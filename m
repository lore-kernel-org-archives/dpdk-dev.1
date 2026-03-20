Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B13109879B
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Mar 2026 15:45:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C9464402BB;
	Fri, 20 Mar 2026 16:45:30 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012042.outbound.protection.outlook.com [52.101.43.42])
 by mails.dpdk.org (Postfix) with ESMTP id 8C658402B2
 for <dev@dpdk.org>; Fri, 20 Mar 2026 16:45:28 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GaW48N7+ADH0a2Av1Vw5qy4xqRDh3zqxuIw+3eoadK08qdDUUBmYwVJuRuyuCFbtZpXeZyGqBrMrgTVEnRmk5aR5+U4ID1wK7dOkDLvEidkElZei2atVUpZ3PNcgo+u+ns2Dr4PeDK4TL/2FjhkUy9YDlNeWP8O7UQEmmNEb7gdfJ84+KgC53fl+Bmr6zkXPbqOjXDEC8ox8BH7EoRHz3Yqv54e4TKEWHTqAadQyZcCp4OHYmh1tD7uHUNl24KG9x8HDs8sqkQquEMPakTuhAWmaf0kUhtnF4K4u0FpM3nv9BFifsvMHU/gWreDTH06bLciTiVzEM+9IcxUWYx9TLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSlm/Iwlu0FrBQ1jqIVh4M3ahN4PVRxK2kQtBDUUQL0=;
 b=w1HfZK6Y1o6JeePq/N/wEnwr1BcNuoyfYKp7SS/l7ZzQCqRc59OoGGUecuZzbmDqH+Y2rA9QZtd4+E0LD0UQZYwC9OoRSL12/OqMC6RKDO0FAoy3ySHroT+WuMV1gwzS7icd2LbMKk1GLW/d6Mnfd/Vdf9xoYqu2GA8yGpVceW74O/3GAf/quIQ6IWhxSJHGcrHQZE9poGmsl2SppQCfM8MssWpji7ncogqfxg+4J48OxyA2mFNpvab29AafhuK1xNXV6Q8sgJIoAWfV6UQOj3Gs4WYR942Izd702tFtRIJvrIw/cN5CuQJ3R2GaFlW1arY8AJe8Th73eCM7YV6VuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSlm/Iwlu0FrBQ1jqIVh4M3ahN4PVRxK2kQtBDUUQL0=;
 b=TVvJSgUXiG17YAne8hUenwqmNqGWLZ9+VGpc6L1Jyo3m0bNGhe7hbdoSRc07ZjfchUP1yt0h54q/wPsl1YJhDJqc3erGLfamlRVAU1j0aZp8jHasdoY4iRpvx0wB3x5DnjCn3yIBvqC0qBxTSNe//Gky/AzzzD6198f8uAOCPioWdlqqxC9B5SUIL2SiIXCDsvLJZ+6N6jFtt4Kn1iO2aO085VTySjCoAPbeIAlQgO0vrwEJk3ptLh6ivVDI7jquq9GEunIlp0Gzvr+KJVJdLteTe+cxS6MtUfDDBWW3Iq29RAzRSLpKB7JvGS+tv1PBDCFgrXNi2wF+Jk9qJaGWbA==
