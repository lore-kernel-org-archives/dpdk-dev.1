Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D59C982CD
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 15:38:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 839F34028B;
	Wed, 16 Sep 2026 17:38:02 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 8C3DC40264
 for <dev@dpdk.org>; Wed, 16 Sep 2026 17:38:01 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GFCLBk505931; Wed, 16 Sep 2026 08:38:00 -0700
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021095.outbound.protection.outlook.com [52.101.62.95])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gq9c8qc4s-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 08:38:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FkPj2JXlckeRsg3BYkfk79NnNfQh+0htFjt5EEpxMAyDLIp7afqKr43UeTtFXZKeGkU5mbRS6yXSIad1Bxj2z+y2IihAX5c9gMWDYgDmfKxEHJfWTsbtxBjIoBYkAqlUHZJlpZQuEK0iwhDoNxwsgejBdlyxWMpQ5WjzjYzr5yLGU7F1sXqD3Sm77rF5kerOsVewGeGAmbPMtSPmk/H/TTkeBJmfebmimSg3jUosTBAbuiGZf3pt/fY+NeWQNbp7Fb6RAIVbZs8FM+SW3uRqRaZVJSk1ph7fElNgIcA7oiQCOr7KSBtL2wldzHQpJukvilgRmrr78yivdkUK7bQpuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y90+H32AbAMrPjr5vh6dxATqOw9xGfMVgKu7HcbE2LA=;
 b=bsNdaran18TgXeTO1ntNxhKPHQf42VGlQo6QLsZs5sMDZ1txdwFt/ui0/rutUpKESjCXPVsaEZ2P5uIBV9++Cw4iK0yocEWH1DDxxiByQYImtksvbQcj2fDMPBzn2jVy0GlXLu2u4+zyJT55MUUw/1z+1z9+ZrLssFVB+YRJUYtpXFbzk+WJ9cToJdxe4DDBXHtuKIj66xst2neH7qHSse9nxsEG5FP2E2Dmr39PBvXITGV8hj+TBXEZ/YF9CNsTOsG8F+R0srZH2nMWWf3Ly1YYZGLYW481hBlVsLl134izhapailYebJlaFv/dvC/7OI10H4pOAyEEDI2sAVreFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y90+H32AbAMrPjr5vh6dxATqOw9xGfMVgKu7HcbE2LA=;
 b=RI+7eEIkgsSmz+q2x5m23PBerW3xUWu2QXRtRPEsWJNv1ljuq7QJSXMnMX5XHSRCDn9XyUPZTjgqzdkvWPLQ0/uaZiOQz0jTC/GCv36yufXNayX0eyQ3H0bjJ4L1y0SpN4qR4tjioLVt0cW4GkUCq/8pDrsGJY3lDkxfccjVVFs=
