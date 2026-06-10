Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8842ACD8CB9
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 15:46:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9AF6940DCA;
	Wed, 10 Jun 2026 17:46:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 25293402BA;
 Wed, 10 Jun 2026 17:46:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781106373; x=1812642373;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=0SVN3Zfm3kqvDM5SZqLorfLj8mXccBI7Mr76yG1RgCs=;
 b=l8Zq/Jwmci9nFYLx5a+mp+bhsU8iteb59ZalIN3ZmnkzJPfMwjLkiCNK
 BZ6jCG+J0+jVxDMaHb9HOhKq58Nu8VCjWCoaxrpthvKc3lp+qsV/5V53J
 Tzl4k9frHAG9k4WTL1ojS811t/DgyQn9aZnMZ6KJZBKRedoWFFR/uRnG+
 5RYLEhycPLKUVq4btcbbyv6ekW6TLrWG7o+9kAOIVXvMabua2i7s68qsq
 bQ6s4NPO5gPHE8uyS7nFT24wZBrcZU2FCKAvORvNXFgJI8HZE1tx3Y2ns
 pbg+G002xbhUlIbXQ7aN8VhWO/NIPRtPP1JxKeDaEuYaSki+cH72WKFhx g==;
X-CSE-ConnectionGUID: LYEcmPS1RJGpFIZm+exxdQ==
X-CSE-MsgGUID: AalywqimT826TKK9E5Rufw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="93390593"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="93390593"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 08:46:04 -0700
X-CSE-ConnectionGUID: dCbW5w6yQz2QB2QaRHfXEg==
X-CSE-MsgGUID: tpJ+YoeGQV2I9XPdA/cq2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="270210057"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 08:46:02 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 10 Jun 2026 08:46:00 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 10 Jun 2026 08:46:00 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.50) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 10 Jun 2026 08:46:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xb5JWRTgkaXNGMnHI4CiJBEpjxDVwgzm221ogJfdzo+KkpGiNBAawFQtfB4GX/N1aTxC8dYgsmiR39gQtzUxnRGmbFFvEnASlSE3doj3lHCs0eUujZRF1tROsTsHr/umvrUWGK0Av20y1gU6xMgJIqwSoiAEc+W2Ah8ihWl+BUQjrJlQjkaDcPoBNTbC916GXOeUR1HI+HzM2OwmqwY11goiPLlPFGCNg9+OPZbpktg7GcovqlSJWcDUMx99seX1JZH/dey4F0/ZdZtuQTiWzF6bk57wW4ps6bucHf/CV+yLDXjZl7JH5oUx8qt0t7BMcAAP7K1RdUlTv0J2iujDBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5X8onizSCB5zH+jLQABC6dRMPDBs872hbNFxzONcsEk=;
 b=ir7FTmy7HOdeY80zHrOWNyKJxgB9Wn9Mz/vRtCOD7P4iPjaJjgEHH0ox86oAq5+Pr8LanVM/8W9d12DCplKYzwxiAOyurOYLRi/3Sctjl9gi3CVVL1SPRt35GM1Qc6biQ5SrbRFA+dddq0r3Fa7Yl3+TOAXBAi+qiAd/bJwX2gcKyrz9g63SOw8AZ253ILWVVcNRp691cdGRcdVAhElvnXgchyp4n+YG7IQL2DM1Ewbf16Mo4c8RgaCo7kYlYM+qxV4kRbKXCFDpu6c94mNRnQoaJEUDFWUm69xDasiXTT04VH4dCfJ7A3ifAACGqKXxhV3b0HPJSNjfHOOS0Iwsrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6116.namprd11.prod.outlook.com (2603:10b6:930:2b::14)
 by SJ5PPF7CF5FEA5F.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::838) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.15; Wed, 10 Jun
 2026 15:45:53 +0000
Received: from CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::7243:ab06:2282:cd8b]) by CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::7243:ab06:2282:cd8b%5]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 15:45:52 +0000
From: "Mandal, Anurag" <anurag.mandal@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v5] net/iavf: fix duplicate VF reset during PF reset
 recovery
