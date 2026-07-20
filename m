Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FF2C4451B
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Jul 2026 08:13:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EDB2E402A7;
	Mon, 20 Jul 2026 10:12:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 561294028C
 for <dev@dpdk.org>; Mon, 20 Jul 2026 10:12:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784535177; x=1816071177;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=u0kjYwrwXRS+XZIXSV/6HU3bBwqZuftAeuTefh/TOMI=;
 b=h23Ay60Z1Qthrfjt7sSSFSINKvr4YCy1QqvoLmRY3WI6oZYp4rO+zA+j
 Wbj9C7djkAAWN6BQBAjJLvLZFJx0BF0mVe3w6KEgvCFVd9GFX5Lzh8Pvt
 Sljy5rpDVEI5owU/4ItkdcprAsuizpXLgzyxM3XzOoXIikzD5Gc/a7e3N
 Fodm4et9VMXj7sxqDrE+R9IKxqJjV83m5EnJJYdEPObLd2hf+AJe3RHoq
 ZGuhQZ0kDuF21rNzkHK80kAG2d8PX5yBbId+GYUNN3tQg699FFM/25z6u
 /sD295XGP4SkyMa/888LEXo/iwTv9FKNRAp4mgUod2N1CvBj58km3BaZW g==;
X-CSE-ConnectionGUID: W0tOze/aSguZqN9Z8b5MFA==
X-CSE-MsgGUID: vSoRyhsbROOKnosci8vFhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="72645524"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="72645524"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 01:12:56 -0700
X-CSE-ConnectionGUID: K/Xvf8ypSYKrc2RsUHkEsA==
X-CSE-MsgGUID: TnTt94UtSDKwYmBw4fl6pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="253021476"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 01:12:56 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 01:12:56 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 01:12:56 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.37) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 01:12:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JaG2OFHLFGtbK4cz0IIdXSVksMVpPzvtUhlCaC9CKHmbuSLMVk6kl8M1J+Rzkzu2NmD8Z5aYBf9DSnWGVSe7jCB2eTFEgXZAzpBjrhrNhVtmC91rDyTtxwSHPpJbfgQlTigMDxulM+svX38auZHgU/ctTWkc6iOs1tUOvMQUwkp4StGqY6wPrKQPW4yTUpiC0dUpllq5kSUPinq4Mq9o+5/rSLRX5vjQ3EdcNOKsA0fdTpyScso8UTrHOt5PX+bCk9ftf/hByCxI6giyhbV/06hGiQU7MXYoQZwPOHok1h9ZFV09APfDW14cnsZFZix9540B+aNMR0AI/6YFv0neJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mC9awzcSM4u3Rgk0Mhz2ZqjPUiACDTBI59PeAi03MmI=;
 b=fUpcnaQ71CseXR5EATwcpjZYgY9tZx4K9pipmxVrKp2RhUTGfFtWm01Ol2dAArDaz8wayato8OeQN0C46GM6EVaEIQejJLhsZDY5MyJtTj0gp+YgcYTStnDW2agJP6pCvWN4WEmcLbPxV+QXlERwc5au8rKslbsLP4MZfZLX3UzeWHnwGRq5jAsdJUF0Q2fFEc5ET8Xyp5g3G+9xUY03FNpI0aWleR4D2VwSY5WnA/M1hEA0bBpQLwvGvs+OJBe9nLlMj62zJ2+hUyBPdOtcDe7unLPO9ghXrVmAeHZ9j6g4KpQlHZlh48oDBPxNr+BHyEbnsWi7KGZMVVRo4IoK5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by SJ2PR11MB7671.namprd11.prod.outlook.com (2603:10b6:a03:4c4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.15; Mon, 20 Jul
 2026 08:12:53 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 08:12:53 +0000
Date: Mon, 20 Jul 2026 09:12:48 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: Kishore Padmanabha <kishore.padmanabha@broadcom.com>, fengchengwen
 <fengchengwen@huawei.com>, Thomas Monjalon <thomas@monjalon.net>,
 <dev@dpdk.org>, Wisam Jaddo <wisamm@nvidia.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
Subject: Re: mempool cache change
Message-ID: <al3YgIWkXNihHGMv@bricha3-mobl1.ger.corp.intel.com>
References: <b54ad1f1692a0274da705d446972efd1@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6596D@smartserver.smartshare.dk>
 <e0b59e0b-1fb7-4a7b-84bb-9fc47f4feb5a@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6596E@smartserver.smartshare.dk>
 <CA+BST0kV0w7teE2h8OVZ5Ont-BCrf6rSxw9+t+Bbn8hx6xUwtA@mail.gmail.com>
 <aliq6kqGI2TfyFoH@bricha3-mobl1.ger.corp.intel.com>
 <00fe4a299adc03ff7d39ef943e62b921@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65979@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65979@smartserver.smartshare.dk>
X-ClientProxiedBy: DU2P251CA0030.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::30) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|SJ2PR11MB7671:EE_
X-MS-Office365-Filtering-Correlation-Id: cd9ed6fd-27cb-403c-a3ef-08dee636b26c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: aYX7gZH7lHs8i/DQcM2kxMf3tZTUrh39K/9sskGjjxGeFVjvqHP03hLDpZd1sWgItUQSmwdjH2Xy+Atkcc4LahYLvRGOHnWZoJ3vxXGa1jfB6A+QL7W5tBebG4P+qL5UrUpxL61oBVHR+Ft01jVYSh5o+Fj3Lk5mOVDiy2+A8KuiZ7cfvMtrfJwNjipJ+VI8s3bNxz+P6zh1lJQU3xZ2CNcRuj0Sqgq/q99K62w0/b6OIOIY2dmV/s7kvni0iHD4WWuU1m8zhp0FVpiVlysTU2Li4Z1xcbn4CQhSS6VCLl32WKEdnN4LddxEsNRXRKTa1Udhr0YaEnVq/rABIHf0aLzzhoiahs6hkJljt3b8bVhmQVZeZBzdK75VmQTQ2/1vwpK5RlDz3Cf2ON4G6mMTr9ko8hyGw979t8pLdlVHl0VTMwaYiNbyy/DevQgMpoKhBaet9rK1o3natlIJ7nfGMldixp8dbiVlXgAbRpIaFUD/X/VBbSZXssEgrHMcmsoS4k2ru0+V9regXY3EAxXPNqhKJM7FUq2IYYfe11F/FVhqa9yY2GYu9yBWO3NBO/T9+shO94uzVpXZhnRIXHRGb74jTEW96s2ufEQrTcp6mur2R1GAVm36FqKebj1NttkrznyPA6nvkiPgYRpPZxbfGIQXxzJeADbwIYJDhDMJs+4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?jfMeS8CHnmmyTh5NTw6rVU9vZUAiS8UICA0oQqsOc2eFt5JX3rg5PU9QH1?=
 =?iso-8859-1?Q?LMdh1okhdFlNzXEL7Zq+dYEdftF/371jMjglsr7i2lGvLuQOyCP9d8lXCa?=
 =?iso-8859-1?Q?VmJ/tpYOpctnSh3AsB/dfJSekgQ75bQmsfaMPGcv1ZQbEjwaF+k9Yv88Fe?=
 =?iso-8859-1?Q?n4P8V9E7NA2LdI0BAZ7zU1fhS7uQIr1VhSoxmd/lRG7kGkvJAcFFRfMO2d?=
 =?iso-8859-1?Q?HyhL1Zu/Z17c38B3iMjcTXnOOif3SKvSzxY3HsoC/Ji+/4iBdIY5TswbXg?=
 =?iso-8859-1?Q?Bge2fZ4XPodGvggWwD1y2Owg8VTfqB3S92c5dgetWtI6vPcf0AXUwHNeBE?=
 =?iso-8859-1?Q?4M9PYn8ppSeGPiooped8PyuaeGtnUhUSzlNvv9RuISW/pbA8LTi+FXNIuX?=
 =?iso-8859-1?Q?JkxWc9Z7edyTQXACxMOEc4XzU/+sKB7GhVp/Tgl3kCCgy6mDaan/93cFMy?=
 =?iso-8859-1?Q?i2RT0au+uJPshKesnf3k3QVZyHSfvZAemz2EjQUZLu73qE+ejm5/VN9mGJ?=
 =?iso-8859-1?Q?5EiVsimbeV4AxoCoqphIi1WsRne6ebWdLYWQLJirjd5UYmfokS1RaIeDcU?=
 =?iso-8859-1?Q?IKrVXRaUhu+T7SJAF5cKuZM3zqj4HIw8AaI0oCg8GUzDBRWY/u/y1DWYnr?=
 =?iso-8859-1?Q?zedOKfcBEJh6YRScsc2NL9a+qZ7YHybda5VjOaok0cv8C6XmzZKzdpvrZ0?=
 =?iso-8859-1?Q?pFVWyGDzTuuWt/lhsmipo+z9br7xStHWZEt9LbIY9V6PIKaMvmV1Gr6tUK?=
 =?iso-8859-1?Q?YxBA6nCs+SAWFhT2pl8utnC8XdR+xPIXtOIRdoRlZLHhV/Hh1cJ5BzVvP9?=
 =?iso-8859-1?Q?JFBb7XUl+4kn/48p/88giUGQxC/BHJf4ESxasY8dJvzxZx6+MqWI77HRyR?=
 =?iso-8859-1?Q?a2Pa0lotGq+jRHJThuhTSRNXmbCrGMMNA7bK52Eugvc3tCmCf+GQpZjI8P?=
 =?iso-8859-1?Q?adsvAvLg0BZBzCoL3Lbbdz/CcsuxR3FTM/+T/Btv4lUJkzncMlHJXOLDym?=
 =?iso-8859-1?Q?fP7Sddv8SeI7Jcu+mICZsrKqptig+EybHfxTWa0P7gXggpd6fU2hh0zLTP?=
 =?iso-8859-1?Q?pd9deOVxR2bIVkJvM/YD9wyYxYjOPBHijy5lkUM8HUEdAvQvKM4XSLP90k?=
 =?iso-8859-1?Q?hsWMata6bIRqkbks8qPPoejK1UrxeE3XIPj75WPsCZdZwqEKSEP5D4Elzs?=
 =?iso-8859-1?Q?ir9p8FDCRpD1APKobAHZ/BE1LVnKVL2j9c1aLcc1T1hzeOWH53Z7dOCvAl?=
 =?iso-8859-1?Q?x6oIVfVbJ2f9XU9Fgugtys4N+jwhZJl75KqM1nCmWA9U1qHENo9nKaNnxB?=
 =?iso-8859-1?Q?wV2HLmPaU7Ckop12bcpMbfVsFao3VoBKj3NmgF3PwjNRCZTrOuhCm0D9DV?=
 =?iso-8859-1?Q?Xy4XP7Iakwaix74A9Mvq6ypVwvoEyJlbU2ce747skGzYFTangq/rdQmkmG?=
 =?iso-8859-1?Q?+e0NOzybl+C2vavNgEt5gsGwPLYtWs2Xfcypp0khmeqTAYZp18oO3yvUWs?=
 =?iso-8859-1?Q?IfJrd2w97F6UH05Lzf1NxtbUvJEntMWwaxmqFUjaG2wwGRd5/9/7oTxEcW?=
 =?iso-8859-1?Q?eNFknWudvFvefvetFueKdJ62lwDNUikAeSxzkEI/haZfQebzv3tpxIUsyR?=
 =?iso-8859-1?Q?lkWzJY+ikZW9S7Jwf/JhDgpaeekpk3fJrKqgntQrD1EQGHOkIxXtNU1wER?=
 =?iso-8859-1?Q?ksDKSnV1tgwwgx178fLfQRtewZAh4Et87cRFd24FweoH5ln4VQB/v/KvfL?=
 =?iso-8859-1?Q?fDl81iG96CsWPaC1q3OIPWpr1ea5LlG9GPQaJLC94UHMjWSurdI+s/gDiG?=
 =?iso-8859-1?Q?o6M2wYxQaTA8GrVZqvJYcHbSX7dkYCE=3D?=
