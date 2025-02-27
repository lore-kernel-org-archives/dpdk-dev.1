Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD5EC021BE
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Feb 2025 13:23:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64C8640A4B;
	Thu, 27 Feb 2025 14:23:01 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 4015B4064F;
 Thu, 27 Feb 2025 14:22:59 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RAvTUK006954;
 Thu, 27 Feb 2025 05:22:58 -0800
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2045.outbound.protection.outlook.com [104.47.57.45])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 452prgg7rf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Feb 2025 05:22:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f5ueZdU/Z2wyIMFxMWqFIQODPCgp3Dlik7QKgt9KaFs2YLUyw/uITdzPo4NxlbMolBZtgmL5xdkbrY2YQliGA2PO31M/WuM2Rxz7IGE1QMmp3I3XIQh+cVanc+LtLFolqOpr9d977regv4N7V5p3CcjYqOIpjUQiYzcp9nZOP3V9K/YMojZ8F10ofSnizGOaETo4oXkC8QlgTLnHJS0zIOSYK0Wljo7iDuqwMgy34ZnBHJH7UuSFMzC+Cp+e6cvOAJQ8xnim+rP+pisRaYcbA2Owua3fi2o3U8kpcwNrQfyKf/bDbSvQvqaUYH4RDf8n6VOr+3DkTT2hFFRpLpRZJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pSkgpKAgsFKbhtG/Q3YqqlUKTT9nNu/ounI9EoxtTBw=;
 b=lW2SaOR4WktnZEGYo8uSNLC4mUTegJvBAHocfIqZ7sOgebQrYb8xz+9dze8QHYt5MrhKcDD3xOHgsgYvAt2tx04giuDai/1leykOwk9L9UteGwBc7bFeAymfwzTuFegEKi+QlqdTzpbJe/pU6lQuQqtpw0puM8GkbTtenbGxS/RLU2/kf03LXZmjSb+hkC8Oa27NZHIHbzNcrfFGp5ypwi5Y9CnhEfKG1++AuuDaYggaU7HQJ0gBTLZGxUr653G6KZLohssQrqRDcAKh/X1isHpzusxENtDPuizNFKvOw8Cey+7suTQ6nlOWzEfbETtCCfYL00AS6I/U+Ag2g8iXVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSkgpKAgsFKbhtG/Q3YqqlUKTT9nNu/ounI9EoxtTBw=;
 b=uN/RxVS59BCIYTLYrsHDhvN5GHR+A7RRE4uh429h7h9ft1Ki/yIkWGg7VlD5euMZXSimjiNIpkN2r15tF28QCKypnZdhUqkO/FQnN8g49QUX70oKOEyfRLP4MrChrPEV0NW6OSy2WHUHdRyQ6xxzIskThj5mAO9FhlTcGGS7xcY=
