Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9CCC71157
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 09:55:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F56640DDE;
	Tue, 17 Jun 2025 11:55:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id CC70F40A73;
 Tue, 17 Jun 2025 11:55:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750154151; x=1781690151;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=SiUe3j+A+M1OCGPOj4fIPTvfkYbMLRlOC+O2qrltHPo=;
 b=Ie1ysgsP7ZKDjauZCB4PbB4E8vr5LFpOoIYSsurk/CeOdWfzsj9BTnhF
 Gd4gOlRUq+UHRK9SpnAlygy6FjmW1PEX0g2GC8wD/rVzkzqXKY7saMmLb
 YxHVGY+OKNsSgjcYcNfJ9u9I6Ow5o6cEV8CizemUBtKvEV8S3zXzI7oAK
 YWxpF/XhLZ8pVNjVm9EqPSyXSsxLF5Dss1zu/H2PACsttXGoz3rjJM4m4
 UKSTnadw/lOpw3TaH+htX5uZ0/vhMYSN1+W0HEaa8svftsOGfes4Y8GKH
 I93w/yuCIMlzXw+3mbs7XO5fZSexNLtN5zyqzXDUQP3tOydLpH6Ym88J2 w==;
X-CSE-ConnectionGUID: 2EvCNZbkQ+6/9i412baraA==
X-CSE-MsgGUID: PpU1vjupSW6rB/iR9/iokg==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="62596272"
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; d="scan'208,217";a="62596272"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2025 02:55:48 -0700
X-CSE-ConnectionGUID: LxrEEBXvSxC8h6ttkXhLYw==
X-CSE-MsgGUID: 4oVqqEKjTpWYZ6DJJqoeIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; 
 d="scan'208,217";a="149620441"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2025 02:55:48 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 02:55:47 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 17 Jun 2025 02:55:47 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.61)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 02:55:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vhxFUUZx8ePj+ua6RMgbl/mKd989wDPFO16Lshqd1TMPa3Y4p57CxXKRm+z7NWmCz1U/3UgkvZDkrgjH3uOMFsk5fQoOqQzErHfjQzmTkpzWjn/Tw6d7bCQmOEXZCflK1uxKSCJfwYRwmDMKE/j84S8zsWHWQfQqUx4iYCj7VMvwjSeckd6EpodLd2gtA//6dGa4OliSAsLXQaBjH0UAq9jZwxv19F9ZSMTkRdcbab/lL5n8eitbYawN6eGBy0vqt+IET035laIx5+HB5tcpIOG2UHX5w9Im3SR/hE+Dga+uAokJmhWtlHUrN4kVW8nJje5vTM+HdSWr5xbmhtupuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzAH9k+BF94RW1bZbgTOG3CG+V5tK7jdecoz//DvLrs=;
 b=ZFHqT083rgZDpI2OeMw6cww0BeWw1R+567BW+Aig22RdQNj0wEKv6kIwLl/fW5hEnCcrF5t1891INESuAQ57lqVjPLPGZyLW09KENINZ3l6lz1Z2KKipsI+0i//QPDX5JWSHCpMe1M/9BsAuCtHMGDMN5PmyuezqiH28nfW6hPKnvPEgIzsvKLOxNoI6CVe+BJSyoEFzZVAYRWc0QkhbB7QBkU/06+xyg+HXpd7+xyJqC0CIncu1laSfO8jXbdE2D+FtmI6NitOMAdzKkZnGzSwxeJAIryIFQilQrdSFClPlP5wfeHGSMwHls9O3VQtk8T3OidufPQ3qMU6Wkqw2DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7458.namprd11.prod.outlook.com (2603:10b6:8:145::13)
 by SA0PR11MB4573.namprd11.prod.outlook.com (2603:10b6:806:98::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 09:55:27 +0000
Received: from DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::1a9e:53a6:9603:8f79]) by DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::1a9e:53a6:9603:8f79%3]) with mapi id 15.20.8835.026; Tue, 17 Jun 2025
 09:55:27 +0000
From: "Ji, Kai" <kai.ji@intel.com>
To: "Nicolau, Radu" <radu.nicolau@intel.com>, "Kusztal, ArkadiuszX"
 <arkadiuszx.kusztal@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: [PATCH] crypto/qat: fix out-of-place chain/cipher/auth headers
