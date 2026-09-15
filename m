Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA34C88E75
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 10:42:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 541D1411F3;
	Tue, 15 Sep 2026 12:42:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 09D8240A7A;
 Tue, 15 Sep 2026 12:42:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789468940; x=1821004940;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=iEhHnqg/hE6vusI79OS8Lyjg5pIEEaravOkfVuZUHW4=;
 b=fF4vAi+WwRJ1P91Us9luS05m5wuHGkp5+Atu/2ahNQ6eHh6TdXwkKtAU
 LGgg4y/KGlwKLzFcEe4oOlUSHpqxxD6OkIJyNrMyPCcE+cTNvgXsWoEzF
 Sf64uyKMEvS6BjbY4+ui6dooz8jXfBGs+ZHXYbOHW1/C6DPhS9/TOtnnh
 eJw1ILZC4ePOBq0VDKRn6gyuvm9WSUbuZg7UfqFWR1BzvyfHAInuYjiZE
 hqAy+70ttXMwpx7eoYrbpfQ+T8EV8S4BkH9mjQSacEfqn96ISxKddzMx9
 9Ss2Ba1YIlp7V9IOuG0ou7kL7Z5YbGRN91bS+RJW/PrZClcKshuake4zM A==;
X-CSE-ConnectionGUID: 7xFU/tETQBufFdK7eYPHOg==
X-CSE-MsgGUID: aUAkIQhrROuNAHxC+HW4TA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89960423"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89960423"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 03:42:19 -0700
X-CSE-ConnectionGUID: x7bZ3TzXTmm0uOb9ab1t+Q==
X-CSE-MsgGUID: hsFxEJMyRHmkQyHmCckOzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="270333139"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 03:42:19 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 03:42:18 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 03:42:18 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.45) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 03:42:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CPF8GNXmY3zM+NNBxO3F+NqHy+rKucYlaE0tkzr4GF3I/SeB+g29KVH7uh/jj6EpV9bZfFA0G+RQdup1WiGK/XbFcc3YI3taNK0uq/BtHiKXkGCQp783s0qCN9dO7jstc5Wv/VE1vHnGKhgRqfoYfbR3vgloEjLzkqCMIO+9d0vr+fyF6IOMiJHDtOAzpKXJ+Z6dS4mSA5XV00rs4HVyikH6v4TyLQn79C/EVSIpwrkRUt+XZxTepFiB+PWHvqEn0uBMo5PHvreBim7/htlwsFuQ9v/aX4ms/VQXiETgI7Q5dtnXtTuEpWqvwn4svNyyJ9gxbQpz42jYCEQtVG6aBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/EM644lmxMHxS36TZU/Kz6DUZCo17B06WrzXJgUY8Sg=;
 b=mqwsGB4AUtI1IEJYKE2xkvDUQ/tM7Whe1jagYxvRgfunWcw3JMDLSTTt6SO1Zs3g50+wxTNh+dlF1ZUVyDefGunSZKNZagA71IKM1XOsHdW48LUrMU8zigXQAmprrSKnpD8hwPFan3BLxQ9t8mzQ2WIhXRJAceLUVkVNfjuYjyytQuT0qMfvyQ8c1+9lOq67roaDTSesp9CbxY0n48mqf8W4lGNOJNV6WN6a0P4gDkeKpJfor5voRbWL27zSiei2gWLzm09aP8m8q3wv8tX2y0ELudaaUGwN1+0J64vVzSpfTeGkt49ulMSoKtc7vi8W09J26l1Yl8Ko+cBtKyDy8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF291EF9BF1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f15) by SN7PR11MB6897.namprd11.prod.outlook.com
 (2603:10b6:806:2a5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 10:42:09 +0000
Received: from DM3PPF291EF9BF1.namprd11.prod.outlook.com
 ([fe80::c5c2:2f7b:a506:2cd1]) by DM3PPF291EF9BF1.namprd11.prod.outlook.com
 ([fe80::c5c2:2f7b:a506:2cd1%5]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 10:42:09 +0000
From: "Shetty, Praveen" <praveen.shetty@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "stable@dpdk.org"
 <stable@dpdk.org>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH 2/2] net/cpfl: fix overflow on store of single-queue
 settings
Thread-Topic: [PATCH 2/2] net/cpfl: fix overflow on store of single-queue
 settings
Thread-Index: AQHdRGVc9+H5iiSOn0K6KuD8wjpnd7bPdMQA
Date: Tue, 15 Sep 2026 10:42:08 +0000
Message-ID: <DM3PPF291EF9BF1D5417444F5A6052CB3A59DBA2@DM3PPF291EF9BF1.namprd11.prod.outlook.com>
References: <bug-2042-3@https.bugs.dpdk.org/>
 <20260914162234.4058977-1-bruce.richardson@intel.com>
 <20260914162234.4058977-2-bruce.richardson@intel.com>
In-Reply-To: <20260914162234.4058977-2-bruce.richardson@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF291EF9BF1:EE_|SN7PR11MB6897:EE_
x-ms-office365-filtering-correlation-id: 0287321a-e156-4518-6a0f-08df1315fe32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|38070700021|56012099006|11063799006|10067099003|4143699003|18002099003|6133799003|22082099003;
x-microsoft-antispam-message-info: tYUDeDt752R8RmxdWZzNA9/uLWNmHiXKFrJO+Qvhf/zyaiAjXW8GxPlvfwKOhSljQfibqQJomgBhZzDEPIMpHPVGKJRMu6EdcD4CNn77XmM+ueH1uDUmDbplU0+DgAf0lySqv+KLVJvjvHNzAbbUBypurpV1DqcD9JWnbDaN0M+kWDKFCV7ZZHRnBIWeMsVT2IlOD3HGLQLHyQQowIL3LQ7hX2R/jbhVJfIOtNQwXdubU/qCEn3G8egaQwBlLMLfIj2kTwmIoqdZU8BKz5gv3Yyp7dxAnbs4NYLU26oruILrTXm3b/tchAxylx4LO3arquMfnShZssGGJEvFflM8iyLbKNvMRhe71CbhT7HS6/cJ64RqmyjttY1u5f8zTSuSQlmAXsQ0eT02WDixwfE28jjCTp6i3Rd4/aR8KD7qtV3mcExiZvTUEl4AI3RM+OGjRhWlszclN3/PZUZWEQBm/m2usDUHQRE2c+stHYtOMWkaZrKWG8YzmNtFuU63sO6g8dbcA+bQcLKe5qTHQNARMcl4xpMIqz8EQa7KhOJI5ByU2kfPZI3mILzDMXp5vfpMwv+8DMy+9Pr9sGjid1fLLxHIwgVteSfyrBSWWy0l+n8Had3lKtUAZpIK3MKTsKjtaEgG0MFtJSxX3IWmx5ZY45IbWBtI67pqrHt22+GG1CALJLFcPDGVX2TwZnz81B7lHw1WezJw7Tg39XHE/raSQNZj6Gp+faZgXZwz6iOzSvE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF291EF9BF1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(38070700021)(56012099006)(11063799006)(10067099003)(4143699003)(18002099003)(6133799003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A686IGcRzqOPxbdPg5/OoMdiqs2cEPo/95UDVC2XE/bdWfQ0DYOFwhJaFkK5?=
 =?us-ascii?Q?RvpqGodEwxqJ3HR674AO2VW73OPWqOlBf0GIX2PsQ5wTZhKQSmN4bQJQZ9+c?=
 =?us-ascii?Q?bLgWVDdqtMsOA/i6qOStoTec9mlh6QPOsdhLOsRgfklKmEyoXqNdl/qdWubN?=
 =?us-ascii?Q?wc74Iy9BkPUHyd9edAJy/sSHSpgnSbW998Sd5ZYUlVzZKU35zSZ2E++Ov6oT?=
 =?us-ascii?Q?lNgz6kUrQcBtH9MZ1zWj8V3kI8TsziZ3JvJizieNqAojdAG2jbo4Tu9FPKFW?=
 =?us-ascii?Q?I5Mw6incQiVqc1yaBBgt/+WjrCF3sHq+CO3WABef8ldnW76j/kOvDPYvlWrb?=
 =?us-ascii?Q?e4QwpO7EVu3Hyhq+RLNguTscS7bAd3Va8JomCL0oCUYrLAc/+spS+8DHZx0p?=
 =?us-ascii?Q?uKBCcioamKnLKojcIe2MpbIFMUDENP/9drxrlP9PP4fDhIz99fqTdeqU3atJ?=
 =?us-ascii?Q?ufLdoUpyPA1scEF5azxvoNhi+RiRPD2qhwrZf6wvxu7l4RkFAZ59oRnf6xTZ?=
 =?us-ascii?Q?p1M5w+CQ+0cz6GpIWGPC6Z0xVJiYFPRxXCTofN6E33JlFAEqjYKdWv7C4HES?=
 =?us-ascii?Q?bHjwA2DLU+iMrQ7d8+vTG701akGpU8lgnybCTZzaN0/4v4paEnXxmWbzXdHI?=
 =?us-ascii?Q?YPP1pBhojgrOphRNflVWvwx8QhwPe2dGEtyv8xxOHzxQsGI4EyAbcWl3EN1U?=
 =?us-ascii?Q?mGz1XtNVvOQgXfXW9SMbdmJ6cW8VaRpYN37csUrPKOTXFwV62CtppnTyD15h?=
 =?us-ascii?Q?zk5/MVX/3WbjBJpVdvOoa9ErpQhd+8w5hJbfmSp4r30isWUMqleS19JTK/O0?=
 =?us-ascii?Q?Mgad60lsiIYCFsaPNYbbgjYSrmmk7evIMoTmcHSRSqoz92jX9ovI8S5KPL6Y?=
 =?us-ascii?Q?FHBStl1nn1URAb55r6XWx5YTHkMYPO0JHCfu4bPSmPSydfWx3GXd+iLyr7h4?=
 =?us-ascii?Q?patmRL0GR6AYfSbyw3K3X4fLTSCr+EHuAkoLO9t+6C1CMi6h/ghyknAfLFbd?=
 =?us-ascii?Q?OQSAK4zavEdum2CSH4AysiFZ7DUcDjlZ8Wh14suifIPN/arBB9OfEeSchgaI?=
 =?us-ascii?Q?FiOFQ18Co0vEf5hq2bpziQ7dXn++h5rDxTViICj9oTb8YNizOj07xFl/Ozh0?=
 =?us-ascii?Q?a0DFrnxC5kLUJFWjtu+AmL9JRXR0ShBQvX0XM0ApCxZWjWhSyBpp3e02JTeE?=
 =?us-ascii?Q?lL0QDwAWJ7HroJ8ZVplB05lqKr6vXf4OYzb0x4jeCftQcty65FxZH9tHd4p7?=
 =?us-ascii?Q?42XEM/8IaBFcbhRxfAVdgciEgam2oMidXGUVR5zARgA63XA5XX0SRsCEEyD6?=
 =?us-ascii?Q?2oTSC5vwjrFziEO1lsWgkby77+X817O5lgVwbQmOKGWCT4X0oz2FlRVZ/+9j?=
 =?us-ascii?Q?yMeKeRfw5SDemCoOdj7WI3MRlcEPrg7jcYxpwbnooO207qstxZasXt58bFxG?=
 =?us-ascii?Q?PDHEhSwBPeXA1W0vCW2lxlGGlLA17Ifkldoyiy8BScHevOuku9XyswPAmpBX?=
 =?us-ascii?Q?r+i3GOGEcGhr0QIvSwyqZLHBCx3BaKOcwkS7qLcs/rgbHxhX3I/EuIqyKPiT?=
 =?us-ascii?Q?2LF2hjIWI3yPfuTyZm+UHGf0he1ewPNdF1D25SJmsFBIo2Pfr4NhyHqM3cKk?=
 =?us-ascii?Q?/LuMnp5DL2IL/b82tK/tkXgSeCQO74clHtgERgpEOU25Gf6w4TaplGmDAITj?=
 =?us-ascii?Q?VLFdBNx3ozxU8U9B2tPHE0Rux/gR5r6veDNiOlDk8xA3JrrdfzoPWgYzws8f?=
 =?us-ascii?Q?GH+bqJJi1g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KOL184LOA47j6MjnjJzF7HXhjbgrZILGemdOEVA4Fk/l2c6QTtjRTeSyA07G5KwcJXJFyx6Wv7blqy0dd9YOVG9Hro3DYfOJYma9Ye3DRimWsIRHtuUM8WO3sWCtq7DGiFxNQWIhvTe3WdUkghAbNzzXz0CAmZQdlPAY/PZjSbtTyUFRpihDCGAwPy4yicvJA3rJH4r13JDWOAsG0igOsUOKQrrVOo1bUwpLUrnWjiqM+DXXUADMBmJ7TwhTs7WCroRQOOBuJzLnEiIkaH/dpDDU5mHX2aEPxb1cnjpC4SE9aYEYMZiatm9mZ9fYAf4yVFov/quFdcNDUj/CSYXYJw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF291EF9BF1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0287321a-e156-4518-6a0f-08df1315fe32
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 10:42:08.9832 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TA5d0ANuFbCswQ4RFZ9IZb/AjeTgppE6auW7/G1MuWYFGXe8UcRjdvjjdEGC57tfgFRuce6ijGA2MnPQMf2GzcxEOOoQp1MnBDgYXd07X9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6897
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

The Rx and Tx single queue settings in cpfl driver are both boolean values,=
 but the parse_bool function writes to them as int. This causes an extra 3 =
bytes to be written beyond the variable itself.
Fix by changing store type to bool.

Bugzilla ID: 2042
Fixes: 2d823ecd671c ("net/cpfl: support device initialization")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com> =3D=3D=3D
Note: this fix is superceded by the kvargs numeric args patchset [1].
However, that patchset relies on new kvargs features unlikely to be backpor=
ted, so this standalone fix is useful for backporting or if the whole other=
 set doesn't make the 26.11 release.

[1] https://patches.dpdk.org/project/dpdk/list/?series=3D39247
---
 drivers/net/intel/cpfl/cpfl_ethdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.c b/drivers/net/intel/cpfl/=
cpfl_ethdev.c
index 4315adb68c..b1b7637f48 100644
--- a/drivers/net/intel/cpfl/cpfl_ethdev.c
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.c
@@ -1448,7 +1448,7 @@ parse_vport(const char *key, const char *value, void =
*args)  static int  parse_bool(const char *key, const char *value, void *ar=
gs)  {
-	int *i =3D args;
+	bool *i =3D args;
 	char *end;
 	int num;
=20
@@ -1462,7 +1462,7 @@ parse_bool(const char *key, const char *value, void *=
args)
 		return -EINVAL;
 	}
=20
-	*i =3D num;
+	*i =3D (num =3D=3D 1);
 	return 0;
 }
=20
--

Looks good to me,
Acked-by: Praveen Shetty <praveen.shetty@intel.com>

2.53.0

