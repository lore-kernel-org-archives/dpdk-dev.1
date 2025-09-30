Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90E9CCA468
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 15:27:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BFF814025F;
	Tue, 30 Sep 2025 17:27:48 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by mails.dpdk.org (Postfix) with ESMTP id 4F33B40151
 for <dev@dpdk.org>; Tue, 30 Sep 2025 17:27:47 +0200 (CEST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UC45aP010709;
 Tue, 30 Sep 2025 15:27:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=uHiLOvadp/1cxswJnIzAd3Pn
 W97ssKlCKn2CCvCk6Hc=; b=EIkMDIwE07L2rHGVXeIYWQ78PQptm0LNcrrHIqKJ
 1sJIRBPelNABfDN+HFTlYOOY2CCerzLPIZXVXlOY4CGvwOGrFJAsKS1oQ9DesEeu
 C48b88L+fj5l2aH38n8Hzhr+obi4EP8E37ZGBTFy8vL4No4z0WAQ0mAgqD9ZQoVP
 mWppH5gtHodj/QZyoZyoe5ipXJ4ZHlSCP+yui2+qxwC6icsFH6IqjCY+x0JxEN9W
 ykm9n/bgFhl/71zceqaRODGJfLQm3n23/wAJB+v/KABHncANeU9Qfq2s4c4vPds5
 VsfLhU++HBfAzsON9fIgivZZgKC9OEKsI1UkJK6XHQo5mw==
Received: from dm5pr08cu004.outbound.protection.outlook.com
 (mail-dm5pr08cu00405.outbound.protection.outlook.com [40.93.13.101])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e5mcst3t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Sep 2025 15:27:46 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Plm0yTvSfrsD/PkBhkGbicazZLfPhtX96hpDzwz894xW3HVO9iZKMYOm3/mQbURXuDPHLa9wInfCU9fqrlOYPpHOdVp1R3DqABzDYNkffzGknM5ehYPSlDw8DC3Pivb5VP8755ig88ohB+w1CezQruQ77f1yM21GTNK8iTljJQz8GrqatKAYaxdHFBF01k/DIcFqmxIRY4RVw4m1am0e+ghL7QsMLiqQ3JNGTzJFniZlkIbQ9q0sRMLb7NKuk//HwM1UYQu0Rl7ksx8nZrzkS7+ZCHW7n2tTQprOfJPouaZFXEbVTsOfvgGzDf37ulnLzmn1ThwFo9CS6suJvgiizw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHiLOvadp/1cxswJnIzAd3PnW97ssKlCKn2CCvCk6Hc=;
 b=svDcHUzD0wW3qwNV37kkg3OjE1wl6zwxc6D2+tp3Zahl1wRFuekA7hzQ7MYeon5xyt04cMCHfoKEpDz47efa7j45zx2ZoK9FWxr1iJk71x5ueOM3TOSmNnY5raC8CwemkzwCav4D/3TahROprLb4kzEdV5EqQtRx5tQ7nRbqr4t2GISmYPQhgGDtUux4Yz+PRemIw9c9NDXUdcQs02uH2DF0Atgp8BwaFRkFkxncQL/i8t8LC1s10bIALuMh8MxxG6eUcR3D07ZstuJ/v1fot+R/UW9P7xtwBs0JstkG8mKfySXiMQnE8afTJChvU7ekgYHml9CvqWk4ZQilsWNBdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from SJ2PR02MB9795.namprd02.prod.outlook.com (2603:10b6:a03:549::7)
 by SA2PR02MB7754.namprd02.prod.outlook.com (2603:10b6:806:148::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 15:27:40 +0000
Received: from SJ2PR02MB9795.namprd02.prod.outlook.com
 ([fe80::5f1:dcbe:bb2f:83d8]) by SJ2PR02MB9795.namprd02.prod.outlook.com
 ([fe80::5f1:dcbe:bb2f:83d8%5]) with mapi id 15.20.9160.014; Tue, 30 Sep 2025
 15:27:40 +0000
From: Sameer Vaze <svaze@qti.qualcomm.com>
To: Akhil Goyal <gakhil@marvell.com>, Sunila Sahu <ssahu@marvell.com>, Fan
 Zhang <fanzhang.oss@gmail.com>, Ashish Gupta <ashishg@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [EXTERNAL] [PATCH] app/compress-perf: support dictionary files
Thread-Topic: [EXTERNAL] [PATCH] app/compress-perf: support dictionary files
Thread-Index: AQHb0L137i4Jy3qVq0eP0deo4bMumbPrrOgAgAeQrQCAFMAQgICSI2YngACEeoCAALNxV4ARQh7y
Date: Tue, 30 Sep 2025 15:27:40 +0000
Message-ID: <SJ2PR02MB9795463C7D404C59ABE617B5891AA@SJ2PR02MB9795.namprd02.prod.outlook.com>
References: <20250530210956.1207580-1-svaze@qti.qualcomm.com>
 <20250604164134.776009-1-svaze@qti.qualcomm.com>
 <CO6PR18MB4484330DB3461425B5FD4AA7D873A@CO6PR18MB4484.namprd18.prod.outlook.com>
 <SJ2PR02MB9795F48C88D139220AF7B80A8916A@SJ2PR02MB9795.namprd02.prod.outlook.com>
 <CO6PR18MB4484973EF4D64751A206D8BED811A@CO6PR18MB4484.namprd18.prod.outlook.com>
 <SJ2PR02MB97954EB015631E1817D6E3628911A@SJ2PR02MB9795.namprd02.prod.outlook.com>
In-Reply-To: <SJ2PR02MB97954EB015631E1817D6E3628911A@SJ2PR02MB9795.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR02MB9795:EE_|SA2PR02MB7754:EE_
x-ms-office365-filtering-correlation-id: 965ad78f-42da-45e3-4eef-08de0035e4c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|13003099007|8096899003|7053199007;
x-microsoft-antispam-message-info: =?Windows-1252?Q?UDtknSi/ZC38LPYrBY+CwbDmSIcoaKvB9fjS9s4jlerHJPb3FBhO79D1?=
 =?Windows-1252?Q?p1xpb2FaJ8GGV6+sUmAv1s5klz6DmEsak2OxBe6wDmmycKHPqFXR2BGc?=
 =?Windows-1252?Q?QIWgPHs4Hf/yZarkCskeVb+9YS3ATyZXdXwRIeTw7NUo1AM1EjAnr5xr?=
 =?Windows-1252?Q?kwpUs3MRdSCH/TBIg9VMLvIlM1ZcpJCwqUVometJf92X5SvknEYAdT8r?=
 =?Windows-1252?Q?4/JnAOmKyddOBfN6F+mPrLDbH4j71M+ghuSIp/ANrY48gakjVrBMqgb6?=
 =?Windows-1252?Q?Ibto5F7hibmfIQ6ZNukE3IlRht+8woIzW0fRJo81Jn4vUikFd0Sd4cV9?=
 =?Windows-1252?Q?XzvNk66Vvq5SNm6W0F/oLRHgLqoH6r82D/BDQRd5YhBlCOfYycYB9gea?=
 =?Windows-1252?Q?Sf/Lew69Kqtd4aQY1cnzEe+s20IhvHVaTmo4clRuLFHm78XV9t3GYitP?=
 =?Windows-1252?Q?p01FpN5slRSWRQ44LkE+DfgZXHf7NjjO8res6X5Ht43LEZOV8J3Dhxel?=
 =?Windows-1252?Q?UV1v+thd08KrhxC/El2n9RPVCqb+2UklFIxbQhhTK50SP+v0eQQ/rIN5?=
 =?Windows-1252?Q?tHCiii+l8Fc8GsiWpZ8t/2FXJW182BnPg5a+dvM+CQVRggGbFpHN2x3W?=
 =?Windows-1252?Q?Ai6qBDY8cAQcafuObqO4G0FtikyNEokEiSQYL6Uru0N5Mq5+iN3crBo/?=
 =?Windows-1252?Q?iZ7h2xR7KCAb2KMb7Gd4f6WJl3BhuIo1/VBQY92CAQOuBKtaRZZeazYB?=
 =?Windows-1252?Q?5XrOazpTQ+/HbErjek1L/9OUwURe2J4d7QlWXp/VcqKEerk1GeQOvgN5?=
 =?Windows-1252?Q?18o2Yrg2C/SKow6tQ/CQI2353K76P1ulwcatpIYH/N37N0bKTF3n9QfR?=
 =?Windows-1252?Q?qehvJKNEotIOuvDeSjvrd4jG//1WVEDs2wAds/CuQcIzArP2ux7wXHgg?=
 =?Windows-1252?Q?GqlQBSCI0swVY/DXYtlOn68rA2bsxuUrf/E3B58dBegJJqkXaLfNjMsJ?=
 =?Windows-1252?Q?qyQJHDns6NXR1hEDnpYXx1OKTzBUJEFGpQ6HB9Jdib2hV80+PsQZLg6C?=
 =?Windows-1252?Q?AD9RMcAgr7za6/s7vyDwOsmNLWKPnk8KvqrZ/QUCfjG1ld5XN8DWgtpg?=
 =?Windows-1252?Q?TiXwOC7/WxVAh4+c9czL6KU1JRDBoqPSDq09m0REpBj2cth3SkOwogD4?=
 =?Windows-1252?Q?cNH3u/BIH0MUOmBbuPeILJRmSe5XmPt5V/Oqg6YaTJmLxQ3b7p3OMex5?=
 =?Windows-1252?Q?k3duNXI7RG75vVZOeYDo8vumVxRiBkwfxaMTrEEYu+BYYXFBU9qBlZ2s?=
 =?Windows-1252?Q?+9b77qriZZjPt2v//a6YwAFUTSdEmYmm/d3dYii1qlSFY6WTdWi2UJXR?=
 =?Windows-1252?Q?oHy7mZJqX5z/pjynGbYU5sc/g3wOPaycibFgD/eDfm9DL3+AUf46X6Kk?=
 =?Windows-1252?Q?hUthOBq6M5zGcJUrJWVNoI/pLJaU3KCz/upmZ6UH+QBhvxjAE7epnkae?=
 =?Windows-1252?Q?4dHqokgDqq9nN0WWzIwff7zAlIJtk/y2jv2ksyWm10vccrxLjNbI02qc?=
 =?Windows-1252?Q?JyBH6Hd+7Z2jONpxxzq1/0jUN+QvLrtvOYDI/w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9795.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(13003099007)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?BVLsUYhD4Ow484Q76mQWwYpizKkBvY70dR4st7XOLl/AN7dadGBI/FCW?=
 =?Windows-1252?Q?1DoBt5qaN6YOXpaAXovC8T5BRpn2GZvEfk8jeYqcb8tSPhzByM0ireoO?=
 =?Windows-1252?Q?TgQZ66r93yiFK0wZcXJaQZqK1TRzpxw0b6fbOgvmJeXbdX1S97tLRWcw?=
 =?Windows-1252?Q?eyHSNVEByAGtMG4PfdVQYNjuuke4pPWp4IoYRw2C2PvNyyDyGiSMl9LD?=
 =?Windows-1252?Q?5smL2swU19sC3z1Z1hbYLBIqVI/+utrkdmwpeEgU82sUcBwCTXszr16o?=
 =?Windows-1252?Q?Kyb2rzXLVHmJDgOvMeFaXk7sLd1f8dw2PDr8v6X9OkavbwhmxZ2ah5T3?=
 =?Windows-1252?Q?TcZgRh2VGubMQKrepKXGZiUgBAQtRMhFGiTC4eif6f6Aw4VvmAzCtpKO?=
 =?Windows-1252?Q?wxlQV8IZNE2OfND43atE1ywg1PgQucaTuWuZEf05TxALaZRSAZkLb2Kg?=
 =?Windows-1252?Q?YYstzAedgMPsNliNmIVtaYmtvJWqfJNs54Uct97taApDMVjNZPstVwd4?=
 =?Windows-1252?Q?TdCjExe2vsFsNaJbpr2nF7RwIhLPoY0rqTQ3lS/iBMBIkBZejvooxJ/k?=
 =?Windows-1252?Q?lhPmbHDu9u2K2pPrBl3yR8ETm5q8ZMdpjOcr7zJWTYmQrSnXDFN2yscx?=
 =?Windows-1252?Q?+MF8vuvXmu9eM5Zu3A392Ne0hrsb9IzjGu2Jb7GmNR8RptLu6J+Rqi1s?=
 =?Windows-1252?Q?omWIOzAP/xqz54aseO2bKOkFiLFo6slV68jAHJie+JmiLHM8Kk2OLTeu?=
 =?Windows-1252?Q?seiDMArU4aE8HcOCq2gOQIMK+JQsl/WD69bazvN/5LdrUH7vtX7zqjEY?=
 =?Windows-1252?Q?kD6VhXCVzKi+Z40YblTFEinXHFl2PeQ5GLfAbAlF23wV7VXwdg44Pifx?=
 =?Windows-1252?Q?YX1D9M0vprFAiYRJQHR7n30lHw+pdam+Id7j5OFH98Ucj05UU009977s?=
 =?Windows-1252?Q?CaZ8IVApNJhXDamO/zy8BQFqnBv7DYfXJoB2Vw59sVWeeJY/AxBL8NMg?=
 =?Windows-1252?Q?J3/DKhub8+shUS14PJjliNwea1W2bPlWOsA2aNcAP+AN6VSVsuniwUrW?=
 =?Windows-1252?Q?SYySyVIwKhcjqFXttZ2m87Uw8DfmQFUR7dxeEftNh9nIHTzuetp+0yRD?=
 =?Windows-1252?Q?EHD5hpmV7NyXivcCe13AI2fbRNiJbCIwxu2vkhETqfZKD6kaZt+Rah9g?=
 =?Windows-1252?Q?TVCww6p61T8qczPPVizNSHLH1UY3y/2xQOjgaeavtuuhYxMZDJHXM5S+?=
 =?Windows-1252?Q?qTHiPlkX1MFShNVqXpsPXS43NY7rlN0qjTUNE7SN4u6F2KTEcDgkw81/?=
 =?Windows-1252?Q?t71oSOAjuo9+scFde5xzPpmgaNWg/xvfXMTfE2j2oGuN0Iup99oZ+w5Q?=
 =?Windows-1252?Q?u0NYx4uYBELO7AMXyodObJp/24Tt6iByaGL0YiLzvsDZ6hrrFoIJcWCG?=
 =?Windows-1252?Q?01QMhBtS2fAbvGoH4g6PeT4GA8JP/4EjNybol3l2RDEy/sTurRekttEg?=
 =?Windows-1252?Q?odUTC6vcbHiKqGDRtLCr6lurpCTH7orn5mLiLV8bGaj8CsEEcy9k/fOt?=
 =?Windows-1252?Q?KmL/5tkCqAyZOG0pIptZOB/49ybgYUeIExY9OlRqwAVP9Bf4B7sMb2L3?=
 =?Windows-1252?Q?/DQ5fYEQ7fiXJT3MSWGmNDoZpQZVVqNlvQHxME/tgAjZyNPT0TDHQN1P?=
 =?Windows-1252?Q?IYAEi3sOInrW+JBoqmzpa+GDmzW99vai?=
Content-Type: multipart/alternative;
 boundary="_000_SJ2PR02MB9795463C7D404C59ABE617B5891AASJ2PR02MB9795namp_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kBz6ZpRPTdcSBaaWrOEyZ+92yASodnZBWbWLjtuuB1fzlrenQBKkLM2FBByxm74y8sMClo7V5sglu9p1E7qYBGrd9Q9aKCa0dYub/XtBG/ssPUwCRCavBjtW18sCX9UQodIU6A+of0ShQdhYPl5+12ySbtKkC8d7sW96sFexRNlv6F2LnqZDyslsW9yvz5Ldv6sE/clmSuY3qFMTBrqdZw/6Lryvk3ZYAjmx12tKHcZkwkLQeWUsI/QbHPIVSjT7UdONpE0sV6bhsbxXsnAjVruLNmxFilC+VGAdPBkXZ0LV61HjzNqTxKJ1Md7NUe7xrx8532tQ4iYf0JTT0GbgNYaLYXbzWOI5aWuYv/faSvoyqa/8VwI8nQKg1mk77iC6AWY9A2bQqHwjpEVwhCcMXjEp3wcsecNPAxJmsIGweCWHmyYOGtTa/6zbGNGHuhYGQCOLnhTYLfLeGkKiuTyqagy66QtmSUwmheFoImNjj4MIBl5wrTtQpGMESsEs5lghPpgB+GZUQX2rCx6lU6EwDD+ZrTyDhflxkh6ce76KdMAgsrDs4G49duQk6vhrgm/UHg8oUGrEQtxjFzIbB5gOOLGqjGyXRaDNM++poW+lhYjpnNtlsrZv0itvJx2dhgcB
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9795.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 965ad78f-42da-45e3-4eef-08de0035e4c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 15:27:40.4054 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A7CJVjfPT+xfGGSOl3/Mi/Z2IKjGuqM+PFTF7KR9reVpl/GI+hMheyrIPVhIbxb591QTg1DPbvBUgn07GiwI5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7754
X-Authority-Analysis: v=2.4 cv=RMC+3oi+ c=1 sm=1 tr=0 ts=68dbf6f2 cx=c_pps
 a=Dfe54NvWukFmmcciijWfiw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=8rWy6zfcAAAA:8 a=EUspDBNiAAAA:8 a=M5GUcnROAAAA:8 a=pGLkceISAAAA:8
 a=gZME2qwqLDp78jbjPUoA:9 a=pILNOxqGKmIA:10 a=k13SdgfryrkA:10
 a=fIQSOH6M60JNUX-BIDQA:9 a=ximzRbRmXI1rnYO6:21 a=frz4AuCg-hUA:10
 a=_W_S_7VecoQA:10 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: HrDZu7bg5trW73_HpK3r0eAGLs3UJXSN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAwNCBTYWx0ZWRfX8YkZiBDdjz2G
 yWuZ/7UIO1NcCohEIeNeSg3MMGKumrOftRPewg9sFMccJYKqV7nDKT6j0qgKkUT2ZmxWq9mS5J4
 6zQgbDWMhUrFrrSf+FsQbnC/Vk8RYW3y6cTOjlB9UAfC6jrEKybtVwmaI2sf3UIHT+D1iB/iXNw
 aNtiphmTmOFzfN89VEnmCEkhfZ++MKxG9pf125Rbv60HDVsmhqMGAxVEyzwzNr3Z2XZ9nxR+EkF
 4mYfNDUE4Eqm4BmtE2Ter+Sit7egCPLKpeYPUGuvEOwZOtt8QzG2tGFGt0kCTs/OVp5cM8OECxO
 WN052evh8BnuLCQH/QEfdN+mVO1Tlag7u+2Bln3mgHDuXR40hDiAoaT4wUOUoxs3pOp5TdBE9nQ
 7PEWjapiQWWVWrhFZ1ptGjUJPwqT2A==
X-Proofpoint-GUID: HrDZu7bg5trW73_HpK3r0eAGLs3UJXSN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_03,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0
 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270004
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

--_000_SJ2PR02MB9795463C7D404C59ABE617B5891AASJ2PR02MB9795namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hey Akhil,

I was able to get the changes as a series. Looks like it is now passing the=
 CI build and test steps after Patrick fixed the traffic generator and retr=
iggered a build. Let me know if you have any comments for the changes:

https://patches.dpdk.org/project/dpdk/list/?series=3D36214


Thanks
Sameer Vaze
________________________________
From: Sameer Vaze <svaze@qti.qualcomm.com>
Sent: Friday, September 19, 2025 10:00 AM
To: Akhil Goyal <gakhil@marvell.com>; Sunila Sahu <ssahu@marvell.com>; Fan =
Zhang <fanzhang.oss@gmail.com>; Ashish Gupta <ashishg@marvell.com>
Cc: dev@dpdk.org <dev@dpdk.org>
Subject: Re: [EXTERNAL] [PATCH] app/compress-perf: support dictionary files


WARNING: This email originated from outside of Qualcomm. Please be wary of =
any links or attachments, and do not enable macros.

I don't see anything specific about creating and pushing a series : 9. Cont=
ributing Code to DPDK =97 Data Plane Development Kit 25.07.0 documentation<=
https://doc.dpdk.org/guides/contributing/patches.html>.

The only mention to a series above seems to use the depends-on tag.

Thanks
Sameer Vaze
________________________________
From: Akhil Goyal <gakhil@marvell.com>
Sent: Thursday, September 18, 2025 11:08 PM
To: Sameer Vaze <svaze@qti.qualcomm.com>; Sunila Sahu <ssahu@marvell.com>; =
Fan Zhang <fanzhang.oss@gmail.com>; Ashish Gupta <ashishg@marvell.com>
Cc: dev@dpdk.org <dev@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH] app/compress-perf: support dictionary files

WARNING: This email originated from outside of Qualcomm. Please be wary of =
any links or attachments, and do not enable macros.

Hi Sameer,
> Hey Akhil,
>
> I attempted to split the changes into multiple patches and added a depend=
s-on
> the second patch. But automation does not seem to be picking up the patch=
 as a
> dependency. Is there a process step I messed up:

When you have dependent patches, you should send them as a series.
Automation runs on the last patch in the series only.
Currently it is not handling depends-on tag. It is for reviewers for now.


>
>
> Patch 1: compress/zlib: support for dictionary and PDCP checksum - Patchw=
ork
> <https://patches.dpdk.org/project/dpdk/patch/20250918204411.1701035-1-sva=
ze@qti.qualcomm.com/>
> Patch 2 with depends-n: app/compress-perf: support dictionary files - Pat=
chwork
> <https://patches.dpdk.org/project/dpdk/patch/20250918210806.1709958-1-sva=
ze@qti.qualcomm.com/>
>
> Thanks
> Sameer Vaze
> ________________________________
>
> From: Akhil Goyal <gakhil@marvell.com>
> Sent: Tuesday, June 17, 2025 3:34 PM
> To: Sameer Vaze <svaze@qti.qualcomm.com>; Sunila Sahu
> <ssahu@marvell.com>; Fan Zhang <fanzhang.oss@gmail.com>; Ashish Gupta
> <ashishg@marvell.com>
> Cc: dev@dpdk.org <dev@dpdk.org>
> Subject: RE: [EXTERNAL] [PATCH] app/compress-perf: support dictionary fil=
es
>
> WARNING: This email originated from outside of Qualcomm. Please be wary o=
f
> any links or attachments, and do not enable macros.
>
> > compress/zlib: support PDCP checksum
> >
> > compress/zlib: support zlib dictionary
> >
> > compressdev: add PDCP checksum
> >
> > compressdev: support zlib dictionary
> >
> > Adds support to provide predefined dictionaries to zlib. Handles settin=
g
> > and getting of dictionaries using zlib apis. Also includes support to
> > read dictionary files
> >
> > Adds support for passing in and validationg 3GPP PDCP spec defined
> > checksums as defined under the Uplink Data Compression(UDC) feature.
> > Changes also include functions that do inflate or deflate specific
> > checksum operations.
> >
> > Introduces new members to compression api structures to allow setting
> > predefined dictionaries
> >
> > Signed-off-by: Sameer Vaze <svaze@qti.qualcomm.com>
>
> Seems like multiple patches are squashed into a single patch
>
> I see that this patch has ABI breaks.
> We need to defer this patch for next ABI break release.
> Please split the patch appropriately.
> First patch should define the library changes.
> And subsequently logically broken PMD patches
> Followed by application patches.
> Ensure each patch is compilable.
>
> Since this patch is breaking ABI/API,
> Please send a deprecation notice to be merged in this release and
> Implementation for next release.
>
> Also avoid unnecessary and irrelevant code changes.
>


--_000_SJ2PR02MB9795463C7D404C59ABE617B5891AASJ2PR02MB9795namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Hey Akhil,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
I was able to get the changes as a series. Looks like it is now passing the=
 CI build and test steps after Patrick fixed the traffic generator and retr=
iggered a build. Let me know if you have any comments for the changes:<br>
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<a id=3D"LPlnk688399" href=3D"https://patches.dpdk.org/project/dpdk/list/?s=
eries=3D36214">https://patches.dpdk.org/project/dpdk/list/?series=3D36214</=
a></div>
<div class=3D"elementToProof" id=3D"Signature">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Thanks<br>
Sameer Vaze</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Sameer Vaze &lt;svaze=
@qti.qualcomm.com&gt;<br>
<b>Sent:</b> Friday, September 19, 2025 10:00 AM<br>
<b>To:</b> Akhil Goyal &lt;gakhil@marvell.com&gt;; Sunila Sahu &lt;ssahu@ma=
rvell.com&gt;; Fan Zhang &lt;fanzhang.oss@gmail.com&gt;; Ashish Gupta &lt;a=
shishg@marvell.com&gt;<br>
<b>Cc:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
<b>Subject:</b> Re: [EXTERNAL] [PATCH] app/compress-perf: support dictionar=
y files</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<p style=3D"text-align:center"><span style=3D"background-color:#ffff00; fon=
t-size:14px; font-family:sans-serif; color:#000000"><strong>WARNING:</stron=
g> This email originated from outside of Qualcomm. Please be wary of any li=
nks or attachments, and do not enable
 macros.</span></p>
<div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:11pt; color:=
rgb(0,0,0)">
I don't see anything specific about creating and pushing a series : <a clas=
s=3D"x_OWAAutoLink x_elementToProof" id=3D"LPlnkOWA61516d4a-7fbf-f91a-c39d-=
791cb61e936c" href=3D"https://doc.dpdk.org/guides/contributing/patches.html=
">
9. Contributing Code to DPDK =97 Data Plane Development Kit 25.07.0 documen=
tation</a>.&nbsp;</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:11pt; color:=
rgb(0,0,0)">
<br>
</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:11pt; color:=
rgb(0,0,0)">
The only mention to a series above seems to use the depends-on tag.</div>
<div id=3D"x_Signature">
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:11p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:11p=
t; color:rgb(0,0,0)">
Thanks<br>
Sameer Vaze</div>
</div>
<div id=3D"x_appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Akhil Goyal &lt;gak=
hil@marvell.com&gt;<br>
<b>Sent:</b> Thursday, September 18, 2025 11:08 PM<br>
<b>To:</b> Sameer Vaze &lt;svaze@qti.qualcomm.com&gt;; Sunila Sahu &lt;ssah=
u@marvell.com&gt;; Fan Zhang &lt;fanzhang.oss@gmail.com&gt;; Ashish Gupta &=
lt;ashishg@marvell.com&gt;<br>
<b>Cc:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
<b>Subject:</b> RE: [EXTERNAL] [PATCH] app/compress-perf: support dictionar=
y files</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">WARNING: This email originated from outside of Q=
ualcomm. Please be wary of any links or attachments, and do not enable macr=
os.<br>
<br>
Hi Sameer,<br>
&gt; Hey Akhil,<br>
&gt;<br>
&gt; I attempted to split the changes into multiple patches and added a dep=
ends-on<br>
&gt; the second patch. But automation does not seem to be picking up the pa=
tch as a<br>
&gt; dependency. Is there a process step I messed up:<br>
<br>
When you have dependent patches, you should send them as a series.<br>
Automation runs on the last patch in the series only.<br>
Currently it is not handling depends-on tag. It is for reviewers for now.<b=
r>
<br>
<br>
&gt;<br>
&gt;<br>
&gt; Patch 1: compress/zlib: support for dictionary and PDCP checksum - Pat=
chwork<br>
&gt; &lt;<a href=3D"https://patches.dpdk.org/project/dpdk/patch/20250918204=
411.1701035-1-svaze@qti.qualcomm.com/">https://patches.dpdk.org/project/dpd=
k/patch/20250918204411.1701035-1-svaze@qti.qualcomm.com/</a>&gt;<br>
&gt; Patch 2 with depends-n: app/compress-perf: support dictionary files - =
Patchwork<br>
&gt; &lt;<a href=3D"https://patches.dpdk.org/project/dpdk/patch/20250918210=
806.1709958-1-svaze@qti.qualcomm.com/">https://patches.dpdk.org/project/dpd=
k/patch/20250918210806.1709958-1-svaze@qti.qualcomm.com/</a>&gt;<br>
&gt;<br>
&gt; Thanks<br>
&gt; Sameer Vaze<br>
&gt; ________________________________<br>
&gt;<br>
&gt; From: Akhil Goyal &lt;gakhil@marvell.com&gt;<br>
&gt; Sent: Tuesday, June 17, 2025 3:34 PM<br>
&gt; To: Sameer Vaze &lt;svaze@qti.qualcomm.com&gt;; Sunila Sahu<br>
&gt; &lt;ssahu@marvell.com&gt;; Fan Zhang &lt;fanzhang.oss@gmail.com&gt;; A=
shish Gupta<br>
&gt; &lt;ashishg@marvell.com&gt;<br>
&gt; Cc: dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
&gt; Subject: RE: [EXTERNAL] [PATCH] app/compress-perf: support dictionary =
files<br>
&gt;<br>
&gt; WARNING: This email originated from outside of Qualcomm. Please be war=
y of<br>
&gt; any links or attachments, and do not enable macros.<br>
&gt;<br>
&gt; &gt; compress/zlib: support PDCP checksum<br>
&gt; &gt;<br>
&gt; &gt; compress/zlib: support zlib dictionary<br>
&gt; &gt;<br>
&gt; &gt; compressdev: add PDCP checksum<br>
&gt; &gt;<br>
&gt; &gt; compressdev: support zlib dictionary<br>
&gt; &gt;<br>
&gt; &gt; Adds support to provide predefined dictionaries to zlib. Handles =
setting<br>
&gt; &gt; and getting of dictionaries using zlib apis. Also includes suppor=
t to<br>
&gt; &gt; read dictionary files<br>
&gt; &gt;<br>
&gt; &gt; Adds support for passing in and validationg 3GPP PDCP spec define=
d<br>
&gt; &gt; checksums as defined under the Uplink Data Compression(UDC) featu=
re.<br>
&gt; &gt; Changes also include functions that do inflate or deflate specifi=
c<br>
&gt; &gt; checksum operations.<br>
&gt; &gt;<br>
&gt; &gt; Introduces new members to compression api structures to allow set=
ting<br>
&gt; &gt; predefined dictionaries<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Sameer Vaze &lt;svaze@qti.qualcomm.com&gt;<br>
&gt;<br>
&gt; Seems like multiple patches are squashed into a single patch<br>
&gt;<br>
&gt; I see that this patch has ABI breaks.<br>
&gt; We need to defer this patch for next ABI break release.<br>
&gt; Please split the patch appropriately.<br>
&gt; First patch should define the library changes.<br>
&gt; And subsequently logically broken PMD patches<br>
&gt; Followed by application patches.<br>
&gt; Ensure each patch is compilable.<br>
&gt;<br>
&gt; Since this patch is breaking ABI/API,<br>
&gt; Please send a deprecation notice to be merged in this release and<br>
&gt; Implementation for next release.<br>
&gt;<br>
&gt; Also avoid unnecessary and irrelevant code changes.<br>
&gt;<br>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_SJ2PR02MB9795463C7D404C59ABE617B5891AASJ2PR02MB9795namp_--
