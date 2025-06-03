Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAD5C5AE59
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 14:25:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52A0440B9C;
	Tue,  3 Jun 2025 16:25:49 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 87A7240A89
 for <dev@dpdk.org>; Tue,  3 Jun 2025 16:25:46 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 552HKn54010615
 for <dev@dpdk.org>; Tue, 3 Jun 2025 07:25:45 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2111.outbound.protection.outlook.com [40.107.92.111])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 471g98j754-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 03 Jun 2025 07:25:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E0fZ8fEj16E3ZjmiQ6tD/fQOsBeFIwOU4yr/ZoceyXOObqduinJBHXlGct1jwrfITmce9fQ6f5pXDqRYeAvku9+TguGCl6c557N1F7oZLeeXeIufKTscUr38kgXgXCWyDclFQiYxUinMfjcLKD4tmPHQVN8LfLfOc2IeJgVkbw47lCtb/SDkneMjzvNCbqqlJWlbBA2HwyS6T8DJ5p8SJmNqZ0uXNxrvNjlE1MprnyXrb2CTQMwVDgdBelD69KuTLHKBIq5y7kfcDr7zqNe/MveNaAmoQ1j3onC39ScrG3FlobUXggctk24GALQ0v6SXP53as3sXF8+YIPXAfIYgNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9L3vgoYiQv3sIFtj2POt7eQ7+FaTlbEGhmjafnop1OQ=;
 b=FFtGRpB9wZHCHjpooopJGhMHbTgXi5MzHTxGSMomCqXjRVrnhnB1AE8WZRRt0GbS4iWYRNGIj7KeICVSScjGROFZngXlNVAuryHOncvfvtBUiNLksoiADFcS0S/mZxr6+ZZ619KBXyLOI8+wTGU9cMn0jE8nIJADygz+SEeUwGn4N9NLj4q8JitfzQD2LiXiB7pvAbY5ilgw1gMSNg1lP0HE78bi9SXCFDFigFjS6iC36IMCHkavW+VSJSV31VVMRuveImEJZZ7ZMe5FG8IithNmpHtxUGd/GBV3u6Im1Za1ZZDtaogbzUE0f6MmHRSmzHSqDJpbfpEbGJploFc/VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9L3vgoYiQv3sIFtj2POt7eQ7+FaTlbEGhmjafnop1OQ=;
 b=f+HqRu1us/AC33bQSgScqCUGiCEhIBY6HfZCvC4/WlNtnkDc4IhUpGqw2TPAYWI9r13bOJStSP6FrlAk2EAmpvqIF7u3lwkq6MfS7bVeR132J3CZLd4j9rZQaH5SXBw57U5K3WpHCPgWlTBEAp16Ym42vT4vnGS6JWmT/Mmoghw=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 CO6PR18MB4516.namprd18.prod.outlook.com (2603:10b6:303:138::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Tue, 3 Jun
 2025 14:25:42 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%5]) with mapi id 15.20.8792.034; Tue, 3 Jun 2025
 14:25:41 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Tejasree Kondoj <ktejasree@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v2 00/25] add CN20K support to cnxk crypto PMD
