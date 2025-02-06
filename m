Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FCDC02194
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 11:40:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47F1A402CE;
	Thu,  6 Feb 2025 12:40:17 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 6C37D4026C;
 Thu,  6 Feb 2025 12:40:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738842016; x=1770378016;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=6eiaSjsi3A/mCmpGEJVhHHwyqpDVHMKWW2DjLwBASD4=;
 b=Kc04FihmuGaqoPK38B1U+AfkoHvsgtVvXqLtujQ5plOnSknJnxKSbLIf
 ChOnRkhwULsMJhXfczx5XC2c1Vzgvnn94wBbcbKmo1NGHZjPvUhGUv5Cf
 i0KyvYypPbwyxyNoW2nVseG4TeIZqeuZxvmtzkimzZ+LOjPqCE5Z+zAFc
 B06Qr6hQYVs6hrCA9AVpVHx/GV423fQf1ZfcmHTZnBm4FZc4ITPJePeYG
 RH3QqoxX4qxxGxcfLQBPSpC/XPh/0UD6z/VxurmG9Xa4xIfkuqO83/puZ
 QZCGEzFTQ8Ts3v+IngOYjLcuCk1tAMNDw5ELPIDFVipgBmRFOuhkdexFh Q==;
X-CSE-ConnectionGUID: 9/eDXPeUQ6iYR4xyhuy0RA==
X-CSE-MsgGUID: FmfaCzUaSRWPVi+Srfd1dA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50427094"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="50427094"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2025 03:40:15 -0800
X-CSE-ConnectionGUID: 4V8799EiTICS/8e5LH4VVA==
X-CSE-MsgGUID: sx9QaAFRSgGK+tAYsjQ/hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111636180"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 06 Feb 2025 03:40:15 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 6 Feb 2025 03:40:13 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 6 Feb 2025 03:40:13 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Feb 2025 03:40:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MwC+M/hgK5WtWTrfv/IDK35HSL7gVkar1NQv3E1/I0rXZaW2VQXIidS89te/yydM52YMnFYdLov9WRD7FMZxa6UPNni7Qu3ph0vDwsOBF2+gKby0f4wp+eIM1Mm0AZt8fMlCjoN7Wo61RWlMcyG9lN1HaovVQEy4cSZG9FOjnntUGpczB5SXR+o2glTGLusDiUGYAJeLmucmNUtlrwhdI69eJPqoaO+YHivbyYraOtKjnyBgFFpfOMbqOqG8eEfXVMH0acfKaAJDEV0wmCubjE3fzXpi6Ae8Lf32KrBMiavrvaBrPel++9QKMhtFBIy2N2p5XcPgycNtPiwmyY+c7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f89zNL4z/qDBr6daLuQB+c74O80cGxj9Er1kpWBt598=;
 b=lGVpJrfZIhlXp3gv43zzRkjW8+lTKsUhYoBSL6s9SysQJYl+xcVZFEG313w/Eag98fkyH+FwIWKsD5oVwnOfkUtR6hNBhaKuifUsWhmXS0/2J+qWXfr87ePCvKRkXtJcZceFx3eGfRHitmeOVdAuXkyzSEROZXemy7ZoFNLYLh031viCOrtLec6Uw29EvDkd4e9LJYhAy8kssVa720W7bikIMFPu0CFeWlE3lvS1TzuvfIkMIMzNLeJ9V9QbVY7L19muq0AElIxKW0oKymHA6PAykK85tXEAUXSptljuxQRcxiUTMz+pfC5IkBmPyWai3TVkGxBnS3dPlQaeFXFiQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB6953.namprd11.prod.outlook.com (2603:10b6:510:204::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.29; Thu, 6 Feb
 2025 11:40:09 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8398.025; Thu, 6 Feb 2025
 11:40:09 +0000
Date: Thu, 6 Feb 2025 11:40:04 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: fengchengwen <fengchengwen@huawei.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH v3] test: improve resiliency of malloc autotest
Message-ID: <Z6SflKJyTbxMRD9g@bricha3-mobl1.ger.corp.intel.com>
References: <20250117125912.985475-1-bruce.richardson@intel.com>
 <20250117144112.2544963-1-bruce.richardson@intel.com>
 <0e91d822-ed10-4dae-8f0a-7169e7819517@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0e91d822-ed10-4dae-8f0a-7169e7819517@huawei.com>
