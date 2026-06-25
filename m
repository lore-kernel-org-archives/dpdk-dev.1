Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD947CDB466
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 03:45:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7902E402F0;
	Thu, 25 Jun 2026 05:45:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id C2530402A3
 for <dev@dpdk.org>; Thu, 25 Jun 2026 05:45:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782359148; x=1813895148;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=QaFkSj32gmVWeAe/IIxuHICM99d4WkJd3l0WqVBRLVA=;
 b=mRI7izGGWeu31sFcCjHhCjurUFi0avUEQGEFQlVU+yBNLcCEKgc6wXw/
 7ZzW5gbgd0K5xfQlB1UBsC5gAHhYMMhDH+WBufT1VF34zgLc+75jWigmw
 M/UVzou4xXMIlsNpm1XGBUrapWRJTGWh2MMk469tRgYcHILaMcBdDbabY
 Gx8BEhMP46fub5vvmU9Ar9haktI86lZI0AhHFlI4siqMKnV5Asoa/Ss3J
 RVMnHXtbJCWzgIhjQN8Gc6+G8D7HVpJSE9bSkG2TRUO+d8ZqCo7kzmqBX
 fLi2mSKUfx1g55HMAHxWHOvilD9UE2kL/PzlHhilkfBJWxJXLNoeHpQNa g==;
