Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D21C5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Jun 2025 11:45:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 007DB4028E;
	Mon,  2 Jun 2025 13:45:31 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 90FD84025E
 for <dev@dpdk.org>; Mon,  2 Jun 2025 13:45:29 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 551NjbxO006517
 for <dev@dpdk.org>; Mon, 2 Jun 2025 04:45:28 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2105.outbound.protection.outlook.com [40.107.244.105])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 470ye01900-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 02 Jun 2025 04:45:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eh72hasrJ8SqmQ+vwhNWeRAArtHR9J1BnLcJeKJqYEk1fsUuRuC/rYDNKlpiyP7M/SirWZwffrQJAkO16nmGJjSapIzYZDb4fixutfzVXoHnPZnr2Vm1ZqTc4NUjxM+lrBzyGTw97vNybIJGPo3SwOM01dXQGKYmhneQIxsim1NZruadfSM2gE31MPUyjvKtq683LnGdnpQsbaZKHgGsueD7+5MKnaukDqZx+ZzJjKKqWCFis9WbKh4c1Uko39qIqTzaHkiKIlgYmJGEJ8iUMjt+35pyCjuGyf7XjJY5jHX34iKZCzbMQ54Fs+hzIpwXdlC7ZvYd8kXpi1HtvMoUOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NR5J0onbDwwbxfGEbLX7qPG5Y8PTUxcU7EGSH139thY=;
 b=lKiMgjqIJBQBfqKQI0MYVNZx9069K4uZq4oyzXT1Rw7wZb8Ag7SqMLZuAOQ998J/ljFA/WLCIBiUFbKXO5PnabKYIMs8cb73MQnbD+UUjP1MN+uCRohulInE/Kao1yK9XyMcwHx29F/HYDLegupZUF04LwLeyQ3HlkSM++oSAMNTNCmMuAOaHNhxjpf28SlYp8guJxMLwuW4FwU+GdwUQMCOIIqcG8RyA+8FVf3U7I/7hWZQI0+gFP8wdXb0/O22+e9S7Gq/uSz1VYCKuDyxfJXyPKf3/vP+bWyTPts+U8cVQzQZFtY1FLxrZfDaF6fvtu7hE66uoujIcPQFaNRmig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NR5J0onbDwwbxfGEbLX7qPG5Y8PTUxcU7EGSH139thY=;
 b=Lnwg7If1lXYX90oTrmPqILGXpUFaSJwdLbjGhsWGT14viGcwTVgNBgQ/CCnGRHNX6/e7WkPibXotVasOLAYzrDRv/IvvYIx6MbiS3yEsJRLWFyxXpkBTzCAW/0gL+GuPVVgKyFVph31Y6uoyask+0WSHkJjJe9MVqPDP6vzViqA=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 SA1PR18MB5946.namprd18.prod.outlook.com (2603:10b6:806:3e6::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.32; Mon, 2 Jun 2025 11:45:24 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%4]) with mapi id 15.20.8769.037; Mon, 2 Jun 2025
 11:45:24 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Tejasree Kondoj <ktejasree@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Aakash Sasidharan
 <asasidharan@marvell.com>, Vidya Sagar Velumuri <vvelumuri@marvell.com>,
 "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH 0/6] fixes and improvements to cnxk crypto PMD
