Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA113CCA470
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 05:49:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6845240265;
	Wed,  1 Oct 2025 07:49:44 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id C31C4400EF
 for <dev@dpdk.org>; Wed,  1 Oct 2025 07:49:43 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UIBH28027781;
 Tue, 30 Sep 2025 22:49:43 -0700
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11020095.outbound.protection.outlook.com [52.101.56.95])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49efefh5sk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Sep 2025 22:49:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yM2M1z3e5QaXu2ILuIoc5i8Ko3JgG+ftYxc9Gs37RuNWC20pewX4xbVvNoHnQiAOJfwOHaOSia9i2o5/Ub8m3isSpObHoNr4lLum0sdUb86Qbhs4B5uOA+17O6dH6K4WgYcq4brOpQsXN9mvYccujcnUEj0wMFcPbnF/snQojzES34FlDmDh+mD+MwqClkfwtlfYqbDvKe94PvaSbgV2XX9ZsgocFB7Wij+z/H4AF6CwZrR0vx9Js5qoRfQBE4w4zdSGVSLzJ4EV2yfZR6RSXRXct/snGZ5xeRUGMPn5VwqF0kqNJCEUpFb6loLcdI9GvisLIJz/KFDJk4d4XJC3fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAJh2SDZ11FVBd4IjuNEbG0l1AdK/ZAltLJRRxtOAzY=;
 b=JSlnIt8pReM710hHrowptwsTeGZO+3bl5EkOhxJsdezYL9zeC4Q1uZRRHI4/sFqCAPuVCqkuVwaZDXOCSYytL19VNZxdact/M9qtLQzyJJe2rzowpeOro3TQ0MyBK6A+3I1urNqp7ioUaz+tweGN5UcfPvL7e87vgxai6IMBiKfifwKV11P59tOJJzXUwD7MwaOr6XQ2+AyrB4YMWyXXCsQ43oyuLAU86ElDnIEN3T8g/flTx4IHOajY1aR5BSKLKn4ImGdgqDYjHhjPhsQVUPyBz9W+ep63WPJj9TrAJi1K27mxDgS16NmpV1zAMRfd1u5GF1uTvguIFDouBnTyVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAJh2SDZ11FVBd4IjuNEbG0l1AdK/ZAltLJRRxtOAzY=;
 b=iYA1GC8JdcOZn4OM13CwzA2Qap0w+Rh9NLXjgnEqpfsyRIQFe6fEdpxEBm/veTD2wJ+uTsFHp48T1hqn5N9meeSaxl8qXYg+ggtdmTm7/0w/6asRTHfS/HvbQ2gMUo0vceGKRJrpY5+0MYFKzTaCPfAoPT5cVbNVMnyhV4zpXVI=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 DM4PR18MB4320.namprd18.prod.outlook.com (2603:10b6:5:39c::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.17; Wed, 1 Oct 2025 05:49:41 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%2]) with mapi id 15.20.9160.015; Wed, 1 Oct 2025
 05:49:40 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>, Fan Zhang <fanzhang.oss@gmail.com>,
 Kai Ji <kai.ji@intel.com>
CC: Anoob Joseph <anoobj@marvell.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>
Subject: RE: [PATCH v1 0/3] cryptodev: support PQC ML algorithms
Thread-Topic: [PATCH v1 0/3] cryptodev: support PQC ML algorithms
Thread-Index: AQHcMjSLkWuH6m/dGkKiCIGJEg7zObSsycXA
Date: Wed, 1 Oct 2025 05:49:40 +0000
Message-ID: <CO6PR18MB4484FC082BAC2BAEEF794435D8E6A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250828070657.8968-1-gmuthukrishn@marvell.com>
 <20250930180316.1021-1-gmuthukrishn@marvell.com>
