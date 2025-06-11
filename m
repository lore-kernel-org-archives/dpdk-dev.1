Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10734C677C4
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 01:24:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B805040144;
	Wed, 11 Jun 2025 03:24:14 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by mails.dpdk.org (Postfix) with ESMTP id 4B875400EF
 for <dev@dpdk.org>; Wed, 11 Jun 2025 03:24:13 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aBDtlFvg09xxQP2zXNR/GNHd/LMtE92RJ11WROT7draOhx941wl9yEDLb/SPl/hpGyB0QRzRSIKHm4aFV1qgjRQdpIuYCTeD8B6P1CPcgKALkgEHGAvW5RPyfRIamrC5S06LXSMawq44R1fSBZ1gxpwdJMou0b68lhWlDiWqIE4Z4NpDqV4XbLuIrgZzwfGHn1k7KjLxmC7u6EtRiIKPbVV0QOtGRCcLM9/F0GqLLNyDomlhdmZHxB9i8YACdvWWIQxkeq97kZ9NrwWXE0dv/Rzj6HtZAfnH8vG56ZNjEJn6ysq5ZDPSPOvsZH5ACIX2+z1NCTk4wVUcrZx79EN0HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PyiZo0D9P5KEk5Fj3egSYHiCStNwYXdQ31vK3dnFHVE=;
 b=QoKmjuchtqvKNsL6wLZpcUjbPZh7AGL3GfxcA7CpVCY1WrJeH8muBPEV5YV+nhjy1m5Wngly8KXrCdQqz6TwQg12DSQhqtsgxer9MAxcCwYXSzGB/ozY7kmnSTSf6GKnyUigvPfQWKFoE8ACGPpgLUCeU7HIby+XkRu9aB+VoUBgzJdd24rOUBK73zFlq+wquElyJcTRE+gbKGkXl/ZVn+AVvhQ2ZlPEgWT6Mi+FCfUCxJgr6D0vyWVus+BSZ0XwAB7j//ZscpSmoLJcyNFFFJP1c1zOba6ByesmOR8bF16BoG/+e0tufryu2OYARoaKgJrnL24I7F0stc82mWXskA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PyiZo0D9P5KEk5Fj3egSYHiCStNwYXdQ31vK3dnFHVE=;
 b=qmtiW8wiEF6BKB60LQShPGqJDaX0w+Ps9YkuD/QEMyLuNzhFXuvWOwf3ddi32pu5+BYKQZGRWMzPoVV8gEewQvOQO66TLmSpBh3xLEAxgVECsFmYx1sr3hwS2fAseTeK1VJ0MVR4Im9Z/mRSukx+WWV7nsvaqwVhDE9fIVfOWlo=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by PH8PR12MB7205.namprd12.prod.outlook.com (2603:10b6:510:227::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.38; Wed, 11 Jun
 2025 01:24:10 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069%5]) with mapi id 15.20.8792.034; Wed, 11 Jun 2025
 01:24:10 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: Bruce Richardson <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Song, Keesang" <Keesang.Song@amd.com>
Subject: RE: [PATCH v4] build: reduce use of AVX compiler flags
Thread-Topic: [PATCH v4] build: reduce use of AVX compiler flags
Thread-Index: AQHb0LCFssNT35AU5kW6BTDmyPwZVbP6ZSmggAAh4ICAAEGXQIAACI4AgAACbwCAAZdkAIAAG0OAgAAF6uCAAAT5gIAArFPg
Date: Wed, 11 Jun 2025 01:24:10 +0000
Message-ID: <PH7PR12MB8596A72231A1DDA75D2DD0C38275A@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <20250325172215.3360590-1-bruce.richardson@intel.com>
 <20250529154249.1310449-1-bruce.richardson@intel.com>
 <PH7PR12MB85967617A71099E2F0E5C835826BA@PH7PR12MB8596.namprd12.prod.outlook.com>
 <aEaUA7rDVyPJEvP7@bricha3-mobl1.ger.corp.intel.com>
 <PH7PR12MB85969B5D596151F83DA09600826BA@PH7PR12MB8596.namprd12.prod.outlook.com>
 <aEbSNr7iv7oNJ7_U@bricha3-mobl1.ger.corp.intel.com>
 <aEbUQNFZHhKFKGeB@bricha3-mobl1.ger.corp.intel.com>
 <PH7PR12MB8596ADB9B5BC7947CF6AC43C826AA@PH7PR12MB8596.namprd12.prod.outlook.com>
 <aEhA3YgjW9SsMfYE@bricha3-mobl1.ger.corp.intel.com>
 <PH7PR12MB85968037EC67A1CDD36F336B826AA@PH7PR12MB8596.namprd12.prod.outlook.com>
 <aEhJ_7lkI2wptnXL@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aEhJ_7lkI2wptnXL@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=a8d7e7e3-ace6-4926-9c69-5c056464a851;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-11T01:23:25Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|PH8PR12MB7205:EE_
