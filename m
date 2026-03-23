Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B24F46101
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 13:19:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2870E4064E;
	Mon, 23 Mar 2026 14:19:03 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012067.outbound.protection.outlook.com [52.101.48.67])
 by mails.dpdk.org (Postfix) with ESMTP id 7FEAB40268
 for <dev@dpdk.org>; Mon, 23 Mar 2026 14:19:01 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ysHXfwyAzptb2RrBweHLpKI4XstjQBkVE7BYXNleCpE7/A4dqFTla/1oMaf0IZ1pu31Pwb7BHlDK10LC1uidw0Fo4vwO+GPqsrqeiJkwzMwwWDIMs5OVUwIh1SpsVLefrRJ9DPDmi/rkXugS9fuYocl0lLZOmbnVcwdadna3jusjDvErMjwecVd+RWC557KREKB30/agP51jCgqhWBUKSTSdcBbkBV/g1gXanwkhfb/tc+l15Tz8ZdI1CArZooatK9Trxanob3yVbJ4AyJkPR9ElrtKIfXOKfsp5enYyCY//D89NwZgsTe3B/OGos5FKXjrCkNUolnGm+8meCs+m4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28m1XY49sC8zwR2/njmCaL1x+sgzY0wBUWpa6Fe06lA=;
 b=IIG20dgE6FbZrZFvD95uLPojgR9QkxJGPbbgctQxF5DlU7sYrWsPg8w3p01x2mz7qkEHJUgaoHZRFO8W8YnYeU2zWc6kb6Q/d57gCRoTym1bGUtq3ia8YTivX8Dzr+6tLl4Ij8Yyo0QxLj9UsLoBZPquwLipnoxnHz5sdDiISpfjLQwq/T8u394I0X65/qE4dlCfOYrjAFZHt1MW05cUrUGj5nDiPJccUhE5WfeEhx16H9lXomcEl3gt3n5KEksNyhW+7D0j4cUbmXHl1OGMehJgqR4kPiC90OJ9YWmVu4+/zW75g82QLA1oKmSnNB4RJD22wYIsaf8Cn6HEgV7GFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28m1XY49sC8zwR2/njmCaL1x+sgzY0wBUWpa6Fe06lA=;
 b=ltQRb0dc0Fe/orzdQZzdcbKBXL9UWjpQ3bZPBLWvIzQ/qQG2g/A3miAbywXC1x0xtFyaJZmcjEcWhMHUthReTKz1YzpPoG3Nw23u8p7FPFreKZy7eNJU9AnYDwtP9pXSJFwYQ7V4h9/bxoPcyBwOvbuTIAYCa+xMsisqq4NvZ27itugwrgF+HygcCx5CPfcrzWGg9AjoY0ZededHqnT0fO6WyJsUAhrph6BSoaCYTGC25TUJbamrtGJNQ/rOHmsley+W168fJxp2m3HyoCnYr+R4o/ygzYkkYM2FXA5R1R6ZlZrN74mAXmMLN6BaeZpX6zWt4gZ34q8GB6p1laRpTw==
