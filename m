Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443B9C0219D
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 13:37:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 374F242670;
	Mon, 10 Feb 2025 14:37:08 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id E089140268
 for <dev@dpdk.org>; Mon, 10 Feb 2025 14:37:06 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51A9CaDx000624;
 Mon, 10 Feb 2025 05:37:06 -0800
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44qemc0dsf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Feb 2025 05:37:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AiCnL/16w/FuhlB/AvYlSLNd4T2xN/+R/en6nmp0uyH9y0Kye3F+nw+b6alncurWxYY0y12s+E8SJhQ59qjKi+wmj/HcwzQdqKitaYKidzucUpDh3naO6On5uAH5gsrrUD5byuhvNTloxvu1RB1dTKZjqvrUkTpBm+ELqDn2r6vAGycfV35vjozlWD4GVQfo1JhNd8lvdj6eL7w7ye3z9mtPBPecgdUbl/gS0u0fj4RbKBybQwXyzX+vNE4jPNe5Fd0Vp3Q5hCoo4aj2vRmF0cNyEDP8T6ua/sBT2kUG89eB429dRFPY0QTELEix37SrezN20s4gT7Wadh8IAvOs0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EmqAHh78jDWWR6qkUzkb3emZuc8ODSsXu4pxsaD3YxQ=;
 b=XdwPm5/zN11nG2SNCqSZ7v+OC9PPvXq0GkH7OhXePgtrRFRHs+FBEDpeLMXaEXGtt9xkIZSIQLZpUROL3LypDZ0fSdsRAHvS+Sm43WkDnD2sOwzrtPOsFRFhKDZT5YOhDXnI05WaMTidSahdzp1dCOMgNMIPrqxBkTlhqQpTJrfOWSuGICUlEtYGyDsr0oYtJNIXLRsXctYRBVoKqfB2Xq71qlZjGrb0cEZ1H+6JJ0h6+7MA3XId4IJXkt3r1T+P7VHD5fiGXSps5YkN2nzgkXVX+hO7tWPdLiXhazFnbKp5IzQ7KDlbgFlzt20m7L4VfcsaoeVlBr2VJOHOwCu8KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmqAHh78jDWWR6qkUzkb3emZuc8ODSsXu4pxsaD3YxQ=;
 b=b1jH+gHsdEpCTvgfYJzUt427CGqicjNm40tB+Sdt0fUsT0zWLSInzd9qF4qZTjv8zeNFd+o8JwInav/oHvArqB77mTUVS3VdskU5FsqJp88J4fkswYb1U15GzyBDcan/SqiJZQjq3H2i7frsfcG7x60r6EvUyEBAe7yQXojQ/v8=
Received: from BY3PR18MB4785.namprd18.prod.outlook.com (2603:10b6:a03:3cc::18)
 by SJ2PR18MB5737.namprd18.prod.outlook.com (2603:10b6:a03:570::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 13:37:03 +0000
Received: from BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576]) by BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576%4]) with mapi id 15.20.8422.010; Mon, 10 Feb 2025
 13:37:02 +0000
From: Jerin Jacob <jerinj@marvell.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Chengwen Feng <fengchengwen@huawei.com>, Kevin Laatz
 <kevin.laatz@intel.com>, Bruce Richardson <bruce.richardson@intel.com>,
 Sunil Kumar Kori <skori@marvell.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: RE: [EXTERNAL] [PATCH v2 3/3] trace: fix undefined behavior in
 register
Thread-Topic: [EXTERNAL] [PATCH v2 3/3] trace: fix undefined behavior in
 register
Thread-Index: AQHbcyeKHR0Df9WyO0uPGQS4Qq1bErNAlxQQ
Date: Mon, 10 Feb 2025 13:37:02 +0000
Message-ID: <BY3PR18MB478513EE8560354EAF1D48FEC8F22@BY3PR18MB4785.namprd18.prod.outlook.com>
References: <20250124161408.310581-1-david.marchand@redhat.com>
 <20250130145849.82003-1-david.marchand@redhat.com>
 <20250130145849.82003-3-david.marchand@redhat.com>
