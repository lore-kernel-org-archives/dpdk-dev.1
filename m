Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9597606A31B
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 06:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=selector1 header.b=Ou7QslcB
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 075624025A;
	Mon, 26 Oct 2026 07:36:17 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTPS id 2772240150;
 Mon, 26 Oct 2026 07:36:14 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q2OFLB2624285; Sun, 25 Oct 2026 23:36:13 -0700
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021124.outbound.protection.outlook.com [52.101.57.124])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4hgt1mx1sk-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sun, 25 Oct 2026 23:36:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vWZfUd9xMMUcn1sN5JwXXtyMQNGnF03s6ZHOy4lVZ2me+F9h7hQpUbh6mKqNznoqpidlLVM4hVS9iRpy00gIKDxx/yfTT1cfZCmxKpr6aPv0+05AxmtMe01kPDylhhCSh7sgGCDtk9h+CJPH/3ZJe0m68kkU3B9+xlwaUNZhM8hCVq6x/gBb6/YH5D4oVVWVgIM+/JFXD6crJvkhThjCYn5jkMuJmxyMaOVl+N0rSSn0AxVjhuxRBIun+X5uL3Telzi2YkOBbq2C9UGO0TXY70cNKZcocB+JK734BpH8CRsq5L6KNEpIbZqvw6RvF4MP1jyR8Hvtb0wr444H70E5sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbwiCP9VHvqHfJ54mTFD6ayINbYELdZWtW9qdvv62Qc=;
 b=WN6hhUjPXIk9nDMqlqALRzsyOnsMWM4q7hyFO/lw92ezvLMlI5wU2E3QU15BJVMMOiRY6lrPXYeP5bd5zOodcWp7kgxvHkzdxGPg9CDdx1YBGd6scqDRjhyB2MlHLjB0oLCVosr8+Ewp3CCKzYklqazw34sl+Wa+CDskzl830MxWdSnuGhWEPDGSxiqrCfNrJsR+4Pp6s0xhRCl5lFe+92i4lJJ0FDXjE0Kqg88ewpuw9RKq/FOAxQcWxVph4KTBo2zooce7JzTLW3vj93oxfgJbScK1+X0+IsrlQ6B8LmpL/83W2YA5BjdwVc8aV7S9eWmNTjuWLTCVaUosu4BDwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbwiCP9VHvqHfJ54mTFD6ayINbYELdZWtW9qdvv62Qc=;
 b=Ou7QslcBQuOeNAnr4BAEzpWWPCJ7Cq2tqj73aHxENcgXP5CSpBKoIAmjJORQl8+Gk/SmUBtVBXJyDWLjrXGujpiRdRvrJo3mhfFciHoZCyh5QSfvb3RdUstQxNgbLvBNnFH33itUHW7H2FMZ/s164AAtuzUVfEdMpUqeM3mJvXY=
