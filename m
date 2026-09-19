Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BFEC982D8
	for <dpdk-dev@archiver.kernel.org>; Sat, 19 Sep 2026 16:14:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C1FE840E0F;
	Sat, 19 Sep 2026 18:14:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
 by mails.dpdk.org (Postfix) with ESMTP id 2F74E40DF6
 for <dev@dpdk.org>; Sat, 19 Sep 2026 18:14:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789834478; x=1821370478;
 h=message-id:date:from:subject:to:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=2WsbYBNZuO1vypaRO0X1xqO+HnCyhNKmLnJcmeeYovs=;
 b=Uiho8HMMI6xkiYOKzu3dKPyDbEER3R3pBJFrQ1kxrv7mXVn0pX/3deHG
 Nx7Zs9JmCCcwJbD0lDs3TnNk6yLIuBbdSxwhprVj1/Iz7FV7XEJi0psBl
 G4bap9Tt/8pCqIRuXHcbF2NASHZDQz4skWFEjLbnY8FFqzSxvCwEMHTGW
 PfAhL6uaayLGbWyMV+Hyn6CD5eZRoyW7qgkZj1vQEcKiSVNZJfTsGydNn
 dg+fwp2uwdJAPt2RefNic/u7PilUAE91V87VOLDcWgTmhKfEkVPCpDDOm
 I34T6vtF0pZC/AbpBKxQ4ZkDCHuV6Nr54N/J7vnlC24YUNtB8JJgmD6mR Q==;
