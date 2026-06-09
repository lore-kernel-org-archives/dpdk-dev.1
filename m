Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8900CD8CAA
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 10:53:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD3D2402BE;
	Tue,  9 Jun 2026 12:53:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id D347B4025E;
 Tue,  9 Jun 2026 12:53:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781002384; x=1812538384;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=XKC8mLMD66iv5qUo4GWPRpb9BIjhd9Qi7l3BeD9RHt8=;
 b=kRDscnj4zXdur1mqbTrFnMrmMwpps9hnvd14A37FYfWjux2BIUjxOATS
 2mPohdgpG/w8hl4JyRSJea267co3zq5kkflDPXjx4bMBH2HoQsenyDIce
 Im8MnwWZ3btmxzKeaQC9z9Kwwai1MNJyMDUB4Bl/a/Wp5QyRSHGzYpoAb
 p7sTO2cyZ0q/0xRsYShZFJa9hbl7+dJYwoKbQ5/kmFi5HDP6sYTa1/O3F
 hKSwYAaRues6NWPasbBPwhxgCvOhSuyWGoZXU6QfJNDfZrQzMrfEm2atO
 i+Uj3U6ZZYQfY+nIte6FNFMEFkcy1nEcZvAceSwUQgExy9H0GL4F5Ys30 Q==;
