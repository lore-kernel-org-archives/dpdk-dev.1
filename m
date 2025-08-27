Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8362CA0FED
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 14:31:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09A8C40292;
	Wed, 27 Aug 2025 16:31:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id A8F134028E
 for <dev@dpdk.org>; Wed, 27 Aug 2025 16:31:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756305068; x=1787841068;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=p7JFTfaimD77cXvp1OGaxw0AVO+EcoMjS9TrixLvRc8=;
 b=AJco9aBT1wCvNLyibCKN47w6UJcfCgb3tG6uuh/lmYyeKFyOUVugd/eu
 viEUTEye9hYGhDaTNYJhx9n15N4LmQCQjjIxMlgHYl9E6moVOA5wGgcu9
 WXt7pex37DczMtAD2dB0FGB2OrbEP8TsEu1/mjuVprukQVCoGC+OVNdbx
 2gWSZW1dbpfXr2S3Ais0WCGc3Sf3/HWWqRdNSrBTBvc2xX7Hq/fD87Idd
 hEqgzVBuiD7wkuoN3XeyuLlyFLLRsIG1xxhwn76HarlTUxy7LaKarKh88
 U47hgpiXUgG2/QF8XldqIKm5ur08m17uqY26GI6hjkzN0VlUCms2CJjSu A==;
X-CSE-ConnectionGUID: ++/vltAQTsWAWYxtaX6OIA==
X-CSE-MsgGUID: CvFhg8adRNm0I9DVjaRpdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="61189766"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208,217";a="61189766"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2025 07:31:07 -0700
X-CSE-ConnectionGUID: KGduNK8LR4Wf9lISVD546Q==
X-CSE-MsgGUID: xGSCDSBvQKiGv2UpG4k3gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
 d="scan'208,217";a="174242949"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2025 07:31:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 07:31:06 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 27 Aug 2025 07:31:06 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.42) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 07:31:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E18/BWnsd3PjwXZgAcjJrra2NFamVHDkF+ndpLj0igUZNRZ/LvE8c9p/oI1c5XxKXFEu2SFabOCSu3OYBrOcPVMBo2/zoi19bMqSnaFIjFoYCaS99PJ6O+Z3hDWunYke3Wz0rv8LACZThqRMj1p9Whm3YmfsMAb3+qLjZbIQcsBHwmSjy5Xz5BFvN5fY6KXv0S0PJK8xlxAlvHYROH4rAitjw/2l3NFGz+5RqkHKnc85pXD66f96Hhhn2NsuUKAkCPJqOeFWFBgQZ3dWYEkI57tvqyReOKDbl5n8ItkdQs36wb0sIydYnwFvDaTAfQb5j6cvIqrcRtUIPnhprCQ04g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bRMr/Xklz5C1lZ7BvVaiDMgnqmjqbWN/wi+221tUTM=;
 b=DsM9QF2APAHNTmU94p7AMQRqRnHZSNNsQKZZWd8nXBW+5mNYfxn3CxDmpIJsjJiwiRNyBoOH4gvVGbxSyx88zneFyz5ZNIo9wmzuZ1zy2/ihVU1BVmwspX9ww39Z/crLTAFS05l7BS9TInjHZq6CJnXhqnRC6A4J7qrhmKuKjYI9q1aC8hI/LulWxfxtIkINzhJFybVd3nQZobDnyeKdTRWVRFcthCEG5sJU4Mjo1a/uW3XgqOk51jTGdxXIdnlux7JxqV2i+7hiI97kdG2URXOFw1QqNXebh1sEDesL5UPQ5MVK5lqFdvK9zSZ0RhvF2LKDPH7vjdu1ifXmCB7Fig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7458.namprd11.prod.outlook.com (2603:10b6:8:145::13)
 by IA0PR11MB7749.namprd11.prod.outlook.com (2603:10b6:208:442::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 14:31:03 +0000
Received: from DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::6d78:37d8:c835:540]) by DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::6d78:37d8:c835:540%5]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 14:31:03 +0000
From: "Ji, Kai" <kai.ji@intel.com>
To: "Nicolau, Radu" <radu.nicolau@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>
Subject: Re: [PATCH 2/3] test/crypto: add QAT EC tests
Thread-Topic: [PATCH 2/3] test/crypto: add QAT EC tests
Thread-Index: AQHcFzRr7DWmmj638kiUC3SIKkyFQLR2j+FT
Date: Wed, 27 Aug 2025 14:31:03 +0000
Message-ID: <DS0PR11MB74580123ED0D3A10642F8B3C8138A@DS0PR11MB7458.namprd11.prod.outlook.com>
References: <20250827092358.765222-1-radu.nicolau@intel.com>
 <20250827092358.765222-2-radu.nicolau@intel.com>
