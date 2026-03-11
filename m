Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8258106288B
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Mar 2026 12:26:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 097C34067C;
	Wed, 11 Mar 2026 13:26:12 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013025.outbound.protection.outlook.com
 [40.93.196.25]) by mails.dpdk.org (Postfix) with ESMTP id E0C16402B8
 for <dev@dpdk.org>; Wed, 11 Mar 2026 13:26:10 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=puiWBsl07V9xbnAAtDZWZsMpHr/YXKD7XyhrYRaTlW5hH7SV5cU0sN6ZixCNhiglVwjZ0sO8O8PvDlHsfZClZu8SutUDNM3cy1QhAFb6t4a1Hzs622ITKDB7wbx8tQVkmg3/09noQ6AqfIl0uk929SjP0+fmbJloTVVG/GxW4rvWGZFVNg2SbnAlKKFZdwdblh8nd1qN+gAvQQ96Js+ZL1YRPw94NjU40J6cuqyhL31haVv+rfyq9mZGnaEX14xo95BKgUh5J89yj/mnskSUenqq/F+9tkLZYAzptl1f2TyEw23crZtzn55/2XXf6ZisgC/0q6h38pv68d0TlryMcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HzZsPb/W5MQ/TqapBPubQx6ltN9P8kxkKHlDXkMFSAA=;
 b=iaG5YbkPLQG1yzXrvKFyMT1m7qCXbLV+JQhp3cFDL3zPPe2pMgclKD5nUP7Qcx7tEJrlLKM0oOPYPA/uN7Cf17oI+0Jtljgm5yR6BLDCQTa05a2UxWV/L7Pv/y9MTtPwE1ZV0deG+mB2Mtj0gZjJu/gHLNLWsOgNyBuevtESzl3LrPOoB79l3WzuPO89vwm3HMmU8SyxajMbRXH0FR0+dTz0wi7drcUH2yHjBr0RNXXN26ckb3/FUQEo0nneetldvQGEad7MFFEdBdmUdIYBDcp6iwVWQkPUc/HBJtQTfQYA5rxU9GyiKJeTIR5ES+4TbKFFON5bYLPadbbQub+DuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzZsPb/W5MQ/TqapBPubQx6ltN9P8kxkKHlDXkMFSAA=;
 b=WuQSR/NCbZ70J/hY350oKMg8ZX8RlrxLLkQriCayXr6Pxxj5hFgJ4/XUv3/D8lwrWjrYRQ0oqIxI0uRruwefBX0+fPcJZbHgsumI26CvRWO19xU4QJpFCNdMJEZCvly/vsgRZZ45d4U7URiVE80VGIbQ+JhiOgIMp83cwF1Z3XLwuvKSq0sOgZyO8059oRPXBg772ezuUNZKnIHzu2Uvahf0JIe5sA5SrzChZQt8RHn9RTJFMEseRn4R2DAzUEAy6ZLKyy5/VuSJ05eKsaHg/oDotWA+irYtryR7ZCV2O2lHt+A49dJsqSYwLvKWDavLRjfdIFo/U159JUY+tbYZjA==
Received: from CY5PR12MB6084.namprd12.prod.outlook.com (2603:10b6:930:28::7)
 by SJ5PPFB332093D3.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::99f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 12:26:03 +0000
