Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B831CA5FFC
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 12:06:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9827840A81;
	Tue,  6 Oct 2026 14:06:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 27CC3402B0
 for <dev@dpdk.org>; Tue,  6 Oct 2026 14:06:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791288413; x=1822824413;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=8dWWJKo9wsh5A3kJfRa+032+vhWrKop7h48OxEu1xT8=;
 b=UozFolGwnpFJYG8658awtaZd//58ehd+IVyBkbKZirFDV7JiiTT/scSJ
 HhtX80WTSHNtwQ6PeM3Mdo9dO3FTZHL0lr9V/5iJp0EbhsLXpN0WPZ/oB
 ifsw5jQ+TFSvXNx8gAPcoLHVFjQbmQzNd8KEeobPStc9CGIB4INHksYAi
 a14pkp3NbR9HCHS7A7AsbRvnVoeEjlwj9joDDSzvfhMXYu05oG3S1ei4O
 DQHmp90vrjPBazqbHQFQu4U7S1C6kOGV+W+mEfzRXKInlsr1hc1kWkAz5
 AAdQeccQVH9HBum9Z4b8mOD9t0LVvkWO7ycLA2rxydB1LtmSOb2mD2Yb0 Q==;
X-CSE-ConnectionGUID: cKjDDdiWRT2QhBmT62shIg==
X-CSE-MsgGUID: LZvelVLSQVC/Yck1LkQM6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="24727"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208,217";a="24727"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 05:06:49 -0700
X-CSE-ConnectionGUID: rAkqIujuRGGliyWj700eBA==
X-CSE-MsgGUID: 35qzZiA2RMa0tlS7g1JAwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
 d="scan'208,217";a="280421547"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 05:06:49 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 05:06:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 05:06:47 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.56) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 05:06:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eb4QUYGWYqOFE1xQ8j5nZpg9Y8WCi/CHzruQl8JtSbO4QzrygU+gxKlFlkuuEoRzuAkWJYJepuHJwr42iaXtVZ7UYEp44EDHlubR8PyFFY9OKAz/RsCANUrygoXEpCYvpEeo0QnyP0Aaa+5cmm3ATdYJ9mN7x/VjK9u9Qwyj9p9en8dwZdT1xQMBS6g3ETS3IbYhMb0SXRGUPueIfoN+UgMyuV1RYWMFNbobOfcDDIPP2ZjdsF4ZZmE5GJU2aPUSYm8p1+0ugdgeUzgHttZR8B8+Ne3I/GGYi3pwftabB2kxEC3IN9akPsLxE/R5xjU3ZysSo9kr+s63Dh+qOoZE3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spIte/1BL+xJM6LS/xyKiMl9mZ0Pr+tBOrsh2xQZ0pI=;
 b=dO1/jL7R6EZawoq6Ctv/79na1+kyFIGWC9WAzVb6YXCYb1hAH2M5EpvbVQ5orIhb/Or5lQbD+I6sncwPdhMfxtoCPafvMcx5vNJIx6NHlbBSk15CZclaCE1q4aNETdKIacOWd94HrCq/VsQXIZCiWqml2Ob9zuG+CGY19auP4bEcEbysCx4MHA9uFWIzM/1znMNFLtdO2PdNnliKiapw5WMqeoucbUzlTDcEUkHXJdla8bttS7lPN5VYIMBCFNIelO3lWsOFc9IGoGL5iCPQ7ajtkUX7Fc0dAZHNyR/qjU8hYAOctLXWKuQNyf3P91LU+ckWRWj3PnRknjE7YHbT7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB6045.namprd11.prod.outlook.com (2603:10b6:408:17b::20)
 by DS4PPF93A1BBECD.namprd11.prod.outlook.com (2603:10b6:f:fc02::3c)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 12:06:24 +0000
Received: from LV2PR11MB6045.namprd11.prod.outlook.com
 ([fe80::1f72:3d49:b6ba:91ae]) by LV2PR11MB6045.namprd11.prod.outlook.com
 ([fe80::1f72:3d49:b6ba:91ae%6]) with mapi id 15.21.0472.015; Tue, 6 Oct 2026
 12:06:24 +0000
From: "Ji, Kai" <kai.ji@intel.com>
To: "Nicolau, Radu" <radu.nicolau@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "De Lara Guarch, Pablo" <pablo.de.lara.guarch@intel.com>
Subject: Re: [PATCH 1/4] crypto/ipsec_mb: add support for IPsecMB 3.0
Thread-Topic: [PATCH 1/4] crypto/ipsec_mb: add support for IPsecMB 3.0
Thread-Index: AQHdUlRiRReGZNm/7EKU04vlIlJ50bbwcXVM
Date: Tue, 6 Oct 2026 12:06:24 +0000
Message-ID: <LV2PR11MB6045F1A0465FAB19E5A7358F81952@LV2PR11MB6045.namprd11.prod.outlook.com>
References: <20261002095652.1540556-1-radu.nicolau@intel.com>
 <20261002095652.1540556-2-radu.nicolau@intel.com>
