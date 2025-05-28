Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625DCC3ABB2
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 May 2025 12:16:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C05040DFB;
	Wed, 28 May 2025 14:16:36 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id EB37D40669
 for <dev@dpdk.org>; Wed, 28 May 2025 14:16:34 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S5r0Bc021424;
 Wed, 28 May 2025 05:16:33 -0700
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2106.outbound.protection.outlook.com [40.107.212.106])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46wq8218u7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 May 2025 05:16:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dHa0w3kIVdQ/Sf5QtVxIKMJnN8nMkMQLgEbHLQUehH3J96aiHZupK5xgsofk3jAkeYC6EeTZ4a2RPO2sg7iCplN9QfjLTuuo0KRsdzLg69ltpi+/a/0zhRo6AH7smOSzLAbryfslG/DP5Ozg8dkDdI6FOKdQgswSc3OtXH8ytNT+V417/YmBUge6/T0Y5LhG4F0nYaXfyUJW2mM5RFTdaVbUCUQZagE2/lIfCsm+G0YcQomKk6hjfzR/1D8lkmRia3SkVHf/1GUTLQdsEwLkxfh7sewo+GAP41sjO+q0hZ5GYevRqenZAtwWMMD46NXYps3KZPLyQlJr8B/+bnrlRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkL3M7UwDoInKPJhe8HxAnDOIZxo4t1gOTyuOXgu/cU=;
 b=xUzUFFGsSR7eOVkIe4HuKzR5cPt3O8fasNxPS85dbUEVL9gMnkL6EAOTrrmtukSp102JF+cWriJnV1wB+tzLNYu7bpOd9K6vRe+foBDO2qWTONL5/R2p6tVlJFX5Ji5DN4Wcw8kSmey3iQkUNp+f5EA56OAG5ZMhIieL9MBX9owuuA/ww+Ma2tfXEB+NFLO7tgYwtQ8XhYGFJRhM60IsGiI6NZP8/XHKUuALZ+1KiS68YQ/ssZ1BZplUxRRft2RqUo4zVpwk1WzzDp8Bon/yQZBLSd3sip+5TaX+kFNqdboq31Ogga7rYkBW3kjQADDQRqU4IcW2GwNGTJqCKK67Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkL3M7UwDoInKPJhe8HxAnDOIZxo4t1gOTyuOXgu/cU=;
 b=BMxKOAEKhW5NnZSyGtH0W3ZgQx+xKfr4S+jbfP1HVq2x4QaHblojISg19zobMChmrO7PZggBg0GdXGXJpsOxDdqzdfhAIZT0DG0RTR6feyc2q+HFd0mPi9o/TB6uCpgdjieZFGyTeIIMiXzdRDjfJwWfTaCy5G59P/k4sCdDam4=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 DM4PR18MB5196.namprd18.prod.outlook.com (2603:10b6:8:44::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.30; Wed, 28 May 2025 12:16:30 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%4]) with mapi id 15.20.8769.029; Wed, 28 May 2025
 12:16:29 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Gagandeep Singh <g.singh@nxp.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "hemant.agrawal@nxp.com" <hemant.agrawal@nxp.com>
Subject: RE: [EXTERNAL] [PATCH v2 0/9] DPAA2 crypto driver changes
Thread-Topic: [EXTERNAL] [PATCH v2 0/9] DPAA2 crypto driver changes
Thread-Index: AQHbyh2YxAec4GCIRkiBk23vnl1AtrPoACeg
Date: Wed, 28 May 2025 12:16:29 +0000
Message-ID: <CO6PR18MB448464D2488ED48DC5B356EFD867A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250520055133.506071-1-g.singh@nxp.com>
 <20250521065658.857707-1-g.singh@nxp.com>
