Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53247C0219E
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Feb 2025 10:48:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25484400D6;
	Mon, 17 Feb 2025 11:48:40 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 71B75400D5;
 Mon, 17 Feb 2025 11:48:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739789318; x=1771325318;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=LnSenGCvaFQZSRXTvDySj7KYONU1bGbjY22zZ9BdUX8=;
 b=ikkjwtHFSC6FD53/9nL4VXBf4qUJnkOL/HwqA13b6VTOgqnr//ko+4gN
 PTPNlctmxDtPm5ss9zBvNGtiPhXG5DBscYdswP1tu+p1q4phMMIY6dIpb
 tuXtpbeLZR6nGxeVmrc/y4WbvrmwfgFFRo5MTwlBSw3ZNIpPNjq9a0c8T
 u5Rbs2HMt+28YhrpF5DqOOivmeytQjzVbD3fjac/PRMSlfYfRW17/wFTQ
 qkWYx3rS+3tfu+IV84DiNwrzCp5UAoCSCAMCI26+yg1Xfsy64AHfwFdoO
 myQrvpw2PcUib4JXglh09duRKSwRZFoRo3qKJ/mxpYHOZHGA20/ZjhNrz Q==;
X-CSE-ConnectionGUID: QV4RNTbPTDqLt360Y8FTBw==
X-CSE-MsgGUID: gLfmk+slTmeLoVmn4xkDwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="57996406"
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; d="scan'208,217";a="57996406"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2025 02:48:36 -0800
X-CSE-ConnectionGUID: kJViy1rXSoGytLyCkca3pw==
X-CSE-MsgGUID: J9SGsYQyRMWcsd+1T1VewA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
 d="scan'208,217";a="114712894"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2025 02:48:36 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 17 Feb 2025 02:48:35 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Feb 2025 02:48:35 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Feb 2025 02:48:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fjxtYI6Mwcf0Bjx5/a+5DcoSJCoDzMmkY7j1B9stQ7ziLpLGuUzs3U65T7VUFTGS71BikQ2Rd/6jAtCCYTCeJqudGAsjz4x+S4qYwkMDyd6AgczC3kHOVAcwtbuqR5g5CWIiFgyea+v8TCSHDaO+xI7EcQWxWC1gp/ifs1UAIelOesiZFoUDe4zYtI0D/qxVYys+OJOmxNoIM0o6Mfxzcal/bXDPrkyrgyXqKmuSrH0WiqVLGRPInnVHqnacZ26YUfuCJgSXoJes9f3BMjlFBRa/n0R57sDT1iFx9w9/MAMx4OTiuDJuMXknWPswyCZAws8Ur89NcF/YVWGUGxZBUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CwlI8fTXADG+uIs17sN0ETbMv4ad79puOdFQrOhz0pg=;
 b=G0EQ45QtSrq1YZLo/zxqByCPHdQULXwjT7RjS/C5EZ6rMXh+zBIstZ9gRoc/LS3NET+8toP4KVICCXOSVV82S9KBLmKZMtBHaC+x98HYk95cpCpid1o1xz1Acg9vmfAFaQL+UIOOPcXIbK0nWpmalzc7jiOuKexpk5FQG7MBZbIQksYJnKvqACqlDjyRs3FiHhN2aa2+zcKbbb/54U4xjj5YF2bdqmc1bshpyPq1xURUtqVPhVIMYeFyYNBVx/ZZ/FBGb1lr0BWLy6vEBjed/ifKzw2At3Ry617NQr+5EEivsme5JE+nxb/cJnHtk7w+TGMRlM/3zK0TfqvueG8zZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7458.namprd11.prod.outlook.com (2603:10b6:8:145::13)
 by IA1PR11MB7824.namprd11.prod.outlook.com (2603:10b6:208:3f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Mon, 17 Feb
 2025 10:47:52 +0000
Received: from DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::1a9e:53a6:9603:8f79]) by DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::1a9e:53a6:9603:8f79%7]) with mapi id 15.20.8445.016; Mon, 17 Feb 2025
 10:47:52 +0000