In-Reply-To: <20261002095652.1540556-2-radu.nicolau@intel.com>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6045:EE_|DS4PPF93A1BBECD:EE_
x-ms-office365-filtering-correlation-id: 87afaf1b-3e47-4eef-f912-08df23a23e0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|42112799006|376014|23010399003|1800799024|38070700021|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003|6133799003|3023799007|13003099007|8096899003;
x-microsoft-antispam-message-info: XMcn6R8MIOterQxancoGAUaEdAydre3dDKj3NbkuGfK7h7BAYKJcRVjHf0NqoV6pOu5arxjgLqD+uPM8vZOVsKOG8ikkqD/vKhvBN3WQy7bdJQfZnvTgiCXHsV/cUgNKrCDmV2YMA2pjNfSW/pBM6EbI3JM2SXBGJowceKLSEmnlRj8kncaCGWieZ90tEMM8lPeZwM+hDMsrFYfjcJ5MRTi5e4O0jRxRtKBBLMGcPXEQNmRa+svq/tf2KR2a26PJPa5487aYHwr56S0fNPgIkkLhyUSJJZgHP2L+w9qQa7T8ScPSF33E6A3j+pecz46Ye3df75fDIIWtLxHbmlG5vmbUB5r+sfuxxih024vUFmvnbH5tBvp7XMKhj673RtLK1sK6IlB+zRD+z57iij3sGNX6gn8XAT1tKaXqjGdE6acNsOomv5QH4lcrLHJ1hMZbI51C4AZjFiJowAhytDSwt1fD08Ei974U1tDR4r9B3tD+jTVAr8bGCNHII0G03acXjDzyYtrNOQc4wACFSKa95ml1leJ6NYEmMVhHUSNevDWYGfH2c0X/8sCaRM6l4RV8QFhcTzPB46vK8PBq1yZmYnO+inMF0WIMc5Uxr20HvHOqfkWQ5U2Ms3/bXXg3zwmItuP0mUDgIvHXs3YPpooLtY+FUFdNVUOc8vRddFEd6+x9bVZU2cP5393IWgEA00Bk
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB6045.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(42112799006)(376014)(23010399003)(1800799024)(38070700021)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007)(13003099007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vaBdEcZEmI48PK+pMB6nW9rbcrvJplOqjDDpqX9AxCGy8LLAvUXiTG+Np5XC?=
 =?us-ascii?Q?1W8Ebt88ShdlMWRz2gNqH91YHVZzWvXRRjONVI49CUFHIhcpgqr1j1PAJJtK?=
 =?us-ascii?Q?QNfsFBKfHTgSDjpxUmmZ6FuGNUAwdLFh7QiNjvNde8PZwpcfb47EonDV7DAJ?=
 =?us-ascii?Q?+mTO9fp1M5oHoxGfJLbL1GpxjWpJcqZh4dEydNaTBoTBZ1rewMW6DPwsW/5i?=
 =?us-ascii?Q?R/lldytScbUrJHXpp+8G+83Hy2L8jRxD9PtlOCc7vdJZd3VNJZyNVDf3gg1W?=
 =?us-ascii?Q?omIE9hBX1e+ZrDwZUwZdM/2cVEaFRN2WA8TamElcAJexr+5lUVtg+Z0qcb/8?=
 =?us-ascii?Q?ng3XwHvPEoh6R3WKfHO1prMbI5MGKKOGGslCUtT6G2pzwGF3rK94HWeHvBV+?=
 =?us-ascii?Q?woKhiMJNakFbG+7RYK/+/tpwIxB1tSzOUhjn/L1pBhNI6ChLXVhioa8P873k?=
 =?us-ascii?Q?jIeBWF/wFkRP55toTfxZA1bE/Ls1LqHv4pPrAmF3PuLm1PRqq51+Zr3xYD8z?=
 =?us-ascii?Q?TELi+kK/TnuSqaHmU6CrpH021HcRLDn3SM9151TDEevpF+pa1vVfawUO/zbS?=
 =?us-ascii?Q?NGiTbSRwQ3VPM/UoneD5PBHa1DR3GohPCbhu6rCl1pQVb3Fx6ExOs9FmZ0jx?=
 =?us-ascii?Q?+nC+fElgs+XaYwpg4rEyyIueYODAi5zoaTVIWo59Gy2q1660tqClG+ift7tC?=
 =?us-ascii?Q?uj/JA/n1hCvgJ69MRLHooAWlqQxWIGXvG4DVT7nxkJAYAet+FyMKV34qIlHq?=
 =?us-ascii?Q?2n66k2SflRHMQDF4XZ5huSfY0PqoubgQ8OVrnWgDDcljF0zXFYsEhGY0vTFK?=
 =?us-ascii?Q?NDnBTPJGVkMT+8RK9IUQK9LbXRAJePheR6e4XnQHVpPnyiIwCP4tjnlkHl32?=
 =?us-ascii?Q?FlFpeTgLzRtxVG0UwhpChYHFdenufZ1qMiBwt7Q5MQU+yHSSaV16kaIeS+i5?=
 =?us-ascii?Q?ADXicrBJ2ok/jprd2VHobzVJaEDAJmojd93iiyb9FTvFoDRcbqPVxQIoN1dl?=
 =?us-ascii?Q?AyeFn6edLpiEjrkE+fNZyE/muJHGf5rDoUF2WwBZsOHbC3jnpLqL26dOeYv7?=
 =?us-ascii?Q?Vm+8m2D3gMrcyQrhEMpQV8/6vNFUg8UOD6JfE5gqeqrPjz/I11PJLOR5k09F?=
 =?us-ascii?Q?ZsjXqF5yxWuxiY8Y+fX/0wXL0dIozJiM//asVVpyztzefbUUU0kskLaLVnrB?=
 =?us-ascii?Q?tmRJ7L06vwnkrbkyyM/QMzoMYleF34Z8vim1lrmEnaPfoNeCMJGqPLC6tqKR?=
 =?us-ascii?Q?dbfCg9aRzLbgZf1Ez+lMJPtsBD0uIQnMJAL+7Ss1vO6pYuvWiCtyMF3taO0p?=
 =?us-ascii?Q?uIrv9X/zHRVbh7j06JQ3LQMud06ordxQ/Y6waLE4N3J9tMKMhcgSzi6gQUqz?=
 =?us-ascii?Q?F2FM96Tw2u1NfcFr9tXHwhhxBF/Ul0W3xSv9g3aaYEl7nYqp9AMirj52c68g?=
 =?us-ascii?Q?AqrsabvSS/92TzSNOrFPZB/CZ8PatbH8DYSJ/u6bQyiY0YW1yZO61G014dOM?=
 =?us-ascii?Q?EHig9bMQYKY4LOBmv3fHhdiC1z3jgQpFrGcHOGXtU7PKoo3EkS+/ts43xs/v?=
 =?us-ascii?Q?7Bz462ZOt8yXpcKc86Q10m2M7lizIwae5giTOO0fiyloXvkTbavqkhscZ6pK?=
 =?us-ascii?Q?gBzLcRE/ZD+uB6mg4btjm9BcKkSYGCc0ulkFC25S4FRq5nQDjlzt9zL37WHb?=
 =?us-ascii?Q?pUCYrqwq+ePn74xLRdDB8/UYk22exgI8nS7kfUQIUD0PGbSU?=
Content-Type: multipart/alternative;
 boundary="_000_LV2PR11MB6045F1A0465FAB19E5A7358F81952LV2PR11MB6045namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rGtZqlCrINBmvuk4N8fdIm6E6YG2eMLIPcRwF8V/12D1LrnsCqfeeD3c0Sc8aHK0jy8kUDZrdQh0Gc2e1qq/rXL6XPjr8roTjudjxRxpuiERrNp+EyuvKYjo48RZucTmy1ScbzMFm9uIfXbRpOJi2iekTOwA0nnDU5C0WQwUG5MrRVFYajj/JPz1eWvtwv+IxSA3jlRulqPV1TecuT6h2HiEZrCjglhij8w+JBLJBCDWh/fJ4zk9d/7EtrnvQCy5fWV+WDz57TDdC1X/7t9uwlXuvLWG0QbAd5DRd6FBopZHDtpcjFl6Z0XdmMlE9V28+SeHMqs0XsznGzhXJBcRwQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6045.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87afaf1b-3e47-4eef-f912-08df23a23e0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2026 12:06:24.2105 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hHhDBlQwkj0u6eOJHJGx9SGwdE0sIWdYU769VgaKY+eYWwCDsQaUjs0SvIj4sXO+HERRWMbWAbS3esCz9m2P2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF93A1BBECD
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

--_000_LV2PR11MB6045F1A0465FAB19E5A7358F81952LV2PR11MB6045namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Series-acked-by: Kai Ji <kai.ji@intel.com>

________________________________
From: Nicolau, Radu <radu.nicolau@intel.com>
Sent: 02 October 2026 10:56
To: dev@dpdk.org <dev@dpdk.org>
Cc: Nicolau, Radu <radu.nicolau@intel.com>; Ji, Kai <kai.ji@intel.com>; De =
Lara Guarch, Pablo <pablo.de.lara.guarch@intel.com>
Subject: [PATCH 1/4] crypto/ipsec_mb: add support for IPsecMB 3.0

Add support for IPsecMB release 3.0
 - removed all _BITLEN enums, all lengths are in bytes
 - removed feature flag
 - use non const IMB_MGR
 - use IMB API instead of function pointers in the GCM PMD
 - remove ZUC 256 support

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 doc/guides/cryptodevs/aesni_gcm.rst          |   4 +-
 doc/guides/cryptodevs/aesni_mb.rst           |  11 +-
 doc/guides/rel_notes/release_26_11.rst       |   4 +
 drivers/crypto/ipsec_mb/pmd_aesni_gcm.c      | 267 +++++++++++++++----
 drivers/crypto/ipsec_mb/pmd_aesni_gcm_priv.h |  31 +--
 drivers/crypto/ipsec_mb/pmd_aesni_mb.c       | 107 +++++---
 drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h  |  47 +++-
 7 files changed, 349 insertions(+), 122 deletions(-)

diff --git a/doc/guides/cryptodevs/aesni_gcm.rst b/doc/guides/cryptodevs/ae=
sni_gcm.rst
index aefc1cedcb..e68dc4eb1e 100644
--- a/doc/guides/cryptodevs/aesni_gcm.rst
+++ b/doc/guides/cryptodevs/aesni_gcm.rst
@@ -40,8 +40,8 @@ Installation
 To build DPDK with the AESNI_GCM_PMD the user is required to download the =
multi-buffer
 library from `here <https://github.com/01org/intel-ipsec-mb>`_
 and compile it on their user system before building DPDK.
-The latest version of the library supported by this PMD is v2.0, which
-can be downloaded from `<https://github.com/01org/intel-ipsec-mb/archive/v=
2.0.zip>`_.
+The latest version of the library supported by this PMD is v3.0, which
+can be downloaded from `<https://github.com/01org/intel-ipsec-mb/archive/v=
3.0.zip>`_.

 For Arm system, ARM64 port of the multi-buffer library can be downloaded f=
rom
 https://gitlab.arm.com/arm-reference-solutions/ipsec-mb/-/tree/main/.
diff --git a/doc/guides/cryptodevs/aesni_mb.rst b/doc/guides/cryptodevs/aes=
ni_mb.rst
index add3c03b74..4851997fd9 100644
--- a/doc/guides/cryptodevs/aesni_mb.rst
+++ b/doc/guides/cryptodevs/aesni_mb.rst
@@ -73,6 +73,13 @@ Protocol offloads:

 * RTE_SECURITY_PROTOCOL_DOCSIS

+Note
+----
+Version 3.0 of the multi-buffer library removed support for:
+
+* the 256 bit versions of ZUC EEA3 and ZUC EIA3 algorithms.
+* non byte aligned bit length (``RTE_CRYPTODEV_FF_NON_BYTE_ALIGNED_DATA`` =
removed).
+
 Limitations
 -----------

@@ -96,8 +103,8 @@ Installation
 To build DPDK with the AESNI_MB_PMD the user is required to download the m=
ulti-buffer
 library from `here <https://github.com/01org/intel-ipsec-mb>`_
 and compile it on their user system before building DPDK.
-The latest version of the library supported by this PMD is v2.0, which
-can be downloaded from `<https://github.com/01org/intel-ipsec-mb/archive/v=
2.0.zip>`_.
+The latest version of the library supported by this PMD is v3.0, which
+can be downloaded from `<https://github.com/01org/intel-ipsec-mb/archive/v=
3.0.zip>`_.

 For Arm system, ARM64 port of the multi-buffer library can be downloaded f=
rom
 https://gitlab.arm.com/arm-reference-solutions/ipsec-mb/-/tree/main/.
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/=
release_26_11.rst
index 69ab5af8a3..ea126aa9bb 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -33,6 +33,10 @@ New Features
   ``pss_salt`` field in ``rte_crypto_rsa_op_param`` to carry it per
   sign operation.

+* **Updated AESNI_MB crypto driver.**
+
+  * Added support for version 3.0 of IPsec MB Library.
+
 .. This section should contain new features added in this release.
    Sample format:

diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_gcm.c b/drivers/crypto/ipsec=
_mb/pmd_aesni_gcm.c
index 3c266cc47e..0c4358a7b1 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_gcm.c
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_gcm.c
@@ -6,56 +6,205 @@

 #include "pmd_aesni_gcm_priv.h"

+/* wrapper functions for library versions < 3.0.0 */
+#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
+
+#define _fn(bitlen) static void imb_aes##bitlen##_gcm_pre(const void *key,=
 \
+               struct gcm_key_data *key_data, IMB_MGR *state) \
+{ \
+       state->gcm##bitlen##_pre(key, key_data); \
+}
+_fn(128)
+_fn(192)
+_fn(256)
+#undef _fn
+
+#define _fn(bitlen) static void imb_aes##bitlen##_gcm_init( \
+               const struct gcm_key_data *key_data, \
+               struct gcm_context_data *context_data, const void *iv, \
+               const void *aad, uint64_t aad_len, IMB_MGR *state) \
+{ \
+       state->gcm##bitlen##_init(key_data, context_data, iv, aad, aad_len)=
; \
+}
+_fn(128)
+_fn(192)
+_fn(256)
+#undef _fn
+
+#define _fn(bitlen) static void imb_aes##bitlen##_gcm_enc( \
+               const struct gcm_key_data *key_data, \
+               struct gcm_context_data *context_data, void *out, \
+               const void *in, uint64_t len, const void *iv, \
+               const void *aad, uint64_t aad_len, void *auth_tag, \
+               uint64_t auth_tag_len, IMB_MGR *state) \
+{ \
+       state->gcm##bitlen##_enc(key_data, context_data, out, in, len, iv, =
\
+                       aad, aad_len, auth_tag, auth_tag_len); \
+}
+_fn(128)
+_fn(192)
+_fn(256)
+#undef _fn
+
+#define _fn(bitlen) static void imb_aes##bitlen##_gcm_enc_update( \
+               const struct gcm_key_data *key_data, \
+               struct gcm_context_data *context_data, void *out, \
+               const void *in, const uint64_t len, IMB_MGR *state) \
+{ \
+       state->gcm##bitlen##_enc_update(key_data, context_data, out, in, le=
n); \
+}
+_fn(128)
+_fn(192)
+_fn(256)
+#undef _fn
+
+#define _fn(bitlen) static void imb_aes##bitlen##_gcm_enc_finalize( \
+               const struct gcm_key_data *key_data, \
+               struct gcm_context_data *context_data, void *auth_tag, \
+               const uint64_t auth_tag_len, IMB_MGR *state) \
+{ \
+       state->gcm##bitlen##_enc_finalize(key_data, context_data, auth_tag,=
 \
+                       auth_tag_len); \
+}
+_fn(128)
+_fn(192)
+_fn(256)
+#undef _fn
+
+#define _fn(bitlen) static void imb_aes##bitlen##_gcm_dec( \
+               const struct gcm_key_data *key_data, \
+               struct gcm_context_data *context_data, void *out, \
+               const void *in, uint64_t len, const void *iv, \
+               const void *aad, uint64_t aad_len, void *auth_tag, \
+               uint64_t auth_tag_len, IMB_MGR *state) \
+{ \
+       state->gcm##bitlen##_dec(key_data, context_data, out, in, len, iv, =
\
+                       aad, aad_len, auth_tag, auth_tag_len); \
+}
+_fn(128)
+_fn(192)
+_fn(256)
+#undef _fn
+
+#define _fn(bitlen) static void imb_aes##bitlen##_gcm_dec_update( \
+               const struct gcm_key_data *key_data, \
+               struct gcm_context_data *context_data, void *out, \
+               const void *in, const uint64_t len, IMB_MGR *state) \
+{ \
+       state->gcm##bitlen##_dec_update(key_data, context_data, out, in, le=
n); \
+}
+_fn(128)
+_fn(192)
+_fn(256)
+#undef _fn
+
+#define _fn(bitlen) static void imb_aes##bitlen##_gcm_dec_finalize( \
+               const struct gcm_key_data *key_data, \
+               struct gcm_context_data *context_data, void *auth_tag, \
+               const uint64_t auth_tag_len, IMB_MGR *state) \
+{ \
+       state->gcm##bitlen##_dec_finalize(key_data, context_data, auth_tag,=
 \
+                       auth_tag_len); \
+}
+_fn(128)
+_fn(192)
+_fn(256)
+#undef _fn
+
+#define _fn(bitlen) static void imb_aes##bitlen##_gmac_init( \
+               const struct gcm_key_data *key_data, \
+               struct gcm_context_data *context_data, const void *iv, \
+               const uint64_t iv_len, IMB_MGR *state) \
+{ \
+       state->gmac##bitlen##_init(key_data, context_data, iv, iv_len); \
+}
+_fn(128)
+_fn(192)
+_fn(256)
+#undef _fn
+
+#define _fn(bitlen) static void imb_aes##bitlen##_gmac_update( \
+               const struct gcm_key_data *key_data, \
+               struct gcm_context_data *context_data, const void *in, \
+               const uint64_t len, IMB_MGR *state) \
+{ \
+       state->gmac##bitlen##_update(key_data, context_data, in, len); \
+}
+_fn(128)
+_fn(192)
+_fn(256)
+#undef _fn
+
+#define _fn(bitlen) static void imb_aes##bitlen##_gmac_finalize( \
+               const struct gcm_key_data *key_data, \
+               struct gcm_context_data *context_data, void *auth_tag, \
+               const uint64_t auth_tag_len, IMB_MGR *state) \
+{ \
+       state->gmac##bitlen##_finalize(key_data, context_data, auth_tag, \
+                       auth_tag_len); \
+}
+_fn(128)
+_fn(192)
+_fn(256)
+#undef _fn
+
+#endif
+
 static void
 aesni_gcm_set_ops(struct aesni_gcm_ops *ops, IMB_MGR *mb_mgr)
 {
+       /* Set IMB_MGR pointers. */
+       ops[GCM_KEY_128].mb_mgr =3D mb_mgr;
+       ops[GCM_KEY_192].mb_mgr =3D mb_mgr;
+       ops[GCM_KEY_256].mb_mgr =3D mb_mgr;
+
         /* Set 128 bit function pointers. */
-       ops[GCM_KEY_128].pre =3D mb_mgr->gcm128_pre;
-       ops[GCM_KEY_128].init =3D mb_mgr->gcm128_init;
+       ops[GCM_KEY_128].pre =3D imb_aes128_gcm_pre;
+       ops[GCM_KEY_128].init =3D imb_aes128_gcm_init;

-       ops[GCM_KEY_128].enc =3D mb_mgr->gcm128_enc;
-       ops[GCM_KEY_128].update_enc =3D mb_mgr->gcm128_enc_update;
-       ops[GCM_KEY_128].finalize_enc =3D mb_mgr->gcm128_enc_finalize;
+       ops[GCM_KEY_128].enc =3D imb_aes128_gcm_enc;
+       ops[GCM_KEY_128].update_enc =3D imb_aes128_gcm_enc_update;
+       ops[GCM_KEY_128].finalize_enc =3D imb_aes128_gcm_enc_finalize;

-       ops[GCM_KEY_128].dec =3D mb_mgr->gcm128_dec;
-       ops[GCM_KEY_128].update_dec =3D mb_mgr->gcm128_dec_update;
-       ops[GCM_KEY_128].finalize_dec =3D mb_mgr->gcm128_dec_finalize;
+       ops[GCM_KEY_128].dec =3D imb_aes128_gcm_dec;
+       ops[GCM_KEY_128].update_dec =3D imb_aes128_gcm_dec_update;
+       ops[GCM_KEY_128].finalize_dec =3D imb_aes128_gcm_dec_finalize;

-       ops[GCM_KEY_128].gmac_init =3D mb_mgr->gmac128_init;
-       ops[GCM_KEY_128].gmac_update =3D mb_mgr->gmac128_update;
-       ops[GCM_KEY_128].gmac_finalize =3D mb_mgr->gmac128_finalize;
+       ops[GCM_KEY_128].gmac_init =3D imb_aes128_gmac_init;
+       ops[GCM_KEY_128].gmac_update =3D imb_aes128_gmac_update;
+       ops[GCM_KEY_128].gmac_finalize =3D imb_aes128_gmac_finalize;

         /* Set 192 bit function pointers. */
-       ops[GCM_KEY_192].pre =3D mb_mgr->gcm192_pre;
-       ops[GCM_KEY_192].init =3D mb_mgr->gcm192_init;
+       ops[GCM_KEY_192].pre =3D imb_aes192_gcm_pre;
+       ops[GCM_KEY_192].init =3D imb_aes192_gcm_init;

-       ops[GCM_KEY_192].enc =3D mb_mgr->gcm192_enc;
-       ops[GCM_KEY_192].update_enc =3D mb_mgr->gcm192_enc_update;
-       ops[GCM_KEY_192].finalize_enc =3D mb_mgr->gcm192_enc_finalize;
+       ops[GCM_KEY_192].enc =3D imb_aes192_gcm_enc;
+       ops[GCM_KEY_192].update_enc =3D imb_aes192_gcm_enc_update;
+       ops[GCM_KEY_192].finalize_enc =3D imb_aes192_gcm_enc_finalize;

-       ops[GCM_KEY_192].dec =3D mb_mgr->gcm192_dec;
-       ops[GCM_KEY_192].update_dec =3D mb_mgr->gcm192_dec_update;
-       ops[GCM_KEY_192].finalize_dec =3D mb_mgr->gcm192_dec_finalize;
+       ops[GCM_KEY_192].dec =3D imb_aes192_gcm_dec;
+       ops[GCM_KEY_192].update_dec =3D imb_aes192_gcm_dec_update;
+       ops[GCM_KEY_192].finalize_dec =3D imb_aes192_gcm_dec_finalize;

-       ops[GCM_KEY_192].gmac_init =3D mb_mgr->gmac192_init;
-       ops[GCM_KEY_192].gmac_update =3D mb_mgr->gmac192_update;
-       ops[GCM_KEY_192].gmac_finalize =3D mb_mgr->gmac192_finalize;
+       ops[GCM_KEY_192].gmac_init =3D imb_aes192_gmac_init;
+       ops[GCM_KEY_192].gmac_update =3D imb_aes192_gmac_update;
+       ops[GCM_KEY_192].gmac_finalize =3D imb_aes192_gmac_finalize;

         /* Set 256 bit function pointers. */
-       ops[GCM_KEY_256].pre =3D mb_mgr->gcm256_pre;
-       ops[GCM_KEY_256].init =3D mb_mgr->gcm256_init;
+       ops[GCM_KEY_256].pre =3D imb_aes256_gcm_pre;
+       ops[GCM_KEY_256].init =3D imb_aes256_gcm_init;

-       ops[GCM_KEY_256].enc =3D mb_mgr->gcm256_enc;
-       ops[GCM_KEY_256].update_enc =3D mb_mgr->gcm256_enc_update;
-       ops[GCM_KEY_256].finalize_enc =3D mb_mgr->gcm256_enc_finalize;
+       ops[GCM_KEY_256].enc =3D imb_aes256_gcm_enc;
+       ops[GCM_KEY_256].update_enc =3D imb_aes256_gcm_enc_update;
+       ops[GCM_KEY_256].finalize_enc =3D imb_aes256_gcm_enc_finalize;

-       ops[GCM_KEY_256].dec =3D mb_mgr->gcm256_dec;
-       ops[GCM_KEY_256].update_dec =3D mb_mgr->gcm256_dec_update;
-       ops[GCM_KEY_256].finalize_dec =3D mb_mgr->gcm256_dec_finalize;
+       ops[GCM_KEY_256].dec =3D imb_aes256_gcm_dec;
+       ops[GCM_KEY_256].update_dec =3D imb_aes256_gcm_dec_update;
+       ops[GCM_KEY_256].finalize_dec =3D imb_aes256_gcm_dec_finalize;

-       ops[GCM_KEY_256].gmac_init =3D mb_mgr->gmac256_init;
-       ops[GCM_KEY_256].gmac_update =3D mb_mgr->gmac256_update;
-       ops[GCM_KEY_256].gmac_finalize =3D mb_mgr->gmac256_finalize;
+       ops[GCM_KEY_256].gmac_init =3D imb_aes256_gmac_init;
+       ops[GCM_KEY_256].gmac_update =3D imb_aes256_gmac_update;
+       ops[GCM_KEY_256].gmac_finalize =3D imb_aes256_gmac_finalize;
 }

 static int
