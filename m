Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57831098799
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Mar 2026 15:19:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90413402BB;
	Fri, 20 Mar 2026 16:19:51 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010067.outbound.protection.outlook.com [52.101.61.67])
 by mails.dpdk.org (Postfix) with ESMTP id D3466402B2
 for <dev@dpdk.org>; Fri, 20 Mar 2026 16:19:49 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hYS8QBuSUWKG3ihTR52H0mghWYuKT//Z6CSpPtSWyZD/i3qZIW5BIhEl2u0MC7l/Tx9PYrgKhHh6KqE4sR+hkcE6BFrHbjzMMsjhR+mhr37s4soNC9+d3Qg00UgGmH5uxA6vSkzMM6cQQw+k6kP/oKb4vAKrrLZzah5AGJNPwQtSRqrl7nFe13yYJiZmROREmsyXztEe2iJoR22aL21arAkwXiCBwxPyLRjUzJzR8rMsxLj5IEGeRPdKFWp7oGg/8pnuCWICrLK8irnmllO1SwQQ6Kg29eZYa7OywG48D+6XwbuWvBa7MXsBe1ra7fdMBVWaY/GsNgHN9FA3m6EJEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szfT+SvVsW4KP004SxjuRoApYp5Ikwn2jlG/jZzWINU=;
 b=vUXqHmo22xO09raSHZ6L7QJksC6jSEfx6W+PUxk4mzUrzULTb25lAGt00t+bXI6SiF0TMxPJ5lnhQ1mvwmcZtM+vsfpH0WIrBr9LUexfdBIrd9sq0v2exnVMTGXJfmi5WPcTp/KW03WUn/wDRC3zYM2I2RYUmP2pxhRWXrHbTErcAL5OK2Vm8/gEflVCkHucCmrYSzk92Ytw9Auj+prvd8JQRf1QVAufc6HViM7odMbROPuPXxb2aTpBb57T+5w7acjeyk/6b0AUXzSb0tLh5ypAlDwqvNue60P0IHjwY406jVh9m3zCR6CRg8L2lI1apddtd4iFWpYv+Tr4svb6mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szfT+SvVsW4KP004SxjuRoApYp5Ikwn2jlG/jZzWINU=;
 b=RnsKatYCb2BI6/kHhZgQLNZuUL5QPwbHFlbHDWroM/JmRVwwwv7cgWUBBp7MWHLpvE1fH6VpY6lOcAypa/rWJF4TUY1w1I0YcEkAxSwsFkrQmLI0kozyUEw9D3rMojxl59d7qaVrtmiNA1MPAZAoUdw6/CNQeP6758ODRj4YnnFdF9uyNld6YKhCy++6OILuFWOylwUL1BhL6KO4wmxfiCsxb4ImWoXgf207pnTXIPbfUeZDYvjkmOyY9oIz2VNHwvjep/jh9L3sqavgGdaHo7Fj2jbw7QB3jin3u2X897wCfmUzPGU3k6i+zM24dhSFsZWZe6AXmjc4HnYhN6kK3Q==
