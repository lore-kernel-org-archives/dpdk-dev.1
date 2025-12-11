Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6696ED41C27
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Dec 2025 11:59:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A93440DC9;
	Thu, 11 Dec 2025 12:59:25 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id D2D4440285;
 Thu, 11 Dec 2025 12:59:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765454364; x=1796990364;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=QGOomaVapcUJ9z3HwZZoy4so/5T7OdV2ih/YbpEuhjI=;
 b=NAq1ANk1AaLxH6xf5CMfp2nddk0vp7eicJXs7o/mEPrRQp9KvsxXOGHY
 7tHRT+VTPQwj4K8MuBtHtXQqw6BvWOgRvn0CXzxdaZchtFj7HdoAfeKXD
 3G+CQGxSeDPuK8oAaXFyGLr79dgwp/Nv+MMHwzfmAMPBF/hx6KFfGXR5D
 Qqx3bJVbRQpuRX9iignK21JkXroR1khNfJmVSrL3h7iHS44nN3G2ZeXNp
 MCLL1Tm1kwysKmQ4U/h2JvyqSjQtXdgWDJ//h/QUh01kqCxiIYbtxvBjw
 PS0KmWz4R9O+dKqERnoRHnmrHM9yZO39gUz3yRik7nSEItcKYryPLHeSg g==;
X-CSE-ConnectionGUID: Bi1oUkO4RwuGz+aeGOXpMg==
X-CSE-MsgGUID: TOO5kiAbRlmqC1k34z3Qjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="71300345"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="71300345"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 03:59:23 -0800
X-CSE-ConnectionGUID: 2vkkeQY9TL6fstG12aZb+g==
X-CSE-MsgGUID: kxKNJZl9S1GiQ/UCubMQdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="196049084"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 03:59:23 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 03:59:22 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 11 Dec 2025 03:59:22 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.68) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 03:59:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X4tYqmrBTtGEdlOMlprjek/Lb7KZSz/Wt7VOBcmSYvY/oetFowmWt0iLxCaDolFGzpCKachXqaYoWQsfxjB1cYPnMdoGezFty4y9NxAdiVooSk24TndLd0riozR7za9qIMPaMC0aqKoygpFQyfGCcnY6vkATjE9g/tO3akGhgmGjN/r+/ZRIbk3Jd55CzPDpy4KHcU2/sXeYj+aIBlws38a+EH6OVRaI7R7iDZHC5eXiPPD1lLMyC/1U2xKLXwO/bh+mXvWJO/MUv3P97fyin7Ri+uU7KMLf4BwN9jUKDUoC9VLBMrqIpWPo0sjDNKP7quyApgfIf22vs+R1XuPVTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSQ2am+2V8iUcFxxWT3c7WLcwdfRVWYDXypUH+4YVIY=;
 b=edFQ6SArFJoMHbDb2boPW3wmqcc5IPh4dQerBBEoItc93zjJZlc1C4jjBe8gWnuvJHxDdukSs3/d0m2FIfpiMMPem+PZj3v6VEZ0ILMblhmqQynqUtPoI6sKe26J3sFxdRWCVlHNOld6hXUR2zxWSQsCg4lJ6CVBDDJzvAHvLG4pUTkjLeITvx0g09DFhkJetUNngrA9zkQZgeuFIOI+KxYARP/y/3TsG1GVpjjpXFeq67mrzOaXxz+FKiQe7eKkuDe1wA/52l+KJHxSSUtZU+T97WoYaguy+q+0GYsuUGI6+9eLifp1vY9iFXAQABnAVdLxVz1SmQg+sEyTWsnx9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA4PR11MB9441.namprd11.prod.outlook.com (2603:10b6:208:569::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Thu, 11 Dec
 2025 11:59:20 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 11:59:20 +0000
Date: Thu, 11 Dec 2025 11:59:16 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH 12/13] docs: fix inline crypto feature status in iavf
 driver doc
Message-ID: <aTqyFOMAmmBPAcxZ@bricha3-mobl1.ger.corp.intel.com>
References: <20251209112652.963981-1-ciara.loftus@intel.com>
 <20251209112652.963981-13-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251209112652.963981-13-ciara.loftus@intel.com>