X-Exchange-RoutingPolicyChecked: CeOBvo2u+gFRqooZZOQ3vwk750j7kZAQ8zMauT6im4b90I5P17EdV3aufS1m8VgtmWghqeBAxud07yn08z0WCADRe4uIyVPEsi/pmkNSDQ/GGZ71SF+j+kkL3UKq/ENaLOrZSVtYeM82doXpoLHtZaLk4JMpfMvN5fIejYgQn55bL+7K/qMNa7Ctmu1xaatza+C6OqYMT+gkc7QW8PZ9WFkyJHd/URn0JZbjghtsCvkt861x0WK0BiO3qruXcirDiLS0a4rqyDcz8DS/o4OTfLDYi2KrhqszDzhN8eI13jy8o5o0vw/qMTuk/Na6GehghZ1bUoFgnTFGLIuP2rgFNw==
X-MS-Exchange-CrossTenant-Network-Message-Id: cd9ed6fd-27cb-403c-a3ef-08dee636b26c
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 08:12:53.1574 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P5zEgVfD5rNZXICdE845xaadq8NTZ4xdxmMfTyH0k8Nb0p/k5/p2aUMRSUX75kQyRaNTvY+EZKy/jddAVS6d6sqHEB9FnSDErxf3wzUlw/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7671
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

