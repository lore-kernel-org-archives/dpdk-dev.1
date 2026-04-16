Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634E9F8D74C
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 14:04:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45B0140297;
	Thu, 16 Apr 2026 16:04:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 8C29840144;
 Thu, 16 Apr 2026 16:04:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776348289; x=1807884289;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=3OB1Mof7SN/t1WRFpJafHmerMG4HCEYcF8ZNSqELh18=;
 b=OWxdmi36LDPFzVfR6b2i+r4GKGlzptICfimEDGQDB5UtZE7gyybfg41j
 gkyzu6zHNBjEjB5erl+tZ9w6oBRW6qEJQT70f1xlrWNJQJpooixUOEHEA
 4oQf00j86YdWb1moG2aeyobMaNm4c2CpCQXu0Vymvx9K+9XFeL+4wBxW+
 gBYG2ira7flBPWzEcJSiVQRsAfXp7CE+Bcu6moEIsoXigdXAO1ICMnlS9
 bLoMX4fft4BjewUYBjIC2EJDmncwnqHNzM/bMfc7zIsKrtjorGJvtVrk8
 67TWhnli4r+IagLWgXHkkOgGJOhxvdEGe0jGW5UXt72mVbkslNtgJbooi A==;
X-CSE-ConnectionGUID: yHuOlIYpSYyGWP9C8rgUiQ==
X-CSE-MsgGUID: 7Jorw04oRaG+j6NrSbhxCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="88047504"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; d="scan'208,217";a="88047504"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2026 07:04:47 -0700
X-CSE-ConnectionGUID: kKMq77FARZ2vqnawVTRKHQ==
X-CSE-MsgGUID: lzFt6ICZQEaTH85qhEfOKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
 d="scan'208,217";a="253984767"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2026 07:04:47 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 07:04:46 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 16 Apr 2026 07:04:46 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.41) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 07:04:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fyAI/znmAXjJWVrFuJPsm3seqpeouKVfIcvQnBwjcJer5xoa77dYKra7+K1gRIahf+M3+vaT2ue/++imGtroa7YnLPcIU6ZfsavSUooQJkXx3xzZHIKO0CddVYG97qJDl+DUzLwLVAm2xgEPlhR7rBbxfeyGDktKUR32uLZqioz+j8DSMwZ6ndH+eTveB2mPLo1aI948lprGpv/+SVli7/pIuvz5bHh3f96t/mWwZx0uMh/2fs4HwdwpmRbzgrekGrZF6+Bts5nWAk1euIlKYIaexVO+N5m9+++SY1cKHnZgWLmraKpm/cogH94moZP5xTubBFFjmEq8UXDl5yNaDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWHEmf31kXssS9xwKRiF4/mmi/h3equg3hXSnG4baWo=;
 b=i22deiLtKeins+f+ZDxwfm382HR7AKsLpUKmnPXNVh/pCjODvld6Y1HpTyH0efvLsUomlCzowALNLcLKUBvx5cTWVYfeRRc40i9egix6mYotTzdNYRVlKDRQ5sZ/vj+Q0AGda8lVj/VzsjV3QEgWCdixV2Ye6ORNq255ueuvX0BXZDrkoMVLoCCdhGTSb0PkGEqDQlzJDNqy5pyDxX/7uqaE4uc344vjyvB9cAQppRCHx+b9+qKXI/+foZLweMtREaDX0Jl6VIfdlkEO281+3TJ9BYgc5JmE6dJ5jGJHJJOfmuwXt2EcwX+D8kZ019wrEaNWBnchnDgTVgwvsdtQMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7458.namprd11.prod.outlook.com (2603:10b6:8:145::13)
 by IA1PR11MB7855.namprd11.prod.outlook.com (2603:10b6:208:3f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Thu, 16 Apr
 2026 14:04:43 +0000
Received: from DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::6d78:37d8:c835:540]) by DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::6d78:37d8:c835:540%4]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 14:04:42 +0000
From: "Ji, Kai" <kai.ji@intel.com>
To: "Nicolau, Radu" <radu.nicolau@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "fanzhang.oss@gmail.com" <fanzhang.oss@gmail.com>, "stable@dpdk.org"
 <stable@dpdk.org>, Akhil Goyal <gakhil@marvell.com>
