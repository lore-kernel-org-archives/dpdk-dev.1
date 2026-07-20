Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136FFC44527
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Jul 2026 09:56:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AEC2E402AD;
	Mon, 20 Jul 2026 11:56:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 9C921402C8
 for <dev@dpdk.org>; Mon, 20 Jul 2026 11:56:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784541391; x=1816077391;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mTnmIZO5IPMZjj0y5ZqlcDr9hA038s2cN3bbzOSmvwg=;
 b=F+hmuPqWC8lGGDUbEUrv2rni9xPaoBHSCT1xeb50kiSrX5QlkjHp3aPa
 Gj2wMLA5doTnm0VMA2NCR84UkzCnShR8Ub0LO5Oc9s1q6leIhN4l5On62
 yvAwYkArjU51egYCIukiKWjNI0tLSKXY+XL/yfLDzL8xH+KrBjVe/+Xc3
 TCxVYPe1q8J1+rlW8W7jykeT8GfFJ8ggpJz93PaqkeqU3vSPNxXge3Wa2
 JwESdjfRWRQSB8frvIiBRKuTMGYK2hDDAc0Aa4vkCcxQ2cpckKFKZca7B
 /jeFKJuzpgzoUnq/yxEIMkpZALQV8UJNGEtomhVugjtSGAFB9Wz8PTU0A A==;
