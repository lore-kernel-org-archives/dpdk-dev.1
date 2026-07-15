Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C93CC44501
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Jul 2026 08:03:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5BC4840290;
	Wed, 15 Jul 2026 10:03:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 62BAA4028B
 for <dev@dpdk.org>; Wed, 15 Jul 2026 10:03:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784102616; x=1815638616;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=6ltOl13jodbCu3nnsxo3nqa5cTXIk7g0YMTUMKRDIWQ=;
 b=MdrCz4JG31C84WlotewoKTctOtazdrBOgAtog3SMdpGtxNt2A9PMfApL
 3OcWkE06LEbAL3x1NJVDb5IGlKMoIdtiMXa+4jQjxug+HA0nswU2LYMBm
 tWe/xaSqnax51cjS1GTfHTQ+5QMj+h/XGkQV2liqIjXdTQj2R9t8QGl5f
 fTHiH/aNAypqelrbxJ5uR3KdKRsS+0sQpxWg9RNAd6n0QTK8OMS0TjOCC
 eKjJufEieqr0GHSPumbRgubWDenAGDiHpBHcRm/FyWd3ElzT8f6xGhPGS
 Teq5CygCe4RQFClcDNxLzt9umiAe16c6RQlhiAh0Pp2h+miukV4VW5sOz g==;
