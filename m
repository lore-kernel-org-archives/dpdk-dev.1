Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D960C36010
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Apr 2025 09:51:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C9EBD40156;
	Mon,  7 Apr 2025 11:51:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id D3D7E40150
 for <dev@dpdk.org>; Mon,  7 Apr 2025 11:51:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744019513; x=1775555513;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=88YS2BPE/m01eGq1SSioq81v0a6Jeq8H1njBK2dLplU=;
 b=Ans1poAbO4nMcfyoulojHBCYfT4agv89vq9qUlCcjs53eikkbPZTc0nY
 htP3xbUOqijHl/KsU+CNC6DWkgZ3xJMef8lXlC6iwAgQ04kJche0BMuU4
 MpVL+S+jUd/GdBkr4B+/2SkjNVtjA35KgY3WbJgO5s49ANBrKyaCHXMsU
 I7NvYwltvvQXC8HGIHSb4wd9x2XI+TZQdg+Jf3L0WU9euiesaAAOxVs7O
 uZe8/X1+/2xlGWOMayK9d6igOvHwB7jan+Qbm6efvbZk3urrzUmO+LplV
 /i8gsyVU+c8ban7bZaWFVnCz2f4xDOcwyiB1aRaWPY8ivJE1Cy0HwzuS4 Q==;
X-CSE-ConnectionGUID: B+BmMl3qQiOdHrmeRk5sBw==
X-CSE-MsgGUID: zVuZ5x9DTZ2/269N6kIzbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11396"; a="45109879"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="45109879"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 02:51:49 -0700
X-CSE-ConnectionGUID: Jl1U9XbZR3uxRr2W/LzgSw==
X-CSE-MsgGUID: mUVVxJkIQIOm51XFfP8SbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="133059464"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 07 Apr 2025 02:51:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 7 Apr 2025 02:51:43 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 7 Apr 2025 02:51:43 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 7 Apr 2025 02:51:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KoFizrfSGPmWSFksZB2e+nHo00BYE951vGGBFmmMCGuZjiyYXNYev0AlLAzb4podge7HJpZYCanAIPs9EWPf5PHzaoNTCfd8P+eIG2Oulk9B7mU4p2mz8O/ROlDyGs7MNPmhwGPcoKdaEupM1qQsMa4jZFKNodDx6ZwxVCUs9DtYk8fmLkkHvxul3YoLdNW3bZfDfsB9FAfnaXKv06z0WOA3UcFGdYeInJNr1Mu12XzrMASDs2pX05G/cNQKG1Qyl25dyxKxhdSGERMJPQkuoEXAO2qQQKt+2KzbIOYfyduj1oc/tsCd5/o9b9ExkdYk1DgoaUtHN5bUcgxD1Bmynw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5UUOlTvmwMH6QW+IfJjydh+jDtaHBtcfu4oGCREvfh0=;
 b=rV1N42qkSkMCOMp9UYnnJ4y3/4DhJGqutKY1HDrsAArvRKMVuIdgvn7PxegZA5QpdVCAIDCk3cMfKc7RCFcJKk8R8xVvIvNiyrjBAh/j8TI1vHG8v0+/Ggr3qzB5+o23WwDbx+B+gc5B7jfIkcZWnJ7Fx8x0CItp53HrVMiw/MehBGF5/HOSsnu9Di0uT8PpWqJmUEH+cXmf+vZXKR9nQHx6YVWV4qR1HPh17EBNiaj1S2kJInK2RYF9U5P0yPdzRp1GOaxOpCPcDx1JZv6aspO2cnxUddKwxMhj31r14TN9SF8He7O+d8YN4dfa13OXdpGJpxiKPv8fmehj/wZysA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB8832.namprd11.prod.outlook.com (2603:10b6:208:59a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 09:51:41 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%6]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 09:51:41 +0000
