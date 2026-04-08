Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469C610F9940
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Apr 2026 15:20:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2DC3040269;
	Wed,  8 Apr 2026 17:20:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id EB8AE4013F
 for <dev@dpdk.org>; Wed,  8 Apr 2026 17:20:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775661657; x=1807197657;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=a4+y5MW/yR2nhwaJz+bjKMSRD+29F3pmWTcwJHytsUw=;
 b=fddpcioQixXCF8j0R/m5v24ez9Q1J5QIQ5G24ci4xYxWTbhOcYB1C5yU
 XX4RU5uHw9+67rTNclQSPcsSzbFzhUCORwP5CjWPa79lZKfSgQ34pzMeQ
 xqfeCzgF3sxBn/RKFK0+hwC4a21Wg0ZhOaiVxh1ls4ME05qNR6yKuoYzk
 0zW6Jt9VXI3l/3qrFl3NZIogc8DUCDSD1KwNQch4cpTuSHr0z2yD64wBt
 Ed+bC6/72OUtYxlL2WE5H2MSq1H5G5HeWXcmViY6YayFtChnqAVJUcOT8
 H+lqkDgOkP/f8NGyZdcoljG/QB75CRfi8KofyAIcFHK1Rkk0z0UljJQM6 g==;
X-CSE-ConnectionGUID: A2F+iSMPQRGHBVkTJykqtA==
X-CSE-MsgGUID: BzUEij3qRUSYg18861bEOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76662774"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="76662774"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 08:20:53 -0700
X-CSE-ConnectionGUID: 7QHehIeiSayDni5ML4ze3g==
X-CSE-MsgGUID: uhOG6R3LRAOWeDk04uMPyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="233374965"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 08:20:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 08:20:51 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 8 Apr 2026 08:20:51 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.51) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 08:20:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FzrurufQYbEQGLaAhAJxNyzAVEYgpSCGLIAUF/p7VTeUzutjXkOl1iBtwHSpPDXqILEKYs0u7YS44uJz91ke6ydw5pUlQAg25vDhAFp8QZSk5jP9pO2Qru3MIpGhjHuN4lTrn8xUb3F+mAVWQDk5F/AeBMnhYIp6NsCW0ylz+k4OacfLUiltwF12ttKfE6QJbuTSAUi3UHUurbz2lqW4onbfuLdhiKghRj2Ns9dr7hg84DJ7aXz+uuWbTon3Cr4uCa2USZQYSeacwBRHs3zXwcn032/mvS4/qkJfzYUOuYynQ+G/IzaYqCwvwfk1SLg+ZPiUy9Yr+eptrZPO0bd31Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijevA6rg5altNazNz2HVAveWjG208+v8CxQ0EEqeRZo=;
 b=TN8/lkFPRMpMdn56yv5bTw4jvC1gnpzVOVi+KfTrbixv/21b9EgsJJMaaoCC36pWZp6uuE3tgserFGe68vyJVAWiJl4bA5E3DhRDgbJOD9XKVvzeKZ+cnHPirrsbKsD0kuvsuDTMF7a4ckRPCcpN2mJ+wRm2FvKdeWis5SW0GHnYW5uJEDtaGB0E8kQPUm1tGnwv/NIRy37vtFUmMrMug2gCWSsxF6GInjg2ZmM/Ju1dr7ldVIkFt/gphUrHpFeJpZR4z12yXqwHGModNvoFtq794OSUIVAG3L5ywGqDJwBLzDv1IzzR6PMUQC0XNtQm0I6CZdV5T3ACDdlOlQMjZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PHXPR11MB9639.namprd11.prod.outlook.com (2603:10b6:510:3cb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Wed, 8 Apr
 2026 15:20:48 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9769.018; Wed, 8 Apr 2026
 15:20:48 +0000
Date: Wed, 8 Apr 2026 16:20:42 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Sushmita Hoskeri <sushmita.hoskeri@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>, Atul Patel
 <atul.patel@intel.com>
Subject: Re: [PATCH] net/cpfl: add LEM block support in CPFL PMD
Message-ID: <adZySiu2t-9IopUt@bricha3-mobl1.ger.corp.intel.com>
References: <20260217012153.36545-1-sushmita.hoskeri@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260217012153.36545-1-sushmita.hoskeri@intel.com>
X-ClientProxiedBy: DU7P190CA0018.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PHXPR11MB9639:EE_
X-MS-Office365-Filtering-Correlation-Id: c1afbf33-dbcd-4f95-b251-08de9582697e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: annu3uu9jen2MFmlIjatRgjNGIYerYi1X+3m0kuDIAbtY9aM7S6LEaAhI9gbE9QJKf49mUOWGk+gHv7C507Mfb+if26yXLuradfmonumlbaewxFPneq0DP90XROrUAJrq/4TSM3XzVPtiOmVGi0Rbgi1zCTnS0ql/jynBJ2qDtyewsGq7HLeS+sPzu0JCkAIIObh98wW4H0FyoX0BCfoYtbzg8OornkpBzSkIpDOQRHTLewNkd2dcF6cTX0HqNVTzn8Z+OL515TA1wY15bEdefAjrO6LG28mHZC14XoxljSBsy/njsXGqtu0Xn+B7FTHynddUTlU3xTyuPfdMY2Qu3CFhl9hrlLzb+FIfUNs7K6iKVsSRcpxvsMx1we85iHjiNTM7vPI0Z00jkaIKJMDmDLYhX0iMUMyz865fo4EWaDq8bzgMfOljd0dobnuGUhIqFYV0aVJgcHDqm+eSTQZ/VJWiEuv60KsqoGBFXhNg/snmott/PILaWnKpmT/Q0aL3Uz98VC5kwJZu0nf5gX81mAyVbRV/f1eoNXszrVW9Ga+sumz/2sFDvNYr7oDF0xDBugvTt388gmeNeCBiWG3OxVn5LMXb8LKx0BsCET4o+nD6JuNgV8PHFH2n2AzdyKRpRByoksdll3ZW3wj/QHFLtfAAsUeOoGowx+Xuqmtj5N7UjVMSW5VDrMuxDNg/GKShlgxmNaN9qOtATkoJI+dT545VgN1oXQmbbOCxs/BIBA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZbSANfgbWPqtQc5KWJStHILCxwQcH+Vi0WDu1YJO1yqrjkwta2pK/E4WZldp?=
 =?us-ascii?Q?Gxh59djjPeFxPME8YDOh6nHVi6ZO7HAaf5/CXGYV7wUAnyn1vMFnUC6jvQ9i?=
 =?us-ascii?Q?ET9BedqCvYRAXyNVtws1J2OPcsyg2WPQFVNWY96wSCwxFV+UAqIenqjpIHAn?=
 =?us-ascii?Q?0THFvVrsU6s1uBKTEqvnkjxJ8ciEu38+Qoa6rGL0M7CaSgsovIGiqOsQ6Dej?=
 =?us-ascii?Q?jAhRdz0DwWj8Zj+ypYV0s/P7t2YfV87h7/HNkk7VQMpCdVv8kIsGYpFqrFVv?=
 =?us-ascii?Q?luuK3nJd8R6SKDaA2bUB9QTUbP0snipDJaHWQAXiFkQttLzidvX2a7Xjz7B7?=
 =?us-ascii?Q?Q9QX6ilYGa/gVxgAl+XAImRJ1v5oxPHBttyHyfL/7OIZNEcmeE8vTrmA93kb?=
 =?us-ascii?Q?NsQihEE2qc/vDpJJ3yX1FfOQlP6R2wNfIf5IRp2Um/zypOT6jj4zEfEluzzp?=
 =?us-ascii?Q?nxq/vsKu7AvpvRzQhoSzNKSZFDx4n1mkVUOSjyCOJfMA+JyxLz9II/dAvJGn?=
 =?us-ascii?Q?aqbp5e/QocZehXvNYT6WEvaR5OHTHnJB+HLZcRAGZKo/x2YVCGs8r4Bi1EAL?=
 =?us-ascii?Q?8KKJREg3h8vVeGfsuWgi6wG65I8uNhN9Wp5rEjcgB2YKcjgVIh0CJBMb2Ruc?=
 =?us-ascii?Q?+qGuSlqbZQe0lQBKeFhCGyNoAiAMuNsW2urNu2J/lnE/I6nH9uSQX3nrnpnR?=
 =?us-ascii?Q?2qt3OFW95RWVGAjfYAFK/xVEm/+Er4cyyP05F5QiYlk7zZBPfB8mnlBTN4IB?=
 =?us-ascii?Q?UU4N7QvTPOuD6c8Cm9w5efntJyvh+LHYCOX6YhTfg9COO0wNxouuTlcOW54t?=
 =?us-ascii?Q?6U53HWOQ6RRluTa60U5SD99AupkXe5HJhZm14uMFtz4jrnw8HHfY241tRAKr?=
 =?us-ascii?Q?2Np3HpFY9duxZ7ZY9dlec27HUrBDLMFkyVv6lcyManCdbiqdJj9iAO3cz2Q8?=
 =?us-ascii?Q?nOeup422EyAJw+47OZekupDw5SH0a3OrR+qQCX0iJFzMvpYkzxxgKsjic1yr?=
 =?us-ascii?Q?I8eNpNkjSSOmabog04H9UN1VDnxW+9W1vu7MxQA1XyS9ZbCWJjMteJxc1Qxo?=
 =?us-ascii?Q?FQu+xnMwple2TYSsbXqh/765Ko7UJHzYgq1V3uVEgJ4qkOP8+6t+IpornrJI?=
 =?us-ascii?Q?+crHzutE30xw5Z1sF1Uc9xnpeifZsQBRv8VKvmVSnSo46sZkRi3ETBU/Owpc?=
 =?us-ascii?Q?S16kcSBnYOYyV3QLAaTGM95nmYgKyvk7/x99bWHy79HEO0qY7/06pE/64goI?=
 =?us-ascii?Q?VpUqY7edkb17PJLg9BSirW0uzbTQ20N9Fbs44Lf6xxyMr6+axL9D1XyPzo3U?=
 =?us-ascii?Q?1ZGmL8sneDUvmP023w5TcL8f8x9qQ6z+EyzGgabPeDLWx/ChaaPuejCPcY7M?=
 =?us-ascii?Q?MwjYuKxwPh/7vv/PCPYW5JV+7PPJRr207nfvftF1fBbTdhSDKez35TPNQLKV?=
 =?us-ascii?Q?OMhnD1L0T13nQPZiX8cinxAp5F5eMgs+5+lSt49RzY3yFqUBo9vyrltlMpQ+?=
 =?us-ascii?Q?Is42WGldainFE4aVZdMPv+oZI2H+8pQh3QDPBmajwgn7tSiEkE0Sm9BvIap+?=
 =?us-ascii?Q?U5ATiefIBstWXzsF9zGNoFa5BBo+5fSYUE2uGll+72DHtZBqVVltQ4as25JQ?=
 =?us-ascii?Q?Xldd/fPsvoItqa09UBf3T9x6fwQsWGqgNjw3fGxQK52hNRTvTkxxPgdenMdd?=
 =?us-ascii?Q?T/2+1jpHQ6PXAKur17hhLHJ/vrTY6qEKn1lweapfu0T0n3EyaWiWfbgqdM8v?=
 =?us-ascii?Q?l+i4ghx+0xEmmwhiN8Z5/T/iu+s3Obg=3D?=
X-Exchange-RoutingPolicyChecked: iocrkAB+V/8qks4G5oYtUig/TeYumpoRXU/UiCAAamt5zDq+5bVg/sN4GQAGIuzTTIfIRDlQJW5ppMTdl/8U9wi4V7T4P33qvMYbpFj2ZCXV1nLiE1dfDAO5l7wCreQa++C1x7SdpNkm3wn56ADoDQL1ik4ZVsNN8SXXsiJ8D5M21Xw6bTc2NqHE6UctV90+ulZ1IQOxOb0sdKcZ1yUsOgcIvz+y3EwUqp7tialRF+nSBmYfA/3badnYOia9GdEHAhAMhJUAWdnWsUVdK9UOWKmfh6x02wWge2MGWZDZVGy0OZ6V4ZBdnRdOUXQKVycPzosKgZtTJSe/I8IPM2KMpg==
X-MS-Exchange-CrossTenant-Network-Message-Id: c1afbf33-dbcd-4f95-b251-08de9582697e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 15:20:48.7944 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nHKnlgxgtz7a4Z8O2OvoSBOkJqeQ7KmM42IROqTeVgJTAcqjgh3KjAiS8nzgDvZquQ8yBXGJpD3vCmpp77L7nGL0D8QlYEIReHgp2EgYmYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR11MB9639
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

On Tue, Feb 17, 2026 at 06:51:53AM +0530, Sushmita Hoskeri wrote:
> Added APIs to enable support for LEM block in CPFL PMD
>

It would be good to explain the LEM acronym in the commit message if you
are using it in the explanation.
 
> Signed-off-by: Sushmita Hoskeri <sushmita.hoskeri@intel.com>
> Signed-off-by: Atul Patel <atul.patel@intel.com>
> ---

Other comments inline below.

Thanks,
/Bruce

>  drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c | 11 +++
>  drivers/net/intel/cpfl/cpfl_flow_parser.c     | 87 +++++++++++++++++++
>  drivers/net/intel/cpfl/cpfl_flow_parser.h     | 18 ++++
>  drivers/net/intel/cpfl/cpfl_fxp_rule.c        | 11 ++-
>  drivers/net/intel/cpfl/cpfl_fxp_rule.h        | 10 +++
>  drivers/net/intel/cpfl/cpfl_rules.c           | 36 ++++++++
>  drivers/net/intel/cpfl/cpfl_rules.h           | 46 +++++++++-
>  7 files changed, 216 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c b/drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c
> index 361827cb10..20a047f57f 100644
> --- a/drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c
> +++ b/drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c
> @@ -41,6 +41,7 @@
>  #define CPFL_PORT_NUM_DEF	0
>  #define CPFL_RESP_REQ_DEF	2
>  #define CPFL_PIN_TO_CACHE_DEF	0
> +#define CPFL_PIN_TO_CACHE_CUST  1
>  #define CPFL_CLEAR_MIRROR_1ST_STATE_DEF	0
>  #define CPFL_FIXED_FETCH_DEF	0
>  #define CPFL_PTI_DEF		0
> @@ -180,6 +181,15 @@ cpfl_fxp_parse_pattern(const struct cpfl_flow_pr_action *pr_action,
>  		memcpy(rinfo->sem.key, pr_action->sem.cpfl_flow_pr_fv, rinfo->sem.key_byte_len);
>  		rinfo->sem.pin_to_cache = CPFL_PIN_TO_CACHE_DEF;
>  		rinfo->sem.fixed_fetch = CPFL_FIXED_FETCH_DEF;
> +	} else if (pr_action->type == CPFL_JS_PR_ACTION_TYPE_LEM) {
> +		struct cpfl_rule_info *rinfo = &rim->rules[i];
> +
> +		rinfo->type = CPFL_RULE_TYPE_LEM;
> +		rinfo->lem.prof_id = pr_action->lem.prof;
> +		rinfo->lem.key_byte_len = pr_action->lem.keysize;
> +		memcpy(rinfo->lem.key, pr_action->lem.cpfl_flow_pr_fv, rinfo->lem.key_byte_len);
> +		rinfo->lem.pin_to_cache = CPFL_PIN_TO_CACHE_CUST;
> +		rinfo->lem.fixed_fetch = CPFL_FIXED_FETCH_DEF;
>  	} else {
>  		PMD_DRV_LOG(ERR, "Invalid pattern item.");
>  		return false;
> @@ -427,6 +437,7 @@ cpfl_is_mod_action(const struct rte_flow_action actions[])
>  		switch (action_type) {
>  		case RTE_FLOW_ACTION_TYPE_VXLAN_ENCAP:
>  		case RTE_FLOW_ACTION_TYPE_VXLAN_DECAP:
> +		case RTE_FLOW_ACTION_TYPE_MODIFY_FIELD:

This change doesn't look relevant to the LEM block, but rather a globally
applicable one across all blocks, right? Consider adding it in a separate
patch.

>  		case RTE_FLOW_ACTION_TYPE_PROG:
>  			return true;
>  		default:
> diff --git a/drivers/net/intel/cpfl/cpfl_flow_parser.c b/drivers/net/intel/cpfl/cpfl_flow_parser.c
> index e7deb619ee..612f5083ac 100644
> --- a/drivers/net/intel/cpfl/cpfl_flow_parser.c
> +++ b/drivers/net/intel/cpfl/cpfl_flow_parser.c
> @@ -421,6 +421,56 @@ cpfl_flow_js_pattern_act_fv(json_t *ob_fvs, struct cpfl_flow_js_pr_action *js_ac
>  	return -EINVAL;
>  }
>  
> +static int
> +cpfl_flow_js_pattern_act_fv_lem(json_t *cjson_fv, struct cpfl_flow_js_pr_action *js_act)
> +{
> +	int len, i, ret;
> +
> +	len = json_array_size(cjson_fv);
> +	js_act->lem.fv = rte_malloc(NULL, sizeof(struct cpfl_flow_js_fv) * len, 0);
> +	if (!js_act->lem.fv) {
> +		PMD_DRV_LOG(ERR, "Failed to alloc memory.");
> +		return -ENOMEM;
> +	}
> +	js_act->lem.fv_size = len;
> +	for (i = 0; i < len; i++) {
> +		struct cpfl_flow_js_fv *js_fv;
> +		json_t *object, *cjson_value;
> +		const char *type;
> +
> +		object = json_array_get(cjson_fv, i);
> +		js_fv = &js_act->lem.fv[i];
> +		ret = cpfl_json_t_to_uint16(object, "offset", &js_fv->offset);
> +		if (ret < 0) {
> +			PMD_DRV_LOG(ERR, "Can not parse 'offset'.");
> +			return -EINVAL;
> +		}
> +		type = cpfl_json_t_to_string(object, "type");
> +		if (!type) {
> +			PMD_DRV_LOG(ERR, "Can not parse 'type'.");
> +			return -EINVAL;
> +		}
> +		cjson_value = json_object_get(object, "value");
> +		if (strcmp(type, "immediate") == 0) {
> +			js_fv->type = CPFL_FV_TYPE_IMMEDIATE;
> +			js_fv->immediate = json_integer_value(cjson_value);
> +		} else if (strcmp(type, "metadata") == 0) {
> +			js_fv->type = CPFL_FV_TYPE_METADATA;
> +			cpfl_flow_js_pattern_act_fv_metadata(cjson_value, js_fv);
> +		} else if (strcmp(type, "protocol") == 0) {
> +			js_fv->type = CPFL_FV_TYPE_PROTOCOL;
> +			cpfl_flow_js_pattern_act_fv_proto(cjson_value, js_fv);
> +		} else {
> +			PMD_DRV_LOG(ERR, "Not support this type: %s.", type);
> +			goto err;
> +		}
> +	}
> +	return 0;
> +err:
> +	rte_free(js_act->lem.fv);
> +	return -EINVAL;
> +}
> +
>  static int
>  cpfl_flow_js_pattern_per_act(json_t *ob_per_act, struct cpfl_flow_js_pr_action *js_act)
>  {
> @@ -458,6 +508,25 @@ cpfl_flow_js_pattern_per_act(json_t *ob_per_act, struct cpfl_flow_js_pr_action *
>  		ret = cpfl_flow_js_pattern_act_fv(ob_fvs, js_act);
>  		if (ret < 0)
>  			return ret;
> +	} else if (strcmp(type, "lem") == 0) {
> +		js_act->type = CPFL_JS_PR_ACTION_TYPE_LEM;
> +		json_t *cjson_fv, *ob_lem;
> +
> +		ob_lem = json_object_get(ob_per_act, "data");
> +		ret = cpfl_json_t_to_uint16(ob_lem, "profile", &js_act->lem.prof);
> +		if (ret < 0) {
> +			PMD_DRV_LOG(ERR, "Can not parse 'profile'.");
> +			return -EINVAL;
> +		}
> +		ret = cpfl_json_t_to_uint16(ob_lem, "keysize", &js_act->lem.keysize);
> +		if (ret < 0) {
> +			PMD_DRV_LOG(ERR, "Can not parse 'keysize'.");
> +			return -EINVAL;
> +		}
> +		cjson_fv = json_object_get(ob_lem, "fieldvectors");
> +		ret = cpfl_flow_js_pattern_act_fv_lem(cjson_fv, js_act);
> +		if (ret < 0)
> +			return ret;
>  	} else {
>  		PMD_DRV_LOG(ERR, "Not support this type: %s.", type);
>  		return -EINVAL;
> @@ -984,6 +1053,8 @@ cpfl_parser_free_pr_action(struct cpfl_flow_js_pr_action *pr_act)
>  {
>  	if (pr_act->type == CPFL_JS_PR_ACTION_TYPE_SEM)
>  		rte_free(pr_act->sem.fv);
> +	else if (pr_act->type == CPFL_JS_PR_ACTION_TYPE_LEM)
> +		rte_free(pr_act->lem.fv);
>  }
>  
>  int
> @@ -1149,6 +1220,19 @@ cpfl_parse_pr_actions(struct cpfl_itf *itf,
>  			ret = cpfl_parse_fieldvectors(itf, sem->fv, sem->fv_size,
>  						      pr_action->sem.cpfl_flow_pr_fv, items);
>  			return ret;
> +		} else if (attr->group % 10 == 4 && type == CPFL_JS_PR_ACTION_TYPE_LEM) {
> +			struct cpfl_flow_js_pr_action_lem *lem = &pr_act->lem;
> +
> +			pr_action->type = CPFL_JS_PR_ACTION_TYPE_LEM;
> +			pr_action->lem.prof = lem->prof;
> +			pr_action->lem.keysize = lem->keysize;
> +			memset(pr_action->lem.cpfl_flow_pr_fv, 0,
> +					sizeof(pr_action->lem.cpfl_flow_pr_fv));
> +			ret = cpfl_parse_fieldvectors(itf, lem->fv, lem->fv_size,
> +							  pr_action->lem.cpfl_flow_pr_fv, items);
> +			if (ret < 0)
> +				return ret;
> +			continue;
>  		} else if (attr->group > 4 || attr->group == 0) {
>  			return -EPERM;
>  		}
> @@ -1585,6 +1669,9 @@ cpfl_check_pattern_key_proto(struct cpfl_flow_js_pr_key_proto *protocols,
>  				return -EINVAL;
>  			}
>  			break;
> +		case RTE_FLOW_ITEM_TYPE_VLAN:
> +			j++;
> +			break;

This change too doesn't seem directly related to LEM block.

>  		default:
>  			PMD_DRV_LOG(ERR, "Not support this type: %d.", type);
>  			return -EPERM;
> diff --git a/drivers/net/intel/cpfl/cpfl_flow_parser.h b/drivers/net/intel/cpfl/cpfl_flow_parser.h
> index 23904e39f1..f865ae8282 100644
> --- a/drivers/net/intel/cpfl/cpfl_flow_parser.h
> +++ b/drivers/net/intel/cpfl/cpfl_flow_parser.h
> @@ -16,10 +16,12 @@
>  #define CPFL_JS_PROG_CONTENT_FIELD_NUM_MAX 64
>  #define CPFL_JS_PROG_CONSTANT_VALUE_NUM_MAX 8
>  #define CPFL_JS_PROG_PARAM_NUM_MAX 10
> +#define CPFL_JS_LEM_FV_KEY_NUM_MAX 32
>  
>  /* Pattern Rules Storage */
>  enum cpfl_flow_pr_action_type {
>  	CPFL_JS_PR_ACTION_TYPE_SEM,
> +	CPFL_JS_PR_ACTION_TYPE_LEM,
>  	CPFL_JS_PR_ACTION_TYPE_UNKNOWN = -1,
>  };
>  
> @@ -85,11 +87,19 @@ struct cpfl_flow_js_pr_action_sem {
>  	int fv_size;
>  };
>  
> +struct cpfl_flow_js_pr_action_lem {
> +	uint16_t prof;
> +	uint16_t keysize;
> +	struct cpfl_flow_js_fv *fv;
> +	int fv_size;
> +};
> +
>  /* define how to map current key to low level pipeline configuration */
>  struct cpfl_flow_js_pr_action {
>  	enum cpfl_flow_pr_action_type type;
>  	union {
>  		struct cpfl_flow_js_pr_action_sem sem;
> +		struct cpfl_flow_js_pr_action_lem lem;
>  	};
>  };
>  
> @@ -230,10 +240,18 @@ struct cpfl_flow_pr_action_sem {
>  	uint8_t cpfl_flow_pr_fv[CPFL_JS_SEM_FV_KEY_NUM_MAX];
>  };
>  
> +struct cpfl_flow_pr_action_lem {
> +	uint16_t prof;
> +	uint16_t keysize;
> +	uint8_t cpfl_flow_pr_fv[CPFL_JS_LEM_FV_KEY_NUM_MAX];
> +};
> +
> +
>  struct cpfl_flow_pr_action {
>  	enum cpfl_flow_pr_action_type type;
>  	union {
>  		struct cpfl_flow_pr_action_sem sem;
> +		struct cpfl_flow_pr_action_lem lem;
>  	};
>  };
>  
> diff --git a/drivers/net/intel/cpfl/cpfl_fxp_rule.c b/drivers/net/intel/cpfl/cpfl_fxp_rule.c
> index 42553c9641..b4efbaa4ff 100644
> --- a/drivers/net/intel/cpfl/cpfl_fxp_rule.c
> +++ b/drivers/net/intel/cpfl/cpfl_fxp_rule.c
> @@ -25,7 +25,6 @@ cpfl_send_ctlq_msg(struct idpf_hw *hw, struct idpf_ctlq_info *cq, u16 num_q_msg,
>  		ret = -ENOMEM;
>  		goto err;
>  	}
> -

You probably should keep this blank line unless there is a good reason to
omit it. That drops this whole hunk from the diff, so I suspect this is an
accidental change.

>  	ret = cpfl_vport_ctlq_send(hw, cq, num_q_msg, q_msg);
>  	if (ret) {
>  		PMD_INIT_LOG(ERR, "cpfl_vport_ctlq_send() failed with error: 0x%4x", ret);
> @@ -192,6 +191,14 @@ cpfl_default_rule_pack(struct cpfl_rule_info *rinfo, struct idpf_dma_mem *dma,
>  					rinfo->act_bytes, rinfo->act_byte_len,
>  					cfg_ctrl, blob);
>  		opc = add ? cpfl_ctlq_sem_add_rule : cpfl_ctlq_sem_del_rule;
> +	} else if (rinfo->type == CPFL_RULE_TYPE_LEM) {
> +		cfg_ctrl = CPFL_GET_MEV_LEM_RULE_CFG_CTRL(rinfo->lem.prof_id,
> +							  rinfo->lem.pin_to_cache,
> +							  rinfo->clear_mirror_1st_state);
> +		cpfl_prep_lem_rule_blob(rinfo->lem.key, rinfo->lem.key_byte_len,
> +					rinfo->act_bytes, rinfo->act_byte_len,
> +					cfg_ctrl, blob);
> +		opc = add ? cpfl_ctlq_lem_add_update_rule : cpfl_ctlq_lem_del_rule;
>  	} else {
>  		PMD_INIT_LOG(ERR, "not support %d rule.", rinfo->type);
>  		return -1;
> @@ -219,7 +226,7 @@ cpfl_rule_pack(struct cpfl_rule_info *rinfo, struct idpf_dma_mem *dma,
>  {
>  	int ret = 0;
>  
> -	if (rinfo->type == CPFL_RULE_TYPE_SEM) {
> +	if (rinfo->type == CPFL_RULE_TYPE_SEM || rinfo->type == CPFL_RULE_TYPE_LEM) {
>  		if (cpfl_default_rule_pack(rinfo, dma, msg, add) < 0)
>  			ret = -1;
>  	} else if (rinfo->type == CPFL_RULE_TYPE_MOD) {
> diff --git a/drivers/net/intel/cpfl/cpfl_fxp_rule.h b/drivers/net/intel/cpfl/cpfl_fxp_rule.h
> index 94eab6808c..544f441025 100644
> --- a/drivers/net/intel/cpfl/cpfl_fxp_rule.h
> +++ b/drivers/net/intel/cpfl/cpfl_fxp_rule.h
> @@ -28,9 +28,18 @@ struct cpfl_mod_rule_info {
>  	uint8_t mod_obj_size;
>  };
>  
> +struct cpfl_lem_rule_info {
> +	uint16_t prof_id;
> +	uint8_t key[CPFL_MAX_KEY_LEN];
> +	uint8_t key_byte_len;
> +	uint8_t pin_to_cache;
> +	uint8_t fixed_fetch;
> +};
> +
>  enum cpfl_rule_type {
>  	CPFL_RULE_TYPE_NONE,
>  	CPFL_RULE_TYPE_SEM,
> +	CPFL_RULE_TYPE_LEM,
>  	CPFL_RULE_TYPE_MOD
>  };
>  
> @@ -50,6 +59,7 @@ struct cpfl_rule_info {
>  	union {
>  		struct cpfl_mod_rule_info mod;
>  		struct cpfl_sem_rule_info sem;
> +		struct cpfl_lem_rule_info lem;
>  	};
>  };
>  
> diff --git a/drivers/net/intel/cpfl/cpfl_rules.c b/drivers/net/intel/cpfl/cpfl_rules.c
> index 6c0e435b1d..ec636fdf4b 100644
> --- a/drivers/net/intel/cpfl/cpfl_rules.c
> +++ b/drivers/net/intel/cpfl/cpfl_rules.c
> @@ -18,6 +18,14 @@ cpfl_prep_rule_desc_common_ctx(struct cpfl_rule_cfg_data_common *cmn_cfg)
>  	case cpfl_ctlq_mod_query_rule:
>  	case cpfl_ctlq_mod_add_update_rule:
>  		/* fallthrough */
> +	case cpfl_ctlq_lem_del_rule:
> +	case cpfl_ctlq_lem_query_rule:
> +	case cpfl_ctlq_lem_add_update_rule:
> +	case cpfl_ctlq_lem_query_rule_hash_addr:
> +	case cpfl_ctlq_lem_query_del_rule_hash_addr:
> +		context |= SHIFT_VAL64(cmn_cfg->vsi_id,
> +				       MEV_RULE_VSI_ID);
> +		/* fallthrough */
>  	case cpfl_ctlq_sem_query_rule_hash_addr:
>  	case cpfl_ctlq_sem_query_del_rule_hash_addr:
>  	case cpfl_ctlq_sem_add_rule:
> @@ -66,6 +74,8 @@ cpfl_prep_rule_desc_ctx(struct cpfl_rule_cfg_data *cfg_data)
>  		break;
>  	case cpfl_ctlq_sem_query_rule_hash_addr:
>  	case cpfl_ctlq_sem_query_del_rule_hash_addr:
> +	case cpfl_ctlq_lem_query_rule_hash_addr:
> +	case cpfl_ctlq_lem_query_del_rule_hash_addr:
>  		context |= SHIFT_VAL64(cfg_data->ext.query_del_addr.obj_id,
>  				       MEV_RULE_OBJ_ID);
>  		context |= SHIFT_VAL64(cfg_data->ext.query_del_addr.obj_addr,
> @@ -124,3 +134,29 @@ cpfl_prep_sem_rule_blob(const uint8_t *key,
>  	rule_blob->sem_rule.cfg_ctrl[0] = cfg_ctrl & 0xFF;
>  	rule_blob->sem_rule.cfg_ctrl[1] = (cfg_ctrl >> 8) & 0xFF;
>  }
> +
> +/**
> + * cpfl_prep_lem_rule_blob - build LEM rule blob data from rule entry info
> + * note: call this function before sending rule to HW via fast path
> + */
> +void
> +cpfl_prep_lem_rule_blob(uint8_t *key,
> +			uint8_t key_byte_len,
> +			uint8_t *act_bytes,
> +			uint8_t act_byte_len,
> +			uint16_t cfg_ctrl,
> +			union cpfl_rule_cfg_pkt_record *rule_blob)
> +{
> +	uint32_t *act_dst = (uint32_t *)&rule_blob->lem_rule.actions;
> +	uint32_t *act_src = (uint32_t *)act_bytes;
> +	uint32_t i;
> +
> +	idpf_memset(rule_blob, 0, sizeof(*rule_blob), IDPF_DMA_MEM);
> +	memcpy(rule_blob->lem_rule.key, key, key_byte_len);
> +
> +	for (i = 0; i < act_byte_len / sizeof(uint32_t); i++)
> +		*act_dst++ = CPU_TO_LE32(*act_src++);
> +
> +	rule_blob->lem_rule.cfg_ctrl[0] = cfg_ctrl & 0xFF;
> +	rule_blob->lem_rule.cfg_ctrl[1] = (cfg_ctrl >> 8) & 0xFF;
> +}
> diff --git a/drivers/net/intel/cpfl/cpfl_rules.h b/drivers/net/intel/cpfl/cpfl_rules.h
> index 10569b1fdc..2b65c7ecc8 100644
> --- a/drivers/net/intel/cpfl/cpfl_rules.h
> +++ b/drivers/net/intel/cpfl/cpfl_rules.h
> @@ -46,6 +46,12 @@ enum cpfl_ctlq_rule_cfg_opc {
>  	cpfl_ctlq_sem_query_rule_hash_addr		= 0x1307,
>  	cpfl_ctlq_sem_query_del_rule_hash_addr		= 0x1308,
>  
> +	cpfl_ctlq_lem_add_update_rule			= 0x1343,
> +	cpfl_ctlq_lem_del_rule					= 0x1345,
> +	cpfl_ctlq_lem_query_rule				= 0x1346,
> +	cpfl_ctlq_lem_query_rule_hash_addr		= 0x1347,
> +	cpfl_ctlq_lem_query_del_rule_hash_addr	= 0x1348,
> +
>  	cpfl_ctlq_mod_add_update_rule			= 0x1360,
>  	cpfl_ctlq_mod_query_rule			= 0x1361,
>  };
> @@ -188,11 +194,43 @@ struct cpfl_sem_rule_cfg_pkt {
>  	uint8_t padding[46];
>  };
>  
> +/**
> + * struct cpfl_lem_rule_cfg_pkt - Describes rule information for LEM
> + * note: The key may be in mixed big/little endian format, the rest of members
> + * are in little endian
> + */
> +struct cpfl_lem_rule_cfg_pkt {
> +#define MEV_LEM_RULE_KEY_SIZE 128
> +	uint8_t key[MEV_LEM_RULE_KEY_SIZE];
> +
> +#define MEV_LEM_RULE_ACT_SIZE	48
> +	uint8_t actions[MEV_LEM_RULE_ACT_SIZE];
> +	/* Bit(s):
> +	 * 10:0 : PROFILE_ID
> +	 * 12:11: Reserved
> +	 * 13   : pin the LEM key content into the cache
> +	 * 14   : if set, clear mirror first state for first index in actions
> +	 * 15   : Reserved.
> +	 */
> +	uint8_t cfg_ctrl[2];
> +	/* Bit(s):
> +	 * 0:     valid
> +	 * 15:1:  Hints
> +	 * 26:16: PROFILE_ID, the profile associated with the entry
> +	 * 31:27: PF
> +	 * 55:32: FLOW ID (assigned by HW)
> +	 * 63:56: EPOCH
> +	 */
> +	uint8_t ctrl_word[8];
> +	uint8_t padding[70];
> +};
> +
>  /**
>   * union cpfl_rule_cfg_pkt_record - Describes rule data blob
>   */
>  union cpfl_rule_cfg_pkt_record {
>  	struct cpfl_sem_rule_cfg_pkt sem_rule;
> +	struct cpfl_lem_rule_cfg_pkt lem_rule;
>  	uint8_t pkt_data[256];
>  	uint8_t mod_blob[256];
>  };
> @@ -313,5 +351,11 @@ cpfl_prep_sem_rule_blob(const uint8_t *key,
>  			uint8_t act_byte_len,
>  			uint16_t cfg_ctrl,
>  			union cpfl_rule_cfg_pkt_record *rule_blob);
> -
> +void
> +cpfl_prep_lem_rule_blob(uint8_t *key,
> +			uint8_t key_byte_len,
> +			uint8_t *act_bytes,
> +			uint8_t act_byte_len,
> +			uint16_t cfg_ctrl,
> +			union cpfl_rule_cfg_pkt_record *rule_blob);
>  #endif /* _CPFL_RULES_API_H_ */
> -- 
> 2.34.1
> 
