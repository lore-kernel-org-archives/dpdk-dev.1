Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39767CAC5BB
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Oct 2025 08:20:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 80030402A0;
	Wed,  8 Oct 2025 10:20:28 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 983C240297
 for <dev@dpdk.org>; Wed,  8 Oct 2025 10:20:26 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 597NnTtc017594;
 Wed, 8 Oct 2025 01:20:25 -0700
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11022123.outbound.protection.outlook.com [40.107.209.123])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49ncv0gvk6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Oct 2025 01:20:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SR/8e1v3jEpVAZtQO+JqVVAOdMve8EanDSzqb5eCfmoMKjVWjMIE3ThXt8jIfOKmXfDxtS6ZlniPscSv1SOXZzs/x1BrEIOWRxg2tXj23xSptwvAL/foYxEEEhyNkHWXtiXUM4PmqzxtJy+FLPLc78ULAhWOii12jFqonOlqUl1gAamc3LMHqtTqTtHlFKwo6tIjvNaeSdxJmbRu8D4PtxQV3wBO0qYTNm5lSxjAxlH3MIa1gn9vodA6SWIknMMMHEUlDrM6UQEkZu+R6DaBZ80ohxJlRgutHD4PgLOmoUUecL4peR+pkqy/P6CmoEaXIcRjn4nSblR0TdKDb1Sw/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBg3yMlwzY+FwlP873VdwRJLgRJnRJ7zAEF8/OZu5K4=;
 b=KKJFrJwkE3eczLklmTPpzpraEtzL2JKFP0g7fN4zfdxJ+sEt4rGuEbHX1+pf01tppcRBwddI95dMcBuvsYa2AZKnHAKGrR1ZXXUxwrF49lkKfa8Lc/tSBpzxn8Gl6n9oiF3LRn5IDt7fTJ+Uexzn+U/rw+YsbGvhpIs0KU9LzCaMS464M8XadjIzGbQvJP4RM3g4e1un0WLqBYLkKhmsyXSv8ETHdlWEccHiMl46NdD3CGmTd3nVKvgTw6oF8NLS5tC0ENLctE/pdoezGK0hKNONd9YdEUpKkeRRy0qg+K9EpFVgsuqyDcgQmurIK3j8KSeKA81Pj4K5jQyj1/nocQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBg3yMlwzY+FwlP873VdwRJLgRJnRJ7zAEF8/OZu5K4=;
 b=U/BsCKN20Rqlw2EwesPHNBSKAs6ejJevmS3VP+NmdVxlZRQ4ELbOknGyA0zlrpY/8pjyioQDlzrkgGwdqzZhKUnKcAbcwsSex7cTCc4owC5GSR02PLv79jSIKfWqWZwgL5HiAKc3nCC1mXtKhCQRn2fWlHVp0MybwnwS+43iXAU=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 DS4PPF35C8FD259.namprd18.prod.outlook.com (2603:10b6:f:fc00::a94)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.18; Wed, 8 Oct
 2025 08:20:18 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%2]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 08:20:18 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Ashish Gupta <ashishg@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "fanzhang.oss@gmail.com" <fanzhang.oss@gmail.com>, Ashish Gupta
 <ashishg@marvell.com>
