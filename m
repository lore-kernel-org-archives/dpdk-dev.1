Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0ADC021B3
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 07:13:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC9004025E;
	Mon, 24 Feb 2025 08:13:28 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id D19EF40299
 for <dev@dpdk.org>; Mon, 24 Feb 2025 08:13:25 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O51TJl011273;
 Sun, 23 Feb 2025 23:13:24 -0800
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4503qbse0b-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 23 Feb 2025 23:13:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HQBeO+YeJ8unmj9QuigGfuWOd+S1ELiyBO+MSAJxmo3h7V7odgWtotTh5xTpBCTEbyO24W3htkl3oKZTXr1pfH7jAGOBbeuNhvfO8RdDZDUISocg5PrFI9QuQuS5W/HixkhvO7xpxxxF25Q4xKw/DO0GtjK4T4Pa7B59LUI/naox7oJwlCBYgNKcYHUVYuSYLHqM6yabkeFdsrGsChwYxD82XdUVD8zp3kks0ndiJGlYtFOhWdNbnD0XsosLTydkS60q35OJE9LAm4xw4hfx1JH+geXAxOtgpuoy6b2Bb7D0pjuBcM5YF8XtU0wHCwuZbIlEXYa8gDKPpud8+AYNOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Viz73dHaElTCQDyY+pDUtuzMEaH0o8sQj9KoFuLrGiQ=;
 b=oDdYLb3MUA4mePTRoPeCLUo2mRqNP3I6gSZ5retZU9S8g/NExL7j+Ju5w/fZElD5SLOJD9HrJbl2k5PfPs708ko9hGfaqmFI7zzN1csMit5H3pLopHnjt5CVrYumQ/qIvwhf0arTbJRnfblL0btP4eyIhc+/efeFZMLfZ0eArDfCVdeFDL043BZFV4SNPC79u3to0f5zCjsy7KhgtWCiYLWNX9cGdn6DHEx8QKjx7Vmg8rE6x9U0hqk+2+xW1ke2CyJceeAyyuPSw2/0rCiR00GOmqtEOh8/88ZQse4u10Y6pbWWiNlZsLDLNjw9ww7d3M06YS7B9K5mAcqMeaX0HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Viz73dHaElTCQDyY+pDUtuzMEaH0o8sQj9KoFuLrGiQ=;
 b=pNTTF3jJ0gByBm1XUSkwHU5U0mkmSI4k4p83vk6nSSpUIJNkKq5aoRTxX27VAhkdVPkGgfua7g5/OCQCyNPmRpYuZqwoiLMh/d01MDfNCEd7IxB99Ommf82mIz5D7ouAV3nuNj0r4J0Nls8Ic2rby16UvSmUTJi5AgBDalYC9z4=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 CH3PR18MB6379.namprd18.prod.outlook.com (2603:10b6:610:205::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 07:13:13 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%3]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 07:13:13 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Jay Zhou <jianjay.zhou@huawei.com>
CC: Anoob Joseph <anoobj@marvell.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [v4 1/5] vhost: skip crypto op fetch before vring init
Thread-Topic: [v4 1/5] vhost: skip crypto op fetch before vring init
Thread-Index: AQHbhQUmeV5hRP4h9EKCaE2KbOHKQLNWDPkw
Date: Mon, 24 Feb 2025 07:13:13 +0000
Message-ID: <CO6PR18MB44848943311DA153D8760D83D8C02@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <cover.1740212213.git.gmuthukrishn@marvell.com>
 <c0abeaf72770785b753d1a9fb6e7e5fa4c8a85fe.1740212213.git.gmuthukrishn@marvell.com>
