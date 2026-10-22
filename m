Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B56F606A319
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 19:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=selector1 header.b=GWIOg9hy
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5929F4027D;
	Thu, 22 Oct 2026 21:02:13 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id BF6474003C
 for <dev@dpdk.org>; Thu, 22 Oct 2026 21:02:11 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MHtJNG1864390; Thu, 22 Oct 2026 12:02:11 -0700
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020110.outbound.protection.outlook.com [52.101.85.110])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4hfmdthmub-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 22 Oct 2026 12:02:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cnmTu1pYhvlUhixU9uAhmX7s+o+leO3We44Z+4kjJ+xxhShirYB9u6W8HUS+m2cbFPMOulFtpvfQKdpcFCMFICxkRL4tge46dmPnMG6XvtXuZmDXrc0VB69VKc6mFL2bmXAuBebx8CMA2qGIZhhHaujRjzGS3mf4s8I7hivUhQ5xlwWBBa6tGfmo87+MxoKyV1hy5TZlTe38llZlh0tigTBq/wQtsjLv1GpngxlTJ6cDLpkZUy0syCLivvmiQsVvoE1n1Y7hHVWCF7xyBjgUkIjNR2/gWZJt01YWwAJDJdQYK8LBkA9lnitsPQEaM9Cv2y+eFDkk/I1O4UB1Qf4QTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yzs6Zh7EiYNJgpKNTYJmx5oSoiMUvM6gDsuNKKuZzB4=;
 b=Ak6YKG5wspGFpWwT7dh1xXpsaSv+593tLFv3lNjpeitqcw8C/kkXFDsw4IgvNPIrbaklZxj7VIJVcrmC2BMZolHfBa0WADZ+5e3pUHAsy8x0i2V9axfCKiWs4mYV3qb5zyiv19uPZA0mmUiQBvJpv76J2RXtSxlLz4Uu0HmNgF4iIoSM0TrEyu+hY8t+KQRuJlqO2e8SJTIKRxX+1CUoF3SV76nF5KD/IJ/0GFDFCW70KgjHpNOOHaDP5GeWAGFcfLin8jw/CG8angMmaNHlnUPVOyfAwsYr2Z1MwYqAu6K/lPylgrYD5wmOoj/VM7OLAeodu+XpzkkjBy7kZ6Zu2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yzs6Zh7EiYNJgpKNTYJmx5oSoiMUvM6gDsuNKKuZzB4=;
 b=GWIOg9hyvuJvoyjv7jJkZsFsy3gJNw5MlaE8pycvR5Retb8sJE94xxm5k7ab4HB4HwIYjDscigF2MMcu4UOCQEOfQ7vGOCblXL/SeJOfIfjTcekmhjZJsqe/7i2xOiGbV+UC37TXLjEWzzt5us+/N8xPCQYYqf2yCXAmFrVbnKE=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 SA1PR18MB5993.namprd18.prod.outlook.com (2603:10b6:806:3dd::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.14; Thu, 22 Oct 2026 19:02:02 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%6]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 19:02:01 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Pratik Senapati <psenapati@marvell.com>, Radu Nicolau
 <radu.nicolau@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>, "Ji, Kai"
 <kai.ji@intel.com>
Subject: RE: [EXTERNAL] [PATCH] test/crypto: add test vectors for more ML-KEM
 and ML-DSA variants
Thread-Topic: [EXTERNAL] [PATCH] test/crypto: add test vectors for more ML-KEM
 and ML-DSA variants
Thread-Index: AQHdRo2zz87Ht+1KnESQ1CQ7Vm3sv7bSma+AgAAEsICAAD7GAIAKxgoAgCpRsICAAi2BUA==
Date: Thu, 22 Oct 2026 19:02:01 +0000
Message-ID: <CO6PR18MB4484D4254B6B89239ED0F89ED8652@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260917101641.335926-1-radu.nicolau@intel.com>
 <SAWPR18MB988310BC52CC8B4B771E060556CBB82@SAWPR18MB988310.namprd18.prod.outlook.com>
 <5ac0b690-b340-4cfa-90e6-33cac4c30eac@intel.com>
 <29a23773-d16f-4065-859f-f85646442cbf@intel.com>
 <LV8PR18MB6078C87C7F16C9DA0692213CBD812@LV8PR18MB6078.namprd18.prod.outlook.com>
 <LV8PR18MB6078406BE61F93954524B0D9BD662@LV8PR18MB6078.namprd18.prod.outlook.com>
