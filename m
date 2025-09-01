Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8676CCA1000
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Sep 2025 18:10:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91E01402EE;
	Mon,  1 Sep 2025 20:10:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id D2C41402BD
 for <dev@dpdk.org>; Mon,  1 Sep 2025 20:10:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756750202; x=1788286202;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vixR9hFFKUahipRVuMf7VenJ/fDlcysT3gx6TIVBW6U=;
 b=dy7dHVn3LWoTD1gGx0wasnDz3/fLzoanDLmBxUXCeaKOdNR3IwYRPXH4
 Oh97jKDsZPuumZvg77rast/mUNZfmb3vdk7KgQfvoTiazx4NLpnTRSc1x
 XYmfhDqclZXypKHace2UU6ACtRiyOtyoURXp0OUk3oz+A7xKvQn3UejqD
 5HNiVzCbDEF3wmPxkMRSnjiLc2YhYisq7V7BGsFrfnjnPDfpEjlLi1b5C
 qqY1PAf7zhGJ9ATI/PHTr/HYVlLKEkdT0c1LsMspc7K7fnc5emUSxWeSK
 jed1iErTL+f/pNRmfSberyS05ZxQMRFTnfsgaLb68azhWXss14gRTi2J7 Q==;
X-CSE-ConnectionGUID: Sy3ysyRTQOyoHnuH1uGGNQ==
X-CSE-MsgGUID: t1hO8ulDTEezdDwHXNiqqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="46591784"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; d="scan'208";a="46591784"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2025 11:10:01 -0700
X-CSE-ConnectionGUID: PmwIAbixSjyNzNAHq14mOQ==
X-CSE-MsgGUID: ijiWElfcSHioBHZEQegpTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; d="scan'208";a="201999617"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2025 11:10:00 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 1 Sep 2025 11:09:59 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 1 Sep 2025 11:09:59 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.49)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 1 Sep 2025 11:09:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p2AMdrsT7V31EB+WX3qQCfunXPJ8J4WCCUvk4OCK+aIv9MPGHvxbtnl9ynQ91xnDVj3ogZCkiCMrIrZIpsNlsxbzpEbvm+/TtCDVHUAhJlKnO+Y3xnAXxXn95bhPJ6wAymNN3AYjYNIOpY8Bf+GM8lRQMO/Qh0PmOOlJ+E3dr1OqTU+/8P9GCUSq8CKZSW+skXk+u/Z9ExwpWlJfCYBuGzbQXqr0V+dRvPWQhtIBVGQlRlroBTdX8thOJkoGsuAWsO+Cg2rPoNH7KUL6xZwOPxjy+PIxtma6nTHs4Q5esSyflJ5MkuqBSq2U0v2yLoYj98UJcMgyzmKxWzgQfNNFlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BVrL5H4rlXByFgsyrean2w/N+XSSZtPYfMS3f7/mcc=;
 b=OE+CHulGr1KMoX6LFW/HBrCFC1sz9o+y57DK4Sei+FYIirordiCwVMq/uuvlAgeyEqy7avcywKhsiwuVXj2ceGcMYlxcKpZAriBpPff0Ygt2JiJT5Ik7S6dTq6CXf+scjcfTff7MeFSPLdlECeL++Jdikc/knMCAYQqld/H/TJ6VOwfCozOFQ6XVQqXLxpeJwX8cKQ2EklHGk5Pvdp7he7KJsB+8I9ZYOfeDcb3m9V6cL6ftq7QiFOnXZc7qTj8TUxMffhtcaYeECeom65NknktHzLPU5zX7kMELs7L2JuQoH5e1i16gwXrrTNz/P4mJj2LdsNb4ZUNd3STOhNhT4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by PH8PR11MB6609.namprd11.prod.outlook.com (2603:10b6:510:1cc::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Mon, 1 Sep
 2025 18:09:57 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::509:acc9:5dba:5963]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::509:acc9:5dba:5963%4]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 18:09:57 +0000
Message-ID: <5fe0c12f-db6a-4aaf-a825-b66e484628f4@intel.com>
Date: Mon, 1 Sep 2025 19:09:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/6] ethdev: refactor and extend DCB configuration API
To: Thomas Monjalon <thomas@monjalon.net>
CC: <dev@dpdk.org>, <bruce.richardson@intel.com>, <anatoly.burakov@intel.com>, 
 <andrew.rybchenko@oktetlabs.ru>, <stephen@networkplumber.org>
References: <20250830171706.428977-1-vladimir.medvedkin@intel.com>
 <3386423.G96rZvMJ2N@thomas>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <3386423.G96rZvMJ2N@thomas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0171.eurprd09.prod.outlook.com
 (2603:10a6:800:120::25) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|PH8PR11MB6609:EE_
