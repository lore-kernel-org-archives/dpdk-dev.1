Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61990C282EC
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Mar 2025 17:38:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D5C3402E9;
	Fri, 14 Mar 2025 18:38:05 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 970BD400D6
 for <dev@dpdk.org>; Fri, 14 Mar 2025 18:38:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741973883; x=1773509883;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=Qxp9gql91WLdh3TDXY111hdz8W7IYe15ucsJjDfoYo8=;
 b=cY86Drwds8xVq7R2jj6oZaEPcz+94EQBYw6ZhYKZ9KAB89EI8M//0Ig8
 8xhzSweAMr36PcsOHUD+L1gvVony5yG+hgmvqIumnAVFbW/248GMsqYJF
 vCsaktXldjuqxd4OES0nXjwVMeV1wyaCkbIzn+Unl/f+vhnmDF3eJC+MR
 +tx5XQ6Kms4FQWEyQRjfp/Q1/nevnzvJi55Q6RjnrpcSAGbrHJt254y/f
 /KhTfzPQnW4b6Afju7LmYSKYwswaMd+SIbM7Z0/vyz5a+HI5gOG1l1saG
 PnUA4YGUCwu3LCPicvrmrZ0r9U3tDIjRgJHEahKlWS82DFPg82w3UkNME A==;
