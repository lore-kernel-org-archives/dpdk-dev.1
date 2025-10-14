Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F09BCCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 09:55:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78FD4402AE;
	Tue, 14 Oct 2025 11:55:19 +0200 (CEST)
Received: from fhigh-a8-smtp.messagingengine.com
 (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
 by mails.dpdk.org (Postfix) with ESMTP id AF577402A8
 for <dev@dpdk.org>; Tue, 14 Oct 2025 11:55:17 +0200 (CEST)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 52A9614001DD;
 Tue, 14 Oct 2025 05:55:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Tue, 14 Oct 2025 05:55:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760435717;
 x=1760522117; bh=agSGWA5ItL5V1YQfjpOrH/8OHG0P4s2fEQtJBEVzrmU=; b=
 Foh9lm0A8wIkL7qKO6XWbsOjmMdz9jhZ5qz/fAKk9CyTsEIHyl10HIwRyXfadVwV
 t9Thy6DLW0iNXDbXj0nk83iClR3+1srh27Kq5geVBvRQ2DhO+RNNn4mMrOR7Txm6
 tMoK9hcSuCxBOVvMF2Gvfk3SKzffTKINC0nOOt3lco0Cn97xKa1xRKfx93pKIKdh
 39Q3fvl4DFklZyTvPzAA6zh3znztvOcZMMpI0GYrzvSigUvqz6Gxa+WRbjei887H
 vqm8Gq2EJLGtTyy/tYMAK4Tv9j7sLKi/DasS0d0luWle/Tx/eZQwz76G8KK64YEH
 vxWpghw+YK6meliBGbVpzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760435717; x=
 1760522117; bh=agSGWA5ItL5V1YQfjpOrH/8OHG0P4s2fEQtJBEVzrmU=; b=a
 Cmblzlj53syFu+mrsYgCby6t+scJrJRL8p1Bsupux08HVEi9YKA9g5stNRB13lgu
 XtAGaLZ0ZtFbHL36LEMjbo0QSscZSa3ytJylNAUj+BLY1KCn34wnQhTPri16QO0i
 sBhJkVus8w+2s2TwUtqDXt+GIaFukDmEDYkMcdD5L2Hl6Fo8QnzY3Dx2VTz6koTN
 0J36Nnw2q9PjlflGFgFFBn8ebqpAf0wUxx+wWoK7tuM6Higa1RmAXxBQlTiFyXuf
 Y26SQ0DrDZXDdoCZvc2FnAJurhFO2cFptDCtOwCnN2iST0ElVtybmBwa/v2p2WUe
 sGZS//aPdH5zZ0+S0SpmQ==
X-ME-Sender: <xms:BB7uaGukXToD6Dp4hVACsV4kJfsW8qmOEqxWi5mYQIefQjDFti2xtQ>
 <xme:BB7uaGZCa-ceEU3sU89aoxHf9WoP4weK18WRYGLCf2Ye-nU6IvbEqoCiW63PF5mPI
 -BeBGcKL6TiF2LMBhE1Bg5Q_wj1bJVpPzWUG0jSeL2ZBrLmojg>
X-ME-Received: <xmr:BB7uaAxgY55icOBtZQpOLZXVuV1Hq4in21fmVVIAvY55JY8ZWTZ4jfBn8IGjJDTMwzyJbzG9DyMUk8hOoXhHO18vsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddtvddvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeejpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonh
 esihhnthgvlhdrtghomhdprhgtphhtthhopehmsgesshhmrghrthhshhgrrhgvshihshht
 vghmshdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhope
 hshhhpvghrvghtiiesnhhvihguihgrrdgtohhmpdhrtghpthhtohepvhhirggthhgvshhl
 rghvohesnhhvihguihgrrdgtohhmpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifoh
 hrkhhplhhumhgsvghrrdhorhhgpdhrtghpthhtoheprghmrghnrdguvggvphdrshhinhhg
 hhesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:BB7uaGixeKq3UuWSbGjei3tUqvJUF-tgNfLTT_Ty1VDemc7kOx59QA>
 <xmx:BB7uaEnV6qujGS3LaS8Xhotx6FVtDml6Z4YGKNq0Gd5aYLKH0kqUmA>
 <xmx:BB7uaEjUl6ouYnMwN3JmnG_hMrV9-yKJh3JP32mlIyTQGjAxbmZm1Q>
 <xmx:BB7uaA3ncnWOZfuF0Ptd1pfpnBZLwCbGxigZCbWy_LT8zrFbiuGkhw>
 <xmx:BR7uaBV9vhNGQYAOZiXmHuaHSKFFSsQ5DUSgpN2CLu1d2VXXj6wRj3sJ>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 05:55:15 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>, dev@dpdk.org, 
 shperetz@nvidia.com, viacheslavo@nvidia.com, stephen@networkplumber.org,
 Aman Singh <aman.deep.singh@intel.com>
Subject: Re: [PATCH v5 6/7] app/testpmd: add commands to dump mbuf history
Date: Tue, 14 Oct 2025 11:55:14 +0200
Message-ID: <2416987.8hzESeGDPO@thomas>
In-Reply-To: <aO4cewme2ItIYMPV@bricha3-mobl1.ger.corp.intel.com>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <3472245.88bMQJbFj6@thomas>
 <aO4cewme2ItIYMPV@bricha3-mobl1.ger.corp.intel.com>
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

14/10/2025 11:48, Bruce Richardson:
> On Tue, Oct 14, 2025 at 11:43:28AM +0200, Thomas Monjalon wrote:
> > 14/10/2025 10:45, Morten Br=C3=B8rup:
> > > > From: Thomas Monjalon [mailto:thomas@monjalon.net]
> > > > Sent: Tuesday, 14 October 2025 08.59
> > > >=20
> > > > Dump the mbuf history to the console or to a file.
> > > >=20
> > > > The dump will contain:
> > > > - Operation history for each mbuf
> > > > - Summary and statistics about all mbufs
> > > >=20
> > > > Dump the history of all mbufs:
> > > > 	testpmd> dump mbuf history all [file]
> > > >=20
> > > > Dump the history of one mbuf pool:
> > > > 	testpmd> dump mbuf history mempool <mp_name> [file]
> > > >=20
> > > > Dump the history of one mbuf:
> > > > 	testpmd> dump mbuf history one <mbuf_addr> [file]
> > >=20
> > > The "one" seems superfluous. I think this would suffice:
> > > 	testpmd> dump mbuf history <mbuf_addr> [file]
> >=20
> > It's not superfluous :)
> > Without it, the cmdline library cannot distinguish easily
> > between
> > 	dump mbuf history <mbuf_addr> [file]
> > and
> > 	dump mbuf history mempool <mp_name>
> >=20
> The latter might read better as "dump mbuf pool history <mp_name>", which
> would also resolve the ambiguity.

I'll try that.

> Even without cmdline lib resolving the ambiguity, it should be easy enough
> for the cmdline callback to do strcmp() on the 4th parameter to check if
> it's the string "mempool" and then direct appropriately.

It is already doing strcmp(), but first, cmdline parsing must not be ambigu=
ous.


