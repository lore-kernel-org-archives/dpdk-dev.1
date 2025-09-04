Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF96CA1013
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Sep 2025 16:54:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59EFD4278F;
	Thu,  4 Sep 2025 18:54:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 2F1C140275
 for <dev@dpdk.org>; Thu,  4 Sep 2025 18:54:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757004850; x=1788540850;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Da2JcMbZaxLEatRLTqAkIaRPlC6Kp7O+fiUptoytoR0=;
 b=ga23udtzyG3gGnayQn9aKv6wkdok2Ittza0O63JFs6UJmHLf4agfUxr/
 N+ANRe1NYgsRlTWrO6neF6FKS5QvgnAv0XtBHeqeEug2zx6hi7i0BVvE6
 JKHzI619/KOjxMYo09sdf97qB/8Wz0kpJrYay3DmzoyMg6AJyIiZAdjAU
 FOBp4ScnCegecmfvdk/UglEn7tu+yK8oBKw9y3wWe6LWx9Oq8brKRvHyg
 ZQbHKX8iLWb2JKnvhz3aUrVyVHCDGzYMBIEpgYP2xqVIHYaDbw5HOgy8D
 +qd6MpA6odFrA/p5jSO656cJwMbk6GJ0GDLo+d682ruFPdnJABkwSH01Y g==;
