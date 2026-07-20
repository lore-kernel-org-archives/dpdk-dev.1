Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3625C44527
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Jul 2026 09:58:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF65F4064C;
	Mon, 20 Jul 2026 11:58:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 0932C4028C
 for <dev@dpdk.org>; Mon, 20 Jul 2026 11:58:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784541492; x=1816077492;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=sG5HjmuqNisKhtuNMKku8KceFxPVfFqm8Y6hmW7BI1g=;
 b=YwPpEefxZvw0OJlsRY3wzCCwWV97tW/P+u2T5sdjC4qw8dhG+GhE7amF
 lqpSmNk+gLTcBpzCfeAFN4Zqu0thp5ExL6DwNkpjQDZc4c/7AYBWMiKmm
 NJqBwN473Rng3GSkr2VMN3IDnPSO7ON09KNG3wqKZb9+I7qbp5eMCe9UP
 Z88Sqwt9YnSYfOMX9HaShRq/kZ0mpdDofqttJpVlOxGHuaAKPd+wNkuPB
 GSnHCyAnNXpIjQP7MZMHIOLTJxASwpBu4he+koFZPADMK/nPLUf+4oZGU
 bRO2aGI7br3nzxA8UgBrJ6uhw0xLVgJXc5bbxdkdng0+5TMgtCm39WDd0 w==;
