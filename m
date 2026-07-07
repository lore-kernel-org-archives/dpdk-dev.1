Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05802C43458
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Jul 2026 11:04:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C2AD40264;
	Tue,  7 Jul 2026 13:04:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 472BE4025F
 for <dev@dpdk.org>; Tue,  7 Jul 2026 13:04:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783422285; x=1814958285;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=/5vDs7pdnWeiS1bZOskz9+WYlzP2F8FlQwrw1SPCDv8=;
 b=QYIMwPl2cohFjzfHa4pLjDYymybQ4PP0OrD9/XZ/J/Fq1Ml8Hu51Kpg1
 H8BB2n4udCMbcy+yctOPrk0Zl7GyA00o6t0b8ArJGA5hvUXpcW5v7nZT7
 5pdLBYf0BQfz6W+zzXrxOypFGQRpiuyOZUBtey/O9j0cJJ627ehosqwlm
 h6/rqCUd3kX35tz8rlg37/pi8vj7po709HAelmkc0riETvHfNWnWCxAt4
 6TEOaK40aaMp4/JurMFMw04MW4NANtlIRogN3vJ4Elpmithgctt6/gMNa
 pGFyxu1J0JI9fopZkymDHyU0RAtg9kcXw1+8yCTLFAIag661GhizLrUid w==;
