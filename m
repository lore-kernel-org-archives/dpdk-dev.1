Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FECC3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 06:57:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C55A40275;
	Thu, 27 Mar 2025 07:57:48 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 1C41840261
 for <dev@dpdk.org>; Thu, 27 Mar 2025 07:57:45 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QJQAgY014002
 for <dev@dpdk.org>; Wed, 26 Mar 2025 23:57:45 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 45mqr3h6cy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 26 Mar 2025 23:57:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qf4t+VLJ29FU6wVLjLxrIQ8vjsmyI6ffqMthr/3i69vCoYy1ugdOvfLm8R4MBU8kPC/DqAiUptcLcYf1R/uGlBzJtUeL9G8oBmyk9GAy/Az7R5g3t+S9kjdW2U0jYkyugVzLkzDJkBYuyvuIyATCNwWG7zYnQrNGe2Oww0I3KV4qWvI+MIE4GSBZEtXUf90kYmbe0eYpvUkoipbbTOsmS4sBqvrmj7RoO+JTqS1mgyMgC4fA1nkyAM4GcDZKstvs4BitIsFRRxcR3Ws43eBm0MvQVmXfuUdLHL51v3JiLBjr/eeWoY5YlIrSP4xkaUfLOi8XmVAsI6djQFXGOJ2T1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wXb3M06nA1iEpSI93DYgeo+6cyna7z5MbS4OZVd7Z0=;
 b=lfjdN4ry8zHbeywJs5YZFFZ8SsMnWUjrR6EmuF/N4oF+VA6sZ6R4BCzix2F8kRNrUTgx0596k5AySc61xdkEvf6M0/IEAbra6qpHUNNAbBWpoEXFPFWdAeO8XpUHcSO40o3KVg3+M0n5nqvBOAZwENny8OsI8oEMuZpIC2DNj1J673ciRi0fs2rYuhfiDuvD/08+zKBGsxiI/Vlxkg1WwsDh3HKioxeyJ0ONgPxExGwB0yaGruF8T29Vjcki32DwqsD+talG2fhybMdxqf6gMc0Yn1R4QKTS4hqubM7ypQXTjp84sfwO44J9Gmjs/9fQbs/UEgSNYuPQxCLREXQbqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wXb3M06nA1iEpSI93DYgeo+6cyna7z5MbS4OZVd7Z0=;
 b=FjQODy6myvyBLwppNZNB6PpZqE7hCNapPLkxsO3Tvr8W1VQ5YZxvVygNeBlQqhbA+oeKGuCX3SiPxtyiOoYYg4cGVExnQjgfvKOMvFNGHZrLYpBRIAmXJ6MzjN5NjPx4jOQvB0AmXEZkWOK18VNx0neX4xcN6WBwwJm8d7aH57E=
Received: from BY3PR18MB4785.namprd18.prod.outlook.com (2603:10b6:a03:3cc::18)
 by CH3PR18MB5929.namprd18.prod.outlook.com (2603:10b6:610:1df::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 06:57:41 +0000
Received: from BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576]) by BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576%3]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 06:57:41 +0000
From: Jerin Jacob <jerinj@marvell.com>
To: Nawal Kishor <nkishor@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>, Nithin
 Kumar Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar Kokkilagadda
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha
 Koteswara Rao Kottidi <skoteshwar@marvell.com>, Harman Kalra
 <hkalra@marvell.com>, Ashwin Sekhar T K <asekhar@marvell.com>
CC: Nawal Kishor <nkishor@marvell.com>
Subject: RE: [PATCH v3] common/cnxk: fix aura offset
Thread-Topic: [PATCH v3] common/cnxk: fix aura offset
Thread-Index: AQHbnIbzdv72yxhmJkGlKRrGPtGDb7OGkeLg
Date: Thu, 27 Mar 2025 06:57:41 +0000
Message-ID: <BY3PR18MB4785DDF4B4790FD8BBA7CC0EC8A12@BY3PR18MB4785.namprd18.prod.outlook.com>
References: <20250304052217.796506-1-nkishor@marvell.com>
 <20250324063525.2650349-1-nkishor@marvell.com>
