Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BB3C61DD3
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 14:05:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 017BC427BA;
	Thu,  3 Sep 2026 16:04:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 1FBB0402D8
 for <dev@dpdk.org>; Thu,  3 Sep 2026 16:04:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788444298; x=1819980298;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=Z+fgdidkz9jo/JnIbpKYex93fLEDuazrNe7w+LmeCGs=;
 b=CkWnsQeF6jPFTqs1oxfiIZjckoRNBx6rBnyYMSwleFWn4lHI3HR1dKHX
 BqJfVYk/KmyBpYLbHAmUSyfIw0hn9u67H255WeKX2wevxfrA16NMPW5Zh
 xMVyeJpVAJvQl45eosqM8zx/QaRM0TnUoHgrLwWOyfPDvwD8v65YzbUQD
 Cwx4lLimviO/0mRebx24epHCqIw8ZfCrPZzFasSSSz+KFhQlKycDViPX+
 dOkC5y9PQWUutkX+9KdCyopAezH9jWbniTYv7J32zbX4f4ZVPbcGiF8dI
 zu+IeQHvapKMcXA/60s3S4s3ATHpgLBySmdgBXYVKnxW6vlOlzHZquQKo A==;
X-CSE-ConnectionGUID: fEJHv4gMQLGIinjvodGcYA==
X-CSE-MsgGUID: v7qUyoo1RWeDzGK44JuH4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="92795166"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="92795166"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 07:04:57 -0700
X-CSE-ConnectionGUID: iCHPvRHmTg2PtkQkA7X+OQ==
X-CSE-MsgGUID: Eith3OQgTpK6skBTwEE+gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="275009758"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 07:04:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 07:04:55 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 07:04:55 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.59) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 07:04:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m2zkvhdiS3WQSmfnHQnEiFrt6jPrU8qomE2hNjmwxZ2nQf55MzzDgGYzbH9eSM3N9/PG8OyQm6R4DfKf05WBOD3d1a0EZEcGAmGHWis62skMp7JwpyjbjuMTf1AdayuiLYEYeSiWDvNJUzDYyKu0S0M85C/IXj/vpFxQL5M0YdijR1Esu0NnRK3m6+HNngLz/CQb2VebqZTz/Cj2S/CKsHzbisJ7sC0lwV2o2JhTgal+Qgf5zstSOyqtDpfXen0Pe3Nrw/IQqlNHYNFyA3D5bZOM/STVg6RYIerfoa/QrZ9S0rOkgHkWUmB226EFfu/Z97UjLoDaJCmY/+mZGiLbPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LS3ykRplQJIFoQ2UcfY1JC7+6MiihEE6QKpl5uOpmjY=;
 b=J+AUt2NscXk+MudoSpepgmDw8B2nFMbc7EStIoeKMC55uf5UEZJuwE+33xI4BYts9D4ZZpMFFkp+KKO2M8xHFwl9qw7N05FYS/LxXbQGKFnYIkqx08W8iONCepAqeO3AXwsooT/uBTpAIEG1YrdJkgdygPzPT0ILU4qtHEmmS+smzeTjaJproJv68aIVSuqOCPrF28bvyvUOsEVfj74F7H7/diBc8fWg2rvBCD385kmeuQKtNsQu9R/JKH7o7ABdua3stqJ2nESZh5nP7S/Jbqd9bgQ18cI+wPqh2V2ofmcx4MP5Ri3iecvZ6eZ0eAy+fV26IsKPr9XST5I8HXNnig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by LVUPR11MB9566.namprd11.prod.outlook.com (2603:10b6:408:39e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 14:04:53 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 14:04:53 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH 5/7] net/intel: fix VLAN and QinQ tag position logic
Thread-Topic: [PATCH 5/7] net/intel: fix VLAN and QinQ tag position logic
Thread-Index: AQHdOTNOcrgD0R1P00y8XK8TOrZ7ura85qfg
Date: Thu, 3 Sep 2026 14:04:52 +0000
Message-ID: <IA4PR11MB9278DA12DA08E052FAA2299B8EB62@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20260831102621.495759-1-bruce.richardson@intel.com>
 <20260831102621.495759-6-bruce.richardson@intel.com>