X-CSE-ConnectionGUID: eT0SOGrSRd2KIwDZCPv7rg==
X-CSE-MsgGUID: O/EQ0zkmRTigayRRpgIPrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="94525940"
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; d="scan'208";a="94525940"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 20:45:46 -0700
X-CSE-ConnectionGUID: LkRQ6wTOSSulcPe2hOUNIg==
X-CSE-MsgGUID: LnRu5jQVQ++TyamWIHJ45g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; d="scan'208";a="243887972"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 20:45:46 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 24 Jun 2026 20:45:45 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 24 Jun 2026 20:45:45 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.55) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 24 Jun 2026 20:45:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q7CCREISNLNS9mKRunMdQMz9/U18LFKk9bB6zUqnAZnoZa/w0HuooCgHuQdA7wHDo/QAYQqUI/2En5muSrPxGoRyeHoXEk65NUcHo9Vy29K47/tWUFIb3DCcC25UQBmwKzLtC71TBVLdAQ2sk+xu3MqtzUx+4ucDFtXlWj/BhEWH5ueg3FmHNVofNZt7IBwOE0W7C76LYb69qmfSFhw81o6uUNpNlNr238uqm/TYvbQHCn/gpypuO0QyMyZQBTSUBwvddC64JfOb5hfm4C3puhCscQZX2hDtkZsERJ+EuIp37rx9dWAqVJCx8hEKGbkYhFS8wpvjMpdPoNDQ9aWJ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBPzUwE86SfWZ3cugugEXzGrsn/U1IZ5AqTfSvIMG3c=;
 b=yRkxRYZR4JByrkZPt4vVjK9adZl32efK9sO7uXkXjHNV0Fowkxysqu3A9dhrZq1KylUi2W4lxHZkYu6CMR5X61ewW9iXd4BZpNByMcDPIZreTwjqSLkuK1MghjOTxC/GT/rL2nT0YO7OSKcnZ8XkHKjNHTclD+D7xJl7qz2AFges5X9dpmbg4dfEMpWcUhvJeWJLVRqq+dVd6BrbkL7DVgU7zsADKNO5N/H4tFA6nq7PlO2MV+wRHdhpnw4g1S2+bRtSSH3dbQhMHT2NQXETNkKXYeaQsnjQDKdsTEhbg7gAQlZsNNp8m3eE+UWqwVoUyLwcpP6v5L7zk998/P6AXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB8336.namprd11.prod.outlook.com (2603:10b6:208:490::22)
 by DM4PR11MB6285.namprd11.prod.outlook.com (2603:10b6:8:a8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Thu, 25 Jun
 2026 03:45:42 +0000
Received: from IA0PR11MB8336.namprd11.prod.outlook.com
 ([fe80::7cba:57f1:37d7:723c]) by IA0PR11MB8336.namprd11.prod.outlook.com
 ([fe80::7cba:57f1:37d7:723c%3]) with mapi id 15.21.0159.012; Thu, 25 Jun 2026
 03:45:42 +0000
From: "Jiang, YuX" <yux.jiang@intel.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>, David Marchand
 <david.marchand@redhat.com>, "Richardson, Bruce"
 <bruce.richardson@intel.com>, Thomas Monjalon <thomas@monjalon.net>, "Andrew
 Rybchenko" <andrew.rybchenko@oktetlabs.ru>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v2 0/4] add versioned symbols for recently stabilized APIs
Thread-Topic: [PATCH v2 0/4] add versioned symbols for recently stabilized APIs
Thread-Index: AQHdA9uMkpABuROCOUu1h92JGGVo8LZOoU1g
Date: Thu, 25 Jun 2026 03:45:42 +0000
Message-ID: <IA0PR11MB8336F5BC052A8D527F1B1C66FEEC2@IA0PR11MB8336.namprd11.prod.outlook.com>
References: <20260623113752.1100072-1-dsosnowski@nvidia.com>
 <20260624131337.1127323-1-dsosnowski@nvidia.com>
In-Reply-To: <20260624131337.1127323-1-dsosnowski@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB8336:EE_|DM4PR11MB6285:EE_
x-ms-office365-filtering-correlation-id: 7128307c-3f73-4873-4751-08ded26c3b4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|23010399003|366016|38070700021|22082099003|11063799006|18002099003|56012099006|6133799003|4143699003|921020;
x-microsoft-antispam-message-info: VweBZIccJqvV26HYu84uTcRMmeqRKOZt7vb60h4QErwC640fPQocJklCDrmomt1vKoiIclT1OLSgkQO4WO5V6WPEv6ZypCq9nfPh7Lubr69aO5VzrngIZ8nlQwa2G8cRcIjvh/d9u4hSlQWVY7Bgz46swlqnMflm4XL7QJ8hgH6FzLiaXNojZYD1iSKmGMZoglVxXfpNK0nPuMvU1ukcKP9+X/NlCf9dEFUfAgIL4lIOGQ4upZCVc/4QCEq7mLOohJoEVz386Orph6QA//NJuMmwtoa6bSwKfFvu1ZHpZupLTHK6b6BaPpnwGSc0qvxITVb9D3ovFCIUcUPcA6wfa6oCU8cTzL99DbIJJkESGE2t1fuwmGHmCvDFlc1h/nKB3j1nYvCmZHrZ4PIsRU28HXr2athbnXfIVu4Dc1bKubG9jtNZZvO//2bWQG21Pju8PcqTXxLMz5fRQkH5cLK/cuuyGocwr8eb0I8qzekVmk4nOPBO9iAPhaPJWrR6EH22te1SyIrhbd3SGDFpT53lPpgIS6vYp4pb6XZRP8A5hfEXPX1az5Ue1vemkN1ceQTBho1EQWBqZ9mD+uQXBBaHvW/zVat+B2zEIiFRYB9z8rbwNA7HfkO6arIYhIokYd9uHFfuv5LFdisHeS2FhejkSg91HXaZJZpBQ94UQFocUEbF9RJWaHh7REwwKCja+91lIdNRDySqc3j6ZS7uTSSCy4deM/J5h8TbJ/aULL6nXDVnZ0t14VWsDxgl2O1emZxU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB8336.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(23010399003)(366016)(38070700021)(22082099003)(11063799006)(18002099003)(56012099006)(6133799003)(4143699003)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Y4ydC/mpVuoKIbH8PH1qtdocK63TvoV0h5HYEswIbdRh0GjcyWCvrlytTRm3?=
 =?us-ascii?Q?5hvpw+DX2XycwtBe+U+tX97Eof0kSkrl9Q4zUdCDZd1cGneE3EK8SDzsHmbr?=
 =?us-ascii?Q?JiUhytmiAJrz1nOlRK/+ejZsqBJZYKpTVO+GRp/IW2V3eVUCIEKrzJnd8xxd?=
 =?us-ascii?Q?Dm/QiuKhvnTcp6ycmp5dbM5moSwfWY2mavPOwT7HmqRM1b1ENSMPsEfsIgfc?=
 =?us-ascii?Q?5ovkpMTTy/Jq3ZYJ9cRxJy3dFk7JGHBaf1vdyeX5r5afGrJmkjy/3aK96vQl?=
 =?us-ascii?Q?UzAdfSvCbrx1ZEICp1R8ECNfoa+JyUFVK48jHxzd7OldH9vaB3PyIxU89ODZ?=
 =?us-ascii?Q?CMhddATEwb3S/QK1viplcxxJzImsWDUbLIC66k07QBUw9vtvdOGmQxr9+60Y?=
 =?us-ascii?Q?7cCaiBifNXSclJIOB18jUeNur+CQnzEbJl97fGbJutUj25M0ygkPDyUWMbbH?=
 =?us-ascii?Q?Y6UiQJIp/Bb0zdhICXwOXZxUvDdKM1GanUVfTSGhpGd67g/RZspornqjT1Li?=
 =?us-ascii?Q?9VntAMjSNdW6WKVFJ+xHchWLFxiOwRhkQlsDHuIJp+B0l+1xMKuKdRbaj6+2?=
 =?us-ascii?Q?qqqbXHZRMM4oa8Qosf3+nJgQSjsdWyK1MbLdDZ/iK/mPtsFCs0sc9mi4ftke?=
 =?us-ascii?Q?s9sgm+0O/N0HdtTNRpFMcKXvsyAi1if1hBOhYznDlbCYk+o4GSeW6jc+Rkre?=
 =?us-ascii?Q?+IaLcx3rORaGoGQo9DtZgYscFOMO36+bdXdRd/gLfBqFzmvX/7cwL2UCk4aA?=
 =?us-ascii?Q?BHrtz3Z2brvzw6aasdpYVxbXFZlPLwbSZNe+i7QBYC0DmE+yBKgu1ZbOwvc4?=
 =?us-ascii?Q?EXCgM/IqgMD9Pfg8OpQ+Q4mvlQ8Dao263GyP48Ros3AqgNbd+9akwe5SvzFV?=
 =?us-ascii?Q?ErCEiVfOQ5h7Utcd1BSxDFdEJ3VPDGyVAtvzty1T+6bkflUH/hdqVoSsRZ/X?=
 =?us-ascii?Q?p0SKbaRySO9OxGJOb7pZZ8+DSsyuB6It+WwTnlSNwSGvgaK0sthlkVEpF9Gs?=
 =?us-ascii?Q?K5yWfdbZ0qS1jnRQUy9QnC3kTBMClB7zt+ngTvyqNYa5Fifrglns3gMQOLMH?=
 =?us-ascii?Q?Dfaqk7c9WTiBUJPtgBLpJplRYGe78073Yycn+4lxOZ/VWeTYfoUX5G9tHzhS?=
 =?us-ascii?Q?ti9gztDVjusD6Ki+/no0ANxo8gO5B5+8GdldTfyQuZ9CaEyQtnHidfbMArNs?=
 =?us-ascii?Q?vSLuCmZ/zRG+u/TMUsSMrMByvBJRzu5G4qga3zB3/6lScObR0hc6Uhu/bXpz?=
 =?us-ascii?Q?QNL/MOgAABxBKMjAn1bDAuqwWsha66d9kbf7Np3wbhd8Baw2l1m6pGAV9PWh?=
 =?us-ascii?Q?rvv7ZpZi6vduwg/if+Xls+W/yR/9rUl1Jp0rxDUFXt91IWEro06JtlEXhUAn?=
 =?us-ascii?Q?hhsYnfFqXtzahlmFVKhoHhjS8RJxXIW7iF6CYXbYYxohbkEN6fd2z4xy0bPX?=
 =?us-ascii?Q?biveng5ZErszFp1dnSR3F8rEphenuNhYT0k1m8Z4ezU/CIu/Gx7HdnChkHQl?=
 =?us-ascii?Q?kpn66TJMA0O3WEpWhFx9AMfmXp+k6sfbFFYfsXwJJLobVzw1NJ6khJa083sQ?=
 =?us-ascii?Q?IU5TlakPSW8UHMNFp/O2bvJBMrbXUKsKdBRYHw6I6EeXrRrVCwA90L+ZetpX?=
 =?us-ascii?Q?PayZOzo6gJOhjk0jipzGmxeRCxN/l7obrZqXlpoVThGmWiFqBaYftvtH7ANt?=
 =?us-ascii?Q?wk7PolEX04twjDTX8mDVD2D9CpHtWcrLCSqZkyuqsHvF43Fn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Uedc4JdOsr3GIdWj4gU0k0E1CCJdEkyEqQ001d5aYWmMNwbNCVdHbnp9Yvfr/IgEGtPPhbO3UvvOWs6g5NQQZu7uzTtQNyqFDrSwyQsb0o3O+AjUy9MTZdrc8BxgGGjIGP5KpBnrfPrvbwGG1F3fwA0iEm1GksMuf4z2bnYXB9u+EMaf0GdJv86kGvYIvICtnMWhgk9Wu0wMNK53e1oALy88vixRJkOLUu96CBMzg9RCCjHXNk3aPmXWnewVq3EyyrQm5TH1rk9SshA7kRWmKzcipnzH3t7hzOUy8HDHeO/6o5qh6iQmdg//hIilpy9h+pwR07O4a8StSBALA6im2g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8336.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7128307c-3f73-4873-4751-08ded26c3b4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2026 03:45:42.6204 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xFHdf1JJe6ws97Xy5Onv9hqUQ+EY/JGELO8PZrdsPcTasQeeX254b4S5pPr9x8eEcnf1lGt/zqX97+DLSVgm4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6285
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

> -----Original Message-----
> From: Dariusz Sosnowski <dsosnowski@nvidia.com>
> Sent: Wednesday, June 24, 2026 9:14 PM
> To: David Marchand <david.marchand@redhat.com>; Richardson, Bruce
> <bruce.richardson@intel.com>; Thomas Monjalon <thomas@monjalon.net>;
> Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>; Viacheslav Ovsiienko
> <viacheslavo@nvidia.com>; Bing Zhao <bingz@nvidia.com>; Ori Kam
> <orika@nvidia.com>; Suanming Mou <suanmingm@nvidia.com>; Matan Azrad
> <matan@nvidia.com>
> Cc: dev@dpdk.org; Jiang, YuX <yux.jiang@intel.com>
> Subject: [PATCH v2 0/4] add versioned symbols for recently stabilized API=
s
>=20
> Main goal of this patchset is to address
> https://bugs.dpdk.org/show_bug.cgi?id=3D1957
> but it also handles other recently stabilized symbols and has some minor =
fixes:
>=20
> - Patch 1 - Fix RTE_VERSION_EXPERIMENTAL_SYMBOL macro on clang.
> - Patch 2 - Allow function versioning inside drivers.
> - Patch 3 - Version the function symbols stabilized in
>=20
> https://git.dpdk.org/dpdk/commit/?id=3De8cab133645f5466ef75e511629add43b6=
8a502
> 7
> - Patch 4 - Version the rte_flow_dynf_metadata_register() function stabil=
ized in
>   https://git.dpdk.org/dpdk/commit/?id=3D4ee2f5c1cedf9ee7f39afa667f71b07f=
4004ba5c
>   Restore EXPERIMENTAL version on global variable symbols
>   rte_flow_dynf_metadata_offs and rte_flow_dynf_metadata_mask.
>=20
> v2:
> - Drop patches introducing versioning macros for symbol aliases
>   and their usage (patch 4 and 5 from v1)
> - EXPERIMENTAL version on global variable symbols
>   rte_flow_dynf_metadata_offs and rte_flow_dynf_metadata_mask,
>   as discussed under v1.
> - Change commit title prefix in patch (2) from "drivers" to "build".
>=20
> v1: https://inbox.dpdk.org/dev/20260623113752.1100072-1-
> dsosnowski@nvidia.com/
>=20
> Dariusz Sosnowski (4):
>   eal: fix macro for versioned experimental symbol
>   build: support function versioning for drivers
>   net/mlx5: fix stabilized function versions
>   ethdev: fix promoted flow metadata symbols
>=20
>  drivers/meson.build                  |  8 ++++++++
>  drivers/net/mlx5/meson.build         |  2 ++
>  drivers/net/mlx5/mlx5_driver_event.c | 22 ++++++++++++++++------
>  drivers/net/mlx5/mlx5_flow.c         | 18 ++++++++++++------
>  lib/eal/common/eal_export.h          |  2 +-
>  lib/ethdev/meson.build               |  2 ++
>  lib/ethdev/rte_flow.c                | 13 ++++++++-----
>  7 files changed, 49 insertions(+), 18 deletions(-)
>=20
> --
> 2.47.3

Tested-by: Yu Jiang <yux.jiang@intel.com>

BRs
Yu Jiang