In-Reply-To: <20250827092358.765222-2-radu.nicolau@intel.com>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7458:EE_|IA0PR11MB7749:EE_
x-ms-office365-filtering-correlation-id: a31fe3c2-5084-4682-5e78-08dde57659b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|42112799006|376014|7053199007|8096899003|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?8SWHXt3QAEeGmb5wlDNOU9P0LMMlgKOUGR6m4MsXfzYJaV1YZHs2Aom1+0bi?=
 =?us-ascii?Q?zpGFYCJBoPw55t9Mmb2PdVC4OPi+vyVTbyHBvgVePLU2bVe5KB8uyUGq2ppP?=
 =?us-ascii?Q?7dxH3yN934vcqKvrrFUwRGCQjQVWqkmZOO1uKR7n3OKERvroHKmpiigRJ3kr?=
 =?us-ascii?Q?Jr7eqVjFrtZBo6ttSWL82VaU1/6pUOHPqZiYBIfFpLuZTGt6JwmefryJmjOP?=
 =?us-ascii?Q?TcXPgewpk+J0taeWWReHmSpwrrgN0yc9y6BNdgzmrHrnNN0rZJrdH4uUWeN8?=
 =?us-ascii?Q?YXpK358LF85juFOZcvtnoGfwfnNX75JKsPX4fl/byO4NMKs+vGFFpUvBne/l?=
 =?us-ascii?Q?BvnqGr50ZUdtk36xxph3YiU8iy0O7soc/G0kNPxlKCVg8/IBCCoHvypDPfgX?=
 =?us-ascii?Q?AgcSbNs7JFJtEmsP8l/JHLFxK+4Bz6a7F8cKQC8vtUfVMXdfhGbo1wIWqIAo?=
 =?us-ascii?Q?RO00bA9HeW48Cd+qotGxmtb14o8yuXpK1sLuOonWoxDSe+I9TRr12qzUkt5n?=
 =?us-ascii?Q?3ORr4EVGbGBheIOA6+teOUQKNO4Art4lt6JjkTBOtlEnTClZMp00ROCJiP0G?=
 =?us-ascii?Q?Mxbtm22EPGeDXXxA6+g05LhUYDR7TfojUFoiDuWNm3n2bhgLg7K2m0o00Wo0?=
 =?us-ascii?Q?oedKu/Bd/ZgDkvl9OcfhU8sTS5Yj8zSGGjHhx/HQ41AU5o1pq8YUNKxZ04qX?=
 =?us-ascii?Q?Vbx0OrrjtVgjzCDNU8nlo7OmToVKi6mnyvocRLjpf/Pzc0LnGx2t4bUT30uU?=
 =?us-ascii?Q?5w9VuI2av6f12XQ83+hL/1+pPxiM312hgCnGB/s22+lF0eBxS0hWiYoxv8/C?=
 =?us-ascii?Q?HiWN6bPO353LoHGQmuyNqSJPlue7FyVK0RbGAtx8vD1a5/mgmXkw7yS3np4u?=
 =?us-ascii?Q?twjsD0ihl59uveaTE1hKI1CIbpYIuYMlQNEdqsd7V1W+Da3Ai22lR1Cv30eI?=
 =?us-ascii?Q?Fu+Eux8HS115L8Yvtk2GxZxwcOoTwHjwK5PdLosLdY2qFW8UH6SRMvkzsiPE?=
 =?us-ascii?Q?BeGISn22QiBK0H/xIA/E1SbbxExWBBW5V1Fep/f1IDtdaRTYtkZGjb1kJP+L?=
 =?us-ascii?Q?fSTjD3VoHWGMRkBRHb+1rS0FsL/d8U5orpWjf7dkxLBzNiZtmAQJz5FooXAa?=
 =?us-ascii?Q?Fc4gWt+uvc7vMEmHbViySt8APOE9vvGvh3WB2Yb3nfvRLD1ew1c7dQ+G4JxC?=
 =?us-ascii?Q?9PuG1xIZnroYP00ZFtFGV9skJqaQ+tbvtltda1SzY//X7+h6sd2CiorBJR9y?=
 =?us-ascii?Q?x/q9K64QEQ1tTLqNT0OtrDC/cFTOQgGlYj5j0LOnCa6mTBsjVNbdFgvKDSwi?=
 =?us-ascii?Q?BNgC95gdQK7Z1jva5PL5tCc0ZvJSqpgBiLfooVrqJQsdA2tsex0imQMhHCbz?=
 =?us-ascii?Q?x4ifpSdk++yZ7NxtPUufqvzOB4DTkK2++IJqe0NjLr7c+LuvTgTh2B4zc4rh?=
 =?us-ascii?Q?kpeyPBxuURqgsNAEJIayVY/1FLNtT4cOJOHtR9qBdLwHBEJkrcTdylw1gsEq?=
 =?us-ascii?Q?3m743csQRHaVuhE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7458.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(42112799006)(376014)(7053199007)(8096899003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+Ad1J+F4G2kKw12N3vGo1siS1LHBdPbi2tqfFsfQXPs7q96Xs+vIPnyq/qI7?=
 =?us-ascii?Q?W26iPohnekuBDCgDEefWGG6THhzne+vcHZSaO2tV99Nd77U9oKzwiExxMUOg?=
 =?us-ascii?Q?hnFLxIfxAQm6zLUUke7XEZiEf3uCOOV2Ngmj0jqTp0RdlFufL60yFZ5h/D3Z?=
 =?us-ascii?Q?qL+nxPrwMKm9keHUmBUi+92DkbZIywgMeRW5PVE1cKKqjmC2voCTjvHfeu1U?=
 =?us-ascii?Q?Unp2Ge+sWDQapOGoKpWCmx8Zcl7swN60LH6+0yeLRuGQ5/DreM9e67Mslvfh?=
 =?us-ascii?Q?XUCBK7JMRFwZSt2uEkuqTXrn4htH9xiypVdvVFMfn6a+oO1jN2JB2A43F7gM?=
 =?us-ascii?Q?UZnt0iVsHVE6Oa05W1A1vg7boHPmYzd3Gr6WHG6XuBzlf0QNZDq87dU3Y24F?=
 =?us-ascii?Q?56HzGOtJjUCGJ/2skPHjMtlZTTRsz8+wgBvwAzNeRQTAFgWP7MM/vp37h6PF?=
 =?us-ascii?Q?w2DICnzJkbEKUclR73l6jOYwTcTUuMCx7//sOWKBQIrShREwZzM+N4yAdLZ6?=
 =?us-ascii?Q?XQGH+M2o7ZuzhXlJKmixvTRiMdNFVdd65FDvOc6TA7Z73xWi0B2/7ElglmJw?=
 =?us-ascii?Q?PgPxSGcVBQTe0mUForBIdMMAv5RGxDcZX1FFdHCJfvGB1iswXbKgh/ZXOm0T?=
 =?us-ascii?Q?etuqDNY3XIwwLTzdRwaKgkzc2JBjjvdEK+18diDLUVcGHLjAoVOFdB8rp1Cb?=
 =?us-ascii?Q?1X902ttDjuHvmvZEdMM3a8A93H7OXPS4zh6LgQW6AXjQ7Mh004gTfsNPxGTh?=
 =?us-ascii?Q?5QLnEvWpVjDhgf7orndqorxWNOIfLTZI+7btcZXDgMyEMD3GkcqV1/HoFkl9?=
 =?us-ascii?Q?pv4ZyEPUgwG/a2sVrxxgtMolZCRtnnEK/953xLxxpL3laWnExTqn5EHefXsu?=
 =?us-ascii?Q?WAqEGMDEm1aiYkYi+CMfwoGVk4T+6/NYLOixmfJDsxiYHo+noadqo+bKNN4n?=
 =?us-ascii?Q?8ADk2DeZU5Onya9+lhKYlYnTe0TRXqaZSpoYcmEIKjVT4GfT3yfLWsSSOzAe?=
 =?us-ascii?Q?PWe/06xtCFWKsO3I4CAA6KpM/xsmw+vkrI9pPzw+ep1fKBVr8urwrlOjt1B9?=
 =?us-ascii?Q?1gE7fmexDDB9YvGidzgSeCpEnaLAQBMXjcZSeYWUwYZK2JOneRwgR99MI7OT?=
 =?us-ascii?Q?J9RFSMKhc2AricY80jdPD0dPuKRLaawpALCYc+6zSqW9i6gRvtp8n8Lt/aBq?=
 =?us-ascii?Q?qYeaKByPdtJ9oViYS60RhROTFLIJffhXVJJ32Q/aEYAXhjpbhFsX5h4boIn3?=
 =?us-ascii?Q?HanP0eCbOf4u/jfaiaLn2WXWTuvUPWZf7tFSxWf5qlMN8ZCX9emZb67VFmk4?=
 =?us-ascii?Q?3TNIaZNAGyt+ucYOsmv9ys4MnwgZOmbKeqh6mL4G1FibBEMCsDDWQTqpFb9S?=
 =?us-ascii?Q?wbc1iwvBQJnMyBtlwuZIsOdExP8krCtg5I3WkUTUvDeVqpJKlxDrM9gtPMFs?=
 =?us-ascii?Q?wfjZ4sWdDasTNM2+fuisSTrMT1Ah9c3gicWOIoNGDRtZxCQzZ1Nx3DsA6aUq?=
 =?us-ascii?Q?Tf1HpAg17ZyARjZr1unBvkOeqxnSzdq24biIBHcPLXNn7mddq75wmfvBJqxG?=
 =?us-ascii?Q?fudJNdCM+L2fCufB5a4iMjHCBb1JjNoUGlKsor4J11nnt7OZDR0JSych6+kD?=
 =?us-ascii?Q?LhwDSmVxqOI6VBJsAUqOhEM=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR11MB74580123ED0D3A10642F8B3C8138ADS0PR11MB7458namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7458.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a31fe3c2-5084-4682-5e78-08dde57659b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2025 14:31:03.0172 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iflUTw/2hKtWMRGphIvvsFDFD6eDuCvQLg4wkAfexEpqnULiZfcsysf3mMJ2G7xUvAAMHNWXuN20AJL9+VxN4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7749
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

--_000_DS0PR11MB74580123ED0D3A10642F8B3C8138ADS0PR11MB7458namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Kai Ji <kai.ji@intel.com>
________________________________
From: Radu Nicolau <radu.nicolau@intel.com>
Sent: 27 August 2025 10:23
To: dev@dpdk.org <dev@dpdk.org>
Cc: Nicolau, Radu <radu.nicolau@intel.com>; Akhil Goyal <gakhil@marvell.com=
>; Fan Zhang <fanzhang.oss@gmail.com>
Subject: [PATCH 2/3] test/crypto: add QAT EC tests

Add ECDH, ECPM and ECDSA tests for QAT

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 app/test/test_cryptodev_asym.c | 109 +++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/app/test/test_cryptodev_asym.c b/app/test/test_cryptodev_asym.=
c
index 20afb5e98b..c62329edff 100644
--- a/app/test/test_cryptodev_asym.c
+++ b/app/test/test_cryptodev_asym.c
@@ -1715,6 +1715,29 @@ test_ecdsa_sign_verify_all_curve(void)
         return overall_status;
 }

