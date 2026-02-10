Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2575FEA8116
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 13:28:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 586EB400D7;
	Tue, 10 Feb 2026 14:28:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id E2761400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 14:28:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770730086; x=1802266086;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=CyQO7L7Z0R/XKXOc9+KFBRDhttktFdXri1PpWCJ53/8=;
 b=F1xnWn7E7N/1jktzpcMIS4wz7S3g6NFvglm4/+scpuT70dfAuBmxHbts
 b+nKYFYmDJ2SoG9ADxEjIA3JgLSatAdr6WGhpK5bL/FG1alt31NtyKPZv
 Jb9kEjEOFnyGQrOq1WmtTM0cC6dKPCp09H83WSBFNBTbqYcZ8952p9CVJ
 Sy3hA5quyDkI2pWlRewHDdMtrds51KR/yoS7hZXXn54y7fsUyRU26gGzU
 8k8MqwaAgD11ixuwCAch+M0BqNVOF9W+ffcwz6mY/mJx1iHiFIFsvME6Q
 9RZgr8k5b9SNQk6E8HZkn5l4+W0eI6lnb4brQATONenkn3XkoVGsInl3A g==;
X-CSE-ConnectionGUID: tiFe9f0ZQ0WzmsrLsf6yeA==
X-CSE-MsgGUID: AL+PP+WuTKGaWI9lov/zYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="72041933"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="72041933"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 05:28:05 -0800
X-CSE-ConnectionGUID: 0SxrZ6G1R0SmHHbtdJDvkQ==
X-CSE-MsgGUID: I/N2IBgpRIKCo3aviW2Dwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211247689"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 05:28:05 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 05:28:04 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 05:28:04 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.31) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 05:28:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lr0XHo5ja9QOb4bqCrhrZvRVcX/FvQENNJvcYvBeT/IWwV+dT0xCKC3eStGGkVKs6VT0zpYBipXr3FxAGoKVODaUhNewMXHM6KmJk4X4aTCiu5wInWOIvd9SqgW2S7l67lDyYmBiOcqxMNxZy50jtHh7nop8HouH59nknDTmHbdcgtKshzSrA6tm7PdCVUGqsDM+AkJWpiEDtjnEY70z8LNxE3+1svHYJBFJITij6Q+wP9dOVvb+zZ4cRt7xMmvJu1u9NyKc1ayLJUHHQQluyL0FSwbXN1a6JivGDQKNVEKHNT6RnJxBJkBhj9aVuR+v45uxqP5tlDgSbMAeIb8tQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zdi/7K0Ek0LQ5Dis5bTSlqt5XpxP0ujxn1Ch35/S+k=;
 b=leHIzROOalUoFTVVCBXtDq0GtvMcXYFGebx2DwuAYRawJmfEd9n5nPF2pA92tDYsYhrD1CfXurmQyhBL9wR25Cvm6hnbK+j1qARhXnHjiFO4DzFpyg/nZdOC45RaU3PYSDPPADEYdOC5fdARI9XNQnaYT0yWlM2UXopS9qk6xsxzt92LaRjSv7uZlmDAnoG7WGzwGi9wYBAoA5hB1gp2kexlfphBhGDfSekymkumGqGIBoqihsyppHiO6w8LRi5LarxexyFng2bOGgbuww3FjRhPtaZflzk2n5/cMcalcxQ//rfMn35K4bUNmvIOWeBnES+z1Nk0nbYJRmsbJPbDJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DS4PPF9E4E1C227.namprd11.prod.outlook.com (2603:10b6:f:fc02::3e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 13:28:02 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 13:28:02 +0000