Thread-Topic: [PATCH v2 00/25] add CN20K support to cnxk crypto PMD
Thread-Index: AQHb1H21KRTO8MfhxkCjhJ0bNoUj0LPxfLAA
Date: Tue, 3 Jun 2025 14:25:41 +0000
Message-ID: <CO6PR18MB44842DA191F792C7153DC7B2D86DA@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250603115026.2664706-1-ktejasree@marvell.com>
In-Reply-To: <20250603115026.2664706-1-ktejasree@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|CO6PR18MB4516:EE_
x-ms-office365-filtering-correlation-id: f1510fb8-3cf7-4869-3724-08dda2aa850f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?93ISRov1/sVGb1uacJ16QnpJETxEubqtJfDo0zmSpZTzHB2pKQ7eLSf/tDJZ?=
 =?us-ascii?Q?Jjp4HR6R3gVo2Iw4+dseQRrLEhTWjWegtxQ5SUsPmx9ztmiq4f4wg94GBc0E?=
 =?us-ascii?Q?BCPXRfr4aYtvVarohJQUp7ZgxSjEeR2Jxrq1bOAjJ8FAnT3lp/WTLo+qfM4U?=
 =?us-ascii?Q?bKUGtyQdLgYyA2ppM20xKIWVbWgUtvS6fgCwOCQvWvSId9620LQLdbCbD9/c?=
 =?us-ascii?Q?I/uJIztzN9TaoIyYCu2XQdwXhbFm1DtASTx0zCRcSPGI01y0Gx36eowrBK1d?=
 =?us-ascii?Q?RIczdF5zJ2qOsw7nof/pUH8b1qvqJKPrX8QYvrnLyjgEzcUlx3CBxFXbo/V4?=
 =?us-ascii?Q?Z3w/l45988f3g4+d/VTFssk/q1aBBC6ef5M+txjcbyL586tOtl5fRZ9wwpgd?=
 =?us-ascii?Q?dJubhSZOTZ0XreO4Yw0wsK+xki1M0ZIbxxBUO6yVbmahNl3lF6/DS2WNp4vY?=
 =?us-ascii?Q?dPrzHyY3w8+B2hRWuVM7yyvN4EoVnePIb3j4FlVKGlfsHdS7XFGAQqrp0Vlt?=
 =?us-ascii?Q?crX+CmoPBFkXSfvL5xfER+S7EQmTxHkCUAiLjA9QPMygki1T3Ta7AfroZ2zs?=
 =?us-ascii?Q?5k20QIupjf8hUUPrI5YaneZDfIgcj5jC6mYfezYtuKvlDbFF6DxA9y4V5ikg?=
 =?us-ascii?Q?2XTx4FMcaMbQeFb1jFI0XETYZFjeEZSZWECIW6hi6CL0xUZ6O/kFXmc7jcBE?=
 =?us-ascii?Q?tMDSHYTpmPiRmhBAil0i1+wxIiWNMVPdKLZodZSdxecmgFFc9JL+njH2kOZk?=
 =?us-ascii?Q?nueDL6SXuNh9OUiiNEIFzao1OZrxLDFprvEZHXYZGX23/pBJJrRSuuBym8MM?=
 =?us-ascii?Q?SEyVDfN1nHdaAF43FQz/Vz8+2rnEUOl5fv/Z7GjV2WhAu6qSD5zWA1MrEu1D?=
 =?us-ascii?Q?HFxTUUkr2KWXUWzYzNFTj5Tbj79HnY5lvW/Ebi42M5J0qeM4O5LAD7D1n1kd?=
 =?us-ascii?Q?sU8FcUF0A5lzk8g5wRRLVaHHUY4I7tT9t0pZ/fOhcmGJDoybAveRzZE4il8a?=
 =?us-ascii?Q?k9wmNcOfQxc+maBdlW9tAvg2+7oB4xSe9C0t6A+nVTHDowcZnYuCsIJHF9Z1?=
 =?us-ascii?Q?fYW3lzTE/HDDmpiD5smuAMTuMaFlZZRM1N/YAwTwEMmIkqvZgkLX4Lsn6t0Y?=
 =?us-ascii?Q?iYWaHmZnjm1wHuUJlbheBa+fSmSTCDzz5D515fuDXT38Ggn938JNDN8yfRwS?=
 =?us-ascii?Q?7weUeXqNHoNuQXI7FJbCWSD/gN+3AuEpiShUS2Lx2oZ3fe2BTkyDo/D2dqlK?=
 =?us-ascii?Q?Pho0LliK4t/zmiBDfFvhztZ3QfgM69V7oklAhaC7q87LLhf2Kqw4WmTW4BK7?=
 =?us-ascii?Q?/kiYA9mlkWkjlZIf4IUHKYSJ4+efqMxowCpuMPxdyGMwUO9jMmnwIINZ6hvs?=
 =?us-ascii?Q?TrdDGg5u9W+XFOp0J1bWNcvXiHCffzkk3WLflCo/AR3gmztZ/eqqSCipM3ru?=
 =?us-ascii?Q?Z6erHOWM8klJiaGd23xgkPZYdAxE8IBUwHDdSKl+XGOQkL7ncxd/GQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?k6KEfEy86+y9anJcCOyJx5fFnwnYhyHThgKyw6ZlqTsWPJdQAwjq45fxyDBr?=
 =?us-ascii?Q?1MOIhDoH+N2K0BBwaoGBZN7wFxJhOZCz5AvShIncFzrnTvlAIWWYhHnahGs0?=
 =?us-ascii?Q?/AtdBe/654SOurIOCjIc7eEwp0Ofn6BqWKcnHeX42TXTH52CiBKCdUQP4nIW?=
 =?us-ascii?Q?xN+CioHw5pzzOUHtm96TTmgZMXWVQg5YjWdNOh1W25+PxvWL2OwtOfzHA0Fk?=
 =?us-ascii?Q?Iwg+TM7Jgguo7ZzAli0sHh90HrbgR/WswxEySxbXuF4avFAp1FR+Z+hd4kJj?=
 =?us-ascii?Q?QlJJOPnCXI6iJ5Cg0HpEMpAjp9QmmXD/90xtNrStty1fd/XpIy7YZ8k3s9Pq?=
 =?us-ascii?Q?NvjxZqtp2kGevM+teg1aNcNXdyakr1TJlGaIeiRoyCuU8lGdo6dVUt3A09mp?=
 =?us-ascii?Q?yPPE12htvplj7mlahnFo5pPJEE2oa0BFx5BshbFeKQ+efBbcBG/qTmX/xSRJ?=
 =?us-ascii?Q?+nVy7qtyy0zRhskwpuHokaTe8SLzNrnNbzKWn7K+sqzgTRfs5qizU04gv5aY?=
 =?us-ascii?Q?f6WpQx7q72OFhpNhoI26u2FjIi/87D7B5vYKXtoiyv3/K9joEJNBKpAEHdJi?=
 =?us-ascii?Q?NAn+iGGhpGzOfeCH7FPi5hD7RGUcISVDqawubm30VaA4nrJFx5s1jeXMBknG?=
 =?us-ascii?Q?JKTs58AWnWeIrkVi4jOw3b2Zxp2ZwHmIH/t/5jVDMo1f3h61mD/pGuRlW+P/?=
 =?us-ascii?Q?+rTcIiR9i/1Cy0rz5zaV0hjQk8l5LIBrfmPxP5CmzwMVQRMnMAIGRYP5FkRt?=
 =?us-ascii?Q?awdxMZOF/ULZaLiM8kMHieALZO/+riz+iqSZIPPZ3fYuOAtiwF2VxkOVOyzd?=
 =?us-ascii?Q?iN6TXlQNWpJ+2ZhzveG3L7x6o/B5YJmxyzBk5hJ9BbgT8m2Ixef5NaYHRMTf?=
 =?us-ascii?Q?4qzVVZlFkr4MigdN6L+TBV67dZQTPk06+RAMgPO3aeOoeJJsdDU03QAlvlL1?=
 =?us-ascii?Q?i5J7QVk04+2I4ULx5qRZBbwTFGKjaLpmCId5KFSUmXU25gMdtE0Gucgq8xCt?=
 =?us-ascii?Q?znsE8K696wnH18n/ni0OqLf5sQKppCKr57YFcd/u9+7vHssZCsUDR9g7oSFI?=
 =?us-ascii?Q?ipCix/rWNfpiYd0tFbTuN50H/buFLkN75pz9RK4TgOXzFI76LQ7tPQHV1Yc4?=
 =?us-ascii?Q?YaFSDJEwT9FmxMmCyt1Hu9Gecja1i1JfH/gDDgK8MAqKsjxkr7kS5r8EJkgA?=
 =?us-ascii?Q?4R/GnokdBKO2V6NVgLM0rwEWDcmtAMImldJIuwXldqhrn10JdGeipKUdUqtw?=
 =?us-ascii?Q?rjWgAAAyoIunsFWM5hc6z48zwA1l8sCTwNuA1h5CNX6y4f9rJ81GjkF+5vUi?=
 =?us-ascii?Q?OxBEb/fD+P9yw6Ltg+o3ib3cMo6zEX5Gi4OvPzk5Scz3jvT8972n8b8EWl0a?=
 =?us-ascii?Q?hR0jMlRzUcbslZYwls5XsXDgSxGGmqfjxNLd/roPGM9MmhxDcOOnGEIaEBGD?=
 =?us-ascii?Q?85GvKx0AE1ALzaKaOrxEQxLxrUxhTXSC8LJLFh7fZMC4XZFxSIXxn0ePjo0k?=
 =?us-ascii?Q?uH7q2zGT9NEEENW8KB3EScZd8cGO7WUPW19BFW9+3fy+GVfIfE8QgQqmfgMi?=
 =?us-ascii?Q?vqUWPx1lt2CAe5vSWuo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1510fb8-3cf7-4869-3724-08dda2aa850f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 14:25:41.6882 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FoxJgiYGRTsWNJp8jqeAZoFI17PUDGodcvJDTjFVQNW/NiC1y8s+KtNxrB9/YYmr6faaMCvtYYnfBCNcVqs6vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB4516
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDEyNSBTYWx0ZWRfX6MinlXWrhza0
 EmEOrJl0Sle6UwoOtZSjrQaVXyEsMvkXpE07x3+D4ilWa5SRgGVsXxWiIGZfGcfrZ3o2neHjTiS
 RA5yT22C+bcAwniut6KzGhmATOfE8iU9fRYLIbQ53JfrJuMVUHrpqYMljejKOG+Srd1X17+3neu
 gG26yovjqDpZJhGyeSU17GHToZ1s+O5UTqUtyWlTde4bXtuouanfV88kvZ6b+FZFjFCRtFY3noB
 K0VczzlcH1uoyERV1q7eUeVEY90LHdvmEIkRXCGDJv042MFzpJ2JS4/NOoxFiCQ/tFzgm5b4EfM
 P1XoAflk7GrxsNadYlxteb73Y2Q/AvO/WxAhbudvtSa23ILUbODrwpo0h2ldYxTU+TtXtiGaCea
 7uj83E9dfOEu4ldqqxJrl3f7AGmUTLwUCZfLLdq8raO1rqDPwxhLCkqjSj3Yf/vXkfFJeITh
