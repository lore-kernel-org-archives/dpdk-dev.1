Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403D8C282EC
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 13:09:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C39B4027F;
	Tue, 11 Mar 2025 14:09:04 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 4115640263
 for <dev@dpdk.org>; Tue, 11 Mar 2025 14:09:02 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52B4wCMb017228
 for <dev@dpdk.org>; Tue, 11 Mar 2025 06:09:01 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 45aem78wd2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 11 Mar 2025 06:09:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UpwvTzoISeaeCGjx2jb3NJzEq/nFLKjn/6qa2CxNA4Ul/2PnCqiO7f5sk2DHq+zuSzRL8dHq3Cnh6rTKfDbM6gC6B3qttCGrjixG994BJG5txTa/LaQWu7JCHs5NmfU32WGJAyGixLnIjOhHbH6sZi4dGbGLqOc1/WeXicbN5zBeQ5CxBBHdhD0UV/EVzigzdc+xvxu4IqXypCe4l47Og4zK6Xk4t4JbYXl9uIVIBSXo5p5q9p2jhLTrtbO+v+eD02Z4nQn0eaEM2G3LDXxw2Ual3Ic+Vq1eWfHinyoZP7+5tOIW6/Q/PJJ17yFOXRi6dmh10hrCA9/lpOx9OfHbOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y77oGuK6OhPGayFCIQh4s0cha5rs2wizWzePHlUFQhU=;
 b=lwgtAMKWdVnYrtTMDMS6I4fdPLOhpAjxMUahUNMy7+EVxA8iGRs2oKlu4qfhNwmun1x8g+ygLXUe/CZpgUCB+Vb0DT/b9IW2vWbs9DYKMZo+oEoybRaPX1dCFDnmNVS3QLsIAvaVs4bXq8Q2+63/B6s7tbCkbAs09XzSIGsQsbl4ga/aqOTyDX/EY2Nc8JgnfFuJzvFYd+y84qFnQmtNYHH9pzOqgje+OzKSOXnsiCGydKwjVffRid7ZASjuqv4HCeITNDRjN862jeS6YliXNhy2oyu9+dTGYuCT15fjy2Zjuocb5CmGHar28OTrgBQ55kxfePYo9BUsHZxGEYPU3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y77oGuK6OhPGayFCIQh4s0cha5rs2wizWzePHlUFQhU=;
 b=IJVepBJIpLrO69M93V+yn94lb8RLFylbswA/ZeA/FSpr/BpUY+8v876r+MHn8/LkolyohrkOgifpwNoKR/MJDQ1kXm3nJs69P6DLTiMUezesx3dOxlE2Wk8CUXicCsT/MJWeyriVnyGZ7e3yG0V3Hd/Fm3g1daFsXQ467AGAz6g=
Received: from BY3PR18MB4785.namprd18.prod.outlook.com (2603:10b6:a03:3cc::18)
 by DS1PR18MB6242.namprd18.prod.outlook.com (2603:10b6:8:1e2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 13:08:58 +0000
Received: from BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576]) by BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576%3]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 13:08:58 +0000
From: Jerin Jacob <jerinj@marvell.com>
To: Nawal Kishor <nkishor@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>, Nithin
 Kumar Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar Kokkilagadda
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha
 Koteswara Rao Kottidi <skoteshwar@marvell.com>, Harman Kalra
 <hkalra@marvell.com>, Ashwin Sekhar T K <asekhar@marvell.com>
