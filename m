Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F4A606A31A
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 09:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZqSTHcl4
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 863524064F;
	Wed, 21 Oct 2026 11:18:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id AE33440041
 for <dev@dpdk.org>; Wed, 21 Oct 2026 11:18:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792574300; x=1824110300;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=qpVRYefvHcQJSroC/Ajjyu/BrBzbut6dVqGW0nzQrzI=;
 b=ZqSTHcl43JpqQBYkTeCk8F3hCtnftPig5nyoswCNbBW/4gij9XjqGdLO
 YQMBEyY76qRuGagejBFcM3WQZ1bw9wqtHYZyVIfC+tyY6RIHulYjXHhsO
 +LXQhkmUm+SXNyfvQdsRNxL1+4zEgBqSc9zHKPDJNFFc/pNE+i6DOU+7a
 arnmWLHWG9cq0A+cZSftiQQPfYYR03eHxGyGJFjm/IDhwtaN3AlY/omnY
 SNazIHys2xEiEmVF428y8VOWq9y12FMquUonGiEaFLqrcy2G6CFKlKqoy
 omV7hEwJllN4iVxNRIRIOBLsaiIXSS65WE+nCKCacmYZucWiXxS7f6QYt g==;
X-CSE-ConnectionGUID: 0yORhOnQQriZmD8zlPoCvg==
X-CSE-MsgGUID: aAvGIxmiSSu9IL8S5diqrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1192297"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1192297"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 02:18:19 -0700
X-CSE-ConnectionGUID: bfyMDIU+QKOZHdUBbGv53A==
X-CSE-MsgGUID: kVQPDYDQRXGBksW8bBrFbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="4876455"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 02:18:19 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 02:18:18 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 02:18:18 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.62) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 02:18:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b18pF4AkOT/DOmNMeAMMdIqb2AVxo/+IyNWCkRqq3QtlLxxB9EtxFCAOf67hxNoBks7D2YmIVPINiln6saL+NEdTuxFpZUwkch4wuFVzuPJiokdHc1+SilGw4SY8fXJ7qUgr6huVDjq1xV7oD74kdUhSjDZoePjGWxcjTkPbdCbtwNgaMeG2Cz5iXeWeHNNxmqyczxIGZU+7PTEfAu2hFYUuVlm/YmClozyufwN0t9xE8b5IKULNwl5wtHwbYjt+87YOna62oMRrlIgVtzSJdP/EI/JjmqLQpOqClZ8QAUHAoT6qIdsyBkmmbdp4R0X5nsseYd5JjPy6WrZP6PP5RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dRuFJZ4OqdX7rd/ZFwHe4rPZ+qjDCJ0l05mDOebQEg=;
 b=bFprJNEBGWp3i7nG9My/qHMrcMhumLLhPwGzglDv1nLoHqSfGZHMgYDUxyiDFB8FmHyT54LNC396YGO+iWo6rdJtJ30ltZdNSzRbjwHIKFnBBE1pE/RlFnamp+tOGHF4ZRtnqwOfgbpDJg5wjArtfx7N9VFGiGToUT3wyLIXZZj6t/gtBGYxAYsHf9zKpyYna+F8pV3r3YpoVQOfyd1zBGfg71WE/5gWsBOw4zyDs9gst60z/jFEINyNN+5p1zMqylaI78Y3ouEp4w+anEyWhJRRbO90LazxrrTRpBouRzUEbFn8dyN+eIq1k8aIlFjF2KVLBUq/AEZLdLWsJ98jJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by BL3PR11MB6483.namprd11.prod.outlook.com (2603:10b6:208:3be::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Wed, 21 Oct
 2026 09:18:11 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 09:18:11 +0000
Date: Wed, 21 Oct 2026 10:18:06 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v1 3/6] net/ice: standardize VOID handling in flow parsers
Message-ID: <atiDTvOdVy1Xw75b@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1792498154.git.anatoly.burakov@intel.com>
 <12811edcc0860be69711f2856fbab6fe82e27b57.1792498154.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <12811edcc0860be69711f2856fbab6fe82e27b57.1792498154.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU7P191CA0014.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:54e::27) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|BL3PR11MB6483:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bdd9ee6-52fc-4faa-9834-08df2f543a5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|22082099003|18002099003|4143699003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: pictmleRhdXLeN8/bMkYeCPMj+B0L4yaqmlk/LBqWQjus4msg1jkxUHDZ6k3HyE1y8WTmPhKar285DeFqTY0rEDm3FbRmYmOu0BA3cRTfjki7XW261Vh2MlE670w29DPMe3jvx0/Qim+i1E9tS6D03azC+tGlA371yDSSjMu+VYPJLqgS01l/XQVhCNDUUqA07RGy+Hp/7I1vzGoINr9XXd2nHiHgPtyaUKhDcJfPqwhfY2Dbrft+/JxCUsjUzxfpohD/kO5XVP55QC1v9DIRBCxTdUVjN7D8Azk8p26LqYZgm9GHfpJubkRcTpAFW/5rayeIavz1RL62DtkM7sw/1JsMZaE4TXjeWwp7+XTCa/F52Bsdg1nVyrtcoQszAkw1cf3k4EbWoQitWozPltr5as8AcO3Ua8zoqBLDg8Dr3Kb0kmkk8FuGBz6YqDuLA0OXZUWVzZuTkcHAnTMQqDQdCGFNn+O/yGtF3X0G+vPnhk+ZdTkZKuZ1Ny5eaiWZe45wg0I7VCuHdjl+wYZ9POgxEb7swxBQXp62IkX2sVjzIz3WCnS/klRq2/FUqhkH7vtYO2tEgyXH84CsGbzC0AM98i36apBhxgKpXqL18QvWU8umhibSaIF27fDqH+RoowJovP72sL7Lrt4kJHIFYQG6qib5ZZ/7DDPX/iiCD4bq1Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(22082099003)(18002099003)(4143699003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MSpXNlz8Oewbsh9nzCbDuhbAHH13hHuqHPs67qfOP8M7i4SWgcEWli4SoF8k?=
 =?us-ascii?Q?a1+v+mfzx5jW3sJwsQ5/DAPohqYb7CWSD+ESPWx2mz0YqHges9Vs/2vTPqdq?=
 =?us-ascii?Q?8pFbfBeD14xApB06MczWvmrt5qyaWKRIwpdTaL9Ssg7Ni+wrTvRFveFVXTg+?=
 =?us-ascii?Q?UyrHaU37owpV70qfGCmAWcbT3QUd+4MX4D/EPLV9ELOlZscG9A12DXBfzvqe?=
 =?us-ascii?Q?4W9woFe412rIF1N8Yoy+dhonPduffViY6QJpU2JReE1XD8JKVOkU5PvNR/4C?=
 =?us-ascii?Q?R2aSITfNkhhnq0bp8O3jcJoLbPec+SRkI6dc2KfG1rTVQNqVATz2JdVth3cK?=
 =?us-ascii?Q?2o3CN6DG1EResZZI0E3Geeck9RDh8k+X15Ni2Ecci1yFBAdQawWL0sSz4dmL?=
 =?us-ascii?Q?jk9Q3FVRXE4kgtS++Xvh08UZwIZSsWY6OsAADAWff0QdmnGTn3bMmm4iScwM?=
 =?us-ascii?Q?voHJkPtaiMhcuGtzEBQjivnvHGjzJ42NziQnTPlOc5AbZs8UxyDClWRo6CL1?=
 =?us-ascii?Q?4TaJp50o6mC6OdViQ1pQuK0ESyk4geNAXKTtx2fw5T53i4jdE2WiA3vB8wBj?=
 =?us-ascii?Q?IyDZ/TL2ofVdZUP5JUAc1f6JvEw9lF9A+NzmYfOPk25oTqIGQAY/krIgLOwi?=
 =?us-ascii?Q?PuRvDHSpSBiRHldkG972GKLtGoaMMMbw/kN8+/8gpc0wAfGgj2SR0emb9PH+?=
 =?us-ascii?Q?AW3xozHSez/zE6sAPN5hC1uEfLMUkXqwZIvi0lE9GlXCBxkTqRNXot77M92B?=
 =?us-ascii?Q?iyrYtcczgSiDXYq+pbBMwEESm7LFqD0UwAQA58j7GAlbRPXS7qie10/basjH?=
 =?us-ascii?Q?V8qC6/BKS4FgmMmgzBz/J9iZXd3v6za/yKjbmqbAsW0CFFi01IteUwVy3FO4?=
 =?us-ascii?Q?QqTNCnAbJe3KNIYXupFnFhIAhIizr0vduQgwQYx8UnQT3C3J+EXTNEoOSQZm?=
 =?us-ascii?Q?12B7Ea0quKrWxq9ujylE6fqcMoinmeJLol4DGuxp+XA/XevuCmoojbstYYHE?=
 =?us-ascii?Q?zTtvwo/dBnMSb3MXUpbg4Ua0goO+goyEEM5tygYrHqGUOsHwU/0gXwBxkFYK?=
 =?us-ascii?Q?lchO2yZ6D0Jg19jO1v1IQ8Ik7ycbU0Xd3ggSfL+/un5zSR1jU3XiTSl8whpp?=
 =?us-ascii?Q?9iqJDnV/3UOB2Qxj5Eq4zqaQoquQ1Mu4me8yzwaoWVMwMd26MjB6J0tDi6s1?=
 =?us-ascii?Q?RB+YGrkpY29Zr9atckYNQfEQzp+q9Q2W34BeDAtLaqc2yNKX60UhIxAxgkh0?=
 =?us-ascii?Q?73pB5a61LnmpHfet/aia2wFQSOh08Ust93E6qBb2D6aRk9kvpYOPaxvbJWBN?=
 =?us-ascii?Q?XBs5VSfBkF3Ski1jrxybTkyfhRYm04Wv/4O/cISDudttPFymL8hdn0MDppol?=
 =?us-ascii?Q?hhtAKROm66MoLHGQ0zPR75MHkB+9AiMxkfBxqCAJo2mAZWC0+G4/C8IsLAxF?=
 =?us-ascii?Q?ZMIP8MwQmeWCobOCwUKf9ejNrsM3fGE1KD4tDJlNtbhNGG+Iz8b5OUJsdnY8?=
 =?us-ascii?Q?SR+G45PhHidpM3gTNs1pZuELenoVlAvhEvPXWHBPW7scI7OwawWfir2ZbM3F?=
 =?us-ascii?Q?LIPHhL8dXDe9pdyZb0hwtWQNMMGE/yXUADNRNeHK5L2jeDlVTXd42y7Y4Ky1?=
 =?us-ascii?Q?Abjv3ZDzcYDPLvoNFqh7mpthKofwZJQLROKeJ2dixo0BRo1AnGUI1tgG6X4a?=
 =?us-ascii?Q?m34ZsUzm6y94Jl+IvPTks6YyEcrg1bywyy05bfUq8Mf1+EIcAN8b7+4Sw1ut?=
 =?us-ascii?Q?j88yYiydk92jlxgxWuiC7d5+JzLj5ZI=3D?=
X-Exchange-RoutingPolicyChecked: Bv6koV5rSw0+Xt/iS3jVwUd5nNkRaRw3sliwj7K+hHOHTl4ebIWKJWdsxhTIIdDNPMWcE3p3ZYnBk2i+zlAI+SOJSQtflfZH+U422b4mV7VIBdXYhWye7lBUtXHrRMAyNa8QUXy4FDkQwcyBDv/yYDaUYR5mk7Lld+8FrPMVfMO928vHgfWCU3kpRx274c2fPc/LlsQe9HDORxA64Ptp4gTBaE3ETZa9+AVjE8fvjdD9DKDQdFdkaJgFklQWK0DvanqDyHvoY4ITLSgMirSEz0nhLOWiqXkPguwg/YEDchJ9oo+7t+4/9S92u7NOxuf4LJxYAl2vTKWi5chUOo2Ojg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bdd9ee6-52fc-4faa-9834-08df2f543a5b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 09:18:11.4693 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jl40PNeTJ3Te+ktSIxGO+2dl/iucs5YgPUk3498z5d0Q5RsHglDfm4j6sEpa3YVVCReFb4hqgJ7b2pPz+fM8oIMYICF1qbvRubHNWRmnVSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6483
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20, 2026 at 01:11:06PM +0100, Anatoly Burakov wrote:
> VOID handling differs between pattern matching and engine parsing.
> Pattern matching relies on a temporary copy with VOID items removed,
> while engines handle them independently. This temporary copy makes memory
> management complicated, so we want to get rid of it.
> 
> However, before we can do that, we first need to standardize traversal of
> the pattern so that all engines can skip over VOID items. Add shared
> helpers to skip VOID items and iterate over non-VOID items, and use them
> in pattern matching and all engines; also use them for item counting,
> lookahead and RAW item lookup.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---

This loop macro looks a very nice cleanup.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

>  drivers/net/intel/ice/ice_acl_filter.c    |  4 +---
>  drivers/net/intel/ice/ice_fdir_filter.c   |  8 +++-----
>  drivers/net/intel/ice/ice_generic_flow.c  | 11 +++++------
>  drivers/net/intel/ice/ice_generic_flow.h  | 14 ++++++++++++++
>  drivers/net/intel/ice/ice_hash.c          |  6 ++++--
>  drivers/net/intel/ice/ice_switch_filter.c |  8 ++------
>  6 files changed, 29 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/net/intel/ice/ice_acl_filter.c b/drivers/net/intel/ice/ice_acl_filter.c
> index eb5d88ccc5..91f684c9b9 100644
> --- a/drivers/net/intel/ice/ice_acl_filter.c
> +++ b/drivers/net/intel/ice/ice_acl_filter.c
> @@ -664,7 +664,7 @@ ice_acl_parse_pattern(__rte_unused struct ice_adapter *ad,
>  	uint64_t input_set = ICE_INSET_NONE;
>  	uint8_t flow_type = ICE_FLTR_PTYPE_NONF_NONE;
>  
> -	for (item = pattern; item->type != RTE_FLOW_ITEM_TYPE_END; item++) {
> +	ICE_FLOW_FOREACH_ITEM(item, pattern) {
>  		item_type = item->type;
>  
>  		switch (item_type) {
> @@ -897,8 +897,6 @@ ice_acl_parse_pattern(__rte_unused struct ice_adapter *ad,
>  				}
>  			}
>  			break;
> -		case RTE_FLOW_ITEM_TYPE_VOID:
> -			break;
>  		default:
>  			rte_flow_error_set(error, EINVAL,
>  				RTE_FLOW_ERROR_TYPE_ITEM,
> diff --git a/drivers/net/intel/ice/ice_fdir_filter.c b/drivers/net/intel/ice/ice_fdir_filter.c
> index 63a0d9fb1f..b1a8753e90 100644
> --- a/drivers/net/intel/ice/ice_fdir_filter.c
> +++ b/drivers/net/intel/ice/ice_fdir_filter.c
> @@ -1904,7 +1904,7 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
>  	struct ice_parser_result rslt;
>  	uint8_t item_num = 0;
>  
> -	for (item = pattern; item->type != RTE_FLOW_ITEM_TYPE_END; item++) {
> +	ICE_FLOW_FOREACH_ITEM(item, pattern) {
>  		if (item->type == RTE_FLOW_ITEM_TYPE_VXLAN)
>  			tunnel_type = ICE_FDIR_TUNNEL_TYPE_VXLAN;
>  		if (item->type == RTE_FLOW_ITEM_TYPE_L2TPV2)
> @@ -1922,7 +1922,7 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
>  	/* This loop parse flow pattern and distinguish Non-tunnel and tunnel
>  	 * flow. input_set_i is used for inner part.
>  	 */
> -	for (item = pattern; item->type != RTE_FLOW_ITEM_TYPE_END; item++) {
> +	ICE_FLOW_FOREACH_ITEM(item, pattern) {
>  		item_type = item->type;
>  
>  		if (item->last && !(item_type == RTE_FLOW_ITEM_TYPE_IPV4 ||
> @@ -2065,7 +2065,7 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
>  			if (!rte_is_zero_ether_addr(&eth_mask->hdr.src_addr))
>  				*input_set |= ICE_INSET_SMAC;
>  
> -			next_type = (item + 1)->type;
> +			next_type = ice_pattern_skip_void(item + 1)->type;
>  			/* Ignore this field except for ICE_FLTR_PTYPE_NON_IP_L2 */
>  			if (eth_mask->hdr.ether_type == RTE_BE16(0xffff) &&
>  			    next_type == RTE_FLOW_ITEM_TYPE_END) {
> @@ -2471,8 +2471,6 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
>  				p_v6->src_port = sctp_spec->hdr.src_port;
>  			}
>  			break;
> -		case RTE_FLOW_ITEM_TYPE_VOID:
> -			break;
>  		case RTE_FLOW_ITEM_TYPE_VXLAN:
>  			l3 = RTE_FLOW_ITEM_TYPE_END;
>  			vxlan_spec = item->spec;
> diff --git a/drivers/net/intel/ice/ice_generic_flow.c b/drivers/net/intel/ice/ice_generic_flow.c
> index 76b3800545..fee048e456 100644
> --- a/drivers/net/intel/ice/ice_generic_flow.c
> +++ b/drivers/net/intel/ice/ice_generic_flow.c
> @@ -2109,16 +2109,15 @@ static bool
>  ice_match_pattern(enum rte_flow_item_type *item_array,
>  		const struct rte_flow_item *pattern)
>  {
> -	const struct rte_flow_item *item = pattern;
> +	const struct rte_flow_item *item;
>  
> -	while ((*item_array == item->type) &&
> -	       (*item_array != RTE_FLOW_ITEM_TYPE_END)) {
> +	ICE_FLOW_FOREACH_ITEM(item, pattern) {
> +		if (*item_array != item->type)
> +			return false;
>  		item_array++;
> -		item++;
>  	}
>  
> -	return (*item_array == RTE_FLOW_ITEM_TYPE_END &&
> -		item->type == RTE_FLOW_ITEM_TYPE_END);
> +	return *item_array == RTE_FLOW_ITEM_TYPE_END;
>  }
>  
>  struct ice_ptype_match {
> diff --git a/drivers/net/intel/ice/ice_generic_flow.h b/drivers/net/intel/ice/ice_generic_flow.h
> index 650b43633f..983f86a5ab 100644
> --- a/drivers/net/intel/ice/ice_generic_flow.h
> +++ b/drivers/net/intel/ice/ice_generic_flow.h
> @@ -569,6 +569,20 @@ struct ice_flow_parser_node {
>  void ice_register_flow_engine(struct ice_flow_engine *engine);
>  int ice_flow_init(struct ice_adapter *ad);
>  void ice_flow_uninit(struct ice_adapter *ad);
> +
> +static inline const struct rte_flow_item *
> +ice_pattern_skip_void(const struct rte_flow_item *item)
> +{
> +	while (item->type == RTE_FLOW_ITEM_TYPE_VOID)
> +		item++;
> +	return item;
> +}
> +
> +#define ICE_FLOW_FOREACH_ITEM(item, pattern) \
> +	for ((item) = ice_pattern_skip_void(pattern); \
> +	     (item)->type != RTE_FLOW_ITEM_TYPE_END; \
> +	     (item) = ice_pattern_skip_void((item) + 1))
> +
>  struct ice_pattern_match_item *
>  ice_search_pattern_match_item(struct ice_adapter *ad,
>  			      const struct rte_flow_item pattern[],
> diff --git a/drivers/net/intel/ice/ice_hash.c b/drivers/net/intel/ice/ice_hash.c
> index 7a9a4f1a04..13bedfe90c 100644
> --- a/drivers/net/intel/ice/ice_hash.c
> +++ b/drivers/net/intel/ice/ice_hash.c
> @@ -624,7 +624,7 @@ ice_hash_parse_pattern(const struct rte_flow_item pattern[], uint64_t *phint,
>  	const struct rte_flow_item *item = pattern;
>  	const struct rte_flow_item_gtp_psc *psc;
>  
> -	for (item = pattern; item->type != RTE_FLOW_ITEM_TYPE_END; item++) {
> +	ICE_FLOW_FOREACH_ITEM(item, pattern) {
>  		if (item->last) {
>  			rte_flow_error_set(error, EINVAL,
>  					RTE_FLOW_ERROR_TYPE_ITEM, item,
> @@ -1235,8 +1235,10 @@ ice_hash_parse_pattern_action(__rte_unused struct ice_adapter *ad,
>  		goto error;
>  
>  	if (phint == ICE_PHINT_RAW) {
> +		const struct rte_flow_item *raw_item = ice_pattern_skip_void(pattern);
> +
>  		rss_meta_ptr->raw.raw_ena = true;
> -		ret = ice_hash_parse_raw_pattern(ad, pattern, error, rss_meta_ptr);
> +		ret = ice_hash_parse_raw_pattern(ad, raw_item, error, rss_meta_ptr);
>  		if (ret) {
>  			rte_flow_error_set(error, EINVAL,
>  					   RTE_FLOW_ERROR_TYPE_ITEM, NULL,
> diff --git a/drivers/net/intel/ice/ice_switch_filter.c b/drivers/net/intel/ice/ice_switch_filter.c
> index 6f5af03f6a..6bc1bdd09f 100644
> --- a/drivers/net/intel/ice/ice_switch_filter.c
> +++ b/drivers/net/intel/ice/ice_switch_filter.c
> @@ -489,8 +489,7 @@ ice_switch_parse_pattern(const struct rte_flow_item pattern[],
>  	    *tun_type == ICE_NON_TUN_QINQ)
>  		qinq_valid = 1;
>  
> -	for (item = pattern; item->type !=
> -			RTE_FLOW_ITEM_TYPE_END; item++) {
> +	ICE_FLOW_FOREACH_ITEM(item, pattern) {
>  		if (item->last) {
>  			rte_flow_error_set(error, EINVAL,
>  					RTE_FLOW_ERROR_TYPE_ITEM,
> @@ -1378,9 +1377,6 @@ ice_switch_parse_pattern(const struct rte_flow_item pattern[],
>  			gtpu_psc_valid = 1;
>  			break;
>  
> -		case RTE_FLOW_ITEM_TYPE_VOID:
> -			break;
> -
>  		default:
>  			rte_flow_error_set(error, EINVAL,
>  				   RTE_FLOW_ERROR_TYPE_ITEM, pattern,
> @@ -1805,7 +1801,7 @@ ice_switch_parse_pattern_action(struct ice_adapter *ad,
>  		return -rte_errno;
>  	}
>  
> -	for (; item->type != RTE_FLOW_ITEM_TYPE_END; item++) {
> +	ICE_FLOW_FOREACH_ITEM(item, pattern) {
>  		item_num++;
>  		if (item->type == RTE_FLOW_ITEM_TYPE_ETH) {
>  			const struct rte_flow_item_eth *eth_mask;
> -- 
> 2.52.0
> 
