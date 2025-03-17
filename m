Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3560FC282EC
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Mar 2025 07:49:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 07D5E402BB;
	Mon, 17 Mar 2025 08:49:50 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 1F2F940291
 for <dev@dpdk.org>; Mon, 17 Mar 2025 08:49:47 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52H1N2KQ021016;
 Mon, 17 Mar 2025 00:49:47 -0700
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 45dtaa1k9d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Mar 2025 00:49:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRYrgtA9RaS61cZeScvKnHR8Nr4PDAQ+mgY77yynzjO9hvESaNDdsb2ZssmfoXAlhHASxooYLLlGARRM/iaxAEkcfAsA7Wap2Ya/o2buqIRWPKW1RyK1kaYbfOkIkggM0OGiWTQMQoRHzjZ3J+bbt0FYkLbsM8QDN0Z+Q32EcTVt7D6V44sx2Sb24uGfn+D+o+MSfhVEj+gluOqfq2EvBuhreKkAJFZVbeC2FWfzbgRvyqcagREfmObzqVCtuqU6MtFSrKrpFgwWh0PnsJZ8q2+CRDANQmyvDnAPWQ/3oy7QZ0YEICfJmtR1HuR1nGAMryuXH3fxh1etp7UE7/zPlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRr2qgpr+1owT7wOiKW/JlOqdUAxgfIKjBCsbonz8IE=;
 b=pwxf/zVRAzNPkMjyDFOe1Pn4r40SxU3yBgYdQqROUCADrmkSDNOzsHFwsBBjYcLbFB4Aaeozo/Pc49WKlPsDRJxvJZB9UmuYfpfMUq20wn7iD/gewgga4mshq4yaQv3OJ81ThDXiuKeqcV+EJtRDP+jd225Tu8DTbiHsuov0bbqtcGYT/2ioVpXop04HoWIDO4r5tvOjRYIL3ePJlZKtcouTgu77ziZ80+gVd7nmeBLEO2U9/WQfyv7Pm8gcGL6lF9sXBzvSL8NqIvcPqcBcQpUHHZ361qat2phAy+pSCZNkk05TRzT5IO/QKdXVD03tczb5h8mLFjhORDsL0rzMbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRr2qgpr+1owT7wOiKW/JlOqdUAxgfIKjBCsbonz8IE=;
 b=n/QGR/nJAViczQ91b+YGAny8gJxp/7molOd0/vmUc3PIgKaJaCAwVtfr8g0zeE9ZLoZcvn9ZK8OZgHpR6TyJ/6BwH94rSAfjsMrAbqhMyrPto13CQx95gA5ylgVW3y2hvlUxKWiz44ptwmaHVCZaRcdfwxM85luMQqZCyCzPUQs=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 BL1PPFE5D90BB53.namprd18.prod.outlook.com (2603:10b6:20f:fc04::dcb)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 07:49:39 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%3]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 07:49:38 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>, Fan Zhang <fanzhang.oss@gmail.com>
