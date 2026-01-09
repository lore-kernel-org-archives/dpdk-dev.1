Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDA5D1A638
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Jan 2026 14:26:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37336402A7;
	Fri,  9 Jan 2026 15:26:09 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 1ACA0400D5;
 Fri,  9 Jan 2026 15:26:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767968768; x=1799504768;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=sniKNfAyhcZj+tzOXRL0rk4Q7MIrw2f4COso5X4SXII=;
 b=PtnOUy3cl65J5NaKm0HayE7k7qA54+Z/C+T8uFlTHa5M3dZ4JsJbzTKv
 jBASawt4Ix5JBjutSGxZipkvGEEOZynUZ48cs7ik5CIvHtKOnXJeJPnv+
 QXCmaNCSOkqE3G8BjwtFbkBW+I27fZ8dDrdsIgHbnvbYELI5sLUgJAgez
 xzZaCVtw2LSdLH3G0DG9IB2sbuUyptmnTewWeAqiXW9sYDb289AppQitL
 prg+7XbWm/Jup/O1CJKzSOMLrAMbC/q/jGmn8cz8TISxP5mij05C1TJRo
 Hqa5xJb6elHnUh0ATBmxou3Op3teZPzYOnx2jdOCdHdP4kJVk0Qh8IXmi Q==;
