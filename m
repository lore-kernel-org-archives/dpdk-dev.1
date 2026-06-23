Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33EBCDB471
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 21:30:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A824A40658;
	Tue, 23 Jun 2026 23:30:29 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11020094.outbound.protection.outlook.com [52.101.85.94])
 by mails.dpdk.org (Postfix) with ESMTP id B324D40293
 for <dev@dpdk.org>; Tue, 23 Jun 2026 23:30:25 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GGQfF/32yXZEl3SxoExszHNoUXPV3L7RiaOzfszl0a75GrWHsIFys6iGrk+UVjvvtSHpbFhjKX9DEoyaeLGKElAcsmV198SSrB+1mcga4AZdJqAEKPT8nxPyCuBrPmT1ttRovNpoVGHnN+PhSxLwjPbBeH2K6LJgpYs0sj0N5b5bmwX4S1gjMP/orJWdOKUwxqteUSqsMQyltvLqgOhZochgxukGLRFdAUzMmk5Zs4YozH7UTO++dQgdXGMPEiZ4fTdN2kgt+kpPcG1RUbBky+8fJOnww4oXGGQixlNq+x69m6hQ6L+qmMUpo+xKcuMWbDgpPclMc7HvAz6YMXgsqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mrx8K2W6mGurcKiBamJarnftCqk+088nOi03jJUGzuM=;
 b=c78rayPWP6osmYVD6NRmgR19YvkGJ+f/qkBloTdc+U5yySZZoUp/GrPvxbLRhCeWiAKfpnixyGx21uJoI8iMAMh1PGrlPYEbg7wwE7iPd3k0ufJ2DuvhjsURAEFZzUONp+FYqYLsmTdxFzzwDCfmiqkmsSbVZCjjauxQIX2lOpGITiekLEHyWsx2LAbvacP89nguEN0IYE44v8t4YCR87of+kEp1jruhRHjsUXJUEzatE4+qzKqjDEvJN4J3o5rn2hcyne0Rz0x64LpP5chH0NCIHkfYt6rdYgSaCTfVBqceTNDpsf77/PQ2XG2CcDcWwu7jAzyXc5pGF+frzPZOkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrx8K2W6mGurcKiBamJarnftCqk+088nOi03jJUGzuM=;
 b=ReeycIek3MdMMlN2P73uSvKldncbXngLrvC805K3xkMwIFgCwuXzp8maBJcwGb+vnaOdRlNHsmkWryZKye6KLacvCKL4WmYYm8Wr/gLTnPRi6k39RlHMGZdtlngvfKVPQ2nzBE4+zbjVagPKOOawE2nNxhyNEtJQBq1iZU/8EE4=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by DS2PR21MB5444.namprd21.prod.outlook.com (2603:10b6:8:2bb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.3; Tue, 23 Jun
 2026 21:30:22 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%3]) with mapi id 15.21.0159.007; Tue, 23 Jun 2026
 21:30:22 +0000
From: Long Li <longli@microsoft.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, "bruce.richardson@intel.com"
 <bruce.richardson@intel.com>, "fengchengwen@huawei.com"
 <fengchengwen@huawei.com>, "hemant.agrawal@nxp.com" <hemant.agrawal@nxp.com>, 
 Wei Hu <weh@microsoft.com>
Subject: RE: [EXTERNAL] [PATCH v3 11/11] bus/vmbus: support unplug
Thread-Topic: [EXTERNAL] [PATCH v3 11/11] bus/vmbus: support unplug
Thread-Index: AQHdAv7fXYh+8eN6rUaMuE/LSwQaRLZMkPYg
Date: Tue, 23 Jun 2026 21:30:22 +0000
Message-ID: <SA1PR21MB668399A4E3F2850F5F215D55CEEE2@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260611094551.1514962-1-david.marchand@redhat.com>
 <20260623105439.2144694-1-david.marchand@redhat.com>
 <20260623105439.2144694-12-david.marchand@redhat.com>
