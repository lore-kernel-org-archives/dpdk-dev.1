Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE666C282D1
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 22:02:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44AC540DD2;
	Thu,  6 Mar 2025 23:02:01 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11020135.outbound.protection.outlook.com [52.101.61.135])
 by mails.dpdk.org (Postfix) with ESMTP id AC9F940DD1
 for <dev@dpdk.org>; Thu,  6 Mar 2025 23:01:59 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OsGsDWrLtzqHfTqCgTrVLnzQOWtQz+RN+F5n+oF3OZ4GsIW4WRFOvKGcneOwjmQdPxLeDpyEiSEFYQCrnL0Jn+TEEiQbw1I1I/KvCWVtKsDwcv7rDs66ikHihKeK1AsFyYL1hHDLspFOJOtR3EvSdua8+rRHFS2aZc7Z5L1uG/7RH/4KIMnO5nrPLaenVUvFMyWz7DNFks5WQC9UHT/oq0Ha/VgEZAM5xMza6eU1fbfkBPrWugmOh9hlA0hVlAG3ev+k8dkZYZKubEzE8i+A2YjqIeQLfVLtn/lbFVvAKGSW/WpYFZuY18LRuzTr6rrMdSSfA1KLxp6TUu9FTZxg3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Ld78LLnXusXzZiK0B+wkh7OIJJLvqwtknZSzfnco0s=;
 b=PSmhqgBcVHACgeangIKGT+1e3cFaqbogTtXOCUhGb/jC1twSeajU23jo1Q5j8XwwDFGstUG07yOEbK4J00iV/t12mNC5T+7435XPLMxe2C5c3smHP7hH25pwV2s/BGiFTtRdJyZ8rDcST8uJ8v/+lCRdaA8zIm7WT8EDd4xj9Nf1GC4jpXg6hLmYEYBxLadlMxeQ6+yrFgRvDdXcdewDd10X3XeVL612tIAaHOau3UyBmP0bjLBsCc06kiR8zahr6MuGFT3Y58T5TOOpKp9VRIx5Fhi2R+fqqDPYbS6qOjgzmiEcLZghtQP4ed8fQn2QkhJUsp/YREBWUb7WYik7sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Ld78LLnXusXzZiK0B+wkh7OIJJLvqwtknZSzfnco0s=;
 b=X6EtLfQYo9p0vcRGd25qpq5KZMF4dKis8AQFlOAoaaKBvUQAIQJQYweenJ/x8E80YjY0ZpejZIlEc01DO/S3JXmG6zW2/4V6fGU2E8qItDFv2zs38WY6I+SkoH3iE8RnfzL4LyQ48QE006svz5eZyj441qj6o1yIExO6ZbAJwk0=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SA3PR21MB3865.namprd21.prod.outlook.com (2603:10b6:806:2fa::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 22:01:57 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%4]) with mapi id 15.20.8511.012; Thu, 6 Mar 2025
 22:01:57 +0000
From: Long Li <longli@microsoft.com>
To: Andre Muezerie <andremue@linux.microsoft.com>, "longli@linuxonhyperv.com"
 <longli@linuxonhyperv.com>
CC: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu
 <weh@microsoft.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH] net/mana: avoid the use of variable length array
Thread-Topic: [PATCH] net/mana: avoid the use of variable length array
Thread-Index: AQHbjj30EERRQ3x3okGawMCHSznYBbNmqhdg
Date: Thu, 6 Mar 2025 22:01:57 +0000
Message-ID: <SA6PR21MB4231D1CD2DC22EE5A5EBEB19CECA2@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1741135052-2039-1-git-send-email-longli@linuxonhyperv.com>
 <20250306021745.GA9956@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20250306021745.GA9956@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=000270c3-54b4-48a9-a79a-8c744d6fe138;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-03-06T22:01:17Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SA3PR21MB3865:EE_