X-CSE-ConnectionGUID: m/Y2Z39GRoy4hJCaXAT9YQ==
X-CSE-MsgGUID: zE2v10ufQRysIhmqdfzstA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="96100083"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; d="scan'208";a="96100083"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2026 01:03:35 -0700
X-CSE-ConnectionGUID: NUfFC4ytQ5yC1pK3LKx2Yg==
X-CSE-MsgGUID: zehcJG7eTU+jK09ebYBQvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; d="scan'208";a="251699218"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2026 01:03:35 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 01:03:34 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 15 Jul 2026 01:03:34 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.22) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 01:03:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cHYdLfi6gWdJ3kGTc2rwn6n7vqMRox1l+mHPRQiSraBjQrelYohonuwOmEyBtJ2wIOYSBa5/S/Vslyx1XZC3v/EWFFaf9HmtSqkWatKFmYSMANtm11S5PA31rEMg0jtpAmJQkK6DA6wzPubq5DsfcZtV5kDFBcwCNRMr58avzAfbyoR/aPKQx8XS8oQy2Te8sdLiJFfYijD2MQo2D4C+BllBNMHqmRKy7G2WlA7rH9uFqOevQ5JLC2KioZCJAg/Ixk4GuHD8rOe1VP1RIndARq5LToFBCPem7LyuIRdpMLYd61eBE7YSbl1WTONbDbxJe9QkKgvpbWcnTCmwIvDTGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1EcJItIwBZo1Cl2Oj7LtQLyn2M2jgJyRef7tXQR+YDw=;
 b=XWfbGU/Rp0DhYH/FzEn4REjPLhRzgrofxyuNiqe/7RqARLWF5dxvTXvN6Xf0a8/H49V/oHV7SDAnhLOPABYwwSP/xEe/DH+yASuvWxaH/pex1O9QsYzFy8ma3m/LyCv/BWyrUX8iikS3zFbIuk7XsxUom8e/gbnGsw7pVznehsC6GeJhkpcSGbh3dQ4yY1HEBXBpxGbKQwJEnGq8KIkiNWCTXb9F8VFCYd1PYA0/BqkO23xmd0qyRf61ha1tganKjVIcKtUvKFVJCv8vluP1YQmWI/4mCCM0j34xtT829gUlVJRNqz60jwemerhRXQ/R9ltqKYcK/u088oOtMf3tQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ5PPFED9C9AC99.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::85d) by SN7PR11MB7976.namprd11.prod.outlook.com
 (2603:10b6:806:2ec::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Wed, 15 Jul
 2026 08:03:25 +0000
Received: from SJ5PPFED9C9AC99.namprd11.prod.outlook.com
 ([fe80::a6e3:dc11:48e:b2e0]) by SJ5PPFED9C9AC99.namprd11.prod.outlook.com
 ([fe80::a6e3:dc11:48e:b2e0%7]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 08:03:25 +0000
Date: Wed, 15 Jul 2026 09:03:19 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
CC: <dev@dpdk.org>, <fengchengwen@huawei.com>, Kevin Laatz
 <kevin.laatz@intel.com>, <selwin.sebastian@amd.com>,
 <bhagyada.modali@amd.com>, David Marchand <david.marchand@redhat.com>,
 "Thomas Monjalon" <thomas@monjalon.net>
Subject: Re: [PATCH v2] dmadev: clarify last_idx documentation for completion
 APIs
Message-ID: <alc-x_frNIfPSgLw@bricha3-mobl1.ger.corp.intel.com>
References: <20260715060630.3450172-1-raghavendra.ningoji@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260715060630.3450172-1-raghavendra.ningoji@amd.com>
X-ClientProxiedBy: DU6P191CA0015.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::16) To SJ5PPFED9C9AC99.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::85d)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPFED9C9AC99:EE_|SN7PR11MB7976:EE_
X-MS-Office365-Filtering-Correlation-Id: 910d7ae7-f94b-4fb6-5677-08dee2478c0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|56012099006|3023799007|18002099003|22082099003|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: WUOB6sBw5+bWh+wrfc4ckb9jcLQLS2ZP4t1Jz3PuYDV4bbQb0KANlWZZAt5ABwB8hIkI1FnoIQ2GZ7s6ff0kl15fWAKxTHUhIqYqNLSM85dx18oDO0TpZqi7zUQgVb2KzUs5DrTFmCQnaMfztTQLpNTl48K8MmmnSvCeUD2Vz4GfUdR50JVnT1HNjcHNHrtmE0khCrd04zPkLUjJPWYvdewNiAt3qE1EizXcdH9Qnvr6N5Ukm3cvyDIriEc7rY+uFS6KDHMgxLKm+SH2ZwMt5rNeO4iEcJ64ZnS4RtXG4n5WbzeBt3ODvhTGj7AOVIygF5tgZ7yePrL12r7H443pQ1Gn1kYmhAnY4K51hFs9l6nFGuNI4YPgBZ4XXGFNl5Y0n12FXx/D1WHXX9yuIlKI7LcBYprFPbTiJpz38yhel/vanQegpqw9TwTmR95mXkaFTghqAopsfRl1m1YxGKtjMknjGlTXOXOJ4U+09xkSQ2qOrPOfE2Si4pT1PjK5kKxIp/JI3AUUYewmVbj2r6R30Ez8e3TUVnY7+sT42yHrOAg41qbxR3jcO7KyIi4p2TR7shcFIr0I/wEttdtAdtfAAbptHW0mKlE4EG3MgCjKi2AWRfW8QBU2ZUBw8wGwdbVQHWSOekoaKdmIUVCRPCYpX8x6y7H9RFWd3sZwYaBEYeU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ5PPFED9C9AC99.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(56012099006)(3023799007)(18002099003)(22082099003)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NTKVTu5IAEEx5Si9JlkaRVxUuca/cM721xexJjNzOFaTvs0MUAfZh7S3sqTa?=
 =?us-ascii?Q?F5XxVOA2FSbAUWjmCK2QlsYUEMfUvjB49mKy4aE0Fa4dBgHtnhlPl7rOKQXY?=
 =?us-ascii?Q?JBWWxL6M6G8elU0sW8FQvgtSJ0UpKu2zup07cRviV6qKENwsWvmLnoPeEVUN?=
 =?us-ascii?Q?0TWPg9HT0lVi1LLA8y2+8MkjHsw7cYYoo8hJ7gh6XOGaLs4NTA4t7neVzeCg?=
 =?us-ascii?Q?kTEYgp8cfU+W+SHcHw9lfTq4dvyqrpn5AWgfKkh0s3ie864F72Yy59Pv0Wrv?=
 =?us-ascii?Q?/SplTSXLBPE9/RxGMg4G+QWALLpsdICgcrFAF4mRSm+gQPTb+W7/NJMQt1uO?=
 =?us-ascii?Q?RT35ZRxBiWQ7knhFI634VPv6TFU+mvm8pPKzd8Cmn5EzEMSWQFCoK1ui08MM?=
 =?us-ascii?Q?tWl+qmbKeP/jeBdOVJ7bN+7vXwOtyXqi3S8anbbnb4jBAFcDghbUnaPuvgNP?=
 =?us-ascii?Q?Imc5iIyIv6wZD0BdypC5HiByHsO2RUV6989AbfJffm6oTVZsoO5JvosrcsUX?=
 =?us-ascii?Q?UeXIcICFfBOfi6x+2DfSF2mdQFBn6Dkh3T4WVUDEnCBaJrgwgrTw9XUFQ1kv?=
 =?us-ascii?Q?uzPUn8lK2xo1fKexGABtziqCRgV+UuVSPW0dLrM/Gxx4XRO2unJmi9OdE5yc?=
 =?us-ascii?Q?MWtMiXvEBx42sS31uHn1FW9w0eRXQofTYgi41+k8SM0OLLDPUc1eaf16fzBq?=
 =?us-ascii?Q?yPdgBCu0Yk3iUTJLHaFZRlHkiVUSo7SSpWmQZvAh/+6bCUIsvLvSzmJoHqjM?=
 =?us-ascii?Q?Bc2c64f8jRlNRUx+BkatDx8LMtScONc7YmF+M1+FYjAUGZKDRjJ3AiN/HJOs?=
 =?us-ascii?Q?6z0/F8DBG+to+5AlHWK19mvKJqTHPOgdVTqNMMUIH9Xqx+SWN0alpjBcqTLs?=
 =?us-ascii?Q?I4JP3wuyg/722Bo0oYo96aiOVlHMEX5vkcI6LLxY0Ghb7QaIDBNntMdT1SuB?=
 =?us-ascii?Q?PjwDpOpr+UmrkTkZqEcurpKyCWZq2HFAN3UVuJdZ8Fz7HRBqgUTTi8MB3MnG?=
 =?us-ascii?Q?AHogcNHHAw8MGg2z5URCfWLK4URfUHKPnuJTQLxMck5p1U8gzi9vEF3shVNl?=
 =?us-ascii?Q?wlu0RWo3bnHrOK/gdZUf8xVsSOlT/3fGb7F+l8t2msq00coxkHpWy6vNzlTr?=
 =?us-ascii?Q?KBCM059iEf5bs6pWSGQyswEp81IaTuk82GxV7f2KpFBmm9hcP9mSkzmX7mUH?=
 =?us-ascii?Q?q5b6WzLu4m4Ny8dCalMGvCZJD/uM5YxqjSKXnGSY+O3izvlSxc24ikUiTq36?=
 =?us-ascii?Q?tsiiiw+WTsfealuNuH+usGgEcQZ1pIorwXn1t7iCBMzuNFt0siecQ3ExK8dY?=
 =?us-ascii?Q?D4maM9SrCuczjZ9YWcJjjbCpQ7+lsGZmlRVUw8Ir6v8ac13G651ICyMe/Ehb?=
 =?us-ascii?Q?s48vZuOg2KECGV9/BhK0XEwdqKsnb76jhNOXwfA2dLe2a7ZueO/XfSzelB+Z?=
 =?us-ascii?Q?chbwNFEPT29qxaw9Kg8SnwCYnxj8CNJLil6Ya7JUl9O5Sg/5anLcW59tAXGi?=
 =?us-ascii?Q?J+ez1n2cHVl1IkLW01uRG9UVYlqnxt3irJCov1hHAg/90XNoJYS0ATQ4PmA6?=
 =?us-ascii?Q?5O7/32HtsO60i0LFK9Ys5rY0GVAPrqgrzlXp3S97xnmCR63LjMiZdkqyq8pW?=
 =?us-ascii?Q?V2pb+r8WVODbDNNs5MCXa9xKGqERvD+GuZ/DDvKge4E7cfcbCkTbSGdmFZwo?=
 =?us-ascii?Q?1n+hd1ytNY1je8nFrTqRRvgHYXsXPxDH34OoUbMNh45ROhqOhUCdiuB0ZJGq?=
 =?us-ascii?Q?XXgSttO5Fmw62ellr97Ytf7FlO8b8Lo=3D?=
