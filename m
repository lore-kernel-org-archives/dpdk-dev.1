Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084C1C7EE31
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 09:27:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D7A840658;
	Fri, 27 Jun 2025 11:27:55 +0200 (CEST)
Received: from fhigh-b7-smtp.messagingengine.com
 (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
 by mails.dpdk.org (Postfix) with ESMTP id 90F574025D;
 Fri, 27 Jun 2025 11:27:54 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal
 [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id AAA6B7A00CC;
 Fri, 27 Jun 2025 05:27:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Fri, 27 Jun 2025 05:27:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1751016473;
 x=1751102873; bh=HiCX1kYZpkm/hNclNkR9dRyDw06E46yTARmVFilnwX0=; b=
 lgt57DS2P7tHf+HLIvuUICvi/NlNpmd4PzDzU2a2HS0j52LGGJzQOmuRAI3dyCB3
 RMQQtZToaPN7JyQkxr09RvGcL1YXpZURDKurtDiAhZSg+t0Y8jP8oAhQBTjMxz10
 mVHRIEZLiHC5VMJdN/MI18e5p3hEeZlINg29BCwJwfi6qgAM5ZFQKKVh5LfOlpzC
 D9n7YBQt/x6yCp8WVsGHvj6/Oc/+SatbilWDnwu43P1YfB1CnQ0pBvUYrA5tou1h
 7nV7p9zPPW57X5DgkW7fWtpD2E/bZLlXBQM3hF9j75Ui9jJJA+Yt9Q/5rjYrfo76
 m4Sxqm8FOOsHHcorkfmk8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751016473; x=
 1751102873; bh=HiCX1kYZpkm/hNclNkR9dRyDw06E46yTARmVFilnwX0=; b=R
 03N0tkfo/+f+w7bE2+BplJtu0KGtnGGoQMWzke4VzOZ5lBQWw1fv+S4X8Pk2bLYj
 Rfl6IQClPlXdu9C5h4KBIbHPTpRnupPkmVfWzUbgG9znMqgXGny4q0lbujdS8rvZ
 kE5sFWOFxAZUHP4/jMtQyzXPdcGjFc60eMgKqgHArBHkSG5AUGqHXHDKiZMvtzhw
 WcDaKjplZoecfDIwT1I5c8dew/f/km8nXZOM151t2Xruqm/DB45apjuAnWdxpKkE
 Xm3op9WSKQM0rMy+NwLqVT2BoGAfZve/LvIValt/7dONDUh57kVsFo11UB5UE2sF
 O17hgOs6KvtTWAbD0QmwQ==
X-ME-Sender: <xms:GWReaNpocoGHMsmmHITjouEXTKD6BxyhxYCDLAnQHsx5uxOImrtEeg>
 <xme:GWReaPqc2OQbtjAcowLw5RDSPjM5dI_cVy29p8isrM7xF24uEBh-yEKqq39cxVJec
 3kNg90tGW5sLsdxrg>
X-ME-Received: <xmr:GWReaKPKG4dJf5Bap3PsviIuiXKuvrJwV2vZJyu9JiO87lp_n3uI-dWkenNfAMqg7AcAm88GbpBvXJa2hjMWaMGyuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvjedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
 ephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghsucfo
 ohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrg
 htthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdvuefg
 feekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeekpdhmohgu
 vgepshhmthhpohhuthdprhgtphhtthhopegsihhnghiisehnvhhiughirgdrtghomhdprh
 gtphhtthhopehvihgrtghhvghslhgrvhhosehnvhhiughirgdrtghomhdprhgtphhtthho
 pehmrghtrghnsehnvhhiughirgdrtghomhdprhgtphhtthhopehsthgrsghlvgesughpug
 hkrdhorhhgpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepughs
 ohhsnhhofihskhhisehnvhhiughirgdrtghomhdprhgtphhtthhopehsuhgrnhhmihhngh
 hmsehnvhhiughirgdrtghomhdprhgtphhtthhopehrrghslhgrnhgusehnvhhiughirgdr
 tghomh
X-ME-Proxy: <xmx:GWReaI4lC-xsN71Ep0LqTRtndZtfQjAnFxTJ_wbO_0i8Q2NIVoRi3A>
 <xmx:GWReaM5VqINmzVkOM7_O4Lpkcr3is0Qf8O6gf_KKlz2ArM4D9zWazg>
 <xmx:GWReaAg5kopv32RT3VKBKnkwyN_jWH-NPMXrdEzf1uenxwePG5D_WA>
 <xmx:GWReaO4JfVUpuF-svQY8LFW2qeZRSvBOEbaElZG4Y-VcfkaOlS4pIg>
 <xmx:GWReaEq6o78tJ5wjKj4NdnzUGCEEY0DyYAzmJ-BIJ1GE9yt6cAUcsgqX>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Jun 2025 05:27:52 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bing Zhao <bingz@nvidia.com>
Cc: viacheslavo@nvidia.com, matan@nvidia.com, stable@dpdk.org, dev@dpdk.org,
 dsosnowski@nvidia.com, suanmingm@nvidia.com, rasland@nvidia.com
Subject: Re: [PATCH] net/mlx5: fix the WQE size calculation for Tx queue
Date: Fri, 27 Jun 2025 11:27:50 +0200
Message-ID: <5772944.CpGBqz00pN@thomas>
In-Reply-To: <20250627082502.26088-1-bingz@nvidia.com>
References: <20250627082502.26088-1-bingz@nvidia.com>
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

27/06/2025 10:25, Bing Zhao:
> The txq_calc_wqebb_cnt() should be consistent with the calculation in
> the function mlx5_txq_devx_obj_new(). Or when the input descriptor
> number is 512, the WQE size will be wrongly considered to be 30 when
> no max_inline_data is zero in some cases. The total number of WQE will
> be considered as 256 and that is incorrect.
> 
> Adjusting the WQE size will solve the wrong calculation when the
> calculated WQE size is less than 64B.
> 
> Fixes: 38b4b397a57d ("net/mlx5: add Tx configuration and setup")
> Cc: viacheslavo@nvidia.com
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bing Zhao <bingz@nvidia.com>
> Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>

Applied, thanks.



