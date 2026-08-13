Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3013C5CFEB
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 14:56:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CCFDC427E4;
	Thu, 13 Aug 2026 16:56:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id C5430402D3
 for <dev@dpdk.org>; Thu, 13 Aug 2026 16:56:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786632973; x=1818168973;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=b4BAUgCmYkhuGa92MWssbKsz38SyTQHb89cwR0LSf3w=;
 b=W8rBUB/8zSyZA5lphZ/w/zoTAZAywt314kcSUUnVooiZffY7vQZ3a+0g
 eIEjMuWBFFZfpPwzGucjB+tyouOnJWVlIl1OzS7SXcSr0J7ixX4hjM0mR
 HGyNgtNa1dGFY0B/P4P21bNlBAFTECeT/qqnnaGpelFvISvtjZr7j1GpH
 iuF7EkouRtd/3N8v3DBNGBVlZbGl2BWM27MYnICT5NE/mwhLFaGnho08f
 NesEjwsqRJgGgC/PG4P03HylFSAPQn5rMMqSkILtPeVgzut4HaEbftxvp
 WxK2RxA4D65/YfgJvxgj1oWdVoSoFurJBTWABsQv6o+Eh03qflnM/Ldhw g==;
X-CSE-ConnectionGUID: WOHTH1RtQeOm/pBDcIsP0Q==
X-CSE-MsgGUID: XFsb4vZlQMqQTapjWaORpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="87227689"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="87227689"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 07:56:02 -0700
X-CSE-ConnectionGUID: k8kmGPdiSriMDckV2lDIhA==
X-CSE-MsgGUID: B19he2u0R9y9QxsC/QUXtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="263985539"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 07:55:59 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 07:55:56 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 13 Aug 2026 07:55:56 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.29) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 07:55:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G1q7gKdIK2OhqOcls/upXgI+CQMnbTG2/n7v3Ap2tyqeaAfyh4CGHnmrdmv4IDvugDJUzRbX8bALMKVd3/FzmSHAeAD4RZ0Wo9sAUrcLL0s8aD9pNmXAQwg5GGXSRSZDE+35riJMsv9BkI59fe9AoCMhqDoY34lCUEldQsDx9kdS+RhhsVlHyDcdzv8Tq+owJniELTqQLTIvB5XTTTFBYxzWvQzp4fpzF2FC4+jM09HqxKZJPx4u8e5ScGvbWP4voX81FGZPLQ3hVakubDROH+/8lb1567sGTtu7vuErtq/5SLa/WcHUGGpAtHgawEjew7ORGUuqX1hNzn8tHP058g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nUzfENBDIZwvYhWjUOX0rMu8RSRIC1CBE08Gm4UOHo=;
 b=FqdadeZeb6RhMysj98FLGSWJlcTtq1t2GgzsRD/XMBjQUB19A62bGK7UaccFXGK6XLVrmAzdKcN18A6jYj8BNq726F8OvLncYx32EjN7b81U47pe/2oEADQx2+4iUbkx3o/P80CmX0Jl9u+W2nZHW0E4859o+b11xC11wW4gtM6cQQUazwSOZm9LNXWjvIH2ZbQnph8ePWEIRFZI34/zBIS88LZrRldr5Kzf64daXB1BuvT59B0GsxptVYHSOy9VVyJSQhGy0niZWkp82H7xfq438rT6qp6vD4GgZzaj2Ho8KL5wJdTSSBC4+OioGUNslZIZ+HHXhKypOZT5H4ZZOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by DS0PR11MB7902.namprd11.prod.outlook.com (2603:10b6:8:f6::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.15; Thu, 13 Aug 2026 14:55:53 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 14:55:53 +0000
Date: Thu, 13 Aug 2026 15:55:49 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <sandeep.penigalapati@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] net/iavf: enable 200G link speed
Message-ID: <an3a9dz3n0khRfkS@bricha3-mobl1.ger.corp.intel.com>
References: <20260805181112.164909-1-sandeep.penigalapati@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260805181112.164909-1-sandeep.penigalapati@intel.com>
X-ClientProxiedBy: DUZPR01CA0172.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::29) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|DS0PR11MB7902:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a65daee-aae9-4de3-e5d5-08def94af915
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|10067099003|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: IXeB8Gm//CSFJlAnNkDqba5pniaSatVQyx+4uA2DMOy86MsAIfnEIwH9wv6sl6UQRBYKQ+GjVLWGjrS+eomSpFITPQ8M9W6qxwtoYdIck5QS2St2iBBQ1xdnPQY8VH3MwTIRevtFotJoszgWegEbopIpdiGGvBckcdUYSKxVFI0A/NxrLtcGTiCbMyBKIgT1ip+KDWYXiL2VOo8E9uJUjeui9y1Wm1iogF9b1PvFm/qpaaj4aHj5EgmcKD8nlPwbKd4XvkwuMZbrk+qeOAXeNzpT5IQzyntIOC5IjHzH0px1+u/ufV3UWnckPC89x2LHhTMWHHQW5crscKXhO8uHT9qADHul/TOFD1QEoLdaKbry+ZqmAU270aVcKiem3ZSALyv7A/UXgJqo0Z0Upqnbbbm0oB/a+/q/ECwYlxQ3eUDLJoVrp6y13VBc0MGtZZsQF96RRNZi7ROmlXnDd3wI2Ri+ISR2OsUbeaosL+91Iyhh1+7rnPe3Rf+aJcW07W0/NNxX/ejRpl+zxpuTwlkIgRWtFxfvKk010vWq1Pk4AYetyI/wZWNgWPPXMSWVgzF1Xg9o65oXe/Z5f11DF7BwcmoiCTS7G82ES1m8leLMMgbxbqy1BzrHdzf4DVcmCjj7WHn5O743+dg5MM5TQp+mTeBFKuvGT3KbgIkEQ5UQ05I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ioSwr2aMyJwMd0nNljzE1OOqqAh5V803M5YPf3sPp5PsVX3n2xvSMUSNq9bB?=
 =?us-ascii?Q?Y3xOOFJg7uGwl86B6FfXfq+CqHTUPP+gsdKfyeMcWzni68kb2izni7r7NUFx?=
 =?us-ascii?Q?j/ajGffVNwuZsKmV9A7jylGvnYQlz0s2uT0yadgecDix8kplLxKcbTe+lj28?=
 =?us-ascii?Q?oVnNkTfvPfBPH8n6+O9Itd5SX7UxzIqb7IJy+babrDEQpiqymHmqKIimJKbn?=
 =?us-ascii?Q?MKghSSRntntZDkeUhf0KQUegSCqPgVd9dzS6yD5Iv5/fJOUGIChCVyBv39x8?=
 =?us-ascii?Q?ricc6Mn+tw8YUUDByTfQ2bDDJyvt4PrSUkaTFRGvbQl4RmB97DAWaz1Ih3yw?=
 =?us-ascii?Q?X03uoY1vdWRQ7APViOsMwa+eD98MqYwduscqvUhIK9KbRvFdxQDt6W/nUcVK?=
 =?us-ascii?Q?L3Pp1OaBCzAQ3aEj4MwX2JqHpDpl1QaezcEPtaRXR7qNQ7fPzTPuPmdirASM?=
 =?us-ascii?Q?ym7nnEyLADK/8K8qwwnU+JaWpZhCoU6xa997TwgYX0Fl13BnAqR0BCfpEYD8?=
 =?us-ascii?Q?evaXbp3eyVFkJes/U6jylm0FjSjWz0L3zL1do8QbQ9i0gjEMRuxMCl8UMC0R?=
 =?us-ascii?Q?T0XKo1OYIpexAJ9lkwJpPm66mUMa4gEv+/jXSgCLBoMix1KBQQaviN46+OhD?=
 =?us-ascii?Q?FsY3nOKMDhEcthThYTDzaR34QldfdevZIvqCiRBkva0UQ1DTISIls6WFjqIa?=
 =?us-ascii?Q?2F1f+G1KX8iYbq2e4bNQHzKdIhKw5o8ItG9L/sqaVjWYJw9P9ysRMUxvq3sG?=
 =?us-ascii?Q?QeZNo1F7F62EMMsRaybtaf0HaSr8HhLsnYJBKj8dxGlaZdkwRWFcOAKf2EmD?=
 =?us-ascii?Q?1c9h+FiyC+c+Cqq8n6W109kR4oxpddqju3smo81PoQUsRwdlyJQeyJNyqY5P?=
 =?us-ascii?Q?dL5/TRNSN9CZLTJs5FsXj+kUy9I3YeotencXw/lLsKDJKdHcTX6u/PJQSxvs?=
 =?us-ascii?Q?Uto79ONp//KepOC/fEL4eSrYcU/G5Bw2vKoOKaJ3+QfSGFADgJohRYJohX0v?=
 =?us-ascii?Q?B050cHjsgSH5Pbg1qQ7l8qtSkqZLIMtVksOg/O/hEh+vZHarsh/cAaJljOnI?=
 =?us-ascii?Q?25TDU0bUSmSxxN36VFyT5aPBgrEHecYHr+o09P73bYrpALKmAMXpKY1+xzOk?=
 =?us-ascii?Q?mEY9XFQwb8qkxzBiUxhrlLFUrECnNqJwsLBTJDUVjkNRVk8x4/Q4Ivgnakk+?=
 =?us-ascii?Q?L5/iebxdt+Zf6xJOoAEb57ZXWOj57+SVOr/dlq/wWeSvRJqGeZPhfA1yAjUo?=
 =?us-ascii?Q?eDfBXPo517DIgnhQrvMXw4JD34ASXtgg8EnnexjZUp9HDuvLUA8UD5rY8lL9?=
 =?us-ascii?Q?Uf7Q2Nh/JryMQOx5VLo3S/y6ZVPrw234TLqtuPQAJRQ5yuLI78auCPuSGDDA?=
 =?us-ascii?Q?VHj9n38Eq2bTL4dCSbxPbgGrrmFuDK3T7I1B5lDoQInIzcfKHwcOh2D5TFKz?=
 =?us-ascii?Q?rfU2tUGByk/Zc8B+2Ld49anlJaNhAiTXoYVgr0t3Esd0ePMcveWjUHdq/YIR?=
 =?us-ascii?Q?IerBMGeSQypVS8P6+MxfX4WOjl4w04yMEWY86J/rtyPblas7J01pPdEK0XKg?=
 =?us-ascii?Q?ofO3hRRRjNO7QpCQD/NLZfs+kJdxwOUcR0050GYkSUyem8LmNyM+GO6lF+o4?=
 =?us-ascii?Q?JEsyRogC13gBRPyKiyrivYPtjB4XzqXEQllU/usfp0tmQzMyFmNmkVy39dD+?=
 =?us-ascii?Q?ecK+i6YIo2gawU8nwCXupFWtZqxS+xW0NSrIPv9im7tjByqpxEAfAToFu+H8?=
 =?us-ascii?Q?TK9HiYT9+4AXkK1k0fTl8sy2uFDrm5s=3D?=
