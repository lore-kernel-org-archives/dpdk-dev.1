Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6637ACA1010
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Sep 2025 15:08:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A80DD40659;
	Fri,  5 Sep 2025 17:08:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 596F9402E7;
 Fri,  5 Sep 2025 17:08:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757084895; x=1788620895;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=y0xav0ZMhfzC22qpNixUi+Uf1Kaoeo5tsRYpQXL2s0o=;
 b=gHD2UKqZBsTGoRxNKMHIp9k/Jj2HDOZFrbbJuGGPxXr6DmZc+gcQljYZ
 ngTgrsyEuEp+1CqU1qG8eTBWGg3qQ4Y359LOYgTKulahnSlrrpLjaHZuB
 la7gCZYm9Z8amUuC0QECiaiNn+oEG19cSTAlia7GaZuLfoSXtLWFhHDIf
 6S/EpgIa2Vn5CvqWmfIChIKSena+mmcdbSSk9xyv5YCtKIhqHxQ63N7ne
 NHQLw/gfoTeDRZL/eRYspHeuht+FvuV1bgyrotl5N6FUyXrqBTKxt1Dea
 Z+DoGf6gvQ4Gj3BUBTijqwKCB+ta8YIq4HeAf0cTRDk3aw1D8t0USyPvU A==;
