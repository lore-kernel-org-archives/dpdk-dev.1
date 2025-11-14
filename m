Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A311FCE8D4D
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 16:07:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D7A9040E20;
	Fri, 14 Nov 2025 17:07:34 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id C3EA440151
 for <dev@dpdk.org>; Fri, 14 Nov 2025 17:07:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763136453; x=1794672453;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=TxTyIDx9aerjpYeG/cEkccGSSITc63WeYMhM1tf08jw=;
 b=KOkW4f+oncW2qjdkpP/LJWB/E7vh3CxGaK+CQz5UbNsmnQCijEASe257
 Pa4jZrGM4cVFyVMKk6gPg9TEKVSbSNQO0fh12A108Y8FnQyPFoelv1iT3
 VTv1PzyNgFiNX3HZkYRGUBuDLpzGaURTqssTVESufQhIISiM3cHKF3k7+
 3K/A1R2BftSot84qX+0R6j9YVRDwvzApmOCbAaW0LR7KbdGpjD6rY7MzZ
 +9ShTUKqb/YLHtOAossNkj6xWC+L3mE1pSIrWPK9rU4cuK4ZEIDMRECXq
 F+3+jkDggLBjD/63SxFe5ccWntMD0/Y6dk/pymN6ozmIoAWRHzIjfseJD A==;
X-CSE-ConnectionGUID: lFRs0SGNThiCg6eJOcNFpg==
X-CSE-MsgGUID: evUH5x18ThKENMSwTstJFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11613"; a="65136192"
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; d="scan'208";a="65136192"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2025 08:07:32 -0800
X-CSE-ConnectionGUID: x919ACZ9ReK1Mbuvt88CLw==
X-CSE-MsgGUID: 6MfiCsdwSwadizWsA8hLtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; d="scan'208";a="189099676"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2025 08:07:31 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 14 Nov 2025 08:07:31 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 14 Nov 2025 08:07:31 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.13)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 14 Nov 2025 08:07:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VIQKjpq6oKHPGMikilTPNwbECqzgpjReEjRXmKX8oN3OCx9aL5+wMfWt2G4SqJEsAJ7pO3rjl9wTF1hz+6QCL64e0NuSQq0XRYegRHVoay/IFqkwN9VCWALWb2JO/u2ZH5ioDMvykTu+UDFbqgs9idcIH/gNOSH9F9w5OOFEv1uWKogZotKKdIeJEXLc3kHsLpQp3z7NM9ERkA/7+3p73LwQqkgfo0sqsxL2lXBD1PNwdd0wPQgezZylnjtFBwhIPdjw0t3KcGpnvtTtN8RPrSWPL0YuVN/5dKXamRE4rQ73NW4UI25bwhvXSsH9cucHuwZ33++slPS0Dj2aY/VJ3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DEfXf1vBImposXynwuOprXUw4ZxA+LGTsq9SrM8kU+c=;
 b=zWYOBDpofJmSdAHZKFkgC+WmXtrjMvi0RcFTILXuKl1xLp6h+O1Wh3v2SV6JaYb603lCZXhkPVPo2wW/8KpiLomgkhKSHx50QuQXYvyDQFKCgp54hQTwk09m4HnpLJsUIkmlAxbhTpx5+pmXtMkmBta7zmCZWPrj1WBfUXXDf8/tAy9rLbIl/wwiSmqqpoaAcmZzqXfyDQIzmubEbf2cLcNVt01xOCl3mRorALUdLtWkDGZUpR2qU3TGyq0effUL3sARk/H71eRjbIdI3st6X0K7zRa9NblrpsCLj/tKx3k6RZ83Xjm90lDWycAOF/uXkxDIfpStfg4VIT4uqFHqHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ5PPF0FD67B0BC.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::80f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Fri, 14 Nov
 2025 16:07:29 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 16:07:29 +0000
Date: Fri, 14 Nov 2025 16:07:25 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 4/7] examples: re-enable format truncation warning
Message-ID: <aRdTvXgbwX1r3t6B@bricha3-mobl1.ger.corp.intel.com>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251111221857.443752-1-stephen@networkplumber.org>
 <20251111221857.443752-5-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251111221857.443752-5-stephen@networkplumber.org>
X-ClientProxiedBy: DBBPR09CA0046.eurprd09.prod.outlook.com
 (2603:10a6:10:d4::34) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ5PPF0FD67B0BC:EE_
