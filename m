Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75FAC369C2
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Apr 2025 04:46:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CBD97402A9;
	Tue, 22 Apr 2025 06:46:07 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 7CA9B40299
 for <dev@dpdk.org>; Tue, 22 Apr 2025 06:46:05 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53M1Uxvb016379;
 Mon, 21 Apr 2025 21:46:04 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46496qcp4h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Apr 2025 21:46:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MezWZ+eDt1sJk7KXLTLCAXZgAmmoXAaVpiD8D0GL0YN+ZQm2jIGfmgY6P9dTDufleasQELy+HO4hZzL5js9UM4buW7mRVAaATZodXs2Aunmzietx05EkkSksc5mfzPgb0z0cTFS798E2XxisOsDyfVlwZzuSdnqHFVcL1G3BYuizhVz95KDhwiYpbFAX7e4vid9x+IVfFbyUpCIfg3o6W3KBAixmuN77kLelNf+Kxp2/9kiWTpESLsa+kB3GEfXRtZsLERR11ArJCExYCYD3OsWmUyuDYMLnRxESEeXR6NF7irK4M0iZOooH0UMiCkQ9NNV0IQ1f0R6z3Je2Uxqi2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zK6d+jCkMC4tz/+wq1D44lGe3X8bLttKCLrTVGdKjQ=;
 b=cDQMFqSkxRH/yMRwASxcHfUqUB/7a1LhtIKnwaG68rDXvPVFpLsCd40RU0Z9PWKY9ab89reaB2xN7QbE2GSZgHYVXJshmeodM0A4wospsOCgYFDkjhiK9+LGzkTCWmr98wLe6wfCPeT5fJO91S1i/6685zpmTbvhQIijyteEVB5LX08TWE9gEpPs82Rcckt9LaGZxAlJsTOlSFEHGJtuXEN5qNIBKDc3hB2wCveFCwWf//btFEFmjQhwmctzV/xiohWkI3GlTbCc3fRU6P9THCkX27pDXgu73qydmqgcIeROd7ci3nKAAtMzk0bymW3E9/mOkhDyoLfrW/kxc35Vrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zK6d+jCkMC4tz/+wq1D44lGe3X8bLttKCLrTVGdKjQ=;
 b=ow4CuysiFSH4SRPRZRJUcsEmLx/H0EBE1xpjE6SHP3utOK5jwTvRDScrI0oCG6pWNI9FRzXSy+C0ZwSwHcLQ2IfQf+/F1oLBf4/ubKvpbuJcgzskU4gjwSs7CUaIV3xRb8cUthF68xWxhCs+xSbCqaW9C/AbTj975X97P9R09p0=
