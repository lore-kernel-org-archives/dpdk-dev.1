Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13F0C9830E
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 11:43:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E23E0400EF;
	Thu, 24 Sep 2026 13:43:19 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id D4B47400D7
 for <dev@dpdk.org>; Thu, 24 Sep 2026 13:43:17 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68O5e8h53983756; Thu, 24 Sep 2026 04:43:17 -0700
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020127.outbound.protection.outlook.com [52.101.85.127])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gvm3kkuxe-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 04:43:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kCLY/8EUS4NME82yGWFl31sFc3LoWB62v7s6RgQTAZmz92PHfr+xD5Luwy59c96DZuvAnjBUFwr9MojvUd44Oss5uyAYkVeUKiz8p8rzrlKK2+FEUB6ASHb8bRrTahWkki/dlEtuiBtBCgq/lclrIZWwmLNdKJwdZ8Yw/iE9/WdWeI7WHzISMvMWJK7bPs64IsClKXrVNrT9dRIM74k9nvUWcQQnXAe/sLKxd0Y0y6TtOBjtabQm3WbttbhW4T1oSIg/tAzy+we50v429xqqQTH/nURueg7ByzsX+sEADjOy31kOMoSIoPlw/qd5GPv3OImFT2s+KrL9L06pK31zNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5ToY8ZSxlHkxcNYw89SRySzu50Z3kWjhHu4uKEVTEs=;
 b=cPkrT1a4lVCihSH4E0xbIDwywF9MrT28DvimsBlcCUO9wOyMdBiW8khjl9Rq3z4lu2mGk1eJmQiaD9nmEactmbprayfm5x6ZrFzyWf000C0mbpMlLZ3sGbfmJAiTOM+1cbs/KnvF//2EWke2imRd34KqT6j1h8o6Y5fbhQTWH4siWC0UlAAulcMI9EKsU3j+EvsfR8FJ2odOP4LnoEP27ZNAYNWMEBg8rOrIXahFii1bwhyQ15YzzXFEELEYqlJ8WkLXvCrBIO7P+GQxEkyMFVPEoA7Ah4W2mId4JfMBC0ls61laF6FkqBEcjooZ/0VXsetysn6mfNZqZhOcavVSmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5ToY8ZSxlHkxcNYw89SRySzu50Z3kWjhHu4uKEVTEs=;
 b=PcdtmKKkAXTcyZyyKGe9TtSpOIPVLcFHrsmRTcrkPXxSkvkm8Lc+aBDqkaGHUWgqpH9/f2BI05nfv+2YPWosfgFT0aBUReAnjWHKN3vin+klligwYjrDyxFKYxvE6raaEUoGf8m4tq+X1ONeG4lF1dDLyTtWZwWlxWGjAbLC88I=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 LV8PR18MB5584.namprd18.prod.outlook.com (2603:10b6:408:18e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 11:43:14 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%5]) with mapi id 15.21.0428.015; Thu, 24 Sep 2026
 11:43:14 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Pratik Senapati <psenapati@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>, "kai.ji@intel.com"
 <kai.ji@intel.com>
Subject: RE: [PATCH v1 4/4] app/crypto-perf: extend support for mldsa Sign
Thread-Topic: [PATCH v1 4/4] app/crypto-perf: extend support for mldsa Sign
Thread-Index: AQHdOSWh6r0DBT+4rEamf/NF0gOHpLbdwV7A
Date: Thu, 24 Sep 2026 11:43:14 +0000
Message-ID: <CO6PR18MB44842323DA97EB2DB900A0F1D8812@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260831084911.256486-1-psenapati@marvell.com>
 <20260831084911.256486-4-psenapati@marvell.com>
