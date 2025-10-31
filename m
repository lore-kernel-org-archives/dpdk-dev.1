Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9E4CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 00:10:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C7CB402B1;
	Tue,  4 Nov 2025 01:10:05 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id F08D540150
 for <dev@dpdk.org>; Fri, 31 Oct 2025 13:32:19 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4cygN553rzzJ46BZ;
 Fri, 31 Oct 2025 20:32:05 +0800 (CST)
Received: from frapema100003.china.huawei.com (unknown [7.182.19.100])
 by mail.maildlp.com (Postfix) with ESMTPS id BAB711402E9;
 Fri, 31 Oct 2025 20:32:18 +0800 (CST)
Received: from frapema500004.china.huawei.com (7.182.19.21) by
 frapema100003.china.huawei.com (7.182.19.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 31 Oct 2025 13:32:18 +0100
Received: from frapema500004.china.huawei.com ([7.182.19.21]) by
 frapema500004.china.huawei.com ([7.182.19.21]) with mapi id 15.02.1544.011;
 Fri, 31 Oct 2025 13:32:18 +0100
From: Eimear Morrissey <eimear.morrissey@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH] lib/net: Add ICMP support to rte_net_get_ptype()
Thread-Topic: [PATCH] lib/net: Add ICMP support to rte_net_get_ptype()
Thread-Index: AQHcPflXJ0JBcHIuD0KzI2zCl2wuV7TcROBA
Date: Fri, 31 Oct 2025 12:32:18 +0000
Message-ID: <03abaccc37f14f4c8955580784f30cbe@huawei.com>
References: <20251009152740.10437-1-eimear.morrissey@huawei.com>
 <20251015102947.4614244f@hermes.local>
In-Reply-To: <20251015102947.4614244f@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.182]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 04 Nov 2025 01:10:04 +0100
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
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Wednesday 15 October 2025 18:30
> To: Eimear Morrissey <eimear.morrissey@huawei.com>
> Cc: dev@dpdk.org
> Subject: Re: [PATCH] lib/net: Add ICMP support to rte_net_get_ptype()
>=20
> On Thu, 9 Oct 2025 16:27:40 +0100
> Eimear Morrissey <eimear.morrissey@huawei.com> wrote:
>=20
> > Set RTE_PTYPE_L4_ICMP for ICMP packets.
> >
> > Signed-off-by: Eimear Morrissey <eimear.morrissey@huawei.com>
>=20
> Would be good to do ICMP6 as well.


Should an ICMPv6 packet be RTE_PTYPE_L4_ICMP/RTE_PTYPE_INNER_L4_ICMP as wel=
l?=20

The comments in rte_mbuf_ptype.h are inconsistent, the top level comment wi=
th examples suggests that 'version'=3D6, 'next header'=3D0x3A
 should be RTE_PYTPE_INNER_L4_ICMP but the comment on RTE_PTYPE_INNER_L4_IC=
MP itself says  'version'=3D6, 'next header'=3D1 ?

-Eimear
