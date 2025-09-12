Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9802FCA101F
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Sep 2025 14:56:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5CCC84065E;
	Fri, 12 Sep 2025 16:56:35 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id D01B64065A
 for <dev@dpdk.org>; Fri, 12 Sep 2025 16:56:33 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C9exbi003961;
 Fri, 12 Sep 2025 07:56:33 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2102.outbound.protection.outlook.com [40.107.92.102])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49484m9m37-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Sep 2025 07:56:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZJftsuWgc0UM9gY1qV4IhCmrAli8bSgzdvnFUj2IWXdOLJ5IaXQQKjbwKs/UkkwzWsMwC1jlaz/0mhNjuzHdffOyWYwoE0EoyFw9bJNKrov+0RwJ9Pk9/KxKojidPG/lAhcylnf0uusYE3AOiiAbCqNYzWBHorq7CaYzdwx5dRZqHzfwLeAL0EW4tULoy2KjCaWSMC+FJibWUO6xb9nuGgmNBG/yUpn555o0jhkTYtyDneN2CcUc9SBX3XX+K4naqSYHJ2Kt5S2wlWWLUS/NUAorz/Evkpf2H68uHJgSma6qQDgrIIy18xjhLiJw2oKdRASvEpV8hlm9VtfBnlSlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUbhKo95lusUNcbwsi78OMPkLLS6Um8T6uWGYCQF1gk=;
 b=JwHHO1fnIdscoSghsypl+mV/5mqmxWJk9L/DC/mq+LIQPU06eGPsxW8ze/qUl4JGXeuHrfKCP6fcTCwOF0VOMZwxH0gHp8zqDWQ3vRjCy+XKztgXvFFCLdOFYFhaRh926gtFqzbXtrv8WkMxTIYYyAkxoQ9OU4IRe7e0CtRPOHLxeOcL8QJAjdJ6bYwdfzj+Yt9xN1BawhZ24nTMoGGm5oblRXL83znymfw3a2m5ghhJ3ql1szKs0ofwEL1EfSIkjw8DJ7QKA5eKPG8q47iArX9RgemD2QLSlRb5tHWAmrM4AF2n2c6hUHKA8Rqg/GdzIzVpriMhdf3d2G/f1JQ1+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUbhKo95lusUNcbwsi78OMPkLLS6Um8T6uWGYCQF1gk=;
 b=tbVQbYFjl0zGCpqnS9gMsTsASRDiOH1DvDq2fJmzqYS4XEWyUUdHeoaFGX+6s1wM8MuOGWGiKTxv3e24tWrr/LhHV880CriWktPhtxKU1sXrc8dRPBQLNz+QYw4oJgYE3ZoSuSCsQkf6wKkVbfH1ezeCJdfezDHWXpccGatedWY=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 LV8PR18MB5656.namprd18.prod.outlook.com (2603:10b6:408:182::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 14:56:30 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%2]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 14:56:30 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Radu Nicolau <radu.nicolau@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "kai.ji@intel.com" <kai.ji@intel.com>, Fan Zhang <fanzhang.oss@gmail.com>
Subject: RE: [EXTERNAL] [RFC] lib/cryptodev: update API documentation for
 aux_flags
Thread-Topic: [EXTERNAL] [RFC] lib/cryptodev: update API documentation for
 aux_flags
Thread-Index: AQHcFzcWJ7TeuTx1VUGp1mFxffzG27SPnK5ggAAQWwCAAAUEUA==
Date: Fri, 12 Sep 2025 14:56:30 +0000
Message-ID: <CO6PR18MB4484C9F7FBBCC5AA04405899D808A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250827094338.767062-1-radu.nicolau@intel.com>
 <CO6PR18MB4484F38CE9989A01F49C8CF7D808A@CO6PR18MB4484.namprd18.prod.outlook.com>
 <114c4b2b-f619-4a12-ac0c-adca09fe6033@intel.com>