In-Reply-To: <20260831084911.256486-4-psenapati@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|LV8PR18MB5584:EE_
x-ms-office365-filtering-correlation-id: 52df5b22-c3a0-46c8-8337-08df1a3104c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: QQsuPGqhQ4Ix8/oGZYyGf0a5uideqsn1xAgACdh3KS8E4dy4yFK41S3M1MaqoiyhBWD3u3meDOdZodET0l5O7hOZrJIFzVgGBSkmN88N2KkQRg0FZ4sTJfj3rvL+EKSn2xlQ1r4ir1wW55CxTACCJXyjQjUTVEdZxNsHGfcd+1JOcJgCOl95Lc6DA8sbdnV7Gmcc4rXQ0c7wC8wFlAxxR8cy8oGFlt/5jXfJ3QbyOkU2w8/fWVj64RC0N+KPXu2JJjtY5DzPHOs72gL/SlhIOJymFqC7vwrymVOAPvpZh+0XAreCUGhyXhVwkavYOxCuVSRRMp524YO9UzUdanEcIYYcQIqod1MQJLAJt9gRGL7iBEQx+kYhLYudKX/ZGKjoAKPi47SkMV1mskZM4zLkI8VQ4v2erBgrcJRm7h4IDMvjLy2mO0ofiGaGeZUg7NoD3OhMexxKUOkA88y63iLBxZa9NADUyAjVVsikwE6Oo6Fza4WyBw3wGQkN/PW2btrwdNHQiPmH3JFOG/zgN+DGsKFVe9AFIOZQtxJ45VyZx+2dOcSdqPkb/j7bq68pDeAX8vNBX4lMLydzDxGMCUU90zJtCicrbzb1kZQsbHTQ8QhAwOLTAEXphSFFYoTdK8g895iu/dlm8ERpoR4ENHeaIAAsiz0nbzEIE5nOyttS7DOJOynsunlmhNLlCCqkgTosodJufa4rdnkz5n4j6rlBKWxl9p/BfGQLFjM/1pjLlXM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vxB7sPcGm4N8hZjitRV9iEyHY1Y4nJLubuR5Du0q4DQN87viM4ZeB/mNi+dL?=
 =?us-ascii?Q?ZzlTMHkA9IVAPlX7csYJaqT7cIh6e7yWxvDUPPLytprrlN/gxm348R+TUHku?=
 =?us-ascii?Q?j6Wh2F5CRArNJWCK3KF7+AwqbLmTySx4H6dvXbRNiZdeh40YHHu74K0jlPU7?=
 =?us-ascii?Q?UJhVi6OLExq0z52OF/HSljFISkM+Jtvkf1gfW1l5YJw/lp2ULMCsq6XrydWk?=
 =?us-ascii?Q?rlyF3p2WMLHnQPBY+thdySskN3tIJ9xS4MJMUfvadtyb33mmk0MBeGWETBTB?=
 =?us-ascii?Q?E4JUIODJDJRPneGQBnCu9CdBLZYV3wRHKrVrLFm/isg0TQvStAR0utemB31X?=
 =?us-ascii?Q?0LpAYNzV8HsxhQ4aF1HOrEPkAs8S1TTKa3kv1uTJKrJBhwAsCgSEjiRvFpym?=
 =?us-ascii?Q?WqY1knQGIuNPYKozB/7O6owdjryCI1kA+WU/f5bjOE0B4aJn7wgHpHDIHxwG?=
 =?us-ascii?Q?uEjIUigMGbLqYJIIGW0Inl/mhGQEb6nZ9Tz+g35LSNWPoa0HOW9wM2DLx5mU?=
 =?us-ascii?Q?++I/p/SFam01k/RlRvu1v7Ca081wyA/sE3WRHzaBzXumEU8VOPvyuWB+SwOB?=
 =?us-ascii?Q?PuQnrLYTxE1/16WOGoIgZHWumEgvYlCtrlcZBS1+jFZyMFkCMrPlafSdC8T/?=
 =?us-ascii?Q?p3cYAJlQX5HS2XeAfQATPZsJukzb4GK85CtAIlgK1iezAOXX8w05hPi8ubmw?=
 =?us-ascii?Q?iBnYwRm+YvmmTqVTYcN/oYrbcAz2cRM8OiQv17jBnVmCG/aHE7kRgOKSI3Jd?=
 =?us-ascii?Q?QX/bjOsPp+JVWHoOy9F4gTQ0bYPinEQuyjyGShXm+6UJ96H9KVR9ounT0AQt?=
 =?us-ascii?Q?KYNEq/on1WzVPT3mG/yfMyn/jksXoy8+ef2hHtMOKCdohXr4H+60ySFgx3P0?=
 =?us-ascii?Q?6mpC7dxwEe0PDzk6btRf4We81WrjSrUIJX0MHPeEvbleim47TU2qtNG7Eexp?=
 =?us-ascii?Q?l20SYrDlYw0cNQyeamVE9Da5sRCdEVhoP4/sUrZ9l3q99I+XflWHEsrXaO6q?=
 =?us-ascii?Q?CTz0icPe7nbf2EXnJ+QV19/Py9frdbtUy6HUsxsiOXyO0/w4z0z5S0I0twOw?=
 =?us-ascii?Q?Vp7WcsAkvgzXbyPOpOOFZs2iSpfIu5wpg2EhWKXslqGCKuR401rdpYLk9cgH?=
 =?us-ascii?Q?jXfZ7kC5Xml7DHpjaELLcO+wgb/rWwjfA43qtiGAsPjDuPYZS2ik2W+hoxEm?=
 =?us-ascii?Q?nn+Wif6rNJWZjQaLPaftAB7wXRHybZQ+vau1BOK/h3dX08cOtjAPLYyqkzyE?=
 =?us-ascii?Q?rz9Z9CPYSeK46J3ddMdRmkG1ThulLvMwqLGthm68sumF0k4qmhkyl2+g0CX9?=
 =?us-ascii?Q?CvCKd/HZLy6fgj0wBjN1fDHK7kVJe3hnldahSyT5ZqCYqZ9Ikp0HT4lmzFL2?=
 =?us-ascii?Q?LAUsV7PjxiG9B9Du45xgPeipET8Lw1d0Y+7909dyzhSRYrYHfFpcA+ZFfmFP?=
 =?us-ascii?Q?nAP921URdK98OQHQ5494ynaSkazdyuj50yTwPsghcXPHgUd4GwV+UdivFTll?=
 =?us-ascii?Q?Px0Mb6PRH5FrdylH6WPNxsE7wtrxwoNbKacC33fg273VPDWnmU5rsmM/VAtv?=
 =?us-ascii?Q?+74e+qXOTlIbrUhCeDN9hCYmnbgxKT6Rm79jtsJbk6joIojCAoFkpmgim1qU?=
 =?us-ascii?Q?8Pa77UjjfW0LVV2yWierU1mAhlghJo+q/R0OUOodCxkLmAoqHfGtbgAk+diZ?=
 =?us-ascii?Q?cC7y9Mw1B7Fo1HyDOej7zhRmw1KaBhLW+AtqGqSEJCzAvcce?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ixH92RjvA4mKxYblLSnko1ie0LkdT1W+fqWFeSWvllFzGCYIoh2a47sY6txPrAP8GAMoNwSzSyWqULaz+jh17BEEOSW4AMLzCciteYAhkOqy2enAcdFP9gvyRu0q0KciL4GaDS2LkW5HLXfu7WVUHAv/Nxz/cvAt2na5RL+SV17m5q3W8AX+PPekAfkForb2Gr9wKAPpL59VKm04u4/ALlk4EWE6iIscRKbAoMguv5fcvdbesMwmvxF/j1Mv2IyOU2ZwZhb/RNG2HHaBRUAazHUdl3t++eS3kSum/DBq6asM83I7YACkFLzyAUijXiGbBvkz5cgWIW4lujWyRnAsEA==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52df5b22-c3a0-46c8-8337-08df1a3104c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2026 11:43:14.5252 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ExUdrZOxAhfisuCeChAOL/IX03GLIqzkurK1Vgq/ZV7c5eAiAM4btVYJE3sSmxnSf1OHOlqBmByW2r9I9NA3OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB5584
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA0OCBTYWx0ZWRfXx2iZAaCLYIFK
 epAMMRFEU62vUFHgwilFpwZgTlW8Ge9IaUV6P/pKgcBkN20Z1uho44MF1pb2rpZqLtAahnXmpQi
 9kZv4VigbAwTrfLp6EVrDAN0TU1v5+VAG/l6gSGpFaib3taaDq7PjUkuf49bg1pE7Qdbcqz1r7o
 VgKYDOoVlaUPtVnWQlz4Xjuz80V21RtxO5BTSgCnqJQw5oMGRq2ZU9QXAQ7YDNGP1Mgb/evzYEJ
 QnMJMhs2N5M2V2p09qKXSQjGxzM87k7BumBCtLOzp2DT9HEAdPmVV0PKqLNrwiqEjqxM0HX3ZqM
 z2y/zorxK5aKz4MrL7IMmFCIwpLFsGnaptBzsWEAP8rVM4aBr0tn9eKN+abHIlxrYppVIlNGNLN
 MLbMc4/tuHxEwKQ6X0vGEMwFguD6hAuChxwEC2e23ILiTk0aL1z8H+UsqcLeRPPW5uVO8Db3IcN
 wPs9Ug0iHHT2YTKhoTA==