CC: Nawal Kishor <nkishor@marvell.com>
Subject: RE: [PATCH] common/cnxk: fix aura offset
Thread-Topic: [PATCH] common/cnxk: fix aura offset
Thread-Index: AQHbjMV9ChTuQs0ovE6e2cRFu8uzwrNt88Qg
Date: Tue, 11 Mar 2025 13:08:58 +0000
Message-ID: <BY3PR18MB47852AF2E8B1F959F5640AA0C8D12@BY3PR18MB4785.namprd18.prod.outlook.com>
References: <20250304052217.796506-1-nkishor@marvell.com>
In-Reply-To: <20250304052217.796506-1-nkishor@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4785:EE_|DS1PR18MB6242:EE_
x-ms-office365-filtering-correlation-id: 2d58a764-c933-494a-e943-08dd609de2a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?eJYs4lChXwKgsO1sk8aZk62SKS6/Y9XFfm6YtzPaqFPn4Bw5Oixo2g8Sn2cP?=
 =?us-ascii?Q?wJ0wHkRRWvVQ6nS+ZI6VX32OI0eFTCVhzQGLnUQX5TZzDixHXncK/gh7UERK?=
 =?us-ascii?Q?RZISPSe9mcOGhiX+bRVCpUcEZQkRlZHuX4fPwffpnsK8+L75l5sUkMdohry1?=
 =?us-ascii?Q?mrN3ZFkW1gjKO7tfR7zV+X5/jilMOFPzI0rPz1m40BYoKEHsDAOFp8ybEAgz?=
 =?us-ascii?Q?zc5C11oYQYpfn+ZfrIbowpegqftvtIDebPGpNQvu5Tj7cR70N5PPuLIzi3Z/?=
 =?us-ascii?Q?TPi2pNTKZif6tFbw/9y2hNUn+4U9i/lQM0wkS5ya8J9vPVJWWbmFaHpxhGDM?=
 =?us-ascii?Q?bWW7MPK8xKuF2JI/W254fF0tUa9xm4dZwEBxrMPYbXlKbteBTuPPNKOQUDJN?=
 =?us-ascii?Q?E4dAPb2gbRwpe/uSHVWGrcFD2S6xgLprOFnZcBSA6YCle9ZBY9qnoJGwjVSc?=
 =?us-ascii?Q?Hdk0TDQnBU2zibk5/kXe9SoH0a2HyV87wIznq3/I3hQzZ4y8T1xbwrwAOkmk?=
 =?us-ascii?Q?1bbitUiEqu8o5hejYalCqHicLe5P51r/1Rp7eqmaFv56p62+DpbI4JQrU1Gz?=
 =?us-ascii?Q?BDfPsPm9FN+1q9YV5k6T29bLDAXz1s527HU4etBiOoi9KfUMIVSDLl+jswHo?=
 =?us-ascii?Q?HHSorDmh/sVERc8Etpcz9Pr1HePZn9fqij/KIiV+lgn7zoRI4UpCRSWizeti?=
 =?us-ascii?Q?FbLhdjqlaXqO2tc2AQQGiHVV4P/QtMmzKuut3OWEElOmszFGJlss3BP+p/UF?=
 =?us-ascii?Q?NH0OvGvUZfMzrTouLiyAmdi2uwpbTi30xIjO3lo7J5GjG9euRDS4hgX8GFPs?=
 =?us-ascii?Q?5xkhNSQMI9ne5pQ3cdMGQahEzcc81yR4g0YN/jndC2rZp1QPphedqvo3TudW?=
 =?us-ascii?Q?vkXYL++lgFEBln1zUV3vVfDLwaWI/uGg7oad76xcv81af9rp2Y35XZHYdJeu?=
 =?us-ascii?Q?amuI5Pdr1GKMRDBOhs/MTRvf+JRIDaitFbhfS1ehO7/0MwsCVPt1U7lMu6mK?=
 =?us-ascii?Q?5EHXuAY0Sm3v5+rHJS8z+IiL1BrAm82KW1jio2LfPlkVkWKjock8r+0ItjJm?=
 =?us-ascii?Q?xjFjzNuSgO3DJxqDu9URgejd/jLnZ/e8HuS5w6LGKCm8N/EnF2Oj7LuFC8iy?=
 =?us-ascii?Q?+bjJ5n2p0tfnx6k2ZlJdBVU85xwRTSrZjx0D2CxHCM6YLmleFcaaFkuwa9LO?=
 =?us-ascii?Q?upG3WR222I2xSNJyha1RASmdk6fFojLNivgADSvcwiTfQlNq6+ALf2iP7fY6?=
 =?us-ascii?Q?A4gnb+SMLwIDb9yjF1uuqao8dA06Gm1FzDPPj8iC8QttgUdVZbmksQVlTXBp?=
 =?us-ascii?Q?sEXPgFZYzPpOBT8rbEVFR9Wmx5qgNMQfn/n9Z7J8xSH3toi32v4M2uUnprSq?=
 =?us-ascii?Q?/rvmZElrbBI2m7+e3pYflcwkB030qGs4L8tqWnmuBTly7e1/fFDTM1YEFcDN?=
 =?us-ascii?Q?BSg7A/z7JF8JNPqmSdIwOXvuwPpIAb/K?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4785.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H+fWTKTFrqbVbDsaFjUSOHjnF2mtReprxLAPDwVq56zPgA9kjIEzVjpmFLZK?=
 =?us-ascii?Q?7Z+qyzZQm7luMiqUuqGU0JSKjEgWzO9QRsM6+Pi5d70OqB+jMicRG5Gh+SWM?=
 =?us-ascii?Q?clAY7YYcPdqrbt3oz4yKgjwz3RT0dxblqUJU3c/hh+ofxURAbjoo7h9HRRFf?=
 =?us-ascii?Q?QzS9sas/8uOYH2XR4DlSdxzkIIznkCuWm70gghISAiV3oSuBpL6UVLT3hKIo?=
 =?us-ascii?Q?10LGcO67ofegjyUdBCtDNT2PYbkABse2F/bCLwBOgCjpkRAoCreLAjC30Fcm?=
 =?us-ascii?Q?6pMrv4Pn8jrd7Ic2EVTjasfeMSDCqXq0zw9D8F4RsmocI3vej576XAqSJVMQ?=
 =?us-ascii?Q?Wqyex/GwAOeHmrP29OYjF0I+cp7swH0/c6lG+ryCWgCTyIJE3bae43I+A5sY?=
 =?us-ascii?Q?VDgwDFajuZu+VJ0BOanuODW+Jo1YPtFz1G8cPFhYlPwUwFg3RBYocoIo8E50?=
 =?us-ascii?Q?PwB6tVGKOho/WEMk+7JT1c/BiQAwm8fOkNX4ZIL0it5SqChV63KtLY0DCry4?=
 =?us-ascii?Q?VZcHqa2KBmnTmx4w3mcek49Md+zK6ALuE8kSMk/0smcCJmeiEdGcbLFKYO9u?=
 =?us-ascii?Q?Aig/s4d8V2K5eSOa8HIf8sK4fy9T4t5FgT4ZyRNnqEEyYd4PaDrvMNvDqsJo?=
 =?us-ascii?Q?gT3oPRDNp9dbXsGxRIfr6wkQrckSZnVxzM9xulUCFHaZtFCzDRduB/8G5Nwo?=
 =?us-ascii?Q?IDbr1Cw1nd7pc2yn0o7z0vCqCckIR30DNx+W6UfzS9AOizKhASUzuon9CUfb?=
 =?us-ascii?Q?s7FFpRC++1tmHwdRVqp2JJSd359rV712Hj+Pr5Z7nCKbhHmI4K0RPwSHx90R?=
 =?us-ascii?Q?+pp17yH73M9hHm532nnqx89VT3Mdj4Xbt2Blha47TiNTP5u1iZ7JBKoqRs86?=
 =?us-ascii?Q?hBX58PoSj8AFM0OP6dTtLu+FJrE8P7b26TuKOt5TnpGuu/WkO9CxL1dT0Wvo?=
 =?us-ascii?Q?BDBkAhqx73PfTgvVYvicHbImY6Cwft8R+oUPkCgOUBX+aTpwIUWuXbZtZoV+?=
 =?us-ascii?Q?UyJcxYNgAYBPQEcXfxWVH7uc+pUy0+OpzunowYiI8IuMdsWJtmopL7xemQMg?=
 =?us-ascii?Q?LS5I7B8DS9wuc7CB2aMfEgCJzCJcORQNZf3MG2hoM/JpwKlU2KgVmnmATo3X?=
 =?us-ascii?Q?3DTIKkoHIoSlheFdkL6981W4RVJ9p8JGbC7qZ6nRmIVoOY5fGVTWRIEG+BrM?=
 =?us-ascii?Q?DVAUFUcSbzFvhjr397HcaFIpWv1XLVk5eJ+a0MYIFoLexRjJ1c12JplkZZGh?=
 =?us-ascii?Q?wMI/MI1OjDeTVBV2Sb5CN3h7+ErPgCNCiKe2pKj0arNtiYKNYlcDS4iMKJfe?=
 =?us-ascii?Q?4QCjaT23gsnsvpdOEnwV2leWQvbotDykyTKBGLAXpnVzYJ9lahT5tYCQ7yXq?=
 =?us-ascii?Q?CXGeovtyO/POEs5cA96Cao5e0UVA2AmUQtO/VtkVtOBEqKkD3BEy5Zrn42zG?=
 =?us-ascii?Q?UMDjB3kR8o8zJX/PqtLDf5xuG3L1g2KOomWmXZi2pDSTl9FK71zwXSsr1kf/?=
 =?us-ascii?Q?ZhlqgR2HRXtzkqeJlUxuCllgX0XJ2QFTaled0pn1igVCdHVD3Jv61dAUnPa9?=
 =?us-ascii?Q?IFkLazYgAYAdG8+YzDKTn4R6ZCLscZ1am2GqVv7e?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4785.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d58a764-c933-494a-e943-08dd609de2a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 13:08:58.4707 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U7W71ZkYTOe2OSwqkPnKdxPr2ok6TB2iFksrh0OfEsxoqbu6zG3KUYDPWiZG9Qtu8jDh3qrGOIuQD5MSqLp3uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR18MB6242
