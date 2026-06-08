Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5E3CD8C9D
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 16:59:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC960402DD;
	Mon,  8 Jun 2026 18:59:19 +0200 (CEST)
Received: from fhigh-a4-smtp.messagingengine.com
 (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
 by mails.dpdk.org (Postfix) with ESMTP id 1A4134029D
 for <dev@dpdk.org>; Mon,  8 Jun 2026 18:59:19 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 7C6EF14000FC;
 Mon,  8 Jun 2026 12:59:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Mon, 08 Jun 2026 12:59:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1780937958;
 x=1781024358; bh=xUODMatyvChXTKH/AKHsC86sj4CARMIs50OuldAVnfg=; b=
 lj4DsyHYo/3fhwaNog7XwhChEsi1kf0Ys9EaxPC+5ruwpwg3JIu6jkEIj30Ri/9I
 B28/sCaBKyLkEZOcd0ablPeQ75yoh6syBRfqYQWWBWYdBtVWQjF1L5xDwjEy6f8C
 yldo6kESCmdBps3rs8jQ0xlgJUKPZ9+6bPtRW5tbvNdvVMUQeqwgAuVAy9IHn21o
 vGDNjEQzxhk6/XofFuozV+5mSKFl1ZgqUHABYCVmggbrMVpSNGX82SJpw33N5PCk
 kOBrG90+X4BfYjtVFaU+yLNj292ABp8l8Wo5+b5NSK9BOB+WSaJijMOgx148UuE2
 GSPxNoT0GWRo8R+ns6tbWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780937958; x=
 1781024358; bh=xUODMatyvChXTKH/AKHsC86sj4CARMIs50OuldAVnfg=; b=M
 QGkDGB4Gv0lT8WRFvWQEtqMyLF2k3sVQ0DMbyVP/KS4oYslEsEx7dryra0dwqFaD
 o4s1nrEFl56FxEy2KiblgIi4XGGfNvg6uMDUPLFvHDirccfZQ8UqTzf4AxIGNCzU
 u48YHODov0HdUJ0GLorl2nNMYkoUGLZN0U7RtzhUOLZrEaMSoT/Mh/g14g7Cnp9S
 3ynsU54Sbi40Ab7WS2K6rkSRdnfv8m4lFiSeiHEPU2Jq9FkoG85vaULSedsucpkh
 u82Dtx1Q5XkZWT0OMDfnhZi1DfJ4oT9UDGrkp9+qMH2Wtbn4IBG9tlaXhuU3qoE/
 RJ0SdDyQL6XtbieObU5/g==
X-ME-Sender: <xms:5fQmajPpmLO7LfWcl2D1cDGPBaivoA_MKNhmxxNhys9bfoHLMGigKg>
 <xme:5fQmap8aW-8FYKjx4u9-iuagsTPnNSX1yC3CwLerwe02ly_8X-Tgn4vCz6Ns2AVuD
 G1DsTOmZ4EWV-GM1DTL5Ir1rklZv4e-uzVkoCKQtfKdit03aZYSeg>
X-ME-Received: <xmr:5fQmakeADLMeUUkAN2WjoDEKXGiOLCLnasPRp6m189mQabp9r98MhfHsLSRcf3yoOo1OeaBeofssE7Fpnl1MQBIg4g>
X-ME-Proxy-Cause: dmFkZTE4842FvxE31XI2pWLLxB9s0GrmAZFX0XTH5cWDudliEYMj3zR4mYXrCGtMdj6sCO
 iuk+fk7VlZgCMziF4Z2N6CDK3/10HLFi/nECXU6iEyXnvgxAykIaOj6gbnNOrGxPrAAt1B
 /noKZjHQyh/uT/sG5V2iwLmt4Xn1FdYAsT7r2OIt13AJLd58w8Y1wOT0xuBt7U7JjtMkJT
 0fhBRdBhQ6JYQ4PvD87QJhrIbVjsgCNOeuYmllrGTFmP7uQTiFn7hX6m2mqPqdBScNE7Vq
 Mjklk6xmesQboANknUkcr7omj+KwLpLWqBciXHonPSQrBm5rI68SwdcWnWZfqI7fiOLZj8
 EzoiVs1aiXkyIvRWyC0d6mcJoZdTU7E8oZ61U4YUfjL0yIx2Mot68G/3MceglMSi2dm9Oe
 biv7ubNN+2BglO5YbFf/eY60GDPhX6/ePQzfTYA6f8vcMdkp9ZxtNeUy++xdLtbZbkq/Jm
 Fd2nSkuXyyM4I/7Bq/D+I3vouY8p9QU/SAqzbttwi3+Zn9hpG9HSZXGFF50lm0Mi/LOYph
 a0dFUbUsBYwf/Oxpqh8PvokwOQ1rPhixoCCWNyOnIveHBZJSRKVcAvOW5ht6ptroTTEZTl
 5YA9SNWCvC/OBG3M2BR1x7tSLbtPWdlQEhI+B4fKuj0h11dMvFKb4/QzeMdg
X-ME-Proxy: <xmx:5fQmaoxIun1PneolHSsJWu7QR4pziJx21OPGJK_8ZFu6ZHEbL6oSLw>
 <xmx:5fQmapKArLXKL06fBaeoAvJzzT2oq9BuzDKsgXNvrLJHGjbMraC_tg>
 <xmx:5fQmaqGfGoYClHrzLLARG_EFqYvXx_qzMVMBfsGPCsI6wDGkPdyOKw>
 <xmx:5fQmal_NrExYiNgufffRMHReBdxyB0_RXYzsDjsF95PalKjZ49aYOQ>
 <xmx:5vQmauv8Brxg3SQQp8RsUqcDcc7s9efHRDg-Gg2IJ77wV-UMr9maznij>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 12:59:16 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Dawid Wesierski <dawid.wesierski@intel.com>
Cc: dev@dpdk.org, david.marchand@redhat.com, vladimir.medvedkin@intel.com,
 bruce.richardson@intel.com, anatoly.burakov@intel.com,
 reshma.pattan@intel.com, stephen@networkplumber.org,
 "Wesierski, Dawid" <dawid.wesierski@intel.com>
Subject: Re: [PATCH 0/7] intel network and pcapng updates
Date: Mon, 08 Jun 2026 18:59:14 +0200
Message-ID: <FRmUxbuvS_qJ2r4iEPYdlw@monjalon.net>
In-Reply-To: <20260608164059.65420-1-dawid.wesierski@intel.com>
References: <20260608164059.65420-1-dawid.wesierski@intel.com>
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

08/06/2026 18:40, Dawid Wesierski:
> From: "Wesierski, Dawid" <dawid.wesierski@intel.com>
> 
> These patches provide various updates for Intel iavf/ice drivers and pcapng.

Please would you mind sending the pcapng changes in a separate series?
Thank you