Received: from CO1PR18MB4796.namprd18.prod.outlook.com (2603:10b6:303:ef::23)
 by SN7PR18MB3902.namprd18.prod.outlook.com (2603:10b6:806:10b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 15:37:48 +0000
Received: from CO1PR18MB4796.namprd18.prod.outlook.com
 ([fe80::d463:1ace:3518:f3b7]) by CO1PR18MB4796.namprd18.prod.outlook.com
 ([fe80::d463:1ace:3518:f3b7%5]) with mapi id 15.21.0382.012; Wed, 16 Sep 2026
 15:37:48 +0000
From: Ashwin Sekhar <asekhar@marvell.com>
To: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Nithin Kumar Dabilpuram
 <ndabilpuram@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>
Subject: RE: [EXTERNAL] [PATCH v2] common/cnxk: fix NPA pool RANGE interrupt
 handling
Thread-Topic: [EXTERNAL] [PATCH v2] common/cnxk: fix NPA pool RANGE interrupt
 handling
Thread-Index: AQHdQ04sGXQ4kNNvFky3nezGJBPtwbbPMj/ggADS4oCAAJvdYIAAFOOAgACf+gCAAABucA==
Date: Wed, 16 Sep 2026 15:37:48 +0000
Message-ID: <CO1PR18MB47963490DE511C867AC2BB80BFB92@CO1PR18MB4796.namprd18.prod.outlook.com>
References: <20260913040800.60274-1-amiyaranjan.mohakud@gmail.com>
 <20260913070428.66628-1-amiyaranjan.mohakud@gmail.com>
 <CO1PR18MB4796E0F85799C486CA837DEFBFBA2@CO1PR18MB4796.namprd18.prod.outlook.com>
 <CAL+mCpO43LNUa-xzH7_AkSjcyo1Ws2-SdVUhvn6ySQY2_2OhgQ@mail.gmail.com>
 <CO1PR18MB4796A90FEE9E4C8246846F11BFB92@CO1PR18MB4796.namprd18.prod.outlook.com>
 <CAL+mCpP35KM98KyydV4VBrCroR41-v1dt61E_dxMfx-3W2AQbA@mail.gmail.com>
 <CAL+mCpPOPtvn+Si6PvnvpK5e3rQHp81SV-+WDaiiJADt99V--A@mail.gmail.com>
In-Reply-To: <CAL+mCpPOPtvn+Si6PvnvpK5e3rQHp81SV-+WDaiiJADt99V--A@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4796:EE_|SN7PR18MB3902:EE_
x-ms-office365-filtering-correlation-id: e6e9b1e5-eeda-44a3-020a-08df14087633
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|38070700021|4143699003|56012099006|10067099003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: yJDdJxdAS06p/oUQ7/FY3h17cRVu57St3STtbsJViytP8rVXAgcCNyWc5c1mfB4OR8VZTIgqGDbMqdAZKvzBxp3TgBDiG91zBgFndYnYZOCU+A/fuJoqlgxrYuH8z4Xc4cFZo8GglWtqbisTUabASuPEvGLhybKx03/OlH5N/syoT8I92dxEGHUXNCJ1gRiu2SInPeVw1y8RtvyhXSt7uPOci1wJ+4aMH8T9ewsBoyAMAF9+lY3vFn27ouT6quloNiKPx0UWkCaOlzabPYl7fcm4iLRPI/0QOJfgLwKO9QgdU+e0ur8cNd/nOaKSkzdiwoq1vebQEpgtAgkegxcKkLj/diklJEDCZfrZdf4NI73SCeFp8yISqU09OhsNBg9ZEpO06O6Oy3KoQsIXideA6WQvQX2FL0Ch/ez+0ickOco4grggdfoPdG36fM8KJGtp6U9LvwxecNziVonI9HO9Ao+inJV173KRR4O8YUjdSNofr3yofwSvjYWdTxbkeQjn+/YeovZ1ZrszrOFnNFU8aVyNUdKrGGyoA96fcUc8MdUFSdoX70ptDn/3KNiUoI+cUbTkZ9gO4t/JlnecNfUKi79wllfBNTkY1gPOheKf1nffeEIKerhD4h8B/uaCAZmzZLJKbwokhd3nCKZ53vOO7OatSTwf5oAHF/0GYUtXJu5/eAG8FjGubB2+bl34dv398oiCus6ukq6YJVb7KoMJkZ+T082H24i5ySYoAghdZpM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR18MB4796.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(38070700021)(4143699003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0V4SmFRbkJDYTJyNzZUK0xTWVBwS1BmaEM4TUppYkFwR2EreTM4WlpNbFMv?=
 =?utf-8?B?b0ZhTVFMWGF4ZEE0cG95cGQ0M1J3Sks1dTVyUWQwRldJT1lrb3Q1Rk5tTk9u?=
 =?utf-8?B?ckRkN21aWVZzUjk5YzFKdnN2eUtzM0tDcTVhKzg4YmExYWFrQ1V4VW81OG9x?=
 =?utf-8?B?djBZbTBQUzZsWDRQRElTaU40K3lPZ2Zlb1VOakJYR0I5TW5NdVRsdDR1eTRZ?=
 =?utf-8?B?OCtsSUtkaUJEVFVxcS9aSER6SnlrVEhIOUkwRlBCTFVGNHliUUwrcFNpaHgy?=
 =?utf-8?B?c3BMeFhYUWtLRUdvK2E3NHBCYW5haXI4bStQZ0dyeDVLNDJRT1c2cUUyYkxN?=
 =?utf-8?B?Y0pJTUNZY0h2clhiVytXYWFIc2FVNVRsZ1JJTjl2WTFNb3g0eVU4U0dkV0Yr?=
 =?utf-8?B?SWpEZzRDeStLM1JTcGZMVWo5YzZqNktHbUlnUjVoNmk5SWxmdjcrWEY5M0Q5?=
 =?utf-8?B?ZzhBVm1kakZpQ1U1QkRDSEc1Qk01WkhkY2MxRlZNSVVUMlM2dEhleW5HWmc5?=
 =?utf-8?B?UVRHVW9qNGpkMWVnbEU4dDc5eFNSckVDbUl4Y3dzN215TVpwbDk5Q2xxRVFi?=
 =?utf-8?B?T2dFeUNiNkFBK2czaFpzb3VML1Ezc1NNUFJLbmx4cXNqMHBUTEFUb1hQTE9K?=
 =?utf-8?B?VmNkbHRDNG8xK0syWmRvUGFzL1NYUGN1YUVBZWtueklTc1lBTkk3RVp5cmdE?=
 =?utf-8?B?cFdTdGx5ZFV4THFtK0NZTWdjaCt5ZzRwWDBwVTkxdXRpLzdwZ2R0YXFVMEIx?=
 =?utf-8?B?Wm5uTXV3ODdDOE5JSHZTSE5HZnNCbjdDbWl5bVZTRFRlbFkzSWdyQ2hnM2x1?=
 =?utf-8?B?L0dKaWVUSHhWM3lUYlk5MlNKMU9zRWJIdjRva3RqSitZYVowbHYyK1Rjalhq?=
 =?utf-8?B?OEhaUmhUeDFvS2FpdWZiSjhjL0MreWVqZlZBTDNiNXZyR2NybnZRYTAvZWZ4?=
 =?utf-8?B?N2JlNGVOL3ZlRlhLQnZUcThPaS90TTd3M0tWNVpFR1FmbDBDbnp4T25sbGVS?=
 =?utf-8?B?YUQ5L1R6YXhoUVZkMVRKdHM3TlpHTHVsMUtGNTZBZlRNVSt4cHZ1emdiZVp3?=
 =?utf-8?B?SlFYMlBVUGxidlBYcGVLdXp1Z3l3Nm9VN3ora1UveGROb0YwMkJMT05HQzMr?=
 =?utf-8?B?Q1d6bjE3cFVMbExSOWlkVXdXVDVZdXM5elhiVHpKb0RPT010bGNwbE5JRjVo?=
 =?utf-8?B?aGJEMzNpeXg4OFpVU3kwbEJ1dnFOeUhjNGZDRjl5TW50Rkw4Vk50bzAwendU?=
 =?utf-8?B?R1JhTUhjUi91aDcraS9tTHE3ZHFOc01vTFJNc2ZMekJZYm03b3V4OGwxY2pZ?=
 =?utf-8?B?WCt1RnB6aEE4KzkrajRodVNFcis1R0c3amxjd0JrZzVMN0ZaQ1pXcG5vWlJ5?=
 =?utf-8?B?YVZaT0tTcU1DYWhUbHc1cGtJS1FOTndGVmZkOFF4VS8zTDNQekFxWndZek14?=
 =?utf-8?B?NDJnOGw0Q2VSWEpkWkpQbXcxQWtPZXMxWlpFL1AyTTJBdy9CSnQwREc5NmRU?=
 =?utf-8?B?R1BmN2dvbTh5NlExYlVtZEpaWC81V0ZFZm1pQnh1dDJYakJ5MURFUFFQeGZJ?=
 =?utf-8?B?WHpkVE9nWDlVRzVyTE9aemJSWGs5cENXVVVQVmFoeFFzRG1lalNOYUZFQTBt?=
 =?utf-8?B?MkN4azV1cGtpZWNsVG5weU1zK3FoYTV1NExjL0kwVXJFS1NnR25oTUlCOXdD?=
 =?utf-8?B?M0o2ZWdtUXVrOTZRdUlYbU5wTDdKRjNYbE1jdThGdmN3TkVuYXZZcDRDSXA5?=
 =?utf-8?B?WWozY1RrNXJFY21CYjZLOC9kU05OTGpGMEV6dlZKelJyM2VmUm1LTjFkTGdZ?=
 =?utf-8?B?UnJML0ZydnB1WUhEbGZKWFJlRGNhZC96enM5L00vTE4va09zakczeGYrZnFM?=
 =?utf-8?B?LzZ4NGZLVzBDOXV5SkRvOWtuYTR4TW9SUDFSVGJaUkprTG9TZE52K2gzOEJw?=
 =?utf-8?B?TnJkRTkrb3NaUGRlMldiWUZmS0htNitwS0VxdWR2R3B4cFR1Zis0aWsvSTFy?=
 =?utf-8?B?ek0xM0FPcDZQN0I0SW4zYS8yUmV4WVhiRjBsRmFPa0N6RjRPVUFXdFg0QWV0?=
 =?utf-8?B?Z1ZuTEUrUGtZODZpUXJ3d3U3ZGlXb2d1dUUxRW5MMnBnelFSdTYwbTZXOGx1?=
 =?utf-8?B?QlV2S1ZwY3R6cGF0OElJOXhSQkVFUTI2ZkNGc1pSM3k2TjlxT0liZzRYcUha?=
 =?utf-8?B?ZkpoRitkVlh4YWJtOUhoTHFHQWJaeXRQeGxscFVMUGxJVTZpYll0UmRiN3dG?=
 =?utf-8?B?ZDNrNi8rL1ZpZHFKZVRBZnA5M0QyUUdnQ2xtb1JDL0JJWWdqamZBeFlzV2Rh?=
 =?utf-8?Q?0HE1zxnwb5xK8wr5xq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tsPu5rLuSLsf4xQSASBWD2AYyxsSYzXJ+ChwXtIdQD2uTGXRmWVP9Sm6b3Lgw37qH9YnegOPoGAk9bWDc6dxnM8ZHJQrYMEx3YKHg5DbWtzIf648nY3TINZLFnur/U50Wgft3zX+eDKV3cddvy5MS9Sq3GuquMhLzSLxKuPwJFtIBtx0lul+xykKEGTkhGEIdXQB9OFJfaUSDJvMdZI0mA1akAnp0tUjZw9QVnpOFiAGwzROjssl3Dc+K5+6tvbJ76NQ81UsNnCOt57FvgykbNg6pL4siXHLlXMnv++E9Nc4Hvp2EnT/JUuiLjZGvrB4MgcdHtG1JFUjoZlvotSG8A==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4796.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e9b1e5-eeda-44a3-020a-08df14087633
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 15:37:48.4875 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I9KmNVMqDtIY5hB7RrWeoSSd7OQtXzukhYpwe6sjPwTdQ4wpbq4LQkMGNHlwqU4P4Edw+qoNyq7dQHH2+JOuMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB3902
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDIxMiBTYWx0ZWRfXyiS7BiXUpY0h
 ZFrCSQ+kvuIY3EhBvDEsfpc32fuzjbXM0YkQxfUyzll4cYhCy+raHhwMYuWrnljRd1g1ttYON80
 NO+Ts5kkyMEdVKZG/LxNYCfhktp/X7YI31ZqFt4LhUULnIkU7qgPq0Qn/6JSDPrd3tvBsw5U4a2
 mkyDbeZmb9Pj/AwnYmOMlncJ3HQ/5NYeb20bNAQBM9HriTIyQvVaFkeYwMOes/cE6eAsTu2ZSKL
 CCufEhk4TsonqkuDrd7+JWRJnKmfceZhMskmbbl9xY37h0iAt7u9Qqt4rxoaoeQeyQqba/fbtli
 PhrBTgkRFWdW11XfaiL7oD5M6ZGWMTf0Z0qiXFnw6mWSLpSmm+fGK8m6tFHGfVfzpdf+nuiT1VD
 vKlNw8kaAyWxAeRuuFftq1cpt6oz1/RKPNG+RG5qAgHBRXuAEMblZXGsrSacgvFaN1adlpCiPXL
 m0p5wbf2TTKLAsGOPyQ==
X-Authority-Analysis: v=2.4 cv=R/2WitRX c=1 sm=1 tr=0 ts=6aaab7d8 cx=c_pps
 a=XQ5R8ZYH27Ke1DXIRfoPQQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=_R254SzI1gHuCo3tU3YA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: I1kV9wfCDrbMmJH91Owvwb9qCPLkXzou
X-Proofpoint-ORIG-GUID: I1kV9wfCDrbMmJH91Owvwb9qCPLkXzou
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDIxMiBTYWx0ZWRfX6JEtFagufl/f
 Fr70mLntAKnHsaM+5A4OCm0w/0rgiQXM4mf8dWt9xRPmnxO56k9yzY1OQEyNlGN504fXD2Zab88
 PhjloiK1sWArGU/PnZGwr662dgIEZq8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_02,2026-09-16_02,2025-10-01_01
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

SGkgQW1peWEsDQoNCk5EQyBpcyBhIGNhY2hlIHRoYXQgTlBBIHVzZXMgdG8gY2FjaGUgZnJlcXVl
bnRseSBhY2Nlc3NlZCBjb250ZXh0cyBhbmQgc3RhY2sgcGFnZXMuIEFsbCBhY2Nlc3NlcyB0byBj
b250ZXh0cy9zdGFjayBwYWdlcyBnbyB2aWEgdGhpcyBjYWNoZSBvbmx5LiBUaGVyZSBpcyBOTyBk
aXJlY3QgYWNjZXNzIHRvIGJhY2tpbmcgbWVtb3J5IGluIE5QQSBvcGVyYXRpb25zLg0KDQpPbiBB
USBJbml0LCB0aGUgY29udGV4dCBpcyBmaXJzdCBhbGxvY2F0ZWQgaW4gdGhlIGNhY2hlLiBXaGVu
ZXZlciBOUEEgbXVzdCBhY2Nlc3MgdGhpcyBjb250ZXh0IChmb3Igc3Vic2VxdWVudCBhbGxvYy9m
cmVlcyBvciBBUSByZWFkcy93cml0ZXMpLCBpdCB3aWxsIHJlYWQvd3JpdGUgZGlyZWN0bHkgZnJv
bSB0aGUgY2FjaGUuIFRoZSBjb250ZXh0L3N0YWNrIHBhZ2VzIG5ldmVyIGdldHMgZXZpY3RlZCBv
dXQgb2YgdGhlIGNhY2hlICh1bmxlc3MgdGhlcmUgYXJlIG1vcmUgY29udGV4dHMvc3RhY2sgcGFn
ZXMgYWN0aXZlIGF0IHRoZSBzYW1lIHRpbWUgdGhhbiB0aGUgTkRDIGNhbiBob2xkKS4NCg0KRG9p
bmcgYW4gTkRDIHN5bmMgd2lsbCB3cml0ZSBiYWNrIHRoZSBkaXJ0eSBlbnRyaWVzIGluIHRoZSBj
YWNoZSB0byB0aGUgYmFja2luZyBtZW1vcnkuIFRoaXMgZG9lcyBub3QgYWZmZWN0IHRoZSBub3Jt
YWwgb3BlcmF0aW9uIG9mIE5QQSBpbiBhbnl3YXkuIEV2ZW4gYWZ0ZXIgeW91IGRvIGEgc3luYywg
dGhlIGVudHJpZXMgcmVtYWluIGluIHRoZSBjYWNoZSBhbmQgZnVydGhlciBOUEEgb3BlcmF0aW9u
cyBzdGlsbCByZWFkL3dyaXRlIGZyb20gdGhlIGNhY2hlLiBUaGUgYmFja2luZyBtZW1vcnkgaXMg
TkVWRVIgYWNjZXNzZWQgZGlyZWN0bHkuDQoNCldoeSB3ZSBuZWVkIGl0IGF0IHRlYXJkb3duIGlz
IHRvIGF2b2lkIGNvcnJ1cHRpb24uIFdlIGZyZWUgc3RhY2sgcGFnZXMgd2hlbiB3ZSBkZXN0cm95
IHRoZSBwb29sLiBJZiB0aGVyZSBhcmUgc3RhbGUgZW50cmllcyBmb3IgdGhlc2Ugc3RhY2sgcGFn
ZXMgcmVtYWluaW5nIGluIHRoZSBjYWNoZSwgdGhlbiBhdCBhIGxhdGVyIHBvaW50IG9mIHRpbWUs
IHRoZXNlIGVudHJpZXMgY2FuIGJlY29tZSBjYW5kaWRhdGVzIGZvciBldmljdGlvbiBhbmQgY2Fu
IGNhdXNlIHdyaXRlcyB0byBtZW1vcnkgd2hpY2ggd2FzIGFscmVhZHkgZnJlZWQgY2F1c2luZyBj
b3JydXB0aW9uL3RyYW5zbGF0aW9uIGZhdWx0cyBldGMuDQoNCj4+IGhvdyBpdCdzIGEgc2lkZSBl
ZmZlY3Qgb2YgSU9WQSBhcyBQQQ0KSU9WQSBhcyBQQSBpcyBOT1QgYSBzdXBwb3J0ZWQgbW9kZS4g
V2UgaGF2ZSBub3Qgc3R1ZGllZCB3aGF0IGtpbmQgb2YgZXJyb3JzIHdpbGwgcG9wIHVwIGluIHRo
aXMgbW9kZS4gRXhwbGFpbmluZyB0aGUgc2lkZSBlZmZlY3RzIGluIHRoaXMgbW9kZSB3aWxsIHJl
cXVpcmUgZGVlcGVyIHN0dWR5IHdoaWNoIHdlIGRvbid0IHRoaW5rIGlzIG5lY2Vzc2FyeSBmb3Ig
YW4gdW5zdXBwb3J0ZWQgbW9kZS4gDQoNClRoYW5rcw0KQXNod2luICANCg0K