X-Proofpoint-ORIG-GUID: 4MkUrJTcp5897tnpfKKTWgIXhHDX5Mwj
X-Authority-Analysis: v=2.4 cv=JpPxrN4C c=1 sm=1 tr=0 ts=683f05e9 cx=c_pps
 a=mNDmJ1XC7hJeB1Yk8AIX0A==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=eerZdWYQDRP0Twnqg_EA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 4MkUrJTcp5897tnpfKKTWgIXhHDX5Mwj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
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

> Subject: [PATCH v2 00/25] add CN20K support to cnxk crypto PMD
>=20
> This series adds CN20K support to cnxk crypto PMD.
>=20
> v2:
> * Fixed individual patch compilation
> * Fixed unnecessary code movement
> * Updated patch titles
> * Added release notes

Series Applied to dpdk-next-crypto
Fixed a checkpatch issue in 6/25.


>=20
> Tejasree Kondoj (3):
>   crypto/cnxk: move debug dumps to common
>   crypto/cnxk: add Rx inject in security lookaside
>   doc: update cn20k CPT documentation
>=20
> Vidya Sagar Velumuri (22):
>   crypto/cnxk: probe cn20k device
>   crypto/cnxk: add cn20k ops skeleton
>   crypto/cnxk: add dev info get
>   crypto/cnxk: add cn20k datapath skeleton
>   crypto/cnxk: add cn20k lmtst routines
>   crypto/cnxk: add cn20k enqueue path
>   crypto/cnxk: add cn20k dequeue path
>   crypto/cnxk: add cn20k security skeletion
>   crypto/cnxk: add security session creation
>   crypto/cnxk: add security session destroy
>   crypto/cnxk: move code to common
>   crypto/cnxk: add IPsec session update
>   crypto/cnxk: add security datapath
>   crypto/cnxk: add TLS skeleton
>   crypto/cnxk: add TLS read session
>   crypto/cnxk: add TLS write session
>   crypto/cnxk: add TLS session destroy
>   crypto/cnxk: add TLS datapath
>   crypto/cnxk: add TLS post process
>   crypto/cnxk: add TLS session update
>   crypto/cnxk: support raw API for cn20k
>   crypto/cnxk: add model check for cn20k
>=20
>  doc/guides/cryptodevs/cnxk.rst                |   26 +-
>  doc/guides/cryptodevs/features/cn20k.ini      |  113 ++
>  doc/guides/rel_notes/release_25_07.rst        |    3 +
>  drivers/common/cnxk/roc_cpt.h                 |    7 +-
>  drivers/common/cnxk/roc_ie_ow_tls.h           |  233 +++
>  drivers/crypto/cnxk/cn10k_cryptodev.c         |   12 +-
>  drivers/crypto/cnxk/cn10k_cryptodev_ops.c     |  125 +-
>  drivers/crypto/cnxk/cn10k_cryptodev_sec.h     |   14 -
>  drivers/crypto/cnxk/cn10k_ipsec.c             |    4 +-
>  drivers/crypto/cnxk/cn10k_tls.c               |    4 +-
>  drivers/crypto/cnxk/cn20k_cryptodev.c         |  158 ++
>  drivers/crypto/cnxk/cn20k_cryptodev.h         |   13 +
>  drivers/crypto/cnxk/cn20k_cryptodev_ops.c     | 1277 +++++++++++++++++
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
>  28 files changed, 4119 insertions(+), 165 deletions(-)
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

