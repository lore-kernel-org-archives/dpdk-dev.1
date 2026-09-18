Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C812C982D2
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Sep 2026 08:42:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2DF2D40276;
	Fri, 18 Sep 2026 10:42:57 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 7B5634021E;
 Fri, 18 Sep 2026 10:42:55 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68I5xWXL779728; Fri, 18 Sep 2026 01:42:54 -0700
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11022107.outbound.protection.outlook.com [52.101.53.107])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4grs0eagu0-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 18 Sep 2026 01:42:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bL/DwxZsPSc/PRfn/+5BTXvJcwD3dMzJ5pStgeJSD0Jo9A5reizCplNbNQyckrUUf3bCncBQ/Q2yvZHQrjrZ3z1HhR+dCo4MahltEjqtYFgA7soLCbPjc2+wOucmqp9Mpyx5wM4th3FiEXGNy/4Uz0wJYidNPBjbk4EWBgptU1+fInfsVHHwIIqX1xkMg1fbWnwf9eo5ac4i0D/L+gvlYqY60cyyv4KhReH2rEnbFoAEcDZJTuXn7VZySMkUeXjGYXPDUDNAe9l7z+SGHZMm8jwzamlTjElE4xJ3Hp/Nctab/KYRZoSUknf2hFEZrN54P11mYdf9H4tYyYSaKLuQ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9mDaXpyoY9n+H2B9rVhHogqhbcqxfw/9JuECOps31U=;
 b=Nao3WbABOaeTR9VQIP1xSnyCQ22jW5/rsUeUt3IeAzMIRxLju1f5ODnfw8gFmSCEXfh3XnUGW/o8vn9WajskC6zdjuVbMEiQvpWH57zdBF1vApVRE+FCdcb+wW+nVbtz0YpRXyiEh08L4Mb7XrZHg1JU0fg0nRF2mFs/sqTcyh7/fwEHPVBnMJOJHIIOvqm3WD5bz0RYVPjqcmrTeIALqZkKTkWLs+mFCKG5UYBpGUriwUBuMw2eBpT+7t0MoYafKdv+BPnI5b/WPu8WPV039VST5KKTy8LSWxrIKCUCidvPgQ+ql/mdPXuWf9Ldaf6fwYOKwNKt2piNEPpDJ5ayEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9mDaXpyoY9n+H2B9rVhHogqhbcqxfw/9JuECOps31U=;
 b=lWiubN+Gh2L5Kwbv48s6+hl5QDEFKMSEHbWqdlW9um6hAlFzpaqToSm3Vm0MHMvGdR7wJ6dM5REYbJ6kBB4hJA8mF6g305mr4q9sJkbmp0yNe9BGkUmMqRYm7K9fdNwjU9cGH0oExSke9/PR6dWl/59YyDNzi6YxuHXDqxQ9Eik=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 DM3PPF435E16BDC.namprd18.prod.outlook.com (2603:10b6:f:fc00::69d)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 08:42:50 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%5]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 08:42:50 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Nithinsen Kaithakadan <nkaithakadan@marvell.com>, Gagandeep Singh
 <g.singh@nxp.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "hemant.agrawal@nxp.com" <hemant.agrawal@nxp.com>, "stable@dpdk.org"
 <stable@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH] app/test-crypto-perf: reset mbuf state for
 IPsec outbound iterations
Thread-Topic: [EXTERNAL] [PATCH] app/test-crypto-perf: reset mbuf state for
 IPsec outbound iterations
Thread-Index: AQHdFPNaIJ+YZCenqUimnuC7MxDGVrZ2DViAgF5b32A=
Date: Fri, 18 Sep 2026 08:42:50 +0000
Message-ID: <CO6PR18MB448436618ECD2307FA1316FED8872@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260716071620.1550810-1-g.singh@nxp.com>
 <IA0PPF0A466555AC4AD40E85F8FC1BA7CC8C9C32@IA0PPF0A466555A.namprd18.prod.outlook.com>
