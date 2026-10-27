Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07C9606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 15:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=h2zdDq8A
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1C1F400D7;
	Tue, 27 Oct 2026 16:10:07 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTPS id 01FEB400D5
 for <dev@dpdk.org>; Tue, 27 Oct 2026 16:10:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793113807; x=1824649807;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=21ixOfbm0McT50D5V8rQROBHATD+he3Spx+rVdbEozM=;
 b=h2zdDq8AxAc/l6KkxfRsyYfz5gPRpQeCyzEjM56O/awQQ1CJ4WpDptCU
 bA09oZBgxjcvzj5GyIj66PlusGL/q+UHwfD6hnzis6LiC7vkpyVmBSHH5
 XJkSyOcrWj3+hxYtQkHksuPLLBO5JyJTzeJMXU55WfqsQZhm6NthzjvqS
 FHB6bV6s+MBo4fm0nUoQAOKfog2O7LSQiBEhwe48RdrUVHwDPTpZFvY3q
 6JRu60n+9ew+hfDpeMj0Dzx5YJsGxVZe5M5iWkuf3q+3WmDuiyO3MnFHR
 m/EPmWgXhi2/VT3b2zNwkieNjadH7jfgXNj+K3krfI0M2JdU9hkZqXtX6 w==;
X-CSE-ConnectionGUID: GweukeuRQF2Iwc/WPb439g==
X-CSE-MsgGUID: kAstfNVWRZK2FuT8sXnAYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1830340"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1830340"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 08:10:05 -0700
X-CSE-ConnectionGUID: nScJfBr8SA2gKSC0c4XDcw==
X-CSE-MsgGUID: NQieMB+NSxO3NqmA1zGATA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4667468"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 08:10:04 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 08:10:03 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 27 Oct 2026 08:10:03 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.49) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 08:10:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TffDuTtvgCcVFRi73sDYpHKz/WGlig3u9Vjgx/Wc5UDShq/D7Jb+RqFCm564lGFFJQIlJnhwrUQxEEHR3tb8GLO3eub53zjnh6Y/YLzW2VsA/ikiQkZzEMozNSGWS/iKykSe50ym+eue4TxiGw0/UWCqUve0smMmAMTpV5+ZayoLLa5Ksh2Fxy0ESn07L5cpx+3i33mkFT9Npt2YonB+2db2HX8rZDOOupuqvBMkzyebRyDoUqEVLJHY4tHabTGdD8K1jqZXK3PrX9X6YvS/CzkMyymona3dYLhlFrekbWRB/W07aQJXuq1eQenylg50rad+/XAoRoEQuCHjRdDOkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2A6JWc9WtHv8b/7HOMC8cj4ryuPvEuO2BJkh38WF5Co=;
 b=zOP0jSTzKPfDaaWoOKj03R9M+KiKTPPbugwvIAjqejCKuOgsbKOS4dwKMYN1Y7/53be+6DeT1W99HQegcVZBFrGvvQs047u8ctnrmzXgoCbCSz3s3EDE1RKE8ZZ7T+hvu7pLykBWox1GXgGyHEgV15In9vaTKWV4t9eB5Kl01ePZsDbS39TBm4+cevo860DVyPHphYF2RCOeUY4ieW/C3I/ralw3MpUZUVTlBEHOenfM9uDr0J9/0RB13M4FgM8CGDrY16hPKUDLdDcIBMtXy93MRRn52sY18Ag7nSU1USb/r2q1KWRvtQtJR6Xug/PCt8nyCJsOGR30aFvl5ta1Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by IA1PR11MB8786.namprd11.prod.outlook.com (2603:10b6:208:59b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 15:09:54 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0546.016; Tue, 27 Oct 2026
 15:09:53 +0000
Date: Tue, 27 Oct 2026 15:09:48 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>
Subject: Re: [PATCH 5/7] net/ice: fix MAC and VLAN filter leak on VSI release
Message-ID: <auC-vG_afz7xNknt@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1793097896.git.anurag.mandal@intel.com>
 <7e0d6afa7e1737e7a9172b3898bc95f0d2e2c718.1793097896.git.anurag.mandal@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7e0d6afa7e1737e7a9172b3898bc95f0d2e2c718.1793097896.git.anurag.mandal@intel.com>
X-ClientProxiedBy: DU2PR04CA0237.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::32) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|IA1PR11MB8786:EE_
X-MS-Office365-Filtering-Correlation-Id: 77cc72fb-b3b1-40b9-1119-08df343c5a6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|261026140227099003|4143699003|56012099006|11063799006|261021121427099003|261022113327099003|261022105027099003|261009223027099003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: MYJtdCDYPjPeMDML7AP/iHLsnbtRz6Kks7CzSwe6i1uOLDKJZ/B47ctv4rAMSmlQDZheeTXyHNrHuAlcaX8Ymri3a0tChVt8bml1ANvbZrVwVCJKzipmQH/5DF20ESLpAiCToVAt9t5JfGMvadvIE6DrcqmNleAZf8MGCotTJKAnECOjgufZpjHXMzuO2JOMhZoJ44fRB+S0P8SjbPEJdmdMvgDR/sAWYEQQpSs/ln8V6GuUYf85AbcNaugvlnTU6DT+Ud53iNxzjd3YSInIckqG/VKqK4VHBfehgtPoQuK7n5WRgUveiLoj2frRvF6TYeYBO1ckOy2xe9Fus6VnzHSzaEZu84/dvVSP6uMj6ba/ZVRPbGurtJ0HmIlfb/g/Cmw6JCWPAbd3oM2jmStKMBNlpyywFyumee+HLuG5vSA/sNyFcP3h2wi9eYOpDBWPu01aMOALs91sKEXUALMzbfY1/y7K3nNdGRzK0HkfrOrQNnXO5nsMb/oaIy88i50UFzhq9jHhiVYXZRFk2/CzTXZZOOjoVmxBsucuT2wtnzThwZjFcShpfWflH3kuQZAMtgG8SnoUXM9+PboYiV7qqKSe4h22mBXFVg6yEuCNPrDmbs/wiEZS1mp9SiRuovwnJnThWAS2gNjanbjV3UXZoTpVnqLRMpS5yYvcvqzPw58=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(261026140227099003)(4143699003)(56012099006)(11063799006)(261021121427099003)(261022113327099003)(261022105027099003)(261009223027099003)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TASjvs2bmq0Hg07Fz85SftIlOXZEfX71rZEuwKu4zDYOzPefcURuTv3cOY7i?=
 =?us-ascii?Q?LqaW88ZODjoGJ/eIW0S9c6OX3Rwg+v/dLZuTldmpH6QbwtJQb8aKDNh0Ttse?=
 =?us-ascii?Q?fG3rT4gl5c7+uA+coPahxMxDx8isBYWZQGshWQay5VH6ia6ZCCzsbXFDXxyf?=
 =?us-ascii?Q?e4JIV9pBSPFNKymePl17Z/3sn6s7mkvrhg/puAcQhTU5yMHwlu+Ulf0gdAe6?=
 =?us-ascii?Q?8BKDvci2V9M7tzQn1zduWOdApFazWAdVFHIDK31315VQeRgkDaJ4mN59wrCG?=
 =?us-ascii?Q?xQoESaWlQzoF9BuKEAaDdXVKTRn/ym0G0haRajVJwtx7oWyEFVlcz66ez5H1?=
 =?us-ascii?Q?1DrcDA4zWGL5YfD7gRzBzWwsjmNUXGbe9uxqZNZvJVOmb7o2M482g9FzMEfQ?=
 =?us-ascii?Q?anc+P3JkeDlFnyzqXpxB1DbP/NUhILvQ6gHHdDj8+TXAQmTVVnsKXIHzGHdv?=
 =?us-ascii?Q?MZ8r3EYUk8aj73T6SmNrPIzV/jaOimhzwFuT34KTDUC5zBQiJHXgf9FE7YNb?=
 =?us-ascii?Q?fo8HDWIrwmrQ3p8yYmzA4HFK48bXPaQeaiprkhQRbGuS6xYOfCSOTp496V9S?=
 =?us-ascii?Q?bKkH4ZOz+bWeHsd+/U0B9Cs0eU7aNlVMF7rosFhr+dWtDzu30FvJf+efPwNw?=
 =?us-ascii?Q?jG/zbKq2KKv2u/HyDGxDQk9lTPrGzW1eJgzKkdR7Hj4kNO35aHpkKKKxROj8?=
 =?us-ascii?Q?ZX1CjPq0PO6fY0z7F2XCSo80QZql9DBlvxR6ZLl/eNDrDlgYRyQDXZSksR/4?=
 =?us-ascii?Q?NrXO4kZJMZFsV19kb6wL9nOshZXJPGUonEq70V6DvtnOfOSJmzR+faJ2V8Xz?=
 =?us-ascii?Q?0Q3s7xJboJLq0gwSMtkTZg6wMQXPQW5D+q5th1nNwk53zpdwcRwB7dxVYVku?=
 =?us-ascii?Q?XrPCKgIRJSLiYkgxDv7K/1D7YY2zO2I09Z0MnDDxvymWyZLaUa3pzwY53RUS?=
 =?us-ascii?Q?mJN2bgwtvstQqs2A4wbJy0BSbVG70rLoB+BIBknFALb0KNyxe/vAOwPBDuAN?=
 =?us-ascii?Q?xYoA3hn6Ba8BCJxiOVgzNBybv17OLbCHHTTKuSwwBL9hQnAkBIP3nJavHzaK?=
 =?us-ascii?Q?TI8fg72zPB3udW2LF3SvHVhelbR1K8d02Zx9kJaW0xVjZe8LYpPA0diW0ugr?=
 =?us-ascii?Q?+TxtGzcfh0IKiYGc+Fl4AKwuYR/iOO0PGbTDrrJgz/KCg8n9d8QkpUQzOvXG?=
 =?us-ascii?Q?zbwW6aBJFm9ATZv84VAOlTYiL29eoO7BtSrYJq400tReva2J4doPuj5xXPbk?=
 =?us-ascii?Q?uzPlsnnLx2Oqnxf9b2s0KvZegm6+VXm+1pOQpOcUhCe08wyocSX9NIuxzklD?=
 =?us-ascii?Q?MNI6D1zoiS+NB67smn11NaZb3KmYLvty1bCcr2ezIoySMk7pxQZtJr7Ah4lI?=
 =?us-ascii?Q?x/DWWFRHky/nbBzqFmVp7FzhUOJ5m1nO3ythqb260COmQd9ljhJ5Uo5HIqv/?=
 =?us-ascii?Q?mEY1WY2VwRpwWQf/qirtF5TNpM/rQCjjxYw5pfV3rUPD52IVnjtOSMV7FMrE?=
 =?us-ascii?Q?3vE20eAa9TX+sVWJefQJty5WrYM/fp272WcHfyUir1eQuphOu1NwJqNq9MGC?=
 =?us-ascii?Q?fwPW9cb45QUiWF/HMxYZNl4zImlS8dRPsY9i4fBHGjs4kuWWPI+ubBj87SPv?=
 =?us-ascii?Q?XHNUIZ2sN6qLj6ynxZV4vph+IidnBa+fg7/li20NEUE9s1bc9LSSox/uJSXi?=
 =?us-ascii?Q?zM+VZsIqaK2K0HkRR4nMi/JIkHnBbVaNzOiNpSbNtNBjMmV3aZt9o803b0OX?=
 =?us-ascii?Q?oy+fL+1SyUXb7fz4TDod+8TmH9WjjMk=3D?=
