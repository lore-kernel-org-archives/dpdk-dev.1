Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5A3CA5FC4
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 17:12:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FD6A40E42;
	Wed, 30 Sep 2026 19:12:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id A8A5A402D9
 for <dev@dpdk.org>; Wed, 30 Sep 2026 19:12:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790788366; x=1822324366;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=R5je/pCWt2Rpj9HzzQAtLmQfgE6FQ6krKAVH8pGrQbg=;
 b=EZxHJmEusW++1rRgWmUZMNorXm7oruxPz0GbL+RKVLCJN9vDZSSNldm5
 N2RYWMdgqLNbkhv/gjcQ13fE12O1Ib7z4SavgBRzsfJmgeG66mfRzHgbW
 HY3JRqZMq/3JCpaqOqM88uVEmRK5o6xAxAl0B/Xn+SOkL3Rl8vCcVv4vg
 T26zjkx6MUt1jS2dAv7H8cFvt57UJ4I2rMA5A950FO67+P7ELNYZtjIGF
 ZEcbWIDfsZyV9wx2ZNAArA/0tHkzETHCfRLoPOvYM60nqI1AwAZUek9pm
 d3314LsmyEcrxuIW5Q5SxjY9jduOSgYqpi41T2XLgJA50F0YtwZzEDf8C w==;
X-CSE-ConnectionGUID: 1HXF4UDnSZmfC5eBjs91/A==
X-CSE-MsgGUID: eB/QwlikTfuuIePEsQEhCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="90300410"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="90300410"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 10:12:44 -0700
X-CSE-ConnectionGUID: P+jDDXMOT4a5rPuR50KMBw==
X-CSE-MsgGUID: xKfD0GcgRVa2W0ZgWV6WTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="275293703"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 10:12:44 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 10:12:43 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 10:12:43 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.68) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 10:12:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ixwegnBeE/pjZ7RcO+P1EiKDzdTDS7HBYky7+7m4peYBagkt9iyeVHMkrJ5YDrvP5Wg/j0HAJOvnoPVqZMgE7CD4uLszGOVLnEZTsHGGujW9V80l2ur8W+2w/gdSrMF6O6VJ622ZTrbtycuZnlKchEmb0CPXtfYgbKweG2KM44z0fQNaDGz47egn5rDnkCidQswjw4uB70jLCCzuC1xnp45HQOiy0PHBrEZoh7nGKBkHN6bUlkg4wmzbBQCN5UFZO9g6AQKBctyhovepuaXeW15pR2NB9k4+WaDlGBp4FVaNeZjz+a/LP7okuE4pGXpL4zVA6dYWQa8uuNtiNk56oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5oBwgbDaB5dnT4YXSt9Zcb9yFgvTHkYo9zonxOvv6wE=;
 b=FdK9xH5a42IdRbKTbk22fHrSq88+xPTKbcUlAwAe2blgep6pxSFTC2oiNA8Ej0kfzq/fXGbf7w6V0eJl2ErlGmIi34SvJaYpbP06tFGNlpnpXGVnS26JGumf1Cccpg69hW4qNIDgLAL751rmnRPLuavHYUGKMRYcFmM3LhwnaWBonFYp852e4cT2oj+l43R6I8/MEUVCO5d4KMAbi/xxIRY1dwodMlDM3Y/4yM49H+5zzHKo75g2YGEoJE55R6V8NWQeRJyh1EuTb08DE0ANWNuRJWQlsvwmCx8lZoqgkoCU3vlKI2Pazm0cXvpAxN628kFzgMdRSYxA/dhStflGTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by IA1PR11MB6074.namprd11.prod.outlook.com (2603:10b6:208:3d6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 17:12:39 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0451.024; Wed, 30 Sep 2026
 17:12:39 +0000
Message-ID: <1263b2cc-6fc6-4b85-b542-6764c2a66825@intel.com>
Date: Wed, 30 Sep 2026 18:12:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dpdk] fib,rib: implement full network order support for
 IPv4
