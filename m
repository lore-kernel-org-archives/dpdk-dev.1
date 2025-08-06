Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79716C87FCB
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 Aug 2025 16:02:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 489F340291;
	Wed,  6 Aug 2025 18:02:58 +0200 (CEST)
Received: from OS8PR02CU002.outbound.protection.outlook.com
 (mail-japanwestazon11022125.outbound.protection.outlook.com [40.107.75.125])
 by mails.dpdk.org (Postfix) with ESMTP id 63F7C400D6
 for <dev@dpdk.org>; Wed,  6 Aug 2025 18:02:57 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pB/db+aJf7DmJG/oKgQFHHP+1E57YjFtDpqMFoa9udmgsGiHhi1Y4FCY3W6bhPxGWvGGs9/ZRaewpQihCFiyduiDcne0pz+2rnXDJc+v4rcY81FLlXqbRbS56Ez0QFj2xyXKYDANlfgvm4lk8xzvGFPNsNILw065bUetKpWRTvmYaBKK0jVT/i10urfQBiGmieIa0NaHHqdAZIKaFngeVGOn9QQ4O0aGJWYieUPPES4dJ2rBanwkM0IAQEcErVY/UYzRqZYZOwX9GdoCKnZs23y74a3HCsFi9dwQsqeEYJ4pKyykuuzXGHlBtZXrCs8/mSalX5w+F/m0ATYDvYDu9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRaDkRrtbLZdqFc6it11ExiKA6kTVBXgRRrD1UeaADk=;
 b=wP+KCXqmorsYae1ysB+0qFnrRgvy7NlvXmECbhjL7huSsexnqvPabECHVr+AXGPdpIJ+EtE3qWhOa0+/haSIoErXsPFr6LQGT8vzFh5bimED899WvSyPNSnQ6Qvs6B/w4J+RQtNAVEDmQij2izyqg/Tx5O/t4vz9PbwdjaN2XICD1QbRGPPGaNRvM8xKA8JPApbe/FJ8K6FJxMU6YhgSsHD4tlQNCpMMTxmRHbgBivTnnbCwy9kQ70cWh+30kL4Pe6HGoEiuF0RLQXclkv0dW+W0S0aJ7TtcrGMLssnvEDY4r4E0nGOAql/nx6MXlkZd2UFV3+2dVSZg9kudM8pU5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRaDkRrtbLZdqFc6it11ExiKA6kTVBXgRRrD1UeaADk=;
 b=j2iHbt6MbFr8NDWcIpEwQg2W1z43FOR8bRhC3z16iC6ZPjCCABN6ssJVhwbsH8hi8OO3zxLlQC32T/qlXqsW78+db3542UPB5KDCQm/H8m2pqMcIXPd1K1Mo/hkDzUuDPgjRABFhcnoyJp3EFQNb1/wzuAftfaU8lNgXF+xsMvM=
Received: from OSQP153MB1307.APCP153.PROD.OUTLOOK.COM (2603:1096:604:373::18)
 by SI4P153MB1072.APCP153.PROD.OUTLOOK.COM (2603:1096:4:26c::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.5; Wed, 6 Aug 2025 16:02:52 +0000
Received: from OSQP153MB1307.APCP153.PROD.OUTLOOK.COM
 ([fe80::b5b4:898a:d979:93e9]) by OSQP153MB1307.APCP153.PROD.OUTLOOK.COM
 ([fe80::b5b4:898a:d979:93e9%3]) with mapi id 15.20.9009.005; Wed, 6 Aug 2025
 16:02:52 +0000
From: Wei Hu <weh@microsoft.com>
To: Long Li <longli@microsoft.com>, Stephen Hemminger
 <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] [Patch v7 0/4] Support VMBUS channels without
 monitoring enabled
Thread-Topic: [EXTERNAL] [Patch v7 0/4] Support VMBUS channels without
 monitoring enabled
