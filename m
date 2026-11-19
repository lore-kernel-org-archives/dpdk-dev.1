Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6000E606A320
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Nov 2026 11:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XI7QhZuC;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=OorTEmfw
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC4BB402D6;
	Thu, 19 Nov 2026 12:08:52 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTPS id 3895C400D7;
 Thu, 19 Nov 2026 12:08:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795086532; x=1826622532;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=UJlAl7n3P4uvZzz/erVonEof8jK0TC0Nbos9JAD7Dlo=;
 b=XI7QhZuChVyUcJC/EdtNoxFSXSt5YvzcWGsRrC27Q62Wi8X/ZlqX3zzO
 ZRMj8wmNRpVe17CA6mJQyC8FUQ7JrhsOfm6McL22JYOmd2Wn4GInN0VcE
 pOtHzOdpTdeWN1G+F9vZGNIOOKOR4S51M+1zCIk8bxPyme0tdbyux8Erw
 1ydBVlVUNqnZEm3OnrAKiVklKWD45qQcEaHd5iGAQnrCjkchcF1Q7HrPm
 aE/7w4CdysYH62qjnH7KPjLdIrif4ZevY7PcJpwNaM4Yy6FBa7C8Ma1Ql
 iAO94n+m6wRHaHngw2LPzIN2+Km7FL3tW4LmknlfL3cYIzYlmVn+fwgk2 Q==;
