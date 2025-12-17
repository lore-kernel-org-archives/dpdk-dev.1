Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACFFD65C4F
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Dec 2025 14:23:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E154040275;
	Wed, 17 Dec 2025 15:23:02 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id A331B4026C
 for <dev@dpdk.org>; Wed, 17 Dec 2025 15:23:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765981381; x=1797517381;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=7lcb88Z26UEMKHCH6G0YK2E/7xQzoZIyPIV1mlzPdIA=;
 b=c9jhKnaWIXjTBjKE9tUwhsTzkGAwXpJupzJMFaGpluDLjEZOPuNe+ou4
 rHq/qyvE13GaxuDj0+Ttbfxbjlg1KO2/LNU2oo7h8gEVVtOr/ucEukEjU
 TfX+45tvp2muZ87jbs7fJR9TbK9oMgUExTWJRXFFbdOTUQSIBATBBuj9q
 hcv8T7xxkeOICHC31+k8iRbctp0R/o1mThafSrSugSKb4Uso1XCq8BJh5
 oonNU0guZOD1Yqh1dPS2SpM2dhdWYwqZMsL68jjiyU4RnCrLnucXqDC3O
 sQU9OxaLMk9TvUQinrU7VdUxi1BngnyuJiAMFRQNA9hcGOdTMv3E/hy4U w==;
X-CSE-ConnectionGUID: INGY9XrxRjOAhHvNH6MLPw==
X-CSE-MsgGUID: WSJz6qqUTYmd+MlIBzwb+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="85335308"
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; d="scan'208";a="85335308"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2025 06:23:00 -0800
X-CSE-ConnectionGUID: l0UeSEeVSECF6LdoBfidOQ==
X-CSE-MsgGUID: N0pgHAnQR/mjBOtijmcQhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; d="scan'208";a="198802707"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2025 06:22:59 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Dec 2025 06:22:58 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 17 Dec 2025 06:22:58 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.55) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Dec 2025 06:22:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KwKWun15NXDF4UUzrChdPQtvfpjZQqUAXF57YDE9cqtPYE4FQDPaYNvtG0LcPoS6EByDPXG7fff7XxS3HrWabExkBaTv9Ep8xhQb1Omhq8PemnI02ROLUQ76/gNvmr3ssDlGIP47Omkevu4xpYd+nY+nPYYii/K3CJRD3qrRh61v40mvqcwvenbpUIN4yr4TBmNiB9UL/mWxSLq5i6o4Dxl6PSBriYOfGHE13aIOKJ6oQvQ0EZOLhUVVlX8VLtQ0ou+3HeEn18Zm0U09q2w5GGLHKwUuXdW4CTiG2K2kAol2gRnO61yhmBwpSoJVhUIVp1NY97nmSAWpD+Yi4+GQ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2Tfp5kTsQPVeoTYkjfcCeLdlQ7mFJsGbCLXmDjlYpg=;
 b=RjD/LaSPmYFXckktylTk/QksOIKIyDbDY3pudMO/fraOa/DHjyWRthmsBx3fsst7T0HHjYaEk0AIfaGGw8BrEnxc1TbzaGFOIp3W9gjQcCksPoeEVV6ZHwR8JK/12rqkD1E3XnVaUWPFI9YVybQN7fX6hRR/nQIh2L9rkWvZ+cyiwXxm7zs3nUzY/xVekSMt7nN+BH8yN0NWSMM2GGpI+S6gxmQlk4KhQL5wZHm4Jj09ADiAUuCRCwJRtncZdlX+BdT4QsKqnLNrQicwDDXCHHr2v6+kqjE2RdG1fTWZGBG6FXpr/JC5hzIYf/hrFnhOPjaSSeoDNHaC6F+QpQUctg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6116.namprd11.prod.outlook.com (2603:10b6:930:2b::14)
 by DM3PPFC89313B1C.namprd11.prod.outlook.com (2603:10b6:f:fc00::f4b)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Wed, 17 Dec
 2025 14:22:51 +0000
