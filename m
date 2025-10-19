Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE702CCD184
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Oct 2025 08:37:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A3B4B4042F;
	Sun, 19 Oct 2025 10:37:40 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 0D9A14013F
 for <dev@dpdk.org>; Sun, 19 Oct 2025 10:37:38 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59J7rPAX030788;
 Sun, 19 Oct 2025 01:37:38 -0700
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11022141.outbound.protection.outlook.com [52.101.53.141])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49uyge2h2k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 19 Oct 2025 01:37:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HSps3czo8hxn0CEg85MXqVNzvN5+dRuDsRw35GTbDe3MpumsjwYthaRhW0IMpur0b1E9N8LT/xYwqCLLH74iaktb/1Di/zl/P5SKxWLCtIuuzxtsyoS6Y3GgV3VdDadHjQk5hCU2lS66OPb7QBiSWO/7mWTe1ayhfn6GEPdA94oVOynphvNW+Ltzc1mWgKCZgzWPdLt5gAbA3f9Ijc5QTiOux5+UYow3w344rwkjGZ/W8dfbDER+fJYuOPycFzIdAGkV+Z0sFZ9i2n65QOvt3DQ0R7y5D/O1y4ViBUHUFMUG3IMkCysvJZNzySSpS/jV4St+tr4MZuLeDft+jGQDAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bAL2tCFz4UW86xQFKSUeZr+1F1cYCxRrSzS2vjGPEkM=;
 b=b6xL+FLskSg83uZEMxpSFBKwfRylVb3CiQIl3TnE6rItTT+ZqKqB/mz63AsBELE723teB6jpP9wmjq2yYH++TviQrHdzuojUGmT01/ZRsLQph8C7VDDSXrC/dNyhV7uc3vF3KhnKJLF4G2bl8gkVTQw2SdNSY9Mqn4L9UTA3xK+B15M/kA4S1Ho6fy0k4jkuhwAwKXWz0+mJavET+pwCELeW2n7oCd45SKCOW8RsVhAm7bZ2vWij4FgwN9KLIKocOSnW60o1YOmPlX+xTNg6Dd4lc3ZPFmX7Oe8evj0+dObJyDl1vgvEffFysprzu+3N44l1nTx80KXMVrkcDO8ktA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAL2tCFz4UW86xQFKSUeZr+1F1cYCxRrSzS2vjGPEkM=;
 b=MVIHGb2qjoXefYRq674Lsahr33Mw0YU72xNvqrVIsnVI5D6rxn8SehSLKgCBt28VN6tmkrdlFX6lhVe09ChEPNnUzb+78XG+MtAs95ggWhPtcnRrrMH3XzLYY2dqBpnLh1boC4+/DNhuFzKtiMcAaB/39AX9V1pLaCwbXiJALQc=
Received: from SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
 (2603:10b6:a0f:fc02::f4b) by PH0PR18MB5144.namprd18.prod.outlook.com
 (2603:10b6:510:16f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Sun, 19 Oct
 2025 08:37:34 +0000
Received: from SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
 ([fe80::2a2c:7ed8:2041:544b]) by SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
 ([fe80::2a2c:7ed8:2041:544b%5]) with mapi id 15.20.9228.014; Sun, 19 Oct 2025
 08:37:34 +0000
From: Vamsi Krishna Attunuru <vattunuru@marvell.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: "dev@dpdk.org" <dev@dpdk.org>, "fengchengwen@huawei.com"
 <fengchengwen@huawei.com>, "bruce.richardson@intel.com"
 <bruce.richardson@intel.com>, "anatoly.burakov@intel.com"
 <anatoly.burakov@intel.com>,
 "kevin.laatz@intel.com" <kevin.laatz@intel.com>,
 Jerin Jacob <jerinj@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH v4 1/1] lib/dma: add control-plane APIs for
 inter-domain DMA transfers
Thread-Topic: [EXTERNAL] Re: [PATCH v4 1/1] lib/dma: add control-plane APIs
 for inter-domain DMA transfers
