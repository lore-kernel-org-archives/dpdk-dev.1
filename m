Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58945606A319
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 09:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Neh3ihq+
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD9DC40608;
	Wed, 21 Oct 2026 11:17:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id EE19A40041
 for <dev@dpdk.org>; Wed, 21 Oct 2026 11:17:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792574266; x=1824110266;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=spoNNrbVZm3nt4jb9DZMKDiK2Eqw5WW8817az3MyvJU=;
 b=Neh3ihq+6zOjQpTXF1wm7bGhZema//TyXAfr0GsUIOrKnEr/f+HcRDVg
 SKPKZxwWISbT58LqdwIlhxUuHSiFWSevp2Bt9tDB3gZgm1WzkEVE2wfQ5
 rW37xTzBMBx9f36Zr6bfXl7X4vh6vk8KvXCrKCtnkzKO6pB+g6Cl0lJe2
 asbOfOyYFfogWJ3WgPFKbBQuaRZmPxDagemP+TTiNypgwOUnWCidyEjQA
 yXF/glDGfXziFfpIG+PylfFzoU6VduGCeaQzebhvo9rUrthJ8mt2QG21s
 MdFp+BsPq9Xlc/QhR9WVysM0U7Pn9tkKCY+ytJ6E1MlB91wudgmE+jrEw g==;