In-Reply-To: <c0abeaf72770785b753d1a9fb6e7e5fa4c8a85fe.1740212213.git.gmuthukrishn@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|CH3PR18MB6379:EE_
x-ms-office365-filtering-correlation-id: 1e56ee88-b4a5-47e0-c9f0-08dd54a2b3a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ynHrgiP15tpTBdTZWcerveCcdZOdQL3RQQEUAr0UlwlZiVeRQv/vc7mqXghs?=
 =?us-ascii?Q?CAfxa/ibOQEy9hxOCsvED2sfopW8Ji0vWKXeROkDXDob8T7Iu0esDEPhhCAS?=
 =?us-ascii?Q?sSKqNJWARkWmXkQurcpo5/P11907of7CT0IqHcj6o0DHzOsTRmg4Il5PrlHb?=
 =?us-ascii?Q?Oan1pShugAryYOw096+fgnw0FsNo1twgiEg8FXQxZ7TZI4xDvkImsLV0phc0?=
 =?us-ascii?Q?JqS76DrupwgJefW4ZlIluGIZwIv5nOucM/mNVGstiT10v/nvKN5OL8KPhk4/?=
 =?us-ascii?Q?aAljoNjyRNpuQBtrbqS137KHZIRaSCtq4XhUZO/r9KWD7DuacOv36b4SOHPV?=
 =?us-ascii?Q?1Ki21TRheGTzZ7iOdb8W631sdAMtHRgriYF2j8L+BCrePIiZ/ca6SjfL38Gt?=
 =?us-ascii?Q?ckyX6CF8fNvAzEOL2wu0+lP2oLBvAmgFTFKouQ0/SOs+LSpRkHYqzOmRdebc?=
 =?us-ascii?Q?m/yQoUlDfU4f4by1HqGfzRziDJaVbJyPVFRnv82+CUpxdQ5CpGg9af2GwWoe?=
 =?us-ascii?Q?tMJ8zu4Fo5AbRiuWwxJpd/LTVoz49V9Es1DoZ6F4Ly5Cg3mZH2MNF9zpLYhY?=
 =?us-ascii?Q?rvhFB7EYOrQBcJLt9EWaxEO2NlFPO31Iv7W+YO5w6JswbLMOowVbKgWrj5to?=
 =?us-ascii?Q?QcgTii8/CvffylJSCwywcxhVKhr491IQW/4mCE43R9Q+gfJ2wuBg6kD1zHkI?=
 =?us-ascii?Q?AQUp0mYyWMc8VN85fEzEpVtLJgT8VQWd8CyZ4XESCF2vgiFFOJqc5VeOO//0?=
 =?us-ascii?Q?BcEUY8nS3zwks344K/dw9hfoP7gu1c0Vwrj0byWnRcBDKN0aAVehB9M5bnq9?=
 =?us-ascii?Q?Mqy+XK1frD59FW69MRlxcc7OTOCZDCVla1IVucLb0lQxDHUVXYExnqSwP9Pc?=
 =?us-ascii?Q?5wABrrJuzoqqV6gTqXUJCFpEquEoNRKSsOHYNupoYFotjydWA1i9w2h+gw3a?=
 =?us-ascii?Q?Vbm1uOx63vWniosmU8PlB+O3ueAJKNf8m7A0aiVJvU9SxOu14DEGKk8QgSoP?=
 =?us-ascii?Q?324nHJoPv8nSG9FRVdJOpQmWhEHmD4zxvglNVuxyx306OQ8iRWKm+NlifZxp?=
 =?us-ascii?Q?JVVMQNuvWNBUw+LRZe0DLtlC8QI0Jm7DlqJcdEbTGl0/XDujcd56v3y0Khn/?=
 =?us-ascii?Q?tjMsSniBA2fe4+z3KeHlICMSjc97BxsGIalU8XOtxiaaitRezbS4xflwygxW?=
 =?us-ascii?Q?RbO+EwFYiu6p5+k+4jjUJhOLIDm7a1jJkaJFse5cFLs6ZgH1mwGwkIBOdP2y?=
 =?us-ascii?Q?dnu732rtk35W3kO74jaYvFa3FA8t9MzMDfuxouRjxxE0agJ5bTzTwBVquM4k?=
 =?us-ascii?Q?3iGlllOwkFWJECaYs7TOcjmzF1sS4KLU42MDABBjvYJFUJnpLtFbiu3WgovG?=
 =?us-ascii?Q?B+KV94MuBCJt54hlRKiH3vUU3J6k4vFBjWWlLwFDZtdyxLBDAjAMvUaCiiPo?=
 =?us-ascii?Q?QFydFFTlEaopMDbu5nPLAB52kvE7Jvpe?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UwCWzr0EpRzjvDAOatAVUm/H36zx8De3fAR59GeKb5jeFMMqOh3rKCM6bLTT?=
 =?us-ascii?Q?Wkv7DOkL7L3lzQjSD+sVLDUmWVfWMyPV/eFqg3wwqTwodo78DBmw8fv/2biD?=
 =?us-ascii?Q?pysUXkGnwXdVi1DKFJZuLB+UkTgWoHUM60bhb/h+2P89MBVp/6VwU/MZIUXt?=
 =?us-ascii?Q?FzxLxxHUuXDJJF8XZivHe1wEwDj16h4Hl01FIdH83VuwgL7x3R0iVNDWFIVy?=
 =?us-ascii?Q?CYeSEXLfDkX0V77VC9CVS4CY4QQd90m2ouwQOY32qCNBx2Hz0vEkF/iifo7E?=
 =?us-ascii?Q?HNz3pMfPV11l/B1tz+MEAyOdVM1gbdTxirRhxDl37SaLkLxheZVmpO5wg6bj?=
 =?us-ascii?Q?xDHCNPiIvt4qCI7cnUHaZeBeQFS95XPRNd/Bnts3RJFGVjWB9jJwRhoLSVNA?=
 =?us-ascii?Q?Ir1XLLp3Z/VZk6lLGVfkvIT5Btg/WWd9bfwV2ZN19NDVa9hZR+AmDIGQnRon?=
 =?us-ascii?Q?AF4YwLFGffacYLmJnQ0OBASkgj18QK4gWREI7EqfEEjCmdJVGlFjyL32Rx5j?=
 =?us-ascii?Q?7nQybKAO0jObP9KIVDQTxJDfvxM+6LgQ3W1ySx9JA9EKOpMmS5XaHAsdiq++?=
 =?us-ascii?Q?RMBilPXoDT7wm+yf8sJ9Givmz1PnsRaUHjFFtTKZxeERDTibf6UK2ffQCWJQ?=
 =?us-ascii?Q?HL6Y+H2EJTbT5m6rAn1nSjWuqdIi3I3nBKgEdG06tiMglxQl7i56oOiTtJmO?=
 =?us-ascii?Q?UN/W96p+lGQUjOQHy6PuIrn2g9oQxb5M5QDXWWa3rjHN98zqks5w3hxg1690?=
 =?us-ascii?Q?te8JfXQ5Mm/6XA1JE7AHXpx/p3CW8mEE6iPGiWA10h/d0ezFYiFOplM75U2S?=
 =?us-ascii?Q?C4TXQ3GTP5OBUihRBejvwfSuESC9TAgElQHhNddV0nYBtzGVpVlD67mdqDHC?=
 =?us-ascii?Q?Wd6fSr8HWbIydGwoviVHzHWbCMz9OHckh5LjF7SxSM1JeiOGB14caS2Gcyfp?=
 =?us-ascii?Q?8DnWr7xvMzRaZbvKGdxcuHgk7MSqa52dkBf361UHdUx8tL56UJ7dErN/q+km?=
 =?us-ascii?Q?J5WV9FO4TTxeioQFx8x4QOti0WMTtx/Rr7zfkyWRQfRmnvgzbWbSUWsZ/aE/?=
 =?us-ascii?Q?1cw/BE/AX/JLk7S03Ekpzvs84UKlQIq+6UH025boXIDfuNd/gnCdPzZ/A2hV?=
 =?us-ascii?Q?9jCvAVDh+IIZjwezJyrI7NLv52JcjdXriLKwoPgjODnSKJLkIRvrZtid2Fed?=
 =?us-ascii?Q?sZXOr2dhhlTJIaea+8OdbT1/FRVMPjH9ZbqCx03D79qSXLUquUKog5zBWEQl?=
 =?us-ascii?Q?EsjU576zG2lA2qJ7F+txxIlAblzx0KSyH5Fo6/W/nLiGhxzfzo3mFZqthBYY?=
 =?us-ascii?Q?uvAXphmITWH7NZYM3/4JrMB3ENQpsfIYdlE1JsLXNapNLTkdkXbR5VrLcgjd?=
 =?us-ascii?Q?8quHr1UUrjGI9HaJ8pNIxQ/hV8UK/pWWnXK8YuSXQMrfMaWD7oN/UwA7NKyB?=
 =?us-ascii?Q?n9fkWxPd4RRHyYKM+c8KsiNqD922WEOGO8UpA/DQTtjT0CEPIhXckMBaIAhe?=
 =?us-ascii?Q?ISdtavV4TfLu79tveOTSWLwAwBBCjZO8T883a35zJ1WV7TV0p3lj3NHSdQVH?=
 =?us-ascii?Q?aEAdfJfkvl55i7vgMMV7IT6kEM92Rr1Dw5sC6XsP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e56ee88-b4a5-47e0-c9f0-08dd54a2b3a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 07:13:13.1658 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /NwVqB6TDW1fAIRw0ivcgoI0ypqewjDIcGBt9AH4nT7jE/jLfi66qrI4IYLuTNoI3Le7S7FzwuLUeZvKfemEaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB6379
X-Proofpoint-GUID: 74Ua4gsm4USw5scW3xby2NCx8Bq-opho
X-Proofpoint-ORIG-GUID: 74Ua4gsm4USw5scW3xby2NCx8Bq-opho
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_02,2025-02-20_02,2024-11-22_01
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

> Subject: [v4 1/5] vhost: skip crypto op fetch before vring init
>=20
> Until virtio avail ring is initialized (by VHOST_USER_SET_VRING_ADDR),
> worker thread should not try to fetch crypto op, which would lead to
> memory fault.
>=20
> Fixes: 939066d96563 ("vhost/crypto: add public function implementation")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Acked-by: Akhil Goyal <gakhil@marvell.com>