Received: from DM4PR12MB6087.namprd12.prod.outlook.com (2603:10b6:8:b1::12) by
 SJ2PR12MB7943.namprd12.prod.outlook.com (2603:10b6:a03:4c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 15:19:43 +0000
Received: from DM4PR12MB6087.namprd12.prod.outlook.com
 ([fe80::3359:f44d:6814:3ec3]) by DM4PR12MB6087.namprd12.prod.outlook.com
 ([fe80::3359:f44d:6814:3ec3%4]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 15:19:43 +0000
From: Slava Ovsiienko <viacheslavo@nvidia.com>
To: Vincent Jardin <vjardin@free.fr>, "dev@dpdk.org" <dev@dpdk.org>
CC: Raslan Darawsheh <rasland@nvidia.com>, "NBU-Contact-Thomas Monjalon
 (EXTERNAL)" <thomas@monjalon.net>, "andrew.rybchenko@oktetlabs.ru"
 <andrew.rybchenko@oktetlabs.ru>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>
Subject: RE: [PATCH v3 06/9] net/mlx5: add burst pacing devargs
Thread-Topic: [PATCH v3 06/9] net/mlx5: add burst pacing devargs
Thread-Index: AQHcsmwGRut8auL0qkizfpFd+gdkZrW3k9aA
Date: Fri, 20 Mar 2026 15:19:43 +0000
Message-ID: <DM4PR12MB6087AC5B81D0215F98CAE158DF4CA@DM4PR12MB6087.namprd12.prod.outlook.com>
References: <20260310092014.2762894-1-vjardin@free.fr>
 <20260312220120.3256755-1-vjardin@free.fr>
 <20260312220120.3256755-7-vjardin@free.fr>
In-Reply-To: <20260312220120.3256755-7-vjardin@free.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6087:EE_|SJ2PR12MB7943:EE_
x-ms-office365-filtering-correlation-id: 04c6298c-30c1-40ae-e2f1-08de86941ce1
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|18002099003|56012099003|22082099003|41080700001|15866825006;
x-microsoft-antispam-message-info: 5NY2IGc+aRw9jOzkAiYRoTWXUDdHGXNtoxT5NJ7zUftLjgafQP5AbwVrKAC2kefzl9+l1O1QhJMoWe4ahLmgni9f1kPENBdgE+dw/ZkPyCgMVSyqZ8ioAolT9kAHS3cX9Hhpyl6mmcQF42AGV5/B4vxFsb6tYN5RBsdZYhZ3ApKpZU6hApC4lqTQfTcAf4LVUBeK848knWBDMBghhrifLwUQZ4tgd8CUqyjaRjExwcr/nEN2RxNs4yucRjMdCSLd+ESUB4k/NfuW4DSfZvLzgKU4LZWHgeYadezQDv3lReOMTa1u6idwIetZ7QQ/7beoEu3jXm572AlZXnGORXqGWTUdQqkS2pCP540aU5rsluOBv44ghUgb1/eBufXEUjkQ+E7oHqOyfD2szD9ovLWHtaZfiNVgqrGoNw2RPSAPcGNQaB13WwP4GNtROTNNbtSo99kd4ieYwGnOkFfz8++pQEZRbJ1vgbAUTpabljCxL7jL3dWkOR4/5KxCinY5adTEpfE9aMepM8nMXve0R6XdVA5mH4vhymbIV77yF2KRkCH3wbNdS/Heia8TVsjk1UybxtChpfhJg8vXTmBfWOcZfPcQtbxCTZlMDRLvY478hL+aKYzNw080ahrKpLFGNuq52ocoHIuSiIxnK4R5EQ0w8HwyKztffQ03n7OXtYycCVJvYpVznJW4CKaMfSPoWwhw5nDas5rG7Nd90HRDrDCK0oXI0Gt7ng0K78fHuxRi8OHi18P781x+obVRCC/6hielL13TQhlAvJcpIJc3p/KO15aPeofwOcQn3mSnirXj94yAxfc5B6oEl58B4LNHpnWwIayUoPjLQ5tPfuOmK+Z0zQ3GOQ+7ZGkSlahT1jXmow8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6087.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(56012099003)(22082099003)(41080700001)(15866825006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YSH6uyiiv8oxkTRlFPUMC51b1EhiOkkXECpSGOIlldHUvMFnGwDqtuWuZ09U?=
 =?us-ascii?Q?fd/LVEUhlkTvaQ4IBj0ZN8K7TpuTqlLwPPZcMm+MR+0AY3J/0KhkDPGtdpcU?=
 =?us-ascii?Q?krybdAEBDq+plfemiGojcPd/K0fOUg3croBbLsY8LkCX1eXydrkvcW6qZxAk?=
 =?us-ascii?Q?Sb2HX8tbcSzO90bDknLrLjdqtUyEPRAuVgtzcj+1eyfj/j0c02+lBjqTZbny?=
 =?us-ascii?Q?RRzeijNEAOZ3b0QQrNECBTLC/QlxiBTJd0NynzUNs4jzT9AYvrL1WRW07rU/?=
 =?us-ascii?Q?xQBqnLNmT+V6DO2CoXXyRx+MvRHaOeVIhBNGxXJieZlZ0JJV+zxVRXO1K7hx?=
 =?us-ascii?Q?nAmOGKnmicqb1GEdp7cdQra4ICUbyUnEJOzSh3uBq6EvIHIXY13kZMabzvf+?=
 =?us-ascii?Q?ykweuzgGbxUPNtu5ynghGEYoch1OzZubADdNlKhj+VlMPDlfsk6gKnK0e76p?=
 =?us-ascii?Q?dQHHIG6vMbN3R9vwxpZMD+C4C1oD8/9LI8X8GQrP1T6f54tvnNMw0Jg25t9i?=
 =?us-ascii?Q?YoXEqxERe1TQ7SlXKfEyo1UOjNYmsBGo78knzjCggTmYRbTKcxYp20N4ojm7?=
 =?us-ascii?Q?BlbFkSgmA3JdM1vNizeb67slPOUHrFQc4rhQ6ytlApo0474R8OoteCmBjfAu?=
 =?us-ascii?Q?D3ynz5saD2LEuvXWE6wxdTSKUtrZj6ZCXIGJSIbeiZTCwLoxPSD2xqOHUCWE?=
 =?us-ascii?Q?qLSCazK/2uwoUXvhuF6kv9HY8wWtl3rhN2C1ItPaBwNYpwLmmxv//EUVfl3N?=
 =?us-ascii?Q?2e9zK3CEGauq1mn7Nz4DNERcES8n1yXWVCqu9MHPVsbNLcWOq13d6ZNwyWlK?=
 =?us-ascii?Q?vVh2S43v3DMSqgH9fo2FSCC7Mo8p4NsIGvOqdyjEcaL5p1TCloKq3uGYA5Ob?=
 =?us-ascii?Q?0kPI/VAwPB9aHXwqNVX+ynQkbTo+YvT2Gbhdyf+7VLi28yTYbEOM+5A2zyLD?=
 =?us-ascii?Q?BOREY6WWpH9WSps5356fM5tbC/Q833EAzhorcmyJDD/I+e2yEJ6M34Ke8S6p?=
 =?us-ascii?Q?6rcUC4nbGHZwi/ao0TNPgP1o1PRev55njttKI7iVBlTp3tMlyn330eHENw+r?=
 =?us-ascii?Q?jG0hzI4GIv0EOHTxAOrqguulGlXZj0cZ2zfuwHhVJuUWp0+VHZPc3HnIUkO7?=
 =?us-ascii?Q?L+xRgrhRCjh1ocdtNRIDnspqtKrzebVDW9W7dppS/zf0T+euJHscargW7SDG?=
 =?us-ascii?Q?q+xRSC4BhV326WeVBohzohGEamczhKGoBUITsAoHfdydwQIQl7ct4NX4/A4C?=
 =?us-ascii?Q?Wd3381JjVqpb0fEg03mYIAY55KWmV/swjTdSFzwDUft+CX0Z+xL46XZWYlgM?=
 =?us-ascii?Q?SWyJewGFGl+V+OolSnx+9YB2gLvI8krKHkZUtiy2w8FiqB2x5RweEAuwm08l?=
 =?us-ascii?Q?/ZYPhZNjOAn1el3XwXpsMgRMLwJqHgFOzm79pmjteBJabMkZotZgqCYhBNEo?=
 =?us-ascii?Q?Zuf/aNZXnOLGnhnuiLKuHnh8qODG7nYK3+uKYNkCMmA56WTp1OnQp1XjF2Po?=
 =?us-ascii?Q?rzIxZRYExCQ6HSlvD3+FtE8G0JuFaK9ciBVejeeHIVZ0XvE7geAHV1SCTaRN?=
 =?us-ascii?Q?N4O3rh+jcR5EqvRUs/7Ik20LBrtlsanidiemC6v7kpHZ1d92jE9f47ECCW9H?=
 =?us-ascii?Q?TFNQQmyo4MjA4246BEc+vIP8it0QWIeBVzzQlsX1Mvb/9sVhk+KHZT/osi3d?=
 =?us-ascii?Q?nh54uxdAA6JM1Rq/tthtbN5m090Z2KiFl8dxLNy2h2g3hafHQ3W2QYPCVePm?=
 =?us-ascii?Q?ylBO2sGZqg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6087.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c6298c-30c1-40ae-e2f1-08de86941ce1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 15:19:43.0695 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q4EfAjE983se7aq4Elx6JPVXFpC+zfwODY5awmYLUUEwKuvXSfMBgqbuOYaLyeiIYABalbGRqvZk2y4T6QCNPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7943
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
> Subject: [PATCH v3 06/9] net/mlx5: add burst pacing devargs
>=20
> Expose burst_upper_bound and typical_packet_size from the PRM
> set_pp_rate_limit_context as devargs:
> - tx_burst_bound=3D<bytes>: max burst before rate evaluation kicks in
> - tx_typical_pkt_sz=3D<bytes>: typical packet size for accuracy
>=20
> These parameters apply to both per-queue rate limiting
> (rte_eth_set_queue_rate_limit) and Clock Queue pacing (tx_pp).

Clock Queue is special facility to overcome ConnectX-6DX hardware limitatio=
ns
and handle send scheduling. It uses WQE rate pacing and doe not need=20
the tx_burst_bound and tx_typical_pkt_sz be set. Please update the commit
message and remove update of mlx5_txpp_alloc_pp_index().

>=20
> Values are validated against HCA capabilities (packet_pacing_burst_bound =
and
> packet_pacing_typical_size).
> If the HW does not support them, a warning is logged and the value is sil=
ently
> zeroed. Test mode still overrides both values.
>=20
> Shared context mismatch checks ensure all ports on the same device use th=
e
> same burst parameters.
>=20
> Supported hardware:
> - ConnectX-6 Dx: burst_upper_bound and typical_packet_size
>   reported via packet_pacing_burst_bound / packet_pacing_typical_size
>   QoS capability bits
> - ConnectX-7/8: full support for both parameters
> - BlueField-2/3: same capabilities as host-side ConnectX
>=20
> Not supported:
> - ConnectX-5: may not report burst_bound or typical_size caps
> - ConnectX-4 Lx and earlier: no packet_pacing at all
>=20
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> ---
>  doc/guides/nics/mlx5.rst     | 16 ++++++++++++++
>  drivers/net/mlx5/mlx5.c      | 42 ++++++++++++++++++++++++++++++++++++
>  drivers/net/mlx5/mlx5.h      |  2 ++
>  drivers/net/mlx5/mlx5_txpp.c | 12 +++++++++++
>  4 files changed, 72 insertions(+)
>=20
> diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst index
> 5b097dbc90..2507fae846 100644
> --- a/doc/guides/nics/mlx5.rst
> +++ b/doc/guides/nics/mlx5.rst
> @@ -580,6 +580,22 @@ for an additional list of options shared with other
> mlx5 drivers.
>    (with ``tx_pp``) and ConnectX-7+ (wait-on-time) scheduling modes.
>    The default value is zero.
>=20
> +- ``tx_burst_bound`` parameter [int]
> +
> +  Specifies the burst upper bound in bytes for packet pacing rate evalua=
tion.
> +  When set, the hardware considers this burst size when enforcing the
> + configured  rate limit. Only effective when the HCA reports
> + ``packet_pacing_burst_bound``  capability. Applies to both per-queue
> + rate limiting
> +  (``rte_eth_set_queue_rate_limit()``) and Clock Queue pacing (``tx_pp``=
).
> +  The default value is zero (hardware default).
> +
> +- ``tx_typical_pkt_sz`` parameter [int]
> +
> +  Specifies the typical packet size in bytes for packet pacing rate
> + accuracy  improvement. Only effective when the HCA reports
> + ``packet_pacing_typical_size`` capability. Applies to both per-queue
> + rate  limiting and Clock Queue pacing. The default value is zero (hardw=
are
> default).
> +
>  - ``tx_vec_en`` parameter [int]
>=20
>    A nonzero value enables Tx vector with ConnectX-5 NICs and above.
> diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c index
> c390406ac7..f399e0d5c9 100644
> --- a/drivers/net/mlx5/mlx5.c
> +++ b/drivers/net/mlx5/mlx5.c
> @@ -119,6 +119,18 @@
>   */
>  #define MLX5_TX_SKEW "tx_skew"
>=20
> +/*
> + * Device parameter to specify burst upper bound in bytes
> + * for packet pacing rate evaluation.
> + */
> +#define MLX5_TX_BURST_BOUND "tx_burst_bound"
> +
> +/*
> + * Device parameter to specify typical packet size in bytes
> + * for packet pacing rate accuracy improvement.
> + */
> +#define MLX5_TX_TYPICAL_PKT_SZ "tx_typical_pkt_sz"
> +
>  /*
>   * Device parameter to enable hardware Tx vector.
>   * Deprecated, ignored (no vectorized Tx routines anymore).
> @@ -1405,6 +1417,10 @@ mlx5_dev_args_check_handler(const char *key,
> const char *val, void *opaque)
>  		config->tx_pp =3D tmp;
>  	} else if (strcmp(MLX5_TX_SKEW, key) =3D=3D 0) {
>  		config->tx_skew =3D tmp;
> +	} else if (strcmp(MLX5_TX_BURST_BOUND, key) =3D=3D 0) {
> +		config->tx_burst_bound =3D tmp;
> +	} else if (strcmp(MLX5_TX_TYPICAL_PKT_SZ, key) =3D=3D 0) {
> +		config->tx_typical_pkt_sz =3D tmp;
>  	} else if (strcmp(MLX5_L3_VXLAN_EN, key) =3D=3D 0) {
>  		config->l3_vxlan_en =3D !!tmp;
>  	} else if (strcmp(MLX5_VF_NL_EN, key) =3D=3D 0) { @@ -1518,8 +1534,10
> @@ mlx5_shared_dev_ctx_args_config(struct mlx5_dev_ctx_shared *sh,
>  				struct mlx5_sh_config *config)
>  {
>  	const char **params =3D (const char *[]){
> +		MLX5_TX_BURST_BOUND,
>  		MLX5_TX_PP,
>  		MLX5_TX_SKEW,
> +		MLX5_TX_TYPICAL_PKT_SZ,
>  		MLX5_L3_VXLAN_EN,
>  		MLX5_VF_NL_EN,
>  		MLX5_DV_ESW_EN,
> @@ -1626,6 +1644,18 @@ mlx5_shared_dev_ctx_args_config(struct
> mlx5_dev_ctx_shared *sh,
>  		DRV_LOG(WARNING,
>  			"\"tx_skew\" doesn't affect without \"tx_pp\".");
>  	}
> +	if (config->tx_burst_bound &&
> +	    !sh->cdev->config.hca_attr.qos.packet_pacing_burst_bound) {
> +		DRV_LOG(WARNING,
> +			"HW does not support burst_upper_bound,
> ignoring.");
> +		config->tx_burst_bound =3D 0;
> +	}
> +	if (config->tx_typical_pkt_sz &&
> +	    !sh->cdev->config.hca_attr.qos.packet_pacing_typical_size) {
> +		DRV_LOG(WARNING,
> +			"HW does not support typical_packet_size, ignoring.");
> +		config->tx_typical_pkt_sz =3D 0;
> +	}
>  	/* Check for LRO support. */
>  	if (mlx5_devx_obj_ops_en(sh) && sh->cdev->config.hca_attr.lro_cap) {
>  		/* TBD check tunnel lro caps. */
> @@ -3260,6 +3290,18 @@ mlx5_probe_again_args_validate(struct
> mlx5_common_device *cdev,
>  			sh->ibdev_name);
>  		goto error;
>  	}
> +	if (sh->config.tx_burst_bound !=3D config->tx_burst_bound) {
> +		DRV_LOG(ERR, "\"tx_burst_bound\" "
> +			"configuration mismatch for shared %s context.",
> +			sh->ibdev_name);
> +		goto error;
> +	}
> +	if (sh->config.tx_typical_pkt_sz !=3D config->tx_typical_pkt_sz) {
> +		DRV_LOG(ERR, "\"tx_typical_pkt_sz\" "
> +			"configuration mismatch for shared %s context.",
> +			sh->ibdev_name);
> +		goto error;
> +	}
>  	if (sh->config.txq_mem_algn !=3D config->txq_mem_algn) {
>  		DRV_LOG(ERR, "\"TxQ memory alignment\" "
>  			"configuration mismatch for shared %s context. %u -
> %u", diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h index
> c48c3072d1..a8d71482ac 100644
> --- a/drivers/net/mlx5/mlx5.h
> +++ b/drivers/net/mlx5/mlx5.h
> @@ -382,6 +382,8 @@ struct mlx5_port_config {  struct mlx5_sh_config {
>  	int tx_pp; /* Timestamp scheduling granularity in nanoseconds. */
>  	int tx_skew; /* Tx scheduling skew between WQE and data on wire. */
> +	uint32_t tx_burst_bound; /* Burst upper bound in bytes, 0 =3D default. =
*/
> +	uint32_t tx_typical_pkt_sz; /* Typical packet size in bytes, 0 =3D
> +default. */
>  	uint32_t reclaim_mode:2; /* Memory reclaim mode. */
>  	uint32_t dv_esw_en:1; /* Enable E-Switch DV flow. */
>  	/* Enable DV flow. 1 means SW steering, 2 means HW steering. */ diff --
> git a/drivers/net/mlx5/mlx5_txpp.c b/drivers/net/mlx5/mlx5_txpp.c index
> 0a883b0a94..756a772cc5 100644
> --- a/drivers/net/mlx5/mlx5_txpp.c
> +++ b/drivers/net/mlx5/mlx5_txpp.c

Please remove the diffs from mlx5_txpp_alloc_pp_index().

> @@ -88,6 +88,12 @@ mlx5_txpp_alloc_pp_index(struct mlx5_dev_ctx_shared
> *sh)
>  	rate =3D NS_PER_S / sh->txpp.tick;
>  	if (rate * sh->txpp.tick !=3D NS_PER_S)
>  		DRV_LOG(WARNING, "Packet pacing frequency is not
> precise.");
> +	if (sh->config.tx_burst_bound)
> +		MLX5_SET(set_pp_rate_limit_context, &pp,
> +			 burst_upper_bound, sh->config.tx_burst_bound);
> +	if (sh->config.tx_typical_pkt_sz)
> +		MLX5_SET(set_pp_rate_limit_context, &pp,
> +			 typical_packet_size, sh->config.tx_typical_pkt_sz);
>  	if (sh->txpp.test) {
>  		uint32_t len;
>=20
> @@ -172,6 +178,12 @@ mlx5_txq_alloc_pp_rate_limit(struct
> mlx5_dev_ctx_shared *sh,
>  	memset(&pp, 0, sizeof(pp));
>  	MLX5_SET(set_pp_rate_limit_context, &pp, rate_limit,
> (uint32_t)rate_kbps);
>  	MLX5_SET(set_pp_rate_limit_context, &pp, rate_mode,
> MLX5_DATA_RATE);
> +	if (sh->config.tx_burst_bound)
> +		MLX5_SET(set_pp_rate_limit_context, &pp,
> +			 burst_upper_bound, sh->config.tx_burst_bound);
> +	if (sh->config.tx_typical_pkt_sz)
> +		MLX5_SET(set_pp_rate_limit_context, &pp,
> +			 typical_packet_size, sh->config.tx_typical_pkt_sz);
>  	rl->pp =3D mlx5_glue->dv_alloc_pp(sh->cdev->ctx, sizeof(pp), &pp, 0);
>  	if (rl->pp =3D=3D NULL) {
>  		DRV_LOG(ERR, "Failed to allocate PP index for rate %u Mbps.",
> --
> 2.43.0

With best regards,
Slava