Date: Mon, 7 Apr 2025 10:51:37 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] net/pcap: fix indentation and numa node
Message-ID: <Z_OgKaEXuxqWALbm@bricha3-mobl1.ger.corp.intel.com>
References: <20250405153623.200771-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250405153623.200771-1-stephen@networkplumber.org>
X-ClientProxiedBy: DU7P250CA0001.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::23) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB8832:EE_
X-MS-Office365-Filtering-Correlation-Id: f759e7c7-84e7-4544-f44a-08dd75b9cc5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?za/yh0qJ0rdYTHUA8QuwnoU17NjEGdV5lifGl88oWgRhD7oZPLSd0HjKA2qW?=
 =?us-ascii?Q?Kk9VKu3zG+4OJTaE9DcjR3HYds5+zCXDezVFTy0XaWUkppJ67XkC4Huw3OWG?=
 =?us-ascii?Q?1J/0CScSU4DrZwsa0zmyL/2W+Tsbc1+k24aX4arMNrYmSOSQvyecG6iyy0SR?=
 =?us-ascii?Q?COrjU+7Pl01cQmjvYmdNy+aVIbMNpX3tOAXzIs5qQ2ZgyS/ebT9o3qNYBK8X?=
 =?us-ascii?Q?4nJNIQgf1qnLJuM5mpATbvhERS8jybL8D/TEivRoFGGAtI98iRwQ7dFGw5dd?=
 =?us-ascii?Q?SeegRuvdD4WSKhqLBKBEYB0kuogekAH58lnZe98uMrG3zGdKnOpaSVQOzuc8?=
 =?us-ascii?Q?tWOZ4K1ej8Leq2Xq8RY54uBVqoVjsMjlmLx4M30sTcTVCuzPn8PFelWDXYB1?=
 =?us-ascii?Q?zQAHw077MsM//1ITwRHcl6hAOCICyqucZCyizcR/2j5tGd5w8AVROKyzOxkF?=
 =?us-ascii?Q?m9UT79G65N92X/XeYd5ThDc63PPK7DouUIbOpWjqw0lZaEqdpQkpjVcLjZsI?=
 =?us-ascii?Q?pbq0lTKprRPDdwp1nltMpoTNF9/QTs5bzz2G7evkRVneodp03wmmBP71YN7m?=
 =?us-ascii?Q?JxSv9xrNBKi4wH0f183hi4ud3RoF/cqkY4jojppSREuLtcU15l+y2GMS3tXd?=
 =?us-ascii?Q?aESuUge3kgjYwo+b8g47rXsvqfdAluawzxSraiYmDL8HK1UsQjFAkn5q19Po?=
 =?us-ascii?Q?yBT4vjLWbgKhtuTeNmdFUO4ruRqf9iMf3sfSgCmclXCSEUNkH+3QBudPTWIu?=
 =?us-ascii?Q?QC2N80CNeOQHaADkc7cjdbliGESs6I9f57o+PqZCkLVq+ZvQmKzO0cv2O8xf?=
 =?us-ascii?Q?PZ5zV7HasIhwcpWj4ua5JwK5mQh1uUpETI1fQPw4juJSBm8fQ1s1ouKFZ+dJ?=
 =?us-ascii?Q?n8T1duEjtKCqfCSVTCvxdn69fDmppC4yZQonlXarzUYnzo2eeBcDOHaveDNx?=
 =?us-ascii?Q?PscVMycpYcmNPI7JCdUFazoVMioDIFSaad+OicTt9+AhC6Hm1NDQpCEgAwWA?=
 =?us-ascii?Q?sizkEr0GAmsFQiZvwzjPzuV+w5akhqJyvjJjJRorhxNI7CgT/akAHbV8w+3p?=
 =?us-ascii?Q?3YZORBAzkd5jnL+tOWiB3snAg154+6AXkgFihCLz6O2RMG9ooqQ1MVXw99uF?=
 =?us-ascii?Q?5xVm6PmMeRwtJ17tPivXWO9/A5rJpIBDv0oulqBucGKVJvpnS5j7fYI6lOd/?=
 =?us-ascii?Q?ypxk7o7SWexBJVJtJ/q6n49s5c8ngP5h6GDS57/uPgY1cQzEqQZPNbpgRUA4?=
 =?us-ascii?Q?kRNdVRfrtCnulWDo0xSAZOvWrEj/zrhjP5CpgWXCSCa+x6yHh5ER2IOJre3Q?=
 =?us-ascii?Q?Bu54vK7VV7KT4v/TGaMD9fuUB5etd/YfYQFj/nq+nGoM9l/B+MI5fCf2gBYI?=
 =?us-ascii?Q?2c4Mj8iot/CSNr7o1CknlyFvbgEnflNcf6Gh7Rjcjwe2xp7WRRSg7spyhCZ4?=
 =?us-ascii?Q?4RrCCO/gY7o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RVlMo0wEDCV7dWDy3Zvr9ZRd77URqHg3NmgzkUTCjNJpZWgBT3vnil6wW8mL?=
 =?us-ascii?Q?MvDgxjBgyoDyldjxstiaXzi2a+owHl490GtVcrys5MpzBT8pmkZ7sQb9UJuK?=
 =?us-ascii?Q?Ja7+4oX9CcOFpdudET++WRPTB7kbpuPOyjntEf9R8LUD7SHwnkim4GGms7e6?=
 =?us-ascii?Q?VRN0EqeutvWCxnH8mu1VELfYpds83UVqLo+uCiKpErhD9IyIvUio82sT6Op5?=
 =?us-ascii?Q?cgI2vw3RlUPWQwE7krJL1jQuj0IpEtm0nmmw7oOBhphqLWJ+FIDMz0TxPYQF?=
 =?us-ascii?Q?vOqEJQhU0DUXZbP3EEbPxgB15iDcyE9a9gdCq7GfxMTx1mlmcc7TS2adrH9D?=
 =?us-ascii?Q?sI+Hq8Qoj+HIDVBw/j5cQapcLfWdR92UscdvCm/tfQjgh/lb36/dWG392Ddw?=
 =?us-ascii?Q?Q5+2TqvelOrS7LhfnLjvB6b3fLv1IRX2hv+5mVnIStZhSW7rYXzr3SQKsKsC?=
 =?us-ascii?Q?auM5eb/Z2MtjB3WekcgCqfkUN+RscA+8gKTQTFX527+eDexEUkA+Wm7QiSPZ?=
 =?us-ascii?Q?DkoCrRD3ijXxR6z+UD5vqnKgh6qbNU5k0KX2JMHgApDMdo3QqBzYxXIsQMQj?=
 =?us-ascii?Q?K1hH24M3k6x4F91AZWIzbLsmPtIoOsRG9XZoB3aXBcR4CUJ26Tw1yB4hEyLK?=
 =?us-ascii?Q?Ty36sM/+sZLIwYsrFH56IDEh57qf8+z1FMWXTU7F6fs47V9hJkaq1UuMVxvf?=
 =?us-ascii?Q?DGShQUaoWLx+4KBeyMy6Hu40GdiF+HnozNN3LRFtVgDlO6zbzRrVoVnC8qde?=
 =?us-ascii?Q?u0UrUAJ0k5XWnvlD7ysimOnZAdi1URuLHkh3sgG/U4Iv/rnmBZx478sOReAg?=
 =?us-ascii?Q?p/vb6cUffqCfRvoWi642aJ2IFF3bR6MDYWtFivJu/PdtZHZkekDTnNdJV2KQ?=
 =?us-ascii?Q?EL/Qd20veQuZJ+74rG6NC3AnCkkq14feeoQ9MBfLLCSMpk03Y5rSEhIQxYD6?=
 =?us-ascii?Q?G5f4tyGc2qJHlUQJH4XWWmXH3tDwTpAKTg4XoFm1EONz2EJGiS/UISxJC7Ns?=
 =?us-ascii?Q?UuzC0acEt3DfQneQ/YU1NxjMy9QvJcHUu2LyUJekNQzizpZlX5LKMZ3DWKd5?=
 =?us-ascii?Q?P4xpQbWRC4gTn0Wu5wgpBBzubimEIRrqlV/goHcCC7BMkKYdiA2u+2HpHhg2?=
 =?us-ascii?Q?NZRN2A5GB4cgGfXxtiI7zYWIjs/+0OcdCV8hRAXG7x+y9L0RqAgYeLgFeYoK?=
 =?us-ascii?Q?MITW+wgo8njUAUrlDy7PnSduDJ32N/NknvIvF5ksBTFWzi1P9TxKCQBFpjJW?=
 =?us-ascii?Q?qbQFFDVDTyZskUuYy+CKGEF8Vg1gOTKg7ivEq9ZY8sQMwE9GcobJ0u3jlH32?=
 =?us-ascii?Q?0UxiU9R93huAPaPtjRyDZuU9S5SqrI7RcDN2+lcGOFHe3iBWAqqWV0gyZYsp?=
 =?us-ascii?Q?YwqO0f4VnkeiHhSYPFrzlVz9HvqfHG0otCqhOXQEqjwpiRP08pku/85FFtOy?=
 =?us-ascii?Q?9rjLLeiZ8jtsVxoM3LJZPIN8bkyc+tGz2XKt9AwBb09Aygt9eKbZiFidGwRz?=
 =?us-ascii?Q?Ez4W10fqU9aZKr8cYTC8oP/1riq0CISZ9yZ2gilHkeqWEcEFj7LhFkdRTTEQ?=
 =?us-ascii?Q?snv0gZpIOjDqmfsMHUZ6prRVuuxwQtmZAjFh5m9SzwKCrKoKmr5eAKwABYjm?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f759e7c7-84e7-4544-f44a-08dd75b9cc5b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 09:51:41.6412 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X2sC9iBz150gjpgq2AOST3Il5OT3gY48cZN5f+n3K0roz13hD6qrd0BXqqKm41PYSJVnO0xUIyqIgrMHW/d4nPNqgsXxUIi7uFgAwYmGsz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8832
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

