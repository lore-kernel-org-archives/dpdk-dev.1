Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA203C021B3
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 16:58:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4029F4064F;
	Thu, 20 Feb 2025 17:58:25 +0100 (CET)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by mails.dpdk.org (Postfix) with ESMTP id 8E7964065C
 for <dev@dpdk.org>; Thu, 20 Feb 2025 17:58:23 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.88.194])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4YzKB96ZgzzLr3Y;
 Fri, 21 Feb 2025 00:54:57 +0800 (CST)
Received: from kwepemf200007.china.huawei.com (unknown [7.202.181.233])
 by mail.maildlp.com (Postfix) with ESMTPS id 123D214034D;
 Fri, 21 Feb 2025 00:58:22 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 kwepemf200007.china.huawei.com (7.202.181.233) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 21 Feb 2025 00:58:20 +0800
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Thu, 20 Feb 2025 17:58:18 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "lihuisong (C)" <lihuisong@huawei.com>, "dev@dpdk.org" <dev@dpdk.org>,
 "thomas@monjalon.net" <thomas@monjalon.net>, "david.hunt@intel.com"
 <david.hunt@intel.com>, "anatoly.burakov@intel.com"
 <anatoly.burakov@intel.com>, "sivaprasad.tummala@amd.com"
 <sivaprasad.tummala@amd.com>, liuyonglong <liuyonglong@huawei.com>
Subject: RE: [PATCH] power: use hugepage memory for queue list entry structure
Thread-Topic: [PATCH] power: use hugepage memory for queue list entry structure
Thread-Index: AQHbUezKxRn4I6S/S0+UBKv0KpGojbNQN46AgAB4KgCAABe7sP//8ZoAgAAT57A=
Date: Thu, 20 Feb 2025 16:58:18 +0000
Message-ID: <534dac28376f4a88a846fbabf2e45b99@huawei.com>
References: <20241219075319.8874-1-lihuisong@huawei.com>
 <01d163c6-6d18-03e8-ac67-e7907d27bd08@huawei.com>
 <20250220081158.345f09b0@hermes.local>
 <295b2b64b39c4a61b76158e4ff474e40@huawei.com>
 <20250220084522.16c5930a@hermes.local>
In-Reply-To: <20250220084522.16c5930a@hermes.local>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.195.35.39]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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



> > > -----Original Message-----
> > > From: Stephen Hemminger <stephen@networkplumber.org>
> > > Sent: Thursday, February 20, 2025 4:12 PM
> > > To: lihuisong (C) <lihuisong@huawei.com>
> > > Cc: dev@dpdk.org; thomas@monjalon.net; david.hunt@intel.com; anatoly.=
burakov@intel.com; sivaprasad.tummala@amd.com;
> > > liuyonglong <liuyonglong@huawei.com>
> > > Subject: Re: [PATCH] power: use hugepage memory for queue list entry =
structure
> > >
> > > On Thu, 20 Feb 2025 17:01:53 +0800
> > > "lihuisong (C)" <lihuisong@huawei.com> wrote:
> > >
> > > > > The queue_list_entry structure data is used in rx_callback of io =
path
> > > > > when enable PMD Power Management. However its memory is currently=
 from
> > > > > normal heap memory. For better performance, use hugepage memory t=
o
> > > > > replace it.
> > > > >
> > > > > Signed-off-by: Huisong Li <lihuisong@huawei.com>
> > >
> > > How is that in a hot path where this could matter?
> >
> > AFAIU - it is used in RX/TX callbacks that power library installs,
> > so I presume will get hit on every eth_rx_burst/tx_burst calls.
> >
> > > The safety rails in rte_malloc() are much less than regular malloc().
> > > I prefer some degree of safety from checkers and malloc library inter=
nals.
> >
> > Didn't get your point - what's suddenly wrong with rte_malloc()?
>=20
> Coverity and Gcc analyzer treat malloc as special case.
> With attributes rte_malloc gets similar treatment but not quite as much.
> Also internally, malloc and free have more heap pool sanity checks.
> In name of performance, those don't exist in rte_malloc().
> Lastly hugepages are limited resource, so they should only be used when n=
eeded.

Ok, I understand all that, but what you suggest then - not use rte_malloc()=
 anywhere
In DPDK code, even when it is a hot-path?
