Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDFC1098797
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Mar 2026 15:38:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C40B402BB;
	Fri, 20 Mar 2026 16:38:33 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010010.outbound.protection.outlook.com [52.101.61.10])
 by mails.dpdk.org (Postfix) with ESMTP id 07814402B2
 for <dev@dpdk.org>; Fri, 20 Mar 2026 16:38:31 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oga+Z+A3eQFBdywFRCyd9ujLIXrtI16sQRD3eFT59a1Dks5zI8rmP0JdbJHfc9PmS7BMmsPgjZuk90trw1TaUeybvP79dE8b1i3THWDdwNLWkBkZm2eYsr0v+0KvgKyndSAU3j7Ll6qhLC4ZuEDgXu/rktDfDn2AHBsKnixnzC4LCO+k6A8egBtkF9ZwSXLTaWlYHxGuoPG6ycrz0gkuG/J+rZiLuXzN9gTALIgfpKsxOfWk+Grysmw5aKYj2xwlz9nEYnjCiES85MkvnTIsYx4s2zmZ51hSKBSG5kcszTB41k+Vs8ooNCXeAy1QvceqeNIHhkvO9oUX2ahyHjRVBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2XAVZgFdx51nKSS1pTzD5HnwFvoPAdYbu56b4myRKI=;
 b=QpkD4RrRd73PnQJrwUP+GvjzTegsstyDGglVALwZ59hGZoRzHh5/c+Gu83woUpNxx3OIMUZPFwXuD0Yx9XU3QuwZW5jMHyASEgH5WGXMPqMx0kktYHOU0HSfOvdxsMRGrhe0xMUi2rUejZZ/0zFxgWurmQSEjPwUOGkKcmg2MUB38UGsxDWoqr0TFCzBBap09AizumJOO+iU8zqJVS5P+dtJLB0URSxUWWlkaZcqaIr4SoquiDHZJ0a0O39122U4NOZzfmH0cZOkALTQxik7NFQ0bsjV6V/CnPzrK4zEGGoOsc/HIZXWlWxsouyOXOqyi4OcseKoNHpe6muCQYGxHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2XAVZgFdx51nKSS1pTzD5HnwFvoPAdYbu56b4myRKI=;
 b=KpAIEaf0HAYL0dNMQJNpowddMyy/wQU7NOREgM41XElFJKHwr0ZstFufjQGCqSWUaUefUNLhc70f+tVARbUE3Kwt5GQDIhS8GxGY3IA1PTjhHFlVpOUbDPDCj25za/9tjzsVEzW0SscZ4JOHFSTpxrxsnZ1W+kMn0EAiPGdDJxMFJZqwCzn5HJTfImGnoTlMthJNzyKa7e1Og+UdJf9tzzMvFNriJp3XC/Fg7wwgISrLPM/vNXKiw6aCzLf/f6uDEjwx8TydpMpO5p87RtpDf98i03sknycLN4cmZcoN3v7SOQ2QX7uiJef7Kd8QTM4TUrMruSCN17Vzpmaw/yPjpA==
