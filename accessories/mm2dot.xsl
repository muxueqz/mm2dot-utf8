<?xml version="1.0" encoding="utf-8"?>

<!-- Author: Jochen (Joschi) -->

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  version="1.0">

<xsl:output method="text" 
  encoding="utf-8"/>

  <xsl:template match="/">
    <xsl:text>digraph G{
  rankdir=LR
  center=true
</xsl:text>
      <xsl:apply-templates select="//node"/>

      <xsl:apply-templates select="//arrowlink"/>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="node">
    <xsl:value-of select="generate-id()"/><xsl:text> [label=&quot;</xsl:text><xsl:value-of select="@TEXT"/><xsl:text>&quot;, fontcolor=</xsl:text>
    <xsl:call-template name="getcolor">
      <xsl:with-param name="col" select="@COLOR"/>
    </xsl:call-template>
<xsl:text>];
</xsl:text>
    <xsl:for-each select="node">
      <xsl:value-of select="generate-id(..)"/><xsl:text> -&gt; </xsl:text><xsl:value-of select="generate-id()"/><xsl:text> [style=</xsl:text>
<xsl:choose>
      <!-- hm does I have a edge attribute or any of my parents?! -->
      <xsl:when test="ancestor-or-self::node[edge/@WIDTH='thin']">
        <xsl:text>dashed</xsl:text>
      </xsl:when>
      <xsl:when test="(ancestor-or-self::node[edge/@WIDTH='thik']) or (ancestor-or-self::node[number(edge/@WIDTH) &gt; 2])">
        <xsl:text>bold</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>solid</xsl:text>
      </xsl:otherwise>
</xsl:choose>
<xsl:if test="BOLD='true'">
  <xsl:text>,fontsize=16</xsl:text>
</xsl:if>
<xsl:text>,color=</xsl:text>
    <xsl:call-template name="getcolor">
      <xsl:with-param name="col" select="@COLOR"/>
    </xsl:call-template>
<xsl:text>];
</xsl:text>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="arrowlink">
      <xsl:variable name="dest" select="@DESTINATION"/>
    
      <xsl:value-of select="generate-id(..)"/><xsl:text> -&gt; </xsl:text><xsl:value-of select="generate-id(//node[@ID=$dest])"/><xsl:text> [style=dotted, color=</xsl:text>
    <xsl:call-template name="getcolor">
      <xsl:with-param name="col" select="edge/@COLOR"/>
    </xsl:call-template>
<xsl:text> ];
</xsl:text>
  </xsl:template>


  <xsl:template name="getcolor">
    <xsl:param name="col">#ffffff</xsl:param>


    <xsl:choose>
      <xsl:when test="normalize-space($col)='' or string-length(normalize-space($col))=0 or $col='NaN'">
        <xsl:text>black</xsl:text>
      </xsl:when>
      <xsl:when test="substring($col,1,1)='#'">
        <xsl:variable name="red" select="substring(translate($col,'#',''),1,2)"/>
        <xsl:variable name="green" select="substring(translate($col,'#',''),3,2)"/>
        <xsl:variable name="blue" select="substring(translate($col,'#',''),5,2)"/>
        <xsl:choose>
          <xsl:when test="$red='ff' and $green='ff' and $blue='ff'">
            <xsl:text>white</xsl:text>
          </xsl:when>
          <xsl:when test="$red='00' and $green='00' and $blue='00'">
            <xsl:text>black</xsl:text>
          </xsl:when>
          <xsl:when test="$red='ff' and $green='00' and $blue='00'">
            <xsl:text>red</xsl:text>
          </xsl:when>
          <xsl:when test="$red='00' and $green='ff' and $blue='00'">
            <xsl:text>green</xsl:text>
          </xsl:when>
          <xsl:when test="$red='00' and $green='00' and $blue='ff'">
            <xsl:text>blue</xsl:text>
          </xsl:when>

          <xsl:when test="$red &gt; $green and $red &gt;$blue">
            <xsl:text>red</xsl:text>
          </xsl:when>
          <xsl:when test="$green &gt; $red and $green &gt; $blue">
            <xsl:text>green</xsl:text>
          </xsl:when>
          <xsl:when test="$blue &gt; $red and $blue &gt; $green">
            <xsl:text>blue</xsl:text>
          </xsl:when>
          <xsl:when test="$red = $green and $green = $blue">
            <xsl:text>gray</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>black</xsl:text>
          </xsl:otherwise>
        </xsl:choose>

      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$col"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


</xsl:stylesheet>
