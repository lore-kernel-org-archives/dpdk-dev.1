Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107A9CCD194
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 09:53:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5AB61410F9;
	Thu, 16 Oct 2025 11:53:58 +0200 (CEST)
Received: from fout-b3-smtp.messagingengine.com
 (fout-b3-smtp.messagingengine.com [202.12.124.146])
 by mails.dpdk.org (Postfix) with ESMTP id AE165410E8
 for <dev@dpdk.org>; Thu, 16 Oct 2025 11:53:56 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id A46061D00144;
 Thu, 16 Oct 2025 05:53:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Thu, 16 Oct 2025 05:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760608435;
 x=1760694835; bh=2lIRpdR1GmzAp7di+I6sB4lO868TZ/FZoKOXdsehKwk=; b=
 Ms1MeKLv4K7TRFRPsU5q/OAIgk6fYzSku2EsJZ1GE+FlePfAX2GQyY3+AXFwRLWd
 0jR18cIyVcNw4sjuLgUbIj21ctL7BJuY8U+WuDDXJG6tWKGbzcLZjZEfbO0S6aJv
 JibdYhN5Pt5WOK9rFfQsD0Td/A6pEGKOPNdcWeFCMpNP5xWuiP5HNS14bj+sIF93
 2Dq3GQIzRA9IJY2tpMkuMqU5cv2ZkrdDk+dqf0b0co6pVnzjisaOHQe0MBoNvV2X
 2puvwV2nStPwVmPmxPjUcwTsamBpIf4l1aDeNgXSzBe8cr7ddDJcomKzmLTX58tO
 sHtQdzRfCpbPpzkOFFk3Sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760608435; x=
 1760694835; bh=2lIRpdR1GmzAp7di+I6sB4lO868TZ/FZoKOXdsehKwk=; b=u
 WUziW3LzRYOrm/va3bOj1JE2ksMZQBdKLXMO4No2Jz4IKtmzfRO/7GTC1+IEOqUz
 NwbeJ5hjHlEDFEplhKGABSie/x897/WCwngu/Vc34rojnU4nVIQZ9sh/BMUEFzrZ
 w6Kky9SGIivBgis/MpphHI6zDuXTFR/gaACFn8FbC3XasYZtHwNMxktmgbU8czM1
 C5HW3OO4Le0rRggmO5RRYYjYyFcpVidhLX8gx/32UU1DNQK00usH92FaQ/2qtgWy
 6cfz7KXKqXaJ2AHIwd0p+9+e4IIGl3ncLbNyNanQmja3lVvxzw3yC0Dtbb567w0T
 BGIs77Cfm5dsJIe3JxsbA==
X-ME-Sender: <xms:s8DwaMERKeQCuEyNyfrow44S6twjb53iSXAzCkwZ_l6KKYkgO4uz5Q>
 <xme:s8DwaOROWMsEybQ5eN90B2YcNJZ6jJkFBc-DTRsjSAvbZVkl4yNweMOSWhM58J6wN
 pSlUBPjAxnojYf1MEcPgAugCXorezQp_6ak-Y4KoCLQcE5yu5a3uw>
X-ME-Received: <xmr:s8DwaBu347OfF7XzvjbuEWiY8ZSDjF7BF5MC5IeztYXLz2K5PmWUxRkuzHDHaWktlZGFqkztEjwQJPzub5gFOlj_gw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdehleekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeeipdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehmsgesshhmrghrthhshhgrrhgvshihsh
 htvghmshdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthho
 pehshhhpvghrvghtiiesnhhvihguihgrrdgtohhmpdhrtghpthhtohepvhhirggthhgvsh
 hlrghvohesnhhvihguihgrrdgtohhmpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghr
 ughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifoh
 hrkhhplhhumhgsvghrrdhorhhg
X-ME-Proxy: <xmx:s8DwaOJ5zFzGKF88YHaa0IwT1iIPRycSl_jxkwkpAesWGupoiSWEoA>
 <xmx:s8DwaOlLrNlhaFuDBf3XoFDRE5yA1mpU1yL4tE3W6hWUjcK3dsg6Eg>
 <xmx:s8DwaPIXSWfG6LaYjopLX-VwHEMwGcmyktocrzkRh2C_6SHC8aB_3g>
 <xmx:s8DwaD5tMPsh39aiH2buWVlMUTE6Upwt13O7A2m9IVW0fJFrU5zqbw>
 <xmx:s8DwaOTK0fc-iXULwQyU-5xXcBAfnTTGoc3okH0tHnSZMvwpq6aTxum7>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 05:53:54 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, shperetz@nvidia.com, viacheslavo@nvidia.com,
 bruce.richardson@intel.com, stephen@networkplumber.org
Subject: Re: [PATCH v6 3/7] mbuf: record mbuf operations history
Date: Thu, 16 Oct 2025 11:53:52 +0200
Message-ID: <3739293.U3zVgo479M@thomas>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F654D0@smartserver.smartshare.dk>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20251014124046.1032293-4-thomas@monjalon.net>
 <98CBD80474FA8B44BF855DF32C47DC35F654D0@smartserver.smartshare.dk>
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

16/10/2025 11:04, Morten Br=C3=B8rup:
> > +	/* Calculate total allocated mbufs */
> > +	uint64_t total_allocated =3D
> > +		stats[RTE_MBUF_HISTORY_OP_LIB_ALLOC] +
> > +		stats[RTE_MBUF_HISTORY_OP_PMD_ALLOC] +
> > +		stats[RTE_MBUF_HISTORY_OP_APP_ALLOC] +
> > +		stats[RTE_MBUF_HISTORY_OP_RX] +
> > +		stats[RTE_MBUF_HISTORY_OP_TX] +
> > +		stats[RTE_MBUF_HISTORY_OP_TX_PREP] +
> > +		stats[RTE_MBUF_HISTORY_OP_TX_BUSY] +
> > +		stats[RTE_MBUF_HISTORY_OP_ENQUEUE] +
> > +		stats[RTE_MBUF_HISTORY_OP_DEQUEUE];
>=20
> Assuming the purpose of total_allocated is to count the mbufs not sitting=
 available in the mempool, it's not calculated correctly. E.g. USR1 and USR=
2 are missing.
>=20
> Instead of summing some specific states, just sum all states (for op=3D0;=
 op<OP_MAX; op++) and subtract OP_NEVER and OP_LIB_FREE.

Good idea


