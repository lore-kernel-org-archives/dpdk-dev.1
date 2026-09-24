Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F316C98311
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 10:32:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 26F9E42F02;
	Thu, 24 Sep 2026 12:32:10 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 81092400D7
 for <dev@dpdk.org>; Thu, 24 Sep 2026 12:32:08 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68O7LhZo2556726; Thu, 24 Sep 2026 03:32:07 -0700
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11022113.outbound.protection.outlook.com [52.101.48.113])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gvydggkec-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 03:32:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJtX8F1MAlOtpouM+b9cTgJxgmvpaqhvYUp24RT+DFa0mOvC2DCCMx79oykhc4TCc55IALcx25x4n8olfig3l3CG4qnZHJn2nHi0DcaWD1jMqBrh7kGs8gXgjYbQz556NQ+yj769MWD4iuNok9bqlKrPca/JlZ04jNlFVybjfWL5+hmKO5iKzPZIbib4ocD+UQU/unSrf/j8fgNAw4APinoR+bofG4c/FsuOqUGBoWaTmKbTIYVWrcwfirZ3rryGneKkQOBNlKG4Yc7vtn0dw1X2shwaNyaA93nO4e8RUUGT6OLN+vbilLsi2jlnN4UmK6o47uYUEUi/qMHdgkX1CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2QW+8y7FZf1bXDS3dwlhQkxlckmxe0FuB/nOyrKv7g8=;
 b=FE9+gxujm+wFMAqB6u3w8Ylt1u8Zj9pGMf6l2vuYCIaqsB6bM5GaG/j36Q7xSArRTUzVC+mUSU8D4jEoXGKu5U7f3JtMX6k2RwKsH8uwiWqyy86jERqB1Ky3NawxZyW+mVMLrCva8fdhOoGKCvO09uOGmHhlexL3tkOx1fodwp3ytOCnsv8ZGYLfzBHfOaMHPgq+aoWjBvYdSjnRZ5smhF/Svg553WWeyKo7+jYvD35qFayi4x3TCN1XestCxQXbiG5T2SZaUnP4sHe8qoYSopWCd6x4Ih4rOtWIHpu3C5/yBJ+JriCXKoKMHRzJNk3xYDWUFT1jZEuoHJyuifn7Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QW+8y7FZf1bXDS3dwlhQkxlckmxe0FuB/nOyrKv7g8=;
 b=bxF7aUlPhmPmriI+a43tQF+49pLtn/aX75CexVrID4E3vB89YEzTYqPRQPYI/iEcOGY3WC/F9+jhKW3aW9BvbJpTt/kfhaX1+2f0noHCaGwMqONu8V62I1yemXXRb6l24pqOLFr5fGzucXiNpw28MtwwLI1E+iOQMhItvdg8guk=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 MW5PR18MB5127.namprd18.prod.outlook.com (2603:10b6:303:1c1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.16; Thu, 24 Sep
 2026 10:32:04 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%5]) with mapi id 15.21.0428.015; Thu, 24 Sep 2026
 10:32:04 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Prashant Gupta <prashant.gupta_3@nxp.com>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, "dev@dpdk.org" <dev@dpdk.org>
CC: Gagandeep Singh <g.singh@nxp.com>
Subject: RE: [EXTERNAL] [PATCH v2 03/47] crypto/dpaa2_sec: support AES-GMAC
Thread-Topic: [EXTERNAL] [PATCH v2 03/47] crypto/dpaa2_sec: support AES-GMAC
Thread-Index: AQHdQSuWBsKpIgYwQk6YmvlI/a1RTbbdnFRA
Date: Thu, 24 Sep 2026 10:32:04 +0000
Message-ID: <CO6PR18MB4484DB175CE8967C7B57010ED8812@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260903135353.3358303-1-prashant.gupta_3@nxp.com>
 <20260910135158.2181141-1-prashant.gupta_3@nxp.com>
 <20260910135158.2181141-4-prashant.gupta_3@nxp.com>
