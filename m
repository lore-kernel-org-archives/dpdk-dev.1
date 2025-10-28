Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DBFCCF9E0
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 17:19:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 677A340262;
	Tue, 28 Oct 2025 18:19:18 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by mails.dpdk.org (Postfix) with ESMTP id A234D4021E
 for <dev@dpdk.org>; Tue, 28 Oct 2025 18:19:16 +0100 (CET)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59SEntoO1937136; Tue, 28 Oct 2025 17:19:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=yzisUSr64W6AWNFm9Pa2Kr3s
 9+RYmMuHvOXA7OK2dUY=; b=bpaorBKrVN2j0kb2SXwWaUoY7eoLAYFFAsOCj5y+
 FgRJfr3KlR2N5EbOfATfBTCjxPKodWZo9hMpeKXtpq6fWLYuJZEuYbL0WYeZqVsi
 5SRX+pDTEs5Puts3pvyiCc6k2L3ORi1VbZalFTDkeGlLv/7TkKIMwYy5bHK/TUv+
 n5W7RkLE/cK8F1odf2XZCwOAI9kDDx+QlCfsKv2bJ1QLTcD8NKnudJ09FNUtXqQl
 3xUqTyvHmzUfA6u8cXlW2mYIouSmYCIBvaIYKTA1fsyumB/6e9wtEvMqnB0BlFYM
 HRR9hBoP7YI/F0H8hrRWTTPlK41FQwNbU0fw+7YVq9h1yw==
