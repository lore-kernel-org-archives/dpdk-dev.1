Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CF5C55184
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Aug 2026 17:09:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B81FF402D2;
	Mon,  3 Aug 2026 19:09:24 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11020075.outbound.protection.outlook.com [52.101.201.75])
 by mails.dpdk.org (Postfix) with ESMTP id 7F5D540272
 for <dev@dpdk.org>; Mon,  3 Aug 2026 19:09:22 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iznUUHZjmTd1RuhlMfx2dY8aen+FZXKC3uvsxgPbRfszji+KNlQ8IVa24PFk7g446n24Bt7tv/wj1P3rMsQcfgvWxEH+ByRlsqHBcVL8f6CD1L71dhhSJ+fRWzq8PRA0U4HGJboLprRMuQrIxe4PZTIVQJOlJdUvco6YEGDwoBA5/kTIqkhNNYHjjGCbNBTjHIjRhTc0uJLFQxxoZmZOe5WRWXMqU/m3fBFfOPkqfGOToO2qqNhILcSk5u6QuvxK6+cF+Q0spS5WzUCBVOPQmTP3Oc7vM+d5zfY3PsbR2dFN8XFTiLS4cA/MyEmae6T8ZM+TcINIUIeBOef0y5CngQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1vWevR7iJyAaHuvWHaajc/o49QTC+YHW+BOUtVExCw=;
 b=g1A8ciR31MRqQm0CceaznrEWq26HH8+kGSklsdmSMW/OrP/u6OCNKoqeZeXJDbnye3nPSjorfvttkwtl36q5L5vkRpv5+Fjy8YKLcE677/pKlRTrrMmeSmxKib9BoEv29rXWGaHB7gvVQhpf5ErkkMOL9cCSqKPONM28OMmyulBSXVRlO/ncpUDrCrKxyJPCdCSq30Y8/DpQ3JuG4xD0EeYueHn7Iz0N0v5D+oILzpzTV30pkjefJKS7TF0B4N5qN8dheHicvkcfVGFyd7aqzdwgeH8uk6J6zX6HwOv9M2dMH/3bhXkznWLyQyhmqaNh998nG+S3lshy+/f2qzIB4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1vWevR7iJyAaHuvWHaajc/o49QTC+YHW+BOUtVExCw=;
 b=EpQvKnfvBmCvXrGJZsfc+gyza8t7cY/KqtACZJlBI5TSPN73WFV2oHCFUuv34ASHRxr3NejNQk0poL6avLgucB/s+5Oiz5xGt8Xii9AmCCu1X2PedD1sB4DAGOPYLxQLF/1Rme4FkN/AGy5PGiw5o3rOZOQ8eBHoeqV3y6dWK8c=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA1PR21MB6536.namprd21.prod.outlook.com (2603:10b6:806:4a3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.3; Mon, 3 Aug 2026
 17:09:19 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%6]) with mapi id 15.21.0315.001; Mon, 3 Aug 2026
 17:09:19 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Wei Hu <weh@microsoft.com>
Subject: RE: [EXTERNAL] [PATCH v2 09/22] net/mana: include used network headers
Thread-Topic: [EXTERNAL] [PATCH v2 09/22] net/mana: include used network
 headers
Thread-Index: AQHdI2iXW1Sy8+Zq2UyxhSr5A5GYh7aMjrFA
Date: Mon, 3 Aug 2026 17:09:19 +0000
Message-ID: <SA1PR21MB668306F2DAE4B2E67B2BE408CED52@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260803165304.289869-1-stephen@networkplumber.org>
 <20260803165304.289869-10-stephen@networkplumber.org>
