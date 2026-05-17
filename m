Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC280CD37AC
	for <dpdk-dev@archiver.kernel.org>; Sun, 17 May 2026 09:37:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 862E940278;
	Sun, 17 May 2026 11:37:04 +0200 (CEST)
Received: from fhigh-b6-smtp.messagingengine.com
 (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
 by mails.dpdk.org (Postfix) with ESMTP id 7E6264026D
 for <dev@dpdk.org>; Sun, 17 May 2026 11:37:02 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 4BDDF7A0044;
 Sun, 17 May 2026 05:37:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Sun, 17 May 2026 05:37:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1779010620;
 x=1779097020; bh=EQUAmKyFK2RloSccuLJOwlhzNHH5PAWuku8lkUC66dM=; b=
 n3w1ci+YFmQ2CcJDN+YmcNG+51ASfI+0wvv6pk+2QszyefZfAUzz0HpXH3+yMJSl
 8LkSbxVZ0oOf7TwoqNcHtXbD3gQoe2gGd6MZqlkPNaVE7DeV+yDmwY6Q29/P77mB
 IfFbiUAfHrqffsnpBZnruj8FQOgMRljc+P3AmHIIHh64JbIX4IEy8/lz6wV7hjxd
 rZlQNZfa5CdWmxU7Q23kIZib07Rkf8dgtfpUPSSQJkzn24p9eKdvu9lY5CYp0UkP
 r1/KuNbIFg8ua5f8k92sgtrESQtdv6uLrsPiwmQkp2holO7zfQitAkvlKGXDdali
 ZLvZP47qv/wy2q7QRE7Lpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779010620; x=
 1779097020; bh=EQUAmKyFK2RloSccuLJOwlhzNHH5PAWuku8lkUC66dM=; b=u
 5kW/tAXmlpLivJb1BWQEK9A4Di8G780/PBt4vX1pR/Lg5LGLRx4kT1JJ9xVI8TCc
 X6CHvzh65s6PPKXxFd7qRzGhWop71oQTYw7l91qEgKYAcJrTxZyVdtS36g6dBvi6
 4Tbbzb+rMUDfLRryzxo91B+2EnvgC1EPHCjUwmE7M83aoINbu+mlVxxstexGNxfv
 hVFMz/QtkbbhqnYIi+Yzny6MUrQPL98BNJ8r5+JSUE04VGPhD8wk3h2Aj5e7etWb
 1pP4911LwlmSTwV8Tg36Y+QJktUgX0swRcKT+ueMQUobH5nGM64g6K7/J7ahWkuE
 SMHy3zt3pnrGPbJcAF8Ug==
X-ME-Sender: <xms:O4wJanAr_gQzsovTYWEOgeOHhHNd417rbxAoWXWYWQMZ1yVa9I7VSA>
 <xme:O4wJavBIICxe7L6XbTXVMBTZy9le-jesmaUXIRCH9rmnO58-hGaJUFh8EMzmQQOrG
 e8qsH_EkGYzM0s7S1E_SU8XTvKQdFVbQCZfriCCINjwsE-1GfW_Cw>
X-ME-Received: <xmr:O4wJaiprnF09GWfFpY3cIcXmKNGBswoeOFk-9wX0lkgG0bqNDSwa2XFw5MhzkB3A7c4LDniVovwPmw08eI9JTTThCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeehieegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeehpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeifrghnghdrjhhunhhlohhnghduseiith
 gvrdgtohhmrdgtnhdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhm
 sggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhope
 hrrghnrdhmihhnghesiihtvgdrtghomhdrtghn
X-ME-Proxy: <xmx:O4wJapm2lZ48AjtBkCjYo3OwA7vK7DtautxoNqzfjgJ8MIdsJLWMtw>
 <xmx:O4wJaix9EWHMpwTsAJt3z6I5tsynE-qk_DH8QiMI2s8JTfD6rHDAeA>
 <xmx:O4wJah8V6Y6nPguQEKhi9HpShymju10KDuVAfcs4r9ZgevJruvfKkg>
 <xmx:O4wJauIyj-W85OiEogqa5jc3Ot606SioG-JEha7XzvKFgD122T4yCQ>
 <xmx:PIwJakqINlcIKPfUfBOaJB2xCcQlBHqbSA6AUEnW1ecHjoRO8zYgNgoY>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 17 May 2026 05:36:58 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: stephen@networkplumber.org, dev@dpdk.org, ran.ming@zte.com.cn, dev@dpdk.org
Subject: Re: [PATCH v1 2/2] net/zxdh: update zxdh Maintainers eamil
Date: Sun, 17 May 2026 11:36:56 +0200
Message-ID: <fysmzQJSS6ehtBMpskHJxw@monjalon.net>
In-Reply-To: <20260514015650.3500578-2-wang.junlong1@zte.com.cn>
References: <20260514015650.3500578-1-wang.junlong1@zte.com.cn>
 <20260514015650.3500578-2-wang.junlong1@zte.com.cn>
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
> update zxdh Maintainers eamil.
> 
> Signed-off-by: Junlong Wang <wang.junlong1@zte.com.cn>
> ---
>  ZTE zxdh
>  M: Junlong Wang <wang.junlong1@zte.com.cn>
> -M: Lijie Shan <shan.lijie@zte.com.cn>
> +M: Ming Ran <ran.ming@zte.com.cn>

He must be added in .mailmap.


