Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945A0C43458
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Jul 2026 11:02:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9479A40264;
	Tue,  7 Jul 2026 13:02:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id D146F4025F
 for <dev@dpdk.org>; Tue,  7 Jul 2026 13:02:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783422160; x=1814958160;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=nnfv+oCS0j556EJk5fCZhEAtiC1qEXPwGtDpRjFn/zw=;
 b=oHIyv4mFjSXog7+kcaPvnxxUDyISxxo35+qOWOaMH2rNzRIra5zzr1s9
 O1IteA7yMFqN5UfAEFCGusP6XDgyUAskvWGB7+QYZFjBtCLDXatSoBNqj
 N7zi5cgicevWZsgW8tppW6j155/o7/VJaidEi0YoWHaVQfkhLtyH5v/Pe
 /WERV4m7P9q6WGo177lVPuXd0H3PQegqzDUn6Y2qK8ofcYD1W4UGn8ZoL
 cR1FXS+k7bcqQrmRcN7GA+6mUYlG3X8BWMN4ooN6TjoWJvqo0n8LepWcT
 WA9l3ludZgZlkbVPx6UAKeCbkuEohtClLa7+54EhY4LTCCngaY8UaeKUR w==;
X-CSE-ConnectionGUID: TXRNuWSXQEGJ2pB1ktJZBg==
X-CSE-MsgGUID: gj+5CNPHT3qJcZFY9/V5aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="84088741"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="84088741"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2026 04:02:38 -0700
X-CSE-ConnectionGUID: ZHVLiOZrRRey5kF51WPXTg==
X-CSE-MsgGUID: gxKzapbfSFqJWwk6frpk+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="257544627"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2026 04:02:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 04:02:37 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 7 Jul 2026 04:02:37 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.30)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 04:02:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xIkdDF476R00Fksa0KOi27Cgqt9pzz8arLnN2Kh4OgQqvlgkac9VoalCm17tuwj1jyyVmQ5g1tgsFz0x7uniZ2RRc8B66ZY0lXl0Lryq++QkHUXf05R5PM6rxkUe7qb6Js1iaVXDaONcU7McxvVG/fQraY4YoTqVDQlGun5A/l3yh3ytHRcu8tjR8NX2ShQxZUb5b/Eq4EWfz49ZfhU9E4fFYnToplzF47uRyYozkaVXhYD85nKx7WaeNIzZlqxLdjg3gVq/Hdi6hJaE9Lch4+BgvcGjKdSICk821wZ7aOs786DwGI+GdFFeTsaSzkpvV5o7Q0zZZ8+h37mvIHuhWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSYotOEadisHotUQWzB5deVcyzi9m6IFh3jDzKkRW8I=;
 b=gicJPUqmXpB8w1ifRMSPAoinskzRhZYty55p5Qes0x7hUJRuJHo7b2ye6+guA0Tsa3sOAORhIGYI32cWq9+0Al9V8Oawoskj31TagZHcE/TBdoeLPe6ppidPh7tY7L2cNsduXNhURPD/5VONOsooYaMf65yXbQf9UdCsIvVXN/EpiAMAeIUDSkDcCuXfiRAgWUTXeCAA1owxyaWTxtdQ98YzJo13GvWfP02x/2jbAY+ZlimlFHzd0y8k0lYt6GecVYZm5UnCawOoxQ5jUBOC2XGWGZ+ZFpjgzSlfwzmMrEBFLN5uNoEFVR1Fe5M1ANkO/gKe60D3PmedQeYQRgKfuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by LVTPR11MB9911.namprd11.prod.outlook.com (2603:10b6:408:3c6::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 11:02:34 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0181.009; Tue, 7 Jul 2026
 11:02:34 +0000
Date: Tue, 7 Jul 2026 12:02:28 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Parav Pandit <parav@nvidia.com>, Xueming Li
 <xuemingl@nvidia.com>, Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena
 <sachin.saxena@nxp.com>, Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta
 <nipun.gupta@amd.com>, Long Li <longli@microsoft.com>, Wei Hu
 <weh@microsoft.com>, Chengwen Feng <fengchengwen@huawei.com>
Subject: Re: [PATCH] drivers/bus: remove blocklist evaluation when probing a
 device
Message-ID: <akzcxJwc0X_9UXFV@bricha3-mobl1.ger.corp.intel.com>
References: <20260706150611.839502-1-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260706150611.839502-1-david.marchand@redhat.com>
X-ClientProxiedBy: DUZPR01CA0210.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::24) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|LVTPR11MB9911:EE_
X-MS-Office365-Filtering-Correlation-Id: d2f6e876-ca3d-4447-604c-08dedc173fb2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|1800799024|366016|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: NYT7HUN9CvtIv+ffX8emf3GZvNUcK8b0pTw+U+JeWH+WmR1x36uZZ2wFzWnb3FyeYJ+Vs/mlinurO7N8fk/W7UeL1Rfba9QvgUknXgCiaSGwrIWNlN4EJ2UIQXbDlcWHlZp81NZlZnzpabeQPjheyIxuklddxF81qxIQEz5vYfXhJJSZ1lNAPzaxFBoFMPYso14oHnKdulbzTGZLsV8aQMlHBUJJ9BPnobNXy5Ctc5xvj9YbEn+883GteSnU6/UKHPuWceXM0usY+RNyJEwDVBOmaf3K9LThYijYe4mMntHgDo/PqYLlAokJvt73fuCUd92LhQS7TgfC5eJias4gc8tfrgR7TBVsLuRerRCi6LjOrepecdg/UuR1GIOUa9PzQx0YLZzVLSx4ucDn7xHsTW87zPKSI9Ghq59mETlhFMjX15SZZhS5o9HgUfFVbRSY359JZjw4c/rbyEBah2yHZ1cGThNNKRE4LJ2gstAUiKrz5tiHp5TtSe0HC6niPPePXB237T91LFeQBlKz66B0nEx5rtHLOuSscTGLcNwETPUo5zBjDf6T1i2JIptCdD/Pbo5yD1u0ZxvVn/8otlongja8i4V9Y4GVKzB0J6izahH+kW3GX1hIH9J7XQ2EbBnoUqAmeU/3mwC4B3cBNXKMyMip7WTzzVAcNpA+3lXJ/OY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g2W1vZeHVezlJSxMGudiHqdUWd7SCQep7dNpcB3gA7MgRSBN1lGuYa1dUaCf?=
 =?us-ascii?Q?+A551g/hlYOalUc3UapWNMIo/yNgRCU+uv27BNSG4R3CCDfPjzXFq7wkBu1i?=
 =?us-ascii?Q?Txh3Aa8HQNRFNXJibB0z7U1GV8jOAda9IKcvC4uQm/iFl0VF+KOM7ITuRlxd?=
 =?us-ascii?Q?lwW3gf7EhVV2odk4y+Vkk+DzrpCJMuM2BvqQtb8SSJTWDACHhjfdWy7tZzoC?=
 =?us-ascii?Q?dp7KRf5q1XTT6Q28jDnlYpog1WOmlWhcX71WzdIeKmJGFp82iriFXVbdYVlR?=
 =?us-ascii?Q?FHr20LINPMqsYNwcR8DdMIHRuDEBPqE9kDBse9vegAZO3aW4QS5GrlMBgn00?=
 =?us-ascii?Q?8AYyW7UApTu/xWOg7+y7W90XBAnpGUFNrnBuZMktpQJIoSjLav9hKcMr+e04?=
 =?us-ascii?Q?vJ05eghLjT34sfloIvN/fuVOczCL1ctu0/S/9sZDxGZgwQEL0s65N+9JYdl6?=
 =?us-ascii?Q?iE/pE2P9HYihxZOKiKgeU8D8jkOMWejkERrQUmfQdNEW2d8Wz375jQx8DPNI?=
 =?us-ascii?Q?kxZWw02wjMUj4VnUJE+c3TGNcZuEtDKnHSKBlNbrspBvxKUZ6mHEeJzkaF0G?=
 =?us-ascii?Q?gu/409FMffuhU+KXCOxwSYsyzfX4xF2usKeNNGE+DdXjx9dxgJOogTRQMsvr?=
 =?us-ascii?Q?6upI6ZvzxisqKewJVzcj8kcOANezXea5GxvW7hVdoK1khIuKx3tF9QpY0ht0?=
 =?us-ascii?Q?wNE+3Z9JfzjJXpFbK5s6NV3LvrIMYKRcBi/0tJJXuMCel4gAwjyhlcwAYkVB?=
 =?us-ascii?Q?URxpZnYoIdlBP59kVE64VGYTv5DCNeYiwCdAtkpO1lo7Ra9PUIDpdtglI/Uy?=
 =?us-ascii?Q?tCo6VST5vRS2k5xTUUwNZrX9VZsDLdwielCCGaV26pKa9P4BUCLJK6cyKTdA?=
 =?us-ascii?Q?pEBNqPBr48bitxL/t+UNZmPXzN0dw2DiMZeQ0/8Vlh3fFzvL3N4TbrtfpfUN?=
 =?us-ascii?Q?E8LPs1D5iMfSJNAtljbB4USSBNZVnjQOwWxx7fxqvdIs4lEnJvFZcTJd+iI8?=
 =?us-ascii?Q?gL/qdpKF2jh1bkmg7u81SqHu7WwwGqDPg99ovwuxwR9blZFIHgZT/DWCe/T1?=
 =?us-ascii?Q?nNs55BSwB2hydpN8p3snY2yiLgA3hwtkw5gTX11bsbGnTibbXL5LTHRo+Y8N?=
 =?us-ascii?Q?uvt2SpdsqoYrANvojCboyaXlnnroZ2hGVE+Qh67nn7vNzFBckjf3nZAWr++S?=
 =?us-ascii?Q?MBYaKUcOuAwC8Oq2TfjiwDnDIAXPkqy/1MeUpzmm3XLCYVkSPoOe8Z1t7n6N?=
 =?us-ascii?Q?OZ4mj8QE5NKCUVnW70pDegfSY+8nK2ZROAI9UlfURzY6AihO4ipSOuTqyrG3?=
 =?us-ascii?Q?+pxh6zdP4+zMgVxhQn0QgdCyfDsUD/Wsas0iOoeUdMQNThBw8nB7e7ZlV5J4?=
 =?us-ascii?Q?K8gsSKEaGpX/bA0rGT+C0OEuVCzaHjTHgS/oR1qdHYbGMWOFnt0jEY7G+fKG?=
 =?us-ascii?Q?2SQ+0Y6N15xBxyhV+k0cYH3/2kG5+6DwSnwKo2ssoExa/y9hqGFsQsLx+SXD?=
 =?us-ascii?Q?Wlb26YpAnvxglvTvbVviNGViRGJsObeZigYnkNgiZGW3QxNtJVE/cOn/gsfW?=
 =?us-ascii?Q?FcS89gZw3QtaqOjJaq5lGeKQOz0+r6idI+vC3zutJJmqiS4UlbRVmx9U3YF4?=
 =?us-ascii?Q?xJpwVM4qW5Yqky4528qTEvHKZ8e6LcwrBoiDxckv6CI5pE+jqyt1Ynq61ZO4?=
 =?us-ascii?Q?oo9dy84jL2NDLecjHth2D8yVD32ToCBxtC3HZIk6WhtEXP8wKaOew2+joMAd?=
 =?us-ascii?Q?C1cQAVZ4YMij/ZlO0tXGEG8ZE11He94=3D?=
