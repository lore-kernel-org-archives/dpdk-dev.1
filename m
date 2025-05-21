Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157E3C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 07:00:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 293EE40ECF;
	Wed, 21 May 2025 09:00:53 +0200 (CEST)
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mails.dpdk.org (Postfix) with ESMTP id 88B6E40EA5
 for <dev@dpdk.org>; Wed, 21 May 2025 09:00:52 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal
 [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id C12D61140134;
 Wed, 21 May 2025 03:00:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Wed, 21 May 2025 03:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1747810851;
 x=1747897251; bh=Puiq2ovVhGrCxNli+/l/FwggXjROZ+ABt18lPOguUs8=; b=
 GILYb5g90Vilrr+6zrgO2GpX89F2q37AoNpnu1gjAz+2Cp5XmsEU3TNaSMUC6VRr
 vHpfjiKoKqskfryZYMKuvJF7eKxcmzHmEQjchQoqsd0ZUefk9yDi8knLS4ahk4De
 8nAP9KNAOk/zLM44WbaR8XfEiiboVdlMPisLkxpzc7Wq2qRIBKd/H5LhMxGbkIjI
 213av19tjhbA3ULd4IrG8fYTwemolKOwYbUu/MGb3lByIlsS5+IYvAJKUAuLEXx+
 EkdV+RC8wkML8YpxORXHP2s3yM6n6U6kToDYrOXkBvEgd6AnRwn7R3KNBRdid1NS
 X+Sc2aUEGhc0ZnC0b8Pedw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747810851; x=
 1747897251; bh=Puiq2ovVhGrCxNli+/l/FwggXjROZ+ABt18lPOguUs8=; b=n
 9BYqcJuUa04qtuqW/AUXkgBftzptwv2UokVndFyraPn2RNIJX02Fd74VkPjgAU6p
 MBACIH/tsQAqmpFd6+wB4YkGFSEZ9sh4Yi/+xgwVvpj7P7VZ7KY7siBQwI8Q5XkL
 X+0bGQC8xfz07vijcQOn4AMOi0//dnKEMAM17VV7R2gw2RVpv5IDGQ2austM/rwQ
 DcHJaJNallK0zgO207qzr6ScyWWaB4HLIPGlPY5LB8oerKuXqjfK+TXFOM1RmiR5
 MntYSYbWv568ioh3VQRBjuoU5USfIv+HHpeF3rd2pdBc4RS9IlyteK6OggIL6Zed
 t1HUsxFBBCZf0le9h5INw==
X-ME-Sender: <xms:I3otaHFAkgbGvgPboH2rpJXcjowdr_U9oUb-9IsbHMIIsIVXntlY0w>
 <xme:I3otaEUSTeAjEZTm2LWxHSAIRQqA5TbWKs78zqLMlwqlAAU-hI7g_MGedAyWkoFpI
 MV_4U_Uzcy_ySMnhg>
X-ME-Received: <xmr:I3otaJIdN2RPEZuDVfvuDWIzu0yEC-ATA9M59crvNNklsu-5HBbVg7mKsNamhvd5IpkKlIlJueN1ROs7CWrmBV1K1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvgeefucdltddurdegfedvrddttd
 dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
 nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
 enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghf
 ggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoe
 hthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudev
 heeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhush
 htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhho
 nhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuth
 dprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdp
 rhgtphhtthhopegrnhgurhgvmhhuvgeslhhinhhugidrmhhitghrohhsohhfthdrtghomh
 dprhgtphhtthhopegumhhithhrhidrkhhoiihlihhukhesghhmrghilhdrtghomhdprhgt
 phhtthhopehrohhrvghtiihlrgeslhhinhhugidrmhhitghrohhsohhfthdrtghomhdprh
 gtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:I3otaFEvhFNV8YZCazZU2f-sJqifFunKbwVavFqYwrrMa2LZ1QGLUg>
 <xmx:I3otaNWvumrQmYlGZBowg0aITKC1jZQ8PDZD2feyCdCnWgZNbc2hfg>
 <xmx:I3otaAPYuHqixq_BaLq9mZv2TKHRPw7wRU65EOYpcc5GJoT0Wwbhbg>
 <xmx:I3otaM08KII4Vu9d84rhjNRu8URhObpTDu-SS5krThL696RIHU8tgA>
 <xmx:I3otaPX3gZXuyzZv6NgoqYaSbTwjfGZ2KyLkAy3GomM9OXa1BoG3yIp5>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 May 2025 03:00:50 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>,
 Andre Muezerie <andremue@linux.microsoft.com>
Cc: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>, dev@dpdk.org
Subject: Re: [PATCH] eal: add getline() function for Windows
Date: Wed, 21 May 2025 09:00:48 +0200
Message-ID: <2358541.72vocr9iq0@thomas>
In-Reply-To: <20250521003517.GA9927@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1746477607-14961-1-git-send-email-andremue@linux.microsoft.com>
 <20250520101433.3a264cb1@hermes.local>
 <20250521003517.GA9927@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
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

21/05/2025 02:35, Andre Muezerie:
> On Tue, May 20, 2025 at 10:14:33AM -0700, Stephen Hemminger wrote:
> > On Mon,  5 May 2025 13:40:07 -0700
> > Andre Muezerie <andremue@linux.microsoft.com> wrote:
> > 
> > > Existing DPDK code uses getline(), which is a POSIX function and is
> > > not available in the Windows APIs.
> > > 
> > > Instead of rewriting it or coming up with some other replacement, this
> > > patch makes use of the implementation provided by NetBSD to make it
> > > possible to compile code dependent on getline on Windows.
> > > 
> > > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> > 
> > Not sure, are BSD-2 and BSD-3 compatible?
> > Getting license exception approved requires going through the governing board
> > which can take up to 6 months.
> 
> Hi Stephen, I would appreciate some guidance here.
> 
> My understanding is that in general, BSD-2 licensed code can be used in BSD-3
> licensed projects, as long as the BSD-2 license is retained in the original
>  (BSD-2) files.
> 
> I do see that BSD-2 was listed in the exception table (for getopt function). It's
> not clear to me why it needed to be listed as an exception, but if that was
> needed, it indicates that the same should be done for getline(). Is that not
> the case?

No matter the compatibility agreed or not in courts,
if the licence is different we note it as an exception,
so it is crystal clear for users of DPDK.
We don't want to have any surprise and we avoid exceptions,
that's why the Governing Board has to accept it.


