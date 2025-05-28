Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4674C5AD49
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 May 2025 16:41:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E7AD40B95;
	Wed, 28 May 2025 18:41:14 +0200 (CEST)
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by mails.dpdk.org (Postfix) with ESMTP id AE5B640156
 for <dev@dpdk.org>; Wed, 28 May 2025 18:41:13 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal
 [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id A7BCE1140098;
 Wed, 28 May 2025 12:41:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Wed, 28 May 2025 12:41:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1748450472;
 x=1748536872; bh=pRvW7eFy5ANVo/9AE8VfpXZzzOHCansFEzQ/oQkWoFo=; b=
 ejFKloAR/trALflCluYCFXBzjwH/KqMBplf2rHGrCYi2mTLtJjL9MVzsouMKC87a
 TFXCQ7q+oJ3xuL3RmfIFxwFlWm9A4a4G2DPzccNV7WMblVn3vlI300pPrEd4AlZg
 WlXxwWSMgEm7Ypd09U2WjN91vNq/nnWX7j/z0+x3WRNsYCULxvnGx0pkWi+8u5X1
 Vrii/1WvnuM+QgWUkSKTsMPALSOBz3sx8r3wsCBklmsojq8/F7TL4ONolDBMotUL
 TYYphSyeyRVKcyX52DsnkHjBk0SB1F6NSwYexGkR8bHtmUO0t53qhj4LSOXxyrdt
 FMqJVBlHHo0XD6lvm7cRCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748450472; x=
 1748536872; bh=pRvW7eFy5ANVo/9AE8VfpXZzzOHCansFEzQ/oQkWoFo=; b=q
 K36peFjcndMshnILPbQSbzkLqhoK7t7LIniz06KFCWBHPRacUh3Ey0zOEsJw7qFp
 MBv0/Spsbj0UdsWm2XNS8o9eUlVXIg3u77GPBGldYH7kOkYYJJyyzHsqS1/5NYWh
 7iZuhVVpGzCB4XL1MxxD7D+qrJHaO66aHNcZ9x0XF/VWnQ63lFrLp4PPYdRTqSIP
 LGikgiiL1fl06EYvvCPSc/0Efik3GGhqQTV6C2HZlft81Szn2hhnN4+FGSoxbzXs
 qU4zuvqNac6cjS6of4ZL84AelnixLMzS9AadP/DRU0hTSFi6bpAJ/K6BejtCuFmZ
 3tUvFxTlRGVi3Rz+PLMow==
X-ME-Sender: <xms:pzw3aD9-ox2OtvYw-LxIsW41N8QTLq-gK7JgAOFny-OeA-iVO5zzUA>
 <xme:pzw3aPt2E85WKQ_y7Uplg1cxlqieKl1B_MhFVeuyTPqiwRlRz7BErTu89V4B1C5B7
 nUj7UeTNpAAeeaZOA>
X-ME-Received: <xmr:pzw3aBCD84sefG5EaQp7LL9XznzWswrXsEqBVQszCPEolpTN4sdZqMVykQnTTqDQ_adkwvZ1qUPdQXuPpisVcVGBOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvfeejieculddtuddrgeefvddrtd
 dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
 fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
 dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgj
 fhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuc
 eothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjedu
 veehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluh
 hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehm
 ohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouh
 htpdhrtghpthhtohepughouhhgrdhfohhsthgvrhesrghrmhdrtghomhdprhgtphhtthho
 peifrghthhhsrghlrgdrvhhithhhrghnrghgvgesrghrmhdrtghomhdprhgtphhtthhope
 gsrhhutggvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomhdprhgtphhtthhopegu
 vghvseguphgukhdrohhrghdprhgtphhtthhopehnugesrghrmhdrtghomhdprhgtphhtth
 hopeguhhhruhhvrdhtrhhiphgrthhhihesrghrmhdrtghomh
X-ME-Proxy: <xmx:pzw3aPeZElYOOzBrKhrs7Fx4lLRJz5OqBkC4BhmtYLV32mvkbLaxgw>
 <xmx:pzw3aIM8N7p43KdHvXI6dfRt8Ou4fRCZWDLsexbka5QDU_Ddpht6lA>
 <xmx:pzw3aBkSjc0vNzzIh1hh5P8kf28LryzTh6PG7vRX5GwEn7QNzL5tOw>
 <xmx:pzw3aCu8_BJhzV_T8p1udRDLMl_uptzZJoCoSriQpEkrT4-4Abz7Dg>
 <xmx:qDw3aAaARA5A-KzQcVMhQj_bu8zSlSUVqC_fPJq00TGGCgHa-NxVYiht>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 May 2025 12:41:10 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Doug Foster <doug.foster@arm.com>
Cc: Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org, nd@arm.com,
 Dhruv Tripathi <dhruv.tripathi@arm.com>
Subject: Re: [PATCH] config/arm: update neoverse n3 SoC and add neoverse V3
Date: Wed, 28 May 2025 18:41:08 +0200
Message-ID: <7878089.DvuYhMxLoT@thomas>
In-Reply-To: <20250516161558.1482246-1-doug.foster@arm.com>
References: <20250516161558.1482246-1-doug.foster@arm.com>
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

16/05/2025 18:15, Doug Foster:
> Arm Neoverse N3 build configuration is updated to include mcpu that
> aligns with latest GCC. Also, add Arm Neoverse V3 build configuration.
> 
> Signed-off-by: Doug Foster <doug.foster@arm.com>
> Reviewed-by: Wathsala Vithanage <wathsala.vithanage@arm.com>
> Reviewed-by: Dhruv Tripathi <dhruv.tripathi@arm.com>

Split in 2 patches and pushed, thanks.