X-CSE-ConnectionGUID: iYGDXZAURYaTORea87J8ag==
X-CSE-MsgGUID: H4Ia/aUHSJ6bZH2yCnLTpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="46923148"
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; d="scan'208";a="46923148"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2025 09:54:09 -0700
X-CSE-ConnectionGUID: J9Nz10YjRxK6V8ROwoA8sw==
X-CSE-MsgGUID: agRIyTAGS9KkUM4nF3YVuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; d="scan'208";a="171838707"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2025 09:54:09 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 09:54:08 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 4 Sep 2025 09:54:08 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.67) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 09:54:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DTODurepEi0rionIForqiMKb97XGcdB8oOzY3Gp7+KnUecTaTcKHOgex7ormtrz31PwAjYzNZuwDsfXBNImgORPKZkoAfjrtz20Z16KJyoibFQgWFo5fOkE4tu01TQK6I1C4CKixf9W0Hvhs+OauMXJIi7mjHnLez5oj4LwDegyL8s8ATeATTVqk3aa1u2i8hPh7Q4XQ5CNf82L/qNnxGSTp7onZfy0EcslAxFHer9+TIWOn6bdQ+ANq8Mv6eFQADd9fP44yOMhXBg0AGtjYf8o46qm3naZFS3ob4a4MdTR8lsoQcLXC0JmYjR8oxSQw7HgDii8NL4BZok+6LLV6OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KrtZbtHnZ2hutHGqYu3K+49zwr0fYAx14MYdhpZO2LI=;
 b=YExUT9m5/v69cEPNUSYD+KIyTgToCi/6cF6lWpPgX6cg2Gitr4ZVjI3ISC9HBktruxp0bpqMjqHyBSGCbqaWLAs02qtpkFXg4NaKZNTBu95ajZl92FiqpKmG2ULJXRAQ7m2rfcbCXvyh+4vVMZ4aMvM81JUtuQSaDGGnSKZYW7/iilivL77AVZmjzos/7AFJKfTlJEz5JsGwRKsE46k3g/+Ah740wW2Fop2STW/Skj5sgK0S7pAWbqO3DjE30VTCETuhRZ+xaVKAQrxI0DTl68EZOYakmtyKQNlzcSvO70pZFThPvc5YadpCkTSNinNOmnW279mIhpIsDlgyasi35w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB5229.namprd11.prod.outlook.com (2603:10b6:5:39f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Thu, 4 Sep
 2025 16:54:03 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 16:54:03 +0000
Date: Thu, 4 Sep 2025 17:53:59 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 0/4] Fixes for net/intel Rx Path Selection
Message-ID: <aLnEJ46s9VIe3S67@bricha3-mobl1.ger.corp.intel.com>
References: <20250901095953.1858938-1-ciara.loftus@intel.com>
 <20250902104859.2100141-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250902104859.2100141-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DB6PR0301CA0087.eurprd03.prod.outlook.com
 (2603:10a6:6:30::34) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB5229:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dd3299f-fb4a-4b88-d2e5-08ddebd3a728
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7devVqRSYwuKOjov41UyWhFYAO32UH88PhmHYHWehv0CZFVOK6xYNeDnF7Jz?=
 =?us-ascii?Q?+eGbKWBphssER5QDPt49FH0wEGVMKZ1jxgF96QOCHtbyBzBQch1yx80v4AM6?=
 =?us-ascii?Q?+AZjZ8+G4DW56KVLwsGGsfz01BxxBxzrK6bnO8wb1aedQ1sXeUaUdCbEn7vz?=
 =?us-ascii?Q?NenBcVq3p6HcPs12fnWtj5oECG9zDFDTXVvea/vlbZmZI2bxK30YTvD4Q3lA?=
 =?us-ascii?Q?n5R4xHIVABBPWzqr7+ooHWdaz0Rz0UqwJQ6z7Bq41rvzI3qmrbch/tQeuVla?=
 =?us-ascii?Q?T0xHr5y9iwMP489w/0ZnOTeVgPzuFjm+FiD+GXMFN/NnC8oJQwdEnq8MLptE?=
 =?us-ascii?Q?1+aMwSA4uA1FgLMOXG8GrNzCWmO5ARt1JgfEkHK5z+iC6nh5vo+TSe03Jd/H?=
 =?us-ascii?Q?QGR32eKL/XwoNpZYL15fVcOLeiKXaFXbO+3MGz7xgnEzUqIcOZhTr85msgvF?=
 =?us-ascii?Q?UaxhRHf2ppF9FtkDLJMldjPObfKNdn0EMSQRDqmBoiIIluLbGtAKvTKYumBr?=
 =?us-ascii?Q?x3+QQcWGGEnn6aWPMgrqTVAAofDdAl2zavywR17NqhkQ3c6vnPGIk8kaMCxs?=
 =?us-ascii?Q?gm5OLFfyWfRerM46aqvXPo+uFmmw741iN16tAgVJXtQigZTzCcn5jRyl1+4Y?=
 =?us-ascii?Q?WwDdlfBH3N2zAArvye4dbVyQpEwibLS9ONGfAZz2WWCy7seXtKuKfWz9hmJT?=
 =?us-ascii?Q?VpSZI951QmRVEgNfSHc8UIpE/Jcr56OjupQBKrCQP82A0n5u1Zj0//PVQXWp?=
 =?us-ascii?Q?pzso1MtfOo9h4Bu4b2nKFDRIXWwT2BHkB+Qn/CaGTpFenNO1ZrGkevY9HsqY?=
 =?us-ascii?Q?rvmDWcugVNrlahguszEA98Ad30AuRHFpJsdtBWekuycMRfCvhOiFxr0s/aX5?=
 =?us-ascii?Q?Z6Ab1l1AZ5QaYe/MUtz4oCVbuzXw8w4LKix++Amc1P2wZtC2fJAKkfglKrjm?=
 =?us-ascii?Q?9GfB2VL6F++zVYwqOraviAprKO1beJiEmfcW4c8ztuQ7mP14JU8XPPZhAc1C?=
 =?us-ascii?Q?rtbZx4sdUUaPpA6rRD0iy7gO5LPWIER9J3DKaKDhCQGYp4dFsBa/Btfin6Tt?=
 =?us-ascii?Q?jZXgtmVcWADvtzXcRRVpQn+pSTJM353fRXsmPSZTu/VAqT8lCspOGBnX+dhM?=
 =?us-ascii?Q?/lep3HoZRXc3pxBFXpLpcg3V1rBQ664b4eZz5um5n+Nq71hZTadnZCeB/gpa?=
 =?us-ascii?Q?/Mop+M1TUpP3ODllw2PYfGqxCXCZAfQYnWj10YgxN4v7BQDVUjT3wznl4SRN?=
 =?us-ascii?Q?oyIdnM19LRACzIehmMfxyQ8MpRwm9DJX3OcAy0O+ibMWYf4DpdxHB4k8A/ef?=
 =?us-ascii?Q?HlAkF8cUvc0gKIyXYxxucUYdqY6MWRf9r/hs3S6Q4F/9g+iCqWj1Npg7RFYd?=
 =?us-ascii?Q?eS/Aik23VFWadApeZ9YD+8DUEyNiJaTWTcilQwgIldX13P6wf9Qf9+Nigr9R?=
 =?us-ascii?Q?w0pbPxlaTX8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R1tZC+8IwA1mNfM+8eyOhbAs/ca204d8KGQqevQPjUkH8yYgggOviooYeXcv?=
 =?us-ascii?Q?zLMwIljwOgtEV73AX5I7eBwtryqZMihS/imnXJk5DY1wrsw7+jsCd8381Khp?=
 =?us-ascii?Q?SLwwzZQt1iadjIJKWziPQPgeA3CsXgWnVQ+WxCyC7DM10GN9cEtP2F3piUN8?=
 =?us-ascii?Q?fxoiQFP8el1WGSCo8ojed2SIsaR7SPyphIoFHVV4p735X3KYlzTGt2x4LjzS?=
 =?us-ascii?Q?OFMromqDhpjurtbydwruvczQP1cXRAttzS/6MSI33s91kYm3tU3tGp5fmg20?=
 =?us-ascii?Q?/uQ2DIqQo9/vGHzX/7gI7Yj7xzwpRwbY5K73rThK4jIqGTuHVxnDE0/BTWCe?=
 =?us-ascii?Q?4AmQeb4NeCICPeCfSg1nSPLtABW3rsBCR8ssP9hsZip8CvoEs9UE2LTSJiQy?=
 =?us-ascii?Q?sIEBbc/VYbPaP0QYO04itdjnaW3CujrxWzXCWHoIVSG392MzyZqk/kOPD3yS?=
 =?us-ascii?Q?dk8wPg4xwTi4RLPHU/f3XST7j9ZNt4Xny/Ec8ddgWF2FdFU8eJA65DIFPnhX?=
 =?us-ascii?Q?y3oQq/BuIA+60I71+eFY7q6+9YOvC0tNxPCsXzjFHe2gb2Q2oVCbBzDvZme1?=
 =?us-ascii?Q?OvsNRRa0e8/3PcuanWnOH6wjzt8nm92wGs34D0TFmL0FLQq7MVGOC/SxkG/C?=
 =?us-ascii?Q?Enfr9Ptn3q55wgd0wd+ds/ndcBw00bi5Vw6VK88c0mYGRMtJVBwci/zXDjk3?=
 =?us-ascii?Q?IMVLy4/wA5qAFGDtxM7Y2yhCGaTvGwlZYWhE0T0O0FWTph6viecnf+PHxdNs?=
 =?us-ascii?Q?uv7u0pOQxvenJ9NasfXssR37ZddlRc+ASgay5t9CcLCR5kkn+d4Be+C8+s+I?=
 =?us-ascii?Q?1fUYdjGp1qyu7uljN5TUxZEvXO0fRIdsDBFlrVUuw/PoO6o6Fit2muZVqqa/?=
 =?us-ascii?Q?tJP4a+A+N2eI+cCcmT3YA7hwNrf0cjUkztX9WCjLCkRY+WTtLsQRommTcjNa?=
 =?us-ascii?Q?lcIHSIUr8ShLT4XgTkkB7grl5DKRk+xO/8JQidNzHg1EH9qQxJPRFlnifYEV?=
 =?us-ascii?Q?QM8VtY3ZSyiEEyqJtFG2tF0s4YQb1V+8Zrvoy3kfwpMS9gjZL1sFwqoT1wvL?=
 =?us-ascii?Q?zRhlxWyXnfSnQne6/puG0SfQ07t0rfcNWZ47mTWWvYn/6PejQNjNPONGx8zw?=
 =?us-ascii?Q?I1x/CcxA97TBq52HfR4xh3Qg/aVijLn3R0Lh/4kRuiZS7adQr3p9hQc5L0dm?=
 =?us-ascii?Q?ICaYjHhFprnReDqltg02w33hviIH6MZOmfnRtjXrCUdt/tgfappkwCdTA1//?=
 =?us-ascii?Q?z17qupt4RBh70P9f+lFz+nA+k5o8slCznB6kdBe4RPXfiHAsEGXROI4UV0ac?=
 =?us-ascii?Q?sCkS9g2dkQpwYA2PpJWX9DG+jupkOr9sEkVjzGM4J54zVc0/dQwvj7K1Vk2o?=
 =?us-ascii?Q?uozxBlrKO1CMpVU3agx8k/H0guGnnv9nsm16ViY2BFaIGLeFyZc1BsCNI0zc?=
 =?us-ascii?Q?j1Zbea2CkECSKiocT/s01mA+PZHnSGX0jNnFyy22afs8dfEWmJNpR4CiHgiT?=
 =?us-ascii?Q?geXEkdeh9IWxlB5MDK8e7RaIWxmAaN3CJ6j11kxjuXgdEE3pMsEVL9vUbtLC?=
 =?us-ascii?Q?HHSlxLPN3/mScUx1XfEVzX/0ejXOWl3yzQ4R40QgtWiIDx1LuYvEULkGAsoZ?=
 =?us-ascii?Q?5g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd3299f-fb4a-4b88-d2e5-08ddebd3a728
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 16:54:03.3600 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e0Un/hDMfvxn1rGTemmOd/4Ng8A2ZW/+uE0sRQ0VZsLFg0bA+8ngQicvZduZkywXyoHd0OgDzOunvvzAmXG/1FBh11cAG5gDizB+eN7tFFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5229
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

On Tue, Sep 02, 2025 at 10:48:55AM +0000, Ciara Loftus wrote:
> This series contains fixes for the code surrounding Rx path selection
> in the i40e and iavf drivers. It is mostly the removal of redundant
> and duplicate code. The target is the next-net-intel tree.
> 
> Ciara Loftus (4):
>   net/i40e: fix supported offloads for Rx vector path
>   net/i40e: fix vector Rx queue set up logic
>   net/i40e: remove redundant vector Rx queue setup code
>   net/iavf: remove duplicate in scalar offload list
> 
>  drivers/net/intel/i40e/i40e_rxtx.c            | 40 ++-----------------
>  drivers/net/intel/i40e/i40e_rxtx.h            | 11 ++++-
>  drivers/net/intel/i40e/i40e_rxtx_vec_common.h |  6 ---
>  drivers/net/intel/iavf/iavf_rxtx.h            |  1 -
>  4 files changed, 14 insertions(+), 44 deletions(-)
> 
> -- 
Series applied, and squashed where appropriate, into next-net-intel.

Thanks,
/Bruce
