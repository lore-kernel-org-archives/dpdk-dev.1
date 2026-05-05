Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9E3CD3427
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 16:51:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 723664064E;
	Tue,  5 May 2026 18:51:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 481934027F
 for <dev@dpdk.org>; Tue,  5 May 2026 18:51:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777999901; x=1809535901;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=7eXsg+jaOTYZUtMe6VGFaGP1epRhcdIeQvfOdJCL76I=;
 b=A4gqI9ZQr0399tuuuYfvbGSG0jV86x9+YnAa2UGMUuQDlHBH9eq0r4sH
 Z2OudduvkSy8SBkQpeoU0ncWdJVPBi0ULelMHZ7gQuXyC3mYOyFsbhF/a
 VTXIr9MLvsTbepXRKMnJR3hmRVCM1j9zObIEhaepHUoLM9QtxhKZOFeqA
 ffuNtKYmlgr6flsoZ3qOuTJgKrn7Vqedeql0ZNtb2zryH9L0xHxJCXF04
 5Klr9LX35Lt26WT/psz/gUx5HMAlS2en2ajsUOM0NsXsFYzukepkviD+m
 78BlShB+z0itWS+368Qjj7oJpREm0kD68t61nkemYdkRHiIW5ZNZbA4OJ w==;
X-CSE-ConnectionGUID: 1ET7Evn6SQKFH0RNhrL3NQ==
X-CSE-MsgGUID: zHgWeyz9Q1C/R/GJhpPCnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="78738106"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="78738106"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 09:51:40 -0700
X-CSE-ConnectionGUID: dXQKac7aQjOexSG895i2Gw==
X-CSE-MsgGUID: Rk8Bd3ikThWqfyXdqsRTvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="233208984"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 09:51:40 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 09:51:40 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 5 May 2026 09:51:40 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.24) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 09:51:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fitZvKEYK0vIgI51sV3bFM860MzqxaQHRLMAKbQcnlL7dMAyCKcDW+31YWsOXtmTfpBR3Lq8xw3OzCRvvzoUIaWONWqAvmfUVN1cbjVKeZPsAhGYkplIxFv4/0FIMePpA1g/G9GMoKTIv8+qgyy5qE7jHlISyd123PaDLillc4HW7n6uh8HbDxjVHPqdF7YQkydp+573aycIftpjAoW0nDX5uFg93mRZZmQ/+EFeJFXcFvBi6XEhXL7bQIc0zCPVPHv/UDz71xWyc585oEZBHpNL+RLZthSJMh9SpmhnKlgZDUVrQuP3h6sJpGEg25bydQmjf7WvoWck+96whC3SZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkO2CcdaIp1ql8KrkWCQ40KOH6vj+pwej6t/TfH6gkU=;
 b=BpXbSe6ZzL05zs2g6QPSx4KiJvUVKhlXg9QqAroXm4dVC9FGL7+DNlIhY/nAuOtn9E1cS5/siVA3liPX9nHjzGI3h+uyO/ezgFA5ynCZGbF1U/oQRktgC6tRir5rYKgvl1HVOy2cOSIbm72gi3gE6u+iiPZ7Jr6g3M8Ezb+mvCOyqtwa+lYtjk52mS3RmXKpUNuo6OawyXQT1M1JsFTVqJ1xWqV/WawsigqRGrj9VnZC+sVugwWmbRekJagB+mFJ4TSl7NkfaHMefvRiKLEBLI55lkhJN15R7Kuiq1Nac6Q2BjEENXhQAo1FAvDCgUfpd8HfSKqmGUeI4npjrIbT5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY8PR11MB7828.namprd11.prod.outlook.com (2603:10b6:930:78::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 16:51:34 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 16:51:34 +0000
Date: Tue, 5 May 2026 17:51:29 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v2 1/4] net/ixgbe: implement flow dump
Message-ID: <afogEcVLhq1aAcIV@bricha3-mobl1.ger.corp.intel.com>
References: <8885d9b4e9d1290b5340b9eb3da06d7acb2973c2.1777545092.git.anatoly.burakov@intel.com>
 <cc3919f5b33e633d4fea632ac2126eed2b537175.1777546834.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cc3919f5b33e633d4fea632ac2126eed2b537175.1777546834.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU2PR04CA0044.eurprd04.prod.outlook.com
 (2603:10a6:10:234::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY8PR11MB7828:EE_
X-MS-Office365-Filtering-Correlation-Id: 88626d02-8d57-4f15-1531-08deaac690dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: VfBczXbDwumJqDgUW2k0WOdfMBGlyTe2hN3xAScoB8nymQRwSVZYzPFT8XoglTI7+sPhnVNv5HtbnQoP6Udk+E5M1FfNx5pTDyW9WrQk8dC1+VxUGxOuwR2fcHmzGxLfM9AJU8NQdKjwX3vggfuq+G5KprJZXqZp6MSLieaGE1AKAJ0SzCbw5f85q/Ow4MKGffAVprFNmqStTtyVc0ajQAoyn9ganCibGyw6STOFr1ybpT2PZ9VEHtmTif/xAYBYHiD/+gckeVicQo78blCcmJY0+3YLdyZBigGgLGndDFsCXWTPYjCkMo1xTikx3b1qc21AROTckEXtJMuIjR3PgeX8PtjgrcA0fD2V/aHaxhcoCWD3GuKNpCC/buPaJsc94bI4hAIxPaPl3OUZ5ISKStRoL/fygn1pra0PfmPsU+vWrUQT9hVE1y103LpG/iJmLmqXUZike6ToAimRN76pq46pLVTeUxTDIMbC6vC5kccn2mCVglmrGX4HUPxAVMdo1CXSbHc5ipqxqtwW6PzDSbdliuGMD0soygpmniJc4bJhAhswWACLCCUuGEOJEosTYSaUfIM5x6eSvPWoH0I1kPVFzJvFp2+urCDd7SmGrVQghKE+pHTtKWhtrlJUlCBw/YrRg/Rru4QYJNF8ctouB8wIPHxb9wcBKbX3L8yre57yS/tonJEfYgpeq9c+TzSQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JfIz36XucbaFAruNqKHLtB/+2k2L1BHDyxrVzJ8ysveNN0hB45XDpof8TwZr?=
 =?us-ascii?Q?v74028w3xUxPcmbuJqJe1UV3H9AoHKGBkfpbu3kOlWPpn4b6IVqfJY+ZvQXi?=
 =?us-ascii?Q?P+qnDCqlynuupadNzFCHlczBJF3T9hxYK3i5wudz9K21r+YO6VbV+EgBeqkI?=
 =?us-ascii?Q?5CBDfCjACudJmFaEEt9OvJzkT5wZ1ILsu+q+VnbADJzIH+PP/D/w3F2MZUWA?=
 =?us-ascii?Q?JPtoj2SULK7KyMLxRc49swytNsqtt+rqDFHD8IhERPsgcviei8ffJY1lKSLY?=
 =?us-ascii?Q?Q7ejsQUZ40Z5YEBj3a95WWlbkyQtkLM2wtPEEcKDcmcChANMVuRxIHxoANYq?=
 =?us-ascii?Q?YKc4SoO/J3zSavBJq5leM7pFC/+wM9S2JSFopwDn00m4vUUoVtbZPA6oXLg9?=
 =?us-ascii?Q?62XWaAKCLQ/UWFzRfRHJpj4H2YOntIa8ZxDGwP540MsiWR6S8FU6lKvOw2Dw?=
 =?us-ascii?Q?zVeogvlLo2iBfk0XGeMEr2e//hwm330x05TcJCJCGKWBFZVFlK0NrnS3nzcq?=
 =?us-ascii?Q?UL+uzJQnIlnSQjK9EEBQ1rgC8fTgkzDhEmYxA3ajTuxHl8wSClLfzwelsL8J?=
 =?us-ascii?Q?U4f0tHh0eXZbzXoM7G/DF/Gko5IG5gc4VGag9hjYj2TmsD8M20VVo+hEnmE5?=
 =?us-ascii?Q?885XTG+JRpQ1fGFbR4lniz7BKRu4wlBbGFWclEIeCLhGXghZ2WEza4v1HuNI?=
 =?us-ascii?Q?akPxm34oT8cYjp7DX2QXOKdomMVUWfDKhDE7U38UeCUUTkGzXxAcF40dqO60?=
 =?us-ascii?Q?J8OaD84QtEnDhrPcTcKeSnHEFN16q2oJ3IFOrN2BSry2dJaj0+IzDpxeBNkN?=
 =?us-ascii?Q?0yje1BQqeC6jwojRy4EW7X99zWdk7qRC6tDZsywvLGzoy51PFxsflPJtK4R8?=
 =?us-ascii?Q?Qpd2r5kr5QevuVRmFJPvppebH6GNYIRXgwSN6adrwt5LSFH09LBMlHzrMBTm?=
 =?us-ascii?Q?MvWiSbbPYs15nuoWPLtdQ21zVMkXk9fYz9st0Y/50lvZERHKZEwxWGtDI4W6?=
 =?us-ascii?Q?cvCSbce7XvL5thC+WjrB0s/CVeqCuHLzP4dEUyW75Snms6iCVLQhK0j7rXKK?=
 =?us-ascii?Q?p3AE2NXIy96YNVTmALWWDqMYadXQXHw0mOndlII8IAwcVcWKfNgTSyzmq4Ph?=
 =?us-ascii?Q?usYBIr/DScCVz2PU+iR2l3jb/HTDj+hkI8LpwO7uldnhG60wmjWaGYPSVhfb?=
 =?us-ascii?Q?Mbw1wKmDn9RQD7987M4xvhEuXTywJ5BAqyB4Sl8uksvGB7/uXq2ocUDdK+1k?=
 =?us-ascii?Q?7TbGn0j9fR7yooEh5QFTaodam6mYrNtFBQAgWtmMxCYFbIH3TU2c9rWeaggl?=
 =?us-ascii?Q?5bJLGNNgFDPyMBxQFLGxmU4tAL3sKy5Zo/jVQZV5r0DMrkPMnABhf3hLTztK?=
 =?us-ascii?Q?cGaV2p4gmz3XEasqgWQH7pvuzXA+8I8UUfISOD+w6b3Fh3HT7Ll8ziL+Xruh?=
 =?us-ascii?Q?LmAM8XzzuzRVujtfhYR+QWze9cBU4W81nk5D7XIF8W7PU1TR5DjtZGVM+gNY?=
 =?us-ascii?Q?6TLWtLBS/n2d5nFSAeVcyjlRy87qKuu4H3sXO/eIoGL3ppN8EFJgRHKeuMJt?=
 =?us-ascii?Q?vfnmtRamLft0YkLoABbsOlPyjLmFb+a6CjfQr4MtmxhVY1UnfFFxHN0Sc8Ca?=
 =?us-ascii?Q?T+A3FKLWSlOg5SFX4Sqvi7c+YQux5hMlg2zyZTt9k0OqKw6GjBrwF3G96cch?=
 =?us-ascii?Q?Yxw4xRRJLX/xmgQZ5fD4MjTJeyqsmYjgqsKkUYZDOWpIR9NdGxdXCB17IoXw?=
 =?us-ascii?Q?XdiPHRrrMTIlI/4NzsFgkfVZqkfcGdM=3D?=
X-Exchange-RoutingPolicyChecked: hefZL37ztVEJBfCMb31drJYTjv4eVyIfrpM0sxpTS5FswE1fWH4sYwJfWkioHhZM9nkxhyH526bEBQHCbzyssgVVkh286xRkRl2FA0rJVVYdOV8trRogv8pc5evDDQKay2vxelGhAkGgz1qNkk3FWQLWgEfq8U8/Jz0S4UW+lXxh6z0ciSRiN5nDxzwrSZIC8IXZ02bE+qiKqGw0obqMUzzRfDGIOHLDcMzYtDA53Ha0ixMjTjeJOz3c4/zgr8HZQmwr7huQhDMVg9kUg8hKrn7efAlM53qwp4of8tuepaWFwaf/rtliOKXc8T2cmR+mK9QuG60b3czgltNeTashiA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 88626d02-8d57-4f15-1531-08deaac690dd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 16:51:34.5079 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eQMcdnw6vV5qwtJgCvoVTiuDjZod6kuMjCKF29kZqhp0bFp5tMnZvdiKqP9UbkfZDSvJd3szL3tL3YtTmdxaHvwLwg99OOBgJuSeGhD1pCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7828
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

On Thu, Apr 30, 2026 at 12:00:44PM +0100, Anatoly Burakov wrote:
> Implement flow dumping API.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/ixgbe/ixgbe_ethdev.h |   3 +
>  drivers/net/intel/ixgbe/ixgbe_flow.c   | 141 +++++++++++++++++++++++++
>  2 files changed, 144 insertions(+)
> 
Series applied to dpdk-next-net-intel.

Thanks,
/Bruce