Subject: Re: [PATCH] crypto/scheduler: fix typo
Thread-Topic: [PATCH] crypto/scheduler: fix typo
Thread-Index: AQHczYePnzNUDEuGpkizvcKPG7Dc/LXhuLJk
Date: Thu, 16 Apr 2026 14:04:42 +0000
Message-ID: <DS0PR11MB74582F9B2381C12687BB5A0181232@DS0PR11MB7458.namprd11.prod.outlook.com>
References: <20260416095739.105062-1-radu.nicolau@intel.com>
In-Reply-To: <20260416095739.105062-1-radu.nicolau@intel.com>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7458:EE_|IA1PR11MB7855:EE_
x-ms-office365-filtering-correlation-id: a94f8361-5bcf-40e8-6e91-08de9bc11b92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|42112799006|366016|38070700021|18002099003|22082099003|56012099003|8096899003;
x-microsoft-antispam-message-info: NpUyX5HqNnwMnpMHGJY1Vo6MtwjKALT8g8ynBdy8pXN0EpBfTMQsBXr01f17UQHRn1Hv1jO7otNMKOBZhvgWX73nA0y35k3ygYgwqTv+lbl1EkzTonOiOKM13y0snmcnxHzqaGPnEbHn7Xmcg0NT+iCwi2OYz7TLbuHRnhWpoYidKSmzJxv/k8w9iddbv/GcPeHzJSiyOoaYnMRIlRdEAvPP8ObB9jEeZLGluM5MfNh6LhdBueh1tm/G7g6U/8LPCoRQw0jD5yoDAoqzO0HPXnaL/gOASNkdQbSanwmMqZB1os23WbFqlJFiCRUuCw9oe0wpPpDLHpF8fYWsnrIbZdzHi5CLrBnFxDH7iTMYKCq/5iPslfPUrMuJjRjTHOYHrP8JkHSEReMJZX5pdq3ym96YirD+AwHwKXPe/BLqOCnGk4G0K+Y+/RG05AUoLTQtVowUIax9vtKGG10fXqge4frJbF8DyLQPO2v2tiXvURv4yG1GORoQC4e6obrwHdvi4pRT7aJyQ1p04glN/Fw3Um20lJbItvDa913yVRe+tsrfwzihcBYPt682jeXBmdo+1ptXh4OuD2pvDuBF+Jkrk3gOOYc+hjdmphae+dbRPDMXzrQAWlW7cTJbeelVsJVklfn8RdjYjm/+1P9crLaJX3LPgyTonJvTjnXIBqK2Ej7U9UsyDUAi//vjvKLMPaCW7Cdjtq5ksKSVZzw3U9SObgADq4wlq4wOgILiXQMY2HCKryc2K2WO3q+Jbn4dgI6qHEGyauvxtApZOcTBwLW1qDY9KmZG8jHnigHCgW3oIg8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7458.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(42112799006)(366016)(38070700021)(18002099003)(22082099003)(56012099003)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AwbKXb8W5IPeH07lEMMe1bsyVGMi8plWoxIdxre7VVn31moJ4ZzBrLZYxPTD?=
 =?us-ascii?Q?VlJ+exQvtYpWeD/AHQzqXw2XygcYZIVOWZxtDFDVtt6ZnbytiiokpfJcnm/c?=
 =?us-ascii?Q?30wlFmVLMbCnq6dUGCrVXHOMoP07VeYVqa1ozNlUas3rBE2IY/VV5m6pdWsG?=
 =?us-ascii?Q?FDzUmpfIYafIVn+Z9f0gegY4nmekxEhaMi3W65oy87wMP0HqnboPw/0Q/QfZ?=
 =?us-ascii?Q?ZLzh/AwOS0bspIMbjVZti/edD6lyyoExbgZ2O/EtyQe63fkGeGooUbOa26Yt?=
 =?us-ascii?Q?7enwQYVd81AI7DetX/hLk1GRgAljR1FaPAPsCjgS63CS1uUofTDtLj0Hi13V?=
 =?us-ascii?Q?5G4Dg2y+CQc+NLCOdBRC+2dOnbEvYjwgnJk4D1hJWTB9fADlAcRRPpRPsDug?=
 =?us-ascii?Q?q/HqUZOmockM/Mx1vEA+FkfjzkB+b273CBxRKsApS7vC+h6TwRQYcw1oQ0E/?=
 =?us-ascii?Q?z1b/gn3nEgALgL/J2lJc3DDoiQ2BTP+OsWoGV561W2ssTdyy4xV4KZutC6J7?=
 =?us-ascii?Q?BqZNpwhmw6SvYe1/FQ4lW7xPEUb4anzVrMj85vDp4ukU+tvP3q/PXJd6vBRg?=
 =?us-ascii?Q?XCbMa1HISaDeNQ9i/FXIlPf2HKtQqYspd4a9dSAM1UkanaqGGcUdbuIjN+7Q?=
 =?us-ascii?Q?0drdAdEw/5jJYNWoEF6p8cLRZMouNZnv4fGwMyHaTukTuMjafIwGihm+1m9D?=
 =?us-ascii?Q?t5WOm9Zr/WEpWozBlqY+g5Nx2sWeg35j3w96RBg97TD0gDx4Os1FxaO1Uxih?=
 =?us-ascii?Q?ADZwiujZhVGf3iilgpMUArmZsvx8MAQYAdaVvXussIKYcwIfdnEeeB0FW2k+?=
 =?us-ascii?Q?8j9eOWW75bEdVEVIBuJa3r3RClLqK/n6fyqa/SK4pUQwbro+Q+s/m1dP7DjZ?=
 =?us-ascii?Q?NE0Eq6FDcaU3lVlg2G2Ts8KvL/6NnX3CTlr3dswZ7Q+JPNFOpSUDU9MhY+Hf?=
 =?us-ascii?Q?8rczium36Qf7NLj1PhfSwkZbzZMmFZriARlN+t/9BHZgdiMyHdfy5PEcPhJi?=
 =?us-ascii?Q?OCNI+gau39T2JPbC+2jGwliodqPS+WxTiPTFRJx/1VK5GcgxbmNxvqW9LbFB?=
 =?us-ascii?Q?4RsviezTPq+OnkSNnjX4bMZ+EP2QMxXAUyL4qaSSlVjFohCkvWdP6OtlG0Zl?=
 =?us-ascii?Q?vdKoS/h07u2Aivli2gRmQ0LKf8NFnYUkQg1SvofXQwiS/IHSl5SHIanxxNs6?=
 =?us-ascii?Q?CT6hEJBtZJHrkNLwtV24gZiVwEkFvnmhza13uu2fKaslDzJfwzMVdlkSguu/?=
 =?us-ascii?Q?ob7C+U/wJyGHLcJNQRulRpP+LbuV8ghE8SMcBxh6aw6S4XlKQJx9KxXA8//U?=
 =?us-ascii?Q?FzWQexNBnyvF05gplVUjhHx3LvZ5lANF1XFkwLjqUP3SBRgH2rG7huD0ywEM?=
 =?us-ascii?Q?X6rQdU7V91ClsQTHILwb5Mf7wYKenustfuUg4PWWJZltHSDg6hMWd9tNaMG5?=
 =?us-ascii?Q?oOThpT9JO3pCiukjAfm/8dMW6LM0S/geU2bhR8uEzHJfXt0mx2ST5dzwLXrz?=
 =?us-ascii?Q?C6uHjRjhV2jp8XeSzf8pj+hsMhMA0Kc6BB3l4K4NTcjCHtl7Eyo66xT4ZJVD?=
 =?us-ascii?Q?a/o5VTRg1yMGgQ+vFJLLJgZf8Y1VyVzVZFwXHLsR++EPySy/WuQc4qQPUOLX?=
 =?us-ascii?Q?3vIrruiZPu4TtkvDlf+QlKGlxiqWnxiSx3WRDkFv3hYw7AEEMjlcxo+vqlEp?=
 =?us-ascii?Q?MKpwpJGIgDUFnlU1okiki3ZYXZ3QQcGhKwxS4VQoxPxSvt8/?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR11MB74582F9B2381C12687BB5A0181232DS0PR11MB7458namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TP7sUxJmUynaTIynVx6mYMCw65N1Rh77suciXJVLI4+OBv97x2oLKf9H/qZ8nXVFDUaitSye4y3NrqySXlyZzYM6vv5bNuuQCLjr0+tvr0H+xeCYBvAvJ6PwXDz8pF7pZh9Jq9PKB04C+e2fqVCSy1YdxBgMIsWhqVL03eQ8OBV9/3qhxN2aYLxJs7EmZR8Vv2/IzDcSf6z1mrxYulLsvtu+b3p+/axTUfylKgDovAFRcD0gXx8TRkGy3qDZg+n/NBad57Nzc2+AE+IRlzXwanOSV3KLJgIk/v7TsAOA+zqdcvHSJpy7aOb1QAWGymv4lOFHvGyJ2kpbmb2s76kZCg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7458.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a94f8361-5bcf-40e8-6e91-08de9bc11b92
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 14:04:42.6572 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G2KTDpAli3QWi7EEj38pDG9+zahiOsNFVJYnpA6GJn1dqtjnET9qi0VhbVi8js75783ykGj/GMw+HKMCd+b52g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7855
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

