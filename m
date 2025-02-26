Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBB3C021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 10:28:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 571EC4029F;
	Wed, 26 Feb 2025 11:28:36 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by mails.dpdk.org (Postfix) with ESMTP id 6B37F4027C
 for <dev@dpdk.org>; Wed, 26 Feb 2025 11:28:34 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LG1La/DEnyV1Idn74GzBSEG7pDM4r1EHGeE53yEYMD1RPLf77qd6NOs3fRS4zf6pfT4VyT/vjaZF4riKTy9yPXLnptBA74le+2jf3jLnaE91kV8mA9yK2bdDdUtVPx7eoZpoCe6F9YzBE0h67oeUg7aGjXbxAc9lamILdvF9oMhULd3ftotA3S9Cmh1uPPI5TRH2Hy3N8H93hrk0XOckxm96tSy8PAmiD4yTrFjXmXV7ofK6OG/WeComiNyoR6WQnSpcOynsESs5iFn7R3qM81qKUzTJkacInh07ELaQGNRnx3BG+iQ1ubXPQtUnHOQ0dV+A9cH2spr5qPbuNiV2mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yMuzEFmbAo3YwMDSjdR2a25EFiE5TwAMy8G/blGJi4=;
 b=xPZYBDjLfSlPyrhHo0J8tTqatRCqCGHOdnRHr4Ae42z75YquitROoAes9moSGDqTClA7HV67bOZfg1Vggg1+zAN+T4LUqBZg0XqKRxuTulV58QPf63XItTgrkrv1qyhzzEQq1KhtSzVqpW0pFuHYrA5+QSEYdrdXglV//Rxndx4De92vCpNA/ag1NzXmU4+CLAl0xfMPloOv0tXmDSKavZJbjOCtKUmfnCjN15aMqe1zhvAMobd8y+Z1ZLvTA8URTR583opgc/iuLsoNrxoF3ovQrsVrrKP703EV4oBbpJkIZH/7FK4oWsAil5FAie71lOuvNtZw5QmmqQte/l7xXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yMuzEFmbAo3YwMDSjdR2a25EFiE5TwAMy8G/blGJi4=;
 b=IkHipO5s9DRQeF5qlbKRvq7OtKR57PCNkTm1ztMUfohE5SZYz3VuWdx/1uS6OyL2A0HR1Sycg2Q+ItlbofcoDeDcnWSPI0mqPMTB+MnQPqmz9iCOlu5ustnfkHVJuXO+803FeDniQWdNHTPrSj0ij+NQRFzxU2YW2GfoKQIfmZ8I4c3Swi6EW3g8jhFzlFuabqPQBK8VGd4G0gsgDR0b3kbUO+Q7DJE7XiiTaIYo05xa73WQ1sHREtvn9JjQy0yqLj8uMsXVTZFmB+Zvj9uFrjMMJJvnYexruhD43z9yPPcBAtMZnVTlCRS+oOypTRJA3zQW3pIFobYXPWfDhDQSYw==
