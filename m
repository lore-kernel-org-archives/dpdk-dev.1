Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CA9EA3F3D
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 15:53:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 99CB440431;
	Wed, 11 Feb 2026 16:53:27 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id B408740297
 for <dev@dpdk.org>; Wed, 11 Feb 2026 16:53:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770825206; x=1802361206;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=gkGJeGkcXdqFgRvzUa2mOWIKoOYHdHq2At+gsbo/quE=;
 b=FOjMbcYkSJY6xp3gAREHzIcXwaC+st8sNDa9TjnW5fN31IMR6c0zit1A
 olOfYTf3E3xvoB3JWAIhXVkdBoKdg2/nTRALOwsciyhVfgIVjthDrDOau
 XlBYI3/qbDWpkQtP1rYE8ivFKqpBRXp3x5/uwTt4laz6QCzsjtChcE4gR
 5h6uW0ktHRS8SGMhIznonQKvaC3FWYsjC7l1SICmlBm0EeRurGLaPafwc
 aU+M1f4wq0ODlXM56/BsNTxIPtG+8fqVlp1LvraV5/P40hsZqiTv69dyG
 ErrAvMQryaW5YElIIe/aapz0tUoAX6x+x+0sMoBPhRaCCt1IR7++PHFzU A==;
X-CSE-ConnectionGUID: 96DCawcsSEiN4fatKoQu/w==
X-CSE-MsgGUID: 8YMUqtKQSL6GTy7qRgOgaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="70996065"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="70996065"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 07:53:25 -0800
X-CSE-ConnectionGUID: cRl/TNHHRBi9DdvEYBGlFQ==
X-CSE-MsgGUID: EmO9uSlkQ8qaoTjvpzA+Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="249937891"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 07:53:24 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 07:53:24 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 11 Feb 2026 07:53:24 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.10) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 07:53:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ju315+lyE9lBjVlEY0PSzBVxnYmJ2gGyXHzG5uw8Ew7rEpc2fCWN7PkVaZHPZW5pieBwsiYuqpkBqlYogKFbS79YWLIJ5ByJIyKmisrAeDhK11MvWRWPhcDtRglh+Mnt3BVE633KHWpPVZDiV/gBZIoDi/Oeajcj0nVL9nUtmEykikGMOF06kinvp4qS0VcgYb2IZntwbTI+2HkspRkEQTX/lNaORBOhmHjqOHHTxyRfI2JCeJz3qNm61ztsx1LqncLaKF01JB35nO8wIU7jS8PtUiNevfTLOul+8ZrNPOG7xJcCK/3rUxRIxSgSX+VAcA3/7deMKahgD8wlrSb2Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywze+qa/ZUYsBy/2OJ/iljePSIpwlRnPRZkh15x+0Dc=;
 b=CHp4gTiKNS9DxqzVFhj71M0OBssT3XSmsFGIk6dd0cw2xdiyDFdTqgsXaqx0S38NwiB5tLuuHL5PiUk1xZ+3vi2zQ7tbttAvhTMAOrCT3dr5k0FDbYJB3/FuUiy8rS5HzhLaDsm0DBPp8nR2qlnwk+OoHfYJzQn6dw7qvOknR8WcwINPSPPKLu0yIXwAI29cdR5n2MLKlWtVIvMc+HQpuJBxFQ7H9aHYI6z6fYPnW4wA9gTWH50zjYrncuc+3c9AzINd79Z/qI57t68LUEPrBC+tnm73J82qmLmNIX0Izkf0AS6JvN1vQgOQ0H4pzXZZqplsUYODxYwW7Gx87MShfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by SA3PR11MB7628.namprd11.prod.outlook.com (2603:10b6:806:312::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Wed, 11 Feb
 2026 15:53:21 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2%5]) with mapi id 15.20.9564.010; Wed, 11 Feb 2026
 15:53:21 +0000
