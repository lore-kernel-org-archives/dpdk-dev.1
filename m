Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F89C5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Jun 2025 11:53:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 517A64028E;
	Mon,  2 Jun 2025 13:53:37 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 631284025E
 for <dev@dpdk.org>; Mon,  2 Jun 2025 13:53:36 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5521jF8O013934
 for <dev@dpdk.org>; Mon, 2 Jun 2025 04:53:35 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2122.outbound.protection.outlook.com [40.107.237.122])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 470bpa2ect-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 02 Jun 2025 04:53:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ifRzD3Yibxspps2UmElHJGfjfJX8a+NS3v5DJOlt+fS2GzQi4ZfGtUyDZOwHM7T83WQNMAuyvanZ4RANaRQhYvANZTla8Rj2jCbNN0OwZYIqeWk77yazdqZnpJzfc7Ife/NZmDlu5YOFqfr7+p/zwIJ24v10scVe8pVkltKjfjB1pGqbXjsvmS8P+jgntX3XgBw+/RElh8MVaLYIsTGR7YbH8NhdqQ8EN/l4V9Sroo2KiGSzyROhQosl4eXLQNO0cPavRRqunWR/LsR3T57afFIWKutgDejNlj2AKJdMBPfc60g1CmhH9OahZBsJYAjQoA3Iqcwr6wciffNwlOiWYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QyL76oYLy1jWa8owmEAAIO05TMo+gfhlvYD6DLdhPMQ=;
 b=y18/G7duP/kMwtkCK0oUp2STneBZxEKnaZf3W36kvA2OZx+xZaqx00PRBFj5eEB+RBJjq2eO6laYfUkhHkJLHNSvn54uUJgBQPaUdHmb2YmUMu9jL3O7+N9JeYDbla4QG66w8nyn4FmlZBC6o8I7NI7AALfdpUMbWecN/F8V5v24RuMOg9rO3iD8R6vzURy72UrIDUhxlwa3lEEf14yMwZIlbVe+6rBtsvRgKSiixxa2X9q0zNL2vKy9vi+udu3g1zxnvfMs48i1+Q60VmvbzkBnVYyS3MlmOAB413W3327r3BSwnnHCxHdJLhKOc1hd50KtlbtWU/BQ9pXTMgPQHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QyL76oYLy1jWa8owmEAAIO05TMo+gfhlvYD6DLdhPMQ=;
 b=HQdusRstFLIaTpkVyjiDgoZc+hEBVFADYjQ4zToNci7IeCFJjty6sHDv9Jp4JY6uoyutuG/5m6a/baA+B036ow1nRED8MJxfoozBxFqVgzTysetuV7KNsYV0ES2oMpQfCCjZS7YtkypOW0LF6zKACGqOjGWzdD6nFkO2uaBbPq4=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 BY3PR18MB4708.namprd18.prod.outlook.com (2603:10b6:a03:3cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Mon, 2 Jun
 2025 11:53:33 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%4]) with mapi id 15.20.8769.037; Mon, 2 Jun 2025
 11:53:32 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Tejasree Kondoj <ktejasree@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH 00/25] add CN20K support to cnxk crypto PMD
Thread-Topic: [PATCH 00/25] add CN20K support to cnxk crypto PMD
Thread-Index: AQHbzvbNlul8yPh5BkWwRasBUQnNP7PvyfDQgAAB/HA=
Date: Mon, 2 Jun 2025 11:53:32 +0000
Message-ID: <CO6PR18MB4484DCBF14E6172020D563ABD862A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250527110205.2300800-1-ktejasree@marvell.com>
 <CO6PR18MB4484450C1C211727EE49EB0BD862A@CO6PR18MB4484.namprd18.prod.outlook.com>