In-Reply-To: <20250521065658.857707-1-g.singh@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|DM4PR18MB5196:EE_
x-ms-office365-filtering-correlation-id: 6857d00c-e18a-42a7-d856-08dd9de17a20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?zM4YKXpNQpH3Y3Ha7+Dl36Sz6i8jNccwkPYm1Kgzfv3xkGQ7m8lbmHf/pI/y?=
 =?us-ascii?Q?eK8J5sJJJCGATRc4LbMPAceiwI1A58jQtq+9ezbdRccgcHpE5jAD867q2eH/?=
 =?us-ascii?Q?iD3+W1Npx0bn1LiaQZv5L12aguFhXiv9U4QwLRnY4T00FWxB8rIxcg3weFgU?=
 =?us-ascii?Q?RFg5igGugzzJQ/7w/asHRPBslMuoBL31R3U6fx+XZPzdjU5emQmx/wiR41dK?=
 =?us-ascii?Q?V8b9/euAe4ohU/USEKS0F6K5SUOrun819SGGeYOhCH/moxucFwQosFqlx49C?=
 =?us-ascii?Q?6+yOVznpGkgq3LOUN3LSYi700tEwpoWD5fstn/HnQmxMKwd3/E2QAUkuP/zE?=
 =?us-ascii?Q?Vg8+Ijp2G8TcXR/eD0P0iLAsAE0osKuy3leiV1iUVbS3G6rASiPPSVpisan/?=
 =?us-ascii?Q?cphXQqsdwjo14yLAi8Kipeb2vOLvRbFUrWJD6xpKweEq3OKUOvUxQh0z1YbF?=
 =?us-ascii?Q?8iBxxiOzv6bGVnI/ee8M5w0pzt6GIWIJPIkQbOcZQQ7fIsFwBRNNGrvfU9Jf?=
 =?us-ascii?Q?QOvVlswXAuztPWQPlVJuPOILt3lYL1SbbnoTLp3LAzhvxnzK8cyoJwVSqgSE?=
 =?us-ascii?Q?7ub2HQPddTYK/XCOO2lF3d3lee8ZqsK/iGMNRMNJBcYJHb+B36flzx0m/jSI?=
 =?us-ascii?Q?GLY7JyAGwzn1TVaRiprj/3I9+Dlxgpdyu3bkKwWtLeoewYQC/f+TjOuZGtUd?=
 =?us-ascii?Q?vzHuYoYqOlBSA/QwQWNOKPLAn5YhJxaWqJL8Xa5ryCqcIhDuHWIGMkzhiYlq?=
 =?us-ascii?Q?Z703/hpNqIeLcnDaoM6iHFrepFw7/Lan67K3B30doaRUTMd3eYeQCfexuhrC?=
 =?us-ascii?Q?iTeNF8neUQBct6Ski5blrpdaBMYfGqzaEs5w/xE32dVs/7U948io469AVLTK?=
 =?us-ascii?Q?ehanB7mmwDqtF5C5IgqKqe8w69HQ+xwbBm/X4DDPSpUDZ+DEpXHdPON5UBTC?=
 =?us-ascii?Q?kPkBjhc9BHcfnkeLZY8qm7RwVODV9jaSqZha+qdBcJ/oSJncRzIQKuDrCyvb?=
 =?us-ascii?Q?qFN0WDpMnRWk5ZVNfCJU97n9LcSVp8UnNGagILj1i1g3k+omJAP+a8oiyo7j?=
 =?us-ascii?Q?ew49ioxAig1srbQmql6z003N7dwKf5COBRaoTg2KlbWuYg2mI1bgNHUMPu94?=
 =?us-ascii?Q?5osfrlbJmTO+2ayKLaaLAvbUjUliKDcPAhzz5s6bUaCE2DIdct/VCCT8HvCU?=
 =?us-ascii?Q?Jo3qvZRIEnpz1H6kcRIa1zEflYxEnY7yh5QygyoSroRaDI/vrmP1icFrNZH/?=
 =?us-ascii?Q?y5AERVRt3QMKjUBdGZDQWImsijf8gHSNLMSiPcxzQaxX1SdSkUgnILfHeLoN?=
 =?us-ascii?Q?sXBV1Gw4qYiMXlyL6neFxBKaM+HqWy241HHJiAlvnj0xMBw0nqVhGJ26LxNj?=
 =?us-ascii?Q?grbfxDVz84lK94AToMb3ygm9PfrA40YVUq78gxMTq3NV3QHyTxGRYWQAiCCP?=
 =?us-ascii?Q?lOut51TSXv+RGLXxcE22sqgeoGe3XZ2Y2VrblhHfkURcr0IsCaawKA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?44nkRxnf6PpXgygfBJk/vZLjv2VsVf3seTD5RolGxEizl9gnqDVRQMqPeiEs?=
 =?us-ascii?Q?ZyJf7EoBsjw2NpVxlyN8HurNuS9vcFbexBNDCSmNDCMnUQ/0MAlP/JzPW46s?=
 =?us-ascii?Q?CMMxoQjVJS52ldaVk5pm1EmgqqSlFpB3S8ASHkDRXNCTxp7oC+3heZoEoXTR?=
 =?us-ascii?Q?XcOE7+S7n1xGCz/nFJ5WRm9eFeuPvoBErePPX7GrIS14obYtGa+KQRvspx8T?=
 =?us-ascii?Q?6a7Xwlpb4kZzAuSUfDWOmaUQ1N2PrWgtet/vQt8GhI3hb7dnvoKdI0XacC44?=
 =?us-ascii?Q?gGyY8gzYIRBe9A92cveyjXn1vtoyF4q8hZNCUOckCDQXQt9TAf4T3DcZBafF?=
 =?us-ascii?Q?hXDdeFLEdsy3LIdla6BVA0LARl8ybk0JaAZV/2035srwyGOxb5swhKNjQYe0?=
 =?us-ascii?Q?mkkm6CVJGCzNZP3Q8VyUy1LFrYK1QadVHCjFp5aRTykYdGn46aQORMyVvYUU?=
 =?us-ascii?Q?ZQUrUH/PXdrZH8/OkezfpQzJTNF1gtVfzmqy9RvjUv2rngcRLxk65cKH2MT0?=
 =?us-ascii?Q?+dPrYYC7bQMcPQQUnoldYEN2tD+hH7qDhD6RDk3AnHm0I/0nbYjPDvkakARi?=
 =?us-ascii?Q?xMrty4xcF9Ze2ho/bCOuVsNlFsc7DExtwWbgRDJ0yJEgB6C7ck24Im/6CC91?=
 =?us-ascii?Q?JdGkABZjSwBWDbNp5Rupi4rGG7zXismWV5U0+7LuqcI+dHprWjlWY/0dtrid?=
 =?us-ascii?Q?xufpqvbOtf+ByAUaAatZJbzYN7G8Twrxe6w7AHqvXlEJDx3YZZTQjPnRYN+S?=
 =?us-ascii?Q?qses92FtrIR2iNJdmgFxFqnZXzr4kCgqQqpclXoUIGKgVAkNp3bApE8GW+gQ?=
 =?us-ascii?Q?UoPxCZn1QqtODXrWNlGrzsR2zubOjX8WnBGEqUq31mJh7wZ8LDW+GkbUHsKs?=
 =?us-ascii?Q?AbuEGcUn+kgdTlDMT4tiYwBaG+0Ng2kdxRE3YKQqye7uo4JF417ju6d0OOu7?=
 =?us-ascii?Q?NfNyc4E0z0bzfmzPcaxNsjD13m36/w8XOSrozSsxxV3SnMkgHhCjJXikAxV/?=
 =?us-ascii?Q?E0x/WWW81Keh6Ge1u0rMb4zhtUwXyLMIG7mjeDpaqXmF2L1BVFHiiTHQW31L?=
 =?us-ascii?Q?fKbGfUMBb2d0p0X2+MVYvVCyDNsffSqIleVlqSn1Vz4FNv3T5F9M1yF9VHtU?=
 =?us-ascii?Q?IqgyQ/ncOL+NlYh0ATXa8jnnC3tMBjeM4Y1VTQ3wJUZk/udev2I2Qz9wyjYQ?=
 =?us-ascii?Q?Kg3dys/o141++VRIxQNXQMjDgD4sgYsiwE6WfXyqek1kQzxz22DMbT0Jod4Y?=
 =?us-ascii?Q?Aw/5UBxGp/c4k5V+DsqkxHeBP2YMsSyqeMbm2UMai7xYa2QY9sWmTIm6wFSD?=
 =?us-ascii?Q?/Qh9KTQuM4uOQtQ62RBDBhS6ZBqSgKfpYiAfkVdU8eafYP/28QcndJ5wTpSI?=
 =?us-ascii?Q?L7v3bRv7p1SClJfJKz1Od+LeRXFYffZlDLq8VlUzIVHJyoKgjhFYAmewFtES?=
 =?us-ascii?Q?TpdLU9oWvmE7CEszl7ULZapciOin3SRrBtWRqqxj+3x9V5RsahR5Vcm1OYC9?=
 =?us-ascii?Q?kWLshai5uRJWwv15M2kvCv5gMgu8qrth2xuExJFoG5B11dkiJRg2gWnh/jFi?=
 =?us-ascii?Q?jwz2udgh8rr74nXNYOO0xB9CR4rc7iVF8ECaO0/B?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6857d00c-e18a-42a7-d856-08dd9de17a20
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 12:16:29.8154 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6ehaTxfH+NWlJATVwfzYis/ms+bHuDWkl1stTr0/qmxhCm6O5C594Wtua1Rq1BTz8JNe5QfnwJKiakiKH4Y+VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB5196
X-Proofpoint-ORIG-GUID: SGIUHn-aTGRggFrsGW9CFFsqeMhomezP
X-Authority-Analysis: v=2.4 cv=EfnIQOmC c=1 sm=1 tr=0 ts=6836fea1 cx=c_pps
 a=b1Xu4tulDBGmpFzVk7b7Ig==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=OZEAiN6XDWF5s1rhQg8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDEwNiBTYWx0ZWRfX8Q6idf/RY2XG
 7E/Fl/G7UD7j0A4jklyE9jOo9PJH/t42jtfiynMxQ1ms4uRIzErmSJgUtChGztGJYcOfd1FX2sO
 8xhbwX0dgx1MvFjJmbmdvoNLNkNTVOUSu7s1neUMzznqgeuvL/v25MdZSunW/iebnE7RlYbKTCf
 o84p1V7duPxhM5+8c6uf57b2O3y8lRhIOaqikjzFwHgsOYk+raLmB6j5AYJLv8OiDBc0mhnJ5jG
 7g0plcRpK10NDxp+9lrkhkDPwCNwgCql6Dw6PiAB5qiYVwurF/0hra0GhPrP0b08WEaRmv15pJ2
 XiR9TxF157bvyZ/hHuy8chS/wLqDm5xgl2EomvhH7o79TNkDnq49kLvESSNAPSnUr3/704EUyn2
 8czxK77TeDaDQlsM3TKXluYCiAQs7O+R8nRm3rgAOTLnGiK6iNGGt9dfmwCFZYDJma/B7h3b
