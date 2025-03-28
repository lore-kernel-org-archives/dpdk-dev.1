Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F501C28B20
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 13:02:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D59A40653;
	Fri, 28 Mar 2025 14:02:03 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 41DF440269;
 Fri, 28 Mar 2025 14:02:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743166922; x=1774702922;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=miZEYFeciL8kGVKiZAf6KttwvTMfRXOiSv2eWnrZsVk=;
 b=AqRmtjmgQ675VKE9mnDoaa8JkQcLLNuB6CWBoit/438Edn0Hzzj4qCBr
 picanDF40mtTwAnQRWLJvd9PKtN+CvfhC4CUaf+vkpa1uB3uisyKaKZzN
 htCenomgGXsmcyyBMK/vjnr9viCehbSLhJLugONgUfZpMOiDXP/9yILYR
 ZlBehgdgsP/pdX265fNFyIHyLdq8BeqkbYiL6OHWNN68KzJbYrn8Dq8Bq
 TuYrz3zOFo7YQKn/L5haR9qQm83WwbIi3rUhcfqFCMmJQzw4P/syXo2Ih
 8PXNKGEosB6QViR9kKRJETXNeZRTTkS6cS+wcLQo1jOoc9BrjRgSeuG40 g==;
X-CSE-ConnectionGUID: qQL+crPhSli+kPVZvSTXeA==
X-CSE-MsgGUID: 2PA/q6RVRtC/4MDbZxefew==
X-IronPort-AV: E=McAfee;i="6700,10204,11387"; a="55186840"
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; d="scan'208";a="55186840"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2025 06:02:00 -0700
X-CSE-ConnectionGUID: 6/XqNYfFRr6QDQAcvhmNzg==
X-CSE-MsgGUID: zPk5mRvlSUyQZ+0hvsZJVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; d="scan'208";a="130296611"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2025 06:02:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 28 Mar 2025 06:01:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 28 Mar 2025 06:01:59 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Mar 2025 06:01:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ySAEkQFXOTnN/04BUyUsIa8VIi1t79bgaKeSobWZ5+3xdOgSUAOckStaW/yCJPbiwIgxDIvx0Tp+gklbP5QK37N0bXzcEgJI2m3a/U0ghsqp2Dgm561/ukv+iLUsaiBV4jMLxnVAxwuckysuh+q3oRq4LtBsK0WQtU6U6LA64sqpWb3h4gTFDFUoWrFiRltPtM7Gd2/lKkRv/o8S7OKtDlIovc/jZ9KMnqSwvvoX37oz9POhO8kAWvMZHsdwz26bvdXaeDDvLWP5Vs72YSuG0hZcN/PugUb2f58kvyDOydqoRF9bMISB/jt7uo1MKrL0nvyBL6HsMbFUn8RoISTQdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucpkoZ+Jq627gr8nfDjgQxz3+tzTKsmQpHhbEj2Lngk=;
 b=n+y/Fvwo9ra9s9NZiaR29NQiog6NdZ2AOvRiOKopFbd9/6kQ8B2j/QqLPHXppCoOcchbXvDQsXAbvlzLdpyYXs02oU9jLD/Q6AJHbdvzhAnaw7H+Yf5bV4z5BL+Rfw/LYmybjPv3a2GiusFWOZCm9xSlDLq683LLUhhmBOPym6dz3EG01KTyfPQXEYIbquvTWutUGhM9QHdh28Aijwunt8OFpxiES+4AjqawoUDxwxAsfdLkobb8aHcovzJwXww1yFbH5ffAeUhKC9k5p2rb8+xnaZA+JYUQ3z9L38OFGGURYrg5roqc36VEV0HQSkABz7RGra0y7kUhsmZ3zkzvpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SJ2PR11MB7597.namprd11.prod.outlook.com (2603:10b6:a03:4c6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 13:01:38 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 13:01:38 +0000
Message-ID: <a9078869-b8a9-489e-875f-eba53ce08309@intel.com>
Date: Fri, 28 Mar 2025 14:01:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/9] net/ixgbe/base: correct definition of macro
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: David Marchand <david.marchand@redhat.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, <stable@dpdk.org>
References: <20250326155230.1315056-1-bruce.richardson@intel.com>
 <20250328111621.2665257-1-bruce.richardson@intel.com>
 <20250328111621.2665257-4-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20250328111621.2665257-4-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0310.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::10) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SJ2PR11MB7597:EE_
