Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E2D606A33C
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 10:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LYkDrkXs
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C957040281;
	Tue, 10 Nov 2026 11:52:04 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTPS id 190E44027C
 for <dev@dpdk.org>; Tue, 10 Nov 2026 11:52:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794307924; x=1825843924;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ssMnUJJCh49luDd04I31blQMK0zS1RM0jsEO2D5FItc=;
 b=LYkDrkXsvb5D3ACyoqizZen477TSWkdrVB+etXq96ZsAPTTsjkM29dyS
 ppa5VGLwjMQl/gpvX97oEp5J7lQiYunEhbJs9MmRjbuVr5SOWwil8caJu
 vgu3H3rh6ZGlmkHYkB/Y7xM8naLwCqIZwrGPSVmKU9yZiDoqspXTcqpUf
 N1Or5XHkN0NB9BAQ37/r2XscXZAwDCKQWqtfuexmKj/6ulshaQqWlbz3V
 OEJ6sMEJwAblqgPf4CXVH1GxP2uzl1STKcSpR1thj3Cw8npfJtvL+0B54
 6kQ6v0PvLB5fHJ+lCmuEWXd6nC3d0uoq3Yhl7RiIeMpuIoLpL8cywDcy/ Q==;
X-CSE-ConnectionGUID: NIug4mBnS8am0TlKUUWs+g==
X-CSE-MsgGUID: lPoHbFxMQ16srUPH4WHSiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3084660"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="3084660"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 02:52:02 -0800
X-CSE-ConnectionGUID: ibGa2HiqQl+tMWKHfVbHYQ==
X-CSE-MsgGUID: cBo2KSJoSaqVom/x8qoRxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="8289396"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 02:52:01 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 02:52:01 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 10 Nov 2026 02:52:01 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.51) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 02:52:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZcW1DATEDxz3IN7aSobBJiNETLzUY0wuFGtJI+N2D/55np0kgwGZO1337X7IY1WMOisgTndL8wrUM7AB8BYrz67DfCgYHlW7bra5mz8gGPz3tLQKDEIiKyoxIQEL+QtQzJ7VQgJhQ4Ms9c4nRM3hYH2UeZjs0RpUXjO2T0zSvgGMcrlShRGUO5gWZEk4J0oUTpiOglJHiP9bzS7N1qjKS7OY0HAysdqclAGaRPgXDLsMookaji63RGOl8Ii7ZTCnp97XXUOxBe4T9JcQguDDsX8VwRMnJ//zJS0Ng7UGuPfMK3tknevRiaWVCgnZBuOg0z1uu57gATIPYaZ/DhwLkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFzlBVXoEvhKH2+yQyTblUDohN5qUTJ6Ucd8CNKqsAM=;
 b=JSRLb+AX33n4Qvwp9q9YROVuDpdzB3qP38Szsbi4qXfT0kcXqBaVA5aFvoZKUb7AhmxU0YchjLv+oBoVn/ZmYngVooI/gol/6nTdz2vlsblSFDsmpufLYB5EsCHyrPRo2aRFYsb3+pQDx3aXwoji5hm2BVdZLK9cE8P1Yt1sNsTiFBb5B5sbK41iZM3LVcV7ooJWprsMZlg1O9sHgJm+OMuVFWnsbPqe5wCLYt5nlQnyRCySOvqaO1a70Q//dEPMBH3dn6wHvIkVnha6ubJcCMJjF/FDhALLPQFHmRxWS6X+zhbrYwzkas4SGMlf4NyIN9xd1W8eLwEFDkSBWkQldg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by IA1PR11MB7891.namprd11.prod.outlook.com (2603:10b6:208:3fa::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 10 Nov
 2026 10:51:58 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 10:51:58 +0000
Date: Tue, 10 Nov 2026 10:51:53 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v4 0/4] iavf reset path fixes
Message-ID: <avL3SVr17vec_YJ7@bricha3-mobl1.ger.corp.intel.com>
References: <20261105123237.12279-1-ciara.loftus@intel.com>
 <20261106094014.28784-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261106094014.28784-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DB8P191CA0025.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::35) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|IA1PR11MB7891:EE_
