Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9709C982D8
	for <dpdk-dev@archiver.kernel.org>; Sat, 19 Sep 2026 16:14:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DD5440DD1;
	Sat, 19 Sep 2026 18:14:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
 by mails.dpdk.org (Postfix) with ESMTP id 0EE0C40B94
 for <dev@dpdk.org>; Sat, 19 Sep 2026 18:14:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789834445; x=1821370445;
 h=message-id:date:from:subject:to:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=Fvp8S3OE/rqziUxFT92Z6F0X6f2KmR0KpIR+HtL9sBU=;
 b=dsnwSWKQW581ebyKN/iKHrtywMirnZ+yFS2IMkmjwONG1O2lpBohnrI1
 4uGJ+5M8FFPrK8Y5sk9lcJufA0wySkmxYTNQtE4FDkAzBEDnEzwofE5Jh
 PvP+XB/L4tVxWLVlEpMSNKgoNJ4W7R+4hww3+y9bS7rCkWjnjOmVe7kLN
 /+ZYwHNAPyi0KVo1enTqqaAdezgYdCgRD7l9YcoewxNxVaR6D/CtcNYr2
 ML2fMl1N+jah5nQCkoyWCIkjssRKoavy0N5RFKaFcwg7j32GyrWBBv3JJ
 QcryNPVGe83rKvPpP6y4DnzFLa3m1e2rHtN7UTWb/Wm/odPp4nyqL/VRA Q==;
