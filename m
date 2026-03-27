Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD54110ED659
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Mar 2026 11:22:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 82D65402C5;
	Fri, 27 Mar 2026 12:22:06 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 5978840280;
 Fri, 27 Mar 2026 12:22:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774610525; x=1806146525;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=KZeT+rBuHgAufMswW0OTP/xiKmyXUxBXMoR6n35SORk=;
 b=KlSkK3uggR2zhcQKxDPc3V4U9uFJZOCJauOptFhdh2DpVn+84wnaDSdG
 2SMr/6qZE/UX4KP+fWze91Agi9FQTFGT/3ADxFAsTK0rquDem4Tfs8u0w
 fwIxUjxSnu9MZGclwKLptMJ3E1eBVQLBWmA8s1PjXZ00RHvtgN9nw18Pn
 1P1UviR4H0OLwzLxyyTlbyIsBGJGCXWikRFaekHxKKG/BPt38Z7FBh40g
 CKKPXzy7A8BI0xv9C4O+aMVUPCU7B/0gA6NWiLeSRr7eoQxgj3jWnCMcm
 Csp8+b04aOH2JXLJuU+f8DT/XlqaNz0Xo2IcB7EFptmbUzEfV3ySd4tB1 g==;
X-CSE-ConnectionGUID: sdvBgUq3T/iPh7+rfDUpvw==
X-CSE-MsgGUID: d3JPS2RhTouqkyzH20oJ6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75703825"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; d="scan'208";a="75703825"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 04:22:04 -0700
X-CSE-ConnectionGUID: cZenLHfZTbSTki6sIVnJ0g==
X-CSE-MsgGUID: IQbXgZSWRpeOFbhp08Gfvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; d="scan'208";a="225209644"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 04:22:03 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 04:22:02 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Mar 2026 04:22:02 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.55)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 04:22:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ge2Qm2TYYptVJ8h4keX82M6Jq9Fz6FnrKfd3kdIAXkUwxiIZ/+sfGw0ajd3Lux7bla8Hfce7h6PVB2H6cZ/FzL+cF3Oy/bsIg3Cgv7xMljV4I26IIR1GM0VTDpx+Zk/7kKoBxaTpO7eY8XP8MaQ8GXtRBuAxoz4UQkAzHbRFE7qnhKFa19m0RbWGIYzgU1fgVtLJNQFKOjIvBAcX2JCbuygXtm83yr523I7+k3R2wgv1ixVXt6SNwekxIH6moWzlRf64n2hNpVgyR+8UAflX3X+MFLw9wKwKfQZYP3TfvgRjTwwUKRJXyuS80u1pgy2hMITRKBqbx1a6+Zw6R8pGww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5z2D1wJ+NXOb16vteSgZw4Qg+ymd6Tr+gfbu8dXQmqA=;
 b=OJGE+cjqdtxykYNAS9d7xlLKzWz3fes0mDP0E78iyf5DiLbyTcK6dmhlcp7Zn+mdUr3Kp0Y7DfHJBfO4XhwbhkB6cDeqr/stv3Z6bHcJ1W4JFFNWbgj/sjuGuGR2Y8NXMHb/9yjjojbhmLkJ3cVmgSExPqlckkmgjR6uIU1n/JqgFuxq+kHOgCV2b0bjMLRzoV4dzkpBI1lKSWZ+yOeHayCOW4l7SLSwCVfVQJYe/ZFUW1OAprGYq9LNgdcnlhHclDk85zU7Ez3trmqI1xlilRTySWLYArXTuPR5JF8fQvAX9XiEsg7aua/MW+/kQJi59YV2mYZEDi7TDDd9tqOC3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by SA3PR11MB8120.namprd11.prod.outlook.com
 (2603:10b6:806:2f3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Fri, 27 Mar
 2026 11:21:55 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::6d5e:e9cc:2957:6451]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::6d5e:e9cc:2957:6451%7]) with mapi id 15.20.9769.004; Fri, 27 Mar 2026
 11:21:54 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Burakov, Anatoly" <anatoly.burakov@intel.com>, "Richardson, Bruce"
 <bruce.richardson@intel.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] net/ice/base: fix double HW reinitialization