X-Exchange-RoutingPolicyChecked: wT3nN8a5JpekzyYbT9nLWDWj7uLFPd8uzWQR8WYktSI5OLWUwFErtlnU0i6NXOWHgjTnSYmLrWL8d2kfxuxwi+CRgYiUVHRcFx8bDS/ucTK2+zQY6916AnmQu0VwEdOMH2sbQzoCA44n0p3Uf/RCsUt0C0ey5FRskC733VUFC/h5NQp+FmPTkCh08z06o7GdNZkqaAQRJ4zsi4yb0fN3iwsMTuRXlBmIih3Gt7mlmYSH4V8ByhY4K0Q+LD499ZcT68SGwr+czKzoQZmeXsPcbJZK20DoB/Mf7hD+gSu8glXMSuOXDXpoL+/xADyYH4BBrj/9jJOSrgKVqWQ3BWOVHw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 77cc72fb-b3b1-40b9-1119-08df343c5a6b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 15:09:53.1688 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hqu25YRMarpA6VFK3OyEAuAMj03ReSLwkZjGrjE9JFhJPPMl93P0TL7pwqvOabqkWqA41KLtpzfXmBGYfKZARo/9SAuf+SXaK4J+CB/w8YU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8786
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

On Tue, Oct 27, 2026 at 10:51:35AM +0000, Anurag Mandal wrote:
> ice_release_vsi() relies on ice_remove_all_mac_vlan_filters() to free
> the MAC and VLAN filter entries. That function returns early when the
> VSI has no MAC filter, or when removing a filter from hardware fails,
> leaving entries in the lists. The VSI is then freed with them still
> allocated.
> 
> Free any entries left in the lists before freeing the VSI.
> 
> Fixes: e0dcf94a0d7f ("net/ice: support VLAN ops")
Cc: stable@dpdk.org
> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
>  drivers/net/intel/ice/ice_ethdev.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
> index 73fa016066..90e3663287 100644
> --- a/drivers/net/intel/ice/ice_ethdev.c
> +++ b/drivers/net/intel/ice/ice_ethdev.c
> @@ -2931,6 +2931,9 @@ ice_release_vsi(struct ice_vsi *vsi)
>  {
>  	struct ice_hw *hw;
>  	struct ice_vsi_ctx vsi_ctx;
> +	struct ice_mac_filter *m_f;
> +	struct ice_vlan_filter *v_f;
> +	void *temp;
>  	int ret, error = 0;
>  
>  	if (!vsi)
> @@ -2940,6 +2943,12 @@ ice_release_vsi(struct ice_vsi *vsi)
>  
>  	ice_remove_all_mac_vlan_filters(vsi);
>  
> +	/* filters whose HW removal failed or was skipped are still listed */
> +	RTE_TAILQ_FOREACH_SAFE(m_f, &vsi->mac_list, next, temp)
> +		rte_free(m_f);
> +	RTE_TAILQ_FOREACH_SAFE(v_f, &vsi->vlan_list, next, temp)
> +		rte_free(v_f);
> +
>  	memset(&vsi_ctx, 0, sizeof(vsi_ctx));
>  
>  	vsi_ctx.vsi_num = vsi->vsi_id;
> -- 
> 2.25.1
> 
