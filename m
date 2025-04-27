Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97777C369CB
	for <dpdk-dev@archiver.kernel.org>; Sun, 27 Apr 2025 02:06:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 581AA40263;
	Sun, 27 Apr 2025 04:06:20 +0200 (CEST)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com
 [205.220.178.238])
 by mails.dpdk.org (Postfix) with ESMTP id EBFAF4021F
 for <dev@dpdk.org>; Sun, 27 Apr 2025 04:06:18 +0200 (CEST)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53R1KYWU017728;
 Sun, 27 Apr 2025 02:06:18 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2048.outbound.protection.outlook.com [104.47.58.48])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 468mq195tp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 27 Apr 2025 02:06:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Su8axUZ3guGumvNqdnuF/sPKRuq1nfNpUEl/z4zkn85a/87DJndFDNPL1/pYnNXhNDEjcbDOfOwECNYDphiqzZxp3pHshT4dimKhFxEMYeKx8ErxClvg99QvFzqUbHVFV+d0+23Rctr703S6wLEfTYfG0OFucdI1oa9TTL/bpCsdAd9pjx8o41uEYoZ6EJJOyDILxS3TUxPn1e99B6Tgznc94xcKNZngw8Y7Fbeih93QlF/NdRY1S5GyN6pfksgngmjkHPKKLVTOQ9WWhgcnymbEko+qJ57Cq6ojmte5R6c/jtBNZjDxHBYBKln4X9Uf4VuHyffwG20FzDXXh/BXkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOzUWXFH9KSkju3/c+3VNcTd2CPU9V7HirpcfLI/nJY=;
 b=w/hKq4KvmYi1tUAtn8S3OeQJ/GJL+tnJh3jW84GSViemlq1efvXY3YB0uPHJHDtLgLba8ho1divHcFg5RGz4L+r/n4rthTuSdgkeZNK9viqVlfA1GZ7JKaBU01FZuSlirknBE9aoS8OeJphXcFL2HoC5oN6g7OihhW5yLDKujQw/fExXtA4sSyGv6Aj0KRWY/C0K6kNisN6M/MkoLYCi1kf+ph60Rv9w33DaJBGQZeAUYB+VA6aULpnE2tQ/L2j1FcbAzCywxSOsFPofxhs59bzNMgMMNqSW6K/MxwlY4jvTDcr0zBCeXKDDioi4yBMjEpcbLubMr/qAcNGQPvOUXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB7312.namprd11.prod.outlook.com (2603:10b6:8:11f::18)
 by SJ5PPF5B09F0799.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::82c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.30; Sun, 27 Apr
 2025 02:06:13 +0000
Received: from DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::8436:b2d3:31a9:1c8c]) by DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::8436:b2d3:31a9:1c8c%3]) with mapi id 15.20.8678.028; Sun, 27 Apr 2025
 02:06:12 +0000
Content-Type: multipart/alternative;
 boundary="------------Uk7zOLb1Waz8bLbuSoMbD6Db"
Message-ID: <26c063e6-484d-4cae-94c2-b74981c92fe5@windriver.com>
Date: Sun, 27 Apr 2025 10:06:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] ethdev_trace.h: Update the trace point function when
 _TIME_BITS=64
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
References: <20250422122956.1217418-1-changqing.li@windriver.com>
 <20250423110052.1b89ad1e@hermes.local>