X-MS-Office365-Filtering-Correlation-Id: 0653aaa5-abb2-48a1-22aa-08df3f18a4a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|22082099003|56012099006|18002099003|261026140227099003|261022105027099003|261022075727099003|261026121527099003|4143699003|10067099003|261028144727099003|11063799006;
X-Microsoft-Antispam-Message-Info: gPXLxO8czd5FAcNlgS790IjlIHEj2ULeIRTxYOubZNIjFe2X+stmWAVi9wC6jfI4+Y1UhBdm7sflMVe4xP2/STKpCQr2BpmbEgwDli/zXPPOOxQFEzJFgqOz+rj0yUotbKEdwQwlazNpmgZdVlQZmpVjQ61L25Jfct2L0ujbAY6mb32qhNWxey4N6ZIL/K4erqJO87BeJskc+/8ql2YXMFkqUwxemJkpzRxAFQioOlXCe6KbbpWOB4WDKFpsFR3qMIgKtVvttkp/dDG58Gi8z+2wZ0PdpbngVuIf31AHOnLTAZS3LLmnj/qSdAQZISrZT1BZSmsF3R/QNQjN4cNZ4GiXaP0vX739kvAgjMq0lYbh4f9+o7fvBfQbYtCRDGVTN4ICuNyw09xZPulsyX54CcM+qRJxBJqeRlNlYxHdst6r/CbzZ/UKTt+N3OXGmg779jUsQc3agPuogaFLZotCI9Cax1Jh7VVmQ8C5dyz5OsM10MASFvIjwmHnmP/PF7cNxfBea9aKsumCk38NGu5F1OittThNxYJdE3XZr6dhjHqoD60NpgqCkYKGRhkIy/76e74suNmsR7I/JYSFNvjjmOGDC2NmFllyWibLLq0GJpATID+C7+W+3VV3Znxxaj0FVhZ4BXFqM1vOR/cRxNAcYXek3y3FIEoJWHpWE5shco4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(56012099006)(18002099003)(261026140227099003)(261022105027099003)(261022075727099003)(261026121527099003)(4143699003)(10067099003)(261028144727099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WjFWh9cqwfNQMIxlYNED7yhRBOPYUV0Ez6lpQSksNq8JGJko8/6/26OXmzon?=
 =?us-ascii?Q?xY7fTiI07B8y37HVEEk5jvv5pI6IiK7dV+5Or7kiDyky5ThkuENU91Q1ukz0?=
 =?us-ascii?Q?BLYVEEuVJ5LbgjFAvL7wEhNLuY6LhGCRIyUYIyrZdZ/78wD2/zEiW1n9fk+i?=
 =?us-ascii?Q?/mE+R2IVzo8QRzyV8YtnCGZw/6pMMvDRTc6zZikYF5pXmDBW8e7Wk/wP8/8s?=
 =?us-ascii?Q?Gqg8mnw5riadr7Q+Fm7imkpeahJ4SuYleB2PleEsJ51H8yVZcCVmFqBkwX0P?=
 =?us-ascii?Q?g52VuLo1UA62FbsplSw9sppfZLQyAQWDjFYO4pnmurjMUyPhIb6KSE7CNedW?=
 =?us-ascii?Q?x1momOym2eyX/+T3HuSvg45/py1PtSqTFjLghun2nvdavscOyvHwT3FlAYFh?=
 =?us-ascii?Q?2xekth2EHnl/ihN7wf8rYzjGr3J4wMmKOT4xwHMpYFZ68a0qZagZQcVmlhI+?=
 =?us-ascii?Q?4zIBRR3gYfGBRKbd+hCy1awAVv6l7C1PDZHwragraE8FqtO7wSR+kk7ncVRA?=
 =?us-ascii?Q?1F13z74LpsWGVKX9pb2QAIzPz5k8CQ6vcre+GTLs58zpcqsfKyh1ktUOKoXb?=
 =?us-ascii?Q?Ac3ZU1mNyy/24I86SN4JjUHNSH1yqjLgOlPCkzYcbwcYX7yKIqp1Dul77ksT?=
 =?us-ascii?Q?Z21W9cZ2WkKe+IIzn+dA/GnSIxM79VkTFGAmuYlP7Pz0n771zw4hGBnAxBKH?=
 =?us-ascii?Q?YpJsUYRshZD+mMNu0O8kTFqu2KDGSE3C0rqieW4mhOs3pomHAa88+zN6Lbs2?=
 =?us-ascii?Q?fI047q/+3zmyP/s7/vpIsuDp7o2aorqtRHu2HlY4XMJSOHXrc9XPv+es53nI?=
 =?us-ascii?Q?ZgURZAe58CiJR0CLGVonGX+B7ZEHHtGwc+DAaRxMa7LVakNkSyc29Tvy8fQU?=
 =?us-ascii?Q?3CkLhk+g6p2J7pX36pSWd3DHiHCewGQ7ikZWs6TD9SMYWvzuJiZRZ07W/uam?=
 =?us-ascii?Q?6zVOjm/SBVYGjWXvqcYHVpvgJ5xAt0Pq6gb9Pfza3xJWZqJ3jCyW3CR5djXM?=
 =?us-ascii?Q?F0uF5Xb+E7cPlx66sst9agXw4spAPFLqvGAM+DCrumRHrwpFnrmyr6oi1mE8?=
 =?us-ascii?Q?p9G/+GzVVfIk8Qk39hGPTrCStEARbn5EIMMQ/Xu0J6zWKgdQHp1uYZli4Q7N?=
 =?us-ascii?Q?jXiCtPbY6YMfqPLjLCxNUV6nM3NNvHa2ahzANlva6J/j9sdJxqyPSTl6L4h+?=
 =?us-ascii?Q?qTEvefo75Yy0RcUT6Kyv2b81oFoKuufyVYNC4TFLm5F1D0IP3dX9q++ppQt8?=
 =?us-ascii?Q?MJEOX5V9vD8xEOVunD9jhsXLQRt/1PdY3X5F5+pBQWECbbw2imHLXmqF2r7Y?=
 =?us-ascii?Q?62yFe5BcWWHoOz5dqslwektzyE3lINwx530VkiTy6gkkjJak74luXQpXpBCm?=
 =?us-ascii?Q?jZDQgQE15u+quWA7W9lEIYciZ6IXCT0h3yEub6WGPJQjXdTqXaTLj51ddU2V?=
 =?us-ascii?Q?u20rLMB1422yO1QVQNvYJie+LX1VjkOLysvpVGvI6V/JxqpO+26I+3MlXW2/?=
 =?us-ascii?Q?p5YBDwtwQXqIo5ulm/6VNHFjhQ3Lx8kvrrcBoraaSrnDgQ5F8QBANd20EjoJ?=
 =?us-ascii?Q?22Iiv5FtB42tjhhhm0x7XOjG+B8PQf8NaHPTDDHDhVMNz3LMHsuBOb44O3Qq?=
 =?us-ascii?Q?8JMPxYeKqFGubjDGOeMvmbHu7mBgJ2SafNXz21lZa3hJlq3B30KcQ2ErdIUi?=
 =?us-ascii?Q?QafL7HCl/EXsF5NlBNvgPbc+cqAbxwFLab3Nzy2Fy89qBc8KDQUDPlM89brk?=
 =?us-ascii?Q?U8YwpDyjeabYPx1wcO+yE2/ZOQq8Uyo=3D?=
X-Exchange-RoutingPolicyChecked: CqKP1TLhB99dNxq1kAuDMIIFWB93cEPwWLaYeBP13Dfk6BDPn3mycOLCec2rqBWdsSBiR1WM7grkmQ+04Bz6FG2bFGe48KeIN9kBoZ620RJcMXBNhzGAwtH0im75lhkDk9XmizaeHxYv0r00UBtYdsXimWy138B2zbLuRFUJcI1UvRY3Xr9SFVKdSnPifox+UwMpaQqDWMq9XfS0b4mGzfmTDncsohX2q+6ENyP4FflmCgStxBIVs+idUomj+Urjv7a1LrBrQlfKDVs1uF0W66CL6CUzWgJRman2cztfVk8bI+D1Bz1HU6dPWc7eB49Ty6WhsbYVMxdefbMTYvbJzA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0653aaa5-abb2-48a1-22aa-08df3f18a4a7
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 10:51:58.5024 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4rLLkeipKU+UjM8fYIrGYwMbJtjeuzO58a9xxvsalcSohlrdSzBb90dJ8lGsoqaYxw5RQoCnsHNV+hUhdi5dK/7xJmrHtsTbNuMeYW1m7io=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7891
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 06, 2026 at 09:40:08AM +0000, Ciara Loftus wrote:
> Four fixes related to the reset path in iavf.
> 
> v4 ( patch 3):
> * Remove overly defensive check after reset callback
> * Added a log on event post failure
> 
> Ciara Loftus (4):
>   net/iavf: fix crash in Tx drain on PF reset
>   net/iavf: fix event handler leak on init failure
>   net/iavf: fix watchdog clearing reset state during recovery
>   net/iavf: fix watchdog enable racing disable
> 
Series applied to dpdk-next-net-intel.

Thanks,
/Bruce
