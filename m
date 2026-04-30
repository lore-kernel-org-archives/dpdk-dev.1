Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E0EFF8875
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 01:29:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF7654028C;
	Thu, 30 Apr 2026 03:29:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 2A64740280;
 Thu, 30 Apr 2026 03:29:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777512584; x=1809048584;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YepdGIIbUDxt3v1KXJcSkqLRnzKaVk7G3bKTLdndg+0=;
 b=X6NKhc/3fYaqTFYQJWM5DIoBvr9WPk0j4i9DyRRpO/Q7cMKX9I1oDCN2
 P7SY1JqsNIUqUxurWfBP8SxO8uhrGp/TC1AoeveHfJVhCrZoH/FExOKaD
 WvcMl6BHNRHlMtCCMOnWaMxHlEGyjMQUE47nZq+dagqLJXx74aTpWyEou
 9+Qma4PwW00d/sKsdShjT5LEwssEklyzXvttcjADR1ceNAChjiC/ryGye
 pkHxGKJNApXzwPTFVcrRtnXWQYFRRLNpG/R+W9fjOm+GgT/q0ahmNR9lq
 Npz9PcWTyJbvlU8rK3iFePBYc0sKLvgu7/k9nVVe1YuSneVNpM6i0zyGX w==;
X-CSE-ConnectionGUID: VZAUy6p+TSu91Ge9hxs/Pw==
X-CSE-MsgGUID: 1ClBs4jrRXG8fyQRFyqWQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="89547908"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="89547908"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 18:29:43 -0700
X-CSE-ConnectionGUID: kA8zAJxsRCiJm1pA5opqUg==
X-CSE-MsgGUID: 4B4GeKbMRk+24QOjH1mVVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="229833506"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 18:29:43 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 18:29:42 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 29 Apr 2026 18:29:42 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.13) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 18:29:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BRhbaudrRb9sv9a5XM2L/mXMTr7bHn+qK7l6wYtTTJM7EXvAUeSJotDpeXxLC4nqO9KtxUCdXleJrUo9Ox/yr7XRUPRnuxRDUDh1aq19+pm8yg4YEF0vvyuYSmkI0OZ/uiGIsvU80M3AQtNE1ovXxKxToaFfp0sAOhHmUegv3leSgQuWvtZUXrjIsB2vyvVOFT7LbcX6R0zdVSREw+lHyEUBNYZOKDbStulvU3Qp5rYYatpi4bkXuc/FM5s8JzEbsP/8/t8x98el2/kv8j8NgDif5Wbkn+/nmd/97f/IpZC2/a+nb13+BQfh7aboU7gO+RAtfjhIRvpELhb6FegitA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNOC7cf0jWWDB5GAQdSArg3YyZvoQy9l2lNM0/+w+5w=;
 b=ZzYUeOSHU3V1QkDN60aqjYds1yzrifqc15c319PxQdX3ILVgkZb3s1FLJZ+XAjSCmkeCfZsUWhdQ7+69AA3Zws2jkoB4MuMrapivyvPSupvcBT5fDo0eE6vPmMmBrKk3isJLErfZpBycnLxR3aUOaaW/23Chrghbrq+ivQ7OBu46bbTVdYNDFGfC9kryZL4ZI0R4nQKP4MINgyg9puR8rJ63/UKtZd0jHLbYPIVcp+GCeZ/MdkYDaThk3TvPiKvHrUvSBrIgJCEjUT6z2bmvIT6ZuUVYGoA1YXgCoTx4+mrbJAndjpNSs6Q7xIXk98EYtT9ok/HhAVCSy4ku/LIgCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF00BBED10C.namprd11.prod.outlook.com (2603:10b6:f:fc02::5)
 by LV0PR11MB9814.namprd11.prod.outlook.com (2603:10b6:408:382::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 01:29:40 +0000
Received: from DS4PPF00BBED10C.namprd11.prod.outlook.com
 ([fe80::e1ba:9b4:57d2:3cf6]) by DS4PPF00BBED10C.namprd11.prod.outlook.com
 ([fe80::e1ba:9b4:57d2:3cf6%5]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 01:29:39 +0000
From: "Xu, HailinX" <hailinx.xu@intel.com>
To: Shani Peretz <shperetz@nvidia.com>, "stable@dpdk.org" <stable@dpdk.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Abhishek Marathe
 <Abhishek.Marathe@microsoft.com>, Ali Alnubani <alialnu@nvidia.com>,
 "benjamin.walker@intel.com" <benjamin.walker@intel.com>, David Christensen
 <drc@linux.vnet.ibm.com>, Hemant Agrawal <hemant.agrawal@nxp.com>, Ian Stokes
 <ian.stokes@intel.com>, Jerin Jacob <jerinj@marvell.com>, "Mcnamara, John"
 <john.mcnamara@intel.com>, Ju-Hyoung Lee <juhlee@microsoft.com>, "Kevin
 Traynor" <ktraynor@redhat.com>, Luca Boccassi <bluca@debian.org>, Pei Zhang
 <pezhang@redhat.com>, "qian.q.xu@intel.com" <qian.q.xu@intel.com>, "Raslan
 Darawsheh" <rasland@nvidia.com>, Thomas Monjalon <thomas@monjalon.net>,
 Yanghang Liu <yanghliu@redhat.com>, "yuan.peng@intel.com"
 <yuan.peng@intel.com>, "zhaoyan.chen@intel.com" <zhaoyan.chen@intel.com>,
 "Puttaswamy, Rajesh T" <rajesh.t.puttaswamy@intel.com>
Subject: RE: 23.11.7 patches review and test
Thread-Topic: 23.11.7 patches review and test
Thread-Index: AQHc0Vq9otTlKI9MNkqeTXIbjtieN7X23Yfg
Date: Thu, 30 Apr 2026 01:29:39 +0000
Message-ID: <DS4PPF00BBED10CC6595A70B04B9F7704AA9F352@DS4PPF00BBED10C.namprd11.prod.outlook.com>
References: <20260421064637.2506152-1-shperetz@nvidia.com>
In-Reply-To: <20260421064637.2506152-1-shperetz@nvidia.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF00BBED10C:EE_|LV0PR11MB9814:EE_
x-ms-office365-filtering-correlation-id: 8ab5248e-9d2b-466c-8f5e-08dea657f2cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: uDhtKq33+8nFUaBQl1Y92gB0ced+pve01gXz2jiYXUZzznfNmhsaEbPD+563le4vfSLrl5e40eyaLI+1jwH5jQC76ytwwU7SS05N7MUos4gNiV/Je6pgK/6vgOvP48Uq0vLhzTrujBjM2f3MZPNbgFmdRkURQNizezM5RyRqO/uRvhSzfQH+00zwXiy+orkAsymkceOyM8PjBm9aSaA71qVArLYLwjwdVPsIxyGF6cz7f7OucgGl2pVLy/oZ23E1MacRc12e3sl1iz2q6S3wlz0Nvvb2FrB5Dz6RCR+JozwgGa/Q4d/9hAhCfeXVqZqnL3FHJUDpyaztMvtDJkvyNONY/ptN7KoBzoIIOQ1qNQWf2zhKwgzvNadLCQcp2PiePceqdKJPbagzpfBqxLDi6PkjrlzvaqADIxiApCVyUVyn99TRfYOhtcsAlOgMVbx4yVeHO/MXbDK+3/cPMoMslFZb0fGt4zqm398ZypHsXmIm1GqMgzgkeWWaMq28rvPC97bOYFehsQ1JZ2Mhb77p4q1TtlrZse9dW08L3bpD2Au0+9wOkaTPK58JHcISQOOsJJHRqLWpmycL74UdKNM+ggysvHg4JhF1YxqVCkY0jGu81LVtP4NgzryEu3GuMbV3Is2phFe+re6ybnze+P/vW/jjkmXrxq35Vz9aKV7CWnVCA8/sx6quFG9QgC8uABGAPMHq1yJMET72+3UBPU/NjGWz34854N3v8ZreXoeiNPV3N89ngfgMAoZt3ir5wlYEl1Y4r5LQWlwb4k2cNYIfEWhXPRKBLNg7zZ+Un4RYN0/x7ku76X0Y46o5LsZ5JtvH
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF00BBED10C.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4WEPD5NpXkP0Asg8TT09sD3VIJgoZ01iDihw/Eo8oIPC5J3hFBrIW8+Y9clm?=
 =?us-ascii?Q?aTmLp3Lx5rIL6JHpOKjYY4UPS2n3EukRWfMBMT6J2Wp20IJ6RdElx6KUEpCQ?=
 =?us-ascii?Q?8UyvUxhmg5nThff5Fl4Mtl0KXlmsAgiHCQjJUoHD5b6+j4By2ydkn/HFNadc?=
 =?us-ascii?Q?bYotdra1BLFe4NJlwPGWZlqsXumZp6VWX7a/5DjDh0nLG9dqKawPrcq9QnFW?=
 =?us-ascii?Q?8wDkeyu4alaEkauuRXihE35MlCSjSiJEgGGGRNfCrzmKG/0zctyoVd6updr2?=
 =?us-ascii?Q?5Xl6ZwRMOGje1Yrya9jg7TqymaPJiez6TwbCer4KzX0wLPlf/HuVaEV7tRKA?=
 =?us-ascii?Q?TXc0cyu0wiNwxzU29O/iu49ywwip5jgcnVH03Oro3T4YMN/H+JSUnXLSjwUv?=
 =?us-ascii?Q?CFnyz+wBCAhlx5YQqMsZHaPLpMaAnTnq79H+ZsYMtEqymwCg5mMc50JIC+M9?=
 =?us-ascii?Q?1jVFoi+FwVA+CdnpW9iMoSNyLHi3Bhq38vrSW8lo62QCZaatXwXa79VaJ+Hx?=
 =?us-ascii?Q?jdZ+8SulfgIz9YelLuw6UcAR5bVIXHdnMzmCSUio1iYWgafpeBuTjFUAEU2X?=
 =?us-ascii?Q?guQb3hj+hQ9c2LxKz9tqrgkbh8td9h7B8o3omF8PqSnlnopPN9saNqv84PgZ?=
 =?us-ascii?Q?90McxTY1HC0gmDPj5TdWgzwKrtIXeyyC8YbfbkPB8Ku+3B0QKFnA5MkHBgjU?=
 =?us-ascii?Q?pKScyrm16/MWscrR+N7s9/vxu9ZwkQk8bggSfySylRtui2DR6OWnOz+14YSt?=
 =?us-ascii?Q?PnA20ZZHAi05FIOGGfqD34iwW1OyrPVpjU674d1jtmrs4wvdr2VYLwDXX6Dn?=
 =?us-ascii?Q?Re/NcIb8wBweUpABMFA0c3YywdRulMi43jaaXPjVPr9KB3cr1NGf8gfyxxYt?=
 =?us-ascii?Q?OD3v8VbWojwRKQEeqW9rfhYizwEa3bN9hc/vhcHhHzRi/aEH59QGjwXOmpHf?=
 =?us-ascii?Q?mnJtDL+37NbLp6UpEsX/NliDYPG7uY0U9mjx955DvD+dFO7CcVX1DdQntkJ9?=
 =?us-ascii?Q?wkpG4nThNZoU4S7Vb7YZCmj8f8v5P+7IwnWEg2neb/zfOOus6SlQ+VhADITd?=
 =?us-ascii?Q?95zX3debMWz5HBJ5ixJW/kLVRkssFG0PhiTc4ejNMG5XIDpyvT48JiLr5rw3?=
 =?us-ascii?Q?b9TFDEkHe636MFY9JClkeQ2TgHWfC+v3eqXByzeaJRd2qX/oLkXC+ugU43Xf?=
 =?us-ascii?Q?G31+fvZ/8mGmDPqAEXkjGpshUTOuyJjL25/YRmag9OMCvLim1hKsCiFiQn2q?=
 =?us-ascii?Q?/BFlyfHYGZ2GiSqShwz2R8V6o2fb4U6IwZcKejgWsOmXkzTx0T53x2768gkZ?=
 =?us-ascii?Q?GX5Fm2LwxwSBYvBJRTJLvUV1cGDDsiyLxzgoGwy4/gTzRvLdfj+Rlr0RyyS1?=
 =?us-ascii?Q?oTy5WIw3n0WXQ1kUnm2K8HU0rd4vOiS0ze972MpB48ql/+yOZ8Iwo0SBzLa7?=
 =?us-ascii?Q?YC5si4SxyjZY1S0VNBxkIjVnIHypJLGonbHVoxd1pJngUQRH0t18Wkdbz/o0?=
 =?us-ascii?Q?xdWbseR08aOoeoAnuE3sU2kMNJ+nhXsAfaSzE02SQmwdNPn0c/aqkMl+nDth?=
 =?us-ascii?Q?Sr9TzUk9VqVX/8t7ctUGAM9yYsO/kQXq4vYQswOu6IyNCHi6S5m8FVlkYlXH?=
 =?us-ascii?Q?dDbvCgZQCmT8NhwtPbQUzorrs4hef9BQQI4lYGdziYe72oJ6cZd+h/8YATyG?=
 =?us-ascii?Q?mIwZ/x60Ee3UFVRM8bMvzSWVMJXhy2HVAdOwwA3siwT/HXym?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Hu8f6spODO6taf7XPQTOYn0q549wYJC9aAnawXwTMTasvYs0/VtGBMTctbGXmBE3j+Yb1SXJfGHIicbnuVuxLgWZhQBzybl5Abod76BWVVIzXUkWV+lJspMZf85qdQGmpayb8YUc9bSYOQwJNJfCdGAOf6drZtBGBrw8lrp+yx3Oc+gMrZWFfjlmn1iRgH5ruyIN7yi1sqsAyc6G3KShNb5OzYag0wK095mqvT7CsBtwFbpErZifufo9o7XMzOA2ibKfM0SLZh2cq16EKgRipb1v+VMK/w7gB6IyKBcRVBU9paob5TVc+2kAfYovX7z7+VNx1Gb2qF4HW8ccsDGBlg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF00BBED10C.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab5248e-9d2b-466c-8f5e-08dea657f2cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2026 01:29:39.8668 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dCEYkgxi6RHqYbGjFR174o/DcD9aARTYCSQeZbwvsU/m63xOpbdvCvjAzGj9NtRbVaIhNM3XTjKzJvN4NRL6Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR11MB9814
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
> From: Shani Peretz <shperetz@nvidia.com>
> Sent: Tuesday, April 21, 2026 2:47 PM
> To: stable@dpdk.org
> Cc: dev@dpdk.org; Abhishek Marathe <Abhishek.Marathe@microsoft.com>;
> Ali Alnubani <alialnu@nvidia.com>; benjamin.walker@intel.com; David
> Christensen <drc@linux.vnet.ibm.com>; Hemant Agrawal
> <hemant.agrawal@nxp.com>; Ian Stokes <ian.stokes@intel.com>; Jerin Jacob
> <jerinj@marvell.com>; Mcnamara, John <john.mcnamara@intel.com>; Ju-
> Hyoung Lee <juhlee@microsoft.com>; Kevin Traynor <ktraynor@redhat.com>;
> Luca Boccassi <bluca@debian.org>; Pei Zhang <pezhang@redhat.com>;
> qian.q.xu@intel.com; Raslan Darawsheh <rasland@nvidia.com>; Thomas
> Monjalon <thomas@monjalon.net>; Yanghang Liu <yanghliu@redhat.com>;
> yuan.peng@intel.com; zhaoyan.chen@intel.com
> Subject: 23.11.7 patches review and test
>=20
> Hi all,
>=20
> Here is a list of patches targeted for stable release 23.11.7.
>=20
> The planned date for the final release is 30 April 2026.
>=20
> Please help with testing and validation of your use cases and report any
> issues/results with reply-all to this mail. For the final release the fix=
es and
> reported validations will be added to the release notes.
>=20
> A release candidate tarball can be found at:
>=20
>     https://dpdk.org/browse/dpdk-stable/tag/?id=3Dv23.11.7-rc1
>=20
> These patches are located at branch 23.11 of dpdk-stable repo:
>     https://dpdk.org/browse/dpdk-stable/
>=20
> Thanks.
>=20
> Shani
>=20
> ---
Update the test status for Intel part. dpdk23.11.7-rc1 all validation test =
done. found 1 new issue and fixed.

DPDK build failed with clang21.1.8 on Fedora43:  -- Fixed

* Build & CFLAG compile: cover the build test with latest GCC/Clang version=
 on the following OS(all passed)
  - Ubuntu25.04/Ubuntu24.04.3
  - RHEL9.6/RHEL10
  - Fedora43
  - FreeBSD15
  - SUSE16
  - OpenAnolis8.10
  - AzureLinux3.0

* Function tests: All test done and passed
  - i40E-(XXV710, X722) PF/VF: test scenarios including basic/RTE_FLOW/TSO/=
Jumboframe/checksum offload/mac_filter/VLAN/VXLAN/RSS, etc.=20
  - IXGBE-(82599) PF/VF: test scenarios including basic/RTE_FLOW/TSO/Jumbof=
rame/checksum offload/mac_filter/VLAN/VXLAN/RSS, etc.=20
  - ICE-(E810, E2100) PF/VF: test scenarios including basic/Switch/Package =
Management/Flow Director/Advanced Tx/Advanced RSS/ACL/DCF/Flexible Descript=
or, etc.
  - IPsec: test scenarios including ipsec/ipsec-gw/ipsec library basic test=
 - QAT&SW/FIB library, etc.
  - Virtio: both function and performance test are covered. Such as PVP/Vir=
tio_loopback/virtio-user loopback/virtio-net VM2VM perf testing/VMAWARE ESX=
I 8.0, etc.
  - Cryptodev: test scenarios including Cryptodev API testing/CompressDev I=
SA-L/QAT/ZLIB PMD Testing/FIPS, etc.
  - DLB: test scenarios including DLB2.0 and DLB2.5
  - Other: test scenarios including AF_XDP, Power, CBDMA, DSA

* Performance test: All test done and passed
  - Thoughput Performance
  - Cryptodev Latency
  - PF/VF NIC single core
  - XXV710/E810 NIC Performance


Regards,
Xu, Hailin

