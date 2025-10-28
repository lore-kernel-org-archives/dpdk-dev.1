Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435B8CCD1BF
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 17:20:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F91A40262;
	Tue, 28 Oct 2025 18:20:11 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by mails.dpdk.org (Postfix) with ESMTP id D83D54021E
 for <dev@dpdk.org>; Tue, 28 Oct 2025 18:20:09 +0100 (CET)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59SFcwJP2027333 for <dev@dpdk.org>; Tue, 28 Oct 2025 17:20:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject; s=qcppdkim1; bh=pE286JS5CPsOXr7eTMqvEF7CQOG
 p2KtG5Y2OcyZYJeQ=; b=OmlkN5uPCcX/XWldHqEYKo51r4hay4yvWXFa5W8J+iT
 Sm0RujEySBnF/xj+2LO9jOsuEq6r3qdpanabNtckzGrVhLMLJMPgsbnQfe1co2wJ
 Rzn36OGKrke78J0AO9B4+1KIMH+73S7S6M4quB1GVwfyA2QOOP5CofBNck2uLCwl
 JXprCd/HIBHVxxdFWkMLI2d3612YxMOnAWixq5Shrl6uJgv+lpeVIamUD2vKY4v2
 8P0y+72V6m6wdyaeFrTDtmBlWZgdS+lTliTQLUT1l3L4neyZG7DuL8QXygXmsCK6
 g5Zq1bPEvGfrBK59QYSJ0sPwUgUyoVlxl+rkMn0lNpA==