Thread-Topic: [PATCH v5] net/iavf: fix duplicate VF reset during PF reset
 recovery
Thread-Index: AQHc+MDfEWfW2nUVOEO6n7TpQiZf9rY3nGQAgABSPSA=
Date: Wed, 10 Jun 2026 15:45:52 +0000
Message-ID: <CY5PR11MB6116938B45BF27B7344D40C3E41A2@CY5PR11MB6116.namprd11.prod.outlook.com>
References: <20260605202911.314359-1-anurag.mandal@intel.com>
 <20260610100704.366722-1-anurag.mandal@intel.com>
 <IA4PR11MB9278C1F04D8BB54089B361E58E1A2@IA4PR11MB9278.namprd11.prod.outlook.com>
In-Reply-To: <IA4PR11MB9278C1F04D8BB54089B361E58E1A2@IA4PR11MB9278.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6116:EE_|SJ5PPF7CF5FEA5F:EE_
x-ms-office365-filtering-correlation-id: b97cba43-1b34-41f7-29e4-08dec7075a5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|18002099003|6133799003|22082099003|38070700021|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: 552nHLehrjk52Hu+dTPwOP6HC6LYnVnEhHLO64Yg4Xxo5FZ+RmwryaOn04lRFgwawXvYUk9mnCSbIH2hFpPxT2IfJol6OmS8/shu3pcgNI79zsnk3Qs+iIa0DWUZY7suBSB/ZginwuHz/OOcOKh5N2A6WuYGnw1e0Ru4UrDGIit3MhfmiATIyxzz9dPNAmsujSjao2icxzvdt0R9hzH6ptJGefGDC3FbF0aVYoC/mfTKwaE2BuNbNM05E8E68ETt8nVGNGW+RZTuLc3lxnVsv4RmcvKSNAenKBtJSdeun1BGS7eHx2pG/4BgnLT6p0ahMrY2vsdrTJB4DU+flmyQqfeROM1A9+2NhDipPn5OVQeUbbmYYY7nu9gTlGe2nCiiz2Pq+ZhdHOCu9tN9DbBJMaERNd9d8r0qxcDd/1F+ivtFORRhfyvrxvl1ugBCuwmw+9EeSuW/C9Qb09T2bAAF4b8ypSmAsr0J5iRCFJL6gOJ+7cShRo7a3NnOEl3cGWA6YFEal4cdDe9jSKYJMmfsEbztyWZDj0TaGlKduS53k7LD9ZmjmHETRd2381ogVRizqB5s0qY0HCBQG+plwKVTIp2t6zhF6fkWH4xIP1WeV9rfqNr2X2Mg+mU5sVxY/crzPuROdz+7lMF0vBAraVQwcdXpQB1qkW6AV4hx7/rTSvm1vzdzRM2gDsvragc/tk+YsBqk+6AtKO1tjpPOzwl406GOIxqIDJDPKcqPvhqaWxHpgCAEuhgzqHWi50i+ULDI
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR11MB6116.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(6133799003)(22082099003)(38070700021)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ryOLz4R8m3MgUBHbLZbL9LfXVeFqY+1s5pFx3+kEsfLs6Gup4g0zadChn/U/?=
 =?us-ascii?Q?cWpY9pNLdRfJ5MKW2aVD2Z8PHB7x0segBNYy/kBuPmIzOyv8FEPzdSenxoRf?=
 =?us-ascii?Q?Wl4V0E4t5rbUZNmlaeQv5rErbHWxhyqZWl0Tpme/TJ/l2xFbuAegG5XXqJKq?=
 =?us-ascii?Q?cZ22kzxDbzZIQ+bL5/zLpzxN1sDYYoN0B+XHtbQ8pqpfZzvchDGUVp2DDLG5?=
 =?us-ascii?Q?behkhHqwxnokeow5QT5I81T55no2gCk5VUEWYajv+UlEq2OYbsMsW1lBZ2tI?=
 =?us-ascii?Q?XYy4ND96kRRwNa3AWfnK7ovZDeqNq5N9kRlHonjYg7PVUI7r5pqoqNwCTB1f?=
 =?us-ascii?Q?O/mEI8SSyDtJMMQLYXbJJkYYuieDNC0lbMmIxG66m1RbO79uBdFP1ZsNGbDh?=
 =?us-ascii?Q?8P1lSrCpcRjCBrl3CYXIwbVD+UawK13jivVHfWVkCxfcTMhbUcLDE5IDzzdl?=
 =?us-ascii?Q?GqGbEbpS4HKDbORBBu3vUOZambWWZ2R9S66S7P8xNDp6WaYV7utYVRyIC4gm?=
 =?us-ascii?Q?m6/o2bZm6/qx1rFNTli2HNIOPzCaXjETwZe9CJt+PxslqocyoAYbgEQXdqi0?=
 =?us-ascii?Q?SuSBeRlZCM2IU27sR3y3UEFxs0BUsHNRcH7OlcgmgL4mY9oOaqgmv4JdVW2p?=
 =?us-ascii?Q?mtLJP4J4Ezbh1NvMWfraY1iF6gJPpGaJ+ViY9nxUwpvLWW16O3vtE8Dgdelz?=
 =?us-ascii?Q?B2HIhc7ZGIlSrfwcEW6VzDr890TU99xml97PSd2QQMfOpsBrjfvzD7TKSoAd?=
 =?us-ascii?Q?9dIpEs9c0mlwvUEM5s9MLKANYlhfBmXujqZTJDJ1V0432/1Pha1zY4MbYGzh?=
 =?us-ascii?Q?0h6/IQ4kLmGaSUVlprSxbaa8KOX5LFFHMuuTwBV06VievxSjF820mPLA8LQE?=
 =?us-ascii?Q?2F+1Fqp16oxBZF1RXU0Gp+DOITnlB7LelyDTjnAtazB6OX8euQBzmm6JtUFT?=
 =?us-ascii?Q?L+uqOILDzHAqrNGC5FIzJzCWW9daevKvFHALL3Wd0St7z+GYKT4/nW4sC4MZ?=
 =?us-ascii?Q?gP2y0ybvnlj/RhYwDeMDVX65NdK2Pvpe1uYxzyWSTGfJfWmP45ZiJHr5pV5j?=
 =?us-ascii?Q?nJqGMbEiMlr3LG0xwJo6k7N9lExv2xBy29cjVo2RI4bZlKOTuPHMWq2+c/59?=
 =?us-ascii?Q?QpxL6s9aS1gznmEpdYXmNNzNbE8WpiVcHpYrdNqY5MZPESi/1hDnlG8ri00F?=
 =?us-ascii?Q?IhufE5fTcdbgGVD6SSdznxX4llIEWJmnggU8q0DqhHnvJJabuGds0Y63saC7?=
 =?us-ascii?Q?SfKCYHM3x4hDhhQLo8agMo5ydq2VDNLbh2KuX8Ff/SFhbKNBB4yNMfk7Rhdr?=
 =?us-ascii?Q?2OIiemUoQrSOfzoYB9dgxX7hsEsiJaL47BVibkWScfm7CBbxbwtiFD2Pzn1j?=
 =?us-ascii?Q?GX72BmoNZLcWYYm4G3YdTJ6/wzziAgA6TWNd8SZZ1HB30Mba3v/n9k+uHH97?=
 =?us-ascii?Q?qUujE+2YloEO2j72Qhy55mLjFcl7HsgN8D17DENZtNHEQ3s/g/xXz0ce87+q?=
 =?us-ascii?Q?JdpRTloYcz66DRzUTiPJG7j7HbiAJMETutxTwBZcfkRK5Xv0KWinmOwrdhO4?=
 =?us-ascii?Q?vMQBeGGiMDYfp+2NrIv4iVGPwnf+jdi9k2IDYn7Etbrf/8TfqKBUsH94Rh2l?=
 =?us-ascii?Q?6fl5spuQUqsCMT8/dc50qj2FItQJlUGLooq9d4nf62Iquvt70qgq6ULdv0ts?=
 =?us-ascii?Q?88JG8aliwpfNJdErRKl5j8hYHzw2lSqZOqhI8hCZ9MK9aT1itupbVPyM33Yb?=
 =?us-ascii?Q?tQqmSjd5lQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fRTXBSZSrLqiUY4YL63P2o7scrDYvK05wae+KkiyxNk0fDrIALvDSMGnfn37tnS6VrbpcSL/wO/IM3qIK2L4cYcViQSSu/5QDVVLBc8817vR/e7J4MZx53i7rj6WOfaYLc6tSZEAfucV18TXDweRKhLB7ItVHxiHcFpBjlL/gPjf7r7pHkXgn+ip7ihQ64TFNTsd/ataRp3DAlMfnHWPqV2mvDmjCvvSa/ZsFXx19xvt5Gw/OlQD4sqiV08TTaqiYZ7A0n5ZVR/0lzIB7xRhl7W1UhIilTlhmL92E3FVLgsdWJN4TBJ2K7DnbdHktW07g7dvbXV/w8esx+aE7TIayw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6116.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b97cba43-1b34-41f7-29e4-08dec7075a5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2026 15:45:52.7130 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FUqJqobByR9BGmnQQjOXEjhAgLoSZjgROUz8sgyLMSziuOKlHIG9GNSTqoDmbVVh/UAeF4gtEsBF44EDFfMLyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF7CF5FEA5F
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

