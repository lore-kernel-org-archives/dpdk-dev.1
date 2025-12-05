Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3AFD2F7D4
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 10:17:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C0DC54027D;
	Fri,  5 Dec 2025 11:17:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id ADEEE40156
 for <dev@dpdk.org>; Fri,  5 Dec 2025 11:17:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764929860; x=1796465860;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=LkJT2eRme5Ol0HQmDDQoR1iKVoFmT6Dn7gZrWaU9Y8A=;
 b=cMQXR8KbuMmAgN5HkycH7CGdtatVHh4ntC6jdVDrd2xcuVSgvsRN07kr
 59IJcSWD1uR/Hn1tXIezrIRAEVpgLSuBfyk3aV7m0tLJAVTau7OlvMYv5
 E+5shDGENhyvfLEglwQv3ee6eMwCtlNbwxw7KpgTpKgeq8jER0JjDjlxX
 FOkQbwvfbK7KO3TO1WqcZ9PbgCDudQlqFB0AV8Q+jkBppcUd9OTFlCPeU
 VvxVH4nN5diAPuQARgEA4eFfWrh8m8TgCDWrG5QQUV1rRnH9QGDZ6sWsd
 eaIIBsLj9FVjJ+OjWQf2WJw+sVAvqUy1s5pNrJaF15+05cK3MXW2qu4Dm Q==;
X-CSE-ConnectionGUID: SysGi2lrTOiQZLmJ+D5iOg==
X-CSE-MsgGUID: 8z/HhGFlQhGa6f2tUSiw9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="78073541"
X-IronPort-AV: E=Sophos;i="6.20,251,1758610800"; d="scan'208";a="78073541"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2025 02:17:39 -0800
X-CSE-ConnectionGUID: Awy2VsqgR2SYMFpM0cmOtg==
X-CSE-MsgGUID: f/CKUwE6SUyopSyOctGUCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,251,1758610800"; d="scan'208";a="200214078"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2025 02:17:39 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 02:17:39 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 5 Dec 2025 02:17:39 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.54) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 02:17:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cN/TcI6aK7I9g1yKRGulQd5o6LfrLibCEykJoKUv2umB0xCiUynGe9cgNHY2vRlNMxtzm2/qBpx8+mNihNqi+umm1l5vfnvE3t32hSPeviHD920U6ScYdAomId+CW5fHODywQPUFqWnAYFuu8FqdYTW5EkGb0W+715daJpsomU0T7QHDgc55GuIIrSjQX79Oqb2qcO3Rpq/069YAycIuJpu4+CujSvPIP627WuEZWNjoctttCh6XgWGA/MEx2sYK0z8vAoWVxcC9kViUlDhGUii2kasrm54uoDJKBj/EC6k1BTY8ORMNVab3+0fg+Wkc1f1WY22cJP701f2PHirESQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7AsfGUnydm/9uMefh5XFjmN1Plj0JHK/UQyL5MFn1hQ=;
 b=gHid2Lwd5jY0RUVpsgGPdjep4iqBcaRBHEhrRCj429rsyjoBRVixepUZ5ldHUq58CgVyBlF8vygdmF/kC3ZU0KBuin2iK9LxBkS3IQUdveLIgAUuTE7BGO+tdmjwVggkPYUXPK3hlphh2RVOMF3iy9HlLgY3OMOxOXutCJ9Z1fa4PgrHzUIbU2fyrOujsY7doK9lEQZ0fUvd9vhr8MnIWYHaaaEjRs0h0wISBrOB1k1/0UEfrW/iheyi/zZz+aA1jDRrZobCFJmXVkBymzqc8TbpBRzf8bpnW+8QK4eHzHZKXswyInqNlC3vlMUVi3xEsLneuPseZnxWoafbC5BPyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB8237.namprd11.prod.outlook.com (2603:10b6:610:154::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 10:17:36 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 10:17:36 +0000
Date: Fri, 5 Dec 2025 10:17:32 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Marat Khalili <marat.khalili@huawei.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH v2 01/10] app/test: make parameters clearer when adding
 fast tests
