Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A239AC71141
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 10:32:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4D724021F;
	Thu, 12 Jun 2025 12:32:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 7D0E54003C
 for <dev@dpdk.org>; Thu, 12 Jun 2025 12:32:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749724322; x=1781260322;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=TWJT7DYf+yi1ftY2cN2OmiK2tEjXUQCTY0XghprH1CU=;
 b=kF1KRnEh27niyWPRz/Xb2xFyLwkPdZ1+G8b1fOz1dR7GswhNFnpZqNU+
 JEmwOjk5z7tT293LJAykE8umSREDyzSDOxFskmzF4mYhtkFiWVMmjngtY
 1Ksj6fVpTY545tslm1+mrFo9RkF/t9olhntnH3G/ivT7C/uKWyNXQ3BgP
 PaSmSGXd5E7NShwtDkE4vTxf1T6ZL969jsyVfId3atVdCS3bCQd5cRn6S
 OZwrJdv2MgSF4th/R1GbUr+7x6JeottVM42eLr1EHcujm3L63x+M5lcfE
 4GhOYiVgLlVO09hYu48c8bUbwb6VXIf64KrCf7Qm/KdwGVPHQmWoel9JH Q==;
X-CSE-ConnectionGUID: 1N/5b2ksTa6ugTnSzRas1g==
X-CSE-MsgGUID: +rmSrXVCSkSn0YJA/Jte1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="51004473"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="51004473"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 03:32:01 -0700
X-CSE-ConnectionGUID: ZjZ8Y6MLSwG53FMnB1LfzQ==
X-CSE-MsgGUID: 20mJhGxRRJ+jdMNBii3VmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="148377253"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 03:32:00 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 12 Jun 2025 03:31:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 12 Jun 2025 03:31:59 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.71)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 12 Jun 2025 03:31:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=igTzxbxBpJN9M9a+h4eSIIG5uXcPKbSRSYw3EDfPy3Ebbbhg2rgCa6bYWwnSABde3S4bGwqmk2LEgZTOyAfBrBhK2TTNfWED6UsvYFSdhf+HHNZT1Du9VbL+IMZBOFaJIVRiT0kX5vQL/A9wNraeP9J5+eeuWhUFxzo6f9iESCxnDu571h0YseAwt9BtJU0vcZDYyQT1HmOPbMHyeE79sRiEy7XceOWWAMZbFKLFg2w53xGtDkj8KC3vQFlm7Jk5FctruxbpjTlqhBzCa8v6rDyWQMgHbgYvXyW5IDRiaw0FQgruoCEEiGGL6OVLjoSJdcfJ6x76x2zeQ4vfs9CjLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X94t3Mp3OKww7zTaLia+GZyoBDUQnYBtSEfkAqJkJnU=;
 b=ALJoRpr8oMln85QZSagqCFvu3VKLdHKEZ8p6iUMEZZ7TbKg1ft7HVwmDLwkr0vLblktxNtxk2hHrsW8Gj62aNLzAhQ1lxxuFTTJ2gcM22yjbA+nqB85Rw3D7QctmoEEYHEwY0JBc1WBe4oZOCNqbt3HmEyK1ri5CCjuxm0cYx3dm8KWsrXIjDvY2aUrpIL6bTctJCp9beXT+7lq7E/vmLx60DzY/y6d806/3njJJQedWeFvKGLOz+Z1637rAfOI18F6vsLPG+jL3i3Nq1CDwKMoKsE3KzoMkzx7lcFAXSFDVPcTt8Aoclo13BpyDxAYimDFYHXjzlpaZFjipSXuV7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by PH8PR11MB8062.namprd11.prod.outlook.com
 (2603:10b6:510:251::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Thu, 12 Jun
 2025 10:31:30 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::19b1:dfa1:9d1f:38e9]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::19b1:dfa1:9d1f:38e9%8]) with mapi id 15.20.8769.025; Thu, 12 Jun 2025
 10:31:30 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Hore, Soumyadeep" <soumyadeep.hore@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "Singh, Aman Deep" <aman.deep.singh@intel.com>, "Subbarao, Manoj Kumar"
 <manoj.kumar.subbarao@intel.com>
Subject: RE: [PATCH v4 3/6] net/intel: add TxPP Support for E830
Thread-Topic: [PATCH v4 3/6] net/intel: add TxPP Support for E830
Thread-Index: AQHb2k3CmUPgRgYILkW5XI6Y2fxDhbP/UR4g
Date: Thu, 12 Jun 2025 10:31:30 +0000
Message-ID: <DM3PPF7D18F34A1DCBEBCDE7C91289CCB5A8E74A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20250606211947.473544-2-soumyadeep.hore@intel.com>
 <20250610131159.495566-1-soumyadeep.hore@intel.com>
 <20250610131159.495566-4-soumyadeep.hore@intel.com>
