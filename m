Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568D9CE8D6B
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 18:38:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D1A4402A0;
	Mon, 17 Nov 2025 19:38:52 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 70F994028B
 for <dev@dpdk.org>; Mon, 17 Nov 2025 19:38:50 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AH1pLRP1846094; Mon, 17 Nov 2025 10:38:49 -0800
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021088.outbound.protection.outlook.com [52.101.62.88])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4aftde1tah-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 17 Nov 2025 10:38:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IiPfpRKzDv2G2Ks5oaH1DDJZpIVdrRLLsURFtQ26jvBE5vbp7wYQ7q9cBW/Oh/BZNJslrYx68QTMmiuBf1km/3P9FgRxyd3Knx+1o0c42SZrQEqhMU+00G8Hn1+c9jiceq5vTkXpD62U5t5FJTYiCm0YlxgwLd1bpLoHptlw8pZTDVhnptMmms+aM7E0D501zKAzInWF/zs8uD0+LgxfDODkpdk68ImHlqiEUFpw2WVxG+dyphYh9uIxtvmXX3p58ZwKSHhwa0VjHtzp1HPymgF2G0PButGFS8Q69kr9t+kao6eQyWpzusdmWlDIEXMuaOOGQrAFSbVmZvpuNl2ILA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cTd/LyetwEStlDkTQ8mJwrvXwpncUPSh2X/WNeoStfM=;
 b=yWPzByE/ABVZx+cl4p/Zt8Uhc567TfOQiFt1tAhNNF6VUAVl59YFflW5S2meeCBm6W/7N+p789HZtMwRxyF0SOgWldgXf+NaKR1n3WUSf62/CIhP/YQdOzHI44TLWH49fVGGDr2ulKTM3xOE1QGkgloAMWKsvkXxh10ePpkrk6KphhAOSJBUCoDFEo5AdXTLOGh2KZoJWks+6PzDTpAAOXT17xYrevoEoXBLCkYkNj+fcJul3eGg2/RPBrjZettmw674bApAnoWTy9MTsUjStpGCE/3u20eGOOaXOCCVchEuujfGt1rmgRDKC7M0SqDUhVZdw4JFSIrxEICXSFw5HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTd/LyetwEStlDkTQ8mJwrvXwpncUPSh2X/WNeoStfM=;
 b=uShUm/sEN8pp2xBVD/H4RjCowg/vuZWz0hCTAjmO8xL4oOkt6NDFTSYWXgdoZMNucocvejuIRoANRFygJcBvnndENT/YaXRI7SqyoJsyFDErZ4vkXwKoRh6gvlBE6m83vcrl6SaZ9wLcqTArhdA/EPELPbfpQ2Ahmt1XXj49QvQ=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 BN9PR18MB4185.namprd18.prod.outlook.com (2603:10b6:408:136::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 18:38:46 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%6]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 18:38:45 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Shaokai Zhang <felix.zhang@jaguarmicro.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "kai.ji@intel.com" <kai.ji@intel.com>, Joey Xing
 <joey.xing@jaguarmicro.com>