On Sat, Apr 05, 2025 at 08:36:23AM -0700, Stephen Hemminger wrote:
> The process private data allocation was indented incorrectly
> in the source code, and had unnecessary cast. It is better
> that the data be allocated on same numa node as the device
> structure.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/net/pcap/pcap_ethdev.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
> index 728ef85d53..aefa74c7be 100644
> --- a/drivers/net/pcap/pcap_ethdev.c
> +++ b/drivers/net/pcap/pcap_ethdev.c
> @@ -1208,10 +1208,8 @@ pmd_init_internals(struct rte_vdev_device *vdev,
>  	PMD_LOG(INFO, "Creating pcap-backed ethdev on numa socket %d",
>  		numa_node);
>  
> -	pp = (struct pmd_process_private *)
> -		rte_zmalloc(NULL, sizeof(struct pmd_process_private),
> -				RTE_CACHE_LINE_SIZE);
> -
> +	pp = rte_zmalloc_socket(NULL, sizeof(struct pmd_process_private),
> +				RTE_CACHE_LINE_SIZE, numa_node);
>  	if (pp == NULL) {
>  		PMD_LOG(ERR,
>  			"Failed to allocate memory for process private");

My concern there is that by forcing the numa node parameter, you are going
to make it impossible to run with memory on the "wrong" numa node.
Admittedly, this is less of a problem with virtual devices like pcap, than
physical ones, but I still wonder if, on error, you should fallback to a
regular "rte_malloc" call to allow the allocation to succeed so long as
there is some hugepage memory available somewhere.

/Bruce
