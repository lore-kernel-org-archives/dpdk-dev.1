Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91550C83F25
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 13:12:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCE6B4021E;
	Mon, 21 Jul 2025 15:12:45 +0200 (CEST)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mails.dpdk.org (Postfix) with ESMTP id 7EECA4014F
 for <dev@dpdk.org>; Mon, 21 Jul 2025 15:12:44 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal
 [10.202.2.50])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 29A7E140019D;
 Mon, 21 Jul 2025 09:12:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Mon, 21 Jul 2025 09:12:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1753103564;
 x=1753189964; bh=BdKAf5D+DgTjjaNYF1dnXWIz1JG6XaRUo4nyIYfKwc0=; b=
 RmkIA2ctS9T2SzzYIRecBecDS1nkWRKutxARSVFUq2sSLGWCBunztyaEX+WF3F9c
 ZR7S1F+VDypwWcktDHkjOBM5JK/iXq0gdZ6+cuAz4ZVkLKu30tATxfzKEdOjYi+r
 wIZm6JP7RuIjzQ20v9d9aNp6P+2Fj23h9Kws9bYYP7P0EGvhAqN+k6Y06FEdEpQi
 yk6JDZD4z+IQ4beOdf9VAhTIqZbYC9Bxp6rFDm6OD5Z+ht8A7yPG2tgc9xcyCRIx
 /MI3gqeuWkv2Df4YgCSYTzI9nFoFydfrNy6xwMhB14Ik0JyS2hFPceD1uRlrKhbe
 9+vP3iA+dwFnCrt4f31mfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753103564; x=
 1753189964; bh=BdKAf5D+DgTjjaNYF1dnXWIz1JG6XaRUo4nyIYfKwc0=; b=T
 6Zwkl6jiMptTWSTu1CYaJpP1wuvFSVnrusboQkgvGBcJUiLt641R39dJu6/0knFd
 Z6NCI6SR0FjAS0dDyI8hTQuj7XweV9w/YNi9ArWIYoVPEpvSgSfW16SKl6/YF4WZ
 nxVM3A+I/jVaUdU2xJ6x5/lZVyQvg7RXnACXWWCJ2cUYW73R0PPUV9vQGI0nVrgS
 UDgawJnup7POqoFTRHGYmoPxxTB7SkxvP60SFzwQ2n9eYo513WiTq4ahPz7jjY2I
 2T8Np2pRhUEA3m456l6J2olDe9532DkeBGBnmu/D4EJ+wU6T6S9OESnlGWcAJpXw
 VEhFGgPm3HCFWg6UOCqtQ==
X-ME-Sender: <xms:yzx-aDVRFilnweJWHhcn-uq2rY8WSHMu2-5vAfziJV6ABXPpCNIP7w>
 <xme:yzx-aGc7JcxiVURKzxVDGpetw40ihILUpb0W4HormMwrFcL3ArWHHbOmf3iD55eq4
 rNNosBOpuv3aNeKrg>
X-ME-Received: <xmr:yzx-aHOVW9eWWs-rb8pz9CUEZSunRmB-ePcBQViEQrx0zhZ9yRQV-kPQ3ImgyLAHnS8MFne2eqEsTZMV6xaDZ8JTeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejvddujecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkjghfggfgtgesthhqredttd
 dtjeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhho
 nhhjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeegtddtleejjeegffekkeektd
 ejvedtheevtdekiedvueeuvdeiuddvleevjeeujeenucevlhhushhtvghrufhiiigvpedt
 necurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvg
 htpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehp
 sghhrghgrghvrghtuhhlrgesmhgrrhhvvghllhdrtghomhdprhgtphhtthhopeguvghvse
 guphgukhdrohhrghdprhgtphhtthhopehjvghrihhnjhesmhgrrhhvvghllhdrtghomhdp
 rhgtphhtthhopehjvghrihhnjhgrtghosghksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:yzx-aMgBMuhc85A8A2gQ1lx6NfPubniTBJEYy9VS14BJh_5CJcKQLA>
 <xmx:yzx-aC2AZLhcf6tokIB8DSlnNRxP-jNs9Z-vpcSXk98lr0P335yQng>
 <xmx:yzx-aOg2sKrqxs0iN2ClEnFgTa-SoM0tuRe1Iniz9jMJT2I1kEwvSQ>
 <xmx:yzx-aKce0hosEJcA8XdP_WoTxQRVlegsYujqCATv3batvdbTcqMwZA>
 <xmx:zDx-aDfI9w5JtOSTVoFAFdx9d6dmP9ngMfR5snQXpMvq7Ch4RDTuencf>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Jul 2025 09:12:43 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: pbhagavatula@marvell.com
Cc: dev@dpdk.org, jerinj@marvell.com, Jerin Jacob <jerinjacobk@gmail.com>
Subject: Re: [PATCH] devtools: exclude atomic checks for common cnxk
Date: Mon, 21 Jul 2025 15:12:41 +0200
Message-ID: <3039387.VdNmn5OnKV@thomas>
In-Reply-To: <CALBAE1PSsm4o-a8_7tJfT=Shiq7xMLvakLgGH0kBRuhiH9e=gg@mail.gmail.com>
References: <20250327111344.2205-1-pbhagavatula@marvell.com>
 <CALBAE1PSsm4o-a8_7tJfT=Shiq7xMLvakLgGH0kBRuhiH9e=gg@mail.gmail.com>
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

12/06/2025 15:39, Jerin Jacob:
> On Thu, Mar 27, 2025 at 4:50=E2=80=AFPM <pbhagavatula@marvell.com> wrote:
> >
> > From: Pavan Nikhilesh <pbhagavatula@marvell.com>
> >
> > Since driver/common/cnxk has common code that is
> > used across multiple platforms, allow use of
> > GCC builtin atomic functions.
> >
> > Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
>=20
> Acked-by: Jerin Jacob <jerinj@marvell.com>

Applied, thanks.