In-Reply-To: <20250610131159.495566-4-soumyadeep.hore@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|PH8PR11MB8062:EE_
x-ms-office365-filtering-correlation-id: cf64e3af-7dd1-4598-b91f-08dda99c4b7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?+Hcz8RETILblyS1ImsW+lZJEqcs8Lo/cbCJyHsEwuRj19aDlNAw7pJDmLi06?=
 =?us-ascii?Q?iuVFIEt+1F6np8snKL0Nfh9/dssmsmUdzsqO/pSE3p4FSNPe8tsDQq0bDiDa?=
 =?us-ascii?Q?RiH3YOk8mLrxGQoa3FKl6p/Qdk4zNwZRoiRBmt99E6j7X9qDbR9PGpgdc0wY?=
 =?us-ascii?Q?DaOirStsjBt2zncRkDFoyHauIMP4T94sFkf1SWz+6GEdviu8liQm6/GnZbf/?=
 =?us-ascii?Q?J9THOoPDnWuU6I9HHkdNuBgv6/t7Rvv2r5Pjc3WlKPFEkcOaplvGfOsHlBwZ?=
 =?us-ascii?Q?XCRH96ZpNRtQfydwjXtwm8VCYOwoeRWbhb4J7qYe00lcpZ/AWXJUsZ58KIwk?=
 =?us-ascii?Q?ECYS/cRYriK3rsbYIliqEpm8kml0PeeMmInqXpJmcvfy8QFQl6N7L6oR4ljn?=
 =?us-ascii?Q?urkaFInH/p/Te4u5l3hQnM5oV0MeoAn4VgtzSUJztyKI1aXcUsOEo6pjFugo?=
 =?us-ascii?Q?ewYL0yqsQbYse3RQ0YCmBh3Hw6VI++atk0wJiRU5EbzjB8lc90L9JdIZJaVg?=
 =?us-ascii?Q?SiJisX9gEQqz7E6rk6si86StJCcJjZ7vk+ox/kIw9Ly3iVQHKeGpblpqSF3e?=
 =?us-ascii?Q?LFK9xeCAyEb2quK7Wz/NEbrwH+6Oebo9et4kCRmDVdVW2oUQszk1Q5bxFVDv?=
 =?us-ascii?Q?kTvaz5v82JJuFJWYCbqHTq5NMx9fNPaiDDIS/2SoxeX0G22Hfx5c++bH2v5I?=
 =?us-ascii?Q?uHESq3cLYt9Ol/ASbZOSo4nkjINsdo6OJv9ID+KNRj2NG6f3+r1j4gIqn+Hh?=
 =?us-ascii?Q?wGAJzg1iRpHoml81e1w1t/1VBw9hasjyDBdRGRqDASU8eiSLoNdsU2dRAnVP?=
 =?us-ascii?Q?XpS6bULqX9U3jha4zQROURIOdLTpWZJd/ZkMhFpypSwYWSuV7wPkpvY+w2CG?=
 =?us-ascii?Q?Uc78LbKbtaYMAok4o4X19zm3INiBZTARR+WPymxsqbme+3SR1RcCi1sH9nYO?=
 =?us-ascii?Q?wTEEH/M0AEnqO46rym0J/UfiOozeYjtJHIOSF2+kvMQzbrJtMxajOhP47i4a?=
 =?us-ascii?Q?OraWY7l0iVbrcSL+QNQm0ZAsQ2/wjFkqmvoqBw8WQccmflCclrHj1fx1PPNJ?=
 =?us-ascii?Q?G0De2abEE0kqSaRZMn8lel+4eAKgUcLz4QmrZNbnefjCFiWHwocNGgr0MxUp?=
 =?us-ascii?Q?njR8yeFZiaqA5oyGN6lNdJ6UDQDZoWKrxtO5N5+ZErYi/PQ96jYTPfOQU7Zt?=
 =?us-ascii?Q?tTRo6g9GpnStDOqI1o4Wj7PMCrdHlN93IZq/ktjZvLJRJyvIhxolp8qN7PLu?=
 =?us-ascii?Q?gLT/7BjBJCLeXuhb1CJUJJnFoYeZmkkb94Ik6ZTF7sIYKbprCBWqRp13U56j?=
 =?us-ascii?Q?2N5VKS6RQdxgspmfrR1jV/P48RPZMuAJDuX7rpv+qD99j5DRvKkpOcKWlM7V?=
 =?us-ascii?Q?pQAY930b9uMHo3QcTcWSg1G3/BtDkfupmc9Wfr1qV1TxW1NSjCWZ6bTwO+b8?=
 =?us-ascii?Q?B1w71Pm61D6GBZIwvPqbbud2VwpO4doO2zzgUtAnpEduldBq+1attw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gdKcfcG1z/RBp7y3/IgA2xaLUwFHkQDWvNRf18qLA/OxThkLzAoSwM6KMM6r?=
 =?us-ascii?Q?h8Hp/fBGpoubTyOOiaOuQYFZTrk299w0/1HA6rMV5dQrscleVrrIGyxptW1p?=
 =?us-ascii?Q?qUzpJFw7eN+bwPNuj0A9EHCTsm3QLj/cXrAxfC38FwG0MMOIXd6VOZeFXDUI?=
 =?us-ascii?Q?8LQUA80kUiRacGQbSOL9ZOVX7LEtns0M0HxvGH8q6Dgu3lzuhKQg2/F70j/T?=
 =?us-ascii?Q?JI8cBfEYOzD4lXDUfVy28JBMOaJNcesdHmb+1IOhuIvFWqItA9c0gSXKw/mM?=
 =?us-ascii?Q?PnAw4mzjtRpVupUSYRwgBk9M1kN5qjmmZ2DypPKYfuCLAjlFVrOr8G6dXQY6?=
 =?us-ascii?Q?ktts6nkt+oGi1i60wNijLwyOjI8U0mJRBQs0AMeaKm87mccGJlpaDnTDY+Af?=
 =?us-ascii?Q?d9KoW4sqigHfoKMCjKyFTJx8drmfEKVxp+VDGYIy7is4msmApgyIS7NdUB3q?=
 =?us-ascii?Q?v8f80DchKh6eQ+lohpQT3qIkgMmgk3DvU5H0qjBTxwLtdL6lW6hIgbBSMWdv?=
 =?us-ascii?Q?jO/Ntri24P06AqKClz9bUf+0iWDkXKYiCk4yOLkl7i0p/EvArUHhzfjrhXpl?=
 =?us-ascii?Q?UyDBoPXkwgUCNG6TwhboagDyBQsnz/MbESyqGnpBRks7TFtYb+MyHenJS/oR?=
 =?us-ascii?Q?ImBsB7ExjoGMQkfVrDBhqSLeSCG0Y8bD0LLRDpZcTsM50Rsq2R6pXzOrR1V1?=
 =?us-ascii?Q?9TF/Dqcn9+3jSyfSyxyXpcTcLy0V+GCRWDg4PhqGp3AwFA3LxyARwo4NX4aa?=
 =?us-ascii?Q?Vx/A2QYFMZ5E2iRP7OrPr1B0fxHIbbT5glm6d/iaN+itydPrwjnA8BRycFiU?=
 =?us-ascii?Q?0O6ySwbwfOfFgMXENwmB+ERyJ6oYFdXkhmdaBP5FWjX33anySkunNyLCrCnL?=
 =?us-ascii?Q?dcqwq5qLmQ+6ef3tTcgUI0NLcmf1ytod8fPaTATMq8JMFyVo8Mu0nreq76ii?=
 =?us-ascii?Q?BxnxAzEbtJA544fZ6fiXDmqT4cu4mZe5alsMr8BWp0k1sxdUDcHfV0ONb+fp?=
 =?us-ascii?Q?q8byhaDQcLhGfFo7B92TjHZYW16rX8T5hVVD+Co+aQA+2XvyVT8wUzYEZWLl?=
 =?us-ascii?Q?K6SvBW2kV6ieJmIpkV8UpE0FqTwaMUZdpgayuDUyYvxe/43g+sgL1cKcOZQN?=
 =?us-ascii?Q?WEz1lZBHRpvak6Uf98ho16Lis9nXdsRrLHne0zPcYB8DI8I2487i/NSAWvFr?=
 =?us-ascii?Q?OoYS1fjjkLnhXUHvZUjoDfbenVbv7w8f44Wua3nMlIIwkIq/EHBi+XyogknI?=
 =?us-ascii?Q?9W3Iwns+vOPdG6dnSBCrAlO9gfG8KV/4ziUjyk0gaB04ABgk5t+6DCjXqVVG?=
 =?us-ascii?Q?sloDuhdO/OVSB+5ROiawOGx8jvVGtf6Bcfn7ZXKdODIuXCQ1nB+uz3QUcJmj?=
 =?us-ascii?Q?8vuZ1wisTatqsvIphinaZ3FjX1zlgn5eEn3sreEHFyoFn7CuZpEJpWluLVaD?=
 =?us-ascii?Q?gfAdsWp22BAadDWUeflLZw8mGRJMu2nnzVIfbG81+1HH3NKR3nFWNUjXCi1k?=
 =?us-ascii?Q?NLD1IsDZeH1QHbUXl5/mu2AtGGgsF/ZwmfI91CXIBNHbAi8Ksu+e+Hg38Q9G?=
 =?us-ascii?Q?jk0Masqqt2TQyvWKWtRXYXqTKbQerE5E3lidPwQu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf64e3af-7dd1-4598-b91f-08dda99c4b7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2025 10:31:30.2762 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TvLsrMUAVih2zksabQVmc4bEqwg964eapSPTSGwgn6dG5diTAUMuZAhrcutFepaEVYjPMZDv2RLz20/VJk3iGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8062
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

