Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B82C83F1B
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 15:56:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D6A14013F;
	Wed, 16 Jul 2025 17:56:09 +0200 (CEST)
Received: from fhigh-b1-smtp.messagingengine.com
 (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
 by mails.dpdk.org (Postfix) with ESMTP id 3BAFB400D6
 for <dev@dpdk.org>; Wed, 16 Jul 2025 17:56:08 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal
 [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 72F5A7A00AF;
 Wed, 16 Jul 2025 11:56:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Wed, 16 Jul 2025 11:56:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1752681367;
 x=1752767767; bh=YbRG9Jv8t7IrzZh+bUb0HJr0Asa2bdMkTiaS6+G7zJo=; b=
 L7imDY93O4btEfE8p71UErpLKcfRZabXM2l9lskrEEmFUYDcLpFMxyEotRmRd7HJ
 TnPq50pU54/GXPQfu/f+3f21L7svHiz8d9whKAwcwLm+InTXf7kZlILXguPNp6sf
 LDsQs0tCbgNcqqNmS8fL/JHg0073LVWAaBr4B4QoDJWVLL/pejUd2lKVWBYV1eOJ
 TehvYagts/9+QDGf6kEkIZ75uhnHDLu2hQyA1FmpaYePOadrUJnSjLO63FT/0MXG
 cxcb7pqppGh9vR0G670p2qteAA7CjGvgB5DQpunlBMIWHMQxEp8z8cXx5pTMokAn
 Gx19GRPyW0fkij5jJy5ZaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752681367; x=
 1752767767; bh=YbRG9Jv8t7IrzZh+bUb0HJr0Asa2bdMkTiaS6+G7zJo=; b=H
 80UTjdMQz3ig5H/GsY0OFLM3741BsgqZ8I2QyKRzX1wVxRET7Bb8MsspaJjqGkHv
 KgXDUOzGrC/D4CPG387UDNF2NosGspMgSwVi0NVuxQGaPAsVwntRLn9nwuSqWfRz
 kQEhhIGfIczxRM98aJe1EwdXkiMGnDtAXV+IWGyKx/nIxxnA60J6KlN3YtjZWAOn
 AAkum/ECKj0wmdjNDbLYFn/o4shjBygyPHfE5tfNlG898GVyFVvyhjyEtIb2Ja+X
 4vuz5CJKRe9hC5a9m8ONatQ87fod4KQjbo1/mxQWM5uJP+pZF8d+7fy+le/zVSuP
 5QPexRsxX/M9APNFMbQWA==
X-ME-Sender: <xms:l8t3aINCsLzH-7UWJV0q51miFIACZoUxxpUdKaecuyfLPoqGjgqn2A>
 <xme:l8t3aGlfbBEOL9FYTPN637xdAbz1qAippS1dbqnidbaPybrdi6lQyWaXU7-H6qBzc
 Dx6VDg_zjI_fnl19Q>
X-ME-Received: <xmr:l8t3aM7wEVrbLxxC72e_CFyDfvhg_Z1Lr_3N9O8bqXKuyBBP1l-gZxYTZ0mniXnRkd5p8wVs2_kzE4FZMl3y-Yz4tA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehkedufecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepkedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnse
 hinhhtvghlrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthht
 ohepmhgrthgrnhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepvhhirggthhgvshhlrg
 hvohesnhhvihguihgrrdgtohhmpdhrtghpthhtohepughsohhsnhhofihskhhisehnvhhi
 ughirgdrtghomhdprhgtphhtthhopegsihhnghiisehnvhhiughirgdrtghomhdprhgtph
 htthhopehorhhikhgrsehnvhhiughirgdrtghomhdprhgtphhtthhopehsuhgrnhhmihhn
 ghhmsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:l8t3aK1Zca31K5coPG-HMsyWODpWkzGsY81ENWYOYStp9QVQhU08Sg>
 <xmx:l8t3aHG6OdY34Tk1HwxyylSrrhSbjqRW9d-OTjE1ossvAMFyMUIdIQ>
 <xmx:l8t3aJh2gBq5hWBg9gGfRoUFRQZTgOmbTqFGRyFLqBZfKWQ8lrnzNA>
 <xmx:l8t3aKAMF7hL8nGI8gmLaDmLhWwVh6QtHejcb71dv0wO02FNLwSpjg>
 <xmx:l8t3aIeRhTqnuGfun21mi4-yQERY-bjbLxYbR0dLzeofDNhhG4b4irMi>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jul 2025 11:56:05 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Matan Azrad <matan@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>
Subject: Re: [PATCH] doc: remove Mellanox acquisition explanation
Date: Wed, 16 Jul 2025 17:56:04 +0200
Message-ID: <4667722.LvFx2qVVIh@thomas>
In-Reply-To: <aHeA3jXjcq80QERe@bricha3-mobl1.ger.corp.intel.com>
References: <20250716101516.224980-1-thomas@monjalon.net>
 <aHeA3jXjcq80QERe@bricha3-mobl1.ger.corp.intel.com>
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

16/07/2025 12:37, Bruce Richardson:
> On Wed, Jul 16, 2025 at 12:15:16PM +0200, Thomas Monjalon wrote:
> > Time has passed since Mellanox acquisition by NVIDIA.
> > No need to explain this anymore.
> > 
> > Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> > ---
> 
> I wonder if we should include in DPDK a "future_cleanups" doc which
> describes cleanups that can or should be done at specific points. For
> example, after a specific release or date, or after we drop support for a
> compiler or kernel version. After we add a workaround for a particular
> tooling issue (or other change), it would be nice to have somewhere to
> record when exactly the workaround can be removed and how/why to do so.

It looks very programmatic :)
Yes why not.

In this case, there was no clear deadline.