X-CSE-ConnectionGUID: FOd3GfxTT8Kr14eY+taToQ==
X-CSE-MsgGUID: 0r5WXq/4S4Cd8qZAUmGr9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="107906897"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="107906897"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 02:58:08 -0700
X-CSE-ConnectionGUID: MpRdLSgURnOv7g431gL6gw==
X-CSE-MsgGUID: wKvzfhwnSnudKF3Hip8wbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="257482811"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 02:58:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 02:58:07 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 02:58:07 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.44) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 02:58:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rAgTZ9b+z+AIvacX2VkvNDEhaBF5g+HPyQDMmK0pl18DxW7Xw73gYxFsDPc/lhbBp/VIJWTPP4w/jCtFz3CGZvOU+WzXDBfrcaJs1xHBeHhSPXmYijd5tMMRDfafqUBGNGZPYoRTVU5GqAyTDHfJ5dX33JaN4dXV9n6tWOIY7SxlH2BU88evV+VCeFCFyFqDEZi34qPc7JHLuYWi0ReB3aXntMCKg3RMFuDCtjy66aNlRF4wOW78nKe2irg5+8Lm+2oQFURrQ6NAnvm2fgLyi12Em822AbcpPSbqCK3zjuS0AhTMiT+tvYibWadLIuE9lpTTWacCqAIAxXNDT+S+uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mN8wSByd1vxdml6ZjpP/d+5Vo2mWFno5WGisM0b0HdY=;
 b=ZhnK0XcFscibRNZDeJg4YloJRH+QQPpsmggreHlysxaaz/j1Rk6n7zL7a2tDelRgG4Nalgg4NirXprY32zNh7ksQIPm8qnO3b1T8c+CaE+S9WM7kIvpB3xkyQXkAIsOxwyAQl8sJMkGviHYL9IrKyk156hF0ZDzI5IRpiWt7U5jazm6WDzbHZ3C61Nl1h0ei9novU54MA1k4i1q5LEgf76NF0BETjLcRD7VXv3IY19K1TDraDl9mcrTuGk/5ygUaKNnG4JYS2TVIyIVn2w0HSW7ydgVrTQpvhcLZtL9WErcKS4x10JP7fH268FrENMU5DIeFSJGfHG5OLsEsLOFVDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF00BBED10C.namprd11.prod.outlook.com (2603:10b6:f:fc02::5)
 by IA1PR11MB8864.namprd11.prod.outlook.com (2603:10b6:208:597::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.15; Mon, 20 Jul
 2026 09:58:03 +0000
Received: from DS4PPF00BBED10C.namprd11.prod.outlook.com
 ([fe80::39c3:b214:8d57:23fa]) by DS4PPF00BBED10C.namprd11.prod.outlook.com
 ([fe80::39c3:b214:8d57:23fa%8]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 09:58:03 +0000
From: "Xu, HailinX" <hailinx.xu@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>, dpdk <dev@dpdk.org>
CC: "Hosamani, Manjunathgouda" <manjunathgouda.hosamani@intel.com>,
 "Puttaswamy, Rajesh T" <rajesh.t.puttaswamy@intel.com>, "Richardson, Bruce"
 <bruce.richardson@intel.com>, "Mcnamara, John" <john.mcnamara@intel.com>
Subject: RE: DPDK release candidate 26.07-rc3
Thread-Topic: DPDK release candidate 26.07-rc3
Thread-Index: AQHdEjrSQk7SuOkIh0eHUHuw3ajqqLZ2MFHA
Date: Mon, 20 Jul 2026 09:58:03 +0000
Message-ID: <DS4PPF00BBED10CFC26B4BC2DB144A3EFBA9FC32@DS4PPF00BBED10C.namprd11.prod.outlook.com>
References: <74T0wdLsQL6DTJtar0xt1g@monjalon.net>
In-Reply-To: <74T0wdLsQL6DTJtar0xt1g@monjalon.net>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF00BBED10C:EE_|IA1PR11MB8864:EE_
x-ms-office365-filtering-correlation-id: c82ccf34-45cf-4d88-80b4-08dee64563f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|11063799006|10067099003|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: kuo4tnsFdX50o0iFCYTIzC3bEIXqxlCx3X4XhQRtsp0yoIvyjAZppTPSfAO+dqRCxtCpoSnuyTET5HMk6AdEbsSPySuD8JZx6nCWDqT/hlSMrW3GhVDKuKvK55EIg28Gl3NZLil/IwxT5kWuVH5qi/dFer5UECRB3mplyp0rrwF0z2+lQGz9PMuq7UMCxjYYATkGrJ6frdWvny0zDo7e5qMCt5feOj7Hi4YgIV97Q4qQsUl2I69D+hlTRFyWFixDIdFijQ9Ov8vijg8EeA1l3PYrHIjOmi0bG9xNxxmTpRnEEploNjTUOK4Sjm+kJiv+D/aVgN2lL9MMYHnYem7U0hbWak6sN7DJ/iK8One9scYARpujVEUgZKZiisYglVbJTfKHJjKWVk2soie5LN5Hh57BZIxVX4XpCMTNTxIyWTGbelFsx/3GZofhh7ETWVvPjU0PBx6CGqeTnhCtmkOu5176UlvBckuxFMHR2Hc4b9DQrZAtaznTxHrl2Bx9E+ZX1PKkhf37sfMpSWxhSUJpqGXU0E8mEBKBhGqRz7khkoLUv35uGPiEU/FFdapGTFoo/JinNuUerAt6gwFX2tc480a7CW0bRJEp6R8h3YldF2SSlYY283xCd9tfg01hq5/RnuyWTxjbGEeV9rgRYzQLjRKStUMuO/eVXeZQsm9B72AQFFTefYJQSHLEgm1ItgBy
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF00BBED10C.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TRwBwa0VuGyVvkFtFFxwCpaamUPxDJoDihMNEX7xoC2yxpQcoRkuZ4brWu2Q?=
 =?us-ascii?Q?Y/Y3QHivEsqmgJaPloE7fGbI+rcljpBD7hSpOKSSviqI0zY1pgg8iYqR7BJ3?=
 =?us-ascii?Q?nD3JLR75IQrBT45hPEPgiguwN/2EaBbg2Klgh9Xx42no1iKEaxPtSzNnR8EM?=
 =?us-ascii?Q?1jcAwppPPEufW81k+9gHLW8B0JBlfyo1UePjkFb7++OJR2bCisW47zwVr4kf?=
 =?us-ascii?Q?hr65VWi22h+yUO6e4eq+BiB8T+ybJs80Sc54oa1qOEGGueVKNU8XJjt+QZuj?=
 =?us-ascii?Q?eQRzdPfY0EEKWudk10y5JpZb83T9tM23jbOU1PoXB3/hG7M80vozhnuQNKXx?=
 =?us-ascii?Q?N+zqM46Faidw9XQbuctiyuqehNytU6b+Zbo+c5bwJgNS+ZEMGnEn07nn/G6S?=
 =?us-ascii?Q?+ohcoWyBKmJckSuklnOq4uJqXXSq/Kj0ogIoa3OKS4JFBwZInSyHh2H/r5vg?=
 =?us-ascii?Q?j4IwqEPWJiA8R/XvHv6LWKHcMXUQJ8ROLiWzT2W3ycjywxoDnK1mthqvD4+c?=
 =?us-ascii?Q?5Rcu5vA5CriHcNX6mBE1Y8/2EUyoEdxk4jZOl7ULhW07mKa82BSq3hBRUql9?=
 =?us-ascii?Q?s7pbxnN1TfYVq9D5O9peC6oXuRVB2fenajR4XhPrDVNGQPJUt11r7OOHxFDs?=
 =?us-ascii?Q?WR3AZSveifgF0r22cpZPVcj04l7PKr/tyeBt15dO1AgMyLJ45PeV5kBgBcl2?=
 =?us-ascii?Q?qgSzOvgVN+amDrwsP/SEXvfiTsRmAdak1nom+uUuDtzDQN2ofMmrS/rGhZS3?=
 =?us-ascii?Q?rqUvxmc+1NqD6pEdoh4yTfaVq0VSLH0dcw1TseRjIhL2wHiEvDHdiLgovAId?=
 =?us-ascii?Q?GZpxdgNo7+nh6j+1mkszATeEOxD/6GK94HZTjlRc4gJCIo7rF7UdXxoKe+qf?=
 =?us-ascii?Q?uA7HJd4WJ621F2D5i3gaMKsaqu3NjnLMoerz6z/WYD3E+1WS+iQNAdNJtOSz?=
 =?us-ascii?Q?dCMgHGGsmddrQpycvjzosRSEsjmZGiI4iIgs7DR1eLYLvmM9eQiv3k5m5Yx/?=
 =?us-ascii?Q?UXcPWQFwo1SIs82uEmkQllz1B+VpUJpJoFcN4fB35ABWcUkqQU0ZN6BSaV0B?=
 =?us-ascii?Q?EvL2cSyydm5T0x4RkayxLWQi2aVgzmAlBTCBrxYgk4s9l7Abs2Thjv/Hu5+r?=
 =?us-ascii?Q?joA4RHx9PIFizFmG6CUqnhEmgvqTuBYBp32DxOvusjM8uYI67TnV59hd2K4k?=
 =?us-ascii?Q?2fY2E4zh4YOYt39qb1oe0OVUuUQ4OjOcTDK30q8EOP0efg1DtkwFQwh18s0b?=
 =?us-ascii?Q?K2uP1y27DD+o1SHHKu1/ZuEW2Umq0jx7BXF6rCycgwXq2up72oMclpMmZozI?=
 =?us-ascii?Q?wpyYU3/xad6wibu6xMD8ydjppqcpQ0rDKy9IX3pxHF6ZBwRLPZKf8Ks338tF?=
 =?us-ascii?Q?EvOBz3MI8j+RKHbFfPukH3iCh7Jbqitj0LjHv7o888nFSikSx7NQ/odSm5uV?=
 =?us-ascii?Q?UkKnWXmF7VPlzHKVsKXCxV+oDQfVnR50fz9yxlHwp37w7jbXXh8D1CDWukNA?=
 =?us-ascii?Q?0dRbgB/0avskzSVmgabehmeUVoPXRIz6qZxkgeV+xsPRgX3UCczvZFAXXUmP?=
 =?us-ascii?Q?7TGFkw/dFnVGfEPvD3AyFYBeXliohILuBRhdtoXFnkxdKhZcoWsESUDwphdO?=
 =?us-ascii?Q?kdRvINxtxZlcmlBR35HxdKNkJwPzGejddSn0W17PIAekblB1i7oCPjpS9ftT?=
 =?us-ascii?Q?WFV1HLdEypjVJ3k+dWID3GQIGOD7at7Gra1sem9b4Rc3KT2H?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PaiSGi7qin0IL8ATaSJ8teY6bN+gH2sL2iIq8Uz/0kXP5QV4/tXsQf08tfq/hM/DuiDfIG9GKdbStqUnS08kEEnX+3gq93HIXSCHZifPJg69UehzmXFN6/I5LoY6RJ+/H22GqnReWvduYptDeZS82tzgY6Wkf+pRu8gg7nj3ZmBRsKYx92wXh7xxznr2F6f7BAxYBd2YcUoYPP8mXoviBhwkfkhOFBYG9Luj+a7XqqPClN8sYM7nMdtojXB5STzfzavEZqwm/Eln6rRGZNEbie9YAnftNGEdrvt9X2lnR8Dz7c4W24uhms3ulvA49kLWjAHFlyqDkXC3Op4/Q7a+aA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF00BBED10C.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c82ccf34-45cf-4d88-80b4-08dee64563f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 09:58:03.7017 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QGkpH/ldLFMYFP/Z481POW3rrBnwcG20Kh67b3MNwDOWDtVQM0jIWPTHNkUsd7pMROZ9W5K8/L5R6gums7EgEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8864
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
> From: Thomas Monjalon <thomas@monjalon.net>
> Sent: Monday, July 13, 2026 4:12 AM
> To: announce@dpdk.org
> Subject: DPDK release candidate 26.07-rc3
>=20
> A new DPDK release candidate is ready for testing:
> 	https://git.dpdk.org/dpdk/tag/?id=3Dv26.07-rc3
>=20
> There are 88 new patches in this snapshot.
>=20
> Release notes:
> 	https://doc.dpdk.org/guides/rel_notes/release_26_07.html
>=20
> Please test and report issues on bugs.dpdk.org.
>=20
> You may share some release validation results by replying to this message=
 at
> dev@dpdk.org and by adding tested hardware in the release notes.
>=20
> Only documentation changes and critical fixes are expected at this stage.
>=20
> Thank you everyone
>=20
Update the test status for Intel part. dpdk26.07-rc3 all validation test do=
ne. found 1 new issue.

New issues:
  1. vf_vlan/test_vf_vlan_strip_avx512: Failed to strip vlan packet!!!     =
       -> has fix patch
      https://patches.dpdk.org/project/dpdk/patch/20260715225234.482186-1-a=
nurag.mandal@intel.com

* Build & CFLAG compile: cover the build test with latest GCC/Clang version=
 on the following OS(all passed)
  - Ubuntu25.10/Ubuntu26.04
  - RHEL9.6/RHEL10
  - Fedora43
  - FreeBSD15.0
  - SUSE16
  - OpenAnolis8.10
  - OpenEuler24.04-SP2
  - AzureLinux3.0

* Function tests: All test done and found 1 issues.
  - ICE-(E810, E825, E830, E835, E2100) PF/VF: test scenarios including bas=
ic/RTE_FLOW/TSO/Jumboframe/checksum offload/mac_filter/VLAN/VXLAN/RSS/Switc=
h/Package Management/Flow Director/Advanced Tx/Advanced RSS/ACL/DCF/Flexibl=
e Descriptor, etc.
  - i40E-(XXV710, X722) PF/VF: test scenarios including basic/RTE_FLOW/TSO/=
Jumboframe/checksum offload/mac_filter/VLAN/VXLAN/RSS, etc.=20
  - IXGBE-(E610, X550) PF/VF: test scenarios including basic/TSO/Jumboframe=
/checksum offload/mac_filter/VLAN/VXLAN/RSS, etc.=20
  - IGC-(i226) PF: test scenarios including basic/RTE_FLOW/TSO/Jumboframe/c=
hecksum offload/mac_filter/VLAN/VXLAN/RSS, etc.
  - IPsec: test scenarios including ipsec/ipsec-gw/ipsec library basic test=
 - QAT&SW/FIB library, etc.
  - Virtio: both function and performance test are covered. Such as PVP/Vir=
tio_loopback/virtio-user loopback/virtio-net VM2VM perf testing/VMAWARE ESX=
I 9.0, etc.
  - Cryptodev: test scenarios including Cryptodev API testing/CompressDev I=
SA-L/QAT/ZLIB PMD Testing/FIPS, etc.
  - Other: test scenarios including AF_XDP, Power, CBDMA, DSA

* Performance test: All test done and passed
  - Thoughput Performance
  - Cryptodev Latency
  - PF/VF NIC single core
  - XXV710/E810/E825/E2100 NIC Performance


Regards,
Xu, Hailin
