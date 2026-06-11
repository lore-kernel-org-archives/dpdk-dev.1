Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A836CD98D2
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 09:46:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D3A042F91;
	Thu, 11 Jun 2026 11:46:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id E874A42FBF;
 Thu, 11 Jun 2026 11:46:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781171197; x=1812707197;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Rr0c8FlsjA5LwLKkPlXe8YMoIkpWqZIPzAW+K0qWeZw=;
 b=EzLS6ouV7/PWOxMbfqQ/dmLtriv9HErSityQiAymfQ+jq9zNQgGiEJ3v
 4N8YAj4x9Ci9I5YR1SN2yEJUxUZwMttNZCPrmAs5RxRgq+XLoJhKKgIcQ
 kCFDeY3+kPliKEGEBPrz+xBOqDytjSQI1GGDTjblfZ//2IkhBsm/Mu0mj
 vZDYIo9oLCdlDCmG+MKHAMRybnz6hz3qEWXvhid9w2hi2kyh1yUy2Ggce
 yLoPJD/j8oHBVtY5bPXAunJ1xlEdfYjB1gmtoaC4Ey4FP2XYSKi3QO5tL
 29T5h31sQPW7r6trPBVuoefs2cFfRraPAJnxpy1r2tXPngQD93NUMDkVB g==;
