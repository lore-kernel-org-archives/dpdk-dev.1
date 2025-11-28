Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B669CCFD376
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Nov 2025 10:17:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 866874013F;
	Fri, 28 Nov 2025 11:17:29 +0100 (CET)
Received: from fhigh-a5-smtp.messagingengine.com
 (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
 by mails.dpdk.org (Postfix) with ESMTP id 72110400EF;
 Fri, 28 Nov 2025 11:17:28 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id C798E1400097;
 Fri, 28 Nov 2025 05:17:27 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Fri, 28 Nov 2025 05:17:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1764325047;
 x=1764411447; bh=P8Nn6dW8MLYkUvq9LBrGqXOuk7h8nqVxLkJfWiApxPc=; b=
 f/tKN5+IjjBzlcRGDosQDKJLNNsdr/oZ1fid/63sDYSXGjLCJa0JjWEoKTE+X3Uw
 1HwJBRnDfg/eSn1hzzboE6MQQk+xnJl56v6+SxfiJJUa1ub6BGlOvRqSyP0YLMwg
 hnvK0P21H4VcqIzidQ913ihBEBqhYONMGFY0paUnMoJiRakFWD6mlNzwX02CJqP6
 w9XEszwEwFi3Yx/ilpAJ/Wg2yIxVp1xsbqj5RQQoHIueG0whvlZf+EVKloX4IfoV
 CvoW+2upuaXC1z8VHdD1ewarfWL4S08r1DvXOCAoERPthUzY8/UUWE1hzlp/oG81
 lasASImnJld27NbQvURjfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764325047; x=
 1764411447; bh=P8Nn6dW8MLYkUvq9LBrGqXOuk7h8nqVxLkJfWiApxPc=; b=o
 brkNbg/iaKj4VV/aqtJIaQInVrHbUTEtJgQykp9fCC4ppuiRtW9lHPpgwHww6GNO
 UuetsxJb1Q0evN1iSPTkDdmi3VGgydlMQ2ltA/xxvD6kHEwZHlbgXDewbbmTTF4K
 JGNKQ/+pY3YYORt3RtFLoFgZszEI4r37KREq9bJBPue2LU4CDYBRgjyeDToHBXXP
 3cn0DMahD4pirTyaiGuffMDx9L43DCs/MQelh9BroECsMHGE1QggAsQo+ybLtOCv
 +T1+MNBtDmbsv06W2uWXTxoXV3MiaIfWox3c7J+ZPNL/KL/dx4oP471YXxKF6fOu
 aF5NP0/zkKzzRdJq4+XFw==
X-ME-Sender: <xms:t3YpadbjOU6WH9COgkI7sQ6t0F-9rCI9RrBf9Ufxd0lS1DVdy-5CZw>
 <xme:t3Ypaaa9osep2ph-w7k2pBSppDdoYsK0McSK1SIliDjYBztQZM4xb6UG6E2P22bnh
 GTcNpiDcohC_ce7j_zY9UAuUH3TtrlWRaxiRGiTgstI55jYLi1zbQ>
X-ME-Received: <xmr:t3YpaaxMdpPBit7US5sudaNlfv-ZsyctCMQBt234unL5Jf1j46aegKxGQUPyScttfqL9HwLBbuHMdVden4ZPXIlecQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeelieduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeduuddp
 mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgshhgrghgrvhgrthhulhgrsehmrg
 hrvhgvlhhlrdgtohhmpdhrtghpthhtohepjhgvrhhinhhjsehmrghrvhgvlhhlrdgtohhm
 pdhrtghpthhtohepshhthhhothhtohhnsehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtoh
 epnhgurggsihhlphhurhgrmhesmhgrrhhvvghllhdrtghomhdprhgtphhtthhopehkihhr
 rghnkhhumhgrrhhksehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtohepshhkohhrihesmh
 grrhhvvghllhdrtghomhdprhgtphhtthhopehskhhothgvshhhfigrrhesmhgrrhhvvghl
 lhdrtghomhdprhgtphhtthhopehhkhgrlhhrrgesmhgrrhhvvghllhdrtghomhdprhgtph
 htthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:t3Ypaec9Q6uQ6NOHzJjkVWNfwwsccXTNxwKI6cr7sPrqgew_maPMZA>
 <xmx:t3YpaX6nrUHJabbTdwF-qcPPtBzuFHPzeRh5ycKGCayMzmuwJx8ufQ>
 <xmx:t3YpabIKDArJyWdpVSrCVzVx0wX77DmiiGgjYIk_XPe9ffZAJ7vnzA>
 <xmx:t3YpaXy9IkiUxxmvwJ6IUuxmYG5ZuqIWoj8XzfZ0L-i1Aror4XpIxQ>
 <xmx:t3YpaSdF9xg5XalnF5JjvgN6d7QBfZLNForNPY-j9ExIszxPcqaQV9o1>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Nov 2025 05:17:25 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: pbhagavatula@marvell.com
Cc: jerinj@marvell.com, Shijith Thotton <sthotton@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>, dev@dpdk.org, stable@dpdk.org,
 Jerin Jacob <jerinjacobk@gmail.com>
Subject: Re: [PATCH v4] event/cnxk: fix offload flags
Date: Fri, 28 Nov 2025 11:17:24 +0100
Message-ID: <3058944.irdbgypaU6@thomas>
In-Reply-To: <CALBAE1MTGzQabVmqoFGWkEzZ_tyH4md4ocEsPzqKrav8a3rMtA@mail.gmail.com>
References: <20251126081353.85811-1-pbhagavatula@marvell.com>
 <CALBAE1NMMTEDykgdJ7vC4GdXcXm64ask-iHbAJZA5grGmfPYHg@mail.gmail.com>
 <CALBAE1MTGzQabVmqoFGWkEzZ_tyH4md4ocEsPzqKrav8a3rMtA@mail.gmail.com>
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

27/11/2025 05:49, Jerin Jacob:
> On Thu, Nov 27, 2025 at 10:17=E2=80=AFAM Jerin Jacob <jerinjacobk@gmail.c=
om> wrote:
> >
> > On Wed, Nov 26, 2025 at 9:41=E2=80=AFPM <pbhagavatula@marvell.com> wrot=
e:
> > >
> > > From: Pavan Nikhilesh <pbhagavatula@marvell.com>
> > >
> > > Use device configured Rx offloads instead of hardcoded values while
> > > draining work.
> > >
> > > Fixes: e8594de2731d ("event/cnxk: implement event port quiesce functi=
on")
> > > Cc: stable@dpdk.org
> > >
> > > Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
> >
> > Acked-by: Jerin Jacob <jerinj@marvell.com>
>=20
> @Thomas Monjalon  Please merge this patch in this release.

Applied, thanks.



