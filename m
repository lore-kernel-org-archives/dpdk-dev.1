Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648C7CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 13:17:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 448A4402F0;
	Wed,  5 Nov 2025 14:17:40 +0100 (CET)
Received: from fout-a2-smtp.messagingengine.com
 (fout-a2-smtp.messagingengine.com [103.168.172.145])
 by mails.dpdk.org (Postfix) with ESMTP id AC857402F0
 for <dev@dpdk.org>; Wed,  5 Nov 2025 14:17:38 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id 16AE4EC0271;
 Wed,  5 Nov 2025 08:17:38 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Wed, 05 Nov 2025 08:17:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762348658;
 x=1762435058; bh=gqV/SFSygNiIL1KGmmkDSDjoUqvSbbNsddlBz4zLTj0=; b=
 Hzw7kBfLwBTvw4oj6qo0F0gqCqXiYq/62EG0dAzDA6hKwhjBv/oPePreD2i/8FMU
 xavqCCEeNI9qTebpGKkCWd8xz9sTOsP22qoOecoyUNpDKIvSEaEQK+IZ7uMntral
 Fqa4fC/VFZCJIUcn0a8AR1ZVSPnM/91g0DvL6wRRaosGDQVASeL/0QmuaC+2aiFJ
 aUDVJbQaeyzm8eUQpOOKqBOQW3FVJvuf2gfsB5qwLfj1hJSIcjrv3iJe1CEhwJUH
 N2f9RNiUCUsLh+bm0/9r3c5rFngg9e+l+5Bb59ISzjC+RMQgtMTG1ThhcvyWt/C0
 Hi1TswytKeQTYS+nv1t65w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762348658; x=
 1762435058; bh=gqV/SFSygNiIL1KGmmkDSDjoUqvSbbNsddlBz4zLTj0=; b=1
 s93Z/aW1N0ZxidfhRxCyUWifedQp2v0+5/3wQLsYCmypMoIjsQ/Ki8zdDW/r22iu
 81C5PdnOzCUvRiCqM+X30GwAalhnZGQmuIdRy/49hJf8lnLGHWeNyA3rJvgoVqg7
 W8i7fZb4pZ863zmk17EoWEmM6399gx2OmVARbL/KAA2AvDxjibhjlhk6Yby5robg
 mh8WzvWT2OgGZLVt/2vDzjzlGkC+wmeBLy8pjBiIiVR8gTxY4LpnaMJ4esPnjcca
 ekQLmTGEqTe2as4T3BWwARfUUn8/m9lzWipKsE51+jAX3rCxJKmOD72GK95AAslz
 WYIf0g3XbuBIHEVSG0efg==
X-ME-Sender: <xms:cU4Laawfpjn0itBdwQCHY9vQRHuHKKhMTwOwg9DU3TQNThlg2kpoXg>
 <xme:cU4LaSnxaujaSczYAD0zyWtWZuBGeVtTsJ3eqsfc6XKiY-OTIKmP4do21BHuKsYNk
 K1EzPo17G6LoKpLfddRwxJs_oFxt4x4pRUGnbw2nDHH5El5mER21w>
X-ME-Received: <xmr:cU4LafGN_vjNYeeVhoLZy8hFR8Q699TYRLLEYncoGpofL4Fbg-IiDq9ijj9DK8dsc0syF6brPGOEH0W33a4KJ-IswA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeegtddtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehfvghnghgthhgvnhhgfigvnheshhhurg
 ifvghirdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:cU4LaSWVqGjCpPESArQJ8rvnbDXr_ogiD6Z9LY2Ip5_vel5ZNRDjMw>
 <xmx:cU4Laey0K852JHYmiIbyfpkaodzWTtCMz53MU_ut5bud6UGQkhXzWg>
 <xmx:cU4LaYNZkqYtmrA8mqS4goEeN0w9s5gOL8P3bUrbUQPHiMeg2-q8cg>
 <xmx:cU4LaX5MRnGbpXE6NLERwy2r7_b-ILwewxSklRfRfZAiCIAKGHwiGw>
 <xmx:ck4Lach21vBoTQXSXgijFTSfINkf2eVR80L-dGAeojMBV7j8a7T0oVBl>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 08:17:36 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] dma/hisi_pciep: rename hisilicon driver
Date: Wed, 05 Nov 2025 14:17:35 +0100
Message-ID: <34429507.6xKfjbll68@thomas>
In-Reply-To: <20251016023747.18871-1-fengchengwen@huawei.com>
References: <20251016023747.18871-1-fengchengwen@huawei.com>
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

16/10/2025 04:37, Chengwen Feng:
> The original hisilicon DMA driver correspond to the internal DMA unit of
> Kunpeng SoC PCIe subsystem. This commit renames it to hisi_pciep (PCIe
> internal endpoint) to reflect hardware IP.
> 
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>

Applied, thanks.