X-CSE-ConnectionGUID: EfbZjMHHTViYqNaZpoLM9A==
X-CSE-MsgGUID: ObvP5p94TTGqasv1OPnO1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="80996309"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; d="scan'208";a="80996309"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2026 02:46:36 -0700
X-CSE-ConnectionGUID: bpHpU+vCSseKPrGMkg1aeQ==
X-CSE-MsgGUID: xTurCLStT2S1nyP4hpvc8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; d="scan'208";a="243992882"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2026 02:46:36 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 02:46:35 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 11 Jun 2026 02:46:35 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.63) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 02:46:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IBaxBDNjVEiXLAvO7rc84J8LU+oF1rv4PxWyBwBM6fPypbuHOxefG+lVaVs7HSQsFfq3n27+b5dcOlbN2ek6EGXKZpNcIFef72WHwaJSxbYwyXdTeuX9xMJ5wd5oi+389TVGoclJDi+D4MEeVc13dTRCFkotZMdZDMoRr9+wXkEGI5SLIh4H+iHqUS0C0RUe4Be1b1suo6q6uuQpAZW6tBBUcGgF3O/Ww9/ZfMQNZcnIDof4axwIaQubAhUYamHSy+Gq8JnA90Zf66XO1+srKmeyc/uRxlKF9llIcDM660VpI3Nc/V8ngafY0cNuGWUMEecmw7v53GvcemYSPpA79A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KpwoNdlUTRN5dugDalktQq5kxoULudxMX5vpFj7n+uM=;
 b=g969Ua84ZMe4h3FamalrRu94PH5ZnMH7uuoyYtfMt1uZjbePhLbRaxh2NUcTIZUVrrUxkMlsut4FzUbHikqjPt1XAmI54wK3Nob59MaFaM8fuAgRNb7rz60nMTzQyDdbygaU1moMg8WBsiWLofOUb0P894QXPfGRQJ64G94zhBdL8dULTIpPejuoZ/Y6oZTpEWbEY4ixip56uLdF74ksuQbKB2WFBkkxQ2a7dBVnY9xujqT50eBz0a10YsxvaxAh7fAJPLUSNmiMp3QoEMdNg1LcuilzZllEv6T0HVPNvqzEmf3mp6gASDV5hroKruD7a2Ofv15YR4mg/6loVn6CAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB5924.namprd11.prod.outlook.com (2603:10b6:806:23b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Thu, 11 Jun
 2026 09:46:32 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0092.016; Thu, 11 Jun 2026
 09:46:32 +0000
Date: Thu, 11 Jun 2026 10:46:27 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] net/iavf: reject oversized frames in prep callback
Message-ID: <aiqD813Iiaat_ZtS@bricha3-mobl1.ger.corp.intel.com>
References: <20260609140317.1901278-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260609140317.1901278-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DU2PR04CA0339.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB5924:EE_
X-MS-Office365-Filtering-Correlation-Id: e0dddbe7-d4f3-4d16-9b4b-08dec79e5185
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|6133799003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: P/4L53tasFIS+ygSlU19IUmQwVWcmKCyuCrbNeZKZj/64IHaO/imAfDXZZIckaf46gxrx4rSdaBQn9hfTtMRNV0z02RYX94732wDKK/gdvMJEPSo9LIR5IVj6Za6vp3ByP6RsevFFPqefSc2E2FEt4wBXGPgijWHsYeD0eQkqq6ZlYU+nUGRm8PeV1txxkirmwzfgORhaB8OLd4eoYKiMuofzUoV3x9XmI4I0JdWQ1nNwq9Pt7mPGCqIUllpSL2BINlRME5nKmKQdwYDEnjPQ3+y3hvgfWX+KJcl+gsHDxythl8mlpJemyErXconhr1onCpa42YCY/cx5AnZAoNAFVp9+FLSAlDlZhr8/kzUQKRQg+2rCxmcNfdT8wGcn7y52tOWUIlEWzgCe9X/pqNPkCynFr774/1KETFjcfUXviBKTfPmF2HXwUV4yOgE02otE4+uaKzCSsf4eqkm5pj4d1cnkExD1ZUyopoEnmo6CTFT6M5UqkSbG1zS9ivR7S7Ck0GRAHxBTNBsRsDpxrLC935Qk6dijWufyLl7PooPN2XcblaREMrnDhELGGNhmC9A6WsOn1MqlJzWsFGVu4+TMZ0xLYtw4+tIyBmVPvuhRhggoC8bKCuMTc7WtPcD/t2/3S6fAe94baVdQc7ze8xLdqDPn1Q1DV4gRyN7AXaK3xewkzY24/AGVQPaQ8dkJ8cp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2bzbdVDiPd1z34gAhKiZJXixqo7Uy0E7Awqww8pkTPtnSQ0OCv06TTvYWb/X?=
 =?us-ascii?Q?5B7EsWGo3BEAIqJBODsdLjir0MW3xWi+1MGSjLG+RmCUSDy+7X0h7WI/Jfea?=
 =?us-ascii?Q?sF97IUrrBz01Mp3v7jb7ediXJLvwm71IkdUInXl7DD0uj0iC6XTXMhUjPe6c?=
 =?us-ascii?Q?J5+Q4mrKeyBkSoP9ZD0lmwycJbQVOzCOhxbhyhmIOLSILZIktxTGDPp3nHjn?=
 =?us-ascii?Q?OUWG1okl0xnWl9fipKm34a3Xj4/UFh0kO9OfuLEOwgV+aMzr9SyL0THrS9KT?=
 =?us-ascii?Q?njtWzWdwWyYQBjIH5JRJVSeDlCLzP+BzBwGRf59MD/ZDI2sRMwqo2wzo4nuA?=
 =?us-ascii?Q?5CComQW2VdqpCWmwsVsJUIQ/wZAbzOZChPqX2hoVHZeCBPXXQHaMsOuVTRFj?=
 =?us-ascii?Q?E/QCdr2/6ZErwrm3hwkSyKhBZHpk9SznaM3FIdtf3HhXlAIZs7WsMATBWbnE?=
 =?us-ascii?Q?gCWua6hxp2LdQWi0GD7TqNID/UX7axdQP/4qO4eSFbZVca9AwicjQ41pizkq?=
 =?us-ascii?Q?M9xCo/JgO0ahmNPyAdAIC+E7v+UXjp3UNRjeCpu0yhvTCXUClltqCt9GaAUv?=
 =?us-ascii?Q?eIBZawA4Mgdw1+nUDj4nGJI8jMfNhmYD0m/dpiCAwvyRVpoNbTfIl8V4xu1k?=
 =?us-ascii?Q?SiULgBE4KEgbvqSrJe2Qd4jAM6aJTv3GsIKJ4uqCHYw2eBIa9p++3sa3K52K?=
 =?us-ascii?Q?NrmqTG73LYNBAzwgKSkJOPeblLuBzq8PpODPjeA7Xz4viGA2b0vOIknDxtDO?=
 =?us-ascii?Q?YjYFbSI2MxjunZIITd9xlv6p2ToUhjb4jbAGoXgx9/yGiEFbMCDUuQdYRKce?=
 =?us-ascii?Q?vu+cvJxdUEt1nhD3c3pfiOFZxfUCb5pfAW28iDnbIDCY4CSKf+WaF/vfDkN4?=
 =?us-ascii?Q?chZZZ3BQgSHnq+Ku5fnlaSwHtUBPCP4R2b3+usidbTOVcZzHA79UoW4emVoM?=
 =?us-ascii?Q?t1lTU42D+QgP8mNb0cDOQKeoqib0ZTk7GIBuHlCQ7NEsRjF/6reYP5w7OKRm?=
 =?us-ascii?Q?y+Qr8hY+gwel6g0G5w8ptpd0REz81e0N4KKqtBe/U32xIpayMh6LZ/OeNeFY?=
 =?us-ascii?Q?VWWaFuBPpSIzNaNy8wGhiFqNB+vdzuq1g1cxmwFEg3GVUATOTmiyB0SwQDAu?=
 =?us-ascii?Q?pbEjiS8yMfYnSF8l2d5JdjJdXXg/UalAxISauPzBaYxl04l5Bb1lWKFQVTAF?=
 =?us-ascii?Q?ZvW5Ya7Kc0VDB3LWgBCGClykpuvrM10qmjK3h6lSiBa+5sQj5RDeYs2lunay?=
 =?us-ascii?Q?tB9eCGZXMiYOKKUUIUcH7d0AEZMZs/KFdmqlG9zLQ6XtjNpBtR8hXDkBYLHM?=
 =?us-ascii?Q?FXIwjkf53XPHz+BldvEvwaS7aXQGUO2ery1pG9m1pwL3YplKxQyzmkjbH+TD?=
 =?us-ascii?Q?+9c1PHy7rBM9GKlC8RavhGu0M+qv7V6cP+5HgYzCCls0jDfc8rtCoVGA4Y97?=
 =?us-ascii?Q?OkOgYvAAk9vea/+/3HWF3IChOg/DxSLOO9uAKokW+SwKPopm9ofiQcrpyJ8W?=
 =?us-ascii?Q?sw/ZBXkaykcSEoNcxrkLuj6y8OQYTVvHxwNns8OaYS0smObs2p5aphS6YV+p?=
 =?us-ascii?Q?QZSIROdM4skT+tibvrdxgbirCxzQG8wokiWP9Sp0N8gu26FynLYRDrr0HSPt?=
 =?us-ascii?Q?Necd88sDgx0RQrU/kWCxitxPn65c5VUd4ThMKO6kp9sgUC/s+h9jH6IUSGRI?=
 =?us-ascii?Q?dJfCAVX+Pj8cRZ0d++iS9cdH4iZtknG7ZYT6OHxt6URnj01Al4/GnTfmaQMS?=
 =?us-ascii?Q?N3iDSXZf7hgIbS3mD8ckRafLMNp0t2g=3D?=