Subject: RE: [EXTERNAL] [PATCH] crypto/openssl: support AES-XTS operations
Thread-Topic: [EXTERNAL] [PATCH] crypto/openssl: support AES-XTS operations
Thread-Index: AQHcV8AH6DyciOxA0ESd4lunUWPgf7T3MwbA
Date: Mon, 17 Nov 2025 18:38:45 +0000
Message-ID: <CO6PR18MB448463107AEDC7323E799F53D8C9A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20251117124414.1839-1-felix.zhang@jaguarmicro.com>
In-Reply-To: <20251117124414.1839-1-felix.zhang@jaguarmicro.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|BN9PR18MB4185:EE_
x-ms-office365-filtering-correlation-id: f626f20d-a890-4846-6983-08de26088a90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?S3dQQ3F4WDIrUUlqaWtKMHFvd0Zzd0xqTTRSM0dmdWRNUmdzWGJ5VmZxbk05?=
 =?utf-8?B?Qmxja1hDNnJtU2ZqeVJKZUpuV0FjNzkyTElVNGl1QTFsRXhINUliaVdkYTZ3?=
 =?utf-8?B?cFFQYmthckhuV1Y4RWFMcm5sa2kxWFl5SmZHMGtZY1BiOXVOVXo3cHpFWWpO?=
 =?utf-8?B?Y1YwWklOMmkvMk43YVZaOWQvQ2gxNllJcEIrdUNBNkpQRUhjbHRadUlNWjAw?=
 =?utf-8?B?d0lRV0RiaUtreDZzamRmZHpNMUdRRXJmU0FhcVdXcjQ5ZStmcURrVU41RlFn?=
 =?utf-8?B?c1hodk1jU3crTFpNS2t2UXZtN055RDZWOXVoRllWTklyY0VQWmNkd2F1MlNn?=
 =?utf-8?B?M2wxRzg0SXdoV3dSUEVOUloxUk52czdubFQ0cUc5QWhHbGowQzh6bGkyUy91?=
 =?utf-8?B?N0RaYnZBTEpncHdkV2pZcGNQSlZjSnlkZ2Qya1IrdGowbENKNVVuVE1MQjlG?=
 =?utf-8?B?dXp5c1NkbzBFUG8zV3pTeXFUV0NhQUlGRHFCa01FOGF2WDFwaTZSZVFRWm52?=
 =?utf-8?B?Z0V3bXVLVEZhdjZHU0x2akVML3l1blcwMDhmT1lKaUQxcVVtYkw2WURLWTl6?=
 =?utf-8?B?MlNFWmlNbTlJUHF3VmtGY0xDYzg1M29pNlpramM4SzJDNi8rTWh2RzB3ZVQ4?=
 =?utf-8?B?VEhhVWpHcmp5TjlkNEhjL3dFZWhpMElYUHhsWENMdktBNGJwdEhSai9Na1lo?=
 =?utf-8?B?YnIrUkc5UG04emJqQ0JpVzZLSzc1ekdvaFlybGoxQmdOdFVKSEZKdXZpbGM0?=
 =?utf-8?B?VkJpd2Z0WUNWUTBFTEF5WHlwajhhcmNhalA0Z3pQWEgvZnJ6NWNRcndQR2xz?=
 =?utf-8?B?SXFUZ2NlVkdQNndJUTRURmRGbzNwNjM2VnByZ2dSK3J5WjBOWUEvdndYeTFm?=
 =?utf-8?B?bkdDbk9PVS9WWVo4QnhvMGNPN2hjbWg5UzNicURMeGhaMjBBdDRGK2R2T01t?=
 =?utf-8?B?eWlxd3Q3cmF5dDZORWFGcGdpUERGL2QybXQ4aHhJR3Q2T3VxMFl5bGFXV21N?=
 =?utf-8?B?K3RVZGRoeHdEQWlkMDhOT3Y5R3ZVR0dQM0ErMnNNOTd3cDhKYjBzM3JQWmNo?=
 =?utf-8?B?Ky9pR3N6NitRcnYyaWwwYyt5dHAreXRIVmo3eHZIVHh5QmlBQ0tJU1BiZ0xw?=
 =?utf-8?B?Y2xHTmZ6bkNyY2dGT2JUSVBmUnp5Nm41Q01jbkV2RGU2QUVyM2ZOS1BQc1Bw?=
 =?utf-8?B?WE5kWTJXalpqNGkvTWJnZmRRcjFscmtTL01iaFBhTHhXSXRYWHB1TzQxenY1?=
 =?utf-8?B?RjhVNDdjQmVZRDJMa3lpRTB1TUsyTTNiZXVsSWNTR2FoWC9IVXN4U2RyVXMx?=
 =?utf-8?B?T3hOb3VydkQzL0c2WFA1ZjQ3LzFkaXJDZDlHRmsrOE5kZVBjVi9BSXFYejNF?=
 =?utf-8?B?TWt4LytIY05XakRCWE5ZbVRIc1UwQlB6Zlo4ZkJXSnczVWVEZ3paWEZHN0J6?=
 =?utf-8?B?STJGYSt3LzcyQVh2LzdTZFVSSnlnWER0QzltbTVwNnczQnk0Q1NFZE1ReG90?=
 =?utf-8?B?WEU4VkFEZlR3UXR6aWEzdmk4MU12WnMzZTNPV085QVg5alBVOGpPSlNSZUQ5?=
 =?utf-8?B?V2dtaXBMRThtSCs4Nm1uRTNtYXFOMWtTRzRWR05iUDFVREE0MFl0VkVvVElH?=
 =?utf-8?B?a3JsUUhJT1ZEY3ZERFphLzE0Y3VlMTVQU2tMdkFPZnZNUWRzOXRmc1pOSHVa?=
 =?utf-8?B?ZXlkcXlncHU4cmF4SG9lZzZpZ0UwL08wcVVYZ2x0MlB3eWtwd2lES1E1Z0Iw?=
 =?utf-8?B?N0NDcUM2dk9mWjU0Q2o4UmNUMTNsd2ZVRVZHVDJpbE1VUXo2UzNtaXNnUzlL?=
 =?utf-8?B?NzVYVGpWYVJLU09OUGhSSjJoWnZ1dDVXWFFkb2kwZVdudGVCWFh1NDdaM28x?=
 =?utf-8?B?NzhhNlU5OGRXQ01HSmEvQThZOFNzNVdaUWl0U25mRFY1SXdPMXFESVNlTXMr?=
 =?utf-8?B?SnJjcUo4SDNQS3QzVzFLcHpiQlVpRHdQTjhVVUl4VWxJWDlYaTRjVlRVQ29O?=
 =?utf-8?B?ZXlINGdPMFU1cE1IVk5oK2Yxc1F0WUY1RlRXRnpPekVPai9pYmhaWjRSd0lL?=
 =?utf-8?Q?9/EsFF?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzlTTm9wblRzblVTZlFlWXBiWVQ4Lzk0UjhtYkRMSDQzc1NQbHRkbENJSzc5?=
 =?utf-8?B?YlhLR2hkZkpjbENRdldsTjN3NHFNdkpuSVZBbUs4V1dqa3AyN1F4M0QzNUhp?=
 =?utf-8?B?UUVNQ2ZWSkwya0xQKzFHWFcxQXBRdDRPRWUyUFVzVXkyLy9qN0RVSUFwNHRk?=
 =?utf-8?B?anZNbFMrdWxIaTNVUkFCU0VkcURoZmhrZ0liSk54em44Y0NXcnQ5VDJEVXlj?=
 =?utf-8?B?eTFyMFdsTWI0S3N0MjNUWno5UTUvZWNMVEM3cUROZ1V2dVhiK0VnSFBoTVN2?=
 =?utf-8?B?OG9rVlFhYjRwTVBCdXpiN3Q1Z1VYTlhGT0VHY3hiWlR1UGFYQnpBSlZ4RFJk?=
 =?utf-8?B?NXJ0N0RsQ0R6M0ZaNGJmNzhuMVJNREtVTEkzOStKRmpvZk9Vb0NFcVVFR1Bt?=
 =?utf-8?B?ZlNWM3RXSmlxZUUvbkFiZ0lyZWxsM0xtb202ZHdWQWpTMU5FY1AxSXF3Y05z?=
 =?utf-8?B?SlkrbW80SitzaysxMHpYSGQ3L1VLZlNNbjRuYy9LdERUL2o0WmZ2dUQvMnZs?=
 =?utf-8?B?QXZIS2w1bGZ0bGx1TDJzYkdVekNrQUxyYW5tOXY1M0NuTmk0VjhNTmxKK0Mv?=
 =?utf-8?B?Qk52czY4MkdyQzBSWjhmTllQcng2QTFkb2I2YUpWVXk3b1ZUb3JYME5HZlY2?=
 =?utf-8?B?VG9pelh3TEhCWm5yMDRYSzFPaWxxZWRQZEpvOC9qMmpQaFE4VU0zSTJyN05K?=
 =?utf-8?B?M1lrcXlTQTVPMmdXQm8zVXdTWVVLb0xaelZ2WlZWcERHdytlKytzaWtFNmUr?=
 =?utf-8?B?QXVnMlVoNmNPR1RlTDROSmJJa0QvTjcrNWtxK3RtTlhHUVR2UDU4dlVpa1Zx?=
 =?utf-8?B?VUwzMUFLcUJ1a3VzMElTTWxWdUY5ZVNEWVJhUmpBSjVZdU5PMWN3SG9jRTNm?=
 =?utf-8?B?M0h0Y0VlQ3RZVFpoSnI2VHBLcW1ncFNVcjBrcU5mbUVvRFo1KzBXdllielcy?=
 =?utf-8?B?RXBsT3F0VmNKeXBMbEdxMHQ4M0FsSlBUV0EzczRLa0FjZDFvTEdIalZXQnBk?=
 =?utf-8?B?WDJiZE1pSkVZUWgyNk45WjdyZmljbFFsYUoxTE9FdFYrUXYwdWhHaklFMHJT?=
 =?utf-8?B?bElIMWtTaVRBaTVyaXlsdlZGVFJmeU43LzQyREVkK1FLTG9ITVBHRituTVlp?=
 =?utf-8?B?cTFyZW5NNUdOeVd6c2FmV2dLZnpjRjBZWnBIUUZTcTkyMGtmeThXRmw0ejl2?=
 =?utf-8?B?RkVlblpBMk1mUU9aRWVKcnNIa3ozREw5Y3FISGtBc3VmNzhCWnlJZWJJT1ZL?=
 =?utf-8?B?ZFpzWGlRMVM3RmtmOXhiZmhXaUNqRmZ2aVRvaG15QlUzYW56bW1YWXJNNjRU?=
 =?utf-8?B?UUlKV1FKMjAwS2d2clVKQ1pEckdNNW16YythbnVxZ2tEWkM0ODllZExEUm5B?=
 =?utf-8?B?MXd3RG5idU5iS1A1ZWowU09uREZsRGpvdHg4eFkzQlpvWkM1ZU0rOUtrSlVP?=
 =?utf-8?B?YW1wUjdKeDRKY2JQSnhjOWNodmhYKy85ZG5KZytQN1NyQUoydjR0YUFYbkFW?=
 =?utf-8?B?V0dEZGZvb2pVSm4xTHZQYjZKMjBXWkQ2eGNBSnB2aGxJZXhHYTdxZDNLN3Fs?=
 =?utf-8?B?YjArVzFJWWNhaVk4MElPa0w4UjgxSGVWTVBZT1JxRloxaFZqUTZ3eDJ1bHVv?=
 =?utf-8?B?WkhKUWR1eDlLZ1hBU0FsSk81dStWQ1M5V0J5OUl5RzdTNFVOZzVsTnViaHdT?=
 =?utf-8?B?MUtCVkhRR25COWhLdW9VTzIvQ3pLemYvR3pVbGpvUHplUXBvaDdjSUloQ2NP?=
 =?utf-8?B?YkFqa2hwUTZTUlgwK0VncU14cTAweTRvVmcvbStXeWZXVDZVNmdyT2EwbDBo?=
 =?utf-8?B?T3NDS2tManZ4bUxoZnVlQ0tMQ0tMOXpIenVtcHcwcHkwei9naW1jaW1ENVBC?=
 =?utf-8?B?MUJObjZGS2dON3dqU0hGUUorOWlieTVDSmdMdVBVUE8vRDlMK3FQMFJTTXk2?=
 =?utf-8?B?Ni9oVW5EaCsvdi8yeFFMR0VjbW9WTWRKR3ZJZld2eUFudU9hL3NQU0tiTDJz?=
 =?utf-8?B?SXFQTUM5N0tCTnJxK2tVQ3BRZ3hKdk95aHVqZElxVW5qZEJFTG5NL2Z0R3Yv?=
 =?utf-8?B?Q2RLYjNOSjBTei9qZWNOckNqdzNjK1ZQZVdkS0h0UDRhL2VGL2VjdUpQdEdU?=
 =?utf-8?Q?9DP3p8r1nrhylhl6g8SVPAd+s?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f626f20d-a890-4846-6983-08de26088a90
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2025 18:38:45.9475 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1AVrxYw8jAWsl2l2V6W6isbFwhaDMOSb6ifdqmVUIws5QYO805nENjKDz9sVA219dWTaBDek/wC0M3PXnlBiAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR18MB4185
X-Proofpoint-GUID: ZtnbDP1J63iRpTfYp5RkOMtDml03HsYI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE3MDE1OCBTYWx0ZWRfX495Wzu4lagBJ
 aiYYPnUeGXck2KZtBhCNiPWayHu3BkKlYXOfYiLaG02NMmF4/HywfEGBg5HP1j8WfFBzhd62jIx
 Ji5VpPl7UOesUQsW/wioPSJxTIRHKblN6QX/cd+r+0ytPTWHZjRWk7FgOVlBNq7qhHL1O0mYjm7
 u7XO6uVnt+rin9i+GYw3GkETaqIrPGXqD6/O5Z6cakpjNFj/EiKdkKzcHrniBfu8xlkPWFEizdQ
 aQZQ1gXpHfWL8cxekwL7AV3wVoHHIdaJvcF7/qsPwezLNYIpkl+oEtQwIpwVTeqISoidVSrGRca
 GWJc9fXZ90kKCBmuX2gO3U87sg1dmi02SFxWF9T6y7PpVp/tXwWWc4l0UKXsC0wm4rYCK262Qbz
 QltmvCagyR4hmlJdSBd1/htUzNRA1A==