X-Proofpoint-ORIG-GUID: NM05XoKAYBvhpfLuzEH0LxOy95x_90WU
X-Proofpoint-GUID: NM05XoKAYBvhpfLuzEH0LxOy95x_90WU
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA0OCBTYWx0ZWRfXxj+g8JZfOkpF
 +8Hs7KKrrorMu0WsEVkZbVG2elfx6N+Hvc8Niyvdo2vjGifd2ATif6rUxh1qe5PeDQOllsHAffR
 9Jk6rS+InUWzjwXuV8mTL8j2as/6m/k=
X-Authority-Analysis: v=2.4 cv=LtQHWXdc c=1 sm=1 tr=0 ts=6ab50cd4 cx=c_pps
 a=PGzkYtW+Y2OQBedXY5L5Qw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8
 a=8rWy6zfcAAAA:8 a=QyXUC8HyAAAA:8 a=XKyuU7dwuj09yXYwDegA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
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



> -----Original Message-----
> From: Pratik Senapati <psenapati@marvell.com>
> Sent: Monday, August 31, 2026 2:19 PM
> To: dev@dpdk.org
> Cc: Akhil Goyal <gakhil@marvell.com>; Gowrishankar Muthukrishnan
> <gmuthukrishn@marvell.com>; kai.ji@intel.com
> Subject: [PATCH v1 4/4] app/crypto-perf: extend support for mldsa Sign
>=20
> Extend Support of Sign-Iteration
> (1, 5 and 10 iterations) for ML-DSA to include
> ML-DSA65 and ML-DSA87 in test-crypto-perf.
>=20
> Signed-off-by: Pratik Senapati <psenapati@marvell.com>
Please rebase.
