Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752A9C3ABBC
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 May 2025 02:21:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A1D74025D;
	Wed,  7 May 2025 04:21:47 +0200 (CEST)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 by mails.dpdk.org (Postfix) with ESMTP id 2F28B4025A
 for <dev@dpdk.org>; Wed,  7 May 2025 04:21:44 +0200 (CEST)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5471x1Mw005819;
 Tue, 6 May 2025 19:21:44 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46dee3btb5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 May 2025 19:21:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C5Oo4P2d6X35fHPhBoTWJ95kSY2XdkK3kCFfl0IjwTp3h4wMd1zaOb3LlDNy4OIwmDMWK8Tpu3k/FvqBwGiKmpFhUSU5IsOm+YQjzHwlliySLJSn48AXzgoslZOYEY/jjwPeD0MDXlnKreXXf1O+DM6VIBUkt/B9vujyVcCQTw0jGoizRZcqaD8F/YxK0Q85HfPTisFxhg3y7HFNVdZKha3j0X141uKIPIE0NoXJVNkovWsHFF4w5cmGg2lMJ1iJPmqUSie8dp8ycIHQ/ffu73xT6pfqi8LG1T/2edsWvwPqyGj+lIpynbCCEzNjY9e820MllXdxAMxMZVhNUyDshg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8u0qoWFQkVldHJFPWkj3HTPYod1+/hucNiMCysp1QU=;
 b=igNDW76rcxnqYDdNWc1TnAT9Wt2rsvMbhhJQWJuISgjhpzSDKuOSlmeY4MFJJJLS0RUz40e9uSJtbFhLibE3hM9W90vVkPKuVqC2ejYEwnejOsj/bjEJ9MLVJoUD85aTyYs3m8xUQMQC2WI9suRtvtT1PEFkqFzwBpOB7VidhqyKDKELfwkh4QsLZeiIVLg6QMD7OiZ4CFYDzJW/LNEvZglBmN7o+ZFhQyYMyb5HuSlFOpK7cKmCRgMpxE3AbPFfpJfLnq/Dnk+XYpGq2zlqTh4bBWmWf9Yjfxq0yeEWxnXW0k+DNhmQ9Xh8FGPcHTZFXmq5NJEJfdfVlyNvm2IZ9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB7312.namprd11.prod.outlook.com (2603:10b6:8:11f::18)
 by PH7PR11MB6977.namprd11.prod.outlook.com (2603:10b6:510:205::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.25; Wed, 7 May
 2025 02:21:35 +0000
Received: from DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::8436:b2d3:31a9:1c8c]) by DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::8436:b2d3:31a9:1c8c%3]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 02:21:34 +0000
Content-Type: multipart/alternative;
 boundary="------------OcLJvCuy75ev0Zy6H5ov3Xhg"
Message-ID: <e6ca8bfc-06dc-4844-9b2d-f44436050165@windriver.com>
Date: Wed, 7 May 2025 10:21:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: |FAILURE| pw153190 [PATCH V3] Add new tracepoint function for
 type time_t
To: David Marchand <david.marchand@redhat.com>,
 Jerin Jacob Kollanukkaran <jerinj@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, thomas@monjalon.net,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
References: <20250430013431.2056969-1-changqing.li@windriver.com>
 <20250430024403.2690306-1-robot@bytheb.org>
 <d498a836-e6eb-43b8-9ea3-bdb98ae4aaf8@windriver.com>
 <CAJFAV8zk=gzCagoU7c4=dsXcEFnLjiqrWxwTWANa-U77Uj=Taw@mail.gmail.com>
