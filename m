Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A7CC43458
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Jul 2026 11:09:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75558402C3;
	Mon,  6 Jul 2026 13:09:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 237CF4027B
 for <dev@dpdk.org>; Mon,  6 Jul 2026 13:09:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783336160; x=1814872160;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=JOrX85qUu2iJvNDO+mW8DaQjY82lu2su0CAUxgxkCi4=;
 b=BBVzwlpadgFgzL3bzgk3TolJm+4G0nG8NCV/sORZD4DcGvroojCPFS/h
 j8G+ExaN+aksKZp3ioqYoRby4tT7EcYpg6ulIraoGlqtjG2UFJ2bHRaR3
 xzD3KeO/M8JPhsXs3pFPz+P+i68HxDv0v8pZx+rGUrqsm8uRGoW/hDNg+
 5DvTnYK9sRzCqgOhx5WK368kjpqGR5tP/ecyYXRkdx/VrC6DOxqywa1mx
 oXFwbZbNGxRUVVMcFN1DvVHx3MGDo0bmm0pFxXudzRW+K/pVzy6UBZGeR
 sZPBmBPqOk03Hrq0eEIX6c5P/nOrfeHppktKVZLotl1PR5yugwqsoBmZm Q==;
X-CSE-ConnectionGUID: 8jRDV/YIR1W600vbtumi3A==
X-CSE-MsgGUID: vfWNxulhQeyHZ4zWwxJ5MQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="83740269"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; d="scan'208";a="83740269"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2026 04:09:19 -0700
X-CSE-ConnectionGUID: qcS0j1J+TbCOmBk7fc6YVw==
X-CSE-MsgGUID: /3Dk7ulGS4a3aefPxk01ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; d="scan'208";a="251942421"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2026 04:09:19 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 04:09:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 6 Jul 2026 04:09:19 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.71) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 04:09:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=osTupIZMuNLycRPfcw2fDxEfNgu0TvnaahsAfYtF1sRh6wLwxn3JwxBYqFLPaXT0dfVyVrKPa4vR+X15JSGXIA+fjJrud6iyOtInxzu/bm1IgkSs4I4UD+Jl00Usp5+3xj5W2ZHYREU+DyRHt7+/xrZziLd9K3v2Nk2KXu/z6sVIoQ7xOV8LqTQQsz7+fpVNpbgCCFUumjIWs/PQmgwrJzr3p9/Cdk094bfwyeBAq94DQzo1h/mWlSj8McCJ5RJFi0y1yvupuYZYR2ZeRfxiMUJlH8thgCfp78lhnkpJ/kOvwt6ESVJyn0k6I2eIwN3TdYLhBbSbIBsd6LbBRr2AUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0aV5+zJXvADjqxWOI/xDTvhLArH0s3WK0RDvRF9xT3M=;
 b=pQW65IdSPnJ9yJjemq4zR+8JZBYMku19HJbiVXwrjL40DRy7nWgMNsf00CalXpRFXlNuhgDJI02Y5MB/Zv52YVt8J424IJz9MjfB8LemdI5D6danyFkE+6AP8t1lAzwi843eRz+7oqDWiQ9rd9qwQHBsbrBo15WTUohV0aa3j203HpUi33BasfOD5TNQgFRbc2wGK316vI0scVey59Wt8ocZHCnUvn5nTxypTMqzJBxGHsoM/HLr8+WHn012/ULX5Oknf/nQP/T/nQ6i9g0ZhNUCcq7cZKJBrh0Nj5fgyG1a0OnAZZ2AEO/gKJFO/ZedH05lL3lQ8pr2SzH/VtPKMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by DM6PR11MB4547.namprd11.prod.outlook.com (2603:10b6:5:2a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 11:09:15 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0181.009; Mon, 6 Jul 2026
 11:09:15 +0000
Date: Mon, 6 Jul 2026 12:09:11 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH] doc: announce QinQ offloading operations in iavf PMD
Message-ID: <akuM15sJlImRdy6s@bricha3-mobl1.ger.corp.intel.com>
References: <20260704131730.457722-1-anurag.mandal@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260704131730.457722-1-anurag.mandal@intel.com>
X-ClientProxiedBy: DB9PR06CA0030.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::35) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|DM6PR11MB4547:EE_
X-MS-Office365-Filtering-Correlation-Id: ec1d1556-0f69-4b5e-0634-08dedb4f0436
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: RMVU+11ZsKw6f8y2N2ZAZn5htqJwmORw8wGt9K5qTrnOmBxD2vmBUUlJ9d3lwb1u+ACAQx63BzHn5U8ZRZXNg8BoEE2KUn6RxioPalZl5PCp2uVDv7Aqa6ayHDte8imX8GJ4S7/YIIy3mg0iJ9IZcfpNOCUPmlvmx6tWIun03LcLZf3vrEksOxc8s64gWjkxP8xt79N4TzSlJcelQ5BxBKVN4ZUUmWa1rIwC1BWhr1SoC+ZPy7YiG7oqssUtzZ+c00YWuxVl9Cg1ItDX7kz9UFECtbNO7ybzkYkuINYzxlkyuWjY8JrKUZJ9ApoShR1EfEgnrGnnOZP4axFS7dNTTttgfUlYx9gb7FThNN9NcQDQg9y7oLng7vcHj/0H0NUIuZWIrZw3vgDSaC0/onphOR376NTo9tJKRLvG0y+ese5yXsVIRCzWroViXgD7be0SJydkGqmMTSwR2VjCN4JVxu8uU8+E6zw6+WrYvOhhLxIiRoz5+slFaHAs2qyWCN1QHhQbP88HhoUfJ+zDFv3fG+J1rJ9wvv8LRr7PsWuYCU/IbJ9dUD/w5w6jJjFatlN/9HEarosbu1kecWbBCdc4UP/XfVNmD2GrPHHvO0RDg7DCvsicB+d7CslnQHLKmMr/sKGJRJiRWdIi4lh561wLB/Uvrm/nTKdYeWxVIk+4FiE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FCDTbijZDeS8lfBG/wSE77A/oeTDkKFu73tTxhW8SEd7ZKDToBIJ+SnsW1ge?=
 =?us-ascii?Q?cTXZf0F5xcg3hGFJCrfbCjCLtzzfpJ8AHod1CRHkELXl+ZZf44rMWyyWERKq?=
 =?us-ascii?Q?5iURsDIU7lbSsJZpRoq0Hs99oEJjVjES7NhrUZw6rArCz6GAFlJtPUU1kI9N?=
 =?us-ascii?Q?ZbYf56wLwrNBujtjap/RrCxwObotJyfz5qXnxPx8NDWC/52d6oIahXU3/fi2?=
 =?us-ascii?Q?+Gs+ZYcuGX+vgbfH6e5HDmVlOGtkQEehJX17l5+koFsdVKrl88xPeL4X2jkJ?=
 =?us-ascii?Q?rMUwFerdZCmLqpe0ZyjoPNU0ZTHct2XC1lQ2bAnrliy8n39XAK6IZ1xeFXiP?=
 =?us-ascii?Q?BMvfXmsAiymUAu2/YuNHkltU70PkIX1AKVJapQZd8VPj3jW/Bq4G5WMzE6AP?=
 =?us-ascii?Q?sUjjmUtvINkKc4d1f8u/DDbRFCmpW81iWv3DkZVwwtGVDleok0l7XA8iO3G1?=
 =?us-ascii?Q?xmZNsdq2M95e5M5CA4ALCgCwff9/4vYBo3CRzFIfT6tRkH8kMEp+G5F2VYDh?=
 =?us-ascii?Q?Hpdnkh/esjN9C3W4fM7I6fkekBHncUk8xaw8E9rHC/xRcBVNvYq+BhXnfJS6?=
 =?us-ascii?Q?rxBlwgUxyU70jxPgc3jkSEWSYdelhaH/Y/KxqKEhhDdDLIL7DvqOF3zdy/fz?=
 =?us-ascii?Q?6/4McmrDBCe8pTZ89d/MyJhQKyPAxbTKVYToMevq4bDVCUx+sEPzCrcVtEnz?=
 =?us-ascii?Q?aHMzQ3dCxgoeR8FFUeFxSUR6op0BODKU2zHgECVGPtmOh8zI3lXQXOEsdPnn?=
 =?us-ascii?Q?che+wPBFzPaXY2sMFPPfyO4dUxmYys7EsILETvp3MPbN2c0KUg64bKIKkEbb?=
 =?us-ascii?Q?t3i5DxMB+XVE6e0S6dMtkvyW8FXRJ+IESzEG/qhiX5GfEQ+xlxiVlirNnj3n?=
 =?us-ascii?Q?avfGm5Tpdvr1K7jOPzQ9qKTJCTaYz9B4l6poHrD9j0OBNadtRPUoeY1DHfzN?=
 =?us-ascii?Q?rwCBrJsrnOOfcUTZBtYEA/ASEtUT+fcHWCAXNjNFbqeA0CMuyUPj1K7koKzP?=
 =?us-ascii?Q?eQi3HJjTcXtCFxavVrwOxLN8Hu80dqDoLosvc7A43Bz97rTT3/AmtUBbCWr0?=
 =?us-ascii?Q?CPrsizaRDgTmZagAUXqejQPKxZUznU2lZ7vMbgjl3wxF7jMnb834JIqWT5Cx?=
 =?us-ascii?Q?edbDxlCFQkEL1hYDyJcecOCerhHltWw+/8vTY0Ava+VxvTL8+tAiSQw30cK7?=
 =?us-ascii?Q?rDn0yYRW0Zk4iw79ui1OlX82Kal2NUBpOOd9oGhhtJegrnLTUtapeBDOiOJv?=
 =?us-ascii?Q?15xTDNIyPy+GdOTo+s4qE+3dPZcNLDYaJs3a7TqakIP2PzvtPHbgLOH4Phbf?=
 =?us-ascii?Q?5CPyeRtTl9zVEMfDEr1RFtDpk9CzKUC0fbSW9uiUG/dKujlZF0P+4DFIVma3?=
 =?us-ascii?Q?RAcSLtUwP4fO+gOIPMpshO+326A6G3nC/q5O+7ky7IXR78tLO5wIozc21885?=
 =?us-ascii?Q?nRn/5O4hEVVHPFbfQpQdQ9QCnC4HWxArGox1Ya5gIgQpT0nIDk0elW3YSIeb?=
 =?us-ascii?Q?K1Q+2XjZed/NY4fuhCMHZHm9Y1vOjpY+HoZUHyjlyuLZdDk4hD1Mcz5BT11n?=
 =?us-ascii?Q?Ci6uhIEbSNDNtUMrArcBzZRSlhicTo9BbLFT+qgkWEV28BzgnuC7pW2C5ejt?=
 =?us-ascii?Q?PHLzRLXztwE6Ns5kxBViPXv42T7HUdGMCSM4JqwoiYBbCcdo1LmUDTpctA+t?=
 =?us-ascii?Q?4XqCtcLJ/AqbnuOBm5TQNjnX8I0Wtxp0HGccpOXjovR4PJ3qe1GlCrNt8+4m?=
 =?us-ascii?Q?5SRlyYjik36aCjlSgNvwmNwlX3X5K6o=3D?=