On Sat, Jul 18, 2026 at 04:07:05PM +0200, Morten Brørup wrote:
> > From: Kishore Padmanabha [mailto:kishore.padmanabha@broadcom.com]
> > Sent: Friday, 17 July 2026 19.10
> > 
> > Hi Bruce,
> > 
> > The below patch works fine for us. We tested all the different packet
> > sizes.
> > Thanks for the patch. Do you want to push this patch since it is not
> > changing the ABI/API?
> 
> Too late in the release process.
> 
> Let's postpone the discussion for DPDK 26.11, where API/ABI breakage is allowed.

Agreed. Let's not unnecessarily rush this.

> 
> I'm not strongly opposed to Bruce's algorithm, targeting a fill level of 25 % from the edges and flushing/refilling up to 75 % of the cache when necessary. It does have its advantages for some mempool access patterns (which are not exotic).
> I just prefer the current algorithm, targeting a fill level of 50 % and only flushing/refilling up to 50 % of the cache when necessary. It performs better at random get/put access patterns, and the backend transactions are smaller.
> 
> For DPDK 26.11, where we can break the API/ABI, we can simply double RTE_MEMPOOL_CACHE_MAX_SIZE to 1024, to compensate for reducing the effective cache size from 150 % to 100 %.
> The mempool cache objs array will no longer be [RTE_MEMPOOL_CACHE_MAX_SIZE * 2], but only [RTE_MEMPOOL_CACHE_MAX_SIZE], so doubling RTE_MEMPOOL_CACHE_MAX_SIZE will not increase the memory footprint, but allow using a cache size up to 1024.

