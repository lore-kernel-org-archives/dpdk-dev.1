Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219E9CD4F26
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Jun 2026 07:23:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4FD9C40264;
	Fri, 26 Jun 2026 09:23:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 942EC400D6
 for <dev@dpdk.org>; Fri, 26 Jun 2026 09:23:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782458626; x=1813994626;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=F1ki2YovvFwipP9RNvdPGiDKraG8LD146SWfnyLMoU0=;
 b=Ebmid0oQfe49LGnZtc1P274kqhJgMNom332fg155gAycVTbgBKAsfu25
 pFeThCtRguyaFy1fvp2Uv78TJ/JelSGcnT9IIXAVBfJOYwgdz1mSqXs2j
 8gzOTqsvNn70THb/V4CLfZ0iNCTjdH32FU4rhjtzhOgOfsw1FqAOPFBqs
 AVwawZgmcir08/YlYYYzAVCowsig4pubRpHJ5LymNrr3X14DgfiN0NwRN
 Q0XmvmMlwqJqTYeNXP7kUwJ/xWW7SYZGfi0yy8CAEW9k2ZTk04cvz2d4u
 rw0v8l0iSyxdPsyRCgp1HK//UlCbSRjmgaIut61OCJjt69IZGt1AMBM9d g==;
X-CSE-ConnectionGUID: 0f9PubcTTaa1yTAPmG4yXQ==
X-CSE-MsgGUID: FC13KAIyQp2nogEWb2Fogg==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="93603639"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="93603639"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 00:23:44 -0700
X-CSE-ConnectionGUID: tXCdLcYtSLa05Tc3kczU5A==
X-CSE-MsgGUID: sR706jNyTHS5urB82l3TRw==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 00:23:44 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 26 Jun 2026 00:23:44 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 26 Jun 2026 00:23:44 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.59) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 26 Jun 2026 00:23:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T9YEqXQebmBboy/KvfWKfxzr1HjeKriAzZg4ZSs0OPW6apS8cG/z3DDOzx/k+JFD+sLcsQ7YD9tVItd1t+N57LMfzClK21c5x61OZ/Rh1xblcUUsuk1JDREVZGNh8rRu1RDQ5FFRElmvxIqRWJcYeSnoIQwT1XD/jsnVAd6ggXwjQrsZwja7JXgl6kkcomEZYU7aj7dvpEwnAtHKiQYyOuyb6uENqBIBP22E2z4JBL35N2jqsFZw4oiUm/vFDJdZRRc2dMh72Djq4tK9bB4DlSBzPwezYUGMhrWqLZNRTUKKKyOAB7+mnCAvcxaZuNm/oCkuq47fUW3jFjIIfsg5sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MI7pP53Uo37mNzTkKbL8heO60rDkqub6bDCuuYdREJw=;
 b=asL5M7WAOGHwZoBiv/rT8UmBzdW8kYQpy0pMmiEdc/3tAguUwCOYE8IqlcTJYNDzR6LMHI2jGrhoI5O+Nma6feemRzkUr7cbkrJKPNORmfUZjfQ23UVk/mEQ9SexilRULied2vGxfRjPCC405MLNfP/U/RAZIRE8UoET6neM0pP5EdUOLPNU0RqbwtH87VrQuB3Xlve6W8e9sg9Lb7bdMZ/XJPFYoa/meNTubsxsD9g7B7/eAxOrO7+ujqNbeVH70nV6Thc8FFT/OjvYPkXU6YLScOTq5VXT/jti1jFQ3o6ZZNwcqtap4BOsXbeVNyNXls9X0Q6bFjG1vDZrRWCnGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by DS7PR11MB9475.namprd11.prod.outlook.com (2603:10b6:8:26b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Fri, 26 Jun
 2026 07:23:36 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 07:23:36 +0000
Date: Fri, 26 Jun 2026 08:23:32 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 0/6] examples: remove MAX_TX_QUEUE_PER_PORT
Message-ID: <aj4o9IOCeg7qWiNs@bricha3-mobl1.ger.corp.intel.com>
References: <20250901154400.2333310-1-sivaprasad.tummala@amd.com>
 <20260625174908.278408-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260625174908.278408-1-stephen@networkplumber.org>
