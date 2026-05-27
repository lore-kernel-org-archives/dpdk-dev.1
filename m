Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AED6CD4F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 16:24:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 550134026C;
	Wed, 27 May 2026 18:24:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 6AFA84014F;
 Wed, 27 May 2026 18:24:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779899098; x=1811435098;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=LKL5dpyFaaQfHy2uNIGXWi5S/mvWYIf4lVcfw2Kwf98=;
 b=nLroHGzhJ5EfaBaFJJFKJMctYkMtDeN8qKzNSb05mixh3/fcm3sFkxwx
 H8Q9ODiD6twB9nZFJJ6/qXJxGzwPAEcxK6UEMP6/fjgOr0yw54RaZVXFl
 Lv3+712tWL7DvXo4USbhR91yB7KTd4QAveh+eYUSPjLsHxcz8qiCXHCQU
 bA/td5Ytx1H0IbmH/bmAyBJOQ69yHrUzSh8QS1AVVU2Ew8aoI4h8vtM0H
 N3yymg55bIr93iGHiueNKz0qbA/OjgRlJfAvd813gkaoYiOoXwm7BQXEH
 rkrhRb8Qnv2mt487uiaUaSrffABNeo+gDIaiXPcyWYiBHjLrKypgzfiVt w==;
X-CSE-ConnectionGUID: ktiHTPFqS7eM1ELzFCcYWw==
X-CSE-MsgGUID: wRVBXtcAT4Gqmq9j6SoYwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="103410111"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; d="scan'208";a="103410111"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2026 09:24:56 -0700
X-CSE-ConnectionGUID: v1pHwNnCS/m8lgO42UiNew==
X-CSE-MsgGUID: tPJOBIuUS72BYIDSYEz8RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; d="scan'208";a="247364403"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2026 09:24:56 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 09:24:55 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 27 May 2026 09:24:55 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.3) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 09:24:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ap5obR5zZ86qIGk2DsAcN5l/SKzmFR4RqvpvFhME9arE7KWDYLEc73Asls8W2oAJJyqSn2DPLuor68t/X5R8Kn18vq6uQsDh4t5kpL8PpMRqz1yLvQTmkF/TordcXeRWrGZeemWQ6eCKlIZhwCK5MA93fKhZbfg3sJes3meVDkkdHuadSDoyUbuerlwh/XlBrRYrWEoULSOsLmzYDi2z8xHKIXI+pyaYqFs/328tqwkMniK9iGwT0StVYgU0wDsK3HdtqzNw5n1Jf5O65fqPznusFQV+FRGUMRUdFuPcEuWHn7Fk8/Lkq48oaNfxq4wee1ngNR71K3PdNMWr6VoRjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0AIiMxgB+cwk5tb7LHVH8o1Qmwp3N8uA5IwE0aqkYs=;
 b=iXKvjIPNRU3KJ1M5MCgWBRYCf2Xp5YWJJTX3m2QAs/x4X5MPLy3ASrzP+sV06RZrbJ0XPL2zzJLWob+33ngjn6KCBLX9+bvYgf7BTe6OhqoQIW1KhyiNJSAhVdcOmq9xZig0C01yn7RCHBkMOYpU1rJVUn+IBdedXMj4gBfUtMq+kSIbRjuhbG6YOJLxAy3j6g4q0lJBOXYrpV3XRUj6iJjASOF/L7d4912G8iQFB8NNWb/THgWgA2rjXo+NMDd9XYW1tXH826KumNhlDSwayobKZxfAh6YUtL016EMw/G1D0TAoQ/n9vOowmOuBdokkAABqvoreestkIE12MUXNGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM6PR11MB4706.namprd11.prod.outlook.com (2603:10b6:5:2a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Wed, 27 May
 2026 16:24:45 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0071.010; Wed, 27 May 2026
 16:24:45 +0000
Date: Wed, 27 May 2026 17:24:39 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Chas Williams <3chas3@gmail.com>, "Min
 Hu (Connor)" <humin29@huawei.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>, Qi Zhang <qi.z.zhang@intel.com>
Subject: Re: [PATCH 2/3] net/bonding: prevent crash on Rx/Tx from secondary
 process
Message-ID: <ahcax9T5KYPay0Ka@bricha3-mobl1.ger.corp.intel.com>
References: <20260417165530.653328-1-stephen@networkplumber.org>
 <20260417165530.653328-3-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260417165530.653328-3-stephen@networkplumber.org>
X-ClientProxiedBy: DB9PR06CA0021.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::26) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM6PR11MB4706:EE_
X-MS-Office365-Filtering-Correlation-Id: b4c2d748-b914-4127-aa5a-08debc0c76cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|22082099003|11063799006|56012099006|5023799004|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info: vyWoLqeqYmcUMH8FcYI0XyOyCMsTyUFf4SoLSgcmsBsnvtMfcyuL//Z3xW6AvZs63Z7jWa6QMPATDS7k/m313ilp7CStUeZqzmsNpZ25CesOYoRD1MCM39HHKSHBgbXxwvXyOQaNQTncYtgsXF/6Ev6XqEpa1Df9Zk6AQhpijtck2nMheTDRUJbguSJ+3NI2zAm9OHTsm+KsvHHhIbvEDaldIU+Z7IfPzI0mapkCFrUXM0Tj9b/uH4fQze8nP8qEZEFusLle/ihTYnCn+f/vtV9vpn2ou6viHAR4i8aOun1q66AhS4dl8PcvgIkIvviZRdwUk31ZhOkrQv0oTV2kVWR2u72/F+O3656GAg1/D9B8Of+05mvFF30+aq0sx64Ubw25vaS7ne5IyIEhwI57XJCFYu1CD9ri1blnJ1+M9oiNbcKmRPnDkO+jMobMJXHl/1+y/si+Aa9EeddHqaAjIioZEeqSYXq0bFSAHh43m02xjWCP77BSsMtmslZzkyIlxOV7CQjBogVsU+1y2kQz3zXEsnUPXZEbpT/kHvS6uikbWKgpeFKyvZ3K2wAsHD0tod381OeQGjrQVWngxFZV5JrT9ONumNExNH6IRjjlIqnW40D5E1XbwV2JWkkDjzS4FVHXhCvlpM1q7Lsi9h7ra4aCjDL/l8UJ32n1tzpC8kEQWwvco4mUfmF2FD21SBdD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006)(5023799004)(6133799003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zlmB2BZJQ6hVETxoqnjAsAulYZ5nvq7en2qCHAJROyhJlLRGzQ0hWA7p+WMa?=
 =?us-ascii?Q?DSOmaYYHYdrGypvD6LQoI936qR72uWE9DryIq0W5Dh8z01iHn7zW8tZMVvok?=
 =?us-ascii?Q?hD/vli7+86VKj8H2mGUAeyj7RRmHFwMAR6DJjg4PM8czvZwNNdz11q1j+OgQ?=
 =?us-ascii?Q?ydRm7sr9xf3AOWb8V6Oiy06kiq2kqix694BbnH/mUu6cWz0MuOOjw8RjUg3S?=
 =?us-ascii?Q?h2SvmOz8zIBLVdaUvsBu4MNftngky72OZkEDmxub1OPACJ8FMy0baaKm14Q0?=
 =?us-ascii?Q?El7bl4EZFKOlPHjmjxTFPc3J3d9GvXLxP69FnvZFttk3/g6WiQ2L1CWmUedW?=
 =?us-ascii?Q?VFGDWRL/TV/ZZNXaDt52Kc3s+niDwX5WRitQ/Ee/1rWMuqYIokLUnKfni7bh?=
 =?us-ascii?Q?rO+TKQey0k5gNOQGh1ocPmvdClqZq/LsOedyZwS/1VjyoP3p1+gzBPhdi+d7?=
 =?us-ascii?Q?Hcb/etXCTEpaGctlP61FpARyVc9NkbuWMyhn5zukRPqj182wpL/kqgF5JSDg?=
 =?us-ascii?Q?xoXowmja3iI3S+a8r2cQ8dTIDXrkxtqgbbAoi4A6fGRiPgNjepeBPBU18UyA?=
 =?us-ascii?Q?Mq4M8pLbdM8idHkjZGO1JxHhp9ltX+dPoUl/NOnFR9qvSeRKFksdx+Ov+htU?=
 =?us-ascii?Q?sV+IiWEukHVkqJ2NP7GhQu7zbzhsqxej84eeL6AZbGN4keoVlSG7y5iavsco?=
 =?us-ascii?Q?Og0etvSeHanexlDoYIMHLCTI7mi/p1mFG1p7URYymTqwRS6z1etQKU/ji5F5?=
 =?us-ascii?Q?V71WqL9jChdAstoHcovNn4e9DMCJPWQ/eLWmktI+lGgg4un3P0uXVbntHx9W?=
 =?us-ascii?Q?82q5eiD+5fmIWurZlTYEu9dQ1ahhp9ToXkLV/ZDd2bSavHCLrKPoslbUQdp4?=
 =?us-ascii?Q?ZbfPkvnvJPNRR9L/pWTvlxkw4lBZnLEE7/zvhExMMK9zoDxAd5nmIDGoJdVb?=
 =?us-ascii?Q?irI/N+1XsLVOa5z1p+G7vsCmsmA5gg/7aCpNxGlliDztTtmp7qTTfHH/VpDD?=
 =?us-ascii?Q?e0eSp2Zzr+3g7mhIOzzglmpSIuElpMrJqDBn/nQSXnIWeGs0coW20kDLKXg3?=
 =?us-ascii?Q?z3r3jSGBEWUiP8rKTA+NUjvuMOUIDQ93rqvQQrfKRmS++8DW/QU8Z1fnBGWt?=
 =?us-ascii?Q?JdMjfz+e7uT4TxaS84edTIs8wKEd0JNwp/RI6iHvU4HosXxCT0e02c/brw0S?=
 =?us-ascii?Q?S671WvErQglKtSiuzZTT+5jhtC/dulmHApYpUoFbJ44Zowt9DCrSsk/xRdZ/?=
 =?us-ascii?Q?S2oefpXEc/0gNjmVQ4AcE5kLjRlfacLgF798qeEbmXHFOyBlQsIVdRZ8605i?=
 =?us-ascii?Q?ARMLQqRb9vpr2fKNNyeh6Cfu1PvQrV4PqL9OY9Kzjl84/3Uq4Zt+bRcWLIMN?=
 =?us-ascii?Q?LeeOxSC74VjFNO3jmWsVXjw2ONkO6qEvslUAJL2twHrevsvcDeyk6tR9RPvO?=
 =?us-ascii?Q?ojdpYAi8yzpCc4DKdaHW9L3XnZ+zUUeATuVf13RhxqLAW3VwLVRtZr8SLCYQ?=
 =?us-ascii?Q?tFlELMUrtLzsNzvmDzf7Dhiw01FrT2KaCRNed08mII4VTAclSkXTaMSyxUXd?=
 =?us-ascii?Q?agiKhpH6P810s4CxNg+z+5YIMERqoJ682OJo2/3DtvX/01p0SremrNw2VS1G?=
 =?us-ascii?Q?R1ada55aUPUOjSw7dQKvfaEUp3w9qmduWAZiRqf+SMO5SEg8xj4omHiiWdkg?=
 =?us-ascii?Q?Y/7eGkqm6UcC9QkwoGDvJNapGm3XU4l67/xg5DWxh1bCzN6kH13D7oVOZlQh?=
 =?us-ascii?Q?RnFi8Cs1PAKNU8q+ql/VccOpHergLtE=3D?=