Received: from CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::2b59:d9a6:8854:e9b9]) by CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::2b59:d9a6:8854:e9b9%4]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 14:22:51 +0000
From: "Mandal, Anurag" <anurag.mandal@intel.com>
To: "Mandal, Anurag" <anurag.mandal@intel.com>,
 =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>, "Richardson,
 Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Burakov, Anatoly"
 <anatoly.burakov@intel.com>
Subject: RE: [PATCH v3] net/ice: add MAC anti-spoof option
Thread-Topic: [PATCH v3] net/ice: add MAC anti-spoof option
Thread-Index: AQHcZEGAPn5qQK3460OIGurf0zTObLUPyuyAgAAkB/CAAA4vQIAMnksAgAkzcYCAAAxfAIAAEziAgAAHv4CAAABMgIAAAiyw
Date: Wed, 17 Dec 2025 14:22:51 +0000
Message-ID: <CY5PR11MB611686BE0F27B6611461DA8EE4ABA@CY5PR11MB6116.namprd11.prod.outlook.com>
References: <20251113105914.34949-1-anurag.mandal@intel.com>
 <20251203104126.75935-1-anurag.mandal@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655B7@smartserver.smartshare.dk>
 <CY5PR11MB61160E99ADCBFDE1182D6BABE4D9A@CY5PR11MB6116.namprd11.prod.outlook.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655BA@smartserver.smartshare.dk>
 <aTrhuMI14CVK27aS@bricha3-mobl1.ger.corp.intel.com>
 <aUKZmzuLWYguKOlE@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655F2@smartserver.smartshare.dk>
 <aUK0GxJjmJDB0ojE@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655F3@smartserver.smartshare.dk>
 <CY5PR11MB61162578092FBC66127A2EDDE4ABA@CY5PR11MB6116.namprd11.prod.outlook.com>