X-CSE-ConnectionGUID: 5hovWdqmTIG6qL6mi5ojQA==
X-CSE-MsgGUID: uwEAyqQ5SLm2jGDSxu5vnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11666"; a="69507715"
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; d="scan'208";a="69507715"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jan 2026 06:26:06 -0800
X-CSE-ConnectionGUID: b30JctkNTqWVtwBU3+Wt7Q==
X-CSE-MsgGUID: VJHHdurZR8aIh9MlV30wLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; d="scan'208";a="203764911"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jan 2026 06:26:06 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 9 Jan 2026 06:26:05 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 9 Jan 2026 06:26:05 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.13) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 9 Jan 2026 06:26:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7TiSJIYJwYQCZXq6pQZD/jXc2VHTgZA/pbpfo2xhEb7vXWXmN+kPEdkRrutgt4WMWACjlV1I594lnyGY7bxzeZpmPQIwZzjh6O/jjCUglxcj4J1GHVqVAKBHR0/nyflqLHWHLeq9js3jH0L+yn/3jN6i7XJArqVNIaagC18L072nkCBCsmnzSP1vHjLc1z1iUGMfcqT1aeFX3Sbu4dNlClJNJgJXT8IhPLetmV+GJaf0hxStji1fDBnDfvxJE/FOsXkeErdBRgQbjQje3pmAKOxg7A8GdqioA+132IfBXHA95Tjxd0NntvHVxszUBC5+xWrcZCOeOZdz6NNbf1ofw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFzKJDEqL31aOlwu0sTmpk6VZJTd1MFSBWIjYFAiGok=;
 b=epHAMWPuNzyMQehkfGY3kLS7VGvrxOhDKHVjW6NZzs1UaAqKK/Q9wAMc08lCGe0HS/t9h5b6Rx+40x++fjTmGFvmLMWYfZE2ElAIXd/XMwys3Q3bfVjyWtaVGh2gfAt9krJRTjdZmau/k6MQiIL4Q3GFAGylY3tzo1DJmZdPkRAqMILc6TVToIsViXtc4kojz5lMcYShaipuYEsJeyfVFEGxp+Zetfr0zN1WyL4xFSajgSRkj9zoD9EeVNaaRk6j6aI27tDcESpMlWCGu5vTVFDkl4TD2kbp9goJe2U5kmBJ6htje9QPiky8IYYTDwPkZvVfsWNDk++aA9INjkQAuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ2PR11MB8421.namprd11.prod.outlook.com (2603:10b6:a03:549::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Fri, 9 Jan
 2026 14:25:58 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9499.004; Fri, 9 Jan 2026
 14:25:58 +0000
Date: Fri, 9 Jan 2026 14:25:52 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Robin Jarry <rjarry@redhat.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>, "Beilei
 Xing" <beilei.xing@intel.com>, Ting Xu <ting.xu@intel.com>,
 <stable@dpdk.org>
Subject: Re: [PATCH dpdk] iavf: fix reported max TX and RX queues in ethdev
 info
Message-ID: <aWEP8FqWsDVvwzK6@bricha3-mobl1.ger.corp.intel.com>
References: <20260109142129.1550058-2-rjarry@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260109142129.1550058-2-rjarry@redhat.com>
X-ClientProxiedBy: VI1PR0202CA0010.eurprd02.prod.outlook.com
 (2603:10a6:803:14::23) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ2PR11MB8421:EE_
X-MS-Office365-Filtering-Correlation-Id: 2924c70f-f4d9-46da-35a9-08de4f8b01d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oyW2UWJLRsFoVsYGHT+lLU4Ic6HQKormVyi8WFYOmWy4mwsGdqSDIDts3wPe?=
 =?us-ascii?Q?8DTKfV45mTQNWTHaMYmkrgeEG9Rh7bWH4l8Tbt+Uj87jVxJBkPEldLj6EUSN?=
 =?us-ascii?Q?1s48Yb0gB9fY+fvQ5H9FUlJ2ppRoqjqpm7rnnfFG8hqhA6qEpuOFYgAd7+br?=
 =?us-ascii?Q?UxDNb5yRqfrPVAIuqVqROE4+TGIbw6eU//rytyExIAJdKd5+pW1oqJMWnGRi?=
 =?us-ascii?Q?/9HRT3AYba4ayNYv/g5zTIbDBPFOrKTH90ftIfSObIkUXrUHjmByU3G494xG?=
 =?us-ascii?Q?tIdi0/jE8a1HSyLevjICGLQxZ4pq9obmy10pRQ4KE9F7gLCw8YNsDbDVcnaR?=
 =?us-ascii?Q?7MlenfvJqeB3ceLgRnPLoDxsr6SSAAODzDm0dx2V8xFAwevo+P4bHpfXXlTt?=
 =?us-ascii?Q?ggfm9czxXJyz6J95JiwRYXD9PnWeUhFQjKcLVv90SmM0lji9v7o84eCJh9da?=
 =?us-ascii?Q?glM1k+JkPOH1JPqK84ceFwQR7uqjK3NJS2IOx42M0e1fCNZABpURXC2Qqfp0?=
 =?us-ascii?Q?nqHJJUQfwAHDJuAOK8v3fjC1xLpb68cu18jfC4248GCpwNBrws6qI0LCYr0B?=
 =?us-ascii?Q?i2Ly77YeOSY0v+kgu6hSrm1MDFNA1HTMukC8c5I8uv3tZtOk3BdJ1G2fDHoX?=
 =?us-ascii?Q?eHcQCLbwCjVrrFr+baWTHVvyADNQ5PWUiDGfk1D1bQS/zjV+5XNeADLB+FfJ?=
 =?us-ascii?Q?RTRhs5z+dOTqSx9AMtP6/YTkXmG6yERdFb/jjr4fIeJr8YiVDaLteHgAKtyu?=
 =?us-ascii?Q?Of8bTIgcAlQ2e71P1nvs8Dh/4lUfKem6shZobcWOiOxbfY5+g8v9v4HS3+0J?=
 =?us-ascii?Q?6pN5daTIsMw4LVvc1cuK/1mxbAyeG0za+hCdp/NuTz0b3/9rOr6z3362Ub6M?=
 =?us-ascii?Q?sq6zncXSa+ylX+R0AVzDNIFuCeuoO0/qbXtTAnGvIIWZh3RSkRKlhHvHX+HV?=
 =?us-ascii?Q?k1hUPPdABarNoYoaCqWK6aCJRicxxgEYmQ/ZBfMO5j1znM0pehZsYuSZWLL2?=
 =?us-ascii?Q?PX8E2Da9ajivB5puLEN9ax+ghPTs1yAA+oQpTGZZzGympGis1B76DhNz8eMJ?=
 =?us-ascii?Q?m8Jani6rgQXWESqNyLQWQeXpGs5eaehJqeXViz/nKBlQO/UhdWH5UaNXswWY?=
 =?us-ascii?Q?nfY8WPds5ReTr0D/dWjxJ9iyI2D/lEo4tmggxMfh7G6pi3i5PZmLnAI3bpVl?=
 =?us-ascii?Q?6wLKG37AFZ48Pt9bVi8kCWPB27uKRU3o1WSnIKORgIa/Q34rp+AwANYfpku3?=
 =?us-ascii?Q?LQiCM07iBW/RrMQRnTmT8AADALTnwIHQD1FiPeQuvRFe7AYgwfPJdNsbdrhZ?=
 =?us-ascii?Q?2tmmg99G64O0wuf5sXNchVREgsLLe3L72KkTIWcOgTAZfrTMgPA11FhAgOyG?=
 =?us-ascii?Q?ylwaYQmSyvstLY590TstvbUFufjip7wvX9U7QI8RVgh+vjlhxeNhMTVLfE48?=
 =?us-ascii?Q?xfrhZVFwfOtNKFkuOTMIYjSxwsZZMoy8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GvsnYK/5dJGlKbUuYREE7IG3WEH/uOkKbQE0aRL2qPg+R5qYzYiZJ+fn2fQm?=
 =?us-ascii?Q?mDp3fLr0xmT4YMRVFtJOo+NxWegI/soym0e8Ds/qH2gPC/QYzhsyGyfNS2De?=
 =?us-ascii?Q?XzFuRfKPG2f1RPdRsCkySLnesONOay1Dv5mXvcm/BeMhO7Rylyf7SVCiVyad?=
 =?us-ascii?Q?c0ZpdbPu45fiEvs5X1tQnYchelouNzGSf+raUqGHFwTYTUYjs/X7XX7s4U2e?=
 =?us-ascii?Q?KkmU/Q24rljD3lBy2RG+93vWQGCwFBj8UqXTrxdr/6sm/maca7qYYVLSm9GN?=
 =?us-ascii?Q?LzyP+QusRuku7ZZk5o9pTPRMGQdRB+fDqiUP/Nq43ngoLSKRNOPvO3ebBvGZ?=
 =?us-ascii?Q?/BwbCqOxVV8SoqsCTStI6MbQ9RO3bTmCket/29kPwz2zKvTl9e48j/wbAAwV?=
 =?us-ascii?Q?yDSyq648+vhBZUvY/B7ebc/CUqCd9TzLF+H3zPyWMXl5u1aLSXFbGMBPiK8N?=
 =?us-ascii?Q?ltFbXMD+lCkY1leFmTAl6ouGxFiXEBSJphis3gbJGZWPpUUfbOXjbfm95AZK?=
 =?us-ascii?Q?erETcgy5jkbdmhq05Xus3zAsXaGoSn8yWahAzX4aEl3ASCBoDhnLXmoRnOMt?=
 =?us-ascii?Q?ym0vFY2B0lP7ln9g6ykq0VjgiVYVrwvS9ZPE+ikgzU8aAycOSWp4RPmVj68j?=
 =?us-ascii?Q?tkYSKMOge6MIkuH6waHpSacct74G1JA+A9s9X2XQ7oqPJnR2KlsYP45xi4o2?=
 =?us-ascii?Q?5lGcmVcTCxSUTFQkoTsjKc1JvCkbzK9YdFvzXcKf9eZxSagRQ4BTDvMuAIQC?=
 =?us-ascii?Q?rqOGS70z7BJxMg8CrGpNFO9cpKmFgGmXI3Mikv2u1Yo6wSqWbByFHCA3mLjR?=
 =?us-ascii?Q?NzP08O5CgehboBu1DSfLof9KOiJM0ouTLyxALWUtPFeMhany5XSudxcmN86T?=
 =?us-ascii?Q?aBWVHhGylToWhbb3uM3gMf9xQvhsFu0zrRKwEpcuZVRmbo/k5aPSwTSDIehb?=
 =?us-ascii?Q?6VidSMjlfan4y2zvay0a7lnBFtehMMxoNR21fB/Vy2V0leE0HodQGdfaXxfb?=
 =?us-ascii?Q?Q39IIAg78tz+OJw3UPMVcaJMkblmmGw47WJ7wah/+mQBu+Af6T5ZOAB3h7oe?=
 =?us-ascii?Q?FOAkVb2fxA/Z3N3B/Ox/thWKtDwRfW1YfbPkfXu4Tofoe+dy3S3D2nUZgVd6?=
 =?us-ascii?Q?WTaC2H10JStmZ+UKH2u3azjbrPsxbA7p2qTRkQS5h8qoSvfgFlxERHjS9wVW?=
 =?us-ascii?Q?xJraNI+fW2Ox5C0MgmuTd3RDaZLVu7ekfcu6uPjcJYR8Ej0Kyr0zs6WCoKTm?=
 =?us-ascii?Q?G7nwXQxwOel19HY4iImXnDq0r0zK+X52g6jTiyALsv1HgN+lg3uRujJN0KIp?=
 =?us-ascii?Q?OzxsNTLbWDjuzZH/EZ8OYgVUMMW2pIop0nU6gsvUn4L1kgW8NEt9+73D56yw?=
 =?us-ascii?Q?HgwWzIFoe6hu8UbTP8BrdQhrAzZrPVy0HPRmqGOr4vAW43+E1DRq8DkcEews?=
 =?us-ascii?Q?uqr9COOYF4KAMkGTOovtorquByXFNMXualLTqvyp/MfYKaGDXJ7K9P0dXwHm?=
 =?us-ascii?Q?LwlYDUOS2ecDVjqzh6SHUW34nzAeOi26bsqWJGZq6rHYeypr/necn3B7boIn?=
 =?us-ascii?Q?u2mP3th0ZpvDmaLQUFQkGtENErSNEhQJYM0NkpOUcPOWU2yN2mWooTd2KIuU?=
 =?us-ascii?Q?1yeqsEapOfxbhLkHjUDX9A9XCLxakWlvbdh+IMNak4o1uVsACh6J+c8JHklB?=
 =?us-ascii?Q?/WwrUZkj+sct/Amr8m+q6QWmV7/btxMWWEKF5h+vpe/QE0hMSJnBAbU8Kpjm?=
 =?us-ascii?Q?9k/6hbBLzbgNHG/mm1wWBSpTLypCzJY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2924c70f-f4d9-46da-35a9-08de4f8b01d3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 14:25:58.4901 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rUm3Ls9XJYmyY/wvC8b3QZ35axllTHYgIr2G+9B65XtbnsXsnB4QQSU+yu+VRtiiATouBwtFRywdtJIPnNfDv+X637j+0Ow2JuphszXYCTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8421
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

On Fri, Jan 09, 2026 at 03:21:30PM +0100, Robin Jarry wrote:
> With a regular iavf device, rte_eth_dev_info_get reports 256 maximum TX
> and RX queues. Trying to configure a port with 20 queues returns an
> error:
> 
>   ERR: IAVF_DRIVER: iavf_dev_configure(): large VF is not supported
> 
> When the large VF feature isn't supported by the PF kernel driver,
> ethdev info must not report 256 supported queues but 16.
> 
> Fixes: e436cd43835b ("net/iavf: negotiate large VF and request more queues")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Robin Jarry <rjarry@redhat.com>
> ---
>  drivers/net/intel/iavf/iavf_ethdev.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
> index 15e49fe24814..59328ebc5ad2 100644
> --- a/drivers/net/intel/iavf/iavf_ethdev.c
> +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> @@ -1126,12 +1126,18 @@ iavf_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
>  	struct iavf_adapter *adapter =
>  		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
>  	struct iavf_info *vf = &adapter->vf;
> +	uint16_t max_queue_pairs;
>  
>  	if (adapter->closed)
>  		return -EIO;
>  
> -	dev_info->max_rx_queues = IAVF_MAX_NUM_QUEUES_LV;
> -	dev_info->max_tx_queues = IAVF_MAX_NUM_QUEUES_LV;
> +	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_LARGE_NUM_QPAIRS)
> +		max_queue_pairs = IAVF_MAX_NUM_QUEUES_LV;
> +	else
> +		max_queue_pairs = IAVF_MAX_NUM_QUEUES_DFLT;
> +
> +	dev_info->max_rx_queues = max_queue_pairs;
> +	dev_info->max_tx_queues = max_queue_pairs;
>  	dev_info->min_rx_bufsize = IAVF_BUF_SIZE_MIN;
>  	dev_info->max_rx_pktlen = IAVF_FRAME_SIZE_MAX;
>  	dev_info->max_mtu = dev_info->max_rx_pktlen - IAVF_ETH_OVERHEAD;
> -- 
Makes sense.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

