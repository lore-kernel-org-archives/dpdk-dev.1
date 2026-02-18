Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F60E9A03E
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 10:09:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7881540395;
	Wed, 18 Feb 2026 11:09:29 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id B965B402A3
 for <dev@dpdk.org>; Wed, 18 Feb 2026 11:09:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771409368; x=1802945368;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=VjHB4n/nBQ6Uv9OmJLBW+8icWEiIgJ5vIFM3/dCYdgQ=;
 b=GEIYsg7IEEFyQ/ZJaqjJMAUOyZC1r0TNT40xZfkFr57mT/3PFQsXHhm9
 fGw72KTzTs5wX9NvaYpB6qIYudOIWgIgy783PN8oaoYTUGOAoT3z1AucM
 fjpoTi0lSmc5UytLEF6Rm+j7P1Y1eRSBR1lHJBhzlQBZ+wKn75J+TiO6g
 7XcFqGkNfMbejl+7pfuP/XzZ7G4ZCeTf97BTxaUvBQo6o1F3gwA9xQg9P
 9SVzPIO80dGun12y4Z1ak2kuGk59xr8xtnc9KRZcD/CWTjbz+kNujc35h
 QadjCtc4807TOet3bkQ0iObwzoiwmgJrJ3xF+oTQ60Gxxwx9xueItohlW g==;
X-CSE-ConnectionGUID: d5CTcVlkR5WM3Y2J9gwDag==
X-CSE-MsgGUID: qJLUhtquTICwW3kzi6fVmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="60052287"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="60052287"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 02:09:27 -0800
X-CSE-ConnectionGUID: /qMZhl2dS1u9KbTVEiL11w==
X-CSE-MsgGUID: /OfhO515TV2ND69RPWNcjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="214006309"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 02:09:27 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 02:09:26 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 18 Feb 2026 02:09:26 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.28) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 02:09:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kat+3UR6k8RvUk7cdrLbMgyWhq+FwBuzE0msj59CuQPtDOUdtcK3271EyarwI4Z73Pfn8S+SzGAsdVRxE+OowRfkcs+GIteoGJBPoJFPOZdS90eiRZ//Ey3vQi/I7sP/ejo2LeV072FeX7VJUyhy/Fsh4Jy5mDrZ5MNrzJ7mNC+6GJ9nBmkijhnifJjoXzgjKP2vCkT4QFHw5DEVIwcNFYK2lcVfRZlAu5dQOJ2E7t5U9w/p6OokCHlj5pjeFZl0Bvo/8DlyDGG+O3gzTcDC+CuKGWvkSecJds7lMOTJZD6M/zPu6fuMUxuVarcQXojkESJGYq6Ed3NqhvJxUpIFMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RgyHQCTOp6Ki+JnF9bf12HAohVK8OQW++Y6RPADs6PU=;
 b=kutCpwZPA75neNEgxsOreSrCZu6mQRVIluEye7yhPVZhXghmuPd19daSai2tJLxflvPX1BIl/Pf+68RgTF97LeWTf0X8ukaFrjLtMx9AaaKEUfzDB7MTZn8OkmBxEjU6/UTkQZSS0VNv8kAQoJfRefsC6DkghIjsvzf9vz3l0s83izoqdMjUKfL1kG/E1XdbA/ZeCFd5xfTsc4xDHOhDcbS6iJY0ySxunviqvv5PGAWJcTFLoyOyWq1Ym1s5J7n0VupDOivyrlz/TR6JT1W0gge7dJFV2QFUY2X44eJOZ1y0dQITut+DHMRJwhEULFq84qKQ7bb257qyIUJIIWNkVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB5818.namprd11.prod.outlook.com (2603:10b6:510:132::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 18 Feb
 2026 10:09:24 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 10:09:24 +0000
Date: Wed, 18 Feb 2026 10:09:19 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 10/10] net/cpfl: permit secondary process Tx path
 selection