In-Reply-To: <CO6PR18MB4484450C1C211727EE49EB0BD862A@CO6PR18MB4484.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|BY3PR18MB4708:EE_
x-ms-office365-filtering-correlation-id: bcb921c0-700b-4694-155f-08dda1cc1979
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?eReLChgufRwYxRqFTitna1J44fL5EHSLtZbtxkokK6UujAS4GAOXWuW0EEwp?=
 =?us-ascii?Q?9p8Su3/uQF1ovVeDUbepmXD/2p9VDDM6x1QE9EB7brflaNc/hgPeydSRjrAy?=
 =?us-ascii?Q?X18oEhK5rjY9tAwpryCuSdtmsTb6jN5azU3enUWrBJ8L1V5hZsGBO3SHjTt/?=
 =?us-ascii?Q?j1AMu9/2LKIfGTlpBJwLBL4RpwqxLUYkuAorJ+MGqVgPS9nFvVDX7ilgAObM?=
 =?us-ascii?Q?4UYA/hKKaRMabxQ7V+An23DHyGePp5DZAHdC1p9LCI1W5Qr7qKcRIqt04MCo?=
 =?us-ascii?Q?fxCZPZiDHusEi4O5G3Zp80BIQ362LBDG36sPupg9kTvOF5Z2p2liTV5cAYVX?=
 =?us-ascii?Q?X7CDQaGgJgx/hBJadbQF6J34K/cZTLwmX6JULlJ2BA4D7H9bN8N5Q+y6RzRT?=
 =?us-ascii?Q?GkdQjzgiuyfjG1K7fp2Ja5QO178Tijx969aCJTM7Gf9v1HLiQOmKoQFwaeMX?=
 =?us-ascii?Q?aGxaj9I7YVcLuSsHEl6U88fmmyPfBq/p6R9O6bQRH6eihO1X4+Qsg+3e4+BY?=
 =?us-ascii?Q?XUB3uhrY7713Zqwsjciu8kymxF7ZRtHUQ2NDS2j+3JoppHNDgd5t6G8w/gP8?=
 =?us-ascii?Q?Z00cm10fmUQQdt6icayYImhaLzcAmP3kFvKnwGH0BTfYH3Mkw1igF8sDlu5l?=
 =?us-ascii?Q?O6H7rfGxGPLpRXPtgBqf4+VrZdYOBcZrjuO2dPapd/F32Z36rd77uUDqy9mL?=
 =?us-ascii?Q?bdr7KGeM9j7fZoU2M6vnsVubTvhTyIHhI/Ei/+KgzCP+3OzkE4vfbEDV9UvO?=
 =?us-ascii?Q?o0fYfaMYArDNy74Fx+Z2q7DQXUxWatJqz7SzfRO3Sz7RE43B9M/YGYj8ay0Y?=
 =?us-ascii?Q?a9k5JyiMD4WiobyyuHu0AOZoYspfuOZRnGATGBingqzX54Ftn9WyrKcfq9dF?=
 =?us-ascii?Q?91tOE5C+jx7X5Ge2/NI9ZPg/8qOH+PqzwaBK/Oa6PbIycrux7Us4EHZJnHwe?=
 =?us-ascii?Q?c5jUPoMwCwPzQiD5Ruet0YrLZlonom9+X71D3um7NTBegnavDk4IlU8yHOea?=
 =?us-ascii?Q?wDkoQCsqv4nP97IPrYhHwXo/muJlTBNgVahgQw9+vXUrByInkmsjimzSoHhJ?=
 =?us-ascii?Q?iLLvaXWDTBZb4SfNGBHVDZFUv96MqQelVCiCT2d+IL52ZgwNz6VAXoq3DX0v?=
 =?us-ascii?Q?D2JEOqgL/NhlVUeICXff3DOPleyC3eYoH+P9DRaUx6TqGckr1P6oCW208yu7?=
 =?us-ascii?Q?wuc5jmMYU/Zk5FOlalmktgp0d4ENgSroswomNDjKDr+14Jp95/Y1pBOL0Ysj?=
 =?us-ascii?Q?+LmpQasiOP28EERnuEj0j4O+QCAlkgKdWAzzbAay3h5UVqJ93EbcIhGy5Ag3?=
 =?us-ascii?Q?Agg7rSBktaeJ/cRsZfOZcn1wnITpM0w60nKmZulY3i/+k8uv66PfTzK/sLEv?=
 =?us-ascii?Q?fUku8DiiCKtp4PaUq0jRiIuklb7oUXPP5LuU4GqrxfbjSwLhAscduuK+lM0A?=
 =?us-ascii?Q?OAZQChZlZxUWTzPzT05q5kVDcUWakL2IJQlGpB2LRdAHFw5TMTQZXIBFof+R?=
 =?us-ascii?Q?cCK1KboosVQDRz8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sfdsTZmwMMxc1W1Deow0x4tj3m8pZG5aIXp6bCewRi8WzV5iDEHit72IkiDq?=
 =?us-ascii?Q?lzBcMGCbwqt8Ldk3SYV22LQnHs/NUbvfNjBu98pR15zfu8c4v+yuVqvP5aZC?=
 =?us-ascii?Q?zmLY42IbWFxhVs1c+960Q0egI++Hmo6z10lrscTbSmzu/QFyVT55M5uxv/Jh?=
 =?us-ascii?Q?OJRhBzf3C/VSPI6W8xbnKIXg3PX/sfAem42QLCEtzqk3RBT9H22A25iPXsi4?=
 =?us-ascii?Q?XtAjq/ASxboKBMo7sgD1ZLJ5KQadhsPXUo287KOllQzTLBQRZXvAD7V3ntSA?=
 =?us-ascii?Q?wHoWY7rKcFWW9wnokkLlwa5lI8i1Fal2aMGCMg15WHgtF1EzjgRqH95Ww8aW?=
 =?us-ascii?Q?ZWG1JbeOHhQwzgBqgf4EPb4A2xfZC5H4fJJLPB/mA2DFyjVAQfgl8/3iYDjT?=
 =?us-ascii?Q?NdmkLtvhQ0v/K5nxT2PGBbeN3t6BldFPjW3byg+tl9X9HFl0PaFXJE+yBjA0?=
 =?us-ascii?Q?pryvLruvlRCHcoA7zBaeh4I3DrF7tXYEr5wLuzlecB8pUd8/NJj4OZmkPr92?=
 =?us-ascii?Q?4TpCjqc+HxGXcuOZu8kZTERwS9u+dS1A3nNXTtQIdoZepghdMGOVFDDRVafG?=
 =?us-ascii?Q?bUHRXlavS2Tllq1HpfIckvz87CwA0MFlW+lqjtIq5iFh86Q51vqtvXPj8Jte?=
 =?us-ascii?Q?ILpx8xAa4YrIfKZ8erNI6UmkBqsUOZDk9Mzlpdv1X7cz34wb19Sr/PZwpg1O?=
 =?us-ascii?Q?PDmy8RFtgnha+UvqAOF0lmotEf/gNxlX2I3sTQAHWi+xoKl7YAGoDwE2WpRo?=
 =?us-ascii?Q?ZAJ/lDLYoU4lLseoVVVj/MvPkBCK8UcDJECASoT27wi9LxoL7apXiYDHk/iV?=
 =?us-ascii?Q?ZeNLYX5IKaq2VMZxeCAQQWtGjk2uPQSKLNvxF5NJt88M92vRcZJzLbBNSHWc?=
 =?us-ascii?Q?w82OXk17notoIvNSw9Jlph/W1HDw/bnxwK7tltCrx2UgnOyBS3fYgEU09mSQ?=
 =?us-ascii?Q?NVPiFAfrLGK3n3bOvHPC4DeUqzn7oyUo3SCpAQ0io5foElRooFWmCQtW+//B?=
 =?us-ascii?Q?tNgDPfoogvPT0KF2+YgPk4Av8/MiBpRIBi5v7620BPMm+43POxuCJK0FI01v?=
 =?us-ascii?Q?zBS67ay9gttU/mUsqZMmaPJejqsgXQmTeyUvSM1CsV++OYgpJSMYHaSox4P+?=
 =?us-ascii?Q?7pqkmcylDSu95PcDronYYx9v/y3mgbRM+mFbu1YHx2ILkScAvOQngFS8bOPH?=
 =?us-ascii?Q?CwMhTj6NyOp3csvLuWL5iawjobBry5d4ZhBF9YjXMaoKTXb9Bph2gghVBHP1?=
 =?us-ascii?Q?2kz2zWPDIDzjs4ODH9UWbDIXy5BWv4d4tcus1q/uWKpeovHR9wCmXyWEvIA3?=
 =?us-ascii?Q?KPt3Q6nReuO6V032e3ISuoRASoVxH1N2TyUL3Xq9FUP3FpTQhpydUC4jonNE?=
 =?us-ascii?Q?wPHvGb3vbi8Zo8JosS68MVmfzsiwKjG/OqpG2U4/UOGdVyhOBH+oz8p8dDmC?=
 =?us-ascii?Q?fvy/rwQPkc3USVNSFsL4I1h/bwwhDB3uFQCNJSdL6+sZ0JhHgrTG18hoEGRH?=
 =?us-ascii?Q?5gyEk9vH/UQyt0YzgAmEngN5PvOgpk4eoZZTh9OJD3A5Ccu8zfsYXo54a2uC?=
 =?us-ascii?Q?xga4trwq97aD1nkxCMY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb921c0-700b-4694-155f-08dda1cc1979
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2025 11:53:32.9136 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1gobb69fihjNWe9ynFC14Z7IM9FjwWHdMgnwWn1XubgU9jKAidEQnrPR2ukWosEEHbQAEdPb1Qpurl7sNm9JQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR18MB4708
X-Authority-Analysis: v=2.4 cv=MJNgmNZl c=1 sm=1 tr=0 ts=683d90bf cx=c_pps
 a=A3v3qn6PhMMR3Z1noSFPxA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=89AEe5TETISvge3HjHAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: yP_IiUo_qahg00kmhltQkC0eHqXptKSX