Thread-Index: AQHcP29T6oCwn4C/jEGZqX8lPtkz7rTJITwAgAAF1nA=
Date: Sun, 19 Oct 2025 08:37:33 +0000
Message-ID: <SJ4PPFEA6F74CA2C8C8EAE365AE5505773DA6F4A@SJ4PPFEA6F74CA2.namprd18.prod.outlook.com>
References: <20251017122610.3126992-1-vattunuru@marvell.com>
 <20251017140652.3186205-1-vattunuru@marvell.com> <3166338.vzjCzTo3RI@thomas>
In-Reply-To: <3166338.vzjCzTo3RI@thomas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ4PPFEA6F74CA2:EE_|PH0PR18MB5144:EE_
x-ms-office365-filtering-correlation-id: d50d041f-4e15-4d62-4682-08de0eeac009
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?clJwUXYzM2kxeVhxRW9DU3p2YnppYkZtczlFaUU5NXJ0dFVGWVZaRkNKTkdo?=
 =?utf-8?B?TTZ3NWFpR2FKQ25vSVRESTZheTVOSzF5OGk3czRmMWs1eUU1MWMwOHMyYVZ5?=
 =?utf-8?B?VkwyQ2lmSFZPdkVYVlo3Q2draGFMakEvYXJ1Z3I3YzVEbmxEaUxCbW9Fejk3?=
 =?utf-8?B?Q1JDeUNyeDVjYVY5dXp1K2crdVhGam14K2lCRVh6NzVNUlJwelRiLy82YjAy?=
 =?utf-8?B?dnFVbk5RN3REbjJ3QUg1aVgrZ2RDM0dPVlhPRGhkTHROdldZdFl2MmFHU0c1?=
 =?utf-8?B?alcvM0I3bmdMTDBlMDFsejlVSG1SdFVCL2wyWjh1WlZuZnk5YTJPVFFGSDFv?=
 =?utf-8?B?WUk1K1V4OENxQXhCSitUOE1FTENlREhyL0FDR0MzVGRFNFhUUzhwTVIvaXJt?=
 =?utf-8?B?VXhlbmtxTjlaNW1uclY4OGE2WnRjY3pzVW8xdGNMc25VNjRmT2xtblFqS2U2?=
 =?utf-8?B?TDZaaFNvL1Rzb1VsUzUwVXRkTXBDN3dLU2R0V0tDcFdBdjZpL0NGV0Q0Nkhz?=
 =?utf-8?B?VHZZbzZYaGhsa0ZnQ3JtK2tGWGVzbHV4bUtGSU9CSnFwM2E1c1ErbXFuTFl1?=
 =?utf-8?B?WCtjVEdPV3U0UmdKdlVEQXB3SCtadFc3ZndRQUhjMXVzRE1UMkZxbSsyZWJm?=
 =?utf-8?B?L1N6dnlBSFJMQ2J3RWw0NE96ckFYRFZMcGhxS0E5Q1dhZHFUamlYbUhCUnRw?=
 =?utf-8?B?Y3FZbGxNZE1UL2xvWlFVYWZGR3o0dlZPNEtZTndlcy9xZnNsczN4RjJMVjIr?=
 =?utf-8?B?QmkrclNIRU1iRVphUlJIbll0QTIxa0xZbncxc21oVzZtWkFGQVdvdUcwOXVV?=
 =?utf-8?B?V1M4OENoOTVVNmxiVmFYN1h6WGo3SzU5YU9RdjNXMjRWRkVIdXlGS1pPSTY4?=
 =?utf-8?B?YkQwV0VPSmRyODB5cDYxVnZMSnR0bGs0d0RTTnZWejJXZDNZQ0FvMUFBNDlO?=
 =?utf-8?B?QnVteU1pWktuMC8rV3BiWDdaS1ZFa2ErdG9lcC82WHBwNnU3T0dtVzlsRDlE?=
 =?utf-8?B?aFgxdUx0TnJXTFprQlRpVjQrMnAyZzNvU2krbC9YbkxwVTFmN2x3Sm5zeDhp?=
 =?utf-8?B?Q2M5L2gzTGhIL201Q0pSSXZGbXpNbGU3MEIyWnBOM0VBRmJPdmFDZGk2MmJa?=
 =?utf-8?B?SmU0ZzhYbE1wQ0paa0ZJdE9wdG5UcmFyODZLVEVkbkc4OTZXUG54WDlVaWxu?=
 =?utf-8?B?YjBKWW9idVlzV1IvVHd4TnV3djRTRkU0L2kzMmFFVWxlL2RmUytKay92eXI0?=
 =?utf-8?B?bThoMGlYbTJBZXNxcDRVdVQwK1FXMXpFR3RMdE96blpYck1qT29yNzhBRXlG?=
 =?utf-8?B?NmsvQnBkRVFZRDZvTzlyQnZmS1dEYnppTmxlM1FHdmZpSzhJTmNpZXNtYzRB?=
 =?utf-8?B?L1pnbGxSQTh6aVk5YVNPSENZSThwcjJhTCtsK0JuNXBIYVZrM1c0L2VYWkZo?=
 =?utf-8?B?ZlI3MXhNOGFVMGMxeHdSZmJRMUUvWENHbVFlNWY3ZEpDUWNsWmhxZ0s2TjNG?=
 =?utf-8?B?eG5pS3lkczJ3aVg5RnRLTCsyUGpUbnhaV1J2cGYwSElnSjgxbkNzYzcwL2ZG?=
 =?utf-8?B?Qm8zbjlKd0xyb1hBZDk5SWpxaUlvN3lmTTdLd0c4REQySlord0hYdjdKOUpl?=
 =?utf-8?B?Z0FjLzBsTHJOTnBoc0Y3MDZROVFoWUxsa0pjWkNQbTFLSWxYRVFOZ0MvRTFR?=
 =?utf-8?B?RnZYOTFhSXc5ZVcwNVVSOEkrZHpDVVZFTXpQT2QvVms4SmZJR0JNVGduYWZ5?=
 =?utf-8?B?TDJwcXJUQkVVQmZnYVV6S1hOQTR5dU1DSUlEREVvS0lPTlhzOG5IY1hBUG4z?=
 =?utf-8?B?c0VTYjhZMnBUUHVBYTNDcFFTMjRvV0h4UnBuMU9VWncwR1o3MDhDTVRwRFpi?=
 =?utf-8?B?OTFaKzdLR0tVOFJCb1oyMnFRMGk4M2ZZcW85dW1sMzM4L3NFSGhTM1Vsa1V5?=
 =?utf-8?B?MTBvWUJrd1pWUnIweDdJSzFSZit4L1ZncGM3TU5udlkxWDdMNno4MzMwc1JB?=
 =?utf-8?B?OXpWMGxoVUpDaXRzL3Z5Q2ZuQXVJWFpRMWhXU3Y2ZkE1UE5JRS8xRVIwd3hG?=
 =?utf-8?Q?x/prNg?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ4PPFEA6F74CA2.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkJNaGNucnFTbk1wVmhyTCtkNHovMGFLS3pBUXljSStKaVFtcHFUL3hxVGww?=
 =?utf-8?B?T0tIZjNsS0NWbVlCc2lZV2JsQ1lWejQwc1pwajQ0ZVROYUxicXBqWUJXaFFO?=
 =?utf-8?B?NEh4QTlWb1A5RTFoU1pmLzhQZURvSVZoWm9qZVZBam01RTRRdnhKR0UzTlhu?=
 =?utf-8?B?SllEZmRjaC9VUWU1aHJ6cVZWS2orajlGVFdyRnVwdnNXdXRFZC91VTRNcHJT?=
 =?utf-8?B?V0Vkb1lKTE95d3B3SGNxYzJRRG00SUQyNkIySTFoZFFlZUxCUUxlTXlHcTdM?=
 =?utf-8?B?UURCUGJRMlU1ekQ5WjlRYzJ6TVJNZkNZRTEvZmNnVzAwd2pTV3dQOGxld0dI?=
 =?utf-8?B?N2ZibkFSbHVOT0NoVldvMzhPbTJSYklyZ3djQmNRUGtHUU92S3BqSzNHQUJ5?=
 =?utf-8?B?UmFhYlBNSTIxcVljSXQ3QTN3Ync4Q3h5MFk0VzBRY0Qxbk9nVHN1TU5BTE1q?=
 =?utf-8?B?WWFJbDRpOTc1Q3NxT3RNTVdRN1NMWS92ZVZNRlRRb1d4M3ZWV2dncit6YUhK?=
 =?utf-8?B?VnBMUDNuellXeVZxQjhuTlhybFFWSnpQMjN3VnJ2eG1OZmRYUnNJZWVMM0FE?=
 =?utf-8?B?SU5lejlOR01VRllaeldVMFh3bjRtVXh6YzhORFVCSlFzSndtSGZ4UUN6Ym1Y?=
 =?utf-8?B?cVc3SjBWNS96WTBIQ2JaV1JrU1QwNFBQUHplQ0w3OURJSEJKL29aNnAxZ2E4?=
 =?utf-8?B?TnpNd2ZZOHdIK0tkdlVyck00WUNsSmRzNnZCY0pVTnpkWlBQaGxxNW9FcWV4?=
 =?utf-8?B?OXNkZlh1Qk5OSkhTQzRHbHNLK2NRK1FlUEhmak1vR0pEbHRPalFZalV3Tktm?=
 =?utf-8?B?aGt6SzBSYlVQeTZqSUhsYmorbHZMcGxTR2U2TlZQd3dCb2hXd2FSUFVhM2dX?=
 =?utf-8?B?ZkZrbVlRajZlMG5iUnRsNVRIeDZTN09XTkhVYmtOSG50a1pSVElWZUg0b2hN?=
 =?utf-8?B?bTRrOHpEczR0enNiUk1PWmV4K2Z2SmN6SnN1S3BNMnV4Vi9kc2FDN1UxbGlC?=
 =?utf-8?B?bWkyK01jNnBjR3pZbktZYlNKRkN3MzNmUDV0ZTZsS096bGM5dWtIS3V5Mjlo?=
 =?utf-8?B?aGdiOXJnRXFqOVdUNkhEeHVYQmJUeThsdWNNU1Q3b0JLN2NuMmtVbnRYZ21n?=
 =?utf-8?B?bEE1cU1COHd0SE4wcWVCZXhxc2ljdVREd0Iyc3VaNXFFUXA0aTE1b0p4Z1V4?=
 =?utf-8?B?OHdSVm55ZE9hTUxsMGZ3SDRxY3hCZ3I5SkxWM05nUHBBVnRrK2VyR01Ga1V3?=
 =?utf-8?B?dTFoelo4ZDE0MTBsai9OdDVOWnFYcS85MURsclM0c1Fnc0lnSS9xYlhuVmRY?=
 =?utf-8?B?V3IydjdNbUVDbXBhYjRPeEpyKzM4T053TE5Zb1pPckhqNEZkTFN1L01GOHpp?=
 =?utf-8?B?eUlKSDVYSHZMNTJRdTdTL3djT2QyN0UyVXo0cUlYR0VOVXYxSUhFZ0ttalRL?=
 =?utf-8?B?Sm5DZHhIK3l6SUgrNlhjZFFLV2dsaVhhTmJxVFlXdkpQWUkrMW9FUUIzYWJT?=
 =?utf-8?B?KzcxRXdhU0RyVFJZSFgwUFpBOXY3MmNBYlRobVcrMTJ0MFR4UFRCR21mTXh3?=
 =?utf-8?B?WlBNZGt6eE54Y2JTcjd1VXpMcmdndFVmTXlWMVBSVXRPdTRScjdlalowNVFy?=
 =?utf-8?B?RVhyRHZuc2tRY0FNaGhwY3J3MFQxK3NjL3Y1citlWmt5WkhQWUhDM0NWR0d4?=
 =?utf-8?B?VVovcTE3UWFuMHFPQjlHMnRqMHA0cWR2Z09nWFd3S2UvM09zRDk1aDVUNW5U?=
 =?utf-8?B?U20rMWI2MXZTbVhQemlYbVdQSElPOVQxWUR2Sk5YcmU3aHNKNTRiRHQwNUp2?=
 =?utf-8?B?U2RLdW1RVHFOQkN1ZVUvUm40RkhESE50YWZ4amFwS2YyUzdlTzhsbFJwcDdK?=
 =?utf-8?B?T1NucTV0REdxZWJwcDRtOHMvR2dxeklLeDViOUZPdGpuWXA5OVVqMHl1SXYx?=
 =?utf-8?B?ZG84WkJ5YUdLSUJsMEdKcWE2eFF6c0RPa29PeVFnQU1XYnZuQkZvd09vbmR0?=
 =?utf-8?B?eWtGd21rcVRjVTRHbGppeDZGNWlXelcwNVE2NzVRaWUyaTkxZlF6WWFJVHFw?=
 =?utf-8?B?aVB6NFBhaDlqajAwOUllTG81NHlNclpXSHY0dXdXQ2FvL2MxYjNySmo5TGpX?=
 =?utf-8?Q?t124ZtDJsOyD8cDIZ9zjCca+U?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d50d041f-4e15-4d62-4682-08de0eeac009
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2025 08:37:33.9842 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S8Zju/aMePxrnsaLGSazPENPUoaIF7sdMtCVJ/7cui72xFFQ6qeLhYMMsHgmYhVdU2lxA6WHAtwqDt8ECUZSfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB5144
X-Proofpoint-ORIG-GUID: 0_XES_j1o8PRAQEfk3n8ZT6X5BGli2To
X-Authority-Analysis: v=2.4 cv=G+oR0tk5 c=1 sm=1 tr=0 ts=68f4a351 cx=c_pps
 a=wck1Q1pII696GML7qL2HzQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=M5GUcnROAAAA:8 a=i0EeH86SAAAA:8 a=Z4VYA7cdH_5jIJAvaDMA:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE3MDE4MSBTYWx0ZWRfXwASXN1n3rtw1
 YYZXHR3jDJkRjPs0zV9Nxqcp4F+R4SAOOijbTn7sm9NBqeLV4i9fB6uY+2DrmJit2BnsEsO7GuJ
 bAUA5vI/DNyPj7Yr1fmyOcd3+DLq5XBlZRGCw62lkL4ohsG5F9LMT0HNy/tiEmQpZqxhvo1Z/lt
 2OZetiDSFhEbxY7vPIVX8Of6AtR5K7Jn4lHNiHi0cgN++xXTXi+vAPqTnDl7d65ctD878oUA4po
 Bj+pj/AovGBYGAeRKlBBNwvVDexKJhdoIqFYFplqcOjt5AfeGqfz90pVCA8QujO8KlPupfeDZf4
 1yiwu2DFNknmyNn587gkTUEFUqax4Mt5N1O+4Eo2DyVaL79qd080+5WCsiHMmzx6uwLEIX4AlO0
 nMx385WIZ8ML14lSwlNxM251ZJ7GuQ==
