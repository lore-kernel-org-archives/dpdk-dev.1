Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74F6CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 22:30:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB4924026D;
	Mon, 10 Nov 2025 23:30:58 +0100 (CET)
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mails.dpdk.org (Postfix) with ESMTP id 134764026A
 for <dev@dpdk.org>; Mon, 10 Nov 2025 23:30:58 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id 1B63A1D00213;
 Mon, 10 Nov 2025 17:30:57 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Mon, 10 Nov 2025 17:30:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762813856;
 x=1762900256; bh=SATtOev6/iAPOqEAHr0CnbL3RJ8QeB5S3uV3vXmw29Q=; b=
 FdnSkoTQMqt+I5/68VFGsaN5f+woaVGV8H08E9jn2tmtOU6NbE3drm1mNBQLebzy
 bw5J5UcXOFXSGs/xAThmCjq01SDFY7pgb0o8UOO1+581ZkD1Ysxp1RUrocFpe0Z3
 3Hwc0VqsNJwK2GQtJ3Yg5OcZAl5p4VtORohJ7x1ZNk0iwVgVQvmfExrvZO0ZC7P9
 Wy4wOg8N8cNojDQdhNbjHrOBwUF36SRWPtQzJD6RCXLxxNMTa9SJJ+auSUbSg8hi
 4QvbCT53IeUo/A8nj58LmXQsYHqpMK3wwxfmTXFl4vMS9i/N32akHh1Lk4eFAKxB
 TH8FK+U5wSHI8KV+rn1W7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762813856; x=
 1762900256; bh=SATtOev6/iAPOqEAHr0CnbL3RJ8QeB5S3uV3vXmw29Q=; b=x
 0DXFqMGoh4MhPBf7tgQx1GNF+bC4rH3SY/Zo0Wdb0QGiJk+WrYwJ3/QbDjlmR/Th
 tQezmKYniCc9Nz3pelJ3TyJRHjvE3Ubef6Fzs5dk8MrszWsjejcBukC/qkpF2s2P
 sUf5mEs+tbDGsD1Qd+roL2dTWVlOEGLn32/EUzNqa5VKwKBkbMhaiAI0lQG6jdMd
 1b3C+qC07okdtitvHkoD1CK6rhYDhFJvvhW9LZTQw7cR58GEnb63Y/HpSeuW83tL
 EeYr7NyZThhHI1a+zDK/vxt/Z74Wss3svGgPOoSUHvnvAVwnGadVYj1/icV/NfrL
 2i/E3NHHH2OaVz2N3h7Sg==
X-ME-Sender: <xms:oGcSaewR3zqVXa0fvZOUkXYVSpw7G5GyzGa0qu8nZiyjKsYOJXkoqw>
 <xme:oGcSaUUJ8vq-z67QwJEVo7K_4Xz_e0rL1TtmIN6zcY-lRuDABZ5_wUSe9UCgEaPat
 EHPd5Hqas_e_qW-3EwqmhMxLAc4FPu4d0ibaL0SBNfokeFMh2Xy1g>
X-ME-Received: <xmr:oGcSaQNM2CL6Snx3-BiNcHGdLDdd-EDNWmcMDqeYs6CY7AEwGNlgAijbSvJiRnD6KW4OnpqchrUK3QrmIE2crboVpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleelhedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeekpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghnihhshhdrkhhurhhuphessghroh
 gruggtohhmrdgtohhmpdhrtghpthhtoheprghjihhtrdhkhhgrphgrrhguvgessghrohgr
 uggtohhmrdgtohhmpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhplhhumh
 gsvghrrdhorhhgpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohep
 khhishhhohhrvgdrphgrughmrghnrggshhgrsegsrhhorggutghomhdrtghomhdprhgtph
 htthhopehmihgthhgrvghlrdgsrghutghomhessghrohgruggtohhmrdgtohhmpdhrtghp
 thhtohepshhhuhgrnhhglhhinhdrfigrnhhgsegsrhhorggutghomhdrtghomhdprhgtph
 htthhopegurghvihgurdhmrghrtghhrghnugesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:oGcSaWAKkGWC1QQF9xDvM-NGulIZEN9pv8CTtMyUv8Gzn0-ktEEMLA>
 <xmx:oGcSaddoswuwvO_o_NT6CjzcxPmmcgUqKXLAbzyDxAenm2E4aZOouA>
 <xmx:oGcSaVPrsbhBjBFy8xP3avF7zf5ebDuFizrmrg_I3vptpi4R9iwYdg>
 <xmx:oGcSadJS8I-SKg8tGoZTpJ7DAcfkyO7Ix4BhPiaI1EFe5uoCxbHXwg>
 <xmx:oGcSaZKbrICogN_eB3ieDgd-OiTx2x9yMZIHrH96essCnPjOkA_0LdLZ>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 17:30:55 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Manish Kurup <manish.kurup@broadcom.com>, ajit.khaparde@broadcom.com,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Michael Baucom <michael.baucom@broadcom.com>,
 Shuanglin Wang <shuanglin.wang@broadcom.com>,
 David Marchand <david.marchand@redhat.com>
Subject: Re: [PATCH v5 19/57] net/bnxt/tf_ulp: hot upgrade support
Date: Mon, 10 Nov 2025 23:30:54 +0100
Message-ID: <2780952.dkkaz22YKf@thomas>
In-Reply-To: <20251110141017.4f2c034b@phoenix>
References: <20251021175049.46092-1-manish.kurup@broadcom.com>
 <CAEKskBV8Ebeesg8qLZ7JcENWYRgfFeOAOhHRBC-WaaLRhn43Mg@mail.gmail.com>
 <20251110141017.4f2c034b@phoenix>
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

10/11/2025 23:10, Stephen Hemminger:
> This series should have never gone into the broadcom-next tree.
> One of the roles of maintainer is to make sure local builds with all
> flavors of compiler work before merging.

To name a few we could also talk about hiding fixes (and backports),
forgetting the documentation, wrong commit explanations.
And many more could be said.
As I said in another email, we should not accept such future series
until something is seriously changed in bnxt management.
For now I pull from the bnxt tree as it is what was planned.


