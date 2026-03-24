Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13916F54ADA
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 17:07:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45135402DA;
	Tue, 24 Mar 2026 18:07:13 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 3064B4025F
 for <dev@dpdk.org>; Tue, 24 Mar 2026 18:07:11 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OGjuVt1603674; Tue, 24 Mar 2026 10:07:10 -0700
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11022101.outbound.protection.outlook.com [40.107.209.101])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4d2fk760nk-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 24 Mar 2026 10:07:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sP6csxhNtzgDOEN3A4DeUXCq8cOg59ksqLl9HMzXuzgfbiFhZ3BfIsGlr56GEwe8Ext0VCHaMWi5qb0tKbcEF4eXJ1BR5KwmFAXkUAplm+pe2q36C6XushL1Q7WOo1VzZ8cz746WEM1EMBaddz6eaFAv70YP7C3zTJ6hgxskKD+SbDHhaCf493XbKOAxv7DLxA7mOoEqbmknbJRwP/GLomGsC9N41YZJM885HY4Pm1+GK1aVPzla9DJazf8Lrs9A8qqRdbyTu9nkmIg0i6pWze9kz8ssZe7t9XIm95HpuHhsj8s20FvsCbKlXAbiAU56/iIfCsB9RIaOizx08RyYaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBNiMnV7TJ5ksRIw9obTUc+PSce9rT7+nqCt3tLVjwg=;
 b=Y1kAa/zC7EG+Xt5YzkE2n+IiGqewNhPTT8T1mjfXtqLfEzANZ6jWK6I7ZcnMvipjJjZTvwD3/ffdhtKEJ7xYGM36dtNsw3Caz3dal5ByKi2RVmQCPH5Jdazv4fJELOKMEixxRzxXzqKnN9fkPx/Bo2aOJGQ13qqUuyU0347YNrzluDrZY01ewKv8wPNyozQvgguzKoFlCnveQGkLmm5PJEw8iybBc4j0wAoXEqy5Nw/l6jVEU43YPo41guoCuC18Iad65s869Pg4ndAfof1NR3oSXDFEJOhnu3qz1XLiIfsRzhVyk0o+b9RxSwDPSfjwRqqWSgv+92b0++kM3VmmJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBNiMnV7TJ5ksRIw9obTUc+PSce9rT7+nqCt3tLVjwg=;
 b=Lry8iDB0Hlpv6kuBSJQ+wWpTLLhoqZ2KrI+wR41spYe0suD7HW8vOA4AKCK95z08QMTrAE9S3qT+nUjgfH1ZOREKDAoGu8wX3sohBUZhh5nY93oEBpsyOZGBh0mvKYMCdHhlLS2tqWLbcP/U6zGjLm06nJAA/qUIOC/L/bY0ALs=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 DM4PR18MB4288.namprd18.prod.outlook.com (2603:10b6:5:397::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.31; Tue, 24 Mar 2026 17:07:07 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%4]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 17:07:07 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Nithinsen Kaithakadan <nkaithakadan@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>, Tejasree Kondoj <ktejasree@marvell.com>, Thomas Monjalon
 <thomas@monjalon.net>
