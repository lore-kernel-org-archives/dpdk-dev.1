Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A230C7EE30
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 12:11:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B3F5C4026B;
	Thu, 26 Jun 2025 14:11:34 +0200 (CEST)
Received: from fout-a6-smtp.messagingengine.com
 (fout-a6-smtp.messagingengine.com [103.168.172.149])
 by mails.dpdk.org (Postfix) with ESMTP id 4D9C3400D6
 for <dev@dpdk.org>; Thu, 26 Jun 2025 14:11:33 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id AB5C3EC00A1;
 Thu, 26 Jun 2025 08:11:32 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Thu, 26 Jun 2025 08:11:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1750939892;
 x=1751026292; bh=5RuCIPvGSJRJp6/3bp9ghkbW4qg23FDMSxyZjGyFd4A=; b=
 KJXAwqE1qR8ag1NLTaOoS+krt68xvvy8oaP+KMxQiUnnpdcuhADIjTf37ga/RAcB
 ZkXP+Gb2bfj8Zr6f1BOdsc1l7f+e5K3vFhME0aJXsZpNrbu574nKXVSSpVK35zwN
 YNv3F+cn6L59R7HPEA3fE/6lHC0tWsK/ejxzReKw7sDHMrVKcv9BuJJv+58X8D24
 jJh8ZbYImMTSPhP1XwLZAwl1OvH8poBCBUqThHe4Sja6KLG+yBGd1CbH8arZj1E6
 D5958wOvZg7ZBkGWG9gNAaQ0oP0Pf1of+Z3fS9riYQBlAIvwyaKspRl5PdcoajT4
 svNoNi1HWLnReKLQNvFmZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1750939892; x=
 1751026292; bh=5RuCIPvGSJRJp6/3bp9ghkbW4qg23FDMSxyZjGyFd4A=; b=T
 Elm2Xj+9lnjGpe8I2zNqqqVfVtXVxBLIH4Y52elaATij+BmrwvpqGPYLk419Mh55
 su2tKjlyY7AEUj4Wp06gNF6g5zi6fc5rD0uO2yPMdhbleV28y2bxEK68mJYOX8jU
 eJnhPYzo+ktAktEYzj6tmqKL8IvhRb0gP5O3uK13RugT/rVhzzDuB9RJGsNgr33h
 5QGyl1+Nmk70xf41qn9HPvkPDR1nqbCxbxndTJZcRPPtrazqyVUG3teQ2DVHPW8U
 BQRRg8JrTY1y7sIdhtgQm8Sumlti2UbUw+Xup4G2WDezK3o1VUVZ1DGoBK5XFAIb
 zOJCoVTafmLtWjW6SEknw==
X-ME-Sender: <xms:9DhdaD-Rkcmk0bYFeW0v-sIpc4HFl-cwedTznDJMtDgmOBw_MQZUqA>
 <xme:9DhdaPuNg2vrZqj8pLhANaHCsfHv1jeqEjDgS8gYHcZPkA4IbEwZfMQcUWQPrCgLZ
 6W-5PNtYNjfkPziBw>
X-ME-Received: <xmr:9DhdaBBOV333axUzrGXzmf-jwoZ6gLpd7xlD6G4iyY6S68rUmEPbmZXdD-CkkIUBGyhx_SzQHaE-ZbzosOQXwy9Jpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduhecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
 ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
 fhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcuofho
 nhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrth
 htvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeugfef
 keejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepth
 hhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepledpmhhouggv
 pehsmhhtphhouhhtpdhrtghpthhtohepmhhkrghshhgrnhhisehnvhhiughirgdrtghomh
 dprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopegushhoshhnohif
 shhkihesnhhvihguihgrrdgtohhmpdhrtghpthhtoheprhgrshhlrghnugesnhhvihguih
 grrdgtohhmpdhrtghpthhtohepvhhirggthhgvshhlrghvohesnhhvihguihgrrdgtohhm
 pdhrtghpthhtohepsghinhhgiiesnhhvihguihgrrdgtohhmpdhrtghpthhtohepohhrih
 hkrgesnhhvihguihgrrdgtohhmpdhrtghpthhtohepshhurghnmhhinhhgmhesnhhvihgu
 ihgrrdgtohhmpdhrtghpthhtohepmhgrthgrnhesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:9DhdaPcI8ulZd8vvUDCO7RdjCF94K3bYTnKaoOOLo5q_fIJjRu2i1g>
 <xmx:9DhdaIN_E8KE3h1bhf1U4m9K0uX9XHrt2QcG0d8dYDNRBzCsVTNFiQ>
 <xmx:9DhdaBmZh878pXbltT2Uel6Pv5XK-WUQ0FjJaSih6NNdlsUNGgEezw>
 <xmx:9DhdaCs38gb1YzE5YsYXUXFUzHRIxeZn7HN-EvqhdOMrcKdQcc5PRw>
 <xmx:9DhdaGVWtCwIHID3USucfc8Clm9GIw3661g87G0ZeUZlPcDkfbT4Q4-E>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Jun 2025 08:11:31 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Maayan Kashani <mkashani@nvidia.com>
Cc: dev@dpdk.org, dsosnowski@nvidia.com, rasland@nvidia.com,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
Subject: Re: [PATCH v2] net/mlx5: support NUMA node fallback
Date: Thu, 26 Jun 2025 14:11:28 +0200
Message-ID: <4495972.n97fhnxGW3@thomas>
In-Reply-To: <20250625150022.183054-1-mkashani@nvidia.com>
References: <20250619070132.35181-1-mkashani@nvidia.com>
 <20250625150022.183054-1-mkashani@nvidia.com>
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

25/06/2025 17:00, Maayan Kashani:
> Cross NUMA support means that when there is no
> memory on the local NUMA, use other available
> NUMA memory for port initialization and start.
> 
> If mlx5 malloc with specified socket failed,
> malloc function would return an error.
> To support cross NUMA,
> NUMA tolerant wrapper will be used on supported toolchains,
> and it will log the exact place where fallback allocation happened.
> NUMA tolerant flags in mlx5_malloc were added to support cases
> where the toolchain does not support statement expressions.
> 
> Add a NUMA tolerant wrapper to mlx5 malloc calls in
> ipool and devx/memory region initializations
> to support cross NUMA in device probing and port start stage.
> 
> For Tx/Rx initializations, use socket-num given by the user
>  and when SOCKET_ID_ANY is passed, default to device NUMA
> node with fallback to SOCKET_ID_ANY.
> 
> Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Applied, thanks.