X-Proofpoint-GUID: lwyzmiXmuicPnftrx1Fly2A1pXkVrmJJ
X-Proofpoint-ORIG-GUID: lwyzmiXmuicPnftrx1Fly2A1pXkVrmJJ
X-Authority-Analysis: v=2.4 cv=A+WWP7WG c=1 sm=1 tr=0 ts=67d035ed cx=c_pps
 a=LxkDbUgDkQmSfly3BTNqMw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Vs1iUdzkB0EA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=znEo7icW1Lg0q2lSmLAA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_02,2025-03-11_02,2024-11-22_01
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
> Sent: Tuesday, March 4, 2025 10:52 AM
> To: dev@dpdk.org; Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>;
> Kiran Kumar Kokkilagadda <kirankumark@marvell.com>; Sunil Kumar Kori
> <skori@marvell.com>; Satha Koteswara Rao Kottidi
> <skoteshwar@marvell.com>; Harman Kalra <hkalra@marvell.com>; Ashwin
> Sekhar T K <asekhar@marvell.com>
> Cc: Jerin Jacob <jerinj@marvell.com>; Nawal Kishor <nkishor@marvell.com>
> Subject: [PATCH] common/cnxk: fix aura offset
>=20
> Fix aura offset in NPA_LF_POOL_OP_INT.

