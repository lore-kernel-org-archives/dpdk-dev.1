Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14515FF8855
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 16:33:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E6AE4064E;
	Tue,  5 May 2026 18:33:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 21BCD4027F
 for <dev@dpdk.org>; Tue,  5 May 2026 18:33:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777998833; x=1809534833;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=4FHDIWiE3XbSuT8eEEySpHqawgnqRUuTE8RgBKyRyHA=;
 b=ERCVWIb4b253xXKKmzWO4g7p1zC5a6Zq9kgaEKahSEphtiqdUPrY7v8J
 G04zK630fqVma5fQgDXx7XW8Jrki1srF8Urprf9QEeg03oharAn6m+EIq
 91hT+rb1o0KmCZYUhEAOlccGrNv9v7HuRKNADBLIWL2EvMUDZ9bnU7jlG
 U/SV8AhbgHAk3tH5uJ5hlLztOJl0wAt5PNQXi3q8iQYe83g8n40Hp+oyP
 kx3sv0ZfBk4PSD8wHr90jpxSqe+zuz9Ei+n13049f4z84GKeMXLVaReJn
 6w8+2dmahvxoXOrg+eJ+fJyb7Ld+Jq0LNOzUokNScGQYQI5M+3K+cUkSx w==;
X-CSE-ConnectionGUID: JaD7YQQ4QUi9KfJnand87g==
X-CSE-MsgGUID: 5qU6MdiHS0+XtKwS7PhLRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="79069211"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="79069211"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 09:33:52 -0700
X-CSE-ConnectionGUID: WIzphJeIScOTqDOIw/fWWQ==
X-CSE-MsgGUID: 3XEPE1UcSzGAuAftlpK15g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="240850764"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 09:33:52 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 09:33:51 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 5 May 2026 09:33:51 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.67) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 09:33:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TmJe3fxjJzjhxbrTDOpkJi2InRFLaBhrFlt9Q6zVE6tk5RPoJ9ZShHWEAIKuZqUZYwn4lYcZMcyUJOwyBU8dT3hnwiUY82t5Ny90Ktaz0aWkuWsFXmCLQ4bx8yWYsHUeWk9hlrOQGEry50ekQZ0PtkUZL86XoyL8fVJg+EU70lc4XTLZkYNbPJfAHTBnRgDajUbojpxo8FartePAqn1Wr/kXsRmD+gmXYYzQxjeGpiL2bRF96VdG5s0xk5r/dqe9DB9pfDQMeHITByIXBG0Joz7nzHqQ+rUHMcQ30BJxAQ0MW7AmAlMCQ2ptPotwRcJY9KGM+rDj2ruqPtli43dVpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2oeYZ8TDR3BWtXte+MAef9TFKW8UaeslVaWWtiXMu1E=;
 b=bAaP/kuori/WfLuM1LWJNryG7Fricj6A5RroJ5Vk0SQyY/dLcBD7WvSonI1GvfsDKb7coIZMQIMpgyT06sOcpK4mkzlxlsyRNB1oburz3zni6k8F0B5AGAOK6e7p2mSEV9ps3zfCkIN0Tn+rM2ILdtLjm7V4PT1WVXA7DYXn/fX0jYmgJxfbYh92R6i2CJ+kTXdzkySAS9xM66e1Y44LavVIBdzKiUB/aK2YGcrJPlvuUXyF2fv6q2DT+PUDXoMvW4FdrFF+XoTyetzzFHWFD0Tyi8VUBeE80Ly/eh6m2SvkoZFw8F3Zq49GcW0VBFtps+6rMy5lE8C6Ki8dnjD7vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SN7PR11MB7706.namprd11.prod.outlook.com (2603:10b6:806:32c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 16:33:48 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 16:33:48 +0000
Date: Tue, 5 May 2026 17:33:43 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v2 3/4] net/iavf: implement flow dump
Message-ID: <afob5mz-tqhnl42P@bricha3-mobl1.ger.corp.intel.com>
References: <cc3919f5b33e633d4fea632ac2126eed2b537175.1777546834.git.anatoly.burakov@intel.com>
 <eacc8a315356cd6a1c1cebd192c804d0ce2ff90b.1777546834.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <eacc8a315356cd6a1c1cebd192c804d0ce2ff90b.1777546834.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0229.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::26) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SN7PR11MB7706:EE_
