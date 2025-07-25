Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E314C87FCE
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Jul 2025 13:44:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A40244064E;
	Fri, 25 Jul 2025 15:44:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 878D340616
 for <dev@dpdk.org>; Fri, 25 Jul 2025 15:44:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753451047; x=1784987047;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=4vEek3dZVnZYCiHQMakCh2/nidxsIUDlysKH+uUVw2U=;
 b=RxESUAXTaA/1ZtcQoldrsMuknFSWnn3Zq1dluQr0jfGtw6WApqy0fi7X
 Enb7PY2+xIxq2SkjOrKFqDW0nbBqx0Mg4k7v89x8JEqkxYtG3YrAf2G1m
 3PXh4ITu97qIXjwnKILwimBPkf5xcDU7zf0Qosa5s3LV1XIOuq0G7pU+P
 KZwESt2IANlaNyCyzAIJGpfCjhow1YL5o8zuzbuCEik06UpH6OEUJDKSf
 sQdo4qVcEaNW8Vr5QkYbsnZjDG2jMYQbZZv2kSzKb57flcoxBQnYkGoUQ
 P5Jox4lB+wuQWz8I0E0M0cWCC+ObgFJl26dgXKI+Yh6tB1dHvslC3DvCr g==;
X-CSE-ConnectionGUID: 6F8u/ha4ReCkEYosmbXL9g==
X-CSE-MsgGUID: 0xzdnH5pRMmvWSBNMQuCNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="55725276"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="55725276"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2025 06:44:06 -0700
X-CSE-ConnectionGUID: nI5hUplPTNmJPGEScToMoA==
X-CSE-MsgGUID: v2d8sudNSraYiJ6sz9sD4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="198057699"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2025 06:44:05 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 06:44:05 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 25 Jul 2025 06:44:05 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.72)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 06:44:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GFFkC4TkpsudVyHlQAZfDgm2YyAQd2nbCFK4lmBrCxDTv89puOSEEvOLl4mobvKIF/NjbwxmWdJCpnh3q7RrWJleLRUMSWrBjIDLp+zwBLad0A3/LE0Y0wQel0+Gw/U8a3RLV5vanqmoP2bQILVhNT0dgMCKPguNn0F8+13Fe8ZcB7EMDotGUQxJvmsCPUnQMFtqJm53E6ONM5QrgZHuSNMYRdfnRRBG2h/oUKTMhgClBxczAFMhiYVDjDy+pNtAaeTXDe0MuxK7FP0foNZeprFNUElFDOi60YCPGt8YvWteSeqeG/aooWTpYSuPQZjY2Hxstr9NJCJpaWZN5u/oXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v72YhqRKx7nEbx/vIOUorJ5D3UxmPtbfvQGfFsiJq2w=;
 b=Q/DAzMYaoqnQjCida1cPIwFSEmbsFolChvg0eyIJjrcdQp6hC+Ah3/xtfCwQ2ZSlCkz6wCBdaQux5o96uurBARhbfrEKc6ktm1d4dy/lcR0vwGm8A1pE0bZu6IDWCTfPPMHRaike0nW0EKOd7DO81cMMxCgkfFzBMgn0i3YBWgptbFTo/NjMFajUvxLS93lmkz/z5GOeRIBa26tRwj5jN0IlpPnvwpvYtlMYlQ9SGfSA2niZLo6472s6EpkdMmVdQm2Yfc1auewWUD2Xc7W8oe1lJNYAIIYgsHv4/HTtioTBb7d9JlGoUDaRfaM2BwFl5dsMcme+p8LcO9zR2qgsHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by PH7PR11MB7002.namprd11.prod.outlook.com (2603:10b6:510:209::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Fri, 25 Jul
 2025 13:43:35 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971%5]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 13:43:35 +0000
Date: Fri, 25 Jul 2025 14:43:30 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [RFC PATCH 04/14] net/i40e: use the same Rx path across process
 types
