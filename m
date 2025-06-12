Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FB8C61CE8
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 10:34:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B1DD4021F;
	Thu, 12 Jun 2025 12:34:00 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id DD56C4003C
 for <dev@dpdk.org>; Thu, 12 Jun 2025 12:33:58 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BNVSsM010002;
 Thu, 12 Jun 2025 03:33:58 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2103.outbound.protection.outlook.com [40.107.220.103])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 477kj2s7gn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Jun 2025 03:33:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hEI08o44l5f4nsEwNQY9UFyBUK50JqvE79hByOATCeNqRYWvE/VXxi/azArXu+fMYiRZnkQLDkVi9P2iJkkyeLAj2M4JErRfyslXbHR9ecSuikIvBRdlPVZtugQ7WUTMbWfsaYEVXlf7oCmX4mAWIyucZTbTM9yjVUcpVetSjfFVllmNVrc/A4oxGMpNNvjaddQdi46S83iZwLVfFJXtGkWthISsntu5zH8dx9M+Y2zOqcRMGdvTe/HM7Mq0Ri1W2fs1xwW/YJSJD7V37w2KvzEeSLgtOX49zgDyAFR8iOYmgkeSuBVY5rKLSq0AHPVhohDt4jzrG+N1GAdnacM77Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1G3eVX5TzYloFNzttb1ZXpYowc1Kph77f7pvhpcuIyQ=;
 b=opEuR6tb24dQzdVjKLUyATZMQHy4qvHg3hqXWnnYPDgc4Z79XmGkAEETtnBmwvc9pwTJMMkSwUpQwMXYnZ0kUfXU/fqZsm+hjXCMZSSUahTycNQT9pDjVzLGglLlz67d54zCle2WHnKD9K7hkyzhArzoEt2ARBQnRw0QFadb1t9UuP4Xiq37chy1eCerQ5eb5kL78p9wJzFYGE366xtQmWwc1Ua7FVCSIWw9gF5snUx7+AjvLezpegm5MO+Lir5cdJgUrFNIahSPrOauOfx6B7G5/dkYpRGdUkYmknFz4fga5l2f8n2pJnTsYrMWaZilYnbGDL+DjoUK6/uY7YoxBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1G3eVX5TzYloFNzttb1ZXpYowc1Kph77f7pvhpcuIyQ=;
 b=dO93CfQ+wrbpMferESppMUoGL0Fd3IsUiQmW/ECPV2dXSob21qBJ8kOdR4s6vkr4MwQljSKdMeMJnNK9Skhdgpvv7JNlRH4l/8KqAmbS1bIZCdnV27gGLJpVOpU+q0xRKxH+03jaGSY1PsFnAJ5siJH37JuLGmfF1KbEnlJH7K4=