X-Exchange-RoutingPolicyChecked: cNUIjyXPYlEV99xpnfyWNR3N2Z5PeM/uXrbQZckJe9BkXrHb4GuQFJ6J5FqA38jwqJWiIRHlF7+HRrJfZwMAPkdI2akqq+K+9G3YA+2jP27gBRCRcClY2nlghGvvVyAGOxXq60QcIPs2KfNAlZRT0LuoU0ag837MJ+6A4c+PPJQQggSzqyJUGaG4qa40ZNNIfZwIg7ZDoLnjWgA0Krk/lNt5MCtwtocCZiNsDo/5lwzbwpyImcrdo21ChYuQC0POAK4YvCgpdWXZ8jM9lQPMIerizxEyn4FsWL6XRcEb/9mk31rRwXSNgccwVGDs8YDBn+GGtrvCabczPTsM0rbxLw==
X-MS-Exchange-CrossTenant-Network-Message-Id: e0dddbe7-d4f3-4d16-9b4b-08dec79e5185
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 09:46:32.2505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qStiJAVsKJuHt/6rO+CJf3qP/FyIY4KJUFzG6tiwnL7wjsi3B8lENRN7pM4bOBQ2HkzNsrmWI76ZQXiFuektQWK/Lx4LKIaoSVJb/FEUi6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5924
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

On Tue, Jun 09, 2026 at 02:03:17PM +0000, Ciara Loftus wrote:
> Currently, only the segment count is checked for non-TSO packets. There
> is no upper bound placed on the packet length, so packets larger than
> `IAVF_FRAME_SIZE_MAX` pass the prepare callback unchallenged and are
> submitted to the hardware. Sending such frames can trigger Malicious
> Driver Detection (MDD) on the PF. Fix this by adding a packet length
> size check on the non-TSO path.
> 
> Fixes: 19ee91c6bd9a ("net/iavf: check illegal packet sizes")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.
Thanks,
/Bruce
