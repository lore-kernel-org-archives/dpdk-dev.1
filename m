Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C294606A31A
	for <dpdk-dev@archiver.kernel.org>; Sun,  8 Nov 2026 04:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=aj4paxjF
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7452A40264;
	Sun,  8 Nov 2026 05:22:19 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013062.outbound.protection.outlook.com
 [40.93.196.62]) by mails.dpdk.org (Postfix) with ESMTPS id 979964003C
 for <dev@dpdk.org>; Sun,  8 Nov 2026 05:22:17 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e2nagiuYZJHXA5XxrgYLPBiboOUb+T0EqzTjmeNHUcSAxE8mID1C9PXgzeReSQ/b1/cmJtLKYsQevN4jri5/4ex59QBijpb/SFMvCJe9hVFdEo9rHf+lRji0es6nWCCOq3iiU/frM3nEZ0uwLpyjdWgmrMsIY4hHdUYbTvvPzikQOgheD7QkSC8aYvXBvlikgEYGzy+bjg61D0jio0uj4BGr+tdOtwTd0jpKP+7R8oGnClZ2sf/498ytncFfLdTpbEGg5mKmgX2QbF2ZYfQjfawd4tv23Juc3zKE33XsN2iyx6hIEnRWBdIgNujjbVn4lNtDZfqscdSI9cmD33UPmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAlFoABBaPevXAHpzji5OYm6YZxuJ+OLfJ/mo3czKu8=;
 b=IAztAmTutiLSOTeuoqMgUPlz5i+Uti2sKr3pMgYgShKb+NfGvmTZQEa4KtOfUzkUeInufQLPZ8IU+5eX7+k+d7kuvV1tlwXlDVc0G+CGVeCmpI9Jfnd8l1hai9mEing+XLJKJE3/x/o5+IkeOZBssRj989BaPAh6VBHC2JbE6M0G0986oAyZTPsECCekV9gIhYEaArX64UF+yWvB7DyAWpgFBzXvg9erVvR4XxFBVUdPPE0yhOZhtSeoW0IqVR4ToebKEValU5koT58uvOXgo8+MJvgluRVM8P/XTha3l6vrla6sBko0NtuZA5BbdB9dKMYIKaU/eKj2qt2d8Va7iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAlFoABBaPevXAHpzji5OYm6YZxuJ+OLfJ/mo3czKu8=;
 b=aj4paxjFJkFCLTGUcVVWbQXaHhQq1S3ivqcNNWptpgOwVdHFYoGOwLOJLCU9CX7hjZSDshKdN72sm4XitDouRfO3mBg7dNhId6+ilbiaSW7+A/zV+YrbEskaHgaLYKv4zcBLv8r3+MBRNrlCTZUMkcbrcofGEh3RFq0K/DjTi0yUfqfm+zE9ONSQ96F/CFOQBvbSsMUxkFvjbzoqQf7x0/NamU+qFkMd1uwOe4HXkvKohuBoOKfwPYqsCYNxrIEuq0IfIqM/N9UezASwHC2xOM7j3KTC21JGdhdhVgT4dkxXDFU8RjJ4TveRPEaicp7tXsyKStm3VN5li9UCfL/pjg==
