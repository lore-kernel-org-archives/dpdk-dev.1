Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9067B606A329
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 11:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OKYWz4Xr
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 222D84060F;
	Thu,  5 Nov 2026 12:26:29 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTPS id 5507740296
 for <dev@dpdk.org>; Thu,  5 Nov 2026 12:26:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793877988; x=1825413988;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=WCQAEuh0vTvEJH+PY3cXz+oRcCl8nuDuPay32CNk2P4=;
 b=OKYWz4Xrf1h4zExqCWtMNXcnWTzIKL6HgmCzEgIAbuE+GdPJng6q2m4i
 RhmDbYRCi5QfjVEPimdIz9sAFgMSbtGKivoJdf0WN4H6SOObR48UB9c/k
 C7ZoWZY0H6T8Y4lb2pYJPBaxnNC7H0eqq5rPkPuFEejpYmchVyCh06Qgl
 07WpagTEdRiReGSvU/7o72hTpToizHJ6KnynJCYmIE+iR2wVAmXtqGGy1
 HZ2pIHgsC9o+xd9vuGRY3Tr5x+o6VZ9AdGPQZ3g+5E553UfnFJjabTENN
 kj7zA/D+Tpe44a1cD2SkRX4qcuBMw26BFLhTZiIK1gluAeE/roQX30Lor Q==;
X-CSE-ConnectionGUID: S7hOR0DPQrSVnZz+4mkp8g==
X-CSE-MsgGUID: 4rm6S+sqTt2vepevGg2yWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2694190"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2694190"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 03:26:26 -0800
X-CSE-ConnectionGUID: qosZIcL1QNOF2ugsSqEvcw==
X-CSE-MsgGUID: scWHB6EhRD2qiMGnFGhk8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="6978370"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 03:26:25 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 03:26:24 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 03:26:24 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.63) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 03:26:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d13NzCxhSljZITGcqLwNMjaHgFPsfXrmRLbdSdNkeUxOAveO3uSXTvv1k25YZqzDTQJGsVkerlxxzOrPS0qzNtfpsDegqYN4jloPRxV/t34OrehpsN0HiKwrfIf9aLH3taR9w2S2NDKhFnB9mA38Z9m1mN/hdX7sGqyjozSlpn/xhW8YqRBi7ZeXjRjrCbwXz5w4AfIVtjetAbZsO8mLYXsa3BnKsSqI7CNaLZoGS4OTFaQoBJUDN7GPvq/o1HQk11LFUNNfCXM+avPBLyhosYfUpCOeFmd20R8eWWzO0O1kZSLew+Ik10qBpdJ1RP7uvnoafaWHkyobRI/4u5Z56g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cACXh3pppXJw11r9ajOhnJMIot4z4X5RE86nyBrio2M=;
 b=cajWY8BDqnXrPc8rhR/olWMe88w9HMWh+WKDkb07hbFfd5tOQzCU/e3hIyljNe2M5QRd8gKxQV5mKcBVgkQedWNcLcgR4pRXXe3IBVKSyLLUjw6ZXAUSMApogvpJ1SJkamXz+nLoneq1bbXA5oRK+5MoJHK7h6JAeBx3Otb8i3tFpvv/1yvaJPuwZj4pTU2GwOmeyeEJQvoPj8Q1H4NaWf/l+WMuSY7+LnWznSTqs+hCT4HtrEZrisWsdiWZ6oWcYtUbSvy2i94KTMZ8tDovs0Ukww8tYiva93cRvAIGtZILNk7NCXUKdYgRjCzplfLBlKjNJf9VwYqG7ySJGhbhkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by CH3PR11MB8414.namprd11.prod.outlook.com (2603:10b6:610:17e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 11:26:17 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 11:26:17 +0000
Date: Thu, 5 Nov 2026 11:26:12 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v1 1/1] net/iavf: allow flow validation without engine
 callback
