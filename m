Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465A6C3ABDD
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 May 2025 16:32:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 783A8402DC;
	Wed, 14 May 2025 18:32:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 77432402C8
 for <dev@dpdk.org>; Wed, 14 May 2025 18:32:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747240375; x=1778776375;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=/OTxH1dU92li+jVM6BNvag4RBfdcfmDc213VmvMI0xo=;
 b=gq/drhuzVDhJo+9SGs1vGu9/JaQf1hQ05J8q6QzhM8fDYbVNwbU7b0zO
 l3bBkwlMMzkgCjnVNiS/buYqUdAZXZ9NJXkywnbO4yJ5CpPY5JJQdf72n
 4kUhH3Mhp5KS6zVnNkGXAOl/WD3eb3Q2JLBJcc01qqhu3TwXesWqIPG78
 A6OPBBmx+GHEpkHJM5nkyztwIjw6BPfChpVAAHJhietnp3qkRCbEJI7U/
 9kDJnXhlKGkkFz8OcdzLkghd12XlgYiQPimVFTP/NyNSKoZBNwXMTZGIp
 Qlsm3OQyYQKkNwv9pcw/i1KM/S0CVy/n3YUbACqxpmpyMEqtHeiSIFiuq Q==;
X-CSE-ConnectionGUID: gK/lNKaUQZGG6pB0kdoPsw==
X-CSE-MsgGUID: FlampqyUQ16dM3o58mh/Dw==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="48260820"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; d="scan'208";a="48260820"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2025 09:32:52 -0700
X-CSE-ConnectionGUID: GxQSn6uHRkSH9hE6HPHf0Q==
X-CSE-MsgGUID: 6dIf/igyRYC+vOQJFXYGMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; d="scan'208";a="138151996"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2025 09:32:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 14 May 2025 09:32:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 14 May 2025 09:32:13 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 14 May 2025 09:32:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TjG8GWDHdMbSCrMXCNxz0TgORjxWmdz8B+8+lizv81c/+MO7GuAi7Q+TsLGfI4kPhf+DzGB4nH3t2+QwUThPdtD8ismYkfzDJKGLNMRAxXkrHTn3+jPOI3YHo5ViZltzJng2OkgSGDYitrt2n9URC1gLn9BvzdaRAXfEYUjLvVzDTaKUmukslLzi57l/i1JE6MJfZlH77RF406P1aDALrLJj0X7JrtJh7Kcc9sUw6m0s0A9cG7B/H2iznPgB9+BrrWG9ueT+1w/y4frCfUoQkGi1nKAiq2QziD4sOWcwkP8VFN7wHL9tll9znnOyprXBTpdnIS3sK8awL6CZq3XgYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxlLtiC4xE6Z35OpSRKeN+C1Ge5ZYIjB9TIU0EEFAMU=;
 b=ccpmBMnV4kqN1PNKU/yiZ+o/gjuRfz3onjhG/dhZZgxaOQPbDX7cw8ovwal2uzFEKrl8qiKz4wyxJw0JpZQcUiWvrJm4AH7qqe2EOZ8d0AwNVwgrdEHVQM02pt8n49neF1Eic8ww5Jpys2peQtZEofcg3ilefyJGV+gSju+PRVJD6PP3SQ46me3L3Dn0+suynfowTiJiGRMi7kezpxKXvVLSFcB802THcfgGc/m8/v6hfnEseUu1kGe3ZiseUlNP8mozbf7wt2EqHXn9rIVLE1A7AvQDwtP3k/P2rZtzg4sYxOOnx7nm3Q8hfIwB27VlSc0rvdQN1TDi4WRN8lxAKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by CYYPR11MB8388.namprd11.prod.outlook.com (2603:10b6:930:c2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 16:32:11 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971%5]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 16:32:11 +0000
Date: Wed, 14 May 2025 17:32:05 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v3 01/13] net/ixgbe: remove unused field in Rx queue struct
Message-ID: <aCTFhfkYJUbYALMm@bricha3-mobl1.ger.corp.intel.com>
References: <c92131e8fcce1901018450bdf97ae004253addf7.1746538072.git.anatoly.burakov@intel.com>
 <afcd4013458bdb8b970e7ed57d6a1ede0ee654b8.1747054471.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <afcd4013458bdb8b970e7ed57d6a1ede0ee654b8.1747054471.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0070.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::9) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|CYYPR11MB8388:EE_
