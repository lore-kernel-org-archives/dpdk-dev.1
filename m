Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD892CCFA04
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 11:41:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C8684028C;
	Tue,  4 Nov 2025 12:41:22 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 896D340285;
 Tue,  4 Nov 2025 12:41:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762256480; x=1793792480;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=NuSzSOE/pziuis38h6R/xbdcivl8K+bJV3vT9CImSVc=;
 b=RNAzdZ5t3LRcBSDiTePiPCNttoWVZx/niOrDvIGBTNS1ybtE06sE4tdi
 QbcZWZk3DFPcV9JFyh/C69yz9M4uxncFYF07MIlWFhe4GhIzmDG4io+f0
 UD5UXrUlKyjhvgUpRkGYAaNEfnXQjY1rJpsoHf+l1bVrUvVE2ksRF+CZ7
 Y4IsZfSJXjpdM8a9ylHeEA+ND2/zKt4bL+fv+UqC87hwm7d1bTu4155Ir
 i8NJD/W7IplGKhpTmrOYWTgr/LFraMu0Csy2L2eipWb+nlW6fi3owM8Ra
 6E8JTxiwuHRKTQlHTQDyYDNNOxVXGAzxU1USZUo6HY+R1qxGHA3Z27air w==;
X-CSE-ConnectionGUID: gR/DVT/CTW2sV2JKI8Dg7g==
X-CSE-MsgGUID: /PXx0uniRiqxD+vACdtxwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="74640588"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; d="scan'208";a="74640588"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2025 03:41:18 -0800
X-CSE-ConnectionGUID: ioIP7h3tQbSpNeK9Ek3Zfw==
X-CSE-MsgGUID: ICxxf5elQl2M/J/68F04zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; d="scan'208";a="217780272"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2025 03:41:18 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 03:41:18 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 4 Nov 2025 03:41:18 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.47) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 03:41:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUXjKM8R4BhYM+p15dkMHJPHiRN96eAoLrIiGZmSabD17SewiNVm53wA32bsF/tgBGtrs9lCqoz8lcfiDiLlXZKeFBBwiHXMe1eDwgsSKDaavsUZS9rPpn8RbVMbD+NbjGixZjp68HKavZ/IZkyVTwbbo60Oy6YjcFBWrMBgXKW3gbJhOFvfCWuqPQwPrxV3kzezkMMWougLEckebDiUhPSo9OWJljyLGE8wJ/EecZh/+KdWHhfQdyoRbw0J6SCGYLklyvKNOChF8yIjAWjeA6dEeSdnviEr6PLmNRfRB1Edfr6/nvhmMvt58aBZgu8151qbcHgc9lkeVRIUjeFntA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVP4TvZcbDLOoRhkVe50fkAu3HsfDCEZs6m5arsj0Yg=;
 b=W9c0tR+5Y9Xzghor14VV0g5tgoafFj5EbeYmdkf6dxSYkFS94YXZaqEs7SXrF7VnTaOm+runiwq+X/GENL3sldlQWLLffvxlWYKzq8mTzMd37dDSSo0W9tLFKqzhMHOyORQXb9+ne3xjTiw+4dq4T+P/r1HKtrovuI3lPAABdxWJGFJggRVqCaaB30oM/CVi4VI2M2T3wFIwHVoEdy+26vFdNUeYyoyEnK5rXpB1j01TisRAVMw/smrwrLkUIO7EV6q2YFuIP4Ew9rhDUMijm2I20NnH9WPnc/zKUdyU0j6NhKuDEK70NOoaGCerdz+Ru0f9fnEOt4VKW8QX2LJYHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB8861.namprd11.prod.outlook.com (2603:10b6:208:59a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 11:41:16 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 11:41:16 +0000
Date: Tue, 4 Nov 2025 11:41:11 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Soumyadeep Hore <soumyadeep.hore@intel.com>
CC: <dev@dpdk.org>, <rajesh3.kumar@intel.com>, <aman.deep.singh@intel.com>,
 <manoj.kumar.subbarao@intel.com>, <ciara.loftus@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH v2 3/3] doc: update TxPP documentation
Message-ID: <aQnmV9s7VRfOtyQ-@bricha3-mobl1.ger.corp.intel.com>
References: <20251027182801.191295-1-soumyadeep.hore@intel.com>
 <20251030173304.260209-1-soumyadeep.hore@intel.com>
 <20251030173304.260209-4-soumyadeep.hore@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251030173304.260209-4-soumyadeep.hore@intel.com>
