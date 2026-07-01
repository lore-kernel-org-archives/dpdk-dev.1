Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC39C43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 11:18:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F0F0940647;
	Wed,  1 Jul 2026 13:18:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 44911402E0;
 Wed,  1 Jul 2026 13:18:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782904695; x=1814440695;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=hP0oSU2eVq6/R6bvA+bavNsqBTBsUqHMXVRY6a1yZkM=;
 b=DKGWf89rzJV1/CveCCLiFjLZcD2mLDBhT5yfa6wdkQWkIdUOUUlmr107
 TxM0KMIzZJJdWVSU1J+PKuv7pzLShA3XLOzVIbd8GrmNBiXkVKonSmnhv
 QG7dqdjf3PCVeE7G/HZ7cG3/McUSBSfMCQdahHxJ6w+eF04MYBA/SO/hQ
 wbmkWX25icOtli8h5XWUX4cM0Rl7CuISPmhjhq4jgqJ2imfAkj/RFcAIE
 sHQadOWRz0N9l9TVnX+3MSBth8Wbm5PRBf3rq+dJ1qduQL7jiwTTnI0lP
 mb5w6P+EsJq+znrFUOtTuwb+OXJCoY9BP0fLbaNe+6OLKgd0UlpyZC50B A==;
X-CSE-ConnectionGUID: y6u6YxuGRB6CvxKCu3t2ag==
X-CSE-MsgGUID: dSMU6R4wRnW+ZPGg+87kmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="101176861"
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
 d="scan'208,217";a="101176861"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 04:18:14 -0700