In-Reply-To: <LV8PR18MB6078406BE61F93954524B0D9BD662@LV8PR18MB6078.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|SA1PR18MB5993:EE_
x-ms-office365-filtering-correlation-id: f156f3c2-e48a-47e4-afd7-08df306ef4ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|22082099003|18002099003|10067099003|11063799006|56012099006|4143699003|38070700021;
x-microsoft-antispam-message-info: 3kaehYwQbXYGN3XfquRKIXl1nvkq9skGQIr1SGoj7KcGj8Z4nGdGUk6QjLx6CIj0XSIp23M4vAnjdNZ5DnbNf+E1dqGmXyVPPnSwN7Z/dqkYGj5HdFmSIIr1vWwgoe+0z+OpFAYjXyGGk68AT/0ed0OutOEnqNWTJIpDCWBfYjYPrv72vIE+02syt5pm6TvNboAVM8lHKmN0OzWy84d89EN4Rr72GArc2aNuJ2oYhNOmC1aL/G1Ta+2b6WyyCxlbbFJaPv6gZ3eOSsKvbcFTCB1hxTrh/tIdccQ5zXVABb07k7qr6Xw+Dz+CNf9x77TvuYs1JFgkt9WfclzqMJILbcMSrwuCEDac+g6qS9vS0yLH+5T8j3heIlK7R51GnquKnvBrTA3A48Bb8UOQqtzsIJGfSaSDjY24Xw+nr69xuDjhYqEmVg7rC+u3ZnmnYNZyj1Vl6/URKAA4j+ZJCjrJysjXv7uxb4sbVJdHHIzrqg215YhvgTT7yxafZCiQcgsTonKTgFuSVIAOaCftx1jEn4lKS+YZsRc/cr1j7NuxH2+a2cf3A/6aobHsXYxUjTz8J4qzid5lV+0AMYC65zoMA5S8dvfM/bDr551P9OKFiBaD7W7UaTBaxbLNBgRAZdEeJx9gEyxayGMb+5KB4WxXDEaumuBAV8UVOqC7/gAUtSvtDFWQ6yYiyK6xmx/WYsxKSdyezp4YyUw0yx/e5YGlzEEhQJnSIzPixA/hiHGvxos=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006)(4143699003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W9JikFq92DSxPr1/ZRMRJajaD5OSQa6SKEylD++DrGx/n2jgzVREHGqRE5/o?=
 =?us-ascii?Q?vmva9M7vnBAnGdYurXBRBppkefE5Yjxcjlg4k/8lYcZOc7WSCDIlujiF8fzZ?=
 =?us-ascii?Q?SgOvL0/5pKDL+vI9VFRA67Ooki/QCgQnZHyL7enkYWgSKnjGW2toMukeJA0m?=
 =?us-ascii?Q?4M/ep3x57Tsx1iz316ih1tEzMs7rYFj7pymjy6rev4B6nnOD9MR7XMbwgpqR?=
 =?us-ascii?Q?mYRpCgg+ato6nZCO0IYMMilzp2ZoF45X3Lbgx5wYHc504zYskjWh8qWUvzdx?=
 =?us-ascii?Q?FAab0ZbL8ypa4+RsbPBvZQgZUl5LCHMj7j2CzZP9X47Uo3wCjozaX0tQTg+Z?=
 =?us-ascii?Q?xXU1zHQo6/g2NEYfU4l96/lwTDATss8WNdEdlFJWVyNUKxN7I80S7B4Qmf2a?=
 =?us-ascii?Q?kWsslTdY1waKryVcXEz4Ix08cGpsTXfc5HX87/zbhQOQT8kmLC+mIiDG30aH?=
 =?us-ascii?Q?zXOKG+9WniwxKgwrO/Rt7eeVqiz+TIWIMAlbipKZ4+sy779zKpkmxu98UBLl?=
 =?us-ascii?Q?yapcXn6XxKoY7QPZ2iSwbvGkxzNwYtYI5DwG7PRmiE6hPb3jlKRQdf4cs4tk?=
 =?us-ascii?Q?JvjWBzuZGm4jRt/x6WSDakFfAvP/yzhwJHXcKwYgt3O3g+r6GX7eehK/AH5f?=
 =?us-ascii?Q?SJF5dlGDFKc1WlLGsAqRu3RB9e7ufn3oKnVg1ezCsSfGrjrCNPlEDVUZVFZJ?=
 =?us-ascii?Q?QoQ7KLWbtRU8oH0vkefq4QFaku1fFOqrISOr8LqwGu8KUgBsWoya3x/doLnq?=
 =?us-ascii?Q?U6cF+QiLqHp3x2RMSLZ7RBlEAUAdFQ9kvq598XFsW6/CIElWP88CSkTSAl9S?=
 =?us-ascii?Q?5MqKyC/612X2usF8ZLzJWpQ2hzGUOHMmPShEEHQl7UpMC9T242Lyn42ccgk7?=
 =?us-ascii?Q?W9x7s/+xDOE+qgGglDkZcgAPQGsytPLhZIZbkKEe4+qSYfTfgYWgG4o1hLwj?=
 =?us-ascii?Q?rQ5pxmpT0EUkZg4nbepfbPPOysmYU24HIaaiICFbiY9yD82Og95r89yLI5GK?=
 =?us-ascii?Q?o9eqrPJs849XuezaSw33J+/7a/pLJc/CRVyP/Mo1NOxFDDd873ocKyrk08xa?=
 =?us-ascii?Q?c3wZ1gm0BHu1xkQOesJ0wuDPMoq3vsa6KLHhKMPZrkbmhRFudMIkUr9b0oCo?=
 =?us-ascii?Q?JgItt1gXy2wqQ40DXJ6EtBlbSUQHO+GGJ+o1+/F3OE/aLZ++k5G9Iq/Hhq2n?=
 =?us-ascii?Q?nN/o+QJ6lkj2Gh4FNJq8IkhGAPPxe/1n3B8NmqczDM9pSclYzsle84rvulrR?=
 =?us-ascii?Q?952BBMfHxcyLiuCcadZKbfw7Bh3xJbpEkcDClJMKhH8U+67mVipu+cc3lcF2?=
 =?us-ascii?Q?0jSAwxzmMiZsNOPge70+JIjpny2KYmF4+y5amgmWXxwTtDqKmAV8Xr52pSHc?=
 =?us-ascii?Q?YO1hFwkVfKrZlelymC8WLDuoqXIwOXEG3J9EHUybs1IK5hIQtSR9M0YL3vVP?=
 =?us-ascii?Q?5H+xmXzK+TjvJbTKQgiYX0QhmUfWo6KnXHYsQwZMc0FuxhSoJxzZE/lPFUHL?=
 =?us-ascii?Q?jG/DixyPIaoyMBMlxJuACQrgmBeNw74yfw6pLpAEGLkEFsOQZKC+E6/DXESO?=
 =?us-ascii?Q?BN0dGWaDkwYWB/2LvSOd9il5H+KQeCYQZiyBC7qmt3ku+dSTwHa6J55GyjUb?=
 =?us-ascii?Q?2S22PlwbiJA1mSlW2iNH50o3hkpf9exLxn6gwxxcUvT4EJfN/fHEHQGpLQQu?=
 =?us-ascii?Q?iN9LDL2lhUBZ/FlDuC9O3fypR+fHRUN9M0BG73wjUXWSgy/L?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EHkAheCR2J7fMb+sS6HPOZ6bxzj8ssHyva04/xPmHvnRK4WqDrem6WHjgegYaBomjYFoRIpOfsymYGCBifORkoe/UrY8h7On2Xo8ByjF07ncAPp1EychJONCCQfss2RqdQgGH5nUjw2JYEKSoJIg5szbPYy8fdlBV3Ppoy04emgg3RJFs1nT0TFBxvGX4QRwY60T3ASJP9AN69FWE1wZX5hPgNbFVPeQ+F6gQYJoMsXPW9FNhgXjDbz1vieirHL0KhEL4nW77AqS2wAPekFX+vzJd7kqMDFE+T5orMll8HOF1cciGsVjXt9joD10v0MSIoCYKiKWRTdZVctfxf/FfQ==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f156f3c2-e48a-47e4-afd7-08df306ef4ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 19:02:01.9427 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZYHXz7zXi5VcaJkbbqrzAABgVVnMBUukrq18VdZEgFQ+yYjfEJz/mKkKKjjLYT5X1CRRZTKEqSUGDzAudWUIjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB5993
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA3NSBTYWx0ZWRfX039KIPTjJ6ay
 skk3VJNKwomXiMDQZ+e04inIUh0o0IodhM1kcB+YA47fXygrHSIhs0x4gSD9qos8W7My4rRM600
 n3iTqhsw7Pf2ChEPo5GJ2ldtqZqoAnY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA3NSBTYWx0ZWRfX9sICQVwX4US5
 FOqIYOPNhFDKhaikHCMVHGqinYRp2DQohYiPP/amEzZA2zAsl4CWNpnGrsY+ZjD/qc150hWnizO
 yS5NPyDNCK6cHsStMwDRr+t99we+zKv61tNolMrpOYhf/xwH1+fcnGHOxh9EMp9O/2YCxuyLccl
 0GmHL1WV8Yh+MPbQ5QWvKfMAXeUw+cRfr6jFlnsQOMF0R9x536WXDcv/a3J8EHoRaDZEtgluBZW
 T/3YsRK8Z0SdsYRkHNFPleNFNLDbhWB11dhugVTIo0u1gQRj3TviA/5ZljuTfHTyCN7mYlr8gq+
 YB6hoSIGVNZC9ehZTFi+jA2pqx3LJKq+hVleMyXW9KYXA2njUd17LOJBJv/cfLFvIbxzaFxGuzZ
 YhprGjuWpV4E3+hQwjokvP3F0Q/jyY6W/WtrRiBQvqmIh2Hy1H1T723gKA9oZ18CTzbcSkfEYUE
 ybQDGe+Aic0XWw23w/g==
X-Proofpoint-GUID: NwYk4cI3CGI74ud36HL08BkJDpilDW4u
X-Proofpoint-ORIG-GUID: NwYk4cI3CGI74ud36HL08BkJDpilDW4u
X-Authority-Analysis: v=2.4 cv=PalqFShd c=1 sm=1 tr=0 ts=6ada5db2 cx=c_pps
 a=54yuESksmrMaP3RwvbuPCA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8
 a=Lv1jClmjWfryNBGNlNQA:9 a=CjuIK1q_8ugA:10 a=ysv77nodxO0A:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Subject: Re: [EXTERNAL] [PATCH] test/crypto: add test vectors for more ML=
-KEM
> and ML-DSA variants
> Acked-by : Pratik Senapati <psenapati@marvell.com>

Applied to dpdk-next-crypto
Thanks.
