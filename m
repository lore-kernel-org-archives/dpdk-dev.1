Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F8ECD8CB9
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 10:50:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F0C1A4060C;
	Wed, 10 Jun 2026 12:50:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 42B1640269;
 Wed, 10 Jun 2026 12:50:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781088639; x=1812624639;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=C5S6JXUFg7wgGwojpu97xQmnXOnrSoZg/Wow1wOQgbA=;
 b=AIaTbnRtlGdtB+zjPOSUlJ8eZQkH4R9bKfZKqIjaidho8DD1/U7Lwu5r
 ZdKj0Dm7D2AM0eBVjo/ZtIbjMWFdOX68E20x2X70TfSgQBVgkxzugEsXl
 JelB8wntasxscpRKtt6KHNJh9GItTGJ843rUnY8DpMSJacnIoJvaKcQwx
 z2LUjfM6WWUvQ1znAa53EWmc6zSs4nINj+cW/qO7M7BYBqoLjFFJ9myH4
 wqEsjknmH0T6QZm6dZGBzrnnr5S5XM3I4eB/4TI+i1ot+iHvBYa2HBOOi
 5Df2Wzjn2Q211wx6fUA1jHXi/KzSZcGH/Gc/EMEPl8nRIItuj//j/G+in A==;
X-CSE-ConnectionGUID: RkFVuBqvQ2+XvK4TtrbA7Q==
X-CSE-MsgGUID: vVrSolvYSUu/K4e7XRTa3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="69411503"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="69411503"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 03:50:38 -0700
X-CSE-ConnectionGUID: z3jKQNzmRbalOtwio7iXTw==
X-CSE-MsgGUID: fZauy+gUS/O5eHt7ho19Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="242001556"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 03:50:38 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 10 Jun 2026 03:50:37 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 10 Jun 2026 03:50:37 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.15) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 10 Jun 2026 03:50:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eV+2mX06rTATjEyIoUtFT1tmflESX/F7K3n8mN39uDqjW/ZsMWUKumuLE8Ppx9aJIj+gt2oOIJghw+P+MO+BUiUZfonioneE/m/h3ZqFC2wqldnf5XK3woSxZItIS2pau5JIU9taak9FRjY7NL3jysYaisLmoPDE1U5wYGmNdDFxbUjmVsoG3s7xR5NLlF8PQA5bLvfnwpOIoR/XV4HNUT4GuFIXRGECZeGCDlq9kpsvipPjVxnBRPHEFKQHN2kFkmvhaUQCNpdjF/K/g+AXuT0R5csE2S7NNmQ0DbOsSbNlnBX26Kr//F5bf1OiKdSSbhKa0u5vWYS3WOKZWnuPvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=siFmkUbbzUMIUl11FfhVnyOa29vC0sSMywn2/SU9/+k=;
 b=Cg1spL9P9pd4jSn4r59boxd3Bc0ZS+tpUyHra6wAcqx0WekHez4sLasb34cNsQg98WpJPXBN5/vPCAMFj/bb4xwSFsdQ1xL/s9pM864LMLJJNTVqkLlLiWafdQqEZeDHBk8vnu2dPe9hwbNqu8GhXric5b5epap0/XbI/pFAJ7udmu0AF670qA5bsnB2o1LKiEXRRnqBCJ7dnSheLycdvgyrn53WskT0CptGHKble7cM1ynDMZnA0KplnkUHlol0QIDl9SgaoovJ8QOt2UARdg9Vwr2LDTGqpfOba8NwSUAOYy5Qx04RVBZA7OWcMfZOp9+/dm4QBAWlDNSCWVaRiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by SA1PR11MB7700.namprd11.prod.outlook.com (2603:10b6:806:330::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 10:50:29 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 10:50:29 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Mandal, Anurag" <anurag.mandal@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v5] net/iavf: fix duplicate VF reset during PF reset
 recovery
Thread-Topic: [PATCH v5] net/iavf: fix duplicate VF reset during PF reset
 recovery
Thread-Index: AQHc+MDf6KPxpYDyXECNgXm39bwdE7Y3mXKA
Date: Wed, 10 Jun 2026 10:50:28 +0000
Message-ID: <IA4PR11MB9278C1F04D8BB54089B361E58E1A2@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20260605202911.314359-1-anurag.mandal@intel.com>
 <20260610100704.366722-1-anurag.mandal@intel.com>
In-Reply-To: <20260610100704.366722-1-anurag.mandal@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|SA1PR11MB7700:EE_
x-ms-office365-filtering-correlation-id: 778725ef-bb24-43fd-cae8-08dec6de1622
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|38070700021|18002099003|22082099003|11063799006|5023799004|4143699003|6133799003|56012099006;
x-microsoft-antispam-message-info: QrUuIYEtyrwv7nZAgHsl4ft8SrkcdVTHh9NJpxlhbN1FxH0v1wLJf3Y+4oQRecp4xMzgsXrx+yihfVkN9TcFWtZHB4+gXMtJDj7LVfHAhadyaqUXuDXZEy9DCKeFGZCv2Y1/ITCt6rBQLuUuq/LIqTXaZUJDDU5WYcePpHr18TcpwKrOlOTVdTv32pwKuxx6SRTwQ+ShcvSzhvdyEtfgSHA4kSDXSiIgYANCaaI82IyqZmSR878zbvDF8PVgGhEhqoFoZs79F80S8VMhK3voPuDYnpK4v/cKXMpPoexTF+cp+NWVtSxzcshf5WEizcjzS9QVSvUWVVVssDXHY2FAMc22FBzfVGxRyd9YSwEAYxfhCjCKXJqiUnk9uBjiLeux9HgsdsojQiD2z67V6ThF+OZyz5XXadKYiFw+k6O8UBAjhBsaChVJleGCkCCqgkuIwJPvTNM/EhBQli71RkwvJeTFHtBm7uXnEU/cpHVyQVLER9NT8+awn7IZzipDWIk/Yza2bYVxa3+US5VSegj5UP2ce/c3Gonu2KTp2935N+dYIqNfsfuEBb9G9ONDFGKuA326+c3wz6xSvCq0JhF78FUg1C/pTuDltmwullElO41RZcmlDhEm18Fz1Ag6h8qP7VNTuc+b7AF1zoI+FKJCvABn3hRaDIC2QMmGw1OCW1fuvKTxbNZKsCqDdejvbdHNXl3Juaq+RbMOqgHAL1N648+bLe+1Z5myk5plzOkus4aEUG++1PncvI5TGeHimPLk
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(38070700021)(18002099003)(22082099003)(11063799006)(5023799004)(4143699003)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CKJqfVMQzWzMFYnsZbTkLXfSUYJZSKHClyIFK8YV7EE/cOJWdFT5KbhrS9w6?=
 =?us-ascii?Q?W9xGU1nYwo97iAcQ565P5COiqse8pDgHh3gm/mmC4ygitwbqS76GU9GWf2zo?=
 =?us-ascii?Q?aGTRJxucNxbJbh9r2oIYYA6qcNB8OIElAVfrf8fgpW4R6vbUfe1wsDaz8klO?=
 =?us-ascii?Q?ciBD+mhee8lioDixedHlkdu1WcuxdQQmeKk2yP3aADsL8tPeEbOwvbppeCQy?=
 =?us-ascii?Q?MjX1NuBrSQDUTBON1X2KHcgIdMFra5KQV28GUC1r2VjQW6cVz+OCIvf+3o1q?=
 =?us-ascii?Q?5FT8d9k5vFpkkWsRjUpQIGH1OO65RBcxLUfHTyrWfQP96XThndVhQd/1Oyg6?=
 =?us-ascii?Q?4aL+H2KtzGQ1NG2krS+jM7lSx+2qVXnjzA3tNs8rrRjWJewgaom1lzNtoUH6?=
 =?us-ascii?Q?SWj1ZGvVN7fqLy5nA/6zT0w4pDktqj4nTkCSUnE8O+I0qqYlB3Lz2i6abQal?=
 =?us-ascii?Q?v2mJf9hbYktPfjll9+YFEv6GkrnpMEmhecVWFGH+O0vbrOR+l1aRtn0kAbqO?=
 =?us-ascii?Q?aYN3ub7dT1JIuhN02tgonAE/ZeozugNppjQXEOH4u5QPuk/+Nx/dQyjgSSod?=
 =?us-ascii?Q?mf1A1pHW0h7oiTZgpOokhXrcbiAaPThY7gtaJEdLlP6jVM80l1Xcp2qBodHL?=
 =?us-ascii?Q?v2DwbrgABH2eqBgIkmnh37Jprt/BRZykKmJnmtkYw/tF3KKzNtPWBeul0ZF5?=
 =?us-ascii?Q?aSc13B1OKsfKW3e4NcyqU5UBtJhwRDvN5zPItA9k4878RqYP/cxcDrzHbXtm?=
 =?us-ascii?Q?iEn9Kh8SqzMinMNI92sA2mVBqbFiCCNnmtoTX0KxE8X3KJjH+RE96bqTCLmC?=
 =?us-ascii?Q?GombUXnD1o+NUTUqMKXNXYJYMmOHrV6g/N6QTEGz2PFFSNZJ5eqWOTgDBZds?=
 =?us-ascii?Q?gPW5KlvZiTpLwE93LkFv+538e0eshUoiT3vKC04ddWm4pu2zQxzDMfiVSiL1?=
 =?us-ascii?Q?ahaF35iXmhRM42mhDFrHfwyaKQhTz7RwBPA1cS/4BMO1os1fJq8pRBXyRwjE?=
 =?us-ascii?Q?fYcCEPCPDdl0cnlDqrWF9X3IgrWYtdLIYNGJVXoA1iWZXdvQqJrPileaaOK9?=
 =?us-ascii?Q?YifLm6DuM/8HZYffVcU4Y48PU7cFheLjMcwRh1omfjYK4VKbTCWcJoUWE547?=
 =?us-ascii?Q?8PenIrde7SSCBGTQ8DaADlAoT1kCYYAyUCW6EMRCFvUEb8YDJDZ8pJPyjoFi?=
 =?us-ascii?Q?A4Rp9gL5urvvtbV3bZYm3pDlYReXNyuVyXGgf1S98azgZoMK8Qs/Mw/m6CjP?=
 =?us-ascii?Q?cjVURqdK0A8asv5Cl1fwFaYiaAEKN4YOqfvclprejipxXU/4n6AEMRdi24VP?=
 =?us-ascii?Q?mwO8JfXL9jg2FhJso7kO4orNd/uWB+eJt0i4cWBtH6ecCxd5sMrq8DlnA/qv?=
 =?us-ascii?Q?KmDOseuKZa5kJsW1ft7f5n9HupRybClLR51iSTAkIcofSpe3ucyXBACQtrEx?=
 =?us-ascii?Q?XM7XJBBU7Or4eYw5K46zSTG+f5pMBFi0+uc0sFw+x7Ai2N+GvSSqn8gLhHTW?=
 =?us-ascii?Q?NzdwNmRSGhC7FGc5kGNie9CEkuAYxJAfuzgxVu2Jy8FjWSjw10mrcF4joR0o?=
 =?us-ascii?Q?T4yt5inDoLsXyLU39UR8+AzDLj3JAi3YGGTFstgTMf7Yo9bNQAfG82pP1xCL?=
 =?us-ascii?Q?gCUxQ8OsXTbAKANw/xCnOjh5kisB3IAqObzoLlYpiBPTrFpy7suGp2X2yxLp?=
 =?us-ascii?Q?u+3h5BweQc0IYNjsEtPuuh9gtwOSC+2OtbU9Cy3lfnle5tB+CWSw/Q/SvobJ?=
 =?us-ascii?Q?cww52cXa7A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GNl5SLq/MHKTZMCql0r7vM91UIx1pTyC66rPR6F4JyxZdJPSHOihvKf1TvIhFmeRsC1Op7rVbOPC7bC3cVWmXyLlCDqq0Qfh1wysByMEyKsaX8rajfyJ9aXepv+QMiTnAE8g0hC8UFE+uON7OK+pNN8Pk0DbNjdDDJe8PZiCeIiUYfXtMpvmA8T1GbDm7TyaKM/Co5Bh/sF6NJ6k1ohQzTwCyBWJsHkZbViRSx5a/84h6alILpQxzxYeRwjQ4kx6+vl+nRMWbEYHZP2SCRZPisUvIdsspa7cMuvRGEqrXeewkxtbD9Is1TPi70gyZ9mvV1f8OuuBAZ+CzoMFqysTIA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 778725ef-bb24-43fd-cae8-08dec6de1622
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2026 10:50:28.9072 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qbnpQVqPvQAtZpUF6STTw1APJPOg9OrmNfYqEEe6Kk/yRKOdeVezX56y1g0Ia9k+hU1zsl4/0U4yXA3FekoXPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7700
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

> Subject: [PATCH v5] net/iavf: fix duplicate VF reset during PF reset reco=
very
>=20
> During PF initiated reset recovery, iavf_dev_close() sending
> an extra VIRTCHNL_OP_RESET_VF while recovery is already in progress.
> That second reset can leave PF/VF virtchnl state inconsistent and
> cause VIRTCHNL_OP_CONFIG_VSI_QUEUES to fail with ERR_PARAM after
> ToR link flap/power-cycle, leaving the VF unable to recover.
> This results in connection loss.
>=20
> This patch introduces a new flag 'pf_reset_in_progress', that is
> set only when iavf_handle_hw_reset() is entered with
> vf_initiated_reset as false and is cleared on exit.
> Also, close-time VF reset and related close-time virtchnl
> operations are skipped when PF triggered reset recovery is set.
> This is done to avoid a duplicate VF reset, and keep normal
> behavior for application-driven close or VF-initiated reinit.
>=20
> Fixes: 675a104e2e94 ("net/iavf: fix abnormal disable HW interrupt")
> Fixes: b34fe66ea893 ("net/iavf: delay VF reset command")
> Fixes: 5e03e316c753 ("net/iavf: handle virtchnl event message without
> interrupt")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>

Acked-by: Ciara Loftus <ciara.loftus@intel.com>

I think you may need to respin due to patch application failure.
I have some suggestions for improving the comments/release notes
that you could include in the next version. Code looks good to me.

> ---
> V5: Addressed Ciara Loftus's comments
>  - added separate flag for PF initiated reset recovery
> V4: Addressed Ciara Loftus's comments
>  - split VF reset from other code changes
> V3: Addressed latest ai-code-review comments
> V2: Addressed ai-code-review comments
>=20
>  doc/guides/rel_notes/release_26_07.rst |  3 ++
>  drivers/net/intel/iavf/iavf.h          |  7 +++++
>  drivers/net/intel/iavf/iavf_ethdev.c   | 40 +++++++++++++++-----------
>  drivers/net/intel/iavf/iavf_vchnl.c    | 18 ++++++++++--
>  4 files changed, 49 insertions(+), 19 deletions(-)
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

I think something more concise here would be better.
eg. "Fixed duplicate send of 'VIRTCHNL_OP_RESET_VF' during PF reset
recovery which could cause virtchnl state corruption"

>=20
>  * **Updated PCAP ethernet driver.**
>=20
> diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.=
h
> index 2615b6f034..67aacbe7a6 100644
> --- a/drivers/net/intel/iavf/iavf.h
> +++ b/drivers/net/intel/iavf/iavf.h
> @@ -292,6 +292,13 @@ struct iavf_info {
>=20
>  	bool in_reset_recovery;
>=20
> +	/*
> +	 * Set only while iavf_handle_hw_reset()
> +	 * is processing a PF-initiated reset
> +	 * (vf_initiated_reset =3D=3D false).
> +	 */

I don't think a comment is warranted here, the variable name is
self-explanatory.

> +	bool pf_reset_in_progress;
> +
>  	uint32_t ptp_caps;
>  	rte_spinlock_t phc_time_aq_lock;
>  };
> diff --git a/drivers/net/intel/iavf/iavf_ethdev.c
> b/drivers/net/intel/iavf/iavf_ethdev.c
> index a8031e23a5..2b6f4daa99 100644
> --- a/drivers/net/intel/iavf/iavf_ethdev.c
> +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> @@ -3166,23 +3166,27 @@ iavf_dev_close(struct rte_eth_dev *dev)
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

Regarding the comment above, here we're not skipping RESET_VF rather
preventing sending virtchnl messages to the adminq during the PF-initiated
reset. I suggest rewording the comment to reflect that.

> +	if (!vf->pf_reset_in_progress) {
>=20
> -		vf->max_rss_qregion =3D IAVF_MAX_NUM_QUEUES_DFLT;
> -	}
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
