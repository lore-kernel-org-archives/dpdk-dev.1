Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5913CA600D
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 17:31:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B3FC540294;
	Thu,  8 Oct 2026 19:31:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 5041040284
 for <dev@dpdk.org>; Thu,  8 Oct 2026 19:31:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791480669; x=1823016669;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=SFTyCq+bjBjirJVjEU9Bdbl5DporS0AKUDqx9ETfLXs=;
 b=emaI4UmQVZavzweLhbeBjh6BRtte6Fw+wgcJB1Ns9fdBLySGGKZ1UCh2
 EzJUo6ZjlbPLrgQcT0IImsZdsADFH3lsmTcKWCvHILr1nkMRtWDln+5DH
 9+03TJl17z2Q70wLCg1RFDYLSlaG6uZGqQkUe+0kGuAWUqFWkzc1lL0mZ
 mxhE+eBy4gZMY5tFtFhS4oo/SCA2D4+gVi3lBnNpxxwasYAvI21Av9W5r
 Y60LyvkMWCupDt3XsqybHardhSDBvqww4PWpH3GxB/fO24AI+hA7XJiqB
 LRUQ9hQF49gc5gb2SdEgWjtY7uNSnOb6x0UxPPJEC1kC9YJ6iuWYAF43M g==;
X-CSE-ConnectionGUID: T4usnYkpQVyIcSQv/uP1Yg==
X-CSE-MsgGUID: 0VncD9+vRomp/RMHc7Vg1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="282414"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="282414"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 10:31:08 -0700
X-CSE-ConnectionGUID: clKWZaBvSR6NQn/LltMFmw==
X-CSE-MsgGUID: ypwTzh7HSsiBB9GDLyx+tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="1857914"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 10:31:08 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 10:31:08 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 10:31:08 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.5) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 10:31:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LoecS8ZBOapDtjk/z/J0AaClc0tbnPdsroonUPN8n3qQRIBQfbX94yr8NCNwbYnWOpm92oph/bvPrhhFJc1wgfwlzU89V0OXcrvmuW5EjLoqtCbbQOT09WLZMEzi24s+Rk0QoMm7jwzGQdjCuMiE9DPg+Dfkxs3co6qNaCjwbzMTeeOKJUKZwoqjRv4NNW1MnYZCzkEsjTm1HFVEKLobAxzHevazKy2btUCkqreSeOeXPY6xk1KJ7TdKhBQU88FtakdbsFe2nVcGxzrhfWNfW53CCg6ilGZgVs4Vu76Vna2N+ZMAAJK7Ms24NOT8kXTmIGzkSYYQyN87+L479RBhvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFTyCq+bjBjirJVjEU9Bdbl5DporS0AKUDqx9ETfLXs=;
 b=uZNpk1TBc0SNLUpL/TAU6+e5K2IojAkSg+FoFhQAKzPzgeOCAQcw6zjpYUMegSFcmOKxiXqALZXS5qLxV3t6Lq9HHu897ixrjG7txU1U84xIwjtGprxTQhdj8AnR0yHkx9vFuZig+L9KF/8KfTiOQAqj8OUhUSZePYm6j0Gx/ZyTgqyMDd7k7gDxRarzGnMpIfMpNFpD3qdGzp+Mr0LWkcD3ITzN1Hzcnd4BqwjrBRtZbjerqumQxU2TPhGeyUD++Givxw0BM9IXNbDcoZltgoEsCxAqtrTcvDMfB6xEQwGYFUxJJB7ugn+ZXmrElBMVSdYgOf9TeDwdblp+l1X84A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB379463.namprd11.prod.outlook.com
 (2603:10b6:408:3b3::21) by DS4PPFBA72E12AE.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 17:31:05 +0000
Received: from LV2PR11MB379463.namprd11.prod.outlook.com
 ([fe80::f034:dc57:3874:5e8c]) by LV2PR11MB379463.namprd11.prod.outlook.com
 ([fe80::f034:dc57:3874:5e8c%6]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 17:31:05 +0000
From: "Penigalapati, Sandeep" <sandeep.penigalapati@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH] net/ice: support Rx timestamp offload on vector path
Thread-Topic: [PATCH] net/ice: support Rx timestamp offload on vector path
Thread-Index: AQHdR3ZOtx5+CrKCnkuybg2vke2aFrbzpMmAgABgWxA=
Date: Thu, 8 Oct 2026 17:31:05 +0000
Message-ID: <LV2PR11MB37946381469C9240A9218BE1649C932@LV2PR11MB379463.namprd11.prod.outlook.com>
References: <20260918210352.303512-1-sandeep.penigalapati@intel.com>
 <aseBPS3GmdAkIvn8@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aseBPS3GmdAkIvn8@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB379463:EE_|DS4PPFBA72E12AE:EE_