Received: from CY5PR12MB6084.namprd12.prod.outlook.com
 ([fe80::8d8b:f0b0:1a28:6ba3]) by CY5PR12MB6084.namprd12.prod.outlook.com
 ([fe80::8d8b:f0b0:1a28:6ba3%7]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 12:26:03 +0000
From: Slava Ovsiienko <viacheslavo@nvidia.com>
To: Vincent Jardin <vjardin@free.fr>, "dev@dpdk.org" <dev@dpdk.org>
CC: Raslan Darawsheh <rasland@nvidia.com>, "NBU-Contact-Thomas Monjalon
 (EXTERNAL)" <thomas@monjalon.net>, "andrew.rybchenko@oktetlabs.ru"
 <andrew.rybchenko@oktetlabs.ru>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: RE: [PATCH v1 01/10] doc/nics/mlx5: fix stale packet pacing
 documentation
Thread-Topic: [PATCH v1 01/10] doc/nics/mlx5: fix stale packet pacing
 documentation
Thread-Index: AQHcsG83xyx0qEDAM0eyBBKBDam8ArWpQ1XA
Date: Wed, 11 Mar 2026 12:26:02 +0000
Message-ID: <CY5PR12MB6084DAD339FFFCF3DDA14336DF47A@CY5PR12MB6084.namprd12.prod.outlook.com>
References: <20260310092014.2762894-1-vjardin@free.fr>
 <20260310092014.2762894-2-vjardin@free.fr>
In-Reply-To: <20260310092014.2762894-2-vjardin@free.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6084:EE_|SJ5PPFB332093D3:EE_
x-ms-office365-filtering-correlation-id: 159ea985-f4b3-43c9-d59b-08de7f695c47
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003|38070700021|15866825006|41080700001;
x-microsoft-antispam-message-info: 7ZXI1CBKU8SWK8XRhcS7FAqCItC8MWoXdKfIL6sm7XRbiwT618GAziACiAl3/DpkTefhC5/UM3v57ATqwtzM0n5zEbqGG8cdLNnAgrXHcTLu6ds+OT05STbUuBRjg/4/8dDjuBw0AnwPOd4k+j/GYeZa0TpJz8nm9Lu0ZQiASNan35sdyP1T4sGScCEq/k+iqohkRPFEx4wZxGUNOEkRv6smMMadkJZe9txnaLPhHL40SayA8R1EjcWBH7Af6+6qXUQlGK5ppCXUxpDWMNLlrkfoCV1xiEBlSOkXd66VurFN/BxbHFxLLAJz6DbQfsLtBBcYldKO5hvCP/4HEwSx9TmWvR30cdZKhfejf9TlB1NOKrKvHK6wM3WzOK3KlyQTNeyr191oabKOQmZqt/kRdtrlgg0Iy55r3rxlc2imKxZZbdVwTaHgc7tcDdBHTeh7Ug53rZR/64kVAr+9glBw+hJ9EzYkOvWU6B/UFLRQlq2ejhn0IKenkHCtVonohFAwQ1vV0f7BqWM4rYdarUCKPKGz8g5OwlvVlvSOHyqUzKeXdWQ/55jfG0iLnt+KPaw1POenowRtPZAJqqt3YicswZdzSzO/F7CS1cCJHv8WK5J3KMlYq6vA/rMYyZshJO76AXlETYA07PUzhy0/R/RJY3EoYZp6004mDc6/rrYA0NesMXzN4C0XrvWGZFgEf+0H7iavWG1iWjS/bb326cPsvmgBTbDbHTJtE8UnOdR1YhxvJUITe0e7mDWtfvzRLzRQrdY6T2rkoT57mJkd+MGG8kerh5Eaz9pK5ELuMg/2oSYyafpEmAzaYvtWEFMDqUW82JNYTmKfDalAKHA0Uq7X7xpC/v8i+X0zIHNlm6uuXQo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6084.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003)(38070700021)(15866825006)(41080700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ao4nYz7g/adMcGiQJOrhLww8JFYGHjlro8swRYNi7LJoqp5ailCNLVKoJOLS?=
 =?us-ascii?Q?XTC3Gu4ppzrTqPFPZNQDrdL2GI448eILtTk9MeikdPgXp0fMECyqVPyV29iB?=
 =?us-ascii?Q?pCHmVV33QH8vYcBoq3LvxX4TBwh1ehJP0FIKlIsU1bJn/3zD2DNRk4HJn23E?=
 =?us-ascii?Q?pUIOsXf4zeCW0eKAB1WbybkOWlkSuPDISgNc9524UlJtvPNwJAApAk2hckVw?=
 =?us-ascii?Q?r5MXshz6a1n2sTu5XF1h4BuNbJ5/tTFRY/FrN1QNLlLBlp7GYY4meJFgMY1x?=
 =?us-ascii?Q?nq7skhBkU6jzDantpawgdEX0i3+b5iLBF2fbJgOavuW0qjjp9awEXhgg/lS/?=
 =?us-ascii?Q?il4wA48wfftI9XadQUjE4KMhgkinQF8ifRlpu2xo+BiyTuKJyVfl6BW+rZ9I?=
 =?us-ascii?Q?wAc3TCTqUsmRYadfzRKYFwK8ZTB74YWAQyxxnn9l2DgnJVVW3EEPd1jXSwOf?=
 =?us-ascii?Q?FrXFr2SN2ExrAirsz1VlgfMnxMkQ5gfzKJeAF4nuUSIuvGZiEN+Xi3x8etiL?=
 =?us-ascii?Q?9st2xKxuuV0TyctOEsRrkUXv/70Rg8LnSSyBF3mAoyB+8aQ1RBM0eZHRqWwE?=
 =?us-ascii?Q?uHBtS+KqMZNx5vTEZOZqc06gyobU/pfPhyfzDy1p74cnvj9moa79i1Hzh4wt?=
 =?us-ascii?Q?dytyUdJagtxbH8+g24lsN/4Uku4jldMK0zWaIFyRXzjG0I87Qc7nMOVipyDm?=
 =?us-ascii?Q?l0tl4FL2dAWezupwAaIK7xY/nATyIVrt7CaPJ7ozUmzecDqDYJRkgRYu1SBJ?=
 =?us-ascii?Q?MZWpKXyHCIezI114XlJUDuByqU+MJHWy5/xTxX4yU4UTXF3bUvAqEEnqzCyo?=
 =?us-ascii?Q?rTREFQC0YUaMqKoolgYf+h21CYke4CiYAHccMoGibGXV37q1VrFrsz7i64Sf?=
 =?us-ascii?Q?y6+xAWmoVbVnI4AM1S2C+zkP0LyUzpvaBhtDQYB23alalaQpn5WU/AQN5gni?=
 =?us-ascii?Q?NrWl8jQn4dBoxL0DQDQwnjdL0U/ursArUnyzw3Izw22GOFNoZc8JnndHdL3f?=
 =?us-ascii?Q?Iaj5bcKG99VeXGfqCDWTW3ZZcL3rI43auJUr3/QowkDoQJ26ntCdeXIPYPld?=
 =?us-ascii?Q?+Z2d4XcVsYRrUM+uEvNBhArySF6Ta6gMy2wICccS5h3IK1Yx564Gn79vaHHD?=
 =?us-ascii?Q?7qLDZUjryMCuMnwGAfsunLYyakLaWqwv/J6djQKfDWoJgOVcJNRG9MAj62Xi?=
 =?us-ascii?Q?cTmg6mgqMjCGFqkwqGM/HVj7lGO50bptUjRalntoC14tC5qu9V6+FTGHN8rm?=
 =?us-ascii?Q?5XpnmLcHAX+Z9lbzQCJ9g63LJMsUND9uvvCQW8oARUF1heRLH6aAHlHLumYB?=
 =?us-ascii?Q?/cuaPDN8bB/jNU9tem5XW6RQSH/3gAEaavCmnhKTxg13GFntoLbJjyILlFE6?=
 =?us-ascii?Q?1qX16+EhI6RGOjCW25bbeDPABRRM+Z1EawUdDdTi0+vaTDy+m4Rc18SXo5CV?=
 =?us-ascii?Q?wpVGiEEbagmwJgqmMqOXV4N2ikk1f4yBFzNG8WAkaK8seWROulF3SUK8q9yI?=
 =?us-ascii?Q?yvxaWyrCbvqGuXdGMf7+Tca8oOJ2O49MUR212OALBCc69KuVjs5iPOuNOkC4?=
 =?us-ascii?Q?XBert4u6L6NKfV5WGFeAekWUoUMnLr+UZ37jXh1+VDZWNJpetBje4RJutsgF?=
 =?us-ascii?Q?Eqx0fh1znJ5orJMEtWVWsT/NPqfz6yc6mtImwcbRSPWxrM64DERWeOrjX0F4?=
 =?us-ascii?Q?ec963u5fpFUDtJ9N/P/M43blzB3YTKqS0BxCQFeA/H1fRte/h6p+NmHy16WK?=
 =?us-ascii?Q?U09+Yh/q+w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6084.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 159ea985-f4b3-43c9-d59b-08de7f695c47
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 12:26:02.8793 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n50BKQ/gyunONxQgstvU3kudcz/Kxq0F2FqjXzGrnn+QZNtP4PSztBu2atxuLnN65oLEhhsqTmPNkwJRebzIuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFB332093D3
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

Nice clarification, Vincent.
Thank you.

Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>

> -----Original Message-----
> From: Vincent Jardin <vjardin@free.fr>
> Sent: Tuesday, March 10, 2026 11:20 AM
> To: dev@dpdk.org
> Cc: Raslan Darawsheh <rasland@nvidia.com>; NBU-Contact-Thomas Monjalon
> (EXTERNAL) <thomas@monjalon.net>; andrew.rybchenko@oktetlabs.ru;
> Dariusz Sosnowski <dsosnowski@nvidia.com>; Slava Ovsiienko
> <viacheslavo@nvidia.com>; Bing Zhao <bingz@nvidia.com>; Ori Kam
> <orika@nvidia.com>; Suanming Mou <suanmingm@nvidia.com>; Matan Azrad
> <matan@nvidia.com>; Vincent Jardin <vjardin@free.fr>
> Subject: [PATCH v1 01/10] doc/nics/mlx5: fix stale packet pacing document=
ation
>=20
> The Tx Scheduling section incorrectly stated that timestamps can only be =
put on
> the first packet in a burst. The driver actually checks every packet's ol=
_flags for
> the timestamp dynamic flag and inserts a dedicated WAIT WQE per
> timestamped packet. The eMPW path also breaks batches when a timestamped
> packet is encountered.
>=20
> Additionally, the ConnectX-7+ wait-on-time capability was only briefly
> mentioned in the tx_pp parameter section with no explanation of how it di=
ffers
> from the ConnectX-6 Dx Clock Queue approach.
>=20
> This patch:
> - Removes the stale first-packet-only limitation
> - Documents both scheduling mechanisms (ConnectX-6 Dx Clock Queue and
>   ConnectX-7+ wait-on-time) with separate requirements tables
> - Clarifies that tx_pp is specific to ConnectX-6 Dx
> - Fixes tx_skew applicability to cover both hardware generations
> - Updates the Send Scheduling Counters intro to reflect that timestamp
>   validation counters also apply to ConnectX-7+ wait-on-time mode
>=20
> Fixes: 8f848f32fc24 ("net/mlx5: introduce send scheduling devargs")
>=20
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> ---
>  doc/guides/nics/mlx5.rst | 109 ++++++++++++++++++++++++++++-----------
>  1 file changed, 78 insertions(+), 31 deletions(-)
>=20
> diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst index
> 2529c2f4c8..5b097dbc90 100644
> --- a/doc/guides/nics/mlx5.rst
> +++ b/doc/guides/nics/mlx5.rst
> @@ -553,27 +553,32 @@ for an additional list of options shared with other
> mlx5 drivers.
>=20
>  - ``tx_pp`` parameter [int]
>=20
> +  This parameter applies to **ConnectX-6 Dx** only.
>    If a nonzero value is specified the driver creates all necessary inter=
nal
> -  objects to provide accurate packet send scheduling on mbuf timestamps.
> +  objects (Clock Queue and Rearm Queue) to provide accurate packet send
> + scheduling on mbuf timestamps using a cross-channel approach.
>    The positive value specifies the scheduling granularity in nanoseconds=
,
>    the packet send will be accurate up to specified digits. The allowed r=
ange is
>    from 500 to 1 million of nanoseconds. The negative value specifies the=
 module
>    of granularity and engages the special test mode the check the schedul=
e rate.
>    By default (if the ``tx_pp`` is not specified) send scheduling on time=
stamps
> -  feature is disabled.
> +  feature is disabled on ConnectX-6 Dx.
>=20
> -  Starting with ConnectX-7 the capability to schedule traffic directly
> -  on timestamp specified in descriptor is provided,
> -  no extra objects are needed anymore and scheduling capability
> -  is advertised and handled regardless ``tx_pp`` parameter presence.
> +  Starting with **ConnectX-7** the hardware provides a native
> + wait-on-time  capability that inserts the scheduling delay directly in =
the WQE
> descriptor.
> +  No Clock Queue or Rearm Queue is needed and the ``tx_pp`` parameter
> + is not  required. The driver automatically advertises send scheduling
> + support when  the HCA wait-on-time capability is detected. The
> + ``tx_skew`` parameter can  still be used on ConnectX-7 and above to
> compensate for wire delay.
>=20
>  - ``tx_skew`` parameter [int]
>=20
>    The parameter adjusts the send packet scheduling on timestamps and
> represents
>    the average delay between beginning of the transmitting descriptor pro=
cessing
>    by the hardware and appearance of actual packet data on the wire. The =
value
> -  should be provided in nanoseconds and is valid only if ``tx_pp`` param=
eter is
> -  specified. The default value is zero.
> +  should be provided in nanoseconds and applies to both ConnectX-6 Dx
> + (with ``tx_pp``) and ConnectX-7+ (wait-on-time) scheduling modes.
> +  The default value is zero.
>=20
>  - ``tx_vec_en`` parameter [int]
>=20
> @@ -883,9 +888,13 @@ Send Scheduling Counters
>=20
>  The mlx5 PMD provides a comprehensive set of counters designed for
> debugging and diagnostics related to packet scheduling during transmissio=
n.
> -These counters are applicable only if the port was configured with the `=
`tx_pp``
> devarg -and reflect the status of the PMD scheduling infrastructure -base=
d on
> Clock and Rearm Queues, used as a workaround on ConnectX-6 DX NICs.
> +The first group of counters (prefixed ``tx_pp_``) reflects the status
> +of the Clock Queue and Rearm Queue infrastructure used on ConnectX-6 Dx
> +and is applicable only if the port was configured with the ``tx_pp`` dev=
arg.
> +The timestamp validation counters
> +(``tx_pp_timestamp_past_errors``, ``tx_pp_timestamp_future_errors``,
> +``tx_pp_timestamp_order_errors``) are also reported on ConnectX-7 and
> +above in wait-on-time mode, without requiring ``tx_pp``.
>=20
>  ``tx_pp_missed_interrupt_errors``
>    Indicates that the Rearm Queue interrupt was not serviced on time.
> @@ -1960,31 +1969,54 @@ Limitations
>  Tx Scheduling
>  ~~~~~~~~~~~~~
>=20
> -When PMD sees the ``RTE_MBUF_DYNFLAG_TX_TIMESTAMP_NAME`` set on
> the packet -being sent it tries to synchronize the time of packet appeari=
ng on -
> the wire with the specified packet timestamp. If the specified one -is in=
 the past it
> should be ignored, if one is in the distant future -it should be capped w=
ith some
> reasonable value (in range of seconds).
> -These specific cases ("too late" and "distant future") can be optionally=
 -
> reported via device xstats to assist applications to detect the -time-rel=
ated
> problems.
> -
> -The timestamp upper "too-distant-future" limit -at the moment of invokin=
g the
> Tx burst routine -can be estimated as ``tx_pp`` option (in nanoseconds)
> multiplied by 2^23.
> +When the PMD sees ``RTE_MBUF_DYNFLAG_TX_TIMESTAMP_NAME`` set on
> a
> +packet being sent it inserts a dedicated WAIT WQE to synchronize the
> +time of the packet appearing on the wire with the specified timestamp.
> +Every packet in a burst that carries the timestamp dynamic flag is
> +individually scheduled -- there is no restriction to the first packet on=
ly.
> +
> +If the specified timestamp is in the past, the packet is sent immediatel=
y.
> +If it is in the distant future it should be capped with some reasonable
> +value (in range of seconds). These specific cases ("too late" and
> +"distant future") can be optionally reported via device xstats to
> +assist applications to detect time-related problems.
> +
> +The eMPW (enhanced Multi-Packet Write) data path automatically breaks
> +the batch when a timestamped packet is encountered, ensuring each
> +scheduled packet gets its own WAIT WQE.
> +
> +Two hardware mechanisms are supported:
> +
> +**ConnectX-6 Dx -- Clock Queue (cross-channel)**
> +   The driver creates a Clock Queue and a Rearm Queue that together
> +   provide a time reference for scheduling. This mode requires the
> +   :ref:`tx_pp <mlx5_tx_pp_param>` devarg. The timestamp upper
> +   "too-distant-future" limit at the moment of invoking the Tx burst
> +   routine can be estimated as ``tx_pp`` (in nanoseconds) multiplied
> +   by 2^23.
> +
> +**ConnectX-7 and above -- wait-on-time**
> +   The hardware supports placing the scheduling delay directly inside
> +   the WQE descriptor. No Clock Queue or Rearm Queue is needed and the
> +   ``tx_pp`` devarg is **not** required. The driver automatically
> +   advertises send scheduling support when the HCA wait-on-time
> +   capability is detected.
> +
>  Please note, for the testpmd txonly mode,  the limit is deduced from the
> expression::
>=20
>     (n_tx_descriptors / burst_size + 1) * inter_burst_gap
>=20
> -There is no any packet reordering according timestamps is supposed, -nei=
ther
> within packet burst, nor between packets, it is an entirely -application
> responsibility to generate packets and its timestamps -in desired order.
> +There is no packet reordering according to timestamps, neither within a
> +packet burst, nor between packets. It is entirely the application's
> +responsibility to generate packets and their timestamps in the desired
> +order.
>=20
>  Requirements
>  ^^^^^^^^^^^^
>=20
> +ConnectX-6 Dx (Clock Queue mode):
> +
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  Minimum    Version
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> @@ -1996,20 +2028,35 @@ rdma-core
>  DPDK       20.08
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> +ConnectX-7 and above (wait-on-time mode):
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Minimum    Version
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +hardware   ConnectX-7
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
>  Firmware configuration
>  ^^^^^^^^^^^^^^^^^^^^^^
>=20
>  Runtime configuration
>  ^^^^^^^^^^^^^^^^^^^^^
>=20
> -To provide the packet send scheduling on mbuf timestamps the ``tx_pp`` -
> parameter should be specified.
> +**ConnectX-6 Dx**: the :ref:`tx_pp <mlx5_tx_pp_param>` parameter must
> +be specified to enable send scheduling on mbuf timestamps.
> +
> +**ConnectX-7+**: no devarg is required. Send scheduling is
> +automatically enabled when the HCA reports the wait-on-time capability.
> +
> +On both hardware generations the ``tx_skew`` parameter can be used to
> +compensate for the delay between descriptor processing and actual wire
> +time.
>=20
>  Limitations
>  ^^^^^^^^^^^
>=20
> -#. The timestamps can be put only in the first packet
> -   in the burst providing the entire burst scheduling.
> +#. On ConnectX-6 Dx (Clock Queue mode) timestamps too far in the future
> +   are capped (see the ``tx_pp`` x 2^23 limit above).
>=20
>=20
>  .. _mlx5_tx_inline:
> --
> 2.43.0

