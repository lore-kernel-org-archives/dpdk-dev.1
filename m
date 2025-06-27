Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065ABC77B7F
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 10:19:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 038BA4026B;
	Fri, 27 Jun 2025 12:19:19 +0200 (CEST)
Received: from fhigh-b8-smtp.messagingengine.com
 (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
 by mails.dpdk.org (Postfix) with ESMTP id 5D8DF4025D
 for <dev@dpdk.org>; Fri, 27 Jun 2025 12:19:17 +0200 (CEST)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal
 [10.202.2.51])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 8DD877A019F;
 Fri, 27 Jun 2025 06:19:16 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Fri, 27 Jun 2025 06:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1751019556;
 x=1751105956; bh=rEf/ZfTnrKThZ5mgnyCCRxNXaEFx/CDEHtJl9yXHyq0=; b=
 DWF58wSpG8CUYYim1pb85Ug57d5WWATxP5sOd0zqNuyNpKd3Nb0E7YtnuUTr9uos
 I8OOAGvpzLJGHCTU0WTAYr5ZYwFKpHSUqJ0nnggSeinUCNke5bAss9EU2c+gt799
 nOSO8SPKQedTouxY9+Pwmn19ZpUWHtdefBVm7O1E8lV9xPndfaL4uHxVAR0t9J4e
 eByCGb52DP4RfgP/mXPAcO5mXHuB4GrbIhsUNGD5v/Z20KQ79Myn9gLV4wOHUYCt
 0SGPVJjz+wWIRh3ChARdxj9vLHcitFWXR+ieC0ww/0sV095U0gkFUoOcAfOZeDCO
 O7CudyoAdY2eavYGjfRyGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751019556; x=
 1751105956; bh=rEf/ZfTnrKThZ5mgnyCCRxNXaEFx/CDEHtJl9yXHyq0=; b=d
 Hx4ixCivt6My11fzP3Sri1iEkJs9GTbkG0OwENn2/6L94GfwN624vIbO2Vwbblm7
 rzFRzTlnFUXC64ZbqdcHpAs3FwWRFtqHoYFSSozq8aKkz29LvyNrrMeFtMQF/NK7
 1IaHNYwWNqOf+HGcvCQntTrlTTkzsq/ZW7XqRRRxhxbbgx/o6dBybUDSVBdD3VXi
 piOD72MxC73hA8N1LEcXdRjv2eKuaIJGDvC8QZVqOQJv2rouJB1s4CEmo2LZ8JFI
 SrdmG0/s250TGlHoBJfOuV+W9Rz423PQ0Z8lBu9JldcWooP6fjg8bz0bITLyiKs1
 rWjtBv3bNAa4fmS4gDSMw==
X-ME-Sender: <xms:JHBeaIoJru8tJIF9hvf4F6R5EUTr89bUvE9Os1UsgEeEnv-RCi86Fw>
 <xme:JHBeaOon2igqPvc8Av9oQgwmJp6ny77Ebw2lwiey6GX4p17wkjqlUNNwIJC3uEVhW
 -jjRPHRwymEKL9b_A>
X-ME-Received: <xmr:JHBeaNOS1xNPJKALTzooGKLerlNuLCifmK__Q_1XS3woKsZr3HKr9AtQ6ha7OyOduCcpq55D2CQ49bZ3E1MpjCq9Tg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvkedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
 ephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghsucfo
 ohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrg
 htthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddvleev
 jeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeegpdhmohgu
 vgepshhmthhpohhuthdprhgtphhtthhopegrnhgurhgvmhhuvgeslhhinhhugidrmhhitg
 hrohhsohhfthdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphht
 thhopegumhhithhrhidrkhhoiihlihhukhesghhmrghilhdrtghomhdprhgtphhtthhope
 hrohhrvghtiihlrgeslhhinhhugidrmhhitghrohhsohhfthdrtghomh
X-ME-Proxy: <xmx:JHBeaP6BGrr22FcRL6ILnHaGue-OF0mGbxlABUCGPlqUC2Bo5UmSDw>
 <xmx:JHBeaH5Rf2QYym4s66G45FxNTf-HFjdLxE3r_lRR4O6we4miivA-6w>
 <xmx:JHBeaPiCexIb-AMh8OGanBB0sBGLt3pW0GchjTpjZ5HimxbyQIXeHQ>
 <xmx:JHBeaB4lfxVQI8aqiSLOzUXAHRvUOEQ2JuuKMvubFEPf_VunXtjilA>
 <xmx:JHBeaAQmM4HcAsrHJC7U0M-lsLJkiF9KCwm9VEmD8AfJPBo_lmevHrMp>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Jun 2025 06:19:15 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org, Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: Re: [PATCH] eal: add asprintf() function for Windows
Date: Fri, 27 Jun 2025 12:19:13 +0200
Message-ID: <5542814.uBEoKPz9u1@thomas>
In-Reply-To: <20250612144648.GB3279@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1746495789-14101-1-git-send-email-andremue@linux.microsoft.com>
 <7942373.1B3tZ46Xf9@thomas>
 <20250612144648.GB3279@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
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

12/06/2025 16:46, Andre Muezerie:
> On Thu, Jun 12, 2025 at 02:41:05AM +0200, Thomas Monjalon wrote:
> > 06/05/2025 03:43, Andre Muezerie:
> > > The asprintf function is not part of the C standard library but is a
> > > GNU extension commonly available in Unix-like systems. It dynamically
> > > allocates memory to store the formatted output string, similar to
> > > sprintf, but avoids buffer overflow issues by automatically sizing
> > > the buffer.
> > >=20
> > > Instead of rewriting it or coming up with some other replacement, this
> > > patch makes use of the implementation provided by Neved4.
> >=20
> > Why not using eal_asprintf()?
> >=20
>=20
> There are many calls being made directly to asprintf() which made me
> believe there wasn=E2=80=99t an equivalent available for Windows yet.
>=20
> Thanks for pointing out that is not the case.
>=20
> I=E2=80=99ll make the necessary changes to call eal_asprintf() instead.

Thanks to the define in lib/eal/common/eal_private.h,
asprintf should automatically call eal_asprintf on Windows.