Thread-Topic: [PATCH] crypto/qat: fix out-of-place chain/cipher/auth headers
Thread-Index: AQHb24LL8XaI80FjbEmwgo1d8PJP/7QHJMGH
Date: Tue, 17 Jun 2025 09:55:26 +0000
Message-ID: <DS0PR11MB74583A17750C4A6AAF023CA88173A@DS0PR11MB7458.namprd11.prod.outlook.com>
References: <20250612101414.240641-1-radu.nicolau@intel.com>
In-Reply-To: <20250612101414.240641-1-radu.nicolau@intel.com>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7458:EE_|SA0PR11MB4573:EE_
x-ms-office365-filtering-correlation-id: 502df13b-f8ef-4ba8-116b-08ddad851621
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|8096899003|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?qXox3avxVyg85sCYw2uwOu5FhfoH+wSEsan64FVX7TejWVkJG7/Bd7dsquM2?=
 =?us-ascii?Q?MmrxBl+qqqYJeYqk/fqbnu4Jy0f0/RtqTHe+CW5llTpA8HUWytKin4FCW4oC?=
 =?us-ascii?Q?Khbj+JWHJesemctkEDdfRfAL68Vi7uBPLZR5kCTbEq86ujiDCCAH32MJDjm2?=
 =?us-ascii?Q?SI5a7LZagLu0vXeeDgyN/CN1JtUC8cvCOk/yT1ItnvDXxQq+3lTS9GGiu630?=
 =?us-ascii?Q?fL9/N13U9b98peH17SAhWAs4HyvQxzEB3ArsBT+z684mmw5VLFnWbGb/d6S7?=
 =?us-ascii?Q?Y3PeAkn608XQXqdr24bCdcj9U7JieQ5qJBjU2llVM/L3XguKa+YOt1HO+VaK?=
 =?us-ascii?Q?78opNfdmqWdBoB1Lzui5YcXDnVS5zbMJxPPqos2PnhGUnNFcmptm1QdiLLur?=
 =?us-ascii?Q?728LqZCN/N0gA5xRJJ2ihHgTTwpyZ2VOMLxq70mntP8ZD0VvPSfnc8ck1s5u?=
 =?us-ascii?Q?N2KMjDbL1Acdy1KQGF+Kd5aBgBJK2RV4BRuFCAzn2+k4gQtabKnuk3osCQrb?=
 =?us-ascii?Q?CX3Ex8Cj0266QwXB3Uitc4qzO2+tCOhNVi4XFWcuWQTUWRshVniqzpPP+r2k?=
 =?us-ascii?Q?uxne93eS8mxYmUvKcZ4fkDoiCsYyHJXV3UB1+56Um79s7YKMNOyDeWl3hppC?=
 =?us-ascii?Q?EXdpTYj1w1ZYirZTSifsqofHznnhhsUTiaKlOVeQpysM6sihaQSDSnbHjQ1k?=
 =?us-ascii?Q?zilPCR12kznff8k/pzhCkfBis3ZSmtLJ41GIfPFSCUNJmWsy0KvraHdCx6Ta?=
 =?us-ascii?Q?X1QKAy3t8hNbA/YMSqm7s5GBoJZEaWoSq1o8d5xvDVuxVTIb6Xx4uhev83T1?=
 =?us-ascii?Q?dLUUCo+J1N+nw/ER8L3TG/m4jbet4FnihlRK6VsSTqNhiBUjVQEO4YaOwKTM?=
 =?us-ascii?Q?i1eitZroBEl1Mh4jQ3F1mGtu449Ukk4PPNB8W1cX5mZno+04BFJT/+TNNu7a?=
 =?us-ascii?Q?nH4fZ6Y7ZYhYPYfWKdPLDyi5Rbc2oINq8cGFVufBn+RCSsom2xbVZe5yaEET?=
 =?us-ascii?Q?MrsYivI6y8OauPLAlldoV1/K0MBo7Wgfa36H5RVVvBe76l07Ryzi4OVUsgxw?=
 =?us-ascii?Q?9ZGkrK6nH7RTJxACgapaVrHRiyUhfOU5xw/WMc7/Bci/RHUg3YKohOuY8Y9x?=
 =?us-ascii?Q?LtYUhgnQ3NgBJqmOECJosbTlFmVSlifM+2buRQ1y8/7wa/a8XQbH7BbUCAbM?=
 =?us-ascii?Q?WwkrBOpGwTSGKeqEuDilWqJuGK+VNOEJ0YGxofRp8OrkOhdTt3rLsP7/z314?=
 =?us-ascii?Q?is0QbaTgAN4wu5p2jyyrU4Hv3GdRllTXE8/VubaKu9JD3TUqw4Afo9yVoJnk?=
 =?us-ascii?Q?TwLrH8yIS73RF3rIres6gnh3jXoh8B93r4t50h2YOHIx87SYJOElHpuVe3vv?=
 =?us-ascii?Q?Z8Rd3JGxL9CS8Zcazhpw3ScaZR/k16q9wP5Khv813epIExnVg84FmMO/aVUy?=
 =?us-ascii?Q?L0q3wxmZHV+03lltx8RMR81YOyKDED56eNwlihZ7rnQk63myIx8S9A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7458.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6XOneQVC/MeaxgEP2iUIGqRJFIwDxSlqWYSyxgZU02chcw4EXl2YDYEEzTE7?=
 =?us-ascii?Q?KJ62NLbG38uDGLLRQC0t+dam+MObyQmAUp5mDVCLez+jWMGTMpJw9QcnQGbu?=
 =?us-ascii?Q?EBwBqRxxKEPhoKPPrV0nhMmVjE/s5p3E9NJ3JsV5iIBIM1FSXErBYvwiF0vV?=
 =?us-ascii?Q?MYZCtzDWGiuFwuMj3foR3Rl5pwNiKX2tkqhofW17j7MTwF49ECM27mBsMmBJ?=
 =?us-ascii?Q?S9f7y1NTbgjRHTrkv8uy/ppxewJr5yKrwwvfdp53epqpJnPMSti7P4moKsT2?=
 =?us-ascii?Q?HqtcQMgY+LSpZJsFDCeJG4RvaL3muhi9+DVZG83pnYAx7deMEvjYoakSZgoh?=
 =?us-ascii?Q?yhDKwGXw1YrtxCPR9LZAMsPmI56HkGPIjq/r2775wZyu+mBfkDJn3tFxKEwx?=
 =?us-ascii?Q?l0TLVYJwdD6X1/B/VbylwU9IbxhW7MDrtI6o7qp9QDuqXAKoZBOi9qUCKP3N?=
 =?us-ascii?Q?aFqn7jOAuz/Rw90RsaG6We1ww3n8bp23nYZyUFNOvyosLw56Az9bO+RhAyEV?=
 =?us-ascii?Q?oGTPOPG0PSzcGRU0DYAtka7LomzEcKLUc3f0aak3HMG8U4XKDyZdE7HDXR2t?=
 =?us-ascii?Q?zVRXdt6MbbEVIE0AmGdOsFruSVLUwbGlf6sq7OQTkSXed6GqsfTQNQ7NVpNb?=
 =?us-ascii?Q?q3iCOjzjVj8lRWLx9KXBEu3cnfSn4UifLr0RfjkszGBEg7N5IM7q98NLP89Q?=
 =?us-ascii?Q?EXg94jtFUOSv6aoW09/fypEMep/gXflTsmE4SgMlDjMccNbg5oGigurayXZg?=
 =?us-ascii?Q?kaapd6jlhcpADztfv4tc//6tsBaFzgnFNYO/xEgsEk5yWdCU3/O2pJ6v9s5d?=
 =?us-ascii?Q?z+QH5YQfjYJSavmbHDLc2spNvFL99fQRxDylOXUUet5l+MlC4QU3IMTHwa6u?=
 =?us-ascii?Q?wnb7nZx1EpB8bqUyvF837Pj2BJ5wpo34zbybh3kkkLorjoxyQp/f51MSrSjB?=
 =?us-ascii?Q?5iA6KRCI+AYT8Yui2oLWiEp/Vhg7EVx+ErZ1qEYUasoxRk/U6q5YztvmOF/n?=
 =?us-ascii?Q?0ksekGv1eKm3CrbE/OJ+nDGIWRFqZ/iiMzqOdxbYRrbD+Rxj01L6hf5N1ZcC?=
 =?us-ascii?Q?Z/rNeA2kvE56Phe/5DvfPcfMmX8Epcufm93TiFfKfK+k/A7q+Dc8tUoVUwet?=
 =?us-ascii?Q?Y7Ws3CBVOO4WzH0a3sfo5VLUcoPMSY6sYQ7GSO39yXVfEHNs2Lpv0zchtZWM?=
 =?us-ascii?Q?f/33c6X6hOt8r6b4XXYnkYNp+cx+rvzkdAad/YzOqRZrwRypPR4zkWSGtlds?=
 =?us-ascii?Q?cOG7/Jj9JaHhLBaC7nQnN9B74GmvLrp5djt8f/6WRlxdvKY9GKhwwQXFoZvV?=
 =?us-ascii?Q?p97W0IZ/NSiCItPeTRD7xtMgtWKZWEZh9U4zelQZtsgpeZppMsk2SJmrAIJ9?=
 =?us-ascii?Q?dmzgeG7iujkParAJUhtCbH4AOl3klrRapRgTOGPraIduFijxGzthorfRfdyR?=
 =?us-ascii?Q?tx+u9pS4AKaXgYbAHLhniA6apoofvwLf5Daqx0/DjDd4VF1fZrNxLvy8VcxK?=
 =?us-ascii?Q?ho6MDLuI0A0Ac4TWBUE42FwkDRcQfLzsedjPGCFjvw8WTVKcOXZ6YZcMeXP5?=
 =?us-ascii?Q?ZVT/Z+Fdhz9RHOMjtJI=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR11MB74583A17750C4A6AAF023CA88173ADS0PR11MB7458namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7458.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 502df13b-f8ef-4ba8-116b-08ddad851621
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 09:55:26.9435 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fuj50O+ZAlGwNOJxPZbAJAzpSieJ1hvued1HbRbTgA7ZVsFlwCFxl8xfSFn2icr8mJaMjeT5oEw75cKreYl6jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4573
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