X-CSE-ConnectionGUID: n8WpcPYES/qYUB6B+ZZ6Eg==
X-CSE-MsgGUID: 6VeosSWcQ5avTZcI8gpcxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="47008190"
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; d="scan'208";a="47008190"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Sep 2025 08:08:13 -0700
X-CSE-ConnectionGUID: iYiMW5l3Q0CwLLFOJVZZXg==
X-CSE-MsgGUID: HEnLWpFvSky6UHV69mwTtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; d="scan'208";a="176280349"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Sep 2025 08:08:13 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 08:08:12 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Sep 2025 08:08:12 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.42)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 08:08:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMx+u0uYLx46q98x+L5GgDEsBTiB7v5l+/0MU7E3I4PA8bhEE4uukEHuRRPpw1c3udNxPjsVPwnB9eVGrSJwqZufFdLdiD/QIirplddcfgJ5tmQZ8J3JxEII7WCg7XlTxI7S181aV9bcJ9n7zwpZcRCC9iXr0m2PPGiMUu7Q/rlBRqm+RQSfpKGjsI/JESaLWrEA9tllPEbV7S5rn1Myxy8jWn9VTCkGjYLOmfJblk1bQByDlxK0rrw8ujjbxep8UBa/MNYFv4GbYyPR9O9dXymaRVqsFuioBT80C9G39d+Hu9PEWXJz5L8llmr5nyyCKendzVQFd05PRBE9BC7/xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3lWHPLlkEH5q6sHFqoFh8w9K5wLkhX/NaigIuEeJUA=;
 b=JamJTQSDqgJsPrByu0HZFMe17i/rMJ8CTtVB5zGErn1nPjt1TaLvklF7sfnWOEJNZFG92gq7KvfTJNfplTzuy8sigxIFERRv/agdhSsNlZr1rMDCflnX9v+RFLa2LF7jqQgw9HT5MkoqXjYVtCmXaHOkWFfiBSnea6UlE1dmm7hf7LySH7ZKWQHsIbemwa5xGq7kwIa4LgQ2bhszXtR/3Y6FSOweQlLCe4kBIli4EuVNd+UNq3XqyxIXSydAA44tyeZJF703fNgCdr/bOf0qX5pxV6AoUpQoX/W/b5SNZJM4Ql65tWeTObwx/KvUDMo4YNBz+pqGh8o7iFy15Ixasw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CO1PR11MB5092.namprd11.prod.outlook.com (2603:10b6:303:6e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 15:08:09 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9094.016; Fri, 5 Sep 2025
 15:08:09 +0000
Date: Fri, 5 Sep 2025 16:08:04 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Qi Zhang <qi.z.zhang@intel.com>, Junfeng Guo
 <junfengg@nvidia.com>, <stable@dpdk.org>
Subject: Re: [PATCH v1 03/12] net/ice/base: fix memory leak in HW profile
 handling
Message-ID: <aLr81HYY7JdV4yR4@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1756833701.git.anatoly.burakov@intel.com>
 <33597cac6faf31548d3a3e0a07eeb020b000479a.1756833701.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <33597cac6faf31548d3a3e0a07eeb020b000479a.1756833701.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DB3PR08CA0016.eurprd08.prod.outlook.com (2603:10a6:8::29)
 To DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CO1PR11MB5092:EE_
X-MS-Office365-Filtering-Correlation-Id: 847c9a41-22fe-41c2-4a41-08ddec8e060c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0KgE4B1FRlSaf2kaQRkwAaE2l8cp/8U7K/Yg17p7FDsCwb2z6kcerQDYhjHF?=
 =?us-ascii?Q?gmBvkq69hK4qIEUPA/9J3k5hc+1T8iuz7dKIM/nfvLjmwfS45+1N9woRmx3J?=
 =?us-ascii?Q?g0Q7Iow+LTtc6K7em6dV3ncz9EMb7bj/ee7BYh6gTqx79g4i/eklb3DjgY8J?=
 =?us-ascii?Q?PKXDVpHp7567gI3j/nh9Qtl99ZD0U5lBibDLfsXneqMLInCTKtOTr7wek+DW?=
 =?us-ascii?Q?Oi6FNegk+wvpLUP+ua6pcO+nveSo9npysgopjDUXLkuXogKTuovcxS8C2pz7?=
 =?us-ascii?Q?2mPbJvkz1xrmsgWHm3g7hsgk/o/htPLs5foldSMF/3FmUwiG6hnNNZhR72i9?=
 =?us-ascii?Q?eSuyTwk9nLU1TN58/DB8KwjjbYJofiwCjevn/k1w/Hk8ibiOFJE9DXVjAj1s?=
 =?us-ascii?Q?iu9OQlgTPxWZAEllwhXHQJxOzhFH//X6MJG0COdGvd1HUI1bxfZ/TYFUeKg2?=
 =?us-ascii?Q?3qMfrT8zQUicqd4ePh1X5ZgLODD3Fx8KSOdYEl8oR7SIQpAprJkhTItAUSQ0?=
 =?us-ascii?Q?6uJO5OqFpiWwRK77bHnVRDJle5lkBqt8KSodkTvj8nbooH+42vmPxnb3OyOu?=
 =?us-ascii?Q?VBBYRT+yHPogY+FDmnNX1KBSVJ4ZuAPVISh3PHm0EAfuqegI2pp2u5lD2FNM?=
 =?us-ascii?Q?iXhOm4IqG4PbUjJZXu8bXRRuGJmSRUydgbcwRvNNxdG2NsbIPBO8tYmPt4RW?=
 =?us-ascii?Q?mY/rZk4DUeGuE9qSUNv6jO5OAGoYjdgk3NbBd/eLsPgyHb/ZoNhynlZuNAnc?=
 =?us-ascii?Q?KCzdMdt934s8ETNbzu9QoYEFhuppxwaTeudB1mvSVyQad7LNLywoHylu9fPr?=
 =?us-ascii?Q?SDg/o7k1GiCr4CvI6lJyzPHtFxu+h4Rdz+ZSA1tY2BEV3nps/FM2tgNycTYq?=
 =?us-ascii?Q?8pV5pXZx4z0jWrDRxKkJpOH5KU0oyej3I4jTEDSKcFoHQuIsgsJuJZZZvRNc?=
 =?us-ascii?Q?Ac1W1KOxaNJsIaYLzENzBRIK0Wi+RwZwOYhbgCu1GySDbOoY5N/7hDYkquJC?=
 =?us-ascii?Q?//4GuhDlqn0M1QcKum6WVi7IdhCe4sKr69LFVMZmlvFc6S0z1yKkY1QgKgnq?=
 =?us-ascii?Q?Ve1/k+lhiMRqejulwGI4mTmdnKg3MiruMPxuOVpTd3Deh0SEKGNOmGoxBXbN?=
 =?us-ascii?Q?41y/m+wi02HihadYvg2CIuniW2d4MlWVggsRobbEuZthCBM2xBSpGzZhF74D?=
 =?us-ascii?Q?urDJYTbyz2WybYp5xSIcwJLJoF/o4DlVCFfDHdnOw9j6an+JuuHwvG1mJuSn?=
 =?us-ascii?Q?Ga/hM8I7x3SbQxpx1blvc7FPO/9MnXkedvNz7apo0/9NiubkvEIBm1YS6umr?=
 =?us-ascii?Q?2D6P95dQtFC4h0etarF+APuEWMnByCbL1BlW1dwpItEGwQz90/Y35vqYhUl2?=
 =?us-ascii?Q?8d7LOC8/7O5lU42/Jo9s44d7tG6pYTodUFiAN+S4F4aYtBAf9952+AaCg4Bz?=
 =?us-ascii?Q?Rvfw4NcWiIo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kEbj669hyRt88ctFtCEtRWNEyttbzTU0SD01RGBbXZsW3MLIpx0LGPI/xYF3?=
 =?us-ascii?Q?KFY6SBuenCVpc8jXhWlrxEcopRWnOzcTNi3HlEFs7CRuVxq04JoX0ADeFUZe?=
 =?us-ascii?Q?+OigOFP/j8LsN7iX/l9ulC2CgkHex4kToYLaSMs+AtqY7AnnjlTlf/SsYwbG?=
 =?us-ascii?Q?vw4+kv4uXEaHblPq5noIyCb0uCaEECoBfZDVSjQl304fbo4SuhUCUgomkyNs?=
 =?us-ascii?Q?hZcbmCc8Z4hXV20B469HTS5wKkBe78CBE6UJjGcVEsSBTlPZm7E5mOPH0qg4?=
 =?us-ascii?Q?uaG8zjHfQe1NlQ9AacUZHB5cTyl8sGFimFf9cHV0j23pU8xnoefQDDmFrMi7?=
 =?us-ascii?Q?Yfh/o1ZyZi7vaWBQAyz1Cc/mh3GRJDL5H0vSpMeRs3QExwoMlNykr4YwzCn0?=
 =?us-ascii?Q?wwul38DPB0qRalRfLIk1YVJzyHtDqPrpiHGkufkh1DmrLpkCHg6gYHoEWqGv?=
 =?us-ascii?Q?gD/nQVBVKVxlxfYMgNJr9dofnHXMl44dQZF8VBfVPWN4IbsTkPq6JLL2TCFw?=
 =?us-ascii?Q?J2KFXmRuUaMB5LgiELr2mdlxBLi3NJV5+xFGJYpwIH8BXYVUqD0FB1QPzKtI?=
 =?us-ascii?Q?hfMEqzn6F7ppx16Sai5BuGJUNzlyCuwyOof8IPvbIzvWHk1m9XPYRcGN3SA6?=
 =?us-ascii?Q?BbajSDQR6pgqGiFKN6X4A474XYADGEyVHiZ4okWU/ULZRXnHiUSFlcD+LiMQ?=
 =?us-ascii?Q?F82KmNPKtzK6oJzRqP72PvjJ+0+qdqZjGoYnKfpvXxoKQU0f93BFqMusawbm?=
 =?us-ascii?Q?kIV0XC8HJG3FhXWGU2Cpv9DvMD6uzjxYQNbZGJUkBOoPifQgQVLx/N7Paban?=
 =?us-ascii?Q?gxWzqf0dGNQ0zlHkRvaGgI4W3Tsi6tcaqtEbyxm3PvGRbE8RDXeWMEoyyNFY?=
 =?us-ascii?Q?P4LhTDumpLw2h5IFU49u8DncGMYflH7WH3hKTAJCacyomex2pswRcLpZuuIR?=
 =?us-ascii?Q?3TDppFANQT46ooLI2Y887sF0hNDEbnCY2LavDV6CZ9lilRCLugcMPieKnk7c?=
 =?us-ascii?Q?V9t9QjmditHV6GPIbpjzLiogCRBR+GGmW6rZ+gsrZaNqYnHRNVYz/5gjScFc?=
 =?us-ascii?Q?Kojo+DjHSwoOushRzZ1C/SdrgCUSp9GmuJ7W5QyjrfKn+lrP/QwlWd3G2vN8?=
 =?us-ascii?Q?db/uTRrS34XGzG09ICXE5hYRX6NJdeT16YVRcIDcZutkHsfelaTqhkTtEiVf?=
 =?us-ascii?Q?fT+OKw+1hjKuwNihXKuw8rJthnaEb+1dLjASYzcUpWpOQ2x7CeCLzC2VFcgN?=
 =?us-ascii?Q?zfbukockB6zXOhvAno5tsLX6B6qW2FQBtfxgWEmprZexcVmCfyWEP5oYRpCH?=
 =?us-ascii?Q?cms1wUhUn2Df/rs00/L3WO7ozP/PamHFmpI9rahPe2aZ7wDIgC6a/6ZGiZGg?=
 =?us-ascii?Q?x2PU26UZ8KzqkLIMVDTcY6pST/DlKn8E0wUSrrn6Mf1zN5uijmqNVWXmgkwX?=
 =?us-ascii?Q?n2XsWBWm4n9MqB4NhWO2+koRtj0fNKkOHDnND1wDnHuimmMHWmK/4PiaBO5T?=
 =?us-ascii?Q?AfubpGyEvn1qa28wlJ9vhXys0XY/agxYUZ72QbhR5HHJ1LD1Bc/3dFOIIP+x?=
 =?us-ascii?Q?2eOgriuL+xiMgzHPlhbuNCZoO458Qeun25yCRotXnlhs9wqxUEnvGUSoDnhl?=
 =?us-ascii?Q?2g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 847c9a41-22fe-41c2-4a41-08ddec8e060c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 15:08:09.0110 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +yEHR60WUkkSHxNBDYmAhXm2Lcq/1JEMiYydVUUreInK/7H8Iegyw1msjq1EqAK5Ki1OTLqkXEsxWz2GI7cMWxQ2Hijvda/WwbFQTlCpqqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5092
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

On Tue, Sep 02, 2025 at 06:26:53PM +0100, Anatoly Burakov wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The ice_flow_set_hw_prof() function allocates a params structure with
> ice_malloc. It uses this structure to hold some data temporarily while
> processing the hardware profile to set.
> 
> Static analysis indicated that this memory is not released. Fix this
> function to free the memory upon exit.
> 
> Fixes: 8ebb93942b2c ("net/ice/base: add function to set HW profile for raw flow")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/ice/base/ice_flow.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