Message-ID: <25b4e4bf-b572-4a0b-832f-020aad3fb2b7@intel.com>
Date: Tue, 10 Feb 2026 14:27:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/35] net/i40e: document requirement for QinQ support
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-17-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260209164538.1428499-17-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0155.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::11) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DS4PPF9E4E1C227:EE_
X-MS-Office365-Filtering-Correlation-Id: a723b272-d3e8-4919-b60a-08de68a83735
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d25DalhkOEdwQ0pETElkNm5oQUNRdFNFeWQyZlJUREVKME0xN3p2MXR4TTRR?=
 =?utf-8?B?WTBndk5NWjAycVppTUsrTTNqVlBaelYxL2VZek5QWmhVVHhZb0UySnd1cWla?=
 =?utf-8?B?VkV6Mmh0K3U2d0RDd3ZkVVh5bjRFb0UydWcxVVoyMjkrNENaZDBmZm5oOEU2?=
 =?utf-8?B?dlh4UC9zcm45QThJYXI3Z3Y2YW5zdWtxMytNc2ZqREVCNGdVb041Yk94a2Fs?=
 =?utf-8?B?Vm5yS1pMM2pCQ25aN1BpUWxkUUNXT2lBVGdGZWF1akwzZzJOYTVQYUxKcWlP?=
 =?utf-8?B?bGlackxobCtuOFV0UExXZktaeUdJNEFORkV1MmN0QVhLWm8yMnV2SjBJNFlY?=
 =?utf-8?B?SFlQckwwcEMvWGxaTXA2bHpPallKbWdhRzlMQWhBdk5vTHRWTDUraGR2UTE3?=
 =?utf-8?B?U21aTTNDWHJrYnF1TkhPZVJ0Y3NROFpoRVVBSkdEL0lyV2RkcXd1dGJ3QlBQ?=
 =?utf-8?B?Mmk3Nys0K05oNVUyZjlkYUZTYWpQaGR0WHJKdDIrNUJZY1NXMkx2UkUxOHdE?=
 =?utf-8?B?dzdELzlxOWtqV1BtWWlyQkZ2djRqWFFQR0Nod1ZQZ1JyV05NMXZJM0dQUlFw?=
 =?utf-8?B?c2VUZ1NiV2VvNmV1MzAzbjFmM3JLcWJBUDVtNmtKcGw4SzREMjZuUEEzYmNv?=
 =?utf-8?B?TkxQeVVoeUkwMStMVjdVbjJkSEtBQ3BrTWJVVXdFTXRaVThPM284dU9mOVdU?=
 =?utf-8?B?Wk5MTlQvRXY1VlAzSWpJcDYvUmo4dEUvNGNTcjBxc1VqK3NqTlhBbFFaWDQv?=
 =?utf-8?B?djBsWGN2VlhyaHJmV0N5NWlRL2pWOUVSNGEydlVrLzBYSkRUc2ZWdXEra29V?=
 =?utf-8?B?YzJYcWdMcUpSZUxhb2l0K0d5MGhEUWh4VWVJdTlhaC9COGYyeUtJS25LZzQy?=
 =?utf-8?B?dnlCZ3gweHBqVUJpbjU2QXRueTlLdzA5RW5wdkdhUHQyT3lOanlUT1QwaERl?=
 =?utf-8?B?TFJSVktpdVUrMm9RNEI1UnJTTGh4VERCeGdPeW9RZmZUNWxQK21Cc3JMZmds?=
 =?utf-8?B?QkV1MElTdERrTmhyaWF0ck5KNHVrbitTVEFqQXlwbjZ4STNaVmZFUjY4eEd1?=
 =?utf-8?B?Vnp1TFZOM0ZTNUtjd2R1U1Q1MGM1TXdTcHZpS0RvOFVSbHEvVjNXTDk0cno2?=
 =?utf-8?B?ZXp6MlVIMTBualBoaGlmTDhHRVV2aXU2QS80U2s1UVd2Q3RNTVM3NEhQd09K?=
 =?utf-8?B?WVdEZnluUm12Q0Jld014WTduTUd2dXJJUk9YdU1vL1M4SHpFSU9RVkdUV01D?=
 =?utf-8?B?S3JTSnBpU1BHRnA2Z1lKVGMwMURsWnVFRThFcjF2NlZFRmdKQ3NhaUJEUmZY?=
 =?utf-8?B?Yms5cXNwNDhtaXZMamEvS3JPZG53bFdWNXNxSmFMTDFOYUc5YTNLZGEyOHoy?=
 =?utf-8?B?MG03ekdWbDl1WUZSZGdaMUR5T3NrSno0Ym45Ti9PSlpueUJNSVljRUpQdFhK?=
 =?utf-8?B?dG5EMGdGUVdHMkEyUHpTdndacFVGTVpreXBtMUxsdHQrelBjRDZkUkdxZith?=
 =?utf-8?B?OHNGMFhjRVBaWjUycjhEZEJJZWVROERBWktyQVVBT1pOTmszaTFCcnpmdjJN?=
 =?utf-8?B?d2RHM3YxZy9kUFltcW5KSFRMbEEvRFkrSFhtRkJQSTBPQTZnOTB4bVQ1YVpP?=
 =?utf-8?B?enR1Y0JMdFBVMVlBVjJHc0dKVGFqMUtFaUpXK1dFQURQU1dJSDIwSjFLM1No?=
 =?utf-8?B?U3JDVkY4ZmJjemI4STk3STllcDlLL3Y3OStlZnlBaW1aRkluNXMzQ2pnd1E2?=
 =?utf-8?B?NVFid1U4b0djKzN2V0tXT1RoK0l2S0RWNEdVN2JIaC9NOXo3QVBoL1l1UndK?=
 =?utf-8?B?eldJVnl3dnNadXZxM0RkdFVsb1M1TDhuNy96bG01T0hmVmpsc3pEbVc4NGc2?=
 =?utf-8?B?SE9ZVjZBanptYnhDNGxGS3MwbDJvK0NxQmRUbEZVSGN0ck5qZzRHRWl4b0sx?=
 =?utf-8?B?NG54aVBvcyszcGNZTnorcjRRQXRabWwvVlFpUk5QM2hJOUNYalhxVjBGaWkv?=
 =?utf-8?B?RnRzNEZPdHhXZ2dDb3JlVUhUTC9XOW1BMW1wSHFacFoyNzErSmFCandkM3Fo?=
 =?utf-8?B?Z0xIcUNxR3NoR1F1ZGxPcjRlV1FMQVFtbTFLMzFwS3JWOHBZQ1FMWE9HUnU0?=
 =?utf-8?Q?RW8M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S296WWZrVngwVmJ2QmZzMDY0UXE2RklWWGZsYUNsNTZrOHRLWTl0RXJQT2tl?=
 =?utf-8?B?Q002cXg2ZHdESGpIa3hkc1dWNjRIRDA3eU52Szg1ZHVqM1N1S2U0N0x5bjhT?=
 =?utf-8?B?R0xpcG1IN1dNQkRzbDdMMkt6dkxQQnZOV3lLTThYZTFPczN2WW9qY2Q0QzZ5?=
 =?utf-8?B?WHgvZmxrOS9GQ2lUSFkvdzBhZDlPNmpKcEhYTWZIWE84OVJRN21CZVcvZDVW?=
 =?utf-8?B?OFhzMUpIVVRtYWwxbnFPb09TTkl4WnVTemk0aGJYVUJySzFFYWJGNEphTGF5?=
 =?utf-8?B?V0l2SXBQT3VqQnNSRnNqUG85ZW9yM1hDcjFWL1FIN2IvT0Y5Z000Vm8rd25k?=
 =?utf-8?B?YVZ2aExvUThZV1VtSHpnS2pzWnYwS2RZa3NlZjl4ak9IekFTZS9oL3pRVnUx?=
 =?utf-8?B?UWlTNTF3TENKeW5uOVNRRkVON0I1S0xVeG42blF0djM0SlVtZUNQN1daU1lv?=
 =?utf-8?B?Y1d3Y0RQRVhpRWdzOGZDUHlMbkZITXNyVWZrSVF3WjVtNmNlb3NxbW04bGZG?=
 =?utf-8?B?Z1UyWDFjcUZwUFBZWnc2YTdZTjRNV20vS2JFemFZTzJDemQ5YlRJNk9GTlg5?=
 =?utf-8?B?YS9SZHRHOHJaM2RiNTJSQkxaUDZMZnFabDh1eEVNUmNuc09kM0FIdlZmZEs4?=
 =?utf-8?B?ZjQwdElpZ1c1L3I1Y29XSkxHeFJOM1BuWklaTE1PSTF5MmYvM0V2UmFiMWdq?=
 =?utf-8?B?K0J3dm9ieUkzNm83b0hMbUJZTW9kWlFWSW5BT3lvWUM1L2tuY3JHcmV5U3Iy?=
 =?utf-8?B?Wlo1M05LOU5iZEIwN3h2M1JqZnhBNkVubU12QklCUmh4SUJ6R3gzVnZmOWdC?=
 =?utf-8?B?aG1BbXJNZkxrYWlwVDJadCtLUi9YYUpSVDNIeWk5SnI4VUpsWVBnRVRidHpl?=
 =?utf-8?B?R3hGOTlpT09jZDd1YmFtS1Qvc0JtQzFUTE5lUitPOENDenhJVjExcFJOOFNS?=
 =?utf-8?B?UjdyZUJXbVRSTEphTXpNVkZFSGpSWHI3ek5FOTBmUzVTL3hJYVp6K3Q0dWZy?=
 =?utf-8?B?ekhUSElnNjNONWtsM1owQ2h0bUZtNHo4ZGM1ZlVFNm5TblV4Mmp4YTEyTWdq?=
 =?utf-8?B?UUthYlVRaFYwZG1jUG02QjJtcnlzaS9KWWp6RGFVZWY1QkZCakJKNWJEZDlM?=
 =?utf-8?B?UUgvRngzTTZBYks4WS9GVXZUTFRUVG8wdVErelpDWHVtR21UWWlPVm9tdCtW?=
 =?utf-8?B?OWZYdjVOQzFybDNaTTU5K0xkdkJ1dm5jRkNYcTNsRFRCMDBBcjBkc0FOazc3?=
 =?utf-8?B?T2hlOEJjUFRITndTT1J2dFkxNnRPVUJHcmZKakYzMXRkbFhEWStzT0N5SHgz?=
 =?utf-8?B?WEtxcWQzQlhWNVFlM0tuZTlVb29QSHp2ck1qV3JFbU44SWNTakdEUEIwS1A1?=
 =?utf-8?B?WUZHNFJZV0FMZGZhNVBPRkM3OE1aeDN2SUFZUHV0TE4xRUxxOXVmTmhJenpC?=
 =?utf-8?B?Z25lMTNmREQzNDN6aitPNTZicG1pVWtoVXRZekRNY29kMlNEcEJjdWRrbHRU?=
 =?utf-8?B?THc3L2ZNRTVqWlJoSUNCcDQzeDdjQlU0cm9ER2UrNjIyZmNuUURtWmtTdmxv?=
 =?utf-8?B?RDd5ekhac0RlemVCbG53K3ZhQkdJTTZGeitrQkpVSlg1eXNmRklQd2hHTC9n?=
 =?utf-8?B?dUsyUGM1ZHNVMmMwc0ZjZis1RDVDZnV3K1pia0VVK3VKR2JuNi80YkhZdjd3?=
 =?utf-8?B?a1V5RERnejVEOXQrZDlUQVhpRFRNeVcyNC9nV1VIU005ZHd0cEx5ZlU4Unpu?=
 =?utf-8?B?MXBMMzE4MWovRXZ4ajVMaExGcXhtUG14NzFOUVR5TjRvWFVVNS95VXB6b2Zy?=
 =?utf-8?B?My96ZzY3RWh3R3d1azlXYlRMcFdSa1NlNWp1cmlmMWUvR01yUnhib3hmMVgw?=
 =?utf-8?B?N21mYXUrTXBJamFoTWplRWJZMHQraUdIb0tUaHpjbk5LaDNqVkhwMzJyVjRC?=
 =?utf-8?B?anVtdEFqVW5lN2Y1N1FxTkRWUUZoN215d2tzWFhlTXNwcWJWTEJBR1Bva1Qx?=
 =?utf-8?B?ZWhsZXE4Y0xWTnF2ZGFpaHZvWkJoV3FyMmxyYW9aazRMQzM0SG1hRzVsWDdz?=
 =?utf-8?B?V0M1OFR1Znh5aUhUamF4emIvV3lNY1VNeXdzUDZwcDlvTW9BVGQ3YjhTNU1X?=
 =?utf-8?B?d1p4NXhFTmd6Zm04eDlhUm12UndyUWlKSDVtaEp0OE42dkgwdEkxWTBqdUVQ?=
 =?utf-8?B?UW03MCt5MjlmWmRFQ0xpeTUyZHp0VmpJVXlpR1BTK2c0N0ZlUHRwSjBuVWlK?=
 =?utf-8?B?ZGt0dTNuMTg0clRvNC9rWjc3cGk0U3p0L1NrUVNUOVZRdU1xZkRYNlR6bDR4?=
 =?utf-8?B?Z00wayt3UHBQSnVNUlJMMG1QQ3JNb2lSVEdrWEExN1U1OTdxZ3IrbnFUb3c2?=
 =?utf-8?Q?HKrMoDzfhuvRBE9s=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a723b272-d3e8-4919-b60a-08de68a83735
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 13:28:02.5480 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P3D1t3XlrqhnJpAlyKr+W9SO9WsvXSoy7MFPhYBU1IZc+KUTmA0enzLgHiH73S6mWRa9SWk7pJE+XMcaGPXu2+kpHIrYB+8ETdby5gMozGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF9E4E1C227
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

On 2/9/2026 5:45 PM, Bruce Richardson wrote:
> In order to get multiple VLANs inserted in an outgoing packet with QinQ
> offload the i40e driver needs to be set to double vlan mode. This is
> done by using the VLAN_EXTEND Rx config flag. Add a code check for this
> dependency and update the docs about it.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