Received: from ds2pr08cu001.outbound.protection.outlook.com
 (mail-ds2pr08cu00102.outbound.protection.outlook.com [40.93.13.50])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2pjfaabw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 28 Oct 2025 17:19:15 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Negt9mlM+9DDldGuAZT6Up1TUaVfTDqxILL7+9pn0LIy9Lc4cgx9tVFRZpKKcz13eUr0KlIdRRP3attm2Zuns9hylmCaVijklnQhg0AG6du7MzP3/bpir9pSXujQucFG5mIEXf2w3hT1JhBtx+9pYVQmp2nOP9OgCi7r0B+0PEhEMj2FLaiY3EZn6BnVBTuDa2nhzaKb3Zpml7dC4c6LYPlp0gcLlxPqgZS1bnkoS/3iKVPMmR4GEO5kzbsXMp0VXxj+fcUyc2kfan+dK4Hr9rOvt29Vf3+YoUUf8O6XVEAS3OoWlMxZbXoBJtLT7m9irfPoEe21ZzG0/pFG2YhpHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzisUSr64W6AWNFm9Pa2Kr3s9+RYmMuHvOXA7OK2dUY=;
 b=lp3EUyqcUgMqoFoVTc2L8nt92rz7KsXendqSZPEWQxeWm625I253jToFHLtL26qIv12Ll7wXE5eWLAXuMW6R1LoVlbvBlBdhR30MfB3ZlCQv/WSJvDkHkQ7GVIJtObAypCi0mL61etWOQtWmQ51IYcrXU/ZIRvTywIXFEYQJ9kSd0b75dEH/L5fwzRqqUx5HaIEUyCimk+vGgJNetTDiQ5EuluTuGiKMHt0R4BKWLwzeu+zwUE4zCO32BAd20mpI1Jgy10HyNjQ0ya5bPJr9dyTgOWV7QG57a7j+HH6zMAYDgrHK5sJ6LjnD5UgO5xxn7jRKyyIAx5viMBiOzROvUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from SJ2PR02MB9795.namprd02.prod.outlook.com (2603:10b6:a03:549::7)
 by LV3PR02MB9982.namprd02.prod.outlook.com (2603:10b6:408:1a7::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 17:19:12 +0000
Received: from SJ2PR02MB9795.namprd02.prod.outlook.com
 ([fe80::697:a925:e536:acbb]) by SJ2PR02MB9795.namprd02.prod.outlook.com
 ([fe80::697:a925:e536:acbb%6]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 17:19:10 +0000
From: Sameer Vaze <svaze@qti.qualcomm.com>
To: Sunila Sahu <ssahu@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Ashish Gupta <ashishg@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH] compressdev: fix coverity issue
Thread-Topic: [PATCH] compressdev: fix coverity issue
Thread-Index: AQHcRRanOHKK+dCWxEif70E4SmjXVrTX00av
Date: Tue, 28 Oct 2025 17:19:10 +0000
Message-ID: <SJ2PR02MB97955A036156C166302AC92489FDA@SJ2PR02MB9795.namprd02.prod.outlook.com>
References: <20251024184724.1698235-1-svaze@qti.qualcomm.com>
In-Reply-To: <20251024184724.1698235-1-svaze@qti.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR02MB9795:EE_|LV3PR02MB9982:EE_
x-ms-office365-filtering-correlation-id: 7d6cbae8-acfa-4fca-f981-08de16461bb6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|8096899003|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?7w9+4c4gbbI4BoogcrndjLa+aQBlLQXeqOsht24PNk/aAm+QsUNjdCr9NPdl?=
 =?us-ascii?Q?9KPkJ/B8hXTR7OWZpxaYmHJB0rc4WUJ2uNohogcZ2qF428zCShBAFrbk+ble?=
 =?us-ascii?Q?bigs1XyVLP2UdzPXMPNSBzd2O/cb9njkyImXQ0z+y093v6u793lkiaugdiV0?=
 =?us-ascii?Q?MRy4iFyCG6n9DeO7Lg+EfzPlW2w8sOgUplPczMGj1A/ZGnFTBQpcDSc9Hui+?=
 =?us-ascii?Q?EjTF/NXTTzZhNkiLWLqubqer7r8xU66g8RPAdWJACJdlMzaXuTI+JjgWESLx?=
 =?us-ascii?Q?P3BwY624+x8qB6DdIZiPaK/Ocm5pkJIMPv1IiIdLNDNRlMsjoJJiBsCclqxl?=
 =?us-ascii?Q?FHoq80vfnYnvS+nX8YYFXhgkq98OBsoSXQDweBONDdpTDfYfx94qe7Dtsmw0?=
 =?us-ascii?Q?/PJyDGu+Nhxf1CMmzBB9S90CdxpaDi0vflHkl4x+9C+L4mPoIk5EUhMxVyAF?=
 =?us-ascii?Q?pJbqcul5BqHG6hSRQqeBgcMfZ2DAKviUPFzzx07uVdE103bLqo/TQQ7Lrc39?=
 =?us-ascii?Q?PmR2PjZaxTjCtjf+/NRl1A8BPNW23Un5JG8XZm74S2EObPSug+0Fg5XC9YYm?=
 =?us-ascii?Q?ytVU/pHBzXb03JHUAt6iKXRH3ZOPXwtaWhi5IaMFiW2GKQ/bcRasJBZpDhrp?=
 =?us-ascii?Q?CuFxlCkIUh2ZhZEm+ooLpncnaZF9bugBq4ErYJKZ/P1YZci6ww9/fYxMsvcI?=
 =?us-ascii?Q?R/qnaEccFFTe/u2DaLcLl/2FTaKwpnAHi8qQdLiH6LW5xdhTfTfWwJ+fwUk5?=
 =?us-ascii?Q?qqp4E0IFZxvh5xga7SAyov3ldoaT7ZV08zTe7lKjsWIdeoh1Yk5eObccsSVf?=
 =?us-ascii?Q?O6pZW36ADwX1W/8pYDJNaArHBFQ2jl2pyGyOg4nIDP1E9vWQGOm2jR8QVH9d?=
 =?us-ascii?Q?0gZ8QIpPVzJ3LGFMAyNs20eZzzOlnlgeayE1BTjfNTeY5vVWlXuuok4OXUwo?=
 =?us-ascii?Q?8duoP3UPBkkNK9paBmpS46KzVK7+E6zX6gDQq7NZKa9jkhsg0oW+r2gi+uXN?=
 =?us-ascii?Q?LcuDYOVhs8N4DrzVuCnQrYGqac95MSlujM5f1j1Ei1M6cgsc3xFWrn5b7dYU?=
 =?us-ascii?Q?5zzzAS5fm0821jyRxOwWvp9cDmEiMC5NUqJDyJI4w70mb2G+nVpnFpQm4H8E?=
 =?us-ascii?Q?k0x9vl4sObf+1rpYkrsU069sBXsve9/1uM1yVpmx09uStodKxmOZssn0NmW0?=
 =?us-ascii?Q?yLtR7dG55/6zlyebfYRAnFMt0jXhSWvUUzHEm7ErIOkx3r2Fk0IdfQ9KbAxD?=
 =?us-ascii?Q?XHMGgeRzaTzM0cUEUmrY8BeoRKfTOvH63Wffg4ZdvarBcR5DBmbXD5w313r7?=
 =?us-ascii?Q?m8AoMPpM5Cyv/drhuq/pN8axZqnuWEppQZB8n/alp51f0HXqXaMWKXs6kxjZ?=
 =?us-ascii?Q?HiKEuhUSSyg7szCKei8ztuWjpOFF03sBXgN+QRlcw2bS7jXXRL1qsdhipbvS?=
 =?us-ascii?Q?lZMfdygxPAyXVT1aZGle0hf42piHhK4kAFzMvKyzG0qzkNMsFLTpYkpuudTX?=
 =?us-ascii?Q?RQoFr8li8lJpfUZq9XrqqrBmeVsZ+AWsa4RK?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9795.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?y/87nDLxKrKUH2jo47zYIG7Uw71WU8LmkIcFRyhNkV9jMv3TXwiqaxN9vtQj?=
 =?us-ascii?Q?R+kjvZX/lND0ka8JEBwqBr2/+PPHsdSFBNGcqSn3Es5XvCDI6H7thMXJdee5?=
 =?us-ascii?Q?yyj6lsvzY0w/0MvTVWys0qpJIh0TAJLq3VK28IGkv4DczJI7NsZnf+iw8ik5?=
 =?us-ascii?Q?jt1Yy3e4U8U/zES9mA4mh5EqGC1XUWMY+wIYOSwONmv5xXd62FBg4s2iZ8eJ?=
 =?us-ascii?Q?96Uj+2Jx8ycOR0HCcerD0+GtvI0RtV+49yxYX1sswoh/JNwTbZYrEQlNDdHV?=
 =?us-ascii?Q?5Gb+48KlMEmBiNqDO2njdVgUCkzNV4dnzfxek1Rf8GKWCiKWi/rEb4o0i+vO?=
 =?us-ascii?Q?9esrS0lD9Th9NtulJTYx2pAoZfV0fmkW8OyW18PNU65RqdkQmU/xs2uOcPrd?=
 =?us-ascii?Q?IM94x3CRAPCB7kiZEQCaqyt1tiYYvx5VBpuiv08y6kYoVQln7IjkijEFNyOf?=
 =?us-ascii?Q?NiVPMynANtUazfIsoRT3UcSb+vt9R0+lFYuFR281K1Dcw6s8vyBL166xM/45?=
 =?us-ascii?Q?tqBng8z9yCuaHoVPgrjov3UeY/k4/BWLmo1sKH0wssNY/CLI5Nnl3Tv9iNXs?=
 =?us-ascii?Q?hgqy/UByvW2w1L48rb0VHAPzuHFKORm71voYijjcp173WCW1Sjt0qGKoPeFG?=
 =?us-ascii?Q?op1SmWdY5q3Y8jbYPv5TdMO0IISu54eqsI7T6i0iSolOVYE/skp7JjyyDfVG?=
 =?us-ascii?Q?i24U7NuQlOCIZMbX213HouiSnq59sof8ayhCg7X9sTBLh4c0Zbo2Rndn/rKj?=
 =?us-ascii?Q?lkAJK6ttVwi+J9XRN8WDXnWEmMPylwhzBtaJq6IZfWAIFvb+Bb3gS5/3LmKn?=
 =?us-ascii?Q?9vW7Gs8lvFTiOtqrqUFdr1pi38QC3hdvbO9XNokLzAlVQ+YXfe0DYQ1Dl4Ug?=
 =?us-ascii?Q?PpfwrXHQzzQdP2uIKAUMHj9A2zzrK1iVK/XD0hNqezN03LTEgaRxRZIVBcT4?=
 =?us-ascii?Q?I5efN8vjxjyzf1Y/J+dakMEed9lFryvIhkU9Lh6pT6lWuuZedMZhhOwHA109?=
 =?us-ascii?Q?RtrJTd+gru+o0R4PtfTGwjFE2oW37tMmj9roNzgWpKV0T2TQlU9EAsMK6tQX?=
 =?us-ascii?Q?kSQjMSo7ghFBRvvNb5nwXaqbq9qSWSV0SRARjIuAb8cJ16UkH8UGsdVu375y?=
 =?us-ascii?Q?Mv/u0SQhVWrY4gZLu4amdHzEed0fbwULxPyYSPMpqTK2WheLvuASsV3mSHe1?=
 =?us-ascii?Q?O7iwxWtJDXvmbFPpr313ndvZmn5p1ZaPUbtyCShoSyXSRtZ7SnqrZtHVcxuo?=
 =?us-ascii?Q?tm2ynn5Qb75bYzES5e12G7S0M57FtAnwe//hWZIef81II7iQORE6/poFGwyz?=
 =?us-ascii?Q?VFH4HAJ6BnwQgEDALZpmzKQZsRhSvV2Cu4tMrAuhC3K+B1F5gfOjOhuf+QKc?=
 =?us-ascii?Q?7jBekMPpja2Irp8oYGy96lwcjvkWASAA39D0WDUiH2EVbpa2Df3sgtTvMYve?=
 =?us-ascii?Q?9x6HuP1l8qyNufsH7fNQdWKcxDWR1jAJqBnSyDXkXxZuBLkk/vzMJ9b7stDB?=
 =?us-ascii?Q?nq+waWHzj/v03VX8eupKU+oBlhdxxHBR3m4n2o6Md1bURdbNfFLTDGtLRasg?=
 =?us-ascii?Q?8UQL0RF10XwiM8oYoPOl4o1Z7S73WhDT/yQg2VRf?=
Content-Type: multipart/alternative;
 boundary="_000_SJ2PR02MB97955A036156C166302AC92489FDASJ2PR02MB9795namp_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: erHiiGp/Dupj6W2oOX9aazXqVMu1LjaMbmKbYlNIwNO9r6kbCWoAgQL2ZQoJJnsXAneXEKaYFJevWOtG/J3qfV3eho6ziQBNEgr0XudNqXeFg2jK6DvgyPQA3D2M9WMAmZfAD2PjjKqb8KBpcs9WBNUD1GZtRlmfMxAhO5pUkJgXKTh0LVI9+ofwiv9D1AOhjy1oyhieGhL45sAcXGPv0uNc5ww2VwJOGh69m3+ou+dQ0O4ECsSFi1lqrEgE29B8ZKR1qxfMtXh2WOFdhism/hV1SobcRbrhh3BdT9uMllB0DWKbkjz5xOuZgEwKey1PYLqUR4XYQLsVVeHKKLgD4dRiCtd3zfB7a0YOhhh6voWjq5VxoVqjahxQgOrnUW/HdsK18zk03MRVUzn3rEv85LxOXgdIBwl5+l58XAQtu56wGjN8rBhPD5OWdr8jqsHN8mRjDgZbFEmFbc6tMnNHOKl430JvVLReB33VfffCOll2EsOg0mmbG+53VEBdRyrkGyp835O7hHaRO+LqHK+l9+GGqSsc7NeaqnpScmD6+OCDvUnJOqM/Qyr16eb7R2wjeaMTd82vqlTrRbgg/opb7EvPNJD7yzQuqhhLotBVZ3JbxtMDrsfID6oSKhPoWaec
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9795.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d6cbae8-acfa-4fca-f981-08de16461bb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 17:19:10.1148 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MfNwVsBbPQHM0YOgE21LsJ/RCeaYNQlHnRwwjChic1ucoSFFxgNWn4TwV9ZCkFCdME2fZpWZNMzxcO/mdcMwIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB9982
X-Authority-Analysis: v=2.4 cv=Ut9u9uwB c=1 sm=1 tr=0 ts=6900fb13 cx=c_pps
 a=ITiX5wGoaVWtfJBAqtKqhw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=M5GUcnROAAAA:8 a=pGLkceISAAAA:8
 a=8rWy6zfcAAAA:8 a=OtfHWxG8SO0elayeX9QA:9 a=CjuIK1q_8ugA:10
 a=tICrskoflLkfJMyR0EcA:9 a=0ZKyI5_0SvVtDSmN:21 a=frz4AuCg-hUA:10
 a=_W_S_7VecoQA:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE0NyBTYWx0ZWRfXzwrcikneBQ5/
 gyw9M4w7gNIWKArQ2xvIjqYP2KIIZDFJJWzutPDKpmFugq61YCtH6qqxuxrZ8pjj8XKoJWLqYoO
 DZGUg6/j0125NFwcM2ibgIMp+SE/jBtxW9c6i8wT9o0XoO3hjEZUmtH/pImXKzJK7V++URKStKs
 /+5RthjxYuL2adECApYr6NRjnjNVqskPMOKuvfGoJLW6wbwTy7xKYoVPLTRImnJSL+xVMqq922g
 EFX/6sZpPJnnFJAXeeDCavDLtc8r3kowqYvM5yWHNNO//SEN6wpT7c5q1jnnD5wyMaGgM2Q6kq+
 HYt3UPTocfiTgIatpaLTsgBs8WnOKuKckV9sXnDMIBFW/MRhTiyTyL25+3/xP6bqFTiKcNiObpW
 76MCFmy+uKAowhHUHbBVNxweTLpmgg==
X-Proofpoint-GUID: ds2_lqUr1Zij5D29u3hB5gM70MKov_xF
X-Proofpoint-ORIG-GUID: ds2_lqUr1Zij5D29u3hB5gM70MKov_xF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_06,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510280147
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

--_000_SJ2PR02MB97955A036156C166302AC92489FDASJ2PR02MB9795namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Recheck-request: rebase=3Dmain, iol-sample-apps-testing, iol-compile-amd64-=
testing
________________________________
From: Sameer Vaze <svaze@qti.qualcomm.com>
Sent: Friday, October 24, 2025 12:47 PM
To: Sunila Sahu <ssahu@marvell.com>; Fan Zhang <fanzhang.oss@gmail.com>; As=
hish Gupta <ashishg@marvell.com>
Cc: dev@dpdk.org <dev@dpdk.org>; Sameer Vaze <svaze@qti.qualcomm.com>
Subject: [PATCH] compressdev: fix coverity issue

Adds missing free before end of function

Signed-off-by: Sameer Vaze <svaze@qti.qualcomm.com>
---
 drivers/compress/zlib/zlib_pmd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/compress/zlib/zlib_pmd.c b/drivers/compress/zlib/zlib_=
pmd.c
index 3a2485b54e..1d7651dd7d 100644
--- a/drivers/compress/zlib/zlib_pmd.c
+++ b/drivers/compress/zlib/zlib_pmd.c
@@ -126,6 +126,7 @@ process_zlib_inflate_chksum(struct rte_comp_op *op,
                 free(dictionary);
                 return;
         }
+       free(dictionary);
 }

 static void
