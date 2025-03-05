Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB12C19F32
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 09:57:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0658040156;
	Wed,  5 Mar 2025 10:57:03 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id C4B06400EF
 for <dev@dpdk.org>; Wed,  5 Mar 2025 10:57:01 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5257QQDY030006;
 Wed, 5 Mar 2025 01:57:00 -0800
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 456j7jr8ks-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Mar 2025 01:57:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UaO+qqN/k/Ki3CCXUa214L0pM7psOMaBfM97Cnqx6nvDBMuN9Y4KHU1zLkXKYDY3bzi7fhJlzWwedDvoDeX3Zzu+hPjZDeKawwNkfILKmB1d5s3udF/CRNTrNlGybJXDm3hZfo/eBnxDOk7mnSs/FdmcnBObSWpEqu6lc6ZRWn/qqOJp96WDj+ULM7KAMXr4pZpID6hP6KLyt6kQ2FNWEKbouPoDZ8VpZHeQSUrakTzhFMUrfBIW8r6CVDxFzS2MvLQGJuZZduxTyYRqJFY23TLh6XjEiBZ9aqo2ZrtrhcJDSGxwsafEdqTr0a5NYGqzpXiErHqPWby9BaxjEoaixg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IcIThEatOSN7+xwd2cSsU37QgYDH6ecIWCPaiC4dvUw=;
 b=MbGubf4yT7W7WjYaJYRvmhMmyPfVT1QRMWtlPcY2Mj2mcTWyGSEkL0W89PzuHwts6eOMULqBZlYspTh0gY7CNUDdgnlaDy2SpHmW3gw9+/ks3VNDTFFisq4FpQ8z3dLZvB43J7snauzsocQJZldEAC9ULkpiSdFqaYW7oXs7VnpyKCGDBLMDWKKxT9Rgv5mzWUrcLHtqtZ/dJHY8aMdiJkd0Icvakc7jtq12VocB3GlQAKXFgvHrLHJrnS8WRxPVSjk1fYea+pprsuX/ePIqeB2y/FbLrDhevSirKmTjQyYSaTsjgCQlNYH1SKM8YFXfAsusZyrhzhb8W/1Z93bU0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IcIThEatOSN7+xwd2cSsU37QgYDH6ecIWCPaiC4dvUw=;
 b=Z4p4FJMh3fRigZjrvRB2ky+SrbtN3t04CWW/qkQfReLrdGS1SAM8N+iVjyaPTM/TGWnjgcHVgMd02AOp55imFgVWVjz2yV3korD/i13Kj9edmRFHxsH8FKEaVIqlrk59F2iP9ImHt6A4Fo9TqxENSQa0nuD0YMz5yu4qRzQ4Uv4=