CC: Ankur Dwivedi <adwivedi@marvell.com>, Anoob Joseph <anoobj@marvell.com>
Subject: RE: [PATCH 0/2] crypto/cnxk: add SNOW5G and ZUC256 support
Thread-Topic: [PATCH 0/2] crypto/cnxk: add SNOW5G and ZUC256 support
Thread-Index: AQHcu0EVpJH+ZUXjAE2f7srta3wzNLW96USA
Date: Tue, 24 Mar 2026 17:07:07 +0000
Message-ID: <CO6PR18MB4484C3FD2C9B671F0A185D21D848A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260324034819.1010198-1-nkaithakadan@marvell.com>
In-Reply-To: <20260324034819.1010198-1-nkaithakadan@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: thomas@monjalon.net
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|DM4PR18MB4288:EE_
x-ms-office365-filtering-correlation-id: aae0e5b8-dfb3-483c-e183-08de89c7c7a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003|7053199007|38070700021;
x-microsoft-antispam-message-info: si+2KiwPwIKKb/IMV8bifcsX57WdVmaGTeMbDIesKE0cPxNeyXFgEpEfTjRc+xyV4wcqxxs0V0VpuDZGyItu9xGmB3tE4uxUFmBPNJaSUwYjWzFFVNj/unk8/2C80slFJIU6NZv4/A8N73OWV3rJAg0CplsBeItps5gPPc8HxGbEzgRxsc7JjU3ZYDWC0/R9Rrks+e4nI06d8+QSmL8eCw8bmhgbwakNOu8CmNiaRVNSeVC+ExTKUQWH3LQHQutORMuW5X3EmHCb0IwkLx6xmgFa/JTRABRnXRX+Sh1vM8JcapmzT2KOME9nM6qEBLhjM217GNX6SQ3aM3JP8ez+hgG25FIQU1Izqh1WMALaeTtNK42Az6pMUJ9Yq02gYO2WRInl/3di8qCx5VyiCiwIaAwR0q947j3WyoaTGjP8imvM8f4ugPbCYi/XG1ra7KtVzBbB2/eOGNROd7pX5ws3JYzTz0FwtI2c9zqP2pUi+P+XYwa/MaNDDOluff6ATxMMd2RQpW3KIoERF/ZGcZvIHi+qLmMRi7YJ+sKrWziFhHSygNskpOqAtB2zR2770kcfUbMAftEqGXYC50ZCQMCf2gXqRw49yUfTVzNVTDFb+PPwCtSK83i/XkOPGAluJ3lnTkH+12ESgykphxgI4s0olUKDUZfJkcVbrGmaX5JuzTg1YCCVF33Oju5mM9d6OowNK9V4sLmdeeNN30ftibelM71Zh0dFq+RC0fqOAgm5eiwyLILuo2HF6K4qM/491u6kaLWOFLImVZQkFzYIumutFwRHH5ollG4bnQE3PLCfbro=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(7053199007)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M/bvT+k7CkqtNiebme9oUfVXPLa09IHMnNRdEZqscJAA1Ztc8hBdOAnAqOiB?=
 =?us-ascii?Q?eRJXyP43YP1Rk0uPaxxA+VbvHk+2Cr3eWm+rY4W3oQtdamUMcEPAh6kziIhf?=
 =?us-ascii?Q?wqsGG6Dv3qIPNg4jfbQpFXAfHBhrkAdMX8b9Xr1KdSRhynPS2tLfv1pL7X9Q?=
 =?us-ascii?Q?bSiHPq5L1eu+5whFsPPbwLw9GIFlgYRD4U580s5sZ3XuOcd1Tnli5azJO5Os?=
 =?us-ascii?Q?kQJ8bie1sdTCOYEtdgKRjBKdrRdkMOLZIOKWzNSQIRFWB2FENXYd3rojNf0r?=
 =?us-ascii?Q?/jtl/rXgW6/eFnDIK3M9XXfYCcDxakTlDgegbiltN1rWntRCo4MLRTfdFLUR?=
 =?us-ascii?Q?G9uss+hB6AsEshKFcCIew1LPEdna8LaZwNMXw2QUj0eiUdiHYQ11YHhcF0lY?=
 =?us-ascii?Q?aQXOtQuvrG4UVBJie6a/Lv0qPQTCZ4YoXXCpZ3dFA0GIx7x1Sxmpdl1plunN?=
 =?us-ascii?Q?lu9K/B65WosOIoU3uOvZEkq/32fy7l0TVKpPNnuCbcuhIh1RoKqq7xnHzVZu?=
 =?us-ascii?Q?MrM6d3h7dXLXAarV/On4Aw6N20zWzZvztebbwGcbGeMb+gGNbFk9elKwg1mx?=
 =?us-ascii?Q?UfFlynv6LPOwXrcr/58klZYs7CuEAPqfs1of0Xohki1UUMp04uGygxedS3TG?=
 =?us-ascii?Q?hf3ZxvpjLhbjFigVWMH5LCF3ePq+in89IvKqTlt/n5ooebJv8y2Zeny/5c+J?=
 =?us-ascii?Q?LyNR1jbDAB6eZQUW0qN4BeD8nWD96kfW5ZAE0mKPEjif3lPoITcLujazv/aV?=
 =?us-ascii?Q?es++D0DyOaSIBt/OoSD7uvT5fVGPXRoeHCxO0a5XmoFoevLKpJ583i4dBbrh?=
 =?us-ascii?Q?7i4zqjaUezXocc8mJIq9G46V+MoyFLZRXw93VjIQhpzaMEAbudvfBThJUNZm?=
 =?us-ascii?Q?whyfR+dEoozNZ5V6YGeqmE+BADOw7tiEWZBgc1XveRlfclpRl0d2qUxWdAVL?=
 =?us-ascii?Q?50181zEhw7KIrn20WzIBS6diAA8I5NQG5agQV9atDGmuNnA+v7vn5jc1uub0?=
 =?us-ascii?Q?eGohZgNYUB3P7f4qkNTsNWkpO1X9hlloDchY1E+Nb7lfPIGkvC6dSq0nV7zm?=
 =?us-ascii?Q?uszQrEGT9iAW8L0sYrf5dJcy+ZcaUfXAm14P4OQOKxu9XaDwi5Uib1PX/fC5?=
 =?us-ascii?Q?241fUsQ69zZFMbFwiUFL/pFZ1QDwnL7kZHPSbAMA8JGfYOWB98easB9zEIC0?=
 =?us-ascii?Q?68RDZPR9iycmHkgynjVc6eCxNtWVAsV1UyxOXILCTvlKqIpgHPUtcoV54sJG?=
 =?us-ascii?Q?+fWzE6v2/6othfd/YyksavC04l9paxq89Hdb+nTLDhSjVOc7TWcau0TnZBIi?=
 =?us-ascii?Q?HJbJw4xOPlk2w/SoKgNu0Dyx+nfIfjjuzeAjjuvwAAD5df9zftIBemkU7+1B?=
 =?us-ascii?Q?FZD4QJlyVxzwLHO2BJMS9FbdTgAxJiZH6WRSkjoRYo2MVdkUD6cTxR0YPlQr?=
 =?us-ascii?Q?BRWqDhidemj70JVfohecveEsZ+KX01MZKZx8tiVuY0OA79rsfT8l7sIflWpI?=
 =?us-ascii?Q?t9Hc5ki37fo/TjWRw24it9mLpDtgFMB94Lm6gQ65gyFv1Ci9EiIAksYkXzhS?=
 =?us-ascii?Q?oJHvU1ZuEKJ8Prok0jrkXtuNgDyp9939QgcRCFgGVtdaYydQVwx8fYLxfweI?=
 =?us-ascii?Q?gNH7zop8FOctRx3hInU8QcwHB8rSi9dVXNhHzWo6wA4zyL3Ohkzx3vl1RzvH?=
 =?us-ascii?Q?HmYzQmsimwZs+AP30x78WYi9jKyp3+ZrcmnIvxwWC9BVj7eZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LKgmDtFss/nj6JbfDbT37hYfjg9DvxnA/pDxO062vvoRvftLixn6A1cce1p6fsPpxH/IBbR8xqa676vseGsGXHdDsT1UX/nsbB511eOiDuzQY65ICktEPXn4j3WasNz9HmFBy+SEJoJSbl8hCdZsvCe/Tk8MSjaYkJVZrszq4HJM/xc7Q78/bjWErlwwMnmBA2YmsvfvzAI9vO1ADVepk37GF26hIaJFRkTE9fwYwJ3t7krimst9Z0QstBCc5PuDmcFwCKseVgk3cJWPDVuM2o5qzXoJoq5uyhxQEhpICdtsq/2fM0Fe338y+uG+tQ+1aZSAbyFyv0zAGOn+b7yUYw==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aae0e5b8-dfb3-483c-e183-08de89c7c7a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 17:07:07.4052 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kjQaX7oKoHUrD160MmQcxsP3fUs7k3QZ8AeGMNILISd4zVZEemKk2vBcdkKAtRay7/Qtx8ypHHpR/7YuYGbVmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB4288
