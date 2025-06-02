Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44246C54FB3
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Jun 2025 11:47:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8DF414028E;
	Mon,  2 Jun 2025 13:47:00 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id B2FBC4025E
 for <dev@dpdk.org>; Mon,  2 Jun 2025 13:46:58 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 552894Hi004539
 for <dev@dpdk.org>; Mon, 2 Jun 2025 04:46:57 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2105.outbound.protection.outlook.com [40.107.237.105])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47186dreeg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 02 Jun 2025 04:46:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vlfkkd2FwguUCMwQzF2tT6Gtz2pqMd4vhiHy08K5Bz/NRKo7dJrXY5+8E057Oxtv9yjW2SuE/6pwN9KOQumSE+JloUX+qADRLHHeqKPVjX80Fct9G1iBsAcPn/8ESMyEbPBj2D9A93eF359UDvwD0yDdE+ek0Bl+pS6IsTv+9ZLfERC+3WxDzAZtBcxa7WuEPrRUo6fdG0Tqe2w2ieKieh5SUeqqDz3I+vM6DsGTSohsIWoFbMDeu4VgrLWLrkiGTvg25XlSI7bIjyjAFBBw1xFJVOWlaX1gJbnZmTT9RvBLQ6omClo3AJXV1xiP96V5NfxBTDuNktNz2/bt+WeH/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4FAgJZwktgvsX7HqSeer3AnqaXSZFBdAU3HnT40wvDE=;
 b=TC45QDUr6pEAuUz64hPNpEpQAkUbXA3IFZ/OJ7oihFNQX0Lez829SmtoOF4Men7XOFXWDIsocAeHoGZUu2bUiJBjcCgtZsj/dKJlA70QlIPk5v5j+qgVq6HmjOdt52vjvcmRbnm9FlaRUz2eVhiNuDbj60BcemxzBtW/tmXEecuMXbkWa+ORQtnNEZpvcTkSTegMTCXkk46Q0ZoiMFR+BashrtDYZgNNYrB0s8ws2A0gm+W8dHUjf1D5zBaR4O6i3rVFdaxlf9Cr2ND873i9oEunNAQ3NABwPfPebpWJ7qMcC6faLuu54GUdhfrKnZWgFx1+JPYwl04hLDneXVsprg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FAgJZwktgvsX7HqSeer3AnqaXSZFBdAU3HnT40wvDE=;
 b=QLuEAzBu12yH2Unrv/WULExTJIka9yOw7evYBhRWp7qsaIvxrlQMphLOynScTVM3ynyMCbEUGWdl/Fr/zLhIuAVuOe5ljq1Azipy7U01ZP3QXV666EIO/ENnBsS2Ocf0oe51yZXCjZ+Zf+eB5rHDsY91MNkFjPWpREcK6yB/UnU=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 BY3PR18MB4708.namprd18.prod.outlook.com (2603:10b6:a03:3cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Mon, 2 Jun
 2025 11:46:52 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%4]) with mapi id 15.20.8769.037; Mon, 2 Jun 2025
 11:46:52 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Tejasree Kondoj <ktejasree@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH 00/25] add CN20K support to cnxk crypto PMD