+static int
+test_ecdsa_sign_verify_qat_curves(void)
+{
+       int status, overall_status =3D TEST_SUCCESS;
+       enum curve curve_id;
+       int test_index =3D 0;
+       const char *msg;
+
+       for (curve_id =3D SECP256R1; curve_id <=3D SECP521R1; curve_id++) {
+
+               status =3D test_ecdsa_sign_verify(curve_id);
+               if (status =3D=3D TEST_SUCCESS) {
+                       msg =3D "succeeded";
+               } else {
+                       msg =3D "failed";
+                       overall_status =3D status;
+               }
+               printf("  %u) TestCase Sign/Veriy Curve %s  %s\n",
+                      test_index ++, curve[curve_id], msg);
+       }
+       return overall_status;
+}
+
 static int
 test_ecpm(enum curve curve_id)
 {
@@ -1881,6 +1904,28 @@ test_ecpm_all_curve(void)
         return overall_status;
 }

+static int
+test_ecpm_qat_curves(void)
+{
+       int status, overall_status =3D TEST_SUCCESS;
+       enum curve curve_id;
+       int test_index =3D 0;
+       const char *msg;
+
+       for (curve_id =3D SECP256R1; curve_id <=3D SECP521R1; curve_id++) {
+               status =3D test_ecpm(curve_id);
+               if (status =3D=3D TEST_SUCCESS) {
+                       msg =3D "succeeded";
+               } else {
+                       msg =3D "failed";
+                       overall_status =3D status;
+               }
+               printf("  %u) TestCase EC Point Mul Curve %s  %s\n",
+                      test_index ++, curve[curve_id], msg);
+       }
+       return overall_status;
+}
+
 static int
 test_ecdh_priv_key_generate(enum curve curve_id)
 {
@@ -2674,6 +2719,56 @@ test_ecdh_all_curve(void)
         return overall_status;
 }