X-Authority-Analysis: v=2.4 cv=caPfb3DM c=1 sm=1 tr=0 ts=69c2c4be cx=c_pps
 a=vWQ3mT+D5TKWrXkKqtKQhw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=-AAbraWEqlQA:10 a=Zc_DtpmQZw8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22
 a=QyXUC8HyAAAA:8 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8 a=_RFXdPuBYAD5uyzEEBYA:9
 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDEzMyBTYWx0ZWRfX9KwS+L+L3Cxi
 opWHemdCh6qw/VceGNwhGMAmnLJi0coGCIPljMJ9a4fP/Re1BZwD3DWlJWqIQkyoQ421Hg60Ovj
 V1CIolUu1DnMxc43TP75uMMSTI4wEpqDIDrR2wk4nG9rcgbv3vqYn8RwF7wr4YBe4mzS+r8QZ+A
 7SfUoSIj1xzuqkY2cz60mMgMFDYi4lxmFlA7S6q1b6OFwcfBAZNcdcL3rcT/uuUPWn20x3eSPym
 je8QnDIQ1Py/LSez5nWDZ4SE68s5qGYa/7Cq3ZwXblVHD+fHkjVcRKTkchmuheI1ZjneNrhFR7a
 QFt91oa04uc64BOXccuKaAaYPn/9QOmNDSW3DP8IL6c/btPfG3ntbdyfLWNZqAXMuDsTrrqoJ9C
 Te4EeW0Zl0hs6O94bHv2zNJpIL9QCeLu3aCKu02GIyF8YiGFpa1nLNsslKSB1QlJqKoWgurVgNQ
 G+ozQiGHdGR5IEfVsBA==