X-Proofpoint-GUID: yP_IiUo_qahg00kmhltQkC0eHqXptKSX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDEwMiBTYWx0ZWRfX2eKW29ge7eQB
 b8HRIWajl8KI2cqCq5ES4bH64kPe2CXFOvZMwsp/p8QL79WM8rlZO+DcMA15EEXckfLsLAHP8pL
 ARunA3Nvi9pB24M7UkrlHG2cJ2ktZWwkmyowX1wCO6Uh4olxEjdIkWwPxLXw8d0clzWr6GVmtwD
 wGSvt1XHWjTQAnZSAdHbZZ6qtOseOoUie932947dlosOL0RVoOlmWqH4jPxlpRy8uTyG03SgRTH
 UKH1tl/DfF8bA06dul9GAmp5L2EyQFc5c2CHuHkHItPckUCM3Ii6CzbNQggQn8nqgwZ2XHHPgXx
 PiOSPLHkeAi6a9HLbbYGF7fsFqmVvBUwGF9dXtn/nhBW+jfFXybnz4bL4N/scXISshvngtZPN/Y
 7Ffpt8tHSgaemgp2HymWgkJKtDDsUpqEcNCXOqXPHuYBWzMjuW3xmc9ZCssqMemsII4iHy+Q
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

Also update release notes.

