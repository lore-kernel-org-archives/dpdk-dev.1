Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69433C531C7
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 10:15:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45A964028A;
	Thu, 23 Jul 2026 12:15:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id EC5444027C
 for <dev@dpdk.org>; Thu, 23 Jul 2026 12:15:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784801744; x=1816337744;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=M1aeYzOEVKRo62Pk9WIjqecwTVG5k2spJNAq+gVrwkg=;
 b=S+pD7hxJM2lXSjOAcZQ9l+imScAxNX23rWDzu4pmsd+3fvM26YRkCxWL
 zUXYb6XMZjYgx9F5FSGAUW8uo42j1+pVwxblm9KsF7h2vz5LQb/+XHFLh
 GmMiCOikDl6SvTXAhCtJMvGNKLQPIKcjfKwpvy54DBdaE6GPIDytoZMKN
 yYkMm5J9LmL6p4iDVU/Bxg/lYq4LY7kTcK1gF++GYbXKUxJTY9mCfp3e1
 XZfcypRX/ZqUVR9/xIs0NFY1CNne/9jYtcOvomQHVYD4czV2WkWPZ3Glh
 8rWSW9QX1cDRU55Ze0y7m7I+CnqYBp29KaZYK3a1mNLZImWes+hjfm8b9 Q==;