Message-ID: <2e76c9b9-214e-4d7a-ab86-5a0f29a34b44@intel.com>
Date: Wed, 11 Feb 2026 15:53:18 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/9] net/iavf: fix IPv4 flow subscription
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, Jie Wang
 <jie1x.wang@intel.com>, Qi Zhang <qi.z.zhang@intel.com>
References: <72142464577caf4c78dff27ed7514be8a4dcbca6.1770817694.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <72142464577caf4c78dff27ed7514be8a4dcbca6.1770817694.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0072.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::10) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|SA3PR11MB7628:EE_
X-MS-Office365-Filtering-Correlation-Id: ac74f3ce-af40-4ab2-adfd-08de6985ae96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MWI0cGJ0dW4yRnE2L1dzZVZtL3lMWjFvbkxEQlptekFEU2F2MWJRVGphME1W?=
 =?utf-8?B?am5zSEFzL1JXUWwrUnBON0JoU0tVZ2RSS2Y1Slk3ZUVabW9LMWJhL2FuenFP?=
 =?utf-8?B?WjJyRTFjb1djenNibDlYNXUvMndyRmJlL3FOT3llQkhjcUQrRUZITlVpajhC?=
 =?utf-8?B?bHFLQmlCRmFrZU9mcW0rMnU4NnFjVC9lWmZZME1kTmRoS05wN1FOSzZXVGgz?=
 =?utf-8?B?VXVRZ3RDQ2hRd3lyNzFaalNFWlF6RFBmUWU4Njd4ck5rakRNSzkxdWI0ekFq?=
 =?utf-8?B?SzZKTEdMRUFHeXpvOGlWNnozclhENlFKWlhPQmtCUVdhUWdzbkFpM1JkeE5o?=
 =?utf-8?B?RG0yMHh5NHBablVxZG9GQ2o3RFQ5bzFyYWpSQ0p3NXBlQzF1ZDYyL1NZd3Zs?=
 =?utf-8?B?bkxiYjVDZkpFYWtHeStSc0VpY2thSVFDcmpJUVRSelJ3Z3dNNkgyK2tNTkhj?=
 =?utf-8?B?NlhvYUpWajY4dGJPYUxScnFtWHBuUXdSSG1xOHEwQkgzd3pVb3pvbGJlY0dB?=
 =?utf-8?B?Wk5RTU5CaVNvSDIyZDFNSWVlejNLbmN3dHRmaGdPajI4YkNMVkxudjI4ckNu?=
 =?utf-8?B?b3hmOFFQbEk5NFp1UTNKcFZ4Wjh2ak5qYVFKQTRLT2NWajFDMmliVHNDaUcz?=
 =?utf-8?B?V3NUZSt5SkNuMThlVU1nQlJzVkd6MXduekZHb1dVTVRBYmpMV2JMVDVRdXc2?=
 =?utf-8?B?czhtTXJtQUY4Mk51bUU5OGVSSjlvRCtabFZwWEhFeWc1WlRqSzl1U3NFOXA3?=
 =?utf-8?B?Z2RVcmlXaWNsa2tzd2ZHZklVeFVCcTJscWZtT25OOE90MjhDQnJGSHRHN1Rt?=
 =?utf-8?B?Zmp2VWVZbFZ3elllbUNVSS82Z1dMelp4dmx6RGkrelRpV01PekRXbUdJbnJ0?=
 =?utf-8?B?MTNpeVdKWE1QRmh1ajVuaVdCSlBCVHBxdlk5azk1b1JEWXVZVlhJWFFHcnMr?=
 =?utf-8?B?OVlnU3lNYm16SGpKYkJSK0EzU1N6MU9xa0dtMWdpczZIeFNkOStmaCtkQ0l0?=
 =?utf-8?B?dWI4ajhXWUFoRnh2bi84U1JpZStSQXkwT2VxbmpzRjY3WWFZZE9jQVZORDJT?=
 =?utf-8?B?RVduWm4wLzZUajRseEVmQ0RGeSt2TmlpODUzamI2SjJaK2xGdFFOTzRvdzQ4?=
 =?utf-8?B?UWFGdTZMR3pvZjdxYmVWa1ZPTGRmL2RmMFFBWHNXa2tEa3VPOVpzSTMrZFBi?=
 =?utf-8?B?YmdXNmtwSGZDU2FMbkVoaU1DbVVQRWpVdE5ZVWc3WVdiZjkySzJiVSswUEtU?=
 =?utf-8?B?NWk5M1NtL0F5enpJOXRvSGNNOG1QT2xodGI0TXRzbHZLNmVrVHVyWWxnR3ZS?=
 =?utf-8?B?aTBKbUJ2L084dndNbDFYV0tIL2ZwcTcwYldOWUYxeUNKRWVVeGwvSXFnaTE0?=
 =?utf-8?B?NHNnNDl3eG1KdDJjOWpQWHU0bmlKUVhHNE9JMnlNQ1dibDQzZVB6WGEvZDg2?=
 =?utf-8?B?WWJHeGgwZWx4ZWorRkRXZmVTOHl6QytyUDNKVy82Uldtd0ZVWEZzT3Z0QzlN?=
 =?utf-8?B?WEltWmkva1NITWRkdGVsaXg5QnpNL25NckJJWUdzSEZuNlpEcW1CSkZLcFJS?=
 =?utf-8?B?My9WZ1BpcUkxZ2xyTVlBdlkybkNvdXZUd2ZJUzZCMGZDdlFsWUJUdlNvOVZF?=
 =?utf-8?B?ZUMvL0NlUjZSdUEvL3dwOGZ4K0U4VktmVTRhb0tacG5jRXgrRVZyRXEzaDAw?=
 =?utf-8?B?bFpvWlNuejd5MmJiSzYxcUd6TnExNUh1S3AzOFNyN0pPNjEwOEVhUVhPNWw2?=
 =?utf-8?B?NnduWFgwU1VDL09Qa0hZMXRvZUFQQW9DZGNDZFNMa2lRM0FjV0RpZmVOUk9s?=
 =?utf-8?B?ajhuUEV3VHMvTlQxcks2VXFsQTBaVllxK3FoWUFPbEZmdW00cDFUam5VYnBV?=
 =?utf-8?B?SUE1L096c0VudHN2KzZPSXpSaS9uQTFrYjVyUDcrNHk0MW92anlnTzJvNXZP?=
 =?utf-8?B?VkoxaUZidzZ3em5uMHdvTCtFWjVCWThWZ2FNamh5Qk9lSkFQdGcvVGFSdTBi?=
 =?utf-8?B?Q2JHaDZqOFVQL2ovanczMmlsNlptM21sNmY1Ly94WjFHTERYT1RGRTVEN29n?=
 =?utf-8?B?U0cxVEJGRVo3UUpwcjEwTUJGeEY1a1NOZTNGYlhUd3k4NDRuMERuaGN3WGNn?=
 =?utf-8?Q?3BX8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czZiTmgxNlF0SFM0dFNvQmtjaXZGTnFEYVk4Y2Z3bk1RQ1JBSkYzWUl5MXlX?=
 =?utf-8?B?NzBBdVEvWWo1N2RVWFlnQk1VUEk3OEs0TWF3Z1dUb2lTZDU5dkdJTlNYbkgy?=
 =?utf-8?B?eGtiV1hFZ1FUSlUvanNBclBRTmxFNlpucFo3K1EvaWNqU3c5Q3Nwd3JaRXVy?=
 =?utf-8?B?eFBSOUNHRTFRL0NvY0NIb3RGazU0K2hjR3pxc3VaL3pvNW9JT2V6c0NjVHBL?=
 =?utf-8?B?Z1dZRldCcnV0VUEwUjRMY3J0eGVHenpyU1VXbUJiTXVSajBYeURyVG1IQWp2?=
 =?utf-8?B?VEVRcWZNd0ZqTlFXbEdsdEpySThHVTRNenRQdTRSdGtDeERwaFRTNSttSnd5?=
 =?utf-8?B?QWNLNFRaUVBJVzhoMGVEMXhTZ29sR0NuQzJKdUgyTFhZWmpoZGlNSXdIWGNp?=
 =?utf-8?B?aGlPcGFuZFBBYU94Vi9hQXh0aDZYR1NPMzY5NEVObktMUU9yVndMTDhzWkMw?=
 =?utf-8?B?Nk0wVEoxVWRHejJkRXRlUElqZFpnd0VHeVhFTld1ZWpielRpTlNaSmpNMGFF?=
 =?utf-8?B?R3NNZmVCdmN2TGo4bnhGbi92RWlRcTRKZ3hlT0xjTjArQzlTWVMyMlcyaGw4?=
 =?utf-8?B?WHdVRjFLYmtDSU94NjJQT1ZOSndEVUNSVUlXRDFpT0FjYU82Tm1DYUd0U3Zy?=
 =?utf-8?B?MTNmQ1dQK3RaZ2dTZVNkYlJuMmFHNnBUZ00rL1VzWEtGZ1dscDlibXNLUWox?=
 =?utf-8?B?L0ZhQVRkdEpvMHQ1YjAwRHh2dkpENnlKMVRKQUJzZ1BIb1Z0bTd5ZG5KSG5K?=
 =?utf-8?B?R2Vyd2V1ZGlKTEVIeGJIWjZZSklvanFVUno3T1JQNGZ6SEtuRHJxLzgySDBz?=
 =?utf-8?B?Smk1S1E5eVBreEhGcVlWTWZpRmZtamxhanI5RnZ4ZXlablBKV0dJVzB1cWVP?=
 =?utf-8?B?N1hjdlVPQ2hVT2pJdDFwcnZyY1FtOEc2aksrUmFCcHg2cE9iUnhmbGZlNFIr?=
 =?utf-8?B?WFZQUUZPcWVGWlRuSlNNUllJRTY2dlFpcXNxeXFzVTJaM1FpOWRYbnpPeEZt?=
 =?utf-8?B?Z0M4cUl0OWJtYWVlK0lHSFdCRkI1bDdKdWdGdjZTY3gyN25FditRRXl4c0Ry?=
 =?utf-8?B?U1BlSjBjWDd4bkdBdlk1RDRoTXkrclFwL3VjT1dka054elFLeHpSZXZ3R29K?=
 =?utf-8?B?VVlOV3NGWnZYK0pJTWxGbURyV1h6T2RCNTl6K3JvSjFDSUNyb1h0U3ltMHY0?=
 =?utf-8?B?Rm9iTDBWczY1bng2Y0VJREVHWGJTQU5JbG9RV3RGeU95eWI5K3RqUmlKcDNx?=
 =?utf-8?B?MFdvQXNrSnhaTXNGSEdZRFJNajNCTmhLOVYvSlRvbThLd3JTM2lvVVExVkJ4?=
 =?utf-8?B?bUxZbTRFdlNmOUZweXlIOXFROFBiR2hiQkoxcGR1RkFqSW9heUtoK1hNa0xR?=
 =?utf-8?B?c0lDdVUySnhPMUI2SmhPZzd3UEpmaG1vb2RsMmxISmJmazJ2dVFKbWdrTjRN?=
 =?utf-8?B?R1NXUGRPcEoreUptMWY4NEh1cHVtRU0zUUpadHZ4ZmJyQWJ4VnJ0Z0owR0Z0?=
 =?utf-8?B?MW9WdTdHcXc1enA5a01lSWE4MDdLeWVGcnFlMGRCSDhIMjJ3Mk9kZ0oyR3FI?=
 =?utf-8?B?NlRKd1JaMm0rcUQxWXEwVGVWVjU3Y2cxQU5UK0FnR2lDMDV2N0RUeWxqYzYv?=
 =?utf-8?B?dHMySXg2V0F4aDdVaDZJQTIvOEJ4NFRVa1NhRHlvSXhCdFZEc01EZUprbC9R?=
 =?utf-8?B?TnpFT2dxMzZkSXR2bWJYOW9VNUdncTlKdXBiWlNDbFk5RFB3dUdpUjFJUlU3?=
 =?utf-8?B?UldwTXk5Rk9nWVZ6S0NaeTZHelorTlpOWGIwWnJ3R0pUYjJsc2tuNVlUTXN0?=
 =?utf-8?B?Rkhnbm1DRk1GU2FOU3VGb01PN04rR28wcWxRc0FpOHFWclJ1VDJyQmEvMzlQ?=
 =?utf-8?B?SzdIK0h0UDhUQmpDS1RzWm1ZTkxHMGRoK2doemlnWjJUZjBVVnJKMk5QZ215?=
 =?utf-8?B?WmphQkpJVi9zUHRCRDVpMHhFdnB1d3h0bnBXaUlSU1A3dDFtUllQU2FLd0sy?=
 =?utf-8?B?MC9USFRVZ2FvdTBwRnpmSVZJSVNPSEpuVFRvcXNEQzB4dG0yZ0dhTENvOUZk?=
 =?utf-8?B?RFJ5cEZ1NmRGWDZ6cFFGMHkwVUF2ZFBkeFRtbkhyaGt5eWsxQm1aenNRTkhO?=
 =?utf-8?B?WmRlRW92UDJYMzFBNXI1UzRrNGtmRk05ZmZxaFpycVhabmdxZzhURXR5ckF1?=
 =?utf-8?B?OENybkgvVzNEeklPVU4vMUhKbkticDNSL0p2c0lKWm95ellFM1FZS2Yreldw?=
 =?utf-8?B?bnVjdW4ydUZBQWZwaW9WcEdDZ09ZUXpNVTZsOUdCbGFmZ3puN1daZTJiaHhH?=
 =?utf-8?B?MHVobndDN3lwWDYwTkdWaFFVNGhHTHZsTFVMT0xqVUNkZDMrd0VJRGZoYm54?=
 =?utf-8?Q?sQLy3KKQ0qihwMrc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ac74f3ce-af40-4ab2-adfd-08de6985ae96
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 15:53:21.5920 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZIYRcVNhTLp8mfY7T05++017PmIdvxloPGNWaRQkZtTrDCwVLVfPCplkrqAEljMKY5TexY/zRusrJpVVX490j3SmXGChkghbpyVe2tSbI4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7628
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

