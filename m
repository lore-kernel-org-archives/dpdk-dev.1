Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E0BC5B552
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 10:43:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E9E040E20;
	Mon,  9 Jun 2025 12:43:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 0A65440E17
 for <dev@dpdk.org>; Mon,  9 Jun 2025 12:43:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749465836; x=1781001836;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=XPcLWI6cknb+qYZh33TS0vGsTiZr750V2xTczb7K3o4=;
 b=YGrZwJry86qU+gwvljwck9ZpZJ+JVb8fBkginQvIXH15Ct4iie2EgdZI
 1v92ay7oKquBt3tEDm9bXE0qazlg2bCGXEiz+aduxCsND20Ql74EZA7CN
 2bmdyDL9Nq8jjvz5jXG8KGx8pCn1cpfJ7KcRjVZOhOt0JqCkjRUNlI2UG
 mui8oSqLRi/2bS4SynXjKDZg7RYvTfmcV6M0pgvVvNU9OAuACGtuL9gHd
 sHKgMDCTnmYuMijI0zZoQs46LN6+CUvzrLkmeq2ayX7IeFzfzZjyqnpMw
 ZsBU+PUd3RJiSw3lVs4lxzi/JLbj6KpN2FUYCBOJlMj7NAOsmlI8W0cSW Q==;
X-CSE-ConnectionGUID: a6dHPi9XRIWA4jrKjacerQ==
X-CSE-MsgGUID: OqZ6Q733QJOvSjGeDKeKmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11458"; a="62939552"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="62939552"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 03:43:55 -0700
X-CSE-ConnectionGUID: VDwaKaJMR2+nIPSHZ20XkA==
X-CSE-MsgGUID: uXnwvadcQ6OiuFgjYiaYSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="146828307"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 03:43:54 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Jun 2025 03:43:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 9 Jun 2025 03:43:54 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.67) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 9 Jun 2025 03:43:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eWy76Yf+9GVBuKSWbFGJ4XIE6SOlcV38Sq2myX+6t6Rb1/K0ZtTPByDDmRl7HGOEoykAfyh+l1eC8LANDarz65KkXQ1wNwj6dEV2W2BAte6+nffl6F+2/I0QrXUlHpZBIOgPni/CcnG4NQwZJ25Zgs8F+ME6A+fz3kRdBcrda0P71dpLVKpbVxRGAPZMJXdfeUNLrjGGZAItNBclLdOERxlp8qlceeU4CGtMUdn+EVYdofAeE41o/NKY4lYkgdtU5WJRvraFaYiMr1h4O36/5owPpaZDcy1Z50cISi0zLMHosvbAiAYqaoZRzLOYZxbZS34mqXhbL8o6Tod4Qlt6lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uUPhI3VTd9mpjs21onb6vl0xcgzRvbJKXAGkJcnV4A=;
 b=ePFHYszsPwvGF83uzskSB/FVF18a6F8r75EEh3xBeT6mgf/9f9+SzB4npjpKQMaedR+q7eSI12007WTUAKQg3gR6eLfwHPJ/cdAMyOL/x5C5y8cRfx41f2tNfoLFnxUNRZ2RKPVk6TBt3J24AKLYVGGJSvFKO8vnH9iWbEplVm2O0fiUiuOUAJSv6BnxAHB5u6hsV2pesV2bQxnpIABmp+qYuWR/wtpCPA368eVbDCStbO5UgI/W2IZUuVNRDOUyJeUWvGP8tGVVqBaW7eG/pho7XGl0iQFpZx6m99oes+BOJyri0jA4gIZIw7aTaK6d/suEhzbFquDr3BLWTDw72A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA0PR11MB4736.namprd11.prod.outlook.com (2603:10b6:806:9f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Mon, 9 Jun
 2025 10:43:50 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8813.021; Mon, 9 Jun 2025
 10:43:50 +0000
Date: Mon, 9 Jun 2025 11:43:45 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v5 13/34] net/ixgbe: decouple scalar and vec rxq free mbufs
Message-ID: <aEa64QqzpdAgwl7g@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1749229650.git.anatoly.burakov@intel.com>
 <cover.1749229650.git.anatoly.burakov@intel.com>
 <4d611236d5fee9b9315093d889fe0a41a7c6cef2.1749229650.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4d611236d5fee9b9315093d889fe0a41a7c6cef2.1749229650.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0125.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::17) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA0PR11MB4736:EE_