X-Proofpoint-GUID: YswxwSzmlC3LZgs0xTPr55b5PDcFwG2Y
X-Proofpoint-ORIG-GUID: YswxwSzmlC3LZgs0xTPr55b5PDcFwG2Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
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

Hi Tejasree/Nithinsen,

As we already have merged the cryptodev and test app changes. PMD patches g=
ot delayed.
It would make sense to merge these in current release to have feature compl=
ete.

Can you add updates to release notes and cnxk.ini file so that
these patches can be merged in Current release.

@Thomas Monjalon I hope it is ok to merge these patches.
Lib patches were merged as below.

commit 6e928dcd68ab2bca9fefea9031f5edc388e89258
Author: Radu Nicolau <radu.nicolau@intel.com>
Date:   Tue Feb 3 11:13:07 2026 +0000

    cryptodev: add 256-NxA4/5/6 algorithms


> -----Original Message-----
> From: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
> Sent: Tuesday, March 24, 2026 9:18 AM
> To: dev@dpdk.org
> Cc: Ankur Dwivedi <adwivedi@marvell.com>; Anoob Joseph
> <anoobj@marvell.com>; Tejasree Kondoj <ktejasree@marvell.com>; Akhil Goya=
l
> <gakhil@marvell.com>
> Subject: [PATCH 0/2] crypto/cnxk: add SNOW5G and ZUC256 support
>=20
> This patch series extends the cnxk crypto PMD to support SNOW5G
> NEA4/NIA4 and ZUC256 NEA6/NIA6 confidentiality and integrity
> algorithms across supported CNXK platforms.
>=20
> Nithinsen Kaithakadan (1):
>   crypto/cnxk: add SNOW5G and ZUC256 support
>=20
> Tejasree Kondoj (1):
>   crypto/cnxk: add ZUC256 v2 support for cn20k
>=20
>  drivers/common/cnxk/hw/cpt.h                  |   4 +-
>  drivers/common/cnxk/roc_se.c                  |  52 +++++++-
>  drivers/common/cnxk/roc_se.h                  |  18 ++-
>  drivers/crypto/cnxk/cnxk_cryptodev.h          |   2 +-
>  .../crypto/cnxk/cnxk_cryptodev_capabilities.c | 118 ++++++++++++++++--
>  drivers/crypto/cnxk/cnxk_cryptodev_ops.c      |  13 +-
>  drivers/crypto/cnxk/cnxk_se.h                 |  32 ++++-
>  7 files changed, 211 insertions(+), 28 deletions(-)
>=20
> --
> 2.34.1