Message-ID: <aTKxPLHEREaH5Gqk@bricha3-mobl1.ger.corp.intel.com>
References: <20251202154948.1757169-1-bruce.richardson@intel.com>
 <20251204182047.3154429-1-bruce.richardson@intel.com>
 <20251204182047.3154429-2-bruce.richardson@intel.com>
 <5b0438bc0a494ca5972718b7f9e1ce22@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5b0438bc0a494ca5972718b7f9e1ce22@huawei.com>
X-ClientProxiedBy: DU6P191CA0016.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::10) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB8237:EE_
X-MS-Office365-Filtering-Correlation-Id: 00d61eb4-d6c7-4bd6-a9dc-08de33e78308
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FLZ+UZWVsaF6oyOliiJIZ8jGvcUUw004pd03z+VKRSNSqYeNUf/b5UNcYh5o?=
 =?us-ascii?Q?QVpN95k2TY+cwbOgaFZ27s7oEQ7MSQvrzOM9Cl2MXjzStU589KXZWQSdbrfg?=
 =?us-ascii?Q?cUjlSqiXjCMNEbgLenWcHSebB0G8s+WlFEkGnbCpy2wvEpSIeCp0+aK72G6w?=
 =?us-ascii?Q?ZbG9kKRHeU9XZ8tq3mGoCzj5D7gV7DZoWz9HU/bCzuHBKEBl0VWL6hTEGs4b?=
 =?us-ascii?Q?pwuzN2h6xvTy78kiFwDxeCyqnfE7CagdDhvGBvAfe4WYaje64Z8QWzCmmFor?=
 =?us-ascii?Q?9p6it6nVh/p0PMkU5gOMarZBJdZFNaaAfnZ81f1wphNx/YMt/gplaViHgrHm?=
 =?us-ascii?Q?0iN7XteD3JMUprVnOnyhtWMpxCSZQlXC5VgmprUswLfpMwYPIzQghF5DGrPw?=
 =?us-ascii?Q?7B/vcQGiNXXCcIJW6k2F+r3yu4lH7p3F6B26oiaEFj5z5WkEyIOlIMbDwriW?=
 =?us-ascii?Q?epWpvmxyH0JuVtZn33FEHulSeG4o9hJXcyYxgiRLGal30cqlAWQcm62iAi2X?=
 =?us-ascii?Q?vfkXKe+mzyzgUbqRMmVZJIcez5jifG/bncv7dTzbYdUL/QBkgH0cos6WQeUc?=
 =?us-ascii?Q?ksoEY+bGP014uck1cu2xk+SMZ/Q7q9gTljUNHw1eKygb+P5wUhpobpki/B8C?=
 =?us-ascii?Q?FXiHx3ciy2gtSXTUgQUelMnBdmGGI4fP1muXmTTIg+hGepZd0ck1dhJKBQc7?=
 =?us-ascii?Q?FSIKL4nj7G0yMChhAlK10usGo3ZF0m5dD2ZKIYIpyabHDNArVZ4qyON5xGih?=
 =?us-ascii?Q?md2JRu94qgDzguv5SaIBW0FrSpZ0p4B3zpzNtik9BlEZ2UP0AM9PLHnXHatK?=
 =?us-ascii?Q?H+mwdgsIQpCQO8qjG2nvqHOSJH2SqxYriUyCIarUdF20B5VJpTNNUgL9uOqf?=
 =?us-ascii?Q?nxTz1dWDoIu3HqLH2Karqgv0qVttt7M6bfSJHS33RxXehY/LbiCfpzsimVJI?=
 =?us-ascii?Q?fRJzDEAnW1eeG+1HL38N6Dp0XMzD7atw1d7Lhw/RXjvxXlfjsRJEtb0YsK6u?=
 =?us-ascii?Q?iQi1DCfzM71msPYmRdoTUmqioXxdL3iob1O+0EkPxv9ovCtiMt188BTY6v6k?=
 =?us-ascii?Q?KGSS98EoxC77xrf7vN6vpqbq4d1qmlmWsDIp07mzUmajCc1r0B1iSOBqbV1M?=
 =?us-ascii?Q?+OGzrtDdzcuKESRFrlSWE0HGb5j5o8QSQ/fwHZvFFxdKsAueDcngkFQrbmRz?=
 =?us-ascii?Q?aJNGtTmxf6q3t8aBYz854RlOWJgL7J0nvGC/NqUD43wmN57hhNZM8ugjLURg?=
 =?us-ascii?Q?0OL/JeHFv5qWQVST1mN5VKAlDJxTX2uDE6rHHLl4pRZS4rSfxjykjaYt8FN4?=
 =?us-ascii?Q?9RDGunRcNM6NY0p/44UscL+dX1wToMGa8x5beqlmhGIrEO/gUxVN9BZtfjub?=
 =?us-ascii?Q?yH9wVujj5qQTApUjH6UQ9N+6dzwnt3/Q96cnNLrTPtJo/xuyjpPDqut7NHOe?=
 =?us-ascii?Q?DW2ZkpCozib6wGiAGeshrr8VRiMtwTQ8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v+VcFg2MehaQn7bSFMVM3lNmtzY4dk4l7F6aLyubRON5G4BGFuZDPGrKCVHO?=
 =?us-ascii?Q?5DT5zS+JoIrhJHuWCzA8lqrk8PEFyqu889yr40aot4oZd60ma/y0P7cId/uW?=
 =?us-ascii?Q?1Yhcz1HJQOIhISQVHfnKm2ILpAB7z5Foyu1J3UUPvMRvfp7GkU1og7gW8mnJ?=
 =?us-ascii?Q?X+lfN1F1IXspCrNPfOX6ITjGu/LCBFnYFt6ygi1R9IsEcyL/0JWGjrtQ8f40?=
 =?us-ascii?Q?yXE74oslAWZQhdEmSnuGOgMStUYDLOk05rDshP/O1HvOzHXjdEvs7gvmu659?=
 =?us-ascii?Q?0jXmv8TMyaUZZTbSUOdA2yxzFPAaoLi+c+F1IS4vsAPw6AYPnOB2ObJ8Sf33?=
 =?us-ascii?Q?EaMaktlKxJO89OcS4UxBi6RcR6z3+g7duM+rDpK8sodAklNvQBO9UyurrJGU?=
 =?us-ascii?Q?h8SQWjGMbOjzUSmn9Z64MfYtHejn/ZDfg7WvilXOnAnsvs9dscXSFRhrB2HR?=
 =?us-ascii?Q?fWX4QLfV7Zwf62K2gJwLV29JOiyggXX8ba9usSDZiC5PhTAiau1S47A5CGo/?=
 =?us-ascii?Q?UqFfFXEUK6Us8wDFPSrqDJf89b510P38NzvCxXrNasg2NLh70utPwDRN1iC3?=
 =?us-ascii?Q?eVqk6MR+MSB1AIXTC40pL+Ni6F0JrOeAqRII0S+5ZFKM4SP2t7WjYfDcleJg?=
 =?us-ascii?Q?XosGziWkLE6NKvyRmQgM5d+2s9G9uuRaQ9RcT1rSSHm0dyiy+F6NHomzUOmx?=
 =?us-ascii?Q?58hwwZAV+C7dPoB0mQTYbWLIUXyO2ALZbjG6KxBVVGfHxwKhR0a6RStimFjh?=
 =?us-ascii?Q?Aq0svgKkm0bVjwegP0S+UQPgPxl59fgfsv8ZHLCuCEerRHyrsM6T/wmdxJRM?=
 =?us-ascii?Q?BcTLGcK7TRDCmmPZAPd7Yz9wIhuIPegzpPZMZp72D/AMcjGHzYD2pSZE7CO2?=
 =?us-ascii?Q?dLpJBgrkrU5984xaz0pRr8u3fp4XjFQ/kzNQpASH6JpQdu2/yv4vnmKLLCco?=
 =?us-ascii?Q?/VQnVLF24bCh+Cgkd5MzqfUrf1Xur1SgQxjtqC1tx1ikPdKsLpBJ4Eh6cOxp?=
 =?us-ascii?Q?5jdGffs+JotH8kOg9z+LchjI6FaQV1cEhKRVLKqJQTx0tHYC7kTglo1k6GbA?=
 =?us-ascii?Q?PZyfKpH90lS0pbLW5XvDPvGJ+7c+43RMFYqH0Zqr2DL6+PTq/gna3qZqUtZs?=
 =?us-ascii?Q?g1M0rhNLO+NhHR5UEUxbe2VKI4Hl8xUDF3RYIkOnjsjJjN3et2OEKRrtOHhx?=
 =?us-ascii?Q?bLw0FX2rrfeYjvJ5CFJZzavIfXfupI0LSzw/tWSBtbiDGL+Nond3jXDadokt?=
 =?us-ascii?Q?1ouDYAhKSZZ4tgRFRI/gMDe2zJjJq2N0eL9VePtApMOKLWje47kMK1vC2OBl?=
 =?us-ascii?Q?DLAcBXE5hdUSgMJrlxT+/GAMoaLQugy5ODkC1tAtxEEIaVh3w5jid8wRyfpm?=
 =?us-ascii?Q?MrCvVrAYDKoe29pC19xMB2XM3JqX0b808mgsSePhxjVitbRm/kq3anEHLqhm?=
 =?us-ascii?Q?Cp7nu4WOXWuwLzVdCC+w3Cpja86yhLpdt9pZ3zKUQe7HYlzdMNOR9ZRmpUiH?=
 =?us-ascii?Q?8iEhdfzIJz/Cwh6cuZU7odZUzDPmYb2rUVWDA6czDseYYwKw34KsWziZ4Y67?=
 =?us-ascii?Q?Px19CHWLN/JB/HcyneyNwzhD8jlKvKlWguuMpPtw/VaEWcJ6rV7Vis14Y4zh?=
 =?us-ascii?Q?/g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d61eb4-d6c7-4bd6-a9dc-08de33e78308
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 10:17:36.4104 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6IR1U7IVNs8P7Py3EFvvT174q+axAQDnBCu2z0p14kiwK5EKPCOevIc4sUYlBNO4L/gs1xY8nJy73f67TAl2ViS5Vz2lCakTifljQ4Tt4ic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8237
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

