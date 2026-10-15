Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1DECC6B33
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 14:45:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 46AE240DD1;
	Thu, 15 Oct 2026 16:45:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 3275E4064C
 for <dev@dpdk.org>; Thu, 15 Oct 2026 16:44:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792075499; x=1823611499;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=esclM+ae8nkwGNG0zFvFTprNekxVm/hDhUy18fVUa10=;
 b=V0bKBQeD+aF5KmvwdKeTguXcNhe+DDrKlYEbOb/bGCK0HneKf0MDFqbh
 sykDGNI8EWfvOMxgPNpl66VOdjpuljc321SG6V0bPszYfhde0iYuUfzMG
 r8bXd2fxL8HOeNvUVKOsUozptmtmN2LQP5BvoN641Y/HKAcs0HTSLxmFU
 TUACk9RlubLHawoeIcYx3qfGWg+duKiRq9IDrp6/PMbhFB9Ak+DR68IQ9
 qLBPxOk4RGG0VZwOK281jcrcCYwK/j8k7obSINGumcfBq/hl9RAPK8a/F
 ppzs0Yn6SVm9hMe/UuHECl6ChnuxjPe1x0amXAWMO2ky12VpRuvl7vseD Q==;
X-CSE-ConnectionGUID: HjhwRFjsQvii9miwwmAdUA==
X-CSE-MsgGUID: ihV2iMB6QmSpQIbgmXKKGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="950110"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; d="scan'208,217";a="950110"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 07:44:58 -0700
X-CSE-ConnectionGUID: K4rPz89lQa2kyzFFJOJNKQ==
X-CSE-MsgGUID: Rr2Iwmh5TuS9wtPChqFY1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; d="scan'208,217";a="1782843"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 07:44:57 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 07:44:57 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 07:44:57 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.64) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 07:44:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LZfxhmh5smsXQ8ZAqf2r81Ixf5x4Xncgl+XATl3Sfuq4L82U6fw+BiAphCmpn3VVCvmyF6vdntQhFVqz6os7Wa84/HrYGQYdL9wG7WVQyFsChgqmVc+Yto6fMna9Sl4gZoZDb/yhDDmoS8ARsMvwKdGyCV/W1rLRfU+JIpgnll5W8z0sxIcObJig5xAQEAuPN3My3YRy1t96PRY9uiz3SdUdTPayEdtaMaLcN4GGrbBBZROTdg8BPSyOhccm23BE0VajTtIC0V4FGveZ/dZND/UaStmJICVGEr4VeNILv3r86KEaMunAb/mfhiTAIJcHREdzC0XeLp6/lnz8w4CyJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C669X0VS4apq6DjSTo2SXRb5gd+EwsrZcpMUA3N5qXM=;
 b=SvX2q6JQEodifhiCqOvSMnUbOesSg2gt7z05xhNjWoHU7/C/D894dQrE9EJqV643JNjnrWLAJh0k5kTIv/o2MLMSV2ywrOsUQVTN+ULALypqQdVbs+th83hjKtcY4N9BBDJ4LAhxqDLX2r9YlB4/T8heuI+4Q795AC2KZ2Quz3i/I2lCPmNlQ+HuCrekFUrTNwse7liijvqn7ZKA4IsgCMiZ4WO0mxl09PXnUUPcei/8Rzxw0Rc4K12HrxljU1xLPz5q1w1JIsOFw1mfpCx8iTqhT4hiUKPZFR4x/00ucCbA2NpyL2ELNzjoyVOc0yF6rZnI6dVJitqwExu8ckX9bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB6045.namprd11.prod.outlook.com (2603:10b6:408:17b::20)
 by SJ0PR11MB4958.namprd11.prod.outlook.com (2603:10b6:a03:2ae::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Thu, 15 Oct
 2026 14:44:48 +0000
Received: from LV2PR11MB6045.namprd11.prod.outlook.com
 ([fe80::1f72:3d49:b6ba:91ae]) by LV2PR11MB6045.namprd11.prod.outlook.com
 ([fe80::1f72:3d49:b6ba:91ae%6]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 14:44:48 +0000
From: "Ji, Kai" <kai.ji@intel.com>
To: "Finn, Emma" <emma.finn@intel.com>, "De Lara Guarch, Pablo"
 <pablo.de.lara.guarch@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH v3 2/2] crypto/ipsec_mb: Add SHAKE support.
Thread-Topic: [PATCH v3 2/2] crypto/ipsec_mb: Add SHAKE support.
Thread-Index: AQHdWvXokpl11jdLPU+YRZW07yGLHrb+sXma
Date: Thu, 15 Oct 2026 14:44:48 +0000
Message-ID: <LV2PR11MB604551C0B9431E99C1CDEBC4819C2@LV2PR11MB6045.namprd11.prod.outlook.com>
References: <20261012083506.754857-2-emma.finn@intel.com>
 <20261013093312.817235-1-emma.finn@intel.com>
 <20261013093312.817235-3-emma.finn@intel.com>
In-Reply-To: <20261013093312.817235-3-emma.finn@intel.com>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6045:EE_|SJ0PR11MB4958:EE_
x-ms-office365-filtering-correlation-id: 73ec776b-1cbe-442b-0897-08df2acadcab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|42112799006|366016|10070799003|376014|23010399003|6133799003|18002099003|8096899003|3023799007|10067099003|22082099003|4143699003|11063799006|261009223027099003|56012099006|38070700021;
x-microsoft-antispam-message-info: Q7rmUtrcuEezwPKkHP7QDfxnlnNNnOsclK1s6EFy4VkVZ+YLAfMesRxxY0/Dmpt3rnxQe1yVZDnL1B29k/XkJC0rrbqfUjfVG4ZBqkmuA0IxKuwmezTGQ2I2a7tWsLK9dUUXWYBtTPq9trvTyXiANty5rvmi5XY9hMl95lLsYDMymXouQ/pTBUNNuuWfjtq8UDGX80uF9qxDG7WZqcB6Z4YC5EwyLB6HgvcdVH55lKkawWmLGZ4uVAz16RF3UxNQXm7TW/oVb+nSCN35h0R3+KVRPE4qsNk+xMdPCAWjhp+z4XcwSCzsfnqwDtgzNsdP5oh+o9wuBcLWoWV/Bc0qOsnbNbvj7D+IDG5aEKCrxhEuZYTfgHuSZbYTUtm4o7tjnqvbgN7dC3MZfF5PZxqUCRWjkRNA1IKM7Higas+bFr3ZPm+f65S1veCsPO1htIwcvLo1SqhWRTve8Jy0wykXcw5Uoz2HkD8Lp3lwvU7vSFooDpJCu/Pd14G4d4TjFu+htKdCzOl4TOcOM6Y+MVnVtXl7LCo1Zp2XfkTbreqE6mIYYp6Ks2KpKG4QjJ4BvuW2S82W7aCbB+xrdLqSZdvQ41RJlJX2uSqpS/5LXiAsYOvQrsdIDoOBIJQyBPdXv2L/aRtXqT/eYa6iEem3n9d0NCQpbEBPAyRBGAoEf+VnU4gpnueEhCFZjQV6scLxWfWawy1Yg7hEHsFZ9jydYiCUxC8ZkUXyPU53Ewc4WOlfhhA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB6045.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(42112799006)(366016)(10070799003)(376014)(23010399003)(6133799003)(18002099003)(8096899003)(3023799007)(10067099003)(22082099003)(4143699003)(11063799006)(261009223027099003)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QX2Y3v7P7RkdZLF0bN5SWUg62URYIKYRRoiqIDMXppIKkkdIXDOJoHwCrJLE?=
 =?us-ascii?Q?RWqjpN2vCvM983x1L4kset6KTrP+3jf1+HRbxKbTlLOjTP2HDv+glMTG+Jz9?=
 =?us-ascii?Q?jFyY+hNNog5HsMjoUBZYTpEhgxdFOAkZVpheO7oF8ZFUVg+UHGR9+J9u9mZC?=
 =?us-ascii?Q?OH1EqyX66fYdT+rCFwHZ5NfMYReH+Bvj1xVDADWsaSLiEzuhmNkKM9laOpXB?=
 =?us-ascii?Q?g0mIMFkY4aFS7HbaN6gUPvjyGbU5F0Nx6I7qFPUSLmHYx634s6FDrl9atWrg?=
 =?us-ascii?Q?t/UvddbjXjdKARUiYqDPp0FkAtCi4dsMwnvoAHYuCjqUOLMLJaXavTbaMtyo?=
 =?us-ascii?Q?oW/zw8QnEeicqA81t1sT1X8jehZs23kkmpmet9lDEySjFz37UtomyHQuGbEM?=
 =?us-ascii?Q?Eyx3OK1HkWOLe3s8/v5YtkvsogFA8Qc4OFgCiYBIhTHZiPSi4lsm4AJrYovF?=
 =?us-ascii?Q?fkNXZIpPw1LMtKCvJ40IuawA0hMp6t4eAdkKhBUhL5wLiX2l9EEST04DbGgM?=
 =?us-ascii?Q?Apg39IubzGbuR5ut9bVTIQ911doObwnVVKf62aTJXO9gylvaGo5r/8BQmnIA?=
 =?us-ascii?Q?TvfcyCqfeOJ7DoxlYaZ3IwPivYzNfdOBUpeNxB+H5eFnzGoyboTscWTKzak/?=
 =?us-ascii?Q?Che7f5G0KpID+mCoyRNwTrV0yQdbEB9CtSznOlgGQwUfEosghk/y75nXennH?=
 =?us-ascii?Q?1xxL2MmPXKQtoZjaaq/0V443sC82UFT5751fkkFBtm8SeBbyTCkld7F+mEQa?=
 =?us-ascii?Q?OIBf5oEVzPg3pVzRRDglQ0u6KtkmwAaD7H0I8jBI/yUB9pbwSAUWGfPkeIC5?=
 =?us-ascii?Q?66CCgOfxaTxYxQFpt2c/XPUu640ekowXzgTijP4i+/TJdAwat1SZlqNEAhNL?=
 =?us-ascii?Q?BVbtzn1vSrZ21veLAPXdcT52hxO35FJLgBV3BjYyPgbeGKmAlJTPqGGViwbu?=
 =?us-ascii?Q?Qbzxi5MeTpwwHzlJULs7XO0QMJLgkVp7Y08iq5/ATT3pzFbk5+2kk8UCKUFl?=
 =?us-ascii?Q?W8pDKH0/qIG8As6eR5I1ztMWHi/R/9eNQaEDVuduPS+s0UZZ8oFurB+KCMtm?=
 =?us-ascii?Q?gFEQMjmbzejwSFjBklSEgfj4OIlz58XNpw+VdybP0tlH5gQH3WD/KYiV5wRT?=
 =?us-ascii?Q?d99H3ruU7nGJ3uanu4u3ZhHL0LZpfr6/uWevsOJsePqe8vQt0y3fp49vtj8c?=
 =?us-ascii?Q?p1H5tOkn7DU0vz6iOaMWFLPZnuBaniKYr/7YcVDtVrvb/3yqcQZy/LCfVXPO?=
 =?us-ascii?Q?Nd0zJ+dz4ju04mpi4RMyrrMDry4T2MkMoCuqMbwZrohFwGQjigRX5Zglqs1L?=
 =?us-ascii?Q?SaCq0lfg4eLPAGVGFUAoMIVL+HeUhf5PxzzBoLBxY/8V+gvC6PS10643bUFA?=
 =?us-ascii?Q?DDbKoQMWDsATZZINMn95z3dgNt8xZf126050NPAjckoFgvr5Zc3tLMrumXUV?=
 =?us-ascii?Q?4x7ZYnZm7/Ac0bgP/AZ/PlHqxgp5Nd1FPc0xfP3kzinolgvkZLw70QxC0QIa?=
 =?us-ascii?Q?cF83aqVGK7Mkss9ctllsDpQKaUMSp55Qe86z0FeTy5+O3OFPu08qEqRxoQOe?=
 =?us-ascii?Q?Ct0W7PRN1EnsVOdpoCKUpmigWnGGkCn7jv7Kk4BQnGDqJNa2QjUa+YWga/Ai?=
 =?us-ascii?Q?CMK0Fg7DeUSu248yUe7WP4Y2xUuNx7FhB1pnkcH8akGal4xLtaBaljJJzQMU?=
 =?us-ascii?Q?JgaDguyovTJbtWELFs2uQx+XTk4fZE0NvI/17Uep7P+foWQxn1KbtR1L+8d6?=
 =?us-ascii?Q?JiaWDI49ORHiIFxBP+r95b0QJxb47EQpPfGbgp1Tc3G6CzuCPEbu?=
Content-Type: multipart/alternative;
 boundary="_000_LV2PR11MB604551C0B9431E99C1CDEBC4819C2LV2PR11MB6045namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MtfIDOIEK9hO70Bn4B1ysg5AYhjn6OVvNUiWhaset6XL5oBRPCkrBiR4B+7lTiJFvbvCDBfs+lXCrNhWXpJspAyTdlX+cIJyzvQNSJr1DcabT5us/4Ld/7a701wiUABXgphg+0saxBma2ZekY0XxRH7j1snqa1qnV5s+dTAV2B4/dfvpKr2fQADdf4w1bsp95POH9GuHzqOOBeGxxhiM6zocmQ5MJmh/2JdQiBI0sfcwNBWTEfP0uOnQMwnUz9strMKOFYQdzoHbtuRueYTwlyJ6C/8aemFjFy3rqqPBnrv5GBHQHfebEvnYWzcO8B9saLnSpHMVMCjHkyrVefQbpA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6045.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ec776b-1cbe-442b-0897-08df2acadcab
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 14:44:48.3696 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +TiLPScJCCitBTASJqElu6LEtRfYrj5G0Sh+oHC4aCr9b2sxU6G62noMt37qFu+uc9wXHC5pCdNG6c5PtVFSIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4958
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

--_000_LV2PR11MB604551C0B9431E99C1CDEBC4819C2LV2PR11MB6045namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Kai Ji <kai.ji@intel.com>

________________________________
From: Finn, Emma <emma.finn@intel.com>
Sent: 13 October 2026 10:33
To: Ji, Kai <kai.ji@intel.com>; De Lara Guarch, Pablo <pablo.de.lara.guarch=
@intel.com>
Cc: dev@dpdk.org <dev@dpdk.org>; Finn, Emma <emma.finn@intel.com>
Subject: [PATCH v3 2/2] crypto/ipsec_mb: Add SHAKE support.

Add SHAKE-128 and SHAKE-256 support to
ipsec_mb PMD.

Signed-off-by: Emma Finn <emma.finn@intel.com>
---
 doc/guides/cryptodevs/aesni_mb.rst          |  2 +
 doc/guides/cryptodevs/features/aesni_mb.ini |  2 +
 doc/guides/rel_notes/release_26_11.rst      |  1 +
 drivers/crypto/ipsec_mb/pmd_aesni_mb.c      |  8 +++
 drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h | 54 +++++++++++++++++++--
 5 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/doc/guides/cryptodevs/aesni_mb.rst b/doc/guides/cryptodevs/aes=
ni_mb.rst
index 663b9f19d4b..da37d54471e 100644
--- a/doc/guides/cryptodevs/aesni_mb.rst
+++ b/doc/guides/cryptodevs/aesni_mb.rst
@@ -69,6 +69,8 @@ Hash algorithms:
 * RTE_CRYPTO_AUTH_SHA3_384 HMAC
 * RTE_CRYPTO_AUTH_SHA3_512
 * RTE_CRYPTO_AUTH_SHA3_512 HMAC
+* RTE_CRYPTO_AUTH_SHAKE_128
+* RTE_CRYPTO_AUTH_SHAKE_256

 AEAD algorithms:

diff --git a/doc/guides/cryptodevs/features/aesni_mb.ini b/doc/guides/crypt=
odevs/features/aesni_mb.ini
index 73bb9f42633..18109ffe05d 100644
--- a/doc/guides/cryptodevs/features/aesni_mb.ini
+++ b/doc/guides/cryptodevs/features/aesni_mb.ini
@@ -77,6 +77,8 @@ SHA3_384     =3D Y
 SHA3_384 HMAC =3D Y
 SHA3_512     =3D Y
 SHA3_512 HMAC =3D Y
+SHAKE_128    =3D Y
+SHAKE_256    =3D Y

 ;
 ; Supported AEAD algorithms of the 'aesni_mb' crypto driver.
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/=
release_26_11.rst
index 826a0cf05cf..c116f3373da 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -28,6 +28,7 @@ New Features

   * Added support for SHA3-224, SHA3-256, SHA3-384, and SHA3-512 hash
     algorithms and their HMAC variants.
+  * Added support for SHAKE-128 and SHAKE-256 hash algorithms.

 .. This section should contain new features added in this release.
    Sample format:
diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c b/drivers/crypto/ipsec_=
mb/pmd_aesni_mb.c
index c96d1453b8c..adfc39b9569 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
@@ -332,6 +332,14 @@ aesni_mb_set_session_auth_parameters(IMB_MGR *mb_mgr,
         case RTE_CRYPTO_AUTH_SHA3_512_HMAC:
                 sess->template_job.hash_alg =3D IMB_AUTH_HMAC_SHA3_512;
                 break;
+       case RTE_CRYPTO_AUTH_SHAKE_128:
+               sess->template_job.hash_alg =3D IMB_AUTH_SHAKE128;
+               auth_precompute =3D 0;
+               break;
+       case RTE_CRYPTO_AUTH_SHAKE_256:
+               sess->template_job.hash_alg =3D IMB_AUTH_SHAKE256;
+               auth_precompute =3D 0;
+               break;
 #endif
         default:
                 IPSEC_MB_LOG(ERR,
diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h b/drivers/crypto/i=
psec_mb/pmd_aesni_mb_priv.h
index aad31b9f909..74accab99a1 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h
@@ -937,6 +937,48 @@ static const struct rte_cryptodev_capabilities aesni_m=
b_capabilities[] =3D {
                         }, }
                 }, }
         },
