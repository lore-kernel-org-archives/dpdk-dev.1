Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45381C369B8
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Apr 2025 04:05:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 39B79402A1;
	Tue, 15 Apr 2025 06:05:39 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 1DAFF40289
 for <dev@dpdk.org>; Tue, 15 Apr 2025 06:05:37 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53EJl1nN017761;
 Mon, 14 Apr 2025 21:05:36 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 45yqpjdjvy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Apr 2025 21:05:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yPpzTvXcXqrGXcnxCl5+kYg9kgbhrvN49LHRyj3HX00FD3dEoOMc9zhXqLt9c3Lm8Ykkf2VUz9/za5CLmyMBlYLXarNBnPNAWhoyrgAzx/XLPVP5ORW0HU0pezLlNd9oXm1qqmk77uqivTurk5+SeFq2zdx0OWId/a7CyizmeyKQPllSxZ7Pxt2csCA65EIABhYGEJPPfLBDxaOf2MWYzseI/bQ8jpTsavhErBbYqH3aKSeii5Io9dsgexY1x1FilnMlLIK96wIcQjnG3H7pgo0THCIQZrKKqPVIZRoe6eYkYRLGv/aZXYQjkpQa81GkB4ya9/iyGg0rfe+H9FcMHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pnqCtrKSTdZ747Q7xC91x7zpRis6ne1GBNfqP2OIuA=;
 b=kRQcyUO3Fly1RrRTmSHKfJv2BCWkVhJ5dZ4uEYpFbf9uJVylGFpw7/H0DistGASwDxnibA99h+5cgfE53KRXtu4nuaPLhgpUsU20OFKq3TSZpcNfMe959Rm12pzqH2UZf3olQ36bp/hDNNjbAtWbP6cWpasGey/pNeFRh8HGDRdC6f3TUp2t/ZTytNnClV751EDGdWzqIP6lJn4+mcT5faYlrHqvNTFDvWRd+i4sUs37rxXVnKOrdBRrh7Mwkpigc4UDP3axCYD6/q+NDKUOf+X65U6I5GscKDoIeSil7+ZMG6gXbw8G86m6Ct3Y6z6kCApqjnKdP/BP9jFMJ7HmrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pnqCtrKSTdZ747Q7xC91x7zpRis6ne1GBNfqP2OIuA=;
 b=vz3j7MZr0DsQu/7Kfi6HjgCCvoRsl8J/lhbrob2VosAsyE0G4T3rzVkSUK4cy2G0boqSHifl9cu4tv7hrb0qPdpP0ZUUGSIW5qD60fhuRMXx28N6etbXAy+DKCzC3JJdyPijFdahJ1aiSglJQoFW23VHvz8HLfk37NWeXBxEw3Y=
