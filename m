Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFC1CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 21:29:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0C15402F1;
	Wed,  5 Nov 2025 22:28:59 +0100 (CET)
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by mails.dpdk.org (Postfix) with ESMTP id 95161402E6
 for <dev@dpdk.org>; Wed,  5 Nov 2025 22:28:58 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 052CC140010D;
 Wed,  5 Nov 2025 16:28:58 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Wed, 05 Nov 2025 16:28:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762378138;
 x=1762464538; bh=J+PKwPILcPwR9e9G6qFbh2/qLCx/96wQ4VbWoM11RLk=; b=
 jXfi/FgSwZmaqJLqKEM9Nu4IvVTGR51wG5OQxYBWBIaeB3PqWe4OgOI/550tXCt4
 pZP8cV4L0updGpdTO8eeBPu/7gPTFu0WDS8L7JdymLf+V+LigZB1MvIu/apF3ae8
 q3c+AsfJDx+XQf0zLSP8U/gXIROu1PvDYmnRWdnyMl6gbcYUN5eQiMc7LjmKS86i
 t3TFMkkyDGEvIyCt6UusH90MOkIvWRkGOqltHj2tTBhNKP1l3996HQ2uP6hOJPoQ
 4egyjz+bkDRArjRnkSmmvBLnsb7a3IeOXXEDpxJKuIw1LFQdIdWWstkJJeEwE5+2
 bnmKXhfr7JmTmlV7t+Qbtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762378138; x=
 1762464538; bh=J+PKwPILcPwR9e9G6qFbh2/qLCx/96wQ4VbWoM11RLk=; b=j
 tgtRoh438kXA2IfWc1EhIi8V9DNmiuRptswC/qked6SddrCHWA9mRE0VtCVY74nW
 NVuyQi7DUVDdjaO3lAfktNRQ6LSepqQJADEi8J1mNrWxhsuWsV7sjwYAuTUnG16M
 8SD6307OWB9hB1l2R/9DntaUcxbBoMRPB+k5rwAq0N/X5xpMQzfYIz3rYzlWxeLa
 qtVomzsou+dOmBUXkWBpJFE0GzlpatA51ekAvMVcezZyYep8BQLglPV1bD0XzP5o
 I4nvZbXaIsys3OVrZzpFmtb9Q69FWFKuBe5BwLazP0jG/A8naYEfR1MwLEqQznVE
 s7gQ2XGgVTtGNmusGuEVg==
X-ME-Sender: <xms:mcELaQeRBLgWTt9FFeMGOeXp9RVhpDMazDk8wDqj0MSIL-Gt2IoEGA>
 <xme:mcELaej2XPpbA_We2c8mtGBz75v3Tt3Ln1yfOoFb91Xj6jSawJoKlXacc938IiBeq
 -5ElqGvx9njIN-vZtdrr8QBkKpo-n-HhnPMsibKg1q5bpcPQDKgYQ>
X-ME-Received: <xmr:mcELaUSaSPzEbg8zL3jCqm0AEPw_3gIxd9e86ljoyhXnMbAkT_SammL9XY4Cj9ZUp9Jnw7dgt3kp3zO4sGuqAqDvOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeegleekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehmsgesshhmrghrthhshhgrrhgvshihsh
 htvghmshdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:mcELaXxmxqzBlDb32Pa425WOUT_kfAONWDwJcWK2uz748sWviEgfug>
 <xmx:mcELafcAJgcCmbNzxal3A7niJEbc53ar_0UtKkMq45krnVV8WnKx3g>
 <xmx:mcELaTKcmm337IQLdDSPpplqW9_rdHtajTia-uUNUl6A8Xih3r5Ljg>
 <xmx:mcELaQHrB9chMFFkG7fYc28QO7mhFVUp3Ha739h_RFy9UNV3GVomtQ>
 <xmx:mcELaf8GcKa3q7GCgr7V-TWpWRXk-eQZrl-TS9cESIt8WWdPR0NiNKmN>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 16:28:56 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] mbuf: improve mbuf comments
Date: Wed, 05 Nov 2025 22:28:55 +0100
Message-ID: <11692478.3WhfQktd6Z@thomas>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65530@smartserver.smartshare.dk>
References: <20251105112810.20838-1-mb@smartsharesystems.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65530@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

05/11/2025 12:33, Morten Br=C3=B8rup:
> > From: Morten Br=C3=B8rup [mailto:mb@smartsharesystems.com]
> > Sent: Wednesday, 5 November 2025 12.28
> >=20
> > Updated the comment preceding the 'rearm_data' fields to reflect that
> > some
> > ethdev drivers don't really set the rearm_data fields on RX descriptor
> > rearm, but rather when pulling the packet from the descriptor.
> > By doing this, they avoid a store operation into the mbuf when they
> > rearm
> > the TX descriptor, and instead postpone it to later, where it will be
>=20
> Typo: TX descriptor -> RX descriptor.

Another Typo: RX -> Rx ;)

We agreed to prefer Tx/Rx capitalization in devtools/words-case.txt.
I personnaly think it is more correct, as it is not an acronym.


