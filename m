Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DF9CCFA05
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 15:02:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF29A4021F;
	Thu,  6 Nov 2025 16:02:49 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 07FE34013F
 for <dev@dpdk.org>; Thu,  6 Nov 2025 16:02:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762441368; x=1793977368;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=QWnUIoB5sipScg132+tqKrBSb7bNU759rtWWT+NzbBk=;
 b=nOGMfOE25viAk4lYnthx+cUAar613WdceXZSfDyMSo4RWuv+yESVWm5w
 92kp8rMY7lixTwt545LePOrEtNyM+qe8qJU+DuLdthyH8orgPF5XxK4W+
 UH1JqYZQamWEEYPQw56pX6q9XpvCvK+Y8cZTKkq7iLDlhlG3a29l3OTzk
 Qf+DtHDrAurKUaCui7gZyOAskLKojOUOluq1DPnOK4EyMgBuoyAIbICG+
 HnRntg6ttDXJqYLRkM0TWCOTJj4RxGwgDHEwHpoX6CL/jOFaLeAOsHV10
 lOX4mfHdeGl/drXq4VdTE1nwTCeEZkhOi8k76HOn7pTeF57alwc4cIp+s Q==;
X-CSE-ConnectionGUID: c9yX1n0OTTSnEABvjGl5YQ==
X-CSE-MsgGUID: zwkaUqAjQNOYx42j2VdKHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="75266028"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="75266028"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 07:02:47 -0800
X-CSE-ConnectionGUID: Ax88UgbNQ7CbWay4eXKOsA==
X-CSE-MsgGUID: GWqqQcjgTYqpKDW4c0erVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="192824856"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 07:02:47 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 07:02:46 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 6 Nov 2025 07:02:46 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.29) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 07:02:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YaCAmiB0XACkpNiIQz18GrwWZDaVXV0BCOy3U8dND6StJxwIsujhCvWqvepRniw0HhgtOEjTT2WzRWZznd5M90k1rEdjle3sfL6M+WQP7x2tulmMP4Sr9ogMT8kwQ8GFK793Yj0FrKmyETi8D/drpMnr2LJ6uwez50OE2dwSSih0G9dzpHqbW4D338B7n7M5t2ZLhi0agepI9gKRFXWfopV9HdiqgALxObEyKf073qyPGkh1EOI7BPExo1xzISVs+XUTdgW7o+860I1r2fUN6AbQfy9rW+dNmyxdXC761+leDqx9yNtLVzoWLhXAdEaYrk7l3wZWWWe3iOf5NOLHuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAJ/UnoZDNfbrWmcUS+zvQUy0Y6yEvWF+mknNJRZfOw=;
 b=e0EvTObEJWeVRgkdG/TY8YKaWBkIaepg80jkGMlkLrYqJ5b51NyMlPsYZumIrulCP6vZMgndnVooDWJW5sfull/C8TRMjYbBiXplYQXSHAHMIOnwgRuX2+LaaKX9363h8ZBAgcPm+kAQkLyTV9cBLyODI98xUE/SiSU53U6ZNyxzaLIzDZl6JtaSvTto9Ga86xRbX4+mAWEKwD+6ApWIfTyOoIFz29b+mEM+teqXNHggfDFsGE7O6MpuG5sMABGLIemUhVZS0IrzS0XuJQpG4SS0kow59cxoG7TKbi02liNzEyuZnmbY2Fc13vgFA8Wm1Jrpg9SKundSinuN7lBnuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY8PR11MB7242.namprd11.prod.outlook.com (2603:10b6:930:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Thu, 6 Nov
 2025 15:02:44 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 15:02:44 +0000
Date: Thu, 6 Nov 2025 15:02:39 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 1/6] net/iavf: fix compilation with VLAN insertion
 disabled
Message-ID: <aQy4jyEOWcz3F9Az@bricha3-mobl1.ger.corp.intel.com>
References: <20251105152642.2981673-1-ciara.loftus@intel.com>
 <20251106115016.3035639-1-ciara.loftus@intel.com>
 <20251106115016.3035639-2-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251106115016.3035639-2-ciara.loftus@intel.com>
X-ClientProxiedBy: DB7PR05CA0035.eurprd05.prod.outlook.com
 (2603:10a6:10:36::48) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY8PR11MB7242:EE_
