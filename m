Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6148C7EE30
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 12:52:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4EE4F402A8;
	Thu, 26 Jun 2025 14:52:26 +0200 (CEST)
Received: from fout-a6-smtp.messagingengine.com
 (fout-a6-smtp.messagingengine.com [103.168.172.149])
 by mails.dpdk.org (Postfix) with ESMTP id 178C1400D6;
 Thu, 26 Jun 2025 14:52:25 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 9E950EC00DC;
 Thu, 26 Jun 2025 08:52:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Thu, 26 Jun 2025 08:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1750942344;
 x=1751028744; bh=WIASueq1XKC4TG+bWrnEN3WU6LJHUBmUq4DeSqCa4y0=; b=
 bq1QOFhMz03nwzieE0Gc6emW5M5i6GVlAvhRtxpTw2LyayQJROe/hIJdUpBp5bS4
 VXjqCSxcNFDxAVOR7WFv7j5mI8bPHJJXqu+sc+slPQRoV8ZD1qOnTWlXDGTTWloR
 oj5uPxEHSFymYFlW9pB4ruU5tnYFoVfpk7TNVz9PcmMIZzRT9r6v6M5To1iclTVQ
 EHQbT06zCsaUVyusxf345b8tD0mj54JKzd3Nnn/DVw08HApB+LAJBnk+hN3SO8W6
 hkX3tDLLPtxeo9Yk7qd0aqLtKhSN0aM9TECzybzFQsivmvFb8nyVnzySOUTP3HH7
 kk8/hjO5oS9Er4OjiEn2fA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1750942344; x=
 1751028744; bh=WIASueq1XKC4TG+bWrnEN3WU6LJHUBmUq4DeSqCa4y0=; b=W
 N0SBejF3KN/BiVZjXPimrZdvkdHawo7W0z1dJN423ohOYTFXvDLtuxeUra2OCQRR
 j/pzemynF0DBALLtuzsdDgXMlguS6iu4hnmyK8Mjp6lppTnzbGhNXRaU+O8jF9+p
 jO8d/ymaSHGnSC9kz1UOAmT0PYAEUB4GENDcX0ammzmfELcEDEv6mO7yh6cyTZe0
 zLpndPvwmEUdVQSyx4UVEkyzVDK76vDMIy+gfjlZ0us8SikSj+LogSjxo62GAE7p
 o49bRTzkqJH2WkT1LpAMUHS+GEFZwVB4bEZ0VWmQR5yaws/jC7w7dUdOnsHkKFe3
 gpOuIJZIVdqa3Gqfyj75w==
X-ME-Sender: <xms:iEJdaDQuwyJMnoHBAreH0xrKbsTTPOqmsa6etixKOe6gOHBfDJ5gTg>
 <xme:iEJdaEyAgyDtazppP4nVemlf9_lETDauoubvQRXuo78cHRaiMLUxXZYzMhqrp2gsT
 0LPDq4PdB0_19uUlw>
X-ME-Received: <xmr:iEJdaI1AsiKDK5Mu4JkDNl7U4WWyMo9IL6wl1gDGUnOHAe9tSxKyLuf9HSyy09Nl5IlpcCfFvUu0CH3NYX2JHdA95Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvfecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
 ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
 fhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcuofho
 nhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrth
 htvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeugfef
 keejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepth
 hhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepuddupdhmohgu
 vgepshhmthhpohhuthdprhgtphhtthhopehgvghtvghlshhonhesnhhvihguihgrrdgtoh
 hmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepmhhkrghshhgr
 nhhisehnvhhiughirgdrtghomhdprhgtphhtthhopehrrghslhgrnhgusehnvhhiughirg
 drtghomhdprhgtphhtthhopehsthgrsghlvgesughpughkrdhorhhgpdhrtghpthhtohep
 ughsohhsnhhofihskhhisehnvhhiughirgdrtghomhdprhgtphhtthhopehvihgrtghhvg
 hslhgrvhhosehnvhhiughirgdrtghomhdprhgtphhtthhopegsihhnghiisehnvhhiughi
 rgdrtghomhdprhgtphhtthhopehorhhikhgrsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:iEJdaDCWw_g4mcs76-o3g_q9-55CSYYJzYgEia2tT8GTmTP3W6FLvw>
 <xmx:iEJdaMjWufQirS5lk3m9FWH7_E4yw8RvcF3cLxQQLf-qcAeKhCHs4A>
 <xmx:iEJdaHq_Xht-PaALBBVrG3VVQ0uQgN8gdh7sSubHmf8MHs8PR7nxbQ>
 <xmx:iEJdaHi0dIqKykP6oh0bj26hZuV3oSaULomP2zN8PhLmeh8mzYEL_g>
 <xmx:iEJdaEAxaIwmIAXGwB9SAXYyd-meF0ElIiMimFdJbLpBk_bSlql4OT3k>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Jun 2025 08:52:23 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Gregory Etelson <getelson@nvidia.com>
Cc: dev@dpdk.org, mkashani@nvidia.com, rasland@nvidia.com, stable@dpdk.org,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
Subject: Re: [PATCH] net/mlx5: fix access to auxiliary flow data
Date: Thu, 26 Jun 2025 14:52:21 +0200
Message-ID: <5708550.MVdQ21Qd56@thomas>
In-Reply-To: <20250625094339.344416-1-getelson@nvidia.com>
References: <20250625094339.344416-1-getelson@nvidia.com>
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

25/06/2025 11:43, Gregory Etelson:
> The MLX5 PMD keeps non-essential flow data in an auxiliary structure
> to reduce flow L1 cache usage.
> 
> The auxiliary data location differs in HWS and non-template flows.
> 
> The PMD tried to fetch HWS flow table from a non-template flow object
> and accessed stale memory address.
> 
> The patch separates the `mlx5_flow_hw_aux()` implementation for HWS
> and non-template flows
> 
> Fixes: 27d171b88031 ("net/mlx5: abstract flow action and enable reconfigure")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Gregory Etelson <getelson@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Applied with commit log reworded to mention "async template" Vs "sync non-template", thanks.


