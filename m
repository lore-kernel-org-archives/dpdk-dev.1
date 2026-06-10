Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9F5CD98CE
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 14:34:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E2CE40678;
	Wed, 10 Jun 2026 16:34:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id E832940269;
 Wed, 10 Jun 2026 16:34:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781102073; x=1812638073;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=iBXDrCT8BPX5jrB2vx76IBfIzjBVD+4NeXyzpFPEvoQ=;
 b=eWvkxR9Mh5aWR5R6naq2k+tSN1QZv9uOj0Fq7b5ovwkvE2yoARVXhfko
 v3+FmpOJaBOP1FVud8ocz+0buZ9qOsOHMXNRK0wR7vjOpkmTc4CrLuzp9
 O6W8FbR4usIZkYOP4WnsXZXvl6+gGm3VWAJea/gbil86zfdHBCiwFZL0h
 uMLgsDCurP5gPRKYm73Y+Xzjf0/N9Y84BBTXArR8zZ0LzYuH04dUjTBhQ
 7aQrqMkGTDz9nqRrYXjDRakZaDReSHP5QSnRDrkn9YDts0iPY07rz1/uo
 5Xa8oXw6SeIxk9lIjkoPD+oLvMkHC2MyJvjFpHI4I7v+GiCNSFt80fGxL g==;
