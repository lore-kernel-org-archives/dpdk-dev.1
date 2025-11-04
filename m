Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7684ACCFA00
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 08:18:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B89184028C;
	Tue,  4 Nov 2025 09:18:53 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id D1D3B40285
 for <dev@dpdk.org>; Tue,  4 Nov 2025 09:18:52 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d11Yg6dgFzJ46BK;
 Tue,  4 Nov 2025 16:18:31 +0800 (CST)
Received: from dubpeml100002.china.huawei.com (unknown [7.214.144.156])
 by mail.maildlp.com (Postfix) with ESMTPS id 23221140275;
 Tue,  4 Nov 2025 16:18:51 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100002.china.huawei.com (7.214.144.156) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 4 Nov 2025 08:18:50 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Tue, 4 Nov 2025 08:18:50 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Wathsala Vithanage <wathsala.vithanage@arm.com>, Honnappa Nagarahalli
 <honnappa.nagarahalli@arm.com>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>, "dev@dpdk.org" <dev@dpdk.org>, Ola Liljedahl
 <ola.liljedahl@arm.com>, "vattunuru@marvell.com" <vattunuru@marvell.com>
Subject: RE: [PATCH 1/1] eal: correct memory ordering in MCS lock
Thread-Topic: [PATCH 1/1] eal: correct memory ordering in MCS lock
Thread-Index: AQHcRE2WHhnnI3qNXUmQEzir4eowobThH/qAgAAgCICAAAZ5gIAACaJwgAAMDICAAOD+MA==
Date: Tue, 4 Nov 2025 08:18:50 +0000
Message-ID: <9a7a720e91f546879368a0ed83dd7224@huawei.com>
References: <20251023184724.1759497-1-wathsala.vithanage@arm.com>
 <f08a5a55-2a46-4f8c-9658-f7c320de57f2@arm.com>
 <20251103090717.2d181d95@phoenix>
 <b435dd1d-c56f-4d56-9f73-30ee1ec99eac@arm.com>
 <d63bc45cb32848299574333fed5e5406@huawei.com>
 <20251103104803.30464227@phoenix>
In-Reply-To: <20251103104803.30464227@phoenix>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.156.162]
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



> On Mon, 3 Nov 2025 18:06:05 +0000
> Konstantin Ananyev <konstantin.ananyev@huawei.com> wrote:
>=20
> > >
> > > On 11/3/25 11:07, Stephen Hemminger wrote:
> > > > On Mon, 3 Nov 2025 09:12:39 -0600
> > > > Wathsala Vithanage <wathsala.vithanage@arm.com> wrote:
> > > >
> > > >> MCS lock is broken, it's just a matter of time it will run into a =
deadlock.
> > > >>
> > > >> drivers/dma/cnxk is a user of MCS lock.
> > > > I am surprised that a driver would use mcslock.
> > > > MCSlock is targeted at case of large number of CPU's with lots of
> contention.
> > > > It will likely be slower than spinlock or ticketlock for the use ca=
se of driver.
> > > It appears in |drivers/dma/cnxk/cnxk_dmadev_fp.c|, perhaps the
> > > maintainer can clarify.
> > >
> >
> > If MCS lock is really broken, it needs to be fixed anyway.
> > It might be used by other third-party libs/apps that do use on DPDK.
>=20
> 100% agree it must be fixed.
> It would be good to have test or static analysis tool that could validate=
 all the lock
> types.

+1
Another option would be to have sort of stress test for all locking types w=
e have in our UT.
At least for ring I found it very useful.

