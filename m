Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF99FC282CD
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Mar 2025 20:28:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D7E02402D1;
	Sun,  2 Mar 2025 21:28:24 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 2A80840041
 for <dev@dpdk.org>; Sun,  2 Mar 2025 21:28:23 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 522KNPOU027765
 for <dev@dpdk.org>; Sun, 2 Mar 2025 12:28:22 -0800
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4540fua501-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Sun, 02 Mar 2025 12:28:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jgdcxzg30PJRhGn2HbGcUmih8N33LC1WKrAERgNatNy3KnJBTJGInpttdd86nHz6cFZgsjNwEPs7eTOp5n8BhFB9QOQx3aA0phILxYinBtjbvCUYvkPdaJ5pq9Ev9q3xa0DfPI12PUTzJFGHOYzu/QrnfZcuxiRbr2dMAh9atxUDAJIlp2PNNgkAE5iphoF3K+dt2S81b/hEou2ZDo6Qkkg1bIDPMBdII3JzYn2oczcRhjVsUbz7fer/O29koP148wWNKKq/PvDPs4uqB34Zf2RRtBwKwqOVbCP7pMjPBFA1RasAZ4M04v0D6Ig6VVqVTN2WJXtr/H2g9A7939i/vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKbeaI5iDDRPl9Bvuas9274yxSFcDZDw8Ysr1re69yM=;
 b=Y1NUaBanj9LFTAQzc0m3g8sY856Kr0ySdvrf863N66xjUsj4bBbEfBDriEHyqLA9QcutzAA7/7TKXJmeDq52KfEKv8PRCSw/gjUNvRfTokepHk49IURVFMPP1oCMEevGHGaD6fgB/PKk/Vds/si3ndm4CwmT3XugbPz0oNet7rTBblGp+Eym4dgufDYC0FSet/mhqD2TTN8vIqNYgPYNpYDmAn/YqqzV12Pdb3IZoQhz3BF7nFT2Us+II18JQERtINcsSQzETHKbmBrsdd1wEzOUyzdz3Cqgxu77kKMjtN72qimglHzn83zY3kbdBzWUNKjVdF0OsnaUiMkvZJ7VPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKbeaI5iDDRPl9Bvuas9274yxSFcDZDw8Ysr1re69yM=;
 b=XBnLG0RXsjd9uyOLxiKpDHJjDBRsT6uM+tk48CFugATA0BMkSscok6l44/eQc5r9FXebFC+9xQxho6GFXWwC7PXchwyR9jGp4zDNr+BRHQQzppdeHh5Q4AgfBAGQpEqRLVLfpYTnHWmM9QIN1n9rFOtz1dXz9BjI+diYMJXzQl8=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 DM4PR18MB5525.namprd18.prod.outlook.com (2603:10b6:8:17d::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.25; Sun, 2 Mar 2025 20:28:17 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%3]) with mapi id 15.20.8489.025; Sun, 2 Mar 2025
 20:28:17 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>, Ankur Dwivedi <adwivedi@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Tejasree Kondoj <ktejasree@marvell.com>, Gowrishankar
 Muthukrishnan <gmuthukrishn@marvell.com>
