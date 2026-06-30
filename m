Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D3FC43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 08:56:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5FD494025E;
	Tue, 30 Jun 2026 10:56:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 4E6CF4021E;
 Tue, 30 Jun 2026 10:56:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782809800; x=1814345800;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=PpZMTiF+iMqOI2Z7Tq4s8dzG70F23QCusLLdFHdklqU=;
 b=A8JpQCyj9HIDWdDyoJjjbLqnOq5lrOJ9Bam+akSISr0BTSj815ia3FxB
 0EuMhtUR0lzhJnSsljsQTQykCSSYkE0z2AyLBaT8MFSDbmVYhJrfLyWpf
 cqXVsiwNnB2jZHLIoMX972rqXKa/l0/1bhh7ba156w9bSY6qtkiQP08ME
 hCkDEGzOIri1Am7+IaUIEgennlR5e9NCWNEoaifw1Zb3MnIkHTJZSNzA8
 5NDxQvs3Ml01x0wL+juIJ5gcVtCWAb3EKsSvtZzMgodrCf0UysmubivDq
 30g1axEG5SnMHdKft3ZcQvEutP6LQ5QLssY8dB2my6oZV2OfMufDnXE5B A==;
X-CSE-ConnectionGUID: ACeEQaanSbubhjUmfzK2Og==
X-CSE-MsgGUID: 7EGty1OLR8+cSzFZ1FetSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="83651937"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; d="scan'208,217";a="83651937"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 01:56:38 -0700
X-CSE-ConnectionGUID: 0uu8xnL4QKKsohiHWhvTUw==
X-CSE-MsgGUID: hCFmihgeQcasoNMqGfVLJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
 d="scan'208,217";a="251803001"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 01:56:38 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 01:56:37 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 30 Jun 2026 01:56:37 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.0) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 01:56:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jYepHMm/hRfKF9lAbHZLQkQKNE0HfWdz4OhGlDs7hRgwulPSp9G5gRb5RhN0K9hXUFX19M/qWbM6Kev/H+lckdEtob6MEonUir/k+xIy9j1mnJpIFEqYQIOlLCT469tElPTl5n0l2/TVWHD7fpBU1+7nAhdr+H7/4eo92T5+8tK9oDVE7RMs0zX321BBUksq/iBeV/zVetGafTyfImbFJ5Etlaux8eApDojB8vTTcYy9C77ODaBMeCM0gpQJZ80ENTT2QTEbuPF34cVjQK1pGzdDoLEsC0QSIHrETiKDqQ9FVbK+aafzDZzHxzQsobGGjFwDD1FIFKvlwe1AHdPVLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zfeYrKyISu0BOd0YA8oJxdahriHdnT5zDp+MyrJdxg=;
 b=HRK12z9OMrv5CZZVBVHFlYqKI1JGAfbWEIIfr3an8XM8dN14NVjlsC83AUIofN+5QauZghU7RSM+ubUBJq3yr1kzpHC/2bL1cI+wI9oq8oRcbDHbSciAovIeyBYk9uj9sWO1yRXl1E2X6+tgSEOyGHoVYaX0lMQOh3RCq77L8x/GBVLZjNCK7bTK6px012Jid71CrBpDNd0VUvhMRyrj0BJB1+JQ4FHd7Ijvee+O2YPaR1jIxx6LQTtlk+ATyxcIPjQOzBP9zYQruter2Zg7wFm6z2LYNWJ0UYpjo/oHekhi1fQYxyIYQGMAYf1eRVvhDTsSQQHe9BJjR2eTR5Y+EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB6045.namprd11.prod.outlook.com (2603:10b6:408:17b::20)
 by SJ2PR11MB8538.namprd11.prod.outlook.com (2603:10b6:a03:578::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 08:56:34 +0000
Received: from LV2PR11MB6045.namprd11.prod.outlook.com
 ([fe80::1f72:3d49:b6ba:91ae]) by LV2PR11MB6045.namprd11.prod.outlook.com
 ([fe80::1f72:3d49:b6ba:91ae%4]) with mapi id 15.21.0181.008; Tue, 30 Jun 2026
 08:56:34 +0000
From: "Ji, Kai" <kai.ji@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Fan Zhang <fanzhang.oss@gmail.com>,
 "De Lara Guarch, Pablo" <pablo.de.lara.guarch@intel.com>
Subject: Re: [PATCH v2 04/17] crypto/scheduler: replace strncpy with strlcpy
Thread-Topic: [PATCH v2 04/17] crypto/scheduler: replace strncpy with strlcpy
Thread-Index: AQHdA8VwkYqWNfdPFEGqAiEyLABKQbZW1QWt
Date: Tue, 30 Jun 2026 08:56:34 +0000
Message-ID: <LV2PR11MB604589C97D6A19F17C42A00B81F72@LV2PR11MB6045.namprd11.prod.outlook.com>
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
x-ms-traffictypediagnostic: LV2PR11MB6045:EE_|SJ2PR11MB8538:EE_
x-ms-office365-filtering-correlation-id: 78c353ef-8c4e-43b2-0119-08ded6857cab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|42112799006|376014|23010399003|1800799024|11063799006|22082099003|3023799007|56012099006|4143699003|18002099003|8096899003|38070700021;
x-microsoft-antispam-message-info: z5/Yt4lUCWQsI2GdSJL95C/HgHytP6dDu8ZHVY9yUp6BGLov3evZKvHioVzZ6g6p8ixWBO4dhACQAY2uZR4yV7FWTa/dTzsxGZlHkC6C5aysls/EVt0I4BP4dtwAtW+OAC5tqZyM4hOVE93KDelU185xl5Rw39cBNWFFZ/aZgL5i17TG2hxaJ0mqmzkdGQG5sbH/teyS7wwN73l4DQcU5dQCBf9DVfUGkhaOB6IbKyaTkbyvP1fxjAO9sNYC9FwOSxvJZ5DAx0cu8FEVfrF57Xe3PdWRowMDm5JYBrMYQSXa5HMVRlJ8AY9LXvsJMZT5OmMKqM1klrbOM4kadAtgByBCmEIWAByQL7nFcwaeD48JirAX6LSoJ2uZuceB9cS1fEaE5g4KxefT6YmeXLyyyvBz5oLSzDGn4ei3FuTNuLY1ibuu7dhv8g2Z6LHsb53QlsK41aj9kkcnLdWWSl8BTgjFmHkxl1pr7/cO+sVblabpdXBWVKu0VxH7NWsSGJ3ExJpCh0UZVzD/wKT4yWdzmlTXMXMA5lCXTd9P8jPRwFNFmmY6y0ClVlf9TjzM8rVTmpyOodedlqOo07xaDN9nKErFGxtWIccczWBbjjNM/oemNC/XDaZd+LCAm0BVtWE8MKVYuKuI+0kj8WMKHDsOYjBOVxyl1mxduWu5u35PAWdHdu56Vb0mspkm7D3Fe4KI4U5gP+pxIjIAJmRu4DXjMM78AjxP+EmFkrWhNu0u6HY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB6045.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(42112799006)(376014)(23010399003)(1800799024)(11063799006)(22082099003)(3023799007)(56012099006)(4143699003)(18002099003)(8096899003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4VE8mQ+o7k1mmrlpW1egXn6h9et2M9pNh3nkhcsGwGZmCXC7ANBf/2ZHtvW7?=
 =?us-ascii?Q?v54Dhst0e6rLFvbKQh3b5f2bAmh1A3uzjEgJOWLCYUjp8Br8+FbMf+SLIPZ3?=
 =?us-ascii?Q?hJ/9YGL7Txb9j+S/P4uDHouvr5GLOIdZ3wNfFeMJXFysCmJBLrFb18JQAl06?=
 =?us-ascii?Q?ugZoUfKuU8cct6ZMoj5vFnyMyyRpxpSs1YjX84a6LPfwHR9qyjnr6NPhHijF?=
 =?us-ascii?Q?DPXSw7cmmUUxPmKGlefbcjfEJ/pEw2R4q7Uqyzm09XLMOQR6CkOrTXTr/TBB?=
 =?us-ascii?Q?8xqz3dey3UVL/CIVlf33BZXjvFqwwWZ7bg4ZPRvTra6pQExqI7p6apHS/CRc?=
 =?us-ascii?Q?nGLPlvJ54M94W3Eekb4Ld76lgMfd/hCFrcX0dQ6GxU0E9LWp2dyOKytqCmj0?=
 =?us-ascii?Q?MRJYKPqmAkoJrRa4R/MGJelHD89ZWsQpfZyz2+lJ9GBqQLNnBcassyaRGWeO?=
 =?us-ascii?Q?d+VxW8AFId4sdRQ3U6BBbBl7jczvw/J+I4Zp8qrsU718+yCErVv1X5yKNlt5?=
 =?us-ascii?Q?PHbGMYP16/+mSW7pr+zzi44bQjXaH00FtdCXdfSx8G1dGkh4iBmVa7lIz37e?=
 =?us-ascii?Q?0HQixXS882/SFEpMf8cwK0wd1KlZSb4Pq45k5ZhF07781DdmnC0KSTa9FjrV?=
 =?us-ascii?Q?fu1v1YkUI5HkEFrt91FWh10mN6lg1loDh4pfHpItYvbzWq3YnSM3GC8xT/eE?=
 =?us-ascii?Q?uFO2eTVFK1AI1EkX+LLRk08mSL2PE7/ak7CZIIxKA5RJbHN82WKH5ZyZ3VPK?=
 =?us-ascii?Q?f1a3rcblJWqAXhrk5YxjeiSYtpJAZnl4A2FRf3IeccC9pArRjOAZ/M7f/Xn3?=
 =?us-ascii?Q?TrlK36c6crKXToyAoYZoWSnHr5VmoQVHud5djCG9IQceVHpbLpyPguYq+sdk?=
 =?us-ascii?Q?CLu0/BAm+ToUzyW+renpGzz5/UdL/+ZKV6Wpo2vR0S00EC/SXk1mD1mOTXaC?=
 =?us-ascii?Q?dHeTNIU2KaeU12s4UdJEcAZvsZ/ummkY+vzpK7mnXjWKA8oSO1g5Usor9T6I?=
 =?us-ascii?Q?U3LZb20rELTvAJc8klNtU4Lyz09x9DtSDMAMcSyLYWi1syScnXp2Ppv89CiV?=
 =?us-ascii?Q?H1fFDhPYzwYHXLHs9Cs0zW1nKF+cDCtpEGAugMuqIcyMU5nWYfKTVz1Krqlj?=
 =?us-ascii?Q?mSZpYFirT6JmWuOfuLh9P/XhPZ8x1EEoc7CxNzlRcJCQb9ekpaztGGGcX8Rb?=
 =?us-ascii?Q?Br/Ifnxso3fwDfonpf/xMc4eudY2SZ3HW0dpKE1VyeH+GZsUm8coUvh4jKJ1?=
 =?us-ascii?Q?HZS01QFKJjhsACpkIbCaUfUQS3aXPGg3joTJOHck+jzEMwNaYTFlyQQfoLkp?=
 =?us-ascii?Q?ZHFcIyhoccmbLZjYgAHnay+cPK0NZ1KYUWEW6fUxrsBV6XspKxUiIp4FyQHa?=
 =?us-ascii?Q?XqoYis2adDARDr9tvILArES9lsmmSX8niW49Qb/W/lY/H7L46HIGlg9FGfYm?=
 =?us-ascii?Q?2KQ5nYXYUhVL4s7xQKWdYU5jMa1cPUzxpNzm2UQO6fBVAjPeCyPlb39D45np?=
 =?us-ascii?Q?CDlAcp9GC0RsuWQGKNS9wDOjlBgIwtoPzRiNQkm8eaN1I1N+6ONeZpuLGxFA?=
 =?us-ascii?Q?vi0knn9GIB6efiWLq7o+jih6g025hcYqu9CkDiBwzHnLGUX8eF18166MpCEv?=
 =?us-ascii?Q?e4HJFilNy+0c8Xx3BpveWvE1rPi4Ho6+KN3tjaBUD4TEblgfdSMRnGISS+4g?=
 =?us-ascii?Q?udiyO+vGra/dbd7m7X7kuWyaXolx76kAb35G6xqqLUlvjjkD?=
Content-Type: multipart/alternative;
 boundary="_000_LV2PR11MB604589C97D6A19F17C42A00B81F72LV2PR11MB6045namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JRHiywEFkiGgumF5Yqmn6E7oEIHJk15Nipxq+HCs48hgpiYMsg4iGPTtG2m638T8mYCZLIo0vaMWyuCL9QbsmMASYzLsqLfk3sPruwd1LP3+a3QbXdxMwfy3fpjavbc/d3ADYyo6cs8egtBguthcn21QCgyeNPzDavBUzk+tI/UyVKAWqEu62ZR3HqcFrioeSMJNNGUQjtR/RtPl2Q886MNhsDq7jKBG/62RIz+hpCKRTe5TKDKRGeE7UjDM3euEawtXYkf14xhOYICyvppCWTSZ+BfoyJsw7KyeP5KP1o2LCyQVvYoz6NEeqGmIPRcDvo7rUxCaWMCvBuT5+IBPLg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6045.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78c353ef-8c4e-43b2-0119-08ded6857cab
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2026 08:56:34.3263 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: shgHXN34zEhVf0hGabpCQDICKQo0pHDLic3lssL7i6C5hlJKFJPctC1MPWFPDtoVGbe63M3d0Uq+ZRYwR1CHLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8538
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

--_000_LV2PR11MB604589C97D6A19F17C42A00B81F72LV2PR11MB6045namp_
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


--_000_LV2PR11MB604589C97D6A19F17C42A00B81F72LV2PR11MB6045namp_
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

--_000_LV2PR11MB604589C97D6A19F17C42A00B81F72LV2PR11MB6045namp_--