In-Reply-To: <20250130145849.82003-3-david.marchand@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4785:EE_|SJ2PR18MB5737:EE_
x-ms-office365-filtering-correlation-id: 71451b2b-ded1-40e8-b4b5-08dd49d8008d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?aytXk/K52HEeJMLM1x5WWzpQjqeFCpbgsyVQAKc3JEF4a8luepoQBEktRCdn?=
 =?us-ascii?Q?zDNcNhhQLdEe88TFEroCdbf+WZz32trIlZnkfBJ3vSAbmIv9ck7fWYEWek+B?=
 =?us-ascii?Q?gE1VWUl1kSPnlFFade9egn2hCns5sxAl8Z0I2/WhgVFCNzZbP3A/345VGusW?=
 =?us-ascii?Q?Ifd7Wmv8EtZaT9Wuv8QgcuBDTa4UDnOSrbY+c40ci8m1f19BfjYEqgh4mdRh?=
 =?us-ascii?Q?ExsM/qXzB+ashQ9Ges7WRbID/z+CSxTkOC8sG9WNsyeV7F4S9bfaKOAVPhOn?=
 =?us-ascii?Q?eruQBGFp/SUFuhIt/WZ4b+iQzOqbfQ8z7mNzIiTirO6ElENszoAeX8us+y/N?=
 =?us-ascii?Q?f3AmLNvGdaJTZcsNd68Xe88o3YCcwt1y+Bv5oylsknLMdYqX1IE4wco2ufG/?=
 =?us-ascii?Q?7PT7f6CtB9I1dYYP7SY77iqd0W3OT+6pZkMgPISFkdjIH8uVQODfT2S10ixJ?=
 =?us-ascii?Q?jQ4NFFMPN/tfd2HwYyWcoe/MARXQP4KBxuzS1mH+zVCf9c9RVTGXSGxzSaep?=
 =?us-ascii?Q?OjetMpj98QpWrAEQT2UXxQls/+j0XyaOBeQjSNJfzf31vXIE2+kHxRjvyTTF?=
 =?us-ascii?Q?Nl40Gy6mIOqmGXYKV2HObv4zr6nrs7/54pdZ20EwuxBpL4zEc0Z+bLlv6apD?=
 =?us-ascii?Q?wUkp+Y56qGXHdII9fV6Rs7EqjpyzSHb8GT0ZvXl7hHOkr1/w6fN//tOP3ds7?=
 =?us-ascii?Q?yOKinYCPEKuV7COcWMMgCA5Bq7THkI88e3aMHPvSHO6HHiP0DOMHOjkPfHLG?=
 =?us-ascii?Q?dwTSek4fLrrOUFoCtcga2hqk+sq0utHBAl0/isNglnxOMAOGRjWWxe+pe5CT?=
 =?us-ascii?Q?5PtO2ugrm5hwQ9/loSPdAMbW5+iK+GwIg13DBm7kLI0Ecr6r2l/6Lj3dvz/P?=
 =?us-ascii?Q?ppJ0jVPf+H8PMaV7GVNsb6OEoSI+155dKSswvLVPEvRiShb976qJZyHr3U3c?=
 =?us-ascii?Q?p/6PRtjnUPzqi/c4kcxNpDQgx9O82n7DTs4+lTDrZwdupGUEvhfrM64mvWUT?=
 =?us-ascii?Q?Mr7g6aDuUPL1zCEIFQREDGd9/5YQFL+ickTi38gWJJl6Figdtn5jECJ6pJKT?=
 =?us-ascii?Q?BgxEqnNlDL7b7U8ocsgtljlObbGeSh/ue/qQTRWkBDGHpZUzioqTcor+TFuf?=
 =?us-ascii?Q?sG87UQs232u8mBKRAqy782FaTZOH23jPI2MERVpaDGSU4p7CC49BK+/9Iuce?=
 =?us-ascii?Q?yJ25obOnpN/bt1aJ2tETTMl60s1arki4MQ1Nkv2KuTDqZprkRhZ04RNsj6H7?=
 =?us-ascii?Q?sxxeMO4XEXxRh3K/KEL/EZmmI0uj91DCdNo/O5Hs1QLoLizuHKdM8NGHjsMQ?=
 =?us-ascii?Q?JqqYTwK+v02crEb3t6/RjAwrRReSwEYCgV5G1aynv1HhZgCxjs3J3Lp2sHAb?=
 =?us-ascii?Q?k/8tEdZ7UtUmbgc9UpHWiRfN7k32ma/TZaWafniy/vPj2KR/Ng=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4785.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5mQaHP3IiAPR1KkzQ33pqmt3HqzVHv5PHqEItAok2TaNRhYwE3wPfKo+D2GE?=
 =?us-ascii?Q?OVlz7qb04d/eozEi78mZX45Hc8UoEcX06ukBiemBXl76c74XZE1Ctsdjf0a+?=
 =?us-ascii?Q?n93cVJboS8HijNHJvYTtDSL8IzTG2sj2R3OF7JNjGgECQe4YomwmuJTVgbZz?=
 =?us-ascii?Q?WtHzJickxwStYpKA+W88u8otbOik1jNcQOdPaWe+6hRYGLro0bcrXdCD47PK?=
 =?us-ascii?Q?xmsosKJPmHX+DuVDsKJ0siU9E2BM7ySnNWxexGxToA1bzUQlW7n4BuMeYfsH?=
 =?us-ascii?Q?MA4u3F2lQEMmVgkvy3ThkmuLZSPoer341rnf+l4QmFIHNZkSHHpi30crMWlK?=
 =?us-ascii?Q?7oKe8aiBObEQm3BpXws6IKwKWrY6ajWOENsz1RsYCieuY8UkXDQrPcerumZp?=
 =?us-ascii?Q?/DbmjM1fT8pI3IlvZKfpapdcHeNT8F2Zx02CVPNK6NE0lgDiD5BYXyItqxJl?=
 =?us-ascii?Q?H7d/Gr4Gy5m+Jhd7VBty2Sx8vNyDMSms0ZElUqlk63ujHZcTsu6GjFCLMvbf?=
 =?us-ascii?Q?5ES7Sg4R9Ao6aQtcgm+6TzYax93wsGWT417rW/c/a8helvzKGlkBsKbEQSo8?=
 =?us-ascii?Q?O+NvZ6kOyIy6SwC6s+tf7gVVtApRDK3KNYpsC9LTn6y4/8b49k/eFFnjY5Oh?=
 =?us-ascii?Q?ig5iHH/Qssmz4X0gWR8+EUTb2TKyIUKtcnrc0lIVV+ltyoENCKlsqyhbOkcj?=
 =?us-ascii?Q?N0dDrp8fGD02+iPPa3FQ6W4FT8ESfA77G8lPeh4czSIPScMR7qBecsHBaJn9?=
 =?us-ascii?Q?VtScVKhlL4jD24fINF3jEljd5edVMEMTvpmAoTa/WfnjchCyB0bNFQTQ/nWA?=
 =?us-ascii?Q?67vUfl6gN0xVXEyz4VX6R9mJ0XmApPlW8E0BbFLFnasrDfJ+fc4N1N0rXwfL?=
 =?us-ascii?Q?SqICP4x2a6h84qvjurHuhNfIcOSh7MAS83fzXqw5yDuFTfVFJAKmjVgcAyGw?=
 =?us-ascii?Q?fm+smVi9qocPhT11aeJf8HmoWSVh42d17pS4fDuQ4EUdjAazKcSYtkxWW1Fy?=
 =?us-ascii?Q?1MrYcCwTzP9GrTTDk6rXqbdFiJb3FVjHZxkMK5BS+7NTJe98woDjAMdG3ML4?=
 =?us-ascii?Q?qhZB/0wg2PjHUL6WA6pqGGo/q/sMeJERiWRXsZABP12GUKsdF4uz+XADeNWr?=
 =?us-ascii?Q?AOtzcfBieBS/0yyUGuGTHCot0s9+KdB11/WaouVurGJP6IX6TH9iIf+7VZHH?=
 =?us-ascii?Q?tayGXj9yz6Lm3ZVU56N5r6t7sAwYpjnAMjdl5eZS/yNKAb48j9UFpud5Dt/1?=
 =?us-ascii?Q?qv9wKgW73Fwthhw3NM53QlXe52HFLNS3bLw8jF9wAhFwTiOS3ociHQmUzU4B?=
 =?us-ascii?Q?RmoUDrjGndgvq9v5UrcKKXaPWyzvPUqI072p2bCup9eocjGuW9g0SKvDqIUB?=
 =?us-ascii?Q?IPWLlp/V5QpvGYxOKjMJP0Oax75nK0jY4m5DckLxx3sC+wdx1YC5CzrlmLkO?=
 =?us-ascii?Q?cW/5+tz8dNuX2t6owEsjdbb4h64s6TNwdvcSqJ3u3mXHOed31THfs3uTdpls?=
 =?us-ascii?Q?s0CO3KBt7tcuiR+hhfsLnfklHqw5XRjfN3jIzsM/vkCFp/MhPGK0zTc6bE8p?=
 =?us-ascii?Q?xFIOt1Pwvu1DSnM8f1c1waW9kUIbyd5fLgQKsTZk?=
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4785.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71451b2b-ded1-40e8-b4b5-08dd49d8008d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2025 13:37:02.6940 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3pYCmuCzXNgt0VrRgPZjKGd/y463G8o2TdHZR/eGVqsg8+T0q2wzQa0hnGhFULoVasP8vipf6zXzQm6LBSErNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR18MB5737
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: mRUiSjn3cbeC4QJ4eeDSShO0qnUVIDNA
X-Proofpoint-ORIG-GUID: mRUiSjn3cbeC4QJ4eeDSShO0qnUVIDNA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_07,2025-02-10_01,2024-11-22_01
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



