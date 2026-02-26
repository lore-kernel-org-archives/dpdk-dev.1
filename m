Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC223FC5926
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 10:39:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D0920402BB;
	Thu, 26 Feb 2026 11:39:58 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 1C3C74021F
 for <dev@dpdk.org>; Thu, 26 Feb 2026 11:39:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772102397; x=1803638397;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YsbBIp+DYh2/jkBQBhgNLUoJBM0XDMVyD4ri5Q65MyI=;
 b=oFCE00Mw43MkOxmPOzuqhBrrJIyzKzyVG/IsvFRDc9laIMz7GYYREglq
 rExGFF/HFxTwbuBlJPDfmmpvG3LRgK54c8OSk9OA770wMhFDAA9mMVi68
 LJnFFYHt/xp7d6IOE6fpyTHj1Kbsr8kdgBg5EKP6R6e0cGMecsLvdvJiG
 oGPMWRlO9s65jNU/d2jLAbtikn5xWf7OSCUkvxqXej6Z2zU/UxDg81tuQ
 Xn79Y2/Zjsb2Y9b1uc8+3o7pdVEl7+H01UeZeDGlA9ck7/0D0RVAjCz2B
 6DTgu3vwZPoFtT1F66VHFhydJPBf7prCHvkzgBX/E31LsDKR1addqj0v6 g==;
