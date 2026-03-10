Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E389FFD2D9F
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 14:08:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CFAD0402DC;
	Tue, 10 Mar 2026 15:08:58 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id F0F26402BA
 for <dev@dpdk.org>; Tue, 10 Mar 2026 15:08:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773151737; x=1804687737;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=3COAmr8eELSxKI8rkJlzEH/rfPO62cC41tzr/d4iU0A=;
 b=dVbwkK2OrCvSCLflxh/F3pmFQRpLMdQd5Lkk+uKMdjiqdt7DlV/1tICQ
 RAYHztfQppx2yJycJGepGtBZyreHPETy+DLPvy07ixL9RFzH6QhEw8h1c
 b1f9yeFPTk1Wfg4u2M8oSLJBOoRZVoNbbbEkwsBp1/sXU+sFBj8Jr10Vf
 1ciFKBpK608TD7FTC03vVnp8a2IwDzkJKmCT6r4Poy1N/xJ2TijIZfBU6
 dRQbnobql7/LSp8qFuOAPHpl4zzyjllkcqB0fp6i/UJwI2CbUtbQ6yIgq
 6jB6KJi4+PoYO8coaJjE/Ee9R+1ZYA1TB9Bm87Cpui97oZJmCbASkllC6 g==;
X-CSE-ConnectionGUID: deMiwMDiTrW7BfTwhtQGmw==
X-CSE-MsgGUID: c8mp/FrgRxGusTlkMT3f6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="74277048"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; d="scan'208";a="74277048"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2026 07:08:55 -0700
X-CSE-ConnectionGUID: oEqWm9DLRcusmDdaB6oFew==
X-CSE-MsgGUID: SGgkHpLGTs2JdKm1mQ/zMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; d="scan'208";a="219254663"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2026 07:08:54 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 07:08:54 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 10 Mar 2026 07:08:54 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.56) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 07:08:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lcJbQRm+hVxxP75Tg+JrGfNdN4HUhTtQ+OR5VWmqduFsiw9vaRXWPI/sj82E6eZiKIaLur4Mle3WhPpp5mIJ68EEYDwhNp1xKu4symOP7mpv+OwKGH2y9NzcQAjbIrj+xaSQF4lu0YyfpqhpeLHDT3PWxjcePNDamY1uN8vJ7ZoLRt388N0640b+LQF25XBbtSxvWJagMAhyinKRX3Ylk55bv8H4qmKxuERn4WbIaHJYB+0Ho9sovWFClHNdz1Z6zN+fBHzdsirdERHKc/W80UGH2FBWdbygkypYKdk7AHbxNj5k2+9/Ge/F9EuCQDLGxcDwEEey6ynF81+R9M87rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P4sVfCNDyww9FNo9fYuqb1+DMofMK3BR54IrcFSXGkY=;
 b=X3YYoSXd7+Z30Yb5rN/wiIjxk3gkJaCIon7K8NoHcv56rnkwnFegZ1Lo9v6XXVSFOfCKEHYVQVnGbI6b7HKjBpcf6UStyDhfjSdj7cBCGzbKdrKcrowMw4AhaQo1TRlNAkf4ViYaJbzgW6gA4QvhouRGBikyUn0rZ/9NvqHme3Gpk0Odks0QOcV8W4NdrD0fX4g/lK+dOK+6PWqC5mahTVGH16F2CTVY+vJ4KoQH7arRfHRY+6F1GYopv4ywz5Y7c2XJ6mjH7LFXqB6yDt3cDUfyhHOGVYqW1Oqgab3gAEB/1s88RNnKAPpVD3xO2VziZGx734M9Ok0uBYJSTsugLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH8PR11MB6729.namprd11.prod.outlook.com (2603:10b6:510:1c5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.9; Tue, 10 Mar
 2026 14:08:45 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 14:08:45 +0000
Date: Tue, 10 Mar 2026 14:08:40 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Soumyadeep Hore <soumyadeep.hore@intel.com>
CC: <manoj.kumar.subbarao@intel.com>, <aman.deep.singh@intel.com>,
 <dev@dpdk.org>
Subject: Re: [PATCH v1 0/6] Update ICE Base Driver
Message-ID: <abAl6HmyKhiUdPyt@bricha3-mobl1.ger.corp.intel.com>
References: <20260310095218.703423-1-soumyadeep.hore@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260310095218.703423-1-soumyadeep.hore@intel.com>
X-ClientProxiedBy: DUZPR01CA0040.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH8PR11MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: f9b1b4cc-a186-45ff-dac4-08de7eae8ad9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: nEW12ghTeFVFg8zcZLxYsk1Vkt7IRRfZ0Xz+3AMlMYlGqhUSeW4nxnUhJD/9YYR3O1STuE11la3bQnzMDBcNlqZKVUtpwCZh+nLVvcKmrKMWNnDmyLSo0/HwdKw4BucRKroAdtKztd/c9Y8JDn2zSKeBMnhWhVuoKmjdeD4zENxpjGQsm+apLMaYskPWcc9VO9XsIbqBHpoSL8YTsyAZR6Ey5Fi9Nv8Mgr09Qg1aY7q4EdK2Z7rIygw3OxUphMv/+t32kny1Dcy4tR/MqEMx8i1qforEF8CosBXMlfuUdeJfVkq99/UReZF2e4hS5KWy5Y2s1TBOqiQEDJNUO4kjC+8mKfy3YE2k3erNG+XdkYUWlqe6BN7gJpJj0dZ+T6Wmf5C97qwNw4dHBzM/7agCLsNy2p3pPQmw6tu5p9JXn3a8fCkHC07iPhfU1YjVINgPIsOySHB3YQzIAmbLRIP1qIv47dpSPnCL7ouGGfPOphqkpkSHgkZOitHjoDyiMfFpDmBwqvaiOdlxMl5gGykZZrLC00SYQKqupIvwi20Uqwlx4xK0995bHdujzmSxSoMLz3RpxAkqcHFGJPKX0G0T/DmTgd7c5ygvM+wmWiHCTYbBcthBitO27YHk+lZdvb+Tj6aDhCs2aX/X1bULIdVLn2tmCcE5L4T3Lu4B0O6HZIJFEBxBTCWv6VTBIukb+ap7YW4y6fCvW5QryGwpEQr34otUbfOJaiENw3kzbX/rwCc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ERcwH2jbdU/JQAqCafmeWFHNfYcQwvBa8/tU1s9KFafnhTlvK4RBCqKRAD/4?=
 =?us-ascii?Q?f6XuIcB+QfTQxWohSsVui6SZTterTBploYQiIqjpZPWNqnhtutc//dEsOTrX?=
 =?us-ascii?Q?Cbd7kmhub2L9LbHP4igo8MH3ghWzKzJy3jpb4YfYw+tWFGM42EXT0Pb39lvc?=
 =?us-ascii?Q?wZ7Dpc1T4FKay8r2mAGhVwE42bIk8MwJzxC88/+yXKOiCgZiB0xq6IM/lHw8?=
 =?us-ascii?Q?7hLlmwCWoEXLMSvI6x+s77Kf0BDVlZqrYxRVEgZjX4nNVd5QHM9bC5VtHX1G?=
 =?us-ascii?Q?p9tYXWImgjKQztddn/WEX+XWtRHnNTVRLSVLJpIp7U+kZeaDLvasAJpNFBUp?=
 =?us-ascii?Q?iqw1v2V7zf04DpllrlJxk8FPTzKhGaaNoJVW5B3Ib4YMugH+SoaPCL+48n2t?=
 =?us-ascii?Q?5r9ViS422laHh8qYc74376tjlOftf2cplDeFZgNpKP1KyiLQlyHIx2/ptzzS?=
 =?us-ascii?Q?ZDU/7QaXUtStksCvenHBPqIV1q8JzOhlx/yDq0Vgze+JXFw7byyYbPmpQnSj?=
 =?us-ascii?Q?mWCU+pqZYipOoo04PxzzxLRzFPU6p47gKfDpCfyOs8pU3GiGmMgqHFjwf/ps?=
 =?us-ascii?Q?apvk/qeNv2/oKQTsKg8ta0RvvwkfkEGAn6MHKwOMUu5u/Dm7grCm5N3mojY2?=
 =?us-ascii?Q?CTrl3vYZ4qgrhAoBzpFUJVW/VFDra1zIe0rWfWmBWTDR6hv6JnFv9/r96CE7?=
 =?us-ascii?Q?uw4wn8/ZZkrtaH4Wy6WkoXETZskWitjym/SBoCltD7OhG+5vm/8/oo5+HHhs?=
 =?us-ascii?Q?XDZAxoSIu5UH1xhDYW7MGprZlRsprlmbUUUTyN7Kr4jgemIQwu86sXQ/9lEo?=
 =?us-ascii?Q?vdiaw5d0hdeosRw187ZbqaBnohln5pjGp+a7W8QcSDfVmDljRWdUxHRjrN9e?=
 =?us-ascii?Q?w2kVwkV/otgPZcoD0dbAwPz4tC0uxeG5TVgYFHrOKgbnZ7DQ8rhbIsXZw8tF?=
 =?us-ascii?Q?52BGV2w4wrI9Dz2B3n243yDk3RMT4DOGS4Tu2UXrQ++b25LToeIbEsteGXyF?=
 =?us-ascii?Q?bMWZKRjPL6MOuQhxeYADEBTvP7gwr3Nn/ft+bbmnM4hYKZVthzGM9hHkpzkB?=
 =?us-ascii?Q?kFTrc88ru1cqRj3CzFBifTupFyuqki8HonjB55SZMxruhhlPdLdnI27N9C9A?=
 =?us-ascii?Q?/DhQIQhTey/XTXz7PEi6jMnrIoMTWkXbOndUjJp8amMQUsGK86QMobleR3xy?=
 =?us-ascii?Q?m5abAGOyT8nMSGASCWnycEqFk1AnoFotJ5tSRbVNs9A3rG3tPv3lQBq8Quso?=
 =?us-ascii?Q?nc1pOI3nyKgNEo04pz9ahmPUKVq1c8IdBlZSV7hYbUMGvdW0ki3LqkDGEjDu?=
 =?us-ascii?Q?Tl91VWW4IIQnf5oX5zn4UHeqYER7+Dv+pD0ZdbSGv0wX69OMr3wY21iJOH/O?=
 =?us-ascii?Q?z7Trv5SYQ/NSiHzI21gPX88fZ4ek6Wmuqr9TUpg4S568BTe0ssLAZEXwvlyO?=
 =?us-ascii?Q?C9k67pppm95B//vcnAsRb+bO4AnKTLS2uMDActeKeOnuM6OkvyJLeXqW7vDG?=
 =?us-ascii?Q?iIrdlMRSrMwhKUd3ZwF4XBf9g2XG+4TmGwXddtDs0UwGrgLYiiJqwcWqFmKt?=
 =?us-ascii?Q?VoPccLgvTunSgyi9joq+UUo/8huiSPHiNYZXV3NzUZZVxH0iItPAZZPib7jt?=
 =?us-ascii?Q?mxtrZ3j1QwewuHnNBe98KWvh7zvNN0lkMEbWG54e72GY3bme67W885C7nyxp?=
 =?us-ascii?Q?/e9sPGdY3rsC3vXWnNaM6nOO8AUL3pNmtIWosYCUAoHf6HW36uIVf+py478Q?=
 =?us-ascii?Q?+6uxZbLSvJs5iAWpXcppUOsFtQ9LBFQ=3D?=
X-Exchange-RoutingPolicyChecked: XWdB8RMyliVnWXuNsS28zE1leTQDyuwzN30e0ZuAznGEW5AuoE/GSplSHoxb4iieFU7wmHOs3mMVSyTA0Sq2LtVB/AKVnK/h2mbJi4/k/rH3Zuk2mD6nAYqRqn8mCJOg5JFtbpCfDYlqTy+ZxWHmOUgF6DBdlG6+vs/DZcSSaoSKTOPvzas6bCEpbgUSBiUwswYgqd9YMS/bbnMpRXXWnMKP4oIlMgRPrkR4rO/+MHoQVzPBS6zAATCFt+rtKEDpwrM3CotryhijCwgVYBHjDfKndR4cRHlymUZY+dua4e6P9MzyR8qil8pej5zK6QLuskJfUDEbOIvzuO3fyHt++w==
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b1b4cc-a186-45ff-dac4-08de7eae8ad9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 14:08:45.4123 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xvgjyTeXjR0BR8Oz+tQI8WyYhElkLxl6UtL9SW9JG8v+5VGUjUy0tmDFiHWmoGKoqc4DxtgeIncmwrnq5KTOvbkYlYbBCVwx31EI9MGQda8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6729
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

On Tue, Mar 10, 2026 at 05:52:03AM -0400, Soumyadeep Hore wrote:
> This series updates shared code of ICE PMD.
> 
> Aleksandr Loktionov (1):
>   net/ice/base: enable LLDP filter control for E830
> 
> Grzegorz Nitka (1):
>   net/ice/base: fix 'adjust' timer programming for E830
> 
> Maciej Paczkowski (1):
>   net/ice/base: resolve comparison-with-wider-type violations
> 
> Paul Greenwalt (2):
>   net/ice/base: update crash on invalid topology
>   net/ice/base: support RDMA on 4+ ports of E830
> 
> Pawel Sobczyk (1):
>   net/ice/base: add pending admin queue events API
> 
Series-acked-by: Bruce Richardson <bruce.richardson@intel.com>

Series applied to dpdk-next-net-intel, except patch 4 which is a no-op
change for DPDK itself.

Thanks,
/Bruce
