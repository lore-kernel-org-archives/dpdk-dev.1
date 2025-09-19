Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1483CCAC5A5
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 05:09:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3A78402B7;
	Fri, 19 Sep 2025 07:09:05 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id EA1DF40289
 for <dev@dpdk.org>; Fri, 19 Sep 2025 07:09:03 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IEOXaq019733;
 Thu, 18 Sep 2025 22:09:03 -0700
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020081.outbound.protection.outlook.com [52.101.46.81])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 498ktj9rjt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Sep 2025 22:09:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cXNvHIUat+4QtqQvnkOx1KtAqWlECG5EVLrONPUoi9rqQFtcoUYFq65ytOcSeRHnmavg2NpNFlCaUktdRxoFRKCI5PRQw90VHpIaSKw8NFLBxm66kYlQl2Q9ttpRqghs0v8N/XhNemBr6O9LXuTx5kcg6DBb/VrxGkQVNF9ISpm2Wkb9Sxp0lBo0Nged8Gs2nV5hDh2dpu4HyZbHDApyloN/2c8jSVYD5wVi+vCgHTgO1ThAsfI9SMrf0OG0L7MVQuc6vLZWfonN8Ih/C6MROON4G3XW0pYa6z545UkXAecVC9PndqA6w5rQ/Kg12Ru5zFCRAlOD1tKnp8DBzCWvHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5+Hm2Kmz4I/Vih5/C+Hr1yBPmy58okhk9Z1WtwC9vg=;
 b=hACEYkRzf1c8u6yL9Nd8tSeRlrWo39ItLXcZwIHEXHkev4D6Fobsrh9LSALETI1XC9aGeMn16jUam+6o0gxrrEXUnjTI+IVtsw1RQ+sUuuHzx1dgVLC6TkKsWcfaUIK45ZZvr7DM321TLVL99ehDGQQzACHRvfKC5YmkcktAMXeAEpvnoG3AWVK/Ul6j1mbpmJ2c/ueXjJTWF8CQakhjTISLECljcpbdKh7JLsuM0h47iR6QDl+gYt+jZ5ZS7yLnd7/FMJKU/0dIAuFzlwOylTKvX04e3AeE+vFBq2DeNeVH2WXoB+sdz18vFH4DkEQh1CceMjEnKmmOell7hqtdbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5+Hm2Kmz4I/Vih5/C+Hr1yBPmy58okhk9Z1WtwC9vg=;
 b=eH6LtfgB2/0P/NOk05LmVQQ8gZ6QIx3YA6g8f4jId3Dc7A1OuOKiKZfSrjo/o89h5CR2QF8GoJnxVB06MfLv2qlFLFmY/keFI0zQRf/MKFmSsYWKCfhF8fHUvNfxL7S0AYuV0BENTg4xk6TNAG206IS8iPpA5fDXjlGaFbgtoOo=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 PH0PR18MB5071.namprd18.prod.outlook.com (2603:10b6:510:16b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 19 Sep
 2025 05:08:58 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%2]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 05:08:58 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Sameer Vaze <svaze@qti.qualcomm.com>, Sunila Sahu <ssahu@marvell.com>, Fan
 Zhang <fanzhang.oss@gmail.com>, Ashish Gupta <ashishg@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH] app/compress-perf: support dictionary files
Thread-Topic: [EXTERNAL] [PATCH] app/compress-perf: support dictionary files
Thread-Index: AQHb0TUsyVBQ3cr3r0uK/R8h31ucUrPrq/gAgAeQrQCAFL6XkICSJcuAgACCXNA=
Date: Fri, 19 Sep 2025 05:08:57 +0000
Message-ID: <CO6PR18MB4484973EF4D64751A206D8BED811A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250530210956.1207580-1-svaze@qti.qualcomm.com>
 <20250604164134.776009-1-svaze@qti.qualcomm.com>
 <CO6PR18MB4484330DB3461425B5FD4AA7D873A@CO6PR18MB4484.namprd18.prod.outlook.com>
 <SJ2PR02MB9795F48C88D139220AF7B80A8916A@SJ2PR02MB9795.namprd02.prod.outlook.com>