Thread-Topic: [PATCH 00/25] add CN20K support to cnxk crypto PMD
Thread-Index: AQHbzvbNlul8yPh5BkWwRasBUQnNP7PvyfDQ
Date: Mon, 2 Jun 2025 11:46:52 +0000
Message-ID: <CO6PR18MB4484450C1C211727EE49EB0BD862A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250527110205.2300800-1-ktejasree@marvell.com>
In-Reply-To: <20250527110205.2300800-1-ktejasree@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|BY3PR18MB4708:EE_
x-ms-office365-filtering-correlation-id: ce3a696e-c14b-4885-57a6-08dda1cb2a85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?4NTh6/xJV2NJkR1KeUt6ZlEEegqaruMv84kcoGQdQbrcQNx83RHHKPWTrTMw?=
 =?us-ascii?Q?JkrekWGJgju2kfB2yWr5G+wrn8996FvNJXHUNCZcTnnHwTqJ3S6/7PPcdbC+?=
 =?us-ascii?Q?y31z9BMlk/cRmY14lsH0e+Sfcgrl07xvQxIs8IK0XiPzM7bKzxMTKcDg1+SE?=
 =?us-ascii?Q?4PB3L+9MXxLMyDoHExDQpokm7OP4aYs0/zSpwe4O5OWe3G/ay88g/tPmTbQc?=
 =?us-ascii?Q?YyKbeqQd6PUJyeLbbhIpcja0uAjYd/GO4/8yZSYfNn4PdI/PBPqWhzqBVwzy?=
 =?us-ascii?Q?1u7MzrOI+5rKlTu9/LOpGaAx/9Ah++mQekHpFAU35pPjWb+AtjEyNfkkj1wT?=
 =?us-ascii?Q?eYUvw1rebw+e+WjOoDIOWfzFrnpf3op78G4xyKBgHUb8QDSRNre3NF/ZF9R7?=
 =?us-ascii?Q?Ea7Px6dPnDHe3MQMLvkuD3/quRfHkO9uDT4pDrO3BpmiWhwunPYgefrdZKv1?=
 =?us-ascii?Q?O0bPo8uEbB1qYH3SBbje+q7Vvy0PehlXcPgWl/5mWcxyGGr9ODg8biEofcFN?=
 =?us-ascii?Q?aj2n+7i7OssWk+wtJKyk5YzYFua6j06iA+pJ4OnZtrxerpYTM8KPbS1gdWG2?=
 =?us-ascii?Q?FrlDNE0zc5lVp4fGu/N9U8VPJmg8GokL4ByJIaTq8kT+kQHH2WbefiQEDkD1?=
 =?us-ascii?Q?jVPxqJ/n/K/T/I3V1QuGw8nmKP+jBKgPi2K0PqPLwnJympmA0vLmB9tPwf4b?=
 =?us-ascii?Q?XRrcodjOjbYHDwbh5Vf4KGhNZ7wkFv621dFgAMQJwHgxIygtWS/4ze/WDebt?=
 =?us-ascii?Q?DDorsL+oRNozNL2YQGWbDLNm6YV+WTTDKhmVSqT5oocvpc8Lzn+F0cHc8WbJ?=
 =?us-ascii?Q?tKXjWfM5Du3ZZANflZu1jwceRy42MX8KCdEq2DXziLA5cfIejY1ZEipHjaWd?=
 =?us-ascii?Q?EGOtoG9suJ1ItI34SLEHPDqr0dhEEkfSGO5ZVxYa59NEEfUAPrOJIUtRRC/u?=
 =?us-ascii?Q?7R/6WvcGy+i/NgiKRrg/m9MHOR2S6ofnAmXsfuwDeqFEcGJ92uQpBVpq3e/n?=
 =?us-ascii?Q?Z+DJFjKA+7UP5Mvf5k1ilXAtMlt68v8hZOXpxtXujayKy/p+LTm03K4U+s86?=
 =?us-ascii?Q?uHswRiTE2Qn6Xlyd3VEp/xc6LuwOWIQDds/u/MMUNfN3iM8Xqai1TKqsHsmv?=
 =?us-ascii?Q?1mQmxp63qCl3cpMle2EwzfwNFawpQAc2565W+edHNXrhEugM50qyMyv661eP?=
 =?us-ascii?Q?DjXPQjgKIPd/WawJA7G0uRUMzsAYHBkK0Va8bPVKLPFb8Lv+d3tPtilXX7xw?=
 =?us-ascii?Q?a6BDW6R2bUmqK+ujams3AnOIQVt7+8hsJU9PG5srG6KghJLKF9+HdOYXUmiN?=
 =?us-ascii?Q?nUfSusd/IktxDNyEj1tpEWx8gPOfr0sN2AlzLLsp8bkFJv4XdpX3jF4s9lvM?=
 =?us-ascii?Q?qOrUJnWyUCFVVtbXEBw87hCWUVo37uRev4AC6gQ3OoVTHKOzxpYNwHz1m9a4?=
 =?us-ascii?Q?zlOey0zHkUXOzjhGxbX3CW0SLS2VXk9LsMWJNx0+qlq5djpM4qs8O07SbZ7/?=
 =?us-ascii?Q?DNqf+YZdRaP1Bec=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0rFLJd5AbpdjTcOGOsRRwp9SVSfhj6U5UBUxW5PxYFYPaGCzGV+JInyjRAKj?=
 =?us-ascii?Q?iXuOys6Rzw5eXcO2Uwf+Ty9wlAbLULdccyPo1s6q2QGGrIdTz3J8+SlSVJre?=
 =?us-ascii?Q?nsQSnhHo3zqUsY0LO8wWnYnxXrPT7I3hi9uk5RXOqiCspIOfGdn0cTJJMeQj?=
 =?us-ascii?Q?gXz9BFnVZPuLYaMKkFiTR5n0WSvXaiqxHwfelNnU7lKc0WDj3H14OmAfbZN2?=
 =?us-ascii?Q?WoZE8A3fjYRryISEYboPWiVsedZFV2MTRrlxTX/R46TLCm012ILd/i56HsDN?=
 =?us-ascii?Q?1n+e5puWFTxZsFW5rxDMz195GrAsOLIBgCw3eg0jkWrnQVt8ZLdpm+F9b2Bv?=
 =?us-ascii?Q?wZ2uGk/xflzy2DWJLORPdaVuQ8oofP+MUUGT57s1Noac31OuNew1ygWaS/zX?=
 =?us-ascii?Q?9k4zoyvlKbzbfvOOJtSk8OPo6V3OS+8NaPnJlTSMg1bKLfraQZIRTIDjBSB7?=
 =?us-ascii?Q?93tL7/u/GURL+u6ju0zB33h2ompK/xPvVXGYmYRMQqb4E9ePN3/SkVRdS1Qo?=
 =?us-ascii?Q?BEvjE7mlFY2IwBnknp9mkY+53nmQqi1vofQJ3SmrrxTvXXP49zeMAYdnXbUT?=
 =?us-ascii?Q?l4PnPDNioNAGC0eaMg8tjuW7FQ22s3MwWSvLs8R/dzBtzXFoGsNHsHhGkSGo?=
 =?us-ascii?Q?tx14C5FqGg5cFOLNTvtIcPrId01K/Nf4PZMsRz8shi26O0xL7DbP7T+2uRAR?=
 =?us-ascii?Q?q0mt+qYnZgNOes4CnjdMoHZICUpOBkxuVjRUgGO9M1JYPEl8daAmrTDeMrQO?=
 =?us-ascii?Q?QElJSjX+PB3Bh0P7WpHM4Fk13rYAZHfN0S49B0LxrJMvd4jPG4f51e0oqEP2?=
 =?us-ascii?Q?HXRBXA1T/W/0Hha8Op4nkPUk19tx8dxV/FFXF8JIFZHX48n0Y2M1NtiSgfJh?=
 =?us-ascii?Q?tJzegTUhYem8y2dANEpA6kGmDPvksc7mlyZcoo8Z1wzZIGXgjVSSxwlUnQ2n?=
 =?us-ascii?Q?DXO1bo5r5iibRNssF4nN2w/CvAbsangU8zk/aG13emEckHKYUY8WEPDz0ecW?=
 =?us-ascii?Q?sFdJ7qlRlWi75Kl372OlAmIGOWNdARsp9pFyD2SQoM9q1LP5SduExrC/gFP1?=
 =?us-ascii?Q?5O3aZW1821y7hPP8rPNBNhoWQdOa9o6CfRGVRH/9khaVeJ3HYXAteY2Thlhx?=
 =?us-ascii?Q?4GlTTZU9GjM+Ay5AXAEZadkiEyz5Hp7eagz0wBXswcd14LtNInk0C9TkBlNi?=
 =?us-ascii?Q?PN4jviWwmYFepzjIb6YIbhvJr+1K9UIefJ3bdpabH8yJhusUKmqc5CC/d7uw?=
 =?us-ascii?Q?5WvpcR5Ty3eeRE+Onp2A5rqGk6uGZLpSSuKDZjBHtK9gdy4/aVFJdC9KZ0Bm?=
 =?us-ascii?Q?yaIdoxtVxjXksz5y5X3tSkqfGnHnV+60x0lAOBW47yD7j6YxWBKmIg2Abywc?=
 =?us-ascii?Q?FNBpYbziWIWOWwa/uEWflpVF2e+f/Me2ExvevRiqKh6Mf4BSy3wwP4ufJnF8?=
 =?us-ascii?Q?o7bYOt8VKtw9FgQX7+XBYlA7XPTmtEu0cEXaOl8GKN1LU4qhCK5iewH+jSJP?=
 =?us-ascii?Q?MpKROQ08q6P5c500iRxiDASLPp4zuMIieELDI+8FS0mwzMrFAKltBm/jyTdu?=
 =?us-ascii?Q?dy+PpDfBkwoD4Q0B8n0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce3a696e-c14b-4885-57a6-08dda1cb2a85
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2025 11:46:52.0264 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H3qDs0WfYRL9jqdgF4xkt/7QNAECHUYIw8oPodIkQjEAUeHg8cTgqKYDU0RYLcTHuRN+CMgSLkwUrE7GobTq6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR18MB4708
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDEwMSBTYWx0ZWRfXwkUO0A2lIEQU
 PDK1X3Y1OEmUkWoRXjMIM8jOqL1Fy7dBxCA+nvelxx4txEqxB3CjhRwDtkcdHZluLpXsFenePhl
 GAKJFmwZprggqCDPyvt734cIIOSi+cSQrXDLfmPzjfgcoB/BJCR3sh7XX1bSAwUt/b+43PAzkR4
 XeycRxbOjp9oqKz3wpr+CB0UYbjbz/ygIGcGfuyf0zfIv3bSzrJEi0lwIua8C4+YAS/nAtL9V9U
 TlA6hvwQjDcqB0xOCE213Bpjpiuhd54KxujDBqLBnFFks7woUoplwuVesg2UYH8bI1ilFwRF3W4
 i3ojyMRs5J6VL9I5lEGAAIZcFsQsptNaSf5//Xxo4bePBNhR0zgJgdV4q+1tykm8SbaVe2Qqg8u
 oFhSy8ZSQaqwSHQNGO6nIgEUM2wHHqsrdfyGjUiKUkg5gof5TcPNRIZIu+thZBbXNWkgYYZi
