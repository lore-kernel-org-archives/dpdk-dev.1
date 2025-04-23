Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9322FC369C2
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Apr 2025 00:07:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7007A40156;
	Wed, 23 Apr 2025 02:07:05 +0200 (CEST)
Received: from fout-b3-smtp.messagingengine.com
 (fout-b3-smtp.messagingengine.com [202.12.124.146])
 by mails.dpdk.org (Postfix) with ESMTP id A9E5140151
 for <dev@dpdk.org>; Wed, 23 Apr 2025 02:07:04 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal
 [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id EC03A11401EA;
 Tue, 22 Apr 2025 20:07:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Tue, 22 Apr 2025 20:07:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1745366823;
 x=1745453223; bh=8Plvh40hoDSHQSSbHqX1PJQHZJZvy5w5Sev2LDWEMjc=; b=
 AI6468jvJQSmKX5ahSARMK78V5mxNeNANkker2YYF7jKC0anb5RFf8rQ3sA015Zs
 /TZyhhe191t4FFOSdsRYoVV9iG7ca02AdlM6LnwjzmORjsZp7YnqTyt79gxE0i+I
 zE5RlkgAKjLHvjoHvNhfM43yoUnir9pTL313nkvHvEs/D5Q6oRZwqiCsoTZzHNLT
 Pg1BsT4lppbW83mcmrdYKqEVsW6xxCQegDMDLUTztkDG6sU1HCrEWWo7WJ6cOvQr
 C2B4IzxI1chG7WZ5IwRg1FyU3usM03dc75SeTiU3OgMTPcEHR3qz7oo4Ogb/vLUU
 frYcsO3Xk1zklVSP2umGAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745366823; x=
 1745453223; bh=8Plvh40hoDSHQSSbHqX1PJQHZJZvy5w5Sev2LDWEMjc=; b=W
 HInL0cmLirzxjCAbQAowqPBUprkHNZ6vCNW+elUhWyb8sUt86q09Ec5o1oosACoR
 nVFp3/hN4LIUPsvJiT4jmHC4OjgeJk7gER2mLfJiycSTAKnAMcsN06thQSJEFZWi
 M/siabLgUJZ+iexMTqmOqMMDiJA1BuDPbQx8fdGq8TSrdUAMPB2KQeZkO0c9j8m2
 smcNnvshipHLKDnfZzqfM2Ihu9XiIMyVWhaFI9KK2ttD+Y5fHNEiOTUVvbWuYECT
 cDe4eYuNZrd5FoWC+GvBVvD2rGkHptOs95BQaRZmsjIOufzHGUXxVstIWID+Q1Lw
 bq2Qcdw9djJPyhoP1+KwA==
X-ME-Sender: <xms:Jy8IaMYZkAG15u5pC-aNNvntJF9MC2ug6rcwDSX-0AJkV1FceGK2HQ>
 <xme:Jy8IaHb5AOAjUdNR2pLPCvcCg0ipMJ6MQYwgeE5ZimxqFpTKh0izBI3diAEWtZIQW
 3fDqYNdIF2iEUHDMw>
X-ME-Received: <xmr:Jy8IaG-TsoSKlCHwUE0s2fglJSZO8CUmbr9XPMMjObXBeaVOQSy9SC4Ci2U0uQX-TRrOFNURNhZiWz2AEhyfd4DaWh0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeehuddvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgfdt
 geekueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvght
 pdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkih
 hrrghnkhhumhgrrhhksehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtoheprghmrghnrdgu
 vggvphdrshhinhhghhesihhnthgvlhdrtghomhdprhgtphhtthhopehfvghrrhhuhhdrhi
 highhithesrghmugdrtghomhdprhgtphhtthhopegrnhgurhgvfidrrhihsggthhgvnhhk
 ohesohhkthgvthhlrggsshdrrhhupdhrtghpthhtohepuggvvhesughpughkrdhorhhgpd
 hrtghpthhtohepughsohhsnhhofihskhhisehnvhhiughirgdrtghomhdprhgtphhtthho
 pehorhhikhgrsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:Jy8IaGrstWEDwypAndtBET7TBUvGAHlfWLH8YvHbWAnNap5jn4_oHQ>
 <xmx:Jy8IaHqp2CY3kfCFLXxUbgv1MS9ojcDIZATASbxDCMjPDtt15KpKyA>
 <xmx:Jy8IaERh4rsfGG2IcQ6EN9VjHBKWDCRZ5tnBBtyQRhzaiyUIyyVTMQ>
 <xmx:Jy8IaHoTFHgImow7bubPqE3cvJQlRnogKs_XG6R8ioc3swNDOPVh4Q>
 <xmx:Jy8IaHlxaj6ygYgn044W9ySosjKrgEccdWoCQ5lUA4acUbaAcH0uivnZ>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 20:07:01 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Kiran Kumar K <kirankumark@marvell.com>
Cc: Aman Singh <aman.deep.singh@intel.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, dev@dpdk.org,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Ori Kam <orika@nvidia.com>
Subject: Re: [PATCH] ethdev: support RSS based on RoCEv2 header
Date: Wed, 23 Apr 2025 02:06:58 +0200
Message-ID: <6153993.lOV4Wx5bFT@thomas>
In-Reply-To: <20250422051459.661395-1-kirankumark@marvell.com>
References: <20250422051459.661395-1-kirankumark@marvell.com>
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

22/04/2025 07:14, kirankumark@marvell.com:
> From: Kiran Kumar K <kirankumark@marvell.com>
> 
> On supporting hardware, RoCEv2 header can be used to
> perform RSS in the ingress path.

Do you mean IB BTH?
It would be good to adopt a unique name between RSS and flow matching:
	RTE_FLOW_ITEM_TYPE_IB_BTH



