Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392BCC2D0CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 11:39:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 46662402DC;
	Thu, 15 May 2025 13:39:45 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 538FF40E36;
 Thu, 15 May 2025 13:39:43 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FBLppj030523;
 Thu, 15 May 2025 04:39:42 -0700
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46nfaqr12a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 04:39:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z0TqAFrq6lFVtuoPk66UScxVxvWN8bwvIgE1QVOw4IjTYbO12ne++byFW+kOwkE4FiQ8FYbNxOtFuVE8Qs3frfpxcawgKdzLyR9eu9dmE0T9p7K4et/9FEs6wSpMTbpG8oS0du6wxa9R7s22qoSH0ArOlDmFrvTb8Z2wyy3E7VF1bh8daTamuRClH8qIwdwngVzeC7VmZJgY7qviXeQRBXlsCvB6bMYdciCVUcDjw2VaLP0XloLgBAtKIU6eEXxsPSyyJWtT1jZ668cgg7v/MrmozZ1GNlNGn0i0TZ+NK4UXEH3XDaU2+XP/gD9TLsIKV1YmuzUUn/Mq6Qn0s1l+Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5riD0jcv8BLMhMTUX2ZiU+1CzhFpel9Ks3SA1kBr1A=;
 b=ZNjbrUGwJGVcqWbOkL8S4CQ+pcW+7z0PoLMJw9GMtGU5uHLDkjjdrz5U2gAvtfl9fA6kYYjM2TobKXyQfujjO1nFsEo/Sd2+vU4kBUPLCaeUNaMCjtbnrC0BfoMFeye58qcscR0gFTTKF2+dQxvqGeLuz3ulC3TTq4qGfXv4bUH99Ah0OBztCu4zUB3+C8syCZNikiZv54SY+zQPC54DcOsze/RGZT8DmhCdm3zpKBSMExg+M/btjgk0hMNe8MLKgSEHJ7Ku+hLwLCZQVguNa9N+P/S6vzitHsNA+i0JoxXu6Cc+lThKmK8+v9o6l7+9jNIixZ68oCs+jdr+3Leu/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5riD0jcv8BLMhMTUX2ZiU+1CzhFpel9Ks3SA1kBr1A=;
 b=g1w8Y3r6jIKT5cJUJmDomzMvE4N7dhCMIAlpFP/XShBjFHL9w9kmzowADDNMdtEtjGyQMtKc/ixGS+0UrfvANbZb5mFxHhLsPfOajT/+7Oam60fjZs89Ly+IGv9i9U24Hq4Dbbkmw0d2/En3P+72tg7KlulXsMMMstF0FeoqEKM=
