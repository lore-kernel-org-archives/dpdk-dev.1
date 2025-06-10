Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81B6C5B552
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 14:52:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D17A742EAD;
	Tue, 10 Jun 2025 16:52:29 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by mails.dpdk.org (Postfix) with ESMTP id 96D1040672
 for <dev@dpdk.org>; Tue, 10 Jun 2025 16:52:28 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iLHLfU60PsBJRrFjHxdXQPzcv6d6ZQ9qHUb94BiChRGdMyVHiF3wWQZKpSr+ystKaJDBGRDgqtE09q0uszbKa4wQgH24qqSpXxTLULK1xwJ1pu/wWvwR5lERDxmyTI9p07VKbz+pvq4UAIseHLsfvNTSvRIjwvydjMrXY9z8ss9KbLzNxc6qam/1IaFpu8kYzxVt/76x2H4az/wBY+wFrtNJeTL6XNKyrPm03MON1aDHcXfmjgNpIBIHw/rFaRIp1QsHp8aIekZ+Q0EniZfA+hasa4PVkSHp8R7w+lPzfyhlW/Uexn4ZBVhsH+gmiNMlUePbbJRFUcFP6IWdmS+JoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PoIeQYmD4cxakRexmiywiYLS6qozyCn2GNhh7+KDm4=;
 b=NnYnmPAnO3UjilmOo4xKjCAzgMmSEPEkyRZa2gN8gXmuSz+gPtbc6NmEVSZM4lVUX/s0gjPI21OhF8futDuvJ8i6e4Vx2C+nso+37qv3HvSPI66/K1aAvPMZGCKrDB/L5H4WFiz/eFItYAJNlfRM0oMn8M1z4FwWecxe0LtliZHzzp7muIl0u5iOrXhliM+ChtUdLfyzKtSIzsT8W8MhfwhYMJmeIcJ5ErRBiwAIRjR/qw08BxMZ9rjagG0xaT5H5//sR/gM9UGwEknC1KzfiIGqbiSfFdcWcGsb2ZYdTcRQxDV3h0aZiPRyayC/FC/CKRfSpKEbVpCKzHlSUkCL3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PoIeQYmD4cxakRexmiywiYLS6qozyCn2GNhh7+KDm4=;
 b=q0QFsGrFWwmeJxwZB05HHmq4XHrl1fzMVXpIdemn7AW1PK0KWZlKPbda8ldUZHWCE5HOIh967vFhZJ2XGrKgznsapCXvVgQeIH+DR+5NZmXOO0n2pmIdgNxNtxv0AxRdnNQgFnGE/D2ZkJpgEJ+o+Wri88NeErflfcoFmcMKKJI=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by SJ2PR12MB8881.namprd12.prod.outlook.com (2603:10b6:a03:546::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.36; Tue, 10 Jun
 2025 14:52:24 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069%5]) with mapi id 15.20.8792.034; Tue, 10 Jun 2025
 14:52:24 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: Bruce Richardson <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Song, Keesang" <Keesang.Song@amd.com>
Subject: RE: [PATCH v4] build: reduce use of AVX compiler flags
Thread-Topic: [PATCH v4] build: reduce use of AVX compiler flags
Thread-Index: AQHb0LCFssNT35AU5kW6BTDmyPwZVbP6ZSmggAAh4ICAAEGXQIAACI4AgAACbwCAAZdkAIAAG0OAgAAF6uA=
Date: Tue, 10 Jun 2025 14:52:24 +0000
Message-ID: <PH7PR12MB85968037EC67A1CDD36F336B826AA@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <20250325172215.3360590-1-bruce.richardson@intel.com>
 <20250529154249.1310449-1-bruce.richardson@intel.com>
 <PH7PR12MB85967617A71099E2F0E5C835826BA@PH7PR12MB8596.namprd12.prod.outlook.com>
 <aEaUA7rDVyPJEvP7@bricha3-mobl1.ger.corp.intel.com>
 <PH7PR12MB85969B5D596151F83DA09600826BA@PH7PR12MB8596.namprd12.prod.outlook.com>
 <aEbSNr7iv7oNJ7_U@bricha3-mobl1.ger.corp.intel.com>
 <aEbUQNFZHhKFKGeB@bricha3-mobl1.ger.corp.intel.com>
 <PH7PR12MB8596ADB9B5BC7947CF6AC43C826AA@PH7PR12MB8596.namprd12.prod.outlook.com>
 <aEhA3YgjW9SsMfYE@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aEhA3YgjW9SsMfYE@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=ddb37827-7117-4db6-a5d0-358f4a3ab144;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-06-10T14:49:01Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|SJ2PR12MB8881:EE_
