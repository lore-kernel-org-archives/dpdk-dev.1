Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D633CCA5FB1
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 08:53:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC65140BA0;
	Wed, 30 Sep 2026 10:53:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 3FF4A40278
 for <dev@dpdk.org>; Wed, 30 Sep 2026 10:53:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790758393; x=1822294393;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=fGawgAR+71sLqgwM7G3D7z5oYssmeaICxunAEdSHzO8=;
 b=jorocrxgXo2IMiRv6S1ysjvIrvqDjXHO7guczaet6ZFJoWLUz7kipU5h
 bgPlC3xQZt0vrcHVC1Avo5PA9m2uUyexgOt+Q7bXfqVMKj0JctS0jCfub
 f5ladYD2Ng6CwEzlFJ9w8PJiY+r3qgN1hmkR3Sn2+8qYPhQYu4CEveh1G
 3/AyIFVU0cSpYMCwxCS9LoNKUf8fH7E1UIdfZfe3lZHSgYYzrl62J/DBm
 O0N+MAH3YvS19tR7SymPY5Ak0G+MgrH7yzkCKOFmLrnC3w+r6lIAdqSv2
 kcB8qr4yc6SBzRIfOsYR/DG/6ZnZa4b8QMcKCIlCWFcwsJK+TSvG0A9U9 Q==;