From: "Ji, Kai" <kai.ji@intel.com>
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>, Akhil Goyal <gakhil@marvell.com>, Fan Zhang
 <fanzhang.oss@gmail.com>
CC: "anoobj@marvell.com" <anoobj@marvell.com>, "stable@dpdk.org"
 <stable@dpdk.org>
Subject: Re: [PATCH] crypto/openssl: validate incorrect signature in verify op
Thread-Topic: [PATCH] crypto/openssl: validate incorrect signature in verify op
Thread-Index: AQHbgH93LA4jocsjDUm491zDGw1CrrNLUFyO
Date: Mon, 17 Feb 2025 10:47:52 +0000
Message-ID: <DS0PR11MB745813B2C7CF3717F0E69F7A81FB2@DS0PR11MB7458.namprd11.prod.outlook.com>
References: <20250216142822.1508-1-gmuthukrishn@marvell.com>
In-Reply-To: <20250216142822.1508-1-gmuthukrishn@marvell.com>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7458:EE_|IA1PR11MB7824:EE_
x-ms-office365-filtering-correlation-id: c8bd3ade-699c-4f1b-2833-08dd4f408740
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007|8096899003; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?M5mQQxzREKgNLIs7Qu8r6F6BH4vPjTeM8ScibLv6xz/9XK51zErO7ZSn1y?=
 =?iso-8859-1?Q?rFCQrQOLjvLRD69EPiWiGjnqH8/Xj0HqVrzUKB7X8SosHA9qxl3jNJqkeq?=
 =?iso-8859-1?Q?juSpSagaBaTon4e2zPJfiQzdR3Bfzz1WmAlhu5dedpkCyY07TCNFCxgWYP?=
 =?iso-8859-1?Q?6oSdVC8i8Zv+Kpz7O3PXSVLCm/tPVIYrbgNQSJf2mRTgJhaPt6pEEJU5FM?=
 =?iso-8859-1?Q?A2u6JfezNOemS38MSyPMPZgvtQpZeU+E05r0J0tzPQCwI9+0XKzEB85+6P?=
 =?iso-8859-1?Q?wZUSTClOwwsKKBlk42Hkmym+SZS32g4WflRADaMCoOaXVU4+0ed2oKAp4b?=
 =?iso-8859-1?Q?V6gz/+SRA5xYFlmUpKfHuQgjo+5t1WBeOU9HUMaAnSjB3hBVd3pyNyVsvL?=
 =?iso-8859-1?Q?dubR24IT8BHqyNpsDcwqvTFro0XYKZGZwBNow1/lStTcp8KFuLhPQJFt4S?=
 =?iso-8859-1?Q?tGc7md5Tq3WRTJidnDCUHLP2ciIa4tu/2Nnx11U37lzWE5Am1Qq8+iX6ry?=
 =?iso-8859-1?Q?0uSemOFPdNlT1dKvBfQ7kHgQjUL1+M8z4kP/Lgm7zH063HN9msMYMZsQjJ?=
 =?iso-8859-1?Q?snoa4TyB16olYdyo1SclEuEByFRsjgQdWDKvvDmD9Wk0UvrEg7A4rtjQK9?=
 =?iso-8859-1?Q?swQMgIMfWWbWvd7zsESAQ4gm5CsDYeAgS2vEB+aVv6K/nPTuvzHMf1N1NK?=
 =?iso-8859-1?Q?CsmEYijQ8123++EeEi0cqndtYzaFn8HA6oGQiUHko2BXACT50VTDBdv7+n?=
 =?iso-8859-1?Q?eGhF9m25rX7NdCZBIRZ5DXqYotOwqHvcMoTevR4gYEMDgbp1R/LC+OMxgi?=
 =?iso-8859-1?Q?r4VKVTuh6y8e3qEmUdy9VcuNArvvkP6fb5oqTPuydXOI1kzwAoNM4LPJIh?=
 =?iso-8859-1?Q?eia+5ycNPQjk98NC1cAl4cqZK0tM7KBLP2x56A+SjIWSSR+YUSrbpcrHtV?=
 =?iso-8859-1?Q?h2w++1/eIH6jFtb3nb0RJbfNGHAsflnEMfXyaYK4ihB5kNl4/EbvDO//6X?=
 =?iso-8859-1?Q?SUAB5As4lDyR4SSe50SneWY5BOI9AkAhg++6eSod0uuLd8UrzHme9L/0rA?=
 =?iso-8859-1?Q?eC04hbrHPsE9E/7+zhx37PR+MtwEJWpv3B7N5efqRtS6kvxMwYI0T1ckw5?=
 =?iso-8859-1?Q?Coq79v8FtSPMOA2scpPpmXYlB2UQFWyX4tyrG/57a8As3qkeG8wCy0Snx+?=
 =?iso-8859-1?Q?/KzBztgELASmwTC6UWy4QBVK0A7hyIQT7anDt5jbVY0lzTvdKwm82Qg/k5?=
 =?iso-8859-1?Q?aVFbQwRNkJP6NsyNc2/WtJPrqQuySFCxxj8jyM/2YBoYfe6Fu49vrOXnmY?=
 =?iso-8859-1?Q?MbbojLFj00K+UG6vKBO1dtZvu1LqcX+U+8ojdXZhTKzOW1PFw7Do3J0S3J?=
 =?iso-8859-1?Q?ldAl7AlYTeABJIXE92JUJ3OYgHyWWwuBPeUul3JhcepBmbL+ahLLS25rjQ?=
 =?iso-8859-1?Q?/1H9XLj7ajYbwpe9cX9wICKQUmfiFDWMsENxv/XfZYCPJSWsu+wfmpQSGv?=
 =?iso-8859-1?Q?GoQJ0h7FdZ1mIdFZKuig/R?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7458.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bbf3L0bffYglCBlKQwdhQJKM4/Un3BUTiYw3eRXHFAW75stmp0ggTRQ8NK?=
 =?iso-8859-1?Q?3eRdUfguFVm55BRxe/N1m8oaXyFcwDx1yEYmrktXaWXH7qQqM8NxBQy7iC?=
 =?iso-8859-1?Q?uJmdIhBVtGXEYE2+YOEwZa406kiEC+lBFkgkXsJer6I9nawojuc+W9Bhka?=
 =?iso-8859-1?Q?H8pWEjTQSo963unBzzNRHLqsMJy+5YO1uPRjpCFSsarQ2vmfP9qgHhbpzA?=
 =?iso-8859-1?Q?7PSXRTi9/aLcsLr2KBeIyk/T2EFPMubLZfNd3nmU3VgPsomsVxG2LymZwQ?=
 =?iso-8859-1?Q?XBuCy61YS0TXxq1WJeuWPo7eWn/+QacQbXPirhciO/gbxOudjzCJ5rpHEx?=
 =?iso-8859-1?Q?06jrvZumreEudM74X+KD60ZPhN4nTZSQNL6b4aPGYEZrFzQjZLv9Pommne?=
 =?iso-8859-1?Q?NV/ThH/2MSDM2ZlCBTiMzzhnvYrryfPKaUqkHIBnu8kcOeMBzxkxWrlq5b?=
 =?iso-8859-1?Q?X7c873EH2VXyFJ+CTf8er5X31vTXUWiT3jhQvNFBdi4H6y5cXGBoSGR+55?=
 =?iso-8859-1?Q?LTlRMVtLSHx/o25SaYa6zGtZdFuPP2hK/eR0f6NcYUDCklWZATzoFB4ZeZ?=
 =?iso-8859-1?Q?fDxSLiASnSjIs7QpXhPapTy6M+RMcSQxTpf+adHofBD6pfSm9v4TnGfhEu?=
 =?iso-8859-1?Q?mUFPScUaa+1IgEKToAWPEg/ASgzN5KNUTpZrNMl4Rc7XqGqJyIsrXLROy9?=
 =?iso-8859-1?Q?uPzAbs3xRdPM5ws1W3OKuY3t/Jt7c+oYptOX4pifkhI5llAPu98t7/XBbS?=
 =?iso-8859-1?Q?5lMhUOluqqybPRgH83Wj+MVeno6aYkeXFz1BHL2PTVHsN5tblHdRz0ww9W?=
 =?iso-8859-1?Q?nc5NVeRA48hl3US8etjMWz6BNYh/WlrxwWFWqhP/pAQgn7EG9qijeZu1qT?=
 =?iso-8859-1?Q?PcGE7DXU09Jc0tBsxAJc22fekg7VJcSGf+TkWDW1h426fqwmmW5LbnC80B?=
 =?iso-8859-1?Q?ZB47nhfxMuJjqm5wYGmhAH/sTNrcVoDmfGqpk5JGfW5GsVhMkSP/A5PK42?=
 =?iso-8859-1?Q?Apt93I+OUQ0LnqzgnjeoIt8ppPziqCEO6VRl0mr1cjD/5nhVzq9mI9u+mD?=
 =?iso-8859-1?Q?KgCNPQ4xD9rxRXs59kb90xhSqNpgMq1Lz0HZz8iYAvhzfcNklVkUKcmAf+?=
 =?iso-8859-1?Q?zESLhgxZzlb+35uQplj6umJL46JOvXyl1ORZWChdwsgoMWMlrstZmZC37g?=
 =?iso-8859-1?Q?uvW0G3xqDVAqvGpE+fY3Pa78SoemU5mZm57+kGhe+DP32m/XuVoS2Vfe2X?=
 =?iso-8859-1?Q?oHscJ3dnIblDRb+jrzxK5scLcyxm1W/1ZS3aRSnkFEfeBIbWtzuECI5aAM?=
 =?iso-8859-1?Q?YUwkwfi0ZTdeKNkxDROniqAvOdfzE0bPV4wlSHCw11LoIg6lBW2mVHjkNB?=
 =?iso-8859-1?Q?rHuOu8yYaYVtGWf0Td/Ee4yTbfOig/7hEcH2tOzdHZi0PSWUuY7f24TIGt?=
 =?iso-8859-1?Q?40GJ2jTrSQF41xSYL1ZybJ6WF5D6BQoM8gzsI+gqQXIIM4OCln9gEMATnV?=
 =?iso-8859-1?Q?4yjIdKmVIXEGML7fAvQmvYdi/EDjJVTM3tsUE33ot33xjnZ7O09PaPQAiJ?=
 =?iso-8859-1?Q?gYWkrwqplvBBUGU4Mpr7Nf5XgNE3DMcWHa+bgL54q7xnsJ9MvPFp3g7cJj?=
 =?iso-8859-1?Q?g9pJaYR2J9iOY=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR11MB745813B2C7CF3717F0E69F7A81FB2DS0PR11MB7458namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7458.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8bd3ade-699c-4f1b-2833-08dd4f408740
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2025 10:47:52.1792 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jrRCiOG9C4lRk0LjT4NY1gsNVuyUXUgyKcFK49kGcncYm4wscbqw5DAyidJ7oTinBjDmYUZ2MX0IcZ8Zpy6qrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7824
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