Received: from sj0pr08cu001.outbound.protection.outlook.com
 (mail-sj0pr08cu00102.outbound.protection.outlook.com [40.93.1.74])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2yxtrhhv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 28 Oct 2025 17:20:09 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r235qwjtCJxXRoH8Gj9CuuDS9WHTTod8ab0NYsayVBMBHtIT+goSIeNrnls2DKdfPm0vpJZE7P6GnPFVKTSdkxItNaVeIfAIc3ponNCgEAxi3HDZFjmTbsZtHnCAC1J0YyjUQ+9TDGddDehFCXZF1iigA1wzt+un8KvSR13iHLQwyyMefYE4x1XQc1myfkW838eLBFivG02YQGrOEbLQ+34oafl5ku9cUQLuZUkddnASER5gudr4yGnZB8E99LAaH5bNWxiS5/rku2ORMH1DGOBl9Vw0ylnZZMFZb0lRxfCU6qmzwChsehOaig4AriLhOoc/owEnvoOhnRQcIrhZCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pE286JS5CPsOXr7eTMqvEF7CQOGp2KtG5Y2OcyZYJeQ=;
 b=llgBkY7EPp4IMB+dAnTjmPsHEDpDp2FRik0z8YFJOXuVi6R5bW0LoxnUNXP5QC0fn02iH+5//P4g/dP8hTtVsJBYzXO+7jKWbM1fu/P4uXvZz9hJHfSSxeKz3aJTgUFNMWTpM0Fb8WLF6eNmnTxGiaZ/GEfD984Yl+y9TRNoLhNwxS9BBQxtEAbQRYXv+lfR8o4gxYjAuB+lh3YYPc4NWarzhDlGOpAY6U7fDArqqH4YNGY8H1oQoK8i/wjnn6qeeenZrYL3dgaB3ToPaa4ELxjAb1doomFfyfV4u04maqmtKSOOEugnKAN5RXKgLEf3AKbxHo+elEXQK5Rv/0tMsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from SJ2PR02MB9795.namprd02.prod.outlook.com (2603:10b6:a03:549::7)
 by LV3PR02MB9982.namprd02.prod.outlook.com (2603:10b6:408:1a7::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 17:20:02 +0000
Received: from SJ2PR02MB9795.namprd02.prod.outlook.com
 ([fe80::697:a925:e536:acbb]) by SJ2PR02MB9795.namprd02.prod.outlook.com
 ([fe80::697:a925:e536:acbb%6]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 17:20:02 +0000
From: Sameer Vaze <svaze@qti.qualcomm.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Sameer Vaze <svaze@qti.qualcomm.com>
Subject: Re: [PATCH] app/compress-perf: fix coverity issue
Thread-Topic: [PATCH] app/compress-perf: fix coverity issue
Thread-Index: AQHcRRazNkNdp20yqkaVN+UxsLw4zbTX08gv
Date: Tue, 28 Oct 2025 17:20:02 +0000
Message-ID: <SJ2PR02MB9795341842DF1C4B70F7B32D89FDA@SJ2PR02MB9795.namprd02.prod.outlook.com>
References: <20251024184745.1698409-1-svaze@qti.qualcomm.com>
In-Reply-To: <20251024184745.1698409-1-svaze@qti.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR02MB9795:EE_|LV3PR02MB9982:EE_
x-ms-office365-filtering-correlation-id: 3a996d43-5497-402a-74a0-08de16463ade
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|8096899003|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?lyQzl8p1JZ1hZ+Lt4mKkhTzrNFFJLIgAeaMexJ3vfWo1JoTN+kbXYgg0rkgN?=
 =?us-ascii?Q?YYMzBwU9WuvmsfnRlJgi9Eg19hXZYXVlsRKSIFooQd+D5tXqT+s5g/parIGA?=
 =?us-ascii?Q?wGwkWitZrBAzBBMV7QH7n8Y1ENAuL3Vf8fXzvUcvUVq7Bhk92CWc80KBYzEY?=
 =?us-ascii?Q?hCuHj0ZriDImgK/DbbIWmU2qxj/klfMj7i9xeyLodhwpnnmrUWvLC5jYIW9G?=
 =?us-ascii?Q?PEzIqrPj9qhb7ViPca6/ed6aD6i0cDhV9g3wfegh17EoN4uYG/GHPTTIYQOq?=
 =?us-ascii?Q?9+xt1oZ9gtJxPR8r2SavjUTpg9FA7/PGtCThRytSIqS2bLBkJl85zXJCTW+9?=
 =?us-ascii?Q?a5nikP831KF3m29ztIX9vb+tmTfrg74EhYl95P3gqoKX3NdsPodcuVajM9gE?=
 =?us-ascii?Q?CZd9UtshmH7hYaKlOMaWBGHbY6Z6MZrjuaaqEwgdfR57JaP+D825KGbXOlwz?=
 =?us-ascii?Q?RFI06UrKgGoB7qdr9oaEE36C1I6PQULCyEo5MFOEhgWWse0olJp+MNt2XO6Q?=
 =?us-ascii?Q?lBBVEB7fb+qroGZbKoekmJQimBWQYBkhOSJnhgRRt4Ofb+VIZvOF9QOspanu?=
 =?us-ascii?Q?+OvK33TswSw7QAHzYvxwrQpCsfXloC/Il03Fei7XumUetlBjXGDgLpqmrj6i?=
 =?us-ascii?Q?yhOtPQDsm1frIEWENBR9WtLSgUJj3l8B/+vgw9cDujqJy9nUGh0EvqocIHWt?=
 =?us-ascii?Q?DAa14UNe43jErMh7I+uCmgYw9AhF2vo3rc3tQFEv1+KYHgc9LEFwaZ61NykA?=
 =?us-ascii?Q?72cCdYzJ59w3DwtsmNaxSYVbcBS37U4woSa0HgGIuXwxgxmmFszYBNUhBdIA?=
 =?us-ascii?Q?I5B2VTXwpzEVI3QPr08U7tzkIhQw9tuumRKtAOQvqJAsQbSCe81IiU/jOii1?=
 =?us-ascii?Q?+ac9FdueFV6Ox31WNtC6sCwgYgB7XTzlH7fVYqV+w0RfEgcA28Jt3sNmTQuG?=
 =?us-ascii?Q?F0Jev5YO0uHsx35CsKaOW1u8lu73XtpgqrjnIzUV/DJyrk6NPUn4qVlNYYck?=
 =?us-ascii?Q?I2skYaqfkTuf1OaK6hmxzcK9DW0Yr6d7jfBDfTv7kkHqGAKOHV2gFdQAKzHK?=
 =?us-ascii?Q?g+/P9hptfgzWcP9ZQTVf/Y0CR2J4/W5xM82hz3yuzUtF0yO/UZUjSilQLli7?=
 =?us-ascii?Q?2eiunKwyXkkyMu7l2YZY3RlV7pX8Lsh2r7q0ElnzWOWWjr4g1bQ6tQEh5Tgk?=
 =?us-ascii?Q?2VK3cRRbt7w99m2bBY5WoZpqnaLoez/kJVZtxuFBC3Sfm/+VoBFfJUwCE9x/?=
 =?us-ascii?Q?Js2tghrpDSyieuUxcfNLrdrQPo1WT9MpigpMnKHTDBo328mzjuyX6bKDF/b6?=
 =?us-ascii?Q?r4xkwQGv2XQ3UaiNugBAVJYbvUTktVcDNV/6IhOm+WwU/1+0fpMfwcQX3ccz?=
 =?us-ascii?Q?gEItWOFAQUybMMzZ8B1cl6Nq9i3DJGnfVKA8xTbaAnpDf0UVwSP5OwluQLnX?=
 =?us-ascii?Q?R2wtnMguvrCS5++HO/Etq1i0ykYj2Pb6g2egSu669kq0W7+6SfW+2cbYxUjR?=
 =?us-ascii?Q?c2de4wqHhacI0P7KAwKx+aW9QwhO1YemI5Hr?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9795.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ed+OubAVD+FP9cXCWHd9Enw1Kcn6IuIRJn+J83Zk7TOGIyGb0qwhjQWzpPIr?=
 =?us-ascii?Q?jajos45MoAtntEDxh0tOeSN+dS+PNuv7P27Q7BrgL2ZEVq5M7Z0LEUzPhaZQ?=
 =?us-ascii?Q?DYHcgMYvKLoOoGTUeI8QXajA9RRdgKcz+fAyeykHTb8TrmWqdHCjrH3GXzCK?=
 =?us-ascii?Q?2IS7TAvZAW0lx3Ot0tm+HfRX0pZVAPkW7+9yOnuXtuGtEvZyD6Nh80zH4Y+e?=
 =?us-ascii?Q?SnS2nULVhz/dvMI4alKMKu9dBeQzqn92+tPyBcC9vqMl8pyWyC/lQIKSctuN?=
 =?us-ascii?Q?cUIMRpd71Mxdts8F401B2EHMoEkTI6TPg8tVCJge5l0kdAADOyuhLC2uhM4B?=
 =?us-ascii?Q?dLoSMDQSf/83cd7Cahd4IgUVhz7vxHYZgNDuRGb4l6GIRZepLRduoSlJYU0z?=
 =?us-ascii?Q?PzYqWEES/rgSlmtq4TH+l8LI7n2Nvpau1D4HNq+h5n4ePHKK4kQv8RyJg5yN?=
 =?us-ascii?Q?CT/xfxCX3fuRHFERMH3ruBVvwsDKXz6WqXMzJbetFZAY0KuUuRKUs3of6Drr?=
 =?us-ascii?Q?6hAePnASEZrkaHwMAadnmLw6NjyQTQhIeRQMcykIcclSq2JcfRCEEmiGxgVq?=
 =?us-ascii?Q?805K37hnoyRwnBnppBQJpW6MDmxPb7+IMXJ1Fd6yqxsbFtvlscg7haAFJDfT?=
 =?us-ascii?Q?N5W7J+PffeZXM6fd0c+YOTp2MIiy9T9QGqj0gbudCXvDKZlzLuycgB88eTr6?=
 =?us-ascii?Q?8aeRExFp6HYp3LE8astNpBJbxWgSbRmS7fNMg/qTtqeT0pxIxNVr+9kwyuYn?=
 =?us-ascii?Q?kPfhkXTP8YFj6UwL2VqC1JxP9FIjBKcwjEZwLcdkHYbLPOCNXDbV+h4mXllU?=
 =?us-ascii?Q?QLLkjf5XEFMWVrb+0+ELBOwN/mKrJeSvOxUo6ydaCzyF4BY1VR/DnS5dZdIN?=
 =?us-ascii?Q?ImRIckVwI9YDCfTk464Ep7ZMfB/TMM2cHXaa4ZzamL9yynaK2TccsUAUYvW5?=
 =?us-ascii?Q?6UXVqtz63rcajTglqeZQl6sgaTHnkyltO3r10UoFY1w4hous3vECuGceVXwK?=
 =?us-ascii?Q?NvAtLafj7RqdCVyrILIpCRqT9SsNkqKLOeR7EfVBnQdSfyitD94FiRd8czZX?=
 =?us-ascii?Q?Z1CIEFJj7xpGug3qXQsNYP0w3t/UgLr37op1TAbdLlfj03zCoOvskp5r7CUT?=
 =?us-ascii?Q?HXEInNEQQUZLpm4mgcbz9fdC/oGsiVKtHSwKfgbQAvwI0BFevophCKE4aCU8?=
 =?us-ascii?Q?ZVkkebMbkPY1Phaa/P4TkR6KY7JRCv1gex1JrjVibJXD7dPP2+r4KF6SXULj?=
 =?us-ascii?Q?ZvQJzCmfYlo8efGu4G5VKfuJrve7WgsNx5xXxMw2U0srEzUkr9xE/qJN/ZrZ?=
 =?us-ascii?Q?4jQ/hKk7P3Th0Cb6beFPO4Z8nfCqEQEqjIv+OQWOpZj3oUcEC6SdQmaEuX+5?=
 =?us-ascii?Q?naypdgqDS2DckRWmXQ929hJgkmyz7R5XW9BEZxAgYYBBZGZnI1coAdfpRE8t?=
 =?us-ascii?Q?L6MlaT0k7TUr9+wGkH97C1ZS0JHJFbXMuw0u9AFtjMOMc3uKqCeogaS9Bz7g?=
 =?us-ascii?Q?dWxh1ghzAS65yAETzJ7TATymkdsBr3deAOH/XVjV3JRtbzbiqnr/RXqY9R3d?=
 =?us-ascii?Q?SbXjNM7sXlilETsAuhcMtOcuOVIWgBgNBYt/+dha?=
Content-Type: multipart/alternative;
 boundary="_000_SJ2PR02MB9795341842DF1C4B70F7B32D89FDASJ2PR02MB9795namp_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HyjL0nKHVg7csh0KgoPttvy1Jov9KknbVGB/jcFDnTYo8x/KH3MqB+bRcGc2EaSfyE2IGsGnQj14N8L4spcwPY7T+N1rSbCVIjZdFyK6aRNTiEkfoin4PKkwpo9N+XaiHsuZxFKG+ceBMoIfNPlo+hi0CdSSShfbUT7Ml8+jusIwIVhDwAZEKwfKRkqckaatSvVQRjL5rY/8ORobK3URi4jfCVNBfqp77R9Sc0ZabUFaaQ4EQqIGgDySp/w+gMij5/+nuJmmovaXgdNRDRhEs7WdtNJWTbNLjpAO9/tBDdz5tSxCumuSivOsnJtN2JWCx7YynxpQiVX/URvm+sUXJiWP0+e/tuHHb//kII1SI/zIgsEUQi5yrn+9uPLndSnJdAUCpnsAa+rCzTF1q9X70CoVKQwg5y8ZeRsvX8+/PRdtAlGlvrGCB1u8BFhvMKZDgk7iczUxyLYTAcQxn/AurXYOoBVW0BKoDyVCi8/sIKlIXCltOBEkYUxrRkSCNhhbuA9J/EH+SkBI/F0Mhwdp/rD/NVGMhMTMaAng0WuXeg9iPRYXZWibmM1m6O+0Za6R7zvAgXzS80WU2SiTUlxS2N3QClJ5hfPzsVmRx3n9NSuFr4friTTG3q+o56J+tJ1c
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9795.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a996d43-5497-402a-74a0-08de16463ade
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 17:20:02.4150 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JISHLsUnaPVvV8t+Uv4GbxtVespDKuqAomH7I9kxW3cPE86uGT2+SnD73YB1pYlOgvZmDPgQ6cfpzJ9GJgt/6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB9982
X-Authority-Analysis: v=2.4 cv=ZN7aWH7b c=1 sm=1 tr=0 ts=6900fb49 cx=c_pps
 a=i5O+0KHWwz6AHTILDS7dZA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=9cW_t1CCXrUA:10 a=xqWC_Br6kY4A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=8rWy6zfcAAAA:8
 a=SxM26bOyJmv0ALaE1eQA:9 a=CjuIK1q_8ugA:10 a=xfbmT3IrJVpm7hlXS28A:9
 a=lv6hTjqe4B0QkdbI:21 a=frz4AuCg-hUA:10 a=_W_S_7VecoQA:10
 a=YjdVzJdQTyZRADMV7wFX:22 a=DYNvvWTX9Sh4oU8lHtL3:22
X-Proofpoint-ORIG-GUID: wbMCqwPYcu81mhcou22SPtRJazsj1eD-
X-Proofpoint-GUID: wbMCqwPYcu81mhcou22SPtRJazsj1eD-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE0NyBTYWx0ZWRfX+mMVdwfbnfH+
 mLOXg8vsehKoX1N4XEljT9g+LRoNBZwRA/BLv4GhSADq6znGratPwX58w6tgxwUr+bhSUxSKEQ8
 jMbqCZJfnZDfyHfSh+G9fEDPC1aaPeLjlhQM2f0Zi8VTAsdyU8Xg1u2R7SJQiHQplvLb0Ap/Epy
 hAbBZCICDVmiwj9fnn36VPjuWGp1lr4hiGvT2ogzFi++293fl+g4m1b5qfwFuK15lbjeQtc043p
 AJnJ3jAxlPeYa+nEZOv28utzgBUNRr3RubzZWz4aLx9VtTXKTwzpR9rfX7sRJEGeApQj8UEj6aU
 nm4iwm1j3F3ZdV62XtPPJVG2knaGWQ63dW3kexT/3QQorCrtobDnRIWa8vLikE1kTPbomkMrhjz
 cVfMT+L8V5KDttkMtrBmr0w6I8/IyQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_06,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510020000
 definitions=main-2510280147
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

--_000_SJ2PR02MB9795341842DF1C4B70F7B32D89FDASJ2PR02MB9795namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Recheck-request: rebase=3Dmain, github-robot, iol-sample-apps-testing, iol-=
compile-amd64-testing
________________________________
From: Sameer Vaze <svaze@qti.qualcomm.com>
Sent: Friday, October 24, 2025 12:47 PM
Cc: dev@dpdk.org <dev@dpdk.org>; Sameer Vaze <svaze@qti.qualcomm.com>
Subject: [PATCH] app/compress-perf: fix coverity issue

Removes possible assignment of a signed value
to an unsigned parameter. Also makes dictionary
an optional argument

Signed-off-by: Sameer Vaze <svaze@qti.qualcomm.com>
---
 .../comp_perf_options_parse.c                 |  2 +-
 app/test-compress-perf/main.c                 | 19 +++++++++++++------
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/app/test-compress-perf/comp_perf_options_parse.c b/app/test-co=
mpress-perf/comp_perf_options_parse.c
index 49197dc290..16d31c7e90 100644
--- a/app/test-compress-perf/comp_perf_options_parse.c
+++ b/app/test-compress-perf/comp_perf_options_parse.c
@@ -660,7 +660,7 @@ static struct option lgopts[] =3D {
         { CPERF_LEVEL, required_argument, 0, 0 },
         { CPERF_WINDOW_SIZE, required_argument, 0, 0 },
         { CPERF_EXTERNAL_MBUFS, 0, 0, 0 },
-       { CPERF_DICTIONARY, required_argument, 0, 0 },
+       { CPERF_DICTIONARY, optional_argument, 0, 0 },
         { CPERF_CYCLECOUNT_DELAY_US, required_argument, 0, 0 },
         { NULL, 0, 0, 0 }
 };
diff --git a/app/test-compress-perf/main.c b/app/test-compress-perf/main.c
index 11b016069c..59af073f12 100644
--- a/app/test-compress-perf/main.c
+++ b/app/test-compress-perf/main.c
@@ -355,16 +355,22 @@ comp_perf_dump_dictionary_data(struct comp_test_data =
*test_data)
                 RTE_LOG(ERR, USER1, "Size of input could not be calculated=
\n");
                 goto end;
         }
-       size_t actual_file_sz =3D ftell(f);
+       long file_sz =3D ftell(f);
         /* If extended input data size has not been set,
          * input data size =3D file size
          */

+       if (file_sz < 0) {
+               RTE_LOG(ERR, USER1, "Actual file size could not be determin=
ed\n");
+               goto end;
+       }
+
+       size_t actual_file_sz =3D (size_t)file_sz;
+
         if (test_data->dictionary_data_sz =3D=3D 0)
                 test_data->dictionary_data_sz =3D actual_file_sz;

-       if (test_data->dictionary_data_sz <=3D 0 || actual_file_sz <=3D 0 |=
|
-                       fseek(f, 0, SEEK_SET) !=3D 0) {
+       if (fseek(f, 0, SEEK_SET) !=3D 0) {
                 RTE_LOG(ERR, USER1, "Size of input could not be calculated=
\n");
                 goto end;
         }
@@ -386,11 +392,15 @@ comp_perf_dump_dictionary_data(struct comp_test_data =
*test_data)

                 if (fread(data, data_to_read, 1, f) !=3D 1) {
                         RTE_LOG(ERR, USER1, "Input file could not be read\=
n");
+                       if (test_data->dictionary_data)
+                               rte_free(test_data->dictionary_data);
                         goto end;
                 }
                 if (fseek(f, 0, SEEK_SET) !=3D 0) {
                         RTE_LOG(ERR, USER1,
                                 "Size of input could not be calculated\n")=
;
+                       if (test_data->dictionary_data)
+                               rte_free(test_data->dictionary_data);
                         goto end;
                 }
                 remaining_data -=3D data_to_read;
@@ -414,9 +424,6 @@ comp_perf_dump_dictionary_data(struct comp_test_data *t=
est_data)
         if (f)
                 fclose(f);

-       if (test_data->dictionary_data)
-               rte_free(test_data->dictionary_data);
-
         return ret;
 }

--
2.31.1


--_000_SJ2PR02MB9795341842DF1C4B70F7B32D89FDASJ2PR02MB9795namp_
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
Recheck-request: rebase=3Dmain,&nbsp;github-robot, iol-sample-apps-testing,=
 iol-compile-amd64-testing</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Sameer Vaze &lt;svaze=
@qti.qualcomm.com&gt;<br>
<b>Sent:</b> Friday, October 24, 2025 12:47 PM<br>
<b>Cc:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;; Sameer Vaze &lt;svaze@qti.qua=
lcomm.com&gt;<br>
<b>Subject:</b> [PATCH] app/compress-perf: fix coverity issue</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Removes possible assignment of a signed value<br>
to an unsigned parameter. Also makes dictionary<br>
an optional argument<br>
<br>
Signed-off-by: Sameer Vaze &lt;svaze@qti.qualcomm.com&gt;<br>
---<br>
&nbsp;.../comp_perf_options_parse.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 +-<br>
&nbsp;app/test-compress-perf/main.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 19 +++++++++++++=
------<br>
&nbsp;2 files changed, 14 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/app/test-compress-perf/comp_perf_options_parse.c b/app/test-co=
mpress-perf/comp_perf_options_parse.c<br>
index 49197dc290..16d31c7e90 100644<br>
--- a/app/test-compress-perf/comp_perf_options_parse.c<br>
+++ b/app/test-compress-perf/comp_perf_options_parse.c<br>
@@ -660,7 +660,7 @@ static struct option lgopts[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { CPERF_LEVEL, required_ar=
gument, 0, 0 },<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { CPERF_WINDOW_SIZE, requi=
red_argument, 0, 0 },<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { CPERF_EXTERNAL_MBUFS, 0,=
 0, 0 },<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { CPERF_DICTIONARY, required_argument=
, 0, 0 },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { CPERF_DICTIONARY, optional_argument=
, 0, 0 },<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { CPERF_CYCLECOUNT_DELAY_U=
S, required_argument, 0, 0 },<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { NULL, 0, 0, 0 }<br>
&nbsp;};<br>
diff --git a/app/test-compress-perf/main.c b/app/test-compress-perf/main.c<=
br>
index 11b016069c..59af073f12 100644<br>
--- a/app/test-compress-perf/main.c<br>
+++ b/app/test-compress-perf/main.c<br>
@@ -355,16 +355,22 @@ comp_perf_dump_dictionary_data(struct comp_test_data =
*test_data)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; RTE_LOG(ERR, USER1, &quot;Size of input could not be =
calculated\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto end;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t actual_file_sz =3D ftell(f);<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; long file_sz =3D ftell(f);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If extended input data =
size has not been set,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * input data size =
=3D file size<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (file_sz &lt; 0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; RTE_LOG(ERR, USER1, &quot;Actual file size could not be determin=
ed\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto end;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t actual_file_sz =3D (size_t)fil=
e_sz;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (test_data-&gt;dictiona=
ry_data_sz =3D=3D 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; test_data-&gt;dictionary_data_sz =3D actual_file_sz;<=
br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (test_data-&gt;dictionary_data_sz =
&lt;=3D 0 || actual_file_sz &lt;=3D 0 ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fseek(f, 0, SEEK=
_SET) !=3D 0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (fseek(f, 0, SEEK_SET) !=3D 0) {<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; RTE_LOG(ERR, USER1, &quot;Size of input could not be =
calculated\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto end;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -386,11 +392,15 @@ comp_perf_dump_dictionary_data(struct comp_test_data =
*test_data)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (fread(data, data_to_read, 1, f) !=3D 1) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_L=
OG(ERR, USER1, &quot;Input file could not be read\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (test_data-&g=
t;dictionary_data)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_free(test_data-&gt;dictionary_data);<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto =
end;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (fseek(f, 0, SEEK_SET) !=3D 0) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_L=
OG(ERR, USER1,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Size of input could not be=
 calculated\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (test_data-&g=
t;dictionary_data)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_free(test_data-&gt;dictionary_data);<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto =
end;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; remaining_data -=3D data_to_read;<br>
@@ -414,9 +424,6 @@ comp_perf_dump_dictionary_data(struct comp_test_data *t=
est_data)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (f)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; fclose(f);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (test_data-&gt;dictionary_data)<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; rte_free(test_data-&gt;dictionary_data);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.31.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_SJ2PR02MB9795341842DF1C4B70F7B32D89FDASJ2PR02MB9795namp_--