In-Reply-To: <20260831102621.495759-6-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|LVUPR11MB9566:EE_
x-ms-office365-filtering-correlation-id: 2bcec3aa-6ab2-4eec-c113-08df09c4538a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|10067099003|6133799003|56012099006|22082099003|18002099003|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info: 5dtj2kyeiO0+PQf0gvoqsjnHQcHXSafk/1P7h2Eep6NJT9gIIuYrk/g3sQKGQOot7hgXK1XUpQrEdYnzc5nafs7Txhh7XXBVMa/jbiVBXqa4oW0Xx/wCwmmYGLpC3BAdULtIlPmWwsvpnHxb+eT4zY0316Dl/U3DrZYJtJzKiU+IzgWhG2DS6QDUA6FFWggWEaFXsFdlSRtBcKv0LweEHfYpnz3t4+IivbsWjz4Zui88Yyq5zL2ToAZE4XeRLBI2rWUXmHN+Rnbrh/XQ3tJb1c52PMHSSfgAZix+xMwgAwSFfmdFNTQ+kHKm2VjGz2MGLrD8fzr6YiER7dk/FByUa5F/EbUztfVmCgLfbrCsBYCgfqnnNPSB19WJqZzF62/sAIR/dV1vpEUxEuu2m/Y4Yxp6EMWjoAN6N6r5HsE8ozkLJmhyZA97XIqVVgNt51JlRlZzMozAwgzLV+yhOyW9eGxXzIHS68uRhxOTzjUlc6juKhZwvXTp5qr4qZpe5dzX4QO2bZyCBUHS2GPfBfifcOY95mXLSMRXVO5z9dx7UbK5yGFRCTLybuJ3qNqF8A6P+xuKQ7ybK4TSe9nDfyh+M2fH6gWBj77gtaJlwf49uVhQhXv7B0bB/a4Deq4d2lLpbSmHRcQaZii2OqOY2QpTiJTWp0h6xNQc9TijFJtZ4tepITVEmyTiRoWmopKgZCwJFh2t0w7rwaFasvUlr/yzUlfQXsQE4WjEFt/V/IBPdPs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(6133799003)(56012099006)(22082099003)(18002099003)(11063799006)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sONMgo8tXqbRXvd+/1KjUecKYSjZA6JYBT0Ei6SRD4Xlvk4sachJF6z17Q0Z?=
 =?us-ascii?Q?7aLeyJ6eUNQwK1h+U4Idga7kr+lfBgEEprS06B3sEZ0gwXBvyVw8rDU01q2x?=
 =?us-ascii?Q?T5zMyZcp0KuLWgtqH9D1ubVPbJFSxJDcpoFH7MNz5LVa/r4CAChpEMawMq+l?=
 =?us-ascii?Q?Ih7wT+BpvXGytNWyWIZ3rN36ognTvLbk7E/TZvYjVU85ChkDy8tmcylyHidO?=
 =?us-ascii?Q?6ZNbzu34wvVNTDtw+OYiTyvVfCbFI+wOkvHGr03DD41W6uFlRWs26SWTRoP+?=
 =?us-ascii?Q?YgJ0ie0hB9/Wf1r7dPxpyBJErRwD88nkS7Wjvse7XWpWmh8+bkkIKJtrsreX?=
 =?us-ascii?Q?+Jzhx+MqgWkQZH/QlLeUivhTlHwy5EKgEt5iPE054z4IB3SmXYBTwBbzvTv9?=
 =?us-ascii?Q?xrd1ALy65UWq0ox4rGZ+pbhL1f9UT6tVTi6sJPVFd1L8A+6WN7nDS9GonX9v?=
 =?us-ascii?Q?6JUkBqvaL/b5prw4ylRVcT6rv8nO1Ngldfsy10Wmebv3ZBwXi6Aliv3IFH7Z?=
 =?us-ascii?Q?8KqK6EQ/e19kd5NyGQNzgNFAbX14t5FJR9TXG+i/VkmdBi/hu5V4GzeTfkmh?=
 =?us-ascii?Q?VW4bLAhtrvPVXWAYGSw10F9tUbHMVSq9/Rxhi7oWWCs+eddDZXorVEHFxy/4?=
 =?us-ascii?Q?eLE0RM1QT1IiI7/336Nv3Wd71xRUKxxVXAwxkr/j6RI7WGeurUGCzL81VLAM?=
 =?us-ascii?Q?bLtgJ2rLLnJW2L7vbxLjtXvXQNXzCXdBHqOaCftf7NCEviVxXMsZG1JoCWBc?=
 =?us-ascii?Q?BAysJbbveeRGY3j/YQP4v7LRhFrkOipUQKYmxvNId4xUF3zpmP99BlFi64xC?=
 =?us-ascii?Q?xZj6hgeQzJG35q3Y6wQaR0n8bNMbwRsLgJzdkE3QlrwaW+dkiV5+ns6NxVom?=
 =?us-ascii?Q?uWPvplBqcVH4w1NtwroxCgahw8l/NuzqjUIjNn89yTbtcTxQcJh8e/eA4+0N?=
 =?us-ascii?Q?6WAw8TLfYrp9gfUEwP/cui4XAXIOfCqGZwQSxOq9+M+LGgRUV066rLD8L+yk?=
 =?us-ascii?Q?lIVpquGSa19H2peNZe40Nlb1vpXT9O/t5TU7ZK3N0sobE5lFEITKlQ+OA0cQ?=
 =?us-ascii?Q?NNlmKd5htNjxp1JnxClLH+Y/PsMntJGRFWI/k7hZ5NJhcGKPxKR8BUiVGTR9?=
 =?us-ascii?Q?bqBR05g3wmwlhfZJVHkLhRxx764A+AIyEp/gF25QM9Es0EdatgdWJHkuS2CS?=
 =?us-ascii?Q?scGQFxfGVflepIhIfEb8IQZudw5qRB9yxr7A8NjzO/0ZanedvPYppJ9dkm9s?=
 =?us-ascii?Q?vehVyJHhf1wWdoRzi4CDQsQiG/EOTHcCfAaZ2SzZD7oR/XOxKSWA3CPcxhma?=
 =?us-ascii?Q?17tKhY3TVCyU7V79SjhkvdYoYjvPPRxQtm5bAhB/X2msdlUSZortlaPSxS+t?=
 =?us-ascii?Q?tIrvUIDOGfkoV3up19ElZ0068FJ4tS2zpJ6GvVc8UjZBntWPmW5x2Wh9Lynm?=
 =?us-ascii?Q?OSop9ijBDY2ipBXLrB76Q2h3EV5jtUYLmlrm+DJzFCMaeWd2IH7V1XpnE93o?=
 =?us-ascii?Q?g7OB/MegY0KNvvEMNc5oWLfOPA9roYuMuxP/WYoxy8lCfryMvDwqVZbdNXfz?=
 =?us-ascii?Q?zC70Q+FvQlf9sX4Ir0EEJCXbTFtvMnneGjW55OVavdGu/JI9WfwsXOYfCrHi?=
 =?us-ascii?Q?m3A/J14pXJi+LW/o9rnzSc4x3YviOvvDQvAY5k+iamFjsC6z7jaA2tOY+BkX?=
 =?us-ascii?Q?UPC4HmgvHUrzD4jco0w4GuasGq13VzRrxzkRiie9Ju/ZpOA7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: c1wAWNNb/JzxivD24RyicPPdqwQsf0N+z6XsYsMbVst1+wU5IKyhOjlxn03IFkE39x+d48QHVRB5Cuv/nOLRwYC6orp1FfDOIvHnyN7EkByAdpEgnaDVUQ3xXi5rvlnml0mr3LAo9QPi2ksXKj03sDuuqRJRfggtsp6LjVcxiShcgWqlMUOm8/9lAK5USz4+ht45YabkqPjF+C4DoDv1rYGW8Ex4LYbw4/KxDo0JuG36VvIJs4xMUw/4KbbjnuCY1wWjvma1n6SCQIIsRqmzg8pbGoZOqMaTKY02o3qNhqjOg1+rVU4MGkm5xIA4NgBVUWEutaELEhIZ4b9xIHZFuA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bcec3aa-6ab2-4eec-c113-08df09c4538a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 14:04:52.9167 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eaw+bqaaWaIqXTOab+vBWjRKBdQ04HlB8olwsRjLHZUAXQ+42mOo0rqr5QZtjc/fQQRZgutNUf0WOZxDYFIPnw==
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