X-Proofpoint-GUID: 0_XES_j1o8PRAQEfk3n8ZT6X5BGli2To
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-19_03,2025-10-13_01,2025-03-28_01
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

DQo+WmpRY21RUllGcGZwdEJhbm5lckVuZA0KPjE3LzEwLzIwMjUgMTY6MDYsIFZhbXNpIEtyaXNo
bmE6DQo+PiBGcm9tOiBWYW1zaSBBdHR1bnVydSA8dmF0dHVudXJ1QG1hcnZlbGwuY29tPg0KPj4N
Cj4+IFNlY3VyZSBhbmQgY29udHJvbGxlZCBpbnRlci1kb21haW4gRE1BIHRyYW5zZmVycyByZXF1
aXJlIGRlZGljYXRlZA0KPj4gY29udHJvbC1wbGFuZSBBUElzIHRvIGNyZWF0ZSBhbmQgbWFuYWdl
IGFjY2VzcyBncm91cHMuDQo+Pg0KPj4gRE1BIGRldmljZXMgdXNlZCBmb3IgaW50ZXItcHJvY2Vz
cyBkYXRhIHRyYW5zZmVyIGNhbiBiZSBjYXRlZ29yaXplZCBhcw0KPj4gZm9sbG93czoNCj4+DQo+
PiBDbGFzcyBBOiBCb3RoIGVuZHBvaW50cyByZXF1aXJlIGEgRE1BIGRldmljZSBmb3IgZGF0YSB0
cmFuc2ZlciAoZS5nLiwNCj4+IE1hcnZlbGwgRE1BIGRldmljZXMpLg0KPj4gQ2xhc3MgQjogT25s
eSBvbmUgZW5kcG9pbnQgcmVxdWlyZXMgYSBETUEgZGV2aWNlOyB0aGUgb3RoZXIgZG9lcyBub3Qu
DQo+PiBDbGFzcyBDOiBPdGhlciBkZXZpY2UgdHlwZXMgbm90IGN1cnJlbnRseSBjbGFzc2lmaWVk
Lg0KPj4NCj4+IFByb3ZpZGluZyBhIHVuaWZpZWQgQVBJIGZvciBhbGwgdGhlc2UgY2F0ZWdvcmll
cyBpcyBjb21wbGV4LCBhcyBMaW51eA0KPj4gYW5kIG90aGVyIG9wZXJhdGluZyBzeXN0ZW1zIGRv
IG5vdCBvZmZlciBuYXRpdmUgY29udHJvbC1wbGFuZSBBUElzIGZvcg0KPj4gdGhpcyBwdXJwb3Nl
LiBUaGVyZWZvcmUsIERQREsgY2FuIGltcGxlbWVudCBpdHMgb3duIGNvbnRyb2wtcGxhbmUNCj4+
IG1lY2hhbmlzbXMgdG8gc3VwcG9ydCBDbGFzcyBBLCBCLCBhbmQgQyBkZXZpY2VzLg0KPj4NCj4+
IFRoaXMgY29tbWl0IGludHJvZHVjZXMgdGhlIG5lY2Vzc2FyeSBBUElzIGZvciBDbGFzcyBBIERN
QSBkZXZpY2VzLg0KPj4gRGV2aWNlcyBjYW4gY3JlYXRlIG9yIGpvaW4gYWNjZXNzIGdyb3VwcyB1
c2luZyB0b2tlbi1iYXNlZA0KPj4gYXV0aGVudGljYXRpb24sIGVuc3VyaW5nIHRoYXQgb25seSBh
dXRob3JpemVkIGRldmljZXMgd2l0aGluIHRoZSBzYW1lDQo+PiBncm91cCBjYW4gcGVyZm9ybSBE
TUEgdHJhbnNmZXJzIGFjcm9zcyBwcm9jZXNzZXMgb3IgT1MgZG9tYWlucy4NCj4+DQo+PiBBUEkg
VXNhZ2UgRmxvdzoNCj4+DQo+PiBQcm9jZXNzIDEgKEdyb3VwIENyZWF0b3IpOg0KPj4gSW52b2tl
cyBydGVfZG1hX2FjY2Vzc19wYWlyX2dyb3VwX2NyZWF0ZSgpIHRvIGVzdGFibGlzaCBhIG5ldyBh
Y2Nlc3MNCj4+IHBhaXIgZ3JvdXAsIHRoZW4gc2hhcmVzIHRoZSBncm91cF9pZCBhbmQgdG9rZW4g
d2l0aCBQcm9jZXNzIDIgdmlhIElQQy4NCj4+DQo+PiBQcm9jZXNzIDIgKEdyb3VwIEpvaW5lcik6
DQo+PiBSZWNlaXZlcyB0aGUgZ3JvdXBfaWQgYW5kIHRva2VuIGZyb20gUHJvY2VzcyAxIGFuZCBj
YWxscw0KPj4gcnRlX2RtYV9hY2Nlc3NfcGFpcl9ncm91cF9qb2luKCkgdG8gam9pbiB0aGUgZ3Jv
dXAuDQo+Pg0KPj4gQm90aCBQcm9jZXNzZXM6DQo+PiBVc2UgcnRlX2RtYV9hY2Nlc3NfcGFpcl9n
cm91cF9oYW5kbGVyX2dldCgpIHRvIG9idGFpbiBoYW5kbGVyDQo+PiBpbmZvcm1hdGlvbiBmb3Ig
ZG9tYWlucyBpbiB0aGUgZ3JvdXAuDQo+PiBQZXJmb3JtIERNQSB0cmFuc2ZlcnMgYXMgcmVxdWly
ZWQuDQo+Pg0KPj4gUHJvY2VzcyAyICh3aGVuIGZpbmlzaGVkKToNCj4+IENhbGxzIHJ0ZV9kbWFf
YWNjZXNzX3BhaXJfZ3JvdXBfbGVhdmUoKSB0byBleGl0IHRoZSBncm91cC4NCj4+DQo+PiBQcm9j
ZXNzIDE6DQo+PiBNb25pdG9ycyBmb3IgZ3JvdXAgdXBkYXRlcyBhbmQgY29uZmlybXMgZ3JvdXAg
bWVtYmVyc2hpcCBhcyBuZWVkZWQuDQo+Pg0KPj4gRGVwZW5kcy1vbjogcGF0Y2gtMzYzODYgKGxp
Yi9kbWE6IGludHJvZHVjZSBpbnRlci1wcm9jZXNzIGFuZCBpbnRlci1PUw0KPj4gRE1BKQ0KPj4N
Cj4+IFNpZ25lZC1vZmYtYnk6IFZhbXNpIEF0dHVudXJ1IDx2YXR0dW51cnVAbWFydmVsbC5jb20+
DQo+PiBBY2tlZC1ieTogQ2hlbmd3ZW4gRmVuZyA8ZmVuZ2NoZW5nd2VuQGh1YXdlaS5jb20+DQo+
DQo+QWRkZWQgZXhwZXJpbWVudGFsIHN0YXR1cywgcmVsZWFzZSBub3RlcywgY2xlYW5lZCBkb2Mg
YW5kIGxvZ3MuDQo+SXQgZG9lc24ndCBsb29rIHJlYWR5IGJ1dCBJJ3ZlIGFwcGxpZWQgaXQgYmVj
YXVzZSBDaGVuZ3dlbiBGZW5nIGFja2VkIGl0Lg0KPg0KPkknbSBub3Qgc3VyZSBhYm91dCBoYXZp
bmcgZGlmZmVyZW50IEFQSSBmdW5jdGlvbnMgZm9yIGxlYXZlIGFuZCBkZXN0cm95Lg0KPkkgdGhp
bmsgdGhlIGxhc3QgbGVhdmluZyBzaG91bGQgYXV0b21hdGljYWxseSBjYWxsIHRoZSBkZXN0cm95
IGRyaXZlciBmdW5jdGlvbi4NCj4NCg0KVGhhbmtzIFRob21hcy4gVGhlIGxlYXZlIGFuZCBkZXN0
cm95IG9wZXJhdGlvbnMgYXJlIGludm9rZWQgZnJvbSBkaWZmZXJlbnQgY29udGV4dHMuDQpHcm91
cCBqb2luZXJzIGNhbGwgbGVhdmUgdG8gZXhpdCB0aGUgZ3JvdXAsIHdoZXJlYXMgZ3JvdXAgY3Jl
YXRvciBjYWxscyBkZXN0cm95IHRvDQp0ZXJtaW5hdGUgdGhlIGdyb3VwIGFmdGVyIGFsbCBtZW1i
ZXJzIGhhdmUgbGVmdC4NCg==