In-Reply-To: <20260623105439.2144694-12-david.marchand@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8ffffc07-fca9-42f3-9ea0-9a32c7fe5f4d;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-06-23T20:04:19Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|DS2PR21MB5444:EE_
x-ms-office365-filtering-correlation-id: 0f24eb77-5603-4d9a-22d9-08ded16ea1b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|56012099006|18002099003|11063799006|22082099003|6133799003|4143699003|38070700021;
x-microsoft-antispam-message-info: UQVVAb1OeDl4aTB2ablsmp2XlR9W2vP0+URmGDPByqp2gJ5ToieROqbxiHHy0CeTJxyl4A6J/DjSYmJHu4QIuT8L4kfp0MAU+IOfqRQK3Tn6OtPSqH4CcLUFHpDYHhWxz24IG6rIykzQNHkMVeIViPWOSsTZEjag0+z/e/82UbsgTcVOkcoNPFjxbyCX2mjm4EZeI6tcMv5Fio+2L6cT92kKC14g8pinnBsqKrHX18wvs0U8/hgpte7Tv97xQb67OiFq6Re4+Q6aQy4owdsebcvUSRSECikyuPYEPokYeTc5GOYMTzf66lFGer2ynz3BQUUwilTBZUr+fDxdn5BOsN+8gyHlaJ+OorGGJoxmcsbTs/PVx8DUaC6Ov+E18Dzf1877YuS7hLB2XPWcXtFmc0fR5chOAFKl4K7m2C0M6wBvEbKr+AoImziClF9U87qF3aTQPkCdcNWqoGsQsh6lhe0JWbqs7ncDX0HQuON1Ljt224pMFdATmKiq+L6eJze0TqYQDAb/yPaXev2jx7C53eukgYZ6FbPuR0XD+6KwVcIsKMErx1Tys/N8DOOMmnaY6IUXd5vQ8cSIK/T0pZI9EvBq4VAFdjRb5fI8R588nlkhmzJJvxRYf7At+ryLHqTIKKAtFoZiyZiani4g4Qx5EAzfc558rRhpps3LeFU93nl4CmiWWfgT44VAWGSJim/93sU8a28p23zU3Z6WtPzSzVp7D43ogR3FQGWN1r9WwCg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR21MB6683.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(18002099003)(11063799006)(22082099003)(6133799003)(4143699003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0JrP6rg9yh3J+agmC/qMR1ybY2PYoVT0W+qZU6wFtOhStrZpAYKaQxC32Uq/?=
 =?us-ascii?Q?8ceD7l2JMToiol9na+nzQqAkMBc5tUTPPqUQqmhMhxtC3aKbofZxk2EQwutz?=
 =?us-ascii?Q?RRV7ADfSCteDAIxEo+3L3Ak75MeDDDJn3vYialRdUh2TH3LnSCDJGdMRdWGP?=
 =?us-ascii?Q?UflRxrrEE6YdSAY7JFkNFAWv6ZroSvToepWvMr0ni6XpqqNwQsTDIIT54wV7?=
 =?us-ascii?Q?fWu1xt6MfX05ljCOJk/W1L0weBdx+e/09PnH3vlCxjHDpmkwiHSjfVAbMcHk?=
 =?us-ascii?Q?IBSvR13m3WRjr7Hh8jydU0FygOI0k5M1HfKq5GejOMbD8hHq8ZMa5KtRkYBl?=
 =?us-ascii?Q?T29TijmwfEhSjnLTgQjY6EOEIk9GxXJmg9E1mI5NlIgCO4t7nWs3CxRXtGAu?=
 =?us-ascii?Q?rmIDNg/q2vGd8kpZ3CMBbDwVUfvfOZlMqzyg1NSkxSj2yEQ3rjxeHFgjGXKQ?=
 =?us-ascii?Q?Ja/zTjjoGF3F3c8LDi3VCyVe4csGcF5K6IF860wolZUqCr6cWnQfNpBtuKb/?=
 =?us-ascii?Q?5eq2FjPxSJOJk2kTbMn9+KvWp3Q3GMWoBUU6xg2StOL9Dgl+TJ4nFSMawlEQ?=
 =?us-ascii?Q?5pdkq1/sP3DuqL+NfVv37IeMkz28PcWYjhbFYHbqfwV/0cYpGnl6ccNMl71W?=
 =?us-ascii?Q?s4h6ezma5gEXuGtv6YbyJOWR834AnaqDE3sPg5wqaZ44POqc3lQMAj0y4zR3?=
 =?us-ascii?Q?kY00QTukyZwWY3W6fTMw8q5Q86jXn93XYsiqiChYD9y3+zggfI0TN9pkFnGH?=
 =?us-ascii?Q?e8HjgmY/2RMmky6U9IH+M1Q/vcXSv3o3ED5WUjwvtW6AIP1Y5D8A5+Exzjam?=
 =?us-ascii?Q?InNF7FHygeCFpxzBuVSF8vPeH1X5oO7ocEMdkcYwe0urWlEimF0eP50L+P3I?=
 =?us-ascii?Q?FB5XcBnTAqDS501KO+ofasOTCnx5BLtpAm/alIh++jYRFSehiycFMQrCfvOc?=
 =?us-ascii?Q?orwZU4mIzCEKfcVgsj5o/oP2SmK1mALglqjbi1hmlsIkBFQIUoWfTnw+j8ho?=
 =?us-ascii?Q?mz6WrG5vVeOtUyhc1Jw+5A1rdnT+GXVWP9i+IOzNVSZeUBJcHaHHIi8qbYuf?=
 =?us-ascii?Q?JolAzH4udajDDTZ/YxTCnurrjtunfrB9YhPWFAz2IBj9bTX14opdNHpzdCGI?=
 =?us-ascii?Q?QhmqfW3BZZSDdlKZkWr3tFPAvz72VW80xAp6BVUi5F6kHuoUGO/jfcP6pRdQ?=
 =?us-ascii?Q?RBY8jopKxMqoFPP/Wh5/KwWL/irugcePQ+Sh62FUyJ+MLDNBRhLauwdYfLCF?=
 =?us-ascii?Q?hYDdpUkirfPzu3irHCQkHH9ks6XysE3ANI6AARVEqJO8gVYjIZ7gE6F+17Y6?=
 =?us-ascii?Q?LyJzX03rJ0Tq6XYwTtpSMg64Spm4PpC1uNegXrdEU8Uba13FnSapLTwt+jAv?=
 =?us-ascii?Q?/2WsBqGvYNyoupL2ngwjRtmOz9acFC1oGMDrf3euqu+Y/tR3ICTdvuZkZH2r?=
 =?us-ascii?Q?VDP7fmmlXPcNoaw9uFqR+seSifx+PbmEt9YEkfbDjYL2VphcDgarrLzUv2hQ?=
 =?us-ascii?Q?6SSH5TU9apGJVyiyif0hhOPanQETxG+RWZ3FQvgVqlvCgBPKgA8KZm34klGt?=
 =?us-ascii?Q?IMfma7f3Znh7E0pcWHy7keh3cc8nizzEDLwt4MVE6wGmtbIYT25of5jrhILa?=
 =?us-ascii?Q?CHzznNfVBlMM6rFcGFJV2zxm8IAPx8Ziy0h3wA1QwV8IL+gD7pEoPqmiVEoA?=
 =?us-ascii?Q?N+1NYDoo1sUaVeJoACWH/8/lEwxVuAvZFzgX2fE95we0Xoys?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f24eb77-5603-4d9a-22d9-08ded16ea1b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2026 21:30:22.2006 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PN+d6HY8ZU6sFSuFKEoLUS/Gn8kPNRaRaHBRhkHoSUl/lAHBD+6k+R13uKF27HsaVO/bNyq/ps3Vr9K6YgRhkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR21MB5444
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

> Add .unplug callback to handle driver removal, device unmapping, and
> interrupt cleanup. This enables use of the generic bus cleanup helper.
>=20
> The cleanup function was already performing these operations, so it seems
> safe to expose them through the unplug operation.
>=20
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Reviewed-by: Long Li <longli@microsoft.com>


> ---
>  doc/guides/rel_notes/release_26_07.rst |  4 +++
>  drivers/bus/vmbus/vmbus_common.c       | 41 ++++++++++++--------------
>  2 files changed, 23 insertions(+), 22 deletions(-)
>=20
> diff --git a/doc/guides/rel_notes/release_26_07.rst
> b/doc/guides/rel_notes/release_26_07.rst
> index 5d7aa8d1bf..55d3b44527 100644
> --- a/doc/guides/rel_notes/release_26_07.rst
> +++ b/doc/guides/rel_notes/release_26_07.rst
> @@ -114,6 +114,10 @@ New Features
>=20
>    Added no-IOMMU mode for devices without or not enabling IOMMU/SVA.
>=20
> +* **Added unplug operation support to VMBUS bus.**
> +
> +  Implemented device unplug operation to allow runtime removal of VMBUS
> devices.
> +
>  * **Added selective Rx in ethdev API.**
>=20
>    Some parts of packets may be discarded in Rx diff --git
> a/drivers/bus/vmbus/vmbus_common.c
> b/drivers/bus/vmbus/vmbus_common.c
> index a6e3a24a7c..cd6e851e4c 100644
> --- a/drivers/bus/vmbus/vmbus_common.c
> +++ b/drivers/bus/vmbus/vmbus_common.c
> @@ -144,34 +144,29 @@ rte_vmbus_probe(void)  }
>=20
>  static int
> -rte_vmbus_cleanup(struct rte_bus *bus)
> +vmbus_unplug_device(struct rte_device *rte_dev)
>  {
> -	struct rte_vmbus_device *dev;
> -	int error =3D 0;
> -
> -	RTE_BUS_FOREACH_DEV(dev, bus) {
> -		const struct rte_vmbus_driver *drv;
> -		int ret;
> -
> -		if (!rte_dev_is_probed(&dev->device))
> -			continue;
> -		drv =3D RTE_BUS_DRIVER(dev->device.driver, *drv);
> -		if (drv->remove =3D=3D NULL)
> -			continue;
> +	const struct rte_vmbus_driver *drv =3D RTE_BUS_DRIVER(rte_dev-
> >driver, *drv);
> +	struct rte_vmbus_device *dev =3D RTE_BUS_DEVICE(rte_dev, *dev);
> +	int ret =3D 0;
>=20
> +	if (drv->remove !=3D NULL) {
>  		ret =3D drv->remove(dev);
>  		if (ret < 0)
> -			error =3D -1;
> +			return ret;
> +	}
>=20
> -		rte_vmbus_unmap_device(dev);
> -		rte_intr_instance_free(dev->intr_handle);
> +	rte_vmbus_unmap_device(dev);
> +	rte_intr_instance_free(dev->intr_handle);
> +	dev->intr_handle =3D NULL;
>=20
> -		dev->device.driver =3D NULL;
> -		rte_bus_remove_device(bus, &dev->device);
> -		free(dev);
> -	}
> +	return 0;
> +}
>=20
> -	return error;
> +static void
> +vmbus_free_device(struct rte_device *dev) {
> +	free(RTE_BUS_DEVICE(dev, struct rte_vmbus_device));
>  }
>=20
>  static int
> @@ -222,10 +217,12 @@ rte_vmbus_unregister(struct rte_vmbus_driver
> *driver)  struct rte_bus rte_vmbus_bus =3D {
>  	.scan =3D rte_vmbus_scan,
>  	.probe =3D rte_bus_generic_probe,
> -	.cleanup =3D rte_vmbus_cleanup,
> +	.free_device =3D vmbus_free_device,
> +	.cleanup =3D rte_bus_generic_cleanup,
>  	.find_device =3D rte_bus_generic_find_device,
>  	.match =3D vmbus_bus_match,
>  	.probe_device =3D vmbus_probe_device,
> +	.unplug_device =3D vmbus_unplug_device,
>  	.parse =3D vmbus_parse,
>  	.dev_compare =3D vmbus_dev_compare,
>  };
> --
> 2.54.0

