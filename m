Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A123BCD5BD2
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 00:30:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5629140285;
	Wed, 27 May 2026 02:30:01 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11022090.outbound.protection.outlook.com [52.101.43.90])
 by mails.dpdk.org (Postfix) with ESMTP id 0777A40280
 for <dev@dpdk.org>; Wed, 27 May 2026 02:29:59 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OEyqMsFSb1bvq1ClolXE9dGEpFhG5jZ88Js8fzZcdjZQINjRXstP+FEY6bnImqP8zSS7WKTCQV+vc+RN0M9KTLtGvJp5oCU8Mu4Kv8jNkUXiGA16MZqP47BJhokseccEszpuCOs75pkEYc7lnavB28BZLSmsCpI46IURQU3RKSVnGJT+n9NJZHWwzdBL6oRuEfgud0ioTK8MO7B0L1j3TyGe3nlu8sBrHijsClmxE/S407En8SNbXmRQO7Ldf9grOU+DeSGGmAmJwozJHIuE2RRp0hD7RL7Lj576Sux+FkS3QDF3btVkuBHf9vOlBAsm0Dj7M1FoxT7Br4NmOlk3nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZn+qQD2cYSRzxpFj/5Y72R27aHyOF1Ioa4Dk6DIlMw=;
 b=zHOIzZCxWql/EgDTAl5pgUx0hQfWMJSBksMeqYFLpwa4ALthVpPhm1uObNuRnfJxkMHk5jwDvs+OxRxPQLNqtkW9FWSaAs6MADVwxerFwWYLxQNvPoQIoyso4lHbJVGp5BRyBrcMHM441hfBCfrjRBIGjyttW16nFpfrFdIMBBKlcB/YKGeve7tiRIvtyMgdJYq1vPf4B9NQrfxBdMMKepiNoFp44PimNCqYlXpv4Lr+O9X3hMphSBvEB30/FV89dYvlPe+kNK0vlk+Z324rTNWlVk+mcX5u/RSbk489wR2CavvV+Q0tB8NwMF9w2/T8f10arJWgFsp6p+g3aB6EmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZn+qQD2cYSRzxpFj/5Y72R27aHyOF1Ioa4Dk6DIlMw=;
 b=Xrc7t3IH/GNUXk4/OjXBwo96X9Ar/tETYYXxZ0zbWaAWdaA/ToVOoZ9JFamA4xV9PVMBCPIFPjHDS3XMRN/Sf5jzHbP/7wfssnBAAsWhNRM8faIC7z/QeO+V26l842H+b7GKk2cG7u2oBlL12m4rk/yJ39EUwJny7qSVjYEEZVk=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by LV4PR21MB6413.namprd21.prod.outlook.com (2603:10b6:408:357::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.1; Wed, 27 May 2026
 00:29:56 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%3]) with mapi id 15.21.0092.002; Wed, 27 May 2026
 00:29:55 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Wei Hu <weh@microsoft.com>
Subject: RE: [EXTERNAL] [PATCH v4 15/27] net/netvsc: replace rte_atomic32 with
 stdatomic
Thread-Topic: [EXTERNAL] [PATCH v4 15/27] net/netvsc: replace rte_atomic32
 with stdatomic
Thread-Index: AQHc7WcGZJ6WbwCZtECuAhUmCiobM7YhBFnQ
Date: Wed, 27 May 2026 00:29:55 +0000
Message-ID: <SA1PR21MB668328954F3A75443CD9AFC9CE082@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260526232542.620966-1-stephen@networkplumber.org>
 <20260526232542.620966-16-stephen@networkplumber.org>
