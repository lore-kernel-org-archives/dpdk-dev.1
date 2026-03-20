Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DDD108B90B
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Mar 2026 12:02:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D0EDF402B2;
	Fri, 20 Mar 2026 13:02:03 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010001.outbound.protection.outlook.com [52.101.85.1])
 by mails.dpdk.org (Postfix) with ESMTP id 75C5A400EF
 for <dev@dpdk.org>; Fri, 20 Mar 2026 13:02:02 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s9obBHdtPPPiDuQaOy4Yjw3Pga/4OCp0YIxFoC1PgMzmxgrvoO2UebYv4b7jljgdjjoRbnQ2r6l2IhFK6e/hz+WreSHsPaSpBJ5QnsDQAuWMRJw8ngd7UppdZnTPzcfrD01F2LnROJOl2AQVT8ZUykBNqqZw6/XAKZDeyXg352Sb22zjhCGi23ZY5C6EyBOGhHQaqXzpdWnsyu/bv0LUCMMmZpTkbBZrJAz4bLgVbuQLLrqtYfF8jm5U3aC96eRK7pcte3+xZywzAI0uAjLh/o6ZdWQnPItrj6txQJ5A7KCwaJlfaHlHAN7tkcL7irkUf0515qotiXyD3xsEtkaapw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Zp/J4poS7g+bZ059FFHhKafma6YyJYsCr7e3Bwd0dk=;
 b=XRPbG+v8+kKlJ0dbNXyQhcLlfX5anjMJuV9DjEYRoFejaNjrtzGDRODMnimFcZEPt/XR8BTnF1X4t1/CGP1S0zxXvxuuF8Jx8HIxDcnEpDbwP/hFrnVld9h0MyYYm2edbz7IMXsDLBcPaJSMceXIaNABP43KvDgXFCRMg5xUi9vX2netDMgc8YMPfLnEDeCKN3cPNMi+TUwDaDRxGkKRsHww8ljTewcLEoh//swfg98JViMtG1wZVK4U/905hWlqudG4xa0AVHwuALzjq1jxxcHWcfdSsTd6PiMnXhoATUIDkfY/804pPGdg9a+OkENs5bXmBa7ECc9iLgFr1kWqNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Zp/J4poS7g+bZ059FFHhKafma6YyJYsCr7e3Bwd0dk=;
 b=HckFZnnmuvS48IHKMWBzSY6/CMhh7MWRnkQkNxGUr3m8e9c0E61ZCvCKiDtBFAogBAnNSDobOt9C2ZT9AFt57YeHi8cYpQlzhTfdnbw8PUqX3VMbn4NPtVWg1Mo+rohRN85QnQItAYIWAMvD29XdTdO7k+Enp2WpAX2vxgPem5vJwHyL4odk87u5lAVrp/NcSYPlYH6z4fkPy39tzn0g6WjKSHVMYaLCJLO8VVyNF+YpG7MtrJjH1L9og+gla4GHld4InUqMAErOhh3xAwtkwPVoI3trqS9OzWmUyarpRvGLWeunvRHP/CSzK9bMVzdCHUrS6k10uAx+m48C5Hybog==
