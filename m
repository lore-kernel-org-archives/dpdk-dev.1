Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525E8C3ABC9
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 May 2025 14:41:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2530340395;
	Fri, 16 May 2025 16:41:06 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id DBAFF402CD
 for <dev@dpdk.org>; Fri, 16 May 2025 16:41:04 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GCf6hU030033;
 Fri, 16 May 2025 07:41:04 -0700
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46p5jtr66v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 16 May 2025 07:41:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pAjBI+q6eDqAfEhlnbJbO/UO418TDYJVvm1usopheIWvvW6h9qeRO8uhrta7v5K1qJLzGUx10mwIwNgURhmYPI6iOTa4a9YD6Wl3QFYiMfy5sZhUKJjZM8WTRz13R+Cif+UMz4Tp3ZCUlF6Dt6InmmbAa96PQ4Huhp718aCuIm5sejLxrCypg/OHSpP8W9240yw99YlZXAqhTZyvZdFBM8zyeopeXfMl4uQO7bHQHvcPUdQ1xHkf/ctJzsgpmsDNCQRFLk3xm8czBSFJV7V2ydryhwH5JAxA9x9Tk5Ev8YQa8CXwHppiutHF1HoV2Jgc1dRkMBDwQXjqsDH+7tHALA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSe4JGjU1X9KQeXZZ1iU+eHgY9eLf2rhqM6T3AGqNww=;
 b=WwXNvnZ67FfyMMQtGAkMfgWJ/nJvyyst782nhvNa2o4ze/7H5BxQNq19aPM3fk/myCQYcKmGrv2WQSL6HuSM9e9Tz+GY9GM39tgdiyQEWzun1GMwypGLB7G1AoQrwc//DDXn6UTeNr32aFcYTqzApA2M/Nk/xhmbcQMCU28602eDXQ2XH0VnTUsjiDGj8nJeF4IWppMBR0WtVROKXBktsq37gwgNeRq0dG+wsCgY6fbryVYY3x3Vj3n8IMz4DB2mehVLdgBoNEuS4cyi9aKyg2QNUERXazZQHBU64vBe0MtrbF8/pE84clEaoMwRhQR+aFI5F4hrssdkPXXsbRkLOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSe4JGjU1X9KQeXZZ1iU+eHgY9eLf2rhqM6T3AGqNww=;
 b=iETucRCyUIfhZrl7GS0Ih7f4R8DzwPsN1Cx7L3X36cIBM0I1EByaBEYFqHDgnqpuzvPW3eWBGSLCksz21YJPhyLarDvmFihNJ/m/cAo6T1BopagSyGMlOAR0QX/WLhQOWEgoVmwH7btbw9q8a+xCbWmTR1qga5crxEU4TfrcW7w=