x-ms-office365-filtering-correlation-id: 3bd0da3f-090f-4d4e-8f7b-08dda886aada
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?C+r6z18sH6Q/4/U6u0s5GuCVi09KrMTm2dQWjd1e/2N5jvutThH68LRoxKCn?=
 =?us-ascii?Q?q+3epNjIiz5Ivssg8cFznFUt0MCgpWM27zjAbmOLqgZZvhO95Y9yLd4A5VS7?=
 =?us-ascii?Q?Lm9dU8hCo7CfEZseHDU2Uoenp9lk83MVsPRrmRSPszcAvygR9wdd9rHETeM+?=
 =?us-ascii?Q?o00SJoC578HLRI8fRNkSuPnLiMmTflxCJRWXO9974ToJ20O9Q5HRezfUCtWO?=
 =?us-ascii?Q?IFbidSXjaBfOKwnLok8HvLDlaFLSGNDVmfMtlFxf7xHmNH2+7q83jaqXHu01?=
 =?us-ascii?Q?UamT11485C5OXHsjOJICRhxrwi0vw+KuRBvq6emsFerprSi95Bx1cIYh8ZLB?=
 =?us-ascii?Q?TRTGTqJYusUST4vZkTRtGadWmd0ewtiKBh6zW9HMOrzkuRCU/5wOXTvARzQx?=
 =?us-ascii?Q?DZuPlA3HqcE4/HXziRbx4gLUOKrYrk5TD2LI21NHtjt9aw/Kw47wH9piSHrm?=
 =?us-ascii?Q?padolnVkA18VIX9f6pRGie9noY+WKTCXxAFIvdht/ToFkq5zEhwxFN/E8HPH?=
 =?us-ascii?Q?apE/zmDB+AQeICXG2IbmXQgvRx0KDPmxpQqp2JWhAR/+VCLHIKeEMWMqBFgT?=
 =?us-ascii?Q?CIMsuqNvMJxhPtbpg0u+wUsnzCCjwBURTey708Z6HmlkoR1lR2aS6l0PbFIm?=
 =?us-ascii?Q?+ee7oGXI1W1tGMlMr4mjSE00oy6ZGfbNiCFlAbvRN26f3RqJ8trf48K+hP4H?=
 =?us-ascii?Q?BkVTc/IutDrQYD9YtzWPaROJNs28l+QKgbiTz9bmaxt59OY8aUFmXJvOhhVG?=
 =?us-ascii?Q?8OHV6cEQ1m562Bx++SM2qfOg7/5Wug1HZhM9zbWdaDevD86wt+TzboPLSucA?=
 =?us-ascii?Q?KZgySyW/FOkc4B0zNXFS+ZAJ5uGvE8sukrw0Xgl8MEgYvF3BFzAwjEJP4u2Z?=
 =?us-ascii?Q?tIIKwxrns6VFC5zTmjQnu953ICdLy+nUvigCES/n1vU0rjNVDWqC9j5XYyOY?=
 =?us-ascii?Q?4wtQ4Hnln7A+Z2lVbcsjM0kFe72QOCN6TnQF4JQbc+uDlF6G0fffVpCJjZb+?=
 =?us-ascii?Q?T4+cZuvPvN67G+TCUbheWg6yer0V02xMIKyxvHShf5YEQ1QlXIQQbJvgnGg0?=
 =?us-ascii?Q?tEJPp2feOEQnMB4sTMtBv/cvKElBKqPjX1/pDTPbzTdXUQ1t2UyDR+dIVP/m?=
 =?us-ascii?Q?9pIvVAP3MN5reGEw1/18Pjy1CcVAG95EaKD7pRPGE/K8tQP3Lh8brPiiIooM?=
 =?us-ascii?Q?z5M95zp2gtcT4ZjKCBpGn8urzK9l6FaEBJI2BnkfuEjbs8trAbKStllu7ZF0?=
 =?us-ascii?Q?LtPiKgsID8XEdyIRl+/OcCpuCiybHlG0qxr+c6WHoHeg5+wD3LNuqhFFDwj0?=
 =?us-ascii?Q?b7ZScIDIxmpn/z0ENbXbPbo2DpRIE/mCKywitqbRi3Z9yQAuOQ5WYTz1aMpz?=
 =?us-ascii?Q?SAvWkO4wvhcP0X6IlhSaJedM10RIEBVnVHFimKO8TCrOLBlDDqElAGKLp9YG?=
 =?us-ascii?Q?JhKYlPCvlsvnKCqyCc1obtNuu2U001kkvxoHZsk/3lqsnIyX/odZAmylFA0x?=
 =?us-ascii?Q?bWGJmvaHqyH9uzw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YBjswpdndjfrBF5Rd4wUjXf1lKGJyTJ8B6TrFJeL/3/ehlXI77AtlRynaWbn?=
 =?us-ascii?Q?rNrcZfXbA11BW/NfLDeoAvowyBCdIKWd9/D4PeWenC8p+ACuC9iMbNFY2oa2?=
 =?us-ascii?Q?WQSZ5QzTUXNfzJ+n3PsBx74zBfU+vOH7KZxmNUkZNW7SREBOXyKFlebZm/9m?=
 =?us-ascii?Q?Sdq+YZ7p87qvNj/AnuBrs+fhCQ9I/kbBMV2Nfap1fuWXWD3W6+en7gBb4UC1?=
 =?us-ascii?Q?/7f1FLanZeGNmcaOzdpKbDHweS0OvOOfTcpBn2Y2beB4bliBOzbW6IvV8vOU?=
 =?us-ascii?Q?BLDZ8HHXdRWoOsfy9x7HzodhpOgSr7VCQT7zQeBBliq0ZvTIovXgVUyvFJSe?=
 =?us-ascii?Q?Y2XOoi1osZB5YPJBgAE5XFgaoVax4R3I1kZGTN/Yf+7UBAkpE2R4MOraGADH?=
 =?us-ascii?Q?F1NuBL1qfz2QfyEtfHMFIi5934PAjJeoIhT8vxIgrvw9VhM9dc3UlfY0UPUs?=
 =?us-ascii?Q?ekYJ6khS/tv9G2li41ze0+TKbnhVj9wGT5Q4T7Hl7ec8PcNwcjit9GsFpPIN?=
 =?us-ascii?Q?WoKuk7yZoQrIzLLbOUaQv3vlqHoeywzOd3e5D5cEYDnKQe0zizm2jVMiOXb5?=
 =?us-ascii?Q?qp86ee8fYBX63A+YHPz5uCwL91zqehsSFfFrGjeLc726y8sRtaXmz/E/vaBa?=
 =?us-ascii?Q?cKkiZ5NRzkcXnKAJOL31QHLIzUDGOkMi162fDn8YQNm67xI3OmUTD2zEADPZ?=
 =?us-ascii?Q?/GNquto96HiV+jwHpd+4jKolGwtpCd+Gheg5U3R5XOGD31iE/xaIE9bh0DRh?=
 =?us-ascii?Q?PVBQSR3PeV1jQTJfS1shefbM53fCBeFUn52YnGJuytoh4tL4DObTvKKJXDXG?=
 =?us-ascii?Q?vjiicnokMaC7PU65GhbmeXEBgBQiNzyq0CejBeikkwCBLSZABg5dh4TK5HiT?=
 =?us-ascii?Q?38c0VspVNTyOOAU68vflZDN3QFsKtSSobnbUeLu8yDNQerHl3RO39z+EB2bY?=
 =?us-ascii?Q?LcZhT3QvMYNzMzBE4eq9WKrAktHChlqa2Qp6KSxZDXSG7CNfTQf0JQJKhqZS?=
 =?us-ascii?Q?V6ncE/SoPBUHWtVUgPXbv85bak2iPG5lxsBpN9U8hX1pHB2MaJ+77HyuY2d+?=
 =?us-ascii?Q?GtRsAmSBIKErSdMGljcY2I4qS966s7Lq2AVQ+gtJNavLUA5gtsMwSVAHH+nJ?=
 =?us-ascii?Q?HiSD2Lw3pctX80U5oReVn5BMMLDc5s84nyn0CeSq0yD09RNpVGZ2qGOVw0wq?=
 =?us-ascii?Q?rggLPexj+ZNTWY377sS3H3RY3jm8Oes9g0gjKXuRdjiISO6IW+LElXmpKk/z?=
 =?us-ascii?Q?vH01CVpOnH4PcD9rVetAXHhta1iIG38eHC3Sm8/QCSR98MzN9Azn8if8h+9f?=
 =?us-ascii?Q?DwbnEwbs5e7lF98wdE953I7LEL31WP0wjRJ+oG7I7R3pZmepm2XXWx89wl46?=
 =?us-ascii?Q?1tAI0Ehp9OIYQCuMh4yqhGphKzTQot4HRsj3wFMTuxHN6wfv+uKyIr/+ihHI?=
 =?us-ascii?Q?ghUYAI0eLAKSdsjfEzpSXSEorT6t1/LvyvBUesf9nvCSrT+myiu4ThmIHpIK?=
 =?us-ascii?Q?PM0DnB8GE/wqBxy4QoVS/4CLoj8cY13fTKrJneBKObxnleRAbysQ/6JTBRy/?=
 =?us-ascii?Q?QPwcSkt67s0DLKW1sEI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd0da3f-090f-4d4e-8f7b-08dda886aada
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2025 01:24:10.1937 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x/JOj/AeFe88uZ87j5h3WXeLRTv0VgjA3t5YrDjkWp2szKPsg4y+bEg8HoYgBdlIh2ikzATaC24NMkT32jBgrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7205
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

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Bruce Richardson <bruce.richardson@intel.com>
> Sent: Tuesday, June 10, 2025 8:37 PM
> To: Varghese, Vipin <Vipin.Varghese@amd.com>
> Cc: dev@dpdk.org; Song, Keesang <Keesang.Song@amd.com>
> Subject: Re: [PATCH v4] build: reduce use of AVX compiler flags
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Tue, Jun 10, 2025 at 02:52:24PM +0000, Varghese, Vipin wrote:
> > [Public]
> >
> > Snipped
> >
> > > >
> > > > In above log I get `2 instances of march`; logs `-march=3Dnative
> > > > -mrtm -DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API -Wno-
> format-
> > > truncation -Wno-address-of-packed-member -
> > > DRTE_LOG_DEFAULT_LOGTYPE=3Dpmd.net.i40e -DCC_AVX512_SUPPORT
> -
> > > march=3Dskylake-avx512`.
> > > >
> > > > Question-1: I think this is not expected right? The
> > > > `-march=3Dnative` is populated
> > > from `cflags` and `-march=3D skylake-avx512` is populated from `
> cc_avx512_flags`.
> > >
> > > The above command is correct. So long as the compiler supports
> > > AVX-512 we will always compile the AVX-512 code paths for runtime
> > > selection. In practice, all supported compilers have AVX-512
> > > support, so in reality we have the two scenarios you tested:
> > >
> > > * The target architecture e.g. znver3 in your case, doesn't support a=
vx512,
> > >   so the meson.build file adds on the necessary flags to add this sup=
port,
> > >   i.e. that file is compiled with -march=3Dskylake=3Davx512, which is=
 the
