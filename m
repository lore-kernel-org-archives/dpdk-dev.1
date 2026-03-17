Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72158FED9EB
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Mar 2026 16:40:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CAC7A40650;
	Tue, 17 Mar 2026 17:40:09 +0100 (CET)
Received: from fhigh-b7-smtp.messagingengine.com
 (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
 by mails.dpdk.org (Postfix) with ESMTP id 2346140270;
 Tue, 17 Mar 2026 17:40:08 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 3D6297A0184;
 Tue, 17 Mar 2026 12:40:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Tue, 17 Mar 2026 12:40:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1773765607;
 x=1773852007; bh=qTN1ZAClFOJhnSDMIu3bqBPJ6+i9hr8/kt0EqWZsGV8=; b=
 MdEPAK6ZFp8LSIqSdByW9yeYtiJstK6727d/4EVIDeri+FM68is7zLO+5o2e+YBh
 90ygk6MnDATmvjKWOlnMuszJ61ef0JqloXoUYMQFCbzJOCZ963YIGJJpffXH7cLm
 FwXI3SjQxdks1e1GVDft0F5iXPXDwHm57Lvkp33bJpDNtH5lqqMFW/o4eSJ+jBMQ
 96MRT/cwu8zhMR+k4YKJ2IqzupojfpeLknkrrVNOmGMoDiblhnLprtub/Nfecqiu
 lcBuV9cr9YwZzFHoSaX7zEwjfOPKQ6qn0vECmMT5NtJcmT8mO9EdHZm3W7HMQYPA
 BmksKRvCh2QwMoI+1AuKlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773765607; x=
 1773852007; bh=qTN1ZAClFOJhnSDMIu3bqBPJ6+i9hr8/kt0EqWZsGV8=; b=b
 3QDB0K3PLoYoKlqC8VoAQUoxSHdn0WnjFUaE/9czCktABkkoc0FOWzENjFJtgjgz
 UvO+YxwZ+WcQdW92HkjQU0ipbeOYYOk938t4B6u7ZH6Aw7tzZn/hRhTCVkSLGuM8
 rGLC9Gg4eVqT0g/IZE86fQ958ILyXLn7h7h8nVfPb2eLG/PONVoAUpK5sUqHfyMV
 6OVvqmPsE+UpJQAu3U+s3Tv9PpzRsPyPXajYW3tQsza1GYP3CJeHUWblWPyHeNAl
 d6qjA/xosxE0rvDkHVV4qIX3KHRagfsHRRmOl9JuHYflPiE/hgtuXSyuyxJdRXqx
 yIgWiQJ9GENVRncWiNs9A==
X-ME-Sender: <xms:5oO5aYzwfHbDA55OYZqcyISLKrblBGGd77STD9M-smG0t8xGsCPBXw>
 <xme:5oO5aYQxGL2XMytiX8v84NYuNY1OzGgye1wNrExQAT5cT5LKdo3-dj1VpsodGhjap
 VK12DKz0j0HuhSuq8kWWBo0yc_Zh-Z396TDTm9lZjdSrsbOPN-upA>
X-ME-Received: <xmr:5oO5acj9POB49ay1CC2bWWMs0Nt6mwaheo6ltrJIF4rciHvVit--3f_kPVrunuAYVftVvUc40XvQI0LW7KavQ9eFtg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddujeeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeelpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehrkhhuughurhhumhgrlhhlrgesmhgrrh
 hvvghllhdrtghomhdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhm
 sggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhope
 hprgifvghlfihougesghhmrghilhdrtghomhdprhgtphhtthhopehprggslhhordguvgdr
 lhgrrhgrrdhguhgrrhgthhesihhnthgvlhdrtghomhdprhgtphhtthhopehjvghrihhnjh
 esmhgrrhhvvghllhdrtghomhdprhgtphhtthhopehnuggrsghilhhpuhhrrghmsehmrghr
 vhgvlhhlrdgtohhmpdhrtghpthhtohepshhtrggslhgvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:5oO5aXmeDd0QVg6XUgn2pBPXjZwVDuR_QGTPfp58LBRtEotNRtN-Ug>
 <xmx:5oO5aXsE1-d2ZM6zjlc_xW9AY52WKuWmX98mI87cIqgOLaGjAPx7OQ>
 <xmx:5oO5adYfhL3ZS1YJIw6HZ1-02SwWHajuHz6SDR1awLS0lwnESeO0LQ>
 <xmx:5oO5afABpNSRkhKJ2KGIhUITAJkWHQGKeveu7GHdn_pjAGqV_uct_Q>
 <xmx:54O5aRKbmoBl5KnQo4wloYu--1L3rdEGgUHnfgo2MNQpUZgkaH8p5DTC>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 12:40:04 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Rakesh Kudurumalla <rkudurumalla@marvell.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org,
 Pawel Wodkowski <pawelwod@gmail.com>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>,
 "dev@dpdk.org" <dev@dpdk.org>, Jerin Jacob <jerinj@marvell.com>,
 Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
 "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: [EXTERNAL] Re: [PATCH v6 1/1] examples/l2fwd-jobstats: fix timer
 stats display with lock contention
Date: Tue, 17 Mar 2026 17:40:02 +0100
Message-ID: <3342165.vfdyTQepKt@thomas>
In-Reply-To: <DM4PR18MB425513DE057FB7D2B68969F1CF40A@DM4PR18MB4255.namprd18.prod.outlook.com>
References: <20240811155957.576645-1-rkudurumalla@marvell.com>
 <20260302074804.40042d55@phoenix.local>
 <DM4PR18MB425513DE057FB7D2B68969F1CF40A@DM4PR18MB4255.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
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

16/03/2026 14:36, Rakesh Kudurumalla:
> Hi @Stephen Hemminger,
> 
> Yes, you're correct that the architecture looks unusual. But since the primary goal here is to stress-test the stats/timer subsystem under contention rather than packet forwarding, I believe the current structure serves its purpose well.
> 
> From: Stephen Hemminger <stephen@networkplumber.org>
> > > From: Rakesh Kudurumalla <rkudurumalla@marvell.com>
> > >
> > > Race condition between jobstats and time metrics for forwarding and
> > > flushing is maintained using spinlock.
> > > Timer metrics are not displayed properly due to the frequent
> > > unavailability of the lock.
> > >
> > > This patch fixes the issue by introducing a delay before acquiring the
> > > lock in the loop. This delay allows for better availability of the
> > > lock, ensuring that show_lcore_stats() can periodically update the
> > > statistics even when forwarding jobs are running.
> > >
> > > Fixes: 204896f8d66c ("examples/l2fwd-jobstats: add new example")
> > > Cc: stable@dpdk.org
> > >
> > > Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
> > 
> > This does fix the problem, but this whole application seems like it is using an
> > unusual architecture. The main loop per thread spends most of its time
> > updating job stats and only periodically calls the actual rx/tx burst forwarding.
> > That is upside down??

We can discuss the future of this example.
For now, the fix is applied, thanks.