X-MS-Office365-Filtering-Correlation-Id: aeff970c-9596-4da0-6a5f-08deaac41524
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: /upDW9KOR8hTMENwznqheYDl03ZbQuXNvSyDdz6FViyaB47nWIRSUeGymRhQrhvRNNsiePV/zV0ittKy+vWRoY34V5AtIT5ea4qfxD2I1Rxgy5iEcgiWK/cs7bIvPJWYx4ZECBGVAJPV1IL92WYf5dWo5GDjbgDjkm4Rt+DBygnaqyajymCNdsv/D//Tk77hypPYZj0HRfa87amsb5UqzrSwBIb2uheywRvBLb5eceHoN8iRUMLSQpRZ6PbTnSVfZ3QlObKa8Yg+2/S3NUv9CbFuF6+TJMEJHbEImy+05nlDh6ry69YQHfMUc310dEuFWZKYtRiXFDPDBTZNJ9wbM896LsJAhuZZHXEdfNNBAbFh+US2t3TNGDFKR7l7S7hVNAoYekV9mCucl3yVtu733GfWm8zpzA7ll1wNXSimmeMre+sgPuFVKsweXdEMNHza8x8b2KentYOW+PbL/qYvsyEFPAQDMUTQdRLLhgoRc5J5ttJJUNFqoalbndBBX+jIFqo3GiV4RURz8yl+AgMrZkqqVSN77LK9b+YMW303Yn9iCfcXG9JRFXeu0rPITgucTHuGr3OCca07AIEVkz3UzRszzakzafF+GxqUloSNfbc4bWjFlmZcTjxU8BxmrkHii0K2K32jRsvgU8MtObb0pzlU9ewq/WvvtwYBOmqBjZErvRxghL+Rb0wz9NJbJeD7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XtElNbXyooO0hLLzFrc5EVfubKgIYYe7gjrj1T3gHSxlSq/IojVssVfWIMwZ?=
 =?us-ascii?Q?0ONtWYCbZCetTTHrrxuj2HvZwokobbOfPScpzYJTZl/wn/ycTq4v6nxF7BJN?=
 =?us-ascii?Q?P9DNu9GQacWNVONuh88/BomtnJ8KaZHzbQkcVkDiXDKX9CgbeZq1S9ymmAZi?=
 =?us-ascii?Q?rvgo30icliHTgHgiDm7Yt5ORkvB7PYXzk4wt9/0QQCCTZ3vvNhLHUpVKFN73?=
 =?us-ascii?Q?dSBLHOl9f6uvmBYROc/I8Qplrya+vwBxJAUy6SsuXk06BKP+Yg3C481JKLIL?=
 =?us-ascii?Q?4HLe42Mv+3VCysOIZnnUzFFb/2WtfgfrE5ET31gODxqV5YsluFY0IdD3ArO8?=
 =?us-ascii?Q?CdOIgcsgxl5Txzqc4KP8wQ6j8X/elgmaq2oLdF+nlZemgxk9q7Cfb/hfuTR9?=
 =?us-ascii?Q?Mxkq3501gzbrzmLwKMBht8hU+TMLxhfJiyfRoD3+zJwZVTjM+Jz0y1G0eyE/?=
 =?us-ascii?Q?pQBvxUrA03Qyh8mtDaAN8+DYrClQoJYE1Po3e8klNdymHfpjvbZHqf7kVh+l?=
 =?us-ascii?Q?RJLfSg1LcqNCfBOavLBLBWG8Rt16EgZl1uRkKwTclCW0T/QphgO2SFJ7IFTk?=
 =?us-ascii?Q?aqXZZ+30Z+Tk/9bpl96VuPIh/8qpdS35M4H9SBEykrwhl2CnPXibtBkc6ixw?=
 =?us-ascii?Q?My89T3qCQi4wNJW7gf3K/YL1msVFREVEIGilhsgizpzCotqDkyYjV+YQuJYe?=
 =?us-ascii?Q?gzdyWIdTeqrg6r5kCnD85EGOjSV3WFfPvh90nzC3CAPxEz5VtyfdqX4SoP0x?=
 =?us-ascii?Q?T+tj4+g+lcEcgini3tfcCpqCAJ0I9+8UBgPcsXxQp9zTR7T79zzTvYo2OOX+?=
 =?us-ascii?Q?L3xJk8FGGcZN6omsTePLYqwCiJuo/30KjH3BLwEomNqpJEgTABx4JXGhgR0w?=
 =?us-ascii?Q?d7OO9u/xpqxgouuj7R8KP9i0pSVqGwD1wuVS+b0QjfO02fkcgSM/YF4Vvs1R?=
 =?us-ascii?Q?aLzulBL6PIGl/1Ki9zqLoRDKoNM2sP400moaVUEzDY0wHlvkzy3EhrOGVJrJ?=
 =?us-ascii?Q?88cU+Nj7d2if/AFk57sGWhklurTn1D6DP8wn5BU5SGC1ykVEOJ7UANQVxVNe?=
 =?us-ascii?Q?+kEEUvuXxZjx43KR7MxBzgeA8vBnfxqD5upfY10rwQRUEcEQNZYyZhL0Y5nH?=
 =?us-ascii?Q?Q3u1rOJRZJqkV/EAIQiywON/coEEPU/YhXTqbN1PXsWcJC9n0azwn760sb93?=
 =?us-ascii?Q?bcJaMio7qatTLOL7WewNOC41ypVE4LnP8eaVnoJuvPFsO8ffp1P8p2Njlogc?=
 =?us-ascii?Q?oU5ckkxPBmh2it9E95fW14BjhPLZ4pWa2jTGPx875UAgutGIXYJeM9uji3MP?=
 =?us-ascii?Q?lHJ2ljyKYS7swyt8cw79V+H+SsbHLS0F8AIHijpRwuGcBMSla18CBtjX0LhJ?=
 =?us-ascii?Q?/GcDqtX4bDlIqDmcfdMdlwut+938gjnTD8PHWaimTbpWXDd4mKnjsmzycL6g?=
 =?us-ascii?Q?yWa68vlVN1NV21Frx7HG2EH/m0IF9bw0PCp1F2l8MzTGNdHBolSe4fjOmkzA?=
 =?us-ascii?Q?pEKQfPTTlx541rYWKsz4LZcfAhPiBOjarB8/rw28IHtzjnqw0Poz5nONE8H7?=
 =?us-ascii?Q?4w7syZGPVv44X4lMNXgPo7oGC7jb9BVZoHuw6f95OtrW9TUnfPEY4yW3xphE?=
 =?us-ascii?Q?7kwKlvcMSbEKzemkjSxI6mRab1xtkeqoTZaax1aZsuDU4o0UgKm1H5mfQAUd?=
 =?us-ascii?Q?KrdA3qNmT/CLB0c5S51naCb/w+RJAIPEqqex6srIE0vaypmUCFhf8pv3dFMO?=
 =?us-ascii?Q?zTpbNvULjvPKpkkRkp8qVKGD10NEotY=3D?=
