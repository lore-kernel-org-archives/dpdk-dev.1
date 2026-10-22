Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AC1606A320
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 14:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NHhvXAY6
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8374C40264;
	Thu, 22 Oct 2026 16:41:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id B923F4003C
 for <dev@dpdk.org>; Thu, 22 Oct 2026 16:41:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792680094; x=1824216094;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Ywes2xScp6qlUIoPecOW84yclnZn/xhxQrM01V3m3Tg=;
 b=NHhvXAY6g3DG8xrOH6TzczWazATt1/OHRmuC2El2eP4rn8K8Y7OaKEUr
 wEVw5heKM5a9sdJGfaSK4SHUAuFfvZUKB0H0KK4D6k2I1BW3+38YHeHpa
 ova5Cpou1alL/fv8dwh8eMJ7TlnsqL3XpA8PAGsPWS4T601fg0Q+Hwdi5
 hrn3/8whoSjDqXN7Wz8U7ss1uqLABVUSb8M2/iQ3UtYR6VDcGbtKsZqUY
 FKzOjAMhajz2BsCO500kIJbD98Baa5jFDGT+tjEop7k71GlhRun2efzsX
 yItC6pSwaeY+ZtftZNCJ1Cvf5gUVYrsi6UjxOO/fOeQwO55IFR6s3jCYG g==;
X-CSE-ConnectionGUID: KhQdEYGLQuGW+M5S9r5d2Q==
X-CSE-MsgGUID: /f1La4zbSBGF0VIlktOfuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1413789"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1413789"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 07:41:30 -0700
X-CSE-ConnectionGUID: WvS/37S3Sf+sBeVvgsBLcQ==
X-CSE-MsgGUID: jiSg+CKMSiGXyepj/1KRgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3324568"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 07:41:30 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 07:41:29 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 22 Oct 2026 07:41:29 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.59)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 07:41:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mpOb9RG48u4gs8Dg5OQFVeP48oOeeNMhmRM10p5lj+RWb5ud1hOzx0iwLrznJytUVs8jLfhubDn26wH/SET2yWcuYHn2OHRMrgSz9/GvZGPbnLoBD0gg3T2pRRHXLzc0F7pSHcyi4Q436d4mWn3SQzRm6OZYcdm1dpnjsiikInF2oZHHga/Yg6cGvMlgjv01xj1FfEQsXf34/Uw2WElksBp4QFUkPy8gUfmKRKMIQW56NpteVbcmV4Hoeq0BsR3tgqdIAK0NcZ5IMdlq8IIf88AxSOaHntSixvc8qAscFlOVPJOGGATsybe7GtsP1VUPDSysaE1roGTnL+n0pnxZKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CH2iOI02niMwS13wjHn/x9b0hxAp65pw/Mu2jH7ggM4=;
 b=om60jQqI0OzhjuBbLBQ/2Piccfy77Q/xGqm528uSlVVa6KLgXtfF8bTFCdkg1OAkHYN8q9R5FJTL2o69uGUDtJlzkrblhcSQgw1sw1pukOkOEuT7qilerc25+lV+x051EqE9NfX2GG0lqly35wmqA9KtjSMp+iSr1zPF2f/GKIufwNO+QKfeqZFJfTnZSNPg4Sahuc2ERDEXj02FU134mnr6gWETBd88pIzOL1g0cG11hxwMDJOOymqpfG62tn6+f1q6SR9OX1bXUEKArx7GhbFSKALXFEb3Er10PhN9WccMfLve1I4RWbYBce0oUCpmPIQng2/9/Wuie+ru45hxLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SJ5PPF5B09F0799.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::82c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Thu, 22 Oct
 2026 14:41:20 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.017; Thu, 22 Oct 2026
 14:41:20 +0000
Date: Thu, 22 Oct 2026 15:41:14 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v4 08/10] net/iavf: remove redundant reset checks from
 RSS engine
Message-ID: <atogioPUeSUTPtcw@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1792592724.git.anatoly.burakov@intel.com>
 <cover.1792592724.git.anatoly.burakov@intel.com>
 <33dc65f213786b0e455f4026ba08c2cfa3bd70b2.1792592724.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <33dc65f213786b0e455f4026ba08c2cfa3bd70b2.1792592724.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZP191CA0045.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::12) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SJ5PPF5B09F0799:EE_