X-Exchange-RoutingPolicyChecked: nPdA2ZN8qyQ6EycZcfNPKwJiA2C8VtPtfY+e4Ff10naDRFU9pu1ZqVxRaSUYG1JXPaxCYDdyx3hRaN6eIg1vMwCQHumLethlGE72njbU+9zCe1xnZOvgdv39c8xCN4uCfG087Zs0srsJwvIVXBhbt9sv7x8+vdoeHjNcubCm/kyQNu/O9B1bqFEzYHHTfz3U9RtJ+3MHbIY4KHhIJiHaSSF9dBOcAxlfM6sK1vzqf6BuT0sLEnWvN7o1Ps0ra8t1pP/IeDXcZ47z5guSQu96kcSbMXrlKUy59ZV7bj+RZL8X9Yth27kjoPsu5KYgR7JEJTf8krs21tZukvSPqWU/GQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d2f6e876-ca3d-4447-604c-08dedc173fb2
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 11:02:34.6539 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rgi0HjxkCtJPKPUv60HcoNTlX+tqSW46LNooa/bcMaGBEEQ7FY1U6VQaInDawzIAecGxPU+FqVqFzgVhhLep+eXamznGipiB/sXKCcy1D1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVTPR11MB9911
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

On Mon, Jul 06, 2026 at 05:06:11PM +0200, David Marchand wrote:
> .probe_device is called from EAL, that already evaluated if the device
> is blocklisted.
> 
> Fixes: be29c42523d8 ("bus: implement probe in EAL")
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