X-CSE-ConnectionGUID: CIzGliugT5ecYNcWCkh9QQ==
X-CSE-MsgGUID: ZivYnA3wRZi5WJ6NsPA8Fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="107906324"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="107906324"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 02:56:30 -0700
X-CSE-ConnectionGUID: dumNNehFRbOzrQGfePdkww==
X-CSE-MsgGUID: 0YcWNONTS7mqidHXbyFWHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="257481935"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 02:56:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 02:56:29 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 02:56:29 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.10)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 02:56:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TOtvBmpEZXSbs0C4gVS208hO3LlKVQhd4VeszG+RcNxfzbMZJxRtFf8IKQP8ZFLilONUNm5GjDbckW78D321y2v6XnUQyiSrlPYysLLFvF4iHJTAHynNcbLTSyKQMLnOYAqEBGBEK1jon9KbS9eDZnHkuc3c/YG4dzRnhFKI3runEh952j6Wiq/bYN2qglMfODN6swX8ZZdnT7WqIPr87d8k1zdN4pxYQiKYAPcn18oaAWlDZS8UAMSmbp/2yeRjYhmn2NOqtrHhIcB0CrkaL5WOmHdw171JALQ7Kdes4K/Buu1erQtcFGow+4AJYCz4K0Q/oP7bHrGHqMKtudYzOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gG98WO2SA2wdCuhQWox8R4GGcQMZ0uQ3IQS9fOHkcHQ=;
 b=LWVoRTI32bJ8UIty29JavG+wvSWkwS8g0w1Creoko6upC5hyWjzIugLs+J+1iAwQk12qzF25Se3nw4IBdvPXDVZRKmbejfK0bFpbA/PPg6+6wxMdkRPdK3OxypPf7FQFSk4kPlrPoANaI4li9Jh79mmxIK+HQ15d0JI8ohNqpigB95kygsRBFBiDsQnPQC9yl5rMktaWDp0WXebcZyo0CGS2txZvRqmNiclFfNEDdjty23aekWEe4qiTL4LC5MvF98Eo4xK+8pNwd8jbplputz0l+6Ovlbh4YCOTym0rVDkryaZ9Sj1QA6M8shp1ZFHrEAiv6vyG9QdVhKP2TUXBDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF00BBED10C.namprd11.prod.outlook.com (2603:10b6:f:fc02::5)
 by IA1PR11MB8864.namprd11.prod.outlook.com (2603:10b6:208:597::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.15; Mon, 20 Jul
 2026 09:56:24 +0000
Received: from DS4PPF00BBED10C.namprd11.prod.outlook.com
 ([fe80::39c3:b214:8d57:23fa]) by DS4PPF00BBED10C.namprd11.prod.outlook.com
 ([fe80::39c3:b214:8d57:23fa%8]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 09:56:24 +0000
From: "Xu, HailinX" <hailinx.xu@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>, dpdk <dev@dpdk.org>
CC: "Hosamani, Manjunathgouda" <manjunathgouda.hosamani@intel.com>,
 "Puttaswamy, Rajesh T" <rajesh.t.puttaswamy@intel.com>, "Richardson, Bruce"
 <bruce.richardson@intel.com>, "Mcnamara, John" <john.mcnamara@intel.com>
Subject: RE: DPDK release candidate 26.07-rc3
Thread-Topic: DPDK release candidate 26.07-rc3
Thread-Index: AQHdEjrSQk7SuOkIh0eHUHuw3ajqqLZ2MFHA
Date: Mon, 20 Jul 2026 09:56:24 +0000
Message-ID: <DS4PPF00BBED10CFE374C1284F5DCA11F269FC32@DS4PPF00BBED10C.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: ac829c22-5f97-432f-f3ed-08dee64528b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|11063799006|10067099003|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: zN+EetjBRfn/PASbXgGsO/wcQ03GKNmCzIQW2syYWW8OPr0Noxp7EtSGss4ToJYTrFwEmoQaP8ZCGoYi/MF4EDM+UwsupbQk/nTde2wlAgm8QM34YK/wS9JTOqAE91sOElULMHd7ruS/iESe1AaCC/FH+VZ8DjmbM/AKRD+EgoNFUaG1Y61qxQkPZyelueoLLG0kZyc951JpaDt+DeujauQOOL1QP1mey8kxIJ9/Ki/x8l5l1VIOV0nzg1phKqZZ/0V7MAEu8NoltNDrgXIzJ3jdsqYxMoDc1kBnyLkB+yscaauCg9+l7GTVCOh1sj6pcSCumqPV+g4Wnf3HmbgwqR5Jo0KU4UhAnbuPFuVIjpO2AIGxnKs/xd/pZBalP73wXhEv9myY6pZGpHwssBMhvIbkngOc1o5DaO7sqIuGuv9HgeObZ0lHPamfWQDamS/mBRno3QOOQts4NW3pW/BYkzbX04yhxQLNvVRhJC0wtG3jXdDeaNtjREuxruYIzsw3YCCHM3rBdV2jscXh5aHTNNvaz6oLG1pVn/RnRI8ApGpdho8xhS1fU8rYIFZw9GdAN/7fJuH7LR7SceMj4y/ArHS8GfMswg5CVEbJkdTxLDkxw/LLjadDa9Zj61ov/devXrZlyuIaWC6tJKZK6nZxNgSzS/nA475CrVoJvNXWgXk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF00BBED10C.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EZHTFOwA9abUIJ8ZMr45szD2jPTcXRW7FQu4k3ezhYI0Ou9eRkjb0hoHJzO/?=
 =?us-ascii?Q?vp4woT5xHFCB2l3lc2IyIstLkBiaivvND6XUwl9JIlwBdmxbiJr3IrJKUUin?=
 =?us-ascii?Q?9U9AqQkclUJbl8yLBf6wr7PiosyBwctmu52qyv8sOobgC82IIflglaJJT/S2?=
 =?us-ascii?Q?Om3B18U0UK0GQZa18Eu1dU6FcaA+1xByN76NJGixDW40qGxZaL8P9k71O2K2?=
 =?us-ascii?Q?4eaeXKDfIqv+edhZ/jkEl8VAZ5ewMUY+dnL/+v8+leIWL1gFFkPHNvIF/Jkl?=
 =?us-ascii?Q?4Xv0r2Uay6zEFlLIf1e9Id9KbgwZaduBIv0BzOnGbkEtwGUro6qu+1IdjpsA?=
 =?us-ascii?Q?P3PH3ibkkdf/BaoieuhxPtGy1jJ2cRb5bBwYbPubkKjEheqb09x0skak0qs3?=
 =?us-ascii?Q?60dJOuZOVTZt2leOx5GTogDqJl+/4ysBGsIPOCzUCp5QP+20C5FPkwTXkQKG?=
 =?us-ascii?Q?N/pU9YqI03ksCCom+xq8HyPrbp4ILn1I7QgHwxcOysLIwOjvTFMPxD08PVg1?=
 =?us-ascii?Q?XzCvBPmXnTTJG0GRY+QqPOnfGI1tnFs1sJ1EAeLlvIpSlrV8RuZ2kU79bfny?=
 =?us-ascii?Q?kCLtfF2jZbyn77wYCy71b7ScLiVN5IOF4ynaLJzqfBz2+/dyNOX3bwMDffcP?=
 =?us-ascii?Q?mXoOGrkSY2etURkslvFS6k1Kz5CSGE8vteEU+kbNAdp655VBy6ThsY25mox0?=
 =?us-ascii?Q?e4T2nWQ958KyENtnAtjZN0p41VPZN7jP6mOLWjmffAesRKC+nsBbx+CQYnDm?=
 =?us-ascii?Q?dVBhAo28v+a78ZcOVAz3rtZAXD4yBk1HZvIQ3NqRBAuBPX9Cw2xrq8t6OyAq?=
 =?us-ascii?Q?Jde7YIdt+qY97PTM/iVD2hzjsQ5SujFWlpN4ggva7E0Li6fY3A8wPwjzouQL?=
 =?us-ascii?Q?TkQJztQwk0ZgAfo2xOfpwBJMQh1BMyasBaXm00nJxNSj1+pJw1i9HJaafQbG?=
 =?us-ascii?Q?Z4OhBn7XUOSVCuBbHcWSd63oejBP134dc0WtRP6hc/nudHvYkeiBFQnAxsM7?=
 =?us-ascii?Q?D9jMv46xfboKK0oF2vsRJbegWQ9bywaSZBSSwAQhjkqTHzBylupYMf2a8qwC?=
 =?us-ascii?Q?fY2Wj/QyvZY1qxWcA3cMQwwb4udHAdr/O24AUpuyrZNBe94kFDksTQk82KBU?=
 =?us-ascii?Q?ckNM+dokx9KWJi8L3YOfDVUKDnZEpg7lQIN+OWweOHGDX6MNWoxd7ydxPfPm?=
 =?us-ascii?Q?UTHTjh2XIPK8izfl/DGCPE6nVi9hgcVKOjWuy8HR0+OVDpX4F0pUbvTRAyGZ?=
 =?us-ascii?Q?3rOQ/tv1cQh4rd3RjPd5jLkmlZCnRTL0V/pGF736s4Ziv+ksYf04+XUZNtq1?=
 =?us-ascii?Q?4B4s6UdKWpevBncGNvEtqgg0vNaMleVN0CSr+m2Le2D+oWEaisnxuNaQDwrf?=
 =?us-ascii?Q?nRAwq64/pPIasirCM8kveZqDF/fjpwE9+ueIlM6bPpSyTrfMwyv24o58d3QF?=
 =?us-ascii?Q?8vZJXHKUvHjQXhXYa+GeTEtg2FwBu/b7+FDydrVuF2Dg/3OuIX05BLS8AJmp?=
 =?us-ascii?Q?g41/vZk+dFUwCS1Sa+vKKjC865h4LhXkJ/tM76q4kWR7wcac/ZQoh4VHs21v?=
 =?us-ascii?Q?jkr3+VQuDONQyrrZggScmHiyetIMUUu57+JK7gUurRE9b+6Riv03+lExuYMo?=
 =?us-ascii?Q?TDjf19xHvZqQ3RhcdJ1Sfu9at5zo0kYcpOpcuXzebC6KaLkT2GSaUOJWzwqQ?=
 =?us-ascii?Q?hUSy1RMT85XiUJtFIEDyV/FGxNTpCjW5gzKQFFgUQt4b3C38?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: q0r6A7LcfLg2tx1KftDky1KkIAxSVjB6jJO8zZs5oSXdGpyabFnmVAFLGOiDFPQVhPf6HgMrBAdgSxvVq/P0nTGxFXYrhYx5JR4TODz2SQulPyWuZiFHrRDCPP976oQKMwNQirCz8WMXcnndw7064J4ZVt4OanRQXBAdrd2ag9LcI4Y3f36e7lO85XXDrP79r9MI9V2DwHF9ZI6YbIXcPjU72T3Rp1V7/WdscTGTV43wcbLELio8V7RVc67uuhNvsPK/0Ozq60nTAW1qVzNcyK1PxmuefjsEbh75vjdl66oUsm+BDt+tohKfJTXEKnmRLAqiu6T0mrsWYx08ABlqjQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF00BBED10C.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac829c22-5f97-432f-f3ed-08dee64528b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 09:56:24.3243 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NvuVOpbnoVGWkIcGcGoNUC8smtEQXhsfuf0Osv41RTzfZjq2K6CvAl1zwV3oeIL4Jr8lXUCRmY72OfOh1P679g==
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

* Function tests: All test done and found 4 issues.
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