X-MS-Office365-Filtering-Correlation-Id: 64dbfefa-3a85-496b-1a74-08dde982c201
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M1RhVWFVWmRjNzFZSmZzY3hUUi9lUzFlRk82ck9mNkpod0JrcFo0ZVVMdDBq?=
 =?utf-8?B?ZXFKVm5aKzY1MVlobnlIQnNhY1FOQWxJV1lOSEYyM1FVUW9aanFSN2dHS0g2?=
 =?utf-8?B?VlMrdjI1NEVIUkxOd0pHeGpESnZEdE9XL2dhZFJtSVhYNmlMMnJkYkVyL3Fh?=
 =?utf-8?B?dUdYZENKdlVZRXBjMzBZSllXdHNPSTlEanhhOUV0WnBtSjJKK0NhNlpPTnNt?=
 =?utf-8?B?c2poRGx0S2hUZHUyS3NmZFRSN01DTVZENjhqdHcrbGNyUitCWFhCczJwekZV?=
 =?utf-8?B?OWQzUUpCaEtjUGtLZFo4UFo3RzlPRWUwZ1MyeEhHRm5tZG0zdm0zWjZRZ1Mv?=
 =?utf-8?B?VFNOWFgwRElrOURQd2tyWVNNVUkzWlRUVWhPZFRxa2NRRTlsKzR0aUtqVFBV?=
 =?utf-8?B?WnNGQlQyMktndTNHOUhDRUtFcGphQlVKSG5wb1RVNi9HaVhITHlmYjdleERl?=
 =?utf-8?B?QlVaZ1IvZTVWSEw0Skc1cVBFd0o5NkxZUG5nSFFGM2N3TlFMbUM3UlpQTXJt?=
 =?utf-8?B?NkxEclAxbkhRUWd2aGN5QUdHTy9VRzQ0bnJHWGF0a3JpbzRROE5pQk5QY0Qz?=
 =?utf-8?B?dE1NU0xpL0kyczJaUWdScGV5YzRyYlFCdzg2OS9KVDRQbEZ5WTZmZ3ZXVlpQ?=
 =?utf-8?B?UURjNkFXQUMxNGdXeWUwa095NWE5N28xS2FBTmN4UTVjSXE2L1Zrc0t3T1Mv?=
 =?utf-8?B?NTVkLzBMcjd5d1JXZk14ZDZxaE1zR2RhdWtxVFc3RVNYY0tSZndCcGpFZjVq?=
 =?utf-8?B?VUFUU09oU0ZRM1dxQ1J3eTYxekx4cTdLRXhlMm9GQ2xJL0pRdUY3djdsU0Ri?=
 =?utf-8?B?ZStxWjFYakR4MWY5Z2pZS3VCM1BZc0hEcXQxZzlRY1BNQ0Yzc3pIczFLS0Jq?=
 =?utf-8?B?MnN5VGNQWFhmYXgwaWZkZ0lHZUJXZDdzYVMrcnQ5Z2I5TGdmZ25oNUt3a2RF?=
 =?utf-8?B?UElGL3M4endRL2htTjZTZDNHNThIcEEvbW5Falh3S1NYVXFuaHljcjcrSjVz?=
 =?utf-8?B?LzVoQVJhZHcyY0dLR21jZmxyZkEyRUtDZFZ1eXV2MGhNM1hSam8wb0hEeFVz?=
 =?utf-8?B?anRXRmV0bWMwbHR5SXFRRWpOQ1QwUGt5Mzc1bnk4azRvUXJmTXBvdUxIOUxL?=
 =?utf-8?B?RmgxbnMxLzQvWUFqMmxIaXNJMWdQaFJOZWpERFJjNm1HUFE4Yk4zdzlxVXRq?=
 =?utf-8?B?R3RwVkdRNkx2NDJZTjV0cFo2bVp2Rm9seDREeDNyd1JjejdnREZES1pCdVhu?=
 =?utf-8?B?R2F6K0JPVVZ1RGZPeDFiU3I5eEkxK3dIRDE1bmJXdmRTMTZDcUNqMEI2a2sv?=
 =?utf-8?B?Wko1aDJ2STY5dUhTNktDbUd5U1F6aEVGeXc3aElDWC9aeklxRnA1KzU3cklQ?=
 =?utf-8?B?RUtqZzZtMEN4MjBVZ0dsMWhWSE5hT2F1ZUJaUUNKNy9kZ1dpN1dzNFJ3TU0v?=
 =?utf-8?B?QTBwQU0xNlhLWndQZ296UDQxSytkN3ViYmdVMDNOQUZyVWJWd2tSRFhUTEth?=
 =?utf-8?B?dzRYU1drOTJtZWZZM1hkVDE3UllmZE4vNTM3aUxqT21vZmd1NW5kSjhuN0dm?=
 =?utf-8?B?cGhQbnRqcmZRSEJRMytQNCsraUxoTHhTMkt6bmp0eXp5VEJWc04wVWl6VGJH?=
 =?utf-8?B?cWlmQ2Z1aGdMVzdmZitmT25ySjlWd2dLK1hhMElIcFJpRWZqcFk5OUMyejYr?=
 =?utf-8?B?Q1BMeEdaTjA2RkV1VCtqZjhhRDFnNnBiR3YvMnh3WWF2Yi9CYkhIbkRjWkkw?=
 =?utf-8?B?akZMMG1EdDVVSEVudVJ4bWZiM0taOU1OMmJBT3Vxd1BxS3FZZkc2a29UeTVr?=
 =?utf-8?B?SVFzNVF5UU9NM1FSR0t4a2RkRVl5Vnl3TUdHUkNZMmo4dW9tK2o5VnVOa2Z1?=
 =?utf-8?B?RFhMVDVwUjladHplNXc5dnpWbkV2LzN3YWhrUG5aT3hpRW1kcmhhSXhHM2dV?=
 =?utf-8?Q?kyONCuxyVYo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3Z4VmxTZ0FFSmZORUdqVC9kelVOZ0V2dDFQdGN6bERWOVBWdEVIRnBwcmNF?=
 =?utf-8?B?KzBXaTlSTEhRU2h6Z0VJME01bm9GL2ZlSERselN6cm9RUCtZelJnVENnaXo1?=
 =?utf-8?B?b0tNWFRPZTc5eGIyMlVQcTNTWVh6Y20yZzdFaFVIc2FJbWR2R0JDd21JYUE4?=
 =?utf-8?B?OHlkWCtCQUo1b2c4eXlBeDhVbWtGdWxNNi9HRmtXeVIvdHJlbENZV0t3VXdt?=
 =?utf-8?B?TE5CTFVYQTc1WGFmMUFEWUxIVkZuMm40cHMvRjlZQzhQUS9SV1A3VE9RZkVH?=
 =?utf-8?B?WTNta3Fia1VwUVFsOEhUNVdHSFBVV1AySEVSNTFjTG92M1RENXRuRjdXdkFs?=
 =?utf-8?B?aEdvV1IzcVZMSU8rZVcvQkt6NW1MUTNyK0RBekZkVU1mYkcvNTBaRGhKMUpt?=
 =?utf-8?B?RDY0cnZhTzVhdWt0RFhQMWRuNXFYaUc4ZlRzVkRnRUJrUUQ3U2FmNmovRGhy?=
 =?utf-8?B?WGVybVJRY2NXdDBPWFkvWEZ0Q1UwaDZhVHFHSy81Q0hjYXI3dTZObXhsbXU5?=
 =?utf-8?B?NDNkUDR3UU93WjZaT2E4UzQ0UHo2NjFjbHZoUGd5MFdmN3dtTkNaK0xLVjB6?=
 =?utf-8?B?K0xyMXdqVWsvMlBMNGxmRUFFMU45elpLbEVCVUNzMVU3STFwL01kbTZzajdh?=
 =?utf-8?B?U3JEaGM4VTk1enpIM201R0xveUhQVEdaK0JiN3orSVJwL1JUUlpvdDVqSlN1?=
 =?utf-8?B?L3lMbXRTcTMvSUVybUlUbFRxdk0zOGluR2hsZE4xSTZVcVRwQWNIVVdWV2o5?=
 =?utf-8?B?ZlAvK1ZoOStzM2thZGFkZVJwL0VCenJrWElZZVV0VTR1bEEvdHh4TzVuN2tR?=
 =?utf-8?B?dzg0ak9PY1JqeE1VSW0xVCtCa2tPMXdDV292T3NVSWJOQWpSZlFnbVZkMENu?=
 =?utf-8?B?QkFWTFowVDZnVkRRcGl2QVp3eEk4VUNiZDdYcGg5QnprM2dnQVVaaDZQNFhQ?=
 =?utf-8?B?ajFDQTA4L1Q2VU9KY1Z3dUJMU2R1MmZZR21Sa0JzTElzZDMrMUx4NVBPZlNX?=
 =?utf-8?B?TWk5RnRVYW9sTGEzLzQ1cERxbk0zWU1WWUlUTDdhaW5HQUVoVnNlbFpSN1h2?=
 =?utf-8?B?QnFDZkRqT1R2Q2RaK3RBN1c3YWhGajBDVi85WFI0RklMSTcwMDl4TXNQclpW?=
 =?utf-8?B?UXJiWWZwWFREQy9aVDVTa0liRnpzeFZSWE1ZTmhBa2FDTkVwRnVSbkxyTlJ3?=
 =?utf-8?B?TzBHY3JsLy83M2xteWZYUHFkUmdSL2hySDI0WFFaeFdKUysvZWRBZEJ3NkJL?=
 =?utf-8?B?MlVvbXhHOExkdXpvMEJaTXlSZm9KNkVyclduNllMZ1BMN0lBUEJidkNmWERF?=
 =?utf-8?B?cVF2YjJWblFXUzhvanR3dXFSeGdVSlpPUEs3elBTMXQ4cDRiTDdUNllRa1JI?=
 =?utf-8?B?T1N1SEZ1QndCeVVsaG51dEorNXUzSExhaVVlTmg5QjA4cm5rUnJYRTZxYURl?=
 =?utf-8?B?UXJWWi9kZE0wU2xvYjg3NnhxTTFPSm9Yc3h0bkE5UnBIV2tFK0NMMDJvSzFo?=
 =?utf-8?B?eUFUSXVESVNVMGpPZlczcjF6bXlOSUw0bkRpVDVhODZTcU1lT1B1Rzh2U3JL?=
 =?utf-8?B?b0I2RW5qSWMzVUxCeWxMQjRDTmltQ2tKOUdZMURoN3czQTNraWVDazVORFFt?=
 =?utf-8?B?OVBUb3NJdHBxQ2FDVGpJc2VEOGZ2dVRza3lGV2NJcEVwN3AxeHBqTEhZdTAx?=
 =?utf-8?B?WmltZHhOMXNHazhYSW16RGg1M3VrWDZjTUlzMWF6QVVEZ0pIY21GU2lBZDhE?=
 =?utf-8?B?THNtSFVNL0dkV1BpNTNaYnNhQTBMeGdqc3grSGpKeHVOVG5jb29oVHFqQ0Ja?=
 =?utf-8?B?M0ZzWkJCMEx5ZGlkeHh2V3ZDYVN5cDBnWVdWVGxPZ1ZXelBSV043RTlld3Vu?=
 =?utf-8?B?YmJsVklmRUlwZGZFVjliNGQ0WmU1bGtuSjRTV2EvMERyZzE3VkFveHF5b3ZR?=
 =?utf-8?B?blNFd3Z3LzJQUjJ1TTQ3Y3UvZmlUYXkwOGNmUHRRdnk3M21TUGFpK2FIMnVH?=
 =?utf-8?B?Z3dQWUVXaVhEUHQvSy8vd2w1Vy96STlXYld1eTBpYXpxd2dBbjBudDEwTHVX?=
 =?utf-8?B?RzFrZC9aNnJqc3NBNnN0NlBVWUJoT24xUWg1TzAxOU1yUkpGM21yZ3RhUzcx?=
 =?utf-8?B?NkNDZ2hFamF3QVVRcDNEaFA3T2pTN1hLdWpvVTlZQlBIVm9yVjhVem0rQWtK?=
 =?utf-8?B?SVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 64dbfefa-3a85-496b-1a74-08dde982c201
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 18:09:56.9260 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KI8vM5L6Sdf2szgCQrql9WLU0MM6SmkNWWTMJOLjXBxWqc5cMQVy0tUxBWReVdnk6uuTEqngfnFmkbdhp7w4yQpuzG33SZuj4O9RiMqIFls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6609
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

Hi Thomas,

Yes, these changes have not been announced, because they're not meant to 
be merged in this release. I would like some feedback on the direction 
before making any announcements.

On 9/1/2025 9:51 AM, Thomas Monjalon wrote:
> 30/08/2025 19:17, Vladimir Medvedkin:
>> Vladimir Medvedkin (6):
>>    ethdev: extend and refactor DCB configuration
>>    ethdev: remove nb_tcs from rte_eth_dcb_conf structure
>>    ethdev: decouple VMDq and DCB cofiguration
>>    ethdev: extend VMDq/DCB configuration with queue mapping
>>    ethdev: remove dcb_capability_en from rte_eth_conf
>>    ethdev: move mq_mode to [r,t]x_adv_conf
> These API changes have not been announce in a previous release?
>
> I like cleanups, but I am skepical about the timing and impact on users.
>
>
-- 
Regards,
Vladimir