--_000_DS0PR11MB74583A17750C4A6AAF023CA88173ADS0PR11MB7458namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Kai Ji <kai.ji@intel.com>

________________________________
From: Radu Nicolau <radu.nicolau@intel.com>
Sent: 12 June 2025 11:14
To: Ji, Kai <kai.ji@intel.com>; Kusztal, ArkadiuszX <arkadiuszx.kusztal@int=
el.com>
Cc: dev@dpdk.org <dev@dpdk.org>; Nicolau, Radu <radu.nicolau@intel.com>; st=
able@dpdk.org <stable@dpdk.org>
Subject: [PATCH] crypto/qat: fix out-of-place chain/cipher/auth headers

Extend the original fix to gen3 and gen4 code.

Fixes: 317d05f3721c ("crypto/qat: fix out-of-place chain/cipher/auth header=
s")
Cc: arkadiuszx.kusztal@intel.com
Cc: stable@dpdk.org

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c | 13 ++++++++-----
 drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c | 13 ++++++++-----
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c b/drivers/crypto/=
qat/dev/qat_crypto_pmd_gen3.c
index 478e766b97..428430882d 100644
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c
@@ -643,16 +643,19 @@ qat_sym_dp_enqueue_aead_jobs_gen3(void *qp_data, uint=
8_t *drv_ctx,
         for (i =3D 0; i < n; i++) {
                 struct qat_sym_op_cookie *cookie =3D
                         qp->op_cookies[tail >> tx_queue->trailz];
+               int error =3D 0;

                 req  =3D (struct icp_qat_fw_la_bulk_req *)(
                         (uint8_t *)tx_queue->base_addr + tail);
                 rte_mov128((uint8_t *)req, (const uint8_t *)&(ctx->fw_req)=
);

                 if (vec->dest_sgl) {
-                       data_len =3D qat_sym_build_req_set_data(req,
-                               user_data[i], cookie,
-                               vec->src_sgl[i].vec, vec->src_sgl[i].num,
-                               vec->dest_sgl[i].vec, vec->dest_sgl[i].num)=
;
+                       data_len =3D qat_reqs_mid_set(&error, req, cookie, =
user_data[i],
+                                       &vec->src_sgl[i], &vec->dest_sgl[i]=
, ofs);
+                       /* In oop there is no offset, src/dst addresses are=
 moved
+                        * to avoid overwriting the dst header
+                        */
+                       ofs.ofs.cipher.head =3D 0;
                 } else {
                         data_len =3D qat_sym_build_req_set_data(req,
                                 user_data[i], cookie,
@@ -660,7 +663,7 @@ qat_sym_dp_enqueue_aead_jobs_gen3(void *qp_data, uint8_=
t *drv_ctx,
                                 vec->src_sgl[i].num, NULL, 0);
                 }

-               if (unlikely(data_len < 0))
+               if (unlikely(data_len < 0) || error)
                         break;

                 enqueue_one_aead_job_gen3(ctx, req, &vec->iv[i],
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c b/drivers/crypto/=
qat/dev/qat_crypto_pmd_gen4.c
index 6a5d6e78b9..638da1a173 100644
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c
@@ -418,16 +418,19 @@ qat_sym_dp_enqueue_aead_jobs_gen4(void *qp_data, uint=
8_t *drv_ctx,
         for (i =3D 0; i < n; i++) {
                 struct qat_sym_op_cookie *cookie =3D
                         qp->op_cookies[tail >> tx_queue->trailz];
+               int error =3D 0;

                 req  =3D (struct icp_qat_fw_la_bulk_req *)(
                         (uint8_t *)tx_queue->base_addr + tail);
                 rte_mov128((uint8_t *)req, (const uint8_t *)&(ctx->fw_req)=
);

                 if (vec->dest_sgl) {
-                       data_len =3D qat_sym_build_req_set_data(req,
-                               user_data[i], cookie,
-                               vec->src_sgl[i].vec, vec->src_sgl[i].num,
-                               vec->dest_sgl[i].vec, vec->dest_sgl[i].num)=
;
+                       data_len =3D qat_reqs_mid_set(&error, req, cookie, =
user_data[i],
+                                       &vec->src_sgl[i], &vec->dest_sgl[i]=
, ofs);
+                       /* In oop there is no offset, src/dst addresses are=
 moved
+                        * to avoid overwriting the dst header
+                        */
+                       ofs.ofs.cipher.head =3D 0;
                 } else {
                         data_len =3D qat_sym_build_req_set_data(req,
                                 user_data[i], cookie,
@@ -435,7 +438,7 @@ qat_sym_dp_enqueue_aead_jobs_gen4(void *qp_data, uint8_=
t *drv_ctx,
                                 vec->src_sgl[i].num, NULL, 0);
                 }

-               if (unlikely(data_len < 0))
+               if (unlikely(data_len < 0) || error)
                         break;

                 enqueue_one_aead_job_gen4(ctx, req, &vec->iv[i],
--
2.43.0


--_000_DS0PR11MB74583A17750C4A6AAF023CA88173ADS0PR11MB7458namp_
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Radu Nicolau &lt;radu=
.nicolau@intel.com&gt;<br>
<b>Sent:</b> 12 June 2025 11:14<br>
<b>To:</b> Ji, Kai &lt;kai.ji@intel.com&gt;; Kusztal, ArkadiuszX &lt;arkadi=
uszx.kusztal@intel.com&gt;<br>
<b>Cc:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;; Nicolau, Radu &lt;radu.nicola=
u@intel.com&gt;; stable@dpdk.org &lt;stable@dpdk.org&gt;<br>
<b>Subject:</b> [PATCH] crypto/qat: fix out-of-place chain/cipher/auth head=
ers</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Extend the original fix to gen3 and gen4 code.<br>
<br>
Fixes: 317d05f3721c (&quot;crypto/qat: fix out-of-place chain/cipher/auth h=
eaders&quot;)<br>
Cc: arkadiuszx.kusztal@intel.com<br>
Cc: stable@dpdk.org<br>
<br>
Signed-off-by: Radu Nicolau &lt;radu.nicolau@intel.com&gt;<br>
---<br>
&nbsp;drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c | 13 ++++++++-----<br>
&nbsp;drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c | 13 ++++++++-----<br>
&nbsp;2 files changed, 16 insertions(+), 10 deletions(-)<br>
<br>
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c b/drivers/crypto/=
qat/dev/qat_crypto_pmd_gen3.c<br>
index 478e766b97..428430882d 100644<br>
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c<br>
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c<br>
@@ -643,16 +643,19 @@ qat_sym_dp_enqueue_aead_jobs_gen3(void *qp_data, uint=
8_t *drv_ctx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; n; i+=
+) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct qat_sym_op_cookie *cookie =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qp-&g=
t;op_cookies[tail &gt;&gt; tx_queue-&gt;trailz];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; int error =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; req&nbsp; =3D (struct icp_qat_fw_la_bulk_req *)(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint=
8_t *)tx_queue-&gt;base_addr + tail);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; rte_mov128((uint8_t *)req, (const uint8_t *)&amp;(ctx=
-&gt;fw_req));<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (vec-&gt;dest_sgl) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data_len =3D qat=
_sym_build_req_set_data(req,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_data[i], cookie,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vec-&gt;src_sgl[i].vec, vec-&gt;src_sgl[i].=
num,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vec-&gt;dest_sgl[i].vec, vec-&gt;dest_sgl[i=
].num);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data_len =3D qat=
_reqs_mid_set(&amp;error, req, cookie, user_data[i],<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &amp;vec-&gt;src_sgl[i], &amp;vec-&gt;dest_sgl[i], ofs);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* In oop there =
is no offset, src/dst addresses are moved<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * to avoid=
 overwriting the dst header<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ofs.ofs.cipher.h=
ead =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data_=
len =3D qat_sym_build_req_set_data(req,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_data[i], cookie,<br>
@@ -660,7 +663,7 @@ qat_sym_dp_enqueue_aead_jobs_gen3(void *qp_data, uint8_=
t *drv_ctx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vec-&gt;src_sgl[i].num, NULL, 0)=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (unlikely(data_len &lt; 0))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (unlikely(data_len &lt; 0) || error)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; enqueue_one_aead_job_gen3(ctx, req, &amp;vec-&gt;iv[i=
],<br>
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c b/drivers/crypto/=
qat/dev/qat_crypto_pmd_gen4.c<br>
index 6a5d6e78b9..638da1a173 100644<br>
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c<br>
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c<br>
@@ -418,16 +418,19 @@ qat_sym_dp_enqueue_aead_jobs_gen4(void *qp_data, uint=
8_t *drv_ctx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; n; i+=
+) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct qat_sym_op_cookie *cookie =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qp-&g=
t;op_cookies[tail &gt;&gt; tx_queue-&gt;trailz];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; int error =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; req&nbsp; =3D (struct icp_qat_fw_la_bulk_req *)(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint=
8_t *)tx_queue-&gt;base_addr + tail);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; rte_mov128((uint8_t *)req, (const uint8_t *)&amp;(ctx=
-&gt;fw_req));<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (vec-&gt;dest_sgl) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data_len =3D qat=
_sym_build_req_set_data(req,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_data[i], cookie,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vec-&gt;src_sgl[i].vec, vec-&gt;src_sgl[i].=
num,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vec-&gt;dest_sgl[i].vec, vec-&gt;dest_sgl[i=
].num);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data_len =3D qat=
_reqs_mid_set(&amp;error, req, cookie, user_data[i],<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &amp;vec-&gt;src_sgl[i], &amp;vec-&gt;dest_sgl[i], ofs);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* In oop there =
is no offset, src/dst addresses are moved<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * to avoid=
 overwriting the dst header<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ofs.ofs.cipher.h=
ead =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data_=
len =3D qat_sym_build_req_set_data(req,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_data[i], cookie,<br>
@@ -435,7 +438,7 @@ qat_sym_dp_enqueue_aead_jobs_gen4(void *qp_data, uint8_=
t *drv_ctx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vec-&gt;src_sgl[i].num, NULL, 0)=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (unlikely(data_len &lt; 0))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (unlikely(data_len &lt; 0) || error)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; enqueue_one_aead_job_gen4(ctx, req, &amp;vec-&gt;iv[i=
],<br>
-- <br>
2.43.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DS0PR11MB74583A17750C4A6AAF023CA88173ADS0PR11MB7458namp_--
