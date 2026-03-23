Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B918F46100
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 12:59:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 103BA40268;
	Mon, 23 Mar 2026 13:59:35 +0100 (CET)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011003.outbound.protection.outlook.com [52.101.57.3])
 by mails.dpdk.org (Postfix) with ESMTP id D8FF64025F
 for <dev@dpdk.org>; Mon, 23 Mar 2026 13:59:33 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Of1IJjhN5cMIJQwKFzL2pSCwBuZee8Xro9A7UVnZj/XasmM/V9v+qVPy/zySg1QztECG5ui4LP3L0I+0Ee8vgcmG1hZY+N0kYgbMvKEYzdzXV9SA/ut/3pBqWv129SJp95qHZUYBleyl8g63TbDmHuKDk44S5uCVSJxfH17orCqI138pf0Fawt3VgQS/OhtStRA+LkxeeJnBLLmdTWx8LTxKNmrI6GAeJv0hBrILS2fpEmJOCgqar1FkGccRwVbl+XsWb3nnU/ZhN+/iiqb3+sbXOn1K06/yHt6m3gUWe9ppyCnq6v/SqArd3dEHZs2v7FfGt7DhCsaETB1oivcplA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbdjUHH93AZm8TosqRHywA4AuPpZzmh7shjzSxyn45E=;
 b=LyHVGQurSqqCHovDVp0lwq7THzk9JIaV6wzeODu5cajsg42gFRO26HzhKJSlbPhMmiVxTl3fAn7WaqKCp6TtCq9/WzHGYZRuuOGK15yprytyElbnUgEdQ5xZxA5iNngCqDx/yW42yroX5P34FYzgHgLj3tKD6vWzQC6AWIGmMeN7NNl5dpzaFEXX/dqCgy/VrMyQVY3nRqNu6utKiqQxagxtTSLQm8hCPd+U0CRKijSiXgPiBJf/iubZ4Jeq0G6+PSpogAlZo7a2ZK11chrbaEHzNq/jJ+3QM3VRR61yBO75Rp/S+hh9x1LulDN/GtrO98vWFQJGpKUoCdkUTw0E2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbdjUHH93AZm8TosqRHywA4AuPpZzmh7shjzSxyn45E=;
 b=O0aMw851YCNlGOMRqnOotUziOqqPrnbHcwYrrzMrETMLRdZv0ZVpjImR8YAj0Je9HHSfIV4WrLqM09eGxkexMPgx4NYyIM08gt+9Vjfv3v8aiG+3gFxMJac9tPxrRMHD/DEFatdzuPHty6yF2jpjvuomxf+DBKg5xjiGMpB4Qn+vPMMQxlxkjZZvJPuTuYVvjSxZYSU3vfmFr1XErZPV0swCeueNv125x9cSfZGKp4Kkjo9aYVAn+PC8+mi+w88+6ZM6L7ShDnDiVbNqU5k6DBCBvN/CFYjwfSsBF7nd9HtzFsfJ9nCcQHAgCPjEEnhXPsPO2k+1EEjAbuMvhBqplA==