Received: from DM4PR12MB6087.namprd12.prod.outlook.com (2603:10b6:8:b1::12) by
 MN0PR12MB6127.namprd12.prod.outlook.com (2603:10b6:208:3c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 13:18:55 +0000
Received: from DM4PR12MB6087.namprd12.prod.outlook.com
 ([fe80::3359:f44d:6814:3ec3]) by DM4PR12MB6087.namprd12.prod.outlook.com
 ([fe80::3359:f44d:6814:3ec3%4]) with mapi id 15.20.9745.015; Mon, 23 Mar 2026
 13:18:54 +0000
From: Slava Ovsiienko <viacheslavo@nvidia.com>
To: Vincent Jardin <vjardin@free.fr>, "dev@dpdk.org" <dev@dpdk.org>
CC: Raslan Darawsheh <rasland@nvidia.com>, "NBU-Contact-Thomas Monjalon
 (EXTERNAL)" <thomas@monjalon.net>, "andrew.rybchenko@oktetlabs.ru"
 <andrew.rybchenko@oktetlabs.ru>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "aman.deep.singh@intel.com" <aman.deep.singh@intel.com>
Subject: RE: [PATCH v4 06/10] net/mlx5: add burst pacing devargs
Thread-Topic: [PATCH v4 06/10] net/mlx5: add burst pacing devargs
Thread-Index: AQHcugKTn8Vjtp1+nUG3X24VYOQJt7W8Gyrw
Date: Mon, 23 Mar 2026 13:18:54 +0000
Message-ID: <DM4PR12MB60872FDC757C4FFC2656A3B6DF4BA@DM4PR12MB6087.namprd12.prod.outlook.com>
References: <20260312220120.3256755-1-vjardin@free.fr>
 <20260322134629.94633-1-vjardin@free.fr>
 <20260322134629.94633-7-vjardin@free.fr>
In-Reply-To: <20260322134629.94633-7-vjardin@free.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6087:EE_|MN0PR12MB6127:EE_
x-ms-office365-filtering-correlation-id: 12c18f3c-ff0c-4f0d-ef4b-08de88debbb7
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|56012099003|22082099003|18002099003|15866825006|41080700001;
x-microsoft-antispam-message-info: qLjoudTcjILy/JKVM2aVzByQIYIwbk5OG9VBIJK81nRAU+lQK2WoKTcA+URRKLv/QdJUgQi0H+B6p6eK0JEocPo+OvY5rf9jUs2WUnvDxbAplH/ifgKZK7H2jBOuc7bNspvFUhJJoOAGnfinHTuv1ta3aCS6jgmq1Gh2e1gjvjf27gJzXHLkdcI2XnseEmNj8aHg6veQb2xv98KoEs1TdU296IjedTeL3Je6Aflf+CwEKo7pExkqA4RYrIdaMTPjANFhjBmqPNRjVSnG29Sijo8UMU0RoeqcfLa+chwDMB52YwOTFBeMmRzMv/ZHzXrN8enGQnLZ1aSTC9ZGuRGIId2Hh31OdIx9NMcm2YVLYsXJozp9Bjxi6mxl7bN1x8iTAFCTGekZYu7pd7rNkMnL0AHmcSGbAA0MGE0sE1wUaYzRj+wCSMc4c7vRg4hp5OVzoCTa23J8h1R5MMnUyP7t+sTavseB8nHFbZHAAIIGYXb/tjfkMS2wVOoz1T8SuYBjN3gGWm2ukDqmw2zEoH2nK2aehJYVyWJSLAcBb0b3n0HxxoHm+qGoV8XQmIS/Z66ukBklkkn5JlLBB3RSNELkzR9c0Vh3XK1mc5jH1gmHBxKIVbOlTGRQAuAGD6eMpZW70VEBL9ew44O+aoyY92W3elhXn7RidQ1CiQK/e4TYMAd+K9svSOWq5QpxitFyTV/wZXUuzfwHMcigvHARrbwNbkVvlSKsGjewW5g3sLcytuXPqp0ADztO+3W2p/0fN7FWKYYrpfoRq879lVUSK0WeKYVpVI+jfCtgzSErMTjWT9DtnicQj+/APNKujd/H/O9rKW6yGjapdquJpxEXiKbOIoXDdPH394vx3G+6duPX1yU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6087.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(56012099003)(22082099003)(18002099003)(15866825006)(41080700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R6RMG26KcjwjmFfQbfiTUw2A6YIolwTGLZ75ZImiuSU5wTYUhxve1xnD+9HY?=
 =?us-ascii?Q?yLKvcRm/2gwZCZs1ONIHrDgXeEEh1+H10mXs+BEKNFhZP73GPxDoPSMDL9Im?=
 =?us-ascii?Q?PNyYhue033qu+Gsts0bcSqcyUUv3VAPE13ZLGpSxoD/QqBa3121EW4eV82tD?=
 =?us-ascii?Q?X8mTvEUUHWc96CXvObTJpcf9AS5SYO6Fmv+FAznCt0BmkS0JMIpS65XGGGV9?=
 =?us-ascii?Q?jr0TN8lwg5RVxDC8f3XR+FdE6H39VR/7S5mubI03xpMMrzyruFOZ+TWSZYs4?=
 =?us-ascii?Q?tI1HoAsfhgzmQVTdgG2ZWpuWLrFsvs1fp/pJ/lHJm0n6PfPSt+dtr1JvF04d?=
 =?us-ascii?Q?W+dL+SZZSOeiqBQQSjdaUGwIb7n2xZ7uOIZdKwFuy36fYZWIIN8/pyID1jB6?=
 =?us-ascii?Q?27ABfMoTe21ry50Nl1je54Rr/7bEP8nQJ+bp549vwU8jtDKrH7jHSFPdGW5R?=
 =?us-ascii?Q?NIP/OXLeJ7JwA58nE7i6rW3i+UFeatnjG+uZofz2esTYow59RXJABpo/wrt5?=
 =?us-ascii?Q?WrHeaFCYxEAcnB7vEEJ8na5uqAeluUyL9Ctik1GwLhlqR23mgrNlRVGWYtI2?=
 =?us-ascii?Q?kHvxFnfbuswE62GbCf2UTAZecwns3ijnWGRe+FoHpbarJG4BogU2HpdV+kGM?=
 =?us-ascii?Q?ng3Sa5NN1wfIr+UdlbYhD7pgQVBqMOTAtpfgsSafWnK5gOm1PxS9Kzri6G+S?=
 =?us-ascii?Q?Fqru+BX8LzoTTHMuFveAO8Qx9t5I0h/R8uXRBbTjqj5bmXt+xnGWjURMmwC9?=
 =?us-ascii?Q?WIIMFXWBguNyY1mP9wvsIySbyZy8X7h5xDRCsvtygPkFTYRvcfSFFyew9a9y?=
 =?us-ascii?Q?wWU3wLQ1BOJt7SUiQTK7JtK102VoQkpPc7N90a+d47haOKGg+hzn4g9F68e1?=
 =?us-ascii?Q?72hHJDF0qSdRtWqbcwEx2BfbBCiIvvc7PvBLyXHIegRzjezWBBDoFagIofUk?=
 =?us-ascii?Q?z6htKN8jLI7qfFaxCrYIU06QGs6d4zKOzbPk7H9OnBpn3dyfIFFgUQoebEV2?=
 =?us-ascii?Q?qXH5lBQWnxtoZ20Rp9gFC675yJJrfHOPqhKmyN1Vm9nlVt6aHgpX0BS3itks?=
 =?us-ascii?Q?dXa1zVrUrMdp470q4UDj1uKhMOc1Bg+aP6pCm4J1ni4TeKZllkNmXdutwExE?=
 =?us-ascii?Q?s12J1UlxlTzHYl5r6P5iV8JohUOaPEYXBmnPNNfqqop9ywa5CD793SPW0HvC?=
 =?us-ascii?Q?u4klJvGyr6fh10ATK4lIMwSIfTWC5ZJuddQPgbuqPZQ6JadWzFqOzKdq4JwH?=
 =?us-ascii?Q?+Pv+5/ZGTs2kdnCPbunHAQ6zCDmVAX8419xInK9FAn0B2A6pY6YGTR1Nd/xF?=
 =?us-ascii?Q?+X2YbT34M3QmxQAh/N9iwCzM3LLKvUFYsWHhE+eSApGrC2mW2cxBw2h1aTsb?=
 =?us-ascii?Q?qq34I7Nr4CeGIajRO8h2Ln2jeCdozHc9wMyngZ/ayZAzG0pVF2McDE9AjVot?=
 =?us-ascii?Q?MBl0aPHpEBKCyQU1qGmAr0pEqm1M7iEYySWC3o33WVJcIA31qk3FHotUV7c2?=
 =?us-ascii?Q?mUscl00idf2rSx0xjj9zUBD5kGaYWqnqXjdzMYL7BXQxHCYX4ySaZWteq9Sb?=
 =?us-ascii?Q?5wyqUH6nwYsRM/mTr/wG8StnSM48YFXpov0yMQHjvpcpYwL5va9muoDgSMpo?=
 =?us-ascii?Q?spbJyHwxOOaSdRSFD0zzpLZiz9WOoaR6Y4DX2WHB3Da5TSGWYm8020GQn1+c?=
 =?us-ascii?Q?fUIdLHxFWFkwDVXHJ4wD5RMoJevcIDeeihAHR+UquDjTyP9K4intSju/TaoW?=
 =?us-ascii?Q?TWHtERTExw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6087.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c18f3c-ff0c-4f0d-ef4b-08de88debbb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 13:18:54.6398 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: io3+xvpguN0o2UFIQAAZJB0nWOi+p5kRi1VJyOdbR5jXPxHE5yjLVObhNwRXnRNWz4RSkgXlkqtzynYBeYiGgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6127
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
> Subject: [PATCH v4 06/10] net/mlx5: add burst pacing devargs
>=20
> Expose burst_upper_bound and typical_packet_size from the PRM
> set_pp_rate_limit_context as devargs:
> - tx_burst_bound=3D<bytes>: max burst before rate evaluation kicks in
> - tx_typical_pkt_sz=3D<bytes>: typical packet size for accuracy
>=20
> These parameters apply to per-queue rate limiting
> (rte_eth_set_queue_rate_limit) only. The Clock Queue path (tx_pp devarg) =
uses
> WQE rate pacing and does not need these parameters.
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
>  doc/guides/nics/mlx5.rst     | 17 +++++++++++++++
>  drivers/net/mlx5/mlx5.c      | 42 ++++++++++++++++++++++++++++++++++++
>  drivers/net/mlx5/mlx5.h      |  2 ++
>  drivers/net/mlx5/mlx5_txpp.c |  6 ++++++
>  4 files changed, 67 insertions(+)
>=20
> diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst index
> c72a60f084..d0b403dd5c 100644
> --- a/doc/guides/nics/mlx5.rst
> +++ b/doc/guides/nics/mlx5.rst
> @@ -580,6 +580,23 @@ for an additional list of options shared with other
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
> + ``packet_pacing_burst_bound``  capability. Applies to per-queue rate
> + limiting  (``rte_eth_set_queue_rate_limit()``). The Clock Queue path
> + (``tx_pp``)  uses WQE rate pacing and does not use this parameter.
> +  The default value is zero (hardware default).
> +
> +- ``tx_typical_pkt_sz`` parameter [int]
> +
> +  Specifies the typical packet size in bytes for packet pacing rate
> + accuracy  improvement. Only effective when the HCA reports
> + ``packet_pacing_typical_size`` capability. Applies to per-queue rate
> + limiting only. The default value is zero (hardware default).
> +
>  .. _mlx5_per_queue_rate_limit:
>=20
>  Per-Queue Tx Rate Limiting
> diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c index
> e718f0fa8c..7d08d7886b 100644
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
> @@ -1407,6 +1419,10 @@ mlx5_dev_args_check_handler(const char *key,
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
>  	} else if (strcmp(MLX5_VF_NL_EN, key) =3D=3D 0) { @@ -1481,8 +1497,10
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
> @@ -1557,6 +1575,18 @@ mlx5_shared_dev_ctx_args_config(struct
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
> @@ -3191,6 +3221,18 @@ mlx5_probe_again_args_validate(struct
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
> 33628d7987..5ae01ec491 100644
> --- a/drivers/net/mlx5/mlx5.h
> +++ b/drivers/net/mlx5/mlx5.h
> @@ -383,6 +383,8 @@ struct mlx5_port_config {  struct mlx5_sh_config {
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
> e34e996e9b..707ef9d111 100644
> --- a/drivers/net/mlx5/mlx5_txpp.c
> +++ b/drivers/net/mlx5/mlx5_txpp.c
> @@ -176,6 +176,12 @@ mlx5_txq_alloc_pp_rate_limit(struct
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
>  	rate_limit->pp =3D mlx5_glue->dv_alloc_pp(sh->cdev->ctx, sizeof(pp),
>  						 &pp, 0);
>  	if (rate_limit->pp =3D=3D NULL) {
> --
> 2.43.0