In-Reply-To: <20260910135158.2181141-4-prashant.gupta_3@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|MW5PR18MB5127:EE_
x-ms-office365-filtering-correlation-id: ef435d07-398c-4f33-bdd3-08df1a271394
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|38070700021|3023799007|6133799003|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: pIFDrX7CoZ8k00aevobXMyGRDSrxA8QS7He7eS8FIFa5K1dgEmSY8+a++sHaYGru/sI3u6N9TK+6LWWt+G6RGOG/GT18H0ZlZoGT+JQwIgazZMzO2QDNZwADfWFb2kdc+kVi6S0PHeIAoAgAGubZD+gQMQ6Zso6h1d6laxcpwAbO06tCN7e7mpQKzgsQ38GAl4AnK+PPWTODQHYUqINf1C/cbf/NSvt8YgCSGBoHEdLrE5NTTm9WhnmkAxQfS1SCPwk0oL4afY6q4LjZhefuwF4nsVt3DJSPEUsH4HgO5ZJU5Dx6UIqQiEMs7T5vhiBd2ofAja27EW12nfSkrxGHzKPiWW8TbTBu8qNYOXGP/2ElaWxwVNIkoSC0lnsEjgD8SVZbGEmqnBC0N8sb4fsuilvZj6u3tul/lQazlXDrCBd0FvBQ8K1EZTku72m5Ax8uc+RCNVltGjzLvT7iQtcrC74htLMQihKBsnwkbKdkhZEG79BNBfSxRpU2tdaj6YqxfOSeFM4fWv/Z32Ow8rEmHWAY7NYDuj2m0aMd/fjBo03eArVDRlfk8YvfAHy7DPfJpVTihM7N8u1rO62bgTNevuGyQcn09JVO9nAQ94NZrRulk51QGR7O3SHjTcL3EtKxV243b5meMVs1zWovhxjUX+leKWRHQ+AS67yFI7XxzqSfgmmOnD5suGrje+amwwqcvm1DwscKIGEhQ3Rxk+kQ0iGiG0A22KAL38mDBpzhbSM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(38070700021)(3023799007)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bml4QTA2UDl4OHVoZUZaOXM1dEhNUTd2M2ZqU2kvdDFMN3F4T3pENjREN0sr?=
 =?utf-8?B?QmlaWmYzT2RBanpJWmpNb1g1ZjBWSnZUWEhORVkyamdWempqd2NzZEJTQjZY?=
 =?utf-8?B?UWwvV0lQb1BTR2dBMS9RMEcxdzFHWEhSUnBid1lyaFU1bkprOFNMMzRTbkJ4?=
 =?utf-8?B?aUdMNVl4S1M1UW5zNlZvU0lzVFVRZmtrcUxaSVFTNDd5TndqTkNEcUdISVVK?=
 =?utf-8?B?SEFqOVNaUmdVQ1RVSjJpMnBscSszNzN4WC8zVU5JYzRiYWJRMThuTFpqQkEz?=
 =?utf-8?B?NU5LckR0bk02YlZ4eER5VUZ1SXZTNTF3clF2M2t1ejJMU3p0MGZlbjdPL2Rx?=
 =?utf-8?B?a1B1QXczYnBMOTNvZjFwakp1MmZ1ZDQzNDhXSEwxTnZHYmRVU01DZXRTbk9Q?=
 =?utf-8?B?MkRESXdFb0Q0TFlJcFM1RWdaakRVaGVNMUJBRWJQd0VHYk52TFVJOWtoMU16?=
 =?utf-8?B?eUxNQkNTbkJPTmU0ZDE3eFNzaVY1T1RuenpTZE5ETmRmMmhraU9WZk1uUWNv?=
 =?utf-8?B?emdudTg4NlZlUVpTN0M1dUkwMEFZTVVnM1l2MUFvWnpKdjFRYk4yTzRUTXR4?=
 =?utf-8?B?WGptWEJPN2Y4Wm5xdUNGbHc3eEhYbmFLZmNFWndNZzFudnpzajV6RVdLaTlW?=
 =?utf-8?B?MDFDL0VVWnlKSGRjU2J6ekJNNHp6NFltMWFpeVp6RnFCdCt5TUlHYmlzNWph?=
 =?utf-8?B?UGt6azdQTW0waExORHNnNjloc3JUeUtZTytuTXhvRHdjNEdja3pNbGY2NXZu?=
 =?utf-8?B?eUkrYUxXZ2lpK0RlMTRBbVdjNUVWNlRLNGQzVzhxalFNandWYWMzVjdQMzVu?=
 =?utf-8?B?MFhrR3hHVmUwK29Hdk9NL001WC80WVJYdGdEcUFENlBMZEhtMjlqa1FJWXI4?=
 =?utf-8?B?QmkvT3E2Ri9LcWMwTHlBSGdVVEphclUvbDBLbDhvdVZReDlnYldibzIybHpR?=
 =?utf-8?B?Z0pkdE4xRmR0Y1lNTmM1cVdhazVYbkxSdUVTMDNKdHViTi92U2hzbmJqMUdV?=
 =?utf-8?B?cTRNR0FKZ2JxYlgzUjJNcEE1T3c2ZFNkalpoRG5hejF3dDJTTzcwNkwwQ2tx?=
 =?utf-8?B?T3R3dHN0M0lKSktrNzZEdlA0bmlCbTdZZFBMait1blpYY0dPSkYyM0g4bGVx?=
 =?utf-8?B?a2w0MGxsSVlIUmhJTy9zTk9kMS8ycFhROUU5QmxDaFJKRE0zY2NFcENNTGE4?=
 =?utf-8?B?YURnZC8wbGJ6c2lsemxpYmdJbEVyK1ROQ3BpeWMza2s1ZlR0L203NTZGU1pI?=
 =?utf-8?B?djFHNzM0NU82YmlJNm85ZVJRWkw0VFhrNU56YWhXYnppU3NVYTV2eDRqOTZO?=
 =?utf-8?B?TjhJQUtzcGVqcEg2NnBTeUFzbFIveW5SSzJBUGtZc0Z4VTVZY2V3ZGdvK3l5?=
 =?utf-8?B?S3I3aHhCT0UyTUt3aG12TDJVcVJ0SjV1NnpzWERuNmpyZUI5RWozbUlDaVFT?=
 =?utf-8?B?UFMxc2MxbE9tSVU2YzJPWXZXL1pjZ0xnRHZ4bE91Q2MvT2kvWDM0VUYyYUdh?=
 =?utf-8?B?cm1xNWFkbWQyV1ltK0NhNnJhZ0JGK3ozNFNLUUNIeG96dFpvVytaSy82YzJ3?=
 =?utf-8?B?TTJLSnFiV21SaTVBOElKdkM4cnVuYlhhYUF0OEdtOEp4emlBazgzT0QyOFZH?=
 =?utf-8?B?d2E5L0I1TUIvTjNqWFBXZ2Z6QXpnRTM5Q2tHdmE1ZTluUGxHejM0OVNEb2dk?=
 =?utf-8?B?UUs3K0dhRDYxaVAxTGJEWlF3cTEyWTRpMHYyRzRUY2JaVGUwQ2kxWU02UlYw?=
 =?utf-8?B?SFk3clFzQTdzZHY3cDM3NnVEK25XSzZZRjdKRS9CdHduTE9ZNE9xU0JGaFZy?=
 =?utf-8?B?eDhQNzNPbVZaeHVwWGJpNjhxWXppeWZGcURsVXduNzh1dEx0T0dTNFpEVHJ6?=
 =?utf-8?B?SDczdjhmU1pMZ2JCb20yZkYrUnF4QnJsT1ByUyt1YkN0RWVOcCtpdURWaTVP?=
 =?utf-8?B?aFJVT05sNUt1eEMwOW1BYTNtSUd4N3IxMHNRUXVHNC9pQlp0UDhBaW0yZHpp?=
 =?utf-8?B?N2h3SWw0VTBXRzNHdlF6eHlGNC9mU2RiL29ualNOSC8vSSt1OHJYNkxjZ09o?=
 =?utf-8?B?eDlaWnJlK05VL2grSFFmL3NUbkFvZ3g0MTFWejdtS042d01ZT1ZJdlU3NktM?=
 =?utf-8?B?dkZtTzIyL281djBMUmdYSW0rb3YzNmFKMHBWdGx0RmF6WElFK1N1N2RHNm1s?=
 =?utf-8?B?SGs3NVdOZGRIQlJ2cVlVVkFVbWZJNmpWWWZSTVZ5RVlpbG8xZmNBVC9BVzB6?=
 =?utf-8?B?SE43bjl1OVB6N1EyRjVKZVpoL3NiTUhxazYzeU51M1R3TVFqVXVaZHFIOWpN?=
 =?utf-8?Q?mWyeIAnZGJhAxk+cQP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HzC8ddUQrg76AIhEXleArDPYUD6wTc41uWGUucm5pliZiHv1HHg3Mr9f9WDQPHFV0wyBhH4wWvEfmxUzPqTWtd5CKjQOp9Vb+KdGqDe+Id1RTamocDKmeyCc/4ZlRTNHWBImbxYD2DPD3GROGfLsR9qld2PlFafnidGinuSMm347MKyEQmxS+fUEsQkVfHR0TTbonQiRfyFWTH9J9TZHJ7hVJ4tmIe1VStH6evRMrVFtr5O8+ZjuLcniPFp4hTm7H9gnJv3iR85p+ern5JLxtQ/rrFprTS0OK7k/BAaUg7dVokZn0BUxT3jvKAmsyCUi4+fQQaV8hxnID3ykfJhLyA==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef435d07-398c-4f33-bdd3-08df1a271394
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2026 10:32:04.3960 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iJt3KArtIUSt+RtcpxjBgwcHdLclpV8febQpE4j9rvdNlYRWBynaNE9TPzB/4TkHr1w2metqP85rwCXPaWwmyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR18MB5127
X-Proofpoint-GUID: cAfoxS2SXPtnEQ5qi0uWBpIePUysuWkd
X-Proofpoint-ORIG-GUID: cAfoxS2SXPtnEQ5qi0uWBpIePUysuWkd
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA0MyBTYWx0ZWRfX3pmU397oDjHw
 b2tHdpeeEfg+BWt6GzB7dxrHiLTJ6flR/iuX6VBA8O8pqo2mgJb4G795dIQ++Mm1vBjjyS5iy+E
 Y3E5rINuQ0w0DR9FAdPOSsuWS/VmDZI=