X-Exchange-RoutingPolicyChecked: FL5bdvoStwSL2xi+WQRFG6im2OyksWYcOZ1CS15DCW0EMTYIKjTbxXfezQJ8Kr2+ApVBIyPTw3Gg/tnZZSeFE1/GCC4Lz5hpHlHlkEj/9DExEqJOaJyvSzTSw/fzWOvy0wax87w9nebIHY/A5qN9x99cxb4HucmUeSUBdt4Dpks1Rqv29fZZh1qd33H5skzP3yUOItCcr/jnsXYONeEYNe78HipM620hwEhPj2UT39ZCSll0uh6NdJDnSh4NQxqoz0Fu2rzl+/hdQa3Wo2UNI6F5AkNScmsMlSiQok8+SJPGy8pZUWDqCcu8OFtc+yhiD6EarC3dOxMQh2ynFT6dUA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 910d7ae7-f94b-4fb6-5677-08dee2478c0d
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPFED9C9AC99.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 08:03:25.6654 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c/L5G/4y2RNYgPvH8jBaORpZQ5TVBFyDDZB5i8h/2hlKcewurBrKBsyUz5yKXKuc9AXnAVTYPdqb8KVEqCwAeuvBhbB/VdQgWbaEfIyQrwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7976
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

On Wed, Jul 15, 2026 at 11:36:30AM +0530, Raghavendra Ningoji wrote:
> The last_idx output parameter was documented identically for
> rte_dma_completed() and rte_dma_completed_status(), even though the two
> APIs have different semantics:
> 
> - rte_dma_completed() only reports operations that completed
>   successfully and stops at the first error, so its last_idx is the
>   ring_idx of the last successfully completed operation.
> - rte_dma_completed_status() reports all completed operations regardless
>   of status, so its last_idx is the last completed operation's ring_idx
>   irrespective of success or failure.
> 
> In both cases only up to nb_cpls operations are reported per call, so
> last_idx is the ring_idx of the last reported operation, which may not
> be the last operation the device has actually completed.
> 
> Clarify both descriptions to remove the ambiguity.
> 
> Fixes: 91e581e5c924 ("dmadev: add data plane API")
> 
> Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
> ---
> v2:
>  - Clarify (per Bruce Richardson) that last_idx is the ring_idx of the
>    last operation reported by the call, bounded by nb_cpls, which may not
>    be the last operation the device has actually completed.
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