> -----Original Message-----
> From: Loftus, Ciara <ciara.loftus@intel.com>
> Sent: 10 June 2026 16:20
> To: Mandal, Anurag <anurag.mandal@intel.com>; dev@dpdk.org
> Cc: Richardson, Bruce <bruce.richardson@intel.com>; Medvedkin, Vladimir
> <vladimir.medvedkin@intel.com>; stable@dpdk.org
> Subject: RE: [PATCH v5] net/iavf: fix duplicate VF reset during PF reset =
recovery
>=20
> > Subject: [PATCH v5] net/iavf: fix duplicate VF reset during PF reset
> > recovery
> >
> > During PF initiated reset recovery, iavf_dev_close() sending an extra
> > VIRTCHNL_OP_RESET_VF while recovery is already in progress.
> > That second reset can leave PF/VF virtchnl state inconsistent and
> > cause VIRTCHNL_OP_CONFIG_VSI_QUEUES to fail with ERR_PARAM after ToR
> > link flap/power-cycle, leaving the VF unable to recover.
> > This results in connection loss.
> >
> > This patch introduces a new flag 'pf_reset_in_progress', that is set
> > only when iavf_handle_hw_reset() is entered with vf_initiated_reset as
> > false and is cleared on exit.
> > Also, close-time VF reset and related close-time virtchnl operations
> > are skipped when PF triggered reset recovery is set.
> > This is done to avoid a duplicate VF reset, and keep normal behavior
> > for application-driven close or VF-initiated reinit.
> >
> > Fixes: 675a104e2e94 ("net/iavf: fix abnormal disable HW interrupt")
> > Fixes: b34fe66ea893 ("net/iavf: delay VF reset command")
> > Fixes: 5e03e316c753 ("net/iavf: handle virtchnl event message without
> > interrupt")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
>=20
> Acked-by: Ciara Loftus <ciara.loftus@intel.com>
>=20
> I think you may need to respin due to patch application failure.
> I have some suggestions for improving the comments/release notes that you
> could include in the next version. Code looks good to me.
>=20
> > ---
> > V5: Addressed Ciara Loftus's comments
> >  - added separate flag for PF initiated reset recovery
> > V4: Addressed Ciara Loftus's comments
> >  - split VF reset from other code changes
> > V3: Addressed latest ai-code-review comments
> > V2: Addressed ai-code-review comments
> >
> >  doc/guides/rel_notes/release_26_07.rst |  3 ++
> >  drivers/net/intel/iavf/iavf.h          |  7 +++++
> >  drivers/net/intel/iavf/iavf_ethdev.c   | 40 +++++++++++++++-----------
> >  drivers/net/intel/iavf/iavf_vchnl.c    | 18 ++++++++++--
> >  4 files changed, 49 insertions(+), 19 deletions(-)
> >
> > diff --git a/doc/guides/rel_notes/release_26_07.rst
> > b/doc/guides/rel_notes/release_26_07.rst
> > index d2563ac503..f6899a78c3 100644
> > --- a/doc/guides/rel_notes/release_26_07.rst
> > +++ b/doc/guides/rel_notes/release_26_07.rst
> > @@ -95,6 +95,9 @@ New Features
> >
> >    * Added support for transmitting LLDP packets based on mbuf packet t=
ype.
> >    * Implemented AVX2 context descriptor transmit paths.
> > +  * Prevented duplicate 'VIRTCHNL_OP_RESET_VF' during a PF-initiated
> > +    reset recovery, which earlier caused virtchnl state corruption
> > +    and connection loss after a top-of-rack (ToR) link flap/power-cycl=
e.
>=20
> I think something more concise here would be better.
> eg. "Fixed duplicate send of 'VIRTCHNL_OP_RESET_VF' during PF reset recov=
ery
> which could cause virtchnl state corruption"
>=20
> >
> >  * **Updated PCAP ethernet driver.**
> >
> > diff --git a/drivers/net/intel/iavf/iavf.h
> > b/drivers/net/intel/iavf/iavf.h index 2615b6f034..67aacbe7a6 100644
> > --- a/drivers/net/intel/iavf/iavf.h
> > +++ b/drivers/net/intel/iavf/iavf.h
> > @@ -292,6 +292,13 @@ struct iavf_info {
> >
> >  	bool in_reset_recovery;
> >
> > +	/*
> > +	 * Set only while iavf_handle_hw_reset()
> > +	 * is processing a PF-initiated reset
> > +	 * (vf_initiated_reset =3D=3D false).
> > +	 */
>=20
> I don't think a comment is warranted here, the variable name is self-
> explanatory.
>=20
> > +	bool pf_reset_in_progress;
> > +
> >  	uint32_t ptp_caps;
> >  	rte_spinlock_t phc_time_aq_lock;
> >  };
> > diff --git a/drivers/net/intel/iavf/iavf_ethdev.c
> > b/drivers/net/intel/iavf/iavf_ethdev.c
> > index a8031e23a5..2b6f4daa99 100644
> > --- a/drivers/net/intel/iavf/iavf_ethdev.c
> > +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> > @@ -3166,23 +3166,27 @@ iavf_dev_close(struct rte_eth_dev *dev)
> >
> >  	ret =3D iavf_dev_stop(dev);
> >
> > -	/*
> > -	 * Release redundant queue resource when close the dev
> > -	 * so that other vfs can re-use the queues.
> > -	 */
> > -	if (vf->lv_enabled) {
> > -		ret =3D iavf_request_queues(dev,
> > IAVF_MAX_NUM_QUEUES_DFLT);
> > -		if (ret)
> > -			PMD_DRV_LOG(ERR, "Reset the num of queues
> > failed");
> > +	/* Skip RESET_VF on a PF-initiated reset */
>=20
> Regarding the comment above, here we're not skipping RESET_VF rather
> preventing sending virtchnl messages to the adminq during the PF-initiate=
d
> reset. I suggest rewording the comment to reflect that.
>=20
> > +	if (!vf->pf_reset_in_progress) {
> >
> > -		vf->max_rss_qregion =3D IAVF_MAX_NUM_QUEUES_DFLT;
> > -	}
> > +		/*
> > +		 * Release redundant queue resource when close the dev
> > +		 * so that other vfs can re-use the queues.
> > +		 */
> > +		if (vf->lv_enabled) {
> > +			ret =3D iavf_request_queues(dev,
> > IAVF_MAX_NUM_QUEUES_DFLT);
> > +			if (ret)
> > +				PMD_DRV_LOG(ERR, "Reset the num of
> > queues failed");
> > +			vf->max_rss_qregion =3D

Hi Ciara,

Thank you for the detailed review. I have addresses all the review comments=
.
Sent v6. Kindly review.

Thanks,
Anurag M