X-ClientProxiedBy: DU2P251CA0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::12) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|DS7PR11MB9475:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ff0689e-20f0-43f2-879e-08ded353d64c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|56012099006|4143699003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: O80TORvSPhmrsTLYs1wKVUEfq0mT7EQmCsljX+c0VrMkU1ZqhxCzKWle7UxgcmY9+8aQZrK7bL824nskJvQxgxkEHl9BDBSWRLnzkqy4bb/JhL3ZZYqFualnrKu+TC2wsDJPjGj9SY/UC1CCy4nGQ1AUQV2beKKyQ/OcVwNSVZAN1NM2dXgucUZ7gVbiu7iOsW0TZqqMKWfxKO0Afe9BaVrRAXsf9oh1DGIHU4UdFnKryyxx8Zl0tVPqxWFrquWu9z7V1rpS+JVumSwzvmkxb8/PeoYg7/+wmLSr26hsCb0JM1Yh+9c2/u0KxZVepaqmUXnmHs96nNdp56LqWlt/Xidhay7CDJOPiHRudRedtFPpGIUqz/5BaPv0yTIGbPGuCVwBRwZm0Cs5YSxBQbEncRpCxxEeq2c5/5MGkkQsI3AKcueew3AkjXNNeBG/cFjKhCr+Bx5pYf8Ysb7enlPOWP+IVqdKnHH3ErHE6exBUKqemnl01yYkvvMHY9F2j715IpkMYYHx6dO7ksKpkIXYhUCrw1jUaVLYjUI3+R45jbuHfpXLY6OJ/I05PJr+iMG4EhsreoQpvc1A4+pGzNRBmPb8jwF8Nbxa/sgxnJ+o/bxdO6bcOTOhCOsZlKIYo82ETFYoldQyYAp4XVqp8mSrPWSOXYkl8VpnVY5Xf2JDvFk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(4143699003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XT9nONtR/0bMoGizZQATu8mQSvY65C+IaMWDCGVFFa1ySiiPvY3zqTBlZowK?=
 =?us-ascii?Q?ZmxF+YsUK/J5dB+VMr/sICa5zor635byG00v895vg7qJoGa8JY7orQ1adqZS?=
 =?us-ascii?Q?B3II8VjtrWvpcujK6kE+uzn0w3qrDxw0OJDSUMsfkbY1N4OtznvbMSwgwX5E?=
 =?us-ascii?Q?8wuazWDCfPx0zv6BxDgn/rXCbBHyD9bp6gB6oSTZ28TEKXCHL20qYmMvRoZt?=
 =?us-ascii?Q?CbbDGwF8MJvA2pGuoUz50w1EQBcGVT0KehhiyaqOuDI1eovT82ROeOk4bSbx?=
 =?us-ascii?Q?bW/p+/6Qf7f4TgVsDHNE29JYNoDrsgduLD76MXAffnPoUOoUeDUtwpPiN0uW?=
 =?us-ascii?Q?LqS/SjPfzkRbbPKZUTWhtVMLpRMSz6oZETqp2LirrLIUHaNuCi/0NWgU8XMl?=
 =?us-ascii?Q?ZOYmEMlIItmUloCzr1qUKIcuF/Tz/SrRy/lmuwSBqbhPgTzFQKyD/9z/gkqN?=
 =?us-ascii?Q?6ps0EjDWMgHcRDz51n2zZ1kv8HC6fnifSaWlkXJgpYc1AnGeVvqU6/CrHbl6?=
 =?us-ascii?Q?/RI4DGAByyIzB9qP3lr1SQcqlLdLHevI/1JeAoLn5teJGJincPC5K6EZH7x6?=
 =?us-ascii?Q?d9UCvjSyemrWmYxHuBFABZ7Z47gzizIaKB2lfKvgIuZTcUM2Ddyp6a+i+n37?=
 =?us-ascii?Q?ckhV/C+HJ7ckDTFpsLaCOd9Jag72DavunXmAQW9tqUHgA6momspSyE/zoUP0?=
 =?us-ascii?Q?HELjiVqj+WXrROIPr0RtBorRBS8zORLKxD/E+fsWeXIcieWcYwU4A8gWAvx4?=
 =?us-ascii?Q?Pa3NYCEyUjGwFXCw/LBZfAB6PIJj0OBgKi0DQG86DGdUUauoW6T49r45pRTF?=
 =?us-ascii?Q?y7LcVyPBnVF5dk+OAAQEMkF/x4+EnNUQLPGk8q7g9wakAyOHThFyPs+zoTJL?=
 =?us-ascii?Q?dX6ek/YzxoaT3ynF0mC3d5bCWSbVS1WCsVUoWitlZ8TKnRwcNKjpXGFqaPkT?=
 =?us-ascii?Q?InhQUyf9bdhHPM/98H2AZvLeC6NwomFBf58bNK76x0acjV/01O6Yf1IZpL0D?=
 =?us-ascii?Q?b8rtJlewQN7fGzs1RBWEKSOjJ+khSYewxuXOpQp0yehNl/4uB6t5dd1MeTsS?=
 =?us-ascii?Q?yqjo4hGqgpC4llJurKrDndSs8Pzg7HLtuTQSI+xzUCEJ18vBKih+f0wCc+o7?=
 =?us-ascii?Q?8wqJ2fn3jKB7ibO8JJY8ibu0aECyI9QDuwnCvvH8VIag2TU6lLDEKm/5Sp+S?=
 =?us-ascii?Q?zXY5ojCJDtov1rLK8wweNabZ4qWqgCLkEgQ3/rJW1Qwo04wI3IAY/6v/fsyc?=
 =?us-ascii?Q?UtkcaDiEtVpJbQkUwnDXCIyu1FSpRS1dVdMfZH93n+Ad8F3+oucDHjCnYgVZ?=
 =?us-ascii?Q?G+AtqAMIIyPOw20bpotfw7qpiavg+WzlKGUwbn1gdgpxlxBNJG1+puI8xutY?=
 =?us-ascii?Q?g19cUZTfkNHCGvD6L0IxUpJiRa18cEmP0TqY1yKdACnNGS4OCWEJ2lf0x5Er?=
 =?us-ascii?Q?+0xOsmF9HXURJxCZ1x7wBLycbfody8mz2TMXVTyZvls6uDAyUI6MustYgQaN?=
 =?us-ascii?Q?19wr7d0ap8aLlNl/bRjxlgx3BpQ6MRlx/6EPrkH3i763sfgmanpXs1G9wAem?=
 =?us-ascii?Q?DyBnQg5zgqpJxwqpXsOvBjfFsMivgTG9et8Q5z3T7dTmSlP8/PZgFxo3KJCd?=
 =?us-ascii?Q?Zb5HAy3tQyX751xg4M9EhEcM93Y/VpkevVQwlZCmmBHZP67e5XgM5BsYp6pu?=
 =?us-ascii?Q?qw78cqfTuPr/aOge3a7RB0L0S/icju7YyNH3mfvIP9SFakwKhcnyxDumSDqT?=
 =?us-ascii?Q?AdO/vV0kx4DK3tDAUQmquarVZbBrwU0=3D?=
X-Exchange-RoutingPolicyChecked: l9IDIbYTPkbyclZ8Cpi/NeRLGaJNz8+npNL4eCVao5pvCWGREmG3cBTMVlNonKb+1clIIDUhIALMqXfZmcC0z0qLxXBLuNlxJeeyOfd9ixR3e2xGufvev/+SLuirjThvfSpik8qv1hOp0db0J7GLkqaVGG3PQwmcXhUgksU13LuWRPZhnWB0OhFXHHtCfbNgrDBaptbGa6ZZqeBNrprWSWNM2ybFP2SN9NmFlsOIRtMeMVbeeUluFhiSYjCOfKpB4jNKafLGjdYxiZ6TbkqyUfm+34MtaAdxEyibkXmieinusEt+J829WEGh4DIIvUwqPdcq+LHEK6Otv4BBF5qgWg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff0689e-20f0-43f2-879e-08ded353d64c
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 07:23:36.6772 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sy8NFGXjAAZajTLAniOXSrVvO+/6rhH7JEz8SrIkdVB6QK14InRbjSyeJ1O/Sq3I9M3ySFgyER3OmVW8Cqo23GzKP93sYokntFuncF0yxLM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB9475
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

On Thu, Jun 25, 2026 at 10:46:50AM -0700, Stephen Hemminger wrote:
> This is an old set of patches that removes the use of MAX_TX_QUEUE_PER_PORT
> in all the examples.
> 
> Sivaprasad Tummala (5):
>   examples/l3fwd-graph: remove redundant Tx queue limit
>   examples/l3fwd: remove redundant Tx queue limit
>   examples/ip_fragmentation: remove redundant Tx queue limit
>   examples/ip_reassembly: remove redundant Tx queue limit
>   examples/ipv4_multicast: remove redundant Tx queue limit
> 
> Stephen Hemminger (1):
>   examples: remove unused define
> 
>  examples/ip_fragmentation/main.c      | 3 ---
>  examples/ip_reassembly/main.c         | 3 ---
>  examples/ipv4_multicast/main.c        | 3 ---
>  examples/l2fwd-crypto/main.c          | 1 -
>  examples/l2fwd-event/l2fwd_common.h   | 1 -
>  examples/l2fwd-jobstats/main.c        | 1 -
>  examples/l2fwd-keepalive/main.c       | 1 -
>  examples/l2fwd-macsec/main.c          | 1 -
>  examples/l2fwd/main.c                 | 2 +-
>  examples/l3fwd-graph/main.c           | 3 ---
>  examples/l3fwd-power/main.c           | 1 -
>  examples/l3fwd/main.c                 | 3 ---
>  examples/link_status_interrupt/main.c | 1 -
>  13 files changed, 1 insertion(+), 23 deletions(-)
> 
Series-acked-by: Bruce Richardson <bruce.richardson@intel.com>