To: Robin Jarry <rjarry@redhat.com>, <dev@dpdk.org>
References: <20260518083935.15173-3-rjarry@redhat.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20260518083935.15173-3-rjarry@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZP191CA0020.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::7) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|IA1PR11MB6074:EE_
X-MS-Office365-Filtering-Correlation-Id: a17cc2fa-2e39-4390-b8fb-08df1f1607f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: yg7Jy2lcVvVf2ldRo3iNbr57CMY3qqKSZ1yeHnpK8P5/k9f2Ydp0tJ9YpnexcELhZaRWm8jbme7TEGXS9jg3KXMJ9uh4OEDtqrbiHXJQOht2NyzGbdN2QGBXhXUZPXcOBFlfQ3MVO8vuEPjyals/i5VAI24mZdbkGsUyOkObJcSxkenD3Ec+sh3h14Pfk13Wv4uaKhW8vPf020NnAUF6UF1luzPqHZUTxHKv8q5e5uvtS5WBt0gObXbuvfDXMRGVuWRTz9vdGhQJ5ah9VVoPLum1eIShTgULTWzUfHqx3AxRBAc1XMwlMXWtDkZAUEwdmDp9Fj07pIMbPPs1wGAmZuZUzcDvapWwe856/i3l8KGTWoW0giiFy4LXTfTBn1bTOn3zkGTWN50fhfiKSTR80Zn3QpnQ6IsSev5T8VelVNhUX39K4Jwj+NGsCz+w8ZoBCGQBG6pM+QGaUJ4iFqSprham6HVlfpP1/UxwM0nsCM/209tUQT+CSjJqlttv9yCJjfVYd1D3CgO86t60PonEt3jXPk1opBW9gzNcy4T6UHH1eXBO5PennyiNrUeVXYF3TgMtpX/2WcxLKeeu9SHXl+fu4bQt2nVgWdec8GA7exuEV09xrIpZ7JoSUaK3uFckRwi8zvmOuam67xLnio8tsBs8rSH3AZh827246pYESGA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXVBb1JxYUd6b0U2bDRvUk41MGVmRWhYOEFlVHUzZ25wNkw2MEFNNHNqdEUr?=
 =?utf-8?B?N3dYMHEvdysreTZYY1VtM3puMzN0eDZoa2tZUEVYQW5SQkhrVm5UbXh1ZVVz?=
 =?utf-8?B?MWVDWmd6ME1jRnJaSU4vbnEzQ05rVzJOT3BZeCtTaGhCYmxjUWJMV1dLUWZF?=
 =?utf-8?B?RklmTGVJWW1jQ3pnOHlBLzdUVll2TjFNWEhLT1FFdEZ3RFJDcmo4OXRaS3RW?=
 =?utf-8?B?UjVFTlVheVpjM21GWXlxMG0rMWVhR1BDK0k5TFYvQUY0bXlQcTVmd0hnN3JL?=
 =?utf-8?B?a0FEcmpqclRwNXhZbFAwaHBZVFpRMzl4bWhtQ3cvWExCdWxHTHdaS3hSTEJj?=
 =?utf-8?B?eURHNXZIeDkxNWhwWmtmQkp6OEhSczljV0ZoN2poOXRoNC8wS25qbzYyazdu?=
 =?utf-8?B?RU9jRDBoOFVkWE84MlljbGNHMzRaTGtCdGVEYmNPS0gxbVdwMU13NSt1OWM0?=
 =?utf-8?B?L25ubWJ5L3hTNE5aMmFmNnNyRmdkNXdraGxDemtodCs2RGFrS1FzS0NtMmgz?=
 =?utf-8?B?NTFyamQzS0tmQUlWblN5RTRDSXl4bzNFSkt5SmRtUFdKek1PSmNadjdwVFE3?=
 =?utf-8?B?MVhwbHFiMW95YXp6c1JTYS9mVVVwM0k4Y1BKSVU4aGtCMFUzR2c4UWtzRXN1?=
 =?utf-8?B?eG9nSEZCTGR4S3g2UkFpdHBrMk91V2JmOGppNGN0b3U2TkRVdjFLL3piZU5Z?=
 =?utf-8?B?ZDJXdFh2RVI1VEY4R1gyMU0rUUFEeCsxWjRwWU9sWDFacVhENTJGUnB5SzZR?=
 =?utf-8?B?OTNBcWdqczdmRVYzNUpNNjd5N0pxKzNZNDFPajQ1THh4T1ZCajJNTjF5dEZC?=
 =?utf-8?B?U1RjNm9yZ3RPRnlUaDZrdnFXZW5lN1YyaFh5UjZrSE00VGIwZ3pIbkE4WWdx?=
 =?utf-8?B?WGEwM3M1VWtBV0N1T3QzenlBSS93bXpIZU5xL0k2aU4xczdYcXhBcUhONkkv?=
 =?utf-8?B?bmxTTE53VWNXR1dCYnR5TUpOa3ZHZ0kwWEMrcXJuVURVV09oVHgreVRnUEl5?=
 =?utf-8?B?SkNIWEpsSGNQaU0zL2ovNHJPMmtOWDZyRWNxUUM3ZnZ4a1ZJSGY3OUNyb1ZH?=
 =?utf-8?B?TGRqaTM5S0dsbll3dTRONmtYUE5ZaEVBQnRWZGh5WXB5eTBIZVlRS011cEds?=
 =?utf-8?B?bGJZZmp0Wjc3TkQ0ekM5N3BhYWNMMVBXSW45MzdNQ05pOFlMbGNlSWdzOUxS?=
 =?utf-8?B?ZzZJTUxpZmlqeHI2dTdtSFpsRkdJRXpsV2tGOG1PdVZvNGgyOE95SlU1Sk9J?=
 =?utf-8?B?V2gxY0tKOUs0dFBydVZlUkwya2ZLNUVkRjZESjBVcDBHaUJaVE13eUdwVlE4?=
 =?utf-8?B?Z2IrTS9TRUZ6SmtiSnpBdDFsREVvYVhwUkR4c3VHZ2plVzI3dTJHQTBwcnhC?=
 =?utf-8?B?U21HMllROVlFTm5wUFV3dzhzVFU3enlQTGIxakVVcmhJSEFjUWp5ckNRdjE5?=
 =?utf-8?B?MWtlRi93R0d5UUx1SjRzNW1vZVVDZ3NIQ0NZVzY3RGNFMDlrZnFPNTdRZXh3?=
 =?utf-8?B?dGZadXpVMEdGd041UU1NQ09od095MFNENXdSR25ub1FWeVFxWThrdmFJT3p4?=
 =?utf-8?B?WnVJYUxLamRGc3F4RHpLT1FPSUpibE40SHYwbnk0Z0thYXVETmI4SUUzZGpG?=
 =?utf-8?B?SmVDUDhhVXpLQ2ltOWRCVHdiMGxiTHJzT2o2VjNza25ZcUE1SmErV29vaWVP?=
 =?utf-8?B?ZGlEcmliOExtbEFhOGRJWDVxZUgyZEdUTjNoQTFVRmcybTRkN2FBWGtmbVcz?=
 =?utf-8?B?bDllaTNtdS9zQmNFcXM3QUd5SnNpQUhHbFVOVjUxelFBaXFNZkVEY1VUdXJM?=
 =?utf-8?B?VWRML0dSN1pBOGl1N3FuSC9mMFhScjlJbmpvMDNZSWx4aDI5TTkxclhXTUtt?=
 =?utf-8?B?Y0JidHYrdFNXdW8wYmhIYW80ZFhsblZIc0pmVTRCYW1xdFp2ZEVyVnA5ZGJk?=
 =?utf-8?B?b0Z2MDV3ZXBvQ2h1aEdDQ0lEY3Y3SXJLeHVFVWxIM1JFMWJldGkwUnZHVGVl?=
 =?utf-8?B?elhKVnJkaTVsVkxuTjZjTFdMZU9TUEkrc3ZId1k5OWMxOUdBSWxkNnNsOHg1?=
 =?utf-8?B?cEZkdy8rZmZhVTNJcitxdHpmdVlCL0llSjl3alFsZ1dwVldoSC9HOHhyQnpT?=
 =?utf-8?B?SUEweEtTdm5OUFdoV21MWU1OVzFhK2ZyV1Jwd25VWEI4SnNwUHNFYUJ4Nzh6?=
 =?utf-8?B?aENWdVVnenU2bEUxME9RRWNReERzV0x6ejdYVWRwL1kzTHV1NW1tWC83dDhY?=
 =?utf-8?B?bDh0QVNBeDNBbldpZHllMDlqV3duaFVYMnVXZk01b3FYdFF4ZWNSRlRYRTlI?=
 =?utf-8?B?OElRM0E4dER6b05HZWFIMVVWVkxabnpTMzhNbnBQcnVBeVlBdlROYkN1RjNO?=
 =?utf-8?Q?LhG4aRHNeateublc=3D?=
