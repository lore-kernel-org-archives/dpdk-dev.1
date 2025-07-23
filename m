Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71304C83F1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 15:09:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B73EA40E4F;
	Wed, 23 Jul 2025 17:09:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id DC6EC40E4F
 for <dev@dpdk.org>; Wed, 23 Jul 2025 17:09:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753283353; x=1784819353;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=fIUucj2JQfY3b4um5uw/0iSQb/HqVDd8vHgKbrhKtG8=;
 b=SSnHHQewpp6AkLFPWoZq2Ne7x8OGl8U7UYFSh6Xkp9MWd1exV4navdz/
 RzVWPkjSZO/DXqirmWZx7vlDcH76JGk8Xp52Fxy28Z4jwBInxtT/JGFM3
 uNCLDS+2H6ejGWJ6J2ig8hcFI8D0u5/cnqZ74DHZdDToUPw5C84qVYRsv
 XM25lGEycZjSbap1FxKQJy2rJcBKhJ/jqE6j7e6gA0h0W04/+10GRw0Tb
 CbTuJ8wmPRaa7IcI/j1TS6HPyv3dBvUMiC03CAeHFCCFxirrp0DEQlCtK
 r2eZwp7F+Bf8yprWzUYi5G1HFF333wSRiodz16LBLYdBzfxj6WrdeNFqV A==;
X-CSE-ConnectionGUID: zWDywe48QQW8njzCRz9jYw==
X-CSE-MsgGUID: Bw/4iigtRaiPFEu/zf7IYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="55417161"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; d="scan'208";a="55417161"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2025 08:09:12 -0700
X-CSE-ConnectionGUID: pbyzO+OJR/yBD1iCMMcnXA==
X-CSE-MsgGUID: zr92dkruTqGwnnopQvG2Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; d="scan'208";a="190502916"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2025 08:09:12 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 08:09:11 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 23 Jul 2025 08:09:11 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.89)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 08:09:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I07geQxLa0M3q0tPr8y+2unAOcYCIRUlvQRH6rkfsYftC4G7+gY4U+h48Xf9iYsQk8Xtnr4OHZlul/39b1ZIORuFrLaYKc4c+UkCpszCe4jnMV3OTPjGLGezk0+TK1U+FHyrgO0/tRNmm+ELBr5K7QcvXGaK4O1eoVLJUmZeNOZ+po9ct6FcUbLtEW15gdDNOXE4SO+UsWQCx3NAJA07PjKLLdZuu7qh/XQRq1yrd4WtZGD/Wm+rvQBEoP/rmqD6WHI+IQKSQdbgoz+WZGKjK1m31LtMdoQLAGxrkbWK0MnCiq9W3HCUcKTlqfhyPfZ0Lbr4NZbuTqEXu98Zcc9Vmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3KsApn2qTlaKk9FMqX51xZNSBOkh5wMqhgkU4fFQHA=;
 b=YQamsxsXRtxNEh0YjGfEQQ0Za73ZvF2XrVFK7iQ6oZzXWTm2ilAooTnREZ6qCHdpELR6efQcgJgmT38hx7GsdnW3tnS5xmwu6KB84gLWZVy1NEkONicV0fu7g4pbZxQRL6xvsmJOZvShbUknAcr2bpBV88lSxOgrSV9glyyeJGjWdVH6BaR236Ra4vsgUaHM/6EX9viP+JCg3FvPlbo66VOa94LrXYRngygcvylROoQBVEVA6QRhlmosVnqpiag8JOZ+SvDVHDH4OasCs5o7q7ywe8bJS8Z+aa6Y6NYYyguPu2K/1G1Oc8wcvYGPCPNAMyT7XvjxEbjE5LQ/qlf4Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB5248.namprd11.prod.outlook.com (2603:10b6:5:38b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 15:09:08 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 15:09:08 +0000
Date: Wed, 23 Jul 2025 16:09:03 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v5 19/22] rib6: fix some highest bits handling
Message-ID: <aID7D_3nLDRak4j6@bricha3-mobl1.ger.corp.intel.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250723133157.159825-1-david.marchand@redhat.com>
 <20250723133157.159825-20-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250723133157.159825-20-david.marchand@redhat.com>