Received: from DM4PR12MB6087.namprd12.prod.outlook.com (2603:10b6:8:b1::12) by
 DM4PR12MB6088.namprd12.prod.outlook.com (2603:10b6:8:af::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.13; Fri, 20 Mar 2026 15:38:26 +0000
Received: from DM4PR12MB6087.namprd12.prod.outlook.com
 ([fe80::3359:f44d:6814:3ec3]) by DM4PR12MB6087.namprd12.prod.outlook.com
 ([fe80::3359:f44d:6814:3ec3%4]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 15:38:26 +0000
From: Slava Ovsiienko <viacheslavo@nvidia.com>
To: Vincent Jardin <vjardin@free.fr>, "dev@dpdk.org" <dev@dpdk.org>
CC: Raslan Darawsheh <rasland@nvidia.com>, "NBU-Contact-Thomas Monjalon
 (EXTERNAL)" <thomas@monjalon.net>, "andrew.rybchenko@oktetlabs.ru"
 <andrew.rybchenko@oktetlabs.ru>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>
Subject: RE: [PATCH v3 07/9] net/mlx5: add testpmd command to query per-queue
 rate limit
Thread-Topic: [PATCH v3 07/9] net/mlx5: add testpmd command to query per-queue
 rate limit
Thread-Index: AQHcsmwLw1DY5HFyGUKOyaMJYGPDqbW3mTvA
Date: Fri, 20 Mar 2026 15:38:26 +0000
Message-ID: <DM4PR12MB608781EBBE46068C2163646BDF4CA@DM4PR12MB6087.namprd12.prod.outlook.com>
References: <20260310092014.2762894-1-vjardin@free.fr>
 <20260312220120.3256755-1-vjardin@free.fr>
 <20260312220120.3256755-8-vjardin@free.fr>
In-Reply-To: <20260312220120.3256755-8-vjardin@free.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6087:EE_|DM4PR12MB6088:EE_
x-ms-office365-filtering-correlation-id: c505012b-5101-4937-2e84-08de8696ba61
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|18002099003|22082099003|56012099003|15866825006|41080700001;
x-microsoft-antispam-message-info: T0a7IoVPfeMu+qRhIIsviDLbBESzHEEp5VuE2+ApM9PpPli3+GHQpED0HB/SOdw6X8d50P9H/ih3LX3q4RuBawRciEYCZCcZmXf1NCyqyunGVflXCljiSXGA3g+4A8vGs2POxYVxISznA7J2NX7u8W654YKp7QGO4vru5AhzcGNh/JQ4kf1vboO9Rl8QVyZMybr8kvH07fxZB7piYcfMqkA3T7R1NtuwqKeScSDfOE5Q0m3+NbfPQnC1V+23mjh6pxcXZvhEBctog2vEjV/Xk0U/TUL/LmvjZjSul6+Zmllthb3TJpgXdisd//ZbVJtUAUhxG3IsiYey+Eq38ReZvG06t2NyDEJ3e9Dpw/2ntC+RzVNpRVMdtyY9peYulHNCPKOeWpuaVLvH8QBvFph3SH2y+UuoXzn5oAB/8/8aecKkNodw3HK1kabU/H8fTnzWRqNuvt8/zphFheosQplxhH6HP5GkQ11b9tSalt6qI9CiM2OwLMMWr2g6clEo/wwyj6dqGz8q+dcT66/i40iaAuMxoZxAjqBC1xy64RVl+ri60dfZcMOUd5QPcHwixP94n9hd6dNK6MMYUNKKIW5l/GnNBrbEp7okvTVTWiHwwOFPnlR6onCyYQ7FLXJh1fGMNsbN7K1qZ+gt0DSGTAEmzofEvx4H5VBC9HILLidkqiox5IBpmcbBb+3z0N1icyF1thKzKsKlYxsNEbBB9kWZykew4WcMrDSEesCx6bXUxPrAI5li79otdhk1x5y2yX8DHDgvyXwWi16QWlNydKgtTWIS9SqFlLWetXvzOBDC7yB4uDRsvANsMsoaK2b8bzGmT4CHamj/A3tB7CheizvJs0fEJT4XrTQ+mMrq3oDvYec=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6087.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(56012099003)(15866825006)(41080700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ju7spBWKFaMZf68l7KunV68KhwCpQkAi18qH5lUvmQ3Igro1a/86yCf0jqZG?=
 =?us-ascii?Q?yMepYWSTWl4K1WvyXUUu/RCL+l9pSyfYWxdBVcmB3IFZ+EK9QVKolPd1lF8a?=
 =?us-ascii?Q?Iq583tyT0FREZMZUpB2CJai2b0iqHGbBjS9KtcRG0saZ7h5It486TXmqBrUk?=
 =?us-ascii?Q?iZWe6WSSCXZHj2BPtR03rWdPzrvFymY0w6LTCuLFt+i0lR8zoD18gJNgE/uV?=
 =?us-ascii?Q?VJHUkABzt6S4Kz1VNVItw4CsuV/cqst4VjmNZ/EjsWR7T9t+0rL7xAYT1Hio?=
 =?us-ascii?Q?xqR/m6YDAiTeNsFi9PrPTRVDu2e5wkxHoQv8a7C/xhSJPM+G0Fz5LP2Rg2nZ?=
 =?us-ascii?Q?BNj8w9L9n4yh+2Rj56WTFvfwqLgkpvS1UHjMPGc9P5BPPImPtJQWiaxpvhVw?=
 =?us-ascii?Q?HGmOKKj2RPvNgj1HY8a2Oyb6ffZgxpwqkGPnTK80QnLhaQ8WsS5rqYwcSfLP?=
 =?us-ascii?Q?11c9t+yO+NyTY0Qga6iIHFDqz9nodcsvSt9ztv7vdXOhntcIvAziz7LTqEu4?=
 =?us-ascii?Q?14R7bO25xJczpalF9Mfu6pQLvRKIEjTSqPvi8/nRo8AFd+I7XWqh5z8sJmB3?=
 =?us-ascii?Q?pFvjWDoUPijShVa3qVrq/OaPUSoGW4ReDNzNOf2h6wn2YqfUydKT2QfLdD1t?=
 =?us-ascii?Q?2uhVjHsE6+5xUMoVgXzpLRNKsbFMvg5dSkdOb3DYfIStS9yeimDqHE+cjoRk?=
 =?us-ascii?Q?4Yz3u06xtJ6Z+HQQ9cwCjMqdKOUUf7Wg3hqokv96JZ9QIsXDZ17aRQT/mPoQ?=
 =?us-ascii?Q?zYpFViXsmQE7MBaunuFMazB/RJNUqvu0x+WDhLhyhRrlZZ62rWh5Sv8gOGFF?=
 =?us-ascii?Q?bFwMEdAVbaQzWh4pmjLp+QJYakDQSAs9Z/I1bCKd7Yy8NlJHUSI4q3c1kQQo?=
 =?us-ascii?Q?ehEVEJnjR6eeZU1zX5/NF0xEA4GtaiOZWv6BSyvQw8vTUrZOiMYfOM8qMzHQ?=
 =?us-ascii?Q?D+TJrEFgV9219YsbUiWqrLEs0W6fnZ/z8740hH3k1sFKaVmWe8OT5hfIWdQZ?=
 =?us-ascii?Q?muXqHmzwoqVSVzq8sK44e5dbA0sqvwSVkvYxKUOlQE1j8SYi4FF+I9n8cPs6?=
 =?us-ascii?Q?pH2m1ptrSkoyWKERrYD6mxaqDbeX4XA82+yH2JPtR0eDsoc/Wks2zMbrQm0n?=
 =?us-ascii?Q?lKhjuWl9kXgQXh5RVrr3uE/+YjS4nREVPka3BYVMBvIP5zetc8YvcGSAGw8y?=
 =?us-ascii?Q?SVfTGbQA4S9iBuHSylj16tgecKNZ7Q6+3KBmTH78GlzgGa9/fFUqt4ic7Ip7?=
 =?us-ascii?Q?nCCuiRTOGqYdTYS7fG7Wm31lzhf6t/ijtv3zcu2GKfMTdx6ja2zpDVBxsMdd?=
 =?us-ascii?Q?yR+/Bi0XAmC1a3FJLCj/1L5uOSSzGRmjtX+GSGlc1KIiurkazO16cTCyym/s?=
 =?us-ascii?Q?8CKMDoR+7aYsSezlrWSUohlT0VWua/1prudtVOYZhWPlT1U3RdaRXBXQFfaC?=
 =?us-ascii?Q?8fyZmwmvgWxDWR0tEPSjZPBQwSf9awKmYO9Zij61YMt22Edth+DVf7zJd55p?=
 =?us-ascii?Q?7RikT9DrSk4wfMBK0ChUIlUwC+taJuAbzGJANeybWVL0PKgXNRkfERLjA5Bs?=
 =?us-ascii?Q?Sjvnqon4cfvqFYf4liE3b9m9YJZss2wck6/rApMy9mJWFscFsMAWxEKxhP6f?=
 =?us-ascii?Q?KNJTF4WkcTJorhjlQOW4BjS4VzAuAvb9VHY/nSYQLB47nkjG/cEbN75EG1K4?=
 =?us-ascii?Q?JZSBSr9vrqxKBWaFCzTcFYIxQ/DO921nn71/rcxehafXV0UJ36w9wq+UM96o?=
 =?us-ascii?Q?f4gD6iSaRQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6087.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c505012b-5101-4937-2e84-08de8696ba61
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 15:38:26.2355 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 30x1+totyZqUcUgqFBMHbdriDxw0sB9bNyXDHsQLv+x5nQi0OPYcvL8EXB9ZTfYFU6WTl57xFR9PQA2u7EHUig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6088
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

BTW, we have mlx5_tx_burst_mode_get(), all information about tx rate limit =
could be shown there.
(I do not insist on, JFYI).

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
> Subject: [PATCH v3 07/9] net/mlx5: add testpmd command to query per-queue
> rate limit
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
> txq_ctrl->rl for driver state and mlx5_devx_cmd_query_sq() for the FW
> packet_pacing_rate_limit_index field.
>=20
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> ---
>  drivers/net/mlx5/mlx5_testpmd.c | 93
> +++++++++++++++++++++++++++++++++
>  drivers/net/mlx5/mlx5_tx.c      | 40 +++++++++++++-
>  drivers/net/mlx5/mlx5_txq.c     | 19 +++++--
>  drivers/net/mlx5/rte_pmd_mlx5.h | 30 +++++++++++
>  4 files changed, 178 insertions(+), 4 deletions(-)
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
> 8085b5c306..fa57d3ef98 100644
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
> +	info->rate_mbps =3D txq_ctrl->rl.rate_mbps;
> +	info->pp_index =3D txq_ctrl->rl.pp_id;
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
> diff --git a/drivers/net/mlx5/mlx5_txq.c b/drivers/net/mlx5/mlx5_txq.c in=
dex
> f2ed2454a0..f0881f3560 100644
> --- a/drivers/net/mlx5/mlx5_txq.c
> +++ b/drivers/net/mlx5/mlx5_txq.c
> @@ -1406,7 +1406,20 @@ mlx5_set_queue_rate_limit(struct rte_eth_dev
> *dev, uint16_t queue_idx,
>  		rte_errno =3D EINVAL;
>  		return -rte_errno;
>  	}
> -	if (txq_ctrl->obj =3D=3D NULL || txq_ctrl->obj->sq =3D=3D NULL) {

Should this code be in the commit introducing mlx5_set_queue_rate_limit() ?

> +	if (txq_ctrl->obj =3D=3D NULL) {
> +		DRV_LOG(ERR, "Port %u Tx queue %u not initialized.",
> +			dev->data->port_id, queue_idx);
> +		rte_errno =3D EINVAL;
> +		return -rte_errno;
> +	}
> +	/*
> +	 * For non-hairpin queues the SQ DevX object lives in
> +	 * obj->sq_obj.sq (used by DevX/HWS mode), while hairpin
> +	 * queues use obj->sq directly.  These are different members
> +	 * of a union inside mlx5_txq_obj.
> +	 */
> +	struct mlx5_devx_obj *sq_devx =3D txq_ctrl->obj->sq_obj.sq;

Style nit - could you please mode variable declaration to the {-block begin=
ning ?

> +	if (sq_devx =3D=3D NULL) {
>  		DRV_LOG(ERR, "Port %u Tx queue %u SQ not ready.",
>  			dev->data->port_id, queue_idx);
>  		rte_errno =3D EINVAL;
> @@ -1420,7 +1433,7 @@ mlx5_set_queue_rate_limit(struct rte_eth_dev
> *dev, uint16_t queue_idx,
>  		sq_attr.state =3D MLX5_SQC_STATE_RDY;
>  		sq_attr.rl_update =3D 1;
>  		sq_attr.packet_pacing_rate_limit_index =3D 0;
> -		ret =3D mlx5_devx_cmd_modify_sq(txq_ctrl->obj->sq, &sq_attr);
> +		ret =3D mlx5_devx_cmd_modify_sq(sq_devx, &sq_attr);
>  		if (ret) {
>  			DRV_LOG(ERR,
>  				"Port %u Tx queue %u failed to clear rate.",
> @@ -1444,7 +1457,7 @@ mlx5_set_queue_rate_limit(struct rte_eth_dev
> *dev, uint16_t queue_idx,
>  	sq_attr.state =3D MLX5_SQC_STATE_RDY;
>  	sq_attr.rl_update =3D 1;
>  	sq_attr.packet_pacing_rate_limit_index =3D new_rl.pp_id;
> -	ret =3D mlx5_devx_cmd_modify_sq(txq_ctrl->obj->sq, &sq_attr);
> +	ret =3D mlx5_devx_cmd_modify_sq(sq_devx, &sq_attr);
>  	if (ret) {
>  		DRV_LOG(ERR, "Port %u Tx queue %u failed to set rate %u
> Mbps.",
>  			dev->data->port_id, queue_idx, tx_rate); diff --git
> a/drivers/net/mlx5/rte_pmd_mlx5.h b/drivers/net/mlx5/rte_pmd_mlx5.h index
> 7acfdae97d..698d7d2032 100644
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
With best regards,
Slava
