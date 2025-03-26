Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F969C36008
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Mar 2025 19:39:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D2184021F;
	Wed, 26 Mar 2025 20:39:48 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id E2EA740156
 for <dev@dpdk.org>; Wed, 26 Mar 2025 20:39:46 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QHiPm5019644;
 Wed, 26 Mar 2025 12:39:46 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 45merw1e8t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Mar 2025 12:39:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QcpWx8Elk+sGuA+hfYiH43G4/ggeO+8fUKvH6ruSmZMy28Gj/QsKdNKLIrp9HxmiQvI9OmB0ZdVVu95UmGij2WGVY/KH6cvqriBXZDFULNLq9RkI0U28ySI5I8YeiAEse9YquRItsfZBOX9SJercFw4WyJlp9JkZ5WnTNBVdlALWzkpESZZBoX8X40Qp09yNhCAJWZYsBCe8ec+/WcN18YkgImdOhDPBY0y/TtfwPcZ+L79kU+i9alotXjFju7lKGBT4cJJwFBo8dRc7ANZk7aDyLt69PqEtMBLt24URDMfip7rnhdT1AtRj43Cnbg/HEP9FeoS3oeXgureeElA+VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BYFjf3quDevNIMnPXkZgPoM1R2WTHQmpOcjTiRU9IRk=;
 b=ydg3hLHFHAXQlQ32phixMQRt6Q2Si8zOTJ5o2B56rm4D2uH62sQJB28oFrx7lQ0dYGobu9CRn42Cs48uj6A0tDPxASUTjAE4fwLIN+qMrSwCc2XCq2GNfOkiy5BgHpTTrAvLATwtKHBqdKvH6s7S+qoyahig5l7KRHLzw4ECYe7nS/rotppiqiYP1/vMPKCMkTmjKsImkNhJPNeoIm7VSnqwgObZ3bFjn0qAQ34uYDYkOS7mC3pZdO8j+24oDS+5wpsJSad5PeBbIeU9kXfxjIPnTRBwqMLvHCuXCY8HGKKl0js3N/4d2K/8F5vr/e1Enm/JGFNCRGVWK0StHZNccA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYFjf3quDevNIMnPXkZgPoM1R2WTHQmpOcjTiRU9IRk=;
 b=rvyvidiIJEyh37HqzLNFkGxDeMjvzpnYSL9RMetFEw+XEzG2YxIFKkxfW4a2k44A0HRrWIZZsWjZyGlboK1VFwexFuC623FEdX9OysvP0jy84ytDUwM0201VG+kR/By2N1zrytfs1cPNYhTyMQeMMyIiAKxlTm+fFxoGBxWQnvE=
Received: from CO6PR18MB4084.namprd18.prod.outlook.com (2603:10b6:5:349::18)
 by BL1PPF03AA8DBB5.namprd18.prod.outlook.com (2603:10b6:20f:fc04::d86) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 19:39:42 +0000
Received: from CO6PR18MB4084.namprd18.prod.outlook.com
 ([fe80::c296:9e34:99f6:944d]) by CO6PR18MB4084.namprd18.prod.outlook.com
 ([fe80::c296:9e34:99f6:944d%4]) with mapi id 15.20.8534.042; Wed, 26 Mar 2025
 19:39:42 +0000
From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
To: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>, Jerin Jacob
 <jerinj@marvell.com>, "fengchengwen@huawei.com" <fengchengwen@huawei.com>,
 "kevin.laatz@intel.com" <kevin.laatz@intel.com>,
 "bruce.richardson@intel.com" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [RFC v2 0/3] Introduce DMA enqueue/dequeue operations
Thread-Topic: [RFC v2 0/3] Introduce DMA enqueue/dequeue operations
Thread-Index: AQHbnoZtM1tMcE/sxEeepkzyt6J+9bOF0FFw
Date: Wed, 26 Mar 2025 19:39:41 +0000
Message-ID: <CO6PR18MB4084CB125E5C62AE88E44844DEA62@CO6PR18MB4084.namprd18.prod.outlook.com>
References: <20250129143649.3887989-1-kshankar@marvell.com>
 <20250326193637.12557-1-pbhagavatula@marvell.com>
