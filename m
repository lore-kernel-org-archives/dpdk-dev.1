Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C88DC3ABC9
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 11:59:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43A46427C4;
	Wed, 21 May 2025 13:59:42 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 80D96427BC
 for <dev@dpdk.org>; Wed, 21 May 2025 13:59:40 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L9qx3P012897;
 Wed, 21 May 2025 04:59:38 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46s3kc95a2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 May 2025 04:59:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eY1yu73tmOtAhJt6ki5FOjwQVORBsA1RLgTZpIQ2/Wbdhk7rJNhIwJp3hUUuWH8CpfMibwM2/UiKnxahZE4TFPgOHcmpaBfNWwyXCWl2Q46oRmycNN9hzN3a+UKJiT8zJi6LWn9irIEFWp0/DZzNMvzQhdcb9SCGDSr2WSlZ54l+s/wJK4TM41dopQ27L42QB9agXd1zZn3XFFcQSDC5vrCLAH9DGIqfrVurw1+2y7Lpz1O/DIdHkoPnNYbMzXyHlbNlVSYwxg8wOC0bBZMxOuVXEwhQ70ozr8nGfys4Xhf6sVQ7vCTC6Sw6jTgcBIQSax152Drd1vztYJUfeqEZYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGJjwbQXrL6a+7QsjH6bQZxvQ+Y09bZaeAL1jcf2f1Y=;
 b=f/x8+ogLehvn31l9e1KaXDunRS7wDphsRjs2+NAM2dDbBUrWCbXTNYcNYZUmT/uwrUbKajmqsCfKmWMrYJjXalYVmdw/8VwYspSsfcEYttbRfmdHnNodx/6+XZq5rNas+8AT8xfjW8wVS0lm2MOXQgEZJQKwaQZ6t+I5aZRDP+wHOn5ue4Hgx8glPokUiLUV5qbPcFv9YqW1uM07TfBKnm/7rXFL+ITYIqsAnYG9mvgHQ5j9STZ5oHTE+05m3mdiThevum5VacFAI/pugUPhm4jgELPKGFxgZmQ+LxliOz/1P3Axw3Kv3mQooQj/SLdIeyTg89foPySwduBMqyXo2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGJjwbQXrL6a+7QsjH6bQZxvQ+Y09bZaeAL1jcf2f1Y=;
 b=VMduUExHN+SuE1MSp89beirYImugsKsudE6QvOKHJPnCXEU1t5KeAhWAPKr5gVHGp2elpd/tH9Ia2Si1rb4/D9S2Xch21CsFxHnGzQD8vpzJO04UJl5pkGQAJZbP6QXGJmMcrh4kc7B3/W1n9xKKgcJey03lmWlTji18OBsDTGU=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 LV8PR18MB6004.namprd18.prod.outlook.com (2603:10b6:408:232::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.30; Wed, 21 May 2025 11:59:30 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 11:59:30 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Gagandeep Singh <g.singh@nxp.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "hemant.agrawal@nxp.com" <hemant.agrawal@nxp.com>
Subject: RE: [EXTERNAL] [PATCH v2 0/9] DPAA2 crypto driver changes
Thread-Topic: [EXTERNAL] [PATCH v2 0/9] DPAA2 crypto driver changes
Thread-Index: AQHbyh2YxAec4GCIRkiBk23vnl1AtrPc+s9A
Date: Wed, 21 May 2025 11:59:30 +0000
Message-ID: <CO6PR18MB4484957133F63EF2E58F9169D89EA@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250520055133.506071-1-g.singh@nxp.com>
 <20250521065658.857707-1-g.singh@nxp.com>
In-Reply-To: <20250521065658.857707-1-g.singh@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|LV8PR18MB6004:EE_
x-ms-office365-filtering-correlation-id: 85c2ffb8-209e-4f27-9dd7-08dd985ef1cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?+9mXr6lRtfyPTqbr38sACwR9MF600bdTMkAhoy4aNN7Kwjj42T/tq3sT97nB?=
 =?us-ascii?Q?GipKsx+MsG7tBXtkceRS+tFNgci0zsVZ40jFrhYty0ZZX5VmFyuaJmLcnYrk?=
 =?us-ascii?Q?CXhtZFNuwOC/LkV6OD8s86CNeZrcXv0ewpaqsK0myQn2kOVfgazrV/h7FX1n?=
 =?us-ascii?Q?NjGHqjUfpKH31lnJ9zuliNf8+4r4OAuoE3m7Fr9hN7TItt0UxF5RoyCMbDhd?=
 =?us-ascii?Q?WhmXumdIwT6jkczM4ob7YZzocebT6+Iromh4hXO6Cz7lTQcEHUKotFaTknip?=
 =?us-ascii?Q?zaShO4eemhv8ANr+PhC169PT2kYNXnhmgCms88kKR9JMfjVcFzCj7vJxOs2U?=
 =?us-ascii?Q?yBA4MatBs2E/MM1zzE89xjaa3V5D1eTam3KOXqZBaMphrpefIv9fIEqQfwWN?=
 =?us-ascii?Q?c2RzRkoR8jIw8zV0n0yYVM36yLCStj+c772q2gBw7GEyb88KLysHMdzV0OgG?=
 =?us-ascii?Q?aWK+WfoUvJZNBcwGawV7JMNTesKiS0WJCGCTO0f1dpJWaLDt+TJElah/Sv2D?=
 =?us-ascii?Q?/MuhI6z+A3USjOE1SuWICu1NXtPYsDQmmb2xnHJIgxaeJ7Ioby3uOy5W/ndL?=
 =?us-ascii?Q?njTp56lNDNDD4k3iHRpsXOdRv2G/OtvBjrRslHYc89hF4ErcYqLgoU3AgULa?=
 =?us-ascii?Q?yYaLsMiEgc/HAcnfOhFSvNYBJ37Rg3Ag+nuK0/BzCUcntzPXyhk53kbW1Xkd?=
 =?us-ascii?Q?FsrCjYqzq+lJjublHgjx4EyrwDxLUI4Fi7iob/7mfHRoou0cMeBJs0SZm1nh?=
 =?us-ascii?Q?Jk/UrGEw7Gdj5OlE0myyKnjq5GvXQEAtW3hfaZSc8RnxOwwkMgs85XlRUX9L?=
 =?us-ascii?Q?OQHVkjxEzSoKXMWI1mcH9tRvhpCUHP7mDeLRey049oDSkpqhwqv8WDKY8gO7?=
 =?us-ascii?Q?aB4BQnorOUMiA/aI0RsOJnIF3/2cQdaplQ+EiaovYH84jmKWsgg7DIRCW41v?=
 =?us-ascii?Q?0EcnOSUwSL1x2EcW/VkweW4ERSVBKRAi/Zg28L+qPPfcqeODIwCksZyefdt6?=
 =?us-ascii?Q?uXv38xmS+pOvl/j/BZVOnRtQ3EGZ5AmNKtzC25y63eXJK3Y5AEgo01/UJT9Z?=
 =?us-ascii?Q?25KUvC/mJ2n4Q4tqCqIIywqFjBWLV4DqCfTrqNydLzUTXfjZVyezmNx75fIz?=
 =?us-ascii?Q?4pkbKKcJlb7BfeVI0G0v7iP9yMVil/DDEcBUH3QcC50xGB1kyFOOh+qa3y9i?=
 =?us-ascii?Q?egQCtHWtPTmbgv0JC5PkNRGR1g66tfEOhP7R9VO6k3+KuwOhjID7WdwSMx7H?=
 =?us-ascii?Q?7lBgU5ta5gI74+TKWPiy0vGzWaPAEQqzUabI7DLezGLxYgPhVcT/RF1VHp2x?=
 =?us-ascii?Q?LBzOySga+nGHK3Wqy4qWkrOoxZxWikKMallw9nKzg5GWt5lb9Zuk2WJZLcai?=
 =?us-ascii?Q?OcIdhprgh1YETBLp2Ewj0dlIsG1YDk+7TmfPF8m28NfPddztKSLaWxy5sWUv?=
 =?us-ascii?Q?IbFLUvKNhwV9szcfQd5wqqvt/sEXGn/lAXzmrQ7El2if3crWuX/jwA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DxMbtiV9tgT7eR6vynlT1MDgf1Fn7QCjuWUVOhkuHZt2/FuYjhAF1ALYbWJ4?=
 =?us-ascii?Q?dk+IMCLpQKSvwSehrBT9XyQF3UfTMMX8yzUhb6UAKSkSqqqwEHUVglMHexN/?=
 =?us-ascii?Q?SzTdhNcYyIw78FMY/cBRNrleCthQB0DwhuMszdxAKMV9eIBWylipxUfJUKka?=
 =?us-ascii?Q?U3JwJHKdF5+1XWlaxP3nXaiM4O7YKOJNgBMSdLWB5+HLdOwZqQR567qwSuwv?=
 =?us-ascii?Q?iP5FdxA8HJfwZMHoyIA47nl3iI78twMqayOMeFU6uSwM6ZnK3kuYe/zeoX+X?=
 =?us-ascii?Q?olC4Xxqmi0wajUuD2CqnwFfldog+wDZkXHTEOzbnVnyOyFfnOyDEQB7pdENM?=
 =?us-ascii?Q?WFtke3t0zsuoJo9NTfPEQOB7WKVlZwc5AfiaQjqHPcoN0nem/9i9nQl5YdmI?=
 =?us-ascii?Q?1d9W0Phg+Ti/Y4qsLpNUTp/D0lewZURLkJiZLfr7WyNLlXEhAlq91G44WuK3?=
 =?us-ascii?Q?qPR/s3LesK163yzMppPHmmeClgfmVg+vOXrYoduKN7Cn1iNltlsxfjtQRFxU?=
 =?us-ascii?Q?yp4rdB323gtRunYFhUplpx7OKcmp95JYKzaUVUCTFlBv8tUCv4I+OwyEyhf3?=
 =?us-ascii?Q?IdDj0X8ZYqDccltA0r1awjpiRvWBOFFIQ6rEhwP+xK/fU7P9aLGpKuRb8zHQ?=
 =?us-ascii?Q?mq9FI/PkmxlclVe+lud6a2U6IKkV6phTb5wGFW9Ip+hjbBdP4jJYKe+F/J2c?=
 =?us-ascii?Q?g/8QiuSpEqvzX6Q62NLplQPxM7YACWRlR7ff06ImDREbzvYWSNk3mJQe8hmu?=
 =?us-ascii?Q?fXHjsVOC0g984S2LuqUCxlTlfcc9Vew+th2RW1X3sinj6WL2CroPfmkX62nC?=
 =?us-ascii?Q?1S3etJEa3io93fwWLThuE2O8YmzKtrGJWTlfAbPEyac67yIvOXopL+keuH1p?=
 =?us-ascii?Q?HTcsVl+pbc0J8dw1VMgsbebbZBoK58//+XNtAQKMbPbSFjn6X7+4FedsQYyG?=
 =?us-ascii?Q?M/JoTgommlFcEfJA7vTPzH0yRxGzD5ydbzett/qhOAEolET3XhQJJHhJNWZF?=
 =?us-ascii?Q?7KDxbBBq/Gtak4tC+7snjTU4eD4j5fS6F1gGnkUnrk40lmBShrB6mGMBkq7W?=
 =?us-ascii?Q?upmf/aLtlyFK+XCtDSsg/lnMsnNIuxc7KFXsCrbcnNmB1S+xrRvF6qVy3d25?=
 =?us-ascii?Q?8wY1EZUktbw2sDdxmI+4agyUvf/gMebZxe0DJI/Hnb60Jr/3894RF0b0fg3o?=
 =?us-ascii?Q?MQbn1IdUFQ4jIONDEneLXqnOxTh4Bs8cAvB83yXr/qUFlCRRt97O8xk9gVn8?=
 =?us-ascii?Q?YzzYm6V/mHhe5QM3EmEQnxwC3uOe7LUXbjZu/VH7vcfCVF5p62OI7H7SQT2T?=
 =?us-ascii?Q?5Vw1u1RkuVrlZ7p1p7ZdCQrevl3geWSBl+sQbsm0QsLuizRYrYGDmIfUtAoB?=
 =?us-ascii?Q?L44WWhnvKkOdPKzCs4qIkt57mlIW2MEvhbCvf3s13cyMnVjN6qHpTIcwgFR2?=
 =?us-ascii?Q?aZZos7osK0akKM/XTkVqKzc5euC30MDbXEOHJNsc7wL35G2VCWTQgMnkUT0m?=
 =?us-ascii?Q?fAZbg/tvf+GDGuK5x8SkLvBi9ywSpnWKny29y2S/lQFKJ1oazoiAcpnO0sCk?=
 =?us-ascii?Q?bfiJUA/QqO0OlR8xiegzdvMDcca26JrhVWwrwbkC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c2ffb8-209e-4f27-9dd7-08dd985ef1cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 11:59:30.7373 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jbaE/TYeARjwZ2NS0hFxJZrBWiGS/8k8GrxhEEipIGjHqRYo3ZoJpvUc0TEfS8WHWAYEVV//eAxV2r1jx1F1wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB6004
X-Proofpoint-ORIG-GUID: Jum5UGs8_b5kmfBhPR6hpl1Gxk6Z9tqI
X-Proofpoint-GUID: Jum5UGs8_b5kmfBhPR6hpl1Gxk6Z9tqI
X-Authority-Analysis: v=2.4 cv=TcyWtQQh c=1 sm=1 tr=0 ts=682dc027 cx=c_pps
 a=19NZlzvm9lyiwlsJLkNFGw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=U4m89DWn4Bpq258BqRwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDExOCBTYWx0ZWRfXzdObqOONzN0k
 +nuLF6lAWjqtYBHgvVN1ikXvGuh7SRwrmZwV6RPh6Ln+kC7YtqeMza6M+rrSKrDbNZQJ5zPOYIs
 oWjlsaXSzyEKIuxSnOr9CF6A7sS4KaApqIxJ3bD3cAa8uNdsVWJapOLHkJezfYUxJKXKyzYJTcI
 vyZND5YDAkecBkn0DPYGPliPuIvUI7vZPxBwiFiZAcI0H7LIum7OwtZf8oFb0u9nBiRocmxulmb
 j1HTmxSnheIgMWfd6CXBKYsPnfIJF98vTlk87q377ycB++b+qEnbmBeJekKnr8EcF6UJCh9Emjy
 gEQYPYKihjZljAWXPBtCT152gcPfaE3CZQBfVHt2sZwY38M1/2LS5XlcOJzxelo88DLRD+5M0dm
 RPoVIIe2j6oRGLhGGe6j9VpoTwIF58ipOTtV4itwIBFfDxo2Ur908gndDMCNXgqDMqJ+unor
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_04,2025-05-20_03,2025-03-28_01
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

Split the patchset for appropriate trees. There are patches for net and mem=
pool which will not go in crypto tree. And I don't see them as dependent pa=
tches for crypto.

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

