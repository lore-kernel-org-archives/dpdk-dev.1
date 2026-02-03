Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C681AE8782C
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Feb 2026 14:00:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F0F96402D9;
	Tue,  3 Feb 2026 15:00:45 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id E5031402BE
 for <dev@dpdk.org>; Tue,  3 Feb 2026 15:00:43 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6137D9p22429832; Tue, 3 Feb 2026 06:00:43 -0800
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021101.outbound.protection.outlook.com [52.101.62.101])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4c28pe4rca-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 03 Feb 2026 06:00:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FTceGq+WZKVuAstxMU9tW1kH458VEO3BnLPmNdCyn5d+4Pfyo46Byoo971QBoOyklYe+MGgHtd0Uv3Aq0DG4VBRXsOuJx2e3Yh9tkjctC8ILLAwbSgH+56nfvswT/y8FsQOI3xeHav6BkhAQTSqj1NxSfQrOxu24wdyM134YQQ3hG1w+SOJ2XY7RqVDSLI32wAHEVazqZeAptk2L3NdJvmsuiX2XetocvAh/WdCbTzA9bUJ61Ng4SnJqBYPB2RZgxo1WukQ//WegoOm3fINQIR7sYcE9AfHMuTd0a11OQLv30Pl8iNKCQpZvz9xjF78hCx6oImdRm3VN4sw1t1lQAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfrI7Fei26TDHiLquoGD7MAgxn5tSbcYkws/r12YMCA=;
 b=y44d8nzel/olLE0zxYSzT2Y2s2t8g8R5ouzovvEwtBbCTjjj0eI8QCUsULCzDq2g+mGxnxZc5hUBR6o6kGwnfnHK2GTm5dbhaOOALFBaiW+6XZZv141g8JgAxLp83VQ3msqw3++QcZFAUsXa7BtDR2WHJuzL/3FqYP17q+uMRhNiK1KQrHbZ1GXqKgHoaXKB5j/Z2a7YqyYoALoO+HYsrhE8El8Sdelf4Mn1Lob8HPEqULx7M/PG2aNEShEERVFXadCJFFWzTDOapCVkMekRs9wm5XKTWAkJNNq2sx45L0QBoNAKBy/16TUWQGDV67TELYx7re8aGrvHWAtlt1aIzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfrI7Fei26TDHiLquoGD7MAgxn5tSbcYkws/r12YMCA=;
 b=fFbGFh1+8SJtMLAZ/h4Xb8Boa+gFi/shtLAcLv0JGCYPiD91KWdYE3R5XDdROX9sAo8kpcisNZlHIC8mXcchMugnHsEQS3UnoxXUpesKQptd6e6HoAVlOin4uZSnLVSo4xOZIoW2rab63SUEA0FReD2sQIQOSw7Ln5cyvnlzM5s=