--_000_DS0PR11MB74582F9B2381C12687BB5A0181232DS0PR11MB7458namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Kai Ji <kai.ji@intel.com>
________________________________
From: Nicolau, Radu <radu.nicolau@intel.com>
Sent: 16 April 2026 10:57
To: dev@dpdk.org <dev@dpdk.org>
Cc: Nicolau, Radu <radu.nicolau@intel.com>; fanzhang.oss@gmail.com <fanzhan=
g.oss@gmail.com>; stable@dpdk.org <stable@dpdk.org>; Ji, Kai <kai.ji@intel.=
com>; Akhil Goyal <gakhil@marvell.com>
Subject: [PATCH] crypto/scheduler: fix typo

Small typo, pending_deq_ops used instead of pending_enq_ops.

Bugzilla ID: 1537

Fixes: 6812b9bf470e ("crypto/scheduler: use unified session")
Cc: fanzhang.oss@gmail.com
Cc: stable@dpdk.org

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 drivers/crypto/scheduler/scheduler_multicore.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/scheduler/scheduler_multicore.c b/drivers/crypt=
o/scheduler/scheduler_multicore.c
index a21b522f9f..70f8a25b70 100644
--- a/drivers/crypto/scheduler/scheduler_multicore.c
+++ b/drivers/crypto/scheduler/scheduler_multicore.c
@@ -191,11 +191,11 @@ mc_scheduler_worker(struct rte_cryptodev *dev)
                                         worker->qp_id,
                                         &enq_ops[pending_enq_ops_idx],
                                         pending_enq_ops);