X-Exchange-RoutingPolicyChecked: grOxd69RDW7asL15CpYCOZv/h8IGLj4dVKCHXvOY30ero4+SPHgQRI0S2+NQbAnyYev3YtExeXfCX83+Mn5HCR9SUDli21jyl7zNFJ+pfLDVzeAAgyrWs7NIyURC0HslJ17fU8Yri4Zfpc7npWgCWCqvDrJMW/a6yBadv/NAUHbLXM+chSP8O7XXll/hur5zW5Sk9ndhPGvWvLJHbrTuvRWgrdorHjx32QldJ3NAO9mG11aWsDyG0YHWa0cfC9T5oJTLti8Pp9ZR7QXFV5YAK2dCfFFhfXX2f7vTXevU4qCg5kXelULuJwgNGCLmUATz12sX1M2GURAtSU4TBLMVsw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a65daee-aae9-4de3-e5d5-08def94af915
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 14:55:53.7714 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hcc1OqvwShwtS2uU9/TLHnVk+24lIFx6qEU3Qg6tT0DdCizjnzP3LvK/v+i4pE0TPgJQ1UUSs8QkTcUDVn8inFBgUkK+TBK86o7HpBihEPM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7902
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

On Wed, Aug 05, 2026 at 02:11:12PM -0400, sandeep.penigalapati@intel.com wrote:
> From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
> 
> Enable 200G link speed reporting for E830 VFs.
> 
> Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_ethdev.c | 3 +++
>  1 file changed, 3 insertions(+)
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel

Thanks,
/Bruce