X-CSE-ConnectionGUID: Pkw/Ct6ySX+c4XTNFBwBoQ==
X-CSE-MsgGUID: /Kqv/toHSpGTDTcaoAJTiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3819765"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3819765"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 03:08:49 -0800
X-CSE-ConnectionGUID: 9LIldCthROCEoWN0emM42g==
X-CSE-MsgGUID: /rmzgsgGRrWmklrwIFWNZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; d="scan'208";a="12150185"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 03:08:48 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 03:08:48 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 19 Nov 2026 03:08:48 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.66) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 03:08:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CqYv8iDL5qmj431GrpuQgxv/o2n6TIhk7VfKCcTpjD15Hu6ei9LjG6z5RWq6kzYQbAlY56lB9nnn30SDtyHov0GI0s/0z7ilkOVQi2fcnGvDAX64Hwjb7F1wsnOcW0EeTCwoEUT7+4WBzIrXyLYKrNGdkgHxD7e/9k/6ByLqAV9tQDB94nC4zKdD2AcqTMS4lQYHr2u9nXGJGTjZFut7j7aft/hhG5ZppZ6ajNJCnyeqDSKWG/ZdZhdeyNKgT/CnhP6gmC37sQ+jgeEaGUhylyEM+cc/uBIu3CjNjEIRayXoEsp0am9/hQXE5GcKM1bA4EwXrOuTZpy7vKba7DaHkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZM4rNZU2NcsKschU9zLg8mD2O+oj5souHNuH5K0fNQ=;
 b=HPhHWuKznnYZR3+elUz0XhBZX2Ka7NQTsz6ug2eP8Aq5g94o2zJzpiX24tdlcrAywe7qVZWjWg26/BbkQqHRmnLI75PbFJLxumFARJadWy5a7yUNmva++3w1hQfkHuQc3GmvDxrv4/rO7BHaY4+o5AzUdFHLWFJpCU50iaqiV9VrvlxRM7Ir++A5bUg4GzVnmYOr72a9CnbYs02WWYaVbaOgR80p64nJX3vg3uMpnIa7Ic/jNmyB9uk1hlX0hyUT9fRsFJEpqVYm7dv1x37Cly1QHneLq1pH+dWQ9IJ3GpsLUSYZjneUX309i9bjWxLvlzB6sb5uzcc8R2yYxGqFAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZM4rNZU2NcsKschU9zLg8mD2O+oj5souHNuH5K0fNQ=;
 b=OorTEmfwAAyXWIwTOIGzsK/Pzj8pp+PTKcDZ9qK9fOZIPXGTTZPK22KoxcWIYfPwMf/gq/rZ0Q+9YPeQUJ0ryLOEP18MUzw7qna10XSfFJ2eHhbnWSbaaSWwqGT5JvY3N25hvb1c+5wVoq/3QEP+bM8e50423CDr9rfU5kWECA8=
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by DSWPR11MB9847.namprd11.prod.outlook.com (2603:10b6:8:4e2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 11:08:40 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0615.009; Thu, 19 Nov 2026
 11:08:39 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "stable@dpdk.org"
 <stable@dpdk.org>
Subject: RE: [PATCH] net/ice: fix silent drop of MAC addrs in ACL rules
Thread-Topic: [PATCH] net/ice: fix silent drop of MAC addrs in ACL rules
Thread-Index: AQHdd1QUJdev8Ncf3kSTd0o/pI//a7c1PHYg
Date: Thu, 19 Nov 2026 11:08:39 +0000
Message-ID: <IA4PR11MB92787FCB7016C8CB60DF4CB58E792@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20261118115724.2708792-1-bruce.richardson@intel.com>
In-Reply-To: <20261118115724.2708792-1-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|DSWPR11MB9847:EE_
x-ms-office365-filtering-correlation-id: e62cd7f1-c460-460a-35fe-08df462d7745
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|38070700021|10067099003|56012099006|5023799004|11063799006|261021121427099003|261021135927099003|261021133027099003|261021130227099003|261021123027099003|261009223027099003|261102123227099003|261022075727099003|261022105027099003|261022113327099003|261026130827099003|261026140227099003|261022115727099003|261028144727099003|261026135527099003|261026121527099003|18002099003|22082099003;
x-microsoft-antispam-message-info: qbO0MMbc+CxNwP5RyN5koA8+nuO3hfFc0cH6ywZCoogB3dlmCJ5P6dLDrfbiNk0DEzE0eqsaXaUfA6Ag5sKrgI86YVQ6t+m5SUNlcNBuoTP84ju6pM93mMrAoFTdpSFPqYqJSAw69etTsAmk8FeF8KTZkZyOV4zkMo4uHj5qQK1fQVNqkLndlPbzwOfMw2g+mX6F1RruTx7vJPqBYyyShwF560N6Mp9QT0DxmMrxCBoCNMbGz9/Bf3X7neCxagJX3EkfngJAWLJi6b8OKpFXCaxhdoiyAcDhbw3vnhYqfdvYBXR1Djc9y4bOYgXQB2LcpljzUnGPj34ZocFKcaEocMClUgWJw8ovvasmi8d9no+v6Vt76szapSPiFFFOirl84d0JxaDvZgCF/bnnkCjTrnjUv265A7qsTtlOe40ImM4TXJiGkG4pwUmnCcpqSMOYAil51SR1JfwrNsh2QoeeXXovEefwEPV8FPAAODsR+CtjfITP2Ew5/1UGtLmX+TyxH52jpWc/toMFCgXhcT1vAlcWFrHP/yqM1d1JGXvALzJiRKRmuqOgwyQw+0gZrLLENAr5Unwz3iUBt+YGrsxaO6ONVIhJsyphlB+xNqup9Zsvijv0s9wEqXruyljueUlPUA7BJ036R1/rKjp7XVlsQpkPM7JOzPE7Ki2Xhv6MdiVosIsbkMRSxO5hw2CpU/wIRwLO/2tc5YWw3iUYW95z5OG3GEQQpkzdwLcccQXSgRo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(10067099003)(56012099006)(5023799004)(11063799006)(261021121427099003)(261021135927099003)(261021133027099003)(261021130227099003)(261021123027099003)(261009223027099003)(261102123227099003)(261022075727099003)(261022105027099003)(261022113327099003)(261026130827099003)(261026140227099003)(261022115727099003)(261028144727099003)(261026135527099003)(261026121527099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iVfblYJ3YDe3NnRldWFKvZhjh8QvZSdUnI/Xiy07+807ARlaoESnpzLpOpr2?=
 =?us-ascii?Q?gmVo1SDAXL58XiHEj8ARsnbnF1c2MOFLryzKKwxjovxZmREInH3ukH6O2R8f?=
 =?us-ascii?Q?N+DJnmLCWxDHRkwfB7b666tT5tp2tZnLk5Sf7CZtzZn9Rw4Jh/skew2DzP+m?=
 =?us-ascii?Q?Y6E45N6nucHbWjtQ9LWPZYUmCKF30CpQaJ5bEkCjqzSMZKvSwyDMpLHA3+Vh?=
 =?us-ascii?Q?zC1oohIjl9Fj7lajXXan4xjINJtIGy2+poqhtbf9PZPR4ZWJ7ONO/DFa+tsv?=
 =?us-ascii?Q?j13bQ5Z/lWQhbaXeYrDIf5ZTPo0fSJM5A2sjx5XeiFCI4rSDHlupD4repwXh?=
 =?us-ascii?Q?DqX7VZkIdOdQ3KY1Zj+esd+19aZ/0U1XSL7hUrkw1e67q8YQFZudpPKn9mNz?=
 =?us-ascii?Q?dHbDMPekr9XYvEmBFoB5L5XWAYLeqsTllpTGv+dpemUmTYwG9MV+T2KsOA3o?=
 =?us-ascii?Q?Ty47nn5HADwsqWXeLa3A7X9qFQuaZWjlwo8pPqE8cSHnB7a+QT5LZ4qb2ahl?=
 =?us-ascii?Q?pngheWAgHpqlEx3Mc2lNkgGdiv6IxwOFR9nCMAwv4rGMCQ6kcOhvlHrGCTDs?=
 =?us-ascii?Q?2USGBJCu/EEmGzY/GpVUsguYabl7/Q7wmiftQ8ZoaOCnbmzNpFtVdCXrJFVd?=
 =?us-ascii?Q?8nQ22vMs0ie014x/Ebmt5F+EHxVijK8/f4/p8leL65MySKIZ5DZDrHKDrLQ7?=
 =?us-ascii?Q?VZ6DIuXSYfoX/C82Gxbir2kVbO0IJwsMrG18In01OzddA36M4PmxsJCmGZ36?=
 =?us-ascii?Q?GRbJUzuW0cEkYoz8/0D6pB987pvxhLenyXJYOYso86fvFk9JAe9GprNoHQ6S?=
 =?us-ascii?Q?xzyFSHv/aciIFPLPh8bDOhOgR3TX3EDNMuqNnPUN9PcGikcpgmeOP9xAyR2q?=
 =?us-ascii?Q?m9Rwc/kpQoCqxboFLs0GVqbNMyhp2jMevSA3xcEmdABfj7A1V0M8G6KWdE4K?=
 =?us-ascii?Q?IqlUeiPEzaQoqzJZCPOYLqn38PDt8Zjv6r4eHq240n8JLYwB8kvqeoRwX2Hp?=
 =?us-ascii?Q?ODvP65lhkDWQ8woTAk2kgrvmpFKFilWAB4Y7+z+1ZCK3J3t+Mzh/FwukBWi8?=
 =?us-ascii?Q?JUK382XmWrhPV6qPkMxo/RRxufbcfuzjGsPYyv8E1xtSiJ3ppgz/RCkCXuMD?=
 =?us-ascii?Q?u9udY3Vm+bJ/VB/4Mwu2l/Bt+51LcNxIMacpy/4rgY/YlP7Bd/8ZtzVmcpYQ?=
 =?us-ascii?Q?M96X7rdiSyzfXIOlvWsRodO7+MEFcG2OfxpG245ZQOCKmGJAQlbOYG/4TDTF?=
 =?us-ascii?Q?YI8LEPsVI7AHHHvKeMwLXL8CV4yiVQoW8M2ugqrZOkSnMATDERPjLLZWMuhK?=
 =?us-ascii?Q?SM+TRhIh0LATkZGKUGMZIAtuOwoRk8nmcatwGur1oXZGqhSlHGbJoybwjNTr?=
 =?us-ascii?Q?rW4EzxyiFFA7Pz48T5fX11x10Yh21ve+HYeS8YuaiiGyphkrSbWVqoD+DnTj?=
 =?us-ascii?Q?+hlx3GV/vJOAO+crvzvqwI6HwG292rNDrn9pG/gS9WlWuge1NzWfgwEapdVS?=
 =?us-ascii?Q?i2WON62CPQvBb9THhPNDZUoJ1QbJOSUGcOBo3VLSXHP10NkPihnevia2V/yX?=
 =?us-ascii?Q?o0PqzOhpWp5tssVNhhauOi1cixCVVgV2GmyLnnv+2PX+gKfLxWgWUd+MuaUN?=
 =?us-ascii?Q?FXGAoUS1uO5vtHJmZB2qUDXExomQSH0REx0PUMoVHOaY/nZUTGJDzJu8xRQI?=
 =?us-ascii?Q?i2ViaEozm9FLO/KdG/crUZFvD3AoJpGyHgjl4Ka2WBqpw7lddZpYuRpqw42w?=
 =?us-ascii?Q?yV7If9pjaw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: seXkD8G7YaY+3VaSBJRM/m+h2PQYuwnnpv6fF6G3YoDYb11fL/2+BVBa54OQdloVIbvEWi/5/LbFNviV3WjRIS33XD1+ZH82FlVVH4yM1BUvrx/JZn16GCTenIbrmY5RnyYBi8fefTv/B36/cqjJ41ANea8Fn7AlkviACx7r4DtGR/zkcotyn67ZiKjFIb9obZolzWXF/n3ZyL33LHtFCyF85xAorTmIg57KEcnr2WP6g1VL5ozbnSx8/tA0phzYI8nfLoN/x1EdpeWxIAhKlvOx6RGQ43XU1RQCgMM4ugdNO5lZqYZ3bG66vJlJaa1A2TJPwQyA+yXrfI0GESx6GA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e62cd7f1-c460-460a-35fe-08df462d7745
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2026 11:08:39.8080 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: abYdDzrTU07k9IcbGXVbFoN6VSHG6UoHfvlZzlGP5UVDohpK2K4umO8C2WhNLHNzU+rqDF74s71gZHEKrmJO8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9847
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Subject: [PATCH] net/ice: fix silent drop of MAC addrs in ACL rules
>=20
> For devices with 4 or more ports, the size of the ACL rules supported is
> narrower, so MAC addresess are not handled there (see [1]). Reject such

Typo: addresses

> rules in the ACL block rather than silently accepting them with missing
> filter fields. Those rules can then be passed to other engines which may
> be able to accept and correctly implement them.
>=20
> [1]
> https://github.com/DPDK/dpdk/blob/main/drivers/net/intel/ice/ice_acl_filt=
er
> .c#L170

This line reference will be stale once that file is updated on main.
I don't think the footnote is necessary. If you want to point to something
you could point to the function name eg. "see acl_add_prof_prepare()"
If you want to keep a URL, use a SHA that will remain constant.

>=20
> Fixes: 40d466fa9f76 ("net/ice: support ACL filter in DCF")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Code LGTM.

Acked-by: Ciara Loftus <ciara.loftus@intel.com>

> ---
>  drivers/net/intel/ice/ice_acl_filter.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/net/intel/ice/ice_acl_filter.c
> b/drivers/net/intel/ice/ice_acl_filter.c
> index 0f913126de..931c5469d2 100644
> --- a/drivers/net/intel/ice/ice_acl_filter.c
> +++ b/drivers/net/intel/ice/ice_acl_filter.c
> @@ -998,6 +998,15 @@ ice_acl_parse(struct ice_adapter *ad,
>  		goto error;
>  	}
>=20
> +	/* MAC fields are only in the ACL profile with fewer than 4 PFs */
> +	if (ad->hw.dev_caps.num_funcs >=3D 4 &&
> +			(input_set & (ICE_INSET_SMAC | ICE_INSET_DMAC))
> !=3D 0) {
> +		ret =3D rte_flow_error_set(error, EINVAL,
> +				RTE_FLOW_ERROR_TYPE_ITEM_SPEC,
> pattern,
> +				"MAC address match not supported by ACL
> on this device");
> +		goto error;
> +	}
> +
>  	ret =3D ice_acl_parse_action(&parsed_actions, filter, error);
>  	if (ret)
>  		goto error;
> --
> 2.55.0

