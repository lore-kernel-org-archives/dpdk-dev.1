Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42620FC591C
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 09:57:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98A92402E8;
	Thu, 26 Feb 2026 10:57:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id EF445402EE
 for <dev@dpdk.org>; Thu, 26 Feb 2026 10:57:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772099860; x=1803635860;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=qRPCxyX3p1y+jKbldmzHfzoHRT3NVH/Zs5xESn365vk=;
 b=AC7nFJIEX4W3Tzgf0IbZsWTHJ6iCTK2JXNjZKSSHx024460nH8AkMKUv
 d7n7WHdXz4MiVMnLJFLasiGLQOGUxLgCSEsENb14IwLjtrjsDFjRhdNBW
 q6oDGg/nvyS/Lvd8PbONcIwvTvh2O6BfhqmSrYOAgE5MM7KSyV/K93n1u
 gAfF162EOwYyFGNZlG+1f8BD2sxqqX898DbX9wf1xZbcF2/e6SpO5uRQs
 XYShz/EFbQd+qcmNgE2/d9L9elQ4L5q9ZKla/MZBAn3LWPnVEMH34fGWJ
 uKugonz2Fhc3eL3XJjkssMDs475H6TwSFRjCBmaTYc6+5B2CEvZGjY+wF g==;
X-CSE-ConnectionGUID: jQvgp9PWQ9KaO880qlF0Pw==
X-CSE-MsgGUID: lngpBpSgTke/WMLogOelqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="95771766"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="95771766"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 01:57:27 -0800
X-CSE-ConnectionGUID: kIahJ/n0Q0SXTwmffgpfow==
X-CSE-MsgGUID: rLjCKeoXSH+RRWEmhQb6Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="215753446"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 01:57:27 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 01:57:26 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Feb 2026 01:57:26 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.41)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 01:57:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gARD5X6JywjEkhVeowoyQQiycXhPjsJJgVY+jWfpwbkpwj+mvT7Odz9uWmLsL93PXkyph6KmU7tiwcC3bRM2mSfnAMsFvr/qHFiEA7RMWJ/8QQi2Mzx6zka3S/mEBJ8wR4zG+DmK07Zzfc4HnYQmjv1BX1LNEn/G53CJ39BAkUvEqqpQ0A42nRf1SdVkNLtGKMmOex5WMT7Ul+SySskCPusediISClUbeT1wlaILmWsfhCn5bWb6MBruWzufZqbvsv+9Q3yA18Y5Whn9brbRhDgYYeaHiHNGD3W+DYPnAgPrOxlY8cnAC+4D6vqNGUXn/F2Po3fODFb08vR47Ri5bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0SI9n/Qrvxhn6Hao0ymDzO5bv+aYqxWOq8rpKMXS5o4=;
 b=WhqY+lyDxE2tXnaCYxe4YdT/2FlUglw2Pwod5lpR43NT7VVk1VEYSWmFaAnTU4mHD+BRdOdLNXKzvUvFRBQUaCHV/WVvVcl63Ysd4shyx/WBrWRujDU7npSAPhhyqlUvyz56NIoLOwGyFzqS8S4462WkmLr4msenKFmgvX4cQpAsq84x5EgJP0rCyISwRD2wxwXchBNkgychijbdHcPp3/MwbdF8jncaM6mZ+KEqM4RoSmNdDbUCy62h03XqWluA35oOujLrgDBEdZ3ofsm6D12wMxfszJIlsVCTMc698jj1f9QOP9PtfAt0ga5p+LYOnNRShSCK/jaAWyDR0ALybw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7563.namprd11.prod.outlook.com (2603:10b6:510:286::11)
 by PH0PR11MB7614.namprd11.prod.outlook.com (2603:10b6:510:28f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 09:57:24 +0000
Received: from PH0PR11MB7563.namprd11.prod.outlook.com
 ([fe80::b1d9:cd5f:9d12:e954]) by PH0PR11MB7563.namprd11.prod.outlook.com
 ([fe80::b1d9:cd5f:9d12:e954%4]) with mapi id 15.20.9654.007; Thu, 26 Feb 2026
 09:57:24 +0000
From: "Kumar, Rajesh3" <rajesh3.kumar@intel.com>
To: "Hore, Soumyadeep" <soumyadeep.hore@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "Singh, Aman Deep" <aman.deep.singh@intel.com>, "Subbarao, Manoj Kumar"
 <manoj.kumar.subbarao@intel.com>, "Olech, Milena" <milena.olech@intel.com>
Subject: RE: [PATCH v6 1/4] net/idpf/base: add a new API for PTP support
Thread-Topic: [PATCH v6 1/4] net/idpf/base: add a new API for PTP support
Thread-Index: AQHcnYFCjMYUPnF1WkW6U9sljwVO1LWUz+Uw
Date: Thu, 26 Feb 2026 09:57:24 +0000
Message-ID: <PH0PR11MB7563F7B216E8F99696B3C5E6B572A@PH0PR11MB7563.namprd11.prod.outlook.com>
References: <20260123000449.188008-3-soumyadeep.hore@intel.com>
 <20260214194920.139066-1-soumyadeep.hore@intel.com>
 <20260214194920.139066-2-soumyadeep.hore@intel.com>
In-Reply-To: <20260214194920.139066-2-soumyadeep.hore@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7563:EE_|PH0PR11MB7614:EE_
x-ms-office365-filtering-correlation-id: 3b81562c-4e10-43a2-0b29-08de751d70da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: 7UDZDodiEaKZHdsrBgVgaBoi+NqTQbYcLOzfYeLGA+9H6rcu7uID2nCQlddwMqs3hFPEw3tM9bxoiyjJZN7QaJWY87wCChXbszXNWcTWls74agpVsIP5G09SdAEMyNZ7KdHPhVQX1HG251XAX3KHa06VQ/ryTMu7/PYnfADYPqc2BwRz1vPIZKgMLrFh+Aj7oTiY2dTS/45l79evpyWILXOJoXEthl2iJWCT9BkBB6clXjzpXmcdd4c0ZDgrhVAtgn9Fg4UrRU3xaa6vFwQcBdGq+6mE7HrpnnvQ1uFPgFTWVFKkbw1V6f6XcQd5OAwgnXyKJFyriMowdpbulNpNAuL6cN0xTV56UeY+6KNwndnNyiX0CDOOtLWUoq3p4MN2gx9oVE46Buz7Kt7fab5TmKd3efL2wVsxwkCmUXYtAYejhLdI+A245WNV992pSVSL2OoDNlE5Tx1ziYwnqWJAxfESOQDBCTgbQII8+5A3pzAgRxKSqUa3coeeHWIfhCge8Qb+Ab/gEUmzOXR13KembVNvhcSsJPy69smXhuMMz/GNtH8Y3TCyPjg5Dhhx+g9zAAmhyIN6+5HZlg831ir8/F04al8yVaTRSxW9qVz9dSEV59CYeXYrA5+EqWU15VtNsI6smY31bbDxJdfqe4hbCboh6zNZUlH0YWK1q7eYFWSwEwcLPWI5FWz+4/F2YbX2obGH6cORAOl4dbkhstZVB1XNm5wVWBu3HOZUtjaJPu1Z0M1FfBuUi/9XsUP+GR9HpHGdudPXkh+wW9jPlbfTzR0XfQHVB5rHwEuNBKJ42Hg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7563.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ygZWH7BtbrnGtoraTWyenwnCuBGz29ihveCjJ2/kNWhX6/1UD8i8dX1Ym7Ju?=
 =?us-ascii?Q?I2rLrxi6Ym7StdepTRCJU9BAZH0r1zcTjPB7LsTmghEIk0zetZGgqOBwocyx?=
 =?us-ascii?Q?sB6P5eMVNEx8efIsDrRJ6NnUL7/p7lmpkI6L8bErUowKbawPOpLKAsvfXSmm?=
 =?us-ascii?Q?WJS2AjGZK2F1lj6+cxyT07Dete+DyGGvS/9c5Y+J059dg9GJ4KeDKFB5DDgb?=
 =?us-ascii?Q?EHadbBRmCepwULA2jJZ2eXf4AbNEqSWi8eVBUIXp3H+yzkiE7sTiWViq9UGp?=
 =?us-ascii?Q?NFi1n/96XEACiMu3LtOh1BiA8i26vemN1dnpGxsR9dTOyBRuRJscyHwyvj6a?=
 =?us-ascii?Q?fAsM5l5SQVmWdg4qQuER3a7vuHGE0LSRrbIZTkmJPQ3Ok0czkZzzZMgJqErR?=
 =?us-ascii?Q?ga9PgVkmwYjnj8KnV4WigU7EFDfEjnjStFcQXRg5k4NFxhGUJD/9HcqNMfXw?=
 =?us-ascii?Q?Ku6paAJIiS+UIkwD91fLNcwoC5uthai1HG1qQru2TgDhlKXWrMBXsseJ7HWS?=
 =?us-ascii?Q?VjjcUz8yAxZKBvh6hPMuQGjK7HHVERR7nWIA9x9wkDdSnViHTFzrmmFXJdO5?=
 =?us-ascii?Q?4PRWPAjGd3JU+n1PBYputldIEWtS72g3fRqtFwOpaLy7BaLCksb3MXAX7Cl1?=
 =?us-ascii?Q?nrQQ8VPOwYb6tvTnbJBvt/4QNucADT0oJbx/bIrERSt2QjzQ3S4zQxPTkcor?=
 =?us-ascii?Q?K7g2kqCb9vPp6Mqv1KUXQ0tYMpfEyUJJSnkE4YmuYzQtjBQzVm65eJ6JQHRm?=
 =?us-ascii?Q?jYxeJ9cnDHqEsXEu6QvnTvyEYBIh0vlPOO/pcx9fVIOsCnfi1Eqxf7ofZerT?=
 =?us-ascii?Q?0MyUQkiEvZ8oZIOfMf7ufFFfDDkVFpf2B4N0SkqA+b7+21aueShGOGiUuxms?=
 =?us-ascii?Q?1G0dLCcZ9uPOexnm44ZBhcpUObhOj8CTRR7OQUoXAFu507vSSc3l3kvB/jMg?=
 =?us-ascii?Q?jyHzNUOd6Mjd+IznCij3dgU5eAee7DKWAviFHp0THPLt/ZjSkz5kh7AWZ4RC?=
 =?us-ascii?Q?lkVty5ja51gCmzshlsYknHPiDvpD6S7lLXpABYbDeqLrD37g5rc2zar/1Jw6?=
 =?us-ascii?Q?nue7QlOn1OeMLnupL081hR2o8FSHP2OrkrNC/GARxRNf1CLox+fyMBoH/2qI?=
 =?us-ascii?Q?vSeELMOsLf1hIlUu3xLVGlMBiAi0ycIwRvlvWHESMBQ6SdsVkLDKRFYprNrR?=
 =?us-ascii?Q?Tk3FJO2dFrvUKJgI3JeimtClndUlS/uYVwNWMvZSo1QARnPzObctd3KhxbZj?=
 =?us-ascii?Q?/ik+d/XTCb0Eg8bi6vbB9uv/SkzPBe7IoAHSQni3OxNolMdafY/0PAVcgWiX?=
 =?us-ascii?Q?k7/tAjhjZDlVIOzN8NhmQiXCleHBuo2l6z4Tb+G3E8aD2jBowZcQP1tilwKv?=
 =?us-ascii?Q?YSu6dokefsVuxjZuTNvvX2SAyhXp2D6CWZKjWjHNi/uoIRY2d4PpAbLpwOgw?=
 =?us-ascii?Q?m/eOIMlsMLKKvJhkV5J1YiW9oAwbz/2jSOxY2/IIBSkGjUe17BqLV+57azYu?=
 =?us-ascii?Q?cUkW2ftTqfgi4yG4IrssN9r0Apm6q69VYez1+VSvBmb9FYZz85rqTUXU/J5B?=
 =?us-ascii?Q?0QpjqeoORW7qlJJfMZigwLqo2EyYANGJmDOSfnk3DtG+it3qQBz+CNsLXbHN?=
 =?us-ascii?Q?0byY1Cbfl03nKYDlJ1bdATVQjqyvZX5phTZTuTz3Bfdkzwmsf+SV+UG25AeC?=
 =?us-ascii?Q?sT2YbBfU39d0sbwrygNGlQzCa2ORqzSITpf17Eugdix2aw9SaO/bg0rOe8vq?=
 =?us-ascii?Q?K7bCBKRN9Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7563.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b81562c-4e10-43a2-0b29-08de751d70da
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 09:57:24.0611 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6TXFWrvT9EbppB3oZFNdhhNImSfF2DCBkhISp8stOHzBuxIcImKNzJ+w8GfQZyfil53bnV+qWFJIxRevWQnqmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7614
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
ingh@intel.com>; Subbarao, Manoj Kumar <manoj.kumar.subbarao@intel.com>; Ol=
ech, Milena <milena.olech@intel.com>
Subject: [PATCH v6 1/4] net/idpf/base: add a new API for PTP support

From: Milena Olech <milena.olech@intel.com>

Add PTP capabilities to determine which PTP features are enabled - get/set =
the time, cross timestamp, adjust the clock and timestamping.

Create appropriate structures and opcodes to support features introduced by=
 capabilities.

Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
Signed-off-by: Milena Olech <milena.olech@intel.com>
---
 drivers/net/intel/idpf/base/virtchnl2.h | 324 +++++++++++++++++-------
 1 file changed, 235 insertions(+), 89 deletions(-)

diff --git a/drivers/net/intel/idpf/base/virtchnl2.h b/drivers/net/intel/id=
pf/base/virtchnl2.h
index 6cfb4f56fa..0b01daee30 100644
--- a/drivers/net/intel/idpf/base/virtchnl2.h
+++ b/drivers/net/intel/idpf/base/virtchnl2.h
@@ -118,8 +118,14 @@ enum virtchnl2_op {
 	VIRTCHNL2_OP_DEL_QUEUE_GROUPS		=3D 539,
 	VIRTCHNL2_OP_GET_PORT_STATS		=3D 540,
 	/* TimeSync opcodes */
-	VIRTCHNL2_OP_GET_PTP_CAPS		=3D 541,
-	VIRTCHNL2_OP_GET_PTP_TX_TSTAMP_LATCHES	=3D 542,
+	VIRTCHNL2_OP_PTP_GET_CAPS			=3D 541,
+	VIRTCHNL2_OP_PTP_GET_VPORT_TX_TSTAMP		=3D 542,
+	VIRTCHNL2_OP_PTP_GET_DEV_CLK_TIME		=3D 543,
+	VIRTCHNL2_OP_PTP_GET_CROSS_TIME			=3D 544,
+	VIRTCHNL2_OP_PTP_SET_DEV_CLK_TIME		=3D 545,
+	VIRTCHNL2_OP_PTP_ADJ_DEV_CLK_FINE		=3D 546,
+	VIRTCHNL2_OP_PTP_ADJ_DEV_CLK_TIME		=3D 547,
+	VIRTCHNL2_OP_PTP_GET_VPORT_TX_TSTAMP_CAPS	=3D 548,
 };
=20
 #define VIRTCHNL2_RDMA_INVALID_QUEUE_IDX	0xFFFF
@@ -1813,123 +1819,180 @@ VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_promisc_i=
nfo);
  * enum virtchnl2_ptp_caps - PTP capabilities
  */
 enum virtchnl2_ptp_caps {
-	VIRTCHNL2_PTP_CAP_LEGACY_CROSS_TIME	=3D BIT(0),
-	VIRTCHNL2_PTP_CAP_PTM			=3D BIT(1),
-	VIRTCHNL2_PTP_CAP_DEVICE_CLOCK_CONTROL	=3D BIT(2),
-	VIRTCHNL2_PTP_CAP_TX_TSTAMPS_DIRECT	=3D BIT(3),
-	VIRTCHNL2_PTP_CAP_TX_TSTAMPS_VIRTCHNL	=3D BIT(4),
-};
-
-/**
- * struct virtchnl2_ptp_legacy_cross_time_reg - Legacy cross time register=
s
- *						offsets.
+	VIRTCHNL2_CAP_PTP_GET_DEVICE_CLK_TIME		=3D BIT(0),
+	VIRTCHNL2_CAP_PTP_GET_DEVICE_CLK_TIME_MB	=3D BIT(1),
+	VIRTCHNL2_CAP_PTP_GET_CROSS_TIME		=3D BIT(2),
+	VIRTCHNL2_CAP_PTP_GET_CROSS_TIME_MB		=3D BIT(3),
+	VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME		=3D BIT(4),
+	VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME_MB	=3D BIT(5),
+	VIRTCHNL2_CAP_PTP_ADJ_DEVICE_CLK		=3D BIT(6),
+	VIRTCHNL2_CAP_PTP_ADJ_DEVICE_CLK_MB		=3D BIT(7),
+	VIRTCHNL2_CAP_PTP_TX_TSTAMPS			=3D BIT(8),
+	VIRTCHNL2_CAP_PTP_TX_TSTAMPS_MB			=3D BIT(9),
+};
+
+/**
+ * struct virtchnl2_ptp_clk_reg_offsets - Offsets of device and PHY clocks
+ *					  registers
+ * @dev_clk_ns_l: Device clock low register offset
+ * @dev_clk_ns_h: Device clock high register offset
+ * @phy_clk_ns_l: PHY clock low register offset
+ * @phy_clk_ns_h: PHY clock high register offset
+ * @cmd_sync_trigger: The command sync trigger register offset
+ * @pad: Padding for future extensions
  */