In-Reply-To: <CY5PR11MB61162578092FBC66127A2EDDE4ABA@CY5PR11MB6116.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6116:EE_|DM3PPFC89313B1C:EE_
x-ms-office365-filtering-correlation-id: 6b5b856d-ef9f-49f5-b6fb-08de3d77c2e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?nVpX2Y1Akp+pO0iliG+1HQmR0NMYgSCuVNUbXPY7puCc13/hlDRadd6YQi?=
 =?iso-8859-1?Q?OQrhyX615rCV/bMh35+abzf0VOEuxJnBbiP7FQmg/PV595MOB/Rvb/z7wl?=
 =?iso-8859-1?Q?ac7i4/kIgfJ2yOCcruph5fM/EI98BBeCCKmfgmc48gU6RCuWIAueWqH/AJ?=
 =?iso-8859-1?Q?vLrmPIfLx/iHCKpUVidunKW3WhXurnzzKZnpVdwth4syW7/bnRuRnjleE1?=
 =?iso-8859-1?Q?AIVfqMyL/5bzlmamG/W58Px3sNge0nipaWS0edcBkNG5pcye8PnuBXrfWQ?=
 =?iso-8859-1?Q?6M+KoAc4o4Gm+Xb5dTS72XmCJe3gZsMPKQBZJFC1ac7EHH/I1Z8jHwfwKP?=
 =?iso-8859-1?Q?VXhUtPoSWSmoXAli+mGmXQ1CD9/h9zt0jQc97TDo6Q01cr3//5CGQHBP5/?=
 =?iso-8859-1?Q?pYlxmKOmL+VFCYqSStqn04QYPKJyE54jBoqiMRbGr6TLY1l3cb2lFEz1X/?=
 =?iso-8859-1?Q?9P4w+CxHPSCwSBdADmEVG1p8OD8qvzV2CS7jZ3IHnz252nL+7nr1rZ0Hj8?=
 =?iso-8859-1?Q?DQgxs5nABXoVnVCvJRDXa9Tg9t9Hr1lfZw615qBQ65NtHAwQvoa8IEP7lU?=
 =?iso-8859-1?Q?bWzGtF8d3D/xFrAzy250bZUHtOum0xVXwZSOn+3/Mv1/iunCjHvt2qmdNh?=
 =?iso-8859-1?Q?y1krplaoxDbTaWLYkBOiBLRJKc+UdLpkx0GGsbpwhE0dS+UCwZQvJgMMZ4?=
 =?iso-8859-1?Q?sPoNh0dyw9ufCB84aRPCoKNm7wSYCGqNeicYFz835UtvsJFrEO7svjjlrs?=
 =?iso-8859-1?Q?OzQ50pDdcNgzpk7umP/yHZxXJWtRUfK2xWqPANvYiQnAk9eY2Z693bJeQc?=
 =?iso-8859-1?Q?6nowA6tuPkAsGtJTdF52+BFkKadIg8/Hk5Lprk5xeMYxTwl6jVHaHipp+r?=
 =?iso-8859-1?Q?aFH+iNcpq4fjhG8sL5Utt8LzhHowFkyehvtFlywgaElnrcwKMT5WHEmiCO?=
 =?iso-8859-1?Q?inkIw0RQVZ/HefOSBj5oaMU3ZMvylE2OJcofrq0xGObOFpshOsi4QVqT5c?=
 =?iso-8859-1?Q?5/2qDM9cuDLtERIKrizwpijJK2/NtYz1W/apRfaGRzNGyOwk1CliyLBEr7?=
 =?iso-8859-1?Q?jNY5+Pmo6xlVHpjDcwdKTK0KScsKYaorhBxGEjpw7xg+AbZPRAcdA7n7Zw?=
 =?iso-8859-1?Q?LHfaYKZZytHQczL5q3vau3U8z6Y7ckxYOgP/3HsQnOPoLjHkZzLlGOPDzM?=
 =?iso-8859-1?Q?x8QbqvO2R/HbkgsJ8IauI0SOIyiol4+s2DgsGRSvibPv2mo6ItjQEcQYI4?=
 =?iso-8859-1?Q?MN9v2MKmHsQXi0jOEx+w9/cFASxuN6hup2DD9S6WDxAF1kW2ddeo+VuAHg?=
 =?iso-8859-1?Q?+vF5hmSE1kzYlwoLNiN9k+hLNbwdOyO32VuPfzGMpSxWInCcVoHnywftyA?=
 =?iso-8859-1?Q?0Y5suqXrnvOAPmXpd0Mz5M6xbUPVOwsyCjWzsE+3EsjuaCy6rDt5B2sJer?=
 =?iso-8859-1?Q?oNcTrYGKMK0EhVrIdNZXFR8iRC/TJVjPwAjqAkshNNpa61/gZm3neFizsI?=
 =?iso-8859-1?Q?nzy1UGEzQzNz1EeW1teTq2l8afwMVyrKNiSoWxsviZHdDpfQdsxny4wpUO?=
 =?iso-8859-1?Q?GkJ+DREEt5+YfmRaezDlGDAbGFsz?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR11MB6116.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Clzm834qcD2+eK4GVSCoAENLO1I3GySr/HygCrwfXxBx12wRPRu0IQLj6o?=
 =?iso-8859-1?Q?5tDz5xItW+tLOGDRCMZoSuZmmq1dTe6qG07aIEAfN+aOzQRlVBSmO4WtAL?=
 =?iso-8859-1?Q?uD+FX+iUFvicaRV3asb3MiSdMlUqaLuGNIl7k7ze3NSF/PZwvURKeifqdZ?=
 =?iso-8859-1?Q?leDcxKEtU1GqLlNlXcI75+7enLjlVjE9cF/aF5E/4vVJpjL5PQBJBT0d4q?=
 =?iso-8859-1?Q?i27Vhqgq8K2y3XK3lgyNK4nLhzXJutlCRrlRIq0lkl3tcQ2IiLpWV+9O+w?=
 =?iso-8859-1?Q?UBxviZotkPQGzmCtTOULZm44SeQZR6hZ4K9hep4hbMl7jh6xqasmpk8M1K?=
 =?iso-8859-1?Q?MH+7Y36J1F36QeqxdxRS9Vz3UopjlPMVm9TqVvPzgOLcdCUwoFn5mEvLvC?=
 =?iso-8859-1?Q?rMwlTffGUxfKG78SF96h4uAibuTt943LhyxW7sXM4+KfABXP3dAbTWcl30?=
 =?iso-8859-1?Q?oCxV4q5BSNWEcI17pNrGI7N89nuTb/V2RYiLm7CIk2jHUZZksFhgMK/+oI?=
 =?iso-8859-1?Q?w9Zhu9ODS8S0n9ez9x1T3GDo7zUJcfquCs/heRR9ROVKS80sTxMhCdvTZb?=
 =?iso-8859-1?Q?rpnOQ7JR57S7tXSDB3/7t2nCH0AvDGEbDXxCJxqcLt6MK1IKJEO9HEt7Wt?=
 =?iso-8859-1?Q?sS66lAf4pE2TfSIgMZJsLrdFimtcvyji0XNj6b2emHmvXbHp+C6shb+gy5?=
 =?iso-8859-1?Q?cMxb2Sst/QTigPjCGZoQ4E4mg1RZnJTPhSVEwX/IRq5mWIRzFbDHVnA24K?=
 =?iso-8859-1?Q?beoIgC5KP5o62qEV0DKVa7KLKlpV20Fi+kgJSRUq26/wYS/XNWPZbkfDP8?=
 =?iso-8859-1?Q?v+oQkozjeR6k415ixN11iyv6aOmNYV4F1vW6rzEU+0Da88vDd0/jSQohkG?=
 =?iso-8859-1?Q?bwqDyfowxzddUv+MSTRWCpDlRYeSpMcX6h5OOk8hF++DUSGnKbMd/Oka35?=
 =?iso-8859-1?Q?nX1saIRtDjhIQ8svv0Ps5W5CR6OCPIhSR4oxwY6w3Ty2l/8xWF2FZmG1jZ?=
 =?iso-8859-1?Q?HwSHC8XmHTydkTNsohUAD5XwV55vd0oTIBcwKEVSODsiytfhDDmGkN3KhA?=
 =?iso-8859-1?Q?5AuodqmyF3SqRRaXhR6R3vGAfP22vloPerbO9fpTeB4wEM8Jr1xBP6QW+W?=
 =?iso-8859-1?Q?yDzHuJ4XpXtpNRm/BmcucNlEgTVEaEPeBCHY2GFUT+sy3kAljHTG0CHEJ5?=
 =?iso-8859-1?Q?kiauYTIlCRL4/4XRn7CFDW2HniGUCoebNhzCsURQLaB1Cn9wTkUyN9P50Y?=
 =?iso-8859-1?Q?Wvui/5HeLjUt2vWeGvQlICs4SZsffImQN2c9KYJbpQJNtjyAZFN8tNKMlo?=
 =?iso-8859-1?Q?YnvY/FvXQD3YM6bW9/IVTDMX4uEZbCH0lCFO8Prvu2M5tGE+tmDgNz3DA+?=
 =?iso-8859-1?Q?VLvFEhfgxrYaDjxdmjS0qL6/h47n40mAYHJtmB1Y5akCaYhlgzvjzIeb+r?=
 =?iso-8859-1?Q?7MB/mjbjgfiVdxM5/K3VhNtkZKqr0Zh1v+DSrHaweRDD8rho+kAefAfABT?=
 =?iso-8859-1?Q?fH3XIS8ZMPUbQlCUlhvV+JVA+DH8Nn6yiDezEjVhqFF13kzs5vOaLGifCE?=
 =?iso-8859-1?Q?5BqKbemGHBB0+7TmjA5HALufwEu93wuqoKM54aTwEdbGpyJGA1jLUXUH3O?=
 =?iso-8859-1?Q?TWEHvOYwO4CqPfChPvAsqXlN1JMhTIsdkE?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6116.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b5b856d-ef9f-49f5-b6fb-08de3d77c2e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2025 14:22:51.3297 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZIxaD49lHbAmu5UBNlHh/fx1gbOtiQe7gVxPQKr3Vi7kmPF6JPGrkc4KvJYfFlNzDb65ChKRvz18iIYMsyV4Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFC89313B1C
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

