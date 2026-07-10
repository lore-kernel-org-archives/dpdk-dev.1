Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B738C43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 10:52:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2FFF04026A;
	Fri, 10 Jul 2026 12:52:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 35399400D5
 for <dev@dpdk.org>; Fri, 10 Jul 2026 12:52:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783680734; x=1815216734;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=K04QE5ZYaNSEmJ6JDCySXpV6bsZmvivxvkIYcsGdO5s=;
 b=QFjFWcjzQJJxoJXjZlRSufV8d4m0GkjRinrBBevtdQNZCav7cd7xZ7u0
 apV8hCNzNsg6GYF9AVMBOM5wVUPqGUMkgCiYH1Kepl2onvWoC1DT0UUHh
 5mxVoJHPZwmkTECvqiHcqNEpBkKVf2Th/O9edUfHMWKbi3xUY6Hco+Ep/
 e73SEDOyBq0P9imGPZLGoMCPrjF/O5Dg5hOpLywYProMGP5i0ObHnFpqJ
 LHy5l3EH9CjsMqB1TSCjaXmgyIqtfKHbMPDdLA9kpThbsxxgZPAxyjnLs
 l8RdUHxqfrPq5slYL3QljLOgbpVavVHewfZfscYJ1p5J6oTWLbNruPwXx w==;
X-CSE-ConnectionGUID: LxL1K8mhTjakYZ+JHsecRQ==
X-CSE-MsgGUID: 4fEMFxCYStCr19XJIK1Xdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84348957"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="84348957"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 03:52:12 -0700
X-CSE-ConnectionGUID: I9hA8X6VSGeNUtvO5kqybg==
X-CSE-MsgGUID: XUyedXCyQg+QEFxXj/A1yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="284958707"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 03:52:12 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 03:52:11 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 10 Jul 2026 03:52:11 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.5) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 03:52:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oxJdwxuLIekTFKnOrqgrMP9oMjOQfCVPGTkdUBHDktn8Fxv8KBtlYaI6UVmMEUUs9yVpEX4TdiCEXNnbPxo6RabLqu4kjNyr9FlltGLUdqWo/oPWT9evaOMQLtYiX7H5A6rRzn1VbGSk2KpExluSMNJ7g8zEICg+a/63dhBF/YSSNU89GIjgJtgrUTPpPGEjgEKMtRtr+2nIwcuwZKdBvErCBpQERtg0+i4SSp7bQqRIvj6ljQuqDY9rutvWTVwHiFCSkcmpr+yhbflVSLrYwhE5D29zCeXuB/Ack9wxkbQt+SRXtxSNEdfuINVwVhFEP40jagV2M2lT38qOe9MK8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3uE6J9pSW+u+XEX5wHKb+vIW6/ccRAtG4ZqPpQffHsI=;
 b=KbpH8zGMGnxH8K0OKMbsFRUdXgtbOTMTzHtK21ur+nPf7kxp6yXe3jzeyl6aM5fcH6VMjqoEYrMY3UZRbsDw9W1MtYDN6TK8mtNgEgxfKhEg/2NJnwiMPrkmdk3d9u895YLoRddukm8Akq8ESr65Q4YhtzRKs7gonxxYC7tTvAbdG9b4QjccstdIxA9oLlPCqK+5MgU5zHVJ8jCQW3eUxk4GC5H4xs7VCzX3fch5cqVxLO3KW90K9Wdi60j+jmR9iizMoqPeDe0sbVsGc0A5zmx2YYB7kGoKAzM+niCleG2WZ/BWEcAVU9+eBseiONFd5EDSR6GbfM++/zBnR4OxJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 10:52:08 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 10:52:08 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH v3 0/6] net/intel: fix some small memory leaks
Thread-Topic: [PATCH v3 0/6] net/intel: fix some small memory leaks
Thread-Index: AQHdEFepM7ghq5ezA0yi17ZtfSjXG7Zmk4pA
Date: Fri, 10 Jul 2026 10:52:08 +0000
Message-ID: <IA4PR11MB92780E0AC2DEECB77E23DD7A8EFD2@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20260703083335.4058936-1-bruce.richardson@intel.com>
 <20260710103403.1548864-1-bruce.richardson@intel.com>