Subject: RE: [EXTERNAL] [PATCH] compressdev: fix device ID validation check
Thread-Topic: [EXTERNAL] [PATCH] compressdev: fix device ID validation check
Thread-Index: AQHcOCegYMXFByN9MUK/5PdRglZVyLS36FXA
Date: Wed, 8 Oct 2025 08:20:18 +0000
Message-ID: <CO6PR18MB4484389312E64F1E7B524CE9D8E1A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20251008074532.3066685-1-ashishg@marvell.com>
In-Reply-To: <20251008074532.3066685-1-ashishg@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|DS4PPF35C8FD259:EE_
x-ms-office365-filtering-correlation-id: b54bf20b-9d10-47d0-05f1-08de06438441
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?WHhESkxrR1FDTjhtU08xU3ZKamNLSlc2a1ZTZVA5dVRSdHlDR0NmYXhNSzN6?=
 =?utf-8?B?ejZFK29VVEZjeGdUR3hSdUpaalkvclRYVmtLNktDNkQ0akUrMmVVZTNqQUlE?=
 =?utf-8?B?ZTlvbnFjTXRscTFCYnRQc3FFMXZETWZpeUZxWjdmZzdaOVF0SmNTanRFTzVS?=
 =?utf-8?B?MW05N3QrSUxVbWdTaXJqdEs1ZG9SdmZzRVFTZExPSnhNRGl0bzRweC9mSFJm?=
 =?utf-8?B?NGx1SDc2UG9NRm1rdmV5TEV6WklOSVdKMmx1S3lMS1dFcEQwZmJ4KzFQT1k2?=
 =?utf-8?B?YlQxakRWcnhDb2s5YTNiMUVrNG5vT2thUmtBcCtkL3VjTys0dHc4U0hkcHAw?=
 =?utf-8?B?d1NSUFFGOWdEMkFoV3FZQXlVdlZPWnBGaHJBbU1OYmNJYXQyNFo2QjUxRk5T?=
 =?utf-8?B?bHNkdldPQ2tiUFhoR1RWOGphV0lDWjk2VWlqUytnV3lmVTBDbGh4eXJDUFZE?=
 =?utf-8?B?aGVrdy9PWTNvVjJtM2wyRWRUUjJodGcwNlBpTHVtUkZqTTZZQ2YyNDBWYi81?=
 =?utf-8?B?RjNsT1ZPeldxbUR5S2M2UXZZSkNpYXczZzRzcFp2WEh4VEdtVnhvbU5xYWFG?=
 =?utf-8?B?b05GdEcxRksyUE93b3RhVDRVK0VwNVJoczlSSmhNYkIrOFFTaldtaGdIRE5Y?=
 =?utf-8?B?ZmxYMWNNZGloMjh5UzFEbjY5azBIeHFoVzhhZ2tkVFN2VU1meFdMdnh4Zkk0?=
 =?utf-8?B?QnBKWlZ2aEtWRnlJUXVLWmY2UkltaGtOZnYwRDNBRzUxN3h1NUZiTHM4OTly?=
 =?utf-8?B?cnBnS0thc1dqdldxejVBLy9zSVl6cTluYWVTVjF6Z3Z6VDBobkx3YThUOVEz?=
 =?utf-8?B?L0lYUHhtTUNwWG82SjU3R1gxT2dNb3VMRlhtbDhPMStISERBNHdiRHFIeDBD?=
 =?utf-8?B?dUJ1eDBkR0lpK05LdmpLK0dENG9oZUtyZk5IaUs3L1FFcEZKUGltRVVOaHpF?=
 =?utf-8?B?NTV1QkZqVm1MYzc3aEM3SXZxYXdtcDJjMzdaWHRCcXk3Z2NjNzdJbXN0K3Q4?=
 =?utf-8?B?eVdhb2xNREV6eXdqT0FnUFBKeCtEc3RvUmowZ0VXT3BQdUdwVU5YU25LZEo3?=
 =?utf-8?B?ZEgxL215eGNmNGxsbUg5NEUySnRxbVZhV3pZWGJRWHpIT2FwWEkrNURkSEl2?=
 =?utf-8?B?bzhIZjBnZjdocFJiN3dFcW10SHNSTitzeVdvcFlCdGtYcndKZ3VmeUg4a01p?=
 =?utf-8?B?aHZhUXcweTY4Qld1QlJyWHZwMW5GZkJUSkdabXlvbk82QnJjT3FBWHY4bW5Q?=
 =?utf-8?B?RzR2aklFamExVzlkOW9nOFpMOHZGdTczQlhRRzE5clJjeHN4UEdUSFl1OVls?=
 =?utf-8?B?R2dPQ2lUaEFwbzIrYTA4NXlzUGVoWEIyM3RXc2Nmdzk4M0E3aWJqbFhxV1F5?=
 =?utf-8?B?VnN4Nkl0SklBVjBMdmgzRE9BSGE3NnhoRUtLbXRtS0ZRQUEveVFFdnNHVWJa?=
 =?utf-8?B?NnhRWVMrZTMrT05URjN5YWUyOHA0TzN0WmkvWDhPb2hHbnd1bDRxZlhnZEJ5?=
 =?utf-8?B?TjJCZWxvYXVoc2xMdFFqaE5sVzFVZTkrM2J6bC9FVmRna1U0NFhuNXp3b3Rp?=
 =?utf-8?B?TnVXdmJsemE1QWZOZDlIVFRBUmxHa093dG1RWlJCcERoSWlqajNkcU45dkc4?=
 =?utf-8?B?QTBHUkM4Zm1Oazg3NXBOdCtYUmhRNHlOdTA0QnZFanJaZXN0d01KOUY2QUNB?=
 =?utf-8?B?WlZ6WlV3YVIxRWVRcUU2VDdwZTNKK1VZb3RsaXF0OHFnUzV0Y0tVTkMxQloy?=
 =?utf-8?B?MGFDSjFGVWhsZWhaMHNDYm40WGw4eFdNbDlsZHVSemFiSUluRVc1NW5aTTRl?=
 =?utf-8?B?ZTFKNzRxOGM2d2Rqa1RRYzFidjNmN1BTYUtlRUxOWURLaTQ0d0p4SzBpWWRV?=
 =?utf-8?B?bllLZm50RkNuV3JZT1NqbkQ0dUh3aEJ6cVREYk1xTGtGM0ozenZjUVVFa2FJ?=
 =?utf-8?B?dnd4RXFkai9Zcmx3NFN4RldFWHB0V0NIWTlVWFljcjdxWDNHT2lBWDZaNUEv?=
 =?utf-8?B?cDRGUVZ2OVdtLzFNbWF2Y3hDVmNMU3FNTEpCQUF5Mjd0U3hwQ0QxUHN6ditD?=
 =?utf-8?Q?zp9Yuq?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emV4S01JLzZ3MFpRaVlFWjVJeU55aUVzVnQyMG9US0FBZWFqOFJHVnRSenph?=
 =?utf-8?B?a3BFVFNxbnpCeU9ST0MrWE0xNGI1S1dxa0VaZkorRTkrWlJoazBIZUNMRmZ3?=
 =?utf-8?B?YkFsWlFTQ2QwT1psSkRxQVQ0UFRWeDdreEQ1YzdJS2dFaWFVcG5wUldqdmds?=
 =?utf-8?B?MTZOTUtQQjVhbUQ3RnhkYU0ySTE1SXZPWDZXaytxU0M2YUpxZTBjQlhGelc4?=
 =?utf-8?B?MG11bnQ3RzhTVlQ5dkU2K1lkSko1S25rR0l4MXZmSHZwR3E2RCtsN0kvMGJM?=
 =?utf-8?B?N0pQMEtHSVdjenJvcHRrV2tHZ0k3bW4yYlFmSVJxeTZPSTFqSHVxbUVIUVhO?=
 =?utf-8?B?L0dQZkNSTlo5dUN3ZjN2d2R1SmRrLzh4Z0R2NTc4Zm8rUUttUEV6dm5IYm9Q?=
 =?utf-8?B?QW0yVXl2ZWRwVXpxN2hqZnVLa1JDbWZUVlRGa2pyMXQ4bnpjWEd3d0hVMkNx?=
 =?utf-8?B?YzlxcG9QY1ZNR3NlL1lMQUNZa3RFTExvS1BOaDRjUTlIV3hTb25Rc0hOMXd6?=
 =?utf-8?B?NThsek8wM05OcTBqNk9sYnB0RmRPZjNESDR0a2R5aXVEZWRmNXlBWHhzbnhX?=
 =?utf-8?B?WVdwTGJqQSsrQXN5OHBLZWVOTjBkamd2b2xCaWVZaVpQajdtVjF6dGQveHg1?=
 =?utf-8?B?OVVqRENWVnZrKzhyZStaQlg0amV2UjN4eEp4eEozL0V3azhVZ0xnQ0Jycmdn?=
 =?utf-8?B?d3gyVTlVaUpUV0xlK0IzUVpjaGtHZTJaaUxzelZ3bzVWNFc2YjZndkFSQlNs?=
 =?utf-8?B?Nm5RUUx3Q01IQ2gwMy9jTWdJSzlrZXM3d1JrbjBsc1JVMG5lTVRRRm5zS3dw?=
 =?utf-8?B?c2tWOE9aTTJhMmJoVE1KdlZ2OHZIY2lFelE2QnYyWHV5Y04yWkREM2pLTW5B?=
 =?utf-8?B?OFN0WVJnUkh3T0UwbEJCM2FaelovdEIxTHA3MEYvZElZSHNsUzFySE5RT1RJ?=
 =?utf-8?B?Y0Z2MWpXb3NmbUszeWFJd0F0aTJpZ1ZRUStiRUkvcFFqcWsxS0pGUU9kRXhw?=
 =?utf-8?B?THRiMkJzODNTeXM2Rm9hbGlmWEJsT3pacVc4bkVabWxvRG5vS2hlbngzeTY4?=
 =?utf-8?B?TnczTno4VGpwUjdJRU1uWHgzcktROVRlRmQveWNMbzhLK0QvNGFrT2FWRU9t?=
 =?utf-8?B?M1FXbVdGWHZNYzZsUmlXYmZNYTE0Q01nc0tjQ2V4NFJRVjVRbW8ybTZwc2NM?=
 =?utf-8?B?cjZkWTBuYnFuNXlqZnVrTVJkMXVOZWQ0REFvUzNFUHAwc002VmVNeSt6MUN6?=
 =?utf-8?B?alVLa3FNRy9LajlaaFBXREhEMkoreFg3d0lmSVdOS2x1TGVpbGVJS0QydW5Z?=
 =?utf-8?B?dDQ4eDAzazJCaTN6K2ExYXFrSWxXdGJwZldEdkVjQThkbFhhN0dmTzhsNG9J?=
 =?utf-8?B?dFJ2L1kvSXRDbG54WTZIQThZM1R3ODg1OVpvTFFVaENJeU5CMG53NWwraFM0?=
 =?utf-8?B?eDZCSGFhVk1UQ09mM3B5ZnU2TWFLcS9JczVEWnFoa25RNUhYN0J1U3o5ajU5?=
 =?utf-8?B?dldoNFdzeUxvSHRuRVc3VDJjRzMwcWozU3pKK0YxNENibUp3VVgyVTFjMDRn?=
 =?utf-8?B?US82cE1FSFkwNFdFd2pPbEhPVjNVMDJHOHFjV3dWVGIxUkQrWFcyVHo5cEx3?=
 =?utf-8?B?TklHV1lCYzdPVS9HNXZ2V01JWkxQU1VZbU1kZWVTOVJBdkkvdklOQXBZV2dv?=
 =?utf-8?B?RGpQTGFvN3FTREkySU8ybzlOVkUwVTBSeGJ5OHhYeVJqQkViR0Y2Zkdoanli?=
 =?utf-8?B?OHQ4MW9jbnFhbWJmZ3ZNSk5vQkd3ZDdmQ2t5NkxSYnBNTDhMQ281cXpTYkpF?=
 =?utf-8?B?OW96YUY5ajRlY1pnT1lHMEJiNUFlaU10a24rNEVGVEpmMElxMVdHRkR5Q3JJ?=
 =?utf-8?B?R2k0ZTkwZWl6b0JDSWRQNytxVVVaNWtiSStydzlwb25PdVl6WitCa0JRREQ0?=
 =?utf-8?B?QU5vbVN5ZUl2OE03NXdjRlJFUE1IUlBtRVo0T3JlUGY5SnBZNk5XMlVtYWpy?=
 =?utf-8?B?aTJLSEpVT2FxYjdlaXdVTTd6ZEVmc3pDUk9SMVRjWVgzVU0yUENoUlNUdWJF?=
 =?utf-8?B?OERQS2pRaUFITEFtQW5aMTY0RzlPY0tRWGNlQlI1bHRGTTkvZDQzNWNBeEph?=
 =?utf-8?Q?knCmufeArl55AMHteFifJtrPr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b54bf20b-9d10-47d0-05f1-08de06438441
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2025 08:20:18.4199 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k20Q5vUARuQK/EWQAQVEYZEV0MMeB4K20Nz8HYsSDcJZI76hsUtinlu07GxQmBqdRZ9HfODpKyId1WLYZBr4iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF35C8FD259
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDE4MiBTYWx0ZWRfX3U4rsJ9eLwJj
 QC7T80MZNjiYNpqpBIHcO2mxecPEFT4JNHcWHZZG4P4UvMwBrMYczCSzSPC7EfB90no9LPHe1+a
 T36qdGEsrWW22Yx64Tek50zh9bbfNkJaAGmLMDYjGMx752nhCMuwlwVyzLudkoreN5IQX2oELST
 tvSqBqWHz6F3cc59a77w85vCI4U7NPdFMpRwseYyZG/2uuGqmQ9jXVZ95M+H3H4NlIPq0DG8kIw
 rcV8oVja20ucPTkfHbOn//UmcOT61znlDwM2VoSPAM3cNyWovKdGgvlJ/+wfqa1saFtf5Jz4Gfc
 9cijDzNkL/iFpdM1Anw8rn0+iCSmiqg24OgGrz090Wv9iJdv492VpiudZjLRTP85U//+nScUQRR
 59tIniHMdQFLii9B6W5fOm/CdbwFRw==