Message-ID: <aZWPzwOqXALbzhR7@bricha3-mobl1.ger.corp.intel.com>
References: <20260205124627.371733-1-ciara.loftus@intel.com>
 <20260218094937.1652391-1-ciara.loftus@intel.com>
 <20260218094937.1652391-11-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260218094937.1652391-11-ciara.loftus@intel.com>
X-ClientProxiedBy: DU7PR01CA0030.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB5818:EE_
X-MS-Office365-Filtering-Correlation-Id: 92c3317d-42d6-427f-c2b5-08de6ed5cad7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yz7dgq06fNN0BXAvZcTnwN0g3EnV3pj9FbclCTAfETwgIVFyrcNwUX6JbUdc?=
 =?us-ascii?Q?c/L1pcf31OXS0XxGWVMOyMDoIgJMcJDeD86ywLoNdaDQu0lkS/olpB5qczUA?=
 =?us-ascii?Q?ojxyZY79vuDPPxCAtBLdVj6ogbvZn/XBFwa34Hd9Fc+et5xoyQjIlT8ZTigS?=
 =?us-ascii?Q?C/BBNRDSS1/T2MlzOIo674j81tUjTEKyYMghDDYBfGtrz+/15IXjTpkFZZDw?=
 =?us-ascii?Q?KyiMrji4HoCJVTEVFZJQyv5kKfw/1QR7k5cIyTvABK4HQnS/eArSiuKdOpO0?=
 =?us-ascii?Q?Xji+O2mTv8ITQqJWAjFNMIw333dlrjMeZ2YzVzMyNoix3h5BRZdt+YLacs5g?=
 =?us-ascii?Q?oZDRTS/3RH+YjDxk65UOiPeMvH08ptZ1AorFYlAHM5Bi5EjVh2DgKY53S4zj?=
 =?us-ascii?Q?9MWnq+XPNEEdjxAV8ToqjQ0s8w0M7DONj+G05EyOLImzoJmIhncwmTY10sd3?=
 =?us-ascii?Q?+a7YgxSo+lGcgkL2Ff4yzkCn/XVkBanP1AZ929U0aexwneVQllfp1i7KVH7D?=
 =?us-ascii?Q?YVYh9olBqp8BNcQPr7LEy/8rG5z8vTBow5IYirj7BzdSwOOLJnStKpNfuazR?=
 =?us-ascii?Q?X5JYrt7GSonN9RgLTdkvNgaljHPUGhBwI4E9zIBaMcqw74+ACdOtdSjheWuC?=
 =?us-ascii?Q?rwAm0Ne/m9Ija7C6WmvOEhOrt4Ckb692moGYjDtEbrgxqF0NkYa68WkDdo08?=
 =?us-ascii?Q?R0uKGPo9j5nfMbKGHmBfjMPur+12OWECxKdb8YXgRvYSTWZ9qu6eKzQ6/pTo?=
 =?us-ascii?Q?qRh/joaJ6J1GpwnwegwvFYoaibvB49Ef2V+FFJaJb4EPWOgbGXXc0+YSY7P/?=
 =?us-ascii?Q?pCTeE0mJnspjGjZHiiHocRPZu29kLsi9/AVbnem4AlVk49pg+8UbrjPffckH?=
 =?us-ascii?Q?4lJRpY4AfKKTXze9XfezejheZ/sb2G5uXt78PoZGgsu3Jljd5d1/JaUr8TU+?=
 =?us-ascii?Q?OGLbFIEEAAsdssmwsgSqklHwi4dz3B34BDUj7lc7m71MBEKztO2471M0PltN?=
 =?us-ascii?Q?77gab6B502LRQFQC0bY5Wk69QBwP+BnzM7wQgcXrGhek1qlkoNmhIitNZlmA?=
 =?us-ascii?Q?rO6UuXVNdkw1KvfdfPAIco/U8AoZlu4riouRbJQoAlCEmbY0ecBqUDe/QvjQ?=
 =?us-ascii?Q?6a097KIk16thTcD+/FoU/yvG8LGrAR+yXJosT6twDthPN1W8UOz9uXPpZ0ly?=
 =?us-ascii?Q?blFq+/ezPfGsRthrwBTnn4Ka2Gc0ooDOsyCB6jDjK+m10Li7IOdpbJJWIHog?=
 =?us-ascii?Q?bUGtHsA4WVMDg1v1Ph6hEv51H96EQBbtxd3ZZQSd0GWlEvm/i7LrS+gCMlbQ?=
 =?us-ascii?Q?M6EU+4H4YfaZYI0g2CeUmfw1G3+u8SqKMCMEzZfWQ+Q3LkvYNFRlAZxk47YR?=
 =?us-ascii?Q?2BNx7/83+plix6y9hh+Ep2GAI8R9CiaeTKKclo9lotkFDHq2dUcVXume/9IS?=
 =?us-ascii?Q?/IGVjxM11x3WFGS1ILy61Kffc3wrWqEq19hXsBOBd0XmmBVaxFnaMrKWhqO3?=
 =?us-ascii?Q?7by8qHrBfMIpiTbk4Ktw5CmngnILnN7+3JCVUDDMIUv75M04PR9eQKriIZr5?=
 =?us-ascii?Q?xLvIPBVsisSHLKFF5Eg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q/X1vATy9HRE9dfeXLuy1PKoAZBgZGAhNzDeeM8J45tvw0/5sCqU5YV2BhsA?=
 =?us-ascii?Q?2HDAlWbaZI4sKgBSetdqsef4ryxwWlakM7+ZYgor5TBHtAIHRwu5+/mw273x?=
 =?us-ascii?Q?YPOAoPwL5sXYQLFWTOrU4Bm9YLfCFZSXRG99NGNAOFir303rVT+78/u3OUDZ?=
 =?us-ascii?Q?gNB76oGNP/H2rD1mohfAqVS+zM/Q45PGjfaVutJ/g9kZ1CkCMej8p2NFOdR4?=
 =?us-ascii?Q?p6CFwXAwRGhhvpATxneuvExAr7+iIQsPbOmD21hHl4IujjQawi9vyP7a8EJ8?=
 =?us-ascii?Q?1S2ZYJEEqFspl/3v0PYiI+pX/w2nRDLMGQk+HrzbIQ0tFn91OpSedxxNu0gU?=
 =?us-ascii?Q?DljYc9sUvEKV0l0+TWc3qduHzpufeouVrxg3dzzGWJ7ZQR2oMG3nsizD0uL4?=
 =?us-ascii?Q?mOhoPOxT4rdYk8s7EeGTI7Mvp49HUYjf3FxbA9P+UJ3KDH7b5DoNb0MB4K2v?=
 =?us-ascii?Q?h9rWmcGlQuos1RSDM3KV92Bs4qyQa52wTMqiOt4lOplUXuQ0YIoDAjyXiH8q?=
 =?us-ascii?Q?r1dXw+IQ/ZnBi9izqArAcEkVas/j91Jhyx/KT7CVKvPOT/8NXm0z3KpaZ3EH?=
 =?us-ascii?Q?Jgt1EJ0DMNlAdRTsG12egCYs5DIjAjA6A/m01/uHUnZwyzix0AcuO4hkwmRN?=
 =?us-ascii?Q?e8YYpeTm4oReTtjINVgp1aYM+l7S3jHmPwgjHjhiOsT9TlV7ONQ7G5+Pjc/r?=
 =?us-ascii?Q?uodtynAUwNY/8ZBSnfg7orYXC/cSRPvoEGU+MxKgVOpjk3vSxbALens9I+q8?=
 =?us-ascii?Q?kAs2L77OnL3JEl0eIJa1T9b/xQhtVtxeQVYEix3PkxV1hoV41bYsU8/6A7Su?=
 =?us-ascii?Q?dmUGYwVHuA0D4PrrPPX063q1YZxpqaOdsPJT3cd9JfV9SaNiVTsD1Iryh38m?=
 =?us-ascii?Q?CJ7r41MKmMrx8sm7u98pdQxBWYbXFtXklSKzhSoHnt4knsGuYF5pJWn686W8?=
 =?us-ascii?Q?dfYyO4GS6jfwSiajb2vK63u5fELKa09xiCtoR+KN0auMPDNJB93sVpubgyEX?=
 =?us-ascii?Q?39VHhiFeXTIuuDp38Xr7u0+v2qd+WKQALwANVlqyiD7ccItkmDNCAeHoA19W?=
 =?us-ascii?Q?rg9mkXrsGYonh+fhPyJxwJLYrijXy0d9UhBmLcPLDt2IW9ppQmgFgsO6soBp?=
 =?us-ascii?Q?GDL+n1yh6YrdAux8f5WcY7Zn2C4shOynFSsRWKfMdrsoKUz91PTgzirenfap?=
 =?us-ascii?Q?wq9WnnOlht76NqAgMuZ36oitz+pBbrOsgtaAAJCyo/Ojx+j0IT392zmLR77l?=
 =?us-ascii?Q?HAQ0l15i6YSu5YRYSAPDdKv1k2c+SKhCLwSUInYmZKrOFEvdN95Sg3wQF8mQ?=
 =?us-ascii?Q?69QCXLM5EkQItNlV07HhIUhL5gANLfu2YiZvUM02HLOKYuX9u/fJgpcXYc+3?=
 =?us-ascii?Q?Xkz0Mg5DUc0sZIvUTAIMsYzOM4M7kdpq002VrHoJfeXGZj0+Ir6zsLub+0UG?=
 =?us-ascii?Q?cN+xtJboNSYssm2lUs+yq6Fsi9ZYtOQ/vYGw/9rcI/QDWI+PQiHaS/huC6QM?=
 =?us-ascii?Q?pScks7+rAxAYykNPqp03VkJveBfWdDaj231hgNzheMk3CXZ5adyxb9RunNB8?=
 =?us-ascii?Q?FEawp2CR59JMI8WyTKiZmPKDjyATlk9Z6JRL2W10EOwjpn6TZ24mz94earzH?=
 =?us-ascii?Q?DSENdW2YjyQDXoHlQlkHxaNLRkHgbaEX1i5pCmlZYlH9Npdyca0YRuJgTvpW?=
 =?us-ascii?Q?q38pnxFwGnt1IA2XWNbKUnIhHXJsGYeFghCczRVUeqrmayN47HAI7OJ5SH2G?=
 =?us-ascii?Q?rkDV548gsRrGyXz8NJ6str0BfIgQ7dw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c3317d-42d6-427f-c2b5-08de6ed5cad7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 10:09:24.4769 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NoTcK25XpxJcuziHhMNdwvJHlUujg89g9DwXqEev4ITm2aCSaXdXujJ7aD4wTGCuSoKjebaN9z2jwhQEM8Yfs95ZCkttKxLgpWv8qHtyf44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5818
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

On Wed, Feb 18, 2026 at 09:49:37AM +0000, Ciara Loftus wrote:
> Commit 6970745698b9 ("net/cpfl: use common Tx path selection
> infrastructure") changed the way that secondary processes selected their
> Tx burst function. Instead of letting secondary processes select their
> own function, they now used the function selected by the primary
> process. However, the primary process only selects the function at
> device start, so if the primary process hadn't started the device by the
> time the secondary process was selecting its Tx burst function, the
> secondary process would not select the correct function.
> 
> This commit addresses this issue by allowing the secondary process to
> select the path if the device has not been started yet.
> 
> Fixes: 6970745698b9 ("net/cpfl: use common Tx path selection infrastructure")
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
