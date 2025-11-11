Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B88CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 14:44:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF879402C6;
	Tue, 11 Nov 2025 15:44:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id E5692402B0
 for <dev@dpdk.org>; Tue, 11 Nov 2025 15:44:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762872282; x=1794408282;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=faNn6P/+k9jUuLWsr5m9iOnVRJXRLTu7RgtL0wZL7iw=;
 b=gqxGa0ECpMgeiuVYXoWWPHRPL46D4/Tx2cwohrK18BlMPiATD4Nj+Rys
 AGap5GpwYcttrV//tXoCH+7DHLmoD1/+MuHltTVeOTJTWnjmam/mxCR/3
 2NF1jGWZDeWhYmGloq4bImudTjmwzXMl5OVIoZJwUpY5reL8iyThKc9cW
 ssx2DiywlV1GQX4jIKAx1xV5IZ2CVcP38QWgrwsvI01ICeCQbXQw8EidN
 8GT/2N/qABZQcf/VqtdmByGQy5V8bGHe5xfWUWV6dIfVT/dU8mP4SWOCd
 cstreAGWW2GhEzFNPJ5D3aMhfmCxr1jUmQhOFMgEXrXGmZEri8EwwYPPq w==;
X-CSE-ConnectionGUID: xrDGdjtFRvOo+I0Fdbml2A==
X-CSE-MsgGUID: IPri6iNhQoGa4/v2h5ISCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="65027361"
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; d="scan'208,217";a="65027361"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2025 06:44:41 -0800
X-CSE-ConnectionGUID: fcMcj9CJRR64CYU5vxRLhQ==
X-CSE-MsgGUID: vMSLXwnnRzmShpK2IrnSQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
 d="scan'208,217";a="193359286"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2025 06:44:41 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 11 Nov 2025 06:44:40 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 11 Nov 2025 06:44:40 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.49)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 11 Nov 2025 06:44:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eVUVQCy1AWMPwKxAN5J5GqmhmOtPFcEV4XRCa7ZTC4BCYzjljcXj19I30ubk7Fdb8CfNyavvulkYDnuGWdf+7EXXxbOZEj8CUmfWBlkuCGsLvA5ixAz4lkLYND0ANm+ZPDRvKol17CWHkBXrXWfTR7QLcMRNLeA2BKcoKOZteGE0YtWB+4m0EeKK/xp+/SPaOGZ3Nf52gozqUzaGblaDjM5UfAvBo1qiLyoYFAJy+xg7U/cnViu+PkXYTviDeB04+T055wUI/zyyLZAKke7BcZpt3oAha+Kg+JXNtl2x8xQU1MY7UOZa4coyoXAiimN/ifeOq8i4iFTHJgHPFFCorQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/397HXJRURmDiDRmAFCEfpozVOordBdGtm785yTPHVU=;
 b=y7nnt/V45sq9n2SR13KqJg9xTF5MMNx8tFhqVfv7vFN5YTq8MugJAZxXyEAd4JXasJ/IXsbaS8X2XHu7M/KU9lY+0B5dvDvFs4Ff2XHX7mh8Zm36v2+HrNQmSkPpUzfHCXi0/apRrZrdXArA4kuJTID+7Q6u+y11gN5cWupodVuQ9FKOZ/Z0/NDHGR/bP6/1nbFRQyb3o/kH1XQWeTZ2nSDDXUfUxSTpbE9Vo2+yEpWcizEZNt0Xh4YMEukVDFHIH/XGOCQ+1GpEa6D4W4xLbBHLSeyJvpVyBJDOur9e+SAfDm3WpmOyDhw5VqO8DfHJNzSaTI8OJMA7erZnxo1q4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7458.namprd11.prod.outlook.com (2603:10b6:8:145::13)
 by DM3PR11MB8758.namprd11.prod.outlook.com (2603:10b6:0:47::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 14:44:30 +0000
Received: from DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::6d78:37d8:c835:540]) by DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::6d78:37d8:c835:540%5]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 14:44:29 +0000
From: "Ji, Kai" <kai.ji@intel.com>
To: "Finn, Emma" <emma.finn@intel.com>, Akhil Goyal <gakhil@marvell.com>, "Fan
 Zhang" <fanzhang.oss@gmail.com>, "Trahe, Fiona" <fiona.trahe@intel.com>,
 Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [v2] crypto/qat: fix CCM request descriptor hash_state_sz field
