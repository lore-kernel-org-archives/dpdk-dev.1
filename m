Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FEDF89251
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Apr 2026 11:18:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D68E4060C;
	Tue, 21 Apr 2026 13:18:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id CC9964060C
 for <dev@dpdk.org>; Tue, 21 Apr 2026 13:18:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776770337; x=1808306337;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=EbC9JJ3pG6vnemNAdzXOiDVTI3cHaoER7ouEx4OnHd0=;
 b=PXjrxIxUoFaQhZkSxzJRHydK267HNKAnE/73LVTGTRtwHrVKWKCHackO
 lGn4+nGoSby+9gFKaaURPyItBlprsYdncGkTxbWk3R5W9rBtbKwdkgGWu
 fqAC40VWaXm+NpMcnCNwbLcNM+MLLVTuvWtVMjwBxxsrqTj+1PvzIoESn
 bbq6uJpqBEQDeTyou7SgDz0LUidA94bSs+uLjtXk0GyLH0QtPckrLHYQe
 RdWShq7oezknBRx5odvpSrjZ2oWaOL7/6TgljA/BiZ3Zz2KvFD+DKzV1/
 2U7u5Uf9R8BBheLWS2qXv+wo1wae1N4l0gGilc4RerpjDU09Nnmz//p/R g==;
X-CSE-ConnectionGUID: 4Yv6ZLl0ThyLNIQrCwj0Fg==
X-CSE-MsgGUID: ydp2W9hZQaaeGRa6lPkq/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="95111142"
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; d="scan'208";a="95111142"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2026 04:14:44 -0700
X-CSE-ConnectionGUID: dHUU8DpmSNaZdZY40lLPLQ==
X-CSE-MsgGUID: BbGYbB4lSSaavAI1Zfcsrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; d="scan'208";a="236990657"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2026 04:14:44 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 04:14:44 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 21 Apr 2026 04:14:44 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.50) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 04:14:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f1nd4oMCsqC4ju+FEP9uMt7oAaQ+712DEKajYAI9KifOsZcrZJVfRXkAIbz0acFFLk+xBfjmi+e5Yg02Ev9aBjcRTwBNwMXiLaVx7vfhcvDTFaJ8bd2r8JhQSjj7y7eI/zEhowTWqPNnRHPuSd2k6ogt2VhcA+aI9+fJmauDSpd8aESdymbsevTJEk74vKCOksVOEP8BQ/CJIwpY25y+XG4eAWkGoegKkZz2yrX6p7HicNDiioCc2WmQ/0GvOzD4rLl3053Myb1iEl6VO7prev4hTsC1N3E57/nj4xRFunBQky6ynVAqlkGbBiXMaC6Oyo8sdu9fPxa8ZgjCbyvTSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4JRJ4jcBC2ny2E5LJNxZYn5fxhcvpYXNAHKMY81R6Q=;
 b=FhiuT46WB7WnEHcj8h/JH/sbGtmPQ8kssRwYDaWYWwzRySHLPPsdGNwBYLeLmS9W9+0vmKW9CtCP+ignsi4tPerPZmH4FhajPHrXH+Uj5JbI3jJ/FGfpezsefX1HIS1meeLDIkk/B9fcqrdiJnG62jLT33lceJL2pIJYLOcRFbT0K5VdE+ZH7py9xhFBwBPtaGi9v+o54OCh4TizS++ybWtb3zWI91h4Vndgy+DLDoACd9kIg5ZrdebrlKuZ4sQqUVAZvZQuE9GV17kGpUcw2JXOcb7IlUiirNSksWNS3vr+bvbpAAFAm6ITWsDzm+KT8B2aLVhHyOFFCpUyAqZQ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MN0PR11MB6184.namprd11.prod.outlook.com (2603:10b6:208:3c4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.14; Tue, 21 Apr
 2026 11:14:41 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 11:14:40 +0000
Date: Tue, 21 Apr 2026 12:14:35 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v4] net/iavf: add support for QinQ strip
Message-ID: <aedcGxx26guY4awP@bricha3-mobl1.ger.corp.intel.com>
References: <20260216103710.195777-1-anurag.mandal@intel.com>
 <20260409101951.114492-1-anurag.mandal@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260409101951.114492-1-anurag.mandal@intel.com>