Thread-Topic: [PATCH 0/6] fixes and improvements to cnxk crypto PMD
Thread-Index: AQHbzrvrA+uTlTwm80WE1JJfywo5IbPvyhNw
Date: Mon, 2 Jun 2025 11:45:24 +0000
Message-ID: <CO6PR18MB448443979F01CA8938D6196AD862A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250527040036.2280893-1-ktejasree@marvell.com>
In-Reply-To: <20250527040036.2280893-1-ktejasree@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|SA1PR18MB5946:EE_
x-ms-office365-filtering-correlation-id: fbab26fb-546d-4f49-f2cd-08dda1caf639
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?RSQt1EtNdOggu0ent7yMXb3DtTQ8rNMlbxpNHn5awZ78VHKnbeDTy6bXUPnd?=
 =?us-ascii?Q?OqYVAKLTppttYSZCI0tHwB1i/BDLnFM+kWQV0+Ez2ji5+hjxSjvcfq8bo8kd?=
 =?us-ascii?Q?F0RQ0iPIU0JP8dUwYKydL76nV+8QURaHERX6uicCcfZRNqAv31thCf3BbrRe?=
 =?us-ascii?Q?cDrLKSyA7z3Ap/T7krmS+XcFdEjQ86zAyIyrgVfc4FLM34E2LxwpAi3ydrAD?=
 =?us-ascii?Q?9jF+byvZXHytblyevMenzV3ilqdjeUzNsdQHExtEptRd+Z68774ajNQyPqEF?=
 =?us-ascii?Q?L5B7lYm/ZtyRmRgIGHB5zZcHOb/GPbsrWGRfi5ONxwrSE4HWNFBkV4J/HJsq?=
 =?us-ascii?Q?a9BgaQ6JglioCUDHwVfq9TdsMTLCoWQPLJuOtqYttaiFKNnya6Y8bb/c0NRt?=
 =?us-ascii?Q?0Dh+PbHly8iiD+woFGx0DPdfYjxwfHnUCpfMyR7rs2nzO7joRQkG3to2Vgo0?=
 =?us-ascii?Q?6Aj98iD+xxdqAyI4nrhCkQLNkADQJ2CwLluovSrPSy5LLyLyzR0NLM8nKKcA?=
 =?us-ascii?Q?PTH9YEgDcvVbVSA5RnSMK0Ii4Nb/I5kdhH3JAGfAKU8eSo0YYeg5yEN0KGBt?=
 =?us-ascii?Q?XOnOxoyYQQ1R7YsKHRigQWk+XfOfqq9EHlOByFboirE+XNfqlxfLZJ8a8pc4?=
 =?us-ascii?Q?Qpgh6Q6rIfzteQjefzkMmszNO9ma22pwDdJztDSWpOq5Z0i1KqA0M/XVXdHI?=
 =?us-ascii?Q?vo1XUNQPorqsQi+YOnO8pUzpIMrUhE1JvBJaLVlT8JTPwXm81uIVe1OiDoxA?=
 =?us-ascii?Q?UoHc21J2zHJDM70wDSZwnlvvTfAM+ad/ud3Ua7bXsl5/34P2+eFpaZo9QJgM?=
 =?us-ascii?Q?VHe5jIA9HsD/A4uilFIn2GITmwddYN3wthq8sl+n8BU7JltwApkAfnQzmSho?=
 =?us-ascii?Q?PsXjyTRudvHeyL9y/KxUkV1KJEFq2naZdsCB8hV8KSuh2K3FI8jqc2joZE8g?=
 =?us-ascii?Q?mJ6YgnUy2h994/su7VTzYmdNxznKe6kdqf7aWi3+yXB2gLi0oGr1hkHs8RIR?=
 =?us-ascii?Q?AF/Axvyu30RFzJecyskEF+J2Wm7w+9rVu9Agpuh7Y3OzyQA8uzdwz+A1oYOr?=
 =?us-ascii?Q?pND5MoXjl/5j2RWK3a7akDUdwxtQN33JF/JmZ3tghJR58kN5dYlm8D00nh1y?=
 =?us-ascii?Q?J6JQLgp0RJN3Si0Uq7RPLhWYJNrR0dc3jNArbl0BHs+Q3rjzjtDqGGHRRz/e?=
 =?us-ascii?Q?eVy+4+eKkxq6kcUQjz/WKxLGJGdBoQszB/pBcv5MyQyDlqo3L+Qus56fuvQA?=
 =?us-ascii?Q?SQ/E0bF4+9llz8IMJJnls3NoFzAxvWG+L1of6IaOWtLgfKgBLwanNgdHyRE1?=
 =?us-ascii?Q?5eWdAAhAsSZZGYzylbjb6mA6AXL2GWqn40eSNR1yIWpWcPz4Bjtzs0tnnwoc?=
 =?us-ascii?Q?sQcKTOF9oA4HdlTzzYKnlygWIX/rVVSyFKcg3F56UfFoMSGW7e0+qIq/O78e?=
 =?us-ascii?Q?ZaL8fG8uzOfRa2SljWEQmKazQNMnTqtsDm6Tym4QgB/oviN+1hvquio2zscs?=
 =?us-ascii?Q?b3turm1nwvKqMuQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yc/1CWkLiZPlBjztspSImncQd4dccwf31KjUHoKiLvbL5+TEl0YVILWOTWlq?=
 =?us-ascii?Q?MJaBUUiegdXKcFLRKzXFiTVOnCdJ8JOdh2QxrFytfHU9zoFzEnweGQudfF9v?=
 =?us-ascii?Q?ZFS2wpHBAio8mqZktgttpG8MGUi6Tc9ZpUel4myvMU3TvYUwJI5CnMDVxDLk?=
 =?us-ascii?Q?j2c+I023uXmCCfaBw4ZJxvnPrP4JqTTu9kra3RNCODYb7DpVOfVkKKJjeJnV?=
 =?us-ascii?Q?uyG6z7OuxFdZnTPiWiVoCM70zUQhj0I+jKyJlnJsofUtPeRRHH0hwDZmfEW6?=
 =?us-ascii?Q?f65RE83CSAAk/gnLOuTwp+kU2BMgWKls5pIccXrHal9Wd/LpJ0txZ1WsRFfT?=
 =?us-ascii?Q?ZBkE/U0FKvchYICoqBU+c7Dkp8ByqX2PIl4R1kscTT9N5d/LEdkYPHsbOrJ5?=
 =?us-ascii?Q?ODB9ovz6v0amtz0eU324Vms0w6xqZheaU8Q2OPy/m4ck0UaTWoIcj+AcNyYN?=
 =?us-ascii?Q?ioRaMkudU7CfO4aJZJe2h4wlOD9szFikdovuwmvGP8ihyifMBtwLOvlmZTGY?=
 =?us-ascii?Q?JA1LHdjKExvuzaB1GwVshn0gnHegQhp2IdQIlT5g0Qp4nEIornsiVZIWe+4V?=
 =?us-ascii?Q?m5gZICuB15kneZzXwGdQADabFL80vEG22EnQJyD88772TCm4+vzs2N5fHCA7?=
 =?us-ascii?Q?llRWF2loqOJpglrseys6/Tf6ejL7AgQ6doIP2UDv1p1kSOhNeGzmwBy3p9X2?=
 =?us-ascii?Q?Aq7gZcRkOJb3hodGN7/A0nVC6wXsG1vkXZRJsq5/mzD5DMbM/JYVmd62Pswt?=
 =?us-ascii?Q?HlmmlV6rdc+mX+hGOzViWmLzK6TKJvCe4YULhyxLq4kdxE2XD0cw26kuSqXE?=
 =?us-ascii?Q?4eTJHOwZg0NkmOl/RT/31JhYArXHqex5KifH+SqltQjsAzqGvS/oRkxjFl0j?=
 =?us-ascii?Q?Y5JJpgh55rZTAXOZkgyft7ydqMNuoXRhSbm/yfRRms+zoxgtVhlA8joBHuKk?=
 =?us-ascii?Q?KwhtpiRQ22WDSX6cIVX8psk0V5Aewdppzw6nh3AAU439c/B0oDaabXPYJShi?=
 =?us-ascii?Q?7p9XMrWHmQvAXDvSh5hCyilDz3wYQkqAA8appXMNSdYomZWmbAbHD0oDHz91?=
 =?us-ascii?Q?CMmvyXuNEBtIbu4IcoNKv77V87QJy6wrOvALYhy6NPIpynHAdySIg3Q4g6j6?=
 =?us-ascii?Q?mPLO0HAhXiCsTdknLo2bcCbRpiaT05jUmiKIruS0ILlW2ygiivxrIDPE6AP6?=
 =?us-ascii?Q?LkSzvrz5IUJJ5HbrzutAynmoxWv2c4e1wPpnULAo7LZGbaOYLs6RQJuAyIum?=
 =?us-ascii?Q?9Vl9d6Uy0geyB7Vr6r5a5IjpRbhZA/LzHEyBxvKwQEE6+KnMrNfWyOTDazhB?=
 =?us-ascii?Q?1VQLESHvw+zTtchNGeIRXRhpqEbCo5AWlLkE16/M+vXOySgFDlxDecKOcaXh?=
 =?us-ascii?Q?YZHD8JYkmQq1YYSItiYxgcaDBYpIxYjZGp04ctvn95e5E/XuLQZUj6xpe8/l?=
 =?us-ascii?Q?18y6bbzu6BnV2fMjCiNRKdtTKMEIFXbn3lgy6Vv7wtH8l2smuPqDRiHC8VzV?=
 =?us-ascii?Q?WomIO+tP4CRN/b0zW1XBc6pB8qwUSWmg92dRoyUd80q5mY9V97qbm8imHKM8?=
 =?us-ascii?Q?ST7pxy9bvOau5mhKo7I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbab26fb-546d-4f49-f2cd-08dda1caf639
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2025 11:45:24.2543 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8qRoiaPxoOxxNI+bjLiSi0ffoiz4B8KGA/NLoJnJ73tmlYbaQhEjRtMAE8cste5fkgG4n16F3nVvdzbyNEBmQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB5946
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDEwMSBTYWx0ZWRfXyATE6yrckVzq
 5c/KGSRXe3h6AwvzuFfU6waHkxop8tHMbCPadr672mdH3xL28xEjonBkKNxFu6u1X66e4asYO2b
 /9S0y8o46GCpSK/P+T90tiuT6xQ53M08dSMsfTvLRbevRH3Q/m9TWbMB9hIjqpYa/Cnbx9EzzJs
 x0Y1PC9J2QzHl/l6BFuRGRnZdJ7K8AWypLl4gWGCUU6hgSKYFD6OVN++BAPdqQsj6LrY+0QLPeA
 sP6Qknze2ZobhjF51TSJ1qDc5NshFTm0NrrQtfbEXEixZigLjXEG6ynv4c/LVwoOFhiLN/OwwSH
 m34Q8asFeVLMJyn4DBKL3utRqI6mGxK7LQ2vfppMfT+fl7L3ZIL2DGZ59g9NiplgKpIpMnhI5Js
 DGB4fSEIXE505fayz0BF/ncB5FzKjljR0eQFPGrJeWjeR2idm0ONW0ef+VG86RA1cejpuxaS
