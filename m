Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51684CD6E79
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 13:54:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3109C402BA;
	Fri,  5 Jun 2026 15:54:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id DFAEA4026A;
 Fri,  5 Jun 2026 15:54:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780667683; x=1812203683;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=pSIjT0HMUQ14IZTZ7D9kg5AkwPm/RM5TLs/tNp+/7Q8=;
 b=NMpHsmqGrujR5sdvo/Ka7r2zBsAtApNR70WIchf1sFSE9hJBUFHINnYC
 p9z0ddgn8gZVCfWjftjjEq4bbMr38Ghgde6zfOAQEwpbvzOkVdMy+Tckm
 MmHlyiegbvnVz8ruEkpevnh9pcs0vXfla0utwIUhR5T9mG8L3YzQ5Rvnu
 OSSgkEJIgRWrcpJNzXs8AtfvZRFGfeU7kLAkQhRZEEZO9zaDkjjdInrK/
 Z1gRksNviGktuRmiGOOc2euEiGXVP/qtmGJcaLKl1fbUFPyHgmyJVPD3z
 sJi0/7Jh3HDBb76uLWTWtZylow8dkez3g/B7nX+AcyLjfue4e+Dszc1uY w==;
X-CSE-ConnectionGUID: vlAVBqcVTTKBf6JmHyNErA==
X-CSE-MsgGUID: LNj4LfCyQkOAzGcX2/q82Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="80637397"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; d="scan'208";a="80637397"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2026 06:54:42 -0700
X-CSE-ConnectionGUID: W8qqC26MTz+J5Riyt+q+dA==
X-CSE-MsgGUID: EUy07QWUTia873MJutXw8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; d="scan'208";a="246679857"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2026 06:54:42 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 06:54:41 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 5 Jun 2026 06:54:41 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.40) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 06:54:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tdqZ/2B3RcCBt44N729rXxRes8vMMqzNonSRpHuorfNwIKg/FqbRlhfvvUWLBvS+wYtL+pznDy3EzpnIdQv4mVeHSjN2lG50jZj9peGNeQd7BG4p4iGuN6ZgxoHkXsPKALBOz2eXa8JeIvgTYhyeNXxkRGGhiCeoZJCUvqiAhD94jRHFD/bDkj3A4oS9F2nAIrewxd+PWhAPo3FteCffp8Mf6c6lS5ZJMlZ6qqt4iGqc+SRW9pLMD53NqSsXP2NgFiu4zzxEIqwNv8IuyEzx73r52hIPgx3guVvRrHyIPSSUb7z3i+/ct7xFw5NltKi9nL2LAAsAYez0Xz1HSPgn9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aIsAmVgqwHc34MSQJnEF7K3KZw3jP+FbRh/hIAGt+Qk=;
 b=k+OKfFWyHkqGE5y5Oo+sKwR0CEphbn42tY0UJwQAlVforZKgmVJn4lnyT/gV9+GMeri2gAovgdh7byqWJKYnPTR7UNBXz/HzOBJRGXJiWKFi4gXY94+Lp+0/MUY8pLn0i1QIKEy6gaM2cZBxrjZUOesJ/ZYiLvfXygKNR4NGD1MBZwsDRKVcU7fovjzDv6Nnjwwq28qSLbKHxj8H3CS+qvAMGHyyN/9P9TGLYCHnbRPmgP6sFXHiYfX3zJPnprBaEcDhpp62JxH+UiRyMIzBzlek67A6b05DVnDaNOPJ66qRgmCBJbcphQf59ejp1iAQwj8w0XYlnsfE50t8ANupEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF6915D992B.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::29) by DS7PR11MB6037.namprd11.prod.outlook.com
 (2603:10b6:8:74::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 13:54:39 +0000
Received: from DS4PPF6915D992B.namprd11.prod.outlook.com
 ([fe80::2ef7:faa5:9104:f49c]) by DS4PPF6915D992B.namprd11.prod.outlook.com
 ([fe80::2ef7:faa5:9104:f49c%8]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 13:54:38 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Talluri, ChaitanyababuX" <chaitanyababux.talluri@intel.com>,
 "dev@dpdk.org" <dev@dpdk.org>, "Richardson, Bruce"
 <bruce.richardson@intel.com>, "Singh, Aman Deep" <aman.deep.singh@intel.com>
CC: "Wani, Shaiq" <shaiq.wani@intel.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v3] net/iavf: fix VF reset race and stale ARQ message
 handling
Thread-Topic: [PATCH v3] net/iavf: fix VF reset race and stale ARQ message
 handling
Thread-Index: AQHc9OdqzmbH3Wi4PU6Nut9PHTnY2rYv96Rg
Date: Fri, 5 Jun 2026 13:54:38 +0000
Message-ID: <DS4PPF6915D992B4985581F5D7E9F6213B48E112@DS4PPF6915D992B.namprd11.prod.outlook.com>
References: <20260518054227.110701-1-chaitanyababux.talluri@intel.com>
 <20260605123646.1328492-1-chaitanyababux.talluri@intel.com>
In-Reply-To: <20260605123646.1328492-1-chaitanyababux.talluri@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF6915D992B:EE_|DS7PR11MB6037:EE_
x-ms-office365-filtering-correlation-id: 7f3127dc-6f96-47a8-8213-08dec309fc50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|6133799003|22082099003|18002099003|56012099006|5023799004|4143699003|11063799006|3023799007;
x-microsoft-antispam-message-info: Il6LGzmNA9noQ3/15hacGRxYpNJkF7Ak5DfizGQdcUfAFRNFx4EibAqYJMQUIiQNmmBTa1K+igYjPv3avrsHJjkj+veVQ01VYxCpmf+VI5vTf1fUaSpH4xtKRuVG1Acs4vOiRzmDRugHsCH+dk74068HesGBB6Jd4Y1HF+0UWi0Qpf8RgG/56AbBLk2qMJTxQ76kunjXFlgWNJUYgNHsTSpAj16R4FpGyoWyJVyQmzlGVhPsljcwjUBqZSlhExQw4TCpxG6dNruUESADM52TmGfOnGHldHMVgskdNOctY3ZSWWKooGyGs5EdXlkGsc99bAllym6mnikJY68k2yPQVu7h28FED3wxr5oDlIPzLPe7M4iqEAceTpudBji5FYatBy51eYVTWnUZR0fkHawkLj322Q1Sf+UE8NDUGoFxQF2NZe8t2h86yNS9YEMW2XbH+cRqEebSwkuYLHzrkCujTJgQGR4H3pOBu1NSmQpmCfkyJrmumZi0N6tbbrw3okrNB+qKLT5TF7S26QONfsJlMLuf6lEgdDXlW6g5Q5AV53Ta9JK7MUMyNjFJ0Es6T0Et/3sXkaSWbVNxaT+HD5thIeGc+rA5HUERiTN/u5fgDYNw9guOdIf8V7bAYZbEyEjiunrJIPklNel+pOO16ZOoO55clfVzKwWHaOrCnIdf0IuNYTXANPObqKlv8DCPepmXba4nkFONHdHE/QzwIamUD4ExSATslzh7wAUm8B2SPpswc4UfQu2vYhQBFWT39xS/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF6915D992B.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(6133799003)(22082099003)(18002099003)(56012099006)(5023799004)(4143699003)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b3ypsl0J2W0hxuuwzeEg6dFwphLN1nx2uI7tktER9gEKKvxmvzibdjlmE8xE?=
 =?us-ascii?Q?kOU+Zsd48JfSXlPw+++BuWPUGrGJNMe6xeAy7Hs0UkAaadVdr1L1/IKwxlJ0?=
 =?us-ascii?Q?OHEIjxoqZmhNB8ai9EVEiznT2Ki1enUU7VHXWsjmmG07l/R/9r44oGekT2Jt?=
 =?us-ascii?Q?vWVm6cd18D97o6/XxTXmIcNGRrejpTIPZ9dgozqHcslLchlonSxto0Up2L6Z?=
 =?us-ascii?Q?ZSDcl552FnDEXg4d7KWN6fqn85rI+aV+qFNh5kWzPf6b0KmOVmhoi8rfNtW1?=
 =?us-ascii?Q?S6yRJdpJkURIyv8d8P2dGm9UWj2oIyy8LPSflHU0eoxt9+Wgi+poRKewBkRl?=
 =?us-ascii?Q?nt9EhO7bgctGN4xhUuhPIwf5m5A6QmYjTb5I9iyWtZv+H8z6/PT9pmBXM1yj?=
 =?us-ascii?Q?9mHRo3alvpxVd/zFrP98WuObyUhP6YRVlIMD4ZnKSjctF0QRUUIvI2DepTZX?=
 =?us-ascii?Q?HhNS0XkImCTW/VEXmajAS+LCzGdbbx1pyYjH8JecWTOI6jTdwq+9dAJ4nSGX?=
 =?us-ascii?Q?l6Q5OzJL7HlkEgGRhs0Wi5aWDfJlnMbgVpVyKlua5dO23uFYO63+/mjG1yiM?=
 =?us-ascii?Q?j8JEnBpMr3EqKIJjQKqWYSVPPa8Kk+ISdiZ/cpafk77osDGgFlgdbwHXdJrA?=
 =?us-ascii?Q?qjIAPmrXgxjkFv4o8xlu5f52jUzKrmeqpBPtuy0DTiPAikP4MasIqbdoyYmV?=
 =?us-ascii?Q?cvL8Quoz9atyqQUolfYhH7nlAGiGCxJzTL5Q6os34/Fu9ivi5yYv784AI53P?=
 =?us-ascii?Q?JyEx0xvBBu778AQ3Bdwy05R7I+HkaPCl4DbYu1cOYi3PZ5USE8VEvOslApSo?=
 =?us-ascii?Q?VAmhFSi73YvYzlL3qVuiZgCBhLTuKCsiPX0s4Qod0QntK81ayR4Ol6GL5TTQ?=
 =?us-ascii?Q?vF8Wa/N0b/fcR/2Yj1G/BBOCYQ9Ko9oqYAvtzeLI9mn4UhGED0hfQuwHTvSN?=
 =?us-ascii?Q?Wxw0QA16ra6Hxq3p5pXRWDca+UqdGuYEvL64oVkxtCz/M01FIMn9BOiTziK0?=
 =?us-ascii?Q?cov4XXCqR2ybD9dRJ7/ryIkxEanIaTIiKYPm+7YRcv8cwo0a+T8FQ5eFQAG+?=
 =?us-ascii?Q?M43QmKMqgzeCUkg2+ux1Xt0sMZtLz+84yP9AZTuQKMFCl01XrVP6t4eIuMYN?=
 =?us-ascii?Q?32VbsmQQhSVYfGwmFcYPgJMrznf2q5Jy6Uf5JiwhdsF8LfwljXmW4+RqUKWH?=
 =?us-ascii?Q?gC0Ig37CoA/R8Cn7jJcQVTlNUGI5BQg0fmdCEYCyqo2AqM7lWFmtwTji+Bnm?=
 =?us-ascii?Q?xtmqli/0vLmD19TwRB0XzcSuce0BujTnQiqHRfcP2TsLP9STb7+mUKjLEXKi?=
 =?us-ascii?Q?I7QFTGqOQQDlEvnJ8/WzBGexRIcpLDe74G/9NHYI9IG8M72yPHcsqEI68JAY?=
 =?us-ascii?Q?BMruvTUkQgzyGqYtoXg4BlOkjPS0A6Q32MTbV2wF39GXM+/vWIYmiIQ4sYKg?=
 =?us-ascii?Q?e3r4KArsEQBMrXeEQ2pjXFnJzQY6gH2XxjzNB9sSq9dvs5YxXnjjvQOIoe1G?=
 =?us-ascii?Q?kcVL01B9X+wz7pjmuUmgUx2n2jMTbFQp8RsoC28Jtd4+pzZV8U+ak0y00DYv?=
 =?us-ascii?Q?eYER6W30oPxjVVcFFH8D7nyGZACKoidxQ/TmcJ1eWRM34liavSs2Bd2FRcl1?=
 =?us-ascii?Q?fNUlQzHiE4PSsNQOoY/RF5y+neByLYFI2TofUp1/zK9C+3bvMyPyGoGp8OZZ?=
 =?us-ascii?Q?XbfP31NJbZzglrU7+jetvxmjBsJ0Ry7gkmu9uB1jcsjmIyhuCuW2Rhtw+Aeo?=
 =?us-ascii?Q?CZY25hmpNw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Qpztbj1DvcGQKWlC65SKPuPyHKRyREm9qJeetlvDV94n7O8LmuIWV6zihWAZIXrIMikKjzlgUjc26eLrEvQlvBByL6ZGbgVKasSwPsixEZcKPTHonzTkEeWC6uagsZ2o1lEOexd85Z4iQKutN0+fk68jovstRhrB2c4sn57MkhP0jAEW3Hu+QBjleKPf+s2rcix4gTlHsqUtEbESmlDftl72/AtvO60rbfZUfUvfvxdVkGJ+P8Fj2VFCzPYTsniuEAbkrNPXufb3TybdBMZCUJrZE+mj6TrLc0lvw8VTVkrRqZDWKzCJV9uvs8Z4ebQKn+/uvrT57oxJScsJB7FIpw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF6915D992B.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f3127dc-6f96-47a8-8213-08dec309fc50
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 13:54:38.8241 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2LQr1qXIzPXf0c6AWV0fuXcD7munkmOUEiNsg23/S6XQ/9aoYIr+SN+SbNVPVd5UIZCZkZsNO4DDPJa9/2ry1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6037
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

> Subject: [PATCH v3] net/iavf: fix VF reset race and stale ARQ message han=
dling

Some comments below. I agree there is an issue here but I'm not sure about =
this
approach to fixing it. I've explained why inline.

One alternative solution could be to call the existing iavf_is_reset_detect=
ed helper
immediately after iavf_vf_reset() in iavf_dev_close() (on the reset path on=
ly). That
would ensure that the reset has started before before proceeding with teari=
ng down
and reinitialising the adminq etc.

[snip]

> +
>  static int
>  iavf_init_vf(struct rte_eth_dev *dev)
>  {
> @@ -2654,6 +2706,10 @@ iavf_init_vf(struct rte_eth_dev *dev)
>  		goto err;
>  	}
>=20
> +	/* Drain stale ARQ messages only during reset recovery */
> +	if (vf->in_reset_recovery)
> +		iavf_drain_arq(hw, vf);

Even with the guard, I still think this draining is unnecessary.
The adminq is initialised in the code block immediately before this.
I think it will be empty and there will be nothing to drain here.

> +
>  	if (iavf_check_api_version(adapter) !=3D 0) {
>  		PMD_INIT_LOG(ERR, "check_api version failed");
>  		goto err_api;
> @@ -3289,6 +3345,8 @@ iavf_dev_reset(struct rte_eth_dev *dev)
>  	ret =3D iavf_dev_uninit(dev);
>  	if (ret)
>  		return ret;
> +	/* Add delay before re-initialization */
> +	rte_delay_ms(50);

Although it's a short delay it feels a bit heavy handed to unconditionally
delay here for every reset.

>=20
>  	return iavf_dev_init(dev);
>  }
> @@ -3352,6 +3410,7 @@ iavf_handle_hw_reset(struct rte_eth_dev *dev,
> bool vf_initiated_reset)
>  {
>  	struct iavf_info *vf =3D IAVF_DEV_PRIVATE_TO_VF(dev->data-
> >dev_private);
>  	struct iavf_adapter *adapter =3D dev->data->dev_private;
> +	struct iavf_hw *hw =3D IAVF_DEV_PRIVATE_TO_HW(dev->data-
> >dev_private);
>  	int ret;
>  	bool restart_device =3D false;
>=20
> @@ -3370,6 +3429,11 @@ iavf_handle_hw_reset(struct rte_eth_dev *dev,
> bool vf_initiated_reset)
>  	vf->in_reset_recovery =3D true;
>  	iavf_set_no_poll(adapter, false);
>=20
> +	/* For VF-initiated reset, wait for PF to start processing it */
> +	if (vf_initiated_reset)
> +		if (iavf_wait_for_reset_start(hw) !=3D 0)

At this point of the VF initiated reset we haven't indicated to
hardware yet that we want to reset. So this wait will always time out here.
The reset is kicked off @ iavf_vf_reset where the VIRTCHNL_OP_RESET_VF
op is sent. Only after that does it make sense to check the reset status
reported by the PF.

> +			PMD_DRV_LOG(WARNING, "PF did not acknowledge
> VF reset");
> +
>  	/* Call the pre reset callback */
>  	if (vf->pre_reset_cb !=3D NULL)
>  		vf->pre_reset_cb(dev->data->port_id, vf->pre_reset_cb_arg);
> diff --git a/drivers/net/intel/iavf/iavf_vchnl.c
> b/drivers/net/intel/iavf/iavf_vchnl.c
> index 94ccfb5d6e..0a536a15e0 100644
> --- a/drivers/net/intel/iavf/iavf_vchnl.c
> +++ b/drivers/net/intel/iavf/iavf_vchnl.c
> @@ -296,11 +296,21 @@ iavf_read_msg_from_pf(struct iavf_adapter
> *adapter, uint16_t buf_len,
>  					__func__, vpe->event);
>  		}
>  	}  else {
> -		/* async reply msg on command issued by vf previously */
> +		/* Async reply for previously issued VF command.
> +		 * Stale messages from before reset are ignored, and polling
> +		 * continues until the expected response is received.
> +		 */
>  		result =3D IAVF_MSG_CMD;
>  		if (opcode !=3D vf->pend_cmd) {
> -			PMD_DRV_LOG(WARNING, "command mismatch,
> expect %u, get %u",
> -					vf->pend_cmd, opcode);
> +			if (opcode =3D=3D VIRTCHNL_OP_UNKNOWN)
> +				PMD_DRV_LOG(DEBUG,
> +					    "Ignoring stale msg (opcode 0),
> pending cmd %u",
> +					    vf->pend_cmd);
> +			else
> +				PMD_DRV_LOG(WARNING,
> +					    "command mismatch, expect %u,
> get %u",
> +					    vf->pend_cmd, opcode);
> +
>  			result =3D IAVF_MSG_ERR;
>  		}
>  	}
> --
> 2.43.0