x-ms-office365-filtering-correlation-id: ace73070-ba82-43f6-412a-08dda82e696b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?kHpVwmNQiKJgaOzMpacLOZE8bdN06nV5fxUUkm3gfF+427XtuELZv0wSTVZZ?=
 =?us-ascii?Q?Dpt5hJnMACOk7EcOGeEp9yTA6B7O2FOFOru1QCgPX4czc0jqybwMFFY+kqOj?=
 =?us-ascii?Q?9Q29xmm/vkeB2rKeAS94jUpkwyL6wcx2+7kOz7Kz9O26OUVigoA6FTA5L9GO?=
 =?us-ascii?Q?Oz/ib4j7rOdYj7kQztzDJst4q3xH2JHDCJaiC5G1FKNNQQkWwVhPpZ+5TQGI?=
 =?us-ascii?Q?S4ZChqi3BbxqhKym+naylE6sj4BFt+dqbb+0mnubRsxmFVspl3wTMbuOEcWt?=
 =?us-ascii?Q?B2gpUhvVBclfWR1JwwAWOA6e2eS3nC3QdWuIXIR2CD/0ACfGN/0RNFvfqgn0?=
 =?us-ascii?Q?ZvyzfNTnnPezV2qpXNXwtPAB2JrUL58A549Fvd985iYK0LZ/te2S+S+nOnRD?=
 =?us-ascii?Q?tmDdnQfhVptfKf4T91q8kBH6/ECkgxks+/nS9nANCr3QmQ43b1KcR8FXTwLo?=
 =?us-ascii?Q?tdp3Sm3EUGNHMorTpy6wIj3hx1/fVtQgsaJvh2x8pfpXDN4m4w9N659yc+P5?=
 =?us-ascii?Q?MCLzd2i9tPuBQTryGNNzZMvfqhkke9gEyzHtViGJI91T7duq4GOuhrCVBg94?=
 =?us-ascii?Q?zm0bGvt01vQGfN16imAW+ZtoqhxR7q7Fe9U/1ctynCQWQF797onWihQzfvRy?=
 =?us-ascii?Q?r8H4yHEF1OueziBhYrZ4a2HWwXKS03jyxZC/5xO9NyYcIUHxu4Cr7WE96P8v?=
 =?us-ascii?Q?q2g6wM3ocJIl1Qb7ydzR+YwRLepIWPtCkNHX972vkhHOsi6AJoFt2NqZPZm+?=
 =?us-ascii?Q?ZW2Yl3oqTFJixvxlQHmsw/yRknhZLE2TyeQ4L2Jn0F3kvsVnAumpb6jwEFHU?=
 =?us-ascii?Q?a2/l+O5eijZwZpJu7lhNmZJ/mcIZ8J2g2czy/x7F3IlDplckrqSTCjsWYgrg?=
 =?us-ascii?Q?0dWFGqacYJMRmw6RNSInP+62/uezUwZq38UfgIo14JSRoDnFnOeuSSLc3r0j?=
 =?us-ascii?Q?2XYqHd2BZb/FihTq/OWiooLtsoasvHt4rOR/HkX6xMPMrKeT5X7hBte5WiIn?=
 =?us-ascii?Q?cSwJVmwH8vCzgFR91GficD8MrK/h4+2JgtZ/WlRfM4odao6JAFPXpq6vbwyQ?=
 =?us-ascii?Q?+gQPtHjIpjY5AjudsW8+tX3WUVO3ySLn99ywda/1QTKyyi7IhGi2XIG8odFc?=
 =?us-ascii?Q?1AvENeXixIUTWNQfrYH0z72e3x0gbOvYIdILH276wXO64sr3z3MaDIg7AGim?=
 =?us-ascii?Q?W/PNpuTKs+nJmwqNy9ywGw2Bjr+jm8mvHtT9m9r5m1rV7Tl72e6kRwky+Uet?=
 =?us-ascii?Q?m32XhoRLIA69PRgW6MoLMtjyNiG1/VnnZR1ruxPpFptL/I1ywlGv2oZ1cR7R?=
 =?us-ascii?Q?MackduzsZo4sEUFnA8ewj7qQiWtOMs6mPDTAKUxLJdKzIfHKjvthm3vf7Y7q?=
 =?us-ascii?Q?tAKpI2JMrEEZ0kK/OeX5t3OCvw4YoxrT0IehKlINeU4Dxlzpg1Ei1BoynELS?=
 =?us-ascii?Q?ySjfBOxiBsMPUO39yGZwwP0GKa/1Wm3L3EbHDY3iLtUkZx53QY4Sxw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lhdspRT9CKFgxG+BnOgUe4jDiC6TudN86wyeQeIYrqy38zUTK1Va+7PcSiEW?=
 =?us-ascii?Q?z6YQNz5xJxU1uSJ7Oiicg9WdTcHUnuViNamnaEC0Z8IM6w+c+Vpf35cUs3S7?=
 =?us-ascii?Q?QNlxSeB9k+1QpvijC0Fy4ENsjBTc6bEwV75YxGLwDka7W+dqxL4fmGZWgXjc?=
 =?us-ascii?Q?rZnRAtbcFsXK0eLSNEbThPXVLgCgbk0u+w9P9S2ydZgVZx+tgaWdv4dg/Lf/?=
 =?us-ascii?Q?hFML0H8kmIYCynGp4ZG53ZtIhQOG+R0APf2Xb3AH3rOC0LYqiUDumlpMQQ3m?=
 =?us-ascii?Q?yTTojcX2Yfho7QHnPwKwilyMqeN0taGrgffzPZaz/QSZhB/aoZue6NhCe8x+?=
 =?us-ascii?Q?4ISVRu0tq2HfrGkHDlQ53U+X0szEzQybGmDOA/Ue0TkJqb6FL3yD8LZJfeM5?=
 =?us-ascii?Q?6Lw1MgEqnXX6T8b8WLZqX1HW9qn+tUvfUwarwULcO/E+p2HjzFjbC7ikqnk7?=
 =?us-ascii?Q?qjumCC3Lm6k2ohFseJmKKVAushGDlCXv64EfRbOiv4BQ5WxqrJWiKKvST2/z?=
 =?us-ascii?Q?ccy804zJT9zUFomPreffoVEfJozz+00bji0EAq1e4PJTYK0z/7JjREUN/Wa4?=
 =?us-ascii?Q?6qismzeZ3n9iwyevIXU9BTOTEFDoCIY39Iu52DBNJUFL18CwkPnNWBdN7cgH?=
 =?us-ascii?Q?Yhuql73QwcAKPJ5gNao17l+45laIuT8KToid9tBB6hYZfyS50NuA7PNdi+R3?=
 =?us-ascii?Q?ATgOba3FA0Quynnbhr6g81ZgMhf8h39OEKGCzuObDFjHAy3pd7RxlOO9Z1xT?=
 =?us-ascii?Q?Y4UNo0/C7bRuJ/bpLLoEerSLDSPkcllYDB4vg05+rZAdnLR8XzEcZjdc3EB3?=
 =?us-ascii?Q?t0qzF4PgULRmb2VK8qOuw6t0MTp0XBI9aYr76qDV0hy9UlRm5j/4q+iWG7Oz?=
 =?us-ascii?Q?DuFLM9WlRUY/bM2/zlZuv+t45ElbsWx1Lx94jLjBjeGS1cqVsog05iqi+kJ4?=
 =?us-ascii?Q?RqAjTf8H5J2+sUV1cwMPrGNK+HTaJPQmCWK39AH/TfMzlDu8JjE/JMY2jIp8?=
 =?us-ascii?Q?hm7d0HfmtTfepbiDWxC93gyEwatQ7dHSIkOQCIdohUQtTps5PVt0NidDTn6Q?=
 =?us-ascii?Q?dQXNcAytn01NXxiQKvEoREIjn82xGyu4JUQsu8OIy7G0szNjiH5GGh6y/8OK?=
 =?us-ascii?Q?Ds1X8JwZn0UrdKRe2BdNGO2T9sozXfmIxBjnpYWzz5qNQ8mXcOWIGWFdK+CF?=
 =?us-ascii?Q?vnAWzbvhjUUWv+Tqk9Hg/nuZ5Dpj9q9eaS75p61Nnc5hYYU4ObTwUpJMOetC?=
 =?us-ascii?Q?U0z2iwcYcYucr9kXviUE3Xb32/n7+WD9/rcoyeVNUMgBwTQYNGXEC6Kb+Vo0?=
 =?us-ascii?Q?cI75ZYkjh2i53NCUmbQMmNCF330NG6JtrMcuL4Hm9JsPj6gw1TJiWou1y5k+?=
 =?us-ascii?Q?G4W+Bkokw3X9IsvmOv0yQaf1AXsZQpLYAzvoRrVA2VbUtGRFhr3GxKxfsRvX?=
 =?us-ascii?Q?8FWhXp2+xlMvN7FRqt63h4u1H+Bt3gB2xQ/7KBd0UPsoQzeBkJ4PVVQCVCBT?=
 =?us-ascii?Q?yrPvvkquEa2dY9NOvMiWsDz+UL+eu3KDLf3et26pFYrYJHrpIJ4VI6kBQWGG?=
 =?us-ascii?Q?ixDvZQfKAAM+2dtEKnM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ace73070-ba82-43f6-412a-08dda82e696b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2025 14:52:24.6734 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 443SvU31079Fxetx2sUyWavmpfjMe3+l5L3xOOrlFEEWtAHtHI4u5gL2bLC3qr0sFKLJfN71Qmg4QC7XBQtByQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8881
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

