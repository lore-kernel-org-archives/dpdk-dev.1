Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A88109C02F
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 15:12:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A50F9402CE;
	Wed, 25 Mar 2026 16:12:35 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id EEB5C4028E
 for <dev@dpdk.org>; Wed, 25 Mar 2026 16:12:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774451554; x=1805987554;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=okqkv597HFIZ4+1Oyeht6naml4I9c+vcCzrbcXrcoo0=;
 b=iipLkQpm+ijX0OHW7u6ISkFwuk3gxGnM1kFIalpQ+FIWA9QQk1MoA/58
 74oAEQh5gdLaNtEFRCAqr/luuixTnnAieWWeh+4DqaqQ9yGitCKRDFlpV
 ZfJZVLCOVJ4XEvvjckVk6xx/mxAoDpfdbur7ouFsukiRy78r1+/gsUvQ6
 7qOX09bMX8HWWjOGbRjBTFrXj+gkW1/tyDDDYCw821g5v6sROZkcXEnqT
 B1wNhUEVZ6uu6yOKccFWy0QgNe4DzKBctJRlNy5th9vmiMaf4CDgSBHEg
 xIepTy7P/tJcQNGsdWt9RIGnLer8+bcARZZCUYfbNi8slwmBiuVOzlqcI w==;
X-CSE-ConnectionGUID: 4NnsQIelS8C8PslA3rKEVg==
X-CSE-MsgGUID: i1BmzRmIRb6nxdrcpFGEnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="86186106"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; d="scan'208";a="86186106"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 08:12:33 -0700
X-CSE-ConnectionGUID: rqu84wgLQcCFpNH7ckNGNA==
X-CSE-MsgGUID: w6rX3+nEScu4R4i1EakmiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; d="scan'208";a="247741767"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 08:12:33 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 08:12:32 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 25 Mar 2026 08:12:32 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.44) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 08:12:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NusayTkF63hEq+D7JUcSeQnYU/TcTfkhNdo7TnCPs4chu0luVAI4QkgDR0NXpmb10wp9DjjP9WxLZPh4vkZj+8CCfx4vYjeBYm8LLBxbuZSZyFM/D/BL1DBf3fAYEeqScZa7enIE5E3pNJBhDTkPRsAH8OLswa1SysfFWnWIbOX3J2qkBN6X5OiMxxXQXSmvgTRqmoyDreUTkNRHTKVONNP/2ronlIev1cz6zfufupoNxpw9BwKclxXh5VR7xItmN1uYKTqoQmGbtQaW+6Fzcvc/C/2HzPVQUShzhQWHrmoB7AWn6VaL51qE6olyJCKzGzjSfz/WS5bKneboLyVorQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aIipVHAxB+85E+6DXJugyUZ55/ucDK7fU+TfwCAQ6FY=;
 b=BrJH9Oc7u5DP1x7VB2/BNNPrOn+VpxBVW0uQixFdrx8mUmKR2jIpc5QMzegYjCSlpp9yhQoKE97jUw60jBKHSBfcRto0+zedykzKmVCucF1tjgxkylbkwys4Okmps2S3562oGEba3l7QlzUq4ntVVmXQwkRu/fBb4P79imt71RYl0R2DJM5zRN450DQzvc+qwWOrHWjUXsKq2dIt1+0+ZzOtqyxG49NByKQ07b/9lBUPcLJb4Ye8Ku1DlYgIYCxpK1cR6mKGC+gwE324gM9AHq77eBTlIC6hnEqCVE+/B9Ju/CmONsE6PNVBfp2SEnsjNvIGDS+zUGQbrkAWhBv3LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB7177.namprd11.prod.outlook.com (2603:10b6:610:153::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 15:12:29 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 15:12:29 +0000
Date: Wed, 25 Mar 2026 15:12:24 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH v1] net/ice: fix FDIR flow type for tunnel inner items
Message-ID: <acP7WEglEU_AMLX3@bricha3-mobl1.ger.corp.intel.com>
References: <20260323025418.651923-1-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260323025418.651923-1-shaiq.wani@intel.com>
X-ClientProxiedBy: DUZPR01CA0090.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::8) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: 9378bfe7-b45c-4d33-d8d8-08de8a80ee10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: Vhiv3eZKAMQMSdwm8v+IdvEBCeYPU7Niq5WGqo1YINNyzjkP32OW6LZ9NYw3kwyS6p72kIvtYT7qyGfpM6rXDsCRBleqo8fEbzlsIY1HbEMKYqzbnHZcrwIrM4mcUb+rv16jzKaVzmRXvLPPuuxOybdYG01HEsipvm9q/nSARmwea/8DI4mMLPJKIHT9Kml19RcWyUurWFZRx92nqKYYFN8nAPtYoQk+YaA5+7Bb3gUOXkULy8MRcgigSmQ5OorvANdAQGAoZ2YdCeDksXuZvuAhv174Qhasl8DCavxR0iVvxnVWrGlmJyyG2rvw79wm6vUQaa4x9Fe3XU2kpTihJcLC667Rm6qWNgVzZBuhL5JaCuzAkPlVLJi9y6zrY1fOEmsa2unjIoPufcronjtetN697T7Z0ZtX3SzExmlzFcJre1CqqB+qxN+6rcPqFGH6e3DVHtmytoEmma0s/Ayeud/nZpj0QD1uvEsTG7kfOuxWPPuDQiZULNYykH+Bf2h+v0wGImrIsaL9XNG1zGx5sHNlMuJUij4jPk+P7/l/Plpb55BB/crMKzUjJXBpTFD16BY1i0gQDG2g/EjKxKnEwqV0KU0BD1bmmTCyknS7nN7O1uVUP4byoRDivYJui+XVwKdSe+MFiNjoSzqyLkqA0Wd1MkXfoQXJzm0FL2KHtXORMYZSRp8p+ud1f3t2foBaGZb17ynaef6xnLMOefVGf0FWGsNvlExkro5I5nc/oa4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lOvjchsXiuTydPDa0QbuuYjA7W9y/5tNIOxips5GPZeC+ybsZTjsSCVt/iYb?=
 =?us-ascii?Q?xJN6lp1noNv/rQygpI63Z3V/B7MUDGTJuWD/bSurPvEMQa2pfHL/eHJzAe0c?=
 =?us-ascii?Q?BNUooW7sc/Cy/hnTvkj5qyxf+rtdJFg31nrkSW9cvJY+KL34YpdZn55f18xg?=
 =?us-ascii?Q?iR5mtDDkfmNOi21XQgtUbBy2jI+NMmrUjkakLqPjECLYrhIuh9ruPUOQqB2j?=
 =?us-ascii?Q?YzQcm3HZai4U08qw9kx8bit5ozStWf8M4tA9ufLsdkKXXtguxfmeLwlWoHn9?=
 =?us-ascii?Q?V8fI0tZO5hVREYyNNjM91uS9EEpZrMdqkicriRbC/ueZ5th3KMPKlGrdhITK?=
 =?us-ascii?Q?fZL/uKr9HFsMxNoU9j/5SaxMnUPdNVY+PFd+gtpIPfUmNPRekoJ+d+YLbQRR?=
 =?us-ascii?Q?Sjkk3P6IUSkc81Vm1+GFraJwW8zbKhfDSs8i0ZTtiLqK+Jf4vInERXpMcCzB?=
 =?us-ascii?Q?/3Mlfib8qf7Yek69arcyF6hwALQ0Y/0ge+rW3eiIRVCvDagdS879vbfn0kq6?=
 =?us-ascii?Q?nt1ExvHGkJGtNakkgCdk15CqWUXCmcHSWGTaQElDKTYswV2EH7Sv5U2W0yzk?=
 =?us-ascii?Q?72J47s/SJ8jbVsWhClUpOscWynw6c1hUzHJsS9XMBZSfQkmUUvQlmvQBBbCB?=
 =?us-ascii?Q?QZHukvG2UQG1XOABUBbgVYs/902U10mSPIIAdUhowSk5h0KsUAaryu6DF51y?=
 =?us-ascii?Q?K7MYV0W2h1Bk+c5o9gQWaeIiG6UKgaX8LDUN9sZ8BDy5qBcYi1rOEMTO/xJm?=
 =?us-ascii?Q?L69lLdbs6muskdOXyWE5GNUHq6ZBHz+qGuzAGqr0Dhmp2TPIR6nRM89eNZZr?=
 =?us-ascii?Q?uo//DXL3cGs/6CIHDQVE1vHOF37oRJTqf63nHifi1FLP/wuNn1Szx/DeVZvb?=
 =?us-ascii?Q?UYXfJg79iApuOsHDXxXVCZgfc7wfg2EAOnzVKDXPBVMnk3aTLy9wI1QNF/qm?=
 =?us-ascii?Q?AzRKGe2zAp8YLZRe/6OYrlMDB3KxEt69OlIAlzxstilm5YtuPLFFe+HWiTew?=
 =?us-ascii?Q?tZcW4LvEFArbFlyRGbq5dYuc/A2vRy8o5txkKgLixf55tABkyZ+h+5QX62pA?=
 =?us-ascii?Q?v5BkfuqMiOPo4/KN7LuYJCLv9kTH7tQYU4441XZT20IHHxwYDgkh2HrbSzEy?=
 =?us-ascii?Q?PPsUQ+YMkRdg98rJ/mXorqxbOAiDiluy+eAmveYLSD+T5dEs8Yj3gBNyDSS4?=
 =?us-ascii?Q?3Un/LXu7HULGzFelBdO076cly0z3Elpv4rWmPZBcjki3beNITx2SwfsihX0Q?=
 =?us-ascii?Q?NfHg280pKQH1a8rz6js70FD9XMrKb41Qe/PSPuVbDtm1n/OzpjOFnJzieoUL?=
 =?us-ascii?Q?ot01G6lH/dzhJnc4DqvgwQMASXDqEMryUmQRB5GbA4EBVrwvppqCKRI+zpbu?=
 =?us-ascii?Q?F6fKC9AxnVsSeybckHSt6LqWC2BW/9uWsCFi3oM7HJY+evIi6uLlI2kDF/X3?=
 =?us-ascii?Q?jIs+YD7ixOdesEYe4/aCvHBDKsRPtKzBM+I+m1JqFFFq9Bg/Crpu9JR8kSAb?=
 =?us-ascii?Q?wG19j5tsgzaBYE1dUUGKX7Y3sfrC9aUerblqVNqTxHqeHsre4ruyusrOjDuF?=
 =?us-ascii?Q?lYI6C8sBmLy1epaMwY7EWQNCEeHo+LCmXEzTwFIiDWa2KV5SrBxkseooBsKQ?=
 =?us-ascii?Q?41fHxdtcUtu6VANgzFWBl8BQCJGelFP2gBMFxYvfFZhqfJJcYXj8vDTQN17H?=
 =?us-ascii?Q?7QOwOZKZ5M28jTfn7LqUn1ewdfjbAhqhpioSauBrOjD+S16ktTXKNLt0Shw6?=
 =?us-ascii?Q?F24aZDeblxd3zcOqqZgbdQuG0hb6yt4=3D?=
