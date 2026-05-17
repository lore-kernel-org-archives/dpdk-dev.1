Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBF4CD4F21
	for <dpdk-dev@archiver.kernel.org>; Sun, 17 May 2026 09:38:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 767B040278;
	Sun, 17 May 2026 11:38:21 +0200 (CEST)
Received: from fout-b3-smtp.messagingengine.com
 (fout-b3-smtp.messagingengine.com [202.12.124.146])
 by mails.dpdk.org (Postfix) with ESMTP id 170B84026D
 for <dev@dpdk.org>; Sun, 17 May 2026 11:38:20 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id 67A321D0006B;
 Sun, 17 May 2026 05:38:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Sun, 17 May 2026 05:38:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1779010698;
 x=1779097098; bh=YjWHu82v3WLm5q3cybp6NyIPgQDprkx5pYrY1nI4PzI=; b=
 hJ7S0pJdzo85dR9NpwFmmAC0u3JcwfFmnP2gFyrufvuOkfojqacaJJ+T/tpM4iBT
 tec9y/2u4ud2LtQ6hq5kbgX8RRNP6fGIB7jPf0XvgoxdVHaAEgEvG4FJGqL8uhX/
 R9Kv4nERR0gDZf2irAJNZr+bZk6Dc3RAGBl5zBkzqR2fSAu+CVP4LuOwIh0UGGOJ
 +zqnNQPCMMa0UGCGi41cJkuXwkodjQJIIelWtFmNqA+ch4wsMsFwx8ZFhaJBOlOS
 MVnkZg5jV5QoxRnMxWuoT3mgDW0YJZwBHAoz8EcIgWT24VVHEKTKTDXx4sV36QcA
 QcE+7LMoE54GQkMACv31jQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779010698; x=
 1779097098; bh=YjWHu82v3WLm5q3cybp6NyIPgQDprkx5pYrY1nI4PzI=; b=e
 7OV5nztflMJ/5KV/q4tqlYfIWBzAOx4KPUv6pxO3IqOFqgrzzyBvOGbGXyejbyf/
 4k7TaM0Mgy6R5Ydm4O88DTXZmxE9LqPy1m6yvZgvHt+fT9nStnTbYIxUYuJQL9lr
 HTweBjguLxgahULIMsvxXL86kq7eFqYkjf2L3krAydAltKX14gNFYGo1w8QR3WRu
 yESfXVqXKaQ0S9JpncVbTeYQOI6mRjIdGKizX5GzLk3NT8jzBq6E8iNIg58PJdlk
 Xncca6IUducRjoifLdFOy0KNR80cUIGqiyK91Qri1qVaJ+MnLiw0ctV660d35b5v
 3wPm0XdUfRJVzRxXrezag==
X-ME-Sender: <xms:iYwJasp2kpoePkGeZYFW3WGuND6oTClUN9PpAuvLPatxuqJdGF030A>
 <xme:iYwJagcebu6n1CFhrh7aivzvJs5zU58xEhQ7RH_b0Hpr1c3mcX4X2f_3_ps1ezBg6
 8CT7GqJAeG5ex-Aymbemks5aRaqcNhVyPH2bewveKRi4QvvcsaT5bE>
X-ME-Received: <xmr:iYwJarpIkuFH5EuEmG42M8vZtEeTuX3dRvKOsUofkKzwPaliUVKj0bYNqj9af0gyQCJGRFiczvdorURi2LYh7N4e9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeehieegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeegpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeifrghnghdrjhhunhhlohhnghduseiith
 gvrdgtohhmrdgtnhdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhm
 sggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhope
 hrrghnrdhmihhnghesiihtvgdrtghomhdrtghn
X-ME-Proxy: <xmx:iYwJahFhrh6Kb-8h5kaTlGqaACrqA8cfXVk0IDbJodxUkfxHWKIezg>
 <xmx:iYwJarutC31dY5MKXdmmGaqBwoGSWWn5uAq_9Z3D9r5btu2zjtO9FQ>
 <xmx:iYwJajXhnylrJqHASIbT3CsztIb51AIM-jSQO8pnAtXXeeMhiJ4XUQ>
 <xmx:iYwJanEUV5NQFmnvVt3nXAc9rwbk78xNcpJ-NU9SeUIiVEcPG3GkBQ>
 <xmx:iowJavsOtugm8s93Pv7JcEM75rPmGwiyP4CMb_IAb5A1OgiR1JK63Xmu>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 17 May 2026 05:38:16 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: stephen@networkplumber.org, dev@dpdk.org, ran.ming@zte.com.cn
Subject: Re: [PATCH v1 1/2] net/zxdh: add supported zxdh support nics
Date: Sun, 17 May 2026 11:38:15 +0200
Message-ID: <_JndlwHKTf61EgE8J24TNw@monjalon.net>
In-Reply-To: <20260514015650.3500578-1-wang.junlong1@zte.com.cn>
References: <20260514015650.3500578-1-wang.junlong1@zte.com.cn>
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

14/05/2026 03:56, Junlong Wang:
> update zxdh nics doc.rst, add zxdh support nics.

There is no such file doc.rst


[...]
> +Supported NICs
> +---------------------------

Underlining is too long

> +
> +- ZXDH E310 25 Gigabit Ethernet Controller
> +- ZXDH E312 100 Gigabit Ethernet Controller
> +- ZXDH E312S 100 Gigabit Ethernet Controller
> +- ZXDH E316 200 Gigabit Ethernet Controller