X-CSE-ConnectionGUID: 1qyMQ+iSQ+unrY4BHot6Xg==
X-CSE-MsgGUID: TM2eYE+qR5O4z2xc1pzkpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81944397"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="81944397"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 03:53:02 -0700
X-CSE-ConnectionGUID: hcR8UQcsS4KfABcliys07w==
X-CSE-MsgGUID: XMP89/swQ7ee08Ie3ojfCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="276016364"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 03:53:01 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 03:53:01 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 9 Jun 2026 03:53:00 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.57)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 03:53:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZsXSlpJFmki+16h8W5clU9dDBEBfns6qbgC4ZZ0vsMFYGNy676hnbCbogpNakonQLHH5zutzdEhjqsd7W32VSAabcJwff/Y3m+KeEXM2LxWgNXiQ38MOfljDXQjKcG2hN5v7b15VWRD6utwX/TLgW2ZoZOiLG1XTrpNGs6cCc9PIe9jmNgGSwlmSn3any+yt6Ry/Zg3YFcZ7CudVA/fu78q7E/6uRaJ/EYQyHwv8W/K+oZ2oUWm4yo49VP7MMDK8wOUxbbXAvB89rB3wk7EkWANyM0eqjIMJA20owOGsOpBkisfrwXHdaZeBaR65Agr3zTl0yd5PW+f4hz6arhqp6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnF9tvROhvVy34VHGae6o1bmkP7jAb1sC/1UMtthR+s=;
 b=GlWQmuohpf6YWLmHodFOb4AxNMuGflWLqa1JiIn/w3f+Qv75CJd9AHmqTQpi6GIJTogChy3wZ7bjiPFQGEJZgIUt0tPyxdCdzQk+54lfFd0JMSe3CWNtALyIQkxnya8XN1IcP5cXVDiHAue2bVo+jy2V1nlah4nYXm7S9xs8gNN9bmEcxMXp7Q8BtoyJ3hxZuC8EYWHPnsI42DpGx9J+Z6d+Ozp3P697gylMrD2K6NPeOBvKR3YxBd37akWGfyFHqlSMrXIRx4DZ4Wp/A0rvlTlR2/J4o8Mfm4eDQxcH6gFNm+HiGrBSP8ZjTsH0nxQ2S+iUzcKJEW77wDZOtwSqjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by DM4PR11MB5263.namprd11.prod.outlook.com (2603:10b6:5:38a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 10:52:53 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 10:52:53 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Mandal, Anurag" <anurag.mandal@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v4] net/iavf: fix duplicate VF reset during PF reset
 recovery
Thread-Topic: [PATCH v4] net/iavf: fix duplicate VF reset during PF reset
 recovery
Thread-Index: AQHc92QBBPuzAs4D/UCvnCtph0L4sbY2C3tg
Date: Tue, 9 Jun 2026 10:52:53 +0000
Message-ID: <IA4PR11MB9278C6E444FC5E3D969865318E1D2@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20260605202911.314359-1-anurag.mandal@intel.com>
 <20260608162936.354248-1-anurag.mandal@intel.com>
In-Reply-To: <20260608162936.354248-1-anurag.mandal@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|DM4PR11MB5263:EE_
x-ms-office365-filtering-correlation-id: bb28a4e2-5068-4935-48a2-08dec61541af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|6133799003|22082099003|18002099003|38070700021|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: UDDOd97R42FwYPkNXdQhZIJhV01YEr7GZWrN4sRmRD/OTUQjfr0K9ZTe7OoW0c8W6WLNQIWwdUP4zn5RsQdizKDQto9heBFtgIrtC4lhTeIwJjzhNKrWe/uWffI/H5LbbFygVKdkzmHOpkuCQ8MlLxH0JpkZxz4HrPyfFurI3p3hsWkYnH7IpZVZazzTAYbdWloVUGXP/DDp9jPKV/LIo5LWTe7qOLRmAXk9bVNPVtyw4ScH97CNpDLp/K8PGBAhSr1kF1tl2aCEmDzuvHNzixhp9hlcsqcB7RUR7N+vTVJgn+L+koCX45XwMfO5NhhJpwwuAG4zLwawzUe5FRZJ9hkBjpe3H06KRQZ67VnGg+ukkdGaG3qf7GXcPbBA/sKYWnye87HdPtI6IjR3bUVgsduwjI+ZzYKzunyyJIauwJuOpCJaEkzIr1dlxheW/Kb/TRUa0Z+FnxDUsB5NWysL8IR00HmG6G4eAFfRLYz6K1CI79RFY00O25AONOX+zZFdqHKLncPO77Plqvg6fqvh5phSa9FOS52ws/RszLhOEr1j/LzQ73uxnew9K8M43gDof0Lwkz0qJ+Pq6M/GlFtPHw63gzHjF1dcJ4bYz3Sv3Z5ymP0yAzyLxJXtZEZQlc4E6EgRnb2nS3NZGvakFxYUbb+rVSPC5kLyZeEX1TzkyuXJFstjdP1FBr3wiEDYsJDF4EoP5C83EDEvp/wFJMkFCuHBb/lff5wF+acNEfOKFM4zC7H0C908gdhcEsu7aPkt
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(6133799003)(22082099003)(18002099003)(38070700021)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BODMOMcvH81ztsr2NaCm2I681KL8+78+NXCg6TZdpcOpWlaYwJIeqRLvAgwA?=
 =?us-ascii?Q?8/+RXqP0hUii6YpA6e9tqC4zFa4Ur1N6zqaR6f5hM3KwORgR8EddWuCAfxZz?=
 =?us-ascii?Q?PolkcJ5vkIF3VmX/G08KVbN+6v85MHiYJbeWOLls4Xr+Vsq0HvouhH679CN/?=
 =?us-ascii?Q?/0uWcLBU7eG6+JdEMh5aYqqVyXOYweDSdlcUghQgLydbK91MfcwmwNs6+RWf?=
 =?us-ascii?Q?xKI7uXcdmOuvSAbIvvPlfSI/eDGeQlFpxPHiY6O4GYWqko+CDBkPsA+scDO8?=
 =?us-ascii?Q?nbs+rKSHDkJoitJJq/hXKbOHhG+e9iRX64i0ho5uORCySBWHYzwXElKaObmI?=
 =?us-ascii?Q?2MDPKp1kC1ZDcpGdXSTnx5DOnizIC9BB6oUHNZ/GrxmilCVK4dil9XiEUvyi?=
 =?us-ascii?Q?3OheCzbQwQ7qTIu6G4Adz2x2WpNmECC1JxEwnAYhVtim23A1uZCunBn2EX4+?=
 =?us-ascii?Q?OFzQUwwXmvszDlaZCO+TAhHLzdwvb7KRf3KjLkqqpe6+ScDJhQyt6/BKoOII?=
 =?us-ascii?Q?npaK5iyHiiy7YDII1F+n1EbBRxH9ubi/j1CeoywXsUNXaRCN8KB8goE/8VyV?=
 =?us-ascii?Q?ir7ZAh5HRumB2M+Odw522kvDDY1Uwp6SS6CT+3nf8zT89YTIMELO4ac6fzdm?=
 =?us-ascii?Q?RFAF/1kJbmxbDTAJ/sYdW2CFlIIv7xN+ujJkrrqz93BkImNvaVIbm+bQYaHx?=
 =?us-ascii?Q?j34IU6y6V8DrpPy5OuemzNJ2HDFwIOvguk5dUw2Y2KLD+ckVqN7IGEw6uwV6?=
 =?us-ascii?Q?UPPQ+VFKI9rN4t6n2Pj1usKo+34KSlR6DQ27+qD3E44mHwn+QLVKnm8eCWzq?=
 =?us-ascii?Q?vgVaIY/6AjIRIDuqKq6Wv8CvVYA9o/6mcP+zEjIwNolw2m6eMJm4SW4se3x1?=
 =?us-ascii?Q?qjEoPwdw8vzQS4c3b2NqoJYMUDnD7r3vf5MJEou/BkK9tm1RE00jJAZr9prb?=
 =?us-ascii?Q?984qOXsLyMu8uqaMa7TOMPWK/xZKvmaX9yguKmlwXgwML2zQt08OluQa6OVP?=
 =?us-ascii?Q?ahehXtfZzCP4/MFryYSDl0DksaFBm8JgfnpLh9cwQqGNPs5ixP6d1Ud54+qc?=
 =?us-ascii?Q?deH0NjV4MB2AL/u/B2cs3zFiDZqil2NVSf3TkN1hk5wzGXlOsxOoGeQ9DaiW?=
 =?us-ascii?Q?1sCWmDh14q7FJ7v9fhicIdVkEegsUY39PNWMUosIOAdiVRprC58UxnbPlJvk?=
 =?us-ascii?Q?xuG4e7MWL82iuo4UV9dY3u+kTGIIoG+QVezK+36e70mgWAwNK1uUL6Y4LOUO?=
 =?us-ascii?Q?xS4Nzs8VjrGA5UBzMY0XcOMWu9OunqU+6YOBB89MgAz7tRa/vj3g0nBZVziv?=
 =?us-ascii?Q?B6ORmStKJSX9jh3Luxxx0uOrD0k3OW9fi1eOMgLrXno8DdIHha6igv8+AZTD?=
 =?us-ascii?Q?xT6SqOkG6AJJb1ZzrVfvwyPYIhwCiynNC1vbWCzsKS8mCADvgQQcY6Hvlxim?=
 =?us-ascii?Q?Wrjn7dJ7Xy7LJTYG2BIgv43U/2UEP31++zBLs+QkRi2CLvVLlcUj/V1+9zzZ?=
 =?us-ascii?Q?SYwovM26EGAGzC3eGO2Rt0eKnmJTZ4K6/ru+FoQyfUNleyO1DfKd8HvTG3Op?=
 =?us-ascii?Q?pt/FlQsbGaDVy9ivprCXo7An9j7HyfdETl0AApImsfd34rOFw8DXvpIc0CDQ?=
 =?us-ascii?Q?swAJ6sIHqr11Dliyx2hCoJXiO+oQQYx8P+n5NVYCywPEAVBihEDmIoLWKKrL?=
 =?us-ascii?Q?Eo+wKnKxAOWvkJl1khUn0FOMvisSZZ/VafWg7wfjIby7ydAS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: XnkjmrPL8jT2Bb1MPQC+y2LjO8JvVYZQihJf2dBt4r+9nX4FFai6OofLVu5v9QJgXXysSuqUIhIpP1Icad3YPrh++t1mFvEZcKf6dtGQz0Kr+RYuILRmSBzGAGRxi2Yy7i5t7T4ptEw9EeMxHG8gxdSQQmgRYiu0LxhGspW02RGIuUGfk3oQWFZjuSV+bW21Qy81e+6Kf0s74YuoIRQSDZVr8Dn9q045z252iJYQ8KQjxLkPIzU+OpTHgayq8Wb8GoFTrGe1zazHcMELTCr/TNYx9tLFpnykThhjWnogwPptiKcOozGXZCJzl9+FX2S1gS24PwBlU3+TIhTWdzdizQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb28a4e2-5068-4935-48a2-08dec61541af
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2026 10:52:53.1539 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OgpkCd37Fe+yVUW3ArvVfX46IooRILppqSbF6x1aI1xL5zbuwT64LCtqAn5n9Vx3PAKWLHMg1KJC/3Dzzq8QsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5263
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

> Subject: [PATCH v4] net/iavf: fix duplicate VF reset during PF reset reco=
very
>=20
> During PF initiated reset recovery, iavf_dev_close() sending
> an extra VIRTCHNL_OP_RESET_VF while recovery is already in progress.
> That second reset can leave PF/VF virtchnl state inconsistent and
> cause VIRTCHNL_OP_CONFIG_VSI_QUEUES to fail with ERR_PARAM after
> ToR link flap/power-cycle, leaving the VF unable to recover.
> This results in connection loss.
>=20
> This patch skipped close-time VF reset and related close-time
> virtchnl operations when PF triggered reset recovery is set.
> This is done to avoid a duplicate VF reset, and keep normal
> behavior for application-driven close.
>=20
> Fixes: 675a104e2e94 ("net/iavf: fix abnormal disable HW interrupt")
> Fixes: b34fe66ea893 ("net/iavf: delay VF reset command")
> Fixes: 5e03e316c753 ("net/iavf: handle virtchnl event message without
> interrupt")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
> V4: Addressed Ciara Loftus comments
>   - split VF reset from other code changes
> V3: Addressed latest ai-code-review comments
> V2: Addressed ai-code-review comments
>=20
>  doc/guides/rel_notes/release_26_07.rst |  3 +++
>  drivers/net/intel/iavf/iavf_ethdev.c   | 37 +++++++++++++++-----------
>  drivers/net/intel/iavf/iavf_vchnl.c    | 18 ++++++++++---
>  3 files changed, 39 insertions(+), 19 deletions(-)
>=20
> diff --git a/doc/guides/rel_notes/release_26_07.rst
> b/doc/guides/rel_notes/release_26_07.rst
> index d2563ac503..f6899a78c3 100644
> --- a/doc/guides/rel_notes/release_26_07.rst
> +++ b/doc/guides/rel_notes/release_26_07.rst
> @@ -95,6 +95,9 @@ New Features
>=20
>    * Added support for transmitting LLDP packets based on mbuf packet typ=
e.
>    * Implemented AVX2 context descriptor transmit paths.
> +  * Prevented duplicate 'VIRTCHNL_OP_RESET_VF' during a PF-initiated
> +    reset recovery, which earlier caused virtchnl state corruption
> +    and connection loss after a top-of-rack (ToR) link flap/power-cycle.
>=20
>  * **Updated PCAP ethernet driver.**
>=20
> diff --git a/drivers/net/intel/iavf/iavf_ethdev.c
> b/drivers/net/intel/iavf/iavf_ethdev.c
> index a8031e23a5..99457ae510 100644
> --- a/drivers/net/intel/iavf/iavf_ethdev.c
> +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> @@ -3166,24 +3166,27 @@ iavf_dev_close(struct rte_eth_dev *dev)
>=20
>  	ret =3D iavf_dev_stop(dev);
>=20
> -	/*
> -	 * Release redundant queue resource when close the dev
> -	 * so that other vfs can re-use the queues.
> -	 */
> -	if (vf->lv_enabled) {
> -		ret =3D iavf_request_queues(dev,
> IAVF_MAX_NUM_QUEUES_DFLT);
> -		if (ret)
> -			PMD_DRV_LOG(ERR, "Reset the num of queues
> failed");
> +	/* Skip RESET_VF on a PF-initiated reset */
> +	if (!adapter->closed && !vf->in_reset_recovery) {

adapter->closed will always be false here so no need to check it.

vf->in_reset_recovery is set for a VF initiated reset as well which does
require sending VIRTCHNL_OP_RESET_VF because that kicks off the reset.
(rte_pmd_iavf_reinit -> handle_hw_reset is the vf initiated reset path.)

We need some way to know if we are currently handling a PF initiated
reset here. Another adapter flag, or else make in_reset_recovery
tri-state eg. 0 (no reset) 1 (pf initiated) 2 (vf initiated)
Then skip the OP_RESET_VF if pf initiated.

> +		/*
> +		 * Release redundant queue resource when close the dev
> +		 * so that other vfs can re-use the queues.
> +		 */
> +		if (vf->lv_enabled) {
> +			ret =3D iavf_request_queues(dev,
> IAVF_MAX_NUM_QUEUES_DFLT);
> +			if (ret)
> +				PMD_DRV_LOG(ERR, "Reset the num of
> queues failed");
> +			vf->max_rss_qregion =3D
> IAVF_MAX_NUM_QUEUES_DFLT;
> +		}
>=20
> -		vf->max_rss_qregion =3D IAVF_MAX_NUM_QUEUES_DFLT;
> +		/*
> +		 * Disable promiscuous mode before resetting the VF. This is to
> avoid
> +		 * potential issues when the PF is bound to the kernel driver.
> +		 */
> +		if (vf->promisc_unicast_enabled || vf-
> >promisc_multicast_enabled)
> +			iavf_config_promisc(adapter, false, false);
>  	}
>=20
> -	/* Disable promiscuous mode before resetting the VF. This is to avoid
> -	 * potential issues when the PF is bound to the kernel driver.
> -	 */
> -	if (vf->promisc_unicast_enabled || vf->promisc_multicast_enabled)
> -		iavf_config_promisc(adapter, false, false);
> -
>  	adapter->closed =3D true;
>=20
>  	/* free iAVF security device context all related resources */
> @@ -3195,7 +3198,9 @@ iavf_dev_close(struct rte_eth_dev *dev)
>  	iavf_flow_flush(dev, NULL);
>  	iavf_flow_uninit(adapter);
>=20
> -	iavf_vf_reset(hw);
> +	/* Skip RESET_VF on a PF-initiated reset */
> +	if (!vf->in_reset_recovery)
> +		iavf_vf_reset(hw);
>  	vf->aq_intr_enabled =3D false;
>  	iavf_shutdown_adminq(hw);
>  	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_WB_ON_ITR)
> {
> diff --git a/drivers/net/intel/iavf/iavf_vchnl.c
> b/drivers/net/intel/iavf/iavf_vchnl.c
> index 94ccfb5d6e..cf3513ef94 100644
> --- a/drivers/net/intel/iavf/iavf_vchnl.c
> +++ b/drivers/net/intel/iavf/iavf_vchnl.c
> @@ -283,9 +283,21 @@ iavf_read_msg_from_pf(struct iavf_adapter
> *adapter, uint16_t buf_len,
>  					vf->link_up ? "up" : "down");
>  			break;
>  		case VIRTCHNL_EVENT_RESET_IMPENDING:
> -			vf->vf_reset =3D true;
> -			iavf_set_no_poll(adapter, false);
> -			PMD_DRV_LOG(INFO, "VF is resetting");
> +			/*
> +			 * Force link down on impending reset to drop
> +			 * the cached link-up state; a fresh LSC up
> +			 * event will be re-issued by the PF once the
> +			 * VF is reinitialised.
> +			 */
> +			vf->link_up =3D false;
> +			if (!vf->vf_reset) {
> +				vf->vf_reset =3D true;
> +				iavf_set_no_poll(adapter, false);
> +				iavf_dev_event_post(vf->eth_dev,
> +					RTE_ETH_EVENT_INTR_RESET,
> +					NULL, 0);
> +			}
> +			PMD_DRV_LOG(DEBUG, "VF is resetting");
>  			break;
>  		case VIRTCHNL_EVENT_PF_DRIVER_CLOSE:
>  			vf->dev_closed =3D true;
> --
> 2.34.1