@@ -135,15 +284,15 @@ aesni_gcm_session_configure(IMB_MGR *mb_mgr, void *se=
ssion,
         switch (key_length) {
         case 16:
                 sess->key_length =3D GCM_KEY_128;
-               mb_mgr->gcm128_pre(key, &sess->gdata_key);
+               imb_aes128_gcm_pre(key, &sess->gdata_key, mb_mgr);
                 break;
         case 24:
                 sess->key_length =3D GCM_KEY_192;
-               mb_mgr->gcm192_pre(key, &sess->gdata_key);
+               imb_aes192_gcm_pre(key, &sess->gdata_key, mb_mgr);
                 break;
         case 32:
                 sess->key_length =3D GCM_KEY_256;
-               mb_mgr->gcm256_pre(key, &sess->gdata_key);
+               imb_aes256_gcm_pre(key, &sess->gdata_key, mb_mgr);
                 break;
         default:
                 IPSEC_MB_LOG(ERR, "Invalid key length");
@@ -324,10 +473,10 @@ process_gcm_crypto_op(struct ipsec_mb_qp *qp, struct =
rte_crypto_op *op,
         if (session->op =3D=3D IPSEC_MB_OP_AEAD_AUTHENTICATED_ENCRYPT) {
                 ops->init(&session->gdata_key, &qp_data->gcm_ctx_data, iv_=
ptr,
                                 sym_op->aead.aad.data,
-                               (uint64_t)session->aad_length);
+                               (uint64_t)session->aad_length, ops->mb_mgr)=
;

                 ops->update_enc(&session->gdata_key, &qp_data->gcm_ctx_dat=
a,
-                               dst, src, (uint64_t)part_len);
+                               dst, src, (uint64_t)part_len, ops->mb_mgr);
                 total_len =3D data_length - part_len;

                 while (total_len) {
@@ -345,7 +494,7 @@ process_gcm_crypto_op(struct ipsec_mb_qp *qp, struct rt=
e_crypto_op *op,

                         ops->update_enc(&session->gdata_key,
                                         &qp_data->gcm_ctx_data,
-                                       dst, src, (uint64_t)part_len);
+                                       dst, src, (uint64_t)part_len, ops->=
mb_mgr);
                         total_len -=3D part_len;
                 }

@@ -355,14 +504,14 @@ process_gcm_crypto_op(struct ipsec_mb_qp *qp, struct =
rte_crypto_op *op,
                         tag =3D sym_op->aead.digest.data;

                 ops->finalize_enc(&session->gdata_key, &qp_data->gcm_ctx_d=
ata,
-                               tag, session->gen_digest_length);
+                               tag, session->gen_digest_length, ops->mb_mg=
r);
         } else if (session->op =3D=3D IPSEC_MB_OP_AEAD_AUTHENTICATED_DECRY=
PT) {
                 ops->init(&session->gdata_key, &qp_data->gcm_ctx_data, iv_=
ptr,
                                 sym_op->aead.aad.data,
-                               (uint64_t)session->aad_length);
+                               (uint64_t)session->aad_length, ops->mb_mgr)=
;

                 ops->update_dec(&session->gdata_key, &qp_data->gcm_ctx_dat=
a,
-                               dst, src, (uint64_t)part_len);
+                               dst, src, (uint64_t)part_len, ops->mb_mgr);
                 total_len =3D data_length - part_len;

                 while (total_len) {
@@ -380,19 +529,19 @@ process_gcm_crypto_op(struct ipsec_mb_qp *qp, struct =
rte_crypto_op *op,

                         ops->update_dec(&session->gdata_key,
                                         &qp_data->gcm_ctx_data,
-                                       dst, src, (uint64_t)part_len);
+                                       dst, src, (uint64_t)part_len, ops->=
mb_mgr);
                         total_len -=3D part_len;
                 }

                 tag =3D qp_data->temp_digest;
                 ops->finalize_dec(&session->gdata_key, &qp_data->gcm_ctx_d=
ata,
-                               tag, session->gen_digest_length);
+                               tag, session->gen_digest_length, ops->mb_mg=
r);
         } else if (session->op =3D=3D IPSEC_MB_OP_HASH_GEN_ONLY) {
                 ops->gmac_init(&session->gdata_key, &qp_data->gcm_ctx_data=
,
-                               iv_ptr, session->iv.length);
+                               iv_ptr, session->iv.length, ops->mb_mgr);

                 ops->gmac_update(&session->gdata_key, &qp_data->gcm_ctx_da=
ta,
-                               src, (uint64_t)part_len);
+                               src, (uint64_t)part_len, ops->mb_mgr);
                 total_len =3D data_length - part_len;

                 while (total_len) {
@@ -406,7 +555,7 @@ process_gcm_crypto_op(struct ipsec_mb_qp *qp, struct rt=
e_crypto_op *op,

                         ops->gmac_update(&session->gdata_key,
                                         &qp_data->gcm_ctx_data, src,
-                                       (uint64_t)part_len);
+                                       (uint64_t)part_len, ops->mb_mgr);
                         total_len -=3D part_len;
                 }

@@ -416,13 +565,13 @@ process_gcm_crypto_op(struct ipsec_mb_qp *qp, struct =
rte_crypto_op *op,
                         tag =3D sym_op->auth.digest.data;

                 ops->gmac_finalize(&session->gdata_key, &qp_data->gcm_ctx_=
data,
-                               tag, session->gen_digest_length);
+                               tag, session->gen_digest_length, ops->mb_mg=
r);
         } else { /* IPSEC_MB_OP_HASH_VERIFY_ONLY */
                 ops->gmac_init(&session->gdata_key, &qp_data->gcm_ctx_data=
,
-                               iv_ptr, session->iv.length);
+                               iv_ptr, session->iv.length, ops->mb_mgr);

                 ops->gmac_update(&session->gdata_key, &qp_data->gcm_ctx_da=
ta,
-                               src, (uint64_t)part_len);
+                               src, (uint64_t)part_len, ops->mb_mgr);
                 total_len =3D data_length - part_len;

                 while (total_len) {
@@ -436,14 +585,14 @@ process_gcm_crypto_op(struct ipsec_mb_qp *qp, struct =
rte_crypto_op *op,

                         ops->gmac_update(&session->gdata_key,
                                         &qp_data->gcm_ctx_data, src,
-                                       (uint64_t)part_len);
+                                       (uint64_t)part_len, ops->mb_mgr);
                         total_len -=3D part_len;
                 }

                 tag =3D qp_data->temp_digest;

                 ops->gmac_finalize(&session->gdata_key, &qp_data->gcm_ctx_=
data,
-                               tag, session->gen_digest_length);
+                               tag, session->gen_digest_length, ops->mb_mg=
r);
         }
         return 0;
 }
@@ -540,11 +689,11 @@ aesni_gcm_sgl_op_finalize_encryption(const struct aes=
ni_gcm_session *s,
                 uint8_t tmpdigest[s->gen_digest_length];

                 ops.finalize_enc(&s->gdata_key, gdata_ctx, tmpdigest,
-                               s->gen_digest_length);
+                               s->gen_digest_length, ops.mb_mgr);
                 memcpy(digest, tmpdigest, s->req_digest_length);
         } else {
                 ops.finalize_enc(&s->gdata_key, gdata_ctx, digest,
-                               s->gen_digest_length);
+                               s->gen_digest_length, ops.mb_mgr);
         }

         return 0;
@@ -558,7 +707,7 @@ aesni_gcm_sgl_op_finalize_decryption(const struct aesni=
_gcm_session *s,
         uint8_t tmpdigest[s->gen_digest_length];

         ops.finalize_dec(&s->gdata_key, gdata_ctx, tmpdigest,
-                       s->gen_digest_length);
+                       s->gen_digest_length, ops.mb_mgr);

         return rte_memeq_timingsafe(digest, tmpdigest, s->req_digest_lengt=
h) ? 0 : EBADMSG;
 }
@@ -573,7 +722,7 @@ aesni_gcm_process_gcm_sgl_op(const struct aesni_gcm_ses=
sion *s,

         /* init crypto operation */
         ops.init(&s->gdata_key, gdata_ctx, iv, aad,
-                   (uint64_t)s->aad_length);
+                   (uint64_t)s->aad_length, ops.mb_mgr);

         /* update with sgl data */
         for (i =3D 0; i < sgl->num; i++) {
@@ -582,11 +731,11 @@ aesni_gcm_process_gcm_sgl_op(const struct aesni_gcm_s=
ession *s,
                 switch (s->op) {
                 case IPSEC_MB_OP_AEAD_AUTHENTICATED_ENCRYPT:
                         ops.update_enc(&s->gdata_key, gdata_ctx,
-                             vec->base, vec->base, vec->len);
+                             vec->base, vec->base, vec->len, ops.mb_mgr);
                         break;
                 case IPSEC_MB_OP_AEAD_AUTHENTICATED_DECRYPT:
                         ops.update_dec(&s->gdata_key, gdata_ctx,
-                             vec->base, vec->base, vec->len);
+                             vec->base, vec->base, vec->len, ops.mb_mgr);
                         break;
                 default:
                         IPSEC_MB_LOG(ERR, "Invalid session op");
@@ -603,7 +752,7 @@ aesni_gcm_process_gmac_sgl_op(const struct aesni_gcm_se=
ssion *s,
                               struct aesni_gcm_ops ops)
 {
         ops.init(&s->gdata_key, gdata_ctx, iv, sgl->vec[0].base,
-                   sgl->vec[0].len);
+                   sgl->vec[0].len, ops.mb_mgr);
 }

 static inline uint32_t
diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_gcm_priv.h b/drivers/crypto/=
ipsec_mb/pmd_aesni_gcm_priv.h
index 8a5a41fb19..4074430d6e 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_gcm_priv.h
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_gcm_priv.h
@@ -79,41 +79,41 @@ enum aesni_gcm_key_length {

 typedef void (*aesni_gcm_t)(const struct gcm_key_data *gcm_key_data,
                             struct gcm_context_data *gcm_ctx_data,
-                           uint8_t *out, const uint8_t *in,
-                           uint64_t plaintext_len, const uint8_t *iv,
-                           const uint8_t *aad, uint64_t aad_len,
-                           uint8_t *auth_tag, uint64_t auth_tag_len);
+                           void *out, const void *in,
+                           uint64_t plaintext_len, const void *iv,
+                           const void *aad, uint64_t aad_len,
+                           void *auth_tag, uint64_t auth_tag_len, IMB_MGR =
*state);

 typedef void (*aesni_gcm_pre_t)(const void *key,
-                               struct gcm_key_data *gcm_data);
+                               struct gcm_key_data *gcm_data, IMB_MGR *sta=
te);

 typedef void (*aesni_gcm_init_t)(const struct gcm_key_data *gcm_key_data,
                                  struct gcm_context_data *gcm_ctx_data,
-                                const uint8_t *iv, uint8_t const *aad,
-                                uint64_t aad_len);
+                                const void *iv, const void *aad,
+                                uint64_t aad_len, IMB_MGR *state);

 typedef void (*aesni_gcm_update_t)(const struct gcm_key_data *gcm_key_data=
,
                                    struct gcm_context_data *gcm_ctx_data,
-                                  uint8_t *out, const uint8_t *in,
-                                  uint64_t plaintext_len);
+                                  void *out, const void *in,
+                                  uint64_t plaintext_len, IMB_MGR *state);

 typedef void (*aesni_gcm_finalize_t)(const struct gcm_key_data *gcm_key_da=
ta,
                                      struct gcm_context_data *gcm_ctx_data=
,
-                                    uint8_t *auth_tag, uint64_t auth_tag_l=
en);
+                                    void *auth_tag, uint64_t auth_tag_len,=
 IMB_MGR *state);

 typedef void (*aesni_gmac_init_t)(const struct gcm_key_data *gcm_key_data,
                                   struct gcm_context_data *gcm_ctx_data,
-                                 const uint8_t *iv, const uint64_t iv_len)=
;
+                                 const void *iv, const uint64_t iv_len, IM=
B_MGR *state);

 typedef void (*aesni_gmac_update_t)(const struct gcm_key_data *gcm_key_dat=
a,
                                     struct gcm_context_data *gcm_ctx_data,
-                                   const uint8_t *in,
-                                   const uint64_t plaintext_len);
+                                   const void *in,
+                                   const uint64_t plaintext_len, IMB_MGR *=
state);

 typedef void (*aesni_gmac_finalize_t)(const struct gcm_key_data *gcm_key_d=
ata,
                                       struct gcm_context_data *gcm_ctx_dat=
a,
-                                     uint8_t *auth_tag,
-                                     const uint64_t auth_tag_len);
+                                     void *auth_tag,
+                                     const uint64_t auth_tag_len, IMB_MGR =
*state);

 /** GCM operation handlers */
 struct aesni_gcm_ops {
@@ -128,6 +128,7 @@ struct aesni_gcm_ops {
         aesni_gmac_init_t gmac_init;
         aesni_gmac_update_t gmac_update;
         aesni_gmac_finalize_t gmac_finalize;
+       IMB_MGR *mb_mgr;
 };

 RTE_DEFINE_PER_LCORE(struct aesni_gcm_ops, gcm_ops[GCM_NUM_KEY_TYPES]);
diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c b/drivers/crypto/ipsec_=
mb/pmd_aesni_mb.c
index 02bacd020b..e8f6e77d21 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
@@ -161,20 +161,22 @@ aesni_mb_set_session_auth_parameters(IMB_MGR *mb_mgr,

         if (xform->auth.algo =3D=3D RTE_CRYPTO_AUTH_ZUC_EIA3) {
                 if (xform->auth.key.length =3D=3D 16) {
-                       sess->template_job.hash_alg =3D IMB_AUTH_ZUC_EIA3_B=
ITLEN;
+                       sess->template_job.hash_alg =3D IMB_AUTH_ZUC_EIA3;

                         if (sess->auth.req_digest_len !=3D 4) {
                                 IPSEC_MB_LOG(ERR, "Invalid digest size");
                                 return -EINVAL;
                         }
+#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
                 } else if (xform->auth.key.length =3D=3D 32) {
-                       sess->template_job.hash_alg =3D IMB_AUTH_ZUC256_EIA=
3_BITLEN;
+                       sess->template_job.hash_alg =3D IMB_AUTH_ZUC256_EIA=
3;
                         if (sess->auth.req_digest_len !=3D 4 &&
                                         sess->auth.req_digest_len !=3D 8 &=
&
                                         sess->auth.req_digest_len !=3D 16)=
 {
                                 IPSEC_MB_LOG(ERR, "Invalid digest size");
                                 return -EINVAL;
                         }
+#endif
                 } else {
                         IPSEC_MB_LOG(ERR, "Invalid authentication key leng=
th");
                         return -EINVAL;
@@ -187,10 +189,10 @@ aesni_mb_set_session_auth_parameters(IMB_MGR *mb_mgr,
                 sess->template_job.u.ZUC_EIA3._key =3D sess->auth.zuc_auth=
_key;
                 return 0;
         } else if (xform->auth.algo =3D=3D RTE_CRYPTO_AUTH_SNOW3G_UIA2) {
-               sess->template_job.hash_alg =3D IMB_AUTH_SNOW3G_UIA2_BITLEN=
;
+               sess->template_job.hash_alg =3D IMB_AUTH_SNOW3G_UIA2;
                 uint16_t snow3g_uia2_digest_len =3D
                         get_truncated_digest_byte_length(
-                                               IMB_AUTH_SNOW3G_UIA2_BITLEN=
);
+                                               IMB_AUTH_SNOW3G_UIA2);
                 if (sess->auth.req_digest_len !=3D snow3g_uia2_digest_len)=
 {
                         IPSEC_MB_LOG(ERR, "Invalid digest size");
                         return -EINVAL;
@@ -339,7 +341,7 @@ aesni_mb_set_session_auth_parameters(IMB_MGR *mb_mgr,

 /** Set session cipher parameters */
 static int
-aesni_mb_set_session_cipher_parameters(const IMB_MGR *mb_mgr,
+aesni_mb_set_session_cipher_parameters(IMB_MGR *mb_mgr,
                 struct aesni_mb_session *sess,
                 const struct rte_crypto_sym_xform *xform)
 {
@@ -407,11 +409,11 @@ aesni_mb_set_session_cipher_parameters(const IMB_MGR =
*mb_mgr,
                 is_zuc =3D 1;
                 break;
         case RTE_CRYPTO_CIPHER_SNOW3G_UEA2:
-               sess->template_job.cipher_mode =3D IMB_CIPHER_SNOW3G_UEA2_B=
ITLEN;
+               sess->template_job.cipher_mode =3D IMB_CIPHER_SNOW3G_UEA2;
                 is_snow3g =3D 1;
                 break;
         case RTE_CRYPTO_CIPHER_KASUMI_F8:
-               sess->template_job.cipher_mode =3D IMB_CIPHER_KASUMI_UEA1_B=
ITLEN;
+               sess->template_job.cipher_mode =3D IMB_CIPHER_KASUMI_UEA1;
                 is_kasumi =3D 1;
                 break;
         case RTE_CRYPTO_CIPHER_NULL:
@@ -536,8 +538,11 @@ aesni_mb_set_session_cipher_parameters(const IMB_MGR *=
mb_mgr,
                 sess->template_job.dec_keys =3D sess->cipher.exp_3des_keys=
.ks_ptr;
                 sess->template_job.key_len_in_bytes =3D 24;
         } else if (is_zuc) {
-               if (xform->cipher.key.length !=3D 16 &&
-                               xform->cipher.key.length !=3D 32) {
+               if (xform->cipher.key.length !=3D 16
+#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
+                               && xform->cipher.key.length !=3D 32
+#endif
+                       ) {
                         IPSEC_MB_LOG(ERR, "Invalid cipher key length");
                         return -EINVAL;
                 }
@@ -1177,19 +1182,23 @@ sgl_linear_cipher_auth_len(IMB_JOB *job, uint64_t *=
auth_len)
 {
         uint64_t cipher_len;

-       if (job->cipher_mode =3D=3D IMB_CIPHER_SNOW3G_UEA2_BITLEN ||
-                       job->cipher_mode =3D=3D IMB_CIPHER_KASUMI_UEA1_BITL=
EN)
+#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
+       if (job->cipher_mode =3D=3D IMB_CIPHER_SNOW3G_UEA2 ||
+                       job->cipher_mode =3D=3D IMB_CIPHER_KASUMI_UEA1)
                 cipher_len =3D (job->msg_len_to_cipher_in_bits >> 3) +
                                 (job->cipher_start_src_offset_in_bits >> 3=
);
         else
+#endif
                 cipher_len =3D job->msg_len_to_cipher_in_bytes +
                                 job->cipher_start_src_offset_in_bytes;

-       if (job->hash_alg =3D=3D IMB_AUTH_SNOW3G_UIA2_BITLEN ||
-                       job->hash_alg =3D=3D IMB_AUTH_ZUC_EIA3_BITLEN)
+#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
+       if (job->hash_alg =3D=3D IMB_AUTH_SNOW3G_UIA2 ||
+                       job->hash_alg =3D=3D IMB_AUTH_ZUC_EIA3)
                 *auth_len =3D (job->msg_len_to_hash_in_bits >> 3) +
                                 job->hash_start_src_offset_in_bytes;
         else
+#endif
                 *auth_len =3D job->msg_len_to_hash_in_bytes +
                                 job->hash_start_src_offset_in_bytes;

@@ -1457,18 +1466,20 @@ aesni_mb_digest_appended_in_src(struct rte_crypto_o=
p *op, IMB_JOB *job,
                 return NULL;

         if (job->cipher_mode =3D=3D IMB_CIPHER_ZUC_EEA3 ||
-               job->cipher_mode =3D=3D IMB_CIPHER_SNOW3G_UEA2_BITLEN ||
-               job->cipher_mode =3D=3D IMB_CIPHER_KASUMI_UEA1_BITLEN) {
+               job->cipher_mode =3D=3D IMB_CIPHER_SNOW3G_UEA2 ||
+               job->cipher_mode =3D=3D IMB_CIPHER_KASUMI_UEA1) {
                 cipher_size =3D (op->sym->cipher.data.offset >> 3) +
                         (op->sym->cipher.data.length >> 3);
         } else {
                 cipher_size =3D (op->sym->cipher.data.offset) +
                         (op->sym->cipher.data.length);
         }
-       if (job->hash_alg =3D=3D IMB_AUTH_ZUC_EIA3_BITLEN ||
-               job->hash_alg =3D=3D IMB_AUTH_SNOW3G_UIA2_BITLEN ||
-               job->hash_alg =3D=3D IMB_AUTH_KASUMI_UIA1 ||
-               job->hash_alg =3D=3D IMB_AUTH_ZUC256_EIA3_BITLEN) {
+       if (job->hash_alg =3D=3D IMB_AUTH_ZUC_EIA3 ||
+               job->hash_alg =3D=3D IMB_AUTH_SNOW3G_UIA2 ||
+#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
+               job->hash_alg =3D=3D IMB_AUTH_ZUC256_EIA3 ||
+#endif
+               job->hash_alg =3D=3D IMB_AUTH_KASUMI_UIA1) {
                 auth_size =3D (op->sym->auth.data.offset >> 3) +
                         (op->sym->auth.data.length >> 3);
         } else {
@@ -1585,12 +1596,14 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp =
*qp,
                 job->u.GMAC._iv =3D rte_crypto_op_ctod_offset(op, uint8_t =
*,
                                                 session->auth_iv.offset);
                 break;
-       case IMB_AUTH_ZUC_EIA3_BITLEN:
-       case IMB_AUTH_ZUC256_EIA3_BITLEN:
+       case IMB_AUTH_ZUC_EIA3:
+#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
+       case IMB_AUTH_ZUC256_EIA3:
+#endif
                 job->u.ZUC_EIA3._iv =3D rte_crypto_op_ctod_offset(op, uint=
8_t *,
                                                 session->auth_iv.offset);
                 break;
-       case IMB_AUTH_SNOW3G_UIA2_BITLEN:
+       case IMB_AUTH_SNOW3G_UIA2:
                 job->u.SNOW3G_UIA2._iv =3D
                         rte_crypto_op_ctod_offset(op, uint8_t *,
                                                 session->auth_iv.offset);
@@ -1616,12 +1629,19 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp =
*qp,
         else
                 m_offset =3D op->sym->cipher.data.offset;

+#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
         if (cipher_mode =3D=3D IMB_CIPHER_ZUC_EEA3)
                 m_offset >>=3D 3;
-       else if (cipher_mode =3D=3D IMB_CIPHER_SNOW3G_UEA2_BITLEN)
+       else if (cipher_mode =3D=3D IMB_CIPHER_SNOW3G_UEA2)
                 m_offset =3D 0;
-       else if (cipher_mode =3D=3D IMB_CIPHER_KASUMI_UEA1_BITLEN)
+       else if (cipher_mode =3D=3D IMB_CIPHER_KASUMI_UEA1)
                 m_offset =3D 0;
+#else
+       if (cipher_mode =3D=3D IMB_CIPHER_ZUC_EEA3 ||
+               cipher_mode =3D=3D IMB_CIPHER_SNOW3G_UEA2 ||
+               cipher_mode =3D=3D IMB_CIPHER_KASUMI_UEA1)
+               m_offset >>=3D 3;
+#endif

         /* Set digest output location */
         if (job->hash_alg !=3D IMB_AUTH_NULL &&
@@ -1701,9 +1721,11 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp *=
qp,
                                 session->iv.offset);
                 break;
         /* ZUC and SNOW3G require length in bits and offset in bytes */
-       case IMB_AUTH_ZUC_EIA3_BITLEN:
-       case IMB_AUTH_ZUC256_EIA3_BITLEN:
-       case IMB_AUTH_SNOW3G_UIA2_BITLEN:
+       case IMB_AUTH_ZUC_EIA3:
+#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
+       case IMB_AUTH_ZUC256_EIA3:
+#endif
+       case IMB_AUTH_SNOW3G_UIA2:
                 auth_off_in_bytes =3D op->sym->auth.data.offset >> 3;
                 ciph_off_in_bytes =3D op->sym->cipher.data.offset >> 3;
                 auth_len_in_bytes =3D op->sym->auth.data.length >> 3;
@@ -1714,7 +1736,11 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp *=
qp,
                                 session, oop, auth_off_in_bytes,
                                 ciph_off_in_bytes, auth_len_in_bytes,
                                 ciph_len_in_bytes, lb_sgl);
+#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
                 job->msg_len_to_hash_in_bits =3D op->sym->auth.data.length=
;
+#else
+               job->msg_len_to_hash_in_bytes =3D op->sym->auth.data.length=
 >> 3;
+#endif

                 job->iv =3D rte_crypto_op_ctod_offset(op, uint8_t *,
                         session->iv.offset);
@@ -1772,12 +1798,19 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp =
*qp,
                                         op->sym->cipher.data.length >> 3;
                 break;
         /* ZUC and SNOW3G require length and offset in bits */
-       case IMB_CIPHER_SNOW3G_UEA2_BITLEN:
-       case IMB_CIPHER_KASUMI_UEA1_BITLEN:
+       case IMB_CIPHER_SNOW3G_UEA2:
+       case IMB_CIPHER_KASUMI_UEA1:
+#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
                 job->cipher_start_src_offset_in_bits =3D
                                         op->sym->cipher.data.offset;
                 job->msg_len_to_cipher_in_bits =3D
                                         op->sym->cipher.data.length;
+#else
+               job->cipher_start_src_offset_in_bytes =3D
+                                       op->sym->cipher.data.offset >> 3;
+               job->msg_len_to_cipher_in_bytes =3D
+                                       op->sym->cipher.data.length >> 3;
+#endif
                 break;
         case IMB_CIPHER_GCM:
                 job->cipher_start_src_offset_in_bytes =3D
@@ -2047,8 +2080,8 @@ post_process_mb_job(struct ipsec_mb_qp *qp, IMB_JOB *=
job)
                                 aesni_mb_digest_appended_in_src(op, job, o=
op) !=3D NULL) {
                                         unsigned int auth_size, cipher_siz=
e;
                                         int unencrypted_bytes =3D 0;
-                                       if (job->cipher_mode =3D=3D IMB_CIP=
HER_SNOW3G_UEA2_BITLEN ||
-                                               job->cipher_mode =3D=3D IMB=
_CIPHER_KASUMI_UEA1_BITLEN ||
+                                       if (job->cipher_mode =3D=3D IMB_CIP=
HER_SNOW3G_UEA2 ||
+                                               job->cipher_mode =3D=3D IMB=
_CIPHER_KASUMI_UEA1 ||
                                                 job->cipher_mode =3D=3D IM=
B_CIPHER_ZUC_EEA3) {
                                                 cipher_size =3D (op->sym->=
cipher.data.offset >> 3) +
                                                         (op->sym->cipher.d=
ata.length >> 3);
@@ -2056,10 +2089,12 @@ post_process_mb_job(struct ipsec_mb_qp *qp, IMB_JOB=
 *job)
                                                 cipher_size =3D (op->sym->=
cipher.data.offset) +
                                                         (op->sym->cipher.d=
ata.length);
                                         }
-                                       if (job->hash_alg =3D=3D IMB_AUTH_Z=
UC_EIA3_BITLEN ||
-                                               job->hash_alg =3D=3D IMB_AU=
TH_SNOW3G_UIA2_BITLEN ||
-                                               job->hash_alg =3D=3D IMB_AU=
TH_KASUMI_UIA1 ||
-                                               job->hash_alg =3D=3D IMB_AU=
TH_ZUC256_EIA3_BITLEN) {
+                                       if (job->hash_alg =3D=3D IMB_AUTH_Z=
UC_EIA3 ||
+                                               job->hash_alg =3D=3D IMB_AU=
TH_SNOW3G_UIA2 ||
+#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
+                                               job->hash_alg =3D=3D IMB_AU=
TH_ZUC256_EIA3 ||
+#endif
+                                               job->hash_alg =3D=3D IMB_AU=
TH_KASUMI_UIA1) {
                                                 auth_size =3D (op->sym->au=
th.data.offset >> 3) +
                                                         (op->sym->auth.dat=
a.length >> 3);
                                         } else {
@@ -2550,7 +2585,9 @@ RTE_INIT(ipsec_mb_register_aesni_mb)
                         RTE_CRYPTODEV_FF_SYM_OPERATION_CHAINING |
                         RTE_CRYPTODEV_FF_OOP_LB_IN_LB_OUT |
                         RTE_CRYPTODEV_FF_SYM_CPU_CRYPTO |
+#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
                         RTE_CRYPTODEV_FF_NON_BYTE_ALIGNED_DATA |
+#endif
                         RTE_CRYPTODEV_FF_SYM_SESSIONLESS |
                         RTE_CRYPTODEV_FF_IN_PLACE_SGL |
                         RTE_CRYPTODEV_FF_OOP_SGL_IN_SGL_OUT |
diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h b/drivers/crypto/i=
psec_mb/pmd_aesni_mb_priv.h
index ad38a1e28a..6afda45414 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h
@@ -19,6 +19,15 @@

 #define MAX_NUM_SEGS 16

+/* bit len removed in 3.0 */
+#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
+#define IMB_CIPHER_SNOW3G_UEA2 IMB_CIPHER_SNOW3G_UEA2_BITLEN
+#define IMB_CIPHER_KASUMI_UEA1 IMB_CIPHER_KASUMI_UEA1_BITLEN
+#define IMB_AUTH_ZUC_EIA3 IMB_AUTH_ZUC_EIA3_BITLEN
+#define IMB_AUTH_SNOW3G_UIA2 IMB_AUTH_SNOW3G_UIA2_BITLEN
+#define IMB_AUTH_ZUC256_EIA3 IMB_AUTH_ZUC256_EIA3_BITLEN
+#endif
+
 int
 aesni_mb_session_configure(IMB_MGR * m __rte_unused, void *priv_sess,
                 const struct rte_crypto_sym_xform *xform);
@@ -573,8 +582,13 @@ static const struct rte_cryptodev_capabilities aesni_m=
b_capabilities[] =3D {
                                 .block_size =3D 16,
                                 .key_size =3D {
                                         .min =3D 16,
+#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
                                         .max =3D 32,
                                         .increment =3D 16
+#else
+                                       .max =3D 16,
+                                       .increment =3D 0
+#endif
                                 },
                                 .digest_size =3D {
                                         .min =3D 4,
@@ -583,8 +597,13 @@ static const struct rte_cryptodev_capabilities aesni_m=
b_capabilities[] =3D {
                                 },
                                 .iv_size =3D {
                                         .min =3D 16,
+#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
                                         .max =3D 25,
                                         .increment =3D 9
+#else
+                                       .max =3D 16,
+                                       .increment =3D 0
+#endif
                                 }
                         }, }
                 }, }
@@ -598,13 +617,23 @@ static const struct rte_cryptodev_capabilities aesni_=
mb_capabilities[] =3D {
                                 .block_size =3D 16,
                                 .key_size =3D {
                                         .min =3D 16,
+#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
                                         .max =3D 32,
                                         .increment =3D 16
+#else
+                                       .max =3D 16,
+                                       .increment =3D 0
+#endif
                                 },
                                 .iv_size =3D {
                                         .min =3D 16,
+#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
                                         .max =3D 25,
                                         .increment =3D 9
+#else
+                                       .max =3D 16,
+                                       .increment =3D 0
+#endif
                                 },
                         }, }
                 }, }
@@ -888,9 +917,9 @@ static const unsigned int auth_blocksize[] =3D {
                 [IMB_AUTH_SHA_256]              =3D 64,
                 [IMB_AUTH_SHA_384]              =3D 128,
                 [IMB_AUTH_SHA_512]              =3D 128,
-               [IMB_AUTH_ZUC_EIA3_BITLEN]      =3D 16,
-               [IMB_AUTH_SNOW3G_UIA2_BITLEN]   =3D 16,
-               [IMB_AUTH_KASUMI_UIA1]          =3D 16
+               [IMB_AUTH_ZUC_EIA3]             =3D 16,
+               [IMB_AUTH_SNOW3G_UIA2]  =3D 16,
+               [IMB_AUTH_KASUMI_UIA1]  =3D 16
 };

 /**
@@ -922,9 +951,9 @@ static const unsigned int auth_truncated_digest_byte_le=
ngths[] =3D {
                 [IMB_AUTH_SHA_256]              =3D 32,
                 [IMB_AUTH_SHA_384]              =3D 48,
                 [IMB_AUTH_SHA_512]              =3D 64,
-               [IMB_AUTH_ZUC_EIA3_BITLEN]      =3D 4,
-               [IMB_AUTH_SNOW3G_UIA2_BITLEN]   =3D 4,
-               [IMB_AUTH_KASUMI_UIA1]          =3D 4
+               [IMB_AUTH_ZUC_EIA3]             =3D 4,
+               [IMB_AUTH_SNOW3G_UIA2]  =3D 4,
+               [IMB_AUTH_KASUMI_UIA1]  =3D 4
 };

 /**
@@ -957,9 +986,9 @@ static const unsigned int auth_digest_byte_lengths[] =
=3D {
                 [IMB_AUTH_SHA_256]              =3D 32,
                 [IMB_AUTH_SHA_384]              =3D 48,
                 [IMB_AUTH_SHA_512]              =3D 64,
-               [IMB_AUTH_ZUC_EIA3_BITLEN]      =3D 4,
-               [IMB_AUTH_SNOW3G_UIA2_BITLEN]   =3D 4,
-               [IMB_AUTH_KASUMI_UIA1]          =3D 4,
+               [IMB_AUTH_ZUC_EIA3]             =3D 4,
+               [IMB_AUTH_SNOW3G_UIA2]  =3D 4,
+               [IMB_AUTH_KASUMI_UIA1]  =3D 4,
                 [IMB_AUTH_SM3]                  =3D 32,
                 [IMB_AUTH_HMAC_SM3]             =3D 32,
         /**< Vector mode dependent pointer table of the multi-buffer APIs =
*/
--
2.52.0


--_000_LV2PR11MB6045F1A0465FAB19E5A7358F81952LV2PR11MB6045namp_
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
<div class=3D"elementToProof" style=3D"margin: 0in; font-family: &quot;Inte=
lOne Text&quot;; font-size: 10pt; color: rgb(0, 0, 0);">
Series-acked-by: Kai Ji &lt;kai.ji@intel.com&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Nicolau, Radu &lt;rad=
u.nicolau@intel.com&gt;<br>
<b>Sent:</b> 02 October 2026 10:56<br>
<b>To:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
<b>Cc:</b> Nicolau, Radu &lt;radu.nicolau@intel.com&gt;; Ji, Kai &lt;kai.ji=
@intel.com&gt;; De Lara Guarch, Pablo &lt;pablo.de.lara.guarch@intel.com&gt=
;<br>
<b>Subject:</b> [PATCH 1/4] crypto/ipsec_mb: add support for IPsecMB 3.0</f=
ont>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Add support for IPsecMB release 3.0<br>
&nbsp;- removed all _BITLEN enums, all lengths are in bytes<br>
&nbsp;- removed feature flag<br>
&nbsp;- use non const IMB_MGR<br>
&nbsp;- use IMB API instead of function pointers in the GCM PMD<br>
&nbsp;- remove ZUC 256 support<br>
<br>
Signed-off-by: Radu Nicolau &lt;radu.nicolau@intel.com&gt;<br>
---<br>
&nbsp;doc/guides/cryptodevs/aesni_gcm.rst&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 4 +-<br>
&nbsp;doc/guides/cryptodevs/aesni_mb.rst&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 11 +-<br>
&nbsp;doc/guides/rel_notes/release_26_11.rst&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; |&nbsp;&nbsp; 4 +<br>
&nbsp;drivers/crypto/ipsec_mb/pmd_aesni_gcm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 | 267 +++++++++++++++----<br>
&nbsp;drivers/crypto/ipsec_mb/pmd_aesni_gcm_priv.h |&nbsp; 31 +--<br>
&nbsp;drivers/crypto/ipsec_mb/pmd_aesni_mb.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; | 107 +++++---<br>
&nbsp;drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h&nbsp; |&nbsp; 47 +++-<br>
&nbsp;7 files changed, 349 insertions(+), 122 deletions(-)<br>
<br>
diff --git a/doc/guides/cryptodevs/aesni_gcm.rst b/doc/guides/cryptodevs/ae=
sni_gcm.rst<br>
index aefc1cedcb..e68dc4eb1e 100644<br>
--- a/doc/guides/cryptodevs/aesni_gcm.rst<br>
+++ b/doc/guides/cryptodevs/aesni_gcm.rst<br>
@@ -40,8 +40,8 @@ Installation<br>
&nbsp;To build DPDK with the AESNI_GCM_PMD the user is required to download=
 the multi-buffer<br>
&nbsp;library from `here &lt;<a href=3D"https://github.com/01org/intel-ipse=
c-mb">https://github.com/01org/intel-ipsec-mb</a>&gt;`_<br>
&nbsp;and compile it on their user system before building DPDK.<br>
-The latest version of the library supported by this PMD is v2.0, which<br>
-can be downloaded from `&lt;<a href=3D"https://github.com/01org/intel-ipse=
c-mb/archive/v2.0.zip">https://github.com/01org/intel-ipsec-mb/archive/v2.0=
.zip</a>&gt;`_.<br>
+The latest version of the library supported by this PMD is v3.0, which<br>
+can be downloaded from `&lt;<a href=3D"https://github.com/01org/intel-ipse=
c-mb/archive/v3.0.zip">https://github.com/01org/intel-ipsec-mb/archive/v3.0=
.zip</a>&gt;`_.<br>
&nbsp;<br>
&nbsp;For Arm system, ARM64 port of the multi-buffer library can be downloa=
ded from<br>
&nbsp;<a href=3D"https://gitlab.arm.com/arm-reference-solutions/ipsec-mb/-/=
tree/main/">https://gitlab.arm.com/arm-reference-solutions/ipsec-mb/-/tree/=
main/</a>.<br>
diff --git a/doc/guides/cryptodevs/aesni_mb.rst b/doc/guides/cryptodevs/aes=
ni_mb.rst<br>
index add3c03b74..4851997fd9 100644<br>
--- a/doc/guides/cryptodevs/aesni_mb.rst<br>
+++ b/doc/guides/cryptodevs/aesni_mb.rst<br>
@@ -73,6 +73,13 @@ Protocol offloads:<br>
&nbsp;<br>
&nbsp;* RTE_SECURITY_PROTOCOL_DOCSIS<br>
&nbsp;<br>
+Note<br>
+----<br>
+Version 3.0 of the multi-buffer library removed support for:<br>
+<br>
+* the 256 bit versions of ZUC EEA3 and ZUC EIA3 algorithms.<br>
+* non byte aligned bit length (``RTE_CRYPTODEV_FF_NON_BYTE_ALIGNED_DATA`` =
removed).<br>
+<br>
&nbsp;Limitations<br>
&nbsp;-----------<br>
&nbsp;<br>
@@ -96,8 +103,8 @@ Installation<br>
&nbsp;To build DPDK with the AESNI_MB_PMD the user is required to download =
the multi-buffer<br>
&nbsp;library from `here &lt;<a href=3D"https://github.com/01org/intel-ipse=
c-mb">https://github.com/01org/intel-ipsec-mb</a>&gt;`_<br>
&nbsp;and compile it on their user system before building DPDK.<br>
-The latest version of the library supported by this PMD is v2.0, which<br>
-can be downloaded from `&lt;<a href=3D"https://github.com/01org/intel-ipse=
c-mb/archive/v2.0.zip">https://github.com/01org/intel-ipsec-mb/archive/v2.0=
.zip</a>&gt;`_.<br>
+The latest version of the library supported by this PMD is v3.0, which<br>
+can be downloaded from `&lt;<a href=3D"https://github.com/01org/intel-ipse=
c-mb/archive/v3.0.zip">https://github.com/01org/intel-ipsec-mb/archive/v3.0=
.zip</a>&gt;`_.<br>
&nbsp;<br>
&nbsp;For Arm system, ARM64 port of the multi-buffer library can be downloa=
ded from<br>
&nbsp;<a href=3D"https://gitlab.arm.com/arm-reference-solutions/ipsec-mb/-/=
tree/main/">https://gitlab.arm.com/arm-reference-solutions/ipsec-mb/-/tree/=
main/</a>.<br>
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/=
release_26_11.rst<br>
index 69ab5af8a3..ea126aa9bb 100644<br>
--- a/doc/guides/rel_notes/release_26_11.rst<br>
+++ b/doc/guides/rel_notes/release_26_11.rst<br>
@@ -33,6 +33,10 @@ New Features<br>
&nbsp;&nbsp; ``pss_salt`` field in ``rte_crypto_rsa_op_param`` to carry it =
per<br>
&nbsp;&nbsp; sign operation.<br>
&nbsp;<br>
+* **Updated AESNI_MB crypto driver.**<br>
+<br>
+&nbsp; * Added support for version 3.0 of IPsec MB Library.<br>
+<br>
&nbsp;.. This section should contain new features added in this release.<br=
>
&nbsp;&nbsp;&nbsp; Sample format:<br>
&nbsp;<br>
diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_gcm.c b/drivers/crypto/ipsec=
_mb/pmd_aesni_gcm.c<br>
index 3c266cc47e..0c4358a7b1 100644<br>
--- a/drivers/crypto/ipsec_mb/pmd_aesni_gcm.c<br>
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_gcm.c<br>
@@ -6,56 +6,205 @@<br>
&nbsp;<br>
&nbsp;#include &quot;pmd_aesni_gcm_priv.h&quot;<br>
&nbsp;<br>
+/* wrapper functions for library versions &lt; 3.0.0 */<br>
+#if IMB_VERSION(3, 0, 0) &gt; IMB_VERSION_NUM<br>
+<br>
+#define _fn(bitlen) static void imb_aes##bitlen##_gcm_pre(const void *key,=
 \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct gcm_key_data *key_data, IMB_MGR *state) \<br>
+{ \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state-&gt;gcm##bitlen##_pre(key, key_=
data); \<br>
+}<br>
+_fn(128)<br>
+_fn(192)<br>
+_fn(256)<br>
+#undef _fn<br>
+<br>
+#define _fn(bitlen) static void imb_aes##bitlen##_gcm_init( \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; const struct gcm_key_data *key_data, \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct gcm_context_data *context_data, const void *iv, \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; const void *aad, uint64_t aad_len, IMB_MGR *state) \<br>
+{ \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state-&gt;gcm##bitlen##_init(key_data=
, context_data, iv, aad, aad_len); \<br>
+}<br>
+_fn(128)<br>
+_fn(192)<br>
+_fn(256)<br>
+#undef _fn<br>
+<br>
+#define _fn(bitlen) static void imb_aes##bitlen##_gcm_enc( \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; const struct gcm_key_data *key_data, \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct gcm_context_data *context_data, void *out, \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; const void *in, uint64_t len, const void *iv, \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; const void *aad, uint64_t aad_len, void *auth_tag, \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint64_t auth_tag_len, IMB_MGR *state) \<br>
+{ \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state-&gt;gcm##bitlen##_enc(key_data,=
 context_data, out, in, len, iv, \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aad, aad_len, au=
th_tag, auth_tag_len); \<br>
+}<br>
+_fn(128)<br>
+_fn(192)<br>
+_fn(256)<br>
+#undef _fn<br>
+<br>
+#define _fn(bitlen) static void imb_aes##bitlen##_gcm_enc_update( \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; const struct gcm_key_data *key_data, \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct gcm_context_data *context_data, void *out, \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; const void *in, const uint64_t len, IMB_MGR *state) \<br>
+{ \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state-&gt;gcm##bitlen##_enc_update(ke=
y_data, context_data, out, in, len); \<br>
+}<br>
+_fn(128)<br>
+_fn(192)<br>
+_fn(256)<br>
+#undef _fn<br>
+<br>
+#define _fn(bitlen) static void imb_aes##bitlen##_gcm_enc_finalize( \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; const struct gcm_key_data *key_data, \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct gcm_context_data *context_data, void *auth_tag, \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; const uint64_t auth_tag_len, IMB_MGR *state) \<br>
+{ \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state-&gt;gcm##bitlen##_enc_finalize(=
key_data, context_data, auth_tag, \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; auth_tag_len); \=
<br>
+}<br>
+_fn(128)<br>
+_fn(192)<br>
+_fn(256)<br>
+#undef _fn<br>
+<br>
+#define _fn(bitlen) static void imb_aes##bitlen##_gcm_dec( \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; const struct gcm_key_data *key_data, \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct gcm_context_data *context_data, void *out, \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; const void *in, uint64_t len, const void *iv, \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; const void *aad, uint64_t aad_len, void *auth_tag, \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint64_t auth_tag_len, IMB_MGR *state) \<br>
+{ \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state-&gt;gcm##bitlen##_dec(key_data,=
 context_data, out, in, len, iv, \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aad, aad_len, au=
th_tag, auth_tag_len); \<br>
+}<br>
+_fn(128)<br>
+_fn(192)<br>
+_fn(256)<br>
+#undef _fn<br>
+<br>
+#define _fn(bitlen) static void imb_aes##bitlen##_gcm_dec_update( \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; const struct gcm_key_data *key_data, \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct gcm_context_data *context_data, void *out, \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; const void *in, const uint64_t len, IMB_MGR *state) \<br>
+{ \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state-&gt;gcm##bitlen##_dec_update(ke=
y_data, context_data, out, in, len); \<br>
+}<br>
+_fn(128)<br>
+_fn(192)<br>
+_fn(256)<br>
+#undef _fn<br>
+<br>
+#define _fn(bitlen) static void imb_aes##bitlen##_gcm_dec_finalize( \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; const struct gcm_key_data *key_data, \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct gcm_context_data *context_data, void *auth_tag, \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; const uint64_t auth_tag_len, IMB_MGR *state) \<br>
+{ \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state-&gt;gcm##bitlen##_dec_finalize(=
key_data, context_data, auth_tag, \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; auth_tag_len); \=
<br>
+}<br>
+_fn(128)<br>
+_fn(192)<br>
+_fn(256)<br>
+#undef _fn<br>
+<br>
+#define _fn(bitlen) static void imb_aes##bitlen##_gmac_init( \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; const struct gcm_key_data *key_data, \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct gcm_context_data *context_data, const void *iv, \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; const uint64_t iv_len, IMB_MGR *state) \<br>
+{ \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state-&gt;gmac##bitlen##_init(key_dat=
a, context_data, iv, iv_len); \<br>
+}<br>
+_fn(128)<br>
+_fn(192)<br>
+_fn(256)<br>
+#undef _fn<br>
+<br>
+#define _fn(bitlen) static void imb_aes##bitlen##_gmac_update( \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; const struct gcm_key_data *key_data, \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct gcm_context_data *context_data, const void *in, \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; const uint64_t len, IMB_MGR *state) \<br>
+{ \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state-&gt;gmac##bitlen##_update(key_d=
ata, context_data, in, len); \<br>
+}<br>
+_fn(128)<br>
+_fn(192)<br>
+_fn(256)<br>
+#undef _fn<br>
+<br>
+#define _fn(bitlen) static void imb_aes##bitlen##_gmac_finalize( \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; const struct gcm_key_data *key_data, \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct gcm_context_data *context_data, void *auth_tag, \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; const uint64_t auth_tag_len, IMB_MGR *state) \<br>
+{ \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state-&gt;gmac##bitlen##_finalize(key=
_data, context_data, auth_tag, \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; auth_tag_len); \=
<br>
+}<br>
+_fn(128)<br>
+_fn(192)<br>
+_fn(256)<br>
+#undef _fn<br>
+<br>
+#endif<br>
+<br>
&nbsp;static void<br>
&nbsp;aesni_gcm_set_ops(struct aesni_gcm_ops *ops, IMB_MGR *mb_mgr)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Set IMB_MGR pointers. */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_128].mb_mgr =3D mb_mgr;<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_192].mb_mgr =3D mb_mgr;<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_256].mb_mgr =3D mb_mgr;<b=
r>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Set 128 bit function po=
inters. */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_128].pre =3D mb_mgr-&gt;g=
cm128_pre;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_128].init =3D mb_mgr-&gt;=
gcm128_init;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_128].pre =3D imb_aes128_g=
cm_pre;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_128].init =3D imb_aes128_=
gcm_init;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_128].enc =3D mb_mgr-&gt;g=
cm128_enc;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_128].update_enc =3D mb_mg=
r-&gt;gcm128_enc_update;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_128].finalize_enc =3D mb_=
mgr-&gt;gcm128_enc_finalize;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_128].enc =3D imb_aes128_g=
cm_enc;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_128].update_enc =3D imb_a=
es128_gcm_enc_update;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_128].finalize_enc =3D imb=
_aes128_gcm_enc_finalize;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_128].dec =3D mb_mgr-&gt;g=
cm128_dec;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_128].update_dec =3D mb_mg=
r-&gt;gcm128_dec_update;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_128].finalize_dec =3D mb_=
mgr-&gt;gcm128_dec_finalize;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_128].dec =3D imb_aes128_g=
cm_dec;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_128].update_dec =3D imb_a=
es128_gcm_dec_update;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_128].finalize_dec =3D imb=
_aes128_gcm_dec_finalize;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_128].gmac_init =3D mb_mgr=
-&gt;gmac128_init;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_128].gmac_update =3D mb_m=
gr-&gt;gmac128_update;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_128].gmac_finalize =3D mb=
_mgr-&gt;gmac128_finalize;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_128].gmac_init =3D imb_ae=
s128_gmac_init;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_128].gmac_update =3D imb_=
aes128_gmac_update;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_128].gmac_finalize =3D im=
b_aes128_gmac_finalize;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Set 192 bit function po=
inters. */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_192].pre =3D mb_mgr-&gt;g=
cm192_pre;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_192].init =3D mb_mgr-&gt;=
gcm192_init;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_192].pre =3D imb_aes192_g=
cm_pre;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_192].init =3D imb_aes192_=
gcm_init;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_192].enc =3D mb_mgr-&gt;g=
cm192_enc;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_192].update_enc =3D mb_mg=
r-&gt;gcm192_enc_update;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_192].finalize_enc =3D mb_=
mgr-&gt;gcm192_enc_finalize;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_192].enc =3D imb_aes192_g=
cm_enc;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_192].update_enc =3D imb_a=
es192_gcm_enc_update;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_192].finalize_enc =3D imb=
_aes192_gcm_enc_finalize;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_192].dec =3D mb_mgr-&gt;g=
cm192_dec;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_192].update_dec =3D mb_mg=
r-&gt;gcm192_dec_update;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_192].finalize_dec =3D mb_=
mgr-&gt;gcm192_dec_finalize;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_192].dec =3D imb_aes192_g=
cm_dec;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_192].update_dec =3D imb_a=
es192_gcm_dec_update;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_192].finalize_dec =3D imb=
_aes192_gcm_dec_finalize;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_192].gmac_init =3D mb_mgr=
-&gt;gmac192_init;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_192].gmac_update =3D mb_m=
gr-&gt;gmac192_update;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_192].gmac_finalize =3D mb=
_mgr-&gt;gmac192_finalize;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_192].gmac_init =3D imb_ae=
s192_gmac_init;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_192].gmac_update =3D imb_=
aes192_gmac_update;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_192].gmac_finalize =3D im=
b_aes192_gmac_finalize;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Set 256 bit function po=
inters. */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_256].pre =3D mb_mgr-&gt;g=
cm256_pre;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_256].init =3D mb_mgr-&gt;=
gcm256_init;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_256].pre =3D imb_aes256_g=
cm_pre;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_256].init =3D imb_aes256_=
gcm_init;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_256].enc =3D mb_mgr-&gt;g=
cm256_enc;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_256].update_enc =3D mb_mg=
r-&gt;gcm256_enc_update;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_256].finalize_enc =3D mb_=
mgr-&gt;gcm256_enc_finalize;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_256].enc =3D imb_aes256_g=
cm_enc;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_256].update_enc =3D imb_a=
es256_gcm_enc_update;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_256].finalize_enc =3D imb=
_aes256_gcm_enc_finalize;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_256].dec =3D mb_mgr-&gt;g=
cm256_dec;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_256].update_dec =3D mb_mg=
r-&gt;gcm256_dec_update;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_256].finalize_dec =3D mb_=
mgr-&gt;gcm256_dec_finalize;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_256].dec =3D imb_aes256_g=
cm_dec;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_256].update_dec =3D imb_a=
es256_gcm_dec_update;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_256].finalize_dec =3D imb=
_aes256_gcm_dec_finalize;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_256].gmac_init =3D mb_mgr=
-&gt;gmac256_init;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_256].gmac_update =3D mb_m=
gr-&gt;gmac256_update;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_256].gmac_finalize =3D mb=
_mgr-&gt;gmac256_finalize;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_256].gmac_init =3D imb_ae=
s256_gmac_init;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_256].gmac_update =3D imb_=
aes256_gmac_update;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops[GCM_KEY_256].gmac_finalize =3D im=
b_aes256_gmac_finalize;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int<br>
@@ -135,15 +284,15 @@ aesni_gcm_session_configure(IMB_MGR *mb_mgr, void *se=
ssion,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (key_length) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 16:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; sess-&gt;key_length =3D GCM_KEY_128;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mb_mgr-&gt;gcm128_pre(key, &amp;sess-&gt;gdata_key);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; imb_aes128_gcm_pre(key, &amp;sess-&gt;gdata_key, mb_mgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 24:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; sess-&gt;key_length =3D GCM_KEY_192;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mb_mgr-&gt;gcm192_pre(key, &amp;sess-&gt;gdata_key);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; imb_aes192_gcm_pre(key, &amp;sess-&gt;gdata_key, mb_mgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 32:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; sess-&gt;key_length =3D GCM_KEY_256;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mb_mgr-&gt;gcm256_pre(key, &amp;sess-&gt;gdata_key);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; imb_aes256_gcm_pre(key, &amp;sess-&gt;gdata_key, mb_mgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; IPSEC_MB_LOG(ERR, &quot;Invalid key length&quot;);<br=
>
@@ -324,10 +473,10 @@ process_gcm_crypto_op(struct ipsec_mb_qp *qp, struct =
rte_crypto_op *op,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (session-&gt;op =3D=3D =
IPSEC_MB_OP_AEAD_AUTHENTICATED_ENCRYPT) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ops-&gt;init(&amp;session-&gt;gdata_key, &amp;qp_data=
-&gt;gcm_ctx_data, iv_ptr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sym_op-&gt;aead.aad.data,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint64_t)session-&gt;aad_length);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint64_t)session-&gt;aad_length, ops-&gt;m=
b_mgr);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ops-&gt;update_enc(&amp;session-&gt;gdata_key, &amp;q=
p_data-&gt;gcm_ctx_data,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst, src, (uint64_t)part_len);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst, src, (uint64_t)part_len, ops-&gt;mb_mg=
r);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; total_len =3D data_length - part_len;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; while (total_len) {<br>
@@ -345,7 +494,7 @@ process_gcm_crypto_op(struct ipsec_mb_qp *qp, struct rt=
e_crypto_op *op,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops-&=
gt;update_enc(&amp;session-&gt;gdata_key,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; &amp;qp_data-&gt;gcm_ctx_data,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; dst, src, (uint64_t)part_len);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; dst, src, (uint64_t)part_len, ops-&gt;mb_mgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; total=
_len -=3D part_len;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
@@ -355,14 +504,14 @@ process_gcm_crypto_op(struct ipsec_mb_qp *qp, struct =
rte_crypto_op *op,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tag =
=3D sym_op-&gt;aead.digest.data;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ops-&gt;finalize_enc(&amp;session-&gt;gdata_key, &amp=
;qp_data-&gt;gcm_ctx_data,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tag, session-&gt;gen_digest_length);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tag, session-&gt;gen_digest_length, ops-&gt=
;mb_mgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (session-&gt;op =
=3D=3D IPSEC_MB_OP_AEAD_AUTHENTICATED_DECRYPT) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ops-&gt;init(&amp;session-&gt;gdata_key, &amp;qp_data=
-&gt;gcm_ctx_data, iv_ptr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sym_op-&gt;aead.aad.data,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint64_t)session-&gt;aad_length);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint64_t)session-&gt;aad_length, ops-&gt;m=
b_mgr);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ops-&gt;update_dec(&amp;session-&gt;gdata_key, &amp;q=
p_data-&gt;gcm_ctx_data,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst, src, (uint64_t)part_len);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst, src, (uint64_t)part_len, ops-&gt;mb_mg=
r);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; total_len =3D data_length - part_len;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; while (total_len) {<br>
@@ -380,19 +529,19 @@ process_gcm_crypto_op(struct ipsec_mb_qp *qp, struct =
rte_crypto_op *op,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops-&=
gt;update_dec(&amp;session-&gt;gdata_key,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; &amp;qp_data-&gt;gcm_ctx_data,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; dst, src, (uint64_t)part_len);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; dst, src, (uint64_t)part_len, ops-&gt;mb_mgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; total=
_len -=3D part_len;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tag =3D qp_data-&gt;temp_digest;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ops-&gt;finalize_dec(&amp;session-&gt;gdata_key, &amp=
;qp_data-&gt;gcm_ctx_data,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tag, session-&gt;gen_digest_length);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tag, session-&gt;gen_digest_length, ops-&gt=
;mb_mgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (session-&gt;op =
=3D=3D IPSEC_MB_OP_HASH_GEN_ONLY) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ops-&gt;gmac_init(&amp;session-&gt;gdata_key, &amp;qp=
_data-&gt;gcm_ctx_data,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iv_ptr, session-&gt;iv.length);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iv_ptr, session-&gt;iv.length, ops-&gt;mb_m=
gr);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ops-&gt;gmac_update(&amp;session-&gt;gdata_key, &amp;=
qp_data-&gt;gcm_ctx_data,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; src, (uint64_t)part_len);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; src, (uint64_t)part_len, ops-&gt;mb_mgr);<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; total_len =3D data_length - part_len;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; while (total_len) {<br>
@@ -406,7 +555,7 @@ process_gcm_crypto_op(struct ipsec_mb_qp *qp, struct rt=
e_crypto_op *op,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops-&=
gt;gmac_update(&amp;session-&gt;gdata_key,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; &amp;qp_data-&gt;gcm_ctx_data, src,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (uint64_t)part_len);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (uint64_t)part_len, ops-&gt;mb_mgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; total=
_len -=3D part_len;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
@@ -416,13 +565,13 @@ process_gcm_crypto_op(struct ipsec_mb_qp *qp, struct =
rte_crypto_op *op,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tag =
=3D sym_op-&gt;auth.digest.data;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ops-&gt;gmac_finalize(&amp;session-&gt;gdata_key, &am=
p;qp_data-&gt;gcm_ctx_data,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tag, session-&gt;gen_digest_length);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tag, session-&gt;gen_digest_length, ops-&gt=
;mb_mgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else { /* IPSEC_MB_OP_HA=
SH_VERIFY_ONLY */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ops-&gt;gmac_init(&amp;session-&gt;gdata_key, &amp;qp=
_data-&gt;gcm_ctx_data,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iv_ptr, session-&gt;iv.length);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iv_ptr, session-&gt;iv.length, ops-&gt;mb_m=
gr);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ops-&gt;gmac_update(&amp;session-&gt;gdata_key, &amp;=
qp_data-&gt;gcm_ctx_data,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; src, (uint64_t)part_len);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; src, (uint64_t)part_len, ops-&gt;mb_mgr);<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; total_len =3D data_length - part_len;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; while (total_len) {<br>
@@ -436,14 +585,14 @@ process_gcm_crypto_op(struct ipsec_mb_qp *qp, struct =
rte_crypto_op *op,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops-&=
gt;gmac_update(&amp;session-&gt;gdata_key,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; &amp;qp_data-&gt;gcm_ctx_data, src,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (uint64_t)part_len);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (uint64_t)part_len, ops-&gt;mb_mgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; total=
_len -=3D part_len;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tag =3D qp_data-&gt;temp_digest;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ops-&gt;gmac_finalize(&amp;session-&gt;gdata_key, &am=
p;qp_data-&gt;gcm_ctx_data,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tag, session-&gt;gen_digest_length);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tag, session-&gt;gen_digest_length, ops-&gt=
;mb_mgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
@@ -540,11 +689,11 @@ aesni_gcm_sgl_op_finalize_encryption(const struct aes=
ni_gcm_session *s,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint8_t tmpdigest[s-&gt;gen_digest_length];<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ops.finalize_enc(&amp;s-&gt;gdata_key, gdata_ctx, tmp=
digest,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;gen_digest_length);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;gen_digest_length, ops.mb_mgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; memcpy(digest, tmpdigest, s-&gt;req_digest_length);<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ops.finalize_enc(&amp;s-&gt;gdata_key, gdata_ctx, dig=
est,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;gen_digest_length);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;gen_digest_length, ops.mb_mgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
@@ -558,7 +707,7 @@ aesni_gcm_sgl_op_finalize_decryption(const struct aesni=
_gcm_session *s,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t tmpdigest[s-&gt;ge=
n_digest_length];<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops.finalize_dec(&amp;s-&g=
t;gdata_key, gdata_ctx, tmpdigest,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;gen_digest=
_length);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;gen_digest=
_length, ops.mb_mgr);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return rte_memeq_timingsaf=
e(digest, tmpdigest, s-&gt;req_digest_length) ? 0 : EBADMSG;<br>
&nbsp;}<br>
@@ -573,7 +722,7 @@ aesni_gcm_process_gcm_sgl_op(const struct aesni_gcm_ses=
sion *s,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* init crypto operation *=
/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops.init(&amp;s-&gt;gdata_=
key, gdata_ctx, iv, aad,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint64_t)s-&gt;aad_length);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint64_t)s-&gt;aad_length, ops.mb_mgr);=
<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* update with sgl data */=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; sgl-&=
gt;num; i++) {<br>
@@ -582,11 +731,11 @@ aesni_gcm_process_gcm_sgl_op(const struct aesni_gcm_s=
ession *s,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; switch (s-&gt;op) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IPSEC_MB_OP_AEAD_AUTHENTICATED_ENCRYPT:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops.u=
pdate_enc(&amp;s-&gt;gdata_key, gdata_ctx,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; vec-&gt;base, vec-&gt;base, vec-&gt;len);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; vec-&gt;base, vec-&gt;base, vec-&gt;len, ops.mb_mgr);<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IPSEC_MB_OP_AEAD_AUTHENTICATED_DECRYPT:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops.u=
pdate_dec(&amp;s-&gt;gdata_key, gdata_ctx,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; vec-&gt;base, vec-&gt;base, vec-&gt;len);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; vec-&gt;base, vec-&gt;base, vec-&gt;len, ops.mb_mgr);<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IPSEC=
_MB_LOG(ERR, &quot;Invalid session op&quot;);<br>
@@ -603,7 +752,7 @@ aesni_gcm_process_gmac_sgl_op(const struct aesni_gcm_se=
ssion *s,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aesni_gcm_ops ops)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops.init(&amp;s-&gt;gdata_=
key, gdata_ctx, iv, sgl-&gt;vec[0].base,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sgl-&gt;vec[0].len);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sgl-&gt;vec[0].len, ops.mb_mgr);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static inline uint32_t<br>
diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_gcm_priv.h b/drivers/crypto/=
ipsec_mb/pmd_aesni_gcm_priv.h<br>
index 8a5a41fb19..4074430d6e 100644<br>
--- a/drivers/crypto/ipsec_mb/pmd_aesni_gcm_priv.h<br>
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_gcm_priv.h<br>
@@ -79,41 +79,41 @@ enum aesni_gcm_key_length {<br>
&nbsp;<br>
&nbsp;typedef void (*aesni_gcm_t)(const struct gcm_key_data *gcm_key_data,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; struct gcm_context_data *gcm_ctx_data,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; uint8_t *out, const uint8_t *in,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; uint64_t plaintext_len, const uint8_t *iv,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; const uint8_t *aad, uint64_t aad_len,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; uint8_t *auth_tag, uint64_t auth_tag_len);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; void *out, const void *in,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; uint64_t plaintext_len, const void *iv,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; const void *aad, uint64_t aad_len,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; void *auth_tag, uint64_t auth_tag_len, IMB_MGR *state);<br>
&nbsp;<br>
&nbsp;typedef void (*aesni_gcm_pre_t)(const void *key,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct gcm_key_data *gcm_data);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct gcm_key_data *gcm_data, IMB_MGR *sta=
te);<br>
&nbsp;<br>
&nbsp;typedef void (*aesni_gcm_init_t)(const struct gcm_key_data *gcm_key_d=
ata,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct gcm_context_data *g=
cm_ctx_data,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const uint8_t *iv, uint8_t const *aad=
,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t aad_len);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const void *iv, const void *aad,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t aad_len, IMB_MGR *state);<br=
>
&nbsp;<br>
&nbsp;typedef void (*aesni_gcm_update_t)(const struct gcm_key_data *gcm_key=
_data,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct gcm_con=
text_data *gcm_ctx_data,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t *out, const uint8=
_t *in,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t plaintext_len);<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *out, const void *in=
,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t plaintext_len, I=
MB_MGR *state);<br>
&nbsp;<br>
&nbsp;typedef void (*aesni_gcm_finalize_t)(const struct gcm_key_data *gcm_k=
ey_data,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; st=
ruct gcm_context_data *gcm_ctx_data,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t *auth=
_tag, uint64_t auth_tag_len);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *auth_ta=
g, uint64_t auth_tag_len, IMB_MGR *state);<br>
&nbsp;<br>
&nbsp;typedef void (*aesni_gmac_init_t)(const struct gcm_key_data *gcm_key_=
data,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct gcm_context_d=
ata *gcm_ctx_data,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const uint8_t *iv, const uint64=
_t iv_len);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const void *iv, const uint64_t =
iv_len, IMB_MGR *state);<br>
&nbsp;<br>
&nbsp;typedef void (*aesni_gmac_update_t)(const struct gcm_key_data *gcm_ke=
y_data,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct g=
cm_context_data *gcm_ctx_data,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const uint8_t *in,<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const uint64_t plai=
ntext_len);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const void *in,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const uint64_t plai=
ntext_len, IMB_MGR *state);<br>
&nbsp;<br>
&nbsp;typedef void (*aesni_gmac_finalize_t)(const struct gcm_key_data *gcm_=
key_data,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; struct gcm_context_data *gcm_ctx_data,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t=
 *auth_tag,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const u=
int64_t auth_tag_len);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *a=
uth_tag,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const u=
int64_t auth_tag_len, IMB_MGR *state);<br>
&nbsp;<br>
&nbsp;/** GCM operation handlers */<br>
&nbsp;struct aesni_gcm_ops {<br>
@@ -128,6 +128,7 @@ struct aesni_gcm_ops {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aesni_gmac_init_t gmac_ini=
t;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aesni_gmac_update_t gmac_u=
pdate;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aesni_gmac_finalize_t gmac=
_finalize;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IMB_MGR *mb_mgr;<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;RTE_DEFINE_PER_LCORE(struct aesni_gcm_ops, gcm_ops[GCM_NUM_KEY_TYPES]=
);<br>
diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c b/drivers/crypto/ipsec_=
mb/pmd_aesni_mb.c<br>
index 02bacd020b..e8f6e77d21 100644<br>
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c<br>
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c<br>
@@ -161,20 +161,22 @@ aesni_mb_set_session_auth_parameters(IMB_MGR *mb_mgr,=
<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (xform-&gt;auth.algo =
=3D=3D RTE_CRYPTO_AUTH_ZUC_EIA3) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (xform-&gt;auth.key.length =3D=3D 16) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sess-&gt;templat=
e_job.hash_alg =3D IMB_AUTH_ZUC_EIA3_BITLEN;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sess-&gt;templat=
e_job.hash_alg =3D IMB_AUTH_ZUC_EIA3;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (s=
ess-&gt;auth.req_digest_len !=3D 4) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IPSEC_MB_LOG(ERR, &quot;Invalid =
digest size&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+#if IMB_VERSION(3, 0, 0) &gt; IMB_VERSION_NUM<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; } else if (xform-&gt;auth.key.length =3D=3D 32) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sess-&gt;templat=
e_job.hash_alg =3D IMB_AUTH_ZUC256_EIA3_BITLEN;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sess-&gt;templat=
e_job.hash_alg =3D IMB_AUTH_ZUC256_EIA3;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (s=
ess-&gt;auth.req_digest_len !=3D 4 &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; sess-&gt;auth.req_digest_len !=3D 8 &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; sess-&gt;auth.req_digest_len !=3D 16) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IPSEC_MB_LOG(ERR, &quot;Invalid =
digest size&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+#endif<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IPSEC=
_MB_LOG(ERR, &quot;Invalid authentication key length&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n -EINVAL;<br>
@@ -187,10 +189,10 @@ aesni_mb_set_session_auth_parameters(IMB_MGR *mb_mgr,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; sess-&gt;template_job.u.ZUC_EIA3._key =3D sess-&gt;au=
th.zuc_auth_key;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (xform-&gt;auth.=
algo =3D=3D RTE_CRYPTO_AUTH_SNOW3G_UIA2) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; sess-&gt;template_job.hash_alg =3D IMB_AUTH_SNOW3G_UIA2_BITLEN;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; sess-&gt;template_job.hash_alg =3D IMB_AUTH_SNOW3G_UIA2;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint16_t snow3g_uia2_digest_len =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; get_t=
runcated_digest_byte_length(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IMB_AUTH_SNOW3G_UIA2_B=
ITLEN);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IMB_AUTH_SNOW3G_UIA2);=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (sess-&gt;auth.req_digest_len !=3D snow3g_uia2_dig=
est_len) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IPSEC=
_MB_LOG(ERR, &quot;Invalid digest size&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n -EINVAL;<br>
@@ -339,7 +341,7 @@ aesni_mb_set_session_auth_parameters(IMB_MGR *mb_mgr,<b=
r>
&nbsp;<br>
&nbsp;/** Set session cipher parameters */<br>
&nbsp;static int<br>
-aesni_mb_set_session_cipher_parameters(const IMB_MGR *mb_mgr,<br>
+aesni_mb_set_session_cipher_parameters(IMB_MGR *mb_mgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct aesni_mb_session *sess,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; const struct rte_crypto_sym_xform *xform)<br>
&nbsp;{<br>
@@ -407,11 +409,11 @@ aesni_mb_set_session_cipher_parameters(const IMB_MGR =
*mb_mgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; is_zuc =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RTE_CRYPTO_CIPHER_SNO=
W3G_UEA2:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; sess-&gt;template_job.cipher_mode =3D IMB_CIPHER_SNOW3G_UEA2_BIT=
LEN;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; sess-&gt;template_job.cipher_mode =3D IMB_CIPHER_SNOW3G_UEA2;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; is_snow3g =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RTE_CRYPTO_CIPHER_KAS=
UMI_F8:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; sess-&gt;template_job.cipher_mode =3D IMB_CIPHER_KASUMI_UEA1_BIT=
LEN;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; sess-&gt;template_job.cipher_mode =3D IMB_CIPHER_KASUMI_UEA1;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; is_kasumi =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RTE_CRYPTO_CIPHER_NUL=
L:<br>
@@ -536,8 +538,11 @@ aesni_mb_set_session_cipher_parameters(const IMB_MGR *=
mb_mgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; sess-&gt;template_job.dec_keys =3D sess-&gt;cipher.ex=
p_3des_keys.ks_ptr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; sess-&gt;template_job.key_len_in_bytes =3D 24;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (is_zuc) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (xform-&gt;cipher.key.length !=3D 16 &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xform-&gt;cipher.key.length !=3D 32) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (xform-&gt;cipher.key.length !=3D 16<br>
+#if IMB_VERSION(3, 0, 0) &gt; IMB_VERSION_NUM<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;&amp; xform-&gt;cipher.key.length !=3D=
 32<br>
+#endif<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IPSEC=
_MB_LOG(ERR, &quot;Invalid cipher key length&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
@@ -1177,19 +1182,23 @@ sgl_linear_cipher_auth_len(IMB_JOB *job, uint64_t *=
auth_len)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t cipher_len;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (job-&gt;cipher_mode =3D=3D IMB_CI=
PHER_SNOW3G_UEA2_BITLEN ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;cipher_m=
ode =3D=3D IMB_CIPHER_KASUMI_UEA1_BITLEN)<br>
+#if IMB_VERSION(3, 0, 0) &gt; IMB_VERSION_NUM<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (job-&gt;cipher_mode =3D=3D IMB_CI=
PHER_SNOW3G_UEA2 ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;cipher_m=
ode =3D=3D IMB_CIPHER_KASUMI_UEA1)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cipher_len =3D (job-&gt;msg_len_to_cipher_in_bits &gt=
;&gt; 3) +<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (job-&gt;cipher_start_src_offset=
_in_bits &gt;&gt; 3);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+#endif<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cipher_len =3D job-&gt;msg_len_to_cipher_in_bytes +<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;cipher_start_src_offset_=
in_bytes;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (job-&gt;hash_alg =3D=3D IMB_AUTH_=
SNOW3G_UIA2_BITLEN ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;hash_alg=
 =3D=3D IMB_AUTH_ZUC_EIA3_BITLEN)<br>
+#if IMB_VERSION(3, 0, 0) &gt; IMB_VERSION_NUM<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (job-&gt;hash_alg =3D=3D IMB_AUTH_=
SNOW3G_UIA2 ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;hash_alg=
 =3D=3D IMB_AUTH_ZUC_EIA3)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *auth_len =3D (job-&gt;msg_len_to_hash_in_bits &gt;&g=
t; 3) +<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;hash_start_src_offset_in=
_bytes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+#endif<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *auth_len =3D job-&gt;msg_len_to_hash_in_bytes +<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;hash_start_src_offset_in=
_bytes;<br>
&nbsp;<br>
@@ -1457,18 +1466,20 @@ aesni_mb_digest_appended_in_src(struct rte_crypto_o=
p *op, IMB_JOB *job,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return NULL;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (job-&gt;cipher_mode =
=3D=3D IMB_CIPHER_ZUC_EEA3 ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; job-&gt;cipher_mode =3D=3D IMB_CIPHER_SNOW3G_UEA2_BITLEN ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; job-&gt;cipher_mode =3D=3D IMB_CIPHER_KASUMI_UEA1_BITLEN) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; job-&gt;cipher_mode =3D=3D IMB_CIPHER_SNOW3G_UEA2 ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; job-&gt;cipher_mode =3D=3D IMB_CIPHER_KASUMI_UEA1) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cipher_size =3D (op-&gt;sym-&gt;cipher.data.offset &g=
t;&gt; 3) +<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (op-&=
gt;sym-&gt;cipher.data.length &gt;&gt; 3);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cipher_size =3D (op-&gt;sym-&gt;cipher.data.offset) +=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (op-&=
gt;sym-&gt;cipher.data.length);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (job-&gt;hash_alg =3D=3D IMB_AUTH_=
ZUC_EIA3_BITLEN ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; job-&gt;hash_alg =3D=3D IMB_AUTH_SNOW3G_UIA2_BITLEN ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; job-&gt;hash_alg =3D=3D IMB_AUTH_KASUMI_UIA1 ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; job-&gt;hash_alg =3D=3D IMB_AUTH_ZUC256_EIA3_BITLEN) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (job-&gt;hash_alg =3D=3D IMB_AUTH_=
ZUC_EIA3 ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; job-&gt;hash_alg =3D=3D IMB_AUTH_SNOW3G_UIA2 ||<br>
+#if IMB_VERSION(3, 0, 0) &gt; IMB_VERSION_NUM<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; job-&gt;hash_alg =3D=3D IMB_AUTH_ZUC256_EIA3 ||<br>
+#endif<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; job-&gt;hash_alg =3D=3D IMB_AUTH_KASUMI_UIA1) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; auth_size =3D (op-&gt;sym-&gt;auth.data.offset &gt;&g=
t; 3) +<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (op-&=
gt;sym-&gt;auth.data.length &gt;&gt; 3);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
@@ -1585,12 +1596,14 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp =
*qp,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; job-&gt;u.GMAC._iv =3D rte_crypto_op_ctod_offset(op, =
uint8_t *,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; session-&gt=
;auth_iv.offset);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IMB_AUTH_ZUC_EIA3_BITLEN:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IMB_AUTH_ZUC256_EIA3_BITLEN:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IMB_AUTH_ZUC_EIA3:<br>
+#if IMB_VERSION(3, 0, 0) &gt; IMB_VERSION_NUM<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IMB_AUTH_ZUC256_EIA3:<br>
+#endif<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; job-&gt;u.ZUC_EIA3._iv =3D rte_crypto_op_ctod_offset(=
op, uint8_t *,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; session-&gt=
;auth_iv.offset);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IMB_AUTH_SNOW3G_UIA2_BITLEN:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IMB_AUTH_SNOW3G_UIA2:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; job-&gt;u.SNOW3G_UIA2._iv =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_c=
rypto_op_ctod_offset(op, uint8_t *,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; session-&gt=
;auth_iv.offset);<br>
@@ -1616,12 +1629,19 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp =
*qp,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; m_offset =3D op-&gt;sym-&gt;cipher.data.offset;<br>
&nbsp;<br>
+#if IMB_VERSION(3, 0, 0) &gt; IMB_VERSION_NUM<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cipher_mode =3D=3D IMB=
_CIPHER_ZUC_EEA3)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; m_offset &gt;&gt;=3D 3;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (cipher_mode =3D=3D IMB_CIPHE=
R_SNOW3G_UEA2_BITLEN)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (cipher_mode =3D=3D IMB_CIPHE=
R_SNOW3G_UEA2)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; m_offset =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (cipher_mode =3D=3D IMB_CIPHE=
R_KASUMI_UEA1_BITLEN)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (cipher_mode =3D=3D IMB_CIPHE=
R_KASUMI_UEA1)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; m_offset =3D 0;<br>
+#else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cipher_mode =3D=3D IMB_CIPHER_ZUC=
_EEA3 ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; cipher_mode =3D=3D IMB_CIPHER_SNOW3G_UEA2 ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; cipher_mode =3D=3D IMB_CIPHER_KASUMI_UEA1)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; m_offset &gt;&gt;=3D 3;<br>
+#endif<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Set digest output locat=
ion */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (job-&gt;hash_alg !=3D =
IMB_AUTH_NULL &amp;&amp;<br>
@@ -1701,9 +1721,11 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp *=
qp,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; session-&gt;iv.offset);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* ZUC and SNOW3G require =
length in bits and offset in bytes */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IMB_AUTH_ZUC_EIA3_BITLEN:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IMB_AUTH_ZUC256_EIA3_BITLEN:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IMB_AUTH_SNOW3G_UIA2_BITLEN:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IMB_AUTH_ZUC_EIA3:<br>
+#if IMB_VERSION(3, 0, 0) &gt; IMB_VERSION_NUM<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IMB_AUTH_ZUC256_EIA3:<br>
+#endif<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IMB_AUTH_SNOW3G_UIA2:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; auth_off_in_bytes =3D op-&gt;sym-&gt;auth.data.offset=
 &gt;&gt; 3;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ciph_off_in_bytes =3D op-&gt;sym-&gt;cipher.data.offs=
et &gt;&gt; 3;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; auth_len_in_bytes =3D op-&gt;sym-&gt;auth.data.length=
 &gt;&gt; 3;<br>
@@ -1714,7 +1736,11 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp *=
qp,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; session, oop, auth_off_in_bytes,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ciph_off_in_bytes, auth_len_in_b=
ytes,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ciph_len_in_bytes, lb_sgl);<br>
+#if IMB_VERSION(3, 0, 0) &gt; IMB_VERSION_NUM<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; job-&gt;msg_len_to_hash_in_bits =3D op-&gt;sym-&gt;au=
th.data.length;<br>
+#else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; job-&gt;msg_len_to_hash_in_bytes =3D op-&gt;sym-&gt;auth.data.le=
ngth &gt;&gt; 3;<br>
+#endif<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; job-&gt;iv =3D rte_crypto_op_ctod_offset(op, uint8_t =
*,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sessi=
on-&gt;iv.offset);<br>
@@ -1772,12 +1798,19 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp =
*qp,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; op-&gt;sym-&gt;cipher.data.length &gt;&gt; 3;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* ZUC and SNOW3G require =
length and offset in bits */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IMB_CIPHER_SNOW3G_UEA2_BITLEN:<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IMB_CIPHER_KASUMI_UEA1_BITLEN:<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IMB_CIPHER_SNOW3G_UEA2:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IMB_CIPHER_KASUMI_UEA1:<br>
+#if IMB_VERSION(3, 0, 0) &gt; IMB_VERSION_NUM<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; job-&gt;cipher_start_src_offset_in_bits =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; op-&gt;sym-&gt;cipher.data.offset;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; job-&gt;msg_len_to_cipher_in_bits =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; op-&gt;sym-&gt;cipher.data.length;<br>
+#else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; job-&gt;cipher_start_src_offset_in_bytes =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; op-&gt;sym-&gt;cipher.data.offset &gt;&gt; 3;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; job-&gt;msg_len_to_cipher_in_bytes =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; op-&gt;sym-&gt;cipher.data.length &gt;&gt; 3;<br>
+#endif<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IMB_CIPHER_GCM:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; job-&gt;cipher_start_src_offset_in_bytes =3D<br>
@@ -2047,8 +2080,8 @@ post_process_mb_job(struct ipsec_mb_qp *qp, IMB_JOB *=
job)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aesni_mb_digest_appended_in_src(=
op, job, oop) !=3D NULL) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; unsigned int auth_size, cipher_size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; int unencrypted_bytes =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; if (job-&gt;cipher_mode =3D=3D IMB_CIPHER_SNOW3G_UEA2_BITLEN ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;cipher_mode =
=3D=3D IMB_CIPHER_KASUMI_UEA1_BITLEN ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; if (job-&gt;cipher_mode =3D=3D IMB_CIPHER_SNOW3G_UEA2 ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;cipher_mode =
=3D=3D IMB_CIPHER_KASUMI_UEA1 ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;cip=
her_mode =3D=3D IMB_CIPHER_ZUC_EEA3) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cipher_size=
 =3D (op-&gt;sym-&gt;cipher.data.offset &gt;&gt; 3) +<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (op-&gt;sym-&gt;cipher.data.length &gt=
;&gt; 3);<br>
@@ -2056,10 +2089,12 @@ post_process_mb_job(struct ipsec_mb_qp *qp, IMB_JOB=
 *job)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cipher_size=
 =3D (op-&gt;sym-&gt;cipher.data.offset) +<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (op-&gt;sym-&gt;cipher.data.length);<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; if (job-&gt;hash_alg =3D=3D IMB_AUTH_ZUC_EIA3_BITLEN ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;hash_alg =3D=
=3D IMB_AUTH_SNOW3G_UIA2_BITLEN ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;hash_alg =3D=
=3D IMB_AUTH_KASUMI_UIA1 ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;hash_alg =3D=
=3D IMB_AUTH_ZUC256_EIA3_BITLEN) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; if (job-&gt;hash_alg =3D=3D IMB_AUTH_ZUC_EIA3 ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;hash_alg =3D=
=3D IMB_AUTH_SNOW3G_UIA2 ||<br>
+#if IMB_VERSION(3, 0, 0) &gt; IMB_VERSION_NUM<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;hash_alg =3D=
=3D IMB_AUTH_ZUC256_EIA3 ||<br>
+#endif<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;hash_alg =3D=
=3D IMB_AUTH_KASUMI_UIA1) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; auth_size =
=3D (op-&gt;sym-&gt;auth.data.offset &gt;&gt; 3) +<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (op-&gt;sym-&gt;auth.data.length &gt;&=
gt; 3);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; } else {<br>
@@ -2550,7 +2585,9 @@ RTE_INIT(ipsec_mb_register_aesni_mb)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_C=
RYPTODEV_FF_SYM_OPERATION_CHAINING |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_C=
RYPTODEV_FF_OOP_LB_IN_LB_OUT |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_C=
RYPTODEV_FF_SYM_CPU_CRYPTO |<br>
+#if IMB_VERSION(3, 0, 0) &gt; IMB_VERSION_NUM<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_C=
RYPTODEV_FF_NON_BYTE_ALIGNED_DATA |<br>
+#endif<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_C=
RYPTODEV_FF_SYM_SESSIONLESS |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_C=
RYPTODEV_FF_IN_PLACE_SGL |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_C=
RYPTODEV_FF_OOP_SGL_IN_SGL_OUT |<br>
diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h b/drivers/crypto/i=
psec_mb/pmd_aesni_mb_priv.h<br>
index ad38a1e28a..6afda45414 100644<br>
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h<br>
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h<br>
@@ -19,6 +19,15 @@<br>
&nbsp;<br>
&nbsp;#define MAX_NUM_SEGS 16<br>
&nbsp;<br>
+/* bit len removed in 3.0 */<br>
+#if IMB_VERSION(3, 0, 0) &gt; IMB_VERSION_NUM<br>
+#define IMB_CIPHER_SNOW3G_UEA2 IMB_CIPHER_SNOW3G_UEA2_BITLEN<br>
+#define IMB_CIPHER_KASUMI_UEA1 IMB_CIPHER_KASUMI_UEA1_BITLEN<br>
+#define IMB_AUTH_ZUC_EIA3 IMB_AUTH_ZUC_EIA3_BITLEN<br>
+#define IMB_AUTH_SNOW3G_UIA2 IMB_AUTH_SNOW3G_UIA2_BITLEN<br>
+#define IMB_AUTH_ZUC256_EIA3 IMB_AUTH_ZUC256_EIA3_BITLEN<br>
+#endif<br>
+<br>
&nbsp;int<br>
&nbsp;aesni_mb_session_configure(IMB_MGR * m __rte_unused, void *priv_sess,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; const struct rte_crypto_sym_xform *xform);<br>
@@ -573,8 +582,13 @@ static const struct rte_cryptodev_capabilities aesni_m=
b_capabilities[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .block_size =3D 16,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .key_size =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .min =3D 16,<br>
+#if IMB_VERSION(3, 0, 0) &gt; IMB_VERSION_NUM<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .max =3D 32,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .increment =3D 16<br>
+#else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .max =3D 16,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .increment =3D 0<br>
+#endif<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .digest_size =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .min =3D 4,<br>
@@ -583,8 +597,13 @@ static const struct rte_cryptodev_capabilities aesni_m=
b_capabilities[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .iv_size =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .min =3D 16,<br>
+#if IMB_VERSION(3, 0, 0) &gt; IMB_VERSION_NUM<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .max =3D 25,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .increment =3D 9<br>
+#else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .max =3D 16,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .increment =3D 0<br>
+#endif<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }, }<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }, }<br>
@@ -598,13 +617,23 @@ static const struct rte_cryptodev_capabilities aesni_=
mb_capabilities[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .block_size =3D 16,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .key_size =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .min =3D 16,<br>
+#if IMB_VERSION(3, 0, 0) &gt; IMB_VERSION_NUM<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .max =3D 32,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .increment =3D 16<br>
+#else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .max =3D 16,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .increment =3D 0<br>
+#endif<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .iv_size =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .min =3D 16,<br>
+#if IMB_VERSION(3, 0, 0) &gt; IMB_VERSION_NUM<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .max =3D 25,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .increment =3D 9<br>
+#else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .max =3D 16,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .increment =3D 0<br>
+#endif<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }, }<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }, }<br>
@@ -888,9 +917,9 @@ static const unsigned int auth_blocksize[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; [IMB_AUTH_SHA_256]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 64,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; [IMB_AUTH_SHA_384]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 128,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; [IMB_AUTH_SHA_512]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 128,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; [IMB_AUTH_ZUC_EIA3_BITLEN]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 16,=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; [IMB_AUTH_SNOW3G_UIA2_BITLEN]&nbsp;&nbsp; =3D 16,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; [IMB_AUTH_KASUMI_UIA1]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; =3D 16<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; [IMB_AUTH_ZUC_EIA3]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 16,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; [IMB_AUTH_SNOW3G_UIA2]&nbsp; =3D 16,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; [IMB_AUTH_KASUMI_UIA1]&nbsp; =3D 16<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;/**<br>
@@ -922,9 +951,9 @@ static const unsigned int auth_truncated_digest_byte_le=
ngths[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; [IMB_AUTH_SHA_256]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 32,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; [IMB_AUTH_SHA_384]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 48,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; [IMB_AUTH_SHA_512]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 64,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; [IMB_AUTH_ZUC_EIA3_BITLEN]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 4,<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; [IMB_AUTH_SNOW3G_UIA2_BITLEN]&nbsp;&nbsp; =3D 4,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; [IMB_AUTH_KASUMI_UIA1]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; =3D 4<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; [IMB_AUTH_ZUC_EIA3]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 4,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; [IMB_AUTH_SNOW3G_UIA2]&nbsp; =3D 4,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; [IMB_AUTH_KASUMI_UIA1]&nbsp; =3D 4<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;/**<br>
@@ -957,9 +986,9 @@ static const unsigned int auth_digest_byte_lengths[] =
=3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; [IMB_AUTH_SHA_256]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 32,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; [IMB_AUTH_SHA_384]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 48,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; [IMB_AUTH_SHA_512]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 64,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; [IMB_AUTH_ZUC_EIA3_BITLEN]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 4,<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; [IMB_AUTH_SNOW3G_UIA2_BITLEN]&nbsp;&nbsp; =3D 4,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; [IMB_AUTH_KASUMI_UIA1]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; =3D 4,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; [IMB_AUTH_ZUC_EIA3]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 4,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; [IMB_AUTH_SNOW3G_UIA2]&nbsp; =3D 4,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; [IMB_AUTH_KASUMI_UIA1]&nbsp; =3D 4,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; [IMB_AUTH_SM3]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 32,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; [IMB_AUTH_HMAC_SM3]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 32,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**&lt; Vector mode depend=
ent pointer table of the multi-buffer APIs */<br>
-- <br>
2.52.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_LV2PR11MB6045F1A0465FAB19E5A7358F81952LV2PR11MB6045namp_--