In-Reply-To: <20250326193637.12557-1-pbhagavatula@marvell.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4084:EE_|BL1PPF03AA8DBB5:EE_
x-ms-office365-filtering-correlation-id: 3af877f4-eb4e-42a1-e929-08dd6c9df456
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?7zdILPZ8L7a9NPQzbAhfv2ihUXM790iyXma2J9nHDlohgkQQNnlg9l8mGQfw?=
 =?us-ascii?Q?l4h0nbYIxCPXXaZ3l2eN2tMli9UoIY4uhmikEIOPv14FWGkL9qmJqoTUrCjT?=
 =?us-ascii?Q?mLyALUxK6A2aVeOfIhS7E1VGLa1cTnDd/5IWyUjnRzpPF4umzzVmDMM3fYct?=
 =?us-ascii?Q?JedHbM+O3GIUI2IKvw7ZEd6VbMZKvIJdy32c7H15Gb3Rr2ut/oug/IFVQ5Eb?=
 =?us-ascii?Q?UpCIdc/vTxqMiuFWD0u70aWnyP7V3kYz6shi9LCirq2VLZ5VSFMGFj4BK4/t?=
 =?us-ascii?Q?jck3WfjyMRFJR6KsLXeh/DzqYI8Cu07xg+YAusYBoPzE8plX3G1lmPLl8xcI?=
 =?us-ascii?Q?1ev1wpjA04c5CtaiyBe+CkECKUuy9rdvzLFGVaO+4k2JU0k0stTLGDOVVOQa?=
 =?us-ascii?Q?adl7r9o2zm2K4b21m5vEKr15uVwJF1mbZ9RlEIKwj8aoHdefyKdiJf9aI1u+?=
 =?us-ascii?Q?TisSGco7y641JaNfWMpE+A9hZnfIRjXj8A8xbVwMLgPRb4v9Ccdp18cxcchF?=
 =?us-ascii?Q?ICp9+j/P97NXihYrPSaaO6FiHKOjCeBwnlG4w34Y6YDd3yjXs8iDt7MibwUv?=
 =?us-ascii?Q?E1tAJOZfqJsJ6hJfsLAZ1Eawj1KrWxcXHdl50raD+PrtuXmqonSCAcC7ozpk?=
 =?us-ascii?Q?8PIy4h5EOFVoZxH0rkZHp4k2KGKuWPrZ+38Agy9Iosh3V/JxYAl4XPJnvhXV?=
 =?us-ascii?Q?rVD8wijLIle84+rZ9XAYR50fKR+z9qa0Tg0kjnjYKoV0U9Z7/PWMBjlVeHnF?=
 =?us-ascii?Q?ZuaZX+Fm6pQ+4AKR9x9IWSB+8XwOSXZYm/C5V1Aq6+57TnYYSeWh0hry+HDg?=
 =?us-ascii?Q?5hJAv11Wxh5D410Y+mZCH8twUSwQYvzVicZuoowo2dHDogwcDdO71QhQ1XY6?=
 =?us-ascii?Q?HKArKKG0Cptfh5EAGsIhpiN0R0MGE+OVS/zb3ZiyFb8Gz38CQnNiN9DSU4ie?=
 =?us-ascii?Q?mha1/9n3liYcjF+GQw9O7nfLdCDGTpkUvy8wLreLW00brXLxFjC+6TnA6HG8?=
 =?us-ascii?Q?Abv9tAWDKkkz1D1IvHCtZafpBtCDSGp4pBxCa7Vd1wpe+b3OlYT+4C1FVLoq?=
 =?us-ascii?Q?GDJBQ8Z1Qx/fBkvhL/08/f6AR2EKzo+wdkLaqXPeTzJhQeoIlYzVxD9zhgrQ?=
 =?us-ascii?Q?rJPQy3wQur9FsFwBRJIJ/RF9xHINwj2GzTbWhRfQ62Sl00otX7l9HwPEyK//?=
 =?us-ascii?Q?pYUj1EsCitEQ+le+EMSexzsbNnlHHsbgil/Zkr0gVbZQFEPBSohDcEdrU+9q?=
 =?us-ascii?Q?P/D3HNIIJHRj8Mgk3J2X2Du6RmJpztvS5G6qV5hf58T5QWHLbLRWJk8XGfPD?=
 =?us-ascii?Q?9mdfzIH6jNnew9ethVy5xb49bu2R1dRW2C6sI0R9lqgf0TXcRd39ZkzfTNt4?=
 =?us-ascii?Q?ujIvDbp7Og/CjZN9mZ7XeNye8B03YTdr/8eWY5PwhY0aH8sNQyz5y5e1SzMA?=
 =?us-ascii?Q?C6Ky/eWJM6eRuT+kAiPYuH8dmRB/JlR1?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4084.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QZ4eMI8F4urGXHwOet1uy0WyvUZIy0TOJbX56CGB0OTmzYbh1YB7/TJT0p/5?=
 =?us-ascii?Q?Tk05tJ02xV07SiZSyTZHaivBsjoS4ZunpcOpSr3PzUtg+l+vRWuMeC9y4zjB?=
 =?us-ascii?Q?5mUAZdayzUWNIAitBnGVwEyN33RdsfSS6AJvPzGh4AOnjhCs2KDGpKBQTwSL?=
 =?us-ascii?Q?22F1jRAIorfouyK0EY5uRUh5gVgYAkqKO7n/WWoOct3gqoALMqbOdgon2ZIF?=
 =?us-ascii?Q?WkIeYzmrdSshHDvyxBqj3MhPkls65xSHIMB7lgsHNOjsS+nyKORQ+V7COYW4?=
 =?us-ascii?Q?r28NMTJ5T/KSs1PaYCruc9RBirJJckYYooMMVSbcbgebIYWn9QkykQDN4IfS?=
 =?us-ascii?Q?dAb+v3XiQIMubasxrmmyam3ODrtEyo4hMu7olBDhsVGTrdfcwDL3SCnpY1v2?=
 =?us-ascii?Q?XEOnGfzREEMLwAGhjXAakf+gSA0XtHP1G9YaLWTTX1QallpGuANxQ7q2V4Yy?=
 =?us-ascii?Q?e/aE9itKohbtzARDhMQ1FyCTAzHZA4lMIq4tYvUPsVA4dpf/rMql/ipRBQ/v?=
 =?us-ascii?Q?utFiMtRgJFYJQtxpNDos7zq2FqI+rQg8RSBXF8RgrKhlteitoshhXP1txTN1?=
 =?us-ascii?Q?50zH19wpt4f/UaA7eleCtm394kmPsRa7GD3+AJ+gNYz6uxiJk/so4Dzx/Q9Y?=
 =?us-ascii?Q?XRYixvVXNFdYvVpmc5QaXFuujkADXxE0e90NdjiOlTQN381CvR5mkzvOd8+b?=
 =?us-ascii?Q?6vSrdbYOHvEQD8z+JXZjdbSjU1gd7SPjJOvYDaswD92UI9G5Vy2XVQANKSnR?=
 =?us-ascii?Q?vLzD3GHoSepVD7ZaoADsvIul/QF0ZPNfZwVs4K+LMGWGmN+r1/hwrnd20h1h?=
 =?us-ascii?Q?QiJVwKWj3ry7e7IUH9A3c0nYMXvDSmsSuicF+ehHbY+OGQnC8l22NNoKlzdQ?=
 =?us-ascii?Q?xJrQn81Tm8xAmSe+9xHvc5sOEVVEgc9rU4ieSfj01HC8u9S1KE16pKkeCT+U?=
 =?us-ascii?Q?5M42r/CNhumI8ibhi9ESNORtQP65nyqRe3NU6D1VHrTR4XZ9T+zhNLzgC2cF?=
 =?us-ascii?Q?I+UdLxvSImtuJ5/6At5ydRwSyywErvEqoXTStvVnHP63IR+GY2usMJD7Kjbt?=
 =?us-ascii?Q?2/Z5CGPGL4yR24HriGvlytJ8FMemSydAiXw74LPi4ci6Dtm7O0tYsqwTpl5J?=
 =?us-ascii?Q?Dyv1zYIIJ0e028wFnzEkKQBpSTbuWbXNchuxib7jekd+c7jfrZ64oLTy3vlt?=
 =?us-ascii?Q?Q0lRTglxyIBmX6pdKh6+Qz/FpEEX25T+JaJbMEeGwYs/LwWu8GtKwJKp9IPc?=
 =?us-ascii?Q?lKHucyYGMcTuRZWe7/hO0NAdick0wuOliXNcw4q02hmB2LkD8EyL7x7pxIhE?=
 =?us-ascii?Q?rxIA8sPmhbc/lDbtUMHDAvhirtA9zvmAg8eNXu0DcC7nbSS5/Y2nLdD0wg/n?=
 =?us-ascii?Q?jSxixaouPCOXfd1Z5Q7Km10Nv3DRLUsuiA58V+lJmCO0R6uhdOrWalwwgAdW?=
 =?us-ascii?Q?bY4rpyxI/5N2I9fWBil4XNxwTrUHTeH+qHANoAmbXVpehKvmb6z/PP8aXLl0?=
 =?us-ascii?Q?SuFsxrXXIQXLoJrIQeBG/sauz//oMSbsEXPDV1R8wqwYmvhMECui9imOGfQ9?=
 =?us-ascii?Q?kMw5VMJ92J/FAtZsG+4tf+/OlkGXvCpKiub7sBIv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4084.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af877f4-eb4e-42a1-e929-08dd6c9df456
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 19:39:42.1232 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UBPOSc9Ux7Oke99q9Ij91edcBp6bT1BQb/istPVuM29JTCV1PuZoc7HzpzWmYY3D3bkaUbTcHVCKMc9uKyHOdVbNU6QJHiAAaqFfWEy1kRI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PPF03AA8DBB5
X-Proofpoint-GUID: GOC0eqnHsByw8ewip-2bxL9Sh5OKf8ZX
X-Proofpoint-ORIG-GUID: GOC0eqnHsByw8ewip-2bxL9Sh5OKf8ZX
X-Authority-Analysis: v=2.4 cv=S9nZwJsP c=1 sm=1 tr=0 ts=67e45801 cx=c_pps
 a=AuG0SFjpmAmqNFFXyzUckA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8
 a=8rWy6zfcAAAA:8 a=-swvvnw5JcDUgg2B5SoA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_09,2025-03-26_02,2024-11-22_01
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