+static int
+test_ecdh_qat_curves(void)
+{
+       int status, overall_status =3D TEST_SUCCESS;
+       enum curve curve_id;
+       int test_index =3D 0;
+       const char *msg;
+
+       for (curve_id =3D SECP256R1; curve_id <=3D SECP521R1; curve_id++) {
+               status =3D test_ecdh_pub_key_generate(curve_id);
+               if (status =3D=3D TEST_SUCCESS) {
+                       msg =3D "succeeded";
+               } else if (status =3D=3D TEST_SKIPPED) {
+                       msg =3D "skipped";
+               } else {
+                       msg =3D "failed";
+                       overall_status =3D status;
+               }
+               printf("  %u) TestCase ECDH public key generation for Curve=
 %s %s\n",
+                      test_index ++, curve[curve_id], msg);
+       }
+
+       for (curve_id =3D SECP256R1; curve_id <=3D SECP521R1; curve_id++) {
+               status =3D test_ecdh_pub_key_verify(curve_id);
+               if (status =3D=3D TEST_SUCCESS) {
+                       msg =3D "succeeded";
+               } else {
+                       msg =3D "failed";
+                       overall_status =3D status;
+               }
+               printf("  %u) TestCase ECDH public key verification for Cur=
ve %s %s\n",
+                      test_index ++, curve[curve_id], msg);
+       }
+
+       for (curve_id =3D SECP256R1; curve_id <=3D SECP521R1; curve_id++) {
+               status =3D test_ecdh_shared_secret(curve_id);
+               if (status =3D=3D TEST_SUCCESS) {
+                       msg =3D "succeeded";
+               } else {
+                       msg =3D "failed";
+                       overall_status =3D status;
+               }
+               printf("  %u) TestCase ECDH shared secret compute for Curve=
 %s %s\n",
+                      test_index ++, curve[curve_id], msg);
+       }
+
+       return overall_status;
+}
+
+
 static int
 test_sm2_sign(void)
 {
@@ -3987,6 +4082,7 @@ static struct unit_test_suite cryptodev_openssl_asym_=
testsuite  =3D {
                         ut_setup_asym, ut_teardown_asym,
                         modular_exponentiation, &modex_group_test_cases[7]=
),
                 TEST_CASE_ST(ut_setup_asym, ut_teardown_asym, test_eddsa_s=
ign_verify_all_curve),
+
                 TEST_CASES_END() /**< NULL terminate unit test array */
         }
 };