Received: from PH0PR18MB4672.namprd18.prod.outlook.com (2603:10b6:510:c9::16)
 by SA0PR18MB3632.namprd18.prod.outlook.com (2603:10b6:806:72::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 16 May
 2025 14:41:01 +0000
Received: from PH0PR18MB4672.namprd18.prod.outlook.com
 ([fe80::10cc:503b:935f:f61c]) by PH0PR18MB4672.namprd18.prod.outlook.com
 ([fe80::10cc:503b:935f:f61c%3]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 14:41:00 +0000
From: Anoob Joseph <anoobj@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "suanmingm@nvidia.com" <suanmingm@nvidia.com>, "kai.ji@intel.com"
 <kai.ji@intel.com>, "hemant.agrawal@nxp.com" <hemant.agrawal@nxp.com>,
 "brian.dooley@intel.com" <brian.dooley@intel.com>, Akhil Goyal
 <gakhil@marvell.com>
Subject: RE: [PATCH] doc: add limitation in using segment-sz in crypto-perf
Thread-Topic: [PATCH] doc: add limitation in using segment-sz in crypto-perf
Thread-Index: AQHbxluS4q8hcCMwnUWmgyUA86igsrPVVC6Q
Date: Fri, 16 May 2025 14:41:00 +0000
Message-ID: <PH0PR18MB46722C2377C833F92C728E30DF93A@PH0PR18MB4672.namprd18.prod.outlook.com>
References: <20250516121043.145572-1-gakhil@marvell.com>
In-Reply-To: <20250516121043.145572-1-gakhil@marvell.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4672:EE_|SA0PR18MB3632:EE_
x-ms-office365-filtering-correlation-id: b3df1065-a5b8-4d4c-ef41-08dd9487ad14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?A1z0o0yWVxOfwey5IR3FHlv/78mkrd6my0vpCzchYQ26DaBPlJrxCrx9Nj3n?=
 =?us-ascii?Q?eGMxPsZo3zS5shntsBZR98W205ocdcOhE0t2RWEtbAYaNi+MF0xuJPU4/feV?=
 =?us-ascii?Q?fYNFn66TouA7cYQ5QA8Dtatr7/cZSuh5R80x59vSR1ygDDcrH8ud2QVkyrd1?=
 =?us-ascii?Q?wMus08WwcaIdgb+pYYi5PW/VjmcDlk5x5YEc6Xuqoh77cjXEQTYfQuit/GJc?=
 =?us-ascii?Q?DK0W3MXqCSfNPNWNIHi7Idk/bcsdBtMKwknVvD2A/rLFpsas+cgvTA5Fo9pH?=
 =?us-ascii?Q?64ddrn52RotzJtNhu/SM0HOZUhvxnFSx8o+8VPk9F55Kjq0zgzS1oJ1ro12L?=
 =?us-ascii?Q?Cxvd3VWftsWGV8XqaAR1OVhwg9reWVB2C1a/UQDaajE/8srKyjEMflMh30yE?=
 =?us-ascii?Q?hQ6CElYbLPbuZrCQQwzjYxUaEN/gHrBuoKI3rDAvXZ29seQHMNTU/+EoPs/k?=
 =?us-ascii?Q?ZlXCjcyiGaP2hbixsn7fB2g1uOPWESxlvnIJVRTdBNmxrRz7NWWW53Nfl02o?=
 =?us-ascii?Q?fleXdSAYNHMb8okYeuIa9vX9cg9KoLucvtV7LTYNIN7pxKS4yoYyE3QRvBoi?=
 =?us-ascii?Q?wYMopwVvXFCd3+i1kYWcOE7EoOuhwwMdktTelIzK8Xs4+JCLcdVF3WTYTpR6?=
 =?us-ascii?Q?wY0merCWpQxaOa/NT1Ahyw8K5rMnI4OeyD6PuqS5ia/yL0obHpvFlp8DGSBz?=
 =?us-ascii?Q?DFaWV9H9bLPsW/nG60SeUru0SXzqruvWDGxQ3g0G8lcV7fqSTJWNUC1sSTux?=
 =?us-ascii?Q?kgbTNyBb/N6zRBpel9Xofpytr/wUVMX74FGAvWqi4r1E/fv1DOAvN++JG+iE?=
 =?us-ascii?Q?0DzlOnXEJiPggC6e/sNCNlsA9SKJJ1iMO2AsBcJODWnxGrp2qt8rQZs3R8Dc?=
 =?us-ascii?Q?YqO8N3BMMssq2Mwxnf5ySYQ5v4M2gycyEsG3jZYdYMnIc77Y/U5Ki1oCGREm?=
 =?us-ascii?Q?dRwPVT+Ne7qEKm/ZavOkEzZRQoXRxAE21aMtDva3nPdJsfYobGQMneJVdb4e?=
 =?us-ascii?Q?Q74FL16yrQLvSglUnGUv5uR2I6Rf2cBjcQkyoA/TPD7ukjN6C1T/hJTDVTwj?=
 =?us-ascii?Q?rBfYLv+AzOBpX6zyvQqOFUpF9fE0bLjbgf6yIiaBBj4nF8AuXFEn4WTW326+?=
 =?us-ascii?Q?8kQvpV7MmoU07B/srPlqQZfqjBqqiFtuGZBEdOrlNDJ2L9Tp7mgl10+nG/g3?=
 =?us-ascii?Q?UvTbvNmyRT+6kNQzu0ViewtBaDvpFjLDjSBQFhy6GJa/9GeJeKT/VXhL6GSh?=
 =?us-ascii?Q?SwUWlKwPoLcohVka7NJlreYLXRdkB9uJaPFr/zjKGcI6h4B3pOgs2+o9Nd7Z?=
 =?us-ascii?Q?LKyy3rMxqycw6kBAl9UMYP4i6Rn+mBDsS/bw0F+rl4SAYJw+/KE1fLoKze9H?=
 =?us-ascii?Q?rewaPZzFkFSHs2luzjKyVkZQYNQWdkvNhhDWeoahqycXFG3j477mEwL8RbO3?=
 =?us-ascii?Q?AuiHPH712dTi7HrzpxABqPFCFrz/2mCGX9ecNCU0ojhcd7VCFadzRal31/Wb?=
 =?us-ascii?Q?RUFUOfy930EUzlo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4672.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?teYZWAsOF5xLA/hSNKyiPWCUzWj3szFYqDAgV/DSUiXwby01PBw7Xlk4MLlj?=
 =?us-ascii?Q?3bJPQlNYAr++BXd13v3yITKN+0zio5KqZtrXToNMp0p6E9EzpM4LOlMdNt6C?=
 =?us-ascii?Q?Ke8RZQ1grzHMHUXa7X+IcxzDzY5TI29MkT/3mw2EfN/gArXPXD8Jm/ojzeWq?=
 =?us-ascii?Q?+6k5im/LEefzQbd24YTHsJOGpcrbUR+BxC5NxAKEcf/x1VKA0Ics/bOa/LVk?=
 =?us-ascii?Q?C/RuGRO4wF1Qd9mh7yNyLFT592TMnVa7ir0xu/BjugEpATrLAnlXUPoRmjxV?=
 =?us-ascii?Q?k5Y31jhtug8ZcJdUC35r+SujqH5izsc2/FacyuSKs8dTTooi1IDeT3NGcD3K?=
 =?us-ascii?Q?eYbUB6IOElL+j/sHjd5sDXsOeUyIAeeWlLMn863dTNEKr1paO99vyXA5Lab4?=
 =?us-ascii?Q?OCQa5D9jz8R9z4Dw1uHz/GuGDTlRaxjzgXyUytJMRckeIZolMLPPt5NF43CE?=
 =?us-ascii?Q?K+FyUmkQVeP7c78EHccxKaZFsixpsDtfCUd6YlQsFQ7oAG6lUG3cAQ7fZHwr?=
 =?us-ascii?Q?BD+WuNLv7U750j335LbEK+R6obviyePrki5hY27FWZtCnmcIjDepKsHEA+/U?=
 =?us-ascii?Q?sGJKdejYFMzgwcAqV3yJsK8J4AF/p8A3CJQJYT+hMAMBNUxPTzfEbJd0mh6I?=
 =?us-ascii?Q?6V7d+G/6P43Chghb8bDwISkupKWMczP226WRJYxHWebii4OHEMRxjM+LM9f5?=
 =?us-ascii?Q?MswewwwkPWVww6Id3MHDiTMrHsP/33jZRo2QQK3YP7StFicHiDAdcxQUafpt?=
 =?us-ascii?Q?wujbrH2pZTYQhIBnHJ1mdwKJvG4NNvuPUc8+dyUlxd33BAe5Z72V1QUfFs9o?=
 =?us-ascii?Q?ZlN/QLER8JN4EAfS3NAdWcZQO4Rezewz+L3OVuWKe/TrzPfZkB99uRjMST1V?=
 =?us-ascii?Q?R704iI4/xAzXCWiZ9D0jjOUPbWYJ0FsY95jsLa8Uf8lsmZt1dEyH+IqYkU2J?=
 =?us-ascii?Q?FBvKSUPuDL2im4u4xQj1FaKqR63Md5KaFkjpecge/Pnr5qO7RNAaXmVmvxDF?=
 =?us-ascii?Q?/TVFkqa49m3GgjKlEhl/8QNrcUq4E9IJB4ILSBy9vvc+pIUMLJFRnH5GOUNH?=
 =?us-ascii?Q?dg0wwRQrEX062FW5RBsWo5vIBQ+9UJ6Qvb836cqqSDuWQhaHswZuZT23+jKg?=
 =?us-ascii?Q?TDQhbUQk7lZt9/RpPAXvBxbOOpUAFiiHFHURtng5ou3rPtXmU0B6oMBPe/TG?=
 =?us-ascii?Q?y7p4KP71G2gq8rIKVO2w1OwhdJ+lz+PhLI/+5UUu8b5J55FYQAbv2ShHcCXA?=
 =?us-ascii?Q?NZ9H8oZ5dd5wpkt1Dh2BgN2zQGX3kkEk3vJJjI5UhITrfSBgfKbDJyvi1OsM?=
 =?us-ascii?Q?6JKG+ql6BSatw5QAMMpocf9U3D6m1zZ+Hg46lxgOshadJe04XQTdt2S7p1ch?=
 =?us-ascii?Q?MAjml8zDHSymalSwy4BuI6NwjRdJ8WD1//fnlYuzkr2csroRea/xKk44gu9+?=
 =?us-ascii?Q?QSFvEEpl79ixTAmFBAHNZqWH0zHLCpFJ6vq5xO4UkVAasWjgTviJSs+5pCtH?=
 =?us-ascii?Q?HVQywb+WSsWTrtzlbsOZb5Vz/6U89Hax+pQxBogvLETtuL12nLY2i2Dp6gKM?=
 =?us-ascii?Q?bckUgvD6kPPpixelatA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4672.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3df1065-a5b8-4d4c-ef41-08dd9487ad14
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2025 14:41:00.1251 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dpPpFaeTPoH9i6JF/Yp8GMaVvHgXcUSz97cwRUejqYpBvcyj2O22QTQYgnuy2ZCSfJSidLb6BQ8A/4fnaKQvtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR18MB3632
X-Authority-Analysis: v=2.4 cv=GPgIEvNK c=1 sm=1 tr=0 ts=68274e7f cx=c_pps
 a=PZJ0/dUMjH0jBWORzn298Q==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=6Io2p0sKCphI8ivHYZwA:9
 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDE0MiBTYWx0ZWRfX2qI4EuYquXPa
 tdC7riIaDCOtmqVfBVMkGPuV65y0Y+85QPI7OWvSZs+0jWoIcmTm3bSgbotofHPHFf6nQkYIdw+
 dCKtRgQ7637G06+Emg7OeTAcCAj0E8Y47lMJ+23AuZWZRQhNT8Z4TaAf/m3460kWPnnxX4YyDx1
 1StqCrxaQ8h4GarDjjhdcCagsbsNr4yoeiGUD3Hpn0Rjd4MDx7tsLfAG8Fw1a2Z1YHKAcWQSURj
 PsZRs0kJWtWpJpVLjtgV2G3l2R5Yv8HdEP9S+ycsc5oExRyvJpGD6rBTxVEfPe8hGv+yzGi3alD
 Nvk0ZdZa/tEXblzkA4EHgsqJfKfEFKF0apvNNk3K4g+K5QZgCpv6cABffwVGBA51zaML++Jotwt
 iId8b8+4wAXSXAe1mPdR5DZz8FPNN3cp20JY0nEnTS1J8hFMfBMeC3oil2i6chCYwGNONyQy
X-Proofpoint-GUID: VB76uMIZl9CMIWP7on9GWIc6kovEHi50
X-Proofpoint-ORIG-GUID: VB76uMIZl9CMIWP7on9GWIc6kovEHi50
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_05,2025-05-16_03,2025-03-28_01
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

> Subject: [PATCH] doc: add limitation in using segment-sz in crypto-perf
>=20
> When segment-sz is given as parameter,
> use buffer-sz in descending order.
> The reason is, same scatter gather buffer list is being used for all pack=
et sizes
> which is initialized once in the beginning.
> Now if a small packet case is run first, mbuf SG list will be trimmed to =
a smaller
> number of SG and rest of the SGs are lost resulting in segfault.
> Buffers cannot be re-initialized as that will come in datapath and will b=
e costly.
> So to workaround this, if segment-sz is passed as argument, use values in
> buffer-sz in descending order.
>=20
> Signed-off-by: Akhil Goyal <gakhil@marvell.com>

Acked-by: Anoob Joseph <anoobj@marvell.com>