[Public]

Snipped

> >
> > In above log I get `2 instances of march`; logs `-march=3Dnative -mrtm
> > -DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API -Wno-format-
> truncation -Wno-address-of-packed-member -
> DRTE_LOG_DEFAULT_LOGTYPE=3Dpmd.net.i40e -DCC_AVX512_SUPPORT -
> march=3Dskylake-avx512`.
> >
> > Question-1: I think this is not expected right? The `-march=3Dnative` i=
s populated
> from `cflags` and `-march=3D skylake-avx512` is populated from ` cc_avx51=
2_flags`.
>
> The above command is correct. So long as the compiler supports AVX-512 we=
 will
> always compile the AVX-512 code paths for runtime selection. In practice,=
 all
> supported compilers have AVX-512 support, so in reality we have the two s=
cenarios
> you tested:
>
> * The target architecture e.g. znver3 in your case, doesn't support avx51=
2,
>   so the meson.build file adds on the necessary flags to add this support=
,
>   i.e. that file is compiled with -march=3Dskylake=3Davx512, which is the
>   minimum ISA that gives you the necessary support.
> * The target architecture, e.g. znver4, does support AVX-512, then no
>   additional flags are added and the files are compiled "as normal"
>
> In both these cases, whether the target architecture is specified as "nat=
ive" or
> explicitly makes no difference.

So, for files which needs avx512 support like acl_avx512, fib_tire_avx512 a=
nd others, we then only pass `cc_avx512_flags`.
All other cases this is ignored. Thank you that makes sense.

>
> > Question-2: if the target is meet minimal ISA why not we use `-march=3D=
x86-64-
> v4`?
> >
>
> Good point, that would indeed be better. I'm just not sure whether it is =
supported
> widely enough on our compilers. Do you know what gcc and clang versions s=
upport
> that target?

As I recollect we have been using `x86-64-v4` this from gcc 12.3 and clang-=
14.
I am not sure if the older versions supports `avx512 that is x86-64-v4`

>
> > Note: I am yet to check for cross build. Will update on cross build how=
 this comes
> out.

Shall we skip the check in cross build?

> >
> >
> >
> > >
> > > Regards,
> > > /Bruce