X-Exchange-RoutingPolicyChecked: fQGPfDJLjKv88Uhq8xGSHV5I/jlZZJZ4UCga2uIzkbawESh3WZPeNmHyp1VzBrDERdv0R4q/saKQfHtgaQUol0SjFm1OFeiROlh7LXYIsPqE+XDDPfDd1+rOhwSSBsS0SaNwLN3zq5qIfBaO5GgMKI/tQxErjqfyPSOP2Aq/GpQzwLI/8CvqaAxJZBpxwHdSqDOhAe3BX76qDTjf6Bz8mqtCa5WK1ljMcXd1NWJm+mpw04w3y+rkwj3Tzq+qtzE4hWNgNVE3OPZ+9BlfJkkV0xBSkcNs0+wM0YKyUWwwp4D3UP1rmQfAdMqZVgboRY1bwyOf/gn6YsYqA3H4m3jebA==
X-MS-Exchange-CrossTenant-Network-Message-Id: ec1d1556-0f69-4b5e-0634-08dedb4f0436
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 11:09:15.4785 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wTbwXuNgXG8jCtQOCMIq9I0I0p3cya0Lujq3v3GYJ3PdncK47NgDaibUOKsJtRIje79M6hSwdllJRYjUSekibhlkFie3B+hzg0s0aQw3Ou0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4547
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