X-CSE-ConnectionGUID: PM9nXe7bQtqFyWXAPG/Ylw==
X-CSE-MsgGUID: k5PZThJwRQ2TaAXwJ7FASw==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1192264"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1192264"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 02:17:44 -0700
X-CSE-ConnectionGUID: TM+NR5zERFOgS+JBdT0qOA==
X-CSE-MsgGUID: sCWCdkP0QKStZP+VB0xDZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="4876177"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 02:17:44 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 02:17:43 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 02:17:43 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.44) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 02:17:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IdWc7icz25MFm3rGXxzWYAG8OOK6cFeBqDTBgmvScInE7asbF0LGESip2FX+Bgcaj7rScXdFf1eZ/rbb7qxUiBUIz9IGidj8sqZMH6bcKk7CFRAExV6gndI3uglvkPIavJiRXKQLwr6pzkoTwGVfOiszu5urJiirB8cpLkG2DV9NZEdqK+HXmvwW1T0KdNsxFabd2/VojdNKLLmn++5MokKxGwmf7AwffZ5Q1inrKRipu91NJ+0BSKtFHh6RRtk+pQacj6yKe+bthfrJL075Rucbku4o9q7Y3Z1hX6jeNy3heTY+SFjBwjU7hvxcdg+5UgKGpifEVVaHqWQvIH42MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7UdOcLmPcWGiYxmOhtzlm03xDUil9jyVN6lDYxHgF8=;
 b=pqQS25xBAEbO9qswLaast7DU+t0CAvJoKVL/QmYwOe5pikkXSfkgS/dRXvaOm1dPPYwXG8LuS4WzoOVc6wx2Fg840mDzngCPCUSoPkNwY6BwE82zy3hjYY73WBiUEnPWOQ+HuKbQZg+9L+tT3j1bWHOJe97+hdqJNRHvZw2IlnwbDLPj4fDDreAg6Yk+TKlhlQHjZQR/cZbY/X/iI5hvOOnTRNsCVZR7oYEbmozrpLgLvZuOUXDaF+7ELo0khOoACvHx2LOTEbbvcBxSB4q8JvQfFYC1tF3xlW/ZXtip28XzXmMCazA7QIkbdsaRy2tI3pve4iGy3Cfe04HBG+kDpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by BL3PR11MB6483.namprd11.prod.outlook.com (2603:10b6:208:3be::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Wed, 21 Oct
 2026 09:17:41 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 09:17:41 +0000
Date: Wed, 21 Oct 2026 10:17:36 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Xiaolong Ye <xiaolong.ye@intel.com>, Yahui Cao
 <yahui.cao@intel.com>, Qi Zhang <qi.z.zhang@intel.com>
Subject: Re: [PATCH v1 2/6] net/ice: fix inconsistent state on FDIR failure
Message-ID: <atiDMDdGHN3HrcS2@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1792498154.git.anatoly.burakov@intel.com>
 <c1c40841ee6fba9e2d0322a2ae1fd7ae06cff891.1792498154.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c1c40841ee6fba9e2d0322a2ae1fd7ae06cff891.1792498154.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0257.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::29) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|BL3PR11MB6483:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b8d93f6-0c3d-4411-6e62-08df2f54288c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|22082099003|18002099003|4143699003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: /oXjA5ZQ+4l8QlVwpjFsuk7jBr7GjFdqhb41K+OAMG4ovCqEVvftSK2OaQw6Kq+wc8Ib6zpT2thg82pvg/J/WhAqDqBy+AuwUuyfnCmgJkDjb91qfg8+6JnIFkuMaZF+YuYdJLy5pkcKWh5Kas6Gun7jhnJCXBzmuNDNcDZ9sZwYESbxxpd4OkAaCG84HsZUr6ZGieIjzWwA+DX5dByuUZQh/OCGjHhFnCsX5HSayXTeVR3j3GX5mHYgMhrZ86/LELRG6fzH8qLCdCaxbgXZpAZ8wXLHNNtZtXrsPku3DetCn/eOraM1qC4m4ZDYhAnrpctmfmrNeAk9773Ua0WF+aDPzru2+Me2ew5ArFg5aAHnn7g9uB3mg5FKK4lpm5QnEdO+mP5no4wI0JALl6gOOErqIONQHrtGlOzEtayUokYRA1UXknk5hytW2/bJZQDdKpk6R0Lj7r0wWXomZ57qHvcvP1Fv5k1qViROsq6QdTw5/cpp5ED3bUct8+IDIVj5wGpMv0bveMsIBFUSeiZSTJ22P67gRX3O8HWSMxJEJePCDOPDbZFkeWYszrF/1EwQiSSEpwwstEL14+5Y7FdM5BEbdnL66RBOBHAfivjaMJvrbe/aDtqo7KClztFbUmKgnUJigurGXdkJFtdIzKildlVRstlFi2TZQSmqF9LwA1Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(22082099003)(18002099003)(4143699003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KV6+8Y/88+z8oVXhq0wDuPBej4qIZq1MGTMFF/i/mOHemeJROpZLUDZ5jO5w?=
 =?us-ascii?Q?1r91ju0324+VV9QbPoUQj9ttIxWqpoY0SPVgwBbZbYkWP1EEUNOqrMb5x/9z?=
 =?us-ascii?Q?oeLN04r8OAkbk3sq/FrF5j17d4zxix9KIKJQdwORUqPTfB3IqrVspdGaRm+E?=
 =?us-ascii?Q?PVsLfPSDAiQHcnX29c9bIxR85+DFWR/eKZxsu5X3h2dNqyLOq//yCkm9T8aZ?=
 =?us-ascii?Q?pd1AgEFVYkBmuP1RNtdoYUNjVZJPkVZVJ4yuasWXF4O8ZWkZYo8/vuJx8aXh?=
 =?us-ascii?Q?A15QV/U1WBrDWrnGpDyAA2nSY2SjEThKZNq9Jsk5NuFF6F3HROGi4QiQrNsM?=
 =?us-ascii?Q?WulZQiE6ji1jCp6gDbwV3iZbEHwvd8f2zd8/PazOeRlQKzfBsly+bNbQRcaF?=
 =?us-ascii?Q?+pc4AEEYnQvhlRORztxpDTveb1oNV9U+DNK87Myaq6u8kMi3spMKfvVsIcLq?=
 =?us-ascii?Q?vwCXC55GalRjfxpjP8owUnQfe9D2UNWrkpsxon2iAYCpXb3hVJRljuDfPU/N?=
 =?us-ascii?Q?W1/zqqTfuXyxHgJRMYoKrWQKSnbc6QcG5AocbcPxPm8j45Cdy94Hcn2VBP5h?=
 =?us-ascii?Q?Qa8ZfgNFFAzhS7ma8TipxzOyLLrhB5Cx2V9lJ51PKGxBYt1v3npKoCEewlKA?=
 =?us-ascii?Q?PiRgtm8mnsC3LvhGD/Z5lpIEpP5Wmex80EktUsDPWCk77GwZ5bw/d8WkELw4?=
 =?us-ascii?Q?uEJLNNXqGSNutbecZ+uyJt5GYM8iH8tN/6EWX/EjV8fFXtTs5mAlqm5T5UEi?=
 =?us-ascii?Q?fA+xyEUVd0QwJQn392BdpnvJ5Ud/C6+Q95t+HFbcKb2ev6v5FjQmi8vrYtbu?=
 =?us-ascii?Q?MF1DN4iOTzuJmwiMVFLYJektKelViC2jnlKMQ5QAX4LimyKpg2953ppR9Bir?=
 =?us-ascii?Q?NpI3Clp3Yyxhp6EUVV0L8cOFTreuR/8WZmSgZCVV5YCLazxw2SNC6+Djj7Hh?=
 =?us-ascii?Q?BhSpMdEQDwX2eri1YyikNR+xWywEX7slLKM+36bKHNyIMPSV0l2aYXAfBFnS?=
 =?us-ascii?Q?qQgYAaOR1y3TYRUGbfPr7nmeK4UhWJoLOkppMThVpNe7P/4OQj46+B8nJb7Q?=
 =?us-ascii?Q?MOIqiUv+4tjrSjus1noHBHoPITi7X9E+WoMTehAB5g7AHsURStFWvw1VqIYP?=
 =?us-ascii?Q?MgyPj/fcMO/T9Ahg+xNWgnhhaz4xjyvB3XoxZrMmRjXdDaSAtdrdLnLfjej/?=
 =?us-ascii?Q?iOMQkGps2fcgHRLZCllhRrKJDGfjJIsSiFJr3EADum2kOry6X6T3l06Ud+Jc?=
 =?us-ascii?Q?IUI0uZzL8tXIce0U1JA7f9q3byXSd6gH5nDMj3KMDcSW6IU9Brf8dUAiWdDG?=
 =?us-ascii?Q?3DapqCFK1Tgz2PqyZeOEjGdKY5MPZffhY2LzCyixH+iBCK7MD9xkc/4gV2gx?=
 =?us-ascii?Q?JMMlv43LVWCvujHkj/Gxgp5uo7IRVK14jciDVIMoOZw+Cyrnsodu3+sbNQrq?=
 =?us-ascii?Q?aQ/XhoOJDHGFcOOnqggC6S1dpOfLeA/mjiuPFz8IfoiGm+l59hwwURXaRJJv?=
 =?us-ascii?Q?mGcxPkanI0HrjCn5T9QOa2Sz11CTy9P+bUlntI3WFsezyA92RTUpZTGl5rmQ?=
 =?us-ascii?Q?+sgY0L81GrH4JTE1rWVWohMivJBgx77SMuMlx8Goy6itcEs6w38JOVlWnKN9?=
 =?us-ascii?Q?d0ZplUrzo95Zq5nr3ddFB5xwgVj2k6qvcO7q2qqanUX+yRkHncrfDzLBTBiz?=
 =?us-ascii?Q?ZwHJ++Y7lk9KYMto8YPYWE7RyfW6P2QwItaj+ufMMkIrcttmGR3Grb7nplOH?=
 =?us-ascii?Q?o3VuM89G7K993V48Utp1zLMJhNaCXNY=3D?=
X-Exchange-RoutingPolicyChecked: GeFCCRZ3v0VJqC9j1+fDgGgAAkfpt6dSf9KOiYNU/VKI/Gk2dnuwA1pQfAgVmrnS3hhnxJPD8krZ75HEOvkhua+QYw4DSNvyRw6w4QtTQ+pz+YiOXlvOZVqn5wvVA3kNzy6zZx5bu3SoGrI49QHM5VkYLWpWPdYejn1y6uWaKubZjmqepGtrt4GPBeTFaz6SPaRjzTClWKjGbdO2jMbRZm3sQdn1bBPf2yFF7vdKkE3zC2BoOTSWTjZ2pntd0dNtSq3AvddqC7WNUw2sdot11Njh+pXzZRLSdEOqlUts2XDyaFgO2DwiAU7JbLsKtezgGhaJjqVQr8q4cN+prBnIew==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8d93f6-0c3d-4411-6e62-08df2f54288c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 09:17:41.5929 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Rka5UqpwbfFJ1ZhvOr7oOLU9LTOj6F63PcikbilFcbYCQJsxKveJ4oYblFvYL7rDxVhVafr2jF93y/YuMlfDwgsHO5EOxw2zzg2gS6XwLU=
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

On Tue, Oct 20, 2026 at 01:11:05PM +0100, Anatoly Burakov wrote:
> FDIR creation programs the hardware rule before inserting its software
> hash entry. If insertion fails, creation returns without removing the
> hardware rule or releasing its counter, and MARK parsing may remain
> enabled despite no flow handle being returned.
> 
> Reserve the hash entry before programming the rule, and release the
> counter if reservation fails. Remove the reserved entry if hardware
> programming fails. Enable MARK parsing only after both steps succeed.
> 
> Fixes: 1a2fc1799f09 ("net/ice: reject duplicated flow for flow director")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  drivers/net/intel/ice/ice_fdir_filter.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/intel/ice/ice_fdir_filter.c b/drivers/net/intel/ice/ice_fdir_filter.c
> index 517c32cecf..63a0d9fb1f 100644
> --- a/drivers/net/intel/ice/ice_fdir_filter.c
> +++ b/drivers/net/intel/ice/ice_fdir_filter.c
> @@ -1654,8 +1654,18 @@ ice_fdir_create_filter(struct ice_adapter *ad,
>  		filter->input.cnt_index = filter->counter->hw_index;
>  	}
>  
> +	/* Reserve the software entry before installing the hardware rule. */
> +	ret = ice_fdir_entry_insert(pf, entry, &key);
> +	if (ret) {
> +		rte_flow_error_set(error, -ret,
> +				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
> +				   "Insert entry to table failed.");
> +		goto free_counter;
> +	}
> +
>  	ret = ice_fdir_add_del_filter(pf, filter, true);
>  	if (ret) {
> +		ice_fdir_entry_del(pf, &key);
>  		rte_flow_error_set(error, -ret,
>  				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
>  				   "Add filter rule failed.");
> @@ -1666,14 +1676,6 @@ ice_fdir_create_filter(struct ice_adapter *ad,
>  		ice_fdir_rx_parsing_enable(ad, 1);
>  
>  	memcpy(entry, filter, sizeof(*entry));
> -	ret = ice_fdir_entry_insert(pf, entry, &key);
> -	if (ret) {
> -		rte_flow_error_set(error, -ret,
> -				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
> -				   "Insert entry to table failed.");
> -		goto free_entry;
> -	}
> -
>  	flow->rule = entry;
>  	ice_fdir_cnt_update(pf, filter->input.flow_type, is_tun, true);
>  
> -- 
> 2.52.0
> 
