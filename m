Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE78C369BD
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 10:07:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BBD2C406B8;
	Wed, 16 Apr 2025 12:07:17 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 179A4406B4
 for <dev@dpdk.org>; Wed, 16 Apr 2025 12:07:15 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53G8jEiu019603;
 Wed, 16 Apr 2025 03:07:14 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4629a604xy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Apr 2025 03:07:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJP7RoKSvVcuHqaU1wA7cbI451LneEO8aZywv5UfMKapSF5FIfi8bBceI4AAjlJ+elEchVYvyiDsOHc+sYofEk3PdMitIvO8gpH0hcJqiPxZVBpFWAdU1Ag1f1JxuxJPLNawSwu/JqL2w6QRZETb9ts+ufbZTtu+WRzIK3dj1eEo4Af1QhNBSQNenfHgZcJWJucDnnSMQ2FkhIzJULZKsmJyMo2ZULOZG8mJY1N8B0cLAfP4gcmmZFn8ZHzCgil+Lm2h6wdGpM+DumUAmh71DGcNIFQDnFksN2wxAFrkhC68jJblIZlFosUZcZAjfVRCGCGxn3o4BX/6cuyoAhi6ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyWIX82kq8DC0emG/IaxWxnMnOthTF1MPgM1+aE3YF0=;
 b=gWnB4yAUXVqVKTcVkKmSBBwQQmfuK8tnAO6TxGJMppM7rQ0k6RTp0cD9jE38/2LMlxafKrjH6aX38dqudit99gAJlFqXB+DYxwaPCxuhsi0CK8r0R3prxg0LKUBqPJLPOgRsCH9VLT5UI4nd3INUxfkAJBanjQkWHhcSctbTDtsfBYiqPlYoxQ1uGuaW7R+xzcvN3/jh0j+QYrAvDV9qgb1HEoWUENhUBhrvzaclm3m/F6Tu9IVSqXL/CqeUS7qy4LRQbQ2SwPTCN0qQo4iJjnL0WX1VYn2CwrDKtL7L0H6Y7D0IoR4XtIp0BPwe3ynux22vkJroLFgGQV3tqhhvWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyWIX82kq8DC0emG/IaxWxnMnOthTF1MPgM1+aE3YF0=;
 b=HYVsa+lNegdYqM8YY3S/qYFyuifr0cyvDzPxrKMykMeyzzYtkeFGYXLUo/HyDSUTVZi6/209Z9NQ6IFf85DS0VZ5RIYrdBDIUrIlW/m7a4V1iOZa8MbXhyqtP0IjERb5RTjyeFvcZU9kxFgOIStd+ZTjDGOWUwv/8Sc4d71xDGs=
