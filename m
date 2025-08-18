Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05433CA0ED1
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 08:01:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F234740267;
	Mon, 18 Aug 2025 10:01:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 967034013F
 for <dev@dpdk.org>; Mon, 18 Aug 2025 10:01:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755504095; x=1787040095;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=CG+lrg+45J35mR40JyjnO8Nwn98Fxs7HEMMwHzcK8UA=;
 b=Nc82DUUb0dMhy77/A7UblFTSmHoizSL/8aJY7+rpId2t8gZO6qA3E0v+
 zzLdim+Bxc0d/pRiBxP9PJz6vW/+tgBXo+uHZ7xrgb5r24DKEQlGdvPud
 G4E4xfPyBsX1stNqWqsEouKV1Bzj8I4oTq9LCUAF1qza8pL9k2pb6+i1d
 JAzsX9kkUb5XcCBytXJ30khAY5wJMPmbcco1xgsGKqVZO8uEktMXeaR89
 +ClFPX+pqq0XGQOCZ+rLrlV/A+M3vxBweCkanxbAuDDeSG70ZPylBE7my
 FHGGnIJmlODZjg1JgvhbrZBCVfMxYOXwWSbOE/BFFcn26y6VwHvww9VY+ A==;
X-CSE-ConnectionGUID: oN+j/pOvS0i3r64FG4yTWA==
X-CSE-MsgGUID: b2pVfkNQS7ulzGFxfKqYoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="69092529"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; d="scan'208";a="69092529"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2025 01:01:34 -0700
X-CSE-ConnectionGUID: k70a3gelRL6hG9IJUxHbcg==
X-CSE-MsgGUID: qwerRgEBRh6mfpJTL7aooQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; d="scan'208";a="204678359"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2025 01:01:34 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 01:01:33 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 18 Aug 2025 01:01:33 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.48)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 01:01:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W6b8yz3BsoAXACysd9hgPNnIR/daV5j+A6QAvYnb80etnhXHX8sGFfKTg3IctkJSJ4Dz4xf/nVc/fpoS6Z42mfdRgINTmbMTtBGep45sgvzNctqmqHP8v322BavbBP/wS3AhHYSFO+mHG0mZSQW3i6LQmWQ6dQ8dIQMVYoN4II2ZA/Nb0cFdReCnAsAfN4uSRKLhJjkex7kRQtgq9vBVermhPirCDFzDAdHLxDaz0JCmmpCPqxKEZ0IYZEyPGOzu1XMkPcCeHqX4UAVkV3kuIpXelOyHrL82/IgPaBNOV10O157RClmgMgW/B9ZZ1A88SvMlemSMhp8P31mePRFbAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6LNq7lK6DhBQQrk8guLiNp+jtBN736v8lM2L0kNDx+8=;
 b=KowkJqJ3fR41EYL8qZICLPdaGLMuz0XsnSbJV2WEIEychXxp2Ed4POGXZ8DbTrLLSpjAjxW7/zCxwSo38iWGgKbiV936HhkhZ69fYjxdJwE31YYWGeeTVPeUPNIxUC9OzkAL3F5waspqbPGMIV7sX1EkMl4qsv4GTu+3x7+dlhnOvhdrKftHSaSuFDc08UG3XN73SeKQk1GrudRgeLCNplqFvME3wUaOR1B0BX7FHmlFCpSBAgZFUgN30NWOLKFw8N7pZPW9r+ACW4/u8abPwepMKbgPFewmfIP6RbsPgklBcM+19yKOGsv5UO8S6fiFBFuj4ASuR+lpvkwLPVW/gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 08:01:30 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 08:01:29 +0000
Date: Mon, 18 Aug 2025 09:01:23 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: Re: [PATCH v2 3/6] graph: replace unnecessary comma operator
Message-ID: <aKLd0yuqV4wW_bk1@bricha3-mobl1.ger.corp.intel.com>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20250814212901.88863-1-stephen@networkplumber.org>
 <20250814212901.88863-4-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250814212901.88863-4-stephen@networkplumber.org>