In-Reply-To: <20250324063525.2650349-1-nkishor@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4785:EE_|CH3PR18MB5929:EE_
x-ms-office365-filtering-correlation-id: 6545c381-04a5-4c88-d896-08dd6cfcab2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?1g3aqv5vJ0rlorrAQ/fvJcCnzSbejNIYtJbp4tlQ7mSK0OjX3thOIgHG2yUv?=
 =?us-ascii?Q?ZxNyjxl6toFoWBvb/s4v9sNOnIyBzToByTmyi7770nG4ZuC9Q8f2qb4/U2Nw?=
 =?us-ascii?Q?enZSj9jWGmGnoxU2uOQqM3w5Hrya6KWNJBwYDH6dMbl1jIEbSgnqAI5pKXti?=
 =?us-ascii?Q?KJafT9OAaejy6/56CqqQlbDoHOE1J8/hYEx1l2keVFq0OOWVX9C2hb4oxE6H?=
 =?us-ascii?Q?zMMmV/KCV5nMuZavSu33dr60V0X6bIUYT3txlvT9Zurx4k1n4FvymVbbMBIJ?=
 =?us-ascii?Q?DZ3pbWpTrDEctEmxtphUOSmn1QC2MUm88H/jhC9KX4fk8AThtveQQIgL4x5x?=
 =?us-ascii?Q?Wt3Z3T2ZSft+eoNGFMyEgT4mbW1hFha6EnTU6SfFQ01PJa10TgclCEYjSRlW?=
 =?us-ascii?Q?8HZq78npcSDm6tx2r1ruLo7AQ86augggQXto1ZeU7rbgk/kHZQ+9N/M8mMBz?=
 =?us-ascii?Q?W7rn+F0rI2cScTaviZfo3lEHKsFavDplp1JXEor+QLZMun/0lBuhUx4ZfCjQ?=
 =?us-ascii?Q?PqNVtTZzK0ud3T/7FENBPmHvvrck7HekWsfIkz8isWdvIzEs6WSP+srjBoPR?=
 =?us-ascii?Q?pXkbzj3E5V6hv7jgeWTERZZPeW1k9XYSnl5VKG8tQ5iKXgDpM41mJ61dExhi?=
 =?us-ascii?Q?rq5QyvxkB/P3VTYKNwFzpvCEVs/v5PnDBV9n9eWMoJ4V/YPANakCvUGwMxCz?=
 =?us-ascii?Q?4M07TklbGKNKlzWZ2/9AKqZnO7mFgRvaP9X3+teMYJpYdfDhnYRCvnzpeB91?=
 =?us-ascii?Q?OOuhSRA5S4gN8TtWfG+tfPPnChU4mUcKXry6rcGqTdQhK+LRV870QtEM1fYQ?=
 =?us-ascii?Q?YHNMWL55CYSAAAitb6se/Tgsck7MVlhCzuytS3wCEKI35gnhh3sB5jR+kStS?=
 =?us-ascii?Q?rr8PWEhtL/mQNCPV6ejRWXNkg01E17lL6HqHqguImU4GNy7aWDenMXx5T/92?=
 =?us-ascii?Q?9QPqXMS2IW1PI4zkqTbRHKlgb00FbsqLVshs2o4/LBzCFSKBd4/EVh+faKQV?=
 =?us-ascii?Q?hGHQF4nuDZvTn2sPGEGh2xGWJWgKJXdl2l6MLtd5WxiH7COotras54XmI3Lv?=
 =?us-ascii?Q?JekMjqZovpGCDpUt3hOnyCLWNnJoy8uP1LCOVF4IMcph2KCX/yAwhpJ6jVek?=
 =?us-ascii?Q?mKTTSLLiyhj16spkM+gHZ/Xu6EqEYzcBmGbSV/dovXaEBgHSvtx5Vpp+A0/6?=
 =?us-ascii?Q?EeWoBQwWiB7Vh1PLUIAgFcsXnp7vPMt0lw1IryTl18Gs7L7nSG8tsLGVlrBF?=
 =?us-ascii?Q?ezrCpz7O5q0qIX5dZQzcOivf9Vx55ttoZdOFrzAYsAJK0JsHUqvh6PguFJba?=
 =?us-ascii?Q?NDfZV8lHyhgsButFinLdxHQ96mnk1WBvCdS5YXZAhUkJJcNI5yr7L/heh8U+?=
 =?us-ascii?Q?c8XqoKBohjjkR857WG+02esAUuIKw7xb8aML8FD3KPT8bkdOhuZMg4PPH7CM?=
 =?us-ascii?Q?f0zH2d7Zv5xj5zksEqk6FnVrHGXEIp6M?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4785.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iV5miyGWZnUCrU3hs+wbl7FjY7xRq2xe9La7rQsuRg44X6lnGSeZ2P1+P3mx?=
 =?us-ascii?Q?F0vvnAdh4SIkgT/q8CKurAyAzqPwSJW+fyMvDuNPP9cKRBEAik10xOnKOPEX?=
 =?us-ascii?Q?Ykm7SN0sFiuSVIYQUeiN4aVSmCmAG3YJ5jYtJKmm71OS/muokgIUwZsq5iZZ?=
 =?us-ascii?Q?YpjYfyLGVjLHkJqGXOx+T1co9XGj29D1RqRJxjKDhzbXrhgiHj890yFPU+CJ?=
 =?us-ascii?Q?5aZqHNZoPgUmk9uJEaXn/yY48J+rGapDFK2ew4eg+hhZmZCfPNOL7s8KvT34?=
 =?us-ascii?Q?A2JMd4/q1pQR6l720bWJccWwDEK5G1fWORKMK8sWo5OP1SOB0HgYMCxbn0I5?=
 =?us-ascii?Q?syiWOBmNi3bqa0GcWVbp4VTGSKKT721D/hCegMTV+Az8V8rM81bxBOQ78ArD?=
 =?us-ascii?Q?6ZpFwrgYVPosccyfZI8Iptd8w1ol578/pT/jzLgYsqTT5kxKgAcuuTA37Obc?=
 =?us-ascii?Q?8jgI5DvMFz/dIf9vcP0I4k4ztqxQcpOHRXR/h2di22/yEWkpaqDTCmsy9UhI?=
 =?us-ascii?Q?pBwrmcJd6IntlnL4jCnFxGWHGhwAtmBB/dhsamr+8QkVtWW80rkantdtrd7p?=
 =?us-ascii?Q?UTp4F+EQbkkhBjaUpt+4BPh+IPdRoMgvycjPJ51QDXfw+sex5ZlCC+b/1F5r?=
 =?us-ascii?Q?VOALHosYE2dVdnUTLEGsJV7XPhdIj3iePEZBymzrpDV1cGVtmAygO7w50mAF?=
 =?us-ascii?Q?ESdmXJnLyOmd54F+fRYNaKzBBx16rIl/tgRWiRCBQdNqNCwj/faiGvb42oXU?=
 =?us-ascii?Q?nrSH6r1KyI1Ie3fZ8x0tUHBNyuTQch65OVRI7S3C9ZrEvUHzrO6FKqv66fhw?=
 =?us-ascii?Q?cGbSCO7wunn1uZxqee3hHeb+naIwf7cQpLbUpshHPDxxlsQte8RB535G2ryL?=
 =?us-ascii?Q?MO7W4gfsQpNMeawapyY8e3kseGJp9BeiHONHwlyx0fBxIyH12/3k1x0ofQci?=
 =?us-ascii?Q?PNdHOZJN73UI9W109bz1IE3OER5RNUjsnbeUwY7dxnOtjDYxeLy2yY015eKi?=
 =?us-ascii?Q?bfTcmQ3bdWcqYtT+dmY0da3+tNniQdKsBhF/0W9LMMOlFarJlneMvoymCpIh?=
 =?us-ascii?Q?ran/XtLH5ZLhJrKwzWMB1s6t5eRIUUOaHPKXAM8xBLkyWakYyb7C/AgP1z9E?=
 =?us-ascii?Q?hMTZZNrq55mDGYs0E3EzHHwY0be9BYogQCNX7ThZxE1IwJEUqs/8yNVKTSua?=
 =?us-ascii?Q?2dx9lifC1jLfG1eCl4YcA7afv7I9s5IA0N87LKvgU96TORKRBf6nYoJUVAPR?=
 =?us-ascii?Q?AxdQr7hz+cVITmhEdqa6lxepanGrFEy1IbtFxAsILquRlf1ClOsqA9DT0aAQ?=
 =?us-ascii?Q?18mrpPrUdScDNxqyXSypJFrh9mTDaGnOTv8QEZk+zGDBO01HeC1FmkGCyBMv?=
 =?us-ascii?Q?BJ5hLi7FZrtY1C5QkmBQ89g/l1fyAsuj7NErHg8MFig5OzTSpGSzbcEm/Ylo?=
 =?us-ascii?Q?5irSzg8Nj3fy4ao/Elrs3BCwVouUF/VR0VZSsnUpwqM5SVKXcgP2BcPtR7Uf?=
 =?us-ascii?Q?xTiuoRtu4jgxj6ivEmOANZblycnIMKf0naaghq5GnMGytnOvipdOiZrih3HD?=
 =?us-ascii?Q?aXDjYb9o9G9cjoVSPqgAs41mzOS5zrz0d3ck/RHK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4785.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6545c381-04a5-4c88-d896-08dd6cfcab2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2025 06:57:41.5623 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vQb+AoZW1WCcJvtPEcNiLx8aYRnZsRAInTZebf6gVeUoQmFeKJhin9jlY7mUX7jqrSYZeQYum3CpsrExoHCt8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB5929
