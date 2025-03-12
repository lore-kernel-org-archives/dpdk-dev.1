Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1FFC28B28
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 14:06:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B971402CE;
	Wed, 12 Mar 2025 15:06:49 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id A612040265
 for <dev@dpdk.org>; Wed, 12 Mar 2025 15:06:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741788407; x=1773324407;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=rRUDi3CQ9UZtien0D+NoEaBfpda6FlY79emSz4oBM2c=;
 b=jZZssue0CGsQwwjlvB9qJXNipJJPRDIinigICPFDtnYfT9brogUtoeDl
 t6nDs94KyKR6U7zH9jaATvtaGQeQqwqjexuKb9csaE/iMz5zFEsxEVe2h
 l3fjuKZiFRMmxmOd0kP2Lgo5he1ab8SoQCGra00SU4pvC9WT2Y/Dn+eXt
 4Zm8v/Ih47oOobM3IxjVdOuK6Jmc51wptlTV2MVl2sKa6JWZeWogT6r+m
 PFsgLUH5/u0aunxZ2Lyyes3ZdpRGS01OjEVuTgv8iP4+8ROI+47cOgZxm
 jErS2VxlN3DBBqbY3lmYXwKjRPB9Z6JQxTlKrkKzzP6J1oq/yGn6+fHie g==;
