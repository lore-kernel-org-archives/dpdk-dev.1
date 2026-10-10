Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B44CA9EC0
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 18:44:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 108AF4027A;
	Sat, 10 Oct 2026 20:44:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 87B49400D7
 for <dev@dpdk.org>; Sat, 10 Oct 2026 20:44:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791657874; x=1823193874;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=QAR8628tOrgpPYOPmpMPPlZliO3n62G1csy2CUpbDUA=;
 b=Blm84mOvwGJ6lzsJdjGz6kbmW4nAatjtrOmkqLJJ5Iid1vDwZzsTu2IC
 DmFWwysAQfrVwXRUVyYHDZ20H0W0q2HmMijSglvxIFFkWkrvX+gnGp/vL
 kRTU5lIOjyTEs4Eu6ZcXhPY+qr3/tB04pJTRSjCLQnRj7jjrksNx9ifPv
 MO2ykpTaiXiDjFWgaFevoIKkHsGSz9EH0nz+VIn248TVVsYExT1qIsypg
 7ye8Jc+NaVm5cwHNlPfzg9VsvVBroTvofHi8ikbGNnKVqO78fGYqE7e70
 AHyLK47DDGX0fIVeDiRC7IjA5A/WRHovKTwgJSiY4N8A60fC2+tOu/EnQ w==;
X-CSE-ConnectionGUID: Fs1M3gH+RAGFVi4IGDuzGw==
X-CSE-MsgGUID: eHnfD+MhShO9HrnCU5RuMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11931"; a="521690"
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="521690"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2026 11:44:33 -0700
X-CSE-ConnectionGUID: RfgdCKyhSXOvlKczCv80Mg==
X-CSE-MsgGUID: dqkh8tfWT7aywsrtlxZpFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="2359291"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2026 11:44:34 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 11:44:33 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sat, 10 Oct 2026 11:44:33 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.48) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 11:44:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XMxK2YbWcLvEOZegc5fAUKOgEVr2xRjBsOPNgys6tUvhJlbp3TYhX9A1tFCM+0+vaK5llSuwiji8ijgEE7oG+gugBCERpYzkEsJ9CuOh3AvZbItBaRdp4YeOBfbhUcgZEPe9C/bH2BzC/Jd5dbGiSUthsFuj3Hcj5hVXX4wd9DIOhrUWXxS2vrkDVF4WLaYZMISNW9jUokybLgjSHA84rv5Mf30OyTpF1BdMTNZQz6sU6UO5yT4pETSStzxaQZc7cI7jTGIAPCdy87kh2CvOTcrlTPPjNXp5ZKH/G3bDSjvkUSlkTA9Em172tifldOB5M8dPChVrRnHaI2SeSzYKAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUlwRqd+/TMvsGi5SNiozhqn8H4uMXZ+3ruwfhlDSsg=;
 b=GUcX9RFoS8Cr45YbkL49tgFuCiWge6tNgKy6pGQ99Z5RwuDoBVcr7XcgHyRdNRenwIjQNXFd/9rjH2K/u2s1fFHjQTYCD5xGSc3sCkuvTr57NcDk/JhFltmeDC6rGkMJruw3cUIhXj5pwo3tLWjFna9Cn/Eke8a4fSm1YSgxnxNQYI9NMx3aWcrKP3LYCScwxDOmiiSSMfYzJD18aOhSnN107cUOBdsMcF3a79h8KKxeqNDFLydEli25A2X/EsCiPXKwabSI2jQ+Mq8rK5nGh3nJY6fcaZjf3Janfzu6wT0PVL/izvWIEMO0+cqRwAt+fF3gUVfsirE4NKTQrJq76A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by SA0PR11MB4527.namprd11.prod.outlook.com (2603:10b6:806:72::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sat, 10 Oct
 2026 18:44:30 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0496.015; Sat, 10 Oct 2026
 18:44:29 +0000
Message-ID: <4083c620-f251-47e0-a9e5-ca260461323c@intel.com>
Date: Sat, 10 Oct 2026 19:44:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 20/25] net/i40e: reimplement ethertype parser
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, "Bruce
 Richardson" <bruce.richardson@intel.com>
