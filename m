Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FEFC28B20
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 15:25:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A4394028B;
	Fri, 28 Mar 2025 16:25:11 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id DDA764026C
 for <dev@dpdk.org>; Fri, 28 Mar 2025 16:25:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743175510; x=1774711510;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=uEhWZcAHVJzzsYq+zZpoVt5ffMaxUM+yc5Vx+TCt7sE=;
 b=lGfCVB4U2OaKpgA/GUMqh5w3joDZH0FT5EK8PmpK9itLpVdSFZckCrfU
 aSdglpH45be9RSQ9U7hP6JUsQ/k7nzqkniO7awysco/mE4kJIn7rBo2IE
 yAVLqZANNtNuPNnOetXnD4kt1VJXXgLLPV/6YcZZpx3NFKTyvX33d0BKA
 A1dXbkMAUqWs5lxDzIJfZjiFpiJwogvw3ntdVvgt2uGIOLH5uAGEli1GN
 qxnqcTCROur8psN5jtaKhYhiYxY9MRYecn0GBMYvMlXyGBvnr3F521FFo
 VOH9PpmfZCyRPDLrs2awlCZw9MM3nyiM5F7t/cB7A1U7+01y2cwrk1Imp Q==;
X-CSE-ConnectionGUID: Qkh/RmY8SzyLdTQZqItIHQ==
X-CSE-MsgGUID: JGL7z/eHQa+xzPxSIkg5cQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11387"; a="61935122"
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; d="scan'208";a="61935122"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2025 08:25:09 -0700
X-CSE-ConnectionGUID: 7JB2EL0HTM2HyEvx4hNLZQ==
X-CSE-MsgGUID: 4moc5XbnTieYF9yK8XaYgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; d="scan'208";a="156469536"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2025 08:25:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 28 Mar 2025 08:25:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 28 Mar 2025 08:25:08 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Mar 2025 08:25:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u26ipKraYLdcBtIWxG7P3oKg1e0leVx23gWhtz+to9kL8yTFIBRa8XwKWs0eKd/BgDqxFc5lR7G/wd1siz+ivgCSLu8PSbnwtPEBcumQYgb/r+Z+1NiCE1zfLX514keDGTYx9Anl0ozy9BNxduWJqX1bz2iwJeC6avXxqDn51xuNwxf2G3PbSHUjpwRVP2mAb1sULMwEm20CceyDV7208l///4htb1NSxhAmqsBAmPJme60zhzF3zPdov7Lp9FBurXMpY+kkKS/ZHMsp2z3VVKgBhVIqACq2Ep2GEe9sPsFpUjZWdYo3t0WHIn2uO0bObHLQ05RJZPNVxCwmHnLspQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfPzDNJso0zqrKEQAfypXrwGH5rey+/g7mItkJZVAdw=;
 b=RXQeFyRYKiiF9RTdJbwJC7lAASzc/8TUrDODaF9W/EiZMrjUE+01ITLMxq9JL5DkSf9G2luURAI7ibO8UZf5EwbadJeMxbfp0+HleouDe0Ty6oeXyTzrWiCBKhhaDTd0p/BMdMLHIC73blHDNsAn2l4geG684dQbgJsr89LPpt8tkKPPaypR07lWy8BbMnQU0638pni4rWNjV9TOXSXLquc+eI5D2h+tNaS8AijjgyLDyU+PJI/YLcxeGqRe8m0RTAu5fCqNdArVKeNCTKjpGf2Ph/ap1BGogMjsBR/rf8ba/uE8R8BSpHl5gBt1prRvj+KRErTc0f2M3BymmL5KeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB6323.namprd11.prod.outlook.com (2603:10b6:208:389::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 15:24:24 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 15:24:24 +0000
Date: Fri, 28 Mar 2025 15:24:19 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v2 1/3] net/ixgbe: use check for VF function
Message-ID: <Z-a_I3rpZQnqZJuZ@bricha3-mobl1.ger.corp.intel.com>
References: <91f6e1e3f59faf66e6d5f32e4198bfd13b30a317.1743085431.git.anatoly.burakov@intel.com>
 <91f6e1e3f59faf66e6d5f32e4198bfd13b30a317.1743088329.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <91f6e1e3f59faf66e6d5f32e4198bfd13b30a317.1743088329.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU7P191CA0017.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:54e::25) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB6323:EE_
