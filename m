Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8223CD5BCF
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 05:57:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9BD9C40280;
	Tue, 26 May 2026 07:57:10 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012053.outbound.protection.outlook.com [52.101.53.53])
 by mails.dpdk.org (Postfix) with ESMTP id 6688540279;
 Tue, 26 May 2026 07:57:09 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JXmWOOysNuqElEblTpeJY9saYgWfc/GdnXJ9xZV25+b0HPMCJXayWP5gkqkdYUL1GHLjJ4HzdEfcU/hEhH2F2FQQCOw/K9qRGMY9genfqpOxqV7iZaEzKkJeyOhlafHhzFIHp3CUEU0gTFMSMNpos7BxB9Wxwwb5A4UVxRR/Xo0ZsWAoMnx/jPIP/sUUrug+Qcu8gVw1E/hWVu0mkHRD/RMeRwSbzl3oFJ+wwBc0nPX67/q2FUYFAu/US/fl7gnO+BYungQ6BDY2zOaX1f42aGGaPhsukePyg9elNGIqvP2TSYDzzytQCCWCTHOxA0+6EgcGzcO1+6Tt3qt1oX2D+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HrGh6fXFq7/uDbLeURC64fIB2nF1WVIevEpWWa089SQ=;
 b=LWNrMxWroBxUswF4Mlc90inHwo++Ha4VT0vBuVkShKqaxs8vKn41Z8YFy5BaQ1dS7S52E212ovSBQHTLY6HTqVWXIui/XS4oZZyOlykmwHb6wX265+Fj4LQTJGrXSReciiF3iIWV+CJDHY+NE1Cg4W6nHZx7zEgP+67PAT/gDrmiMD8IBy/EPURGoBCh1ZKjU6gzsI/1C5s6/FpUWVn80ACGEmko338fynMJROA1vSsAR1JehGrpb8U3gUj+HVc81SbDdJGl9Sl6AGelaHL+88PQKffsn6s43ZqaowZWJkATl+91uUfnFfK4wjday4+cY7BNitjVRDy11/AjOrSTgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HrGh6fXFq7/uDbLeURC64fIB2nF1WVIevEpWWa089SQ=;
 b=ZO94yjh1prsNzF/Fq+4qvuMTxzz0iHQFjL/rLf2NDV16yyXpKI4UnuAUYDzTAWKj0R67baQHi4JrZ/Ni/WLIUGGyVqZCvM1+5SkwdD5Ke2JWtzjSjBFv0HvRUmLEs9yLiWEwrUmTpniUHNBPxN/SD+9lVolgJ+ryhlfHwxFA4sCwfhknzH4EXcSTe5z6RobOQytcNDsF4v3RBwppdXcxL1+wvisS37ur+6Js9TuMOtRzeK1RrTU/BC52cOoC/a0pH5/XV1mXnUusVgAqnSo+rsrgoo1JqfypRnTf+poHScfS5RRTfTm82VgSiCY0GBiVYmPlHRWFSROqAEXCXWUvmQ==