x-ms-office365-filtering-correlation-id: 77bebb7c-85ac-4668-af21-08dd5cfa8366
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?nmsVPj9GMyw1astxRz6fSXhGkENDErYC4LADZYGHuILKkZq3XqVZA+jyhbdj?=
 =?us-ascii?Q?ZO+nvfHuzOGL1sH7DHHmjOxi7Mav+ZQ+o6JRYSJLOi/FXYy3+TkSvzNZCBJ7?=
 =?us-ascii?Q?B1Yb2JMuCFRE6vstEjvHVvO8EIq+zGSUs39bkADko7Z/UypW3qMZtNMfzWN2?=
 =?us-ascii?Q?eku3j2XvnR07zGNZgV8MSgAK49xo9zDE0wf3IdN77LL2A60LgMja75Ff6LUk?=
 =?us-ascii?Q?/Cv9G+57MsN4pDJDAe4YRh+H2GuAdlyqwXscQzYVP+2gQnjddHF2hj0j9Ryj?=
 =?us-ascii?Q?5p0TI4rmCeJzNk7+tDHWBWQTcaysEbPM106ijzoms6ZSBE3FARUNGBS9Ky3t?=
 =?us-ascii?Q?+DaSLTOTEvmdKPLbQMxOn+y7JAVfEe5EAiyuGPQJ6Q5YtJH62Tj0TSgMYoKF?=
 =?us-ascii?Q?9RTzZb67MMAAJk9HHJs3wkuzEWYJ4wj2m4DR+tmeR5OPjwsjzBq7iU0uY4r6?=
 =?us-ascii?Q?yavSJ8KKJUYVIfFeRh7ODw3IYqFjUs7A+tXW3joRWO56T6zcZjNWtFOB3Yz0?=
 =?us-ascii?Q?MC8ozqac33gHU9cKkJUiVjJLFOAMcGFRK6T5fDoDGiTkLKBoclBRK9MCxpqM?=
 =?us-ascii?Q?RerD5F9F50lB3OuhI766EqpfZMnipoeasXa6ksYn5cG330W/rc8yRWCvDRhH?=
 =?us-ascii?Q?2AxJ4vqgDGVAiq9Y4goQ//xdTm2cfrw0y8KSTkxhLHIuD5jv7dXSnXCNUnmd?=
 =?us-ascii?Q?Sb7LccLse3V95b9oV4Qu5ZdkXE7GNnMTXj1Njvj1QDJ7KSL9Jls+z8/uX/70?=
 =?us-ascii?Q?zJCJ3yhvhM9T7dkjQf7BNHEgZhYZssZJR3vm8jf0ihaN3Z84HF/d+XGYv7uG?=
 =?us-ascii?Q?gvdFaNAkIEYysPnJbqA67tQE4f2slXwDEsxpdVLB0R5V9CyLmiWVCYE35hdk?=
 =?us-ascii?Q?XvEBuGl4thNAC/sbqe/QF+jwO8AH7wiVbOjaOnegtK8dtBV/FEYXjm92mZiB?=
 =?us-ascii?Q?Pn0vQIsb4p2QQY+xn+P6ecZbTRSedF+sFg+3BudmPrQt6yBXSzu11X6B1D7h?=
 =?us-ascii?Q?0nklirTzgs3ipzXZoI0c8vjcnuFjs6YcB/oJLb75Fw+xMuBTWZKCs/Mjdogp?=
 =?us-ascii?Q?gd0G9suqwEnjdCnM/l3dU6pwzR4dm196AWq0Z9oWJ+AGX1UsImt+xb+tmeav?=
 =?us-ascii?Q?XnZDdB5sDNcbhDNycWWL5OWT8H9jgge6I0wSv9NsCCu8Dh0Jnp5WiuWLZKz5?=
 =?us-ascii?Q?NQ4ppmIscS08Js+fQ7vh/V7hfCXtKICsHDeNBk0eWB3ly/nfFCOvs6gqO/CC?=
 =?us-ascii?Q?8pf/PrrEpikq/d7aLBaWwbczQXkT7gcUEV3gS07w8Wl5+QByJJItMl7y7Jhx?=
 =?us-ascii?Q?75nGBOjLGDHfy7Fm5AtK/dwadCYl7QASUQ0d8Q3UpRBhs1y1xQJWR6yGsW/D?=
 =?us-ascii?Q?bwVgsd39eVUsk9V9GiF4jbmeSTsK8KW4XQQ1RgEMCA9JMymBTBIDI1aFbpzK?=
 =?us-ascii?Q?02Am2J0TSz1fI8bS9lVg7wNeut8exLH+?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA6PR21MB4231.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NDOtPawzd/R/5eBlEUXG6dlkWhYTZHGLuwOBJlar3LmkWr2R0p1WZuVlgkV9?=
 =?us-ascii?Q?a32Q2J6DDsxCxFskqHghYAJeCGXmm75rRwRKpmMJxO68QT8krm1j9jtLP9Zu?=
 =?us-ascii?Q?GzXf5XvBjuNZB4CEAQMGBpYLWBeuqrjJQsOCVATcH2W4lvty4ZzgrAy0nNm8?=
 =?us-ascii?Q?wZ4Bqw+neaNiFP1tisL7t5QoIEtTwYUIhVFW02atfFURGuYOumsjQ8K93/MW?=
 =?us-ascii?Q?HZzqOrSzTUeQ/bvmO08/Edyni8fcTCICbXLYY97xw/xAzuUZJo13tm0/t4fx?=
 =?us-ascii?Q?vHZnG5rBIDJxULshsMHKlhYpBM309tVfb92EjoJOY1d05EwYitBkD8WNiQC9?=
 =?us-ascii?Q?jl7WvM4p6PqW9MMe9ORS0xQLp7XAJsKBAefTZirgfFvLNOP5PXzWffY7mqlT?=
 =?us-ascii?Q?XLPSQID+LHhbedDeyDnvcxDriJ65HXnyOJLCF3VvQjHsbrssof6jPYYZESLd?=
 =?us-ascii?Q?tSOz5R8ZJnqUm1OEboAAvrFU1Lnnm9yQuvJ5bsC+rs1bBA1lryEI1ba9Ilat?=
 =?us-ascii?Q?G5rIrmPuyKqgj6iY9mycrkBr1gh1Zvm5Ug55etT1k52HZs04+T90eQfZZYwA?=
 =?us-ascii?Q?/mbjtsBdkM6c1NrgB1djrDpt+4r8WBJDLePGuUpBbw0tmo3nfP3PWb8fAohM?=
 =?us-ascii?Q?0XAMv72xZKxF3DvQfnFVToZvz6R5kOke5bHnUJqMJiQAKh0spOCKruPmT9s+?=
 =?us-ascii?Q?7N2gS7d1Q/++0KVYzo9SJfUnxflLq8H+T/9v7R0OMrD10ZPNL9mSBeuoS7cu?=
 =?us-ascii?Q?iJtZPXTQRX38tt026pXEKxVbuajlqWRA2oeOvApQ0mq5zbqW2KjMHTsoSxxr?=
 =?us-ascii?Q?IiEJqKkwJhATX2HSno3h6nqDJW+3nrHe9nH91Wla88D+G5Z8sPCaRf+I3Zuf?=
 =?us-ascii?Q?yBLaj795k9+SdiWWhRDFDD6ZIlOm+gCy97kBBu4ruVOY/sc95MBUcvriZ48L?=
 =?us-ascii?Q?HIbzPU1IniV9ZUxB832BEF2TlZCbaF13TIsfyvEzp45/zGe3rbGfJADbEK+3?=
 =?us-ascii?Q?kgUc0nSSPbOYgt8D5FcJIqetgeEPJM7MykLDJiNJhwGBkezgzyDMaOJ+R5Cn?=
 =?us-ascii?Q?B28UnqibMTH3J6avBLVx4JqdstwlzSETbIpvOac+bz+JuupM78mgv5GH5m9M?=
 =?us-ascii?Q?AGFxcZulK6Ihng6AeL0HDnEIGYbrK0gcmKKK/+fY+CrmbUScb/ywsGMiklyr?=
 =?us-ascii?Q?jBkS2AEuXiZUgNop3XQWkZGviHt+fxJBEo+sLyVS+Ze89MgQE3RxC5UFb8/j?=
 =?us-ascii?Q?Q3i39pUyZuQrATgrufOd2bYj3HYR/S+jTfe0EvllfIPh8ANPHk5pQzy0b/fB?=
 =?us-ascii?Q?ok1sepnlWZpaG1oSyykFwSfqn1UHbYkemTfzuvPNT9t7AJBW6yG9xnOg+vWU?=
 =?us-ascii?Q?+FgC3fsUhvNzbdQ5c596UInT2ZFHb3ptrBvnpczHeNuX1WhGJKPbiVr+Jf7d?=
 =?us-ascii?Q?qbJba8aEguOMeXppfqbzFt7OlHuhYSBpVGo1spfZMiAvBO+Dcn+RW/RuAfeR?=
 =?us-ascii?Q?r32JolihdykAdXIm1jk4koebeAeNB+ZLDBGsnpXo9EP2JlmOETJ/2fdN2m7H?=
 =?us-ascii?Q?ApzXkaKo1dt0Rz1l9XcKo0fyn1OhCw0qzhkXx6dQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR21MB4231.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77bebb7c-85ac-4668-af21-08dd5cfa8366
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 22:01:57.2097 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9JC9xnWgK29W8GE+ECV9FnyvN2mgBEF55p0/C8w8UkMQjOOdexc4CpMJVfXxNdwyU/wtMyLmN5DQBw4wsHQ9MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR21MB3865
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

