Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65256EE6B4D
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Feb 2026 19:48:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A25B40276;
	Fri,  6 Feb 2026 20:48:24 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id A871E4026F
 for <dev@dpdk.org>; Fri,  6 Feb 2026 20:48:22 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 616G2tm93328136; Fri, 6 Feb 2026 11:48:22 -0800
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021123.outbound.protection.outlook.com [52.101.62.123])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4c5kfrgfsu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 06 Feb 2026 11:48:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pIdUUmLylmwYGftVbfUPMwTLDMHioy1ZMXcc8Mac4dpJjLupCTMw8Vf+6ZuIGpKuuZ7lqHSI3SOpeDTAynYKO4eBTFPqsBQF7Z6i5ZWBmtWcEoz3Icoz4ealZFswbWy3P60MuYBaJpWwsNccbspRGXOR4erkQYCwLhgYs5pfWTbBUetNGcp1EtaWH1WH2yroEAyERXlZ7+tRW/PtHAqjV78MstccKKjSLwOZtE0evu/yr0jJWNoFGX25B3qB+k1jaG2NT2MQ49NGI4WobBhLvWVw5+qX5gxM26yYTIjDMozBa1RHTqoc9nHLA8O4iPNboyuuUmHTXSIGKfbeLbFdqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKukTTlu7g3b8hzp1+/1sOLoinDdC47FAnPYsVwY2sU=;
 b=WDWLRxoQTzjOUmwTkrB7hqJ95V+DkMOk5VE+BsSAc+FX/h0VSqmg85IXgaSJLE7hVV/VEcVuSHjh+opEHOnacAOnnc8N7eKD4MXHZ7TMHxyrI8v3arRalSksq77qiprCvHueTGGxJRE7x++vWfeTgA73EcDAVwM6D1dJ7mXs4qEFJR1lpS1i/4eT08r1k7mfbtZPV3WUFidOssFco7eSmjaImpgXgGP5Ezc32p/ih60dtZqJ4R+rsoSwzZxexb7F12A+RvgHPMu9GSQoCYzD+FJQBf/JHBri5qpLgGUF+vVb4ge3nncHfwG/5cUaYeIn2VmQ2SMxsZFZQNPBa3mNlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKukTTlu7g3b8hzp1+/1sOLoinDdC47FAnPYsVwY2sU=;
 b=TJr1YyFeJilng1i/q1EO1y81MOR8c7gXOPW7RgrX1P7mQoe1vus8K8KHxgOPxlqWPAg0IZQg936SKtrR44px5UNgz+FlBBRO6zvnFQgxsNVDpXWoScGEkVOZNfKnb+GVpWHAgFpG5H3aSjazbv6n8ZcOBGJE/lAg7WlvCA7Xr28=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 CO6PR18MB4051.namprd18.prod.outlook.com (2603:10b6:5:34e::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.15; Fri, 6 Feb 2026 19:48:18 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%4]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 19:48:18 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Radu Nicolau <radu.nicolau@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Nithinsen Kaithakadan <nkaithakadan@marvell.com>, "kai.ji@intel.com"
 <kai.ji@intel.com>, Anoob Joseph <anoobj@marvell.com>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>, Fan Zhang
 <fanzhang.oss@gmail.com>
Subject: RE: [EXTERNAL] [PATCH v8 1/2] cryptodev: add support for 256-NxA4/5/6
 algorithms
Thread-Topic: [EXTERNAL] [PATCH v8 1/2] cryptodev: add support for
 256-NxA4/5/6 algorithms
Thread-Index: AQHclP4sOXYIKUJawk+Ix3+mLsSEprV2GNlA
Date: Fri, 6 Feb 2026 19:48:18 +0000
Message-ID: <CO6PR18MB4484B3B98B03C7BDAD730A30D866A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260107105649.1708347-1-radu.nicolau@intel.com>
 <20260203111338.183138-1-radu.nicolau@intel.com>
