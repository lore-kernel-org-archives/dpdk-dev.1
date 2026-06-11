Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C5CCD98C6
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 04:56:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A705542EA1;
	Thu, 11 Jun 2026 06:56:11 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013009.outbound.protection.outlook.com
 [40.93.201.9]) by mails.dpdk.org (Postfix) with ESMTP id EDAB6402CE
 for <dev@dpdk.org>; Thu, 11 Jun 2026 06:56:09 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jzGWmqd0y4YF/SbNVOJPAZQws9pwUcXpqUi0QAeqXdXO/F6q7jrYyCkPw37yPgiy67K+6TDq/GaPIgFPVXjQN6eES1qNtRj5OEz0y43jcwl/GRs48lf5QDpjf+IibCsdz/5pPgt2LPakEl+/R9tjG04veF43GImH5KMRridtRJJ+ztdIgbjWp3GYS4s47MTaom0ScYAVsdSg4FA6m15sPlG3DxLh5KvLJvHZUYW3l8QylpmT7iRYZXvEXaKpme8vNmkENLuYNcLkCXzsBMN+pKOh/8j96yalHvYGzau8FU3a2rBr4MOY5sH2S/Gtt+g+PFJY1wBhEstjpI6DPG0WXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dj/iroI78XuETlGgGM2fsKDzlnePEklH1vuCYwcjBfc=;
 b=xh1AVIYBd5WDNyQSady8DHZEB4IPpXfp8/hZnoI0mxJ5iYU/9NAVNZDhXprT8u2jZzQfNXRLp1GMPL98TvpOHu9zNtUgVi4JRgwVzCqM8TVnVX3x/1+YxkJsh6hPKROvYcgT98JT0NBAxLNP5bNI0S7k0H4vAM9V5j15mHUZ8DaCz7XWjEeTlGIaKP4nSwXsYsvT/KASi95+s+HHGe6qLR9Z3DdUtiLuO5JKWeER/PpHO698HL8BkBejHzrcEKhogiPOvN29UxDJ7+JdiRVdOEJzy5k0G8nltGZqZ1DK3uEDIE/nUpE437kAe/M1YIhyuxgbZJ05BnQVuCppILFW+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dj/iroI78XuETlGgGM2fsKDzlnePEklH1vuCYwcjBfc=;
 b=OnQV4dZdu1Iuec0A1l633kXoNrtCBXdwCF6OFHbpN2Pm24VmXLmUjX58hUWb0LTjdtefsNnHqivmT2NjvwbLoZJ0xQj5XgFEoTBeKs3FK7H2ZfVXLrJRGDNBItxPcgx5PFIAMed6ZWHGa/cwy51B+AE5mv3PW5ohjz7zNAZmelLTQ3zLtVXRhNpfGs+0BszkamxU/e1GFrLM+D6TQTw2WgpMT/gekHXpDcvsmM13zJJeIgK/8hIfectGXp42J6hdTqN+4jfg5Y4OEBvWw7gl59vp24KcYHkpgEms/tcJ0WdoB19p6nOHwHrSEnenD2SsozXJOqrz4nw9/GrNfCwrjw==
