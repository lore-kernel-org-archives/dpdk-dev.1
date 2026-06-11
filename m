Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FACCD8C9D
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 04:55:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5DA5D40612;
	Thu, 11 Jun 2026 06:55:21 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010065.outbound.protection.outlook.com [52.101.46.65])
 by mails.dpdk.org (Postfix) with ESMTP id 19E34402CE
 for <dev@dpdk.org>; Thu, 11 Jun 2026 06:55:20 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pb3W44i6CE39LfglvYkfvp+eId8aPh8VxtytEEmPaRnA5Knr6p4JNxHpBSj/nOsM85QN93let0yJGigGxELC/GZDQODL7LWKB+MqBklyH655JjTG+UNDYlK/OGP/M4mdkI+UM+hD+AJd9/ZtySN+CtZ4gM7+ncAUgwqVtnIFnEEeqVfZZNkhOLdKnx9a7pFA5plYScxYibHkilXfj+tukNxccTQHBtRjYzCnESGCfekStWAitjP6RHnMB8aZ3NfWkSDXholUV+kY+nC/Zr25lf+T8hnwwzgx03tTkJIpEZua/P8UOU5AGFZ8Ic+ytN3Fs7INc/4eNEtT5dvwpMT+8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWhOX0ONe+hX4kEgbPDYb8naqRM1avLcBpICOQuEZCs=;
 b=tHDccEPxn1rvmJxwzXmksZtwLoveoi6ZtZ3kmxAPSNx66ElDxwffnwVOhbjA5sXdCBsIwcdlO6QbwsFpM5bps/NY7xLUV0WtUCGjp9a0MOGLb4q4ruq67lPpiq1JR+5poOJzdWfEkhXyso+2k3G+MBYtGCUbpVMJTEf9roiLp7XuW/Isssm/PTtfQynAtWS95+qBa6g8aajFSaHwTnOgx7kWM0wV8Q0r8Cxiw+w5AZQX9QFUyKtml7YYGx0fvc2QaW4ghc9dRyHKJY3Y1BX8WhYkz/4IHt0UqP4ddbrkn2+1TmtlEnzNDtS/WilPmbd/mGRXwTrOKNPKrgcAuh9Mhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWhOX0ONe+hX4kEgbPDYb8naqRM1avLcBpICOQuEZCs=;
 b=Z4k35wtAIXX/R6CUBgKcm0mc2hhqAxJfP6bX0de7hX7kWH+GTSSFVlBVoO40SYEuZCGO6eGQR2MpsKikOsNDsD2xnlEYP2TJKNz3ZY4LIKAbP3DU/dyW2GVhDVO4NolGrcK/k9QMvE+nbAjqBojJj1KtvpzlaamysAULQBlFKoEmFacA6tb630+X2c0QUvLUJnNsMi3kjK5ov/xOj37RAMGEENSn0gHtyS5UpCNcokroAOPmfXhGXq/vNla5mkGNuRM6+etpG3dqj/52C9xLWL/nMhSR9WlsAjqo5GXCtAVEUWSLMt+Uf2+KeU2AnrwI5Inyvm4zdLikricj3emvug==