References: <5f7721d0e6f15f1822445a54da802f8442f188ba.1791543155.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <5f7721d0e6f15f1822445a54da802f8442f188ba.1791543155.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P195CA0021.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::31) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|SA0PR11MB4527:EE_
X-MS-Office365-Filtering-Correlation-Id: d4e927b0-c350-47bb-8654-08df26fe846a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|18002099003|22082099003|3023799007|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: NEGumFrnAVYUa/CAQELpUO+NmM0v9rNpWG489JIRZHMgTPF194iAP6tWYwl2TPsF0qnQ4QcvFTMia2vHF7UsqxPmjyLhD29faC2OQ3k0LzCyM5okXDOgoLnuOUjmoBaW/01kiJtcUTwqhLOYwFzQeJKWA8IK6Znu1elrBbt4AJ/OhnrxG5Ki14F0ujfEm2HjRbDZAiytEUCoBg6RcPlk96tUdOsVOm9SOG5Qf+2kvNDfHcT8NMOsGEcT5jAxJvRpGEi63biLG1HkE/SBN302WPwkW1Tgk/5vkGHS78KouSx2n3fSH1cXf+OUxgCrCkRnActQXReTd/pRFa2GJmhQlJ9Fht8apF4/W1S+PKAROh7N+17lG19nHrKJolkwVjboCcfOnvF8i/gq7t8pIv9dj/DkgZzIXmW3e5AedFOK40A7xEJ0tJrwDS6zdOTOc9pFrmq7REwMRRD3N0UKR647bwAWcT6ArNJxT/l/iAUmvji+hS2wGOGdcPmS8w21ye1DFBiJFrDWVwXHtKet+Lfe5PDOstFbGEMBIDUylfK4kXh7JST00o9AbGMUtl4y+vZjOMDmTptvrcDsi4LEw0kPHzta5OYG9jvt38YfINRVovOvjCqrXWJbOudCS3m9t0kDV6QYVyAUNJyWMIphNfO1K9RTfRPqoqjiYqDOyjT7Yl0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(18002099003)(22082099003)(3023799007)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1daMjdqWi9MNFllZFFWdzZIcnBjUlVwWWxZZC9Ka3VwUS9iMzJmenorOHJS?=
 =?utf-8?B?UVJWaGxkMEN1ODVJK1Q4YzZBajBqMnBYZFljRk5NNWNRWHBkYXpXbnh2WDA3?=
 =?utf-8?B?WFJrMndJRW01dFQ4U1JscEtVcnZYQlR0R2dXenBwQzhCUmk0SW53NmJ0OFI4?=
 =?utf-8?B?TG1aTTFnL0haQnFIOWpjMG91bVBsR01HUmduMmxBcnZaaHd4TmNqL3h1RFpx?=
 =?utf-8?B?elZBSWtQbk81cnRQSG96dHAvOVh3RDc0SDhTWWZlaWJrSG1iS0JvcjlMNW5H?=
 =?utf-8?B?cy80SjlDOEQxYVlHU0tWVXdVNVdPZUhNZ1F6RXh6Q0NvZEtnaStlR2JSakdD?=
 =?utf-8?B?aVJrbDVVSTk5UUVkNzBNWGNnOEl6RHhONVAwOFUxRzlJaFZJZmhJWkdldVlY?=
 =?utf-8?B?ZDRCU21BWHJQSXBLRVRvQjNPd1IrL25tQUxBTjFEeGpveThEclJIeWdxNE5x?=
 =?utf-8?B?cnpZSzFYQWhyT2ZiVHdXZVFndlBEWUVvRmk1WE5vVWQwS2lueVhpZENWcTdE?=
 =?utf-8?B?RmlnSFhmL1pWTkg0d1RPUWp6Yks0ZGIyZ21RaFEzYjVDUnliQTQ2NStmM1Y1?=
 =?utf-8?B?a3NqN2xBWkVBTG9TcWw4OE9XRHh2REVsZzQ3TUVRSmszRFo4aFhLb2o5UGF2?=
 =?utf-8?B?QmszQ2IwWDV2dDNBTzRtNW02SThjcCt4Wk1TUUFsS3lPVGpDYnpaS1ZFRlBU?=
 =?utf-8?B?cjR3RkJqbVB6RzN3em5sNlpBWUw1UHVDT2toNUdqM0dBdjk2MmMxbW9vMTIz?=
 =?utf-8?B?cndFWU4wTmwrVEFtaEp5L2k1UnRQKzRBNkJ5YStLaGZmamVTdE1rampsRnRZ?=
 =?utf-8?B?RURTUGd5cEZXdjUvYjFSVkZkR3ZUVXYzMVRvK0dHQWpNOGpqMFFDSEhxTU5Y?=
 =?utf-8?B?blo4elU0eS9kZmRXczMwZ1BXUVRJVG9pVEZLaTZPWjBvL29mQ2hBNWJtQlVT?=
 =?utf-8?B?UlhjcFBmUmtKbW05SU9iV3FFYjlyWmlKazlrNytyTVoyY24wdUdLczJ2WjJs?=
 =?utf-8?B?NHI1YndXMHNBaUE1eW55eUpoOE9qajNXTkQ0SGlNVU1kd0kxdVV2cDBmVGQz?=
 =?utf-8?B?RFJ3TUhEZzR0UmJ5R0o2MVk5amc5L3ZwTzFOaFJvemErR2h4cTl6QUs0cTdI?=
 =?utf-8?B?cUR5V0lsYWlZcVE4WkxaZG0yWUJGSHB2TjMveVUrcUZQNC9UcnVLQzRpM1ZD?=
 =?utf-8?B?SGtkQmtpekNQOUZHdFU2bTdNcktyMGFsS05BY3JVYWFWN1o4YXFJK0Q4NUF0?=
 =?utf-8?B?Y1VXbmZiZEhOMWlvWEREWitSWWlpMllHMmNuSG9qY3hjSFczZGtTZHVEOFEy?=
 =?utf-8?B?UElvZitZeTh3V1luSGRLQ01FTU0vUWppOE5qbitYY1RndGZtY014MVhObUIw?=
 =?utf-8?B?YjBOSUloN3ZCSnNZWTdlSzdLSFBOcDhENkNTekNycXJMMjN5Y1VhQVp0WmFi?=
 =?utf-8?B?aVoyT25nUmZGY2pvei9MV284Z2NEWll4cUZFbUlEOS9mWFpvZjhNM3RBdU1n?=
 =?utf-8?B?T3JlRUt1OXFLYUdLV3ZNMnJOK3Q0ZllSeU5KME15anFRUmtiZlUxaWtXYlNG?=
 =?utf-8?B?UFoyVWthWC9BeTgxNklYUnVSSVFOcmF6Y3NOWC9RenNSajJFWC9MLzRsTStS?=
 =?utf-8?B?b2l2RGtIaWU5ZG5kcHhFbkExTnZWWE43VTJJZDRCck95UEF6RHhCYy8vZ21Q?=
 =?utf-8?B?NDF3SXRkSXJSS1VYV0ptdnFjbURiQ2hNNXVITlU3dGJoeU5lSVlUa2FMaUx0?=
 =?utf-8?B?djJITUlIMlJNUTdIUWtmbU9leUNacUluM3BXcTZtTEVCT283SDBJcjBHUTF6?=
 =?utf-8?B?Zm4wTmtNbDUzSHFCSGQ3UExJOFNmSEtiSXB3WnBTZFZkVEU2d1JJOTZMeCtr?=
 =?utf-8?B?UzFueDdPSnNUVWJhL0QzZXZrTUlxbnowZU10bEYrYUR5dFE1MlJZTkE4LzdH?=
 =?utf-8?B?dUowOVpYMVhNcC9VQlIydXM5bUZyNGhKN3pRL1hjM0VyZ3BWclhPNlhvRHVo?=
 =?utf-8?B?Yk9WRVk1QWtWekFQbmQzbmM5bHR4SWREN0RtNE9jcnk5WlBQaUtXNWtoNWdj?=
 =?utf-8?B?ZWpLZGdpSWZZeGlkZkdaL2g5YmhJWFBBdkxhVkN5N2RTSUdZRU1sSU1QRGpF?=
 =?utf-8?B?bVBYSWVUczJhWEZoQ2JiSnhOMHljVzFSSUY0NDhJaW4zWUxyOTlxeTFLV1p3?=
 =?utf-8?B?VVIvZEVaaVRkV05pYy9wOWIxc1VBMDREaXFNUGlTMXZOc3ZtN0p3OGUzaklY?=
 =?utf-8?B?QjNTcnN6NGc4WFVwN04yWVJHV0dGUHJudVV2Wi9vcThzOGJob1RERnZBMVhx?=
 =?utf-8?B?R0RzWXR2cVJHZitPemFFTlRLT2hwT0hIeWd2bEZtVXM1a29Ld0FPWW5sRnNX?=
 =?utf-8?Q?8zIQ2kDEQvpj7OYE=3D?=
