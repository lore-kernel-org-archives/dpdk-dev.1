Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0A9CCD18D
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Oct 2025 15:32:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D05B5402DB;
	Mon, 13 Oct 2025 17:32:25 +0200 (CEST)
Received: from fhigh-a5-smtp.messagingengine.com
 (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
 by mails.dpdk.org (Postfix) with ESMTP id 83A374028C
 for <dev@dpdk.org>; Mon, 13 Oct 2025 17:32:24 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id DB22C14000C8;
 Mon, 13 Oct 2025 11:32:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Mon, 13 Oct 2025 11:32:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760369543;
 x=1760455943; bh=kQ2m0Tcz8RLodgNFfs7GRT+CD9+EbHbzypRL24QxDiw=; b=
 CZdG3rnC0s64jfXHAi6NqZAYOrSuj+VVMjsivFZoyboqtd+0J/1RqaHjaR2d9EaW
 VzPHMTf0e2BryP9c0HFb72oqSrllDixEH8L0ru6kyp3k/H1xK1dbRUxGgFBV327n
 Uv6PylCGjOgExcU+N1S9xemZyF/69x8Q1uPl3ZDjco6r6A2QVwn661kTWPLXkPPz
 SI1HgDqqWnk/i8oGc0NXrYfpTlyGRNN5547e3Ue2Ve9Y/lf+4D6tih5FgSjvs7qu
 r6T6NCuRgbJEUAuNlcUbdg1INkT0P2rfLbmnCZXNiv+SwR6vUNxgsMDpX7ETCydL
 kzz23pxqrE/rw53kahXfRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760369543; x=
 1760455943; bh=kQ2m0Tcz8RLodgNFfs7GRT+CD9+EbHbzypRL24QxDiw=; b=D
 o/PRqjWhHk0AW1taLgUHtiDAD7Z+WqptlWSwZ7ix44jhMiJoIrJ2hWa0Sj0HlJG6
 kl4jGSzhl7eCF08wmfXiz7Rdes3Rj94IP95nIwL3NHXT2YaP4RBhAx8UHGV5BoNG
 2SllHsNrw2i4Lc2wERco5Jhd6ehb0v6Gy08lCQjIioMpCmC5gxnztp+orpUWV65a
 dNWwGwaTOor2XtgnqaASvRAv/nU2peS4+Q3vMX0HegPgooNxSsvuD55oHb5nI6vc
 CZcz3ZB6l9o3UebVTflk4Lhja5Uf1IOJQYMKJXorpXjUqoGjGNbgcLu1Hk8oJ20q
 5zwa79/I8B5vmyJB31FYw==
X-ME-Sender: <xms:hhvtaK11JVh5DZ5EEDKl0uDkWFm5S8ag9j0IrtoAfIIAzn6JYPau3Q>
 <xme:hhvtaICnWEALStH-c8owzQsJQ4u5ckqYtYbI9Pa71ZLc4uhzLG4xCfarCmOP7Eb8P
 8JAsQaSu51RsOHF_4taj1jcAe5VwySK-MF8S1CFnZxT9YdFY8B6Pw>
X-ME-Received: <xmr:hhvtaB7IRIQ8AjO5_zaKxJ8p4RhVNOycMkkV_-3G5JsEne59gT31ab8d2b9A3Wthl6UqIuZ3aTigvuTsDs_6qWGZdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudektdduucetufdoteggodetrf
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
 hrkhhplhhumhgsvghrrdhorhhgpdhrtghpthhtoheprghnughrvgifrdhrhigstghhvghn
 khhosehokhhtvghtlhgrsghsrdhruh
X-ME-Proxy: <xmx:hhvtaBItipuNnU0G1fyhMUnAQVGXL11-AB0e63jAeNrzx7j-oMgbFQ>
 <xmx:hhvtaKs4L3L7v3oB_fqL3ce5R9UGzD596RopzxvwiwEeOSklPPgt8g>
 <xmx:hhvtaAIxWCGJxIUrzbksDVvhU-6FCkX5uy85-3jTiiTcZjn76EYMoA>
 <xmx:hhvtaD9-IaC_-XNB5X_JtuPEJw6wbbzswd4y6HrzhiAkZDjhIBrv-g>
 <xmx:hxvtaC3pBETfWGP5v9FOO20lU0a7ZZlhMHxefl2DN16iVjJKf13yGtL6>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 11:32:21 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Shani Peretz <shperetz@nvidia.com>, viacheslavo@nvidia.com, 
 bruce.richardson@intel.com, stephen@networkplumber.org,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH v3 3/5] ethdev: mark mbufs in burst functions
Date: Mon, 13 Oct 2025 17:32:20 +0200
Message-ID: <2711482.bB369e8A3T@thomas>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6548E@smartserver.smartshare.dk>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20250930233828.3999565-4-thomas@monjalon.net>
 <98CBD80474FA8B44BF855DF32C47DC35F6548E@smartserver.smartshare.dk>
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

02/10/2025 09:44, Morten Br=C3=B8rup:
> > +#if RTE_MBUF_HISTORY_DEBUG
> > +	uint16_t requested_pkts =3D nb_pkts;
> > +	rte_mbuf_history_mark_bulk(tx_pkts, nb_pkts,
> > RTE_MBUF_HISTORY_OP_TX);
> > +#endif
>=20
> I think the compiler is clever enough to optimize away this if rte_mbuf_h=
istory_mark_bulk() does nothing. So you can omit the "#if RTE_MBUF_HISTORY_=
DEBUG". Also below.

OK let's do that.