Received: from BN9PR12MB5338.namprd12.prod.outlook.com (2603:10b6:408:103::23)
 by DM4PR12MB6663.namprd12.prod.outlook.com (2603:10b6:8:8f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Thu, 11 Jun
 2026 04:55:14 +0000
Received: from BN9PR12MB5338.namprd12.prod.outlook.com
 ([fe80::7b66:315e:f851:8ddb]) by BN9PR12MB5338.namprd12.prod.outlook.com
 ([fe80::7b66:315e:f851:8ddb%5]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 04:55:14 +0000
From: Bing Zhao <bingz@nvidia.com>
To: Bing Zhao <bingz@nvidia.com>, Slava Ovsiienko <viacheslavo@nvidia.com>,
 "dev@dpdk.org" <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>
CC: Ori Kam <orika@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>
Subject: RE: [PATCH v5] ethdev: support inline calculating masked item value
Thread-Topic: [PATCH v5] ethdev: support inline calculating masked item value
Thread-Index: AQHc+Jn48DZZOj5LrkeXrHIFIVNeULY4ytvQ
Date: Thu, 11 Jun 2026 04:55:14 +0000
Message-ID: <BN9PR12MB5338F6E48AC491C180292DB8D01B2@BN9PR12MB5338.namprd12.prod.outlook.com>
References: <20260603092805.9837-1-bingz@nvidia.com>
 <20260610052729.5637-1-bingz@nvidia.com>
In-Reply-To: <20260610052729.5637-1-bingz@nvidia.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5338:EE_|DM4PR12MB6663:EE_
x-ms-office365-filtering-correlation-id: eed1b0e6-861d-47c9-f7fd-08dec775a03f
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|38070700021|3023799007|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info: 6zEODvRGC1q9YjtoP44i9vlkV8lHAqIHWjZ0T6aEVCFQyuywW6Hbz2Iwv5zwRcX7dwa6559ggMQve+8QLHKCZ0IfgkPGBbIyXRCftQE3e+XOE3lJBI9QP62ByuOsIVolfJZLpq96ElNGkVWjY/R4c8H8t5Co1umxDfm0G255iy9kguzi7u4KZInM3SK+P7/sV9xWcJCDn3nNhssDbLoHNUtwsSe11RZ/8V/MfI7drhKFWXY4PkEJ4m4xTKL/i7MDAPqzO1Xrq/BMXcPTF++DzAWqjb6wh3khcDWeayUTBkkcvaTYqBevqHhFg87gYt98iJbWjeFqTwg+b19mJczCvGt7eS9zJ+n7aA23brV+WYxEZfBmRT1vJWpO8Mr8rMmp5p0tVb0z25IkoLfOQhS98X21aHTKNqzhPUWBRHy0ZyVz2DYFsvsRW3N90EJ76VbGC5vOLKbLuv3E2grNYlNp9BP+4DTbdbdLyOf1lXfuniAB3M2KI6tPgqqnJbZfhzgQupaHWFcww6EF1/ZTTOy0mu5muj9Eb7aSdgfQreTbMyj/muSng+F7DJ4qGGQYYsQwbcnGgZdT4Sr0DWdiiBAcyMkGX376altDPAdAb++G6vJv9WszYyXVBZORHAWjv5y2ZfznKCuY/jUJxDeOSG/sP+8KPvY5cYg8EWaFUVfFactLTWRZ5EIs9UMjX5e2zSCgsEzZrJFkLSgXFKHr5eD+SDES51wxZxy99spHvKtSiUguFwvyeS25UccFty4Zfqx9
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5338.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(38070700021)(3023799007)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uWvj4g8kWgTNiepOe2PDdxPcvmH6hzLLik6/yaRVOlUUj+UZLm+WnF0qFi7A?=
 =?us-ascii?Q?Dx/NPiJPkKPEJJCQOnfCcXnfqIM81x6lv9yyPGWCy7IGuLPfyMwAxT/t1EM5?=
 =?us-ascii?Q?h7jNEhY/nCKzOfhcsPhP07uNwC6IRxuu76zsx80ewJX5L+S72JCQh0YM39CN?=
 =?us-ascii?Q?uEruz520X6BKZNoi7AgjXnaCU+m1DpR6CoZbDmvTJLETSPaRL3RM/9rMVwvn?=
 =?us-ascii?Q?rMA2AS8Zsw9gCdkxPrltv4HtxjwgBicY2zZ/mA/rFqzXi6eqOlzWDywZ+U4/?=
 =?us-ascii?Q?LpH6mAMrYwH2W3toIr9uv7Jzv1b6hkEI9gm/az07uuSzn5aT0owD3gJF7oPN?=
 =?us-ascii?Q?29OpRKm5oLzSlTKHxTnzgXbzE9AiEJOEamjjhrrS+iLQflwUD2QsQFVZVvEO?=
 =?us-ascii?Q?r72KkLIVWDSMhF0CDQgTGym03Ag2uxrU/y+xQSsnnqFXQAlCt7wKmad/fUZa?=
 =?us-ascii?Q?6UntntBJ6mXwYT0qgzS5sQT3eV+YAvqj/5ubkoGSeirBfM9o2SfHXBC3PJsS?=
 =?us-ascii?Q?WYD06anekimkworoaAzC4kzX89ZC6PnoOAmt5c6FnO0klfuCj//nHcJ/YWwU?=
 =?us-ascii?Q?pk2RSts3q7Px/u3Nir+eJvHQPJVk24mJYxV+YY/je9EF+4kZZ3O58TBAvyDQ?=
 =?us-ascii?Q?t3y5hlDur5dsidvsEKUvddTlWSUN9us+mUyNFeGtu0fx1Z75oMnRrKCL3vkd?=
 =?us-ascii?Q?AdCmEHpDmzBFidR+XClpgCpAEcKS5hFnvQ7GJehCRWL4bvemigJOGVtZFZZS?=
 =?us-ascii?Q?U6j/rq+QFlpTeVH3Du/T1YqyNDgjrelOuGSGQ+a+a7ljCHP4Hrn7FHWt6FeM?=
 =?us-ascii?Q?NqOmIS2hp2ETn0cbQWXbrzUHWDZg3FK5+EPKyhjrImWa+N6lcUQxvC/Mi9MM?=
 =?us-ascii?Q?VIWrnkkxZNFUFhGbPj1Yq/ynb+J9aPlQ8WNwgRSRwf1m3WxxXe7t9mNZD/bL?=
 =?us-ascii?Q?07BGqAIu9i0zalaQIX/mvt6X4MYlvDWCzKiu+Bh9z3WMk5Mgj1GnAsbhxDvS?=
 =?us-ascii?Q?Zv99AfYKm3YXdbOm/o8AqKNEM361WVj2l5ZTlTA6fcmOmLgRB6l9wfs0DNBO?=
 =?us-ascii?Q?eWtsOd20JwKfnKj7aRL0dTIM0I2RkDArbgWBu+idPPZYu4FqWswvPbIqlGu/?=
 =?us-ascii?Q?mHk35WFpZQlnuV0g4WNoQXWrUu3CPMQoEuWGWa10EqowTycphnlBDql/tb9p?=
 =?us-ascii?Q?qdnCNRDsk7e0HEBEbQ00CRsBrxHMkGJP5jyfyEAUnu7HIaDVNmuAq2dPAocZ?=
 =?us-ascii?Q?wG5kh4vjc3Rauqw1J7FA/2HyVxYmP+ifbgcgsF96dKRw7onMOSq0QgpuY/9b?=
 =?us-ascii?Q?I37VjWb5hSvwDKCPIZK2ulCKKzpdzWPdJyAZV79sRvSW1AqbF2YrKxGOaKVO?=
 =?us-ascii?Q?pT6qwStbiDkpi9IVevl5eHC/1cPR3eKhtWlQYRiv8THARDCN0uhWgTk1Evfe?=
 =?us-ascii?Q?gR2AvLToitBR5vX066i2Z5cgIBzejHPqeYXzkfTCU/BlkD6R+DSkZoL8mvby?=
 =?us-ascii?Q?xdd/uuJDubq2AKyAP4SBfKGWhb5F8gIuwFQXCdorYlCK4KCruZZAci/TQuNo?=
 =?us-ascii?Q?XE+Oqwlj+wJLHlKESdom0tWApiNU3Z2knyHyoxqw6M33GJ/2K8HNlcd29SST?=
 =?us-ascii?Q?4UQkQF1bGeLHXeSISZs15YC8qwa67Xu8EBsTtTt8iplpY92db4d4bbfwzIHp?=
 =?us-ascii?Q?ULalegYNeaFHqMrLXAs+iLuQ/hIv1YpIEutBKSd16joMBk3v?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5338.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eed1b0e6-861d-47c9-f7fd-08dec775a03f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2026 04:55:14.6799 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MCvHqyxVZKYvoemvFgd40FBtwzAVStNUxjNg05vnoBJl/3T//2yHDa50AlPpPrTDqWDgCgnhgyUneho0sR88aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6663
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

Hi,

In my local code,

diff --git a/lib/ethdev/rte_flow.c b/lib/ethdev/rte_flow.c
index 7cf9f6f6f3..7a2721af00 100644
--- a/lib/ethdev/rte_flow.c
+++ b/lib/ethdev/rte_flow.c
@@ -181,9 +181,18 @@ static const struct rte_flow_desc_data rte_flow_desc_i=
tem[] =3D {
 static inline size_t
 rte_flow_conv_item_mask_size(const struct rte_flow_item *item)
 {
-       if ((int)item->type >=3D 0)
+       if ((int)item->type < 0)
+               return sizeof(void *);
+       switch (item->type) {
+       case RTE_FLOW_ITEM_TYPE_RAW:
+               return offsetof(struct rte_flow_item_raw, pattern);
+       case RTE_FLOW_ITEM_TYPE_GENEVE_OPT:
+               return offsetof(struct rte_flow_item_geneve_opt, data);
+       default:
+               if (rte_flow_desc_item[item->type].desc_fn !=3D NULL)
+                       return 0;
                return rte_flow_desc_item[item->type].size;
-       return sizeof(void *);
+       }
 }

// This is the code before my latest change.
> +static inline size_t
> +rte_flow_conv_item_mask_size(const struct rte_flow_item *item) {
> +       if ((int)item->type >=3D 0)
> +               return rte_flow_desc_item[item->type].size;
> +       return sizeof(void *);
> +}
> +


I didn't understand why the patch I sent is still using the old code.

> -----Original Message-----
> From: Bing Zhao <bingz@nvidia.com>
> Sent: Wednesday, June 10, 2026 1:27 PM
> To: Slava Ovsiienko <viacheslavo@nvidia.com>; dev@dpdk.org; Raslan
> Darawsheh <rasland@nvidia.com>; stephen@networkplumber.org
> Cc: Ori Kam <orika@nvidia.com>; Dariusz Sosnowski <dsosnowski@nvidia.com>=
;
> Suanming Mou <suanmingm@nvidia.com>; Matan Azrad <matan@nvidia.com>; NBU-
> Contact-Thomas Monjalon (EXTERNAL) <thomas@monjalon.net>
> Subject: [PATCH v5] ethdev: support inline calculating masked item value
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
> ---
>  app/test/test_ethdev_api.c             | 76 ++++++++++++++++++++++++++
>  doc/guides/rel_notes/release_26_07.rst |  6 ++
>  lib/ethdev/rte_flow.c                  | 46 ++++++++++++++--
>  lib/ethdev/rte_flow.h                  | 13 +++++
>  4 files changed, 135 insertions(+), 6 deletions(-)
>=20
> diff --git a/app/test/test_ethdev_api.c b/app/test/test_ethdev_api.c inde=
x
> 76afd0345c..5cae1cdc1d 100644
> --- a/app/test/test_ethdev_api.c
> +++ b/app/test/test_ethdev_api.c
> @@ -4,6 +4,7 @@
>=20
>  #include <rte_log.h>
>  #include <rte_ethdev.h>
> +#include <rte_flow.h>
>=20
>  #include <rte_test.h>
>  #include "test.h"
> @@ -15,6 +16,80 @@
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
> +       const struct rte_flow_item pattern[] =3D {
> +               {
> +                       .type =3D RTE_FLOW_ITEM_TYPE_ETH,
> +                       .spec =3D &spec,
> +                       .last =3D &last,
> +                       .mask =3D &mask,
> +               },
> +               { .type =3D RTE_FLOW_ITEM_TYPE_END },
> +       };
> +       union {
> +               struct rte_flow_item item;
> +               struct rte_flow_item_eth eth;
> +               double align;
> +               uint8_t raw[256];
> +       } dst;
> +       const struct rte_flow_item *item;
> +       const struct rte_flow_item_eth *conv_spec;
> +       const struct rte_flow_item_eth *conv_last;
> +       int ret;
> +
> +       ret =3D rte_flow_conv(RTE_FLOW_CONV_OP_PATTERN_MASKED, NULL, 0,
> pattern, NULL);
> +       TEST_ASSERT(ret > 0, "Masked pattern conversion size query
> failed");
> +       TEST_ASSERT((size_t)ret <=3D sizeof(dst.raw),
> +                   "Masked pattern conversion needs too much storage");
> +
> +       memset(&dst, 0, sizeof(dst));
> +       ret =3D rte_flow_conv(RTE_FLOW_CONV_OP_PATTERN_MASKED, dst.raw,
> +                           sizeof(dst.raw), pattern, NULL);
> +       TEST_ASSERT(ret > 0, "Masked pattern conversion failed");
> +
> +       item =3D (const struct rte_flow_item *)dst.raw;
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
> +       return TEST_SUCCESS;
> +}
> +
>  static int32_t
>  ethdev_api_queue_status(void)
>  {
> @@ -167,6 +242,7 @@ static struct unit_test_suite ethdev_api_testsuite =
=3D {
>         .setup =3D NULL,
>         .teardown =3D NULL,
>         .unit_test_cases =3D {
> +               TEST_CASE(ethdev_api_flow_conv_pattern_masked),
>                 TEST_CASE(ethdev_api_queue_status),
>                 /* TODO: Add deferred_start queue status test */
>                 TEST_CASES_END() /**< NULL terminate unit test array */
> diff --git a/doc/guides/rel_notes/release_26_07.rst
> b/doc/guides/rel_notes/release_26_07.rst
> index b5285af5fe..4f5d21d576 100644
> --- a/doc/guides/rel_notes/release_26_07.rst
> +++ b/doc/guides/rel_notes/release_26_07.rst
> @@ -190,6 +190,12 @@ API Changes
>    - ``rte_pmd_mlx5_enable_steering``
>    - ``rte_pmd_mlx5_disable_steering``
>=20
> +* ethdev: Added masked pattern conversion.
> +
> +  Added ``RTE_FLOW_CONV_OP_PATTERN_MASKED`` to ``rte_flow_conv()``  to
> + copy an entire pattern while applying each item's mask to its
> + ``spec`` and ``last`` fields.
> +
>=20
>  ABI Changes
>  -----------
> diff --git a/lib/ethdev/rte_flow.c b/lib/ethdev/rte_flow.c index
> ec0fe08355..c7a94a1194 100644
> --- a/lib/ethdev/rte_flow.c
> +++ b/lib/ethdev/rte_flow.c
> @@ -178,6 +178,14 @@ static const struct rte_flow_desc_data
> rte_flow_desc_item[] =3D {
>         MK_FLOW_ITEM(COMPARE, sizeof(struct rte_flow_item_compare)),  };
>=20
> +static inline size_t
> +rte_flow_conv_item_mask_size(const struct rte_flow_item *item) {
> +       if ((int)item->type >=3D 0)
> +               return rte_flow_desc_item[item->type].size;
> +       return sizeof(void *);
> +}
> +
>  /** Generate flow_action[] entry. */
>  #define MK_FLOW_ACTION(t, s) \
>         [RTE_FLOW_ACTION_TYPE_ ## t] =3D { \ @@ -835,6 +843,8 @@
> rte_flow_conv_action_conf(void *buf, const size_t size,
>   *   RTE_FLOW_ITEM_TYPE_END is encountered.
>   * @param[out] error
>   *   Perform verbose error reporting if not NULL.
> + * @param[in] with_mask
> + *   If true, @p src mask will be applied to spec and last.
>   *
>   * @return
>   *   A positive value representing the number of bytes needed to store
> @@ -847,12 +857,13 @@ rte_flow_conv_pattern(struct rte_flow_item *dst,
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
> @@ -876,15 +887,27 @@ rte_flow_conv_pattern(struct rte_flow_item *dst,
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
> @@ -893,9 +916,17 @@ rte_flow_conv_pattern(struct rte_flow_item *dst,
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
> 1042,7 +1073,7 @@ rte_flow_conv_rule(struct rte_flow_conv_rule *dst,
>                 off =3D RTE_ALIGN_CEIL(off, sizeof(double));
>                 ret =3D rte_flow_conv_pattern((void *)((uintptr_t)dst +
> off),
>                                             size > off ? size - off : 0,
> -                                           src->pattern_ro, 0, error);
> +                                           src->pattern_ro, 0, false,
> + error);
>                 if (ret < 0)
>                         return ret;
>                 if (size && size >=3D off + (size_t)ret) @@ -1143,7 +1174=
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
> @@ -1158,7 +1189,7 @@ rte_flow_conv(enum rte_flow_conv_op op,
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
> -1178,6 +1209,9 @@ rte_flow_conv(enum rte_flow_conv_op op,
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
> b495409406..959a2f903b 100644
> --- a/lib/ethdev/rte_flow.h
> +++ b/lib/ethdev/rte_flow.h
> @@ -4556,6 +4556,19 @@ enum rte_flow_conv_op {
>          *   @code const char ** @endcode
>          */
>         RTE_FLOW_CONV_OP_ACTION_NAME_PTR,
> +
> +       /**
> +        * Convert an entire pattern.
> +        *
> +        * Duplicates all pattern items at once, applying @p mask to @p
> spec
> +        * and @p last.
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
> 2.34.1