X-Proofpoint-ORIG-GUID: KgLiLsq10VaaLnR0GVKWEqMNyQz5bT5f
X-Proofpoint-GUID: KgLiLsq10VaaLnR0GVKWEqMNyQz5bT5f
X-Authority-Analysis: v=2.4 cv=aoGyCTZV c=1 sm=1 tr=0 ts=683d8f31 cx=c_pps
 a=IWBKlLGroRVvC9/lYsYQWQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=ivIPmE0RtOkxCvsByzIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_05,2025-05-30_01,2025-03-28_01
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

Please fix individual patch compilation

[2/34] Compiling C object drivers/libtmp_rte_crypto_cnxk.a.p/crypto_cnxk_cn=
20k_cryptodev_ops.c.o
FAILED: drivers/libtmp_rte_crypto_cnxk.a.p/crypto_cnxk_cn20k_cryptodev_ops.=
c.o
ccache gcc -Idrivers/libtmp_rte_crypto_cnxk.a.p -Idrivers -I../drivers -Idr=
ivers/crypto/cnxk -I../drivers/crypto/cnxk -Ilib/net -I../lib/net -Idrivers=
/event/cnxk -I../drivers/event/cnxk -Ilib/cryptodev -I../lib/cryptodev -Ili=
b/eal/common -I../lib/eal/common -I. -I.. -Iconfig -I../config -Ilib/eal/in=
clude -I../lib/eal/include -Ilib/eal/linux/include -I../lib/eal/linux/inclu=
de -Ilib/eal/x86/include -I../lib/eal/x86/include -I../kernel/linux -Ilib/e=
al -I../lib/eal -Ilib/kvargs -I../lib/kvargs -Ilib/log -I../lib/log -Ilib/m=
etrics -I../lib/metrics -Ilib/telemetry -I../lib/telemetry -Ilib/mbuf -I../=
lib/mbuf -Ilib/mempool -I../lib/mempool -Ilib/ring -I../lib/ring -Ilib/rcu =
-I../lib/rcu -Idrivers/bus/pci -I../drivers/bus/pci -I../drivers/bus/pci/li=
nux -Ilib/pci -I../lib/pci -Idrivers/common/cnxk -I../drivers/common/cnxk -=
Ilib/ethdev -I../lib/ethdev -Ilib/meter -I../lib/meter -Ilib/security -I../=
lib/security -Ilib/eventdev -I../lib/eventdev -Ilib/hash -I../lib/hash -Ili=
b/timer -I../lib/timer -Ilib/dmadev -I../lib/dmadev -fdiagnostics-color=3Da=
lways -D_FILE_OFFSET_BITS=3D64 -Wall -Winvalid-pch -Wextra -Werror -std=3Dc=
11 -O2 -g -include rte_config.h -Wvla -Wcast-qual -Wdeprecated -Wformat -Wf=
ormat-nonliteral -Wformat-security -Wmissing-declarations -Wmissing-prototy=
pes -Wnested-externs -Wold-style-definition -Wpointer-arith -Wsign-compare =
-Wstrict-prototypes -Wundef -Wwrite-strings -Wno-packed-not-aligned -Wno-mi=
ssing-field-initializers -D_GNU_SOURCE -fPIC -march=3Dnative -mrtm -DALLOW_=
EXPERIMENTAL_API -DALLOW_INTERNAL_API -Wno-format-truncation -Wno-address-o=
f-packed-member -Wno-vla -DLA_IPSEC_DEBUG -DCNXK_CRYPTODEV_DEBUG -DRTE_LOG_=
DEFAULT_LOGTYPE=3Dpmd.crypto.cnxk -MD -MQ drivers/libtmp_rte_crypto_cnxk.a.=
p/crypto_cnxk_cn20k_cryptodev_ops.c.o -MF drivers/libtmp_rte_crypto_cnxk.a.=
p/crypto_cnxk_cn20k_cryptodev_ops.c.o.d -o drivers/libtmp_rte_crypto_cnxk.a=
.p/crypto_cnxk_cn20k_cryptodev_ops.c.o -c ../drivers/crypto/cnxk/cn20k_cryp=
todev_ops.c
../drivers/crypto/cnxk/cn20k_cryptodev_ops.c: In function 'cn20k_cpt_set_en=
qdeq_fns':
../drivers/crypto/cnxk/cn20k_cryptodev_ops.c:54:73: error: unused parameter=
 'vf' [-Werror=3Dunused-parameter]
   54 | cn20k_cpt_set_enqdeq_fns(struct rte_cryptodev *dev, struct cnxk_cpt=
_vf *vf)
      |                                                     ~~~~~~~~~~~~~~~=
