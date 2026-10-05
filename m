Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA45CA5FF0
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 18:38:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01A3F402DD;
	Mon,  5 Oct 2026 20:38:02 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 2095D402B5
 for <dev@dpdk.org>; Mon,  5 Oct 2026 20:37:59 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HNvn71191068; Mon, 5 Oct 2026 11:37:59 -0700
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023110.outbound.protection.outlook.com
 [40.107.201.110])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4h4983t9pq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2026 11:37:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KyBDo1xC1ovmJ1iIpFrqQKri4zuzib8ckQAJtaXHiCdJv73JvfoYqrlXwsuTPzJ5+n+MdCtAjryjNWSNnVjejV1npJ8rKgfN7dTkBehlcmbSF3WBvVLpr+7YYH0S5Tg2+Q6HdO0t0k6nBGrG7l9MCn8rZzjfbbh4vZP4Pqh7AFVEeFMZVYZ+HarWKDyBK0ndl5iInXVwNBC1CgFkZLWgd4mbXJVDkDmOCEwgX+LH62urGk8V9s2o0jc5jUlGjqbQHDHKa/7GevKS63GlstB0bdjcgM+PsRB+jx/iIYM6dX0uitGBNV7WpArgjknH7cE3e3KQneIHz7jTX9Bci/3Gyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lj9413jHceZDvN7ETVuVcd5NUibx5wIweoMUJj0lel4=;
 b=ZjgNVVzbLPbMXwJH1eePHCgwblJBN+C5dlsqeN0QwfrE2MAnLb6lMUlxfajVRqDTCEvy1hItDxa1B/adcTCkBdO+35Ptl0HMQvsTRFoG6K11kbJbmx3CPlUlTAHtKGzevDdcrWbMDbrY3lesqZv4wk5/LH47G8WJuDXoyaW08Nw/YyCOAj4NGlZMpgmaPoVGsp9jYHpHik7MCnr9KBtKR7aE26rcse//ebWedPAO5QPH09gyTBzF0KeZUXhsumBkBSpcHsl6y6A4zCcDJaAUqBE6wutYD50/t8LAPg2KdSNII+AvV+qDAzaIue57uOP7fPPzFL9SewZwVwAGzQfTlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lj9413jHceZDvN7ETVuVcd5NUibx5wIweoMUJj0lel4=;
 b=J3Dg6eG6zuJ57Qkw4PpcrHl2zHO0ARpv4I+g+JSSRd61Y93NbwC+2v6GPO+j5vLbB7Qoimpf7ryAYVFseUmWTJIkB24OaWArOnsm9iJqARDDE/e+PK1fanyz5q1OcXqiu/ucleNE15wxjezhy6apojnoXtySW6IfdcyQkp5olnk=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 SA1PR18MB4790.namprd18.prod.outlook.com (2603:10b6:806:1dd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 18:37:55 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%5]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 18:37:55 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Gagandeep Singh <g.singh@nxp.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "hemant.agrawal@nxp.com" <hemant.agrawal@nxp.com>, Stephen Hemminger
 <stephen@networkplumber.org>
Subject: RE: [EXTERNAL] [PATCH v2 5/6] crypto/dpaa2_sec: add support for env
 variables
Thread-Topic: [EXTERNAL] [PATCH v2 5/6] crypto/dpaa2_sec: add support for env
 variables
Thread-Index: AQHdUKp7sjPsjtqL+Uq7HIho6RyBULbvTtMA
Date: Mon, 5 Oct 2026 18:37:55 +0000
Message-ID: <CO6PR18MB4484B210020584C2AF24137ED8962@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260810112951.2879825-1-g.singh@nxp.com>
 <20260930070809.1929564-1-g.singh@nxp.com>
 <20260930070809.1929564-6-g.singh@nxp.com>
