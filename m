Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746F0C61DD3
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 13:59:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA94D40647;
	Thu,  3 Sep 2026 15:59:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 23B16402D8
 for <dev@dpdk.org>; Thu,  3 Sep 2026 15:59:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788443990; x=1819979990;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=T0BqEUn2Lk3IyO59jOSm4zRHnuOT8F8MOrKiJvrdQ/o=;
 b=hRXDkY5yIXdzGQzM+d9I81alYS+47qOqaaBy/3s/L1J2w8C5/d1DpoAh
 b/ua48d+KqpOozXWcZUM7p/b/+INr7Lv4J1MAu9qTrUKtjgz+C7C30vKE
 sbFqKPPh1lr9jl6YIctzGBBK1j7H5ZG0vHlDte78CdYJjKZd6bkf560+w
 Z6dNnQWHNouTpVF2ahVMoK227Bu+4giRVZlLnJYyD93vuZ4WL+aych29I
 yTmjT66ciXbUaSl3xY2v9OEZQFY4QmUPA3Aj6sVU3s4cuNapfMwI7VELI
 4ZQJISsCfXKVgNtOQAilateZM2sMsvT0f+vX1KO+rmbhPpdCiKdQySUOC A==;
X-CSE-ConnectionGUID: xsSQxJV0S7ecXyy21XaSGA==
X-CSE-MsgGUID: xW3uz1f+T/KTLB2mAYJYRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="100284275"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="100284275"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 06:59:49 -0700
X-CSE-ConnectionGUID: 6XIuTOXrRg6ZnNeXbAPlAw==
X-CSE-MsgGUID: KbDmZ0ZAQCa1qmmRnnakdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="269198747"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 06:59:50 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 06:59:49 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 06:59:49 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.23) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 06:59:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iYfVTvv2U5jepdka6AAhH++1MCDt3Nq2Q4RIMvIEuA78RmxHQVaE34U/s96bwcAETeLplk8BYx13yM7AlT/nXPGP2NS+snvYownEvG+8+cSHsXyIkOKGYqiAiMZBm9J9lM2/ztPQK6sQkCyQoXu//zK94T/dF7RpGocNyhzCbzEDZzUVNYl5wzItcV2rqdtUmxZTG790s8FZT8QpyN8n3dYfjI9KJi/QHL3zOJGb7OmdsnkaA3iwWbu3mlTCEzcU52gX6dECQN1KoGFKhzPi4aBkh/YMlXhbwHEIGONKCYJalf/djjyAiavfKh09dNIQoufZqnDmuoDPNO/Hs/ScsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=urJeuJWEvQz99MAsrWKWBZheI6YBDGgB0t05LiItOuc=;
 b=hlbQ/8l6Etz5vgzRWYLctei6WNWPeZPD87/ylnAClD6jyzJBNgcuBRWzz9M77DzrB09NC2mxY6ZCYT1WDu6nRGA8sOilvZSkugEcTn6/u2I8K7R1XFmdyT3KG7VihBQZxfE6DXMn5yznA9xTyF9ktQ+ytfgn+MsMrq+JsjSglX2Xvk0ug3s78/STyNNnMnm76S1Wg4RIihyXICPFL9W+C3SJ+E+NWNnIw1hvpB1gtfW6oWrREessNkFwshEAVdbxj98jEOWO06R75vRvqqD0ebkIVX0LVIzffutcRjyqY6Z9kkN4KWWX1SWLeBO7MK2ZJKEnqnh9RR4SEsVUFP6Ngw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by LVUPR11MB9566.namprd11.prod.outlook.com (2603:10b6:408:39e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 13:59:41 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 13:59:41 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH 2/7] net/iavf: fix VLAN tag placement logic
Thread-Topic: [PATCH 2/7] net/iavf: fix VLAN tag placement logic
Thread-Index: AQHdOTNBbRepQIw4806dDSRtDPUgdLa85lnw
Date: Thu, 3 Sep 2026 13:59:41 +0000
Message-ID: <IA4PR11MB9278305B39B73264265CE9858EB62@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20260831102621.495759-1-bruce.richardson@intel.com>
 <20260831102621.495759-3-bruce.richardson@intel.com>
