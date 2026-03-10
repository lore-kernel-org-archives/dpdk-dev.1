Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F53DFCC9C2
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 05:19:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 58854402B8;
	Tue, 10 Mar 2026 06:19:12 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 8335C4014F
 for <dev@dpdk.org>; Tue, 10 Mar 2026 06:19:10 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62A4BqXs462268; Mon, 9 Mar 2026 22:19:09 -0700
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11022084.outbound.protection.outlook.com [40.107.209.84])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ctc28g3jx-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 22:19:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J2YVy/zrZH01SSyevM8v2uYT+ccAqvT+qmWvr9rMWLZNzxls6J5Uw8luFjkONe/SpjpHaZPcb/tMzlB+TcYIv2epDmRwXg/d2UVHCeEbU0ZZKLOgZdy5wgxV2CaGaKJpNfH0FMtqcKLNotKdTJKxOzQI5PD9b/9JNB9/ebyRnv1bg8TmM+aVuI6jr23nzUzO5w0RW1x1Cmq9gT6JredP7l4v9ET0koWNIByBhqESTurCR1F3IzdtX43iF9VdVT6HfEXaSKSCBZ/8kZoiNiQci66UW8x4a2Icwn7YiB+72I6pA/Gc5PgCm7/PDsEHIdZ0pbu0NC5D+wzPkE7PjiCmgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QjRq7O24t2pR0l+rbvkDedVtqN0Jtzt1RsxFlKZHfGs=;
 b=hqusuwWa8s2Mq0/an5c5BGr0K7NoPSxUe9KoT4hXiEZL27hcIbercsS6rO2D3TyJrRL+cw0Zv7mLtYxHJ6ZM+Gy6uXtbwy1PraYKjh2FznL0DEdYDthQLXXi7pEWGPECQVQUDSr5Of1QMh0LDflgGNgyTBgqpwX9cPXxLuX41iV1iueD3DH0f40IarmWpVQDNH3Jzl/HuvZNfa6t+Y0o1qNND6J41GAvc4AT0VqJ36Qu4yclaYHNoHnlRc0Uk+oVaE9gdUaubx0OirmuYD1LxhssVUJh2dFxMs/WcBAbTQww4v0rprO7/G8AeuFtQSRFRffDOw7tdWmkFtRqSSlyaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjRq7O24t2pR0l+rbvkDedVtqN0Jtzt1RsxFlKZHfGs=;
 b=txWK2NBDnGbXq1iHn02RgL9xolFzCEdkDLe70htk/3CA1tQsFAzMUkgdVa2nMfwc6lzvtoTQ5UoniSeXRqy6Ds9t9V/QUA6YIT8LK3NZ0fWpkzocfD7/OdBUOmYjtWJ9JDkyUSxvZCYgmNoJzGQEnsaPVv0NrvBYn+jgua1+ezw=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 IA0PPF36477A5DF.namprd18.prod.outlook.com (2603:10b6:20f:fc04::c14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.20; Tue, 10 Mar
 2026 05:19:07 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%4]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 05:19:06 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>, Rupesh Chiluka <rchiluka@marvell.com>,
 "dev@dpdk.org" <dev@dpdk.org>, Kai Ji <kai.ji@intel.com>,
 "pablo.de.lara.guarch@intel.com" <pablo.de.lara.guarch@intel.com>
CC: Rupesh Chiluka <rchiluka@marvell.com>
Subject: RE: [EXTERNAL] [PATCH] test/crypto: remove PMD specific asym
 testsuites
Thread-Topic: [EXTERNAL] [PATCH] test/crypto: remove PMD specific asym
 testsuites
Thread-Index: AQHccCf52IRVx+pnVkKcwpvbtr/L+bU59gAAgEKdUMCAKychgA==
Date: Tue, 10 Mar 2026 05:19:06 +0000
Message-ID: <CO6PR18MB44845EBB28C98856A0C4BE8BD846A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20251218140909.1816595-1-rchiluka@marvell.com>
 <20251230090326.3881821-1-rchiluka@marvell.com>
 <CO6PR18MB4484FA2C0961B4104C1A438BD862A@CO6PR18MB4484.namprd18.prod.outlook.com>