On Sat, Jul 04, 2026 at 01:17:30PM +0000, Anurag Mandal wrote:
> The iavf PMD supports hardware offloading for all QinQ operations.
> QinQ tag stripping and insertion offloads have been added for both
> outer VLAN TPIDs: 0x88a8 (IEEE 802.1ad) & 0x8100 (IEEE 802.1Q).
> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
>  doc/guides/nics/features/iavf.ini      | 2 +-
>  doc/guides/rel_notes/release_26_07.rst | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/doc/guides/nics/features/iavf.ini b/doc/guides/nics/features/iavf.ini
> index 0ba6f7dfd7..e324a7aecb 100644
> --- a/doc/guides/nics/features/iavf.ini
> +++ b/doc/guides/nics/features/iavf.ini
> @@ -30,7 +30,7 @@ Traffic manager      = Y
>  Inline crypto        = P
>  CRC offload          = Y
>  VLAN offload         = P
> -QinQ offload         = P
> +QinQ offload         = Y

Not sure we can advertise full support. Checking with AI it seems we have
some gaps, for example, the legacy (non-flex) descriptor scalar Rx - used
with X710 NICs for example - doesn't support reading two tags for QinQ
strip.

>  L3 checksum offload  = Y
>  L4 checksum offload  = Y
>  Timestamp offload    = Y
> diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
> index cf79eb57bf..d864019244 100644
> --- a/doc/guides/rel_notes/release_26_07.rst
> +++ b/doc/guides/rel_notes/release_26_07.rst
> @@ -139,6 +139,7 @@ New Features
>  
>    * Added support for transmitting LLDP packets based on mbuf packet type.
>    * Implemented AVX2 context descriptor transmit paths.
> +  * Added support for QinQ offloading operations.

Can we tighten this statement up a bit - "Added support for Tx QinQ
offload", to make it clear that it's only the Tx side support has changed
in this release?

>  
>  * **Updated Intel ice driver.**
>  
> -- 
> 2.34.1
> 
