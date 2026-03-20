Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42DA108B90B
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Mar 2026 12:02:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 210E8402B2;
	Fri, 20 Mar 2026 13:02:58 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012047.outbound.protection.outlook.com [40.107.209.47])
 by mails.dpdk.org (Postfix) with ESMTP id DFFB1400EF
 for <dev@dpdk.org>; Fri, 20 Mar 2026 13:02:55 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F4VwpeEeETmIilGAXRYgoVwRUdeDxlHanA2Np/RVSYYQ/8GvQCe0sBfV1N+L0LGQR4oKZZyp/CM17ipwlhknoRKCb5IQXB/GW4UfO7GKHNSJrv5KTv4JH0pm8SXW8ELWDoOynSCL6B6JFJy6Zf8ToPw/fnlNNA+N8ov8OJ3SZYOp7sLau4G01/rKrRcSTBRVvnjlxMdenGxrCYko2TlrdDCpY90RSOT1ggqzY+g5UdfVmkbHH+z36WmwGvmkHWKukSjKfb/AeL3fmL/EyBcgkDvmnLRPMOLOsT6W3GmnGDvlzWl0RWjg00a4sUNLY73xznoVOpZKYid1iUsT52ouCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rnDWOXcvbNqPEahjNy5fcOiL0PjCaEKa/9iD/bcrZ0=;
 b=HcJBOpciuIrAZqHMQG9qeSggMrG83K1wD3X6X5w4ZrSR3DpA7leb4APnAH2pg7W/ucz19Ww6CZxS3VMbMpxv/EC1dnYKsUEJgLp3BAl3e2+FBA4RDhnQvqu75TghPcj9mxDavqrCLOLebwUnGJY+xXCUIoGU+gBot9pv89MGGJWNvyZ0KDvyAUqvw86MMXRwM7XHo2Iz7in5ynwbZOD29Lw0BYKalFtn+F2Os1Ipl1VIOApQGWhKI9qFb0aHVlX3mvVBO1Vbu3roAB+WHBMlE1IqQEyY9ZLG/tb7vN89Gwo2R5rZQNU23aBI66pA2Of2xeiNMPiymVqPy3VHIXdmog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rnDWOXcvbNqPEahjNy5fcOiL0PjCaEKa/9iD/bcrZ0=;
 b=mqv3SMwDrrjNBGwCHzDhcAuhDJQCGhF9Ew1F5uuP/19/o5ffFQIgXR/+0bXXLp8s5oqHBeNyPMJfBPmnXH+Jlx7wQLXpI+0c40I9rF/Dp7h28vfLLbvBYQ+O/u/JGKme11pGA/E49oMLSurIJ8Xo3giXJ6uJqZeLXx6JNpEq9a9mujDD0CRDvx/4M5nMECKF9ht9BYx9vBXN8UwJLWsI2EsR8NU1A482DCVdZYWuQ3Ekj1Q+nox0jH5fCNMMsPZCHlyFP8PxxwSi2r5GgqC3f7tQdzXblNHV8tbC+vEgpTDG4iDqh5WJPRy6XoXZJuPib2ZWrblOZtYVETq7bFOoOQ==