Received: from CO1PR18MB4714.namprd18.prod.outlook.com (2603:10b6:303:e9::18)
 by BL1PR18MB4374.namprd18.prod.outlook.com (2603:10b6:208:31d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 09:56:58 +0000
Received: from CO1PR18MB4714.namprd18.prod.outlook.com
 ([fe80::26fb:729e:a947:3e06]) by CO1PR18MB4714.namprd18.prod.outlook.com
 ([fe80::26fb:729e:a947:3e06%7]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 09:56:58 +0000
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Maxime Coquelin <maxime.coquelin@redhat.com>, Chenbo Xia
 <chenbox@nvidia.com>
Subject: RE: [EXTERNAL] [PATCH] vhost/crypto: fix locking
Thread-Topic: [EXTERNAL] [PATCH] vhost/crypto: fix locking
Thread-Index: AQHbja6/0EcrM+Oi5k+urIKJcwjgBLNkTecQ
Date: Wed, 5 Mar 2025 09:56:58 +0000
Message-ID: <CO1PR18MB471413D880A631D510BD247ACBCB2@CO1PR18MB4714.namprd18.prod.outlook.com>
References: <20250305091217.590887-1-david.marchand@redhat.com>
In-Reply-To: <20250305091217.590887-1-david.marchand@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4714:EE_|BL1PR18MB4374:EE_
x-ms-office365-filtering-correlation-id: 324df738-607e-4bb7-2a6b-08dd5bcc11a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?+S+yE9ryA+WNjNK5SlKDZ3CGC8J8rjq/+qCjYouG/aDjBWcuOLwRAKYwUMgq?=
 =?us-ascii?Q?TU2j+x3pmG8JxTEJ5mGXhp3rnP7nU0jhAMC8RfImHSpv/neyvk//LpQMKYoJ?=
 =?us-ascii?Q?1mTrsC2TarWEKEtQUVal4mHl0rYj3eXk4jo1CndhtrUHZ243ku9gDQW+RTfR?=
 =?us-ascii?Q?M7VFNliIKFkmPX0B6RTZwMxx7jq65+nYQVI0R+9WO5chmhZksN4RzN8tcPFk?=
 =?us-ascii?Q?rXcupoNiI8/k7KMWwtz6pD07X4NdMw190uQ587gCHJZBa2gocdxPpq2uX38H?=
 =?us-ascii?Q?XA4HT0+F8ZhWUpO2gOc3s0MyCDH4/2EXBwP3wsaDk6KGrLESCxtFj+I/bTDC?=
 =?us-ascii?Q?13OBxEDoz8+VdXPLNrZHMSaO3Wt7OBgkbUba0ce5giOvHWUrQ6fv5VfjgTg1?=
 =?us-ascii?Q?jJuQz4Rgn898HeT9VqcxmBikl/x42vxM7c7atxe8nfSIkZCqB3hZup1/5K68?=
 =?us-ascii?Q?Ko2sNcgyfcJqDSvg2QuVlLfpVaIBk9nOSmENKME/wU2U5Bx2AWi+mXJNMasU?=
 =?us-ascii?Q?GYE7GxMjzxK4SV1+bfmA/Gz4W9FIDByVvr1CKPrZwV8uoN2S6v4aaFtM4r49?=
 =?us-ascii?Q?J3rkYO3PwLrN4D7IKH2tWSa927MW6iAm3FWflXKpBkzDfEl/luQK4NexBUi1?=
 =?us-ascii?Q?rpunaMrijJ9LeQdKd1eVrJYXmuVHcY7j88kuHtKrModA2nNeUa2VtITSflqp?=
 =?us-ascii?Q?pE6pE+GdVwaoGQWuBJjzR1KWwpVz1t9cMd4bF/zwh5rbB/Q00l6T6zWbAiUR?=
 =?us-ascii?Q?qAjGuEP22lNaZXO5SKS+WAhWD77i5zzF0ltPcLXL30Zcp62AyZGBqysCzPiv?=
 =?us-ascii?Q?FqNTzMpbvZHk1Bdkjd0buEoOurvx522ryx8LJM088K1eBOHl/TAKObvTr8v+?=
 =?us-ascii?Q?H52Ly5gerxcD5sQig9IBaTuOINRsfzyOPCwcpv+ZpTsCclUiK0e3aKQxg+9s?=
 =?us-ascii?Q?YGGJ1z5Xd8fbgfkHHiWcLZ7VeJBYF5Btql+2PikolsMftv0TPYJ5eupIHCN0?=
 =?us-ascii?Q?ImTLM/7LdJf7W/glDZImYwegnNrEVVnwIzfjkRFzUtE7eO1VN5tZ64icFQA7?=
 =?us-ascii?Q?z43KnPQ4Lg12JyWtF+7Lq67Wj8mgvpCvdciQWvJTiByrETjuxuJq4pUHMQjF?=
 =?us-ascii?Q?52X1jDd5IQfBTp5B7nj2u0V/8140h3uy0/TPottRVK+XsaX+Cvnimq/mOCCx?=
 =?us-ascii?Q?WmksVFAUgn/Aa9yTOPXMmBVtaGiV3gIuCnsAAUWfUxQimw5M1S7MWysjUFqX?=
 =?us-ascii?Q?HdoHPr0QCU7OpBzNpQv2G4Qsmar780CZM09+ua72AVe+706M1F5SEWpLravv?=
 =?us-ascii?Q?F2KWnkN2NXCOl9EgXY+GHydtR4oXO25ygmTK6wS7SxDInPcp26ApSPWeknoJ?=
 =?us-ascii?Q?/o0ey/iyWYrc287rlGGDuNx/32Fmx/kT+nWp9rz+0gKpG7so2f7Vk2Q/AXoU?=
 =?us-ascii?Q?ZzQizYvdoYrEieXTD/VnFwsVCfv73QuG?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR18MB4714.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?054jyuyYsZIsETasKrmOovsnqCCdv72k6/uMSDhsKQlJ+GO1i9/qreiGIcae?=
 =?us-ascii?Q?aTHTXOunyB7aJkahndJCQLOvq28k+gf0DboUaceoBrv7aOvlB93Vox5i1VCe?=
 =?us-ascii?Q?0OJzt5CtTFiJmmh2MaOfaO+q5ckpFjUyiFA4ALTmTUbBmVptkLsc3fOZA8G2?=
 =?us-ascii?Q?/Fflu4Lzq5nRAJ2bA49ToqEfu/Kdu9+4/Ha98M6wr24HabgOTL2Cjxp2kL7c?=
 =?us-ascii?Q?aKCUry8/GprZwMFa3I9VTRLAj+w7RoV6DOHpz5+iKeMm7PKqGmCawKUD8Y+B?=
 =?us-ascii?Q?xKOaNWx1MXY3RN8eAULSnHlhwdByPZN75ZcHLuEQPUwQ5X2zt1ICd8dMXQnW?=
 =?us-ascii?Q?AiqFUSVXTXNNpRMyoPTfqFm02WCALolgKWYd+rsjw474n2UfOLHkN6erLNpS?=
 =?us-ascii?Q?TzYA05d+ELhqRERAF0v73WWBn4e3JRsN9roB8noh1bSwowlX6uzTjz5G12EJ?=
 =?us-ascii?Q?6gulq1hdVzVi260IQQWQYC/urTRFTbdTymZEnv3f1+DhIJjkkcPbe+9cWUj/?=
 =?us-ascii?Q?t1JnzCnFUpaX3JrhC37W4+k/4ImOJh9/Rtyq0STQBknggLo2rwC/6J/yZrkC?=
 =?us-ascii?Q?L+Q3ILUa2t3sKYFF+17ab+ZqaDAy+zlGw0YGWyLMyjVW9rlrwyCjDInJ4QTc?=
 =?us-ascii?Q?HLPMNZ+T9haVBDFIKsv6mCoVaFdaF7gb15A6pHFBkamilwkH4AtJJ7abJvI4?=
 =?us-ascii?Q?/LThZYSBYHswVVxBYocvBA/rsOK5HnRaURgIEQsDajGDMgpGrSauZvSYPjvN?=
 =?us-ascii?Q?HUMzgOG28iU66z2xAqaqBrcwPq2zxgpi0G/L3r+o4SP9SkhCH9v3eFJj83Xo?=
 =?us-ascii?Q?MHgGohA5AVC76LYRMlMUqaec1xDQXbYKqMuGYDOFOwOftMt8FuJvFBFWWzYU?=
 =?us-ascii?Q?s6el9A/hYkz9kZLSZ3QfU+7uZZi8fCxZY7KaKpClHpLVopt7WFPN/G9n6nLH?=
 =?us-ascii?Q?DZ5zPz6tvMqU4BlBzLSbgtQ9LIIGG/LO6PPFoDjwUK2vhqBBLjwtodzbKv8P?=
 =?us-ascii?Q?olL2/ZRFue8f6+ieLAY/XyjNEDUrfvb1L1VJ1AFm6rdPWmcGFK2o755CuyOz?=
 =?us-ascii?Q?cjA+cMvz32W1G1ADQwpvc7u7lhV10i5ABj7jnZLzFRPQ7uj6AU3X8C4toofC?=
 =?us-ascii?Q?q8d9Zn9aOz21iqd3+FW7KlhKgE8htF2ljLNTegAKfgN5nPPJOgx3IkrWD9fD?=
 =?us-ascii?Q?Z8qmY2rvThI8/OUqNlmqkSX1IrVStx23zyDrFJMPe7JeetMkImabmGKAOr7k?=
 =?us-ascii?Q?jkneMYTRjOcgh0pVDa6dhrCWVL2xrGT2/34UnjqPOhaGV2nwG9MCWNfpTqi5?=
 =?us-ascii?Q?m2iAEych5lN9zhQRWwdWevfIP3HsTXLJWy8yRqfI/QhEYrYCSX6vT6Tlffri?=
 =?us-ascii?Q?eTDMdCoMWw7ZGgs2K0DugUjCSmgid9W0j+/I7zFRjCJwxBNpclVlHig4KA6g?=
 =?us-ascii?Q?eU0f7IToe2hVqXyHoYGqFUBUkZJErkmAFTD9aOSyGOHLGk8C5YAD6+aXCI5B?=
 =?us-ascii?Q?rnShPrKvBFFaNhf8dgohvIrcvIQHz9PI74G7MzdsxZUu9ybMH+B119fOGXny?=
 =?us-ascii?Q?TN0rBiRbAqGB/9Z++aG8lH0InQtoU1QwJv5oJwKy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4714.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 324df738-607e-4bb7-2a6b-08dd5bcc11a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 09:56:58.3404 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9KmZtZoyJfSSKjClahmmu3OnIZVgMG8XdCsBqTLdBLBi+bnWYsWnuv956nNIRxubzSrVTLFtG5WmFs3KIEZmhA2RiHN9vhJHjlA3yCphedQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR18MB4374
X-Proofpoint-ORIG-GUID: eTeUhZXVkPTM-47scxTUlCL-QTjBypqy
X-Authority-Analysis: v=2.4 cv=EYoyQOmC c=1 sm=1 tr=0 ts=67c81fec cx=c_pps
 a=AuG0SFjpmAmqNFFXyzUckA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Vs1iUdzkB0EA:10 a=-AAbraWEqlQA:10 a=20KFwNOVAAAA:8 a=M5GUcnROAAAA:8
 a=w2PsCp3K5J2208-6l50A:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: eTeUhZXVkPTM-47scxTUlCL-QTjBypqy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_03,2025-03-05_01,2024-11-22_01
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
> clang probably does not detect that the same object is already locked as =
it does
> not track object referencies.
>=20
> Finish the incomplete and incorrect cleanup and only refer to the &vq->io=
tlb_lock
> capability (required by vhost_iova_to_vva).
>=20
> Fixes: 88c73b5434e6 ("vhost/crypto: fix thread safety check")
>=20
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Tested-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>

Thanks,
Gowrishankar
