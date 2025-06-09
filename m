Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67335C5B552
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 12:23:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7DD740A6C;
	Mon,  9 Jun 2025 14:23:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id F1A1A4060F
 for <dev@dpdk.org>; Mon,  9 Jun 2025 14:23:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749471807; x=1781007807;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=LcBLFcTqTdF8SBOnDgedTKmym+/aVlXJLmNZS3hC65M=;
 b=KIA6uGjybCbXRV8lglaI5gMawUuwawCx6ISD/Ge3HYXOITlY1b3QxweT
 n/1pChrsGBOPJrrCQSY7nrmZM/weIb/1CejUjrtBJ2x2CiJ3aQR4GVwri
 NI1b9pHpBehddRRVQfFjGoQj/0hW+oe3Kf80o9VnFJqmzDz6j+VskH/8r
 bf7DEx2kRvMR0rAnGIGQwAqBQXIzAbQkn5oUhPGQiywNHZWSa6/p17FDt
 /wZmYNtLvf5mH6ChPaWrhoepirql/KfwridSzg6xU8QfvFZP2oeJiTMi2
 sXP50kw/sIJohCis7F4uDU7bpV7dtvFcLecjrB05/UGSokSr2cZc2hx4b g==;
X-CSE-ConnectionGUID: TOFOnKrXQJer4Xn61gRMUw==
X-CSE-MsgGUID: WKZgq1U7QCuDfQJCG+nhCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="51250708"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="51250708"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 05:23:26 -0700
X-CSE-ConnectionGUID: pGvJakjKQ4OsgFxNEh/QAA==
X-CSE-MsgGUID: ejGmEpAGTHu9Yf56NudW/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="151494923"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 05:23:26 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Jun 2025 05:23:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 9 Jun 2025 05:23:25 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.57) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 9 Jun 2025 05:23:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KEowo/HTVWIYq3miImvUiew/etkeeuzh2ZlReNJ1cMCCkWVhKgNoUythOTKyjP22C/2LKrTEAnh3ie7eitaKTdRBnAK4ULuqVRmvzsJmMcN5DncihoosDZHNadPf0qzrZLgYqdJTw/saDFcdVq1D+/gWdRqJAldBYMCvvQ+Jgl8KZQt0da5pqTpLBjUXgYqqiuEHF1roJLtVLERb2TcM42bcWy+yOvCR662pzCehv0pGvm4x+ebITKbK8w8ob4ZluOvsat3bNQfb4siduTR2xNJqsq8k1dA7N6SlPJoJldxMcanv5mWGt/qs1mcPzbB0TjOGoL1JcZ8HolYXjeaOlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXGORmvPKGWScaeUa3uc8Mz9hQyoOQh8jVobAjl5CZs=;
 b=gpj1RPeXXFEKEjJc3iTRDp9hM4uMe1Hxj54hlN8R1/7i7zkrb93Yh9kvS44xs0ZETfk79cdQuh30+jYGWXj5160L2AAcpoyOTz31tu5c+4Lp+4NPA1nW9oUAWvPdGN49CVhuK4aYFmLmAtaTxRupEkzpuimwYhLpcdiWt2/k7Zo0miHbOLcrkluy0aevnj+VN/hqxaTUqwgtBuA1efGZDucMyrIL5Scjrs9+kLVCd2pa48afOShrgbShzdkbF6UrmasZeYUnSIgkhrYAGJ04ox3IdxNwobu2x2472jV9f24U+Bi2+iJCsAM1kf5HgR9LK6GJSQLEzpmhLnvPft0lsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB6497.namprd11.prod.outlook.com (2603:10b6:510:1f2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.31; Mon, 9 Jun
 2025 12:23:23 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8813.021; Mon, 9 Jun 2025
 12:23:23 +0000
Date: Mon, 9 Jun 2025 13:23:18 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Varghese, Vipin" <Vipin.Varghese@amd.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Song, Keesang" <Keesang.Song@amd.com>
Subject: Re: [PATCH v4] build: reduce use of AVX compiler flags
Message-ID: <aEbSNr7iv7oNJ7_U@bricha3-mobl1.ger.corp.intel.com>
References: <20250325172215.3360590-1-bruce.richardson@intel.com>
 <20250529154249.1310449-1-bruce.richardson@intel.com>
 <PH7PR12MB85967617A71099E2F0E5C835826BA@PH7PR12MB8596.namprd12.prod.outlook.com>
 <aEaUA7rDVyPJEvP7@bricha3-mobl1.ger.corp.intel.com>
 <PH7PR12MB85969B5D596151F83DA09600826BA@PH7PR12MB8596.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <PH7PR12MB85969B5D596151F83DA09600826BA@PH7PR12MB8596.namprd12.prod.outlook.com>
X-ClientProxiedBy: DB8PR09CA0036.eurprd09.prod.outlook.com
 (2603:10a6:10:a0::49) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB6497:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ef136bf-c50f-4f33-cccd-08dda7506d4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZqcIGINBCzbvfozaaqxxc3I2cNLoB0VFUCWZ5wPQQKoIj1Z+b98PaEGsR8EG?=
 =?us-ascii?Q?8zAg4DQev1+YoISjBc+iFoQ5fAA/BNGgJhRNd4UsCJp22JdQ77g6wYm7wo6K?=
 =?us-ascii?Q?fr/8BiEOpiC/G4fDFffrFzE4YLTM+nTmokj9+8MJdNNkB8vS202zEYVmK1Pb?=
 =?us-ascii?Q?gR1N1nQLfAnAC4vkhSdQQlSqSOmVLn4p8vy6DXctE0hGMYWqFf/OvMDReeJh?=
 =?us-ascii?Q?LZj10J7/VTV9pn3696j881Af3SYhXD+ZV85DDM195ll/wtsmSd5RbAbf3rwb?=
 =?us-ascii?Q?nKgAafEBRJhoiZoZv9/7daJqoTpV3plnF07wTL04i8lyjMCNelABzJdGcqDH?=
 =?us-ascii?Q?JCxVoJnmkFt8CrY5QNPzMa4JiJ3b4lOsjNUsmm+2uGpdn9fsXZMxcGmFHrjn?=
 =?us-ascii?Q?XDFFKahKlwwTcEvZlp9SkdUC24rQ3eGZvgdzEWQFmkMvAoTrFrJs2guK1csq?=
 =?us-ascii?Q?++svlASti5IP1CcEK5zJj3saDd1z4plLv2MGZY5l47tsx9LbYSmFbuueduuT?=
 =?us-ascii?Q?x4nVn2hx6CLJHVr1+qU0uqkn2ejIEfpaZHsklD7++vqOPVRfJZqSVnwuhCu5?=
 =?us-ascii?Q?YL4Jj0bqOLBYH3aVNY7CHISSKnYLUU4XpLzLAW/hWhP6dAk6r+yQhjYlZUX8?=
 =?us-ascii?Q?OPiXHrEDvwtAQ1huXjteXdZmrEEXCxUfB/VDs8hgTovmq4rcyPw1izjwrYMO?=
 =?us-ascii?Q?ZRkslGx5zLOxKp68sou/a2VlGRCrTltR9NM8yGfR78X380kxIALzlqhihy+6?=
 =?us-ascii?Q?EV3sy0Y3JqXFnxSew/cUlD5PPh5SLjXuSvYdTLumXKaZ4xIYLSLKiUH3hFfj?=
 =?us-ascii?Q?tUOyKhBqhScDSA7/1UjhV2xqLGSysVmq3r6zuLYxezEY5bfgc2FUhtFyx8em?=
 =?us-ascii?Q?5pdxO8nqar8ffKm6O1l9REO0DymYKHMwzo7H+oqIk8d10tUNFqSd3Xdzduy3?=
 =?us-ascii?Q?UOv8sCcQtj4US1Ub3l+H5x/VRdWqH7OWCN7Z07GwdJprc9K7x+U+fi5cpjWI?=
 =?us-ascii?Q?YoTRJYWzr8IqUP7nQPqdRU9Aapk1u89y+Q0oXDHILEjDrNIXtcwatEk3bV0b?=
 =?us-ascii?Q?IGMsguqrybMuYQ9AuAGDYXAWzXyCHVEpF/pjEFa9Xlx9W31OAvoHjVW45nV2?=
 =?us-ascii?Q?mvW846wkVF9ah8DzFLK08Tp7Tt7TTn3EmpyacVl+tAdm+uy55nj8gobjGz4d?=
 =?us-ascii?Q?yIvuVAc4uUqmLmUt37eyhaw3jiYqkZX78u3cr/9aui/faFZ3fK6RkPWDes+F?=
 =?us-ascii?Q?z+M3ryoHZpJCthAMlBghYjQ/S18LLrtDk/HNJbQeVFgW8MH3uz7Nkup4sxKd?=
 =?us-ascii?Q?47jC9moRtNsSBn3/bqn98KqYRR7+JHyIppgrrrMoL2DAbg9MzOAPWhMD2PUI?=
 =?us-ascii?Q?4NI7dJVn6aqR0VKFO+sK5mBecpeJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O6huC98U7qoWVFb6epV0RH37hQ1DhoYzSWFrL5dZQ8rBNfjbmi9y49QtoXIm?=
 =?us-ascii?Q?Qz+Ll20J6JvDFMIKmc9FIePVHSKfpKnm1bdmamRHbgvoq+4eKkDO2x95aokI?=
 =?us-ascii?Q?Bsd+PDwE3Py63Iz5Le7PBJKrpJ9Cn9t1PmPJYniHr69T9yqEqmmpDci1afVc?=
 =?us-ascii?Q?Les5ty/wcDklcC5X/hvslNmtoXrc6VjTaxxogo5JIRaSf2cr9NxzL+8GqKnq?=
 =?us-ascii?Q?FHa3utugwhtoxNyNIZiz9KL0XbKuXy05T34s5QYBwujWCbW1FchSDbsYBmhz?=
 =?us-ascii?Q?MshFlwPoMo89uX9CxpQqnVdi+a4CTPWB1qdzUnBntsyVOxcc0nx9KKc1kFn3?=
 =?us-ascii?Q?6FDJMK5kAY9kG7qDrduh3YgFvFVo7SrdzgnGtArjN7nXOeCNGunEoYiGkcAN?=
 =?us-ascii?Q?+MG2YW0F28z5lg+O3pVF2osKTskz/82CctS2DsI3zaVVkOb3mXVWyND9jpdx?=
 =?us-ascii?Q?Y36unLuQPzmw9gE70tLFwGrzFCgA7o2fA4zUZbRckEMyTUy2x3Aa4Gu+uWVr?=
 =?us-ascii?Q?VTeVtFY/4PfprFSWw/SBeHwBc5tO8B6u55D6qdz7uDxeUaTSEhHmY3hxH1DH?=
 =?us-ascii?Q?d8kxAtgSg21sgfAh/XWaR3jS0Dyw1ZbyYY6uvTwDP3EfsKK57Tzs43qFSW0W?=
 =?us-ascii?Q?fLbRrdUFxNtg1zKYSKEgLIpHX0ceDFoDtqBcOO8ZLKf3Pl9g2OxZqkwrwY4f?=
 =?us-ascii?Q?zekFt5bVQIkR0cFs8Ai5MkNxb4L9Q5lskVlbRDKG958lshChjigDJ2Agl6nJ?=
 =?us-ascii?Q?VioECuCvrANwMM5TiFIlbG3h/53mKzBPG9DbKjX0P22NulJV+P+LSTNPS2iK?=
 =?us-ascii?Q?ORf5sxCd/tju3apeF8HO0pZczIfhN9svAlVrJeeeZZAQ2yyOGGmExbEPLNZU?=
 =?us-ascii?Q?26dVdTe2lbXbM5O2Dl4q3xN9+bV/NiDsaa7aTj3Zr1ec5Tm+iGRDWV+jDzWA?=
 =?us-ascii?Q?B/YUB/p1voRRQ/oGCZGZxEer5sYEQIaxiCKwoluyGosSu+rwNtSFQoPFozq6?=
 =?us-ascii?Q?ele0EGoa4LhGBLLh/2F6IF/MBITY54ChzAJpOplhVaNh9+e5jNZnMeX2mTz/?=
 =?us-ascii?Q?voBkSjFpjtKfm6/AjWA6rWBfZV3zDmiW/n2e6RJJBuJ3iqJ9UojO7C2GYkL5?=
 =?us-ascii?Q?X3qS6c/AzgRYAszVuUf8U1zD4uZDLulJOFTMemyZrXxbvdusr68jctgx1A2z?=
 =?us-ascii?Q?c0d9E2dJS49uMYf4ArIO8g3hVVU2PN3Smkq6DQm0tPzcC9TWROs8D/4JVonl?=
 =?us-ascii?Q?fys6jX0zW5l4qSotXaCYYqpJ6mletdFYXM7n3UzXOnPaUVTIN64HEdLQban4?=
 =?us-ascii?Q?R1HOhiRnw/dKCVSsxsNuZU3Ks5+iJSS6dziFUneDdESAT/D/EJ2gDPptkCq6?=
 =?us-ascii?Q?mNWfrEvgyFxrJnEwwoACka3/g02L1O8Ns0YpCAgIlt6rO3epsaY5R+xA5jN8?=
 =?us-ascii?Q?WBBFw5jCt62nqIlqiw2rysTf6DdHzsmTnXSc22sr4YAzVL8pGWTVRNBKbsjQ?=
 =?us-ascii?Q?/gl8u24PqkqGjIcKkyGldQ8XOFCXWO9XdEoX1knSVoBA5Qg8HA6oybx4kCPR?=
 =?us-ascii?Q?kTk+s3pYDXs13aZrgMrUaUhd9wqdypeUrkbwxr8yrN60DivBHN5IorHzq3m7?=
 =?us-ascii?Q?Nw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef136bf-c50f-4f33-cccd-08dda7506d4f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 12:23:23.1426 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jPDnirls59AdUP0DNfxLnSG4BmCskdhTKZG6NLaBCcxd31WiQVTKuFxpLUvczjEfcI3+ueCK8AnLgNWSnQ9I1Ch1nxFkogBQMtdcm+zH+LI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6497
X-OriginatorOrg: intel.com
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

On Mon, Jun 09, 2025 at 11:59:15AM +0000, Varghese, Vipin wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> > -----Original Message-----
> > From: Bruce Richardson <bruce.richardson@intel.com>
> > Sent: Monday, June 9, 2025 1:28 PM
> > To: Varghese, Vipin <Vipin.Varghese@amd.com>
> > Cc: dev@dpdk.org; Song, Keesang <Keesang.Song@amd.com>
> > Subject: Re: [PATCH v4] build: reduce use of AVX compiler flags
> >
> > Caution: This message originated from an External Source. Use proper caution
> > when opening attachments, clicking links, or responding.
> >
> >
> > On Mon, Jun 09, 2025 at 06:02:02AM +0000, Varghese, Vipin wrote:
> > > [Public]
> > >
> > > Snipped
> > >
> > > >
> > > >
> > > > When doing a build for a target that already has the instruction
> > > > sets for
> > > > AVX2/AVX512 enabled, skip emitting the AVX compiler flags, or the
> > > > skylake-avx512 '-march' flags, as they are unnecessary. Instead,
> > > > when the default flags produce the desired output, just use them
> > > > unmodified, and don't bother adding in extra enabling flags for AVX2 or AVX-512.
> > > >
> > > > Depends-on: series-35006 ("doc/linux_gsg: update recommended
> > > > compiler
> > > > versions")
> > > >
> > > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > > > ---
> > > >
> > > > V4: Fix error flagged by CI with clang builds without AVX512 - change
> > > >     "cc_avx512_args" to correct "cc_avx512_flags"
> > > >
> > > > V3: put in version check to work around an issues with some meson
> > > >     versions, (hopefully) allowing builds to pass in all CIs. The
> > > >     printout of the extra flags now only happens with meson >=
> > > > 0.60.2
> > > >
> > > > V2: dropped the doc update for the minimum compiler version.  Based on
> > > >     discussion, that version bump is larger than proposed in RFC and is
> > > >     now a separate patch/series [series 35006 referenced above]
> > > >
> > > > ---
> > > >  config/x86/meson.build | 31 ++++++++++++++++++++-----------
> > > >  drivers/meson.build    |  9 +--------
> > > >  lib/meson.build        |  9 +--------
> > > >  3 files changed, 22 insertions(+), 27 deletions(-)
> > > >
> > > > diff --git a/config/x86/meson.build b/config/x86/meson.build index
> > > > c3564b0011..e6612dbd80 100644
> > > > --- a/config/x86/meson.build
> > > > +++ b/config/x86/meson.build
> > > > @@ -4,11 +4,13 @@
> > > >  if is_ms_compiler
> > > >      cc_avx2_flags = ['/arch:AVX2']
> > > >  else
> > > > -    cc_avx2_flags = ['-mavx2']
> > > > +    cc_avx2_flags = []
> > > > +    if cc.get_define('__AVX2__', args: machine_args) == ''
> > > > +        cc_avx2_flags = ['-mavx2']
> > > > +    endif
> > > >  endif
> > > >
> > > >  cc_has_avx512 = false
> > > > -target_has_avx512 = false
> > > >
> > > >  dpdk_conf.set('RTE_ARCH_X86', 1)
> > > >  if dpdk_conf.get('RTE_ARCH_64')
> > > > @@ -65,26 +67,33 @@ if is_linux or cc.get_id() == 'gcc'
> > > >      endif
> > > >  endif
> > > >
> > > > -cc_avx512_flags = ['-mavx512f', '-mavx512vl', '-mavx512dq',
> > > > '-mavx512bw', '- mavx512cd'] -if (binutils_ok and
> > > > cc.has_multi_arguments(cc_avx512_flags)
> > > > +avx512_march_flag = '-march=skylake-avx512'
> > > > +cc_avx512_flags = []
> > > > +if (binutils_ok and cc.has_argument(avx512_march_flag)
> > > >          and '-mno-avx512f' not in get_option('c_args'))
> > > >      # check if compiler is working with _mm512_extracti64x4_epi64
> > > >      # Ref: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82887
> > > >      code = '''#include <immintrin.h>
> > > >      void test(__m512i zmm){
> > > >          __m256i ymm = _mm512_extracti64x4_epi64(zmm, 0);}'''
> > > > -    result = cc.compiles(code, args : cc_avx512_flags, name : 'AVX512
> > checking')
> > > > +    result = cc.compiles(code, args : [avx512_march_flag], name :
> > > > + 'AVX512 checking')
> > > >      if result == false
> > > >          machine_args += '-mno-avx512f'
> > > >          warning('Broken _mm512_extracti64x4_epi64, disabling AVX512 support')
> > > >      else
> > > >          cc_has_avx512 = true
> > > > -        target_has_avx512 = (
> > > > -                cc.get_define('__AVX512F__', args: machine_args) != '' and
> > > > -                cc.get_define('__AVX512BW__', args: machine_args) != '' and
> > > > -                cc.get_define('__AVX512DQ__', args: machine_args) != '' and
> > > > -                cc.get_define('__AVX512VL__', args: machine_args) != ''
> > > > -            )
> > > > +        if cc.get_define('__AVX512F__', args: machine_args) == ''
> > > > +            cc_avx512_flags = [avx512_march_flag]
> > >
> > > Hi Bruce, we have reviewed this internally and tested the same. We would like
> > your thought for the following.
> > >
> > > - Before patch: we were directly setting AVX512 falgs for F, BW, DQ,
> > > VL
> > > - new patch: we are setting the flags for `skylake-server` as bare minimal.
> > > - AMD supports AVX512 from `znver4 and higher`.
> > >
> > > As per GCC `https://gcc.gnu.org/onlinedocs/gcc/x86-Options.html`, the extra ISA
> > supported between skylake-server (super set) and znver4 and znver5 are `SAHF,
> > FXSR, XSAVE, RDRND, LZCNT, HLE, PREFETCHW, SGX`.
> > > Currently for DPDK microbenchmarks and examples runs safe as it is not using
> > the `SAHF, FXSR, XSAVE, RDRND, LZCNT, HLE, PREFETCHW, SGX`
> > instructions.
> > >
> > > Question: should we check if target is `AMD EPYC` then apply bare minimum as
> > `-march=znver4`, thus avoid possible unsupported instruction generation when non
> > `c_args for march` is passed?
> > >
> >
> > Can you clarify why you mean by the "target" here? Is there a specific value you
> > are thinking of for the "cpu_instruction_set" option?
> 
> `Target` is target CPU, when generated without any arguments we get code for `native build`.
> 
> On AMD target cpu zen4 or zen5; Before patch as per the code ` AVX512 flags for F, BW, DQ` are used in ` cc_avx512_flags`.
> 
> With the patch, the cc_avx512_flags is set to `-march=skylake-avx512` (where compiler optimizations `can add HLE, PREFETCHW, SGX`).
> 

With this patch for zen4 or zen5 the AVX512 code paths should be compiled
with no additional flags, since the -march=zen* flag should include
everything necessary. Can you confirm that you see the extra -march flag in
those cases?

/Bruce