--_000_DS0PR11MB745813B2C7CF3717F0E69F7A81FB2DS0PR11MB7458namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable




________________________________
From: Gowrishankar Muthukrishnan
Sent: Sunday, February 16, 2025 14:28
To: dev@dpdk.org; Akhil Goyal; Ji, Kai; Fan Zhang
Cc: anoobj@marvell.com; Gowrishankar Muthukrishnan; stable@dpdk.org
Subject: [PATCH] crypto/openssl: validate incorrect signature in verify op

Return correct error status when incorrect signature is
used in RSA verify op.

Fixes: d7bd42f6db19 ("crypto/openssl: update RSA routine with 3.0 EVP API")
Cc: stable@dpdk.org

Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
---
 drivers/crypto/openssl/rte_openssl_pmd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/crypto/openssl/rte_openssl_pmd.c b/drivers/crypto/open=
ssl/rte_openssl_pmd.c
index b090611bd0..239688ed47 100644
--- a/drivers/crypto/openssl/rte_openssl_pmd.c
+++ b/drivers/crypto/openssl/rte_openssl_pmd.c
@@ -2710,6 +2710,8 @@ process_openssl_rsa_op_evp(struct rte_crypto_op *cop,
                 return ret;
         }

+       cop->status =3D RTE_CRYPTO_OP_STATUS_ERROR;
+
[Kai] I dont see any status need to be change between L.2694 to here, unles=
s I missing anyhere.

         switch (op->rsa.op_type) {
         case RTE_CRYPTO_ASYM_OP_ENCRYPT:
                 if (EVP_PKEY_encrypt_init(rsa_ctx) !=3D 1)
@@ -2807,6 +2809,7 @@ process_openssl_rsa_op_evp(struct rte_crypto_op *cop,
                                 op->rsa.sign.data,
                                 op->rsa.sign.length) <=3D 0) {
                         OPENSSL_free(tmp);
+                       ret =3D 0;
[Kai] Please add some comments why ret need to return 0
                         goto err_rsa;
                 }