> -----Original Message-----
> From: David Marchand <david.marchand@redhat.com>
> Sent: Thursday, January 30, 2025 8:29 PM
> To: dev@dpdk.org
> Cc: Chengwen Feng <fengchengwen@huawei.com>; Kevin Laatz
> <kevin.laatz@intel.com>; Bruce Richardson <bruce.richardson@intel.com>;
> Jerin Jacob <jerinj@marvell.com>; Sunil Kumar Kori <skori@marvell.com>; T=
yler
> Retzlaff <roretzla@linux.microsoft.com>
> Subject: [EXTERNAL] [PATCH v2 3/3] trace: fix undefined behavior in regis=
ter
>=20
> Registering a tracepoint handler was resulting so far in undefined behavi=
or at
> runtime. The RTE_TRACE_POINT_REGISTER() macro was casting the tracepoint
> handler (which expects arguments) to a void (*)(void). At runtime, callin=
g this
> handler while=20
> Registering a tracepoint handler was resulting so far in undefined behavi=
or at
> runtime.
>=20
> The RTE_TRACE_POINT_REGISTER() macro was casting the tracepoint handler
> (which expects arguments) to a void (*)(void).
> At runtime, calling this handler while registering resulted in reading th=
e current
> stack with no relation to this function prototype.

To reduce the complexity of N number of variable argument, I thought readin=
g.
SP should be fine(Not writing and corrupting it). Looks like some optimizat=
ion is dmadev
Trace not liking this. I am good with your N arguments scheme.

