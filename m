Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723FDC2D0CD
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 10:52:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44C76427AA;
	Wed, 21 May 2025 12:52:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id A9E75427A4
 for <dev@dpdk.org>; Wed, 21 May 2025 12:52:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747824749; x=1779360749;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=PU8VJTPqVBUH4bX6g64u0K0n4RgiV2037qiV3gxymGs=;
 b=IVsXdcNGyBFCMscdZoRMbcgcuEO/8UZ2xhI4b7xmGS2gR6Sfo4XjgatF
 lewLH7pUjM342/GIyU5lK5QzXBJGnQHjo8GfXzeHpQJLVjesrX8wHG6d8
 CivoWgbbLJ+aIGbmAsSMBnDLvydeHSsq2YpWG69AsIlQFdp3H1fS7+H/V
 IQFRuB7YWzEHUKR9+VqQkcW3Se3vwmtHqFKUzYvcr7XqpvQzE2ijOX11u
 S0H/vs5X0GmvrRctz6Jk7V/Xz9vnvgC//ARRApKEoQ/EkOARYLfnrNzvM
 QxfJsCDU+Syo85WNVjmSC0KbqeYKbQRZqB1T/rPWqqDq/q+QavhzZWgQW A==;
X-CSE-ConnectionGUID: BnBhjcobQXWlHTRNVDAySA==
X-CSE-MsgGUID: Xkzi3z4cTi+vpPmJ35Rw9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49952683"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="49952683"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 03:52:27 -0700
X-CSE-ConnectionGUID: d8gUr6CTSVOJ8SmHnJFatA==
X-CSE-MsgGUID: toS16jRpRS6OuMh3TmI/uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="170885336"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 03:52:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 21 May 2025 03:52:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 21 May 2025 03:52:26 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 21 May 2025 03:52:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XzmaSVRMAP4arBNZhmLwgUvaSRj/pTeSoyhLYOv9hYSzH4wHaXq91lVO2L8XJvWxDY6+kQw/neAoBLtwlGMlyT9/bLcWScfn4Q/fHQwgPdxsDYTJziATPGxxkk2536/c7W0mWZfxk1MiAuSpKjKPXXmdGUNrlauLdV4k/wUoC3yoQ8u9Gom4CGQ4F7YZ0T4fgfnSkjLrHR9QD75Zd2lc/GCuvVppW+/nYhsBaRAAudPI0soOMAFuH9mdVckKiy/9cqj43niDz0xjbCqMClzrPTWhRPEIhrWbzLzDaXwqAZ1OeweDAsxlwctdMBv1i4Mv3OJ+1DLDPhM45XCeFuzfDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WB3IGyHld6GD4Rm5OWoRMesTu6cMHmad8sVKVxkT2hY=;
 b=L2BGEwOPqPmSdAJQ3Jg4MqS9cq8stDOuIiqnoxZ29DmDseACv7TA52j0Teh00/D6zaQZuLJ9UCMssdqSN2f+mxxj79lwmoaJ063ule9SjurhQZSiUvic3EV0yJPiOFUiWJiBlTZaY+5MseMsnmKYd8j8MPnjk2GHBegf2zVGwpmfXhF0y9drikm2NYyG28JbhxqhxkgRZDUKgKvVETk5Rbwb3kZD899ILNKHO70HXc6riMZGWjP1Uic0Kjiya7ABXazUNLYZaoKtl+wYh85u81rYxeKQa6iB0smI5x/PYVHHTIqR6jwhuGisoL6so8XwosZz9Ev56VHGtVW+NH5P8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5872.namprd11.prod.outlook.com (2603:10b6:303:169::14)
 by SA1PR11MB7698.namprd11.prod.outlook.com (2603:10b6:806:332::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 10:52:21 +0000
Received: from MW4PR11MB5872.namprd11.prod.outlook.com
 ([fe80::6444:ca4c:aa3e:f8d2]) by MW4PR11MB5872.namprd11.prod.outlook.com
 ([fe80::6444:ca4c:aa3e:f8d2%5]) with mapi id 15.20.8722.031; Wed, 21 May 2025
 10:52:21 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "stable@dpdk.org"
 <stable@dpdk.org>, "Burakov, Anatoly" <anatoly.burakov@intel.com>,
 "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
Subject: RE: [PATCH] net/ice: fix support for 3 scheduler levels
Thread-Topic: [PATCH] net/ice: fix support for 3 scheduler levels
Thread-Index: AQHbvnKgrlkGAuq290mjcWMmsnfL/bPc/8Hw
Date: Wed, 21 May 2025 10:52:21 +0000
Message-ID: <MW4PR11MB5872C77092A3DF1A312FD5168E9EA@MW4PR11MB5872.namprd11.prod.outlook.com>
References: <20250506103414.892849-1-bruce.richardson@intel.com>
In-Reply-To: <20250506103414.892849-1-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5872:EE_|SA1PR11MB7698:EE_
x-ms-office365-filtering-correlation-id: 46b18978-5278-4e4d-95f7-08dd98559023
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?4/zKLozhP+dwPZIbQyOyOvwScVro65Uljv9vzkaKqV6b9+4by0GHGzWdMYOV?=
 =?us-ascii?Q?jRaXkYHBxW4l0RWWI+1hKJASnoziBMspiU1a0+WRYWtYTuME6NEzDiyiKXTm?=
 =?us-ascii?Q?sJhhx/JXmPogXg5cWegH7rDLr51A67yLDSEr5ztCzfb1kgwopE4OiZ7rCrAQ?=
 =?us-ascii?Q?rbNNQoj2Vrzp+809rbZNJ4coTzu7PKcBo21oQ6qSQj3ut4feLOyBnNp+5GQG?=
 =?us-ascii?Q?NuYgTx7U0h4wAdW2giyECIaU9I5fiMfCKbhiNbIWgNwZN4s0l3A5NGXTdPsM?=
 =?us-ascii?Q?GD+6bhy9OMkJdlgIxEmzQAZGn9oLPXm4Qk9Y4fGWYE8KF9O1fbVm137oR9+c?=
 =?us-ascii?Q?foPt27il8h+M0/k6RajmO6UAiHyVEcGQDs7UG/dE6IVszG2QjYc1HpTgN1q8?=
 =?us-ascii?Q?A86aTFpa6N46T3F9UENS2Zdfw1M4FNm8JkXdopmw3LtUIohKNBXJpAy4cSZz?=
 =?us-ascii?Q?XJGblnlFBXvyl1Dces5py8db1gg/qxOLF/TaDObVCxDZ19f2hupr3nGPx7K1?=
 =?us-ascii?Q?EfHSEhfxV081EHtkZKkAOMAfgWhjNgPC/bUzC6QR7/I8nirGG7FAESVyf070?=
 =?us-ascii?Q?to9qZhow5IYVEJrgRvI4y6tJfHDi0u9L3+BwFaalyBbAbYy6FPaPVRW0jids?=
 =?us-ascii?Q?DjJq1CM7dqXh6x2eylzi3qj1A2f1ZRh6YWa+Qm1ILgV6VovnrO3lkzHvCiZR?=
 =?us-ascii?Q?g3iwWD9Ji6pKIkq6BVZXU+xY17zmYphZtKFDqkjl0j0UoFPyvfVj+JhdQ8+t?=
 =?us-ascii?Q?yyFBidGa0rzJ6RLbGjhrL6EsZafW+VtbjHoTrllyP4FXLK5cTsIr6nARH5J3?=
 =?us-ascii?Q?oagab3/VXh6Vk1U8fdLp8jp6WiQ0G4b6zqmWg6WlMMs5qKyvy3OSL3hMRgYL?=
 =?us-ascii?Q?1ZQaZ7YsPJqbmM7f6pREsm6/f6K5DD0g/EZDNvX9hlM1wEIbRCwMIatbjp3j?=
 =?us-ascii?Q?SBPF5TG69GohnLqq77ahUCxhwhHvtrf0QZLrywDUHBhbRYwQH4/dTwxw1GgQ?=
 =?us-ascii?Q?tmwG0bYHwcXBBPOzUVdN5Q/uSKVvBB1sczVkBG/bglpVo9T0TsUbl26tzwV7?=
 =?us-ascii?Q?cNyt0+c2XMWp0/rKxfklSo3DFcqWortF15vFawC5SL18W/6XLqDwKlnQ9vW8?=
 =?us-ascii?Q?Hy40WbWhchI6FbZQ6GOhaAxqx2niOOmKfWLUxY7br3/lfapvgr4Lho3RQhD5?=
 =?us-ascii?Q?eJEyHbI1f3Sdgn9Y4nG3tdPaPSpZf8lY0l2HHJCXRQvFaO7MqMqO8rs5ogGh?=
 =?us-ascii?Q?drL9PZ6p7kS7WCuNMQXbQBepuxctBxeFmGzvqmNqTaz4n3f9udrHV9mbOhRF?=
 =?us-ascii?Q?AyUsznzm0/U4j0WIENLIJL3cp88hpv0EzOT1E4tA8lfi5ucSMbegsFrsAA4A?=
 =?us-ascii?Q?oZtw70Ft0usMJ8CE2PYezM892yFHvHelxhobQuo00+6ODgGxA6T+xsTRl41f?=
 =?us-ascii?Q?NRSQQ8v1OJTAmCFwi8HTT6ycRkzmvxIsRVGAtncsdcf0GYqKXzkpEs/PVOqi?=
 =?us-ascii?Q?VD0UOvMbJ6Sh0fc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR11MB5872.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4xI++U3gca3FDPK7N5eG6KHghE7izG9mS1BsvY5h6m7IiajFtEoO939sIu89?=
 =?us-ascii?Q?zT++iqbRg8XG8t13UCYU78WVQ/TLhcXi9csJnms3y1HdEdkq67Zevnrn6x0f?=
 =?us-ascii?Q?cdxGK0Cfhb1q6O1FqGCQHBSV1Zkea57hpJxP5X+KgMIQcQKEeWlgfM7HoPSW?=
 =?us-ascii?Q?nI1PO/xy9RwVocc1BZy5e7X06bEmYuBMZbsu8BP54Q2Vdl8bAoa0IU2TaWk/?=
 =?us-ascii?Q?ZTkthLr4EI49Qb5B9+SRdPM1sJnlEzBEkGeKwz1iLPMLpX/eRr689w3StT8u?=
 =?us-ascii?Q?jwjWjUlgS4HIOu/lw+9R690OE3jHU51ZK6+jMBml9HVVsIp8SBU9I/vwAJTi?=
 =?us-ascii?Q?po2lFNNn1s2aFgZYfQr8f4/gGFsKRhoZG5g0qIAGRzDhEBcPEZx45Io6hqxN?=
 =?us-ascii?Q?BSAjH0ro7925JfAnOqiCIzIuaX8CM8fMBIPzLUav5aESMgjksJSNv3+F30Gf?=
 =?us-ascii?Q?2F0niTLzp5++ryUueL+OI0yGld7ahqgBWh1Wtr2XQpuln1d7jpNeTuF/BqdX?=
 =?us-ascii?Q?skMDy63GcZlCTiFMmnkIOIV7iKMD2ZRPze56MAXf/2TacOVDaW4TEistxwUK?=
 =?us-ascii?Q?2r/lHBjgB27HSYSMO9QT41OpV3IITiRPWfEdQ7XRJIWdxi7C8TTnQak7qz3l?=
 =?us-ascii?Q?LX65xvTdEvsCwz58yIAUQYXBHf9q7KBpnkpbUpFAG+sY7GYWpCvhj7bLv2+v?=
 =?us-ascii?Q?rvJkJh/8TiJVGe9q5XdpAnH9gUjQS4h7HljPItUBl5orIlWQ1WzHmEa7zJhR?=
 =?us-ascii?Q?5CefHw2R7ZuHAxMalWa9MOBiP8yE7O9SiHeG6kTJ1vUV/VeQ6pmhaDG83EXX?=
 =?us-ascii?Q?EniMoESPrcDl/Rcw7rDvtLU70+VCRj1hvUryhGnyeVEUsfRLmkMpRaZufrsq?=
 =?us-ascii?Q?sM4TMx57whJPz8GAl1sCs4PP70E74reZ/fTPeu44m1lq7XwwBOBN4DHE1su3?=
 =?us-ascii?Q?VniHrWB7zGXxG/syVDX6wibFdheLZijZU3IhU6PNmnaNSSTlO3U+NK3XLQlN?=
 =?us-ascii?Q?EkiDRw3eJ6/nWPLDkdTCsVYS4UYYDO6tPtbEs8mKa3siOtjzpCYksnI63q2l?=
 =?us-ascii?Q?tbU74lfRNli4dRItLx6VvGbuWlBk8rv5bxjiDz1WSREEoilqHcOCoI763vlX?=
 =?us-ascii?Q?EdKJZFfog3PJiY+z4Jy6qzpe1pBQBQ+jE/K+RoG008JbU8UAf2/ilHxbKH6k?=
 =?us-ascii?Q?W9/pHlPEOOIip0AqB8G7ahtP/8IYeyQXG61fnWag0zvqdkj8GD42sqJnHkYa?=
 =?us-ascii?Q?L+/Nu/fB7HXgvRnvtlE+VfTKSU3ecZJug+WmrLmdmOfid1O+B0SgqOhWdUtj?=
 =?us-ascii?Q?ip9uIl1473RMZwtRRL0UeL8zLQtflRE0HBzTpvpL5mD6DNf8eK+HJKTXPdOo?=
 =?us-ascii?Q?0PJHJjPpZUjWqc5pqvsGa1A8Cqxzd7azqVBeWjJRUOEUl+eLfv+nRg9wuxEA?=
 =?us-ascii?Q?T4LMp1lqEeGRpuIMRmtpJsOojFOOvXly/8sP4rGvOpM+EgIz0I1j0rafnnU/?=
 =?us-ascii?Q?i4hx8HfOCaJ5/PBHMJP8+i0G5wtNiz52EYVOfx+GFfL/4dTSSpS+M5PYVL+Y?=
 =?us-ascii?Q?6e34ND1w8a+0zA/SP/ZNnppyzyUBIq7PzvD9SSRy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5872.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b18978-5278-4e4d-95f7-08dd98559023
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 10:52:21.3586 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lu1Q1Lmn4uL1887OvNvXuxyo05a/YVn8IqTOvqfvc88c6Lf2nchrmpyZVdh/sVR4MVeOBnzRtgl/bIgOBSCu9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7698
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

>=20
> When using only 3 scheduler levels, the VSI node needs to be a node
> further down the scheduler hierarchy, rather than one up it as with all
> other possible level settings (5-9). Take account of this possibility in
> the code.
>=20
> Fixes: 4ace7701eb44 ("net/ice: provide parameter to limit scheduler layer=
s")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  drivers/net/intel/ice/ice_tm.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/drivers/net/intel/ice/ice_tm.c b/drivers/net/intel/ice/ice_t=
m.c
> index ff3a6cd77f..f2d8e12181 100644
> --- a/drivers/net/intel/ice/ice_tm.c
> +++ b/drivers/net/intel/ice/ice_tm.c
> @@ -818,6 +818,18 @@ commit_new_hierarchy(struct rte_eth_dev *dev)
>  	uint8_t qg_lvl =3D q_lvl - 1;
>=20
>  	struct ice_sched_node *new_vsi_root =3D hw->vsi_ctx[pf->main_vsi-
> >idx]->sched.vsi_node[0];
> +	/* handle case where VSI node needs to move DOWN the hierarchy */
> +	while (new_vsi_root->tx_sched_layer < new_root_level) {
> +		if (new_vsi_root->num_children =3D=3D 0)
> +			return -1;
> +		/* remove all child nodes but the first */
> +		while (new_vsi_root->num_children > 1)
> +			free_sched_node_recursive(pi, new_vsi_root,
> +					new_vsi_root->children[1],
> +					new_vsi_root->vsi_handle);
> +		new_vsi_root =3D new_vsi_root->children[0];
> +	}
> +	/* handle case where VSI node needs to move UP the hierarchy */
>  	while (new_vsi_root->tx_sched_layer > new_root_level)
>  		new_vsi_root =3D new_vsi_root->parent;

Acked-by: Ciara Loftus <ciara.loftus@intel.com>

>=20
> --
> 2.45.2

