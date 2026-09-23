Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC4BC982EA
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 07:36:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78A1742ECF;
	Wed, 23 Sep 2026 09:36:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
 by mails.dpdk.org (Postfix) with ESMTP id CC40242ECF
 for <dev@dpdk.org>; Wed, 23 Sep 2026 09:36:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790148999; x=1821684999;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Q8IVfyV3cNq3aLUlG99rS3GMlaCo/fd7/eF2728v4sc=;
 b=DYxNF5/WVaS9gXnPssvFJHbeVJvrzn3k28AC8qB0FskiOf1eRADVjg3S
 /cXUfIzLogF7yz/n27AvhmV1v+E7TTKOBSMoL0ohJAUcPtyjSxQV7Vi8I
 g/TD2Y2c4f5Ufn6wBscsnxHORLWlCKcRN57pm5tYnSCNnnU3Lzkde4qdT
 SbBeAISWshzf1IqeuTdO8Zhw85Id2a/NWViL8rrxvq6jKJV+xp3ZfeBpD
 uRAYEuii63cJOxi63sYlGg5PSxtWX/knrx23zMm+icqDsRuAYYUhrZdSn
 ZvJZxJLKXKUBBB/y6ik9Ri2ugPt2w4oBCfB4PY2Nan8v0I2laUdVuSr2M A==;
X-CSE-ConnectionGUID: fyItLgrJTi6udtaX6D1/yA==
X-CSE-MsgGUID: 0FlmMIJfSJSO2pRYOlzg9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="1331993"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="1331993"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 00:36:38 -0700
X-CSE-ConnectionGUID: geOfIgCtS4Ops+Rdw+H2hA==
X-CSE-MsgGUID: v0TzL3mFSvWrdxDkwBNBXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="4547111"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 00:36:37 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 00:36:37 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 00:36:37 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.65) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 00:36:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GFxsWAKd5T7OrpzRyUFXPadlzSVusVklKqz8yicGoo4JMYXpnvETBLz1YmF06vdOcuGXfEJdp+5vN1D2JVoj6TdQJBIF2k0/WzJQkLFMidWwhzJt8OjgPRfuM8YgmPMoYa/sjclZgwXaJo95LAZKy4I6Xx+WNDi6c87kISejkRtVp5gVccOkmn0q0NTuIvM4OJdyWjyNDmnUYLgTijk5rCS9Eqb+bkvkqXq7kLe5PHxvuxwqmcqfal1u/lrMLTB8g8GKSnFXNJQ9Y8FJGEuUAN4/6ue99og812NGgfIKUWHC+zT529iG6bPWZ0IM9cejHrYVgVxeGL6j8Z8hX0cZXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lt8uNO3h2YV9JAvYKoIOWqT2aCqvOWnaV0pXgt97zdA=;
 b=XZgwPLhpEiErHdKcr9NfwtHxACy1Ix4oDRo90MVKTcZhpBgX7O2jqzjsSrg8HImQBVbzovsynSgFc6sY0pbjGCnNBC4wP41OHotGEEnKzMs7PuT1C9fQfWUtwHrrwcg+0Tc5mqhHAd7YtTgghlIClGz1brWfjIUaWycfhIz+RI1j9bElQupjnO1gtxLfA6Gzvg4PA+LYnpFukXnnjDSxtzwGiD+olJfNmI2dgwJXCIcOw5yMUxtcx5MAOJpKSMJcXjDV95UFegluqU05FgfkOH1x0UpMvCv1ZtYld0+fzjUpwg3+vCXIyQOXUuI6rNgOuFRroHJMtEs+P5xRNLTtpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DSVPR11MB9892.namprd11.prod.outlook.com (2603:10b6:8:45c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.16; Wed, 23 Sep
 2026 07:36:35 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0428.011; Wed, 23 Sep 2026
 07:36:35 +0000
Date: Wed, 23 Sep 2026 08:36:31 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Joshua Washington <joshwash@google.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 16/16] app/test-compress-perf: use common division
 round up macro
