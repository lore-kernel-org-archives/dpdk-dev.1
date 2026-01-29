Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1605D3F083
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 04:29:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECEDE4026F;
	Thu, 29 Jan 2026 05:29:27 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 5905A4026A
 for <dev@dpdk.org>; Thu, 29 Jan 2026 05:29:26 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60SMJPeP2901028; Wed, 28 Jan 2026 20:29:25 -0800
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021112.outbound.protection.outlook.com [52.101.62.112])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4byu4s0qbt-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 28 Jan 2026 20:29:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4SiK6M26qtS3kE9KB789xcT8MnW+VqkFaG6ILueh3lugFp0d1FKiOCOavbVl8q5GpVNsCHtddsOocMn2kQiA3Gyf2nt2TFKWJC9zS2IErK+/4+AykdphHp7ppfXVCAV/P4OFeJX405/9VYBEl8zFTNwiSFF599S4cJlBnNFvxEMl2NAVljVvgLPltWH7wpPc11MQ/laPUPxDH0+ZRYyvPotZBZR5ADOtUieKk/f8FCgngUjOJXRIka7xCKFlognSTcS6mV0VaLeec8VDULMP6CVPMePjSn49CAuAyBV3OOTFzAcPe/QXGXuoUZOoG9g632J9Lzflsr+xZcn9EJJFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5uu3r11FbVfGR/i/fo5KH3VzX4uI0ejgxcRMyCEwc0=;
 b=S6Ev/gJE+HeAG1L9dDyecVBhLsF6Mh/KPIGSrmq7w6ZIxCm4UPuPBADbJwpmZKSmA2jdrZwbAs2fhpRNSZsjDEomglpDVDSc5u8uLjgnB4RTE68Ppth7I1lZfDzam//BCLnsA2LG0QhfNwhaue2TD0RyjXL7f0G2+5CyRhJz94c4I5kN2Uspa1nELvug/TWzdiJheZmpZ9A8CHCZYjVtuL5rT1kW1gSts2JAYX3t4j9uKsraUPJxZnHpV002G73PowBnlJqWRlPgCQtL9EBLSYxeApHztgaS0JiGXxBSM3QkqUWx8X3+LUXo0uHkz92/wyUeoxio3v/nxMLaExXzuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5uu3r11FbVfGR/i/fo5KH3VzX4uI0ejgxcRMyCEwc0=;
 b=uwSiBB6EAq7IiqRf6tXqXxrqd5EQp5ErurGsWIrVkgcTQR9jV/WAwASZZDh6AwAc42aESNtrisXTbstSoBeciDSBHRLXkes342K/rDrDnHqGL9fwTNqm7W2sv6SjWJSkay4SZaUnRcHJAYzI9JQ6qJ2t1I8AF+t0k8skiDzEFLw=