X-CSE-ConnectionGUID: cxwFi/QYQDWM+fUDFJxNuw==
X-CSE-MsgGUID: wXPg98yySxyTBryMcH4ZLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11910"; a="870081"
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="870081"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2026 09:14:37 -0700
X-CSE-ConnectionGUID: BPDxCopmSYOKN7zvXl3ICA==
X-CSE-MsgGUID: 4aBYk5axTgCIQmUvccJqFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; d="scan'208";a="270557690"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2026 09:14:37 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 19 Sep 2026 09:14:36 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Sat, 19 Sep 2026 09:14:36 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.9) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 19 Sep 2026 09:14:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jclr7bbzpZSa7Mj2Oi5PyudnogUzZ5JWD8HKQ8a+E1f43xh8Aq6QOG2+XmB/TD0C2aal5lgjP2scSVtVj6hWQXWzOPCTLZq+I4lCp76gSE/cZb5VeDlByxbdI8sg2JL9wQNYyymhV6hvkc1K4A+VMt1JxCGjvNU33V+hLzPAMAlJryG4jfP/e/2Gb0T6TSJywcHhPOtzAxggneOAhPf+X+Y9lKRZn54Mi+uTp+GsVJoTF1s199s2KwPPjZan4DXyI4R7wRK6j4hMtLgA0xF1rtuwCVs9Asxa9zntzZaq7ID84EQsJUD8Gb6bO0PtKjVcjmPUdUDxr2SiRbixFhJeVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WeVYlyS6m5kRiySHjzl5HR3/961uctJ21Fu1rhPaBGI=;
 b=Lri+6IUPAUJNiOvdRlLg0EbKuFFP0mKPLFMxEEYgXBU1IPeJN+GMGc4FbV393W/8NpaDa7ZyZbVRz67FYFkbSyjK0Yj2DzMi7LrpLbAY77sUXlcgtcNzaRKS28aR3qeFLBI+rYY/BOoI055E67bpsAwJz5cLu5gqGK9TkJcbms1xnDwdUbRHsY67EM/Ij7mhdV68A6FvP3C8hFIpOXis/dKtlJiiLwqOKqf63T6b6FXjrOdJ6iUFEqxcchhpCAUO5Hl+kGpI7FjUWM7XzF+egkx13CuxP8sf6SawOnHQKFRagjYO5EwcJEQrmbFCdeqIAcUB/4oK7a1ATRUPlzMwTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by SA0PR11MB4526.namprd11.prod.outlook.com (2603:10b6:806:96::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Sat, 19 Sep
 2026 16:14:35 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0428.014; Sat, 19 Sep 2026
 16:14:35 +0000
Message-ID: <ad84e53e-4899-4548-b4c4-c8a8bf45c30f@intel.com>
Date: Sat, 19 Sep 2026 17:14:32 +0100
User-Agent: Mozilla Thunderbird
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v3 18/19] net/i40e: reimplement hash parser
To: <dev@dpdk.org>, Bruce Richardson <bruce.richardson@intel.com>
References: <0c67513fed61ebf88092810c94388e7ff04a35b7.1789560946.git.anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <0c67513fed61ebf88092810c94388e7ff04a35b7.1789560946.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0028.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::7) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|SA0PR11MB4526:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b9d9c89-3048-44b0-fe90-08df1669188c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|10067099003|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: NfEUzzqe4Awhk8qrni+NxrPXyvOvI7Dcf5no2FY0ceDUncP0s8131LgVQY0VuAT4Eb7pV5wfiJwzNVmughXMVvNhyXXRqXW6TdDj3YxH0yULhtFAJ6aa6QqdjT+RrbUtI3gkLKI4AOo4/LF0rdWCni4iQMqRPIHPpPQBFevzNzxIhkNfAkpvIXMS9PdZv2pAtwuTPNtZIbIXVvzeMzFP90KTHDLQwH24OHXbvVKFXorLGo+DrwlV+HVB9d9bNSWuJhSo7dPXTgN2pXVAJuiugK7EkGmelZkrjJqDz7EOmnzGWtaz3X8MRNYqS7rBG82hjb5/JCkwO32GTuX/NKQdZxdG0naKAQTS09Y6euU8gwH8eurjTa7fHf5k1EzipFWwsylRTB5x2JAQuouGmae0jwOKo10t31R9+yacmk+Iw0wQ8KwAKA6aHAXU9kAwPMrsjj6mrpcSeV7KlM1zppHUVnD0zahkeRzUpIsj8zEhigIP0p+NlpBAHU5n4CB7h+ZMSnwVbAe+xmwiwH3/hC1MVyUyANQ/bu05Escr8/Tsq4D9WCiE+vLhUdTBiOT9Xy7ey0by+Q20aKBYNYzJwLlceAN/KlKyraIIkOnBHrQzsVPIu6vXmR3iaYRpmjS+rfuj1EuLIqx30wEYuld62lC+egVzXudCxL/mUwlXeXV8cc4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVd0cy9EQzIxK2srVG0wSjVBTEgrZUdjQlZqd1RLakdXL3M5NXc1SDY3d3lw?=
 =?utf-8?B?YjB4MENZTWNsRHd5eFlxbDV1bkhraEJRZlQ3S0pIdEpBQjhnankxSHRBSzhz?=
 =?utf-8?B?cVdZMkpaN01uK0s1YVdiRDJPM01ETnJ6SU9uQXh1bmxJMlZUZXAyOWJnTi93?=
 =?utf-8?B?WkpvUFV2alNWSDNxZHhhWm9iQVJvRS9CZXJ5YnhrdFNwNS9zQXVtRGJaT1J3?=
 =?utf-8?B?dlE0cXNxeGVWWTZrWUdNYkF3SlBuY3VuRFgxT0U0dVoyZlFnamQ1QkQvUWV3?=
 =?utf-8?B?Nzl6NjRIRUIweGJacU5RYkpXZ1hEVW9xN3cwYVpyZ2tlTWpEenFPV0dwdk1x?=
 =?utf-8?B?RW51YThNNzA5NUtGeVhsVXVIcmhnTHFNMWdDenJ0d3BIZWVJajVyU1hEbWVx?=
 =?utf-8?B?YkFSY1A0WUhDem90Mm9BUmJDZHZSdXlVV2xZc056dCtOb3drMCtab2Q4Y0N2?=
 =?utf-8?B?eXV6b05SZTEwWVdaSjNWaStZRXpQdXVybURPUC9LbDk0Wi9weFcvYks1Zjd3?=
 =?utf-8?B?amczS1RSVTloaWQ4QlVlV2tjUjY4QUtYdmR6L2dvRGJ3RVE4V3JlaWQvdUEz?=
 =?utf-8?B?djgyZ1lqeTNpRWI3L1pJMzZuN2swemljVlI0ME9LVjIyRzJRZm1ENGJ6M202?=
 =?utf-8?B?VVB4WHh3L3JjUmlBaUMvd050WjNtMVR1TkxmdElZSENIclhrVXlTK24wQlVz?=
 =?utf-8?B?eER6VTIrclI5WnczSnVDQWJWdFJ3VGszcFZTOElleXdaS3hrWGdkYkk5WEFh?=
 =?utf-8?B?L1NZT0VQYWl0YTNzZ0hlV3JqTGZ4eWlsZk5ZQmdzTW9CRzljVHZaNEtSMUtj?=
 =?utf-8?B?NEZTVVh3dmh3dmljNStaK2Z3QXJoRnBRRGl4UzV3c1RwQ3NVL3RZRVRVcndI?=
 =?utf-8?B?WmV4UHQ4MzdFTDJ4a0VldTBHUmg4L1ZEK0w3Wm5YUUxQVTVqR1loQWp5MlhP?=
 =?utf-8?B?SGtzMnVLcmxuQXZmSzhjenZzOEJWOEptcnlDcHJGb3BWaFh6NmdMNnJoRUU5?=
 =?utf-8?B?eE9BUisxU3Uvck5pVlFUM1pjejhIOHFPWjFIWGNnOVFvUmVkbHBsdURKMEtv?=
 =?utf-8?B?VmVidUhNZlkxTDluWVBadXA1S1h6cUhTallSQVBNMmk5QnpBNS9nZ0NaMG92?=
 =?utf-8?B?cnlMQ3p2TnU1YnIzMUpPMWVWcTZDTER4U1AzZjVFeGVzR3ZrZzA5cXFIQmNj?=
 =?utf-8?B?dU85STY5d05TQXl2aDA2MnRRSkNxYXRnREYyRml4amcydi9sNEJiWjNKeUg0?=
 =?utf-8?B?WWJLelZHN2h5R3ZUTERSUjROYnJWWXlnRlZONm5Ud1hDRGx2cU5RUExUUGt6?=
 =?utf-8?B?QzNSVS83a2kzajh6SWVvWkhmTUxEZ2VNbWR0U1N5a2gyVWNiSk4wWFNlSEtT?=
 =?utf-8?B?SmMySWV2M3lEWFVwUk9QdzV4dk9QYUsvazhwRkFPYWtONktMb3JKZzBoTU9i?=
 =?utf-8?B?dmJaL3BBMTZJK01JbFhyRThZR2pUWUlGYVZqamZ5MEphYnlHVmZ2L1lMNGNq?=
 =?utf-8?B?RS81REpTTHp1TUkwdVVlTnhFUDZvMHZsU3A0b3dLRDhWdlRha2hOaEFQb1hC?=
 =?utf-8?B?ZWIweVJUanowNXFHenp0TmczalV0eFVVRk9YNDFpYVdhcFVwNU1MQUdscERq?=
 =?utf-8?B?Z0s4akdVQi9VT1IvMHkyblhVYkVjMDJkRlpUV29Lc3k4ZEYzSlBPV2ZDQzRj?=
 =?utf-8?B?aTVPQmhrSlRpTTdoN0l1MU53bUlxZEk2Y3dQU1U5VlBjSnB5b056eEVFWWdF?=
 =?utf-8?B?SjdlellNNjVxcVZpaEtDK016V0xzck8wS0czTjVIVDdvVDdlZ2dPT0Y2NGVj?=
 =?utf-8?B?L3ZxVnRkeml0Z0FUSXoyZXE3eERWRGh4U1pDdzlaZU1WRTR0MUVOM2dxTmhR?=
 =?utf-8?B?ckZpZzhQT2g3UDRGRkkzSjRMZzlNSWZJZy9sVEp5NEhXVkp0cit2bGlzK01q?=
 =?utf-8?B?eVpTdzhyK2s0dm5URTRIdTdNMjB1RHFmV3Q0empFWmRtTkQrTHhjRVY0Q3c2?=
 =?utf-8?B?bTNxUkRsZHJmeUl0ZmU1MEVFOWRKRGJ3LzB4VmE3anZ1aFZNT0NtMVZkSGdk?=
 =?utf-8?B?ZWlFS1d2QWtXMFNIU2MvTUhsRWxlbzFTWTNoQU9BT1I2eTd5WHIzYWpDWisx?=
 =?utf-8?B?YSs0ZmdqUzlYQXZFV0hxek9GZktmb1pBOW5kSHV5eWlTVUFIbFNINjJJTUZs?=
 =?utf-8?B?WmVXWmhFMUZtaW0xdFp1dUZ6S1IzSzBuWUd1MjRZM1IwNXN6bEFBdWVXdUdJ?=
 =?utf-8?B?M1I1TnMwTzRqWC9oa09abnlFN2VwYjRTb0xtUGVMeG10ekRLR0REdmNUUUpk?=
 =?utf-8?B?R0JlWWlJQk0vNmRLeExWcHdsRTFMSE44czJTNytYV2drUDdoM1FhZnVOTVpz?=
 =?utf-8?Q?ojIkAfjqgbWupG4c=3D?=