Received: from BN9PR12MB5338.namprd12.prod.outlook.com (2603:10b6:408:103::23)
 by CY1PR12MB9651.namprd12.prod.outlook.com (2603:10b6:930:104::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sun, 8 Nov
 2026 04:22:12 +0000
Received: from BN9PR12MB5338.namprd12.prod.outlook.com
 ([fe80::7b66:315e:f851:8ddb]) by BN9PR12MB5338.namprd12.prod.outlook.com
 ([fe80::7b66:315e:f851:8ddb%6]) with mapi id 15.21.0592.010; Sun, 8 Nov 2026
 04:22:11 +0000
From: Bing Zhao <bingz@nvidia.com>
To: Rayane Boussanni <rboussanni@gmail.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Raslan Darawsheh <rasland@nvidia.com>
Subject: RE: [PATCH] net/mlx5: add hardware query for basic stats
Thread-Topic: [PATCH] net/mlx5: add hardware query for basic stats
Thread-Index: AQHczfIdLN47lz3X1kiv0fw9AoU0drck1QLw
Date: Sun, 8 Nov 2026 04:22:11 +0000
Message-ID: <BN9PR12MB53387D0E8952B83DF7D18270D0742@BN9PR12MB5338.namprd12.prod.outlook.com>
References: <20260416224011.14862-1-rboussanni@gmail.com>
In-Reply-To: <20260416224011.14862-1-rboussanni@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5338:EE_|CY1PR12MB9651:EE_
x-ms-office365-filtering-correlation-id: 48b99540-2904-4fc7-5ac5-08df3d4fdc29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|38070700021|260925021911599003|260925022911599003|260925021311599003|261026140227099003|11063799006|261022075727099003|261022105027099003|56012099006|261009223027099003|261021121427099003|261021135927099003|261021123027099003|261102123227099003|261026121527099003|261028144727099003|18002099003|22082099003|6133799003|10067099003;
x-microsoft-antispam-message-info: xnxg8FpBskk9F1a3xr77x8j6tjNEWcrDnzHwiY/L3ROvj5Lpcn7H54ogLNEmW7XodsF0vPTdi6suS5RoPbcEXjYVroUJDIlA+JxV0IClArL964BNcMVGgPTp8AvPYWul3TeUs+pcbn+SIhJ7Ul7fWdtN4NKQLCONZm9aaG4mKbT7LVXjTffPuVu9bbtbOh8CO+YJqEYFxov665SZpNbxKbH2NE49L72vyr3+aB1yl6p1SBzJ+MsHP3giIthFQQnpSoMdwJUXnmjAlDscqq2NwhiyKjDnlS9B9+aVvywWYlX+Jo+yNoGmNuKLedXh5Mm+hJ2YMPLtuAKVy2s1oiCQvLiEpxeztybAMGTvCj1HDD6Xb9AwvcRy+yfTKLubRWyuzaeT5TSg9ea3ULGLrWd4Z1wJS8xi3GiPNTLE03uCG7HmkzQyvHn6VYOsI5fY3HpW2A3VDISC5cIUVWYJ6aKCMna//NZh+gs0tyuDo1D/jaCCNG0Ea1bLv2ZM0HRo0b27GlXBLZ5aMLGybd6U0d5O6+eW+4vJfk4lje42tG7AbJ7H0eedcFEpGtKoD8hi2pRQAwMxKwWVfJ2dQYgfGUTRz/MIdeHmjx0evx2PeQhuhSviTTNLQd4PuQ5tHSnGTmNuAoBDSsn7S1jMdKHUi5kHvp2l/oxMUngqwjiBNmww1DoHjrFM5fuo/WKpQ6fDgXYmWR6YGE6pYCNZUsbwi9oV3eu4w/61Qlf/eF7H4XCxH0Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5338.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(38070700021)(260925021911599003)(260925022911599003)(260925021311599003)(261026140227099003)(11063799006)(261022075727099003)(261022105027099003)(56012099006)(261009223027099003)(261021121427099003)(261021135927099003)(261021123027099003)(261102123227099003)(261026121527099003)(261028144727099003)(18002099003)(22082099003)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Sb0LTx8LpN5Dc8TL4My0dBjp4Nh2l9acmTIr+PUPXpsCfxTwIO6OU57kFxQj?=
 =?us-ascii?Q?U1uDwDuzI2O2mXB21SRJZ2HKkOaJfJFGEGBiAHSeIZT/Iqrclb/D3BqXDLi0?=
 =?us-ascii?Q?hqdzve/TKKFyzqIRLXUxwZG1JydQM7JxT1DX9DkQ1m0ZHdx0Ix5gyHdP4xYO?=
 =?us-ascii?Q?9sSiwUkLmtgk5mQJtGdIYJyLXY0nVNZ0/vOSFZwBLv/W3djVEUUbaoaBsJ7T?=
 =?us-ascii?Q?iQorp13MGAauBh0Re7/ZQse+aK2htIkaaaWQ/QaBo3PrPlohc/ePyFFLHX+1?=
 =?us-ascii?Q?eP5DO/EPdp1vecxMDP9kVAKhw3tdmr6Us5ebw1ARxD4V79QBzLlhzYIEtJKK?=
 =?us-ascii?Q?FKHrOP7NWT3cF69NUl30gDHwy3TpB3DfIqvOtiMD2A8tkn2uuZawyuT5RmOL?=
 =?us-ascii?Q?1eqJugERcZYH/shs/ifbLy2ah+wUYr48dxeIKscgfIN72IB8GcPjIe19FGYi?=
 =?us-ascii?Q?0BmViA0pJmi4QTdJBUzPgfis8qjGAIOqLX4PtU30tRCO1FyioVmFq1ZcEUnB?=
 =?us-ascii?Q?KeTlQWeptwzYN0DA/oyu6UgEAsT/qUnyFp2CPSd2EXHwHmX+nBjMYIUcIaN1?=
 =?us-ascii?Q?hfU+cSjgSlNr2vx2nZRgLfQi27p2/qpxvjRX5yww2zv0JGcLd2t+u3Z61atZ?=
 =?us-ascii?Q?18kd5QRoiugdYKexhpSGtWGK7+nXSpRWDLf8L2eFCMpueuJQwrLtfIuhpUXd?=
 =?us-ascii?Q?zUjwe6jWrZ1FCQ1Jh9idwagMXJVZT/r6dOPK1Y1rIMmNoIvUNiRomnM7yyhm?=
 =?us-ascii?Q?wTdzMODMCPeqxvP0Dgc+GFiXI/iWmN8XFLGZ7sQ/vTsVwDIOeoOUmvfYgBh6?=
 =?us-ascii?Q?ZmZo+SMWNi+A3PXh/I/PY1eTiB6KyVDuSZN2Rwk+h5V8RG24BMahYG8jhmgH?=
 =?us-ascii?Q?0m/2ewU5DTJFUwGTXJPrmWdoZ4gcAoBlqTME/A60SYXMzsd/7P/WTfzk4nIY?=
 =?us-ascii?Q?UKWP5ksM99GKYsRSA3AfxDOprQ6GhPzvH/hseg8Lrnyt5I+z/RqyESCfDauo?=
 =?us-ascii?Q?8aOaLS6pMQwQyFmWxi8bL5KfQLVGA5FlJwlSAI2X/xhjZAqpv/8RIeWyZgvj?=
 =?us-ascii?Q?vaAvZ4KcL37/BMBEseLv53lblVFfb28jgRwKDrmihfzupF5Rx5SQ0W0AUI6x?=
 =?us-ascii?Q?BF01D20gBM49z5doaf1baesDAPfNZZZU/vzXVabRY2OjcEoFMFJt+aRAKgCz?=
 =?us-ascii?Q?QNkS2nu4QTCO0KiKj5vuc2IVVojB+wBUfOe1GUYm+O/EfORcxM7zxcHMaitR?=
 =?us-ascii?Q?U612zck5ztpaONnb+IbHif/P5kc64t+lkMSwgDHyxN4rB9rggX3ViSjnUXpY?=
 =?us-ascii?Q?/yyFxi5gANTbma0/wEpSPX1cNlbmePd/CCTXk2h6TUKGRov3plhtd6j3ImYP?=
 =?us-ascii?Q?V8ENL0uxnK+RaEf/uUKvPcrAmDbz6zDtI9dcpXSXQ2We8Hvosk0wEz1HJgE8?=
 =?us-ascii?Q?ZqWlEtvEbO5SaVFqJ+l/awP3C+sAnvoz7ymDT9pdnsyuyQCSVhQ1FNn0cDqV?=
 =?us-ascii?Q?LqitIFNTdCXAJjVKLF7l5kK6eIMgWcIhiP6q0aQv8bxbS3iOb+e8jQZzYMzw?=
 =?us-ascii?Q?1Vt87m4HKEBCu8TrjpGJvuca2utVDe2ERh6k4yZkiJJBPXXGJ32Y10Sm6X0c?=
 =?us-ascii?Q?jt8uKn/+Rv6hikchNLrM9RI804dnUI3zzwoWqRpRvO4t7S6yWI6Lc3k7uPtc?=
 =?us-ascii?Q?wViQY3IzfdKC6lSagNWTQQYQAl8wwuQ8+5aEujxE5cPNEIW+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5338.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b99540-2904-4fc7-5ac5-08df3d4fdc29
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2026 04:22:11.4988 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k++bpuxC1NrxSxERa3ViAe5olRy1yXC1C1x/IheVWgy8IuCF7OOt1/kc1YOW4NSqQiya5O/4FIMM0FahrICbCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9651
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Rayane,

Thanks for working on this. Unfortunately the patch cannot be accepted in i=
ts current form. Please see the comments below.

> -----Original Message-----
> From: Rayane Boussanni <rboussanni@gmail.com>
> Sent: Friday, April 17, 2026 6:40 AM
> To: dev@dpdk.org
> Cc: Raslan Darawsheh <rasland@nvidia.com>; Rayane Boussanni
> <rboussanni@gmail.com>
> Subject: [PATCH] net/mlx5: add hardware query for basic stats
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> When MLX5_PMD_SOFT_COUNTERS is not defined, the basic dev statistics
> (rte_eth_stats) previously fell back to returning zeroed values for all
> packet and byte metrics.
>=20
> This patch resolves the FIXMEs in mlx5_stats_get and mlx5_stats_reset by
> falling back to the target's dev counters map. It utilizes
> mlx5_os_read_dev_counters to retrieve the bulk arrays from the hardware
> and strategically filters them against the xstats_ctrl index to summarize
> the basic opackets, obytes, ipackets, ibytes, oerrors, and ierrors withou=
t
> duplicating the context-switch overhead.
>=20
> Signed-off-by: Rayane Boussanni <rboussanni@gmail.com>
> ---
>  drivers/net/mlx5/mlx5_stats.c | 57 +++++++++++++++++++++++++++++++++--
>  1 file changed, 55 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/mlx5/mlx5_stats.c b/drivers/net/mlx5/mlx5_stats.=
c
> index 5cd3e303cc..198f231559 100644
> --- a/drivers/net/mlx5/mlx5_stats.c
> +++ b/drivers/net/mlx5/mlx5_stats.c
> @@ -280,7 +280,46 @@ mlx5_stats_get(struct rte_eth_dev *dev, struct
> rte_eth_stats *stats,
>                 tmp.imissed =3D stats_ctrl->imissed;
>         }
>  #ifndef MLX5_PMD_SOFT_COUNTERS
> -       /* FIXME: retrieve and add hardware counters. */
> +       {
> +               uint64_t counters[MLX5_MAX_XSTATS];
   1. The new code is never compiled. drivers/net/mlx5/mlx5_defs.h
      defines MLX5_PMD_SOFT_COUNTERS to 1 whenever it is not already
      defined, so both new #ifndef blocks are always excluded. Neither
      -DMLX5_PMD_SOFT_COUNTERS=3D0 nor -UMLX5_PMD_SOFT_COUNTERS changes
      this, so the patch has no effect in any supported build.
=20
      A supported way to select hardware counters is needed first.
      Note also that the non-soft-counter configuration already fails
      with -Werror, because of the unused "ntcp" variables in
      mlx5_tx_packet_multi_tso() and mlx5_tx_burst_tso() in mlx5_tx.h.
      That is not caused by your patch, but it shows this mode is not
      currently built or tested.

> +               struct mlx5_xstats_ctrl *xstats_ctrl =3D &priv->xstats_ct=
rl;
> +               bool bond_master =3D (priv->master && priv->pf_bond >=3D =
0);
> +
> +               ret =3D mlx5_os_read_dev_counters(dev, bond_master,
> counters);
> +               if (ret) {
> +                       DRV_LOG(WARNING, "port %u unable to read device
> counters",
> +                               dev->data->port_id);
> +                       return ret;
> +               }
> +               for (i =3D 0; i !=3D xstats_ctrl->mlx5_stats_n; ++i) {
> +                       const char *name =3D xstats_ctrl->info[i].dpdk_na=
me;
> +                       uint64_t val =3D (counters[i] -
> + xstats_ctrl->base[i]);

   2. mlx5_stats_reset() overwrites the xstats baselines but does not
      reset xstats_ctrl->hw_stats[], which mlx5_xstats_get() uses for
      32-bit wrap tracking of device counters. After a basic stats
      reset with unchanged hardware counters, rx_out_of_buffer is
      reported as 4294967296. Please either perform a complete,
      consistent reset (as in mlx5_xstats_reset()) or keep separate
      baselines for the basic statistics.

> +
> +                       if (!strcmp(name, "rx_unicast_packets") ||
> +                           !strcmp(name, "rx_multicast_packets") ||
> +                           !strcmp(name, "rx_broadcast_packets"))
> +                               tmp.ipackets +=3D val;
> +                       else if (!strcmp(name, "rx_unicast_bytes") ||
> +                                !strcmp(name, "rx_multicast_bytes") ||
> +                                !strcmp(name, "rx_broadcast_bytes"))
> +                               tmp.ibytes +=3D val;
> +                       else if (!strcmp(name, "tx_unicast_packets") ||
> +                                !strcmp(name, "tx_multicast_packets") ||
> +                                !strcmp(name, "tx_broadcast_packets"))
> +                               tmp.opackets +=3D val;
> +                       else if (!strcmp(name, "tx_unicast_bytes") ||
> +                                !strcmp(name, "tx_multicast_bytes") ||
> +                                !strcmp(name, "tx_broadcast_bytes"))
> +                               tmp.obytes +=3D val;
> +                       else if (!strcmp(name, "rx_wqe_errors") ||
> +                                !strcmp(name, "rx_phy_crc_errors") ||
> +                                !strcmp(name,
> "rx_phy_in_range_len_errors") ||
> +                                !strcmp(name, "rx_phy_symbol_errors"))
> +                               tmp.ierrors +=3D val;
> +                       else if (!strcmp(name, "tx_phy_errors"))
> +                               tmp.oerrors +=3D val;
> +               }
> +       }
>  #endif
>         *stats =3D tmp;
>         return 0;
> @@ -319,7 +358,21 @@ mlx5_stats_reset(struct rte_eth_dev *dev)
>         mlx5_os_read_dev_stat(priv, "out_of_buffer", &stats_ctrl-
> >imissed_base);
>         stats_ctrl->imissed =3D 0;
>  #ifndef MLX5_PMD_SOFT_COUNTERS
> -       /* FIXME: reset hardware counters. */
> +       {
> +               uint64_t counters[MLX5_MAX_XSTATS];
> +               struct mlx5_xstats_ctrl *xstats_ctrl =3D &priv->xstats_ct=
rl;
> +               bool bond_master =3D (priv->master && priv->pf_bond >=3D =
0);
> +               int ret;
> +
> +               ret =3D mlx5_os_read_dev_counters(dev, bond_master,
> counters);
> +               if (ret) {
> +                       DRV_LOG(WARNING, "port %u unable to read device
> counters",
> +                               dev->data->port_id);
> +                       return ret;
> +               }

   3. On Windows, mlx5_os_read_dev_counters() always returns -ENOTSUP.
      Once this path is enabled, rte_eth_stats_get() and
      rte_eth_stats_reset() would fail completely there, instead of
      still returning the statistics that are available today. An
      unsupported backend should be handled gracefully.

> +               for (i =3D 0; i !=3D xstats_ctrl->mlx5_stats_n; ++i)
> +                       xstats_ctrl->base[i] =3D counters[i];
> +       }
>  #endif

   4. This changes what the basic statistics mean. The vport counters
      also include traffic received or sent by the Linux kernel
      (bifurcated driver), while doc/guides/nics/mlx5.rst says the
      basic Rx/Tx statistics count only packets handled by the PMD.
      If this is intended, the documentation must be updated and the
      change in behaviour explained in the commit message.
=20
   My AI tool checked this by compiling mlx5_stats.c in both the default
   configuration and with the hardware branch forced on, and by running
   the patched get/reset callbacks in a small harness with the device
   reads stubbed out. I did not run it on hardware.
=20
   For a v2, I'd suggest agreeing first on how hardware basic statistics
   should be selected, then addressing the points above. Please include
   the documentation update and test results on Linux (including
   bonding) and Windows.

>=20
>         return 0;
> --
> 2.34.1

