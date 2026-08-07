Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B63CC5AC7A
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Aug 2026 10:56:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 263C64027E;
	Fri,  7 Aug 2026 12:56:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 067F440264;
 Fri,  7 Aug 2026 12:56:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786100213; x=1817636213;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=kJ9PhmsrYMPT52vit3HpR3bBq5mFJ61h4Tp86kUpfl8=;
 b=iNmck4Bam0Tkg1c14fYDsGcRL51Dm25+OLGsbEwBzc9hW8Hks/YNJxcx
 Qym4GPcCCtXHKwLTjo+pJWtR8hh0em/dHY4sbmUyBs5clJstDLfKn5kTY
 6qxS4wqIVfsqtTa3OAkppr/v+dJ35hMEql/zSWGfEgU13kBlSxmYibqXi
 ozq2ymWFEnH+LQkqA3/Ba9FL9GExsvFk+QeJ1+lhHH3tt9QSiyKnFIb0O
 L2PJ5UBJLNttFLB9mDMC72SIiA5EYcgiKCorPMzVd6TaxKNOb4ngOxHqL
 fQKB9ZIYYb9aNDk9X89L7P/AqHA4Kw+JeAYhn2DGKuFyv+fReVxUzKGUN w==;
X-CSE-ConnectionGUID: fEQbcGA9TNGe/POKvAoErA==
X-CSE-MsgGUID: fJ1tOfV6TxGhboCUPIB5sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86715549"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; d="scan'208";a="86715549"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2026 03:56:51 -0700
X-CSE-ConnectionGUID: w0/PJ+rFS+O3YI7so6SWKQ==
X-CSE-MsgGUID: q8uH+s6bRBK4mCECDExaig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; d="scan'208";a="261078530"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2026 03:56:51 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 03:56:50 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 7 Aug 2026 03:56:50 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.22) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 03:56:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lyLTafc1j/GkHdPXEDOk2+g9BFCIWUT8OazeifhJo3IsFNSzht0pFR4SkDBWew4C9wZkJ3uJrKmiuxnXuzzWutiiLnHBGVl4iwr52qN57MKWeNMgBwEvcMBh9DZYRI0W9uPFnSTD/yQydRCOp2EbUSzvyx+vz6igFS2OmItz8XAZznFYPN87uiHeqx80954CyprmUkfl8N6dlpMwmNdn1rcrJzJ434Eo8hBO0/QxjYw4iD7IAwxBZgj8C1PdMChXJPHF61sPfqbaK2qj2DN4VA8JnF9PlH2JE2Dgh6pbLiq5fKm5Ju78YHtiqrVovpUEtKIyds5Vnx7fKq1uqyEYUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VtdBXfCW+OJX5oV5BaqaXU7Wlw6Ff+zvvlsSYXZPoU8=;
 b=yYtCOJ4R17jYyMOpU0g2azVh5RUBJQH2Mj1Kacmh4iyvBTgHkk+MWU0EyL8MQedebYYHKQPX0p8OGJFWIYy8bJls6PsotPoSniqNfISueVRGOTzvdOQbF2UAafuSl3bNuvyybrXFngjUd5fpzo815vhs5Vq5ZqV9/UxReTI10zxD+zrC5AGG6oOsA8QAuG512XPMv8JewO4y8OMJTfP3Jhd9TkgG67W08RInO7hBVjf1QdEC/+W+kiwLYqASSy5HjbvjoSg9Y2fWC7YGv9b5LHLdZERvmIBqBpG4PnNS9/7DubZSB/lMCHV+RPqjua/ul+50bYuj+L/jukqfLavP9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by IA4PR11MB9230.namprd11.prod.outlook.com (2603:10b6:208:567::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Fri, 7 Aug
 2026 10:56:40 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0270.016; Fri, 7 Aug 2026
 10:56:40 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Mandal, Anurag" <anurag.mandal@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH 4/5] net/iavf: change no_poll flag to atomic
Thread-Topic: [PATCH 4/5] net/iavf: change no_poll flag to atomic
Thread-Index: AQHdJX1+MErjGm1GuU+QXs4ZP68CcraSarvg
Date: Fri, 7 Aug 2026 10:56:40 +0000
Message-ID: <IA4PR11MB9278D7BC04216882676C1DC28ED12@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <cover.1786004043.git.anurag.mandal@intel.com>
 <d1ea05c4fb2db04ce8cdd5d96b1998c183cf864e.1786004043.git.anurag.mandal@intel.com>
In-Reply-To: <d1ea05c4fb2db04ce8cdd5d96b1998c183cf864e.1786004043.git.anurag.mandal@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|IA4PR11MB9230:EE_
x-ms-office365-filtering-correlation-id: 6638c262-6a6b-4fef-f161-08def4728fab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|6133799003|56012099006|10067099003|4143699003|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: bJFwQI7eSqMCGTmKdxb8sw/AHglAmh07dwM3zUDqe6fgqSi3IKKboK+BMTs9fMx/QW8OUbIxQtTHhfRmRPH5Qr/P+L56pgIRzC3Hza7MzpBOvdn3W2wA6IAaCtmmc+/esLoLgU6U8dhmWa2dDFdgqzIlTAmsSSYi+kAvWnCTJ8QnEHPcPEAu4JtcnOKeorCnmRknzf1nGJ9n1vr+1t6wCu7HdV5kc0ON7zkxCCF0RzG42vbRxmuiMSEp4Mi7r9k4VCmRevBfFSt7JZdKs9K1LrRLwXMnbXRtbndEXfqM65cyyp6p7QjH4V2xJOzeHX/9RV2OhisvbmACaM1PmFc6JDTZOhuakRAYZNThKCmgxms0y95x5DoJK6Wi38yo1jH0618RI2i/I4iJVNH5ewPnfHH4L7+hoE9+FoUzogc97OsRI/RYKnyriXAZctjsqIZ1aYxJMad/N/PUw3bhGljnw9PcLInapPLda5lT3XwwI5MjPxD3lE3TZQ6/L57atuRzBTKRYwjGpvOvOxY3SkSHLNMD3l8pkXEu2HdHck/AbsZmiUUyTD0JSDSFxh35Ms7uFyYViEdkBwJrxMNGooIaNFxaIG4Vpc60pALH+zIgFC7v54GvVxKgmcmBQje4WHJR9yz38eVEXfXwhM6h2QIMDN8dqXDv9cb3SfoBvuYlNXSZlSx9uBSTS9c5wyDAuHj4N7rcEy+JqN+ju2GyEy9aiuNgrZaOVcixgKVaDs3nW3k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(6133799003)(56012099006)(10067099003)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lGojeoS1+G6N93VR2p17VGXo3xP6DZSMNS9hY6eq0pMYeNDxVYlVcrbbd5Q+?=
 =?us-ascii?Q?cqtMIGvTZLMKqAc4ELDrR1FygwyAhVwbAHtopYyGOZNKUEYAPu58y+eO8FK6?=
 =?us-ascii?Q?JIpgqYcm5GwWzqge6kx+BE383v3ZIf42B4GV9saGe6MvPdpHXiyv+6Tql8+W?=
 =?us-ascii?Q?aCOlVVRbtovkt2aHIxGmKITz6CIhsvpfwVelY/w1ipIRMvTrCcDPQnxPBT8k?=
 =?us-ascii?Q?w65zu54ORS8u8LH7q31h2VxzXuFy9m+d9WC84gN/I5QtQ37ZAZuB82TXw5+9?=
 =?us-ascii?Q?sSKLJkRYK9ZJd941twx7r8c2O9yJ3aJKs3jeuYz9eGYfkanpe09+f14CO26s?=
 =?us-ascii?Q?GTnCirigWEWYpWZJgxxAq63cTHKW3bVu9ld6dYMxR9yV/qreeS8r7tVrp2JF?=
 =?us-ascii?Q?8VvWjFp4sq6MPralONF89gXu1Dl7Zt3LekoiDTsOxvfr/+CFQTP80ZhWumHA?=
 =?us-ascii?Q?8+qpMCu/5jXoBh6RKhnsaCOReg2AY81rdyrpFlvJnX6QbciPILgownIMOvq9?=
 =?us-ascii?Q?iqJ7n03Dtq79gSkVeiEg7Hz7vGqslQArVRd+W0o+5r9KVoHVZ15OIqY8R4N0?=
 =?us-ascii?Q?QeW7K1OPRvfyDaVTVUIj23rx/pl1t/9HzK48wL+1n9Sc5Lqx4xXDsgXsbjj9?=
 =?us-ascii?Q?GUC0S3auJCspa0M5uJ+ySeVmOV9ke7lMCZk8IWvDMLU4j7xZFILUt5eiw9fS?=
 =?us-ascii?Q?NwVYkVaJai8sKICHQvJ24JJA/RpQm4v1YdFxOcSie9XOwXZeAX5heHkQwBm0?=
 =?us-ascii?Q?WsquoGnR8H2uk0VDCMstimKWMVtuWCOXLOUZHtl0w7oaZ/nqkR5dBMzr2Hk7?=
 =?us-ascii?Q?9bZKwyBpSZpPaEPmJBFC7dHkt38tQFj1kT04jqbQ8cdenu3XgtAlWvcxhVAE?=
 =?us-ascii?Q?GIUhZQ8906bYZj109L5RZ18xYUVwSnVSzoNa6aMnlN+DpnBeBTikoI3hXknO?=
 =?us-ascii?Q?e31TR7ohlpqfDJdpP7xdpyU16JOkGbxcgOwESJfo5O2fy7I39CYq5BRb9DB/?=
 =?us-ascii?Q?MvRpyaZwK6IeKPQWy59SmWsQ6E2XDqVmXZACVaMLOI2PUwldDRKnLWVR0Wwd?=
 =?us-ascii?Q?y7tBDdec1FoVXRCAiEb3WYOdPpknsrODKuXtT0Wq+iX3Qcf3K48Uci0vRrtE?=
 =?us-ascii?Q?aWphiHVBiAdsmG0uL7v9zYN+IdtYCEedQ+69rw4h0qww0OU2UUOL1j5ZA/5b?=
 =?us-ascii?Q?sxhHcWaNgxcN8BSkB8mLq4CxK6rx1UjX4vBInVk35hmL25g80Gl5vSkF9K5S?=
 =?us-ascii?Q?ATSWgv9dXUu37IoDqRe2tCQYSgnN/yq7S18eTwRQ7VxQQLbpZLQ5jhppP+E9?=
 =?us-ascii?Q?r7jxRb4mYxNDnUyRcY8uRNryo4kPcnnsUVf2qENIUPYNtd/Y0Xp29rRX6LIb?=
 =?us-ascii?Q?3NniOJFzBEYg1+rPg5SmZbEmNFKiOi8pHBPCySAKL7cShbKinn7DyUTQx440?=
 =?us-ascii?Q?IjTzSjLD/w4KXZjIyAK+6E6tMd+Wv/WffZYqtZ2+cMRbGfZQZfiWK3HNVy5P?=
 =?us-ascii?Q?ot+J7I92SENgojhXemiEx5MJ2x3CaVMBIJFKHzoGOyK15FOS97zdMqUygXfR?=
 =?us-ascii?Q?ezfPzQYlAmx0bo41ZOep43bll4dFWRXza8DWbpmgNLQfQxbOslsBb9GyREgq?=
 =?us-ascii?Q?kZLBumxvGaq79Xi7RXUy5bg6Mbz8Mu7mvc3lNm8PVebZM8dXMOFti6+VGm4O?=
 =?us-ascii?Q?Npm9/z0FKLQATzif4/9wVfCJm7h7on+Jjq1YKFdvo1cYTrxX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MPSzmmyd3gRkCUpKHMQSpxFo+JMfNnJ0jW0BLX8nwDhxUCWOyzc2f9u2IKIK/GiGWQYsTToAk1f5gptccRGymfEpmTIgj9k1Mfzr4fA77yC4V9zjXWSf3T8u/BTGnbUiz72rrI4pyOVzwAORGkbZCMbz57scvDCDPjFEz1UwsTRJIE+QVmAnvV3Hbq/O4qd1RZ5oBL2clgLemOKGb+jKfLB/JMcDsRvLTlZmXKyOcoTuXx8CIOWX79es/LHZrZRIG6DpEP6pdyy0Grqm44owk/Mf6EK93gpfHBYwVYOsg+vJGZOUzAfon3e5R4Z5RxwXcQ44I8yUf8csPos0lK0jLQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6638c262-6a6b-4fef-f161-08def4728fab
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2026 10:56:40.6766 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sIfTYGuw6I7QiL6RFVmweu6Cp+4a1+uXevhMNrMi4lz+L94XF4ZMVULU5NU4gKNAulb69JHxkYYCJsMtXIdESQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9230
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

> Subject: [PATCH 4/5] net/iavf: change no_poll flag to atomic
>=20
> The no_poll gate that pauses the Rx/Tx data path during reset and
> link-down was a plain bool written on the control path and read on
> the data-plane lcores without synchronization, allowing stale reads
> that either keep dropping traffic or trigger spurious reset detection.
>=20
> Made no_poll an RTE_ATOMIC(bool) and access it with release stores and
> acquire loads so data-plane lcores reliably observe gate changes.
>=20
> Fixes: 5b3124a0a6ef ("net/iavf: support no polling when link down")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>

Minor nit below. Other than that=20

Acked-by: Ciara Loftus <ciara.loftus@intel.com>

> ---
>  drivers/net/intel/iavf/iavf.h        | 2 +-
>  drivers/net/intel/iavf/iavf_ethdev.c | 6 +++++-
>  drivers/net/intel/iavf/iavf_rxtx.c   | 8 ++++++--
>  drivers/net/intel/iavf/iavf_vchnl.c  | 4 +++-
>  4 files changed, 15 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.=
h
> index e76c3bb410..037bc8436f 100644
> --- a/drivers/net/intel/iavf/iavf.h
> +++ b/drivers/net/intel/iavf/iavf.h
> @@ -392,7 +392,7 @@ struct iavf_adapter {
>  	alignas(RTE_CACHE_LINE_MIN_SIZE) uint32_t
> ptype_tbl[IAVF_MAX_PKT_TYPE];
>  	bool stopped;
>  	bool closed;
> -	bool no_poll;
> +	RTE_ATOMIC(bool)no_poll;

Add a space before no_poll

>  	enum iavf_rx_func_type rx_func_type;
>  	enum iavf_tx_func_type tx_func_type;
>  	uint16_t fdir_ref_cnt;
> diff --git a/drivers/net/intel/iavf/iavf_ethdev.c
> b/drivers/net/intel/iavf/iavf_ethdev.c
> index 87b826c873..f6ce339b0c 100644
> --- a/drivers/net/intel/iavf/iavf_ethdev.c
> +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> @@ -3604,9 +3604,13 @@ void
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
> diff --git a/drivers/net/intel/iavf/iavf_rxtx.c
> b/drivers/net/intel/iavf/iavf_rxtx.c
> index 931bb8420d..104197d082 100644
> --- a/drivers/net/intel/iavf/iavf_rxtx.c
> +++ b/drivers/net/intel/iavf/iavf_rxtx.c
> @@ -3723,7 +3723,9 @@ iavf_recv_pkts_no_poll(void *rx_queue, struct
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
> @@ -3739,7 +3741,9 @@ iavf_xmit_pkts_no_poll(void *tx_queue, struct
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
> diff --git a/drivers/net/intel/iavf/iavf_vchnl.c
> b/drivers/net/intel/iavf/iavf_vchnl.c
> index d22990a524..dee76f97cb 100644
> --- a/drivers/net/intel/iavf/iavf_vchnl.c
> +++ b/drivers/net/intel/iavf/iavf_vchnl.c
> @@ -268,7 +268,9 @@ iavf_handle_link_change_event(struct rte_eth_dev
> *dev,
>  	if (adapter->devargs.no_poll_on_link_down) {
>  		iavf_set_no_poll(adapter, true);
>  		PMD_DRV_LOG(DEBUG, "VF no poll turned %s",
> -			    adapter->no_poll ? "on" : "off");
> +			    rte_atomic_load_explicit(&adapter->no_poll,
> +
> rte_memory_order_relaxed) ?
> +						     "on" : "off");
>  		if (!vf->link_up)
>  			iavf_dev_tx_drain(dev);
>  	}
> --
> 2.34.1