In-Reply-To: <CO6PR18MB4484FA2C0961B4104C1A438BD862A@CO6PR18MB4484.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|IA0PPF36477A5DF:EE_
x-ms-office365-filtering-correlation-id: 86ffe508-2a6d-4947-5a64-08de7e648d80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: kfCRJNnlvQceOG2itELWITDSFpfi2svpWs838hzfdJAcld3WbuA08q4f/c8ETw1dZn667La7pBrnHZMm4wwAzX7UoK4KogrAlKVpiW+9mFcFnDx97sog0VHPwFHG5aJ/OUcJ+5PRfSHGZ/7WQ8Vty7fbJZFCk7EA2/ZrnEWCvmpa6jWHENs2zBXzQImnbUKDZiWriXXM5DWr1BfdwOEz9SAum2fVx26e+Zp5kM8kAY9MfnajGWFxDGJtXcp4eiVNT0DdMvQoiRGuuaimKf9Kk3ipU4/9j3R/BwiN0su8xoZCcyEmldeGrWlPKdHq8O7zs44gQGNP7scRBA0tBZXyj1MF6H9stk9yW+pNpHslrerIpc6Ad6q3vBzYFDK/qWprcMZM1JyOZWj4X/n0lH/hYR3VpUaRRcgqaG58/0dsAtN3oVEMgON9gDeCpy72+3IxNtmNEZOWGj6W4w+UtRZQSdG7fO4EvCokYTRoPlPsOb2gFXKunYVNfJxLeusJqFGi1X8jEF3WAQKWL3BO1LzBzXROZZN3EHwFiFzHCmTzOEV5OpCORVwIFeB3HYuaqTL/U+5PD91RrqzbapUcmuK8+kRZtQDaJb8l5XCQxUViq6WbjzlHXF7Uz+dtVpaqIk47eCV7YEkaqnskY/eQejVGNprT5tF+21KSZOSuKNib8UaEvcc0vqXvYgVa+AwnSRVhJm0fsRm3GYOX74Qya88m4vJi8xQRt+SPMr46MfkTRZO1JV56TDbMTEDlSvCiLRwuA9U7bjjLm2m3toeHLe9L5w3+n50yRcE3r8SY/pJQyHg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVU4cjgwejhtbUtJd2dLOGxhQ0dwdWlEVTU4eTQwL0FUK0t0RTR5c2tNU0Er?=
 =?utf-8?B?MGo1WDg4VThXTkJzK2VpenlPb2p6Z1JMYjQxUGdYYnZNRi9VREpQTkRacm9k?=
 =?utf-8?B?K2tucXg1d2Y3dmt1azRFK3pVTWhhNURBNk4wcDVCSHE2QXViR1RseHg3bkdJ?=
 =?utf-8?B?ZVc2dDZRSHhPdWVnT3BLbjdwMVFRTGRLVGQ3aTNTOHNNUXJWWDJQeFlyTWNR?=
 =?utf-8?B?SHE4eWJxREFTRzVOTTc5a2pmRUFvdThPdnIxRGdlMmFTN1pQTzNZZGNyWFZJ?=
 =?utf-8?B?aUZtRTJSaGJrRTdHVjRvYm9KUnREUTg4Z1orL3hHdjM3REJXUU03RlAxMmVD?=
 =?utf-8?B?amZzMWdUbjJDdjJPZnRIUE5YY3hKQ1pJejhkbzVFSFlRMVIwWHg0RGRIOTJ3?=
 =?utf-8?B?Z2w1MFlvMzg2enptWGxuSFluQlc0dGhNOUpTWUFKWHpUNm90WDYzVUhSSjlF?=
 =?utf-8?B?ODJwUDhGUUx5VERTN2VSay9Lck8vTlRhbXRlRFc5T2t4SWJPMXkyQUhzS29i?=
 =?utf-8?B?dVV0K01hemhGZFVzVmtlb0FnVkl1RlBXb0kwVklQTnBxTWcvdGtkRUYvOFNP?=
 =?utf-8?B?NnUwTm9UcXhnemI0SHpXdFpSTmphVVFmd1plVVpRWUI5aHhpdm51SnoxMm8z?=
 =?utf-8?B?eGJqK0NkQjE2ZURGRmNYbmIwM05oeWhKeEJYRSs5cGRiRWR2ZE5yb3Rac3M5?=
 =?utf-8?B?d2ljLy9lY1lGZS9kRVdVZWJSanAvZnNuSC9xck5MZUI0TjZJVE9TVFI3NlJW?=
 =?utf-8?B?UkRmZzFBbVVHN3V2eFViTjBVRmxwWXo1U0l5cTlMNEFtc05ubjVZVGpMT3Zp?=
 =?utf-8?B?czRjK21PREd1WGpCSFV6d1hUb2ptUzJlYTU4TDNSUWFnQnJ5OW50V0dqa29P?=
 =?utf-8?B?VzdMdndud2xjMTg1ZUhqemJFWE11MW5SQ3ArLzByNHYwdWhwMFJXL0o1bzN4?=
 =?utf-8?B?ZDlqTU1WaXpkVWtMeGNLVmhmQXA4MWdMVEZxUndQVm5SUndZVTlnSzI4TEg1?=
 =?utf-8?B?dW1TK0xGSUhaZ3Z4bjhJd1BEd3BqSnVPT09OMVBWVFc0djRaMnpPbFh3akdD?=
 =?utf-8?B?WXd5M0hPalZ4bjduNC90UU03N2U3cnQ0NXcxOG1ZeWwvbkFmTWRKZ3Y4WFlG?=
 =?utf-8?B?eFVqMUg5M0JwRlZnVmYxMDZhdUVLSlVQN3pSWkZSNEZoekRaSm9XUThsWUtJ?=
 =?utf-8?B?R0kvSVkwbmt6RmRDQk9PY0lWU1MzUE00aHYyZ1VjRVUzNmZOcUt2Smd2c0lq?=
 =?utf-8?B?bm9xNUZFZktyZS9pcmd2Z1lpbHY3ZWkyOUl2MVgycGZSRk1sZThtK3UrUWNH?=
 =?utf-8?B?N3VvNkdFaTJ0NEN5YUFwUFJIRHhGSng3S3JCS2c2MzhWY0ErRDd4NnZNendj?=
 =?utf-8?B?eGswNXdUcGlnSmFHNVNEUnhXSlBSTXpacG5HUUZKN29wNW95VndUbFhvTE9i?=
 =?utf-8?B?S1FReGRDU05sMWF3ZUM5WkRYV1c0NWNBM0szaEpwdjVFZVdoUXVYTnJzcE0r?=
 =?utf-8?B?WWcvL3BNdHlMSDJWY2ZDNjA1NWpwVjFSOFNDZFNKMVpLMUFQS0twelNYenRy?=
 =?utf-8?B?VTFIdnNWY0VSV3lCRUJ1M1VoSU8zOVZPbkhWYTJyTjByK1Roa1FzU2NpYnQv?=
 =?utf-8?B?WVJMYlMvV0x0KzF6N1pUNFZTQkFLU0FoaStWUzY1Q1hid2VNMGNwVzZDL3Mx?=
 =?utf-8?B?SmZCYlM2MzRNODVuVnpHaWxpSW1HbGlkVlhINWE0SGJyMzlBQzJOVDZEMDNT?=
 =?utf-8?B?ZkowMm4ycHRWWXVQMWRTbDZ1NE50MHZRQkVsMG1yV2hyYzU4UUxaa1dSYXBF?=
 =?utf-8?B?YjIyVXpoU2t6cU5ONG5jNWJxMFFtVXpEWlpQNGlHazlRYnFDL204UU1yZVVj?=
 =?utf-8?B?SnkxRlcvd094bVpMN1ZtMTdiOUtLcmNVZm12UEVGNW1OV0wweUdaZzR2dWtq?=
 =?utf-8?B?TDlDVmZiUVZsK0NvREV6dU9sZ2JtSTJRcUpFbGlpdjYzdktjMnhpK0pMSnJF?=
 =?utf-8?B?Yk9seEczZC9obHM5cWgraUtqMUVlRmNkWFJwd3JwZTlhbnVLM08rWis3M1Ro?=
 =?utf-8?B?czFDbVc5b1M0NmxuamlyR1pMQ1o0V04zL05vMTY2bEtJemsvdjcyejRSNWta?=
 =?utf-8?B?bUJlVEN3aUkxczErMTcwRTBDUmtjSlBFZ2o3WVJJUXJDQ1NlcjV3RGtQWU1y?=
 =?utf-8?B?eFVzbDNoMnFyOExyV0pYNlRRWkgvVEJ6OGRIYkMzb3BkQ3NXdGFpVnBESFBt?=
 =?utf-8?B?TjNRMTg0eTJXYUttQ1Z1R2p1bFhacnlMeWpxWlNKTndQOHRtOXM4a2FMTXNE?=
 =?utf-8?Q?MUYJ2Gdr9otYfuRWmL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ffe508-2a6d-4947-5a64-08de7e648d80
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 05:19:06.8910 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FQIPljxzZuYFt9r54UAPvmy3sN11MPpJCo6UhuAOAPZ478CxM7slPO/KOt1nrKClqEq6KVoeCxtJ0artlOAvzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF36477A5DF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDA0MiBTYWx0ZWRfX0leUI2FBM375
 OC/XtsYqvHu4z+J0xkcobYsjQncS5E3h1Ia4QqWXHMr9jp+OivX+OCOEt+gYFncm0D6wySFZUJO
 g+Ql9KLmTLXu39gza+25xJlZCwWkbqrr0o2S4kaDuoDaUKFYi/sCUxENWB8XvQRuY6m9LIZPndv
 mtTBOXOc2HWvi3+2997yfzTOSTWM94hFcCJh+0owI72SR87SMUEIE0UQTRZ2Eo4m1p3T4nI8fXZ
 rCgZzZX+rA2X+iorJmeU1DGm7iQRxHEzfeyLiBkjfQ6aJtZk8d0se5ygJwOyiBd+2sWWMnGzMGn
 e7oRRUpQimdJm/j40KsDrlMkkphTv0dP/b5mDd/y7y1TIVaflzMcvSgztokCjCSwt7BhRig4Od8
 0SMzpKS5dfzVdKuWttvxjXiDSE78NVuY7RY09vD2jntCSp5GTx/kCIVjjBfQX3jKPkwCLZD0ZMS
 NuqW/nyV6dbkc+Va8Xw==
