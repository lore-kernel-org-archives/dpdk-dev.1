Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D30C44501
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 11:12:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E160F427D7;
	Wed, 21 Jan 2026 12:12:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id AA3DC427CB
 for <dev@dpdk.org>; Wed, 21 Jan 2026 12:12:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768993943; x=1800529943;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=FyepvQBJDpDt+cRqHzZp5CM0ai1Sixiz/nhMLaddC90=;
 b=QlpYYo2x2ARQPTGqKQwS0FOCmyNYFSayS/gBKj15zcwUkFkr4aHrG0Sg
 LripRbpaY2T4UBYVQosXBlHdLv7HFdleu/cbb/VRLiYgSXmstL8bs8OoW
 CARGDkDcH+SIC3pw+WZd1iAi83LJ80smhYQtUaYK09B944mm+u3YStZNG
 YujidDrzS5rSvvexykJMk+o39pY8pBeom/YKqq3eFqFd/ZyAr1EwXV1Xw
 Z5k8GBxD0z35E97uqqpAi0owKjd0G1HFTG1KEy/x11VgM1QNhbp2Bh7i9
 gBetLmn0q0ct1aB2DpkRZF2tydVh6LlebgaWw4SW31vlCr7DA4QDn7tqg Q==;
X-CSE-ConnectionGUID: 7GAmLVN7S7imXunwZ8lL/A==
X-CSE-MsgGUID: 16L6luVCSfy9/Sek+0nP0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="70383241"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; d="scan'208";a="70383241"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2026 03:12:21 -0800
X-CSE-ConnectionGUID: xzwjdd/bShGrWAKohmAmGg==
X-CSE-MsgGUID: 2PhdL+psSUy5MiO4k+5yPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; d="scan'208";a="205555597"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2026 03:12:20 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 21 Jan 2026 03:12:19 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 21 Jan 2026 03:12:19 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.2) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 21 Jan 2026 03:12:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gpM2pyfzPq7C5/CkZlKziW5iiDpg2t1mXMfnjTfb5IDsGpxwdnKUHbWTr3rVHATFNBG+6SIgeWkhczaCrCpiVMf5SOKcZV3EZB1mBbTWBVLKYdZIO6C1DRDI1V4e6JuloJN9pdPGZUAb78mEPnYjWMDW5Km0dvUv7TRYcEPH59jXW0+jrikSuvM6U188GT259nGFRgzo9/JMb+wLx8FNBD7l7qujeYlwxviFKWWly/uDrF9smPWM0C8e/fJ+ejWo/sjK/dCYO6IRw5uEzBOx0cQdxWGKXEMsbJv6t1/Jw7yYkUdh6U3CdsKc99bk7QFM9a9m7gNZY92xYp1AasWskw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7hEATo+2EFq1lxbRmFujIs06ncgzYwE9hqSNzryMcTE=;
 b=dKJ/j8X9VIvxD2e67KY+su59GYJU3mthN7P4GXXtFYFORSG2LmMxLzRK8m6SI0lYlEWYPoN4SftudTUebaqQIITViI3JEn4osvSmRg48MINpkAj9UhK5t1zLxMMyuhR1VUKkRLWSoJzP/huNDNzFq6EQ3HY9+z70nyyWp8y8wKPuS1SEMVRZZ8JB/f8L7SKgQWCNvj26hZag76z9jOTYWlf/r2Dzm2k7SYjry6IPonQE6p853dpuvS1brm+PkohRY388K/Yk2QLDIVaanGGaxcANNzrSkeH4E1o7O5gKPT+1fR1K/DIpdUeKMj6oUb51dUM1cggVS6mQnKgWkMKyZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SN7PR11MB7994.namprd11.prod.outlook.com (2603:10b6:806:2e6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Wed, 21 Jan
 2026 11:12:11 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9542.009; Wed, 21 Jan 2026
 11:12:09 +0000
Date: Wed, 21 Jan 2026 11:12:04 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: <dev@dpdk.org>, <david.marchand@redhat.com>
Subject: Re: [PATCH 0/2] More fixes after enabling -Wshadow
Message-ID: <aXC0hMTMJ8fCwzTN@bricha3-mobl1.ger.corp.intel.com>
References: <20260121110757.1948723-1-thomas@monjalon.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260121110757.1948723-1-thomas@monjalon.net>
X-ClientProxiedBy: DUZP191CA0016.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SN7PR11MB7994:EE_
X-MS-Office365-Filtering-Correlation-Id: cabdbaff-50cc-4962-4bb9-08de58ddeb6a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ORJx4JLmP/EEZjVu80K2rDEO9EMwsUHLZMI5llEeiXt02u0blnxtz/XpLVhR?=
 =?us-ascii?Q?5lgoD7lYa9aFxgHN8+JR/CJAO4oXHsQPE3c+pn2tQ3iB3PMbIM1Eg+ZBmeEt?=
 =?us-ascii?Q?4OSvK28SuFxzVbHDRbdYHaSHY19IyVZJ5R8eUlW5uNhKIN1mGxByvXKeqYGw?=
 =?us-ascii?Q?rO6eSKx6G3fPvEMnISVV0b0UNcPA7LwGzEV/C7PX35WUU92QxB3cV539Arfd?=
 =?us-ascii?Q?7AMfhYYjW0LNqPU/LMdUhzo8SHzcHE1hV/iuTY1sVt8+Swt1J3wQphhGb/kw?=
 =?us-ascii?Q?vB6wrXf4ngeqsz4Snb9tKR0DQlr9kZIRZkvTHFTSe9QwADj+6zynnSov0kKK?=
 =?us-ascii?Q?UATKrDM0c7eZpJLKTDQBGikjIpjxltv2t2QiM4+zQDOCVYu+K22HIxs+sF+A?=
 =?us-ascii?Q?mpLKTFhygObkp87QjIER3hoWnrQKpYEIpZb7hGS6ekIci5Y2N0MQlH7FS6if?=
 =?us-ascii?Q?cMp7Y4kGcz2JVljhq4w3rYxG2gbBaINlhItDuQVYdRe5Wdo3pgYkujS+iR+X?=
 =?us-ascii?Q?yx5LdD/qM4AGRTxabIIR1A4pUw0YZVxw8dXDac87fHYCAHqxja+14HEfab5Y?=
 =?us-ascii?Q?pftvSI9DXAHr9E66P6mdnK33htSMXTu5WJwH3dqZtKIv7UCOfHVsA83k95CB?=
 =?us-ascii?Q?ZjqF1Fc90oakimsob1KpXlkU0Jul06aObsPr6Lo2wU8V1OVftph17cnsJflj?=
 =?us-ascii?Q?X3u/4t1IBtUuXhX81wboZoixvyi+Nk5jO6bENJNRuw9BhoKpSEYx177+TC1D?=
 =?us-ascii?Q?YXMFBXAQT5IEUr4GRuw/iDjQ1AUPUF9J/AsyGDwIC0Cao3XqkDx2BJ/GA7v0?=
 =?us-ascii?Q?7J0mgatM536bKIFz7D/997iWN06MCe8dJfKRW0xBXV/IJTO1vqdloUweLl1f?=
 =?us-ascii?Q?Pg6hF+9PmckPDadfheew0UmHZYQCIraqkPftr5ao2Wz8laxLnCc6wa8/UmjK?=
 =?us-ascii?Q?Y4PNRupMNESQD3P5vMB680b6QBi2B+ysCzpB49zf1HgQu3JtNsXSpAvgmjdH?=
 =?us-ascii?Q?vYro0otv0IPUEJK4hixx2eaU7vyDgvzSewRA7Qx4N2NaZKnkzFYO7jUNAPGB?=
 =?us-ascii?Q?59u38J3I8uYYpy7LaZLGIaqpRcBq3HEhM4JOwY80G4nskQxmleOHVrra0Aw5?=
 =?us-ascii?Q?Sp+F4g2XjPgh+lOARanwoXuSbpRrL+jnyqYLeonziOpNGFlV3cS1fRlCMARF?=
 =?us-ascii?Q?HkUrfyPOf/HC9B4ImljwVsYH5pDbQTm6+IFm/KDpEjKjgc+MGXrqrvAtQn7/?=
 =?us-ascii?Q?MKC6X4RaUGzJzosUkZYwcxowxzNXD2BiZM3rGQLCvyXtflFv3aWgueGo+Slj?=
 =?us-ascii?Q?IE5kn7uJtkO/WI+70XW9MJE2zgmWo+xSDXlMXeIPPPjwhIku59vW7TyVLaWP?=
 =?us-ascii?Q?bWBUnFz66D8jIm2BVR2jMgK35Rdryk03ZkDv9J/xdBhjYgAGVLFN+B9aNbqH?=
 =?us-ascii?Q?qptZBcvSL3c3P6NS98z6PncRhjG2YFyqxbVA04P8khQhk014QlkNmFyaIlUk?=
 =?us-ascii?Q?dm7hJPegTg3cxyRrwoG279C9PsyYm5RurYx4faqUFQzLHYPc/pzIFVWCYm8l?=
 =?us-ascii?Q?CNzf+0wUkApwNoXBaDM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QSa/Zba7xgIx6RQHiWhUshj9mp5dlYMUn2IJjE3LQUPTi7UkgaGWNPQDYunx?=
 =?us-ascii?Q?ivouKsh3IzXTISXe2NrNWT4RwJpvJfV+8Csv2g9/yCcuNj+ZFtLZ38crQLEc?=
 =?us-ascii?Q?Dqa3sAolh1pP73ooc9AlYMxD11Lqh43q46HZ7JF73qeR80cxYgELovkIXmGf?=
 =?us-ascii?Q?pcmaNfHsDPT6YRtZUbUE+qAL3+YewKzmbza1ep95Nse+R5jrYJIIul6h4AFz?=
 =?us-ascii?Q?FvCG7rhoceXRBBZuYSX03fVt6n/88NMOW7L8LUD7qLY4Ns+YvzlXul5LpXT4?=
 =?us-ascii?Q?810HQrZDPZpT27t6JUgfqJmcQbfL1cz0egGVqLwb4qyxvAbxrWA/atxn5pCV?=
 =?us-ascii?Q?74HY3SQX5xdBusbsvBUHMvQtfcu6J3coniqbYaZm/06APp7+/sgufRkKqAKF?=
 =?us-ascii?Q?LbYgh+E8F1Cf+HEbfCMWI07oKWyudy/OTsyApHdhN2WVqBaAp1b750VHm0P2?=
 =?us-ascii?Q?QyVKRfuVP9We5qPVsydlyhG8eO3vVCeUT5mi2I5eVd4WvLHIc7UCHLCZUR7m?=
 =?us-ascii?Q?uE+tlTBA8oALVM2op6tfEd8xpEpLjW1qozR9CAw0V2e1BRB4ayuK34NRbjBB?=
 =?us-ascii?Q?xb6X3h2ypXMRSmSzIGIQLFzA61936elcX/Bp2CiQWlY5uFkbPpfKengxaw0J?=
 =?us-ascii?Q?35LsU4UzqqpROhKU5bIlX1Iv6w5pWC49QaMr+brot1RLbUT17SPyoyLXdkfJ?=
 =?us-ascii?Q?XF2xkSX8y48Gu1mwryZMPn/u8Sy6SDcpVdTAaN52fZiUgDxs0y1CMfOKa/RB?=
 =?us-ascii?Q?rRzIBRIU2nNWCEhuny2eU8YkFF4pjuMQ8mZZ0BI9/D6Ce0keQOyJVi/Kbfg6?=
 =?us-ascii?Q?5BQy+z9J11qhu6nm0uFwKvtTuvJ9EnO2UkmUluZkZMDjyvz9DU4d09r93gx8?=
 =?us-ascii?Q?GM+mFZXSWQNEOhWbzXnoO08h9aR5NGxWdJ7zGpk9Deo4T4enXUSCJbB8GiYY?=
 =?us-ascii?Q?gw+DT5XaxZihuiz/FtZDUseOfzfPttbNp4yovoJJN0FuO5ZiwSzSxvneebLe?=
 =?us-ascii?Q?ueg1JmPCFQcjwERt0LzHBBePNZTLOthmIOdvx8P/caLtnEi3TuFNFLYiXtCG?=
 =?us-ascii?Q?uxRjM+Etz0VQM9qcfM7UHn8o3BNZaNu6026I3mCyY7xDNWJVajGSSWP3kQ8a?=
 =?us-ascii?Q?47WZ95gK8kvkP6sR2DdbBA1GNhSC/xSdw5s5mZfsbvu+dyhjanmqZCmGiRGv?=
 =?us-ascii?Q?TKp1/eJfNDgFfgAvBdNzRYF/W1QWQzmuOX3hAg41guuhlB5D7yfjOP/WX1wr?=
 =?us-ascii?Q?8ZjJ/NW2NpmS1JqTBSBoAKEywEGrmKMN/7+zRbW14P4xzV0gd+G8WVlWEQiH?=
 =?us-ascii?Q?ud4A8MsFvWDM7RtouF/Ohvs7s1KFDqo0A+7g/EQxV5pd7TqUsUijVzNULMrN?=
 =?us-ascii?Q?cU2c7au8+MM2H8ix+pbNRY5HPGDDRKPXvSnZjusJaJM4piLwi+TczQHMmpvY?=
 =?us-ascii?Q?yUEoiaA2WGHLbP9IWLS4Aj477Mgi0HV9TSlvQLBIg49LQdqzfZ97qx2DKQXL?=
 =?us-ascii?Q?VD4DlZnUXzKrdsbLmlAXzxWc6j/cvop3IQ/kuMUH+kWfZ3nMvZwUTxi0bvWf?=
 =?us-ascii?Q?rLXpMq8YHqJA9sZIpR43M3nw0SVgv7+KzdV4fAlN1Gr09RUgs+iQi8Gipf5F?=
 =?us-ascii?Q?er54qSNfFZyhvaOeydjQ0S/fGgKg6Z9+cvMyyCX6bU1LQL2BrT/fwOqp4HaB?=
 =?us-ascii?Q?fl/t/pMKEGHbMqU6Lu40EuzMrdjRVWUH83RVsuQiOjoEC4ivbQjWCBX4KANh?=
 =?us-ascii?Q?m5//A8EUXwCfyE67ZbOGJ7wz0cvUl1o=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cabdbaff-50cc-4962-4bb9-08de58ddeb6a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 11:12:09.4898 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kMX+BpN3oGrYj5/+45X2GJyDp9jhK1oQCvp3JE75F2KiagcVJMb4yktE2yns9p6HVQTlNEXE0rEMfQT7nrMY16USuCnoFNu+sr24rkorcgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7994
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

On Wed, Jan 21, 2026 at 12:05:59PM +0100, Thomas Monjalon wrote:
> The drivers mvpp2 and mlx5 for Windows
> were not checked when enabling -Wshadow.
> Here are the missing small fixes.
> 
> Thomas Monjalon (2):
>   common/mlx5: fix variable shadowing
>   net/mvpp2: fix variable shadowing
> 
>  drivers/common/mlx5/windows/mlx5_glue.h | 2 +-
>  drivers/net/mvpp2/mrvl_ethdev.c         | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
Thanks Thomas.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

