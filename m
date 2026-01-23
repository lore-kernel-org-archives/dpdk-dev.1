Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2155D7235E
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 09:02:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 38250402C0;
	Fri, 23 Jan 2026 10:02:50 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id CCDAE40269;
 Fri, 23 Jan 2026 10:02:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769158969; x=1800694969;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=uAOOv95ojSAG5jV8OfaSg/pxDCKbpwCzskozm/LVcAc=;
 b=FuVlEfMybim+zG5AevrCu7/4Qq0g/TXCvW4VkvTbnWLrVOivenyHPjL6
 /oBh30SwFhbIIFYggd2y9e/uRNiECcJBmpDqenVnIgSv4v4n4Nbh1lq6P
 tI2OpmcnVpNU7LTzFp2ZA+e0kuQXmVYXXsqcWrSztYS4b+D42hgTvWO20
 27W6uNsTxoIHalY1enNJEaBtBsBwG02F7DtcPHJM2rMGbYBSXsnxCVSXx
 cZvad/3/bJXEPWqiyzKfH0T3uzgQ5l6ORDW/aTOkS+s4P7FiPoth0sx+y
 pyD61Y1IfDkrvBJPJAZLCdfc/OlPI3XSWw8bgy4R1enc86qOlSgSQbeK4 A==;
