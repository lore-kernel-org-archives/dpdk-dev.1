Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47C860A2608
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UkvopD2s
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BAA3740264;
	Mon,  2 Nov 2026 11:56:01 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTPS id 73FA14003C
 for <dev@dpdk.org>; Mon,  2 Nov 2026 11:56:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793616961; x=1825152961;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=MnV9D8F5OAQ69FbDy+OHEevKV0ybLkP7vucXSs4ajOk=;
 b=UkvopD2sJq9RiGICKSSBNywBx763dhlX4UdGQUjlD5KqlGyYqv5TmQ/k
 uv+IWiBPzRj0AvBXKhXz0JrYzyG5+Y0tIr75JPHqWEQ9P7WKmBBIf8msh
 VMpyxdYURGauwBwrQRpWuoyngO0YOTQQDuc7TwOI2BpdH5FqhxSFo3nco
 sCWN6S6Ag/OVEqCsJAWOa6icGsz4HLS55CqsKNZRaxN4BdaiBLx83MRB/
 j8x7fB5VxVaaOBB8WLPC80D2nKa6gseQUfW00lMxn5j50sSRGOX5fuUn1
 gmBWt9W9BO5OSU/NV+G+hNP13gYAkimIAjGeoVSJoHaCyCJppa5n6LPew w==;
