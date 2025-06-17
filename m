Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18586C71136
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 21:16:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2BDBB42708;
	Tue, 17 Jun 2025 23:16:39 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 09F8D400D6
 for <dev@dpdk.org>; Tue, 17 Jun 2025 23:16:37 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HIprHW010167;
 Tue, 17 Jun 2025 14:16:37 -0700
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2092.outbound.protection.outlook.com [40.107.95.92])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47aw1ktgr0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Jun 2025 14:16:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HAyee/bN87WhbCefrqLth27iD1ZSTqn1NU9JzNTtvjjZKvMSwgRP78eCLZYspR9ibOkRcp+oS0TwEdBXAZmKq3oYLJxUAGlnwqRVBG06/PgV4xYvVE0mW3GNhNIxe9rGnsw/0dHU9MYO23KZyou2UrYSChGT8Bmik4R2Vd7asHjuF/CSGc7igoC7/hc2fSvzUKV7nJ9NEObf07eIF+x8R83xMtPOn5JcVELIckegYfbyDVP0khXoyzagyZsgz3Tl+qUfkQ/WcqO18mjlbov0KrGq6oiBcn+TMDO0uunGWUweI1t4u4Z84oQfyq2gyIhnAt5Q6OHVFX6C2fFJVRzR1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=890qggnO+W3OEACGOjnIVXi5NF4GrCvtyZepoo6+wfQ=;
 b=WZdshZ67BBu5/XXirYx00JqvC6hUIIQcDaPDWoc788y5LZ7sNKXoGaQ6Jj1wWiMMl0Q2Mzjce/G7Ipm2ypzrliYDw++2SOkq0O5zfEvDkTt0Gzxt7PWY1JyABaMxhOtzEyGZVHmB63a9sZdqwlAesvYb5Zj7q+jfBVEBuisfcwgFuVurFjidGCFVR4l2wfaIPq3gXNumAo7+/lhtpO5cdz+1TOWcxl1wFGRY4o2leead2O7ZeGU+0HiZp5TVnjve0m1AQ+4uPupH552rHnar7dAnCNEFgKDE797zWU96PhdkC2751Rhmddnn3J4PSA+lbseq8v+2bRam69+sE6H89Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=890qggnO+W3OEACGOjnIVXi5NF4GrCvtyZepoo6+wfQ=;
 b=VdVXggPDiMeR5G8bvGhRoRotsF/RcxEivaspMcEvyFdQ76rxluVUkJvLtWx0P18xoDekPHqANIEPWn8/wYDvERxEqMvqSxsMWMjs+ZIMQvDbD5OpebJvQTIaiWs5FPwxsz+GSCGhVaHu/FBW5HUhedMHeuXgxji5Xtd0pjcPNG8=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 LV3PR18MB5755.namprd18.prod.outlook.com (2603:10b6:408:1ad::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.29; Tue, 17 Jun 2025 21:16:34 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%4]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 21:16:34 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>, Fan Zhang <fanzhang.oss@gmail.com>