Please add more description.

>=20
> Fixes: 620fc02bf7eb ("common/cnxk: accommodate change in aura field
> width")

Fix the following

Is it candidate for Cc: stable@dpdk.org backport?
        common/cnxk: fix aura offset

Invalid patch(es) found - checked 1 patch
check-git-log failed

### [PATCH] common/cnxk: fix aura offset

Warning in drivers/common/cnxk/roc_npa_irq.c:
Using %l format, prefer %PRI*64 if type is [u]int64_t


>=20
> Signed-off-by: Nawal Kishor <nkishor@marvell.com>
> ---
>  drivers/common/cnxk/roc_npa_irq.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/common/cnxk/roc_npa_irq.c
> b/drivers/common/cnxk/roc_npa_irq.c
> index 0a19319ebf..9505194207 100644
> --- a/drivers/common/cnxk/roc_npa_irq.c
> +++ b/drivers/common/cnxk/roc_npa_irq.c
> @@ -104,14 +104,15 @@ static inline uint8_t  npa_q_irq_get_and_clear(stru=
ct
> npa_lf *lf, uint32_t q, uint32_t off,
>  			uint64_t mask)
>  {
> -	uint64_t reg, wdata;
> +	uint64_t reg, wdata, shift;
>  	uint8_t qint;
>=20
> -	wdata =3D (uint64_t)q << 44;
> +	shift =3D roc_model_is_cn20k() ? 47 : 44;
> +	wdata =3D (uint64_t)q << shift;
>  	reg =3D roc_atomic64_add_nosync(wdata, (int64_t *)(lf->base + off));
>=20
>  	if (reg & BIT_ULL(42) /* OP_ERR */) {
> -		plt_err("Failed execute irq get off=3D0x%x", off);
> +		plt_err("Failed execute irq get off=3D0x%x reg=3D0x%lx", off, reg);
>  		return 0;
>  	}
>=20
> --
> 2.34.1