Received: from BY1PR18MB6109.namprd18.prod.outlook.com (2603:10b6:a03:4a6::17)
 by CH3PR18MB5401.namprd18.prod.outlook.com (2603:10b6:610:154::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Wed, 16 Apr
 2025 10:07:10 +0000
Received: from BY1PR18MB6109.namprd18.prod.outlook.com
 ([fe80::8b06:27d0:59ed:cf27]) by BY1PR18MB6109.namprd18.prod.outlook.com
 ([fe80::8b06:27d0:59ed:cf27%7]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 10:07:10 +0000
From: Ankur Dwivedi <adwivedi@marvell.com>
To: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Jerin Jacob <jerinj@marvell.com>, Nithin Kumar Dabilpuram
 <ndabilpuram@marvell.com>, Pavan Nikhilesh Bhagavatula
 <pbhagavatula@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Rakesh
 Kudurumalla <rkudurumalla@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH v1 02/12] node: add IP4 lookup FIB node
Thread-Topic: [EXTERNAL] Re: [PATCH v1 02/12] node: add IP4 lookup FIB node
Thread-Index: AQHbrf+Fs3X6TSv5qUGx82844DNbWbOmCZMAgAAHCtA=
Date: Wed, 16 Apr 2025 10:07:10 +0000
Message-ID: <BY1PR18MB6109DAA6B3064709DD9ACCBBDDBD2@BY1PR18MB6109.namprd18.prod.outlook.com>
References: <20250415121052.1497155-1-adwivedi@marvell.com>
 <20250415121052.1497155-3-adwivedi@marvell.com>
 <13084ebf-0a1c-4d12-ba98-802494e00e21@intel.com>
In-Reply-To: <13084ebf-0a1c-4d12-ba98-802494e00e21@intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR18MB6109:EE_|CH3PR18MB5401:EE_
x-ms-office365-filtering-correlation-id: f4d596b5-62f1-4420-6c08-08dd7cce7398
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dFlEa1MxRnkvam5vUnNwcEhEZDFUTWplSFRWbGhrcnBFbzIyckMvbUNSV3FF?=
 =?utf-8?B?WlRUK1RKTkN6WDlKa1JBazdtd1R4enNHTDZzdGw3ZkRBUWpoY2wvVERRZWsy?=
 =?utf-8?B?QnVVS1FHZU4rZHI1ak5abEhQVXJ2Ly80ZGlOSlk0amYwM2xmNVM4eXJwUWwx?=
 =?utf-8?B?S0RPaGJrNTgvTVl1OWduK2Q1SUh6Q3hTS0pJZlFQS2xxTTZtd3I2eTlhSjFz?=
 =?utf-8?B?RnBUNDJLWUpNNGwzd2VMWlBTYVZQcmhQRnRDNm03TnJnL3V2RytWT29ZbzZa?=
 =?utf-8?B?OTYxeTlPem1PNVJ2eGk3WWtMUk9ZSU4xdGlSUWlTQVlZa1l3ekdHZUJuZHlQ?=
 =?utf-8?B?cjhnaEl1ajJXZGxpYnZKc0Y0L2hoZlFNdm41aWoydDJVQ3dYSU9hcHUzVnZq?=
 =?utf-8?B?TVh5OFViMXMwanhqMU10Qk02Q3AxbVRZQkY0c01xVlNvUm1hVGVESnlMS01q?=
 =?utf-8?B?TTZZL3FabGRNZ1R2b0FxNmxjSUlYSjBQd0xiUDZ1Z3RtUU5vam85UjNCWHE2?=
 =?utf-8?B?MWJKUU9FNC9NcHhFWUE2UDMxSFNXSCtLVWs3VjdJbEZOblIzQ2hvN08yd21l?=
 =?utf-8?B?cmdLVWt1T3J5SU9ZdGtEVjR5VUdMQnpxcUU5bkhoa0tIcmNWQTdDNFprc3Nk?=
 =?utf-8?B?WWI1dytOT3ZtcnJvYmtERGtsenZ2Z3ZacE5iSm5LdG11b0p4djZweUdnbWpG?=
 =?utf-8?B?RkQzemp6TkFmNFc1cGlUbDNwYVNwRHBVWUlncjBpbTJJS0dVdEdSMkpaT1Zh?=
 =?utf-8?B?UnRYb3Bnenl1cmh6ZklhUW1heVk2S3lrbkdqQi82dFJkTytCSVNQb3pCVVdG?=
 =?utf-8?B?NEdadDFxTzE3YnlaNDViVEVkUCs1U2pWWmFjL1MwUDRwRnQxOU5mU3hkVTc5?=
 =?utf-8?B?eXNqbC81d3g1TEFxRzBZbFNhVlBQKzFOUGxWTGMzWVhhdHhVUkdkOStvekI1?=
 =?utf-8?B?c0ZvWnk5RTRDTG4vRHhQSEdzblg0bmJPNUU1UVFFaTJlaEJKcERnNk1lcDZj?=
 =?utf-8?B?NXpOeWFMOXhDL2lDTzhpTTZLcmRHYnFFUTFQdWo5SHhxeTVCNVVhV0VrNENP?=
 =?utf-8?B?Vlg4WUhTZk1IR3ViL1kxWEZIR3VLVTdqQi9vWUQxMmI5LzROQ1dTaCtyMG1X?=
 =?utf-8?B?QTBoZEp6Q24xbXVhM1dLRzdCV2syTVVPSG1VNnUzZDJiY1JjQUlOZjliYnhV?=
 =?utf-8?B?OWNidHhMcG1QdTllOTdDVVRJWm9pck5WRjhBR2xiK1ZsOXZJSjY2VEsvWS9P?=
 =?utf-8?B?MllRVGl4TXZ5NWtuNVd2NXRzQzFWbStxc3hIS2JOc0dkZ2ljQnZGTFVkZGho?=
 =?utf-8?B?RThrcldUZDYrbEExcUdSaVVwaHdjYlBsUWRyRytta2c5KzhxMHlvcUQxbEVS?=
 =?utf-8?B?bGRpMlhYd3ZKU0pUVS9QZEV1Nm1TbWhlNnhxTkU4UjFGTFBTVWxBZGNrRnhJ?=
 =?utf-8?B?V040SklsRm1BZWQ3cDRqZ3FFNjZJSm1pZFVKVDlSRnlWbi9rN3R6T2hzVEFJ?=
 =?utf-8?B?bW04NzYzUmtteERxNk8wc1VWSHFBdDc5Z25zaG5IRlVjd0ZNVGE2K2FiUDlS?=
 =?utf-8?B?Smt6Q3hYdUxPOE9jeE9KZTRXN1AzaWFWQktvUE1WVXlFelJNcVYxazBicVY4?=
 =?utf-8?B?M0dEZVIrcXJIeTZFQmhUS2V5TlkvQWswaEs4N0xKY0dIQ3hGUGViT3RIMmVt?=
 =?utf-8?B?QTE1UTZPb2t1R2JkNWF1N2JBTjMyZTRpc3lEVlYzaUZXWmxRRVF0R0VGcEhF?=
 =?utf-8?B?eXdGb1BLMkFMZFFsaUJMT25ydlRBSHkrdlA1ZGtyRkg4YkphUWtVVldsR05L?=
 =?utf-8?B?cTNBVTVFblFIQy9ZVGFRZnZ5UlNsYnRNVGZ5ellWUXVaMEdQa2ROMXNqZGlz?=
 =?utf-8?B?UUROcWE0aXRyVThBUFVyaExjTDl4UWo1WW9rNDRiZ1JwL1FsazNqMExubnFE?=
 =?utf-8?B?dkUvZERxNTVrYTJ2NEthZ0tSdU5nNHJxdmRJbUJWdGxMSlhJUmF0ZER4aysx?=
 =?utf-8?B?M1QzK1dpNld3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR18MB6109.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2ZSUGlwbnVlSW1MTFlSTnd2a3JNWnVuZEM0NnFBK2wzWlpPeGhFczZyM1dF?=
 =?utf-8?B?UDJQaURLM3BQZFlyMWVOZkFBVU05SE8rcVN6NmJSUXF3N1hhWFFpTzJRVjdB?=
 =?utf-8?B?T1ROblcwT1B6QUh4Tm1qQUtmK2tjY2JLNzgyd1QweWtLaUxPUTJVVU05dkxG?=
 =?utf-8?B?U2owcmp3dHlwVG5SNFhjWkJwUVdGRGp3cTFyUE8zbUtYRTdNZ0FhUzl6MTBC?=
 =?utf-8?B?NVB4RE9uVGNONU9MS0VRd2VkaVhqcWJHSjlqTXJReml2d21xS1A5UnRQU0NJ?=
 =?utf-8?B?akQzTkl1TzJiSWdtZnVTb2xIUGk0MVd1QzJVbWJXUTNQSlFReTNhS3MwZmNV?=
 =?utf-8?B?THpucjZNcG0yUlBJZG9namh4Z1JGU1VaK1dXYWhmTkVUR25ZekhyakkxNnJ6?=
 =?utf-8?B?OS9zTmU5VlVuS1ExR2tJQ1Q2WnBzQXI3Wk11ck05T0lzaERxYXEzSmNZcEtQ?=
 =?utf-8?B?T1N0RGhwK3RWNWVQSm5sanVqemt1dW55cWVNUi9VOS9aekZSY1o4eWRwUUo3?=
 =?utf-8?B?bVM1YU1mTzhoMTNEaG5ISFpVTG5qZ3UzZ3FzWmwrd3hvWnVkMFBFMFhWUjVE?=
 =?utf-8?B?OUhSTGpaUllxNUhMZFVMd1dyeDdMZEZUbTRUVFk3T0pzbGw1azEvQ3RNN3l3?=
 =?utf-8?B?Q3AvanVPWnFJdXZEcVdBeFkraDNWdGQ2clBRQ0Y3OWU5S2NxbEZnaUhwTnRU?=
 =?utf-8?B?emExcXRZOTdvalR3NnN3dWhLMDNGTmo3dzMrbzZtVklKQkdRTWFQSW1RUWtx?=
 =?utf-8?B?WjRmeitvZ1NVNlE1T3lwY3NlYVNodW5EODhnNFc1WTZIbW5UQm04Y1E1NFMw?=
 =?utf-8?B?RVJiOXJDcUx0WmpjUFlYUnU2Tk1RcTBIZnFvSmZPZXJ2bUNIR3R2NVRJeVVI?=
 =?utf-8?B?QXdwMXBvTTNEZmIrbndoVGVwQzhPbm81eGZBOGdIQTBmdzJOc2RLeTd3RmR6?=
 =?utf-8?B?ZXpuRmZFWGxGUlQwWHdySzNkRlNVcjZicVVSRHpadTYxY2NFai8wRXJndTdl?=
 =?utf-8?B?UmpIYlJFanhSVkl2d1AydHJHSXFZeDJEL2h0YTRHV0xqNWd1dnVmRHE1ZUVv?=
 =?utf-8?B?QW96djV5QVRpZ05FNU4ySHpOQ3VwRTlJYTMxdGJka2dmVkRBcldDck1obiti?=
 =?utf-8?B?WTVvRVlLWW1CcjQwOHJmd3NqL1BTelNHL3R4N3BwS2VrVzlFZU5vQ3J3Z05R?=
 =?utf-8?B?eVlGTDlSVmFSZmhQRmY5MFNXa1RTOVpNSitGZ2ZHb1BTNElueHhJdTd6cG5z?=
 =?utf-8?B?YmlwZ01TVjM4bkNoZUlmTDFzL3BXZEg2Y01rYno2RFlwa3lzZW44dVNHK1Fs?=
 =?utf-8?B?RVhUUmlnNElUUUxoVVdLU2wzUVhnZ0l2RnhPL0grSWRhblpwWXJDQVRNZWRm?=
 =?utf-8?B?KytCTHZXdEtWbnJlZzZpajFtcTh3LzArYUQ3YWNVM2ZPK3NzOW5RL3lRN0FT?=
 =?utf-8?B?Q2JYaXF6NUg0My9PdlhobVdtNDNGNkw2UHg1WVdmUHpHbGtnWUVxYjhISUhu?=
 =?utf-8?B?UkR6OTFHaC8wN0pJVitIQXNuNEtCeTJPcnNMR3ppWFYyN1gxc1RvdE5xNjVW?=
 =?utf-8?B?Z3M5TXZBOFYrYlZCY011a0ozUVZYdEFZcVhFVVJDOS8yS2pCbWVqeTZ3bWpO?=
 =?utf-8?B?elllN1VEVmM1bFM1aVEyUHNoUUFSTG9KWEJsMWx0KzJVYjV0eHAvaHJvR3Mz?=
 =?utf-8?B?aTI2ZXJQYnBhNDNrSWtZcWJhVG1FeHNoTCt4RlF0clRnQ1ZxcVRaRGFnWFlO?=
 =?utf-8?B?SUtlR2lSSFk5YUlFbFk1S3pGSnNhaG1hWVJCSjNNcXBqWnIyVU5FS25LUmdD?=
 =?utf-8?B?QS9MajVTbGNLazJ0clQ4TUFkOHF2MEVwa1R2Y1k1a0paZ0dETmVYYkxXQjZ1?=
 =?utf-8?B?T1VScVJLU3VIZ0NESVU2OUF3R1lBVVM3ZitZR0UvNzE2NkRtWkNscVYxOWZV?=
 =?utf-8?B?L3d1eE55d1FCSGJucmdjOUlWR3haWnJObmhwYWxDMlRsYXRDSEV0U0xBNXRU?=
 =?utf-8?B?Vkh1aHpMc0hWcjZCNjhxUVJ2RVNoejk4SkQrVFd0SjlxTWdYci9CUjZkTDNr?=
 =?utf-8?B?OVVuNWphMktGYmVMTVI4c3FDeE9kT3dFN0pJaytnbVBXU1AxcWdqbkVOVmxk?=
 =?utf-8?Q?CkzPY/HkBDg/WCPTvRtLLiYI7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR18MB6109.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d596b5-62f1-4420-6c08-08dd7cce7398
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 10:07:10.0764 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +yyn0WIRnKJkWRacaKzXZZ+7YftMMnxPBVL9lwDwh+2HmLPvtTnt4cFIVLSRpx5/zD/Ai2usHiB4DVXHj3z4pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB5401
X-Proofpoint-GUID: dig-fXFgiFFjgT2Ws52Nw6gz98cjizpA
X-Proofpoint-ORIG-GUID: dig-fXFgiFFjgT2Ws52Nw6gz98cjizpA
X-Authority-Analysis: v=2.4 cv=ZobtK87G c=1 sm=1 tr=0 ts=67ff8152 cx=c_pps
 a=Dwc0YCQp5x8Ajc78WMz93g==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=snM8vsJKssn3_vXY6iUA:9
 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_04,2025-04-15_01,2024-11-22_01
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

SGkgVmxhZGltaXIsDQo+T24gMTUvMDQvMjAyNSAxMzoxMCwgQW5rdXIgRHdpdmVkaSB3cm90ZToN
Cj4+IEFkZHMgYSBsb29rdXAgRklCIG5vZGUgZm9yIElQNC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBBbmt1ciBEd2l2ZWRpIDxhZHdpdmVkaUBtYXJ2ZWxsLmNvbT4NCj4+IC0tLQ0KPj4gICBsaWIv
bm9kZS9pcDRfbG9va3VwX2ZpYi5jIHwgMTI3DQo+KysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysNCj4+ICAgbGliL25vZGUvbWVzb24uYnVpbGQgICAgICB8ICAgMyArLQ0KPj4g
ICAyIGZpbGVzIGNoYW5nZWQsIDEyOSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+PiAg
IGNyZWF0ZSBtb2RlIDEwMDY0NCBsaWIvbm9kZS9pcDRfbG9va3VwX2ZpYi5jDQo+Pg0KPj4gZGlm
ZiAtLWdpdCBhL2xpYi9ub2RlL2lwNF9sb29rdXBfZmliLmMgYi9saWIvbm9kZS9pcDRfbG9va3Vw
X2ZpYi5jIG5ldw0KPj4gZmlsZSBtb2RlIDEwMDY0NCBpbmRleCAwMDAwMDAwMDAwLi45YzcxNjEw
NzE4DQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9saWIvbm9kZS9pcDRfbG9va3VwX2ZpYi5j
DQo+PiBAQCAtMCwwICsxLDEyNyBAQA0KPj4gKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBC
U0QtMy1DbGF1c2UNCj4+ICsgKiBDb3B5cmlnaHQoQykgMjAyNSBNYXJ2ZWxsLg0KPj4gKyAqLw0K
Pj4gKw0KPj4gKyNpbmNsdWRlIDxydGVfZXJybm8uaD4NCj4+ICsjaW5jbHVkZSA8cnRlX2V0aGVy
Lmg+DQo+PiArI2luY2x1ZGUgPHJ0ZV9maWIuaD4NCj4+ICsjaW5jbHVkZSA8cnRlX2dyYXBoLmg+
DQo+PiArI2luY2x1ZGUgPHJ0ZV9ncmFwaF93b3JrZXIuaD4NCj4+ICsjaW5jbHVkZSA8cnRlX2lw
Lmg+DQo+PiArDQo+PiArI2luY2x1ZGUgInJ0ZV9ub2RlX2lwNF9hcGkuaCINCj4+ICsNCj4+ICsj
aW5jbHVkZSAibm9kZV9wcml2YXRlLmgiDQo+PiArDQo+PiArLyogSVA0IExvb2t1cCBnbG9iYWwg
ZGF0YSBzdHJ1Y3QgKi8NCj4+ICtzdHJ1Y3QgaXA0X2xvb2t1cF9maWJfbm9kZV9tYWluIHsNCj4+
ICsJc3RydWN0IHJ0ZV9maWIgKmZpYltSVEVfTUFYX05VTUFfTk9ERVNdOyB9Ow0KPj4gKw0KPj4g
K3N0cnVjdCBpcDRfbG9va3VwX2ZpYl9ub2RlX2N0eCB7DQo+PiArCS8qIFNvY2tldCdzIEZJQiAq
Lw0KPj4gKwlzdHJ1Y3QgcnRlX2ZpYiAqZmliOw0KPj4gKwkvKiBEeW5hbWljIG9mZnNldCB0byBt
YnVmIHByaXYxICovDQo+PiArCWludCBtYnVmX3ByaXYxX29mZjsNCj4+ICt9Ow0KPj4gKw0KPj4g
K3N0YXRpYyBzdHJ1Y3QgaXA0X2xvb2t1cF9maWJfbm9kZV9tYWluIGlwNF9sb29rdXBfZmliX25t
Ow0KPj4gKw0KPj4gKyNkZWZpbmUgRklCX01BWF9ST1VURVMgKDEgPDwgMTYpDQo+d2h5IG9ubHkg
NjRrIHJvdXRlcz8gTW9kZXJuIEJHUCBmdWxsIHZpZXcgaGFzIGFib3V0IDFNIHByZWZpeGVzDQo+
PiArI2RlZmluZSBGSUJfTlVNX1RCTDggICAoMSA8PCAxNSkNCj4+ICsjZGVmaW5lIEZJQl9ERUZB
VUxUX05IIDk5OQ0KPndoeSB0aGlzIHBhcnRpY3VsYXIgdmFsdWU/IEl0IGlzIG9rIHRvIHVzZSBt
YWdpYyB2YWx1ZXMgaW4gZXhhbXBsZXMsIGJ1dCBub3QgZm9yDQo+bGlicy4gQ29uc2lkZXIgc29t
ZXRoaW5nIGxpa2UgMCBvciBVSU5UezgsMTYsMzIsNjR9TUFYIG9yIHNvbWUgbWVhbmluZ2Z1bA0K
PnZhbHVlIHdpdGhpbiBncmFwaCBpbmZyYQ0KVUlOVHs4LDE2LDMyLDY0fU1BWCBzaG91bGQgYmUg
ZmluZS4NCkFsc28sIEkgYW0gdGhpbmtpbmcgYWJvdXQgdGFraW5nIHRoZSB2YWx1ZXMgaW4gZmli
IGNvbmYgYXMgaW5wdXQgZnJvbSBhcHBsaWNhdGlvbi4NCj4+ICsNCj4+ICsjZGVmaW5lIElQNF9M
T09LVVBfTk9ERV9GSUIoY3R4KSBcDQo+PiArCSgoKHN0cnVjdCBpcDRfbG9va3VwX2ZpYl9ub2Rl
X2N0eCAqKWN0eCktPmZpYikNCj4+ICsNCj4+ICsjZGVmaW5lIElQNF9MT09LVVBfTk9ERV9QUklW
MV9PRkYoY3R4KSBcDQo+PiArCSgoKHN0cnVjdCBpcDRfbG9va3VwX2ZpYl9ub2RlX2N0eCAqKWN0
eCktPm1idWZfcHJpdjFfb2ZmKQ0KPj4gKw0KPj4gK3N0YXRpYyBpbnQNCj4+ICtzZXR1cF9maWIo
dW5zaWduZWQgaW50IHNvY2tldCkNCj4+ICt7DQo+PiArCXN0cnVjdCBpcDRfbG9va3VwX2ZpYl9u
b2RlX21haW4gKm5tID0gJmlwNF9sb29rdXBfZmliX25tOw0KPj4gKwlzdHJ1Y3QgcnRlX2ZpYl9j
b25mIGNvbmY7DQo+PiArCWNoYXIgc1tSVEVfRklCX05BTUVTSVpFXTsNCj4+ICsNCj4+ICsJLyog
T25lIGZpYiBwZXIgc29ja2V0ICovDQo+PiArCWlmIChubS0+ZmliW3NvY2tldF0pDQo+PiArCQly
ZXR1cm4gMDsNCj4+ICsNCj4+ICsJY29uZi50eXBlID0gUlRFX0ZJQl9ESVIyNF84Ow0KPj4gKwlj
b25mLmRlZmF1bHRfbmggPSBGSUJfREVGQVVMVF9OSDsNCj4+ICsJY29uZi5tYXhfcm91dGVzID0g
RklCX01BWF9ST1VURVM7DQo+PiArCWNvbmYucmliX2V4dF9zeiA9IDA7DQo+PiArCWNvbmYuZGly
MjRfOC5uaF9zeiA9IFJURV9GSUJfRElSMjRfOF80QjsNCj4+ICsJY29uZi5kaXIyNF84Lm51bV90
Ymw4ID0gRklCX05VTV9UQkw4Ow0KPj4gKwljb25mLmZsYWdzID0gMDsNCj4+ICsJc25wcmludGYo
cywgc2l6ZW9mKHMpLCAiSVBWNF9MT09LVVBfRklCXyVkIiwgc29ja2V0KTsNCj4+ICsJbm0tPmZp
Yltzb2NrZXRdID0gcnRlX2ZpYl9jcmVhdGUocywgc29ja2V0LCAmY29uZik7DQo+PiArCWlmIChu
bS0+ZmliW3NvY2tldF0gPT0gTlVMTCkNCj4+ICsJCXJldHVybiAtcnRlX2Vycm5vOw0KPj4gKw0K
Pj4gKwlyZXR1cm4gMDsNCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIGludA0KPj4gK2lwNF9sb29r
dXBfZmliX25vZGVfaW5pdChjb25zdCBzdHJ1Y3QgcnRlX2dyYXBoICpncmFwaCwgc3RydWN0DQo+
PiArcnRlX25vZGUgKm5vZGUpIHsNCj4+ICsJc3RhdGljIHVpbnQ4X3QgaW5pdF9vbmNlOw0KPj4g
Kwl1bnNpZ25lZCBpbnQgc29ja2V0Ow0KPj4gKwl1aW50MTZfdCBsY29yZV9pZDsNCj4+ICsJaW50
IHJjOw0KPj4gKw0KPj4gKwlSVEVfQlVJTERfQlVHX09OKHNpemVvZihzdHJ1Y3QgaXA0X2xvb2t1
cF9maWJfbm9kZV9jdHgpID4NCj4+ICtSVEVfTk9ERV9DVFhfU1opOw0KPj4gKw0KPj4gKwlpZiAo
IWluaXRfb25jZSkgew0KPj4gKwkJbm9kZV9tYnVmX3ByaXYxX2R5bmZpZWxkX29mZnNldCA9DQo+
cnRlX21idWZfZHluZmllbGRfcmVnaXN0ZXIoDQo+PiArCQkJCSZub2RlX21idWZfcHJpdjFfZHlu
ZmllbGRfZGVzYyk7DQo+PiArCQlpZiAobm9kZV9tYnVmX3ByaXYxX2R5bmZpZWxkX29mZnNldCA8
IDApDQo+PiArCQkJcmV0dXJuIC1ydGVfZXJybm87DQo+PiArDQo+PiArCQkvKiBTZXR1cCBGSUIg
Zm9yIGFsbCBzb2NrZXRzICovDQo+PiArCQlSVEVfTENPUkVfRk9SRUFDSChsY29yZV9pZCkNCj4+
ICsJCXsNCj4+ICsJCQlzb2NrZXQgPSBydGVfbGNvcmVfdG9fc29ja2V0X2lkKGxjb3JlX2lkKTsN
Cj4+ICsJCQlyYyA9IHNldHVwX2ZpYihzb2NrZXQpOw0KPj4gKwkJCWlmIChyYykgew0KPj4gKwkJ
CQlub2RlX2VycigiaXA0X2xvb2t1cF9maWIiLA0KPj4gKwkJCQkJICJGYWlsZWQgdG8gc2V0dXAg
ZmliIGZvciBzb2NrICV1LA0KPnJjPSVkIiwNCj4+ICsJCQkJCSBzb2NrZXQsIHJjKTsNCj4+ICsJ
CQkJcmV0dXJuIHJjOw0KPj4gKwkJCX0NCj4+ICsJCX0NCj4+ICsJCWluaXRfb25jZSA9IDE7DQo+
PiArCX0NCj4+ICsNCj4+ICsJLyogVXBkYXRlIHNvY2tldCdzIEZJQiBhbmQgbWJ1ZiBkeW4gcHJp
djEgb2Zmc2V0IGluIG5vZGUgY3R4ICovDQo+PiArCUlQNF9MT09LVVBfTk9ERV9GSUIobm9kZS0+
Y3R4KSA9IGlwNF9sb29rdXBfZmliX25tLmZpYltncmFwaC0NCj4+c29ja2V0XTsNCj4+ICsJSVA0
X0xPT0tVUF9OT0RFX1BSSVYxX09GRihub2RlLT5jdHgpID0NCj4+ICtub2RlX21idWZfcHJpdjFf
ZHluZmllbGRfb2Zmc2V0Ow0KPj4gKw0KPj4gKwlub2RlX2RiZygiaXA0X2xvb2t1cF9maWIiLCAi
SW5pdGlhbGl6ZWQgaXA0X2xvb2t1cF9maWIgbm9kZSIpOw0KPj4gKw0KPj4gKwlyZXR1cm4gMDsN
Cj4+ICt9DQo+PiArDQo+PiArc3RhdGljIHN0cnVjdCBydGVfbm9kZV94c3RhdHMgaXA0X2xvb2t1
cF9maWJfeHN0YXRzID0gew0KPj4gKwkubmJfeHN0YXRzID0gMSwNCj4+ICsJLnhzdGF0X2Rlc2Mg
PSB7DQo+PiArCQlbMF0gPSAiaXA0X2xvb2t1cF9maWJfZXJyb3IiLA0KPj4gKwl9LA0KPj4gK307
DQo+PiArDQo+PiArc3RhdGljIHN0cnVjdCBydGVfbm9kZV9yZWdpc3RlciBpcDRfbG9va3VwX2Zp
Yl9ub2RlID0gew0KPj4gKwkubmFtZSA9ICJpcDRfbG9va3VwX2ZpYiIsDQo+PiArDQo+PiArCS5p
bml0ID0gaXA0X2xvb2t1cF9maWJfbm9kZV9pbml0LA0KPj4gKwkueHN0YXRzID0gJmlwNF9sb29r
dXBfZmliX3hzdGF0cywNCj4+ICsNCj4+ICsJLm5iX2VkZ2VzID0gUlRFX05PREVfSVA0X0xPT0tV
UF9ORVhUX1BLVF9EUk9QICsgMSwNCj4+ICsJLm5leHRfbm9kZXMgPSB7DQo+PiArCQlbUlRFX05P
REVfSVA0X0xPT0tVUF9ORVhUX0lQNF9MT0NBTF0gPSAiaXA0X2xvY2FsIiwNCj4+ICsJCVtSVEVf
Tk9ERV9JUDRfTE9PS1VQX05FWFRfUkVXUklURV0gPSAiaXA0X3Jld3JpdGUiLA0KPj4gKwkJW1JU
RV9OT0RFX0lQNF9MT09LVVBfTkVYVF9QS1RfRFJPUF0gPSAicGt0X2Ryb3AiLA0KPj4gKwl9LA0K
Pj4gK307DQo+PiArDQo+PiArUlRFX05PREVfUkVHSVNURVIoaXA0X2xvb2t1cF9maWJfbm9kZSk7
DQo+PiBkaWZmIC0tZ2l0IGEvbGliL25vZGUvbWVzb24uYnVpbGQgYi9saWIvbm9kZS9tZXNvbi5i
dWlsZCBpbmRleA0KPj4gMGJlZDk3YTk2Yy4uZDIwMTFjOGY1NiAxMDA2NDQNCj4+IC0tLSBhL2xp
Yi9ub2RlL21lc29uLmJ1aWxkDQo+PiArKysgYi9saWIvbm9kZS9tZXNvbi5idWlsZA0KPj4gQEAg
LTEzLDYgKzEzLDcgQEAgc291cmNlcyA9IGZpbGVzKA0KPj4gICAgICAgICAgICdldGhkZXZfdHgu
YycsDQo+PiAgICAgICAgICAgJ2lwNF9sb2NhbC5jJywNCj4+ICAgICAgICAgICAnaXA0X2xvb2t1
cC5jJywNCj4+ICsgICAgICAgICdpcDRfbG9va3VwX2ZpYi5jJywNCj4+ICAgICAgICAgICAnaXA0
X3JlYXNzZW1ibHkuYycsDQo+PiAgICAgICAgICAgJ2lwNF9yZXdyaXRlLmMnLA0KPj4gICAgICAg
ICAgICdpcDZfbG9va3VwLmMnLA0KPj4gQEAgLTM0LDQgKzM1LDQgQEAgaGVhZGVycyA9IGZpbGVz
KA0KPj4NCj4+ICAgIyBTdHJpY3QtYWxpYXNpbmcgcnVsZXMgYXJlIHZpb2xhdGVkIGJ5IHVpbnQ4
X3RbXSB0byBjb250ZXh0IHNpemUgY2FzdHMuDQo+PiAgIGNmbGFncyArPSAnLWZuby1zdHJpY3Qt
YWxpYXNpbmcnDQo+PiAtZGVwcyArPSBbJ2dyYXBoJywgJ21idWYnLCAnbHBtJywgJ2V0aGRldics
ICdtZW1wb29sJywgJ2NyeXB0b2RldicsDQo+PiAnaXBfZnJhZyddDQo+PiArZGVwcyArPSBbJ2dy
YXBoJywgJ21idWYnLCAnbHBtJywgJ2V0aGRldicsICdtZW1wb29sJywgJ2NyeXB0b2RldicsDQo+
PiArJ2lwX2ZyYWcnLCAnZmliJ10NCj4NCj4tLQ0KPlJlZ2FyZHMsDQo+VmxhZGltaXINCg0K
