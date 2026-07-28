Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBFCC531C9
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Jul 2026 00:20:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB9D840279;
	Tue, 28 Jul 2026 02:20:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 34C3A400EF
 for <dev@dpdk.org>; Tue, 28 Jul 2026 02:20:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785198022; x=1816734022;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=wvP95ULe7+7SQJIAEGcF4CbGF8VM8u0TqBhYlogTGNA=;
 b=h4wLwESLa5BZW3fD0znaf2yVHe5j2KMEt20STz32+8sNHMIFaFzJjlam
 qCA8CdGrgoNC/JaSeYP4Ep9OeC+AbQRMSv3pbWancpxppGu5eDFKbXMDS
 8dX5TT1Z7W0ulRR+viI49CChg04Z64Ir+110rvWT8JX42p7cL5+ijDbm7
 CXKYQXskkMgkW3kylXDTKcT2t3y+bcUihApnDb0ZkxI9w7PAMAZIH+efD
 zWtMwvQYzv1k+wCXgnVZBKMoOIzd8p/QcyHElqyKlxvbZEXlhagJ7GuCh
 MjRmQnMhzTRG92CKRVb4OM2EOV7ThjGv5TTZIMdbsVKiSPyLq4F9TehsN A==;
X-CSE-ConnectionGUID: ZPAV/uv4QciF0ghiJNKsLQ==
X-CSE-MsgGUID: UBb5C5o2S0Ow1bErtBvEnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="108570756"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; d="scan'208";a="108570756"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jul 2026 17:20:21 -0700
X-CSE-ConnectionGUID: RG/g3odfSUezmtdiyYqkqQ==
X-CSE-MsgGUID: 4c2AmeskT/6CvuUHN1Ja8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; d="scan'208";a="256879672"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jul 2026 17:20:21 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 17:20:20 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 27 Jul 2026 17:20:20 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.65) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 17:20:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYqplAnE5/qg1VBsFnPUcjlUjHtI4azyX9KYgOV7US0ce7Y026sPsaNb0lfFNnWkCEu2LtBlTfxW4/uIh+LjD2v6+z2N5UteOD5mfkk+rWCeXURA27d+Cvj0mJWYpXRRu+VZNWDSS+K85kK6xFYCWdulm7ZQdFRHk62EQxlqQre2PcGgkJ94D7SVZQEuO79ey6Z/zv5ljLvra7KuWE4HJYSd1JWNvsZ9EbNkjeotZv6wIOv9UE1xMgzLz64SvqJf//hq+jioZNDsu54CDEqgnYJz3YkRErIBiOkrD9NnfZx5d6IwcQ1ALfhMveqH3lh0JiAcH/5O+YAvxqWxLjyXZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tkirm4ec1cBdeqLL2gp4KqNaO4o3F9cbLZ1hnG2RNw0=;
 b=coLwAPPLOwQFI2B9Kd4t6iAuGkkADNA0j7TJbKX8wm2Ge4G3MSV5l/aYyHfXUmE6JCf05ZiqwJOB/6ZHtXl8jpDyZyWYpitjU4yuSLfdmVMuHQQd+aqOjhYwCy/pWMXIT2suTh1UQ38f4JLBe59+O6QQyafg7YoqXsYORacLSJWLnFPlgPfepiSn0eVNcRl2JdtviMXkw6bGbymWFXHu9n2/xmtr0yL8uANcgINN2MprHH1d7Al71qZNkv+kYK+vTgKwf+MD7xj8TL6Xk6PWt56DTXhCgnW4gJ0JmZ3XY+CCqJTaKBMXOMwVcNZGHbLOoGqVr4TKqAI4GB57qkhGMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6782.namprd11.prod.outlook.com (2603:10b6:806:25e::11)
 by SAWPR11MB9924.namprd11.prod.outlook.com (2603:10b6:806:54d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 00:20:13 +0000
Received: from SA1PR11MB6782.namprd11.prod.outlook.com
 ([fe80::cd29:ea71:32e6:ff0b]) by SA1PR11MB6782.namprd11.prod.outlook.com
 ([fe80::cd29:ea71:32e6:ff0b%5]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 00:20:13 +0000
From: "Mandal, Anurag" <anurag.mandal@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH] net/idpf: add clock read support
Thread-Topic: [PATCH] net/idpf: add clock read support
Thread-Index: AQHdHe2mOnaPDpl0jUC70oYWV6WHvraCEa2w
Date: Tue, 28 Jul 2026 00:20:12 +0000
Message-ID: <SA1PR11MB6782931E9768BBFE43A2F3BFE4CB2@SA1PR11MB6782.namprd11.prod.outlook.com>
References: <20260727172946.824267-1-anurag.mandal@intel.com>
In-Reply-To: <20260727172946.824267-1-anurag.mandal@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6782:EE_|SAWPR11MB9924:EE_
x-ms-office365-filtering-correlation-id: 967b686f-a46f-4993-a0bd-08deec3dfdd5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|11063799006|10067099003|56012099006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: Y+ne7R2g1M4OvqI4RWQmYBglW5sEZegYxkM0AelfVSp4Ay+q9QkgVcNnFe8t36DHDH+/NVUdOMmNH7vWlfgQ++tFP3ZHguLkCegZYueXXtYgjALC8tGSpuytBPyAgPGl9e2LPPW7jvvigWnwz9Z4nx7X3j1vUt2jSaSvyB7F+Ge8xCjLnE1/xl46Plx+R2hCYOstwLP4bEv6sYjEcYFJCOo90NjDrJzwTazUXVk+gJY4YCfI6e7apV6+1trWtFdKqVYfVryK9aBDrw5RSdVrOnAivZkVBf0ZUg6q5ffiYnmFZaIVFOOHX2HvN9/1tfqZhWm1fh6Ts3mEmIQf9pWM43kIsR+rKVQg4t+7T5AXYi0JCH8bp0M//rjx79mbOjZXATfiRCziNJF13vgPhdYOu471oUstor/ka3nIlb1qUFvKa3UkL/QwHW25mqh01T7PhC0LDXnCOnil14cW/qC41UAKDTuBmd1juwEuoYXkmaKEsj8DfKVX4Nf3ISxO3736y79wEHmowliVk2GS1uPYEfeMKaKdlg6Msz6s+v41pi9q5GHsXuI4CQ/avRJ095NNyb1raya/zMAjNJd3102i3hT1VG0WB2KTzUZ1LgP7TvFrS2Td3zoDikxkYbsRisrjDtcUjLltSjKBWLHuUFIwEFDE8Krk2fQLekbFmDRQXZO46NBkbEuNLnjm3icqBQjjob2w3T+fFtW16WmJTR5eGA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR11MB6782.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LLCJl2JGe+SLPBvoiP1ntSIOqjeZAb7VPz/Bu316zs2NnXOelgLRnULvCtgW?=
 =?us-ascii?Q?WBYZQAl9Eq+k2t5Sbm0h3FvDKmDQ2ygK702AyIYgzarZLT7NCkCkM1HxEslX?=
 =?us-ascii?Q?e1KCTu202L/7pjUq5zSj+6et5PiHkjCHGn48hKKc1JsKsJzhJc4U1IrFiRx1?=
 =?us-ascii?Q?6Ev0+H9xaLoC+xcBULMWxlMX3xHoi2O4KUTt0bBISmiwvDE+MuEgZ0ND7LSq?=
 =?us-ascii?Q?8gAbpYgTQi07+kKcUoysjNFFTc9w2lcBZU2t+TSFhDEbEVXvcFpdqf7tgg9z?=
 =?us-ascii?Q?cs11XWk1XilkqNR/RBzo3s/8LIk90RKvzlOcfnTrXnFmJ2D+XqXtwqjSSBbx?=
 =?us-ascii?Q?V+lgcpyBqnglZmrqR5RspJOU9eipGh7T5pnxsGlSST+d6yNDGb3XjhTcj7fM?=
 =?us-ascii?Q?I/qKXv+/LxKdcITxyghmEC6cHGd/eAX3g0UeQ+cfS9aZ5v9DBfY2yVclEH3r?=
 =?us-ascii?Q?wjpx77JPke0mmSYsKGOa6A3R/AsCkEIiENzkRR58KZ2B8rkQp+2zVMid+91H?=
 =?us-ascii?Q?/ru+kpt5LQu0PzbqR1rQD0Z+FWBKrCxW0rM2PIG7xi0g9EJE5phcz7fcxG68?=
 =?us-ascii?Q?F6pa6jqi9hFcmoDMQnw18fAhuXdreETXHyE13fro1mJDUzHceH7qQIi7xblX?=
 =?us-ascii?Q?akkRiZP/S5dIFQjUG+zKIFMEkTwatIZeMbFUvb5zJDZVJyVOHQYcLIkQSPyr?=
 =?us-ascii?Q?kCfqhQuQvPCOcHj99St+5mRhNUK+VtFZYfau9VosILWgNXDGxDsc262ZISPN?=
 =?us-ascii?Q?a0nXK/7pj13Yk8QTUqtigIjjGe/NmwKPzbLrOYzc4oPiIu4D3DayTwryq2fw?=
 =?us-ascii?Q?j6PpPQcTxdNWE2hFq0wnh+GQzSsW2Qi0vQ6mcdhtEq5VJaDBv7n+R1SyABpU?=
 =?us-ascii?Q?YnECujGqbmGhEYqFzy5KJpZs3xVp6heh26na97J3vL8M44/g7h4VWsuQi8ju?=
 =?us-ascii?Q?MqDu8cNoKrurzrP1XdxEBebz/uVcV9y/T7bPk6XXiUQiqJoDbFP1c0kWK8wm?=
 =?us-ascii?Q?TD4j9qhaa3ZBiCz+PhbAFRRs6lGGILPoqvmtcZW3C49djRPAtP0HAVEEm28B?=
 =?us-ascii?Q?MGqf7MLdb+N3TLiDwtBTLrNDqpxsWYWNuJfGK20/r63yYvB8QPp5dwQApvpa?=
 =?us-ascii?Q?LxCSrxdJcBaWG7nyLvHYuqy/vSfCAP8gI6f5uwEhcAcrDS3PyMryGzZ0XexO?=
 =?us-ascii?Q?M0bfmtSFpSQLGIgabLj+dT2qouF36HjIE93Usdwn45Q7PuKxsmzx8iqcSC3b?=
 =?us-ascii?Q?kranqfyFX8u8r4FLiQqP51aTUZz3Pwoc340ACOCgI+oWKHNFf2tyTilZwL/5?=
 =?us-ascii?Q?0Rrjy/EvjoE827PrAW8Gs3wSHuiUk2OrKYuGYLSGdogZUsIt0GQm8N7geMVl?=
 =?us-ascii?Q?4C4nJWuVUgiwuhcTb9ii0psBvrVgkzv/0d8w6EP03GrEeQx8TSRBiSxVzX5r?=
 =?us-ascii?Q?vLGIKhtxjY4gwLRVN448VldP62dSk83vQpJPQtH4ixgYoJI4BEC2Kl60lpIw?=
 =?us-ascii?Q?aWooPp9+8+TClQjU+tpD247ySNMdaqWJeSRWbuUoIivRaiJOs0o2k8p3rEax?=
 =?us-ascii?Q?BVrsufrDoSPb+OF4WBbP6gw49n57LLGfuZHN5H6s7bmOetdz+mG+DGyrHyj8?=
 =?us-ascii?Q?AB3aYSuqPSzDOQcrTki7o8m5ODwjn2tcnEJ7yW+qOgJfvdYfPdnYhxvq02fl?=
 =?us-ascii?Q?VUWc7tdmDE18tUeew4DsbPuFSAy0NDhSq6UoG6CYgSQreGyuYt970f0ucq77?=
 =?us-ascii?Q?AERa596BPw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IssKyqLaF8z/fJU8DrR0LlgellENjUeRdU9Dzpsxknfs/sCD8EZVE4etlgH5XS7lL8zlLzqbzo4RbvAQ4AEaXY86HSZavf98GrHqfP1HSygQDKR2qt/gvsesZgSs8FBwSNT8gcQiHE3506TeyPSsWppUsGhh68T2sZqMZW4C7ozln0LzHvcMvi5YlpD8K2XJrCl/eepc4nfGjXAjItdTC/7ubFej8gFt4zDmH5nykSiXHGI2ZQMQpA5C9otROOh477PXawrvKnhJLF0V+qdCgcWpnYrb6uibQPl2hDWO/WyOaQCi6CN4EoePU/mrhi0Lv4bZpxHXgJMKUkR3eptoeg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 967b686f-a46f-4993-a0bd-08deec3dfdd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2026 00:20:12.8865 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zM32eWuQao8VCfL+VYRkDpeazKc40Y5nhD5rPjzJyHrGS7jv+IaQhcmFZBasEs/SRXGa3za1SV/2YpFOmt4wfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR11MB9924
X-OriginatorOrg: intel.com
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

Recheck-request: rebase=3Dnext-net-intel, iol-testing

Thank you.

Regards,
Anurag M

> -----Original Message-----
> From: Mandal, Anurag <anurag.mandal@intel.com>
> Sent: 27 July 2026 23:00
> To: dev@dpdk.org
> Cc: Richardson, Bruce <bruce.richardson@intel.com>; Wu, Jingjing
> <jingjing.wu@intel.com>; Shetty, Praveen <praveen.shetty@intel.com>;
> Mandal, Anurag <anurag.mandal@intel.com>
> Subject: [PATCH] net/idpf: add clock read support
>=20
> Implemented read_clock ethdev operation by adding
> idpf_dev_read_clock() feature to get current time in nanoseconds for
> scheduling packets based on transmit time.
>=20
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
>  drivers/net/intel/idpf/idpf_ethdev.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/net/intel/idpf/idpf_ethdev.c
> b/drivers/net/intel/idpf/idpf_ethdev.c
> index c13505416a..224a649f53 100644
> --- a/drivers/net/intel/idpf/idpf_ethdev.c
> +++ b/drivers/net/intel/idpf/idpf_ethdev.c
> @@ -1124,6 +1124,15 @@ idpf_timesync_disable(struct rte_eth_dev *dev)
>  	return 0;
>  }
>=20
> +static int
> +idpf_dev_read_clock(struct rte_eth_dev *dev, uint64_t *clock) {
> +	struct idpf_vport *vport =3D dev->data->dev_private;
> +	struct idpf_adapter *adapter =3D vport->adapter;
> +
> +	return idpf_ptp_read_src_clk_reg(adapter, clock); }
> +
>=20
>  static const struct eth_dev_ops idpf_eth_dev_ops =3D {
>  	.dev_configure			=3D idpf_dev_configure,
> @@ -1159,6 +1168,7 @@ static const struct eth_dev_ops idpf_eth_dev_ops =
=3D {
>  	.timesync_read_time           =3D idpf_timesync_read_time,
>  	.timesync_write_time          =3D idpf_timesync_write_time,
>  	.timesync_disable             =3D idpf_timesync_disable,
> +	.read_clock                   =3D idpf_dev_read_clock,
>  };
>=20
>  static int
> --
> 2.34.1

