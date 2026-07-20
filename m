Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3ACC44515
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Jul 2026 10:29:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B0D0402A7;
	Mon, 20 Jul 2026 12:29:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id A84294028C
 for <dev@dpdk.org>; Mon, 20 Jul 2026 12:29:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784543362; x=1816079362;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wkvzDNWPA/017rIgS5wfKDGgWED/HT0juToimF4X708=;
 b=KYS+H6rn0s7jAUDP7GqIu0dBOKQGB7Os61A2r45jmay3PbUgoKwQ5q9G
 t+nS16Ugh8fME3t0M3cOPYzCWNwBkRdN+EtI59CiubsDBwmw0v2gEkpLL
 BnGxlTFRQ53lpYjrpV366aHpY8BXPlTJAY8VqLtp6M/Q9gCMSm/pLb2uM
 c1+/cs4OK9ttpz1hQxb6qW0cErfLaSCZsoCIqEZLo8qXHhA6AEBN1aNCc
 IlJEJfQa9WI/IejSeSg7tVJfqZa90+X06HNP6tUclHWaRxFay0JVKR4Fh
 +dC0f7WuProgG3VutAiYstRDmWxu53hE6pyK5rkdladXZ5p8p1tysi8MZ g==;
X-CSE-ConnectionGUID: m1nmpW9RQ9Cxzyz2bTiktA==
X-CSE-MsgGUID: x/E3rrFxS+GRrIt9atROkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="85158044"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="85158044"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 03:29:20 -0700
X-CSE-ConnectionGUID: Y/XDY50XSfi++9o+n1rHrw==
X-CSE-MsgGUID: BtooEpMCTvazyNCkziuEMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="261225549"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 03:29:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 03:29:20 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 03:29:20 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.40) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 03:29:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kB5/d6eEz5IsTc1sQqldSe1zWOVCy5hWWulH0IgrA5k7x68ZkqZlF429SS9ZmC7wQpHyY6G4j1yTBKksPJ0ayyrIPukxBl2tqBmoT078BkLmJM5IjEa2TnummTieo2ds6CXRpnzfN6lGP+3O9qSQWhB8jwEWXyBNYuJ2yS9O0g/51eFCWVjNDKClbkSn17yGquUdq3EOhnI9Fcqq5vlguP5uQDUs0mxrWhpI3x7FhHjZfGN46Jm6zS7gnQp/j/EE/EoOkkMc8+0CA9aFmmXlnL3Kif9jD5Nrinm/4cJWIVkbr3OpIdYF9kJq+strSD3GNsPVXkt/SVpMejp9+u2EsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=74rX8bQM/SiS5NWoj22K/Sdh3xVl7xemQDFFvdC+fLQ=;
 b=Tu+fhHHsFs20X+c7WaNHIbAPYBxkV0267gp1re1APM9UIc8B1p21OtBLksVw53QBS4Sh4xidQxpTPoREym9v2wvnYDSbrNOOQoAwN5CRJlsR6JJDsG5yA2mTkIPZnDBwDG3aD4XoPX4mI+bMrFvZ2srZvnZFTPUa/T6XyN4V9/i1K8CZBw6jy4bk/yRNAVw6ZUTFk3H6HumPRqk3UiQzyiWsO9A1e2zWbbbLcwxBvlgt6oiHanZ5tAwQeEZdWyHkv9Gu+OfghM/stXQuURDUHLLMKUj5wGT0HzoOQjYxpX5nFIkssrKpFaHsqYlZGbinrAy2JBZ53AM3KvqWgVhPEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by CH3PR11MB8185.namprd11.prod.outlook.com (2603:10b6:610:159::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 10:29:18 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 10:29:18 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Mandal, Anurag" <anurag.mandal@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>
Subject: RE: [PATCH] net/iavf: harden reset recovery and data path on link flap
Thread-Topic: [PATCH] net/iavf: harden reset recovery and data path on link
 flap
Thread-Index: AQHdFjGF07K7lK/JXU2LhMdGa5gM7bZ2NjNg
Date: Mon, 20 Jul 2026 10:29:17 +0000
Message-ID: <IA4PR11MB927886803E8F050891D951538EC32@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20260717211526.716220-1-anurag.mandal@intel.com>
In-Reply-To: <20260717211526.716220-1-anurag.mandal@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|CH3PR11MB8185:EE_
x-ms-office365-filtering-correlation-id: 44f2d36c-04fa-452d-fa7e-08dee649c116
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10070799003|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: KNT4wuQPoN0NhPsj+gGZDykMIpoozdeU1BfbowmyB/YJrqp2ElglJugXSW/7k2p0owgHxNNCxiTEs0hzemsFnQO2cSdgMbXZJ1QYH9Ye+8XMSc2hg/KDSaXHn73pV9dvzePKfVIRe79BRIwxEzynNS1nP7v0GKsz+oZHkACDh8ZEBxux+TBRUOKJ+MLyA+eBt+eGVdzLj+NswTKZ33ndg6897t5OEVHhzkVbEd+P8H1zCcBySYJQP210B6ITCrFXTgp0N4j6y75wmgHBFwRGIwoy2AMEF1szXZrJCLogjPymWTKWkIgWYpNTCh2yS/LNgC4pZCnjLy5Oz7Auwy/W8Q4/gz4cSOFpLJrsiL4/+3yNY/C0uCQWpm4xjj68FtVSIo1xvYak9GykF0yKXM5NTNIDG3OSbGukuenyNgWgcYeUgKwaU/SswRptj9RAOoBOviNjzjMIxJXhYe2Rr2RmAQLQICQ1kgihY0hDQgSp0c1q2wfuLcNIYeCeA6eAjCRKAopzgV76gPxlq9VTHuNPX6Hufw3Il3Wx4+lQ35AW67qF9+R+VkZBy1k1JvMRqfCGVhrrOqbQ41HP9ew4Xb7emq+zuFw7R5EAQUyPXxamgtOTnXKNhTIUuB1TBSG9J2tV2UwxEJ+w0QeAJ6KOrI5uECXJZ9Riwh6/gFUk0Jw/f+np9H/2LpGMl+F7jCqAmAkoYNwAwoOFA8bVWA5CC8HVP8D+r2ovYvXrJ5TeDmv+dqw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10070799003)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eGO2DXk+OLyRRwk+g9T+RRqsJogV90Jcfh62IWX5Rv+9DOwspBvHxlHFDTko?=
 =?us-ascii?Q?evIKHcXV+8pU+YEDVTsYYizXRSaoEccWHMkwDeg1BGKi9Gb4g2wAi5lyVzOp?=
 =?us-ascii?Q?bUd5VYIgcZfNBr6x1Qps2jlowUyY9O2/1IcLMAsQHmkMigKfOu4tnnUgY0y4?=
 =?us-ascii?Q?z65d62lzbC1qE8qJYpwh8NSZxhz8/ie435LT5TqBEQLsnxWItib33muhyyA0?=
 =?us-ascii?Q?Qo59Ci42IIhx7pax1n40KOLQ8uptzkTZDLadh+eGzMYgpZwPDgSvUXkv4kX2?=
 =?us-ascii?Q?z+IjUq/5KRyIybkjiRSzHJy5zIyzHaJWl9+ieXn/mqXuEUzaGuczdUHyflmh?=
 =?us-ascii?Q?R02TVdx62a9nSoPYaxBtuv7mttSEqOf+eAyHydBhsnWFH3mIlYndwvQ1+UG9?=
 =?us-ascii?Q?2+grKntrWTzETTvULO7Lese+ZBmXdIoA+oZd7TEOON6oVKb6bR7y7lksnADR?=
 =?us-ascii?Q?lkaYCd13FWtMPcDHsYRM/N5sMf+o3W/thpe6G4ph7Ufph0rP5NClfq+aKzx+?=
 =?us-ascii?Q?QdXmDDbyDi7Dq12JF0LYKmzdivWg1xz1CgtQJsUoJrZ3SmM1c14ugENsRWeE?=
 =?us-ascii?Q?0e9N2XaPjqAlrFu0R5EjrAj7W8d/EdS0dcfa/Eqz4BqFJx5plKJjzmp6nH9N?=
 =?us-ascii?Q?Fv2NTZ6HX8wpC+e15LB9FP7ZoLf15pWrLTreKLVcnqPXFehPYAkUURhoqQpc?=
 =?us-ascii?Q?XohigacVSIZZmvMdB4AsuPaWqpw49QsPjYMHI6MAru2ZhrIKtigTCDw8mUYd?=
 =?us-ascii?Q?TQeMRD7UvkHhyhPYZUxZ5Tulqkz8xy19kQyscs6fv1fTVPMr58zTr1+ZnDcn?=
 =?us-ascii?Q?tnqm0YpJFE77NTNyPYGZ4EtBOy6EqE0ox+CvWmRcUomqJFZuOMAr1ZvR9v+f?=
 =?us-ascii?Q?/p2xYpAgHNrSfahxZDdpO8bif4aio1KCcwtunFIUxf/oYeyic4ajIBXHJPD5?=
 =?us-ascii?Q?NOQxv5uKXi4+VYg1QvUtBd56zYrR5SGCsuBcZQDrRLhYNXiFPGyT7QX6PuTR?=
 =?us-ascii?Q?tAqpQpU83hZqDVF56YC6q0CBOFvVJszqhQtB0YTimFzbsERHxJRu7EZGnTFW?=
 =?us-ascii?Q?doHavJgcDadVgm9z70z0MQ6MAO1Dtk5dRYxQ8Rf6bvBI0KevXsH/Bi23XiyP?=
 =?us-ascii?Q?2oQiPGUOxWlzs/bKYLJAdwgT7xKB3XlLUlVolDRg0z+fUn5A+b+i28g7PLv+?=
 =?us-ascii?Q?9ryBtKSzJchTDRxcPvvdhPooMHCoKmnbxkuSXsCsTcwbk5X4ErtpT/nOwWmP?=
 =?us-ascii?Q?dmcsdxwJZ9Xrln3LIqj+nDLwiqVfFD1pZ6A8mmBepmqE7wj75Zs9PZNFjB0Q?=
 =?us-ascii?Q?0QJ52MQWmrpaqKdKmjqYeuMKgwTSNQ7Ht4TsYAYUhxPXre5LGGtRw3y91IHJ?=
 =?us-ascii?Q?pJgENcYmMadbtofQuC+NJ8sTxgxbxrGun0GEu5YI8w79SQDEADeJ6CuXw2sr?=
 =?us-ascii?Q?uF4gXufb1+aVK+prrp5dDCvQ9sFCoJdSGrj2QVJ8SNs7EtPne0j3l6R37FwV?=
 =?us-ascii?Q?PD9p4nCoxZDRwQ+iczSlYCssF9T/YS1E73VFq31ra4u/Y3vF9ReUUJhOsyAp?=
 =?us-ascii?Q?e4ELrC6X66kmNmCjrTNztH4Sm6kj1VHenyPOGPd7kLxaH/6J5yg+lrmH/5rF?=
 =?us-ascii?Q?OV+BH/v/ntSRAK7wIvR3E/g966PDIMiSHsAffTOhfdZj1IuZQ3i3mWVee/He?=
 =?us-ascii?Q?cLoJ8PfMfoaEfIfi1uQOn2j2A9tFUGzWTDzVls9C793RTrIiacKe6FI3xY2x?=
 =?us-ascii?Q?sup3hLtrhQxehSyZLRs3ND7oH1JC5+RVIOuA16Is92V/RE3LYaf7rNK3PGu6?=