Received: from PH7PR18MB5201.namprd18.prod.outlook.com (2603:10b6:510:15b::12)
 by PH9PR18MB126387.namprd18.prod.outlook.com (2603:10b6:510:3ec::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 06:36:11 +0000
Received: from PH7PR18MB5201.namprd18.prod.outlook.com
 ([fe80::5ce9:8c67:1a61:c94f]) by PH7PR18MB5201.namprd18.prod.outlook.com
 ([fe80::5ce9:8c67:1a61:c94f%2]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 06:36:11 +0000
From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Devendra Singh Rawat
 <dsinghrawat@marvell.com>, Alok Prasad <palok@marvell.com>, Jerin Jacob
 <jerinj@marvell.com>
Subject: Re: [EXTERNAL] [PATCH] eventdev/vector: fix adapter slot search
Thread-Topic: [EXTERNAL] [PATCH] eventdev/vector: fix adapter slot search
Thread-Index: AQHdYwT3VPKvC75KokO0WpKPLLb0KrcPYbHE
Date: Mon, 26 Oct 2026 06:36:10 +0000
Message-ID: <PH7PR18MB5201577A8F05B2E3184D3ADBDE612@PH7PR18MB5201.namprd18.prod.outlook.com>
References: <20261023154117.253645-1-stephen@networkplumber.org>
In-Reply-To: <20261023154117.253645-1-stephen@networkplumber.org>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR18MB5201:EE_|PH9PR18MB126387:EE_
x-ms-office365-filtering-correlation-id: 40ebb52c-e222-4b93-93a8-08df332b6ca9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|261009223027099003|261021121427099003|261022075727099003|261022105027099003|261021123027099003|10067099003|56012099006|18002099003|22082099003|11063799006|38070700021;
x-microsoft-antispam-message-info: /lEUR3uy7S/d88gfqSY8dUNc4unbTomfkSB4K1p8HpBVJPVMd7PvNpdflcc9ga5tb1jDEhKyvoaXM3QFZIWYEryjNoQsk/huPXjlrJttRw0pO8HyNFWQOBVz0oScifeRz1X0Z+NxcUCJpWaJ3WWiIO73nRxoOfFFyAOiGyh5+7v1dvPorfFQgu0LSILI3joQc9z92NlkgvRuvk4Z4OmcVwK5ZKu/jzWSVIodwpy3ug2jtycwlYuXt+hV1sU5zOk7fiqYqUZ4X4p7g5SVNe1i58qKozEMmiI8PIo5fgqB/1Bu+g58pDsLfN3MrSY0RGVfHuObTeHtfalkqoaK/jpmavQdIW3kbufx2J5ej5uKTO+hx/sa1Gxw04oTL4133U2n/ZFDjOfdaIiQPuQTvvaoyGxru2HeSGV66tnBkJf1zI5eBpp97OJw8nR8UpkvF1nq8SdrDoHoqn7zG9FonhoMqGNG37GhcxEemcabhvDWmzRvuGeJ93qsTTka1GOaKVmMeT7jiYyFoeZ/n2kj/to1tdlfakN+dY2Lhmg+bnXwPwAHBvZMjmNerReoZGayZ4wvg4xVFQDnO9m0F7/BA1nO1EzomcXyhNJF8Qaxv257Sv6WbDTlOUq/zknIwRw9Rwi58Zyp2UWHRaOW54OwKymx7pmA6wBa5ajfjz3m/s6l0GFaqLV7Af7I1s8uSne8SYV9kpVUSy3AnHC2ZSrRzqGTZkx66cigtEsJZlNsoYfERMw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR18MB5201.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261009223027099003)(261021121427099003)(261022075727099003)(261022105027099003)(261021123027099003)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5K7gnXkuL2M9nuNYV3TFnRH/dxz6/7of9mdUXvSiLKZc+oZ2UrqiGdDtWi?=
 =?iso-8859-1?Q?nNDwjXA3iI1FM1DI49RdodLNS4MTDPkYFvrDRFDhX3Er6s3jW8dGpYNsOd?=
 =?iso-8859-1?Q?eW2FllSA7n3GmN5is5wpkJ/zsjrS1Z1eu2kMuwQk0W5BApQ91Hr4uOEqh2?=
 =?iso-8859-1?Q?595vKu+KyvJwVR+qcExHGv/iu/xyDvtTY7YWCq83Nn6RuRrygjVmmb2Axh?=
 =?iso-8859-1?Q?4w1R/v+FD3dOxiXJzPRLB+dF8mt/weUQ2/sM2yEz8pdfKz+gjSbV+D539B?=
 =?iso-8859-1?Q?waN4XQEgkBO00BEJX7crqWPrdeZvbCrYmH6c2R2UYOT6nXuGQSk/m2OXps?=
 =?iso-8859-1?Q?U18fw6A5NT2s34rLbqQ43aGi5FIVZwZMWlijGQ91d3INlE2eZNtyHmwajX?=
 =?iso-8859-1?Q?OhKdtBJj+vS8DGuNVllizVm0AWOq3zU/AEo4z+32thf9ONXWWqU5I3mntV?=
 =?iso-8859-1?Q?Sx/B/M7RKVwJRhaPgswomeuu3LsvXQsaAVO+ZTdMeoee6sdJHehAs2pwG5?=
 =?iso-8859-1?Q?hmdqJ1lum6u+oYcguSBcKwOJrknshZDsuRrh1LHZZaqExpkJj6d1+7tJmj?=
 =?iso-8859-1?Q?U3uBAamafOpKbmr8fiwCNU7R0pwQyFxtvu1pnggoj7klmf5xHzWDMOVnkv?=
 =?iso-8859-1?Q?3fua3q2njEv/kUAZCubIuKL6c2aA3R91j9gqDsEnQYKolY7mZXEWcY0xAx?=
 =?iso-8859-1?Q?mLpK762cN2sSQFb2E+g59PETNrKOXbmaHXjQfoE7wlUepeAPvthETKI1fn?=
 =?iso-8859-1?Q?yuU2VDpNXt9yeaeHIwueN/JTC1R31yMNsfKHDlBcR7tz1q5sboyPyoTwep?=
 =?iso-8859-1?Q?OSldyRZflS28MAE4VQQyT8NeB2wMMW1CpQiP7bDHVn8LXCzkL6ui+X/kj5?=
 =?iso-8859-1?Q?cHqdKTuVjUpoAVPRTacoC/MqXi2EfrPiGtyLYYY/rX+nLRpK1raGh+kPMi?=
 =?iso-8859-1?Q?PEx6QH9Qdt/ckEiEXrzeLZZRNj8X8WMuxwKqDWTNYxB2PPmd4PD+YfPVcE?=
 =?iso-8859-1?Q?fXs2ZW2s/z0OVEBecO6gPhnDQr+POrbxPSYZ0+oy+sDKOxU6XxdiAO7ed4?=
 =?iso-8859-1?Q?PVTPES0w3VL+4zdKnIPpSzIKqqAmJcxWzp6BjRnebhmvJIIrTMdX1bbj+y?=
 =?iso-8859-1?Q?NMtFA26zNp0SwjqUjSjnu+4ZXay0H+4Qgcj5adq9vKqpUpZEPcGr7euvQ/?=
 =?iso-8859-1?Q?vyn652U1B1REkFsF7KQEGJOsm+MEpUq0vmT/t1wsfC4WDf4R0FcVPdHOf+?=
 =?iso-8859-1?Q?VqlGYQRlhJsrcHOA/SopyXGn6N5Xoffu8dtHsRkt4FKTDJJNEh9n7YbwZJ?=
 =?iso-8859-1?Q?qquh0n+bSZzM5bbobtmVBWEyetx6+uMmUew14otqT6syZUFmDtM1oOl1qH?=
 =?iso-8859-1?Q?5QIZBW5vtj+OUGsG9yTdDyUGEcjh2LwROT90RFi0oLfnZocHYelu79Pg+4?=
 =?iso-8859-1?Q?DohI4ss/vwc9HXtTp6pVE+oVI1pRJyY0ZXwBqnKgoYEndt3Rxan0H2cPXh?=
 =?iso-8859-1?Q?vuvwHbp2jNURq6GfZN6Ys1m5dRuzrZIBFU2XRfZNTwn7hhWZW9g+vZtnnN?=
 =?iso-8859-1?Q?GvF5Z97PvYKIRwIQKxx7PlfWDVRXQNWVj4JBJjk4HKXWvBtT8rw8QeIWOk?=
 =?iso-8859-1?Q?+qQ+0FsiHalg4pwrJVs+iUvg+TqdognKJpeRq39tp4YFsQ/t7o5ZcK1VMp?=
 =?iso-8859-1?Q?aFFTBIgZ6AN9ppgruoMb4ksFVcsfR4jXDqa1dAd626C7Wy0oemDpR/EVCe?=
 =?iso-8859-1?Q?+rHKYUGIq9BwU8dFaf/kVHZjZb2+BPwM5KGzFEhLA/w7GO?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UWDCCBBVRheOsAMNKt+Pv3xS6+lMTNjIlWgtikt7eQ2dEGSsUWH+Na2JPCP7gThl9H3VMlJHLnEq7M/yd/1i9FDQFV4ssHTnhb3oqSFPu6LbPdKiRiChgrxJm971XsrgB2LmP/WDLunIcQcXz5yaQZahoFCcnO8yt4rjrvrOw8WeyWpg79SfSYa1JRStlH6jJNHtHcwvwH53m1eay1Ll/bX/ea/F+LAe/eMo5i8gssSx5p7iRs0aTkzW9FiU0JcQtkP+szEm+X0lgzi7ZtOnmwQ4MXpVX9cw4ABSt4j3LnNIeAzwy6J1R7hH/pBc65upCB1BTvZ+8Dwf+2E5MQ8Y5A==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR18MB5201.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ebb52c-e222-4b93-93a8-08df332b6ca9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2026 06:36:10.9311 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L7OZhnMaAvHX9VaIr9mrw88hpK0TzABcJZg1KV1zcNH1DoQ1dzEvRFpD0OJgE8YU6wEkPscmFZjFkpCFO2fJZFfI+fW85kk1vX1RRfLpulA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR18MB126387
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfX2y37jk6MsdrP
 T3CmAPvFQyiLbpbcpa6+ZetbUPmsb4a2/hD8r56vzneoPubRSJi5F+UnQu6a868G6MCZ9PeBpb0
 ONIQJWrSDN1uiNPgEv1DKva6GexJCSNb5sYDqMvAfw5J08544GqFvd8sheCa0shPb4MvDJlwyVY
 K1/f4zkINppB5nAytzZn+8L/qdnyq9MpJANlrUfZCvXcxI8wx2z9ERORyiZVtkm8/VFbtOrFV6G
 tyo0TUHWgrXMTZgjjXgkFb9scP24Dt0LDBPwXkl+KdF2c5J7EJZzs2L3MZtLXRpfQGQaTRGjmYB
 JK8DrggPiV1AyVl150yVZTTAQJntyRZsE00S1O61bf66Fi7+CnKXkg7JLb2J+pWXjNbUcReTdf5
 JM1jG4Lf4eMtpybXQVKww0j4EZG+Sf2OGoBhi22LPDgYA+QCIw40CfToVOK3tm76jysJ6bsSW/D
 HhSbOpxvG6hPjBLLQjA==
X-Proofpoint-ORIG-GUID: oMHrJR6x1ZFY0gAg8UiTmxLoWR3Reenf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfX4F2/EIMroyJn
 sqOuL9SElLynpyC31HXWUObzceS+0yptI0Rd2CnjYfMrPzy8pyYcOLPyNtbu9GbcwuqhJFYJk8Q
 G1WBWMDboN8CoOS8XJN/+u8w7uB7T8Y=
X-Authority-Analysis: v=2.4 cv=OsnaWC/t c=1 sm=1 tr=0 ts=6adef4dd cx=c_pps
 a=cX9Y/L7S73tC7IfZo5U4Gg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=660iZSQnnn4A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=8rWy6zfcAAAA:8
 a=jZVsG21pAAAA:8 a=SCySa3EsnnlR7pbFTCYA:9 a=wPNLvfGTeEIA:10
 a=YjdVzJdQTyZRADMV7wFX:22 a=3Sh2lD0sZASs_lUdrUhf:22
X-Proofpoint-GUID: oMHrJR6x1ZFY0gAg8UiTmxLoWR3Reenf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

>Building with clang and enabling option to find unreachable code=0A=
>found this bug.=0A=
>=0A=
>The loop looking for a free adapter slot returned EEXIST as soon=0A=
>as it found a used slot, so only one adapter could be created per=0A=
>event queue.=0A=
>=0A=
>Keep searching; the existing check after the loop reports when=0A=
>all slots are in use.=0A=
>=0A=
>Fixes: e12c3754da7a ("eventdev/vector: introduce event vector adapter")=0A=
=0A=
Incorrect fixes hash. The above hash has the following changes:=0A=
=0A=
 MAINTAINERS                                        |   6 +=0A=
 config/rte_config.h                                |   1 +=0A=
 doc/api/doxy-api-index.md                          |   1 +=0A=
 doc/guides/eventdevs/features/default.ini          |   7 +=0A=
 .../prog_guide/eventdev/event_vector_adapter.rst   | 240 +++++++++++=0A=
 doc/guides/prog_guide/eventdev/eventdev.rst        |  10 +-=0A=
 doc/guides/prog_guide/eventdev/index.rst           |   1 +=0A=
 doc/guides/rel_notes/release_25_07.rst             |  10 +=0A=
 lib/eventdev/event_vector_adapter_pmd.h            |  88 ++++=0A=
 lib/eventdev/eventdev_pmd.h                        |  36 ++=0A=
 lib/eventdev/meson.build                           |   3 +=0A=
 lib/eventdev/rte_event_vector_adapter.c            | 472 +++++++++++++++++=
+++=0A=
 lib/eventdev/rte_event_vector_adapter.h            | 476 +++++++++++++++++=
++++=0A=
 lib/eventdev/rte_eventdev.c                        |  22 +=0A=
 lib/eventdev/rte_eventdev.h                        |  10 +=0A=
=0A=
 Thanks,=0A=
 Pavan.=0A=
=0A=
>Cc: stable@dpdk.org=0A=
>=0A=
>Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>=0A=
>---=0A=
> drivers/net/qede/base/ecore_dev.c | 2 +-=0A=
> 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
>=0A=
>diff --git a/drivers/net/qede/base/ecore_dev.c b/drivers/net/qede/base/eco=
re_dev.c=0A=
>index e895dee405..6e76ac9c2f 100644=0A=
>--- a/drivers/net/qede/base/ecore_dev.c=0A=
>+++ b/drivers/net/qede/base/ecore_dev.c=0A=
>@@ -1544,7 +1544,7 @@ static u32 ecore_hw_bar_size(struct ecore_hwfn *p_hw=
fn,=0A=
>        if (ECORE_IS_CMT(p_hwfn->p_dev)) {=0A=
>                DP_INFO(p_hwfn,=0A=
>                        "BAR size not configured. Assuming BAR size of 256=
kB for GRC and 512kB for DB\n");=0A=
>-               val =3D BAR_ID_0 ? 256 * 1024 : 512 * 1024;=0A=
>+               val =3D bar_id =3D=3D BAR_ID_0 ? 256 * 1024 : 512 * 1024;=
=0A=
>        } else {=0A=
>                DP_INFO(p_hwfn,=0A=
>                        "BAR size not configured. Assuming BAR size of 512=
kB for GRC and 512kB for DB\n");=0A=
>--=0A=
>2.53.0=0A=
=0A=
=0A=