X-CSE-ConnectionGUID: qTpSUnkyQO+LaPEp7ZxaWA==
X-CSE-MsgGUID: bBTcKcw2SIm7Hh6K3Z2fPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="95775540"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="95775540"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 02:39:56 -0800
X-CSE-ConnectionGUID: xjhdSbJlR0mFokJlkcflKg==
X-CSE-MsgGUID: ose8YEU5RByRap2kga3oBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="239518588"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 02:39:55 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 02:39:54 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Feb 2026 02:39:54 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.10) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 02:39:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J+fRfp/MdnIBozPY+/F/Rxxw7mblxQCVhgt66EVLpubcbXxscMf/WjI66vYbnoQk3QT6ZsWjGDx5j9TFBRttkifrydJ4Rmb4XduwhN7UkB2eaaXnGxRO+hXE1oT2uSi8AF7sT968kbe4Cc91L5mRZW9DHmwe13u4h3nC/Rcpp57MsQpm5b3aW625S6kPccH6prr8uqTs08FukOfhUaQo5QPfF2cWMBat20eE/SwGUf5x0MDKYSmxqnFvAQQqKooUDDg89hMh9jjvrPbZl2vQ/MSpsf2zOM+pu+i8L6b3B5T+CPbb9C6DiWlDkZpL/EMDzQ60Hy1g+8wHahEccO09tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqZEccWQYtBBYktcHCvE8tQMbpquJo9cuDNQXc8rApk=;
 b=TZx89+m8iyAEZo/4jUdhR3Vgi4ZNGuFmg4unjAiilTqXej1AVEQ0uEyRmrS+h1/dHHYsh2st+pPeyOt/9LH9bm36Ne9bbl9aiWYXQVpVG4C7aZEqwkdSrRbDUo5tRpD1Wcs3vk/ONAGVOZlScP2zEjCvHZlNMfZx3bHwnt7tQZ7VLWn8Mp8h0g6ZoP0yJ0EuTFp0EA44+xw0FMe5tZOhHLG9ucRJ+JkWSHt+8iCqm55tjG0ASpN55y7c89pPsCQWTaKiy7V0r3CQXdse44BQcCkymt37Mkm4gH2oVPKpAWzZaCdRzzA0uRCzCclqVJUSQ5EJDqNxiO/f0LHklHlvrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7563.namprd11.prod.outlook.com (2603:10b6:510:286::11)
 by CH3PR11MB7275.namprd11.prod.outlook.com (2603:10b6:610:14c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 10:39:51 +0000
Received: from PH0PR11MB7563.namprd11.prod.outlook.com
 ([fe80::b1d9:cd5f:9d12:e954]) by PH0PR11MB7563.namprd11.prod.outlook.com
 ([fe80::b1d9:cd5f:9d12:e954%4]) with mapi id 15.20.9654.007; Thu, 26 Feb 2026
 10:39:51 +0000
From: "Kumar, Rajesh3" <rajesh3.kumar@intel.com>
To: "Hore, Soumyadeep" <soumyadeep.hore@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "Singh, Aman Deep" <aman.deep.singh@intel.com>, "Subbarao, Manoj Kumar"
 <manoj.kumar.subbarao@intel.com>
Subject: RE: [PATCH v6 4/4] doc/guides: add PTP IDPF documentation
Thread-Topic: [PATCH v6 4/4] doc/guides: add PTP IDPF documentation
Thread-Index: AQHcnYFDJRZUl8MC5E+UZ6i1lVcWPrWU3R9A
Date: Thu, 26 Feb 2026 10:39:51 +0000
Message-ID: <PH0PR11MB75630590E6CDCAE7BA9B3365B572A@PH0PR11MB7563.namprd11.prod.outlook.com>
References: <20260123000449.188008-3-soumyadeep.hore@intel.com>
 <20260214194920.139066-1-soumyadeep.hore@intel.com>
 <20260214194920.139066-5-soumyadeep.hore@intel.com>
In-Reply-To: <20260214194920.139066-5-soumyadeep.hore@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7563:EE_|CH3PR11MB7275:EE_
x-ms-office365-filtering-correlation-id: 0f8e73ed-7867-4deb-7de5-08de75235f5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: QOKNN7aOQHerh47YWYw6uKikrP0TYwAMPgidrlq+j0E8Vy6tlnJjOlnAoSGpE98qVA/CmfcPOE8MONAtrZxuPD0l80n9pHXV16zJACDhEvr1AgtjQkjo5PkSAIOEj8/BnQrR5SAXHHU3mDOrRbI8KDY4St/DM/do8j3mJfC4xWN+A27pyKTbK8rkIXfv82WsFj5CPawRB5W0b5ekcjEJN+myCdusRkvWAhA2jLTpQtOhfPQmz4cAaZNEcIjgTcfcqBnvH9f50wz0byyvrkezCW8Yg1IQEWn7KOxp8rvljpTDn5VfKC5Kj2yQRIKvGfyX5YwISuL6SzAlVDFUFBySYa03g5CLLjIeFrGZlsORT8p7scxLah58kQnJdHAViZ5VNU72Hd+gtKIsbfpH6nIHCqfA9ULb7I0Y07S/w9ATv6WidJn/liziyj015QihBpa9b9o1aWoONWndd9m+9RBHEC856myaxiNUJo5XxxRWDnKLR6eM+b5NGB9izAlZtmYsbpNVO8i6Z3BiT6jcjmNE1ZuN2HvN7CpEhce5xxQ54xXPCr4N3abSYLT7caE6zHqUgyTLA9uOllajtW3hEwrYlMceq3m5q2kpyUMJVjZE77xmhI7iTe1snHGAuIx5gOBkF5r9NSL2dmzGdGMzGXZRLOVbvsCAtB8GLRk5nTz/0jPFVZPIuEUkfLT080+eneIk8tlK2hAv5f/FBMnDp7w75YPdYN5PWijZznGxT4/4wssldN2YP2/B+tjwEIEqxjsVGa5gtDqo1e6Lj7liG/b36NJE5kcY3IA1hRkCQdHhqr0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7563.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8i3OVNW6MkE330tBKSbBnEMvo23zr2EFLL7mTkklGVDDMHEjtEy2lB9kWsHZ?=
 =?us-ascii?Q?nC15Mr3/fDBrdlDFAQAVisovd+EAXiEIB9DoJHSqXwEn9SFiP/oYnuSxHgKK?=
 =?us-ascii?Q?J563zjN7ReCFa7XsyTo6DmFRHrS1tbb/6/BcIt4rqhQMl0ej1cAddJqvPLyQ?=
 =?us-ascii?Q?P+5q6VERpYn+gMhAoFESWlZ3d+gmLzqERrmZSo/9JqavXS57fqHWHFgQdj1p?=
 =?us-ascii?Q?DPU34+m5CPHH4AduDYer1qX4tux3uqytX4kFbWuV2wSH62zsNsOt7fxCwSrd?=
 =?us-ascii?Q?scl5C1aX5CdlOtT+vupFn1Ai4RrreKi06PK4Dwrs+o6LFlJptRRo9zbRr1kU?=
 =?us-ascii?Q?nT4DcffvBv5xI54yKx2jvKIJw1zovnOGZsilLq8jvNOH3rB4rXe51j2phIBi?=
 =?us-ascii?Q?19L8Koka82AAyVhmS0BwSlxpZXC93vZfrdSzTK9mevxBXmpLrzNitTP/cdAb?=
 =?us-ascii?Q?Ft/HNIlO33nS++2LNRR0aLiN6H2J3vLfHlMKg7MLDloiiCYXUs2XwN28FdzF?=
 =?us-ascii?Q?tsfMJ/uIflisaEOUm4w68K2f1+GaoIq5PesAfJU86SgEBrGhlEO9DIVTypnb?=
 =?us-ascii?Q?1YhIMbKNthhmatglig4wvHf+6bzFEzDuywnqiFteS+RTEVmtjSf90jHNU33g?=
 =?us-ascii?Q?aAa5C4Vmk+k4BP+pReobrnZx7nmmIyItb6F8B0anX+MxIUiyP8bGvaU0epOt?=
 =?us-ascii?Q?ZiRtyigWpOnklQss/9Lvgnk27QS6LnIDUDe9siVHI7ab1rqIL9CuNNYkCikN?=
 =?us-ascii?Q?+SymNYccvej55rvcIOp+hNxu+oBjLm7L956rTSRtX42ms1wegF0xO7wJFSKc?=
 =?us-ascii?Q?+wgLDEDY3ALJKvIPdL1zSnTOxKw3sswbM9BT/6sfPKnIY6bvzSrHPotHfjhf?=
 =?us-ascii?Q?LZOWqzS2exK/fLEtZ1u+YHw/wUZ2GWw6quL2iNLd3Zasc+vlwuRnvAuUCV/c?=
 =?us-ascii?Q?L0o9LGvpLJlSU7YrBR1i6ysmjHf8E/2NLfjgQbSZGT9IA7vreOXN8PCC08nB?=
 =?us-ascii?Q?/e4I1zXPV/MPx3ETQI2EVk0htHE3N211fmLHQqlSPHTgX3WMpa4zKuU3V2jF?=
 =?us-ascii?Q?kClqApVKys/1vCMrIeABaqEexEQvWigo0Tcq+ENG4Kkz/yWMPhtIwAnycLtn?=
 =?us-ascii?Q?kVXgVt+Xcq0Luo73O98cO8naZbvQubGqQws7C3k3G8mnGkTR8XPfTPLzl9Ef?=
 =?us-ascii?Q?aZ/3t5iSkxVKulVlaI7D+jAYbA3DIkIaEVMX4GsZ4G9jzUi4ODl735E45Jpy?=
 =?us-ascii?Q?0kWBRmBJM29SOGmAyrQ5BQ+MOOx8c3+uBpj83pjPCUoZ0Q/50YKiAPtRGmyo?=
 =?us-ascii?Q?9mkZqRLCzgH9JKVZVDtTmkf3Vo9hO96NKP1tCRJ0WMve5f6MRnN+nnUKRBnY?=
 =?us-ascii?Q?/u4zjxjsV8C9Cgevq4IBETUk8apzau6QsCeRqnIzqCUy115vt6Ws8sLFlXvA?=
 =?us-ascii?Q?pNK+nwzb7UaKDNPxwitD7LDQxMB+hCJG7FhiLCUxGrEu8HoDbl2eMD99Y3/3?=
 =?us-ascii?Q?C6Vdf0noJhyGQ55o4Ii2j7/B9+CBGB67FFgY+CFqyfJDCd6MSosBnCl1uh2L?=
 =?us-ascii?Q?tn0lBRjF62Wzb1liM3CB1OG5pPC36kdGd2N962ytv+1E45RsPZdBmaFKj1yy?=
 =?us-ascii?Q?s52qeRoADanMp/t3WilLjqX8+6B2OAL2LAuP4qXZXVVviHQ8ZpW8Uargv6tj?=
 =?us-ascii?Q?F6ZAPrtX5MLIElWRYTor4eF9377knpdgnymaHCISm1vaNtwgBPnbBi0brQrv?=
 =?us-ascii?Q?Zbtp3sDzrQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7563.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f8e73ed-7867-4deb-7de5-08de75235f5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 10:39:51.2590 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wxySz84MowFird8tOfwuH2cE4yFksrmvE33HMxBxR5s07BVq1T+13RQYdCy8IR/66Qynb4qsY75HhzpxZq3Ajw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7275
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

Acked-by: Rajesh Kumar <rajesh3.kumar@intel.com>

-----Original Message-----
From: Hore, Soumyadeep <soumyadeep.hore@intel.com>=20
Sent: 15 February 2026 01:19 AM
To: dev@dpdk.org; Richardson, Bruce <bruce.richardson@intel.com>
Cc: Kumar, Rajesh3 <rajesh3.kumar@intel.com>; Singh, Aman Deep <aman.deep.s=
ingh@intel.com>; Subbarao, Manoj Kumar <manoj.kumar.subbarao@intel.com>
Subject: [PATCH v6 4/4] doc/guides: add PTP IDPF documentation

Updates the IDPF Documentation with PTP feature.

Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
---
 doc/guides/nics/features/idpf.ini      |  1 +
 doc/guides/nics/idpf.rst               | 15 +++++++++++++++
 doc/guides/rel_notes/release_26_03.rst |  4 ++++
 3 files changed, 20 insertions(+)

diff --git a/doc/guides/nics/features/idpf.ini b/doc/guides/nics/features/i=
dpf.ini
index 63b799289a..f546648924 100644
--- a/doc/guides/nics/features/idpf.ini
+++ b/doc/guides/nics/features/idpf.ini
@@ -19,6 +19,7 @@ RSS reta update      =3D Y
 L3 checksum offload  =3D P
 L4 checksum offload  =3D P
 Timestamp offload    =3D P
+Timesync             =3D Y
 Packet type parsing  =3D Y
 Basic stats          =3D Y
 Linux                =3D Y
diff --git a/doc/guides/nics/idpf.rst b/doc/guides/nics/idpf.rst index b99c=
c18188..998c1a5dfa 100644
--- a/doc/guides/nics/idpf.rst
+++ b/doc/guides/nics/idpf.rst
@@ -109,3 +109,18 @@ The paths are chosen based on 2 conditions:
   A value "P" means the offload feature is not supported by vector path.
   If any not supported features are used, idpf vector PMD is disabled
   and the scalar paths are chosen.
+
+  Time Synchronization
+  ~~~~~~~~~~~~~~~~~~~~
+
+  The system operator can run a PTP (Precision Time Protocol) client=20
+ application  to synchronize the time on the network card in ACC  (and=20
+ optionally the time on the system) to the PTP primary.
+
+  IDPF PMD supports PTP client applications that use the DPDK IEEE 1588=20
+ API  to communicate with the PTP primary clock.
+  Note that PTP client application needs to run on PF in ACC.
+
+  .. code-block:: console
+
+    examples/dpdk-ptpclient -l 0-3 -n 3 -a 0000:ec:00.1 -- -T 1 -p 0x1
diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/=
release_26_03.rst
index afdf1af06c..16b5a0b0b1 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -63,6 +63,10 @@ New Features
=20
   * The timestamp value has been updated to make it usable.
=20
+* **Updated Intel idpf ethernet driver.**
+
+  * Added support for time sync features.
+
 * **Updated Intel iavf driver.**
=20
   * Added support for pre and post VF reset callbacks.
--
2.47.1