X-ClientProxiedBy: DB9PR01CA0004.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::9) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB5248:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e0e302d-a379-4914-f361-08ddc9fadf77
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zSOEbLQmIj4MVx833ZYVA7AScRjY+RqIUCGhHerUT5S35GbdEdw+DxSIr10B?=
 =?us-ascii?Q?wKIkcg3bnqHiswAYomu3FAt9jLhRNvnTUSbm0m2I39GQ2IJxXKZsWFbt4LoT?=
 =?us-ascii?Q?+mUaOb82VkQNDn5c998lnHTB425CYEyZb6uvkmyiptV9nGz6V6fm9GnZH4Qi?=
 =?us-ascii?Q?jo/ncVB8V7uj32PlkJv+syfxwUkSeV8rCVtcBsJk0n7oUIz63Ug3HJ0jbPGG?=
 =?us-ascii?Q?b0hbGc5TPek68g45hXG7PymFDAW9pfx6DNSEX3eVCZWnBpm74a6jY0Duz7jh?=
 =?us-ascii?Q?YL07oPCqo/rIjxjvBHm2e4oLHAXafd3hcx8T4ynoX4V3RM40iLzjBemUCaSk?=
 =?us-ascii?Q?yc6UdF+0mKadmCIJNmCZT6ew+YrqgSA4sMRtlosmStFlZwOPsYPwcUCvsn00?=
 =?us-ascii?Q?Dn0aUvnSOk++feB1VUtYiiNWqAHUKNOqG9u/bLeUpbQDBIGHwsfqfwM3Ub5D?=
 =?us-ascii?Q?R/VRf6gJmUWId4pa+AabaXaYr9Z53qXJcfssIyr1onPl/YT5D2o/Ttda4vOL?=
 =?us-ascii?Q?to+0igY+aZEp2lu8re8XDspo7fuRD/HGwJ5GsazgNNq8wxaOMUf3Sufdk5Pn?=
 =?us-ascii?Q?u7OIKJsWN0YzlU5SNcUlRLQLY6FD1p3dKPH6CqZi4a+3JX0zCt1u7ctHRSsQ?=
 =?us-ascii?Q?sLeeoS4YClN+W5e2TFprfriTiaj4waBVpZVWQ4vnhNK0QEhG0nakFxAYlXkm?=
 =?us-ascii?Q?p/D6ZOC8g6OK5Xm1Lob2x2uEntCbxrWEAro0SJs1XW8sP2iUKFnicNbrygM8?=
 =?us-ascii?Q?Pi4ds6U8gpfsKDozvPbRBLCznB+YpmdERnZRT6gl/7fQxHN66G+YByAdJgBA?=
 =?us-ascii?Q?sOm0T4bnjASXXX2L3dJlVGAVnZSJ4iymgHtUEXgcu/7dtsm2ieE9zySGIprC?=
 =?us-ascii?Q?vbKzS82WKoskal6XX9yhhFus/W4PMvOXZ5ki7cMRn9//3WFMrg+aLxLxeReH?=
 =?us-ascii?Q?ZkwMKrf780IetEfxWav7FPVUdKKwoO6Lfycl3+mNDp7dtJy6PmtZE4s/0V7w?=
 =?us-ascii?Q?3HiddifMS9PdLFp+tMoIkN9kAfWydB0Ce1kb9gnfrYDiphnBqj9qGVC7bEdo?=
 =?us-ascii?Q?nTADrEqPNsVS8Jv0cWuV59+CxCOnYOiJEVKfpXzFDHVh/K7qr3NeONL2z3rU?=
 =?us-ascii?Q?6tXzx7tQg6ZBzb/ML24E0DKuRjqf1V74Hk0KMZs+3/NQYYCF/W0Rh5ozxZKe?=
 =?us-ascii?Q?yxqJzUBKpWP1pk6xlpk5+edcZg4Al3ou3Zki5DsKZhFZEG5+F8Kj7Tnu9jNE?=
 =?us-ascii?Q?0hpVWQsE6OMF2QLaiZkawQKsD0oO6PRrHpjDafCUtek8vCXj00kvX5QmmzdZ?=
 =?us-ascii?Q?4wZTi0vA46oo7VFwEljxsv8Q4lMMVJia1zcYxmkD6aJ9P/x+tycA4VbwzHV6?=
 =?us-ascii?Q?hWPU8OsoE8nWVJh8FMNpdk+DkUZWxLstJs0ZhZmPDnGmLXOLCsdgMl8U4xvt?=
 =?us-ascii?Q?Ol4B9/6ZYuE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4OhK1j+APJRiBu0bOPacbgAhBaPR24qA34Yvq1fXe8d4caWRN2PTDcMWmXd2?=
 =?us-ascii?Q?IEkvyQEcyY0qktuhJaZrjfB/DlHo1T2P1qIfL6OZwD9DR0HM5XynXDZ2LNhH?=
 =?us-ascii?Q?UvNzu3Ie3VSPaqw0Wrx4ZZ/DMXNbiHU5tlfL/p/RPrYwPE9O15XZmfV+ZqRy?=
 =?us-ascii?Q?XZDS17d/RVk0LSZIPFpBMHTU73/ip73ayqrTwBfpin+R+QHGPS2acJZZ0BHl?=
 =?us-ascii?Q?LFyc1ZO4yRysq4dnyf8R3pFCByFd3NOFrPqCrW9+32WssE49o+Ja5lBTWAGI?=
 =?us-ascii?Q?VQFC9YWrAKfzV5hbAWU65Az78eK98nfxndkoNgy9SGUTSgEE1Kr8feChypNY?=
 =?us-ascii?Q?abM+DWPiXgYfIZBLqpt7+wZZzBXVNyC93JWFU+/FafVp0w6OH/mbECnFT2++?=
 =?us-ascii?Q?nr82M/K8/0ZFR5oYBq1Gk7V50+e6DVPWTrvMMQh7a7+uQzu7zr6cmcZDgt6+?=
 =?us-ascii?Q?adDCHFDWGMQGdmpOCRjqMXhMXVTltmNO5SmzeCd6crZ+cwy/Vjzl/W+h+OMZ?=
 =?us-ascii?Q?nYbyyVc5wnXN3BxvbRm6YbxV9DjqhL0OYeQLh2bhVCooDJBLCAUJMm1kyu2w?=
 =?us-ascii?Q?NK8QVRfHKwVSam5txAxiFtLR1A1A3tSbA7NNpdZCQdq3JrhOk5bAgXVHSHPI?=
 =?us-ascii?Q?z8mXGC3tEqMCSTR+VFR+G6xXISbHmsN2FaaeqkqYZr5omcJigPKEVmHdZohg?=
 =?us-ascii?Q?d6BSlgYAjxoFOiD+5bc2XOGby8XNPSRtji9ruF9i4Z1Hv3VzkfQxG8P8H8cP?=
 =?us-ascii?Q?sF9lfSyWbg+eCUgWYb1F0dCK699PvWMcRoLPXeAJP9QmLeWRfMYRfqz6gMmq?=
 =?us-ascii?Q?wRqb26Yc0ApGo0R6mQOhOgnqSL479oime0rg2xwhcQ+0fHHqocyQtrmbOODM?=
 =?us-ascii?Q?iCIRioJuEhrcB/zkPksRWXBvBQ8ZlU4A38WrbrpBh693JbDxf8pJaQX9DZ+k?=
 =?us-ascii?Q?BbfbeJZwDcWeys8GFIycjoPU+KxGS2hSRFXyf/XYL7vuWc6Hrhg1YzXyyDhN?=
 =?us-ascii?Q?jOSAQJVkq7MivGUdINNEKIpBUiff9r4bGp8D2GDSDAFl6fCKzVmoJt8s8f+f?=
 =?us-ascii?Q?Ulv/bH40WDxSe1mSOxyg+rbPwsU2wpSn4HpNQ4o8MKfkCXdhMBPF6z0UNXBH?=
 =?us-ascii?Q?wBpYyBCbxN/HfN+scKFVx4aD/Jiw6y1uX81heVcSRWDyuNX4w1iRLecScmQE?=
 =?us-ascii?Q?UnupUr9Ivrl5Tfy9/8AxRl+vtPXIGy5dLWN5oMu/wIyWl8VEQHUbuB/gYa/k?=
 =?us-ascii?Q?QuOqlBTMlOMReALRrxkOmG0yDVONi4/+6xhFKz4z5iLSXlgxg2/oz9Es08hX?=
 =?us-ascii?Q?/E0r5nnZ4bYiwuljLjWSJccfLiJgwxitDZWRc4VikISfI1VN6x0ZRjNkZr2S?=
 =?us-ascii?Q?OSKLO2t4jUrRGu4npC7uexAkISh+iheOYYal3x9O2S8PAtQlTlSX0W9E/7WY?=
 =?us-ascii?Q?obsSwLUKuBz3SJplEjeMXjETk3N+/cC9LRU4a6UJxlz+RQaBbo9tQML752Zq?=
 =?us-ascii?Q?3ZswZ49E46+bVWs01f4vsyx+DaTrFTt1DNJQ4jVKJgPBiEi//eiAoBw7Eaov?=
 =?us-ascii?Q?lDiKwnVVfr2Ws+m0S+3gt57420jN/c4qRvqhKVe6pPDK74Pj6ehJ/2RS9L+U?=
 =?us-ascii?Q?/A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e0e302d-a379-4914-f361-08ddc9fadf77
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 15:09:08.5845 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jlCVOZ3pRP46bNI67CS10GcGhnkpIiUStQavWDt8ryGjglHP8HHnrE9RB9nXYN10FSW7rNpVclmKPnt6CgQvKZgqSii8fySJP7X1nOEVpBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5248
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

On Wed, Jul 23, 2025 at 03:31:52PM +0200, David Marchand wrote:
> Without an explicit type, ip_xor gets promoted to a int.
> 
> ../lib/rib/rte_rib6.c:348:26: runtime error:
> 	left shift of 130 by 24 places cannot be represented in type 'int'
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>


>  lib/rib/rte_rib6.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/rib/rte_rib6.c b/lib/rib/rte_rib6.c
> index ded5fd044f..ec8ff68e87 100644
> --- a/lib/rib/rte_rib6.c
> +++ b/lib/rib/rte_rib6.c
> @@ -352,7 +352,7 @@ rte_rib6_insert(struct rte_rib6 *rib,
>  		if (ip_xor == 0)
>  			d += 8;
>  		else {
> -			d += rte_clz32(ip_xor << 24);
> +			d += rte_clz32((uint32_t)ip_xor << 24);
>  			break;
>  		}
>  	}
> -- 
> 2.50.0
> 
