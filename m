Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D76FC3600B
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Mar 2025 13:37:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4FDE1402DF;
	Wed, 26 Mar 2025 14:37:04 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id EF29E402DA;
 Wed, 26 Mar 2025 14:37:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742996223; x=1774532223;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=zXN4seZOfiRXdyeSEzcOSWDyf9oEkkzasOVo6MmE4aw=;
 b=YfU/ivJMvrMhHBOtnysMhx3WnPyYihja9WX2zWLuIg3Cv6ka3KnR7Rmu
 c0qe5jbDh5GKTXMPKd+wyKegJfXdbP+hTIi0zq5/g0sUheYxXtz+sb0wo
 glRPLJFEGvI/bwkxTt1KJaecp3m0dDRTRRZwMGca4Vx12ExBa6Q5MwxCp
 37s3byejjpDBMS9SI8PmpIq/oEotEm9MFs+/y6SEmR1Qgxg+y+Qy96WMW
 gf+nPYJ3Mvva7MWf2ELEY7qOAYFb6eOxLhGyL1SgHBNzNE1j6Q+TmywD8
 Rdu808GdTXRL+fzd04/n/i+50PhZVhpNq+NWrgWJTW0CcrQZpaWfQchI0 A==;
X-CSE-ConnectionGUID: tkpsu8a5SxS7in5nn/hiXg==
X-CSE-MsgGUID: MNyLYApMRrqPoaOjXxMU0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="54488105"
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; d="scan'208";a="54488105"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2025 06:37:02 -0700
X-CSE-ConnectionGUID: NxFLNtn5QYyu7Sdk92sCvA==
X-CSE-MsgGUID: 4y0aJRNQShS0sCmGw6QyUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; d="scan'208";a="129615528"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 26 Mar 2025 06:37:01 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 26 Mar 2025 06:37:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 26 Mar 2025 06:37:00 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Mar 2025 06:36:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o7cbFxW1d6uVVvDBcCi9n+2BoE1+On0SoNv/vKcbVSRbJa+DjYU5vkkBEFOZIFzoPCFzGCsvaSE5W6Q6u4wuLheGlFybtgCmdckdDBySY7QMnJSdQK+QfJPdgeqUHaI7a3796cxSohiAMsPnvEkmz3xbOOzSo1rFTqOew6YWRmMJq5hbvTRymbUdERSYnksJeLR6yIr7R5f6WdiuVNsVZUV8UCN7HkLOIbYulB02QN7aVlNvxXAtmHcv16+eoI5CderNu4//DPG/MkoiFr021Ja2Nz/gBF4N+9fIxqCujbRZ2l3RRHww/CNz+2HZtEOAcQaOZc48qmtlVk/PNJpNtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7KWVLGoeP3VjLxvIUIz+SJyv6C1p0UuVfhahuqDJy4=;
 b=VCgyCtV2e1Y20JoBS8aI9CdJ3CwRalcLbB2+EAH+I5V3SYZqoRy5RoXcwsVNqcPhmqFFI+/ihb6nr0ydc7Mt2CmNmEGfT08ZzcDEAFbLuGd0ScA+dKl42NEXtoZB28L+zsnP6Xq9vubgPMv5MRrjhDg/dd1kOR33JYT6at0CGWM63kOOg4h2ANic85jVAS8sYKkC1qCE0zedPyX1GSVMsqYvPG9OwSYXO6hR2jdGQNKd8ldKeueL2XVg4MVKT95VBtgYOcD9Q+yfUX8rJ+rAZWC0dhaiavpxv4UqkpYnDxj9lil58ywbdPP3ZH4hpBpA8ANCNMOH+ylqSRRILan6Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB8173.namprd11.prod.outlook.com (2603:10b6:208:44e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 13:36:39 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 13:36:39 +0000
Date: Wed, 26 Mar 2025 13:36:33 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <thomas@monjalon.net>, <dev@dpdk.org>, <andremue@linux.microsoft.com>,
 dpdk-techboard <techboard@dpdk.org>
Subject: Re: [RFC v4 0/8] Symbol versioning and export rework
Message-ID: <Z-QC4XwlHXSlFBHe@bricha3-mobl1.ger.corp.intel.com>
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250317154308.2782689-1-david.marchand@redhat.com>
 <CAJFAV8xiZB8r9=5D2tpc9Onrh+7582ZzM8cY_2VHojaQ7xe=BQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8xiZB8r9=5D2tpc9Onrh+7582ZzM8cY_2VHojaQ7xe=BQ@mail.gmail.com>
X-ClientProxiedBy: DUZPR01CA0103.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB8173:EE_
X-MS-Office365-Filtering-Correlation-Id: a1ab07ca-6218-46ae-59b1-08dd6c6b3c8b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U0VsZnErbC83WUdOWEUwaXV4TXpNWUdXS0o5dHBKb2MyUW9ZVVhjazFhNFBv?=
 =?utf-8?B?K1BHTDZkcSsraW1KMHQyYnhuVnN3NmZYU2d4THdkK1cvQ1ZCUngrUjlxeHdm?=
 =?utf-8?B?bUVZbU5hbHEyVDhBZGhVRHc5VHBCNFIrcnh4WDJzOFZ3b3hhRVozdjVGdWdl?=
 =?utf-8?B?Mng0b3QrYTY1bmpuQVVJdHVOU1Fua2FuM2xmQTVXdlM3L0tnZWxaZGNYQWhK?=
 =?utf-8?B?THdmTVZaN2gyTkJJRXV1bW9pZ2dTYk44WTh5K0tUUU5HYVlUNFJxVDZNcXJN?=
 =?utf-8?B?UEIrT3pZbEprbFEyK3dXbFMxRHdQSWxvTHRCM3BSNS84dFR6Vk1Gemh2L0F4?=
 =?utf-8?B?OEtSRDdmOFdKT2QrM1NMWlkzaEJvYlJVMXNrTmEwTU9IZ3drRXg4Z0JsR0pD?=
 =?utf-8?B?NHB5VEIzTWhJaGUzallsbk9PTmswU05hZXNvY3lJL1doRlkwWFlZdVV3cCtB?=
 =?utf-8?B?VmNuTTFQZTJiMTZ0VnNWaGJVRzRHNUZNTTVaTE93VGhoQkFzU3VGUjkybHFl?=
 =?utf-8?B?U1NmR0lNNDJ3dDA0Z3NDVEVYeGFQbjV4QjdKSGFpUkJYRGdBR1RBb3FGYVht?=
 =?utf-8?B?V2dBOVFtTi9STGhQd29EYjhXVE9KL2ZZSmZ3cDZDaEptTnR0bnA0Q2tVWEww?=
 =?utf-8?B?VG5PWXFDb1ZJNXJibnErZDR1bmlpT285MVF3QjdHS2JFZCs2UEZSVzF5UlFV?=
 =?utf-8?B?QWE5YTQzZGZHeEVicG1scE14dm1OS2s4SUhFa0Q2cWhTYmF5ci9MM1ZVZ1ZW?=
 =?utf-8?B?QzF6TEdRNFZIZlMzdU10NmdSWEZBUUJzL1ZNYkNQdng4aW5Hc0R2SDFDUkY5?=
 =?utf-8?B?RU5uRjUrZjd0SDh3WTMxNldka25XeU8vZHhHSjN1YWFpZTJIVDQvQXFINzlM?=
 =?utf-8?B?ZnVTaklmL3EwOERlNlg2NWRBS3FVazdPa1ZBRHhVb09mR1VocDh2WXpocHdo?=
 =?utf-8?B?M1lHVWM0anFnZDQwYjJRTzJhKzBiaHpkN2FhQjNibjl3T2VhT040Z0J0V0pQ?=
 =?utf-8?B?dzJaSFNLK2dwY3NlNlZ2dXN5b3BSRGszZmVTb2M1UFZTYXFIcXNFRUNKejRm?=
 =?utf-8?B?eWZLVG9jQzNaM05EaWpib2hFc0RmQldwREQvNEg0ZE5mWTAvSUJJTDRnNXk5?=
 =?utf-8?B?SnFMUlczN1lpZDdTQmRKL01WeGxCZTRrTWw3WHNFaTVzK3ZJc3VzYy93VkZx?=
 =?utf-8?B?NExheWpKWk5tYld2QngrNm82TGg5R0tpSThia05qSkVTMFNJcnhRWlNSeGVn?=
 =?utf-8?B?RTUwUHl4SnExVVFLMU1KQ1FNejJiL2lhVXczOUUrUnQ1dGt6YmRZdUkwZnRF?=
 =?utf-8?B?dFhncXpuVmgyaTd5Sk53dnQvWjdIM3cvOTFTbCswQW81ejErdDFVSE5VMEZW?=
 =?utf-8?B?Y1E0b05FWE1md1VpbXNvSnhvbFZicGlCcjBNZnJVSnJVcy8yWW1oVEJNd3Fo?=
 =?utf-8?B?MUZXMVpwNXVqb2s3QVFBUTBnc015d0o5dEUxQ0R0NkVZTE0xeFhZYW5EQmRv?=
 =?utf-8?B?VkUxT24wNXVRM2dkT0RhSExKYVptTUt5cHR4d2puV1JRMzV4MGgzekdONnNw?=
 =?utf-8?B?bFR0ZTk4YmtMVDQxZkwxczlLN2lvMGlYTHZ2Y3VTTDV3MnI1WGJnRDgvbVk4?=
 =?utf-8?B?dW9MVThtenRzWnp3d3V3Ly80UWcwd2tSdTlLVkxETHlIYjNBNW8zWk1mbVA0?=
 =?utf-8?B?aVhvcERtdEcwVGhkbk1iWkZmMWY3QVpXZGxZeGdtMnlxV2tRSmM2QnA0ckVG?=
 =?utf-8?B?clMyck8zaVpYTDJrdDZkVWM0Q1ZBUWdGalVaYU82bERad2RaK2Jkd1BtN1F5?=
 =?utf-8?B?Y2NuL0pDMlc1RkpteXVvM0pZa0FXNkFzVTMvb1J0b3AxeitFdnc4ZDRUbGtV?=
 =?utf-8?Q?J8u//KpFfTAat?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjBPVElCYmtSeVI1b1A0Tm1peDFiM1A2NEx4U2xKMmlicGZRZk9KdnVlN0pQ?=
 =?utf-8?B?WGU0VGhzUGFaS3VUTWlNL2R0aFhEcHByM2tUbklDaS9XOUx0RHp0cVlueWpl?=
 =?utf-8?B?ZHF0RVpEQWF4Y3BpTWtxRWxsNXVBem9MVDJIU2gwa1RrUkhEQzMxRE9hdml1?=
 =?utf-8?B?eE5aNWtqcVFZRFo1d1p0ZFErU1FpZ0pqbTZ6OXFMT1FQTVRPSEtOZkhVZVU1?=
 =?utf-8?B?VW0xWFdEaGJkYXRzNWUwVm1TRTQ1M1B0c3RTK2o0TmhreG01cldGWXVRdGZ3?=
 =?utf-8?B?bGkzTGVvY0R6SytxQTZRUWtkb3pibFJmOHhxQWF3UGJNSGNmQm45NytVYjhh?=
 =?utf-8?B?UmxNRnZnZ3BOaFl0TTJDRlEyZ1poN3FQU0tjUmFZM3ZsdFluN2RFZysrazV2?=
 =?utf-8?B?VlZPMStlVlpwckltUDl4YjlnYlJjU1FXdlVaTGwwaU05ZHJSRnJmYUJ4Y1kx?=
 =?utf-8?B?aGFzQ0FPdUVNbWsrdjdXRXZXbDRtbjlhRnM2aHl5ZXViZkpycXVSTUJ0NWpa?=
 =?utf-8?B?MmdxYzdUTnlUbWJyRzJxZjF4R3o5a3VFKzlITjdSc3phRVNwT2Q0TVFTVnlF?=
 =?utf-8?B?SytPYytFbldLdGtmR3FURVpuUGRsUU1HUjlJSnBDalMvQjFLU0w5UGYzY3NS?=
 =?utf-8?B?UW5LUmMxRUJTM29ZTCsyMWRhaGhsRkV6TjRhaXNhVzhVeHFRRmJZZnE0TTNP?=
 =?utf-8?B?bE1BK01uUzN2NE5sUkRKb0p6YnhTbysxaEJQMTd4bjFFYzNFMlJUUmpGSHJt?=
 =?utf-8?B?ZTV5ek04dnlOK2txQW5yd0l4a2FmT2ZKd21hVVZHR0hMcExVRThGaWdGTFU0?=
 =?utf-8?B?WnowN045NTlhN0EwZWF3TEI5cjFwMWhtcVdRYmhTbGd4Qk1QcXcrVFNUQkRk?=
 =?utf-8?B?dUlmN2xkMWhNZUxGZGtHVDJOUjA3TFhlRE5tUEZ2dzBTL3duem9aQ0YxSk9S?=
 =?utf-8?B?bjl0VkF2a1dSaFptMG9KQ0xFKzh2NTQ4ejgrMmlTK3ZKb2ttaUlUUTBqVU5F?=
 =?utf-8?B?aWVPMXRKTUd3WHVmSjBUVmg1MzQvOGZ3L204RTMyaWR6NnpCUDJ3YkZYU0c1?=
 =?utf-8?B?dDR2YnArUmRaWC9hcEY1bXd6bDh4ZnpwLzF0Q0JqbCtWaHBMTldEclFBN2xJ?=
 =?utf-8?B?bkJyN1EyY0dTVExneUJmenk2L3h3WnJJcUhydlZCMXA3cGFqYjVaVXZrbGda?=
 =?utf-8?B?a3F5SXJxM00vUENOenFzK2t3NStucVptb05mS3BFeGhZUmJ1bVhtU0JMUzFO?=
 =?utf-8?B?QkluNkJjbnVFdHAxdHJDMnIvSm9ZNFBpVzFtejBxY3VZR0cvWkI5MmVIcUh1?=
 =?utf-8?B?eXJ3VzFlSGVPbWg1cm02cndDTTQzZE5uZ2RKSzhzbUUwaW5ZZHhaYWpoTXNo?=
 =?utf-8?B?MFZLZ3JBUmdDVnNoQjBpK2d3MVhpeHhCK1dpekhBM0tNa2d1TXQvSStFZUxO?=
 =?utf-8?B?MHg4dnZTNWJkR3hPbzZIN0FzYnN1dGRhWTVrT2ZwaWlGRElqK2ZVam9KZ1NW?=
 =?utf-8?B?bFNDUU5QMWZ4QWpBNURlQk4rTnZOWTJpQmhNNTlIeVZ0ODMwMCsrTzFzVmtp?=
 =?utf-8?B?TGpMQjZ4cnpKWXhyTmI2dlpJRnFjV2h5OStHMGUzanlUL3RGYVNMTnpDVndy?=
 =?utf-8?B?NHVqbWl1LzgvRzBpSmltMWt5Q3ZHMi8xS2ZpSnh5a3k4V3lncitmdFBmb1N4?=
 =?utf-8?B?WTlRK2gxNFRXZG01dDhRWkxmMzNqaGpKSktlN3p2clE1R21ndDRjdVk3cDFF?=
 =?utf-8?B?MUhCdzd2OXlxaWZxeVlyZXl0WXY5SGlyaGd1NUl1R0tQUmVCay9SSFJ1RUVY?=
 =?utf-8?B?RGh0dTBsR05tbWRYZ2p6SHJ3aHFjbXduZnpUSVVtcjdnYlV2RTRkdmFhVW5l?=
 =?utf-8?B?NUt2NTFOT1NrM041bDc3MDhuR3FKQThFTFRRdHhhYWxBYkVRNUhyVnB3R2dL?=
 =?utf-8?B?b2d0V21YbkRDZWx4bUpIdFlCSE1sL252ZXB2ZWdJc1pFWGpYVUh6cktsSTEr?=
 =?utf-8?B?MWZDa3FwM1Fsa2c3eVpIekpNeTUwQm5sdVVuRitOT08yOG9ibEpHZjJ5NTRV?=
 =?utf-8?B?RU1GaTFiRnAwSndZcFFRV25UYk1GYkF3VnU2c1NiR3ZKMzA3Y2sxdjhZZkJm?=
 =?utf-8?B?U2dKcXhrMWJmVUdNN0JIaU9wRTVwemRXVFE5dnV1ZkxjR2dtRTg2V0hHNXlx?=
 =?utf-8?B?N0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ab07ca-6218-46ae-59b1-08dd6c6b3c8b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 13:36:39.2251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fTdy4TMEpYE1zCJWiAfORhizmJeWSKT3aD9kxnEzuG6YLhyyv79QJ2FGTpEmECl2zBTAACn8F63oIJP7EQoTAkwhWGp249Al7mXSPXiLxZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8173
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

On Wed, Mar 26, 2025 at 01:02:32PM +0100, David Marchand wrote:
> On Mon, Mar 17, 2025 at 4:43 PM David Marchand
> <david.marchand@redhat.com> wrote:
> >
> > So far, each DPDK library (or driver) exposing symbols in an ABI had to
> > maintain a version.map and use some macros for symbol versioning,
> > specially crafted with the GNU linker in mind.
> >
> > This series proposes to rework the whole principle, and instead rely on
> > marking the symbol exports in the source code itself, then let it to the
> > build framework to produce a version script adapted to the linker in use
> > (think GNU linker vs MSVC linker).
> >
> > This greatly simplifies versioning symbols: a developer does not need to
> > know anything about version.map, or that a versioned symbol must be
> > renamed with _v26, annotated with __vsym, exported in a header etc...
> >
> > Checking symbol maps becomes unnecessary since generated by the build
> > framework.
> >
> > Updating to a new ABI is just a matter of bumping the value in
> > ABI_VERSION.
> >
> >
> > Comments please.
> 
> - I am considering making rte_function_versioning.h a non exported
> header (precisely, moving it to buildtools/ and maybe renaming it).
> 
> This header contains macros not prefixed with RTE_.
> Using it requires some build trick (see use_function_versioning).
> And I don't see symbol versioning as a MUST infrastructure that DPDK
> needs to provide to datapath applications.
> 
> Yet technically, this change would be an API breakage if some
> applications indeed relied on it.
> 

Is it not needed for exporting if an exported library header had versioned
symbols is in?

/Bruce