Received: from IA0PPF0A466555A.namprd18.prod.outlook.com
 (2603:10b6:20f:fc04::c09) by MW5PR18MB5809.namprd18.prod.outlook.com
 (2603:10b6:303:1a8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.3; Tue, 3 Feb
 2026 14:00:36 +0000
Received: from IA0PPF0A466555A.namprd18.prod.outlook.com
 ([fe80::b876:8173:5121:dc8f]) by IA0PPF0A466555A.namprd18.prod.outlook.com
 ([fe80::b876:8173:5121:dc8f%6]) with mapi id 15.20.9587.010; Tue, 3 Feb 2026
 14:00:36 +0000
From: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
To: Radu Nicolau <radu.nicolau@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "kai.ji@intel.com" <kai.ji@intel.com>, Anoob Joseph <anoobj@marvell.com>, 
 "stephen@networkplumber.org" <stephen@networkplumber.org>, Akhil Goyal
 <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>
Subject: RE: [EXTERNAL] [PATCH v8 2/2] test/crypto: add tests for 256-NxA4/5/6
 algorithms
Thread-Topic: [EXTERNAL] [PATCH v8 2/2] test/crypto: add tests for
 256-NxA4/5/6 algorithms
Thread-Index: AQHclP4ta8s3v2tUcU+HIv4+4tt/tbVw9Gug
Date: Tue, 3 Feb 2026 14:00:36 +0000
Message-ID: <IA0PPF0A466555AE5D010CDDEED665738CFC99BA@IA0PPF0A466555A.namprd18.prod.outlook.com>
References: <20260107105649.1708347-1-radu.nicolau@intel.com>
 <20260203111338.183138-1-radu.nicolau@intel.com>
 <20260203111338.183138-2-radu.nicolau@intel.com>
In-Reply-To: <20260203111338.183138-2-radu.nicolau@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PPF0A466555A:EE_|MW5PR18MB5809:EE_
x-ms-office365-filtering-correlation-id: a8ff8f3f-28d8-4b7c-b1c3-08de632c9af6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?UThla2pBcU8zQzJSZWJtWlArVHFEK1dYc25IZmkvNGlZQ1hKL1ZxTS9iRlJt?=
 =?utf-8?B?T3pyMEFiS0xBNStLSk1XR0M3S1BPR2dlR2MyRXJWckVyeFludkUwNWEyRVlW?=
 =?utf-8?B?WFZKUlZabmN3QUt1REpiMGsxd2hVYzhVYmhRM0ZvZWE1N3ZmR3VvMDVFVDdI?=
 =?utf-8?B?d2o1VzFZa3NVbDNaT3c5WXMrb3kvZ3laSXNySndhajMzVTNOOVU1VTFXOEFD?=
 =?utf-8?B?dGZEdDNZc2NzTHQyNldpblJtZ2hkM0d5R1VIZFV3a2plRis0MDVBVDlsMytE?=
 =?utf-8?B?bWxlTVJBMEhRMTEwc3haNGdBT3hoL3Y1d2x5VjdOQlhNVFIvQnhWUVlLMWZl?=
 =?utf-8?B?cEsxMWNsU3p6M3FQQ08zL3VYODhkMkRING1VeGJNNVRVYkg1T1VTclIrTFRJ?=
 =?utf-8?B?LzNkb2pldER2b3hhSmNQQTJ4aUF0NGs0c0ZVUWJsME0zdVNiR1A2anphUy8x?=
 =?utf-8?B?V3lFcVk4TEFJZ3R6RncxYzhrYnljaklpUCtyK0luVmJLS0FWVTM0a1dhUnM5?=
 =?utf-8?B?L00zaGJwTmYrcE1Fbi95V1k1VVYvWWRhL0JqTWVJN0VQRlY3STJUK1VFTzY3?=
 =?utf-8?B?OTFtbmQ0S2VOTzVIM3ZsVkt3VGNDY3hzWWdJQ1o2eVZKU3picVRoeSt0amlL?=
 =?utf-8?B?ZnZUQ0VyQWVSM1lIWWt3OUI1cmV6UFp3S2xVNHdBemxINWo2YU8rWElCdmg4?=
 =?utf-8?B?eUhaZ2phclpBMGJuUXpxU2VaS2Q4d0llL1REaDdVamo0dHVRYkpJWWpBcHk1?=
 =?utf-8?B?SURMU0s2VEdZVE94dUJMRzZCNlMwTmZaMnN5c3oxblhncml1c3ZWclpMM1Uz?=
 =?utf-8?B?ckZzT3luR0ZjMXlVOEdVODlCcG9zQmNLSVRPR28wSjV6M09KaFltZnZ5R3kw?=
 =?utf-8?B?RmhESEJkNFhhbDlYck9xQU5RdlhzL1FVcWZxaUY4NXNpLzVWNjZGZk9ZQXV6?=
 =?utf-8?B?YTBnOTlzM3AyUHJ3dW9nQUFZVnVaanFadk9aMkdQemJKditFbTJVOVR6bVNL?=
 =?utf-8?B?MEt5M3RmcFUyVWM5OXU2VHZGTzhLanBXS1VIVmo0WmIrLzk1WmFkL1BXRnBS?=
 =?utf-8?B?WGc1a0luUFE2RjQxb1ExY0toOUVVMDNyTHNBL0greUxaQnhoYnBid25wR3BZ?=
 =?utf-8?B?V1Z3NWt5eHM1RFlaUjUxa1M1UmNMWDF2d0M0TXZvTnA1TE9tMTA2QkVEZmRp?=
 =?utf-8?B?cTFzTUNYVjcyNTNVWEpWSXV1ZGhPOFdZY0FWSEpuVEgwekloVmtoM2RRZ2dP?=
 =?utf-8?B?ZkE1UGdpWXFsRVc1V2hRTDZyejVBeWpyYUFKRmQ2eitxMnltY0QrU1I2bkc4?=
 =?utf-8?B?RmtGOWlDWjg0Ry9mTitRYU82eStUS0VPN0s0dVRoelNYMXdpQnM0VGM2aVRS?=
 =?utf-8?B?TmMvWE9QaHh0bzIvVzNmdk5oNzVQWHdpS096TU1XQ3lLWFpmSzhPZ3hQakIr?=
 =?utf-8?B?SVJWa3hKRnFNMklCSTFwS0tUV29kME42Mnd3MCtNYkN1SkduLzNkeHBKWTBN?=
 =?utf-8?B?Tk1lSFladC9lZ0oreGtvWm9Ec0pFU3IxUUd5ZnJKaGZ3MVVFWXAyUXVJT0xF?=
 =?utf-8?B?ZUVhU1N2NG9MQTlNc1Zlbkg4RkxGQ1pGMjJFU0hjdjllaWNKVFlZYUluU211?=
 =?utf-8?B?UHNrQ0k2U3FZTmVNYVB5WnNhUWYvOWdaU3ZLd0tvckhZM0c3eTV6VkNtaVF4?=
 =?utf-8?B?NktvVUJ2eXlRS1paeVh4UGdxOHhnWXlFVjBPdlM2cERvbGFJTnVITE5OMDc5?=
 =?utf-8?B?OEtVeGFBSURxQ21NNmNiMzkyZm5mS0xFSE1xdVVpWGgzekZuZ3BqL2RFd2dn?=
 =?utf-8?B?Ymk5d0FXdU5NUjc2WmhZUjVSVk1FdnZOd2xVRlRLWmhhQUFoYUNqZzV4Vm1s?=
 =?utf-8?B?Y0NhQjJRSUtheWtCdlo3OWQ2dEFTaklzM0JMSFJQMHExUlZDU2poSEtiYWdO?=
 =?utf-8?B?RjVIalo3RjVpQllzNUhiVWFleWF5elI0MG1iNm80eEE2cERLRExYT014dG8w?=
 =?utf-8?B?UUFxVEJZU0J6RWltQSt3ZlpTSmpzU2JiL3gzNTliYlBVNXlrTEVPcXMzalNP?=
 =?utf-8?B?ZVVqNWd2TzNMbXlNZG10Uk1zd21MbXFqNno2Q1BqcXd4dWY4dlNvUU5pc1FD?=
 =?utf-8?Q?7uTaF3GKcsKUOEy8e2oRFwPjO?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PPF0A466555A.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXhLOFhoMEczVHRBV1lMdHFDUWNpK0h0T21RNzZvTjdPTjFwRG1hQ3Y5dWt2?=
 =?utf-8?B?SncvaVBlT2poL1dKSHViSjI1czU5VHk0aTVObWZ4S2VqZFRGRENZd3BONEY1?=
 =?utf-8?B?YlMwOFlrVFRRd0s4VDlBSndTbWNaZWMrMnNSUlRLSG5zWGZjSGg3ZjNXMWs4?=
 =?utf-8?B?dEY5YXdRVUNGZkRQa3krZDh1VDN1eEFGUXp3N2xRUUlPTEVVRlRENlovQ2s5?=
 =?utf-8?B?cTd2azhmZ3FBa1BieHlxT1F1Vk9NQWs5ZTFZbldKOExGMjJXcGtnN0xoaGZB?=
 =?utf-8?B?dHllcVplTjQ2TFpRUDRDQVhCa09DcHRtQ0VhdFpubkNSbXp4SmpXaFRaNkFD?=
 =?utf-8?B?ZFZFdmk2eHRKM0xPSmFoazdBUzc0QmNKNzZVU29Bc1lpMmZBeXBUd0hEL0tq?=
 =?utf-8?B?ZFZTVUR5Wi8wUmNQemkxYkl2REJvTWNWMnYvMjZJekw5QVczUituWjM4Tkcx?=
 =?utf-8?B?RmhoZUE3SGRPdnhJREpURDI4WjJ6VW1jY1ROQnJHNW5kdHF0UXVac2h3WjR4?=
 =?utf-8?B?ZEZiYXJNSnBkYTI1Q280by8rcDdialFiMEh5SkE4Q1BYRXYyVXpab0hwTEIy?=
 =?utf-8?B?Q3o2bGpMOUR4cWhOeVR3V0VuMWZZTUZZWUNRNHIxTTVZd2tTWjMxbnBpdUZJ?=
 =?utf-8?B?a00reDAvSTJlVXdWeDVUaHFYNldMN1lQNDAyNUhDUW9zUWtYSDVodmd2eCtz?=
 =?utf-8?B?RUpzN3VWbSsxb1hiZ3YzdnlGck1ZU25MNWVzczFCc3BJbzZTNmVKbFlCL2dj?=
 =?utf-8?B?TjFkMEFoeU5vYm11ZHRMTGJBemVIYnBoYVRJQkdlWWt1SU42MDhGLzZENEJK?=
 =?utf-8?B?OGFOQ2V6R1NNM1hHZWlmUEp3NEdXclI4bzRyRTQ4Vkw3Tmk2UWJ2Z0FGVjB4?=
 =?utf-8?B?cmsraCtwdUlaNVVoNC91bGhmSjZmYm1qNXJnczdmQ09jSC96OWhVYmpqWHp6?=
 =?utf-8?B?UFNFZFRZVUNIVVNndmpjSlRCTUVLdW05TFZJdUwzVFpMN2JPVlJ4SGR0VndF?=
 =?utf-8?B?Rk53Z1pyRGRYc0FEUS9KbkEwQXRuUTc1NFBMQlN3b3kwSGxVWW5XQmtkMThC?=
 =?utf-8?B?S2hlWU9aOUtjN1pGZmRxZXVHQjZUSXRnL0Z6VURaSjF4bGNNbjl5NlpDb0lH?=
 =?utf-8?B?SDZSWjR5eEF6NElZNTU2dHdrTkQvdk1WaWFYa0Q2enp4M0l4VjlzbkhZbjZD?=
 =?utf-8?B?VVNvSE9sSWh6S0JhRHViR0Z2eWJjQ1hSNEprMkRxdEpBTlp4NDFHbkhlWkY0?=
 =?utf-8?B?czBDSCtlWE1GWE50aVoxcUhLdU1UcHRxOUVINXBxZTRoTW5VcWR4RFpQTjVS?=
 =?utf-8?B?NTNoQ0J2Z2U4VGt1aE92eDErWG4zLy9xbWVEOWgvUldQUnBlSG9vQ2lKZ2V5?=
 =?utf-8?B?ZUZtZ1JQMlovS2hUYy93K2dPVWx0TFM0cXllUzJPVnFVcmtxRGEvbmoyc1NZ?=
 =?utf-8?B?aUlOc1BLV0NZQmVod3IrRTVXemNtc2lxRWlUZkxjTUlQcEc5cUszTjF4ZDNC?=
 =?utf-8?B?dUNXcGhBYVNzWlFwOWkzdytJNDZJT2ZKdmQ1dnBMeElBQ0poZUhPSnVNTWh0?=
 =?utf-8?B?UFlYd2FKb0h2MncxWCtTa1lWN3FBdlFHOHgwQm1pM0JUNW8ySWpmY1U2T1lG?=
 =?utf-8?B?UCtRYnp3STk3QkxnZVBJKzVlMWtXNVEzREU2RXBJK0xVUExwRzg0MDI4TUkr?=
 =?utf-8?B?YzJwM0g0MmRxblAxSytTZHBMUExPcjNNMHFOdnA1Q1VRTlJGUzBCNDZVcUZu?=
 =?utf-8?B?NmVuVG4waVNic04raEZ2cEZ6cVpRTE5yRjdxQUZOL1d1UTNyZjB5bTVPbHM5?=
 =?utf-8?B?aFcwaHVNZU5VVjF0YWFLOTJHemIvRzEvMjZ5eFRwU211RXB2dmg3TW9ORHlQ?=
 =?utf-8?B?eExjNjVvZmpIRDZjdlQ2enVpaCtycHdQa2FNVWsyQmc2WVV3UmpXUHFnTmhG?=
 =?utf-8?B?U080RXNFNnhEcDNtcXZRWjV1d2pLZXZrakFERUdwYURuWTJEVFh1RzFxeTQz?=
 =?utf-8?B?ZjJrV3FUT1RFRXRINzU4ejluZHlzNmc5RnJESS9JWlFTWVFRbjFsTWdhUXE1?=
 =?utf-8?B?ZCt2WUthblJvaUZQQWE0emk5bStSbVJoMlpoT0RzV0l3c1NqbVRUaUdMM0RT?=
 =?utf-8?B?L0dPd0lTaG1EUjZmRW1TZ3hNYkxWOS9OV3FuRmkyVjExNmVsbTlXUEdGbnI1?=
 =?utf-8?B?bDBWNVRvMm40cUNVZitMSjJqVGJQaGIySE9JQTIyVFg0ZmsyUWs2RzFKN2JP?=
 =?utf-8?B?Zy9MSnVFREZwUExRMFVvUU1HdDJtU25ibUpERU1qMUh0MklXVDhVNkhkQjlm?=
 =?utf-8?B?S1pDL25WbHlsYm9wb0NFWUZkbHdqb2FtN1dYcm1aV2UzNHlsRERqQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF0A466555A.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ff8f3f-28d8-4b7c-b1c3-08de632c9af6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2026 14:00:36.2618 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4/Lqz3dyfC0ftwPnGNu/JDxo+Pxq9+j40Pe7fTrfit4/TP6uUKPt/aAqpcwC3VdYJmDQEtPA1u72LOyumo+rKG+8rSkjraeYolPf1wh5oWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR18MB5809
X-Proofpoint-ORIG-GUID: jSe0GPhMUkbNrY5X-pA2x5jXeWcGPa96
X-Authority-Analysis: v=2.4 cv=Y4/1cxeN c=1 sm=1 tr=0 ts=6981ff8a cx=c_pps
 a=vgafN4kwWYQEHO2M6PbBOA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=M5GUcnROAAAA:8 a=QyXUC8HyAAAA:8 a=8rWy6zfcAAAA:8 a=jZVsG21pAAAA:8
 a=pGLkceISAAAA:8 a=RpNjiQI2AAAA:8 a=Z7GHiSNUfUHmViNBfOcA:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22 a=3Sh2lD0sZASs_lUdrUhf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDExMSBTYWx0ZWRfXzA0TenZFZtig
 wrYjU96/Alr3Sm23j8BLDGzEhdHCxYV/6gaGJNIbyyk1FO8SC1t2DLl/NqJOcQpnVTOpK7XpR7v
 ZwFOQghUjE4wMxGhvBxTQtyG78tAnaoWWXGYhXKt/z2NLm74Vx4HlkT66aPnDvkdQP3lvHTAZpe
 j4KWCYzCw2JAfiJ7YUieJJUzc+3jI+MYOfP4TNDs5hDfUL4gEQy7sOvJwJQ5AeKcv/09rtpRSqD
 YvxDQq21gjRNlagraqt9zR8knP/EjBuVvvYyLYnaGJVZ/I3YL3jPXkcHs8D0E5c0/VRBCBdvpOM
 QhT0JorRB6ARD6PK357wc6JEvIlssRSGpVA27Yj82nozw5wzIEzqIvaP7FkmgwtA9Ur5nR98YhA
 /5jH6xQNX818vKk11MSzR5xCLfSOG0B0hkY0gDIlQIT5EFiIXa1okA2dhH6WHTMDGyK/fAHr/EZ
 vtOqD5DkA9DlcR0xQzw==
X-Proofpoint-GUID: jSe0GPhMUkbNrY5X-pA2x5jXeWcGPa96
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_04,2026-02-02_01,2025-10-01_01
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

QWNrZWQtYnk6IE5pdGhpbnNlbiBLYWl0aGFrYWRhbiA8bmthaXRoYWthZGFuQG1hcnZlbGwuY29t
Pg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFkdSBOaWNvbGF1
IDxyYWR1Lm5pY29sYXVAaW50ZWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBGZWJydWFyeSAzLCAy
MDI2IDQ6NDMgUE0NCj4gVG86IGRldkBkcGRrLm9yZw0KPiBDYzogTml0aGluc2VuIEthaXRoYWth
ZGFuIDxua2FpdGhha2FkYW5AbWFydmVsbC5jb20+OyBrYWkuamlAaW50ZWwuY29tOw0KPiBBbm9v
YiBKb3NlcGggPGFub29iakBtYXJ2ZWxsLmNvbT47IHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3Jn
OyBSYWR1DQo+IE5pY29sYXUgPHJhZHUubmljb2xhdUBpbnRlbC5jb20+OyBBa2hpbCBHb3lhbCA8
Z2FraGlsQG1hcnZlbGwuY29tPjsgRmFuDQo+IFpoYW5nIDxmYW56aGFuZy5vc3NAZ21haWwuY29t
Pg0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFtQQVRDSCB2OCAyLzJdIHRlc3QvY3J5cHRvOiBhZGQg
dGVzdHMgZm9yIDI1Ni1OeEE0LzUvNg0KPiBhbGdvcml0aG1zDQo+IA0KPiBBZGQgdGVzdCB2ZWN0
b3JzIGFuZCB0ZXN0IGNhc2VzIGZvciAyNTYtTnhBNC81LzYgYWxnb3JpdGhtcyBTaWduZWQtb2Zm
LWJ5Og0KPiBSYWR1IE5pY29sYXUgPHJhZHUu4oCKbmljb2xhdUDigIppbnRlbC7igIpjb20+IC0t
LSB2ODogYWRkIGxpbmUgYnJlYWtzDQo+IGFwcC90ZXN0L3Rlc3RfY3J5cHRvZGV2LuKAimMgfCA1
ODcgKysrKysrDQo+IGFwcC90ZXN0L3Rlc3RfY3J5cHRvZGV2X254YW5fdGVzdF92ZWN0b3JzLuKA
imggfCAyMDA2DQo+ICsrKysrKysrKysrKysrKysrKysNCj4gWmpRY21RUllGcGZwdEJhbm5lclN0
YXJ0DQo+IFByaW9yaXRpemUgc2VjdXJpdHkgZm9yIGV4dGVybmFsIGVtYWlsczoNCj4gQ29uZmly
bSBzZW5kZXIgYW5kIGNvbnRlbnQgc2FmZXR5IGJlZm9yZSBjbGlja2luZyBsaW5rcyBvciBvcGVu
aW5nDQo+IGF0dGFjaG1lbnRzDQo+IDxodHRwczovL3VzLXBoaXNoYWxhcm0tDQo+IGV3dC5wcm9v
ZnBvaW50LmNvbS9FV1QvdjEvQ1JWbVhrcVchdGkzWjFmOFVZbldhOUctDQo+IGNtZjA2RDNuc3JC
X3h6V3ZQcHFUT1pmeGFHX2l3SVp3WG5ZTUFBcVFpRkZTYzdqejNGY2g0U3hEd0ozcmpCRg0KPiA1
M1QzbW9MUkJ1QS0xQXhjVFBRWC0tJD4NCj4gUmVwb3J0IFN1c3BpY2lvdXMNCj4gDQo+IFpqUWNt
UVJZRnBmcHRCYW5uZXJFbmQNCj4gQWRkIHRlc3QgdmVjdG9ycyBhbmQgdGVzdCBjYXNlcyBmb3Ig
MjU2LU54QTQvNS82IGFsZ29yaXRobXMNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFJhZHUgTmljb2xh
dSA8cmFkdS5uaWNvbGF1QGludGVsLmNvbT4NCg0KDQo=