> Subject: Re: [PATCH] net/mana: avoid the use of variable length array
>=20
> On Tue, Mar 04, 2025 at 04:37:32PM -0800, longli@linuxonhyperv.com wrote:
> > From: Long Li <longli@microsoft.com>
> >
> > The pathname can be defined as name[MAX_PATH]. This makes the driver
> > compilable using MSVC.
> >
> > Signed-off-by: Long Li <longli@microsoft.com>
> > ---
> >  drivers/net/mana/mana.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/net/mana/mana.c b/drivers/net/mana/mana.c index
> > c37c4e3444..d12dff6ce1 100644
> > --- a/drivers/net/mana/mana.c
> > +++ b/drivers/net/mana/mana.c
> > @@ -36,11 +36,8 @@ static rte_spinlock_t mana_shared_data_lock =3D
> > RTE_SPINLOCK_INITIALIZER;
> >
> >  /* Allocate a buffer on the stack and fill it with a printf format
> > string. */  #define MANA_MKSTR(name, ...) \
> > -	int mkstr_size_##name =3D snprintf(NULL, 0, "" __VA_ARGS__); \
> > -	char name[mkstr_size_##name + 1]; \
> > -	\
> > -	memset(name, 0, mkstr_size_##name + 1); \
> > -	snprintf(name, sizeof(name), "" __VA_ARGS__)
> > +	char name[PATH_MAX]; \
> > +	snprintf(name, PATH_MAX, "" __VA_ARGS__)
> >
> >  int mana_logtype_driver;
> >  int mana_logtype_init;
> > --
> > 2.34.1
>=20
> Did you try to remove the line below from mana/meson.build?
> That line prevents the compiler from complain about VLAs. If the driver i=
s VLA-
> free after this fix it would be great if the compiler was allowed to comp=
lain about
> VLAs (default in DPDK project).
>=20
> If the code still compiles without this line then it should be safe to re=
move it:
>=20
> cflags +=3D no_wvla_cflag
> --
> Andre Muezerie

I tried, it gives warnings on other two places using VLA:

[1688/3164] Compiling C object drivers/libtmp_rte_net_mana.a.p/net_mana_mr.=
c.o
../drivers/net/mana/mr.c: In function 'mana_new_pmd_mr':
../drivers/net/mana/mr.c:41:16: warning: ISO C90 forbids variable length ar=
ray 'ranges' [-Wvla]
   41 |         struct mana_range ranges[pool->nb_mem_chunks];
      |                ^~~~~~~~~~
[1710/3164] Compiling C object drivers/libtmp_rte_net_mana.a.p/net_mana_rx.=
c.o
../drivers/net/mana/rx.c: In function 'mana_start_rx_queues':
../drivers/net/mana/rx.c:244:16: warning: ISO C90 forbids variable length a=
rray 'ind_tbl' [-Wvla]
  244 |         struct ibv_wq *ind_tbl[priv->num_queues];
      |                ^~~~~~

I'll fix them up and send a patch.
