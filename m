Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB8AF46101
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 13:20:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5FD4140666;
	Mon, 23 Mar 2026 14:20:01 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010005.outbound.protection.outlook.com [52.101.46.5])
 by mails.dpdk.org (Postfix) with ESMTP id DD1974064E
 for <dev@dpdk.org>; Mon, 23 Mar 2026 14:19:59 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i6W9127XGXvuvbOSabSPwIMBzJya1wqYIYqU5lzfYljIC0maVMm1qFzPEj5iAENGw0nXw5hP/nKNKrJW7m3KtF50nZC+Gpar9HvD1BTsmasnkMzRmx/w94CQ4cvGCxcwbUumjtNdb+i9nqlJz+CvimjWWyFBOzwgEAD2IWdoIB1vbJuuVcr8HWzjurU25tSlk7U4FW07uTsdV7ji/2fmfhC7GG4Hnrmn3LU45O55nQ7xbxbDL9K/WMHKGHQeXJJtXBEiEMPIB8C/ftQDso8q2og0Gdx1pEacOicXFd6XJ6dGNUPISmvheeHlT8PqlulmNHWblV4negI9wYcNIeKBTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cta/r0v2ilbvvO7pftn6tYVFC/RW4cUt8URoda4LIzo=;
 b=mqihYTdCld+q/dablEPIIc0KcTW5Ax/lR5Qh31bYevNILYa1h0CXZeid31ddNbryfENOHbda4ld0NAbS+ZnGfYRG3oRQSja1uDMUhPC86lbfYZK1WSxzA/kz21SvvBVxsQyuB8S4fQSnHOmBfLk4pmS5d6ZF2zTn55DaE85voe7XxYxZYpSFLgdeeVmPhPnaxN2QPjN4/f6SlusTKaGqbQ2Q/b61M77WxervjfYs4T09r1rd4YKDQksoHnbFiB3dH96WoyH2oFJM8rw/+CAfqjFAgzJ0nNaxljF8/omJMEET7V3KtRhsydAASTMvWLdn+LuylcRuS0MQ26p31pn5cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cta/r0v2ilbvvO7pftn6tYVFC/RW4cUt8URoda4LIzo=;
 b=RsfWxFgSNMSH7LbqhzL3VIfAQBnyuLdQhtzTuvNt2vFSZsVxu/H2uUtcDG+8QAwUylvLySKHnh0srE0TLGqK0sPa+xsVW5JhMKR+6JV3yhcuTxHqsUVmDyTzo7VoJniWDJIKj8HuUKBJHTGywXSjnGVWOdgLWWulHszSUAhhlbwdol9Kt/YgRE/pJQYxb3tPP7QSEchiFdqO3ZewCPfHWRGuvjqB90EQyadwmNKkcqylcgr5YBGWcmb4e8nbx0a/E84ln/UQ/sEmduhN/WPU+V0saUB1oSXEtwENQ+IdLuJgomi6WF/ngt6fIpyaTV/wMKj2BDbnLBmttXpCuoUWdQ==