Content-Language: en-US
From: Changqing Li <changqing.li@windriver.com>
In-Reply-To: <CAJFAV8zk=gzCagoU7c4=dsXcEFnLjiqrWxwTWANa-U77Uj=Taw@mail.gmail.com>
X-ClientProxiedBy: SI2PR01CA0015.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::15) To DS0PR11MB7312.namprd11.prod.outlook.com
 (2603:10b6:8:11f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7312:EE_|PH7PR11MB6977:EE_
X-MS-Office365-Filtering-Correlation-Id: 53049c0e-0cff-4ce8-2e68-08dd8d0de32c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|13003099007|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NnVYWHZqZ3hYbUFGbUxPbzNwRlBTMjk5VCtFZ0JsdG04czhIQzgvWUZrL29n?=
 =?utf-8?B?eEdrcjc2Wmo4L3hlcnBoaE5jbVZkZkpUUVNBWThHNGIwZG82cFNFelpxQTBr?=
 =?utf-8?B?dUR6MTM5TVRJV20wMjg5TE1ZaUxVM29jZllndmdmRWpuSVY1NENUdldFWm9B?=
 =?utf-8?B?RUhHcVdRTFIxbUNOWHRhbjVvelYrT3B4RWZhL21PTytEeHZMQzdQUW13TXJL?=
 =?utf-8?B?bzBKYWt3aVl2MlAwWUo1MFZTTTJWV29DL2RBdStqL3k5aHRMMERnUFdNTFRq?=
 =?utf-8?B?dHg5dzhZT3VLK1E2SEdaeVhNa1czZVgyZlpZR3JnL04vT3NlTGdVUHFHUnJa?=
 =?utf-8?B?Z0hmc1RCNGgwN21GOUtFcStJa2dzSHRHeWFUd3ltQ2t2cENOVmM5ZWdUV2VD?=
 =?utf-8?B?YjJXUlM3L1RrNGxHVU5IYnQ5SVFkN3h4NHhzU3EvTzNwU1lQZ1hVM1dGUDQx?=
 =?utf-8?B?K3lHanFodGxPRFphanZ0azJvVU1oeTd0MGV2dFY0RWJLOFlUemRXdDcxYzFC?=
 =?utf-8?B?d2xTWTFXdmM0LzBSUUVtVWg3WVhnMTlXekZ0Y04rMldnV3NzaFdraXhja09K?=
 =?utf-8?B?RUlYL1pmc1JRK2dYWW9QRUQrRE1aT1M2dUpmRVFuTU54MFRaKzVqQmhYS3Bh?=
 =?utf-8?B?NlFJZFphVlZ2cEEvdTNUcGVTTmtpT3BISVNUZldTMU5SSWZuMXhHKzJDYWwy?=
 =?utf-8?B?LzNmTHI4L0l1Y3dZYjFUZ2RnYitXaDgxU1RhY0YwWHJwL29yMVRqUGsySVda?=
 =?utf-8?B?aG1rRDlMYUNaMTFQMENKSW9jUFNoamdUUGNvbmNEWlU3bXZZTjQ3a3FyU2h1?=
 =?utf-8?B?NXB0YW9hcWVuNy90dFVrZzdDMkpPNGl3MUJVVE9sQm5VaUo1OEFnZGZWWlpo?=
 =?utf-8?B?MnFCMFI3NkpxbUVibXh6T2U0WGdUTCtLMG5MMjRuTmZMMnJtdEZodFB2bWJy?=
 =?utf-8?B?NWRPQzYxdFQ1bWF3VVRVMGJRbjBSM2dwUzZnWmp0KzY2QmlkZWtMMDNFUXZv?=
 =?utf-8?B?d1Q2VndLRFRPeUdzWWpVOE1BdmxDZHJsd1ErMDFqVHBSNytqdUhMRlJybzlR?=
 =?utf-8?B?WTJlTE9DQkZwS1RBSkNjUURvaC9VaFQ4OUgzb1REZ01uTGVkOVF6dnQrWkd4?=
 =?utf-8?B?Q2hBcHhBZnMyckJXcmo0NzlhbDhwUEllSUZlUFRrQ2NvRFpPdU5sS3hWRXhG?=
 =?utf-8?B?ZEpNN1RBSmVVS2V4djB0ck0wcjdmRVl1UG92Yi9qVGxOZDc2RG04ZGhDekxv?=
 =?utf-8?B?b1dYenBRcEZoeEZSeEZjVnhTS21MUkNFVW01ckpPZlJzaEttUzR0OE44Mklm?=
 =?utf-8?B?RC8zb2Y3NXljWGRBK2lXQkw0d2JBRkxIT1UrUVUxY1JJTkptczgzUHN3RFRu?=
 =?utf-8?B?UDdzR1R4a1A4c3VuNWlQMWErcy9pSjF0UldUSHNJUE5RZXF0TGJkM1R2QjV4?=
 =?utf-8?B?VDRDRzNOVWxLK0ZML3hMalZWdzErNjdoQjgvaTZHWDRWdG5FTzBOT2huRTBM?=
 =?utf-8?B?N21jaXdzZ3FVdEdscnJWcC9mNDBOYlVFdGlteGdPUThXZlpoZGhLK1ZMbHZj?=
 =?utf-8?B?Y05GTUFDeitBYk8rNHNTZzg0Z1o2WTJaV3EyUVBUeEVDdGhlMnNLY3JSUGVZ?=
 =?utf-8?B?WmhGRi9PQzl5NTVGWW85NG5FZU9KY1dBMm90VDNLZmR3MmxHZ05OakpoSEti?=
 =?utf-8?B?c0h0M21IbGFaUkNyYzRMZE9HKzJpbnRTa1l5bWxla2hubDEvMklJdmZzMjNu?=
 =?utf-8?B?UGsyMUpLL2d2QW9qK2haV1ZaMVVkWUJVbHNrdC96RjZYekpacHp6VkFPTHJ1?=
 =?utf-8?Q?e7JsTnDnACfJhzOycqQEQ0jqrmjoAh3xs3fzM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7312.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(13003099007)(8096899003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STBFZmFrYUtIN051TmhETitqQnF3QTFKeXhicTQ5d0p3dCtSckdUM3h4bi9p?=
 =?utf-8?B?dEdBMzVwMDRHQ1RDeEcxODZsaDk5SVo2dm56Wldvd3MwSVd6a3plM0RET1h5?=
 =?utf-8?B?RGJkb0oxRlFNOEh5WVl0Y1VGUkp2SGllc1JPSUYzMTY4M01iUnpVUFg3eHha?=
 =?utf-8?B?SHRKYzNHR28wUy85VklQdSt0QUlUeXNVYW9qYU1oVEdWSXQwMW0vUjIxaUZZ?=
 =?utf-8?B?Z3ZONGFTWFpvVEN6WEhYWFI0bURDOU1qRDNUUGJGQ3FNOUJYSUFzMmhOYUJK?=
 =?utf-8?B?alpOSXpJcERmVzdSZVUwWVNob0dVOFlHa2FIRytOZGcydlJqQzllK3l0eUZo?=
 =?utf-8?B?WkZML3EzRmNVZk1TU2FrZWs5dk80bDRsTTRVamZ3YjRDUkY2SUw2bEpEbEEx?=
 =?utf-8?B?czMvYkZaRlYzd2YzSU4xZGRUNHpCUjkzb3cxWHVxajhONDdaSk1aV3Q1Z1RN?=
 =?utf-8?B?L0R4Rk5XSUs5UnpNbkFmNUtRbTYyY1kyREF0c1NLVHo2OElXNHFGdzRvT09o?=
 =?utf-8?B?TGRFWU9PdEN0bWpXRmt4VDJ2OXArVHJvTEw1anZqaHpvbDQ3VzFrYWd4Um1X?=
 =?utf-8?B?emhVRHdOeE10aHlRUGJ4eWVVNGhkU1FPS1FpZFlWdlZzQjVPZnd5WHNVNXVs?=
 =?utf-8?B?NnhSYnpvUDdNdEZhTWppQ0tSMURBSElqbmREL2x6MUlua29yOVRGdEJGdFpG?=
 =?utf-8?B?UUdOb1NIOTVQb3dmclJuNEtUTm11UWpFTjhzZUtFLzBxNzVobDRGb1FLMkdi?=
 =?utf-8?B?c3hIMlhzcTN0K0xGVyt0dVoxSkRESkVYNUNGMWh4NThqY0VoNTU0ZThSNVJL?=
 =?utf-8?B?Q0xhK21oMVB4N1ZLUkl3N01QNVhLa0pmUVFya2hRTWZIOWI4cG92YitJOVNz?=
 =?utf-8?B?TWRUM0J5NXFOMkVuTzk5aGFxNzBGR3N2S25kS2F1VlNJalJmQkpzNFdjdHY0?=
 =?utf-8?B?Z2VIT2dvbDFuVXFoazc0WTAyYjV6Z1NSSXBrbXdQVWZsYzJLb2pWYUFjeEdj?=
 =?utf-8?B?MFVpV1JkUDVEM0pEbXE0YW50K1ZUQ1gvb1Vva0E0OVBzN3FBeXJaUWZoWXNx?=
 =?utf-8?B?cnpESmlFU21OckhrNFMyQ2Q2dVVKTjJBUFFCRHpubzZPZHdGYnJCRXp4OEJI?=
 =?utf-8?B?TGU3TkZuYjlXSyt2eUxtYnI5R1BRMzNBd0tXc21qRThWRGtxcHl2eTl3VzF4?=
 =?utf-8?B?V2JqdVR3bklpcCs4RG55a1N3SHpwL0ZmbFRjL1dVZTVuUnNkZm5vcVhKMFhD?=
 =?utf-8?B?V0xvNXRCSXdXRXFvcDJ2eEpabUgxYVVwU0x6ankvcGhWT2VMeHpnbnphZm5t?=
 =?utf-8?B?TVhPaGhTVFBncmoxYWZnTG5wMmNNLzF3LzdpS2NEZUUvNDdIVmR6c3JhVm14?=
 =?utf-8?B?WlF4MU04RVRKSTI4N0lFVklDeER4Y0tNcXNGelVJZ2R6bTQ3YzZnZEljeWZD?=
 =?utf-8?B?eFEvNUxSSEViRWQwdk5VL25hbTVxZ000cmJ1eHIyR21RZG5BTWdLNXlrNlkr?=
 =?utf-8?B?enpBS0Y5QzV4TGliY3FlZlo5Q2ludy94aHNLMTdyRjNJenhUL0xqd0plc1dK?=
 =?utf-8?B?Z2dncWsyTkpBVUJudFNTalBYcktudzAwVEZKd2E3dEFQUDUxbUI0cURNT0du?=
 =?utf-8?B?MXVRSHkwRlN1VG84OCszRUV3WHpwTTIzUlQ0eGRxditySlQvK0J4OWlKRnlG?=
 =?utf-8?B?MVU2bW1TRkhtMlpobGoyWlIvUFR3N1BxWVVDckV0VmFQMHdaSmNzYlNVMzJa?=
 =?utf-8?B?S3BtQ1p3U0MwSjZxazQ3SmJiamxjb1EvanFLVGJ1N1o4ZWJWYzNaTnhpWUFs?=
 =?utf-8?B?anVqeWpFdnhISFZsNFRKZCtOTUVrb0FSTDFIZzBjMUord2JzTEt5d1ZqMWh4?=
 =?utf-8?B?cUl3WTQyTjM2QWVYU1RJc3RVZXIzT2FqS1JsN1pLQkVmTkxURmhMZGRsa25v?=
 =?utf-8?B?Ny9vckZ0Q282L1kvcTFqbU1MSm1VTjl2MWFWYmxsK25PSURxT2dYTFNvMmlJ?=
 =?utf-8?B?dElsZkRZR1pLbHhXdEJpa2crd0prTXA4WlQycU9XeGtlcGJOdmo1dGpObFV5?=
 =?utf-8?B?MzliYk9KejFmT0VGWVpwZW5mM0VOWExseFo3NXkrV2dLamZoUnk4STY5dWFm?=
 =?utf-8?B?U1JKZjlIcEl4VnNJMytWVzU4WXBGU21IOUFJS25JdDdDRGxISjJmV3lYNC92?=
 =?utf-8?B?TGc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53049c0e-0cff-4ce8-2e68-08dd8d0de32c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7312.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 02:21:34.5907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0YIkOYKnmAieofPhrbLALLGb5G963/nGedej99hIvwqNlAH7T9h0RRnqh7iZ3QAhwOjkfpOvXnw9YyccBE5gwfkwWL5bA1Nvcl7pTnvD8HM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6977
X-Proofpoint-ORIG-GUID: PqEKRAYZYXU9_nG8xfvdrbFYqv4qs_ma
X-Authority-Analysis: v=2.4 cv=Pd3/hjhd c=1 sm=1 tr=0 ts=681ac3b7 cx=c_pps
 a=IYePPuTyj3qIg1BHBNk0GA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=8rWy6zfcAAAA:8 a=NEAV23lmAAAA:8 a=t7CeM3EgAAAA:8 a=CCqvMlHZI9ExTLhlt_gA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=pGLkceISAAAA:8 a=wvPkM9v7g1_ikmSEda4A:9
 a=5qEubZJ_wRcB4kTn:21 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10
 a=YjdVzJdQTyZRADMV7wFX:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: PqEKRAYZYXU9_nG8xfvdrbFYqv4qs_ma
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDAyMSBTYWx0ZWRfXwz4nF90/+gGI
 +PWdmn/UteryfKzMDgBXAfy/R2Un1c8ojH4ncT1V0ABJ+qKMx/+PtFI+RCNvxNnnf0U5HPC7irZ
 O6k8nh/nfKISmu9oxGDEnVclV19eGcAnIxvtRm3DTaA+WSJRbrl9+7sMbk8QAkHjks3Ey2gGxRX
 L4bAhXjVQqmc58naniGETK1Z7RVZHkaw3fNosGBATUM/cwdxuWVEFdzMgabdvI80a9tFHeuorEL
 2g/SiSzNtYgGEIFEK5BOx7VMYxCVDnvyU/PUFeyptMbS49TdPXDBGQthID7eN/RNsj8/ArAtH3J
 HNBgDVTKzA02CLfdZkyprckQI2z2uKqi9BdyijwR+zREL/HWUB9WlUvNM6b/L7Ojy/Cw3ddb6kp
 KCCJNzF5MQkcBLpdeHc7HQE/DKNnUnThppp/FMHGtUUoIj5u897GRxfp3ylslldBQeCQ8uhe
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_01,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 impostorscore=0 clxscore=1011 mlxlogscore=999 phishscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2505070021
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

--------------OcLJvCuy75ev0Zy6H5ov3Xhg
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 5/5/25 21:56, David Marchand wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> Hello,
>
> On Wed, Apr 30, 2025 at 7:21 AM Changqing Li<changqing.li@windriver.com>  wrote:
>> I'm new to this project, and have no clue about the failure,  could experts at this project provide
>>
>> some help about the following failure?
>>
>> + sudo babeltrace /home/runner/work/dpdk/dpdk/build/app/test/suites/rte-2025-04-30-AM-02-25-21
>>
>> Error: at line 2819: token "time_t": syntax error, unexpected IDENTIFIER
>> Error: Error creating AST
> I think this time_t type you added is not described in CTF.
> Have a look at 2114521cff91 ("trace: fix size_t field emitter").
>
> Copying the trace framework maintainers who will have a better idea.

Thanks David.

Copy the fail link here for easy access:

Test-Status: FAILURE
http://patchwork.dpdk.org/patch/153190/

_github build: failed_
Build URL:https://github.com/ovsrobot/dpdk/actions/runs/14744930390

Regards

Changqing

>
>
> --
> David Marchand
>
--------------OcLJvCuy75ev0Zy6H5ov3Xhg
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#cceed0">
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 5/5/25 21:56, David Marchand wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CAJFAV8zk=gzCagoU7c4=dsXcEFnLjiqrWxwTWANa-U77Uj=Taw@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">CAUTION: This email comes from a non Wind River email account!
Do not click links or open attachments unless you recognize the sender and know the content is safe.

Hello,

On Wed, Apr 30, 2025 at 7:21 AM Changqing Li <a class="moz-txt-link-rfc2396E" href="mailto:changqing.li@windriver.com">&lt;changqing.li@windriver.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">I'm new to this project, and have no clue about the failure,  could experts at this project provide

some help about the following failure?

+ sudo babeltrace /home/runner/work/dpdk/dpdk/build/app/test/suites/rte-2025-04-30-AM-02-25-21

Error: at line 2819: token &quot;time_t&quot;: syntax error, unexpected IDENTIFIER
Error: Error creating AST
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I think this time_t type you added is not described in CTF.
Have a look at 2114521cff91 (&quot;trace: fix size_t field emitter&quot;).

Copying the trace framework maintainers who will have a better idea.</pre>
    </blockquote>
    <p>Thanks David. <br>
    </p>
    <p>Copy the fail link here for easy access:<br>
    </p>
    <pre class="moz-quote-pre" wrap="">Test-Status: FAILURE
<a class="moz-txt-link-freetext" href="http://patchwork.dpdk.org/patch/153190/">http://patchwork.dpdk.org/patch/153190/</a>

<span class="moz-txt-underscore"><span class="moz-txt-tag">_</span>github build: failed<span class="moz-txt-tag">_</span></span>
Build URL: <a class="moz-txt-link-freetext" href="https://github.com/ovsrobot/dpdk/actions/runs/14744930390">https://github.com/ovsrobot/dpdk/actions/runs/14744930390</a>

</pre>
    <p></p>
    <p>Regards</p>
    <p>Changqing<br>
    </p>
    <blockquote type="cite" cite="mid:CAJFAV8zk=gzCagoU7c4=dsXcEFnLjiqrWxwTWANa-U77Uj=Taw@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">


--
David Marchand

</pre>
    </blockquote>
  </body>
</html>

--------------OcLJvCuy75ev0Zy6H5ov3Xhg--