Thread-Topic: [v2] crypto/qat: fix CCM request descriptor hash_state_sz field
Thread-Index: AQHcUmOzZsM9uiKJIEOCvtMb/Ov+lrTtjnVc
Date: Tue, 11 Nov 2025 14:44:29 +0000
Message-ID: <DS0PR11MB7458C0A1EE0B7FDDF2CD89CA81CFA@DS0PR11MB7458.namprd11.prod.outlook.com>
References: <20251107164329.2154794-1-emma.finn@intel.com>
 <20251110170107.2296951-1-emma.finn@intel.com>
In-Reply-To: <20251110170107.2296951-1-emma.finn@intel.com>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7458:EE_|DM3PR11MB8758:EE_
x-ms-office365-filtering-correlation-id: 772daefb-4186-4279-c3fb-08de2130d1f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|42112799006|8096899003|38070700021|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?M2PIW1X1hl7LKAJU9lC6eZunTNUo3iRj9WXc2+d6hYgL5ww8ksqOAxP5qqa4?=
 =?us-ascii?Q?AAI40zbPkAYNzWIyZbjcH6686rycZFUk8QY/Mi3YATSK+NZ+LbB9QtPOVe+l?=
 =?us-ascii?Q?J3obat5vBNVUSB5hHL4dAySTHVXyTLFaniRY40/QLJphVHpmjKuPYxd88sDw?=
 =?us-ascii?Q?HybS6XqC5EWZhnH7v9O4olBjjD6FfSRGWFDvBbhFoHwqVaH7Z4TvlSfE41me?=
 =?us-ascii?Q?SLQVisODhXu6gysShLVlt4mebIeoRhi0+E0owSHi1hcglCIkcBkfxzcaFidB?=
 =?us-ascii?Q?5CSJc13V1yimCAzg0KPb7BsXxTDSKDIOMKlQqYo7AUQnuHPSiKHbumxReWWn?=
 =?us-ascii?Q?KNMbKjLSISJMu8dFAlqFKx28Sh4WZfdNRf41VyOVlxNiybPmflWGw6aio8Ba?=
 =?us-ascii?Q?yEgBpXXJ8oTZOkttf+/Ta4rYrEzYQ51DDrXFtzpy/bsjN1QpiEkMteaXTMwN?=
 =?us-ascii?Q?+5nfV9j2Ye0qICM40Po/FwHnnyrXAhiW9L/ATCpdyfEGkb7RvPJEHPoJR8WS?=
 =?us-ascii?Q?SjoqeqNhpALorLokkA5iTFBWvYFzA2Vfa/Y3s1yF02rciV2JAGeHs49r8IMF?=
 =?us-ascii?Q?+14q44An3ihwP+/Ls136//zqzH/8ZxJzeeX2Qr0o/2/73sBX+v/rtpF5IF3o?=
 =?us-ascii?Q?2FM1wgbjE3/bEaLVLrLRKiwqLRuSnJqpBNT7QoFHxO+3xiObNUhtEPJrI6U+?=
 =?us-ascii?Q?/CghQI0Z9PQwqTWRg614UTGJo/pa5I2U3sXdcPoj6fUS4VdZWM/m+dKgIJOh?=
 =?us-ascii?Q?9qgureora4cuT+9KDEIQ3nZUgHNmRFWDCLiV/83zhU8c6I5CqTX71dh9MLje?=
 =?us-ascii?Q?oQaEfEgKmp90KKj0IyIdHzGWdDwrnuMXTc9kqSXxXGfWrB+GgHqX7apyDtR4?=
 =?us-ascii?Q?jqNq8ehBvQI6qrfC7MhyFfRyQLoGv+tNa8QJPIwH/xhJ5SqhNuLUSYEQX61/?=
 =?us-ascii?Q?cs4IXvp9lGiVzp5IKiBkiddvywm4fH9TlpnyZ15oA8BdpeJjzVR5UQQ6B6gj?=
 =?us-ascii?Q?1sMduHgw8dbrY9OfEDtcb3afkwLRPmbdpKYnZuUPm4DzRW4yqbHb6JqSZ2bZ?=
 =?us-ascii?Q?UM5sDpOzsoMhSR+My8vvr8DVEnFVV7dX+9ThmE7oHgRvkkFENoMKqXwew7bD?=
 =?us-ascii?Q?1Si898+aHCRHSFBeooORXSsa9eQ319ZI2GPszJdPFZGYdjuZlBIj1pznB+rp?=
 =?us-ascii?Q?xCX3iELFGOcjuhQ8+zBpYW3Xpr5NFelTCh+dmFrMPO7xNeHYPsWlsNAvfZgy?=
 =?us-ascii?Q?fSAekhhBpX5KjvvD6+xZ2EC/+3uuJaIv3LWTktNFTbdLH2m9BJ+XdFKtJMdw?=
 =?us-ascii?Q?yoD6eDNmCuSZr0MIbPit/F9MU7VxuB9DjYFqdq7zalgaPcNFtn+Zlnwx+MM2?=
 =?us-ascii?Q?J3+uCaT3oJKdnzP7ijAMdm6xNuUzIy/JmQNKi6WGp5qOGdUVEbGgrtAOB5uL?=
 =?us-ascii?Q?EnVtLKa5puqoKweTDJ3RlZk6tDzlP/7di3o6bHUpZ7vTgWM8mjt85gG+fAMe?=
 =?us-ascii?Q?VL9/ERYq5V2aph2Fiu/Tj23Y2E13i1AChTLm?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7458.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(42112799006)(8096899003)(38070700021)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QUsOfwiKoX6O5D5TeIOYMntvUBPEabGF9v2B+ZmWZ50X5lkWIgaf8QK9zdeU?=
 =?us-ascii?Q?SxHJraJdHQFXASMwao0bOH/Su+AnkTilvuJadn28VB8B6LTXcpGw7yh/btgK?=
 =?us-ascii?Q?AhXz04wjJN1qiCkX2yDczje0oLHLkMBot47AtuvMp30EKbRajwhyIjKr0Pin?=
 =?us-ascii?Q?EUPqRt8hCV7uizlM+7WyMMtzKJDQ3w7st+ZU8V5KtYoFIpyJRA7+rCfMX/0A?=
 =?us-ascii?Q?jerNHeo2Lct4DqGbW4/EzT331qOxsPBVi0ur9U2J4t+PDrldJqHEQqn1eY8d?=
 =?us-ascii?Q?+S79jjb5/0ahoxoGzW9rUNHPRbHcSZ3qrCtovEcsM6mcSmcHzR15j908DXWd?=
 =?us-ascii?Q?XcNZptXtguQ8azs6fCeNhGfJIE5RTrN2W/okP9ptt7ywmqTKVVL9XRSYhR5k?=
 =?us-ascii?Q?Pp1x+GsHqQSVoMzdaqbvw1Uy6bC4ABeQ/9SF4BoMagS+xj7Ut6hkVs48Pp36?=
 =?us-ascii?Q?Hn7/hNU7AF1uZ/w6BA5vcclFPRu6Prfa9lRuL04GmdwcBZXjypGWhBEtffTl?=
 =?us-ascii?Q?AZPl29MUYfe//O7SYE58sfkU1bkVSj9+M23OQ+1XEclegYjpWiZai7ijQo6z?=
 =?us-ascii?Q?gRdIGrUTzAAHbBDLoXcsC8tTa6tqon+ZtGqVu1dyoGFXRgklc3RIzJhOJkr9?=
 =?us-ascii?Q?N5k5oOzUj+DD5luHjesTuXAGOmSrvoNzKgzlkaCHFjiPYJKE8zM8M51HJtcW?=
 =?us-ascii?Q?dj4IWvR9u9WT+HrEci1HXooDDGzq00zdQeizLPmsRt8aOegPkJEGnEUUB820?=
 =?us-ascii?Q?Q4xEukYNSe8Ck2fAEy0FNF3aYnpYEblrb/Owo2b+ugRuaPkR6DrKjEPhAPQn?=
 =?us-ascii?Q?iCeVZ9vchjCFqKOUw6yeGMo+Y9+OF1/Zh8R//dZM7pCpLhYIy301d9H7/doF?=
 =?us-ascii?Q?ypO+ZIK16WU2vf3ogH6t5dmgbZN0oRnDa7JGnH5ZTfDOdZXK2xHO/jdaZFXt?=
 =?us-ascii?Q?oJ2w8eVjwZoQZTSXewnsUNPCVo43l1VEFwjgYv6DJVhme6d+oTw88DxAEKxK?=
 =?us-ascii?Q?5A/j4SrGeysiXjwyrQJ4uZ7Xd1ucbLPDDWhzkGAyLzMNRxXM9T8erxDzRpcH?=
 =?us-ascii?Q?a3c0RPQhuEWXHnNkJmwBu2ksIndaLVii9kKCaoJBZHjeCXoDtq9w6qeUOO9e?=
 =?us-ascii?Q?23/VemlCweaL+tSYXgB5XaNl+no2kEi+uT4M7TryvkzdvnbCIKebuUd4EUGW?=
 =?us-ascii?Q?9sSOZrP4ts+0fq/dkMXRo3TtrQVv49v7eWY5LCRssMkS52wpNzDiRNb1eg9F?=
 =?us-ascii?Q?/iPhw8oj2Vc/e3sX4oiLItUfuC3kA5+EXkMPueGFDsA43A0yZ4tiDhHY8s3d?=
 =?us-ascii?Q?VaS5gd6H9XvsbHeHI8JCCSKFbt/fUMeDzkpLRa2mzx1Oo6MZztDr6HkG/vnO?=
 =?us-ascii?Q?0Sk6vpVL7fgftuDkhCF74S/W/ERCMD5MAVO6h8J4B60YXtlSCYFTeczdH51C?=
 =?us-ascii?Q?NXWzsUl/HZdCbjS4Ab8ag6Wu8zPNey8LRpjp3UNh9ijI7GOUzRPrj+4/MYmS?=
 =?us-ascii?Q?YlwFWW0Gx0T4BbH4wCzUsbP3lrxWMueViz90HRKZieNvuJLQJRivkMDL/KEK?=
 =?us-ascii?Q?84ZZN8UxXp7uNqEvjxo=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR11MB7458C0A1EE0B7FDDF2CD89CA81CFADS0PR11MB7458namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7458.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 772daefb-4186-4279-c3fb-08de2130d1f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 14:44:29.7686 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6eI+33Amh8D7ZnKK4mXairiw8CGynAkMAP4ZXdTRXA0neWDIMH3hb3ZsEanz55HBKgHSWKJjnvPa86qjulf3cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8758
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