> Subject: [PATCH 5/7] net/intel: fix VLAN and QinQ tag position logic
>=20
> The position of a single vlan tag on a Tx packet (data desc or ctx desc)
> is independent across drivers from that of where the outer QinQ tag gets
> put. Therefore, these should be passed as separate values to the common
> scalar Tx function. For i40e, ice and idpf, the single tag can be put in
> the data descriptor, and for QinQ, the context descriptor contains the
> outer tag. For iavf, the tag positions depend on the capabilities
> reported by the PF to the VF, but the position for the single vlan tag
> and the outer QinQ tags are the same.
>=20
> Fixes: 6ea6d67bebfe ("net/intel: support configurable VLAN insertion on T=
x")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Acked-by: Ciara Loftus <ciara.loftus@intel.com>

> ---
>  drivers/net/intel/common/tx_scalar.h      | 16 +++++++++++-----
>  drivers/net/intel/i40e/i40e_rxtx.c        |  6 ++++--
>  drivers/net/intel/iavf/iavf_rxtx.c        |  7 ++++---
>  drivers/net/intel/ice/ice_rxtx.c          |  5 +++--
>  drivers/net/intel/idpf/idpf_common_rxtx.c |  3 ++-
>  5 files changed, 24 insertions(+), 13 deletions(-)
>=20