Received: from IA0PPF0A466555A.namprd18.prod.outlook.com
 (2603:10b6:20f:fc04::c09) by CH0PR18MB4241.namprd18.prod.outlook.com
 (2603:10b6:610:b8::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Thu, 29 Jan
 2026 04:29:23 +0000
Received: from IA0PPF0A466555A.namprd18.prod.outlook.com
 ([fe80::b876:8173:5121:dc8f]) by IA0PPF0A466555A.namprd18.prod.outlook.com
 ([fe80::b876:8173:5121:dc8f%6]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 04:29:23 +0000
From: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
To: Radu Nicolau <radu.nicolau@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "kai.ji@intel.com" <kai.ji@intel.com>, Anoob Joseph <anoobj@marvell.com>, 
 "stephen@networkplumber.org" <stephen@networkplumber.org>, Akhil Goyal
 <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>
Subject: RE: [EXTERNAL] [PATCH v6 2/2] test/crypto: add tests for 256-NxA4/5/6
 algorithms
Thread-Topic: [EXTERNAL] [PATCH v6 2/2] test/crypto: add tests for
 256-NxA4/5/6 algorithms
Thread-Index: AQHcjGbRTREdzw7Xr0adGp5n7iQp+bVolEHw
Date: Thu, 29 Jan 2026 04:29:23 +0000
Message-ID: <IA0PPF0A466555AC43CDC59B840C5A5A384C99EA@IA0PPF0A466555A.namprd18.prod.outlook.com>
References: <20260107105649.1708347-1-radu.nicolau@intel.com>
 <20260123124958.2855963-1-radu.nicolau@intel.com>
 <20260123124958.2855963-2-radu.nicolau@intel.com>
In-Reply-To: <20260123124958.2855963-2-radu.nicolau@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PPF0A466555A:EE_|CH0PR18MB4241:EE_
x-ms-office365-filtering-correlation-id: 76ff056f-abaa-4585-96c7-08de5eeefa78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?MFFGMktHekRhMGY4Um55ZlAvOEs4ZEROT0FsK25LTVFOcUJ2SFNyb2IxLzI5?=
 =?utf-8?B?SUVsZkdkTWpuN2tVSWFzYmJNSVVPVVc5cjVPL0NuQ1dObW16bG1VaGZpcmdB?=
 =?utf-8?B?cSsyeHZIb0kycnFoZkwvY3lJajg2WWk3NTdrVlVHVFJKODdVOUZyQVNicE0z?=
 =?utf-8?B?RFdZTXVHbkliaHhVME9ZRjJzOHRnb1B3Zi9kMlk4dDUzZHIyeVB2ZlFucUlW?=
 =?utf-8?B?VVR0RVRRREY2ZUlDT3VnOG03SmdabENZSU85TlJKSU5ORTJueHczMXl6Z3Jh?=
 =?utf-8?B?aEhuRVVobTdycW0zUnBSZk5rbW1CUmd0dGxTOHR2d3FVKzFTSS9IY2pla0Ja?=
 =?utf-8?B?STk1cXNIRVh3SkdTVnFpZHU4V1FJK0NGSGEzbXVIUi9ia0hJekM3RXNMTTNv?=
 =?utf-8?B?czhLbHRCS0ErdDREZVVHVUxZeko2VUs2WDE3c0lNY3JtZWFVL284M0o3YS9T?=
 =?utf-8?B?SUpUUmlGU3YxbllQR0JKeVV4UnBrcnZhbFQ3YUd0amxQcG5iVEdyYlZ6STJD?=
 =?utf-8?B?RUhsd3BBTEZMRHV1SkI3V1NONXNnWDVjclhUU0xEYXV5OUFhK2FHTE92S3Vj?=
 =?utf-8?B?MXVKcUFmS01YM2NhR3F4Q3FLbmo0cm5qK0x3blVKWTZzNEhLdmRDZkl5Uy9E?=
 =?utf-8?B?dFR6OTlYK2g1UmovTFJuK1M0V2Y0WkJQbE9US0Fwb0FneUxGOEpTYTJycExV?=
 =?utf-8?B?dGJmM2N4WE1VTGMxTTljUitrTkNwbXFJM0tFbmJRSHRxQ2duSXM1V0duRDJu?=
 =?utf-8?B?T0Qxb2xMWW03TVNueElMaWg3NXBZNVV1ZEdNYkU2L3JTLzJmMklaTTV6Smh2?=
 =?utf-8?B?UndZeTVjcGMxaHVzM1NtNm9TdGlMV1JFWkFBYnZ3WWV4YXI1S3V3RTlTR0Fo?=
 =?utf-8?B?MkdGNzRhS3B4Y2tTNWRkUzZqUFQrMVZFUmhYZ05PUmk0aVFIVS9BaEpMZ2s5?=
 =?utf-8?B?aDM5b3BjOFNDWW5XQWtadCtLUWMrT09ETUNRRDI5STYyNVhhUnB0cm5TU3J5?=
 =?utf-8?B?MVhtWElDTXd5ai9ZOW9EV3RFYnQ4RHBUbTZnU3VTWWptczJGWU1BSVMwZm14?=
 =?utf-8?B?NkFXc20wWVlqUTlvSmRzdzFqQVYzZmNXNkpScEpmY3FhYSt3cjFDT1ZLajVs?=
 =?utf-8?B?blhRRlBQOGlsMS91OUVod2Yyc01DSjNDK0Z5WkxWNGpoTnBzbFI1T1dQOHpK?=
 =?utf-8?B?MjBmVWJBRWNOMFFvbFNDeGdWdUFlRmw4TVR6UHVRM0plRkw5WUF0UUdtQ3E2?=
 =?utf-8?B?Q1pOSFNBTGdiTkViNVBialhGUndnZitSUUxkVzF5YzAzUVJTMmRnRit5UGI1?=
 =?utf-8?B?WXhkZkMxb3oraUIzTS9XSGhNM3F3QlJaUWZlRWR2eFFzMEpkQXdkM2pKdVlv?=
 =?utf-8?B?Q09NeSsySzdSdjY4SHBpM2dFVlFPc3RHT3dlcis4bUljaERDWWhhcTRka0RF?=
 =?utf-8?B?SVVNN1lVck5ZandaODIxQTVUNG4yeHpDQXZ5eitHNUdVR29WVExOcEgwK2tZ?=
 =?utf-8?B?cXlIUlB0SzZTYVpXNnViMGpsM3RxK1hkMXpYZ3NMejVWa3M3VkE4dW1IaW9B?=
 =?utf-8?B?N1NkU0pSSXl5ZE1FRjhyaUVkSzNHVTg4RmNnRldjTXNsblRENzZvVjNQNWhK?=
 =?utf-8?B?RjkwWFFmQzFBL0VhdjFGcDNyOU5NamZQNTVYU0dSRktFUkRlUkx1N1p4N0kw?=
 =?utf-8?B?RjFaT0FRYkJWMnF2ZlRNYVN4NmhIeFplRW9qczFsQi83a084cEZOdll6UEFO?=
 =?utf-8?B?MTdLZ0VrNjFjUWZYZFE5UUoveFVxWExkSHQzMzdIWFFWMUw4RzFlc1BaWllT?=
 =?utf-8?B?TkRPRXk4RnRLbXkvbEt1ZzhhRy9aZVVFRHI5NG5mQUEzUGdlOVNPK2o2a3R5?=
 =?utf-8?B?NUd0Nk9NSll6SWFvcGptYlh4eE5uTmh1WTBtZUNGU1l5clVNSmQvZHVQWTRN?=
 =?utf-8?B?ZGRJMTB6d0h5dUY4NHJCSDdIMUJWMjJySUo2VHhFSTZNU2p3S25LODJxOS9C?=
 =?utf-8?B?ck1KTVNsNG93UmIvaUg3SEp6L3BtbGpWRWtmRWV5ZUpGZU1RT2p1NWlTK1FX?=
 =?utf-8?B?Ukg2bkxTQzBnekNmS3kxNlNFZnBuL3BKUEFLOFpnR21FSlI5WVhndnJWb3hr?=
 =?utf-8?B?UzdLWkRFNTljMlJ1OXNlVHdERVhwd2Rqa1ltcVZWbC9jVVFwd1JBWi9Vbzlt?=
 =?utf-8?Q?u6axXoN9NbuNTeKJzrricwA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PPF0A466555A.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmNzUm1xcURqR05LL3l1SFNXcFM2NWtMVzkyeEU4ZXFpNWM5OU05a0lKTC82?=
 =?utf-8?B?T2pXZy9VTWVqY3dYbk5zSkxiZkhkSGxxVHFibE82ZUNYTHBCZHhuTlRua2tt?=
 =?utf-8?B?UjBxUWp3VjVNbDhCL2NZMng0bjMwNTFHTXVxNXcwaHNCMTF0TUhjRnJNMXFj?=
 =?utf-8?B?Y3REVEpLN2lSWmFSTFUrbTdXbjRHT1R6U2JSbmE1blVnTm5ONUozZkg4bzY0?=
 =?utf-8?B?NnpMS09tc3B5cnNqWUFWcGU1Um41bnllMFFwdk51dHhyUktXUnJlc2tKNHda?=
 =?utf-8?B?TTZ5ZmNrR2FBWnZSbE9qazh5TGJHOUY2Ymwxcm16WitESlMvYngxclJiVlg5?=
 =?utf-8?B?NWJ3ZzUrZ2ZnT0NJRW5ER2NybTVzOU9TY3ovSE1wUm1DSHBHTkZHd3dDTERl?=
 =?utf-8?B?M2JPNmNLWHJ4Sm5aQWM3SzJQclFRMkt2R245L05RYVFJSTBOMHhyMHVLOEQ1?=
 =?utf-8?B?YVN3ZlFuMld3cjFVYWNyQUdTRXJhWFJ4VlNONlBOckZDZHNQdjhrS0UxdDZx?=
 =?utf-8?B?ZmJpanpRc1VDTzVLRHNUclJ0dnh3aW9xdVNEUDUrcGRxd0tCckptNGt2aHFr?=
 =?utf-8?B?QTdnSW5sQkFYWEJJMmx0U1RuYkFYSGE2S2M5OFZHWHVOd01sc0dhVUE2MTlY?=
 =?utf-8?B?clM0M3crNHNJdURPRE5TNHprYVk0VXFWeGszY0RpQ1dXejltRUVhejBVUGl3?=
 =?utf-8?B?WU02cy9mZXh1MndHdy9uNnBqK2RPTTFjZUk3QlFLRG9takdIejFWUlhWZDBZ?=
 =?utf-8?B?ajN5ODBCNjNia3IvRlhDTXJmbTdPcHhWNXBwV2sxakZGWHNaRUFpM1dSKzRm?=
 =?utf-8?B?VVR0UFAvSlF0OFQ1MWdONWtmZnVMTG1JbnhHVmQ2UFdvbEFxNkdHdVJNRG82?=
 =?utf-8?B?RGVYeFo2RTZyUWIyQ3FmZE5tRVphOHZHUHh0MkpHckRHZGo0cDEvNzBGRDVr?=
 =?utf-8?B?MVdycU5zOGljOWQ5T1lYOHk3akQwTm5CUmZzbGlIbHdOdlMzeS9BUjkzQmxs?=
 =?utf-8?B?SUs1V3RGc3dINldBTTlWcDBFejJqTG9ZR2Jya0pDMmZIajV4bUJ6OTRGSUMx?=
 =?utf-8?B?MkxsNWNiMW96S0xDVVJXTjVlcExINTI0aEFhUFVOV2drTE1kL0lZdmp1ZGhm?=
 =?utf-8?B?c2loMC9vWnBqWDhMUCs5OUY2YXJ2VmxYUW94NlQ3WGZURFhiUFVEWTNaeXBT?=
 =?utf-8?B?emc1aVgySUFrMVF2QWZNWUlmV1JLd25oOWVOZ2pSYzBtZzFYUFlIdkFzdUw1?=
 =?utf-8?B?OEFsVk5KQ0xtamlHaTBaRmFCYUdLL2dRbnRqMi9rVjFuRkZiSmJnTVB4QjQ1?=
 =?utf-8?B?N3lyeEVLeEo2U2xmQ2VrTzE4VWxFT045Ty90SW95SWNMcDFHZFpjNHQxT1l2?=
 =?utf-8?B?Z2FYUnJCcFY3aGlEcGNHZ2dudzZxTXJhYlNjOU1IVFNIcE5LZ1hYY0Y3TVVq?=
 =?utf-8?B?UG1BS2Myb1JERGoxVS82elRYdzh1anA4QUJqVFhYTTRUd2VHM3RmcFR2WGNu?=
 =?utf-8?B?c3RiODRIeEZDTVZqaTBXTkt6Qi9xMFdwZmp0UVc5VGNPeFc1bks1a0FDeFVw?=
 =?utf-8?B?TWVNQUNtZkZvSXJ6d0hpQmJZUjVPYml1amtoWWhyWkNDVFhhUFV4U3FJVjlW?=
 =?utf-8?B?bmhhTVQ5VGhOMVRTeWVkRS9uQWdsSGxodnQ4VVBRcnh3VUF1UzVOK3NzbSsx?=
 =?utf-8?B?bnc2bHV4ZldwOWFkT2lyQnJqb2JJNzVhU1JYSkJsYWVpOVVVWWRub3JsRXVz?=
 =?utf-8?B?TUNPZEZzSWI1VWkvbWx6ZUZjMTcybUdKdmxnaXAxY29zMGkyK3BQQ2RxMkJi?=
 =?utf-8?B?dk84T0orOGJXZ0QzNU5yVFBkd01HZ0hkRUxKM3VhVXQ4U3N5ZFNHbitSaHZw?=
 =?utf-8?B?NUV3RjFiTW1SMkcwSVl3eUFSYS9VS0FNeTdiTFZBNk54dGowZ3RDYTBCREk2?=
 =?utf-8?B?dzg2MDc2RjhjcGVsaFo3eDZETzdwd3lmbmJVSHZ2dzJtRlR2RVMxSDFtNVhr?=
 =?utf-8?B?STh0VnIydVJSYlFGTG9UWjFiNzFNb2djd2kwQ05sOUtPQVdjOEYrTW0raVpW?=
 =?utf-8?B?K0RFc2thdVBwRVVCWDJwVFF0MUlQVkdVa0lQbCswamV4Nmk4QzcvN21tRC9J?=
 =?utf-8?B?eXdLV05rUHVkQ29YaXpIeUNTd1ArMG45bTBxYzZ2SzVmNElEUDdFUlRsaTNp?=
 =?utf-8?B?SGQ0WFdvSkgxeGVMOE5HSE1lc09icVVrN3BQTlE4Q04wcllQRmVZMDRYRHZr?=
 =?utf-8?B?d2szcU40TjFkbTk2SG9XQ0hNZkdlNlpqL0NiNkRzaXkvMXZHY2xLa2tlNU9s?=
 =?utf-8?B?bzlQQzZsaDJ1MzZtbUFkcjZHL0N5THBzUHpBSXcyT2NveldiWEt6QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF0A466555A.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ff056f-abaa-4585-96c7-08de5eeefa78
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2026 04:29:23.0582 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V6uV9jQcVe+isLFF0fkB3JNaZXJ+sfM+9udskZsZHPytuXIw9KMQkhprTUSe1kFRsvDN5qkqA0tPlMSNuYpMuzbhoQQypHS5VuSfZ8qFCOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB4241
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDAyOCBTYWx0ZWRfX+H/4Rdoyv/Le
 WjwCKUVf+T+aR8ZtcTOfXxAbCY7e9tFUMudyAVOsGv3Hm/XcOW9wPx/7qZoBNKGlsdN40gScyt0
 9tRAZcl2T9DHYjKZcEZVE78NrmjfTZB8GL6t/0v9CQoMffE0hgsSlfv1ftNH0/6FU4MMVCl/gsP
 5lgvWU4VCflPTYQG40i4iTUg/5VSQi4Gcr/ZOk4B+6C2p1nEMToki6DnNLuq8hYh5CZrhDfKknr
 fTDqGb8l1gdNBXa//5ZSFBIvPRZwfwX0/lIGWayAU4RHzzB0614Q2z1NGbZ8jTrxXfzFKLD1vqC
 v5eQCjbISgYHRD3Eh3yn5ZVguAjPdsuFavp97RDC9GTH2XTY2ZwHf9e2H4TRRvpEUeCLurJVFNU
 TuysvekpCxmTZEJxS/rQLwH276FNUQDz9Xc0V9mt852FdyKMlRSoHT8K6wovivZGnDobkAEHRvZ
 uFhIlqbSdzU0z29VfIw==
X-Proofpoint-ORIG-GUID: bdv99zd0iA-tA7b__Zp2_9zY4WuPzEvy
X-Authority-Analysis: v=2.4 cv=XeOEDY55 c=1 sm=1 tr=0 ts=697ae225 cx=c_pps
 a=D81verZRVWLMjAELYjey2g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=unE7T35NAELyMbq_lK4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: bdv99zd0iA-tA7b__Zp2_9zY4WuPzEvy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_06,2026-01-28_03,2025-10-01_01
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

SGkgUmFkdSwNCg0KUGxlYXNlIHNlZSBteSBjb21tZW50cyBpbmxpbmUuDQoNClJlZ2FyZHMsDQpO
aXRoaW4gU2VuDQoNCj4gK3N0YXRpYyBpbnQNCj4gK254YW5fdGVzdHN1aXRlX3NldHVwKHZvaWQp
DQo+ICt7DQo+ICsJc3RydWN0IGNyeXB0b190ZXN0c3VpdGVfcGFyYW1zICp0c19wYXJhbXMgPSAm
dGVzdHN1aXRlX3BhcmFtczsNCj4gKwl1aW50OF90IGRldl9pZCA9IHRzX3BhcmFtcy0+dmFsaWRf
ZGV2c1swXTsNCj4gKwlzdHJ1Y3QgcnRlX2NyeXB0b2Rldl9pbmZvIGRldl9pbmZvOw0KPiArCWNv
bnN0IGVudW0gcnRlX2NyeXB0b19jaXBoZXJfYWxnb3JpdGhtIGNpcGhlcnNbXSA9IHsNCj4gKwkJ
UlRFX0NSWVBUT19DSVBIRVJfU05PVzVHX05FQTQsDQo+ICsJCVJURV9DUllQVE9fQ0lQSEVSX0FF
U19ORUE1LA0KPiArCQlSVEVfQ1JZUFRPX0NJUEhFUl9aVUNfTkVBNg0KPiArCX07DQo+ICsJY29u
c3QgZW51bSBydGVfY3J5cHRvX2F1dGhfYWxnb3JpdGhtIGF1dGhzW10gPSB7DQo+ICsJCVJURV9D
UllQVE9fQVVUSF9TTk9XNUdfTklBNCwNCj4gKwkJUlRFX0NSWVBUT19BVVRIX0FFU19OSUE1LA0K
PiArCQlSVEVfQ1JZUFRPX0FVVEhfWlVDX05JQTYNCj4gKwl9Ow0KPiArCWNvbnN0IGVudW0gcnRl
X2NyeXB0b19hZWFkX2FsZ29yaXRobSBhZWFkc1tdID0gew0KPiArCQlSVEVfQ1JZUFRPX0FFQURf
U05PVzVHX05DQTQsDQo+ICsJCVJURV9DUllQVE9fQUVBRF9BRVNfTkNBNSwNCj4gKwkJUlRFX0NS
WVBUT19BRUFEX1pVQ19OQ0E2DQo+ICsJfTsNCj4gKw0KPiArCXJ0ZV9jcnlwdG9kZXZfaW5mb19n
ZXQoZGV2X2lkLCAmZGV2X2luZm8pOw0KPiArDQo+ICsJaWYgKCEoZGV2X2luZm8uZmVhdHVyZV9m
bGFncyAmDQo+IFJURV9DUllQVE9ERVZfRkZfU1lNTUVUUklDX0NSWVBUTykgfHwNCj4gKwkJCSgo
Z2xvYmFsX2FwaV90ZXN0X3R5cGUgPT0NCj4gQ1JZUFRPREVWX1JBV19BUElfVEVTVCkgJiYNCj4g
KwkJCSEoZGV2X2luZm8uZmVhdHVyZV9mbGFncyAmDQo+IFJURV9DUllQVE9ERVZfRkZfU1lNX1JB
V19EUCkpKSB7DQo+ICsJCVJURV9MT0coSU5GTywgVVNFUjEsICJGZWF0dXJlIGZsYWcgcmVxdWly
ZW1lbnRzIGZvcg0KPiBOeEE0LzUvNiAiDQo+ICsJCQkJInRlc3RzdWl0ZSBub3QgbWV0XG4iKTsN
Cj4gKwkJcmV0dXJuIFRFU1RfU0tJUFBFRDsNCj4gKwl9DQo+ICsNCj4gKwlpZiAoY2hlY2tfY2lw
aGVyX2NhcGFiaWxpdGllc19zdXBwb3J0ZWQoY2lwaGVycywgUlRFX0RJTShjaXBoZXJzKSkgIT0N
Cj4gMCB8fA0KPiArCQkJY2hlY2tfYXV0aF9jYXBhYmlsaXRpZXNfc3VwcG9ydGVkKGF1dGhzLA0K
PiBSVEVfRElNKGF1dGhzKSkgIT0gMCB8fA0KPiArCQkJY2hlY2tfYWVhZF9jYXBhYmlsaXRpZXNf
c3VwcG9ydGVkKGFlYWRzLA0KPiBSVEVfRElNKGFlYWRzKSkgIT0gMCkgew0KPiArCQlSVEVfTE9H
KElORk8sIFVTRVIxLCAiQ2FwYWJpbGl0eSByZXF1aXJlbWVudHMgZm9yDQo+IE54QTQvNS82ICIN
Cj4gKwkJCQkidGVzdHN1aXRlIG5vdCBtZXRcbiIpOw0KDQpbTml0aGluc2VuXSBXZSBjdXJyZW50
bHkgc3VwcG9ydCBjaXBoZXIgYW5kIGF1dGguIEFuZCBoZW5jZSBhZWFkIGNoZWNrIHdvdWxkIGZh
aWwuIFNpbWlsYXJseSBpZiBhbnlvbmUgc3VwcG9ydHMgb25seSBjaXBoZXIsIHRoZXkgd291bGRu
4oCZdCBiZSBhYmxlIHRvIHJ1biBORUEgY2FzZXMuIFNvIGNvdWxkIHlvdSBzZXBhcmF0ZSBvdXQg
dGhpcyBjaGVjayA/DQoNCj4gKwkJcmV0dXJuIFRFU1RfU0tJUFBFRDsNCj4gKwl9DQo+ICsNCj4g
KwlyZXR1cm4gMDsNCj4gK30NCj4gKw0KDQoNCg==