On Fri, Dec 05, 2025 at 10:10:34AM +0000, Marat Khalili wrote:
> Apart from one cosmetic issue in a comment,
> 
> Acked-by: Marat Khalili <marat.khalili@huawei.com>
> 
> > diff --git a/app/test/suites/meson.build b/app/test/suites/meson.build
> > index 712dd65568..65995078b7 100644
> > --- a/app/test/suites/meson.build
> > +++ b/app/test/suites/meson.build
> > @@ -67,9 +67,19 @@ foreach suite:test_suites
> >          # special fast-test handling here
> >          foreach t: suite_tests
> >              params = t.split(':')
> > +            # check for valid options for asan and nohuge. Note, the extraction script runs tolower()
> 
> > diff --git a/buildtools/get-test-suites.py b/buildtools/get-test-suites.py
> > index c3a99a862e..73f1d9c9e1 100644
> > --- a/buildtools/get-test-suites.py
> > +++ b/buildtools/get-test-suites.py
> > @@ -18,7 +18,7 @@ def get_fast_test_params(test_name, ln):
> >      "Extract the extra fast-test parameters from the line"
> >      (_, rest_of_line) = ln.split(test_name, 1)
> >      (_, nohuge, asan, _func) = rest_of_line.split(',', 3)
> > -    return f":{nohuge.strip().lower()}:{asan.strip().lower()}"
> > +    return f":{nohuge.strip()}:{asan.strip()}"
> 
> Is the Note above no longer relevant?
> 
Ooops, yes, good catch.

