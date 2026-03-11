Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03E41062889
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Mar 2026 12:33:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 99E4E4067C;
	Wed, 11 Mar 2026 13:33:16 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 14D8C402B8;
 Wed, 11 Mar 2026 13:33:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773232395; x=1804768395;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=WZVHh9tjnicyHhfiYwEzDgZ+zN2+t2S3KrsayLZHHLc=;
 b=jnhBQrU1p9a9NgHbQ7iMB4r2PUOHlk3cbOp9NTR9r5h114orV/S+3baj
 kam/ya1v62bKxnhXdU/Clhp5opfgvlvmLFUQRQy1CEt0+eWyl5bjc25M9
 8mnVQtBDZMOJtyIJ5VxdSaGsVfyKFr5Y2D65pg2O1v9tD5VbiizoibGda
 cjJVRhSx1B5mIUNz/b+xTe1bXKMo1mC83Kb7KZy101V1IibZALzR2tsz8
 j3UdZTKrDfVhXeCtOwJ8sbFqhhI0ulbs+wBHBdTBGgXL+czTDAbN2kjcp
 OitFdupQqwBSlvHNmO3PZMJECPnBRMo3nphfAm2W7D433YkYdwYMlYUPA A==;
X-CSE-ConnectionGUID: QOfJZJTAS8e1eIQE2bhS8Q==
X-CSE-MsgGUID: b6Yu7JUERZyinT3XFyok5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="74336034"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="74336034"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2026 05:33:11 -0700
X-CSE-ConnectionGUID: MM11Fz80TAe/MTDa2KIhrQ==
X-CSE-MsgGUID: cFxsLLCvTzquFNzUnTwUbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="225149224"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2026 05:33:12 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 05:33:11 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 05:33:11 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.54) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 05:33:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KEAodRDP2OCmrGs3R4mImba6qM44mdoGO26OqgEN5DVFZMEWC61rWbtEd3BeO/AYWODi7NbqtfJjx0tRDKGWVKyiLQDSEbuvNC9N4pLN9Wj/jLPvChcQV6R9EDxEjFh7nHK6+0MvZ4xC2We7lBXLw0fw0KmFzfBd7jUeu4QqlqmEicO+Ppi6axkQ9AIpLhP8/VIoEXKaQpnN3NPjsDTbkmrvPt5RmDE1w5IiYBVb2Z+/msS4hujKwzoqpAqqJAgCKCsz6dFSFZRlrZQ/9qVeuVJX+dCwTsTkk2eXLf9mYbuovvJfHGmQV1Qw+ftVyNs7olka6X2mNPHDPQhiYwjL1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbLed/8w8FqRbaC1iyiaHws1nnkZ2cFaoEiZ1Y9ZIXU=;
 b=AwWxks+80YZh9vfUVvXPM4e3zhv72NOxFp4hDUbnv01SV3jLZ6o5WqTFsG9E7rs+OYSLe5NU8W649792yMsgXMuB/kyopwrxYQ1j+sZWKZLlQesIxQprMURlqXS+wjSMTV2C9ikDUTjbEwIgToVqC5bD50Q+j0rIt2XAHWGDWM8EYd+qJXb4e5HNXFUyckiPlxqG8asTdNr/iBtOhAAa26ZAnJQgD49dzsesY4Qh2WxnKWdidRhYFOF5ngPmhzX/zYmA7F94FEYuKyvClFGRuXjo0S7ZAriSLpP5XdKHvmtdmVRNzptnfJjq0bLPeynGV/y4tRwQrOKQg7uu+/OcYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA3PR11MB9015.namprd11.prod.outlook.com (2603:10b6:208:57e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Wed, 11 Mar
 2026 12:33:08 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 12:33:08 +0000
Date: Wed, 11 Mar 2026 12:33:03 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] net/iavf: fix order of tags for AVX512 Tx QinQ offload
Message-ID: <abFg_-lDPbGSTg3u@bricha3-mobl1.ger.corp.intel.com>
References: <20260306151032.2640579-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260306151032.2640579-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DB8P191CA0008.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA3PR11MB9015:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f26b7dc-7897-4570-cb7b-08de7f6a5971
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: tvN7eufK36rvYZJSL82adPehujigo/KF/C1TOd8vK9GLmvoSR+JCJEpi/ZA6jP+KAl/PrRE8dScgWd8tLEFvMWt/y1SOW86JgDTPD++FjukkLZ/BuwneOYJ3QPmlML5gx9rAKH27Vb5CMqYJSWkzQFiENgescU1AoEUoJ6nx/8lG1Y5F+YGJYH4eoHKRkFAMTQuUgDG3KvH/2kX+ZLFVT4E8zv1G2VdXu27h0AvkT/fZ1p9iINifm2dp6ztvoLFpvfu9mk8zNwdVcPxgHy4iUqy0Ijsawdc20r+o63AQROoYv+SgO3ZknSHId/FaEnXHNUyiJmpsHhK4k9iTHzFt05wUMqpWjEpb3QpvAJ1PezGUOK9Qmkd5QYve/e0sE/h4qWFD6LdfvAac7Favzy0dcd/WI9jbYrSFlhT/TrBg2R/yejlVmqDbHj0iQ1qFV6SrDhjp6ZOfPVH46rwsAI1qmHry99HjdCJd8gQ3i7LZP4XZuE2V22Ri9W+KrBu4Hc0mlkwtZUQFVNojtzyO3AifKU1+u3Nj3p9cDkvAd1e2hCaES4MNEFixZXKNabR040CbiS7o6d6vF7LRobDOG7AixTD1f2le+62zqzYWQ7nzrFA/TH+Ww9i/9AkW0gsXGl8nD8gFVtWLcIxsdGSNEG8fRUUVsInUjbnpAgraoyB1pzT0sKz1fVL4lzmI1wg6n8f/nEBRdsW+7+e9FuT1ZwYvtRFZZJsnWSKyVa98+5BjhuE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZuQzHRkHSlar1eFAaKuqsSW7Cwe60ghWk1X2vlrceJ7zBLBcmOg3zR/Lx7e5?=
 =?us-ascii?Q?1J9NeiXa6g6/P6ViTgfvLIfYAJyhUFnUxZQXSwpJoYLdA4wkE0x9sFQ46UsK?=
 =?us-ascii?Q?fmDhcJdL5BO9aRFRzXnmfdrQRuWnmSj7oSB/I5j4XYcG4WQ00+V38ubCEjgY?=
 =?us-ascii?Q?z0TaB4xcZ/Bnevc6iU4CWCpYBeQllXjOq8lv/YGapoEI56CQiWjJ62BbGoDd?=
 =?us-ascii?Q?TkQR75wBTOf+KB8/BP3X48UN/MqwuNlhTwfX49irpI0hgeM3Eb2MWHudnBfz?=
 =?us-ascii?Q?eOK/OUIFpASryYNo1ipP31R6AIk6C/Bdqeq6o6zW4MibYhHJ6KHgMGG2+iqS?=
 =?us-ascii?Q?juaIXO4PvpxCOgDwOg0HSHehxys6NION7iheidGelWHSma/MF1YLyYNTYZJr?=
 =?us-ascii?Q?VtgsMEiPYeZ2UdA9nFuKtHcNkew8vkDwJZsM2dj8LIMf6eOEsX2eTocZLli5?=
 =?us-ascii?Q?2IzK0L8JolW/RQChjmrmspSrEl6gOIcQWnV/8OivS8VsjdS8AvCkNtjbUBqs?=
 =?us-ascii?Q?X8KG+7lQExJxNIaorgR48UYJzSZ+uD5L3c4rQAY4tQ1Zy4UBM80YkFofJeb+?=
 =?us-ascii?Q?B9vTKQIVGweStOE2oS/nVsPbYAXvtuYkM1mKXkl1vZ/h+FKph1NOka7fnnlS?=
 =?us-ascii?Q?0b0SvfGjLjJiQcdplZZ9HhWKc4U5LFY3mN6IcG9utsl3tTIlp1yOj1/AXDj9?=
 =?us-ascii?Q?IbLWbxlnAsz7G04vAZS8lxkIp/EBpZ8UN2ZnrirbAkarw4mhtL6CIfSDd6pr?=
 =?us-ascii?Q?ZlFTTa4wp3zCG2EQcEnTOwXzNX76n8JNM0Qje8C2S9nMyFpmHWueYOY0p2yU?=
 =?us-ascii?Q?P//vw/PLUidS0SpsT8tX+Hrf98K3dzeJ5JmsDG8oGSjVJBxwzagOHv28w6DC?=
 =?us-ascii?Q?+09Otahx5UMzFwSJpXLgf9KsfpPz5k6NwpHLf3lHDQxmTLRq2oB5t9E0xEAJ?=
 =?us-ascii?Q?IiNeg6nnAN30uHMS/SOUf7hV5YqMKnmCLiDJE2iIpWgfcglhqbh3VuK2LacV?=
 =?us-ascii?Q?vG0Tmn1wTr4+i1DY+WfpR9SWiqQfHfUtMzclYTcXILH0y6QHLeGzYv8UNFw0?=
 =?us-ascii?Q?IIf0OUNjaII42OhTar1mgdR0BjUt66OWVYZpVFT438R7ict4Y/2Q5bMpWQTh?=
 =?us-ascii?Q?l8s85dYgDlZAOTyQ3bN0zGxOQpg128U6SQO8gGtLwGB1Aj7KCFLEedtghc9L?=
 =?us-ascii?Q?ehZ//qLc7krcAmgoLfkhfsvuC1aW8zy1WP1UmjuiDKg3qvoe6VvqNfk0mYXC?=
 =?us-ascii?Q?HqZvkYAkotvsjelnEs0mKkf+lseyGOmym6kk/vPeEIa9p24L0N+51lDnkimJ?=
 =?us-ascii?Q?ZbKo0sY8q7zA9OPfS1mIEIyEps70Tz0qzFApvuPV6goLpADBQYH2tOd1Pfxm?=
 =?us-ascii?Q?xqhCfVvYJYRCq4eUMuTPtb4z/rvwIXagUkvbRy994X5SzPCZIrQl/S15MawM?=
 =?us-ascii?Q?9+KyGvhHrqHGpOwH46G+sT0niCGp1/JYp0XuNX/9tOFhGa4S5fh4pNyrRmca?=
 =?us-ascii?Q?61QiFAyWl5PrQxLnnW3lZ/OVIPWpbons8ZhC6J/XLkhz0AcqZ+ff2C9ckLFK?=
 =?us-ascii?Q?JV8eZonGEz747Or3nyXoA9GCVbzc/frGdV9NQMonl+505ty5Cpn/NCLkI8eb?=
 =?us-ascii?Q?omer8nY72cHY4NwIxEDXGrFtpI+ywnrz0c4Op5TENzDwIiSQYDiwOJYrN6ny?=
 =?us-ascii?Q?Jb0/COmg6Q0K28pxp2Gy32wwbq0e5YbleblufAEF3PXL/QkFIMIxT1AcxpQ+?=
 =?us-ascii?Q?K4kMjzeZOMY9D+BlwMORQ00WJfMm+Tk=3D?=
