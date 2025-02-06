Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4165CC02194
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 12:46:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62EBC402CE;
	Thu,  6 Feb 2025 13:46:40 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 708664026C
 for <dev@dpdk.org>; Thu,  6 Feb 2025 13:46:38 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 516BGWWn002806;
 Thu, 6 Feb 2025 04:46:37 -0800
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44msja0das-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Feb 2025 04:46:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BuqhMisq1C/NUkhGoS2seZXo0gBoCqmluX2YzLC2vIG5sO2bTF3ZCzA3n7AeKNrwx6gtmDyCunZMaiRKZaSnkYpjt8cgLS7yF8goooWPGUTXeIOQOM29zGG11QFfxOInGZmk4IqmiIEhcLm95rdGD5ntnjAPrQ2R4zQ1Q5jKmati6ucqoEkRL7OL7GGycqLQc7naqfb9TQCAmSTgWZ/F0vSY4UTmH5V3lLzmwrB4/DgceCwdGAuc85yZj6dfdslJrnAjsKvneqKg0JOQAgxjvQOz89reMBMZysJSqiqnwrmWQub8RzGvgG4FGMMTV8LWFQgitAlo5w0lt4zuSdX47w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKIzEPLN0mkBp++lAdTIJVYJiOm3xUSRjGhv47+saY8=;
 b=KbzrvlqYA5hXvrmvAIEjOECrINajdt1NrIaopSKm3v+gWU1DvUjppavVBBSzkFTPYex1H0yEZcbi31+Sm1j7Zh1qz80wcTO1S4vWtqAss+lB2gLn4+rTH8YX3H2y9VvMQD61IE/njxi1uCu9x3Vg70RnVU6ETgdTV717/rdpY3VsV65siYrUTyzG2fhojQPmVAA6M1MZiqVIrJVcKya6feNb63oZI+++k+q+7bv0IU+qbRwpYfG98WuXkTo4jpYvNpZUVOrQZ3LxAlV28SqOQ0fEa/OmBr1jWpUCBc+PS3D/dfUErim5hfd7CYSA6YX9aq+n70oqykGaiHg0dEPfvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKIzEPLN0mkBp++lAdTIJVYJiOm3xUSRjGhv47+saY8=;
 b=L3JgwQR8YkLFn444x2pTSacKCnQnN8IG5Pyrhr0hyQ2B9M8xnt/cDy/pQPvN5CpkFmNnMOYu2srhFHByGWPaGwCAPS5umfPLlOOJc2cLqxgcW6iwB2A5M2eFJ3zYg+GMbNjCdlIvTqdw6hIDL9hh9D5mP4/tbB/jS5ldglTYlsk=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 DM4PR18MB4141.namprd18.prod.outlook.com (2603:10b6:5:39d::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.11; Thu, 6 Feb 2025 12:46:34 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%7]) with mapi id 15.20.8422.010; Thu, 6 Feb 2025
 12:46:34 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>, Fan Zhang <fanzhang.oss@gmail.com>