x-ms-exchange-antispam-messagedata-1: sSisfjXY40BD0Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JPEWbvXenRROlQims5a2BFLajypadNumPL5xGDgVm9aLOBjW1IRIEmPzwp/WBqhQxKeUgYOzYaHqc9TrPjrMTZ63Ymf1ODeksbxD1Fr92dB5jQWK8yoNinSrGOV3tpM2vmVl2slT3qmh5viTPKsLCwiOJlX3Gvdib8jnuyo/cI79m/46V0uEJJurvyKuG3OMIYaJs20Azdw2TzyKf8QcAUqhRnytHxOOqAkbjgvPDIdTu71ExAZuPpokuiLItBuc8NF4cnFIbRC855Myn8hfAbGxDI9AIUPQQ4hIDySKHmE8CCBn4yqkuIJkknFFITEPA1M8zg/QKCL+C1TxZsDLYQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f2d36c-04fa-452d-fa7e-08dee649c116
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 10:29:17.9218 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6UO0z5Skl22r9jzCw3QAqszs63eFcLsAkEyHT49t+KRxEhqtsSXgHlCr0fom/GZtiBZ48T1fKnyCRcPnfliN1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8185
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

> Subject: [PATCH] net/iavf: harden reset recovery and data path on link fl=
ap
>=20
> During PF-initiated reset or a remote/ToR switch link-flap, the VF
> might miss the reset event, race on the no_poll gate, leak in-flight
> Tx descriptors, and stay down if dev_start ran before the PF VSI was
> ready.
>=20
> This patch builds on the earlier reset-recovery fixes with the
> following:
>=20
> - Reset detection: complement the ARQLEN1 check with VFGEN_RSTAT
>   (VIRTCHNL_VFR_INPROGRESS) and poll at a 5 ms interval, matching the
>   kernel iavf driver, so fast ARQ flips are not missed. When the VFR
>   is still not observed, recover anyway instead of bailing out,
>   keeping PF and VF state in sync.
>=20
> - no_poll: make the flag atomic (RTE_ATOMIC) with release/acquire
>   ordering so the data-plane lcores observe gate changes reliably.
>=20
> - Tx drain: add iavf_dev_tx_drain() to flush in-flight Tx descriptors
>   on link-down and impending-reset events before teardown, preventing
>   MDD events and descriptor leaks.
>=20
> - Deferred start: when dev_start fails during recovery (PF VSI inactive),
>   defer it via start_pending and resume on the next link-up event so the
>   VF comes back without manual intervention.
>=20
> - AdminQ: discard zeroed (opcode 0) descriptors seen during PF-initiated
>   resets to avoid the "Request 0 is not supported" log flood.

