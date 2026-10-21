Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87D2606A319
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 10:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=esH6AfbA
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D8BF4069F;
	Wed, 21 Oct 2026 12:23:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 7EB0740041
 for <dev@dpdk.org>; Wed, 21 Oct 2026 12:23:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792578205; x=1824114205;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=WUDrmkbZOf6PIXAyv4aM7wzJNDFekBeJnGFjg4YoeWc=;
 b=esH6AfbAGaTwBH1mKvGfI/bWG5JO2hJssTQmClOGZhREwrNnsDvTpom9
 vI5+sSjdYVsoHbEUjNpDA5FlZh0ZesXVPK/7k3BHHns9hrpS+mHtAimqX
 xDMC+Br1dyry3teiS+emCSdpphb02GONs1cR+NOJwui6Y3i63NUiSLfnm
 D+NtdhKSAms/wvawvbhM7a6nqcTDAeTkqJ67ikLuBF/WIW779Sk6P/zsD
 L30uRVGAz45mxGj/K1Fxp+nKwELhT0Lt8qI7DfStPJ8BN4d4ttL/Bkl47
 ofmMkYZWEtrGsF8t6IlBuzHIMBVvgXIlMHBxWBL8DWlGwsf1GvXkAtpH6 A==;
X-CSE-ConnectionGUID: g8eHV5b6Rp+tOZwVXv0AfA==
X-CSE-MsgGUID: ndvf1BSTRr6uPrFSLUnPUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1197871"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1197871"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:23:24 -0700
X-CSE-ConnectionGUID: bjUE0vS/Tv+x2HX3t6ukFQ==
X-CSE-MsgGUID: cHOnbvD7SE2yPCDU9sAeDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="2997165"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:23:23 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 03:23:22 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 03:23:22 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.6) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 03:23:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQ3t8xrvUiMp9SC7RvGnFqj/sPNNTR5ehiuZU9B+SuYi6QVrb9e+xx3YuOuNx7Kz0YlgKp2vdjYkPVCW1pHZnhMzOO7wpuVvgiJH8nZubMRQLIDqX57ZEH+LUtsvMdNgeOtXZUbZ8oLmqliYVdQT7XJFg7PV5DU3rx5hXdnu9pYPXlvQOzxwmOL8S7wB1pEUQ+eI46vJyfxJYRiKvnkZCPxBidNN6CzYo+kME83048OJwcfoL7wgNhMkZDv2cZ7r9Y9GGlwtAkRYmg+KW8wdLRR0MmMA84ZckH8SW/D3+v6AaN6yQQQjWJIa5Agj4juvQWVxzSCv53pEHIS1Eo0eqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIfIqCkHeoYpzqLqtuGRS+zqLPJLo6p53EDVam0OK18=;
 b=NLnZ+6sc2MiBoyyq/KEVkNZKo8NXMKjNe57Ja/AfOfsYX+UOEw5NjD/kYVVWS+SFUSBMdbHbtFyZHFP9smng/K2BFCWqCJ+Nzn3+jD13nyc57CkG2+79ZQLm+lJaFj38qtGSJNGCw8y+7PShoMGyoc8twL24XmeUk32bVfyOkP9YzUus6LzC6S/mKm31dbRF/BSvlUNoGvyBWMBEzWjo8+uP7mLKEi8o6fJpYvbctW0w7Hz3lCU6HEg0WTqc1aXocFyPZzTsFSLN5dO9+fQFle4qkqqAO3vP7ZL3XYo5KddVue23SfQCxoabpLeE5Ezdjy3PGvmFRy3QKh9arACMhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SA2PR11MB5196.namprd11.prod.outlook.com (2603:10b6:806:119::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Wed, 21 Oct
 2026 10:23:15 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 10:23:15 +0000
Date: Wed, 21 Oct 2026 11:23:10 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v1 2/2] net/ice: rename flow metadata parameter to rule
Message-ID: <atiSjuqUPouKIF2z@bricha3-mobl1.ger.corp.intel.com>
References: <869a70bf8e9bb8ce36de57ddb46ea2d44d7b9be9.1792577695.git.anatoly.burakov@intel.com>
 <d42ef9c40c98cc9ccb576f962ba0524a4a769ade.1792577695.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d42ef9c40c98cc9ccb576f962ba0524a4a769ade.1792577695.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU2PR04CA0245.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::10) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SA2PR11MB5196:EE_