In-Reply-To: <20260710103403.1548864-1-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|MN0PR11MB6231:EE_
x-ms-office365-filtering-correlation-id: 7fb2938c-da80-486e-a470-08dede714a05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|10070799003|23010399003|366016|1800799024|38070700021|6133799003|56012099006|11063799006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: 3lqmDjv/Er/Giq66otMnp0tJL83vsI7XCCmNh+u3rJmjC807JXnNe9i2QmlImBxVjTLIJHUPhWH6xPcyud8wAqRA4koG9rVjSyQNJ/o2EgBhlToNsq8v4zCe7ODTsFyLpeSoRnzntRrkuP/AXQjWgHR6157QakZREsJqhcdwOIFjlqv38BAs9eJLBI4UkyQm2kXJzZ0GO2yllK6m5pd8e+8B3NOwHKpFTaRHU5GOZadq6wJTiIiOXjszcgtkkCtseOEvDJyIJlF+bjgyt15g7yE85rOwK06RRUnQnn4DRD4DfKXrbFM6DjcCfpiH1oI8nsbwvpktQbcWitYzJSQPn8K3ZRcAPgwKARgSNLdceFlAXYis74xfFwGmsoZSzQQ+LcTOs1J+neZE3CRIJt58HGIaXZvLP/hUzPfUxMvjbk1RO7V+v0QWzfBOiCcPJY1+dgB+kgSocPJbNyKepiOM/YS7Qr8wsJ4ZrB8KQCEmjcfb77m4hbXh32AInDcHHijEDpZvKZBwG6h3ZlxXFJdoBXhvyEShEgmPiFh7ROwCYk58XG/5TfyDecEHjVs7Dix63o34at1H0kGssZzBEOmoOVf6lgqxOKmi16KAi2dEI22rXCNdSeSJRw0/VTal45Zqn6r+ff4j6zbcjzKl4cw+RFOHlORahHGGdz+iONsk0TylRu1UIZiRYAYM+6VKNkwwKs/IgbRp+ObqWrhDN4FAgw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(23010399003)(366016)(1800799024)(38070700021)(6133799003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?97F/9fV2SyRLd4iPjr8Fjb13iE82fMsjbdIkP/cq28hKefblTknZfpe3m1P1?=
 =?us-ascii?Q?H4o3dKP8N2GJOIEYsQHJTN6nZkkEMe2Ku5Xp4JSSDv3HE0EEm6nf4gEIqzia?=
 =?us-ascii?Q?wwf1L5ZNtZG5hLrxM9spoSVMEkAHgbqYXd7/Q00xOxg10Cn08WC6O5zadavB?=
 =?us-ascii?Q?s6M/itjS6WbqpM9MrJ2Tqm/nKyxexOapBFG73Qx+yCa170B6SMId3duoM+Sc?=
 =?us-ascii?Q?L/Fq8qhU3HOTn5s5YWtaM0Y3+feYs5c/sTSoVV5g7HL1krF3n91C296opEHY?=
 =?us-ascii?Q?onELG5XGc2NXqcz/xcqYtSW4caQZvRSY5uYsXw9JoT2xNequdP7TYyL2MnaE?=
 =?us-ascii?Q?l7Wi+goDexAEHTQLaAbemyoK11rtwlBdJdjNGhQ7inPkNEbi1S7jVHBVTxxW?=
 =?us-ascii?Q?PTM1mr7/hFt1pu3la18fTj+/+up7BM29qwC6zf5A9bihpO9UoVnpBdx0Gac8?=
 =?us-ascii?Q?6S+KohZQLExYrKeaEX7MiJ2PAeCmzzAuEqIc/H9gHZff+uHrLAgqcm2fCsj5?=
 =?us-ascii?Q?adq8H7xDdIarjpJszVYNwpl+lUlgEakq5TLzT2gknH4tZ2KWjyO5dwvXa1Zv?=
 =?us-ascii?Q?VoaawbU5MU1O0eJ/egPvkVqXtpbWoGimrbZjIPon6C+OPKyeZUoGCYYGo9I4?=
 =?us-ascii?Q?irdm4/7Bqb6hhvItrF9fbyEk0pZA0BEIgGDIwIWy4GkZtwRT3ecRW9hcVNTw?=
 =?us-ascii?Q?3ZpNw6kSlcYT4+7ZpMFno8h+D88IVgjOWzXCYgCk8/DgSC2W/1QMsd2LdoZ1?=
 =?us-ascii?Q?y8N8qcGlNqTbf54H6xFKBWO134JqA4lVv6t59193w63td6DFLvjRJ9XAvgiX?=
 =?us-ascii?Q?V/HyWmnTKQxzC5QR+0sgFdXKjrB30y+WTWH5Fp801ULlbVV+Wcol2hgCplz5?=
 =?us-ascii?Q?M2Jw7BGX9tAQxBsr7zOziAh4Q2xTcy+hpiyd9W/WOpGFGngExexKK9wgjI1T?=
 =?us-ascii?Q?QL7s2tCbxlxkPaRetwqXLPWO56LSWoHBWaP/+lXAn/J5OEsl0hlR6dNgaJ7P?=
 =?us-ascii?Q?Xrwbs9nMGKstSYtWldVKz4/dxtC31Zs4ElvCl4uy92/1AzidF6svAHdhBELn?=
 =?us-ascii?Q?aWvCIUA8y6G4iwbhpm9Z5lrAL0Q00sqPtB694fuwzpNJUBfSpmRM3SBWs8yT?=
 =?us-ascii?Q?+aD+idGoMW8kJoKMu/EqcJ9ItgbsoL+GrbXOJxuEd5Bs3ibHzNiptWeKCBX4?=
 =?us-ascii?Q?tDlaHGw4BAzmkMj5eJcGoQpAlODaj8Ukg4M31TRsj33TpnFSDFoCYqmlpyV8?=
 =?us-ascii?Q?TCY6fg+2pLvH1R4yT0u9RiVSf0uxlLbqIhexWtzK4ztD/vHIp2ra5N4D8RQ9?=
 =?us-ascii?Q?9YUw7V/ccHHHCt/xFGaJzYrS2euGqPTOxNwjTOISabZDNqTKeE2usK6W73GP?=
 =?us-ascii?Q?fgVresakwSbD03nLazEhX+fQ4qQBdvfUkzwNHMCAojEJOgYBQVRqL7zLq4GA?=
 =?us-ascii?Q?lgLQdF3OBW6XIGLfj3q02WT5+2lt14orWJze80sGQ2/HZkBDSFxVgqkHafCs?=
 =?us-ascii?Q?QihSdceUpSXdrB+0aADwQMqav0WpSwAktb6aHUXTpTsVpT5Lsw+8r9czoRzn?=
 =?us-ascii?Q?AGW6yKSl9PZLpYV0YyJUvqg3N38Z51vKMc683QTRsSikq5Ean3RrUF8VE1sJ?=
 =?us-ascii?Q?ipcAZ7A+j9ePHJsoN+O/zmqkiRGoiNo6N8DcPWdBfuLhH7Sg5f2UYLvYUypL?=
 =?us-ascii?Q?5pVl62K/ybhvBMa0QWeEM/Aldtb7bxbOF1heFX3bCwgzng9zLmXPfOLmNL2g?=
 =?us-ascii?Q?KuN+wCZAhUrycT1ez1F/Y7HyzKFzZTLVRjiEPUqfEoz+SQdCjFOfSHR4ZmPB?=
x-ms-exchange-antispam-messagedata-1: IyMKQ7d4USO5mA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EH3c84Q/S/Wwdry4koPHJSauP4+7tkV597Pr9AgsXNIh4Qv6Kt+ApwTKt1EJvWrqBu2BPC2Cs5EdLN/xpvROSx70Vm7O4aWboeXnsD4tmpc/7mKq1cvkZZBH9eKqkPrP3Zu+2LObVOdfIVJR9p+WkXyT/FvtBK9yNql3BcNWc/oiQcdVff0PSHLyyeUf/QBKmpXH6uDQF4pQRosScoc30te0gS3ZuDwccbSfUu6qQJFS9o7iJFnICGenAm/iQDry/3vmRGCfx6b8jHNwPckfPnZbqD1NN7MgUgYKgEU8BdFdthvLv0FZgf8fzKlUvonHITolS1eH17KrcJIRB+gk9g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fb2938c-da80-486e-a470-08dede714a05
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2026 10:52:08.7409 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vXKsT1wBa6FcmD6npi511nckzzpxsfGIlA0QmePrunb1ZqjP+gTDMbPN/Y/NYbOmZemEhTes3aQ96McxyzWsRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6231
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

> Subject: [PATCH v3 0/6] net/intel: fix some small memory leaks
>=20
> AI review of a patch to traffic management code identified a couple of
> small memory leaks in that function. When fixing those, I then asked AI
> to identify other similar leaks other Intel drivers, leading to this
> patchset.
>=20
> V3: update based on feedback on v2:
>     - fix log message on patch 3,
>     - add additional free on close in patch 5
> V2: expand from 2 patches to 6 to cover some more leaks
>=20
> Bruce Richardson (6):
>   net/iavf: fix local memory leaks in TM hierarchy commit
>   net/iavf: fix leak of queue to traffic class mapping data
>   net/iavf: fix memory leak on error when adding flow parser
>   net/ice: fix buffer leak in config of Tx queue TM node
>   net/iavf: fix leak of flex metadata extraction field
>   net/iavf: fix leak of IPsec crypto capabilities array
>=20
>  drivers/net/intel/iavf/iavf_ethdev.c       |  7 +++++
>  drivers/net/intel/iavf/iavf_generic_flow.c |  1 +
>  drivers/net/intel/iavf/iavf_ipsec_crypto.c |  2 ++
>  drivers/net/intel/iavf/iavf_tm.c           | 31 +++++++++++++++-------
>  drivers/net/intel/ice/ice_tm.c             |  6 +++--
>  5 files changed, 36 insertions(+), 11 deletions(-)
>=20
> --
> 2.53.0

Series-acked-by: Ciara Loftus <ciara.loftus@intel.com>