-----Original Message-----
From: Morten Br=F8rup <mb@smartsharesystems.com>
Sent: 17 December 2025 19:44
To: Richardson, Bruce <bruce.richardson@intel.com>
Cc: Mandal, Anurag <anurag.mandal@intel.com>; dev@dpdk.org; Burakov, Anatol=
y <anatoly.burakov@intel.com>
Subject: RE: [PATCH v3] net/ice: add MAC anti-spoof option

> From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> Sent: Wednesday, 17 December 2025 14.46
>=20
> On Wed, Dec 17, 2025 at 01:37:16PM +0100, Morten Br=F8rup wrote:
> > > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > > Sent: Wednesday, 17 December 2025 12.53
> > >
> > > On Thu, Dec 11, 2025 at 03:22:32PM +0000, Bruce Richardson wrote:
> > > > On Wed, Dec 03, 2025 at 03:47:08PM +0100, Morten Br=F8rup wrote:
> > > > > > From: Mandal, Anurag [mailto:anurag.mandal@intel.com]
> > > > > > Sent: Wednesday, 3 December 2025 15.36
> > > > > >
> > > > > > Hi Morten Br=F8rup,
> > > > > >
> > > > > > From: Morten Br=F8rup <mb@smartsharesystems.com>
> > > > > > Sent: 03 December 2025 17:11
> > > > > > > @@ -1761,13 +1763,39 @@ ice_setup_vsi(struct ice_pf *pf,
> enum
> > > > > > > ice_vsi_type type)
> > > > > > >  		/* Source Prune */
> > > > > > >  		if (ad->devargs.source_prune !=3D 1) {
> > > > > > >  			/* Disable source prune to support VRRP
> > > > > > > -			 * when source-prune devarg is not set
> > > > > > > +			 * when source-prune devargs is not set
> > > > > > >  			 */
> > > > > > >  			vsi_ctx.info.sw_flags =3D
> > > > > > >  				ICE_AQ_VSI_SW_FLAG_LOCAL_LB;
> > > > > > > -			vsi_ctx.info.sw_flags |=3D
> > > > > > > +		} else { /* Enable Source Prune in Rx */
> > > > > > > +			vsi_ctx.info.sw_flags =3D
> > > > > > >  				ICE_AQ_VSI_SW_FLAG_SRC_PRUNE;
> > > > > > >  		}
> > > > > >
> > > > > > This looks like a bug fix related to Source Prune?
> > > > > >
> > > > > > Ans: Not exactly.
> > > > > > Initially, Source Prune was disabled, and MAC Anti-spoof
> check
> > > was
> > > > > > enabled by default. This was done by following:- Source=20
> > > > > > Prune is disabled by setting local loopback with=20
> > > > > > ICE_AQ_VSI_SW_FLAG_LOCAL_LB flag in the Rx direction.
> > > > > > ICE_AQ_VSI_SW_FLAG_SRC_PRUNE is added to prevent transmitted
> > > packets
> > > > > > from being looped back in some circumstances.
> > > > > > Now, MAC Anti-spoof check can be disabled by clearing both=20
> > > > > > ICE_AQ_VSI_SW_FLAG_SRC_PRUNE and=20
> > > > > > ICE_AQ_VSI_SEC_FLAG_ENA_MAC_ANTI_SPOOF flags and setting Tx
> > > loopback
> > > > > > with
> > > > > > ICE_AQ_VSI_SW_FLAG_ALLOW_LB flag in the Tx direction.
> > > > > >
> > > > > > As we moved to making both source prune and mac anti-spoof
> check
> > > > > > disabled by default, I thought no point to set=20
> > > > > > ICE_AQ_VSI_SW_FLAG_SRC_PRUNE during source prune disable and
> then
> > > > > > clearing it to disable mac anti-spoof.
> > > > >
> > > > > OK. Thank you for elaborating.
> > > > >
> > > > > >
> > > > > > Thank you.
> > > > > >
> > > > > > Regards,
> > > > > > Anurag M
> > > > >
> > > > > Note to maintainers:
> > > > > This devarg is like the Source Prune devarg.
> > > > > If we want to elevate these exotic features into proper Ethdev
> > > APIs, it should be done for both devargs in a separate patch.
> > > > >
> > > > > Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>
> > > > >
> > > > Applied to dpdk-next-net-intel.
> > > >
> > > Unfortunately, this patch causes changes in the driver behaviour=20
> > > leading to CI failures. These issues can be seen with testpmd=20
> > > where packets
> are
> > > looping back inside a nic port unexpectedly.
> >
> > Can you please elaborate "packets are looping back"?
> >
>=20
> When testpmd is configured for mac forwarding, sending in a single=20
> packet leads to a constant stream of packets being handled by testpmd.
>=20
> > If the packets egress on one physical port, they certainly shouldn't
> ingress back on the same physical port.
> >
> > However, if they egress on one virtual port, and are internally
> switched to ingress on another virtual port on the same physical port,=20
> I would consider that expected behavior - the same would happen if=20
> those ports were physical and connected to the same physical switch.
> >
> > If they are ingressing on the same virtual port they were sent on,
> that would seem like a bug in the NICs virtual switch. A physical=20
> switch normally wouldn't transmit packets back out on the port they=20
> ingressed on.
> >
>=20
> Not exactly sure what is happening internally, it needs some=20
> investigation.