Thread-Topic: [PATCH] net/ice/base: fix double HW reinitialization
Thread-Index: AQHcvU1Wa6ALaVWRsk6M/DL3nXXrRrXCPRHA
Date: Fri, 27 Mar 2026 11:21:54 +0000
Message-ID: <DM3PPF7D18F34A1CEA1720D10AA42ABE2498E57A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20260326182035.726123-1-bruce.richardson@intel.com>
In-Reply-To: <20260326182035.726123-1-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|SA3PR11MB8120:EE_
x-ms-office365-filtering-correlation-id: e74474b2-d7ad-47db-79c0-08de8bf30d2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: nfg7lZs4Zus5gYY5at3XHpJSLo8F/fC/wEJVeCqDWk/UWwNRO0oI4397dIyLFJgbTgFz7DDNzx6WT41wOHmObK+KXu+WQVTJpshmiaAhtgTm/WrgRc+oNRI7lzTOq6PREbNaCReP0hc4WAh1XpRz1jxBi/64slKo7Llo9YJeNLP8hLLqmMT0MsZmULtUdUX6ixahpU+4GCRekv+z6ThL3eZMxIRIwKbWl3TTYivBKhCiEqOf5hAEgZGFKlh5efEzn8LmDZJiv1ZY+UCtzcZ1qk9YC0SkMhOom64OWtDDp5KYXh6SdD78OoTCk3phTqL91J3JFq92yYcQE+VYr1yTN41Fy7s0PFLivpcoXNmm3mnmazjBeFU2TP/7BoerIVFogSOkeL+JPUjrThZWtnTeniMsBLkHd8Mu7niYSnOOBt+ZZkgREJYoNJt9LiR3MpvWNH2mHpqYdA3UIIqQ2gIVBRtagkL/WVO92D8lA6gNsttqEDw+rjAm49Z66lIydQ/LaqbXzxbCb0CogTGbWDB3qLBVWqwjwNa4K+opTvIKOwHMkIjZkA0hgS/3NhC6yx5GMHwNuUJUrl5iCB6JF9cN+ia3lS5QBh5oKYMGOFabXvlmq7kVQhS24D7l8WaQTQU90+jmr3r9k7K2StCBtu/YYlqGID2ezVWsTZrKTGe98gCCC/AaiQE0TAKzuSwPKy7l3oCGhXda3S6cVr6Z2UUEe8uHeNZD6TXHNc0FlO8OnNtS775HLWf0h+FqFb8fclLpQGsHVE0uyKfCd2SgrcOCYfTbbIL4zZweC4P6xXpQeqw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?knL3SqpiqcEEygbE+qYwjzl1TCNcf73RIUhF3HUxawz4vOq3iEpht26Awov5?=
 =?us-ascii?Q?gqVCfg2lDXRQAN13UIhfJBMQvQ6l92sKAMAcawtg30daS+Dxnwz0ooHX5Yjv?=
 =?us-ascii?Q?zxcOrKoLtRTvk7IPGpcnFWf2P7Ib3rQope/YnfmeaIoRNkqlRyCfa76407Kw?=
 =?us-ascii?Q?cT9Z0+8cSALt5FrfdoOilh+zpGnokniivT2dzfBPaEvzKMlQbMNLDplp7f0f?=
 =?us-ascii?Q?RvaUUPmIwx8EW0vb54m17rhywPirHfYtbUMxCAJtBpNLwklQQ2ntpv8NYfmN?=
 =?us-ascii?Q?nvf4e432OK2ff3M5tpEDCC8ErSc4xtQU4fIkDZF/q+geOJutckxZgena28lF?=
 =?us-ascii?Q?cESvzsMxNdU/9uP2ebzPhbvjpbUBnsZMmPIrVAQV0gwJi+T8Rt4M4hYdd//L?=
 =?us-ascii?Q?zB2JLUcIgH/yORXyympkmHSGUUv5Qn1KDivOiyzUTlA1bpXBXmBk48HyV/Dx?=
 =?us-ascii?Q?YqNPR9W5xs7W3JRT1MEpQWsjmjHIEGY9E52hgpm3NooDeyb+IliW6U1GWxGN?=
 =?us-ascii?Q?kkeA/7RMUIyOiCaFv2+KEujyFbvhqmnXQ6YV8X1a+2kKsNJvRvm0a1wCu+Sl?=
 =?us-ascii?Q?x4RUbEfgyrAHBBD0ApD+Wpm9tMdpTqnhd9fB6q0M2I2riHBwRkNGHwVlM4SH?=
 =?us-ascii?Q?dKY93x6225HUbaLHNJyPeM5suckHE+7+HYFm6HowZehuw2A5w2vSzN6sWEQO?=
 =?us-ascii?Q?U6pZKNP+q/gef0hkdxEQOLy/OD92Anu2+HufJ6T41mxME4GX57Nsl/oo5sJo?=
 =?us-ascii?Q?PDgOWDnPzVgk2TEcafWlnALJodWb7ho4YZKP02wws8JSsbceeVRX1GMYcHjJ?=
 =?us-ascii?Q?ZkASjlOQ0DHUoRD2S4RjDXG1bwylaVnDY8AFohTVixHj8sac3Xq4h4B4j4hO?=
 =?us-ascii?Q?DpS+PeBABoB80Oh2QocD9XTj6P3YKIAGyiBXNk4h/IMygyOsJTqSG39rx5+p?=
 =?us-ascii?Q?2cmAn7mW/b800MltxjwsKFuid9YD0lHV3+kSWqHL/MrtuKS2rJKp9XL86afJ?=
 =?us-ascii?Q?kRhuMRjASYRSIJo9UMUVxbpaAj0NKI4REUEk8unZL4TuhPKqPNY9orITZxbv?=
 =?us-ascii?Q?g8UWImSKauQGqA3u+JKAHk88F6Q+SLxYQe0SbalSshBk+uSXUw6bcUhFPhBL?=
 =?us-ascii?Q?F12k6qXPSo49a2d7jq7yYPK2h+PeF9cZpk9rhQlS76hYAnTl+kId9imyJ9AN?=
 =?us-ascii?Q?RgXASgvtVtYyIq7qROqiE9UvLmsU4WpupC/ViNXpWx6qWzrcU8HLRa1KlojM?=
 =?us-ascii?Q?quf6RZ3n7YE07MkPeADj9YkwMmQKfc+/oAiWdzMK89Ztwoql5zWiMXRDX4au?=
 =?us-ascii?Q?fXHOz7zyYcidPYfV4nK3pnkNe6QrurslVXmJ6cC+2+1Z6QS7vm0Nj83Ean4o?=
 =?us-ascii?Q?nnzeQgQyPbudnBaH+raCZvSyJvNlZXfIIv36bevIS+3J4ciJg5omK28/D88v?=
 =?us-ascii?Q?8WZUkeA6kT5VymW+xfdUQ4h/5H6xg8i684LecIT23K3BEQXP42KO8RLia37g?=
 =?us-ascii?Q?OpC3Ut2wtP4CW1rrId2cf1QBFVapU4m2+4RoT233byBoelKIJ+rTFHhZ1WWD?=
 =?us-ascii?Q?wV1JrP/2qOjdjr8FUbsOwPUDYOstghyca6xxbNgvfEoYY2IsR+w+Bam5dYhP?=
 =?us-ascii?Q?u9+vcOfMx1kgGMWHEfmFZcuG8tIaBiFsZimEoqOLsYajf+aUlZD8Z6Zfhg1H?=
 =?us-ascii?Q?AeSz4qff5ZvIGVLEu7xL5hs2zwJ1nk0nZvisIG8D3wiS8vlGSC2A3ehc0HBo?=
 =?us-ascii?Q?mMERByM5tA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VjhQF9rzATSKUCvB2tewlV7USicj012IpknGQdtT7GzATVgTh7ng7bKJW9T01zGbM81qMSVTJPPjRv3cKD6PTSlegEPY7lISri72ovP+pKJT3uLTE+VsvBa7QgRJ4duZvKMrPiheSaV3mbD4oXZwYKHhtcoihgaw6/ZxGlxCUGxFAePUE0/6FKAaX8cOTTep3tRckHD4IiyKm/gmwt8NEfl/+cNBpyCoDjkW3CxC5oiC8Lq4fxZLKDV5wL0OJTteRpynqBme02p1ETJoeTq/LzLoAzpY/YwZMD71tbR69mXGSG1LUJ3RS7P3dnaUfBV/hJN/95nidnpDg+VAVovVug==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e74474b2-d7ad-47db-79c0-08de8bf30d2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2026 11:21:54.7295 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u/AUuzR3bmN8XpsRZesxPNX8qmf6gBIweiYI+Ta+NRjB2nX568NgOzSI9zndbuPrWfGvsa/n+1rI+iaESaF2dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8120
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