X-Exchange-RoutingPolicyChecked: MtgxyGTk4HgmsJ8Vogt7SYhCN5cCUAAcQEWyyaCynFiok8joXaUK6udpvuce29vrs8cPZuOFdpWHmy5DN+BdIa1cGyPg0TxqfvQpmabx2SoFcCluEaZzmPjcvaCrTaZEmGhhKBMJ+5KnnBIqKNE40DiLkYotP6ypXFMb3RvWrqd32bLgHBbXCc3hspVgLZKp9jeERNcUWBEcv2290dGV9OS0QSzGnn60nvAdZPWteA2cYrEQ7G2uxijBHfVikQeL9Bf2JxYFM3Eg8D1LUWq4pH8rQtZo2MJDI55veu9Xc+PhITZV1bVAdNq3BpHnFCAmm2PXVu2pRmJ1EgUEG+h9ow==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f26b7dc-7897-4570-cb7b-08de7f6a5971
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 12:33:07.9718 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UVT/D0Azd59l16BjV5PiLaI0M8PR67n7FayK+jQLM63HN6lMcVa+otI+ugYRo2jen1XS5A4Bjr3V17i1VfHGSZSLO6WDbY2Lpr6zj98yQ6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9015
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

On Fri, Mar 06, 2026 at 03:10:32PM +0000, Ciara Loftus wrote:
> The tags were not inserted the correct order in the bulk context
> descriptor function on the AVX512 path. Fix it so that it is consistent
> with the single packet function and the scalar path implementation.
> 
> Fixes: 23ef9b485dec ("net/iavf: fix conditions for AVX-512 VLAN offload")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