X-Exchange-RoutingPolicyChecked: EDweGEGN368QLyZi0U/5kCUMyfwM2zFZlemHKGpXlD4nSOlykAfthYJhzWzToHX1FKaRQr7i0kmV+zJry+X7g0zxVZeaegtLWNwwEPzHtj6OzdKcgS1BrdeTIsIh5ET0odkMN88uuyzVLJXsY/Hsj60VCfCz4NBNfyeKarNG9/oHwRdm6recsF6UfnjlbrBE4C7gmjh0JYmURhuekZJ+YKwHWlnTFjpKf84+3EYOqD9B4r6WtLKGReADJihRY7YMoFeKekTc6J6cgz0vsLJXnIPaBgVIH0F475gN3egnnSNdj2r/mzNK6qI/oe87PUSBiSenxcvZRNs72aIt4qNCcQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e927b0-c350-47bb-8654-08df26fe846a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 18:44:29.5782 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AAbXEMW209wD+fXcmqBgDWZ50iS8CAH5Mj8jtEVnEmRhbT1VpM2LZsZY0PaYKxnPPD1ilj9+bfQwB74SrJjYNlFwuaWz4dN+muL6rRnC0PM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4527
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

Hi Anatoly,

one comment inline

On 10/9/2026 11:59 AM, Anatoly Burakov wrote:
> Use the new flow graph API and the common parsing framework to implement
> flow parser for Ethertype.
>
> The ethertype filter tracking has been moved completely inside the new
> engine, and the ethertype code is refactored to enabled that use case by
> decoupling hardware writes from software tracking.
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> ---
<snip>
> +static int
> +i40e_flow_ethertype_engine_init(const struct ci_flow_engine *engine __rte_unused,
> +		struct rte_eth_dev_data *dev_data, void *priv)
> +{
> +	char ethertype_hash_name[RTE_HASH_NAMESIZE];
> +	struct i40e_ethertype_priv *etype_priv = priv;
> +	struct rte_hash_parameters params = {
> +		.name = ethertype_hash_name,
> +		.entries = I40E_MAX_ETHERTYPE_FILTER_NUM,
> +		.key_len = sizeof(struct i40e_ethertype_key),
> +		.hash_func = rte_hash_crc,
> +		.hash_func_init_val = 0,
> +		.socket_id = rte_socket_id(),
> +	};
> +
> +	snprintf(ethertype_hash_name, RTE_HASH_NAMESIZE, "i40e_ethertype_hash_%s", dev_data->name);
it seems like concatenation of "i40e_ethertype_hash_" with PCI BDF is 
larger than RTE_HASH_NAMESIZE, consider either to increase namesize of 
shrink the first part with something like "i40e_etype_hash_"
> +
> +	etype_priv->hash_table = rte_hash_create(&params);
> +	if (etype_priv->hash_table == NULL) {
> +		PMD_INIT_LOG(ERR, "Failed to create ethertype hash table: %s",
> +				rte_strerror(rte_errno));
> +		return -rte_errno;
> +	}
> +
> +	return 0;
> +}
> +
> +static void
> +i40e_flow_ethertype_engine_uninit(const struct ci_flow_engine *engine __rte_unused,
> +		void *priv)
> +{
> +	struct i40e_ethertype_priv *etype_priv = priv;
> +
> +	rte_hash_free(etype_priv->hash_table);
> +}
> +
> +static const struct ci_flow_engine_ops i40e_flow_engine_ethertype_ops = {
> +	.engine_init = i40e_flow_ethertype_engine_init,
> +	.engine_uninit = i40e_flow_ethertype_engine_uninit,
> +	.ctx_init = i40e_flow_ethertype_ctx_init,
> +	.ctx_to_flow = i40e_flow_ethertype_ctx_to_flow,
> +	.flow_register = i40e_flow_ethertype_register,
> +	.flow_unregister = i40e_flow_ethertype_unregister,
> +	.flow_install = i40e_flow_ethertype_install,
> +	.flow_uninstall = i40e_flow_ethertype_uninstall,
> +};
> +
> +const struct ci_flow_engine i40e_flow_engine_ethertype = {
> +	.name = "i40e_ethertype",
> +	.ctx_size = sizeof(struct i40e_ethertype_ctx),
> +	.flow_size = sizeof(struct i40e_ethertype_flow),
> +	.priv_size = sizeof(struct i40e_ethertype_priv),
> +	.ops = &i40e_flow_engine_ethertype_ops,
> +	.graph = &i40e_ethertype_graph,
> +};
> diff --git a/drivers/net/intel/i40e/meson.build b/drivers/net/intel/i40e/meson.build
> index 3229233f501..ddc97f9b3bb 100644
> --- a/drivers/net/intel/i40e/meson.build
> +++ b/drivers/net/intel/i40e/meson.build
> @@ -33,6 +33,7 @@ sources += files(
>           'i40e_pf.c',
>           'i40e_fdir.c',
>           'i40e_flow.c',
> +        'i40e_flow_ethertype.c',
>           'i40e_tm.c',
>           'i40e_hash.c',
>           'i40e_vf_representor.c',

-- 
Regards,
Vladimir