Sure sounds like it.
Let's hope it's only testpmd, and not a broader issue with the NIC/driver.

>=20
> > > Therefore, this patch
> > > needs to
> > > be dropped from next-net-intel.
> > >
> > > Can you please do a new version adding the feature you require
> while
> > > still
> > > keeping the existing default behaviour.  I'm going to move the
> patch
> > > status
> > > from accepted to "changes requested" in patchwork, in anticipation
> of a
> > > new
> > > version.
> > >
> > > Regards,
> > > /Bruce
> >
> > This sounds like the CI needs to be fixed.
> > Why does the CI expect this kind of filtering to be enabled by
> default?
> > I wouldn't expect other NICs to perform similar filtering.
> >
> It could well be a testing issue, or a combination of incorrect=20
> default behaviour and a sub-optimal test case. However, until that is=20
> fully root-caused, I'm backing out the patch for safety.

> A new patch with reverted default behavior seems like the proper short-te=
rm solution.
> While investigating, we can live with the wrong default behavior, as a "w=
ell known bug".
> And the configurability will be helpful for root-causing.

>=20
> /Bruce

Hi Morten & Bruce,

Please note, when I sent the patch[v2] with MAC Anti Spoof enabled by defau=
lt which is the current behaviour without the concerned patch , then no CI =
issues were reported.
PFB the reference.
https://patches.dpdk.org/project/dpdk/patch/20251116035749.45922-1-anurag.m=
andal@intel.com/

Root Cause of the CI failure:-
Source Prune is disabled by default while doing that we used to set ICE_AQ_=
VSI_SW_FLAG_SRC_PRUNE flag as well which is added to prevent transmitted pa=
ckets from being looped back in some circumstances like the one CI reportin=
g.

Now, if we make MAC anti-spoof disabled by default , we have to clear/not s=
et that ICE_AQ_VSI_SW_FLAG_SRC_PRUNE  flag and  set ICE_AQ_VSI_SW_FLAG_ALLO=
W_LB flag.

Hence, my initial solution in patch v2 was to keep source prune disabled an=
d mac anti-spoof enabled by default.

Please let me know the way forward.

Thanks,
Anurag