In-Reply-To: <20250930180316.1021-1-gmuthukrishn@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|DM4PR18MB4320:EE_
x-ms-office365-filtering-correlation-id: 55e6e7f2-ca62-4e86-6b9b-08de00ae507f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?20mvJZs5FKo/4/atLpyeP+UHNCbT5loYVahs+JB7G0irOpV6nHBd0vck7ySA?=
 =?us-ascii?Q?DypAmBZWnsFOujuaKR/tCf6iJVLnMkV1ZaHSWC5ZX940As31nGUVZBucqcW7?=
 =?us-ascii?Q?3LTzAkxju5LT47Xg6qj7yNcr8qoSecK3LfcMBTns4yjMVzU5U3GsjjtF5vZJ?=
 =?us-ascii?Q?KdDepzFmxMKCi+Y1G3ZsqrfOsqFMzL36dvKlvg+wYkxneufKnqpER1xssDf4?=
 =?us-ascii?Q?q6UPFPcyXmwDlfOQ2pjbd4NSkRkeR7lbaH10mUiylxdilZbojKmMQZCphyec?=
 =?us-ascii?Q?1GCbIAxNaTKQZ9ak0WgNJ7ZamyCbU7ZxdKRulujF3/51v+xpFbEgPnuamT2c?=
 =?us-ascii?Q?u7cUg9tY9Gr8lsQ9+pnvIT9fCeLbAy/K4jKDs9VoKpax7hsyZT3F8EoilVBX?=
 =?us-ascii?Q?1D9MrKhvg0qJKszkhAQ3vuAYXYzdkQodl0ub9dc3NNCqt6vp6+7xDPN9QcTK?=
 =?us-ascii?Q?Xh/wnKQ66IjxOZi5GBcBBUAcdcljUAbQy6gHd7/ZGYDenZY+BstQpL9zzHCl?=
 =?us-ascii?Q?r1+NjtwJy+x+CknSZPUDNNdVYXQq0ia2xrGgeQYVfScg1Y2SZ/9kMN/q21mX?=
 =?us-ascii?Q?MR6NEKQzcr/+rYL6gfpB4QpftnGMR5hhr3IkpvVYOpF032Hhux+TDy5SqaS5?=
 =?us-ascii?Q?M6f0L0zq73d9RYEMRAEVDdzRgZXlForAilzEMVzAvtNrhxsWSmK029PH/qYN?=
 =?us-ascii?Q?ZEvWtMZ7i8yHoHrUElYN7PBEoK82iLZWhZ5oiGnrRkj02GZkCW9P7FCrukGY?=
 =?us-ascii?Q?Vt7yn+pnJ7L28GNP/KL9M/9OdrXSqwmiZmkK/JdhXbqXEfmYQ8mNaubNWBuL?=
 =?us-ascii?Q?afgs4Hc1oB6u/WvV1e8l+16BslEvE29aLsf59HJpc4jbZ+dlOZYYilXGskFW?=
 =?us-ascii?Q?DfOXH2yQj6MWb7vK9UKs4SErOlytebh1X9xkkAI8Brfy76x5ZLC4Eihg5JlW?=
 =?us-ascii?Q?ROIqwqjb8r7ec4XhTGMdKwKd8svakyW1zR0emx0ja1SoUqtzJJBPNi9LC/6L?=
 =?us-ascii?Q?JNDAUHn6oqb9bDZyBV6OUkfcz7aoqDS5xB7pJ/un+9ghHAL1sbA3UHL859SO?=
 =?us-ascii?Q?MSbY2BGaeVcUhSpY1Kt2s62eMie9F7+XsIh74uLdafTlcoWk/AsUj36v4SVn?=
 =?us-ascii?Q?bpLDv5cd6HVfcTrKJ/HNegigdKunqZCJXnSGJhjmO7ooZGLXiRfNwRaDfLO0?=
 =?us-ascii?Q?JirQhh1iM1pAUigp/KDCNErDsQrcVhXw/gUyb3Ad6L6QGiMd6ZNnfZeXorfS?=
 =?us-ascii?Q?vpTV/lpwBPB0i2IWz+BoLlYaXaZWVmFAGgCJi9Ea23En6ZwMmAnapKEy2zB2?=
 =?us-ascii?Q?DC+W1QQhalkDNSQd+ZF8m9157c5jUq6PQ7VhONZdYuopi+EMO7x+aLBRP5pT?=
 =?us-ascii?Q?VNIOK7mcUvQvtHb7lbgehBhYtcN94oz16nkK0fat8XJUQuLuPHdTQm6jO+uf?=
 =?us-ascii?Q?Fmy30GTHvVeC/x3FDAyoNPf9KkNgnkhRxgi8ZvTIC2hQ4tUXpHT+jvI9zCu8?=
 =?us-ascii?Q?7zz+OmEw51Dpv4RDXzSO0q7uhcqGiTnrNX6m?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?d10PLT99/RsM9+Ruc0ZsNalMhEmiAD1l1BfRvXczqDm3S3v18DubM3DQY7Ai?=
 =?us-ascii?Q?zGdRXuADkBFn9h+zSG4J6Etx4QlUi2omaECR71sQ21f4mubiSNZej4lcfNZH?=
 =?us-ascii?Q?Bs1QVsGtITRosjrm0ujYG735x+eydLTtTOqZyEXXp94hjlzvbIWgSBrRPucN?=
 =?us-ascii?Q?dIYNrCyKjh8oL123AK2mbG8K2P65rMzLLM58bUHWQwAsNmWZ7Y5zxwCDz4PQ?=
 =?us-ascii?Q?hMgXLVkYCE/l5dXvWqWYtM9W9bzMcD7LtG14pHjbqechU/KIOJ9kCrlIoOJP?=
 =?us-ascii?Q?zyrrvMdQJF+zAdEl7/ZQKxbNaJmRXLcWta3zoscLuqfyRmuReAgufzzPndDo?=
 =?us-ascii?Q?tud3sAGWf/5W+GivqW4pBGwdjfLdt6x6muYkxbxL2oR8ocHDCsFPNC5Qwdt6?=
 =?us-ascii?Q?Q7uUm3kIKwndiq+DbbmaTpdWSmsHtUrj5oqS/xcfoJleEfknBqbSJHEQ7gZh?=
 =?us-ascii?Q?I8JFzoFvjFo30cQZ2EFOcKxBYXoxx7/M2ByEfwXGiNnWJHPEOom0tCT+JxnR?=
 =?us-ascii?Q?lIuyJp7vzhQ5q18Y3kqQ9UO9612sy7e53jvXPW3jPKPhoGKhJqZH/BWlkIay?=
 =?us-ascii?Q?eiu8AQ9IQs+i+c3cnrYlhUinkfVhaJl/b7oEilaOBJVnNxLpS9Vvm7IMj4nk?=
 =?us-ascii?Q?wxjUUdcUInHJiso52e+rpyO6BwSWXl3vLL2vRDJ1aUeTB1kxpW57bzuifQwP?=
 =?us-ascii?Q?MN7VC8yFXmi9FFK9GVPRBDGx2xDhOSKVVarrdSXBCOzlwpiqKiXISbtYNrxK?=
 =?us-ascii?Q?c5vqbsxwO6H8AICh9c1I1g4fXt7sx7EmS10AnMXNznNJWrPEWZ/wmdKrct0k?=
 =?us-ascii?Q?SDK/3S44k75JmiBQ/2FXnaws0/YpxocAq10lEaSF4/i8KNx/UKK6+vx/OLII?=
 =?us-ascii?Q?Vehqy/y3JZTGglN+YmORPMJ7WvI/ABRRPs79v387BVOE2sbcUGi/yHR/OG/k?=
 =?us-ascii?Q?2XpHcA9faKUrKf8Q1hAH3Oj8T07RBhJ+EDcAeounbjnPIjgJ52o11ZvF+1IP?=
 =?us-ascii?Q?9JZohyNCUi8EzPuQ4ePxhpXvcCLsyuegLEW1vHdHAgahoy7tBzMqBgaCJh+T?=
 =?us-ascii?Q?Qc/taA3vFdYScNj8DCnYlgwFf5WnWCTWvFB0ZXjsViX+xIKBjO67jqGI/zxQ?=
 =?us-ascii?Q?KTylDQ2LqM9w99YLwX/4sfSB/1zjHo3CeovuWRJ3w1WhHOccVObKTTudJQlP?=
 =?us-ascii?Q?KE4hHtXq0MIvAPrlEIdJP4l9/Jo5q92HuGA5BvK/NpzKzsQSRjvlB1pTN/jS?=
 =?us-ascii?Q?WLfW/xe3BdV1mWC34IDN0lj6GQVSK0WldVaeOViohJuYV2jXY0R/t6s+So8l?=
 =?us-ascii?Q?OWBZf5v3W63gihs9XI3zTyfb4AvGQ9Tg8qJ9awuNqo/bj5dmdO3rETVUhfRw?=
 =?us-ascii?Q?BT1ESLuhG17idC52c+fVAlr5ULrOIS5+L4IxJyEYM9PbaYRVJzCfBdwMtvmd?=
 =?us-ascii?Q?DqrtuEXwjPohU0pLwqZkdXBwX7pnY5ZXrHdrkas3eQEhs5GLrc9hEWQK27RC?=
 =?us-ascii?Q?lRTEKpHQl2ZxH7D7dMkv1sR53Wknu6Nlup083p/N5yxhvEGNU03ShwFSnnWi?=
 =?us-ascii?Q?APCD2IxarcNtzOaJWfo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55e6e7f2-ca62-4e86-6b9b-08de00ae507f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2025 05:49:40.7074 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dMCSHVn839freYZitr26P4B9YeKfs0krYZjStkQuY9nW0rGHWCrypBhb+wH411amxtIHfsu2XmYSb34qYQ64vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB4320