X-MS-Office365-Filtering-Correlation-Id: cdf97915-eb8c-4cb0-fb1e-08de2397e940
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gY3JvFywHu0wOUFN3nYXR9TEk5ACOQKhV1Aysp8evUI/wKcCTDVZE/m2ovq1?=
 =?us-ascii?Q?uwRnaYEL2/G6Qgcb3zkGofQVFR94QJwbQqmiZ6Lw0y+1LUdiMIjm4eHR6EEU?=
 =?us-ascii?Q?OVkXEYU6qRXQG/lJorLHcqk8LWNJCUOf7F938CjhxviEp+zunMtD7KCN8Uvd?=
 =?us-ascii?Q?LYRsd/LWzfnwLR0JTnCHypDW+KO+kvalsTMA8Dyt8DXh3OMkGEsudftyyG+y?=
 =?us-ascii?Q?vwmHoss5g98KhD42RUkmRutnAKr8kcHQajPTdOL8p22B0f+duT4lhVtlxjKm?=
 =?us-ascii?Q?zvJ1OtOY+2HnI8aLDIi4gD87kEstHV9VjBThrbmqMCKSzeOu1W7ZFDLTYPw4?=
 =?us-ascii?Q?AVWIE+a0BRq+dGnpWlCiABlwzs/RDt3nXfqvMd1Aq7Vx24kq7+yQ56dWnA0X?=
 =?us-ascii?Q?lR4ojyZtl7zVZUp2ikkaRjnu8wqZ1Ne6B2b1HaEQNxK1oAFoCws6F+dDAB+E?=
 =?us-ascii?Q?KQCjryIPkrAgbLcsycJGlNYqM6snMYdg910tZ5pwhI19i8oYIEjUb7Jd9rSp?=
 =?us-ascii?Q?IqEnZnySmqMlXGtqYXh6Cw6oMnAq8wmcVXQ/gCtKIYQBtH+BhRbxYE2MWCUz?=
 =?us-ascii?Q?6Xiz5wvohWmEAuAwq2wirOEncwMletexvPB6uxEpOpJY33UzpKeaLQvQYBiL?=
 =?us-ascii?Q?VAIUnFPzsdqtbA4pszYtMacGblalbyanobherRfcBlSyfW1zXuo374kkMhMO?=
 =?us-ascii?Q?VwsINy2Er2t7oNXiuZqtlgAJKa5QfbgX6fMzaYHO689T5uqX7y8l8XHAYXEC?=
 =?us-ascii?Q?hcL6FrtxLVMTAnCYO4niC6PGWJ/LY2BBpXoYwEqHI7Xt/54iugfsW1ffPo/1?=
 =?us-ascii?Q?blHqTtrSeYfv7CpEtJ2PWMgtptP4srH37xeuDGMfW4BVoWRA1VokjHg+ZyMa?=
 =?us-ascii?Q?+zkqKQUYZd2PTtpQsRBhJaI3U/+LCi7Wpjbe70rpX2RhTVr5jAPc32bu82m6?=
 =?us-ascii?Q?uaq4u0H/PI62NydDSp5JEY9icxu5UE118HGFGTEY1wI+1YpRnJ8VOPUffTGu?=
 =?us-ascii?Q?6c43zZQr1hJ4i1l8+G/qlL96l0OVZ5bZuxbZJo/MZFPXlQCv6bs/dBNtQHwn?=
 =?us-ascii?Q?WJzGU1Q+jW+YakgNU9Bex/tdI8q1YAxXMLwFPklKbyaZlLXkEyfgRZ9Hi1os?=
 =?us-ascii?Q?3aZEv9PcqrDxNBzJEdHZlTRqDapJdW+jpjaZIK0QnSyQ00UX1in/QzrSBN8J?=
 =?us-ascii?Q?7xFqHYHegpKO1k48LL8vL28470MjHw8cFYYzgKogKslQrybLMsdW/BV+Y52P?=
 =?us-ascii?Q?PNsWho5XcOyEg0qudqgsCKc7b/UbzFGsU5Jp0o1Dimwts+nyqqXkdhUVCmjq?=
 =?us-ascii?Q?Zcuqq2hpcZlmR2q82WlwCjAru3dy3COTMBC5BPoX98AT1CrDhe3AtbC1t1S+?=
 =?us-ascii?Q?uyRcOOsVJ9wTaSIAJ8mmHesZA5dQ+zkydcV29dK+IciP8YHBOmZpmWsE7fnD?=
 =?us-ascii?Q?GoXQT7Prh06/CXn/q1Jm+SY+/Zf0p1c4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nm9XLyoTTYWyWagXHe+yMaVizfneiL4V4N1KFwkqjeHDTfHc3BgBkRtHsIZu?=
 =?us-ascii?Q?rPCAqjIbCJOE8cP+HKd0fv6TloWhJ6PrTB64jgXgup9kTiyueij16rgAgnU1?=
 =?us-ascii?Q?FxsWtZQeZ+ye4UGNftENJvKkUvp0XJPQT29yLczsyj8UbKiS7n1gdiRJSQVA?=
 =?us-ascii?Q?6X7f5VyR/mq/clvW6x+tAOHm+55/GX+NTKI5dVnbGtlTOoVB3mwM+9FFtUVE?=
 =?us-ascii?Q?Nt50+RCO23G2i98Ko4WKwj8dA+/dq2jAPWQuBhUIfgxIgT+bE1eqk6MLq6+i?=
 =?us-ascii?Q?yaVRRzNPnPWndpbtSlHUJy9mZNOYt/CGl8iyNZ0l4zJDoXiWn6bjjAGeTW+I?=
 =?us-ascii?Q?q5Ly8BPs081ujspv0buRPR29UbkxgHajn5nyAINc2ns6ug/oBf8g90ts9VMg?=
 =?us-ascii?Q?xQ1Zk9Wgx8ei7VXGs1MLPxNznhjaBQItPm/QcTfeTtLwxgoIkNN5cjNYZPBv?=
 =?us-ascii?Q?iMAwPQ2yLpV2zwZUEThJzJI7X9sjjIWA7xI/EFYOSxfkmqGJSEFZSAxBMHM3?=
 =?us-ascii?Q?9ddi2fbLmLPAiYG9OcGTNUtoP6i2tHaL2ZPqtyd7gtuUhLxuJ3Et6t+RVt01?=
 =?us-ascii?Q?ix3ny2EyEFroxbuXha/W6yJa1SrnhVdtXUH4DodjBdLV/OuRUCbVRZsxn2c9?=
 =?us-ascii?Q?491N1YydQ5Gyth5/o6chcdHCLkMKWJPmgP/gzY2pi7X9PB16R6kJyFpeIKk0?=
 =?us-ascii?Q?1yp9l5ghKK7D3feUT38V3tVbW9vud2Ts3gMbXz0StTUMKgx9TL9HQ2LRqgSw?=
 =?us-ascii?Q?Jgf4LB3KVG7MG6Qiri7aU6AO8rxpBCkQJDDHOSenbAI+GXQihGgVxGGLsz3r?=
 =?us-ascii?Q?1lpAA3/4Bl8B+FS08uECpPwrUFC+HShKFG9TSs74WTkUgeIGM5e5wO8/1juO?=
 =?us-ascii?Q?zJecG9i1hxg4Oe6TItIVLhph8X4RyrE9Yk97U+K3CEakxA+7zqusEGiZeGwj?=
 =?us-ascii?Q?gMdPMkAJ/6iOXMaTIC99OvwMy7+WdZq6WxmR7Z8LVjN0eijP/qjuMjUjBFuN?=
 =?us-ascii?Q?0BmcWk1nXE3cTCszwNF5Xwee5CeGJOavbnTCThv5z41O8sXuFkZuE8hBCPnW?=
 =?us-ascii?Q?Yc4dwNHuWPXfG8xmZeBrXwpicP+HyMbTpqEb1V5ULTQm1tD4weNK8oBOReFh?=
 =?us-ascii?Q?f/5NMjmGeWXWux1Aou4sB7v3yqMdiUCJld/WpMlKvpznwENEs0cTlu8qygjD?=
 =?us-ascii?Q?nx4CfSBDIBLO5jAjYp/ucek9OZ5BrqXmOIS9itNfU6brh0AVIfgWGHOyzitH?=
 =?us-ascii?Q?LZKHqIOBcLKrG7cTlF4wQtJWoTlg4XrBal8iioV+LY2NxXP9YF4qaof1eCDC?=
 =?us-ascii?Q?ZQhH3WBlEjkYioPInR+5/lR/qYzhiWr2YTd1OmjIqEPcUdgMXWsVPT3Vi+5F?=
 =?us-ascii?Q?hoOcDGGcjdT7n0773gRQ0XLwTfGzsD+5NjMSw8nusjRsTxijVnQrE33iws6Y?=
 =?us-ascii?Q?4k2GQbR3G899BxGEfTQuLDLqIUP2RylRbGEJAfhCzyNC9as8G44l8OW20+md?=
 =?us-ascii?Q?+o6OpQgc5Ogw3yqe9Jt897tjXuG0+EXdDRQYevHS4WHllz1v3n9YTT/ZBBb9?=
 =?us-ascii?Q?8QKt496LTrMtQjjF87OrvFBEUHJNo7EFdw+9m+L8L8slV2YCsU/hTEWEVQKt?=
 =?us-ascii?Q?bA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf97915-eb8c-4cb0-fb1e-08de2397e940
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 16:07:29.5670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YnMFjXJAhx0w8UY5eu/37ukr9crS/kfD3oPW2HOQ3y5pJpAITxYqJvc9qLCcDHz6WpxF8ez0F2c/A9ogX26JuN/qVLWyDMlbP83KjG0Xn88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0FD67B0BC
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

On Tue, Nov 11, 2025 at 02:17:21PM -0800, Stephen Hemminger wrote:
> There were several hidden bugs in examples because format
> truncation warning was disabled.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

>  examples/meson.build | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/examples/meson.build b/examples/meson.build
> index 8e8968a1fa..25d9c88457 100644
> --- a/examples/meson.build
> +++ b/examples/meson.build
> @@ -78,10 +78,9 @@ else
>      examples = get_option('examples').split(',')
>      allow_skips = false # error out if we can't build a requested app
>  endif
> +
>  default_cflags = machine_args
> -if cc.has_argument('-Wno-format-truncation')
> -    default_cflags += '-Wno-format-truncation'
> -endif
> +
>  default_ldflags = dpdk_extra_ldflags
>  if get_option('default_library') == 'static' and not is_windows
>      default_ldflags += ['-Wl,--export-dynamic']
> -- 
> 2.51.0
> 