X-ClientProxiedBy: DB9PR06CA0025.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::30) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB4855:EE_
X-MS-Office365-Filtering-Correlation-Id: 529b1793-7884-4fda-27a8-08ddde2d7065
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kZHF074C6id3iGM6aJRi20I3LYfmrp0qzSsnZvv5mzkLtiZ31HKp1LCbCd9I?=
 =?us-ascii?Q?MRyvgZsQGT0KXw/VvxAle+xf9v5TmgV8i1ckrxUM0gHDAJCqU8GcfT3yoIOf?=
 =?us-ascii?Q?YgPnyS1osShp+OBvrpjaeO5AXrTSMB3SnU7cz+1Pe4LMK4tetiMBLv0u/4kA?=
 =?us-ascii?Q?AFgZE24JtSuUuP0dPTiyMPaJLVTmLa81ST6/4kUS8siaSg/6PwJm4AF+pWsW?=
 =?us-ascii?Q?PUF3LB8jYcpGH8CNptbA454XEUvhO6BXtIcla8viWyh6FSxNdz2/ykG65v8g?=
 =?us-ascii?Q?zzY2EfJ28st3MG1VY0wXMMPResd7zk6eaKvNE8Xn36Tn8cgk9Da9M6SgIxeW?=
 =?us-ascii?Q?nMLg33RZE2TV51s6Qbz0O0eN+9gKeh/5zDiab2BrS7mnEfTf2gtcwbZ7bXDz?=
 =?us-ascii?Q?Uwhb5mXrOyqXDuLuv0eslN5M8pTtrmvDq8mJIZJz+8Na42fCas5w7Z17DExd?=
 =?us-ascii?Q?f2LVJJPXKqH0APJ/4sbhdZfZEADzottESCHcUGvQdRKpe4/Xk8SRrAZQANne?=
 =?us-ascii?Q?MBpRxw0a3zNsBiLflsgVBnmP4QO7+Y+ci5MlRTZs66EENZ7KOJbIlbz/eED9?=
 =?us-ascii?Q?j6Xf647BuL8nlMiTktehxqQXAcSHx6YizyLDc15bO23hPEe/O7ipSwDqdjHw?=
 =?us-ascii?Q?hsFjE4qQhMc7TDi/21symtFDhrQpN4mjF/gYhIdTAr0cm0cUw3MHDFcTRZ42?=
 =?us-ascii?Q?mmyS6/4pHQs33IW8afU5zXiKf1QjKpvtgmWCFhGX4nFbeJuXyx3LqPxsp++5?=
 =?us-ascii?Q?KFb0iK0FKfDah7gaT0z95o5ySUHmQ+uyZEDu8/sUZtvwrB1iGnBTrcvDK8Ht?=
 =?us-ascii?Q?cqoVvU8m4+tdSWd5iZ5CN8TFAdNJbVrVQW4RU1RfPYUn2xE9gklILMcS81Xz?=
 =?us-ascii?Q?7SYRqPB92mrV1ZkHYlQ7IY9EvG+CSBmr9yUchnbFqv+Ie3yonSJmEA5E8sWo?=
 =?us-ascii?Q?g/SatgbE7oCWkLnv18LTYN00WRV+wsp8SR8S/FXn2E0YkFuQZNlBO6XiFu31?=
 =?us-ascii?Q?NXxMoFmeHnKyaivMuLaUwZN7p7WhlfZkInLeqiY+AH2g7g1CN4nWlTdxqe3A?=
 =?us-ascii?Q?PW72Jru4cljPy6vluEjSFNiVNRx56eSQ1fhaqQdMpBzMgNNevkfCAdpY9Z1E?=
 =?us-ascii?Q?fQuRGknQF71SP3Yrx6gpz+hjAAfalvuHRxzKhI2L2jdeqmCph+NrNhWer3yk?=
 =?us-ascii?Q?80yOSVgDXKCqw9M1HB1CPw9DQf6HBueL5RElS5Zs741DsUKUrRrGdytjTABI?=
 =?us-ascii?Q?ZSUJqyKarT6k8WQs6kJJNjJfkmUYRi1tnGeb5jZRpgUt92l7WLnciMS1dnSD?=
 =?us-ascii?Q?EGrTANJok9znmO/fq2sPzksZf7QazZbBan5YV29KtS7CwqiwfzBwArsi+v9z?=
 =?us-ascii?Q?ux1IeWivzOVw73cg4c7CgZXGnbyRH28gpt0oBjNlV60JogYMtAuqBoMIiIkp?=
 =?us-ascii?Q?oVGdYDh7VNs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fE5FDeWFAK5gC0r09cKOg8pz4SXEwh0/aezrCdk8eGy14pluMPFmYQJ0js7+?=
 =?us-ascii?Q?spabvZVbubJpDIgMZImzkjqa6mRN0eqZZdJachT0Z1Q0btDjgJ+Ak5kNjcQx?=
 =?us-ascii?Q?YkWmxK7DnKBVoxLUnvgRCYr9iX6OTMw/FptrPTAZMMnDP8lZI/06N+hs6DLO?=
 =?us-ascii?Q?mEAvtd1KqrjE2zMw/GnfCTAFn6wu1e1C9OEGdpgwdLq0gdI3A8AEuJi7ddfp?=
 =?us-ascii?Q?4SVpDg/SlJ7CHvYH/IWoxqNl33e9Q5jsl/+gm/Dn9iEnjfw1gJFZEkON4ec4?=
 =?us-ascii?Q?2MesfYO48LKOIMUvHxqyVROuONuPQhENEolypRZHI0ecdXmcM3zKtaaHzq78?=
 =?us-ascii?Q?NHYGMaM1Hn6WnSZT2UR34bijsO3nWOF68af2vvUe0stEaKZm84IH17PmJBXg?=
 =?us-ascii?Q?qrRfiCFzJjv+pQEmG3iAxGUmEhcWGu1t4xGCzaEQkjl9VgEXFQoIeqTbJP9K?=
 =?us-ascii?Q?47rvy3QtZ0CGQyFS+phg0zo1yvNqhE/VE79rvnE2iRWLwwgFuN0Py2v1m55R?=
 =?us-ascii?Q?cjjJgQlPwZX218VDhNJWnk6VadaAHX5YrksK8uAqnw97Ap4bZQp+buMAt1Xi?=
 =?us-ascii?Q?lXwRHNQ9b2qW4DFwhDCxOnL8/jtLiiZY6V/apKiPgePYt6ftpKkxH9BuD7CX?=
 =?us-ascii?Q?iIpeMozH9BmtSGGG8tT0yzApW42ql4/BZFX0Gp0lnZU6UjvvJdNKaOva7WCr?=
 =?us-ascii?Q?BlywLy2o/dwvBk51EAFLdJ3+ogPII9ELqwypt5GGMQm4y4/aqeSCrGQ0opm8?=
 =?us-ascii?Q?u77P5PXShh1POwr+k1GmGuUryreJaBzhJ4KRU5VVHLqf7FWTsj0OlJTuPR+F?=
 =?us-ascii?Q?elz65eOlaZd44JOt7idmx9ztI27N3hIEDUVsrCbhtWQ6REQStf/fZ4S4srmX?=
 =?us-ascii?Q?zQj3VkJaTMA2xA7/djI03dTvi9S9hBUEd8JaY23YbOn2KRu+qJtOPk7y5Oq8?=
 =?us-ascii?Q?gs/QaQKHTwUmP1eT2p8Yr1oyPw7rvuktbYsDoLH8QpxxuHW1lYG+NFPMOhAL?=
 =?us-ascii?Q?BYGeBop11AyrsXyXJuU/yvZp5lVzlUvCfHD7FLRo1XYPAy0xHYQ464/H7ypS?=
 =?us-ascii?Q?Qa40yIV7sIH8zB7qSXEJiuplQFDlhM6LWapqDc1FgNy3rGtLhdGZxaP+07mx?=
 =?us-ascii?Q?qglO5kuBXAvzk1lC2JHzm4IJ8N5hbLT8HOjnYkG281WI2Td7sqsn8Uc2pGk6?=
 =?us-ascii?Q?4W54pEThmTV/Of9U2+Fzvt1BshY47J4WccZ/lvQJtlm+vdJQDG1M17XXC4Zb?=
 =?us-ascii?Q?5d9tN9tNOq+cP7wPgRA94GS7kF1W/kiMfymfYusGoQ/S9InHRTTJgJ/dBYFd?=
 =?us-ascii?Q?N/K51UIZJGqWBFZ7mG0edP3RZ9D1TScQTTog6NcI234ex769hCR/astt6Kec?=
 =?us-ascii?Q?wbevMsduHB/IOk2qKCNcLiGLgPkisE31DKeAtnCqh9Xz225JQfjMo7Ck4J8q?=
 =?us-ascii?Q?J/AstU3rEnZbmI7+M5t6CVYbnumY6MD5pAxMkfKHkWiGEZwQpIICauPJIthP?=
 =?us-ascii?Q?a/VBcnllZpjG079K+Ors2Sk5kY6SYCPm5XYjexCd5aPSIEAxhxfrpj/NgqDM?=
 =?us-ascii?Q?ToYyENd1Bqh0+QXc8Yo4GEB9UHAWBLMghPr9adks29rLTJgfrdL5Wvz6FEm+?=
 =?us-ascii?Q?FA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 529b1793-7884-4fda-27a8-08ddde2d7065
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 08:01:29.8675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oxww9Mf+Pr1OqHX6vX8gaaU8URTbu4vdhGGdMnlMH/38ANTu1ORf5+n2/6LEgt5uELwz5NGWZc9WMIDVMauAHRMgBlPyRoI7BzTmCPXdw34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4855
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

On Thu, Aug 14, 2025 at 02:28:49PM -0700, Stephen Hemminger wrote:
> Use of comma as statement separator is discouraged and
> reported as warning by clang with -Wcomma
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/graph/graph_stats.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/graph/graph_stats.c b/lib/graph/graph_stats.c
> index eac73cbf71..588508b473 100644
> --- a/lib/graph/graph_stats.c
> +++ b/lib/graph/graph_stats.c
> @@ -254,7 +254,7 @@ stats_mem_populate(struct rte_graph_cluster_stats **stats_in,
>  	*stats_in = NULL;
>  
>  	/* Clear the new struct cluster_node area */
> -	cluster = RTE_PTR_ADD(stats, stats->sz),
> +	cluster = RTE_PTR_ADD(stats, stats->sz);
>  	memset(cluster, 0, stats->cluster_node_size);
>  	memcpy(cluster->stat.name, graph_node->node->name, RTE_NODE_NAMESIZE);
>  	cluster->stat.id = graph_node->node->id;

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