X-Exchange-RoutingPolicyChecked: mcAxCbSpf702WA8IwwlMysfdCNeh8zFS1ShJg4KzZTztbAzEFv8ZCXPs9E44tt3nAU3VpRTUXvksn1FfJS1g77xEMA+iR343y1aN4jtujAlf4r7qImDiJL35aQKSKVnCUrPp6GoBACVq0YsSyDWGBA0VjeczAlMUGgA077cRAeUFFGRZ92eC4SBHSXvr+a+Hy5WQDdXQJ+hMsQ90QlzcInDIQBQnCg6nzo7A/Sqxj3SuF3d0LyvX0dX1JP0j7kyN/Y6egdfpI+P4XDqhni8A0VE1jYBgm5YqNGIca1Nq4co9r6u5jGCr3KFtYXASI1DX/nsOO8+F5yAOMYvx5m0nYw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9378bfe7-b45c-4d33-d8d8-08de8a80ee10
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 15:12:29.0750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cBYpanihBG3RB7Esou/9D4K2bctTyOVS4WjBfaJIdtmuRT5h+vXxrj7uqRIFwgpWDVHdPnHtKlO/eooRQ0geH2RFFig0bOGbvevjEciYCY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7177
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

On Mon, Mar 23, 2026 at 08:24:18AM +0530, Shaiq Wani wrote:
> The inner_l3/inner_l4 tracking was introduced  to handle L2TPv2 tunnel
> inner protocols separately from outer ones. However, the conditions used
> to branch into the inner tracking than specifically L2TPv2 tunnels.
> 
> This caused VXLAN and GTPU FDIR rules with inner L3/L4 items to fail
> because the inner IPv4/IPv6/TCP/UDP/SCTP items no longer updated
> flow_type and l3, resulting in stale flow_type values.
> 
> Fix by narrowing the inner protocol tracking conditions to only apply
> when tunnel_type is ICE_FDIR_TUNNEL_TYPE_L2TPV2.
> 
> Fixes: 733640dae75e ("net/ice: support L2TPv2 flow pattern matching")
> 
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---
>  drivers/net/intel/ice/ice_fdir_filter.c | 34 ++++++++++++-------------
>  1 file changed, 16 insertions(+), 18 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.
Thanks,
/Bruce