X-CSE-ConnectionGUID: oxQzbBwYRPyQkyHWoYVAfA==
X-CSE-MsgGUID: D8pBxJX/Qd+xw0m1VlvxYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="46516452"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; d="scan'208";a="46516452"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2025 07:06:46 -0700
X-CSE-ConnectionGUID: hVH9gkO6Ry6O+k+CnCK/dA==
X-CSE-MsgGUID: yzK1Avo/SzWnlUan2J8Pog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; d="scan'208";a="125831688"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 12 Mar 2025 07:06:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 12 Mar 2025 07:06:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Mar 2025 07:06:44 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Mar 2025 07:06:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=arunqwf4zQKeYFhNZL3o8mCXGeJPXM/M261rsHCDHLtf0P2l+1NXOCZomhKUHIcmNUdbdO5G7i7TyRlmi9clU/G1cZyCoue/Uj7NDBbMfD3FlQlgv1gdwUEv1auMz/0P3iz53QA89QayvA8RuJ6NG/h+BWNaAk5D8gnph9I7qZ1c7Q9u6PerJh0glyHOdAt3ZkscWbFKSK2jbX9WIRPw8iKadjMD+cfh8jkjXFbRmS1I0PITH9acAce4uDn6Z51UqO2k/iVGZ1KZ3IeEffrDjVtZqPF0SowYDa5XKT90TznutbygVY/fwerFlP+y3euur1jPZliTPZtTm5BoThi/Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7YY/txB9ZC7oEe17p0SAIPhCVW+qsm2DjcYltYWDCo=;
 b=YEL5lW2Ww6uGYFTNxys4lvg4Ws5A1EoybMxpCQl7eWxVCkZJgmF0TDih81ll7m+ZnGZhjJP3rcLI5XwiDq19PK/cJy5YToskeosYCgTzw27XaFy8KkLTgxa7gGAga8K1LLLhoHaJ6CgPh6D3dRfPeMmeQOTn9w26wKjc7YVch6vI8mNuh8I1qKz/iSTGVUnNh6FyyBulqW0oMrjgmpVuG5tGWp3sk6eGo4Sk7RqGXBEvQLqXdQlmSRH989TeKOIdsIzmPVurwh3H+5GXCqkA9wmz4Uc13b+AbCgXcUCfHEbW5vZMVZesYmwLvj8NKp9SueybTz3Vf3W+Y2fiDvbWaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB7757.namprd11.prod.outlook.com (2603:10b6:8:103::22)
 by DM4PR11MB6216.namprd11.prod.outlook.com (2603:10b6:8:a8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.28; Wed, 12 Mar 2025 14:06:42 +0000
Received: from DM4PR11MB7757.namprd11.prod.outlook.com
 ([fe80::60c9:10e5:60f0:13a1]) by DM4PR11MB7757.namprd11.prod.outlook.com
 ([fe80::60c9:10e5:60f0:13a1%3]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 14:06:42 +0000
From: "Xu, Rosen" <rosen.xu@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH 1/4] raw/ifpga: remove unnecessary deref of function
 pointers
Thread-Topic: [PATCH 1/4] raw/ifpga: remove unnecessary deref of function
 pointers
Thread-Index: AQHbkp26lLVURrAhCE+f8Iql/czvrrNviqtg
Date: Wed, 12 Mar 2025 14:06:42 +0000
Message-ID: <DM4PR11MB7757953C09CF5CC65B0ABFCF89D02@DM4PR11MB7757.namprd11.prod.outlook.com>
References: <20250311155300.13410-1-stephen@networkplumber.org>
 <20250311155300.13410-2-stephen@networkplumber.org>
In-Reply-To: <20250311155300.13410-2-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB7757:EE_|DM4PR11MB6216:EE_
x-ms-office365-filtering-correlation-id: 09c69e7e-b8c9-4326-1110-08dd616f1db4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?lPumsZ9fFq4YW7DQDwjWnfhmVT0ga8ZezIFg4zScOW/PrjDOVaHyfaxF/s5J?=
 =?us-ascii?Q?QN4hCMDnawwRhjrcbMHpAqJIqi/7lhCCorTbdqJjP2vi2616Q0BQ1Qtxz3mG?=
 =?us-ascii?Q?7XVz5yTaJdbxbyE5zVujYoYhnc+BHIX64UpDFE/1xwVOdHZHNFN6E2oHXU4V?=
 =?us-ascii?Q?p7BD+wMyC9cY573HFN0w0lQNM7BVREfS4l3d91xAEKJE5OMHsJYoaho1n8gA?=
 =?us-ascii?Q?z64TuqGG0/rfL5VFMnlfhiZKSApY0rFDIc5huWaUmnmXtxDqmdyf+fFR2ocp?=
 =?us-ascii?Q?kxI48dnPLVTj+gPGEmWJ0s2zH3TrQZLAuLdriQkxW9LSzNWH38zltZ0/jdO0?=
 =?us-ascii?Q?+Gx/4UnReJeqnYNGHCiHrUEpRO/9DzRNepHgZpfrsRmUiW9mjVTnJhKP+N8J?=
 =?us-ascii?Q?Mvtx3w9FS8i8IMvysg36rpu2IqmqwpbueESNVT1f6i26ub/ZlOaFCP/qq4+r?=
 =?us-ascii?Q?s1+9wrNJPQmx5zgV/H61Res1XMZFt6E//uUzLGQ3bGFetdlP2FW1ZnQrXXds?=
 =?us-ascii?Q?hHz8GTeK79K5U2eG7Sd4msauJHNQ1l3VEJmCS7s5eVkQqqyr0mFINy6mJGmY?=
 =?us-ascii?Q?baCu1EpZBwd5g0Nc+VfS1Z/Haap22l/pT8D9ZztSjz/62nNZIAVT14yjsD/5?=
 =?us-ascii?Q?ea/FaYRRJHkxTi78O3fzy/kW6ozWnwn7dJjMZJk+hdLy/cfDpmuD9YV/OY5C?=
 =?us-ascii?Q?B5U4rN8BWxBGD3WFO9KH84wAnDOIqM7ocVoWHk3t+pmEq6+HJZ/lF9MxQefO?=
 =?us-ascii?Q?/nKp0WDDiakLWA50+EoxcTFI5Gd63vHWgo5ByXsQFw+yMu0P35NdGJ8YAx+c?=
 =?us-ascii?Q?dDr7n1j4UNboNYITDQ0SyVQbS1tgtf16mZzMVgOEWzHVTXLHeEL7v1FOi8i6?=
 =?us-ascii?Q?1YIBZEcGR0t905L+aOrzUtjh6QL8vfiP6xuAYFGk+oBEPavHdMs0K3/1KogB?=
 =?us-ascii?Q?HU7XB1g9n2XslUsGRE1HJkgFjkIH+q1pGibvzpsAVSLG+UJppfJoiGJ5l7Ul?=
 =?us-ascii?Q?ulK6SGM59LGt8BL0Et+REB7NMaAyrLY1fhsJJMYpLc0sGSvGq+7An482+g2/?=
 =?us-ascii?Q?bhJc0Kk5D2eek3k0jt09qwD4MdFGfmA6cGU2QdLKds7BnYVPHv90AlhHb8Og?=
 =?us-ascii?Q?D+5O4+MCI4yKsE4R1zWJt8FSS3Ym6bGVOuLVxscDUiLHJvmn5gEMu01CBvSe?=
 =?us-ascii?Q?9ESNiJ9nje74PPYNvs06lZX3yAruOnRNKe6RqOab8XdLh0D8TahGnYu4eyUu?=
 =?us-ascii?Q?oKnBAMsvKMD/xBGneaSbbqUVug+yX8eXCvrR15p5zOklTmfbmboDCEP3/N+c?=
 =?us-ascii?Q?MM22wGTKyB1Ndw/VsfQrOAAppoU9wwPHgJGafyUPdcnbrA5YuWdcycMWm99g?=
 =?us-ascii?Q?+B9gaXoKcBu1YDL7dtU7gs2fyX8GKki8crpipWOxtXs9ggeiOkkpqPEbsSbC?=
 =?us-ascii?Q?8gljFFM1+ztV7bj/y/YRxRnnY3lxV3D/?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB7757.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ULO+57Bk00VoJO84/eZFYAOr5NdvKMrkDbKt7sXFxPL0tKn6TRHXWhiVAZiG?=
 =?us-ascii?Q?GvEWSeaBUzlfjNov9j8gMigsGPjXTkKRJ/QGtroVAS/ihPlnHHfRPKQUIA2E?=
 =?us-ascii?Q?aKYzX0Gll2+wRuCH71RNRkSTQfuROeRQsnVJAFcWk+DG6ye2xraNDMCmcpQ6?=
 =?us-ascii?Q?3/fjufVZsGiOdi4R3JUU0mANRQMBVy4N2LHwH3Cc/aqUA4Tp+6ZOGpypd9Tx?=
 =?us-ascii?Q?x9TgbmSPpyubN5VjHu+a3HHFZBlnJwnJkhOqN5+xClCzVYvpxhQx9eJKq7md?=
 =?us-ascii?Q?UjirjSWOXSnbZb4LOkvWJfhva2ZovwmZdn4C0wtzXosTY1JRK8e5v+cJX7M6?=
 =?us-ascii?Q?1ps3BNNqD8s5f3X/FiaI46sjLdhIWb/Heryojm1qB714JG0pTFI7DJ96HHmV?=
 =?us-ascii?Q?hFzWwc8NuUapOLqkMvN01lpogRuJvQXtEycfDAkUZxWXTlI+ltW6YmgfsKd3?=
 =?us-ascii?Q?pBTT3UsAtGwh6qpongfzV+x0WOMx0/Gck0fHlUUnAEoRML3YRiNd+TPbf7ht?=
 =?us-ascii?Q?58lXNqDW//232bOJj7ek/QGx45sQn9whAsKZarub19rvAMXnNuTnJgQ7n/wT?=
 =?us-ascii?Q?3FXm2nOvmbGxvsPobGX3rVP8jWwDWlBOf7sxmwh0aZJvC5E8aFyJ+pi5mLST?=
 =?us-ascii?Q?20Sbc/7JawOSqzOILJ8kq7yrmayN/r0ghqrUKr6OXsOSOv5aQ7rljH016kae?=
 =?us-ascii?Q?2kiwXSZ1LJBXjOWqXGO5u6DLEIWyVSDeU7PYukIJ7q2HVNgLnrdIg9EsLXl3?=
 =?us-ascii?Q?l127GqyZekfsNheMSY4n8PqI6Joev4qQ+x4lS8gNumdKJd4TktWNL1KbDJdA?=
 =?us-ascii?Q?+V+5CA1l+Wbv7oj0mtTpTR3IInr2fPRZ2O/22Z49k8sNWA30F7aSnd1LL2/K?=
 =?us-ascii?Q?EBkxhQSb3AudDyO4M6j+Cz63QITVgswPg+bfLOniv8LogmHwnMkNTY+D5x78?=
 =?us-ascii?Q?bmgLwnfmF+L4LAjbY09AlFQvD4YvTUXxvROnpL02uLfRbRBTB1nNYc0lqk1a?=
 =?us-ascii?Q?20o43i6Qn3vJJ3Zdww4u1QOjMVQwxTaqdV8Ar7W/isQ2UJjSHg6S5AO+hhsP?=
 =?us-ascii?Q?3s4Lwajpm5kmW45Uzr/uV27qv2xT7jckBTXSBm3IPcmF52e9jzDmk8tlnxSH?=
 =?us-ascii?Q?wjHUVNOtX3V3hDvhKoph1ZDbfP0LaD3P4k9xVi38//7bOoRrnpw0dCOyZamX?=
 =?us-ascii?Q?bylznHeqpzfkyKi1AGYFTm7yq/U6b/tFeVSa+5iVbAgbgil450X2bTq0FTSx?=
 =?us-ascii?Q?RIGj3kJ2sPDhKlqaik5+nkOOQUWw/EDwdijduDN7tIhvk/aZw67eP5C8q3PL?=
 =?us-ascii?Q?qDwiCnYE3gxZ82wE+c7LVCkAgdkaZg7SkV90o+QEyS+6r/x7Vm/wvC+AScXv?=
 =?us-ascii?Q?i4X8ReUrM8BV5Ty8ggtAnPI2fLOpY/hOKYf2gyi0xbWvV4mZobw/xLrfhuS3?=
 =?us-ascii?Q?eF1eRw9KANxowkztriMoGrhfEH361iIyMIPr4N+Krd3lxI+kzx1uKrRIO91w?=
 =?us-ascii?Q?xrOTBJRJdqkvpxOdWjVFzYZbzIAhoNOdraMLu7kg4lU6/H4871ke2JbPhLUH?=
 =?us-ascii?Q?H9nVQJXrSZXuGiR+uA0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB7757.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c69e7e-b8c9-4326-1110-08dd616f1db4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 14:06:42.3573 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nKOHPl6EQOIiRmW23vFKcDCt8ULT2Th/WgDRsD1LMsJzz+RrBsFpvEaVkc1Aer4exfDm0l+/fUnwrgOHDobMtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6216
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

Hi,

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Tuesday, March 11, 2025 11:51 PM
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; Xu, Rosen
> <rosen.xu@intel.com>
> Subject: [PATCH 1/4] raw/ifpga: remove unnecessary deref of function
> pointers
>=20
> The expression *dev->ops->start and dev->ops->start are equivalent.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/raw/ifpga/afu_pmd_core.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/raw/ifpga/afu_pmd_core.c
> b/drivers/raw/ifpga/afu_pmd_core.c
> index 3ab1f47ac1..f650b76cfe 100644
> --- a/drivers/raw/ifpga/afu_pmd_core.c
> +++ b/drivers/raw/ifpga/afu_pmd_core.c
> @@ -39,7 +39,7 @@ static int afu_rawdev_configure(const struct
> rte_rawdev *rawdev,
>  		return -ENODEV;
>=20
>  	if (dev->ops && dev->ops->config)
> -		ret =3D (*dev->ops->config)(dev, config, config_size);
> +		ret =3D dev->ops->config(dev, config, config_size);
>=20
>  	return ret;
>  }
> @@ -62,7 +62,7 @@ static int afu_rawdev_start(struct rte_rawdev *rawdev)
>  	}
>=20
>  	if (dev->ops && dev->ops->start)
> -		ret =3D (*dev->ops->start)(dev);
> +		ret =3D dev->ops->start(dev);
>=20
>  	afu_rawdev_unlock(dev);
>=20
> @@ -87,7 +87,7 @@ static void afu_rawdev_stop(struct rte_rawdev
> *rawdev)
>  	}
>=20
>  	if (dev->ops && dev->ops->stop)
> -		ret =3D (*dev->ops->stop)(dev);
> +		ret =3D dev->ops->stop(dev);
>=20
>  	afu_rawdev_unlock(dev);
>  }
> @@ -104,7 +104,7 @@ static int afu_rawdev_close(struct rte_rawdev
> *rawdev)
>  		return -ENODEV;
>=20
>  	if (dev->ops && dev->ops->close)
> -		ret =3D (*dev->ops->close)(dev);
> +		ret =3D dev->ops->close(dev);
>=20
>  	return ret;
>  }
> @@ -127,7 +127,7 @@ static int afu_rawdev_reset(struct rte_rawdev
> *rawdev)
>  	}
>=20
>  	if (dev->ops && dev->ops->reset)
> -		ret =3D (*dev->ops->reset)(dev);
> +		ret =3D dev->ops->reset(dev);
>=20
>  	afu_rawdev_unlock(dev);
>=20
> @@ -155,7 +155,7 @@ static int afu_rawdev_selftest(uint16_t dev_id)
>  	}
>=20
>  	if (dev->ops && dev->ops->test)
> -		ret =3D (*dev->ops->test)(dev);
> +		ret =3D dev->ops->test(dev);
>=20
>  	afu_rawdev_unlock(dev);
>=20
> @@ -174,7 +174,7 @@ static int afu_rawdev_dump(struct rte_rawdev
> *rawdev, FILE *f)
>  		return -ENODEV;
>=20
>  	if (dev->ops && dev->ops->dump)
> -		ret =3D (*dev->ops->dump)(dev, f);
> +		ret =3D dev->ops->dump(dev, f);
>=20
>  	return ret;
>  }
> @@ -326,7 +326,7 @@ static int afu_rawdev_create(struct rte_afu_device
> *afu_dev, int socket_id)
>  	}
>=20
>  	if (dev->ops->init) {
> -		ret =3D (*dev->ops->init)(dev);
> +		ret =3D dev->ops->init(dev);
>  		if (ret) {
>  			IFPGA_RAWDEV_PMD_ERR("Failed to init %s",
> name);
>  			goto cleanup;
> --
> 2.47.2
Acked-by: Rosen Xu <rosen.xu@intel.com>
