Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CD4109E528
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 22:48:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2D9A4279B;
	Wed, 25 Mar 2026 23:48:53 +0100 (CET)
Received: from fout-a5-smtp.messagingengine.com
 (fout-a5-smtp.messagingengine.com [103.168.172.148])
 by mails.dpdk.org (Postfix) with ESMTP id 5ABA64067B;
 Wed, 25 Mar 2026 23:48:52 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id CB4D1EC0009;
 Wed, 25 Mar 2026 18:48:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Wed, 25 Mar 2026 18:48:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1774478931;
 x=1774565331; bh=J4aYS0aHVCnBC5L+MImsikpk08tN7IGO0AEkS89YdwM=; b=
 DVvwkN54bYA2wPdCNnMNfG7Rt7ykgV0yD/BFCPDAwRkSQ4vzJPWMyKNd5G2TcfKD
 pQWWXoojpOpbOjrXKzTHJBtE3pff6xNN19NHDrzpDmgnRyi365KCcR3W9EtIxVEP
 EOypYCJRvrTc5MbyGw5901aPgoPSK2Ond52f3KEDraTLHDIRnYe5gfhYDrXRBd2h
 sjljFMoD56nGf5vkMKmGID9xiHIgbqA8IzAENqYn/f6+UZ9IN+4MAhnBKJo7X0+l
 b49L+kejiHmynXf2RbOhuBYpAohhGky6NMe+SOT1wB2YUFjsOQShmF9a2yWlotMA
 ftKXYfz//tBb1tipzREjSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774478931; x=
 1774565331; bh=J4aYS0aHVCnBC5L+MImsikpk08tN7IGO0AEkS89YdwM=; b=E
 xhjgZ/6G5NcLgAf1j/k/469bsErlITBW8jAKmkTPS58iOFIonH2qn7PL0lr2lMC1
 aIXgWR7n4nIUj0VZFCEL6OPQi8QApTnrIjhiWRpwdyl/SCSPqmYL8HW+5tPDeR/M
 FlqG9GzJOlW+AeBmG/tzdBjeBRAoW9LsYayBJWslU0jsCFdsRetO1H3L4DLNZyLU
 ylnuIzmoQAw0GQ4rtyQGAaswUNiUEz+Q1BIbtIJepClCBGkV5tLAtXB42B/rCcvC
 MLZt1RLR4j6zpxuLzM+Nm/Hx2wshvGV37Qu5HfYKcwgdRny455jISjD3Ro+lS4EV
 /tr4/eJxG81Kh5egPtyzg==
X-ME-Sender: <xms:U2bEaSi2RM891EgoyXDlGY_iNgFc1jfnxqySXW3cvUf20zsrsBq4RA>
 <xme:U2bEaWvAOpCUG9Voy5n5sG3iT4eSonwfJMb8OaUOv_Ru-wmX1ZGUkTIeAW-Y-tRKQ
 r8cdWX3B0mygVTBVHvWz29KNik8LGdlRV8KKrN8HuImk5HaKAjZ>
X-ME-Received: <xmr:U2bEaT5qS6d6qPBL-0NOOwfghzrwXhQsgQbU9HeZwXHSaPwGfekF1A26rePyKQIbG53K9nF00b5urCUOE1X69G1EpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdehjeduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeeipdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonh
 esihhnthgvlhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphht
 thhopehsthgrsghlvgesughpughkrdhorhhgpdhrtghpthhtohepuggrvhhiugdrmhgrrh
 gthhgrnhgusehrvgguhhgrthdrtghomhdprhgtphhtthhopehprhhosggssehiohhlrdhu
 nhhhrdgvughupdhrtghpthhtoheprghnrghtohhlhidrsghurhgrkhhovhesihhnthgvlh
 drtghomh
X-ME-Proxy: <xmx:U2bEaSNgpZVIsGVIOlmyz-2lFVnFiQ26KSSablyvyqJvPlttOaM8xg>
 <xmx:U2bEaRswg6y_Tawc0TdXnfJJjxIwSLyWf3Q2PBZjAY2LSIvWZTV8HA>
 <xmx:U2bEaVbcJ6Nde0fjFTPKCFcxs6JqnvGDqLX3gqzG6ZjMDQ9tPVJiYQ>
 <xmx:U2bEaTyLPglSxJLFFvhKkgdm5RaUH98rM6etUyt2StzmpOf5XRDyPA>
 <xmx:U2bEabv_hUpdED4_VpMCorruBsoxtejGSjD3vGXpyXbD39WDgYjseFtH>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 18:48:50 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, stable@dpdk.org, david.marchand@redhat.com,
 probb@iol.unh.edu, Anatoly Burakov <anatoly.burakov@intel.com>
Subject: Re: [PATCH v2 1/2] test: fix failing tests on FreeBSD
Date: Wed, 25 Mar 2026 23:48:49 +0100
Message-ID: <6520037.1IzOArtZ34@thomas>
In-Reply-To: <20260320161108.331745-2-bruce.richardson@intel.com>
References: <20260319171334.1151425-1-bruce.richardson@intel.com>
 <20260320161108.331745-1-bruce.richardson@intel.com>
 <20260320161108.331745-2-bruce.richardson@intel.com>
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

20/03/2026 17:11, Bruce Richardson:
>  test_mp_secondary(void)
>  {
> -	printf("mp_secondary not supported on Windows, skipping test\n");
> +	printf("Multiprocess support on present on Linux, skipping test\n");

There is a typo here.