In-Reply-To: <114c4b2b-f619-4a12-ac0c-adca09fe6033@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|LV8PR18MB5656:EE_
x-ms-office365-filtering-correlation-id: 19e96724-065a-40f0-2345-08ddf20c8ea1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?cUFpdFRsdUJIUXV2eE9QR1c2Nmh1SDdoLzcvY1hTUElkckhGUmtRUndyK0dl?=
 =?utf-8?B?RDJKQWNkWk1ET2RCbEtrOFpXRXNITWtGOTB3MmZDVUlzQVZ5WXFiVFA2WHZn?=
 =?utf-8?B?d1J2M0FUY2Nub2hKTWN1OFNXV01ydmxpUWlXOHArOGRudHNYckliNUlMQ1kx?=
 =?utf-8?B?d00xaitwc3JTOEQ2OEF6Y2cvTHQxSlI0Y05UU3pnYkpNS1ZmVm9jZEtmTjNw?=
 =?utf-8?B?ckgwandIbW9ld29qcVB3bVJ1MFgvZFFIV1NYRmxsZVN3ZmZsZVYyWlA4cWVa?=
 =?utf-8?B?RmZjN2pnYkZXQ3U2VGREdHhialg2cE04QWhBdlZ0UVl3SXhBTkp6UTZqMWFj?=
 =?utf-8?B?bENmNGs1VEtiVzVMMGRZdVh2ZnArTUt3akhXSkE2K3BnNTlpVW5XM1BINnVr?=
 =?utf-8?B?VDBIZDcyMTdmZWNkOEtYbTdmRGRNSWI3U1FmVjdIaTB0dlpIZ0xLZUl5NGFD?=
 =?utf-8?B?K0N0aVp0dzFjdjlFdmo2eDNyZzZxTTgwRTlGbVQrZk5yamZqY3pNN0lPTW91?=
 =?utf-8?B?WTBwQnhacENURis0NVgzWGdMVTB5MXFxbkh4RXN3aTloY2hlaW1WRjZZN1hL?=
 =?utf-8?B?UEZDc25BTTA0VnN6Z0I3NlZXRGcyZU96ZVp4enRQdm9ralQwN2lRRy9PKzNz?=
 =?utf-8?B?dmNsY3JnQjBCVmFyS2R0aVQveGxWV3FIaWJKbnZiVHlFRFZJTlZnUHRoVWsx?=
 =?utf-8?B?cTgyV2w2WFdBaEpLL0k4Wnk4S3Rid242UklYMnhKQndKWmpqcnpjTzVPMDFS?=
 =?utf-8?B?Z2RWenc2by9ycnlBSWYwWUhtd0RFOExmVW01a1FsNkV4bnNvN1dmZlhEK25t?=
 =?utf-8?B?UXlrSW8wVzJxK3F2NG1kNUs3eWU2SjZVNWFaNzdab2lna2R2bkpMYStrV1M1?=
 =?utf-8?B?SlQ5WUpmWUJnVElGWDlSZTl6b3pVWitybzJaYzFuc2VDWnpGT0JvTDBiZ1F6?=
 =?utf-8?B?N21hQ3RBMjJqekxvdk9iYmZONURtbWVUdFk2eUs3amFneU9CRGExaEdubElu?=
 =?utf-8?B?VFp6bktlWjNEa05BMmJlSU1IQXg3eW53NXdzWGcraGxOQUF5bHZheUZ4STFw?=
 =?utf-8?B?a3p3cW1pSzZIcmpSN2o5eTJFRFo1djhXQjlETk9HZjl6THBaRGVvUklDaExE?=
 =?utf-8?B?WmczQkEyZ3VWSnpmaVJqaTFpT2NCYnlXanh1Zk16Zkl6Y1dHOVBnMnIvU3R4?=
 =?utf-8?B?bkkrelROVGp5UFQ4RVhrZVJQYURGT2FUVjAvVm1yMGFvNHlrYSsyNGptOEcv?=
 =?utf-8?B?dXZwN1lxODlGZThCcDhIN1lONUNYRjZoSkJ6ZFRha2RxWmVnc0t1WDQ0OFRi?=
 =?utf-8?B?eTF3aC9RSnJvdmpTazVqWWczczkwV01DOG83NWFoWnhTQ21TQ0ozQy8wczFn?=
 =?utf-8?B?cUt3ck4rNlduVEt3L0ZZVklEOEZVU3JDaXVwQmN6OGF6amJ5bUVYK1h3cVlI?=
 =?utf-8?B?aTJ5Sk14M3JJTXR5N3NVRG9pR0t5NU5TT3kzS3hqT2hwMjNwclZLTVFSeURB?=
 =?utf-8?B?RFVsUm5ld3d3U3gvenE5ZGY1eDE3MzJLc2dzbGlLTU5CSEhSK2RUMitOdGRV?=
 =?utf-8?B?cGVTRUN0UWw4UXUxOWw4eEZjbkVkTlNIVXdZTmw5Z1ppOHJjMi9lZ3RRYVJl?=
 =?utf-8?B?WHVFaW04c0lTOE9mTE1jcWdhZ0dSdVBNY005ZUpaNXNiTnJPWmxhZEhhcTJk?=
 =?utf-8?B?bDkrbGU4K3RvN0FLcGZzQWFna3BxeVhaU09VaEptZnVCbU1reUJxVnpTbGhx?=
 =?utf-8?B?Q29xdFJUOStZTVY3VkRJeFFWb0xXdVV2K3l4S2IzenV6M0doL0FjTzlXb1Fp?=
 =?utf-8?B?bkQ1NGNqNDFsL0xyVW5oM1pneXRUSzVkdko0Mm5leUVSNkdBZ0tHeVRHS2VC?=
 =?utf-8?B?WFVJUFU1OVZYclFnbURMSHJrdlpybkdrMktNWWRiUDhqNk1nSUh4cG9ZaHl2?=
 =?utf-8?Q?hvjEvVD24XY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWQvT3Z6M01PWkdBMDNqK1JTWmNRL2JJMjlaemVlb1UrcUZ5TU9QQ0l4blVX?=
 =?utf-8?B?NUdHb3Q0OWpESUMwQ1hmeHVJb1JIT1FubFRqNWtGM3JnUEkybit2T25rcXlR?=
 =?utf-8?B?UXJCREUybVd4c3NWRGcrVWFiaW1hY0hGaCtZeDM4VEJtdUsrbEJmcS93L2tE?=
 =?utf-8?B?bU1wMjhGdGJtOHBxZTE5NzhiTitOeUg4bUZYc0h2NjVCSWpEc1hSUkRueERa?=
 =?utf-8?B?WUduMHFFMTN4eVdaYzBhZStLSTU0VW01L0gvanNnVEZ6cDFKU0RIM2IyZzln?=
 =?utf-8?B?ZHF4SkNwVnBHVkZWell1TFl5Q045NHFwMTQzbi9qalVBVWY5MThRczNsSG4z?=
 =?utf-8?B?MzRkWmR1bEZDdUtFZldQR09EVVRiendwdzVSakVzcFJSRnNOUEpBVmtNUldo?=
 =?utf-8?B?c2ZOQjE0bFhrWCs3MjBBK0xvNGZNUWpnbmRta01QMm9ITktVSyswWi80czh1?=
 =?utf-8?B?M0t1Mk9kVUJvelBqVjAxcXJhZlZBV2EvbTkxalNLdlpjSEpKc0dkMkJXcmRp?=
 =?utf-8?B?SUluL09BTHJuUTU2a0xwRkxLcWtQa2FrRDAxcVZ5TDlrSGEzRlc4eWJjVEs4?=
 =?utf-8?B?K3JheHFqenNPU3BEcDFGZlZLZnRCMi90dmhQVUlzY3doTTdOWnhiV09UUUVW?=
 =?utf-8?B?VGNFZWRzSHJrOHFIb1pjNVdIbDIrK1prMnNCaS9qNC81YnZxLzZvZTgvMDli?=
 =?utf-8?B?ZlRBWTVZZmZadWlZUTVaTmMyZmhYVXU5NDNZWm9zT2Z3cUViOGJmZFdJMUp4?=
 =?utf-8?B?U2VRbjF4OGd1VHdzaFljbmZvc3doL0cvaUNnMGlhcDMrNGVhcFcwRWRQV2I0?=
 =?utf-8?B?SGhBSnhvT056a2xvWGxiZmF3anErS2tGZ2VrbzNHSTBWMndBL3A5bnNiY2ln?=
 =?utf-8?B?UmlBUFRHTVdWaGNjTzZDQ2lBalB0V29YNUdxWHBpQkJ4dE42V3M3TEtjR2pq?=
 =?utf-8?B?bFJIRUgzNlN2RzB6M25wZENRQTF5Nk8zNC9KS0hsMU4vR1NlVW1tWHBnSjNH?=
 =?utf-8?B?cnFwL2o3eE9OK0NQZTBCdnVzVWhYbWlXMk5SekJHM3dFSVBWNG9VTXduYWVT?=
 =?utf-8?B?aGZQbGRQMFFDSXBLMmUrN3dzeW5ocUdsV0Q4ZGloOEhJdWNCNEc3alorZDNz?=
 =?utf-8?B?d2I2UzB3cTBVZkRnTFhocGpPRGNRcEgwWHp6ZEdmMXl2WGR6UU5IVU1hYXpJ?=
 =?utf-8?B?VlRmMzljZmxNUEh5TWNXRmdtYXBSSTlJTGhlRG9iT3IxY05BQWVBV05POElR?=
 =?utf-8?B?aUJRTkpxSGdZZmw2a2dzaHZ4dmVsVDdSQi92ak5GTXJlVGU0bS94ZWNwUTlv?=
 =?utf-8?B?bWhlUFdaOWYxbEUreUFiUFFZd0Jib2FkVWxJZjFuVmhseWw3NTBSZGZucmNO?=
 =?utf-8?B?N1FhZFF0NG1rUzZRWHNmZThrdXNrTk1kNDk5alQ1MklRNWVuR2NURGhUaVNR?=
 =?utf-8?B?NDZBbEl3WkxzSm9hMDR1aWtzV0VWM1kvTk9DRmRPb2tSRjJEM3lyRk9kOWVq?=
 =?utf-8?B?QTFPU1g4NE51TDFQWUZ4eWtzcHk1UitiYmVweEJZMWwxamVFRTFjWGQ0bzZl?=
 =?utf-8?B?VWlBeDdkT3liNC9Qa3E3Zkk1SHRseHlTTy9zamVrQXhmNy9sVnRiQlBYZlVE?=
 =?utf-8?B?eFg3YmNWdzcxM2Z6RCtUbVdpRUFGd25TUUh2dXRRTjJsV1orTkF4RUsrcXRJ?=
 =?utf-8?B?NUJ5dzVSdG5iNE9ZYTYrbytESGM0aURHeDdNU3dUK0ZjR2djaTlDeHRtTEVw?=
 =?utf-8?B?RjFxSkZvZ2Z1eHRNUFVKaGRLbmt6R2RJZzFyczBPWllKU2FaUGwvdlFrVTV2?=
 =?utf-8?B?Vysvai8vbEJPdGdSVHRnL2g5TU9hUWJVNW1pb0NaR0RTZldGbUt2R3VXejBO?=
 =?utf-8?B?eEZEWVZ4RVNTRUhTTE95VDFKckNkaWorYmNvT0lFZ1lxQjRwdUhNbEM5bEJz?=
 =?utf-8?B?VXJ0VVUyVVZpbDc4Rkt3bWxsVWkvQW5wUnM4U2F3Rk9IVlRlbU5kRXMvVk1v?=
 =?utf-8?B?NWhmZlM5aU5ZM1pPM1FnSUY1dHVhaS9naHppeDlxSEx6dGFMVXlHWUliNjBW?=
 =?utf-8?B?ZWVCdWNLUE0wdFhOSFREMDRYMFpsTVBqNkxlTUIvd2lzWG85RGNOZEN3VktR?=
 =?utf-8?Q?JF38=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19e96724-065a-40f0-2345-08ddf20c8ea1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 14:56:30.2669 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dv+U11dIK69ZT8GE+twfpWaY/b2af1NIz2b/3njQn2qA1JfHtDK+8apKZgtq3Gbk2cUZxqClbrh+0nwILG7EQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB5656