X-MS-Office365-Filtering-Correlation-Id: 7678f861-1a4b-45c8-3878-08df2f5d5151
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|22082099003|10067099003|18002099003|3023799007|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: K6tMQTeqM5E/G4qMZ9eERb8JR/fgKw95mSSnV+Rap0Ad/N2TJfeeZ74ZaWyuuUwdz0U/II1ZELsmii7il8W04STHnSGco0Rx6ac87CELwx+TPae5VHywzt58aBX6L/d607iHrd8jF9n9adCS/Hn0kCB5DCfLPwimyAeRdojHQG9MwLGoBnCKIXO2oghGASQQH5tbUiwGzZdWw9+m9CvBd6jMX+fJDhJ/O6AhbjpOXIa+sJP9pCgGYsk5wTuop6yWW43DghPufqSzj4+stYQJ7gPFDDREIhW+dHAq1XvcTGm1FQ5shPCuaSZQqjlXQVTEqz8KoOMhC1aSgeKlP6oDwUn/1MB0oa9Vph0LU5j2AGzpLRKjVqWIRM7JxiaOysM4eDEuE16/IaoJdMUrA3CEUF2/O73ZeSW0doG6clOwRZ4kfhnwTYVSm/jyA3aYI1kulyGPIlhdY0ZOjSr8W3dkx62Z+ebyHqMJH7v83Ho0gBjjzeoZWkPl+kjIrT6efd/GtSQIL5ulouFmTUxTvv9L33GytQccZXej5YW4GB0G6LdiiWbhj4Rw9aLNmtACOH4mNhjre6whnntC6h0Ls8k3rQUzSUmgyj1XAGZ5JvmkHmsFKn59QBhnxpSW5PDYAe7fN5FxAcBM5Fj6te7e6cX47q07kAWA5VDQ+ZvUfPETLfA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(22082099003)(10067099003)(18002099003)(3023799007)(4143699003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uL3O5AU823zaWqWIHnFr/EecuXB3EEbwPXKl4KC9XR0Dzh6dFqvR7JVDRHCh?=
 =?us-ascii?Q?Criu99X8L49ua1a/Bbj/vu5KnJsJn/NFVEiazE/rMerZQ5lZjOhh6iXNpya3?=
 =?us-ascii?Q?R30Zc2KAyKyyuR4J8wTsMsW6Fa6mPv2RWykUsroz0VmQRWGL8fXUWoTJ+Jrf?=
 =?us-ascii?Q?mnliZC/jr+WB1yvA/8J7DIaTLA79jsXRyBVxVx9wtvlyCR6CD4jMn/3VMjxn?=
 =?us-ascii?Q?lgqm4DKZQr5f/So1rLpDLI13jqPipKRvij4u7qR5Qq67VtYVDtzx8+ZlpcYm?=
 =?us-ascii?Q?sXABc7KHvTs2Dzs+knD563cVf0VXMGh197WWRtOaUjpG56KsOBXjat4VewCU?=
 =?us-ascii?Q?+ItCDgMPM48O+thg7gf+4OgtQKH/3e+PsBA3uFTcTQyP2F/nwUIGl4CkyMO9?=
 =?us-ascii?Q?PmZu/AX45uWn9FXHMA17Nd9GUgwqCJHcIeBWD8hGPd67K88w7M94G5y2AgsV?=
 =?us-ascii?Q?hsqxMLsCRAYTw1SBwBeP8srxn7RIcbkmk7256drseRqNM+xH23Cie+JlHo6Y?=
 =?us-ascii?Q?ObWSFxy2OYzJi+Ii4zQUV3qbC2MRLOp6J2DQGsH+HMtgq9beUgQeZwqizggt?=
 =?us-ascii?Q?4EgFLlQVJjGeepXEpOeWEjmpGtMdCF0+zMIdnWlZbYWf5gjVpx6Er3bYswPB?=
 =?us-ascii?Q?PLGLSYN44js/xt7Qj7DhlNzfuXeNYw4bf4ONt6ta3CQ6e95xHtVCdg9RXmXW?=
 =?us-ascii?Q?m3I2GmdZGs6EMUoUmZX1bgSAa535xJiRbPPsTpM+m3dbUXueiyKsfPf10y3b?=
 =?us-ascii?Q?Kh/GQgGTREV8MPpIQHblKt37hECpkunSLV9pckNKdKOeCXZhNl88IV2LWVqq?=
 =?us-ascii?Q?JSzlXmaGK4c0p0Pan855tMJ89mSBZ1mRGBpXQ7ijZypUhU85ouiXl1XLNk5Y?=
 =?us-ascii?Q?oQoLTAOxyhO7PhtRTQMWMCoqRbdyAzrstZ1mCwXaiQ7ENMVCdbd8hjJXqXQV?=
 =?us-ascii?Q?goRpDCVRrpLSyaHVAHdc6+7ZiOG/3P1e/yMSsmqlcOfp91qVOlHS1hezPuzZ?=
 =?us-ascii?Q?iY9bujC7UjTM/0/a5DuxuGAvToPYsm+JkvEm0Eop5HVxZiZD86qA/kIcUJFF?=
 =?us-ascii?Q?H2T+H6Io0sCqlp4HcEfI8DfTD3Xt0QeUl7MXobYhGRCKVw5F25hMdbe5Pjcu?=
 =?us-ascii?Q?qsmvVz3uHe2/Ew4hSoF7+YRRL+yIBcyrk95RdTETNoOIDTueMtQHY0N86NXw?=
 =?us-ascii?Q?BCPrWjcV7+adjuKagL6Qh+Z74Oy+wPxH6H/4rG/KZiARHUcr+R8UECnyjRtq?=
 =?us-ascii?Q?Ial7CySoS0BIp7liOIFhNAcV8upHJ6Bd2Cg+JBAHFw1E1zGWRL9TECaaQoHG?=
 =?us-ascii?Q?Y46T1hZmDrEf2cStKxeOGaeUdGZpJpLb1oJdvLlW5/NYbVKiYy2ygFrCUBZh?=
 =?us-ascii?Q?EsWbeL+mq1SSPYieGgDkSO530BejnfV1y00ga/RPGcL8FHAS4/4gDfQOoJBJ?=
 =?us-ascii?Q?cazEUnOjCdftxthPJ7lKjctOMgIva/7Fzi39JGvm6SmkpWVV37Wi9VAtqAMc?=
 =?us-ascii?Q?KfOtZgMdJobnO2X4u523fSNOTtAexORNAY1/zeGRuLIgMZ+DnrhrXJ05Wmxq?=
 =?us-ascii?Q?C+R5bc4b5gYOyw0SOpmIdxjYKmLB/hgg7hxb/nifBOJPJ4AdelZfXS+aODJR?=
 =?us-ascii?Q?iCFL7HnnV2iJRizZRp8gBrqVDS8Aq5utiKbJueqrwvIQKkvqZaO60+OEPjiZ?=
 =?us-ascii?Q?C6X/rPcPZxrb7bJwhcJG2BD7nzYZ3HHYM6Ard1GCWt0nFh/DOCxGsJgrv54n?=
 =?us-ascii?Q?SH/ubIIEIjtpMLaZUgn2bKoOkBP1YLo=3D?=
X-Exchange-RoutingPolicyChecked: ZiUagkJ5lM/vwptBI2UUnXhKJpfrlSoG4osL3HxaKsjE3pMxpaIwRFWnvHAZWija/2lBGgQecUdPrOYDJEbAsvIg8wW0UVMrJqvSPs8odIs65jiFzDk/XfOVBihqib9G848EF2ngaz18vxD1sjRkiXUVrnTqHjUFv5KRsbsGG9x8nfI5psG+0/3ijQa7uC6OO3GFvwVm0cPT2UVBbw51zHrNS1P5zes7ajxi5k4kSbmf0HOBl867/ksDf/CRDEUvvoP+jo3gXXuo97kvI6Tt4m1wyAxSsKrGloCghneFrr5y/+/1PB0Rp9qo55Dhfy1vMxslI9t+cplGOmwuIeeDMg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7678f861-1a4b-45c8-3878-08df2f5d5151
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 10:23:15.4527 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wMZyoLkfVYu4IpPh/4y0wyaO5BJgTCf+y92CsWe+1+Qg8RmJCiNxUlGC/0susbcU2HGFNmbdQoRAroX5F/0g/0hjEzOPr/X4nL/4+hyyPb0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5196
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

On Wed, Oct 21, 2026 at 11:15:02AM +0100, Anatoly Burakov wrote:
> Parsers now return the final engine-specific rule rather than temporary
> metadata. The generic flow layer passes this object to engine creation
> and stores it in `flow->rule`.
> 
> Rename the `meta` parameters and related local variables to reflect
> their role as persistent rules.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/ice/ice_acl_filter.c    | 36 +++++++++----------
>  drivers/net/intel/ice/ice_fdir_filter.c   |  8 ++---
>  drivers/net/intel/ice/ice_generic_flow.c  | 16 ++++-----
>  drivers/net/intel/ice/ice_generic_flow.h  |  6 ++--
>  drivers/net/intel/ice/ice_hash.c          | 42 +++++++++++------------
>  drivers/net/intel/ice/ice_switch_filter.c |  8 ++---
>  6 files changed, 58 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/net/intel/ice/ice_acl_filter.c b/drivers/net/intel/ice/ice_acl_filter.c
> index 08695b554f1..fdd841b062d 100644
> --- a/drivers/net/intel/ice/ice_acl_filter.c
> +++ b/drivers/net/intel/ice/ice_acl_filter.c
> @@ -505,11 +505,11 @@ ice_acl_hw_rem_conf(struct ice_pf *pf, struct acl_rule *rule, int32_t entry_idx)
>  
>  static int
>  ice_acl_create_filter(struct ice_adapter *ad,
> -		      void *meta,
> +		      void *rule,
>  		      struct rte_flow_error *error)
>  {
> -	struct acl_rule *rule = meta;
> -	struct ice_acl_conf *filter = &rule->conf;
> +	struct acl_rule *acl_rule = rule;
> +	struct ice_acl_conf *filter = &acl_rule->conf;

I dislike the churn that this rename causes. For this function can you not
name the parameter "acl_rule" or even just "_rule" to avoid renaming the
local variable?

>  	enum ice_fltr_ptype flow_type = filter->input.flow_type;
>  	struct ice_flow_action acts[1];
>  	struct ice_pf *pf = &ad->pf;
> @@ -538,7 +538,7 @@ ice_acl_create_filter(struct ice_adapter *ad,
>  	}
>  
>  	input->acl_fltr = true;
> -	ret = ice_acl_hw_set_conf(pf, input, acts, rule, flow_type, 0);
> +	ret = ice_acl_hw_set_conf(pf, input, acts, acl_rule, flow_type, 0);
>  	if (ret) {
>  		return rte_flow_error_set(error, -ret,
>  				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
> @@ -547,29 +547,29 @@ ice_acl_create_filter(struct ice_adapter *ad,
<snip>