Received: from CO1PR18MB4714.namprd18.prod.outlook.com (2603:10b6:303:e9::18)
 by DM4PR18MB4176.namprd18.prod.outlook.com (2603:10b6:5:393::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Thu, 12 Jun
 2025 10:33:55 +0000
Received: from CO1PR18MB4714.namprd18.prod.outlook.com
 ([fe80::26fb:729e:a947:3e06]) by CO1PR18MB4714.namprd18.prod.outlook.com
 ([fe80::26fb:729e:a947:3e06%4]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 10:33:55 +0000
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: Kai Ji <kai.ji@intel.com>
CC: Anoob Joseph <anoobj@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>, Akhil
 Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Shally Verma <shallyv@marvell.com>,
 Kanaka Durga Kotamarthy <kkotamarthy@marvell.com>,
 Ayuj Verma <ayverma@marvell.com>, Arkadiusz Kusztal
 <arkadiuszx.kusztal@intel.com>
Subject: RE: [PATCH] test/crypto: fix RSA decrypt op validation
Thread-Topic: [PATCH] test/crypto: fix RSA decrypt op validation
Thread-Index: AQHbwZiacBxVlAhw+Ua/Z0S4WXpd/bP/gQsA
Date: Thu, 12 Jun 2025 10:33:55 +0000
Message-ID: <CO1PR18MB471468B21DE770926E149839CB74A@CO1PR18MB4714.namprd18.prod.outlook.com>
References: <20250510104452.2186-1-gmuthukrishn@marvell.com>
In-Reply-To: <20250510104452.2186-1-gmuthukrishn@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4714:EE_|DM4PR18MB4176:EE_
x-ms-office365-filtering-correlation-id: a1df8868-b101-4214-35fa-08dda99ca22c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?jLFG81TBztzJy0vjYZkGGgQvA0wIG/2wYk8K6Q6DemJbp1OFtv43CjKfhgXF?=
 =?us-ascii?Q?uyd53cLr1vZIJeJGhvRV/6aEa0kGyYS3N2opLaUdn50W03qsN6C+Fkw5GkqR?=
 =?us-ascii?Q?S8WvGG26FyzsFwyu3CIlr4OwALChP1fgKLGLXjRXxvkLSVN2DR64d5x6A+WD?=
 =?us-ascii?Q?CNIf4oBL4nH7Heb1HTzUW5U8atlyTrTf6oBj3Ww3FhReN/sN39WESHW1EfCZ?=
 =?us-ascii?Q?XP7XrOj8mh0f8ta0o3VCk6ly0M8BPtfhYuo7jZjZOkt05DyiCYnDtmk8omb2?=
 =?us-ascii?Q?Xzpk1DgcV5EEnvKWEuFWm3R783ALGpwG2i81q3WlRKUf2uLBnlqGD0YVNypv?=
 =?us-ascii?Q?Hd4nMU5CZLDHfxYXHi1pi5FgysLSeGxwWVWxLro4B5Bc7DXidf5u//to+ygl?=
 =?us-ascii?Q?62ghBPUnq2ZcdcMXu5b3HsfgH/eoCvHMYUTQ5rAr3NTKYnxYh7YZpGyeXHxl?=
 =?us-ascii?Q?SY7ieCjztNP4fAFbXz4HAoCvPgdpfwbGJa9pDtWbyHxC+2g9WAa8OWrz0cJa?=
 =?us-ascii?Q?p47bL+x6+tdex+CWTyg1RaqUT4JckzKjo4wfsP4ODR39VBDgcsUgu2G1C1zb?=
 =?us-ascii?Q?arHBXLSzinwezB8d+5bIAjfOrlqV8c2VktVqQiPb+BSq+xa5s7PLpOK9RWU2?=
 =?us-ascii?Q?MMVcuRaQ4RIiONfHKJgB+EWHJKFYbgt3E4XV9YBnG2H07yB37QCD67lNdmKM?=
 =?us-ascii?Q?klqNkLSxjrF+J1DwCHz8mxicaYeMhRcbzRdK345QmR08mrRxIX8T3JbDiI0n?=
 =?us-ascii?Q?tpwMEsCjOc8J4GYM647vZTLHQ7RrUFjMmNgGhGzK7YTSiKwZMZMPMEOTo3I2?=
 =?us-ascii?Q?VXZwl5Pl0pqGdhSSvQzo8J32GIwLY81VfGxA98znT4Cb8TskF1oMTafvKsYf?=
 =?us-ascii?Q?67VlybnoY52lQZTG41EmUxs5sAcaCop25WpMJXEf8dD4INyidxge5HD/erpH?=
 =?us-ascii?Q?tvErlvBlFvy4kHz9OauvOW5ajFEOmAFCSnnjPth8SYfPmkvrze8mbJEPinbY?=
 =?us-ascii?Q?U2+J+AvqhGVgbvUik61Zd4Rt4zDjqAbS98vobVPU2dE3/V4FoPYYqPcZ57+T?=
 =?us-ascii?Q?JvFgtLhyLcQ1fAVAO/xtDAVePJM5BVqj2wp/DfJNL4cXrvFyHJxXIc4b+aaJ?=
 =?us-ascii?Q?JLXtSw+66MxFSFNWQPsG/qa1UrLzYFsXsI9sx7LcssKqxzvNP1H16k0zoDrl?=
 =?us-ascii?Q?IkPggr2GTO9YeCuxuB0+a5tvrBingFtfedy90eT5o9oIB3oI2GnBOgXm6hlh?=
 =?us-ascii?Q?4UINoVeafUCYYtul+/RqHaRlYI3Ig2En90oiwKWaNxgG5Eb8jWwr8GQP44Cs?=
 =?us-ascii?Q?sYwy9mXAStX9hWnBREZ+AJBgXUFbJSbnSQFPU+LMFDZj9JZV2PM5FwqKZDvb?=
 =?us-ascii?Q?OcuLITwPWrFyx6mvddfEpbnk18ekZXmvCU/wFs8FfC5e2sGCqYnBTcMXGXsb?=
 =?us-ascii?Q?4GecbTaZ2nlJk62qoZGdJCEDXQZT7SSc8f2MD6WD+bXThCf2wGbQCw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR18MB4714.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MaeWqcBwGOW1F1o/wuo9iPa56btj/yX3JBs1s+7UKuhurlbFqkRdu/DFzMt/?=
 =?us-ascii?Q?MEPEeDXjVjrKo4zC3VOZQDpaQ1ucyIcNbKH1QtCS90R5bPTnmKd9hvnjX5mw?=
 =?us-ascii?Q?h70k3hQTcxakfhyaSjQAK81syCSeaS7VcVCRRk3oKRSztYaicjX/LEZf1IuL?=
 =?us-ascii?Q?baw3zt0KBz6kaDtZrVjbEsvQKCfqJmWuyoooMspmv3197qfHI317lN8QJf0P?=
 =?us-ascii?Q?TKUrGKrY1UuiWOFs565D4jy6zE4AfL/gQgybQDmMZKbpsi0FDoW2UrieG5wq?=
 =?us-ascii?Q?9I/aGcdITOjjuCfo9Aa4PaLtPW6yn/aWEiPodMEHd/QhziFtN2GA3QvXY50G?=
 =?us-ascii?Q?o11ooqy/mrWzvjtmAAJl6hz/X1fZGTWPb0JlcWngnrUpDRM3zEAsecWY9mma?=
 =?us-ascii?Q?diRYbnMlI26+slZK2UqsBsW/jSThnSU8IyTie/bbN6JlMbTE/X09jo0yIBxW?=
 =?us-ascii?Q?3PKBOE7waWgH1Pd38t2a4qsmi7qxIf62g5Uw/jvCBKXpQluMBEcTJJMpnnIZ?=
 =?us-ascii?Q?ks4oQhbOfspxSLdbZCpKELJBjFI7W19+muEbog6yVzVnzQz3ZkRl3UdUoO72?=
 =?us-ascii?Q?BaZBAkKdxmgAXIBDQNRtSc+c1hGqhPhcGM9xiL/SKfDZyz/MT0uNoEoMsKDP?=
 =?us-ascii?Q?fiB42v8yh3a5MwZNiORfZdSf5Wk07Wu4EA3cK1E+5dkFs/rMv9Ch0tjO7lCW?=
 =?us-ascii?Q?bmdRTr235MQn5f+FqdnfvanzHlV4jv4oHKfoJVd3rzn/0gm61fQ0TT1xFxHS?=
 =?us-ascii?Q?taThiI8csSCA8QksERMJeZIN/S7YE/TyN2OYwlxi28lnqRtPBEYcFsOMUqJu?=
 =?us-ascii?Q?r8hj7Tl1ZZYj63vQS7iJRTK+MXGF/4WQszp3FLHFXsmNp2rNFAt6eNzRTblw?=
 =?us-ascii?Q?9/CJZ3YtED6TkD1JCVaNOjalbSoKR6fNzQPpVxKnE0LpnSQ8vle8JVN6ldlD?=
 =?us-ascii?Q?Nk+speVjf0wpszoCFdazlAQP6rWMcNx8iwVsWznxeV7B/SDvUyt9TLtMIBpJ?=
 =?us-ascii?Q?s7rb9jij01sFqM+ITVNZEzw3vc67YdaWZAQ11FbqAaQliH+bp77mq88b5gLX?=
 =?us-ascii?Q?vyat/MYs7jfjs6lZ2WNAI4k5c6QYGheReWzqzMRK10ziiRpRvU7rbWIKYl+f?=
 =?us-ascii?Q?BVGX1N07+EaLnCyAApkQdCVAkNN09a9XJwzyJzpp7yj61mdK/GOxlQqUEuNK?=
 =?us-ascii?Q?6QGmgLUlBEKb7EIlActRLUZ0ltOnfo8jbh0+ScIJoMiSP0ddQmq030rNN8qW?=
 =?us-ascii?Q?Q/EAngqimLnyN2qq4guLa8unBxiK1zwBgRaHgx6tHPkyr3oGfHSwbs/2eC+O?=
 =?us-ascii?Q?2Y1r2v1AUo1jLUwAGZLir2Jl3MlyGWua4u5FFel1aveCeOZ2hXGljRcTKtTm?=
 =?us-ascii?Q?3E9U7JaDXokKMDOg35Y7aad5krNKLoqcWXLtxIZzzSpANHR3TCv70poJCfaJ?=
 =?us-ascii?Q?xMWxEjCk5RABn0MEY9kcdXVzeLYwZMlYyNiwGmfz8Rl9uUqBMyOisBy/xQjH?=
 =?us-ascii?Q?081wqr9MRoyqyFWXeO6iiaoZRBEHQzXsm7ZCsxrd8e6C07lggQH/CCx6k5MG?=
 =?us-ascii?Q?x5BRRWPPdRZ1GCBBohO4jyERAVUensAkn3yPCitf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4714.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1df8868-b101-4214-35fa-08dda99ca22c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2025 10:33:55.6877 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bNQQ7TenUY+v8WjAN2tGlGWds/FrsTPI226E8ZDgK6DLmFU3JVHWJXoukc3kcCWnrTXq/yhDIIYVdDtt0JY+OZ13zJfVgLl4T1msh7bMHbM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB4176
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDA4MCBTYWx0ZWRfX3MJqIsgfNti1
 Zx4t/VKQKG4QwSbIVcFZUUEXF1yn7safaUqr1KUTN9u2q0AEo1d9F8ldJRt56SC4hfPNgP8UK6i
 CDdZaScMK6ZXLCPZ9TZAKvhM5FjxjQONTBeo24bzr/5wIyA2YksPwjGZeymuTPjU4MbJnyxhF+v
 pJ0rLuWkYX9GtctnebBGwcQu7hGI65jcstLPwxZfRC4KnMY2zWVmC75XA3piLea3EuVewbvFUI6
 j2vgMZ2yOo9Q7xHw100rtsgF/eFk4+SwxKR/glq3THeNVqWj/xN5Rl6xRcmWFiPolnNGZoOd11M
 6Dvxd7cz9x3bi0Rj67TfOK0WCzuCasLDtU6jWDQwL1T2MeNVEHKpwUk1eonRojKhI9cA+wEPkgX
 QN31PBbTk2aCmNUM2y6/F+MiaDTta3xakEhp50ZXmNONK2lzWBkpmM+FnH78JtXqSXi7Lk/g
X-Authority-Analysis: v=2.4 cv=aueyCTZV c=1 sm=1 tr=0 ts=684aad15 cx=c_pps
 a=qkvVI0a6NpPKroYfssW1Yg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8
 a=cKE4gsFeA1e0N1Z4JJsA:9 a=CjuIK1q_8ugA:10 a=YjdVzJdQTyZRADMV7wFX:22
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: ST44rzGWjGbsfJv76e6rp9LVowOc-eGE
X-Proofpoint-ORIG-GUID: ST44rzGWjGbsfJv76e6rp9LVowOc-eGE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_07,2025-06-10_01,2025-03-28_01
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

Hi Kai Ji,
This patch adds a check on cop status after DECRYPT in existing RSA test.Th=
ere are
few CI failures for this patch and the failures are very specific to Openss=
l 1.1.1 variants
used in below platforms:
* Ubuntu 20.04 - Openssl 1.1.1f
* RHEL 8 - Openssl 1.1.1k

When I manually build these Openssl variants in the above platforms (using
Docker images) and execute tests using respective openssl shared libraries,
all tests PASS. If I use Openssl library that is shipped within the above=20
distributions, the test in patch FAIL.

I would like to get your opinion first to proceed on getting these patches =
CI acked.
In my debug, I don't see any issue with the patch and the patch adds better
Validation indeed. May be that, it has uncovered a potential failure in abo=
ve
Distros. Can you check on your end if these failures disappear in manual tr=
y.
What would you suggest to go forward, for openssl PMD ?

If required, I can start filing a Bugzilla as well.

Thanks,
Gowrishankar

>=20
> Following RSA encrypt op, same plaintext buffer is used as output buffer =
for
> decrypt op, hence comparing plaintext buffer against same buffer pointer =
in
> crypto op always succeed irrespective of whether decrypt op succeeds or n=
ot.
> This patch fixes this issue with a local buffer for crypto op.
>=20
> Fixes: 5ae36995f10 ("test/crypto: move RSA enqueue/dequeue into
> functions")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>

