Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2F3CCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 09:43:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09DF1402AE;
	Tue, 14 Oct 2025 11:43:34 +0200 (CEST)
Received: from fout-a3-smtp.messagingengine.com
 (fout-a3-smtp.messagingengine.com [103.168.172.146])
 by mails.dpdk.org (Postfix) with ESMTP id DF3D4402A8
 for <dev@dpdk.org>; Tue, 14 Oct 2025 11:43:31 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id 38C57EC021E;
 Tue, 14 Oct 2025 05:43:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Tue, 14 Oct 2025 05:43:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760435011;
 x=1760521411; bh=hfF9pP2mb9kU7QgHRBXaji84kp8eI0lv2u/wRiFgwTk=; b=
 Ly/kG4UzfIEN3T4YJ60ocYlUBO/VSb1OZ8l3J1MvYdIfNkwXwQoajnAaqW/7dTNj
 Vxb6QBOAUP1t110u9y8sIEm2soFZa4Bm94dGbumziGGKIz67pM8uDs12fcXpZCuo
 +XmSDzfB4jt8/RexrrlB+dYW9hayz8bGmZ9rhlho60qTJ/Pgv/8LbrrIzQ3OLZXM
 /ZRXlcGZKHloJ7zmFvap54JVwQXn1kGPnM634ERhxaJ68fNbipEN1XrdCIsAZ2F3
 EME7PqvY51QnCv05+ucYJyO/4eEIjnWspNTDSbbGfcnbYp6Oo7J2GBVXp9xaaxiE
 gB3MpWHeKf03J02YsokbnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760435011; x=
 1760521411; bh=hfF9pP2mb9kU7QgHRBXaji84kp8eI0lv2u/wRiFgwTk=; b=w
 vimiO8VHO0tFE/GkqL6pPy6lUGm/yAfhSkVBXvTn5Z6EEtIsm33a0JFDgRswc/FV
 h/aZituj+aiU6/UagKKEfwDnYYI8b1oOPhnXaqQ/8wEIHzOT1jwhdoVsV7reTC32
 xM2etjw6PxtLtJfbUc73VRxSohKw+BGycylsNBx7by3BmDgeUiRCcxXbqE/4bDMO
 JuqNk4KNw75v8WWj2p11hgLMe7ClbZn/UTlGW8j2WxZVg6XgQEghe+g1vBypE6tl
 gi5VexhRbFsOAZYXzXhzczKbatAJXaQlYFlDAGEKhsuHm2cqhStDCJxok7D0ydC/
 HyyMzeFYFDuOqQDrEJrKg==
X-ME-Sender: <xms:QhvuaKhNOMRA2jnChNqmoLSE8aSyB0xWnYY6a56pemo-6cyiv1Q1qA>
 <xme:QhvuaF8fzvcXG0tL7cyzCmEzuQBafCT6K-HbNtt-mD3mZnGgyWB7snjbVblwMXFzz
 5zhiIQUneuz1YATSO9OAnRrcU38UDJW6zUfGIKJRchRklowbnqFpA>
X-ME-Received: <xmr:QhvuaBEsjw4i5ziaBBYqp6zJpd8cD5xxRMimwceqfICnMm3vL6LhZ-sALRc2_3c4WL2JKsS4iyn_p2QIWyszdVlG7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddtvddtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeejpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehmsgesshhmrghrthhshhgrrhgvshihsh
 htvghmshdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthho
 pehshhhpvghrvghtiiesnhhvihguihgrrdgtohhmpdhrtghpthhtohepvhhirggthhgvsh
 hlrghvohesnhhvihguihgrrdgtohhmpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghr
 ughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifoh
 hrkhhplhhumhgsvghrrdhorhhgpdhrtghpthhtoheprghmrghnrdguvggvphdrshhinhhg
 hhesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:QhvuaIkNBzGNi4sQG4SwzZNGdWXBRLd-HgPXp-kgIZD-puyWHW25GQ>
 <xmx:QhvuaFa1uWnjFN1YaGbEXvnnzcpbAQDqbSk9yuC7XddbWT4POCMDoA>
 <xmx:QhvuaNHn9CoO8zr3eE4snqv19GJf9odLwoIs6YimmVc1PJ95iEAiuA>
 <xmx:QhvuaGJO7YxGTe7ti-cgAJXUJh17n7WXTWAkCqUqxym4cFdhvJdMgQ>
 <xmx:QxvuaIbhYwvivHhG50N54qU0wH3WYcDPUvisajdLrshPf_yWWrY2KTId>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 05:43:29 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, shperetz@nvidia.com, viacheslavo@nvidia.com,
 bruce.richardson@intel.com, stephen@networkplumber.org,
 Aman Singh <aman.deep.singh@intel.com>
Subject: Re: [PATCH v5 6/7] app/testpmd: add commands to dump mbuf history
Date: Tue, 14 Oct 2025 11:43:28 +0200
Message-ID: <3472245.88bMQJbFj6@thomas>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F654C5@smartserver.smartshare.dk>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20251014070517.922137-7-thomas@monjalon.net>
 <98CBD80474FA8B44BF855DF32C47DC35F654C5@smartserver.smartshare.dk>
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

14/10/2025 10:45, Morten Br=C3=B8rup:
> > From: Thomas Monjalon [mailto:thomas@monjalon.net]
> > Sent: Tuesday, 14 October 2025 08.59
> >=20
> > Dump the mbuf history to the console or to a file.
> >=20
> > The dump will contain:
> > - Operation history for each mbuf
> > - Summary and statistics about all mbufs
> >=20
> > Dump the history of all mbufs:
> > 	testpmd> dump mbuf history all [file]
> >=20
> > Dump the history of one mbuf pool:
> > 	testpmd> dump mbuf history mempool <mp_name> [file]
> >=20
> > Dump the history of one mbuf:
> > 	testpmd> dump mbuf history one <mbuf_addr> [file]
>=20
> The "one" seems superfluous. I think this would suffice:
> 	testpmd> dump mbuf history <mbuf_addr> [file]

It's not superfluous :)
Without it, the cmdline library cannot distinguish easily
between
	dump mbuf history <mbuf_addr> [file]
and
	dump mbuf history mempool <mp_name>