X-CSE-ConnectionGUID: 0QqYEqZBQqCzytUX7pc2gQ==
X-CSE-MsgGUID: aHHqBn67QXefTKJKXdaU9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11910"; a="870052"
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="870052"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2026 09:14:04 -0700
X-CSE-ConnectionGUID: 3hNXqt/cTjaE4iNTMh/74g==
X-CSE-MsgGUID: ZSR/5KT1SLmFe62+5CXF5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; d="scan'208";a="270557632"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2026 09:14:04 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 19 Sep 2026 09:14:03 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Sat, 19 Sep 2026 09:14:03 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.16) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 19 Sep 2026 09:14:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GVFKws8AH33CfWju/kbYxnoGk0SDkwteAgRzPOlLbyhHEzTBPZkfviF210o8VSQMZEvk2WtoYdNdFrXygHN++sBWl11MlfKsoO/EmReLRPIABPKQYNET/cZMn4er2jGwC3JEhqDRviaVi1WAI0CWy/T63ugUmFDKGKruUSF7AxMdz1XGkUPzO8jkhu3MSfSZcbVyo+/qqR8g96qDuz4R/5eUbIEfmAX4zcDtfmx3u6JwckvEubGm6GYT2eKsUMHJX0wRUtTCpSTMvydoCKJjAqA/8L90fw6aScSInTvt1BVyRfem2D+mIb1BpTbK3ZgCvAqD9Qn2LaqxF0zLEyiO0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86lk2ivOh7MTQk10rL0zxxZxBWdf+57xgGKJAOQT9tA=;
 b=IGHvjviSn7q+0UbuPZzvAJFWdLMzcVuFl8jY6Gak5GbxATh3zVj794weNR2GdzZggv1t9VeAKA1+kMmlWD3QFSJ1dWa1ouVgY47FRc3ZAdxGfAq5Ct+Y9ihm/wk+I/j+IK+zDPOvL/fEmqXLqlcylywfVjZXH/7lxfSmtROgWkd0WrIhePwC2xZa+i+AjfK7VK901kbZt1p8hW5jGmURX2zq9I67RB67Nse84at8stg14Z6Ipk6ZiKLVKpeXNiHKDAQel6qgbcUCQW8KIlUvsrkRHJQFjGEUyXhCk5+umPqENQKJMg3jW+jbAQzhZOsFwXCa1B1dKGgJuRtPUL0odA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by SA0PR11MB4526.namprd11.prod.outlook.com (2603:10b6:806:96::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Sat, 19 Sep
 2026 16:14:02 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0428.014; Sat, 19 Sep 2026
 16:14:02 +0000
Message-ID: <a469a325-3f1b-41e9-af16-6786cc15e02c@intel.com>
Date: Sat, 19 Sep 2026 17:13:59 +0100
User-Agent: Mozilla Thunderbird
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v3 16/19] net/i40e: reimplement FDIR parser
To: <dev@dpdk.org>, Bruce Richardson <bruce.richardson@intel.com>
References: <07365d0ba0cc31b21f5004971c4e98a6ad0aca05.1789560946.git.anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <07365d0ba0cc31b21f5004971c4e98a6ad0aca05.1789560946.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2P251CA0020.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::29) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|SA0PR11MB4526:EE_
X-MS-Office365-Filtering-Correlation-Id: bae46a31-4e57-4e24-bfdb-08df166904e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|10067099003|3023799007|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: T6RN/D58fF+E9V84laM2aNFw4QGmIIS4pKYRXeJ3RQkTwx+07KSJOQA03MO5Fkdb53srJCwl732R/PP1vReOQkvX8i8KfcNSyUO3vO3hfm12IG4Z1JH0VsGarcMbLZEeZDG5HV7/E+thZBGlmMclMO/2dNVIGlt2tx+qV3vUozsfws5PtjQB5IPeBFjJtkqmX8Xm8sUS4HWoQfZk6rD0cssoTAx1eZzE46Lyh6RXdGUfgvCHcM1ljDRQ18Lk2/a/THo+6j6SpOge84MHRCUZBsrzqYab6EVGyP8ewJI+Ndv6aEZKJyechgtkTjcsa5u2aHfotX6+hxWlID17nfUPDhH5Jomcj78dks/IeUPz8z9IncZpkjnKv1x1Rgrctz/IZKo+Vj57Tf16J3LYUBCaLkZM1YLq/aYLhNQMPQTPpz/CyPSum3nieCedxRBtErRPR+TWJVLMezPbMZMoTTjM/9luUZtt99NVi8j751fX8AYaBgA0Yequ/qzFO1tQRjaz1TF+rCXjnuzywiR59voYgJ5VDxBaczXfBx8zGX4yDVvnMiCdHtx9rPQ9csX4OuKZE7akrQWwfUmjCeDlLUIkbo/+JA2XD2O0ZcdW///Hf5x7qOcLcB5WqFs7lnf4wg4XdQ/AVv0AM2SgovMbYMMp95rQZu0tDa4xaUoK9eldPZA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(3023799007)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nmp5V2NvUEEyUzBiamYwZlB3Nk1aREl6eWI5OWJ3d2dvQ1R6U2l0OHdiaFpP?=
 =?utf-8?B?THFHTnU1b2NHOEE3YlBuQmlzZTdDL2RtUGpyeHpPbkpLV3hYU3FzcjJGbmtr?=
 =?utf-8?B?L29RZEQwamVmVlhGbk5QeGdlZjFERUpsdmZkaVhZSHdJQmFYc3FZTDc3M0gv?=
 =?utf-8?B?WGdWRkIvNStXVHBhSXJzWE1CS1NCQXU2Y1FjQ3RGeCtmWEpzSzlaV0Y5YThB?=
 =?utf-8?B?RVR5cmRqWlB3bjJlenlEd3MzWlhwY0pRL3FiNTUvNGcwUDlKSFd3M0NmYzNH?=
 =?utf-8?B?ai9JdHM1UVA5TVAwL3lVeWNseWZZaWJMMXRLSzNHSTQ5WE15WTdqanR0UFBl?=
 =?utf-8?B?bkhLUmlKRkVyTFZXaDVRRlpyRC96Y1V1NGpCWEduYmlmcFlNWmNWcnd2YnBs?=
 =?utf-8?B?SEhqYXlvalZ0RkRLS3RvYUJDaVNoZ1hrNGtidTFhWVR2RzNreUpKTWR6M2Jq?=
 =?utf-8?B?MGk0bHlQNnNPMnBqUkhmVnlja1J6M1k3czFubkJmeWMxQW5tQ0E4Z2ZObXZy?=
 =?utf-8?B?OEY3TkZ2OTVpWTA1UmVlbUNPVTluNVRVdnlBc2VFSldTT1Y1MlRiQ2RjemVR?=
 =?utf-8?B?ejl5ZGwzaXpGbXh0MVhlMkpqQ0RvZ1dmTzNwQWVoTmIzTkJEclkxNWkzV3FW?=
 =?utf-8?B?YjFtQnp4QWN1L0N3UjNYSlhLOXZMK1ZTQS82NnNaT3NCdGk4bjdPY0xRR2VX?=
 =?utf-8?B?WGl5Ri9CSlFvTThxZU1NQ0puN3NJdy9NT3QzUm1Vb1Z1bDExa1RpMHgxakxy?=
 =?utf-8?B?RHBXZWU0cUpBTitnVWdiOFUrenpjMTI5N2RuazhFKytoamhybEFpR2F3bit3?=
 =?utf-8?B?RTcrQ1VYcHorcU0vSjZCaEV0d0l5UkNrSjM3Rk9vUzROZnFtTkpxTDlpekYr?=
 =?utf-8?B?bnVwNjBXZDdZb2tuektTcnZBbFJLSzJBR3lpNitSaUFKbkNmMWdxeEx1dm92?=
 =?utf-8?B?cDB0Skh2Z09jWm1KRFk1UmpFVHpNWE9vN3JxUTM2ejZ0QU9ySXAvY0R6ZjhS?=
 =?utf-8?B?SWxRbTk3ZnErdDNHZVk4eHVDdjlHNDJlR2lTOGVHc0UwRVc1YjFVRkl2ZGp4?=
 =?utf-8?B?anRKemZOTGR1Vm04RnRiWnBvZXYzNWhkVmtvd1hEMFl3YTVDbXdNTXFwK1Nk?=
 =?utf-8?B?U2dlbTRMY1hzditYS0k4V2xLc2U3eS8wSTBmS0hHbjUwazc0WDVuTkNjUmZ6?=
 =?utf-8?B?dS9wU29qemZtcGVJbFZDK1dLYkJKK3N5Yy9GaXNWQTduUXE5dDFRQmFVeWdp?=
 =?utf-8?B?WU41WGQyMVc3VnM0UWJBRDFOS3k0ODUzS1EyTGIxUFBtd2hrK1B1NkJBOGdO?=
 =?utf-8?B?SlF1b1pGanI2cnN0RGtRRjBpRy9TR2lkbnArME5pZUFiOXhBWWZydE9scExl?=
 =?utf-8?B?RHpDb1hFMkxaUHRoY0FMM3ZrYjhXT25odFk5NmhqZCtEYTlYOWtJTzRaNmNp?=
 =?utf-8?B?WGJuc1l4eUhxMnM0M3h2Mld0WGI5R1JPUWdqV0dKTDdabW1uQmVnbWp6NUZR?=
 =?utf-8?B?SGtIK0RjRXdnZlgycmhnaklaNzBmY0MwejAzQ0N4ejZXMFJST2U5RG5WVHR2?=
 =?utf-8?B?T3dGVExzdCtCZW1LTWZJaHNFS2FqMkxuWEV5UTBTMlREZVQ1UUtnb2xPa0ZI?=
 =?utf-8?B?Q0NrS0o1My9HOCtOdnpjcmZVdFdhRys4RWZGT2pwTVJBdFZGbFZyZXNOMTgx?=
 =?utf-8?B?d2dDUlVYRTRhUXhCc1FmZkJGWFE3ZEJNYTY3aHYyV0M2ekc3WjJVZWgzQ1dE?=
 =?utf-8?B?R1RJVkhIWEVZMlhuSjlpeHlHVFJmbXVUYmd5dHNwSjhnaXNoQ2VJc3JVOUdG?=
 =?utf-8?B?SDhYMEx1ZjBmZEZZMXQ0eWJ5NjJGOE9PcDVNSmRjQmMyK0RxR0ZuM05NWG5r?=
 =?utf-8?B?dHE3NWpsRWZlbXJyV2ZuUU00Ym1uVXpScXJpcW1ya2R4SlBUQit1N0JMRHZG?=
 =?utf-8?B?S0xKVmh6ZXpTMU5NL3NuZmFVQ0xoeFRhb1pDSGJmSHdIei82RVhlNjloREkv?=
 =?utf-8?B?dEVFcUdyT08vUDFwR0VPdDlzSTRwM3VhRGtlUEdqSXB1djRZaU1TeEFRZkVW?=
 =?utf-8?B?OElFRDQ5a1VybkE3Tms3YzJ2aFd3Q0lZdGk4dm9tWlZtb2UyS1I2ekd1dGZx?=
 =?utf-8?B?Zk9sSlBSc2JTbUE4MEpZSUdRdUUvZkVGSllHV1VwRUhVcHNwZnQ3TWNIdkZn?=
 =?utf-8?B?VnJMT2VLNXRoS3ZsWitoVnJWeEhEdFBIOWFscjF5SDR5RjIvK28vNTZ4ZHJC?=
 =?utf-8?B?TDZtZ2JFSU1hRk1CYW5GSXVac1p3YzdRdmZ5ZFFKL2w1Rk4wU091cW1Hd3VV?=
 =?utf-8?B?dkJ3bG9UamRSaDA1RWNoYXhzT0Z0TGZLeHNLWHBMS3lscEtQT3owdW1nd3Z2?=
 =?utf-8?Q?fz6RG0IBc9gxy1gI=3D?=