X-MS-Office365-Filtering-Correlation-Id: 7498cac5-fe2b-4b83-f56d-08dd9304e03d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IgkkFut8LLYbM5TUiccEDEGoY1F99D6v+Keg4BOqUKm6zIxB/p5U7gzwxqjI?=
 =?us-ascii?Q?vTjTiRc80I4H89AjpKcb94uyrDB69zsByk0fChiZo4eeecKBj5I72XmTZyIV?=
 =?us-ascii?Q?Q/kCWwuUAeC052cjzIVXmixij4bjcefTDegphYNjHlnFZFXCV7hKuDVBV9SL?=
 =?us-ascii?Q?DXEhcUrhdm7P1a4TdU0MyZicM1e5+BA0XjqzX4LhcO2kPUuqKHi2vGL53Ny/?=
 =?us-ascii?Q?js9DIALqRZJLXmUUDFnMECQ7y8Pv1xPyxGLpJON5pMuwfrzlYy023pt4BVDL?=
 =?us-ascii?Q?l2qDtdE7K9R3VMK9vr2tzW5sLUxpbFspOvjH5l4V7LaY3hlKG0lA0mcnyOnS?=
 =?us-ascii?Q?v0Nh2qochu2sp6940bdh7utnIUN7BdhoNI1TJFj7FN4g9bo8G+jbjiTy3TjD?=
 =?us-ascii?Q?/xY/43BF7+JWopxNIxIRTAK+AcdBKxmrkO6LG7XDFWa9xraDnaPdV6ePWRh7?=
 =?us-ascii?Q?VxTujrs2X/detODcea8p9qlOG0YWvZJFAYV4sBuyet7ruB+vkdEn4Aoc6Q2g?=
 =?us-ascii?Q?a6FDB1unvlrWe6R52LruJvAsswiivizmQGMuRBBLM8hZVX2QS62x5c1Y7TmS?=
 =?us-ascii?Q?vf5/aF329cEYzAUu8Qmkl27my+YtOCgjgUsYEcftUxZLTdFZHZ7dVzCEdjyv?=
 =?us-ascii?Q?kRRTxgmyvw6GyLxFm+t2WxTnwNKQtbisPClrNlQ9O9ittHEMDKZqbMuLgpa/?=
 =?us-ascii?Q?hFaKAiotZTI7uF0WSIZpDFFYLFcnj7JodyCeLmX/q/jZEijfMJoJcvAV+Nah?=
 =?us-ascii?Q?XL/NkRYSEFkVh/ifWX2S6leAsfBkuSy3WagZy7vezYx4mhPIdyrS99VHXn6q?=
 =?us-ascii?Q?xOU87hEwC64qhgHyRGx5OqTbxnDQCzVPF2jnUr1UBwDUldD2JvlLrlMV1vbQ?=
 =?us-ascii?Q?2/rqbTMEUmWS0dC7HPVMj+zbWAFud3r9aQyjY4aC1McS6s0Dn9Brh4nJhygG?=
 =?us-ascii?Q?SQA105ou4gVdyMMPAP6uoqLkfL1qsn3lArs0/1ufkr0FZk8VvKziODoVsQFW?=
 =?us-ascii?Q?i1F+mZxoROEjDTNAHsaSmo7sAmn/2F/T700E3HFeaJGJwisF543ISB7po36h?=
 =?us-ascii?Q?JnENkr820JGRG87Wma553nSoeRLf5OgYq3zYfcIISz1wbeyFl9T9k75KP7o8?=
 =?us-ascii?Q?6Rm2F4rbMwhCs+h71NJ3L+I+bt65iq8CQHNNb7EdjtCaF9azV+/9krXb/6eT?=
 =?us-ascii?Q?n4Hm8s+jPZ+GBeGoJF1LH+5aUpW1Sij0xnCc5ViWse4j7I0Z23h8+ddM0MbQ?=
 =?us-ascii?Q?3a/nQKAyvVbPVr3yaPWGrtcunBeaTIRBmPgpFhk10GkvzGyFt1VYHggM3mdR?=
 =?us-ascii?Q?Ak+fSOTGmOWqcf5Yj6Z3ZWq3b7DEQCGHKSogQx1WUThmZqEsd71rSHIIPdgg?=
 =?us-ascii?Q?Busem91taqumw8ifubhw7KAIPzqgUgEQMGFwLkJQzefhsTOQtWw0yBf9l2eW?=
 =?us-ascii?Q?XQp5Y9PBRKo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hah1uJ7H+UvAUDYqPzj5Vwtqa0ESWW2yfNvsiHlFqq03Vt38F3cJXy6j55MS?=
 =?us-ascii?Q?gHxMMlPkbkLzRBJLVQj6Iy86BmxwycTHLV0242R1mYi2Plopid3vw5C0IZ/3?=
 =?us-ascii?Q?uQDK7Qs47Er2w7QEwTqYKPJ/wQpapJiKN9wi/31j4u7HxRqDXMYiDZZYFubH?=
 =?us-ascii?Q?D3e0YPRhQ9mCefwaIjs9GkFAjTq7evre6WPpicRttrtrn4kNSkYli28zWMRB?=
 =?us-ascii?Q?RfBr/aClFCsdUWb6eCoQySooEWxJRCCnp4hom8D49lcmFnIT0//JmnKxpU6Z?=
 =?us-ascii?Q?qcBjiONZAEw4AM1bAIi7jFyTXb2kmWLSOg5jufoCZYoV/vDXJ/PoCEzjGq14?=
 =?us-ascii?Q?KWdq76QnG8aavKPM/UHUsbKZzX+xujtWCCBg1E3r5cpweu8wN44PwL9hRJSz?=
 =?us-ascii?Q?AbQo9O9u4Rd+zonHYzrxxPgFZbhbMZEJi+D4s/SOmlOEdJP+f5xKxNtZ+bu4?=
 =?us-ascii?Q?zmkUNDyeYMS3w1KFma/NwSFaYEG7HL707xKmMLAPf9OT7amjiem6rYh1g13o?=
 =?us-ascii?Q?3TzHpN2FHNYhPCwl2pxPlQv4vncRNBT7tT/l71G9aUpxm4NfAMQb6R/DBaE+?=
 =?us-ascii?Q?U7c8C4v0gBw8mzJz3jvPIbRev4whuErdmxkpnSdkQLdi+//OJysCfgJAL3UY?=
 =?us-ascii?Q?MFxfPxE3d4zDUi+a3TSuNTjdogJFjwLIiXfxrEnhKzOJGZ3QyJEbESlaOssG?=
 =?us-ascii?Q?ZsFgujn386C0aiut2bAStziF1RTb0uIG0tLz37924XONilx67yAmuh5+WHVi?=
 =?us-ascii?Q?2k/k2ebkMf/SNHMU6Xin6t6Wttyc3dbod9mjWO1ha3nCGImjaIGOZbUoWXtQ?=
 =?us-ascii?Q?TAKhidDm7yiMZSxfNfSh1yqLAmrh7JKIq1CRC4CPZC4BkqFzRNbjr5hBjpMD?=
 =?us-ascii?Q?vmsRiyqFLt5BBbJq/Zk9ee6/9gF5Sn/bliTW/VhPH8um5SI0STQMiCgZo2Q4?=
 =?us-ascii?Q?VTDwKlMqQ2vlSGt0Y5L75002xPW2154nhPeicrLkBoI8oSOqW6ZUJHb4rkZI?=
 =?us-ascii?Q?Zszn+x18slCh/AToRmHxIsI36FecNna0c8Ab5uK25urjKMJjlFPV+8RgSMSd?=
 =?us-ascii?Q?vJEkYLtr6Ic1rWAl9fb6o4Ps5KJ6w0gQz0p5H6Hoeoe+yl1tvnHUZrHh6+ZG?=
 =?us-ascii?Q?HDc3vhz0UFBt3aevRWxfQzDqG8c25rnIsGzWNKj2A5/m+rOYlzcxlAGKu0K0?=
 =?us-ascii?Q?WzHtegDzpN36NZI0U9acI48x2V6zt/UXPChVl2UtTacmfcKsJxj8JqD2cTV8?=
 =?us-ascii?Q?uj9iG7JXNHD5CRXQi4fUsl0R2KlEFiDxPf8v5F6texbFZZQ9G6OvZSPV41P/?=
 =?us-ascii?Q?sqCbATvSRbKi7hK2rweDgXMg9IWdDCucCQCAVqaFi6nCONP9DcjFBqjROuh1?=
 =?us-ascii?Q?LPgb7r7CM1wIzaImjFNEazcg2gP6GZHPecBvEdy9UkM2A+/qZd3jVEWwyF6U?=
 =?us-ascii?Q?V3Tu8xAZ87Z6ARqokLvAxCgWY19RL/OHNYbAMjXlaMAuKE0LHRVfQMVWRx94?=
 =?us-ascii?Q?LZh0bRvXVqHdK/bIqYn4w/LOQZSl4pLzeQg5kkfm7HHhld7zH37I9kwi82bx?=
 =?us-ascii?Q?eHyJKPmdYkz7K0nBC9yGBf+tovOyeG4ZPrChbnX22L6tOIqsBMcEhpsoGObv?=
 =?us-ascii?Q?bg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7498cac5-fe2b-4b83-f56d-08dd9304e03d
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 16:32:11.2834 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PTdLGQAHbToXqoKW/iRn0VZKhCqC3yaszYJce8ULz+jZqhFuKsQeVW+SiI6BHx0ZJn/7G4SDHYESkCoAXoGVBcsPfv4zlXWSqe4CWp8fr3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8388
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