X-Proofpoint-ORIG-GUID: QK0XNFFd4gKSaQwLUHJlCvg0UoZS-zRP
X-Proofpoint-GUID: QK0XNFFd4gKSaQwLUHJlCvg0UoZS-zRP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTExMDIxMSBTYWx0ZWRfXyNCb4Vqwq5n6
 5kHShq5UnvENQ1GfDVAmMmm1BQjll8EqZGKWEOTgRo6DNCMbazsGfbLhWVy6kXboUgav4/JuHWt
 +5plW1pP/J/RmGGNQHISTL1lPkEcUeb2vPJqDfPausIjT7PvXMiLM45iFK/JDJBgpu1c923HFIP
 U9NByP+W5UDV9SQKUCKUU8wNBwB+MYnjcQccDwRxivep1EJ3x1rornnWTS3oqQK/p848vMUHcJE
 94C6XritgG8wpUpWN/csDnXPpsI6jzy4Aup+wpt3RM2tEgiRWlt0M9vBXXCFCGKMQAsvZn+R3RX
 IWDP/GYcsFOxq3C1lcwxN/d/Sc9k6peWvMQDdNryTe5E3dCfINC+uXLsG+ydMF91p7nycly4jts
 0cphRCmx
X-Authority-Analysis: v=2.4 cv=FL8bx/os c=1 sm=1 tr=0 ts=68c434a1 cx=c_pps
 a=m+x2I9q508XYD8KzOz5nbA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=-AAbraWEqlQA:10
 a=8rWy6zfcAAAA:8 a=ymOD0eI1V4FodxcN58YA:9 a=QEXdDO2ut3YA:10
 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_05,2025-09-11_02,2025-03-28_01
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

