Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97055CCF2D6
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 11:19:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 50CF340658;
	Mon, 19 Oct 2026 13:19:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 060594064A
 for <dev@dpdk.org>; Mon, 19 Oct 2026 13:19:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792408768; x=1823944768;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Oj6Sid3+yMH1n3kZHFCdsGdwKt+mrcKyM7FfBr6wXEs=;
 b=UMZZala1Ug9HkrF5NjrGfzQhWtDw6iaMYgASGhmziXjmIBgK5mbyYiIT
 K34VenBkVfPh8Puy9i/aKDFiZDl7P/e6YMzS6GbUlN4ZQRf6YIDt2Aomq
 HsDrX+fLnD+xjya6rKOnZkkGzw0x6tF0jBXXJFfTg7cb82rfokxSxzlwR
 zDb2nMZHC7givuk2bil/Vyuo/vv6hAtRJfdiUjARJHj+P1wnLw3nL1B8R
 T/GaDFBBdx5i3LlrY1785sfKCbqnIFe+1R2yUQzz+3xpa4xThXxLVMgUm
 zDJCBmHp6Naaiix/Kl2PCOHjScVprQu2vBksrKGeIgUSJBZvgCiZTYuPQ g==;
X-CSE-ConnectionGUID: pLjNQ5GsT5SvIks7i69CBQ==
X-CSE-MsgGUID: Mv6gFfYkTya5N/xkUcFUCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1089025"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1089025"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 04:19:27 -0700
X-CSE-ConnectionGUID: Fdfn+KO7QR6zpvnzqhP/ow==
X-CSE-MsgGUID: YaKu0k2VQc2nC41D39Bp1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2817719"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 04:19:26 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 04:19:25 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 04:19:25 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.62) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 04:19:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BvibECJBiNZT+AEku/DzyD6USqNVMOH2Xilhy9tvf9m3BJvbx81as3V2vKkgJUObVBRRtT3slAXkLicVVuNFcthjvMOaN4kYPJ0WYlejKNAFNRmhdsV1csQj2UhqaJ7sw/8fcm9beWu1JdBGd8t/30R8raHByWh7BTRJ26sPb4jDS5OoNrmaQC6aUWbsQ9bcyrcVXGJo7s4qyhYUh9ZQE5aRbLpMqIvSrDXCaxGq34OgM3uCmtuMekfXRIEMqdTEeTCutMWvuscZa3e53afaVZb/cHgHZvhDBIC2RL+h9eyZ61Q+IOrBfyU/tcKCcdYuxNCWksvQLFuIfv+8IlMNYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDopyGN5qVX2REiB4FZrUB4OrTmJpxe8foR5sMYXca0=;
 b=dBcmexiV/NFPgUe1oo2xpo7z8IPd1d2c8Y1xlaPIooVHeps8X94orXjOPMOFPWAEdd2nfDl15AXmWWCb53o4hg1wewWy5qOIBv3Zvskf43JKDC53lHjIEacQCbYCOxZpyWD0QrMKX2LnZKbEm18OJojvgb02RmQT3WMTPiWrVVhy3GPE23AD8ma+THMr66oVF2Fl0tRdJKe4ksJhdf4o3NqTNll5leLzlWRsvkY/6TZMzutdoa5p89nXEACK4iWoWGmY36xl/g/sjEiM03cnuKvZW2+hY8/Yk/2ApqLtByRDc6D80x18LCJBGJav6PlStznDvHdzYXtjCMLT+uEw6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SA1PR11MB8325.namprd11.prod.outlook.com (2603:10b6:806:38c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 11:19:22 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 11:19:22 +0000
Date: Mon, 19 Oct 2026 12:19:17 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH] net/iavf: fix memory leaks in RSS flow engine
Message-ID: <atX8tRZDdPwsIX5V@bricha3-mobl1.ger.corp.intel.com>
References: <20261010121255.528329-1-anurag.mandal@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261010121255.528329-1-anurag.mandal@intel.com>
X-ClientProxiedBy: DUZPR01CA0002.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::8) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SA1PR11MB8325:EE_
X-MS-Office365-Filtering-Correlation-Id: c564158c-aec7-4bd0-d049-08df2dd2d388
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|261009223027099003|10067099003|56012099006|6133799003|18002099003|22082099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: r/ol92y06YVxIn459OxWtBPFpKyBPKeJPhB9ZIDlwpI1CaHaE0qQ3WoErD2R0FLLZzsPZZLFNCyhYwviCVHjrz0gmi2r9Zwul3UH3chbjjHV0etgBDC+Mq9ajNXlMeO0bO0JPFRLjLB0QAz/dYLRAR1KoQNZtxIvlJ8f0zOEgXQAea5osGJgo7xHwvjmi/i7N97ziFgjNnK6MuyBrnA8May2A63gYKgXTyK9Za5LE9KpcpBCDpnu7kJJEl0GG9DmV1V2xqGA8zkXMEBRBq6sCmr9R8O8ttQNwRmemqGfr4fZCdMku4bXdd/TJMaKiyrSMvBxTxtHl6gTUa2tZW8pRDOC3PiOph7ECGBZOVgw39lp65bT6NCpqKep1lv2cC0gnC1WFqdzvQlid++lU+7CO4n+KnI8C81wd/PNNJfoV2g4BDd2m666jXI6ISMRQvpd1aImDIYlsUMBJiaw00DFUx2NUmjO+UfaHZv6G+LI5tfZQnbWPc4vXEFha2US9p65Y26aV4iCKw7rSV8u98uPcMCB6LtwjA8Rm8yyaRBq+wCVNz68e8UQLpaiMizqafVES5ghJcmE7eG2WtqdoISNmI9xOB7TLRBdUZyFdHJp4+vo8j6scTuo6JP6jZdcRnbPz/ysLYM6sOaPPiN54Y9X2D1dBEdkiWfLzVF6Q/dGlQQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(261009223027099003)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xzFJXC31M+nIeGbgmAqMBoTLupbrgTZIgNGuCP/V+BTjdSg9bbOECd6UjBIp?=
 =?us-ascii?Q?EQ1IplA4O08v8uLnpnt7jJusz39viqyisuzhOJjd3tz63LzQOPlvKzd5MJ9q?=
 =?us-ascii?Q?k6Hzee799EQUbDAFEwSRAwcmGla7VmVSexNVL1VCpoWZcwJQ5/Qcll6lCjFO?=
 =?us-ascii?Q?ihD4SuO2ZEfa2DNTz27h47JOAb/gyVIamWTzyK7t5d+P3HKV5VHTtgz3yJ2z?=
 =?us-ascii?Q?4NUx67lKYBmhZ0Z1fdDGOrT4b4nQDSsAldo6u178xCnyjKhho2fiGRAuCtUV?=
 =?us-ascii?Q?n/sBMSdCyBQPzDyHjy1b27sXHAKdL3dV1AQeB9j5K/GPjD3Xi4ZNbWhph5LB?=
 =?us-ascii?Q?8pXIP7aXPzydUT4OQHgDc80x89SVcTwQWTitclbyOCKm4PZkySPo0EjdHpFP?=
 =?us-ascii?Q?yBlSqqBLkp97NXvqBoxdNsXywHTy45W3WtHycf+B3SFawDQmzqmcde2fuecH?=
 =?us-ascii?Q?I2xLCDGqAtqMxABoBUoKFj1vf8igonn3J9P/k8bMYBFVloRXGF/qkzI/ZvGX?=
 =?us-ascii?Q?A18kphF5E0s+VJIPd4z36VIP/PlKqoalNOkrySmi+rnrvuRkok7itMo9GQGg?=
 =?us-ascii?Q?YYLTD0H9vnxtM7ix0sknufhQDTGOwPsYTTa7IaOXz1c4HadyQzWOQ8rbfjA2?=
 =?us-ascii?Q?GQxx9/FhJivVxJ0Cf9v143onxudDGWONkqQL9052vLC+jFUKFwGmLtda0bbL?=
 =?us-ascii?Q?YM0svheMocybX8iAYYj7Q/oQzZHQjmyReZhRDmAUHKMs0hmCWYf17D2hMIx7?=
 =?us-ascii?Q?39a30thqjirXmPkGrd7G9F6EKiRMuiwxy6B9KZzp0VO+Cqs0AidEox02iWIR?=
 =?us-ascii?Q?Ok2CvYSajjrmqTuqUF9LOG9JV/rBr1qCu2s5aAe99eTvUKs5cdkAkCzHOawg?=
 =?us-ascii?Q?0CavpICnPe7PvL1hVXeAXkJ+icotU1K2kX3HGRcQhmt2a9vybme82pjUZQXR?=
 =?us-ascii?Q?BcGjicVsNYzRTt8MTNkfacBzDdPFZJv2uONRa51UOYfc/gIA/bG38aLBM+6N?=
 =?us-ascii?Q?jAtf4udo63QIzwh0JfYwR4jAU8/EE2E5L3rBXXSLDezxi6ew4pXAmih7tiY1?=
 =?us-ascii?Q?lH5ylQIR9v2CPKDcp+JmX5RAQpZ9itNGNxp03IIgiVRE3J9wa260e8w8/Zvv?=
 =?us-ascii?Q?QR45fHGCEcw9CwBKDbEucL7AK3vj35XLLFhynKTlF6dHCqKL0rm4nqbUEHZm?=
 =?us-ascii?Q?qjxC/ALpFT89YbNJubZanuphTIrciRF6y9x/uT5j9BUvoQE8d2XedOi8n5lO?=
 =?us-ascii?Q?0VaalUnLMIB0S+52zNUUL2puBVfhHBZY9BXztytmUcgGaSDMtjrWbBLUDHh1?=
 =?us-ascii?Q?QdSu7/VvyFgkJP5dQcXeVKPQ6selOP7Ds4lS/S0HVZSFw5y0sbeMBoniX995?=
 =?us-ascii?Q?jdtts4A7VeSIURryLXpNknvhvQ5UzqIw4zBStL4zmUWTVQVhrvVsBMmq6zqz?=
 =?us-ascii?Q?PpzxrAm0cyoBZMSaWZOwXfneGV7URu8/vJbxjbCEtlJ2jIE7R+LlFGpu42M1?=
 =?us-ascii?Q?MWz5yu8lo7WNsPoteCXWxbKNaUGBVfIgUi9Ip1vrefR4ulQ0dStLbKLaPX4b?=
 =?us-ascii?Q?FMuuSvyHxQoR3CXXF7PFk84nIsQ6efMwE4sBBmCeUKCaJxhm+URY+yoeIOuO?=
 =?us-ascii?Q?zOH+sgPsT1dc6DEjZOJwDm4/ipp7Ep4vnYzuzzkIIzVm4uVDuSkdi5iErvkz?=
 =?us-ascii?Q?2L/9/gaw5XTmCo27h3ooxGPP758iwn99afzL8E+ExcXCJdavPQK0tTes1xvP?=
 =?us-ascii?Q?kWzixVwmefleKh8blz+SwByQUV2KISQ=3D?=