+       {       /* SHAKE-128 */
+               .op =3D RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+               {.sym =3D {
+                       .xform_type =3D RTE_CRYPTO_SYM_XFORM_AUTH,
+                       {.auth =3D {
+                               .algo =3D RTE_CRYPTO_AUTH_SHAKE_128,
+                               .block_size =3D 168,
+                               .key_size =3D {
+                                       .min =3D 0,
+                                       .max =3D 0,
+                                       .increment =3D 0
+                               },
+                               .digest_size =3D {
+                                       .min =3D 1,
+                                       .max =3D 64,
+                                       .increment =3D 1
+                               },
+                               .iv_size =3D { 0 }
+                       }, }
+               }, }
+       },
+       {       /* SHAKE-256 */
+               .op =3D RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+               {.sym =3D {
+                       .xform_type =3D RTE_CRYPTO_SYM_XFORM_AUTH,
+                       {.auth =3D {
+                               .algo =3D RTE_CRYPTO_AUTH_SHAKE_256,
+                               .block_size =3D 136,
+                               .key_size =3D {
+                                       .min =3D 0,
+                                       .max =3D 0,
+                                       .increment =3D 0
+                               },
+                               .digest_size =3D {
+                                       .min =3D 1,
+                                       .max =3D 64,
+                                       .increment =3D 1
+                               },
+                               .iv_size =3D { 0 }
+                       }, }
+               }, }
+       },
 #endif
         {       /* SM4 CBC */
                 .op =3D RTE_CRYPTO_OP_TYPE_SYMMETRIC,
@@ -1073,7 +1115,9 @@ static const unsigned int auth_blocksize[] =3D {
                 [IMB_AUTH_HMAC_SHA3_224]        =3D 144,
                 [IMB_AUTH_HMAC_SHA3_256]        =3D 136,
                 [IMB_AUTH_HMAC_SHA3_384]        =3D 104,
-               [IMB_AUTH_HMAC_SHA3_512]        =3D 72
+               [IMB_AUTH_HMAC_SHA3_512]        =3D 72,
+               [IMB_AUTH_SHAKE128]             =3D 168,
+               [IMB_AUTH_SHAKE256]             =3D 136
 #endif
 };

@@ -1117,7 +1161,9 @@ static const unsigned int auth_truncated_digest_byte_=
lengths[] =3D {
                 [IMB_AUTH_HMAC_SHA3_224]        =3D 28,
                 [IMB_AUTH_HMAC_SHA3_256]        =3D 32,
                 [IMB_AUTH_HMAC_SHA3_384]        =3D 48,
-               [IMB_AUTH_HMAC_SHA3_512]        =3D 64
+               [IMB_AUTH_HMAC_SHA3_512]        =3D 64,
+               [IMB_AUTH_SHAKE128]             =3D 64,
+               [IMB_AUTH_SHAKE256]             =3D 64
 #endif
 };

@@ -1166,7 +1212,9 @@ static const unsigned int auth_digest_byte_lengths[] =
=3D {
                 [IMB_AUTH_HMAC_SHA3_224]        =3D 28,
                 [IMB_AUTH_HMAC_SHA3_256]        =3D 32,
                 [IMB_AUTH_HMAC_SHA3_384]        =3D 48,
-               [IMB_AUTH_HMAC_SHA3_512]        =3D 64
+               [IMB_AUTH_HMAC_SHA3_512]        =3D 64,
+               [IMB_AUTH_SHAKE128]             =3D 64,
+               [IMB_AUTH_SHAKE256]             =3D 64
 #endif
         /**< Vector mode dependent pointer table of the multi-buffer APIs =
*/

--
2.43.0


--_000_LV2PR11MB604551C0B9431E99C1CDEBC4819C2LV2PR11MB6045namp_
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
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Finn, Emma &lt;emma.f=
inn@intel.com&gt;<br>
<b>Sent:</b> 13 October 2026 10:33<br>
<b>To:</b> Ji, Kai &lt;kai.ji@intel.com&gt;; De Lara Guarch, Pablo &lt;pabl=
o.de.lara.guarch@intel.com&gt;<br>
<b>Cc:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;; Finn, Emma &lt;emma.finn@inte=
l.com&gt;<br>
<b>Subject:</b> [PATCH v3 2/2] crypto/ipsec_mb: Add SHAKE support.</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Add SHAKE-128 and SHAKE-256 support to<br>
ipsec_mb PMD.<br>
<br>
Signed-off-by: Emma Finn &lt;emma.finn@intel.com&gt;<br>
---<br>
&nbsp;doc/guides/cryptodevs/aesni_mb.rst&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; |&nbsp; 2 +<br>
&nbsp;doc/guides/cryptodevs/features/aesni_mb.ini |&nbsp; 2 +<br>
&nbsp;doc/guides/rel_notes/release_26_11.rst&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
|&nbsp; 1 +<br>
&nbsp;drivers/crypto/ipsec_mb/pmd_aesni_mb.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
|&nbsp; 8 +++<br>
&nbsp;drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h | 54 +++++++++++++++++++-=
-<br>
&nbsp;5 files changed, 64 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/doc/guides/cryptodevs/aesni_mb.rst b/doc/guides/cryptodevs/aes=
ni_mb.rst<br>
index 663b9f19d4b..da37d54471e 100644<br>
--- a/doc/guides/cryptodevs/aesni_mb.rst<br>
+++ b/doc/guides/cryptodevs/aesni_mb.rst<br>
@@ -69,6 +69,8 @@ Hash algorithms:<br>
&nbsp;* RTE_CRYPTO_AUTH_SHA3_384 HMAC<br>
&nbsp;* RTE_CRYPTO_AUTH_SHA3_512<br>
&nbsp;* RTE_CRYPTO_AUTH_SHA3_512 HMAC<br>
+* RTE_CRYPTO_AUTH_SHAKE_128<br>
+* RTE_CRYPTO_AUTH_SHAKE_256<br>
&nbsp;<br>
&nbsp;AEAD algorithms:<br>
&nbsp;<br>
diff --git a/doc/guides/cryptodevs/features/aesni_mb.ini b/doc/guides/crypt=
odevs/features/aesni_mb.ini<br>
index 73bb9f42633..18109ffe05d 100644<br>
--- a/doc/guides/cryptodevs/features/aesni_mb.ini<br>
+++ b/doc/guides/cryptodevs/features/aesni_mb.ini<br>
@@ -77,6 +77,8 @@ SHA3_384&nbsp;&nbsp;&nbsp;&nbsp; =3D Y<br>
&nbsp;SHA3_384 HMAC =3D Y<br>
&nbsp;SHA3_512&nbsp;&nbsp;&nbsp;&nbsp; =3D Y<br>
&nbsp;SHA3_512 HMAC =3D Y<br>
+SHAKE_128&nbsp;&nbsp;&nbsp; =3D Y<br>
+SHAKE_256&nbsp;&nbsp;&nbsp; =3D Y<br>
&nbsp;<br>
&nbsp;;<br>
&nbsp;; Supported AEAD algorithms of the 'aesni_mb' crypto driver.<br>
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/=
release_26_11.rst<br>
index 826a0cf05cf..c116f3373da 100644<br>
--- a/doc/guides/rel_notes/release_26_11.rst<br>
+++ b/doc/guides/rel_notes/release_26_11.rst<br>
@@ -28,6 +28,7 @@ New Features<br>
&nbsp;<br>
&nbsp;&nbsp; * Added support for SHA3-224, SHA3-256, SHA3-384, and SHA3-512=
 hash<br>
&nbsp;&nbsp;&nbsp;&nbsp; algorithms and their HMAC variants.<br>
+&nbsp; * Added support for SHAKE-128 and SHAKE-256 hash algorithms.<br>
&nbsp;<br>
&nbsp;.. This section should contain new features added in this release.<br=
>
&nbsp;&nbsp;&nbsp; Sample format:<br>
diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c b/drivers/crypto/ipsec_=
mb/pmd_aesni_mb.c<br>
index c96d1453b8c..adfc39b9569 100644<br>
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c<br>
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c<br>
@@ -332,6 +332,14 @@ aesni_mb_set_session_auth_parameters(IMB_MGR *mb_mgr,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RTE_CRYPTO_AUTH_SHA3_=
512_HMAC:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; sess-&gt;template_job.hash_alg =3D IMB_AUTH_HMAC_SHA3=
_512;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RTE_CRYPTO_AUTH_SHAKE_128:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; sess-&gt;template_job.hash_alg =3D IMB_AUTH_SHAKE128;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; auth_precompute =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RTE_CRYPTO_AUTH_SHAKE_256:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; sess-&gt;template_job.hash_alg =3D IMB_AUTH_SHAKE256;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; auth_precompute =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
&nbsp;#endif<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; IPSEC_MB_LOG(ERR,<br>
diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h b/drivers/crypto/i=
psec_mb/pmd_aesni_mb_priv.h<br>
index aad31b9f909..74accab99a1 100644<br>
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h<br>
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h<br>
@@ -937,6 +937,48 @@ static const struct rte_cryptodev_capabilities aesni_m=
b_capabilities[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }, }<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }, }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 /* SHAKE-128 */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .op =3D RTE_CRYPTO_OP_TYPE_SYMMETRIC,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; {.sym =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .xform_type =3D =
RTE_CRYPTO_SYM_XFORM_AUTH,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {.auth =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .algo =3D RTE_CRYPTO_AUTH_SHAKE_128,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .block_size =3D 168,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .key_size =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .min =3D 0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .max =3D 0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .increment =3D 0<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .digest_size =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .min =3D 1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .max =3D 64,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .increment =3D 1<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .iv_size =3D { 0 }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }, }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }, }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 /* SHAKE-256 */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .op =3D RTE_CRYPTO_OP_TYPE_SYMMETRIC,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; {.sym =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .xform_type =3D =
RTE_CRYPTO_SYM_XFORM_AUTH,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {.auth =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .algo =3D RTE_CRYPTO_AUTH_SHAKE_256,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .block_size =3D 136,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .key_size =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .min =3D 0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .max =3D 0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .increment =3D 0<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .digest_size =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .min =3D 1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .max =3D 64,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .increment =3D 1<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .iv_size =3D { 0 }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }, }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }, }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
&nbsp;#endif<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* SM4 CBC */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .op =3D RTE_CRYPTO_OP_TYPE_SYMMETRIC,<br>
@@ -1073,7 +1115,9 @@ static const unsigned int auth_blocksize[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; [IMB_AUTH_HMAC_SHA3_224]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; =3D 144,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; [IMB_AUTH_HMAC_SHA3_256]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; =3D 136,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; [IMB_AUTH_HMAC_SHA3_384]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; =3D 104,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; [IMB_AUTH_HMAC_SHA3_512]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; =3D 72<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; [IMB_AUTH_HMAC_SHA3_512]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; =3D 72,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; [IMB_AUTH_SHAKE128]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 168,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; [IMB_AUTH_SHAKE256]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 136<br>
&nbsp;#endif<br>
&nbsp;};<br>
&nbsp;<br>
@@ -1117,7 +1161,9 @@ static const unsigned int auth_truncated_digest_byte_=
lengths[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; [IMB_AUTH_HMAC_SHA3_224]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; =3D 28,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; [IMB_AUTH_HMAC_SHA3_256]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; =3D 32,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; [IMB_AUTH_HMAC_SHA3_384]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; =3D 48,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; [IMB_AUTH_HMAC_SHA3_512]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; =3D 64<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; [IMB_AUTH_HMAC_SHA3_512]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; =3D 64,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; [IMB_AUTH_SHAKE128]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 64,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; [IMB_AUTH_SHAKE256]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 64<br>
&nbsp;#endif<br>
&nbsp;};<br>
&nbsp;<br>
@@ -1166,7 +1212,9 @@ static const unsigned int auth_digest_byte_lengths[] =
=3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; [IMB_AUTH_HMAC_SHA3_224]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; =3D 28,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; [IMB_AUTH_HMAC_SHA3_256]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; =3D 32,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; [IMB_AUTH_HMAC_SHA3_384]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; =3D 48,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; [IMB_AUTH_HMAC_SHA3_512]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; =3D 64<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; [IMB_AUTH_HMAC_SHA3_512]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; =3D 64,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; [IMB_AUTH_SHAKE128]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 64,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; [IMB_AUTH_SHAKE256]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 64<br>
&nbsp;#endif<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**&lt; Vector mode depend=
ent pointer table of the multi-buffer APIs */<br>
&nbsp;<br>
-- <br>
2.43.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_LV2PR11MB604551C0B9431E99C1CDEBC4819C2LV2PR11MB6045namp_--