-                       if (processed_ops < pending_deq_ops)
+                       if (processed_ops < pending_enq_ops)
                                 scheduler_retrieve_sessions(
                                         &enq_ops[pending_enq_ops_idx +
                                                 processed_ops],
-                                       pending_deq_ops - processed_ops);
+                                       pending_enq_ops - processed_ops);
                         pending_enq_ops -=3D processed_ops;
                         pending_enq_ops_idx +=3D processed_ops;
                         inflight_ops +=3D processed_ops;
--
2.52.0


--_000_DS0PR11MB74582F9B2381C12687BB5A0181232DS0PR11MB7458namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
Acked-by: Kai Ji &lt;kai.ji@intel.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Nicolau, Radu &lt;rad=
u.nicolau@intel.com&gt;<br>
<b>Sent:</b> 16 April 2026 10:57<br>
<b>To:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
<b>Cc:</b> Nicolau, Radu &lt;radu.nicolau@intel.com&gt;; fanzhang.oss@gmail=
.com &lt;fanzhang.oss@gmail.com&gt;; stable@dpdk.org &lt;stable@dpdk.org&gt=
;; Ji, Kai &lt;kai.ji@intel.com&gt;; Akhil Goyal &lt;gakhil@marvell.com&gt;=
<br>
<b>Subject:</b> [PATCH] crypto/scheduler: fix typo</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Small typo, pending_deq_ops used instead of pendin=
g_enq_ops.<br>
<br>
Bugzilla ID: 1537<br>
<br>
Fixes: 6812b9bf470e (&quot;crypto/scheduler: use unified session&quot;)<br>
Cc: fanzhang.oss@gmail.com<br>
Cc: stable@dpdk.org<br>
<br>
Signed-off-by: Radu Nicolau &lt;radu.nicolau@intel.com&gt;<br>
---<br>
&nbsp;drivers/crypto/scheduler/scheduler_multicore.c | 4 ++--<br>
&nbsp;1 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/crypto/scheduler/scheduler_multicore.c b/drivers/crypt=
o/scheduler/scheduler_multicore.c<br>
index a21b522f9f..70f8a25b70 100644<br>
--- a/drivers/crypto/scheduler/scheduler_multicore.c<br>
+++ b/drivers/crypto/scheduler/scheduler_multicore.c<br>
@@ -191,11 +191,11 @@ mc_scheduler_worker(struct rte_cryptodev *dev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; worker-&gt;qp_id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; &amp;enq_ops[pending_enq_ops_idx],<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pending_enq_ops);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (processed_op=
s &lt; pending_deq_ops)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (processed_op=
s &lt; pending_enq_ops)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scheduler_retrieve_sessions(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; &amp;enq_ops[pending_enq_ops_idx +<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; processed_o=
ps],<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; pending_deq_ops - processed_ops);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; pending_enq_ops - processed_ops);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pendi=
ng_enq_ops -=3D processed_ops;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pendi=
ng_enq_ops_idx +=3D processed_ops;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; infli=
ght_ops +=3D processed_ops;<br>
-- <br>
2.52.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DS0PR11MB74582F9B2381C12687BB5A0181232DS0PR11MB7458namp_--
