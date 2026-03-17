Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE8DF3382A
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Mar 2026 09:40:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25F93402D1;
	Tue, 17 Mar 2026 10:40:45 +0100 (CET)
Received: from fhigh-a4-smtp.messagingengine.com
 (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
 by mails.dpdk.org (Postfix) with ESMTP id 999A740270
 for <dev@dpdk.org>; Tue, 17 Mar 2026 10:40:43 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 0660F14001B6;
 Tue, 17 Mar 2026 05:40:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Tue, 17 Mar 2026 05:40:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1773740443;
 x=1773826843; bh=+fsVU6t8GH/xVakNA4mnlfNScuAKHBIIAjrnjNO3heo=; b=
 eykVvm9FyYspx/QxTpW5DW6Ym5VfOluLDmTcAm1aFEfR9JJtxbhATnL8Fj1my6Ov
 mEdqH/g8Snezx6+dPRQxnYhH0wiMnXorfYywOxnA2JhZsUqRtW01ypbbRpfelOE8
 HXu+BFjz8LaxWShpC1UYXX/hT7oaot2bcyjFN/ta1/0CA7f4GsFNk2XtC7HvqLoM
 zAIgaSNrlfiF+TpfqzZgU5Kzwyk4jEwLmpBjlUg6g6enOrJt8A5qLuwxAxCbDYGY
 dI8w6e388zpziCfeb0UfmrnQ++3MauR8dufy5pHUkSKr4JbsSJKnpPRJbbBPKkPc
 LAiGASAQ+CD3Ai9kvqFEdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773740443; x=
 1773826843; bh=+fsVU6t8GH/xVakNA4mnlfNScuAKHBIIAjrnjNO3heo=; b=K
 7yNq08PIvFyYg5VYrvfmDBPJAvegrJabOhyoWpIu+Gy76EMMbmnzlxlqbLPhCfrm
 RDyL/xPOnjyZG3vyOCwU8tBiEPWIDEm1JiZa9GXeevIa4uBW7+EcL4nNwO00kIw2
 QE1fDDT8R8/Yji+A/cENjRlDn8rDnoeLi3OM8ijHIgcXrBgHqcMSWnMvteJPER1O
 rzn2ThgciBgVaPsrnVWjeKyG+qpjD+8nbMVqRBw3EvDG6biR7FTiyYOBLLILc7AB
 5tDpy/JwtvfDinvUUS1Kcss43mUDgApmW4sGlp1DB5X8xHE0e7Y0gnv8sheCi09S
 10oy+rYy9RRf+YyU4JlMQ==
X-ME-Sender: <xms:miG5aa4gDJqik6HJE2fx97im59dj462J_DJTNptTyDDsR2CoMpr7aQ>
 <xme:miG5aYMphh5Pnk7VhQv1XPLCt2bK8pyWai_nrNNw1_ASS7QQ15qYHk1Ao4O5xabbQ
 0JNnl10npU_2JRUwVVfeX0yxtNghLgPujqgvT_EEu2nSygAdMBAjA>
X-ME-Received: <xmr:miG5aYkRxEJ5qdngrfais0vpqzFvGEwD2qVzC0GlvMK6Kmqnd1TV8xplLIFmbUoYu3j1KQJwgW2CwlBDiTfGr4Z-4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddtleduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehrjhgrrhhrhiesrhgvughhrghtrdgtoh
 hmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepkhhonhhsthgr
 nhhtihhnrdgrnhgrnhihvghvsehhuhgrfigvihdrtghomh
X-ME-Proxy: <xmx:miG5afSEWj_O80v5ANOybhzP_52gmvgdH29GEH-WbY98PNrFX9kkYQ>
 <xmx:miG5aUDca6o5vm-Lb7s28035qA9cqdVXxSSmnzHv9wOn96kEwgeWLA>
 <xmx:miG5aeTKmOtqU7eIDVDLeWNwnrYdg_hGJRDfaNhQV-yASB7dF3InKg>
 <xmx:miG5aaq26MIh80bKS__cNug0aCH3FARZVF-Kqs9TgryWWpCh3gES2Q>
 <xmx:myG5aWMFmpZOZ4H6yvlAO7-6evPfuOQ03sh3k7AW_yN4JV6whGFB-8Li>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 05:40:41 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org, Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: Re: [PATCH dpdk v3 0/2] hash: safe data replacement on overwrite
Date: Tue, 17 Mar 2026 10:40:40 +0100
Message-ID: <2180783.KlZ2vcFHjT@thomas>
In-Reply-To: <20260306084710.492520-4-rjarry@redhat.com>
References: <20260212213313.1376294-5-rjarry@redhat.com>
 <20260306084710.492520-4-rjarry@redhat.com>
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

> Robin Jarry (2):
>   hash: avoid leaking entries on RCU defer queue failure
>   hash: free replaced data on overwrite when RCU is configured

Applied, thanks.



