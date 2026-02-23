Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1524EC1112
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Feb 2026 17:16:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE23D4025E;
	Mon, 23 Feb 2026 18:16:20 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 324AB400EF
 for <dev@dpdk.org>; Mon, 23 Feb 2026 18:16:19 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fKSDY6chVzJ4682;
 Tue, 24 Feb 2026 01:15:57 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 359A740570;
 Tue, 24 Feb 2026 01:16:18 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 23 Feb 2026 18:16:17 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Mon, 23 Feb 2026 18:16:17 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "bruce.richardson@intel.com" <bruce.richardson@intel.com>
Subject: RE: [PATCH] test/eal: remove PCI probing for vdev tests
Thread-Topic: [PATCH] test/eal: remove PCI probing for vdev tests
Thread-Index: AQHcpN0RLeou2wA6OU+ddnDxPltP4LWQgLEQ
Date: Mon, 23 Feb 2026 17:16:17 +0000
Message-ID: <8c67f4d90bd540e29c9e1ab4fcdc0dc8@huawei.com>
References: <20260223155603.3651641-1-david.marchand@redhat.com>
In-Reply-To: <20260223155603.3651641-1-david.marchand@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.74]
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
> From: David Marchand <david.marchand@redhat.com>
> Sent: Monday 23 February 2026 15:56
> To: dev@dpdk.org
> Cc: bruce.richardson@intel.com
> Subject: [PATCH] test/eal: remove PCI probing for vdev tests
>=20
> Similarly to commit f67f76e6bbfd ("test/eal: remove PCI probing for
> recursive calls"), let's disable PCI probing in vdev tests as it
> triggers false positive failures in GHA.
>=20
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  app/test/test_eal_flags.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/app/test/test_eal_flags.c b/app/test/test_eal_flags.c
> index bebddf1c98..06a605cce1 100644
> --- a/app/test/test_eal_flags.c
> +++ b/app/test/test_eal_flags.c
> @@ -422,17 +422,17 @@ test_invalid_vdev_flag(void)
>=20
>  	/* Test with invalid vdev option */
>  	const char *vdevinval[] =3D {prgname, prefix, no_huge, eal_debug_logs,
> -				bus_debug_logs, vdev, "eth_dummy"};
> +				bus_debug_logs, no_pci, vdev, "eth_dummy"};
>=20
>  	/* Test with valid vdev option */
>  	const char *vdevval1[] =3D {prgname, prefix, no_huge, eal_debug_logs,
> -				bus_debug_logs,	vdev, "net_ring0"};
> +				bus_debug_logs,	no_pci, vdev, "net_ring0"};

Could use this opportunity to replace tab before no_pci with space.

>=20
>  	const char *vdevval2[] =3D {prgname, prefix, no_huge, eal_debug_logs,
> -				bus_debug_logs, vdev, "net_ring0,args=3Dtest"};
> +				bus_debug_logs, no_pci, vdev, "net_ring0,args=3Dtest"};
>=20
>  	const char *vdevval3[] =3D {prgname, prefix, no_huge, eal_debug_logs,
> -				bus_debug_logs, vdev, "net_ring0,nodeaction=3Dr1:0:CREATE"};
> +				bus_debug_logs, no_pci, vdev, "net_ring0,nodeaction=3Dr1:0:CREATE"};
>=20
>  	if (launch_proc(vdevinval) =3D=3D 0) {
>  		printf("Error (line %d) - process did run ok with invalid vdev paramet=
er\n",
> --
> 2.53.0

Acked-by: Marat Khalili <marat.khalili@huawei.com>
Tested-by: Marat Khalili <marat.khalili@huawei.com>

Definitely not a problem of this patch, but creating a separate define for =
each command-line argument like --no-huge does nothing to save us from repe=
ating `prgname, prefix, eal_debug_logs, ...` bazillion times. If tokens are=
 burning a hole in someone's pocket, perhaps instead we could move this who=
le command prefix into some kind of function or macro with parameters (poss=
ibly one launching subprocess as well).

Another thought, should we have NOPCI_OK/NOPCI_SKIP similar to ASAN and NOH=
UGE?