Received: from CO1PR18MB4714.namprd18.prod.outlook.com (2603:10b6:303:e9::18)
 by SA0PR18MB3488.namprd18.prod.outlook.com (2603:10b6:806:9f::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Thu, 15 May
 2025 11:39:38 +0000
Received: from CO1PR18MB4714.namprd18.prod.outlook.com
 ([fe80::26fb:729e:a947:3e06]) by CO1PR18MB4714.namprd18.prod.outlook.com
 ([fe80::26fb:729e:a947:3e06%4]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 11:39:38 +0000
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: Akhil Goyal <gakhil@marvell.com>, "stable@dpdk.org" <stable@dpdk.org>,
 Anoob Joseph <anoobj@marvell.com>
Subject: RE: [PATCH] crypto/cnxk: fix uninitialized scalar variable
Thread-Topic: [PATCH] crypto/cnxk: fix uninitialized scalar variable
Thread-Index: AQHbxXBK/pjc7P5ljUufoDicTjPbSbPTkAFg
Date: Thu, 15 May 2025 11:39:38 +0000
Message-ID: <CO1PR18MB47142E16E26B2C261DA5168BCB90A@CO1PR18MB4714.namprd18.prod.outlook.com>
References: <20250515080632.1676-1-gmuthukrishn@marvell.com>
In-Reply-To: <20250515080632.1676-1-gmuthukrishn@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4714:EE_|SA0PR18MB3488:EE_
x-ms-office365-filtering-correlation-id: 95865700-e965-4905-489f-08dd93a52ca8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?IjrH1cr8v08UHCqTn3ukNM1fP2H1o3OQ2xRBR0rUIlPd3+BkmH08hNcLcClu?=
 =?us-ascii?Q?ZiyMNY8rxHNBqRn/9GqmALrzHBnvYxlxnQkYeoVBAPAW5ilEH+5Bms0bpfHg?=
 =?us-ascii?Q?CovSOF/8ms7YyOL9mFLgJa8tQoVfO8UQHTUKGtC+JHODCEz+ml8Gj3kuFDlv?=
 =?us-ascii?Q?13SoacNcoDTwwbd2Wnp4S/k2jgSFGmala/ixFR1dFjp/CP326PoPQp56e/ZQ?=
 =?us-ascii?Q?IEzqQ9ZMON5uTipG2nbJq92Z+3uvPXCBIlAggRl1+h2FrVVggvMtDnpEQ8iF?=
 =?us-ascii?Q?aP+gFlSp2U3XSjVZ6ZnqcGc49upCfsyMz4uA9aq0BRhfvVxX3B4xABXlu53a?=
 =?us-ascii?Q?dOAfGGBtCQ132dWTInBn7G9YrG24X8Xna7OWYH9oG7PjCjhoVEfffrEkX3Sg?=
 =?us-ascii?Q?jkAeoPqXms3Rpknd6T26uFOO45bJgqFuf46y+a8/KJkl2bAatYN5ZQF/a52E?=
 =?us-ascii?Q?aEE5ClT50z3ABA095O3ZSvC59+kOB7Ir6eqy6oDd+l6PY+5A36jnFmW065ou?=
 =?us-ascii?Q?PUqOQ4EGvORmhbReYlIRPhzQGNHzftC/wPEWrV8xhK5i+uoUes4a0t8bm5ra?=
 =?us-ascii?Q?yVlaPgCoNcvG0yXzA/L7CA8PvVnyhYBUMrI3hwKRTbUEQZSSjqvKPzIvQGa0?=
 =?us-ascii?Q?pDDadADW2BkrAl5yEFsoMOmMBMHYy9XpXjts37pDv0HD6zCJ5vVYXe0wCDbL?=
 =?us-ascii?Q?tUJqPnkcfkSW/LQ69CrOXKj6ouuPE5cQXd5NkIsIaB3HmfWwJGFB8VtxNcQa?=
 =?us-ascii?Q?X1GDvU/yhU3JXHyhP9F/wh5ojeHnEkeT2bGJ1tMF+OBCv4mnTPnjfTw1uN3Y?=
 =?us-ascii?Q?ef0AtBFgG0UJqdewhoEIUL3yQ5lDqedCJrGQ74xmP54XDwujgS1vDnny6P0X?=
 =?us-ascii?Q?wUvfc6OApL2VpMU8fNZXAN25dOlHN4YD0NGMR7JcsAGvWwQ4mh6YwmYPNA4K?=
 =?us-ascii?Q?6ziAWu0WIiWP21aGvPFVBbe6DCNMJuq7C+qL3g/1PYP5/UUoef2mukNdzyyn?=
 =?us-ascii?Q?Mlqn4lnCSk8cqcJEFT+CnreDsuC4xt3ac/DrurBYZT+vuXe9FGqWi2a/HmsU?=
 =?us-ascii?Q?7BN3PP3BKq8HsCcy3gnKMfO7/DCne3fD4C8jw586vAszLbZs73tEolgoKqbm?=
 =?us-ascii?Q?wJ3dPFdJ0hE1AtC5Fjssiw5nRtTX4pKJDA0ButqtQATHtZVE/u95/5/5qEdu?=
 =?us-ascii?Q?x5YClbMGeXjNlY5T8iNSOJRfhfxtmajWZ9X83JRemc5lvGQMem/vrvjqoifu?=
 =?us-ascii?Q?DTxfOoI/VPB0H7sPGPMbOYN1VcbGLJGgME3R2tYY1UNKQzQhKT9oI65T6y05?=
 =?us-ascii?Q?rSDdHlRCuYnGFErLkqIFT+ffFnUvbbbzmYFS0wpxZ6pnL9p/R2l6a19mCPWd?=
 =?us-ascii?Q?ST0NWRowsl2+uG8zP+NWTdGrUPIOUL5YV85Gp6cZGxGGyb7T1qy2CutQ/cuM?=
 =?us-ascii?Q?poph9/XuENf7wzS+Y0vQPeAkaN8qAP1SLkGvm7kETORB042D0FKL+ihI7nN8?=
 =?us-ascii?Q?ykzQPSe5c24mDcw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR18MB4714.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HykQRKQqNWIj2AgEVWyvUw4XqLN8+p7tLk3+4ney7cKzGEbwY+FQ03fn5UKj?=
 =?us-ascii?Q?c+CGCpQZut829lR+EvnTEuixsfsXK03CfWNY0E1N9pLgXAYbzdHo7sYg5N8d?=
 =?us-ascii?Q?WthLbH42tQLXYvsGWLMoFDZGOhanzNVoBKXdYoOJLY4zKutC4aIJzh3XPFJU?=
 =?us-ascii?Q?by1ESx7czrzTH2aZ9jlcpraHW9R6obNNdWEMhVFf42G3DpEBYXvdaEybDd9i?=
 =?us-ascii?Q?MpPvz7TK6W7wKPed6iRWhlt9JK/wfG7m+51qtt/HT6NB6/j/3grIjyePeC72?=
 =?us-ascii?Q?ulSOQ7AovQw2f/JcPTf+USVYZYKQOcCYWJ265+riiHJRuWXurlQbUFpVQ8f+?=
 =?us-ascii?Q?hoToF6g7ilDIlPXxiMDw8C+A0FXAcU55aOYDrZPhbIue/qFJN4jagsPEcpPG?=
 =?us-ascii?Q?bad+qe84YWt/jk6e2rjcvM/WUednCepEwiUB2wINa/bdCv8JapFlLPAecGSF?=
 =?us-ascii?Q?2RxlZz4Jqbq6V5lAqmaRXgoX1HZr4biiqD3DpPEDcmtIid9bORydMTYnM3WI?=
 =?us-ascii?Q?ng2AZvMyDuURIuKXmT7l5CiqKhtIxbobbzTVPQegCKwhhqpjpSnc71EMa6Tr?=
 =?us-ascii?Q?6ZqjW6FtMHMp+2zIW0KxdwUHaMAqdRR3KjQKQ/wjDYuP2R+nCbohJs4NQs+o?=
 =?us-ascii?Q?AYzjvLyax142Wf0PHAqZrMu44ZuYYOh/v4s6APmQ7b39sNRpjGubSe55oHE/?=
 =?us-ascii?Q?tnK1xFPrJ4Xcu9mN2vj8H0wMMezEB5mSqXP1BS+yY3sIyFAkXVPbXM12cyhB?=
 =?us-ascii?Q?JQ5S1Ym6F2DQyEQyuHthKZ7u3kJUSFWbo39T78B6JYRrqyrLfISNYsJbFkzA?=
 =?us-ascii?Q?q26GjHB2W4dfYIZdNYBjRjmV53cCHq2B0BXltkbHSfIWFw9mFYVPtmvM9TZu?=
 =?us-ascii?Q?6B0BmAQrdmxi/K0485Ke2cmeu0bfzd4qfkn5m+94g2r9+mumMl7B/4/iLJqX?=
 =?us-ascii?Q?zGERfRs9h8k29qXrFWV0w+c+ZSwLfEvfofre9lFZFb4hGMEbSCUGFnH4opQ7?=
 =?us-ascii?Q?3nkGhf/YTV+voeMLDwgj8k5Ek5lwN81j9snpNiQjN3JOehGR1BRh2CCUlWuI?=
 =?us-ascii?Q?LuYJEvs70bDC3WLFXK0lpuzAhTwHvKAPnCllYDg9zG2DQkWBFG3V28BqTiHI?=
 =?us-ascii?Q?Ua4M+iTK+0GGjK6hpNFmPEHqFk3KSxmga7xt31ALY9VmRHSADn19z7T8Ts2n?=
 =?us-ascii?Q?/IJknddIMeKSY2InhIle6LMEO8QTl32zaKZvuYoiEHKb+eQlxZiznRQcrg1u?=
 =?us-ascii?Q?V3p+a3nANcagFx6686s6KdFOK9oY52EsWJYiuNOvnCCpDd54EA7QHIW+imSP?=
 =?us-ascii?Q?VMzrg+PImZv4WQvqChYuyCEV2A8kqOps6mkS6tjsiaZFtqaqVbOV54CGp1y7?=
 =?us-ascii?Q?FKEDYvJxyPCTj/63zvEpiVBFPihGNSUZidmlUs+u/blGRbhaeQo5HRE1tZJ7?=
 =?us-ascii?Q?ONM+dx+9UMRiBMXC7HSbcjtXY1ugLmYYn3VyWjcbMTwJiQeClIri4GRI3vMk?=
 =?us-ascii?Q?GNXg2W9GdJ5uDO7chCYuD4j9BpprwrvfCsSyXKAa+Yt+VEU0W7dBlmGBH6IU?=
 =?us-ascii?Q?1Kzxs40YyQvPsHjfutWn71rKwljERFYtAj6tEWRr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4714.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95865700-e965-4905-489f-08dd93a52ca8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 11:39:38.4414 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5LZdqpNvmoICyPMV3GrvpRYdf2fyvnL6H+oMxxMeCn7tmv7lVBGyUAcN3CKYmQxYNRjtiIr/+kyjxW8ohZWlt+bn4oAW6cYbkZfd9sDELgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR18MB3488
X-Proofpoint-GUID: V8buBnf77O_OSfXYb-AcQR9vEhWPFhNb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDExNCBTYWx0ZWRfX36macdu5tVw+
 nS9EATZ2/06NEiluCkrkqaX8nSdSNl6Meak7VgnHDbiMmK0w08RzgIOgvAzwReY2IbCylFxEqjz
 3z8FKBd8zEiM0adZB3NIoP0BT6Nw8cKRxaWVw7VVBwnFeJpi9FCAPflfdtm+hsCDtEslI8IvviM
 adWKMDtq4KpkMscrg+OgYMnXResqQi51DanonRSFgIa2VY+/EMzY7ecfJaOGV9ZNnMxufIQIC0g
 R4dzONoXy9mVbRvBMyUT4OK0dW5kw/+v1JLkp/eL1y+PhHJ/ySPap3HAMNKTMBjtHgYWGUoH0V4
 TTgEgGHTIXDvLpKvKMuUrXs357eYOFCYihaDTCuGYrabspB0DcE+JfrCZ7fkrQurCnKWBCV4FQv
 enxhxw+Gc1TDS8pSRBMAyOwaVtjg71HDBYWkqZAwUHX1DKOcMcfw2yWm5L35VE/pDTzNpHr4
X-Proofpoint-ORIG-GUID: V8buBnf77O_OSfXYb-AcQR9vEhWPFhNb
X-Authority-Analysis: v=2.4 cv=GKwIEvNK c=1 sm=1 tr=0 ts=6825d27e cx=c_pps
 a=WGTt6C9BqyZsVnlRayY6PA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8
 a=3eX08Eoas2V0bhZ_964A:9 a=CjuIK1q_8ugA:10 a=YjdVzJdQTyZRADMV7wFX:22
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_05,2025-05-14_03,2025-03-28_01
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

Dispatcher unit test failed which is unrelated to this patch and looks like=
 infrastructure issue.

Recheck-request: loongarch-unit-testing

--
Gowrishankar

> This change fixes an uninitialized local variable as reported in coverity=
 issue
> 445390.
>=20
> Coverity-issue: 445390
> Fixes: a8ebe94f8cc ("crypto/cnxk: support EdDSA")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
