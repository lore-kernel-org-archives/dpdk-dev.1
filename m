Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2312DC021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 17:40:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E485402DC;
	Wed, 26 Feb 2025 18:40:14 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id A9D4B4026C;
 Wed, 26 Feb 2025 18:40:12 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q8e2Xu010777;
 Wed, 26 Feb 2025 09:40:11 -0800
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 451yn396rs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Feb 2025 09:40:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sgmjVBPX08qEGwndbBZiAv8dMW5OybuMurzqI33x9T9NDPixrkCDxREO+QOxuZ2kvAm9k/LMAx90/0PPJv8Ff8QAQmzYm72Cfjd5dBeHXsxZcfdgkDKtf9BTp5Ada3eKkI2in5GTJ9NcQAHpi1kr2L2ovEJzTFy917AiZotETZ0DoVIOKoOu/ryNtL9WNtPM07iDPc1z5JRS3oDDMnUMwEXsbJMQY3h8hILObIaMN+SqEH5Dk30NY5e5CfkDBVeQ14T7js1SmkMcL8KtTCkF7zvco4iJd7odTlQwsuoVQDR85sUA/ETvWbgfZheNhLfAGDTInamuMvnWkQWGlHjdaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qeiiVeLZfusvLZ2qIav22wFzR7xgKZZCBbCalctkDwU=;
 b=kwA9i3/ySe+fxKDxX0gjnywy0B2rk22tGqnzB3YTTzNvXHYfNyK1HPnm/LQVflGiiEvMM9OSomyqFfC7h9/YsoyWhdPd/xUTASjlrGVYl+XzCq7+TogP0zW1WLIExjZE8yp7cPdWv9c7B9PlqaI9MfDN5TkBSd4CMstlLbXAJXQKX32T9IsYEXqrLnOUw3Im8nWoUoHx/xC2clubMrz/sQn59Q1rc+4npFSzwu1dX+kYq4wU6j8CenCI3WZ2nlyH0mBLwlmGI839AnD/qLThOdO+ra+SgReKR0F9jmYMzgy7l3eX6s08PZsIKvl3OSRQrECHQa9RXHcE94FGd86irg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeiiVeLZfusvLZ2qIav22wFzR7xgKZZCBbCalctkDwU=;
 b=fcIzuso+ZG2SgMD7sCcr3qgHdsvygOh5pWbYtafdzx/RbaXGW8XrEu8xUwVjQoOaUJb8CrfF2Hu6ono1K7FQPuqY5+/w8vGgluF9jGdCWytkokXq+YcrUbeLuYVE6aAyAGPC1r5BWG6vJt5zaBrs819mPVaSs5a/1kOoqCIV2c0=