>=20
> +#define
> RTE_TRACE_POINT_ARGS_COUNT_(_0,_1,_2,_3,_4,_5,_6,_7,_8,_9,_10,_11,_12,
> _13,_14,_15,N, ...) \
> +	N
> +#define RTE_TRACE_POINT_ARGS_COUNT(...) \
> +
> +RTE_TRACE_POINT_ARGS_COUNT_(__VA_ARGS__,15,14,13,12,11,10,9,8,7,6,5,
> 4,3
> +,2,1,0)
> +
> +#define RTE_TRACE_POINT_ARGS_1(a) __rte_unused a #define
> +RTE_TRACE_POINT_ARGS_2(a, ...) __rte_unused a,
> +RTE_TRACE_POINT_ARGS_1(__VA_ARGS__)
> +#define RTE_TRACE_POINT_ARGS_3(a, ...) __rte_unused a,
> +RTE_TRACE_POINT_ARGS_2(__VA_ARGS__)
> +#define RTE_TRACE_POINT_ARGS_4(a, ...) __rte_unused a,
> +RTE_TRACE_POINT_ARGS_3(__VA_ARGS__)
> +#define RTE_TRACE_POINT_ARGS_5(a, ...) __rte_unused a,
> +RTE_TRACE_POINT_ARGS_4(__VA_ARGS__)
> +#define RTE_TRACE_POINT_ARGS_6(a, ...) __rte_unused a,
> +RTE_TRACE_POINT_ARGS_5(__VA_ARGS__)
> +#define RTE_TRACE_POINT_ARGS_7(a, ...) __rte_unused a,
> +RTE_TRACE_POINT_ARGS_6(__VA_ARGS__)
> +#define RTE_TRACE_POINT_ARGS_8(a, ...) __rte_unused a,
> +RTE_TRACE_POINT_ARGS_7(__VA_ARGS__)
> +#define RTE_TRACE_POINT_ARGS_9(a, ...) __rte_unused a,
> +RTE_TRACE_POINT_ARGS_8(__VA_ARGS__)
> +#define RTE_TRACE_POINT_ARGS_10(a, ...) __rte_unused a,
> +RTE_TRACE_POINT_ARGS_9(__VA_ARGS__)
> +#define RTE_TRACE_POINT_ARGS_11(a, ...) __rte_unused a,
> +RTE_TRACE_POINT_ARGS_10(__VA_ARGS__)
> +#define RTE_TRACE_POINT_ARGS_12(a, ...) __rte_unused a,
> +RTE_TRACE_POINT_ARGS_11(__VA_ARGS__)
> +#define RTE_TRACE_POINT_ARGS_13(a, ...) __rte_unused a,
> +RTE_TRACE_POINT_ARGS_12(__VA_ARGS__)
> +#define RTE_TRACE_POINT_ARGS_14(a, ...) __rte_unused a,
> +RTE_TRACE_POINT_ARGS_13(__VA_ARGS__)
> +#define RTE_TRACE_POINT_ARGS_15(a, ...) __rte_unused a,
> +RTE_TRACE_POINT_ARGS_14(__VA_ARGS__)
> +#define RTE_TRACE_POINT_ARGS_FUNC(a) RTE_TRACE_POINT_ARGS_ ## a
> #define
> +RTE_TRACE_POINT_ARGS_EXPAND(...) __VA_ARGS__ #define
> +RTE_TRACE_POINT_ARGS_(N, ...) \
> +
> 	RTE_TRACE_POINT_ARGS_EXPAND(RTE_TRACE_POINT_ARGS_FUNC(N))
> (__VA_ARGS__)
> +#define RTE_TRACE_POINT_ARGS(...) \
> +	(RTE_TRACE_POINT_ARGS_(RTE_TRACE_POINT_ARGS_COUNT(0,
> __VA_ARGS__),
> +__VA_ARGS__))
> +
> +#define __RTE_TRACE_POINT(_mode, _tp, _args, ...) \ extern
> +rte_trace_point_t __##_tp; \ static __rte_always_inline void _tp _args
> +{ } \ static __rte_always_inline void \ _tp ## _register (void) \ { \
> +	__rte_trace_point_emit_header_##_mode(&__##_tp); \
> +	__VA_ARGS__ \

I have not tested this code, Will this calling __rte_trace_point_emit* vers=
ion of register?
If not, CTF spec file not generated properly.
https://github.com/DPDK/dpdk/blob/main/lib/eal/include/rte_trace_point_regi=
ster.h#L35

