Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A236CCFA18
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 21:20:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44B0340280;
	Tue, 11 Nov 2025 22:20:00 +0100 (CET)
Received: from fout-b7-smtp.messagingengine.com
 (fout-b7-smtp.messagingengine.com [202.12.124.150])
 by mails.dpdk.org (Postfix) with ESMTP id 66E374026D
 for <dev@dpdk.org>; Tue, 11 Nov 2025 22:19:58 +0100 (CET)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfout.stl.internal (Postfix) with ESMTP id 832691D00153;
 Tue, 11 Nov 2025 16:19:57 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Tue, 11 Nov 2025 16:19:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762895997;
 x=1762982397; bh=WSnq3EDraggRa6CdAM/KsXCvDBZP24NtvNUACCj/MIg=; b=
 fu9G2icEIXMQ6zPxt0rRU3XQjjFVdWmucntsPBNPZCBcKKVZzmeCQtUv+R21GpQ0
 hcBZFRRPAW2qYTKZhpgy2XoZV1eGdc++0ZJCApT7xX5AwOy3hEflGzQiPG8lASbd
 8etx9S8+J6vWH2jHJA+RNjr7H5o8V5bizBhPksNuISqBzUqpxycqvQODVa/+3QhR
 mdkpuEiyB7QCXdNZc39XEaydovQk1N4jjHdNUs6fjyu8GlC0HU0lSmDPuvnsXb6X
 /vroP5SYTMuobEwkWG2M9cygN3P3m34vDnEsh7axxQKI3CAvBRRkrM6uNLo7rPt/
 Be5VsmQAmWhyFFkgDSEhgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762895997; x=
 1762982397; bh=WSnq3EDraggRa6CdAM/KsXCvDBZP24NtvNUACCj/MIg=; b=E
 uxOY8C3uXZt6qjVwLn26mfQ09+OeEunqfZY/mb68iavHvDtPLnSpy5hVbNd1WGPq
 WNIGJYs5itM2uvavDIPnKy1EYmVpnwAXzzS/osHrA94cKNHknfDSG4u6G3+ijVX+
 M766Zk8t8XRE4kR+1lBZD8QfyIowdIFWz171OtmARouRicXnud0/OLxBIkkOEvev
 xgZB+WgrKO2G7SZpxwu40iMYDlb9geY2LecSDDz82lDvqoJprn3bTB4ckgunPcJr
 ipbZzJwa+bFZi3epqUvxbt2XVVTxQxMqxKflHBXs9ZRwjArho4nfx4AzNlY7AVEa
 CoKD93ic5qUXXlO5u5D9w==
X-ME-Sender: <xms:fKgTafDXYQw1sW6tXOPRG5ql-MbbXdR7gM9Qd-K6AHXV9nIXuO4l3w>
 <xme:fKgTaefq5mIVKKLClcukZDFl9sJG74COVr1S7KQ5scvgChJAoG0h15scrciYFoKXx
 r1YP2cXcSiPYJUXDQNNGwE7t7lPkGOzrA5SOgIV9_qgbWIUP1XgSw>
X-ME-Received: <xmr:fKgTaWLWishJIJC_NBopfy7EtIsKTpcZQt8bFWcrpdBrNA69EPasQleL1ohdkcO4Owr9GGjtSgaqbHCL6BvcKaGTng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddvvdehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeeipdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguihhmohhnrdiihhgrohesnhgvsghulh
 grqdhmrghtrhhigidrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgt
 phhtthhopegrlhhvihhnrdifrghnghesnhgvsghulhgrqdhmrghtrhhigidrtghomhdprh
 gtphhtthhopehlvghonhdrhihusehnvggsuhhlrgdqmhgrthhrihigrdgtohhmpdhrtghp
 thhtohepshgrmhdrtghhvghnsehnvggsuhhlrgdqmhgrthhrihigrdgtohhm
X-ME-Proxy: <xmx:fKgTaR2VgrVaKE-CMOmj1wOufWkrPhNVGR4Cia3gphHX8O5gOVTTwg>
 <xmx:fKgTaQjmEIChVGzRfwA-Gv8Z-fFj2aSVI3J-DUkFw8NSge45dqgjhg>
 <xmx:fKgTaSWRKpnFvoLC-2lN1qwCHWRorcLM_Y3MUMYkaj8CF2qaSm1DOw>
 <xmx:fKgTafXZGMBhwrB_LLSSfy-_KUmemeKGmx6jsGsktv95JFzGxbGDFA>
 <xmx:fagTaSnepJyBWPtvc5oewFvJe7aHQEZXMx9enmeM1wSSKmRbgkrkqGJR>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 16:19:55 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org, Alvin Wang <alvin.wang@nebula-matrix.com>,
 Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>,
 Dimon Zhao <dimon.zhao@nebula-matrix.com>
Subject: Re: [PATCH v2 4/4] net/nbl: add IOVA mode check in Coexistence
Date: Tue, 11 Nov 2025 22:19:53 +0100
Message-ID: <3056609.DAjeCnDj1a@thomas>
In-Reply-To: <20251111113144.3567291-5-dimon.zhao@nebula-matrix.com>
References: <20251107073459.3532524-1-dimon.zhao@nebula-matrix.com>
 <20251111113144.3567291-1-dimon.zhao@nebula-matrix.com>
 <20251111113144.3567291-5-dimon.zhao@nebula-matrix.com>
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

11/11/2025 12:31, Dimon Zhao:
> Add IOVA mode check in Coexistence.
> Update MAINTAINERS.

This is completely unrelated.

> Refresh feature list and Coexistence Usage Instructions.
> 
> Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>

>  Nebulamatrix nbl
> +M: Alvin Wang <alvin.wang@nebula-matrix.com>

Maybe he is a new team member, but he cannot be a maintainer
as he did not even send a single patch.
Please keep only people who can act as maintainers in this list.

> --- a/doc/guides/nics/features/nbl.ini
> +++ b/doc/guides/nics/features/nbl.ini
> @@ -12,6 +12,7 @@ Unicast MAC filter   = Y
>  Basic stats          = Y
>  Extended stats       = Y
>  Stats per queue      = Y
> +VLAN offload         = P

How is it related to IOVA?


> --- a/doc/guides/nics/nbl.rst
> +++ b/doc/guides/nics/nbl.rst
> @@ -70,6 +70,13 @@ Anolis community:
>  Alternatively, you can contact us to obtain the `nbl_core` code and installation package.
>  
>  
> +Coexistence Between DPDK And Kernel Driver
> +------------------------------------------
> +When this device is bound to the nbl_core driver and IOMMU is in passthrough mode,
> +it is necessary to force I/O virtual address (IOVA) to be mapped to physical address (PA)
> +with the EAL command line option ``--iova-mode=pa``.

A blank line is missing after the heading.