X-MS-Office365-Filtering-Correlation-Id: 1de75747-8958-426d-34f0-08dd6df8ad39
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Um1WNjJEb3dmV1dJbjRLOUxKaEdCM21mZmxkS25kbXVsaHQzOTNnQTkwQUhi?=
 =?utf-8?B?MHRpcWhsazM5dkVuQkVnVjJQWTd4ME9mRlJ6RGtCUlR5ZE1yb3BXa1I4dU5X?=
 =?utf-8?B?YUw4NDgvQ0ZZdG5taGhmcFlYYUUzQ2Z5V0dVZllVcFB3WUVNUWZUM25IZVV4?=
 =?utf-8?B?SVREWHlLSy9tRkNmeXlnU3ZGUmVqKy81R2ZqSFRCazkzYnFwL05HaW1aUTZ2?=
 =?utf-8?B?eFNVZmlaVENUa01PMDErcDhoVDlMTG80dDJaeFpJMHRtM0pJb3pLYVphSGF6?=
 =?utf-8?B?YjFZRGl0Nk51RnI0MlRjOFpvdmpkT0VRdGlMVTlESFVTaHhVQzFlaktmbDly?=
 =?utf-8?B?UGhhclhrVW81THJJQnJXVHdHbUdmRERyUkhLMGpBUEx3a1hZZ3VqTDBTM25P?=
 =?utf-8?B?L25ORS82RzduUFdHdzNGTHdNcVdWUEE5WlE1Z0hYT1FLTFBBYkd4TWkvbXRU?=
 =?utf-8?B?N0tvWkdUV213cmNOSFd0RHEzc1FQOU1EQjZDRWlydVJtT0JDQXV6TFZsa2F3?=
 =?utf-8?B?bERvSnJZUFZFVmhDUVV1RXg0UGxIMm5taEdsckl3cWtzYXduWk5wTXplK1p1?=
 =?utf-8?B?dSsxMzFtYUVwdEhHNjV4eW1NMnl5U3YwTUFldkhLMkgxSjNkOWg3YXQwM3p5?=
 =?utf-8?B?cnVJNzY5aW1GbW1YNFc0VjFYajlkRHliVlFCS2ZKQmNJNVZuazF1OVRYT0NP?=
 =?utf-8?B?bUNVTkFaQ0w0YTN3Q05QMHFQU2s5ZzFaL2o3Q0xUTmM2dTdNNFUrQjIzTGJr?=
 =?utf-8?B?UWJ0akFyYXI3enFNS1VoVXVhenA0Y09MNzZzYVdPeFN3NGhxOU5TRWtEeTNT?=
 =?utf-8?B?eWxYNjR1YXdxdWE1M0V4NmdrQjljRGMyVGhNSlpzeTZSR2ZQb0NhTHNlUU04?=
 =?utf-8?B?Y1ZNSzc4R2N2cUMxVVkwM0xwNHR0OHA0eDJGWnc3Tkp1TFM2akRWNG5HOHZI?=
 =?utf-8?B?MkduQVdMeWZ3Smw3elAzL1dJcXE0V2ZpUEVIc2Z0Y2RsRUJTOWZoT0dnOWQw?=
 =?utf-8?B?cGdYY3FZc0pTcTBQTGNTR0NmTnVrNFdpMzFYaWR3WUZXb2xiNUkzVkNNL2Ra?=
 =?utf-8?B?b2hHQXYyWWQ1WEliQ0xUUnlLVHZpUHJsMWkzMjV3T2l1bS9oZ1paYkhVcmNQ?=
 =?utf-8?B?dmRvNlN4Q2ZrSE02K3lEeHlEb1MzUzJFVnB5QldvVDFPUit3V25zUmRQMklo?=
 =?utf-8?B?enowUVplWkZ6NjJSZys5d0RzTHNKa292cEZWRWRUNzdDT1dTZGVwL3ZzdURz?=
 =?utf-8?B?MHhtYWZ5WEtld0lTTWUrOTUvM1BhMCsrcTBHQm9hNjFzQjY3OERVRnpWd0ta?=
 =?utf-8?B?aTM2Z3poQWMwSUptZ3hIQy9tWlAwdDU3K0NvS1RqVTU4Ymd0VEh4c2dWaDRn?=
 =?utf-8?B?WWdFR3k3aWFVM1RETzV3Mjl3RWxyUkZobk9kTmlEbExJb1hVYURuR2xqQlNp?=
 =?utf-8?B?V2dVWFBoT0FoYU5SOEoxeDBBTmhGUlRYT3dHNmcza0J0UlYyTHRNeUQ1ZXls?=
 =?utf-8?B?ZzFmKzlvd3p2RSsvdkIrckF0WnJydGtMaXZwZkRqVlU4RVZvOVFhTnl0cGgy?=
 =?utf-8?B?U0J6ZGc2ekw5NS9UNG0vdnlMM2o2UTRhU2RRaktWRW5ibTJwVEx6bEE0MzRP?=
 =?utf-8?B?TENLd25mTWJGYzJETGxCOGwya3JhNER0S3A1TzhpbUVpTWw5MHJxdTFjVjBU?=
 =?utf-8?B?U29QRFk3clJpM1FiNE56SG9mNytleVNHNWtaRldhWUYrMUJaTldycmpvNHpY?=
 =?utf-8?B?WGU2MTRXK2QvOVpaVVdkL0tzOUVHUTBGSERjczNQa0VweHlOSEZqdVRtZVo0?=
 =?utf-8?B?czZZNmp1eU1kSXBFaE5RaC9YZXdad1hYaVhRbmh0RWhLaGMrQTNvb2NkY1M0?=
 =?utf-8?Q?euyd3os5sQ4E9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VU16MEprWWU1dkNQNnRJeHMzUUI3aDg4a1h4RHYxandodlFuUllTTU5QeFE0?=
 =?utf-8?B?ejkzd1dxbDVpRDNENFNDM2lqVHNjc3dZL1NzQk80VzVGSGQrOVBsTFZ4bWpL?=
 =?utf-8?B?MnBITG4zN0Y2YnF6T0JyY1JVd3c5cjBMUlp6SjdMOTlnVm4yRWtzVDdQV2Mw?=
 =?utf-8?B?RTB1S3BEMklML0dqR0RHN0d6VmlISFVWUG9EOGpkeVJZa2RkVExBR0RQNFd2?=
 =?utf-8?B?UkIrV3RMeTFxMjZscHF1UGpxYjJRMHVGWFpmSitZT0NLQ05IUERwL1JIek4v?=
 =?utf-8?B?dnR6MTFCVVVJUXNUQ01UcGFMRWk5TVBGYW1raUFJOUdzTFJ1V1cvb0M3MDJi?=
 =?utf-8?B?eXp2azNpWWh2Y0dkYksyUGhKdlZZbWNGSW1ySHFaTm5qQXc1WUYvY20zdnp4?=
 =?utf-8?B?TFNLMTVwSEtua3pnYjNaZzBUbGREQlhIV0RJaGZhekRuc0hTK3IvSmJqdjNF?=
 =?utf-8?B?ZnlaZVFPSC91U2xHUG5scWx2WXBMRytRZTA4UTBzYXA0eUNVVllaMjVFSEJI?=
 =?utf-8?B?VHc1bnBjdkJEcFRCMU9PTFplamFybE1OSnhqUUZ3NHg4dG9hbm5WZGc4cXZP?=
 =?utf-8?B?KzhMWFk2TUl0TzNqL3ZSRVV1eTYxU2pFajR2Ti9WNythZmdRaUZTUVRYRy9D?=
 =?utf-8?B?SnJ0eFB3R3lEUyswOWdQelhPbHloN1NESTFVUlFNd3dXd21WQmgxL1I3YXJH?=
 =?utf-8?B?MFp1Nk0zSEFxc0YyL0Y3amJ2TFE3dUlDRTFwYUppWisrczd3UnVMM1luL0Q5?=
 =?utf-8?B?U0J3d25Oa2RjSlJQMjIzekQ3Uld6bVd0YWkzdlc2YjY0eXdGT2lxUGhnczk5?=
 =?utf-8?B?RkRLLy96RStPQUZzODRFSWZ6YUlHR2lTUjh1bHRTTnJOSWVhK1YrK0l2Y2pS?=
 =?utf-8?B?ZTVocm1NM0FnNWhUMmNOSHE4TTZSNEZobjlaRTJmZVhJc1F0NU1qUkdINU45?=
 =?utf-8?B?M3E2Qk9WdHUvcEQzTGcvb2VwYzRMd2hMUVd4QTkrd1NpSk1zcWpFK3loZVRY?=
 =?utf-8?B?RHVVU3hBS2FhQjAwN080citPQk5qekVJVEdwck5zaGlNeU9TNThlUUU4WUZ1?=
 =?utf-8?B?MjJGN1NVeXNDdlYvazgvaWNhUkZZZlNiQk1DQmwxMkVjeDc4TmRqLzRHa25X?=
 =?utf-8?B?UnVZZWZYVUQ0ODZFNEIzdXVSYmVtQjFkdHJqL3FWT0YzZ0UvMk9hbytSQTls?=
 =?utf-8?B?a1lFejhReEhqbTVpOGlBVTJHdGRzYldkTWlpR2QzZFNTN015RUk4UFFUVkRM?=
 =?utf-8?B?YVByRGtlR2VRb01ZNjM0SlNzMW8ycUNINnNuWkVac2VVVVUxQkoxdWhtZVUr?=
 =?utf-8?B?WVVOdHU3dnFJR1JFQnFiWWFjTTU3TTVtbTdpVmFmaURoQnZqMWgrUTlGUmEz?=
 =?utf-8?B?SjdPZ25lTnFSY1VzWUxrS0lxVWQxSU5keDhSUU9nTHJuV1paY01zMVFXMUJv?=
 =?utf-8?B?Nlp5Smh2UUhvcDZsVHc4ZUN5ejNmbzBHZ3dzUGhRV3Y3Q21kSkJUdWV2Zm9P?=
 =?utf-8?B?SXowb3N0aGI5Ujl1RWFoUGdXZ05McDRWUTM0TTV5Z3dJeTlocGpkNVNEN0dH?=
 =?utf-8?B?MWZvcThRMkxHOW9OOGltLy93QXMxTFFyZjVsdHFaaU1yL0tqT1JJMGVUUExB?=
 =?utf-8?B?enQyRTNaa1FqNFNmVjFCZUtXb0pERjNKNDlUVWhiWTA5WENwTE5nNFBtM2xk?=
 =?utf-8?B?UXR4c3Q0MmN1cWx5ckI1UmYzVHBnWmhZMVo2RmRJZUJab0ZiVGI3TFN6MXJR?=
 =?utf-8?B?WUtwR2pOc1VaR0dTV0tYVjJkZjBuVHNHZkVZcDFITDRENDlwNjU0cHljV05n?=
 =?utf-8?B?cXZ4eHlCaXhWbWMwQTFLS3ZBaDgvaTJLUEpLY0JtSFYyeFkvdFZwN1k4T3pp?=
 =?utf-8?B?a0dETTVKb2JrUGhhUmJYcytCMzB1a1dOeWJldDFjWVVWcllVdW41ZmJVVVlX?=
 =?utf-8?B?U1hJRkhLa0tneENLeWZxU2hWYUlrSHJtUVl2bTVGYkhBRFovcWkrWVhQMkI0?=
 =?utf-8?B?Z3dWV2lyZmpOejYrTkZvMFNheTZsN2Z0bmtRZTRsOG8vemhLVVc4cHFjMk9P?=
 =?utf-8?B?NmpNRnJxWUo2NWZlZUROOFdzTFdKRUI5NEg2aWtsU2VlUkEzTjdvUEZ1dlZr?=
 =?utf-8?B?MzN5VXhLcnZTd3gxcHdVeXN6TXZCSHIxWTV5bm80MFJUTWt4UERKYURuaUd6?=
 =?utf-8?B?V2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de75747-8958-426d-34f0-08dd6df8ad39
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 13:01:38.4668 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kjvWlXGedQnmZcXVPlbcI2woEFRcdo7KMWMjb2K+nHMcsR8+Hw2MxKA90E83JaUAJIRsj6jV6WS00oYNaXUQYGVlSGW+txqQi4bUvAjWHeo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7597
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

On 3/28/2025 12:16 PM, Bruce Richardson wrote:
> The definition of IXGBE_LE32_TO_CPUS macro is meant to modify the value
> in place - similar to the le32_to_cpus() macro in kernel. Fixing the
> definition allows us to remove some warning flags, and removes the need
> for the uintptr_t typecasts.
> 
> Fixes: aa4fc14d2cee ("ixgbe: update base driver")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
Reviewed-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
