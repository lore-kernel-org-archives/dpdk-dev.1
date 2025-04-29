Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F3CC369DC
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Apr 2025 14:39:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 58B17402A3;
	Tue, 29 Apr 2025 16:39:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id AB64640277
 for <dev@dpdk.org>; Tue, 29 Apr 2025 16:39:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745937543; x=1777473543;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=1NBy81vTTWsgLym/YDY3GJJwnPI2u4vJjgnqrW2rYSc=;
 b=YeLN6v8Me4W3kyb1yNfAuh0k/xey98VPEf+o2FuzyWjbMeBWlRENX2/u
 5tFKbCSJWxGg7iAavOohjtGcMuTO4gbIOj+FrrYBHDMp9AjoFv1ZwnwhQ
 UkbA1qYxvLObPqWp8e/sEO76F0sSYZZhbpUGe36Qq8W7l+gJkuRBsptIT
 wpQiVh/Cuyv0D4Tef13Rx4tCNPxYuLN6sW8VT8XjFWXHG5HtIEyPt2DqS
 Fx921ll0akwg7EdrIYMXsG5CbduSaCu0FN8rWLDt4wjh0WIKZjlWOcBME
 tN7WC8QzzcX1cJm9Y4cBiQgO0F5xwzMKmOBgAWNLHVRTX8J4xaXrdWmG7 g==;
X-CSE-ConnectionGUID: mvIiPPYuSuWym67tz93TFA==
X-CSE-MsgGUID: d5brDbqGSpCf//CN751i9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="47442150"
X-IronPort-AV: E=Sophos;i="6.15,249,1739865600"; d="scan'208";a="47442150"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2025 07:38:54 -0700
X-CSE-ConnectionGUID: lEo1jrXySJ20F8pua8mBrw==
X-CSE-MsgGUID: yxqED5PMQCm/URjrzAVoxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,249,1739865600"; d="scan'208";a="134791121"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2025 07:38:49 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 29 Apr 2025 07:38:39 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 29 Apr 2025 07:38:39 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 29 Apr 2025 07:38:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kfNxJDJVEvJ17PONyTRLEXEIgAx+gGkPyX6rv+ERp2I6CIaOFLApU+v+Lc2xNIOOAr2OC2jC0rltpyv+hkwsAPq4amCZbmNnEPKaxsF020D2pCSzpwKK1ar5fC5PI/0Z7y3WZaD4hFgb0xKWRCbDDATM2xgZ+cHtLVg61p2m9EQ6LzpOyT4RCAO2RVmod7OwiMZ8rtV/H75weJ6ccP46bvb7AM8cKIKU5vIf24V0BjXJVt0xo7GcUKO0ViM+nCxQ4zAOOsAiIZRPyRML4YzNU3/DuCTAWXiS5TVu3aiEmPOJQ0Pm8Rshz71C5vlnLXKC2bZdTZTGG6qbNOTFkvenHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30EqdK3Q/of0Pdj6QMUhBUsD5uoT2mZ6K8BVmGrcCi4=;
 b=XvrJC9RV/AZCHRz2WZkY4LdYtg9QhV4yvR3nQ2OUI8pn2cFuxh2jlmUtLjYqzG+43u3nL//yKBkZ0hvuDdD3+vrffgwtcWz2YwTvynCv6zScgKRGswo4frdT1pfxxg5EvukcWLLSxjm5vLY92AnfxwWBWOdUIgzFqzs74z878ZawSQDZYwObEBtJvT8v1eejWUWJaTDVv/LR1wzaDJtos23HTcQCeCTRfdoNZwGBvZbcWdh4Gh0Y2MWRw66LAi64SSgCBKNFFXKOjJ36enMz/Ez0PPoFPA9IKEp0m2BF85JcnM2YQK7of3n3BjYyzwQvS3YEKkf6Mzqnxe5R2/6c5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 14:38:36 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8699.012; Tue, 29 Apr 2025
 14:38:35 +0000
Date: Tue, 29 Apr 2025 15:38:30 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Roger Melton <rmelton@cisco.com>
CC: <vladimir.medvedkin@intel.com>, <dev@dpdk.org>
Subject: Re: [PATCH v2] net/iavf: support Rx/Tx burst mode info
Message-ID: <aBDkZrvS25wGF9fL@bricha3-mobl1.ger.corp.intel.com>
References: <20250416160219.3841018-1-rmelton@cisco.com>
 <20250428220712.571492-1-rmelton@cisco.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250428220712.571492-1-rmelton@cisco.com>