X-CSE-ConnectionGUID: x4qfrRXWSUa0d/V2OiYXdA==
X-CSE-MsgGUID: 3m6PjJYrRjOhQhoGQuKQ0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="53343226"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; d="scan'208";a="53343226"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Mar 2025 10:38:02 -0700
X-CSE-ConnectionGUID: rlQf6BclTnmxTzZoqpat6w==
X-CSE-MsgGUID: kgxRzoahQva/LYb/c2IuZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; d="scan'208";a="121855956"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Mar 2025 10:38:01 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 14 Mar 2025 10:38:00 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 14 Mar 2025 10:38:00 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Mar 2025 10:38:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qcNaORbjho4UY+btDGjnfu0t0FBuCWJUdGa9lTHlPTketYsFq4p2azz90PobHc8NCjHygfC+BJgF2yd91ISgh+SwN0ZvrkAK4Cos0VqnL+CVEfWUVLtQEmYGCSOdUxcts2qIQSWPWPAmeu9h82KNlhQBZJTHusrIVrFOe/L1R0tnh6T3xlgIKuVe9LZ9+xTry3e4rNIx99ObzrcGeIjnZpEi+oZFr82dlRBXUwUOUkcuARriINpkNzUtBOnnOQ340P1Hc0hgFFlA4T+hdPp+RDZGDoFvXysbd8p/yuWivX7SwXfK1RZO5TkmdCu6npw7vutL6F4z72ZcDQArk6gAhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGrE1rMUUrrd8waGctGxd6jEFawgkUp98e3Xx5UO3qs=;
 b=QMgnnDkwhe5DejWfsntMyHCM3eAfn3eJgrnZi50GYmiKRRnqhHyAXLEW7KP0HGQLGIOAskZYJS7s9qqPiNSuG8yhmY128/mZ2C6/cENtlDH3KFnokjMLfvb4qTOYm4aRiCPBZ/kDLOJVyM7aEkHRAc4GeoFzp+OT3dfcLtMTie3QB5GWJejS8W2mTCNFD/ldQysHmUB9O+8tOgkUTN4+Ij8ukYqVOaAYrpYIKdMSTnmGHGgCiMaXaT13KCQoUAtv2LaJb4Wpt3AcquVcLyucIInmuWYFjw4NIvIAsCuqzhH3NevCn6qVDKVpEnWsf+pzKuwHAgnB8wtgtZu05gy6uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM6PR11MB4516.namprd11.prod.outlook.com (2603:10b6:5:2a5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 17:37:57 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 17:37:57 +0000
Date: Fri, 14 Mar 2025 17:37:52 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Ajit Khaparde <ajit.khaparde@broadcom.com>, Somnath Kotur
 <somnath.kotur@broadcom.com>, John Daley <johndale@cisco.com>,
 Hyong Youb Kim
 <hyonkim@cisco.com>, Chaoyong He <chaoyong.he@corigine.com>, Vamsi Attunuru
 <vattunuru@marvell.com>, Maxime Coquelin <maxime.coquelin@redhat.com>,
 "Chenbo Xia" <chenbox@nvidia.com>
Subject: Re: [PATCH 3/3] drivers/net: build use common AVX handling
Message-ID: <Z9RpcED9nSd5qVKG@bricha3-mobl1.ger.corp.intel.com>
References: <20250314172339.12777-1-bruce.richardson@intel.com>
 <20250314172339.12777-4-bruce.richardson@intel.com>
 <CAJFAV8y7WZN59PpAjCqLnM_=KXMi8U22xvp_K5tDwYCC3+-qyA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8y7WZN59PpAjCqLnM_=KXMi8U22xvp_K5tDwYCC3+-qyA@mail.gmail.com>
X-ClientProxiedBy: DB8PR06CA0010.eurprd06.prod.outlook.com
 (2603:10a6:10:100::23) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM6PR11MB4516:EE_
X-MS-Office365-Filtering-Correlation-Id: 935119a7-0228-4185-f8f7-08dd631ef55a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z3M2MFloYk1ON2FxekptOW1BUGgrOG8xU3NlQkZveDRFaVVhTEZ3Qzk1S1Jh?=
 =?utf-8?B?K1N3UFJzMzMwZkcvYU5tQS9RVGtVczM3eERuendKdEdMOU5yU3VSMnFJajZP?=
 =?utf-8?B?dm5GeXVlTU5BYk5FMmZoQmRYdi83M1NMN0h3UmdTUi9GRnBCMEJ3eHN4MDFk?=
 =?utf-8?B?b3pjMlNZb1R3TUxubTUyZVNaV3cwaGg1aEVlMEpUcjJGeU5PVmVkclJQelZR?=
 =?utf-8?B?SXVCNlV1azRZNnJpek1VUmdHVU5CcHpDVnNTdmVTR0pHYjkrKzVwZUt5bXJK?=
 =?utf-8?B?V1ROOHg2UzNFNUVSTmRKczBpQUY1dEhMUk5POHZLOERUQ3ZVemtFdnRpQ3hz?=
 =?utf-8?B?NWNKM0dramhhY0tsRXA1N2QrQ0F6UUI4alVzTjE1T3EwYnNiNTgwVUtDdnlx?=
 =?utf-8?B?TENOYXd4cEVIMEc5ajVHakEybEpNRXNOamZvVzB3NzAzY2d1YmdsSUEvMVpo?=
 =?utf-8?B?dHpaMkZjdVhuQUtrSGhteklrSjlUZDQxckF1QUFWK3FhOTFQbzIxcEhqMjNM?=
 =?utf-8?B?UzBqYUtKSHAvMTNXODF1K1dzVDZjd1VVa29CNlVCYW9rdFdBWlo2TU9SRnpF?=
 =?utf-8?B?Qm01eWJQdXJzTkJZRlJiYk9vTWx4ZDdHSTA4NmdzOE45TTcrVXRaa1BRbzZI?=
 =?utf-8?B?WFIvckw1TW9YYnpTRHFTTHFJNGJyUkJGMTZCalJvcFJSd1hKSXpUd3RlM21N?=
 =?utf-8?B?TXJwNUpkSTVIWTVOcWVldXQ1aUtZbWg4RlhhSE5VMjlWQ2ZrbGRCSm1WWmV6?=
 =?utf-8?B?QllXc2tWWitEMnF1OXRZb2NnM3oxSXdDRWVuZjY0MXdEM29VaWRRKzdWbWVl?=
 =?utf-8?B?TnpkT3AyUDB2N1hhbTlyRG5BcWxQcTBaQU11dzlMVDlWcWVrNm0zUlo0SXE0?=
 =?utf-8?B?REFsNEN3SjdpUjhjemR2N2psN2NKaHIyckQreUZYZkZ1VzJ2VlRoV0s5Z081?=
 =?utf-8?B?UnVlclNucXlKUEV2Z1o0VXNyOHFwelE4dS9Gb1NteU14Y1k3QTJCRm5MNGtF?=
 =?utf-8?B?WXZOY3FmajR2WWF3cUZLQVVBVG0yWXZ6ZEs4dEFvSXVETEx6NlFXdzlGWnpO?=
 =?utf-8?B?SmFFeHAra0xWWXVoakl3NExINEVFZy9YSlhjVFVWZHRZY2Z6NkNlaTF4WENn?=
 =?utf-8?B?aUlsT2UwNGZFYnp1Yk1objYzMCtxVGF4VnBLVTFGdjJURHJueU5zMTVRZEtL?=
 =?utf-8?B?d2VtN1pBMkJYbWZSNEgwNTRuTGExZURmL1lTYWZTSitnSXI1VUJFV3I5Z3Fj?=
 =?utf-8?B?UzQ0TFR6R2VCazlCTzBVMXZwTGQ0M1RsZWk1MGttbFdHNll3QVl2cm52ZllG?=
 =?utf-8?B?UWFVZFcxejZUTFhzcStYNDhhSHo0cHJ4cm9rb0tWNTlxdzFydjFBQkRaLzRW?=
 =?utf-8?B?dy8vdXdJMnAzWFFWZ0IzaURZVFd1RWdqT1BqOUIxVEVpMkwxT2lpdnM4TlBQ?=
 =?utf-8?B?MFJDbXpJR2pRaittL0NhZGR1REhiNzlQVXJkeERpMkNDVjUwYmtJMHlEVlo2?=
 =?utf-8?B?T24yWjRLL1Z6NHlmRGtFcCtMV0tOWjdsbmRDekRpemJRQTVKWkl2dUlpbDdC?=
 =?utf-8?B?cmx5RUlMaVMwTWtLSmVGSWVsbHliMDZobnRnMTZCL0drZHNTbjBMV1h6cTRt?=
 =?utf-8?B?aFhJV1Zrb2J0Kzh0ZG4xNkdPdUsxOUJ6MU9obndKS2ZjWUhNL2d0WVhuWGox?=
 =?utf-8?B?U3VyQTdBNy9zb05zODQwVGkzZTBxSEJaeWVsekJveVFEUmlkMjlhdmlxYzYv?=
 =?utf-8?B?aFg2R0xJTE5KUVV6MlZ5cTg0RzNqZHV5SVUyTHREUGpFdVV1VGR6TG5tUFJT?=
 =?utf-8?B?TUtEWE9QSkhrQUYzWFJCd0tHTHdVSFJnOTRUTURxTFl0VXl4eHRJM3orMm9i?=
 =?utf-8?Q?cs9ipoTN17ehz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTlRWWNxVXJwRXBqeFlZdWEyM1hxRVAxQ1k0aFlnZ1FoZVQzYWlEcDI1Sjlm?=
 =?utf-8?B?NXF4Wk1jdjEyTHFyT3llckJVVEw3d054ajdGRXV0ekk4d0NqeXkyRXZzRlpS?=
 =?utf-8?B?WEowQkI2d1VFbVZmOUwrdSt5L05aaGkzeGZOK1FlQSt5eHBYK0ZhZUMyRkRW?=
 =?utf-8?B?c0hkY3ZrYnkvSHkzT2ZsTEFlZjd4L0E3NGNzczloa21JcWY1b2M1OEhWNnY5?=
 =?utf-8?B?YUoyVHZnTU9MUTFOWU8yREhPblAvSTJ0ei92YkR0a0VVMy8rcm9iZTFYdDlt?=
 =?utf-8?B?SHF2bkNaYWVkN2ZydWFJTWZhWHVKWlF3YnA0d0gvZ1A2MEF1VDhOcGJtUWM1?=
 =?utf-8?B?bU0vNk4vYU9Ud2c0NTZQWW9sME5wa0dScnowZjB0djVKTDJLNUZFL1FZeW1w?=
 =?utf-8?B?bDdUR1RpQ3ZnTTZhbEJzRWk4R3QxSTJ0UG5LMGJ0cEt4WkZIWWRlR29EMEU5?=
 =?utf-8?B?K1I4UFBHSnM1L0hSclRlNXJ3aEtUUEVqTHk2WlFJOS95RmdzZHV0dEtEc0ho?=
 =?utf-8?B?OHpaL3Y4UDNJWkpKV09QTFRDeGpQNEJpSUpkZ1BsZjdTOGpzcU1KYzNVY254?=
 =?utf-8?B?WlRQNFpHbHZRUjg3azNHNXA0d1J0MUhYd2k1Ti9pK1lsdzYwZDUzdlZJWkJx?=
 =?utf-8?B?R3dxT1FSV0Y3Q2VnM0F6b0tQWkM5QzBoRE9CZE9LVzZ5QTNnb2hqa3UwZzl0?=
 =?utf-8?B?UG9XY2dKaTU1RnpIdFJHWEU2RXBoTHJacHVJdzhSdGFSVGpoTGVPeUM1eFNL?=
 =?utf-8?B?akdxQS90aXBPT0xWb0ZoUzNMdEdOL3pZcnlvTHVhRnlIaW5SbmRiWDhYbFdS?=
 =?utf-8?B?c1NtNzQvK2p4VkJEdlBWUVN3R014amdVOHdEc1BLdU5JNDAwZDNEbHRkNGJY?=
 =?utf-8?B?TXE4Zm01L1BqMUJpUDlvMXBoNk5HM1ZiUmFObUVWV1ZNWmhESHBVN2FpcWs0?=
 =?utf-8?B?VlRxdGxTN0dQYXpkcjZCc1cvekJaLyt2SGNEMWZmUVBzL1N5NzJpdVI4WWJL?=
 =?utf-8?B?TFpGODRPUHVnT1gxaHBidmZrUjJYOVFEc2ltekZmd0lIa1gwZGJQVXV6THVx?=
 =?utf-8?B?WE5KUWxwOEw3QlJ6Q01xdU1EQmhIWHVRNGE2QmE1YytVQUErMWpmOHlJeG9v?=
 =?utf-8?B?OU9DSHlSOGdSM1JqZGRBNGtwbFpWU3dKQUcvb1A0MXhlQmVvVUNsdjVVRVhh?=
 =?utf-8?B?dTYwZ2l0d3l4NjV1VU54SHovSVVZS0FpdjA0dnVFS0tHdXE3OXBZbFhtMnhv?=
 =?utf-8?B?L2E2d2g2bVBubDg3OGxDSnVuMzVyZXhwZmZZKzFxZGlDdE5KcUcwcHpnamdp?=
 =?utf-8?B?T09OZTVVTy9XRW52SENCb0VnUzdKV0pwQk8yYmlsd1g3U3VlKzVtVGFkcWtm?=
 =?utf-8?B?MUFBOGN5eGFRdEpBaWJWUGc1dTBEUE1kMWJwUU5NWDJQQkZVL2d1MEswbmEz?=
 =?utf-8?B?WXZRUlVYcUVEYWJXMWtFNm8vZDh0bEd3Q1RRc1RUOEVlT2wvcFNpM3FCc1Vv?=
 =?utf-8?B?REM5bURjMTY3a2luVzFqazJVU0VzS1NqOWdQdEo0WVh2TjI3WHRUYmh2WCtL?=
 =?utf-8?B?aWZZaTBkOGF6cXA2MWVETTVVaDVsSEZvYmdrNVFydnd6MmFoSUhudkE3T2Fi?=
 =?utf-8?B?WUVCekhtSVh6RDJCZ0xRaGVRb0tVbmoxd0FDb3ZBQXRMS1l3SGJ2MEFsdEp2?=
 =?utf-8?B?ZmJlR1BwNVFsRktyZk4rdWJvUjVqZHFXbzQ3K2JZM085SlY2OUFhZGhMR29y?=
 =?utf-8?B?UC9JaFhzdEQySnphS211NHJEMDlQSi9MSjkzalVOMFRLREZZVDZtNEt1cUJH?=
 =?utf-8?B?SjdlQkFxcTE4Zis3SzJzQmJvZDN3MDkwL084YmlyTFRrTVF1MGxHeTlSY3gv?=
 =?utf-8?B?UkxySTRxMnRvRitTb1ZHMG50Sm80SWgzWCtta096czZ2SDc1RWNkZ2MzRGtp?=
 =?utf-8?B?bWVLR3ZRRE1mOVorRklXeHhNOHFGSFNqNjNSbDhDM0JKU3B5dnkwQmV4eGF0?=
 =?utf-8?B?cTllUXc0QytmNGd4MjR6MDQrN3ppK0lzVHM1Y2VHMDloM1N2dDBwQ0Ywbmtu?=
 =?utf-8?B?ZFNKOSt0U1RSR3NDUEJ0OStvczIvZ0ZUWUR4OEZkZzR0MkxGT1dvQUZzY1RS?=
 =?utf-8?B?MTZMQ0UwajFGQWxaZGh4TjFjZDMrVk83VEJEdUR0cVlxQnNDZGtCRWR2OXlr?=
 =?utf-8?B?b0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 935119a7-0228-4185-f8f7-08dd631ef55a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 17:37:57.5096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +LYggQ56lIcMDonl7FAwE0Z0Oamob8RZpIUfIP5n+x4KJaN1FWTedbH0yPPWQYpAGF5knxJ5CxhaSaDn9UpO7T7xZoSi4mbh9MG7WJjZ9s4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4516
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

On Fri, Mar 14, 2025 at 06:31:08PM +0100, David Marchand wrote:
> On Fri, Mar 14, 2025 at 6:24 PM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> > diff --git a/drivers/net/octeon_ep/meson.build b/drivers/net/octeon_ep/meson.build
> > index 1b34db3edc..9bf4627894 100644
> > --- a/drivers/net/octeon_ep/meson.build
> > +++ b/drivers/net/octeon_ep/meson.build
> > @@ -15,18 +15,8 @@ sources = files(
> >
> >  if arch_subdir == 'x86'
> >      sources += files('cnxk_ep_rx_sse.c')
> > -    if cc.get_define('__AVX2__', args: machine_args) != ''
> > -        cflags += ['-DCC_AVX2_SUPPORT']
> > -        sources += files('cnxk_ep_rx_avx.c')
> > -    elif cc.has_multi_arguments(cc_avx2_flags)
> > -        cflags += ['-DCC_AVX2_SUPPORT']
> > -        otx_ep_avx2_lib = static_library('otx_ep_avx2_lib',
> > -                        'cnxk_ep_rx_avx.c',
> > -                        dependencies: [static_rte_ethdev, static_rte_pci, static_rte_bus_pci],
> > -                        include_directories: includes,
> > -                        c_args: [cflags, cc_avx2_flags])
> > -        objs += otx_ep_avx2_lib.extract_objects('cnxk_ep_rx_avx.c')
> > -    endif
> > +    cflags += ['-DCC_AVX2_SUPPORT']
> 
> Could it be set by drivers/meson.build?
> Similarly to AVX512.
> 
Yes, but really I'd rather see it removed. It's now the same as the defines
for x86, since we always build AVX2 support when building for x86, because
all compilers we support can generate AVX2 code.

/Bruce