--
2.25.1


--_000_DS0PR11MB745813B2C7CF3717F0E69F7A81FB2DS0PR11MB7458namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend" style=3D"color: inherit;"></div>
<div><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<span style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0);"><b>From:</b>&nbsp;Gowrishankar Muthukrishnan=
<br>
<b>Sent:</b>&nbsp;Sunday, February 16, 2025 14:28<br>
<b>To:</b>&nbsp;dev@dpdk.org; Akhil Goyal; Ji, Kai; Fan Zhang<br>
<b>Cc:</b>&nbsp;anoobj@marvell.com; Gowrishankar Muthukrishnan; stable@dpdk=
.org<br>
<b>Subject:</b>&nbsp;[PATCH] crypto/openssl: validate incorrect signature i=
n verify op
</span>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">Return correct err=
or status when incorrect signature is<br>
used in RSA verify op.<br>
<br>
Fixes: d7bd42f6db19 (&quot;crypto/openssl: update RSA routine with 3.0 EVP =
API&quot;)<br>
Cc: stable@dpdk.org<br>
<br>
Signed-off-by: Gowrishankar Muthukrishnan &lt;gmuthukrishn@marvell.com&gt;<=
br>
---<br>
&nbsp;drivers/crypto/openssl/rte_openssl_pmd.c | 3 +++<br>
&nbsp;1 file changed, 3 insertions(+)<br>
<br>
diff --git a/drivers/crypto/openssl/rte_openssl_pmd.c b/drivers/crypto/open=
ssl/rte_openssl_pmd.c<br>
index b090611bd0..239688ed47 100644<br>
--- a/drivers/crypto/openssl/rte_openssl_pmd.c<br>
+++ b/drivers/crypto/openssl/rte_openssl_pmd.c<br>
@@ -2710,6 +2710,8 @@ process_openssl_rsa_op_evp(struct rte_crypto_op *cop,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cop-&gt;status =3D RTE_CRYPTO_OP_STAT=
US_ERROR;<br>
+</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">[Kai] I dont see a=
ny status need to be change between L.2694 to here, unless I missing anyher=
e.&nbsp;</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;"><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (op-&gt;rsa.op_type=
) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RTE_CRYPTO_ASYM_OP_EN=
CRYPT:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (EVP_PKEY_encrypt_init(rsa_ctx) !=3D 1)<br>
@@ -2807,6 +2809,7 @@ process_openssl_rsa_op_evp(struct rte_crypto_op *cop,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; op-&gt;rsa.sign.data,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; op-&gt;rsa.sign.length) &lt;=3D =
0) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OPENS=
SL_free(tmp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D 0;</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">[Kai] Please add s=
ome comments why ret need to return 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto =
err_rsa;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
--<br>
2.25.1<br>
<br>
</div>
</body>
</html>

--_000_DS0PR11MB745813B2C7CF3717F0E69F7A81FB2DS0PR11MB7458namp_--