In-Reply-To: <IA0PPF0A466555AC4AD40E85F8FC1BA7CC8C9C32@IA0PPF0A466555A.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|DM3PPF435E16BDC:EE_
x-ms-office365-filtering-correlation-id: 963141a4-e067-444a-862c-08df1560d281
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|10067099003|11063799006|3023799007|22082099003|18002099003|56012099006|4143699003|38070700021;
x-microsoft-antispam-message-info: CvWNtL36MY6CKK6OUWNBrGRbwsjggxcjjuJvXO3I6n/OLGwBJDXv+MfZs7npk9QEeCX/blqj6P5Sfw46avmX3Dwik9MCKNiUTKNjLhB3XXj6BJjgL3p+0KT7HoX+6viAM6aH8j5vL9cMVX7TR+qbG9AjJXSMNAisqJ22/YJhx+o8os9sXiWYRgvA0rl9sTotl/PD+l3p8pF2ZOjlZQLtB45LnoBLwZHxPfVkO1qsdW4+MSnWzqVNAetWMFiMlj72znF03jabA0jmlqo3EwInIToqUZVnN1W6r7dxSwuTtlRiN9mF5eNtCwcnzg3xadpl69rXO5fc8xNldrg4Kpu04gmhJjM1huyw3g/q9mNE8gUhwO+sRNGaEcT0IOS2+2loQ/GX2IrEa69MjtFaG9l/+7mmMukdhKMpl+VLtNfipHiZ+21KUpQMxoG681t4/KNmrDXdEYc7WPZUMcDAmiOe+6ut5wIrSgNC96chRcKnZDbJz6jtXacGnQQFkpJt/Nn6ffRmPxmXJOOTGzTxSbt75mlmu+fAPEL2WB8rvQoS5bfOReP2Ojl4y2rwP+yl1yf5KeI6Y4GD8nzwAdljjpFYAMQRdNnUMGAvBbv9xYVjjHF+pizY/22U3XvcuFJIoGweejuHXlIcsdi7BQQdyTeXBDc+MHLeYiLOA7D1XTWKR6t5xgoYceY3OQYTJNNdSwTEFqQN8HxirMo+ddRwuv+XUIf6pnlEj2WoxdoiuUtZWeI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(11063799006)(3023799007)(22082099003)(18002099003)(56012099006)(4143699003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tu8Iiw8MR5WEKclEQvA2nUWK/J7w82G4PKc4ErC5OZ0R3Ymjrr5p4PvuJx2b?=
 =?us-ascii?Q?oECU8LqUKU5yal7OR9d7ZfFaK0D7FfrEUoJfRpuOZ6kKTWajiZ9R+zQiwxub?=
 =?us-ascii?Q?R6rtC+PBkjMQMXxSRrcf/oriqJZYHiviNmFPFm5VLNr0HWzejLWNnfglaEAw?=
 =?us-ascii?Q?/+HjNPID1nLq38Hd7aXZbloypPVBWQQQG5FUgeHVePgaP0bpeWP7JUwG6HNI?=
 =?us-ascii?Q?v82pkezYaKkRf4q9m8Sjh0oormZzt/oiyPWBWESQ9kgYTJJGgB69B/GtZ57B?=
 =?us-ascii?Q?/ENUKocvdQ81MIET60GvwoeQzxMgOYEnED/nYoF006cJobwCEE6Jli6xRz9k?=
 =?us-ascii?Q?NYcYvRWRz9cJevJHSwPiKx3p6dzXz8st+6ir6TaAFCwnPbEVZMk3YVyC21ea?=
 =?us-ascii?Q?fGB7eTfk6dwX8q0z18Q6fWIizLIgMU34+IpangbaEVoY4iOF7IqviK+BEaHW?=
 =?us-ascii?Q?jEL+fXtMQT8QAVJAefzMz3L3Dp5aODOaQWusrZwCdkTfgNCFWNGbBl0s1vd5?=
 =?us-ascii?Q?4zQ/APSiIxhg88/nfgWnlY6nq0bq9lVNdjOyVqWtBnvnG+NMAKMbSG0TVyO3?=
 =?us-ascii?Q?x4nFNCohjhGfM8HBucS04PP046hZRpeSvXtSJ1gqleN9TmRqwdP9ti3KHoCo?=
 =?us-ascii?Q?O1cH7enClzIt1CYa2I0OMaZjG6SgLte4ALKuMw3cVVqc7ggQb87t31TAy50t?=
 =?us-ascii?Q?fl3aBVC1d3XIo07LBVaFWxsnc077YuJw2Q3L35Tp7ce4ZB93ScKGVLOnjgBH?=
 =?us-ascii?Q?nBVq/EzGzVU2IS1CKGdD8aw+jr++RtMbda2mbLDh5ZrCBTI5yNoWhvyg/nPJ?=
 =?us-ascii?Q?VV+cwsh3Qp13PXjyQ1O+Gdx/Y3iev4GQplL+Jn77w6+8WGie7oTRrv2P5E7v?=
 =?us-ascii?Q?ZJx7DBVpE66M+gsti5vzjoxzVJc+OXmxsbIanqgzKiz7suqiHz3HwzvEYXO3?=
 =?us-ascii?Q?qnHsDfAZuhwwNXPMSIzJ22HpCx9rXoUkl2l/6MipL0jvLXCgZ/4/4DacbMSM?=
 =?us-ascii?Q?Q+BTb24J8XrPElUsYvyA0nKM4EqOzu6aedq2GFTmbsnfAWjlSyAF7SJMJmPv?=
 =?us-ascii?Q?RU8f+JEzZnkMPXVmholgTu2PnW5+97uxzbbqvCeIj/j6vRGvYArd5SCrCnt9?=
 =?us-ascii?Q?6+Dah0jwFjI/hx7LUQNABxNhaEAeylG50taDCjQ8Wiau2uo1S1MfAWexG431?=
 =?us-ascii?Q?KxShGXEGpjeXtuAMWO3QB9tpWrkpdby7zKPMgBTzB3QVyIkkrffmklsQvEyv?=
 =?us-ascii?Q?lcXJsS3E5sVXor8zeuvXk6R1O6fNTX8NLuWIe5cAlgiw5FagrTASPaF6BYnw?=
 =?us-ascii?Q?k2DCcbmZBV7dIeQ2IndlkoR7i7RcAwjnifEIoXggZ+Z+TZsoNghGaKKAxXxz?=
 =?us-ascii?Q?MlYjV2aMYVp9Fsoeir8AEjddaPL25KoNqkJmb6MIj51Kg/TVuYFKv6voX2Fw?=
 =?us-ascii?Q?/UHA9gu6vSMX2NNKfcrAZt4/qDh26LXgtTgej22ATl1LtdjCf3TMLD+e6057?=
 =?us-ascii?Q?FSwCxxE7n3tf+xo6ujrL6L/F1KF9rI7n28cdI/o4o1ewD2eIebzllvo5ALVf?=
 =?us-ascii?Q?v89RyY9IiW1+84aKTAIUU+EiuGRJC9byfKtS5r57p0tXjmk2Dp2Lf+Ac5/49?=
 =?us-ascii?Q?6dej3vk0bhvI1nTRCFJKrShSA3Oe3ngiq3ISzchQp4YLqDt73BsqjnqPvd1j?=
 =?us-ascii?Q?ep2FJJUc3OWEqcj77Ai6EyeWQdsPySohq5NipFhWo29MBW6q?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UAxShQejgaFlFywzoL9ZfAO0lSUrc1ebMc2iBed6RJ+B2XAaqnEOh2ZvKCo+1xlt7IJLVS+KKq061SYK8VQ9p12E6wFRY/voxI7xlcqRtI9ynLyJqhj13rWl7arApNWrMlLle6zXLwiIjedzRrSVXja3KX2BRWmBujDTL0wdNOmbMvo9MOGQgWyD8b0o/xERtysQF4wEkbho72SxbCJ8fq7BZ+6BFwHAcUKQJKkAnErJOcueJrtKF7enMR9UqpAeKUKK9ocbXr7T/N5ojCQdTxfxNfWSpno57Eo2KEQgIAD2WD4EBKXWCKtBy2w91Yn/LYG+z7ve+snnZwDQ4VxAdw==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 963141a4-e067-444a-862c-08df1560d281
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2026 08:42:50.2328 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9xa6FpfzSG4dFpGpxRq8a6zek3LrJGBgz8a27F4xC+/jwXu2pi6EKmy3beGpkoYrQH5RTPOhy85LSaC8zFUyxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF435E16BDC
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDExOCBTYWx0ZWRfX6dtg/5bjmMP4
 kNkcstnkKU/LXA7OsndpFEH35ZJ2mW8l8dNm/EpqNziEitvRmLGOEkjbci9fvma3T312sIqCxB7
 I9Ti+qNgLtGv6Z6nWgMtM5xGjaaVbEw=
X-Authority-Analysis: v=2.4 cv=U6YHnuru c=1 sm=1 tr=0 ts=6aacf98e cx=c_pps
 a=DIqcA6Wvos/1kaZ0X8IXZw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=8rWy6zfcAAAA:8
 a=8AirrxEcAAAA:8 a=M5GUcnROAAAA:8 a=9TjD44vUCLxj2Y1dlnAA:9 a=CjuIK1q_8ugA:10
 a=YjdVzJdQTyZRADMV7wFX:22 a=ST-jHhOKWsTCqRlWije3:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: tCz3qY-AVBK92wXs8y69cWYSeuqCvxwc
X-Proofpoint-ORIG-GUID: tCz3qY-AVBK92wXs8y69cWYSeuqCvxwc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDExOCBTYWx0ZWRfXy46UiuuuYBaf
 1jjSO1BcTb/upLpx8sD/qWNsULvBsyMfQmxGgWRmR8/VvT3XQbC+j7OolX40zIsWd91/dsIz3cc
 mGIQnbrIOIL0v6+YigTcdQq0J8KvZ26nLC7CoeTD9j/qbugopSuiKvVbv+H1SJW1kElSJ9qWLl0
 F8Pk6uDvFyR/NMvJytCFoZFb0zUvK+jB+Mmt357AycXkGy2NdgJCHelwW1H5KwSEwUczQ7tqahs
 MXoc3ARCe/SchnLLGoscmwaS4bMDB9FGYKzCUhzhaVGfNCpQXJj0Rgq9AMQQq9w09GeSaNJwQ8W
 acyUdgFgjiXoUyau4bxfWdZ/ljpaSOkRI5Ab+8M5rvxHoEVCO75+543GPFilU6ZVYQOXRi+ttej
 Ihh8rDnhu8J8sY29HgPeq2EwsrX415QlPgrPFkQDmwK5f+1lh0wOFBmmZ90CKKaHI0qh6WqnPlm
 1f6P6AI0dIbFccxIDPw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
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

>=20
>=20
> > In cperf_set_ops_security_ipsec(), the same mbuf is reused across multi=
ple
> > throughput iterations.  For outbound (encap) IPsec the PMD may modify
> > mbuf metadata such as data_off, data_len and pkt_len as part of in-plac=
e
> > protocol processing.  When the mbuf is recycled for the next burst thos=
e
> > modifications must be undone so the PMD always sees a clean, freshly-
> > allocated-like buffer.
> >
> > Use rte_pktmbuf_reset() to restore the mbuf to its post-alloc state in =
a PMD-
> > agnostic manner, rather than patching individual fields with driver-spe=
cific
> > knowledge of the expected offset values.
> >
> > Without this reset, drivers that back-adjust data_off after encap (e.g.=
 DPAA2
> > SEC, which advances data_off by SEC_FLC_DHR_OUTBOUND on each
> > dequeue) will receive a buffer with insufficient headroom on the second=
 and
> > subsequent enqueues, causing hardware errors such as:
> >
> >   DPAA2_SEC: SEC encap returned Error - 50000045
> >     (QI error 0x45: DHR correction underflow, reuse mode)
> >   DPAA2_SEC: SEC returned Error - 50000020
> >     (QI error 0x20: FD format error)
> >
> > Fixes: 3b7d9f2bc6 ("app/test-crypto-perf: add ipsec lookaside support")
Fixes tag is not correct. Fixed it while merging.
Applied to dpdk-next-crypto

> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
> > ---
>=20
>=20
> Acked-by: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