Received: from DS0PR18MB5502.namprd18.prod.outlook.com (2603:10b6:8:161::18)
 by BL1PPF8A51B4558.namprd18.prod.outlook.com (2603:10b6:20f:fc04::da7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 04:05:34 +0000
Received: from DS0PR18MB5502.namprd18.prod.outlook.com
 ([fe80::310e:57b6:bb32:be0c]) by DS0PR18MB5502.namprd18.prod.outlook.com
 ([fe80::310e:57b6:bb32:be0c%5]) with mapi id 15.20.8632.035; Tue, 15 Apr 2025
 04:05:34 +0000
From: Srikanth Yalavarthi <syalavarthi@marvell.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Srikanth Yalavarthi
 <syalavarthi@marvell.com>
Subject: RE: [EXTERNAL] [PATCH] mldev: enable to be compiled with msvc
Thread-Topic: [EXTERNAL] [PATCH] mldev: enable to be compiled with msvc
Thread-Index: AQHbqxxKzdN5TnBJ+ky6+fd0GLr1ZrOkIMww
Date: Tue, 15 Apr 2025 04:05:34 +0000
Message-ID: <DS0PR18MB5502FE130E5E4877DF9EB25EAEB22@DS0PR18MB5502.namprd18.prod.outlook.com>
References: <1744401578-30459-1-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1744401578-30459-1-git-send-email-andremue@linux.microsoft.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR18MB5502:EE_|BL1PPF8A51B4558:EE_
x-ms-office365-filtering-correlation-id: baaafa7a-b72b-4835-76c5-08dd7bd2c559
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OGNtZGQrSzU3YWRlSFB6RzA0WEhDSzFBdjhhNXFYY0p4T202UGNoRHpnNEo2?=
 =?utf-8?B?SC9jYlE2eURCbElTandDMVVpMUFNN0crMGs5bENDeTV0UzlVc0dRSlpSTi82?=
 =?utf-8?B?aEFuRjBsa1YzMVNkVVNWREpuZ3MwT0htLyt4cmkzbWE1OE16VWxKMkFYMG5N?=
 =?utf-8?B?RklVZnBXL2pGSktvZWNyWFM1dnpEYXNhdThOVWhBUy9DUTdWNG5FVmpmbFdh?=
 =?utf-8?B?TGlGblZ6R1RhUWdoM3dlYnl1RUxkUzR1Tk9Jc1JlR2hHZlo3ZU1mZUtaa25i?=
 =?utf-8?B?Q21BSXBIc0ZZbzNQNDJoNlJTdmpOTG0yTnpSbUZCc1IrcGpWLzR1T2JBbURM?=
 =?utf-8?B?M25IaDIvWGJlQmo3c1luK3k1clc5c2NPSFRBaEh6TXNUQ3ZMNVgrQjdFem5a?=
 =?utf-8?B?Z0trNkJWR3cwVlh3QitNWnE5WSsrQ2l4OHgvbnZDTk0waUg4UE5JaEpidjI4?=
 =?utf-8?B?dEZkS0tTWVU2ZlJ3NGxGVElwR3hUUytJNjRrb2phQTlYSGowVDVlQ09aQzZ1?=
 =?utf-8?B?SUJ1VGE5RGlnNi9Ibkp4alBPZE1aOFZ2V2JHTlltd3NFR2JtTTVvQk96cjRy?=
 =?utf-8?B?dXoyQmE4ejlnWnlQREx4L2FQZEVaZFc1dDNqWEcxb2wwcTBiSTltaytiWXBK?=
 =?utf-8?B?NTlxUURWc0lYbzhPSnMzb2F1dXcwRWI3dkI0RTkrMFJHMDd4SnNOclNCWEM0?=
 =?utf-8?B?SjZaSmRPWCt2U3p2OHoxMC9SWElSengrNnkybEJCdkpPMDhEdDlySk1xdFo1?=
 =?utf-8?B?YXJtb1E1YWIxOEhsWnlrZ3ZRM1FQOWVrMUt0Q005VCtGdWN2Z1hOVTRIQVQ5?=
 =?utf-8?B?Qnk3ckp1MWZETCt4VlAyM2RIeXN4b1Y5YlZZaFpxaDQvUzYrUHB0RmFFM2tP?=
 =?utf-8?B?SlUvSko1QWI2VENtN2RFbS9ndkhqRGljQnI3MEJOTEZSdW56bWpGZnQ2VTN0?=
 =?utf-8?B?cWZVK0JzNkNrL0dPb2ZuY015MWRxc3FqK1pPdEVXa2Y0UVpZKzZZeDJkVHNm?=
 =?utf-8?B?M2VvSGpKRkxCV1FGdU9rUzJRM0ZXSWZIM294eXc0WlRLaDJybEJ1Zmt2ODRU?=
 =?utf-8?B?ZW9LODNjMmROZ2xJUnBFdUpkYmRHcUpwY3N4OFN3SXZ0UjZLVmEyNk5FK2Vv?=
 =?utf-8?B?enRTMjV4VHpOZ0JTZ1QyVndJc0x6MEZEZUxRaFE0dUIwRnBBMTVKTlArWTFV?=
 =?utf-8?B?dWtvSFhwQThFeUcxYnZ2dnBvVnpJVmtqd2dKZ2xLY3BmdW9MRldkcU8vWjZ1?=
 =?utf-8?B?em9TWldDMkowTVhKUVk0VS9JeFNxWTI5ZERna0ZwbDZIUlIwSkRlMEc4Y2pZ?=
 =?utf-8?B?WlJGRTU0UHBlR2wxcUdjYVRvV25yV2tkaDVrTHI3MVVVVUxjelg5S2w3TVNI?=
 =?utf-8?B?T29WUjZFcXlZVEFIYkZqcHlPRGJUSEtYUEltVjh6R2o4MHRmZnZjQXlRVUt4?=
 =?utf-8?B?amdDNWt4dnl4Qkw2K3RrVjl0MDhXOWZxZktnM2FzSUM0MURyWmx3MmlPNGlk?=
 =?utf-8?B?ZWY4cGdocFE5QkFtMnNrYS9pdUw1ZEhPVmVZcno4TVRsTVJmQ0pSb3JKK1pH?=
 =?utf-8?B?eVVIb1c5M244TDNwQUt4bXhUUFZJUTVLa2pFdEh4TkdjZFdseHliOFR0RnFH?=
 =?utf-8?B?alhDc0lCdVNUZHpZbVNkVEJkdzdLNlBwaGpkREx6dW4xVmp6YVJqbkdaR21D?=
 =?utf-8?B?a3p4dEsxdmJLMGFJVVZ5T2NyQTJVSWxqZXdpU3NqUEZCUllNaFpLbXpLOFNm?=
 =?utf-8?B?QjhZZGNiSFJKcDF1V0xLb2RPOVNVNDY5NnlQbzY3L1JYWHIxUERGb1lrWGpO?=
 =?utf-8?B?ZkdlZGxTZDZJWVJ6VW5rTHFPcVFUTXVEemo3NDZlMkMyTjhMK1RUSy9KRmNY?=
 =?utf-8?B?YnY4c1NyTlh3NStqYlVmNFYxVm96VTFFckR6MG9Bcm1KWEJRQUJTdU84R3hE?=
 =?utf-8?B?WHpPcm9vVytGNWtoWnZBeTFJdWt1SytrbjhUdEcyZUtaUktiMzdYMTZPNXRJ?=
 =?utf-8?Q?jU6jWltvBRu4yyQmXzOerVnimcmxr4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR18MB5502.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGg2Nk14TWpnQkVIdW1tbWtwNTUxT3FuYUZzQU9pMjdJZkVDMTlmcVM1UmZF?=
 =?utf-8?B?bWRXZExiSDlDRkxUanE0TndtRndIcGI3cURodm1oL1NiRHZoTFkraDEwR3dU?=
 =?utf-8?B?SlFJaWNtaDdTY21XWVMwMDdERVJQR2g1UDNrNFF2enR2cldTRVUwb3Q2NEpi?=
 =?utf-8?B?WmRQUE1lcjZhY3BmR0lWNExiRTQ5bnlnVlc4amI1UEIzM2NibjIzTFFMOGdY?=
 =?utf-8?B?bWYzYlYxTW5iR2lsYlExeGdPcnlLSnBMcHBET3E3cjRUSk4zdXEvZHE0bzhP?=
 =?utf-8?B?NzY0VXFNNWlQTDBVcFNycXZJT0pjOWdOdDFHUkJCWU5TK2tUaStzdG80RHJJ?=
 =?utf-8?B?VDcxTHpFd3pOd295RXNQZWx1RlppOHduR2tNVHZ1ZTdkc0JKeDdZcm9vZk1l?=
 =?utf-8?B?SW43YkEwc0w4Z1V2a0dTYjFLZ2hvTEF1ZFlOQzJHTFdrL3VnZlAvWW9OY3N3?=
 =?utf-8?B?Qmk2VFVWTWloaEVHOUNYMVh1TlFzR05ZZDlncERoZVE4ZVpScHQyaTN4N0U4?=
 =?utf-8?B?bFl5dWkxaVdrL1l5emZNVmxqN3VPSTdSbFc4ZzNuUXp0YnlVeDJYWWkrNnA5?=
 =?utf-8?B?MmJPN285a0dNdXdWTjBUY0NSSzc3SFdCZmFKQW0wc25lZkE1R0NrbUJEQThL?=
 =?utf-8?B?Sms0SzByVEl2NTVkeHlMNUowMkcvbkMwYkk5M2ZZNThSR29EQThHY2VzY2d6?=
 =?utf-8?B?Y2dpdy82S1ZPR3BsenorZzM1Qjk4aGtIaDZLVDZKVUg2WGkxdXFQTWFBMlJi?=
 =?utf-8?B?U2U2K1p6Q2s0bjhPb1NrSGlyV0V0dFQrLzNVWVRBRkJLWU5tSTFEdWRGeFli?=
 =?utf-8?B?dXpYYjdjZTlocXlReFYzQUJHZ3g2R0w3NmJKemI2SU5TZkNyZjdvejRZRkhW?=
 =?utf-8?B?ZDIvVFRubnM1S2I5TXR4U2E1WTY5R0Z4aFdoMitJZlhad1NhVnFhMzZ2Smpq?=
 =?utf-8?B?U2NVV0tuNmQ0a1FHU2hTaVZhb01xZURvMkxjbVBCc1Y1cFhMWGRsUEoxdFhi?=
 =?utf-8?B?QktXMzN6TEU0cE5WcmVVWDZzSVpYaGR1K1RJQ0ZNbmRjMk1XTzVqemM4ZXFE?=
 =?utf-8?B?ZUkySTFvRWlkRzNnUkZnYi84cmtIWU1sczV6dExsY2kwWm9NK01CTXYxMzho?=
 =?utf-8?B?Y25QRHRNUmhUQVRGWE94U2M5NzBPNXRVVUM5SllSd1NNcCt5dUpmUndLSjFG?=
 =?utf-8?B?U3JZZkZjYUhrQkZiMHEyL05PdzdHN2VSSm1YMzJJcm4rT2k2bU9tNlpFVkY0?=
 =?utf-8?B?ZjZPVW8xNEVVOGo1TkJGWHAvcDVzNGJBQUpsSGdGd3JDUnJBZ2xKNDRQUVFE?=
 =?utf-8?B?bW9xWDYrU0ZsQW1GOFd0dWVBdWxmSjBHQVpCRS8wTkZVVlo3UnZRVXFaVGw1?=
 =?utf-8?B?bTZHdjQzTVp1WVRoa0dzdTdUVkh2OE5XRGkzSGpiNWdIdDRXMUdrV0ZERnJv?=
 =?utf-8?B?dm1MNmh1RC9BdE4yS3ZTclhlZFRhZ0t0djcyTUZJbXVaTmJRSzB5cjJ5N2Y3?=
 =?utf-8?B?MkI5Uk5qQjdzS29Nd3V4cWJGYTNWRHpNODVzQUFncjdUb0YwYzU3UloxSzJ4?=
 =?utf-8?B?R3NvandML0pJZVpVMGlacmk1RWtVS1FOVHVuTFFQNUVOUTFyWGk1OTdtTDJ5?=
 =?utf-8?B?Y2x3RDNvSDZmcEtkaHBIT2ZDazRHTEdLZ1F4Um5VMVBoT0EyQ2d0UGpTc2N6?=
 =?utf-8?B?MG5Gbjg4LzFQajJPRnBFL09PV1RIaDR1R0UwZVJLV242SzRKS2ZFdWNaYksr?=
 =?utf-8?B?QjI0Z0hPaldXK2pUZGVKaTFCNXVYSVdEeDY0d0FxUVpvcWVXVVNxaEJ0T1hL?=
 =?utf-8?B?N253dGhjbWtHb1NlQXdpcURMWmNjdDY0NFpsYStjUzZsR3d1VHVBMmJUZ25i?=
 =?utf-8?B?dDdIU1Jib0tkN3NNZ3VkdkJUQkdRdUc2M1N4WklpQStzMzM1bU1tUVdiNlBJ?=
 =?utf-8?B?bTdFVnViWmFWdnFpeEVYTWxDL0s5cE5IalNMbzFRQzd5TnFubW4raG4vRkhq?=
 =?utf-8?B?cDdhSXBxVEpOQk94RkJFNFA3QTV5MFp0L1VjdTMxeE8yTE5vRmFaSlpDRFJJ?=
 =?utf-8?B?RnU0TGFTSFhYM1F6N21TVmVzU1IvZGZHdlgxb2tvVG9YQ2JIeEZsNURvOHN5?=
 =?utf-8?Q?LqdubYDwPoGCqq57XU8AoOYeV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR18MB5502.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baaafa7a-b72b-4835-76c5-08dd7bd2c559
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2025 04:05:34.0467 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LGv0O3ToB46TH5ww6l+3oee+HZhf0cKrGEoj/ISNFou6lA/YTVakc+kC5pPiACpHDobIwKGKrvFfsp41CHupLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PPF8A51B4558
X-Proofpoint-ORIG-GUID: YRZFwZukb8K8PxsVBPAgS8hLhlNDcYIs
X-Authority-Analysis: v=2.4 cv=ZOvXmW7b c=1 sm=1 tr=0 ts=67fddb10 cx=c_pps
 a=v3ez6FdVe4RSF1xj2bRqRw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=-AAbraWEqlQA:10 a=yMhMjlubAAAA:8 a=M5GUcnROAAAA:8
 a=ycSMHdrk7aHdK_3PikYA:9 a=QEXdDO2ut3YA:10 a=qXopIq8fWvIA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: YRZFwZukb8K8PxsVBPAgS8hLhlNDcYIs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_01,2025-04-10_01,2024-11-22_01
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

PiBOb3cgdGhhdCB0aGUgaXNzdWVzIHByZXZlbnRpbmcgdGhpcyBsaWIgZnJvbSBiZWluZyBjb21w
aWxlZCB3aXRoIE1TVkMNCj4gYXJlIHNvbHZlZCwgaXQgY2FuIGJlIGVuYWJsZWQuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBBbmRyZSBNdWV6ZXJpZSA8bWFpbHRvOmFuZHJlbXVlQGxpbnV4Lm1pY3Jv
c29mdC5jb20+DQpBY2tlZC1ieTogU3Jpa2FudGggWWFsYXZhcnRoaSA8c3lhbGF2YXJ0aGlAbWFy
dmVsbC5jb20+DQoNCg0K
