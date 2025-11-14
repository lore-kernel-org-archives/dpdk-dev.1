Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3505CE8D4B
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 15:57:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B506C40BA6;
	Fri, 14 Nov 2025 16:57:00 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id A9E3B40151
 for <dev@dpdk.org>; Fri, 14 Nov 2025 16:56:58 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AEC4JvI3798908 for <dev@dpdk.org>; Fri, 14 Nov 2025 07:56:58 -0800
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022094.outbound.protection.outlook.com [52.101.43.94])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ae43s0gkj-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 14 Nov 2025 07:56:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nk1zOarrp2F7c3E5kJ6UAojkuXitTMvxeXov/0gcE1lbF5YSH9Shnd6iN7hE411Ruq9Ignpz6AGdK+YD9C5LUR+MMe8hpd3XcL0pptX8Q4AR7w4xgBcXlt/GCZ6bpu73enwhQzWHSuCUmsZ/c5Egl2mv02IR0zCgVDJ34HjRW/c2+kNli4wJh3hi2c+geAimrEpCjFhQ/hLxetPNpaEtX219yLsuUk86jzXED3xrOE/JfdYzP8wWrvNg6XMJimKSQLId2aI/wvOBKux4qeqwZFsCg0z5DdGA/PI2sqrEcUxH8L1wBKzQ9i/RbVDduoMuYKqF75evTRJszym9gBEqMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+dNXC1H3/DGsrm5nAHoU4eDbU20jRoxaJG/kcZHWv68=;
 b=t72Fsnm+lzqTr3h7ZCy5fynatpRTfjWKTBoT0HwQKCRkCBo+z38Be3Lh3oNlfMU7bdTbuVQ5HSZLzvWjCOSQUSc6n0Uln2kLFmzzMedDGn8Ny8qmPm2R7TgmmWM556avn7dSI2PxT4el2O/FRND8fuBvmw2TLPiDlmvc+mVe94YY4IZWT7LsKAnub2rM2Vi/aAVi5AFSmVXS0fcqSlY2NzgyXEQlK7uwK4JPteDKkVAPx0Fn+kecp/yE9x2GHqwngdk4Zjx9N2w491Sf42i9tKiM88r8eWeQFaYmkNkd/m5AsEUMQg1dRklpFDfW/h91xjbnPpnKkGj+ZUoSErW2Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+dNXC1H3/DGsrm5nAHoU4eDbU20jRoxaJG/kcZHWv68=;
 b=ZkLTiUiOsZsVg93yAP0690Lm/b71VhyK8XgDtIWyUBrqGJwDfjMETmqjl+gR0h1ZdkK4/xS09sjp6j7doFTpXhrIE9N6JOolGDxufOFFF1WPZZf2vs5p4FHgavh3/MkfLac9eVx6UFuEZwUFl9bT8ngTYTi7PB8fB3YTldXAdNI=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 DM3PPFC9CA21505.namprd18.prod.outlook.com (2603:10b6:f:fc00::6c8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 15:56:51 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%6]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 15:56:51 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Tejasree Kondoj <ktejasree@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Nithinsen Kaithakadan
 <nkaithakadan@marvell.com>, Nithin Kumar Dabilpuram
 <ndabilpuram@marvell.com>, Rakesh Kudurumalla <rkudurumalla@marvell.com>,
 Vidya Sagar Velumuri <vvelumuri@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH] crypto/cnxk: add CPT CQ support for cn20k