X-Exchange-RoutingPolicyChecked: qGWI/aeGOxEX/xYIuvQFleLknV0Zl/EKyhxIm3ukPCHAFFta85vDzyNGuDpgBe5a+nsLcsa1aYlDaq0cN0CTizrj3L0UNmjh5yKAUB5A106gwVQpZvmu1dyp+ycp0J/gULa9cd3HLVz5me14RkmRrNF+rXuRRvnmPxZavb99S3iRaLsLQy/+7j5a6v7dFRCp/XJtk6qqASqrbrwl6LxApu/0ZSUo+X0B47a8dVLoX9hTXuDnPZXV90BOEaXfkvooz7my0KzZGCiB147EwieoyDugp18LurIvLAsvvqdFD5RVHU1P67XpUOSKyTrqha4uwJzngyQ6mYqhbmcKY2QLXA==
X-MS-Exchange-CrossTenant-Network-Message-Id: b4c2d748-b914-4127-aa5a-08debc0c76cb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 16:24:45.4234 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rw0CF40dTPx2VaikSLeIT86ARNhnZLM5ZiDqx263YIH5IXcbuQEsR7IJ/SDEIb5VVs0vdfPEUypKJ1Xq82AZbNiWsOSlShQ4iQL5GskF0ts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4706
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