In-Reply-To: <20260831102621.495759-3-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|LVUPR11MB9566:EE_
x-ms-office365-filtering-correlation-id: 9059067c-d7b2-48b6-808a-08df09c399bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|10067099003|56012099006|22082099003|18002099003|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info: o7vVyGRX4IFoXUCnDPnoLocMvuULklq4Adk39mL03Indqa3PhK0MD3IFSa8/IOltcrBhfHx0doX/0BQ+ZhDx6RN1e8OUYPS8ztfWyB58Z7M1ZyvbxMDUoYDIeRUhX9traCf/K9eVbAI8gEvlnosi7o2q828yLhBABvU7wtyeLo43XaTu5ndYaTcNqzoUHcqWCjmW4P6LfbIIQ1JdyLHGhc9e7qPLQhiDuZ38pvVnfENTU4Gf2yxuwt416jxgWrRCzUVZeKO81Kk2HgvrxriuwYWFb+uBWe5W04NxEPjLRV5h951wn1x0tACAUIefcaYIMRxbj5oHtORqIEmyXGklRpqoUEsrvISgCmHTELbK8VrK/tbTxQ4UvMgjJH7JMKTWgllFlcwSQ1Xf2L6jKRMYtJGimdIZ6qmpVRa8bzprNygmYLrprtnfN0sRAzgkNNx2+4r6HZokeU0mNj79dfvQyO7z7WH7vZet526hwDYMhDgCLSgxaLOuMjtjOJ4Gq38Mur6jgWRabOgWMcpvsTsKxwRYahF+y6O49z7J0SNJ2Capd+cJjKLoF4UI/Wtz2VZPoy+GeX1Xfjo4DGWx9Zoh4lgIpc0ETMeG/gTARqQgVviUKTA1tiNWIkmMFbfaYdReznKPGJB0T6jhC2oUmfzbpA0MwmZvdreHwQGLM8lnSbVWCklUfEQiCGesLMbwcroKwwuVNoqn0IQuvmztDQyThVKD7NQYJOv+nuPXBdWN9Hg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vfS5y7Dm/Y+is2hPQBvA+kHveBuJsPdj8Ab0nHXVAvllZyAYKdgT8VJTW1eN?=
 =?us-ascii?Q?gXuoETGAwxuokaN76+vHeH772vnPqk49QDD3Hs2/HzHJV9kXEqNJ7EXhgV3F?=
 =?us-ascii?Q?po5gvCB7+T1d1qMsPigVf+b6Ofm38ViZJ7zpFMyYFCpdAiNQd5vQparhrlex?=
 =?us-ascii?Q?TNzOHnz4aFnDE201oryUTHSjaqjm673YhmTUajoWxybR1zaQATEmKw9gpJR4?=
 =?us-ascii?Q?uObky6/q8quKGS9l6Vw4VIn1LvJ21+tuvJs5sBqwKafHCe1DfBqmvxqJkj0u?=
 =?us-ascii?Q?/kM8PoxO0nLms5yOcOG889lGF7g9VGJ27p6eew8AmbM1d7HUAW19ngYi51SP?=
 =?us-ascii?Q?cacCieaV+A/+MvhqzGjzZz3c4+0eg8u/M70iiZigsmQ2ykVkOAtHGUWI4HpD?=
 =?us-ascii?Q?afMNUVysah858r8+A3U3DjflfqVZErHfouf1pHVJRvlMfhUmVyZiNgMPYuHt?=
 =?us-ascii?Q?LTXD/H89LTxKAVRp52X6jADc6+xoanevkcVuVoXCQSp0TYP8MLgXmvH0IHGP?=
 =?us-ascii?Q?BtReHTrhbkFTAhXduJwZytp8yaW+30jpixjMvfl6J2JgJqSobxvjN+gJBl4v?=
 =?us-ascii?Q?Zufg1iMqiB1810kAGSSpP8pYMuhhYKP4PertHDKt4JGHFCBz54qvpQvMHO/t?=
 =?us-ascii?Q?6px5f9oDCvSgoKsgcugOTn36PieyJc1PuzV9hVhM+Rrw32GTliOr/lZ+kFkX?=
 =?us-ascii?Q?D/H3q9Ca0AwZ1C/oClxWTHBOwFM0SBAus42nOZ39i3eaMdUWDuyOSX7YbuGl?=
 =?us-ascii?Q?Xij/VAdx07atgUldNxCY3su7RFDUkievk/dF3srDzvvRmTLCUUFLU754joVi?=
 =?us-ascii?Q?NIilZJhku3jrS049MUsUzNmc/iljoQ4Y6R3UlC5TLzu8ZOkq/PczU3a9iMTR?=
 =?us-ascii?Q?sY1Dli31co1CiyjG4n0iASzCkaFS0AxEFmrK7Lpg7Aa/zSjMVZ4srzsvcsyZ?=
 =?us-ascii?Q?zmWFXHN9fq7IfPHQoHRilXYFQ5E5oZIz0EZ9Qarwv+DikbUZsDD5xXHzGyTP?=
 =?us-ascii?Q?oQQrS+JxNj0iNuWh9Fqg7J85tzBRnx0jyhCemVrt9OJx68mfBXSb3OU27ENn?=
 =?us-ascii?Q?YoEnb5Y65HQ3yCf87yaPVxR92y+nKfbehgoi1rCNBImKxyfLMNtkaes+Vvoo?=
 =?us-ascii?Q?b24ojzD66NJYWLR7D1hW69UifTLcwN8se8C6eO+CshypIh/IEk1Jc25Hbnxb?=
 =?us-ascii?Q?qxKxbBZsCZcjyxVHEviWgWrLvVkXAsjCizE73mS4VsBLO3IqP2ZufPEamTYC?=
 =?us-ascii?Q?OTgjiRhVRysl7f8d9hm6mMHsnvxmz2dQgJk5IXeQ0OVGpPBixZX1y37niVcZ?=
 =?us-ascii?Q?qkrfZumEYTWtwXx/5sZWgCaPPc50ZJJSyGpGb22nZa9cAJJjrRXbY2a+Y45A?=
 =?us-ascii?Q?oPhS7vWSdhGL8KyVcS+1DZELRjrsuL/eGBWn6RgYqo+ujlVeaUo/Eyj9VFz8?=
 =?us-ascii?Q?YuCIgQ3Azm5qJyJaq/6kgVfCE3w85GFPN/VDrQCBhppu5Ys7ERUVrc210VWJ?=
 =?us-ascii?Q?YD0f/oMsVpq0i7lcS7m0mJIxxBIuCSXpV1PEs5fi/d4ySLsLkPLPS6Z8vuLA?=
 =?us-ascii?Q?nc7jZ1UKMY1J0j7MQDln7Fv89izvCO0iVZh08m9WIdez+S3o8l7wP2gBd206?=
 =?us-ascii?Q?H1djY8Y/kagrFuaLQFqD6Cjf7cZ0dyjWUAXogF8sbis34Rl96FOS4S5joCoU?=
 =?us-ascii?Q?JOfuINvYLQZnOxCQR6ZjNwOjS1QuywPNMA4fIIcRpyZQ4UkX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gkuIexqWZZLKa9h3Tipjn2WFmKjv1RsUhVDJl6LqpZiyz0ExEhPRrw3jn8nQi3nidRKGKtzEKxmZE948AyiLbGY5iNSTfu9c5xc8Dnz9Rb3wlHg0un6G/XZCceWaTAG0fbEFiRplCpaSSn05lQNaUcK/XFGUeqWDZsFOH8zOpNbXzCfbg52C20bYuPyRA3KRRyyCiBgAT4WSuCCcYCFuLYzY2oquPMSRAv264Y6qZSzd8Yu3elJGL3igkvJmsaI+ohGk2pADJPdSWAJQv+xIgO0qwe66YTBDmGqQJzk3MqB0UhMLyMlE5QoLU67cgtHiumdsH1yI1amUCOTSFIqcZg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9059067c-d7b2-48b6-808a-08df09c399bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 13:59:41.2268 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bCsTh44TrzQF+JVPc9dTuVXwgkogUVqOndkS8pZiS3k8jXAmBLd4al4b6LHIh5/cwkEDCUqAqkyULfQ8KGnHNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR11MB9566
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

> Subject: [PATCH 2/7] net/iavf: fix VLAN tag placement logic
>=20
> Depending on what is reported by the PF to the VF the VLAN tag or VLAN +
> QinQ tags can be in either the L2Tag1 or the L2Tag2 fields. This needs
> to be taken into account when reading the vlan tags from the flex
> descriptors, rather than assuming that the tag is always present in a
> fixed location.
>=20
> Fixes: 1e728b01120c ("net/iavf: rework Tx path")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Acked-by: Ciara Loftus <ciara.loftus@intel.com>

> ---
>  drivers/net/intel/iavf/iavf_rxtx.c | 49 +++++++++++++++---------------
>  1 file changed, 24 insertions(+), 25 deletions(-)
>=20
> diff --git a/drivers/net/intel/iavf/iavf_rxtx.c
> b/drivers/net/intel/iavf/iavf_rxtx.c
> index d65a518f8e..39bcbebf56 100644
> --- a/drivers/net/intel/iavf/iavf_rxtx.c
> +++ b/drivers/net/intel/iavf/iavf_rxtx.c
> @@ -1151,33 +1151,32 @@ iavf_rxd_to_vlan_tci(struct rte_mbuf *mb,
> volatile union ci_rx_desc *rxdp)
>=20

