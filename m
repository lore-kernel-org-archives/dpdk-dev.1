Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2DAC7EE30
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Jun 2025 19:52:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E13F4025D;
	Sun, 29 Jun 2025 21:52:47 +0200 (CEST)
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by mails.dpdk.org (Postfix) with ESMTP id CF7A440151
 for <dev@dpdk.org>; Sun, 29 Jun 2025 21:52:44 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal
 [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id D752A1D000A0;
 Sun, 29 Jun 2025 15:52:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Sun, 29 Jun 2025 15:52:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1751226763;
 x=1751313163; bh=hf+vLy8rbQXgglzaomVT39bPgVy9QxkbtRWzHp1GXHY=; b=
 eXg5en8wwSHulkuJ5kTs3IofZR3UxbpZ19eW1u++Du4DtkBc+HWw0sYXOxonhgqw
 USKqYboYIST6VaPqzPveZjHjNRn6dtA86seL6jD/X2A4ba/Qm/KTbWgf+9IvBEzg
 DXL+i9PdnC0mNb1GWFjY2aDGRVnXL/dec1E35XW08YlNrTum3uv+IdJ1TkktHkhh
 eTwcfVv1sPXXuIEdQV0Y5a1pgYO+aLbsEhakauSvNMuejtWoT5MYlpam5XyAgDSZ
 WvpKHebAX6Np5cSwc7IC3RoyiCkrt6UNv+D3hq2Rz9fNMsyX2PmlsjyCaGxfHO09
 Xf0e7pwqavlDXnnbucHGdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751226763; x=
 1751313163; bh=hf+vLy8rbQXgglzaomVT39bPgVy9QxkbtRWzHp1GXHY=; b=I
 RJ+6Tx35EOF39d5HQ3XU1xMCko+HuAfzBTGWpp9pcbo5b81utI33AxXV0Jw9zh+Z
 uk0XwLZ9J8Xjj3HzeuQlITZU/37jxHPpbo7qQEWvrrlCVxM7XE1BSLeQF59UvCue
 S2nGYEf35q23Phkj0FRivofHjWf9wGHBXIH6bA4xaG3/dhcnyXqLnZYXSeSucD7R
 1PLaoTu39oponEzKe8RmP4JPQyFC5yfAmvFzt1mphU7ZAgjp+r1IOiPTs7Y2j30Q
 Oh6BsviVrH5gFanM6sDvnk4Xw2CPBmzyGf8aanpjLF1PxEslWJL64N6y8kHOor0v
 Wm0q5Ri/D6OzkeTbghXrg==
X-ME-Sender: <xms:iplhaLmYIA0tl3floeusgM20XOYCR0pzrbdjs37xVznLh9yELkWXqQ>
 <xme:iplhaO1YmWCZ-in6KPlxbWzo4F9cNmxnKJ6qbyxbqm9u2aY8xviXQxiBERLgZMiNU
 ymnI8ha0_91-pj4qQ>
X-ME-Received: <xmr:iplhaBojDF_A4riF-OTcg3h89e5zstbwyCkFlgqZfiD0-8gjyyzhCIHRBDD_yvN4U3IZ2jwuGR0NdUq-Nh8tpGjlAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeljeduucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:i5lhaDm6j4zT6re2c0GDc1EUJnZd5vFv_sg7y86PiyoKiOsp0lX5aQ>
 <xmx:i5lhaJ1EUVE9i-d2FRu-pXBV66O1DPNXVdxM61K0Q7ML6z4HZbci2Q>
 <xmx:i5lhaCvh4YpN7TUEk19YMfVYJQtVr6ZO4V-1aTE7ote8KxkzvwdbIw>
 <xmx:i5lhaNUSu2LsXTtCxcYljq5Z983W2Ipc_YC9FXc80v_q7sO0Sjhx6g>
 <xmx:i5lhaDS2Q-6hU6YkuVTDtx8ZUe_YZmaZDicnGMuLjdo4_M9YviTU8FBm>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 Jun 2025 15:52:41 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>,
 Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Subject: Re: [PATCH v3 0/3] handle sysconf(_SC_PAGESIZE) negative return value
Date: Sun, 29 Jun 2025 21:52:39 +0200
Message-ID: <3846164.teYOa0iCNi@thomas>
In-Reply-To: <20250624080333.127618-1-mb@smartsharesystems.com>
References: <20250610131348.248800-1-mb@smartsharesystems.com>
 <20250624080333.127618-1-mb@smartsharesystems.com>
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
> Coverity reports some defects, where the root cause seems to be negative
> return value from sysconf(_SC_PAGESIZE) not being handled.
> This series addresses those defects in the DPDK libraries.
>=20
> PS: "_SC_PAGESIZE" has the alias "_SC_PAGE_SIZE". Both are covered here.
>=20
> Morten Br=C3=B8rup (3):
>   eal/unix: fix log message for madvise() failure
>   eal: handle sysconf(_SC_PAGESIZE) negative return value
>   pmu: handle sysconf(_SC_PAGESIZE) negative return value

Applied, thanks.