X-Authority-Analysis: v=2.4 cv=e8yT2qp/ c=1 sm=1 tr=0 ts=6ab4fc27 cx=c_pps
 a=Q5kcJUpSFGSGPQA8zxlsBw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=8rWy6zfcAAAA:8
 a=8AirrxEcAAAA:8 a=M5GUcnROAAAA:8 a=w8KSqlGKMONmAzBRaQoA:9 a=QEXdDO2ut3YA:10
 a=YjdVzJdQTyZRADMV7wFX:22 a=ST-jHhOKWsTCqRlWije3:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA0MyBTYWx0ZWRfX5qbT+gKc1rkc
 6ts91/VD8qqn5N9dpQTunumLQJjo9PHa515m4W7zINYwDO4HmKn4M045bUpVDRHwmoMWAr5dHCT
 Ba+Ms35zgVfdveud27FOrD7qVAg51dNueyu99CQ8+4zRVDVgoRp+S60LCBikxduPININVcuOxb6
 yEKstRSFptotvd4OKYNzVwNgHd+2q4LHz30qLSfiBG6HqXxyDRw1UfbtGVq2uQS1CQkyIdSsPxI
 TJCZ4k2MlFJyO6MyFFHiiM4FWbrbbFjVCgoDLD9AYs78xwBRVHaeEKld3cQkb7wEAEFVyIvNb5i
 n7kvDmdHP5mDNFSXHio+sYEKIu7S/iPzGB7FlJf9rUjjTCmby6w69GNW988VX8mts01YTwyYazr
 xO7vH2SFOgZiV09d5TNW5+3rh26lFry40YrwnYlxl5YpARAUBKdw6sbY1lKadfmDkjUTlZTtsFI
 r4YLDUn8h38uZnTnmqg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
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