CC: Anoob Joseph <anoobj@marvell.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>
Subject: RE: [PATCH] test/crypto: skip test when virtio PMD not loaded
Thread-Topic: [PATCH] test/crypto: skip test when virtio PMD not loaded
Thread-Index: AQHbkofEYgxDh4DE5kS/kYUzZZMMJ7N2/RHA
Date: Mon, 17 Mar 2025 07:49:38 +0000
Message-ID: <CO6PR18MB448422C9334DC6741F7A5A72D8DF2@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250311124749.1219-1-gmuthukrishn@marvell.com>
In-Reply-To: <20250311124749.1219-1-gmuthukrishn@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|BL1PPFE5D90BB53:EE_
x-ms-office365-filtering-correlation-id: 0d547a56-2c28-490f-e815-08dd65284523
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?SMCKI8pJfOb17IANhoZp7t8InOs4ULGtnj7V5QPAhPpKJpAM48cYkxQmzKg1?=
 =?us-ascii?Q?u+YPu85J2IU43MoEFmlUl6QVHV0V7aOp6llNRWSBkbsFHEnGMr+dCptpVN6o?=
 =?us-ascii?Q?jp92c9bs9YEwrp9FWldVO6T1DUXEDfxtPpDLkjGKmJ7Fcy0jDh+Ll0Psp6ne?=
 =?us-ascii?Q?MWTcFsrChrYSxRRAhOftWv/Qbq8dPtRtfpvQEatflaTrnqAOZoU+lXZo3W8V?=
 =?us-ascii?Q?z64oBRRjUhvPO7mb37OY2THZvy3Mw0uHj07NCtAtaUeQUcI064jy7MjCai05?=
 =?us-ascii?Q?4YowTPOqHPxMCLRlRVUMLTmt7sAxUPacYo4rbvReazb5MeuiWzoclB1MfrS8?=
 =?us-ascii?Q?C9GdqomAKlfx8Auqd4U/SmNDyhxI2ch9uAr+7F64GGaqxDk1b+IwNpcrtKcv?=
 =?us-ascii?Q?5F9eKnFiURwj5mUSMK9+MOZ7l9m3xVM3OSROisbD/4FfLPC/I61n7mFNEodN?=
 =?us-ascii?Q?shCT8/brmx98ewoGuMvDkzpFgbb5NZ2+Ersq4/Fsr6u4AoROP7wpV/WwTcRB?=
 =?us-ascii?Q?vJOwNY6OCBaupfwasuCKfLuQSClWbEvtOUaQey3ckXUt4XqtLqPVn8G7rLC9?=
 =?us-ascii?Q?/v7U/FfY6RzEDAZR+KuDWEGgrqSl57qYh7WvwIUkTTxTLGTnavsGrupmNCKS?=
 =?us-ascii?Q?E6BRyXXMuBUR09hWkeWFu/1Bf4ltARJuZo6hq7lwSPvttlV6Vh30R2Fsxbwe?=
 =?us-ascii?Q?67ZoFQDY3HYnpo2/imVuBDBUqUNTWaK393Hbsx6/4edH/gRmjdW9mPPdRNpc?=
 =?us-ascii?Q?vqBF7qkaI1KlfkHM8Am7QFK2rV4SYUfOKiwsALVsvZ7A8Rrp8phHTngiFnMz?=
 =?us-ascii?Q?Ooj/5Ryf1HRParI2z2msdjtw6ChWtQhwOa+60QR4tkJH6TiV+yahcLUDMUKX?=
 =?us-ascii?Q?zaBUEuHf/TngFkH/6lPhSyfiVFK3BWpwjri9ap8NSZ9jmWyfhDlyaZiWe/ml?=
 =?us-ascii?Q?26TgZTvxmcymF+paDBDGsXf/wf4145D6WReRe8Q+HKbkoYMh1qLcQ2qDwm/u?=
 =?us-ascii?Q?EeIsxLDZUZZB4FKZCvRhdPi16P2nyAJW+w08Hur8CYUFp4mOQ4taNXtniWUu?=
 =?us-ascii?Q?fVVw2wNSPOja2b4NC1S91Cl3rzQQQR4CIqCDgLyETA76QXEofNbyiJNSl6km?=
 =?us-ascii?Q?E3SekEPRptICrwT2nb21Lq5K/UVHs9u228Oww/PadKzFMTcYw+qs9HXljnNI?=
 =?us-ascii?Q?3zzxHcY0qSVyPvjWBgnPa6l0JimaujtXs0NZ+jMkSlSPhqTqwr3tuY2L4NVW?=
 =?us-ascii?Q?iccubfp1Qj4bI7rfe0298F8JWok599lw3O8loTrZUpKg4gOMcF8R6BVwuu3y?=
 =?us-ascii?Q?NPWYm5XN+AGnOsNv0hM+Y8q25nJy40wrruxb4Aj4t2aWCT9Ar+ale+pOPtRC?=
 =?us-ascii?Q?spyYU3IfGNm/xcR3gScSjLyItnF6X1wkpaYxrpEUxT725iOkgONxEaIIAUFI?=
 =?us-ascii?Q?40pLT65SpCM841lm6IfYxlF+kXLzITOW?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jkL2MGuwTrQv66fQxefB1fxCFJ7E5n5piz+OobBaZdqgYIFqfvtzJKxZUXpG?=
 =?us-ascii?Q?78v+139yGOFWxlH8xYXzzky1KPkvbcLW+quuX96g9tZhGZ02KX9j95oJBh3V?=
 =?us-ascii?Q?dcfA0UB1iTUZXz5CCeSoTUEBaGtRXctySqQQQwVizbWZ7BAE4vSSubpJa5C0?=
 =?us-ascii?Q?/GhKFtFUl7WHgwLGsOV35KGg59oLwJDyQs65UWpR9TYMpTA9j1WK3yaDq84Q?=
 =?us-ascii?Q?PwDEvfL3wA2qkQ10BOSTKklYxQ5Z71jXFGZrWbBvqLN6+XqMWj2g7tCzfRH6?=
 =?us-ascii?Q?jRKQBlMrVsqUatxBUStkHcVkSddC+UxAoTF6UAYGdMGfEhjJHb4SlYa3ln/B?=
 =?us-ascii?Q?hSVqZ0F4HuZU756oYLo1M5uKcM3sUNhJskjz0JtgOBepC4yQ1yBidFAMe1Kh?=
 =?us-ascii?Q?UP6wMx+Y3kn27QKLabPllbEgdRVkn0J1uDi3bCKJ5/27nm8RpBJZ1Th4QybS?=
 =?us-ascii?Q?h1eWXYuAjT9vANJdVvleu75TmwXr8Ugpv7MaaNkIBKunR15R2asf7D7BImlE?=
 =?us-ascii?Q?2ehgbzdL8TBwKKEPSmwScpEdfzgIwO9DH6uWlWPDHbK47uip3uIORuyhDpXF?=
 =?us-ascii?Q?HIVHP7x4xOyRzr7CQ5oevbkAaqTzX96waS0sburWfAZc29trgefpWPxtEzF4?=
 =?us-ascii?Q?n+Y54iAEpa7J7uVX1G3qa97YLV3uZGMExJ7Mp6tTiNlE4ZkcsnanKrJthyWG?=
 =?us-ascii?Q?JLLDUy6gxTjVRwhquJZik5rQTPqkiSlwiwztITTwQK59YvkWm/X9bnw8MZ9V?=
 =?us-ascii?Q?QeuA0Fhh+cUK2TMceVU8z/ke3Vhp7qQnbk9S08SUOYfqvC1I7tr5DqOq3OZE?=
 =?us-ascii?Q?19pJWo2SiIHM3+UAe32JFhbysBGlN6GoRKGMjm2eutGwhhER0SXfzgr2T+EL?=
 =?us-ascii?Q?E+r3Dsw7blaCyR1mSPQEy3ozckYt8QdIGnw0MNTXK+KcRAil8tyKTfzBMgPi?=
 =?us-ascii?Q?qD4JWGSJYBuIAopQkz23OY7lWs+TE5b6hrm+9WpY7YkzVjdpvbsRzW+59BaK?=
 =?us-ascii?Q?PdJM8nY15NMoSFVzJcpfUDDiifzxzFJWE+4Kg9mnhwDy8qZcbs2U0nulc/B8?=
 =?us-ascii?Q?ROx8NfB6p7IOGzksWQUsSX7pkmYFwqIcNokvP8WlEgyPNi4jz54U2FTvCraV?=
 =?us-ascii?Q?8tnb2bdOlCKwG4Obh7TL3XQ44jvhnuJsANBAh/9J0Cf8ZJ5PXNMuI6/2FelW?=
 =?us-ascii?Q?8Jf1Bv/4EIIDvgkjx7mLKwDp5/s7l8P/EJngy61rKNNzt7IgjIOOns0BOxiN?=
 =?us-ascii?Q?RVITe/Acqdm9gIsySp1M2+BE3Shlc95mEAGayyultAF7QE4vHpfahx38MEWh?=
 =?us-ascii?Q?W2nWCwFjUM0ogWc+WyNotqNa8LKrRTO9n27j+qnlDKTilZKzy1PWt1Zavz8Z?=
 =?us-ascii?Q?anX/DIMQdn0/zcLiIrC/w4q79kKm55HtHydb7Qqr8sK6s0Hl5BXjd2c/qhMU?=
 =?us-ascii?Q?hwHwfbycX4s56QAVgPghGm3lA47jn6azm2EWBrCrREH3lh1MqCFqL/03XE3r?=
 =?us-ascii?Q?cLIFs8kquASmOm/914UxsA+xOwA0TVy7vyaBrm7Y/XqK+w4pHVL+orO6nT/A?=
 =?us-ascii?Q?2aCugQFg8QsjwAllVo4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d547a56-2c28-490f-e815-08dd65284523
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 07:49:38.9025 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SZU85hMx5HOjT8Uo8N5Pngd556Pz0C+IszCizibItACwbOW6dgIZKKgxA2uhTGz0BN5BI+axVWKBcOwp7WgIqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PPFE5D90BB53
X-Authority-Analysis: v=2.4 cv=YKqfyQGx c=1 sm=1 tr=0 ts=67d7d41b cx=c_pps
 a=2scX5b6JGDBY9+deG5t9BQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8
 a=Q9rKyhx_ljxQ-BR4-XIA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 9NuTgh7qCa0ZxWDTDkOReedHnZD0gqYm
X-Proofpoint-ORIG-GUID: 9NuTgh7qCa0ZxWDTDkOReedHnZD0gqYm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_02,2025-03-17_01,2024-11-22_01
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

> Subject: [PATCH] test/crypto: skip test when virtio PMD not loaded
>=20
> Skip asymmetric test when virtio PMD is not loaded.
>=20
> Fixes: 7e2e9d5f3227 ("test/crypto: add asymmetric cases for virtio")
> Fixes: a8f3d4f5b547 ("test/crypto: add cases for virtio-user")
>=20
> Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Applied to dpdk-next-crypto
Thanks