Received: from PH0PR18MB4672.namprd18.prod.outlook.com (2603:10b6:510:c9::16)
 by DM8PR18MB4486.namprd18.prod.outlook.com (2603:10b6:8:26::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Tue, 22 Apr
 2025 04:46:01 +0000
Received: from PH0PR18MB4672.namprd18.prod.outlook.com
 ([fe80::10cc:503b:935f:f61c]) by PH0PR18MB4672.namprd18.prod.outlook.com
 ([fe80::10cc:503b:935f:f61c%6]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 04:46:00 +0000
From: Anoob Joseph <anoobj@marvell.com>
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>, Akhil Goyal <gakhil@marvell.com>, Fan Zhang
 <fanzhang.oss@gmail.com>
CC: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Subject: RE: [PATCH] test/crypto: increment dequeue timeout
Thread-Topic: [PATCH] test/crypto: increment dequeue timeout
Thread-Index: AQHbsok6cjSG95CaH06CdDpZqAjN2LOvHRrA
Date: Tue, 22 Apr 2025 04:46:00 +0000
Message-ID: <PH0PR18MB4672233A5B32A27C574B2219DFBB2@PH0PR18MB4672.namprd18.prod.outlook.com>
References: <20250421064708.1777-1-gmuthukrishn@marvell.com>
In-Reply-To: <20250421064708.1777-1-gmuthukrishn@marvell.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4672:EE_|DM8PR18MB4486:EE_
x-ms-office365-filtering-correlation-id: c3b54a10-b853-4450-1807-08dd81589493
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?NzT0dZF+zS4ORKmGUg1b87lxe62PITtGE6AnWBQvsPrLPWmACZmr+/dIKRDC?=
 =?us-ascii?Q?IYO+IHhVCYoRZdyMcBl67TxxNx/bJgV7+Kt37UqimCNyo4p98WbykXeFJwGH?=
 =?us-ascii?Q?G1IJ5BhBkQ+FXHglvfP+00v5OXDljCWZQ0ceW+4pac6dtgWh7kOf64vu/PlN?=
 =?us-ascii?Q?qxNFY74dm5o6CEhNFBFhwqB6igkcOd7bZvwEg6FSjVsbTdJdw0ufQQRRC4EP?=
 =?us-ascii?Q?QROlfugZKiHC1XpnLW5oFRQVxYwum6XN6gXjcSITYfMTCikXNIqItwg7s6Bm?=
 =?us-ascii?Q?f7+GwAwInvRyx2W9slIKQ+0QQUDNqM7D4LDe0eCEalEf97xrYhcfO6lmRB78?=
 =?us-ascii?Q?Kx99ox8PFh9OzJRGBD2g7pxUTK377Xjb04XxP/+WngZOzHZsj17V9p3GdlX2?=
 =?us-ascii?Q?NtAEE+FIfX5A7M0kEBXDfZAS5RdEbTvV8xxBSezW7gUthlsDvCueU7YVY6a+?=
 =?us-ascii?Q?WYb8e38s/7Vr1sKlLey+8TlCc2+9clYh16Q561t1a6aNWPL1hqALLyBs0MNf?=
 =?us-ascii?Q?9tdO5O2C7ShKlBG3wE7NMbG7NTkWmwtRCZqt1v1glxIeIVCABV4/75NQxtpP?=
 =?us-ascii?Q?AQlLr0CgWvaUM+ZIrmPOxZBt9ZnA2n37ihBSxb+fO4+brA6qN/n3dTPtnWyM?=
 =?us-ascii?Q?BlxwCugjksVUidC3fq+SJOX+a/SqOyU2oiHf04GeHT7EKKVcUgvWPcU++f6f?=
 =?us-ascii?Q?Xr+HvFqcgcynCxI5HHLCSQsIp4tjitpEDu5CMuswZ6+SYrTuM8i4WI6dhJaB?=
 =?us-ascii?Q?1DwfojlcDig8zzkpJp/aaczwdeRYdX1R2Vbgp3y4vfEhm8dSP+F2UrcB87ip?=
 =?us-ascii?Q?cWOF6GQTfFGzI21o3gzBfeMH3Gb7U1dewRxcim5AvTrTqMnkY9KBahzVq2P1?=
 =?us-ascii?Q?6HcKCKG+3hx9mmC1JVigKx9RdniZD8XMr0++8RAvLxfoqKbuRnNOwbsjOL6k?=
 =?us-ascii?Q?S1ircFO18odfy8/+pZiWUdBtikAbxnJDzdTlE85pTsF2ny7aG2FIJV5aM8yy?=
 =?us-ascii?Q?EGEYrtcTTpVZobYidZ0MrGlIDy78XlIJiFRWQBExTIRc2qQyGnB0bwRNrZSF?=
 =?us-ascii?Q?z8gEQZdi3TFbJtxjzjttc2vjTz+Kv74ahEVGCXOgDP7gBfnqY1sQJKCrsDq4?=
 =?us-ascii?Q?GeVtBwYJhCwP42tqb+WmrquiJIJ638SZ/VGByajAyIvWxnUvB3Vps4l/ID+s?=
 =?us-ascii?Q?eqfakNwganrP5tHFg/BcDliE8x9+ukXOrx9Ax9+g9/4O8MhLCIoF5ZYUAIMi?=
 =?us-ascii?Q?3eSDC1BDWaH/ymw4oYUT4I+ZAheMysUQKLIV3EweyKHuY92PhP3WaOUs7vPF?=
 =?us-ascii?Q?OCtmRUa7M6bS8sDRUWVM/L5j/nn0yvIABhbVNVQDfW1gZoEQa4bo1AsTpsya?=
 =?us-ascii?Q?ZPN3FdAr57pxBPxZDtaYK0jtm34wMvOBODtl9V/8DNFYCKNiBMyy4ZNbbUAo?=
 =?us-ascii?Q?t6LcnT6SpRd7I1YXU3zednwQ0PFiAS1we1bh82QR7RaOpLXLVfdZWw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4672.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iWsH013jyP6tr8tjH/3dnE2jAQjegtNkQRtDpHBEJznjzDs+itqjAHeErL1B?=
 =?us-ascii?Q?WtcruvzNaxN2MrIYzs1YqraNabAqB7h7vPx10mMp4bsTvAR25/JIfVtwqS33?=
 =?us-ascii?Q?JDTICI+kabEdf+RmByYhATGXUs+oLNB6haZPGgUBVBzeDRaKfrfxCR8bbbB3?=
 =?us-ascii?Q?Rby/Lw1s702D8GPUPC9i3eo7PtvnoENJHBBTQ0RGMwsysLJhL5YAJ5DWBVEN?=
 =?us-ascii?Q?Rw69D+oNIPnthBNwEdY4PIiZ3PKvSvJba/cdEm2PutTe/DDuhyqfHCSEOtzl?=
 =?us-ascii?Q?t5D4f+HKoVJXhAe5B81wL6iYXecVY9kgRqkpWpYAzMMf9l6E1eT3IRq6MiBX?=
 =?us-ascii?Q?gvSlPqFqRsJtZPXxZbpsrRavdmJ37srd04h1/F/hVLrtv/0vxOjUUskVEFJW?=
 =?us-ascii?Q?+5n1PfrUEJxVuQZo2n+W+r+1lyWvy0F4ueWXOSFjRoa7xGdlu6H0qZ7voBcr?=
 =?us-ascii?Q?ANd0U6mahfo3g3769wogN6PZuvmPrhkfvPzhRndigIQeF2AeS9JG5/t1jx0g?=
 =?us-ascii?Q?E2FNOpr/Dygz5b+cc0dvop2HQe40OJFleaIazWW8iIQngWXc3tlMcQQ2BU/n?=
 =?us-ascii?Q?sGz5L0oo5l/eGeXwHiyyEn4nZPPIIRyu9o/XGpW94SgHJ9l1PNPj0AurzY+J?=
 =?us-ascii?Q?v6jwGFSS/mPHExyyNC7Hbe78PH9VS2fX/fc2pBsuXZCDxd9PgFpZAV/b1jqM?=
 =?us-ascii?Q?HMg/UwVA00nvNLQwAUq5/qdxWvLnEMkwoDIvAQCPldii5LBJ2QiYQlU/LRdT?=
 =?us-ascii?Q?qKYMPzFZRDeltNq8GXB2KK76p/SqsYp4x/bjwAWTsdq966KN5cDWYLU+YI9I?=
 =?us-ascii?Q?SeGn5qRIF1b7lIn5keSim4422wDSoq0OISAzjrHmMCmCuvDnjyzoEemtIz0j?=
 =?us-ascii?Q?KWSOAZ10xkvsNGfRIazrSidHI8pnMfmUoSIf8SRMNGZSGDzODCCLO5XJWuK2?=
 =?us-ascii?Q?qPCj1uQqv2/TVCWYMf4wwY/YzNUDo6Z+erUfa4OmIuHc2HIXmyzBEXx4DCrm?=
 =?us-ascii?Q?hb2BUrcWi0FnP+CSSJqkS2ydHWPe8GqZz4Jr3a0Zb2fxjCkOV9NXfCnz7YBL?=
 =?us-ascii?Q?XZAVurI2SNaqNynj6lVIDqSRoT5FgXLHIlUXkv4Rx1WlyueerBjegoHRFrmm?=
 =?us-ascii?Q?skdTnAQyei5HvfyDEGpGfEIXPNR+5L7ewx27LTwtSN7EI/Gl0SmUFeZGe5iF?=
 =?us-ascii?Q?k3IaAmZaWj6FBnyZuWz7P9UHvn3Ss14FsYaReN3ohKQir9FWJPMFYzqCterG?=
 =?us-ascii?Q?L1+0GYVoOziv5GPuE2JABvCZRCoZ1I7x4K4faHEWTp5c1rbzZWNYPYRWf8Ut?=
 =?us-ascii?Q?Q/8VBKjMNSTz7HhIdF+7MPATSFbCtYkgQ5JLEy1Wg7Lwola7mjDFPAmIFDDb?=
 =?us-ascii?Q?2+beGbuD1nRLOlxLpP4JeyFPhZNC2sjVg77XIRytIqMQBMjI2ztGvyjMMlfn?=
 =?us-ascii?Q?ALbrw/J3o6FkDS5usTRsqe1AlQc1Yq3hGmppPZOV2od+AcC+tZjjGqdNw8C0?=
 =?us-ascii?Q?AcnzqBNjgEWyVx1UU7TnWnwINo7+oQCg42rfLC2OjTtT9lg2Y2WPcwnikmc5?=
 =?us-ascii?Q?TRZCUPwOk3MLzZb84kM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4672.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b54a10-b853-4450-1807-08dd81589493
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 04:46:00.5744 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q+8mZ0LxXKQ691YeZ5vFAu2miXv5DPFWFL37x8/cp2ihtmD4mrxrYpcST4qJUj8CZvldZqRzr6GMr1Jl0rftwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR18MB4486
X-Proofpoint-ORIG-GUID: G8bXO39rmFWuuOmiuU_X1-qRaBoaiJFB
X-Authority-Analysis: v=2.4 cv=LoiSymdc c=1 sm=1 tr=0 ts=68071f0c cx=c_pps
 a=Bc47kgIQ+uE7vzpOcRUeGA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=XR8D0OoHHMoA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=wvOYxwte3nP4xlPvJUsA:9
 a=CjuIK1q_8ugA:10 a=OXoeHldmKWcA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: G8bXO39rmFWuuOmiuU_X1-qRaBoaiJFB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_02,2025-04-21_02,2024-11-22_01
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

> Subject: [PATCH] test/crypto: increment dequeue timeout
>=20
> Increment dequeue timeout to allow implementations taking longer cycles.
>=20
> Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>

Acked-by: Anoob Joseph <anoobj@marvell.com>