X-Exchange-RoutingPolicyChecked: DtgBIgaLOB8P3wymDe6Z6TqnrdRNdAFWlxZoMeXWwkCPZ65eKx3lDp0wIK8Ixa0eXbYzO/SAZrEJK6In1m4LEqvOiDipJ89tdsixx1bqgib4NeOPHpzsy2nTxLljgoVlt7MdcUY8TtW1G2/JCMo4rYmzR6TUOGFB6iLGhTamOYHm6oFcH5qpb/F8dlFBZGlN2EtQqEeap/re3OMkKL6UlFGDbc490huBlQWvfMZA3wCJST7aObf9d0fLerVcz8S6m+iHRlc+QO+ZP1kxDnhqZGroheCxnhUq9mCdmg2gcRb7MMIYNMr74f5dObWZucdXPRJBAlf3FbeKw+yXIIR4JA==
X-MS-Exchange-CrossTenant-Network-Message-Id: aeff970c-9596-4da0-6a5f-08deaac41524
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 16:33:47.9342 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NG1YglBgibRxdIOnVBnaniYEzNUc1e3YCrw34SAQyCKpFRb728CGLNvyQ/4k3kdWGvlITbBsxhdLakRlOxfklBtZZd8qWV++/i1rdDBhiZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7706
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

On Thu, Apr 30, 2026 at 12:00:46PM +0100, Anatoly Burakov wrote:
> Implement flow dumping API.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