--
2.31.1


--_000_SJ2PR02MB97955A036156C166302AC92489FDASJ2PR02MB9795namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Recheck-request: rebase=3Dmain, iol-sample-apps-testing, iol-compile-amd64-=
testing</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Sameer Vaze &lt;svaze=
@qti.qualcomm.com&gt;<br>
<b>Sent:</b> Friday, October 24, 2025 12:47 PM<br>
<b>To:</b> Sunila Sahu &lt;ssahu@marvell.com&gt;; Fan Zhang &lt;fanzhang.os=
s@gmail.com&gt;; Ashish Gupta &lt;ashishg@marvell.com&gt;<br>
<b>Cc:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;; Sameer Vaze &lt;svaze@qti.qua=
lcomm.com&gt;<br>
<b>Subject:</b> [PATCH] compressdev: fix coverity issue</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Adds missing free before end of function<br>
<br>
Signed-off-by: Sameer Vaze &lt;svaze@qti.qualcomm.com&gt;<br>
---<br>
&nbsp;drivers/compress/zlib/zlib_pmd.c | 1 +<br>
&nbsp;1 file changed, 1 insertion(+)<br>
<br>
diff --git a/drivers/compress/zlib/zlib_pmd.c b/drivers/compress/zlib/zlib_=
pmd.c<br>
index 3a2485b54e..1d7651dd7d 100644<br>
--- a/drivers/compress/zlib/zlib_pmd.c<br>
+++ b/drivers/compress/zlib/zlib_pmd.c<br>
@@ -126,6 +126,7 @@ process_zlib_inflate_chksum(struct rte_comp_op *op,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; free(dictionary);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; free(dictionary);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void<br>
-- <br>
2.31.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_SJ2PR02MB97955A036156C166302AC92489FDASJ2PR02MB9795namp_--
