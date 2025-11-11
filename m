Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927ECCCFA1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 14:14:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B5CEF4026A;
	Tue, 11 Nov 2025 15:14:24 +0100 (CET)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTP id 52C0140144;
 Tue, 11 Nov 2025 15:14:23 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 6A6091D00144;
 Tue, 11 Nov 2025 09:14:22 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Tue, 11 Nov 2025 09:14:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762870462;
 x=1762956862; bh=mv6R1jkL9hFxRlrXd/Vb0jTFgpg8jlfTKhB7QsIscc4=; b=
 ZZKYsS7n0dXtpP3IVcfL21UIWiuk5i3pDLSVkx95XOb/EXyIgeNa/Ht9rqrE5YYh
 YvuWfi8pXzvngMDYXATdcM6zNH4Oxr/7BgMfHDIyNbVeUzrvsfOiSwtBxMlC8fuI
 kAb7yaGW0hCdRyUKx6uB1lAcmJEO2Ge7zHJtoT1vxjy/hwHcEQye89xuAYLpPwtS
 HAX1guQFABjZauHUkM5tAchK+EYTOfhLNsPTROKj2SGUyZpXoXomDXrgyjpXXWOA
 1GzWWOzf7KtpkabLUS4CM7TR5BH1HguCXeuQQxJGAwXrX2ok3v8WX4Fgy7swk/9V
 N5ngdQUuMLaTSCOpD1Cy8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762870462; x=
 1762956862; bh=mv6R1jkL9hFxRlrXd/Vb0jTFgpg8jlfTKhB7QsIscc4=; b=v
 XSDb7mrKrZuZLeGxwZtgUwU7DwZlqFgCKAYgt3DLiHScnE4SrRVYNrOMkJHQxj33
 NBCbVJD/viNWo3AUAurEb3TVRw3yKJOsoFpFyXO+btMg2ZaQM6999uwEsYD9ZxTg
 NlMA59re1cCH8v1fAe3ybGM7MjFaeOKZsukDPgV9ZfTtEKI8EDA37shJ5g+zSVIj
 JKfzXwf5VPiBtDD48E/5jnjGn7fVWTABj8u6XyrrnLq/gSVInmeCH0MWj9PtUcoH
 Xtutfsfre2fy7H/Sy701Dn5KnSNvN+OgnGfjLrQM0+Wrfkd+9qLGKGUYAWNVyY+D
 hPH879oBjG3ASXKfv/RUw==
X-ME-Sender: <xms:vUQTadUlJFrvSJzlm0-thasT1fOyfXY-jIZY0ZGuZiH42ZEwG6IU7g>
 <xme:vUQTaZl3dVJy1D4qenwWLiX0R8wVrrQb8cKOjuuFbXOw7nkG2L7ZPi0_43vCULl4b
 nAOAOdmvSqYAvUtSoDA_8Bv0wz3kazBbov_g02LthZnSqFCkC6ebg>
X-ME-Received: <xmr:vUQTabmyRhcDrWYLSqCz1MXEAEtXELfHQNRXdowyEmxiwPAwOAdiYUMOGNO3X6aEsGfUp0N3LRRm9nsl4WS_JWG_pg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddugedtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeelpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegtfhhonhhtrghinhesrhgvughhrghtrd
 gtohhmpdhrtghpthhtohepjhgvrhhinhhjsehmrghrvhgvlhhlrdgtohhmpdhrtghpthht
 ohepkhhirhgrnhhkuhhmrghrkhesmhgrrhhvvghllhdrtghomhdprhgtphhtthhopehnug
 grsghilhhpuhhrrghmsehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtohephigrnhiihhhi
 rhhunhgpudeifeesudeifedrtghomhdprhgtphhtthhopehpsghhrghgrghvrghtuhhlrg
 esmhgrrhhvvghllhdrtghomhdprhgtphhtthhopehrjhgrrhhrhiesrhgvughhrghtrdgt
 ohhmpdhrtghpthhtohepshhtrggslhgvseguphgukhdrohhrghdprhgtphhtthhopeguvg
 hvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:vUQTaRYv7NCxd-4HCu1-P7m4nya_gOhrzcfLHzBUjPn9siZD5wR4MA>
 <xmx:vUQTaVSlQyoPx4n-hsVLty3MHTTe1gG-dGj8hYBj6Mb_RLHfE3wUIA>
 <xmx:vUQTaTuSUxQ1CPHwGG2VA0p4fDaYUS8nmGeNPKqukECWVX2PWaDXmQ>
 <xmx:vUQTafF02jbLLAjlzoPiwXZOCEa5rBSyNuMOiG3FhSnlIPS0XiSxrg>
 <xmx:vkQTaZmBIJWdynTqNTTJV2MjZrkVHHwIfkMJJqMhqUjnFRoc_Up3X9QR>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 09:14:20 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Christophe Fontaine <cfontain@redhat.com>
Cc: Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, 
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>, Robin Jarry <rjarry@redhat.com>,
 stable@dpdk.org, dev@dpdk.org
Subject: Re: [PATCH v2] graph: fix xstats description allocation
Date: Tue, 11 Nov 2025 15:14:19 +0100
Message-ID: <3021103.SyXcmblsem@thomas>
In-Reply-To: <20251028110920.16353-1-cfontain@redhat.com>
References: <20251028101333.14776-1-cfontain@redhat.com>
 <20251028110920.16353-1-cfontain@redhat.com>
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

28/10/2025 12:09, Christophe Fontaine:
> Fix the extended stats name allocation size: instead of allocating
> RTE_NODE_XSTAT_DESC_SIZE (64 bytes), only sizeof(RTE_NODE_XSTAT_DESC_SIZE)
> were allocated for each xstat name.
> 
> Fixes: 070db97e017b ("graph: support node xstats")
> Signed-off-by: Christophe Fontaine <cfontain@redhat.com>
> Acked-by: Pavan Nikhilesh <pbhagavatula@marvell.com>

Applied, thanks.