@@ -4023,6 +4119,19 @@ static struct unit_test_suite cryptodev_qat_asym_tes=
tsuite  =3D {
                         "RSA Decryption (n=3D128, pt=3D20, e=3D3) CRT, Pad=
ding: NONE",
                         ut_setup_asym, ut_teardown_asym,
                         kat_rsa_decrypt_crt, &rsa_vector_128_20_3_none),
+               TEST_CASE_NAMED_ST(
+                       "ECDH Eliptic Curve tests",
+                       ut_setup_asym, ut_teardown_asym,
+                       test_ecdh_qat_curves),
+               TEST_CASE_NAMED_ST(
+                       "ECPM Eliptic Curve tests",
+                       ut_setup_asym, ut_teardown_asym,
+                       test_ecpm_qat_curves),
+               TEST_CASE_NAMED_ST(
+                       "ECDSA Eliptic Curve tests",
+                       ut_setup_asym, ut_teardown_asym,
+                       test_ecdsa_sign_verify_qat_curves),
+
                 TEST_CASES_END() /**< NULL terminate unit test array */
         }
 };
--
2.50.1


--_000_DS0PR11MB74580123ED0D3A10642F8B3C8138ADS0PR11MB7458namp_
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
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);" class=3D"elementToProof">
Acked-by: Kai Ji &lt;kai.ji@intel.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Radu Nicolau &lt;radu=
.nicolau@intel.com&gt;<br>
<b>Sent:</b> 27 August 2025 10:23<br>
<b>To:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
<b>Cc:</b> Nicolau, Radu &lt;radu.nicolau@intel.com&gt;; Akhil Goyal &lt;ga=
khil@marvell.com&gt;; Fan Zhang &lt;fanzhang.oss@gmail.com&gt;<br>
<b>Subject:</b> [PATCH 2/3] test/crypto: add QAT EC tests</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Add ECDH, ECPM and ECDSA tests for QAT<br>
<br>
Signed-off-by: Radu Nicolau &lt;radu.nicolau@intel.com&gt;<br>
---<br>
&nbsp;app/test/test_cryptodev_asym.c | 109 ++++++++++++++++++++++++++++++++=
+<br>
&nbsp;1 file changed, 109 insertions(+)<br>
<br>
diff --git a/app/test/test_cryptodev_asym.c b/app/test/test_cryptodev_asym.=
c<br>
index 20afb5e98b..c62329edff 100644<br>
--- a/app/test/test_cryptodev_asym.c<br>
+++ b/app/test/test_cryptodev_asym.c<br>
@@ -1715,6 +1715,29 @@ test_ecdsa_sign_verify_all_curve(void)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return overall_status;<br>
&nbsp;}<br>
&nbsp;<br>
+static int<br>
+test_ecdsa_sign_verify_qat_curves(void)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int status, overall_status =3D TEST_S=
UCCESS;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum curve curve_id;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int test_index =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *msg;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (curve_id =3D SECP256R1; curve_id=
 &lt;=3D SECP521R1; curve_id++) {<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; status =3D test_ecdsa_sign_verify(curve_id);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (status =3D=3D TEST_SUCCESS) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msg =3D &quot;su=
cceeded&quot;;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msg =3D &quot;fa=
iled&quot;;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; overall_status =
=3D status;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; printf(&quot;&nbsp; %u) TestCase Sign/Veriy Curve %s&nbsp; %s\n&=
quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test_index ++, curve[c=
urve_id], msg);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return overall_status;<br>
+}<br>
+<br>
&nbsp;static int<br>
&nbsp;test_ecpm(enum curve curve_id)<br>
&nbsp;{<br>
@@ -1881,6 +1904,28 @@ test_ecpm_all_curve(void)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return overall_status;<br>
&nbsp;}<br>
&nbsp;<br>
+static int<br>
+test_ecpm_qat_curves(void)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int status, overall_status =3D TEST_S=
UCCESS;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum curve curve_id;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int test_index =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *msg;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (curve_id =3D SECP256R1; curve_id=
 &lt;=3D SECP521R1; curve_id++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; status =3D test_ecpm(curve_id);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (status =3D=3D TEST_SUCCESS) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msg =3D &quot;su=
cceeded&quot;;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msg =3D &quot;fa=
iled&quot;;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; overall_status =
=3D status;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; printf(&quot;&nbsp; %u) TestCase EC Point Mul Curve %s&nbsp; %s\=
n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test_index ++, curve[c=
urve_id], msg);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return overall_status;<br>
+}<br>
+<br>
&nbsp;static int<br>
&nbsp;test_ecdh_priv_key_generate(enum curve curve_id)<br>
&nbsp;{<br>
@@ -2674,6 +2719,56 @@ test_ecdh_all_curve(void)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return overall_status;<br>
&nbsp;}<br>
&nbsp;<br>
+static int<br>
+test_ecdh_qat_curves(void)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int status, overall_status =3D TEST_S=
UCCESS;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum curve curve_id;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int test_index =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *msg;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (curve_id =3D SECP256R1; curve_id=
 &lt;=3D SECP521R1; curve_id++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; status =3D test_ecdh_pub_key_generate(curve_id);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (status =3D=3D TEST_SUCCESS) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msg =3D &quot;su=
cceeded&quot;;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else if (status =3D=3D TEST_SKIPPED) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msg =3D &quot;sk=
ipped&quot;;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msg =3D &quot;fa=
iled&quot;;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; overall_status =
=3D status;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; printf(&quot;&nbsp; %u) TestCase ECDH public key generation for =
Curve %s %s\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test_index ++, curve[c=
urve_id], msg);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (curve_id =3D SECP256R1; curve_id=
 &lt;=3D SECP521R1; curve_id++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; status =3D test_ecdh_pub_key_verify(curve_id);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (status =3D=3D TEST_SUCCESS) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msg =3D &quot;su=
cceeded&quot;;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msg =3D &quot;fa=
iled&quot;;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; overall_status =
=3D status;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; printf(&quot;&nbsp; %u) TestCase ECDH public key verification fo=
r Curve %s %s\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test_index ++, curve[c=
urve_id], msg);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (curve_id =3D SECP256R1; curve_id=
 &lt;=3D SECP521R1; curve_id++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; status =3D test_ecdh_shared_secret(curve_id);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (status =3D=3D TEST_SUCCESS) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msg =3D &quot;su=
cceeded&quot;;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msg =3D &quot;fa=
iled&quot;;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; overall_status =
=3D status;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; printf(&quot;&nbsp; %u) TestCase ECDH shared secret compute for =
Curve %s %s\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test_index ++, curve[c=
urve_id], msg);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return overall_status;<br>
+}<br>
+<br>
+<br>
&nbsp;static int<br>
&nbsp;test_sm2_sign(void)<br>
&nbsp;{<br>
@@ -3987,6 +4082,7 @@ static struct unit_test_suite cryptodev_openssl_asym_=
testsuite&nbsp; =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ut_se=
tup_asym, ut_teardown_asym,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; modul=
ar_exponentiation, &amp;modex_group_test_cases[7]),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; TEST_CASE_ST(ut_setup_asym, ut_teardown_asym, test_ed=
dsa_sign_verify_all_curve),<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; TEST_CASES_END() /**&lt; NULL terminate unit test arr=
ay */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;};<br>
@@ -4023,6 +4119,19 @@ static struct unit_test_suite cryptodev_qat_asym_tes=
tsuite&nbsp; =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot=
;RSA Decryption (n=3D128, pt=3D20, e=3D3) CRT, Padding: NONE&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ut_se=
tup_asym, ut_teardown_asym,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kat_r=
sa_decrypt_crt, &amp;rsa_vector_128_20_3_none),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; TEST_CASE_NAMED_ST(<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;ECDH Elipt=
ic Curve tests&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ut_setup_asym, u=
t_teardown_asym,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test_ecdh_qat_cu=
rves),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; TEST_CASE_NAMED_ST(<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;ECPM Elipt=
ic Curve tests&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ut_setup_asym, u=
t_teardown_asym,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test_ecpm_qat_cu=
rves),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; TEST_CASE_NAMED_ST(<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;ECDSA Elip=
tic Curve tests&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ut_setup_asym, u=
t_teardown_asym,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test_ecdsa_sign_=
verify_qat_curves),<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; TEST_CASES_END() /**&lt; NULL terminate unit test arr=
ay */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;};<br>
-- <br>
2.50.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DS0PR11MB74580123ED0D3A10642F8B3C8138ADS0PR11MB7458namp_--