X-Exchange-RoutingPolicyChecked: WiAmjpZ5nAF5VnHy/aWZXYb00gVF0R6XHz2WxJKfJNYnzt+v3zM25ujHnYzM6h+JBqD6lSpP25x1z/QWg/tWViktzcXjNgZf5nszEMEMymMJ1WBu8aQHmtlQEAJdIQOJE8NKqKT3ffqvr+jPRh2DfMn673BV14GKAU+kGhiBkmJKWBZNs+UI0ykQ0jGPsW1zPLAzv0G6YOUPK7oaAJqCe4ETT1hh+nESiwuTRYwSPb20eJ4A94CxJrXvAvpyRe4BJFMWa+k27E9JsAXc68ZhaW7mW34D+GIpWrCMuUDwis8959EWALNRgfZRf+1MLbmP2Y7dX9elbsH+1mfpVbxGOQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: a17cc2fa-2e39-4390-b8fb-08df1f1607f1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 17:12:39.4844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O6sy5S7DhvMyBd8lhYePOjgp7cFZzUkDr/lwltHjWTMZaFZX0qqsBq3TMaGrx8wE/hJN2KdmPdHGgdUcN5uan/werSiqpi1lHIbx1M/cbVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6074
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

Hi Robin,

Thanks for the patch.

check-git-log.sh reports
Wrong headline format:
         fib,rib: implement full network order support for IPv4
could you please split for 2 patches?

A few comments inline.
Also reflect changes in release notes please.

