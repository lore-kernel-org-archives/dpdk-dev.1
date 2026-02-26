Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF84FD8FCF
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 16:24:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3ACDD40608;
	Thu, 26 Feb 2026 17:24:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id D5663402E7
 for <dev@dpdk.org>; Thu, 26 Feb 2026 17:24:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772123062; x=1803659062;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=e3aCpl6swBMXwqKnW4w9kfsUnFQETUexT5L5avmXWj4=;
 b=OJtipH2aOmKwAqSQyI466nCIgFsTDIRVGh177hGR2BtfGFBfwc38VvBW
 ySy/ErhrtO+vukH97EhG9RKna+c/VpG52imtjdb1CwxYp8OZAgU24iTGy
 nZC2/D+KuYLDCIX1v2ILtimid/mQU6Pji+WxKpoPIdcIRpCVrmha2FIUH
 0f0ArTTSIwczUzEz74jRD5GP3JfZIMBOXSjeMq0jXg/kc/jpkShKexu6s
 W9kUew+FttLdr/aZMjUhoNbaPvBBvkDWG4afNIyRgemHW9YAbO+4UrmSW
 9Atzm+tjRw1Vi6khDphjXo84tQ2dcWmotl1+XNn7oPAmE9AtL8OiMw1IJ Q==;
X-CSE-ConnectionGUID: AJ34Ocl4SEiRXEMfvy3FLA==
X-CSE-MsgGUID: bQo+lP8CSq+kFHELX9J1bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="73294210"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="73294210"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 08:24:21 -0800
X-CSE-ConnectionGUID: UNH1/G2ITqq/xZOb/M8FWw==
X-CSE-MsgGUID: 9W1ujYjzTAeOLpuvwSWZZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="216739541"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 08:24:21 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 08:24:20 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Feb 2026 08:24:20 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.52)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 08:24:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MoNU9oFlYPnt7val6W399id+msafLwZH0gReLM3PLFPBb5vzTFdZWqYBd/f/GKJFODoq7fQge1zOMX4qSuYqZsEEAUvbmpRpE9svwg7WNZ8pk58djIPqQ3M8Ra+Ubn7VrTbzuwcnLSRGBkllEbUzDWnUAq+NVzC8DsSbMV8ciOCY8N65DIRiHnV7CTydewoocnFhGQvVDCtPnzV6UrrWiCQTW6uZqkqQNWI30sslbBpB+3wIZ8LEscbkp7N/BTbPR1FaJZr1rFCN68rMiMmp5/z5IwuF+xSC0WQGXXCJkXPQo3bV/u4bJiUml4+lWAgRCcj2ENp7xONAQCpIrym5vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxbMEABrNIfQ58EdzbmHBWtFhRxDUHAruER65rrJN/Y=;
 b=B+KiHFlp0aQFVVyM03EDnc8QHLBrD5OxwYkvHxRIk+CFazqSlmAOhM/L7Qfw9B9gM6i4bfenjy+GJugXlreQKrvZPsE1rt340NZ5p8ieY3EIshGv1cnQhaGNrDrR4iY+mkBJfRi8NNyvV+ZJz2EYM5p8llQqaVMx6+XueXGJ+PMFD+KKFl6c7zOqJ/XLc8XONBRXT6I3P7AI03XHaIKpRuP2cqGstzDe66F4cZpk6QN2Wl/T30r9wfDxfedG1dKeWrTLn9Vi5LfYZ5rX+w6V2aTrTfd8MFHCuj1aBZMkljrGY4qTC+rspLGkG3aY1mKOnOqXr8ySQ7hDIddBF8FghA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CO1PR11MB4881.namprd11.prod.outlook.com (2603:10b6:303:91::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 16:24:12 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 16:24:12 +0000
Date: Thu, 26 Feb 2026 16:24:06 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena
 <sachin.saxena@nxp.com>
Subject: Re: [RFC v2 3/5] drivers/bus: require probe function for NXP drivers
Message-ID: <aaBzps7x2lmtVRV-@bricha3-mobl1.ger.corp.intel.com>
References: <20260225112922.3982104-1-david.marchand@redhat.com>
 <20260226162057.207202-1-david.marchand@redhat.com>
 <20260226162057.207202-4-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260226162057.207202-4-david.marchand@redhat.com>
X-ClientProxiedBy: DU7P189CA0029.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::29) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CO1PR11MB4881:EE_
X-MS-Office365-Filtering-Correlation-Id: da3b77a1-52ca-4a3c-50d3-08de75537a02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: FDvGrhAZ5tusyvYAcx4AYb5vcnMUjVEmnz5/Wninxg2AgvrG4FOXhYK8jCUuGERIG3LofXnrhyCglV53gC6a8CeXJxyiS/EzF+t9VbBokQOGjdbRyufw/c7RcFe269LX0DPeglTD3Qt3Pym85GetQ7rXELOxmV6xpBag5cKF8i5RgySUNq9E0+3dXUFrNiyZ4/doMnR+or4OmEExRc/EiV0CHX/lx3vlcPEXFHUBwAEUCVkjbKy+0z+Bj5SYWDnUxQGhor2GWH6daZok4T5Xo4H45ViwwzuTo1uHA8Tr5NJ96UF06j1pbbG9wwCpDgTwhxF67DzcaNyuJp95AlpNpiEj5SJ5Yplaequ7EjJkhGdHe2/Cus3/iSIhYxRy86n2J+P5zLnMaZ+UpkixkZlvLYSCpG5MH2x2gd/rZ4TgE/5/qK7Q004GzlvBfgCZoVbXI4ybyJtNWH5ELUCL5CsgRcAAf2vGs+n9jFUqZWJF2DylPhgMb+LrpqdUW+JAvjnwumo7a+WWdusaFIFURoYvKcWP/C6GXmBOGGk+j6qTXrAxA7BuPQ8sIccPGjiZuia8mKJIxo3bytdk3jy0+MyICwo071rfnBYu6KT1iXa6p7DtN16eeIGmmO6bDmoUi1k6t7Q48EytyT4xqhpqe1wSW0rw5JERT1tl5u1RLQmopIzVlTQg6nm2kTL8Nd4jmDkbxIrfz0MW+QvhBO+E//fWUZ/AW/aPJYR/SWFgJ+KJY9M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zLnlXMm3Bqg6ed1m4fs/WMGimSK1la1eg2bA5/YlPWAREcPt5UWGFp7ycfNR?=
 =?us-ascii?Q?m0E4yJCz89R8XpMh8s6prQr9ymBevVpQMKk87oWC7Nmzgs2MpOjDxaCMjeWV?=
 =?us-ascii?Q?G22d/logEv3Gua9SYgiKhbGx206OeCfC7Sda+8qWaAGvXBA9S6TAlW64nRlw?=
 =?us-ascii?Q?NKyYnqJrnYOvkYd5Mzn5f4DuWGHQo7K8m9R4UZzoMkxkMTRQYEeVdY3+p61t?=
 =?us-ascii?Q?AAkTjS9guyr+se1gXa4WLxt0KzNzecUSw+NlqccRreyLNpDs/sT9TlZqweTj?=
 =?us-ascii?Q?ul2y8wdESC5JSMId9w2eUeqssTt2ixkvOCEx6ZNoSzP92nFrMvuTEPvUjsU/?=
 =?us-ascii?Q?yJovGq8OGCbMyK/VEt/Ms/Q2ICXinmV6yGfkQOKvW7xvfsUxtWiRyXHA0+c0?=
 =?us-ascii?Q?dPEQKyNrip9BquaHUyE30UyYceoPQdWxFlTLOu/l9RIBnZiDk6xMAp/Bi0KN?=
 =?us-ascii?Q?aw8rZzjd/I9tI73+5IYq9xhnUP7lghpAMENXq3Xc1tQhPW1r/pjUkS1Ardry?=
 =?us-ascii?Q?aV6/CApj+0uZ+RH5abrpGTA4RZWUMmt3CSpt0Tn3gOMtY5e6GyznEnng341l?=
 =?us-ascii?Q?Duiq7KYe5xXAYfmw2GVU4r/GgVHSmhPvtUj7DmHx/dz+D2dCLe3qb0zteELG?=
 =?us-ascii?Q?BAQLp3C69evE6m2ELmnji3KTob6UNWRoVdB4S3anCk+WWPuwiPUEAamqirOA?=
 =?us-ascii?Q?P7ERW9rrBTOPCKersC+RUAIAf/nMV7HauQ2SOEEADRfEz446bH7+EzwsPlM2?=
 =?us-ascii?Q?tbkUvDbWxjGfmXMGppHuU8R5+Z42ml9/200QLeRVfnGM3d0S3VQJpkL/s+l2?=
 =?us-ascii?Q?rHzOpLPm//gpWkjznJwZEiSoRu60w9Cl1wdQzonUvpS428WRg85vxX0rNs+e?=
 =?us-ascii?Q?MHddEGH3vBRplyNOVfv9SSv21oLxN6F33HRtZE+HXmkBG7v+qZPJ5zt10l9z?=
 =?us-ascii?Q?zTfdHUxubUwU2X3l1Lbkv1HVwLSjD9p9BR/SymyIpE0hYtvTQnQGH7KU55kA?=
 =?us-ascii?Q?1s01JVmWuD63r3Ne93tqLJ6cUoYsr4AiK7xbPX13mHJGcdhVXD0FvAsvM14V?=
 =?us-ascii?Q?XslYfq5UBWQsjd/AOMa4Pvb7Eu/Px9QDnK7M4OU/Qx4erEcIpt+c0u70BMEQ?=
 =?us-ascii?Q?VWNt6UdElj7dd64/31ufMj/euCXYbGR7eNWPmxL83cl2oameNdRyZphl+Jtm?=
 =?us-ascii?Q?JYnPzuRjhRm3ZqTgMFnRBPlRPaSOy+u4HxEthuEzYbb3Xuy3AfTqp7+aVNl6?=
 =?us-ascii?Q?mOmS1zZaGhymRKUNko/I/aYxdCFzdo/H2kUZV7q1Pn5C+UaZLEYDNnzYbfo7?=
 =?us-ascii?Q?lWG8qNkpfCFDAl2UY064EM5G9rehnihVTIXmCwOfi8zFScc3rox98xBv8ilS?=
 =?us-ascii?Q?vaIxDv7JMRaUqsPGpg8nQ5LMIjosev1AkQCACxT5qf/cSqZlnwBYj8Gep9Se?=
 =?us-ascii?Q?JSoCUuPHjNc2RDFDixfzOBzStXwvZdUGabhB9Rwpcro/R1IRwxVveao/3fEH?=
 =?us-ascii?Q?ODRnfeYHeaKMvNSrTfDgtLGtSDtm5/85sltqu9NQ3sAfooLCiDsGZna4WeHU?=
 =?us-ascii?Q?2ZbI2kHNpa9byyVjBDD3CwbxX2iXSbrdyhzpjhJOxYhvZUmH5acrV965QUM3?=
 =?us-ascii?Q?UQkE7anAv0F9p30DDXe8sNsl35GTcBl6FEVUEnfwEyNML8rzdxlJ1jLbNJtw?=
 =?us-ascii?Q?KTkOwwSsN7Fw5j0uZaBofMjAFQDXfkrl02wKFtbs1TeHxQLlnIIx5ylX+SUo?=
 =?us-ascii?Q?fJxhBi0T2oSCKojv7Uk73IYeTEOAqCQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: da3b77a1-52ca-4a3c-50d3-08de75537a02
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 16:24:12.4310 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TfYnqx407CXz8s3j2SW1wOQ8rW5Ey+l7IwF3JGlZ/0qDmHvNVe785NwHWG4gryVoQj5CsvLWkUHbHSOabfyw6DvjugXHXJIUMwGnRlevjD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4881
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

On Thu, Feb 26, 2026 at 05:20:54PM +0100, David Marchand wrote:
> Rather than silently ignore an invalid driver, enforce every registered
> driver has a probe callback.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  drivers/bus/dpaa/dpaa_bus.c   | 6 +++---
>  drivers/bus/fslmc/fslmc_bus.c | 7 +------
>  2 files changed, 4 insertions(+), 9 deletions(-)

Acked-by: Bruce Richardson <bruce.richardson@intel.com>
