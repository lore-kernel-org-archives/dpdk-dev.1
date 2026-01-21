Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA7FC44536
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 16:10:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09CE6427C5;
	Wed, 21 Jan 2026 17:10:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id D638840261;
 Wed, 21 Jan 2026 17:10:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769011842; x=1800547842;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Q1q8Hlqk5s3BFAxtC5eeGyDZfgniC/X8Q93aABvRr4s=;
 b=Igg0APBQAs3DzGBtmHXBAKC1AXDpoPs/rmmYZ61ld0rGVUElcqfYPiAO
 a71PlTccJ9jEm7hjYPFHnlll10fuw3NLJW40dPk+zwTOkV25IASeHu2zH
 mFrmMLByp4zNiGhHlQeDLefPemhY/oJNXv+JZZ12JB4tMdPa+ZZlOo0wl
 CfSnJrFye8Dm6LWQbHOn8DG0/gAfdnnsPkKgIKAIfAk8/m6lKTgTcdJv7
 swVboKxoT5uPQM9vkSrbaO9TdUXbHqWObXqQEwbEa1J9bgH1eG4Eves3q
 O6exePf1Ydye83Vg0FbL6+JKWbeg1V3syWzCplga47GpknjIjZTq1Wk3o Q==;
X-CSE-ConnectionGUID: i0vPZ0xNTluZCrlp/jZVZA==
X-CSE-MsgGUID: rpTACEQZRy6Ml4qgHMBOFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="80544898"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; d="scan'208";a="80544898"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2026 08:10:41 -0800
X-CSE-ConnectionGUID: 9GHDIoAoQ7muziDIk65EkA==
X-CSE-MsgGUID: uWpkhJ/sQtSqTB7323NuEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; d="scan'208";a="206552475"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2026 08:10:41 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 21 Jan 2026 08:10:40 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 21 Jan 2026 08:10:40 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.15) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 21 Jan 2026 08:10:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nokJJ1S0QPApCUzYOSUux5id7XTZnU85rKkuZfFmkLqhlAXrril7KzwW/j07z3m4YAF903ZPIVIaZW4E9g2PGnb1/tGSzSulDnGbyLDHrHKpVIBzj12LCuApIaHx+q248JrUMN4+RzMSGGC0gfV02ti4RGWItQ8u/eR4UPWQAO+PswvU5OGHPWqgkSnH+vLYP/LNsFZZ6d37n+jUalHha3P/tBUu09IoTmdmQmkizm125vfwF7ztXWGkZFlKh+A8U1vtRqAbPdBVWCUIJ/G36bBI9DlcOQUQ20jyzBZHqwnzThRmTEE2temj2TUdUxlK8jzdgoNUho7hqx2pfXsmLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5hC4dFQQu47SOECRw6GYIoD4l/d9tud5hweYTBgHt8=;
 b=UM5G3mjoWrYOE2wRoCiRS8gu2BnM9DzBXfgJ2kyZy31mFqf3GX2w6FOn9gomkhyJeNj7e5N8ZdjGD+bMEEF3+L02Dz4ArxMNTH9NPViohaWkewZM70zLLUXw1NYjmWJu2GcI6h0dLsoKeX71sPUAMtXuDyu/btB497H8ou7qp44WyHOrqdl7CMvw1Vul+lVKX6sZtwqaGh2D7KDLlRrisy/yxpHkslKV7jvnpLuTUAaknmLH9MNw9mcXny3Z86T9Ex6qp0Y3DFZu/ri2SG7Ofs7epDcYuxRgp/QfTt5L0qQQGE0V49VN7thAE9LIc1D/oxCcyDtkOjS8QhhaZKvMjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY8PR11MB7876.namprd11.prod.outlook.com (2603:10b6:930:7d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 16:10:33 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9542.009; Wed, 21 Jan 2026
 16:10:33 +0000
Date: Wed, 21 Jan 2026 16:10:28 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH v2 1/6] test: add pause to synchronization spinloops
Message-ID: <aXD6dHdu_KCl8dFD@bricha3-mobl1.ger.corp.intel.com>
References: <0260118201223.323024-1-stephen@networkplumber.org>
 <20260120015759.301155-1-stephen@networkplumber.org>
 <20260120015759.301155-2-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260120015759.301155-2-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0030.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY8PR11MB7876:EE_