Received: from DM4PR12MB6087.namprd12.prod.outlook.com (2603:10b6:8:b1::12) by
 SA1PR12MB7176.namprd12.prod.outlook.com (2603:10b6:806:2bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 12:01:57 +0000
Received: from DM4PR12MB6087.namprd12.prod.outlook.com
 ([fe80::3359:f44d:6814:3ec3]) by DM4PR12MB6087.namprd12.prod.outlook.com
 ([fe80::3359:f44d:6814:3ec3%4]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 12:01:56 +0000
From: Slava Ovsiienko <viacheslavo@nvidia.com>
To: Vincent Jardin <vjardin@free.fr>, "dev@dpdk.org" <dev@dpdk.org>
CC: Raslan Darawsheh <rasland@nvidia.com>, "NBU-Contact-Thomas Monjalon
 (EXTERNAL)" <thomas@monjalon.net>, "andrew.rybchenko@oktetlabs.ru"
 <andrew.rybchenko@oktetlabs.ru>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>
Subject: RE: [PATCH v3 03/9] common/mlx5: extend SQ modify to support rate
 limit update
Thread-Topic: [PATCH v3 03/9] common/mlx5: extend SQ modify to support rate
 limit update
Thread-Index: AQHcsmvqeKbEQAE96kuTkuPyz3mkzrW3W3ww
Date: Fri, 20 Mar 2026 12:01:56 +0000
Message-ID: <DM4PR12MB60875A2129199EB8B0089924DF4CA@DM4PR12MB6087.namprd12.prod.outlook.com>
References: <20260310092014.2762894-1-vjardin@free.fr>
 <20260312220120.3256755-1-vjardin@free.fr>
 <20260312220120.3256755-4-vjardin@free.fr>
In-Reply-To: <20260312220120.3256755-4-vjardin@free.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6087:EE_|SA1PR12MB7176:EE_
x-ms-office365-filtering-correlation-id: 280ef9ab-d922-43e6-47cc-08de86787c0b
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|56012099003|18002099003|22082099003|41080700001|15866825006;
x-microsoft-antispam-message-info: N7AT0s3vd9RiDpT+pUJIuV3L5uH0u4OFQttxksUBFJou4VxVXJN8od0ZyOyxjLbN3q+Kpgt6FeMpRKcbSgjbtCw823op6MFtzp03pRCFCnrlz8vp6Y93+2XVGPgWL42R+ZqxqJF13TMjWMBz/VmirKs+7VHrJnoqfncJm8P3wdmJ6m0LXMAJRXn4txBC3lYqlb6PruaBzuOnU/pGClwwesE2jR4W+/8t3a1VqwIRO8uQ6wcCzyqRm8lO2DTgntNN17vOn0ZBd0j1XfQ2Hygwj4sK5KCZll+AHXZdOXeYtFCYC7PPj/YBRPziCIogkwtz9G46uPz5A7lbu12hciy5S/P0dQIMTgqNVRFLgxd7LYT1hHVy0to7E50uKCzU1eVNlN7Na6wnReWunMbKoFLlkzx1XpomOGKfFHTSqPmjN4gkFckEWljz6r499RMO2QhTWTgEqAXCsZkL7fByG2Ht2EkiwcGpzy1RbnPNtWIJByephy8DsqaOK2ghFCItHP2cNf7ciO+1FkUOFmozRTgLsRvPBUsx4pwl2eCwgiqu9x6bYBCzYYDv/5G/GJSAyUl3+uIIkCZrJLeoXu5xP+GOEfP/ZMHFSX0/T6/qJ7M1xLXQYAhXyOfLLmKCAicOoRWnOqXp7vhKaTS4MQ+S/IUrSIUGZOL5DM6Qu+dpTm0A6aT+gdiuEoOnksxM4IkO/wnZ1eKx9VH6+ubTKIQHNoxHNcrAQJ0UHyTAq98U7N6ACkOzOaUGKZ8jxTYyOS7c1xxVz3PliLZsbpslUSkA2ipAeVgJX/BSZ4+zi91DILCxZ7kCzOYVjJw/F2AHDOuhTROeq2puY4CYjCszZHFWjNo73+C8S/yLWmT//YQl7vwOhmE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6087.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099003)(18002099003)(22082099003)(41080700001)(15866825006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?StDSsN7hzDeWqq8IJY7GGD9JEclLt8E+gQYrg0L85FarYH2I+CiYHtCvXhlf?=
 =?us-ascii?Q?+2A3m55ZHc5f373xtuZdWwwIc7EFcZ/aYh13dGegqeflsI9qfaev2VZ5lC15?=
 =?us-ascii?Q?P43djp58JsiXsj/dZwsLMpgVQeGiMbSJ6aYKmbwCNjt0zvh7e1sAj4XbcDk3?=
 =?us-ascii?Q?c6dukrSM8KAEvbX5esBnXz8oU6WodT+E/UjFqtWFO2hLxX+8UFgJMDvwX/33?=
 =?us-ascii?Q?rxLIN/Zycul8Mk9C4MDaRQypB51zApokBzXfk1RHEws52pmEQXgcGHdCPIwo?=
 =?us-ascii?Q?kqPa0q82uWvzxZB8xx/h3PizhG/9m3Qq1ZmPd0ovlSvB3t8p1mK20nEOckjb?=
 =?us-ascii?Q?KYOU5m0oNdU1EmpHT1fIK0dAEzLdIVaIKQvIPi+YYTOJUogOldeVE93Wlb5U?=
 =?us-ascii?Q?MCX0V6R9KykYMCVUGCbbkFEyCyntlTbjNUC9TZSLgs2gsha9V7Ph/8efC2AX?=
 =?us-ascii?Q?f9S2fLR9MdtL4tDO43dxyGU0EPssEuaCAe5/66kDOXY0dauUFd1SqIcpjS8x?=
 =?us-ascii?Q?tFAWzvwNZw1dA6wsbEeYxeSdVdyLuC0jaI/G8yC1G/g5UMeEX0d6K8DKoHsQ?=
 =?us-ascii?Q?I34Ip0R1wMEhKI2SjbDv2svX+2/wLgWBRTzgdht2nBlSbgDtsIfZzmKbyPPp?=
 =?us-ascii?Q?MzjOMlI0c2hNmQONngaxJL57Gf5jEFKQzsoXaK64jenFXlkCiXercwR1n2rO?=
 =?us-ascii?Q?EEjl1W93QbiUSPdm9xt5zqgv+Ko4Irj5nvFsn1y8qt6tQ/Eh7n2p24CAKptI?=
 =?us-ascii?Q?aEZfswxY7gSi2sLjVKCx18Bin3a+ruAxtq4lDzStex/NHa+hJ2/mw4AuY654?=
 =?us-ascii?Q?3i7SExj/296kCoj2jojY8in3iKQ2E1GGM5KnBzwTJW3wRu8jLnez0n4IGpcF?=
 =?us-ascii?Q?G8xaARpZ4r9FsD84OQA2PlgcAy+LkIU0NFZwSxMRczFMBB3FPvvFD1PIezN5?=
 =?us-ascii?Q?QSAOTYyAPjxQEIdk4+NFA1DSuaBjRvyEOHkU0alZxC56N6aZRi/gQMW+Jm5O?=
 =?us-ascii?Q?46AHymzkfP5/2RHWzdMdJcB05CLq6Ynm4VyJ/rGuV5EBmjf6tCbZySd4Dy9G?=
 =?us-ascii?Q?9nLYHj9SrAZJN8lGU8m2w58gJAQ2/gryDqflTE9pSV80r5YV2ANaXvy+g/15?=
 =?us-ascii?Q?kLAlLHoG2/Wc2b/8/LvgTxkdYb/zUmYCIaFcvtVOeaZ0QcFdNMAEO6ItjHU+?=
 =?us-ascii?Q?yMJceEzI2zrEMErCNvaMkIKFGf+GTzKqKHyAypcA4WMj0RjFCOLaJofbjXI3?=
 =?us-ascii?Q?dObyr/M/XYuJD34ipUTO4fbqYNaqSiDMdodK2yp/2ab8ulc4AOJ1RxRksncU?=
 =?us-ascii?Q?qo9A7Q7/rwez5uFcOC++CmqfBYQgj4dKH4bScEyQXMutfWXZvlfhWw9lSz2E?=
 =?us-ascii?Q?f7J5UABedM13qtQMvQfapmIlfr9qkrBHCUp4f3GGaj6frranLI8t/HOnG6md?=
 =?us-ascii?Q?2VIabfwu4u9yYchFjCk+CtfmJ2rgH0xM6LQJehMTU3EzPM2OdXXFEtZBoHQK?=
 =?us-ascii?Q?4KCaJaqeRb623fe/7jhMJNv976pQfaA1GimNfAY1WK81/Y081SYCS/64tZv0?=
 =?us-ascii?Q?5F4BilU3lI8OafRlLCv6+DgAyYZqYWdGzHC23a4NYDWAMxGRfPvLA1HoP40Q?=
 =?us-ascii?Q?FcT6PuhVAq6H5o+6syN8kAcgn1Y5WaSwyiBNcFF9pFbJ1zp0A1FxMipOSdmA?=
 =?us-ascii?Q?jtQ5egDc0SOTZllr/bMJTedxptVwi2QvcW/wjlFOdnxYiBB+dh9cGd41bo3d?=
 =?us-ascii?Q?wYrTX8RWTg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6087.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 280ef9ab-d922-43e6-47cc-08de86787c0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 12:01:56.7973 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /zbhXpQpz5sxDpzeQnxEzU5FghNVJ9kJB9CespOWthq0bh5cW416elpHi1COAUwLqhXmSQrPvM/uLxfs/Ig5OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7176
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

Hi,

> -----Original Message-----
> From: Vincent Jardin <vjardin@free.fr>
> Sent: Friday, March 13, 2026 12:01 AM
> To: dev@dpdk.org
> Cc: Raslan Darawsheh <rasland@nvidia.com>; NBU-Contact-Thomas Monjalon
> (EXTERNAL) <thomas@monjalon.net>; andrew.rybchenko@oktetlabs.ru;
> Dariusz Sosnowski <dsosnowski@nvidia.com>; Slava Ovsiienko
> <viacheslavo@nvidia.com>; Bing Zhao <bingz@nvidia.com>; Ori Kam
> <orika@nvidia.com>; Suanming Mou <suanmingm@nvidia.com>; Matan Azrad
> <matan@nvidia.com>; stephen@networkplumber.org; Vincent Jardin
> <vjardin@free.fr>
> Subject: [PATCH v3 03/9] common/mlx5: extend SQ modify to support rate li=
mit
> update
>=20
> Add rl_update and packet_pacing_rate_limit_index fields to
> mlx5_devx_modify_sq_attr. When rl_update is set, the modify SQ command
> sets modify_bitmask bit 0 and writes the PP index into the SQ context, al=
lowing
> dynamic rate changes on a live RDY SQ without teardown.
>=20
> modify_sq_in.modify_bitmask[0x40] bit 0 controls the
> packet_pacing_rate_limit_index.
>=20
> Supported hardware:
> - ConnectX-6 Dx: per-SQ rate via packet_pacing_rate_limit_index
> - ConnectX-7/8: same SQ context field, also supports wait-on-time
> - BlueField-2/3: same modify_sq command support
>=20
> Not supported:
> - ConnectX-5: supports packet_pacing but only at SQ creation time,
>   dynamic modify_bitmask update may not be supported on all FW
> - ConnectX-4 Lx and earlier: no packet_pacing support
>=20
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> ---
>  drivers/common/mlx5/mlx5_devx_cmds.c | 5 +++++
> drivers/common/mlx5/mlx5_devx_cmds.h | 3 +++
>  2 files changed, 8 insertions(+)
>=20
> diff --git a/drivers/common/mlx5/mlx5_devx_cmds.c
> b/drivers/common/mlx5/mlx5_devx_cmds.c
> index 8f53303fa7..17378e1753 100644
> --- a/drivers/common/mlx5/mlx5_devx_cmds.c
> +++ b/drivers/common/mlx5/mlx5_devx_cmds.c
> @@ -2129,6 +2129,11 @@ mlx5_devx_cmd_modify_sq(struct mlx5_devx_obj
> *sq,
>  	MLX5_SET(sqc, sq_ctx, state, sq_attr->state);
>  	MLX5_SET(sqc, sq_ctx, hairpin_peer_rq, sq_attr->hairpin_peer_rq);
>  	MLX5_SET(sqc, sq_ctx, hairpin_peer_vhca, sq_attr-
> >hairpin_peer_vhca);
> +	if (sq_attr->rl_update) {
> +		MLX5_SET64(modify_sq_in, in, modify_bitmask, 1);

1. Please define enum for the bit: MLX5_MODIFY_SQ_IN_MODIFY_BITMASK_PACKET_=
PACING_RATE_LIMIT_INDEX
(please see MLX5_MODIFY_RQ_IN_MODIFY_xxx enum). Also no objections to defin=
e enums for other
MLX5_MODIFY_SQ_IN_MODIFY_BITMASK _xxx.

2. Please modify only the involved bits in the bitmask:

uint64_t bitmask;

bitmask =3D MLX5_GET64(modify_sq_in, in, modify_bitmask);
bitmask |=3D MLX5_MODIFY_SQ_IN_MODIFY_BITMASK_PACKET_PACING_RATE_LIMIT_INDE=
X;
MLX5_SET64(modify_sq_in, in, modify_bitmask, bitmask);

This would improve compatibility for the case bitmask is set somewhere befo=
re the "if (sq_attr->rl_update)".

With best regards,
Slava


> +		MLX5_SET(sqc, sq_ctx, packet_pacing_rate_limit_index,
> +			 sq_attr->packet_pacing_rate_limit_index);
> +	}
>  	ret =3D mlx5_glue->devx_obj_modify(sq->obj, in, sizeof(in),
>  					 out, sizeof(out));
>  	if (ret) {
> diff --git a/drivers/common/mlx5/mlx5_devx_cmds.h
> b/drivers/common/mlx5/mlx5_devx_cmds.h
> index 930ae2c072..82d949972b 100644
> --- a/drivers/common/mlx5/mlx5_devx_cmds.h
> +++ b/drivers/common/mlx5/mlx5_devx_cmds.h
> @@ -519,6 +519,9 @@ struct mlx5_devx_modify_sq_attr {
>  	uint32_t state:4;
>  	uint32_t hairpin_peer_rq:24;
>  	uint32_t hairpin_peer_vhca:16;
> +	uint32_t rl_update:1;
> +	/* Set to update packet_pacing_rate_limit_index on a live SQ. */
> +	uint32_t packet_pacing_rate_limit_index:16;
>  };
>=20
>=20
> --
> 2.43.0

