Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D646CCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 10:24:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85DA44065F;
	Wed, 15 Oct 2025 12:24:36 +0200 (CEST)
Received: from fhigh-b5-smtp.messagingengine.com
 (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
 by mails.dpdk.org (Postfix) with ESMTP id 8CD9440430
 for <dev@dpdk.org>; Wed, 15 Oct 2025 12:24:34 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id B7D907A01EC;
 Wed, 15 Oct 2025 06:24:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Wed, 15 Oct 2025 06:24:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760523873;
 x=1760610273; bh=bx9h8Xg+rwTWczdehLPt6cQPOQEl8u0byqKvGRAvLcs=; b=
 Z8XXAgSpXAOA/rf8loAFCz3zwcl8F2W6DC070r6MI5DCTOSNGzEFV0DMwLMXjN6Y
 YvbjjkGCtSLnR0t1UtusAXz5ar+yPGSiqrXMXj0j40DBmMegrI39onG4MzaXRJRW
 8AmH/PoPxXfKNRd+QDvRzKWJBGoo4zV4otMrHcrYNBPiASDMAxxPG6SyvLaXmgw1
 TvNvj+LLHublLLWxqWeGmi/IPMroPU20Ymq5l87wornJMe3JXQEULSE8f8MtveWe
 GzAKUP9rXE46aD2+QmPNnGE6we7LV/Vs6TnV50sKsDCgJ4/Ps4BpEogR+/R43CDo
 BFZPqkAcIlFEgIh9zwCbwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760523873; x=
 1760610273; bh=bx9h8Xg+rwTWczdehLPt6cQPOQEl8u0byqKvGRAvLcs=; b=K
 m7UlbFRk1qykFe1zgrkWOTVz3nF+lcH6VH8lZd6/YsIZoYPPXm2MbXsCimTcbcsh
 hLveqn6cwfnvA8LxSIndQvwKDNSGsvBQv819drXufSue9YJhkhjs/rtPpZkh7Lif
 ohAkL9VgRxnRKhLizFUX4QioOy6uv2dtPHvbwCohBwbhiTEbrzu2EuLChpku7LXC
 1syPEX6parrcfdIXQap3ewy2FYjCtSc8CVk3rBXzw4p/zB/IBw9vaSwGIZf/Tfat
 g+w8pWRUZQKcJ7s8UdoTwq6YmnyahwfIYT52T8X/xvemxZo2Ngug4/12xBQ2WaWo
 si405iYglLThg3UFeXFJg==
X-ME-Sender: <xms:YXbvaCqkQlVQ9-uMmk5m1szsNJRWjaStRx1EncHgAm3GpK2uK0uR6g>
 <xme:YXbvaAwjJ_rXYgwdB0ZueYSeQbNtgPbCtp0789wCpnaHVMz2P3ay6uC_alDT2mpVf
 nVvU_B9CJMwDmybH2N4JJ1GAJkfdt00S3DHWeB7fMoLOjr7Js1B>
X-ME-Received: <xmr:YXbvaPK9CdE5mSlmwthWAfDETnENyeebR2PFQ8H4ZryU4djw4u7_CVrIbjw2VGgoc1Z4cT9fvnbdUqBOiw0W-oA9-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdefudeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeegpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehfvghnghgthhgvnhhgfigvnheshhhurg
 ifvghirdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohep
 sghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohepkh
 gvvhhinhdrlhgrrghtiiesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:YXbvaKIMFBx2hRT780i_9wetXGG9cSRCDQLM-3a58t3dqKxTdOGpDQ>
 <xmx:YXbvaMv6JIcDfR5f6f7qxVrrYMWLpMjlmVD92sZLGowDbIhi5UklWg>
 <xmx:YXbvaHQ4VdrRgW8hI2ZNx_w6diB-6e9EACTYDuB4pMvLXeUFrMfSdg>
 <xmx:YXbvaCN3Mtd2_Z283B94ly9TWOrFetofEh6Tl0iIInh2jbjNORttcw>
 <xmx:YXbvaDCitNV0uJPFajVvmxcIXeK2qI0rnrwUKEPZ8pfhez93wdNzPOXb>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 06:24:32 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, kevin.laatz@intel.com
Subject: Re: [PATCH 0/2] bugfix and enhance for DMA test
Date: Wed, 15 Oct 2025 12:24:31 +0200
Message-ID: <2580558.CrzyxZ31qj@thomas>
In-Reply-To: <20250827012829.40752-1-fengchengwen@huawei.com>
References: <20250827012829.40752-1-fengchengwen@huawei.com>
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

27/08/2025 03:28, Chengwen Feng:
> This patchset contains one bugfix (some case never fail) and one
> enhance (support auto adapt ringsize).
> 
> Chengwen Feng (2):
>   test/dma: fix some testcase never fail
>   test/dma: support auto adapt ringsize

Applied, thanks.