X-CSE-ConnectionGUID: bLjFKdbEQ2OdMp0ift6fmw==
X-CSE-MsgGUID: XC9pa5IlS4GEaJOAYd2v/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="82087420"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="82087420"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 07:34:32 -0700
X-CSE-ConnectionGUID: 5uBz0fMDQrWeRo+vH0gclg==
X-CSE-MsgGUID: kSeyPf+STkKS/E1ap/JiRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="246212409"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 07:34:32 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 10 Jun 2026 07:34:31 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 10 Jun 2026 07:34:31 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.47) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 10 Jun 2026 07:34:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W8VnRV4Pj767zcw/cWki7geW1G5ueL36+21p4KHx17wqTngTuaYwtbgnJT5h7rXIFzQ/9D4kCcG2gJmzoswgYrCfPtG6TTtG0rPnBNF2vjV/yK1QgxKfmEO9bCBfjWxyvl8M37bKAp2wqUdSVB4FsPKDHy0CCZ6NOduH2RY3ZAK/3nDsNQ2C2q1rYXCgIVorYtRaGjQ8mh4A9t/OyAKnN5Zt3ksElbYg1XrZDcVeKZXk4FKS4PtgQ7pC4vZS4LH3KYMO7WKL1XzM+WPlSBQ+6upM2vFLD+6zBpiAmwqnkaZHX4F8+846mnl+OFGkoPmZKNMYhY+EbenT8YekPn7WoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZyxREKEZgIPcUR0IxXtOFldzDCKfeoUobVfbns8DpIM=;
 b=XybqyaATSXGEpa/hj5XCrBeByNipP4KQ7Sq2yUlMeZdvjCo069WZvzJ1vlJfGF+5A7VfPPlzhxGL+Tl9cRp7zE5kzjhbmfGVuOR4Cf3UDOm/RH9SAnCEqtAhIBar46hyruku5AQ+DUvO2g+HN1KxXDVZuIbjDZFPk0bGawz29Hu2gCwO0Pu3p5B0PV89ZDEZpwJ9BtLAx+Ohqhul23GEnbQQoPlNHPWfu1SRCbbmVSo/2ln39PIYG0ARMFBoEpsFFZKdWUqrTM6fwQKD76P2m3IbIJSH7n5eyqigg9ZVmRolEb136B+fxxZdNThbRFaHqdNffomX5m8wTK4ixE4+2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by CO1PR11MB5204.namprd11.prod.outlook.com (2603:10b6:303:6e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 14:34:27 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 14:34:27 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Mandal, Anurag" <anurag.mandal@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v3] net/iavf: fix to consolidate link change event handling
Thread-Topic: [PATCH v3] net/iavf: fix to consolidate link change event
 handling
Thread-Index: AQHc+OMovL/9+858oEap82xC9/0lLbY32oqA
Date: Wed, 10 Jun 2026 14:34:27 +0000
Message-ID: <IA4PR11MB927893A5541358313C538CA28E1A2@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20260609001022.357509-1-anurag.mandal@intel.com>
 <20260610141230.369232-1-anurag.mandal@intel.com>
In-Reply-To: <20260610141230.369232-1-anurag.mandal@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|CO1PR11MB5204:EE_
x-ms-office365-filtering-correlation-id: 9d53a830-ef13-47b0-31e2-08dec6fd6018
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|38070700021|6133799003|56012099006|4143699003|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: YUE6U/BvWGV/ByvLAk9J0VRrEaxgGB+5i/UUmAXc36Gf5dMPFmiVG8yL3V8aBzDjxoddoykXoT0bOmat6hsR9hYfBmbr+D9hdRfcQe6FWP8Syj28ZWmqjZ+Xku4nRhe5l9iCJeVrGd2J35+54r+fI+6+sGZFrD3bhCxi0+RUYOYtrKxj4PUUb/HG2tGhFpTXf2gmBozqayN0Pa4h5+53PiXHGfKywyjN/4toEHAkw6qtXHdG2dKDqlUZl6qdJ7zMPTEdZO+kbrLdpdkW8S6+OB5g2GIKgO+zne2M9D6LQzE7Tr/okuVov2Qs3755oQH2qw6rhV/E6qXiTqUgG5+xavlOWAJt+2Bk5tAydpZC6j7RBgUpDsspFcHvMAVq5hNaKPYW8j7wYJoN243MNnOg/SoUclO0xIZKKy5LO/Kgb/PZ9Eb24JGHPyoTSqzM6G1oqqddJYMC/GxGiTuGoDs8dbVgQZhgEVNUtVNtPr5c9c8sDy2LE3+BRyb6pGf8bJPlCBvLLfOrLIfqDCXROL6J/b8uuABIbB4JUNShepgVB2zK5TAMKL9bAs1Uvk4ME7002y+Xo9Zv+hf5f1roXNjjt8VniyulcduPAK1EpNaEGEtqYJ6qukF09/azWGTL5eXwmN98um9lpSP6bVyQaUzK0OMz+LiIxy6nvX8ey8sGbyF/pgY8dE/CdmuJnTSQhP9FnQ+Z8dgGBxz7zPmLoJq+4t1GXjeDS/BxbFRTyviNs40wHIVZ2rmqalAR5TVMwzKR
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(38070700021)(6133799003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WTMEmyBrGJnS4mOGYuwjMDbF2dSe4PBHhXXrPCmaRa8FiKyzLPXaIxOe2m8R?=
 =?us-ascii?Q?MYEKAZjMvThNwudLVo7JoxQEkkAqF/QjSAOG33qUhpMnPsAoJ0+SYOSvHMJB?=
 =?us-ascii?Q?XaXW+dssjYrcjCeD1lomdK7zTbcH+3/Q3uaLXIj/1ZgUsbr22kyadGkHNz1e?=
 =?us-ascii?Q?dYR70vY7NzR18l6VJjoCoRl/WMtYI7qKfkkcmgj3mDxLncVSXLLlV4TdIeXc?=
 =?us-ascii?Q?8/s4gLnuGkF1gcio95+xa8Ojj29wPIS1GuTu2WLfLTQkpil5iDReqLvH1mAz?=
 =?us-ascii?Q?inpbzJb3mrqxzbJJM0YPEBgmABXPrIkUDBGpyDyycTwVkVYqHv3dXXVf1yvK?=
 =?us-ascii?Q?L1Y8AMQkCQtfGdoYa1rSQdBhi9u2/oLXTnuRQi51izx6yZGT6uvF1KgJ7RJs?=
 =?us-ascii?Q?B11cX1UEPA1yNkzCmlpA2obzCyXxMcnxrynuD/dIPSvUKX592EwCTj2picB+?=
 =?us-ascii?Q?Wf8tC5Art4+m8AZODlCREZS5qGjiNyxJHJn80bOugYuNFOEDozkh/NPoJF1Q?=
 =?us-ascii?Q?kwUmP9svOks+r6E4OHi8EqhOQmUXIiCTZpVnFqbja5r6j3VdVJWo7EniSJ7L?=
 =?us-ascii?Q?IbhzyCBd+mZaPVUgB9Zih1/u/AONipYSwqYROSpUTO3irKa7FUhsRpWkfN+B?=
 =?us-ascii?Q?tnp/2hokpWe6U+vZep4fs9gNlDC7/9+ZjjABje56BrqqynyUU5wX6b5Wc4k0?=
 =?us-ascii?Q?h2TQoi8TgyEM8jlwEs6t/0mDyv3C3UuG6Gbi74953AsXTeDx48WHXH0gM0NX?=
 =?us-ascii?Q?zgjXupSalGPyqlxOzauYO/yGupky1z5L4KBZc0ahoNmKVN9EgX0oWDzfkD5W?=
 =?us-ascii?Q?a2aQ8IzD6LY9H89T3+GIr1Y3N8k4+ZMsqc9XV0s+hzdHuV8bdPa7Ec0/hZrA?=
 =?us-ascii?Q?zh18KxahLyyY8YvgPjyDMtrSPbkRZixpew9G0iE0zmzeoP6jmvFGt06tPgnO?=
 =?us-ascii?Q?NeY++I/XxXHNdRwq5J1SdtdBGMYcBDiyx+0SrODXIU8IEO5VoeUt3CAtqHfz?=
 =?us-ascii?Q?e50UEYagSuKVSYKyuhTZWVQUyyl+VSNH/EX5mzXEUh/li905uYevBdEazSkn?=
 =?us-ascii?Q?QUALt8to21JVujaD9lkF40hUR44+BGk7udSKMBjBTARVNWNwaBPSvd2xbYvt?=
 =?us-ascii?Q?KiRReahrcD9kYi9xizwD5sbRpN5n9+owEwjf8Q1Tdwb4JTP866IZua2PgnOQ?=
 =?us-ascii?Q?5PjY/b0sEN5w1UQnb6evuLMvQhtL1bOskcAWdOCoZUXSgcGWBkuho4akZQRW?=
 =?us-ascii?Q?N8e868PNM09qvbip7suLK/q949v8N8pUwlqLOd7UotBgB6Q0I1qd34kXUVlZ?=
 =?us-ascii?Q?gwjt0mwMD6c3KSSu/ksX/XQ0BSETCM3Q1PlH/1p4LY9MfM+rlAG2DzW1VWeZ?=
 =?us-ascii?Q?LuYhVUJ80lwXj5WDX0f2o7OnOoG3eBiemnoKVRFMjrS8Mlfd7WY5xNI290nK?=
 =?us-ascii?Q?gmOZXx7fatSYSwPkkITP2m9cOrF0HZxkPUdGK/r1U2yl9srwL519iVnkd6gn?=
 =?us-ascii?Q?2HH/WsajbsfPVxveL7qTN3gtGPCiv4DjpJNr6ViluzRmw9mLAC1xASbON9Hn?=
 =?us-ascii?Q?1iENFd7Qq608jnG5+RVIxwMDCVb+eKELc/9u1NbA+kNqasO0KZYuvcVidazS?=
 =?us-ascii?Q?b5n18KQ/j5mC7EkW8LDI+aBlknuZ35d++YvQVPhgOyvFz18OaWmC5gdRoIMg?=
 =?us-ascii?Q?OZO2FZDyBjjbDh5DCqGql+t6FZfSD0XghQ0/KfxRZ4P6j+ULelna+BZkqM9x?=
 =?us-ascii?Q?26wJA6uz2w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: X0EJJEbecoREqTHM4YFJuzhaghPQLqImsGWkCtzZBj8wMZ5RoAOOfnlnp92SGoX0dmbFD7OGlcDcdupnRuMF/rq80sQYlMfCoeiNGx0PhOY36TQ9xsgh2K9yjCOemfuXkJEhrP52vO2aCrIaYZMGtD/tL5/HIqd4TJHaS2STTvyK1os52VW8KGkUyYmDbYI72XZZxFAvkjJeamwHc2njborU4+iL+pVTu2W37VLlVSYnE3uspKgpZxazsRop9ro7UhRbqhaJsSpR7WD4p098MqPgZA3PYdqbXl8hkERN1l2JUnrIuMkS5KxeFJrnlPJVUAUUTD1qBxlAcE7+l4ZGMA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d53a830-ef13-47b0-31e2-08dec6fd6018
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2026 14:34:27.4148 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SzdiW1s1n2T63oa4MVgcr8HOwFqH8GXpdV/Lmi+zZx1nrzGA2DBCqKVNc7o7aUDTLJydCS5Z9UMvwe/lCV/XPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5204
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

> Subject: [PATCH v3] net/iavf: fix to consolidate link change event handli=
ng
>=20
> Handled link-change events through a common static function that
> reads the correct advanced & legacy link fields properly and
> updates no-poll/watchdog/LSC state consistently.
>=20
> Fixes: 5e03e316c753 ("net/iavf: handle virtchnl event message without
> interrupt")
> Fixes: 48de41ca11f0 ("net/avf: enable link status update")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>

Thanks Anurag.

Acked-by: Ciara Loftus <ciara.loftus@intel.com>

> ---
> V3: Addressed Ciara Loftus's review comments
>  - removed two unnecessary NULL checks
> V2: Addressed Ciara Loftus's review comments
>  - removed unnecessary NULL checks which were overly defensive checks
>=20
>  drivers/net/intel/iavf/iavf_vchnl.c | 115 +++++++++++++++-------------
>  1 file changed, 63 insertions(+), 52 deletions(-)
>=20
> diff --git a/drivers/net/intel/iavf/iavf_vchnl.c
> b/drivers/net/intel/iavf/iavf_vchnl.c
> index 0643a835d5..36b7ee9526 100644
> --- a/drivers/net/intel/iavf/iavf_vchnl.c
> +++ b/drivers/net/intel/iavf/iavf_vchnl.c
> @@ -216,6 +216,67 @@ iavf_convert_link_speed(enum virtchnl_link_speed
> virt_link_speed)
>  	return speed;
>  }
>=20
> +/*
> + * iavf_handle_link_change_event: common handler for VIRTCHNL link
> change events
> + *
> + * @dev: pointer to rte_eth_dev for this VF
> + * @vpe: pointer to the virtchnl_pf_event payload received from the PF
> + *
> + * Handle PF link-change event: decode adv/legacy link info, update VF
> + * link state, sync no-poll/watchdog behavior & notify app via LSC event=
.
> + */
> +static void
> +iavf_handle_link_change_event(struct rte_eth_dev *dev,
> +			      struct virtchnl_pf_event *vpe)
> +{
> +	struct iavf_adapter *adapter =3D
> +		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
> +	struct iavf_info *vf =3D &adapter->vf;
> +	bool adv_link_speed;
> +
> +	adv_link_speed =3D (vf->vf_res !=3D NULL) &&
> +		((vf->vf_res->vf_cap_flags &
> VIRTCHNL_VF_CAP_ADV_LINK_SPEED) !=3D 0);
> +
> +	if (adv_link_speed) {
> +		vf->link_up =3D vpe->event_data.link_event_adv.link_status;
> +		vf->link_speed =3D vpe->event_data.link_event_adv.link_speed;
> +	} else {
> +		enum virtchnl_link_speed speed;
> +
> +		vf->link_up =3D vpe->event_data.link_event.link_status;
> +		speed =3D vpe->event_data.link_event.link_speed;
> +		vf->link_speed =3D iavf_convert_link_speed(speed);
> +	}
> +
> +	iavf_dev_link_update(dev, 0);
> +
> +	/*
> +	 * Update watchdog/no_poll state BEFORE notifying the application
> via
> +	 * the LSC event. Otherwise the application's link-up callback could
> +	 * race with stale (link-down) no_poll/watchdog state and either
> +	 * continue to drop traffic or trigger a spurious reset detection.
> +	 *
> +	 * Keeping the watchdog enabled whenever the link cannot be trusted
> +	 * (link is down or a VF reset is in progress); the watchdog drives
> +	 * auto-reset recovery, so it must remain armed in those cases.
> +	 */
> +	if (vf->link_up && !vf->vf_reset)
> +		iavf_dev_watchdog_disable(adapter);
> +	else
> +		iavf_dev_watchdog_enable(adapter);
> +
> +	if (adapter->devargs.no_poll_on_link_down) {
> +		iavf_set_no_poll(adapter, true);
> +		PMD_DRV_LOG(DEBUG, "VF no poll turned %s",
> +			    adapter->no_poll ? "on" : "off");
> +	}
> +
> +	iavf_dev_event_post(dev, RTE_ETH_EVENT_INTR_LSC, NULL, 0);
> +
> +	PMD_DRV_LOG(INFO, "Link status update:%s",
> +		vf->link_up ? "up" : "down");
> +}
> +
>  /* Read data in admin queue to get msg from pf driver */
>  static enum iavf_aq_result
>  iavf_read_msg_from_pf(struct iavf_adapter *adapter, uint16_t buf_len,
> @@ -253,34 +314,7 @@ iavf_read_msg_from_pf(struct iavf_adapter
> *adapter, uint16_t buf_len,
>  		result =3D IAVF_MSG_SYS;
>  		switch (vpe->event) {
>  		case VIRTCHNL_EVENT_LINK_CHANGE:
> -			vf->link_up =3D
> -				vpe->event_data.link_event.link_status;
> -			if (vf->vf_res !=3D NULL &&
> -			    vf->vf_res->vf_cap_flags &
> VIRTCHNL_VF_CAP_ADV_LINK_SPEED) {
> -				vf->link_speed =3D
> -				    vpe-
> >event_data.link_event_adv.link_speed;
> -			} else {
> -				enum virtchnl_link_speed speed;
> -				speed =3D vpe-
> >event_data.link_event.link_speed;
> -				vf->link_speed =3D
> iavf_convert_link_speed(speed);
> -			}
> -			iavf_dev_link_update(vf->eth_dev, 0);
> -			iavf_dev_event_post(vf->eth_dev,
> RTE_ETH_EVENT_INTR_LSC, NULL, 0);
> -			if (vf->link_up && !vf->vf_reset) {
> -				iavf_dev_watchdog_disable(adapter);
> -			} else {
> -				if (!vf->link_up)
> -					iavf_dev_watchdog_enable(adapter);
> -			}
> -			if (adapter->devargs.no_poll_on_link_down) {
> -				iavf_set_no_poll(adapter, true);
> -				if (adapter->no_poll)
> -					PMD_DRV_LOG(DEBUG, "VF no poll
> turned on");
> -				else
> -					PMD_DRV_LOG(DEBUG, "VF no poll
> turned off");
> -			}
> -			PMD_DRV_LOG(INFO, "Link status update:%s",
> -					vf->link_up ? "up" : "down");
> +			iavf_handle_link_change_event(vf->eth_dev, vpe);
>  			break;
>  		case VIRTCHNL_EVENT_RESET_IMPENDING:
>  			vf->vf_reset =3D true;
> @@ -525,30 +559,7 @@ iavf_handle_pf_event_msg(struct rte_eth_dev *dev,
> uint8_t *msg,
>  		break;
>  	case VIRTCHNL_EVENT_LINK_CHANGE:
>  		PMD_DRV_LOG(DEBUG, "VIRTCHNL_EVENT_LINK_CHANGE
> event");
> -		vf->link_up =3D pf_msg->event_data.link_event.link_status;
> -		if (vf->vf_res->vf_cap_flags &
> VIRTCHNL_VF_CAP_ADV_LINK_SPEED) {
> -			vf->link_speed =3D
> -				pf_msg-
> >event_data.link_event_adv.link_speed;
> -		} else {
> -			enum virtchnl_link_speed speed;
> -			speed =3D pf_msg->event_data.link_event.link_speed;
> -			vf->link_speed =3D iavf_convert_link_speed(speed);
> -		}
> -		iavf_dev_link_update(dev, 0);
> -		if (vf->link_up && !vf->vf_reset) {
> -			iavf_dev_watchdog_disable(adapter);
> -		} else {
> -			if (!vf->link_up)
> -				iavf_dev_watchdog_enable(adapter);
> -		}
> -		if (adapter->devargs.no_poll_on_link_down) {
> -			iavf_set_no_poll(adapter, true);
> -			if (adapter->no_poll)
> -				PMD_DRV_LOG(DEBUG, "VF no poll turned
> on");
> -			else
> -				PMD_DRV_LOG(DEBUG, "VF no poll turned
> off");
> -		}
> -		iavf_dev_event_post(dev, RTE_ETH_EVENT_INTR_LSC, NULL,
> 0);
> +		iavf_handle_link_change_event(dev, pf_msg);
>  		break;
>  	case VIRTCHNL_EVENT_PF_DRIVER_CLOSE:
>  		PMD_DRV_LOG(DEBUG,
> "VIRTCHNL_EVENT_PF_DRIVER_CLOSE event");
> --
> 2.34.1