X-ClientProxiedBy: DU2PR04CA0212.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::7) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: a07f18a7-2511-43b1-5845-08dd46a302b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ksXPAyvTROWhNMw4Vv7BiEPXkPQSXm8YYQQL4L/Px2uo5HjZMtUXdpIH4YJN?=
 =?us-ascii?Q?o/p5KJXhwEl4vRpKG4f0C6upVH7xYP7rL2VYuzF8Efw25UxGC7APjndvXWnQ?=
 =?us-ascii?Q?dv0NP46V7PcQSJ3feAJtUH8nLt26UaYDtCeo3eN+gCvzCmOxaLpy0/thAehO?=
 =?us-ascii?Q?CnslAtpVC/HHosz3XKvB4UjyF3O0UV8Lp5boPKE2Ons0zcivY7fJuZ4AvF4A?=
 =?us-ascii?Q?ZTh+oYUx6bPwf7s72TCfRzmux3rmtRxnRYAXC5CcwbYMh670hT0euRIs7IIc?=
 =?us-ascii?Q?d1dG16sV1kVMpRJxfKZ2AsXjKsazzGnBxGWHpyBTznnpORN+iMJu3Lyb+CFI?=
 =?us-ascii?Q?cno/y1bfiGSgbRPyooQopcZ5lEdpSACmTDr7nXCv/GS+lLSGWGqdQZH8kbal?=
 =?us-ascii?Q?xBC8FQiZiQCuXzc8IK67QTLNl4T9v5q5WQ5R7hM7hbv/kWE3y/FZ2BzGEznx?=
 =?us-ascii?Q?MPS/zZuv0ZJqoY3h2h4zpeCeRJEhpnBI8qZ3D4Sy9C3yuL2fJa3Fn2m0XB7C?=
 =?us-ascii?Q?We+4NLyCZ44FPZ5OAhvQwY8ymQpapNcFd9Ea8RQf//UqRt9dqXjcBjmPm5TC?=
 =?us-ascii?Q?Tf6jjwoxG9VuuBEsg7N1WylZgi6Em9b4TV4E3fmn0+CAxy40z5jLIaivoDle?=
 =?us-ascii?Q?65FEZxLqXxBPx3lovjHFrFasThaG6unHmUlesxgZMn81FV1tu9g1SfiawRb8?=
 =?us-ascii?Q?/dd7TN7QJZ0BFn3KS2Ik26SlSnx4o+kNVOpPeNX+HAV+3mB9dnmzthGPhYpj?=
 =?us-ascii?Q?Rs2rysQpjGr1qXSI8lQvIyixZ7JaubanBhe2Ng2k+q0mM48hJ7n0GC4nQdeb?=
 =?us-ascii?Q?fHdfv5Ty4jFwDPx6YVqDfha32lpHC+RtDzhYuJVJO2jMO7Hfb8lY+Opxvs5b?=
 =?us-ascii?Q?8E84XIDPgUOevjWvOpYGVrPTfqmJItUarrcs+MeI16IL90uQjlIWVVxuIZq9?=
 =?us-ascii?Q?GhaMC1pFCJ6g1vyWyVOzGJIuV4UdVwD2RCdxBShphkbPg7fWziwo9NA7F5du?=
 =?us-ascii?Q?DqOiXjAgP5X7zQ4PSfYxQdJjvMxOcV3Br0k2tIwE6vBQaAbUI1jnAu5hT2PE?=
 =?us-ascii?Q?HoTSMB1MVXKqGYkjmnwiCkTuNhVjdIwxH81jQ+arI2mBIyPk60zTynG1D9P2?=
 =?us-ascii?Q?dfje0TJNIlSE/0XiYXJO9i5PiLMENj3ife18BnnQJ2aGyUaK/LXkAHNAjlRG?=
 =?us-ascii?Q?KZsIyT44L+vFP7GG1LdCrLy1paP817y78FjE2t7UmoqPk6aOj6aj3BONrKxw?=
 =?us-ascii?Q?tXaF+Ec5eIyPTMAwVl1t04fOGi2UY9R4q/n0KSmXKuXRVw9HMulvt4XwBmbO?=
 =?us-ascii?Q?tqQwNh+s3QPQhLZEPQkZY+Clcn+hXg1m0ITcFMymdyhlRTen817r3T3IjPbn?=
 =?us-ascii?Q?Yh01fuBfePp8/bfi5KltPCbLZ4px?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SMZheVeE3HPKtftqTO3Y+kX4oDac8omYo69AUzBUpuzn0O3//Uw/z8Twzwot?=
 =?us-ascii?Q?oFC1YkDQAbtIIWikLsu9x/rPcHk+8Clc2pvcGyQUFTm/9VASzJDK1z7/6wqs?=
 =?us-ascii?Q?E43eLRhtFUS/PDITGQddh77U7AaY64Pqwwht/k3SoQPquWjQvbi3eAHSfldz?=
 =?us-ascii?Q?4VNRhxbb3RqBtYINEVq+kyy6vch42Rhv8sZ8zgeUchRTzPmdVsz7H+/1AUOZ?=
 =?us-ascii?Q?SzXcXV5qDC2K3DBN7SsWNk8RkcB/8R0CtNcd0IV/FfUGGJvF39jayin3QZKT?=
 =?us-ascii?Q?kj3ecX1+/2iC4XVjdp+4b75wzmLPN+D6R++SND2rv2H7zPTmkHHaQHc9uG5M?=
 =?us-ascii?Q?59p78aOHENShSiG5lUvobfnj1FHYUuz49J8mAxqldUwT92JgG21BEvNBdx+Y?=
 =?us-ascii?Q?JXbst6b17Pb/k5RGVmGchw8qFagWmwElOD4HOk0ScFRpEToX+Z6KJ4+OAYyG?=
 =?us-ascii?Q?xh3YlC+fmQ8kOGAZIOSdApX8tkt6wUpXstCwwt49JLPkHtVwAlMWhVYAMuqd?=
 =?us-ascii?Q?MAUI+SDEhc3ZW2Gxyye6Xvu3Gst7FwUE59d4J0YMPEmH9LA44e1JArgD8iuo?=
 =?us-ascii?Q?nDiU67FQQTP8HeYtK99TfmSdDpnpuRg5LFako6eZ5vXEN29Xe5hGNmcoKfpx?=
 =?us-ascii?Q?OQ+O1KMG4qB2T4+NPQFV94eGWZxoo2o1U9nTEaVYVYGNT8Lt+04EVTqpYLNp?=
 =?us-ascii?Q?u6MnyK5pfWJp6ilEMvyc3ODn0FSP1YpBv2ZOVdMCePZkABK5Vs1sq6rsnhOL?=
 =?us-ascii?Q?j59dh+KirjjdZC1EkyI3HbLlWAmW+ZdbPbfL2/DAeM3z8GcZDX8SS72ND6B3?=
 =?us-ascii?Q?pM0Zi56Gtlh0v+j74NocXrew8Ha9RdEX2YhJnaWhrgxqcPdRs2K743am4ZKO?=
 =?us-ascii?Q?fYOS3hQISL2Cu6N+BEg9LYOA9rJaZfYyyPlWzeNujALXfKco3E4CsaBq/Vhh?=
 =?us-ascii?Q?8uNAarxoHtOl+KCoMX3ktItYm2xaEwOG1TMzZIJYzgtXTm1MFm/UC2Kg9Xww?=
 =?us-ascii?Q?gr3oz0qlUwPZCNo64hh7h/gWufizHr/UzvEAQ+/ntZ1XakiuBKU3SE+wKDOI?=
 =?us-ascii?Q?F/j6RDqeGf82WFzfFt66Pj98B3F3qjNbGxzpkKIbayw5lTMIUb3YjbQoYgqA?=
 =?us-ascii?Q?E/pT8aoneMO6dBWklK+kmNyFDnuzb1WgfG9ZWmu99unNJOmBMkhD5vpKjxVY?=
 =?us-ascii?Q?rj8S593wLFZ9l44Io1cOynP2GO64Sqke1UbzMDBXc6t2pQY3nJnWyS1ARBt5?=
 =?us-ascii?Q?mIelL++o/Qk9N9AAH4wEhVorlgvrKk1yEbszQ5RkbVSNEyoblz7y7F6vP7XN?=
 =?us-ascii?Q?w38YAm9QUGptUUKqTHo4KiQX3iGHo6BDwt0QunIlS9iD+U/lp48ZQ/UMPGFo?=
 =?us-ascii?Q?h09+g1j236r3svByYUrhSYAw6PQ1PlVsnGJOBc4JF3gy8IGlFTP9dNqEFVeV?=
 =?us-ascii?Q?VMvvHHdAuH7FFRqmAKRVrhKuX0dT/flRo1HyMtKLs+OsJV0tO25XamGfCD3z?=
 =?us-ascii?Q?k1EoB3vTkiuq+/VlCwT8bwJjecL/JO6/mjVpjcFsBhjuNbLUY+fSLL0F3N2l?=
 =?us-ascii?Q?6LEn+oF+QJ9JaVXsWgkk1brBKwYDzlLwt3OT0/kKURfdfhol1uefG02eEr/x?=
 =?us-ascii?Q?jQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a07f18a7-2511-43b1-5845-08dd46a302b7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 11:40:09.6844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z6RaFmEgNQPFScXDD0IuJaYCPEVghB7fn9XZp2XoWEVvR9+1wBSoEbaOwr6JUmZPGvc/UGgTZaKg2Ui6Ztfvp/oF1gWA/F2e0dnJGeJyTfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6953
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

On Fri, Jan 24, 2025 at 03:18:11PM +0800, fengchengwen wrote:
> The new impl don't support re-test, how about add a wrap:
> 1. rename test_multi_alloc_statistics with do_test_multi_alloc_statistics, and make it take socket as parameter
> 2. create a new function test_multi_alloc_statistics {
>     // prepare a new malloc heap
>     ret = do_test_multi_alloc_statistics(socket);
>     // free the heap
>     return ret;
> }
> 

Can you clarify the issues being seen on re-test? I have just run
malloc_autotest multiple times within the same dpdk-test instance and not
seen any issues.

/Bruce