In-Reply-To: <20260803165304.289869-10-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4e616f77-0f34-49d3-8ea0-515b7ee230de;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-08-03T17:08:51Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA1PR21MB6536:EE_
x-ms-office365-filtering-correlation-id: f610c5d2-0e96-4660-baa7-08def181f4ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|4143699003|56012099006|11063799006|7146999003|10067099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: rwOr4CKXOqlRL2+CghJwmAQB53DIWTFEC6BxUDazDv3IvQS4acTmE4MdGmtg0B8RW+0DWTEASWvoYavwM+J7e0xivbFzMSj9zDaAg2vaWBC0VzVzoTaauzJ3kO8so+Qaq74dc2rr6ONvv/l71a5cA7vd88b6CE/gNjSBy90eb8dJesBVRdgq2hH8N6iiTgH23aySIvLt5OQPyJ+bQI3fAM+a4es8IvL33GZibdUQlXTXFaE4VE2PnTimoQbLnHOjeOK5GWGVLEPosC3g0XxMVsaxOZOFEjuXtGk/Y/P2BJLJys27Ten7YM1raeyhSHguKpoJe1MbJNA3CLBoMllpUfZ9+2J7iwxPp2mPjejohhKx6JWRtkN9Pc89hx1kZuq97KlYn2+bd6ZMOOLHfQtDd9Luvqzxtw5KCMGRc4hL1gUIJTCTMwmfqH1Qk8hLk8doJt5ghXZ3ShB+/D7IZ5mI90afpFcIlv/GRzEy+/2F4UdglxdTtTP4JDCZCiHjmUXyYh3Lkl+v/m4To2/E03nSrzENg5Obs5H+oJWzkzFjhfE8uH+MJSbwjFFMe+xSc7r6Rqg4j9mEJc5MQ5vAS8kZnvo/pMdWorqR7NyzjJfCF9prppIWcJwcpCfMbJHmv/B+E26EV55dPU17AJZilzxDM2GRgeJrV903zX5jdOEyheM4dr15bBhcNpZYPLEJ8U24DroIuZ0f2b3byVyOdTM7MQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR21MB6683.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(4143699003)(56012099006)(11063799006)(7146999003)(10067099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Bm7kHSMyXCEves8mOV3ZGYhCGuAcjH6XH5qCvGqaLUBqB0IpRdrHxARYDOKe?=
 =?us-ascii?Q?M+3aIUGogHV5j/PLVXGDjSZfCqjS5O079oAPPalRfouN2Gpwt9wUG0ILUlhF?=
 =?us-ascii?Q?Ui9SzspsSsi7twwpxaOQKshOskp2XNLOjsH7l2N9eJzu/Zxfe+VZ+6ObJSk0?=
 =?us-ascii?Q?RfIAPruqePVefSrHUJTTVEwx4/vxXNxLuh8fkggBPLW66DASvHw2LrCwSI2Z?=
 =?us-ascii?Q?GmHQ32Xr/31BD5H//HGYMIYCNAZ9jVEtZ1aPILhomSjKRh1nUXQlSBCBB9az?=
 =?us-ascii?Q?pC82y8uhThbHLPZYm/8M3SypMWOMmQoUvuX4CZxaFWX7ROMfiYWv/6oiNbzf?=
 =?us-ascii?Q?Azp5Zcq3TVBuU6dLYOHKLz1OU6Itm3eYZNfSOrHxZayrfZsY38hpCMqiG8zW?=
 =?us-ascii?Q?aAjEIgiMDlndtxN0R38eHcDrj1Ymo7evrLJ5/uQaGtZgUUSvyOklm+o64ou0?=
 =?us-ascii?Q?gIMa3Y1ndmDSx7QxsxJbav7onPUDYk1HZQGcXyDzL1E/DWjUJMVBe4yrY0si?=
 =?us-ascii?Q?wVwNaDfJE/9lt/xU2sdiAxj05aKjZzs3pWbkI4yUysSR0x7GFOa4qrsfG2ik?=
 =?us-ascii?Q?aB22Na6m8gR/9DVliQfm2OHf/OYW77FfLLmXLphu22vZAHPcYZTVQVTOuMhy?=
 =?us-ascii?Q?GF83NCDRntSbLYvhTZxvPugziGLB1PizHjAMrjHnjdImfqLiaea2SUyHh4IO?=
 =?us-ascii?Q?KGrJkbgS57Dq9uOnt9Ae8rUNBoKrluZx62DDQtxyHm1vEen6MMGUcB0gfGiX?=
 =?us-ascii?Q?nU4XAMlxjYPe3Ksl3Yxd3NZwJdR8cx/pc14wu7MIVeiF7Rr1MVBlOFbv6GHA?=
 =?us-ascii?Q?LfpcRn0jPEsFGLVXAyiA8Ovnfmc0QtIMT5Isheb6TyIgHhUH7EuOxlPjU6Yy?=
 =?us-ascii?Q?9eK0eMHzH2nBNAyRPb75a1fUSRBnOHZL+6WUdiWZ65ftvOzoXJ8WxVdE2YAM?=
 =?us-ascii?Q?gLZ/aSCK2JcWDcbz1VUV1cxblq3I3IoG+A2h++MAqhHjp5rNhW6y8vLYJ8oc?=
 =?us-ascii?Q?wek5wv60uahDI4bxi9+fIDX5dq6ZZ8Zk+UJRci9GxO7ocOBhXz3LmFlrW7d3?=
 =?us-ascii?Q?ZJqirBBqGjTK5LguOg+CozVv0h2bSQbmhLg2I2fy6buBXNzx3zjwCByjxsCz?=
 =?us-ascii?Q?/bfORrVWsTi979USxkfZ9gpTotxJvAtvCBRhfkUXW3T87PkFjs+SllInOhZm?=
 =?us-ascii?Q?AG9UtsE7VZN1bgO9QQBuS43VGuggXJy+fkzTj+onrdLGqk2osunlX3otiUAL?=
 =?us-ascii?Q?bvfR3TD2NLd4MfEO0k8ckqAXPDSDJVtmjCMW9lyIB193mfXQ5bYC8FXmBhWm?=
 =?us-ascii?Q?QM27YqfllJE0fyI2CghemfyLXeaMYaFm+ebbELSrhD06AIJCrmDEqJqXTNhg?=
 =?us-ascii?Q?qnvPv4wkFh+uZ6r/mTTZ2oYexEsUgr6tjc20WjryDeGREv418LLmriLF7Usc?=
 =?us-ascii?Q?E1veuEDxczx2zlysObPL00XvRIJBFIPkQVWVXhL3A2J1U2FN0DBQqmXsYlBC?=
 =?us-ascii?Q?cR2phsyY/VIHLo/NXTYXXvICksr2RNLVHSMQeno0OnBhIPaRECJ+cMxZAh8h?=
 =?us-ascii?Q?eTSR8HePUJOqNFN+0GhkZyPtqkWUvbixE2/bUtSN5Ocv5NKurZR4lTE/dnML?=
 =?us-ascii?Q?NMnYY+1jYJsAh/cuGv7YrTckkx+sLeURTZ8lZhiBZmc3+PdPNPRo8rSOLIwW?=
 =?us-ascii?Q?3MMaDCzu1M7/nnX6MaKoH/7uFsh82Ce7ii9eG+NWCZNzEQLr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f610c5d2-0e96-4660-baa7-08def181f4ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2026 17:09:19.2575 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qWVQwonG90TWHNkfO50+dnnKnyh+egDIOcS6Mmr3wUk3gx6CCZpQe1/pCipbpo/LviRt6wkHRkQfMhyOgw+YiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6536
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
> Sent: Monday, August 3, 2026 9:52 AM
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; Long Li
> <longli@microsoft.com>; Wei Hu <weh@microsoft.com>
> Subject: [EXTERNAL] [PATCH v2 09/22] net/mana: include used network heade=
rs
>=20
> This driver was getting definition of IP, UDP, and TCP headers implicitly=
 via
> rte_ethdev.h. That will be changing so instead include the required heade=
rs
> directly.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Reviewed-by: Long Li <longli@microsoft.com>


> ---
>  drivers/net/mana/mana.c | 2 ++
>  drivers/net/mana/tx.c   | 3 +++
>  2 files changed, 5 insertions(+)
>=20
> diff --git a/drivers/net/mana/mana.c b/drivers/net/mana/mana.c index
> 0b72f711a1..3870cb4a52 100644
> --- a/drivers/net/mana/mana.c
> +++ b/drivers/net/mana/mana.c
> @@ -6,8 +6,10 @@
>  #include <dirent.h>
>  #include <fcntl.h>
>  #include <sys/mman.h>
> +#include <sys/socket.h>
>  #include <sys/ioctl.h>
>  #include <net/if.h>
> +#include <netinet/in.h>
>=20
>  #include <ethdev_driver.h>
>  #include <ethdev_pci.h>
> diff --git a/drivers/net/mana/tx.c b/drivers/net/mana/tx.c index
> 10f2212b5d..9517b033dc 100644
> --- a/drivers/net/mana/tx.c
> +++ b/drivers/net/mana/tx.c
> @@ -3,6 +3,9 @@
>   */
>=20
>  #include <ethdev_driver.h>
> +#include <rte_ip.h>
> +#include <rte_udp.h>
> +#include <rte_tcp.h>
>=20
>  #include <infiniband/verbs.h>
>  #include <infiniband/manadv.h>
> --
> 2.53.0