-struct virtchnl2_ptp_legacy_cross_time_reg {
-	__le32 shadow_time_0;
-	__le32 shadow_time_l;
-	__le32 shadow_time_h;
-	__le32 cmd_sync;
+struct virtchnl2_ptp_clk_reg_offsets {
+	__le32 dev_clk_ns_l;
+	__le32 dev_clk_ns_h;
+	__le32 phy_clk_ns_l;
+	__le32 phy_clk_ns_h;
+	__le32 cmd_sync_trigger;
+	u8 pad[4];
 };
=20
-VIRTCHNL2_CHECK_STRUCT_LEN(16, virtchnl2_ptp_legacy_cross_time_reg);
+VIRTCHNL2_CHECK_STRUCT_LEN(24, virtchnl2_ptp_clk_reg_offsets);
=20
 /**
- * struct virtchnl2_ptp_ptm_cross_time_reg - PTM cross time registers offs=
ets
+ * struct virtchnl2_ptp_cross_time_reg_offsets - Offsets of the device cro=
ss
+ *						 time registers
+ * @sys_time_ns_l: System time low register offset
+ * @sys_time_ns_h: System time high register offset
+ * @cmd_sync_trigger: The command sync trigger register offset
+ * @pad: Padding for future extensions
  */
-struct virtchnl2_ptp_ptm_cross_time_reg {
-	__le32 art_l;
-	__le32 art_h;
-	__le32 cmd_sync;
+struct virtchnl2_ptp_cross_time_reg_offsets {
+	__le32 sys_time_ns_l;
+	__le32 sys_time_ns_h;
+	__le32 cmd_sync_trigger;
 	u8 pad[4];
 };
=20
-VIRTCHNL2_CHECK_STRUCT_LEN(16, virtchnl2_ptp_ptm_cross_time_reg);
+VIRTCHNL2_CHECK_STRUCT_LEN(16, virtchnl2_ptp_cross_time_reg_offsets);
=20
 /**
- * struct virtchnl2_ptp_device_clock_control - Registers needed to control=
 the
- *					       main clock.
+ * struct virtchnl2_ptp_clk_adj_reg_offsets - Offsets of device and PHY cl=
ocks
+ *					      adjustments registers
+ * @dev_clk_cmd_type: Device clock command type register offset
+ * @dev_clk_incval_l: Device clock increment value low register offset
+ * @dev_clk_incval_h: Device clock increment value high registers=20
+ offset
+ * @dev_clk_shadj_l: Device clock shadow adjust low register offset
+ * @dev_clk_shadj_h: Device clock shadow adjust high register offset
+ * @phy_clk_cmd_type: PHY timer command type register offset
+ * @phy_clk_incval_l: PHY timer increment value low register offset
+ * @phy_clk_incval_h: PHY timer increment value high register offset
+ * @phy_clk_shadj_l: PHY timer shadow adjust low register offset
+ * @phy_clk_shadj_h: PHY timer shadow adjust high register offset
  */
-struct virtchnl2_ptp_device_clock_control {
-	__le32 cmd;
-	__le32 incval_l;
-	__le32 incval_h;
-	__le32 shadj_l;
-	__le32 shadj_h;
-	u8 pad[4];
+struct virtchnl2_ptp_clk_adj_reg_offsets {
+	__le32 dev_clk_cmd_type;
+	__le32 dev_clk_incval_l;
+	__le32 dev_clk_incval_h;
+	__le32 dev_clk_shadj_l;
+	__le32 dev_clk_shadj_h;
+	__le32 phy_clk_cmd_type;
+	__le32 phy_clk_incval_l;
+	__le32 phy_clk_incval_h;
+	__le32 phy_clk_shadj_l;
+	__le32 phy_clk_shadj_h;
 };
=20
-VIRTCHNL2_CHECK_STRUCT_LEN(24, virtchnl2_ptp_device_clock_control);
+VIRTCHNL2_CHECK_STRUCT_LEN(40, virtchnl2_ptp_clk_adj_reg_offsets);
=20
 /**
- * struct virtchnl2_ptp_tx_tstamp_entry - PTP TX timestamp entry
- * @tx_latch_register_base: TX latch register base
- * @tx_latch_register_offset: TX latch register offset
- * @index: Index
- * @pad: Padding
+ * struct virtchnl2_ptp_tx_tstamp_latch_caps - PTP Tx timestamp latch
+ *					       capabilities
+ * @tx_latch_reg_offset_l: Tx timestamp latch low register offset
+ * @tx_latch_reg_offset_h: Tx timestamp latch high register offset
+ * @index: Latch index provided to the Tx descriptor
+ * @pad: Padding for future extensions
  */
-struct virtchnl2_ptp_tx_tstamp_entry {
-	__le32 tx_latch_register_base;
-	__le32 tx_latch_register_offset;
+struct virtchnl2_ptp_tx_tstamp_latch_caps {
+	__le32 tx_latch_reg_offset_l;
+	__le32 tx_latch_reg_offset_h;
 	u8 index;
 	u8 pad[7];
 };
=20
-VIRTCHNL2_CHECK_STRUCT_LEN(16, virtchnl2_ptp_tx_tstamp_entry);
+VIRTCHNL2_CHECK_STRUCT_LEN(16, virtchnl2_ptp_tx_tstamp_latch_caps);
=20
 /**
- * struct virtchnl2_ptp_tx_tstamp - Structure that defines tx tstamp entri=
es
+ * struct virtchnl2_ptp_get_vport_tx_tstamp_caps - Structure that defines =
Tx
+ *						   tstamp entries
+ * @vport_id: Vport number
  * @num_latches: Total number of latches
- * @latch_size: Latch size expressed in bits
- * @pad: Padding
- * @ptp_tx_tstamp_entries: Aarray of TX timestamp entries
+ * @tstamp_ns_lo_bit: First bit for nanosecond part of the timestamp
+ * @tstamp_ns_hi_bit: Last bit for nanosecond part of the timestamp
+ * @pad: Padding for future tstamp granularity extensions
+ * @tstamp_latches: Capabilities of Tx timestamp entries
+ *
+ * PF/VF sends this message to negotiate the Tx timestamp latches for=20
+ each
+ * Vport.
+ *
+ * Associated with VIRTCHNL2_OP_PTP_GET_VPORT_TX_TSTAMP_CAPS
  */
-struct virtchnl2_ptp_tx_tstamp {
+struct virtchnl2_ptp_get_vport_tx_tstamp_caps {
+	__le32 vport_id;
 	__le16 num_latches;
-	__le16 latch_size;
-	u8 pad[4];
-	struct virtchnl2_ptp_tx_tstamp_entry ptp_tx_tstamp_entries[STRUCT_VAR_LEN=
];
+	u8 tstamp_ns_lo_bit;
+	u8 tstamp_ns_hi_bit;
+	u8 pad[8];
+
+	struct virtchnl2_ptp_tx_tstamp_latch_caps=20
+tstamp_latches[STRUCT_VAR_LEN];
 };
-VIRTCHNL2_CHECK_STRUCT_VAR_LEN(24, virtchnl2_ptp_tx_tstamp,
-			       ptp_tx_tstamp_entries);
+VIRTCHNL2_CHECK_STRUCT_VAR_LEN(32, virtchnl2_ptp_get_vport_tx_tstamp_caps,
+			       tstamp_latches);
=20
 /**
- * struct virtchnl2_get_ptp_caps - Get PTP capabilities
- * @ptp_caps: PTP capability bitmap. See enum virtchnl2_ptp_caps.
- * @pad: Padding
- * @legacy_cross_time_reg: Legacy cross time register
- * @ptm_cross_time_reg: PTM cross time register
- * @device_clock_control: Device clock control
- * @tx_tstamp: TX timestamp
+ * struct virtchnl2_ptp_get_caps - Get PTP capabilities
+ * @caps: PTP capability bitmap. See enum virtchnl2_ptp_caps
+ * @max_adj: The maximum possible frequency adjustment
+ * @base_incval: The default timer increment value
+ * @peer_mbx_q_id: ID of the PTP Device Control daemon queue
+ * @peer_id: Peer ID for PTP Device Control daemon
+ * @secondary_mbx: Indicates to the driver that it should create a seconda=
ry
+ *		   mailbox to inetract with control plane for PTP
+ * @pad: Padding for future extensions
+ * @clk_offsets: Main timer and PHY registers offsets
+ * @cross_time_offsets: Cross time registers offsets
+ * @clk_adj_offsets: Offsets needed to adjust the PHY and the main=20
+ timer
  *
- * PV/VF sends this message to negotiate PTP capabilities. CP updates bitm=
ap
+ * PF/VF sends this message to negotiate PTP capabilities. CP updates=20
+ bitmap
  * with supported features and fulfills appropriate structures.
- *
- * Associated with VIRTCHNL2_OP_GET_PTP_CAPS.
- */
-struct virtchnl2_get_ptp_caps {
-	__le32 ptp_caps;
+ * If HW uses primary MBX for PTP: secondary_mbx is set to false.
+ * If HW uses secondary MBX for PTP: secondary_mbx is set to true.
+ *	Control plane has 2 MBX and the driver has 1 MBX, send to peer
+ *	driver may be used to send a message using valid ptp_peer_mb_q_id and
+ *	ptp_peer_id.
+ * If HW does not use send to peer driver: secondary_mbx is no care=20
+field and
+ * peer_mbx_q_id holds invalid value (0xFFFF).
+ *
+ * Associated with VIRTCHNL2_OP_PTP_GET_CAPS.
+ */
+struct virtchnl2_ptp_get_caps {
+	__le32 caps;
+	__le32 max_adj;
+	__le64 base_incval;
+	__le16 peer_mbx_q_id;
+	u8 peer_id;
+	u8 secondary_mbx;
 	u8 pad[4];
=20
-	struct virtchnl2_ptp_legacy_cross_time_reg legacy_cross_time_reg;
-	struct virtchnl2_ptp_ptm_cross_time_reg ptm_cross_time_reg;
-	struct virtchnl2_ptp_device_clock_control device_clock_control;
-	struct virtchnl2_ptp_tx_tstamp tx_tstamp;
+	struct virtchnl2_ptp_clk_reg_offsets clk_offsets;
+	struct virtchnl2_ptp_cross_time_reg_offsets cross_time_offsets;
+	struct virtchnl2_ptp_clk_adj_reg_offsets clk_adj_offsets;
 };
-VIRTCHNL2_CHECK_STRUCT_VAR_LEN(88, virtchnl2_get_ptp_caps,
-			       tx_tstamp.ptp_tx_tstamp_entries);
+VIRTCHNL2_CHECK_STRUCT_LEN(104, virtchnl2_ptp_get_caps);
=20
 /**
  * struct virtchnl2_ptp_tx_tstamp_latch - Structure that describes tx tsta=
mp
  *					  values, index and validity.
- * @tstamp_h: Timestamp high
- * @tstamp_l: Timestamp low
+ * @tstamp: Timestamp value
  * @index: Index
  * @valid: Timestamp validity
- * @pad: Padding
+ * @pad: Padding for future extensions
  */
 struct virtchnl2_ptp_tx_tstamp_latch {
-	__le32 tstamp_h;
-	__le32 tstamp_l;
+	__le64 tstamp;
 	u8 index;
 	u8 valid;
 	u8 pad[6];
@@ -1938,26 +2001,97 @@ struct virtchnl2_ptp_tx_tstamp_latch {  VIRTCHNL2_C=
HECK_STRUCT_LEN(16, virtchnl2_ptp_tx_tstamp_latch);
=20
 /**
- * struct virtchnl2_ptp_tx_tstamp_latches - PTP TX timestamp latches
+ * struct virtchnl2_ptp_get_vport_tx_tstamp_latches - Tx timestamp latches
+ *						      associated with the vport
+ * @vport_id: Number of vport that requests the timestamp
  * @num_latches: Number of latches
- * @latch_size: Latch size expressed in bits
- * @pad: Padding
+ * @get_devtime_with_txtstmp: Flag to request device time along with Tx=20
+ timestamp
+ * @pad: Padding for future extensions
+ * @device_time: device time if get_devtime_with_txtstmp was set in=20
+ request
  * @tstamp_latches: PTP TX timestamp latch
  *
  * PF/VF sends this message to receive a specified number of timestamps
  * entries.
  *
- * Associated with VIRTCHNL2_OP_GET_PTP_TX_TSTAMP_LATCHES.
+ * Associated with VIRTCHNL2_OP_PTP_GET_VPORT_TX_TSTAMP.
  */
-struct virtchnl2_ptp_tx_tstamp_latches {
+struct virtchnl2_ptp_get_vport_tx_tstamp_latches {
+	__le32 vport_id;
 	__le16 num_latches;
-	__le16 latch_size;
-	u8 pad[4];
+	u8 get_devtime_with_txtstmp;
+	u8 pad[1];
+	u64 device_time;
 	struct virtchnl2_ptp_tx_tstamp_latch tstamp_latches[STRUCT_VAR_LEN];  }; =
-VIRTCHNL2_CHECK_STRUCT_VAR_LEN(24, virtchnl2_ptp_tx_tstamp_latches,
+
+VIRTCHNL2_CHECK_STRUCT_VAR_LEN(32,=20
+virtchnl2_ptp_get_vport_tx_tstamp_latches,
 			       tstamp_latches);
=20
+/* VIRTCHNL2_OP_PTP_GET_DEV_CLK_TIME
+ * @dev_time_ns: Device clock time value in nanoseconds
+ * @pad: Padding for future extensions
+ *
+ * PF/VF sends this message to receive the time from the main timer  */=20
+struct virtchnl2_ptp_get_dev_clk_time {
+	__le64 dev_time_ns;
+	u8 pad[8];
+};
+
+VIRTCHNL2_CHECK_STRUCT_LEN(16, virtchnl2_ptp_get_dev_clk_time);
+
+/* VIRTCHNL2_OP_PTP_GET_CROSS_TIME
+ * @sys_time_ns: System counter value expressed in nanoseconds, read
+ *		 synchronously with device time
+ * @dev_time_ns: Device clock time value expressed in nanoseconds
+ * @pad: Padding for future extensions
+ *
+ * PF/VF sends this message to receive the cross time  */ struct=20
+virtchnl2_ptp_get_cross_time {
+	__le64 sys_time_ns;
+	__le64 dev_time_ns;
+	u8 pad[8];
+};
+
+VIRTCHNL2_CHECK_STRUCT_LEN(24, virtchnl2_ptp_get_cross_time);
+
+/* VIRTCHNL2_OP_PTP_SET_DEV_CLK_TIME
+ * @dev_time_ns: Device time value expressed in nanoseconds to set
+ * @pad: Padding for future extensions
+ *
+ * PF/VF sends this message to set the time of the main timer  */=20
+struct virtchnl2_ptp_set_dev_clk_time {
+	__le64 dev_time_ns;
+	u8 pad[8];
+};
+
+VIRTCHNL2_CHECK_STRUCT_LEN(16, virtchnl2_ptp_set_dev_clk_time);
+
+/* VIRTCHNL2_OP_PTP_ADJ_DEV_CLK_FINE
+ * @incval: Source timer increment value per clock cycle
+ *
+ * PF/VF sends this message to adjust the frequency of the main timer=20
+by the
+ * indicated scaled ppm.
+ */
+struct virtchnl2_ptp_adj_dev_clk_fine {
+	__le64 incval;
+};
+
+VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_ptp_adj_dev_clk_fine);
+
+/* VIRTCHNL2_OP_PTP_ADJ_DEV_CLK_TIME
+ * @delta: Offset in nanoseconds to adjust the time by
+ *
+ * PF/VF sends this message to adjust the time of the main timer by the=20
+delta  */ struct virtchnl2_ptp_adj_dev_clk_time {
+	__le64 delta;
+};
+
+VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_ptp_adj_dev_clk_time);
+
 static inline const char *virtchnl2_op_str(__le32 v_opcode)  {
 	switch (v_opcode) {
@@ -2025,10 +2159,22 @@ static inline const char *virtchnl2_op_str(__le32 v=
_opcode)
 		return "VIRTCHNL2_OP_DEL_QUEUE_GROUPS";
 	case VIRTCHNL2_OP_GET_PORT_STATS:
 		return "VIRTCHNL2_OP_GET_PORT_STATS";
-	case VIRTCHNL2_OP_GET_PTP_CAPS:
-		return "VIRTCHNL2_OP_GET_PTP_CAPS";
-	case VIRTCHNL2_OP_GET_PTP_TX_TSTAMP_LATCHES:
-		return "VIRTCHNL2_OP_GET_PTP_TX_TSTAMP_LATCHES";
+	case VIRTCHNL2_OP_PTP_GET_CAPS:
+		return "VIRTCHNL2_OP_PTP_GET_CAPS";
+	case VIRTCHNL2_OP_PTP_GET_VPORT_TX_TSTAMP:
+		return "VIRTCHNL2_OP_PTP_GET_VPORT_TX_TSTAMP";
+	case VIRTCHNL2_OP_PTP_GET_DEV_CLK_TIME:
+		return "VIRTCHNL2_OP_PTP_GET_DEV_CLK_TIME";
+	case VIRTCHNL2_OP_PTP_GET_CROSS_TIME:
+		return "VIRTCHNL2_OP_PTP_GET_CROSS_TIME";
+	case VIRTCHNL2_OP_PTP_SET_DEV_CLK_TIME:
+		return "VIRTCHNL2_OP_PTP_SET_DEV_CLK_TIME";
+	case VIRTCHNL2_OP_PTP_ADJ_DEV_CLK_FINE:
+		return "VIRTCHNL2_OP_PTP_ADJ_DEV_CLK_FINE";
+	case VIRTCHNL2_OP_PTP_ADJ_DEV_CLK_TIME:
+		return "VIRTCHNL2_OP_PTP_ADJ_DEV_CLK_TIME";
+	case VIRTCHNL2_OP_PTP_GET_VPORT_TX_TSTAMP_CAPS:
+		return "VIRTCHNL2_OP_PTP_GET_VPORT_TX_TSTAMP_CAPS";
 	default:
 		return "Unsupported (update virtchnl2.h)";
 	}
--
2.47.1

