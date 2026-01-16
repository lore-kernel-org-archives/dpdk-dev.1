Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD15EC79FBC
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 14:36:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D62DC42E15;
	Fri, 16 Jan 2026 15:36:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id D2221427E2
 for <dev@dpdk.org>; Fri, 16 Jan 2026 15:36:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768574169; x=1800110169;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=T7NgRSIOX7buGDfYOA2q966+YEvYRrGg/kpdD+1VFc8=;
 b=l0jX+nVPZ/BK4JnzbkeaYWv0K0CoWeI/J00eL3fEeg0pfbaQNcaolGDl
 JMxM/YLZ1qaCTO2G7dsGbswYhCu5mpZCjTJQY0/6z7wJ4qhWZoLTIPN7o
 sMMEWYo8tvOaKnNKSXqAUNa4htraSmxnEw13gbRwV76SdsOJzzMx9VmNn
 G9qLHF0EQy4g3Lh9wdG3nxtrt+C3somh6tYsSwLM/4Hsgj6mGK1Z/lzWO
 EiCxSRB86roguGBXMsaZvP7Om1akSXDubo+Vil3xn5FO4u353w5uFQdJZ
 5I9TKMrhM4XJLzZOYQQO4b/3O+t4rzNv1CHMbyLa5lSApPqzuhrQSa2rI w==;
X-CSE-ConnectionGUID: zv4fXc7YRMGLF9sR1Z+flQ==
X-CSE-MsgGUID: esBXQwMORK6DB/FZ+JGqXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11673"; a="69090468"
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; d="scan'208";a="69090468"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jan 2026 06:36:08 -0800
X-CSE-ConnectionGUID: jtH4DRhRT12iQyJCV2FzJQ==
X-CSE-MsgGUID: 5//oWaIkTeiWWV/io5bGsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; d="scan'208";a="228269702"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jan 2026 06:36:08 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 16 Jan 2026 06:34:23 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 16 Jan 2026 06:34:23 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.35) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 16 Jan 2026 06:34:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jH1kc578I9zB2uCCZh+zV+LSDjgYV2N6wk1vHuyYt44mF94wbfB5IUDa6xAWs3xV+bqn/wdgaHRVR1uQeGq+xcHtNjDlbvSx+RijGoGqiCKiY+BRDtf63sHLEMiMVWOXC+TYOnIIvU4QWKlH85H8BHFe/HR4rc5nykUVtA7z7G0dQVBDqJY8OHIhZhGr0D1x8Vrg4rN6lRjJTEEdcIhSjtclFlQiCzdIAijCl5kytgvY3johl1WdcTq62Z4XvqiZmqkahfUFpven3JCjX3OkO6fRsSzUnbn6BS1zVW1loiX8ZT4PEEFuPVVW4jgKBRMM8bkKXEyRL1MbCgYCoWYgWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6dstwZJ8DStCLkP6b403PAPIQhfqO3ej56//eQoIoos=;
 b=frFRHDGN7o0fcMbuIJ4E0cz72fIt9Kv3cM3mhX8HtiIMMj61Zfs3xC1zBvGt2heJcZFnlOdQDfClS5iPrxwmm3ey/ra0mAkqTiLyn8IqjL4TaFtIQ9qkOr9x8eBSriWwxn//Be/aH3k1SDUPVFiGmBGBpMTslq+4L6sA/f/cdsHVqDZ3Hil5LZBMA+W4Cf7rHoEaSCyCn5B3DuUt2qInvQ3mqjiOwl1WV9SLe1iLLQr4ZyZ7lw2JFhX8D9pP1BZj/ixlDV4wvSKHN7lla+lNEJIu9YNeQxDeC2HvePA/4bjFm76/NT9txGp2XxdHlgXO2caMKOnxis2ot+3fPwhDmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS4PPF382351574.namprd11.prod.outlook.com (2603:10b6:f:fc02::1d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 14:34:04 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 14:34:02 +0000
