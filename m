Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E97EB26FE
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 18:56:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5DFF040648;
	Tue, 10 Feb 2026 19:56:53 +0100 (CET)
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mails.dpdk.org (Postfix) with ESMTP id 37BE7402CE
 for <dev@dpdk.org>; Tue, 10 Feb 2026 19:56:52 +0100 (CET)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailfout.stl.internal (Postfix) with ESMTP id BEFF71D00135;
 Tue, 10 Feb 2026 13:41:33 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-07.internal (MEProxy); Tue, 10 Feb 2026 13:41:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1770748893;
 x=1770835293; bh=JUmvZ0WkZX+7SMoCa8RFXm0R1CeQImllZ/M5gi4YyLU=; b=
 koaK+ct6jhtu5wLGQDJ4zzi15C7Ls46sHYSaxgy2m1wi9H/MDU1NjhKWhHcU3W2T
 j/bfabVLb1V3fk3On8RNz8oPu6P70PYfHzDmNGl/JPD94APpaF1VJJLtxvhjqHu6
 BMOv9uvxjG4R4QYUmXad2wdDVWceN34ZQJZf1DRNehN340m377SdILsYdJyu0wsq
 wn9YHDbIur91D2vp1wMuQhf24pCxhy63K0aTRu3hZUfZ7mVoenBeGTcWwbG6xENq
 ViUgNffRiUaIe0OHPkB2oQs8goDZyh99PNN9k5DW0R0DW0Nygi5bMs9BqCNG9oOt
 X3ZgSlPlUYYZIODrEMvbyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770748893; x=
 1770835293; bh=JUmvZ0WkZX+7SMoCa8RFXm0R1CeQImllZ/M5gi4YyLU=; b=U
 BbOSe9mY+kUb6zR99QyWeke6KVzcj1IeljZKrDsVEQhUGQogYthtEJkF3noXTFOT
 3m727WBW6a2nfFNUeW5aPiAcZFbtAjdaImU1+KCFFFmP6O04pCL5+96Nen0RTpmC
 1432/DgEFDRr9OHfJ82eWYYs909R7MEu5MGR3PpO46zCQYKVGUWbZEpNDxXb9na0
 AtJYeSYElFHOIifeq6j266DFHSOvGxiZkEfD27eW9uKBJklQ/uKaqnXeSdBBTXkL
 F0bUM5crBEPZ+ogU/9FUryTfBNviHtz22KRt7NrNwsBdAYbQ7fFzd2LQMHGqNEbV
 ZqztYW0Rx8SETbz/CCv2g==
X-ME-Sender: <xms:23uLaaL_Gz9XOT5yy6tYeK87BpepEGJJGciAZ6KL5DaKTmt-SUqSOg>
 <xme:23uLaWdPh8l5HLJX0BuTdyEheJfRSc0MrCLH60XJ3cDFNkHqmohkClIyzNRH6yXiv
 i1FaYTmEErP51LtHOiRTttlmczVzJoPPyUK-oIfmRNvvO1JhAJG>
X-ME-Received: <xmr:23uLaZ0LfMA5rxqBwUR-9ApxVaKv3Z6_OllI-_BH-1L7ydO61bS1hkA5nm0oY4_vQToKN300nNVrMNua9LBBH11Dfg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddtgedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsphhinhhlvghrsegtvghsnhgvthdrtg
 iipdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepshhtvghphhgv
 nhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhg
X-ME-Proxy: <xmx:23uLaXj3zfM4xX-Id8oxU0bqlAumz0Y-q-M9JJKNlXFDl2yRCSCnnA>
 <xmx:23uLaXQ2JkJNzOJ9axP-7emItOQ11_m1-u__L6kIiZIhz7Ni1q3l2w>
 <xmx:23uLaQjr6zK2nMq1PHHeI1F6jLEVM2kHJdxG-G6nMfP3W2J16l8kvg>
 <xmx:23uLaf69XamHl9RfNWI8QfXoSVLCdA0wZiWOtIACZHHipdQetvJYbA>
 <xmx:3XuLaT-HjtyUDNgYvs_acB0KB53bK6841Y_MgvWlap_xoobaI5gA25km>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Feb 2026 13:41:30 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Martin =?UTF-8?B?xaBwaW5sZXI=?= <spinler@cesnet.cz>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH v2] doc/nfb: update release notes for nfb driver
Date: Tue, 10 Feb 2026 19:41:29 +0100
Message-ID: <11326201.CDJkKcVGEf@thomas>
In-Reply-To: <20260202121743.53ad004e@phoenix.local>
References: <20260202151521.3245438-1-spinler@cesnet.cz>
 <811bfe37111be369a9aba35c49d705fd74f4ea54.camel@cesnet.cz>
 <20260202121743.53ad004e@phoenix.local>
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

02/02/2026 21:17, Stephen Hemminger:
> On Mon, 02 Feb 2026 21:14:58 +0100
> Martin =C5=A0pinler <spinler@cesnet.cz> wrote:
>=20
> > On Mon, 2026-02-02 at 21:12 +0100, spinler@cesnet.cz wrote:
> > > Update the release notes for the NFB driver
> > > with the timestamp value changes. =20
> >=20
> > This release notes update should have been in series-37064 ("net/nfb:
> > code cleanup").
> > (And certainly not in "net/nfb: rework to real multiport" series, as
> > you pointed right).
> >=20
> > But as the "net/nfb: code cleanup" was already nearly upstreamed, I
> > didn't dare to modify them with this patch.
>=20
> No worries. As long as the total version has the right release notes.
> I don't worry too much about getting the release note exactly matched
> with the patch.

I prefer to have it in the same patch so I squash it when pulling in main.