Could you consider splitting this patch into a series of smaller patches.
There are several independent fixes/improvements here but I think it would
be better to split them out.
Also consider if a Fixes tag is relevant for any of them.

>=20
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
>  drivers/net/intel/iavf/iavf.h        |  4 +-
>  drivers/net/intel/iavf/iavf_ethdev.c | 88 +++++++++++++++++++++++-----
>  drivers/net/intel/iavf/iavf_rxtx.c   | 77 +++++++++++++++++++++++-
>  drivers/net/intel/iavf/iavf_rxtx.h   |  6 ++
>  drivers/net/intel/iavf/iavf_vchnl.c  | 40 ++++++++++++-
>  5 files changed, 195 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.=
h
> index 293adaf6c9..037bc8436f 100644
> --- a/drivers/net/intel/iavf/iavf.h
> +++ b/drivers/net/intel/iavf/iavf.h
> @@ -293,6 +293,7 @@ struct iavf_info {
>  	bool in_reset_recovery;
>  	bool reset_pending;
>  	bool pf_reset_in_progress;
> +	bool start_pending;
>=20
>  	uint32_t ptp_caps;
>  	rte_spinlock_t phc_time_aq_lock;
> @@ -391,7 +392,7 @@ struct iavf_adapter {
>  	alignas(RTE_CACHE_LINE_MIN_SIZE) uint32_t
> ptype_tbl[IAVF_MAX_PKT_TYPE];
>  	bool stopped;
>  	bool closed;
> -	bool no_poll;
> +	RTE_ATOMIC(bool)no_poll;
>  	enum iavf_rx_func_type rx_func_type;
>  	enum iavf_tx_func_type tx_func_type;
>  	uint16_t fdir_ref_cnt;
> @@ -533,4 +534,5 @@ void iavf_handle_hw_reset(struct rte_eth_dev *dev,
> bool vf_initiated_reset);
>  void iavf_set_no_poll(struct iavf_adapter *adapter, bool link_change);
>  bool is_iavf_supported(struct rte_eth_dev *dev);
>  void iavf_hash_uninit(struct iavf_adapter *ad);
> +void iavf_resume_pending_start(struct rte_eth_dev *dev);
>  #endif /* _IAVF_ETHDEV_H_ */
> diff --git a/drivers/net/intel/iavf/iavf_ethdev.c
> b/drivers/net/intel/iavf/iavf_ethdev.c
> index d601ec3b6a..eaabef41ed 100644
> --- a/drivers/net/intel/iavf/iavf_ethdev.c
> +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> @@ -3212,7 +3212,9 @@ iavf_dev_close(struct rte_eth_dev *dev)
>  	/* remove RSS configuration */
>  	iavf_hash_uninit(adapter);
>=20
> -	iavf_flow_flush(dev, NULL);
> +	/* Skip the virtchnl-emitting teardow on a PF-initiated reset */
> +	if (!vf->pf_reset_in_progress)
> +		iavf_flow_flush(dev, NULL);

This change for instance is probably worthy of a Fixes tag since we should
never send virtchnl messages during a PF initiated reset recovery.

>  	iavf_flow_uninit(adapter);
>=20
>  	/*
> @@ -3335,8 +3337,27 @@ iavf_dev_reset(struct rte_eth_dev *dev)
>  static inline bool
>  iavf_is_reset(struct iavf_hw *hw)
>  {
> -	return !(IAVF_READ_REG(hw, IAVF_VF_ARQLEN1) &
> -		IAVF_VF_ARQLEN1_ARQENABLE_MASK);
> +	uint32_t rstat;
> +
> +	/* ARQ has been disabled by the PF as part of the VFR. */
> +	if (!(IAVF_READ_REG(hw, IAVF_VF_ARQLEN1) &
> +		IAVF_VF_ARQLEN1_ARQENABLE_MASK))
> +		return true;
> +
> +	/*
> +	 * VFGEN_RSTAT reports VIRTCHNL_VFR_INPROGRESS.
> +	 * At times, the PF flips ARQENABLE so quickly
> +	 * around a VFR that the ARQLEN1 sample window
> +	 * misses it. Using VFGEN_RSTAT, as a
> +	 * complementary indicator, help to prevent
> +	 * from declaring "reset not start" when a

Here you refer to the "reset not start" log however this log is removed
later in the patch so the comment is no longer relevant.

> +	 * reset really did happen.
> +	 */
> +	rstat =3D (IAVF_READ_REG(hw, IAVF_VFGEN_RSTAT) &
> +		 IAVF_VFGEN_RSTAT_VFR_STATE_MASK) >>
> +		IAVF_VFGEN_RSTAT_VFR_STATE_SHIFT;
> +
> +	return rstat =3D=3D VIRTCHNL_VFR_INPROGRESS;
>  }
>=20
>  static bool
> @@ -3345,11 +3366,17 @@ iavf_is_reset_detected(struct iavf_adapter
> *adapter)
>  	struct iavf_hw *hw =3D IAVF_DEV_PRIVATE_TO_HW(adapter);
>  	int i;
>=20
> -	/* poll until we see the reset actually happen */
> -	for (i =3D 0; i < IAVF_RESET_DETECTED_CNT; i++) {
> +	/*
> +	 * Poll until we see the reset actually happen.
> +	 * Poll every 5 ms to catch the fast ARQ flips.
> +	 * Total wait time is unchanged (~10 s) since

The statement "wait time is unchanged" is referring back to the old code fr=
om
the new code which is confusing. That type of comment belongs in the commit
message, where both the old and new code can be referenced.

> +	 * the count is scale up by the same factor
> +	 * that the per-iteration delay shrinks.
> +	 */
> +	for (i =3D 0; i < IAVF_RESET_DETECTED_CNT * 4; i++) {
>  		if (iavf_is_reset(hw))
>  			return true;
> -		rte_delay_ms(20);
> +		rte_delay_us(5000);
>  	}
>=20
>  	return false;
> @@ -3400,14 +3427,13 @@ iavf_handle_hw_reset(struct rte_eth_dev *dev,
> bool vf_initiated_reset)
>  		if (!dev->data->dev_started)
>  			return;
>=20
> -		if (!iavf_is_reset_detected(adapter)) {
> -			PMD_DRV_LOG(DEBUG, "reset not start");
> -			return;
> -		}
> +		if (!iavf_is_reset_detected(adapter))
> +			PMD_DRV_LOG(WARNING, "VFR not observed;
> recovering anyway");
>  	}
>=20
>  	vf->in_reset_recovery =3D true;
>  	vf->pf_reset_in_progress =3D !vf_initiated_reset;
> +	vf->start_pending =3D false;
>  	iavf_set_no_poll(adapter, false);
>=20
>  	/* Call the pre reset callback */
> @@ -3428,10 +3454,17 @@ iavf_handle_hw_reset(struct rte_eth_dev *dev,
> bool vf_initiated_reset)
>  	if (!vf_initiated_reset || restart_device) {
>  		/* start the device */
>  		ret =3D iavf_dev_start(dev);
> -		if (ret)
> -			goto error;
> -
> -		dev->data->dev_started =3D 1;
> +		if (ret =3D=3D 0) {
> +			dev->data->dev_started =3D 1;
> +		} else {
> +			PMD_DRV_LOG(WARNING,
> +				    "dev_start failed during reset recovery
> (rc=3D%d);"
> +				    "deferring to next link-up event",
> +				    ret);
> +			vf->start_pending =3D true;
> +			dev->data->dev_started =3D 0;
> +			ret =3D 0;
> +		}
>  	}
>=20
>  	/* Restore settings after the reset */
> @@ -3573,9 +3606,13 @@ void
>  iavf_set_no_poll(struct iavf_adapter *adapter, bool link_change)
>  {
>  	struct iavf_info *vf =3D &adapter->vf;
> +	bool no_poll;
>=20
> -	adapter->no_poll =3D (link_change & !vf->link_up) ||
> +	no_poll =3D (link_change & !vf->link_up) ||
>  		vf->vf_reset || vf->in_reset_recovery;
> +
> +	rte_atomic_store_explicit(&adapter->no_poll, no_poll,
> +				  rte_memory_order_release);
>  }
>=20
>  static int
> @@ -3645,6 +3682,27 @@ bool is_iavf_supported(struct rte_eth_dev *dev)
>  	return !strcmp(dev->device->driver->name,
> rte_iavf_pmd.driver.name);
>  }
>=20
> +void
> +iavf_resume_pending_start(struct rte_eth_dev *dev)
> +{
> +	struct iavf_info *vf =3D IAVF_DEV_PRIVATE_TO_VF(dev->data-
> >dev_private);
> +	int ret;
> +
> +	if (!(vf->link_up && vf->start_pending))
> +		return;
> +
> +	PMD_DRV_LOG(DEBUG, "PF link back up; resuming deferred
> dev_start");
> +	ret =3D iavf_dev_start(dev);
> +	if (ret =3D=3D 0) {
> +		dev->data->dev_started =3D 1;
> +		vf->start_pending =3D false;
> +	} else {
> +		PMD_DRV_LOG(ERR,
> +			    "deferred dev_start failed (ret=3D%d); will retry on
> next link-up",
> +			    ret);
> +	}
> +}
> +
>  RTE_PMD_REGISTER_PCI(net_iavf, rte_iavf_pmd);
>  RTE_PMD_REGISTER_PCI_TABLE(net_iavf, pci_id_iavf_map);
>  RTE_PMD_REGISTER_KMOD_DEP(net_iavf, "* igb_uio | vfio-pci");
> diff --git a/drivers/net/intel/iavf/iavf_rxtx.c
> b/drivers/net/intel/iavf/iavf_rxtx.c
> index 4f2ffe6188..1dbc7aa74a 100644
> --- a/drivers/net/intel/iavf/iavf_rxtx.c
> +++ b/drivers/net/intel/iavf/iavf_rxtx.c
> @@ -3722,7 +3722,9 @@ iavf_recv_pkts_no_poll(void *rx_queue, struct
> rte_mbuf **rx_pkts,
>  	struct ci_rx_queue *rxq =3D rx_queue;
>  	enum iavf_rx_func_type rx_func_type;
>=20
> -	if (!rxq->iavf_vsi || rxq->iavf_vsi->adapter->no_poll)
> +	if (!rxq->iavf_vsi ||
> +	    rte_atomic_load_explicit(&rxq->iavf_vsi->adapter->no_poll,
> +				     rte_memory_order_acquire))
>  		return 0;
>=20
>  	rx_func_type =3D rxq->iavf_vsi->adapter->rx_func_type;
> @@ -3738,7 +3740,9 @@ iavf_xmit_pkts_no_poll(void *tx_queue, struct
> rte_mbuf **tx_pkts,
>  	struct ci_tx_queue *txq =3D tx_queue;
>  	enum iavf_tx_func_type tx_func_type;
>=20
> -	if (!txq->iavf_vsi || txq->iavf_vsi->adapter->no_poll)
> +	if (!txq->iavf_vsi ||
> +	    rte_atomic_load_explicit(&txq->iavf_vsi->adapter->no_poll,
> +				     rte_memory_order_acquire))
>  		return 0;
>=20
>  	tx_func_type =3D txq->iavf_vsi->adapter->tx_func_type;
> @@ -4025,6 +4029,75 @@ iavf_tx_done_cleanup_full(struct ci_tx_queue
> *txq,
>  	return (int)pkt_cnt;
>  }
>=20
> +/*
> + * iavf_dev_tx_drain - drain in-flight Tx descriptors after a link-down =
or
> + * impending PF reset event.
> + */
> +void
> +iavf_dev_tx_drain(struct rte_eth_dev *dev)
> +{
> +	struct ci_tx_queue *txq;
> +	uint64_t hz, deadline;
> +	int idle_iters =3D 0;
> +	uint16_t qid;
> +
> +	/*
> +	 * Allow any Tx burst already in flight on a data-plane lcore to
> +	 * write its remaining descriptors and notify. After
> +	 * this window, the no_poll gate set by the caller is observed at
> +	 * the next burst-entry and no new descriptors will be posted.
> +	 */
> +	rte_delay_us_block(IAVF_TX_DRAIN_SETTLE_US);
> +
> +	hz =3D rte_get_timer_hz();
> +	deadline =3D rte_get_timer_cycles() +
> +		(hz * IAVF_TX_DRAIN_TIMEOUT_US) / 1000000ULL;
> +
> +	while (rte_get_timer_cycles() < deadline) {
> +		bool any_pending =3D false;
> +		bool any_progress =3D false;
> +
> +		for (qid =3D 0; qid < dev->data->nb_tx_queues; qid++) {
> +			txq =3D dev->data->tx_queues[qid];
> +			if (txq =3D=3D NULL ||
> +			    dev->data->tx_queue_state[qid] !=3D
> +				RTE_ETH_QUEUE_STATE_STARTED)
> +				continue;
> +
> +			/*
> +			 * nb_tx_free =3D=3D nb_tx_desc - 1 means the ring is
> +			 * empty (one descriptor is always reserved).
> +			 */
> +			if (txq->nb_tx_free >=3D txq->nb_tx_desc - 1)
> +				continue;
> +
> +			any_pending =3D true;
> +			if (ci_tx_xmit_cleanup(txq) =3D=3D 0)
> +				any_progress =3D true;
> +		}
> +
> +		if (!any_pending)
> +			return;
> +
> +		if (any_progress) {
> +			idle_iters =3D 0;
> +		} else if (++idle_iters >=3D IAVF_TX_DRAIN_IDLE_MAX) {
> +			/*
> +			 * HW has not advanced the RS-bit write-back for
> +			 * several polling intervals; either the queue is
> +			 * quiescent except for the sub-rs_thresh tail
> +			 * (which we cannot observe here) or HW is no
> +			 * longer fetching. Further polling is unlikely to
> +			 * help, and the PF teardown path has its own
> +			 * grace period for the remainder.
> +			 */
> +			break;
> +		}
> +
> +		rte_delay_us_block(IAVF_TX_DRAIN_POLL_US);
> +	}
> +}
> +
>  int
>  iavf_dev_tx_done_cleanup(void *txq, uint32_t free_cnt)
>  {
> diff --git a/drivers/net/intel/iavf/iavf_rxtx.h
> b/drivers/net/intel/iavf/iavf_rxtx.h
> index 22ea415f44..4088bc421c 100644
> --- a/drivers/net/intel/iavf/iavf_rxtx.h
> +++ b/drivers/net/intel/iavf/iavf_rxtx.h
> @@ -506,6 +506,11 @@ enum iavf_tx_ctx_desc_tunnel_l4_tunnel_type {
>  /* Valid indicator bit for the time_stamp_low field */
>  #define IAVF_RX_FLX_DESC_TS_VALID	(0x1UL)
>=20
> +#define IAVF_TX_DRAIN_TIMEOUT_US	10000	/* total drain budget:
> 10 ms */
> +#define IAVF_TX_DRAIN_SETTLE_US		100	/* let in-flight burst
> land  */
> +#define IAVF_TX_DRAIN_POLL_US		50	/* poll interval
> */
> +#define IAVF_TX_DRAIN_IDLE_MAX		20	/* ~1 ms of no RS
> write-back */
> +
>  int iavf_dev_rx_queue_setup(struct rte_eth_dev *dev,
>  			   uint16_t queue_idx,
>  			   uint16_t nb_desc,
> @@ -641,6 +646,7 @@ void iavf_set_default_ptype_table(struct rte_eth_dev
> *dev);
>  void iavf_rx_queue_release_mbufs_vec(struct ci_rx_queue *rxq);
>  void iavf_rx_queue_release_mbufs_neon(struct ci_rx_queue *rxq);
>  enum rte_vect_max_simd iavf_get_max_simd_bitwidth(void);
> +void iavf_dev_tx_drain(struct rte_eth_dev *dev);
>=20
>  static inline
>  void iavf_dump_rx_descriptor(struct ci_rx_queue *rxq,
> diff --git a/drivers/net/intel/iavf/iavf_vchnl.c
> b/drivers/net/intel/iavf/iavf_vchnl.c
> index f8fffa7802..513c3e18dd 100644
> --- a/drivers/net/intel/iavf/iavf_vchnl.c
> +++ b/drivers/net/intel/iavf/iavf_vchnl.c
> @@ -260,7 +260,7 @@ iavf_handle_link_change_event(struct rte_eth_dev
> *dev,
>  	 * (link is down or a VF reset is in progress); the watchdog drives
>  	 * auto-reset recovery, so it must remain armed in those cases.
>  	 */
> -	if (vf->link_up && !vf->vf_reset)
> +	if (vf->link_up && !vf->vf_reset && !vf->in_reset_recovery)
>  		iavf_dev_watchdog_disable(adapter);
>  	else
>  		iavf_dev_watchdog_enable(adapter);
> @@ -268,9 +268,27 @@ iavf_handle_link_change_event(struct rte_eth_dev
> *dev,
>  	if (adapter->devargs.no_poll_on_link_down) {
>  		iavf_set_no_poll(adapter, true);
>  		PMD_DRV_LOG(DEBUG, "VF no poll turned %s",
> -			    adapter->no_poll ? "on" : "off");
> +			    rte_atomic_load_explicit(&adapter->no_poll,
> +
> rte_memory_order_relaxed) ?
> +						     "on" : "off");
> +		if (!vf->link_up)
> +			iavf_dev_tx_drain(dev);
>  	}
>=20
> +	/*
> +	 * Resume a deferred dev_start.
> +	 * iavf_handle_hw_reset() sets vf->start_pending when
> +	 * reset recovery completed dev_init() but iavf_dev_start()
> +	 * itself failed (typically -EIO from
> VIRTCHNL_OP_CONFIG_VSI_QUEUES
> +	 * when the PF VSI was inactive).
> +	 * A link-up event implies the PF VSI is active again, so retry now.
> +	 * Run before the LSC event post so the port is ready to accept Tx
> +	 * by the time the app's link-up callback fires; no_poll has already
> +	 * been cleared above so bursts go through as soon as
> +	 * dev_start sets dev_started=3D1.
> +	 */
> +	iavf_resume_pending_start(dev);
> +
>  	iavf_dev_event_post(dev, RTE_ETH_EVENT_INTR_LSC, NULL, 0);
>=20
>  	PMD_DRV_LOG(INFO, "Link status update:%s",
> @@ -327,6 +345,8 @@ iavf_read_msg_from_pf(struct iavf_adapter
> *adapter, uint16_t buf_len,
>  			if (!vf->vf_reset) {
>  				vf->vf_reset =3D true;
>  				iavf_set_no_poll(adapter, false);
> +				if (adapter->devargs.no_poll_on_link_down)
> +					iavf_dev_tx_drain(vf->eth_dev);
>  				iavf_dev_event_post(vf->eth_dev,
>  					RTE_ETH_EVENT_INTR_RESET,
>  					NULL, 0);
> @@ -565,6 +585,9 @@ iavf_handle_pf_event_msg(struct rte_eth_dev *dev,
> uint8_t *msg,
>  		if (!vf->vf_reset) {
>  			vf->vf_reset =3D true;
>  			iavf_set_no_poll(adapter, false);
> +			iavf_dev_watchdog_enable(adapter);
> +			if (adapter->devargs.no_poll_on_link_down)
> +				iavf_dev_tx_drain(dev);
>  			iavf_dev_event_post(dev,
> RTE_ETH_EVENT_INTR_RESET,
>  				NULL, 0);
>  		}
> @@ -614,6 +637,19 @@ iavf_handle_virtchnl_msg(struct rte_eth_dev *dev)
>  			break;
>  		}
>  		aq_opc =3D rte_le_to_cpu_16(info.desc.opcode);
> +
> +		/*
> +		 * During PF-initiated resets, iavf_clean_arq_element() has
> +		 * been observed to return IAVF_SUCCESS with a fully zeroed
> +		 * descriptor (opcode 0).
> +		 * Without this guard, such descriptors would fall through
> +		 * to the default case of the dispatch switch below and the
> +		 * "Request 0 is not supported yet" log flood reported in
> +		 * the field would be produced. These are discarded now.
> +		 */
> +		if (aq_opc =3D=3D 0)
> +			continue;
> +
>  		/* For the message sent from pf to vf, opcode is stored in
>  		 * cookie_high of struct iavf_aq_desc, while return error code
>  		 * are stored in cookie_low, Which is done by PF driver.
> --
> 2.34.1

