Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4803CA600B
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 07:17:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 782BB4027B;
	Thu,  8 Oct 2026 09:17:32 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011060.outbound.protection.outlook.com
 [40.93.194.60]) by mails.dpdk.org (Postfix) with ESMTP id 7A3BF40274
 for <dev@dpdk.org>; Thu,  8 Oct 2026 09:17:30 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOSLNfVbnyoHb0EEMiyK1vf/gGAi0lrpxzaD+/7dQkxSfpeTv3UcJWN5PWv/LLtMs1zfcZURvnHZJUb9vZKTazAXPe9Bul+Vp5DQBbgD5Tp6bNrGUMiGl09w8MrpLZiENyXlppi97KhqhwRWmITncms/z0+anWUDcqhywhfytzmu+ehgjqWDcbWMr5y2Wgx2i6jhG5OduPnfbkFR5cFeHenqVzQdTOE03pCS8cfK67LGkkYUozpW8qmZ9PacEJsKugYj8SDIjI5BXGqi/+6jcglHKvN3JCfbj10/W7Xnu5TnxpGoviOPZ8nkxHP4c6p/y7y0xgUqiCXD4ayDgfjhNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fy+J8TIOV8wF2LdQJetcmy0nPjHAcy17AFHQJcXGYsM=;
 b=qxTeQ5rTzxy8oRLr3d0rrtK3rMLMEBpnaRoFJ6Xaa6d0rC2kb9EQ+/ZyjzpNKuyucw0HgEr8ivkknlr5qXp09sWk3yYvib4pVZLFLxTaaWEqR+3SYEHqvAOpRcJrWhCZ6VGWqYZyL4hnVl45BqLo3fTsp+OrESuOJ9K05g6xbqPUrl1V/EMjdrfL/CIEgNWCXAkwJZk5z7qRylIxd0Tijm+NHX8l7mWl5HqBA04UEY2WT9xbHZOKsH/V2bqz44KRD2GdcAjTrxWxqZ7ymqJOMf29slyF/f6z1HPnLxQI5r4TOL7q++ERCV85urzSiAdLEdysEJBtyyzgAz/upqkcGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fy+J8TIOV8wF2LdQJetcmy0nPjHAcy17AFHQJcXGYsM=;
 b=rGZiIfi0S/90MdMlIUNffyUkDHy51ASmV9FZnoIGwP1P1hGfFdjIekwmI9j6CktPzRyteaotdEK+ylH5y3EJxeuSA3H9HDUu+JVQ4Xi9RQpJ+pWL9UsN/tmeoSirdh0TFXQg+B0RR/9DPEiSxJBmL8yCxsLwkfPoKnvCUkEcseHD7dYbQ16IxvyMxmuy5jRy3E44hzKBVWKg4kxQP5nDY9amwVp0hABVPBWSridASLi7bNB0InkjApmB2CePpOdEW6sdQlzOtaiPPmTQ0aD4TTBaV3QGfJ9K+Pukp5Z0H6aPFfauMtM4rnVZ1vKRZnU0xBldTc7vwL/Z67zy9RA2XA==