In-Reply-To: <20260930070809.1929564-6-g.singh@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|SA1PR18MB4790:EE_
x-ms-office365-filtering-correlation-id: 72ae8452-bcfd-47d2-1710-08df230fc576
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|10067099003|56012099006|4143699003|11063799006|6133799003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: j+f7+z3eKHrzWziwFYLHpj22ZTxzMTUVtceP0ys0QfeIXN9Z4ipqJXppMwuRpe9lwN1ile7Sy8LLJ8N7JVBfWCcSoNMEjEBBZzaIO8QKTnwsf+t3iDNj3+ru0C22cDvQGGsoL4AJuLklpCJT2NqmKNlqIWGWR/1tDNalIpVTrHEM6PWwWn+TI8yOa0YKFyXEpS4GlvHYJ6CqzLVSLxvl5G37SU9o65eiJzRkbh7few0H8qHFcvYvV00YYyjQo65cP4hxZWmpgNLcb1CLQeGzo1Apst9O3K6MBPL7iWRtlbUfp8dUsRGZlyJRzwLtBQYKL67wRVPMKuWxudGf8UXf87kYn+qnlJXeTOYqFwF78mV6c+Po0Gu9aB6Mf/aTvoL725lyTUhKZdSueypVnbUvG7wosQ1Nw98wgYgrOVRghj4D/hxNwol/VusWW/G1NgKb8GJlUvXIfpMvr/6u9xaySxJiELveaLOnBFjyArjQ33tZL7PPiQ9t9rC3sidGO7yJrKCi2k1rrMnXpYZCaL91NczPkYfrjCyPBMdX/hmToQVpewRUvaTAcrYv4AIk+weEFszg+NQkiIMV3iUwhKW1SenSQDFUNG6+hB9Wrj08G+OB+/G2rDhTCA96oiVN4pWRvUk9fUmJPI7NKmlQtxORfM2OYQnsvJnQJelZoKPBvNcD9uq40KqMvW7wWXcJmwh0b6zBpBGcpu7sUuXmMUM4Wzo0zHqq62jGywbRirnSR9w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(56012099006)(4143699003)(11063799006)(6133799003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6YJXDmHs7Jsb6+jJiOfawkc8Ipm8iv5orJtazMQICl4b2RznlPyIkr5wnq/q?=
 =?us-ascii?Q?34gt7WvS49QTZ7bFSY+fWDJLw1F+N7Z17VFh6frrCNnVW5xwpCzMNwHJwvy6?=
 =?us-ascii?Q?8FJrWsCRbhjxtAYEKrvUetgiKtFcEDmMpwYa0s6V4Ix8YkBxZgyRSnu6Oc8p?=
 =?us-ascii?Q?h7b+0IS1kky5T1q/yN80IsWjlQtntNoLsc1geHQZT6Q1B2fynUsztDQYDifz?=
 =?us-ascii?Q?vx7f983Bb4h54Q5DYX2ErqdKoTJI++GpaWT2WXTCCGMbXkSuHmapYQlA2W4a?=
 =?us-ascii?Q?yjc5V/t6qcFuXQWQZWVJ1FnxNJo6Vr2Q02P3L5Cm8LE3UTFKzCxx3LPY5QP+?=
 =?us-ascii?Q?lnNb3TakjxOtWA2Ojm4qSvyiVGRdrOpaEkC2v4GKeLIcavUUuE9gu9b6EkB+?=
 =?us-ascii?Q?sPZ9yZv7FhpH40IK+E9qIIxIBCkNJP9E6B2jF7ryxchU+qc9UmeYWFEAzo0p?=
 =?us-ascii?Q?wPay6v6tQzCfWegoqdxE/UcwEeDm+50wWZgByth3DvTh0oTGKlAkXFWUP4F6?=
 =?us-ascii?Q?+DQmKTIq6H9XLEIL6Q1afaidpDCpRsdaD37pFDBI1o/bylNCbJu30e2ITqJw?=
 =?us-ascii?Q?C6wb90YptlMi0DNUdCc8Hh82A5U0El2/KTtd0Ylv5bLZ/Yleb0Z2USiOQj8p?=
 =?us-ascii?Q?cbLa8OlPOAGZzNSRMvSgQHRtXvJqT6W5KRzY8Iltm7rGza0KdFauqFhDUesz?=
 =?us-ascii?Q?IR7g4nlQRpwTOYfmGd0F9B8fp1A0sD02QRVBTZtxR2PJTcHgqdX3fwxy/cfJ?=
 =?us-ascii?Q?5ws1lUelDYUnUYnuCFQlpCqKuVCdlYM641OXv1YZ3ssM3h+SOea/m2rKNb0Q?=
 =?us-ascii?Q?ILv02jPEfEiVpobZ6xQmwTonmotcpSnY2k1JKeRciItAGjUjzjY4oTno9t22?=
 =?us-ascii?Q?3mIHw3DJSNEjwXcNsq8k2sIcrCQm3E63uItNIkzatbeEtqe0kdbyrIpTeMsc?=
 =?us-ascii?Q?hp6x8MK3DFQAMK1mMezG8CcXa8Q9gP1UVtOmDwNRzq4joIOAwlCB57eOiver?=
 =?us-ascii?Q?+Yydto9rYsUO0BIzHtiQGJ2lZkPD3Fnc0V5FwcmLxX8as9Zpb7CrmsmE1Z/A?=
 =?us-ascii?Q?BcAA4ZmHagw6tRdVjFDUSTAZgdeGO0WXAQsOsXx8SHeqBSjEXOLBdQnyPmNa?=
 =?us-ascii?Q?t7toHxDrBCQ5CPFAUCXS7OkpPQPs4jrHBWAXnyxboFN7snEIhi26+PRzkXc2?=
 =?us-ascii?Q?jmRThAOgLGcIpmArU4VYf+YWSJrbIZ+/oYS1SaGTmXtPw3ieK95z/8QDNVY+?=
 =?us-ascii?Q?0FbQOCOkC4CM262EopxKaChPjRE/mWIqha6KqBJ2FTsvLTYT8+mp2tiX4OgK?=
 =?us-ascii?Q?MSj/0lGgHSNzpEpgCRo4P59yobNXqV3i8LZ7oNS/59jILF66aE/L+oBydeQp?=
 =?us-ascii?Q?TOT6K0eIhWk9Mze5G9WINwlYVjGc7QWMQDpADKl7iOu5Z8Gqod+yEwGKMlPy?=
 =?us-ascii?Q?EpNiHjYl7vay38JifDr7pxHQMO6YsPV4G+6g1qvBtdz1u+2VU8bynYmVsrw5?=
 =?us-ascii?Q?N7sCje4nvo1VMCwbQuC+0QIhIjTZwDaELcpepb9yO1TbJnioBFZ40ckeQLW3?=
 =?us-ascii?Q?gvTsow/omJ56LGEwqhks+fFC9QvguRsxKIdbGiKjMQCO55JlKYgDlLQuq+L+?=
 =?us-ascii?Q?ffxoSyM3n3tl8V8u82Zgun6aDvjC2R42LugBQ4kD65IwCIdpWW9lZDNBXuTi?=
 =?us-ascii?Q?+Yse2sZQrvqMlMxeEzgmmvqtrSvmmGcSRtY7QT6mYbi/R+wB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pNB1d9HMy/XahTB8+oNXWgmYTatj+qX3e0h04kurrZbnVMhg7ZUeFLxONsilDpGXi9qIDvhVZxbJM3RX4fR4Q1M3Kex6zz81ySiKo4SU3GfNK2MYtZiGnX3mMGUZ8xit6RhscFN6TrHQ3rdehTLSJK2ft8jOVkbb9rYpi3qqP9QLUbcq67GTQj3vMi2jjyjr+pja1jfZ9lzmsftOOafozLpm8xSDe+o1J0FSkUpYh11BjmjvMJR7OjnuBzXzg/k9jUYktugooRTyjI8cX20FGoS7DleEtLQokIgk9bhIkZ3vzZ0UQzln7wPPsGRARqz7ov9ivfqgeG9Bchm1T8UFkg==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ae8452-bcfd-47d2-1710-08df230fc576
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 18:37:55.3729 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h2BPEw8GYe8HJjUJtUsdxSxxYP6VO2YHP4EgfK3sWcRr2VVv9W0vlazRE14bAU4qpzLQjFRJ5jrD/2qDSrYEmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB4790
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA3MyBTYWx0ZWRfX5hOKh7M0vkT1
 lv4WEAs0dE4u+Kz9EVJnZCmVnRf0QPTjCkPo1cgSh/liSAQaGA+7M7+2BWawjLlxaE5UjVZXoGS
 s7hV6fCgyKe+joYppGp6K7kuaPI5n9O0HWsFbVjM20Ng5fVh/jZorDa6/sTrHcZrK3qRYlOGKCK
 uJxJ06l3hbznbiAlVNEdl0Vsfh4sPUZu6FL2zywdo8KskYI1Boz4fjq9XyoB2ZU/BK/kG4XpgnN
 msCDDmmB4Z91iZBASCPfr4MxsxM/SwwEB+P2eP1XzzSAf2v4EFmNsNGWeXVEWR8me6mB52zoPnZ
 QyN/8yDQOA/mWm9UR4+qiXEHVLoswdk0X8plwyg9/Y0U8xNKnIRFUVWCW6zhPEmEZuGxsVnSMIk
 Ct9cLEPW6VYIXnVDFP0KRRsDaZ62gvpdYT1yQr9Tu7W6FD7jjUENUVEBT02Db/MkPfnZMyj6bT8
 YPJC5QQbJZErcyYBxVA==
X-Proofpoint-GUID: bJnjmmL9ArPKuHCOIe551_9PDQCdUUcU
X-Proofpoint-ORIG-GUID: bJnjmmL9ArPKuHCOIe551_9PDQCdUUcU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA3MyBTYWx0ZWRfX25Y6QW39Y20R
 Wohd1AoV9nPv4eP0D8n3NTnIuFW+XVpfIx2WD16BUHN1UD3H/jlnH3hbHxOyL0Jg+QyqKZqwhhi
 H31/8X4BbfHNXP0MWJBDlHdI699qUgk=
X-Authority-Analysis: v=2.4 cv=X+nHu2Te c=1 sm=1 tr=0 ts=6ac3ee86 cx=c_pps
 a=ALzLegKRD8J3iQ32fiysVg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=8AirrxEcAAAA:8
 a=23pgiVc5KISuIIKJ75EA:9 a=CjuIK1q_8ugA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
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

> Allow driver configuration via environment variables as a fallback
> when devargs are not provided. After processing devargs (or when
> devargs are absent), check DRIVER_STRICT_ORDER and DRIVER_DUMP_MODE
> environment variables to set en_loose_ordered and dpaa2_sec_dp_dump.
>=20
> This lets users configure the driver without modifying EAL arguments,
> useful in environments where command-line access is restricted.
>=20
> Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
> ---
>  doc/guides/cryptodevs/dpaa2_sec.rst         | 12 ++++++++-
>  drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c | 27 ++++++++++++++++++---
>  2 files changed, 34 insertions(+), 5 deletions(-)
>=20
> diff --git a/doc/guides/cryptodevs/dpaa2_sec.rst
> b/doc/guides/cryptodevs/dpaa2_sec.rst
> index f95c6282bb..925d3371bf 100644
> --- a/doc/guides/cryptodevs/dpaa2_sec.rst
> +++ b/doc/guides/cryptodevs/dpaa2_sec.rst
> @@ -1,5 +1,5 @@
>  ..  SPDX-License-Identifier: BSD-3-Clause
> -    Copyright 2016 NXP
> +    Copyright 2016,2026 NXP
>=20
>=20
>=20
> @@ -188,9 +188,19 @@ along with other useful debugging information like
> session, queue, descriptor
>  data.
>  e.g. ``fslmc:dpseci.1,drv_dump_mode=3D1``
>=20
> +Alternatively, set the environment variable ``drv_dump_mode`` to the des=
ired
> +mode value. The environment variable is used as a fallback when the deva=
rg is
> +not provided, which is useful in production environments where modifying=
 EAL
> +command-line arguments is not practical.
> +e.g. ``export drv_dump_mode=3D1``
> +

I think Stephen has pointed out that this is bad precedent.
DPDK has already a way to configure to avoid env variables.
It is not clear why we need this?
While there is a way to set env variable, but cannot change command line ar=
gs?
Is this a debug thing?