On 2/11/2026 1:49 PM, Anatoly Burakov wrote:
> Currently, when IPv4 is parsed as part of flow subscription input set, we
> add two bytes to the total number of bytes in the input set for IPv4 source
> or destination addresses, whereas they should be 4 bytes. Fix to add the
> correct number of bytes.
>
> Fixes: 6d42380e5983 ("net/iavf: add flow subscrption supported pattern")
> Cc: stable@dpdk.org
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>   drivers/net/intel/iavf/iavf_fsub.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/intel/iavf/iavf_fsub.c b/drivers/net/intel/iavf/iavf_fsub.c
> index 18df9c6500..cf1030320f 100644
> --- a/drivers/net/intel/iavf/iavf_fsub.c
> +++ b/drivers/net/intel/iavf/iavf_fsub.c
> @@ -314,11 +314,11 @@ iavf_fsub_parse_pattern(const struct rte_flow_item pattern[],
>   
>   				if (ipv4_mask->hdr.src_addr) {
>   					*input |= IAVF_INSET_IPV4_SRC;
> -					input_set_byte += 2;
> +					input_set_byte += 4;
>   				}
>   				if (ipv4_mask->hdr.dst_addr) {
>   					*input |= IAVF_INSET_IPV4_DST;
> -					input_set_byte += 2;
> +					input_set_byte += 4;
>   				}
>   				if (ipv4_mask->hdr.time_to_live) {
>   					*input |= IAVF_INSET_IPV4_TTL;

-- 
Regards,
Vladimir

