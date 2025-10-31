Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0E2CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Oct 2025 17:10:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 81B0040273;
	Fri, 31 Oct 2025 18:10:09 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by mails.dpdk.org (Postfix) with ESMTP id A899540150
 for <dev@dpdk.org>; Fri, 31 Oct 2025 18:10:08 +0100 (CET)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59VAL3TE1573206; Fri, 31 Oct 2025 17:10:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=6L2g4XfMEozgJaOIR+kQ7CO/
 gcmhAkvBYY/d6ulQw34=; b=dTDT7x1FVxIx+x3wRLMOiqwMympItkirqwjWBdZu
 tftUvt0DtDVYZHPxWgvhQO2y2adRGCQJpVkdX2JKZzlYF80kHbo0zfUd/WwmnQUw
 XVvjiTaQlB8wOLcoDjZU4xeCxAl+cvNrq2tpKEhypf+jLy+nHRkF+WI3Sh18b/Ws
 f0DQEJ4bOkJqtzVk+jjvOGTov9PR7+sGVkt494FOyU6dSm6MzFEdHWzeP/IFYyeO
 yLPaVvwQ7whT064wV9ZbtIEAExxnbA9/6VDkLb/dDvWcB3mzoKdqmEwr75c9O1ol
 NpxuoYuDHOTbOa7bZeJ9qm98tm/jh0cMGmkzctjxF5W8nQ==
