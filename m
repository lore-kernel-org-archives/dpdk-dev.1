Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17096C5B552
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 11:47:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0268D402D4;
	Tue, 10 Jun 2025 13:47:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 7670E4026D
 for <dev@dpdk.org>; Tue, 10 Jun 2025 13:47:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749556066; x=1781092066;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=cDouHvHbGoHmj6wrlG+Q6EKVlVS+tUN6272zylJEVWw=;
 b=iFLLl9aOlaO5ZvvHfC6CGP2oXkh6/5QRxw5Yy+Q8wutMElEtrBbHxmx2
 3b1CnmGYocbipdWVu5scWdfvpIfh18WigW3yJ7NDh/9vainSwgcxHiwg+
 xUXAO4EHLdx3pmTASOGEx42Tljy9J8ySIfihQkSQl6fVFh+aGdbNFRSrC
 ye6kzu5xz4epehzrOPqCG6elKxI153gPkf8ZN01hS99Vcn6XfkRs6a7ha
 n7+0VINdc82pDW1iukaiN1RVvBAqt+FPFzPUgZHkqOUbCXlzyrv1LePCe
 essyOM8QEyRopR4GpAGXJIvN6vHFrLGYH9bQ/cegevPHNakuhk6kwQlBl g==;
X-CSE-ConnectionGUID: qTO0GC8XTxCP8vZZAKxjQQ==
X-CSE-MsgGUID: TX+/dbf9SmehVNSqv+pHtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="51572801"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; d="scan'208";a="51572801"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2025 04:47:45 -0700
X-CSE-ConnectionGUID: yLVcCiWMSgSZAqGtiC7frA==
X-CSE-MsgGUID: YlDnIANDR96TZ7jmYDkbeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; d="scan'208";a="151686781"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2025 04:47:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 10 Jun 2025 04:47:44 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 10 Jun 2025 04:47:44 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.48)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 10 Jun 2025 04:47:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WP1baV6KM48Z9esrWjcwutvSlkQgOI2xk59qlB31DWZIH4jiMGjUhHGD+t0xQMX4UPmP4CohP8la4I/nwxKggR7FaBZnUsarwyFDiHjp9OcErHxzMiRb1bfaEBJOrAfFcAM/Dxm7TL2vDfVXwv2o7y1P5HDc4bMArJ0eeQRKFY3mGnawYtL7Fv4n9bj/z/R5Q+oLD2lyKP/SNQ5+oL9RVNGe+9yzTVLxXM5k6p8OE7lOFDKwIBdq3E3zeIeWhoJfJvvHZElmELiEH2u1U/ZxkxhZQatBt6WUTQj/L25mfN8HS2zm4g30a7/U1lblI34922iWomajqDnDrCouYbBfLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nnn5ir36CNxpdfRNAdgHrvWnSpGwG57V+0cYHjeQ7Fs=;
 b=LuAULD9QCo+A9aeHVsyHXj+MN7i3RAziu1Ux8nmOj9yDTy2T93fq7YA9ZZG6EoQXZ9gEfdCfB1xyDBIlu541B12FVEgB6bLNu47Fxw5e7ZjmcAV8Ouv7hAR9AZyGs1cMPF0juY8RM2Sb3XhgI+/Kl+5CzO22pT+/hcrc9FKnUf2ETd7Q4fTVOQuT3qDu1Ls0VRvgCISvZTyILRdOJREJrUHiuF4Z8tkKaPgcZ/ynek/nJa4IZ4q4FjjFBqxaRhXiaMBejWT2HcmiEYtJj7QzCwlnN88p3y67Nrf7sFxIiSx8M2QQhMvTPDaDm9W5s5pxj8i0W3wqJypbWxyYhgpGkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7747.namprd11.prod.outlook.com (2603:10b6:930:91::17)
 by PH7PR11MB6953.namprd11.prod.outlook.com (2603:10b6:510:204::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.40; Tue, 10 Jun
 2025 11:47:42 +0000
Received: from CY8PR11MB7747.namprd11.prod.outlook.com
 ([fe80::dd94:c5ad:7fd:fd4f]) by CY8PR11MB7747.namprd11.prod.outlook.com
 ([fe80::dd94:c5ad:7fd:fd4f%7]) with mapi id 15.20.8769.022; Tue, 10 Jun 2025
 11:47:42 +0000
From: "Hore, Soumyadeep" <soumyadeep.hore@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Singh, Aman Deep"
 <aman.deep.singh@intel.com>, "Subbarao, Manoj Kumar"
 <manoj.kumar.subbarao@intel.com>
Subject: RE: [PATCH v3 3/6] net/intel: add TxPP Support for E830
Thread-Topic: [PATCH v3 3/6] net/intel: add TxPP Support for E830
Thread-Index: AQHb2K2BfAp3c5MLy0yB9pKJYCkidbP6yXIAgAF/SAA=
Date: Tue, 10 Jun 2025 11:47:42 +0000
Message-ID: <CY8PR11MB77474265BF1570AF87F753BBF96AA@CY8PR11MB7747.namprd11.prod.outlook.com>
References: <20250606211947.473544-2-soumyadeep.hore@intel.com>
 <20250608113223.487043-1-soumyadeep.hore@intel.com>
 <20250608113223.487043-4-soumyadeep.hore@intel.com>
 <aEbZIKK0CuMMrOCY@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aEbZIKK0CuMMrOCY@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7747:EE_|PH7PR11MB6953:EE_
x-ms-office365-filtering-correlation-id: 40118c15-bca9-4b49-4648-08dda8149bbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?7EEDXguYFXQRu4VyqzhLXm1BwGXb77FpaXF9LkLtwFcQAu+Y+/362IDEptFV?=
 =?us-ascii?Q?QsoFlFFYHekCHOU7M8C0vri2V1ljv7Lhj9dpS9Bo9haDBkq2+b76ANXbvkVA?=
 =?us-ascii?Q?3aXV20uJhjeJWgmbhhwOx7I/Pe9vR+qp8/8BwlIwnFNei3c4WIfvERIVA5SA?=
 =?us-ascii?Q?RzIYiPgJaqeAhLxF6U4Qpp4mlS7K/qCviSgtRqk7hpE/g8v1N7Pejjma1gGJ?=
 =?us-ascii?Q?0JypZfNadIqXEQnQ+riXyT5tXXGCZosCzNuamxBrF9Pk2Xtmnz/0zUFYdpWy?=
 =?us-ascii?Q?z/cLf6nvomw22pVWgzzjR+RkMsoe0aZ6dpUOMXbASXKPCmpm4AHMoK4gyJ+T?=
 =?us-ascii?Q?KgnMbJFvl0F7PkR/TRuwyyzJmOW52W4TBE3ifoF2ugSIlsAYwbWm7BpMDQoR?=
 =?us-ascii?Q?SnKOgpXeaq3uh0KaMdJmanMBVhY/PXmzL7JnffVBPWZN8D4SNX8JIEWwwtby?=
 =?us-ascii?Q?eDSguimdAk9rhZW75OOdlh7GhB73vi+qL3gsjlKP4lxlqkbIB92phG6DVsG8?=
 =?us-ascii?Q?gcFGd/qX+BwugU9iW7joWDPEGeYloh5mtOp9D3lmPH/AEvApPFirkV3mf5Jk?=
 =?us-ascii?Q?+Uti8ybY00/S0HStfpfnFLkeb7P0u2HdvvwqvoThS7r1sdhf5ZGwiYP3/hRF?=
 =?us-ascii?Q?NKPx8lq8yO0eDX7C/yvsRnMAmife+KZvXc0kOr2LXrV5HFWmbNDjnBwxPaap?=
 =?us-ascii?Q?LfSwaKY5iypkdDKGX76xdSoBhx81OhejDcTFk8m3tPzv3Wu/Cu98i5ACAfkG?=
 =?us-ascii?Q?VTLPirANesghxk8UoqogYBDH8csyLq/vugLFGgdpJsHgQl+FGdUcpnpHpO4n?=
 =?us-ascii?Q?7s4NdZihAyqaMQz7aa0lr5ixPxFe5uzlBvW7Q5Pg//EvQx1cxbjg+t3DJLwu?=
 =?us-ascii?Q?/Fv2zrHQLzvrAGjuKx+R/kmdKunmpV91tiirIyzSuGI5+evU9GlRyMWKQoOo?=
 =?us-ascii?Q?sA73D1gjVWjbphAZ+pcRmZs84OSTUIl/z2HzCvdCY8nOHJBvJs8YEVEpIE5N?=
 =?us-ascii?Q?OuZ1VKVdok9jaO9ARpz9fDl11xvy5MlXIO1lxvmMVCBJzZ3a40+YIxhjj0Q/?=
 =?us-ascii?Q?kXw8nyR4G83Py7Cn8JH5/tOTpYaQI89VyZWTtlE++Y2Fxkf7i2b+afxLRTzI?=
 =?us-ascii?Q?kFrHaY0jamWVAy1ivYKlQreWFoy567TWFzrGiEkB6dt1vPHGfjjYOQOBX2C5?=
 =?us-ascii?Q?wVAxiLltAwLOOgxxUcAtutUpfxTHEyKSeHkf5CpOMahAFYOwiqKVyJ/ISoQ6?=
 =?us-ascii?Q?H64kK/6zYVEfTntZmwOHGVlM+QBZfjIX7tUHuCSWK+OmkbmrB7ApnW4F+mD4?=
 =?us-ascii?Q?yHhTqTunIOwoLPaB2yZV/5bBZ2gbHjFF5BmNQoOwKWIx/z6J0xdM/pH3Lt01?=
 =?us-ascii?Q?Fy95cVjU2M+gQ+pOyB/ByJKFSF+aYsttKyrKzMHXkrbZFg3OJq/+rGQ3d5Os?=
 =?us-ascii?Q?3rUJTAI3ttht5sowueEfkic6gGeoiw3di2hwRL0YWdgjzGeAhVbKWw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7747.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5bnNS7dctTLK07+VUmS8kdk3/+zAWtsqlhRCtZRzwu7nHX8fw4b6zc64NHu1?=
 =?us-ascii?Q?wDPWCIRaw18rMWyJFLdqg8hSAXcIlWc4VtJXxFOKeLUf2uGSWaVg9CGwnO9N?=
 =?us-ascii?Q?8m/vGcXVbM9yfB1G/pQzdWynqsxoDOjDoNr3MY23Ztp01RUwJYpivLoS6cix?=
 =?us-ascii?Q?+KAGjtFT6zKCWKvDVLHUECLFbx3PMAciM62+v6QGyZVRX80vBouPxMoUedfT?=
 =?us-ascii?Q?FJxZgerh40HIF7+iOU4nXv2gMrp0wRQtZ21txtk2rTbNLfAZEjR9z2Gamp1W?=
 =?us-ascii?Q?bDODmP/eHM/74cUse9Xln7ye9kyLPs/SWbFXfsxYMpjhr+hubWKFORg9Yu9O?=
 =?us-ascii?Q?GgdR9x6hs8RiCJnJgfS2CsyMKCk4rUmMsfnfFiVxycH81+XEd1FhXvajZKpW?=
 =?us-ascii?Q?hfxJuRP40h3XspOJwppD8SlkoSEhobu3fA0Drci3+ds0HkYE8/+j6BqQBK5v?=
 =?us-ascii?Q?8lEQjDl2ErSqJ/JRcqJ4t1i+TtSalFRGIJsKBfe1wgpBHi3EQoDJ69Al67CP?=
 =?us-ascii?Q?iWGjSLL1IXZbXphVjcsX/5rQJsbCiLMyxR6rTT0Zj4TidDsBnMilxCX4NrrB?=
 =?us-ascii?Q?EN77m0NHrZ6aUXxPbx82U4xHqK/TOgs8fKZ11VHxy6hkx+hNgvHp6vJfhzTc?=
 =?us-ascii?Q?ijhgKAeFzHJbqZl3arLqUhqjUDcAvwhp9W0+aMjElCTpR8Ol2kWkdttAQymK?=
 =?us-ascii?Q?JH/q83u56Po11z3gle643ZcLnWUUD1ynW+UbXaZcbzdp/AzxQxoVxUIR8OJu?=
 =?us-ascii?Q?iX4tUXQrHAj9TSfgRsawqlN104xHxmLa8UfTHrj6uvcqU9W4NeMBlPcXeYG8?=
 =?us-ascii?Q?/pC21TbFzkjvktMZ3/20qfnZ7C1gCo9dx5nbbpnt5KLc6ZMdvZGSjZdrrt2T?=
 =?us-ascii?Q?NeBWCA9IH2GstZFHDg35KlHfspJeV2WKdGuSWp+gtA12P2qI7bFwvuvHw8kf?=
 =?us-ascii?Q?8faFKhmXDhknokvquZ4gtg5hJVPZcJdYS3NyipN0BKFqwMQcIXHPGeefVAsa?=
 =?us-ascii?Q?i7QzdMtHw3aqkBrAUJwCHcFj/kD/ZfCyqH7XZsWcY76IP5uaqO9ReWa4dWMC?=
 =?us-ascii?Q?QD0h0EhtIUhYtWJC13lBPvD7Ea/wekS5nkHitBnSGeSJ+OGz0HSwSiPtjaVY?=
 =?us-ascii?Q?Dx0oiZ8bQVkYAwmc2GphqdkABFSht0KYCUbYQx8uRZCoK2PPu6OXzi4tQFp1?=
 =?us-ascii?Q?TroYaCO5aw7MknVVmRR9QVvr7y1GAtXYplsinvotqeWUvenlc8k42XXQA7pI?=
 =?us-ascii?Q?JVSDi9Ppks6dnC199qt0MqU9qpyDHfVJzLUgqqsQGqGi22f4gnJBKyM8//ib?=
 =?us-ascii?Q?4oPVHKs8I4vv3uVUrBUpYS2C+zYG5SmdlJizKw2EneVZ22raFybBqL5w6Sdm?=
 =?us-ascii?Q?z4MWk9ojn5ac9PC2AO+/pEDjHdPLtvJ/YcF0ldXBJqzl/Kmc+soIxjH0SIKc?=
 =?us-ascii?Q?AKwKbabvFV1VVCUIjQa2VjfFDx0Y7u1XpuWWDzKvQHBaQ8o5GLBN+btKmvnz?=
 =?us-ascii?Q?YlWaAdf6JtIa6B4tYFg0ENVeL4CH6B7C8ArcXkrfhgJkSgkIgVpIGinsvrBH?=
 =?us-ascii?Q?0yCivnRGV2Kfs1HXNE2kJKw74h4v4d5p+vl72jXtCfvUipkMOWaQYtXZqyA4?=
 =?us-ascii?Q?9Y5Xe4v5+uAkYndBa9vJ9biCYRI29y4KX163mk7CIuYd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7747.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40118c15-bca9-4b49-4648-08dda8149bbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2025 11:47:42.1933 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: klMB61oYVNJv4wrWJBJJk+4F17ezm/X8P6E2mvuZCiTq17b6fCkqFREKviWm1wUFPf9oADUlxAy5HzqfHc42U9ZPA4kMVCWgT4JINugSvTY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6953
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


On Sun, Jun 08, 2025 at 11:32:20AM +0000, Soumyadeep Hore wrote:
> Add support for Tx Time based queues. This is used to schedule packets=20
> based on Tx timestamp.
>=20
> Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>

Some initial review comments inline below.

/Bruce

> ---
>  drivers/net/intel/common/tx.h              |  14 ++
>  drivers/net/intel/ice/base/ice_lan_tx_rx.h |   4 +
>  drivers/net/intel/ice/ice_ethdev.c         |   3 +-
>  drivers/net/intel/ice/ice_ethdev.h         |  12 ++
>  drivers/net/intel/ice/ice_rxtx.c           | 232 ++++++++++++++++++++-
>  drivers/net/intel/ice/ice_rxtx.h           |   9 +
>  6 files changed, 265 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/net/intel/common/tx.h=20
> b/drivers/net/intel/common/tx.h index b0a68bae44..8b958bf8e5 100644
> --- a/drivers/net/intel/common/tx.h
> +++ b/drivers/net/intel/common/tx.h
> @@ -30,6 +30,19 @@ struct ci_tx_entry_vec {
> =20
>  typedef void (*ice_tx_release_mbufs_t)(struct ci_tx_queue *txq);
> =20
> +/**
> + * Structure associated with Tx Time based queue  */ struct=20
> +ice_txtime {
> +	volatile struct ice_ts_desc	*ice_ts_ring;  /* Tx time ring virtual addr=
ess */
> +	uint16_t nb_ts_desc;	/* number of Tx Time descriptors */
> +	uint16_t ts_tail;  /* current value of tail register */
> +	rte_iova_t ts_ring_dma;	/* TX time ring DMA address */
> +	const struct rte_memzone *ts_mz;
> +	int ts_offset;	/* dynamic mbuf Tx timestamp field offset */
> +	uint64_t ts_flag;	/* dynamic mbuf Tx timestamp flag */
> +};

This structure has extra padding in it, making it larger than it should be.
If you sort the elements by size, then we should be able to save some bytes=
, e.g. putting ts_offset, nb_ts_desc and ts_tail all within a single 8-byte=
 block.

> +
>  struct ci_tx_queue {
>  	union { /* TX ring virtual address */
>  		volatile struct i40e_tx_desc *i40e_tx_ring; @@ -77,6 +90,7 @@=20
> struct ci_tx_queue {
>  	union {
>  		struct { /* ICE driver specific values */
>  			uint32_t q_teid; /* TX schedule node id. */
> +			struct ice_txtime tsq; /* Tx Time based queue */

If you change this to a pointer to the struct, then we can move the struct =
definition - which is ice-specific - out of the common header file and into=
 an ice-specific one. It will also reduce the space used by the ice specifi=
c part of the union.

Actually the txtime will be used in some other drivers in future like in ix=
gbe so we can keep it in tx.h

>  		};
>  		struct { /* I40E driver specific values */
>  			uint8_t dcb_tc;
> diff --git a/drivers/net/intel/ice/base/ice_lan_tx_rx.h=20
> b/drivers/net/intel/ice/base/ice_lan_tx_rx.h
> index f92382346f..8b6c1a07a3 100644
> --- a/drivers/net/intel/ice/base/ice_lan_tx_rx.h
> +++ b/drivers/net/intel/ice/base/ice_lan_tx_rx.h
> @@ -1278,6 +1278,8 @@ struct ice_ts_desc {
>  #define ICE_TXTIME_MAX_QUEUE		2047
>  #define ICE_SET_TXTIME_MAX_Q_AMOUNT	127
>  #define ICE_OP_TXTIME_MAX_Q_AMOUNT	2047
> +#define ICE_TXTIME_FETCH_TS_DESC_DFLT	8
> +#define ICE_TXTIME_FETCH_PROFILE_CNT	16
>  /* Tx Time queue context data
>   *
>   * The sizes of the variables may be larger than needed due to=20
> crossing byte @@ -1303,8 +1305,10 @@ struct ice_txtime_ctx {
>  	u8 drbell_mode_32;
>  #define ICE_TXTIME_CTX_DRBELL_MODE_32	1
>  	u8 ts_res;
> +#define ICE_TXTIME_CTX_RESOLUTION_128NS 7
>  	u8 ts_round_type;
>  	u8 ts_pacing_slot;
> +#define ICE_TXTIME_CTX_FETCH_PROF_ID_0 0

This looks to be on the wrong line. The other two defines above follow the =
field they apply to, this one should be two lines further down to follow th=
at pattern.

>  	u8 merging_ena;
>  	u8 ts_fetch_prof_id;
>  	u8 ts_fetch_cache_line_aln_thld;
> diff --git a/drivers/net/intel/ice/ice_ethdev.c=20
> b/drivers/net/intel/ice/ice_ethdev.c
> index 9478ba92df..3af9f6ba38 100644
> --- a/drivers/net/intel/ice/ice_ethdev.c
> +++ b/drivers/net/intel/ice/ice_ethdev.c
> @@ -4139,7 +4139,8 @@ ice_dev_info_get(struct rte_eth_dev *dev, struct rt=
e_eth_dev_info *dev_info)
>  			RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO |
>  			RTE_ETH_TX_OFFLOAD_GRE_TNL_TSO |
>  			RTE_ETH_TX_OFFLOAD_IPIP_TNL_TSO |
> -			RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO;
> +			RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO |
> +			RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP;
>  		dev_info->flow_type_rss_offloads |=3D ICE_RSS_OFFLOAD_ALL;
>  	}
> =20
> diff --git a/drivers/net/intel/ice/ice_ethdev.h=20
> b/drivers/net/intel/ice/ice_ethdev.h
> index bfe093afca..dd86bd030c 100644
> --- a/drivers/net/intel/ice/ice_ethdev.h
> +++ b/drivers/net/intel/ice/ice_ethdev.h
> @@ -17,6 +17,18 @@
>  #include "base/ice_flow.h"
>  #include "base/ice_sched.h"
> =20
> +#define __bf_shf(x) rte_bsf32(x)
> +#define FIELD_GET(_mask, _reg) \
> +	(__extension__ ({ \
> +		typeof(_mask) _x =3D (_mask); \
> +		(typeof(_x))(((_reg) & (_x)) >> __bf_shf(_x)); \
> +	}))
> +#define FIELD_PREP(_mask, _val) \
> +	(__extension__ ({ \
> +		typeof(_mask) _x =3D (_mask); \
> +		((typeof(_x))(_val) << __bf_shf(_x)) & (_x); \
> +	}))
> +
>  #define ICE_ADMINQ_LEN               32
>  #define ICE_SBIOQ_LEN                32
>  #define ICE_MAILBOXQ_LEN             32
> diff --git a/drivers/net/intel/ice/ice_rxtx.c=20
> b/drivers/net/intel/ice/ice_rxtx.c
> index ba1435b9de..0c5844e067 100644
> --- a/drivers/net/intel/ice/ice_rxtx.c
> +++ b/drivers/net/intel/ice/ice_rxtx.c
> @@ -740,6 +740,53 @@ ice_rx_queue_stop(struct rte_eth_dev *dev, uint16_t =
rx_queue_id)
>  	return 0;
>  }
> =20
> +/**
> + * ice_setup_txtime_ctx - setup a struct ice_txtime_ctx instance
> + * @txq: The queue on which tstamp ring to configure
> + * @txtime_ctx: Pointer to the Tx time queue context structure to be=20
> +initialized
> + * @txtime_ena: Tx time enable flag, set to true if Tx time should be=20
> +enabled  */ static int ice_setup_txtime_ctx(struct ci_tx_queue *txq,
> +		     struct ice_txtime_ctx *txtime_ctx, bool txtime_ena) {
> +	struct ice_vsi *vsi =3D txq->ice_vsi;
> +	struct ice_hw *hw =3D ICE_VSI_TO_HW(vsi);
> +
> +	txtime_ctx->base =3D txq->tsq.ts_ring_dma >>=20
> +ICE_TX_CMPLTNQ_CTX_BASE_S;
> +
> +	/* Tx time Queue Length */
> +	txtime_ctx->qlen =3D txq->tsq.nb_ts_desc;
> +
> +	if (txtime_ena)
> +		txtime_ctx->txtime_ena_q =3D 1;
> +
> +	/* PF number */
> +	txtime_ctx->pf_num =3D hw->pf_id;
> +
> +	switch (vsi->type) {
> +	case ICE_VSI_LB:
> +	case ICE_VSI_CTRL:
> +	case ICE_VSI_ADI:
> +	case ICE_VSI_PF:
> +		txtime_ctx->vmvf_type =3D ICE_TLAN_CTX_VMVF_TYPE_PF;
> +		break;

These cases are all the possible enum values for the vsi->type. Does having=
 a TxTime context actually make sense on all of them?

> +	default:
> +		PMD_DRV_LOG(ERR, "Unable to set VMVF type for VSI type %d",
> +				vsi->type);
> +		return -EINVAL;
> +	}
> +
> +	/* make sure the context is associated with the right VSI */
> +	txtime_ctx->src_vsi =3D vsi->vsi_id;
> +
> +	txtime_ctx->ts_res =3D ICE_TXTIME_CTX_RESOLUTION_128NS;
> +	txtime_ctx->drbell_mode_32 =3D ICE_TXTIME_CTX_DRBELL_MODE_32;
> +	txtime_ctx->ts_fetch_prof_id =3D ICE_TXTIME_CTX_FETCH_PROF_ID_0;
> +
> +	return 0;
> +}
> +
>  int
>  ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)  {=20
> @@ -799,11 +846,6 @@ ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t=
 tx_queue_id)
>  	ice_set_ctx(hw, (uint8_t *)&tx_ctx, txq_elem->txqs[0].txq_ctx,
>  		    ice_tlan_ctx_info);
> =20
> -	txq->qtx_tail =3D hw->hw_addr + QTX_COMM_DBELL(txq->reg_idx);
> -
> -	/* Init the Tx tail register*/
> -	ICE_PCI_REG_WRITE(txq->qtx_tail, 0);
> -
>  	/* Fix me, we assume TC always 0 here */
>  	err =3D ice_ena_vsi_txq(hw->port_info, vsi->idx, 0, tx_queue_id, 1,
>  			txq_elem, buf_len, NULL);
> @@ -826,6 +868,40 @@ ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t=
 tx_queue_id)
>  	/* record what kind of descriptor cleanup we need on teardown */
>  	txq->vector_tx =3D ad->tx_vec_allowed;
> =20
> +	if (txq->tsq.ts_flag > 0) {
> +		struct ice_aqc_set_txtime_qgrp *ts_elem;
> +		u8 ts_buf_len =3D ice_struct_size(ts_elem, txtimeqs, 1);
> +		struct ice_txtime_ctx txtime_ctx =3D { 0 };
> +
> +		ts_elem =3D ice_malloc(hw, ts_buf_len);
> +		ice_setup_txtime_ctx(txq, &txtime_ctx,
> +						true);
> +		ice_set_ctx(hw, (u8 *)&txtime_ctx,
> +				ts_elem->txtimeqs[0].txtime_ctx,
> +				ice_txtime_ctx_info);
> +
> +		txq->qtx_tail =3D hw->hw_addr +
> +					E830_GLQTX_TXTIME_DBELL_LSB(txq->reg_idx);

Nit, too many tabs here. Indenting by two extra tabs is enough, no need for
3 extra.

> +
> +		/* Init the Tx time tail register*/
> +		ICE_PCI_REG_WRITE(txq->qtx_tail, 0);
> +
> +		err =3D ice_aq_set_txtimeq(hw, txq->reg_idx, 1, ts_elem,
> +								ts_buf_len, NULL);
> +		if (err) {
> +			PMD_DRV_LOG(ERR, "Failed to set Tx Time queue context, error: %d", er=
r);
> +			rte_free(txq_elem);
> +			rte_free(ts_elem);
> +			return err;
> +		}
> +		rte_free(ts_elem);
> +	} else {
> +		txq->qtx_tail =3D hw->hw_addr + QTX_COMM_DBELL(txq->reg_idx);
> +
> +		/* Init the Tx tail register*/
> +		ICE_PCI_REG_WRITE(txq->qtx_tail, 0);
> +	}
> +
>  	dev->data->tx_queue_state[tx_queue_id] =3D=20
> RTE_ETH_QUEUE_STATE_STARTED;
> =20
>  	rte_free(txq_elem);
> @@ -1046,6 +1122,20 @@ ice_reset_tx_queue(struct ci_tx_queue *txq)
> =20
>  	txq->last_desc_cleaned =3D (uint16_t)(txq->nb_tx_desc - 1);
>  	txq->nb_tx_free =3D (uint16_t)(txq->nb_tx_desc - 1);
> +
> +	if (txq->tsq.ts_flag > 0) {
> +		size =3D sizeof(struct ice_ts_desc) * txq->tsq.nb_ts_desc;
> +		for (i =3D 0; i < size; i++)
> +			((volatile char *)txq->tsq.ice_ts_ring)[i] =3D 0;
> +
> +		for (i =3D 0; i < txq->tsq.nb_ts_desc; i++) {
> +			volatile struct ice_ts_desc *tsd =3D
> +							&txq->tsq.ice_ts_ring[i];
> +			tsd->tx_desc_idx_tstamp =3D 0;
> +		}
> +
> +		txq->tsq.ts_tail =3D 0;
> +	}
>  }
> =20
>  int
> @@ -1080,6 +1170,19 @@ ice_tx_queue_stop(struct rte_eth_dev *dev, uint16_=
t tx_queue_id)
>  	q_ids[0] =3D txq->reg_idx;
>  	q_teids[0] =3D txq->q_teid;
> =20
> +	if (txq->tsq.ts_flag > 0) {
> +		struct ice_aqc_ena_dis_txtime_qgrp txtime_pg;
> +		status =3D ice_aq_ena_dis_txtimeq(hw, q_ids[0], 1, 0,
> +					     &txtime_pg, NULL);
> +		if (status !=3D ICE_SUCCESS) {
> +			PMD_DRV_LOG(DEBUG, "Failed to disable Tx time queue");
> +			return -EINVAL;
> +		}
> +		txq->tsq.ts_flag =3D 0;
> +		txq->tsq.ts_offset =3D -1;
> +		dev->dev_ops->timesync_disable(dev);

Question: should the timesync disable call come first or last? I would have=
 expected it to come first before we start clearing down other things.

> +	}
> +
>  	/* Fix me, we assume TC always 0 here */
>  	status =3D ice_dis_vsi_txq(hw->port_info, vsi->idx, 0, 1, &q_handle,
>  				q_ids, q_teids, ICE_NO_RESET, 0, NULL); @@ -1166,6 +1269,7 @@=20
> ice_rx_queue_setup(struct rte_eth_dev *dev,
>  		   struct rte_mempool *mp)
>  {
>  	struct ice_pf *pf =3D ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
> +	struct ice_hw *hw =3D ICE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
>  	struct ice_adapter *ad =3D
>  		ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
>  	struct ice_vsi *vsi =3D pf->main_vsi;
> @@ -1249,7 +1353,7 @@ ice_rx_queue_setup(struct rte_eth_dev *dev,
>  	rxq->xtr_field_offs =3D ad->devargs.xtr_field_offs;
> =20
>  	/* Allocate the maximum number of RX ring hardware descriptor. */
> -	len =3D ICE_MAX_RING_DESC;
> +	len =3D ICE_MAX_NUM_DESC_BY_MAC(hw);

Is this change relevant for the time pacing feature? Should it be in it's o=
wn patch?

This is a fix to a HW bug which causes MDD event when TxPP is enabled

> =20
>  	/**
>  	 * Allocating a little more memory because vectorized/bulk_alloc Rx=20
> @@ -1337,6 +1441,36 @@ ice_rx_queue_release(void *rxq)
>  	rte_free(q);
>  }
> =20
> +/**
> + * ice_calc_ts_ring_count - Calculate the number of timestamp=20
> +descriptors
> + * @hw: pointer to the hardware structure
> + * @tx_desc_count: number of Tx descriptors in the ring
> + *
> + * Return: the number of timestamp descriptors  */ static uint16_t=20
> +ice_calc_ts_ring_count(struct ice_hw *hw, u16 tx_desc_count) {
> +	u16 prof =3D ICE_TXTIME_CTX_FETCH_PROF_ID_0;
> +	u16 max_fetch_desc =3D 0;
> +	u16 fetch;
> +	u32 reg;
> +	u16 i;
> +
> +	for (i =3D 0; i < ICE_TXTIME_FETCH_PROFILE_CNT; i++) {
> +		reg =3D rd32(hw, E830_GLTXTIME_FETCH_PROFILE(prof, 0));
> +		fetch =3D FIELD_GET(E830_GLTXTIME_FETCH_PROFILE_FETCH_TS_DESC_M,
> +				  reg);
> +		max_fetch_desc =3D max(fetch, max_fetch_desc);
> +	}
> +
> +	if (!max_fetch_desc)
> +		max_fetch_desc =3D ICE_TXTIME_FETCH_TS_DESC_DFLT;
> +
> +	max_fetch_desc =3D RTE_ALIGN(max_fetch_desc, ICE_REQ_DESC_MULTIPLE);
> +
> +	return tx_desc_count + max_fetch_desc; }
> +
>  int
>  ice_tx_queue_setup(struct rte_eth_dev *dev,
>  		   uint16_t queue_idx,
> @@ -1345,6 +1479,7 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
>  		   const struct rte_eth_txconf *tx_conf)  {
>  	struct ice_pf *pf =3D ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
> +	struct ice_hw *hw =3D ICE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
>  	struct ice_vsi *vsi =3D pf->main_vsi;
>  	struct ci_tx_queue *txq;
>  	const struct rte_memzone *tz;
> @@ -1469,7 +1604,8 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
>  	}
> =20
>  	/* Allocate TX hardware ring descriptors. */
> -	ring_size =3D sizeof(struct ice_tx_desc) * ICE_MAX_RING_DESC;
> +	ring_size =3D sizeof(struct ice_tx_desc) *
> +				ICE_MAX_NUM_DESC_BY_MAC(hw);
>  	ring_size =3D RTE_ALIGN(ring_size, ICE_DMA_MEM_ALIGN);
>  	tz =3D rte_eth_dma_zone_reserve(dev, "ice_tx_ring", queue_idx,
>  				      ring_size, ICE_RING_BASE_ALIGN, @@ -1507,6 +1643,42 @@=20
> ice_tx_queue_setup(struct rte_eth_dev *dev,
>  		return -ENOMEM;
>  	}
> =20
> +	if (vsi->type =3D=3D ICE_VSI_PF &&

IF we only use a timestampt ring on PF, maybe the case statement above sett=
ing the context type, should similarly only work for the PF VSI type?

> +		(offloads & RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP) &&
> +		txq->tsq.ts_offset =3D=3D 0 && hw->phy_model =3D=3D ICE_PHY_E830) {

Indent of the follow-up lines here needs improving. They line up with the b=
ody of the if-statement, so either double-indent the continuation, or align=
 them with the opening brace - whichever style is used in this file.

> +		int ret =3D
> +			rte_mbuf_dyn_tx_timestamp_register(&txq->tsq.ts_offset,
> +							 &txq->tsq.ts_flag);
> +		if (ret) {
> +			PMD_INIT_LOG(ERR, "Cannot register Tx mbuf field/flag "
> +							"for timestamp");
> +			return -EINVAL;
> +		}
> +		dev->dev_ops->timesync_enable(dev);
> +
> +		ring_size =3D sizeof(struct ice_ts_desc) *
> +					ICE_MAX_NUM_DESC_BY_MAC(hw);
> +		ring_size =3D RTE_ALIGN(ring_size, ICE_DMA_MEM_ALIGN);
> +		const struct rte_memzone *ts_z =3D
> +					rte_eth_dma_zone_reserve(dev, "ice_tstamp_ring",
> +					queue_idx, ring_size, ICE_RING_BASE_ALIGN,
> +				    socket_id);
> +		if (!ts_z) {
> +			ice_tx_queue_release(txq);
> +			PMD_INIT_LOG(ERR, "Failed to reserve DMA memory "
> +							"for TX timestamp");
> +			return -ENOMEM;
> +		}
> +		txq->tsq.ts_mz =3D ts_z;
> +		txq->tsq.ice_ts_ring =3D ts_z->addr;
> +		txq->tsq.ts_ring_dma =3D ts_z->iova;
> +		txq->tsq.nb_ts_desc =3D
> +				ice_calc_ts_ring_count(ICE_VSI_TO_HW(vsi),
> +							txq->nb_tx_desc);
> +	} else {
> +		txq->tsq.ice_ts_ring =3D NULL;
> +	}
> +
>  	ice_reset_tx_queue(txq);
>  	txq->q_set =3D true;
>  	dev->data->tx_queues[queue_idx] =3D txq; @@ -1539,6 +1711,8 @@=20
> ice_tx_queue_release(void *txq)
> =20
>  	ci_txq_release_all_mbufs(q, false);
>  	rte_free(q->sw_ring);
> +	if (q->tsq.ts_mz)
> +		rte_memzone_free(q->tsq.ts_mz);
>  	rte_memzone_free(q->mz);
>  	rte_free(q);
>  }
> @@ -2961,6 +3135,7 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_=
pkts, uint16_t nb_pkts)
>  	struct rte_mbuf *m_seg;
>  	uint32_t cd_tunneling_params;
>  	uint16_t tx_id;
> +	uint16_t ts_id =3D -1;
>  	uint16_t nb_tx;
>  	uint16_t nb_used;
>  	uint16_t nb_ctx;
> @@ -2979,6 +3154,9 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_=
pkts, uint16_t nb_pkts)
>  	tx_id =3D txq->tx_tail;
>  	txe =3D &sw_ring[tx_id];
> =20
> +	if (txq->tsq.ts_flag > 0)
> +		ts_id =3D txq->tsq.ts_tail;
> +
>  	/* Check if the descriptor ring needs to be cleaned. */
>  	if (txq->nb_tx_free < txq->tx_free_thresh)
>  		(void)ice_xmit_cleanup(txq);
> @@ -3166,10 +3344,48 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **t=
x_pkts, uint16_t nb_pkts)
>  		txd->cmd_type_offset_bsz |=3D
>  			rte_cpu_to_le_64(((uint64_t)td_cmd) <<
>  					 ICE_TXD_QW1_CMD_S);
> +
> +		if (txq->tsq.ts_flag > 0) {
> +			uint64_t txtime =3D *RTE_MBUF_DYNFIELD(tx_pkt,
> +					txq->tsq.ts_offset, uint64_t *);
> +			uint32_t tstamp =3D (uint32_t)(txtime % NS_PER_S) >>
> +						ICE_TXTIME_CTX_RESOLUTION_128NS;
> +			if (tx_id =3D=3D 0)
> +				txq->tsq.ice_ts_ring[ts_id].tx_desc_idx_tstamp =3D
> +				rte_cpu_to_le_32(FIELD_PREP(ICE_TXTIME_TX_DESC_IDX_M,
> +				txq->nb_tx_desc) | FIELD_PREP(ICE_TXTIME_STAMP_M,
> +				tstamp));
> +			else
> +				txq->tsq.ice_ts_ring[ts_id].tx_desc_idx_tstamp =3D
> +				rte_cpu_to_le_32(FIELD_PREP(ICE_TXTIME_TX_DESC_IDX_M,
> +				tx_id) | FIELD_PREP(ICE_TXTIME_STAMP_M, tstamp));
> +			ts_id++;
> +			/* Handling MDD issue causing Tx Hang */
> +			if (ts_id =3D=3D txq->tsq.nb_ts_desc) {
> +				uint16_t fetch =3D txq->tsq.nb_ts_desc - txq->nb_tx_desc;
> +				ts_id =3D 0;
> +				for (; ts_id < fetch; ts_id++) {
> +					if (tx_id =3D=3D 0)
> +						txq->tsq.ice_ts_ring[ts_id].tx_desc_idx_tstamp =3D
> +						rte_cpu_to_le_32(FIELD_PREP(ICE_TXTIME_TX_DESC_IDX_M,
> +						txq->nb_tx_desc) | FIELD_PREP(ICE_TXTIME_STAMP_M,
> +						tstamp));
> +					else
> +						txq->tsq.ice_ts_ring[ts_id].tx_desc_idx_tstamp =3D
> +						rte_cpu_to_le_32(FIELD_PREP(ICE_TXTIME_TX_DESC_IDX_M,
> +						tx_id) | FIELD_PREP(ICE_TXTIME_STAMP_M, tstamp));
> +				}
> +			}
> +		}
>  	}
>  end_of_tx:
>  	/* update Tail register */
> -	ICE_PCI_REG_WRITE(txq->qtx_tail, tx_id);
> +	if (txq->tsq.ts_flag > 0) {
> +		ICE_PCI_REG_WRITE(txq->qtx_tail, ts_id);
> +		txq->tsq.ts_tail =3D ts_id;
> +	} else {
> +		ICE_PCI_REG_WRITE(txq->qtx_tail, tx_id);
> +	}
>  	txq->tx_tail =3D tx_id;
> =20
>  	return nb_tx;
> diff --git a/drivers/net/intel/ice/ice_rxtx.h=20
> b/drivers/net/intel/ice/ice_rxtx.h
> index 500d630679..a9e8b5c5e9 100644
> --- a/drivers/net/intel/ice/ice_rxtx.h
> +++ b/drivers/net/intel/ice/ice_rxtx.h
> @@ -11,9 +11,18 @@
>  #define ICE_ALIGN_RING_DESC  32
>  #define ICE_MIN_RING_DESC    64
>  #define ICE_MAX_RING_DESC    (8192 - 32)
> +#define ICE_MAX_RING_DESC_E830	  8096
> +#define ICE_MAX_NUM_DESC_BY_MAC(hw) ((hw)->phy_model =3D=3D \
> +					ICE_PHY_E830 ? \
> +				    ICE_MAX_RING_DESC_E830 : \
> +				    ICE_MAX_RING_DESC)
>  #define ICE_DMA_MEM_ALIGN    4096
>  #define ICE_RING_BASE_ALIGN  128
> =20
> +#define ICE_TXTIME_TX_DESC_IDX_M	RTE_GENMASK32(12, 0)
> +#define ICE_TXTIME_STAMP_M		RTE_GENMASK32(31, 13)
> +#define ICE_REQ_DESC_MULTIPLE	32
> +
>  #define ICE_RX_MAX_BURST 32
>  #define ICE_TX_MAX_BURST 32
> =20
> --
> 2.43.0
>=20