Content-Language: en-US
From: Changqing Li <changqing.li@windriver.com>
In-Reply-To: <20250423110052.1b89ad1e@hermes.local>
X-ClientProxiedBy: TYCP286CA0154.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::19) To DS0PR11MB7312.namprd11.prod.outlook.com
 (2603:10b6:8:11f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7312:EE_|SJ5PPF5B09F0799:EE_
X-MS-Office365-Filtering-Correlation-Id: 613d39a2-49bd-4851-afd4-08dd85301575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aW5oUnBnWGR6NXltQ24va00wdDJ4Nk9jMjQ1eU5TWTlDVkFpVlkrLzJ1VHJE?=
 =?utf-8?B?czFtelIzNDFaSUN1bHE4ci8wWkVRZFpHTHVlNFVQNDRHVnpmQkNaMEpGVDBu?=
 =?utf-8?B?bjF3QmxLZHN5ck1vKzJXYmsxK0lkdVNmYXlzVy9EUE5mNkgzeDZ1SmNpMk5p?=
 =?utf-8?B?bW1pN2FZeXRNWlRDYjkrNGtJNDVZWXhuQ3Q4VzVWWVc5K25nZ2JTaEk5NWRq?=
 =?utf-8?B?RGh3ODdHU29oeUs5d2ZHeVMrdVVUb0hhRTJDanlvbkdldHcxRzNzWEdHZTla?=
 =?utf-8?B?YnJUVHM1eVZmYnJyb0NUVE9CM1hERGc4dytWbVVBWWQ0REVsTXZCS2hodjZ5?=
 =?utf-8?B?ZStZSkNRcDRFTEg1S0swLzhOT1p6Z1ppWVZmVlNlZk04TWlXNHJ4UlF0eXJN?=
 =?utf-8?B?Tm42RkNXN3RlS1lvT3pvTVh2bXNEUzhWY3pOc2dlQjh4ekx3aEpJNDJ2NUhx?=
 =?utf-8?B?ancwaGxLTU5YU0UzdEREZ3hzRjVuVjRreUt4Z1I1cnBqZ2Y2RzV2Q25KanlN?=
 =?utf-8?B?NThPdTBzY3pmaDRvNjhjSW5makZHL3d1aWE2dkUxbzlSSWVvcXo4Uy9FL0RK?=
 =?utf-8?B?WFlnTXhUM2tOUE5IS0t4U0NRb3JjL0VUL2hYQ3IvOENHTWorZFZ3VTI3MVor?=
 =?utf-8?B?MlJndy9WUHY3NlpIbXN1U09VRWRtRG0zWEZkZ3NPYlJwUlFlZ2dOMUZUSzNB?=
 =?utf-8?B?TUxjaHJKdDVJWU45cE14bEtPRW1qUUJwa01YOWQwT09RRmx2SDJoQUpad0Jq?=
 =?utf-8?B?QmVlcFJoK2p1SERpSFA4cjA2MVU4aGh4ZUZCaVd1d0hzTmwyZ1JqaUk5NVJ3?=
 =?utf-8?B?YlpNQlB6VmQ5UFJIdXM3MytQWGcxWURZYUFmc0xJbkpyR0VmVkZ2amZWN1J6?=
 =?utf-8?B?OXdpM1ZlMmRNeUZXOFJ3S1NxZjNoM3B4eEdUbGpyME1SYWRZWkZGbjlydHBO?=
 =?utf-8?B?SnFwODVhTUZxaVorOFJIRFhyOC81SXBoeGlIakE4OVVLME5vbEt5Y25sVFJP?=
 =?utf-8?B?Y1F3QlJEOUtzLzdPdDczTU5KcHFkaVFya2s4ZXdOS2NvSi96U200NUhFeTNi?=
 =?utf-8?B?NDFad2dwUG1ORkYwRnY4SXJFOXZyNTV2SzlXaEtNQmE1VVdUanVuYWJickIr?=
 =?utf-8?B?dkdHSE5YNEh0NzAzTHVxNE15MGYvODlVTGNORDF2TmtEQUR2NUpNZlZQdkta?=
 =?utf-8?B?TXFmUnFmdHZFdkdyUzJLSytMMVlLeUFoQUZUMlg4OTI4dHRWU0JPMUxhTXJm?=
 =?utf-8?B?dlpic2JxSE1hSjVKWGZBdDExUDhiUVZpbUdsN1pjSHpXV0hTeG1xZE13eUw1?=
 =?utf-8?B?WjY1bFVmNmZSYTVwcUc2Wk13S0FUK2tsMkdkcVlCaXE0cTArM01yZmN5a2RJ?=
 =?utf-8?B?L2VHbU0xNk5lSnVVYlJ6YjVqVTZlMC8yS2M0TW5saXZONWs1MElpWFFESzRY?=
 =?utf-8?B?cElSSTlSdlRXRnZDaGJFUlUzNTNRNjVnandaSXJaQ2o2a3VxUGw0UlBIVmdw?=
 =?utf-8?B?QkZWK3VFdHNVVVJPWXlzd2tYYUNLSlRXdkZDSGg1V2VlMmdMUVp3YnViUENh?=
 =?utf-8?B?NEphU1pURzZXdFJYbWNYekRGTDNIMlh3ME9LRHVRQldtUmtCcUlxMm80aFFR?=
 =?utf-8?B?TjRRT2JRRWlRKzZsSVFjQlp1T21aN0dnVFIwNzFBOG5vZDJiNmhoU3p2YVQz?=
 =?utf-8?B?bmthbGFiU1M5b2FNNmNzanVFakcyWVFUN0hIdzk3YXo3ZHo2ZkhzbEdCTjBY?=
 =?utf-8?B?OUQzdDRHYTFmNmFPNHl1MWNyNkp0dFdEakRZS21ZNC9TNy9CUXZMVWo1dmZz?=
 =?utf-8?B?T1o4ZmNVYmVJY1JrVTVRZWdrbnpVcCtxWlBMMmZhVmdTdVNRejNpZG1iYVlC?=
 =?utf-8?B?K2VRL1hkelp3UWVWYWpKUkNIZjlQekxhNWJ1ZGNKVzhXTmc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7312.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enpJRmZtTTFpa3Fhc2FDOG1hclZiODN2U3pmQjU2aDQyZjEzWGgyYVRTT0RF?=
 =?utf-8?B?bG5lTE5LUmJndmFrODdzS1RTWWlQQmNEcnByV3M4YkdMN0xITWk0VWhiUC82?=
 =?utf-8?B?QWtodzNBK3B3S0RLRkxWdkZFcTh6MmJQYnYxd1FtWTR2VzhKMncrdVpidlQz?=
 =?utf-8?B?WFEvMEVsV1dmZGFLNGdzYnpTSWdlQVJkdndjUjJiTm9ZUmdvZS82cmRlbTRp?=
 =?utf-8?B?Y0dQcjVTVkhNSCsvendRYVlKUlBPdlhFbDMrVGNzd016UHVxelB3ejN0K3Ux?=
 =?utf-8?B?UFh4WEZDYmY0MDh6bUg2UFdsNGZjbHZpUnJrRkNER2c0dURzOEw3RENIQmtB?=
 =?utf-8?B?M3A4WGVPVWM0dnNYTm82a1JIM2JheDRoNTNaSldPdnVIdEVkdk9JeDI5ZlVU?=
 =?utf-8?B?NnAyOTR5ODJNTDdOZUZjNVIxeXdHYlRIMVdQTFdXY0kxbEFOR3pKUnNzZjJr?=
 =?utf-8?B?ekpFN1hFVUVYTFF0RGF5ZnFLQWZzSndMVzY3L0hMYUJjVXplUzAvdWIvUktN?=
 =?utf-8?B?M2RmNS93MjhPaE8rVk9QOHR6ajJrbmVrM01JN1ZYeDR5YmN0cDFPWEROSTVI?=
 =?utf-8?B?TWlXRWZWSnVFeFl2a1RpTVd0dFQ0bUxWei9vVVpFeGpIK3QycStFTkd1R0h0?=
 =?utf-8?B?YTZCVXVic0o2dmtxaE1hMG83c1NFSmdDY1RmYzFWVG5IU0tTc1FNc2FDbkRL?=
 =?utf-8?B?ZkV0c1FnQ0k2YmVaanc1SFFtdHF0WURJQ1I2WkpiWkpoVVkwNnVPMTR3OHdC?=
 =?utf-8?B?dGxiQjdqczlSR3Q2VFRlN0wxNlJxYlpNQUtGd2M0RWJneDlETWVqY0NNS2pn?=
 =?utf-8?B?NnpVdC8ydWtvZ2NSQmU4a0JYbFpDRzJXZlBZaWx2T1p2a2VUZUNBN1J0NzY4?=
 =?utf-8?B?ZC9Fb3dKRzRRUUpVZThiVktQN0swN21HRDlzV25lK3d6cXA2bGhrSnRoOXZT?=
 =?utf-8?B?SnR3Nm15ZHkxS0Z5b0dTdnRsNFBZaU9SRm0reFdTTFN5Z0hVY3FJNDhnRkxY?=
 =?utf-8?B?TlJGUlBubTN0dlNCRHJWNWhvdnVURDdQUTR2ckJSYzAyRk9yaVp1WVMxbUxV?=
 =?utf-8?B?QUdCTGJpQUhabi9SRlVaZ2pzSENxZHJyTHlzTGxKVWdzU2haNjhneG5NdlFH?=
 =?utf-8?B?RVJDL3liVmJNcU9qMDExTnAvY2J5MDdIbzk1YndZL1k5c2NvbFRpU2ZqVkx1?=
 =?utf-8?B?TzBmSHNQNUJySys3aDZWblIwWGVoeUpPWGhKcHk0YmdSOVJBNjZDNG9hYjdV?=
 =?utf-8?B?cmJaODJ5R20xVlhSbHpqSWhKZ1NsWWNMajlHVjZLYkVOeHdkTzlTWkh2M0hn?=
 =?utf-8?B?NmpCUThtYnQ2cUU2ZzdQS3lSNWg5VkdXM3U3WnRjRXdCYkNUWWZIUXUwZ0pw?=
 =?utf-8?B?RU52M1hCNk0rOXlKTVFyOCtvU1J4b1hPK1RMUkFXQk5MUUdpeEI0TFFYRnow?=
 =?utf-8?B?YU5wN2JZNFI5MnBkT3ZJT2VOMUxMZlgyakhyVEpObVhaeTRodCtzUzV2VllO?=
 =?utf-8?B?eWx4UXNCK0RWcnVDdTl4dnRzaEt1RHNtWkFqWk95L3dwRWczZUtFWitrTlRJ?=
 =?utf-8?B?YnNUdlpSS1REUEpEY3Eva1VIVVIzUWtQYkR4YU5uZzYyOTMwaWx2bVczTDRJ?=
 =?utf-8?B?ZG5TMnZtT1pSQnVESDVLWVZDNEZiOGhoeENod3hYbk16TnZIMFNyK1k2cjJK?=
 =?utf-8?B?YTdMWXhhUXphYkl5N1VoL3NDaWNiZkQ5N1VCV29UMUpCK2ZXOG9KRGUwS2JQ?=
 =?utf-8?B?YXRkajlFNHZUSStjdCt4Mk5HdFV2ODdPN2pZdXlEZmRjdkJBN2lQaHdYOWMx?=
 =?utf-8?B?T0VVbEp5VjZuOGcyelkrM091aExpejhkTlU1RkM3cXRUajNka0lRUmV5cm5q?=
 =?utf-8?B?bGlIUjVoVkJLdlFROUUyelRvL0ROay9iMHA4S3dhUEZOdG9SeU1iWExOUUNt?=
 =?utf-8?B?QlQ0ZE1NcGY4Q0ZUNzdBcjVHamVqWEduaHdzMXJQcVRGV3pKam5iVXYyaEd0?=
 =?utf-8?B?NWxrdHlZb1BZaEVqZnFCSUNrY3VTdnhjbjJkOHZrOHhmL1ZhL1FtNW1EL1VP?=
 =?utf-8?B?VlVZTGs0d01iOFgzNHF5ZXQxS2JHOGl3MHlUT2VvbmhkSjZDaG9oZVY2WUVG?=
 =?utf-8?B?VXhIVHlYN0dPUXgreXVvU1FrVEZMOEE1TlQyajREWHZlTkZMeXZUZkpQNlA3?=
 =?utf-8?B?V0E9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 613d39a2-49bd-4851-afd4-08dd85301575
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7312.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2025 02:06:12.4699 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R4FwgEp39/2Kska0tMfBapcBPTyeITuSBhZt8TfHR0qe4XrNzjr1x+fiVDm95d/ND9FGyOnLwIRuxy5TTw1KJfMmGA7MAKmgNbcWBJ9Gyc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF5B09F0799
X-Authority-Analysis: v=2.4 cv=KsNN2XWN c=1 sm=1 tr=0 ts=680d9119 cx=c_pps
 a=IJ1r+pqWkCYy+K3OX67zYw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=t7CeM3EgAAAA:8 a=mF-CVRvQRVPVjV8obTcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=wvPkM9v7g1_ikmSEda4A:9 a=zbUGb2XjmQWv-1VD:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: FHnkfp8CMbm_GSvTcwH7MViZ6IFQ0ZnU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI3MDAxNCBTYWx0ZWRfX0i9SGBH1q7sf
 W/liAfdUz3mIUqRhpGrbKjFyIRvsHMiwXCyeYH48chpe8PJyo+dwceqYMSgwT/0h+9bmUajlluN
 6QN0ZGVLYyZMH7sy9Dkm7d+GJsg5FURRL88cL4Sn0Kigbyl/qGgWNwjrU8b1t3EIXCMrhD9T55I
 7mJGzuFR66idMdrJ5ZdYYfKyFKpnBIt2wIjLbg70Oj6gouO7q42xjHzAWYnd4Z0aC3EUZRMfSNa
 fIFi/oSS2/W1jpw+JNOOp/1wKcf0M12pAD9RSkzVtCS2LLDYpSH/6b2aQSWEuufmIH/m1f0ojXC
 NN2cW0U6POJExT3e05AQsR/ITSXQthnDQguOSMmLa4PgUEcOV4V02XcKhCsotwoIZFMe/0UAvSP
 n6Cw1CbhPrTc2aYVHtbJS5GOaVMhjgP6I1BGy8dN4TE7sB66cH7+HA56LZzd1WmCBW3m/fJ7
X-Proofpoint-GUID: FHnkfp8CMbm_GSvTcwH7MViZ6IFQ0ZnU
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-27_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 mlxlogscore=748 spamscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 mlxscore=0 phishscore=0 malwarescore=0 clxscore=1011 suspectscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2504270014
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

--------------Uk7zOLb1Waz8bLbuSoMbD6Db
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/24/25 02:00, Stephen Hemminger wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Tue, 22 Apr 2025 20:29:56 +0800
> <changqing.li@windriver.com>  wrote:
>
>> +#if defined(_TIME_BITS) && _TIME_BITS == 64
>>   RTE_TRACE_POINT(
>>        rte_eth_trace_timesync_write_time,
>>        RTE_TRACE_POINT_ARGS(uint16_t port_id, const struct timespec *time,
>>                int ret),
>>        rte_trace_point_emit_u16(port_id);
>> +     rte_trace_point_emit_u64(time->tv_sec);
>> +     rte_trace_point_emit_long(time->tv_nsec);
>> +     rte_trace_point_emit_int(ret);
>> +)
>> +#else
>> +RTE_TRACE_POINT(
>> +     rte_eth_trace_timesync_write_time,
>> +     RTE_TRACE_POINT_ARGS(uint16_t port_id, const struct timespec *time,
>> +       int ret),
>> +     rte_trace_point_emit_u16(port_id);
>>        rte_trace_point_emit_size_t(time->tv_sec);
>>        rte_trace_point_emit_long(time->tv_nsec);
>>        rte_trace_point_emit_int(ret);
>>   )
>> +#endif
> No. Do not start adding #ifdef to trace points.
> Instead, add new hook rte_trace_point_emit_time_t and that can handle
> any ABI changes like this.

Hi, Stephen

Thanks,  I will try to add this.

>
> Best to wait until 25.11 release since could be ABI change.

Do you mean I should not send V3 patch? Send the patch after 25.11 is 
release?

Regards

Changqing

--------------Uk7zOLb1Waz8bLbuSoMbD6Db
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#cceed0">
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 4/24/25 02:00, Stephen Hemminger
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250423110052.1b89ad1e@hermes.local">
      <pre class="moz-quote-pre" wrap="">CAUTION: This email comes from a non Wind River email account!
Do not click links or open attachments unless you recognize the sender and know the content is safe.

On Tue, 22 Apr 2025 20:29:56 +0800
<a class="moz-txt-link-rfc2396E" href="mailto:changqing.li@windriver.com">&lt;changqing.li@windriver.com&gt;</a> wrote:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+#if defined(_TIME_BITS) &amp;&amp; _TIME_BITS == 64
 RTE_TRACE_POINT(
      rte_eth_trace_timesync_write_time,
      RTE_TRACE_POINT_ARGS(uint16_t port_id, const struct timespec *time,
              int ret),
      rte_trace_point_emit_u16(port_id);
+     rte_trace_point_emit_u64(time-&gt;tv_sec);
+     rte_trace_point_emit_long(time-&gt;tv_nsec);
+     rte_trace_point_emit_int(ret);
+)
+#else
+RTE_TRACE_POINT(
+     rte_eth_trace_timesync_write_time,
+     RTE_TRACE_POINT_ARGS(uint16_t port_id, const struct timespec *time,
+       int ret),
+     rte_trace_point_emit_u16(port_id);
      rte_trace_point_emit_size_t(time-&gt;tv_sec);
      rte_trace_point_emit_long(time-&gt;tv_nsec);
      rte_trace_point_emit_int(ret);
 )
+#endif
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
No. Do not start adding #ifdef to trace points.
Instead, add new hook rte_trace_point_emit_time_t and that can handle
any ABI changes like this.</pre>
    </blockquote>
    <p>Hi, Stephen<br>
    </p>
    <p>Thanks,&nbsp; I will try to add this.</p>
    <blockquote type="cite" cite="mid:20250423110052.1b89ad1e@hermes.local">
      <pre class="moz-quote-pre" wrap="">

Best to wait until 25.11 release since could be ABI change.</pre>
    </blockquote>
    <p>Do you mean I should not send V3 patch? Send the patch after
      25.11 is release?</p>
    <p>Regards</p>
    <p>Changqing<br>
    </p>
    <blockquote type="cite" cite="mid:20250423110052.1b89ad1e@hermes.local">
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
  </body>
</html>

--------------Uk7zOLb1Waz8bLbuSoMbD6Db--