X-ClientProxiedBy: DU6P191CA0001.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::11) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB5013:EE_
X-MS-Office365-Filtering-Correlation-Id: 883e5fea-26ab-40e5-0a17-08dd872b85d4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sZA3kXNTKythGqU3XdJemcZeBAGEm/cTeWAr575xROgdRweZEShYRI3fOVIU?=
 =?us-ascii?Q?6ZevRtL9Q7QV30MHoj74qcnBQuXWOKuph6oeIyPe+bWO+QVu5WP0kgR6NrNR?=
 =?us-ascii?Q?dbpxinphazi00n3EbWFUgbtQieAbJGpT6JhE8ucF/HBT6fnNpfnNSmgBSjjz?=
 =?us-ascii?Q?guZGaPNk6hBjEUZW+JbB5Watjht9fTm6eFvaG0t3Yf8mWUm1B6Oy5s4g5daE?=
 =?us-ascii?Q?P82JlWqNBXVXzY647Je0iqk4Hd9Hk5hBrOiBjX2HPq52nJraR2bpjg5vYlz1?=
 =?us-ascii?Q?Kr649vAkR8SSScidAotA9SrmX/8Mqz5+GyJMOapCzU5hMl+pjmBXiNnh0QHa?=
 =?us-ascii?Q?3ivMoeu0OSln65daOZqCYwBfeSZa8u5atS6llwCAy6OXOk1FCWaWfJVZ78WR?=
 =?us-ascii?Q?3gN+/ps6R3oJy6Njdnclh8Nb2Obphpi8dgEE4uzRDrABecGP40JooomTC+5e?=
 =?us-ascii?Q?AKHtdzx5IP/E+vwEjSDxXxtNkX9vvDG1v/eivhZ7xjj6UVsTkPwgzzBDyvpW?=
 =?us-ascii?Q?Yf+xTtkjDA4lKaaXlAMeVfok2yNetqE65JGq+TaB1ui2Wadyr6g9www+SkUN?=
 =?us-ascii?Q?nKaN50Jv/UI19chQIWC4O3BKTj8srAV7G5gTLEBro5b2vlaQKfAl+XKiazis?=
 =?us-ascii?Q?Nf9w+F8zi8oKFB/0rrF7GWk2BEAl51wmVzeELHyh/rIp3t+xEKtBSYDM9LFi?=
 =?us-ascii?Q?v0F0i3oKDiniOohxobM7G1mFNSXvTdLzpW8tUuwTuflzvGaOh1HIE4Aq+q0t?=
 =?us-ascii?Q?CNY3k2bwtT/sutRAgKQZtK/MOn9TToRQtHT7e4gXXB6H5NT//WyIeplThbLZ?=
 =?us-ascii?Q?vxnQlGDrpkY9XT1ZiHviFYaoGynzyp63A7re7JpfDLwxWkBHpooJnkd17TWU?=
 =?us-ascii?Q?HTjOrG0fMqcrg5Q524THM2uR1oFFYYMyqqrjUblf5ujy76IlblG8cN76L++9?=
 =?us-ascii?Q?eWc2kc6cZWc449v++7mU1imHkqDsQ3QQrl7kUzkr7Rt1KFlt8AeePQOQlxnK?=
 =?us-ascii?Q?p7kUFekloala2cBnNX/dRkLIvksF7e7MtULyaL1ndH/g9pCZQHxSKCdpHLA8?=
 =?us-ascii?Q?ktxjw22pccAHE8tg58zFbHhh2jo6RwnNKEABdE8/j2qv6++2pjO/J9De/NCR?=
 =?us-ascii?Q?+YZoDfv4mssk4/h2wbCq2mn0//n8XieDQPLfKHuLCKIgMsExAr4be8eLXNrx?=
 =?us-ascii?Q?noTv1c4pGYK5cgqBnWcRYU9DheuaSVTRgfQlJXYwd1YDO2dVyzcjvDs0i0Bl?=
 =?us-ascii?Q?YZkaIjph7Cxz+MaYRrVkWc5S36lcg78NOn7A0S0zX0cF7hd2Vw5sJOuDri5f?=
 =?us-ascii?Q?MKeJM4xly2GwPt5XWiuqqL2hCx2/dc8hgp72EIXc9PvVMZKzOnXhaBoSHVGS?=
 =?us-ascii?Q?47jtmfl7qQpruln2UsrAuZUKjKAXRIB8r4NejfeB7x5E8XeXSQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BQjEoj44xyupba5f8L/BJ5csi0YHaOVivEtFTO6/JDynJKH4ffB9hG7JhtmU?=
 =?us-ascii?Q?65dAbpiNCUmnBM6g5lXQChFsjCNAQ9xTMNRFqaWcTmHfjhw4iauD/8A+4MTf?=
 =?us-ascii?Q?YkL36lPqIHiHsuDQkbaovQbrqaHVyjJ/d3Ss8mIeMvXG/3awYzglYxrGddnF?=
 =?us-ascii?Q?X09SmFdDUe1rokEDmTvzz+G6Xw26C0pZFxrIsJyCUDIVcJem+OlpJrLYGHpU?=
 =?us-ascii?Q?HRER6a1XXI7bGTpwFTIPAeMjYiv6gcI0vY2oHWDOTCgjVSC/xL2NDSd7sWFH?=
 =?us-ascii?Q?mPQewSeAw5gDz1n4HT/n3n11p4s3FXaZQFEUkCU7E6UxP+0LO2lAy8m1VqOq?=
 =?us-ascii?Q?p1Op2FlMzV8JfN91yIqIPisscKPLrcMjat16MsiBaaU/NAU7Eu8UJ9I7v2Yx?=
 =?us-ascii?Q?wj45slfj+lXVUMDpqXqHqUlIMVdO03zkYXfuzkasrAZkCwtefbKv1dsXmmYj?=
 =?us-ascii?Q?eu6jTBTF1GZy3gOZ34sjSzAY+XH90TD/sXKhsiyIENRiaWj4C5i/w0AVdINr?=
 =?us-ascii?Q?p5Bs2iBvLgbEzgAeOfGjTv17FO3R5YrG/npH7mQ+UZu2g/ZQwvZgcrd0JNg8?=
 =?us-ascii?Q?2rDPmJxWSZe6g/HHnWiLXkLo6KYet5t5UNvBQ+BKph1LQh9+d9b+MKw0bQF1?=
 =?us-ascii?Q?w8xrzsg7nJ4PvjdvNCdBAT2ID7SwREzm11wcHPxKPVu1HmL2GmzvhefIbjnY?=
 =?us-ascii?Q?C/Ft1avy/pCp8gZatBftFQVHoEMjqpfnYPa5yvutqYpe63aI1WW/aH2qF7pC?=
 =?us-ascii?Q?Sqp5PWItEHr5HLIl0tiyf2XftZQS6HBGVZPA3lMNCe35gBSvgTeAuCZcmGIr?=
 =?us-ascii?Q?Ng6JsYYuUoCNPMPvw4iSW4heYYXqZpHQp9yOrHo/FBn51SV8jVTvjvhML//Q?=
 =?us-ascii?Q?7KD7fVgwNpSQli6Gp5kPWbe4qez4o+TMIK/7MvkjZXCLp1Y9ncvmHWfpedxu?=
 =?us-ascii?Q?XlmfS8d46GgRV05tUWY5FWsjrDU98ewVnNZMp6pKNwXBXeBjB+4k/a3vX0Gv?=
 =?us-ascii?Q?Dw3FIfJQfkL8BGtpAAiiafISJy08R5VRmNSR0lvgjd9Knq/MKfKEUOjiHzpf?=
 =?us-ascii?Q?Bcd1XiymgSf2I8yeCOA352BzH5KJ/vI4KyvHgKCcB64hwszKCWyeQ+p4mhpw?=
 =?us-ascii?Q?C5WhSCFHOSqCz4bUC4ItuVT97mrSpHkLapBZJvqg2byiqHHqGbdZnkGLmG9o?=
 =?us-ascii?Q?J6eVfs+OAL1r2jWZrwdIMCS67u4bqkDnHoFFNZzt8MW3fAsb0RWC+LdBhWyl?=
 =?us-ascii?Q?neTFWh+kgUa1tzqKAy48/AYWjHYydfdjQgCQzcPe9ZjAwD0ERFNOBgnvoj7a?=
 =?us-ascii?Q?585qzgAc18lv1Z0a3MAGdNxCQmY5EUqnoidaDn6qymv8arCJNlnEhHpzCFvR?=
 =?us-ascii?Q?551kJDw5NvckHjweEpQ16IftomshJe0zo2P1h6/Ykzyt+QzQo8FdOxQvrApt?=
 =?us-ascii?Q?RSt5+BJMXDW6T8/irZL0R8s1J6r0+5vakDuG7FAXG3Vuwzwf54aLYEYnlEpI?=
 =?us-ascii?Q?/QTvBTrQkqVG15/YXqM2KKbevxBCdZeIEdsLopOxm6LMRNhipqco8YUB9IJa?=
 =?us-ascii?Q?erfVeeUTIB3a2YZbEuE/+u9t/Ks7ArkfyDerGK/sFPD/6feN/R6UK5aHtBT4?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 883e5fea-26ab-40e5-0a17-08dd872b85d4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 14:38:35.7018 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OTcKh5iH+JSFbm3CK5eGmrAmZVmUoY67hvRpVB44yJwDGAMf/LTI81PVd+MU18j24kqg6PMFlo5ukoeE7oXBbYHboI2wZuO3KumL6munTwM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5013
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

On Mon, Apr 28, 2025 at 06:07:13PM -0400, Roger Melton wrote:
> Return burst mode according to the selected Rx/Tx burst
> function name.
> Update 25.07 release notes with this information.
> 
> Signed-off-by: Roger Melton <rmelton@cisco.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.

Thanks,
/Bruce