My concern with this approach is that it won't automatically fix the
problem if we have users who experience a performance regression due to the
mempool changes. While testpmd allows the mbcache size to be provided via
parameter, end applications are likely to have it hardcoded. That means
that if an app does experience a regression, the author/user has to be
either aware of the mempool changes, or has to debug it down to the mempool
and then know to increase the mempool cache size in the app.

It's not an insurmountable problem, but one that needs to be very clearly
called out in our documentation, what the change is, how it may affect
things and how to fix it.

On the other hand, in realworld, i.e. not just testpmd/l3fwd cases doing
little packet processesing, I would be fairly hopeful that regressions are
going to be few and very small.

> 
> Please also note that the current implementation is carefully designed to keep the transfers to/from the mempool backend CPU cache aligned (assuming cache->size is 2^N and large enough).
> Refer to the parameters passed to rte_mempool_ops_enqueue/dequeue_bulk().
> E.g. with mempool cache size 256, backend transfers are 128 objects, 16 full cache lines.
> Using CPU cache aligned transfers has a few advantages:
> - There are no cache line ownership issues across different CPU cores repeatedly accessing the backend.
> - The mempool backend drivers can be performance optimized for transferring full CPU cache lines. (Both source and destination addresses, and number of objects copied, are CPU cache aligned. Assuming all transfers go via the mempool cache.)
> 
> These details should be fine tuned in the implementation, if we do proceed with Bruce's algorithm.
> 
Yep, good points.

/Bruce