X-CSE-ConnectionGUID: 0dcNZ4GXRguY4yMeqODIWA==
X-CSE-MsgGUID: VWRVAkKPSPKT+MztfK94Uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="117020230"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="117020230"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 01:53:12 -0700
X-CSE-ConnectionGUID: hrTpFW6MS66bVFgRiW5YJg==
X-CSE-MsgGUID: KOad+9LiRJWngb1NvXEflw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="275196822"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 01:53:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 01:53:11 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 01:53:11 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.66) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 01:53:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s4L34eRYP601agoN6TXdPaQLEFRGYIiixwSAVaqpKsnbnpT/9pMbDimhQVNd2SKZ4ojg4KM8+1/qMQTBxVvdP8G7P26LfpSDWlZR52zVtxR4YZRD88W2bLukLPfLI4M9WcOhd1u//3HEsTmg3rKJO+v/FeUIzFBXfeliil0NUkxl02exg95JSIhGipp/HQbx4aJPLSL5NBhc5+EEQzZu2SfBvOMz40z5jThl4zakg7H5D8ST7jVWq4PG598m9DCslh+ilxHgN/VGLCRODejPrmFLh7Xnu7A3ZDZ+gnoWKNkQ0W2kq4abUmL3SBbbsyqxQuDNj6arODoubkHIdG/6AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDKPRwDB2kMYaxMu6rNH9KN3CObsQk2D+wQuaDrDz/I=;
 b=epD8bRIhNvXY8j+hUHNmjPW28gBrx8ThpNHsmAdfIDxZpnzRMRmxkl5QSf/CBvmMtPf3Ngx7ywBgcuEojpoFSDVJQep943HxCi9SBIGTn+YoZ8TGlMS363HcBTvObSKqjQGTdCDxEY23dGkb33B8UPa8VrWC1N51d2agcyUKxkn/YGi8c1cOABDIxjYGpQ673rkfJis8xJ2kUFP7RJdkFJVtxYtzPQugnDvz7YhiJ/3ZYlSMYdPOEdbK3IRAcXdDOJks686wduTwmk+8Qc+WVWWbh0QxuEay/ZcYO8p6P8orpYcGChbemoRzsF/ye4nhjNvenFATh0meyG6xdP8OMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DS0PR11MB8017.namprd11.prod.outlook.com (2603:10b6:8:115::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 08:53:04 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0451.014; Wed, 30 Sep 2026
 08:53:04 +0000
Date: Wed, 30 Sep 2026 09:53:00 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH] hash: fix GFNI helpers for building with -O0
Message-ID: <arzN7PorjHs67ucG@bricha3-mobl1.ger.corp.intel.com>
References: <20260930084908.72055-1-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260930084908.72055-1-david.marchand@redhat.com>
X-ClientProxiedBy: DU7P190CA0020.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::34) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DS0PR11MB8017:EE_
X-MS-Office365-Filtering-Correlation-Id: af81f703-1fba-4a36-cdaf-08df1ed03db8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: sazrAev0Ux0lRZQupZlkPz9v/Ecn75WdM++cjArRkUcI4TnoZmeKZxbL9xH6UmquqCeNjscD9zcnjqCL1mJoSP6eZnhYLSgu8q1DnGx5qDdyaEabmqw/DOBWABZ6RjmOoTTJbliaoZqIGHMeAOXiRznOp8npb/JYdJiqktdx1mIHOH+4eOf3Qt1Mvw+ZDUIPQbUd2ML+jI//pNgUHCkLLREnB6jCKFunWTcRBxBxvTPrMQESN5O2jBZgAUUy4y2GRdNpi+L+shYhM/9vtEtoTUpDm6+A8Zk/omn/f3mWSBUPcG3DBTuF8WF4x4+X9mFKDDG/qUSOVCAMc8WoQkb83fKAucWFPGvE8HJ7GXGgEWJUq1irueMs2blEA9CPegpm8vrPMEnflTij1FAwUMC5Ogr829RLJOTN11upu1n2ZXUGQviVQwDsfEFa9QdCyR1ss3Vp6xdbpxrHSOyJ2jAITOJQ253PTgAewXNDR02eB0OXxnws/h95lGDFMQ/JYawq6p/P5OdDKWvSpS2dTLkKzyfTIkIup8YOX5NhQv6n1MRflpV0ZnQKCHDH6jnpL+cwU97NU3ShnFxVWM8nTsXqQ90/qZ+JBvYRaIWAE/dr3OtrJ+dBqQCnMlfF7UV26Rdd9SSnp9OwjY3AyVfOuOfvhLPDUoH+i9Mn7sxYeYU2OMU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uDyiTnDIUKY7kUuNunNjLXRfC9VX5TAWsDjXCXsqpF4PXh39HC6tQnN94eI5?=
 =?us-ascii?Q?+isMa85+SiJTmPHXCZ25jKcW/pdsF8qpKCkGPcWY64v7khIbxpS242QwwuxY?=
 =?us-ascii?Q?imKTPU0FLzpIC9ooX0zYhv+MvCRqlOsAXoVy5MMhLsuSiSSugRpLmRC5HGj3?=
 =?us-ascii?Q?JO3U8YMkCXrDpMn2GJYwcrLsckrQyAL+Fo6FfqvC5r//q4U5du5+6igHPfxW?=
 =?us-ascii?Q?ODIBPGFJGea6T/nIyJSMomx4bBCyEXQc54zPd8vcXQY7Jgjl9Huwt8r0DeYu?=
 =?us-ascii?Q?agFIdrjKXKozEVe0y2ZLGV8pvExOjLFSa1+qxOrQLoBQPtkEflCrfaax+mij?=
 =?us-ascii?Q?aWstVuJXaDKylpAGdKznnBu9AZ3KZJJpT4dkIRhFhkB7Y2/pjRhRRnS5Xt8F?=
 =?us-ascii?Q?H4pGo+fNPDOL1taMOf9EcFHmmnVAvKSGrF4CPFDX9B3AhmHLHdki85zXBXH4?=
 =?us-ascii?Q?FFiLKU/AHrHVxvbr6X+aDtz37YcTR3GrzlmKyeFA2P1jlwEAZwh4Mu9yIyTN?=
 =?us-ascii?Q?isxvHYVcKVF4Jjq6PiYPI0llLI/XT+nPf2+ekx3n/xx0qxs1/xMJfBhxv/oC?=
 =?us-ascii?Q?cKEzwCT1V9GSnTaHjN3VM5mEUtn21TPmK1ZjGOGjtmdTYHvnV+ioUJjjACej?=
 =?us-ascii?Q?/Piw72VE1pqBeZ6SatryUlNJ+OBXhDIcSdhrqP8LGwjGpEiJ6oLlHdremukV?=
 =?us-ascii?Q?un176rPx5wSwoBRq4MMiGB21Sh63BF+T7Crs5PYfhLvGrVRFqsLAkD0Sikyf?=
 =?us-ascii?Q?ZgM2eh8frKOPyxz34EiMI4h1a1O1khjwSg1k6fDz3Nbp0JQrP3vbjMXw9n7V?=
 =?us-ascii?Q?5vxSUbyTCkRTqocmRG9e/znQDh58LMX7pGeQ+cPp68tEscT8N6EugeJ7pr5S?=
 =?us-ascii?Q?U7UoL6gAD3XtZstQ9ozYBzqxUaJFLN3ZswuIKxqnjOs7Fk2Hp7gJibQ561/V?=
 =?us-ascii?Q?pEaJgd1mRbKFQ+9o1q/5wFWCla5j8Sn2L+n65zrkva9tZK2H+NOnG44hEwfM?=
 =?us-ascii?Q?KRw7vFWcaVK4mEi6obsg9DEun7UMUx7RF8KQTpXfSwK9WixoLijLYPcSadCQ?=
 =?us-ascii?Q?OhugK6L5HrPunHSt7YFz7X+r0CHHhEC75v1Cl4TmRzDaIFUGp/0KOywIXywN?=
 =?us-ascii?Q?rb9jr0YST6OW428zsYSQaUsXMCS6doDRI5xBXfROvh1rEAsxfG10M7km+7cC?=
 =?us-ascii?Q?LBe2rrfwgJOdMHNB/4Qj/2jbOIIbw2sBhMxChn8JpaygV3hI9p2X+Xcgxwub?=
 =?us-ascii?Q?eBjuWEYVgUX3c7SsXRDKty+NIBrdvUK9JjvbIQQ+dBYw8QsKj9ly/TQjXA2N?=
 =?us-ascii?Q?6WCxjO9vJeNiRNWV1SAHzNpW7Aa55YpElK56+Q8RWl2XUMIfvyWf9q1+peQi?=
 =?us-ascii?Q?PZLLVNmgnNL/oXvT07sorkrEIgpcqdgkCyFN/MT5JgfwyxvExxkvT325Nq51?=
 =?us-ascii?Q?lyLd70Vw9gHgIMFTpkW8s8ZG6XG/EtBN7ktwAqrOHR6Qf+s1FnPx/G+oUsjL?=
 =?us-ascii?Q?C22I18+EuxzlYFT5Lkv6UIlOfu9KYms3SAkOhjNRZGqKKqasj+axN0l9L/NL?=
 =?us-ascii?Q?eX7IUNP/FJeVO/knsgBAIFkpsRQC0mHXZriwNicTpxWOf1PgZRy1O9pB+Qzx?=
 =?us-ascii?Q?rmrjhNc3c35/6vdVsHzExk6EmuAESDAa6b10J38Eajl7O4HlET5wKleOnLBz?=
 =?us-ascii?Q?pDrrLZofpslX3Prs0R0E8NgSNB1je1c4KGerfuLVKvoumsJet1xRUVVrg4m5?=
 =?us-ascii?Q?fpUy+6y4SiDl4CPnr6RWy8eB2BUxwC0=3D?=