On Fri, Apr 17, 2026 at 09:51:36AM -0700, Stephen Hemminger wrote:
> The bonding PMD's secondary process attach path registered the
> ethdev but never installed rx_pkt_burst or tx_pkt_burst, leaving
> both as NULL. Any rx_burst or tx_burst call from a secondary
> process therefore crashed with a NULL pointer dereference.
> 
> Fully sharing bonding state across processes would be
> overly complex. Instead, install blackhole burst functions
> in the secondary so the data path is safe by default. Rx returns 0
> and Tx frees the mbufs and reports them as transmitted,
> matching /dev/null semantics so applications do not spin
> retrying. Each stub logs once at NOTICE level on first use.
> 
> Also reject bond mode changes from a secondary process.
> rte_eth_bond_mode_set() is callable from secondary, and
> without this guard it would overwrite the secondary's safe
> burst stubs with real per-mode functions whose internal
> state is not valid outside the primary, reintroducing the
> crash by another path.
> 
> This keeps secondary support available for the more
> common use cases of procinfo and packet capture.
> 
> Bugzilla ID: 1698
> Fixes: 4852aa8f6e21 ("drivers/net: enable hotplug on secondary process")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

However, see comment below.


>  drivers/net/bonding/rte_eth_bond_pmd.c | 43 +++++++++++++++++++++++++-
>  1 file changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/bonding/rte_eth_bond_pmd.c b/drivers/net/bonding/rte_eth_bond_pmd.c
> index 96725071da..6a42257d2b 100644
> --- a/drivers/net/bonding/rte_eth_bond_pmd.c
> +++ b/drivers/net/bonding/rte_eth_bond_pmd.c
> @@ -56,6 +56,33 @@ get_vlan_offset(struct rte_ether_hdr *eth_hdr, uint16_t *proto)
>  	return vlan_offset;
>  }
>  
> +static uint16_t
> +bond_ethdev_rx_secondary(void *queue __rte_unused,
> +			 struct rte_mbuf **bufs __rte_unused, uint16_t nb_pkts __rte_unused)
> +{
> +	static bool once = true;
> +
> +	if (once) {
> +		/* once per process is enough of a notice */
> +		RTE_BOND_LOG(NOTICE, "receive not supported in secondary");

Since this does nothing, I think that an ERROR level warning is more
appropriate than notice. If not for Rx, certainly for Tx which just
silently drops packets!

> +		once = false;
> +	}
> +	return 0;
> +}
> +
> +static uint16_t
> +bond_ethdev_tx_secondary(void *queue __rte_unused, struct rte_mbuf **bufs, uint16_t nb_pkts)
> +{
> +	static bool once = true;
> +
> +	if (once) {
> +		RTE_BOND_LOG(NOTICE, "transmit not supported in secondary");
> +		once = false;
> +	}
> +	rte_pktmbuf_free_bulk(bufs, nb_pkts);
> +	return nb_pkts;
> +}
> +
>  static uint16_t
>  bond_ethdev_rx_burst(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
>  {
> @@ -1599,6 +1626,11 @@ bond_ethdev_mode_set(struct rte_eth_dev *eth_dev, uint8_t mode)
>  {
>  	struct bond_dev_private *internals;
>  
> +	if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
> +		RTE_BOND_LOG(ERR, "Setting mode in secondary not allowed");
> +		return -1;
> +	}
> +
>  	internals = eth_dev->data->dev_private;
>  
>  	switch (mode) {
> @@ -3799,9 +3831,18 @@ bond_probe(struct rte_vdev_device *dev)
>  			RTE_BOND_LOG(ERR, "Failed to probe %s", name);
>  			return -1;
>  		}
> -		/* TODO: request info from primary to set up Rx and Tx */
> +
>  		eth_dev->dev_ops = &default_dev_ops;
>  		eth_dev->device = &dev->device;
> +
> +		/*
> +		 * Propagation of bond mode would require adding
> +		 * MP client/server support and lots of error handling.
> +		 *
> +		 * For now just install a black hole.
> +		 */
> +		eth_dev->tx_pkt_burst = bond_ethdev_tx_secondary;
> +		eth_dev->rx_pkt_burst = bond_ethdev_rx_secondary;
>  		rte_eth_dev_probing_finish(eth_dev);
>  		return 0;
>  	}
> -- 
> 2.53.0
> 