Message-ID: <aIOKAr9LyhWf4A3v@bricha3-mobl1.ger.corp.intel.com>
References: <20250725124919.3564890-1-ciara.loftus@intel.com>
 <20250725124919.3564890-5-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250725124919.3564890-5-ciara.loftus@intel.com>
X-ClientProxiedBy: DU2PR04CA0163.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0::18) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|PH7PR11MB7002:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c4affe7-be24-447b-43bf-08ddcb8140d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nPaePZnMW5eXtOzthz1GmiHVrkX+e2nVStkF3BLTsu9Z0hB9/XicfqWhcSoN?=
 =?us-ascii?Q?5ZogOLMfqJy1GLAE1OXhQnYVUbpwewWUagCnCHJVLulO4gXk77pPfcxqc/Df?=
 =?us-ascii?Q?rHjZmehNw1x6lr4JnBIx5HlngIh+GW+MIWHqd508LZ2Y/tmSVtcKbhT51aRp?=
 =?us-ascii?Q?iYfwIk6WcCXI5UEsJLesD1PBlhd6mgK5UvDfhHOy6TNm16DepetAcMrwJgbS?=
 =?us-ascii?Q?BzqPokyrfIGPUQqYn+bjDQq+b7E1OP3NUrr32y8XkA+JXf38Esl+n5EbHli+?=
 =?us-ascii?Q?xBXOvS8hpOfvdnuUU48gPCpOyV14/0IIuLR1Mlx8Os7Ziya1filzDKgaYbSs?=
 =?us-ascii?Q?V9GcY1SKnE3JWCDobb0keyAguKmCtFsHgpwgljwtiscgijnS8iyuxY0UGZic?=
 =?us-ascii?Q?YxWSjhXFqGQBWtWennrW2MPh+cQ1K6vhApoml0Iu3yMt428KBEjslOhemLMy?=
 =?us-ascii?Q?J9pJ2LBrm2cjIzyApGlgaf1c6PpqeKKiPAQjzmtHqrY0y0QLhXo3PILX5WcA?=
 =?us-ascii?Q?va8oG/Z8yQF40Pae3ZFeQk4J3dkD4w8BftZoYIXtKvELWe1qhsjffq6dbY2c?=
 =?us-ascii?Q?A9g42EPTmyS7yGieZ9jc4vDccssN15bwFm++pf8o9SJk/Hchf6zHWbEuSWhb?=
 =?us-ascii?Q?bzBub4/5ixiJFLadIbAI49F3PPQhBxxfFTh3X+5r9zC7im8Ly6teGWMS3LVN?=
 =?us-ascii?Q?g2GeFIK8lmePpCFrj0ZC2Ew5clSvGQ3IRG11QNmXVtvq4nwWtQLRIDO10OSV?=
 =?us-ascii?Q?lOCgU9+BmpCq8ao8t4LFbGDx2AmdU1JxiWCjOm990/R34HlJJKyAmxF4lyr0?=
 =?us-ascii?Q?v2rmNVf+zMf8EnYm9pExPcmaXWK+LEc+RqFvCpIdUSB2ZzJ3zUz2PIaop+F1?=
 =?us-ascii?Q?6GADZBa20iSeZ+JTwO/0vpj/eedddQvFzsK1Bb+cHKDVdxBOFxYUmWM+inqD?=
 =?us-ascii?Q?kdX8196XUT0FIZRTEX/V0eKxr6aPL5Q56pu7jZIEtxrMhl/JAyDOBu94q7iU?=
 =?us-ascii?Q?Cbvp9V3tON+U/GOVUPQsgSG+B5+/1FpiOXtY9duahZcWFqGkvTSAB/DZXXLH?=
 =?us-ascii?Q?Vp1AabifndEIBDv8IkkgNWaEjiLFViQWaomEbaa7JLrmOyVEmD9gV67LuTTA?=
 =?us-ascii?Q?oYwElORnetXm6Hj8/lB4leC6GKkkdPSf+KnojnpaMGxKKQGbG67Rc6Vjxmwj?=
 =?us-ascii?Q?xqn3h8pbvmQaxFG5C5//JLESNllCRXzWPKu/7RNRBdHuE2EO8Z1X9oOLd6PT?=
 =?us-ascii?Q?AQhavWOQk7Qj5Tv4cOb3hFRjjeDvbafYMPf4PaeAIL/p5q5Q+fUF8USYUfAn?=
 =?us-ascii?Q?t7pa3XpmjLDKcwziAVQUJCQbRpmqN14yfgoihi1cypEMPVWGTrycVeeVE66d?=
 =?us-ascii?Q?hSrYa8/Kdt0mUwusB5G0tMisnXIYVmzgbYzYtUx4TjliVyeKqFwHyVsIfAGB?=
 =?us-ascii?Q?rcNzx7bX/ms=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P84ys1qUNnrhGHteYhsLItxeS0ZdHyTece3skpFnvP9jGwkD0argMpqwiSLp?=
 =?us-ascii?Q?R26icnYQmxCxN34psy7meNvdviggpjIn9U6e57wvd7zzeIbY4YduE3IeQw/B?=
 =?us-ascii?Q?WPVoC0eww/YKcURPRP12zmul2V1neyaU3XfKIWCRmASsbK0VtZk6zl5GQus6?=
 =?us-ascii?Q?n/skxCxagVs9c5p137QZCPIumdLw3PzikgjiTrXcclhNwJIRNqelDmWxwql5?=
 =?us-ascii?Q?6gT0qW+lxTo//ZH0LOqhatfabB0OjMw9YrjLXZyRJwkzXt+R1HR+Bvhr4AD7?=
 =?us-ascii?Q?Injp9nNRrrWDO21ZZX6e2Qx31lF8lqnSJbXGVC5WD9wdSIAOwPDN1CqDZtr/?=
 =?us-ascii?Q?ripAsnet92f5Cjh/UqhRIZD0hif79frgvVTSUsSGn19F74xK1NKvvoQHeRlf?=
 =?us-ascii?Q?/Jp9DG19L3VCcWCBXrzCVDdsLLu3EgQlxffHG0zhZtKAG6gnp/DAONcLJTfx?=
 =?us-ascii?Q?PqweD6wyT/uSiODHmbgWs/u5NgMnZX6HmI16HrIFOpo2OG6eePqj075hm31q?=
 =?us-ascii?Q?rga8EQ9YYKRPVl+OAI92CL+ICcWB8KqrXbeFz7sDDbrNdACREAIpvmSUWRv7?=
 =?us-ascii?Q?47+/WVDzP6//VkFUFMh2wb4EkFRWe2rRPhsmDVJwQBaaL8ap4XfpCDHL3Y1K?=
 =?us-ascii?Q?ZLMKJiBLDWqG0KdkX74IoFFv0aVQ5hHREr4jDU+BFZ8oywSYPPSB+LbTPhJ5?=
 =?us-ascii?Q?XoO1MndD/juGdP4AcKLrn08dqfAHeDxhWt9rsXKtfeO5yb9gahWIFsDYfFg1?=
 =?us-ascii?Q?FIYbRpXvYFj0EVudnUxS5h3hqE6oWZhznhjHTLnOUiJ4bzPf9AqQd5RG9vJL?=
 =?us-ascii?Q?9iLULOwml9JBF5+u2VxBsKhDAEtVXoB55cjyLeKQPmn5QkwTlN8wyLyv6/vT?=
 =?us-ascii?Q?yF7fH0eNsOUZUIj0SIXNxGJzJqcT0kOjYrVMh1VfuzEiwNebRYGcq1EpaiFa?=
 =?us-ascii?Q?Iiv9BQdrexYHdfX5J2tYCcaFiTf19zSI6/yzagAJ7sT0U6M9VAewKriqwDWb?=
 =?us-ascii?Q?vqoiEegpMjsnAlh1Xfrb0IrcEI2JdrD7hs8ytpy06ZHcib9EJMx/7UmyAe6Z?=
 =?us-ascii?Q?nx1YPeqKdsdMSM1qK87tE3lQBN3xKHYv2Igvm2uOjlxyfgf8FEpqtdr0urAJ?=
 =?us-ascii?Q?sL4YpgtgDPNgunJV+FXf7LFlPomwv5VzQdKjzV+R/QggKxoz+J08vODUZpro?=
 =?us-ascii?Q?uy/35qNu8UNwqFaf4cw4lm5D8VF3ERH0aBm7LmEwah013iy/yaotjYA2WQF3?=
 =?us-ascii?Q?acqyMEO6vwO5dOAQOBuoeKZBTOWPyIUPYjR+PpBjkfABEhIt6jgk7XanE5iZ?=
 =?us-ascii?Q?KzXCHZOCj7IzBK7MhdoNh4gIlJQBvXxnJVeMh6YqzEXUKaes00uKnq0y3j5g?=
 =?us-ascii?Q?tIXrqsZFjM/EessUJ6ceo+JAGytvqVqfsfGeNTC/D8CSTqRwy1kJ65aE8UT/?=
 =?us-ascii?Q?F031d9csWwXdzwt5h092/79rhntk73Mu1WsyLfE4l196AEFJNNI2x1ic1YN8?=
 =?us-ascii?Q?34AWcRYNlryYhGiXWDBCONl3h3eX3IjYps7Rn4X60Y9T6x2Dohk8/J88TlBk?=
 =?us-ascii?Q?nF39tF1owqhx7ueIpivsjYiDSduI6xGdAbblHcVkQezc6RDejilDFI3RRG0s?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c4affe7-be24-447b-43bf-08ddcb8140d7
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 13:43:35.7602 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9h7yYOl/CqmVO2R2cWFgFCxz/2TUbnnPez9QlMZbcrGFM8CgHWCZ4KqBi3JvRZg5t+7gigIUPCzhch0ZitI+GCocHTa8Xda7HVvlMogJvNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7002
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