X-Exchange-RoutingPolicyChecked: zscWXhrjiJ2uAk5SSfCigx4urv1IlkB+Yk7v8Xi7pdGmjcPZZReLQVlqMU24C0HoT9YxG7OFHQGdjMS+TCSn8k7COe42JPcKfdlw47SrFOTMz31n654IlK4AxTj28/pR7tqFVwTJMoysHfGP6SYUyTqc6KVRSrV6/Tz3pnAdd4NXUuS0fa/gq8+oOTaNFk+xlYkDy09vwRerb2SZJicU8LZn+r0Ys2Ck/umqal8W+sJD4wU7UpX1lCKclDb78UlStTGQxXdrTiF1AG5NhFnZ78Z7OL9NkmT7EJm//pmZZjkCNr/gU3rKd9AXf1KkgpPpxgslmUzmXDjZjeiaHynivg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b9d9c89-3048-44b0-fe90-08df1669188c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 16:14:35.0861 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LFZv+dsIe2dex97j7BQo3m4L3JgaG77773+dHOkYN/Hun1p76aZP+lkqbjNOgWaPOsLtKP+jwS0Avq8++45mgzNQjd0CHgWx0PJnrUqXxO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4526
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


On 9/16/2026 1:18 PM, Anatoly Burakov wrote:
> Use the new flow graph API and the common parsing framework to implement
> flow parser for RSS.
>
> The RSS parser was bypassing the other generic infrastructure, probably
> because it was very convoluted and did not map onto that model very well.
> It has now been made a first-class citizen.
>
> The hash parser is multiple engines that share state, so each engine will
> attach to the shared refcounted RSS configuration state.
>
> Additionally, this is the final engine in i40e, so remaining legacy flow
> infrastructure has been removed.
>
> Signed-off-by: Anatoly Burakov<anatoly.burakov@intel.com>
> ---
<snip>
> +static int
> +i40e_hash_flow_query(struct ci_flow *flow,
> +		const struct rte_flow_action *action,
> +		void *data,
> +		struct rte_flow_error *error __rte_unused)
> +{
> +	struct i40e_flow_engine_hash_flow *hash_flow = (struct i40e_flow_engine_hash_flow *)flow;
> +	struct i40e_rte_flow_rss_conf *rss_conf = data;
> +
> +	if (action->type != RTE_FLOW_ACTION_TYPE_RSS) {
> +		return rte_flow_error_set(error, EINVAL,
> +				RTE_FLOW_ERROR_TYPE_ACTION, action,
> +				"Unsupported action for query");
> +	}
> +
> +	memcpy(rss_conf, &hash_flow->rss_conf, sizeof(*rss_conf));
seems like a buffer overflow. Destination (*data) is of the 
sizeof(struct rte_flow_action_rss) (splz ref to testpmd port_flow_query())
> +	return 0;
> +}
> +
<snip>

-- 
Regards,
Vladimir

