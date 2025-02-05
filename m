Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6167AC02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 11:44:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E06040261;
	Wed,  5 Feb 2025 12:44:18 +0100 (CET)
Received: from fout-a2-smtp.messagingengine.com
 (fout-a2-smtp.messagingengine.com [103.168.172.145])
 by mails.dpdk.org (Postfix) with ESMTP id 0BF5F4025F
 for <dev@dpdk.org>; Wed,  5 Feb 2025 12:44:16 +0100 (CET)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfout.phl.internal (Postfix) with ESMTP id 2419E13801E5;
 Wed,  5 Feb 2025 06:44:16 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Wed, 05 Feb 2025 06:44:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1738755856;
 x=1738842256; bh=hXvGVo196/tqA7zCqrIZTUBeyRjB4UsRtt0MMGXxNbc=; b=
 ceLlq1cIjY3kb/rBsS4BjS6h6zsZO1rwNQ7O3Amjo8GihsJvrgj7bYpMfLnBDPIa
 HVFomFlHRDFibLtlPcoUv7yKAczM1vp7WdwNv611sB4bTFxM8iVByySJjXD95041
 Uqs+m8NSguT6XNr7V0C4dESmhzIZE7LIHAfZ4cA2m+3AZx9x32dnJ36pAIPQhhZC
 /EsyBpRiThBlPFDn5K8GnS1J8f1/AWs2AnVEnFML1nNHLE69fILAMyVo/bxPQBi2
 +uBuLgTPgGsZ9VKtrpgA7Wl/n6NNdiZaKcUnfJwpmqPk6EOBfpdbdGvvC/bgftLZ
 sFlDnVVeOf/wDj4BCSpDyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738755856; x=
 1738842256; bh=hXvGVo196/tqA7zCqrIZTUBeyRjB4UsRtt0MMGXxNbc=; b=p
 egBLoXpXvquxV00HjWEzA5h7+2TQpufjZ6jq+JCpcEzLMZkg/wx0fAOJ55gjVkfd
 /EfnVtJtBYJiN9LZLPVFpBeL38+wLGitBwi8mjdSHSdQ8WBVaIlPLxlNrMoAIg3F
 nv/iTduMMD6VjcpDCnx4LVeupBpZeVsIJbSLcXuZNx7WmMyRlRfLeL1R+eB2xz4o
 Ihzsfz91/s5IlTJ9t3997FRoc18H3KZkVUcvSLMfhTzzpcK0izCFpFj9tsmYlUtG
 uC3anRMVq8pXFobujByOJQClSOfjz8YTZWG1Y88gC76QmyB1m+2fiBe3wqS1i1ch
 IhmVVlIjSxl3OIlKwAJZg==
X-ME-Sender: <xms:Dk-jZ8eOvRLtS2aeCRFtbAss0rDelzHCm7mvF7iWzPfJ2w29K6LWZQ>
 <xme:Dk-jZ-OwZsLz_EcTsR2cEZxLqTq8QSsQYZCo4bozDaf2BeNN9nmCuoINZGvDXyzgh
 G8ccS1I6LBA8XRupA>
X-ME-Received: <xmr:Dk-jZ9iaSes7g8JbatMmF__R3lHekc9zUgpcVzzaOz-xtN6VK1FXv3zcFgTVoft91eEIOo9SvxiYAOc5hQxTe4UjsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeefjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
 fufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgr
 lhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrghtthgvrh
 hnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdvuefgfeekjeen
 ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomh
 grshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedutddpmhhouggvpehs
 mhhtphhouhhtpdhrtghpthhtohepfigrnhhrhieshihunhhsihhlihgtohhnrdgtohhmpd
 hrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepfhgvrhhruhhhrdih
 ihhgihhtsegrmhgurdgtohhmpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkh
 hplhhumhgsvghrrdhorhhgpdhrtghpthhtohepqhhirghnrheshihunhhsihhlihgtohhn
 rdgtohhmpdhrtghpthhtohepnhgrnhgrseihuhhnshhilhhitghonhdrtghomhdprhgtph
 htthhopeiihhgrnhhggiigseihuhhnshhilhhitghonhdrtghomhdprhgtphhtthhopeig
 uhgufieshihunhhsihhlihgtohhnrdgtohhmpdhrtghpthhtohepjhgrtghkhieshihunh
 hsihhlihgtohhnrdgtohhm
X-ME-Proxy: <xmx:Dk-jZx9qeKMOtJ7vEbdOl4Fov4jcC9PLP2grzWERNY75ARYOdIrtRg>
 <xmx:Dk-jZ4vNdLwJTuKxbB4TzVSyhDd0IVRqbKgXmTEWBfnkO4alC_Ds4w>
 <xmx:Dk-jZ4ECcbU97beY-rEJtLDiEPLPhqVvjrc-4UgNF5oi2VCDvuZj2A>
 <xmx:Dk-jZ3OI52hiraNwTYYteKloVDZJrgi9mHBY6vmetantQ7MDP8nLyQ>
 <xmx:EE-jZ5nYpZapNE2saZARedITIWLpYfG2D1az9WkDEgCTyaxcvtviOVGg>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Feb 2025 06:44:13 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Renyong Wan <wanry@yunsilicon.com>
Cc: dev@dpdk.org, ferruh.yigit@amd.com, stephen@networkplumber.org,
 qianr@yunsilicon.com, nana@yunsilicon.com, zhangxx@yunsilicon.com,
 xudw@yunsilicon.com, jacky@yunsilicon.com, weihg@yunsilicon.com
Subject: Re: [PATCH v7 04/15] net/xsc: add xsc dev ops to support VFIO driver
Date: Wed, 05 Feb 2025 12:44:11 +0100
Message-ID: <1873236.BzM5BlMlMQ@thomas>
In-Reply-To: <20250128144655.1956159-5-wanry@yunsilicon.com>
References: <20250128144649.1956159-1-wanry@yunsilicon.com>
 <20250128144655.1956159-5-wanry@yunsilicon.com>
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

28/01/2025 15:46, Renyong Wan:
> XSC PMD is designed to support both VFIO and private kernel drivers.

What's the benefit of private kernel drivers?
Why are they private?



