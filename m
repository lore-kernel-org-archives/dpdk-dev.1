Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123D5CD5BAC
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 14:17:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5AEC402B0;
	Thu, 21 May 2026 16:17:48 +0200 (CEST)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mails.dpdk.org (Postfix) with ESMTP id 5117E4025E
 for <dev@dpdk.org>; Thu, 21 May 2026 16:17:47 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id C489314000F0;
 Thu, 21 May 2026 10:17:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Thu, 21 May 2026 10:17:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1779373066;
 x=1779459466; bh=MQhqPazPm7+RZ2q1P4e6vAAzZLEJ9d848YBc+haj+NU=; b=
 S0Xkdfb7YjNvaTa1N4HnXWN5ePiSaOlCDVmtaIO9F+TxoMBi03oU5SE7axBmqKVE
 Z95l2Pr/pROKIzLjAS+3OLZwVAPeaxewivhw7fnbs8dRIGp9rEghoXExedERKEG+
 OJCVaP2u6I7c87p9J7C/4bNE1UmHra3AUl8O1r6l6JAyagAyC5eh7l7xp1DnSPaR
 g+nDDgVEqrXUS2K1i8ujAzRk/6z6dvaLzb3h0NR540z8M70kSmwD2G5K6x0x+jer
 m+8+jMjFYON6b3V7LRpKx9M69kapJPaeFw8fIs6tm3ja8TqEB0CJ23WH7y8aswkk
 mauyoQnXa+CPeV9T5UoNVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779373066; x=
 1779459466; bh=MQhqPazPm7+RZ2q1P4e6vAAzZLEJ9d848YBc+haj+NU=; b=Q
 EtyK0eAVa6SVuzqxSkagnR9e+Hho1DeB4rc9EMZ1EuFpDL9Mt12AS2PGo0FYEd9I
 3UejOcEaI5eJtXTfo3heNGzinKn4j3eobEDvtmGNczPIsQWepVDxY/AWPSYAWaKm
 wJlMvNTfmBS/3H7wNbgtXQs3P3NSk6KPKvuLhgHoCJJEkYL92GCmKTGkju0rJvFf
 Qr+1hqRTw4NkvaGiBNbCNYhVfXds942ZFDsEV9Lg2+pfGrjjcmWVoxdIiQPVAs8L
 3xlUkRMtyddJMmq0OC+8FzPjYSKhQNj5vdZ8uHkiCi/BBNFu9MC+xPiuPcmz9kRy
 TqoPznuk/ESYpxpLAbOaA==
X-ME-Sender: <xms:ChQPaooyFDots2KIIZ7T9InqwJGhmAuQKiw18aC14lvFE4R1n4oo8Q>
 <xme:ChQPai9s0cD46Dgk5_V8qVLX-MYXaBGN-fOuuDOkXaqiP2g4neZm3d2A06wP_jX-O
 G1NNL_n3RlalmIews_ChHZmUBmkvQT024_6z7yCHiN-6b73WCrqTA>
X-ME-Received: <xmr:ChQPasX8RZliA4DnfZlhk2Z6Cl5l1LG6BlyGljklCqal1EcSUZezpp2iYwjmjjXRMIwiCddByg7fnuONTGVNFEyeqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejjeefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkph
 hluhhmsggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphht
 thhopegrtghonhholhgvsehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:ChQPaoCVU7EH-fAwSTwPGqOR1bN4FkNEBU2vnG3HMn9turJ77WvH4A>
 <xmx:ChQPatyvZZ-HWpMPMdgIoCZe2dzRVYhvNj3vHGEyGGpom7uOyS2JMA>
 <xmx:ChQPalAM5gldHI5POqw6DHQoBBCmOJOE5KBUvNGqYceaO__RS6SwtA>
 <xmx:ChQPaqaZJAp_gUjMmRWTEJRyDhUFvXWYHiVT2u1bnIUCN-Wv_QbgCA>
 <xmx:ChQPasfFAFVz37kJhDk8c1-WZjZIP-5E1l17_OkFrQxp6f5Ilsd6UXXK>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 10:17:45 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Aaron Conole <aconole@redhat.com>
Subject: Re: [PATCH v14 3/6] devtools: add compare-reviews.sh for
 multi-provider analysis
Date: Thu, 21 May 2026 16:17:44 +0200
Message-ID: <lq8p06NuSpSdcXABY_Pu_w@monjalon.net>
In-Reply-To: <20260414211012.951613-4-stephen@networkplumber.org>
References: <20260126184205.104629-1-stephen@networkplumber.org>
 <20260414211012.951613-1-stephen@networkplumber.org>
 <20260414211012.951613-4-stephen@networkplumber.org>
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

14/04/2026 23:08, Stephen Hemminger:
> +#!/bin/bash

I'm not sure why bash is required for this script.
It could be just /bin/sh.

[...]
> +    [[ -n "$ANTHROPIC_API_KEY" ]] && available="${available}anthropic,"

If you replace double brackets with single ones,
you should be close to a POSIX shell script.

> +            [[ -z "${2:-}" || "$2" == -* ]] && error "$1 requires an argument"

and replace == with simple = in tests.