Received: from DM4PR12MB6087.namprd12.prod.outlook.com (2603:10b6:8:b1::12) by
 IA1PR12MB6652.namprd12.prod.outlook.com (2603:10b6:208:38a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 15:44:33 +0000
Received: from DM4PR12MB6087.namprd12.prod.outlook.com
 ([fe80::3359:f44d:6814:3ec3]) by DM4PR12MB6087.namprd12.prod.outlook.com
 ([fe80::3359:f44d:6814:3ec3%4]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 15:44:33 +0000
From: Slava Ovsiienko <viacheslavo@nvidia.com>
To: Vincent Jardin <vjardin@free.fr>, "dev@dpdk.org" <dev@dpdk.org>
CC: Raslan Darawsheh <rasland@nvidia.com>, "NBU-Contact-Thomas Monjalon
 (EXTERNAL)" <thomas@monjalon.net>, "andrew.rybchenko@oktetlabs.ru"
 <andrew.rybchenko@oktetlabs.ru>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>
Subject: RE: [PATCH v3 08/9] ethdev: add getter for per-queue Tx rate limit
Thread-Topic: [PATCH v3 08/9] ethdev: add getter for per-queue Tx rate limit
Thread-Index: AQHcsmwYenU6zoMNtEmrbs7AVJKCVbW3m6KA
Date: Fri, 20 Mar 2026 15:44:33 +0000
Message-ID: <DM4PR12MB6087CEEF8A90789695B6145FDF4CA@DM4PR12MB6087.namprd12.prod.outlook.com>
References: <20260310092014.2762894-1-vjardin@free.fr>
 <20260312220120.3256755-1-vjardin@free.fr>
 <20260312220120.3256755-9-vjardin@free.fr>
In-Reply-To: <20260312220120.3256755-9-vjardin@free.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6087:EE_|IA1PR12MB6652:EE_
x-ms-office365-filtering-correlation-id: 44d2391e-9f0c-4b7d-2a44-08de86979541
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003|38070700021|41080700001|15866825006;
x-microsoft-antispam-message-info: Q34jp5OalwcgnrKA/jXjWSff8c87H/Epx7ktj9dgapKgsMfhdXVn10ywCptKy0xO5JB0MvHkqnQBJ5f6kIbLjwiwbL7xIrUpcktB7Oq55txbUeyuS2hs76thMMeH4G3aEV94I47dyGUm0lr/XDExyLiU/SQWWs1CdXCw8ovEoWxGLnaiGcY9OXI6tm5eNXnQTEPNx/Znaqx0k78ZVX1h7t6fmSduAq43MEiTwiX8JQEJgemqIKHU7YmzJZKdN0+dqEdS8c1eKCpcopmSYouhGZohwJnPQucf2NoqxqUUV45WO0LVKNESBeuK6uBP7qTasGgXV6w2zVL27cjp81NVuLk3zhrWrLVkEVOaimXssIKaUOjk9CKFHuW5dfa3Khn6s1NEylZGBjG7yRz/72ynqUdM5lGEntWP+RohpKaBb0W1uSIL9n0MhOl4/YD6Q7/04OdViPWxBfZLEGG4qkqh8hd7LO1vBYZpa4cu37tzPKWDDO0YNf4Yk2VgyyhbGbQqNQC8f5cmi4xQn9aZp38Pb9Cu0NrYtnYwSJFV9Jg4uXhHLO+6H6wrFK0Llv/OK8e//QJQRbYJ2cllCtGp0jwjvQp1nMDTMncoFT5qtn3CIpfrDkS4PEUZhQ+8W6J23+eWr3WUq0onqjrFAlZYZ52F5wG/CvlcsIE0GCqU2JRcfsXrkb7uVChITiFQYorx7fc0/9euwvp+wdYaOqEUqgBy1AgAh9RtB+6XoTqKszHQ/gZg4k/TRgnURMCX46JgeFa+YxFD58JHquyJXt9qfyDc4kFzwB9C0NKzYEgDXoUD7GBfhwlmW2V87aOrNaahoPQUjtyDjDmwANOcwGeseoHzigeg9A+QdbshLVYGCXdMAoE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6087.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(38070700021)(41080700001)(15866825006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pCynFftJN57IdaxaQ7L6+k7vH64Mzy2ybAOoWFlUo+OF9HiPvAbCXjRWrJud?=
 =?us-ascii?Q?ZQXpKb94H9S+moxMHDDHmmBO3SKBny9XoV8km+r/nRFNWi3T19kgubeLBZ98?=
 =?us-ascii?Q?F/avqT5ktVQQgk01Rxo5e5C/3w8xrPseJkyr0zeIp24bQa+WuJQfLjzP9oY/?=
 =?us-ascii?Q?qbPXGVQ5IxzBiqwLKrkT5S/5pWU0gZ8ASM6dF+EyXKmiffUEkzA7AoNbN4G/?=
 =?us-ascii?Q?f784eIXFW7hU4CNO4iSb6V8F4yZsIa4TlDGde1mXn70kOl6dfQXGsRPUKQB8?=
 =?us-ascii?Q?Ec44aKewaVIMVQ33jhn0g7wCfAhEbqFRCKN2UW5NRTSza8VIMIRebOhAYu9Q?=
 =?us-ascii?Q?6XhpB4ZQznys9xy0fmHHFEnDlMpdnHnbZhiARTmEcGlqwJq2NAcdy7Dwt/ru?=
 =?us-ascii?Q?U/ZyEwfJ+P2cXJtltlev5TmUeSXGss0QF4agW1idMHnTmXGPgSu5u847z6ma?=
 =?us-ascii?Q?X/F2EUD8r6SpSvXBB90mJyzCP/1qxp+gKUKkHLNptDzLdMBibZKPm9vIzjSF?=
 =?us-ascii?Q?lnYb5MU0w9IZaidGhv2zZPlwTuo0Ujl3BQivMj85upLwlCtUnpEiMeT09E52?=
 =?us-ascii?Q?+65nHwsDMkTg8v3MbBokI1Ec3KEvsAuVdbR1d7sjBBaPzpgNUdM/GJYjFxtA?=
 =?us-ascii?Q?lM3SPMGu1xw71SIzGrjhiVhEpbVgFtmiUmScYumUDvWMYeO7P3QBSUuvFBVH?=
 =?us-ascii?Q?GRCMIAqcxnBXoM3qAHC/A8CoIGrnRRlOxb9Eatd9q8KR8/M6Ov57uAqLVGS8?=
 =?us-ascii?Q?Vz0dutITB00vwK1Wm80byZAzaQzqkYpte6Tn2QFigxE8PzpO4HyzxQrS40Op?=
 =?us-ascii?Q?RZdCXRAqIvusnCjsNcM5ikC3j5eeuZ+1NDNR6mVDcw6Ceo8JkJdvcp4+NFBZ?=
 =?us-ascii?Q?KouXHniSKT9mY+PUw6i3i4OEBPA/jX+UVhFJxEZCweKgthyxQONhTkx+DTqU?=
 =?us-ascii?Q?dvAOMWxxFfqN0o+/49P7aEGyxuIfvoNN5svjOvVgs2a2zGREYhmlGconFtmU?=
 =?us-ascii?Q?bH0K9BR43fH6XE6MCJyqNf0Mpy7XLkB/m6isuTwFMe5uHaI0Y5Uq9drqgO7a?=
 =?us-ascii?Q?sLe7QbWTDsAajrOrA2nFhkHXibawCA1M+VYax8zaZoLl3lJB+zoWv6Q4MKmp?=
 =?us-ascii?Q?mXo/6vcJKn5QJDKmVzPgR7pk/tu9vjmtcm60/WEYWMasfEtnVzOHI5u9Dbm7?=
 =?us-ascii?Q?E+17R+jvIk25F3hKgJUcUEt2uaKP2ViReYKTZs1VaySboBGGbZ+ONlcAqxOJ?=
 =?us-ascii?Q?VdEBKuiw7GcxKUayM+FecDAXHxjoSuSJ5u8/FQLwfGP6f943pb51nGMVSH4N?=
 =?us-ascii?Q?6bGzf8VtYlAK48BjDYc/8/7hkO4QMDUiYrzmu2PsJ+8txs6k+mKRh4EOC2Fi?=
 =?us-ascii?Q?4LgwSzzTrXJ95/Pp3BSCnGO73M/c3spINGIH/tazclE13qjbxJbaJSdS6N5s?=
 =?us-ascii?Q?KTWNXZeY4qDWmUCBi4jWUBX6XiWRmmBQX7oKtTFMz893Y6QBF57iVkRm3wLm?=
 =?us-ascii?Q?XDNjAICdQ2C7DJjw3dsB/2+zdd/pp6GmMUmc8rwL1Uy6kYVGMRbzoPPczbti?=
 =?us-ascii?Q?CAN+HtYtVTcHhiZFhaPrxmPAMNJCsfmQtX99X5PDltYE8bBpuKd6d4YcDjC7?=
 =?us-ascii?Q?hFzoCkMuip7W6pk0FuEjVugLJgUFuPyzhVP7L1x3cxromMS2b4kKIfEoK8ee?=
 =?us-ascii?Q?vMwFFK/j4w9fMJvaunumk49B44p078aOxXoLAbBnNYB6U5z3mkrsPrYLLy+C?=
 =?us-ascii?Q?A5i+JUAgqg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6087.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d2391e-9f0c-4b7d-2a44-08de86979541
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 15:44:33.5250 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VKvNOZKKqfMXu+nPzIYBrk4zAa8dgaW4XbSHlcNSfkhBxw0rmyXJCPk9666tLz7eg1ePA2UQpN2cg+884fbKew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6652
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

Should we split this commit into two ones? For rte and for the driver?
Should we add tracing to the rte_eth_get_queue_rate_limit() getter like we =
have
in the rte_eth_set_queue_rate_limit() ?

With best regards,
Slava

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
> Subject: [PATCH v3 08/9] ethdev: add getter for per-queue Tx rate limit
>=20
> The existing rte_eth_set_queue_rate_limit() API allows setting a per-queu=
e Tx
> rate but provides no way to read it back. Applications such as grout are =
forced
> to maintain a shadow copy of the rate to be able to report it.
>=20
> Add rte_eth_get_queue_rate_limit() as the symmetric getter, following the
> established DPDK pattern (e.g. rte_eth_dev_set_mtu/get_mtu,
> rte_eth_dev_set_vlan_offload/get_vlan_offload).
>=20
> This adds:
> - eth_get_queue_rate_limit_t driver callback in ethdev_driver.h
> - rte_eth_get_queue_rate_limit() public experimental API (26.07)
> - mlx5 PMD implementation reading from the existing per-queue
>   rate_mbps tracking field
>=20
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> ---
>  app/test-pmd/cmdline.c      | 69
> +++++++++++++++++++++++++++++++++++++
>  drivers/net/mlx5/mlx5.c     |  2 ++
>  drivers/net/mlx5/mlx5_tx.h  |  2 ++
>  drivers/net/mlx5/mlx5_txq.c | 30 ++++++++++++++++
> lib/ethdev/ethdev_driver.h  |  7 ++++
>  lib/ethdev/rte_ethdev.c     | 28 +++++++++++++++
>  lib/ethdev/rte_ethdev.h     | 24 +++++++++++++
>  7 files changed, 162 insertions(+)
>=20
> diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c index
> c33c66f327..ee532984e8 100644
> --- a/app/test-pmd/cmdline.c
> +++ b/app/test-pmd/cmdline.c
> @@ -8912,6 +8912,74 @@ static cmdline_parse_inst_t cmd_queue_rate_limit
> =3D {
>  	},
>  };
>=20
> +/* *** SHOW RATE LIMIT FOR A QUEUE OF A PORT *** */ struct
> +cmd_show_queue_rate_limit_result {
> +	cmdline_fixed_string_t show;
> +	cmdline_fixed_string_t port;
> +	uint16_t port_num;
> +	cmdline_fixed_string_t queue;
> +	uint16_t queue_num;
> +	cmdline_fixed_string_t rate;
> +};
> +
> +static void cmd_show_queue_rate_limit_parsed(void *parsed_result,
> +		__rte_unused struct cmdline *cl,
> +		__rte_unused void *data)
> +{
> +	struct cmd_show_queue_rate_limit_result *res =3D parsed_result;
> +	uint32_t tx_rate =3D 0;
> +	int ret;
> +
> +	ret =3D rte_eth_get_queue_rate_limit(res->port_num, res->queue_num,
> +					   &tx_rate);
> +	if (ret) {
> +		fprintf(stderr, "Get queue rate limit failed: %s\n",
> +			rte_strerror(-ret));
> +		return;
> +	}
> +	if (tx_rate)
> +		printf("Port %u Queue %u rate limit: %u Mbps\n",
> +		       res->port_num, res->queue_num, tx_rate);
> +	else
> +		printf("Port %u Queue %u rate limit: disabled\n",
> +		       res->port_num, res->queue_num); }
> +
> +static cmdline_parse_token_string_t cmd_show_queue_rate_limit_show =3D
> +	TOKEN_STRING_INITIALIZER(struct
> cmd_show_queue_rate_limit_result,
> +				show, "show");
> +static cmdline_parse_token_string_t cmd_show_queue_rate_limit_port =3D
> +	TOKEN_STRING_INITIALIZER(struct
> cmd_show_queue_rate_limit_result,
> +				port, "port");
> +static cmdline_parse_token_num_t cmd_show_queue_rate_limit_portnum =3D
> +	TOKEN_NUM_INITIALIZER(struct cmd_show_queue_rate_limit_result,
> +				port_num, RTE_UINT16);
> +static cmdline_parse_token_string_t cmd_show_queue_rate_limit_queue =3D
> +	TOKEN_STRING_INITIALIZER(struct
> cmd_show_queue_rate_limit_result,
> +				queue, "queue");
> +static cmdline_parse_token_num_t cmd_show_queue_rate_limit_queuenum
> =3D
> +	TOKEN_NUM_INITIALIZER(struct cmd_show_queue_rate_limit_result,
> +				queue_num, RTE_UINT16);
> +static cmdline_parse_token_string_t cmd_show_queue_rate_limit_rate =3D
> +	TOKEN_STRING_INITIALIZER(struct
> cmd_show_queue_rate_limit_result,
> +				rate, "rate");
> +
> +static cmdline_parse_inst_t cmd_show_queue_rate_limit =3D {
> +	.f =3D cmd_show_queue_rate_limit_parsed,
> +	.data =3D NULL,
> +	.help_str =3D "show port <port_id> queue <queue_id> rate: "
> +		"Show rate limit for a queue on port_id",
> +	.tokens =3D {
> +		(void *)&cmd_show_queue_rate_limit_show,
> +		(void *)&cmd_show_queue_rate_limit_port,
> +		(void *)&cmd_show_queue_rate_limit_portnum,
> +		(void *)&cmd_show_queue_rate_limit_queue,
> +		(void *)&cmd_show_queue_rate_limit_queuenum,
> +		(void *)&cmd_show_queue_rate_limit_rate,
> +		NULL,
> +	},
> +};
> +
>  /* *** SET RATE LIMIT FOR A VF OF A PORT *** */  struct
> cmd_vf_rate_limit_result {
>  	cmdline_fixed_string_t set;
> @@ -14198,6 +14266,7 @@ static cmdline_parse_ctx_t builtin_ctx[] =3D {
>  	&cmd_set_uc_all_hash_filter,
>  	&cmd_vf_mac_addr_filter,
>  	&cmd_queue_rate_limit,
> +	&cmd_show_queue_rate_limit,
>  	&cmd_tunnel_udp_config,
>  	&cmd_showport_rss_hash,
>  	&cmd_showport_rss_hash_key,
> diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c index
> f399e0d5c9..6e21ed31f3 100644
> --- a/drivers/net/mlx5/mlx5.c
> +++ b/drivers/net/mlx5/mlx5.c
> @@ -2721,6 +2721,7 @@ const struct eth_dev_ops mlx5_dev_ops =3D {
>  	.rx_metadata_negotiate =3D mlx5_flow_rx_metadata_negotiate,
>  	.get_restore_flags =3D mlx5_get_restore_flags,
>  	.set_queue_rate_limit =3D mlx5_set_queue_rate_limit,
> +	.get_queue_rate_limit =3D mlx5_get_queue_rate_limit,
>  };
>=20
>  /* Available operations from secondary process. */ @@ -2815,6 +2816,7 @@
> const struct eth_dev_ops mlx5_dev_ops_isolate =3D {
>  	.map_aggr_tx_affinity =3D mlx5_map_aggr_tx_affinity,
>  	.get_restore_flags =3D mlx5_get_restore_flags,
>  	.set_queue_rate_limit =3D mlx5_set_queue_rate_limit,
> +	.get_queue_rate_limit =3D mlx5_get_queue_rate_limit,
>  };
>=20
>  /**
> diff --git a/drivers/net/mlx5/mlx5_tx.h b/drivers/net/mlx5/mlx5_tx.h inde=
x
> 3a37f5bb4d..46e199d93e 100644
> --- a/drivers/net/mlx5/mlx5_tx.h
> +++ b/drivers/net/mlx5/mlx5_tx.h
> @@ -224,6 +224,8 @@ int mlx5_txq_releasable(struct rte_eth_dev *dev,
> uint16_t idx);  int mlx5_txq_verify(struct rte_eth_dev *dev);  int
> mlx5_set_queue_rate_limit(struct rte_eth_dev *dev, uint16_t queue_idx,
>  			      uint32_t tx_rate);
> +int mlx5_get_queue_rate_limit(struct rte_eth_dev *dev, uint16_t queue_id=
x,
> +			      uint32_t *tx_rate);
>  int mlx5_txq_get_sqn(struct mlx5_txq_ctrl *txq);  void
> mlx5_txq_alloc_elts(struct mlx5_txq_ctrl *txq_ctrl);  void
> mlx5_txq_free_elts(struct mlx5_txq_ctrl *txq_ctrl); diff --git
> a/drivers/net/mlx5/mlx5_txq.c b/drivers/net/mlx5/mlx5_txq.c index
> f0881f3560..c81542113e 100644
> --- a/drivers/net/mlx5/mlx5_txq.c
> +++ b/drivers/net/mlx5/mlx5_txq.c
> @@ -1473,6 +1473,36 @@ mlx5_set_queue_rate_limit(struct rte_eth_dev
> *dev, uint16_t queue_idx,
>  	return 0;
>  }
>=20
> +/**
> + * Get per-queue packet pacing rate limit.
> + *
> + * @param dev
> + *   Pointer to Ethernet device.
> + * @param queue_idx
> + *   TX queue index.
> + * @param[out] tx_rate
> + *   Pointer to store the TX rate in Mbps, 0 if rate limiting is disable=
d.
> + *
> + * @return
> + *   0 on success, a negative errno value otherwise and rte_errno is set=
.
> + */
> +int
> +mlx5_get_queue_rate_limit(struct rte_eth_dev *dev, uint16_t queue_idx,
> +			  uint32_t *tx_rate)
> +{
> +	struct mlx5_priv *priv =3D dev->data->dev_private;
> +	struct mlx5_txq_ctrl *txq_ctrl;
> +
> +	if (priv->txqs =3D=3D NULL || (*priv->txqs)[queue_idx] =3D=3D NULL) {
> +		rte_errno =3D EINVAL;
> +		return -rte_errno;
> +	}
> +	txq_ctrl =3D container_of((*priv->txqs)[queue_idx],
> +				struct mlx5_txq_ctrl, txq);
> +	*tx_rate =3D txq_ctrl->rl.rate_mbps;
> +	return 0;
> +}
> +
>  /**
>   * Verify if the queue can be released.
>   *
> diff --git a/lib/ethdev/ethdev_driver.h b/lib/ethdev/ethdev_driver.h inde=
x
> 1255cd6f2c..0f336f9567 100644
> --- a/lib/ethdev/ethdev_driver.h
> +++ b/lib/ethdev/ethdev_driver.h
> @@ -762,6 +762,11 @@ typedef int (*eth_set_queue_rate_limit_t)(struct
> rte_eth_dev *dev,
>  				uint16_t queue_idx,
>  				uint32_t tx_rate);
>=20
> +/** @internal Get queue Tx rate. */
> +typedef int (*eth_get_queue_rate_limit_t)(struct rte_eth_dev *dev,
> +				uint16_t queue_idx,
> +				uint32_t *tx_rate);
> +
>  /** @internal Add tunneling UDP port. */  typedef int
> (*eth_udp_tunnel_port_add_t)(struct rte_eth_dev *dev,
>  					 struct rte_eth_udp_tunnel
> *tunnel_udp); @@ -1522,6 +1527,8 @@ struct eth_dev_ops {
>=20
>  	/** Set queue rate limit */
>  	eth_set_queue_rate_limit_t set_queue_rate_limit;
> +	/** Get queue rate limit */
> +	eth_get_queue_rate_limit_t get_queue_rate_limit;
>=20
>  	/** Configure RSS hash protocols and hashing key */
>  	rss_hash_update_t          rss_hash_update;
> diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c index
> 2edc7a362e..c6ad399033 100644
> --- a/lib/ethdev/rte_ethdev.c
> +++ b/lib/ethdev/rte_ethdev.c
> @@ -5694,6 +5694,34 @@ int rte_eth_set_queue_rate_limit(uint16_t
> port_id, uint16_t queue_idx,
>  	return ret;
>  }
>=20
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_get_queue_rate_limit, 26.07)
> int
> +rte_eth_get_queue_rate_limit(uint16_t port_id, uint16_t queue_idx,
> +					uint32_t *tx_rate)
> +{
> +	struct rte_eth_dev *dev;
> +
> +	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
> +	dev =3D &rte_eth_devices[port_id];
> +
> +	if (tx_rate =3D=3D NULL) {
> +		RTE_ETHDEV_LOG_LINE(ERR,
> +			"Get queue rate limit:port %u: NULL tx_rate pointer",
> +			port_id);
> +		return -EINVAL;
> +	}
> +
> +	if (queue_idx >=3D dev->data->nb_tx_queues) {
> +		RTE_ETHDEV_LOG_LINE(ERR,
> +			"Get queue rate limit:port %u: invalid queue ID=3D%u",
> +			port_id, queue_idx);
> +		return -EINVAL;
> +	}
> +
> +	if (dev->dev_ops->get_queue_rate_limit =3D=3D NULL)
> +		return -ENOTSUP;
> +	return eth_err(port_id, dev->dev_ops->get_queue_rate_limit(dev,
> +queue_idx, tx_rate)); }
> +
>  RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_rx_avail_thresh_set, 22.07)
> int rte_eth_rx_avail_thresh_set(uint16_t port_id, uint16_t queue_id,
>  			       uint8_t avail_thresh)
> diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h index
> 0d8e2d0236..e525217b77 100644
> --- a/lib/ethdev/rte_ethdev.h
> +++ b/lib/ethdev/rte_ethdev.h
> @@ -4817,6 +4817,30 @@ int rte_eth_dev_uc_all_hash_table_set(uint16_t
> port_id, uint8_t on);  int rte_eth_set_queue_rate_limit(uint16_t port_id,
> uint16_t queue_idx,
>  			uint32_t tx_rate);
>=20
> +/**
> + * @warning
> + * @b EXPERIMENTAL: this API may change, or be removed, without prior
> notice.
> + *
> + * Get the rate limitation for a queue on an Ethernet device.
> + *
> + * @param port_id
> + *   The port identifier of the Ethernet device.
> + * @param queue_idx
> + *   The queue ID.
> + * @param[out] tx_rate
> + *   A pointer to retrieve the Tx rate in Mbps.
> + *   0 means rate limiting is disabled.
> + * @return
> + *   - (0) if successful.
> + *   - (-ENOTSUP) if hardware doesn't support this feature.
> + *   - (-ENODEV) if *port_id* invalid.
> + *   - (-EIO) if device is removed.
> + *   - (-EINVAL) if bad parameter.
> + */
> +__rte_experimental
> +int rte_eth_get_queue_rate_limit(uint16_t port_id, uint16_t queue_idx,
> +			uint32_t *tx_rate);
> +
>  /**
>   * Configuration of Receive Side Scaling hash computation of Ethernet de=
vice.
>   *
> --
> 2.43.0

