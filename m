Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00014C83F25
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 17:52:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C1174026C;
	Mon, 21 Jul 2025 19:52:20 +0200 (CEST)
Received: from fout-a5-smtp.messagingengine.com
 (fout-a5-smtp.messagingengine.com [103.168.172.148])
 by mails.dpdk.org (Postfix) with ESMTP id 001984021E
 for <dev@dpdk.org>; Mon, 21 Jul 2025 19:52:18 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal
 [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 86FEBEC0041;
 Mon, 21 Jul 2025 13:52:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Mon, 21 Jul 2025 13:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1753120338;
 x=1753206738; bh=JGsSRZlI8m0yJTX9eX2hd37nL/IlKQQGcwal99IGKhc=; b=
 Jk3i/JzjPQdrOT+igB2Zk96zCwwPSRWgIWWObT4Lx95nznY18DdiyesCJOJGG4NG
 +7QN2BdCDoD3DvjN56j8KFLwOVCWuYgizX1Hqvs/3T6+3fh7v6hT6fE14tVF1Ygr
 yAoX7I6W7/I5MXGRuL/ntde2wPPZEJyvT2N7pJDi1B7oeciwjClnbgR8bi5/ZSEh
 jGPBDLJANkPUsDBxg8txpy+8D/I7Dn9htxhvu3A/yIEfcoCwRIAF/N7Uc0y2O31B
 WftlfC2s35gfRysgmwHCp0NcI8fmqh4YJDyva6zEOABID6/jEkkP62SwMM75+krd
 sxIpQK6OKpH3rJ+JUzhOuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753120338; x=
 1753206738; bh=JGsSRZlI8m0yJTX9eX2hd37nL/IlKQQGcwal99IGKhc=; b=n
 AwUG31HD2rc7E66LQLq7ToM4hWX05eLT6jHRYURHi5U+aag7TzbvPl3WSniS6q8M
 pNPPVE+CrCFewotN4EoPLsORhbesXZMIz8QMa+rqQ8Ow/25YyCHpkpsQEbi6RTwg
 P5xI+OQNTrjFF7lavstuQqUKXbyze1owDYriGfNM/fYVAwyWh9BikpWX0Zj/8Udf
 IojTDLQxmnXYW8Co4+FoSVlUhyTY5yDBqq44ccoZDgvGGUKJfqLPfmGlPYStwUQq
 P9nNd2aC1OLqoaaul60s3KvR1KP5fkVZnwa7jhbcRfasic9vXtrWL/SdzzbBHhcp
 FjNxSkSdcVnHeSdEv4Zhg==
X-ME-Sender: <xms:UX5-aHrN0VQYxjisclabkj2uytyBFT-zsoNoP8M7_4DZyCkzpyVRKg>
 <xme:UX5-aJR0QkgEFOAWnOBONDJsQN92uNXr6JO0dUT298IO6PQyUIKPv29xV2SX0BQ4c
 7f6Ge9wvybkCxPjkA>
X-ME-Received: <xmr:UX5-aB2W4dcZusvn6DpjN6GsjIrGk_aY42pnB4JzhRfEbk5lXvRy5waGfplPfERaTWSR_Ydtm4TousQnmH3QFkR58Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejvdejvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepkedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepvhgrthhtuhhnuhhruhesmhgrrhhvvghllh
 drtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehfvghn
 ghgthhgvnhhgfigvnheshhhurgifvghirdgtohhmpdhrtghpthhtohepphgshhgrghgrvh
 grthhulhgrsehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtohepkhgvvhhinhdrlhgrrght
 iiesihhnthgvlhdrtghomhdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonh
 esihhnthgvlhdrtghomhdprhgtphhtthhopehmsgesshhmrghrthhshhgrrhgvshihshht
 vghmshdrtghomhdprhgtphhtthhopehjvghrihhnjhesmhgrrhhvvghllhdrtghomh
X-ME-Proxy: <xmx:Un5-aFC2M7TrJq5vhBqa6XXyv5lyDtqFmtkdYV-tyAOTTsezJPFTig>
 <xmx:Un5-aNideRbr5KevIN60XKLgMZcGZAH9zJFUuwM48b93sxr0jIGKbg>
 <xmx:Un5-aHPT9tAMKHJBfY3v4-2dp60bcOpONSeAEvMIRUXoTY5AUcJMgg>
 <xmx:Un5-aN9XzUMb72B_rIshnZrDuiS3EXTNMoyjrYoVsOY1v2n2vKW7aw>
 <xmx:Un5-aFoB7vebaoydZFzY3zEECALyELAIMx4AOe9dki1tVmR3RvRH5mQs>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Jul 2025 13:52:16 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Vamsi Attunuru <vattunuru@marvell.com>
Cc: dev@dpdk.org, fengchengwen@huawei.com, pbhagavatula@marvell.com,
 kevin.laatz@intel.com, bruce.richardson@intel.com, mb@smartsharesystems.com,
 jerinj@marvell.com
Subject: Re: [PATCH v0 1/1] doc: announce inter-device DMA capability support
 in dmadev
Date: Mon, 21 Jul 2025 19:52:15 +0200
Message-ID: <2992912.SvYEEZNnvj@thomas>
In-Reply-To: <20250710085101.1678775-1-vattunuru@marvell.com>
References: <20250710085101.1678775-1-vattunuru@marvell.com>
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

10/07/2025 10:51, Vamsi Krishna:
> From: Vamsi Attunuru <vattunuru@marvell.com>
> 
> Modern DMA hardware supports data transfer between multiple
> DMA devices, enabling data communication across isolated domains or
> containers. To facilitate this, the ``dmadev`` library requires changes
> to allow devices to register with or unregisters from DMA groups for
> inter-device communication. This feature is planned for inclusion
> in DPDK 25.11.
> 
> Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
> ---
> +* dmadev: a new capability flag ``RTE_DMA_CAPA_INTER_DEV`` will be added
> +  to advertise DMA device's inter-device DMA copy capability. To enable
> +  this functionality, a few dmadev APIs will be added to configure the DMA
> +  access groups, facilitating coordinated data communication between devices.
> +  A new ``dev_idx`` field will be added to the ``struct rte_dma_vchan_conf``
> +  structure to configure a vchan for data transfers between any two DMA devices.

There are not enough acks (and all are from the same company).
Per our policy, it will miss the release 25.07.

You can probably do this change anyway,
and keep ABI compatibility by versioning the function.