PiBPbiAxMi1TZXAtMjUgMjowNSBQTSwgQWtoaWwgR295YWwgd3JvdGU6DQo+ID4gSGkgUmFkdSwN
Cj4gPg0KPiA+PiBVcGRhdGUgdGhlIEFQSSBkb2N1bWVudGF0aW9uIGRlc2NyaXB0aW9uIG9mIHJ0
ZV9jcnlwdG9fb3AgZmllbGQNCj4gPj4gYXV4X2ZsYWdzIGFzIHRvIGFsbG93IFBNRHMgdG8gZGVm
aW5lIGRyaXZlci1zcGVjaWZpYyBmbGFncy4NCj4gPiBDYW4geW91IGdpdmUgZXhhbXBsZXMgb2Yg
dGhlIGZsYWdzIHRoYXQgeW91IHdhbnQgdG8gYWRkIGZvciBkcml2ZXIgc3BlY2lmaWMNCj4gd29y
az8NCj4gPiBJIGJlbGlldmUgYWRkaW5nIGRyaXZlciBzcGVjaWZpYyB0aGluZ3MgaGVyZSBtYXkg
bm90IGJlIGdvb2QuDQo+ID4gTWF5IGJlIHdlIGNhbiBkaXNjdXNzIHRoZSBzcGVjaWZpYyBmbGFn
cyBhbmQgZGVmaW5lIHRoZW0gYXMgY29tbW9uIGZvciBhbGwNCj4gUE1Ecy4NCj4gDQo+IFRoZSBm
bGFncyB3ZSBoYXZlIGluIG1pbmQgYXJlIHZlcnkgUE1EIHNwZWNpZmljIGkuZS4gY29udHJvbGxp
bmcNCj4gc3BlY2lmaWMgaGFyZHdhcmUgYmVoYXZpb3Igc28gdGhleSB3aWxsIG5vdCBiZSBzdWl0
YWJsZSB0byBiZSBhZGRlZCB0bw0KPiB0aGUgY29tbW9uIGZsYWdzLg0KPiANCj4gU2VlaW5nIHRo
YXQgYXV4X2ZsYWdzIGFyZSBub3QgdGhhdCBzdHJvbmdseSBkZWZpbmVkIGFuZCBzZWVpbmcgdGhh
dCB0aGV5DQo+IGFyZSBhbHJlYWR5IHBvdGVudGlhbGx5IHVzZWQgZm9yIFBNRCBzcGVjaWZpYyB2
YWx1ZXMgbXkgcmVhc29uaW5nIHdhcyB0bw0KPiBmb3JtYWxpemUgdGhpcyBwb3NzaWJpbGl0eSBv
ZiB1c2FnZQ0KPiANCj4gYXV4X2ZsYWdzIGFyZSB1c2VkIGhlcmUgdG8gcG90ZW50aWFsbHkgY2Fy
cnkgYSB2YWx1ZSB0aGF0IGlzIG5vdCBjb3ZlcmVkDQo+IGluIHRoZSBjb21tb24gQVBJIGF1eF9m
bGFncyBkZWZpbml0aW9uczoNCj4gDQo+IGh0dHBzOi8vZ2l0LmRwZGsub3JnL2RwZGsvdHJlZS9k
cml2ZXJzL2NyeXB0by9jbnhrL2NuMjBrX2NyeXB0b2Rldl9vcHMuYyNuODU3DQo+IA0KVGhlIGF1
eCBmbGFncyB0aGF0IGFyZSBjdXJyZW50bHkgZGVmaW5lZCBhcmUgZm9yIHNvZnQgZXhwaXJ5KG91
dCBwYXJhbSkgYW5kIFRMUyBwYWRkaW5nKGluIHBhcmFtKS4NClRoZXNlIGFyZSBub3QgUE1EIHNw
ZWNpZmljIGFuZCBhcmUgZGVmaW5lZCBhcyBnZW5lcmljIGZsYWdzIHBhc3NlZCBieSBhcHBsaWNh
dGlvbg0KIE9yIGdldHRpbmcgbW9yZSBpbmZvIGFib3V0IHRoZSBjcnlwdG8gb3BlcmF0aW9uIHN1
Y2ggYXMgc29mdCBleHBpcnkgd2hpY2ggaXMgbm90IGFuIGVycm9yDQpidXQgd2lsbCBiZSB1c2Vm
dWwgZm9yIGFwcGxpY2F0aW9uIHRvIHRyaWdnZXIgcmVrZXlpbmcgaW4gYWR2YW5jZS4NCg0KSW4g
eW91ciBjYXNlLCB0aGVzZSBmbGFncyBuZWVkIHRvIGJlIGV4cG9zZWQgaWYgYXBwbGljYXRpb24g
aXMgcmVxdWlyZWQgdG8gc2V0Lg0KQW5kIHdlIGNhbm5vdCBkZWZpbmUgcG1kIHNwZWNpZmljIGZs
YWdzIGluIHJ0ZV9jcnlwdG8uaC4NClBsZWFzZSBzcGVjaWZ5IHVzZSBjYXNlIGlmIGl0IGNhbiBi
ZSB1c2VmdWwgZm9yIG90aGVyIFBNRHMgYWxzbyBhbmQgd2UgY2FuIGFkZCBhbm90aGVyIGZsYWcu
DQoNCkZvciBQTUQgc3BlY2lmaWMgZmxhZ3MsIGlzIGl0IG5vdCBwb3NzaWJsZSBmb3IgeW91IHRv
IHVzZSBtYnVmIGR5bmFtaWMgZmllbGRzIGlmIGl0IGlzIGFuIElQc2VjIGNhc2U/DQpPciB3ZSBj
YW4gYWxzbyBleHBsb3JlIHRvIGludHJvZHVjZSBkeW5maWVsZHMgaW4gY3J5cHRvX29wLg0KDQpJ
biBhYm92ZSBsaW5rLCBjb3AtPmF1eF9mbGFncyA9IHJlcy0+dWNfY29tcGNvZGU7DQppcyBzZXQg
dG8gZ2l2ZSBkZWJ1ZyBpbmZvcm1hdGlvbiB0byBhcHBsaWNhdGlvbiwgYXMgd2FybmluZyBjb2Rl
cyBhcmUgbm90IGV4cG9zZWQgaW4gY3J5cHRvX29wIHN0YXR1cy4NCkFwcGxpY2F0aW9uIGlzIG5v
dCByZXF1aXJlZCB0byB0YWtlIGFueSBhY3Rpb24gYmFzZWQgb24gdGhlIHZhbHVlcyBvdGhlciB0
aGFuIHRoZSBvbmVzIGRlZmluZWQgaW4gcnRlX2NyeXB0by5oLg0KDQotQWtoaWwNCg==