Date: Fri, 16 Jan 2026 14:33:57 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 0/3] Ice Tx Scheduler Fixes
Message-ID: <aWpMVaShWhneOeyZ@bricha3-mobl1.ger.corp.intel.com>
References: <20260115103824.1982220-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260115103824.1982220-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZPR01CA0268.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS4PPF382351574:EE_
X-MS-Office365-Filtering-Correlation-Id: b14574e0-cda5-4043-2866-08de550c4b38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Kg757UhZQQhu5kIshykjcKrNeIrm5q4JcfNbn02bhxyrKGuvs8kfEZcZBfy/?=
 =?us-ascii?Q?QswYEmkr3GHuEAjE4CM+4ZtR1HEmUXutk4zU5viaSRIqYsqrr7Qd1eUfXfa6?=
 =?us-ascii?Q?LSphb1kgvRDOidXqGa7RvZNzOutiJONu+3RCE2vJlYebLGRit+DHdoPE5VPj?=
 =?us-ascii?Q?ab6nZCC8bfUVWaJhGHl6i3pWVCugWBtsoeTvfDCaDfQWno0lrO6J8TTRALH0?=
 =?us-ascii?Q?+cjw1ztQo48gSuc4kbjnc2ZdgCfiQilrlO+kiisnNsTi2m5ow5s2j8/DNkUw?=
 =?us-ascii?Q?WEJBV5+SvMD6i2AccggJn4AeyvNzIZqJekI3yCT5qis4BKyHiOQnos0+ISgs?=
 =?us-ascii?Q?FFyljQ+ZYUP1g9hUecvmjl99TNUkeeasO9w9yGAssDAIKBkDX8ZSM7MRYfQ6?=
 =?us-ascii?Q?01lod7rajtU/PFIM6QGePXb1DqPe/YorHUNsOseExrZ7xe3HQ3BhLH/daw24?=
 =?us-ascii?Q?JA4GqX7Do6EHYONae2AKc/FVDhqEpkXerperkSWN5+F12vDfvwjn/U8zNeeJ?=
 =?us-ascii?Q?lw47OPdUTdtMhKHXxpmPOfS+m3MAJoA12LNQSLhg1QvYJpPeMlNMlZ5YNXJy?=
 =?us-ascii?Q?TLzdj2OxctlCYINYRLJlw/OR2ex1RyyM+nKXbddvBeJh0e8kdib7dDX+69XQ?=
 =?us-ascii?Q?x03kELIN8IchGdHd2afMC47jdum1EtOgYfbt4zisQm5FCNkKhDWojIY6A1Op?=
 =?us-ascii?Q?uIyL9V0+wt/yo1057BDiXgPlv50C8M6FRXrPMxKCHwCnGnX16sibiQtTtWpL?=
 =?us-ascii?Q?i8wwQHPMNcbfB0q9EkLc6G5r+AA5xB218fZI7ByCtC51hz4MmTLkZcmZZY3N?=
 =?us-ascii?Q?WmaXkJN35/hwAU/vXmpQukpcKMq/iVQ2dEsVFelvlcbEsNTdlidOqawF6VOK?=
 =?us-ascii?Q?VR+yAJPKDzz37n6RHlni5lrwtpGAZGavtLF75U/XlRlYHnrkr5TPcoZ3Y5/4?=
 =?us-ascii?Q?TvfYYDxF+LDqKLUe+HhrhzeaJQ/Exba/61pH3VWLxYkXtp3M8/875rdDp1Ky?=
 =?us-ascii?Q?az/KuRKc9Bt3VbMM8TUGY680YPLE11XPbrNsQVdWTUTqv3ZN283iSGK+qjyo?=
 =?us-ascii?Q?BA1WF4YaH4ir/b5md1A/gqjkKvybglnDS5PBVvSdGOXDJEJAGz1IxXoclipP?=
 =?us-ascii?Q?mS+3MnNbj9f4TftRIvhVc0V06L0S/wQyV0cNJlXbmODIX+xqTT7PnkY1pRAv?=
 =?us-ascii?Q?sjZ7l3gruoKm92OuD2cVpTbuVvhA6TuuyQglLhtMzD8VE9zUTa88K2Xbe7AC?=
 =?us-ascii?Q?gplNtUQJqo9XG1ULE6AGuhdjEBLJX7ok2R/YpDUuAJeF+ObSvvkBG7+8sWWA?=
 =?us-ascii?Q?r9ZUHYL8oKVSEhbGqDiJOZ2F52mOS2Cbbz8e8ROPW84ItLwJ8S2d/8Kha6zs?=
 =?us-ascii?Q?tgPXYr1aITYuu3tQ4FCH49g0Y9Y60tDct7q6S8LoyUoL+vqPlYZI/jgfXfnU?=
 =?us-ascii?Q?wdA+3owY+IWMj8Eq0YvTjSe48+bBi+USe5r8VU4wl3c9lXaKPp6w+nsijW5j?=
 =?us-ascii?Q?NhaJsr7WNGbI95gQ0AX2/8gGp5BCnWnT4m5xvkiFs6ShE3PifGUPuzm0W/SL?=
 =?us-ascii?Q?igFo+iUx8V9UXUZI1nI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i8TgO/xeVoIPE1iQqZXOTx2HfdhSG9O2Nf6baQkRX+N/CrSiAsSbvOj87rG+?=
 =?us-ascii?Q?IcSGxwYhBTPk5UG92zPs1B2SPtK1ppCfeU6ZYWbQXySr4XLGcT4AJEWFmVy5?=
 =?us-ascii?Q?acGg/T3RwzYGU8fsdtdtvtG6HPmC9A7lHFXdlqxe8MrKBv4f3K8g2DRXigZx?=
 =?us-ascii?Q?sDvvAx+w4azUH1LN7XS75AaMY2yhhosNkBDls4027NUvsf0pvhX4BmogYppC?=
 =?us-ascii?Q?PGmY7tfeTm+ZcA3FaEx6kqJ3ixb1Y0lTqLgd+GOGdaYAnkTe14rg3wVnkf1t?=
 =?us-ascii?Q?V2DvCAOfrSJVtFPHlqU/vwDo5AmjhhHgLoVj4J92A5kaP03CmUUicvOyc6u9?=
 =?us-ascii?Q?tL+uF+jJCELLf4HHzCVD8QJmkrfjAWzy9DmPGI0Nc2l1aACX+A7Go/b3ftri?=
 =?us-ascii?Q?nJ5pV3X/Z6uobgNwDhwi+DTsZSEAoJB9/hQf4jRZHobgKwEPR/Tv+j/xPuC1?=
 =?us-ascii?Q?cMotlYrm+EhBPerm9wn8ZYDcLejkE3YuYZdNeotADtaldX1NHFA/PyvehQ3D?=
 =?us-ascii?Q?1svNv5Ue+irfdy/1XoO7eN8N6sf6PqaI21iMc5dxAiV5HmMQK4UP/CYTi1RQ?=
 =?us-ascii?Q?exVcvjA5NrtZX0w2p7sx7c8ubanUdRYtlS9bmSrFFYOYOuIl6jdmYtS3feB6?=
 =?us-ascii?Q?DwEMS3dvvS/6y/U799urUTKebluVzhgYMp820qtAikiKvJO20zCVddHY6nKN?=
 =?us-ascii?Q?1la+sac2MtkCJ1wa/9Jz3o58In+EaEmsaGUBQ6xz980LVg02nvgPEZzcjbJI?=
 =?us-ascii?Q?jLMl/Eohb7AuYXwMJwsyfEnFfih/5G3qoV5ja2c1K0F2oOsV3LuH5+shplyn?=
 =?us-ascii?Q?OcmKezkbVdBxnYH15F5m7qApx0BVERvFEyQD1dyRAlOxQq/Ow3gwl5edlVem?=
 =?us-ascii?Q?Tq9i3HEcCkapGNIFEOE5tKIRnJc3tQJOPOb2vPGs8zn5pp875prAVvvZMmsG?=
 =?us-ascii?Q?F+I4kg9CvJh+L9CoI5PG42O6ZpBRdVck0xy2V0MyQpxS5XzUr1u5PT22dx0H?=
 =?us-ascii?Q?Xj65IOPPnT8k7mU/xvLaVfY+NBy0nDQVkZ0N/KPlfp3JuLYE2JDb01n3H4ZB?=
 =?us-ascii?Q?bLAt/R5UjbL86VrnharHrl+UwvY8tKFE8Dy56DbRExzkyksslsKqOG2uvQaC?=
 =?us-ascii?Q?K7bvAfegeJW7o/4ADvbwtWBCEz1skwt6A3o6zULpKsoY324PnVKoE5mRhcgA?=
 =?us-ascii?Q?l1PPfnxNGUKF236ITkgnAKk3nFuzwJUaY2YKn1SFnalc/TXNizuzPekIvdnp?=
 =?us-ascii?Q?6pJe1ZQJswqKnaTQxQ3Nr+qG+6pOJk0xzElpmjAEy1QEyLgaXamHC+V+YY4b?=
 =?us-ascii?Q?1Ov8YtGjKEqrg/iSERJPXWtU5vE+vI7UBTFtVaYneLcy7og/Gd0H/ia32F28?=
 =?us-ascii?Q?dlf7TE6t+YvtkW0pJcGSsNI1osqjHeL8qMX1r/nqfB054dDtCYmjrRVqpi7t?=
 =?us-ascii?Q?W96550czhMbBm6ALFB94IY2D5ZuS1kpw6egzJmUjo6TbHuKwoVIiCDNv7Y0Q?=
 =?us-ascii?Q?p1xyOCk1L7tpc28guRBig+Dtn1q+lLoGdNX6J2Y0VCg/NOOQYPd5vjtWPKyI?=
 =?us-ascii?Q?2OtLEZAMX6Ha+swCjwA4LNUu9hplHx8XxzXFz2BdgqXKIAAcDJ6QEhUZv+dW?=
 =?us-ascii?Q?YKgTeF2EPFjZdnB1aNC3+/p1Lf5RAxdvggXgsGfWRh92fkfaUqdCnpvV52PV?=
 =?us-ascii?Q?V7Y4Ix9pTV9nyawQGX/vC6krSWnEIRgXQ7oUXQKv1n5fJcDMioE+Txvy6qQF?=
 =?us-ascii?Q?yJt6lPN2tbwzsue4vrn19V3Ge9fbKAA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b14574e0-cda5-4043-2866-08de550c4b38
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 14:34:02.5287 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fSdIq015kf6UN3jHrEEAe74rf/O3L5UkooOwN4Tpk1IimimVtAiooJChh1DOqyZnlmm9hHQF9wgfVTPtvqqv0ROo4vdWgYAUz9678b/eUNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF382351574
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

On Thu, Jan 15, 2026 at 10:38:20AM +0000, Ciara Loftus wrote:
> Three fixes for the ice Tx Scheduler: reenable strict priority, fix debug printing and prevent a
> potential null dereference.
> 
> Ciara Loftus (3):
>   net/ice: check for null before dereferencing
>   net/ice: fix priority mode printing in Tx scheduler dump
>   net/ice: re-enable strict priority on non-root levels
>
Series applied to dpdk-next-net-intel.

Thanks,
/Bruce 