Received: from PH7PR12MB6905.namprd12.prod.outlook.com (2603:10b6:510:1b7::18)
 by SJ2PR12MB8691.namprd12.prod.outlook.com (2603:10b6:a03:541::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 10:28:31 +0000
Received: from PH7PR12MB6905.namprd12.prod.outlook.com
 ([fe80::33b4:19c2:2281:b662]) by PH7PR12MB6905.namprd12.prod.outlook.com
 ([fe80::33b4:19c2:2281:b662%7]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 10:28:31 +0000
From: Bing Zhao <bingz@nvidia.com>
To: Suanming Mou <suanmingm@nvidia.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Slava Ovsiienko <viacheslavo@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>, Alex
 Vesker <valex@nvidia.com>
Subject: RE: [PATCH 1/3] net/mlx5/hws: support jump FDB Rx
Thread-Topic: [PATCH 1/3] net/mlx5/hws: support jump FDB Rx
Thread-Index: AQHbhx6qN5acgYIMw02OmHLLmsGwZ7NZYudg
Date: Wed, 26 Feb 2025 10:28:31 +0000
Message-ID: <PH7PR12MB690511CADE485B9220DE5BBAD0C22@PH7PR12MB6905.namprd12.prod.outlook.com>
References: <20250225004527.2066812-1-suanmingm@nvidia.com>
 <20250225004527.2066812-2-suanmingm@nvidia.com>
In-Reply-To: <20250225004527.2066812-2-suanmingm@nvidia.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6905:EE_|SJ2PR12MB8691:EE_
x-ms-office365-filtering-correlation-id: 092b23bf-2381-4d37-8084-08dd56505111
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?VJnMhOjN9mf4yIJ+XH7VV9juYuRph9fkA5wQnnbKlEF3Pm9CSSVMW4a0UDX1?=
 =?us-ascii?Q?4EWgyHqv1mu9YLvPiFK9LDvSNm1rxhTFSAOxwtkLDTcY6iYTSStM+GlNnsVs?=
 =?us-ascii?Q?Ry1K8sfEJF+fYDxHrR0zd3PWDs4byp6CS+jZHDi06jmtYlU+l5imPEeyohrR?=
 =?us-ascii?Q?lDqi4kQYuenoNEdoDnOEWx2Hx6Rcviy3Rs/H6g2esc65MdX+EyIqdseHvKC3?=
 =?us-ascii?Q?tB1t84Vp8X/cBylXaPYZ0JDPfhYHN+a9NHbCZfusaRvluTQArNrORYCzPnDm?=
 =?us-ascii?Q?Np6jEiWtweUuc/Ux0KrmqldJNup1eCgj2qe5IimGdg+0cExv/ejRjTWk5xsc?=
 =?us-ascii?Q?yPsDztykAwm3IE+SUUJzgPtANZ0h6NiWImOMOUszIcQWB4AC8DFHvY+Azce/?=
 =?us-ascii?Q?BbhYz25gSzisXe8/BB262g6VJhe20ySGEDo/ZSukx0XW+xAXVJMgS8RK0Kcz?=
 =?us-ascii?Q?xbD3uPHkn0Uf6oE4c3x108v+aG59QEz+ue2vrIYH2BJb+4p5oaxpMI7oJ3Y5?=
 =?us-ascii?Q?iY9CTyFbI3PcSOCUeM1cYfeVN5IpVXh+isATg+3evX83a+SlgOstbUT+atsy?=
 =?us-ascii?Q?MPfYdGCYOMwVIUzHVyg3QtEzDn+tdDeAy4mh5hjxdPz3fOuoa6/CY4edE17x?=
 =?us-ascii?Q?ledd48uXtfHoXQKJpx8tOLPJQ7IgdsK+i6PUTj43vZYu9r5UpAchJOayRt/9?=
 =?us-ascii?Q?sMI/GUb/ZhA72MbOhU6tUJl+eLeJk2Z+nNq5+3NDg1uHSh0818hbM9eq+FMp?=
 =?us-ascii?Q?IPzpeJmx09LCqmG85DT3BMHNpz2pIZERiEabAJQ4XUsPZIm5iMlLylWUWBq9?=
 =?us-ascii?Q?zQNOvyHcQVuFfZNWKQU4p4ZFR6U2ZKxDLUFCY/CD1L0Qti1i7vwyOyIAUAVa?=
 =?us-ascii?Q?djyymtYkN8HHBMFLlVUSn4s7vmpcNPkkQ5Qbora99u8mkZleJh2zDQTrmKNo?=
 =?us-ascii?Q?7q8K2RMBgutRdUJ0cWvu54gaV2Zgn9sdcN71EnNOLZCAX6zwmyf+0MLOwAM8?=
 =?us-ascii?Q?1hxjxCPzeaGKp9JXqnjBZtv4pYpO2R1JEHmLiAg9+hhBoimyzn4uXTzkDAnV?=
 =?us-ascii?Q?7omqs2ylvoKZQfKLOs6OXKOOt1rW9jfA3wNREOyVxpTXe60LDJSOHiOIbyf/?=
 =?us-ascii?Q?iucPSRoapsucU2SbfZDQxb6DuVihbAVwArNp1AHLEcmH9VQ/VrIPLDPNfVSs?=
 =?us-ascii?Q?Kh8Uw3np6+VPawopGi96qQH9m2he5dxh1v/EQSqMK5dwhKZ0keDJmx9fofo+?=
 =?us-ascii?Q?phsfz9FKi4jWQveZcnSR7M31WXavVC+r3qAXqcQwykMkBgWJsqPtRFFu2jdl?=
 =?us-ascii?Q?C5jWnuPVaD2twYdCWf6IFu1hhQD3db8ugkKVU9CUj/1leRMNxnX2l1ToX9aE?=
 =?us-ascii?Q?kySGYG554ErpxEVRNg4MqberCj+NFj7dBqrG0n/hECZrliKKJe8+Jqxw0Kek?=
 =?us-ascii?Q?ByvwBmxhG55b3lXSpYaXh9SIyR3bvI2z?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6905.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PUqYm/IVoCDSexoHVtPOmfOhlBOXw0pBVHMQke5twqt+mvqkrndOpAWAegG6?=
 =?us-ascii?Q?RdAuMuc4ydGim5X8WyAewuT4AwjzAk+XBep2+FeDK/ikW1+q7ppnvRrZxS8A?=
 =?us-ascii?Q?2148pMqmLXmdnQn/YF9TH3aSPVMJSDuZfiHRv65f9SvXSuACGCv0qciq666g?=
 =?us-ascii?Q?tyxhoijVz0bZ/Ig7rG2YFwAOPwroMcTG8ndjRw6x4TD6Kigpz3FpCvM7xbea?=
 =?us-ascii?Q?cADswJ+yK4iAnf45s1lJamu7+2IBux80rcSM1tlFWuTPpNd78m5CPLPQwOr+?=
 =?us-ascii?Q?DatbV5hNqrC8ceObMMB3ZBWTvcK0KUAgNM2xbyFATo+TtTLwifL1vyw346Cy?=
 =?us-ascii?Q?CYN3DypGXhuzC5ZkXmgud0SCqKnATrDH9GZz1ePQX5rd3/j6D14d06kARHBF?=
 =?us-ascii?Q?0M/BjG02pPBJ0Qtz7TA4J6aud8y+jHHXCtXMFOfDaAs8MIZo2cyLvpuSfmTh?=
 =?us-ascii?Q?Wmb/V6y/b9xtnZjnSPunZtnjtUEsARrruc9BZWTXJ+WQ3dJUUuagBXo8FiSC?=
 =?us-ascii?Q?j6fp9FPp2x4Tm9mJEwgNZ1gz999bdUhUrUIOKO5I7zDe9iHp5s4yfZOcuyp3?=
 =?us-ascii?Q?kCgmHxe0SD6BKgUb4iwBAdcUMdVzBACkKkem/8QOy5AKFS1yRjpudEZPTG0d?=
 =?us-ascii?Q?TgJSd46ADF0XF93WyCOxbJ4AlUXXnzGf914caGlCYL1jEajccQmcQ9jK9jMR?=
 =?us-ascii?Q?gQ/O4ZJ76s+9d9N+Ne9JZ7QvW5IxV18ocv3I5mxI6igJ1HTvi2Y0si4jbuuk?=
 =?us-ascii?Q?Y9Rxo27otvCRe70og1VnTRVxHhgFXL5jG6hYJAOLd0eIy1gY3rgNbtL1QSE+?=
 =?us-ascii?Q?t4PwveH3wJKu8wONPKfqVdAjHIjFPADCVhjiBYBZTUr3/DCFZ1HjiJV9U89P?=
 =?us-ascii?Q?QPw9O5SNoZC/CogoEk5BkRQgNglTdiFOzcJB1/YXCoU49t4D4RvV3PvjbMQa?=
 =?us-ascii?Q?QP4Xg4rDEf4KbBb/Y5pjxdC7aUEs6NxofScDdif4V5deRrh+AEhSnX4tgWYo?=
 =?us-ascii?Q?HtAzeFI5N9W8gXgaLwStob8cyD6Ob2CVB3KANCJJoX1e+mxJqRamqzgb+6fc?=
 =?us-ascii?Q?GrTHX/rUh6qFLBSQ0xcDRtuXOGKXgzqeF5qul6Ihjs2RcxdMeKgN2gFyWbA/?=
 =?us-ascii?Q?RjMcWZDaKIg/lasFSdsfkTuwfYBuqFAfDX9OzqOUflby/FRhZDT4FrT2//Yu?=
 =?us-ascii?Q?LJgT3llgHwcoiQw6pcyNS0QF/tWW5BwA5F6grTHI22FJcIroouy2RvmN2FEY?=
 =?us-ascii?Q?Pj7ktcttMyIo0pS6RvLDr/7O08xT8xZdegJ+24L5wZ319mJhw5Z9ayXV8Xyz?=
 =?us-ascii?Q?kDGb62aSKgRlX8IJ6awIvxbM6gCOeN9nFdyam6HJ9s3HhLIN3cNQiw+Lx4Jz?=
 =?us-ascii?Q?y8pB9el1ULUmVc1aNp2B0h39i8wg8EnJqoDAIVICQayXi8u0m/iJ7r5imv+n?=
 =?us-ascii?Q?RMlfZU6DTZenam1ytLDPQKj6OfkrP4CqlpPd988t7bHZGUExsCeMIyDzZ4Wq?=
 =?us-ascii?Q?1iWkqSb41hSWnJNR8oNox6rmr5FbggwSZPTXotsWKBK1fHqP1iz59LMiWE6J?=
 =?us-ascii?Q?qrG7GBeUdgWKdXdckAs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6905.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 092b23bf-2381-4d37-8084-08dd56505111
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 10:28:31.3776 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 61V7lnPJqHDNKL0kxh7Bz6XgW2VPQRzpSNaSMoQSkGBrqb3nhcTJwJTqFow6ok75aBv88xh25FJ/Dp5Jn0TBIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8691
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

Hi Suanming,

PSB

> -----Original Message-----
> From: Suanming Mou <suanmingm@nvidia.com>
> Sent: Tuesday, February 25, 2025 8:45 AM
> To: Dariusz Sosnowski <dsosnowski@nvidia.com>; Slava Ovsiienko
> <viacheslavo@nvidia.com>; Bing Zhao <bingz@nvidia.com>; Ori Kam
> <orika@nvidia.com>; Matan Azrad <matan@nvidia.com>
> Cc: dev@dpdk.org; Raslan Darawsheh <rasland@nvidia.com>; Alex Vesker
> <valex@nvidia.com>
> Subject: [PATCH 1/3] net/mlx5/hws: support jump FDB Rx
>=20
> Before FW introduced the JUMP_FDB_RX action feature, jump from FDB Tx to
> Rx is not allowed. JUMP_FDB_RX feature introduces the internal loopback
> for Tx case and allow the REG C0 C1 B be preserved as well.
>=20
> This commit adds the JUMP_FDB_RX cap bit check and use JUMP_FDB_RX instea=
d
> of FT for dest table FDB Rx case.
>=20
> Signed-off-by: Suanming Mou <suanmingm@nvidia.com>
> Signed-off-by: Alex Vesker <valex@nvidia.com>
> ---
>  drivers/common/mlx5/mlx5_prm.h        |  9 ++++++++-
>  drivers/net/mlx5/hws/mlx5dr_action.c  | 26 +++++++++++++++++++++-----
> drivers/net/mlx5/hws/mlx5dr_action.h  |  4 ++++
>  drivers/net/mlx5/hws/mlx5dr_cmd.c     |  9 +++++++++
>  drivers/net/mlx5/hws/mlx5dr_cmd.h     |  2 ++
>  drivers/net/mlx5/hws/mlx5dr_context.c | 17 +++++++++++++++++
> drivers/net/mlx5/hws/mlx5dr_context.h |  2 ++
>  7 files changed, 63 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/common/mlx5/mlx5_prm.h
> b/drivers/common/mlx5/mlx5_prm.h index 3fc3b0cd2a..84e3347794 100644
> --- a/drivers/common/mlx5/mlx5_prm.h
> +++ b/drivers/common/mlx5/mlx5_prm.h
> @@ -2466,7 +2466,8 @@ struct mlx5_ifc_wqe_based_flow_table_cap_bits {
>  	u8 reserved_at_60[0x8];
>  	u8 max_header_modify_pattern_length[0x8];
>  	u8 ste_format[0x10];
> -	u8 stc_action_type[0x80];
> +	u8 stc_action_type_63_0[0x40];
> +	u8 stc_action_type_127_64[0x40];
>  	u8 header_insert_type[0x10];
>  	u8 header_remove_type[0x10];
>  	u8 trivial_match_definer[0x20];
> @@ -3543,6 +3544,11 @@ enum mlx5_ifc_rtc_reparse_mode {
>  	MLX5_IFC_RTC_REPARSE_BY_STC =3D 0x2,
>  };
>=20
> +enum mlx5_ifc_stc_action_type_bit_index {
> +	MLX5_IFC_STC_ACTION_TYPE_BIT_64_INDEX =3D 64,
> +	MLX5_IFC_STC_ACTION_TYPE_JUMP_FLOW_TABLE_FDB_RX_BIT_INDEX =3D 71, };
> +
>  #define MLX5_IFC_RTC_LINEAR_LOOKUP_TBL_LOG_MAX 16
>=20
>  struct mlx5_ifc_rtc_bits {
> @@ -3621,6 +3627,7 @@ enum mlx5_ifc_stc_action_type {
>  	MLX5_IFC_STC_ACTION_TYPE_ALLOW =3D 0x84,
>  	MLX5_IFC_STC_ACTION_TYPE_JUMP_TO_VPORT =3D 0x85,
>  	MLX5_IFC_STC_ACTION_TYPE_JUMP_TO_UPLINK =3D 0x86,
> +	MLX5_IFC_STC_ACTION_TYPE_JUMP_TO_FLOW_TABLE_FDB_RX =3D 0x87,
>  };
>=20
>  enum mlx5_ifc_stc_reparse_mode {
> diff --git a/drivers/net/mlx5/hws/mlx5dr_action.c
> b/drivers/net/mlx5/hws/mlx5dr_action.c
> index b9452a3ebc..e21db5b327 100644
> --- a/drivers/net/mlx5/hws/mlx5dr_action.c
> +++ b/drivers/net/mlx5/hws/mlx5dr_action.c
> @@ -803,6 +803,9 @@ int mlx5dr_action_root_build_attr(struct
> mlx5dr_rule_action rule_actions[],
>=20
>  		switch (action->type) {
>  		case MLX5DR_ACTION_TYP_TBL:
> +			attr[i].type =3D MLX5DV_FLOW_ACTION_DEST_DEVX;
> +			attr[i].obj =3D action->dest_tbl.devx_obj->obj;
> +			break;
>  		case MLX5DR_ACTION_TYP_TIR:
>  			attr[i].type =3D MLX5DV_FLOW_ACTION_DEST_DEVX;
>  			attr[i].obj =3D action->devx_obj;
> @@ -1097,6 +1100,17 @@ static void mlx5dr_action_fill_stc_attr(struct
> mlx5dr_action *action,
>  		}
>  		break;
>  	case MLX5DR_ACTION_TYP_TBL:
> +		attr->action_offset =3D MLX5DR_ACTION_OFFSET_HIT;
> +		attr->dest_table_id =3D obj->id;
> +		/* Only for unified FDB Rx case */
> +		if (mlx5dr_context_cap_stc(action->ctx,
> +		    MLX5_IFC_STC_ACTION_TYPE_JUMP_FLOW_TABLE_FDB_RX_BIT_INDEX)
> &&
> +		    action->dest_tbl.type =3D=3D MLX5DR_TABLE_TYPE_FDB_RX)
> +			attr->action_type =3D
> MLX5_IFC_STC_ACTION_TYPE_JUMP_TO_FLOW_TABLE_FDB_RX;
> +		else
> +			attr->action_type =3D MLX5_IFC_STC_ACTION_TYPE_JUMP_TO_FT;

Fix the long line warnings, same as other places.
Also mlx5dr_context_cap_stc() seems to contain some calculation inside. If =
the context and the CAP will not be changed during the runtime on a specifi=
c port. Can this CAP BIT checking be done only once and saved for later usa=
ge? Since the code is used in the flow insertion.WDYT?

> +
> +		break;
>  	case MLX5DR_ACTION_TYP_DEST_ARRAY:
>  		attr->action_type =3D MLX5_IFC_STC_ACTION_TYPE_JUMP_TO_FT;
>  		attr->action_offset =3D MLX5DR_ACTION_OFFSET_HIT; @@ -1419,17
> +1433,19 @@ mlx5dr_action_create_dest_table(struct mlx5dr_context *ctx,
>  	if (!action)
>  		return NULL;
>=20
> +	action->dest_tbl.type =3D tbl->type;
> +
>  	if (mlx5dr_action_is_root_flags(flags)) {
>  		if (mlx5dr_context_shared_gvmi_used(ctx))
> -			action->devx_obj =3D tbl->local_ft->obj;
> +			action->dest_tbl.devx_obj =3D tbl->local_ft;
>  		else
> -			action->devx_obj =3D tbl->ft->obj;
> +			action->dest_tbl.devx_obj =3D tbl->ft;
>  	} else {
> +		action->dest_tbl.devx_obj =3D tbl->ft;
> +
>  		ret =3D mlx5dr_action_create_stcs(action, tbl->ft);
>  		if (ret)
>  			goto free_action;
> -
> -		action->devx_dest.devx_obj =3D tbl->ft;
>  	}
>=20
>  	return action;
> @@ -2526,7 +2542,7 @@ mlx5dr_action_create_dest_array(struct
> mlx5dr_context *ctx,
>  			case MLX5DR_ACTION_TYP_TBL:
>  				dest_list[i].destination_type =3D
>  					MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
> -				dest_list[i].destination_id =3D dests[i].dest-
> >devx_dest.devx_obj->id;
> +				dest_list[i].destination_id =3D dests[i].dest-
> >dest_tbl.devx_obj->id;
>  				fte_attr.action_flags |=3D
> MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
>  				fte_attr.ignore_flow_level =3D 1;
>  				break;
> diff --git a/drivers/net/mlx5/hws/mlx5dr_action.h
> b/drivers/net/mlx5/hws/mlx5dr_action.h
> index b779e578fd..a582e2abbe 100644
> --- a/drivers/net/mlx5/hws/mlx5dr_action.h
> +++ b/drivers/net/mlx5/hws/mlx5dr_action.h
> @@ -226,6 +226,10 @@ struct mlx5dr_action {
>  				struct {
>  					struct mlx5dr_matcher *matcher;
>  				} jump_to_matcher;
> +				struct {
> +					struct mlx5dr_devx_obj *devx_obj;
> +					enum mlx5dr_table_type type;
> +				} dest_tbl;
>  			};
>  		};
>=20
> diff --git a/drivers/net/mlx5/hws/mlx5dr_cmd.c
> b/drivers/net/mlx5/hws/mlx5dr_cmd.c
> index f609135ccb..5d1138099d 100644
> --- a/drivers/net/mlx5/hws/mlx5dr_cmd.c
> +++ b/drivers/net/mlx5/hws/mlx5dr_cmd.c
> @@ -466,6 +466,7 @@ mlx5dr_cmd_stc_modify_set_stc_param(struct
> mlx5dr_cmd_stc_modify_attr *stc_attr,
>  		MLX5_SET(stc_ste_param_tir, stc_param, tirn, stc_attr-
> >dest_tir_num);
>  		break;
>  	case MLX5_IFC_STC_ACTION_TYPE_JUMP_TO_FT:
> +	case MLX5_IFC_STC_ACTION_TYPE_JUMP_TO_FLOW_TABLE_FDB_RX:
>  		MLX5_SET(stc_ste_param_table, stc_param, table_id, stc_attr-
> >dest_table_id);
>  		break;
>  	case MLX5_IFC_STC_ACTION_TYPE_ACC_MODIFY_LIST:
> @@ -1280,6 +1281,14 @@ int mlx5dr_cmd_query_caps(struct ibv_context *ctx,
>  		caps->fdb_unified_en =3D MLX5_GET(query_hca_cap_out, out,
>  						capability.wqe_based_flow_table_cap.
>  						fdb_unified_en);
> +
> +		caps->stc_action_type_63_0 =3D MLX5_GET64(query_hca_cap_out,
> +							out,
> +
> 	capability.wqe_based_flow_table_cap.stc_action_type_63_0);
> +
> +		caps->stc_action_type_127_64 =3D MLX5_GET64(query_hca_cap_out,
> +							  out,
> +
> capability.wqe_based_flow_table_cap.stc_action_type_127_64);
>  	}
>=20
>  	if (caps->eswitch_manager) {
> diff --git a/drivers/net/mlx5/hws/mlx5dr_cmd.h
> b/drivers/net/mlx5/hws/mlx5dr_cmd.h
> index 3c615b8925..eb9643c555 100644
> --- a/drivers/net/mlx5/hws/mlx5dr_cmd.h
> +++ b/drivers/net/mlx5/hws/mlx5dr_cmd.h
> @@ -250,6 +250,8 @@ struct mlx5dr_cmd_query_caps {
>  	bool roce;
>  	uint16_t roce_max_src_udp_port;
>  	uint16_t roce_min_src_udp_port;
> +	uint64_t stc_action_type_63_0;
> +	uint64_t stc_action_type_127_64;
>  	bool fdb_unified_en;
>  };
>=20
> diff --git a/drivers/net/mlx5/hws/mlx5dr_context.c
> b/drivers/net/mlx5/hws/mlx5dr_context.c
> index 91d05f1f86..a854b83ad8 100644
> --- a/drivers/net/mlx5/hws/mlx5dr_context.c
> +++ b/drivers/net/mlx5/hws/mlx5dr_context.c
> @@ -140,6 +140,23 @@ static int mlx5dr_context_uninit_pd(struct
> mlx5dr_context *ctx)
>  	return 0;
>  }
>=20
> +bool mlx5dr_context_cap_stc(struct mlx5dr_context *ctx, uint32_t bit) {
> +	uint32_t test_bit =3D bit;
> +
> +	if (bit >=3D MLX5_IFC_STC_ACTION_TYPE_BIT_64_INDEX)
> +		test_bit -=3D MLX5_IFC_STC_ACTION_TYPE_BIT_64_INDEX;
> +
> +	switch (bit) {
> +	case MLX5_IFC_STC_ACTION_TYPE_JUMP_FLOW_TABLE_FDB_RX_BIT_INDEX:
> +		return ctx->caps->stc_action_type_127_64 & (0x1ull <<
> test_bit);
> +	default:
> +		break;
> +	}
> +
> +	return false;
> +}
> +
>  static void mlx5dr_context_check_hws_supp(struct mlx5dr_context *ctx)  {
>  	struct mlx5dr_cmd_query_caps *caps =3D ctx->caps; diff --git
> a/drivers/net/mlx5/hws/mlx5dr_context.h
> b/drivers/net/mlx5/hws/mlx5dr_context.h
> index e89a093c77..deb7196e39 100644
> --- a/drivers/net/mlx5/hws/mlx5dr_context.h
> +++ b/drivers/net/mlx5/hws/mlx5dr_context.h
> @@ -75,4 +75,6 @@ uint8_t mlx5dr_context_get_reparse_mode(struct
> mlx5dr_context *ctx);  void mlx5dr_context_set_pool_tbl_attr(struct
> mlx5dr_pool_attr *attr,
>  				      enum mlx5dr_table_type table_type);
>=20
> +bool mlx5dr_context_cap_stc(struct mlx5dr_context *ctx, uint32_t bit);
> +
>  #endif /* MLX5DR_CONTEXT_H_ */
> --
> 2.34.1