--_000_DS0PR11MB7458C0A1EE0B7FDDF2CD89CA81CFADS0PR11MB7458namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Kai Ji <kai.ji@intel.com>
________________________________
From: Finn, Emma <emma.finn@intel.com>
Sent: 10 November 2025 17:01
To: Akhil Goyal <gakhil@marvell.com>; Fan Zhang <fanzhang.oss@gmail.com>; J=
i, Kai <kai.ji@intel.com>; Trahe, Fiona <fiona.trahe@intel.com>; Arkadiusz =
Kusztal <arkadiuszx.kusztal@intel.com>
Cc: dev@dpdk.org <dev@dpdk.org>; Finn, Emma <emma.finn@intel.com>
Subject: [v2] crypto/qat: fix CCM request descriptor hash_state_sz field

The hash_state_sz field in the QAT request descriptor for AES-CCM
operations was incorrectly set to the digest length. According to
the QAT firmware specification, this field should contain the
length of AAD in quadwords for CCM operations.

This incorrect field value caused QAT firmware to return
INVALID_PARAMS errors for certain AAD buffer sizes. A new unit
test is also added to cover this case.

Fixes: ab56c4d9ed9a ("crypto/qat: support AES-CCM")

Signed-off-by: Emma Finn <emma.finn@intel.com>
---
v2:
* Updated to use 16-byte alignment.
---
 app/test/test_cryptodev.c                   | 16 +++++++
 app/test/test_cryptodev_aead_test_vectors.h | 53 +++++++++++++++++++++
 drivers/crypto/qat/qat_sym_session.c        |  3 +-
 3 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/app/test/test_cryptodev.c b/app/test/test_cryptodev.c