X-CSE-ConnectionGUID: McZw8yMaTf+DOpgnJZ0kmg==
X-CSE-MsgGUID: ukCoN8XnTAumWjTicrrh8A==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 04:18:14 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 04:18:13 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 1 Jul 2026 04:18:13 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.32) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 04:18:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0z4DS+ej7f1FaGMEyIR5Cp7lGH8b8HzoesQ5r/EFFoNstxcJ2Cs0b5Gwifldct2bVxyjAxRaA+KjgI+DRdQ0QWEwXK7Z+lgZWYz+hRoAuql1RyTIr7VYDCovkLu+UKEcHV4lf24m8Om0pagOi6LqebeXKrsvw5wSpJeQNS8QrHRQzwfpGSuRyaeoeejc8LSQvaqZlqcA69K71xJwrytm4b8P1i4xLMnoM/Kn6kSmlt/UBfCW+9WkzbfNGowAJwNCA3NsJZPxxEj4bVi/ste9GWBnWL/jbAITCSmIhCMILFUyZTv0mrWcRSTtxTSlMgMK0nGyKVHA31MM6wBu2S2Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sj/1l4dJfqwptQyBx8hhh8cVLbdhprP9Yi62nTxUFLU=;
 b=MoJgE2hkeulBe15MHpslrd72XZxxjpaHE278rItk+am2SzbqCVfJJEUmte2OzAzn7r+VD++jz7KbzWAFO9i0v0q0uKlpJQL+i0qL3u99F3dLeK2mAO0v06m+BG8MSQQr52zVTljaG+2XshFAnXUYH+3trnDN3C4VemqkLzJ8ArDDUGX1iyyJOZ/z1P5Yg7EF6yOC59osu69gEnxpn8Yh2w+wtZyf9Vc/7czlRtknLA6wsdF/6JYjZebG3uIzkITIkVgrzzlTigvOgDBhV2mtwjMaNnO15SfEhXIsZairOBjhIL0sFlWo44LSmH1WvAoR6ON9y3VxmKz0gS52sFyElg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB6045.namprd11.prod.outlook.com (2603:10b6:408:17b::20)
 by DM4PR11MB6525.namprd11.prod.outlook.com (2603:10b6:8:8c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 11:18:09 +0000
Received: from LV2PR11MB6045.namprd11.prod.outlook.com
 ([fe80::1f72:3d49:b6ba:91ae]) by LV2PR11MB6045.namprd11.prod.outlook.com
 ([fe80::1f72:3d49:b6ba:91ae%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 11:18:08 +0000
From: "Ji, Kai" <kai.ji@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Fan Zhang <fanzhang.oss@gmail.com>,
 "De Lara Guarch, Pablo" <pablo.de.lara.guarch@intel.com>
Subject: Re: [PATCH v2 04/17] crypto/scheduler: replace strncpy with strlcpy
Thread-Topic: [PATCH v2 04/17] crypto/scheduler: replace strncpy with strlcpy
Thread-Index: AQHdA8VwkYqWNfdPFEGqAiEyLABKQbZYju4P
Date: Wed, 1 Jul 2026 11:18:08 +0000
Message-ID: <LV2PR11MB6045737F673A142D419F858C81F62@LV2PR11MB6045.namprd11.prod.outlook.com>
References: <20260623165150.765443-1-bruce.richardson@intel.com>
 <20260624103658.792750-1-bruce.richardson@intel.com>
 <20260624103658.792750-5-bruce.richardson@intel.com>
In-Reply-To: <20260624103658.792750-5-bruce.richardson@intel.com>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6045:EE_|DM4PR11MB6525:EE_
x-ms-office365-filtering-correlation-id: d9371a52-920a-40dc-dd92-08ded7626e32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|42112799006|376014|366016|1800799024|38070700021|11063799006|56012099006|4143699003|18002099003|22082099003|3023799007|8096899003;
x-microsoft-antispam-message-info: lo6Ji3wgE1V8X2nIDzBv6bo5TgcY6OQe857J8auk8K1ogX946qMITt66rVqLUkTywlPoR0BBHQcBxn/+B1ZghEBuwmsqxd3YC/sqx75+kODxw4S+iE4zsgRy9h/O9JkZO6HGqWjMie6YOk/lOn+bra+eu8CakNHI0w+HX6IfKRjR3wLRRdUaS6hGYicOpStUk/3Zw6V6JJCMdsYmmY8KI5SAu2oNSjLj0xjYUDBbF+9pUfDyUXXhHWNapvcXKAKWfj+blNGU5WF75qQNPiqn21k3z3ehHWtSAyujKup7jNKMZQCEIGdyCYA6JtzAAd1Uy3Q57rB6tfWVAlCtFkf030NKD5DZjJiSGpSETr7Pr92ffigGq5GLFuufSV6sGxP5W1d6uoKa/PHDcL2a/VUBmjD16wbI7I9/XSqNKBOXEBjq0453Pco9YdqmtFOazXTKSN17SFza0ZDg0cvRWkNnTHw1720bQDbd8js+Vrc/xA+hP7sgrjg3Daai1YbkrfWgRnkj5dIUFH0OpxOipts3mcYlVd1Ok1WbZ6+NgK6HpKt4SnKrq1sBh4kWeqa85WWpOoVEjrOPgDQ9aLP0LgMjNyCSVMehBkodJ14WHPbyLSYEjXPHeqG/hZDbkRariisLAm5uOHiYvB4wkzWSZif8DqD3P3IgtiED1NvfgJNNZ2PzmVBsR80JW2nP7P0O2ELHcNNj4OHhAStJ3eA8QTtdYs8R0VuDRyWLAxufNtkTa40=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB6045.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(42112799006)(376014)(366016)(1800799024)(38070700021)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003)(3023799007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZK4ftTQkiT35AnV0/BeHMWYEsp7+KMC+cZEtdmLYjhRuT41KO2j+CM1Qbjz9?=
 =?us-ascii?Q?Io+Oj5yCZix87P+GeDeXxB4Msk40RF4t4/r3vOlFRqrdX10DyIag+pfCrSgD?=
 =?us-ascii?Q?vc1bhxpbZoH6OV3SA4jn0oUIc/axVyCbX6EfyPcUrxqXbsW6gho0ZFn/oCjC?=
 =?us-ascii?Q?lOTfHVS6W3tTB6RBMboz4ESMXyxJxv55QheHB+QPJ1nKM/qkTrP4R/BLY3ip?=
 =?us-ascii?Q?FBHRCLlCzEJlSAr9fH/EsX9Ar7NJsv/EL5CKFeLOyOF1Oioy+LTKk9SVMo/q?=
 =?us-ascii?Q?ghZdx9821RJWT36U8zTGGpM4ZwebnTFmpwkQAxZyy9FaP8EiYyGzxRqJ/cft?=
 =?us-ascii?Q?NP45Qc2x3pJFhEka87o3m7WhmD0GgTVjQuVPjanBs4z5jLE88sOFrMT3TlED?=
 =?us-ascii?Q?r14tBEGhDUlOVufHhfgRETr20emHV0UoOybfkhKDUqoIJpnLL1WgTd8jUNL5?=
 =?us-ascii?Q?/ByRRfsY/5MHchSOqVZ3L1Owk/fstiOfOi+oQk+JoGagDhPsaK02I0z0s7j6?=
 =?us-ascii?Q?kmfT4Wxx2niaAtQ26mC221EHxyw4lz/AGN/UUuQRLToNcgjeJlB883VtpmjW?=
 =?us-ascii?Q?YqBPGAixMLMhniiEGZiU0P57JprArEz0Qi2bzQBK5hd22dMUWLw3aNLBqsWl?=
 =?us-ascii?Q?Segr61H12ImIx1cDEPzJ3cuh3Z+3s6ojP3vkKhyl6VU+j06/QEVfaGLasICv?=
 =?us-ascii?Q?SM2grTs4fr0tlPiShZbi9T3xoQR/4NaHjg46N2MwrM2UN/nCIwzIl3L3CUfQ?=
 =?us-ascii?Q?zWo9+sqx5bifuuq6K8voKSh2suUGhLQh4HfBmoWAzv6xqf7oN34T10G5idnu?=
 =?us-ascii?Q?0Bqy9Neo9SUfC/DkcBssk2M8LDMxr9YooAgPDSNWX0/SC+9ZOUpiDkCPXTeQ?=
 =?us-ascii?Q?sAtCdutc2T/zoU+dYobQ3YBVDfD8Q1VghZiVNEab+jiqZbMy/hsUbTLMFXOS?=
 =?us-ascii?Q?ATgU+Vfh6ALQoLxFB+kYqM4nf25HOmScS3M3H0OsSNeCBh+jaIA/tK/657g3?=
 =?us-ascii?Q?uXp/zADQTXmT+pr/dewFbH+xAP33sVDo/ygNEC7dc9zVyECFBATHejMl4J8e?=
 =?us-ascii?Q?uSanJhlpv1dVHQFbjeC7ro6gKdG9DuxTkMH2SVRiAI7Ius6Q/fs1MAccIUR0?=
 =?us-ascii?Q?EqRSU1LapD2p1iVGzvd6eoWAexsm0CxOdez9xPUH2UZWMT5KUBL/hDym5bk/?=
 =?us-ascii?Q?5PDUVkqPVKb8UplNTqUB6FqIko7rjDkVLCPd5NtI9aKA1KNQP9j+oU4NcDuq?=
 =?us-ascii?Q?GFybic9cM15XMEGuCMjyG54gCnYx4cJP2tdRUACMbQ3/NowC9Y53q0tUCqQb?=
 =?us-ascii?Q?hzc4Y+5EjKNh1eA2Ub1XP21xe0ADj4SOV4DL7R5VMx5hSd6/zOSAARi6wPoU?=
 =?us-ascii?Q?LrZgemUrRGHCdk5H5iNLMEI9CPsd2EZ431A6ttrhb7rCrmgzlrCxxX5AsBuo?=
 =?us-ascii?Q?WsNtwp5PXrFUV3bPfkAr17Dl39Mjeq7sm5LywcCLy2Sd1bM0lmrbzm/SOUad?=
 =?us-ascii?Q?4MZYpnrLu7v3J5HCCTCF1z2XPwXvf1Epx2n6BlbxR/lwDZtVrQ9tpwltbNl/?=
 =?us-ascii?Q?dU0E6x1uoVMzhSWW1NYihkjDglge0j9AgVY7pqZyG1dU7dPTJJvdg94sfu36?=
 =?us-ascii?Q?UsATqw8jD3A2aIax5iemrwjYNawYY0uXQ9nfM8RylzOwXHM5XszTWcC3wBN3?=
 =?us-ascii?Q?9R2E7cpGdUixyyjTWxvuSqLX6Hejgm8+ek3y5EvwswCW3ODX?=
Content-Type: multipart/alternative;
 boundary="_000_LV2PR11MB6045737F673A142D419F858C81F62LV2PR11MB6045namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gkF84LDwe8TnysdS1E7JnaC7Z0LkGGBQW9AUy1gr010LNGqnbHH8u/+7gu0BfKLA+CSfzQ0ZuCVDGPvF9igftLhn66tRq2cmnBLpbDKJ6Dn41LY21Uqy+NJovPu16fB4uneKHkYKGqUlI+2Fp7mPoOum846ZWBFiytdjeB4mMiq9dirMtoSKEPHOGME32wQBXlaa/G95qoPjjjC95oSPRNpX1Bt0VwQzUHqIWJe+oHNaduSDmA/+NrYR7pjWXUp1wxvwBeqr4bk2bi42Xrbn5/Li6wpWcnN9nbbuIvoBW6u431Eaxe1IWhOxpwijTHJI7KEQlzbQ2KShu/wFtn0//A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6045.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9371a52-920a-40dc-dd92-08ded7626e32
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2026 11:18:08.8532 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MiNviCIXwOdt8cN2ozn7kRuC4b79kaTUimdT3A5mawZusEcjq/XnrKmj8ubc/EuGdSVBClcxRuWfEmPo5wGYEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6525
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

--_000_LV2PR11MB6045737F673A142D419F858C81F62LV2PR11MB6045namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Kai Ji <kai.ji@intel.com>
________________________________
From: Richardson, Bruce <bruce.richardson@intel.com>
Sent: 24 June 2026 18:36
To: dev@dpdk.org <dev@dpdk.org>
Cc: Richardson, Bruce <bruce.richardson@intel.com>; stable@dpdk.org <stable=
@dpdk.org>; Ji, Kai <kai.ji@intel.com>; Fan Zhang <fanzhang.oss@gmail.com>;=
 De Lara Guarch, Pablo <pablo.de.lara.guarch@intel.com>
Subject: [PATCH v2 04/17] crypto/scheduler: replace strncpy with strlcpy

Replace strncpy() with safer strlcpy() which always null-terminates.

Fixes: 50e14527b9d1 ("crypto/scheduler: improve parameters parsing")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/crypto/scheduler/scheduler_pmd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/scheduler/scheduler_pmd.c b/drivers/crypto/sche=
duler/scheduler_pmd.c
index 95ce893f05..ceaefa329b 100644
--- a/drivers/crypto/scheduler/scheduler_pmd.c
+++ b/drivers/crypto/scheduler/scheduler_pmd.c
@@ -229,10 +229,10 @@ cryptodev_scheduler_create(const char *name,
                         return -ENOMEM;
                 }

-               strncpy(sched_ctx->init_worker_names[
+               strlcpy(sched_ctx->init_worker_names[
                                         sched_ctx->nb_init_workers],
                                 init_params->worker_names[i],
-                               RTE_CRYPTODEV_SCHEDULER_NAME_MAX_LEN - 1);
+                               RTE_CRYPTODEV_SCHEDULER_NAME_MAX_LEN);

                 sched_ctx->nb_init_workers++;
         }
@@ -443,8 +443,8 @@ parse_worker_arg(const char *key __rte_unused,
                 return -ENOMEM;
         }

-       strncpy(param->worker_names[param->nb_workers++], value,
-                       RTE_CRYPTODEV_SCHEDULER_NAME_MAX_LEN - 1);
+       strlcpy(param->worker_names[param->nb_workers++], value,
+                       RTE_CRYPTODEV_SCHEDULER_NAME_MAX_LEN);

         return 0;
 }
--
2.53.0


--_000_LV2PR11MB6045737F673A142D419F858C81F62LV2PR11MB6045namp_
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
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Richardson, Bruce &lt=
;bruce.richardson@intel.com&gt;<br>
<b>Sent:</b> 24 June 2026 18:36<br>
<b>To:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
<b>Cc:</b> Richardson, Bruce &lt;bruce.richardson@intel.com&gt;; stable@dpd=
k.org &lt;stable@dpdk.org&gt;; Ji, Kai &lt;kai.ji@intel.com&gt;; Fan Zhang =
&lt;fanzhang.oss@gmail.com&gt;; De Lara Guarch, Pablo &lt;pablo.de.lara.gua=
rch@intel.com&gt;<br>
<b>Subject:</b> [PATCH v2 04/17] crypto/scheduler: replace strncpy with str=
lcpy</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Replace strncpy() with safer strlcpy() which alway=
s null-terminates.<br>
<br>
Fixes: 50e14527b9d1 (&quot;crypto/scheduler: improve parameters parsing&quo=
t;)<br>
Cc: stable@dpdk.org<br>
<br>
Signed-off-by: Bruce Richardson &lt;bruce.richardson@intel.com&gt;<br>
---<br>
&nbsp;drivers/crypto/scheduler/scheduler_pmd.c | 8 ++++----<br>
&nbsp;1 file changed, 4 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/crypto/scheduler/scheduler_pmd.c b/drivers/crypto/sche=
duler/scheduler_pmd.c<br>
index 95ce893f05..ceaefa329b 100644<br>
--- a/drivers/crypto/scheduler/scheduler_pmd.c<br>
+++ b/drivers/crypto/scheduler/scheduler_pmd.c<br>
@@ -229,10 +229,10 @@ cryptodev_scheduler_create(const char *name,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n -ENOMEM;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; strncpy(sched_ctx-&gt;init_worker_names[<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; strlcpy(sched_ctx-&gt;init_worker_names[<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; sched_ctx-&gt;nb_init_workers],<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init_params-&gt;worker_names[i],=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_CRYPTODEV_SCHEDULER_NAME_MAX_LEN - 1);<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_CRYPTODEV_SCHEDULER_NAME_MAX_LEN);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; sched_ctx-&gt;nb_init_workers++;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -443,8 +443,8 @@ parse_worker_arg(const char *key __rte_unused,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strncpy(param-&gt;worker_names[param-=
&gt;nb_workers++], value,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_CRYPTODEV_SC=
HEDULER_NAME_MAX_LEN - 1);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strlcpy(param-&gt;worker_names[param-=
&gt;nb_workers++], value,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_CRYPTODEV_SC=
HEDULER_NAME_MAX_LEN);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
-- <br>
2.53.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_LV2PR11MB6045737F673A142D419F858C81F62LV2PR11MB6045namp_--