X-Proofpoint-ORIG-GUID: 0dINbSWZbQjLusjmw_ah5lSTipSyCJH6
X-Authority-Analysis: v=2.4 cv=JeuxbEKV c=1 sm=1 tr=0 ts=68e61ec9 cx=c_pps
 a=EEuUCq1UVZeKBjwkVe0TyA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=cIoYVf98QCImzEShG8EA:9 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: 0dINbSWZbQjLusjmw_ah5lSTipSyCJH6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_01,2025-10-06_01,2025-03-28_01
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

PiBGcm9tOiBBc2hpc2ggR3VwdGEgPGFzaGlzaGdAbWFydmVsbC5jb20+DQo+IA0KPiBuYl9kZXZz
IGlzIGluY3JlbWVudGVkIC8gZGVjcmVtZW50ZWQgZWFjaCB0aW1lIGEgY29tcHJlc3NkZXYgaXMN
Cj4gY3JlYXRlZC9yZWxlYXNlZC4gSG93ZXZlciwgcmVsZWFzaW5nIGRldmljZSAxIGluY29ycmVj
dGx5IG1ha2UgZGV2aWNlDQo+IE4gaW52YWxpZCBhbmQgaW5hY2Nlc3NpYmxlLiBTaW1pbGFybHkg
d2hlbiBmaXJzdCBoYWxmIG9mIHRoZSBkZXZpY2VzDQo+IGFyZSByZWxlYXNlZCwgcmVzdCBoYWxm
IG9mIHRoZSBkZXZpY2VzIGJlY29tZSBpbmFjY2Vzc2libGUuIFRoaXMgcGF0Y2gNCj4gdXBkYXRl
cyB0aGUgdmFsaWRhdGlvbiBjaGVjayB0byBlbnN1cmUgY29ycmVjdCBiZWhhdmlvci4NCg0KQ2Fu
IHlvdSBhZGQgZml4ZXMgdGFnIGFuZCBjYyBzdGFibGVAZHBkay5vcmcNCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IEFzaGlzaCBHdXB0YSA8YXNoaXNoZ0BtYXJ2ZWxsLmNvbT4NCj4gLS0tDQo+ICBsaWIv
Y29tcHJlc3NkZXYvcnRlX2NvbXByZXNzZGV2LmMgfCAxMiArKysrKysrKysrKy0NCj4gIDEgZmls
ZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvbGliL2NvbXByZXNzZGV2L3J0ZV9jb21wcmVzc2Rldi5jDQo+IGIvbGliL2NvbXByZXNz
ZGV2L3J0ZV9jb21wcmVzc2Rldi5jDQo+IGluZGV4IDMzZGUzZjUxMWIuLjg0MzViZmExMzQgMTAw
NjQ0DQo+IC0tLSBhL2xpYi9jb21wcmVzc2Rldi9ydGVfY29tcHJlc3NkZXYuYw0KPiArKysgYi9s
aWIvY29tcHJlc3NkZXYvcnRlX2NvbXByZXNzZGV2LmMNCj4gQEAgLTEwNCwxMiArMTA0LDIyIEBA
IHJ0ZV9jb21wcmVzc2Rldl9wbWRfZ2V0X25hbWVkX2Rldihjb25zdCBjaGFyDQo+ICpuYW1lKQ0K
PiAgCXJldHVybiBOVUxMOw0KPiAgfQ0KPiANCj4gK3N0YXRpYyBpbmxpbmUgdWludDhfdA0KPiAr
cnRlX2NvbXByZXNzZGV2X2lzX3ZhbGlkX2RldmljZV9kYXRhKHVpbnQ4X3QgZGV2X2lkKQ0KPiAr
ew0KPiArCWlmIChkZXZfaWQgPj0gUlRFX0NPTVBSRVNTX01BWF9ERVZTIHx8DQo+ICsJCQljb21w
cmVzc2Rldl9nbG9iYWxzLmRldnNbZGV2X2lkXS5kYXRhID09IE5VTEwpDQo+ICsJCXJldHVybiAw
Ow0KPiArDQo+ICsJcmV0dXJuIDE7DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyB1bnNpZ25lZCBpbnQN
Cj4gIHJ0ZV9jb21wcmVzc2Rldl9pc192YWxpZF9kZXYodWludDhfdCBkZXZfaWQpDQo+ICB7DQo+
ICAJc3RydWN0IHJ0ZV9jb21wcmVzc2RldiAqZGV2ID0gTlVMTDsNCj4gDQo+IC0JaWYgKGRldl9p
ZCA+PSBjb21wcmVzc2Rldl9nbG9iYWxzLm5iX2RldnMpDQo+ICsJaWYgKCFydGVfY29tcHJlc3Nk
ZXZfaXNfdmFsaWRfZGV2aWNlX2RhdGEoZGV2X2lkKSkNCj4gIAkJcmV0dXJuIDA7DQo+IA0KPiAg
CWRldiA9IHJ0ZV9jb21wcmVzc2Rldl9nZXRfZGV2KGRldl9pZCk7DQo+IC0tDQo+IDIuNDMuMA0K
DQo=
