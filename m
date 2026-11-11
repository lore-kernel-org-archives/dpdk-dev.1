Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14279606A32D
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Nov 2026 16:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QFcK3OMw
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C616341148;
	Wed, 11 Nov 2026 17:19:04 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTPS id 591FF41132
 for <dev@dpdk.org>; Wed, 11 Nov 2026 17:19:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794413943; x=1825949943;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=Y/P6AqC5VnTy3VzQCVrFWO5KgI2fVn+4n1g0OUStD9c=;
 b=QFcK3OMwNgODoPCU5VRs6aodSQYQIcYSGw23UzoZK0nYBBazCwE1z55J
 MSTeupfD4brHkRcuymdQzgWePaMqB5yeQdHz1rlbh9ZY0+mBe+LeJktX5
 mY9RNtRY3260QK/H4WcEQmBjCSaFOo4t8OJKkZGDKiEw/BVVvdjy1vP6e
 tHyekbWvN6UULyA42oMBCTXlldBRQGu0LbcuJ7Bv+qGT0ZqwDbjo1Ol8H
 nCCOo2N7vCQf/dfrD++4PvG/+LVxRgtLR64IGZmFVw2BPaYj+6p5BID8G
 NWm0xEmSmTW7Ye241IM/m4gZXbGYdrokwMaF0X8iGIbpHgemMTMwhhaJ6 Q==;