On Fri, Jul 25, 2025 at 12:49:09PM +0000, Ciara Loftus wrote:
> In the interest of simplicity, let the primary process select the Rx
> path to be used by all processes using the given device.
> 
> The many logs which report individual Rx path selections have been
> consolidated into one single log
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  drivers/net/intel/i40e/i40e_ethdev.h |  20 +++-
>  drivers/net/intel/i40e/i40e_rxtx.c   | 168 ++++++++++++---------------
>  2 files changed, 93 insertions(+), 95 deletions(-)
> 
> diff --git a/drivers/net/intel/i40e/i40e_ethdev.h b/drivers/net/intel/i40e/i40e_ethdev.h
> index 44864292d0..308039c363 100644
> --- a/drivers/net/intel/i40e/i40e_ethdev.h
> +++ b/drivers/net/intel/i40e/i40e_ethdev.h
> @@ -1226,6 +1226,22 @@ struct i40e_vsi_vlan_pvid_info {
>  #define I40E_MBUF_CHECK_F_TX_SEGMENT     (1ULL << 2)
>  #define I40E_MBUF_CHECK_F_TX_OFFLOAD     (1ULL << 3)
>  
> +enum i40e_rx_func_type {
> +	I40E_RX_DEFAULT,
> +	I40E_RX_BULK_ALLOC,
> +	I40E_RX_SCATTERED,
> +	I40E_RX_SSE,
> +	I40E_RX_AVX2,
> +	I40E_RX_SSE_SCATTERED,
> +	I40E_RX_AVX2_SCATTERED,
> +	I40E_RX_AVX512,
> +	I40E_RX_AVX512_SCATTERED,
> +	I40E_RX_NEON,
> +	I40E_RX_NEON_SCATTERED,
> +	I40E_RX_ALTIVEC,
> +	I40E_RX_ALTIVEC_SCATTERED,
> +};
> +

As with previous patch, I'd suggest working out what the most logical order
for these elements is, and using that. Having AVX2 and SSE interleaved
seems a bit strange.

Otherwise:

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

