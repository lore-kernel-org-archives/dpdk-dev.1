Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D28F10F994F
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Apr 2026 15:34:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 816B5402D3;
	Wed,  8 Apr 2026 17:34:43 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 9CCE24014F
 for <dev@dpdk.org>; Wed,  8 Apr 2026 17:34:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775662482; x=1807198482;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=NjT/Py+TlgEr0U1Xb8/h2C8Rnvqn1B9MLhDJNJGiEQo=;
 b=dpXUtigncEdloKtL9GUCrZF12I6WJGrNXTRh0j+DFqgfD9G/lJf/Y1/N
 KN+wpuSWIaniqgE96XmN8J4PrHyeo+Q/dvWfmdVu55T5zzJpldKfG7AQv
 FE0v1+g+s5l5Wgn3pSxX70d58O8hvLmezi/X3ODTLzZl6Zj57ZmLH/+eG
 MeXaWhYXJVLylhYSSgzyPylGT11fVjyW6xOA4dUizld+TI70BhxH458l1
 oHPr9E2CTwEaGWJPIBlL3kk4z6G08OUhwmixOpwoGrj/PBc9kgYIUaom1
 b4K+uqHhStF4nWoOvPqta+yYZZtD7DNGNmmASfaJMyEo1wMKosbWmEGXm w==;
X-CSE-ConnectionGUID: SFmLLkPVRsmYPQgadThdEA==
X-CSE-MsgGUID: D/JbDfEVQEWR/RArCaijvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="80509461"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="80509461"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 08:34:40 -0700
X-CSE-ConnectionGUID: fMysLdQ6SvSiIdgMksQPuQ==
X-CSE-MsgGUID: yQiB8zahS8CZUVdzKMPXJg==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 08:34:40 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 08:34:39 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 8 Apr 2026 08:34:39 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.67) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 08:34:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eL41wzIrnTmuxSGUOui9qDlOISwVcki2+uoIt5j5jgb4Rlff4YKsnk5Sve5LDT9rCSRzLI4Lo4assFsKJ67qCZbFFTXA5N1aqHOiwW7isrbslk7dDJCsXLZRpdXh4GKEt9mcR6qAGrRKdo02I+0XVFxHz9ONd8any+t+hT9c1utdNwLqBVfj4e6ghvfQE3dczmA+t0zl7ay1niQzS1ndVt9YQQgFVCWumKuQ5gUkRO9wYuRfaPpqPtmlTWCGjrEaQOkF9TGu2V9I8RICCfpkddsnX3d1AKRY59uFU7Y/PLkjvxD/IllqMRUtGq/YcS2OcfLpY2vGlBtcC2ENupuj8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1NOnxQej+rbcEV9VUvFd6ue6KWFqQobxIK1t7FTjpsw=;
 b=ct4JYw02kePubgFMehVZxuLGvAtL+5Uc1fk36zfv2CNB6TReN7HpejowF/hG/Nf3limLQ4bSAdcOuno2jD8mcmQaNvDzcMeU3YzhFgL6N3+d0iJUcnBSuBnmgVZQXIWSNISt8v4yRb2IeMdpj18Y8nK4TJ04GvSjewqt8oYu2JX6V5tYtnLEm3Yq6IQmLSPLlHvCg6gBcvONUBZ6QHsKZPDzbC9CrLZU/veOAMbkym3pA36eGU3dSR5t5GDWJtanMvvTppKpqCNdssAL6RCd0czjPFy0sdjZcgosvBjDvM3UWH6bKuw7jRl93w/tRL9QTOUfeeqfsC5cU57oCmiHiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW4PR11MB6910.namprd11.prod.outlook.com (2603:10b6:303:225::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 15:34:36 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9769.018; Wed, 8 Apr 2026
 15:34:36 +0000
Date: Wed, 8 Apr 2026 16:34:32 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH] net/intel: introduce a dedicated idpf complq struct
Message-ID: <adZ1iJkmy1l3uzu0@bricha3-mobl1.ger.corp.intel.com>
References: <20260406044125.3170558-1-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260406044125.3170558-1-shaiq.wani@intel.com>
X-ClientProxiedBy: DU2PR04CA0061.eurprd04.prod.outlook.com
 (2603:10a6:10:232::6) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW4PR11MB6910:EE_