X-MS-Office365-Filtering-Correlation-Id: 40ff465b-b23d-4093-bc0a-08dd6e0c9f25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2g4/s3m+kt6hTNoBoW2TSSwwFvQWo4GoyH9OuRv02+Zokksuc6PuZ8a9Qedl?=
 =?us-ascii?Q?f47x9rYUa846YV8AByUEOyvSjqgRtLCmSkqyU7VG6IeTQTMFy58wzvCZghsJ?=
 =?us-ascii?Q?LsJvDCSKOVcnmutnMdA+68Ft01sbm3VGxovgncC0eb3D6PSUH2QAhfDrXdHX?=
 =?us-ascii?Q?MRq8dVmJ7nIrYjT+afnrJFZrhUf1eHgz785ViLmrgZBFrGCTteU+MCGPLdN3?=
 =?us-ascii?Q?+Gupbct8EDoEkkyr4A+9z9kx5wR6v6KSFE0wUOOoWA79Z1pZ/A8rKwJVy6E5?=
 =?us-ascii?Q?pgu3jXPHUF3JT7MDrZBiOnSdm36qmsNQADgegnYTRvwjL+IiExWXIpA9oEHn?=
 =?us-ascii?Q?umVfXtYVaNWkDpbc7lOZoFtTd9ORGa6MS4jt38OSbp8FvNAS9qpo6DtGEB9q?=
 =?us-ascii?Q?fy8L+LQrz8OEG0YYmy6qXlA6XwBmAJ/gvq2R6ECjBW79dq028Tr3mAttTg8F?=
 =?us-ascii?Q?ePzEJ0513jOc7LjiRVDke8ji4fMxeShvCs+1XyF7SB3JboOfGDXQx3oLlVdq?=
 =?us-ascii?Q?F12k72NZCCCpJ6OTzIN6IsA9c5l58bwv37HCMt3NZ6E1f/TZolpyrR4PjRD5?=
 =?us-ascii?Q?4Rt/6cvdI4CnvzNrelrjBPGVUyj6mR5RtAoqpNnUFvgfaCWpMeKKwDqeigrT?=
 =?us-ascii?Q?MR8GNXc/i3wIewpaaOrbrkgieMsaVc5V2jeiy7aHHhb6DEzcyBqoMCurPi/c?=
 =?us-ascii?Q?kB6bMQVQkiSTE8Dd3AJPE/XolGICy2gEuR4ErG8NhuOtzV0797OQAPHyjw3/?=
 =?us-ascii?Q?oQAPyyIL3PtwdzU1tfBKODHC2ULcOkYhvfwcM2GjyGtIC2M9dcGkECgF37EI?=
 =?us-ascii?Q?cVXvrzab2eZJ/j77QmH05bTCt7arNiCn+OSZ5hAJkgWzbEAP3NIzJ80bGMZ3?=
 =?us-ascii?Q?vzrQ/LHJ5jaCM/3F45aFXPUS0FV0JDTebBRV8zy1a6hBv+0L4X3q93wF8gQ0?=
 =?us-ascii?Q?Hu0NWlu7A98GhuQOWWQJqCHiwaT1t8rt4pDvtj+F8ogG5+ZQz4Xk+4h8NJl2?=
 =?us-ascii?Q?J7apdG8XyGXI0GIYECQvlWUmlMhGEwmYge8+VPa716NpCGpdaZ6eyj9sr3te?=
 =?us-ascii?Q?WA8YtgjfLFASLB+c0w6AzFd7txQu/zUMgvN+xBlXhV8rTxGdh1VVCL+fZmC4?=
 =?us-ascii?Q?TZ/P7ZbtqJjbKB+xsEZdWFC7RK+xqRqL8xOqtEJroZaWU9iwleZTHEMKZfGS?=
 =?us-ascii?Q?CTCVZkcAbrdLz9x8OKOnWxSz3m/qOvWozo1a1wLx7oLP00XLvHx7EX/y3dCl?=
 =?us-ascii?Q?4F0NSRFgi4atowKPEs0CtulQ4yPPOJLs1j9glk4X/jmt40GO74CdKlhWeFMn?=
 =?us-ascii?Q?CHs2IEvnSWjnnnk/GEL8QYJylt7EU3tFjgee2iP9NgZV8QiNrtbKGJ1VixpD?=
 =?us-ascii?Q?3tsA5tX4AXUR+76fySp4a3MF9Tbv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mykMGr+OHuKRZA3Zdk3ki1nM+f9MQBXoJr+nGGxt0nH3HN75SmQ2JA1hWMPr?=
 =?us-ascii?Q?YNlV40BtJtvujPbRN3tTfyf5e5O8G2KFSHZEFQHfzmIwJcIeanXSl9zrkOUO?=
 =?us-ascii?Q?cdjDEAOcMzAwNw4KS/165U7vpiVfstIWgl/0r1mD3+s4WjJ3KYs+NOu4QpCp?=
 =?us-ascii?Q?QD+J1jvyuF7OJ9zv6cBZg8SZdUoLIuM9FOqgQlnCY+0E8KA8eqK+lI71Oi26?=
 =?us-ascii?Q?s9EpdZuvSXy085RF4a558O+7SOKSKK1QWM2at4s8gGozR0W+Dn0pRjtPesdW?=
 =?us-ascii?Q?8l/lntPJkLlDFxBSKQOPjMQKCsS4pTjilTeYo32D/qwuwKRh7njCajUJaEZd?=
 =?us-ascii?Q?yvIkv6FTt1R0JK4rnv0vVWgeJ23Uvpux2sG3fOukC1gJseRE5mmNSErLNgik?=
 =?us-ascii?Q?2YNdixu1gF/Y1Rw1pExGlEC58awgIHGI6tdDg8q/QEgQeYUvOaDs3HQtNpHc?=
 =?us-ascii?Q?JqPMrdM2tdut3L3meldducVV884GQP1OBN0udyC5YmQiNVuRy6yT1pH7Boqo?=
 =?us-ascii?Q?PzLSCgGyL8UDVT3j+tWypzDC8Mi7lOwUNuQsZzQz8iJ99NdRSbx01hFwbsS7?=
 =?us-ascii?Q?73zX5qn7j/nyseJdeZcMnCpDM9Msaw5M3ePJ9pXQizmTFf1UzS9FG8P+KWyL?=
 =?us-ascii?Q?oQpgV8t8hRh55POa70erSrEkGKHDDIHKnIr8gjxAiNXdrFCU8qjNFiOsuxN8?=
 =?us-ascii?Q?X4HId+FQCzgeTMeJbhKF35VfSPFVJbr2AdPYQV0LM1iBuPZORa2JhA5g0N2w?=
 =?us-ascii?Q?6yQfTduAIgbKdBqZUe03EgFSjvm9JZA/jRpGYoN20XOYPl29w4tZrCm/Uwn9?=
 =?us-ascii?Q?2tDowxkh5Ke+NI4lAgCclRGA+2zM3oz/Fd/3BSHCQKharrjt6/Y1WehyGHva?=
 =?us-ascii?Q?BW22dqLM8jxNdPmcnMbcxItas7PGLz8K2jhQTLqd96KkG69dIm4VdqDhcnQB?=
 =?us-ascii?Q?ACtSNLikrlqi7OjUd/ly1NU/rU/5OiytAGiTmXdQWeBqr+lBtcyBWV0r6Z/l?=
 =?us-ascii?Q?P2eWGSAswtgBBiua8JFuLBSVk4kE8ZNf+1/etKK2mv1Yil/7N20CkYxMfGRK?=
 =?us-ascii?Q?j+FFH4RKciIvNb7HYeXi5F1o9hUffMEw/bRh/PaV3YWNprc5RaHtEgdouwGZ?=
 =?us-ascii?Q?mpOm3zVK4zkCWjyMx9WNHzlyn7Zas11OP77uEilKAyh/ZvH/CavqyZAydtpe?=
 =?us-ascii?Q?FShLHPEWG7ivFji7zTrBabvfSJjABMpaKScNPnMiWc2Bo6QsbCe913czTD4O?=
 =?us-ascii?Q?QeHLGF08OtWI4fUarU8wuHQMuRiw3BA4D/hT94HHHes3lT+jfcqBLm0O9iwk?=
 =?us-ascii?Q?SMmCigyBsOdMofxeud/PdsdQnjxExa1dGMdpzZZRgAUl1Ny+oXuhgkwHjFgc?=
 =?us-ascii?Q?BnucZhQZub5UVnPknMj4h9IBQiNnXvIUMGwydUHGmGjy3bBqEwP6TNPjj/H8?=
 =?us-ascii?Q?aom7iG61Ufn1+nLxFX1kKoe1n/Go2ZPVOvVvVj216kPar7ROp0dsBP8c/+r+?=
 =?us-ascii?Q?VgkNDY12H0SxRMWhavPJhARtzuS5kibyGej4v2M1equGWvjWnvasDvtYCJfv?=
 =?us-ascii?Q?603z1AXnmaMwOuXDLRqFvcbCM5qGDqnXWanLLeorsimbf2qzKdEvGKqLT/5T?=
 =?us-ascii?Q?9w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ff465b-b23d-4093-bc0a-08dd6e0c9f25
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 15:24:24.7078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ds7DncPneDM6b3fcceIZZSE3Jo+PFveuViavikP9iMZ6zkVPbqd8c24pmPrB/3lY9L9ACr88xVf20gU83IIdlKM27N1q2L4uaBSryIU4jQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6323
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

On Thu, Mar 27, 2025 at 03:12:17PM +0000, Anatoly Burakov wrote:
> In a couple of places, we are using explicit mac type comparisons to
> trigger a VF-specific path, but we already have a function that does the
> same thing, so use it.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---

Series-acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel

Thanks,
/Bruce