X-ClientProxiedBy: DU2PR04CA0358.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::31) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA4PR11MB9441:EE_
X-MS-Office365-Filtering-Correlation-Id: 89150d0e-c234-4cb3-3210-08de38acb7f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OvvMf8SQrJR1NoDll+uh5Q8Nc5nSNvxe8Kr+eFX4qKSkrN/PdZy/Seq6jTCi?=
 =?us-ascii?Q?WBL/ehsAiZYugoSYSFnsDsXrEcI7l7Y3U26uLv7n/BM2maGZNPdKGxBtCeDd?=
 =?us-ascii?Q?oTUawO001RxxOCwuFw/Q7mWPeUI8ADISlnXaBCOU1uexWzdFoT3TXYSLIeQh?=
 =?us-ascii?Q?m1UY3M6e0ygKCdx5Ou6ereThK7GuK1o+MHBA5OGaGNHwGu1RVI/AUyutZDpr?=
 =?us-ascii?Q?hDnJVrQSse5O22l+8dth1eEwhoEKEmKGNUgUCDirRY20SC59riYxnTY6X84w?=
 =?us-ascii?Q?GQrPIs1qx+7VFFn+YErbU+YNFWXYD1Jb3d6f5z8ddx35O66a6lYZlrEeeqY5?=
 =?us-ascii?Q?It9S+pB/kDGpQCpkX2aAgIUeDlDmuO9ef+7bWPFen+wce8FtEuaWQL0C6WmL?=
 =?us-ascii?Q?6c8at4JxYJbWrDdUxaQxZE4EPqbf+9m+q4FrxB46QtgnMrVT0E0ApQqbad8K?=
 =?us-ascii?Q?8k4kZWmas+YjU3ZHyI7yXLp1RxWjAQBIewgVobrgvUUNNDGRmHn6JtVVUR37?=
 =?us-ascii?Q?vun62pUGT5OTSTFlnhYLoODnUB2OXKwMkCZbRx5BqDosn/XIcv8mgARl8aQ6?=
 =?us-ascii?Q?d01yiMBJOY2ef8mX8iuyb+GM+9nVcOA+qkfdtcBbBNLKQUIdPKbCIPf/1IGP?=
 =?us-ascii?Q?s9sGGgiSkWhMVXLsVaGgNTs3rlgi7bqGE411BB1UnsbU0eIj5LA7eQD0KU+W?=
 =?us-ascii?Q?oUZGkLMNkWc7mmZ7B7yoBtJM9FDiIxxxb6jnrkLyd9NztWjy24J6KjQj4aO1?=
 =?us-ascii?Q?sS5VMkCEfbt/ksuwv0YMjLUH/fB7SrCCAoEyXGLOtizJMdVJ+t+xu9Z1XZds?=
 =?us-ascii?Q?JeBDE4atc58uYRUJjzvllE6lTS3PphgAL46DcL+tRB3SArzNVfq1EF2GgSA7?=
 =?us-ascii?Q?xXg1ag3dd6Sw3ZJDmDfLfL8wPeer6hqWQqrYD59xtyc7uUBd2MR3FynQIt7f?=
 =?us-ascii?Q?YH7QSjMXt07t3UvbFaRW6QjR+gKEBX7GH5GSlzAkQQ+ZCBO/FkwpEJ1TPjpe?=
 =?us-ascii?Q?VlFjfYHbquYOxZi7o1QoFkX12FZ8doKMRUdRNSaJh1JNyWv/HM0iUqBlveY8?=
 =?us-ascii?Q?xzXwG2K7CWvAclLs7URt6xzTs/EB2nrFq4hHtZgevluu2ZTs0qQNSxEVlJpJ?=
 =?us-ascii?Q?gEYjfRnOqOfNb/F2a1N4gnT/t4GJgP1rg7T/yR/4Ow+U5C1B+qDeaDvstLhW?=
 =?us-ascii?Q?A3Y3gG7tAJffCW5qDHgE1rhuM2hlkr/x2vECAmK9ZCZd8vazT+3ZITQuXTp5?=
 =?us-ascii?Q?yP2+EkOwwR++xI2T7uI3bzZQD/rJvpY8rrfIXgNpIqt0R1TAqZSKZ/KyVt3r?=
 =?us-ascii?Q?nal1v6E0b1y3i8HSspMDwQFkXKJ1iMa54DWGZ7t6Otm7Yx+2vQlAcWzP0tjP?=
 =?us-ascii?Q?SQNcJ01n2YygKVkzyjcIUBVVqf8lXUcEHJwYSaEV0LpDF3xX5zfcUqzxfhZ9?=
 =?us-ascii?Q?Oas11hYB5ckRLln6HT/9cNvGNa3kGNqm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p7gR56pRFuFaG9RGYkFv1vfR1j/UlQHZWviU7BoGtgBKT84AceCACBxwUSCh?=
 =?us-ascii?Q?JaMzTIL+j+FZN+5WvI8Yslwg5sECWFlNze1fUMvJb1EQH1ztUn279CxsrXTb?=
 =?us-ascii?Q?EmNclMHpAkoOb/HR2Is3Gu+qGlkaQxN9alAHBtNdt9tYszoYuBTFrcZb6G0J?=
 =?us-ascii?Q?1qjoQbMY79TzJO6wxSYT+S7gYOcn4vds20JObh6m6h3DEapLMc5kNPF6cG5c?=
 =?us-ascii?Q?5x8rxbKu9PYuMQFVnLRrGtfipLX4PYrFme8mVxecgHGvEdgjZy0SwTqAYq0V?=
 =?us-ascii?Q?EY/U1ZLWBfTg9+l/ebE/SKdyqmF9/xUfa/5WVNBOQHLWKkpyulgn0CDhHhGi?=
 =?us-ascii?Q?WjnyW0PxIiwlcwSffIQjgpVj/I6SswBkxO0AkUKXUN4kBZ0ScQwu2j0o8MJ2?=
 =?us-ascii?Q?yTH+Cq+/K1sWYZxq1uKBzb0/3kwjnsppbikkXHNF2EJqE1/fC32L4Qrp+Bbn?=
 =?us-ascii?Q?mjQu+5wvdSretI8pW3iQ6g459RYz3aIn1FYRfvV6uiFrt6wieCRs7fYEFoq3?=
 =?us-ascii?Q?XX3VySiODxOiBFXgPfEIGvlZiQvU0+6mpyufp3/kMXCzeHry65CU+JMAGkIr?=
 =?us-ascii?Q?voA33uNrhFoZrsND7LZXwEEXX1l3Iyfez73exlGOZ6Ib1OEM0c8J+XG3jKCe?=
 =?us-ascii?Q?++2Frm1Wdqh+lUj/GxFs4xIQRlKAW28Aq1G5tJpEEBXC5vEx+qn28TC/7W1k?=
 =?us-ascii?Q?Hk/Jv7pTOon5tez2V6jv653fxPYVZEFxag+7NHODA58uDuaZVo+BXkFDU8No?=
 =?us-ascii?Q?DWGLhfqDLjg/P1hX4x2E5m4SeD6fWQE8KCJKMQbAuo0zY9SQpKHsCFJLWIE3?=
 =?us-ascii?Q?OM76tWOJuGWH6tfu773FYGW0Z66IK0b/K/feKbIYzV0FHzTlaFtsEvrLT3Ye?=
 =?us-ascii?Q?Jv3do7FyRJxrzdbTWavVrKU5hiTAxUJ4V48rlWoO13YqH7Yyjf4WmEj7zf/K?=
 =?us-ascii?Q?rZeBV73zQLXuzTTiX52mzOMKRsfyJCfrI7rXkNladQPdzFUesE9Uvuz3kyta?=
 =?us-ascii?Q?Wzsg416QkCGfYReZsqt18+HlRPTHAwxKYdQ2VIEvYKTdG7a+i5pWxb3stMBy?=
 =?us-ascii?Q?Q/eFt+6DE5sZnuepKSjpm6bKbSj1TJo2d9xquF4yeVHmCEkuFjIbEQLKbxji?=
 =?us-ascii?Q?xExnNOHLvceWwsBJ+xOCYBnyuwq+RK0mwYcbkmg3oPqy+/dGxFqIXJkaLrXO?=
 =?us-ascii?Q?goPm8s1MK9O8cB49gu2v/KQMCUiKfzTqkJIeczg1LuDyb3tSdXPEjnQycmp5?=
 =?us-ascii?Q?1JC9HG60p45cf+g1YIRWkidzVDiHNYz41MTseSzYKxvJDXPT+UUAVSjNNqOA?=
 =?us-ascii?Q?QcAuhYjyz9tWzzeHTiA7bdO4aAPAtDE2FRamJfHh0joy96w5skMmosKBHJSr?=
 =?us-ascii?Q?Qdcqxb6WPEpfT1GBTyribRlQ8UWEgqDyy2+EjhOfYeKAllgdT8Y9gdUVgwkl?=
 =?us-ascii?Q?8CDyMDVTYaXPRGy8DJ6rGEKM1KjGG95fgll33B3dKVu6J0Zq+ZO0TuT9QbwC?=
 =?us-ascii?Q?WeraXCu/jQdBdVkTYx0cIzaGy44R41oWVV0x2/iMJbqAGACOYl7yVzfYYI4v?=
 =?us-ascii?Q?KPuVKA7cUYeep/VmotLUT4Inypo1vA5PoXW4t9FqKAA28K3gb5niHVDRZFKy?=
 =?us-ascii?Q?JQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 89150d0e-c234-4cb3-3210-08de38acb7f9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 11:59:20.6581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SIVs8JTHTGi5holMZIKIbVW7vAudtsrRawPidiWqT1M3pdXUVy5rkB3HO0hTEZsVzU3EElfyRUdBfP/CVG0tSD0Qcq5tuHRB3tskE0dEOL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9441
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

On Tue, Dec 09, 2025 at 11:26:51AM +0000, Ciara Loftus wrote:
> inline crypto is only supported on the scalar path so change its status
> to partially supported.
> 
> Fixes: 6bc987ecb860 ("net/iavf: support IPsec inline crypto")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>


> ---
>  doc/guides/nics/features/iavf.ini | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/doc/guides/nics/features/iavf.ini b/doc/guides/nics/features/iavf.ini
> index 6c9e97594f..0ba6f7dfd7 100644
> --- a/doc/guides/nics/features/iavf.ini
> +++ b/doc/guides/nics/features/iavf.ini
> @@ -27,7 +27,7 @@ RSS key update       = Y
>  RSS reta update      = Y
>  VLAN filter          = Y
>  Traffic manager      = Y
> -Inline crypto        = Y
> +Inline crypto        = P
>  CRC offload          = Y
>  VLAN offload         = P
>  QinQ offload         = P
> -- 
> 2.43.0
> 