CC: "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] crypto/cnxk: fix status code in asymmetric operation
Thread-Topic: [PATCH] crypto/cnxk: fix status code in asymmetric operation
Thread-Index: AQHbgH6cGsYIqOA/8UmN7A81A24BVLNgYhLg
Date: Sun, 2 Mar 2025 20:28:17 +0000
Message-ID: <CO6PR18MB44845406026ECD5B62EB11F2D8CE2@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250216142510.1467-1-gmuthukrishn@marvell.com>
In-Reply-To: <20250216142510.1467-1-gmuthukrishn@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|DM4PR18MB5525:EE_
x-ms-office365-filtering-correlation-id: 7c791252-b921-4d2f-632d-08dd59c8c3f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?oeGU7KMKEz/Ip6N6WywyHe2S2T5oSfvLOye+7Y+F7+yI9Jbc+UhooMoOSGTU?=
 =?us-ascii?Q?Vx5yPrJX5yCS8TVgIDgnYwihhvVy4YZLNs85rn889pTuXeucwOfZIXQbmyQe?=
 =?us-ascii?Q?YrE29eI06lhBJyYJCEO5Qoq1tnRzuiuYDF18kn/hVhObPvICPhRfYeocabZq?=
 =?us-ascii?Q?W3gWrE4+vxoJGSJadHwCSR5fI1Dl8IOk2J+tB+wdwt766/kQ1WIOq5vcj+C5?=
 =?us-ascii?Q?IvRIOeuOWsWy9obG90Ck6HrPHXYUnGYf+yE68rmUACB0LxZXnAVf/28Fq1Ae?=
 =?us-ascii?Q?giv1ZwDw6vFuJXlM4L3n0O1WGkXoQb3H50RnGk/f2wx9pP0ruH8MgK21WEUN?=
 =?us-ascii?Q?K70dWim/GbYdTnrjTFwi3hmnvqTtuz3VeJR8Pu119IHj884q3Ud/HRdr6f+O?=
 =?us-ascii?Q?iyPXvlN0SXmn0dd1ny1WkCPPaL1EJAqE8pjJsQBC0BBTxKka9hwzpdKsDy9a?=
 =?us-ascii?Q?rgAXtIW60miQXycvQRgSadOo2Kpg+LVq2gqoQlIAr+XbHvq+YQILjDfVxfCF?=
 =?us-ascii?Q?vfxoGecLlSnQRFg+N4+P6my9lRZHorWM8TwbYJ1hrdKjPcK9OpQSfvl+uykG?=
 =?us-ascii?Q?u0EjoX7UYZI0p3VepTA7D6yZ54JUQRGd/px7prDG4zHQq4PTxMfBDvtmmqto?=
 =?us-ascii?Q?GgncHY0vCJ+3mtVcLs5JH+uyIVG2h80hXLkLL+wBL9N5EQ4b3htw2sEsh5Vx?=
 =?us-ascii?Q?oGYTqHbiwcCNFn8w+RZRifTaN90y9R1pEDEdD8bswTQZMxarig+v1/KhXaXQ?=
 =?us-ascii?Q?ibR7ThafbakE56hFBz4QdIyL6rgKhCWGb5pFx5re8h13maCCvkBJCRpQm18+?=
 =?us-ascii?Q?D23pfqYxP+GHYHFes5NYrw7Dl3zOCYftfm/QcLwP2/N2Amz1r7gRBxLIRNN2?=
 =?us-ascii?Q?TA2ObS5d4Pe3bjv/buUuHtMNMNhhoAvXRzNxPZCRIBu++FqxZFx7xqYBXh9v?=
 =?us-ascii?Q?UH/br5mVYjgTu2divLtJxoSUdWfR/eBevrFwF432pfIO+wn8Qx6/kDuB0wyn?=
 =?us-ascii?Q?AfGaJul3ZiwUDGgF6Far9vT2jGhhN//b6Dk7tn8toVuhFVpbAv2mAYv15RJ3?=
 =?us-ascii?Q?NM3GcLADgEvqzlUezChrzaPLwzNZfYIISNr4vrhlqBoQ2d6F+0hXNda/cAg7?=
 =?us-ascii?Q?EBgLqyGVICxok0uwC52Jcx81EtGQ+p7PsACU8CLI/Es/c1QuUfyrJPBjnArd?=
 =?us-ascii?Q?mWBQmfgKLq3DRIUJgkErV65pMgZthkgaxpxP4U8H+lso82/v9bOo+Munwq0L?=
 =?us-ascii?Q?2UyL5jHwPiNH6WtYzv8cGmFstAHQ4cTi5OvAPHwUPesQzEWN4q3jfsHHBlze?=
 =?us-ascii?Q?LbbwfG4x/r6HlqlgGRiiZegnhpkSY9kKzoKivcyBUbXBs/rPLxGZJzq5XuPU?=
 =?us-ascii?Q?94NZcfkg7IK52wk+kxMp8ckd/XO/e+jEfkRWqF/Ibp60On69Hse3tWfHY2wg?=
 =?us-ascii?Q?xFojKlCDI4HZprn6pY1OML73BOqBHpwn?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7/sEto+B1pn9VYuDgA6soxzNfeyQ8yctKeZoFqwN9pJCY4Rj0hTRyB0Q+rii?=
 =?us-ascii?Q?HRik1styBEHvEJ+5de7ExF7A7rGy6vyOfudCkYYcDbX0qZ4YzX7m5N5IWzDf?=
 =?us-ascii?Q?1ay/mAL322Q+G1w1OFTLOwMTR4khHh7tpMX18SjHUmbywSjvxnz4IuQ4J+ba?=
 =?us-ascii?Q?HKhYcNsDn1P2NAYK2Bwevi56BkrMupJQ6Spkz2u5aDlYUQ4yREgRaX1YCmYZ?=
 =?us-ascii?Q?mVSORcS9QjPj3ZNtyPPS0ScPmzo8h7NlEqzNkLwGMdut0eWvIjuJ5zFgWp48?=
 =?us-ascii?Q?WGPxbN5AFDBRZjn55tjZ32fHUTY6ffL2hGVF/5NXGUhHsO6Gc+HRLc0uXhWL?=
 =?us-ascii?Q?Dxm/uR+Lee1q+KIId+Cet0o46b/pCp8sJuCEWc3WlhQG5dJIDnud6LgzDT7J?=
 =?us-ascii?Q?2IGJhTP1fLVFa38H0DWxiYRr6oCpYjxzPCVJPfXoGReSpDorIUKhgEktWik4?=
 =?us-ascii?Q?yhackSruN17g6ce+Vf6WNgWm/HRZNVZeFFDBE05zFzR0D0J1Au2SpE/BZa22?=
 =?us-ascii?Q?euYgoLvIN4kXtwQmso7ArLCkSGcvCzDQlwPJ2a6L5/PwWO5jIaYLgkkVFgQx?=
 =?us-ascii?Q?RedaN63yRDHiea71GmmblqzxEAAu8dq8vlIQd983stX4slG3kh02/IRxzwWF?=
 =?us-ascii?Q?2p6nCcU/hlg8KUPVohT5FbcW0eMj9HH+dfhsMGy/kcNUDSb+7Xj4wSpurmod?=
 =?us-ascii?Q?+VU5BAIN+86/7SAH2v1QALid/V0ad3DKMrxZcJBABYkEkCUNbRCX5gZdZU2O?=
 =?us-ascii?Q?sslEJtyd6Iyn9Gxsrph64NFPwsH81Lu6rfj96FGfZc4hh/y+i1rwTYGn4laA?=
 =?us-ascii?Q?osJxK/RYxWm1aNq+qu+TBkoB8VPXKpOFTYXd3PMSv5Ac/Brw9GeSNaMRktH3?=
 =?us-ascii?Q?W9wRrdjjD2PW+Wj7OejiKbSKXJMHUuJSBvk3PrAR/vJV5olkax8rPJf2S+Y4?=
 =?us-ascii?Q?TVS1cFHIklr6XFXHnrBXIpwppvtkpaZU5+cnf44FYPytVmL3BezuIfwU3Ios?=
 =?us-ascii?Q?P661Teg6Zxow1h3OVKDvh2yKLHuAr8Wgdj47yYuydm01DKX1UwyX2hN0q9rM?=
 =?us-ascii?Q?mlJAhBZIxH8COExcxToR0v/9r4t7IFNSf6tsRr1zSR/YPGfssSOkQcxVahmR?=
 =?us-ascii?Q?Bj6ZGdLkMKUdDKGebC34l8Tf71OIXjUgb2hNs9xmlSGe1JIn846z3+dusZe6?=
 =?us-ascii?Q?qJUPiGHF4Sv3RYoe/MYj1vt8TEAK8D9MwdKWzz+LcGX/km9mcr5ryfDstnMz?=
 =?us-ascii?Q?OdveGMgvmTjrJmWfXUpZMJIAx0xandEdhVyaCp+UpEh7yqRI1imtpn83GgQU?=
 =?us-ascii?Q?+KMvgxFr2Ke2Q6qkq/7DB88v449Lc1i1UXjClg+sQSbXjXiLt8YkWrC7OMCM?=
 =?us-ascii?Q?L/S7axj23v1UXhrYo3ps+ltvvE4XOCUHZuoZJrdqnUULi8g0lDWFHDRMNKnw?=
 =?us-ascii?Q?6+HrDJBV3QmlNBzwlOi6grdX3crYhJ1nyJDN92wCNbgxouiZvsmo14MQUsH1?=
 =?us-ascii?Q?w9Vh4+qTyI1Wmw9Ba6TAxkybVINrs27SjvZnXK3AHr5In1Fun6Hgng4pdLHn?=
 =?us-ascii?Q?8i0U6mwjgZm0Y+vz5c1Z9A5BZSBtUpNZtt3pU/cb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c791252-b921-4d2f-632d-08dd59c8c3f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2025 20:28:17.2145 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ifdOHlBKK0CRV78p4SmyyRxyyS0YXS06vbsq33oh3Z6S54wjglbkuKkZGmqLXM9b5h5gvSqAltZYjO0JTJETLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB5525
X-Proofpoint-GUID: 7hbRQmtHGLWZs5-uIFPgLSocGI-6KcBo
X-Authority-Analysis: v=2.4 cv=e5P8Sbp/ c=1 sm=1 tr=0 ts=67c4bf66 cx=c_pps
 a=19K1aDEwnJ0RahI1emVHDw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Vs1iUdzkB0EA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=kLrOsOkbUJU4rg6zP8YA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-ORIG-GUID: 7hbRQmtHGLWZs5-uIFPgLSocGI-6KcBo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-02_06,2025-02-28_01,2024-11-22_01
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

> Subject: [PATCH] crypto/cnxk: fix status code in asymmetric operation
>=20
> Return error code in an asymmetric operation status
> when none of the known conditions met.
>=20
> Fixes: d29c4e0a4bea ("crypto/cnxk: fix ECDH public key verification")
>=20
> Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
> ---
Applied to dpdk-next-crypto
Cc: stable@dpdk.org