Thread-Topic: [PATCH] crypto/cnxk: add CPT CQ support for cn20k
Thread-Index: AQHcUvyxEunjycecnk64cPHTpIs7nLTyWICA
Date: Fri, 14 Nov 2025 15:56:51 +0000
Message-ID: <CO6PR18MB4484CF095D9DA9A59B868146D8CAA@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20251111111643.2279586-1-ktejasree@marvell.com>
In-Reply-To: <20251111111643.2279586-1-ktejasree@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|DM3PPFC9CA21505:EE_
x-ms-office365-filtering-correlation-id: 7439edc6-d6f0-488e-6392-08de23966d0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?6ngidAFQ6Rw4w4yaWleyySshAs8C4tUG5XMbBiWA1eKpNDAlwXVLsjTMaxR6?=
 =?us-ascii?Q?sVFwPRLtCYKY5E027qIbYA/qxsVnW8PLeW20xGkXcg0TPkoajyUc9oGNYJ3m?=
 =?us-ascii?Q?TOGx9SKCpYA96ldSAxL01el97LxV+J3aAtaYBRDwfgvkB4mfa4CGVn/Ud/ML?=
 =?us-ascii?Q?NoXRlJLroVTv/L/o349a5xrpGK/C3ekQjzg3p0WRBvVkpjn5FFmkVkoFsz3w?=
 =?us-ascii?Q?fwiqALyLoXphzKhxbGNDuURUXEKYr2HTxA64QLHdSohgurQuIEmkTrXDGHaR?=
 =?us-ascii?Q?mQpTGvK1FLvvlKNsBFKH1qL48R47VKQcuDOz4bu7R0LOlaQmKWkDYHiYsIcH?=
 =?us-ascii?Q?w+HzFuDnPnwHA9wuFYrZPbTPf5F/R6tIpMZqSlHrtqzylwSLcaKQ2AlCiteb?=
 =?us-ascii?Q?NJLTFvmmH6ZzdZrUgmMUq7AMhMdB9OsWNAzXgAD61YEpRmg+GSpo9BUx6FXX?=
 =?us-ascii?Q?a6z3ZTqQwZs2hOgQloyNZqhZEXtuDBn4FWqHlNP/r4lSJ8JF5URYcbW8l0hq?=
 =?us-ascii?Q?bxBacwDogJ6pUwemgWPF//lUgFjWx9xjxzkp8wHyD3a8xy4narkfssHQnLW3?=
 =?us-ascii?Q?3LhRCkj+HZNe9//P3vZEOf6jCH22mKuuATewdhWUYEHR34fABNmB2TRX8uDY?=
 =?us-ascii?Q?cU5Uhs+qshP/CpspupgI94pJo+GXxUfDKLK5WtzToCvQOLjqZ+KxghSgS5e5?=
 =?us-ascii?Q?ApXL3gf6oWmogQxXoKL1JYenOicOytzuDcy45bWa9blZ0C40TnkfZ4AGdeRm?=
 =?us-ascii?Q?WL5F4i8yu9bUpexCzASOJWiuZ+MV0W5PpsGj7Fm3Va9n1TlbsCf/LkeA2PG2?=
 =?us-ascii?Q?4ojmdB8GukCkYZEEW7x4qMjUFz0s4bQLSyyK44aCV9xKoRvkSSCdK3IKjT5i?=
 =?us-ascii?Q?mnou+nLAsbuIV2DgpeiOo65UVLBiVxD3rOGboCvQ+szvAnPvx2AE8T0CtDXa?=
 =?us-ascii?Q?TlTIRpg0m+R/YQ/nnt95D/artHF+Hs8qdj9XBGiwK045IEJTUEUJ3WVHxvwh?=
 =?us-ascii?Q?rvI+TtRrkbUTMf+NrK+4zTx1ojBA/KAwfESGKskzg8hQ2PNlZpjopx2A0Yu4?=
 =?us-ascii?Q?edhVJS6pAV8PaQb3CeTK2d8+Tv4e0m+a1GjM+tTpS77tWf75EyNzAoq+WT4r?=
 =?us-ascii?Q?6yy3JKGLwRAfZsuTi4j21uclIrtQqLmuI2cWMTv3UtXAdeXJHvfqznGkZrm/?=
 =?us-ascii?Q?3ErnO+jUs1FHwZmkWzkOXs7QJw87dk9CHdDoyI/cHQQBanNwRwCQUyORVJTD?=
 =?us-ascii?Q?U9P5ptXG9f9bPcgL3r8Vt8Mj+RmhZo+51olDK6DEpy1XM4qH0II9oM7ldusw?=
 =?us-ascii?Q?MJDBGW6ggD0n0K0DR/d73ffiBotPQKHMkxD+veu7xZfFBa3QW+lpHNHAI+Ut?=
 =?us-ascii?Q?gCUswuyYKKWptkuLl0PLiyxofh24brYYStDS77mSDDYDEvDzqUKoNdanjOtj?=
 =?us-ascii?Q?KeVKkS6J7mBtKH8Apv6bBKpSNRB56CA42RHspZPAqP1sJbZgke3dCrFPSrG/?=
 =?us-ascii?Q?dWx7h5tgceFVTDPxqMnzt6x9PaCL6tJzItX9?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ojx+RnprDrhl0rP0XxLiRlLc9QNMfpOI/85XBKYudoouQEXdUAUq2GE9WiP1?=
 =?us-ascii?Q?cV6+BR7bbtl2CtAjJXlqSfVjhgaQ3y5+IhIsvay+DDjeChEkuCVbGJO9MT9H?=
 =?us-ascii?Q?yB8F8BV4K5Pj/OB7tosnfWg0+UEvmGFs4wK8HoJ8mldlKJXUkCrpyhUZYRcq?=
 =?us-ascii?Q?Nn1g8eXnH7jKU4B6EHln9FmmA3KMYI5wSxKFPsSfVcwAAvTECKvZjsfdbX9o?=
 =?us-ascii?Q?AbwQD2IH4ZkUTqF7PaNBXCcowDIT2b1pjd/tqcv8C1JMSOlfseDJ+BcxoA0t?=
 =?us-ascii?Q?H8tzPyAAKaOYz72vVedw9k4mP9jc5CMgiJ/FUqDT/m6PSyOqgDJ2SIftq7Vp?=
 =?us-ascii?Q?gYt9jRNUXJl+ales4HFNg98b26P9NpG9oV8TMjju77rsfuwuJQazdqFii4gB?=
 =?us-ascii?Q?PNHmi7crAwb7KpEpvfYCZ5XXNjGt1OFzk6uA2ruEinJfJAaZFft3+kBgWgAl?=
 =?us-ascii?Q?jXgh1hUQNquGxjx5fzhFtl+bIuvLt/2G/jVk/u5lmZGOXZdr8+vFnuNL2qtJ?=
 =?us-ascii?Q?9IdGI83BrJaXk+H/Xbsi8u0jdpKC/lU80r/Wb9merssdD17Xq5NQnyf/a88D?=
 =?us-ascii?Q?WN49TKjb7e75Om3iO52M51ffBUtH8yvVXrW6HShQ67JgQKHbS7mFyRprb4Ix?=
 =?us-ascii?Q?2NSg3ktt0HsUE+n4yru20BRgaMvqINAV+bzMe3yt6F2JktO6BQTV4yupGnzs?=
 =?us-ascii?Q?FjvEBnwnqFu4oPJXrxDzJv8kmgMUzRdVasNiAE4ffhWAMKMMCao/c83sBlrb?=
 =?us-ascii?Q?6gwQVDRzZvvW/BEm76DdTzGMfAUVi6/5DiQ2dSJ5LGWJ/GZbtrOK42KnuFxe?=
 =?us-ascii?Q?wcEQeiuXHeICpIEKNQNMTbW7D/k6KHNDlO2kkVAzwx/gbqtBokaGWJm4244E?=
 =?us-ascii?Q?pdyhSEzJCDQXJBJbdVO9YprcO96Yw9nuoIO+h+tFsVHcc7juQ9TS0ZI6fEuv?=
 =?us-ascii?Q?AT/nj5NUSGYJ7cjl+2OFQKgn1rRib148pCudQnSpAErXKs0Xs9uQRXOG/G4E?=
 =?us-ascii?Q?ppjEoa2fc489NsdRBqvyr8i5arTfb+321cWtda/4sTSXrEUDMZWz++UIpLlm?=
 =?us-ascii?Q?EvbnLLy9rD9574qaUCnVp+gyCZ89BB7gOTnUaISmHDh5KV6oyXonqfrgvABw?=
 =?us-ascii?Q?SzTUgJ3dwEIN+kW+LXHFDBK6RtWKHw70qPDqrO6tHTCyMWb8ttJWvRbgDJ5Z?=
 =?us-ascii?Q?7jweXa1s5RNd60WA+yL5J+QgpYgiNxEAeCcGweFrgNE6qGYlIiV0arYNjX/g?=
 =?us-ascii?Q?M6qdWVNpXv6YcFH+oCtnLeMaLk6G3DnfRlLeXalLi9IDm03rZK84V+58piOD?=
 =?us-ascii?Q?WKzKOZU7bV8+9Eq4WVfvmKcNCx/W52O3XSd25/rAtNqybPxKVpCPEeJlQfd/?=
 =?us-ascii?Q?LnALqFQ7KjFhA1N1J4rculP86gQrbKfblkMyV1tyYPYt7nTvq2gTdXo2otNP?=
 =?us-ascii?Q?wsHDJsVXnsR2W+14rGhauLMZrr8vXu1GUc1ynY2NZGlpV4bzriHXhZUCf37t?=
 =?us-ascii?Q?kkhnF4Vl3C2Q8wosC/0Nm0/7WdHWFZHSBHIeGn8cyoULhLdh9lvG/G80cuQE?=
 =?us-ascii?Q?eGo/xuiNevf6iy//KhI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7439edc6-d6f0-488e-6392-08de23966d0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2025 15:56:51.4790 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GoMLuPYHmpUiQJnaJQooNX+MuZDNT85HYYOZ8TPQkRk9ZZSnciv8vnRATkb4T5xDOs7tMYU4AzmBbBHU5FPfZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFC9CA21505