In-Reply-To: <SJ2PR02MB9795F48C88D139220AF7B80A8916A@SJ2PR02MB9795.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|PH0PR18MB5071:EE_
x-ms-office365-filtering-correlation-id: 4d855e82-b8c4-4cba-a3d3-08ddf73aa38e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?VEtiMTRTZ2kwWExuRUVmMUxxWVBZSmNLbXJFSWVjU21saVBaVkRFQUtNRlhz?=
 =?utf-8?B?L1pGYkc4Zmtmb1pqbXdBeUZrSzZJNktKZ1FFbkVJc0oyNkZnUEc0OEVYMnYr?=
 =?utf-8?B?MHY3Sldqa1ZjNXY4SlpLNFJ5dUxSZmIwSWFiSmtQdzRLd1RGS1FKNjRTS2ZS?=
 =?utf-8?B?eTJDWjIzTUJTTEpadjZ5NnBoQ3JkcjlHRFNrOVdsbzFsS3ZVcjZiTkJRSE1K?=
 =?utf-8?B?WURXblp3b29JSWR2SVFhZGdOeWFUZHRTeVY3V2gzNGVPQnppNFZnd1UrNmhP?=
 =?utf-8?B?QUdkOWN2T1ZkMWV3Mm5wSGFEOE1CbGhQN0RWamJ6NDEwTnplZlZVRGVSMVNk?=
 =?utf-8?B?WDFhdUg2TzNYcmV5OE9RVHR1RVhBVmdZRWRVeUd2dEIwMTZZN2Z2STN3TWIv?=
 =?utf-8?B?NkRlbkVMeXkxWnRyU2s5d0EzOFVEcnNseHoxV2oyYnYzeEpOVzJJa1ZQaW9O?=
 =?utf-8?B?NlFKQ08reGN0bXQvZWdwL2RtUk5QNDJnL0VpcmdBZys5czJpdjhVV0UyblJL?=
 =?utf-8?B?WWUwY1BmNWxnK3RLK0JmYzRmaXRMdzYwcEhzT2F6NVFNZU8zeGI0cHRxZVFT?=
 =?utf-8?B?eElLaTFwOU4rOXRYSERmVnUyYlUwZGlWWENMRDNHKzIvTnl3bXN0c2R3WGhH?=
 =?utf-8?B?ME9yZ0VxK2VRNktBYmJOWXk0NC9qSkJZRlhTMlVDNDRNMjFSNGRnY3pEUzA3?=
 =?utf-8?B?QkE4L2JhVFVwMXN2b1F4QmpoR2crV1c1aEhjeElGNjFMUFB0SDVwWThSZ3lW?=
 =?utf-8?B?c0cyTnkzK1FNRnYrd3k5Uk1mYW5pSHZUQmRmUzk4YmZjb3dMTkNpT3p0S2Jt?=
 =?utf-8?B?YVNOV3h0OFBqMURKVmkybkFTUmVYcjFhN1huSzZDNmNZMXFjSE9yQUI2MWRw?=
 =?utf-8?B?MWk3OHJocGRJQUZJTDRVaXQ3eUdveUZpNFVwbjltQlVTSHlaU3BnMWFRZkcv?=
 =?utf-8?B?VW1nc2tBTmFCcWQ0U3NVOERLandDN3JRU3BDNXNURWxjMjFVYTBKY2xPNzhJ?=
 =?utf-8?B?MWFySDF4c1hWZ01OR2FRT3FybVM5WEpsUWU0MVYycFZlSDRNSkxWdzZ4V0FC?=
 =?utf-8?B?ODIrc01BbnZEb3AyTnc5dDFrQ3E2VjNQeXQ4cmNIK3I0NGxOZ1pIaGNrdGR6?=
 =?utf-8?B?NFc5OGFZMlRrT2RtNzdINXBNVE90VTJ3TGdDcDdLWmFkazZjN090MXFORnFq?=
 =?utf-8?B?N1JNblgyMkxCSFFPbnFhYUxNQXppRXNKcWxFSlowRURTUHVjellWRnphU1I1?=
 =?utf-8?B?SElUcWsxbE9NdmxzaUdSZmlla05jVkFvdmxlMzdxaFc5TjVIVlV3Njg2b3hp?=
 =?utf-8?B?ZGZuL29XOTNka1JtcFd5K2pDdks2NTZYY1ZsK0lBUlpFQi9RUmpVV1Zud0tq?=
 =?utf-8?B?TWZ1eHR1bVRlZFpJYWJqREFkeVNVMnBWd2RlZGIzRHJOOS9oWi85VGVYR3Jj?=
 =?utf-8?B?QWFmRU9LK1dMbmtlUEZPSzVWcmV5dG4zdFR6ZjRTV1drcVpoQkk3Skl5Snls?=
 =?utf-8?B?TzR1Y0RRS0UvU3Z1YXhwd0VnNTh3SkJTVnE1cUxSUlNqdUwyOHJFRG1acmYx?=
 =?utf-8?B?RjYrRHp3L2FyZFM4dGJDcWV6bm1Bb08zc1V4MmR6LzhYdE0yWnRpZmR6dEdR?=
 =?utf-8?B?R1AwNDdHYW5wQmNZdURVSEx1MG5RNU9FeHcwQjRsWk45Q20rSExYa3REUTc2?=
 =?utf-8?B?REJROTEyZGs4Y0RFeDRpcDVjR0RxNjJ1MzQrWXBSdE5XK3h5YnhWcE95dlk1?=
 =?utf-8?B?dnV5VHZEb0JGbjNYQk5WdHg3RU9aZDlPMVd3SGViTlRMM1NKcVBDWVRqZ2Jx?=
 =?utf-8?B?dTN2TGtuSVh6MTlLVTRrVzF3aktBYjZEMTlIMlE2L2puUEUzRTJvYjBPdVB0?=
 =?utf-8?B?QkFSOHljNjdOSHJQOTJERWNPbytGZFpjOFRtV25uVHNWbDJXNEhTbngzNGg0?=
 =?utf-8?Q?suM+MaUrvFk0jZoxSzu/ZuFPx+Vsoked?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amdKck9ZdzdIcitKUkp5R2M3cURnRWFMTXVQeHVXTGxWZTNJQStLcnpBdDZx?=
 =?utf-8?B?UjNoQlFkSmRXaHA1cnF0OE5uRWJGUWhFN0RFb0ljUmxFMkVzWTRmai9mYi96?=
 =?utf-8?B?WDNrSC9xVkY1YUxzbXpmbSt1c2tVczNDV0poSFBOOG5MNU8zbFNGLzFqV04y?=
 =?utf-8?B?YndmOHFOOVNjdmpwWnAvcFEwQjd5QUpTanhEdFFsYWEwajREL2FBdjVyOURp?=
 =?utf-8?B?QTd4ZUY0TVgwZVJGWjBTNHRPNmsrU2Q2VmliclhTR0kwbHZHT2QzVVVFN0pp?=
 =?utf-8?B?T3d0WFJOM0ZFaWdndkdkQnduYk9QMEltb3JpbUpua2VpRHEzd052UGNhRXpx?=
 =?utf-8?B?Vlc2THVDamNBODZXbDNzWlpCL2RzdFVQa25Qdjl0YnB1NnJUTFJ3b2xXSXNs?=
 =?utf-8?B?K2gxMFdxQ0pxbW1vckhFUkhCa1NxVG5KUHlGK1pQNExQRVRRcHMrZzBRUWIy?=
 =?utf-8?B?MytwUE10ZlduaDlpSXdKaUlTUWJ5R0Y4akhycVVqcitZWkNKaGlFdTNsQmZx?=
 =?utf-8?B?SFBYUGwrV2RsTXQ3Z0kyKzJ4d09WWS92Q0FTOC85dnI5cUM0ZDg4QVMxdzRU?=
 =?utf-8?B?TDFEaTZ2cE5ZR3liSjREdHYvb010ZWhlM000R0g3aVZMNmFQSVQrOVR5YXlD?=
 =?utf-8?B?U2U3cFlmdXcvZnZoZExBUG1GTWhmOFV5UnhLVzhmcnQ1OVYzWnRQeG40b1l6?=
 =?utf-8?B?Y3o3SHZHekxpdVozYXNQUHI5TXdFdFF6Vzk2YVpoWEZzbjRZdWZBR3NsQ1cx?=
 =?utf-8?B?YTQ1QVlueUZTUTB3ZXhweER1a24wdUhXN3Fza2pyY0hqSjk2bGUxOHFXNENQ?=
 =?utf-8?B?Z1pFV2FCVC9SWVFjdnlHaUJMNTVXTElLR0o5akVJVlJPbjVWMUw1cjhGd2pW?=
 =?utf-8?B?TFhHWjQ2ekh0NW1hYlVyVGZFVVVLbFY0cVh6bGtua1RpUW1uL2VENE9FU25w?=
 =?utf-8?B?ODdXQkNHdXpzdUliVm5JYUdrU2F6YVpOeWtRNldEL1Bsc1hsZjQ5YTgySWxn?=
 =?utf-8?B?cERZYVI0V0ZTdEFrNTcvZjJuZ2tWTEVRNEdWWmVhNlZzOTZPWnczcHg0cUd2?=
 =?utf-8?B?U1ZIb0RTbGlsY1JlNTArMTBPbjRPOUlrWk94UVI1cHN2bi84Z1pyUUpCM0h2?=
 =?utf-8?B?L2I3ZGNhZWYxWjM2c2dsQS9iWGRWUjUzOUQ5NDBjbGY3UWRNdy91RDNLU2lF?=
 =?utf-8?B?OFppYzdnMUtKbVFpUFh0TXBwcTFISm10RXkvbmxKdE05VTQ2WGtRenVOVXFV?=
 =?utf-8?B?Nlk0eUJkeW1ralFQLzV6My8zUThZQ3M3Z1AvU1FvZDNxa2gvZFdzekhDY1Jp?=
 =?utf-8?B?c3BZMzlpVm8ydEZRTnVkb2FsbnJBdFNlSDFrYTgrSktuL25PZnVLdy9mUDZv?=
 =?utf-8?B?TDBGdTVDVnhEWkVsV0dRN2lNOExrZVhOT25pZGNIdGJMQ2JBb0RXbnowWnVW?=
 =?utf-8?B?QkRrcW1TUjR1T3J4TnlTTDY4bWtIOXRiU0V0QXBUK3FaTjVJNmtnOTRmQmt1?=
 =?utf-8?B?bUNzMTVPWUI0ZFpydCtGbTFoRTZ5emdjcWx5M0FYTGVmYlZuR1krOVgyMjJI?=
 =?utf-8?B?bnV5Vk9XU3lENGdNNitNYTZ2am5xM3pILzNqT3A4U256L256WUovbUZUc0dO?=
 =?utf-8?B?ZW96VkorRTZHdTdhOWZhS09xeWtIOUl5YWJBMFpjTDNsWEZTODFEemhIaVFR?=
 =?utf-8?B?MDJWMWZwOUJkRmV3bkNzeS81cll2SkJxUlVNNHlEZjdMcFdjcG1oYjkvSjVl?=
 =?utf-8?B?VnBOa09kNkpXRTFSaVpTWGo1RWZxYUlRZkc1MDdKSTRtNFpDWVAzT2FuazFG?=
 =?utf-8?B?QTQyZTJNaUhHanFPR0U2RGFWT3FQY1JJQzlwZU5XdlhEUzl5QlluajRtUjhY?=
 =?utf-8?B?dVZSZnk1QVpwWnFTNHpEcWxIb0M2dWFQN2ZrTk50M0dZUi9RMTFCMGdYc25x?=
 =?utf-8?B?Vm1TQUlGUUZnTWJNdnB2UnNVM0lkeUR3SUxVdVlRNmI0K0l3SjZPZzBmQlRP?=
 =?utf-8?B?UERET3pZeEZkQTgvd2M5ZDdrbFNsKzhTa2FPaG1lZk44WTYrVmJ2NkhwTHZz?=
 =?utf-8?B?NnNlemJTVUtpSUl6QzA3TzBPNXB6eUtvU2xFc1prYUlnWDBBR2g4cUhJMEk1?=
 =?utf-8?Q?5/gM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d855e82-b8c4-4cba-a3d3-08ddf73aa38e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2025 05:08:58.0653 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AjqdKzB6lRMF5SkjK6hivqIFwy/hRYuKWdAi8jKnyOBJjedrAOHuNQpnGpGNTc6rqTQYk2wQoWLmw+vdtR7gXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB5071
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE4MDEzMCBTYWx0ZWRfXxwURcH4G+Ab2
 rkC2kpGYAb3LHnmVxKLrmi9O1FPMO9+nqK1dik2qZNNlkKsmSZ29DoyV0z8HigNSh5/Mma9S6kU
 ipbQle/Cotzg56YxGgbvudDLJzUxoZtAOlPcfpL4MQe4ydZL7+7TaC6/94RW+BpclQ9Jnvu4U0X
 SJYLejdRGfzBR4SOeYs0vLt29qgOnmkrtN+xevfcqEUDpdyI2retspa1pqECGPELfsbzWrtN1TN
 Rc1srBayYBMaRfP+glK5tbjP788PYsVE1p8CEeLmo2RYSXmuuFssYC1Q6/T0UTB56Ypz08r620P
 Hh60lKHTXHJ63iZSaimELBrSLLFilHyLw9GuceB//6Yt0fIQ5wHdYs7gfE8RXDMpfAbubWIjmyN
 iFh2GM5A