Message-ID: <arOBfz6vPnB_2ngR@bricha3-mobl1.ger.corp.intel.com>
References: <20260812223017.2980190-1-joshwash@google.com>
 <20260923010742.2468145-1-joshwash@google.com>
 <20260923010742.2468145-17-joshwash@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260923010742.2468145-17-joshwash@google.com>
X-ClientProxiedBy: DB9PR02CA0004.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::9) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DSVPR11MB9892:EE_
X-MS-Office365-Filtering-Correlation-Id: d4610c72-9b88-41ef-638a-08df1945654a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|4143699003|56012099006|11063799006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: nRU8V4XZ/3OEJ5SaHH4dJ9SVNR0q7h/UVEo3j0lNaRVjYjacmy6ceL1ivc/WLKYMUu3JEoEsEWjdiwtf2xYZNvx4itavPIHrKBDm81ymsy3h4C6YicOA8Xc5nuz3QNrMHg6dmToO4s4vJwfiG6HMGgiPpjFtpVPY1/RKcsMg9HYIjcD02t4lPmCxMN0Ehk0tcKYHdZn1RL5BX1V9An3OIAgnsr1apl8tj5Mgq5E9hRmo/FEB2LaEhH1RaccYaqJDjbTn3RcRi2OCEkyc523BkJZdfw/E/PFj/YNDcpaDTBebGI64fMBvWYgsrgUZDV4ON3Vn1EN0Tp34Q1IT1FFnoblxpPVqgJeVKuALSjHPIz8v6qN313e8Ud0glfEWhony7YThZbKEK0vONWrMQDcl1GvvQL3ypNnHzwSJWIeHskipjyrCBG1e5ygQAKKsx0JAXc/LxStGdZ2P8sbHd5pR5qfqaTCx8J+H3RYaTYxje82XKkzTp/YbEqOhsr/ijWmJBXzHCkIuoDR5ufftB6TIVGstReHpzV04Dl2hn/iz6C1OTpPapSdOyLMci34+NtjytmQWaaf7R6WHF2SVfjH/ifE0k3y+PPUfOuyanVfP/zQC2xeo9y4p363/oM/QMI14Jc4t44tTWT1RIULZzvOcgSLg2HYr2TOnGL0PkiSphY4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(4143699003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aWwt36l3acN83qD+NFRcNpGFIUQ1kXHgIhfy/wYH/LqU68CA52kYbrOz1L/m?=
 =?us-ascii?Q?EktF22TsgPgH8VnQ/423qt4UZCUmlYL9NUm01rFY5WC6XfjN3JrtsABLCYfL?=
 =?us-ascii?Q?TzTsieufOLlV2HFgSjqPaIVzbL2nAO7rJYYATh6Juh77RYMxH/5fiHXIlt/J?=
 =?us-ascii?Q?vCZQ4gXv/hZwNYPeXVRgnT5P4ldzfKygD71rwIFRDbemxD8yoahkacj9qcdk?=
 =?us-ascii?Q?VVCcRWaNBpill4EtWsvISyyC2LKRqVouEP4Bpx1b3e3MJHR7nFP5n81Snjy7?=
 =?us-ascii?Q?83OxiT6RM6UyfofMNLkCNj4YxpWgcNBMCQEvEiMCctPxIZtUeTx3xfNuH4Ch?=
 =?us-ascii?Q?2z+a2jtxbED1yjvsxz9tdNOz7gs3IkCwBEQFaS2aSkg55pwDBWRBdwAKAwyk?=
 =?us-ascii?Q?sYfMbbjSmN1bCLZMRk/TKySv3aTBz98WTepJKfOFLrbAQIiR1rCsf+r7LYGr?=
 =?us-ascii?Q?dES7kK4eTij1x8WlEqlYovvDnb8LPWeV4pSaX3JnCpHZbzkWWQlFtziE+vj1?=
 =?us-ascii?Q?JvOwHXgh6SlfFC9v7IYWJc6phbVjZEAQ8tO5zebYy12nqE9hOYhI6DpNprQU?=
 =?us-ascii?Q?euIXcdkR6AoYCwHSKF+awOGyoiPxOsuy9IbqZF7ce31lhgcoiBzCY6yvT4Mp?=
 =?us-ascii?Q?Nk3PhgHRG6rRNLwTkB4v4EBM6UwVWvHsYiijVXi9shdhtx32vjhxmYIRS+0M?=
 =?us-ascii?Q?V0tIAIkGp8symnemoNhRHrDQH0lLKBLQFVGK8B30ZZ9e8OY1udp6gt/1u9y4?=
 =?us-ascii?Q?PbA7d4xstuq7idMmu+LQVEVCMKVUFamjK30zUt7TLAHYozmUY7FCDCpXPFIU?=
 =?us-ascii?Q?rtJGVAktzaOtqAwCrlgzLaIDF4UxP9hvIEf46se1acLBNUYRzgVV1Z12DiXS?=
 =?us-ascii?Q?DFh0jzm2Eo+0ZmbFV118rHghqIcfBFdsehMeOsCbDNXwtAWnxCLmY75MJ+1W?=
 =?us-ascii?Q?X5RwMpNYm/xSiRWR5H1PYfJIpTGa2xO6vCm/5izNNiHQvr3GvDDabidXNgmC?=
 =?us-ascii?Q?6SQq8wpcfNmEKSHGNVrAhaZSg5s3rUFdFmDm0vSd++jyRNfFKOB4OUAMu7ZL?=
 =?us-ascii?Q?HPRfrCfFETdu/0itduF2K0RtcIj1wwAS5HcrYJkSOsJytAvJnmT3+jboDWuf?=
 =?us-ascii?Q?kJY1W2/5rRzVpoO19C7OB1fA5gX3i2qyt6aBNiux9dDxqoe29Ni2eX9p3oFo?=
 =?us-ascii?Q?pe42itre5EmGPwKPD2UW88YIDWxQCkph8LIY4k9/PDw774KixYTdLngj7XLC?=
 =?us-ascii?Q?UKcdy2cGegONQ+QP62ouIwmzKQa8cVteZgTHw6AZh/C4HxprKmgDzVP9o60l?=
 =?us-ascii?Q?GzCS6epKMtTXZi0ghEwQR2MvBhCC73CaBjFLARdREQi/jwB2/EEGBGAJ6Qgs?=
 =?us-ascii?Q?7oCQ5bRLMR0bBPcMIb+seimF18G9fYdEpkp9ZO266lucZH2+ja+7VMJEZXUz?=
 =?us-ascii?Q?dCS8jQYLJvaNKTidPM2qE1oRE3lH7nC41jemDUoIzSoaSYPQ+uNZgXz++XzY?=
 =?us-ascii?Q?Y8QXOgWgU4y93BwfygYY3QOwyNGtDxMf2B24rEcZELhk7DMdI6nfJ1Nkjmu7?=
 =?us-ascii?Q?rCEAyMjlTDALNBDfgawPxXTFLEzrY9M5tL/qocESNoJFz7S1JPaz66q/qzmw?=
 =?us-ascii?Q?avsC4ndEMcfzrE9ZNBhpRJpiUOzpTrAVKNv3YWFILqkQ1TG6XChQhozh6gpy?=
 =?us-ascii?Q?Fl+jeDBLySiuC5nb+N8L0DOjbavj9tX59Dk9vB0DvpyNVticQ5Ji1QXDF9Vs?=
 =?us-ascii?Q?csZKJSfd8yRdKYM5VQYiDp0fhF0iFoQ=3D?=
X-Exchange-RoutingPolicyChecked: My7YhhU8fZHXwNAuLl5yvxZuemTqhMqSDIj3BMmUa3HjWhZqPSMOEcl2zd96LJVyzTpnIu21Nn+OJRjIUZ6PJpdxN3tqeEUI5LHFbdTh2fd1EtxuQ+rIxUWRI1jDM1Cq2bwbKkTs3GXf7O+KCPui9VwXpSqHwZm7fk+gNnwtXtd4SUHp30Yu1EmdjRZ1jQvABg8GdGciWMWHb9155CLH5QGKm+lGYGO2EIQm6LPnutbYAssrvqEBVQj9E0tM1PaKlS3UtCYepl/1uFBiuLkX3Yi4907X6aGbG+mohnac/dsYFsmOepannWyWVX/8k/4MCCjgXh4LiG//usKzZEX/AA==
X-MS-Exchange-CrossTenant-Network-Message-Id: d4610c72-9b88-41ef-638a-08df1945654a
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 07:36:35.5437 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fLHo06zTY45jqnZvJOD1X5xUq8YYBBGYyX+0qmuiYkedAVBAtvOSq6pFl7uBnl7qMpo70DUvjxinCQbd6THXIBIbh48GGwnEd98kOEcAHkA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR11MB9892
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

On Tue, Sep 22, 2026 at 06:07:39PM -0700, Joshua Washington wrote:
> The RTE_DIV_ROUND_UP in rte_common.h makes DIV_CEIL redundant.
> 
> Signed-off-by: Joshua Washington <joshwash@google.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

> ---
> Changes in v3:
>   - New patch converting DIV_CEIL in comp_perf_test_common.c.
> ---
>  app/test-compress-perf/comp_perf_test_common.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/app/test-compress-perf/comp_perf_test_common.c b/app/test-compress-perf/comp_perf_test_common.c
> index 78487196ad..3f70c222c4 100644
> --- a/app/test-compress-perf/comp_perf_test_common.c
> +++ b/app/test-compress-perf/comp_perf_test_common.c
> @@ -14,9 +14,6 @@
>  #include "comp_perf_test_common.h"
>  #include "comp_perf_test_verify.h"
>  
> -
> -#define DIV_CEIL(a, b)  ((a) / (b) + ((a) % (b) != 0))
> -
>  struct cperf_buffer_info {
>  	uint16_t total_segments;
>  	uint16_t segment_sz;
> @@ -238,8 +235,8 @@ comp_perf_allocate_memory(struct comp_test_data *test_data,
>  		 * Number of segments for input and output
>  		 * (compression and decompression)
>  		 */
> -		test_data->total_segs = DIV_CEIL(test_data->input_data_sz,
> -						 test_data->seg_sz);
> +		test_data->total_segs = RTE_DIV_ROUND_UP(test_data->input_data_sz,
> +							 test_data->seg_sz);
>  	} else {
>  		/*
>  		 * When application does decompression only, input data is
> @@ -292,8 +289,8 @@ comp_perf_allocate_memory(struct comp_test_data *test_data,
>  		return -1;
>  	}
>  
> -	mem->total_bufs = DIV_CEIL(test_data->total_segs,
> -				   test_data->max_sgl_segs);
> +	mem->total_bufs = RTE_DIV_ROUND_UP(test_data->total_segs,
> +					   test_data->max_sgl_segs);
>  
>  	snprintf(pool_name, sizeof(pool_name), "op_pool_%u_qp_%u",
>  			mem->dev_id, mem->qp_id);
> @@ -557,7 +554,7 @@ prepare_bufs(struct comp_test_data *test_data, struct cperf_mem_resources *mem)
>  void
>  print_test_dynamics(const struct comp_test_data *test_data)
>  {
> -	uint32_t opt_total_segs = DIV_CEIL(buffer_info.input_data_sz,
> +	uint32_t opt_total_segs = RTE_DIV_ROUND_UP(buffer_info.input_data_sz,
>  			MAX_SEG_SIZE);
>  
>  	if (buffer_info.total_buffs > 1) {
> -- 
> 2.55.0.1082.g2b9226bbc0-goog
> 