X-Proofpoint-GUID: SGIUHn-aTGRggFrsGW9CFFsqeMhomezP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_06,2025-05-27_01,2025-03-28_01
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

> V2 changes:
>  - fix checkpatch warning
>  - fix 32 bit compilation error
>  - fix a commit message
>  - update document
>=20
> Gagandeep Singh (5):
>   common/dpaax: fix invalid key command error
>   common/dpaax: fix for PDCP AES only 12bit SN case
>   common/dpaax: support 12bit SN in pdcp uplane
>   crypto/dpaa2_sec: change custom device API to standard
>   crypto/dpaa2_sec: add null algo capability
>=20
> Jun Yang (3):
>   net/dpaa2: configure buffer layout
>   mempool/dpaa2: mempool operation index
>   crypto/dpaa2_sec: add support for simple IPsec FD
>=20


> Vanshika Shukla (1):
>   crypto/dpaa2_sec: fix coverity Issues
Patch title updated for this as Coverity issue number was missing

Series applied to dpdk-next-crypto
Thanks.


>=20
>  doc/guides/cryptodevs/dpaa2_sec.rst          |   2 +
>  doc/guides/cryptodevs/features/dpaa2_sec.ini |   2 +
>  drivers/bus/fslmc/portal/dpaa2_hw_pvt.h      |  10 +
>  drivers/common/dpaax/caamflib/desc/pdcp.h    |  31 +++-
>  drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c  | 182 ++++++++++++-------
>  drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h    |  45 ++++-
>  drivers/crypto/dpaa2_sec/meson.build         |   3 +-
>  drivers/crypto/dpaa_sec/dpaa_sec.c           |  42 ++---
>  drivers/mempool/dpaa2/dpaa2_hw_mempool.c     |  20 +-
>  drivers/mempool/dpaa2/dpaa2_hw_mempool.h     |   5 +-
>  drivers/net/dpaa2/base/dpaa2_hw_dpni.c       |  18 +-
>  drivers/net/dpaa2/base/dpaa2_hw_dpni_annot.h |   6 +
>  drivers/net/dpaa2/dpaa2_ethdev.h             |   6 +-
>  13 files changed, 263 insertions(+), 109 deletions(-)
>=20
> --
> 2.25.1

