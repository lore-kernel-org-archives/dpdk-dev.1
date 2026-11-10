Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF51960A2608
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 15:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=akY9FTVc
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4506B40285;
	Tue, 10 Nov 2026 16:53:38 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTPS id EE8E540281
 for <dev@dpdk.org>; Tue, 10 Nov 2026 16:53:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794326017; x=1825862017;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=i/PWiwal8wHk9pG6/uACi9UQzysNtvytIBv4tlS/Cc0=;
 b=akY9FTVc6+xoIZ7J9/mfXa+mQTWlqLSLKjIAYlGucTp2ed0ZzbIzWEww
 YLYO0VnZW7SU+LMoe+wpd+4vz8hw6z7iWhHGhLgB3TYCmjDrKvjxL6JEw
 /7nrfE/NvcMnjRdOSmdXhVWU5fvavyKGLtyikNVmSl519ZxV5uIovXRa0
 dqQ41CBRzA9BjTXOtR39BiIEDKdq+J8UgFgGVaxu7Bdzp714ebt/DRdLw
 45zIAaOwu667Q8M9vZTIm0lkUFCqQ9AwvTQh7LrnNN6hO6+YATqPANkL3
 9REwtvb90jl85360YNsOKGx/DX1v0EYYLkYNJzLK3fhhJI9/BYaF7Xecj Q==;