Message-ID: <auxn1PeoN5xTgN-K@bricha3-mobl1.ger.corp.intel.com>
References: <aaa8fe49c638adcc493263de206dc5c9f9c22803.1793802348.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aaa8fe49c638adcc493263de206dc5c9f9c22803.1793802348.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZP191CA0041.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::20) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|CH3PR11MB8414:EE_
X-MS-Office365-Filtering-Correlation-Id: 995f0c5c-5a6f-402e-c8ac-08df3b2f9be8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|261021123027099003|11063799006|261021121427099003|56012099006|261009223027099003|261026121527099003|261102123227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +JoLB+BXlZnEJqUhS1+rqk9qn4yE38ATgSL36aLviUG9IBClBgmfibBfJ4Ei/coWYrVq43XvhDcIazbnkzQ2QGZABgOJj3r2txzhbCShCXecXKb/C0lW9jqEyrAaADEjnne4LdSNtVrrfSnx84sA6UASm0r2aQpK5zm8yecYbgz/kbitsujJTW+4rR/xr5CoY4tSoKoxCyo4J1KEvWxvgS7qEsjamyHB83R8Ev4I3b8GWTtDT40kh+CoFtbwGryVRr+3Fxm/5+nBY6QBQJGXbbnX/SCzZhuSKCWOXh5wlHcECGL6UGii2l3QxVCVEwQVd5gQK/w/hKn5uAocXaE94HrfkZpLW7Y3zEXbtzhEgolJEB7FItZ3C6OdOweJoGUKY7C5j0jtjfQIHxKcQN0pATn2BtP8F24hdBnumO6aCGKIHucna53mpvbhcsvpKvmS3NiDpQ5YsgTENhpq7YPvXq1zvMnv5bj1sAiZBgSI6GpVsZeidZYHkoY3lswB8Ava7fFTRpHQUzsiX/vJ1XR7AX/DwH8uuAQVP9R+RsW2DVVeiMSH85BUwt692mmNUt7ZotLEHimrbAvQmEmyZjw+42Ov3NyS6cesvMEghfuWZLS95ZHZAUo6T22L+OxTzNpCIsjplAiRFUJMKv6pJi2iGe9Pmqs359hMHepFIhVJB9I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(261021123027099003)(11063799006)(261021121427099003)(56012099006)(261009223027099003)(261026121527099003)(261102123227099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8mlkiulcP5jJOTb1uQDzxZfTkMpnI2WXXaiD3ydcK6XGfH2HHi05ap1iJc0T?=
 =?us-ascii?Q?P7NuPsT5wXJnvYaFe7YEHxCNSkFNT/nQpp/u5u/LKyyajrqhxJSVFQt15fmk?=
 =?us-ascii?Q?Ml74PfOIeapvWw4yKYOHn22zbbK1EEmdAbVbrTr75VM/JqG6A6dEyshqMK8M?=
 =?us-ascii?Q?JC66lPa8ZoaLEpuYTk3eJxMaOf1JSKJ9QC8wXgiKwIleUD1E9R00L8hsNGjJ?=
 =?us-ascii?Q?82qBP/UGB3O7jkLRdzQCbffrwAHRhPIMihPFIgnzcTlBUWAY54528rzE+kIE?=
 =?us-ascii?Q?hy7hCov+DofOPlqon+ad1od16xmhIKELiGUcbZ+uiDvOkxj/Wubqw3Zokv4x?=
 =?us-ascii?Q?RA2FR0blLH5B3OMhDHh9HmMFT64hTHERHlaODzQEp/909VFhspYecrVxB4F6?=
 =?us-ascii?Q?1CEqyNTA+gpbbc4eLw+AncfwV/prQDw341E7eNiRV/oJra10dtDX8lrLncX1?=
 =?us-ascii?Q?o9bw+uNnEqtxCW1TxXkmR+E+MjiKzBUgI/KP0grN1zvb1VZcW1HJe4HQ+NQo?=
 =?us-ascii?Q?nMogSQWTrMz7D7e7O/V/RyUTNaddR/dvm+UTnzK1qgSlV1oZij4/UUqsKAcs?=
 =?us-ascii?Q?NRa+GkxUsczHpMZeZb541UMYNIK66M+LLiq4R0flmSpjF/EAGW/4NqncPkhp?=
 =?us-ascii?Q?rP1mSNDZP8YESNHfQblsb0bPlwhIE5G7f6Qsd2HuRUARK4lnFAy+n0Jh1kyL?=
 =?us-ascii?Q?Olm92cHiLOOoU+BWuhEtravYz00KpyUgf2Qi1y7ba4YOt/Gjge2IMejVrKhe?=
 =?us-ascii?Q?8TMHkivRExw+MuuHpSwYAblLMuqGvf83y54vg0x/GfgImgTRMf7eMOQHQw3O?=
 =?us-ascii?Q?HNpG+DRKsmN3yJeyy78pXkaOJIZnpXkRsCzbiRyuWr/IEPFUzRCAUWWXi4Ql?=
 =?us-ascii?Q?zm9m1FOWUokxwbj/v4jxoRAGibXbZg6WgfNqhcN8oBCRhHZSXm30XmBL0GVm?=
 =?us-ascii?Q?/IFMfy94EtNtPfLc0xSCpv4T+mRMh21lwq9tcWpVvMmgdXIxn8OieZQHY2vi?=
 =?us-ascii?Q?8VntluJ1bAtApqohE8pDN6KA2AGuA9uoa3JLlTd3FiCj4DwuWTXOrbDX2IKD?=
 =?us-ascii?Q?GG6v+z0nXwVRztJh3kk0FlhKrh9zhiYrzjXA4I1GMTZqrov6rwSjOg6UVIPk?=
 =?us-ascii?Q?JO+1FD374TIZglBkxYwYs2TjXIp1rJg1esB3U1HSVHD14O3Q1ESV4U/ts1eX?=
 =?us-ascii?Q?sqOERdUwXp0QqUiN+ruTX4tsBS83KehDvySALCV93UVyIlbm7aUsf/LvUNmt?=
 =?us-ascii?Q?sfPMEYNAyIPaLzQ/mUrfmn/L1D4tARgE4A5IpOr0hBOm1l8hsn7KwnWnIIr1?=
 =?us-ascii?Q?SFy6SeyzenL11ydb0/hMuV5fdafH15oS7Jxxo1zkX4YMQyO7hcs+7STxduSI?=
 =?us-ascii?Q?+foc7raCHi+Ext9HRC9lryJ3NZ6U+tAHLqRyFFa0iFf4RqdjszQvdGoLEYBr?=
 =?us-ascii?Q?UBND0rB5K6uriZR5C7zLPVFQ+iyfwNIy2dtqPnJzrb6jgmpTTq4JCPKvcCKO?=
 =?us-ascii?Q?X75KHj+6VE/agMMFWJgjxhnBEXcR1l+M8vbsATLKOx7kqlGMLsFeiIQ7Ph1M?=
 =?us-ascii?Q?UK+Yh+2NSXvxxq7oH/cbEFbpieBUFS4lm5V3LV+dqVIk4BQwOGBdOO83CQeW?=
 =?us-ascii?Q?fLkiixaWn3ZAwxYS2CunV4gDAH0PEjKrZx0fQLCdL1kzkO5e1q/gOstR8A0l?=
 =?us-ascii?Q?+/ECiBrgweEBHvNREMZXBLFpCesJdk1LojGl7I2OXEZCtbUQyrgFQgT0NMkR?=
 =?us-ascii?Q?1MiixyRx1F9tNjrWIFpHitouifYH5tw=3D?=
X-Exchange-RoutingPolicyChecked: usFriSsaXLoQEAToWUnK0E3OHW7595OL5ZXVeRNzeFdJ8M9hKld9BffxnYH+V9/tyy06hVEpflOAEpsED0E78C3VurJRaLchvFdx1P9mNsPhGMtdqpeVi3Cf9T3o77wls+ISbcWHsxi7d8l40ePJKBVluUaGoi1Typm4WTpvrS3OxtO13hgm53AQu0zLu9XA2a4wBMnE3+FH0He66swNaor4g5fhyooqn9sshuRdEUpkXv5jPJ+Sgc6DprkPo+f8CvgwkoLwiBohbH6FZ9/1ddPr3PJBdWU0hlEw3YuwEz9rMy1v9+Y0p0pX5bsfXlYs7WL+UVu0ipnBvQ2mhhMZZA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 995f0c5c-5a6f-402e-c8ac-08df3b2f9be8
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 11:26:17.7136 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5LUGxowwmMWCztp40th+ihBY0J6hmlHaa5IaWPCnxTCKC9ZYV3xfwrt0rgoRa288s9RSFSqSFXQC0eBeaOA2/H8s+7hqiG9OYwKs1yxBgXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8414
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04, 2026 at 02:25:57PM +0000, Anatoly Burakov wrote:
> Some engines do not implement a validation callback. Rejecting these
> engines after successful pattern and action parsing prevents their flows
> from passing validation.
> 
> Fix the validation function to treat successful parsing as sufficient when
> no validation callback is provided.
> 
> Fixes: fae5ce5de601 ("net/iavf: fix false success on flow validation")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_generic_flow.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel, with one small change made on apply noted below.
thanks,
/Bruce
> diff --git a/drivers/net/intel/iavf/iavf_generic_flow.c b/drivers/net/intel/iavf/iavf_generic_flow.c
> index be7ddf5db63..1ebab3ddefe 100644
> --- a/drivers/net/intel/iavf/iavf_generic_flow.c
> +++ b/drivers/net/intel/iavf/iavf_generic_flow.c
> @@ -2148,16 +2148,9 @@ iavf_parse_engine_validate(struct iavf_adapter *ad,
>  			continue;
>  
>  		engine = parser_node->parser->engine;
> -		if (engine->validation == NULL) {
> -			rte_free(meta);
> -			meta = NULL;
> -			rte_flow_error_set(error, EINVAL,
> -				RTE_FLOW_ERROR_TYPE_HANDLE,
> -				NULL, "Validation not support");
> -			continue;
> -		}
> -
> -		ret = engine->validation(ad, flow, meta, error);
> +		ret = 0;

Rather than a separate assignment line, we can just zero-init ret at
definition, since all paths from here lead to a return.

> +		if (engine->validation != NULL)
> +			ret = engine->validation(ad, flow, meta, error);
>  		rte_free(meta);
>  		meta = NULL;
>  		if (ret != 0) {
> -- 
> 2.52.0
> 