Received: from BN9PR12MB5338.namprd12.prod.outlook.com (2603:10b6:408:103::23)
 by SA1PR12MB7342.namprd12.prod.outlook.com (2603:10b6:806:2b3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 04:56:05 +0000
Received: from BN9PR12MB5338.namprd12.prod.outlook.com
 ([fe80::7b66:315e:f851:8ddb]) by BN9PR12MB5338.namprd12.prod.outlook.com
 ([fe80::7b66:315e:f851:8ddb%5]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 04:56:05 +0000
From: Bing Zhao <bingz@nvidia.com>
To: Slava Ovsiienko <viacheslavo@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>,
 Raslan Darawsheh <rasland@nvidia.com>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>
CC: Ori Kam <orika@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>
Subject: RE: [PATCH v5] ethdev: support inline calculating masked item value
Thread-Topic: [PATCH v5] ethdev: support inline calculating masked item value
Thread-Index: AQHc+Jn48DZZOj5LrkeXrHIFIVNeULY4ytvQgAAA8iA=
Date: Thu, 11 Jun 2026 04:56:05 +0000
Message-ID: <BN9PR12MB53386A71BF67D21A34C7981BD01B2@BN9PR12MB5338.namprd12.prod.outlook.com>
References: <20260603092805.9837-1-bingz@nvidia.com>
 <20260610052729.5637-1-bingz@nvidia.com>
 <BN9PR12MB5338F6E48AC491C180292DB8D01B2@BN9PR12MB5338.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5338F6E48AC491C180292DB8D01B2@BN9PR12MB5338.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5338:EE_|SA1PR12MB7342:EE_
x-ms-office365-filtering-correlation-id: 67e83ce8-17ef-4916-218d-08dec775be60
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|3023799007|4143699003|11063799006|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: ubvIWHz1J5KAQtWET2MO+eDuLeuX3Yhq+E6GRemL10MzyIQ2yBAA0gGIUUJ3UXE4371eOYjF5JIwaoB/jF+nMc6fYxz5m0phdSli5dVyjh8VkTXl79nEf1Qw6hPPY00dJpSFTTY5oBzOFmKTClzF4gOUeQv3bR9oXOPM4U6WQPrTvopEUo8+xzJvRndi0GurBkipwbNyU2OVTI3Bze9uEg2AeEdybSs4s5j6uoBXCShjApzYTs1uORPP/oWKALKRruczfSlHASNxHeWU+SAx6JxujYmFLs2LUyJ5qu/4Eb69K342H5PRe0jIYfE7KDhx/noQUnGSKbuBMXG3ZwMIhd7c+kx47H/3Pug7wrWHXKXb5IdUBgpp6tp91mf84rvDY1M6k9XgSsG0tDKN3qu6U4nTzQaBuaxRFQAdsYnQQ9iIIufvQ97pG47HFgFeznX9U/dzkOe9Dq1A3AhXYXn+Scs5wGFbwcBW+1JqPi9jsqe9Cl+5sJSm6Pzldagnraj+t+MvnnXMZoqZ6tWLUXaO453/q33H0Ox4g8Tk0DEsdw/JkmUbcf9knnMhQE/et/VN7kncDat12oZfGHpKmZV11a2ogSZ2jnRa3E9uJwFK6kQC+Uunh8w3mJbECfR7gCvO58xefmCMeQi1GR7rCdHO5+tSkSjksCHyRfcrktC40JtZb+zd/87AlmSwoUwKUAIth6uGrgrPUe+5HPPwYxyBqs5IRXJ+3TYovWy6kZ+LXBpjwt0D9LdQCNqbYP0+SrYq
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5338.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(3023799007)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rPnlmQ2gAlQJhmoVS08Vy6o+aiFjkCZElCB6dC552wllafrIeZCNr4DKm3fU?=
 =?us-ascii?Q?F2JMVxi21rNmLts4XQ6/uqSUT6r4ErZuooL9Y/O0VxD8a2ioTgIilSYQPOpg?=
 =?us-ascii?Q?qJvspx4z9fZszXtLTnDTaAtM5YntXocm2TTKg6hvpqV8760jhCbuRRsKklQR?=
 =?us-ascii?Q?jTvBAds6DmCCi3ScCdkcefiSTUnYHzHZCgTcHsdjOin4gJwQ71cT7I3f3fig?=
 =?us-ascii?Q?mt+zLUGhLY+xWle9uBP/c0kd3WFNQFyD66sBdeMEVIqpVRGoVYfYl8g4N8Tm?=
 =?us-ascii?Q?XbjIPieD+5ZtJvCbX8oSL4f9kNXPUWaCPYgwqOnr5ZNsWXuSlE+mPUzFv5N6?=
 =?us-ascii?Q?+htfVofCBh85imp61RFGI9eaDZK0S+ALqAzpqEooC8/TaG2kM3UaQfpCuMlp?=
 =?us-ascii?Q?LzvgOxlPvKR7akMYDofInUfWTU6QGK0S71Ce2IImCdUxI/ITlUko6GWsorWL?=
 =?us-ascii?Q?3nGhnv/1gFHXKgAi8Pnl5tHQtKj6T8JNAhgITUjAYnVFUZZONJVC8k7ykP8G?=
 =?us-ascii?Q?ukbgiQIFNlE7KNOu/arZcT/pzqBozG7p6nO5CHlqmqi41u0echJ7PXh9dPRF?=
 =?us-ascii?Q?Pcj7L4JBey7jqc1n9DL+H7bj3XFG02NWl6Xo9+8Kx2qoS6pNI0BFt2XuOIwm?=
 =?us-ascii?Q?mEG5FMjjW0oJOwOpWdquV6OFnffK4pyn8JYP5JeqOBcF23pfcZrG4VgZw9B+?=
 =?us-ascii?Q?bDx+cfOPDn1dIYn00PL14S0kmZcnAL+UUEH6JI31ax9vejjsqOZMHkevz3WP?=
 =?us-ascii?Q?PgI6Pzpsub0ShX7SFrY5vrUr2fuM/YcpouWIuFQJ690/Mf/Rbo0VV0DUyi85?=
 =?us-ascii?Q?it+s9am1JN0ZcUUPt3RCiQBJ+SwObcTSbAYjdV1lPkrZMI7bqmNVU4/j3V2K?=
 =?us-ascii?Q?6c3IupTJIPx+WUXbqv8OWgTHm43gvGGzP1Rln0TS7o6ayt34LbCxiFyXadCP?=
 =?us-ascii?Q?f6JuXDNOKOF8YGUKzMgGCrtP59qpzZQ4tCeLLh/VLQ0RC2wj9ZnkPDNifG7D?=
 =?us-ascii?Q?1/8cLEyV04sb0Ngq57zy4KJOz7KzMmWmRt0TDSjAjBlZRa2l63UJZiEcRjuJ?=
 =?us-ascii?Q?o4bJVOfzB03aqi9xXCo/Nh4LYRKWc6R/QR4TJ8QNop053niYB3fH0E2UxuW3?=
 =?us-ascii?Q?gmhV+ZXtE0UGQTPTMxpgo3T6NBNulk0DpuKjWP5xeyQ38z09m+U8eQYxNMoE?=
 =?us-ascii?Q?s809rJDOXV4AA3NeYzUsNaqRRNy/b6epelrEMarx7YFVjWGaz5p7+qGI2NWU?=
 =?us-ascii?Q?tkdgSoDJzDT2EVbxISI1FHEoqr0Fg9oram2MMCgfIfv7JLXc8twRWnb23iOX?=
 =?us-ascii?Q?PWX1FMeJurgAbKwUVY87JZF7O7ykFyHJkUikf4c2BuexofdSB9uOHOuiAw2b?=
 =?us-ascii?Q?uVD228EDTA7F6MZ6xWBZdMHixN/5y3diNDCphwTRJGXRPIVI564bPpaFqkKG?=
 =?us-ascii?Q?wvZsC5e5mglsug1rJ/2Oj7CHgF8yNWuYILNr/pBWM66RW86Xe0EO8aLWpiMO?=
 =?us-ascii?Q?Z21VK6YEMYxfT5x4bbUPJkR7NwK1UvXAXi//9AA11GJwa2NTiuYe5e3guV2S?=
 =?us-ascii?Q?5+iFi2MA5Qxjk+r5SacNzXukikCcOyCSuXC7tkLTZkPM9avZsiTfW55bZfp+?=
 =?us-ascii?Q?jBt48yxp8544IcsziVjbzxJkVVElizXePqIBgMG+GPn+54TmvD90s0javznI?=
 =?us-ascii?Q?dY0/kkbicUIMoNwJ/8sxFhZCeDWoGdvGmQQCHNs30Cp1efBE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5338.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e83ce8-17ef-4916-218d-08dec775be60
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2026 04:56:05.1746 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FnNthpXkN9mVvDaBCp4g2HuJA6DPGkk3OYQFz4kVH+0PvAZVQ5y6g94eYI5jPM8GY6UCoWtfqWISc6nrYC4+Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7342
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

Oh, I see, I squashed the changes into the next following mlx5 driver fix b=
ut not the proper one, so the code is still the old one. My fault.

> -----Original Message-----
> From: Bing Zhao
> Sent: Thursday, June 11, 2026 12:55 PM
> To: 'Bing Zhao' <bingz@nvidia.com>; Slava Ovsiienko
> <viacheslavo@nvidia.com>; dev@dpdk.org; Raslan Darawsheh
> <rasland@nvidia.com>; stephen@networkplumber.org
> Cc: Ori Kam <orika@nvidia.com>; Dariusz Sosnowski <dsosnowski@nvidia.com>=
;
> Suanming Mou <suanmingm@nvidia.com>; Matan Azrad <matan@nvidia.com>; NBU-
> Contact-Thomas Monjalon (EXTERNAL) <thomas@monjalon.net>
> Subject: RE: [PATCH v5] ethdev: support inline calculating masked item
> value
>=20
> Hi,
>=20
> In my local code,
>=20
> diff --git a/lib/ethdev/rte_flow.c b/lib/ethdev/rte_flow.c index
> 7cf9f6f6f3..7a2721af00 100644
> --- a/lib/ethdev/rte_flow.c
> +++ b/lib/ethdev/rte_flow.c
> @@ -181,9 +181,18 @@ static const struct rte_flow_desc_data
> rte_flow_desc_item[] =3D {  static inline size_t
> rte_flow_conv_item_mask_size(const struct rte_flow_item *item)  {
> -       if ((int)item->type >=3D 0)
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
>                 return rte_flow_desc_item[item->type].size;
> -       return sizeof(void *);
> +       }
>  }
>=20
> // This is the code before my latest change.
> > +static inline size_t
> > +rte_flow_conv_item_mask_size(const struct rte_flow_item *item) {
> > +       if ((int)item->type >=3D 0)
> > +               return rte_flow_desc_item[item->type].size;
> > +       return sizeof(void *);
> > +}
> > +
>=20
>=20
> I didn't understand why the patch I sent is still using the old code.
>=20
> > -----Original Message-----
> > From: Bing Zhao <bingz@nvidia.com>
> > Sent: Wednesday, June 10, 2026 1:27 PM
> > To: Slava Ovsiienko <viacheslavo@nvidia.com>; dev@dpdk.org; Raslan
> > Darawsheh <rasland@nvidia.com>; stephen@networkplumber.org
> > Cc: Ori Kam <orika@nvidia.com>; Dariusz Sosnowski
> > <dsosnowski@nvidia.com>; Suanming Mou <suanmingm@nvidia.com>; Matan
> > Azrad <matan@nvidia.com>; NBU- Contact-Thomas Monjalon (EXTERNAL)
> > <thomas@monjalon.net>
> > Subject: [PATCH v5] ethdev: support inline calculating masked item
> > value
> >
> > External email: Use caution opening links or attachments
> >
> >
> > In the asynchronous API definition and some drivers, the rte_flow_item
> > spec value may not be calculated by the driver due to the reason of
> > speed of light rule insertion rate and sometimes the input parameters
> > will be copied and changed internally.
> >
> > After copying, the spec and last will be protected by the keyword
> > const and cannot be changed in the code itself. And also the driver
> > needs some extra memory to do the calculation and extra conditions to
> > understand the length of each item spec. This is not efficient.
> >
> > To solve the issue and support usage of the following fix, a new OP
> > was introduced to calculate the spec and last values after applying
> > the mask inline.
> >
> > Signed-off-by: Bing Zhao <bingz@nvidia.com>
> > Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> > ---
> > v3:
> >   - add test code
> >   - fix the issue found by AI
> > v4: reabse on top of the main
> > v5: handle some items separately and add test for them
> > ---
> >  app/test/test_ethdev_api.c             | 76 ++++++++++++++++++++++++++
> >  doc/guides/rel_notes/release_26_07.rst |  6 ++
> >  lib/ethdev/rte_flow.c                  | 46 ++++++++++++++--
> >  lib/ethdev/rte_flow.h                  | 13 +++++
> >  4 files changed, 135 insertions(+), 6 deletions(-)
> >
> > diff --git a/app/test/test_ethdev_api.c b/app/test/test_ethdev_api.c
> > index 76afd0345c..5cae1cdc1d 100644
> > --- a/app/test/test_ethdev_api.c
> > +++ b/app/test/test_ethdev_api.c
> > @@ -4,6 +4,7 @@
> >
> >  #include <rte_log.h>
> >  #include <rte_ethdev.h>
> > +#include <rte_flow.h>
> >
> >  #include <rte_test.h>
> >  #include "test.h"
> > @@ -15,6 +16,80 @@
> >  #define NUM_MBUF 1024
> >  #define MBUF_CACHE_SIZE 256
> >
> > +static int32_t
> > +ethdev_api_flow_conv_pattern_masked(void)
> > +{
> > +       const struct rte_flow_item_eth spec =3D {
> > +               .hdr.dst_addr.addr_bytes =3D { 0x01, 0x02, 0x03, 0x04,
> > +0x05,
> > 0x06 },
> > +               .hdr.src_addr.addr_bytes =3D { 0x0a, 0x0b, 0x0c, 0x0d,
> > + 0x0e,
> > 0x0f },
> > +               .hdr.ether_type =3D RTE_BE16(0x1234),
> > +       };
> > +       const struct rte_flow_item_eth last =3D {
> > +               .hdr.dst_addr.addr_bytes =3D { 0x11, 0x12, 0x13, 0x14,
> > + 0x15,
> > 0x16 },
> > +               .hdr.src_addr.addr_bytes =3D { 0x1a, 0x1b, 0x1c, 0x1d,
> > + 0x1e,
> > 0x1f },
> > +               .hdr.ether_type =3D RTE_BE16(0x5678),
> > +       };
> > +       const struct rte_flow_item_eth mask =3D {
> > +               .hdr.dst_addr.addr_bytes =3D { 0xff, 0xff, 0x00, 0x00,
> > + 0xff,
> > 0xff },
> > +               .hdr.src_addr.addr_bytes =3D { 0xff, 0x00, 0xff, 0x00,
> > + 0xff,
> > 0x00 },
> > +               .hdr.ether_type =3D RTE_BE16(0xffff),
> > +       };
> > +       const struct rte_flow_item pattern[] =3D {
> > +               {
> > +                       .type =3D RTE_FLOW_ITEM_TYPE_ETH,
> > +                       .spec =3D &spec,
> > +                       .last =3D &last,
> > +                       .mask =3D &mask,
> > +               },
> > +               { .type =3D RTE_FLOW_ITEM_TYPE_END },
> > +       };
> > +       union {
> > +               struct rte_flow_item item;
> > +               struct rte_flow_item_eth eth;
> > +               double align;
> > +               uint8_t raw[256];
> > +       } dst;
> > +       const struct rte_flow_item *item;
> > +       const struct rte_flow_item_eth *conv_spec;
> > +       const struct rte_flow_item_eth *conv_last;
> > +       int ret;
> > +
> > +       ret =3D rte_flow_conv(RTE_FLOW_CONV_OP_PATTERN_MASKED, NULL, 0,
> > pattern, NULL);
> > +       TEST_ASSERT(ret > 0, "Masked pattern conversion size query
> > failed");
> > +       TEST_ASSERT((size_t)ret <=3D sizeof(dst.raw),
> > +                   "Masked pattern conversion needs too much
> > + storage");
> > +
> > +       memset(&dst, 0, sizeof(dst));
> > +       ret =3D rte_flow_conv(RTE_FLOW_CONV_OP_PATTERN_MASKED, dst.raw,
> > +                           sizeof(dst.raw), pattern, NULL);
> > +       TEST_ASSERT(ret > 0, "Masked pattern conversion failed");
> > +
> > +       item =3D (const struct rte_flow_item *)dst.raw;
> > +       conv_spec =3D item[0].spec;
> > +       conv_last =3D item[0].last;
> > +       TEST_ASSERT_NOT_NULL(conv_spec, "Converted spec must be set");
> > +       TEST_ASSERT_NOT_NULL(conv_last, "Converted last must be set");
> > +
> > +       TEST_ASSERT_EQUAL(conv_spec->hdr.dst_addr.addr_bytes[0], 0x01,
> > +                         "Masked spec dst byte 0 mismatch");
> > +       TEST_ASSERT_EQUAL(conv_spec->hdr.dst_addr.addr_bytes[2], 0x00,
> > +                         "Masked spec dst byte 2 mismatch");
> > +       TEST_ASSERT_EQUAL(conv_spec->hdr.src_addr.addr_bytes[1], 0x00,
> > +                         "Masked spec src byte 1 mismatch");
> > +       TEST_ASSERT_EQUAL(conv_spec->hdr.ether_type, RTE_BE16(0x1234),
> > +                         "Masked spec ether type mismatch");
> > +       TEST_ASSERT_EQUAL(conv_last->hdr.dst_addr.addr_bytes[0], 0x11,
> > +                         "Masked last dst byte 0 mismatch");
> > +       TEST_ASSERT_EQUAL(conv_last->hdr.dst_addr.addr_bytes[2], 0x00,
> > +                         "Masked last dst byte 2 mismatch");
> > +       TEST_ASSERT_EQUAL(conv_last->hdr.src_addr.addr_bytes[1], 0x00,
> > +                         "Masked last src byte 1 mismatch");
> > +       TEST_ASSERT_EQUAL(conv_last->hdr.ether_type, RTE_BE16(0x5678),
> > +                         "Masked last ether type mismatch");
> > +
> > +       return TEST_SUCCESS;
> > +}
> > +
> >  static int32_t
> >  ethdev_api_queue_status(void)
> >  {
> > @@ -167,6 +242,7 @@ static struct unit_test_suite ethdev_api_testsuite =
=3D
> {
> >         .setup =3D NULL,
> >         .teardown =3D NULL,
> >         .unit_test_cases =3D {
> > +               TEST_CASE(ethdev_api_flow_conv_pattern_masked),
> >                 TEST_CASE(ethdev_api_queue_status),
> >                 /* TODO: Add deferred_start queue status test */
> >                 TEST_CASES_END() /**< NULL terminate unit test array
> > */ diff --git a/doc/guides/rel_notes/release_26_07.rst
> > b/doc/guides/rel_notes/release_26_07.rst
> > index b5285af5fe..4f5d21d576 100644
> > --- a/doc/guides/rel_notes/release_26_07.rst
> > +++ b/doc/guides/rel_notes/release_26_07.rst
> > @@ -190,6 +190,12 @@ API Changes
> >    - ``rte_pmd_mlx5_enable_steering``
> >    - ``rte_pmd_mlx5_disable_steering``
> >
> > +* ethdev: Added masked pattern conversion.
> > +
> > +  Added ``RTE_FLOW_CONV_OP_PATTERN_MASKED`` to ``rte_flow_conv()``
> > + to copy an entire pattern while applying each item's mask to its
> > + ``spec`` and ``last`` fields.
> > +
> >
> >  ABI Changes
> >  -----------
> > diff --git a/lib/ethdev/rte_flow.c b/lib/ethdev/rte_flow.c index
> > ec0fe08355..c7a94a1194 100644
> > --- a/lib/ethdev/rte_flow.c
> > +++ b/lib/ethdev/rte_flow.c
> > @@ -178,6 +178,14 @@ static const struct rte_flow_desc_data
> > rte_flow_desc_item[] =3D {
> >         MK_FLOW_ITEM(COMPARE, sizeof(struct rte_flow_item_compare)),
> > };
> >
> > +static inline size_t
> > +rte_flow_conv_item_mask_size(const struct rte_flow_item *item) {
> > +       if ((int)item->type >=3D 0)
> > +               return rte_flow_desc_item[item->type].size;
> > +       return sizeof(void *);
> > +}
> > +
> >  /** Generate flow_action[] entry. */
> >  #define MK_FLOW_ACTION(t, s) \
> >         [RTE_FLOW_ACTION_TYPE_ ## t] =3D { \ @@ -835,6 +843,8 @@
> > rte_flow_conv_action_conf(void *buf, const size_t size,
> >   *   RTE_FLOW_ITEM_TYPE_END is encountered.
> >   * @param[out] error
> >   *   Perform verbose error reporting if not NULL.
> > + * @param[in] with_mask
> > + *   If true, @p src mask will be applied to spec and last.
> >   *
> >   * @return
> >   *   A positive value representing the number of bytes needed to store
> > @@ -847,12 +857,13 @@ rte_flow_conv_pattern(struct rte_flow_item *dst,
> >                       const size_t size,
> >                       const struct rte_flow_item *src,
> >                       unsigned int num,
> > +                     bool with_mask,
> >                       struct rte_flow_error *error)  {
> >         uintptr_t data =3D (uintptr_t)dst;
> >         size_t off;
> >         size_t ret;
> > -       unsigned int i;
> > +       unsigned int i, j;
> >
> >         for (i =3D 0, off =3D 0; !num || i !=3D num; ++i, ++src, ++dst)=
 {
> >                 /**
> > @@ -876,15 +887,27 @@ rte_flow_conv_pattern(struct rte_flow_item *dst,
> >         src -=3D num;
> >         dst -=3D num;
> >         do {
> > +               uint8_t *c_spec =3D NULL, *c_last =3D NULL;
> > +               const uint8_t *mask =3D src->mask;
> > +               size_t item_mask_size =3D mask ?
> > + rte_flow_conv_item_mask_size(src) : 0;
> > +
> >                 if (src->spec) {
> >                         off =3D RTE_ALIGN_CEIL(off, sizeof(double));
> >                         ret =3D rte_flow_conv_item_spec
> >                                 ((void *)(data + off),
> >                                  size > off ? size - off : 0, src,
> >                                  RTE_FLOW_CONV_ITEM_SPEC);
> > -                       if (size && size >=3D off + ret)
> > +                       if (size && size >=3D off + ret) {
> >                                 dst->spec =3D (void *)(data + off);
> > +                               c_spec =3D (uint8_t *)(data + off);
> > +                       }
> >                         off +=3D ret;
> > +                       if (with_mask && c_spec && mask) {
> > +                               size_t mask_size =3D RTE_MIN(ret,
> > + item_mask_size);
> > +
> > +                               for (j =3D 0; j < mask_size; j++)
> > +                                       c_spec[j] &=3D mask[j];
> > +                       }
> >
> >                 }
> >                 if (src->last) {
> > @@ -893,9 +916,17 @@ rte_flow_conv_pattern(struct rte_flow_item *dst,
> >                                 ((void *)(data + off),
> >                                  size > off ? size - off : 0, src,
> >                                  RTE_FLOW_CONV_ITEM_LAST);
> > -                       if (size && size >=3D off + ret)
> > +                       if (size && size >=3D off + ret) {
> >                                 dst->last =3D (void *)(data + off);
> > +                               c_last =3D (uint8_t *)(data + off);
> > +                       }
> >                         off +=3D ret;
> > +                       if (with_mask && c_last && mask) {
> > +                               size_t mask_size =3D RTE_MIN(ret,
> > + item_mask_size);
> > +
> > +                               for (j =3D 0; j < mask_size; j++)
> > +                                       c_last[j] &=3D mask[j];
> > +                       }
> >                 }
> >                 if (src->mask) {
> >                         off =3D RTE_ALIGN_CEIL(off, sizeof(double)); @@
> > -
> > 1042,7 +1073,7 @@ rte_flow_conv_rule(struct rte_flow_conv_rule *dst,
> >                 off =3D RTE_ALIGN_CEIL(off, sizeof(double));
> >                 ret =3D rte_flow_conv_pattern((void *)((uintptr_t)dst +
> > off),
> >                                             size > off ? size - off : 0=
,
> > -                                           src->pattern_ro, 0, error);
> > +                                           src->pattern_ro, 0, false,
> > + error);
> >                 if (ret < 0)
> >                         return ret;
> >                 if (size && size >=3D off + (size_t)ret) @@ -1143,7
> > +1174,7 @@ rte_flow_conv(enum rte_flow_conv_op op,
> >                 ret =3D sizeof(*attr);
> >                 break;
> >         case RTE_FLOW_CONV_OP_ITEM:
> > -               ret =3D rte_flow_conv_pattern(dst, size, src, 1, error)=
;
> > +               ret =3D rte_flow_conv_pattern(dst, size, src, 1, false,
> > + error);
> >                 break;
> >         case RTE_FLOW_CONV_OP_ITEM_MASK:
> >                 item =3D src;
> > @@ -1158,7 +1189,7 @@ rte_flow_conv(enum rte_flow_conv_op op,
> >                 ret =3D rte_flow_conv_actions(dst, size, src, 1, error)=
;
> >                 break;
> >         case RTE_FLOW_CONV_OP_PATTERN:
> > -               ret =3D rte_flow_conv_pattern(dst, size, src, 0, error)=
;
> > +               ret =3D rte_flow_conv_pattern(dst, size, src, 0, false,
> > + error);
> >                 break;
> >         case RTE_FLOW_CONV_OP_ACTIONS:
> >                 ret =3D rte_flow_conv_actions(dst, size, src, 0, error)=
;
> > @@
> > -1178,6 +1209,9 @@ rte_flow_conv(enum rte_flow_conv_op op,
> >         case RTE_FLOW_CONV_OP_ACTION_NAME_PTR:
> >                 ret =3D rte_flow_conv_name(1, 1, dst, size, src, error)=
;
> >                 break;
> > +       case RTE_FLOW_CONV_OP_PATTERN_MASKED:
> > +               ret =3D rte_flow_conv_pattern(dst, size, src, 0, true,
> > error);
> > +               break;
> >         default:
> >                 ret =3D rte_flow_error_set
> >                 (error, ENOTSUP, RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
> > NULL, diff --git a/lib/ethdev/rte_flow.h b/lib/ethdev/rte_flow.h index
> > b495409406..959a2f903b 100644
> > --- a/lib/ethdev/rte_flow.h
> > +++ b/lib/ethdev/rte_flow.h
> > @@ -4556,6 +4556,19 @@ enum rte_flow_conv_op {
> >          *   @code const char ** @endcode
> >          */
> >         RTE_FLOW_CONV_OP_ACTION_NAME_PTR,
> > +
> > +       /**
> > +        * Convert an entire pattern.
> > +        *
> > +        * Duplicates all pattern items at once, applying @p mask to
> > + @p
> > spec
> > +        * and @p last.
> > +        *
> > +        * - @p src type:
> > +        *   @code const struct rte_flow_item * @endcode
> > +        * - @p dst type:
> > +        *   @code struct rte_flow_item * @endcode
> > +        */
> > +       RTE_FLOW_CONV_OP_PATTERN_MASKED,
> >  };
> >
> >  /**
> > --
> > 2.34.1