In-Reply-To: <20260526232542.620966-16-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=464014c6-c50a-4fe6-ac28-682acbb7f992;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-05-27T00:27:19Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|LV4PR21MB6413:EE_
x-ms-office365-filtering-correlation-id: d783c9a4-3ce3-499f-b36d-08debb8713b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|38070700021|6133799003|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info: k2Fd8OQWLHwAxhWPDAPvghMxaIjnJ0xqsDYOj0fu0sOay9zJtV8833qk6tUPoF/Dl6qCVt84VI9yRUlimHuzRq3m1Un+N8APQMARBdOVnDTl6C8AqW/jyUwmCGXcEMYJJQ+8T6ICR6yjd5slkqzjvf9vseL7oJzQe+SbyxJWBMS74NtnguFfL4GcIDJC9atUakBnpwV1WkTfy4lNRRovGadlSPeZ7yh97y6EjGvu8ohqnzjfBJfX1AhfhisDJNG+glSWrdKZ/g07VnoCgGx9kDENn0wn4pJwK/MBlUOEtnpaR72UCjU0ePxZrWSSujg3nAuxiVH30ZU4ljkbhuMnKx7ZHzJ3nSIZmh0HsItbNRwBm511MGUgpa8x9VrgiSNqMh1P14P/7yapQ8UjPW7IxHR5mAokYq5DMjKdHrkF1CrXT6Ohce4X0ecfy0LnDB4juseOU/vwc3s7x6JmklnkEMY6O6ovv7qRFnZuGqLRatjhNaPNLcy2phNPB3FKgoZ0jyMT9t32zTqpmeH5AKaVsdyB25j6cAhBTmVWZ/4wV5pEGB01RRipCMIlMCcIeHHtKI/x94SN9jLPl9xKzNVEfTtj7za70e5zPfM8u68w+64zidbIstPtNRUY9DFFIT2caW7ue2L/njlA9SeJuVVJNCkgQU/9T3eojmwe+bDt2LycQNnRF6t+IKzkYfDoEgtFRVKLYy6iEUORRM7D/IPPGi6LJdjrwRJOZqpG1xp7kGsgtrW0E66QdIprGosWGB+y
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR21MB6683.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(38070700021)(6133799003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rLwC0rKZoaPrajg0DmBqJdXDMwyFTlCQSOLvKHXDjLqzg7YOHJDcsD1HKWxl?=
 =?us-ascii?Q?8YB3vH5fa8F6OD5PeHu1lUJCDgHCLXW7FQED38JCQQJ/xQEFU6E7nNIo/GqO?=
 =?us-ascii?Q?kAPOL50BzsR8Ef1z5S+mYXceLZus9SpAkl8cIDntjSReXskHCxYD+YEQGfiC?=
 =?us-ascii?Q?oHSfug6nIxmOOv8NAil49ZTphjtUrUHWEdMg8Kee59I+bYoL2beYS6xix/aB?=
 =?us-ascii?Q?+IN+IE3Qog13SH1iaDjaIy6L4X4HQyN2zXyGg9j+CqXsCrYYqCv/p5aisVB3?=
 =?us-ascii?Q?fJG9g/glWOQtvLgv149Qt4y0ZrAzOfm4i8HnVl7gOshHBhA0afMJLtOzfQHp?=
 =?us-ascii?Q?R7zioDPmleqGy+E3F478W5JTSE+OxMp9TkBzfCDP/iEDOQHdqEC2wE0G3erD?=
 =?us-ascii?Q?0yGVVp6yLFqXldeir+L+q28j0HjiqD9EKnOROGaEHT00PqdWQNZ5oX4esZ+a?=
 =?us-ascii?Q?8GIwv/dxrOk86UX+iPQR0GvBvSwuctzequo/aj0zNyNCZrMSWY8CXCrPS3gU?=
 =?us-ascii?Q?0jrmK9QAph6gqPmBIApNtk6DotpyNbqqqSWT0KA+AtLLrw1feTc2itBm3Bta?=
 =?us-ascii?Q?+FvgaPCnoxqignp5vtTL1FMuD4pVeXwnnsYeh9b3P+BHjWB8b2Y/41ZC/b/l?=
 =?us-ascii?Q?odxgycxdkbGa1pJPmaNM5snX3KJnGVg5+kg0T4njt5FpVZmWigl9Dpksk0TX?=
 =?us-ascii?Q?pBFnj3zvn/15kJrPdlcrA+tBUdF1a3Owa0OUhNsfsAG3p50Rqs+iIDEKUhtG?=
 =?us-ascii?Q?c5uIJskgOnFiFi9OxEiXywZRfMPPeg1inxtEWyNdKUD2wUTSAm194qXix974?=
 =?us-ascii?Q?yGQ/KCenfiGQE4ZKYdi9zpImDklYDr+cXA+3BkoIdMGlbRrPDASUiszrjTby?=
 =?us-ascii?Q?snXsJZnCTmmue51Es6FK0ieChrfXwxiJCSfXJKgcnmD/xdX1et5Gv1459m9b?=
 =?us-ascii?Q?6x5gwjPgQuDhXWJmekrIpLvbNaQmG2ZmZL8nW9XWvj2ZxC9ddtHnPixiV9fn?=
 =?us-ascii?Q?HZgUK5aUvhQ2gW2ZUxRRGdZ5mHXdOLjxUDMC9mibkERl8F/AeUWkI1hZl7Vp?=
 =?us-ascii?Q?EOjaatqEQ6kfLjwMOcvtwY8f294givwGM7qNm9q76a6+EfErEAAEkPBsVsTq?=
 =?us-ascii?Q?DHgkYnkmOwN1BpwE/2mGrL4xRr7/T5NBoLNw0nB8w9swandenlVFuI9tCMGa?=
 =?us-ascii?Q?z5+WANtqXqfvJgD80+22KIwxFWS+KUjoQFogm0ggonumUhJaqeITfi5bONXq?=
 =?us-ascii?Q?fm5SMDHyEfCpdPDcbyFjEu0p+Ait3hZ2RLHNCiB/2JDtCr/NjE+9XITgzY7U?=
 =?us-ascii?Q?BxpdyWzH74APWyaO48izS6/S3LwDPu0BdZ39XYuZvIvfeNeuqyU14GltApQZ?=
 =?us-ascii?Q?id9mQrrFk04UX1+9ruD4uuna6iZU2LLjCUi9taDLhFH9+nicf1lcLl8yJfI6?=
 =?us-ascii?Q?iLqEsbAglS+gXK1yYnjnvc7BJyQw4fiJh7lwmGjTLX+iThwO7X60TOkp9GYl?=
 =?us-ascii?Q?4zFVMM3lvh5aA/zEKFn5/MZWczkvaKnREuIjM6dpVa7Noxbb/2DVRSgmA/7v?=
 =?us-ascii?Q?HEkyYydYaa1W6ru4Rxo8ekNCmgmCgkxCHMypI4jNnPh/MzXB4IfQmMEEfVAQ?=
 =?us-ascii?Q?HI1XS0/5y6j73iJTlVP/UspRt+ZcMWBYNl7dlfzy9FK2wmn5KOAS7PJPRzM5?=
 =?us-ascii?Q?aUCZJE6CZP01giK8CSRQPzuFRh+2kz1zLUhwCVt/SkozJ1o3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d783c9a4-3ce3-499f-b36d-08debb8713b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 00:29:55.8657 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oarb/R3nik+pfoQlsCJhUcoqwR3nWOECXdysB1OV25y7aH9MCgBGnbNqeJ0WLhGTl301x3HqN3223yYmRb0DoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR21MB6413
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
> Sent: Tuesday, May 26, 2026 4:24 PM
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; Long Li
> <longli@microsoft.com>; Wei Hu <weh@microsoft.com>
> Subject: [EXTERNAL] [PATCH v4 15/27] net/netvsc: replace rte_atomic32 wit=
h
> stdatomic
>=20
> Change the rndis transaction id and buffer usage to use stdatomic functio=
ns.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/net/netvsc/hn_rndis.c | 28 +++++++++++++++++++---------
> drivers/net/netvsc/hn_rxtx.c  | 12 +++++++-----
>  drivers/net/netvsc/hn_var.h   |  6 +++---
>  3 files changed, 29 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/net/netvsc/hn_rndis.c b/drivers/net/netvsc/hn_rndis.=
c
> index 7c54eebcef..4b1d3d5539 100644
> --- a/drivers/net/netvsc/hn_rndis.c
> +++ b/drivers/net/netvsc/hn_rndis.c
> @@ -17,7 +17,7 @@
>  #include <rte_string_fns.h>
>  #include <rte_memzone.h>
>  #include <rte_malloc.h>
> -#include <rte_atomic.h>
> +#include <rte_stdatomic.h>
>  #include <rte_alarm.h>
>  #include <rte_branch_prediction.h>
>  #include <rte_ether.h>
> @@ -59,7 +59,8 @@ hn_rndis_rid(struct hn_data *hv)
>  	uint32_t rid;
>=20
>  	do {
> -		rid =3D rte_atomic32_add_return(&hv->rndis_req_id, 1);
> +		rid =3D rte_atomic_fetch_add_explicit(&hv->rndis_req_id, 1,
> +
> rte_memory_order_seq_cst);

Does rte_atomic_fetch_add_explicit() return the old value of hv->rndis_req_=
id? If yes this is not correct, as the rte_atomic32_add_return() used to re=
turn the new value.