X-MS-Office365-Filtering-Correlation-Id: e160c7f4-8c35-4ccc-4aa2-08df304a893e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|4143699003|11063799006|261021121427099003|261021123027099003|261009223027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: nK+9KQzTz8UtkVV+0LUvaOHhlZqbsF5ue9h+t2QjWOJUq1+pUCibzY8dJUuuyZPiSak1q/93OsYowCVNtVftcOoKkFZQWhvzCJ4ZNBpnf2BmuoWfjyj7Kjb/b81tvgRKfuf/QcBKwP4Qms7EotnXUBfbc/waJ0UxuGSug6hGbG9yJu2f81PmSVjSP3l8XPzt8fKjijya2YLQyMH6s598Ktq0elN94j7I2Pz3Fz1qmYZatws8yHkPYvpFzyyylZuMLKXrY1RiPK9FKvjNGM9uDUrETAOXo4onHgTIc25fhBCe16QspxNhLm81ssYap200ZGMaQn4TWzaLks2fqtUt5h/GuEuJ5gen9o+/RojrG0OLswweW6AC/2bRh952AI2ZM7/jEz0lWhWK2R22GWzvD7IakG3RxueGEj34QXHuIUvNjRKS8BKu92N0ek4KDdVxGJJn801LfZ/hM9MQgxaw9WNBSZmDJjW92cHyg+PWzFBEHqenzt6o4+WIgZQ5vv2nplmnleIwUjHaQDSjmAj03utoFXulGk+gDkCScH8s8kr8fh1PzPfzPq6t4Cl/Wk3KCzx+ku5XGRRLGKa8xihwtuFiqDtygt8tLjfoyrmg5EhCwJ+iAego2B6GI3GXorWorwUMnRAC/N+nLUNqDIT7NXOmszqQRm6Fn9WmSWKvR/k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(4143699003)(11063799006)(261021121427099003)(261021123027099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ATJCCjsTCyx0yitdCxGrhSnyYwC8rc2ZFHHACLMQRAyS/g8W7/ii5ArXH+CB?=
 =?us-ascii?Q?2tMxxIBKV9WxBsUr3MHIprCt9oQIoEbooFbr/QDS7B5H33ABFsGHeYDxMNmt?=
 =?us-ascii?Q?zIWqnOu9h6x6SGD963Mq7XCqlCskq7lKwfIewuNJ0ipitRLUkkE/TS5CO3cO?=
 =?us-ascii?Q?KIL+Y7UnPl71uw5p1u0LeQBZ8sIIfBHWnPNfX52RDGzrjEA2GmOOkFOaIURv?=
 =?us-ascii?Q?VUxGEHqnBvo2L7TUfVpYEkLHLWjYTM6H4atdzZTz9mHzLeYGM5YiSbxcDKY3?=
 =?us-ascii?Q?g5ypRWZI8tbN5rcYW7GgOEsGE4dGDj/UiX947I3GQMr7jXvVUcpeXsLrPexC?=
 =?us-ascii?Q?iXM+Dsj4D0ef9Skl+PBrZGF5dcmGvvrE0bzSw8StOn/ia3SR98KILMmieReX?=
 =?us-ascii?Q?5OSMPuAYq36WqQ9vShJ+LURtWCmSbm2TRQFX+u4D3typjC+gUwPJIrkvSHod?=
 =?us-ascii?Q?V2CC5r+OkOEIy21uOPWtXR2CldwZQ3pTtmo0yLk9LucQa8zyXaXZQkzZLOjd?=
 =?us-ascii?Q?HJia7QBb5dIQQCGJ9iAMRUOl4+UiWh/qEIMX9YFp5F1eZBNF9T6YoyTWVjWN?=
 =?us-ascii?Q?tMNxS05S67kdGJ/QwQ1ZCcQHde/YqHbQMcfFFdxqjuSRIb2nnKjIr/pqzytx?=
 =?us-ascii?Q?TkvDB82Ox7ez7io7/cuHWU4bWM4tUgvitaJYQ8NnkS7S+e0NZRGyHXUV8ETO?=
 =?us-ascii?Q?iKl82+Icpb3frYDNQBxyoLUIKzNuvIUoiPFu2h4LQCruUiOugUxxYcG04fXu?=
 =?us-ascii?Q?WoXESCOpRHFpc5kBeacmnnhxfiUMGFDa7frHPs8YGY1Sr4zzCp0PLhu6rwqa?=
 =?us-ascii?Q?j++S0Uo5I46XYKR/ZOHnSaJrhMepYC732d6HrRLJIcGFOvskNUH0z3IKEjaB?=
 =?us-ascii?Q?pBcRttSEbOAR6RbMcJUqWS01YU3OFdEUoAMEZMU6uzm5swOBN5POiHgUlyrw?=
 =?us-ascii?Q?LeImzywhmbVgnrHKotQAOmYLfiiYjzvqxpp2eMY36s4rrz4XfR9pGyQ966hZ?=
 =?us-ascii?Q?K7JIk+pv6ksOUHtY2UvjSuKjNFuplrOAUnbcK6KlLhFnBMcbVWHfIgYd/sgo?=
 =?us-ascii?Q?kI3NWpzgsJScwZGdPWaMMyViqlYjyHsFJaguzViNjoYUOG28n8UpWdmXsjd0?=
 =?us-ascii?Q?6/MzE59ZQPuAgBdd1NIHnGKYeATLXopBXh7WrU4d6mB3z3fChS3b6WGWLDoY?=
 =?us-ascii?Q?+RpL/NzXWZ65h6VrNybrY+/Poxi2zXdoxoQ4lBe8ah9gxYvNc83ElktZw6ih?=
 =?us-ascii?Q?lpyC3XKeMU8iixyPQ3DYMJnUcYTMveTFG0whO7k0q3hLGY3jvT/PwWAKuuVk?=
 =?us-ascii?Q?yKUrHs2kvS7azXANtEdDiwAMLELu+bOVVrLpxq58Inp2EQg7f/sVh41/k1ed?=
 =?us-ascii?Q?iiPtZL3+gUFGVDpSKBSGmYetLVY/LZsc1lgAqDvCKaKz2zPgQAh6jdztr/F6?=
 =?us-ascii?Q?3cZbOCG1+kW0wmYBgWVu9/zOQq+5TJEPZyfariLKO9RUc3xttEnykp5IxEwP?=
 =?us-ascii?Q?1lzOk41r8SVYohHEy4pZb91+YFhZQerbV4WI8VvYP1Mh3fWw+5A9IFGUCovj?=
 =?us-ascii?Q?290sAFoPSZKrbmnr7sYFnzSAHy0jrgWqEvbeVRNofCyjP18M2/IpW7vJUKjE?=
 =?us-ascii?Q?QHDQywetKmDTfb9rLRMdUxGImuw+9osPqPZLXC0MO0/j73OUL+nq4gSQklGA?=
 =?us-ascii?Q?sXKGyujpZUu7GjGh1mdOFFBpT5yoTdKJZi5MOqia+h4xmZ5iOw1u9Ds8seyd?=
 =?us-ascii?Q?gKyiAduw1AbBPJjeVS1OYzJKqoMzeCA=3D?=
X-Exchange-RoutingPolicyChecked: gn08jn1waO86t12usH13eqO6PvOQuKh1kHcOblGBk6lfgq9he6YTRbN4JcM7QWZtWsPV6sxAGuV2Yc1XTNjUMANWmTpD7VhdsHsiV9JhI1sRiJxgwwgacxL/lMSxOnHTc3/cPOnhd9a4QjbWlIlpr4sZv+/eDBtfhoogxYx3IbOnqCpKVm4yD2WNne3PxAp4QiV3vsIpjdmnFiTi1gsYVHNffJoE12eWYJ6OinGmmYLxFWytx0KlCA13kzWDwJ9RyP7iHkChbuJ+OPpiwhwNMaTpyXAtQ9hjTpgKixWTWnOVKhISDNxC27pn0OPZxwpWj8GMYGcOu+Eq14XzJoYBWA==
X-MS-Exchange-CrossTenant-Network-Message-Id: e160c7f4-8c35-4ccc-4aa2-08df304a893e
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 14:41:19.9960 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QfMWB9OIKIvWromGAl+s9gkKL0cy4kGN/+BrRkwT3qkFdPAuxmdv7ImDzqG4+oVmM91ShgBUrGv1XRT1nAaWcCyiQrjcLk2gg37MsDBxR48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF5B09F0799
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

On Wed, Oct 21, 2026 at 03:25:48PM +0100, Anatoly Burakov wrote:
> The RSS engine checks `vf_reset` during init, destroy and uninit to avoid
> sending virtchnl commands while the VF is resetting. These checks are no
> longer needed:
> 
> - `iavf_hash_init()` only registers the parser and sends no commands.
> - `iavf_dev_close()` skips both flow flush and RSS teardown during
>   PF-initiated reset recovery.
> - the generic flow layer frees rule memory without relying on engine
>   callbacks.
> - `iavf_execute_vf_cmd()` already refuses to send commands while
>   `vf_reset` is set.
> 
> Remove these checks as they are no longer needed.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_hash.c | 10 ----------
>  1 file changed, 10 deletions(-)
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