X-CSE-ConnectionGUID: eOFTBolvS0msVQ1hcl/00w==
X-CSE-MsgGUID: IdAugsq3T8eXj2CDUsLKuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3068250"
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; d="scan'208,217";a="3068250"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2026 08:19:01 -0800
X-CSE-ConnectionGUID: p2TwIXcRRvO6kz2xqrgXkQ==
X-CSE-MsgGUID: Rf4YoSuhSmiC02BYY7eLdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; d="scan'208,217";a="8329263"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2026 08:19:01 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 08:19:00 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 11 Nov 2026 08:19:00 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.3) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 08:18:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+2+Xj471/cMxem3utkVPdd6UBtIWLdlTilDPdrGtXutMHytWF5NGZHznevnft1/vYiGMvm7JykbmzkPSOxTzeC0JtEvGzQwmD7tM5j+0vqKZmEzcv4Ey4P0lpHfgRB/jQHTbeD+uP+RlqX/JKyUDZRuYHgD2AKfDmrpORfTkrTDJrGA5/m+bvDwl6GjEcPSf+NLLVeNluo2yGc3W6biUk4vkAcBi0rYSh/zQ+xpvE+M6iJ3zS1v+Dfe6/xBX0L2S5MjoryJS+7LA25upG1KoW7thdRRbyWBbBSLoC5wY+W57o7nhSHXyprsofrd8S9/3P8KzG6xqNJ7ZT2wOUQ4Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7Te41yLn7AmO0IsgVvJKaFgnuYAf0wCEdi5qd9V7qg=;
 b=btQPDES8PHc9mRSj2ynG1UOqzlCkX0UO5Fky3oaeN1evzsoNzaanCfFN2xvgnerBpYn6WUedeb6abx+45ZmcCJGTfZJDAF3/ZnIwHQzI1Z4i2FYVMs/TmjEMOoyLxOAOVTuMbcOZJAebteHoydYOrBf3cUqNoW9hOgyfZtK/2DnekdGuM6PzVh3seat8dYaGmi5ZA+iDIYI9fngbroUty8LIGNgr6EFe9kEQrYGU/sMemtOcfdArRvLIz6wsZoIKUJFEx8vdjtY6aTJZZWSV6wxEHf+vqTDVqepd9OaPkeeH0vj5aVQ/8sLrRrbC4g5SStie2d7zYbVLGUSV9YeNiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB6045.namprd11.prod.outlook.com (2603:10b6:408:17b::20)
 by CH3PR11MB665988.namprd11.prod.outlook.com (2603:10b6:610:365::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 16:18:57 +0000
Received: from LV2PR11MB6045.namprd11.prod.outlook.com
 ([fe80::1f72:3d49:b6ba:91ae]) by LV2PR11MB6045.namprd11.prod.outlook.com
 ([fe80::1f72:3d49:b6ba:91ae%6]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 16:18:57 +0000
From: "Ji, Kai" <kai.ji@intel.com>
To: "Nicolau, Radu" <radu.nicolau@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>
Subject: Re: [PATCH] test/crypto: add check for device capability flag
Thread-Topic: [PATCH] test/crypto: add check for device capability flag
Thread-Index: AQHdcc3n19fkZEomXkGzoqUwLlSY+bcpDQeI
Date: Wed, 11 Nov 2026 16:18:57 +0000
Message-ID: <LV2PR11MB6045A9F356B3E7C81B5B821981712@LV2PR11MB6045.namprd11.prod.outlook.com>
References: <20261111111412.3031042-1-radu.nicolau@intel.com>
In-Reply-To: <20261111111412.3031042-1-radu.nicolau@intel.com>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6045:EE_|CH3PR11MB665988:EE_
x-ms-office365-filtering-correlation-id: 2a873b9b-9c9b-405d-f987-08df400f7d2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|42112799006|38070700021|10067099003|11063799006|56012099006|261022105027099003|261022075727099003|261021121427099003|261021135927099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003|8096899003;
x-microsoft-antispam-message-info: wntlrvXdPDdHrsG1d0getBvC6QJsxCFZYYgFeIVGgDSCJ4eP7MYhrMoBeAxaMtig/v6IZcJYMS8atEEijKzp9D4rEOk3R97d066CGmC4qIZkoBECFYD3JNcvO75UgKQD0X8RtYmcaMiKKVdQgNsVL52YT5jtLioC2TE/xVVNQuGf8rjjH/vXh7fbkME0BKxRxrZgc8R+J3KWmsMfCubc7pk+xUBg/eAm90PdeqKJJUkPSNMkeeD6B5D1Aq5nUfzYU4ZSYyHraQdZEDwO/AWAdSwxj6v/wbEm9dAvNMJ6/WaqQCUky0lbeumZncp5FH/CzlPGFjRCM3S0AL9IZgXUYuJ5yWN32SSE8jImaLpYPcvqWvW2LCCfGums46+y1ceXuldfgZOQdFs43/Bhcx0U0P+RWUMri6QmLflxCsr7LkCImuz5PpCUY6+df8BLepsn9TMbv02iuwW5FfrEpUw3gDivsQxE9yTmkwrLK3TqA8JsA50KLzH/XROFrIZ5mMriXE/kCYMnoAZh3GCDcTtjBzrBrWZ4lOwYLhJ80DwyB0W6YSgReqiCea2qYxVKXBsQfchYuy5Fv3ubc3M5vhbXbSbo1zqThTS5lx222X0ir+Fe8mHXpfb0JiswUrIlI/ahj8R4bF7P+xj5ZZ1qNyPW5l5BDMmLLdZc7JgnTMKxcUaP2cnjJFFmTwFy8ycOGDXNzHYleNSQc9VdMuxPetQj0PO/HM5exaj68qtoP3Gj1qg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB6045.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(42112799006)(38070700021)(10067099003)(11063799006)(56012099006)(261022105027099003)(261022075727099003)(261021121427099003)(261021135927099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/AUg0ZiTolVBUI3X2bNlxd7mdkdXtOooUBHyyyN3FGNAsCi/Ohjr0wRCM4P0?=
 =?us-ascii?Q?Tfvd+E5490ZcV9o6uQTukh6wkTvjOBLE3Yqon5KPLLIV/qjxZKKybBU47JEC?=
 =?us-ascii?Q?agR0uLl4aDTSox+q6ObtLE/JpjuRmIn2osqNRIUreg264cP+uLn1Xj80hkMb?=
 =?us-ascii?Q?0wSiJRDMEUvN5sZaxEuARNodkVEumIfzZZRohXyZyGJfemGPCkbNjJ6M62mp?=
 =?us-ascii?Q?hQDgtkoEJkY2+gaRgOisy8LRQtd36b5BG3pt+d0zWksxFP8xgDd6IiGqFDO+?=
 =?us-ascii?Q?Le19bB2pkfY6zPKndifs1yyKr4oSoyx2bucIIMDg1rUSvvujZ9ht+GBrULFw?=
 =?us-ascii?Q?xSe/4BLh0iiv01BOXIa0a89WuSMGXGB6m03oE/m9Spox+Qfyrl4jjv6gh29s?=
 =?us-ascii?Q?jh5orbrkzzRftLq6b3qeQl7zkR6ONCHKtmRLakC50QmI9LJBed4NYbsp3g2G?=
 =?us-ascii?Q?lLsBRkhg1RoaORMa+sCthJObifCoWNWiw+o/eQDkISGSzZuNyF3T1GMVhzXc?=
 =?us-ascii?Q?AQKW8ODJOAOWYieXpuZgJg0zcdLlYEZv/FRVCwl8amrfh2KiIbWeoUu199dW?=
 =?us-ascii?Q?Vsra4FHKDWpaDh2ogo0Xuf5ZGj44tIuBT+wF42gfI2VyqH/Mm5TZfuIIA/AQ?=
 =?us-ascii?Q?i0FxP5OYQubiM4oFnOM07AAnVlOgij9AxZILVGp53p8H2lLEWNWD0BQOLf2J?=
 =?us-ascii?Q?igXEbW7oqW4ut9Q2LufoEQ9cyyCIYMxyysaxetF8scDMRdCoDuPnmm63DVSO?=
 =?us-ascii?Q?peUCrbljSDwB6DShmnhc/fH4ezCt9s1JvekfizoBKZvV8NmHi48aPd0Lh2u3?=
 =?us-ascii?Q?x0WvxgWkKFdhCnKrIfGSIJM9IkXdL+Myp56e9oF+jjBHL8RKMkPVMqKaZblp?=
 =?us-ascii?Q?YnqZ1iEL75KI4N7khm9gbP9QT7LiEEZ15zQhgmAFCgU8D+tN5WAlEJNj0EmA?=
 =?us-ascii?Q?ldcWcNhNNy44fJXiSGlSzWU6Vp3TfROR1BqHnxZrrF7E+NQYB4o8ARrz27Oh?=
 =?us-ascii?Q?H+MmHllqzBKU1oBmiGRN6mVI1m03vaxm2eD2jF5aZ+XTNNB7b4xdLu6N5Mmw?=
 =?us-ascii?Q?kxsYetKQVqPlt4s4l5c1sEJyoeobsZ1mGPxG7A7z87oUDfIswoi/ChLszGS9?=
 =?us-ascii?Q?Bk34bflGuomLz0etl17kOELbmP6wpiCRV3seQKVa+zc2BaLAtOAti5rn9isM?=
 =?us-ascii?Q?LmkVkktN9o50nSviJyonAiu8sTFhXeEdNPGRC2jeT0U41tHzpcqDHSRAvgrM?=
 =?us-ascii?Q?Hn7Qrby1LblmDwBYc6dBt4JuaQeDmFo8GBD9hT2cXCQfEC31PW3b1pV/t4a1?=
 =?us-ascii?Q?MRrLGffvWDeAZiTxBzQAOjPJ/BQLxFpGkvoqujfM00Ez5a1J52j85t19M9tj?=
 =?us-ascii?Q?X4s8bG+bSboNpXAJi4eo8W3mTUB2LpqWlNlbkxEg3qNB2GSSZ/OTI2kIAm8i?=
 =?us-ascii?Q?Hl31ZOUa2amzyTWfrtvLnBG5xmBrQ7pVwhe+s40RMt7xUF7g8A/jWhihcxEI?=
 =?us-ascii?Q?UubWlBWfOMJS//jgeCzV/KLJXiY4izgW5Pr81smaelC3zEircXzneHn0F0fR?=
 =?us-ascii?Q?U914asx2iKicXSwoMsC632le9MNfgcPMcqTF/9v7MTOgtnSOgIVMCe3Z2rif?=
 =?us-ascii?Q?7jULk2xQN4BOoSr6xiZorfBowkYeHN8OqMZ8aQTAUc4FPB/JUKzp/XNxOWRk?=
 =?us-ascii?Q?3tto8xvE+cBxTeFmh5aX2rz99PRu81aJYd+7YZeWSTEvJWgy?=
Content-Type: multipart/alternative;
 boundary="_000_LV2PR11MB6045A9F356B3E7C81B5B821981712LV2PR11MB6045namp_"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: WuOsiUXutceonhgEuCFkIRNr1sNI4rGqt6GiJgRbSfbMjQY1b2zhliLdXkrcLMsVthwcahOPhX9w0jrvZWbpiUYhwZvegLNs7zyx9TOVdY0YJIpXN5FueOrzUM6ipAvwSUIk2B16hUIA0AGa9auTv5nZq8jO/zNe0B6hI2VOv1UiagymdudkDutplhsOZ175tuUJskj6heuVGqsRv/TQW0HeIoOlWqTaw5R9j+J8C5mtL+piRVVFrdGgLImFgdxAxS5A6BrTFjHT66CSoKak35t/st0Xs8KrnE8SfTkRjJf9yRM3o7DsmzVWMgTBL/GilJT7csOFbn3g6PVgSIRAww==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6045.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a873b9b-9c9b-405d-f987-08df400f7d2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 16:18:57.8084 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JTzWVbQPDaEi4/6HSw0KXlWMWW6fzL1/4LUacSAWcV9rieCST1ldSktdcUlsQyMZBKwncU9TP1JhCzSQUA87VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB665988
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

--_000_LV2PR11MB6045A9F356B3E7C81B5B821981712LV2PR11MB6045namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Kai Ji <kai.ji@intel.com>

________________________________
From: Radu Nicolau <radu.nicolau@intel.com>
Sent: 11 November 2026 11:14
To: dev@dpdk.org <dev@dpdk.org>
Cc: Nicolau, Radu <radu.nicolau@intel.com>; Akhil Goyal <gakhil@marvell.com=
>; Fan Zhang <fanzhang.oss@gmail.com>
Subject: [PATCH] test/crypto: add check for device capability flag

Test cryptodev feature flags for operation chaining support.

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 app/test/test_cryptodev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/app/test/test_cryptodev.c b/app/test/test_cryptodev.c
index d8c64a13ae..5051ee7fae 100644
--- a/app/test/test_cryptodev.c
+++ b/app/test/test_cryptodev.c
@@ -8360,6 +8360,10 @@ test_mixed_auth_cipher(const struct mixed_cipher_aut=
h_test_data *tdata,

         uint64_t feat_flags =3D dev_info.feature_flags;

+       if (!(feat_flags & RTE_CRYPTODEV_FF_SYM_OPERATION_CHAINING)) {
+               printf("Device doesn't support operation chaining.\n");
+               return TEST_SKIPPED;
+       }
         if (!(feat_flags & RTE_CRYPTODEV_FF_DIGEST_ENCRYPTED)) {
                 printf("Device doesn't support digest encrypted.\n");
                 return TEST_SKIPPED;
--
2.52.0


--_000_LV2PR11MB6045A9F356B3E7C81B5B821981712LV2PR11MB6045namp_
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
<b>Sent:</b> 11 November 2026 11:14<br>
<b>To:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
<b>Cc:</b> Nicolau, Radu &lt;radu.nicolau@intel.com&gt;; Akhil Goyal &lt;ga=
khil@marvell.com&gt;; Fan Zhang &lt;fanzhang.oss@gmail.com&gt;<br>
<b>Subject:</b> [PATCH] test/crypto: add check for device capability flag</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Test cryptodev feature flags for operation chainin=
g support.<br>
<br>
Signed-off-by: Radu Nicolau &lt;radu.nicolau@intel.com&gt;<br>
---<br>
&nbsp;app/test/test_cryptodev.c | 4 ++++<br>
&nbsp;1 file changed, 4 insertions(+)<br>
<br>
diff --git a/app/test/test_cryptodev.c b/app/test/test_cryptodev.c<br>
index d8c64a13ae..5051ee7fae 100644<br>
--- a/app/test/test_cryptodev.c<br>
+++ b/app/test/test_cryptodev.c<br>
@@ -8360,6 +8360,10 @@ test_mixed_auth_cipher(const struct mixed_cipher_aut=
h_test_data *tdata,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t feat_flags =3D de=
v_info.feature_flags;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(feat_flags &amp; RTE_CRYPTODEV_=
FF_SYM_OPERATION_CHAINING)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; printf(&quot;Device doesn't support operation chaining.\n&quot;)=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return TEST_SKIPPED;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(feat_flags &amp; RTE=
_CRYPTODEV_FF_DIGEST_ENCRYPTED)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; printf(&quot;Device doesn't support digest encrypted.=
\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return TEST_SKIPPED;<br>
-- <br>
2.52.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_LV2PR11MB6045A9F356B3E7C81B5B821981712LV2PR11MB6045namp_--
