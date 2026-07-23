Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF566C531D4
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 14:46:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0292E40679;
	Thu, 23 Jul 2026 16:46:27 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id D04C740663
 for <dev@dpdk.org>; Thu, 23 Jul 2026 16:46:25 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=/hW5uqtokiE8NbmYREz1N7x802c9jS4eSPetmdKZbvw=;
 b=voqVwdWxt+GTo6pxKlB4H0r2D5KD0OgwTviZVi5hlBuAPX5KbdAm+0K9Cg4QWqwR/9rUrV9HH
 PQSj3jG5kvjXzlnTzULaeNTsNma/2rT5SVWSkugQ/IPqa8MohfZ9Tz4+3k2Z5E1EcNkpn1WQIE8
 XvgMLMdOc55mU6wD6mJ+Uxc=
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4h5Yp573y0zHnH5X;
 Thu, 23 Jul 2026 22:45:49 +0800 (CST)
Received: from frapema100003.china.huawei.com (unknown [7.182.19.100])
 by mail.maildlp.com (Postfix) with ESMTPS id 622D040572;
 Thu, 23 Jul 2026 22:46:18 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100003.china.huawei.com (7.182.19.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 23 Jul 2026 16:46:18 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Thu, 23 Jul 2026 16:46:18 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Bruce Richardson <bruce.richardson@intel.com>
CC: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>, 
 "hkalra@marvell.com" <hkalra@marvell.com>, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Tetsuya Mukawa <mtetsuyah@gmail.com>
Subject: RE: [RFC 1/4] bus/pci: fix check on interrupt FD for FreeBSD
Thread-Topic: [RFC 1/4] bus/pci: fix check on interrupt FD for FreeBSD
Thread-Index: AQHdGqXwz3+f4lLLh0yaREbwkur6jbZ6+WuAgAAFSICAACdO0P//5SYAgAAjMaA=
Date: Thu, 23 Jul 2026 14:46:18 +0000
Message-ID: <d2f14b3b10974c03b38ba4e1bc88ff39@huawei.com>
References: <20260723131908.3313223-1-david.marchand@redhat.com>
 <20260723131908.3313223-2-david.marchand@redhat.com>
 <amIYn1U_a0WmjMSs@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8wqcNPWffRmFLcUNcSL4KD3T0v5v-kjLX886BqFiV4XWQ@mail.gmail.com>
 <1ece3c764a64471ab966dd324bc19d76@huawei.com>
 <amIngBPWflvFJeY6@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <amIngBPWflvFJeY6@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.78]
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

> -----Original Message-----
> From: Bruce Richardson <bruce.richardson@intel.com>
> Sent: Thursday 23 July 2026 15:39
> To: Marat Khalili <marat.khalili@huawei.com>
> Cc: David Marchand <david.marchand@redhat.com>; dev@dpdk.org; hkalra@marv=
ell.com; Chenbo Xia
> <chenbox@nvidia.com>; Nipun Gupta <nipun.gupta@amd.com>; Tetsuya Mukawa <=
mtetsuyah@gmail.com>
> Subject: Re: [RFC 1/4] bus/pci: fix check on interrupt FD for FreeBSD
>=20
> On Thu, Jul 23, 2026 at 02:31:23PM +0000, Marat Khalili wrote:
> > > > > --- a/drivers/bus/pci/bsd/pci.c
> > > > > +++ b/drivers/bus/pci/bsd/pci.c
> > > > > @@ -93,7 +93,7 @@ pci_uio_free_resource(struct rte_pci_device *de=
v,
> > > > >  {
> > > > >       rte_free(uio_res);
> > > > >
> > > > > -     if (rte_intr_fd_get(dev->intr_handle)) {
> > > > > +     if (rte_intr_fd_get(dev->intr_handle) >=3D 0) {
> > > > >               close(rte_intr_fd_get(dev->intr_handle));
> > > > >               rte_intr_fd_set(dev->intr_handle, -1);
> > > > >               rte_intr_type_set(dev->intr_handle, RTE_INTR_HANDLE=
_UNKNOWN);
> > > >
> > > > Unlikely that we actually have fd as 0 for this call, but change is
> > > > technically correct.
> > >
> > > Yes, this is why I did not Cc: stable.
> > > Thanks.
> >
> > Just trying to understand what's going on here out of curiosity.
> >
> > Zero fd is valid and negative (typically -1) indicating error is a stan=
dard
> > logic in Linux, but here intr_handle->fd is zero-filled by
> > rte_intr_instance_alloc, so its initial state is 0 instead of -1. Do we=
 have
> > reasons to believe that something always sets fd to non-zero value befo=
re
> > pci_uio_free_resource is called? Should rte_intr_instance_alloc set it =
to -1?
>=20
> I believe that's what patch 3 of this set does, initializing each to -1.
> Perhaps that patch should appear before this one in the set, to avoid the
> possibility of temporary breakage.

I see it now, question withdrawn.