X-MS-Office365-Filtering-Correlation-Id: 1774c358-5876-4984-7653-08de9584574b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: uat2i+dEmiBs8fvJT99zWkBz6vAg5UsVFaeSIF/kPzW4Lh7aROlGiXKIF633Jr305UfgxpfqQyam0cvmeJMF5FubS07041kPjT2OekIp8jlUWyICA3c7cM8G2PXVEgxm/fSN296fd+BMyvX8VBiKLtMDpX0A1mHI40FgdIrSzGHEDG8JhUctFMuvLLsz9pYZLPbsT+H5JPlAvSpiZoVR19ahC1+HH8CPnAPp1zthEPE6Wof7ydmeWogq5xfprq1ty8TrZqyYha9s2GlnvDE3UA7hkPipPNCiyWeCIkJ3JfZmPiFxEYbcwqHyPj4HZSOAgjunBMNeenmyViexl9gNQKHIfLVcZedx/mLSXmTorZ5oGKYUeD+Q9lGyKtfSV9SbiQTaQH8pG6sNzaea91UB+V9wTFQ0PxF5t3UrkV/wAXUEUtcfQtcMySAywpS6TgYdqyps90NSMYXZEePtwpPqTaXm1F5kp6VR1X6y84CVLflJyEtk6lk2r0YMwv8pmfsaH5f4bKeYWAZqwl4PB+OrBsZVBjNXPr5g8bqr0wofQgNW5zjJaLiaaqmfG9s+Zq5UwLRREKlwvv9lPzG+uiaTFh8sMV1WIESCHmC0GTCOeHDRS0+dHEBX8yu5QePg+ZPUGQZNIMl6mxE6bJBvZzqNqNt3UEL7a7UdYj7kR4kU2yJvzKbfkGui10oJ8VgR/R41uMpfdnVMSELmB4ShPm1PVrE6EeYkM2dfV9KowJI3ZFw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LVhzwFIR1loeDu6RlVX+eYnXMTWH8ejGDjwKe3lbwmXqRWGO2zZ6FLMi1VFv?=
 =?us-ascii?Q?Zk/canV2p4HzxPSJogXdqxgRe3YAOuQH+A5bVoMs+160QwpZMoB9svoLQOlP?=
 =?us-ascii?Q?Iiy1tdxPpGl7o8Zz+IR9Xy8gnPlN+0IoTAJ7HX0ccB6cek/iIEa1QorEg9KJ?=
 =?us-ascii?Q?vaHxFBGbsZasFeMYa40pjycta67uA9Ug9h2lVDHCAVDfXedNfmnYqucc/nuQ?=
 =?us-ascii?Q?k+0yFiRvQEzwe4eAOYtZXJt+xrvj67emjJ9d94g/i6C/Wc2qak9HyHLBL9Pq?=
 =?us-ascii?Q?n2CRlEAJIYVHRTmR/xAqYmubRYneAZsebygWREvfeKvZbDnWXSBr5uECIy2a?=
 =?us-ascii?Q?waglBIaI2yGTZ7vhLbNCMrpSGIouTCixZAN0XKk9YAUqiLlFeEnr5JLkm2cV?=
 =?us-ascii?Q?1/bH48wNp9ElWipufQ5wwMJWxrJWAHCaxzW/GkTVmBQPh/1++l6/LEafAW7P?=
 =?us-ascii?Q?sVYn0tSfMxeRj2O4unpEnewceAJOPf+sWvuq0FVrEANtWVti2/MMMKof9i1M?=
 =?us-ascii?Q?ygJ4rnAcMuy/dAK+daYnFye6S9wHw3ytNoECj03djbSfcb8lXM2uKUXN0ZEm?=
 =?us-ascii?Q?KbTdZe0LD34UhtZFy49SDjgiy+3A11c/3/80Z8AqIBypizUvbOpCFRX2v7qC?=
 =?us-ascii?Q?KGXi2u2guGH6H4gBN7/ZgUIxZhJyiAF1NrJ+hxF/wgwVMbxm8dPTxIo1FGiZ?=
 =?us-ascii?Q?7VKi6mqPKn4woBpCLs0H8o5AB9r51niMPwYZcudilmQfOIPqGdGhko0093mG?=
 =?us-ascii?Q?JW6R4BXZasIJyTkxZyJk7gYlx+M3W/A/47lEW/hZ/jQnf1T03V0FAnYIQvJK?=
 =?us-ascii?Q?n7ASm9EUz6gSkHthDdlrsczyapEDEOVh1vcpJ3A0lFoXnfv8e/zCADZGqcrA?=
 =?us-ascii?Q?6nG2tdSjqgAGbFL5nCRxaEUOnVvkbkpy//JfSstmco6JIL1oGkwYEPIJpdQR?=
 =?us-ascii?Q?3jOWPGNc093awcFWgvN+LtVpe8pEqQdo3aOFRzu9PiScIcVPTOo/cyfZGOqH?=
 =?us-ascii?Q?3vXn/9kHCVC+hM7RFTONSitQmuqrjiRYTKnsb2aVaP2Qzxokbbgqutr00h8S?=
 =?us-ascii?Q?G7sb4jWsP+HULq6nBLJDJx/mwpESN0roYf50DsRcRGp73PI7FpsFD8EZZemG?=
 =?us-ascii?Q?zOBjRLKysU2ZB/qgEuKB5Bsj8e6vm8dKH/0Likky8FdlGCBBqe17JWNhIeji?=
 =?us-ascii?Q?v5MT5dH3vfK/cxRc9f94L5IG9tOZWAFmKQFhrVwtC8slCUB0V/jPrsFkRJMt?=
 =?us-ascii?Q?vtsXutamQLxkH3yAG3iVMPFIXhwHnTj6iZfoeMfxiXM6Wt71kKA35NIEt121?=
 =?us-ascii?Q?UBSxA5A23MgXqIodMbt6ZHyxHJ3VGcPAUAm7BkuYcHO0rKiAdHqVh3fqGseG?=
 =?us-ascii?Q?2UxAv2otDXVH7ws/rn8uNX/8DMHxTGhOqCey7IY8Q1Svg8jt33h5KndkIHLX?=
 =?us-ascii?Q?3CdWAt50e5dg382aEVVVcQNYmLlGU9hkUeLxjca3wT4XeV20oJBalqQ2PkgJ?=
 =?us-ascii?Q?4CfTOxB43RVeGPz3nZB1sQ3A7dSACGcUnU+p5xbzWU1zULdSCi5jkLAiBVK8?=
 =?us-ascii?Q?BTgC7c9ndDnueRIVJWfUUdnSZyJjPBhRBUgIAtW6WZrY5JQNRlqczk7rwFJM?=
 =?us-ascii?Q?OxfvMt9w2G1fTFvf9pJ6IpkYp7dnPEwk0GZRaQUbOG3Yx/cWjg4nxalOu4Tz?=
 =?us-ascii?Q?4Wj/nPITjM2vue/OlgcaXc3hsvWC+idlNQJN8g/KJtL+b6sj8+eCKyHwfDp1?=
 =?us-ascii?Q?yykZF9Zfeq0WHuoeU7YUlyvuLh00zBI=3D?=