X-ClientProxiedBy: DB8P191CA0016.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::26) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB8861:EE_
X-MS-Office365-Filtering-Correlation-Id: 5150174c-d5ef-45ca-cf7d-08de1b971029
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4iLQrLpOvSyOCj4fCQgTll0hqEWTdkgGuK+eTHeEJEU7C2BZh3zt8ah14q4N?=
 =?us-ascii?Q?Z6ky1xBEI3E+IqJSXLDQqUG6OwIe5cZN+Gijk416TIjqXUsgMYFfoJItDzSN?=
 =?us-ascii?Q?TyXcEkTtUxLD+Na1QckikqqCP4tsrFtfGLXqzD6pDsldJKRYzGLMBLHiZ1tv?=
 =?us-ascii?Q?t0DxypOz4qlJeMdp5zLuFgfMJK2eFnm/oUg/cHBqVczhLFOxRvA5HpBZLkgm?=
 =?us-ascii?Q?+P/UEz4hNnEmKGXEvzRcPTBNVTjbG8Q09VzAzdxUdSnC/0zSZIr5inndkP7L?=
 =?us-ascii?Q?1HUXw+T1jXWYTmlv2pG4TYBZh+7QKHrPBF4yH9+MMdONrXqZDkoqaAumBQz6?=
 =?us-ascii?Q?JXH0APP+vtxpp/dnqHvgtCW9O6WxhCW2peUulUipcPs2vwPPg7SxSTd8ZCWl?=
 =?us-ascii?Q?vEKrK4vQZG7745rHkTNiliiXVej6l6IMrm4xF8PCiJIhFGWT+3mL7uGuCxvS?=
 =?us-ascii?Q?k9sOpgS4fKB18/xjn9YJyrBsdLwVWs+HBW+P7NP7YdBC5f2e52ohTrddpMP8?=
 =?us-ascii?Q?r+iHz12a5K/ExUAwwR0bWm5tWmbbACtjLvwpZTEtDvWnvt2Gj7wY4GeAkgaa?=
 =?us-ascii?Q?wf5dzbbVwhpIefrEOtIZvo1ohglLP0pJLx9VNO23jTz93xFnnVKKzGaBVTNC?=
 =?us-ascii?Q?x7ZxmPXRU7rT+o/zfN6dB0tMtM5TCxG7NMMO3mG2rztLUuIuXgu7cLvQfZFC?=
 =?us-ascii?Q?mZ6feIYZUhMPf8HaHIQXu+Z9rPhsCI7G7bZNb/LCIRG9g0F0ngJ3Peq/YSBV?=
 =?us-ascii?Q?Ddt2tzCYdihs0hSxZHGBg6nYODLahR0nYE5SZH0gYTUnrt52EPf/vd9eyksj?=
 =?us-ascii?Q?Ecz10PTl5ieF6zUaM0dmvBxtDVacClgkb+6cYjdEAA0snsdLtC3ZGqLcFWM9?=
 =?us-ascii?Q?G8Q0Ht+FzMYVJQ2bzJQYIaIXm+u4s0e6KrEc0PlLHxrvmLAfn0NLd9DXBAAV?=
 =?us-ascii?Q?n6q83+/0ntgSnGuA3Ec/X2JzBhpD5KSssZCspPZsmvUDDSqNppKW7dZQS9Wv?=
 =?us-ascii?Q?NZc7pdn1/ljHoWnHT7UFyvgcT01fiae9mlBsMh4XWDasvBPIcsCfzzBvA4xY?=
 =?us-ascii?Q?o5mq7YfoorDlGxY80JUJMj5DNvZWCvB/Soa77KhQbx3S+ySNh1SiWs0wBkTQ?=
 =?us-ascii?Q?tcuBAkPa0X9MHiDGQ4WT/+w3UZylHcwGNWsigKZL9YJJYQq07vnKJkn8yK6b?=
 =?us-ascii?Q?SrdT+iwHlghEOj9FUIBABGXwLjkUNdeMZFe2qXQllSZgjDDiL8ZrnrH8pRIF?=
 =?us-ascii?Q?WLMpG8iHBEuXxBZj+SB94D0ZGWV4K8vptcMHx0CDV3SKE2rZLsIO8OvM1/4w?=
 =?us-ascii?Q?aqcdqvE3+ycmpgwPdkLY/XA9gpQmcvAHYjabC5p/eq/3LsR4TKPNmQg/Px0b?=
 =?us-ascii?Q?ahdmvXYLvwgFsezio1K/uCAetwKlWlBlkA28psdUAMuNMLBi1f/Pnd9BbPIv?=
 =?us-ascii?Q?AFHEpAHqsg/cliZ2nI4gF83NHLXnHKH7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z7xEGu/fvT+bp0TB1WpU0D0ewfJAsmu4kZtii/5x3zxmgyRRGWImoFz40E7w?=
 =?us-ascii?Q?B09oDH3iYwhzIFjxQhFalDXARH2eU1XrsuG7294m5xNOMlPhRRDX/I1sjv2S?=
 =?us-ascii?Q?udSwwtUDAUuka/Oto7IQy7sztGnZ+R9XGFRhypXN3VTHttCo4Yzi8pQQi8cb?=
 =?us-ascii?Q?+HrUCJACE41EtENWlqGJ+yqSBMep1a9np/t6Qjc6QyMIbOkrPzwDyqpRlAbS?=
 =?us-ascii?Q?MiTU9jXNQGSiZ9gFguUxgx3RYr/uQDs/As1xt2AzGfnTwrwJ9aIL85VTmwke?=
 =?us-ascii?Q?7yRucFAFo3qTRHqG/vRYcPfrdy+pb6gcjuh4YBIQHgLhukCpCtk/nu4vy78h?=
 =?us-ascii?Q?TFoSGl0u6G1+Zc7ni321+xSvF74Gg6hiXaqpDTHTqVFPOC3rLo31lDV195c6?=
 =?us-ascii?Q?Q5HFp2kY2ocJuLSLADPUTLELo/LWGneSa9dwSN9wRvAPvIyvOZsczEMF+m0/?=
 =?us-ascii?Q?Ikj/gZUVwA8Ng5Bty96zx8TSdpFWTFG0Z4Iva81T7LHIPeN5TJ2Y04iUyNnM?=
 =?us-ascii?Q?Ywhnq/epjghHSRFSrkQJaPj2Q52+lTwioPp7rGorK5xsk0ww49JKGQz6m+eH?=
 =?us-ascii?Q?hLjIPgDtTqi8F/QfYRPFOkySrPAjhBUhbknQ36/XdcRVipfMdnX4fLT+0VHA?=
 =?us-ascii?Q?/T2lOeN8SkwpYXIiPHBA3hRgwtxhO1D4Not6PCInnEZUlTfM3tiIPEjZI9/d?=
 =?us-ascii?Q?8rY82lt4qHbxz2kECEqoAjMqc6sVBzJH4X6WeMF4ELomY6V4Ui1G5oFbXElh?=
 =?us-ascii?Q?q9eFej1PtID9eompU9LqFCN2P0JXw5OAJoKYM2SUVsYMQblPQzXs2/HKOKD5?=
 =?us-ascii?Q?i3d6JtMAWkoLB27Ft1ecPuXNkHE4KbPZIhIr0G0/ZRhok5jmuJTN1SaRggW7?=
 =?us-ascii?Q?OsRQM3cmwou+B26/Y9DySYxncpoksnNUZFKO5SeouWj/fpa59TKjXvlVkYw8?=
 =?us-ascii?Q?1h89nMSbQF/IwVyY4z+v+nRmcrKX7Mm2zyl3/D+RemX9eeRzN1ot/Q7DetaJ?=
 =?us-ascii?Q?cAGrNxJZGRuoA3FJyvilIhUUoxYtVGVX8jmJbWoC3qX1thfF7Cb7qdGot/4N?=
 =?us-ascii?Q?zzLqFHOVG/NrkEkBkvjAsSnuHSYdAEBlXkF8U1QuZTaNScGvrQ/zzoDc4N0c?=
 =?us-ascii?Q?AwOkP2nDh+5D3znfhduZ6bnekgXxbR6veAVpw/R5gSk+LaXwITYh9enpVlFf?=
 =?us-ascii?Q?COs9ba4dl7aiPrE89/e9uEA3S33vFxm9SMS2EKCpo4PMRku8fX5px0LnMRWo?=
 =?us-ascii?Q?znMjZAg/lK2QyTemgg7UBhWOsIAkLnyYUTCbYPmGlpgEXLu5/3RxoGibnDBx?=
 =?us-ascii?Q?nmzN8AwBcizdm4s5pndYIGCq3HF6mIyraVfFTJGU2M/FSkIRTkTeD9SHgbst?=
 =?us-ascii?Q?zljEQICBi0qJrjbv1yz3mHBABEwrBJLGF73tGtIC7ZG1zx+Dfa/QxLDjmtDm?=
 =?us-ascii?Q?qPDvFa3J2ZnJbtdzDsOorBxpp2AIc1axnMBjEijlEpXe6pIpoOrOU5IMwOmk?=
 =?us-ascii?Q?Z2Yhux3c8n8il6XQev4wcQUOHhOoIpz5q8bqI3JltqtIV3Msswv0FN3WdiM7?=
 =?us-ascii?Q?lwkgL3MWheLaWicC9rSJnR5hVN3OKHZLrZ/6PhkeHO7L5cdA1u0YhtBpatCf?=
 =?us-ascii?Q?XA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5150174c-d5ef-45ca-cf7d-08de1b971029
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 11:41:16.0288 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RkfrmuFrKE6YvZjEw5dVH9WUto+oIuyzzD7BxWHDjzg/LGqPX3zpKBrLHX98Sk65lxyn5T2tsyD4J4+HwMo6cJ5zPw3VHtVlxlfnsBfrjYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8861
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

On Thu, Oct 30, 2025 at 01:33:04PM -0400, Soumyadeep Hore wrote:
> TxPP feature works only when DPDK library is compiled with
> PTP feature enabled and application is run on PF.
> 
> Fixes: 0b6ff09a1f19 ("net/intel: support Tx packet pacing for E830")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