Received: from CO1PR18MB4714.namprd18.prod.outlook.com (2603:10b6:303:e9::18)
 by SJ4PPFAC4FEC6EB.namprd18.prod.outlook.com
 (2603:10b6:a0f:fc02::f37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Wed, 26 Feb
 2025 17:40:07 +0000
Received: from CO1PR18MB4714.namprd18.prod.outlook.com
 ([fe80::26fb:729e:a947:3e06]) by CO1PR18MB4714.namprd18.prod.outlook.com
 ([fe80::26fb:729e:a947:3e06%7]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 17:40:07 +0000
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>, "dev@dpdk.org"
 <dev@dpdk.org>, Chenbo Xia <chenbox@nvidia.com>, Jay Zhou
 <jianjay.zhou@huawei.com>, Fan Zhang <fanzhang.oss@gmail.com>
CC: Anoob Joseph <anoobj@marvell.com>, Akhil Goyal <gakhil@marvell.com>,
 "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [EXTERNAL] Re: [v5 1/5] vhost: skip crypto op fetch before vring
 init
Thread-Topic: [EXTERNAL] Re: [v5 1/5] vhost: skip crypto op fetch before vring
 init
Thread-Index: AQHbhqfSbPbcptyy6U+OOfXjTsOCGLNYNFSAgAFgpjA=
Date: Wed, 26 Feb 2025 17:40:07 +0000
Message-ID: <CO1PR18MB471448E31FF025EF606442A6CBC22@CO1PR18MB4714.namprd18.prod.outlook.com>
References: <cover.1740390893.git.gmuthukrishn@marvell.com>
 <c1aa7cdd5e1d58a6f484fcd45bbbe0f115c7b521.1740390893.git.gmuthukrishn@marvell.com>
 <00e98b7d-a240-4f8f-a06a-a28712e5ef95@redhat.com>
In-Reply-To: <00e98b7d-a240-4f8f-a06a-a28712e5ef95@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4714:EE_|SJ4PPFAC4FEC6EB:EE_
x-ms-office365-filtering-correlation-id: 97ecdae2-7133-4b80-8c7b-08dd568c9c6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZVo3V3IvTExoTUIweExESjUzdnVLUnNDRHhMaUJISFBydXhjcGZpSmtIUFZL?=
 =?utf-8?B?RzhLL1lIdnVNTjczWWRiT3BvSndyRitZT2NZQ2ZkY005OVBaS05MRzlpVllU?=
 =?utf-8?B?TGljRVROM24yT0hvaDRIWFpZVzkvSkJVYm9VWlhuL2VIWEdXaCtJWnZZYk9F?=
 =?utf-8?B?NUV0bjV4WGY4QTR0VUxRdzFab2Z5WHRkdlg5Rjg5R2YwcWN3UE4xN3FIZzBt?=
 =?utf-8?B?WVlwdW10MjYyVFhBbUhCenRlUjFmMVJYbFBOSHdjUEhsWWxVYlBkWU5VWkFl?=
 =?utf-8?B?dE1ONzFNWXhhVjh1UkdBS2FJQXJkcmFiNEhzWmhxTFZLbUIra08yM1VIcTFO?=
 =?utf-8?B?TEJIZWhDMGlVbWlGQnBKekMxMWJjSDRVQjN0R1p4dE9jcmdMalFyOEx2Wlli?=
 =?utf-8?B?L3ZNY1JuYmpyM0U3OVYvenAvbkFDQ1FlamlFQjdRbnhZVnhxUmZ2VzBvY1JH?=
 =?utf-8?B?YVdDTXMrWWJZVFZ5TFdjV3BDNytTZ3R1WXVOWHB3MHZuNC83alFGaHhXalB6?=
 =?utf-8?B?emtqUE0xcHVVMW5wVFk2eGJzcVpudzE0N2FCVXZwYXJWK3VWeFlsdnhDQnpk?=
 =?utf-8?B?M1JLL1lpTG9KSENQV1A1SlEybTh3dnBOTnA3U0Nibnc2bWtsQ1JITHVVVURH?=
 =?utf-8?B?dVgrdWw1eVFpQ2tla0d2a1BwRlJNLzlvSzdKYmdIaWlXbUpTcG1mQTIrMFNC?=
 =?utf-8?B?N1Q2REgxSjNNcWdkT1ZqaHdZU3gzeHUxbFF6ZU5RendIQUNEa0RaaDJmTWtY?=
 =?utf-8?B?MzhLUGgyTlpINDFHOVF2cGdYQlArMnZGdktQcUVJTk1IN1FqZmxiTFFFaVBh?=
 =?utf-8?B?MkgyY0pLU1RIQTVUcFYwaTR0L2pRQ1l6cVNpUHRhYmhvRXgwdDhHY1BKNnJ6?=
 =?utf-8?B?NndERXBYYk4xVVVycXVhUmhpOFQxaDV5TFZvU2RweC9kT1FtejBycm5CSlBG?=
 =?utf-8?B?RGVUVFlDTk5LWG41OUl5Zm1TemVGWU0wNVM1UFVTTCtzcVRsUGVFdVErS3Rj?=
 =?utf-8?B?OUdyQXdNcVYzZ2lyVlJUaWxMZmFDTHdRVTUrTTdkTk5aWm53QjdKTGp1N09m?=
 =?utf-8?B?dy9sT1h3ZEJYOG9MalBybUgwek15TXMzSVozUGtQdWFYK3Q4ZUVkcGFQN1Fl?=
 =?utf-8?B?ZTkvSmxTVm40Qk5xZmtMdXNxWVgyMHBXOHhnSFoyeG03Vm5ZUElIaThYSlZp?=
 =?utf-8?B?N1hoOXFuRUFZbmMrc3Z0N3FqWU42cmhsNmZIN2FEM253YU1aM2taU2RwNlE4?=
 =?utf-8?B?T0psRVp6cTNKOWM3Vlh2U1EyTWZ3VnZGK0tBdmdUS2d5ZU9uY095cnVqWHNJ?=
 =?utf-8?B?QWhwdGZkd0ZXZlBDdEt0MjJKRFFUY0VlQUpwRHVvVVNENzBDZTVaQ0M1V1Bq?=
 =?utf-8?B?S2RObkxXUDFRTkFKOUlGV0hBT0g3WlBtNWY2eWJiYW82dkxZNXVoSjJ0SkVa?=
 =?utf-8?B?eWw3UThkOUhhK2FXREpJWXRGVnlIK1VwZzRGVUU0RDlNZm9PZ21KZ1pJanFo?=
 =?utf-8?B?TGdBRUdDMEVHR1RiZis1Q1lCbmFIMERmazh5NWx2OExIMmVlVTJ5MlZEek12?=
 =?utf-8?B?cFJCNzIvV0YycW9GWkxOYnNJZ2JvaTZJUm94WFJManMwbXVZczFGL3hEdEhJ?=
 =?utf-8?B?cm55bjdaeUNZM0dHUjl3ak55WnQrRlRlaThUa0VmekdsbStJV09TblhzUVlH?=
 =?utf-8?B?U0hqMm16eU5tZkxydWV4NWlqVTdYaUgwSy9vSXJ2QUh4VHNmZThRcXRvTnNY?=
 =?utf-8?B?ZnhOS3ZYYzdyZWJTTWRQbnNmUW1iQTlaRHpLaUduOXNqTkVyMWxsS1g3TUtE?=
 =?utf-8?B?N0s3WDJMY2FFVlhGWE1pQjQ3aDIrL2diZVBUOUltNHZEa0lEeW9sN3RxNU5N?=
 =?utf-8?B?MDloejYwdmJHa2dQanVFMHBEVjdaenRBQXI4amVRWTRaMFZMMlgyT0xHZENX?=
 =?utf-8?Q?Cs4z5PbEC4qWCQXbbusq9oUCmwyndk1F?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR18MB4714.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZlVNd3ZGaXZ1azgvdGwvZE5RS2wzS3lzcHlRKzFQVnU2cUxSaExKRmljM09R?=
 =?utf-8?B?N3lIV1ZTUERWRlNRd3NGRXoxTHdRZXdzQ0NJdndrZU1HM0VNcXZYSjM4L0pz?=
 =?utf-8?B?dVRvYVphK3JZVGhuamZrKy9hVlFJRkw4YnJlbWNQUjlrVzhYTGlxVHBaK3lR?=
 =?utf-8?B?THRtN2hKM215SUtyU3BRWGd1NWEwbE01TDhLZWVSclM3NkpOQnFBbE1jYWIy?=
 =?utf-8?B?V21veStqTXBtTEhDT205SzBVeUdKWWtGUVhVekszWnczMWgvenhqWEh3b2x2?=
 =?utf-8?B?T2h3QTZtVWFVYU10RkhGaFA5ZlFzSVU2UlhtNHR0cjg1NjA2WWJ2TXZpYVNw?=
 =?utf-8?B?dTc3amsrY0o1Q21yaXlnVStmQjR3Y0dCWis4N3RsamtsSXlBY1hXR1lmYjV5?=
 =?utf-8?B?NUZpdERBQktpWmtBRDdPczlVakZHTW9XR2dOUVdEU3FYTkgzWkNPcVBBd0dM?=
 =?utf-8?B?ZDVSdXZWNzZSQ2dRTHNJTXZrak9NeEcwNFZyV2pzUHZHRmJNdnVZendKL1lY?=
 =?utf-8?B?RDhYMGV0ZVltWGx0dHVXV1BvZ3ZYUG1KamlZY1dCNkF2d1dRMTZ4ckZXcHFK?=
 =?utf-8?B?RWVHVmZYSEttaC9La0dicUdQcDdySmdPQjV1K3FaS2ZUbTBGNnRCbTZqenp1?=
 =?utf-8?B?NlQ0MU5IcVZPZGNGVkxFSTVoOGVUMjA4K04xM3hPOGJxUW5BOW9QbGJoOXFt?=
 =?utf-8?B?S0krL1dHT3VEcWR3dnlkc0NuL2VicTRERVhQcTNnRzJobW1hYkcwRWdxcnFM?=
 =?utf-8?B?UEFXUWo5T3RBRFl0K3MrRTJmcC96OTY5YjV0bDdTc0FVRTM1ekRwMSt1WVQv?=
 =?utf-8?B?NG9oY1hEc095SDFZcWlBbVhyWWRCZHphNG5sQ0JlMGdjek9RVHdYSGFpQ0do?=
 =?utf-8?B?NDNVMklmN1RPbFRYVG92dXFTSjgrbEdNNHdtRWRiRmMxVlFrRlNUSEdGTUV1?=
 =?utf-8?B?TWc0VW50R0p2QTBaeTlHZWw3K1FUeVRxSlRxT0ZlaDNlZTIyT0hYQnJuS0dx?=
 =?utf-8?B?aTVCRHhNNWRMZFBieDAyQVRUQisxYWRRZjhadFBJMk1iQmgrSEFxU3BaQnFC?=
 =?utf-8?B?alVFN3BKbThUczBPS3lkbmFrZGRzbVdYWm1NaHVhVXdOaWhzOXRPRFl0elBW?=
 =?utf-8?B?SWhyMVpLTFE2ZjZvSHlLQWtiYnNOWnA4NkZuOEJOR2dZS3pPekxUQk9mdzhS?=
 =?utf-8?B?YzZiOUdRYWU0L1NFQW92VVVveW1lWXVIdk9RMnFnR09xSlErZk1Ta0VWOVM5?=
 =?utf-8?B?OHV1MDFhWVVZeWR2eTRpVW9rL3hqS0RwbHdGTkdnbGoyd0Z1SVlRRC9iQlQr?=
 =?utf-8?B?RDVGejlaL3QwYmpEbjJWTkxpczZUdXFIVEg5QjFHSkhMS2dOYzcvSnJac1RU?=
 =?utf-8?B?K0ptM3RwZTVtaFZHYWp4U2tpZEUzcERjaGN0WjhWMHVVbWJRQ3V3Y2tzZEhP?=
 =?utf-8?B?bHhFM0dNMGZGelVQUFZmdDZpY252clNvRTVEbEpMQi9nd3Z3eGc4MUY1a3JS?=
 =?utf-8?B?MEt4WG4vNWZSb1IyNnBZbHZRamdlcDVpeDlDa2ViYTNnS2hOL3I3cy85TE91?=
 =?utf-8?B?YUlmM2YwcGdJU3hHNzBlZStqTnZkTHFEaDcrUVJON1JscFU2VW0rc3JFazE5?=
 =?utf-8?B?ZEwyL214akdrY0dRNFgra2d6b0VjaG9lTmxWR1h1TVY4ektoY3o0R3BmUm8r?=
 =?utf-8?B?L1lMOS9oNWkzSDlZc2lwUjZJRnBCSlhXd25pTXM3eDJISGQ0cjZmTk15OWV3?=
 =?utf-8?B?a0pUSytZNlhFWHZTOVpGRG9EdVZKQ2lnbnpBQTNsbmxMZUFtZTdIZFRCYUtL?=
 =?utf-8?B?QVNhV1NhSDkzc0FWa3FGNFZTU0xCcStkUllSRkU5bGE5eFd0b0dneXpiTDht?=
 =?utf-8?B?SjJabXBHTGsrMmxoa0JCdU1XRFlVcWtyaCtGQTVjTytwakhjbUhCVmptYlA5?=
 =?utf-8?B?N08vZDB4ZTF4NEl1ZXhNTlZPUUNiQzVWM2p2SGY4TlYyQnlhWU0xRTRYN1JD?=
 =?utf-8?B?ckg3ZU9QUlpHYnVpazE2MHE0RUFKQlhDZkVMbmhTYXBuUm5mOUk0czNraTlw?=
 =?utf-8?B?S0R4VWFwdVhTK05lNDFOUXlETEFLcjBJUm1VWk0zMlBRaXpoUmM4aVJTRDF2?=
 =?utf-8?Q?hl54IvKo9GNg8FoIC+vj0bBCW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4714.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97ecdae2-7133-4b80-8c7b-08dd568c9c6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 17:40:07.6125 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9VDdvT9hPAAmo9vDRwTtsatovEfG8fKQCRrWWRKsB49rTUDqeIlsZigjvrzk05e2/UL7LEWMz4uptlwUc0ZCnniH1UDd49EYv/29D8hLE00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ4PPFAC4FEC6EB
X-Proofpoint-ORIG-GUID: iuzRtOSEYaSMQlFfw6EGelGkgdu_AqQU
X-Authority-Analysis: v=2.4 cv=BLRJrEQG c=1 sm=1 tr=0 ts=67bf51fb cx=c_pps
 a=2bhcDDF4uZIgm5IDeBgkqw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=T2h4t0Lz3GQA:10 a=-AAbraWEqlQA:10
 a=QVwLZOpkJ2vixkpznZIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: iuzRtOSEYaSMQlFfw6EGelGkgdu_AqQU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_04,2025-02-26_01,2024-11-22_01
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

SGkgTWF4aW1lLA0KPiA+DQo+ID4gKwlpZiAodW5saWtlbHkodnEgPT0gTlVMTCkpIHsNCj4gPiAr
CQlWQ19MT0dfRVJSKCJJbnZhbGlkIHZpcnRxdWV1ZSAldSIsIHFpZCk7DQo+ID4gKwkJcmV0dXJu
IDA7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJaWYgKHVubGlrZWx5KHZxLT5hdmFpbCA9PSBOVUxM
KSkgew0KPiA+ICsJCVZDX0xPR19EQkcoIlZpcnRxdWV1ZSByaW5nIG5vdCB5ZXQgaW5pdGlhbGl6
ZWQgJXUiLCBxaWQpOw0KPiA+ICsJCXJldHVybiAwOw0KPiA+ICsJfQ0KPiA+ICsNCj4gDQo+IEkg
dGhpbmsgdGhlIHByb3BlciBmaXggdG86DQo+IDEuIGFjcXVpcmUgdGhlIGFjY2Vzc19sb2NrIGFz
IHJlYWRlcg0KPiAyLiBjaGVjayB3aGV0aGVyIHZxIGlzIGVuYWJsZWQNCj4gMy4gYWNxdWlyZSB0
aGUgaW90bGIgbG9jayBhcyBhIHJlYWRlcg0KPiA0LiBjaGVjayB2cSdzIGFjY2Vzc19vaw0KPiAN
Cg0KQWNrLiBFeGNlcHQgZm9yIHZxLT5lbmFibGVkLCBuZXh0IHZlcnNpb24gb2YgdGhpcyBwYXRj
aCB3b3VsZCBjYXJyeSB0aGVzZSBjaGVja3MuDQpDdXJyZW50IHZpcnRpbyBjcnlwdG8gZm9yIHZo
b3N0X3VzZXIgZG9lcyBub3QgcmVxdWVzdCBTRVRfVlJJTkdfRU5BQkxFLCBzbyB0aGlzIGZsYWcg
d291bGQgbm90IGJlIHNldC4NCg0KVGhhbmtzLA0KR293cmlzaGFua2FyDQoNCj4gWW91IGNhbiBo
YXZlIGEgbG9vayBhdCBydGVfdmhvc3RfZGVxdWV1ZV9idXJzdCBmb3IgZXhhbXBsZS4NCj4gDQo+
ID4gICAJYXZhaWxfaWR4ID0gKigodm9sYXRpbGUgdWludDE2X3QgKikmdnEtPmF2YWlsLT5pZHgp
Ow0KPiA+ICAgCXN0YXJ0X2lkeCA9IHZxLT5sYXN0X3VzZWRfaWR4Ow0KPiA+ICAgCWNvdW50ID0g
YXZhaWxfaWR4IC0gc3RhcnRfaWR4Ow0KDQo=