Received: from BN9PR12MB5338.namprd12.prod.outlook.com (2603:10b6:408:103::23)
 by MW3PR12MB4459.namprd12.prod.outlook.com (2603:10b6:303:56::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 26 May
 2026 05:57:05 +0000
Received: from BN9PR12MB5338.namprd12.prod.outlook.com
 ([fe80::7b66:315e:f851:8ddb]) by BN9PR12MB5338.namprd12.prod.outlook.com
 ([fe80::7b66:315e:f851:8ddb%6]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 05:57:04 +0000
From: Bing Zhao <bingz@nvidia.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>, Slava Ovsiienko
 <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] net/mlx5: redirect LACP traffic for legacy E-Switch
Thread-Topic: [PATCH] net/mlx5: redirect LACP traffic for legacy E-Switch
Thread-Index: AQHc5Geq8uBBRUdl3k+4qyCY1QK59LYf4AWw
Date: Tue, 26 May 2026 05:57:04 +0000
Message-ID: <BN9PR12MB5338DAC8EBC5211595329276D00B2@BN9PR12MB5338.namprd12.prod.outlook.com>
References: <20260515123700.354341-1-dsosnowski@nvidia.com>
In-Reply-To: <20260515123700.354341-1-dsosnowski@nvidia.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5338:EE_|MW3PR12MB4459:EE_
x-ms-office365-filtering-correlation-id: 6ff8e6c6-986d-40f8-d552-08debaeb9d03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003|38070700021|11063799006|6133799003;
x-microsoft-antispam-message-info: twwztCsI6XVd5TPw3kjahU3iNT2R/onsfXHN2FQsJC6FtkdCvyARPKmapdMeX1T3gRucNzneS6h3RY1iZKao7FT7aikCoLE4l6Sl69OPW5/Snx+Ze8bndH3m0or3piNUKss4x3aNy/qm91cmfw1x7RqHvpRj/VR55weTrBMGgbbDzgIlzlpSjaD/TCJf0WIUxJ4D23J9PIl8hwisYV3EI9fTjATge1qz7DOGXjWdCO/a01chwpm13wUodnfz/cnoRGgdPAdeo80UtOxLvC+tP3mLJBudM8Uj9kmDnpPGkpkfpwtcvZEXjayK+1f/xoNp44+Jv8xMEKbcnBzykADDuj9rQYxCdX6uQlmDtAfafVb97w2wjsIslOY6kmJzFtrb6F42NDOPuyPIwzvaTyEJSWMIGrnJYLsqRrvbflRKMX88am2LayIEJVbnm2jiFiFiZPtUcsBvt+8MJwJvgVAYqsE32HPGBcDWXk6VDAGsbK1ytbb39/TjErKW7VR9FZYOvOc8vpmn+IUf2VRLMcFmLR9o26TwReI5ELMpuQX2UkYOnS9B68hreAQUQ3EVZjSSDuvkMAE/6JlVkKTGHTGQNXRgfK9HbZO6praEnJB9Xj3sM0ogMp0BYc2fw45rCjcT8oBmVaXs96W6ak2r3d3CuTGcdfjkKVwKpmzo+Xr5TEJ+iVhFPYVHT4xmK1w6s+5pJ1J6efDWEUq+wGObG3pFaHGd78oXtoLvCBX6aYcx/c2k7siy38z8wImm8mA7g5TU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5338.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003)(38070700021)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TuyVL1vBAkMebHXMW0Lf4i4BrfRahMVZKM+URIGMUY2QLYD1YPIIeF/fJ4aT?=
 =?us-ascii?Q?HdbatV90+LrmCT+UvbXsq4FkwtpynTho4SlH5YXWbw/1W7a8mwlWMe3Qe2co?=
 =?us-ascii?Q?iEAMR6kTsu1/AFnDopC5OBRnvypJuWpsSQ7bFvbiXHviF4afrhVdkJSTqpHE?=
 =?us-ascii?Q?2W5EnvKBwU3v59UbWE8XriDNU0Td4HGAVPZgW6+XfdbExfbfdDdaWtJOsj7A?=
 =?us-ascii?Q?rzkg/V67DFAGunRcb5Kjfup7stCRwqdcKh7GuMJKV98ZIuMAIGpTd79YfUpV?=
 =?us-ascii?Q?7IhG6fXBCUzEl20aKq80A2iD+mtz2BZetzQg3T2OTdrpN3boe3DAlhYRutZd?=
 =?us-ascii?Q?Hl1OTrHYe4WPh707trNWVsCF9WA+J4MCxjvHT07v51wpI1mPMsnFJvZXcPnT?=
 =?us-ascii?Q?swIjl6WJqNxwSQv/jWGaPaoNTJCoU9NB2abciBVNHfpG+sxjrsHoN1bBK+jL?=
 =?us-ascii?Q?+t6/y7vnYd/DnXsVGAaQDFJcpiviITz6rMWZrXb+VfX0zwdvchDzNg7wOF0Z?=
 =?us-ascii?Q?gctPYORPB6U5uk2NeUVJf45EZPFEjziayHqmnRY29q6ITvzxfJiolwleQA3+?=
 =?us-ascii?Q?35bCJN6yruoK7sCyFME8CrxR2FOIX6HhI5u1zGsvdH7LY3Iekwjde5peWrAm?=
 =?us-ascii?Q?nesMM2XP6/VxDg7jWRdgeNHKsm+4Uae4v4pt3PhR/5e7OiU0c6n3Kk2RjSnk?=
 =?us-ascii?Q?vn+fmAv/UeUI5y7hQt4HfPmhGfm8hkfilv8GWZcfGvwE8YMGGFDbuK6VS6QF?=
 =?us-ascii?Q?YgrTtDhETktAT/piydpkIu5mJRBpYAZRXuvgP0/H0/m3FzBbvmsetc6fkw+P?=
 =?us-ascii?Q?lek94yritckpGTrc/bbRMjFXLsvJh15oaUusd0+bq4suQHf05QmMs3H0ksW0?=
 =?us-ascii?Q?ZCCMo53HX874zGwGSkYQ5CmU3HlXfdgagLyyMQkyQF7NAGlqUgx3KTrPYEBd?=
 =?us-ascii?Q?IEcKIvMgPbtv2GAnngQVfDi7JeAj28GI6u0sOEeIwHbRJiVOeWH4D4G1HeYa?=
 =?us-ascii?Q?dFK5yyzRyUzGzFxVnDCc+iRXJ0kvSTEhIHpe9/m8/a4bLWxVGKRF3Kqyx0Id?=
 =?us-ascii?Q?4Nq9hzjpUYeM2oi6jyC6ME+TYNsAjwyksXSs4EXoDLxoIQ+Tj96B7RorGnuX?=
 =?us-ascii?Q?W2C7R6TYxdb7ApoFwRxkKhzSeJfKlHqLFF9HaZDIXrjAqZvwmziFxV0BPKX6?=
 =?us-ascii?Q?f9u5QmlM2PKBizB0glZWRth6qdvrhEYprlnHsNsEKbrwAw8SeeV/20mcSKmY?=
 =?us-ascii?Q?J2E6MSeVxlzUGCYG7iMfhAuea9sUE/X5xF352nDCEiGsV3XNq9nkAVnoUX8D?=
 =?us-ascii?Q?Ap1w3SzMk0osTKKJCNbBoWiiOv5jjmZw22Dkkkc9Yxalx9LbizjZldWeasUu?=
 =?us-ascii?Q?5V/HaS28XaQu11k2hHmpDdhL+Xtobc62ZmlRavQEJGkKDDvqcYyl3zpSgoe/?=
 =?us-ascii?Q?qb7Tmdp9XEorKpqzQ/4RlZNZAj1DOppnOSaQHr9wLPAYrBUyNi1TfZPGtkhN?=
 =?us-ascii?Q?BGcj9TV/mvl3o5BeI41kgVfOIZV19fNk17cw4zNNRLblQWA0ux1U6ofXbODV?=
 =?us-ascii?Q?IjaHSc+lqnMdITmOEqcHQPPfbOUGgQsXY26d4mPKn4v4xmklMdQ93CwWZBN3?=
 =?us-ascii?Q?V8s4VMyStB0aq2pyO/2Mzd0qskffx+gJqkZToplt3ON9T1BpQuaYebmcGaig?=
 =?us-ascii?Q?cHmZi2QRTDeyI1jckPnUn8f4m7eQt4DNSwgB6VZ3LHSUsLEL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5338.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff8e6c6-986d-40f8-d552-08debaeb9d03
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 05:57:04.7457 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sj8FZmnl3Ujr9M1E0DfQewCEbXDpZhKgg3on9Ue1lnV1uAEXEwHctgr8cu6QZiU+Uv1gsMy9v1Tcf8rM8k9gAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4459
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
> From: Dariusz Sosnowski <dsosnowski@nvidia.com>
> Sent: Friday, May 15, 2026 8:37 PM
> To: Slava Ovsiienko <viacheslavo@nvidia.com>; Bing Zhao
> <bingz@nvidia.com>; Ori Kam <orika@nvidia.com>; Suanming Mou
> <suanmingm@nvidia.com>; Matan Azrad <matan@nvidia.com>
> Cc: dev@dpdk.org; stable@dpdk.org
> Subject: [PATCH] net/mlx5: redirect LACP traffic for legacy E-Switch
>=20
> Offending patch fixed the LACP miss rule logic for NICs where switchdev i=
s
> enabled. In this case, LACP miss rules should be inserted if and only if
> started port is a main port on the embedded switch.
> Side effect of that change was that LACP miss rules are not inserted when
> switchdev is disabled and legacy SR-IOV switch mode is used.
>=20
> This patch addresses that:
>=20
> - Fix the LACP rule insertion condition.
> - Move HWS table for LACP rule creation out of FDB rules,
>   so they can be created separately.
>=20
> Fixes: 87e4384d2662 ("net/mlx5: fix condition of LACP miss flow")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> ---
>  drivers/net/mlx5/mlx5.h         |   1 +
>  drivers/net/mlx5/mlx5_flow.h    |  40 ++++++++-
>  drivers/net/mlx5/mlx5_flow_hw.c | 140 ++++++++++++++++++++++++--------
>  drivers/net/mlx5/mlx5_trigger.c |   7 +-
>  4 files changed, 145 insertions(+), 43 deletions(-)
>=20
> diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h index
> 49a0c03544..ab5c76bfc4 100644
> --- a/drivers/net/mlx5/mlx5.h
> +++ b/drivers/net/mlx5/mlx5.h
> @@ -2040,6 +2040,7 @@ struct mlx5_priv {
>  	rte_spinlock_t hw_ctrl_lock;
>  	LIST_HEAD(hw_ctrl_flow, mlx5_ctrl_flow_entry) hw_ctrl_flows;
>  	LIST_HEAD(hw_ext_ctrl_flow, mlx5_ctrl_flow_entry) hw_ext_ctrl_flows;
> +	struct mlx5_flow_hw_lacp_miss *hw_lacp_miss; /* HWS LACP miss flow
> +tables */
>  	struct mlx5_flow_hw_ctrl_fdb *hw_ctrl_fdb; /* FDB control flow
> context */
>  	struct mlx5_flow_hw_ctrl_nic *hw_ctrl_nic; /* NIC control flow
> context */
>  	struct rte_flow_pattern_template *hw_tx_repr_tagging_pt; diff --git
> a/drivers/net/mlx5/mlx5_flow.h b/drivers/net/mlx5/mlx5_flow.h index
> c9e72a33d6..3f5ba55bf9 100644
> --- a/drivers/net/mlx5/mlx5_flow.h
> +++ b/drivers/net/mlx5/mlx5_flow.h
> @@ -3031,6 +3031,13 @@ struct mlx5_flow_hw_ctrl_rx {
>=20
> 	[MLX5_FLOW_HW_CTRL_RX_EXPANDED_RSS_MAX];
>  };
>=20
> +/* Contains all templates and table required for redirecting LACP
> +traffic with HWS. */ struct mlx5_flow_hw_lacp_miss {
> +	struct rte_flow_pattern_template *lacp_rx_items_tmpl;
> +	struct rte_flow_actions_template *lacp_rx_actions_tmpl;
> +	struct rte_flow_template_table *hw_lacp_rx_tbl; };
> +
>  /* Contains all templates required for control flow rules in FDB with
> HWS. */  struct mlx5_flow_hw_ctrl_fdb {
>  	struct rte_flow_pattern_template *esw_mgr_items_tmpl; @@ -3042,9
> +3049,6 @@ struct mlx5_flow_hw_ctrl_fdb {
>  	struct rte_flow_pattern_template *port_items_tmpl;
>  	struct rte_flow_actions_template *jump_one_actions_tmpl;
>  	struct rte_flow_template_table *hw_esw_zero_tbl;
> -	struct rte_flow_pattern_template *lacp_rx_items_tmpl;
> -	struct rte_flow_actions_template *lacp_rx_actions_tmpl;
> -	struct rte_flow_template_table *hw_lacp_rx_tbl;
>  };
>=20
>  struct mlx5_flow_hw_ctrl_nic {
> @@ -3735,6 +3739,36 @@ mlx5_indirect_list_handles_release(struct
> rte_eth_dev *dev);
>=20
>  bool mlx5_flow_is_steering_disabled(void);
>=20
> +/**
> + * Returns true if Rx control rule for LACP traffic is needed.
> + *
> + * mlx5 PMD needs to create a rule matching LACP traffic and forwarding
> it back to kernel if:
> + *
> + * - Underlying device is a bond interface.
> + * - User did not request to handle LACP traffic in user space.
> + *
> + * Creation of this rule is also controlled by the E-Switch mode:
> + *
> + * - It must be created in legacy mode.
> + * - It must be created only on proxy port in switchdev mode.
> + *
> + * @param[in] priv
> + *   Pointer to Ethernet device structure.
> + *
> + * @return
> + *   True if LACP rules must be created.
> + *   False otherwise.
> + */
> +static inline bool
> +mlx5_flow_lacp_miss_needed(struct rte_eth_dev *dev) {
> +	struct mlx5_priv *priv =3D dev->data->dev_private;
> +
> +	return !priv->sh->config.lacp_by_user &&
> +	    priv->pf_bond >=3D 0 &&
> +	    (!priv->sh->esw_mode || (priv->sh->esw_mode && priv->master)); }
> +
>  #ifdef HAVE_MLX5_HWS_SUPPORT
>=20
>  #define MLX5_REPR_STC_MEMORY_LOG 11
> diff --git a/drivers/net/mlx5/mlx5_flow_hw.c
> b/drivers/net/mlx5/mlx5_flow_hw.c index b6bb9f12a6..c133230cb7 100644
> --- a/drivers/net/mlx5/mlx5_flow_hw.c
> +++ b/drivers/net/mlx5/mlx5_flow_hw.c
> @@ -10820,15 +10820,6 @@ flow_hw_cleanup_ctrl_fdb_tables(struct
> rte_eth_dev *dev)
>  	if (!priv->hw_ctrl_fdb)
>  		return;
>  	hw_ctrl_fdb =3D priv->hw_ctrl_fdb;
> -	/* Clean up templates used for LACP default miss table. */
> -	if (hw_ctrl_fdb->hw_lacp_rx_tbl)
> -		claim_zero(flow_hw_table_destroy(dev, hw_ctrl_fdb-
> >hw_lacp_rx_tbl, NULL));
> -	if (hw_ctrl_fdb->lacp_rx_actions_tmpl)
> -		claim_zero(flow_hw_actions_template_destroy(dev, hw_ctrl_fdb-
> >lacp_rx_actions_tmpl,
> -			   NULL));
> -	if (hw_ctrl_fdb->lacp_rx_items_tmpl)
> -		claim_zero(flow_hw_pattern_template_destroy(dev, hw_ctrl_fdb-
> >lacp_rx_items_tmpl,
> -			   NULL));
>  	/* Clean up templates used for default FDB jump rule. */
>  	if (hw_ctrl_fdb->hw_esw_zero_tbl)
>  		claim_zero(flow_hw_table_destroy(dev, hw_ctrl_fdb-
> >hw_esw_zero_tbl, NULL)); @@ -10898,6 +10889,99 @@
> flow_hw_create_lacp_rx_table(struct rte_eth_dev *dev,
>  	return flow_hw_table_create(dev, &cfg, &it, 1, &at, 1, error);  }
>=20
> +/*
> + * Clean up templates and table used for redirecting LACP traffic to
> kernel.
> + *
> + * @param dev
> + *   Pointer to Ethernet device.
> + */
> +static void
> +flow_hw_cleanup_lacp_miss_tables(struct rte_eth_dev *dev) {
> +	struct mlx5_priv *priv =3D dev->data->dev_private;
> +	struct mlx5_flow_hw_lacp_miss *hw_lacp_miss;
> +
> +	if (priv->hw_lacp_miss =3D=3D NULL)
> +		return;
> +
> +	hw_lacp_miss =3D priv->hw_lacp_miss;
> +
> +	if (hw_lacp_miss->hw_lacp_rx_tbl)
> +		claim_zero(flow_hw_table_destroy(dev, hw_lacp_miss-
> >hw_lacp_rx_tbl, NULL));
> +	if (hw_lacp_miss->lacp_rx_actions_tmpl)
> +		claim_zero(flow_hw_actions_template_destroy(dev,
> +							    hw_lacp_miss-
> >lacp_rx_actions_tmpl,
> +							    NULL));
> +	if (hw_lacp_miss->lacp_rx_items_tmpl)
> +		claim_zero(flow_hw_pattern_template_destroy(dev,
> +							    hw_lacp_miss-
> >lacp_rx_items_tmpl,
> +							    NULL));
> +
> +	mlx5_free(hw_lacp_miss);
> +	priv->hw_lacp_miss =3D NULL;
> +}
> +
> +/*
> + * Create templates and table for redirecting LACP traffic to kernel.
> + *
> + * LACP traffic redirection is needed whenever LACP bond is managed by
> the kernel.
> + * Required rule has a following structure:
> + *
> + * - ingress rule on root table
> + * - match EtherType 0x8809
> + * - action DEFAULT_MISS
> + *
> + * @param dev
> + *   Pointer to Ethernet device.
> + *
> + * @return
> + *   0 on success. Negative errno otherwise.
> + */
> +static int
> +flow_hw_create_lacp_miss_tables(struct rte_eth_dev *dev) {
> +	struct mlx5_priv *priv =3D dev->data->dev_private;
> +	struct mlx5_flow_hw_lacp_miss *hw_lacp_miss;
> +
> +	if (mlx5_flow_is_steering_disabled())
> +		return 0;
> +
> +	hw_lacp_miss =3D mlx5_malloc(MLX5_MEM_ZERO, sizeof(*hw_lacp_miss), 0,
> SOCKET_ID_ANY);
> +	if (!hw_lacp_miss) {
> +		DRV_LOG(ERR, "port %u Failed to allocate memory for LACP miss
> tables",
> +			dev->data->port_id);
> +		return -ENOMEM;
> +	}
> +	priv->hw_lacp_miss =3D hw_lacp_miss;
> +
> +	hw_lacp_miss->lacp_rx_items_tmpl =3D
> flow_hw_create_lacp_rx_pattern_template(dev, NULL);
> +	if (!hw_lacp_miss->lacp_rx_items_tmpl) {
> +		DRV_LOG(ERR, "port %u Failed to create pattern template for
> LACP Rx traffic",
> +			dev->data->port_id);
> +		goto error;
> +	}
> +	hw_lacp_miss->lacp_rx_actions_tmpl =3D
> flow_hw_create_lacp_rx_actions_template(dev, NULL);
> +	if (!hw_lacp_miss->lacp_rx_actions_tmpl) {
> +		DRV_LOG(ERR, "port %u Failed to create actions template for
> LACP Rx traffic",
> +			dev->data->port_id);
> +		goto error;
> +	}
> +	hw_lacp_miss->hw_lacp_rx_tbl =3D
> +		flow_hw_create_lacp_rx_table(dev, hw_lacp_miss-
> >lacp_rx_items_tmpl,
> +					     hw_lacp_miss->lacp_rx_actions_tmpl,
> NULL);
> +	if (!hw_lacp_miss->hw_lacp_rx_tbl) {
> +		DRV_LOG(ERR, "port %u Failed to create template table for LACP
> Rx traffic",
> +			dev->data->port_id);
> +		goto error;
> +	}
> +
> +	return 0;
> +
> +error:
> +	flow_hw_cleanup_lacp_miss_tables(dev);
> +	return -EINVAL;
> +}
> +
>  /**
>   * Creates a set of flow tables used to create control flows used
>   * when E-Switch is engaged.
> @@ -11000,31 +11084,6 @@ flow_hw_create_fdb_ctrl_tables(struct rte_eth_de=
v
> *dev, struct rte_flow_error *e
>  			goto err;
>  		}
>  	}
> -	/* Create LACP default miss table. */
> -	if (!priv->sh->config.lacp_by_user && priv->pf_bond >=3D 0 && priv-
> >master) {
> -		hw_ctrl_fdb->lacp_rx_items_tmpl =3D
> -				flow_hw_create_lacp_rx_pattern_template(dev,
> error);
> -		if (!hw_ctrl_fdb->lacp_rx_items_tmpl) {
> -			DRV_LOG(ERR, "port %u failed to create pattern template"
> -				" for LACP Rx traffic", dev->data->port_id);
> -			goto err;
> -		}
> -		hw_ctrl_fdb->lacp_rx_actions_tmpl =3D
> -				flow_hw_create_lacp_rx_actions_template(dev,
> error);
> -		if (!hw_ctrl_fdb->lacp_rx_actions_tmpl) {
> -			DRV_LOG(ERR, "port %u failed to create actions template"
> -				" for LACP Rx traffic", dev->data->port_id);
> -			goto err;
> -		}
> -		hw_ctrl_fdb->hw_lacp_rx_tbl =3D flow_hw_create_lacp_rx_table
> -				(dev, hw_ctrl_fdb->lacp_rx_items_tmpl,
> -				 hw_ctrl_fdb->lacp_rx_actions_tmpl, error);
> -		if (!hw_ctrl_fdb->hw_lacp_rx_tbl) {
> -			DRV_LOG(ERR, "port %u failed to create template table
> for"
> -				" for LACP Rx traffic", dev->data->port_id);
> -			goto err;
> -		}
> -	}
>  	return 0;
>=20
>  err:
> @@ -11754,6 +11813,7 @@ __mlx5_flow_hw_resource_release(struct rte_eth_de=
v
> *dev, bool ctx_close)
>=20
>  	mlx5_flow_hw_rxq_flag_set(dev, false);
>  	flow_hw_flush_all_ctrl_flows(dev);
> +	flow_hw_cleanup_lacp_miss_tables(dev);
>  	flow_hw_cleanup_ctrl_fdb_tables(dev);
>  	flow_hw_cleanup_ctrl_nic_tables(dev);
>  	flow_hw_cleanup_tx_repr_tagging(dev);
> @@ -12160,6 +12220,14 @@ __flow_hw_configure(struct rte_eth_dev *dev,
>  		if (ret)
>  			goto err;
>  	}
> +	if (mlx5_flow_lacp_miss_needed(dev)) {
> +		ret =3D flow_hw_create_lacp_miss_tables(dev);
> +		if (ret) {
> +			rte_flow_error_set(error, -ret,
> RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
> +					   "Unable to create LACP miss flow
> tables");
> +			goto err;
> +		}
> +	}
>  	if (is_proxy) {
>  		ret =3D flow_hw_create_vport_actions(priv);
>  		if (ret) {
> @@ -16234,10 +16302,10 @@ mlx5_flow_hw_lacp_rx_flow(struct rte_eth_dev
> *dev)
>  		.type =3D MLX5_CTRL_FLOW_TYPE_LACP_RX,
>  	};
>=20
> -	if (!priv->dr_ctx || !priv->hw_ctrl_fdb || !priv->hw_ctrl_fdb-
> >hw_lacp_rx_tbl)
> +	if (!priv->dr_ctx || !priv->hw_lacp_miss ||
> +!priv->hw_lacp_miss->hw_lacp_rx_tbl)
>  		return 0;
>  	return flow_hw_create_ctrl_flow(dev, dev,
> -					priv->hw_ctrl_fdb->hw_lacp_rx_tbl,
> +					priv->hw_lacp_miss->hw_lacp_rx_tbl,
>  					eth_lacp, 0, miss_action, 0, &flow_info,
> false);  }
>=20
> diff --git a/drivers/net/mlx5/mlx5_trigger.c
> b/drivers/net/mlx5/mlx5_trigger.c index a070aaecfd..32cd18717d 100644
> --- a/drivers/net/mlx5/mlx5_trigger.c
> +++ b/drivers/net/mlx5/mlx5_trigger.c
> @@ -1672,9 +1672,8 @@ mlx5_traffic_enable_hws(struct rte_eth_dev *dev)
>  	} else {
>  		DRV_LOG(INFO, "port %u FDB default rule is disabled", dev-
> >data->port_id);
>  	}
> -	if (!priv->sh->config.lacp_by_user && priv->pf_bond >=3D 0 && priv-
> >master)
> -		if (mlx5_flow_hw_lacp_rx_flow(dev))
> -			goto error;
> +	if (mlx5_flow_lacp_miss_needed(dev) &&
> mlx5_flow_hw_lacp_rx_flow(dev) !=3D 0)
> +		goto error;
>  	if (priv->isolated)
>  		return 0;
>  	ret =3D mlx5_flow_hw_create_ctrl_rx_tables(dev);
> @@ -1796,7 +1795,7 @@ mlx5_traffic_enable(struct rte_eth_dev *dev)
>  		DRV_LOG(INFO, "port %u FDB default rule is disabled",
>  			dev->data->port_id);
>  	}
> -	if (!priv->sh->config.lacp_by_user && priv->pf_bond >=3D 0 && priv-
> >master) {
> +	if (mlx5_flow_lacp_miss_needed(dev)) {
>  		ret =3D mlx5_flow_lacp_miss(dev);
>  		if (ret)
>  			DRV_LOG(INFO, "port %u LACP rule cannot be created - "
> --
> 2.47.3

Acked-by: Bing Zhao <bingz@nvidia.com>
