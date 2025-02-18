Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314FDC021AF
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 16:41:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F07E402CF;
	Tue, 18 Feb 2025 17:41:40 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 66D29402C3
 for <dev@dpdk.org>; Tue, 18 Feb 2025 17:41:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739896898; x=1771432898;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=m6wy4A9ZR5GzNrOsRf0OsKnemNEQj8plj3bcy8sG2XU=;
 b=dskOfe8biCjYugIFVSm++vsSgeTbfMoV8RRkAcBA2R2xwrSHYtzTmbyD
 Be7ZqH41bueWo5fyL78yQxtGIMDYey52yXYomGFhlfncPcMO4057EWZjW
 95GqJI5o7X2o+zfqx0wkEIpKCOC/KVoO5bsRcsf5yB3SAvkiL/kSnR7y6
 6ms43JQs0bmQyl2FD/QXo8Cl+Adj3t3xRw/G/rgiPkktbrNlgs3o8zaGo
 PXRyFW4tiN7uNq+RRG5BwE7aN0yqABYiLRXUvzUnU26yT7TkY4euPSf7N
 7q5/0Qlgrv/cAK10WIqb3WTbSX0ht60VYivmOnIuuoMPN+yVwrnnIg7bu Q==;
X-CSE-ConnectionGUID: tzK/+cKYSSWuPbuhy3GAuQ==
X-CSE-MsgGUID: mOIpGjB0RMK1VeqB6GE8BA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40312394"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; d="scan'208";a="40312394"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 08:41:37 -0800
X-CSE-ConnectionGUID: 8dMGkGsPSl+/YlsUqT8ICQ==
X-CSE-MsgGUID: VGubRLLlRNmuNDT7DM9lzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="114307930"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 08:41:37 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Feb 2025 08:41:37 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Feb 2025 08:41:37 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Feb 2025 08:41:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NAFCYClKOLIOOgeJ4OlPrpXWUoFXTitdTpJvE6DZrdALLS4yu39106jqWvRp87sGlnxt6TVJJ7rRzbY14gZ/O41HwGK3bVdZaiyBYDgPumeE9KGcEesEP8exLcc2/9mgs/2ipPBqK0G8KrwifqcgKq+zRmH8cLIywulMy6Pob8davLHgK6FnZGqD6Cl+B3rReZaTugpnQyapnz+3oTU3evAXjLaZCzOcOfvN4OACJgIwd958vCoGpO1vhGmNv2sst5rr4LjEiahgLg0rQ+wPeoBypzd0WAP9lib7FNmK4bZvUmy+UsM4IthJg3obsQiaUOMnQTt8zNYHIXCn5CiEtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dMxVRdG1tzWZsJBkNVeu+qPFHitz8r0lKm/STl0XnI=;
 b=oZJP23qvkxW4gKXh0cK31iPl7I+z18ERO9VKGttMqtmLdhN6J5lhJr0TcQSG1ueGT0caaP+XXSDGjLH5WwUprIo5XzfbPs8PAvRdHKxCHiTaKLQx1+6QOUiZWEERIrco2btdK3jFtqvCN+sQdeg0xyDG8/1L8l8Ghf6bwtJv5BjL9AO7ZWPXidafYKHsbgk0iAL7vFZNn05cuoNM0BdMmxYmg5QUQHIxsrzBV6KOEbGED35D+guTrchynk7qLP2y8uevFFcQ7KxLy2UMzGmW6ZLVM24ZIoTrMbPRLGa928oe+J77OidW5rdURIug9wYGrGy6pFQQqrBNam8ZVHRYmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY8PR11MB7136.namprd11.prod.outlook.com (2603:10b6:930:60::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Tue, 18 Feb
 2025 16:41:19 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 16:41:19 +0000
Date: Tue, 18 Feb 2025 16:41:14 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: <dev@dpdk.org>, Chengwen Feng <fengchengwen@huawei.com>
Subject: Re: [PATCH v2 05/10] test-pmd: avoid undefined behavior
Message-ID: <Z7S4Kn_tf08rMpLc@bricha3-mobl1.ger.corp.intel.com>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1739896329-1946-1-git-send-email-andremue@linux.microsoft.com>
 <1739896329-1946-6-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1739896329-1946-6-git-send-email-andremue@linux.microsoft.com>
X-ClientProxiedBy: DB3PR06CA0003.eurprd06.prod.outlook.com (2603:10a6:8:1::16)
 To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY8PR11MB7136:EE_
X-MS-Office365-Filtering-Correlation-Id: 78cca773-ca7b-4adf-26e5-08dd503b122d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I7+n8RBcuUM2cPmvlXaOpzOwD04zcmCcf9bAjaUWS+AEitk4bLCPGw+dXMHp?=
 =?us-ascii?Q?y66FO0c8XFOGYc3I11CvNUGCrvZsXNYOrXweJA8DLZJ61rgGGLnsdaWbpIp2?=
 =?us-ascii?Q?w1IbLfe/4b/Aw+KdhcVYQbxyL6Zyk7VHxQiz0o+eKcSwnLqskNq3a/HCbqMs?=
 =?us-ascii?Q?LqtLo5gI0ijhlOGG7YPq/8m/fZjJMuB3XGZvNtJnkzeeyF09xyTt4sVlrY9t?=
 =?us-ascii?Q?1JxPT02rpZgM/HwfmXuwQsmcQQFLtwXomn+NgPt38Y1QOkZ4Hkt+aT9y8vpZ?=
 =?us-ascii?Q?OY3495t7VsBK4gNUYJu6AxOOERfRHPFYkFZQBpE3ur7Whg4OpvDlAu2eo65w?=
 =?us-ascii?Q?nWZBwnIW06vYZqPFUW+Albj2m5gQLL1wgfx2CzXA6+JIvlM8cmosLlH2RU7U?=
 =?us-ascii?Q?JebmQ90f7QlK/PuMdCieB2yOpEq6SCyq8bQgx+J8m7YIis1e4seGW0mW1laf?=
 =?us-ascii?Q?a05wryetotwAmnavIEOcDJ+G4yBIdO/vdIvzli5+OnSMoF4ZwoE4YfZ+Q1YW?=
 =?us-ascii?Q?NdyXdVXIXtgOlLzHJ3iN1xmotCQlhMABKLvhyzGbCaJD1zUZbJhqXSCXc83m?=
 =?us-ascii?Q?wc0sT/Xmg2sSX6i6H9o3t0+MoBB69EWmA/s7RaOr3TyXXv6eCUIlXwbnWcoZ?=
 =?us-ascii?Q?ZOZwKvm4YMHC0CMiRo74PN36CsaNYYM+LE0ozyUzOy/Z0C5pu3iUr3Vk4303?=
 =?us-ascii?Q?7Lx3YbyTiXMvaQCuury0leaw17EWLZcQMew9azWy2yoyjStqgaGZN6xZdA+e?=
 =?us-ascii?Q?6CQytos9p9Vqj2MiYhCnwN5+QBxpy8IkEoBj56zrhcUriDNjYmaAE5N9V0Ax?=
 =?us-ascii?Q?xIqgMKVhc/nn1TMz9JpBZaBmPHIQUnFSFBWLp4JF6fuUcnimrNXPMfO780cq?=
 =?us-ascii?Q?5LB6OvbPjHTNE5x31gvHcrhwh6WsM+x5N4iBMv0EuE+KZky4tIZdl8IMEBYG?=
 =?us-ascii?Q?fbtAIpG31kWcX0bollKgsPGdWDuRmVT9h86I2SVBUG568oTxXxQH3NmuQD2c?=
 =?us-ascii?Q?EfGlla4g/fODmvDYdV/aFBZIHFeEDaiU9J+mOHpE6Rw1yfpJ5Dr4B5eFbJCF?=
 =?us-ascii?Q?IUAmtuVsW79ScU8+1SggOZxgDWShRvrIa2AohUpJmsdWe4VEqMZihaSBqLjn?=
 =?us-ascii?Q?JcjZgxfA9ImqPekHCnj8hyYYtWJDW/c8VDaylGyoVkOPp3toCYeU1zt09cp2?=
 =?us-ascii?Q?1rHeDEDgjZlFjSFChldm/biGMgvnwsB6loHUwNEjFqKqUPphuYnvVSh4Rn7S?=
 =?us-ascii?Q?u5PedoczkgLe0tc6WIWaIfNo8M2bhioeRhvkfM1bYwoEauMelRU4WqkkH3Ip?=
 =?us-ascii?Q?dGCv7DVUG2FUqES2sWnx/8X6119vs8bzPjQywIpaVrZhfdhQoDz2ksfzxQ+g?=
 =?us-ascii?Q?YuMT/E0vqoctivdjM77pHI5LjxHk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k8xsFHECw7K0ZwvjJ41Zl531uCsDGxLaKfcTmThXB/L9zFUKNTBQJiD7Y+Na?=
 =?us-ascii?Q?CgcRfULYh56URnoPdn854aMeXz19XSmpjQqEX7xfJ1FMTfP+NFfSMfBHeV2c?=
 =?us-ascii?Q?NWRuyhMEDZyFaPg6wPfKR+JDPoe2RXigzjx/Lu1JbnqABv19k0isHdrr+kmC?=
 =?us-ascii?Q?6FtDcsTyX0LLAp5hCPIi29lOtxb5Sgqcxn/5A70Zy9UN2verNYHODPDqsiwp?=
 =?us-ascii?Q?nVA9CUO06XSJBqwutY4y7cJ3Vs2UTg35qDcOQH+va1r55XBtMtbQgpU+Vbvo?=
 =?us-ascii?Q?O4VQlVURnCdSGCakKmD2b4l4NC14h+ys1biBmbAFrxQZzyicPgT7GSnYudRJ?=
 =?us-ascii?Q?4rUhyra+4cas/468RvozveUyMUt+47vos+qaIgQ6c1UQ5GYNriMQnQvMG7kg?=
 =?us-ascii?Q?NuotebdgLeQXQ3lwyVtoLAkJHtLwM+QTPpOYeTDbJ9Ejb9xliBzQp9Y7bAnj?=
 =?us-ascii?Q?1yzpe1t8rLjkeTy6T/ZEYonTtv3Z0HBvD3mzlz3YiuFkXH/QOF4JBo0TMHL8?=
 =?us-ascii?Q?0cS65b3jcqIFlzsGt9TUpUGVxP1TVznkdy7wuE5Vc66g7bzhZXbr2Uq0o1ch?=
 =?us-ascii?Q?EK9TL4T6mnRPjhl4pSr+gBKr6jOAHA0pOru+6NHLO3oKOKEurLu0ChrTVKme?=
 =?us-ascii?Q?eVIaT8aDBqDQvibbeE6j6zp7d1OA+QufUST5obfQGfMSVjEsFYxTvG82WPMu?=
 =?us-ascii?Q?RM83zlCbp/gg+4xgqDs/iwEml6Poij5gDtQOQIqLuOdnrQIE/iy7VwsGmydh?=
 =?us-ascii?Q?Oip6myjgH1Mm3FKRDyObWCtgw5YG5WkwLFD3FFskUUvUcDsXMQBgSK8DwcX1?=
 =?us-ascii?Q?PvGKjfCothPurXZ63GfU6rRsognsGNmYfb2GX+4gzfYHNc2t6jP7/3GFMa+o?=
 =?us-ascii?Q?xa7/Ivxx+XWcBV/Xq43D9VBh/Htzh+gsuDP6pmg53KFug4wGew1lANVpi7AE?=
 =?us-ascii?Q?psOuVdNynpvN9tEynNIX3PSDW+heNfzplWcoZiz0mYGZmjHyBJknpnSUlvQK?=
 =?us-ascii?Q?92iQkk1wzIeHYdlvCXE51HouqyNardOwPMWNJPvPJOIuEKr7VFQ9hA3B/WUo?=
 =?us-ascii?Q?5NAtpHb8ka+BVXzc/F5l+vPnBAZyGGxY8CYNBN6tsy3NykjmFj7teZTbNmQq?=
 =?us-ascii?Q?0w7ecgYOAnJNufKPNjFtOAL0d2tK/e6pQMPmbhVmtfv+bxrccJTAC32eWo6J?=
 =?us-ascii?Q?I0/u0t538rFAKxvoqRcPWbd3gTczFlKiIHxC9QxCgZHPsUh5Bsd3rf8YwiKc?=
 =?us-ascii?Q?CuiD1IsLRXRxlIUUz1eizaMEsbjSgY7EVfGzIrJJSCdgFXPXuDlQS3I5XhPY?=
 =?us-ascii?Q?yaIZJaUEP/9qakbi2ug5+rw2Foutjm/l8reTjRMkMzH/4omaBa87cGpRAl0Z?=
 =?us-ascii?Q?vkppDmt3hFIRftYPZHAKnqRWzDFaW/IbNPLQydck/9yxGT+fjWq4vBi8hF8k?=
 =?us-ascii?Q?CqowUsiy2LPt4db54g1pmu+eQoeMHir0sxivLwm2Nc0IvU2qQ6BcIzCx9LnT?=
 =?us-ascii?Q?jyynBuMckwDwXNqdukBAozxnHL9a9WQQOVmqrSJ5J2vR49td7YR5VqZWoZN+?=
 =?us-ascii?Q?EUtm82RHVAA+VTisZcblAgd/Da5kCs7nf3v/oOPhSsl4HyLa1uhnvBFnxMrM?=
 =?us-ascii?Q?ig=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 78cca773-ca7b-4adf-26e5-08dd503b122d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 16:41:19.6453 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q1fBVAg1d77wfA4WQWEZURLl/nq6BFeDW56RXwIg43JnfsjCNFOkbohmUCmG8dTzKcNBnMZtSaERo0Kn+uEpp+69xUUlRAdm+xa7qyMdWc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7136
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

On Tue, Feb 18, 2025 at 08:32:04AM -0800, Andre Muezerie wrote:
> Compiling with MSVC results in warnings like below:
> 
> app/test-pmd/cmdline.c(9023): warning C5101: use of preprocessor
>     directive in function-like macro argument list is undefined behavior
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> ---
>  app/test-pmd/cmdline.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
> index 2afcf916c0..4f0b0340c8 100644
> --- a/app/test-pmd/cmdline.c
> +++ b/app/test-pmd/cmdline.c
> @@ -9011,6 +9011,18 @@ static void cmd_dump_parsed(void *parsed_result,
>  }
>  
>  static cmdline_parse_token_string_t cmd_dump_dump =
> +#ifdef RTE_EXEC_ENV_WINDOWS
> +	TOKEN_STRING_INITIALIZER(struct cmd_dump_result, dump,
> +		"dump_physmem#"
> +		"dump_memzone#"
> +		"dump_socket_mem#"
> +		"dump_struct_sizes#"
> +		"dump_ring#"
> +		"dump_mempool#"
> +		"dump_devargs#"
> +		"dump_lcores#"
> +		"dump_log_types");
> +#else
>  	TOKEN_STRING_INITIALIZER(struct cmd_dump_result, dump,
>  		"dump_physmem#"
>  		"dump_memzone#"
> @@ -9020,10 +9032,9 @@ static cmdline_parse_token_string_t cmd_dump_dump =
>  		"dump_mempool#"
>  		"dump_devargs#"
>  		"dump_lcores#"
> -#ifndef RTE_EXEC_ENV_WINDOWS
>  		"dump_trace#"
> -#endif
>  		"dump_log_types");
> +#endif
>  

Rather than defining two separate lists, is a better fix not to provide a
dummy implementation of dump_trace for windows, that returns e.g. TEST_SKIPPED.

/Bruce
