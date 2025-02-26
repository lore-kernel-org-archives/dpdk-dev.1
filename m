Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902CAC021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 13:36:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 39D5A4029F;
	Wed, 26 Feb 2025 14:36:13 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by mails.dpdk.org (Postfix) with ESMTP id 254C44026C
 for <dev@dpdk.org>; Wed, 26 Feb 2025 14:36:11 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D5cVD6YtsZp2vJscjwmw0wfy0v4zHy5e+fWz1KKcIA88K+nce8Q7ya3cE6WTwhjFETECHgs0j/Ijn1YTkwMLHhAio5WEL+1IYfn5Z1tB8p1ATFE4KXkM7ltBPr7ehKYAiRiIHUs4yiDELMDySXmOf2PVp0fEtqCLcjyrgiIXYfixr7K18Mwp9uLkpAs4afsLzcDths4faA+GqemS1C2wK/slVgqStPkQ9rFtfbfPgRpxxnYMB/PiXpmvytq16W+fRy1W8ACJrCWqA7C7P2Yk1CZWAhiI2Ltuyzs7+ZVTyYyuZ59+4WsCds1J1Iwe7G6rFZTcMxo91v7UJdgOWj8ItA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iy2fHGguB91hnjf9JY2rJflnLijJPXsCtk83fe7glv8=;
 b=XMTykph6e56c/Qg0FbjCjF7qRYeCrIrX81OJCAUWnGAAiwYDDlgcR2xgtxiRKfDXl6UqHtzjLL0APlIGkLgtOQC+s6j9ZMWs3hOULA4o88l+kqtWdF7knpQlk+7wABkDIo6Mh3pgQPhhcWN40KOzCEju0TEs0Ocpwqw8HJaMJLnBMfNSpXHMXgh2YmivpM+c4i2iLTCWBpyULqQXhQhfd3FkpdRQs4gJvbUm/ZjY+bZZ4hJnw1/jmVsgGwOeRBms1EVsmpQ4X7OAbYKcUdKHvy0SVqjoDmpKvRDXpdmeKLqOhcufkjLUaruKsYLBerkGjxPt8jrGpZsVGpetH2tVmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iy2fHGguB91hnjf9JY2rJflnLijJPXsCtk83fe7glv8=;
 b=L8oMoPa0wREuDo1H7HtEBHGt4HMINBcvjBc1dcJSM2f23j8IoJWg0FoHEBnkPB+OirGHVW9Caq79QGc/FMmgefw8HTwmtSqmVt0ch/po8CCe6c0apgYZq9jRsLaJG/QatO6H/F4IU9MBRgBNchsqjDcmeEWSf52tMaVEbG/ytDxFLXxO0JGDHKMVwDVijHce7JRg1pw2Zuvl/Rf7XHsTGELqDAmVE1J3xJsf4J3txMHu1zGAxpsm//i8trDsCydS2p4xZkWkp9Np0Dmpikyme18gQgRTXsE6+I5DoB1qnk79djBVEB3Lw7stGdWaAnQE1q1R/Buju4JsLBFx0z8Iyw==