X-CSE-ConnectionGUID: EIuTbcpfRG6dB3JgXQE7zA==
X-CSE-MsgGUID: kg+XFezXSU2Mzm9P9boTSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3109173"
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; d="scan'208,217";a="3109173"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 07:53:35 -0800
X-CSE-ConnectionGUID: 3wbrkQVQRa6JNjkITQYD8Q==
X-CSE-MsgGUID: aIkLQmWmTU2ky2bOHUqwAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; d="scan'208,217";a="8066674"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 07:53:35 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 07:53:34 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 10 Nov 2026 07:53:34 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.14) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 07:53:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=id2+etcuEGYw2X2a3Pc8vh6nIsaOcmFOmNAIsZTD887R1N63yitTtnhRNak7FYUa/CBrnaYPJj88CXE7Elu10riwqexrFk/jHUgsnmM8EjQYsc+UYdIzQE/xM+bmSnar+eIqDEFZWMa4fpy6aVr1jKNnSm99fCdNJphsnOl2iEiHZ+E9Z1Cqip0QhJ8NiMmSIhOb5gWSOsm0OJMoFShGMoBLiRNAMwuahqVYVOro1e380t65tMfELnurUpPLBXAt7qfaa+xtJIbIgCJ3/CkeTrrvVhbVBwubWWlNfSj7Z0jWAZZsazecFii+9iCw5xvP4lkozNgxS+iCo+XV06NUAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXFY5q/cAtifdI9wjiXL8fnTqutE5ERFTx48MYv2rzg=;
 b=w85L8FY87lyioiSKMbmRP976NpSPs0KWQqoB8xVka8kHRV0sFSHT7BB6KppHR1EwrtWq+YvFxqv8ZeLAeNLp5KToEvWJHwTZpWhHZ5qc8ldev/6x735JJbnYRwUIfQjCfiXaPlJertmaKJOdzFHociT3FNwtmHr+GKIZ3NJsE0Vr2+mJ5JhBK9x7NqQi4Pco3XY7fCLw34WUo7bqKd/7LoipLAmx5BTBBJW64rSU61nBH6uvkdFrlJk/T/0WQtKXmCvBmIyCcNa3zQnDgvGAvQZpyU4Q2WOb8VuB+fGQPXbSO25WdfzYBoPuPWhGzFAaS5DE5LDPNTr/aUVenTKoFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB6045.namprd11.prod.outlook.com (2603:10b6:408:17b::20)
 by SA1PR11MB8523.namprd11.prod.outlook.com (2603:10b6:806:3b5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 15:50:27 +0000
Received: from LV2PR11MB6045.namprd11.prod.outlook.com
 ([fe80::1f72:3d49:b6ba:91ae]) by LV2PR11MB6045.namprd11.prod.outlook.com
 ([fe80::1f72:3d49:b6ba:91ae%6]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 15:50:27 +0000
From: "Ji, Kai" <kai.ji@intel.com>
To: "Nicolau, Radu" <radu.nicolau@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Fan Zhang <fanzhang.oss@gmail.com>, Ashish Gupta <ashishg@marvell.com>
Subject: Re: [PATCH] compress/qat: add Gen 6 support
Thread-Topic: [PATCH] compress/qat: add Gen 6 support
Thread-Index: AQHdcSZfMy8EniFSpEqfVebKPGtqLbcnc/Uh
Date: Tue, 10 Nov 2026 15:50:27 +0000
Message-ID: <LV2PR11MB60459B9E8839EE18C6E94FD381722@LV2PR11MB6045.namprd11.prod.outlook.com>
References: <20261110151529.2966094-1-radu.nicolau@intel.com>
In-Reply-To: <20261110151529.2966094-1-radu.nicolau@intel.com>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6045:EE_|SA1PR11MB8523:EE_
x-ms-office365-filtering-correlation-id: 73283f8e-b8fa-4f42-d15d-08df3f42572a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|42112799006|38070700021|260925021911599003|260925022911599003|260925021311599003|11063799006|56012099006|261022113327099003|261021123027099003|261022075727099003|261021121427099003|261022105027099003|261021135927099003|261026121527099003|261028144727099003|10067099003|261102123227099003|261026140227099003|261009223027099003|22082099003|18002099003|6133799003|8096899003;
x-microsoft-antispam-message-info: /nCKH1DNwlF91/LI+ZbxiJQRn86yywz1/0tAlnWXBhMeiq8Rxsdr9IlD52VnuwgCOlIgzJRgC/0x7bw1aVRYPmNX8PjSS/VJrgLecypHoZjLPSbmoyRD+uiaunIAssV1b0cA4Kpgvoc3d/CRX46F5XNRpdwuJJvppzd0N7UGhwTkGOMQHOjjJq/OZZ/20uKKKrtV25aqab9hRGyV7Xw9cEsV58qKKPysp7d6Jr+WtJjzPKl7MvFR27VR2aDAHnepUDz0XFNhq0ep6JiODhd9UzWgZN9WvKJ24us5vN44QpZD8LDvncDnAbJ9htGaZyY3ytv7NGxRWeWNxmHR0EmDQa5Tl7daGrt/QXYCBXl12u9s2mPLm3i04DWR8D6yOAtyTYR/9aTTnUbLGqNXBaR+14Gu/brxZaDYrsBakgk+zY8sIWXvYdfn5oev2kCx4E7O+4y+GaK+Iy1aPSFKwy8t30msMneqrJvct6ZxtbATF6E4D3AJIYbkzrO7/GAfKwKXUfS2/bhNC/fFHsgH+nt3hJIhF/7PBnqoh8FKYKr1K4gyCEORRXxsVFJlvvaGC26o8XxhkyvviJOTIxHPm7vt0nyr1Y9dVaCMI4xpAx+BOJ89jTeTv8RJw0QhFMbWSJE3iiCFZR1V1Apf9FEf3muMZLgcUBSBb9TtBPrhLPSSNAzM3xy7GB125nhpwyw9/7oMA7PbPjxVsHgKCjy2YRBlxuKm633RCwqDGLUn8VTt1B8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB6045.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(42112799006)(38070700021)(260925021911599003)(260925022911599003)(260925021311599003)(11063799006)(56012099006)(261022113327099003)(261021123027099003)(261022075727099003)(261021121427099003)(261022105027099003)(261021135927099003)(261026121527099003)(261028144727099003)(10067099003)(261102123227099003)(261026140227099003)(261009223027099003)(22082099003)(18002099003)(6133799003)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?w68CO7kS6Vbq67V8EHHJe2/y1ye83CiM+QuyDI1G3rC1OdyF/ofsN1hOOi66?=
 =?us-ascii?Q?q/ax4hO/m1wRlKG43JmYB1QT9k1lSbMWpqmLYD4Mm10PXomcOocaIjXN2HfU?=
 =?us-ascii?Q?Pf5yfHbjeFFY9Amnrklf7oRZ1LSSnh/E9BMqShZbHQdhY1ozwXypri7xHCbT?=
 =?us-ascii?Q?GVi2la6swjR1yoKEmucO/mEqwbOlUIukgmxvrgAv8HcsMZBKtzhGaFtK0EyJ?=
 =?us-ascii?Q?wOp8wgk8YqVg+U9j4ZrEwnkO8zk4p1eyti71MOqy3gCIg9qlSQnEvx3Fl6wI?=
 =?us-ascii?Q?g66hrYZ+xb9mw8mC4Lo51J5iAWGs4DZvqKbF0qRKb1ASkPNO4INh5r9nKFTb?=
 =?us-ascii?Q?wBIr40oW0NlvmPmCxbygCHbth+UtWHi7sM93dZWzpxMu8mAzFjwYbq5av139?=
 =?us-ascii?Q?sg9w0Fzu31Ci7Au1SjVLJgcpfTjdcuuR4jELr2Mld9z3/i5cumJAvhGRKGQ+?=
 =?us-ascii?Q?YCEcmufa7fBxuTNdCSEM5x1HeoCgdBwfMGitTnw4sETDhJHBLlRGmW1coyJ8?=
 =?us-ascii?Q?JvMOzT15prPvaOx493Zx0dSvb9shUlVbq8N/pBjw4DzvmmWd5sNaD/cxA5Qu?=
 =?us-ascii?Q?Xo/iLhyQvgnOFkHpBPWG5xDttguBGK6R2uiES7Pg61JJOEKc/dmm9E9n2TuM?=
 =?us-ascii?Q?0NaTs3hJriX6iNr9GdwCYh9OKKxw+Qard1FHI84nL9Nti1YSNmCBVkZDgwWe?=
 =?us-ascii?Q?ErrEQ3j4f0D7JTtfV4g8jc83rfo0PmyEAQ8VXN0XajYuxVmKnEwmE2hr1RvJ?=
 =?us-ascii?Q?xSeL6RUXnzySsucqHpRc5IxYOuDbL9cgMDViHydUW7nXf39r/UyDslAzEnFr?=
 =?us-ascii?Q?nnksg7UgqKcPwnZThm1lstj8P+5THSGHzWPdW+JLjrv8qTB68/zWXKWzqAdi?=
 =?us-ascii?Q?/cgjSJCDT9aGCqPJeZ9t1O7vMwmN2wxXu47rbC9/tL5judsKVYmrvuHF0eBJ?=
 =?us-ascii?Q?XTGVbanT15h0/I/c47E+XklYPhI+e9nC8tOjjeq7iu8vR7fEL2vdKMLF24fJ?=
 =?us-ascii?Q?r/N15XXxk4M6O5wT0Zb+K6RKNz8BKoHC0cXmHAvUBDtvrraYOS5PPCpp/Mjh?=
 =?us-ascii?Q?IykR3BROCYSND4oLzdizh8vhranE/bOKMNQIAAFcTErNM1EfN51WugWkwiIE?=
 =?us-ascii?Q?I6RUNbIbG185ebJrl14FPYPKuUTgo/oYVkH4uf2U3MdWvhxOBYR6J2TdQOjv?=
 =?us-ascii?Q?6LbWaMJXCL7jTxjYT9WSnVSb3dspOS4WNTQCVgWNLpbWIw8CzsmcvotbuUAv?=
 =?us-ascii?Q?r0gacT3TgG/rWHwFD7a2cosyeUI0Ra8HcXRTtSTuAD+jqEi3ND0WjhWrJEqs?=
 =?us-ascii?Q?omdZ1mMpmLMV6JsnyamfR9g596xUopCxI/4lMlWhLXS6YYWBlB9LtEUJ6JOd?=
 =?us-ascii?Q?OPm1OSeSAi9MBU5nTzvRdLTJjcHGMLbNa3o2tKEqT/7ZnP9/xGL5ARXfy8PR?=
 =?us-ascii?Q?pB8OtEGjk7V01dNaAMVCVJg/iGNtYgZsqlg5Pkz+vt/pQAT/6CivuNQD0j3h?=
 =?us-ascii?Q?TzZquWLZrw8gYsfN/GPn5L/LEb0eabvH6znq2pIHif5uZXdjnB87x/77Y5At?=
 =?us-ascii?Q?BH+7UBBc21kuyhG0RLF5SOQoZ7D4EETXWTm1CbsUK8eDpkrBUKkoO5yZLBzi?=
 =?us-ascii?Q?v0abe8lQXYj0wj10QIxWCy9cXe0aOv7x4JKuFqOP+L/raOOYZJUupzSwwrQU?=
 =?us-ascii?Q?ZcDZxN1T+59QAU0DHImgqOB0hZoG4y4XsjF9j18Sdgt822M8?=
Content-Type: multipart/alternative;
 boundary="_000_LV2PR11MB60459B9E8839EE18C6E94FD381722LV2PR11MB6045namp_"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: eAl1UTIsSZ3zfWh8qMli5RAmEmLyB79G0mmbumX36/8H13yhNoK+q5DUoJnqepTPiF0RU5QADLZoTWfXNkwq/syaKbKXuFO0kLyhVQdeW85GxbGgUriugf5kt8w9cRtZeGTq0XNttgEktaCxcC7xByHRkskRazGAxaWbEbA5CglwyloPtibwHw0+F6pLMX89PfbqiGwZhNf3R6topBIJXI0YWPO8jS+9erVegqKuw7wtPzKFZQVt4IuKe6EsN2t+Sk/CTC5fhgFLsiLnz5HQLh+ECTDqieuEOJRHpwAFKRTQBG6nGuEJJugvQIRE/VgsYnQo16PoN8LP1IrkE1s7uw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6045.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73283f8e-b8fa-4f42-d15d-08df3f42572a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 15:50:27.2464 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s29J/fF801I/HFLeEMcixfTwuO78uvVtysMKAdg95R0Rzx+EWf9lh7/hg2CkVY+PPmwJ3Ft2scJXyRgh6eZA7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8523
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--_000_LV2PR11MB60459B9E8839EE18C6E94FD381722LV2PR11MB6045namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Kai Ji <kai.ji@intel.com>

________________________________
From: Nicolau, Radu <radu.nicolau@intel.com>
Sent: 10 November 2026 15:15
To: dev@dpdk.org <dev@dpdk.org>
Cc: Nicolau, Radu <radu.nicolau@intel.com>; Ji, Kai <kai.ji@intel.com>; Fan=
 Zhang <fanzhang.oss@gmail.com>; Ashish Gupta <ashishg@marvell.com>
Subject: [PATCH] compress/qat: add Gen 6 support

Add support for Gen 6 QAT compression devices.

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 doc/guides/compressdevs/qat_comp.rst         |   1 +
 doc/guides/cryptodevs/qat.rst                |   2 +-
 doc/guides/rel_notes/release_26_11.rst       |   4 +
 drivers/common/qat/meson.build               |   1 +
 drivers/common/qat/qat_adf/icp_qat_fw_comp.h |   5 +
 drivers/compress/qat/dev/qat_comp_pmd_gen6.c | 135 +++++++++++++++++++
 drivers/compress/qat/dev/qat_comp_pmd_gens.h |   8 ++
 drivers/compress/qat/qat_comp.c              |  21 ++-
 8 files changed, 175 insertions(+), 2 deletions(-)
 create mode 100644 drivers/compress/qat/dev/qat_comp_pmd_gen6.c

diff --git a/doc/guides/compressdevs/qat_comp.rst b/doc/guides/compressdevs=
/qat_comp.rst
index 78b1ad9c23..7c6c8e1074 100644
--- a/doc/guides/compressdevs/qat_comp.rst
+++ b/doc/guides/compressdevs/qat_comp.rst
@@ -15,6 +15,7 @@ support for the following hardware accelerator devices:
 * ``Intel QuickAssist Technology C3xxx``
 * ``Intel QuickAssist Technology DH895x``
 * ``Intel QuickAssist Technology 300xx``
+* ``Intel QuickAssist Technology 6xxx``


 Features
diff --git a/doc/guides/cryptodevs/qat.rst b/doc/guides/cryptodevs/qat.rst
index 27713913ae..8c118b3c5f 100644
--- a/doc/guides/cryptodevs/qat.rst
+++ b/doc/guides/cryptodevs/qat.rst
@@ -486,7 +486,7 @@ to see the full table)
    +-----+-----+-----+-----+----------+---------------+---------------+---=
---------+--------+------+--------+--------+
    | Yes | Yes | Yes | 5   | 420xx    | linux/6.8+    | qat_420xx     | 42=
0xx      | 4946   | 2    | 4947   | 16     |
    +-----+-----+-----+-----+----------+---------------+---------------+---=
---------+--------+------+--------+--------+
-   | Yes | Yes | No  | 6   | 6xxx     | linux/6.16+   | qat_6xxx      | 6x=
xx       | 4948   | 1    | 4949   | 16     |
+   | Yes | Yes | Yes | 6   | 6xxx     | linux/6.16+   | qat_6xxx      | 6x=
xx       | 4948   | 1    | 4949   | 16     |
    +-----+-----+-----+-----+----------+---------------+---------------+---=
---------+--------+------+--------+--------+

 * Note: Symmetric mixed crypto algorithms feature on Gen 2 works only with=
 IDZ driver version 4.9.0+
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/=
release_26_11.rst
index fdcf155e07..81971ee38a 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -59,6 +59,10 @@ New Features

   * Added support for Gen 6 QAT devices.

+* **Updated Intel QuickAssist Technology (QAT) compression driver.**
+
+  * Added support for Gen 6 QAT devices.
+

 Removed Items
 -------------
diff --git a/drivers/common/qat/meson.build b/drivers/common/qat/meson.buil=
d
index db792864a2..c7ad535c69 100644
--- a/drivers/common/qat/meson.build
+++ b/drivers/common/qat/meson.build
@@ -123,6 +123,7 @@ if qat_compress
             'dev/qat_comp_pmd_gen3.c',
             'dev/qat_comp_pmd_gen4.c',
             'dev/qat_comp_pmd_gen5.c',
+            'dev/qat_comp_pmd_gen6.c',
         ]
         sources +=3D files(join_paths(qat_compress_relpath, f))
     endforeach
