Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74921606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 19:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=selector1 header.b=fw8YBUVu
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE2E2406B6;
	Mon,  9 Nov 2026 20:39:27 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTPS id 89CB94028F
 for <dev@dpdk.org>; Mon,  9 Nov 2026 20:39:25 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9HK5v0789234; Mon, 9 Nov 2026 11:39:24 -0800
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022107.outbound.protection.outlook.com
 [40.93.195.107])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4hujfgrm70-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2026 11:39:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SCXq3h7qa3Yk1sg5utNNOdC9VKehUjtomvaUZxxiJ1asnpIPw5mO6kd0hBiRWzjZJHpfUPOr0tQOsIAnwAcsXCTgcIY5Zp0JtrR9On/ocInAVrsVNd1QkWaXuQt+Jk0xMYF2oNsuSrWQFXx6TczX0IuB4bDpEMFmhaOYzAC143/jxr2Ej0hjKpGpzW2D16dEJJ86/BDZ6YtuL8wSHg0c92Y5YaZNhJqhpSGCwjkPxbH5hc2SOS5WHcTX+lt+BiELSPVKs0dkbXjE0gh+k8LuygAVtc8+ctblkDknFCMF9a8j5CNl630+RCzuVSVY0rc8Cf3DbDdfJ7uFiG3WbfmAsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YjIKMvNtXe5sCHXYRgoOqhyXKL71T3+h4oFmDej5Bxo=;
 b=QQdx41lDEybrpml1gi7jO9YiDngrldcgdxC1oOJawyALmPBNH95rgI28pDGtXfwEvTTS+iAY/CXcEC3FImYkjjLgdQ2U38J3Mic0cXcZg4LeLurzf85MctdrrQ3gu1KKR3K7o9X0TmNOwBPIncrM1rMtW36Tm8eIcyAoXYLXbwO/594aoqwrDQ+w2lfgfi1be4U5V7+lsaM6VNFlYpdFrc4mxaby7iu2XtgfWTJYDz60o2SJAGZ+hgZPTHZwSpEuOyaqS+GM/jh4rA5deWXZ91uDmrMW31Vcu03s3tq3u6d4cqUSUqj111B0f+WGgsMg9QzBVo+QM6S6dZb6Z23leA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YjIKMvNtXe5sCHXYRgoOqhyXKL71T3+h4oFmDej5Bxo=;
 b=fw8YBUVudFh1kvy0pQITuKzuYjqE0/kKrwyRzdVuB9Z/z6lQ2koyJBmBM1qRNX2MyXR08WTTciYuGY7T+YyQexQlwROd9CF1nAr3DSzXFa/SFMkPCRk+BS4rAqkXcFTo3PK7kjnQF1+m7i/RpqZM/On+hGaOzUyXzO3ofj7+nqs=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 BL1PPF678EF7061.namprd18.prod.outlook.com (2603:10b6:20f:fc04::d9d)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 19:39:18 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%6]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 19:39:18 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: "Ji, Kai" <kai.ji@intel.com>, "Nicolau, Radu" <radu.nicolau@intel.com>,
 "dev@dpdk.org" <dev@dpdk.org>
CC: Fan Zhang <fanzhang.oss@gmail.com>
Subject: RE: [PATCH 1/2] test/crypto: Add NULL OOP SGL test cases
Thread-Topic: [PATCH 1/2] test/crypto: Add NULL OOP SGL test cases
Thread-Index: AQHdVkF3yyys6sUplkq9vv5+jE56obcmVz2g
Date: Mon, 9 Nov 2026 19:39:18 +0000
Message-ID: <CO6PR18MB448488C369A3018BFCF550B2D8732@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20261006105424.1630315-1-radu.nicolau@intel.com>
 <LV2PR11MB60456B879250E8B44296FFD281942@LV2PR11MB6045.namprd11.prod.outlook.com>