X-MS-Office365-Filtering-Correlation-Id: bbee6600-e431-46cb-ae1f-08dda7428530
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qdqteVolQ8CTnzsdUL+vkYuCVe70FbuGodYt9/LFTt0NHIZOzfLJaIEqRRX4?=
 =?us-ascii?Q?xaSSkZ2zNAQN1vqs+nc5SHTFzfAadSrvqfCgs5LlA0Xh+FZuKCLl7m8JONPi?=
 =?us-ascii?Q?u5I/7pmd4S/7n0pQmlZekxvHsuwDRCzNE7zhR4Qc6nZcfoOtme96IaiU1BBF?=
 =?us-ascii?Q?8ZrETALD1cBNSGKKOtukWc+aKN5BNDp0hN/VGyG0R78KnK1P/7WMjKLbue5y?=
 =?us-ascii?Q?UocM21lJDuVRtD/E/10hANAIUyiTrEifCVQZtq0D7eKCWjymQ6PFQ7tJRxAZ?=
 =?us-ascii?Q?4Y/U+6NswWMOBGV5jgT5I9FL6i+U2Y3tCkMm7EwS++mWmcQajqxi0POaxtAc?=
 =?us-ascii?Q?gQyjgpKPfgcUISI9bFj0KH4O30OswgacyRQqZUnxNooBlnLWsjta3ghEyJI4?=
 =?us-ascii?Q?F4FGrFkxSnrSAcghDqmz/Zh3tfbbDsFJE1OaxcI+Q/HVs6B0lKxnsB46rM0Q?=
 =?us-ascii?Q?+nfxkzL7Gh+gdzI8BdEcfusoqUmlfAAtM2LO/vgKSZ3gd2Dnfmf36ugcj0wO?=
 =?us-ascii?Q?lJ6/c9n2awMU/Rua4GpCCjvsn8+dWZRzYwNrVNKmvQO9DNWFjfD5N0R7GK+u?=
 =?us-ascii?Q?tWwXarBOtgXYQA0yisFZ9+E79m1nbGc9tDokYiQsl1WcHzWhjDvOXWEEYb4m?=
 =?us-ascii?Q?26HRK+Nc/EmvRCXjyje38vxmfOOet1ZqPAcCtCA1egmWgeeRviUGgS8og1Oq?=
 =?us-ascii?Q?VjVKNfz6k6wFNQTLpeSJ6h8RrD7XUs0WoAjNJpG14kPCqZfbSLkUGQvzJAgD?=
 =?us-ascii?Q?42s4yn5o6KFRF4NLjIAj+CohjsXEGQ5uF8+zArxuBYqgw4hvsoVQxSIAm8yE?=
 =?us-ascii?Q?1k4xJt4VlQVnFUoIBI0llUn1tdr141fgjRLEo9aLVOYYb1UMYQS0zwd1yQrb?=
 =?us-ascii?Q?C9NSosPKJ6YYHZunphgGYbC64PAL7SLN6Wokz8sGdX7s8odeQoDrxspxQjpH?=
 =?us-ascii?Q?CpyrvkCGceU3kYNXk3ujqRIq8gMMlLGZqIn781wH23e6rzG3suUcnq65bcKl?=
 =?us-ascii?Q?MqLSggvJrhlCmJ3DBeXVrN168TvycdFGj1NQLywI4r9/dzb9FmyDWm2fHZ6U?=
 =?us-ascii?Q?Qmott42anEqKVn46fccM3nljyLe+uRjTZLuhkfuXMgkVxbLTQd95DGr0qe8m?=
 =?us-ascii?Q?jAGIcxqVItSmwsKzlbztsjd7SRddcltMMjeG15i5//EaIQlW79N/QbihOxlQ?=
 =?us-ascii?Q?TvDHVUzjixKMWZRAzSfSD20hp5ycW4A47EG8lZX1FlDb2UEnEUXC3t7W2PVj?=
 =?us-ascii?Q?Jykt9Bb+IH7qwbuBw34M5k058W6Myi9orbgUE47lT5lwwjTo6UgtL5GoY5Ji?=
 =?us-ascii?Q?+bMKw+CT/S71ijKWScJYTivXALIJNwuNTU+TB6nglFC7k4cO0CyUF+cQItNs?=
 =?us-ascii?Q?bmsI6HY763m0JHaEy6pM6aYpwqldOd1QfWK3pTz+H5OHfokWUA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sllirkdWxnHnJQJYWh7xLhJeDYvd7slMwyfxcSR0duma3XKWN6navtQl4/n0?=
 =?us-ascii?Q?yf3KJSKN7XQovV7dzD0FhhijtR2lx48eNi4C0+Q2IfYP5+mVsOrFitG1h+5O?=
 =?us-ascii?Q?Vz77cEr35muTAyGg3/oASvdLem6XgXqe+2e11lRk8M0ASi7dM56mHNg3FyYv?=
 =?us-ascii?Q?2F6l5uGK2gghzlhDmuCaAiavQ1S0CuvkznEQq/F8Q0muWwxXQG6t7gdZayRf?=
 =?us-ascii?Q?70yAHmnKuwnryiX5+UGTvI/1FqIjz9kJJNkGvCH/2ikC0MZuh1OEuW4jaFLF?=
 =?us-ascii?Q?vnUg95+u4GiR14V5OZW/Xw7+5i/IPDbX3d+Z9C+EUsqFcwdSDBA3ZqkVZgnh?=
 =?us-ascii?Q?S7eEH+2qflvVO/RjJ9qzJny84QF1ZR6laDjcFOPKFVbcgtR01lP+I3lhJ323?=
 =?us-ascii?Q?01x3o6EgHqqBafEdsj+2qnfShrtwYtYNpEe5GeM9bgYYBtXeSgAB7toB6Uof?=
 =?us-ascii?Q?LTipcftAiCc36diYzhxnAUyOTS6xogzvfJPEQ8wCm6eVhRg9M00o1DN1SeiC?=
 =?us-ascii?Q?SjDdepzAVlq0+jh2baVOLwAl21sY+UGR40V/4AA1BY2dDbic9QNpAX4FTcG6?=
 =?us-ascii?Q?KmunkH+/gvkH0KHwEMQHtvMcK1j7ZqlfP/DAOrD8aBdkkysY2u45zHOMZH8H?=
 =?us-ascii?Q?5C5E1iCo1egr+6ZRYcv4AwP6/6J3jVYMOjTcv4LDJDvicC9itjEtNgrLALQI?=
 =?us-ascii?Q?1hby4DXGV2G2oZwIOlo4nrTIjJaB+5izB30BQj1cLP1rDD7EiDsyoOP4tGCP?=
 =?us-ascii?Q?Iq9iSF+Q5Y25s0CeA5a79837lD+ihWNoqO2auYGbfrL+XwJ9b+sUhz35KJkM?=
 =?us-ascii?Q?1AjEu9a7ZWjNmcnZeOoau9W05bMEmZDa4+I/np+8KYRZvKcxbdiJvSlIOOt6?=
 =?us-ascii?Q?uRaEUJ5SDwXP6Mlv1FSPnie84kjXc2zrkQGosazNoKy2X4wsGWL1/srl/LlJ?=
 =?us-ascii?Q?khCsogrVzmDGswuza0NZ8MUOcwFfM5YhwrFhWNtOv69w/3xH+g2SkRCijsDf?=
 =?us-ascii?Q?xPJTBv6RFvPZVatppoZ1nRO3zNz+zkp/oJrEyrUsMiPQ6e/QGRFmbg5Q6X/M?=
 =?us-ascii?Q?k04I6ZsLpki3UTO6iZO1ItamZyehdWHcUxYv6G3RO8rq1LUcsOyRlyRaSABf?=
 =?us-ascii?Q?jKJq20oHVTWhIq8FZEjPO4inY57w+afFw4dOYASncBeeb/SJuopExGIus3+n?=
 =?us-ascii?Q?apRVe6uER7yCwEGk4BSx6XijSBKK3U++NlyfmsBzVlsZJ1psIF/o6EqGXNdj?=
 =?us-ascii?Q?bvUjq6OR0ITl1tXpVDTk1HA0Z0seuQs1gc5aNfVYUzRRIOzRE0xwBS0CraIG?=
 =?us-ascii?Q?aSXVK1NfGdWBLe1Wn1TKT9NogIX69w/c0tfQrtHxFgFvNgoV0/jjeKAF3Tz7?=
 =?us-ascii?Q?UeVDp67YpMZMhOIbxcR4QPp8Ztsg7ciBfd1XJWayy7UTWtno1+44uiNcOcvi?=
 =?us-ascii?Q?93UI1Ss8gdmcVTs3V/ivbEFUet8aqPR75ssGpIvjg0rP5TtafE+tbZqINgr4?=
 =?us-ascii?Q?fjKQ/mlS+srzH9/gDafVyXKGCu8JmlysX0CfXHMelTzzjuZ4Eqw3BqJGC7No?=
 =?us-ascii?Q?UZXkxxyEMDfI686mUbDWo7N+C90xN8ulxjkux132tgPoRCoUb1fr++fk/1R3?=
 =?us-ascii?Q?lg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bbee6600-e431-46cb-ae1f-08dda7428530
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 10:43:50.3056 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sydBOgZcHthe+Ec7Mq/z0Q1wzzLpy7ImxAoLGd7TvMxVNVegYD+6fazOIq3m42/RhCkoXBBOZhmKutgIMlhg6T9rUdv6XtIuXTQzzIR5k5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4736
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