x-ms-office365-filtering-correlation-id: 27cb2150-bc4d-4d8a-f24d-08df2561ee99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|10067099003|18002099003|4143699003|11063799006|38070700021|56012099006;
x-microsoft-antispam-message-info: js7u/4+LJJWXsQIFKVhdQZJDQ49v2B/+6t54T6K+6zpdn5Kro4NVGRYwtYZO9KH03JRXucXtIIN9n7u6km1SoS7eaZR7sPhNcg5OuogJwVNf7ro9PmW6Dk6SSONSE1s3yue2s0Opxu1Mf1b5e6tdr1yfBA+6vSiHNqKOV6AVU6FUJauBcYpsAJ0dsgH7nCfzhoL53iBkrrrPq5QNFt46ieAntOsBdMSUYHosFnnaw/zwUN6zx9sD8cI7XPcMF0QEoRdP1W7nQdTKhWJP3WZ1VD0ca5j1l1WnVnZJNxjAvFwuuv7hfKTqFpWGp115TucGdZ+aI4ZCGmIMKSlqdfYeKJx+QlRiUgHsDpC9NGJKrkkTF29iHwZqB/t/m+aQUrIIXUevMf3zDdNFAZGNETjOUaTECkMW5f3YwwBXAjKVzSH72xQR8nGwVTfwdkHtM2CXrezMunf1XZ8UF87RZNjqTf7D25Cg3Sh/4S4l/M/6oiOaAbbjxM501qxqfmpDDUE3Tj/4BqQzocUm6ZRmLEOjsVwqVL52VsB3NCMpQdEsPudQg8NjqYD4ufHHlC/HVX6i/p+jDQRr1AFbW1bo0fq9VAA3xgLuREr3zMOzzeQn0CpMZhmr/MdiuR6H4db6UYu54BGkAB3TY7ii8Vy49+B8rO+cWhRwtxp9cAn6nB00PGHlYMtpRPTiUqCyW0wXwGWkG5pw6e7kYtyELN9ukRWTbusMufytwCw3jxfJ6H/Dg1k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB379463.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(10067099003)(18002099003)(4143699003)(11063799006)(38070700021)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Nv5aExa1BLdUmgDs2GSqNSMMu53y/erZ64nSi6FOUhpA4xQhLMmLb904hLVE?=
 =?us-ascii?Q?tjQgWIZ1yKlajSYeE0dMT9seadfm+u/NTSKPKPt0GkGx0JNubFL3qQrkoQC6?=
 =?us-ascii?Q?AarisyXTv/1Wx3QRY5LKUU3jdobCzLr977vP93it5qZmVbSrWpPknMPQtEIG?=
 =?us-ascii?Q?Il/9ziXtY1Niy7O0qd8nv6zRXYSIVIIa2bypCZfA9dDhFQQSs4NYwi2wWz5M?=
 =?us-ascii?Q?vF5DzBgOEnWsSuriSU2pp08f7S+MKLjyMKu18hGr5EBwzJuzFOTv2SpUVM/O?=
 =?us-ascii?Q?D2/Z2qcrghxvpQBV3EEYwzcU7xzlEHmTW3RSsHwsRmrqzaxoTQEOKVdMQ09k?=
 =?us-ascii?Q?PfqWoAhpZKJYWyUGBnwLI77Y+RCqpGtsoW2pjydL4+hYq4EfjrFlgUTYGJoZ?=
 =?us-ascii?Q?Jmtu23KUkZI9yL0vd9jEVVd2q5dHzXmmeLjqIHCxvx9qcZok2Kp4bN9euS91?=
 =?us-ascii?Q?iZ18JGBEr7YWQUxeCb9UbB6OxE2Hip/IzH1U/ULSy3c6PpJGsR4cBIVJaxCc?=
 =?us-ascii?Q?3j9uT+ds1dPUrPyZ6uaPgWEjwFY9FD6gxKR4DHz19IapzempLp+m2BYkGvFf?=
 =?us-ascii?Q?0nFHEy/O5AxoCy/+f5sgtBCrsy5KWhHy0UYckNXAMQjztBlvfmF0G4qQYnyQ?=
 =?us-ascii?Q?qN14vInXZ8HzWw2vvabc7zoGMNwHVE276AVL3Xg0CPSoSinam20s9aO3czhl?=
 =?us-ascii?Q?tQwhcnCLQsIM2jtdgL/2943oIhPD6HzBF3jVtd7nykVTImvVDHLYojfiPdna?=
 =?us-ascii?Q?JLul0GgvQIXtAtlM3PZnaTZGR/mCUhGG+nxDdg13Y8uMAk+lfvlldxn4W3ed?=
 =?us-ascii?Q?ew9rgT5W3q/iVeZ90xTtjeYGK8Uf9mq7bGqkwm0T6mBnoUSMS1/9txP/e4JP?=
 =?us-ascii?Q?17kUfFP287+8DHWeIN6mrvK4PkREEeX0a++Fa7zVULIcjjseoq6rA5lQQ95A?=
 =?us-ascii?Q?7igfQqAkE2czGIQoxkBsh/Fua52llTYWUCPUGtvmHsacmvNViowDeuI3oFPn?=
 =?us-ascii?Q?KB8Wz8oqeVOH0h2S/CZG4qhvmfJVHOF3ugJGIJJ7/mC7em9TLlj9/wSujluP?=
 =?us-ascii?Q?uQMhDr3gJRBLTLuvIeCRJyLOXISYoqtMBKWK3FIC3iiT04DSLZKDuL2sJ0cB?=
 =?us-ascii?Q?qW+PzM5l5pQX9dlfTfQgkLsRTp3nAbY7IqwmooZBV5tdoTpYcm8AcKUcagEp?=
 =?us-ascii?Q?Rp/DXawXNEO0JIHdOnqxm19m3OTubS5nrfNmY1+7egxjtAVHXFI1bhg7Lyb+?=
 =?us-ascii?Q?MLVIl5WP08PDNuQ7ly51Tf0oCy7gqopZpHqTOKB2/Grd2SrYynplGqsr2YQZ?=
 =?us-ascii?Q?dBPSdK0dnA5ZPTeSJu+tkPAm5jPzIBECPoJe8b5ac5THCBsMTlAxodE4itG0?=
 =?us-ascii?Q?DYmODQnrU3s+o8chFGWRgSQXueVMul/RgAlCvybE2Iyv7Df0Ywpq4/GL2fLI?=
 =?us-ascii?Q?H/fpXGlIn897BaTWBmvNLv0sNMwfpTebNRxba81UALXv9u3kwZ20LkMo0CwI?=
 =?us-ascii?Q?bE3KumcG9sDBHTexrdUMoj0irKkkNPFG7fus7MMNai4Dy7U3SOCM8doi/BwX?=
 =?us-ascii?Q?oEfpot6oNGynMiX25pN2SO8QnSVtEfpy6SMGlU9U6HjyjT7YrDgxIE98VTkG?=
 =?us-ascii?Q?ui5SodkpLzZtzpaS6bB0q9wLis5MqsFZOAXhW0c8h0+xt5twW5XdDHDYZE2m?=
 =?us-ascii?Q?cGqZgSRIAH4FvpK7mDOzP+IJUgvGAf94toOsLUvKSWEHAfVT8pH6wVL6cJZM?=
 =?us-ascii?Q?fRAHOqs7wlPur22Mbb1n5/t5uU36Agg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: WxJtm3FD/bI1vTkgkoqupQv6TclN/fasQoh4uMQzDScqmYyD0guh7EjyL88z6iEoXx5wFJaZfEA9C7HcMyvOktI1lM9OKHGMz8+wr0SLPi6mV2pgC1Tqts1ziq632FAvmHiBFGAWm/eRS7zntgje/QcX3ChMl/ERlzw1MoqmX6FzVeBqifVSx7LbBsH/C3Yljq91rGMJ5a6Ya5oCWuAispoHmuxkxYwe+rP0cUDNBo0TRg/Le3FwYzNVlc4gvUsKwKQ4JbAremRFedSlLFDkcsRl6TMXnSh96dITzvTn1joJwM6wjWJh70hr0xwBHyB2HqvRSMstv7QskX+C75x1+Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB379463.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27cb2150-bc4d-4d8a-f24d-08df2561ee99
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 17:31:05.4743 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: areIjT+QBump2Ah9zhKpqWjlx9h/O2O+oLmgV5a8APN2q/SFj4wKA6+pCv63Nn5KDOyKwylhbd0m0x5VfC2a9suNqV9MBq2ghwfFpSqCFJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFBA72E12AE
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

>Patch looks ok to me, and AI review finds no issues. I've flagged a couple=
 of
>minor things below.
>
>Main concern is performance. What's the performance difference - if any -
>measured on this Rx path with this change compared to without?

Thanks for the review.

On E810, 64B single-core rxonly (--record-core-cycles, Rx core
saturated): with RTE_ETH_RX_OFFLOAD_TIMESTAMP enabled, the scalar
fallback was ~159 cyc/pkt; this patch keeps it on the vector path at
~78 (AVX512) / ~75 (AVX2), roughly a 2x reduction. The non-timestamp
path is unchanged.

>Patch needs a rebase, there is already a section in release notes for ice =
driver
>updates, and the ice.ini file has conflicting updates too (though both the=
se
>are easy fixes)

Done in v2 - rebased, release note folded into the existing ice section,
ice.ini conflict resolved.

>Nit: I'd try to keep this on two lines rather than 3.

Fixed in v2.

Thanks,
Sandeep