X-Proofpoint-GUID: XxFRTEZzn4cUw9Vuqosy7Pq-skD1ocIU
X-Authority-Analysis: v=2.4 cv=JYC8rVKV c=1 sm=1 tr=0 ts=68cce56e cx=c_pps
 a=Sq8Pev+jtt5PqluhJgCvtQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=-AAbraWEqlQA:10
 a=8rWy6zfcAAAA:8 a=EUspDBNiAAAA:8 a=M5GUcnROAAAA:8 a=pGLkceISAAAA:8
 a=GzTIy55JKRCfn8eRTTEA:9 a=QEXdDO2ut3YA:10 a=YjdVzJdQTyZRADMV7wFX:22
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: XxFRTEZzn4cUw9Vuqosy7Pq-skD1ocIU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-18_02,2025-03-28_01
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

SGkgU2FtZWVyLA0KPiBIZXkgQWtoaWwsDQo+IA0KPiBJIGF0dGVtcHRlZCB0byBzcGxpdCB0aGUg
Y2hhbmdlcyBpbnRvIG11bHRpcGxlIHBhdGNoZXMgYW5kIGFkZGVkIGEgZGVwZW5kcy1vbg0KPiB0
aGUgc2Vjb25kIHBhdGNoLiBCdXQgYXV0b21hdGlvbiBkb2VzIG5vdCBzZWVtIHRvIGJlIHBpY2tp
bmcgdXAgdGhlIHBhdGNoIGFzIGENCj4gZGVwZW5kZW5jeS4gSXMgdGhlcmUgYSBwcm9jZXNzIHN0
ZXAgSSBtZXNzZWQgdXA6DQoNCldoZW4geW91IGhhdmUgZGVwZW5kZW50IHBhdGNoZXMsIHlvdSBz
aG91bGQgc2VuZCB0aGVtIGFzIGEgc2VyaWVzLg0KQXV0b21hdGlvbiBydW5zIG9uIHRoZSBsYXN0
IHBhdGNoIGluIHRoZSBzZXJpZXMgb25seS4gDQpDdXJyZW50bHkgaXQgaXMgbm90IGhhbmRsaW5n
IGRlcGVuZHMtb24gdGFnLiBJdCBpcyBmb3IgcmV2aWV3ZXJzIGZvciBub3cuDQoNCg0KPiANCj4g
DQo+IFBhdGNoIDE6IGNvbXByZXNzL3psaWI6IHN1cHBvcnQgZm9yIGRpY3Rpb25hcnkgYW5kIFBE
Q1AgY2hlY2tzdW0gLSBQYXRjaHdvcmsNCj4gPGh0dHBzOi8vcGF0Y2hlcy5kcGRrLm9yZy9wcm9q
ZWN0L2RwZGsvcGF0Y2gvMjAyNTA5MTgyMDQ0MTEuMTcwMTAzNS0xLXN2YXplQHF0aS5xdWFsY29t
bS5jb20vPg0KPiBQYXRjaCAyIHdpdGggZGVwZW5kcy1uOiBhcHAvY29tcHJlc3MtcGVyZjogc3Vw
cG9ydCBkaWN0aW9uYXJ5IGZpbGVzIC0gUGF0Y2h3b3JrDQo+IDxodHRwczovL3BhdGNoZXMuZHBk
ay5vcmcvcHJvamVjdC9kcGRrL3BhdGNoLzIwMjUwOTE4MjEwODA2LjE3MDk5NTgtMS1zdmF6ZUBx
dGkucXVhbGNvbW0uY29tLz4NCj4gDQo+IFRoYW5rcw0KPiBTYW1lZXIgVmF6ZQ0KPiBfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXw0KPiANCj4gRnJvbTogQWtoaWwgR295YWwgPGdha2hp
bEBtYXJ2ZWxsLmNvbT4NCj4gU2VudDogVHVlc2RheSwgSnVuZSAxNywgMjAyNSAzOjM0IFBNDQo+
IFRvOiBTYW1lZXIgVmF6ZSA8c3ZhemVAcXRpLnF1YWxjb21tLmNvbT47IFN1bmlsYSBTYWh1DQo+
IDxzc2FodUBtYXJ2ZWxsLmNvbT47IEZhbiBaaGFuZyA8ZmFuemhhbmcub3NzQGdtYWlsLmNvbT47
IEFzaGlzaCBHdXB0YQ0KPiA8YXNoaXNoZ0BtYXJ2ZWxsLmNvbT4NCj4gQ2M6IGRldkBkcGRrLm9y
ZyA8ZGV2QGRwZGsub3JnPg0KPiBTdWJqZWN0OiBSRTogW0VYVEVSTkFMXSBbUEFUQ0hdIGFwcC9j
b21wcmVzcy1wZXJmOiBzdXBwb3J0IGRpY3Rpb25hcnkgZmlsZXMNCj4gDQo+IFdBUk5JTkc6IFRo
aXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgUXVhbGNvbW0uIFBsZWFzZSBiZSB3
YXJ5IG9mDQo+IGFueSBsaW5rcyBvciBhdHRhY2htZW50cywgYW5kIGRvIG5vdCBlbmFibGUgbWFj
cm9zLg0KPiANCj4gPiBjb21wcmVzcy96bGliOiBzdXBwb3J0IFBEQ1AgY2hlY2tzdW0NCj4gPg0K
PiA+IGNvbXByZXNzL3psaWI6IHN1cHBvcnQgemxpYiBkaWN0aW9uYXJ5DQo+ID4NCj4gPiBjb21w
cmVzc2RldjogYWRkIFBEQ1AgY2hlY2tzdW0NCj4gPg0KPiA+IGNvbXByZXNzZGV2OiBzdXBwb3J0
IHpsaWIgZGljdGlvbmFyeQ0KPiA+DQo+ID4gQWRkcyBzdXBwb3J0IHRvIHByb3ZpZGUgcHJlZGVm
aW5lZCBkaWN0aW9uYXJpZXMgdG8gemxpYi4gSGFuZGxlcyBzZXR0aW5nDQo+ID4gYW5kIGdldHRp
bmcgb2YgZGljdGlvbmFyaWVzIHVzaW5nIHpsaWIgYXBpcy4gQWxzbyBpbmNsdWRlcyBzdXBwb3J0
IHRvDQo+ID4gcmVhZCBkaWN0aW9uYXJ5IGZpbGVzDQo+ID4NCj4gPiBBZGRzIHN1cHBvcnQgZm9y
IHBhc3NpbmcgaW4gYW5kIHZhbGlkYXRpb25nIDNHUFAgUERDUCBzcGVjIGRlZmluZWQNCj4gPiBj
aGVja3N1bXMgYXMgZGVmaW5lZCB1bmRlciB0aGUgVXBsaW5rIERhdGEgQ29tcHJlc3Npb24oVURD
KSBmZWF0dXJlLg0KPiA+IENoYW5nZXMgYWxzbyBpbmNsdWRlIGZ1bmN0aW9ucyB0aGF0IGRvIGlu
ZmxhdGUgb3IgZGVmbGF0ZSBzcGVjaWZpYw0KPiA+IGNoZWNrc3VtIG9wZXJhdGlvbnMuDQo+ID4N
Cj4gPiBJbnRyb2R1Y2VzIG5ldyBtZW1iZXJzIHRvIGNvbXByZXNzaW9uIGFwaSBzdHJ1Y3R1cmVz
IHRvIGFsbG93IHNldHRpbmcNCj4gPiBwcmVkZWZpbmVkIGRpY3Rpb25hcmllcw0KPiA+DQo+ID4g
U2lnbmVkLW9mZi1ieTogU2FtZWVyIFZhemUgPHN2YXplQHF0aS5xdWFsY29tbS5jb20+DQo+IA0K
PiBTZWVtcyBsaWtlIG11bHRpcGxlIHBhdGNoZXMgYXJlIHNxdWFzaGVkIGludG8gYSBzaW5nbGUg
cGF0Y2gNCj4gDQo+IEkgc2VlIHRoYXQgdGhpcyBwYXRjaCBoYXMgQUJJIGJyZWFrcy4NCj4gV2Ug
bmVlZCB0byBkZWZlciB0aGlzIHBhdGNoIGZvciBuZXh0IEFCSSBicmVhayByZWxlYXNlLg0KPiBQ
bGVhc2Ugc3BsaXQgdGhlIHBhdGNoIGFwcHJvcHJpYXRlbHkuDQo+IEZpcnN0IHBhdGNoIHNob3Vs
ZCBkZWZpbmUgdGhlIGxpYnJhcnkgY2hhbmdlcy4NCj4gQW5kIHN1YnNlcXVlbnRseSBsb2dpY2Fs
bHkgYnJva2VuIFBNRCBwYXRjaGVzDQo+IEZvbGxvd2VkIGJ5IGFwcGxpY2F0aW9uIHBhdGNoZXMu
DQo+IEVuc3VyZSBlYWNoIHBhdGNoIGlzIGNvbXBpbGFibGUuDQo+IA0KPiBTaW5jZSB0aGlzIHBh
dGNoIGlzIGJyZWFraW5nIEFCSS9BUEksDQo+IFBsZWFzZSBzZW5kIGEgZGVwcmVjYXRpb24gbm90
aWNlIHRvIGJlIG1lcmdlZCBpbiB0aGlzIHJlbGVhc2UgYW5kDQo+IEltcGxlbWVudGF0aW9uIGZv
ciBuZXh0IHJlbGVhc2UuDQo+IA0KPiBBbHNvIGF2b2lkIHVubmVjZXNzYXJ5IGFuZCBpcnJlbGV2
YW50IGNvZGUgY2hhbmdlcy4NCj4gDQoNCg==