> Subject: RE: [PATCH 00/25] add CN20K support to cnxk crypto PMD
>=20
> Please fix individual patch compilation
>=20
> [2/34] Compiling C object
> drivers/libtmp_rte_crypto_cnxk.a.p/crypto_cnxk_cn20k_cryptodev_ops.c.o
> FAILED:
> drivers/libtmp_rte_crypto_cnxk.a.p/crypto_cnxk_cn20k_cryptodev_ops.c.o
> ccache gcc -Idrivers/libtmp_rte_crypto_cnxk.a.p -Idrivers -I../drivers -
> Idrivers/crypto/cnxk -I../drivers/crypto/cnxk -Ilib/net -I../lib/net -
> Idrivers/event/cnxk -I../drivers/event/cnxk -Ilib/cryptodev -I../lib/cryp=
todev -
> Ilib/eal/common -I../lib/eal/common -I. -I.. -Iconfig -I../config -Ilib/e=
al/include -
> I../lib/eal/include -Ilib/eal/linux/include -I../lib/eal/linux/include -
> Ilib/eal/x86/include -I../lib/eal/x86/include -I../kernel/linux -Ilib/eal=
 -I../lib/eal -
> Ilib/kvargs -I../lib/kvargs -Ilib/log -I../lib/log -Ilib/metrics -I../lib=
/metrics -
> Ilib/telemetry -I../lib/telemetry -Ilib/mbuf -I../lib/mbuf -Ilib/mempool =
-
> I../lib/mempool -Ilib/ring -I../lib/ring -Ilib/rcu -I../lib/rcu -Idrivers=
/bus/pci -
> I../drivers/bus/pci -I../drivers/bus/pci/linux -Ilib/pci -I../lib/pci -
> Idrivers/common/cnxk -I../drivers/common/cnxk -Ilib/ethdev -I../lib/ethde=
v -
> Ilib/meter -I../lib/meter -Ilib/security -I../lib/security -Ilib/eventdev=
 -
