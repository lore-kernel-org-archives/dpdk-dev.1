Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C122EC982CC
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 15:42:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0786D42F03;
	Wed, 16 Sep 2026 17:42:18 +0200 (CEST)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mails.dpdk.org (Postfix) with ESMTP id F20994028B
 for <dev@dpdk.org>; Wed, 16 Sep 2026 17:42:16 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 79C041400106;
 Wed, 16 Sep 2026 11:42:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Wed, 16 Sep 2026 11:42:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1789573336;
 x=1789659736; bh=us8aLytAjkFhadsDBKQObozPKgE11iBCy61pF2ipmTM=; b=
 BledDl9WTxYb2PVZP0bSDOJuiHy80oPJTnIpX9U2KMACysd5wugE601tCy5hGGaI
 Wkr2uWYkiaWSVMoljRAvMdH9IPDlg4J+1eLpyLWroTSvVyPq+y0R56vpjA2I+1A/
 8WUjG5ywGindtLwyvbf779USdGsIPdrUcDHElsAaeMnjxHVkDchmMpK1r1T/lNxb
 L2cIZ1x+4txo4aJH0iXz01zrD3wfD7p1xCaAdD8zDiIkmpW4YGMhf+YD5io5vmr4
 wfgBzPlbK0bGgCCqLMskgbw+xKbEmVHp61IbSPJNzdUVu/lkTz7Pb+spbJhPrrLy
 MLCoJxGW6ddnk6PE759jQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789573336; x=
 1789659736; bh=us8aLytAjkFhadsDBKQObozPKgE11iBCy61pF2ipmTM=; b=M
 V1cmdfulIv9tFiCmYa1DhpfsYf4jGjHYfEX+7A9Kv/Jbh3IwRJFQ3FelaoZii6Qr
 WVExpSbgUQwlZyYzppW0Z5ca1Ss10tX/747oh+pv+r2jxrLTl4o+gC5d1JiO7Mj8
 bLqr089znfJoDFvMAKd0QNS/yoEDF+bGRIz7gaifduOPqVFD9o/f0opmO59DCU6p
 hLNBcn9kYMJCO8HsGM61cmrTn4Uqle3771fJYQCkr9/FtsLIJjip5UfKSohq4T3A
 Er0jCkm0qOpOja53jxjptHjuv8pveYXlXp815jWzPbON3ycLzz67wGzvJyQJ5QNX
 rwoDJBmhPaHhlo0lNHtQA==
X-ME-Sender: <xms:2LiqarZwQpX5m0WPUobjNUGy4J_5R2MdxEYb_VL96sCjh8QzMMia8Q>
 <xme:2LiqamtuALzS4sKr2LEM6mdGt-HqPXilo9nKb2t5US7_Q-iezyWdZdl7PGW2Swt_z
 eOZMcSSj4ia_VTbdUAWNsDiMW5T1xPZW9RnkxSd_zPQ1dqzyQawx0A>
X-ME-Received: <xmr:2LiqagsvBhNd7rdqTiSa22b0V3_jBk5ejRJJGRtsD89zBi_dFLqA9kY8FDDTB7_towjppnl4hQLWO9-o-sqMkmU>
X-ME-Proxy-Cause: dmFkZTFFtG8ndmKwT+ikgqIrlLMijC3f+nAs/TlunyfczAms3rnxmD44DFGzi7QfG4e5cm
 M9xkToaAeg/xNEsw15K5/gsIhYhQ4zYN+luhRUT+T5P2mtfvmBSZmPfxU1mT8UBLfo2w/+
 zka24QhdDSd6trmzh0P6og1KXqAfhHOxMVOkOw6gPhGSsYgIEpVURWqE3tf3aLuVspxb8T
 /ZcU+BX1hBOV6UQH+6hDbgnJSrE1Nw6UqFMBNJqzPIvGi08ahqCH5SAWdKPsCks45W+xGS
 KYXB7RFgJWIfh4n1XtvyiWk0DHlRInwsPE7ZvNIbiIHJyK5lZJ9c7kJiAN/xzF8NttvOdV
 DjeSKAPJX8EEJOCEfbFiqC4ecAZLEOyBeAyDtacS4ZYPIGPtfEFdafZkX0oWEjpaj8jBI1
 jBKniZvZGwiqT7ZljayJTPEQP2qQ1NZcYpG/gtxlYs/rsBk4+yTMPBxIqIareJlwrwD53I
 +OzgiegVdYR9E00MdRWkugbfrMEUmGCSf6wvmBSu43CgH1d7CDDBLAiZcT5SPxQ6MvXaeE
 E3bWPbtZyFtuIJ0Sk684DMQwaYLmo1K5RZyifyhe3H8Bo6LIM4FZssGvH849vCAICGbBvR
 2skN6gjZU+kw7kP1CebaDRLgybZAPWXC521Rbwu8Qd14ImBzEe2h1xfgyfcQ
X-ME-Proxy: <xmx:2LiqajeJnWhDpdk6DKEvQk4uHiAYCyqgPg3XK_C6ODDzUennaSY8MQ>
 <xmx:2LiqapbMV3kQUVhZMvFbCDpMIYiSfhwNGXyHk1fccJjp948R1eyQHQ>
 <xmx:2LiqauUoU2KfUYy13szRZhJkh2rvg97DSXzQ1SbdUpxaGvuS7lo2LQ>
 <xmx:2LiqajilCMd_v_LXZVgvwemG3PDlYsr-yWeUrokj750jsNrjnSIF6g>
 <xmx:2LiqaqaQlOKeY8DByD5-X1BzR0TvQ3ZTEQHCiAZc4VbKAKjH8hcKFL1r>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Sep 2026 11:42:15 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH] MAINTAINERS: remove one gve maintainer
Date: Wed, 16 Sep 2026 17:42:14 +0200
Message-ID: <Mw4Nom6kSb2D7Qr1T78kXg@monjalon.net>
In-Reply-To: <20260806162558.673588-1-stephen@networkplumber.org>
References: <20260806162558.673588-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

06/08/2026 18:25, Stephen Hemminger:
> Mail to jeroendb@google.com bounces now.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Applied