X-MS-Office365-Filtering-Correlation-Id: f77d1a06-f4f1-4950-b065-08de59079ad7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?93l14FhaUIW0DDokzfFNtcyi1lNXHKj5uXWeOR54ThczmgPAPfHt92KzJvmC?=
 =?us-ascii?Q?YadkZ2tzeQAyiENTrKNfDP0A0xWIKTlJtMeUDzGv/eBsrxURTdHENvsR+RAE?=
 =?us-ascii?Q?qe1ZV2CqZluT6qwyYqJGBW4nx2Z5/rU9AOvmTDZh3BMok6oXAcBlCRbPIIOa?=
 =?us-ascii?Q?NWoxdv8EecDvKqdSSEibPbZYGyPdpp1ThGhtWO9wWy97dzSGV07/cLaug/yW?=
 =?us-ascii?Q?GwWyaBQMgM/CIDR097XJrCH54sXfH6f7jXpXDt9pX4lmB6JSixsURyD3ZJqH?=
 =?us-ascii?Q?VTMXlgscxSEED62HTP0lGMAak924keIG+85Zl0jbx+mtqV4ww9yOm9iC1AXd?=
 =?us-ascii?Q?Z5r7qiHdrJSkhfDcS5djf554q0Ng9PXWRO3KJBEthf5Y+WlskwXcoFHOB7ha?=
 =?us-ascii?Q?sqs49u/2u+t6OEVwkm1ljdYNLICeM7x0aBzxvcdP15BF4DUgPidPIE6GezjX?=
 =?us-ascii?Q?rCiLA149ETIlr2dGjg8r5a0+9uhMxfYwr3ZZkYfgCru0ou/TWFfVdBI5w5xs?=
 =?us-ascii?Q?IXHAH+wEWZkQ/eWvCIBDvnlEyOQs5IRRkTJChl3dKSuYwJtd/orFkOiNEs1P?=
 =?us-ascii?Q?gTQJ0bvtOaf7ZuP8zqCkZifUe5AyFoeQx/Mes2qKaoj1vV8KBTC1TrSTopHk?=
 =?us-ascii?Q?Gfj7cTHV7EKczcpi1AJXGREwBSmHVHoN84rdFyi9hIud9F8IrGIOurypmkeE?=
 =?us-ascii?Q?D3VJ+IEZdIoYgv93nko4ee6aIfXYNa0h+HRyg5v0OJcdk/QqMXbI12+r2HUx?=
 =?us-ascii?Q?IPwxh5zeLpugcjsg7eZ+65uAiQtE64L8pIvJO+9vdam0UPFok6nGcnPyzTwd?=
 =?us-ascii?Q?wOab+EWnfw/6iljjUYWKlHvez3pUswvXNKLEBlvaMXlgy6dvrMFr1xn5+kSd?=
 =?us-ascii?Q?SEXbGZtkkyPm6+ohjzP+P0ifAzjRit8wFlKHnwFH/Z3gwYQPSn7Wpk+jQPp6?=
 =?us-ascii?Q?aKowDbJhtViL+l8aS8ruE2fbb1DnPVkC/rq0HumTOJQsZZ0MVLtKDoLHJX0L?=
 =?us-ascii?Q?J7wwdIk1tUwYAziJO8arTM6kuGHobHCz9BTC7QYtCmEGQup3627O6jlMaG+E?=
 =?us-ascii?Q?L7GOGTlaKyGvqvihd0Ooq8YNhKx5MiIK57FplLqymWRhPvnTfXpxoM+55zIm?=
 =?us-ascii?Q?Whc1t3PStQYN92QI4ChKPtoESp8VUoi3LipZEgEefd+evASEhbConrsJt+75?=
 =?us-ascii?Q?ELZkd0LNTSlmRomHGvbPKNY92nv7gr2hYk/hpfoVg0mctSahActJqW2/1un5?=
 =?us-ascii?Q?7qhgGb+ovoJ6x3IQK9vXvRGZptfgzh7dLl6t7StF/NW2nOq5i2QiREc7kMm+?=
 =?us-ascii?Q?RPaoQPSB5sgyFiNFMDyVJ6OcokAJZPEGKYUmOr4CLDsBPKI1M8djVIKDhgvB?=
 =?us-ascii?Q?gjFV5pyIcfegC/YJzPt12ZB3pJ2t0HFIbuh2Ke1AirMezBNQuoPQiOwAcKhl?=
 =?us-ascii?Q?aHcxUj1JOA4NBn/tNA38WOUSZlainDaeMG8GJs0YVvugSj55Dm7lXXQ3PLnw?=
 =?us-ascii?Q?H91Z2vtVur9zDd3qiMsK/nWhZGBTZiTNRue7BfHRuXZEOTArEsjd/sUvX8RV?=
 =?us-ascii?Q?/UlSJh/VB/nJtjEpyPs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S7Z4Moz6eJVATPP8KF/nl36Z5ZUIUSGO4Wq9GKx6vDPe1h0vRDjRobNfF3KY?=
 =?us-ascii?Q?tBKz0CRmfhr/ZRAm0tEyfP4gqfwRhlHujTbtmtE5uUD93tjJM5c18hOCbHvs?=
 =?us-ascii?Q?WxceRkV0eTKrDid+ilMd2nxSX3kDLcL1yUOi2cXtZf7qOFPJvRfO58o6cCMe?=
 =?us-ascii?Q?Tt4FXX77wc821DDpWtFO7jKW8Q4gPPIRDrIFWn6HBK1+kluhLV3Akuq2kpMx?=
 =?us-ascii?Q?D6aJ0wfBasO6Y4JLkC9eB/m0beXrJ3qBu0uUtYvPbL/2H5wB73CPS0GZPpXx?=
 =?us-ascii?Q?0hm1c66Y0siW4NaN63f624sAoE/ik3vEui52Cm02ToRx2jIF5xu/mw3H6nry?=
 =?us-ascii?Q?1pCFBw/93WqBCIxQ5qFmas0WJoRy4GbDBoCGvmvuIv6NSAo+lzH8lmTfdQ9M?=
 =?us-ascii?Q?iW1naCRd+yQpP0vsA4HfDnK/KyBeDBVVRKnstEjB9/2fYRk0SMeSGk3BVGsi?=
 =?us-ascii?Q?XHxwRCQ5c/nc1MA92kL7gmbHQsk41A3OhvBTbmxP921sxkus7lx2MIGJ77WI?=
 =?us-ascii?Q?WRNE1/Psk/rxrcUNeJKjbOGQ4ktbMCIiPJP1ZkZbNK3vJ+ggptyb+CGGq9vB?=
 =?us-ascii?Q?GorueoS3nELyUgNX7wTVqZ5B+qzNOxmFn+fFuX98Dpzvr0dSDiV6J/dEHe95?=
 =?us-ascii?Q?vutZS+u8FBGKEL1z+XwOOBOZvVcFBatRfgRKRk1pHeCoGj62aDEs0C3IXynQ?=
 =?us-ascii?Q?MArAT6v+7cNMvI5JE2Y/1HZy2U5nTLk/WhxA4164wjAGoIezs7s7bUlxcfQ5?=
 =?us-ascii?Q?1cwT3lCTPGq7Gf9vRnMwvXh/16dp81ipm8U/NlLKxZUKJEW36F6yXOls8AJx?=
 =?us-ascii?Q?qVh7xYIxBy+z+BAueDgRkanik818uGLrS/YfvnbymtHXt7b32VAEAQVATAx8?=
 =?us-ascii?Q?SBT6AMX1fEEUX992CMzG2kkBqQWTvnh507bavrbbBOB9lUepmqDlZ7I6r09x?=
 =?us-ascii?Q?XKQq3OpdmPIIVH5oOttBvOBlbWF+zjkns9T7PghpJS43MhaLDZLEc19cCwVH?=
 =?us-ascii?Q?NGI0z4m1VeOFOmxBU6xSw9JMv+KUzeDQjM4UsxlpqHxTZPwO0nPslUeb8l64?=
 =?us-ascii?Q?X8WWxjkKuZtBRWYhvt7wzYGk9idVY9PzUkIubtn3is9GHkcykvZVPcSrh/7U?=
 =?us-ascii?Q?sz9hSn361ZZPQo9gaU4Uk4kewSCY8EM3hHecMpOoqHcYk1IdyO7H3wU1eifT?=
 =?us-ascii?Q?TFR8MzSaHnbTgyMiN3lBJc763/Z0SWwPCLzIz4op1+rpnY/eC35hKbv0bBKw?=
 =?us-ascii?Q?MPq74QfwF1VKS5O01boHyYc7ZTqL0cmrMmrpD3MeWLvKpY9uvrTGx0cZZTj1?=
 =?us-ascii?Q?iDJyKgmHHcOnZXSxlv0cC5cRFtCR1xNx5+UcyQcDxXF20rwfC83z7+F+dk15?=
 =?us-ascii?Q?V7X5zV35A8U9n/dMWHU2q68rwnGBVP/nfIn9GLVCYEE8AsZ59jAxqm18hncu?=
 =?us-ascii?Q?DyJtaZGDL7ti9GEilq6uMgwXJ3ea65EP0qqC1veaZ5mLLNmy2M9DH4LvH8VQ?=
 =?us-ascii?Q?kCdWddEd0pYAIbHZNpytCwysFoVgSf7v3bU8m+vQ3eJYlpaSFdfl7TJJO1kI?=
 =?us-ascii?Q?jUrdc1fDZrAVAXDercC/mLAbpFjXkva3oL2g6D75Okk2iAiewye9p/QRZoBc?=
 =?us-ascii?Q?LRcOYnsFWt14EDbBRQp+UVAAP7ZA8RWU/bzPFallGz5IyxwoXqHlmjGRn7oV?=
 =?us-ascii?Q?PsIj2Hzfzyo0gXfeJQMpdJv+5ryTL04x+rBALEY5nnB+dIkKHDw3NU2hVwWe?=
 =?us-ascii?Q?fZ4CbqMW16Ak39Wo2f/3Kz7BoJueztk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f77d1a06-f4f1-4950-b065-08de59079ad7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 16:10:33.1921 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DRZtZHTgre1qP1FU4oTaeL5YJD2SGEuM1Duq6KedB7dURNkpPrY4r68f1Dd8baCqwh5qhuB3KqriRTqe8SiwcqUn/DuZEhtTanOT/4cwtkE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7876
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

On Mon, Jan 19, 2026 at 05:55:04PM -0800, Stephen Hemminger wrote:
> The atomic and thread tests use tight spinloops to synchronize.
> These spinloops lack rte_pause() which causes problems on high core
> count systems, particularly AMD Zen architectures where:
> 
> - Tight spinloops without pause can starve SMT sibling threads
> - Memory ordering and store-buffer forwarding behave differently
> - Higher core counts amplify timing windows for race conditions
> 
> This manifests as sporadic test failures on systems with 32+ cores
> that don't reproduce on smaller core count systems.
> 
> Add rte_pause() to all seven synchronization spinloops to allow
> proper CPU resource sharing and improve memory ordering behavior.
> 
> Fixes: af75078fece3 ("first public release")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  app/test/test_atomic.c  | 15 ++++++++-------
>  app/test/test_threads.c | 17 +++++++++--------
>  2 files changed, 17 insertions(+), 15 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

