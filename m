Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BE8CCD194
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 15:05:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 499FB40649;
	Wed, 15 Oct 2025 17:05:30 +0200 (CEST)
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mails.dpdk.org (Postfix) with ESMTP id 3DD6F40273
 for <dev@dpdk.org>; Wed, 15 Oct 2025 17:05:29 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 711981D000B2;
 Wed, 15 Oct 2025 11:05:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Wed, 15 Oct 2025 11:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760540728;
 x=1760627128; bh=UasyHj6SLrwoTzXZ7Z6Xhn1/pD9pMgwa2liD5PxTyPQ=; b=
 goWtc6sASrlpsZAHlQEOCZS8jjvzXmf8axAZL7DeklQVhGA5hEYvl+pKdI8kviJ+
 xEtwi+mH/HiPYuqwabeW54uutdP9LQh5b2IhyhyPD4n0DPZwW1hDAC9RrL8G9HV9
 5B/nF/5GC9OqyhqVnAb6Ez5sP9YC7sKrxHPMrQE7DvxPXgqWob98z5fGYqzYLijZ
 fPJe7Pxet7DI4uW1JNuX1+JeD15GidhcT1gvIRxeAi3pcgr/nxBYx54vwXY2G1FX
 VrwFvTOtaElbhnrfswM5T5c3g6w53Rivhzi9/cr88ItBe+XdKIdS7oUko2YuzNHL
 Rp0UY5gNcUYNbA8Mb3ygvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760540728; x=
 1760627128; bh=UasyHj6SLrwoTzXZ7Z6Xhn1/pD9pMgwa2liD5PxTyPQ=; b=n
 C9UaBxGhPsnw0UN9X6bY0GtAbo/39NA9uHSg3oDvwJkNqw9fU9wzcPkm+vndDE1q
 Piwv2wL3ZZmgUNvLdaauaEPHfl41dgnvzZ89P+YLfA6ZH3Uvy4KB+Mw+r62asZwq
 sOgggVqB66/mhSz36q9l66JSl7CbjUD/p1S2Yqqp46YqfF2jqIZaeS3+FmEvfFps
 lSf5Y1drCS+CkC1k4/aTJ3ER8Rz3HjcpVZc75irCByVfeWzv2wgwCv9lsBsaD186
 U1oquoSXWQuGVuLoFl2xtf0XyAXaPbU/JRzAqK18tYL8XqyzC8fHeWE6rCJQOeqe
 IVHqNqVyT1f1hQmqAs5rA==
X-ME-Sender: <xms:N7jvaF1-VpDPNYhh9Bs1uQngNbkJNmEcLHZcMi1dADjICIxPQ-NQLA>
 <xme:N7jvaHB6R90nVdCD5xL9Le-8u7A3EKnt8Lx8lxlpVl3p9pgD6U3DE9lk6lXCgg73T
 65l0yzRzVN659hyGE_nkwt5NIHSgCXu1PcGYdMwrR-_gEabENWM>
X-ME-Received: <xmr:N7jvaE44uHzWkOKJ9CnBWbyyvcGvhBVzCyndW-9yW2MYdEnlYykO9acnu5L2t1DVJ2g1xB4z8BPEKYwOZwkfH0QyKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdefjedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeejpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehnkhhishhhohhrsehmrghrvhgvlhhlrd
 gtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepshgrtghh
 ihhnrdhsrgigvghnrgesnhigphdrtghomhdprhgtphhtthhopehhvghmrghnthdrrghgrh
 grfigrlhesnhigphdrtghomhdprhgtphhtthhopehshhhrvgihrghnshhhrdhjrghinhes
 nhigphdrtghomhdprhgtphhtthhopehjvghrihhnjhesmhgrrhhvvghllhdrtghomhdprh
 gtphhtthhopegrshgvkhhhrghrsehmrghrvhgvlhhlrdgtohhm
X-ME-Proxy: <xmx:N7jvaIIRvCcCb9VhHjT_ZXWj2G1hT6-wxeBCsc5txXsj0ndKN9nHMA>
 <xmx:N7jvaFsc6q11ZTRJOyY7-3KGOJ_7uhnijg4HRSOB85lX46I8hdyelQ>
 <xmx:N7jvaPJCu_4giQc2JQkKKi1q71_7NwuXul11b9GgFQKyqzvKkYFY2w>
 <xmx:N7jvaG_BrY5plSXTVtUBxjH0n2wLrKtDLV2OiMemPgNG7wyv7BqV6Q>
 <xmx:OLjvaFig_g5Q2yMIOjcKD4lojmBTiYKry88nAR5TTnX-n2ZSGqnIIJkR>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 11:05:26 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Nawal Kishor <nkishor@marvell.com>
Cc: dev@dpdk.org, Sachin Saxena <sachin.saxena@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Shreyansh Jain <shreyansh.jain@nxp.com>, jerinj@marvell.com,
 asekhar@marvell.com
Subject: Re: [PATCH] rawdev: fix device ID retrieval function prototype
Date: Wed, 15 Oct 2025 17:05:25 +0200
Message-ID: <2509677.g5d078U9FE@thomas>
In-Reply-To: <20250924055654.1986682-1-nkishor@marvell.com>
References: <20250924055654.1986682-1-nkishor@marvell.com>
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

24/09/2025 07:56, Nawal Kishor:
> Fixed rte_rawdev_get_dev_id() function prototype and its usage.

What? Why?

[...]
> -uint16_t
> +int
>  rte_rawdev_get_dev_id(const char *name);

Other functions handle dev_id as uint16_t, so why changing this function?