X-ClientProxiedBy: DB9PR06CA0017.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::22) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MN0PR11MB6184:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e04fe9b-fbb1-45c7-6bdf-08de9f972ec3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: qtXpTu2bIgvXldGHYx+3GkETZZmYKb65i8yToD5ntXnk94Nt5vyoUoaztoYQvuQhwPBzC8nDVsjJYJsm/RPkKVkvaRP5RhvXKks4kzvhitd4dqXy4KB7entCyC1tPjprNTq6ehlHUwLuGwPmKLeGc1blEw1QJ9UNcQXHmpn93Gv28GlMfH3zCfrE/BFqFuL5DlkKdFJPQ13+ADhnu/YSAexlwUZAepH2wvfoSNkAJsF7KQHEwB+qJwZTYHr0UeLqQ1YjjyJpYcwKJHr6QYZpRn28rvDmMHh+0Wc77w/3PCGrtjvn1d5mH4xzNztaFlQa9ahs71/n1zSK/7rjFG2Ljn+/R0ORtOhQY7xZTm+OYdLXMS0UB2VKe96SWvv1c+hVw9D1oGRYDpb6DKviKzcFCJjYAaSj6zIwAa6IMgEG1Dh4niZAt/TL+Np37TDAHOJJSfHy7rfGXE2GmT7u4PFa23GODwK6mBrfT8EGMsU4QPCdiFe+SRGSHlmVM5cy0YsfZKvpFw8Odo1UlsbIq7tipqhgQafrCdwioXINByuZ+Dl2YkkN+ywfaOGvtFUXDQTWR6KnM/W9XGbA11g1o/sct4xc/e5nF2XT0TvgxL32ZIC+Z/Jx5mDlOq/2G8FahKlUrkg092z6hu81oKqtxQa+hqcKeugB7iNQzjSm9UJ+83dPNEJObdum8rj0Hslypuryz+cqbeSOlJqFnUpRHoGuCt9gDdNwX/IsW06yP/GL45k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AELcG0kZ+kfTn6bpxZgpcoxoRvN6ZP6n/bYQNe7VJnnyCtVS9n+FkiBejUZV?=
 =?us-ascii?Q?6GG5qIdunJKjkbhIYJ+/U3kPbHq6j7AqkpbA/tAFbvh4RAGd/842fsZahW4O?=
 =?us-ascii?Q?Aakv15C7UUSul8RPxLl7UYhD+qlA08o51hZnlkpxCJuEQ2u+tWYynSs5RRKn?=
 =?us-ascii?Q?FIUx/mDWGXXcpe4NhSHVG676p2G1W2UQ1IPeiloFOnp8cJyEDcKwk8IH8TZ+?=
 =?us-ascii?Q?/T2F97tUWozeCZJzKTmpGCA5qkXHFxTqDplVUEIyF6Y0DQVlAS7HKA+s5GU/?=
 =?us-ascii?Q?EiNSU5bs9yGbHg5/rqxNX4P7XHsdPCKkJDkPnzMoWuRetkSaALyqRNkw9B9J?=
 =?us-ascii?Q?ACeycDuBVp8TU9ZlL5YKzDayYzGrgGelt2fYJdM0uT7Obeyuwqa5pX/fcMbL?=
 =?us-ascii?Q?Uvf7bc47KLt9voWipMbqPazF2UnrY/Fxe8auZINMv0TiLK2uKh0a3uCpAUmq?=
 =?us-ascii?Q?lkh3J2iknXnRgB1W90tnegW4xzo1QgUsDMcBk/rXEQARiPZGH28ssGxdAqpV?=
 =?us-ascii?Q?sX+vn9DoAvhaPaczPci5p7Ab1pLdjVTNHxCSH4L9OuC4ervvj1C5thZ8prRU?=
 =?us-ascii?Q?tBVplkMBgzPo8jSDz4BI2SD9cQr4ChYWlaGnDu/pW3cl8NGmKBosRjONdQTf?=
 =?us-ascii?Q?EjlasrfdBcK1eYDoK8+E2ZEzW8O2Bo+qiWjQdT358MJNNQ1DeaviOZdZlMLk?=
 =?us-ascii?Q?m13AZQ/BUOzWMGG42aICvTKbYY3m3d5Sywsa5DW1kXfgi/AmSU2pmuWxHoSc?=
 =?us-ascii?Q?0Md2m8pEMnEdTyD4WHRZZhyCTA7HWanvfcPDxGS6dcI0GaIPJ83NjfT1PaMr?=
 =?us-ascii?Q?0J0mWqEYlIYtf7uFmE7V1MC2qqiS2k9Ze2S0Vlbw3QVo4rbaRrG0GP6FjMzy?=
 =?us-ascii?Q?AeMO9v14xWeiJV6dwYwmuGTIV6Ct0OVyDuVH8mqbs5UD922yCVC9G0WdNtLD?=
 =?us-ascii?Q?Ki9XRMl5Dl9SxDV9ojrWstsdHafCKPwqlNT4shWQUwqJO7EebUZ2ky6Ej6Gn?=
 =?us-ascii?Q?OCFvqWUW28oZ1bWbxSDORlE8SyTpEzyKuqoMHNfhks3SqSmy6tYKkj6+q/Uc?=
 =?us-ascii?Q?0VcQdChaXJwk4I8P9+UhyyVnQs8ix06MmcTFV0rI7MuxPIRtSDmwX+Mm6PCL?=
 =?us-ascii?Q?bEVcCF+J8sURd1w9RIt/pdMLfpdfXTCpOkdOX/rEiT8L+vUM7DMevBIGf7Sk?=
 =?us-ascii?Q?0YfhgiKLoJ0gBLsWa5EoqSBMg3pQaXi8jZzYnxVeY2mSUqe4TlUotD3mONb/?=
 =?us-ascii?Q?7CYK6oaFL/SfSmelaOLvUMXYfsGuXUcu1454VIiFYYkJemIq6lEbDERtoVJ+?=
 =?us-ascii?Q?mN3fk430VanFTTtHe2R8Uj6h0f95lbELsOtW7U5jSDqaaI5+UDSHRqe4zVLP?=
 =?us-ascii?Q?M8wtIbo9+3YihntXi5kJvW48IOsCYoZwP6P++qob4EuiPSNxc7mx7dMZoSHq?=
 =?us-ascii?Q?V/qPZY0VZ7GLJ9HSkd8SgdQoaZbrk0ZQg70MRMw62TkqceLf62VwHTnLiQnS?=
 =?us-ascii?Q?dxOtPGbO2MTK/CZgIS3LnyqBKNR3qAg3TFTDFCh7pc2cVAwIs2gncBesU+3f?=
 =?us-ascii?Q?lGUKxOS2ZEDIxUbO5PFbIVcW0vpX/Pu/7xOde/W/Zb1Ps7Zcpd/2VE/qBqNY?=
 =?us-ascii?Q?iD/GZ6/UncMrcyFfebd5t/dmrwb3rp9eU95bNmb50f8w0VCvOe61ejMuVC1J?=
 =?us-ascii?Q?eKV8jfWIw+7h6g/RvYGPyP2+gGsmH2Kt6VPx/+urMWjJzajGXyY5VHIhYqPK?=
 =?us-ascii?Q?JNfpwjX9CUICEh4pp/LOOSyjOlCBDAw=3D?=