Received: from DM4PR12MB6087.namprd12.prod.outlook.com (2603:10b6:8:b1::12) by
 SA1PR12MB7176.namprd12.prod.outlook.com (2603:10b6:806:2bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 12:02:52 +0000
Received: from DM4PR12MB6087.namprd12.prod.outlook.com
 ([fe80::3359:f44d:6814:3ec3]) by DM4PR12MB6087.namprd12.prod.outlook.com
 ([fe80::3359:f44d:6814:3ec3%4]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 12:02:52 +0000
From: Slava Ovsiienko <viacheslavo@nvidia.com>
To: Vincent Jardin <vjardin@free.fr>, "dev@dpdk.org" <dev@dpdk.org>
CC: Raslan Darawsheh <rasland@nvidia.com>, "NBU-Contact-Thomas Monjalon
 (EXTERNAL)" <thomas@monjalon.net>, "andrew.rybchenko@oktetlabs.ru"
 <andrew.rybchenko@oktetlabs.ru>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>
Subject: RE: [PATCH v3 02/9] common/mlx5: query packet pacing rate table
 capabilities
Thread-Topic: [PATCH v3 02/9] common/mlx5: query packet pacing rate table
 capabilities
Thread-Index: AQHcsmvjh7MmdR972EO5pyQ+Xk9nqLW3XgtA
Date: Fri, 20 Mar 2026 12:02:52 +0000
Message-ID: <DM4PR12MB60870830FA026723C8E87245DF4CA@DM4PR12MB6087.namprd12.prod.outlook.com>
References: <20260310092014.2762894-1-vjardin@free.fr>
 <20260312220120.3256755-1-vjardin@free.fr>
 <20260312220120.3256755-3-vjardin@free.fr>
In-Reply-To: <20260312220120.3256755-3-vjardin@free.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6087:EE_|SA1PR12MB7176:EE_
x-ms-office365-filtering-correlation-id: f4b4e3d0-4841-494e-867f-08de86789d1b
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|56012099003|18002099003|22082099003|41080700001|15866825006;
x-microsoft-antispam-message-info: E4+XmTS6/w69uHaXBMSyt+WXDK2+QjO8+QBXdQGmgkxD6TCkyWtsjTrXWQcJyquWAZnqrYExWWHenq3kodmilSOfMl4+UzfMYgfignp5eaIYSZ+DN3NkLGPDG1utbIxQnPPeBMLbq47mQFBv35/FUFaNsUeRo+HyDQ8Zx845qZkDCeoS24MHEWc19GWvxLDC/+rzA7vQWEvtaZ0HHWvopufXTOOR+fFwQ0uFysfvmf97pncNAARYyQQ8hD5BkPwsKB0Y1wrLbIkeu6ZboK1dxnraT45oDDbbIo9LVr24vE03Lnu6we9trWNWnKXV79mDuZlmpRhiig14VKyVDxTlmftOAgq/4CMBnzTSWiu9OFhJ1k1EXenmR5bu9DRBw5lgIoFVyV5vu48CbcZ1ZW3AQI6mKENvC+p7ktx4Sljuxoug1c9SzooHpY2j+No6QykIHEzSP+GAeXuR+APp0bNXXS8Oih1OHOIolMpybMNjwluszmU7MEx4S/fepCwwycQpHcoWBtmwN53r+5ngAQmgWMuQISL+WGP4pAN5pi3RQstwddFRWUCTkhWrSSqIfD2DiGR3v7FudhxmPlq9K+L4HA3o3Z/kZQRyx4c4etlYQ6ap4e9WxVlF91tBdUqpBvydzH9c2yBGmg0LFFhoo1OHccitgWupFoiLxaE7SiOJQjjXEiLGoV7Vq9W554wWMeLtFXfGwRqIl/aQDNpyEsdNOqaXArxoK80S7DRcbb/CBI6mtDhmy4+JGTx5Q24go9UIKZXE9C9e/ejmf/SBrOWNl7NOqK++BqeITXV0WP3TJVAq3yn/hHyaY1A9dfgMx2OrfJ8YUYw06Qqu/v1dZBHRvmauOYMFf1ak7ZOcUN5DAnw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6087.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099003)(18002099003)(22082099003)(41080700001)(15866825006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UluCbJQBOWzyy5oOpgzNiEH1OWtLstvodyhQyUoR2nnXu31G/7t+SDMpIjq8?=
 =?us-ascii?Q?gAJMspdB5UGxQtGSbRiiQhkS6FAy5KAhnUxLnICU5LWW22eyb2gAbhMaUG60?=
 =?us-ascii?Q?RYaYzrofkKqwRE0DUnpeozMnPMYD/KaM84k+uswNIxc+KCE1YkeODEZ/KTmB?=
 =?us-ascii?Q?dH3d4a1+t0kN7UL4sx+udpFN2E06x8cUMHswcIrO9p+TQ3o6Xmm8K3F0s6pw?=
 =?us-ascii?Q?ossMDh4hoX0cap4MaOKo+mkPSI5C4N86+ibUsOYSXT8919zs/iFs+zwDlGOB?=
 =?us-ascii?Q?eDS/IPF8ZtlUbLHWjgxW5+KEUHzykgFavt+gyyhnxU5wqGuBf1x5L9iz7ex2?=
 =?us-ascii?Q?yYbadaciCuJaXIvCjz8L2dSNg5Gt4SQbXvWdi4rDAsQ1xow3FmpBB9sfGeeH?=
 =?us-ascii?Q?RwDW0P5Rk30bHAD1MOuZZmzvTLaOO2Wv0/6vH7JMnrLGUohNxkTrlVqi1GSB?=
 =?us-ascii?Q?gQXTbZUKXqR4Csmx4KOMyK3etBZi40ZaAdaulvI+vav7nEXmuANhCP//RHVB?=
 =?us-ascii?Q?r/om4uWB0ffZkfk8rZVZEemLRtiFsAuzteTQEjC0qlUiAbKwjX8/LEmK+kZc?=
 =?us-ascii?Q?ZlLuhx0wiyKP1RVxNETziR6AGd+mRa9AtwgMHZGEXuG2YpFWtakC6YVcAVly?=
 =?us-ascii?Q?sqQkBnOQOr/InJduk+jOjG2+MVpjtqh+S1TFskohzXOWw15J1rqI8IXA10sS?=
 =?us-ascii?Q?LWqWWMJbTnFUpGRGG54G01G9grVWs1TJ60wTfnj2X7TIbo5N+L9y3bQsTCRb?=
 =?us-ascii?Q?2C+iufiveh55DJYQOWbAHZh4DQqH8w7JzXW+Vv7AOa/WKsMsLodX2NiLEoQX?=
 =?us-ascii?Q?9SEB049akjwba0in8NIDdCWP5IfrRlJoOND5BPDz1S9NYNpEhV1zPYqOH7t6?=
 =?us-ascii?Q?UpT80kIDEGAip49hFYpr/KjyRIyT1t3d6W3sL2gpsVwVL+AIu8Vak1tspqcC?=
 =?us-ascii?Q?3tgkvJR/ZIfj4nIopvp19uLExVaQbRw/BLvTc7hTymkGvvbAacPrZru6n/8g?=
 =?us-ascii?Q?BUcicpa1BiMzT0qikJxARmHhyGrc6VQCXgeHcgLf+yoZ9/dl6J/TacMe8raG?=
 =?us-ascii?Q?ToXhz8eXbJhHsPRdCZOHsyAR0qzRi06oErb6jM12ir3inFzhAD11XdX3B10D?=
 =?us-ascii?Q?kyzDyImTBBXBjvprb7m3VdaBv+iFdFPM8l+awk0bOL3F4Z8NH8RT+I4LzGOW?=
 =?us-ascii?Q?NgKC83k+fx+rT5i+0OfVxtSz2iOMvyLHR1vQNEgT/IDsz5BuBfJsXrsfExRL?=
 =?us-ascii?Q?kDAD5Hv1bOpkYnuBXvprdgse1HTu2WgiV8zdUAjHK3EiyTd/iQ5jkv4u7kFz?=
 =?us-ascii?Q?KIBXX5COrVHjHOjQnCPJOZMT+5wloFhB1cBQbwkcSxOwpnLPc8Sl/2xdYrGq?=
 =?us-ascii?Q?e/rCjbaTry6nBsW7t2KNktrRLNb2sfZXduJlvzbPgzaDzvGY78RgActaoNlH?=
 =?us-ascii?Q?TYSGX3E6f36qNU4PB+ooR+5r3z05WonR3zA92S0lzVuF8cEZlzsD5dBkftRi?=
 =?us-ascii?Q?mgtAQLw3D2jVAz2AsbbjaJqLyoBHnMkyt7Y7AbhGjWZIAGTRjysKGMOZSF16?=
 =?us-ascii?Q?0jiYoAFVwraK9TeJCFk3I6OQM2mOHGLiUiSYlECaFY05v5UqDu0e1WxGZowT?=
 =?us-ascii?Q?XfkF/XmlSGSYzm58DbgqoL1EfkmjSkMSLSciArBVWz92GvA14CEANxQLggnZ?=
 =?us-ascii?Q?2lVS4Djd6e324vbbz0ty5AxMFKs2SdcuCUJqE1n9brjCb6z1NR+j6nllxemQ?=
 =?us-ascii?Q?WWTczVtqJg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6087.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4b4e3d0-4841-494e-867f-08de86789d1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 12:02:52.2166 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fKWb4pzTCDIdv+YtdUExP32Dr+NCHAOTMsfsRz4xWVU4pAFJHYrASbaduqp2IdJuxQSAsxLDUDsLCfe+3wg6/w==
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

Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>

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
> Subject: [PATCH v3 02/9] common/mlx5: query packet pacing rate table
> capabilities
>=20
> Query additional QoS packet pacing capabilities from HCA attributes:
> - packet_pacing_burst_bound: HW supports burst_upper_bound parameter
> - packet_pacing_typical_size: HW supports typical_packet_size parameter
> - packet_pacing_max_rate / packet_pacing_min_rate: rate range in kbps
> - packet_pacing_rate_table_size: number of HW rate table entries
>=20
> These capabilities are needed by the upcoming per-queue rate limiting fea=
ture
> to validate devarg values and report HW limits.
>=20
> Supported hardware:
> - ConnectX-6 Dx and later (different boards expose different subsets)
> - ConnectX-5 reports packet_pacing but not all extended fields
> - ConnectX-7/8 report the full capability set
> - BlueField-2 and later DPUs also report these capabilities
>=20
> Not supported:
> - ConnectX-4 Lx and earlier (no packet_pacing capability at all)
> - ConnectX-5 Ex may not report burst_bound or typical_size
>=20
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> ---
>  drivers/common/mlx5/mlx5_devx_cmds.c | 15 +++++++++++++++
> drivers/common/mlx5/mlx5_devx_cmds.h | 11 ++++++++++-
>  2 files changed, 25 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/common/mlx5/mlx5_devx_cmds.c
> b/drivers/common/mlx5/mlx5_devx_cmds.c
> index d12ebf8487..8f53303fa7 100644
> --- a/drivers/common/mlx5/mlx5_devx_cmds.c
> +++ b/drivers/common/mlx5/mlx5_devx_cmds.c
> @@ -1244,6 +1244,21 @@ mlx5_devx_cmd_query_hca_attr(void *ctx,
>  				MLX5_GET(qos_cap, hcattr, packet_pacing);
>  		attr->qos.wqe_rate_pp =3D
>  				MLX5_GET(qos_cap, hcattr, wqe_rate_pp);
> +		attr->qos.packet_pacing_burst_bound =3D
> +				MLX5_GET(qos_cap, hcattr,
> +					packet_pacing_burst_bound);
> +		attr->qos.packet_pacing_typical_size =3D
> +				MLX5_GET(qos_cap, hcattr,
> +					packet_pacing_typical_size);
> +		attr->qos.packet_pacing_max_rate =3D
> +				MLX5_GET(qos_cap, hcattr,
> +					packet_pacing_max_rate);
> +		attr->qos.packet_pacing_min_rate =3D
> +				MLX5_GET(qos_cap, hcattr,
> +					packet_pacing_min_rate);
> +		attr->qos.packet_pacing_rate_table_size =3D
> +				MLX5_GET(qos_cap, hcattr,
> +					packet_pacing_rate_table_size);
>  		if (attr->qos.flow_meter_aso_sup) {
>  			attr->qos.log_meter_aso_granularity =3D
>  				MLX5_GET(qos_cap, hcattr,
> diff --git a/drivers/common/mlx5/mlx5_devx_cmds.h
> b/drivers/common/mlx5/mlx5_devx_cmds.h
> index da50fc686c..930ae2c072 100644
> --- a/drivers/common/mlx5/mlx5_devx_cmds.h
> +++ b/drivers/common/mlx5/mlx5_devx_cmds.h
> @@ -67,7 +67,16 @@ struct mlx5_hca_qos_attr {
>  	/* Power of the maximum allocation granularity Object. */
>  	uint32_t log_max_num_meter_aso:5;
>  	/* Power of the maximum number of supported objects. */
> -
> +	uint32_t packet_pacing_burst_bound:1;
> +	/* HW supports burst_upper_bound PP parameter. */
> +	uint32_t packet_pacing_typical_size:1;
> +	/* HW supports typical_packet_size PP parameter. */
> +	uint32_t packet_pacing_max_rate;
> +	/* Maximum supported pacing rate in kbps. */
> +	uint32_t packet_pacing_min_rate;
> +	/* Minimum supported pacing rate in kbps. */
> +	uint16_t packet_pacing_rate_table_size;
> +	/* Number of entries in the HW rate table. */
>  };
>=20
>  struct mlx5_hca_vdpa_attr {
> --
> 2.43.0