X-Exchange-RoutingPolicyChecked: fkG8iGOTQ6hJjBVQKnHEP4DYW0guNdPiP8xEQzWucXFowFFzPcOV3rJ9trlxoz/xKP+48ycPcQvBqvXWucMg5nGhLGA+m8iVfjaCaMD1TwFwOmUuLRQS+H/N+k3wnJHXrze7dVNsoizk+US7O+F44q3Icwr6/UUQV6Pq256JVNRoYQZw4x5EkpEpEOM90cd23CbRgU0Ol0JOnsSnzeG/+DWsd/hGMmZvyrnOVoGc6A8AMmo7YiaJWi2Pvq/M+82rF7R3fi26bEGIyQ/tVsWVfHslyhT0vlX0I2zVD8pEadRNZIKTLaP6/KDLlQYWAFdcpqiq2MyEMoMfsJPnzUp6VA==
X-MS-Exchange-CrossTenant-Network-Message-Id: af81f703-1fba-4a36-cdaf-08df1ed03db8
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 08:53:04.8592 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GVVj1LJlERrE4dEun/XLmlCUHDNfrkCsnRy1URgW5lj5LP+icKEIMcIwkoEtL0Yp9G2RphyjzxN9T+Hb06pFne2SjuCxGJRQ12BaPz2MGHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8017
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

On Wed, Sep 30, 2026 at 10:49:08AM +0200, David Marchand wrote:
> Similarly to commit da31ef54c865 ("hash: fix GFNI stubs export"),
> fix "internal" helpers used by public inline helpers by removing the
> incorrect __rte_internal annotation.
> 
> The issue is usually not seen as those helpers get inlined under
> standard compiler optimization level, but it becomes visible when
> building with -O0.
> 
> Fixes: 4fd8c4cb0de1 ("hash: add new Toeplitz hash implementation")
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  lib/hash/rte_thash_x86_gfni.h | 3 ---
>  1 file changed, 3 deletions(-)
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