X-Proofpoint-GUID: JcZJNi6rHnm1f4e9TwUaq4f4k5QtlYmx
X-Authority-Analysis: v=2.4 cv=Yeq95xRf c=1 sm=1 tr=0 ts=67e4f6e9 cx=c_pps
 a=Dwc0YCQp5x8Ajc78WMz93g==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8
 a=8rWy6zfcAAAA:8 a=XdJklsGTFhtxm2kHfmYA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-ORIG-GUID: JcZJNi6rHnm1f4e9TwUaq4f4k5QtlYmx
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



> -----Original Message-----
> From: Nawal Kishor <nkishor@marvell.com>
> Sent: Monday, March 24, 2025 12:05 PM
> To: dev@dpdk.org; Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>;
> Kiran Kumar Kokkilagadda <kirankumark@marvell.com>; Sunil Kumar Kori
> <skori@marvell.com>; Satha Koteswara Rao Kottidi
> <skoteshwar@marvell.com>; Harman Kalra <hkalra@marvell.com>; Ashwin
> Sekhar T K <asekhar@marvell.com>
> Cc: Jerin Jacob <jerinj@marvell.com>; Nawal Kishor <nkishor@marvell.com>
> Subject: [PATCH v3] common/cnxk: fix aura offset
>=20
> Aura field width has reduced from 20 bits in cn10k/cn9k to 17 bits in cn2=
0k.
> Adjust the setting of aura offset in NPA_LF_POOL_OP_INT register accordin=
gly
> based on the platform.
>=20
> Fixes: 620fc02bf7eb ("common/cnxk: accommodate change in aura field
> width")
>=20
> Signed-off-by: Nawal Kishor <nkishor@marvell.com>

Updated the git commit as follows and applied to dpdk-next-net-mrvl/for-mai=
n. Thanks