Thread-Index: AQHcAOZI33Ahv5Q4Y0WGZAKPKI6yZrRVosaA
Date: Wed, 6 Aug 2025 16:02:52 +0000
Message-ID: <OSQP153MB13078454F0A3C58013A86949BB2DA@OSQP153MB1307.APCP153.PROD.OUTLOOK.COM>
References: <1753834183-22244-1-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1753834183-22244-1-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e6a148f7-4bad-48ce-90fb-811ee31c06fb;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-08-06T13:01:55Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSQP153MB1307:EE_|SI4P153MB1072:EE_
x-ms-office365-filtering-correlation-id: b7743c26-a5a7-40ef-a240-08ddd502b319
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|42112799006|376014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?2KlIt/6Cq+L71ZEmEHEAsKcjKmK8sqdEDebJ54sBri+PcGJxVolui2N4O44e?=
 =?us-ascii?Q?bTXCMN1JYkd+aM/NB/8+JN4TeFCRu3Mz7Uu/Vj04sd14nwyQHfwSye5QJJUU?=
 =?us-ascii?Q?XEgqeUBNcAmqGl2VvkuxI4xui0vo8ic38JJkzPqJ064jltQdR9yqG9PB2TWO?=
 =?us-ascii?Q?A0TxWt34rl32eB8tdJoD6sM/lRcOoR4g31ppA6OxUVWeRi7y6D2WwPm4ovxi?=
 =?us-ascii?Q?r5bi3nHEMRqUKKbuuIETHDiwJs0Pl5iswFgf7skvdu836K5L/4RGha1izQQ1?=
 =?us-ascii?Q?ID8bAkaKXcT7tl0tcVYfa0fIaUAXYGmmzl7iHKUXpoyKC9kgU/5VAjvbW2ov?=
 =?us-ascii?Q?B7eIzPW34qYUrgRX/I3lHrKAhzIwzhZzeXL0TM6+lKfcClLPwKjwJ5Uz5I6A?=
 =?us-ascii?Q?ePn04jQ0AsJ4hMhzJ71bhzogsPplMHRZI7F4skSfcTRdU6KvC//SFTuF/k8P?=
 =?us-ascii?Q?CfPcM+rGzqIsn7O5UurUkDfpqyEWSn4xZcjVDHpnEqhI8pf7iheJTw3msA0z?=
 =?us-ascii?Q?tKh9S/eK0KlJBHX4yDPel4ILklnciofMizi6VqrtakmE5Q1i182h9pVcKvbg?=
 =?us-ascii?Q?SOihBs58Fa51/Y70cdQVBcwXgMQLtyNgE4h22SGp5a9sbCYrM5AylKoc5bX7?=
 =?us-ascii?Q?wOlFAh13JVxxSqZ2Q9VvWgv23s93VFDyKy+fZReNJn7urHHfz3SNVyZ28+Rt?=
 =?us-ascii?Q?Ws5q8DdlYJM9V2WSMqRY333colS6WyPizhNmn6fgS+GyMqwvKCct1//791fs?=
 =?us-ascii?Q?aNlrZzrIbiebEFswAXpzmrc7e0JcWDB7/tviM2eZnqngXf09vPXeWW19zj5C?=
 =?us-ascii?Q?yRPqCr4PPapU07iCWUquXR+u7FEzI8rxyswI/hoFeHaTvad8QNqNlCTqNHo2?=
 =?us-ascii?Q?rYkP1rE4DXUwuABe9NZF6VqnnsNRxGaR3YDM0+8vLO+iw6LQyc6i1dOgvVKa?=
 =?us-ascii?Q?VzW0Gas7QXHWTs5UjKioLazraFFHM+sR6P8+wCs0euz3rwjbJdvQxMcMwbn2?=
 =?us-ascii?Q?JvL1Sz3dRl9WoWiGXWWyE6f0EhQB+MMb/hAbUX7sMBLJyUpj2re53JIiCq2O?=
 =?us-ascii?Q?tSIA2oHbWpBrf+24wZcEvJANwiPLC0FdYOKUhr+XzisKcP7Hjmc7MFz/MmyU?=
 =?us-ascii?Q?6RZ/F8T0r8eQRJeKPuFFFbvAwFxfmoJETGJo7NbAjh9Gein/LR8NQI9SJj9W?=
 =?us-ascii?Q?vS/m9hE1zGP7NT/f/JM7nYOWA1LgqY09TsSKEXNKuJzFHFDHernZtOWYpMfe?=
 =?us-ascii?Q?pQqUM8WQvMiauaSEBmf2DUDZ00yCkIFN2Sy4iK7TEwYeoAqhX9zGFi+MEtlM?=
 =?us-ascii?Q?h1oPLQ5zL60B9EL+Kb7J8y5d2wcghAEWrHJc4HPdiypf+W2VYhduHo15IUd6?=
 =?us-ascii?Q?xmstNIVqQisrqrsso7DfEyCnXACQk3lLQQ9Cg0E85XzLhnfec6xfyh1vzbNq?=
 =?us-ascii?Q?40sDsO+ifsJcgbFegTMx58YO1XRoCZRv98+8fKtRyYnmrbN9cSUlOg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSQP153MB1307.APCP153.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(42112799006)(376014)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wk9pdSSvq/479DY6ec2nO6t/93UaZa1hP9F1MZAoSmcE6MDt+kV8PzVecTyU?=
 =?us-ascii?Q?Skt20fGAepCabUgmjFZA+ov1cDbvCQWwoxk10uJ7tfKpeAwyJu91HVkKLnvx?=
 =?us-ascii?Q?yhAUyosmFFrqYPC5oCKRn3n9Otsm7uQJMvkuhGqNZ/RXmxVCUxKEGYTmN+0Q?=
 =?us-ascii?Q?/rVoCIwPx6NE957tO/dMrmAY9x910S1mYE8to/SqO6eCQtcsim6bfglikYA8?=
 =?us-ascii?Q?qBPjBt8fFgMnueXBDt170S6bQusP8R7bKCY8rVrMyaCxiMfKCBLf/mjM3VpL?=
 =?us-ascii?Q?YgziTpITVYXRBhj8d9392ZEjtHVjtbaLzaV25n1HtYapJhsOJimj8xawXWiX?=
 =?us-ascii?Q?E3BA8Lldy67ztntEl2yGt+mRfH0WFPLYjV4Sh41Y9LVaCYbiGddUXJKJlqC3?=
 =?us-ascii?Q?QY97/4O//1MA3IPYo9BvAqxLSq+/3YHgK8VG/q92u85wVkBuzJkyhJVKAs92?=
 =?us-ascii?Q?tkk+7/vAGc9O+p3XXTs9jPgjyzbktajImQaZUsDhb5lqD68kFzhDqoHOXbTh?=
 =?us-ascii?Q?3w+3CkgFr0fvU6Ez9rSymxaeXDgbAYgQCgChYy2ZEGguecc8joEx9r9ACESu?=
 =?us-ascii?Q?UQznJWDFemN9AhU6cF1MhJI8SBtHo9d6Rx7E0VOo33yTeDYk4J6sOAPusmhw?=
 =?us-ascii?Q?2Sj3N7DZpVJH3LQMSsmYsFJQ3ymIlvNvdugDWOYYYKrWYZvx60iR85JnIaDK?=
 =?us-ascii?Q?6ng0+1JHQhHYhRvBL6bBO7qBfihk6ww2qEwMMc2b8Xl+2EfXdVigyejt19pp?=
 =?us-ascii?Q?lC//ji8Qq+hpByYtsM2TIpjqKkJ6q9vTg+HndWSyfm0jaWzFokR7TMBb9GHZ?=
 =?us-ascii?Q?+V/EsxER/XSEdaBA7fh4+UmPIXvTfT6+Snvr38UUqpJokB+CnWzhIlu7DaVS?=
 =?us-ascii?Q?+bQRjT9wskwvmH2QgdAQCoiy56nQz3YFcDe3QfuDSsdD6rfAlzw6GWtgID6Z?=
 =?us-ascii?Q?6CfUbLr6YScCt52t9Goge8kajv01ixlYPwg9JXFbrxRLLYxBnll/Ho+uZwJR?=
 =?us-ascii?Q?IhZU3z1LPp0xdZ1wNURfnZFqwGYWbgHDcbvu4JWold88YgV91L0QtrYw7X1K?=
 =?us-ascii?Q?Y9sd5OTYq7hKYngRsD7HfrVL4AGx6udbNC7/vvay8OYUP+pA+0FP3DjOx7Lr?=
 =?us-ascii?Q?e4s+4q8WRMrd9lvqBiuzop44JonoK0GmTIZY0xB7PuTFeY9MvG3kFNAQZHk3?=
 =?us-ascii?Q?vQ0OEHOYNW+Ok5VGYXbWPHyBQMJfofLo2Yxt4dYIj/tToiGaRagI154lyvic?=
 =?us-ascii?Q?a9SkYtH7507RgUdXUP5Qm+ZaWuMJG0h0gB805AG86/6P1ruAKedczDPAa9fi?=
 =?us-ascii?Q?WcapdWG948D0PC4SSgbyxMfL5LWaqRUgjliHCWUZBKyXuZDIadd1m/8VX0m5?=
 =?us-ascii?Q?oCtTG6is2EmtCRE9TiA+FyF18kgfk2DIUYS84BmvHoQDHDewwSCY2ygkTTI/?=
 =?us-ascii?Q?JeP17fUmB/5/GcblY59ycOYTT74JfFluYLHpt5Fps8eB9YLGKnJX3yy+LrID?=
 =?us-ascii?Q?QtOiBWn9vNEZd9TIa+1wIb+G4HhnH5ZKPj6Yu/joEjbZwtrRHUGViqWCLG+h?=
 =?us-ascii?Q?xdj4JQJ8+uEGQpW/PmZZ4u8pDeB8P6roJH1f41gkxwoJvUQGp+y1/CGya3g6?=
 =?us-ascii?Q?owsInEYSMrWENrBovY7fJg4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSQP153MB1307.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b7743c26-a5a7-40ef-a240-08ddd502b319
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2025 16:02:52.7747 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ngG92hCUNASoD5jFjN+8xxMM3Y+P/SXou6fftZZQDjKd6+VOLosHTAEAhyhNg4YXcBxKaL3GMiZCtavBORqzYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI4P153MB1072
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
> From: longli@linuxonhyperv.com <longli@linuxonhyperv.com>
> Sent: Wednesday, July 30, 2025 8:10 AM
> To: Stephen Hemminger <stephen@networkplumber.org>; Wei Hu
> <weh@microsoft.com>
> Cc: dev@dpdk.org; Long Li <longli@microsoft.com>
> Subject: [EXTERNAL] [Patch v7 0/4] Support VMBUS channels without
> monitoring enabled
>=20
> From: Long Li <longli@microsoft.com>
>=20
> Hyperv may expose VMBUS channels without monitoring enabled. In this
> case, it programs almost all the data traffic to VF.
>=20
> This patchset enabled vmbus/netvsc to use channels without monitoring
> enabled.
>=20
> This needs to change the APIs exposed by drivers/bus/vmbus. Because those
> APIs are used only by NetVSC PMD and not feasible for use by a DPDK
> application, all VMBUS APIs are set to deprecate in upcoming 25.11 releas=
e.
>=20
> The notice for deprecation is accepted in the following patch:
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatc
> hwork.dpdk.org%2Fproject%2Fdpdk%2Fpatch%2F1742242184-19600-1-
> git-send-email-
> longli%40linuxonhyperv.com%2F&data=3D05%7C02%7Cweh%40microsoft.com
> %7C31b5d1d8465a4a7e2e7208ddcefd648b%7C72f988bf86f141af91ab2d7
> cd011db47%7C1%7C0%7C638894309981905236%7CUnknown%7CTWFpb
> GZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4z
> MiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DAi4Y01e
> rExEqaHxj5NV9oo2gdDdh%2FELHRQusxShm2W4%3D&reserved=3D0
>=20
> Change log:
> v3: Add in the comment on the VMBUS API deprecation notice
> v7: Dropped the first two patches in the seires as they have already been
> applied to net-next
>=20
> Long Li (4):
>   bus/vmbus: store UIO fd for secondary process
>   bus/vmbus: support channels without monitoring enabled
>   bus/vmbus: add rte_vmbus_device to all functions accessing vmbus
>   bus/vmbus: set event for channel without monitoring support
>=20
>  drivers/bus/vmbus/linux/vmbus_bus.c  |  9 +++--
> drivers/bus/vmbus/linux/vmbus_uio.c  |  6 ++--
>  drivers/bus/vmbus/private.h          |  2 +-
>  drivers/bus/vmbus/rte_bus_vmbus.h    | 16 ++++++---
>  drivers/bus/vmbus/vmbus_channel.c    | 53 ++++++++++++++++++++--------
>  drivers/bus/vmbus/vmbus_common_uio.c |  9 +++--
>  drivers/net/netvsc/hn_nvs.c          | 18 +++++-----
>  drivers/net/netvsc/hn_nvs.h          | 15 ++++----
>  drivers/net/netvsc/hn_rndis.c        | 11 +++---
>  drivers/net/netvsc/hn_rxtx.c         | 16 ++++-----
>  10 files changed, 97 insertions(+), 58 deletions(-)
>=20
> --
> 2.25.1

Reviewed-by: Wei Hu <weh@microsoft.com>

