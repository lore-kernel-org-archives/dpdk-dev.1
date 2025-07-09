Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31584C83F09
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 06:18:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 222864021E;
	Wed,  9 Jul 2025 08:18:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 893F04013F
 for <dev@dpdk.org>; Wed,  9 Jul 2025 08:18:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752041917; x=1783577917;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=U1RLht7oeaewDP2L7SToQOkbbUlzEmJSwEV6yYJBzIw=;
 b=k5TTb+3/tyDCXLxQ5V0a72eDGwkG+ri9T8RyzkLfJto721d390v9ccCL
 WR7gJHXDu1K2kYGO1h2cR0hC9qr2dqL54g2wl3yQaKW68yJprUxuZGaHW
 Y/qjoXiMiPli3RiYzHnFPMTNoibV2CeiXcHuzzU4pkP2kuergyIoWHd2U
 mHjToGxCVmC+YDiAf27d/U1B9MZyuvUgXythiJ/CK6ceRCz8TluT5FRvz
 AIcbnPWGentMxobCB+bMvqMtKmyy17V0Ht6Ffay97uXe2wyzrOywSvMx2
 BAbemxry3RuRdBVc7XAg7yd5gn1k89Ym+uc62wqdnAMZAe31B1nzvKMaN w==;
X-CSE-ConnectionGUID: VKdcMEaSRIOAPufB6ouT5w==
X-CSE-MsgGUID: TRrB0OqUR4OIqLpabdfrhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="65744439"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; d="scan'208";a="65744439"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 23:18:36 -0700
X-CSE-ConnectionGUID: yoA/wOwZTPuwj3siXexAZQ==
X-CSE-MsgGUID: FdUrKx1gTWeqqJbjMkti2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; d="scan'208";a="156268867"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 23:18:36 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 23:18:34 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 8 Jul 2025 23:18:34 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.61)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 23:18:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cQXq/R8k8AizPxhBCXukvHVVa17ISbG34cErAs0LXvkJRIUz5PyKQlUTn6sbet3Q76xsTV4j5/yEB+fQOd4YvmCwwLoOBP2ZFViEoa/u+faR6h1pUb9ewAsUBM88IL+FblYFiBC2dU1FYzXelqacl27nMrbggEjuDHhx3UP/8CyPjNzDMWJRdg37rqDb7J1lHw7SjqkAC6nFaxSZHziFhfRN4QZ2jSdxO6JPTRlW51t4qypT6TSefeGqd/UOZ/rTcADdC06SOGCY/oz5K3aOFD8N9qZcGGaE9lHrclclXr8/Pib8Wetnubrdh0QLs5u9CgVBLFnhCdk2JOMk7MCKAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W33K4VxCZCyG/WIk7y4JsmZbn7BdOrQIIbp5ccYzxa4=;
 b=hblc/xv+yEfoZN4wx9PHihdAzPpyUW4TZYYTUNy1coxjOmO6+uVUnGYtT9mQUDxN6dEMsehPCcFCXL1ztZb9PZg/vw655k5rD4DOHJT6htyuMp8lFWR6QSXpLcGOCvXN3tcnidjP5WQOfKFOJ5BelGfeqgx0R0XfWvb2mx3977kORay3H875noq3tiBQG8ak8G1ZgbW69DfCnI84E2HCsatMavIVSV/IY5HCu7Ba0xvtxZr8ZeUa47LKv1UZ6LEyiowQyJgWeq7/yK7CrGt5gkhzw/P4e7+Yqa+c6hicOnCbLfA3jvrUNNK9wkhayooumcYAK7fM32lcpn0K2jRouw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF00BBED10C.namprd11.prod.outlook.com (2603:10b6:f:fc02::5)
 by IA0PR11MB8377.namprd11.prod.outlook.com (2603:10b6:208:487::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Wed, 9 Jul
 2025 06:18:04 +0000
Received: from DS4PPF00BBED10C.namprd11.prod.outlook.com
 ([fe80::ebe9:c1c9:bd2c:7051]) by DS4PPF00BBED10C.namprd11.prod.outlook.com
 ([fe80::ebe9:c1c9:bd2c:7051%5]) with mapi id 15.20.8901.021; Wed, 9 Jul 2025
 06:18:04 +0000
From: "Xu, HailinX" <hailinx.xu@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>, dpdk-dev <dev@dpdk.org>
CC: "Mcnamara, John" <john.mcnamara@intel.com>, "Richardson, Bruce"
 <bruce.richardson@intel.com>, Ferruh Yigit <ferruh.yigit@xilinx.com>
Subject: RE: release candidate 25.07-rc2
Thread-Topic: release candidate 25.07-rc2
Thread-Index: AQHb6UWI5GDmsIkDZkiHHTlE6ymBwLQpXlRQ
Date: Wed, 9 Jul 2025 06:18:03 +0000
Message-ID: <DS4PPF00BBED10CE0C2D48E401F9B7A89049F49A@DS4PPF00BBED10C.namprd11.prod.outlook.com>
References: <4829359.Nya5fj1elA@thomas>
In-Reply-To: <4829359.Nya5fj1elA@thomas>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF00BBED10C:EE_|IA0PR11MB8377:EE_
x-ms-office365-filtering-correlation-id: 4d64e738-959b-484a-ca8e-08ddbeb05cf7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?pzJOhu9N0LcvqOzXd6JfAyoEhq2zw5sWTYz87a8zoF2dKD/uv8RkHC5pN4J7?=
 =?us-ascii?Q?eX8rii1eqgSCmFYoZ8CH7FQlzVw30zoFtLD/nXdG9worasezum4vvi6OEttK?=
 =?us-ascii?Q?ZY0slnmYY5ncuUMHe/Rw5UYPTLdq2itS0iZG2L0l659ldUJhr6xfhm0QijuC?=
 =?us-ascii?Q?4JbE1gc44ZVMI1fwFAsyKqaLveghgohiMbGx1z7dT6QEaMMw9/iACVW02G/b?=
 =?us-ascii?Q?DWz/ZQJyzy5uq3KV+fcWQFdG32MvNCQ4zBu/kXIGgLE3NVcreVYgeKbzv/gZ?=
 =?us-ascii?Q?j5z52E8UwCzx78hbRZK8s/PSUOS/v5Eq94p1sZczGPIbQYrwBEnEVqfoSrQq?=
 =?us-ascii?Q?c2jm19/90O6N/4MJer+5b2kR2QByae6iGqm/H7bhspMU7P3q4YZLQqoiNrPb?=
 =?us-ascii?Q?e/y7TxTZ8fHpaXgB5svdeyUz3Nn9yLDR1DOp8spBa7RbWXJhrAR5SqvqqTer?=
 =?us-ascii?Q?VHXfA8uE1ldXpdZgHUI/bAsEVo9JI2o6RN+0fNkZJAwyq153wUAfvGQHHOzU?=
 =?us-ascii?Q?FVmpUlPzEmdcXP3m7YSzjBnFHwQQYD9+0H617YU8nemjh0ld88f7E8/QjLEg?=
 =?us-ascii?Q?S81Ekpt6jrUsC/BUHNjxXDYQN+Ou+pcE1w1olat5/mVpUlgHYGWpKl3sVcZs?=
 =?us-ascii?Q?htaAtzU5YXcyn2igJ3KcX1kLV3vOLVsxKaV6KdrwSYymvRfpTqTSaMWigtiG?=
 =?us-ascii?Q?uqhy15CyxQLltc7vKQC/vRyVp0X8Lz00tB/cUFGQ1IOHN+dZuwN4fp1BPJT3?=
 =?us-ascii?Q?F7QNLkauoYK24CaYSkvlvxXTb7PQ6Nt7qBuTVMLXUYO/gKMXU0Be0bJygw+N?=
 =?us-ascii?Q?a1+zqjUgHRZLdbA4s59CWzVEb+jF/ao68eXfbwtRcjFLNGvwchcoxTfLHQ6R?=
 =?us-ascii?Q?jqHi2gSYsRWTW+T2PYuxKzjrbtsc98KzwAassY7I06KF1/dVT4o0YHuYeROw?=
 =?us-ascii?Q?ljay3oCkXpKZ/VgZQpJlLHtMCuR63UCpCAiyAvIFD/q4mqTFlb23vYMZ+vrx?=
 =?us-ascii?Q?QFC6xEX+jHS7aWtWy/nBqYAs0ctKDKo9dQSpPyh0Swe5afbtsaailNfKn2Wz?=
 =?us-ascii?Q?60Ord0/BOATLzqBpUFrHL5GFFggtMovfjL0h83792wLPmfvo/7Eb5HqTFJoQ?=
 =?us-ascii?Q?mjEtCyhHWFF8xWkv9vhITV33BGUya6zge9Bim09ulw7zMOejHpa2+MXJS2aT?=
 =?us-ascii?Q?sIwHMdkqYru3LU2RhHA98aaHpVvmh7yAk5kL3DIi2h6oS8Q/oZP5fR4wZJMa?=
 =?us-ascii?Q?5UTquJVe5+LjioXL1e0fFLiGPM1945iLCc0KjTo8Nv3rXBom2oOjELCbCPDE?=
 =?us-ascii?Q?71M8ZWgiiYGixNkbEiBsn7KAScroHuuj8h2jFCRGK/9nZo8hZlRGDJJH5tuz?=
 =?us-ascii?Q?W0+86ogyDca9kn0IPwWz6oJNPMcZaZ7nyyf8SH9SdV/lynzqcLjG1gMzHuPv?=
 =?us-ascii?Q?sesgiQVQROc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF00BBED10C.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sDdo+hBVuclaqmdKOtdVGXx5bNP5H3i8HVvoI76RNA4axWzXL4ydyysd388N?=
 =?us-ascii?Q?LbE/h5ndeNU25xwM3FpJOmo3CbLya0FiNwgyxYhtIgns6GkqgUcC8Nwz4sOV?=
 =?us-ascii?Q?nYEE6guAMEhjX+bSdXlSUHP+BBVbGafU5nBbNoH2Vf+qiJEDKqkFpwtZ2s7O?=
 =?us-ascii?Q?8cD8Ny0BAo4BknOZSYfZ/SdchXT9P4xbYe3tSwYyo24B4Sm5SEf4y9ISE0BL?=
 =?us-ascii?Q?WTr3q0CIVZC7wbIMCf/bmBAJpsYFjhAUM2wDr4OZIVT6Spej4fM5NIeAId1H?=
 =?us-ascii?Q?JsCN/uUuACzLYtuZsQPtTK4rlyX45XWPrFjmpXLeHPGVpVRqIiCDe6XQbtLj?=
 =?us-ascii?Q?hXO3wX+nKEjcoECuQfOpFVxALEfCMIT/SyvTFveXc/m8fRSxb238tG6QpBzy?=
 =?us-ascii?Q?dU+R9CGnUhHQUKS+OPckNZua5J0Pjbl8K6oZNqHOAUXw0sXqf4Hw2xOOkvgd?=
 =?us-ascii?Q?Qf+24W5u7V7rrtd5QWb/96OODTWKIjhu30Bm93+C0GNEd7VIKQR2SG1Kz5UT?=
 =?us-ascii?Q?3jnqaEi0DuC8SAcOK76+d21ct0MoitPlT32bXXBulQDl1BVSB55FsGWBr6dZ?=
 =?us-ascii?Q?35oL8dUiNAgnXSvSvgXUkgEVlqadjgVMEXif0R4i3PHJ/hi/hgjzFUvN0XMg?=
 =?us-ascii?Q?sx+cALYooknqJPNGlACft+sjNU5clLbS6o0mSSILQxsl4UUBmBeNDH8bwuHi?=
 =?us-ascii?Q?AJh0txIIQBC5aNUNDswzroTMWuTZQx4IcDkbg8PiKTbGT2f5blWEpAy6+bDO?=
 =?us-ascii?Q?YRmZz1xuXE7YAHCYoh36UFLXCcyTuSEZ3hYgUKW+KJ+5z9k71HaSaoba6mlS?=
 =?us-ascii?Q?XVMuXnwQqLchSAc/9gTdvJyLi1M3sTOKMeLJi1BQD69Sd5ZKnvTl3BMaC2tE?=
 =?us-ascii?Q?4BBQfMilUGiLSD0wkzDzhMdf68nOcuBSMWUa9lkiGbexsZVCHnVEc6wDK0kB?=
 =?us-ascii?Q?m4Dm7THOZlId/QLtWfS0duo0kTRd/QthaW4ZWgTMtp1/IO3IL+QsyFPNY45I?=
 =?us-ascii?Q?dtqtwwAq+bNvjP1luXM2flDA8hE5EuOD0wEZdo463Uf3+Q+c0impXV2vB40s?=
 =?us-ascii?Q?qfUD5EIHxWnrJLJnHJCFgbMdHelh+R3kqNNtuuzIA11XlwCbYsWKK+DHP+pz?=
 =?us-ascii?Q?DwgZMBj8uAVTpDBDPGh1/++FHlSxUhfAkbIZsmwNjSdNCfHxgSVGgoK3p6uh?=
 =?us-ascii?Q?/LC7jUJJU3BcetNRj6gGC/gCk0mJNmOnxqyS6vYTSUHQRONli+HfEkaSC8Ru?=
 =?us-ascii?Q?V16pGsF9AOqGUya9sV9xVh8GRhFd4UWruK3Jws1PPohNZgQ+qdYXI0QPtz1a?=
 =?us-ascii?Q?yvNSlW+XjZwxII5QewGua8mCgWOt1m2jNAqRM3ObAPaeVDSj1YCUdMdd0F7N?=
 =?us-ascii?Q?3+TAhRsiexZ9vRsI+uDAIpWGZbRA+fnrXJYScg91d3AQC59q7wlOdCgVSTro?=
 =?us-ascii?Q?CAWhN94dQfm9+dwso6m1WG1kToVBmGBVacUBcJKaroDM2I9zRTCP/L6CnSXy?=
 =?us-ascii?Q?4ZtDozX/znMqTR5MPUx5VqyUVAAp7P1ibPYqQ5PTBu1kKsn2ITojCUdvXxDh?=
 =?us-ascii?Q?wVzwxaAEY9nKcEWY0P+XK+369Xa/OVEVler7G7b1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF00BBED10C.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d64e738-959b-484a-ca8e-08ddbeb05cf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2025 06:18:03.9242 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: smv3s+wuDzrt55wtKWLBc9ijbdCxZGYL2aZ32k6vX7XgAggFjNZC9oN64+MQvvzjnXt9jTk/vUXSW+wytOnnWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8377
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
> Sent: Monday, June 30, 2025 6:31 AM
> To: announce@dpdk.org
> Subject: release candidate 25.07-rc2
>=20
> A new DPDK release candidate is ready for testing:
> 	https://git.dpdk.org/dpdk/tag/?id=3Dv25.07-rc2
>=20
> There are 141 new patches in this snapshot.
>=20
> Release notes:
> 	https://doc.dpdk.org/guides/rel_notes/release_25_07.html
>=20
> Most significant changes are in multiple drivers.
>=20
> Please test and report issues on https://bugs.dpdk.org
>=20
> DPDK 25.07-rc3 is expected in one week,
> with a focus on fixes, tests, examples and doc.
>=20
> Thank you everyone
>=20
Update the test status for Intel part. dpdk25.07-rc2 all test is done. foun=
d one new issues.

New issue:
1. [dpdk-25.07-rc2] vf_pf_reset/test_vlan_rx_restore_vf_reset_all_ports: Un=
able to receive VLAN packets  -> has fix patch=20
     https://patchwork.dpdk.org/project/dpdk/patch/20250623181136.48239-1-a=
miyaranjan.mohakud@gmail.com/

# Basic Intel(R) NIC testing
    * Build or compile: =20
 	*Build: cover the build test combination with latest GCC/Clang version an=
d the popular OS revision such as Ubuntu25.04, Ubuntu24.04.2, Fedora42, RHE=
L10, RHEL9.6, RHEL9.6-RT, FreeBSD14.2, SUSE15.6, OpenAnolis8.10, AzureLinux=
3.0 etc.
  	- All test passed.
   *Compile: cover the CFLAGES(O0/O1/O2/O3) with popular OS such as Ubuntu2=
4.04.2 and RHEL9.6.
  	- All test passed with latest dpdk.
* PF/VF(i40e, ixgbe): test scenarios including PF/VF-RTE_FLOW/TSO/Jumbofram=
e/checksum offload/VLAN/VXLAN, etc.=20
	- All test case is done. No new issue is found.
* PF/VF(ice): test scenarios including Switch features/Package Management/F=
low Director/Advanced Tx/Advanced RSS/ACL/DCF/Flexible Descriptor, etc.
	- Execution rate is done. found the 1 issue.
* PF/VF(apfi/cpfi): test scenarios including cpfi_rte_flow/TSO/MTU/Jumbofra=
me/checksum offload, etc.
	- Execution rate is done. No new issue is found.
* Intel NIC single core/NIC performance: test scenarios including PF/VF sin=
gle core performance test, RFC2544 Zero packet loss performance test, etc.
	- Execution rate is done. No new issue is found.
* Power and IPsec:=20
   * Power: test scenarios including bi-direction/Telemetry/Empty Poll Lib/=
Priority Base Frequency, etc.=20
	- Execution rate is done. No new issue is found.
   * IPsec: test scenarios including ipsec/ipsec-gw/ipsec library basic tes=
t - QAT&SW/FIB library, etc.
	- Execution rate is done. No new issue is found.=20
# Basic cryptodev and virtio testing
* Virtio: both function and performance test are covered. Such as PVP/Virti=
o_loopback/virtio-user loopback/virtio-net VM2VM perf testing/VMAWARE ESXI =
8.0U1, etc.
	- Execution rate is done. No new issue is found.
* Cryptodev:=20
   *Function test: test scenarios including Cryptodev API testing/CompressD=
ev ISA-L/QAT/ZLIB PMD Testing/FIPS, etc.
	- Execution rate is done. No new issue is found.
   *Performance test: test scenarios including Throughput Performance /Cryp=
todev Latency, etc.
	- Execution rate is done. No performance drop.


Regards,
Xu, Hailin