> > >   minimum ISA that gives you the necessary support.
> > > * The target architecture, e.g. znver4, does support AVX-512, then no
> > >   additional flags are added and the files are compiled "as normal"
> > >
> > > In both these cases, whether the target architecture is specified as
> > > "native" or explicitly makes no difference.
> >
> > So, for files which needs avx512 support like acl_avx512, fib_tire_avx5=
12 and
> others, we then only pass `cc_avx512_flags`.
> > All other cases this is ignored. Thank you that makes sense.
> >
> > >
> > > > Question-2: if the target is meet minimal ISA why not we use
> > > > `-march=3Dx86-64-
> > > v4`?
> > > >
> > >
> > > Good point, that would indeed be better. I'm just not sure whether
> > > it is supported widely enough on our compilers. Do you know what gcc
> > > and clang versions support that target?
> >
> > As I recollect we have been using `x86-64-v4` this from gcc 12.3 and cl=
ang-14.
> > I am not sure if the older versions supports `avx512 that is
> > x86-64-v4`
> >
>
> Checking with godbolt.org, to see what versions give errors or not.
> * Clang accepts the argument from v12 onwards
> * GCC accepts the argument from v11 onwards.
>
> Unfortunately, that means that we need to at least keep some form of back=
ward
> compatibility for older compilers until such time as we have those versio=
ns as
> minimum.
>
> If you are ok with the patch in general, I'll see if I can respin a versi=
on where we
> check for support for -march=3Dx86-64-v4 and use that when we can, otherw=
ise
> falling back to skylake-avx512 as here. Does that seem a reasonable appro=
ach?

Thank you Bruce, that will be great. First try for `x86-86-v4` if it fails =
fall back to `skylake-avx512`

>
> /Bruce