index 6e5f308e55..9bdd357727 100644
--- a/app/test/test_cryptodev.c
+++ b/app/test/test_cryptodev.c
@@ -14271,6 +14271,12 @@ test_AES_CCM_authenticated_encryption_test_case_12=
8_3(void)
         return test_authenticated_encryption(&ccm_test_case_128_3);
 }

+static int
+test_AES_CCM_authenticated_encryption_test_case_128_4(void)
+{
+       return test_authenticated_encryption(&ccm_test_case_128_4);
+}
+
 static int
 test_AES_CCM_authenticated_decryption_test_case_128_1(void)
 {
@@ -14289,6 +14295,12 @@ test_AES_CCM_authenticated_decryption_test_case_12=
8_3(void)
         return test_authenticated_decryption(&ccm_test_case_128_3);
 }

+static int
+test_AES_CCM_authenticated_decryption_test_case_128_4(void)
+{
+       return test_authenticated_decryption(&ccm_test_case_128_4);
+}
+
 static int
 test_AES_CCM_authenticated_encryption_test_case_192_1(void)
 {
@@ -18975,6 +18987,8 @@ static struct unit_test_suite cryptodev_aes_ccm_aut=
h_testsuite  =3D {
                         test_AES_CCM_authenticated_encryption_test_case_12=
8_2),
                 TEST_CASE_ST(ut_setup, ut_teardown,
                         test_AES_CCM_authenticated_encryption_test_case_12=
8_3),
+               TEST_CASE_ST(ut_setup, ut_teardown,
+                       test_AES_CCM_authenticated_encryption_test_case_128=
_4),

                 /** AES CCM Authenticated Decryption 128 bits key*/
                 TEST_CASE_ST(ut_setup, ut_teardown,
@@ -18983,6 +18997,8 @@ static struct unit_test_suite cryptodev_aes_ccm_aut=
h_testsuite  =3D {
                         test_AES_CCM_authenticated_decryption_test_case_12=
8_2),
                 TEST_CASE_ST(ut_setup, ut_teardown,
                         test_AES_CCM_authenticated_decryption_test_case_12=
8_3),
+               TEST_CASE_ST(ut_setup, ut_teardown,
+                       test_AES_CCM_authenticated_decryption_test_case_128=
_4),

                 /** AES CCM Authenticated Encryption 192 bits key */
                 TEST_CASE_ST(ut_setup, ut_teardown,
diff --git a/app/test/test_cryptodev_aead_test_vectors.h b/app/test/test_cr=
yptodev_aead_test_vectors.h
index 73bedaf557..6b9642e339 100644
--- a/app/test/test_cryptodev_aead_test_vectors.h
+++ b/app/test/test_cryptodev_aead_test_vectors.h
@@ -50,6 +50,13 @@ static uint8_t ccm_aad_test_2[22] =3D {
                 0xA5, 0xB8, 0xFC, 0xBA, 0x00, 0x00
 };

+static uint8_t ccm_aad_test_4[32] =3D {
+               0xD2, 0x3D, 0xBD, 0xF2, 0x13, 0xAA, 0xD5, 0x03,
+               0xDB, 0xA5, 0x3E, 0x44, 0xBB, 0x1E, 0xD7, 0x19,
+               0x65, 0x2F, 0x37, 0xA0, 0x97, 0xD6, 0x5F, 0x59,
+               0x0B, 0xD1, 0xE6, 0xA4, 0xCC, 0x50, 0xEB, 0x62
+};
+
 static uint8_t sm4_gcm_aad_test_2[] =3D {
                 0x3f, 0x89, 0x42, 0x20
 };
@@ -3714,6 +3721,52 @@ static const struct aead_test_data ccm_test_case_128=
_3 =3D {
         }
 };

+static const struct aead_test_data ccm_test_case_128_4 =3D {
+       .algo =3D RTE_CRYPTO_AEAD_AES_CCM,
+       .key =3D {
+               .data =3D {
+                       0x2F, 0x55, 0xF2, 0xF8, 0x4E, 0x66, 0x5E, 0x4B,
+                       0x1D, 0x56, 0x91, 0x62, 0x6C, 0xE7, 0xD4, 0xB8
+               },
+               .len =3D 16
+       },
+       .iv =3D {
+               .data =3D {
+                       0x2C, 0x39, 0xBE, 0x24, 0xAF, 0xF4, 0xC1, 0x0E,
+                       0x20, 0x26, 0x11, 0x49, 0x49
+               },
+               .len =3D 13
+       },
+       .aad =3D {
+               .data =3D ccm_aad_test_4,
+               .len =3D 32
+       },
+       .plaintext =3D {
+               .data =3D {
+                       0xF5, 0x2A, 0xEC, 0xEF, 0x88, 0x73, 0x10, 0x11,
+                       0xD0, 0x68, 0xCB, 0x8E, 0x82, 0xBE, 0xED, 0x68,
+                       0xC1, 0xC6, 0xF2, 0xA5, 0x9E, 0x99, 0xF6, 0x3D,
+                       0xDA, 0xEA, 0xA0, 0x49, 0xD0, 0xF4, 0x18, 0xC0
+               },
+               .len =3D 32
+       },
+       .ciphertext =3D {
+               .data =3D {
+                       0x0F, 0x7B, 0x8A, 0x0D, 0x79, 0xB6, 0x1C, 0x93,
+                       0x00, 0x26, 0x57, 0x52, 0xC8, 0x68, 0x30, 0xF6,
+                       0x92, 0xA4, 0x9C, 0x86, 0x5E, 0x77, 0x51, 0x9C,
+                       0x79, 0x15, 0x7C, 0xF3, 0x87, 0x27, 0x2A, 0x77
+               },
+               .len =3D 32
+       },
+       .auth_tag =3D {
+               .data =3D {
+                       0x64, 0x2F, 0x58, 0x61
+               },
+               .len =3D 4
+       }
+};
+
 /** AES-CCM-192 Test Vectors */
 static const struct aead_test_data ccm_test_case_192_1 =3D {
         .algo =3D RTE_CRYPTO_AEAD_AES_CCM,
diff --git a/drivers/crypto/qat/qat_sym_session.c b/drivers/crypto/qat/qat_=
sym_session.c
index 98ab82ffb3..2ba4fc0a3a 100644
--- a/drivers/crypto/qat/qat_sym_session.c
+++ b/drivers/crypto/qat/qat_sym_session.c
@@ -2774,7 +2774,8 @@ static int qat_sym_cd_auth_set(struct qat_sym_session=
 *cdesc,
                 hash->auth_counter.counter =3D 0;

                 hash_cd_ctrl->outer_prefix_sz =3D digestsize;
-               auth_param->hash_state_sz =3D digestsize;
+               auth_param->hash_state_sz =3D (RTE_ALIGN_CEIL(auth_param->u=
2.aad_sz,
+                                               ICP_QAT_HW_CCM_AAD_ALIGNMEN=
T) >> 3);

                 memcpy(cdesc->cd_cur_ptr + state1_size, authkey, authkeyle=
n);
                 break;
--
2.34.1


--_000_DS0PR11MB7458C0A1EE0B7FDDF2CD89CA81CFADS0PR11MB7458namp_
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Finn, Emma &lt;emma.f=
inn@intel.com&gt;<br>
<b>Sent:</b> 10 November 2025 17:01<br>
<b>To:</b> Akhil Goyal &lt;gakhil@marvell.com&gt;; Fan Zhang &lt;fanzhang.o=
ss@gmail.com&gt;; Ji, Kai &lt;kai.ji@intel.com&gt;; Trahe, Fiona &lt;fiona.=
trahe@intel.com&gt;; Arkadiusz Kusztal &lt;arkadiuszx.kusztal@intel.com&gt;=
<br>
<b>Cc:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;; Finn, Emma &lt;emma.finn@inte=
l.com&gt;<br>
<b>Subject:</b> [v2] crypto/qat: fix CCM request descriptor hash_state_sz f=
ield</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The hash_state_sz field in the QAT request descrip=
tor for AES-CCM<br>
operations was incorrectly set to the digest length. According to<br>
the QAT firmware specification, this field should contain the<br>
length of AAD in quadwords for CCM operations.<br>
<br>
This incorrect field value caused QAT firmware to return<br>
INVALID_PARAMS errors for certain AAD buffer sizes. A new unit<br>
test is also added to cover this case.<br>
<br>
Fixes: ab56c4d9ed9a (&quot;crypto/qat: support AES-CCM&quot;)<br>
<br>
Signed-off-by: Emma Finn &lt;emma.finn@intel.com&gt;<br>
---<br>
v2:<br>
* Updated to use 16-byte alignment.<br>
---<br>
&nbsp;app/test/test_cryptodev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 16 +++++=
++<br>
&nbsp;app/test/test_cryptodev_aead_test_vectors.h | 53 ++++++++++++++++++++=
+<br>
&nbsp;drivers/crypto/qat/qat_sym_session.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; |&nbsp; 3 +-<br>
&nbsp;3 files changed, 71 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/app/test/test_cryptodev.c b/app/test/test_cryptodev.c<br>
index 6e5f308e55..9bdd357727 100644<br>
--- a/app/test/test_cryptodev.c<br>
+++ b/app/test/test_cryptodev.c<br>
@@ -14271,6 +14271,12 @@ test_AES_CCM_authenticated_encryption_test_case_12=
8_3(void)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return test_authenticated_=
encryption(&amp;ccm_test_case_128_3);<br>
&nbsp;}<br>
&nbsp;<br>
+static int<br>
+test_AES_CCM_authenticated_encryption_test_case_128_4(void)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return test_authenticated_encryption(=
&amp;ccm_test_case_128_4);<br>
+}<br>
+<br>
&nbsp;static int<br>
&nbsp;test_AES_CCM_authenticated_decryption_test_case_128_1(void)<br>
&nbsp;{<br>
@@ -14289,6 +14295,12 @@ test_AES_CCM_authenticated_decryption_test_case_12=
8_3(void)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return test_authenticated_=
decryption(&amp;ccm_test_case_128_3);<br>
&nbsp;}<br>
&nbsp;<br>
+static int<br>
+test_AES_CCM_authenticated_decryption_test_case_128_4(void)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return test_authenticated_decryption(=
&amp;ccm_test_case_128_4);<br>
+}<br>
+<br>
&nbsp;static int<br>
&nbsp;test_AES_CCM_authenticated_encryption_test_case_192_1(void)<br>
&nbsp;{<br>
@@ -18975,6 +18987,8 @@ static struct unit_test_suite cryptodev_aes_ccm_aut=
h_testsuite&nbsp; =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test_=
AES_CCM_authenticated_encryption_test_case_128_2),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; TEST_CASE_ST(ut_setup, ut_teardown,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test_=
AES_CCM_authenticated_encryption_test_case_128_3),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; TEST_CASE_ST(ut_setup, ut_teardown,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test_AES_CCM_aut=
henticated_encryption_test_case_128_4),<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /** AES CCM Authenticated Decryption 128 bits key*/<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; TEST_CASE_ST(ut_setup, ut_teardown,<br>
@@ -18983,6 +18997,8 @@ static struct unit_test_suite cryptodev_aes_ccm_aut=
h_testsuite&nbsp; =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test_=
AES_CCM_authenticated_decryption_test_case_128_2),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; TEST_CASE_ST(ut_setup, ut_teardown,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test_=
AES_CCM_authenticated_decryption_test_case_128_3),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; TEST_CASE_ST(ut_setup, ut_teardown,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test_AES_CCM_aut=
henticated_decryption_test_case_128_4),<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /** AES CCM Authenticated Encryption 192 bits key */<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; TEST_CASE_ST(ut_setup, ut_teardown,<br>
diff --git a/app/test/test_cryptodev_aead_test_vectors.h b/app/test/test_cr=
yptodev_aead_test_vectors.h<br>
index 73bedaf557..6b9642e339 100644<br>
--- a/app/test/test_cryptodev_aead_test_vectors.h<br>
+++ b/app/test/test_cryptodev_aead_test_vectors.h<br>
@@ -50,6 +50,13 @@ static uint8_t ccm_aad_test_2[22] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; 0xA5, 0xB8, 0xFC, 0xBA, 0x00, 0x00<br>
&nbsp;};<br>
&nbsp;<br>
+static uint8_t ccm_aad_test_4[32] =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; 0xD2, 0x3D, 0xBD, 0xF2, 0x13, 0xAA, 0xD5, 0x03,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; 0xDB, 0xA5, 0x3E, 0x44, 0xBB, 0x1E, 0xD7, 0x19,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; 0x65, 0x2F, 0x37, 0xA0, 0x97, 0xD6, 0x5F, 0x59,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; 0x0B, 0xD1, 0xE6, 0xA4, 0xCC, 0x50, 0xEB, 0x62<br>
+};<br>
+<br>
&nbsp;static uint8_t sm4_gcm_aad_test_2[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; 0x3f, 0x89, 0x42, 0x20<br>
&nbsp;};<br>
@@ -3714,6 +3721,52 @@ static const struct aead_test_data ccm_test_case_128=
_3 =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;};<br>
&nbsp;<br>
+static const struct aead_test_data ccm_test_case_128_4 =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .algo =3D RTE_CRYPTO_AEAD_AES_CCM,<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .key =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .data =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x2F, 0x55, 0xF2=
, 0xF8, 0x4E, 0x66, 0x5E, 0x4B,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1D, 0x56, 0x91=
, 0x62, 0x6C, 0xE7, 0xD4, 0xB8<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .len =3D 16<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .iv =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .data =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x2C, 0x39, 0xBE=
, 0x24, 0xAF, 0xF4, 0xC1, 0x0E,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x20, 0x26, 0x11=
, 0x49, 0x49<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .len =3D 13<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .aad =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .data =3D ccm_aad_test_4,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .len =3D 32<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .plaintext =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .data =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xF5, 0x2A, 0xEC=
, 0xEF, 0x88, 0x73, 0x10, 0x11,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xD0, 0x68, 0xCB=
, 0x8E, 0x82, 0xBE, 0xED, 0x68,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xC1, 0xC6, 0xF2=
, 0xA5, 0x9E, 0x99, 0xF6, 0x3D,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xDA, 0xEA, 0xA0=
, 0x49, 0xD0, 0xF4, 0x18, 0xC0<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .len =3D 32<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ciphertext =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .data =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0F, 0x7B, 0x8A=
, 0x0D, 0x79, 0xB6, 0x1C, 0x93,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00, 0x26, 0x57=
, 0x52, 0xC8, 0x68, 0x30, 0xF6,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x92, 0xA4, 0x9C=
, 0x86, 0x5E, 0x77, 0x51, 0x9C,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x79, 0x15, 0x7C=
, 0xF3, 0x87, 0x27, 0x2A, 0x77<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .len =3D 32<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .auth_tag =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .data =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x64, 0x2F, 0x58=
, 0x61<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .len =3D 4<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+};<br>
+<br>
&nbsp;/** AES-CCM-192 Test Vectors */<br>
&nbsp;static const struct aead_test_data ccm_test_case_192_1 =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .algo =3D RTE_CRYPTO_AEAD_=
AES_CCM,<br>
diff --git a/drivers/crypto/qat/qat_sym_session.c b/drivers/crypto/qat/qat_=
sym_session.c<br>
index 98ab82ffb3..2ba4fc0a3a 100644<br>
--- a/drivers/crypto/qat/qat_sym_session.c<br>
+++ b/drivers/crypto/qat/qat_sym_session.c<br>
@@ -2774,7 +2774,8 @@ static int qat_sym_cd_auth_set(struct qat_sym_session=
 *cdesc,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; hash-&gt;auth_counter.counter =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; hash_cd_ctrl-&gt;outer_prefix_sz =3D digestsize;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; auth_param-&gt;hash_state_sz =3D digestsize;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; auth_param-&gt;hash_state_sz =3D (RTE_ALIGN_CEIL(auth_param-&gt;=
u2.aad_sz,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ICP_QAT_HW_CCM_AAD_ALI=
GNMENT) &gt;&gt; 3);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; memcpy(cdesc-&gt;cd_cur_ptr + state1_size, authkey, a=
uthkeylen);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DS0PR11MB7458C0A1EE0B7FDDF2CD89CA81CFADS0PR11MB7458namp_--