X-Exchange-RoutingPolicyChecked: rW13uyXI/XJgjR8jxhd1+EFcJazHaeKV2nX254j/6JdclXbDlTkFscpOGAKnSiNKHDLhi6pTbtIt6hjCr4pb1GmeruWa+H2ByP0ptTZajjcmTvfWdM0FWrVcJrKGkHnnVXfx7uGtX5CCPOzDJrL0N3ZSsz/0Kk6xnQJ1dmOL1BdmvKkYFtVjkGQnVCWketbJRHnuHWsIU7BPwtHFpQke3dwNxQHSVOq52UV5OpWKzaiAmVeAeFrPGgwgU8jogSr/hOHDepKzBmfF7Yq5BS1vBonx5beyY8PKfuqGNUILotCJq3QzuCXeWiGu5y0OsZa11eszpX6O7XhodFKlIsFkIQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: bae46a31-4e57-4e24-bfdb-08df166904e8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 16:14:02.0322 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JffGXqx8k5ZEg7cSt3JCHAh0xWHGIwGi9x9wBaWzYJ+63J0JSgTr4dMlohEL3mOOX5plOD6Ay4hZszBkOMuBtfUT0LqjSy6G2sUATx69rpE=
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

Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

On 9/16/2026 1:18 PM, Anatoly Burakov wrote:
> Use the new flow graph API and the common parsing framework to implement
> flow parser for flow director.
>
> As a result of transitioning to more formalized validation, some checks
> have become more stringent. In particular, some protocols (such as SCTP)
> were previously accepting non-zero or invalid masks and either ignoring
> them or misinterpreting them to mean "fully masked". This has now been
> corrected.
>
> The FDIR engine in i40e has also relied on a custom memory allocation
> scheme for fdir flows - also migrated to the new infrastructure.
>
> Finally, some of the FDIR infrastructure has been migrated into the new
> flow engine, so that the engine itself is managing its own allocator and
> its own flow deduplication scheme.
>
> Signed-off-by: Anatoly Burakov<anatoly.burakov@intel.com>
> ---
<snip>

-- 
Regards,
Vladimir