X-Proofpoint-GUID: BwDOuM0hiw6r_30wbOHq9OwsW5Z5TUcf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDExMyBTYWx0ZWRfX9Rr66k7GSgcu
 Xgi0xEO1eWpwOs7u+JNmiIqYsQttKKgiGfcKxPrpoBHJGlAn1NIlTB8VJ8C2AXmiNe0wvQuahAe
 fr5fbafsPM3RzlZvmAKfhaNBfvohMIy2iNEDSHf5Tuxkq9X03EKeIgJoY0Kn8G/pK+B2wmj2sB7
 FaWwTYaSPf5tJaD8BJe9tEzLTefQPhnw9fwI1fCBqqi554eZF/FvniS1s+Xe2BLdK+3+aa+wm2E
 i7DkAoEHdo5L2CTB2Lo6QdncTQHu846mrjYEd8G0OJttT2TUYEJC+nRez8zuaLHP7BsZmqpacEP
 492qhp2RzAMZYleXz6Y5r/68befM/XQs9nj6rFwqXzc/sGsFBIOUGkQivmTqqswtxfUsDUeePZI
 9xY+KJ3YKbyy5UGdvvTmlJsEYVatFA==
X-Authority-Analysis: v=2.4 cv=RorI7SmK c=1 sm=1 tr=0 ts=68dcc0f7 cx=c_pps
 a=yVrI7xnXu6GnujqWTphvPg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=-AAbraWEqlQA:10
 a=UAcaaFjAG7F3bw8uQOUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: BwDOuM0hiw6r_30wbOHq9OwsW5Z5TUcf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_01,2025-09-29_04,2025-03-28_01
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