In-Reply-To: <20260203111338.183138-1-radu.nicolau@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|CO6PR18MB4051:EE_
x-ms-office365-filtering-correlation-id: f6f5bc18-7fc3-4763-11aa-08de65b8ad04
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?aTFXdHBkeWRyazlpWHlZOFQ0enc5NnAvR0g2dVo5cFNQZlBEbEhFMm01MXhr?=
 =?utf-8?B?aWZlU1AvZFNlY0FkaVdDQ0ZvcDFNVllqTzgwbjl0NmErZHJzSzhodHAvQmg5?=
 =?utf-8?B?K0hvV29oOTMwLzg4ZG9tR081a0RFaVZiajN1V0x2R0t5MEM1bmNlVW81S0h5?=
 =?utf-8?B?VkZzV2l2akRyY2pmeU9qa2ZtQ1pVWDEwM082S0dzZm9pMXRnMXpYZ3NQTGE5?=
 =?utf-8?B?dkdsSGpPS3loZUZPTzRWaTVYLzNaSFdyUlZtaGg5YW5DemFwOEJLbXRab0hu?=
 =?utf-8?B?eXZocUswdHlrd2puZG9Db1BMZ2pielFNaGg1d2JIZzY1aFpkSTJ6RGZuMVVr?=
 =?utf-8?B?Wld6THlta1BoRkFVSitEbEhJSVJHK1hPUElRVStKN0ZqV2xtTkNBWDZNMkl5?=
 =?utf-8?B?WjVTRCtpdDROV01tU3JEWXJsZEV5QmMyOHZkQnZCTlRGTVZjUnZpZ05HQWl4?=
 =?utf-8?B?OGRDYTdhQUpOaTBPOTRkQUVHTXRsMzBNbkMyNUlPS2N5SVc2WEN6K2ZzZHZZ?=
 =?utf-8?B?RGw4QTFYbWd2RXp1YU5va09mSThrQnRHY2d0QWZ3VFRKTXB1UGZFZGU4M0hy?=
 =?utf-8?B?eGs3NW1OSXB4QTBDTXN3cVpwOTcwU3lPektDWW9JQURWVUdaNkhZdmxSWVpa?=
 =?utf-8?B?bitJbW56ZFloSzkrQnZNRkhOcXM5ZWV4QSttOUh0V2Z2Q3FYbTZOR2J0bVhQ?=
 =?utf-8?B?RVVRb0FNQUNKbG4rWkdYRkdVV3dydVVqR2xVRS8vbFpDQU9ObHdPVHNyRXkw?=
 =?utf-8?B?QThQbmNTbVNoWGJTYVpMTkk0QnpJaW44Y0poNkFSMWFOK1RxNmptS0IrODh6?=
 =?utf-8?B?K0hZeDdSeVBjVU5SQ2pTMVNxK1NoQUNDak1PVlgrMGVTREJiQ0VtT2hPbnRV?=
 =?utf-8?B?QllJZWh1YjJnWmJ2cHU2TW85SHg5TTAxQ3dBWUJ2QzhPbWU2a1REZk5jUHJV?=
 =?utf-8?B?bVJJaVhNY2ZxMnZXTUxRR01VRlU3REJtMWNrYWhqK3F0NGZTamFsT3dxSXdG?=
 =?utf-8?B?N1JKYkFVQ0NvZ3A2TXdFSCttdUE0L2ZmeXp3YzNCUVJjZDIvZ1g1MlBkbmVI?=
 =?utf-8?B?a2lMem9keXhSbmU5MmdPVlUwRlU5aDl3OGxsdko5OHkzclk2bHlhT3JOOHk0?=
 =?utf-8?B?bnZHRXhlNlFGTGJwMkhvd3dtNGVDWnhReGhOOExBMlZJckVURjZDL2tmb29G?=
 =?utf-8?B?RUtiQ1dOQkgvVlNIRU5yMHh3bkpiTmxlNkZ0anZINUdOM1VTeGxrM2xDWEdG?=
 =?utf-8?B?U3hQK2ZuZ3VmYVcrYjR1OU44VXY5MUUxY200TXVMMTNaU0RuTTlCVFhhVmpw?=
 =?utf-8?B?QXVCZ2FuTThXQldqY2xUZUJRMEdtMTZwWS9Bc1NEVDRTWWxHNTE4NzZxVXpj?=
 =?utf-8?B?SkRqYnlEdVdUeUE2RHJqdWRDaHArNmRQS2h2bFc5K2VXZGhMbWR3eHNudGQz?=
 =?utf-8?B?SW9IbWhmYU9QQm56SnFKMmY0aGswU0IwTXNDb2NCK2tsZGd0T3g5K3ZpajlD?=
 =?utf-8?B?WnhjQlVrUnRVQ3hSY0Z0cmd6LzBiNS9GdHlyczl6QVRxZmNFbk1nYlhBTzQr?=
 =?utf-8?B?ZlBacnNvYVFKam0zc0dyTUljVjFPL0Zoelc3NVFqcThyWjVyMFhIb3o5d0k4?=
 =?utf-8?B?V1lyNXV6Sk90SEFGNzZ2QjZtYm1XY3BidHBhbko2VURjQ1VScHVkMEtjbG9a?=
 =?utf-8?B?aU9jR20xR1ZxQjJZZWR6SnZmVXc2UEhlS2lyaGlNa1YrbCszN3dGVmJIYURH?=
 =?utf-8?B?VE16dzR3NFZFYnEvYkYxR0xMNmplMEVmZndpWWxhdmZDYTUwaUR1UHpkRHY3?=
 =?utf-8?B?VHJhRFlYTzRTQy9BYTlFNHdkQXR5QjJoS1FCcktxaXhMaTlJZTBnNmdVMFVX?=
 =?utf-8?B?V0M5d0RaR2Z3d3JLSHUxaWQ4WSt0MHBLbitQU21qYjJKTDVFRy9Ob3N0dlFU?=
 =?utf-8?B?dnNiVkJvU2o5ckRNVHNkcHJuWTZxeDZSK1dpNUNSS0tBVGdjYmh2Q0Fld1Nx?=
 =?utf-8?B?a215VngwUUtJcE9HRXNLUVdJaWZsR3lrNlZyUDJIMkJHdTgwRlcrV25pVHRE?=
 =?utf-8?B?b0FQYkkzUXNSM2t4R1RIUXQyU1l3ZDBaZUtsYkVTZnQ4dzluaWdmUWUzL2hw?=
 =?utf-8?B?Q0VDRFcrOURZcVVsRjR6QTdpOVRCa2poeFlUUFBVSHhpUEI2eXpBSlBIUW1V?=
 =?utf-8?Q?Rl10NaxPVvU990REhrzlwWM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NlJibVZLVHMyVG1lSTZIL3g4eEZic2NJSXFlWXNSQ3l4V2hmQmpSZ0Y4Q0Er?=
 =?utf-8?B?VUxMM1FQbVQxZ0FHa29KY2ZNRVNpdkxBQ1haL0ZuNlltaWNIVW5PL25WeFJC?=
 =?utf-8?B?QzUvcXNGOWJqc3pxN3BVNjFDMEVZdU0yMDN5WURUSjIvbFluYkRON24xbTRv?=
 =?utf-8?B?MWFhZ1RVYjc3aHN4eXBlRGJIZjRma0NVYUI3ZkhUa0Y3bzVsVEZRSDhlVENE?=
 =?utf-8?B?TkwyZGhZQXpiMkxPVXBFSWxmWDlnVTY4M3F6N0NQNDhQZTVsRE55VGNCMFJT?=
 =?utf-8?B?MUp6VVUrcDF3OVhPRml1Y21RRUJhc09Cd3h2dHZFaWRndkpQbU10NFRJcFNB?=
 =?utf-8?B?VzVLUDJRV1FKOTBFTjNCb2FjTkd0UjhpeldBNWszTzFEN2FRZkpkZURXZ2RG?=
 =?utf-8?B?RTFOWEk0L0NqOUlhVlE0UU9rcXUveU5kNlVqRDJyN1Z3ZmM3UUh0dmE3VFlN?=
 =?utf-8?B?NVlRTUI0a1F1RnNDdUp2c0JYbVNCeTJEaW1pVTJ6S1B2SzRvRk0wcjFYU1Ns?=
 =?utf-8?B?ZVZaenE2S0hkWkVUaWZ4Q0NLclE2UlExRHUzK0xHbFpxV3ZSRmN4VE9WTkpz?=
 =?utf-8?B?WGxCYWphMUcwUEY0K3J3RSt6ZVR2T3l2VlVMM2hzOUVpWmswM0xyQXFMcFRQ?=
 =?utf-8?B?K3Y4dC9ER0tNSTdrR2ZKQ0syVmk4VXFnbFpad1hwaURrbC8vUHVMU3JwcDNu?=
 =?utf-8?B?Q2s3dndTMWxpQ0gxYmN1TEJjVXUwOXFkekpQRDF0N1Fya3doT1N1djB1ei9n?=
 =?utf-8?B?WEZDaitvb2tzbExLRzg0Qit4dWZ2cjRtTFB6RjN3U0NkUFdjclJRSWpReEFL?=
 =?utf-8?B?d1RVVFA4NU53cXRpdHlIVXZ3dW1mL0VycC9qdGV3UXdDMEVjSnFVeXExTVYr?=
 =?utf-8?B?MXcyaFFyMHliWUVuVDdONEhCV1hUVFU5TEdBUy9CNmRRRXJ0V1hrS0dCa2Yz?=
 =?utf-8?B?aDZ2N0hkOFJWZUVRZVV6b2NuQnE0ZHlEN1pHdkxjY2oyNkJpdHJaZEFUSldC?=
 =?utf-8?B?U1ZrNEw4M2ZjS2k4ZWtxanQ1ZGRhRHR0WWQyL3NPZnA1QnVtR2dpRGdNSk1k?=
 =?utf-8?B?Y1JWTUpIcmF0OU1qN0VOWXV3d2k5TnpIazEySlZtd0dlUVpPK1pzY1pyeGxk?=
 =?utf-8?B?NDQyM1laK1ZXWHZYak13d215WFRhZVd1WUxVdGswbXJGY1ljQ1ZkcUdDanBD?=
 =?utf-8?B?bFRIcVNnT3RzbzdLRmVKK2xmTG8wc1ZYajlhQXlERXZoZDhKQzRLVFV0eUls?=
 =?utf-8?B?a3pZQXVRLzlwOXJWbUhDMHB2UnNiemkvbS9oRzNreFpJdHBNOTRTWndEeTdM?=
 =?utf-8?B?bzVNZmxqZFNTOFY2WGIzU0xrOWswMUFIR3lvUGFpTW1RMWpDS2k1amZjSENT?=
 =?utf-8?B?d1VlcDNkbW1VREliUnJuNG5idGdEbXF0NFNlLzJhRzZ3Tmo3dmQxQXYzeXVU?=
 =?utf-8?B?dG1hS085bFRROHFpRkZXWmVmMGd4YW1MSGdHemEyekFOb01mQVN6eFdabDl4?=
 =?utf-8?B?eVpkeitqdkxER1ZEU1NlVGJNMEs5ejJMZUJJV0xuT3pVeG85L2FKWG0zRDkz?=
 =?utf-8?B?K1pHc3RhaUVZbU5IYkhXUllMRy8vb0tROG44dzRFclBnUzQ4V3VYcGVyY2pW?=
 =?utf-8?B?aEhLWGI2TDRYVlNhOTlrM0NmWXJGSXQ0UU5kUS9EUzA2WDB5M1VleDJlaU5I?=
 =?utf-8?B?UHNsbnJ1UFdGbHlYOU5EeXNQbUppVHBXWm1LTUR3YUxFRDlpc1F0K1pCZHM1?=
 =?utf-8?B?N0F4UXpndko1KzBudmlkT0ZadngydFpGNStzVk9xSUJFS1E2dXoyWldCK2E5?=
 =?utf-8?B?M0hFcDI2Y2dRN0pEZHRtRWtqWGZtZXphaE5hRWlSdEcrSUVxRHllYWVwM28z?=
 =?utf-8?B?WUowTUVzdzViU25pNHBpYkNpZFJNMVpVZXFzVWt2VE9LSEgyaEN5cG5mMmhi?=
 =?utf-8?B?QkUwYmcvU2EvVzNESXFTeUYyTEtLUHpFWmhkWTFHNlNlQ1gvS0wxZ2J5Q2Vj?=
 =?utf-8?B?VThRUkRjMDdTWkJ1TjAyRzYySkw4azNRZGVYb0ErMVIvcytjTjJIMDF3Ty9w?=
 =?utf-8?B?NWNyTlhQVm44SWpJcmFGbjYwa0tuRjVqQm5pLzlRZitpMGsrTEY3VXhoN3hQ?=
 =?utf-8?B?OWpjbDk1SlpBQUR0TGdLdkRpNm5UeURYK3NnTUt4eWlPNUVxMDVSdHM3eFRO?=
 =?utf-8?B?T3ptVWFxZlJjOE5GaDNKNEYrSlNPMDNvV3hHa1k5UGpiMk5IZitEekxXVmtZ?=
 =?utf-8?B?aGpCV29HeXdaNjZQUHc0aWVZdjN0UVdOTEJ2SmdwYUprcld2VC90cENQdEdO?=
 =?utf-8?Q?EILIMw0QJSneGGYZn2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f5bc18-7fc3-4763-11aa-08de65b8ad04
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 19:48:18.3799 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6rXUskUxpX/ABMFiHrOyPYL/3y3qvTHIldeWJwJda8MLF2mT7x7dmescUszbN7n/0SjMNxYGv18joSDeUmCwKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB4051
X-Proofpoint-ORIG-GUID: GbXKQo51UUEciB5IU-PCE9uSyBJnXM37
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDE0NiBTYWx0ZWRfXyKU8kIAiPNQF
 KL162FhlTmh95hKpZZqvj64IUYplVgECejIGUg4vAzurFGlqvazb1Opr0mIq56CJo+KB+8Wy7lj
 PqtNDDCZ6yqiiWGaI68S6OEmAyk36PGFoHZoJzULaTS92RWMDrE69+eJ9lUNERN+G4evx47iXez
 E+LG+cOdT0TN8LmNzIfprTrdWCdKWDVtn2RbxmHO7ke1lKE27nySbxCtMrRJKW/svzyuaZVzd86
 A0kGPv1vkql4wpZnoB1EvJpEIkXHxPrhpsxG1jAKMJrdc6FRT4aG4dLutyudmyG0IaswbjNaA6u
 CQtq4iIeXirDPlLVVWnypWXpVYGJroqZENYSD2P6KtFkEW9E+mkxQZwW0tGoJhs/+gshoats5lH
 fr2vQDSUK7FgjqbcRywMeuLERzZsAgNG82EG2sEjDdoYDH7IT93bbBOsyh5T9Axd3RayaczrNsz
 KLXiosq7BvvZDcGiHzQ==