> I../lib/eventdev -Ilib/hash -I../lib/hash -Ilib/timer -I../lib/timer -Ili=
b/dmadev -
> I../lib/dmadev -fdiagnostics-color=3Dalways -D_FILE_OFFSET_BITS=3D64 -Wal=
l -
> Winvalid-pch -Wextra -Werror -std=3Dc11 -O2 -g -include rte_config.h -Wvl=
a -
> Wcast-qual -Wdeprecated -Wformat -Wformat-nonliteral -Wformat-security -
> Wmissing-declarations -Wmissing-prototypes -Wnested-externs -Wold-style-
> definition -Wpointer-arith -Wsign-compare -Wstrict-prototypes -Wundef -
> Wwrite-strings -Wno-packed-not-aligned -Wno-missing-field-initializers -
> D_GNU_SOURCE -fPIC -march=3Dnative -mrtm -DALLOW_EXPERIMENTAL_API -
> DALLOW_INTERNAL_API -Wno-format-truncation -Wno-address-of-packed-
> member -Wno-vla -DLA_IPSEC_DEBUG -DCNXK_CRYPTODEV_DEBUG -
> DRTE_LOG_DEFAULT_LOGTYPE=3Dpmd.crypto.cnxk -MD -MQ
> drivers/libtmp_rte_crypto_cnxk.a.p/crypto_cnxk_cn20k_cryptodev_ops.c.o -M=
F
> drivers/libtmp_rte_crypto_cnxk.a.p/crypto_cnxk_cn20k_cryptodev_ops.c.o.d =
-o
> drivers/libtmp_rte_crypto_cnxk.a.p/crypto_cnxk_cn20k_cryptodev_ops.c.o -c
> ../drivers/crypto/cnxk/cn20k_cryptodev_ops.c
> ../drivers/crypto/cnxk/cn20k_cryptodev_ops.c: In function
> 'cn20k_cpt_set_enqdeq_fns':
> ../drivers/crypto/cnxk/cn20k_cryptodev_ops.c:54:73: error: unused paramet=
er
> 'vf' [-Werror=3Dunused-parameter]
>    54 | cn20k_cpt_set_enqdeq_fns(struct rte_cryptodev *dev, struct cnxk_c=
pt_vf
> *vf)
>       |                                                     ~~~~~~~~~~~~~=
~~~~~~~^~
> cc1: all warnings being treated as errors
> [3/34] Compiling C object
> drivers/libtmp_rte_crypto_cnxk.a.p/crypto_cnxk_cn20k_cryptodev.c.o
> ninja: build stopped: subcommand failed.
>=20
>=20
> > Subject: [PATCH 00/25] add CN20K support to cnxk crypto PMD
> >
> > This series adds CN20K support to cnxk crypto PMD.
> >
> > Tejasree Kondoj (3):
> >   crypto/cnxk: move debug dumps to common
> >   crypto/cnxk: add Rx inject in security lookaside
> >   doc: update CN20K CPT documentation
> >
> > Vidya Sagar Velumuri (22):
> >   crypto/cnxk: add probe for cn20k crypto device
> >   crypto/cnxk: add ops skeleton for cn20k
> >   crypto/cnxk: add dev info get
> >   crypto/cnxk: add skeletion for enq deq functions
> >   crypto/cnxk: add lmtst routines for cn20k
> >   crypto/cnxk: add enqueue function support
> >   crypto/cnxk: add cryptodev dequeue support for cn20k
> >   crypto/cnxk: add rte security skeletion for cn20k
> >   crypto/cnxk: add security session creation
> >   crypto/cnxk: add security session destroy
> >   crypto/cnxk: move code to common
> >   crypto/cnxk: add rte sec session update
> >   crypto/cnxk: add rte security datapath handling
> >   crypto/cnxk: add skeleton for tls
> >   crypto/cnxk: add tls write session creation
> >   crypto/cnxk: add tls read session creation
> >   crypto/cnxk: add tls session destroy
> >   crypto/cnxk: add enq and dequeue support for TLS
> >   crypto/cnxk: tls post process
> >   crypto/cnxk: add tls session update
> >   crypto/cnxk: support raw API for cn20k
> >   crypto/cnxk: add model check for cn20k
> >
> >  doc/guides/cryptodevs/cnxk.rst                |   26 +-
> >  doc/guides/cryptodevs/features/cn20k.ini      |  113 ++
> >  drivers/common/cnxk/roc_cpt.h                 |    7 +-
> >  drivers/common/cnxk/roc_ie_ow_tls.h           |  233 +++
> >  drivers/crypto/cnxk/cn10k_cryptodev.c         |   12 +-
> >  drivers/crypto/cnxk/cn10k_cryptodev_ops.c     |  125 +-
> >  drivers/crypto/cnxk/cn10k_cryptodev_sec.h     |   14 -
> >  drivers/crypto/cnxk/cn10k_ipsec.c             |    4 +-
> >  drivers/crypto/cnxk/cn10k_tls.c               |    4 +-
> >  drivers/crypto/cnxk/cn20k_cryptodev.c         |  158 ++
> >  drivers/crypto/cnxk/cn20k_cryptodev.h         |   13 +
> >  drivers/crypto/cnxk/cn20k_cryptodev_ops.c     | 1278 +++++++++++++++++
> >  drivers/crypto/cnxk/cn20k_cryptodev_ops.h     |   85 ++
> >  drivers/crypto/cnxk/cn20k_cryptodev_sec.c     |  137 ++
> >  drivers/crypto/cnxk/cn20k_cryptodev_sec.h     |   64 +
> >  drivers/crypto/cnxk/cn20k_ipsec.c             |  378 +++++
> >  drivers/crypto/cnxk/cn20k_ipsec.h             |   41 +
> >  drivers/crypto/cnxk/cn20k_ipsec_la_ops.h      |  199 +++
> >  drivers/crypto/cnxk/cn20k_tls.c               |  917 ++++++++++++
> >  drivers/crypto/cnxk/cn20k_tls.h               |   40 +
> >  drivers/crypto/cnxk/cn20k_tls_ops.h           |  250 ++++
> >  drivers/crypto/cnxk/cnxk_cryptodev.c          |   14 +-
> >  .../crypto/cnxk/cnxk_cryptodev_capabilities.c |   10 +-
> >  drivers/crypto/cnxk/cnxk_cryptodev_ops.c      |  119 +-
> >  drivers/crypto/cnxk/cnxk_cryptodev_ops.h      |   34 +-
> >  drivers/crypto/cnxk/cnxk_ipsec.h              |    2 +
> >  drivers/crypto/cnxk/meson.build               |    5 +
> >  27 files changed, 4117 insertions(+), 165 deletions(-)
> >  create mode 100644 doc/guides/cryptodevs/features/cn20k.ini
> >  create mode 100644 drivers/common/cnxk/roc_ie_ow_tls.h
> >  create mode 100644 drivers/crypto/cnxk/cn20k_cryptodev.c
> >  create mode 100644 drivers/crypto/cnxk/cn20k_cryptodev.h
> >  create mode 100644 drivers/crypto/cnxk/cn20k_cryptodev_ops.c
> >  create mode 100644 drivers/crypto/cnxk/cn20k_cryptodev_ops.h
> >  create mode 100644 drivers/crypto/cnxk/cn20k_cryptodev_sec.c
> >  create mode 100644 drivers/crypto/cnxk/cn20k_cryptodev_sec.h
> >  create mode 100644 drivers/crypto/cnxk/cn20k_ipsec.c
> >  create mode 100644 drivers/crypto/cnxk/cn20k_ipsec.h
> >  create mode 100644 drivers/crypto/cnxk/cn20k_ipsec_la_ops.h
> >  create mode 100644 drivers/crypto/cnxk/cn20k_tls.c
> >  create mode 100644 drivers/crypto/cnxk/cn20k_tls.h
> >  create mode 100644 drivers/crypto/cnxk/cn20k_tls_ops.h
> >
> > --
> > 2.25.1