In-Reply-To: <LV2PR11MB60456B879250E8B44296FFD281942@LV2PR11MB6045.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|BL1PPF678EF7061:EE_
x-ms-office365-filtering-correlation-id: 2adf52c5-c66c-440a-1a61-08df3e992558
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|10067099003|38070700021|11063799006|4143699003|56012099006|261022075727099003|261022105027099003|261026140227099003|261021135927099003|261028144727099003;
x-microsoft-antispam-message-info: 2N/dnXAVF2bOzSwEd+SWCwkvlywN1z7kEvfvO4R2d+T9gvi5Tanwmr0fFzPOSoXHNEwAAea5hxkoH4UikSucRwmOkp2Zm3GYHSvZNgVnHHQKybHB81bc1Jqh/dpmZ7dV1ndqunlNUytas6Y1E+ZeuhFOxdC2GNb3sxiSo5oU8CbFH0bVXxy28VezBkQWzjZkONzSpFzY9b8cSIeZJMWJjkWb0cld4GkNQDwx1eTHn0ewyW4SdLuezoFyGQlRb3UDf348YHeinWfmgt7WmFu5H/wP+Jw1jqXviaof4V+oaosGe9JlYnE0ItviGzkQNmw1dnpGG9DhwA91A7wZxJWC6LGhHQVuuLuFSwdkuqJfvoDq0GAOqJF/8kJnhkD2VeROwx6pcbT0mqq5R2EswoJS3FiH3m3/IZfUAJ192rPMQoIOZUxObBgwTvafgtDsZfxitO8OoSnXgYeO0sL0ka9Q9TdCqjzF0DVsD1nV2wi/8XphvSgxychK9fwY4HBPnrtSGNlqgO3sCxLQ0gPn3fvGXhda0BbKG6omiDm/CCaTX8zdx6M0kaDXZorNPmtxCZPRcHgTVDZW1cm3a7v7Xr0vxVOGXa27voI4cAL+nEMhqxyGwnGGC2OZHTyvZnYEAsX1W+xps3L4LA4PRqO+zCviAMMSBeu2ivSuF1jrV/3fl2HGYRwjsguFC+N6BlK5jfvCRLMByEqNALfmxyAKB8/llw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(10067099003)(38070700021)(11063799006)(4143699003)(56012099006)(261022075727099003)(261022105027099003)(261026140227099003)(261021135927099003)(261028144727099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emlVQWtWOU5WeEJaaXlTM3N5WExVbStWZHJCMndQYjBleDF0Zm1WdisraHd4?=
 =?utf-8?B?UjJTNVBVWjU0QXBjVVRkV28wNWF1QUdkRTVQcUNXVFlmRHJWcHIyVXpQWkFt?=
 =?utf-8?B?bnVNYkF3QStCSm4rMHJSMTBDemUzSURJTUVEM0FzZUx4dkhSTkU2eVJMM1or?=
 =?utf-8?B?T3c2RWVleXFZR3N4T3RQWHNmUUF3a0dmMDFaUllKcmlxbnR4SjBNYjI5bXpC?=
 =?utf-8?B?VHF3aEJjRkUxL3lpQ3BuWFVyWXZ2bHREWER5aHluR2JiRSs3NFhXSWh4Y3hi?=
 =?utf-8?B?ZlVyb0dXNXdGZjdMNER5Q1JURHA1TGVSRjllVXZMS1F4L21ZeTNhZDROSW4r?=
 =?utf-8?B?b3lXcER1aG9wWmdLTEUxdk95NXpIWTI0aUdXU1dUMVYvbUozZjhnMTJiN2Iy?=
 =?utf-8?B?UElhbzN4ZVByMWxzMjdPNENZdVg2V2oyYlBRYWRrTGFMTmdzbjk0ZGo3eGVP?=
 =?utf-8?B?a2I1K0x6YUxENTRlOEFITXdLTDJ6QldpVXNieWRYb3R6bHpNTjZqeEJzM084?=
 =?utf-8?B?dVBId2ZoNHg0SE1yb3NaQXltYncxN2JTbXU5UDAvRjBqd0U0cCsySENtOWJW?=
 =?utf-8?B?am9yalRHMFI4WXJock54VW1JMW9teGZGa1RHSVVncnBLSEpoMm90OFdOeC9s?=
 =?utf-8?B?eUFlbDJtR3ZNeEs1aXNSRmlUZnQ2ZVBmcVg0NlptakNEd0wwUmZvS1I4dnNy?=
 =?utf-8?B?Y3p0NFYyTFJFRDZ2UUdqSWVvSC9FUCtBQWJGb0tNbXNMYkgyVDRUTWVXY1Fz?=
 =?utf-8?B?THluTDB1YWNkSDZENm9oc3FOSTU1NlpJOWV1NDZhOG90TENPNHRFd3FRV0JR?=
 =?utf-8?B?RktRZFJBUlVxMkp6eU5DdEN2YXRqWGlqOU5sWk16aTFhWENlaE85TWpJczJX?=
 =?utf-8?B?aDZ3Z21nYWViUVhTdUdSOXgxaTNRMjFHK1pSZ2dWNVp1S3NCMFM3YkhzSXYz?=
 =?utf-8?B?UWpjRlFJdmNLc2V0L1NOTkZMQkh3SjEzNDlqRzNiUE1KQ3VyMW12ajA2M3Zq?=
 =?utf-8?B?eU82aDY2SFkzWEVKMHF4c3dJNWtKUXpza0YvSUU2SHZPK3lNRUdxM1VUQ2hw?=
 =?utf-8?B?T2RFQVJpUFl1MkZONVhuM1hTSFdCWDcwYmNYdU15S1lGNGdoeHVsbmRVY2lJ?=
 =?utf-8?B?bnZZZ0VRMEl6OGw0ODJNdFVGQzFUcWtWaTM3VHJHL0hlUVRlQTJXcFlyaFha?=
 =?utf-8?B?NXAwUlozZFc0ZGNjbktMQ2d2dnRyL3VSMGhSUXludXJVM3ZmNzhLZ2lReUtP?=
 =?utf-8?B?R1FuNC92eFgwT1V1andjUE5qUWV6dk1oc21NaStFbzE0ZWxzTGk3Ry9OSWFz?=
 =?utf-8?B?azlQdVNzMTNyd0hmb204bjROK3N5a0tybVNKeGxzU2J3Q0xxbThvUG1FQ1Jy?=
 =?utf-8?B?YXFDUVJZYkl5OHdtYWdFdlZudWEwRkxiUFBsWFZaL0NMbXo3LzNNcmVwZXR6?=
 =?utf-8?B?cjd3akZkNys3K05HU1BsUTFNQXZVYU1qSkU5R1FTajcxZitUS3JNUE1Ka0lw?=
 =?utf-8?B?MEIySTdrN1dxaE9WL0NCaG5jaGJWY1ZwUm84NmJsbElqVk9lTkF0MldBNjB1?=
 =?utf-8?B?RUM4VFNpak9qNHp3elN1RzMydXRtT2lVUVlaaHR0RW1iUGVPNTNtQXRIakN3?=
 =?utf-8?B?QTNaMlp2QzRoUVJKSnF1OE1LYVNFWVlWU1JzN1lmRFlKUko5ODVkMWtqQ2RM?=
 =?utf-8?B?UnZvZzcwOTRiV0QwRUkwbUx2K1dTamdWU2FFSUVlWm9pNW4rdSs1YXhxUmFN?=
 =?utf-8?B?WkZ3UFJQbnE5dVptVjRzN29ud2ltTktqRHBXVzMrYWZhb3daaW1vVjRkaVJw?=
 =?utf-8?B?YlBrd0FrRFRLR1A3TG84UGppSkxKQlk2TmR6b0xUS1I3MHB6Q3owNmh4WElv?=
 =?utf-8?B?TFVMR09uUDQ3TGdjb0IzbUs1V1BwQUpkeE11amFMaExwcVVjcTl3SHVRVXgz?=
 =?utf-8?B?ditXRHRyamhIbjB3V3Z4NzEzRnZrbWJoWTYyM3UyL3dxbUVHL0cvR2twVWNz?=
 =?utf-8?B?UVJUTk9vakZmcWZ1SnAvQ2t4YnQ0THRrT2NIM1Jua3NqSnptQVh5dUFSaGln?=
 =?utf-8?B?WHFIek1ubmVKcU4wNFlNa2FVK2VhMldhUFBQZ1A1MW9TNmpPTW84WHAwVUV3?=
 =?utf-8?B?YlNxM012Q2M3dTlMSmVERm83NnFaVDJkNXQxWjFYbmNuUGY5Q2l5RDc2SjlY?=
 =?utf-8?B?Y2VoTUxtR2oya09xb0VYcDJVa1RUMFd5Vjg3OUZ2eDdOQkNLdUlCZVhJV3lG?=
 =?utf-8?B?dFZ3OTBlNytXeVFyS3NwRi8wRVlHcmNDZGlFM2ZaQXREV081bVZwMVM5SGpP?=
 =?utf-8?Q?L6RoB8B8OF95Oqzn5U?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vlachPO9jIV415cD0f61qchatM/ttYoUBUOrAif2CQKpGUoYXKOxqn1LUrZF3PSlNODHoHFY2dOf+KsQRH/CKExT7HZcDJxl55EbKT89xi9jvjkG6MEOXn5+kvjRJnHjvkFgxg41mHxYBEiha0MfMmcu2OOAIAXNJ5tua+x8uOj5M78XqKBrUzgp1VKGqRpBOjUFkDF2bG4ypycS9EWBWeC05TwM4rBp/5w/4lhQvhzuZkDGCV4P0keOTDYVkGyU1a5wllvKkpqA5LYw0iv/zl5sTYMLt/9UvNZucGcXSwO3oW8XhaXB+tQxxgEwHiMZ4PMX5XrycCf0/5OXaOCOPw==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2adf52c5-c66c-440a-1a61-08df3e992558
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 19:39:18.6833 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6XsGSPiy63L/sQLzk+eVWBz+Wq7tzsjqJ4RFWQAmPw0VT/K6zhGV/4ncCCg7mlaaZVD65lae3zuuOXU9vBxOtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PPF678EF7061
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA3OCBTYWx0ZWRfX4zc6XfT/1Dsw
 whLlnA1AJtFLtysxcYEQzR09c7HeULGJronyx4I5cKZaMOvA622Du0VgckJbwHtpla7E4qHrXoP
 6h80pwv1VeWiIM+IoQp6ZMbTFNtPEAY=
X-Proofpoint-GUID: m_z2livvH07Ho4NKzymB7ZGfrXQFVSJr
X-Authority-Analysis: v=2.4 cv=F5nC5ahN c=1 sm=1 tr=0 ts=6af2216c cx=c_pps
 a=8M1Omf0bnxBxzy+yzgHWvw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=QyXUC8HyAAAA:8
 a=OwylmeCehev7LjY_zUQA:9 a=QEXdDO2ut3YA:10 a=XqwKkIuMdFcA:10
X-Proofpoint-ORIG-GUID: m_z2livvH07Ho4NKzymB7ZGfrXQFVSJr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA3OCBTYWx0ZWRfX7ELDG3JYpc4Q
 R8FEyv7xsmrV/lUouL5NwDt1NuuYkaxdJ1tYgcIaHijWtpTQX9GmIfncn/rNbFz5aoKVC4duW2l
 NDNDoDcyXy8Pl94ueV5qg3ERU1/r88t1FL0g281n3ls0Poo5pX1nmVgHYetNxbPP0Q4KtJ7KWqK
 S4F9Dz/3EtIkYQ5gUxfqwBQAjf8lVLG2hPVOBOFelV0L65fnaUs0LmLrBXRWqQC2gYckpMe4QwX
 UfuZ+Pvn0e3UInnqBq1HeFgk5eJb625cstbUgoLf3QWg2ULnSxGAsIITINQdJDhgFdT5P/HrvsU
 BnjD/+otTq2n84wrlL3Q+jQUn88jJLUBb1QaXhD6RweEc4SBT6SpVLnCdLQYQWpKBtph4Eqfx38
 TPatPSKu5x2k8SDJ6DCVnQvj6K8BHfXKATm2TZLLL0lPlN5bsS5r7FDZ7o2B+3wVv4gt7MRiZ9Z
 1fOZwficnAohh5ilMaQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PiANCj4gQWNrZWQtYnk6IEthaSBKaSA8a2FpLmppQGludGVsLmNvbT4NCj4gU3ViamVjdDogW1BB
VENIIDEvMl0gdGVzdC9jcnlwdG86IEFkZCBOVUxMIE9PUCBTR0wgdGVzdCBjYXNlcw0KPiANCj4g
RXh0ZW5kIHRoZSBibG9ja2NoaXBlciB0ZXN0IHN1aXRlIHdpdGgNCj4gTlVMTCBjaXBoZXIgYW5k
IE5VTEwgYXV0aCBPT1AgU0dMIHRlc3QgY2FzZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSYWR1
IE5pY29sYXUgPHJhZHUubmljb2xhdUBpbnRlbC5jb20+DQoNCkFwcGxpZWQgdG8gZHBkay1uZXh0
LWNyeXB0bw0KVGhhbmtzLg0K