Received: from DM4PR12MB6087.namprd12.prod.outlook.com (2603:10b6:8:b1::12) by
 PH7PR12MB7257.namprd12.prod.outlook.com (2603:10b6:510:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 13:19:56 +0000
Received: from DM4PR12MB6087.namprd12.prod.outlook.com
 ([fe80::3359:f44d:6814:3ec3]) by DM4PR12MB6087.namprd12.prod.outlook.com
 ([fe80::3359:f44d:6814:3ec3%4]) with mapi id 15.20.9745.015; Mon, 23 Mar 2026
 13:19:56 +0000
From: Slava Ovsiienko <viacheslavo@nvidia.com>
To: Vincent Jardin <vjardin@free.fr>, "dev@dpdk.org" <dev@dpdk.org>
CC: Raslan Darawsheh <rasland@nvidia.com>, "NBU-Contact-Thomas Monjalon
 (EXTERNAL)" <thomas@monjalon.net>, "andrew.rybchenko@oktetlabs.ru"
 <andrew.rybchenko@oktetlabs.ru>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "aman.deep.singh@intel.com" <aman.deep.singh@intel.com>
Subject: RE: [PATCH v4 08/10] ethdev: add getter for per-queue Tx rate limit
Thread-Topic: [PATCH v4 08/10] ethdev: add getter for per-queue Tx rate limit
Thread-Index: AQHcugKoO+8ubxCBuE2ciBOYD4qdsLW8G3Lw
Date: Mon, 23 Mar 2026 13:19:56 +0000
Message-ID: <DM4PR12MB60876B693BE49656587F5159DF4BA@DM4PR12MB6087.namprd12.prod.outlook.com>
References: <20260312220120.3256755-1-vjardin@free.fr>
 <20260322134629.94633-1-vjardin@free.fr>
 <20260322134629.94633-9-vjardin@free.fr>
In-Reply-To: <20260322134629.94633-9-vjardin@free.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6087:EE_|PH7PR12MB7257:EE_
x-ms-office365-filtering-correlation-id: 67e59e58-cbd9-4a38-cd1d-08de88dee07e
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|18002099003|22082099003|56012099003|15866825006|41080700001;
x-microsoft-antispam-message-info: 4TTI3S4o7OcPeCpb1ACmyvTdm6C8TRk22FpebEtSoc1DTH/CSTXQ99/ABGz09rljSHTO8DQkwakumKTPZOaNRIZbWIcH1QzUoMJEtSyOhuW7jlBqAC8Bxv65m4br5hrNuZynM0hRDftg2K5N7vpDeT2L42U2Yt8TJ8XyUiG2Q0xfnaAUVO4NpJqqDBJxPDgrjL4OnBn2cnCbJRqgleYWvbEecVAdnTjaxe6v0pFqBXW3qnDCXKjrpg02uPP+nCL3uFLyCD12QjmVtDnctEIN9Xq0JayoytQ9Un5CnwvlsL5CK2wg+ErKr/5+Kw+faYk2CAhHk8N8f6Zlm3MG69M2wnmJ8wa0TbheTV6CZK2A3L85+8G2n7eNgJwtKpeh5ZfgQohwZju/uMCY+Fpgtu+WYHnR0XkscdqKScaJ1UT+evDd0s8QI0I+UFi7zFaGqVHsKowoQ0aXUrISWymjQWle6NUMgvB0V4AK7OdfO+DNJ+eq73AUmRjxayq7/uLB9l3ofcUkAE/Czah1Q5V+gNZEMlpiWtsTMSgzy8+1HNLzV80B+2/+Ou4n27IzGRMtiwwEoY/ZTVFFCK1sPju+NjVj3xZu4UIEWL7S6Y43dPMkS2uUxhHqxk/4XqXLYCYlAin3Wo8E4i1VW8UTRg1PciIcoxofzCodcyDtUmhsgmE0P5z/47mlfz1Z2bKI36olYdvgxSt0xNTmqA3mWlw5bQFyoLim3qb+woHxRQzqRYnAn76Z0VwXBKVm31nZNuq69oC3zxh4iwTIuoa2VMQdCdekfgzmx5wNp9snkJYGDCVHuMypctbMzELtNUbeUEPRLZdoM0xXRVhRGgtFBGuEm8fT6NsakTLshnQlDoFnZ2N/a8c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6087.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(56012099003)(15866825006)(41080700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YyAdA7tEOkt4zV43QDP9BiqTXWF7/SCUcvFHLf4dkgJtEocKfQ+xn2gsrECi?=
 =?us-ascii?Q?MxsMwzxMtdyZmjG7hsFFY7niwwlInuFkDSCsjFuzeL2oDM3Qgprdpdv4BmjM?=
 =?us-ascii?Q?9MLOd6z52q7Y9rR96zR37lz7oZOwUr4UgtMrjm42PH4mRWHkjCOlc7yScU9l?=
 =?us-ascii?Q?TNarggmvXeL+rYSzveVjBecigD0rbE/74zzU5iq3epsI3dFH6JAZzIYG0i1j?=
 =?us-ascii?Q?ye3ucOihSCvmZmi+r49uflJDoZW9YF0bceJ8T9tag0pBVSrJcsjLOopRaXZA?=
 =?us-ascii?Q?XX3Af6JplZspc6Zzdb9PvyNfrV/6wQRJU2Z6CJydGFTu4qQ/7Hck6HULtPMI?=
 =?us-ascii?Q?Xpjej9lAq3hHpDyM+9MMxd3Jc4L1Fbkcd37mETNW0KNptDlb9iQ7A7MLPN+Z?=
 =?us-ascii?Q?ca2yU+xFdQMtk6zUc0lOAPiSNGelH8cwpyu3B+G+F48uEEwFjYKqjKLb+DFy?=
 =?us-ascii?Q?ccI+2/OHJMpmARI5LztmedbuatqfmIMWr9WGZ1DwjCn67/NEzVNvot7au4v9?=
 =?us-ascii?Q?AvLhEJ4fn6/NKVm96IIFnSAl3n/kYfuLHURXPC8lV751IXchLl9q39pC18JC?=
 =?us-ascii?Q?axwdyaUM43yHnfj2TnIZ+3K4KuQ1W3wTQmnSbh4Lzm0kYkz3i2gPTMJ3ulSX?=
 =?us-ascii?Q?0nqoQWhtBB/gMmDyRTw03sIBuneVmK9SdQqft2Hkmv6+Tmp/ker/FF7XVWAs?=
 =?us-ascii?Q?SzuUhriFBHZQyBnEnDpU7YQ+d58tbU4cBF2OpldG4s9DLpaxbxjpF7gBuBhK?=
 =?us-ascii?Q?YS3YCGx/7eLWQieXxcbgieXyzATLifE6Llf2maj0azF6CEecVLp4OUAHzOh1?=
 =?us-ascii?Q?vOlf4lehsKUyPP2UXU7RX4UZ6kwIFyUoOFrechy/bOgzKdeWhMjIE0hmxMoe?=
 =?us-ascii?Q?te7ZOd+djQHbarNuxdaDlVBXSEnJ1tzqYt06ZVpyK7/z9P/TppWKc22pDgIv?=
 =?us-ascii?Q?TwEldWyfCCEo/ZqeuyjLOomyB9Pw63ZsaO0d02Pt36FbSJYrChGOqj5TayHx?=
 =?us-ascii?Q?i3c3mxi9oT9YLkDdftpSd6ukctNDth/wN/tUI8P/hv9228VNfDe7n/sYitUf?=
 =?us-ascii?Q?ZlQo/ZOb5WEMboA9lsTIxfM9JfQaZ2twNBUOQPy/xtsTbD11+lrtWgiz3xvN?=
 =?us-ascii?Q?Eo0qbGkykK0LsKb72ojLGqF13LtPNipWkqz+JG5EsmeenTvt8CwDgExwJTzx?=
 =?us-ascii?Q?ZPaolJyhztUusoBYkpP4V+9luLTjQt2IO0wkjGa6i6oO49Q/Oq3ZlmttwSQj?=
 =?us-ascii?Q?cWrst9U6m0CISU7LG9Sctfw1onk5dMf6JaYJgjI2ZBD0wJhqRS5E/1JfHH0L?=
 =?us-ascii?Q?K+ozheCjFld7l/zNCcpw5CuJS+Jk/7vP6+I/jKb7eO6xDDu1CvNFhHDRsAaq?=
 =?us-ascii?Q?fK2wf2pJUtuSaFq0PnobeBMVPNlOSdxdUCzhPdp2z2j00NfI5onof/cdcAcN?=
 =?us-ascii?Q?mSc+pKkpfqYAtqKQask69vWkhszqXcoHs+jNGr65M5MitFGsDztSVu4jHYm1?=
 =?us-ascii?Q?UuT6mp9240NPfm2On/lwM+j04/h0HV06xO6lncW3cSpqvgKudpXZ6b4+A0Pu?=
 =?us-ascii?Q?4gXCL/GzXpuAVgdaqCVGF8wODBrcKSs2FiWVkrVI3zbXQsco2RbqolpCzRJv?=
 =?us-ascii?Q?KIXZobDrJljS0cI+wy9P9+nA3pnXzSlOh+zA/E7SymPUXIzqk8/5eWOyos2B?=
 =?us-ascii?Q?i1Lz6p8WLVI8dwf9E4ibfyTlGHFoWWlhsah6hWEEYyrMi4HyAM1WZ3NVxnUE?=
 =?us-ascii?Q?/FvLwZzKcQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6087.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e59e58-cbd9-4a38-cd1d-08de88dee07e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 13:19:56.2996 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jfjCCk8kHYOWn61i4xJ+zUpXh1+fnRnnMvdtRGpr6CB9/Vv5STd1VuFqjNRvzLefotMgrfnXYOR3X+c2Zw6bEg==
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
> Subject: [PATCH v4 08/10] ethdev: add getter for per-queue Tx rate limit
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
> - Trace point matching the existing setter pattern
> - Generic testpmd command: show port <id> queue <id> rate
>=20
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> ---
>  app/test-pmd/cmdline.c           | 69 ++++++++++++++++++++++++++++++++
>  lib/ethdev/ethdev_driver.h       |  7 ++++
>  lib/ethdev/ethdev_trace.h        |  9 +++++
>  lib/ethdev/ethdev_trace_points.c |  3 ++
>  lib/ethdev/rte_ethdev.c          | 35 ++++++++++++++++
>  lib/ethdev/rte_ethdev.h          | 24 +++++++++++
>  6 files changed, 147 insertions(+)
>=20
> diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c index
> c5abeb5730..cc9c462498 100644
> --- a/app/test-pmd/cmdline.c
> +++ b/app/test-pmd/cmdline.c
> @@ -8982,6 +8982,74 @@ static cmdline_parse_inst_t cmd_queue_rate_limit
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
> @@ -14270,6 +14338,7 @@ static cmdline_parse_ctx_t builtin_ctx[] =3D {
>  	&cmd_set_uc_all_hash_filter,
>  	&cmd_vf_mac_addr_filter,
>  	&cmd_queue_rate_limit,
> +	&cmd_show_queue_rate_limit,
>  	&cmd_tunnel_udp_config,
>  	&cmd_showport_rss_hash,
>  	&cmd_showport_rss_hash_key,
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
> diff --git a/lib/ethdev/ethdev_trace.h b/lib/ethdev/ethdev_trace.h index
> 482befc209..6554cc1a21 100644
> --- a/lib/ethdev/ethdev_trace.h
> +++ b/lib/ethdev/ethdev_trace.h
> @@ -908,6 +908,15 @@ RTE_TRACE_POINT(
>  	rte_trace_point_emit_int(ret);
>  )
>=20
> +RTE_TRACE_POINT(
> +	rte_eth_trace_get_queue_rate_limit,
> +	RTE_TRACE_POINT_ARGS(uint16_t port_id, uint16_t queue_idx,
> +		int ret),
> +	rte_trace_point_emit_u16(port_id);
> +	rte_trace_point_emit_u16(queue_idx);
> +	rte_trace_point_emit_int(ret);
> +)
> +
>  RTE_TRACE_POINT(
>  	rte_eth_trace_rx_avail_thresh_set,
>  	RTE_TRACE_POINT_ARGS(uint16_t port_id, uint16_t queue_id, diff --
> git a/lib/ethdev/ethdev_trace_points.c b/lib/ethdev/ethdev_trace_points.c
> index 071c508327..0a28378a56 100644
> --- a/lib/ethdev/ethdev_trace_points.c
> +++ b/lib/ethdev/ethdev_trace_points.c
> @@ -347,6 +347,9 @@
> RTE_TRACE_POINT_REGISTER(rte_ethdev_trace_uc_all_hash_table_set,
>  RTE_TRACE_POINT_REGISTER(rte_eth_trace_set_queue_rate_limit,
>  	lib.ethdev.set_queue_rate_limit)
>=20
> +RTE_TRACE_POINT_REGISTER(rte_eth_trace_get_queue_rate_limit,
> +	lib.ethdev.get_queue_rate_limit)
> +
>  RTE_TRACE_POINT_REGISTER(rte_eth_trace_rx_avail_thresh_set,
>  	lib.ethdev.rx_avail_thresh_set)
>=20
> diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c index
> 2edc7a362e..5e763e1855 100644
> --- a/lib/ethdev/rte_ethdev.c
> +++ b/lib/ethdev/rte_ethdev.c
> @@ -5694,6 +5694,41 @@ int rte_eth_set_queue_rate_limit(uint16_t
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
> +	int ret;
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
> +	ret =3D eth_err(port_id,
> +		      dev->dev_ops->get_queue_rate_limit(dev, queue_idx,
> +							 tx_rate));
> +
> +	rte_eth_trace_get_queue_rate_limit(port_id, queue_idx, ret);
> +
> +	return ret;
> +}
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

