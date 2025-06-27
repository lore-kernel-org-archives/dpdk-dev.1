Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FFAC77B7F
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 15:56:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B2D4402AE;
	Fri, 27 Jun 2025 17:56:07 +0200 (CEST)
Received: from fhigh-a8-smtp.messagingengine.com
 (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
 by mails.dpdk.org (Postfix) with ESMTP id 6AFCB402AE
 for <dev@dpdk.org>; Fri, 27 Jun 2025 17:56:05 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id D0B271400195;
 Fri, 27 Jun 2025 11:56:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Fri, 27 Jun 2025 11:56:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1751039764;
 x=1751126164; bh=eeA9WloZ+By9Vlp7CQwZjIsp7cFZs/Ewkx4hzG9o52c=; b=
 Y1L/oudzxiHMsWXxvqXfbINGqx5F33dpR6m3VUhg94VIReS3p1iwoWTYsYWc6EDP
 3fGzOwR9Lbc+jWLK+coWVrlCf1RXU2FvLtYpnN6kCT6aqlduvJgRNSchY18TTDGB
 bhPAPPyejOkWu8n7wzBIKarBECmdKuxCUOGggps1eqcX19aD3Rfw14cFcKYuyfqJ
 ALsdkRrhS/ezxEcu37EDCGLWnZgziXAHOu0p/P6paUBoCdqy2z7250MNlMwP6A7x
 qA/Ui5F2yXuWFv9rk54dQ/Ihu3UqyZF3fhkCDdILQioBeN9FZc44s/bYq7l7cVHT
 1jQk8JyAEnm+WNX3Ca5eqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751039764; x=
 1751126164; bh=eeA9WloZ+By9Vlp7CQwZjIsp7cFZs/Ewkx4hzG9o52c=; b=N
 abN086G9eWXcmwIzwSCT9Xt02DM5pM/+ht0KQbBIqFqBY33mT4p9Zf32XnwMkYx8
 Ejp6ca6BdUHQfJ74XZW2lVPirX/5JBUARMabOAsfGYN1Ztvp7LaaKwN51Vp3CsxW
 2iSBXk20IyL5wHffCvnSBndYjAaZPhFb/ICMRa3qQdoR1Teju5ly3P3qqdf7rkHC
 +ehASycjV7f67UizU21dm7fjla47GGHlEFB16kHDeBVVdjq98V8wEsmhXHw1/YmP
 R9+3cX6nCZEqFo9meCbGKzDRlqGW8hf/zif4Pi0qonisBLlEHeL5deCJHVlaDuZY
 G3aqqw+6xx3TlIMb4FixQ==
X-ME-Sender: <xms:FL9eaGeqoTK_G5HNyiWQRwpKi6YWieeUC3GLp5jPc6g8H8FsudF0AQ>
 <xme:FL9eaAM02H4GRnKGgcYZR-mv8zy0BA7e-LcJNZe9lGitrDT4prrbriQSSZULNhrRm
 flQLOWY4Gbzg5SS_A>
X-ME-Received: <xmr:FL9eaHgv7cS0Z7fjVjBG00BChFAoYYxmxNTVWaE9-TEPGb-imuRcK3tQINVN1OMFg9zrQceMb9jtg8ZTMUgP3q0Zpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefgeekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
 ephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghsucfo
 ohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrg
 htthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddvleev
 jeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeelpdhmohgu
 vgepshhmthhpohhuthdprhgtphhtthhopehmsgesshhmrghrthhshhgrrhgvshihshhtvg
 hmshdrtghomhdprhgtphhtthhopehrohhrvghtiihlrgeslhhinhhugidrmhhitghrohhs
 ohhfthdrtghomhdprhgtphhtthhopegrnhgrthholhihrdgsuhhrrghkohhvsehinhhtvg
 hlrdgtohhmpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghl
 rdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgtohhquhgvlhhinhesrhgvughhrghtrd
 gtohhmpdhrtghpthhtoheptghhvghnsghogiesnhhvihguihgrrdgtohhmpdhrtghpthht
 ohepthguuhhsiiihnhhskhhisehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtohepshhtvg
 hphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhgpdhrtghpthhtohepuggvvhes
 ughpughkrdhorhhg
X-ME-Proxy: <xmx:FL9eaD9yJgmr_lCG8pmUp58VjzEBfVv-B3oRLl0E4hm5IwN_Au8a9w>
 <xmx:FL9eaCsDW6Ajljq2bsoHAdqR6PEGS_DXkmcWbvoHF7ZdYB5XtqlROA>
 <xmx:FL9eaKGXI8JmtJW_DbB-CsOEXZaD2k3d682mH8Qisi5uwnSA6MImWg>
 <xmx:FL9eaBPHa3wHmTU2KtokPd8vx49l-s3sbCPrno4dx-LyK-9jkhtnZg>
 <xmx:FL9eaHq3FBO9Ffw7x5vEoe41yNvBFrsJJITzaP351j300YgwVP0vOCfD>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Jun 2025 11:56:02 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>,
 Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Subject: Re: [PATCH v3 1/3] eal/unix: fix log message for madvise() failure
Date: Fri, 27 Jun 2025 17:56:01 +0200
Message-ID: <4027143.U75o6juQT5@thomas>
In-Reply-To: <20250624080333.127618-2-mb@smartsharesystems.com>
References: <20250610131348.248800-1-mb@smartsharesystems.com>
 <20250624080333.127618-1-mb@smartsharesystems.com>
 <20250624080333.127618-2-mb@smartsharesystems.com>
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

24/06/2025 10:03, Morten Br=C3=B8rup:
> In eal_mem_set_dump(), when madvise() failed, an incorrect reason was
> logged.
>=20
> Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

We need to track the root cause with Fixes: please.


