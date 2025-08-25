Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588BCCA0EFA
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 14:54:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 83C57402D3;
	Mon, 25 Aug 2025 16:54:31 +0200 (CEST)
Received: from fout-b3-smtp.messagingengine.com
 (fout-b3-smtp.messagingengine.com [202.12.124.146])
 by mails.dpdk.org (Postfix) with ESMTP id 9161040156
 for <dev@dpdk.org>; Mon, 25 Aug 2025 16:54:29 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfout.stl.internal (Postfix) with ESMTP id 62C501D00087;
 Mon, 25 Aug 2025 10:54:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Mon, 25 Aug 2025 10:54:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1756133668;
 x=1756220068; bh=Hv2VbckHiM+UK41cZLB4OU5EkKBZYY4gWkvbEBrE3cI=; b=
 qihMdmEZxhBFs3qTOsEhNtQpMJlY98s9hRMagWYkszUmqY/7hC/Csy21qqFcRnG5
 oubrZC9Puyo4IXWz3f6mpWJ6WG1YH3w5EnyQrKUuMV77PdC2H/e9UBo2zFw6PyX1
 JN8rBiKK1xHvtWMAbexZeWmH+lhLnavn+aw1JNj85XXKgULZWm+PLsTbSfexFPyl
 lO8iDZX78qmDmhE1npORcoFwv/5Y1B70T5ws8cyq+6NIkur0//NWda/m9L4eRMwu
 Gym4LhL0RSN6GcTtGcZh+FxzYadKsY4GUmKmlKtRC25GHnYpBaX414LLrDHtF5nJ
 0YWZMak/VdHT5tp4/PWzFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1756133668; x=
 1756220068; bh=Hv2VbckHiM+UK41cZLB4OU5EkKBZYY4gWkvbEBrE3cI=; b=P
 XRvaMMssQEiwJs5vz8hYfVvtJsKL/TUC64YdTupnyPgK1oNcpnvEpuAmDXT6nOSU
 R4KWupQLpfSyhAHCRsP5F3pgtyhYq3ZFJLVDDQvhrvKJLt8ibM7pbruuZ17lUFyc
 oHiv0Zz2yGtaCfAtfoBM3avc7beI94W60e+59oWrx/5Lq+FvWKAvK0mMRRyTi9jc
 mgZIe1svSkgAx/mNxSM12Z2VVT8QPcE39kxrh2ye3MGQmWYkwyoVcj0fFaPM1/Io
 1rb0wuM6x4cD3AQlHVfWrEqOHV57J65yKo9Qv4VWZJXFCwJRTkKisge/KXU8AMRx
 zB22poM9q6udpqcA0PbHw==
X-ME-Sender: <xms:JHmsaFPUnwT8ufvv_g06DRqqAcnTqJy3ri66x2DfJINhsiTYzW-ZwA>
 <xme:JHmsaOtJF8qxFzkR6UeW5nj-XbTxXzM4aQmUJXono0d2SlsqatXYrzl3CXcaiUaLN
 HNK5S8B2vY3BqbAnA>
X-ME-Received: <xmr:JHmsaGB7qxkyhWhzxrzn1aKAqfqF0uxH8eABQGfdir467wmQLs_b_rip1FnbmSlBjBldf90PImgMHSrsEsgSTZTbMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedvieekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeelpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehgrghvihhnlhesnhhvihguihgrrdgtoh
 hmpdhrtghpthhtohepmhgrthgrnhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepvhhi
 rggthhgvshhlrghvohesnhhvihguihgrrdgtohhmpdhrtghpthhtohepohhrihhkrgesnh
 hvihguihgrrdgtohhmpdhrtghpthhtohepughsohhsnhhofihskhhisehnvhhiughirgdr
 tghomhdprhgtphhtthhopegsihhnghiisehnvhhiughirgdrtghomhdprhgtphhtthhope
 hsuhgrnhhmihhnghhmsehnvhhiughirgdrtghomhdprhgtphhtthhopeguvghvseguphgu
 khdrohhrghdprhgtphhtthhopehrrghslhgrnhgusehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:JHmsaNaceYJpck7CG-A-PbU3qXxaZUvlFeLe3xYSZXDNQzq6nNqSKQ>
 <xmx:JHmsaJXAhAfB7W6oGwEhUai1UiMTnWQ6LvrDT6Hekh7FAoJM1jycAA>
 <xmx:JHmsaEMNaLlL4CcwbBdxRlshUVA3LjD-P_2bVXvmPuEBCrpfjHww7A>
 <xmx:JHmsaLaNndK2MJDXw-SOWb6WXhGpc3kozXbAOgyfSV3JIDYFzS_MnQ>
 <xmx:JHmsaE1FrEagn4resVEBOcrK94_J6op3bXtSNxeEoIUTNlBuwjLdWB42>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Aug 2025 10:54:26 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Gavin Li <gavinl@nvidia.com>
Cc: matan@nvidia.com, viacheslavo@nvidia.com, orika@nvidia.com,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, dev@dpdk.org, rasland@nvidia.com
Subject: Re: [PATCH V3 1/2] net/mlx5: update how MAC address bit-fields are
 used
Date: Mon, 25 Aug 2025 16:54:25 +0200
Message-ID: <2010919.fIoEIV5pvu@thomas>
In-Reply-To: <20250825141322.974335-2-gavinl@nvidia.com>
References: <20250825141322.974335-1-gavinl@nvidia.com>
 <20250825141322.974335-2-gavinl@nvidia.com>
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

25/08/2025 16:13, Gavin Li:
> Previously, mac_own was a bit-field indicating the MAC addresses owned by
> the PMD, specifically marking those added to VFs by the PMD and allowing
> them to be flushed during exit.
> 
> With this commit, the bit-field now applies to all MAC addresses added by
> the PMD, including those for PF, VF, and SFs. The process for flushing MAC
> addresses added to VFs by the PMD remains unchanged.

To be clear, there is no behaviour change in this patch?

You should mention the goal of this patch (preparation of a fix for multicast).