X-Exchange-RoutingPolicyChecked: kY4RWSeGHjpFdA3ivEZX39zfIcuz9Lz0BQ24lLhA+fRjvj25Gpwe2ivU+oy+RJ13vAYQjJyBs1pgGmnxUi5KP2IQL1xCracJ1fwuvPFLHPrAo4dYTChgZ87pkmKsgcNBgjQ2npoSsOcUWv8n96GxriuCo5U9BvsXsNKSrkLHiB32zGH00KCvMPRX411VlCuqIy6Q/2y+WDT2Ds+hvIdDgbwSDLnfUpQ+AHW5Tml8T5F3Pn4+pxAPUaTn0CTBRHmiw7jVrx/s4UIXmHR/LVAH1+6Ozwt+1AYRbUESn7Yz7PO+Wuct2j10v/vrRPW/xKF97k0x0U1If8hiD7YynB9BlQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1774c358-5876-4984-7653-08de9584574b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 15:34:36.8044 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OHWwAnuVJPXhvJ9dlg5JqhLqa/aVeVobQSY+1SpPogwu9BeoERjPYKREDO55MRZk2Kl4Idag0AgkWLqIgHKQFnSUz7nwFfBDSv/ZUjDs4iE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6910
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

On Mon, Apr 06, 2026 at 10:11:25AM +0530, Shaiq Wani wrote:
> The IDPF split-queue completion queue was using ci_tx_queue, a structure
> designed for TX descriptor queues, wasting ~96 bytes per completion
> queue. Additionally, the CQ-only fields (compl_ring, txqs, tx_start_qid,
> expected_gen_id) bloated ci_tx_queue for every other Intel driver that
> shares it.
> 
> Introduce struct idpf_complq with exactly the fields needed by the
> completion queue. This brings the CQ allocation down from ~150 bytes
> to ~48 bytes.
> 
> Suggested-by: Bruce Richardson <bruce.richardson@intel.com>
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---
>  drivers/net/intel/common/tx.h                    | 11 +++--------
>  drivers/net/intel/cpfl/cpfl_ethdev.h             |  2 +-
>  drivers/net/intel/cpfl/cpfl_rxtx.c               | 11 ++++++-----
>  drivers/net/intel/idpf/idpf_common_rxtx.c        |  4 ++--
>  drivers/net/intel/idpf/idpf_common_rxtx.h        | 16 +++++++++++++++-
>  drivers/net/intel/idpf/idpf_common_rxtx_avx2.c   |  4 ++--
>  drivers/net/intel/idpf/idpf_common_rxtx_avx512.c |  4 ++--
>  drivers/net/intel/idpf/idpf_rxtx.c               |  2 +-
>  8 files changed, 32 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
> index 283bd58d5d..9da9366046 100644
> --- a/drivers/net/intel/common/tx.h
> +++ b/drivers/net/intel/common/tx.h
> @@ -114,6 +114,7 @@ struct ci_tx_desc {
>  
>  /* forward declaration of the common intel (ci) queue structure */
>  struct ci_tx_queue;
> +struct idpf_complq;
>  

Minor nit: You probably want to have a "struct idpf_flex_tx_sched_desc;" line here
too, since you reference that struct below also.
If no other issues with this, I can make that change on apply.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