X-CSE-ConnectionGUID: gkT5y3sLRaOXjhAX7Mrurg==
X-CSE-MsgGUID: fYE/m58JS8O2wyjmGDd82g==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2210849"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2210849"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 02:55:59 -0800
X-CSE-ConnectionGUID: VjrOOXX5RIG+OCAxDqporg==
X-CSE-MsgGUID: utlHuSoIRmqgbxETCn1YaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6082080"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 02:55:58 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 02:55:57 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 02:55:57 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.12) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 02:55:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U6xRjXZTE+1uQgtClj4aIwn/PMAxmeDkczM6eh+MWJTgvK/xlTgDRrAqBA5qxK0Mk/A5w6DaEsF94Mn28YSNp/TlF5i1/UtKhkD/O7KHfF+/qz51xiebTw2fjkedIrc4E+E3i0fvHzktFBSs62ftQVjfXjaqK2Nq2ONHRwSvgQOkA2Vck8KXKSQJthtnBmLuUnDNPP5JzMdztmLD5XJKt4EW5AWNeHZk/vMKKmu8oV1W2Lu4F7rdpNJB2+kUUOu9uM6UJZjJxH8ZDN7BSvK56K/yjUY2+fnovwsQJ3knCL1vxvDLflrGlZVq7J4leA2MPzU4PDI8EsHCsdlzkVYE/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWgNNrh4jEu6h7Q6lXzrKwc0Qdr0+GQrsdBn/fDTHAc=;
 b=xjbTClRyZnMbmHgkKldOJmS8+z+kYHhmUqdmPAmHSjXAdpUEQiLxd13Koz2+ehyySNIG1/991tY5DjqBA51d6t80Kple8O0lFbLJkbfys6qAxGIIVG6VmDyikceQWBZnC0PgMfYKo78sNxSTMCCPtTx4v3tZ1d49NJGihM0vW9WqvC48RkNupXMI9AUXy3ygxxiYjC49xql5Sqkqcsz31i4YAzSpN20sB1FjH2rwwGrp3bB1YfJdHoVmDnYC9VulvkG25x5bGZCtT5tATgjx2DI83naVlIfPKADY3BYThS2aXq4dTErvQU2GTLsFOHQbUs6VkhgXPCaURF6c8A0l4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by SA2PR11MB5083.namprd11.prod.outlook.com (2603:10b6:806:11b::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.20; Mon, 2 Nov
 2026 10:55:50 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 10:55:43 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Burakov, Anatoly"
 <anatoly.burakov@intel.com>
Subject: RE: [PATCH] net/ice: add explicit control of link auto-negotiation
Thread-Topic: [PATCH] net/ice: add explicit control of link auto-negotiation
Thread-Index: AQHdaHJr4dBtGTbzXkOAqgMyz8fG9rcansQA
Date: Mon, 2 Nov 2026 10:55:43 +0000
Message-ID: <IA4PR11MB927804496D3ED9C0A512C97F8E6A2@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20261030132616.2066712-1-bruce.richardson@intel.com>
In-Reply-To: <20261030132616.2066712-1-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|SA2PR11MB5083:EE_
x-ms-office365-filtering-correlation-id: f7cac630-8d2b-4ff6-4307-08df38cfd7a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|10070799003|23010399003|1800799024|376014|5023799004|38070700021|261026140227099003|11063799006|261028144727099003|22082099003|56012099006|261021123027099003|261026121527099003|261009223027099003|261021135927099003|261021121427099003|261022105027099003|10067099003|261022075727099003|18002099003|6133799003;
x-microsoft-antispam-message-info: ErcltO00LDj8rUrNbmMLFM10hR791UzvT/Gc/Fd1BO0kQmLmebHCCtk/O6Js7Wl0vTRiIwcCH2HLZg5W3kGVSoCART/VKFJByGkvYRydYaG6Z7adE23Z68qJOyaY7FSF4s+n4wI9l5A5NjFndVw2TC3f3wok2nu+b9YJ26z2+/N9f7lLfGhFVn3+KfzcwYLTDOGJfvqIGi4rPFIPU18Rz0e1/vYGGHtMPLsvA2+D2I8cP+VAQK18IvSc3LTDuFBNJpss4Y+d5vqZLMrJq7lek7mHyfNK/bqVWh0EAkh2KfB/ihF5DyK9PGTB/0cey4+eomevXnMqeC8f1nkb54SxzyMiiHse2MAnXhisCDFgpCz/aCXWI/MuAMrEReok2avt9B6RVonCSLK9KZJfo1jdmeuyDzEz3mEM2/QL3K5D9uwwdSmawCJEGA4OupQGOaEKBuzjXx37+8V7vzGLNn/EoE7ytEyP6CtM848qwH0OJbGTMHQ/HYG1h5qCW35kinfb0SxLEX1JuyH1RXIuMcXXMpmboejUEyVIi3SBMQzDPM8XWbKpJwPYlqjJQUJfFb7XLEJRJXwVIEezkBFF2lREmTynCrmjkxNt3GstUFm4DxMyRYbiG0jbZdvurCB8qVEmdSEHOmYaeFsrwcVE8JKc1L7Eu3xEQBZrrsEPuiY4xug/zbuJzcKg4QZ+0QRe3k+6ziSTmUEbDUGMrAZr64Qt3IfbT1flvbihxEEK1qNeWJs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(23010399003)(1800799024)(376014)(5023799004)(38070700021)(261026140227099003)(11063799006)(261028144727099003)(22082099003)(56012099006)(261021123027099003)(261026121527099003)(261009223027099003)(261021135927099003)(261021121427099003)(261022105027099003)(10067099003)(261022075727099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Xxh34Z9Sub7daUGjYz0XNUAedK45FRCeluuFvceuyZcIxw+TVDbPbRkwRue+?=
 =?us-ascii?Q?w06h1JTMvnTyWb9sjZbSMQy1C7IErp2UfexIp0+9Bl/VI4tKAGTcJc7thes1?=
 =?us-ascii?Q?NQ0flgV4pXP85b6IwlkSun8ol3S1iOudKBMIh7PezaWwr+NtFzkTBhSPWHgT?=
 =?us-ascii?Q?Lg/O68qM2Ls07E/uklH+KZ5k90LBrLwL7WE9hgD17KR9BpuPSU3eCfhYQPi5?=
 =?us-ascii?Q?paYc9c1MrCL8DuX2C39/S+qfWmr2XbPjT5lXUSrj8A0A6s5KhJ5nmcTVh2Iy?=
 =?us-ascii?Q?NBW5mTNrjD9AVr0KDk3q0nX4cSE+k3JGkDS99GE0BC7sO7EwkiV4GmpHI1y5?=
 =?us-ascii?Q?d1NgfBlc4i1+iAYYGoXJd83Eih/AQ+fPcCT3XvtdebnRSdNiTBpcs3iqlE9H?=
 =?us-ascii?Q?YwbPIHYXU5lNgcThCDmc7EMYHu2U/bf6pILndrSCmVYrxcNdNRrWI+eWu8bG?=
 =?us-ascii?Q?xxn9o7cVRX81rJxF8fdfyfTA3PSZ0uI9KRExhgzRmcX56EYv4sZZxVKXDTn0?=
 =?us-ascii?Q?y5sJOgIOXjsykm/bf92f4BJ1bgxbhMPCStq1eD6r8XmAAlGp/Z6CwOyeeKsb?=
 =?us-ascii?Q?zKeeofbumy1EQnhP0LKn+dObtMJR8H6Nff4kjmktRYhLnNmwiX4F+p6KqATh?=
 =?us-ascii?Q?g4mViOGWIuDkjhnWpihOoy3UK5n44Yaj2PCLOuvsLJ0zTW0R1DFoxHc1jMHN?=
 =?us-ascii?Q?iKqL/xfqxJ7TI6aVXoexi7OJ8CaAmGwFuszZfYcZg1iQNOkaOWrUS0OiOBx7?=
 =?us-ascii?Q?tKOksP8quOhO6U/He+14pL/zXx/V1W+dAwMHyAjSEX3QHBmUTxvS7L3Ptdyu?=
 =?us-ascii?Q?7zrwmBkawnBAxrofTBOX876DFoa/UV3WjTJTVnm1xlZHmxpLlbWNsJvbIB05?=
 =?us-ascii?Q?pBDggtjW9zvUydOJQzFhySeM/5WlzfeiMGKMHTEXjwrTqTA24cYT/RI8w19J?=
 =?us-ascii?Q?c6M0qeMCXOrFAXMwWHFIPheyvdzivqU8eaqIu6Wk9NMbpoUXl4inoBq/889Z?=
 =?us-ascii?Q?SZ9yDs1qdT5HU9CuJxLpwFFtLxoz+yjAguCV89x3BlT6T/TjvJIJbvyWnA7i?=
 =?us-ascii?Q?m0MQ2HwVh5IWH0h721ACbaBTZYuH5/g8/twfuEukNAYguaaQ8ws24FFkhWfU?=
 =?us-ascii?Q?rk6nLBiB11Abc446b5cmF2kuETW9deRUoTIFASe8PHgDIO56zWId23WOlAcE?=
 =?us-ascii?Q?ov9f6RWdSVQcCldRFC9mlhsdtn/IhW7GCSYUEz/9go66/jGQ3ED+GwwgzNws?=
 =?us-ascii?Q?E2B/Eopp9ngFH1GK8vUoteEMVfEmuyOFCB4wwTR9eBYX0xgE+mZHKlbkxCQW?=
 =?us-ascii?Q?cqWb3cl4YWidFbN04x8QylVF6fROGWd4qExHY40PGJ8Q7mM4ZXh6tw3GKPoN?=
 =?us-ascii?Q?Lk9d/ZQsW1cUuKdgRA+lSh25kMOyQ6Wgirte8yDm/vXviaz1a3zBdfbP5a2V?=
 =?us-ascii?Q?/TV2YGLotlr+ltJb5JFWHwNEXJg3S0IBVljvroM9zFQFgytEPmOW7Q078AG3?=
 =?us-ascii?Q?ml29OuRQOpUkYQNPAx/IM7FTjdpHP1Zu6SluJg66jTotNeda6+c/sYYg+3Dj?=
 =?us-ascii?Q?4DMP+Ca7uqUdFm67ZRjE+BUXjQHi7zuQTKBh6jffKfZnTLhbfLqcaxhWvrCX?=
 =?us-ascii?Q?7a8FI1vq9QmM+yxmpbRyb1d/3jxNU89yHYHsoGCK74OOJmJbRscIbknXUXMz?=
 =?us-ascii?Q?1S2wEyuAYtPnFMDvAE0rteqLL218IzFPOa0tlE0x59BO7+iyC0YyGdliVF4R?=
 =?us-ascii?Q?yXQTtndim870tZrqNG/LM8Li9bXBZNNReNAWVKej14xgI6r1OsEwxFZT5wZX?=
x-ms-exchange-antispam-messagedata-1: T75hUqW8JuVuhw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PIpkfAuggQCYk34jVzzuDaN+sOjjtCxtlPF0pcRU4HKR1hP21NOmdB0D6WY6K2+Rua7lGHpcaTrLFUNL2mFhce7WQq8rxfr78vQysX/VgUJWtNF0p0JgGwnprbbvEd0qzuc41dn5B1/voIOAJuUQCFfZc6Q7a+v+SM+Zz7Br32hM7bzXJXilxWqTN2tNCETuMq0k52poO85mx7NfwktYOD4T6BTmxQB+96z0GDf1mdrfVOTWdVEnCQYHOg2L2g+kaDXO3c6zMdUgu53MOQi3IKLX+rxeAJsEHfMasU6x3v2L02FXCpJvwewznL8jf/UDT33KqsAluE2KGC2wYDvpOg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7cac630-8d2b-4ff6-4307-08df38cfd7a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 10:55:43.7163 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hXeAP6SannNryvBBn1BUUPkRqwlfc9QO2vCe8PQ/oPwUI0dqRvGyGupxvTnTopbz1MQ/QmtxIIZE43YsWAht2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5083
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Subject: [PATCH] net/ice: add explicit control of link auto-negotiation
>=20
> When selecting a fixed speed of the link, whether or not
> autonegotiation (e.g. AN Clause 37, etc.), needs to be enabled depends
> on the peer link. While commit 3dc2933866d9 ("net/ice: disable link
> negotiation for fixed speed selection") would allow link setup when the
> remote side also has a fixed link without AN37 auto-negotiation, it
> causes the link to flap up and down when e.g. two ports are connected
> back to back and only one is set to a fixed speed.
>=20
> Support both scenarios of auto-negotiation supported or unsupported on
> the remote end by adding an explicit driver option for disabling
> auto-negotiation when a fixed speed is selected. If no fixed speed
> setting, then new option does nothing.
>=20
> Fixes: 3dc2933866d9 ("net/ice: disable link negotiation for fixed speed
> selection")
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  doc/guides/nics/ice.rst                | 10 ++++++++++
>  doc/guides/rel_notes/release_26_11.rst |  2 ++
>  drivers/net/intel/ice/ice_ethdev.c     | 12 +++++++++++-
>  drivers/net/intel/ice/ice_ethdev.h     |  1 +
>  4 files changed, 24 insertions(+), 1 deletion(-)
>=20
> diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
> index ca3a94655b..af36341c9a 100644
> --- a/doc/guides/nics/ice.rst
> +++ b/doc/guides/nics/ice.rst
> @@ -107,6 +107,16 @@ Configuration
>  Runtime Configuration
>  ~~~~~~~~~~~~~~~~~~~~~
>=20
> +``auto_neg_disable`` (default ``0``)
> +   Control hardware link negotiation when a fixed speed is requested wit=
h
> ``RTE_ETH_LINK_SPEED_FIXED``.
> +   By default, the firmware's negotiation settings are preserved,
> +   allowing a fixed-speed link to use negotiation such as Clause 37 when
> required by its peer.
> +   Set ``auto_neg_disable=3D1`` to disable Clause 28, Clause 37 and Clau=
se 73
> negotiation.
> +   This option has no effect when automatic speed selection is requested=
.
> +   For example::
> +
> +      -a 80:00.0,auto_neg_disable=3D1
> +

The approach looks good to me.
Something my AI review flagged was the setting of "link.link_autoneg"
in ice_link_update() - your patch doesn't update that setting, and it's sti=
ll
just based off the dev_conf.link_speeds value, and doesn't take into accoun=
t
the value of the devarg (unlike ice_apply_link_speed() which accounts for
both). Perhaps it's not necessary, just something to check.
Once that is addressed or ruled out:

Acked-by: Ciara Loftus <ciara.loftus@intel.com>
