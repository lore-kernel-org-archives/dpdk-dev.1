Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02ED4F46100
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 13:19:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 50A724064E;
	Mon, 23 Mar 2026 14:19:32 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010008.outbound.protection.outlook.com [52.101.46.8])
 by mails.dpdk.org (Postfix) with ESMTP id 4EC8040268
 for <dev@dpdk.org>; Mon, 23 Mar 2026 14:19:31 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJ0jYCzE3DQI4DU0PUo4LV9eNHnAn/uV6y5VSX42UA+WyH34XDGrZDecfq5qEw/Wf1EtWljKHYAsyHAJRosIovC1B6Xs9DVtzcVMCRjvtCCWzmsK4urRR8gGZQZbhyv1+Rk+gxib8+leloq/wlEXr1/Wh5W2hQbdbz13xz4CSUXA4/idb1UTQrZfyLSw/FFQIGIATQL4tLTOcNOpxNl1t30TgN50hTIhxH5TUO5kzRzxXnbMK3f++weRs7TO1NzIlSE+nwsHM9aNhbgSipoGM8/NlnxpLVVx9fmqyizBVRIGTEh3MHLcPjMIfXS+BeS+xPq4fRFB1kxduToLJ2bUsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/X7Hxmrew8p2vI8ka+bs+bV2A+AW9UJHozF/0efBFA=;
 b=FEKQdLELmZ/sxFwmdi+cMmOc9GmClbfHdUE3CwvhMu0w9cOXhz4f8G3raz9l8qINqjJLFBmQK0sllBqwsqyEDTNkOUNRhebOL7PlTdMbeHzZ4UF+bAP1mmsKjFiIrCiIQTyu2rnmbbpF+X8DmkCQBLdCYWTliDB+SxLOnmkTr+Kpb8JH5zqPgsZacp34OMLP5++iMmALb+9sC/CoQT+U9hhwjvEjBmOqINwnRjO8OMssIMn4Y8X9LTgrgLDfHcaFl4PRHo0/SAdvnLP+1Of8fHi4hVI8n7+s6+iW6Et4ZqeuLZibRZPLSh8XVDdJHpbQqQbfWGPu7EemVpLb2J3AAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/X7Hxmrew8p2vI8ka+bs+bV2A+AW9UJHozF/0efBFA=;
 b=Ld+iHH7Z61jtFSoo4WocZFBiT0PIiGpFLghx6dyqk5MhUwKl93c8ls6jORclyLjtT5/8WszogBEzKJJDmIfeu6gPPoxKfYfbgT+V+khpKXiUJNJAKpYpoF88Og4iYcUnSH/XEllt/lzZGj6bE4SPjwkVq7ppNcwuqcTwPU+fZ88j7/FnyiRV7a4GO4W4/2gQKolxFqKhgxkg1UKPnkVBccrZKemrcrK7oV15OL6xNMZ6+eJu7CatRd907vfLcC1Vvxuw+knmEXF8YAJTpuzMbTrYynC7tVmER3loDv33cJIP8K1BILny9I7eGA+Xdgjrlxzq8tqEex2n9esE3LzL8A==