Received: from DM4PR12MB6087.namprd12.prod.outlook.com (2603:10b6:8:b1::12) by
 DS0PR12MB6416.namprd12.prod.outlook.com (2603:10b6:8:cb::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.20; Mon, 23 Mar 2026 12:59:30 +0000
Received: from DM4PR12MB6087.namprd12.prod.outlook.com
 ([fe80::3359:f44d:6814:3ec3]) by DM4PR12MB6087.namprd12.prod.outlook.com
 ([fe80::3359:f44d:6814:3ec3%4]) with mapi id 15.20.9745.015; Mon, 23 Mar 2026
 12:59:30 +0000
From: Slava Ovsiienko <viacheslavo@nvidia.com>
To: Vincent Jardin <vjardin@free.fr>, "dev@dpdk.org" <dev@dpdk.org>
CC: Raslan Darawsheh <rasland@nvidia.com>, "NBU-Contact-Thomas Monjalon
 (EXTERNAL)" <thomas@monjalon.net>, "andrew.rybchenko@oktetlabs.ru"
 <andrew.rybchenko@oktetlabs.ru>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "aman.deep.singh@intel.com" <aman.deep.singh@intel.com>
Subject: RE: [PATCH v4 03/10] common/mlx5: extend SQ modify to support rate
 limit update
Thread-Topic: [PATCH v4 03/10] common/mlx5: extend SQ modify to support rate
 limit update
Thread-Index: AQHcugJ3GiKMBxZXcU2BrgymmqTCv7W8FbFw
Date: Mon, 23 Mar 2026 12:59:30 +0000
Message-ID: <DM4PR12MB608743BBFC5BE9FD8FEAFB12DF4BA@DM4PR12MB6087.namprd12.prod.outlook.com>
References: <20260312220120.3256755-1-vjardin@free.fr>
 <20260322134629.94633-1-vjardin@free.fr>
 <20260322134629.94633-4-vjardin@free.fr>
In-Reply-To: <20260322134629.94633-4-vjardin@free.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6087:EE_|DS0PR12MB6416:EE_
x-ms-office365-filtering-correlation-id: 12aa8192-6eac-41ea-eeca-08de88dc05c1
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|18002099003|22082099003|56012099003|41080700001|15866825006;
x-microsoft-antispam-message-info: 98tmyRyM0RPi/js7ulXfURs3NZ9CJ62wD5NOIrIM3QUWFNLCp4gayyvgtxL0sJzmAuXpjASC2D+UyfACi/VFoE7ZotVfUoyJR6bk2XP3z9oBeS/yt5zHIk1Pxf5xtBcJFdvQdIXorAVfZB3ef7u+sOddSG7jiFO0QMkWu03pTlKdPsNY0teMhmID3NL3wxfCywCrqxQPrbaZu0QexkcmrzJrUdsMswIZfTqWljDZAq7aHHSwQMN1OzqQBAII40p1RVE6HL2Y6mgasU00j7j9BhNksjAz2ahTic2qdl16WW3LEWnU+p2R37nqS4mKS70E6UEPkCBhCQOQUexHop4ehn2iKXGvkbubJ4kpAobUwyROAkF3+4g6WtWpC7Oi2+Tb3/wpH54hsWLnkTdTX50byRJkZKkjGJ1PMQI4hrLzzjrJWzO7YhPGTj+9gq/r2qMsT+2I3RMmSba/qzhV2TQOYUfsZU4f0pVVWmHUzj8orr7uAIBfd2Y0Gxype0BaD0aDpcGOrh1PQvJrgY+vl215VWo/70OWMJq86UaWwSL1yBENlDRw/U0J0Qw87Yka5oyFLZpjl8/TQu1ndI9O8cBScU6DytiC74pttaSJEmxNVNjkA2gj/yB9WNJdhJ330WfF6Y6cMyKIWhV/Sta2JFT8o2QnwU/lLHCN+ZLHVDAX/mKDASVBV4dn8SKJ9Ey0GSz+sBHu+hRx3NbWgwCxWvsDmuLds0OFzJLij1G3B+3odF+bINfd2uiQVW5AcXFCkaPzH1/+AZkIQQFoUhaiQjAuvhv9UaVDCxVLI05BcyvSFeT+NM91+E5zgNIoXTVadlBiZQIygU6ZQa0nl39bD5Ya58nqdjQz0uX8oruzOxExegM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6087.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(56012099003)(41080700001)(15866825006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?I/uGTRp19/5rLp5CwYLC4oDAL9p3FUv/q2I2PvFA1bxTCOjEWF+UsHLVU9dD?=
 =?us-ascii?Q?L/S+PwsN/7h9925sJyIIEH8HFB2/kDqZad9zyFIeYkGvOaYsUJ909ezrUscO?=
 =?us-ascii?Q?14BZNfuMIVf1Vmcl6ZX8kWVMiSTKAxh1dBUhONyHg940WkqYxpWbDJqk7iF8?=
 =?us-ascii?Q?lWnMPY3+w8U7IWDyHktsTy0t2spyqx42RoD92SLeRnWGDUizbYEjOGkEEeQr?=
 =?us-ascii?Q?icLBfulxZ9jkEKhkiCpmqCyDDSbBmKJs9KU2ifvgpeAPGQTK+jXSGmua6tGj?=
 =?us-ascii?Q?9Pot+QojGfwM/DrDlb/UM6V4xnykX20uXbHJVs+58IOHDjvX0ln0ChGlI30N?=
 =?us-ascii?Q?cQMcxPZ0O9wlpOjYgQIZl/A0h1yb/e1zfuAKXw+5ApMTK4OUOhy+F+PHtUPA?=
 =?us-ascii?Q?6/8S5y73yVJ/ciAK7Q2az6sOldQ18N+s0EvimfDyNyUDWhs9QM0nVevj9v8I?=
 =?us-ascii?Q?g6lPpSmUUwe2lPM2qncD4jj9HWByFPThXbacpMsBbBtYAPUZT5Vq0JjJewVS?=
 =?us-ascii?Q?mvbjnPkL1HsYOcVF5q56IdV6tSJuN8fsRlAOHV4HjB1DjOnF1cRI4KkBpNTR?=
 =?us-ascii?Q?ZIH1dZ+HihGHEEVXWC8Ny8VMefINf4tJ0GLzlZwSBci/QGgF6Mb5xKjK7MIg?=
 =?us-ascii?Q?T7fFs8O0+S6N3LuEGxsVCPOhaP09/U40euyouPFja3I+mhfn4dMSHRtiRnpl?=
 =?us-ascii?Q?dJGGM3pbOe+gfwmtysxMViZgBG9/yIVgYWWdLDBgJbeDCLWmbkGiyhimrW/P?=
 =?us-ascii?Q?N15Kodwk9jijZHWGVqBL37RNbg0mWGrmJXLiP0reojhMIdn4J1O8BJe+lsjw?=
 =?us-ascii?Q?siw3+Y7RoX5Q8+NKUzjxvDGfA/NRTkXs+QPOu9wsFWmoWI2/O/ySLvMiEDs/?=
 =?us-ascii?Q?IKALUeFxCkaG7IyHhPEtK2PUkM0HHku/x6fK0xrcgzpcAySG0/5jw2slUbwn?=
 =?us-ascii?Q?cGrIzEbgo2QGqZVrqA48aHQuh9ZZKupAugXNbUMbIk69k6QwVLflS7IRRl1h?=
 =?us-ascii?Q?5dkLCcrmUyr1sKkkdmiKq/vufK+j17cvBZDcD6XfGlcSVsj1an9dzQj7NNQL?=
 =?us-ascii?Q?XhWBD4u4KKmjPJ0mfI8vZp1ADiVOhixF0Lc1zpJnoc7rPkfhdaWPYIM8mWxG?=
 =?us-ascii?Q?S/3g49BsDAEnzNAp4Ck54vhcXdEUom9bTRP0x7znIYjUrZVNEb3FbEYA4poY?=
 =?us-ascii?Q?hqrErRji80OD7WNggKX7/d397/jLZ6cIYF/Ilv90hfMpX/ywngOOda6/7hzx?=
 =?us-ascii?Q?j5tcX0kT31BCFTfGYqkedw/bXNohhwWvss7fI2KTkY7rf6DCCgJUrOC7++2k?=
 =?us-ascii?Q?/Uhake87Q+lADpLF3xgwdMnB4J/95C5I97BCRSSnhWqx7/3FBuR3f7e+cZ7H?=
 =?us-ascii?Q?ndHN6kIqhqAV2zGOlgFcP6xKYkdAtvCrFccF3RVcYMXrAsOpxiLJiDWEyu+q?=
 =?us-ascii?Q?XX4usKq03/j/RksEFiu//f3xJyvPQPJMmDEt/2mlK7dCb/GTelmjaC3Ow9Nw?=
 =?us-ascii?Q?2FN1R7ZEWS6hfLxMvrv5grqs7GwIDgCLpcoi0pHg5rnD+cV9gC9yuTlPZjda?=
 =?us-ascii?Q?FT/HhAOUJebEw1Qo9u3Jb/x4eF9Fy12iCkk+i3gt2pHo0dOx/JXb2cprCDsd?=
 =?us-ascii?Q?V/WCjGopA+yaIbDauXIH51YvAG+XA2styZEdq7hPkP7xYJ3VfcnnIDCFRTqf?=
 =?us-ascii?Q?6vyuhVVz0k8E2vqGr1asf5bSa22zlcScahf1x/Un0n85o2wYoPYhZont4C5s?=
 =?us-ascii?Q?x58QF9lqhw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6087.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12aa8192-6eac-41ea-eeca-08de88dc05c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 12:59:30.3741 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vtkna81lkPxER4mZHMfaWFMHhanGx432DpawU3Sx9SNrBPFU8NGfeylLvJDe3P6o+HnqSuM1IdXBjQoYZkxaJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6416
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
> Subject: [PATCH v4 03/10] common/mlx5: extend SQ modify to support rate
> limit update
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
>  drivers/common/mlx5/mlx5_devx_cmds.c | 8 ++++++++
> drivers/common/mlx5/mlx5_devx_cmds.h | 3 +++
>  drivers/common/mlx5/mlx5_prm.h       | 7 +++++++
>  3 files changed, 18 insertions(+)
>=20
> diff --git a/drivers/common/mlx5/mlx5_devx_cmds.c
> b/drivers/common/mlx5/mlx5_devx_cmds.c
> index 8f53303fa7..102f84fd5c 100644
> --- a/drivers/common/mlx5/mlx5_devx_cmds.c
> +++ b/drivers/common/mlx5/mlx5_devx_cmds.c
> @@ -2129,6 +2129,14 @@ mlx5_devx_cmd_modify_sq(struct mlx5_devx_obj
> *sq,
>  	MLX5_SET(sqc, sq_ctx, state, sq_attr->state);
>  	MLX5_SET(sqc, sq_ctx, hairpin_peer_rq, sq_attr->hairpin_peer_rq);
>  	MLX5_SET(sqc, sq_ctx, hairpin_peer_vhca, sq_attr-
> >hairpin_peer_vhca);
> +	if (sq_attr->rl_update) {
> +		uint64_t msk =3D MLX5_GET64(modify_sq_in, in,
> modify_bitmask);
> +
> +		msk |=3D
> MLX5_MODIFY_SQ_IN_MODIFY_BITMASK_PACKET_PACING_RATE_LIMIT_IND
> EX;
> +		MLX5_SET64(modify_sq_in, in, modify_bitmask, msk);
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
> diff --git a/drivers/common/mlx5/mlx5_prm.h
> b/drivers/common/mlx5/mlx5_prm.h index ba33336e58..597d06362f 100644
> --- a/drivers/common/mlx5/mlx5_prm.h
> +++ b/drivers/common/mlx5/mlx5_prm.h
> @@ -2985,6 +2985,7 @@ struct mlx5_ifc_create_tis_in_bits {
>  	struct mlx5_ifc_tisc_bits ctx;
>  };
>=20
> +/* Bits for modify_rq_in.modify_bitmask (Receive Queue). */
>  enum {
>  	MLX5_MODIFY_RQ_IN_MODIFY_BITMASK_WQ_LWM =3D 1ULL << 0,
>  	MLX5_MODIFY_RQ_IN_MODIFY_BITMASK_VSD =3D 1ULL << 1, @@ -
> 2992,6 +2993,12 @@ enum {
>  	MLX5_MODIFY_RQ_IN_MODIFY_BITMASK_RQ_COUNTER_SET_ID =3D
> 1ULL << 3,  };
>=20
> +/* Bits for modify_sq_in.modify_bitmask (Send Queue). */ enum {
> +
> 	MLX5_MODIFY_SQ_IN_MODIFY_BITMASK_PACKET_PACING_RATE_LI
> MIT_INDEX =3D
> +		1ULL << 0,
> +};
> +
>  struct mlx5_ifc_modify_rq_in_bits {
>  	u8 opcode[0x10];
>  	u8 uid[0x10];
> --
> 2.43.0

