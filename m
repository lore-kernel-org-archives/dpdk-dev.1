Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CBCCCF9E0
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 13:54:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4622040151;
	Fri, 24 Oct 2025 15:54:31 +0200 (CEST)
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 by mails.dpdk.org (Postfix) with ESMTP id 3E1B940150;
 Fri, 24 Oct 2025 15:54:30 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 818DA7A0178;
 Fri, 24 Oct 2025 09:54:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Fri, 24 Oct 2025 09:54:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1761314069;
 x=1761400469; bh=ptZQoKCWu3IPHPDRgyIQpNq5k5V5iYz5v0FuvdS35nQ=; b=
 NBJKVwAd7nOsZwreJLYGGV8fRpTqZ9necQbVyKtJLKwNVXkPJNvu0Aysi5NBcXV6
 dc0wynp8hW58LG6oNAvlV9seIWbGgsmu6+KeM5UD6DawsC9Vi3BCIYn1vGexj88Y
 ZJJNOkIrQqw0G3lBAiK/fcXd79lRXHwLJePIUFb586Wj70G1o3zuS0EVnG+HM5B/
 Tez7qcEhl2enXyJiStMTrlcE4oeTMto3UtGrfFXUfth9cemU6yC3O8TRhTGX3G39
 mdplyBvAuTYVQoyN/U70TrmaiLmVprm4gqRAajnfgw5Ht3sMJ4zr15aw99zHKedM
 v/jDV01PGU8/M2OXvlwQfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761314069; x=
 1761400469; bh=ptZQoKCWu3IPHPDRgyIQpNq5k5V5iYz5v0FuvdS35nQ=; b=K
 4rcSSwbODBvIRgudhEKu4SGjWo6Kw8Rtp5mkDJsufSXj2V3lQ28VtrjKId1TManM
 W4NzL5209Ukc5qsgSIVpV5CADLcK0va1vHzA28ij1p8HQUXM8uN+70DkssgHuLSB
 UayX4y6YWX74GAF01VtoneVkW33H+JunZM1SzF64IH2USzytxVxJM3j5346BcF+b
 dY/TInDH0tTKiHPEwV1pGTh20hF9pviZuodvfmJQ96h3WkIcGHnAYCAJGBhSi5ss
 HVM9jEIaRF56Rcnb7Y51WcD3GtwNNWmpRw2/0cvBp26fnVo5Cp7mkcjHPOYunsjY
 7q2lYJz9fBYkb2nyOeSaQ==
X-ME-Sender: <xms:FIX7aPR7Sz0B-Jq9PCc381_GfasdaBM8W_rOFw-6nUmEk3KH8mX_jA>
 <xme:FIX7aHrlneIG-QwcXW-D_2BOaHE0ElEhXfZKwaz5hoTxVMguyjguQDoh4wP_4hOds
 tDCQHa-2sVMNmgnqoAL_b9w4trnXLtraJIsIDZsKBMW7D-oem5ONA>
X-ME-Received: <xmr:FIX7aNLj8FSiafaUCoN2yAsEaL17lwdTm0wCpCHSHPaIa1Kw6Ir2UFGrQQnEksUfN1M7JDSxDuDZBIAr45GTlSRhNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeelheduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertd
 dttdejnecuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehm
 ohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevff
 fgtdegkeeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgep
 tdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnh
 gvthdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
 mhgrohgsihgsoheslhhoohhnghhsohhnrdgtnhdprhgtphhtthhopeiihhhouhhmihhnse
 hlohhonhhgshhonhdrtghnpdhrtghpthhtohepphhrohgssgesihholhdruhhnhhdrvggu
 uhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopegtihesughpug
 hkrdhorhhg
X-ME-Proxy: <xmx:FIX7aKrWeD6k0mUQoKn7p5h5H3hCT6_m5ZZorbp46E-gtbljhYp37A>
 <xmx:FIX7aFzfHbCYYhS4tNvq7mjcZloeq2QGTw9upYvwV3ppLg73zmAumQ>
 <xmx:FIX7aOMbMYjFP_bjbftrr2Sh6IEr9o0zcMdfa49Id1HijOZW2WJptA>
 <xmx:FIX7aK4ZdAG-sKb-yXd3WgAeejGWWusNjlbCFYRxuwXTsLotWHcKDw>
 <xmx:FYX7aNAFcJRL4fiiF12yvacThMub5EG-dgnSEJDdGeKTUAadqZl3L2RM>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 09:54:27 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: maobibo@loongson.cn, zhoumin@loongson.cn
Cc: probb@iol.unh.edu, dev@dpdk.org, ci@dpdk.org
Subject: Re: [PATCH v1] maintainers: update for LoongArch
Date: Fri, 24 Oct 2025 15:54:26 +0200
Message-ID: <2521648.VZ3vTMCxA0@thomas>
In-Reply-To: <20251016090948.836029-1-zhoumin@loongson.cn>
References: <20251016090948.836029-1-zhoumin@loongson.cn>
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

16/10/2025 11:09, Min Zhou:
>  LoongArch
> -M: Min Zhou <zhoumin@loongson.cn>
> +M: Bibo Mao <maobibo@loongson.cn>
>  F: config/loongarch/
>  F: doc/guides/linux_gsg/cross_build_dpdk_for_loongarch.rst
>  F: lib/eal/loongarch/

Applied, thank you for the work done and to come.