Received: from DM4PR12MB6087.namprd12.prod.outlook.com (2603:10b6:8:b1::12) by
 PH7PR12MB7257.namprd12.prod.outlook.com (2603:10b6:510:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 13:19:26 +0000
Received: from DM4PR12MB6087.namprd12.prod.outlook.com
 ([fe80::3359:f44d:6814:3ec3]) by DM4PR12MB6087.namprd12.prod.outlook.com
 ([fe80::3359:f44d:6814:3ec3%4]) with mapi id 15.20.9745.015; Mon, 23 Mar 2026
 13:19:26 +0000
From: Slava Ovsiienko <viacheslavo@nvidia.com>
To: Vincent Jardin <vjardin@free.fr>, "dev@dpdk.org" <dev@dpdk.org>
CC: Raslan Darawsheh <rasland@nvidia.com>, "NBU-Contact-Thomas Monjalon
 (EXTERNAL)" <thomas@monjalon.net>, "andrew.rybchenko@oktetlabs.ru"
 <andrew.rybchenko@oktetlabs.ru>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "aman.deep.singh@intel.com" <aman.deep.singh@intel.com>
Subject: RE: [PATCH v4 07/10] net/mlx5: add testpmd command to query per-queue
 rate limit
Thread-Topic: [PATCH v4 07/10] net/mlx5: add testpmd command to query
 per-queue rate limit
Thread-Index: AQHcugKcRS/KCS/9kkSqUl0ZgRuAy7W8G06A
Date: Mon, 23 Mar 2026 13:19:26 +0000
Message-ID: <DM4PR12MB608729EDFF0A2D02544A2547DF4BA@DM4PR12MB6087.namprd12.prod.outlook.com>
References: <20260312220120.3256755-1-vjardin@free.fr>
 <20260322134629.94633-1-vjardin@free.fr>
 <20260322134629.94633-8-vjardin@free.fr>
In-Reply-To: <20260322134629.94633-8-vjardin@free.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6087:EE_|PH7PR12MB7257:EE_
x-ms-office365-filtering-correlation-id: c6b06b55-d4c8-4c4e-39ed-08de88deceaf
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|18002099003|22082099003|56012099003|15866825006|41080700001;
x-microsoft-antispam-message-info: 8IfjChyKqO2aocJmSyVDpnJ6dvDz9mkh7WDBKtx5RgPHzB0lfrCxmxIpdJypVSj/v5/ykQ7J5+983kI0/BGrIgj7PAQ23OOA26kfx2ES4RXE1qUI7p0+swSc7C6h+4IDqsDgi6O7VRtXz6sC7WP7yWIdbMJ+AakaL/GIKXt4e2t6cJ7O0FsujV8ZQHkGZ9DP53yTS5Ra9j5Itjn+76vPRMG+mNcHKCp9X41lXALJK8uhAUMSRn2NylMn6NwYURmfnkmSM00bFpLn7Hj54/2a5susVTcrxZAQzrkCimd8LqsuoSSCIctGiVSeNw7NpeEQAwFhMjwHqmAOgwVg7VP3gFTHXNSp5bvxstpF6SSx8wbKrYGjjaJciQi7Tko4r+qtNHhbhzA0lWlJ4mlPmIG//47ZEdoOk9VYC/UBgGncQ0pBMaCSde9t6TfcncRTvBCeVvyR0cPWiwXn9SGhUj3U3bMWAgkXa5yMsNShWwwY9SFT6eei2AxGhsE+8aDrHAzNcnYToBGe/Pp+/6MmUH3huWELgS3gpHBAw7/a2UoTYqZyqKwE4wLnmfUA9wJ/BYylscqnFFNVlQwxxPOeZbvY3/6hmdblNVIgccHqdL4yawz0FOaGPAwVERuK1J4buACckINkAqSbZaJcTnZvyMExWaHvxGEHkyoe6vQUOOgUvN4smJaRqpgUQaZYyUC8lv4ZKBkChGtEepCqZTyHru+Z5H86faKi2D+jlYmkWqVlL3drdm7Rkmx97U4duQ9iwpQ6X24pGBbBFe32T27htIzdrDZu/rlfHuPkfKP8odqho9y7mycZXCnzwX4rMjPCgaUN6rlI0Uw4BiXTc3DXA1LEbJbGcNJF/pzZofOkx6uJ40A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6087.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(56012099003)(15866825006)(41080700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Yj3q3y0JGWM3XoMMmIDqD9y5aP0A+qVnm0o6FfxkPMYRTKeVZsWGVnIFaBet?=
 =?us-ascii?Q?IAvzCeTeuh6ZJ2eVXoWSMm5z2ke5Oj0X36hRdSHrexv+S/XNEqUP4GD2ZCLz?=
 =?us-ascii?Q?Gfz4Y/r3+1LBAaaCWpt//jDVXaJD49l54Uq7OMwBBfrfB6wg416wfo1O2XX9?=
 =?us-ascii?Q?tuBu12CKSMTZNLhHhexJXuytZXhy9/qYyY/eftr51CWks/t48yiaK94haLVO?=
 =?us-ascii?Q?Gnk8oQNl4rfqMpIH76s86Q+icoH0h4xQ8+W4MnE+W/E86taIAOjWQ6YX0ijR?=
 =?us-ascii?Q?viNRbtTAY3d0nOytABkiIafejCVF4hPlyRuUKcjXKgUNUGc7yliVTUzJvhNf?=
 =?us-ascii?Q?74WBSbtgLHR3+X1u5b0dZqHcfHNUkjwPizM2xBaJP/46plgvN874iDY5CmbC?=
 =?us-ascii?Q?o8yoRq003q0TaQi3+1FQF9VEiZfY2Gm23VdteUR5qTPCAYI6zljJgAjYO4K+?=
 =?us-ascii?Q?zgYzJ7jJ1k8M8fxvWxutb78k+b/rwkjpgUJE+lCYhkWpK83WMBTEwBkV0o+L?=
 =?us-ascii?Q?2FS11jBka3PfmhNGoa7K2YrX1sON18u8uiuDnO2QjQux6LbmhUQggUiBxJ8h?=
 =?us-ascii?Q?C8Zqtz+bUZE6BsR1NiRJCa1tbP4ydnvtaTOds09dcUTbMYc/n/fi4YMATkjf?=
 =?us-ascii?Q?y/Aa7yjSEniwKTyp3p4ZZQqKKijDCYCVjAQ6bF4Aw4sRfI65AykGZk9FaaI7?=
 =?us-ascii?Q?Xo/9uXyvlMpEIipdmzEulISmRbJrSxM0AXB0fzDHj124VtcabSDtbWW9vEvz?=
 =?us-ascii?Q?JkG1ZRinZx9sIgGkBCbDmAsjEd7DyXB8kHCX1rt4ynHW4qY8Vumb1IcVHXeQ?=
 =?us-ascii?Q?CjB/PBWw8zr7SskAdG7rug8cFN+2kJg4KBN3VcXp4+dGLJPYCqpcwyQ6JI7z?=
 =?us-ascii?Q?HXCTETzndL/NpAwbCdrorxidPRUYiYy+8zfypTKRhp8oQcV0kLY1gH2Tax+1?=
 =?us-ascii?Q?tnYzrgeTBO2WUDtKUwb9dbtTaCyT7ypdXKKOUXr5dmKZKuJMO1C34AolKyCk?=
 =?us-ascii?Q?CE0GxZKtlcd5I0Shyn+eNHcKkzF3/zpVl2pqy4Mb3XD/jvwMoSeskSWsutGk?=
 =?us-ascii?Q?9n5w8fCRm5Q3jWN2MqsiuHExYjwvn1iSAHaQuxXHwcdYvfkKHS64SEfDsUXs?=
 =?us-ascii?Q?QzRmqx4xUKuyeQsO/flctGsbC5ahVpOUR3CxgorgOeHeAGCXUjnX3W91oIxM?=
 =?us-ascii?Q?zuWOYbk/bLjffUrq9DzumW6uc67M6R5l881LLZoJ92b6xcHy8xN8Kij2LPk7?=
 =?us-ascii?Q?L0O9JH2gQ8mZWmkHA327CTvr3MuPyuRDZSXNFMxEkmhDSd8+DnxRp7fN0ZZ9?=
 =?us-ascii?Q?6RGo7ytM9V5CvC0nDrmjcPgVAWa5UDzFLDJs7KCxnw6Syy1E7/HMASS98hdb?=
 =?us-ascii?Q?p8JZAkbxxK58+RI52zo4qO0A7i2waqrrbK5QWiK/PRSqK3fGDGwMr7mxoKbQ?=
 =?us-ascii?Q?rZIMKGaAA9JqijJruIubrvobpgwAe56h2KK4w0GdLvMWUuZ8WtPMW46+o241?=
 =?us-ascii?Q?1zzOjPq24yNbASyXYopPIcq0lxqMH8FSyK4SXIJyYOP3qGnN7iaPjmwlERWc?=
 =?us-ascii?Q?KfR+EQK5613rUmfPWk6J6P0bcAyJRHd8Bt+4o7j7t+mClxcIbIzX+9fvx3gi?=
 =?us-ascii?Q?BCkOqzX+2dd4bIW66gXDKtMQZo8elEdaos3rT6XMNnwd6cmmXNOKC7dhHcb9?=
 =?us-ascii?Q?rvVef7PFSqR/f/ZFrAEQH/hiH7/t7v7s/hhLMeKjCMa/fMHH1e49i6ZhAITE?=
 =?us-ascii?Q?86THEuhn2A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6087.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b06b55-d4c8-4c4e-39ed-08de88deceaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 13:19:26.4653 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pBhjQuJOlm7CVU6OAuOWkKhw1FidDWk6eyyXrtaxE/L6Eyt+nRSuu6PGtRpRBwDJ6YL7pzTYl6HiMmGKVTCdPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7257
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

Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>

> -----Original Message-----
> From: Vincent Jardin <vjardin@free.fr>
> Sent: Sunday, March 22, 2026 3:46 PM
> To: dev@dpdk.org
> Cc: Raslan Darawsheh <rasland@nvidia.com>; NBU-Contact-Thomas Monjalon
> (EXTERNAL) <thomas@monjalon.net>; andrew.rybchenko@oktetlabs.ru;
> Dariusz Sosnowski <dsosnowski@nvidia.com>; Slava Ovsiienko
> <viacheslavo@nvidia.com>; Bing Zhao <bingz@nvidia.com>; Ori Kam
> <orika@nvidia.com>; Suanming Mou <suanmingm@nvidia.com>; Matan Azrad
> <matan@nvidia.com>; stephen@networkplumber.org;
> aman.deep.singh@intel.com; Vincent Jardin <vjardin@free.fr>
> Subject: [PATCH v4 07/10] net/mlx5: add testpmd command to query per-
> queue rate limit
>=20
> Add a new testpmd command to display the per-queue packet pacing rate lim=
it
> state, including the PP index from both driver state and FW SQ context
> readback:
>=20
>   testpmd> mlx5 port <port_id> txq <queue_id> rate show
>=20
> This helps verify that the FW actually applied the PP index to the SQ aft=
er setting
> a per-queue rate limit.
>=20
> Expose a new PMD API rte_pmd_mlx5_txq_rate_limit_query() that queries
> txq_ctrl->rate_limit for driver state and
> mlx5_devx_cmd_query_sq() for the FW
> packet_pacing_rate_limit_index field.
>=20
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> ---
>  drivers/net/mlx5/mlx5_testpmd.c | 93
> +++++++++++++++++++++++++++++++++
>  drivers/net/mlx5/mlx5_tx.c      | 40 +++++++++++++-
>  drivers/net/mlx5/rte_pmd_mlx5.h | 30 +++++++++++
>  3 files changed, 162 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/mlx5/mlx5_testpmd.c
> b/drivers/net/mlx5/mlx5_testpmd.c index 1bb5a89559..fd3efecc5d 100644
> --- a/drivers/net/mlx5/mlx5_testpmd.c
> +++ b/drivers/net/mlx5/mlx5_testpmd.c
> @@ -1365,6 +1365,94 @@ cmdline_parse_inst_t
> mlx5_cmd_dump_rq_context_options =3D {
>  	}
>  };
>=20
> +/* Show per-queue rate limit PP index for a given port/queue */ struct
> +mlx5_cmd_show_rate_limit_options {
> +	cmdline_fixed_string_t mlx5;
> +	cmdline_fixed_string_t port;
> +	portid_t port_id;
> +	cmdline_fixed_string_t txq;
> +	queueid_t queue_id;
> +	cmdline_fixed_string_t rate;
> +	cmdline_fixed_string_t show;
> +};
> +
> +cmdline_parse_token_string_t mlx5_cmd_show_rate_limit_mlx5 =3D
> +	TOKEN_STRING_INITIALIZER(struct
> mlx5_cmd_show_rate_limit_options,
> +				 mlx5, "mlx5");
> +cmdline_parse_token_string_t mlx5_cmd_show_rate_limit_port =3D
> +	TOKEN_STRING_INITIALIZER(struct
> mlx5_cmd_show_rate_limit_options,
> +				 port, "port");
> +cmdline_parse_token_num_t mlx5_cmd_show_rate_limit_port_id =3D
> +	TOKEN_NUM_INITIALIZER(struct mlx5_cmd_show_rate_limit_options,
> +			      port_id, RTE_UINT16);
> +cmdline_parse_token_string_t mlx5_cmd_show_rate_limit_txq =3D
> +	TOKEN_STRING_INITIALIZER(struct
> mlx5_cmd_show_rate_limit_options,
> +				 txq, "txq");
> +cmdline_parse_token_num_t mlx5_cmd_show_rate_limit_queue_id =3D
> +	TOKEN_NUM_INITIALIZER(struct mlx5_cmd_show_rate_limit_options,
> +			      queue_id, RTE_UINT16);
> +cmdline_parse_token_string_t mlx5_cmd_show_rate_limit_rate =3D
> +	TOKEN_STRING_INITIALIZER(struct
> mlx5_cmd_show_rate_limit_options,
> +				 rate, "rate");
> +cmdline_parse_token_string_t mlx5_cmd_show_rate_limit_show =3D
> +	TOKEN_STRING_INITIALIZER(struct
> mlx5_cmd_show_rate_limit_options,
> +				 show, "show");
> +
> +static void
> +mlx5_cmd_show_rate_limit_parsed(void *parsed_result,
> +				__rte_unused struct cmdline *cl,
> +				__rte_unused void *data)
> +{
> +	struct mlx5_cmd_show_rate_limit_options *res =3D parsed_result;
> +	struct rte_pmd_mlx5_txq_rate_limit_info info;
> +	int ret;
> +
> +	ret =3D rte_pmd_mlx5_txq_rate_limit_query(res->port_id, res-
> >queue_id,
> +						 &info);
> +	switch (ret) {
> +	case 0:
> +		break;
> +	case -ENODEV:
> +		fprintf(stderr, "invalid port_id %u\n", res->port_id);
> +		return;
> +	case -EINVAL:
> +		fprintf(stderr, "invalid queue index (%u), out of range\n",
> +			res->queue_id);
> +		return;
> +	case -EIO:
> +		fprintf(stderr, "failed to query SQ context\n");
> +		return;
> +	default:
> +		fprintf(stderr, "query failed (%d)\n", ret);
> +		return;
> +	}
> +	fprintf(stdout, "Port %u Txq %u rate limit info:\n",
> +		res->port_id, res->queue_id);
> +	if (info.rate_mbps > 0)
> +		fprintf(stdout, "  Configured rate: %u Mbps\n",
> +			info.rate_mbps);
> +	else
> +		fprintf(stdout, "  Configured rate: disabled\n");
> +	fprintf(stdout, "  PP index (driver): %u\n", info.pp_index);
> +	fprintf(stdout, "  PP index (FW readback): %u\n", info.fw_pp_index); }
> +
> +cmdline_parse_inst_t mlx5_cmd_show_rate_limit =3D {
> +	.f =3D mlx5_cmd_show_rate_limit_parsed,
> +	.data =3D NULL,
> +	.help_str =3D "mlx5 port <port_id> txq <queue_id> rate show",
> +	.tokens =3D {
> +		(void *)&mlx5_cmd_show_rate_limit_mlx5,
> +		(void *)&mlx5_cmd_show_rate_limit_port,
> +		(void *)&mlx5_cmd_show_rate_limit_port_id,
> +		(void *)&mlx5_cmd_show_rate_limit_txq,
> +		(void *)&mlx5_cmd_show_rate_limit_queue_id,
> +		(void *)&mlx5_cmd_show_rate_limit_rate,
> +		(void *)&mlx5_cmd_show_rate_limit_show,
> +		NULL,
> +	}
> +};
> +
>  static struct testpmd_driver_commands mlx5_driver_cmds =3D {
>  	.commands =3D {
>  		{
> @@ -1440,6 +1528,11 @@ static struct testpmd_driver_commands
> mlx5_driver_cmds =3D {
>  			.help =3D "mlx5 port (port_id) queue (queue_id) dump
> rq_context (file_name)\n"
>  				"    Dump mlx5 RQ Context\n\n",
>  		},
> +		{
> +			.ctx =3D &mlx5_cmd_show_rate_limit,
> +			.help =3D "mlx5 port (port_id) txq (queue_id) rate
> show\n"
> +				"    Show per-queue rate limit PP index\n\n",
> +		},
>  		{
>  			.ctx =3D NULL,
>  		},
> diff --git a/drivers/net/mlx5/mlx5_tx.c b/drivers/net/mlx5/mlx5_tx.c inde=
x
> 8085b5c306..7d71782d33 100644
> --- a/drivers/net/mlx5/mlx5_tx.c
> +++ b/drivers/net/mlx5/mlx5_tx.c
> @@ -800,7 +800,7 @@ int rte_pmd_mlx5_txq_dump_contexts(uint16_t
> port_id, uint16_t queue_id, const ch
>  	if (!rte_eth_dev_is_valid_port(port_id))
>  		return -ENODEV;
>=20
> -	if (rte_eth_tx_queue_is_valid(port_id, queue_id))
> +	if (rte_eth_tx_queue_is_valid(port_id, queue_id) !=3D 0)
>  		return -EINVAL;
>=20
>  	fd =3D fopen(path, "w");
> @@ -848,3 +848,41 @@ int rte_pmd_mlx5_txq_dump_contexts(uint16_t
> port_id, uint16_t queue_id, const ch
>  	fclose(fd);
>  	return ret;
>  }
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_txq_rate_limit_query,
> +26.07) int rte_pmd_mlx5_txq_rate_limit_query(uint16_t port_id, uint16_t
> queue_id,
> +				       struct rte_pmd_mlx5_txq_rate_limit_info
> *info) {
> +	struct rte_eth_dev *dev;
> +	struct mlx5_priv *priv;
> +	struct mlx5_txq_data *txq_data;
> +	struct mlx5_txq_ctrl *txq_ctrl;
> +	uint32_t sq_out[MLX5_ST_SZ_DW(query_sq_out)] =3D {0};
> +	int ret;
> +
> +	if (info =3D=3D NULL)
> +		return -EINVAL;
> +	if (!rte_eth_dev_is_valid_port(port_id))
> +		return -ENODEV;
> +	if (rte_eth_tx_queue_is_valid(port_id, queue_id) !=3D 0)
> +		return -EINVAL;
> +	dev =3D &rte_eth_devices[port_id];
> +	priv =3D dev->data->dev_private;
> +	txq_data =3D (*priv->txqs)[queue_id];
> +	txq_ctrl =3D container_of(txq_data, struct mlx5_txq_ctrl, txq);
> +	info->rate_mbps =3D txq_ctrl->rate_limit.rate_mbps;
> +	info->pp_index =3D txq_ctrl->rate_limit.pp_id;
> +	if (txq_ctrl->obj =3D=3D NULL) {
> +		info->fw_pp_index =3D 0;
> +		return 0;
> +	}
> +	ret =3D mlx5_devx_cmd_query_sq(txq_ctrl->obj->sq_obj.sq,
> +				     sq_out, sizeof(sq_out));
> +	if (ret)
> +		return -EIO;
> +	info->fw_pp_index =3D MLX5_GET(sqc,
> +				     MLX5_ADDR_OF(query_sq_out, sq_out,
> +						  sq_context),
> +				     packet_pacing_rate_limit_index);
> +	return 0;
> +}
> diff --git a/drivers/net/mlx5/rte_pmd_mlx5.h
> b/drivers/net/mlx5/rte_pmd_mlx5.h index 7acfdae97d..698d7d2032 100644
> --- a/drivers/net/mlx5/rte_pmd_mlx5.h
> +++ b/drivers/net/mlx5/rte_pmd_mlx5.h
> @@ -420,6 +420,36 @@ __rte_experimental
>  int
>  rte_pmd_mlx5_txq_dump_contexts(uint16_t port_id, uint16_t queue_id,
> const char *filename);
>=20
> +/**
> + * Per-queue rate limit information.
> + */
> +struct rte_pmd_mlx5_txq_rate_limit_info {
> +	uint32_t rate_mbps;	/**< Configured rate in Mbps, 0 =3D disabled. */
> +	uint16_t pp_index;	/**< PP index from driver state. */
> +	uint16_t fw_pp_index;	/**< PP index read back from FW SQ context.
> */
> +};
> +
> +/**
> + * Query per-queue rate limit state for a given Tx queue.
> + *
> + * @param[in] port_id
> + *   Port ID.
> + * @param[in] queue_id
> + *   Tx queue ID.
> + * @param[out] info
> + *   Rate limit information.
> + *
> + * @return
> + *   0 on success, negative errno on failure:
> + *   - -ENODEV: invalid port_id.
> + *   - -EINVAL: invalid queue_id.
> + *   - -EIO: FW query failed.
> + */
> +__rte_experimental
> +int
> +rte_pmd_mlx5_txq_rate_limit_query(uint16_t port_id, uint16_t queue_id,
> +				  struct rte_pmd_mlx5_txq_rate_limit_info
> *info);
> +
>  /** Type of mlx5 driver event for which custom callback is called. */  e=
num
> rte_pmd_mlx5_driver_event_cb_type {
>  	/** Called after HW Rx queue is created. */
> --
> 2.43.0