X-Proofpoint-ORIG-GUID: 9mn4WnV940xU05ChtFoj4pXazZ7AnTg4
X-Proofpoint-GUID: 9mn4WnV940xU05ChtFoj4pXazZ7AnTg4
X-Authority-Analysis: v=2.4 cv=XtL3+FF9 c=1 sm=1 tr=0 ts=69afa9cd cx=c_pps
 a=NQnYyjwfQkqppbiA7sK3Qw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8
 a=jKOsvKlyTpk06HaNDXsA:9 a=QEXdDO2ut3YA:10 a=xImrzNact8EA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_01,2026-03-09_02,2025-10-01_01
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

PiBIaSBLYWkvUGFibG8sDQo+IA0KPiBBbnkgZmVlZGJhY2sgb24gdGhpcyBvciB3ZSBjYW4gbWVy
Z2U/DQo+IA0KPiA+IENoYW5nZSBQTUQgc3BlY2lmaWMgYXN5bW1ldHJpYyB0ZXN0c3VpdGVzIHRv
DQo+ID4gY2FwYWJpbGl0aWVzIGJhc2VkIHRlc3RzdWl0ZXMNCj4gPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IFJ1cGVzaCBDaGlsdWthIDxyY2hpbHVrYUBtYXJ2ZWxsLmNvbT4NCj4gPiAtLS0NCj4gQWNr
ZWQtYnk6IEFraGlsIEdveWFsIDxnYWtoaWxAbWFydmVsbC5jb20+DQpBcHBsaWVkIHRvIGRwZGst
bmV4dC1jcnlwdG8NCg==
