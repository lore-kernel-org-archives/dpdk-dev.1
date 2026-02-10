Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C007EB26F5
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 18:17:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B02840689;
	Tue, 10 Feb 2026 19:17:18 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 694DF402B0
 for <dev@dpdk.org>; Tue, 10 Feb 2026 19:17:17 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61AHsnPg1274626 for <dev@dpdk.org>; Tue, 10 Feb 2026 10:17:06 -0800
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021119.outbound.protection.outlook.com
 [40.93.194.119])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4c89g1g24b-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 10 Feb 2026 10:17:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SiBVGTwT/GnjH0SVlhN6g5yuy9Y5PU1KoiDiC38653BxbSCTftgF9CgeGL5o/lckIPjao3HzawusP6wFXb/vTRj6znw6KmbRtoldEcWxH4oYwy6t7eYoiK4TNVjA/xC5CFFokC8Y9kL7ExgcMHS8IPQUcAXAnaHdkmtS9gj5LzwnvRvlFat3Yfh3AaGboT7iXk600la7jNnfN6/s1qKMcx5bv1QqhJb2RPjTbOBkvoD/pZ21vAwtVDicrZ2uK6DJRlaaH9eNCxGGve5vVJJ2JT2KScpfc15UFeDO6JNryL8nYNJ+n/wyGYxENP0HbkipEzBDVjUKIO3Acn+hjEqBsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yxo0DnXLL4uOb+vdsQpRyxyZwLTsu2Zij2jnbkB4Em8=;
 b=S+KGbA4FPcXHcGKuhpZcRsjAJTDUUsjTXX5DaELlGD4WhOhRkSTLA34z8XFJo21JZdLZ7GLLTMHhEMNEjCjMVkTwEyGhLBV+yP/HNS3t6pS5Tt3h6hifwaolUXKaz7uCT3h8E7yPTNIQiO4ubDbwVwVo6yjzz19DXygseufW2R3IraY0dmWlu5t4Q6CUBXWMbN7gOb4y+Kl2XiI6MJxWcglsKfdSxCYidV9rRoLaXISkTCX5L/BKDCWWN+r9w5KqZbKutm2+w/9xW14AIyxBUMGmfsuYZwt/QkuHNSAqB6vSv6majTLOo9Krek+q85kiIzI0rGYjiLy3KtdWxCGODA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yxo0DnXLL4uOb+vdsQpRyxyZwLTsu2Zij2jnbkB4Em8=;
 b=rFGti0WUy22P3lU7ajgOQtL0ACIe526qw2wUtohhpLvnsNDJT17hW5GbLgGkVIHXb4cNoatlaWRSlamLJVc9MGEFTXyAtJSIcvAlvvtVHHOouwSX6Hka6smmrDAxoRpfo3gOKX5Br5+WUUVcLgcyJGzE4VgBri/gzghGB8E9QKs=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 LV3PR18MB5723.namprd18.prod.outlook.com (2603:10b6:408:1a8::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.15; Tue, 10 Feb 2026 18:17:00 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 18:17:00 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Rahul Bhansali <rbhansali@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>,
 Anoob Joseph <anoobj@marvell.com>
CC: Rahul Bhansali <rbhansali@marvell.com>
Subject: RE: [PATCH] test/security: IPsec rule for out-of-place tests
Thread-Topic: [PATCH] test/security: IPsec rule for out-of-place tests
Thread-Index: AQHckFwX4ZWmKE/WtEK77QDwd+nqG7V8Ubmw
Date: Tue, 10 Feb 2026 18:17:00 +0000
Message-ID: <CO6PR18MB4484A4D0025E27C2BE17B2F2D862A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260128134308.571158-1-rbhansali@marvell.com>
In-Reply-To: <20260128134308.571158-1-rbhansali@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|LV3PR18MB5723:EE_
x-ms-office365-filtering-correlation-id: 4cd098f7-30a0-4f4d-b8b2-08de68d09593
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?Vp/6lsdK68Bkls8A/me4K28PkBya389UB9OFeMrO92BVlWOV3vOj+ogTJ3Pj?=
 =?us-ascii?Q?qlStHbDhWYevK1LIuAIqwZO0vFb1YLf+bKOP4DwBHF/n5lgW/eqtcLC4o6pA?=
 =?us-ascii?Q?CpLzIzmlDqj/hwRwPLZNjFaDHiHIU/W09KI34uzjOHBr7cCDsRJGIUUrheR5?=
 =?us-ascii?Q?BS1p1k4a5B06SoLlAcE+IMoZz1LZMRnX6ByjeURaVOie5DD48udS0xK2n5I5?=
 =?us-ascii?Q?9FXPgAfs85e3eNXBLl91OGI6VU5HY3c+9OzUHP6DZI8NpBUz6+8PJsMIHntp?=
 =?us-ascii?Q?PiDVZK7wi1AXSTiTWFxs45vvfZR8AM0bkdj8jMij2+3+okeKoETZwNnLUxP3?=
 =?us-ascii?Q?6CVxwZJBGj0JPydHwjEuQ7LB5KLrvljUcM+P3cUuuBPjh28yKtCn/mlu5a9Q?=
 =?us-ascii?Q?z6cp7nGtGoo8+D5tyw5Ttbu7kB/feFAyy5Jjk3FFEQG8IlySaE6dDC24jUl7?=
 =?us-ascii?Q?Y6mOI0w7/ClnAReyB0BUAxs0R7G+S8YW32wH4SsZZSap/37c6eLQYxsHnMED?=
 =?us-ascii?Q?WZXhzPHsl2Sg6F61nHeAlHMm2hcCX9s5Qqf0eQYcYFt2i5p4jfH8UkS4nVxW?=
 =?us-ascii?Q?UwSvWYgTC0xrTqpICnrQDaqRD1jsLy6hL54YJUEMU19QhCbkyyl1s4L9qcQz?=
 =?us-ascii?Q?8KNqcX0/GepUUGO2593IXzsP70kf4nbD1KysplpJ2qw+Z5YWNZkXO7L1Sh2Q?=
 =?us-ascii?Q?pausVQGRevqzvY+HP88bp/GpZaJtzAvNhE2zKHkafY9kljC0Wbm6aLKbBhtc?=
 =?us-ascii?Q?IlStiLqiCjgrzNOeq7s9HHjc+A43Cqep2dym2dlip5iHZSJTgRLFpH+gsbwK?=
 =?us-ascii?Q?amPA6c1BF/25n4McmWXFDE75ApUxVvq+Es9Z5FBSJEYd86NzyBdJATekOpjd?=
 =?us-ascii?Q?F53gkkjZKeIPIZDbSJRrFb8qOuiIgIhkIXrTBvDIK8ZE0Rl12MT8M3wNOMDF?=
 =?us-ascii?Q?F+vPhYN9IvmWWzFn1yDp+hj43OQxxAZpErl/+P+2rOcvEY1jhW151MJ3WzOi?=
 =?us-ascii?Q?34gGx28P22IOCbbWj3HgnTlo9SSXrp8j8nNsYRLIdFcOxj9OTXGlj3ECWB1q?=
 =?us-ascii?Q?4jnRw0YSXq6BDXRhvDEEF2IALih1Zr1IuMwaC2ccBeU4a4zspctv/jgg+3ww?=
 =?us-ascii?Q?K6G4gNCw2egzZIFmE2MJ5eCZo50ABuUxaGjTC7me1PewQhzJsCGrERKABZ3j?=
 =?us-ascii?Q?5mYtEjTJXps5rNIAgc6/knpLp8Xd+wjKbk/rMk2eTxANnu4Ip8dBzWd89yjA?=
 =?us-ascii?Q?DDbaGhRMBY0fKwp8QTJn9bz9X7isZUCuPNpFqcYu3wvfDRt/BU5Zg05J0Qw2?=
 =?us-ascii?Q?BVZfzfwWh1v3LeoxgkCvGm8pSK6A2HPpcr2bzpeC1CEyQkASpLjT3fJQ/vmC?=
 =?us-ascii?Q?sjnfg+x983xnKZSWgbfOEGQufsaDxzkNOyC0e0Nj/MneWjRpz17SdyiqEr54?=
 =?us-ascii?Q?hfrmUNfFopOfO4rNmByh9WDdtDI4KrzBsutSW2Pqa1EtyvakTvSy5Gd/LrNf?=
 =?us-ascii?Q?5kFpfmvhKKezxqYEaCbGJKJ9xODrj7b2YrWnhqKIglQNws6TXwre1r8dkB6j?=
 =?us-ascii?Q?sVfFcgytew3+9MH48L/npG4NUYpdyZevVppiHW6t20IvqGkqj91pHTEPY5M3?=
 =?us-ascii?Q?7zny7CG8z9fkx3wFSyH0dAE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hpGOj9va9QfTiYPrrq5fsvdnGBO4oLxUshggqF8bjJBNLVE79N8geGzrR/pn?=
 =?us-ascii?Q?zC7n+Ns45FP3Vy8q9t53Y0zLYD3pvqovrbSMZbt6gYK4d9Owz1736hT+91SQ?=
 =?us-ascii?Q?D6/nIBKv99nnx0Iudn34qF9jvIFWzF5hbUKf18RVFcMuAJsi2Dt26v7fAhyg?=
 =?us-ascii?Q?/nu3VbbHBA8FZeVjsLHNsyYbkUZfrbx8H+OnUifqVKFp76Je5SLZoX58T4L5?=
 =?us-ascii?Q?wrMMTT4CTtIVp5NZPCmRHVMdD05wD4pUGGHoeV7nBlQYUR43vlhJfIg7OTwU?=
 =?us-ascii?Q?Z13rlPS1YtbEOTr+aIulIWPUhyIaTIkA/brzdxKJWsojxGgF2YNNu/TfYWaX?=
 =?us-ascii?Q?31GV8nZ0kWejSUCEaAZdLjiaVBKs588aTz1YcH2+8/n7pDy+nX67+rcvEtDc?=
 =?us-ascii?Q?wgM9cKaavjV9KxNiRSODUvFQE2+xYDqypqvuuEQUTbg9aPx9FHT4DGTKYB8p?=
 =?us-ascii?Q?zUzIm8V/iefbSl2B1xbueKFYsYbDsLZyhClHJSbLgqgyhkepu6phD6IdRrrn?=
 =?us-ascii?Q?x+wRNbHyyQ0U5Xsdz0bmMMUqfauyqwcUFCaOsUzXtI5bMnL5Cx4aGZf8QOpf?=
 =?us-ascii?Q?yO0KdO6Fx1lmc1r8FRl5pZ4p5JJV7ov0mmFMZPYPSvGhpeX5zfs9GoRFdFjr?=
 =?us-ascii?Q?s1BsML/sPeYXWhq9UYxVB/PiOBno4wF58Du2F+5wU63bwCvaRlBZOL9a6wG+?=
 =?us-ascii?Q?q0QTXgMRJoDRZ3TwG9Gs41ki7tkiDX30EF9O+/bT14s+40SS/1KPfVC3Vvq2?=
 =?us-ascii?Q?Zgpg4aV1JBGFaKjelshOQX76WLDLXDRRJAxAmraY5ALLmXLlH8H9igodfWIy?=
 =?us-ascii?Q?lxvB6PglliRqlBE5zwMGAXJCRThuRWzzWcyQiSUNdzBUedRrGZp2ydmJ6l7q?=
 =?us-ascii?Q?5J9yYLSuFrg3KapG9B9UgP54iAl7OQj68zds+Z1GIF+pJmu9MmF8TwQhEK1s?=
 =?us-ascii?Q?KxI6R6LEG8EG34EsP9N+cU4mQ9Aqa3iSopgkn6/FpHx7APUtBYTNpr4Dq7pW?=
 =?us-ascii?Q?fH+JpVinC7L9RoEBtH599ezZw0rE0EDpEbfi0nlqFeviWuf/Ulz3OpRX66xS?=
 =?us-ascii?Q?2oTe+pd3gIxowsmvd5vT0K89pO7WsUiRp6z2Dl0jXKgmsXtw9RvmgAk+J1KX?=
 =?us-ascii?Q?qi/yINDtnt/QPPx3tFa9/dRBcAFwi/bDz/8ogJUvNM0wurrZWHXa/dzdWO/y?=
 =?us-ascii?Q?eP5AVKRo5vZ8mesaG584y/CiW9rt2EBuopckXYhTdeHEtVNNb2Wk198A0UTj?=
 =?us-ascii?Q?oFq8U4jvPSIPr2oDXy2hMaXUInf0ti4lMf95uFzumXRok65k/UnLG/1moTqd?=
 =?us-ascii?Q?73wG4/3WTnORZrL6n8s4c19eOBd4MZ3EVDxOhoxi3XsoqalJkRYUYXwTlUHI?=
 =?us-ascii?Q?4NPnveGquriLW5NdGWBxGoVAn8CiNUJDJlu+h4Zi4GxU16wlEQ/MHicHOXIt?=
 =?us-ascii?Q?JDwE6Fw9bDyBYiTuiv3Gzo4+4wkG+6IILIfhsJV9Pg48MkXdEKe2jYeezmPj?=
 =?us-ascii?Q?+Gsvdix8jL5GsyhQ8hd2rmJIemN1ANAOhURIO8Kpyk3fZudtGmGWz5PS06fN?=
 =?us-ascii?Q?NYLymtebhWRrCWxxNmWT80/c9bxb1v7c8pa0JOIHWn2Unp6hsJ0o064wEztU?=
 =?us-ascii?Q?HbM/R79yi5qSQMB2MdCm6/PyBc/3WVfmoJjVYROkUR4+vHLbTExUV95SrS7E?=
 =?us-ascii?Q?nUGxhsDrxmcSiOTENsxnYlxFgXtFhshXgPXZm7EimriuY4wJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cd098f7-30a0-4f4d-b8b2-08de68d09593
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 18:17:00.4594 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NUuO9xu9lRpQ5zPtSbyvfVk4aMPrJpyEYeoTtuy7Rn17cxeVbNIZdxkC1ePKjff7SuY6duffLzhgDPLTKs3haA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB5723
X-Authority-Analysis: v=2.4 cv=ELgLElZC c=1 sm=1 tr=0 ts=698b7622 cx=c_pps
 a=GdOSod5Hi6qnJTGfnwF89g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=M5GUcnROAAAA:8
 a=23NkyoHjQVvAVUHHxPgA:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDE1MiBTYWx0ZWRfX+r4d9zyTRK8n
 OIyovCUoX/aKK586yR7mdcl+apX4dn0lpGcnGJE/AHvtwb9cjoeTGbANuatPR1lm2Jo/7U3x2Nu
 R4+JILPnQWv4IOp1nosGISz5xl2OikgB0NCh/3hhn+crISx7WqlWyqc8160McK2JEU1a88S7CCY
 CN4F7nF/NvOitO4mqL2eCt0GlFIA7zISl4q1KdtWdCVCcaN7ELF7wUVQDudZihu2OzOsfC6uwe/
 FVL3z1/C6b2MpQrrdbfOEqIYQWrXDVnyV/LX6W57WkknKEs5o5uUl/Z9gP+GHz1VbHsjW6eOM8L
 /TqpiuiEiKIJJwkohZdMEgn7XNbfsC3UwsrK3sEyNL2D9bOW134dqchNDF8Oc4fxaosB/3jtkgv
 FC6SJf5f3t3g+IpNBtEfxGqllz3kf9BeYNS8TZ2iKM1ZaNpLA9+5SCeczWvUHz++lIoucgzqEwR
 AbtmFKAHR/wqGBJkSgA==
X-Proofpoint-GUID: KObgyGSK5WqwQs9tYQHAawIHhDvGtzZq
X-Proofpoint-ORIG-GUID: KObgyGSK5WqwQs9tYQHAawIHhDvGtzZq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_02,2026-02-10_02,2025-10-01_01
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

> Subject: [PATCH] test/security: IPsec rule for out-of-place tests
>=20
> For out-of-place (OOP) inline ingress test, some of the
> hardware supports ESP specific flow rule instead of
> default flow rule.
> OOP test case will try first using ESP specific flow rule
> with SPI specified in flow pattern. If ESP rule is not
> supported then will retry with default flow rule.
>=20
> Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
Acked-by: Akhil Goyal <gakhil@marvell.com>
Applied to dpdk-next-crypto
