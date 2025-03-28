Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6F4C28B20
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 15:29:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4CC8A4028B;
	Fri, 28 Mar 2025 16:29:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id BCBF04026C
 for <dev@dpdk.org>; Fri, 28 Mar 2025 16:29:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743175762; x=1774711762;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=F6c4Esp/sysyqzzmgLutsx6gIG/2Z4QmchXm3MTHG54=;
 b=jlPRzF0BlKWbjqYwbx+Omq4JjNd27Z5e+trU6LhWj2zx0A5f/nSCrmPs
 v/wRLPDQPOyy8mlIh5/l0HJRyDt5W8tR8Mb6y3vMjGyu2rWPxgl7yPM/o
 47byjQ/cxetVYjUFv8RCV+DFwz6WjdcRqGHaJEwSjMfWo3mUxCQ5NNiL0
 ng+AM3orsvA0qMOL5nzR1Xt17tJnGXUlkWjYIBDpyjlCwRSPbL4ONpz+u
 PypYUFTAZxcdklyFmZ3yNfr3cxuLsYtNK4AvIBfchiA2d+RYtHWc52yzl
 RRrDfxb4W4A6S3XJodskYhuuWR9PBOKjWZhKUpoXPji2WATEnsR59A5A2 w==;
X-CSE-ConnectionGUID: zp9Y1TB3TnSExfPb4ygAdg==
X-CSE-MsgGUID: JxpV/qa9Qn6Z8u3JBsVCAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11387"; a="44425759"
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; d="scan'208";a="44425759"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2025 08:29:20 -0700
X-CSE-ConnectionGUID: oozLwGFMR6i53R370QX9Dg==
X-CSE-MsgGUID: eLmWxq8pQ4Wu/KbdWlk+cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; d="scan'208";a="125477304"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2025 08:29:19 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 28 Mar 2025 08:29:18 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 28 Mar 2025 08:29:18 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Mar 2025 08:29:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZC3CJQWtTdO2yVZsxdoQ551Gpd5eergycQdlHz86u0VnQ8WbEY83NKGUARXr+t3BXMvG6RsNg2kWkcJeucjRIMUwfJ4uP14jK2T45UB0bUQtK+klMcBCMWUnQINHWB8QkxjZ0SPFm4pOoXT5H6U2dMumEQ5f/FqPmCK5KOpncfyL+hjxjxR7qv6y2p3lrt453VJ3zBuQgKX4EBXp9iKpk/g7a6QhpRTmGaf3HNmXYKD9aGaySovJK8Sc4wFo36UZUjk0R0a1gwtozNR47VGIWGJ5qxBdzlrS6bFu9Qtd0/ArC4XOCWjTUdw45DJWNGtAz4vWOLOl9W+9mCt7tXBUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1nSfvMS6qN/0g/Yvx5KkAjCO/VbIS4VGjttYpiHys4=;
 b=HkCYI23WV4Op5CUKXyd7uOuRDb5zASP2ibqhCVcArDqWf6nhR/a0kBqsooME7jzNSSMBUScUj7gBttEOmE/nt+tNd2ItXoastgXG/5bC2uVWexYVCtTPFvk83iCM+DktjHwUMyNf1oW4k5GoPS8WTZRCmLzQB8qJlFBF88TXLVUuRaob/xOf76le6ZE+NjxVKlzYPFNzbUnP8dvmaxzEcjn/il/5+8DbUOGh0Lm3LDhXZb01bzXF6v5lUlqC/Cnm9TRQlatM6uw1a2oXzyRkCpMi312tW/q/Gtv52fedxQB63wHQd1QxAYh/SrLo778GHN5ZkOuz2W4l/yX35h2LmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB5994.namprd11.prod.outlook.com (2603:10b6:8:5d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.47; Fri, 28 Mar
 2025 15:29:17 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 15:29:16 +0000
Date: Fri, 28 Mar 2025 15:29:12 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH v5 0/4] net/intel: using common functions in idpf driver
Message-ID: <Z-bASPF9J8_htYNE@bricha3-mobl1.ger.corp.intel.com>
References: <20250327104502.2107300-2-shaiq.wani@intel.com>
 <20250327160437.2296127-1-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250327160437.2296127-1-shaiq.wani@intel.com>