Received: from BY3PR18MB4705.namprd18.prod.outlook.com (2603:10b6:a03:3c8::12)
 by DM3PPF516449E88.namprd18.prod.outlook.com (2603:10b6:f:fc00::6a5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Thu, 27 Feb
 2025 13:15:33 +0000
Received: from BY3PR18MB4705.namprd18.prod.outlook.com
 ([fe80::1a4d:d74:bbd0:57fe]) by BY3PR18MB4705.namprd18.prod.outlook.com
 ([fe80::1a4d:d74:bbd0:57fe%7]) with mapi id 15.20.8489.021; Thu, 27 Feb 2025
 13:15:33 +0000
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>, "dev@dpdk.org"
 <dev@dpdk.org>, Chenbo Xia <chenbox@nvidia.com>, Fan Zhang
 <fanzhang.oss@gmail.com>, Jay Zhou <jianjay.zhou@huawei.com>
CC: Anoob Joseph <anoobj@marvell.com>, Akhil Goyal <gakhil@marvell.com>,
 "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [EXTERNAL] Re: [v6 1/5] vhost: skip crypto op fetch before vring
 init
Thread-Topic: [EXTERNAL] Re: [v6 1/5] vhost: skip crypto op fetch before vring
 init
Thread-Index: AQHbiH6FA1dexCVgyUmrLiQ9SxTU/LNa32UAgAAA7wCAAD+IoA==
Date: Thu, 27 Feb 2025 13:15:33 +0000
Message-ID: <BY3PR18MB47054AE703CEB9AA6812A7C9CBCD2@BY3PR18MB4705.namprd18.prod.outlook.com>
References: <cover.1740594750.git.gmuthukrishn@marvell.com>
 <0784f44b63f6161ac8716644acfea979704eca39.1740594750.git.gmuthukrishn@marvell.com>
 <81fac570-cdd7-45f7-b209-ce999d5c3d0e@redhat.com>
 <de649087-3686-4372-a1ac-d9a05961b6c0@redhat.com>
In-Reply-To: <de649087-3686-4372-a1ac-d9a05961b6c0@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4705:EE_|DM3PPF516449E88:EE_
x-ms-office365-filtering-correlation-id: 383c8138-a234-4f3c-32b1-08dd5730d0f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dm4rM0JRV1BwbjA1NTlsZHoyU3g3b2dXemUxVXFpOC9waHlRVnV2d0p4YUlE?=
 =?utf-8?B?ZWRWMW9OQXN4VytiWDZHcGg1WXJHT2NDMkhiaUZtbXprTVdOZnB0YVk2UHJC?=
 =?utf-8?B?UUkzMjhob2NxOXhNOS8rMGNtS3BLQW1uYUYzcTF6WDBDVXd6SDVmNUZTWVND?=
 =?utf-8?B?clVjTE92WTdYTm5NRVFKcXZZQkVLelk3NGcrbytTUnIzdDJJbVhhTnpXcklX?=
 =?utf-8?B?VlF3V3JWQ2xCY3NnSW1KalBZbzk4TktkUE92MU1FK241Y0FLaE9wK0NjbXYy?=
 =?utf-8?B?L29OUTZkQi84YmZra0dUbmp6V1N1YmsvZG1SamZSL1RQY1pJY0RncVpOWmJU?=
 =?utf-8?B?SUd4SFF2bENGd1VIcDIrZis1SVFSd3BoTGp5cEV4VzJJTGRPMTNCdXMrWkRp?=
 =?utf-8?B?cjUwYlVDSTVMN011OUlBVVd0U2Y5UVNidFlML2NpdFhnNkhwZTdHUVliUW9B?=
 =?utf-8?B?RHp3TWNhY0x6bVVrOVZMLzl3bkhpOUdiSDRwY203YWowemNDcHJ1S1R2T3lU?=
 =?utf-8?B?Uk8rVUJPckJpSXgxaVJtZWEyRVh6V0NEd3Z0cmZYK1ZQMEFRQko5TkQxZG90?=
 =?utf-8?B?akxDdmsvTmhudlBKL2JKNEF4NU52OEIxb0R4U0hEQmVFay9BY1ZoM2FlVVNE?=
 =?utf-8?B?SmEyYnpkeE9HMmU2WjlScUNEbS9acGVLNFB0dERhVi9ia2NBUEN4T1pPMmx0?=
 =?utf-8?B?MnhBamtydjUveXFuWllUMm5pZ3czM3JuMnFvRi83b0FObjl4cC9VSmt1cGFt?=
 =?utf-8?B?VXVQeVZzODBISkgrcXl2bjFQZzJpNGxZL1Jydm90b3ZIMEJFWklCV1lZQUdq?=
 =?utf-8?B?T0RmN1ppd1NnUEJNTVg2WUVqYXlPUVliaGtrWlBobmtXcWZaUGtVd05TSDZK?=
 =?utf-8?B?aWlmKzZrZ1VkYm1QaDdsd2l3RVdlc3lmT1J0UHlzb0JXY0pSb2VjcG5xL0Jx?=
 =?utf-8?B?K2lnRGNCR2xjS3VzcWlzeXA3eU5lTU9WN3AzYmdManNRbnBROUFqMmhENFoy?=
 =?utf-8?B?elhLVUNVcWFLcVpFR0pwWHhqeEpFZE1yajIwdmYwQTVqR2ZkMHdOMFlzUW1t?=
 =?utf-8?B?aTl3dzdyMUlGcVl3MEk2NFBaUlFnbzJQeWt1WXlFUGV5aC9RYlZMNG5OZXM4?=
 =?utf-8?B?L0Roc0ljeW9nWGk3R0ZyaWZKcm0rTUlZbDJPbUhQRkRZV2dSZGxVRy96VDlQ?=
 =?utf-8?B?YXV1M0tYQlpVNXVPcWV5NFVyODFXbktJanJIWng5cjZtaE5CazYwQ0RCYlVZ?=
 =?utf-8?B?MEpnaUJ2ZHQzNGRlNWwyMXlNLzVrUXNjYWtxVTVkMGFaT2lrZ04vdys4c2dH?=
 =?utf-8?B?N05Pa1ZxTkROTnlBODNuT01zemppUzhaUkVxcHhPQlYrbW1mUHVJUENRa2Zi?=
 =?utf-8?B?dzJSUFJJSFNHcTFsUjVramVBK3QvQnBxU0dEOEtsajFGQUdodnVxSTZCVDgr?=
 =?utf-8?B?Rks1TnhOM2ZDS3VJK2dyeGtoajQxeFVXS0pmTmxtN3hUQVJ2YThNdWxpcWlJ?=
 =?utf-8?B?TGU2RFRvSm1FbWdHbkEyV09GVEhGNHVBcTlVaERrd0pkOEtWNmc1SFBmT2kz?=
 =?utf-8?B?K1JpMW9YTkQvdktiMUFvdTJMdmVEMWIzOGdha1lMMDJ1RzNkaWxXdWdFM0ps?=
 =?utf-8?B?R0xtREhZVlloZnJJRlhLdTdiSFN6bm1vRVJHVXAzL0gyMWtUV2pGUXFuNjhz?=
 =?utf-8?B?b05ZU2pnS3l1UkN1a2dDMVFjMkZpMHQvT0ZDdzVEWU13Mm9vT0xiVzBmKy9z?=
 =?utf-8?B?eG1oRll4TXRnQVpIMGcyZ003bFVrSW16d1I3eVBPRVZYejZCQ0lhNlRnc1Rj?=
 =?utf-8?B?alFZc214TVBDQUNqOFp6VktJSUVWaGlsYmovLzBNQW9nWEVOUDdldHQwSXJj?=
 =?utf-8?B?djJlSzZJODJlNHZSTGFEemR6KzU3U3VKaWs5ZFp4VjdVaGtKclZJZ3R1L2Rs?=
 =?utf-8?Q?tNXeKcKGH8NwhKDMoP39UBkTv+1WzVon?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4705.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVRsd3pJbUdZSTNLVjh4eU9RZEJ6bE5wcG9NVVF5Y1hHZTBMSzI2L2t5VDVn?=
 =?utf-8?B?Q3dobEZTb1Z6OXY2aGczMmNOKzlTcmlaTEUvTWFnRVlXL29HeGZqZitka25S?=
 =?utf-8?B?YkJiUWR0Yk54MnFBNnJ0SlRwbWx4TitvdzE1U1ltbkVCNXBCaVEzUHgyd3p4?=
 =?utf-8?B?SjgzUFdwU2ROWjQzaUtKMFVybyticTVZRlc3Ti9RSHBDelo4VnAvempNRDY0?=
 =?utf-8?B?aXZ0Q1graDl5N0M4V0VLTXdkVXd1UmxHUHpRVkFCRU1WcEtybDNlNFd3THNw?=
 =?utf-8?B?b1o5M1FJM3dxaVBWV2ZxSCtqMm5xd05UUjFqV00zM1IzMWZxY1lOQUNNcG5M?=
 =?utf-8?B?dFZ2Y0ZEaDhxUkxzdnB5MVVqbG9ZMzA4QkZ5NENOYUZzRGRLT0E1YXFoOGVI?=
 =?utf-8?B?bmNxM3FzOVRUaVFRZ2xiREYyM1B0Yms4UHdIVHRERDZVNXI0MytGRU9YQ0ln?=
 =?utf-8?B?Tk9ndzlLSGN4ektlWEwvRG4xVHhDb0xjZHVjWWxodU9Fb3VuL3kzaWsxRm9u?=
 =?utf-8?B?ekd1S1lzRU81NWVvUVREWkxpdWFKeGhPdHlYSjFXMzJJbFNIclNHN3ZXU0NL?=
 =?utf-8?B?NU0zQTQyTE5Ed3dqR2pxelk0WnZmVnV6bGROdUpydkFkd3pCYWtpNTR0TmRZ?=
 =?utf-8?B?TFUvMzduRG4rZDVVajZsc0FUNEFjRlI0SURIaDRacUFUSnM5bDViVzNVUms5?=
 =?utf-8?B?alhXTTFVSnZ1Nm1xY3lyZUhlUkFmYWlzK0hOLzJjVzFWTnhHbFpidDk1VVNt?=
 =?utf-8?B?NG1mOFNiNGh2cW95OXdXVHQrZjVQVzFRRWlFTU4ybVZCcmpFV282SUU0YlpN?=
 =?utf-8?B?VjZya2IrdFlDQ2NZVVl1bHY2elAyMFNoWWFLUmpISUZlSU5EN05BazArMXhy?=
 =?utf-8?B?dGV4S3JLWmlHemRGUWdEbTdQT1FCOUtWd0h3bklBK21sakVYekhvQkdlbnFE?=
 =?utf-8?B?amNadER4UU5iNFREVjFYSUxSVzhQZ1YvYUl6bTlmQW9jeDlTbXBGMTZpaHA0?=
 =?utf-8?B?akM5akhVTnlWWEsrenIwWXpvU2dRUVk0c0hsM1JkYURvcjlhaVdBN0V2dG1t?=
 =?utf-8?B?bWJsc0lPZFVMWlZWdUdWYm1TMDZiR3cyY09BbkNzUlRVVWJ0NTR5MDBQM081?=
 =?utf-8?B?ZDN0V2lsMDRrajk1Tk9nM2tuaEowcW96L29OTDZJbXFKQ0Q4dVB1MjdYelFy?=
 =?utf-8?B?M3hBNGlyWXc2SjJNMFBFODBKV2ZPMTMxa1lrOVRiUE5mdC95NVVyMkRJYkYr?=
 =?utf-8?B?QkloWlJadENRMzlrWDR4bkQ0SDU4VGJqQ0pRSFRiM0tOZ3dpOVZsMm0zZWkx?=
 =?utf-8?B?aGY5ekpHZlRmU0NhVUhKRWwxV0hMV00rTjJ0RnNNZWRiNytUTG1WNUJoTmV5?=
 =?utf-8?B?R1NqV1VKQ1pjcnMzWW1qQ2ZsNTd3MGdhc1o1bkRVL3JqaUFudmxOUjRaazZw?=
 =?utf-8?B?TU0vbVU3K0NCSTRoZndEblhnQm92RitHYmtoMnU2ZVZRa2hGMkhSV0hiUm1h?=
 =?utf-8?B?LzVJQ3RlWW1MTXQrSWFHZGdaTnlDd3NMcElUT2d4a3pMZkdidjZyb3RpWnFl?=
 =?utf-8?B?M1dpSWdjTTRodW4wRTlPY3dueTBhTk1NOUJHRVpTTHlVNDlybEViM2Z4V1FD?=
 =?utf-8?B?YnNKZUZlUGhCV0Fnbk1EMmowZjB3SFlxNkRVbWlPRE4rSWFNdmZqTHJ1by95?=
 =?utf-8?B?TThCeERTMUhueDNyOHprMEFodXFqUFU2bzhoQ0RTUHRvTytWOFIzOURCNXpi?=
 =?utf-8?B?cy9idmhOb1QwdVdnYjgzQjVCYjFhNzBTaDg2Q216RmpyeFdLcXZnRDRaeWc0?=
 =?utf-8?B?TFpETUR6MEM5dGk4WnU5OVJyVGhqZkg1NEd4bW5WYWZ1R0pYc3pVdFI2S25V?=
 =?utf-8?B?TncyVUwyM2ZLNnBpUzZQaldDMDRHb2NQUHkzaTJIWEw5ekZaRjFPZ2VqNjdD?=
 =?utf-8?B?a1BZaWFqWFprakZ6MUNubnc1WTFYNjNKUzM5ZGlqV0lRL0RiNmQrQ2RwSldm?=
 =?utf-8?B?YlpDdFdPays5WXZrNjQ4eG5XbTVSZGlrN1lKWlQ5LzN1bW9OTmc0MkFwWHBz?=
 =?utf-8?B?cFNoNGdsamp6bWNGZzZEU1dBaG5vUzh0NEZQWFhmTi82YnVRT2FjOERMK1BH?=
 =?utf-8?Q?EnWuPK/O7oLFuLip3Tanabgwf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4705.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 383c8138-a234-4f3c-32b1-08dd5730d0f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 13:15:33.1822 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SK2fbVOCh23yRlh1ke+oeINRbdqkhQHsSY6v48geA12CInMh1sqlaMHxxtmlxlK/bwHZVtUbFFCKWKegiSSJZrpSytd4Yh1lzT0jpbWPtsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF516449E88
X-Authority-Analysis: v=2.4 cv=RPFJH5i+ c=1 sm=1 tr=0 ts=67c06732 cx=c_pps
 a=hSS9g3ca6WprpwKybkK64g==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=T2h4t0Lz3GQA:10 a=-AAbraWEqlQA:10
 a=MnNfl1Y3dzEPj_Nd8jcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: DuprUKasE37YaQ02kNthWcdpMjaq1oPo
X-Proofpoint-GUID: DuprUKasE37YaQ02kNthWcdpMjaq1oPo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_06,2025-02-27_01,2024-11-22_01
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

SGkgTWF4aW1lLA0KDQo+ID4NCj4gPiBZb3Ugc2hvdWxkIG9ubHkgdW5sb2NrIGF0IHRoZSBlbmQg
b2YgdGhlIGZ1bmN0aW9uLCBvdGhlcndpc2UgdGhlcmUgaXMNCj4gPiBub3QgbXVjaCBwcm90ZWN0
aW9uLg0KPiANCj4gSGEsIGFuZCBhbHNvIHlvdSBzaG91bGQgYmUgYWJsZSB0byByZW1vdmU6DQo+
IF9fcnRlX25vX3RocmVhZF9zYWZldHlfYW5hbHlzaXMgLyogRklYTUU6IHJlcXVpcmVzIGlvdGxi
X2xvY2s/ICovIGluDQo+IHZob3N0X2NyeXB0b19wcm9jZXNzX29uZV9yZXEoKSBvbmNlIGltcGxl
bWVudGVkLg0KPiANCg0KQWNrLg0KVGhhbmtzLA0KR293cmlzaGFua2FyLg0K