X-Authority-Analysis: v=2.4 cv=Iv8ecK/g c=1 sm=1 tr=0 ts=683d8ed8 cx=c_pps
 a=W7ZfpJ52Y0I/iYNgY30rAw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=4f-iWfeupCBa-5fp5ZYA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-ORIG-GUID: JOgy3H82foNpKBqEn0-2V1ppQGLLzTeh
X-Proofpoint-GUID: JOgy3H82foNpKBqEn0-2V1ppQGLLzTeh
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



> -----Original Message-----
> From: Tejasree Kondoj <ktejasree@marvell.com>
> Sent: Tuesday, May 27, 2025 9:31 AM
> To: Akhil Goyal <gakhil@marvell.com>
> Cc: Anoob Joseph <anoobj@marvell.com>; Aakash Sasidharan
> <asasidharan@marvell.com>; Vidya Sagar Velumuri <vvelumuri@marvell.com>;
> dev@dpdk.org
> Subject: [PATCH 0/6] fixes and improvements to cnxk crypto PMD
>=20
> This patch adds fixes and improvements to cnxk crypto PMD.
>=20
> Aakash Sasidharan (1):
>   crypto/cnxk: fail Rx inject configure if not supported
>=20
> Tejasree Kondoj (3):
>   crypto/cnxk: add lookaside IPsec CPT LF stats
>   crypto/cnxk: fix qp stats PMD API
>   crypto/cnxk: enable IV from application support
>=20
> Vidya Sagar Velumuri (2):
>   crypto/cnxk: update the sg list population
>   crypto/cnxk: add check for max supported gather entries
>=20
>  drivers/common/cnxk/roc_cpt_sg.h              |  1 +
>  drivers/crypto/cnxk/cn10k_cryptodev_ops.c     |  6 ++++++
>  drivers/crypto/cnxk/cn10k_ipsec.c             |  4 ++++
>  drivers/crypto/cnxk/cn10k_ipsec_la_ops.h      | 10 ++++++++++
>  drivers/crypto/cnxk/cn10k_tls_ops.h           | 18 ++++++++++++++----
>  drivers/crypto/cnxk/cn9k_ipsec.c              | 19 +------------------
>  drivers/crypto/cnxk/cn9k_ipsec_la_ops.h       |  5 +----
>  .../crypto/cnxk/cnxk_cryptodev_capabilities.c |  6 ++----
>  drivers/crypto/cnxk/cnxk_cryptodev_ops.c      |  3 ++-
>  9 files changed, 41 insertions(+), 31 deletions(-)
>=20
Series applied to dpdk-next-crypto

