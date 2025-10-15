Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0962BCCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 10:05:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F21A40654;
	Wed, 15 Oct 2025 12:05:50 +0200 (CEST)
Received: from fhigh-b4-smtp.messagingengine.com
 (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mails.dpdk.org (Postfix) with ESMTP id 4694140276
 for <dev@dpdk.org>; Wed, 15 Oct 2025 12:05:49 +0200 (CEST)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfhigh.stl.internal (Postfix) with ESMTP id AA7267A01E4;
 Wed, 15 Oct 2025 06:05:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Wed, 15 Oct 2025 06:05:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760522748;
 x=1760609148; bh=aR38FyInqvTDExinT2EX1lq5n+a7UAu1WKtjcIqo+mY=; b=
 cZDNnLiVyBCPIjY3AgnjCHAfnE39nq51VBM7od9YIqGs5qOZFtbCyvMLBVE8h3jJ
 vPJ8+eQSWrZA6swEsgc7CNQJgcp+BiOrK6P7D354j9ENJAd3FhIdYvzAuXSmmXIt
 AGRfRivt72q3EgXCRofCSFjXGPV43llFvpIBOlcgsRczshcuCLnmq+c21EM1U6Jt
 mn4BF76hnSGeCkJHo4bNMBCEEdjmG8waV3ODd2cwVPJ0LoQ8oppDMIRooay09Q8C
 p2hc++wBuGQB+vXIeCayz0chFX2SqDZ6M4lcn0h4Tmq7JUW16V/Pi3bB9/genDxj
 C0Ruoj5K9lz84tCO7f7NQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760522748; x=
 1760609148; bh=aR38FyInqvTDExinT2EX1lq5n+a7UAu1WKtjcIqo+mY=; b=t
 QLsl4MfTonSy+f2KsNymLvB57ckq/m7iuT2J/cvOktR/oxxme6wCuTccwHcw1yB4
 s284gUSIaDR4t5KdNcpAr++Fa0pS23/2e8hDArgw4Rg9at3zSLC4QeHcmx5mt8BM
 qWs4SKODTV/5b/XuUitHHvb4t9MWDFRTyVptGKAVK6QiUnZBugXUnVU764vCcr91
 3d3zXu6oZ9ZwoBZpqBKRndyqir9u6LjC0yyG/BFv7AcMgoKAM2+nBC/4oOhRyw4P
 9XIDiCiyq4yALIArRIRGzmSsx3lCwkaevFCeHr6rjyofeZQiTfI7+oP+mGkTuNel
 i0wkpd2RWXMJuCtgftQ2Q==
X-ME-Sender: <xms:-3HvaL41zLPI2RGY7R9ZM7rvcwO365zZjr8UHCs0NLVnOQrLTawqZQ>
 <xme:-3HvaFOB-_IsOgoXZ-ThaK6iEcdpf5kB8ATA2v0Fh7JZBd0VTgblsoj5JsjM6ywj2
 7GKNkdgds82zWUCdav4uMO8xjdqUPpe-T5q5d_O8AFyyDTAAucq>
X-ME-Received: <xmr:-3HvaBlVX3mORGZXulrGwI6tS49on8RiU4DGDtercUilH1_qPhtIrgNgPw7VH-ABmu0OQYyFQBRfpSOs16-n1i5p2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdefudefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehfvghnghgthhgvnhhgfigvnheshhhurg
 ifvghirdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohep
 lhhiuhihohhnghhlohhngheshhhurgifvghirdgtohhm
X-ME-Proxy: <xmx:-3HvaESp6SabrgUaDvTnqxGfaF_JllwbN6Vqe3WDaI6_TVZ3lH7Lhw>
 <xmx:-3HvaFAyvrbAJkU9OxHzBM-mZXUwwMDlV9ouMLwHFMgm8YxkJ2kblw>
 <xmx:-3HvaLTPuVoLLYqGfCTZkkStH13FbERqkKqSMSjPqlFvKNpNx7wscw>
 <xmx:-3HvaDqjCo7ZVHjQJ-_ep69EF5tGVRGxlLq2n1h1lrI-7Dv-_6tzdw>
 <xmx:_HHvaN5dLQclMaj0aFXmR26n-yUP2pIP5N4f67ncfIsqBAGHdbjXzFiq>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 06:05:47 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: dev@dpdk.org, liuyonglong@huawei.com
Subject: Re: [PATCH v4 4/4] dma/acc: add doc
Date: Wed, 15 Oct 2025 12:05:45 +0200
Message-ID: <4548489.fW5hKsROvD@thomas>
In-Reply-To: <20251013091157.1145-5-fengchengwen@huawei.com>
References: <20250827092729.10719-1-fengchengwen@huawei.com>
 <20251013091157.1145-1-fengchengwen@huawei.com>
 <20251013091157.1145-5-fengchengwen@huawei.com>
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

13/10/2025 11:11, Chengwen Feng:
> +HISILICON Accelerator DMA Driver
> +================================
> +
> +Kunpeng SoC has an internal accelerator unit which includes zip function, and
> +the zip also supports data copy and fill. This driver exposes this capability to
> +DPDK application.

How is it different of drivers/dma/hisilicon/ ?

"
Kunpeng SoC has an internal DMA unit which can be used by application
to accelerate data copies.
"

If it is the same hardware (Kunpeng),
I recommend having a single driver, or a single directory.
Also we already have a driver named "acc" in baseband.