X-CSE-ConnectionGUID: 46+oZx/2S62JpJzn4OWdFg==
X-CSE-MsgGUID: gIqWtOWQRDy8lCrtOHKxfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="84429997"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="84429997"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 03:15:40 -0700
X-CSE-ConnectionGUID: wRdqrkeCQE+Q6xIHetGP4Q==
X-CSE-MsgGUID: OmrfyxiETA61DhSFXQ5n1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="262151491"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 03:15:39 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 03:15:39 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 03:15:38 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.20) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 03:15:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F08pWSIN1yjOF+F1E5IOzcVuF0Q37gxGn7GzZvZe9uHfPCoJ5tmhhrjMFYlSILPNbr5/Z/PxtQqUxIgmT0PXAvjGLq3JU1zx1v5p5wYWhL+XD2LOkCdGT1EQ/CrQrYXqkfd8Y1+YBWyDaEE/syP0b9+J8CzGF3VS0sL9vHjFUZZElIV8JFv3ChD4x9sDi+1232qWbQ6jLSHjHE1VQ5NqRcfQW0rgKUgbFftlUi/YoYy77vCurA8TzcjDka7xDLvMX/5JmziTxglcVoot1nRs3sGLM73+HBdS5bKGYJRhEGnDWsMyYP4++0ewOkGmNhX2VonNKNRhoLriuCi1r7IAgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQTfwXK+GdhilVlGH54rOIjl8UDIir9JWcc/z1xJDCI=;
 b=oF8pC/sNF8XQ8Oc533mx+irQQe1kg+clLG9DirVGHeKLlKmECbPtSCrNqHjCY6mc4JDL+r6JThAKOSJYhoOs4nOCOM9FYFOwJsbGfAj/NDZmZPqbsTe/3ZyWv8r9fjJZP7dXzRW0m8CfofFxp5yhGYzE3/2D7ScjfXkDMANC2OhuY9KgouRLqGO9um9UmviGi+Hb1ft0qnBgPCTpFMW/97bmvDBCyXFhOBecytrZz8wADhOwSyFbqApX7RqXXq/0AuD77Wuve09zNGNSZsDdPlb1ScK2cxXZ8ZIn1fn7c/CmpwfY4k6foajKnNkQ0oKUUpOJLDwKEGd4/HlPLMpSyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by IA0PR11MB7956.namprd11.prod.outlook.com (2603:10b6:208:40b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 10:15:36 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 10:15:36 +0000
Date: Thu, 23 Jul 2026 11:15:32 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Dhananjay Shukla <dhananjay.shukla@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH] net/intel: add MMG device support
Message-ID: <amHpxNFifOJO-1dY@bricha3-mobl1.ger.corp.intel.com>
References: <20260701102948.3333550-1-dhananjay.shukla@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260701102948.3333550-1-dhananjay.shukla@intel.com>
X-ClientProxiedBy: DUZPR01CA0152.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::27) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|IA0PR11MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: 7638125b-6267-4074-ef57-08dee8a3563d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|6133799003|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: /kKfAVqRaMmMb5ZJ9Egd4cihwqL/+DEXSRwcDgYmKbRiJdlyheHcvYEe5NqnY1D2xLmZUIvVc8vLixzzAwiJtxTZWYhJgIqUY2Yg/3C1P5QCRHpYq14IdzlI7DxbXJBb55RJ9rvLWqnvJ3AhO/xgMwZTyvivTIhr8bK2QP/KcJrEk0lW7NezwhjzorkK7UROh+WXBAfey2lviSS9Aw6EHc98Vq+fjp7ygGFbiNA5oomPELsNjUCWyXWbRSgZnFUIJDrbQ6P2+daFu+Py2sUjoIMG+mH0Hy8dAkK7lcdmYqBl85Y74U+1NLuMSEyuacWzqfjIcOTeyN1XvzhcjikPXiwR7OplsJk64M8z9bvnT6IZZCp3qRQ9JqLQhb/6N8XQvCrn+BKze7+KOdPY3b4XishZJ4BqOwQrUCZKmeihORYnYdYjS4VwgmQ47rGhdj6JN/+m3suzLr1S/6zElVCh6uE03AAIAuVT78m6sxR+xJsPzS22+/E+a5/+Q/QHgiGk43WVqszEH6m4GH471ocdw0zLH87RYPzVibrpe4YkagrLXhyZo16x6CUZ9WuHCMU5Za4SryrryvwWe/adhQd6XeYOgIJTW4ZCtSo/zs9MLKtAi18Di/A3ZGDgulnijxX2/S+UqeDV0p5zfgv386ybem3n1Wfp0yAxtgUZBOWjihE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EcrQvi7auIEgdGt6t5c+amPgw5dJ0tDwk1nMgCtEOkYd7pXb5JZ/liIGWx2f?=
 =?us-ascii?Q?RGx/D8GSVMOGht51/w+QyHLspS9Qmilqt81m08G1Be1itTfW8/zADMc4khIt?=
 =?us-ascii?Q?PMYJPzKLqxh+TMXz8iYqnHczBShn9EIhrNb/VedlsNK5RkCS6axBKFPgjkLE?=
 =?us-ascii?Q?lykX6zkuwuQqrwrqsJkMWOeWvJjdsdnFNFw84LupiIqwxZY6l4Z4aaS1zkXm?=
 =?us-ascii?Q?XBP8dR7u3v9tJ+6A/ZU2u4E49uwz+7ZI6UHm80JWrKXHUgzITPSjGxjj7/TK?=
 =?us-ascii?Q?PT8U8VcgwNXcANdYCunI0qTqaZo18QP8gARak6ZQ7/TLO2FsTu310E5dICb6?=
 =?us-ascii?Q?EILelea/ZAIFbiqsxITESogIc4bMheOJP4mWpnMK9qJjlUp7bfPEL7Ho2uX9?=
 =?us-ascii?Q?Ml0O+AINfSbfjTXEvQvWdzm1OrG6pSOjyFvAexJE8gMA44er977PGX5fA1ok?=
 =?us-ascii?Q?V0O+E9edAaf+0T+QJPpjLd0muq1rsXKG07m9QnwRZRnQMA5nGBNFA30VEEtq?=
 =?us-ascii?Q?7rqVH7oxLF464oZjQrjtnGYf49WocPpNPXZESbKGghm3NhOos2gLHs6xJKPe?=
 =?us-ascii?Q?HX12j2AuVqMlVkgjJ5RjvcOG5+xoM/QXXO9O8koCAQ7YJIwjlw4itZAfde+J?=
 =?us-ascii?Q?vCJw80IMfdXD85nV/fqw5pNu/Mg4r6whTy1Ur0is/Z60f3bs5Tkt66oy1w8d?=
 =?us-ascii?Q?ln21G8xKNDu9jWlQQrReQgoJQoGsSdH6xYftizzIPcRQkRfe2kbM0SWug1i8?=
 =?us-ascii?Q?uuniYtLrb+6KPZWNgw91ANQqlU4AA0/DzVxKTh8ZtLcKBN/SuCvmNvlI8AF+?=
 =?us-ascii?Q?SRS8uJhp0qOl79YBQUargE7pRtZ8gXi64BdMgfLKlFXzUkIZ/MhalpHXTiP8?=
 =?us-ascii?Q?BK8zCSWOh39SQwLCPMqz2eB44PtwKxrHGJuN6VshWbvPpPXX4aL06e2A2Skm?=
 =?us-ascii?Q?F3XF7vvJEocrxf3d6+oPv0tUve2zK5VfFijx3rPZ2TWUNMmeBWI6ne0zYVtx?=
 =?us-ascii?Q?hzxYnQEaSOJIWKMe8OCLQE4+uI3lilxVldluwJjMVtlQguKoaEQs/1+vAOlr?=
 =?us-ascii?Q?SUmnm4+MA5utN+XsebyRuIN+Vuw+r+cejjrAovr5PSHqTsdrbT9GO18het1d?=
 =?us-ascii?Q?i1defoWh5qGPGxOsEhrKnQV7Mj5tm94ilavzXXX3H5nw6Y1QMKwjEm55RPpO?=
 =?us-ascii?Q?K8jPM+1sytNI5b/oIzbG3z6BWHbFS1oEdkX13yMarADdRLkFQ/eZPwZGyQ7I?=
 =?us-ascii?Q?VX6aQfkjkuonrumrtnOoUHC94OCtQ9hVVyVisy8fxtPszJCq2G9QQMHRhSaR?=
 =?us-ascii?Q?WTbnzrl47ucxlk8N83bVI9g3NPL5bVq7cqNq7ksgwZPuIzi4zPW620tPoGdC?=
 =?us-ascii?Q?vOYEj9qep3xqP39Ttjbv1XOmBF0Ifw6II0J5ZD2mro0tjEq9v1K+aVum936c?=
 =?us-ascii?Q?iU7+FGy4T0jndIIApFT4lg2MDZW/OGI5SYo1UIjzrgn2omxmqaVJTyjKKOjS?=
 =?us-ascii?Q?uQHBIp95bfkhfJ+dr/K44dmQ0wAkuWwSDehgmtEsgrHQN5Ygiu5AqBj8R1i5?=
 =?us-ascii?Q?7oSX+gYAn/Xj7v1G0b539bDr3o7Q+7ea2H5/7AYOiyoKxP0blH7MmLWtK6z7?=
 =?us-ascii?Q?6NQSLdu7WS37HsDO51UUbBq5HKCViSo94dkFwsgrvKJaX56FvbwNCyEsL6Pf?=
 =?us-ascii?Q?+cn8H9dV0+BcQJKWhxVqU/grpv1jwscsUVFjKgFhoqApbV0BSJWcPFo3dI9n?=
 =?us-ascii?Q?PsD/CmQq9L1EsLJ7GzIOqcYFiVZmUq8=3D?=
