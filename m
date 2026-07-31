Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771C5C54F54
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jul 2026 17:16:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 41A0C40288;
	Fri, 31 Jul 2026 19:16:02 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id B879240269;
 Fri, 31 Jul 2026 19:16:00 +0200 (CEST)
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66VFLepI3214985; Fri, 31 Jul 2026 13:15:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=y
 QK0c6J1Ez+v5GDw1nY371VXXtNmKMFFtn/ICDZtGo4=; b=Y9l2EF2zWo2V2F/G9
 ilGlutnIgFC042ZDrfogRUc64HY7PiKohXT5Kmsyyi0KJ8HACdElGMKWgzd/y4IS
 DnlLkptBaaGaHoRFw77UvSkkht5SJo99H2u0ftVsz+fwatVPeLKLBnBRfcfDrCLn
 d/xy7fpM4LaBy3iWn3x+/TEtOXh25w+vY/7bwR95/DV9+MwusBwQIKclNdBm2JAY
 lJrqFAfPstlHv4s4q/d9b7l4Vk2riWL0uRkA063DJjyHUPfT7NqnCxSWjSi79weI
 gYa1qLEEuUN+ZRFvi4tmL4wr5eahsEXw4jGSD+lFPEqHoj/PLjV/9UirluopN8Bx
 rLKyg==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4fqpxcswva-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 31 Jul 2026 13:15:59 -0400 (EDT)
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66VH26Lc488705; Fri, 31 Jul 2026 13:15:58 -0400
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11013016.outbound.protection.outlook.com
 [40.93.196.16])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4frw4mts6f-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
 Fri, 31 Jul 2026 13:15:58 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kboBRpRz2Xq1GXxZc/xRNMS0skCOGZN5ECCJe4CW/tx6tb8p631LIF0I72/5+K8xD2987+29AOy0+yYehrH8tz9eBMRNtUV1SO8dT++oXx0HOI/6rnmwOSV76+Kb7RA+JsOJx3u3U+gU1oNQrapz9VwrIo+o4EfGw1LCefcVB5iwrpeKim5/iTXVBrJrGF2pQ3NmQJjIpYKGp7uzBYbtzJt5e9J7LWF1+WGYXJj3RsgJ03O9jDvxwPhJPrrFJ9ilatO5DxwqZ8WKHaYj8myBqkAH6R50Jk53eund5Y7zEIxJRMrTO7o/3JgmKCFNIioYrzZ4ZPkpM7J/5zIYU8yE0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQK0c6J1Ez+v5GDw1nY371VXXtNmKMFFtn/ICDZtGo4=;
 b=tWP2gZDdby88kb8IelDSIMM65bk8j6iZ92e/y+9y4vqFfvth1ZRhk75YwWl3A97uhYgduaKgUJLUCqcMe5qSDKk2hsMvR1MZAAIE5g0+CB16sHIFCimrUAwwjgtQvrxlZIhmiidvi0M+wXxCF69sm0fZ/JW/PrEAOK7kyloDmS8RlTkelonTuSJQ9+i8nb+oOqKLtH24Djx/QY4zODH0lR9ty9OfE0xL0oTDInZvXaUnlZdcBg5rhHPeWU8o3PNBEf7fC7ToXTQCLUbTVXFMo9tSRdYK/vVvN7+EdNx4RuUxLu8N/Ajx2j8rUhIeaVtq86JC+NC6wnqfvPRqOgTvrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from IA0PPF659BD4C46.namprd19.prod.outlook.com
 (2603:10b6:20f:fc04::ca9) by CO1PR19MB5109.namprd19.prod.outlook.com
 (2603:10b6:303:d4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 17:15:54 +0000
Received: from IA0PPF659BD4C46.namprd19.prod.outlook.com
 ([fe80::3375:a560:cdb5:4267]) by IA0PPF659BD4C46.namprd19.prod.outlook.com
 ([fe80::3375:a560:cdb5:4267%8]) with mapi id 15.21.0270.015; Fri, 31 Jul 2026
 17:15:54 +0000
From: "Bathija, Pravin" <Pravin.Bathija@dell.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>, 
 "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>,
 "fengchengwen@huawei.com" <fengchengwen@huawei.com>, "stable@dpdk.org"
 <stable@dpdk.org>, "thomas@monjalon.net" <thomas@monjalon.net>
Subject: RE: [PATCH v2 1/1] vhost: tolerate file descriptor in REM_MEM_REG msg
Thread-Topic: [PATCH v2 1/1] vhost: tolerate file descriptor in REM_MEM_REG msg
Thread-Index: AQHdIJqmnf1/7bON30W14JW0Wc3J87aHKHoAgAAJu2CAAAjrgIAAC/nAgAB6AwCAAB4JQA==
Date: Fri, 31 Jul 2026 17:15:53 +0000
Message-ID: <IA0PPF659BD4C4653EA823F77F74FBFEE61F5C82@IA0PPF659BD4C46.namprd19.prod.outlook.com>
References: <20260731031355.3578236-1-pravin.bathija@dell.com>
 <20260731031355.3578236-2-pravin.bathija@dell.com>
 <CAJFAV8x137vqFU8bptTFhxjusYG1wYHxkvE46iMRif7+84_w9A@mail.gmail.com>
 <IA0PPF659BD4C466F2C7E46C7DF91081BF6F5C82@IA0PPF659BD4C46.namprd19.prod.outlook.com>
 <CAJFAV8xPCRAerr-goiD5UbxPjmy5ddyb0ew8FK+nZMdu_g1kDQ@mail.gmail.com>
 <IA0PPF659BD4C46C174C843A7FE6C0208C2F5C82@IA0PPF659BD4C46.namprd19.prod.outlook.com>
 <20260731082756.31f7a9d8@phoenix.local>
In-Reply-To: <20260731082756.31f7a9d8@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=True;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2026-07-31T17:15:25.0000000Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use; MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=3;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PPF659BD4C46:EE_|CO1PR19MB5109:EE_
x-ms-office365-filtering-correlation-id: c581866d-0792-4cb9-ccf8-08deef2760d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|786006|4143699003|6133799003|11063799006|56012099006|38070700021|22082099003|18002099003|10067099003;
x-microsoft-antispam-message-info: kgIWfut/9Z6pNZqO2GMfYeVh3mx4j9p3iWi3flZADn6/WVmqAB0/B46bIsYN/twacVfRTsiwgWF/nB7u63T7KRFL+/n39a995tYn78xvIdorPush+X8aEY6uy6ywcufi0wt2/VkQTekTC7cR11udoMwAKFCZPSOL1Lh+HaEhrJxc78VmCpTZcqwqxJauVJbe/Cf/TQjD86iW9sO+BSan2neO/VRPIVmoGQTO3+1iISZFMqfCX2qzLbt/bHzxRGCn2EKHb15x3tbLjcnJK68GMQZm7Z4dMtODkEccgAaL21l/oMFdueH6N/9tPcnlBWqLz8aSa21LEEdimF+Rcw3IkkKYXzRlU44c+gCLK5ZN6pxs6XYodq7JeRBzKmOYiO1hh7A/vNiwAnGnwSM1Q5yJl8rdMzkLje2SMDjJG3Hdsfdcx+eU12JTCIPdNACRu3N9ywwKnItsNCEHJNR4KZBZXeIGwDF9DUYbtr0uV1vO6S6r0TzHN1OsjTBI8PiPYY95DUXzBm8oLwQptUABXWQKiD8Ej9o52S4vxI/XbgrSzW5I5Os7vaZqgB3c74afZoH5OXLrFNxufvD6wkWS3P+lh367hITs3zU5X4r5xH/4xfzc0j04qSre4+V3U552gLjtnaRl9DS7j8B5PO+h/AHcPxJb6zU6MVJ5cdebpJLB9vZ/oPG963lZs10K8cazyN7Py4LCP8Lhcnbjyoptf4+KUQTv6zOlobx3e1MFeKf/8Kw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PPF659BD4C46.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(786006)(4143699003)(6133799003)(11063799006)(56012099006)(38070700021)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-7?B?cnJHaFJ5ZHRMQ1d5ZTU4bzcyVlhqVlhpSmM0T0JvVkNqUXREV1dJUjVWeUtu?=
 =?utf-7?B?S2hJYm1CSVJRR1JmTUVmeXBCWmJXRDNlYXB5VlBCQXhMRkN2OG5nbHNGODd4?=
 =?utf-7?B?QystZEhQZistalhXVTJockc3elVlOWVXa094Q2gvNWZEQWxVanVqU3pDbXRJ?=
 =?utf-7?B?djA0cjdNNlgrLUVrcEF2bHM1Ky1qY1hBNENrZCstQVQ2cGZ2b3I0bjEwM040?=
 =?utf-7?B?ZXc2cEFETGZlL0NGVWZraUcrLWtiSS8yV3ZzeU9qU1hzSEhlVFpzZVdCOW5M?=
 =?utf-7?B?VnoydWhIMks3UGJKYnd1WktkWDFNaWpwRW8vQXNRSU5nN1c3VXd0SGYzWVc0?=
 =?utf-7?B?NlpTVjdnb1AxR1hBYnQ2Mm1MSnBxaVh3a2xYQ3NvL3duQmtHckV5d0RXQTVG?=
 =?utf-7?B?M0FIbmZxdlFyeXhaUFQ0TDh6Ky1MR1ZMdnRlZ3JkcmRrVHJjVC9aQjZGa1Zn?=
 =?utf-7?B?RVFtbGMvMkQwc3R0ZllQcndqYzBWQkt5ZFFCTistQVJhVU1nRW1rUE1DNzlJ?=
 =?utf-7?B?MFI3WDVmV0FmWnJ4cm9xQlpmd21TNnc4VTFNdFpxekw4aUFxT2ZEZ2Q1eTk0?=
 =?utf-7?B?VkVWQmQxMGxRUUthc3RBME4wYk5qeHFqbXJPc1h1cm5Yc3d4VDNjeEpQSy9x?=
 =?utf-7?B?THBUU3hiZnl1bmd4d3BjMFdxVC93VlZoV3ZJN1k3L0NxTWU5Z3pqWFBBVzB2?=
 =?utf-7?B?VkcyRTNCMmtEclEwOU9MTkUrLWFWSU9UMU1YOUF5LzNDYWJvTjBQTThjNGgx?=
 =?utf-7?B?YUhHbjZ6V2lrdndQN1VBZWc5SVBJcmt2WlU1T0ppdU9HSVJ6aGVGTHpWS0Rz?=
 =?utf-7?B?TWFTT2w1bHZMakxRcVIzZVAxdkpLM3Q4Z2ppTG5WdzNRYnNnejFFQ3NldHRi?=
 =?utf-7?B?bk9MV3llbUNhRnFBWmhPSndOQlYyb2JkUFZ0d2hRdS9BMHF2UlRXV011UGs0?=
 =?utf-7?B?Z00xRmtUUE53eEhqaUdibFlVcml1UXBxOXdJZUZrWVV2QnVFWG9ralJaTEVE?=
 =?utf-7?B?dHozQm5oQXVCOHREV0U5VWdaZU1IdW03bCstb3NoUXVTcXNTM0xRanFXYUI3?=
 =?utf-7?B?eW9ZUTEzdWFsb2VDQzQ0UTRJbWM5ZGhLcHlKSDJ3YWxPTkw0Q2UxR1dveHNH?=
 =?utf-7?B?eGJLKy1Eb2ZDRC9hKy0rLTVYSXZvNVljZ0RtakY0N0FkamNTN0RGN1g3SFhu?=
 =?utf-7?B?ejV6MnhuOUpFMGRGMmdNbUpsSzA5VVBscTd4dWZVU2QvUzBRZGpYVjBtUSst?=
 =?utf-7?B?bWpFb29xY1lWVEFDSnQyV0hjVS9NR0pleHpHbkdpNUdROGlIZVQ0cVI1amdl?=
 =?utf-7?B?VTh3bXFNYTFmSUtDMkEwSTJSQ3hEZDlUV3phSWdJNVNKQ2lyc1pZZGVVYkVo?=
 =?utf-7?B?Y05mbkdQUVFoZlAvWVRndDUyUlhyYlg2UistTHVVZlJ3OTZqM3dPZUdXdmVq?=
 =?utf-7?B?NVBDOTJEWmMyNjFFRVlPV2dZT2VOM3pBOThWMWtIVmtDYmVDQ2ZtbmNTdVow?=
 =?utf-7?B?WHovcE42cEt1WFlCL3doOE93MVZzU1QwTmZFS2RlVDQyaWZVc2dNOHpJSGJM?=
 =?utf-7?B?TWRXWFVFWEVyaWorLWx3bjVuZlNuMXVHWmRUdlBTWUY2OHNVUEdBTVQ3bUhz?=
 =?utf-7?B?QlBZeGFKMGt0S0xVTnhvbVZ1dkNFKy0xbWVkZ1FPbVJLUi9MSW1NQmlzWFM=?=
 =?utf-7?B?Ky1aUystNm1FRTVWSEd2cU1IQnJMOTYvNW10Ky1pSklwTi9sZzFhdndRWGRn?=
 =?utf-7?B?SFA5eistOFNmOWUxV0NFQ1FSZ0didDFhZzVuM3R6NXNvVGtsdlRUc2hCcjVi?=
 =?utf-7?B?MVQwNmR3WlErLTZSWHhiSExaTFQwVVdKc1VjV2xUcnZmenFKdmtJMHVPbWE1?=
 =?utf-7?B?aTB4NXc2MCstWmJUKy0yWDd4NUNqQjBWS2QwMDZhYldZeVVuOHVYUEFUU2xj?=
 =?utf-7?B?MnZZMG93SGtsbjYwTSstKy1lNUJQbVJGYTJCR1JDenIzVXY1V0hrQzJxS2s=?=
 =?utf-7?B?Y2QrLXIrLUk4ak9nZFN3cmt2MkpsLzV3bDRKSFpmdXpCbDFMU2NOOEFydWhM?=
 =?utf-7?B?dUhWbERRalovWnIvNUl0YXl4bC9sUnJqSDdzQVdaZU9MT3V6QURnV0hsa2xG?=
 =?utf-7?B?YWVoSHpraUpsZTNIMkU5LzA4Szl1bjZlUXJlZkVxM2lGeEF3YnBQbUZGMzhp?=
 =?utf-7?B?alRLZ1JIVU9kVU5xeXJaNWZQaURXNERUUjZyaW5HKy1lSUdEbVQ2SmVYWElZ?=
 =?utf-7?B?SDdMekgvdHhYKy1Jc04xSTJLdVpiNU5OZDM1Mk83TGN0emF1MistWUt6Z2Iy?=
 =?utf-7?B?MXI5Q1hQRmJJZDQ1eDVhdW1HcTBFSE1PZnlpOEJEclk0Z1FhdGttdkZwdTVV?=
 =?utf-7?B?WG1JdjQxY0tTOEFMSHZDKy1qYmhWcUNVOGtac3crQUQwQVBRLQ==?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lzCFv0923pjQ5WoOAnvzn6vh0Iorc0j2WhHCU7GzhpnTwJPEqzX3ug+MyHVXADupAsMWKDvbCIcaOhMKRs5wBO4Kz9bksEkN4PNQB0mu2opCG8vIsTfHErXsX/Lsa9Ag0tKfPHm4pj+aZzUyUY5ZVxcpfrAK5MMYrzi69VApw1t1z1nR0YG6r5s3cCXHNhR09NEQbsokiui51kMS9T4J5zqPcbDgnP7VrWKeAvwjIVG6Qk8c2epqPY5JH8jbtOTAMd2+i8IwW1bF3L6m0dg5siqdOte3ycnWCJiahMgNTaVnSLcvMgm193zcCGsyZ9paDMvmqIVbSq/ahseKI0A1SQ==
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF659BD4C46.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c581866d-0792-4cb9-ccf8-08deef2760d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2026 17:15:54.0124 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E3o74ipQhe6/xLYJ1VHk+apWTVl/F4eXP7Rt34IeCI/TjjhiMFWpo9Ug71nIIUiugKdYRGdtMCEsffZQaUNpJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR19MB5109
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310132
X-Proofpoint-GUID: knsYOGkYHrJuGBPNGHpM8GtH4GdgpIY7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDEzMiBTYWx0ZWRfX6yrzSG3SmChl
 zX1mNMwAgHPTyhnW/Kb6Q/0s7ZTUmWCRIo6jZ3g65tNIn0pNFrroJ18IawjaViH+hXpc0gnJNNG
 oMyOCBiOgZ80n6NrOlpyi8pQZ/mlYzY=
X-Proofpoint-ORIG-GUID: knsYOGkYHrJuGBPNGHpM8GtH4GdgpIY7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDEzMiBTYWx0ZWRfX5RzpnoO1Mj7R
 VS2LeTZq3ppI+xupqWK54/jS5agZe50uogxZLNb8ofi66g7PIKYVYWZTpKPj76DAvM90H3GrT5f
 sbD2LhhB1o8UUwtoxfAqGDJORt7QKHiSFLr/5M3CoX3+oA+ol6KqVwYJXtiM7e4X8iPwKp3SVKo
 710xRF6KPAGyHuJxyrrfDb+ebsSwZ8erDGeybDC/6+xQ1/0ldnPHRwkzZqKL+XF/Alwjl1WYjBB
 i4+FQOdm/LtaT57TISLauLqB36uAUUMLnZRxbXbHmQhwiqIJTnOV7iK0me6Xm5Rt+fK7AeUNP6O
 5szf0Ktwxl1CDsAbBIUY2wykv32vMAOBLZDfpT90JQC5dPoIF4aE5OLBSLq2wXOn2k8UNefUrkE
 dGewRNnFMlOA0n6jCf0Azj87/LwB/c892esbFdqyhWieUwTw81gbpomZA6J73079DaysWMfAYL5
 4geqtKMg34n/Ov46s4g==
X-Authority-Analysis: v=2.4 cv=NIHlPU6g c=1 sm=1 tr=0 ts=6a6cd84f cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wzW8d0FwaosA:10
 a=YU3QZWNX-B8A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=aNt9FJNJ8fZyd9HhltU_:22 a=jZVsG21pAAAA:8
 a=iLNU1ar6AAAA:8 a=20KFwNOVAAAA:8 a=8rWy6zfcAAAA:8 a=i0EeH86SAAAA:8
 a=bt5KbKNvAAAA:8 a=qgO09VQOAAAA:8 a=LfxEVeEBAAAA:8 a=XlRjxQ70AAAA:8
 a=eSb-bNSJAAAA:8 a=ytFMdNZ7AAAA:8 a=6-dRa9qSAAAA:8 a=8NRyImnFpWpLStkrNSEA:9
 a=avxi3fN6y70A:10 a=gbU3OgOOxF9bX48Letew:22 a=3Sh2lD0sZASs_lUdrUhf:22
 a=YjdVzJdQTyZRADMV7wFX:22 a=a-zEBD5cKgE7DNtTSb7C:22 a=r_vHcs92K7WWAI_28FKx:22
 a=7k9nRlTqVbDGZ3p5_T00:22 a=1uMOUU2w0DxzEe95gQqD:22 a=h7YW-pclpbZRD8svLbQ0:22
 a=oxySFUAvEW1-6AXleBSr:22 a=NZk92sZ4hQKp_Sw8PGvT:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310132
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




Internal Use - Confidential
+AD4- -----Original Message-----
+AD4- From: Stephen Hemminger +ADw-stephen+AEA-networkplumber.org+AD4-
+AD4- Sent: Friday, July 31, 2026 8:28 AM
+AD4- To: Bathija, Pravin +ADw-Pravin.Bathija+AEA-dell.com+AD4-
+AD4- Cc: David Marchand +ADw-david.marchand+AEA-redhat.com+AD4AOw- dev+AEA=
-dpdk.org+ADs-
+AD4- maxime.coquelin+AEA-redhat.com+ADs- fengchengwen+AEA-huawei.com+ADs-
+AD4- stable+AEA-dpdk.org+ADs- thomas+AEA-monjalon.net
+AD4- Subject: Re: +AFs-PATCH v2 1/1+AF0- vhost: tolerate file descriptor i=
n REM+AF8-MEM+AF8-REG
+AD4- msg
+AD4-
+AD4-
+AD4- +AFs-EXTERNAL EMAIL+AF0-
+AD4-
+AD4- On Fri, 31 Jul 2026 08:19:07 +-0000
+AD4- +ACI-Bathija, Pravin+ACI- +ADw-Pravin.Bathija+AEA-dell.com+AD4- wrote=
:
+AD4-
+AD4- +AD4- +AD4- +AD4- While the immediate motivation was libblkio, the sp=
ec's
+AD4- +AD4- +AD4- +AD4- compatibility clause was written for exactly this s=
ituation +IBQ- any
+AD4- +AD4- +AD4- +AD4- front-end could make the same mistake. QEMU's libvh=
ost-user
+AD4- +AD4- +AD4- +AD4- reference implementation
+AD4- +AD4- +AD4- already tolerates it (see vu+AF8-rem+AF8-mem+AF8-reg).
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- Which does not change that I dislike such compat.
+AD4- +AD4-
+AD4- +AD4- I couldn't agree with you more.  The libblkio fix is ready and =
will stop sending
+AD4- the fd.
+AD4- +AD4- In an ideal world we'd fix libblkio and move on,  but there are
+AD4- +AD4- already several released versions of libblkio in the wild that =
exhibit
+AD4- +AD4- this behavior.  Users pairing those with a current DPDK will hi=
t a broken
+AD4- connection with no obvious workaround.
+AD4-
+AD4- IMHO security safety trumps the specification in this case.
+AD4- Although it might help to document this somewhere and add a better me=
ssage.

Agreed that security comes first. The patch does close the fd immediately v=
ia
close+AF8-msg+AF8-fds(ctx), so there's no leak risk. Happy to add a log mes=
sage so it's visible when a
front-end sends an unexpected fd. Something like:

if (ctx-+AD4-fd+AF8-num +AD4- 0)
    VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-ifname, WARNING,
        +ACI-REM+AF8-MEM+AF8-REG received with +ACU-d unexpected fd(s), clo=
sing+ACI-,
        ctx-+AD4-fd+AF8-num)+ADs-
close+AF8-msg+AF8-fds(ctx)+ADs-

Would that address your concern? I'll include it in v4.