Received: from BN9PR12MB5338.namprd12.prod.outlook.com (2603:10b6:408:103::23)
 by SJ0PR12MB7068.namprd12.prod.outlook.com (2603:10b6:a03:4ae::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 8 Oct
 2026 07:17:26 +0000
Received: from BN9PR12MB5338.namprd12.prod.outlook.com
 ([fe80::7b66:315e:f851:8ddb]) by BN9PR12MB5338.namprd12.prod.outlook.com
 ([fe80::7b66:315e:f851:8ddb%6]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 07:17:26 +0000
From: Bing Zhao <bingz@nvidia.com>
To: Bing Zhao <bingz@nvidia.com>, Slava Ovsiienko <viacheslavo@nvidia.com>,
 "dev@dpdk.org" <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>
CC: Ori Kam <orika@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>
Subject: RE: [PATCH v6] ethdev: support inline calculating masked item value
Thread-Topic: [PATCH v6] ethdev: support inline calculating masked item value
Thread-Index: AQHdVn1VueyQuVRzr0ymMywtyxDdhbbzPPCA
Date: Thu, 8 Oct 2026 07:17:26 +0000
Message-ID: <BN9PR12MB53386A2486E9D3559A59BDF4D0932@BN9PR12MB5338.namprd12.prod.outlook.com>
References: <20260610052729.5637-1-bingz@nvidia.com>
 <20261007165904.126976-1-bingz@nvidia.com>
In-Reply-To: <20261007165904.126976-1-bingz@nvidia.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-Mentions: stephen@networkplumber.org
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5338:EE_|SJ0PR12MB7068:EE_
x-ms-office365-filtering-correlation-id: 30ece9ba-c789-4def-2516-08df250c34ee
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|38070700021|18002099003|22082099003|3023799007|4143699003|11063799006|10067099003|56012099006;
x-microsoft-antispam-message-info: 8ehF7LS+QfR4BCO+E2z2yrRNPL1VwnuWjyGhCOVpKbB4+dzG41P8C5afdTn1ntsTvROL1e5VzvEX/WbjxSrhufoSb5rY+JLDuMGkTvX9x1cQ4lDoT8HWZFNXgTZTMhJiqErTibAnPMZGfAkrhdSp9c0yWPSEmf1Cgx8+KdCcoLpzkRq4oNEaIyEiSh1JrMPH/OKXHN6ZNSKLURolbPqAd8B5yWhnRCLs7415UolaYEjOyKtTKDgw2eWwsKgoRmEt49XLaw0nsw5DbV2gAcSm6WixoAAJppVrgui2gk6lgnshj6Fr8VfL4Cd3MiJzTiNinJ6QcBm6rpbY3qOlAXNIi6OJjRDQ3z/jRhm9G1z0MjGaJVZBoqwGfQfMZcCvt2TA4LRa8KiEBKzDcP3vSQbC8BAwnWve6afkbNeR1dvwdlR+TAwP7U0W16LiA1bAk7/Mmx/7Dju9xqUvIOdaPBc/Nmzv6NaK3YWogsyXFP62b6DcE/aviJsHPYJqRJssoI554RqDhhJMv0+hLJ1XxohucRqeZ2+PNPAwJbuWreb62GhBAI0fmKvOM2PEhZIZGCWw6OEwSTlyuJT6sTebxVn2ldnyC76EM1mnyeD5CgmPN1Rs0Y1vBlyP0WwSbAb9CO9AG6ncQuItd3OqYYO22wNcwoaSsmgYFBsFLxvkUB6EF2hcIciQ3TNY+iM0XHi1srp+Oke5vJpeE+1yJIJtQG9Wkedx7DcMrv+poaSJhxw8SVw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5338.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(38070700021)(18002099003)(22082099003)(3023799007)(4143699003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?06yITzof9/PIpK1CVAKoM8mr2QPZ3FwmDwFlMKQPk4QFUi36Nx1ZizEDiEGh?=
 =?us-ascii?Q?Jg9N/hsauSg5qmf0fVjpEX2xSZJvrz+mcSIiVnwg+0uLrOJKbcu+ffDcPMEk?=
 =?us-ascii?Q?MHbosuwU8VvNZJusxuYtQcsSrxIEXLI5mFbtetR4hmLK7UkJBZnHskgSGjy+?=
 =?us-ascii?Q?kop/h6RRTZsM1YgswG5GKlmjcPbZ384fkiDmmfpBVGh5uOBy1UDcb31IfDEF?=
 =?us-ascii?Q?1pHkD1Fj+FMY8JwxNtJDUL3BTRWFH8nf7nf4hfxMSkIZrUFg3qB7L8gUxZRi?=
 =?us-ascii?Q?0/g0rUQqFijx6Kkb8hqvbQHHUgBQPiNIR7knf1y8u/1eWzyQhY3sQiQnfxV6?=
 =?us-ascii?Q?iE3L5pnXhEls07vbfjRuVCAkdWP8Ts8VvaP+fD2hQxHpFxc+VgLjdOpDEnNx?=
 =?us-ascii?Q?w4bfSMnxrZqWYUWSvPoiMPB4cAeu4pihgU2hqz02QZO4Mx4SyFgQ+04pclRk?=
 =?us-ascii?Q?2wKk2Fm328B5OxSHBDCrHVwvWyk3yVWor9LHUx4iVoobxpcd/eFfCX+mlyiy?=
 =?us-ascii?Q?+THmw8R1YQ4kyGRgzvdB06qufA7Pa63541AiEBiMrIrBGC8pyMrEYqH5QF+O?=
 =?us-ascii?Q?o0ScZPPlmRW9KPTyOvv5jk1lr2w/d2aN0uUxUD+Sl9elMDnDmRmcOcSkHs1Z?=
 =?us-ascii?Q?6cVMqyGARfcpMDqBd2rMi8yd2W/SBJseG20Thfl0mHcp+KoFKkNv8U0CFN6z?=
 =?us-ascii?Q?gyOWT0HLR99HOHmvy1/BT0B8lOBGsJKHMN0aCnBlYyuZ9z5heUzwl9o17g35?=
 =?us-ascii?Q?pP9JfoIg2IeD5RK91mOAI2lISdrei9fBxwXIsDIrSXa96Mf47zlqDln+AG3X?=
 =?us-ascii?Q?A5vQQSdRF0t/55Sygm08q2KkJMX1ZyL0ybQrXaerBdgKweERctYiuODB2MXt?=
 =?us-ascii?Q?0TSuMGFw6QHN84uOwzp2fuoOGo4cr8brJ5kFjca+UYXWYS/Xbv4gbBeyVhGV?=
 =?us-ascii?Q?SmJCyXiYrmGGcqSMulUZEnDQljBtwki7T4dwCCoW9Wvem55FNL8LB1LVQDbR?=
 =?us-ascii?Q?nV80/QwejC/fSpHhW585OW1PDjQBGAYAlIfI+26uUBdliJs+hzSIvj1V8ZOp?=
 =?us-ascii?Q?KQayQRRs9TdbZipJB2KZb7Zs+HLDj8syXJ5r56c8YZLCjTMLJ7ka4wb2mqrx?=
 =?us-ascii?Q?oN7uXMPNfymBNaeJK4mdUiS3P+X72xwA8YcQSSAKrF1HA4xVtyhJHULXrdw9?=
 =?us-ascii?Q?ymZeAQXoK7F3CrVVciCXYH2mAobUxVhenT855sjzf0NMACNTIEMIaQsDkt/X?=
 =?us-ascii?Q?WZV40dqIc119F7fnb38X6JmE55wkzk9keuEdlucgz3t5dNbpgBAkOlXCCC2E?=
 =?us-ascii?Q?21C2tq4FuyjaHK3qlfzSj/GZ3wC4Ifz1xtZfIvcp3XzNfhkmRB00P3WLZROX?=
 =?us-ascii?Q?Xa+KqGpqaAQ8OBwLEApNbZsSHx8lcVMFxq+lBArklcZ+sYvBvcj6T2m1u0V2?=
 =?us-ascii?Q?KwZTFW8XmCAu/O4OkPdQyZHwIKqo7arYl9oBCxkg3NoM2oozkFOmwuk2FM14?=
 =?us-ascii?Q?bdZpKmZXWtACvWOEyo0bmsUkDzpgzbZ4mj/svCgsypoZR4I2cV3GrvOUGtLq?=
 =?us-ascii?Q?m14pDhyBFvKwRFsY29mjEYtG9EVFMW3fZUoj43f8j0J3gDq0UinqKReH1PKA?=
 =?us-ascii?Q?JRPqBXLT9LyNYYIZOYAeGBfhg0g8V1g62e7c3KTU1X5m8qceTxoUkMop+QBR?=
 =?us-ascii?Q?WKpN4P3sXzo1h185Asfjv5QidBb5ICkImOVtSO7ra9tyzb0d?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5338.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ece9ba-c789-4def-2516-08df250c34ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 07:17:26.7581 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u4OLW66iWpgCOnSMV0fP1GCCPtPVt/txODeuvQW2BaCMRcQCMSKiy89xvkLSKI8EIdFPfg9aBcP8YCB7hA9xyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7068
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

No. The three errors in that AI review are not valid, and the warnings do n=
ot block this patch.

rte_flow_conv_item_spec() returns size_t, the number of bytes to copy. It d=
oes not return a negative errno. In rte_flow_conv_pattern() the local ret i=
s also size_t, so if (ret < 0) is always false and cannot be the missing ch=
eck the review describes. That copy pattern was already there for spec, las=
t, and mask. This patch only ANDs the mask onto a buffer after that copy ha=
s produced a pointer.

The other notes are process nits:

The with_mask comment is already clear.
A release note belongs in the current release file, not release_25_03.rst. =
This master has no current notes file, and release_26_07.rst is gone, which=
 is why that hunk was dropped.
RTE_FLOW_CONV_OP_PATTERN_MASKED is one new enumerator at the end of an exis=
ting enum. It cannot be tagged __rte_experimental, and existing callers of =
rte_flow_conv() are unchanged.

https://mails.dpdk.org/archives/test-report/2026-October/1057123.html

@stephen@networkplumber.org, FYI

> -----Original Message-----
> From: Bing Zhao <bingz@nvidia.com>
> Sent: Thursday, October 8, 2026 12:58 AM
> To: Slava Ovsiienko <viacheslavo@nvidia.com>; dev@dpdk.org; Raslan
> Darawsheh <rasland@nvidia.com>; stephen@networkplumber.org
> Cc: Ori Kam <orika@nvidia.com>; Dariusz Sosnowski <dsosnowski@nvidia.com>=
;
> Suanming Mou <suanmingm@nvidia.com>; Matan Azrad <matan@nvidia.com>; NBU-
> Contact-Thomas Monjalon (EXTERNAL) <thomas@monjalon.net>
> Subject: [PATCH v6] ethdev: support inline calculating masked item value
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> In the asynchronous API definition and some drivers, the rte_flow_item
> spec value may not be calculated by the driver due to the reason of speed
> of light rule insertion rate and sometimes the input parameters will be
> copied and changed internally.
>=20
> After copying, the spec and last will be protected by the keyword const
> and cannot be changed in the code itself. And also the driver needs some
> extra memory to do the calculation and extra conditions to understand the
> length of each item spec. This is not efficient.
>=20
> To solve the issue and support usage of the following fix, a new OP was
> introduced to calculate the spec and last values after applying the mask
> inline.
>=20
> Signed-off-by: Bing Zhao <bingz@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> ---
> v3:
>   - add test code
>   - fix the issue found by AI
> v4: reabse on top of the main
> v5: handle some items separately and add test for them
> v6: resend the correct version instead of v5 with AI defects resolved
> ---
>  app/test/test_ethdev_api.c | 123 +++++++++++++++++++++++++++++++++++++
>  lib/ethdev/rte_flow.c      |  55 +++++++++++++++--
>  lib/ethdev/rte_flow.h      |  13 ++++
>  3 files changed, 185 insertions(+), 6 deletions(-)
>=20
> diff --git a/app/test/test_ethdev_api.c b/app/test/test_ethdev_api.c inde=
x
> 00d6a5c614..ba3e785425 100644
> --- a/app/test/test_ethdev_api.c
> +++ b/app/test/test_ethdev_api.c
> @@ -2,8 +2,11 @@
>   * Copyright (C) 2023, Advanced Micro Devices, Inc.
>   */
>=20
> +#include <string.h>
> +
>  #include <rte_log.h>
>  #include <rte_ethdev.h>
> +#include <rte_flow.h>
>=20
>  #include <rte_test.h>
>  #include "test.h"
> @@ -15,6 +18,125 @@
>  #define NUM_MBUF 1024
>  #define MBUF_CACHE_SIZE 256
>=20
> +static int32_t
> +ethdev_api_flow_conv_pattern_masked(void)
> +{
> +       const struct rte_flow_item_eth spec =3D {
> +               .hdr.dst_addr.addr_bytes =3D { 0x01, 0x02, 0x03, 0x04, 0x=
05,
> 0x06 },
> +               .hdr.src_addr.addr_bytes =3D { 0x0a, 0x0b, 0x0c, 0x0d, 0x=
0e,
> 0x0f },
> +               .hdr.ether_type =3D RTE_BE16(0x1234),
> +       };
> +       const struct rte_flow_item_eth last =3D {
> +               .hdr.dst_addr.addr_bytes =3D { 0x11, 0x12, 0x13, 0x14, 0x=
15,
> 0x16 },
> +               .hdr.src_addr.addr_bytes =3D { 0x1a, 0x1b, 0x1c, 0x1d, 0x=
1e,
> 0x1f },
> +               .hdr.ether_type =3D RTE_BE16(0x5678),
> +       };
> +       const struct rte_flow_item_eth mask =3D {
> +               .hdr.dst_addr.addr_bytes =3D { 0xff, 0xff, 0x00, 0x00, 0x=
ff,
> 0xff },
> +               .hdr.src_addr.addr_bytes =3D { 0xff, 0x00, 0xff, 0x00, 0x=
ff,
> 0x00 },
> +               .hdr.ether_type =3D RTE_BE16(0xffff),
> +       };
> +       const uint8_t raw_pattern[] =3D { 0xaa, 0xbb, 0xcc, 0xdd };
> +       const struct rte_flow_item_raw raw_spec =3D {
> +               .relative =3D 1,
> +               .search =3D 1,
> +               .offset =3D 8,
> +               .limit =3D 4,
> +               .length =3D sizeof(raw_pattern),
> +               .pattern =3D raw_pattern,
> +       };
> +       const struct rte_flow_item_raw raw_mask =3D {
> +               .relative =3D 1,
> +               .search =3D 0,
> +               .reserved =3D 0x3fffffff,
> +               .offset =3D 0xffffffff,
> +               .limit =3D 0xffff,
> +               .length =3D 0xffff,
> +               .pattern =3D NULL,
> +       };
> +       const struct rte_flow_item pattern[] =3D {
> +               {
> +                       .type =3D RTE_FLOW_ITEM_TYPE_ETH,
> +                       .spec =3D &spec,
> +                       .last =3D &last,
> +                       .mask =3D &mask,
> +               },
> +               {
> +                       .type =3D RTE_FLOW_ITEM_TYPE_RAW,
> +                       .spec =3D &raw_spec,
> +                       .mask =3D &raw_mask,
> +               },
> +               { .type =3D RTE_FLOW_ITEM_TYPE_END },
> +       };
> +       union {
> +               struct rte_flow_item item;
> +               struct rte_flow_item_eth eth;
> +               struct rte_flow_item_raw raw;
> +               double align;
> +               uint8_t buf[256];
> +       } dst;
> +       const struct rte_flow_item *item;
> +       const struct rte_flow_item_eth *conv_spec;
> +       const struct rte_flow_item_eth *conv_last;
> +       const struct rte_flow_item_raw *conv_raw_spec;
> +       int ret;
> +
> +       ret =3D rte_flow_conv(RTE_FLOW_CONV_OP_PATTERN_MASKED, NULL, 0,
> pattern, NULL);
> +       TEST_ASSERT(ret > 0, "Masked pattern conversion size query
> failed");
> +       TEST_ASSERT((size_t)ret <=3D sizeof(dst.buf),
> +                   "Masked pattern conversion needs too much storage");
> +
> +       memset(&dst, 0, sizeof(dst));
> +       ret =3D rte_flow_conv(RTE_FLOW_CONV_OP_PATTERN_MASKED, dst.buf,
> +                           sizeof(dst.buf), pattern, NULL);
> +       TEST_ASSERT(ret > 0, "Masked pattern conversion failed");
> +
> +       item =3D (const struct rte_flow_item *)dst.buf;
> +       conv_spec =3D item[0].spec;
> +       conv_last =3D item[0].last;
> +       TEST_ASSERT_NOT_NULL(conv_spec, "Converted spec must be set");
> +       TEST_ASSERT_NOT_NULL(conv_last, "Converted last must be set");
> +
> +       TEST_ASSERT_EQUAL(conv_spec->hdr.dst_addr.addr_bytes[0], 0x01,
> +                         "Masked spec dst byte 0 mismatch");
> +       TEST_ASSERT_EQUAL(conv_spec->hdr.dst_addr.addr_bytes[2], 0x00,
> +                         "Masked spec dst byte 2 mismatch");
> +       TEST_ASSERT_EQUAL(conv_spec->hdr.src_addr.addr_bytes[1], 0x00,
> +                         "Masked spec src byte 1 mismatch");
> +       TEST_ASSERT_EQUAL(conv_spec->hdr.ether_type, RTE_BE16(0x1234),
> +                         "Masked spec ether type mismatch");
> +       TEST_ASSERT_EQUAL(conv_last->hdr.dst_addr.addr_bytes[0], 0x11,
> +                         "Masked last dst byte 0 mismatch");
> +       TEST_ASSERT_EQUAL(conv_last->hdr.dst_addr.addr_bytes[2], 0x00,
> +                         "Masked last dst byte 2 mismatch");
> +       TEST_ASSERT_EQUAL(conv_last->hdr.src_addr.addr_bytes[1], 0x00,
> +                         "Masked last src byte 1 mismatch");
> +       TEST_ASSERT_EQUAL(conv_last->hdr.ether_type, RTE_BE16(0x5678),
> +                         "Masked last ether type mismatch");
> +
> +       conv_raw_spec =3D item[1].spec;
> +       TEST_ASSERT_NOT_NULL(conv_raw_spec, "Converted RAW spec must be
> set");
> +       TEST_ASSERT_NOT_NULL(conv_raw_spec->pattern,
> +                            "Converted RAW pattern pointer must be set")=
;
> +       TEST_ASSERT(conv_raw_spec->pattern !=3D raw_pattern,
> +                   "Converted RAW pattern must be deep-copied");
> +       TEST_ASSERT_EQUAL(conv_raw_spec->relative, 1,
> +                         "Masked RAW relative mismatch");
> +       TEST_ASSERT_EQUAL(conv_raw_spec->search, 0,
> +                         "Masked RAW search mismatch");
> +       TEST_ASSERT_EQUAL(conv_raw_spec->offset, raw_spec.offset,
> +                         "Masked RAW offset mismatch");
> +       TEST_ASSERT_EQUAL(conv_raw_spec->limit, raw_spec.limit,
> +                         "Masked RAW limit mismatch");
> +       TEST_ASSERT_EQUAL(conv_raw_spec->length, raw_spec.length,
> +                         "Masked RAW length mismatch");
> +       TEST_ASSERT_BUFFERS_ARE_EQUAL(conv_raw_spec->pattern, raw_pattern=
,
> +                                     sizeof(raw_pattern),
> +                                     "Converted RAW pattern mismatch");
> +
> +       return TEST_SUCCESS;
> +}
> +
>  static int32_t
>  ethdev_api_queue_status(void)
>  {
> @@ -167,6 +289,7 @@ static struct unit_test_suite ethdev_api_testsuite =
=3D {
>         .setup =3D NULL,
>         .teardown =3D NULL,
>         .unit_test_cases =3D {
> +               TEST_CASE(ethdev_api_flow_conv_pattern_masked),
>                 TEST_CASE(ethdev_api_queue_status),
>                 /* TODO: Add deferred_start queue status test */
>                 TEST_CASES_END() /**< NULL terminate unit test array */
> diff --git a/lib/ethdev/rte_flow.c b/lib/ethdev/rte_flow.c index
> ca2f85c3fa..e4efcbf10f 100644
> --- a/lib/ethdev/rte_flow.c
> +++ b/lib/ethdev/rte_flow.c
> @@ -175,6 +175,23 @@ static const struct rte_flow_desc_data
> rte_flow_desc_item[] =3D {
>         MK_FLOW_ITEM(COMPARE, sizeof(struct rte_flow_item_compare)),  };
>=20
> +static inline size_t
> +rte_flow_conv_item_mask_size(const struct rte_flow_item *item) {
> +       if ((int)item->type < 0)
> +               return sizeof(void *);
> +       switch (item->type) {
> +       case RTE_FLOW_ITEM_TYPE_RAW:
> +               return offsetof(struct rte_flow_item_raw, pattern);
> +       case RTE_FLOW_ITEM_TYPE_GENEVE_OPT:
> +               return offsetof(struct rte_flow_item_geneve_opt, data);
> +       default:
> +               if (rte_flow_desc_item[item->type].desc_fn !=3D NULL)
> +                       return 0;
> +               return rte_flow_desc_item[item->type].size;
> +       }
> +}
> +
>  /** Generate flow_action[] entry. */
>  #define MK_FLOW_ACTION(t, s) \
>         [RTE_FLOW_ACTION_TYPE_ ## t] =3D { \ @@ -797,6 +814,8 @@
> rte_flow_conv_action_conf(void *buf, const size_t size,
>   *   RTE_FLOW_ITEM_TYPE_END is encountered.
>   * @param[out] error
>   *   Perform verbose error reporting if not NULL.
> + * @param[in] with_mask
> + *   If true, @p src mask will be applied to spec and last.
>   *
>   * @return
>   *   A positive value representing the number of bytes needed to store
> @@ -809,12 +828,13 @@ rte_flow_conv_pattern(struct rte_flow_item *dst,
>                       const size_t size,
>                       const struct rte_flow_item *src,
>                       unsigned int num,
> +                     bool with_mask,
>                       struct rte_flow_error *error)  {
>         uintptr_t data =3D (uintptr_t)dst;
>         size_t off;
>         size_t ret;
> -       unsigned int i;
> +       unsigned int i, j;
>=20
>         for (i =3D 0, off =3D 0; !num || i !=3D num; ++i, ++src, ++dst) {
>                 /**
> @@ -838,15 +858,27 @@ rte_flow_conv_pattern(struct rte_flow_item *dst,
>         src -=3D num;
>         dst -=3D num;
>         do {
> +               uint8_t *c_spec =3D NULL, *c_last =3D NULL;
> +               const uint8_t *mask =3D src->mask;
> +               size_t item_mask_size =3D mask ?
> + rte_flow_conv_item_mask_size(src) : 0;
> +
>                 if (src->spec) {
>                         off =3D RTE_ALIGN_CEIL(off, sizeof(double));
>                         ret =3D rte_flow_conv_item_spec
>                                 ((void *)(data + off),
>                                  size > off ? size - off : 0, src,
>                                  RTE_FLOW_CONV_ITEM_SPEC);
> -                       if (size && size >=3D off + ret)
> +                       if (size && size >=3D off + ret) {
>                                 dst->spec =3D (void *)(data + off);
> +                               c_spec =3D (uint8_t *)(data + off);
> +                       }
>                         off +=3D ret;
> +                       if (with_mask && c_spec && mask) {
> +                               size_t mask_size =3D RTE_MIN(ret,
> + item_mask_size);
> +
> +                               for (j =3D 0; j < mask_size; j++)
> +                                       c_spec[j] &=3D mask[j];
> +                       }
>=20
>                 }
>                 if (src->last) {
> @@ -855,9 +887,17 @@ rte_flow_conv_pattern(struct rte_flow_item *dst,
>                                 ((void *)(data + off),
>                                  size > off ? size - off : 0, src,
>                                  RTE_FLOW_CONV_ITEM_LAST);
> -                       if (size && size >=3D off + ret)
> +                       if (size && size >=3D off + ret) {
>                                 dst->last =3D (void *)(data + off);
> +                               c_last =3D (uint8_t *)(data + off);
> +                       }
>                         off +=3D ret;
> +                       if (with_mask && c_last && mask) {
> +                               size_t mask_size =3D RTE_MIN(ret,
> + item_mask_size);
> +
> +                               for (j =3D 0; j < mask_size; j++)
> +                                       c_last[j] &=3D mask[j];
> +                       }
>                 }
>                 if (src->mask) {
>                         off =3D RTE_ALIGN_CEIL(off, sizeof(double)); @@ -
> 1004,7 +1044,7 @@ rte_flow_conv_rule(struct rte_flow_conv_rule *dst,
>                 off =3D RTE_ALIGN_CEIL(off, sizeof(double));
>                 ret =3D rte_flow_conv_pattern((void *)((uintptr_t)dst +
> off),
>                                             size > off ? size - off : 0,
> -                                           src->pattern_ro, 0, error);
> +                                           src->pattern_ro, 0, false,
> + error);
>                 if (ret < 0)
>                         return ret;
>                 if (size && size >=3D off + (size_t)ret) @@ -1104,7 +1144=
,7
> @@ rte_flow_conv(enum rte_flow_conv_op op,
>                 ret =3D sizeof(*attr);
>                 break;
>         case RTE_FLOW_CONV_OP_ITEM:
> -               ret =3D rte_flow_conv_pattern(dst, size, src, 1, error);
> +               ret =3D rte_flow_conv_pattern(dst, size, src, 1, false,
> + error);
>                 break;
>         case RTE_FLOW_CONV_OP_ITEM_MASK:
>                 item =3D src;
> @@ -1119,7 +1159,7 @@ rte_flow_conv(enum rte_flow_conv_op op,
>                 ret =3D rte_flow_conv_actions(dst, size, src, 1, error);
>                 break;
>         case RTE_FLOW_CONV_OP_PATTERN:
> -               ret =3D rte_flow_conv_pattern(dst, size, src, 0, error);
> +               ret =3D rte_flow_conv_pattern(dst, size, src, 0, false,
> + error);
>                 break;
>         case RTE_FLOW_CONV_OP_ACTIONS:
>                 ret =3D rte_flow_conv_actions(dst, size, src, 0, error); =
@@
> -1139,6 +1179,9 @@ rte_flow_conv(enum rte_flow_conv_op op,
>         case RTE_FLOW_CONV_OP_ACTION_NAME_PTR:
>                 ret =3D rte_flow_conv_name(1, 1, dst, size, src, error);
>                 break;
> +       case RTE_FLOW_CONV_OP_PATTERN_MASKED:
> +               ret =3D rte_flow_conv_pattern(dst, size, src, 0, true,
> error);
> +               break;
>         default:
>                 ret =3D rte_flow_error_set
>                 (error, ENOTSUP, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
> diff --git a/lib/ethdev/rte_flow.h b/lib/ethdev/rte_flow.h index
> f864578f80..2261d1ea06 100644
> --- a/lib/ethdev/rte_flow.h
> +++ b/lib/ethdev/rte_flow.h
> @@ -4544,6 +4544,19 @@ enum rte_flow_conv_op {
>          *   @code const char ** @endcode
>          */
>         RTE_FLOW_CONV_OP_ACTION_NAME_PTR,
> +
> +       /**
> +        * Convert an entire pattern.
> +        *
> +        * Duplicates all pattern items at once, applying each source ite=
m
> mask
> +        * to its copied specification and range.
> +        *
> +        * - @p src type:
> +        *   @code const struct rte_flow_item * @endcode
> +        * - @p dst type:
> +        *   @code struct rte_flow_item * @endcode
> +        */
> +       RTE_FLOW_CONV_OP_PATTERN_MASKED,
>  };
>=20
>  /**
> --
> 2.43.0