X-Proofpoint-ORIG-GUID: oQmNLftWVJCqti5hUWH9Gv_351RM6Z3t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDEyOCBTYWx0ZWRfX46gayFUXdsiw
 J1nlE8nnHbqv7DrRgKM/0FjxnKrd9edcEce2HeM2TH1YvZGZ7MQhevo8d7tNKw+GC6MDozIkdgS
 2i7NbzSMXFqkXGr37s1+Yo2Oka2FaC3xLbD7kHJoWZs7XWT1vJZw6Cu/+nq+Dh5EB/ydn69rM4F
 Z5wGLNyxLkMsjyes+aEgsuT5mIg1d0AZYvEuV2oWQQiTH2M1QRW9hwjBXlRfpJCssEKeeb5xuFL
 pDHzxiieqvQjMwRWapsSC9Sr1eLKqGtCwcMxdAZDP0HHy6LsXKJlZmpoWLdiTAZ0MaeZUAEbCau
 620FqEN+jToO0Tjo6Rq+da6IBYVotR+YyAsdc330M7tYzRChfqleCfha2ruvL1u9k7R+O2POHjS
 jqDhdbLT5NhRUW58Q8Dub5BZ8eRb1w==
X-Authority-Analysis: v=2.4 cv=NOHYOk6g c=1 sm=1 tr=0 ts=69175149 cx=c_pps
 a=13WRnYNq68uQF2pe1ZmaJw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8 a=zOl_0MzkO7kqa-rY-MMA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: oQmNLftWVJCqti5hUWH9Gv_351RM6Z3t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_04,2025-11-13_02,2025-10-01_01
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
> From: Tejasree Kondoj <ktejasree@marvell.com>
> Sent: Tuesday, November 11, 2025 4:47 PM
> To: Akhil Goyal <gakhil@marvell.com>
> Cc: Anoob Joseph <anoobj@marvell.com>; Nithinsen Kaithakadan
> <nkaithakadan@marvell.com>; Nithin Kumar Dabilpuram
> <ndabilpuram@marvell.com>; Rakesh Kudurumalla
> <rkudurumalla@marvell.com>; Vidya Sagar Velumuri <vvelumuri@marvell.com>;
> dev@dpdk.org
> Subject: [PATCH] crypto/cnxk: add CPT CQ support for cn20k
>=20
> Adding CPT CQ support for cn20k.
>=20
> Signed-off-by: Tejasree Kondoj <ktejasree@marvell.com>
Applied to dpdk-next-crypto