Received: from byapr08cu003.outbound.protection.outlook.com
 (mail-byapr08cu00307.outbound.protection.outlook.com [40.93.1.111])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4ksc2b71-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 31 Oct 2025 17:10:07 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gyRWyxXLoPAWnIsVsg9yygJBkJIxv3TF58N+xv1F3KyxHy1T+NDLhHKUcttz/ejU+5ANMVSWluKctUWicM7woF92BgrcNKoZcvWEZMDpMvu8gxOW6+9ZIZ73cwExTdtFIl5XT98pBxaeR2g6+Cp47SLqEBIV900YIdzQ5XByUamHDmdrGp3Jdv121KSk0z5t4/dY/6e2ERgw1KDujDE/lq00LFpMdY16v/nMLg07gEM5eYkPbeNLvSP9t4u1/cKjadgNn3G8EvqQojBaFkd7QeOe3Uo59/u4F1qH9XJu3RscUnOIevWK2Jy6k8Am9vJKsX8XuWTCm28JY9XhyCrgeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6L2g4XfMEozgJaOIR+kQ7CO/gcmhAkvBYY/d6ulQw34=;
 b=uMxb1xJ0iwuXrd14vmKZKHOEb5j8gIBkdgr1GMWVvkqJ4SVRU2Pxgbddwgfoe60f/l4/W/vcmliiGz3RCXucvARAma3Zcqcw5PNqzRjjCjFTKTho+I53Uli13ipn+RjUf6NIFc1KkZniP82AFT2MMFRWpQ3FMVoJQvqg0Z7FcPdwhYmrwi/ji65sd7cmzCtUizA7t51omqmHMN/JEgKuaofSt7+7759/8I+J1mUP5OCy8OxzlVC+X7QSF3JJH0wPuT3j6LWDWIKSgeUYTzY/ExIdavAf2dT1k76NRYxTJ65VNaWB9j1N2U/lFAGptWRZGuC84mtThqEprKkeAooJ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from SJ2PR02MB9795.namprd02.prod.outlook.com (2603:10b6:a03:549::7)
 by CH4PR02MB10636.namprd02.prod.outlook.com (2603:10b6:610:23b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 17:10:04 +0000
Received: from SJ2PR02MB9795.namprd02.prod.outlook.com
 ([fe80::697:a925:e536:acbb]) by SJ2PR02MB9795.namprd02.prod.outlook.com
 ([fe80::697:a925:e536:acbb%6]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 17:10:04 +0000
From: Sameer Vaze <svaze@qti.qualcomm.com>
To: Sunila Sahu <ssahu@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Ashish Gupta <ashishg@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Patrick Robb <probb@iol.unh.edu>
Subject: Re: [PATCH] compressdev: fix coverity issue
Thread-Topic: [PATCH] compressdev: fix coverity issue
Thread-Index: AQHcRRanOHKK+dCWxEif70E4SmjXVrTX00avgAS0FEA=
Date: Fri, 31 Oct 2025 17:10:04 +0000
Message-ID: <SJ2PR02MB97950C22EE0516E4903D5CF389F8A@SJ2PR02MB9795.namprd02.prod.outlook.com>
References: <20251024184724.1698235-1-svaze@qti.qualcomm.com>
 <SJ2PR02MB97955A036156C166302AC92489FDA@SJ2PR02MB9795.namprd02.prod.outlook.com>
In-Reply-To: <SJ2PR02MB97955A036156C166302AC92489FDA@SJ2PR02MB9795.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR02MB9795:EE_|CH4PR02MB10636:EE_
x-ms-office365-filtering-correlation-id: d18d98de-0dec-4826-5a54-08de18a055cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|13003099007|8096899003|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?6YewuncqkmybEmg+U8UH8oDE8raPmgoCvwfdUvo/6atFyXgyMZbwVhlfrPQM?=
 =?us-ascii?Q?kAynWZgivEMsiNpyneq4qrcovai/d+8n/GKEuFjorCyGP8JTbVjCjL8IF/vb?=
 =?us-ascii?Q?sXzn2TiAR7Qya4zrzU3E+Fle8wwYQC0R82l73UxM1KjK/zuF1mRXwKoXFzei?=
 =?us-ascii?Q?v3UqHDRzs2vlSHVVeZVqvtF6LUM/XvqG7Mev6sy8oOfSfK1aDaAZMNKBsSY5?=
 =?us-ascii?Q?vqwrHgnqaEdWJsDvzPUjQrajnLv9WnPnj4wlzOkKZ5/dVBKPdyPbWSn8uO1V?=
 =?us-ascii?Q?poOcKp27NH3fP/vBxsslshq1ZspzADmWDtUIgdjd1OLL0Smego9MAdsKO4+j?=
 =?us-ascii?Q?aQL3n8YYioE7n4o5rUNT1ynHxIYzCfLK2CAladEZFeqsZGh3FV9J8zY/6oN/?=
 =?us-ascii?Q?qFT9+9ZUdJXT1YPcP0lRWgXis2JtJdjvQB5cn57v5OZJkK0dLClNTy/iQq2F?=
 =?us-ascii?Q?qrcWp6Yr73Wc3YM3fJMVG4BwuDS0zojkzQC6jJ8TUO+4z5DAk6S6r+dBONm9?=
 =?us-ascii?Q?Lu2FT002DFSm7nF+ETdtfvUdiJyiGngqFj41O9VNfrQmVxf0VJFWmzfSxq3h?=
 =?us-ascii?Q?ODqis8I0Ad/JDBJ/kR5wncM+CZ8ffAMy/S139glDZe2goTGecAYNkUfZ+e+a?=
 =?us-ascii?Q?TrYLvupCdrVvevcy7ZdM61MLaNAXJc7fxsGOX1L6uc7ecbfvzCWk2WdaUBKv?=
 =?us-ascii?Q?M1/mn2A9j7rwzwX1TlcTVroYJ2HJWd5D+F5zuUHfEY8rKvS0vTlFtS1QHwkp?=
 =?us-ascii?Q?Ybtivf9RddfjVqcSiav61GgGlVrD8qC57LMI08eQBAF1LYAHRey4g5C6JE61?=
 =?us-ascii?Q?WOR3YjSHUgX4ilgyHZco0BP41vtFwWmGex1P1GO4SDPdzCtnUkMQMPY3M8c8?=
 =?us-ascii?Q?IoPSSn123LAZslB8PMaB3RhhmX0oxaHy9Z7SwURhoQwnbMvux1R9dRdmZOz2?=
 =?us-ascii?Q?nYSqRIqxDOsompZd89vV0bcweWU3ZQoj/WVrQUIDMoVwpeGqtZzokz6MFODn?=
 =?us-ascii?Q?dD0FKS+3Ea0nLoLY5ZgcHZZP54rXSionW/SUkbwXqlG7ubG3NoDW9ILzYOSy?=
 =?us-ascii?Q?f+rhf40ZoEdiAhHjp3csJVgN46P7Whpdy5PTfgawowcNl3+C1TJO6cX/MuvY?=
 =?us-ascii?Q?dn04qeDBG/hN0sPb+ffutn9RArryFn74wfot/XZeF+CM/g11T/bqy3yDzFw6?=
 =?us-ascii?Q?+HAXLweblNDZS5NBoMbA3OFQ8Wf9/1RZPjTSVKsiOZTGZRC+b+o5g21ub/rL?=
 =?us-ascii?Q?wh2kwz7bu4q3wpzZyfxzekOoMAQ0PkkMQBg5rEs6kSxs6yTmV8/nBWn5WpBq?=
 =?us-ascii?Q?qkvHamzr7eLZ+VkkUQOLynILACofmFZ9ab63RMudVFM8o7A6Qtsicb1woGco?=
 =?us-ascii?Q?ZYHJH9uEZE7f89sTKL8GhJ0vSY2FMh0fi1N0bP8Dlc9KcqcPuKYOnwiqqPF5?=
 =?us-ascii?Q?ds6/ndL2VTAFyGZNn70ojL34eX0YZ/U2B1YWpKI+fXIwJzoU4MX20Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9795.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(13003099007)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MKGxPLOlu8NyeWQT4E7Z47RIcFEz6Pu9JxO2fxnPorjQv+77EypjYrQOrfCO?=
 =?us-ascii?Q?ucYG0jOpnsrBSbWKEgthkH7BI/TZS9BDoWNLxh/6skxnhyclpdKMCq347x2m?=
 =?us-ascii?Q?HF2XOKnQ72RowsTohkpfPhJYCg5lk7othMKJhqpKuZcAzuaj7k2cUcP4Po8z?=
 =?us-ascii?Q?5m8q65pcPqmb+Ja4RdFuDOlyjUwxQkoIgNx2YsSkv4TGvvWZGvoL0hue4FwQ?=
 =?us-ascii?Q?gqLdMV0itprmLuJL0FiTNZX/C5ZXwrB1tzgFU3QjorzxCEphku3343gq+gDu?=
 =?us-ascii?Q?qQ9xooj72iLafz53Dvi2sHU2mTeGnAZHqMgiME/5Xv+yumvEY6sBqRuuOTZ7?=
 =?us-ascii?Q?sQZ90EN9xSaayPdakiQ0MmEtHEO8tnSOGIuchYT+e74MaON+UJcC7HNf6NDS?=
 =?us-ascii?Q?Vc4WvQ0mW5weUZ7uXu7UEb+vRUieHynjI5nEZuDTI2Gy8Rrf+Qf+zTt9csXG?=
 =?us-ascii?Q?18SfOtJWsGTxpZJom/HkQ/Mx3424JSjxscWIUxWjF3PjeZQuK6tR5pXOuw+z?=
 =?us-ascii?Q?AEJGx4AvXZ1SFerr2f9DsLwkWYIuWtTnpzxLA/yyuPpSVWTRv1BlvTFpJXip?=
 =?us-ascii?Q?Vs1xjJ6K6t4gGD06CgJz3j+NUFpsyMBd8eFA/o4KEFx734z/PULdvOhZMPZB?=
 =?us-ascii?Q?Hxe0M7EPZerGsx2Z84BWu0DE58Gz8coDh2JTx2YdoV/+yHIy5UpEKRBxYUHS?=
 =?us-ascii?Q?CDphzKcu6KEw1fbyZje/sFvg6c2L8a+ekfI/iPMWPXBZUssJLllaK2VFRaK4?=
 =?us-ascii?Q?XJqq3GrNenx5cCQnDrBp9VZAvsa7/20pUg3u3k/2t2kA8rKZVMZAgvYipV0/?=
 =?us-ascii?Q?+ImSKZkW1Ub9wDyS4X7K0XMCvSsX8yvUsYCWyvLYSWNvVJ1kuzzZnaPKmfXg?=
 =?us-ascii?Q?VYa03CpM6XpifMLThAfw8Ij7BwC32CygCzg2X7yHPnHWwYUq/NE4CfbhMN9S?=
 =?us-ascii?Q?+6284KwUPUWzohbzzl1XhtW5JtgVvWeRnCS37rOwUOZ3VpruDe3dKhPwPU0Y?=
 =?us-ascii?Q?/PrQLU/ajmYWwr+mw6o1n8u9YFGe35uyOdYyys7bb6SGs+1MLqvbMow4AZkn?=
 =?us-ascii?Q?VS3CWrQjCPqNhkij5yYv1HNvDFS5V7QIqHyzhklUcFj3TGFFdZ/KviW8G7PU?=
 =?us-ascii?Q?gFVRz/5+lAWfQoFJuRuT9aKJ0hkuT3nMibMJIA7qKGczJUFAlqLIuDPOc5lP?=
 =?us-ascii?Q?/5SrFwizg7iY5hlQSz+xIVb4fSDAEDHlMTevweu5hMY4fgcNCPrV7T4NrWgb?=
 =?us-ascii?Q?00YNzVUdk12uMswxd7DnV3p16U1dE3Ujd77Fa1TOUQZz7egF/PCDJEvWBRtj?=
 =?us-ascii?Q?7gVf0P5hUz4RRKTadfnH9rLqR7+Q1fgbYc4Wcij03pF2wnbQS3yPSBgkxR0c?=
 =?us-ascii?Q?scCnxFN0TRJbBXMGvjIsn6HZpLXiQsc1dbvh7bp5KeCPWeSWGv3SLFYFAffS?=
 =?us-ascii?Q?9cjkDv8v2dsitdC/WQJpwZnRIiSiAvoxqygI5+evfgFKNTUHjDGyk6WBDP+k?=
 =?us-ascii?Q?cA9xqHJf4dIMKqWco0Rc/1yXw4Xp1jU23yGrq/BEPNtu/M/gB0SVxPPyobxy?=
 =?us-ascii?Q?y16tdWIXz3wLByMRTIk=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SJ2PR02MB97950C22EE0516E4903D5CF389F8ASJ2PR02MB9795namp_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Um/HAXK2btSU6c3WvOw2hqSOiP4IDZj8RxODtwPVxlPLUtLv/pgm34z7P/Y7erYJYBrhzINgiFbHPvB7iDV9PZI/mwLPYDrKFk9JDDjNBOeRRXs/pnqCIP9Se5E4ZWLZsQWH1umWnSUyKpxd+/EBQmZJdl1M3JWrv9Cx8U/7n6FoYuut01RT/GaGgcM5qWCs3zZv8nedyJizqtjg9ttiFE28EW+5eSWO8rqZ1eFK0hcelYu+VGZjUBePWdYc5QMSaGSYQXiSMfVpxHoBmlat4aH/+kdTdctzbZps5X+0Tf0NYlvCmS7hErozGdsnwifSjDsdhao0ZmtirMeZssq7tyN1Nsa2cOWRqPwwA7W1arB6xhuSRzHYFnNzaMlMcHCmfV0GQKAJ1YPpdAWmwXm8AYha0dtpj2VEoFTKe3Ui8POB/AGdCZtxzZ/TJEswQQGnZTur7Z6jMuA8ZF2Hlm//F02AeePf5Phuwo826Htm5id6KX1SG3nHTw2lgm3XcLNXvfY5Eou27FmQwCgLi60VHSMqWovA7qkBWEoEaktdg3hzU/6L9lWJAhgEYUbQvvRYcfvltB9gebCVNTP6KGB2KW6GunX9bcXOR+H7hp+oeHGfI0250kAs4NJhx6094KQS
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9795.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d18d98de-0dec-4826-5a54-08de18a055cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2025 17:10:04.6171 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QpRySSWHZMZ6rsfVhexIbjw0TqadC5/wro8ZUqzoiMAK2098p3tnprMA+oBvm5rfdZdwSZ+21+Fqoo7CBXIv1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR02MB10636
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDE1MyBTYWx0ZWRfX/3MgmA/2PrTv
 4CJMf2IfTb6HPUDY5oZfjJZNOkeIANXdryL3VTu8P8bQmZkwEokCFRMZvB+1YwOt4zgM0K1TTgx
 6hflfEc2HXEHwuAGuskOJFq9VwVtg8Z7ISDvlmvb1h0DA7Xl0X+51oGZY4hchxu8P412XuyYAhJ
 8X29BKp+PRcQnpYRZVgK4oe+nBsKZHWwldy9ehrUCcB4gV8Q+AIcEckcUJgT+h4fOGjbZWLgP5n
 5gVaaGetG8f/kqyV9rDwkjbE0BFXIA2LGv0lR/ivikjxQSIsTyp50ChwjjWHmwHC2pjYliwyPvA
 +Ny9VOY6HUWeglsW41Pm0bLL2b0c6rjOinvwJepYx7+ISMRt4/9njUXdPYmY7puUYNuGt4umWOp
 gwdzG/t3BOkQyL2CmfkzCNSdjtf1EQ==
X-Authority-Analysis: v=2.4 cv=Q8PfIo2a c=1 sm=1 tr=0 ts=6904ed6f cx=c_pps
 a=FkaiYsdaSJ2J0TbLpd2qeg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8rWy6zfcAAAA:8 a=EUspDBNiAAAA:8 a=M5GUcnROAAAA:8
 a=pGLkceISAAAA:8 a=1aGH6oIAq40W3ycRDJwA:9 a=CjuIK1q_8ugA:10
 a=jWP1SRVnDo3hfmg4XSAA:9 a=R03saLzcPolIx2Gw:21 a=frz4AuCg-hUA:10
 a=_W_S_7VecoQA:10 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: edOFEvR8S_0oCNBi8AbruH3sGzIV2tjt
X-Proofpoint-GUID: edOFEvR8S_0oCNBi8AbruH3sGzIV2tjt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_05,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310153
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

--_000_SJ2PR02MB97950C22EE0516E4903D5CF389F8ASJ2PR02MB9795namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Hey Patrick

I followed https://core.dpdk.org/testing/#requesting-a-patch-retest to requ=
est a rebase and recheck since the failures don't seem related to my change=
s. It doesn't look like the retests were picked up. Did I miss something?

Thanks
Sameer Vaze
________________________________
From: Sameer Vaze <svaze@qti.qualcomm.com>
Sent: Tuesday, October 28, 2025 11:19 AM
To: Sunila Sahu <ssahu@marvell.com>; Fan Zhang <fanzhang.oss@gmail.com>; As=
hish Gupta <ashishg@marvell.com>
Cc: dev@dpdk.org <dev@dpdk.org>
Subject: Re: [PATCH] compressdev: fix coverity issue


WARNING: This email originated from outside of Qualcomm. Please be wary of =
any links or attachments, and do not enable macros.

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


--_000_SJ2PR02MB97950C22EE0516E4903D5CF389F8ASJ2PR02MB9795namp_
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
<br>
</div>
<div id=3D"Signature">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
Hey Patrick</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
I followed <a class=3D"OWAAutoLink" id=3D"OWA1ca9f512-d97b-9bdf-6aac-161c55=
ee1852" href=3D"https://core.dpdk.org/testing/#requesting-a-patch-retest">
https://core.dpdk.org/testing/#requesting-a-patch-retest</a>&nbsp;to reques=
t a rebase and recheck since the failures don't seem related to my changes.=
 It doesn't look like the retests were picked up. Did I miss something?</di=
v>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);">
Thanks<br>
Sameer Vaze</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Sameer Vaze &lt;svaze=
@qti.qualcomm.com&gt;<br>
<b>Sent:</b> Tuesday, October 28, 2025 11:19 AM<br>
<b>To:</b> Sunila Sahu &lt;ssahu@marvell.com&gt;; Fan Zhang &lt;fanzhang.os=
s@gmail.com&gt;; Ashish Gupta &lt;ashishg@marvell.com&gt;<br>
<b>Cc:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
<b>Subject:</b> Re: [PATCH] compressdev: fix coverity issue</font>
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
Recheck-request: rebase=3Dmain, iol-sample-apps-testing, iol-compile-amd64-=
testing</div>
<div id=3D"x_appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Sameer Vaze &lt;sva=
ze@qti.qualcomm.com&gt;<br>
<b>Sent:</b> Friday, October 24, 2025 12:47 PM<br>
<b>To:</b> Sunila Sahu &lt;ssahu@marvell.com&gt;; Fan Zhang &lt;fanzhang.os=
s@gmail.com&gt;; Ashish Gupta &lt;ashishg@marvell.com&gt;<br>
<b>Cc:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;; Sameer Vaze &lt;svaze@qti.qua=
lcomm.com&gt;<br>
<b>Subject:</b> [PATCH] compressdev: fix coverity issue</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">Adds missing free before end of function<br>
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
</div>
</div>
</body>
</html>

--_000_SJ2PR02MB97950C22EE0516E4903D5CF389F8ASJ2PR02MB9795namp_--