X-Exchange-RoutingPolicyChecked: q7ogIcR5yj2wL1Y7o1Dv2XJ8FmQyAffx5yjlIWZYWA+s1QxFGOsZ6Q7TKTuVopxR8CW2gBSREmMiXcpMzyL+xdEidPPYRL3VFV+ylLc+WSC0PYmuipjiYGisL1V5qhLTvwVbaPvipH96qO0IgRxHs63wBB3tfQ7ywwP448pObgKTC1CwyH7SwUxCvwf+aYq6pe5fZnf3wS1xTyO1kk4VrGU2eweuJcgh/lu5TkzgivGcR5rKBvsIiL0iRAueZ/BF3dgYtETXi8wYpQJUIK38qeKfx+Yt2wYkgkcNCvBZFuBP0p2Culg5WopfgiCQx02E+zxoT3dM4xCej24SKPavnA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7638125b-6267-4074-ef57-08dee8a3563d
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 10:15:35.9827 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q314nUabp/tqfSDRPnSNVb8rKg5H3jQQhpGx831qBgZ5tB5gzTBzYs3q6Ub8esWH5dLIDbM0QIyzRsQvlZz/vTX85mg70FC0H/zDuLefPnA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7956
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

On Wed, Jul 01, 2026 at 03:59:48PM +0530, Dhananjay Shukla wrote:
> Add support for MMG device initialization in the CPFL PMD by
> replacing direct device_id comparisons against CPFL_DEV_ID_MEV and
> IXD_DEV_ID_VCPF with the idpf_is_vf_device() helper. This
> centralizes VF/PF detection logic in the control path open and makes
> the code handle MMG and future device IDs without requiring changes
> at every call site.
> 
> Additionally:
> - Export idpf_is_vf_device() as an internal symbol so it can be
>   called from the CPFL driver.
> - Skip VIRTCHNL2_OP_GET_STATS in cpfl_dev_stats_reset() for VF
>   devices which do not support this virtchannel operation.
> - Skip idpf_vc_rss_hash_set() in idpf_vport_rss_config() for VF
>   devices which do not support setting RSS hash via virtchannel.
> 
> Signed-off-by: Dhananjay Shukla <dhananjay.shukla@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to next-net-intel with some rewording. For example, although it
touches code in idpf driver, the patch is addressing limitations in cpfl,
so I've retitled it as "net/cpfl: make device checks more generic".
(Yes, check-git-log wants net/intel as prefix, but net/cpfl is more
accurate so ignore the tool's suggestion)

Thanks,
/Bruce