Received: from PH8PR12MB7326.namprd12.prod.outlook.com (2603:10b6:510:216::7)
 by DM6PR12MB4121.namprd12.prod.outlook.com (2603:10b6:5:220::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 13:36:08 +0000
Received: from PH8PR12MB7326.namprd12.prod.outlook.com
 ([fe80::6d76:9c33:d230:8264]) by PH8PR12MB7326.namprd12.prod.outlook.com
 ([fe80::6d76:9c33:d230:8264%5]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 13:36:08 +0000
From: Suanming Mou <suanmingm@nvidia.com>
To: Bing Zhao <bingz@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Slava Ovsiienko <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>, Matan
 Azrad <matan@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: RE: [PATCH 2/3] net/mlx5: add jump FDB Rx flag
Thread-Topic: [PATCH 2/3] net/mlx5: add jump FDB Rx flag
Thread-Index: AQHbhx65wXOdVEwkik+emOGfkzmZCbNZZqOAgAAwrrA=
Date: Wed, 26 Feb 2025 13:36:07 +0000
Message-ID: <PH8PR12MB7326B60D6726E2C3AC9CA514C1C22@PH8PR12MB7326.namprd12.prod.outlook.com>
References: <20250225004527.2066812-1-suanmingm@nvidia.com>
 <20250225004527.2066812-3-suanmingm@nvidia.com>
 <PH7PR12MB6905C9CF4D53ABD23F42D8D9D0C22@PH7PR12MB6905.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB6905C9CF4D53ABD23F42D8D9D0C22@PH7PR12MB6905.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB7326:EE_|DM6PR12MB4121:EE_
x-ms-office365-filtering-correlation-id: 2e5b8329-1fff-4dd3-1905-08dd566a8698
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?ILCueJt0tSm5ONaj/gHG18bSo49nmiDMrONqsR5ddKLEmh4FbrDOExTiY4xc?=
 =?us-ascii?Q?Q0AeKC1E2FxwrfkmT+hCh/9fuE4bvw6VP+QssRisZehOICy6h4H48iBwyx8q?=
 =?us-ascii?Q?5+C5EhwuqP43Hu3GBR83Btd/TdDrKx9gRQj1pPxutmYmHEVBy4ugSA90joU4?=
 =?us-ascii?Q?ryi+X6+WVdQy4CBQQhsiHDGDRFzECaw6RU2USoeHwHe9rRw1bPXZbjDMhvLr?=
 =?us-ascii?Q?F5OinRigaR/2P8h8JBk5qRaN8mGwDVhMJcxiiCkkP4NSB3LIjh4rh166xR1y?=
 =?us-ascii?Q?Thjc2rgLqj29Aqnc+DBk6z5meK1y5O0BYBboImy+oI8NvMvsJpgdw1xZP95Q?=
 =?us-ascii?Q?dQwpgHgkTPQNZ4ZXkKhwCdQJx4Zf7fPM7iP2tkG4UpTXXfIqrm/V9s4zzzJJ?=
 =?us-ascii?Q?Q9ml5zHl9DF2wuazj1Fpwu8k2JlK9v+F1LbWm3qacuyTFEu4Y8joJmqjUzBt?=
 =?us-ascii?Q?EDDT9V9fwkYRGfkQGHHAe3FbRMz6rT6q28Eq66gklhDxZ+Z1Wkv2KzL+raOI?=
 =?us-ascii?Q?RznylM31bVGPdTyvoNHecrze8aYWigPrmmnK3FWmBerhsfjt57Dw/CjsMzq9?=
 =?us-ascii?Q?m7ziPRryhOsOD2UsKHUAbziirZE/aa+J4VLSGaztNNP0X1n3fFIbEPaqDpJA?=
 =?us-ascii?Q?nnPzM70Jgb+I1IIyCQxdkLQqzY0sSpeeNQms56C0l9p0kvE1qDOp4XrNy+R+?=
 =?us-ascii?Q?ut/Ay/AhBHPmEtQI1bg1U/gpA58H5/9LgFrlgGIMcP4Sy6cAEdixkH1BOO2G?=
 =?us-ascii?Q?hjW4T9n/cYWXLPXyRjO/1FfJYlTkXZQrn9TUCkH9BekJTjMLWicXrJut8azw?=
 =?us-ascii?Q?A4E3IFyRV6L1H0gYCRBlFB5a72fs/ZVHEcemQSXw7Z4A/LbqkdFoCJig2BNr?=
 =?us-ascii?Q?wSBEGFLRmTNen5Q0wwxQ10RMCY+2RcWjkJc9Y2ZsMemqlXv7vcknChEtjIpm?=
 =?us-ascii?Q?2PQd7XUZ4sZC7tY7E6tnoxy75NAwnPsakUx1CFXJBU3ATB9aXXPrbabNiNFa?=
 =?us-ascii?Q?UV2lAU45N5NCsX/JjqriD7iJCBLexRcMXMlCcDDSkI59YV/nA+JaXryOlSXR?=
 =?us-ascii?Q?2Jb4BNPc4GSGCdMtnuzX4ZoQJB9TqK8EPaxPvJ/FYhCFcy8xf7LorNSR+9jH?=
 =?us-ascii?Q?hocybJi3azMefOcv1OsSSW0i4hsFM/0i7oHC17/wJpEYKG13KzGMl4fNOraZ?=
 =?us-ascii?Q?+RSk+Oj63T0lWyXeyqo4l8sd1bVEVrEH2irn/Gsa15NR0Jn6MKYiqYJYmcPn?=
 =?us-ascii?Q?eeNFblko4R808ImH5NXsQgU44cAPSRemrmUr1bCQk6n/shA28lbFPA8N8wrQ?=
 =?us-ascii?Q?26+pZM2ZJdjBKLHzcJ+r3Umisz2J1ZDNJ4nhB5eBUyPwx2OEKyvEywkqbmmo?=
 =?us-ascii?Q?L3N0nXAmEK7hnKR4C04CXIBPzu4TW1BrZWa0sq2aAuiaaD1+pKwZ1vsIpMdw?=
 =?us-ascii?Q?Y1EX2AvWR99lCdBmMnscZUcb9rMjRrWk?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7326.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?s4oE9pHB9V+a+zuQOToRIJl5Wlt9zrR6sv3bOqbEhHH60lkya8kWKX6Zku3+?=
 =?us-ascii?Q?l2wsICHe5L1kdQR+EsPPt+wjfS5/YK967eCSkbBDzbPmQGLsmHjsyCVYOvJI?=
 =?us-ascii?Q?aRsjMqekgI5Q37RPkM7OENIty29cOPtSdfmHX5vESWD1noKS11jCRkSQ/tqV?=
 =?us-ascii?Q?yjCjTe5uH3LKMcDPTxlZRs3EZlDFwjtuRgc/4+7QhxC1bqk8kpx/m7FK9mT/?=
 =?us-ascii?Q?FMfL5JD9XChgnRimgMCQIEXhahYAd2SPahUwFx85lIWkIpkp+0T3tLkytBSe?=
 =?us-ascii?Q?F3EEgq6e/F0B9q0gNwj8/82Kd2GW9X2h8zjKvFJkeoE5B3ona/IPUtRHdq2w?=
 =?us-ascii?Q?P8+iGduFDOqRGBbtZNezwdpsaBXp7uzcWjyNm/XzK3FF2iVSNfhoc83SBL0x?=
 =?us-ascii?Q?poBAG4tLg+aM+g3Dlu2OcuF6kR9MUs5DzAk41408Ppjx/q75mw6vM1qQqsJl?=
 =?us-ascii?Q?/DZIa8q4a6sHdaBxMgKzwuOv2wLJSBn4nZRrlph4QhE7J6I+abH9zJmQPvtc?=
 =?us-ascii?Q?pVpoCX3WAb0tJxYmlqnJi6LxwOzWyWTDKgztXwk831yv9GyvbqOSx8GoBJkM?=
 =?us-ascii?Q?5QnfKod4qNJXVVkHajR0LLmz6Htntc/sAq7vVCqvIpqeoWAoHv2CfXqfM4Lf?=
 =?us-ascii?Q?vXKe4eTwf5t1FD3hD7Fqav8UfdFRTXiNBcfi61h2AaqwA3tLkjsEnXiocMR1?=
 =?us-ascii?Q?9RhcaH9jXNNgXSkGlK1cUFSR5ojfkE0zG+BoIBGxkLwBqN0HWIu83Ft2GVCJ?=
 =?us-ascii?Q?l8/lnQjv6PbB1zC6NDvtpFWuz3eJSJl8VmCoBP0BWDvBD/Ko9v2GGSrZ85fN?=
 =?us-ascii?Q?Rr9RoC9AcpZi74ZcJj0lmir90bmvLLQvCBxbrk04/xYfv+f3N7yVTt0Qcip7?=
 =?us-ascii?Q?7Tq6CQubss+0xDi2gC3mKH2I8Hm/SGC5UFmoFH0tVqvuJebvAJrCW0/dtIZr?=
 =?us-ascii?Q?lz4ddvIJROELyZPV2hFxXiSbQzGl98zs/F7eZlABeo1UO35BhAoV/SI8uNJF?=
 =?us-ascii?Q?al4bTgy8yEkifxkJgte70EVzZ8uNX/oxzwi/5azVrXlW/3InCq/414cVOsDL?=
 =?us-ascii?Q?ciZbe/XDVE22YQd80Ijmdj02LPC160q/iVhPxe9J4DOZV0Nhx6/nrAwpqA2h?=
 =?us-ascii?Q?VgW1pLk3lF+t2kavCva/+ONRPFshcIrBaX3PWT5Etf92Aa873MpvUwU/oapZ?=
 =?us-ascii?Q?hQuaFmkzufAiGavo0NgMt3W8YO4G4MdAr666BTDTfaiVU8ROo4dGE9qccNSW?=
 =?us-ascii?Q?tkTSNZ+LsNOzN2FRMpj3CQ3pgy2280Tq8MRlmIDa+SzwrFOapcAV9JFtTlXl?=
 =?us-ascii?Q?FVo0vT3lnvZR/USyKm4UKuJBDOqDq/Ho8x6t48lgfvc5fMp6aim4JxJ0wGit?=
 =?us-ascii?Q?gt3szBhD0ML+7jEv5+0pw1z4lLoRo815MotmM/+lBOQ/BFguuQSalMKYXQRU?=
 =?us-ascii?Q?qnJ0VlhzYLGVDHGKex/c/n+8u4puPISsCig7uDckPJcBFaOexK6SUOi7quAo?=
 =?us-ascii?Q?Vo3k1IGiO0cT6jCcrbRYwsth5OuySXp3nu/nhIZjacokxaSfd2VJJimLISVe?=
 =?us-ascii?Q?sVtgFhMmVvreDzkUMneHTkBHcM0XoCK0askl456/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7326.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e5b8329-1fff-4dd3-1905-08dd566a8698
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 13:36:08.0293 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zc+KOIffylaX9sRCuQ4sDhtAitJrrKn5K6U6hE3im7fCLbG2OgTOfBPTpCUuILugKS2ddohqwt0sVIztPSoEAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4121
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
> From: Bing Zhao <bingz@nvidia.com>
> Sent: Wednesday, February 26, 2025 6:38 PM
> To: Suanming Mou <suanmingm@nvidia.com>; Dariusz Sosnowski
> <dsosnowski@nvidia.com>; Slava Ovsiienko <viacheslavo@nvidia.com>; Ori
> Kam <orika@nvidia.com>; Matan Azrad <matan@nvidia.com>
> Cc: dev@dpdk.org; Raslan Darawsheh <rasland@nvidia.com>
> Subject: RE: [PATCH 2/3] net/mlx5: add jump FDB Rx flag
>=20
> Hi
>=20
> > -----Original Message-----
> > From: Suanming Mou <suanmingm@nvidia.com>
> > Sent: Tuesday, February 25, 2025 8:45 AM
> > To: Dariusz Sosnowski <dsosnowski@nvidia.com>; Slava Ovsiienko
> > <viacheslavo@nvidia.com>; Bing Zhao <bingz@nvidia.com>; Ori Kam
> > <orika@nvidia.com>; Matan Azrad <matan@nvidia.com>
> > Cc: dev@dpdk.org; Raslan Darawsheh <rasland@nvidia.com>
> > Subject: [PATCH 2/3] net/mlx5: add jump FDB Rx flag
> >
> > When jump FDB Rx is supported, flow will be able to jump from FDB Tx
> > to FDB Rx, in that case the dest action in FDB Rx table should support
> > FDB Tx as well.
> >
> > Signed-off-by: Suanming Mou <suanmingm@nvidia.com>
> > ---
> >  drivers/common/mlx5/mlx5_devx_cmds.c | 8 ++++++++
> > drivers/common/mlx5/mlx5_devx_cmds.h | 1 +
> >  drivers/net/mlx5/linux/mlx5_os.c     | 1 +
> >  drivers/net/mlx5/mlx5.h              | 1 +
> >  drivers/net/mlx5/mlx5_flow_hw.c      | 8 +++++++-
> >  5 files changed, 18 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/common/mlx5/mlx5_devx_cmds.c
> > b/drivers/common/mlx5/mlx5_devx_cmds.c
> > index f504b29f31..eb8553e8ad 100644
> > --- a/drivers/common/mlx5/mlx5_devx_cmds.c
> > +++ b/drivers/common/mlx5/mlx5_devx_cmds.c
> > @@ -924,6 +924,7 @@ mlx5_devx_cmd_query_hca_attr(void *ctx,
> >  	uint32_t out[MLX5_ST_SZ_DW(query_hca_cap_out)] =3D {0};
> >  	bool hca_cap_2_sup;
> >  	uint64_t general_obj_types_supported =3D 0;
> > +	uint64_t stc_action_type_127_64;
> >  	void *hcattr;
> >  	int rc, i;
> >
> > @@ -1352,6 +1353,13 @@ mlx5_devx_cmd_query_hca_attr(void *ctx,
> >  		attr->fdb_unified_en =3D MLX5_GET(wqe_based_flow_table_cap,
> >  						hcattr,
> >  						fdb_unified_en);
> > +		stc_action_type_127_64 =3D
> MLX5_GET64(wqe_based_flow_table_cap,
> > +						    hcattr,
> > +						    stc_action_type_127_64);
> > +		if (stc_action_type_127_64 &
> > +		   (1 <<
> > (MLX5_IFC_STC_ACTION_TYPE_JUMP_FLOW_TABLE_FDB_RX_BIT_INDEX -
> > +			  MLX5_IFC_STC_ACTION_TYPE_BIT_64_INDEX)))
> > +			attr->jump_fdb_rx_en =3D true;
>=20
> I assume integer value 1 is enough, since it is a bit field, no need to u=
se bool
> type.
Will change it to 1.

>=20
> >  	}
> >  	/* Query HCA attribute for ROCE. */
> >  	if (attr->roce) {
> > diff --git a/drivers/common/mlx5/mlx5_devx_cmds.h
> > b/drivers/common/mlx5/mlx5_devx_cmds.h
> > index 8de4210fb2..6c726a0d46 100644
> > --- a/drivers/common/mlx5/mlx5_devx_cmds.h
> > +++ b/drivers/common/mlx5/mlx5_devx_cmds.h
> > @@ -326,6 +326,7 @@ struct mlx5_hca_attr {
> >  	uint32_t lag_rx_port_affinity:1;
> >  	uint32_t wqe_based_flow_table_sup:1;
> >  	uint32_t fdb_unified_en:1;
> > +	uint32_t jump_fdb_rx_en:1;
> >  	uint8_t max_header_modify_pattern_length;
> >  	uint64_t system_image_guid;
> >  	uint32_t log_max_conn_track_offload:5; diff --git
> > a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
> > index 9410211e3b..4e64026137 100644
> > --- a/drivers/net/mlx5/linux/mlx5_os.c
> > +++ b/drivers/net/mlx5/linux/mlx5_os.c
> > @@ -1718,6 +1718,7 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
> >  		priv->unified_fdb_en =3D !!priv->master;
> >  		DRV_LOG(DEBUG, "port %u: unified FDB %s enabled.",
> >  			eth_dev->data->port_id, priv->unified_fdb_en ? "is" :
> > "isn't");
> > +		priv->jump_fdb_rx_en =3D sh->cdev-
> > >config.hca_attr.jump_fdb_rx_en;
>=20
> Can we add some INFO or DEBUG level log to indicate this to the user?
Sure, and I think here we have another improvement as if unified_fdb is not=
 enabled, jump_fdb_rx_en does not make any sense. Will update.

>=20
> >  		if (priv->sh->config.dv_esw_en) {
> >  			uint32_t usable_bits;
> >  			uint32_t required_bits;
> > diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h index
> > f73f6e63ff..545ba48b3c 100644
> > --- a/drivers/net/mlx5/mlx5.h
> > +++ b/drivers/net/mlx5/mlx5.h
> > @@ -1987,6 +1987,7 @@ struct mlx5_priv {
> >  	uint32_t num_lag_ports:4; /* Number of ports can be bonded. */
> >  	uint32_t tunnel_enabled:1; /* If tunnel offloading is enabled on
> > rxqs. */
> >  	uint32_t unified_fdb_en:1; /* Unified FDB flag per port. */
> > +	uint32_t jump_fdb_rx_en:1; /* Jump from FDB Tx to FDB Rx flag per
> > +port. */
> >  	uint16_t domain_id; /* Switch domain identifier. */
> >  	uint16_t vport_id; /* Associated VF vport index (if any). */
> >  	uint32_t vport_meta_tag; /* Used for vport index match ove VF LAG.
> > */ diff --git a/drivers/net/mlx5/mlx5_flow_hw.c
> > b/drivers/net/mlx5/mlx5_flow_hw.c index f0888dbf0e..83f55ed3e8 100644
> > --- a/drivers/net/mlx5/mlx5_flow_hw.c
> > +++ b/drivers/net/mlx5/mlx5_flow_hw.c
> > @@ -9322,6 +9322,7 @@ flow_hw_grp_create_cb(void *tool_ctx, void
> *cb_ctx)
> >  	struct mlx5_flow_group *grp_data;
> >  	struct mlx5dr_table *tbl =3D NULL;
> >  	struct mlx5dr_action *jump;
> > +	uint32_t hws_flags;
> >  	uint32_t idx =3D 0;
> >  	MKSTR(matcher_name, "%s_%s_%u_%u_matcher_list",
> >  	      attr->transfer ? "FDB" : "NIC", attr->egress ? "egress" :
> > "ingress", @@ -9342,10 +9343,15 @@ flow_hw_grp_create_cb(void
> > *tool_ctx, void *cb_ctx)
> >  		goto error;
> >  	grp_data->tbl =3D tbl;
> >  	if (attr->group) {
> > +		hws_flags =3D mlx5_hw_act_dest_table_flag[dr_tbl_attr.type];
> > +		/* For case of jump from FDB Tx to FDB Rx as it is supported
> > now. */
> > +		if (priv->jump_fdb_rx_en &&
> > +		    dr_tbl_attr.type =3D=3D MLX5DR_TABLE_TYPE_FDB_RX)
> > +			hws_flags |=3D MLX5DR_ACTION_FLAG_HWS_FDB_TX;
> >  		/* Jump action be used by non-root table. */
> >  		jump =3D mlx5dr_action_create_dest_table
> >  			(priv->dr_ctx, tbl,
> > -			 mlx5_hw_act_dest_table_flag[dr_tbl_attr.type]);
> > +			 hws_flags);
> >  		if (!jump)
> >  			goto error;
> >  		grp_data->jump.hws_action =3D jump;
> > --
> > 2.34.1