X-Proofpoint-GUID: GbXKQo51UUEciB5IU-PCE9uSyBJnXM37
X-Authority-Analysis: v=2.4 cv=J7SnLQnS c=1 sm=1 tr=0 ts=69864585 cx=c_pps
 a=rsLAoTD1kIcpcG7DHw0aAw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=QyXUC8HyAAAA:8
 a=M5GUcnROAAAA:8 a=GI19-8pjPv0lKbmtnGIA:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_05,2026-02-05_03,2025-10-01_01
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

PiBBZGQgc3VwcG9ydCBmb3INCj4gDQo+IE5FQTQsIE5JQTQsIE5DQTQ6IFNub3cgNUcgY29uZmlk
ZW50aWFsaXR5LCBpbnRlZ3JpdHkgYW5kIEFFQUQgbW9kZXMNCj4gRVRTSSBUUyAxMzUgMjQwIC8g
M0dQUCBUUyAzNS4yNDANCj4gDQo+IE5FQTUsIE5JQTUsIE5DQTU6IEFFUyAyNTYgY29uZmlkZW50
aWFsaXR5LCBpbnRlZ3JpdHkgYW5kIEFFQUQgbW9kZXMNCj4gRVRTSSBUUyAxMzUgMjQ0IC8gM0dQ
UCBUUyAzNS4yNDQNCj4gDQo+IE5FQTYsIE5JQTYsIE5DQTY6IFpVQyAyNTYgY29uZmlkZW50aWFs
aXR5LCBpbnRlZ3JpdHkgYW5kIEFFQUQgbW9kZXMNCj4gRVRTSSBUUyAxMzUgMjQ2IC8gM0dQUCBU
UyAzNS4yNDYNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFJhZHUgTmljb2xhdSA8cmFkdS5uaWNvbGF1
QGludGVsLmNvbT4NClNlcmllcyBBY2tlZC1ieTogQWtoaWwgR295YWwgPGdha2hpbEBtYXJ2ZWxs
LmNvbT4NCg0KQXBwbGllZCB0byBkcGRrLW5leHQtY3J5cHRvDQoNCkFkZGVkIHJlbGVhc2Ugbm90
ZXMuDQo=