X-Exchange-RoutingPolicyChecked: jGr1tH6EeurA2xOK8fTl5mwfpQjRlCBA+ZypuAx2mGyGT4jOFL1YAxGWGXt6cJaxh7Q1uvizzK0Yn46uAifT+3mYAo6ZyIJL+mTkQ64eyzgg785kiFL1iA19pnheFtGskFirV5bakDja2xsU/lKvvDHd79nQs6l+fu/o5oNSz3Pt6UfMuMB/dRgqZhdEXzdDZ599V8w6YaZKLVUfGSKbHlt0N9dmxsPgzflvcLaDjKGI3kNoCvgqlFY4idDFi+YO9oFp5cn5z+vTkFVGxFgdgW2iAyNPcdvEVs1aEe+ooyC4MSkBQN5kU5QTgSQXiq7/NG8MMYVrwsmccF9jDyqXNg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e04fe9b-fbb1-45c7-6bdf-08de9f972ec3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 11:14:40.9203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ym/jhI0ceStMHb+YNoRAIAtYHzYoPvO/PIssJmty88ujgL4DIDcXWY+7D3w9e60wVSKz6iznO7Uuz6kzZVH6IMD4gLqR7SO8dwtKuMlPNUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6184
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

On Thu, Apr 09, 2026 at 10:19:51AM +0000, Anurag Mandal wrote:
> QinQ strip with VLAN TPID 0x88a8 & 0x8100 support was absent.
> 
> This patch adds support for QinQ strip with both Outer VLAN
> TPIDs 0x88a8 (802.1ad) & 0x8100 (802.1Q).
> VLAN Extend should be enabled for the same and Outer VLAN
> TPID should be set properly.
> 
> 1. Tested QinQ stripping with TPIDs 0x88a8 as well as 0x8100.
> 2. Tested Double VLAN stripping i.e. QinQ (802.1ad/802.1Q) &
>    VLAN (802.1Q) stripping simultaneously.
> 3. Tested Single VLAN (802.1Q) stripping.
> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
Recheck-request: github-robot, rebase=next-net-intel-for-next-net