> Subject: [PATCH v4 3/6] net/intel: add TxPP Support for E830
>=20
> Add support for Tx Time based queues. This is used to schedule
> packets based on Tx timestamp.
>=20
> Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
> ---
>  drivers/net/intel/common/tx.h              |  14 ++
>  drivers/net/intel/ice/base/ice_lan_tx_rx.h |   4 +
>  drivers/net/intel/ice/ice_ethdev.c         |   3 +-
>  drivers/net/intel/ice/ice_ethdev.h         |  11 +
>  drivers/net/intel/ice/ice_rxtx.c           | 229 ++++++++++++++++++++-
>  drivers/net/intel/ice/ice_rxtx.h           |   9 +
>  6 files changed, 261 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.=
h
> index b0a68bae44..1fbbe40cce 100644
> --- a/drivers/net/intel/common/tx.h
> +++ b/drivers/net/intel/common/tx.h
> @@ -30,6 +30,19 @@ struct ci_tx_entry_vec {
>=20
>  typedef void (*ice_tx_release_mbufs_t)(struct ci_tx_queue *txq);
>=20
> +/**
> + * Structure associated with Tx Time based queue
> + */
> +struct txtime {
> +	volatile struct ice_ts_desc	*ice_ts_ring;  /* Tx time ring virtual
> address */
> +	uint16_t nb_ts_desc;	/* number of Tx Time descriptors */
> +	uint16_t ts_tail;  /* current value of tail register */
> +	int ts_offset;	/* dynamic mbuf Tx timestamp field offset */
> +	uint64_t ts_flag;	/* dynamic mbuf Tx timestamp flag */
> +	rte_iova_t ts_ring_dma;	/* TX time ring DMA address */
> +	const struct rte_memzone *ts_mz;
> +};

I recommend taking this out of the common file since it is only used by one=
 Intel driver. If support is added for another we can move it at that point=
.

> +
>  struct ci_tx_queue {
>  	union { /* TX ring virtual address */
>  		volatile struct i40e_tx_desc *i40e_tx_ring;
> @@ -77,6 +90,7 @@ struct ci_tx_queue {
>  	union {
>  		struct { /* ICE driver specific values */
>  			uint32_t q_teid; /* TX schedule node id. */
> +			struct txtime tsq; /* Tx Time based queue */
>  		};
>  		struct { /* I40E driver specific values */
>  			uint8_t dcb_tc;
> diff --git a/drivers/net/intel/ice/base/ice_lan_tx_rx.h
> b/drivers/net/intel/ice/base/ice_lan_tx_rx.h
> index f92382346f..cd02d2b4eb 100644
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
>   * The sizes of the variables may be larger than needed due to crossing =
byte
> @@ -1303,10 +1305,12 @@ struct ice_txtime_ctx {
>  	u8 drbell_mode_32;
>  #define ICE_TXTIME_CTX_DRBELL_MODE_32	1
>  	u8 ts_res;
> +#define ICE_TXTIME_CTX_RESOLUTION_128NS 7
>  	u8 ts_round_type;
>  	u8 ts_pacing_slot;
>  	u8 merging_ena;
>  	u8 ts_fetch_prof_id;
> +#define ICE_TXTIME_CTX_FETCH_PROF_ID_0 0
>  	u8 ts_fetch_cache_line_aln_thld;
>  	u8 tx_pipe_delay_mode;
>  	u8 int_q_state; /* width not needed - internal - DO NOT WRITE!!! */
> diff --git a/drivers/net/intel/ice/ice_ethdev.c
> b/drivers/net/intel/ice/ice_ethdev.c
> index 9478ba92df..3af9f6ba38 100644
> --- a/drivers/net/intel/ice/ice_ethdev.c
> +++ b/drivers/net/intel/ice/ice_ethdev.c
> @@ -4139,7 +4139,8 @@ ice_dev_info_get(struct rte_eth_dev *dev, struct
> rte_eth_dev_info *dev_info)
>  			RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO |
>  			RTE_ETH_TX_OFFLOAD_GRE_TNL_TSO |
>  			RTE_ETH_TX_OFFLOAD_IPIP_TNL_TSO |
> -			RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO;
> +			RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO |
> +			RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP;
>  		dev_info->flow_type_rss_offloads |=3D ICE_RSS_OFFLOAD_ALL;
>  	}
>=20
> diff --git a/drivers/net/intel/ice/ice_ethdev.h
> b/drivers/net/intel/ice/ice_ethdev.h
> index bfe093afca..f39c4b0471 100644
> --- a/drivers/net/intel/ice/ice_ethdev.h
> +++ b/drivers/net/intel/ice/ice_ethdev.h
> @@ -17,6 +17,17 @@
>  #include "base/ice_flow.h"
>  #include "base/ice_sched.h"
>=20
> +#define FIELD_GET(_mask, _reg) \
> +	(__extension__ ({ \
> +		typeof(_mask) _x =3D (_mask); \
> +		(typeof(_x))(((_reg) & (_x)) >> rte_bsf32(_x)); \
> +	}))
> +#define FIELD_PREP(_mask, _val) \
> +	(__extension__ ({ \
> +		typeof(_mask) _x =3D (_mask); \
> +		((typeof(_x))(_val) << rte_bsf32(_x)) & (_x); \
> +	}))
> +

I suggest moving these macros to ice_rxtx.h.


>  #define ICE_ADMINQ_LEN               32
>  #define ICE_SBIOQ_LEN                32
>  #define ICE_MAILBOXQ_LEN             32
> diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice=
_rxtx.c
> index ba1435b9de..94d42ddf06 100644
> --- a/drivers/net/intel/ice/ice_rxtx.c
> +++ b/drivers/net/intel/ice/ice_rxtx.c
> @@ -740,6 +740,50 @@ ice_rx_queue_stop(struct rte_eth_dev *dev,
> uint16_t rx_queue_id)
>  	return 0;
>  }
>=20
> +/**
> + * ice_setup_txtime_ctx - setup a struct ice_txtime_ctx instance
> + * @txq: The queue on which tstamp ring to configure
> + * @txtime_ctx: Pointer to the Tx time queue context structure to be
> initialized
> + * @txtime_ena: Tx time enable flag, set to true if Tx time should be en=
abled
> + */
> +static int
> +ice_setup_txtime_ctx(struct ci_tx_queue *txq,
> +		     struct ice_txtime_ctx *txtime_ctx, bool txtime_ena)
> +{
> +	struct ice_vsi *vsi =3D txq->ice_vsi;
> +	struct ice_hw *hw =3D ICE_VSI_TO_HW(vsi);
> +
> +	txtime_ctx->base =3D txq->tsq.ts_ring_dma >>
> ICE_TX_CMPLTNQ_CTX_BASE_S;
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
> +	case ICE_VSI_PF:
> +		txtime_ctx->vmvf_type =3D ICE_TLAN_CTX_VMVF_TYPE_PF;
> +		break;
> +	default:
> +		PMD_DRV_LOG(ERR, "Unable to set VMVF type for VSI type
> %d",
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
>  ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
>  {
> @@ -799,11 +843,6 @@ ice_tx_queue_start(struct rte_eth_dev *dev,
> uint16_t tx_queue_id)
>  	ice_set_ctx(hw, (uint8_t *)&tx_ctx, txq_elem->txqs[0].txq_ctx,
>  		    ice_tlan_ctx_info);
>=20
> -	txq->qtx_tail =3D hw->hw_addr + QTX_COMM_DBELL(txq->reg_idx);
> -
> -	/* Init the Tx tail register*/
> -	ICE_PCI_REG_WRITE(txq->qtx_tail, 0);
> -
>  	/* Fix me, we assume TC always 0 here */
>  	err =3D ice_ena_vsi_txq(hw->port_info, vsi->idx, 0, tx_queue_id, 1,
>  			txq_elem, buf_len, NULL);
> @@ -826,6 +865,39 @@ ice_tx_queue_start(struct rte_eth_dev *dev,
> uint16_t tx_queue_id)
>  	/* record what kind of descriptor cleanup we need on teardown */
>  	txq->vector_tx =3D ad->tx_vec_allowed;
>=20
> +	if (txq->tsq.ts_flag > 0) {
> +		struct ice_aqc_set_txtime_qgrp *ts_elem;
> +		u8 ts_buf_len =3D ice_struct_size(ts_elem, txtimeqs, 1);
> +		struct ice_txtime_ctx txtime_ctx =3D { 0 };
> +
> +		ts_elem =3D ice_malloc(hw, ts_buf_len);
> +		ice_setup_txtime_ctx(txq, &txtime_ctx,
> +						true);

Nit: this does not need to be broken into two lines.

> +		ice_set_ctx(hw, (u8 *)&txtime_ctx,
> +				ts_elem->txtimeqs[0].txtime_ctx,
> +				ice_txtime_ctx_info);
> +
> +		txq->qtx_tail =3D hw->hw_addr +
> +				E830_GLQTX_TXTIME_DBELL_LSB(txq-
> >reg_idx);
> +
> +		/* Init the Tx time tail register*/
> +		ICE_PCI_REG_WRITE(txq->qtx_tail, 0);
> +
> +		err =3D ice_aq_set_txtimeq(hw, txq->reg_idx, 1, ts_elem,
> +				ts_buf_len, NULL);
> +		rte_free(ts_elem);
> +		if (err) {
> +			PMD_DRV_LOG(ERR, "Failed to set Tx Time queue
> context, error: %d", err);
> +			rte_free(txq_elem);
> +			return err;
> +		}
> +	} else {
> +		txq->qtx_tail =3D hw->hw_addr + QTX_COMM_DBELL(txq-
> >reg_idx);
> +
> +		/* Init the Tx tail register*/
> +		ICE_PCI_REG_WRITE(txq->qtx_tail, 0);
> +	}
> +
>  	dev->data->tx_queue_state[tx_queue_id] =3D
> RTE_ETH_QUEUE_STATE_STARTED;
>=20
>  	rte_free(txq_elem);
> @@ -1046,6 +1118,20 @@ ice_reset_tx_queue(struct ci_tx_queue *txq)
>=20
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
> +							&txq-
> >tsq.ice_ts_ring[i];
> +			tsd->tx_desc_idx_tstamp =3D 0;
> +		}
> +
> +		txq->tsq.ts_tail =3D 0;
> +	}
>  }
>=20
>  int
> @@ -1080,6 +1166,19 @@ ice_tx_queue_stop(struct rte_eth_dev *dev,
> uint16_t tx_queue_id)
>  	q_ids[0] =3D txq->reg_idx;
>  	q_teids[0] =3D txq->q_teid;
>=20
> +	if (txq->tsq.ts_flag > 0) {
> +		struct ice_aqc_ena_dis_txtime_qgrp txtime_pg;
> +		dev->dev_ops->timesync_disable(dev);
> +		status =3D ice_aq_ena_dis_txtimeq(hw, q_ids[0], 1, 0,
> +					     &txtime_pg, NULL);
> +		if (status !=3D ICE_SUCCESS) {
> +			PMD_DRV_LOG(DEBUG, "Failed to disable Tx time
> queue");
> +			return -EINVAL;
> +		}
> +		txq->tsq.ts_flag =3D 0;
> +		txq->tsq.ts_offset =3D -1;
> +	}
> +
>  	/* Fix me, we assume TC always 0 here */
>  	status =3D ice_dis_vsi_txq(hw->port_info, vsi->idx, 0, 1, &q_handle,
>  				q_ids, q_teids, ICE_NO_RESET, 0, NULL);
> @@ -1166,6 +1265,7 @@ ice_rx_queue_setup(struct rte_eth_dev *dev,
>  		   struct rte_mempool *mp)
>  {
>  	struct ice_pf *pf =3D ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
> +	struct ice_hw *hw =3D ICE_DEV_PRIVATE_TO_HW(dev->data-
> >dev_private);
>  	struct ice_adapter *ad =3D
>  		ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
>  	struct ice_vsi *vsi =3D pf->main_vsi;
> @@ -1249,7 +1349,7 @@ ice_rx_queue_setup(struct rte_eth_dev *dev,
>  	rxq->xtr_field_offs =3D ad->devargs.xtr_field_offs;
>=20
>  	/* Allocate the maximum number of RX ring hardware descriptor. */
> -	len =3D ICE_MAX_RING_DESC;
> +	len =3D ICE_MAX_NUM_DESC_BY_MAC(hw);
>=20
>  	/**
>  	 * Allocating a little more memory because vectorized/bulk_alloc Rx
> @@ -1337,6 +1437,37 @@ ice_rx_queue_release(void *rxq)
>  	rte_free(q);
>  }
>=20
> +/**
> + * ice_calc_ts_ring_count - Calculate the number of timestamp descriptor=
s
> + * @hw: pointer to the hardware structure
> + * @tx_desc_count: number of Tx descriptors in the ring
> + *
> + * Return: the number of timestamp descriptors
> + */
> +static uint16_t
> +ice_calc_ts_ring_count(struct ice_hw *hw, u16 tx_desc_count)
> +{
> +	u16 prof =3D ICE_TXTIME_CTX_FETCH_PROF_ID_0;
> +	u16 max_fetch_desc =3D 0;
> +	u16 fetch;
> +	u32 reg;
> +	u16 i;
> +
> +	for (i =3D 0; i < ICE_TXTIME_FETCH_PROFILE_CNT; i++) {
> +		reg =3D rd32(hw, E830_GLTXTIME_FETCH_PROFILE(prof, 0));
> +		fetch =3D
> FIELD_GET(E830_GLTXTIME_FETCH_PROFILE_FETCH_TS_DESC_M,
> +				  reg);
> +		max_fetch_desc =3D max(fetch, max_fetch_desc);
> +	}
> +
> +	if (!max_fetch_desc)
> +		max_fetch_desc =3D ICE_TXTIME_FETCH_TS_DESC_DFLT;
> +
> +	max_fetch_desc =3D RTE_ALIGN(max_fetch_desc,
> ICE_REQ_DESC_MULTIPLE);
> +
> +	return tx_desc_count + max_fetch_desc;
> +}
> +
>  int
>  ice_tx_queue_setup(struct rte_eth_dev *dev,
>  		   uint16_t queue_idx,
> @@ -1345,6 +1476,7 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
>  		   const struct rte_eth_txconf *tx_conf)
>  {
>  	struct ice_pf *pf =3D ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
> +	struct ice_hw *hw =3D ICE_DEV_PRIVATE_TO_HW(dev->data-
> >dev_private);
>  	struct ice_vsi *vsi =3D pf->main_vsi;
>  	struct ci_tx_queue *txq;
>  	const struct rte_memzone *tz;
> @@ -1469,7 +1601,8 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
>  	}
>=20
>  	/* Allocate TX hardware ring descriptors. */
> -	ring_size =3D sizeof(struct ice_tx_desc) * ICE_MAX_RING_DESC;
> +	ring_size =3D sizeof(struct ice_tx_desc) *
> +				ICE_MAX_NUM_DESC_BY_MAC(hw);
>  	ring_size =3D RTE_ALIGN(ring_size, ICE_DMA_MEM_ALIGN);
>  	tz =3D rte_eth_dma_zone_reserve(dev, "ice_tx_ring", queue_idx,
>  				      ring_size, ICE_RING_BASE_ALIGN,
> @@ -1507,6 +1640,42 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
>  		return -ENOMEM;
>  	}
>=20
> +	if (vsi->type =3D=3D ICE_VSI_PF &&
> +		(offloads & RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP)
> &&
> +		txq->tsq.ts_offset =3D=3D 0 && hw->phy_model =3D=3D ICE_PHY_E830)

Perhaps we should log an error if the user tries to enable this offload on =
an unsupported device. At the moment we silently fail.

> {
> +		int ret =3D
> +			rte_mbuf_dyn_tx_timestamp_register(&txq-
> >tsq.ts_offset,
> +							 &txq->tsq.ts_flag);
> +		if (ret) {
> +			PMD_INIT_LOG(ERR, "Cannot register Tx mbuf
> field/flag "
> +							"for timestamp");
> +			return -EINVAL;
> +		}
> +		dev->dev_ops->timesync_enable(dev);
> +
> +		ring_size =3D sizeof(struct ice_ts_desc) *
> +					ICE_MAX_NUM_DESC_BY_MAC(hw);
> +		ring_size =3D RTE_ALIGN(ring_size, ICE_DMA_MEM_ALIGN);
> +		const struct rte_memzone *ts_z =3D
> +					rte_eth_dma_zone_reserve(dev,
> "ice_tstamp_ring",
> +					queue_idx, ring_size,
> ICE_RING_BASE_ALIGN,
> +				    socket_id);
> +		if (!ts_z) {
> +			ice_tx_queue_release(txq);
> +			PMD_INIT_LOG(ERR, "Failed to reserve DMA memory
> "
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
>  	dev->data->tx_queues[queue_idx] =3D txq;
> @@ -1539,6 +1708,8 @@ ice_tx_queue_release(void *txq)
>=20
>  	ci_txq_release_all_mbufs(q, false);
>  	rte_free(q->sw_ring);
> +	if (q->tsq.ts_mz)
> +		rte_memzone_free(q->tsq.ts_mz);
>  	rte_memzone_free(q->mz);
>  	rte_free(q);
>  }
> @@ -2961,6 +3132,7 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf
> **tx_pkts, uint16_t nb_pkts)
>  	struct rte_mbuf *m_seg;
>  	uint32_t cd_tunneling_params;
>  	uint16_t tx_id;
> +	uint16_t ts_id =3D -1;
>  	uint16_t nb_tx;
>  	uint16_t nb_used;
>  	uint16_t nb_ctx;
> @@ -2979,6 +3151,9 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf
> **tx_pkts, uint16_t nb_pkts)
>  	tx_id =3D txq->tx_tail;
>  	txe =3D &sw_ring[tx_id];
>=20
> +	if (txq->tsq.ts_flag > 0)
> +		ts_id =3D txq->tsq.ts_tail;
> +
>  	/* Check if the descriptor ring needs to be cleaned. */
>  	if (txq->nb_tx_free < txq->tx_free_thresh)
>  		(void)ice_xmit_cleanup(txq);
> @@ -3166,10 +3341,48 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf
> **tx_pkts, uint16_t nb_pkts)
>  		txd->cmd_type_offset_bsz |=3D
>  			rte_cpu_to_le_64(((uint64_t)td_cmd) <<
>  					 ICE_TXD_QW1_CMD_S);
> +
> +		if (txq->tsq.ts_flag > 0) {
> +			uint64_t txtime =3D *RTE_MBUF_DYNFIELD(tx_pkt,
> +					txq->tsq.ts_offset, uint64_t *);
> +			uint32_t tstamp =3D (uint32_t)(txtime % NS_PER_S) >>
> +
> 	ICE_TXTIME_CTX_RESOLUTION_128NS;
> +			if (tx_id =3D=3D 0)
> +				txq-
> >tsq.ice_ts_ring[ts_id].tx_desc_idx_tstamp =3D
> +
> 	rte_cpu_to_le_32(FIELD_PREP(ICE_TXTIME_TX_DESC_IDX_M,
> +						txq->nb_tx_desc) |
> FIELD_PREP(ICE_TXTIME_STAMP_M,
> +						tstamp));
> +			else
> +				txq-
> >tsq.ice_ts_ring[ts_id].tx_desc_idx_tstamp =3D
> +
> 	rte_cpu_to_le_32(FIELD_PREP(ICE_TXTIME_TX_DESC_IDX_M,
> +						tx_id) |
> FIELD_PREP(ICE_TXTIME_STAMP_M, tstamp));
> +			ts_id++;
> +			/* Handling MDD issue causing Tx Hang */
> +			if (ts_id =3D=3D txq->tsq.nb_ts_desc) {
> +				uint16_t fetch =3D txq->tsq.nb_ts_desc - txq-
> >nb_tx_desc;
> +				ts_id =3D 0;
> +				for (; ts_id < fetch; ts_id++) {
> +					if (tx_id =3D=3D 0)
> +						txq-
> >tsq.ice_ts_ring[ts_id].tx_desc_idx_tstamp =3D
> +
> 	rte_cpu_to_le_32(FIELD_PREP(ICE_TXTIME_TX_DESC_IDX_M,
> +								txq-
> >nb_tx_desc) | FIELD_PREP(ICE_TXTIME_STAMP_M,
> +								tstamp));
> +					else
> +						txq-
> >tsq.ice_ts_ring[ts_id].tx_desc_idx_tstamp =3D
> +
> 	rte_cpu_to_le_32(FIELD_PREP(ICE_TXTIME_TX_DESC_IDX_M,
> +								tx_id) |
> FIELD_PREP(ICE_TXTIME_STAMP_M, tstamp));
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
>=20
>  	return nb_tx;
> diff --git a/drivers/net/intel/ice/ice_rxtx.h b/drivers/net/intel/ice/ice=
_rxtx.h
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
>=20
> +#define ICE_TXTIME_TX_DESC_IDX_M	RTE_GENMASK32(12, 0)
> +#define ICE_TXTIME_STAMP_M		RTE_GENMASK32(31, 13)
> +#define ICE_REQ_DESC_MULTIPLE	32
> +
>  #define ICE_RX_MAX_BURST 32
>  #define ICE_TX_MAX_BURST 32
>=20
> --
> 2.47.1