On Mon, May 12, 2025 at 01:54:27PM +0100, Anatoly Burakov wrote:
> The `rdh` (read head) field in the `ixgbe_rx_queue` struct is not used
> anywhere in the codebase, and can be removed.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>

With the one comment below fixed.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>


> ---
>  drivers/net/intel/ixgbe/ixgbe_rxtx.c | 9 ++-------
>  drivers/net/intel/ixgbe/ixgbe_rxtx.h | 1 -
>  2 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
> index 95c80ac1b8..0c07ce3186 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
> +++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
> @@ -3296,17 +3296,12 @@ ixgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
>  	/*
>  	 * Modified to setup VFRDT for Virtual Function
>  	 */
> -	if (ixgbe_is_vf(dev)) {
> +	if (ixgbe_is_vf(dev))
>  		rxq->rdt_reg_addr =
>  			IXGBE_PCI_REG_ADDR(hw, IXGBE_VFRDT(queue_idx));
> -		rxq->rdh_reg_addr =
> -			IXGBE_PCI_REG_ADDR(hw, IXGBE_VFRDH(queue_idx));
> -	} else {
> +	else
>  		rxq->rdt_reg_addr =
>  			IXGBE_PCI_REG_ADDR(hw, IXGBE_RDT(rxq->reg_idx));
> -		rxq->rdh_reg_addr =
> -			IXGBE_PCI_REG_ADDR(hw, IXGBE_RDH(rxq->reg_idx));
> -	}
>  

Unrelated code change. Please remove from this patch in any subsequent
versions - it's not worth fixing this unless we are otherwise modifying
this function.

>  	rxq->rx_ring_phys_addr = rz->iova;
>  	rxq->rx_ring = (union ixgbe_adv_rx_desc *) rz->addr;
> diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.h b/drivers/net/intel/ixgbe/ixgbe_rxtx.h
> index 641f982b01..20a5c5a0af 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_rxtx.h
> +++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.h
> @@ -85,7 +85,6 @@ struct ixgbe_rx_queue {
>  	volatile union ixgbe_adv_rx_desc *rx_ring; /**< RX ring virtual address. */
>  	uint64_t            rx_ring_phys_addr; /**< RX ring DMA address. */
>  	volatile uint32_t   *rdt_reg_addr; /**< RDT register address. */
> -	volatile uint32_t   *rdh_reg_addr; /**< RDH register address. */
>  	struct ixgbe_rx_entry *sw_ring; /**< address of RX software ring. */
>  	struct ixgbe_scattered_rx_entry *sw_sc_ring; /**< address of scattered Rx software ring. */
>  	struct rte_mbuf *pkt_first_seg; /**< First segment of current packet. */
> -- 
> 2.47.1
> 