X-CSE-ConnectionGUID: AjMLxkRgTs+b7ACUlCxG0Q==
X-CSE-MsgGUID: Mu+UhQReTLW7kov+gih9xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="81041451"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; d="scan'208";a="81041451"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2026 01:02:47 -0800
X-CSE-ConnectionGUID: k6GegWD1SnCBNTXqJz2Ckg==
X-CSE-MsgGUID: zDt0IoXQRUqMa5GJ3Jo/gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; d="scan'208";a="211841333"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2026 01:02:47 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 23 Jan 2026 01:02:46 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 23 Jan 2026 01:02:46 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.34) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 23 Jan 2026 01:02:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nYrCp18mOGPkZUxABze1Zs8cc3vOhlF/mdgVC1Y+5FqVEfDsLkTXHRI23zQ9nZ3zJ2ahI+cnjBSd4RCCaOwpz0rDB3MU0mSZ6GxBXXbMFoTu6p7Buw86KFqk3KnbJ/LZ+IOjXB+2tlthB8wUc6gH7L4KCGODHhddA5dQ7rnT58iSJad2WKJpowhNP9+zSja1C/Si4iLkhY9NYWNJSa31llgng3GGrrohbsKX5UyN90DwUowgncSCf2CyCIU3Xz0c9D8e/fmWx27A5EGsFohSOvcVG+RqZ2tYFBm4Svd1ODooZnhHCVVMDPgYn6iZlelWMMgYWxTsoDN2EiMiuQLmNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TT6sgoEAjV/BvUF3RA0U4r6f9pbFiW+4lCVQsI3zbjE=;
 b=tJJjI+meyNNTK0owKRZ/lg+wKDnszoFgv7itVpRAjWWsPqZPQE2NtbeJDBiqyIlPRqnsU9BcZgemxcSLdOKG/yIB3uc7jLrRWq5acimgdg96cXcqkLZ8TIs+dWup6+3aeAyZK6i16QIhXrVPLFswltF2otSKFWzB03vAHd9LsUVfbwLu4rIdifg/9g5pCvA/6H66z/NcAo8xU51Zx/wzrkzLDGjFqdGXRR5ICN7PHGxbh4SwuMiASRVdJXMOqSsMcE3HU+kMpAukj1ntJze7NIoMaK7+YaCLHiUze9aMcC18Zdjk2iRBCqTmouAjW517JzyQMJyf+7W6sbDNHrVZlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CO1PR11MB4993.namprd11.prod.outlook.com (2603:10b6:303:6c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Fri, 23 Jan
 2026 09:02:43 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 09:02:43 +0000
Date: Fri, 23 Jan 2026 09:02:36 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Patrick Robb <probb@iol.unh.edu>
CC: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>, <ci@dpdk.org>, 
 Thomas Monjalon <thomas@monjalon.net>, Aaron Conole <aconole@redhat.com>, 
 Luca Boccassi <luca.boccassi@gmail.com>, Timothy Redaelli
 <tredaelli@redhat.com>
Subject: Re: [PATCH] build: bump meson version to remove warnings
Message-ID: <aXM5LAcV6EC6L9VS@bricha3-mobl1.ger.corp.intel.com>
References: <20251205121301.3443561-1-bruce.richardson@intel.com>
 <aTLP4TBHLtqm0kpR@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8yEy9Oz3u0ZqyA4RHQPUjmvEFSLH1cAnfMZccehd0+Z5w@mail.gmail.com>
 <CAJvnSUC3ze51WFHx=cRMGKezrwXvo7fCXH8o64qJsbWf9SXsZg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJvnSUC3ze51WFHx=cRMGKezrwXvo7fCXH8o64qJsbWf9SXsZg@mail.gmail.com>
X-ClientProxiedBy: LO6P123CA0026.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::17) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CO1PR11MB4993:EE_
X-MS-Office365-Filtering-Correlation-Id: e2b123cb-8cca-4537-510e-08de5a5e2b6f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZXZRZW01MXhSRkg5TlZFdjNCRmZORXV4U3dTV3JvcnJoQ29NcVR6RTJOVWZT?=
 =?utf-8?B?aTVQUnpDU1dDSUtVNkZ5aFpJR0Z3ZmtXb2ZadWFvbnJQY2hDVEpJdlRzVU1Y?=
 =?utf-8?B?Y21tTmRSekI1eXRIYUtYbHlTaUdxMi90VFo1U2kzMUpDKzJhdkQvcm5sNlJz?=
 =?utf-8?B?L1ZxYXFaK2ZkM3IxY3RrOGFUUm90QjFsV0pWd1c5QnBFcG1VVGxIaVdmanJ6?=
 =?utf-8?B?UUMyTXZEZzQ3R2VJZTFNSVZrTVI0Q1pUSjZmY1BtbmpVOUZQV2VUNzdTZC9o?=
 =?utf-8?B?QUdnbzBjSVRNd0hWQ0NKTlIzYndNSE1XaTYyQ2ZsMzQ2ZjdOdXEyQ3duQmwv?=
 =?utf-8?B?M0U0YmNkd2JhTkcxR3pmL1ZCbUhOMms3a1BTdm9sSW4zYkkrdHVQQ2U4eHdT?=
 =?utf-8?B?NGhWenU4WmNCWDBsQnM2cmtES2ZXN2F6M0pUTk94WXEyenFERnBpL2tPbXgx?=
 =?utf-8?B?eEdWN3YwMVVjUTRXaTdGeVRXVFVoMlNLK0JpRFJwQ1N1eC91TVFGWnhDaGpP?=
 =?utf-8?B?T1BUMlozU3QwRm56Q1VUL29GbWhieXh0TE5qSDRkdmFBTy8vbkxITzZrVTRs?=
 =?utf-8?B?YUZOVDFJdTV6WTI3N2g1TE5MZHlXSHZQMTI2L09IcnlxUG9mckZOTitSZDFR?=
 =?utf-8?B?b2VyOVhMQlpmbUcwUFlvS043eDVhMnhrVzRaU2s0ZGliUUgyck1LNUNUS213?=
 =?utf-8?B?UUVRUmpVcmlielE4eXZoSUpzMHRpT0h1WHRLU2ZNOXFOUEdRZ3laK25kNnVl?=
 =?utf-8?B?NHBpQkNTN1lqWnIvT0xyb1p2NzNkK0FZamcyQjRLbDk0SDFLczZtRWhHdCtn?=
 =?utf-8?B?VWJ6NXRkT2h5NWp2ZFA5ejhQbkxDdHM2M3V5VGdFTHB2RWFFSDYvcVZCTmlX?=
 =?utf-8?B?YTJqOFVzUW5WYS9kbERHNmtsVy96dFVaTXZrMU13U1V1Y2p4bUVJa3RBNGxM?=
 =?utf-8?B?bkc4THJsVjU4dGxmdEE2SDVyei9najFvdWJyU0pYMThMMkpZWmkzMFFpNE5R?=
 =?utf-8?B?VWxBYldiLzQ1OUFLMHpwZjlDNTBaODNqTUFZOVVZeGxnNXJKUUU3T0sxZWFR?=
 =?utf-8?B?ZVdVaFJReXhGNGJFNFZRTi9jYkNsUmVCNmU2ZkVxNWlEcHFEZnVVUzJCNE5S?=
 =?utf-8?B?ckoybjR5Z3dkT2Iya2NaMldQK2YwbU80bTBEYThVNnRJTE1LRHJBY2xoUEhq?=
 =?utf-8?B?RzRsQmlDZ3ZIR0sxWld4dThpMjRRd3JvTVp5aFJtbWtMYWhnWjFmM3hKYmo0?=
 =?utf-8?B?UlFEQzM2SzV0c0dTWnhxcy9KSG4wY0hVYkVaeDFKbXdxUE55bGFNT0Fyc2Ur?=
 =?utf-8?B?OWZ1Yk8raHdTVGtDV2NyUHF5alh5T0pSUit0UFhxcm5kUGtaa1NDZXRjd3JO?=
 =?utf-8?B?YWJ4VDdUbS9PakdzbS8rTjhuZUYwa213cmhLdk45a0pQNmhsRnN2N3U1NEM3?=
 =?utf-8?B?RWNiYUlsSEx2a2V5M21GbThQaEJML28reUVJV3VmeUNzK040OG9oOU9LUkFN?=
 =?utf-8?B?aWFWL3FPczMrS25xcG9PMkRMeHB0VlUvTSswUXhKbkRYYWplWlczUGU4U1hV?=
 =?utf-8?B?V04yMXZ6dGVtVFFmdzFWOTI1UFVlSWpwbGVJMzBzK285enpsWjFEUjU0a1BV?=
 =?utf-8?B?aUlqWGovZVJURjhyeUhKTjk0TkplUGVJS2o2cUtpQk9TMW85Y0VXSVlrZndl?=
 =?utf-8?B?VXFkd0hFS2hCMGxVcTVyWVkyVFU2QUtZSWpraEpKeXp4Q0ZERmp0aFNQZU5W?=
 =?utf-8?B?d1p5M2x6b0Y3UzBkbkJLUXhCYWw1dzQ4NlB1UmNSVmFEUm1CM1EvZDBiRmdy?=
 =?utf-8?B?UnNpTzNydit3SERTdDB2TVJyc041WnhoRGVMcTJjVDlwNUt3S2U5TjBBY2ZB?=
 =?utf-8?B?c2hkQzBYTXMxZGFkekp0MFkxbWNSVHlsTXhHM3VNNGlISFNEOFJvenBxMjV4?=
 =?utf-8?B?N0dsSnNBZFZIL25tZzlydnA4Rjh2R1R6OXhKN05zTlZrR1JVdUtUMUdQRjg1?=
 =?utf-8?B?NnpMblpDdjNlQUJyUkozWkdMckg4ajFOOUpDTVlOVUNJSWJIMHN1SW8zbWJY?=
 =?utf-8?B?cDg5eXVGTmgrYlh6YU41Q2NIdUtkdUVaT1M3WDJ4dXNIeVpwNmo5cUI0aEJQ?=
 =?utf-8?Q?AaUc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDFvSjY5eUZmSEhDdHE3cmZXSXZNaUhhSDVzMlNJK2RqeE5JN3NSLzcvdG52?=
 =?utf-8?B?cjQvNEgvcnk3V21MdUF2QUduS0twVWVUeUcyeW1WRzBDRnpZaFQ0NUFvTDVS?=
 =?utf-8?B?dVBlaTFEZE1haHl5bnluZ2ZISWRkRm9GZWxMVGZnSi9mdDRMUFhmM0RhM2Vs?=
 =?utf-8?B?VEgwMUdoeU81Tyt0Y1dzR2wwZ2ptTWRjZnJseWxCRllSc3ovNTZsbVNKVHFR?=
 =?utf-8?B?akVPVFJDK0lUMmNVNHNlZjQwa2RySmNOczVxQkNER0RDeGZsNEp1aFhtcjdh?=
 =?utf-8?B?bFZvWVIxVVJxalpXVitmb01ON1ViOVVNeldzc3Ntb0hiLzlUZFhVZC93Z1pi?=
 =?utf-8?B?TVVMV21CSjFwZVQ3WTR5Y1hRcmxtQmh1Sy9qYjdsaFlPaHhxYlRLSEZObmla?=
 =?utf-8?B?SzhiWDNJand5U2ZtbUppWHJseG5TWmQrdHVDb3FpaTVpSUUya0hEVWRTK3B2?=
 =?utf-8?B?bkdQZ1NFVTN1cjlLQ1dES09LL0ZRK0FOd3loNC9FdE1hSG84aUFUYmFiQm9l?=
 =?utf-8?B?N2NLSmNxUG40YytWQjJRa3FqUTE2bjI5T2tiQ0lwOWYrcjM3ek0vSjFESWR4?=
 =?utf-8?B?Z285alhKWExFS1FVcDRLVE4wNHUrUHdCNVBaSlBaSHdtTUtNME1PZ002TkVP?=
 =?utf-8?B?SGxmeGZSRm1mOVZpMWZDZ3JLYXd6d0tjbXFlQ1RGK3dzd1NVVTB0MzhCeFE3?=
 =?utf-8?B?T3B6SkI1VjRQdTB6YlB5NWkvcVFJZ3Q4OElPek4zZTZ5MjNSSUtrQnJxaG9D?=
 =?utf-8?B?V1FRTkdYSW1XM2k2RkI5bXhQbGtheXVEMHNmTVZMVWJDaXBTOTMzUkZBeVht?=
 =?utf-8?B?Nkt6dDFMS0UxR0NEZ29ZRmlpN1dHWGxGNUNBNXJvOGtlRTJITzZFRWZQVkNy?=
 =?utf-8?B?UWFyOTAxYTYxQ1REWlBMZEg0UW9lYVJJNks2eG9BVTVSQVJrNXFMcGloTE5p?=
 =?utf-8?B?MHlzM1JydzF4TDljVU5sWWNhWktXaDJWbGhWKzFCekVGbnIrQ1ZSeTRjcHdS?=
 =?utf-8?B?UUowNFN6bHVTc3FPYmh4dmRrZUowOC9IVFBQYmtrbE5ZcmhERDlETkRtVUxL?=
 =?utf-8?B?Mlc3L3o5MUY4eVVCTjVsVm9VKzJMb1FRNHIwaEZEb0RtZXFLdkVUMHdQVVpy?=
 =?utf-8?B?THZiZ08zNVpzeVdjV2dZUDYvelV2VW1XUmM0MU5MRlpFRTQreWpJNGhWb05z?=
 =?utf-8?B?WklLVzVpeFJkZXd5YXlsRXQzNVlUellwNEJqQUJBZFpiVi93NUI1MFV6V2ll?=
 =?utf-8?B?S1BSSkpxVko4YzdrRXcvSVMvL1BaQ2VvQnMzSGFHVzUvbkg5M2p3R3BMZzEx?=
 =?utf-8?B?bUJydm8zd1FzM2g1NEhueTVqVXV2WERKWEhsbmJ6Q1ZNRDFWSFpjR2gxRUk2?=
 =?utf-8?B?VEE3QTB6UEU5SW0yQVo2N2swWmxuS28vcy9PRTgwaXlWR2xZWDZTYlJvYUhh?=
 =?utf-8?B?cG1CdUVIeFJTTDdobENHVXR0VEQzS1N4SUZ4RHFjcDQ4c2ZTWGRyWkE2S0cv?=
 =?utf-8?B?UWNuVWhvUUdyVy8xMERJSFYvWTgwZzh1WVFUVlZrMjc2dmFwVlh4T2FDQUw2?=
 =?utf-8?B?UUVKemJSUDVKcVJORDkyQXdITUhWRVd5UjZKNXR3RkQvdmNGZnd3RWZqWEdM?=
 =?utf-8?B?TTNjaFFNdXpNSkE5YmxGNzJLc1diNUljd3Jud1ZBZE1WZVlkSHBoU21pWE8r?=
 =?utf-8?B?MWlGZlFKNkg1U0hJR2pEMXAvTk5ocVZiVldueWdyZ3ZTRlBrQkpGd1p0d1ZC?=
 =?utf-8?B?LzhYTi9IejlwOTFDam9YYVAra2xEaXVYY1JFWnBKVUhFcXRnK3lSQ2RNdHNM?=
 =?utf-8?B?dExyZXRTU0lnOXFlWlBCcnZ5enkrZi9RNXhWaXBuQk01Wk5nMEJJWkUyd0g5?=
 =?utf-8?B?ZWpFcVFmdHdkcVBxRWdpUXpNSXEwZGF6UUdjS25aU1ZDWktlWkVJaHdWdU9S?=
 =?utf-8?B?MEYyMUd3c2trb081MEh3Z1VNbForS0g3eHVXZjdUd3JLa0M0dHBpdzFqeHFJ?=
 =?utf-8?B?WWtTdk8zc1FEdXNiT3VBeHM2dXF2TTdGTzQ3eXREaFpiaGVWY1N3TVV2MCtK?=
 =?utf-8?B?M2JOREw3Y2ZTSXZrcW5VdFRIRzVqSWcvay91a0tQTk8zcno1RGlkWDJjU3Nv?=
 =?utf-8?B?KytXN1l2ZWpFZDBYMVMyZGF2K2NlWDRONEFkOExMMjR3VG93NnM0UHJ3UFFz?=
 =?utf-8?B?Y2ZVUitIM09URTI4OVZ1eE1IZFlRL1lLajlxYVpkWnJJOGRYeUlnRFV0OG1z?=
 =?utf-8?B?TUI5T3hwdWhSV1F1N2VuYzVOaDBRNHVqMkNFR0M1c082c3Z0RG1WTFhxcnRp?=
 =?utf-8?B?S0tJVFNPODM4dXo0NGx1Nm44SVFlS2xkQlZkTXRHM1NhUGRCUFZ0eCszK1BQ?=
 =?utf-8?Q?hOqOdLxgEHHNOZbM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b123cb-8cca-4537-510e-08de5a5e2b6f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 09:02:43.7231 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0mtuS2zmo2IIQl+T2u/0GIOpCkdIR7HG50fma6a5FbbSsxM15wiaUbw/Ml1PGK8a60oBd0v0kOUJjVjO1G1j7YvLpdBnOezVYNjnMyDLbto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4993
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