X-MS-Office365-Filtering-Correlation-Id: a06968a0-166d-45b2-d670-08de1d458a0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iPTPlKzo1lJZE7w4SKtmpKe7h40GR//hob3YltK1Zb3i0GkWkuDLEhuqSGvj?=
 =?us-ascii?Q?bgnNU2npdUocj5tMedL/9aPThqDcyoRH34WlVodp4CxYixjOdClN00caPeaV?=
 =?us-ascii?Q?nCrH5dEy3fyml9NjZXuIgnnwWUt8nWRm4qwEZpVIZPETUFNggcu5My+c6BTD?=
 =?us-ascii?Q?J+RGrMhRAMtCa2rkGrjdHqd1jo2K4ttTYK/ITXjnWQB5fH/suf8x+82qWe8s?=
 =?us-ascii?Q?UAti4+aVKmzgQqKqrOImfr8wFdfFwViF0xYBv9vaA3u9cfLyydlRLy3VTmdQ?=
 =?us-ascii?Q?u90x0m6PdSMFi+NzYPD7Xa3VR8sYoTe/VpPo6Wj5/a+If3pq0vmuUeWOG72Y?=
 =?us-ascii?Q?Id+RB+qGa5cClKaM9JBGGPx98unr8DIpmg8ckPGVp2gwSdcKDglxq6HQFf8T?=
 =?us-ascii?Q?H9dGGAcTQrHvIhjZH942dFxIexeeFFZbKrv9QDA5wT9LUx8RrFVgvHmwHG6d?=
 =?us-ascii?Q?Ff3DwhfTSKNuugUgQktuZldM5Z+DFGlsMmZ4frtOh7uIrAGq2IOb7XzYt+PT?=
 =?us-ascii?Q?Bfg3eCjVFtdihhMJ25YB10MM0XAL98yhRGMcW40B4JdTeCZMMMRCo38g5Abt?=
 =?us-ascii?Q?Kp0Gi2+0jUq+ctkhYqdjxSM7A5WHI7Mlt4I9ZfFEBwgy+rPj17PmAL1EtuTq?=
 =?us-ascii?Q?ttvGttOtroSGOJDNsF5N7xpxYfyxg15C/ceey4Qkx4Y6m05bP4KYKt0C5A10?=
 =?us-ascii?Q?C+YufJ31ODvKraqtoOXEvjjV41ZcWM33z6MNkXATw9dLlXYD4nTpwErIIsIQ?=
 =?us-ascii?Q?qLHnmJ4weeeeXeq31AmPW9Baf8cBHME6mFBZHRGUAI6z27TtPfxLCbR1PjbW?=
 =?us-ascii?Q?0dCIGTZZ18Cq6TEPgXFoX2OiNdSb/oVZE1Za8Y2qcc6GlkY9Jco/pMmoWm4A?=
 =?us-ascii?Q?7a1dXKtoRGUukDnqa3sm7+wUkLcQFwV5DGLz53i1B4stHp2ae8zLRmrlW815?=
 =?us-ascii?Q?IiaJMTbH9DdMY/87gMU3DH674zMcL9dp9y7oJjzX98e/5IksmWW527mSER/O?=
 =?us-ascii?Q?LocRnLOeev2Zj/+OyDy2IjLv2bUANWDp4MMa8oGFWC4Hm6lTqQVAJL7lwDUh?=
 =?us-ascii?Q?ubvTpKZ/jxypvn8r0qBc1tfehCZhQIKQ1CRmTQifJdobjE6hubtQ3z+2/7k0?=
 =?us-ascii?Q?7WydvafBo+VZd3OfO0AzJqY0OkmjPgr4Lb9JcvdQwu+nuMGgFf71u01gFpkg?=
 =?us-ascii?Q?3m6yoOjmnYFN5pIZxSwM/vUtY5FGoCY/mQxINZyUMzi+5SKF5PrH8JPagR9w?=
 =?us-ascii?Q?X8z7f8V/CGQ1hMeTQbq5HnHxDeGFCTFNIVOs2l9Q7fD2+y4+aASEasj+RKbJ?=
 =?us-ascii?Q?g0eTtDLNMR+IJdRXdrXYduwbuBN/yKsU1Abx48JBlhxLAlwflazSxsNdfY9p?=
 =?us-ascii?Q?fyDuhYe1UK7+hYAwVmDOCWRiQyeXhd/MOgbgDmISwsyBkWPpDIdYSNV0kuM2?=
 =?us-ascii?Q?iLecOiNCbTvRygjb/8riARlVNA9djmjO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Da/f3Zmq4SNVX/Ejrqeium988mk9fBxsNurBFsi1SLf69N+SezLwcOEKeHgG?=
 =?us-ascii?Q?/KcTPqXBsnkLvx33IEl3mmHJvteFdu7I42cOOf3PYFGC53vdmxIB119hrGWj?=
 =?us-ascii?Q?/6R1MB6qrmod5lYn4Txwj0Ifrqax5Zxk9ciKACh2Q78E4w0bc9+Ld8xN6aU9?=
 =?us-ascii?Q?0wBQZMQ9Xh2+mJ4p4f8Vy09uzvO5ngzE9/OwwuJjhkNY7/y3JGLAkJIUguwr?=
 =?us-ascii?Q?RVgYH74ipFg/NUTtisYEsSBzF/UbNGWYLinJIhQ8QK0SYo4Dry9MqeCIlP2/?=
 =?us-ascii?Q?4E3yP4llh55gRD/JmxL25ZFfEyFS3ZHE444V+YCupNeItE5Td2/jye9w2ypm?=
 =?us-ascii?Q?+0dwGNpkjk/UpE8iu68uAqSg5UZXYttjB0GoWBSRYIbh6ladbCopaRQlixrI?=
 =?us-ascii?Q?p5hGIaJD3eSmZIoDSjO1xLEI+kCnGazDXGCyVsW/mcHCMt8qwvcC8MSEeJyv?=
 =?us-ascii?Q?Hjocni1HQDbdUV7hvHMh6IoID5nwosj52gd4Ju/MS9MsTaKUi4sS5wc92R4k?=
 =?us-ascii?Q?B1aTHtnDvgXjbc6RTgzp8i6TjAGGLSCYBMPTKIQwt3qCv5zGCtf7APRfxNg9?=
 =?us-ascii?Q?UEgF2zFNobXQzhGQHfnlBJjC+fgzM/65mf07CehG98EJyNXyQ+SZEg0Yhkne?=
 =?us-ascii?Q?otiuJhtAI20GW/mCMwekrDstBZbsgv4VBM64p9hC+Qolg5n+fjvUP17+9xHk?=
 =?us-ascii?Q?mtOs6shtUVh8KEoYLH1hiLXkNft5TIY+tksWzxbhqjiNTE3pj/JGPLttfKDp?=
 =?us-ascii?Q?aWmz8NNQ9FH6aC2HZ9hLVnd/jRYt9QgweyIyXAJdrVFzPTFBT3ieh3cOr3aY?=
 =?us-ascii?Q?YeXRyE/JsS3EissUwOoDS0h2cnSNpbgnp3hTf2Z2T83yHudcoAptJp0omQdX?=
 =?us-ascii?Q?tVV8XrM7iRbpaP2UI2cwBieDJQ23kTb66qVO8VumJqnzObvXbkYvl9XC7x+i?=
 =?us-ascii?Q?sOU8Pi+sPyDv8mzzMZdHYKPxbWaXffgAZvdE0fryx9gywrn9dLaw0yg1CtWe?=
 =?us-ascii?Q?/bmigzh4QMKIgU4g1wL9kWv7SyoZsoMEptx+il+CFBq7FljcY4bc+I83tw4y?=
 =?us-ascii?Q?o7ZIvR+lxz0Ciatgkv4+e+Sevk/6Ifb1YNXktb/azKQ50fX2Ji2p/2e7Mqis?=
 =?us-ascii?Q?gXjzSM8b5kbLNBaztHRwKb7FdhH+hLWPcOqk7Pj6JL5vhAkQBmeeAbjigGnm?=
 =?us-ascii?Q?FTMzKjtbpW4jbxGtpHhDfGVor63/PhXSA3OrIVdanBR7aQ0OMZcCUR1hKcL/?=
 =?us-ascii?Q?5Y+Xl8QGmtaw3MG0UZiV+vr8C9JQ0azkIIq7DGs0yLLflIaQB8xiy4shpyGk?=
 =?us-ascii?Q?zctZ2uXXvHtq/sT4d5XlSkK7zd89KfR5fwj8QQyatbttjAoMJZM2q03XOTzC?=
 =?us-ascii?Q?DdfMvzEtJbOJeI/CoJoWWkEc5UtQgeuwgb31VbMBncnhbI7sqOkEzSDSxUHt?=
 =?us-ascii?Q?CfrfvbyT9ULht2UXjGxH6GgsVeTUSNTCq1Pp891C74vLwmV8cwBbYHb1GYSL?=
 =?us-ascii?Q?XbK1jnccpgveBm3x/kCPDSV3zqduAsqsZTfRE8DHsn5F5YktWXsszrKRK57/?=
 =?us-ascii?Q?qosgTU9zDaegAcbWKZGPSasjxCpuOSUhkM5M+9AxY7ABR3ltoyhGZiDYNwj8?=
 =?us-ascii?Q?qA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a06968a0-166d-45b2-d670-08de1d458a0b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 15:02:44.0811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U1Lv76umD6vyFKUV3Sd3575sRTHLDHiuaTT5i2DNE+csIBOpzmRSw6WVnGhDR1Xk5/+PEvXbfr68RuAUZ40DLLPaTT8z9pN/ghVaFHED2d4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7242
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

On Thu, Nov 06, 2025 at 11:50:11AM +0000, Ciara Loftus wrote:
> If IAVF_TX_VLAN_QINQ_OFFLOAD is undefined there will be an unused
> variable warning. Fix this.
> 
> Fixes: 3aa4efa36438 ("net/iavf: support VLAN insertion in AVX512 Tx")
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_rxtx_vec_common.h | 2 ++
>  1 file changed, 2 insertions(+)
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