On 5/18/2026 9:39 AM, Robin Jarry wrote:
> Control plane stacks deal exclusively with network byte order addresses.
> The existing RTE_FIB_F_LOOKUP_NETWORK_ORDER flag only covers datapath
> lookups, forcing callers to convert every address back and forth when
> adding or deleting routes.
>
> Rename RTE_FIB_F_LOOKUP_NETWORK_ORDER to RTE_FIB_F_NETWORK_ORDER (keep
> the old name with a deprecation notice) and add a new opt-in flag:
> RTE_RIB_F_NETWORK_ORDER.
>
> When these flags are specified, *all* user-facing IPv4 functions accept
> and return addresses in network byte order. Internally, both libraries
> keep operating in host order; the conversion happens at the public API
> boundary only.
>
> For rte_rib, a per-node flag bit tracks whether rte_rib_get_ip()
> should convert back to network order, since that function does not
> take a rib pointer.
>
> When creating a FIB with RTE_FIB_F_NETWORK_ORDER, make sure that its
> internal RIB object has the corresponding RTE_RIB_F_NETWORK_ORDER.
>
> Signed-off-by: Robin Jarry <rjarry@redhat.com>
> ---
>   app/test/test_fib.c | 80 +++++++++++++++++++++++++++++++++++++++++++++
>   app/test/test_rib.c | 59 +++++++++++++++++++++++++++++++++
>   lib/fib/dir24_8.c   | 29 ++++++++++++----
>   lib/fib/dir24_8.h   |  1 +
>   lib/fib/rte_fib.c   |  6 ++--
>   lib/fib/rte_fib.h   |  8 +++--
>   lib/rib/rte_rib.c   | 74 +++++++++++++++++++++++++++++++----------
>   lib/rib/rte_rib.h   |  5 +++
>   8 files changed, 233 insertions(+), 29 deletions(-)
>
> diff --git a/app/test/test_fib.c b/app/test/test_fib.c
> index bd73399d565c..84b57eef3b5a 100644
> --- a/app/test/test_fib.c
> +++ b/app/test/test_fib.c
> @@ -7,6 +7,7 @@
>   #include <stdint.h>
>   #include <stdlib.h>
>   
> +#include <rte_byteorder.h>
>   #include <rte_ip.h>
>   #include <rte_log.h>
>   #include <rte_fib.h>
> @@ -24,6 +25,7 @@ static int32_t test_get_invalid(void);
>   static int32_t test_lookup(void);
>   static int32_t test_invalid_rcu(void);
>   static int32_t test_fib_rcu_sync_rw(void);
> +static int32_t test_network_order(void);
>   
>   #define MAX_ROUTES	(1 << 16)
>   #define MAX_TBL8	(1 << 15)
> @@ -588,6 +590,83 @@ test_fib_rcu_sync_rw(void)
>   	return status == 0 ? TEST_SUCCESS : TEST_FAILED;
>   }
>   
> +int32_t
> +test_network_order(void)
> +{
> +	struct rte_fib *fib = NULL;
> +	struct rte_fib_conf config = { 0 };
> +	uint32_t ip_he = RTE_IPV4(192, 0, 2, 0);
> +	uint32_t ip_be = rte_cpu_to_be_32(ip_he);
> +	uint32_t ip_miss_be = rte_cpu_to_be_32(RTE_IPV4(10, 0, 0, 1));
> +	uint64_t def_nh = 100;
> +	uint64_t nh_set = 42;
> +	uint64_t nh_arr[3];
> +	uint32_t ip_arr[3];
> +	int ret;
> +
> +	config.max_routes = MAX_ROUTES;
> +	config.rib_ext_sz = 0;
> +	config.default_nh = def_nh;
> +	config.type = RTE_FIB_DUMMY;
> +	config.flags = RTE_FIB_F_NETWORK_ORDER;
> +
> +	fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
> +	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
> +
> +	ret = rte_fib_add(fib, ip_be, 24, nh_set);
> +	RTE_TEST_ASSERT(ret == 0, "Failed to add route\n");
> +
> +	ip_arr[0] = ip_be;
> +	ip_arr[1] = rte_cpu_to_be_32(RTE_IPV4(192, 0, 2, 123));
> +	ip_arr[2] = ip_miss_be;
> +
> +	ret = rte_fib_lookup_bulk(fib, ip_arr, nh_arr, 3);
> +	RTE_TEST_ASSERT(ret == 0, "Failed to lookup\n");
> +	RTE_TEST_ASSERT(nh_arr[0] == nh_set,
> +		"Failed to get proper nexthop for prefix\n");
> +	RTE_TEST_ASSERT(nh_arr[1] == nh_set,
> +		"Failed to get proper nexthop for covered IP\n");
> +	RTE_TEST_ASSERT(nh_arr[2] == def_nh,
> +		"Failed to get default nexthop for missing IP\n");
> +
> +	ret = rte_fib_delete(fib, ip_be, 24);
> +	RTE_TEST_ASSERT(ret == 0, "Failed to delete route\n");
> +
> +	ret = rte_fib_lookup_bulk(fib, ip_arr, nh_arr, 1);
> +	RTE_TEST_ASSERT(ret == 0, "Failed to lookup\n");
> +	RTE_TEST_ASSERT(nh_arr[0] == def_nh,
> +		"Failed to get default nexthop after delete\n");
> +
> +	rte_fib_free(fib);
> +
> +	/* repeat with DIR24_8 */
> +	config.type = RTE_FIB_DIR24_8;
> +	config.dir24_8.nh_sz = RTE_FIB_DIR24_8_4B;
> +	config.dir24_8.num_tbl8 = MAX_TBL8;
> +
> +	fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
> +	RTE_TEST_ASSERT(fib != NULL, "Failed to create DIR24_8 FIB\n");
> +
> +	ret = rte_fib_add(fib, ip_be, 24, nh_set);
> +	RTE_TEST_ASSERT(ret == 0, "Failed to add route\n");
it is probably worth to add an extra more specific route to better 
coverage. Or keep RIB in host order and byteswap inside the 
rte_fib_add() as I suggested below
> +
> +	ret = rte_fib_lookup_bulk(fib, ip_arr, nh_arr, 3);
> +	RTE_TEST_ASSERT(ret == 0, "Failed to lookup\n");
> +	RTE_TEST_ASSERT(nh_arr[0] == nh_set,
> +		"Failed to get proper nexthop for prefix\n");
> +	RTE_TEST_ASSERT(nh_arr[1] == nh_set,
> +		"Failed to get proper nexthop for covered IP\n");
> +	RTE_TEST_ASSERT(nh_arr[2] == def_nh,
> +		"Failed to get default nexthop for missing IP\n");
> +
> +	ret = rte_fib_delete(fib, ip_be, 24);
> +	RTE_TEST_ASSERT(ret == 0, "Failed to delete route\n");
> +
> +	rte_fib_free(fib);
> +
> +	return TEST_SUCCESS;
> +}
> +
>   static struct unit_test_suite fib_fast_tests = {
>   	.suite_name = "fib autotest",
>   	.setup = NULL,
> @@ -600,6 +679,7 @@ static struct unit_test_suite fib_fast_tests = {
>   	TEST_CASE(test_lookup),
>   	TEST_CASE(test_invalid_rcu),
>   	TEST_CASE(test_fib_rcu_sync_rw),
> +	TEST_CASE(test_network_order),
>   	TEST_CASES_END()
>   	}
>   };
> diff --git a/app/test/test_rib.c b/app/test/test_rib.c
> index a4a683140df3..200533e84e09 100644
> --- a/app/test/test_rib.c
> +++ b/app/test/test_rib.c
> @@ -21,6 +21,7 @@ static int32_t test_insert_invalid(void);
>   static int32_t test_get_fn(void);
>   static int32_t test_basic(void);
>   static int32_t test_tree_traversal(void);
> +static int32_t test_network_order(void);
>   
>   #define MAX_DEPTH 32
>   #define MAX_RULES (1 << 22)
> @@ -323,6 +324,63 @@ test_tree_traversal(void)
>   	return TEST_SUCCESS;
>   }
>   
> +int32_t
> +test_network_order(void)
> +{
> +	struct rte_rib *rib = NULL;
> +	struct rte_rib_node *node;
> +	struct rte_rib_conf config;
> +
> +	uint32_t ip_he = RTE_IPV4(192, 0, 2, 0);
just a nit: ip_he does it stands for "host endian"? ip_ho instead for 
"host order"?
> +	uint32_t ip_be = rte_cpu_to_be_32(ip_he);
> +	uint32_t ip_ret;
> +	uint64_t nh_set = 42;
> +	uint64_t nh_ret;
> +	uint8_t depth = 24;
> +	int ret;
> +
> +	config.max_nodes = MAX_RULES;
> +	config.ext_sz = 0;
> +	config.flags = RTE_RIB_F_NETWORK_ORDER;
> +
> +	rib = rte_rib_create(__func__, SOCKET_ID_ANY, &config);
> +	RTE_TEST_ASSERT(rib != NULL, "Failed to create RIB\n");
> +
> +	node = rte_rib_insert(rib, ip_be, depth);
> +	RTE_TEST_ASSERT(node != NULL, "Failed to insert rule\n");
> +
> +	ret = rte_rib_set_nh(node, nh_set);
> +	RTE_TEST_ASSERT(ret == 0, "Failed to set nh\n");
> +
> +	/* lookup with network-order IP */
> +	node = rte_rib_lookup(rib, ip_be);
> +	RTE_TEST_ASSERT(node != NULL, "Failed to lookup\n");
> +
> +	ret = rte_rib_get_nh(node, &nh_ret);
> +	RTE_TEST_ASSERT((ret == 0) && (nh_ret == nh_set),
> +		"Failed to get proper nexthop\n");
> +
> +	/* get_ip must return network-order IP */
> +	ret = rte_rib_get_ip(node, &ip_ret);
> +	RTE_TEST_ASSERT((ret == 0) && (ip_ret == ip_be),
> +		"Failed to get proper IP in network order\n");
> +
> +	/* exact lookup with network-order IP */
> +	node = rte_rib_lookup_exact(rib, ip_be, depth);
> +	RTE_TEST_ASSERT(node != NULL, "Failed to exact lookup\n");
> +
> +	/* remove with network-order IP */
> +	rte_rib_remove(rib, ip_be, depth);
> +
> +	node = rte_rib_lookup(rib, ip_be);
> +	RTE_TEST_ASSERT(node == NULL,
> +		"Lookup returns non existent rule\n");
> +
> +	rte_rib_free(rib);
> +
> +	return TEST_SUCCESS;
> +}
> +
>   static struct unit_test_suite rib_tests = {
>   	.suite_name = "rib autotest",
>   	.setup = NULL,
> @@ -334,6 +392,7 @@ static struct unit_test_suite rib_tests = {
>   		TEST_CASE(test_get_fn),
>   		TEST_CASE(test_basic),
>   		TEST_CASE(test_tree_traversal),
> +		TEST_CASE(test_network_order),
>   		TEST_CASES_END()
>   	}
>   };
> diff --git a/lib/fib/dir24_8.c b/lib/fib/dir24_8.c
> index 489d2ef427c6..781ecbe9e64e 100644
> --- a/lib/fib/dir24_8.c
> +++ b/lib/fib/dir24_8.c
> @@ -414,24 +414,33 @@ install_to_fib(struct dir24_8_tbl *dp, uint32_t ledge, uint32_t redge,
>   	return 0;
>   }
>   
> +/*
> + * modify_fib operates in host byte order. When the RIB carries the
> + * network-order flag, rte_rib_get_nxt/rte_rib_get_ip return addresses

nit: rte_rib_get_nxt() does not return address directly. It accepts it as an argument

> + * in network order, so this helper converts them back to host order
> + * for DIR24_8 table operations.
> + */
>   static int
>   modify_fib(struct dir24_8_tbl *dp, struct rte_rib *rib, uint32_t ip,
>   	uint8_t depth, uint64_t next_hop)
>   {
>   	struct rte_rib_node *tmp = NULL;
>   	uint32_t ledge, redge, tmp_ip;
> +	uint32_t rib_ip = dp->be_addr ? rte_cpu_to_be_32(ip) : ip;
>   	int ret;
>   	uint8_t tmp_depth;
>   
>   	ledge = ip;
>   	do {
> -		tmp = rte_rib_get_nxt(rib, ip, depth, tmp,
> +		tmp = rte_rib_get_nxt(rib, rib_ip, depth, tmp,
>   			RTE_RIB_GET_NXT_COVER);
>   		if (tmp != NULL) {
>   			rte_rib_get_depth(tmp, &tmp_depth);
>   			if (tmp_depth == depth)
>   				continue;
>   			rte_rib_get_ip(tmp, &tmp_ip);
> +			if (dp->be_addr)
> +				tmp_ip = rte_be_to_cpu_32(tmp_ip);
>   			redge = tmp_ip & rte_rib_depth_to_mask(tmp_depth);
>   			if (ledge == redge) {
>   				ledge = redge +
> @@ -475,6 +484,7 @@ dir24_8_modify(struct rte_fib *fib, uint32_t ip, uint8_t depth,
>   	struct rte_rib_node *parent;
>   	int ret = 0;
>   	uint64_t par_nh, node_nh;
> +	uint32_t ip_he;
>   
>   	if ((fib == NULL) || (depth > RTE_FIB_MAXDEPTH))
>   		return -EINVAL;
> @@ -486,7 +496,13 @@ dir24_8_modify(struct rte_fib *fib, uint32_t ip, uint8_t depth,
>   	if (next_hop > get_max_nh(dp->nh_sz))
>   		return -EINVAL;
>   
> -	ip &= rte_rib_depth_to_mask(depth);
> +	/*
> +	 * The RIB API handles byte order conversion when the
> +	 * network-order flag is set. DIR24_8 table operations
> +	 * require host-order addresses.
> +	 */
> +	ip_he = dp->be_addr ? rte_be_to_cpu_32(ip) : ip;
> +	ip_he &= rte_rib_depth_to_mask(depth);
>   
>   	node = rte_rib_lookup_exact(rib, ip, depth);
>   	switch (op) {
> @@ -495,7 +511,7 @@ dir24_8_modify(struct rte_fib *fib, uint32_t ip, uint8_t depth,
>   			rte_rib_get_nh(node, &node_nh);
>   			if (node_nh == next_hop)
>   				return 0;
> -			ret = modify_fib(dp, rib, ip, depth, next_hop);
> +			ret = modify_fib(dp, rib, ip_he, depth, next_hop);
>   			if (ret == 0)
>   				rte_rib_set_nh(node, next_hop);
>   			return 0;
> @@ -518,7 +534,7 @@ dir24_8_modify(struct rte_fib *fib, uint32_t ip, uint8_t depth,
>   			if (par_nh == next_hop)
>   				goto successfully_added;
>   		}
> -		ret = modify_fib(dp, rib, ip, depth, next_hop);
> +		ret = modify_fib(dp, rib, ip_he, depth, next_hop);
>   		if (ret != 0) {
>   			rte_rib_remove(rib, ip, depth);
>   			return ret;
> @@ -536,9 +552,9 @@ dir24_8_modify(struct rte_fib *fib, uint32_t ip, uint8_t depth,
>   			rte_rib_get_nh(parent, &par_nh);
>   			rte_rib_get_nh(node, &node_nh);
>   			if (par_nh != node_nh)
> -				ret = modify_fib(dp, rib, ip, depth, par_nh);
> +				ret = modify_fib(dp, rib, ip_he, depth, par_nh);
>   		} else
> -			ret = modify_fib(dp, rib, ip, depth, dp->def_nh);
> +			ret = modify_fib(dp, rib, ip_he, depth, dp->def_nh);
>   		if (ret == 0) {
>   			rte_rib_remove(rib, ip, depth);
>   			if (depth > 24) {
> @@ -606,6 +622,7 @@ dir24_8_create(const char *name, int socket_id, struct rte_fib_conf *fib_conf)
>   	dp->def_nh = def_nh;
>   	dp->nh_sz = nh_sz;
>   	dp->number_tbl8s = num_tbl8;
> +	dp->be_addr = !!(fib_conf->flags & RTE_FIB_F_NETWORK_ORDER);
>   
>   	snprintf(mem_name, sizeof(mem_name), "TBL8_idxes_%p", dp);
>   	dp->tbl8_idxes = rte_zmalloc_socket(mem_name,
> diff --git a/lib/fib/dir24_8.h b/lib/fib/dir24_8.h
> index b343b5d6866d..d4fa248cfb88 100644
> --- a/lib/fib/dir24_8.h
> +++ b/lib/fib/dir24_8.h
> @@ -33,6 +33,7 @@ struct dir24_8_tbl {
>   	uint32_t	rsvd_tbl8s;	/**< Number of reserved tbl8s */
>   	uint32_t	cur_tbl8s;	/**< Current number of tbl8s */
>   	enum rte_fib_dir24_8_nh_sz	nh_sz;	/**< Size of nexthop entry */
> +	bool		be_addr;	/**< User addresses in network order */
>   	/* RCU config. */
>   	enum rte_fib_qsbr_mode rcu_mode;/* Blocking, defer queue. */
>   	struct rte_rcu_qsbr *v;		/* RCU QSBR variable. */
> diff --git a/lib/fib/rte_fib.c b/lib/fib/rte_fib.c
> index 184210f38070..3e4c15cfc809 100644
> --- a/lib/fib/rte_fib.c
> +++ b/lib/fib/rte_fib.c
> @@ -109,7 +109,7 @@ init_dataplane(struct rte_fib *fib, __rte_unused int socket_id,
>   		if (fib->dp == NULL)
>   			return -rte_errno;
>   		fib->lookup = dir24_8_get_lookup_fn(fib->dp,
> -			RTE_FIB_LOOKUP_DEFAULT, !!(fib->flags & RTE_FIB_F_LOOKUP_NETWORK_ORDER));
> +			RTE_FIB_LOOKUP_DEFAULT, !!(fib->flags & RTE_FIB_F_NETWORK_ORDER));
>   		fib->modify = dir24_8_modify;
>   		return 0;
>   	default:
> @@ -172,6 +172,8 @@ rte_fib_create(const char *name, int socket_id, struct rte_fib_conf *conf)
>   
>   	rib_conf.ext_sz = conf->rib_ext_sz;
>   	rib_conf.max_nodes = conf->max_routes * 2;
> +	rib_conf.flags = (conf->flags & RTE_FIB_F_NETWORK_ORDER) ?
> +		RTE_RIB_F_NETWORK_ORDER : 0;
do we really need to align the RIB and FIB byte order? Since the RIB 
structure is internal, why not keep it in host order and byteswap just 
once at the API boundary, i.e. in _fib_add/del? In that case, we 
wouldn’t need to touch the internal algorithm-specific code (dir24_8). 
This would make things an order of magnitude simpler and cleaner.
>   
>   	rib = rte_rib_create(name, socket_id, &rib_conf);
>   	if (rib == NULL) {
> @@ -340,7 +342,7 @@ rte_fib_select_lookup(struct rte_fib *fib,
>   	switch (fib->type) {
>   	case RTE_FIB_DIR24_8:
>   		fn = dir24_8_get_lookup_fn(fib->dp, type,
> -			!!(fib->flags & RTE_FIB_F_LOOKUP_NETWORK_ORDER));
> +			!!(fib->flags & RTE_FIB_F_NETWORK_ORDER));
>   		if (fn == NULL)
>   			return -EINVAL;
>   		fib->lookup = fn;
> diff --git a/lib/fib/rte_fib.h b/lib/fib/rte_fib.h
> index b16a653535cf..5542e735b6f3 100644
> --- a/lib/fib/rte_fib.h
> +++ b/lib/fib/rte_fib.h
> @@ -91,9 +91,11 @@ enum rte_fib_lookup_type {
>   	/**< Vector implementation using AVX512 */
>   };
>   
> -/** If set, fib lookup is expecting IPv4 address in network byte order */
> -#define RTE_FIB_F_LOOKUP_NETWORK_ORDER 1
> -#define RTE_FIB_ALLOWED_FLAGS (RTE_FIB_F_LOOKUP_NETWORK_ORDER)
> +/** If set, all user-facing IPv4 addresses are in network byte order */
> +#define RTE_FIB_F_NETWORK_ORDER 1
> +#define RTE_FIB_F_LOOKUP_NETWORK_ORDER \
> +	(RTE_DEPRECATED(RTE_FIB_F_LOOKUP_NETWORK_ORDER) RTE_FIB_F_NETWORK_ORDER)
I'd suggest to keep 2 flags at the moment - the old one just for lookup 
and a new one for lookup and control plane operations
> +#define RTE_FIB_ALLOWED_FLAGS (RTE_FIB_F_NETWORK_ORDER)
>   
>   /** FIB configuration structure */
>   struct rte_fib_conf {
> diff --git a/lib/rib/rte_rib.c b/lib/rib/rte_rib.c
> index 046db131ca00..c6dbe684d211 100644
> --- a/lib/rib/rte_rib.c
> +++ b/lib/rib/rte_rib.c
> @@ -8,6 +8,7 @@
>   #include <sys/queue.h>
>   
>   #include <eal_export.h>
> +#include <rte_byteorder.h>
>   #include <rte_eal_memconfig.h>
>   #include <rte_errno.h>
>   #include <rte_malloc.h>
> @@ -28,6 +29,8 @@ static struct rte_tailq_elem rte_rib_tailq = {
>   EAL_REGISTER_TAILQ(rte_rib_tailq)
>   
>   #define RTE_RIB_VALID_NODE	1
> +#define RIB_NODE_NET_ORDER	2
RTE_RIB_NET_ORDER_NODE, just to avoid confusion with current naming? 
Also since this is a bit flag it would be better to define it via bit 
shift instead of a power of 2 digit
> +#define RTE_RIB_ALLOWED_FLAGS	(RTE_RIB_F_NETWORK_ORDER)
>   /* Maximum depth value possible for IPv4 RIB. */
>   #define RIB_MAXDEPTH		32
>   /* Maximum length of a RIB name. */
> @@ -51,6 +54,7 @@ struct rte_rib {
>   	uint32_t		cur_nodes;
>   	uint32_t		cur_routes;
>   	uint32_t		max_nodes;
> +	unsigned int		flags;
>   };
>   
>   static inline bool
> @@ -112,6 +116,8 @@ rte_rib_lookup(struct rte_rib *rib, uint32_t ip)
>   		rte_errno = EINVAL;
>   		return NULL;
>   	}
> +	if (rib->flags & RTE_RIB_F_NETWORK_ORDER)
> +		ip = rte_be_to_cpu_32(ip);
>   
>   	cur = rib->tree;
>   	while ((cur != NULL) && is_covered(ip, cur->ip, cur->depth)) {
> @@ -162,6 +168,8 @@ rte_rib_lookup_exact(struct rte_rib *rib, uint32_t ip, uint8_t depth)
>   		rte_errno = EINVAL;
>   		return NULL;
>   	}
> +	if (rib->flags & RTE_RIB_F_NETWORK_ORDER)
> +		ip = rte_be_to_cpu_32(ip);
>   	ip &= rte_rib_depth_to_mask(depth);
>   
>   	return __rib_lookup_exact(rib, ip, depth);
> @@ -172,18 +180,12 @@ rte_rib_lookup_exact(struct rte_rib *rib, uint32_t ip, uint8_t depth)
>    *  for a given in args ip/depth prefix
>    *  last = NULL means the first invocation
>    */
> -RTE_EXPORT_SYMBOL(rte_rib_get_nxt)
> -struct rte_rib_node *
> -rte_rib_get_nxt(struct rte_rib *rib, uint32_t ip,
> +static struct rte_rib_node *
> +__rib_get_nxt(struct rte_rib *rib, uint32_t ip,
>   	uint8_t depth, struct rte_rib_node *last, int flag)
>   {
>   	struct rte_rib_node *tmp, *prev = NULL;
>   
> -	if (unlikely(rib == NULL || depth > RIB_MAXDEPTH)) {
> -		rte_errno = EINVAL;
> -		return NULL;
> -	}
> -
>   	if (last == NULL) {
>   		tmp = rib->tree;
>   		while ((tmp) && (tmp->depth < depth))
> @@ -213,13 +215,28 @@ rte_rib_get_nxt(struct rte_rib *rib, uint32_t ip,
>   	return prev;
>   }
>   
> -RTE_EXPORT_SYMBOL(rte_rib_remove)
> -void
> -rte_rib_remove(struct rte_rib *rib, uint32_t ip, uint8_t depth)
> +RTE_EXPORT_SYMBOL(rte_rib_get_nxt)
> +struct rte_rib_node *
> +rte_rib_get_nxt(struct rte_rib *rib, uint32_t ip,
> +	uint8_t depth, struct rte_rib_node *last, int flag)
> +{
> +	if (unlikely(rib == NULL || depth > RIB_MAXDEPTH)) {
> +		rte_errno = EINVAL;
> +		return NULL;
> +	}
> +	if (rib->flags & RTE_RIB_F_NETWORK_ORDER)
> +		ip = rte_be_to_cpu_32(ip);
> +
> +	return __rib_get_nxt(rib, ip, depth, last, flag);
> +}
> +
> +static void
> +__rib_remove(struct rte_rib *rib, uint32_t ip, uint8_t depth)
>   {
>   	struct rte_rib_node *cur, *prev, *child;
>   
> -	cur = rte_rib_lookup_exact(rib, ip, depth);
> +	ip &= rte_rib_depth_to_mask(depth);
> +	cur = __rib_lookup_exact(rib, ip, depth);
>   	if (cur == NULL)
>   		return;
>   
> @@ -246,6 +263,17 @@ rte_rib_remove(struct rte_rib *rib, uint32_t ip, uint8_t depth)
>   	}
>   }
>   
> +RTE_EXPORT_SYMBOL(rte_rib_remove)
> +void
> +rte_rib_remove(struct rte_rib *rib, uint32_t ip, uint8_t depth)
> +{
> +	if (unlikely(rib == NULL || depth > RIB_MAXDEPTH))
> +		return;
> +	if (rib->flags & RTE_RIB_F_NETWORK_ORDER)
> +		ip = rte_be_to_cpu_32(ip);
> +	__rib_remove(rib, ip, depth);
> +}
> +
>   RTE_EXPORT_SYMBOL(rte_rib_insert)
>   struct rte_rib_node *
>   rte_rib_insert(struct rte_rib *rib, uint32_t ip, uint8_t depth)
> @@ -257,12 +285,18 @@ rte_rib_insert(struct rte_rib *rib, uint32_t ip, uint8_t depth)
>   	int d = 0;
>   	uint32_t common_prefix;
>   	uint8_t common_depth;
> +	uint8_t net_order = 0;
>   
>   	if (unlikely(rib == NULL || depth > RIB_MAXDEPTH)) {
>   		rte_errno = EINVAL;
>   		return NULL;
>   	}
>   
> +	if (rib->flags & RTE_RIB_F_NETWORK_ORDER) {
> +		ip = rte_be_to_cpu_32(ip);
> +		net_order = RIB_NODE_NET_ORDER;
> +	}
> +
>   	tmp = &rib->tree;
>   	ip &= rte_rib_depth_to_mask(depth);
>   	new_node = __rib_lookup_exact(rib, ip, depth);
> @@ -281,7 +315,7 @@ rte_rib_insert(struct rte_rib *rib, uint32_t ip, uint8_t depth)
>   	new_node->parent = NULL;
>   	new_node->ip = ip;
>   	new_node->depth = depth;
> -	new_node->flag = RTE_RIB_VALID_NODE;
> +	new_node->flag = RTE_RIB_VALID_NODE | net_order;
>   
>   	/* traverse down the tree to find matching node or closest matching */
>   	while (1) {
> @@ -300,7 +334,7 @@ rte_rib_insert(struct rte_rib *rib, uint32_t ip, uint8_t depth)
>   		 */
>   		if ((ip == (*tmp)->ip) && (depth == (*tmp)->depth)) {
>   			node_free(rib, new_node);
> -			(*tmp)->flag |= RTE_RIB_VALID_NODE;
> +			(*tmp)->flag |= RTE_RIB_VALID_NODE | net_order;
>   			++rib->cur_routes;
>   			return *tmp;
>   		}
> @@ -336,7 +370,7 @@ rte_rib_insert(struct rte_rib *rib, uint32_t ip, uint8_t depth)
>   		}
>   		common_node->ip = common_prefix;
>   		common_node->depth = common_depth;
> -		common_node->flag = 0;
> +		common_node->flag = net_order;
>   		common_node->parent = (*tmp)->parent;
>   		new_node->parent = common_node;
>   		(*tmp)->parent = common_node;
> @@ -362,6 +396,8 @@ rte_rib_get_ip(const struct rte_rib_node *node, uint32_t *ip)
>   		return -1;
>   	}
>   	*ip = node->ip;
> +	if (node->flag & RIB_NODE_NET_ORDER)
> +		*ip = rte_cpu_to_be_32(*ip);
plz reflect this change of behavior in doxygen
>   	return 0;
>   }
>   
> @@ -419,7 +455,8 @@ rte_rib_create(const char *name, int socket_id, const struct rte_rib_conf *conf)
>   	struct rte_mempool *node_pool;
>   
>   	/* Check user arguments. */
> -	if (unlikely(name == NULL || conf == NULL || conf->max_nodes <= 0)) {
> +	if (unlikely(name == NULL || conf == NULL || conf->max_nodes <= 0 ||
> +			(conf->flags & ~RTE_RIB_ALLOWED_FLAGS))) {
>   		rte_errno = EINVAL;
>   		return NULL;
>   	}
> @@ -473,6 +510,7 @@ rte_rib_create(const char *name, int socket_id, const struct rte_rib_conf *conf)
>   	rte_strlcpy(rib->name, name, sizeof(rib->name));
>   	rib->tree = NULL;
>   	rib->max_nodes = conf->max_nodes;
> +	rib->flags = conf->flags;
>   	rib->node_pool = node_pool;
>   	te->data = (void *)rib;
>   	TAILQ_INSERT_TAIL(rib_list, te, next);
> @@ -541,9 +579,9 @@ rte_rib_free(struct rte_rib *rib)
>   
>   	rte_mcfg_tailq_write_unlock();
>   
> -	while ((tmp = rte_rib_get_nxt(rib, 0, 0, tmp,
> +	while ((tmp = __rib_get_nxt(rib, 0, 0, tmp,
>   			RTE_RIB_GET_NXT_ALL)) != NULL)
> -		rte_rib_remove(rib, tmp->ip, tmp->depth);
> +		__rib_remove(rib, tmp->ip, tmp->depth);
>   
>   	rte_mempool_free(rib->node_pool);
>   	rte_free(rib);
> diff --git a/lib/rib/rte_rib.h b/lib/rib/rte_rib.h
> index c325b3e3618c..085e507508be 100644
> --- a/lib/rib/rte_rib.h
> +++ b/lib/rib/rte_rib.h
> @@ -17,6 +17,7 @@
>   #include <stdlib.h>
>   #include <stdint.h>
>   
> +#include <rte_byteorder.h>
why include it here in .h?
>   #include <rte_common.h>
>   
>   #ifdef __cplusplus
> @@ -36,6 +37,9 @@ enum {
>   struct rte_rib;
>   struct rte_rib_node;
>   
> +/** If set, all user-facing IPv4 addresses are in network byte order */
> +#define RTE_RIB_F_NETWORK_ORDER 1
> +
>   /** RIB configuration structure */
>   struct rte_rib_conf {
>   	/**
> @@ -46,6 +50,7 @@ struct rte_rib_conf {
>   	size_t	ext_sz;
>   	/* size of rte_rib_node's pool */
>   	int	max_nodes;
> +	unsigned int flags; /**< Optional feature flags from RTE_RIB_F_* */
old tests (and all possible places we're using rte_rib_conf struct) 
should be updated to account for this new flag
>   };
>   
>   /**

-- 
Regards,
Vladimir

