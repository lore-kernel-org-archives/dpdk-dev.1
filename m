Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E222C77B7F
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 15:58:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B97A8402AE;
	Fri, 27 Jun 2025 17:58:15 +0200 (CEST)
Received: from fout-a7-smtp.messagingengine.com
 (fout-a7-smtp.messagingengine.com [103.168.172.150])
 by mails.dpdk.org (Postfix) with ESMTP id CA50E400D5
 for <dev@dpdk.org>; Fri, 27 Jun 2025 17:58:13 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 36A0AEC01A5;
 Fri, 27 Jun 2025 11:58:13 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Fri, 27 Jun 2025 11:58:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1751039893;
 x=1751126293; bh=dZjjmzw8nz/zsXtu9aGiM9Bh9Zv2vdzbGcfA+xa9HAo=; b=
 ZY6X0Kla7EFQDpm3eUIin66/QmI+ltRxRzqIVoYyTHQ3mR36XgULVyHIQK6760qa
 awP7lJansirBP7WgEab/Va+SiENDkHmKyZeq/ZadtgeDaKqumyUmdnBDDK0H0zaR
 03BrM2QXjw+ICCNTO9oXI0Yf/9Q6dc3uztj5dVPcShS+LM/6utFx0ZL2OjiSaCCB
 1h1Rnv3WcO3yfStrXORLL4ByEZRvfSrmeks6yFLpbT85eNvsHTTciov5gIKywNWR
 PXAoB1zjHEcWrs/DV1Ntb/5DaQTTNUDpQNsTYhO5sUOj9CcsXl6pJWNovR4FX3cY
 u7NNq+UuA5Zl9kDI9GGT5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751039893; x=
 1751126293; bh=dZjjmzw8nz/zsXtu9aGiM9Bh9Zv2vdzbGcfA+xa9HAo=; b=o
 KfXR5hj6qzTnW0bVFabpn51yycHNsjwQ0xg7t5Lm+4+ei3ue0IpsF7se757zWWR3
 ztL6ucyz9Phh/aBg7DFJMgqEg0Zg17ui8vVY0AY74KCTeWGVD+Q1P6L4Jmrude7f
 7F3JF8dhE+FqKcwNamqil+lmPxgWLn8r/zhI4GBA4u7R0q8h7r/rkUFHXLKbuxLv
 vgSHqmEk8t0fLR2hpAsivw3pkMNGdQAuZtSsvhpJhdQAEbDWHSHPBJ18QMIzk1S3
 BY0HxdUG6kXtOjPNlpca4hX2AQUqlTHuhxmx7TeKOGeanSspk7BBBhFZt5Ze395h
 +gld3Z8/rvCQeYzh9hxuw==
X-ME-Sender: <xms:lL9eaPM69pHZt04J65rCrbUJi1OwZReN4NuWfWceVEOj6L3Uj4UQ8A>
 <xme:lL9eaJ-Hx7gDhJwFWCIOQdhZUiqFV2R-Ihu5Q6AIN6XLMVn-RonVBaCFLkzLK2jkC
 43IQQpv8Fctt21cmg>
X-ME-Received: <xmr:lL9eaOTwwdA_CVnYtQWv_AEqViDBd339SDz4eVFf9C8v_D3rksLMrg0wZFqgtojEfv7zgUClxcntEBXGz2zEOvEn-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefgeekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
 ephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghsucfo
 ohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrg
 htthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddvleev
 jeeujeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpe
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
X-ME-Proxy: <xmx:lL9eaDvVEzAKsv9JG_N-6pEBPPVibyn2r4f_uEo9MSaC7Zf_ryrVug>
 <xmx:lL9eaHeQrEK1s-1CdfJLF2pevqbHo9WD4WyzRn0rUF03gtxnnJdHCQ>
 <xmx:lL9eaP0I303G3E6V6lrOx0q-c1pv-kBOFXZOYCfhvRxKaSsSVTlV0g>
 <xmx:lL9eaD-z46u4ZCh50TLd0_oZqQURcokH4JSF5guq5olDV_zzFTKM2g>
 <xmx:lb9eaPbe6SRFpo8mhfNqczqSG53o6QD-vNN2PKFnGRnZlP9DSL_ESA5c>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Jun 2025 11:58:11 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>,
 Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Subject: Re: [PATCH v3 2/3] eal: handle sysconf(_SC_PAGESIZE) negative return
 value
Date: Fri, 27 Jun 2025 17:58:10 +0200
Message-ID: <17086222.mzqWEpnEhh@thomas>
In-Reply-To: <20250624080333.127618-3-mb@smartsharesystems.com>
References: <20250610131348.248800-1-mb@smartsharesystems.com>
 <20250624080333.127618-1-mb@smartsharesystems.com>
 <20250624080333.127618-3-mb@smartsharesystems.com>
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
> +		if ((ssize_t)page_size < 0)
> +			rte_panic("sysconf(_SC_PAGESIZE) failed: %s",
> +					errno =3D=3D 0 ? "Indeterminate" : strerror(errno));

We don't want more rte_panic().
You could log the problem and return 0 here.
It will be a problem later, but it may allow the application to cleanup
instead of abrupting crashing.