~~~~~^~
cc1: all warnings being treated as errors
[3/34] Compiling C object drivers/libtmp_rte_crypto_cnxk.a.p/crypto_cnxk_cn=
20k_cryptodev.c.o
ninja: build stopped: subcommand failed.


> Subject: [PATCH 00/25] add CN20K support to cnxk crypto PMD
>=20
> This series adds CN20K support to cnxk crypto PMD.
>=20
> Tejasree Kondoj (3):
>   crypto/cnxk: move debug dumps to common
>   crypto/cnxk: add Rx inject in security lookaside
>   doc: update CN20K CPT documentation
>=20
> Vidya Sagar Velumuri (22):
>   crypto/cnxk: add probe for cn20k crypto device
>   crypto/cnxk: add ops skeleton for cn20k
>   crypto/cnxk: add dev info get
>   crypto/cnxk: add skeletion for enq deq functions
>   crypto/cnxk: add lmtst routines for cn20k
>   crypto/cnxk: add enqueue function support
>   crypto/cnxk: add cryptodev dequeue support for cn20k
>   crypto/cnxk: add rte security skeletion for cn20k
>   crypto/cnxk: add security session creation
>   crypto/cnxk: add security session destroy
>   crypto/cnxk: move code to common
>   crypto/cnxk: add rte sec session update
>   crypto/cnxk: add rte security datapath handling
>   crypto/cnxk: add skeleton for tls
>   crypto/cnxk: add tls write session creation
>   crypto/cnxk: add tls read session creation
>   crypto/cnxk: add tls session destroy
>   crypto/cnxk: add enq and dequeue support for TLS
>   crypto/cnxk: tls post process
>   crypto/cnxk: add tls session update
>   crypto/cnxk: support raw API for cn20k
>   crypto/cnxk: add model check for cn20k
>=20
>  doc/guides/cryptodevs/cnxk.rst                |   26 +-
>  doc/guides/cryptodevs/features/cn20k.ini      |  113 ++
>  drivers/common/cnxk/roc_cpt.h                 |    7 +-
>  drivers/common/cnxk/roc_ie_ow_tls.h           |  233 +++
>  drivers/crypto/cnxk/cn10k_cryptodev.c         |   12 +-
>  drivers/crypto/cnxk/cn10k_cryptodev_ops.c     |  125 +-
>  drivers/crypto/cnxk/cn10k_cryptodev_sec.h     |   14 -
>  drivers/crypto/cnxk/cn10k_ipsec.c             |    4 +-
>  drivers/crypto/cnxk/cn10k_tls.c               |    4 +-
>  drivers/crypto/cnxk/cn20k_cryptodev.c         |  158 ++
>  drivers/crypto/cnxk/cn20k_cryptodev.h         |   13 +
>  drivers/crypto/cnxk/cn20k_cryptodev_ops.c     | 1278 +++++++++++++++++
>  drivers/crypto/cnxk/cn20k_cryptodev_ops.h     |   85 ++
>  drivers/crypto/cnxk/cn20k_cryptodev_sec.c     |  137 ++
>  drivers/crypto/cnxk/cn20k_cryptodev_sec.h     |   64 +
>  drivers/crypto/cnxk/cn20k_ipsec.c             |  378 +++++
>  drivers/crypto/cnxk/cn20k_ipsec.h             |   41 +
>  drivers/crypto/cnxk/cn20k_ipsec_la_ops.h      |  199 +++
>  drivers/crypto/cnxk/cn20k_tls.c               |  917 ++++++++++++
>  drivers/crypto/cnxk/cn20k_tls.h               |   40 +
>  drivers/crypto/cnxk/cn20k_tls_ops.h           |  250 ++++
>  drivers/crypto/cnxk/cnxk_cryptodev.c          |   14 +-
>  .../crypto/cnxk/cnxk_cryptodev_capabilities.c |   10 +-
>  drivers/crypto/cnxk/cnxk_cryptodev_ops.c      |  119 +-
>  drivers/crypto/cnxk/cnxk_cryptodev_ops.h      |   34 +-
>  drivers/crypto/cnxk/cnxk_ipsec.h              |    2 +
>  drivers/crypto/cnxk/meson.build               |    5 +
>  27 files changed, 4117 insertions(+), 165 deletions(-)
>  create mode 100644 doc/guides/cryptodevs/features/cn20k.ini
>  create mode 100644 drivers/common/cnxk/roc_ie_ow_tls.h
>  create mode 100644 drivers/crypto/cnxk/cn20k_cryptodev.c
>  create mode 100644 drivers/crypto/cnxk/cn20k_cryptodev.h
>  create mode 100644 drivers/crypto/cnxk/cn20k_cryptodev_ops.c
>  create mode 100644 drivers/crypto/cnxk/cn20k_cryptodev_ops.h
>  create mode 100644 drivers/crypto/cnxk/cn20k_cryptodev_sec.c
>  create mode 100644 drivers/crypto/cnxk/cn20k_cryptodev_sec.h
>  create mode 100644 drivers/crypto/cnxk/cn20k_ipsec.c
>  create mode 100644 drivers/crypto/cnxk/cn20k_ipsec.h
>  create mode 100644 drivers/crypto/cnxk/cn20k_ipsec_la_ops.h
>  create mode 100644 drivers/crypto/cnxk/cn20k_tls.c
>  create mode 100644 drivers/crypto/cnxk/cn20k_tls.h
>  create mode 100644 drivers/crypto/cnxk/cn20k_tls_ops.h
>=20
> --
> 2.25.1