X-Exchange-RoutingPolicyChecked: 1a/EjgJladWWhRRL1VlDeeAz163P6QA/5akMBc9yxozDjjnhdnEOP34WLds4l6yTKEXJACtGrdGXxG9xct8daXa7CPrKqPc7Dbt0tDudb6jKEwOxUh7TdLh2keAGASr1I6Ta5zpZgrYLOe/a+AEwmqFwpaTd0TJuEzgh0tVmwczAzmoFO0Z/YPxpEotHOiWlSa59g7cHvbGYltG/p9IEAdRcuPLXBCnF77vdgTGCpepMuQ/58KYCNCxv2IkvtbX4XoYzoEfJ3iRHxndjvRlOPagIgstcgi33tJAmwVsYDtP9+KaWZOJJFbV+3Nr21oSbrw0J55YBjtmEExWEMvq35g==
X-MS-Exchange-CrossTenant-Network-Message-Id: c564158c-aec7-4bd0-d049-08df2dd2d388
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 11:19:22.7709 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OT0UgkzP0//tY8PzMPfbCz0DtmY+0m/GDIsBJv3a/iBvUisT9hdwP87G/yYLXueJ11ltwRjD8wEraaOaptEj18zqGRP73hE0XTkeGMIHk88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8325
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

On Sat, Oct 10, 2026 at 12:12:55PM +0000, Anurag Mandal wrote:
> This patch addresses several memory leaks and
> incorrect error reporting that exist in the
> iavf RSS (hash) flow engine:
> 
> - iavf_hash_parse_raw_pattern() returns without
>   freeing "pkt_buf" when the "msk_buf" allocation
>   fails, leaking the first buffer on every failed
>   raw pattern parse.
> 
> - iavf_hash_create() only frees the parsed "meta"
>   on success.
>   Both error paths return early and leak the struct
>   iavf_rss_meta allocated by iavf_hash_parse_pattern_action(),
>   which no other caller frees.
>   Free in both error paths.
> 
> - iavf_hash_destroy() never releases flow->rule.
>   The virtchnl_rss_cfg allocated by iavf_hash_create() is only
>   released by the engine's free callback, iavf_hash_free(),
>   which is invoked from iavf_flow_uninit() but not from
>   iavf_flow_destroy().
>   So every flow destroy or flush of an RSS rule leaks it.
>   The early return taken while the VF is resetting leaks it too.
>   Free the config and clear flow->rule properly in all paths.
> 
> - Out of memory conditions are reported to the application as
>   EINVAL while -ENOMEM is returned.
>   Report ENOMEM instead.
> 
> Fixes: bc0e85586eaf ("net/iavf: support VF RSS flow rule with raw pattern")
> Fixes: 7be10c3004be ("net/iavf: add RSS configuration for VF")
> Fixes: c02ea7410e51 ("net/iavf: fix flow flush after PF reset")
> 

Cc: stable@dpdk.org

> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.
Thanks,
/Bruce