X-ClientProxiedBy: DUZPR01CA0225.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::22) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB5994:EE_
X-MS-Office365-Filtering-Correlation-Id: d457a0d5-8c10-48b2-161e-08dd6e0d4d4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ujbbO02Vbq7WgIi8hzdz8JQ9MrgDZat0hpQmusQk9wKl+lkrvCyPghgTonGx?=
 =?us-ascii?Q?zWF4nuZ7DO4/sCh/9a+ZRb2NB2szj8xJe5EH5TXultKKWQbWn0F9+1vjMLEo?=
 =?us-ascii?Q?/v7tjiLsO59DyRCg+GL7xpkltv09eRsXgdQqoIxSvxUFBoU5VCNvuWlBsjxX?=
 =?us-ascii?Q?a8AMclM6cONBJRmxMrHNOQt3VXgUnEpZYR7r5GzaPbxIPdwlfVAX5afqWFtD?=
 =?us-ascii?Q?VLs+ALuPfSwZQNCaO9dMiSq3PeUkdeBGFnO7uuUUkVyoSnaIL5m63BSs6iPk?=
 =?us-ascii?Q?MJbLlsoL3UHA9XX3QMbBAy4JJsoLA/TTjCTkFOUdBsV/51BCaWNS4UKX4tVf?=
 =?us-ascii?Q?pvwdTNXrlP258RBKny3WCY9SWaSuTZ7E/Ib2hP4cwffv8NjnIE0BpQRxmCyu?=
 =?us-ascii?Q?aRATmCvU8jYdBrGAVyEU60qwo0BnA/9DF1DfrdAqJaYGmGmpbaUQBB5sXzby?=
 =?us-ascii?Q?UGIIO2NvXYuKKSfp/WSdw3Svs24VWdgKxzAhU7NGFib/Fao20tMdZfN26qZ6?=
 =?us-ascii?Q?lVzEMnoVjpmyAkfKgRq5jLOCWfzNLZfkoc6UvM5EpPcKV0Xd/MqD1a4achYu?=
 =?us-ascii?Q?jV1RyvUqn8H6Y7LrOjJly68ggLR43pYnxeN568nw54p/OTcJfs4v8wXuX8JJ?=
 =?us-ascii?Q?hhlGryOHTqYrLdmGj1kFhO1BG///rn6E773Y0F81jeOqA+q6UHOg84+OEz+n?=
 =?us-ascii?Q?8Flkl/A3IFPOgJCYznEkJQtukpnqHzear3F1CXSABWUKSohrZrPsIob6m1fY?=
 =?us-ascii?Q?z91Yg6aOkaQGnUK7AjOVE6nxk/iheGSEQLciQdRZ4AINV9Q00OfJBU6wDFZO?=
 =?us-ascii?Q?xf7xaTs+YhwpRcralXZcAe4Glb0PGegRLxgE9r+aIKlMeKXF8ZrZIr95jvni?=
 =?us-ascii?Q?idzQEzjYE7XUkLh1eN7fwHKATHaEHB7SZO11wCA62uqQC2E6YvFJeNAFL/Cy?=
 =?us-ascii?Q?E9w6mJAHnY8R1N/exaTYhXOHTQmn4kEZOWXzb1X7w4QW+u8OOAWdxhnfh45M?=
 =?us-ascii?Q?1X8w8cdQ75IiCd7Z2nNKnvcUZbbS3HGeIxgozmv6MYgfUZgS5ccMeRz4QkcA?=
 =?us-ascii?Q?9+kp72YOSr2QOhLdHUgincpTp5I0C/ZwN2s46+wKTnJ4/0mqZGnZmX4rgEQj?=
 =?us-ascii?Q?RCSTO/Lm+G+mVL3sgdWEXsEcLYzCQmzq39XM6+ScD7tGgstSY+qIzqtZqyt0?=
 =?us-ascii?Q?QhEVc4ajH3oASbjS4AvXexNLW0DWSVo62eAU3WBONdBkzMzRFn6PUEnvFXOI?=
 =?us-ascii?Q?BHkaZHOq1w52lNfuxMMsMl/JLGJ2+nNLaL5sP/avqk5sbCH/avqyPSmSOS1H?=
 =?us-ascii?Q?SzjHj0Nj6NUjeJCeGhUp0b5gPlRhbQj9HR9U+uUxWbFowhw1ELFjI3e1mjR/?=
 =?us-ascii?Q?6CxrGkvt9z4O5ClVFsEqjfDJ7Yx3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kCZM3Vmr8gBhoMgKD6dUMn1Lj106dGOG9VTfS5C2I1Gte8ftbWzpYmObkAFY?=
 =?us-ascii?Q?z3puJ8s/qbl/bt6VmBeE2WuwvSo2CJ/TBKo7SwBMpFhvHV5vFCmVMsbnZjXd?=
 =?us-ascii?Q?akr5NKcge1MAtyjX431rnvMJk7kyL90Z0Y3iyQGzvlgjhcZpcu/iJOWReGhQ?=
 =?us-ascii?Q?3CRmFHOqdDjlT8Y8QRh3T+zjcm4kc+iprK32nfOMv3pTe/TJ40FZUi3iHc7+?=
 =?us-ascii?Q?97DjsQsTCT5GgCBHmaHTZuHdxjK5kbiED53Es4q8Oajo4FTTi2f3bPhocoqu?=
 =?us-ascii?Q?P5QcyNHMNR3qsxE7JqPytnRvXNal8dB/R9egdJnajde1ZG+9GPXwJxkZTikN?=
 =?us-ascii?Q?snnO/SsF4HCKOKD5D16J6EqfUeaT4ftFJDF4VJsdO2V/ISWJe1VBKz8ZPdQh?=
 =?us-ascii?Q?aiDIsPR6qnJHu9Bpkp0R2Nzhs4AKWJ7Exgv6HQ3ukpU5SSDFolaLguJQL331?=
 =?us-ascii?Q?Y3by70U0yYRAoPy6AG/O6xSbElS0XMKxrB4a3MG/j6oQRq8LgXKR/jQGDjsD?=
 =?us-ascii?Q?4XbwSLocuc5Arjl8/rqUR7pUevOdplDjcaeOu508EsnjA6OmMU5PEdVwE6xT?=
 =?us-ascii?Q?n3WFC4mr6sYtazTLnXFcIFM+5CFc5Oz3B1GrQAQajlE6JHqL17bCjqb1d5pY?=
 =?us-ascii?Q?ulfyPIZ+D85PTyhNgYsjX6CzVk3atTTP0p72k4K4DNpLMp3EVfjA7uDX0Bll?=
 =?us-ascii?Q?LhWDTSKUrf+BB2SrdQ3nSdwMNhdKSm3rnpIqrCe+F8KL6CQrEcU9MGuMKgm6?=
 =?us-ascii?Q?V3FZ0OAAG6MraX2rmnGbSyvcBW11inoakUYXhF/oqzIEFXlZ3a1xWSUi1q5g?=
 =?us-ascii?Q?DgtT3gzgw74fZBcieL6/VYUvE6xxX2M++ABwto7a9NQAFjYSdIfpVdLQDTSw?=
 =?us-ascii?Q?/k6dBJ7UPGTyczCdXHrO17e7b8JK9OkHn2mOIE9UHZJtLz82EGr2V5qzGbFC?=
 =?us-ascii?Q?RePrtigsGvBbMoShS4aTfHqv1V8R3jpMovWQ5ucs4IJNRqhu9uHd791O4YmM?=
 =?us-ascii?Q?avdW07+D66epWkt3ThNywFg9Yqd97thJirDMIoUpNfifNh6IxrwN5wx/UbGh?=
 =?us-ascii?Q?ecfHcVI3H2QOD6E9aAInmJp7DoVEJFsI0mh8KYvl+slY7FEo4C64CEMmKKFr?=
 =?us-ascii?Q?bMyXe/ZKGGFV1ASv7CR4mqlS+aIhqmY5f5x/WaMd03HurtEd0LrULpmGPZ1t?=
 =?us-ascii?Q?cOwhI6D+hRuqs24249Vn8ybc0zGAOGoNlYkox33F8z/TN8WcarMkcEzV5QXg?=
 =?us-ascii?Q?AOzP3yPwkGnen3SHojNYA8A+Wl2TWve739ublTfdFACC27JuBkD9HTSw4NTj?=
 =?us-ascii?Q?IJIaKb2Te1TNUo5RuHW1HikG4mSYRp3FuDB+7hjY8d9WcvZtSbzD9kgb/uw0?=
 =?us-ascii?Q?0j5sKJ0bm69gDq55vEMrx0Q3udK5cTTWyvQj4JrzYtWME4+nyrdTTjCxqINJ?=
 =?us-ascii?Q?8wwQDbeiUbAwHEO2eMY6qRgr0JqOe4PyD4AO1fGj/zVlNZPixCgf3d1Z+0e2?=
 =?us-ascii?Q?QHQkZd36vaLc+XM/NVixmMorCsJYMhivO87TxHDCh5U6Lu4eDNAaAtgJP8sd?=
 =?us-ascii?Q?h+mImaBqyWVLW3RbZqqIO3lkbA91dv79cJKAezvjq41MVVlWG1x6x/rsiXPv?=
 =?us-ascii?Q?SQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d457a0d5-8c10-48b2-161e-08dd6e0d4d4f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 15:29:16.8865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BG9N8T7+6FYmj1B+1v3hRQONvFrYOlvJSMc1B7j9S5pb8/VeJCQ51jBoiRTG0vTtQkpWUolAGYnzxdQnJf/wiSrKJe/5ieojctLICUuvrqA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5994
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

On Thu, Mar 27, 2025 at 09:34:33PM +0530, Shaiq Wani wrote:
> reworked the drivers to use the common functions
> and structures from drivers/net/intel/common.
> 
> Shaiq Wani (4):
>   net/intel: align Tx queue struct field names
>   net/intel: use common Tx queue structure
>   net/intel: use common Tx entry structure
>   net/idpf: use common Tx free fn in idpf
>
Recheck-request: iol-unit-amd64-testing