CC: Anoob Joseph <anoobj@marvell.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>
Subject: RE: [PATCH] test/crypto: test vectors for additional ECDH groups
Thread-Topic: [PATCH] test/crypto: test vectors for additional ECDH groups
Thread-Index: AQHbz+E7l1KjipO0RkOvXr4m6fYb9LQH+lMQ
Date: Tue, 17 Jun 2025 21:16:34 +0000
Message-ID: <CO6PR18MB44846B117A105AA90CFCDC10D873A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250528145958.1897-1-gmuthukrishn@marvell.com>
In-Reply-To: <20250528145958.1897-1-gmuthukrishn@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|LV3PR18MB5755:EE_
x-ms-office365-filtering-correlation-id: 566590b8-31f7-477b-919d-08ddade43d33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?2BCXSHPFVPXbjhppg6KwPU9ezGczvPNWgTVaCSeZu5Uqs0rHDzWv8WjE5IUu?=
 =?us-ascii?Q?NO4NW12Xy8qfEnyT/VgKUBWxa9ePRdeJOqVIe2qiv0cmDyMf70xnCBvc25PQ?=
 =?us-ascii?Q?s8xWvsAfBZOWhqtOxVv8lDQqjMuOSm9aStOvaUXxTQoEDyg3AF+Ql92hHJcv?=
 =?us-ascii?Q?zAo0bnC/K++s4cvAPNrJdQa2kovTqQCjPwl/1h4du0dGntprpgfnjKGhAgF1?=
 =?us-ascii?Q?qx3G//PgDceOi0kQ1IduqMphZF8Q75oFIBMirrolUhHKYXO0J12Qd0guwXbs?=
 =?us-ascii?Q?zCGATb1ZooPdbak2o7SdyYzvGY7Tjvm7eioGg5rzBF5Bc/vDVSodfVeqFrBe?=
 =?us-ascii?Q?4XTibt+Rn5OWJfLOCH/GWC1EXKmExuSIIok0eebjL1Ij8+Y3be+Omt6kTXDE?=
 =?us-ascii?Q?wMiYpUWSIlTkmvsei/8V/GX0ym9UdI6mFLDtb5yZUqcQgexR4OM8BDgQTBBN?=
 =?us-ascii?Q?0tQ3WAdH87KEFsuQeyFgkDE201PFiSSJZqEmaXc9TSAnutN1R1cnet3pLwYc?=
 =?us-ascii?Q?TH4XHPyZTx+tlxMYCj5UwetnYhHg25S3/lRqYEpSrLA6rZu55LeAGQH0fTso?=
 =?us-ascii?Q?JkDzHcbn6GCLNsr+INIH/8l6t+ZikqY+CzDGsdxZkwfsdCMsaTTanRC6BpeX?=
 =?us-ascii?Q?H0jWzXW82OKey1+Y0kEUIo6aQ8pNRbDkgK6lX02J8XVJAAOI6u/5d7/XLtvm?=
 =?us-ascii?Q?mWf+VF4GdXR2u/x9XfUsSqMcOQNM1la2fBorPDN57sZgRAyZYKB5teKKBpPW?=
 =?us-ascii?Q?2b032oeGbdE4PZh6W8bolJPnvgiv34U4YUzNtx2rrpulvljXFT74aQVJTdAh?=
 =?us-ascii?Q?tzdn7nqxj4KM5ufgH9QKQNHWE9GrHqZbyPN6JO2OqhTCQCuqO6OQoVt3E5ck?=
 =?us-ascii?Q?UjlwuVfgpSJtgQ7vd34fYDQdWtOFuijOsqnGuN58SP7bTkZyZ03pmlsVbOF8?=
 =?us-ascii?Q?Vv1e+ZBDiQao5KXqyMVNkub6NXFPQsAcH0IoKBifNrIwpAafOakZf4EoSLNc?=
 =?us-ascii?Q?Te0hHAIHxHcDOv2ErJWsTOnCgOvttcG9n+3aDLkOH3cR8Rj8YvzEcLf2pzD9?=
 =?us-ascii?Q?o6CEqgBdMxo5Blowd9fcpTEYawiK6YdSTSLtL2cW1+3H9ovHbs+bPDXNer/N?=
 =?us-ascii?Q?Sl4+DDbg4PSceq75+kYZZt+cGvNDcI+G2p7AMPFrUfBsMGG/7JCIFPmxmJPZ?=
 =?us-ascii?Q?VO67+MNLYy5N0HP8MgydxEBc9LevtvT8xHxdaWGpD5Wzu+61P1ZUsxxXTSon?=
 =?us-ascii?Q?z6l7GptHCMQNn0nBlhbNjzypOurdiT73tfVehuYPwz3AcK4qpbGe/k6Zb/K7?=
 =?us-ascii?Q?ibmI3mZIHNKkqwkKSkYPrxD8zA2/E/vIbcC6QUiwHVmJ8VH1kVMOgXeOA0Fk?=
 =?us-ascii?Q?W3hs86cuIz0Cks0rN85f37CEcxuTBrKTs5yM0ZczkTymq5NlGmK2R/OqCfAO?=
 =?us-ascii?Q?L7z7+HQ8Xgu8rEwgfGgK5Fa1Fx9BDgkngA4Ks9jzYNH7JE/j5HjVDUyvXs4M?=
 =?us-ascii?Q?DVOHsi0YCYQR2BY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HMKM+BNrlF3GROevV833D2avo1sC6ewn3NRZKan1Dz02SbYYYqsj9YrTGAm2?=
 =?us-ascii?Q?XKU/eOwTgZsdnyZ4dKZy4QlwqBVehS1EhgeiYaFeJnjNDxTTyVjQ7nVs1o+M?=
 =?us-ascii?Q?dqOGpj67xla23l0LkogqVSE06uFCfUg3I91v2SEqxOCM/DkU5oAQZhkCyVZ3?=
 =?us-ascii?Q?i1+3vzT3itI0ZhScq7b9Pc807GkrV9su+WlfUCUtR5t1Fa503KArRn4HvPJP?=
 =?us-ascii?Q?ZnU6EVQocQZMFw3B5WFJoYSmj5L5zLFPgSTJdi7HMemk0OmYZszeLCU7luPL?=
 =?us-ascii?Q?nbas2evzzuCbzhlzai9bicT1bQyd/2QwdzpddFL/+PZ4+OVVUFwsCVxiFRpP?=
 =?us-ascii?Q?9Ho74ycZY71xC8CLEjPFy/ysBhHa1WgBHPmPDUJk+ejddA/04WPm4haO0gP8?=
 =?us-ascii?Q?ZN8bi0LVhvUXInm5xr2/mq67zrzdA4TWWTyxzxjQE4UoNgKakdydiJCe9rDG?=
 =?us-ascii?Q?mcMgGGdyrrR7ugvSpuAUikRNtDUqzSj+L4VbT4DCHhciK3lpTFJ8+vghPq6S?=
 =?us-ascii?Q?PUToVBN9fbHODxBXo+t4UoKoNU0hyxEDU8CgqTx1Hm+UJ+8UkuL+Ph1ixc0P?=
 =?us-ascii?Q?qIjTGaaElhk7YGG22B0MY9Kx+2bjOIoS8a3mwaDQDp+NKztZe3qFlXJ34mYA?=
 =?us-ascii?Q?UbfVz8/nZY8Ogmf7k0FzJn7o7N9mpnJZSNtjXnt6zd/4E7eDO95DheXC2mDy?=
 =?us-ascii?Q?XQVzjCpXkuuO/pybZNe0aE5h/LSxl2Ngt+bNYzFP5cAudrsK0myGHhliRESm?=
 =?us-ascii?Q?mtoHccPVzbqr4gQttLm8D+J3WQSRu/ngqcnehwtSTTdOfVMkM0REOFzcMGJ8?=
 =?us-ascii?Q?X8ZJ8P+f2Nz0bkwV5lVdmgmQmsf0cd4v41R2PRkAItikUta7J8Tqaz1DZ7rm?=
 =?us-ascii?Q?b+Gr1dokz+bn1GOBWVl9iAwEXugtLkaJj4seSIsfoOt3QU6jh8472bmGiqpf?=
 =?us-ascii?Q?RdYBCS1ISSG04dnnPYdtpUVi4xV9nbLfmHJhaQczYNQJ6Sy731CPchpXMrK/?=
 =?us-ascii?Q?RL1fH9m3dXnrkw+alciT7PCPAiAJ/ZRSoW5iKuVIW5hwPD3Jp2WqeyK4Uadc?=
 =?us-ascii?Q?Y/VQ7CKYxiInSsQQEn/IkM42/8Joqkp5DAz9tXwnfEDuKk00pYPEZKd+4/h4?=
 =?us-ascii?Q?IptiLNeo4yvJUEuozknmlcD6AC/bH2hNK41ezVVIVOcIivGuOemiDAbzgyad?=
 =?us-ascii?Q?xrDEnrjYKsqR7MmXo0zJojwhYkROnGSFo8GSxplFpjCGer/a8ZLElaYOGOtA?=
 =?us-ascii?Q?P4P0ucdDMU6l2cZfppKIJINH4jbov1S/Zt7B8t4v2+3rYqEtaHPjdSGqzlxV?=
 =?us-ascii?Q?YH2Fdb53+ccE4LvaEFWmCJs0LQBfpWHoPg804SIw1KZYeSpRvFtigk5uODfe?=
 =?us-ascii?Q?UV1y3rVPtcxVflssUEPBkA5i/i2m2f0+9ecOGPVQuPmRw7lFtjj05zPbj7wy?=
 =?us-ascii?Q?7ZO/pxMHVGV5ebcAatbjmjVvRMvqm+cZ3dARxMhDqDCPMa9jcr/f9wGLfN3W?=
 =?us-ascii?Q?zJBayJh62K7+fh55NBB2FwglMbIT7yEZ6OLZA3idcSnmxgTgNA/fxHmZTjbH?=
 =?us-ascii?Q?PyJYkf3TyFPyOHZVAcU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 566590b8-31f7-477b-919d-08ddade43d33
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 21:16:34.7379 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bp0jJjPLXqmplasgX1kp3Wp27nJFIoMDfAqqyLwioL3E+mzmvv6zB/4aFIPGZ1zxCmwOg+9bwWrSZSHVBZwFAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB5755
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDE3MCBTYWx0ZWRfX0Z+4E/DMopkG
 5gOYjVBSz33PQTHCOq2n6g91dhfT6AN8Zp9IX0MELqBFbMntcCLF9+JxUwH0/htMs+98epZNJBE
 H2FPE84v/3+cKyKsd8/dNQMWWowxv/7BYd0Qr2TiMPILtPI/I63gPA238kdWO6FAzU8kagRMVfm
 Ut+QYzXfWhYwDmSFOC7d3a3/P1nyrXwOrDDcfraadq0Vz3V30fPaIZxR0WGr2Sf0uQyF9sRYLye
 lGuD+K41lJy7jxmYWEhnIbnx8qkvsUWtFE5FiFGvvApO6zBulw1yUCKgbblxG3Q7bc+uLN/13A+
 loKxxqZoT4smPbZur0L9Cf/racJblyhyQRjUemyw1vyaOcYRgrn2hALN1GWLJvKgSu8Tnsidfhg
 KurplO+VjEauuc9Tipile/kckcfVs7XRVYpUONW5Jyv53owScAUGECSSoP/epG/ZNSxfWplj
X-Proofpoint-GUID: Y32-J-wJJ9hfccvGlwx0w6S7dlXqrg5e
X-Proofpoint-ORIG-GUID: Y32-J-wJJ9hfccvGlwx0w6S7dlXqrg5e
X-Authority-Analysis: v=2.4 cv=VM7dn8PX c=1 sm=1 tr=0 ts=6851db35 cx=c_pps
 a=793Y01VNg1gv70ofVcud0w==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=pGLkceISAAAA:8 a=78wN8cesNRiZXGthmYoA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_09,2025-06-13_01,2025-03-28_01
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



> -----Original Message-----
> From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
> Sent: Wednesday, May 28, 2025 8:30 PM
> To: dev@dpdk.org; Akhil Goyal <gakhil@marvell.com>; Fan Zhang
> <fanzhang.oss@gmail.com>
> Cc: Anoob Joseph <anoobj@marvell.com>; Gowrishankar Muthukrishnan
> <gmuthukrishn@marvell.com>
> Subject: [PATCH] test/crypto: test vectors for additional ECDH groups
>=20
> Add test vectors for ECDH groups 19, 20 and 21.
>=20
> Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Applied to dpdk-next-crypto
Thanks.