++

> -----Original Message-----
> From: pbhagavatula@marvell.com <pbhagavatula@marvell.com>
> Sent: Thursday, March 27, 2025 1:07 AM
> To: Jerin Jacob <jerinj@marvell.com>
> Cc: dev@dpdk.org; Pavan Nikhilesh Bhagavatula
> <pbhagavatula@marvell.com>
> Subject: [RFC v2 0/3] Introduce DMA enqueue/dequeue operations
>=20
> From: Pavan Nikhilesh <pbhagavatula@marvell.com>
>=20
> Introduce DMA enqueue/dequeue operations to the DMA device library.
>=20
> The enqueue/dequeue operations allow applications to communicate with the
> DMA device using the rte_dma_op structure, providing a more flexible and
> efficient way to manage DMA operations.
>=20
> The programming model for the enqueue/dequeue operations is as follows:
>=20
> * Query DMA devices capability for RTE_DMA_CAPA_OPS_ENQ_DEQ through
>   rte_dma_info::dev_capa.
> * Enable enqueue/dequeue operations on DMA device by enabling
>   rte_dma_conf::enable_enq_deq during device configuration.
> * Allocate a mempool for rte_dma_ops with object size of
>   rte_dma_op + (sizeof(struct rte_dma_sge) * rte_dma_info::max_sges * 2).
> * Configure vchans and start the dma device.
> * Get an rte_dma_op from the mempool, fill it with the necessary
>   information and use rte_dma_enqueue() to enqueue the operation.
> * Call rte_dma_dequeue() operation to get the array of finished operation=
s.
> * Free the rte_dma_op back to the mempool.
>=20
> The enqueue dequeue operations are not compatible with rte_dma_copy,
> rte_dma_copy_sg, rte_dma_fill, rte_dma_submit, rte_dma_completed and
> rte_dma_completed_status range of APIs.
>=20
> Pavan Nikhilesh (3):
>   dmadev: add enqueue dequeue operations
>   dma/cnxk: implement enqueue dequeue ops
>   eventdev: refactor DMA adapter ops
>=20
>  app/test-eventdev/test_perf_common.c          |   6 +-
>  app/test-eventdev/test_perf_common.h          |   4 +-
>  app/test/test_event_dma_adapter.c             |   6 +-
>  .../prog_guide/eventdev/event_dma_adapter.rst |   6 +-
>  drivers/dma/cnxk/cnxk_dmadev.c                |  27 +++-
>  drivers/dma/cnxk/cnxk_dmadev.h                |   7 +
>  drivers/dma/cnxk/cnxk_dmadev_fp.c             | 152 +++++++++++++++++-
>  lib/dmadev/rte_dmadev.c                       |  18 +++
>  lib/dmadev/rte_dmadev.h                       | 145 +++++++++++++++++
>  lib/dmadev/rte_dmadev_core.h                  |  10 ++
>  lib/dmadev/rte_dmadev_trace_fp.h              |  20 +++
>  lib/dmadev/rte_dmadev_trace_points.c          |   6 +
>  lib/eventdev/rte_event_dma_adapter.c          |  18 +--
>  lib/eventdev/rte_event_dma_adapter.h          |  57 -------
>  14 files changed, 397 insertions(+), 85 deletions(-)
>=20
> --
> 2.43.0