CC: Anoob Joseph <anoobj@marvell.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>
Subject: RE: [PATCH 1/1] test/crypto: additional RSA tests for CNXK PMD
Thread-Topic: [PATCH 1/1] test/crypto: additional RSA tests for CNXK PMD
Thread-Index: AQHbbMHthHmgZA8P9Uec5Gnjc+RierM6ULWA
Date: Thu, 6 Feb 2025 12:46:33 +0000
Message-ID: <CO6PR18MB44848B6D403B0B9E1724A4B4D8F62@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250122113626.2953973-1-gmuthukrishn@marvell.com>
In-Reply-To: <20250122113626.2953973-1-gmuthukrishn@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|DM4PR18MB4141:EE_
x-ms-office365-filtering-correlation-id: ce15193d-9729-422c-0f47-08dd46ac49a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?LAJPSkB092dEtg0TEBLwx/pibOSq75SAnTq/6eYJ9N/5KJOaEwtDxTCKEq+J?=
 =?us-ascii?Q?a/dhs9j2OO+45T6aJ0v7bkOKdMyCDtU7IKCxboy3bez2p56hGj2bS9C4Idri?=
 =?us-ascii?Q?HP2Gd4cUPBJ+yh0CJo3Zy3zrWe4FTORBlO7MNnhIvoTuXbGcmymsTSp7N8lF?=
 =?us-ascii?Q?p8IaEU3c80TJGm+AGtkdv2B5rrl2mgqKxcVHAXx1nxGuMLJeFD1t3YZu9Nur?=
 =?us-ascii?Q?1iQPOUyyyQsjYnoFR9Lb81y0Vg+v39f6/Kd0DuBUOwgFwdOPN6aTPWHGUPQ/?=
 =?us-ascii?Q?W9tMsgbyzri3myZJbIL7leoNpAtjZ+F0ttuojZzBqeWHOmhu4Mdbv5buTT7m?=
 =?us-ascii?Q?LWl3dITtf02eqQTAat0OQHiIBI8xhVMdSXmjYNaQrUJhH0WIISZsUE0XVloK?=
 =?us-ascii?Q?dhPBrLsLFflZted1B2aaVOZaTxH7sCQaTzMq0T2az4MOv1pnktbvsz5klBSE?=
 =?us-ascii?Q?sulidtZej2f6z944mRgbkwcxc2m1kyL/KXU5VMv58b9tcZ+flafL8qfCrn9J?=
 =?us-ascii?Q?HNvM4L3MYUuuG3don/oTUCIObXp+USEft5FIKE1Qg2oTd6eCML85egqAGCd+?=
 =?us-ascii?Q?LA5gH1RWPQoWLJObUIzYN9GG+zauEN1KMoaY2qBWwUthgvEgcdpcQycoupV+?=
 =?us-ascii?Q?SsnEeqX1GHR3Bof5ycHPNtft7929s0YE7rGNDy/3jM8GUvy7WZxzfgaHKyrm?=
 =?us-ascii?Q?bPPKzZ+/9KjiqDEm0V0vzOcBVZShtIukyjY8d7HbI0/xqTor+IDJhF8Ggkdq?=
 =?us-ascii?Q?g71EIFhG6LaSoihlgUDy7YqbqczD6U1rPQNnzVPa93QJTwnfrRu6ZVlr6zlT?=
 =?us-ascii?Q?9XL2BfwPl74lDJ6b59FQztmrxt+Mya2cXQtgSppbKig5BIW8cRfvkylwK1N1?=
 =?us-ascii?Q?ZocSCzjTNMZUG6icc+MQUPrXXvFRj3K/+W62Z8gu/J/iHZMWLSPiJNk3rClr?=
 =?us-ascii?Q?c8OkueAHPHlNoa7Mt1F59cyN5TZNBQIklZGOkdEpPi79uxKOpaj64RG65Qre?=
 =?us-ascii?Q?f6hTQ5oTULI2J+nPvtFISHEzJfi8pANLKsTHLRxoVVVcNVepiNL7LrfW83D4?=
 =?us-ascii?Q?rClfx9QyKOe1FAm7tKvgIG3kHdhK0/A2PkReBMQDiCaHaZzqc9AuPFtU7I+z?=
 =?us-ascii?Q?c0p/t5Nci8UTjk8psiUP2GoMwEVGzVv++kAXArmDMoHjIPaekrLwAX1Fqkvl?=
 =?us-ascii?Q?OV+UUw6tgxmROWEn0oeGAubCY5qnvYbEUq9LZDfwD4DMP7A5KS8k7P4amvvM?=
 =?us-ascii?Q?dlqku3tw9/oCH3lkey3fSGK9MVmaLX6N9qTypJVmJMGedKCqPFiUk9UW7H37?=
 =?us-ascii?Q?mpb2jlupAk6Xv4MTBW58m22S3PpLa2MM9uH35qHG036b7wsSYZyJ5lUlYQMr?=
 =?us-ascii?Q?ZJbd7dySbRd+6I/AU+miu5CokLJnsbl5352RhxmXYIN+lbg+5PxG6t/1n0Hx?=
 =?us-ascii?Q?d7rXuV//VrY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VCChFcCJX6/d/NhtV6HbezJxCq5Fvtgc+IeOwYuqVnJueGpeQulEU35iAMgO?=
 =?us-ascii?Q?ojpR6IR+KZBW+oA83E1yrQYOPZ1+fNaGVATCCiAojCZDC8NDaYATYOgWu31G?=
 =?us-ascii?Q?sFb8i8m4en24UFcpLP1Praj7Kpu2BfD2+Ol2UIPS5rcQPkpbry6tfa0ZQKN2?=
 =?us-ascii?Q?/K6oAXp8RrBbaUY0WK2BYUhR9/FjkwKQQGb6UYWj3QHLHT5uumIpomDkNpK6?=
 =?us-ascii?Q?NTBykIwmJnx1Or4yZQmng9MG9D9lVUYKYmqV/S0Mu5llJC9p0o2hnnIHE8vI?=
 =?us-ascii?Q?2jNSXdQEfWABhapmnCe54coVPJEvFDEwJSvQAZK9OOQwOhrKoVcN4ttttNJO?=
 =?us-ascii?Q?6ZZEp8FdR+JJeDuKBreQXxtZphjGFlrora0pBJkNBxZwdx9Jud9/rsL4d4dQ?=
 =?us-ascii?Q?rbDJVZ5VnNGp385XLTHQNwexQuzi7djA6IcAKYSkIw5Q11WlXLX3elFMAilv?=
 =?us-ascii?Q?cOlzfQdfeKWHqYiz1Z1K2wCftISpBWjujEZUGdRU2/xlZ2CTU7SHpsMoNgUw?=
 =?us-ascii?Q?SVM0eJRVLuXEhyb66kao7m5+W91Lf58VotsmC/rYtE1gAP5BgCSgLpe8XGJu?=
 =?us-ascii?Q?AyHgo19EV7AMRhTyJ9jIQqcEE1C/drL16lEiDOl//1aVoMGmuwM2KZofSr8C?=
 =?us-ascii?Q?VfKJ5Z7iUU86VropeljRjZjlxOFE+0pmM0IO6j0x+SMAENfqe3o4XyHHtrFi?=
 =?us-ascii?Q?0jk7EHIGsqK+kUz++pGmKJdOwflIpShIWV/PjNfIxAq4zkF4jfhhttPudSvV?=
 =?us-ascii?Q?ySDV9CxWb3oQUuAcYuh5TZvSW4becJTpOmtg99HMbya9OpvsihzwZ0SnCk1e?=
 =?us-ascii?Q?9k9c6aZQ3MARnAwPSVPcy5ZywYrBRKN5ltd2Bijnbg940YoNu+bga+Bn3OtB?=
 =?us-ascii?Q?PMtjro5aD4kmIUHP7KjZAG4bSCtlPzgKXWTwQQIb3EHvcjpiHjfyPLZWXrjx?=
 =?us-ascii?Q?UMo3Clx4X0U+Y2ArAQPRIlAO4ukqArlPCBnWzTOscEVhRnsLrZHkdWE/P+yo?=
 =?us-ascii?Q?faIt/oiKNxIg8lUTOIAWHohZhTsBNnIkS0WTdXZuILxV11h13xpu1woMLQt2?=
 =?us-ascii?Q?V/9yGQeq6YT8qIA/ATiQKzEiawmO6VSg0wWqX5SBoaTx4nTbTjmmVFtzlB55?=
 =?us-ascii?Q?LgxMaN4X+sieH+LpOR1nS8cxSDd67QXNAWKR2fogf/z8u1mVGPMbk5CdsLMQ?=
 =?us-ascii?Q?KW8DXPmrCl5Sj6qG4im60sot2o0+wkUV8bPODMMlEjEPyR6ECp7GItbwATdb?=
 =?us-ascii?Q?0qbAqDF5V5k1CurQ+wbxYRdbsAJJnQ/3VX5j6JsgbIsU1MmvVrBqj66a2P8S?=
 =?us-ascii?Q?xn6gIVXsSr2FemdrHC9bN1hcg6kvUPjSydViHlqGnyLDnIa40stOWcml0+zi?=
 =?us-ascii?Q?kUGP7tYfv9fHhK2RELyWMoJNiJPT6XXB/xY5E/ayP8hu7srUsBU6/1VLAKZO?=
 =?us-ascii?Q?D3+xeVoziOymMYhy/NrHHd094uDx+nBUYAum5GWLPSL0bDqwsFvSVCIt4Jk4?=
 =?us-ascii?Q?2QI2K2SzE2e+F6ck1X8SMw4hLT4RMbSTW3wPPGnv4LkqkycTHBnoI+Rj1ZCh?=
 =?us-ascii?Q?TvnA24+/DlegCo4Evhay//Oo9LZb2Nwk7ROGx0rx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce15193d-9729-422c-0f47-08dd46ac49a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2025 12:46:34.0290 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y3gp0IoeZhBHwEMXgZYV+5nLRBV+9MhIMKM45BFaRg0IgGBuz5QXEDZZB2IJc0hFWQGrxA7L+GVCIBnBQF9C6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB4141
X-Proofpoint-ORIG-GUID: oZ-3qJYniq8RCD9vVeaiVfaAyIF3QpWb
X-Proofpoint-GUID: oZ-3qJYniq8RCD9vVeaiVfaAyIF3QpWb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_03,2025-02-05_03,2024-11-22_01
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

> Subject: [PATCH 1/1] test/crypto: additional RSA tests for CNXK PMD
>=20
> Include additional RSA tests for CNXK PMD. These tests validates
> RSA operations using private key in exponent form.
>=20
> Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Applied to dpdk-next-crypto
Thanks.