diff --git a/drivers/common/qat/qat_adf/icp_qat_fw_comp.h b/drivers/common/=
qat/qat_adf/icp_qat_fw_comp.h
index da45cb8f7d..625fdc055f 100644
--- a/drivers/common/qat/qat_adf/icp_qat_fw_comp.h
+++ b/drivers/common/qat/qat_adf/icp_qat_fw_comp.h
@@ -20,6 +20,11 @@ enum icp_qat_fw_comp_cmd_id {
         /**< Delimiter type */
 };

+enum icp_qat_fw_comp_cmd_id_gen6 {
+       ICP_QAT_GEN6_FW_COMP_CMD_DEFLATE_COMP =3D 1,
+       ICP_QAT_GEN6_FW_COMP_CMD_DEFLATE_DECOMP =3D 2,
+};
+
 /**< Flag usage */

 #define ICP_QAT_FW_COMP_STATELESS_SESSION 0
diff --git a/drivers/compress/qat/dev/qat_comp_pmd_gen6.c b/drivers/compres=
s/qat/dev/qat_comp_pmd_gen6.c
new file mode 100644
index 0000000000..40be10b1ea
--- /dev/null
+++ b/drivers/compress/qat/dev/qat_comp_pmd_gen6.c
@@ -0,0 +1,135 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ */
+
+#include <rte_memzone.h>
+
+#include "qat_logs.h"
+#include "qat_comp.h"
+#include "qat_comp_pmd.h"
+#include "qat_comp_pmd_gens.h"
+#include "icp_qat_hw_gen4_comp.h"
+
+static const struct rte_compressdev_capabilities
+qat_gen6_comp_capabilities[] =3D {
+       {/* COMPRESSION - deflate */
+        .algo =3D RTE_COMP_ALGO_DEFLATE,
+        .comp_feature_flags =3D RTE_COMP_FF_MULTI_PKT_CHECKSUM |
+                               RTE_COMP_FF_CRC32_CHECKSUM |
+                               RTE_COMP_FF_ADLER32_CHECKSUM |
+                               RTE_COMP_FF_CRC32_ADLER32_CHECKSUM |
+                               RTE_COMP_FF_SHAREABLE_PRIV_XFORM |
+                               RTE_COMP_FF_HUFFMAN_DYNAMIC |
+                               RTE_COMP_FF_HUFFMAN_FIXED |
+                               RTE_COMP_FF_OOP_SGL_IN_SGL_OUT |
+                               RTE_COMP_FF_OOP_SGL_IN_LB_OUT |
+                               RTE_COMP_FF_OOP_LB_IN_SGL_OUT,
+        .window_size =3D {.min =3D 15, .max =3D 15, .increment =3D 0} },
+        RTE_COMP_END_OF_CAPABILITIES_LIST() };
+
+static struct rte_compressdev_ops qat_comp_ops_gen6 =3D {
+
+       /* Device related operations */
+       .dev_configure          =3D qat_comp_dev_config_gen4,
+       .dev_start              =3D qat_comp_dev_start,
+       .dev_stop               =3D qat_comp_dev_stop,
+       .dev_close              =3D qat_comp_dev_close,
+       .dev_infos_get          =3D qat_comp_dev_info_get,
+
+       .stats_get              =3D qat_comp_stats_get,
+       .stats_reset            =3D qat_comp_stats_reset,
+       .queue_pair_setup       =3D qat_comp_qp_setup,
+       .queue_pair_release     =3D qat_comp_qp_release,
+
+       /* Compression related operations */
+       .private_xform_create   =3D qat_comp_private_xform_create,
+       .private_xform_free     =3D qat_comp_private_xform_free,
+       .stream_create          =3D qat_comp_stream_create,
+       .stream_free            =3D qat_comp_stream_free
+};
+
+/* GEN6 specific. */
+int
+qat_comp_create_templates_gen6(struct qat_comp_xform *qat_xform,
+                              __rte_unused const struct rte_memzone *inter=
m_buff_mz,
+                              const struct rte_comp_xform *xform,
+                              __rte_unused const struct qat_comp_stream *s=
tream,
+                              enum rte_comp_op_type op_type,
+                              enum qat_device_gen qat_dev_gen)
+{
+       struct icp_qat_fw_comp_req *comp_req;
+       int res;
+
+       if (unlikely(qat_xform =3D=3D NULL)) {
+               QAT_LOG(ERR, "Session was not created for this device");
+               return -EINVAL;
+       }
+
+       /* Template below carries no stream state, so stateful ops would ru=
n stateless. */
+       if (unlikely(op_type =3D=3D RTE_COMP_OP_STATEFUL)) {
+               QAT_LOG(ERR, "QAT GEN6 PMD does not support stateful operat=
ions");
+               return -ENOTSUP;
+       }
+
+       comp_req =3D &qat_xform->qat_comp_req_tmpl;
+
+       /* Initialize header */
+       if (qat_xform->qat_comp_request_type =3D=3D QAT_COMP_REQUEST_FIXED_=
COMP_STATELESS ||
+           qat_xform->qat_comp_request_type =3D=3D QAT_COMP_REQUEST_DYNAMI=
C_COMP_STATELESS)
+               comp_req->comn_hdr.service_cmd_id =3D ICP_QAT_GEN6_FW_COMP_=
CMD_DEFLATE_COMP;
+       else if (qat_xform->qat_comp_request_type =3D=3D QAT_COMP_REQUEST_D=
ECOMPRESS)
+               comp_req->comn_hdr.service_cmd_id =3D ICP_QAT_GEN6_FW_COMP_=
CMD_DEFLATE_DECOMP;
+
+       comp_req->comn_hdr.service_type =3D ICP_QAT_FW_COMN_REQ_CPM_FW_COMP=
;
+
+       comp_req->comn_hdr.hdr_flags =3D
+           ICP_QAT_FW_COMN_HDR_FLAGS_BUILD(ICP_QAT_FW_COMN_REQ_FLAG_SET);
+
+       comp_req->comn_hdr.serv_specif_flags =3D 0;
+
+       comp_req->comn_hdr.comn_req_flags =3D ICP_QAT_FW_COMN_FLAGS_BUILD(
+               QAT_COMN_CD_FLD_TYPE_16BYTE_DATA, QAT_COMN_PTR_TYPE_FLAT);
+
+       res =3D qat_comp_gen_dev_ops[qat_dev_gen].qat_comp_set_slice_cfg_wo=
rd(
+                       qat_xform, xform, op_type,
+                       comp_req->cd_pars.sl.comp_slice_cfg_word);
+       if (res !=3D 0)
+               return res;
+
+       comp_req->comp_pars.initial_adler =3D 1;
+       comp_req->comp_pars.initial_crc32 =3D 0;
+       comp_req->comp_pars.req_par_flags =3D
+               (ICP_QAT_FW_COMP_BFINAL << ICP_QAT_FW_COMP_BFINAL_BITPOS);
+
+#if RTE_LOG_DP_LEVEL >=3D RTE_LOG_DEBUG
+       QAT_DP_HEXDUMP_LOG(DEBUG, "qat compression message template:", comp=
_req,
+                   sizeof(struct icp_qat_fw_comp_req));
+#endif
+       return 0;
+}
+
+static struct qat_comp_capabilities_info
+qat_comp_cap_get_gen6(struct qat_pci_device *qat_dev __rte_unused)
+{
+       struct qat_comp_capabilities_info capa_info =3D {
+               .data =3D qat_gen6_comp_capabilities,
+               .size =3D sizeof(qat_gen6_comp_capabilities)
+       };
+       return capa_info;
+}
+
+RTE_INIT(qat_comp_pmd_gen6_init)
+{
+       qat_comp_gen_dev_ops[QAT_GEN6].compressdev_ops =3D
+                       &qat_comp_ops_gen6;
+       qat_comp_gen_dev_ops[QAT_GEN6].qat_comp_get_capabilities =3D
+                       qat_comp_cap_get_gen6;
+       qat_comp_gen_dev_ops[QAT_GEN6].qat_comp_get_num_im_bufs_required =
=3D
+                       qat_comp_get_num_im_bufs_required_gen4;
+       qat_comp_gen_dev_ops[QAT_GEN6].qat_comp_get_ram_bank_flags =3D
+                       qat_comp_get_ram_bank_flags_gen4;
+       qat_comp_gen_dev_ops[QAT_GEN6].qat_comp_set_slice_cfg_word =3D
+                       qat_comp_set_slice_cfg_word_gen4;
+       qat_comp_gen_dev_ops[QAT_GEN6].qat_comp_get_feature_flags =3D
+                       qat_comp_get_features_gen1;
+}
diff --git a/drivers/compress/qat/dev/qat_comp_pmd_gens.h b/drivers/compres=
s/qat/dev/qat_comp_pmd_gens.h
index e329fe3e18..6a0b281abd 100644
--- a/drivers/compress/qat/dev/qat_comp_pmd_gens.h
+++ b/drivers/compress/qat/dev/qat_comp_pmd_gens.h
@@ -41,4 +41,12 @@ qat_comp_dev_config_gen4(struct rte_compressdev *dev,

 extern struct rte_compressdev_ops qat_comp_ops_gen1;

+int
+qat_comp_create_templates_gen6(struct qat_comp_xform *qat_xform,
+               const struct rte_memzone *interm_buff_mz,
+               const struct rte_comp_xform *xform,
+               const struct qat_comp_stream *stream,
+               enum rte_comp_op_type op_type,
+               enum qat_device_gen qat_dev_gen);
+
 #endif /* _QAT_COMP_PMD_GENS_H_ */
diff --git a/drivers/compress/qat/qat_comp.c b/drivers/compress/qat/qat_com=
p.c
index 559948a46a..35fa513631 100644
--- a/drivers/compress/qat/qat_comp.c
+++ b/drivers/compress/qat/qat_comp.c
@@ -18,6 +18,7 @@
 #include "qat_logs.h"
 #include "qat_comp.h"
 #include "qat_comp_pmd.h"
+#include "dev/qat_comp_pmd_gens.h"

 static void
 qat_comp_fallback_to_fixed(struct icp_qat_fw_comp_req *comp_req)
@@ -814,7 +815,7 @@ qat_comp_create_req_hdr(struct icp_qat_fw_comn_req_hdr =
*header,
 }

 static int
-qat_comp_create_templates(struct qat_comp_xform *qat_xform,
+qat_comp_create_templates_genx(struct qat_comp_xform *qat_xform,
                           const struct rte_memzone *interm_buff_mz,
                           const struct rte_comp_xform *xform,
                           const struct qat_comp_stream *stream,
@@ -933,6 +934,24 @@ qat_comp_create_templates(struct qat_comp_xform *qat_x=
form,
         return 0;
 }

+static int
+qat_comp_create_templates(struct qat_comp_xform *qat_xform,
+                         const struct rte_memzone *interm_buff_mz,
+                         const struct rte_comp_xform *xform,
+                         const struct qat_comp_stream *stream,
+                         enum rte_comp_op_type op_type,
+                         enum qat_device_gen qat_dev_gen)
+{
+       if (qat_dev_gen =3D=3D QAT_GEN6)
+               return qat_comp_create_templates_gen6(qat_xform,
+                       interm_buff_mz, xform, stream, op_type,
+                       qat_dev_gen);
+
+       return qat_comp_create_templates_genx(qat_xform,
+                       interm_buff_mz, xform, stream, op_type,
+                       qat_dev_gen);
+}
+
 /**
  * Create driver private_xform data.
  *
--
2.52.0


--_000_LV2PR11MB60459B9E8839EE18C6E94FD381722LV2PR11MB6045namp_
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Nicolau, Radu &lt;rad=
u.nicolau@intel.com&gt;<br>
<b>Sent:</b> 10 November 2026 15:15<br>
<b>To:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
<b>Cc:</b> Nicolau, Radu &lt;radu.nicolau@intel.com&gt;; Ji, Kai &lt;kai.ji=
@intel.com&gt;; Fan Zhang &lt;fanzhang.oss@gmail.com&gt;; Ashish Gupta &lt;=
ashishg@marvell.com&gt;<br>
<b>Subject:</b> [PATCH] compress/qat: add Gen 6 support</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Add support for Gen 6 QAT compression devices.<br>
<br>
Signed-off-by: Radu Nicolau &lt;radu.nicolau@intel.com&gt;<br>
---<br>
&nbsp;doc/guides/compressdevs/qat_comp.rst&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; |&nbsp;&nbsp; 1 +<br>
&nbsp;doc/guides/cryptodevs/qat.rst&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 2 +-<br>
&nbsp;doc/guides/rel_notes/release_26_11.rst&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; |&nbsp;&nbsp; 4 +<br>
&nbsp;drivers/common/qat/meson.build&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 1 +<br>
&nbsp;drivers/common/qat/qat_adf/icp_qat_fw_comp.h |&nbsp;&nbsp; 5 +<br>
&nbsp;drivers/compress/qat/dev/qat_comp_pmd_gen6.c | 135 ++++++++++++++++++=
+<br>
&nbsp;drivers/compress/qat/dev/qat_comp_pmd_gens.h |&nbsp;&nbsp; 8 ++<br>
&nbsp;drivers/compress/qat/qat_comp.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 21 ++-<br>
&nbsp;8 files changed, 175 insertions(+), 2 deletions(-)<br>
&nbsp;create mode 100644 drivers/compress/qat/dev/qat_comp_pmd_gen6.c<br>
<br>
diff --git a/doc/guides/compressdevs/qat_comp.rst b/doc/guides/compressdevs=
/qat_comp.rst<br>
index 78b1ad9c23..7c6c8e1074 100644<br>
--- a/doc/guides/compressdevs/qat_comp.rst<br>
+++ b/doc/guides/compressdevs/qat_comp.rst<br>
@@ -15,6 +15,7 @@ support for the following hardware accelerator devices:<b=
r>
&nbsp;* ``Intel QuickAssist Technology C3xxx``<br>
&nbsp;* ``Intel QuickAssist Technology DH895x``<br>
&nbsp;* ``Intel QuickAssist Technology 300xx``<br>
+* ``Intel QuickAssist Technology 6xxx``<br>
&nbsp;<br>
&nbsp;<br>
&nbsp;Features<br>
diff --git a/doc/guides/cryptodevs/qat.rst b/doc/guides/cryptodevs/qat.rst<=
br>
index 27713913ae..8c118b3c5f 100644<br>
--- a/doc/guides/cryptodevs/qat.rst<br>
+++ b/doc/guides/cryptodevs/qat.rst<br>
@@ -486,7 +486,7 @@ to see the full table)<br>
&nbsp;&nbsp;&nbsp; +-----+-----+-----+-----+----------+---------------+----=
-----------+------------+--------+------+--------+--------+<br>
&nbsp;&nbsp;&nbsp; | Yes | Yes | Yes | 5&nbsp;&nbsp; | 420xx&nbsp;&nbsp;&nb=
sp; | linux/6.8+&nbsp;&nbsp;&nbsp; | qat_420xx&nbsp;&nbsp;&nbsp;&nbsp; | 42=
0xx&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 4946&nbsp;&nbsp; | 2&nbsp;&nbsp;&nbsp; =
| 4947&nbsp;&nbsp; | 16&nbsp;&nbsp;&nbsp;&nbsp; |<br>
&nbsp;&nbsp;&nbsp; +-----+-----+-----+-----+----------+---------------+----=
-----------+------------+--------+------+--------+--------+<br>
-&nbsp;&nbsp; | Yes | Yes | No&nbsp; | 6&nbsp;&nbsp; | 6xxx&nbsp;&nbsp;&nbs=
p;&nbsp; | linux/6.16+&nbsp;&nbsp; | qat_6xxx&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 | 6xxx&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 4948&nbsp;&nbsp; | 1&nbsp;&nb=
sp;&nbsp; | 4949&nbsp;&nbsp; | 16&nbsp;&nbsp;&nbsp;&nbsp; |<br>
+&nbsp;&nbsp; | Yes | Yes | Yes | 6&nbsp;&nbsp; | 6xxx&nbsp;&nbsp;&nbsp;&nb=
sp; | linux/6.16+&nbsp;&nbsp; | qat_6xxx&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 6x=
xx&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 4948&nbsp;&nbsp; | 1&nbsp;&nbsp;&n=
bsp; | 4949&nbsp;&nbsp; | 16&nbsp;&nbsp;&nbsp;&nbsp; |<br>
&nbsp;&nbsp;&nbsp; +-----+-----+-----+-----+----------+---------------+----=
-----------+------------+--------+------+--------+--------+<br>
&nbsp;<br>
&nbsp;* Note: Symmetric mixed crypto algorithms feature on Gen 2 works only=
 with IDZ driver version 4.9.0+<br>
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/=
release_26_11.rst<br>
index fdcf155e07..81971ee38a 100644<br>
--- a/doc/guides/rel_notes/release_26_11.rst<br>
+++ b/doc/guides/rel_notes/release_26_11.rst<br>
@@ -59,6 +59,10 @@ New Features<br>
&nbsp;<br>
&nbsp;&nbsp; * Added support for Gen 6 QAT devices.<br>
&nbsp;<br>
+* **Updated Intel QuickAssist Technology (QAT) compression driver.**<br>
+<br>
+&nbsp; * Added support for Gen 6 QAT devices.<br>
+<br>
&nbsp;<br>
&nbsp;Removed Items<br>
&nbsp;-------------<br>
diff --git a/drivers/common/qat/meson.build b/drivers/common/qat/meson.buil=
d<br>
index db792864a2..c7ad535c69 100644<br>
--- a/drivers/common/qat/meson.build<br>
+++ b/drivers/common/qat/meson.build<br>
@@ -123,6 +123,7 @@ if qat_compress<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'd=
ev/qat_comp_pmd_gen3.c',<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'd=
ev/qat_comp_pmd_gen4.c',<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'd=
ev/qat_comp_pmd_gen5.c',<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'dev/qa=
t_comp_pmd_gen6.c',<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sources +=3D files(join_pa=
ths(qat_compress_relpath, f))<br>
&nbsp;&nbsp;&nbsp;&nbsp; endforeach<br>
diff --git a/drivers/common/qat/qat_adf/icp_qat_fw_comp.h b/drivers/common/=
qat/qat_adf/icp_qat_fw_comp.h<br>
index da45cb8f7d..625fdc055f 100644<br>
--- a/drivers/common/qat/qat_adf/icp_qat_fw_comp.h<br>
+++ b/drivers/common/qat/qat_adf/icp_qat_fw_comp.h<br>
@@ -20,6 +20,11 @@ enum icp_qat_fw_comp_cmd_id {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**&lt; Delimiter type */<=
br>
&nbsp;};<br>
&nbsp;<br>
+enum icp_qat_fw_comp_cmd_id_gen6 {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ICP_QAT_GEN6_FW_COMP_CMD_DEFLATE_COMP=
 =3D 1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ICP_QAT_GEN6_FW_COMP_CMD_DEFLATE_DECO=
MP =3D 2,<br>
+};<br>
+<br>
&nbsp;/**&lt; Flag usage */<br>
&nbsp;<br>
&nbsp;#define ICP_QAT_FW_COMP_STATELESS_SESSION 0<br>
diff --git a/drivers/compress/qat/dev/qat_comp_pmd_gen6.c b/drivers/compres=
s/qat/dev/qat_comp_pmd_gen6.c<br>
new file mode 100644<br>
index 0000000000..40be10b1ea<br>
--- /dev/null<br>
+++ b/drivers/compress/qat/dev/qat_comp_pmd_gen6.c<br>
@@ -0,0 +1,135 @@<br>
+/* SPDX-License-Identifier: BSD-3-Clause<br>
+ * Copyright(c) 2026 Intel Corporation<br>
+ */<br>
+<br>
+#include &lt;rte_memzone.h&gt;<br>
+<br>
+#include &quot;qat_logs.h&quot;<br>
+#include &quot;qat_comp.h&quot;<br>
+#include &quot;qat_comp_pmd.h&quot;<br>
+#include &quot;qat_comp_pmd_gens.h&quot;<br>
+#include &quot;icp_qat_hw_gen4_comp.h&quot;<br>
+<br>
+static const struct rte_compressdev_capabilities<br>
+qat_gen6_comp_capabilities[] =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {/* COMPRESSION - deflate */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .algo =3D RTE_COMP_ALGO_DEFLATE=
,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .comp_feature_flags =3D RTE_COM=
P_FF_MULTI_PKT_CHECKSUM |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_COMP_FF_CRC32_CHECKSUM |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_COMP_FF_ADLER32_CHECKSUM |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_COMP_FF_CRC32_ADLER32_CHECKSUM |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_COMP_FF_SHAREABLE_PRIV_XFORM |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_COMP_FF_HUFFMAN_DYNAMIC |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_COMP_FF_HUFFMAN_FIXED |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_COMP_FF_OOP_SGL_IN_SGL_OUT |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_COMP_FF_OOP_SGL_IN_LB_OUT |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_COMP_FF_OOP_LB_IN_SGL_OUT,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .window_size =3D {.min =3D 15, =
.max =3D 15, .increment =3D 0} },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_COMP_END_OF_CAPABILITIES_LI=
ST() };<br>
+<br>
+static struct rte_compressdev_ops qat_comp_ops_gen6 =3D {<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Device related operations */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dev_configure&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D qat_comp_dev_config_gen4,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dev_start&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D qat_comp_dev_start,=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dev_stop&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D qat_comp_dev_s=
top,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dev_close&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D qat_comp_dev_close,=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dev_infos_get&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D qat_comp_dev_info_get,<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .stats_get&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D qat_comp_stats_get,=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .stats_reset&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D qat_comp_stats_reset,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .queue_pair_setup&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; =3D qat_comp_qp_setup,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .queue_pair_release&nbsp;&nbsp;&nbsp;=
&nbsp; =3D qat_comp_qp_release,<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Compression related operations */<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .private_xform_create&nbsp;&nbsp; =3D=
 qat_comp_private_xform_create,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .private_xform_free&nbsp;&nbsp;&nbsp;=
&nbsp; =3D qat_comp_private_xform_free,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .stream_create&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D qat_comp_stream_create,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .stream_free&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D qat_comp_stream_free<br>
+};<br>
+<br>
+/* GEN6 specific. */<br>
+int<br>
+qat_comp_create_templates_gen6(struct qat_comp_xform *qat_xform,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; __rte_unused const struct rte_memzone *interm_buf=
f_mz,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; const struct rte_comp_xform *xform,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; __rte_unused const struct qat_comp_stream *stream=
,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; enum rte_comp_op_type op_type,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; enum qat_device_gen qat_dev_gen)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct icp_qat_fw_comp_req *comp_req;=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int res;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(qat_xform =3D=3D NULL)) =
{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; QAT_LOG(ERR, &quot;Session was not created for this device&quot;=
);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Template below carries no stream s=
tate, so stateful ops would run stateless. */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(op_type =3D=3D RTE_COMP_=
OP_STATEFUL)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; QAT_LOG(ERR, &quot;QAT GEN6 PMD does not support stateful operat=
ions&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -ENOTSUP;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; comp_req =3D &amp;qat_xform-&gt;qat_c=
omp_req_tmpl;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Initialize header */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (qat_xform-&gt;qat_comp_request_ty=
pe =3D=3D QAT_COMP_REQUEST_FIXED_COMP_STATELESS ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_xform-&gt=
;qat_comp_request_type =3D=3D QAT_COMP_REQUEST_DYNAMIC_COMP_STATELESS)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; comp_req-&gt;comn_hdr.service_cmd_id =3D ICP_QAT_GEN6_FW_COMP_CM=
D_DEFLATE_COMP;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (qat_xform-&gt;qat_comp_reque=
st_type =3D=3D QAT_COMP_REQUEST_DECOMPRESS)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; comp_req-&gt;comn_hdr.service_cmd_id =3D ICP_QAT_GEN6_FW_COMP_CM=
D_DEFLATE_DECOMP;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; comp_req-&gt;comn_hdr.service_type =
=3D ICP_QAT_FW_COMN_REQ_CPM_FW_COMP;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; comp_req-&gt;comn_hdr.hdr_flags =3D<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ICP_QAT_FW_CO=
MN_HDR_FLAGS_BUILD(ICP_QAT_FW_COMN_REQ_FLAG_SET);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; comp_req-&gt;comn_hdr.serv_specif_fla=
gs =3D 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; comp_req-&gt;comn_hdr.comn_req_flags =
=3D ICP_QAT_FW_COMN_FLAGS_BUILD(<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; QAT_COMN_CD_FLD_TYPE_16BYTE_DATA, QAT_COMN_PTR_TYPE_FLAT);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; res =3D qat_comp_gen_dev_ops[qat_dev_=
gen].qat_comp_set_slice_cfg_word(<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_xform, xform=
, op_type,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; comp_req-&gt;cd_=
pars.sl.comp_slice_cfg_word);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (res !=3D 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return res;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; comp_req-&gt;comp_pars.initial_adler =
=3D 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; comp_req-&gt;comp_pars.initial_crc32 =
=3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; comp_req-&gt;comp_pars.req_par_flags =
=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (ICP_QAT_FW_COMP_BFINAL &lt;&lt; ICP_QAT_FW_COMP_BFINAL_BITPOS);=
<br>
+<br>
+#if RTE_LOG_DP_LEVEL &gt;=3D RTE_LOG_DEBUG<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QAT_DP_HEXDUMP_LOG(DEBUG, &quot;qat c=
ompression message template:&quot;, comp_req,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(struct icp_qat_fw_comp_req));<br>
+#endif<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
+static struct qat_comp_capabilities_info<br>
+qat_comp_cap_get_gen6(struct qat_pci_device *qat_dev __rte_unused)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct qat_comp_capabilities_info cap=
a_info =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .data =3D qat_gen6_comp_capabilities,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .size =3D sizeof(qat_gen6_comp_capabilities)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return capa_info;<br>
+}<br>
+<br>
+RTE_INIT(qat_comp_pmd_gen6_init)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_comp_gen_dev_ops[QAT_GEN6].compre=
ssdev_ops =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;qat_comp_op=
s_gen6;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_comp_gen_dev_ops[QAT_GEN6].qat_co=
mp_get_capabilities =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_comp_cap_get=
_gen6;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_comp_gen_dev_ops[QAT_GEN6].qat_co=
mp_get_num_im_bufs_required =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_comp_get_num=
_im_bufs_required_gen4;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_comp_gen_dev_ops[QAT_GEN6].qat_co=
mp_get_ram_bank_flags =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_comp_get_ram=
_bank_flags_gen4;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_comp_gen_dev_ops[QAT_GEN6].qat_co=
mp_set_slice_cfg_word =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_comp_set_sli=
ce_cfg_word_gen4;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_comp_gen_dev_ops[QAT_GEN6].qat_co=
mp_get_feature_flags =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_comp_get_fea=
tures_gen1;<br>
+}<br>
diff --git a/drivers/compress/qat/dev/qat_comp_pmd_gens.h b/drivers/compres=
s/qat/dev/qat_comp_pmd_gens.h<br>
index e329fe3e18..6a0b281abd 100644<br>
--- a/drivers/compress/qat/dev/qat_comp_pmd_gens.h<br>
+++ b/drivers/compress/qat/dev/qat_comp_pmd_gens.h<br>
@@ -41,4 +41,12 @@ qat_comp_dev_config_gen4(struct rte_compressdev *dev,<br=
>
&nbsp;<br>
&nbsp;extern struct rte_compressdev_ops qat_comp_ops_gen1;<br>
&nbsp;<br>
+int<br>
+qat_comp_create_templates_gen6(struct qat_comp_xform *qat_xform,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; const struct rte_memzone *interm_buff_mz,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; const struct rte_comp_xform *xform,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; const struct qat_comp_stream *stream,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; enum rte_comp_op_type op_type,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; enum qat_device_gen qat_dev_gen);<br>
+<br>
&nbsp;#endif /* _QAT_COMP_PMD_GENS_H_ */<br>
diff --git a/drivers/compress/qat/qat_comp.c b/drivers/compress/qat/qat_com=
p.c<br>
index 559948a46a..35fa513631 100644<br>
--- a/drivers/compress/qat/qat_comp.c<br>
+++ b/drivers/compress/qat/qat_comp.c<br>
@@ -18,6 +18,7 @@<br>
&nbsp;#include &quot;qat_logs.h&quot;<br>
&nbsp;#include &quot;qat_comp.h&quot;<br>
&nbsp;#include &quot;qat_comp_pmd.h&quot;<br>
+#include &quot;dev/qat_comp_pmd_gens.h&quot;<br>
&nbsp;<br>
&nbsp;static void<br>
&nbsp;qat_comp_fallback_to_fixed(struct icp_qat_fw_comp_req *comp_req)<br>
@@ -814,7 +815,7 @@ qat_comp_create_req_hdr(struct icp_qat_fw_comn_req_hdr =
*header,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int<br>
-qat_comp_create_templates(struct qat_comp_xform *qat_xform,<br>
+qat_comp_create_templates_genx(struct qat_comp_xform *qat_xform,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; const struct rte_memzone *interm_buff_mz,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; const struct rte_comp_xform *xform,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; const struct qat_comp_stream *stream,<br>
@@ -933,6 +934,24 @@ qat_comp_create_templates(struct qat_comp_xform *qat_x=
form,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
+static int<br>
+qat_comp_create_templates(struct qat_comp_xform *qat_xform,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cons=
t struct rte_memzone *interm_buff_mz,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cons=
t struct rte_comp_xform *xform,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cons=
t struct qat_comp_stream *stream,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum=
 rte_comp_op_type op_type,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum=
 qat_device_gen qat_dev_gen)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (qat_dev_gen =3D=3D QAT_GEN6)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return qat_comp_create_templates_gen6(qat_xform,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interm_buff_mz, =
xform, stream, op_type,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_dev_gen);<br=
>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return qat_comp_create_templates_genx=
(qat_xform,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interm_buff_mz, =
xform, stream, op_type,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_dev_gen);<br=
>
+}<br>
+<br>
&nbsp;/**<br>
&nbsp; * Create driver private_xform data.<br>
&nbsp; *<br>
-- <br>
2.52.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_LV2PR11MB60459B9E8839EE18C6E94FD381722LV2PR11MB6045namp_--