On Thu, Jan 22, 2026 at 01:59:19PM -0500, Patrick Robb wrote:
>    Thanks David for the CC. We need to rebuild all of our DPDK
>    container images for the distro build testing etc. which takes some
>    time. We should be ready early next week.
> 

Is rebuilding all container images something that needs to be done every
time we do a minimum meson version bump? If so, we probably need to look to
take steps to make things easier to do.

/Bruce

>    On Tue, Jan 20, 2026 at 3:32 AM David Marchand
>    <[1]david.marchand@redhat.com> wrote:
> 
>      Hello,
>      On Fri, 5 Dec 2025 at 13:28, Bruce Richardson
>      <[2]bruce.richardson@intel.com> wrote:
>      >
>      > On Fri, Dec 05, 2025 at 12:13:01PM +0000, Bruce Richardson wrote:
>      > > The build of DPDK now uses features from version 0.6 of meson,
>      which is
>      > > greater than the current minimum of 0.57.2. Although these
>      features are
>      > > non-critical, they do cause warnings to be emitted on build.
>      Increase
>      > > minimum meson version to 0.61 (== version in Ubuntu 22.04 LTS)
>      to remove
>      > > these warnings.
>      > >
>      > > Signed-off-by: Bruce Richardson <[3]bruce.richardson@intel.com>
>      > > ---
>      > >  meson.build | 2 +-
>      > >  1 file changed, 1 insertion(+), 1 deletion(-)
>      > >
>      > With this patch, and the previously submitted patchset for
>      assigning test
>      > cases to the various categories/suites, all warnings in the meson
>      > configuration stage should now be gone.
>      >
>      > In terms of the specific version, as noted above I chose the
>      version of
>      > meson present in Ubuntu 22.04 as a reasonable baseline. Both
>      debian stable,
>      > and debian old-stable have newer versions than that in them. For
>      the RHEL
>      > line, I'm not sure what the baseline is, but I believe that RHEL 8
>      shipped
>      > originally with a meson version even older than 0.57, so moving to
>      a later
>      > one I hope doesn't matter. [I wasn't easily able to find out from
>      Google
>      > what the current meson version in RHEL 8/9/10 is]
>      Cc: Timothy for .rpm distributions, Luca for .deb.
>      I prefer we get some acks from distributions people.
>      Also, this patch requires coordination with the CI guys (as can be
>      seen in patchwork, many envs are using old versions of meson).
>      --
>      David Marchand
> 
> References
> 
>    1. mailto:david.marchand@redhat.com
>    2. mailto:bruce.richardson@intel.com
>    3. mailto:bruce.richardson@intel.com