X-Proofpoint-ORIG-GUID: ZtnbDP1J63iRpTfYp5RkOMtDml03HsYI
X-Authority-Analysis: v=2.4 cv=GqZPO01C c=1 sm=1 tr=0 ts=691b6bb9 cx=c_pps
 a=cooaqHSabeYmkmrBM5QRww==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yacp4PbrAAAA:8 a=5Rv4Lrqt1Sjgd2XG6B4A:9 a=QEXdDO2ut3YA:10
 a=V3FWeFeR7HlZ9tVNOp1k:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_03,2025-11-13_02,2025-10-01_01
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

PiBFeHRlbmQgb3BlbnNzbCBjcnlwdG8gUE1EIHRvIHN1cHBvcnQgQUVTIFhUUyBvcGVyYXRpb25z
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU2hhb2thaSBaaGFuZyA8ZmVsaXguemhhbmdAamFndWFy
bWljcm8uY29tPg0KPiBSZXZpZXdlZC1ieTogSm9leSBYaW5nIDxqb2V5LnhpbmdAamFndWFybWlj
cm8uY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvY3J5cHRvL29wZW5zc2wvb3BlbnNzbF9wbWRfcHJp
dmF0ZS5oIHwgIDIgKy0NCj4gIGRyaXZlcnMvY3J5cHRvL29wZW5zc2wvcnRlX29wZW5zc2xfcG1k
LmMgICAgIHwgMTMgKysrKysrKysrKysrKw0KPiAgZHJpdmVycy9jcnlwdG8vb3BlbnNzbC9ydGVf
b3BlbnNzbF9wbWRfb3BzLmMgfCAyMCArKysrKysrKysrKysrKysrKysrKw0KPiAgMyBmaWxlcyBj
aGFuZ2VkLCAzNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCkRvY3VtZW50YXRpb24g
dXBkYXRlIG1pc3NpbmcuDQpUaGlzIHBhdGNoIGlzIGxhdGUgZm9yIGN1cnJlbnQgcmVsZWFzZS4g
V2lsbCBiZSBkZWZlcnJlZCB0byBuZXh0IHJlbGVhc2UuDQoNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2NyeXB0by9vcGVuc3NsL29wZW5zc2xfcG1kX3ByaXZhdGUuaA0KPiBiL2RyaXZlcnMv
Y3J5cHRvL29wZW5zc2wvb3BlbnNzbF9wbWRfcHJpdmF0ZS5oDQo+IGluZGV4IGZlODllNTIyZTEu
LmQ1YTc1MTYwMGEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY3J5cHRvL29wZW5zc2wvb3BlbnNz
bF9wbWRfcHJpdmF0ZS5oDQo+ICsrKyBiL2RyaXZlcnMvY3J5cHRvL29wZW5zc2wvb3BlbnNzbF9w
bWRfcHJpdmF0ZS5oDQo+IEBAIC0xMTgsNyArMTE4LDcgQEAgc3RydWN0IF9fcnRlX2NhY2hlX2Fs
aWduZWQgb3BlbnNzbF9zZXNzaW9uIHsNCj4gIAkJLyoqPCBjaXBoZXIgYWxnb3JpdGhtICovDQo+
IA0KPiAgCQlzdHJ1Y3Qgew0KPiAtCQkJdWludDhfdCBkYXRhWzMyXTsNCj4gKwkJCXVpbnQ4X3Qg
ZGF0YVs2NF07DQo+ICAJCQkvKio8IGtleSBkYXRhICovDQo+ICAJCQlzaXplX3QgbGVuZ3RoOw0K
PiAgCQkJLyoqPCBrZXkgbGVuZ3RoIGluIGJ5dGVzICovDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2NyeXB0by9vcGVuc3NsL3J0ZV9vcGVuc3NsX3BtZC5jDQo+IGIvZHJpdmVycy9jcnlwdG8vb3Bl
bnNzbC9ydGVfb3BlbnNzbF9wbWQuYw0KPiBpbmRleCA0ZjE3MWY0OGNjLi4yZDgwMzkxMmQ0IDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL2NyeXB0by9vcGVuc3NsL3J0ZV9vcGVuc3NsX3BtZC5jDQo+
ICsrKyBiL2RyaXZlcnMvY3J5cHRvL29wZW5zc2wvcnRlX29wZW5zc2xfcG1kLmMNCj4gQEAgLTIx
MSw2ICsyMTEsMTggQEAgZ2V0X2NpcGhlcl9hbGdvKGVudW0gcnRlX2NyeXB0b19jaXBoZXJfYWxn
b3JpdGhtDQo+IHNlc3NfYWxnbywgc2l6ZV90IGtleWxlbiwNCj4gIAkJCQlyZXMgPSAtRUlOVkFM
Ow0KPiAgCQkJfQ0KPiAgCQkJYnJlYWs7DQo+ICsJCWNhc2UgUlRFX0NSWVBUT19DSVBIRVJfQUVT
X1hUUzoNCj4gKwkJCXN3aXRjaCAoa2V5bGVuKSB7DQo+ICsJCQljYXNlIDMyOg0KPiArCQkJCSph
bGdvID0gRVZQX2Flc18xMjhfeHRzKCk7DQo+ICsJCQkJYnJlYWs7DQo+ICsJCQljYXNlIDY0Og0K
PiArCQkJCSphbGdvID0gRVZQX2Flc18yNTZfeHRzKCk7DQo+ICsJCQkJYnJlYWs7DQo+ICsJCQlk
ZWZhdWx0Og0KPiArCQkJCXJlcyA9IC1FSU5WQUw7DQo+ICsJCQl9DQo+ICsJCQlicmVhazsNCj4g
IAkJY2FzZSBSVEVfQ1JZUFRPX0NJUEhFUl9BRVNfQ1RSOg0KPiAgCQkJc3dpdGNoIChrZXlsZW4p
IHsNCj4gIAkJCWNhc2UgMTY6DQo+IEBAIC00OTMsNiArNTA1LDcgQEAgb3BlbnNzbF9zZXRfc2Vz
c2lvbl9jaXBoZXJfcGFyYW1ldGVycyhzdHJ1Y3QNCj4gb3BlbnNzbF9zZXNzaW9uICpzZXNzLA0K
PiAgCWNhc2UgUlRFX0NSWVBUT19DSVBIRVJfM0RFU19DQkM6DQo+ICAJY2FzZSBSVEVfQ1JZUFRP
X0NJUEhFUl9BRVNfQ0JDOg0KPiAgCWNhc2UgUlRFX0NSWVBUT19DSVBIRVJfQUVTX0NUUjoNCj4g
KwljYXNlIFJURV9DUllQVE9fQ0lQSEVSX0FFU19YVFM6DQo+ICAJCXNlc3MtPmNpcGhlci5tb2Rl
ID0gT1BFTlNTTF9DSVBIRVJfTElCOw0KPiAgCQlzZXNzLT5jaXBoZXIuYWxnbyA9IHhmb3JtLT5j
aXBoZXIuYWxnbzsNCj4gIAkJc2Vzcy0+Y2lwaGVyLmN0eCA9IEVWUF9DSVBIRVJfQ1RYX25ldygp
Ow0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcnlwdG8vb3BlbnNzbC9ydGVfb3BlbnNzbF9wbWRf
b3BzLmMNCj4gYi9kcml2ZXJzL2NyeXB0by9vcGVuc3NsL3J0ZV9vcGVuc3NsX3BtZF9vcHMuYw0K
PiBpbmRleCA1MDk1ZTZjYmVhLi5kZjVjMTI2MjZkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2Ny
eXB0by9vcGVuc3NsL3J0ZV9vcGVuc3NsX3BtZF9vcHMuYw0KPiArKysgYi9kcml2ZXJzL2NyeXB0
by9vcGVuc3NsL3J0ZV9vcGVuc3NsX3BtZF9vcHMuYw0KPiBAQCAtMjY5LDYgKzI2OSwyNiBAQCBz
dGF0aWMgY29uc3Qgc3RydWN0IHJ0ZV9jcnlwdG9kZXZfY2FwYWJpbGl0aWVzDQo+IG9wZW5zc2xf
cG1kX2NhcGFiaWxpdGllc1tdID0gew0KPiAgCQkJfSwgfQ0KPiAgCQl9LCB9DQo+ICAJfSwNCj4g
Kwl7CS8qIEFFUyBYVFMgKi8NCj4gKwkJLm9wID0gUlRFX0NSWVBUT19PUF9UWVBFX1NZTU1FVFJJ
QywNCj4gKwkJey5zeW0gPSB7DQo+ICsJCQkueGZvcm1fdHlwZSA9IFJURV9DUllQVE9fU1lNX1hG
T1JNX0NJUEhFUiwNCj4gKwkJCXsuY2lwaGVyID0gew0KPiArCQkJCS5hbGdvID0gUlRFX0NSWVBU
T19DSVBIRVJfQUVTX1hUUywNCj4gKwkJCQkuYmxvY2tfc2l6ZSA9IDE2LA0KPiArCQkJCS5rZXlf
c2l6ZSA9IHsNCj4gKwkJCQkJLm1pbiA9IDMyLA0KPiArCQkJCQkubWF4ID0gNjQsDQo+ICsJCQkJ
CS5pbmNyZW1lbnQgPSAzMg0KPiArCQkJCX0sDQo+ICsJCQkJLml2X3NpemUgPSB7DQo+ICsJCQkJ
CS5taW4gPSAxNiwNCj4gKwkJCQkJLm1heCA9IDE2LA0KPiArCQkJCQkuaW5jcmVtZW50ID0gMA0K
PiArCQkJCX0NCj4gKwkJCX0sIH0NCj4gKwkJfSwgfQ0KPiArCX0sDQo+ICAJewkvKiBBRVMgQ0JD
ICovDQo+ICAJCS5vcCA9IFJURV9DUllQVE9fT1BfVFlQRV9TWU1NRVRSSUMsDQo+ICAJCXsuc3lt
ID0gew0KPiAtLQ0KPiAyLjQ3LjEud2luZG93cy4yDQoNCg==
