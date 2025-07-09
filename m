Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D118DC83F09
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 13:29:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA70E402DA;
	Wed,  9 Jul 2025 15:29:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id A0206402A9
 for <dev@dpdk.org>; Wed,  9 Jul 2025 15:29:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752067749; x=1783603749;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=M/Ya/YBYow6KjPE0Afc51Hs6YV4TC+H5TlDpVHaoT6w=;
 b=kFZ4tAd3M1Zy5fz99ixuavZsXsgThs0K0kYioXVl/fTj5xtXjWh9y2dQ
 mdI9rp4dwRUzJm7kse3S1OVYWqMYtzHATaAXF+3a1jf0hF5+1GCFNxyxh
 aNx6kUFDtaegMb20tL8eGSNQtntzaw/ZsoscomYBLwXNobAQ6HRjdLTJT
 rZbHPZo3saylJpup1B/v5Q+LKiUAddh/qAMUav5O6WzM0Fo7ZflfyG1Z/
 HL0jvnqQRXD1QHKkGvhzi03H8jhJIWM60eR2L3z07FkEzb7oNXM6Fn3Mi
 X5k7kpi83+pagorCqL1jKmZ+1zELjWfe1PjPVpPF5ax5wO43I3QoWtYB7 w==;
X-CSE-ConnectionGUID: Grb99uLSRoSJpzYdum2Fpg==
X-CSE-MsgGUID: 7PA6j5SSTeuzw7wffEkp8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54455380"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; d="scan'208";a="54455380"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2025 06:29:02 -0700
X-CSE-ConnectionGUID: h3GVmkzKTz+HKh4QP2gvDA==
X-CSE-MsgGUID: 2zlFDd5zQqKfqvlelGQzXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; d="scan'208";a="155866370"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2025 06:29:01 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 06:29:00 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 9 Jul 2025 06:29:00 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.53)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 06:28:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qo856XcNaqJxUPJ/bQsz7jS8JPM9Ox9Osi2fQjXCxE2Vp02hz7sasDC3pR93sVn50Et4Ulsp06Gx14B0AvQz0BHZJeNe91BGtjg3lMU9kMBPW953GM1Zme02HaA+Y6SzS6wZoIcPzFOJnv1/YS8KJQF062cfjMHPlHs0zvODUi+tSCZ00m1a/VSCKwsG7YWjeXIGASeEYg6ZXtSVEefzslt5kMuoM6u+GMFn4rsvsKdjmVubK5gfArzPaLMlx+RwOUYoiyJuhq43r1F5/rvQ/36d2C6uxjVRaVn0BLE/IBJjgM/oyhBVH6nlz2NdEsvazJ8tgHcACmLYhGTYfWjgjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ibhicok8rdpXIaYAQSJvPj35d7nXYwsWWe9OhbVt1s=;
 b=MVPmcEPsr3fiZmxDkYp/rmiOYqcLCxuO7CUjKvNNWviA5kEzrL8ym97gn1V5NxqanQzARLNO7vsc+A9BURweO5PwmMlyqnuwYaxRmtunTyxG7xcsM3vCp3vLfj1CVxIS6tDQr0QGuMOkRn4Vna9I0+pzkFgGn740f4r+gjxDjDaizM2zuVhDRJ+UE5p9EoVYA8xLZVo/cTUAlIdLG9/wOv5f0Lm3aiRyVlZTE7LVIc/jUK+yUgQ05Fht/KXzVQc9WrZIA+alVWBEbb39CmhuPXsjxegPdQ55oei31HQQ72eltZ70Q06gbvuRKRX+8Jvpiu/aGDEoNh2a8r8+PhFZ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH3PPF6E8D29981.namprd11.prod.outlook.com (2603:10b6:518:1::d2d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Wed, 9 Jul
 2025 13:28:28 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 13:28:28 +0000
Date: Wed, 9 Jul 2025 14:28:24 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v1 1/1] net/iavf: fix order of inclusion in vector code
Message-ID: <aG5ueFRWP86CUrZa@bricha3-mobl1.ger.corp.intel.com>
References: <552f8241f4f65fce0c8b43797612a97dec5d9ebc.1752066381.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <552f8241f4f65fce0c8b43797612a97dec5d9ebc.1752066381.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0093.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH3PPF6E8D29981:EE_
X-MS-Office365-Filtering-Correlation-Id: 1afd850a-e27a-4f61-b03a-08ddbeec7d7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?N5kpCL3JqJZXMeQA37PrQ5Ap4HJcleqTUCYLfO+1LqQ1s+Dpnb9IsB5zQl7j?=
 =?us-ascii?Q?msMZm53zAZXLbHsnp6GTYESNNcicctE9Vex5M1rl551jn/opa2JTxmc2FPmt?=
 =?us-ascii?Q?HxfTl6Xv4+7V8KxBT38m+1k5Uw/h2gAunKUCs785jH7fFDB9VEkO3K9UAUyc?=
 =?us-ascii?Q?IXQSJNpSBa5vpU47gfjvsoFJQ3OubvIBZLpbQ0p5Gqu9QmLQXdjUPYGI9CiG?=
 =?us-ascii?Q?kc6uCpRW4FdMKwzq7fqDxNyPWCNAyTc+tkBywL4wOQlEowlh7feMP6HXAex5?=
 =?us-ascii?Q?tuNH8DCeg4Gj01VfC1mjqU055s3YCXtTZ2tKIKvzYnj2RduwuNMbi9QU6Hob?=
 =?us-ascii?Q?kjVocF5yfNJuiBE8qSA1qUCOsA6jWAQvgLQaUx9qL6OUjhxfALvZZScxbMrT?=
 =?us-ascii?Q?HTuAc/1cXkZ+VEYZyU9WIObIYk6KKAECUz885pxfW/s3etj3vSM23d8I8/jp?=
 =?us-ascii?Q?VKKVrSKYfJX93bU4ViWE8dIPzVWqhiQOPzv7Nj0kWrpMabTDMdsynhLRazVE?=
 =?us-ascii?Q?cz2EjzBbxCDh9JinNXe6ncZ+9OvonO6ERs1oaZgQfFrGLQVGULOoj3RH6qUL?=
 =?us-ascii?Q?85R2LqfqNmpnZ9yx6F1aZic8cEDZlG+bucF5QzEy82xTQvN14smRdlZITAO+?=
 =?us-ascii?Q?2ZVBOWN0Ytlut/U360cxLly5IM01imPonGVnesz3aKBXj4CyU4H+U/DbcNnQ?=
 =?us-ascii?Q?Xtl5u26TIXJQyP9xuWd1Jmxrx6NM7CnSWOKRt8fDrcDBcN0gBT2bbyO03hol?=
 =?us-ascii?Q?EtuF6hjNhZUTycMPsmPGX7gSnEKr6hdh9YS0fHtOpgwBwi7Ze/XXXZJyFMCY?=
 =?us-ascii?Q?kmCcP8fesNkg8gm+UyDZTCoeqQw7quiY3KjHa8iwZthlEie2kGephb1UpF6W?=
 =?us-ascii?Q?XTpf5dnIkDJt50vVLGXqTeEtQPQg344KLiDC/GmIJJTcdXt2S0gBJoYewgPm?=
 =?us-ascii?Q?ORASSfjE/7l62mdnj9yAMEsvItcIcjoszQMSnWe0ww+30iEue0zPcPKWqmM3?=
 =?us-ascii?Q?gaU6JVyL9s8N2Z3bx5/WItxsyyslguPnTrNRo45OH1R8ehc70nvhuiQpRZcl?=
 =?us-ascii?Q?idQtsIgXZMYHxeb6sI5Rvneer7+CsR0o+BkiB9mkZubfRZ6TsC+mwl9XxuL/?=
 =?us-ascii?Q?rZkzMU2aQQoChVkscKMqAqfGpuNb/+NbgujFNuZmm0xGURHnNo6Yc828RmK0?=
 =?us-ascii?Q?1ggLHOlqWiUML4sBiaBdAGbU/lp1Q7ppCIM/ACvS68e5+8i96b8irvrQSBzw?=
 =?us-ascii?Q?za2wx6QVKOQnVsevKxPyWfPC07grwK3YN7tZArh50lkskGZTU/+USUNZOv86?=
 =?us-ascii?Q?MAfGWoZmt1TpoMu9UjilejoL9TS2PkqF9RVEwgv+BUxTMrPhiLuh34PHAQAV?=
 =?us-ascii?Q?ghgXFc47N8/q+y2WGaVQmJI8j4LU3I32q6gk4SaixCnXmf6OyA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wB+kp6WOz0TZfRF7uNrpXAcFmh3OhoompytBazn+yDlwoyQ42Ag3Bh8W4pj+?=
 =?us-ascii?Q?IIafiQQ8umO5yphKkvHFb1y7cIS+kHLskjVJsRydKg7LyuQu9HgTP3jPwlBv?=
 =?us-ascii?Q?9X6mAV9zxcIyW9vvlb+UnenuuVpuYLfLEy2fcRlWV7SMaDfurSzmNFIr2I0X?=
 =?us-ascii?Q?/oOygWzNDcujWP92OInZvDlR74aiDCSEOXb5Lk8/V3WB84TTqjwY4r7eLZlV?=
 =?us-ascii?Q?mmOVhtsRpts3ZW0jE6wre2qMmC+jx3obTIL7FB8c/nx57FVnaHkWogo7aMs7?=
 =?us-ascii?Q?+B/4G4bNJfe45BIy9J1+rHj0x82L6dMaxvCHI4EGdfOZ0t//9boyRdlWb/JD?=
 =?us-ascii?Q?IDpLGY5vRu4tRtDQi3+ZyhDsJk3gvyCN/bXRlOL5v1WqcOiU8pEeeyECSara?=
 =?us-ascii?Q?KTbC9fcVK3q85C+4U/48XF0HVY4sa4Vy+JH/S9efAt2IKZMeuejo7WnYSyEw?=
 =?us-ascii?Q?GTFOPZq/GfOplYaOmPA3wxitWiFGVTDrgYPHYJACuZc26Oka+f9DlSqSfXQN?=
 =?us-ascii?Q?KXbJVcvivZ+9+KFMg26oMHkl318IZSXViVWGLxEUB+5qVV3mvHBLYkpurw8B?=
 =?us-ascii?Q?PKxRxnavM0cvvMYatHvjOU0DPc2CLSgU6qlkGCxfNGbsP7fZ4hpkQoqZXide?=
 =?us-ascii?Q?2AU5rrwYhQet/HDuvwFnQzW+LtNmGTMg1Oqph+HCMHa+P5aXzLRGbJoxpmfe?=
 =?us-ascii?Q?BugvEvhqM8gcWwnejxk+MxMDcZ9A64ITmgjuBnuWKJ2V+5muB+wN6YY9H43I?=
 =?us-ascii?Q?8701WJjU9vYuPqQszqPj9+AqUF/yDuPfE0Gb4Ar080AeVyJcV5sj5xKnXpG3?=
 =?us-ascii?Q?b/8YdXCUHZqrnldEmCoX4OWRXmxtqPgtcq4hTYCPNkFwxgRnBUHOHi4RJgVJ?=
 =?us-ascii?Q?vCvFSCwm39fVVJnTTNy4nJOPlYmX1nlC5nSUAw6YYFhBvwt2EllJkwH3raYv?=
 =?us-ascii?Q?E9zloWZgTxxQgk0JakgeBGklFq/11sDRIc2qx5sPS+lPyhWg6yWfatmjj3y2?=
 =?us-ascii?Q?P9HHrBiwcpu+VL5MX4I6RLcDnyI7RemOOf+0xhFKnqtOY4hyLCeVq+TgvYpO?=
 =?us-ascii?Q?SE36yDWIdWqD7vH2GXD87Hd2i2Pv2i7wgEvc1jNqRhP0d/zUgN3aNAkCeK44?=
 =?us-ascii?Q?s/ZPFfWAJDG7donxIMXnNcOHu22jAED+FZcCq/kdarCZwZM8V+nOH+9nV6n1?=
 =?us-ascii?Q?SJDt19DHTlU8catS0C5Xtlar4vu9G0aZwOhlu3VcCG3WkfD0QCNYAUtvs/33?=
 =?us-ascii?Q?mSxBB0bIwLjZkGHanNdBSu1+fW+hNqpsWHK7GQ2u3xHwM7igU4QYV+PIxBCv?=
 =?us-ascii?Q?N+ZOoRGgnSXGOPbjOEc5Hvyp3j03RLuaQpaadSO8JioePBxUqX4mBGxsfZVC?=
 =?us-ascii?Q?fEuGLXzrV0eTSwhs4cKtPjmoSUH8EgvtUwATWJMscMMS9UWFvP9c3iWRvMMk?=
 =?us-ascii?Q?bx/iqQk0pUDKp+KHO56aoJIjGVIjGCw2krPjz3x0Meo9ml/Zynpd2tSvnBRj?=
 =?us-ascii?Q?I0dJ8UHLLU4j2+RHmQQghhoCQdLDv3PCqKNfN4WgpL0G3VOtU27LjhA1nFPz?=
 =?us-ascii?Q?hMA8jDUBtU+sSFyZaPOe0wjI7RAY8q/cfV3PqzmcnPnHx5Y9t5FmwSDO7qDR?=
 =?us-ascii?Q?sQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1afd850a-e27a-4f61-b03a-08ddbeec7d7f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 13:28:28.5127 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eIXjNchZXhk3bs99AclJzSaouZL6kczEEATy9yoOUdw6P5cuGsFRn++jWvPKSxSKdxh97RgUGYjUS/ayE1DEGuoDDxs4SqZNGmGexPBSynw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF6E8D29981
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

On Wed, Jul 09, 2025 at 02:06:29PM +0100, Anatoly Burakov wrote:
> IAVF driver does not support 16-byte descriptors (because there is no PF
> that can support a VF using 16-byte descriptor), but if IAVF is built with
> a flag that enables 16-byte descriptors, this flag is then propagated
> through the inclusion chain in certain cases, because IAVF includes common
> vector code before IAVF-specific common code (which in turn includes
> `iavf_rxtx.h` which disables 16-byte descriptor support).
> 
> Fix the inclusion order to include IAVF-specific vector header first, which
> will fix the compilation error due to correctly disabling 16-byte Rx
> descriptor support.
> 
> Bugzilla ID: 1749
> 
> Fixes: 11276ec5e042 ("net/iavf: use common Rx rearm")
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