On Fri, Jun 06, 2025 at 06:08:52PM +0100, Anatoly Burakov wrote:
> Currently, vector Rx queue release mbufs function is only called from
> inside the scalar variant. Decouple them to allow both to be defined
> separately from each other, and provide a common function that picks
> between the two when necessary.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
> 
> Notes:
>     v5:
>     - Add this commit
> 

One thought on the naming - not so sure about the "_common" suffix on the
function. Might it be better to keep the "ixgbe_rx_queue_release_mbufs"
name for the common function, and rename the scalar function to have a
"non_vec" suffix?

Either with above suggestion, or as you have it below:

Acked-by: Bruce Richardson <bruce.richardson@intel.com>


>  drivers/net/intel/ixgbe/ixgbe_rxtx.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
> index fad4a01a10..ecd1f38ac5 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
> +++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
> @@ -2970,12 +2970,6 @@ ixgbe_rx_queue_release_mbufs(struct ixgbe_rx_queue *rxq)
>  {
>  	unsigned i;
>  
> -	/* SSE Vector driver has a different way of releasing mbufs. */
> -	if (rxq->vector_rx) {
> -		ixgbe_rx_queue_release_mbufs_vec(rxq);
> -		return;
> -	}
> -
>  	if (rxq->sw_ring != NULL) {
>  		for (i = 0; i < rxq->nb_rx_desc; i++) {
>  			if (rxq->sw_ring[i].mbuf != NULL) {
> @@ -3002,11 +2996,20 @@ ixgbe_rx_queue_release_mbufs(struct ixgbe_rx_queue *rxq)
>  			}
>  }
>  
> +static void __rte_cold
> +ixgbe_rx_queue_release_mbufs_common(struct ixgbe_rx_queue *rxq)
> +{
> +	if (rxq->vector_rx)
> +		ixgbe_rx_queue_release_mbufs_vec(rxq);
> +	else
> +		ixgbe_rx_queue_release_mbufs(rxq);
> +}
> +
>  static void __rte_cold
>  ixgbe_rx_queue_release(struct ixgbe_rx_queue *rxq)
>  {
>  	if (rxq != NULL) {
> -		ixgbe_rx_queue_release_mbufs(rxq);
> +		ixgbe_rx_queue_release_mbufs_common(rxq);
>  		rte_free(rxq->sw_ring);
>  		rte_free(rxq->sw_sc_ring);
>  		rte_memzone_free(rxq->mz);
> @@ -3501,7 +3504,7 @@ ixgbe_dev_clear_queues(struct rte_eth_dev *dev)
>  		struct ixgbe_rx_queue *rxq = dev->data->rx_queues[i];
>  
>  		if (rxq != NULL) {
> -			ixgbe_rx_queue_release_mbufs(rxq);
> +			ixgbe_rx_queue_release_mbufs_common(rxq);
>  			ixgbe_reset_rx_queue(adapter, rxq);
>  			dev->data->rx_queue_state[i] = RTE_ETH_QUEUE_STATE_STOPPED;
>  		}
> @@ -5701,7 +5704,7 @@ ixgbe_dev_rx_queue_stop(struct rte_eth_dev *dev, uint16_t rx_queue_id)
>  
>  	rte_delay_us(RTE_IXGBE_WAIT_100_US);
>  
> -	ixgbe_rx_queue_release_mbufs(rxq);
> +	ixgbe_rx_queue_release_mbufs_common(rxq);
>  	ixgbe_reset_rx_queue(adapter, rxq);
>  	dev->data->rx_queue_state[rx_queue_id] = RTE_ETH_QUEUE_STATE_STOPPED;
>  
> -- 
> 2.47.1
> 
