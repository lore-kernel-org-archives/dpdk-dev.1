Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98E3CA0EE6
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 Aug 2025 11:36:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01A1640267;
	Tue, 19 Aug 2025 13:36:07 +0200 (CEST)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mails.dpdk.org (Postfix) with ESMTP id DAEF340144
 for <dev@dpdk.org>; Tue, 19 Aug 2025 13:36:05 +0200 (CEST)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 3DCDD140068C;
 Tue, 19 Aug 2025 07:36:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-07.internal (MEProxy); Tue, 19 Aug 2025 07:36:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1755603365;
 x=1755689765; bh=8n3kMNuAOL6gQLG9z8ezNbim3t62GB2D3kR7LccC28Q=; b=
 j57NGmAVJYAbRUZF37Ww1YZImHHGQPiFZsJpwPlMBgi55t+mdkNwD1o0lbK1GWO4
 GTUt9IqDIfn5N5shaOEIr6VLcj42IUGyPbNEgSXU1P6waA4voOKD4pD+L5PJPOnO
 L1ewK9WRLMknWMbCy4Q53DKwVmrkjaDjRekQZm+rSQO3PZbuuAJRy4hBuCCznWjl
 D+ZMHOniXb/BqjIs8X5gIRA5X8MvAnaxqj9/1ZFF+gLVvsvjFy3DvLysi/ygMBnk
 x8l5qNyhPV8IOBprQcbda2DLu21SHS/MM3TijJ7dSMFBgkcEjRQTbuv85FhwUKTJ
 YJmpaXLxGgfmSD+Kd9dz4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755603365; x=
 1755689765; bh=8n3kMNuAOL6gQLG9z8ezNbim3t62GB2D3kR7LccC28Q=; b=Y
 IbnyaP/efqcH0t0RiqEkoFPQk8qvkCvf/VtunSJpA0NSMyqsq2jWL3al9UDsHR+O
 KjgnCyuFb2qB/OYIoinOgZ8Hlz0+ncRv5FA47e3ccH2CTuKU7va2kBrCZwG8KPpA
 3g8rB1uPUh/WItAUJFp7R7tJkQ0NyLRoyVlLv/gr5b3JvFPgzMJFHXnogK3nKwaw
 HZsN5oCAHwz1iaKhQaWCCtcRIL94Dwhr/fgwAhU7pF6mLhBaYLRaTQzC9iNVsbYt
 Gwrs0rAx/8a8Xr7wVAKE0uYun2ZQh2zhTy5h2WbJfuykmeJch4/ukcg+4liR0j3Y
 syhB1pOs3fi8sceCiCabQ==
X-ME-Sender: <xms:pGGkaGlKot7M8t8ijLNiJKcwa0Ua4sdHUcdm_hV1gquV1LqGncqF0A>
 <xme:pGGkaFN7yE7Ul_GJu3pxUcHx4azYJlan5AeYmmeL1veWIm2ag7KGHEsyVLLt_saqW
 ZltqBT0iZNwup9ggA>
X-ME-Received: <xmr:pGGkaKMYe1ObwvwFwR8alfHbGtzX2gTXzYQLzmRKLvwqpWejzlSp_RsjkThQHiF0H2jPpz7w5v3Im8eE_We08N1dKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheehfeekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeejpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehprhgrvhhinhdrsggrthhhihhjrgesug
 gvlhhlrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohep
 phhrrghvihhnrdhmrdgsrghthhhijhgrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpth
 htohepmhgrgihimhgvrdgtohhquhgvlhhinhesrhgvughhrghtrdgtohhmpdhrtghpthht
 oheptghhvghnsghogiesnhhvihguihgrrdgtohhmpdhrtghpthhtohepuggrvhhiugdrmh
 grrhgthhgrnhgusehrvgguhhgrthdrtghomhdprhgtphhtthhopegsrhhutggvrdhrihgt
 hhgrrhgushhonhesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:pGGkaGjLEx_wmjxDl1TXAWzPF4yv-WezOVJakMtij_86Cv1fvWGzDQ>
 <xmx:pGGkaHt5vEbY6crpW_4RNOw6AQBQK5fzn1KDyogJrWeC9W5o0aHt4w>
 <xmx:pGGkaMQPfWLqAdDkRDHcUeLtyDnUvRkdgOOpMMcEpUOrpQcwqPYJGg>
 <xmx:pGGkaD0uZx4lTqFxByiRfztPQNcL2hprp058ML3FzENY4f-VuBt3AA>
 <xmx:pWGkaBan0Z8x9ZyJ58GV0e-XHxVFYVaPePw0q8XaLfgsHdX5DLxJkl1m>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Aug 2025 07:36:03 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Pravin M Bathija <pravin.bathija@dell.com>
Cc: dev@dpdk.org, pravin.m.bathija.dev@gmail.com,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>, David Marchand <david.marchand@redhat.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH 0/3] vhost_user: configure memory slots
Date: Tue, 19 Aug 2025 13:36:02 +0200
Message-ID: <15537925.JCcGWNJJiE@thomas>
In-Reply-To: <20250812023358.2400020-1-pravin.bathija@dell.com>
References: <20250812023358.2400020-1-pravin.bathija@dell.com>
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

Comments inline

12/08/2025 04:33, Pravin M Bathija:
> - add protocol feature support add and removal of memory
> regions/slots dynamically.
> - this patch set has been tested with multiple instances of fio

What is "fio"?

> connected via libblkio to spdk target backed unix domain socket.
> - please apply this this patch-set to dpdk mainline as well as
> version 25.03.0.

As mentionned previously, we don't plan to maintain 25.03.
I understand you need it for SPDK,
but I think SPDK should rely only on LTS branches.
Is there a specific reason why 25.03 is required in SPDK?


> v2:
> - fixed warnings with e-mail address
> - fixed warnings with typos
> - there is a warning about __rte_packed_begin not being in
> pair with __rte_packed_end which on reading the code turns 
> out to be false. It is an anomaly of how git-format 
> generates the patch and how check-patch checks it.

When sending a v2, please use -v2 so it is reflected in the email subject.

> Pravin M Bathija (3):
>   mailmap: add user
>   vhost_user: configure memory slots
>   vhost_user: support for memory regions
> 
>  .mailmap               |   1 +
>  lib/vhost/rte_vhost.h  |   4 +
>  lib/vhost/vhost_user.c | 325 +++++++++++++++++++++++++++++++++++------
>  lib/vhost/vhost_user.h |  10 ++
>  4 files changed, 296 insertions(+), 44 deletions(-)