> Subject: [PATCH v1 0/3] cryptodev: support PQC ML algorithms
>=20
> This series added support for PQC ML-KEM and ML-DSA algorithms.
>=20
> Gowrishankar Muthukrishnan (3):
>   cryptodev: support PQC ML algorithms
>   crypto/openssl: add ML crypto support
>   app/test: add ML crypto test vectors
>=20
>  app/test/test_cryptodev_asym.c                |  856 ++++++++
>  app/test/test_cryptodev_ml_dsa_test_vectors.h | 1856 +++++++++++++++++
>  app/test/test_cryptodev_ml_kem_test_vectors.h |  873 ++++++++
>  doc/guides/cryptodevs/features/default.ini    |    2 +
>  doc/guides/cryptodevs/features/openssl.ini    |    2 +
>  doc/guides/prog_guide/cryptodev_lib.rst       |    3 +-
>  doc/guides/rel_notes/release_25_11.rst        |   11 +
>  drivers/crypto/openssl/openssl_pmd_private.h  |   16 +
>  drivers/crypto/openssl/rte_openssl_pmd.c      |  868 ++++++++
>  drivers/crypto/openssl/rte_openssl_pmd_ops.c  |  129 ++
>  lib/cryptodev/rte_crypto_asym.h               |  306 +++
>  lib/cryptodev/rte_cryptodev.c                 |   60 +
>  lib/cryptodev/rte_cryptodev.h                 |   15 +-
>  13 files changed, 4994 insertions(+), 3 deletions(-)
>  create mode 100644 app/test/test_cryptodev_ml_dsa_test_vectors.h
>  create mode 100644 app/test/test_cryptodev_ml_kem_test_vectors.h

Please fix compilation on lower OpenSSL versions.

>=20
> --
> 2.37.1