X-CSE-ConnectionGUID: n6T+FdKLTAuTA2JmB67SCg==
X-CSE-MsgGUID: lSD8aQxCSVOOfCqBWw6JXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="83928225"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="83928225"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2026 04:04:44 -0700
X-CSE-ConnectionGUID: 9mU3FnLaTdab0W8PUDRsmg==
X-CSE-MsgGUID: +bP1AFu7SO+f0DZ86RPDew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="252223535"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2026 04:04:45 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 04:04:43 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 7 Jul 2026 04:04:43 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.37) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 04:04:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ShnWkPqcVm965+XWDM4wFrou7fbIuXOwDkInpWMwA71pOfe0lA53mUyrcJG5TqfkWfwl+fKY2b0roTyCk2lQAxJL0gEp+5Moid4Z3on2Ej3Sjlxg9+jDBCd16fNoM/Bmzamsw9YexVbzTvGbTaRFGSl0jZ6XHGfqeAiKtADdiutaBtJj6+wQdBcVAozV6uE8+LQJqz2G+Yc7kXM1sfu88HUrDa9DS6ci6wjZibNq/KnJ2wKzzcLrQfNTq2ttkH9XF6IiNl2tn8u++6UkdtXlTpKFHYt6HmCbv6o2xgPXUVFyCH62rPjho6aHnTNSMr5FXfzHgh6yJUe0OxMj7LvDlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ro/VmOCvDNNuTxHmgUFZOfPFWWfihi/MHhGAiG8TZUc=;
 b=qHScfKM9mdMudyTZD1tEfDc+NIycgnlCcFEnpx0mPEPvQ/zU/u8OWwmx1bzQVdkMEWT1Z5OmPKmsHe5yVa/MdoNP+H7Oph+oxZpj7/RNZBY65s3sZIaJsj8PrZZ+ONQSOIUtSSwZD8BY8XIWxy3ke+IZQsqa9MPIiS6WMELBJTLbqmU2xenBm5JL1QZycIhwmD1Cuz4f5LQG2dvZimEB8XrfSH+DQudD4bSgajEl5ws1HVB3PwS5wktBcbRX8l4IpMA9STNaNQzo2L3rBt5bhGxDPYoUg/dUeEjB3lZp7yOMJIhWQ46gKBWfCLdDK3kgNTRamVtEfVQ2WhC2CrVASA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by LVXPR11MB9755.namprd11.prod.outlook.com (2603:10b6:408:389::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 11:04:27 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0181.009; Tue, 7 Jul 2026
 11:04:27 +0000
Date: Tue, 7 Jul 2026 12:04:22 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] dev: hide internal type for device comparison
Message-ID: <akzdNnQ9ol9sY1-p@bricha3-mobl1.ger.corp.intel.com>
References: <20260706150636.839560-1-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260706150636.839560-1-david.marchand@redhat.com>
X-ClientProxiedBy: DU2PR04CA0052.eurprd04.prod.outlook.com
 (2603:10a6:10:234::27) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|LVXPR11MB9755:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e7a1f08-c9a7-416a-ad51-08dedc1782cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ZIk1sq/uPXQXiSYBzTjyW5S/BRu5EdFQeLXG/0u+venjRaOqJDQ31rYPci/yejNR27+ALqrO6fVyivrFcxWQd+gC2wTbRadni5G0ynMrhHmNVrA0TRyBzpmHWGgEWrNHXxgDZNC+bttbLTrK5v8+epHi90ZbpOKwhjEdO2s9807+Kl9lvhLj99dBCiD1nKzyIfJFDMNvm7bTdEjbJzATilJ5yQHDnZyvEZt+7e4+xCxWc1KWyalXU7K3SHnZGu8gKeO8+Cc35zltGZmLsqpoOudswdoNQ0JwA1HoV1DUCeylo2OxWwEnib0O0LS7HXP5hBT/0E+wQnbMb2Y74AcDWorhVT3IbRjVZE2cs52kmqV8TmwXJgtFHT7lCVfrWFZmeuheRC7PWucOb/NbB8OpeEqbaKKm/CBoD1pZmi2Kjo5zCRIKyrqOQF/DimjkGopqf8sNXEl/o2MfUU/lyD0yKEhBfavG7eCPSDMhXaJoXUFE14oRFiCFqPwhJW/nalk282sAWG07++lou//BM9BWtky1sWPZb8yrAP2xoxIBNntTCw65+cLG48V/X0MnY5YV3GXs9b1GKl9jz2Qzhp+JhSuHCyFTfKCUy0cf+c1OuNbBK/+XZX3MwQSQ02N78+UWnnUQG6kz75jK/qzjTO5ZPlk0hU8/EeCOvJu0pGOcUdY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5jztWUdAxsDnPvuDnKTPnhwHeQ277H+uCNWi3PIHcvXk6L6jIAZpzTSvYsxD?=
 =?us-ascii?Q?e0fe/1IS/iohM6mRy3sgmECLC7U7Y9o1xjy5DQel6z+SxflhxkI4j21tpDyd?=
 =?us-ascii?Q?fPYk8wkZFxQrzi0ogQowmNq+8yvMhUwsdaMjYkTzQWu8evwHrHKhc0dV4mD+?=
 =?us-ascii?Q?AqD1xNZAREFH0QrSQEak9QgCSakryY1bwTHgf9QGZ3wbjt5esQ3O+8N/P6tJ?=
 =?us-ascii?Q?7fOZ7+cDr+2Pa03y/GKES92ORACB6/ugunv5k4UmPces4BUnkTwQYQyPasjP?=
 =?us-ascii?Q?h90jm1pwXDap8UH+6m9OFEkO6d20kdngxOzZBrYK4iHg3Rd1nlxKBXm+YzKA?=
 =?us-ascii?Q?mmKqQk/FwXeRfek1HF3HtaFZFNVxEL6bFJOaPtg0KapazvpykzlqqloiIKOV?=
 =?us-ascii?Q?E0tc87CIOmbQW0pjLrgAQ9++KbgwAjKsrxBumqboGCwsVPJik9AvgBO+PX9T?=
 =?us-ascii?Q?JRgz2x23Kqo+Pe01lG7HX0GGzPVBesJMYX+OXx+6zss0WAoS8NDPIsKPdCek?=
 =?us-ascii?Q?xiqq+RlvLqkEmI1oc/c0EmjKn7RTlHeVpdqrUHdfGIWwQ2cDLBRNf84h15YT?=
 =?us-ascii?Q?xK2P4PM663N/qak2KDE0AN8LRsMopRAY7L0H4Risu9FIfkueCqit5p5Bzmie?=
 =?us-ascii?Q?f5VpW3MH4v+Bim3/aZ9sFKXxyVP3R4py7yPI9kYa9/5gxq9Sb3FpboLIIv0x?=
 =?us-ascii?Q?etAyU8hGd1HTIsY6rOJox1D8sTuY2w8RDsd90pkeTKmp/ZaPHfXngJkoYWc9?=
 =?us-ascii?Q?h5mUdKT7ENFABybWbUKUZsfLcvbtnQ9yFdiXpr7GzrL6JwvvTVqtAm5gqtkY?=
 =?us-ascii?Q?M3vJ0ri+iwkaldcw2RrH3k42/Q7g+QyzxvXKjT8kc9n31au9mO+d3GWh8v5k?=
 =?us-ascii?Q?R/RIa4fJtEqgZP9EpXk/fATrs90/1uceZ/CMAM6lYfxfVYzP9Hp8sjcambXr?=
 =?us-ascii?Q?nTxZ5OfKBn2X16SeXDMDBsBXie0wfuB1hKovBwzkORDWR2ROcqk0y++MaPUI?=
 =?us-ascii?Q?Cg93qcUvdyQkW83NGPlV0CXKGC/NJZsrzBiaw1bJFDl6Y6Mbp+FhPjwb9YNb?=
 =?us-ascii?Q?RQxUhE6LWIvLBQ6FIE5HDf5QbNu5byu1K7s4eMYqZgxkY/BEDw+Say7A+BJX?=
 =?us-ascii?Q?O+euPIm7OOkPkmTJZqhnuOq1MiG3zRpjVjfQi6w/2XaUlnYRJBppvU6/N3qs?=
 =?us-ascii?Q?FvoVqku+x5AAvyOhKXhD5i72phQvZAF51ZDrHLe+e4rWBugTlQGLM3QDPiDw?=
 =?us-ascii?Q?6byW8IWlH8TKGMUoIza8XiqM4+t7kEEp6EyYIAExt78UiKuVM7I9tGpXBEfg?=
 =?us-ascii?Q?m/AcGvatzkCOWZj/1tSVg6qEWrwynlnj3NP7NkWJkdAGdBRC0T9KR4m0n8MY?=
 =?us-ascii?Q?+Jmhq1gdxC91NUl2t7UlPzTurktRFK6h7I7OWCZnZ52PGStFhQPI198u+jV3?=
 =?us-ascii?Q?EI7dEYi8a6JGnE4Ijo4iqWUwD7WwoR1XOmF/8qEthxgTywiO3fZGYP1CZrWg?=
 =?us-ascii?Q?Xzklyibhvc3uLFVLO/EjcyCa9lgP8CieE/Xi9ZLS2kinq5K4Z2Cqd+lCjvWQ?=
 =?us-ascii?Q?Zo/U+ZdxTdW5rIsTKamYszun5MjXvWK0qZxhTZ2yiLLW6YAz35547iI+VDiw?=
 =?us-ascii?Q?9qirK1+fgyRg77BuKBdQBGPjfjbUw5QQiQ6ALq5bpMNCgaU7TdoCIez79Bwf?=
 =?us-ascii?Q?azdk7iR9iLMETXfbfMeNl2WlCaQ63/YLlFzxhkKIPtReevVzR4NgwGAulUST?=
 =?us-ascii?Q?AX2440OpuGQNlwl/FoMiIvUkP3vj7gE=3D?=