PiBGcm9tOiBHYWdhbmRlZXAgU2luZ2ggPGcuc2luZ2hAbnhwLmNvbT4NCj4gDQo+IEFkZCBBRVMt
R01BQyBhcyBhIHN1cHBvcnRlZCBBRUFEIGFsZ29yaXRobSBmb3IgSVBzZWMgcHJvdG9jb2wNCj4g
b2ZmbG9hZC4gQUVTLUdNQUMgcHJvdmlkZXMgTlVMTCBlbmNyeXB0aW9uIHdpdGggR01BQyBhdXRo
ZW50aWNhdGlvbg0KPiBhbmQgbWFwcyB0byBPUF9QQ0xfSVBTRUNfQUVTX05VTExfV0lUSF9HTUFD
IGluIHRoZSBTRUMgcHJvdG9jb2wNCj4gY29udHJvbCB3b3JkLg0KPiANCj4gV2hlbiBBRVNfR01B
QyBpcyBzcGVjaWZpZWQgYXMgYW4gQVVUSCAobm9uLUFFQUQpIGFsZ29yaXRobSwgcmV0dXJuDQo+
IC1FTk9UU1VQIHdpdGggYW4gaW5mb3JtYXRpdmUgbWVzc2FnZSBkaXJlY3RpbmcgdGhlIHVzZXIg
dG8gdGhlIEFFQUQNCj4gcGF0aC4NCj4gDQo+IEFkZCBSVEVfQ1JZUFRPX0FFQURfQUVTX0dNQUMg
dG8gdGhlIEFFQUQgYWxnb3JpdGhtIGVudW0gYW5kIGV4cG9zZQ0KPiB0aGUgY2FwYWJpbGl0eSBp
biBkcGFhMl9zZWNfY2FwYWJpbGl0aWVzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWtoaWwgR295
YWwgPGdha2hpbEBtYXJ2ZWxsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogR2FnYW5kZWVwIFNpbmdo
IDxnLnNpbmdoQG54cC5jb20+DQoNCkFFUy1HTUFDIGlzIGNvbnNpZGVyZWQgYXMgYW4gYXV0aCBh
bGdvcml0aG0sIHdlIG5lZWQgbm90IG1ha2UgaXQgYXMgQUVBRC4NClRoaXMgd2FzIGRpc2N1c3Nl
ZCBlYXJsaWVyIGFsc28gYW5kIHRoZSBpZGVhIG9mIG1vdmluZyB0byBBRUFEIHdhcyBkcm9wcGVk
Lg0KVGhlc2UgY3J5cHRvIHBhdGNoZXMgc2hvdWxkIGJlIGNvbWluZyBhcyBhIHNlcGFyYXRlIHNl
cmllcyBmb3IgY3J5cHRvIHRyZWUuDQpJdCBzZWVtcyB0aGVzZSBwYXRjaGVzIGFyZSByZXN1Ym1p
dHRlZCBmb3IgaHR0cHM6Ly9wYXRjaHdvcmsuZHBkay5vcmcvcHJvamVjdC9kcGRrL2xpc3QvP3Nl
cmllcz0zODkwOQ0KQmV0dGVyIHN1Ym1pdCBjcnlwdG8gcGF0Y2hlcyBzZXBhcmF0ZWx5Lg0KDQpQ
bGVhc2UgcmVtb3ZlIG15IHNpZ24tb2ZmIGZyb20gdGhpcyBwYXRjaCBhbmQgY29uc2lkZXIgc3Vw
cG9ydGluZyBHTUFDIGFzIGF1dGggYWxnby4NCg0KRnVydGhlcm1vcmUsIHRoZSBsaWIgYW5kIFBN
RCBjaGFuZ2VzIHNob3VsZCBiZSBzZXBhcmF0ZSBwYXRjaC4NCg0K