> Subject: [PATCH] net/ice/base: fix double HW reinitialization
>=20
> After downloading an alternate scheduler topology, the HW needs to be
> reinitialized. Since commit b47c1229d617 ("net/ice/base: improve global
> config lock behavior"), a reinitialization is done in the topology
> download code itself, so we need to remove the extra initialization from
> the calling code.
>=20
> Fixes: b47c1229d617 ("net/ice/base: improve global config lock behavior")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Acked-by: Ciara Loftus <ciara.loftus@intel.com>

> ---
>  drivers/net/intel/ice/base/ice_ddp.c | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/drivers/net/intel/ice/base/ice_ddp.c
> b/drivers/net/intel/ice/base/ice_ddp.c
> index 68e75be4d2..ae80d93656 100644
> --- a/drivers/net/intel/ice/base/ice_ddp.c
> +++ b/drivers/net/intel/ice/base/ice_ddp.c
> @@ -1359,10 +1359,6 @@ enum ice_ddp_state ice_init_pkg(struct ice_hw
> *hw, u8 *buf, u32 len, bool load_s
>  				  res);
>  			return ICE_DDP_PKG_ERR;
>  		}
> -		ice_debug(hw, ICE_DBG_INIT,
> -			  "Topology download successful, reinitializing
> device\n");
> -		ice_deinit_hw(hw);
> -		ice_init_hw(hw);
>  	}
>=20
>  	/* initialize package info */
> --
> 2.51.0