X-Exchange-RoutingPolicyChecked: q5AXXz7nMpTO6u7Xi+J/XE6/ru5fKO/lWjRd4dyfAWi5/5Kihdp9H5zEMH3PD7rJw54TohdMyb252tMIw4eobVTyU7oWQ1eNfJfimkU20LrselbCHoCHCLSnaHPdpKl5b+3k8BCCR4auOEI1IwO8i+yEVj/gnFzkOIHYMsrq24CePNv0UYMO6LvIZCuF0u0TGlVdAf9dygukAW1601SAjaWrqEf+KGdpfWmb75Zv7GqYjD40/p+B7Xfq/5+4aWrwSu4xQ1Nd2/EZajpYBSBigXi0AcHkDH48PDs0Yu7YTZL6QteZICQg/U2nsnZ+CuqvaFRpMstH9ytwJ8TVHBZUmA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7a1f08-c9a7-416a-ad51-08dedc1782cf
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 11:04:27.2055 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MEbt93OJVH0cIsSWk+Hp+i0nsp8BV3r+jDxe4zQ1+scvfTLtUMwsPJ5lAwPmsi+12qb+z7LmujapnbMVMAL1xiEwJDvH/V4onH2eheKX/Ws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR11MB9755
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

On Mon, Jul 06, 2026 at 05:06:36PM +0200, David Marchand wrote:
> rte_dev_cmp_t is a type used only in bus operations.
> Since no public API references it, remove it from exported types.
> Thanks to this, we can remove the dependency of bus_driver.h to
> rte_dev.h.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
