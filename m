Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39E1C83F1A
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Jul 2025 12:15:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7EBCB4013F;
	Thu, 17 Jul 2025 14:15:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 043F2400EF;
 Thu, 17 Jul 2025 14:14:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752754499; x=1784290499;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ov+Ty9yNYjrNQXQm0u+manc2+VVl2g3mZXRK1i9itZM=;
 b=WHhQrhS51u0nW/m/ghcyjx00kFCCB1iqG9jV/c47v+QcaNqEoFlyBY/7
 r+om+9Jp1u78MJfL0oVka4SO6/t8BF+7nCnBCjHu5IFuWDE9qOwAcJ1g7
 n+ZEwoCvLUMzyZ9crJ280tpgDAiV1wESSbMsph4O9b/FLWRRXZ3qbObON
 kAqKhJ5c53cdCgl0xuq3Sp1XXXlnLooyZkH8RycrDLweZ0/DVdQVwBXc4
 X0vlFnAkgQRZleJLXNvKLY6vNRiGncvxcWDL/hsJWcXa7uPj9M2Zi4PVl
 b9xYLH+5khpbM5WC2zD5oTHYZ3egl04bGn/T8ZHszZafTxaKyaX+scuEk A==;
X-CSE-ConnectionGUID: olgEKwYdQcODGW2CJvayBA==
X-CSE-MsgGUID: U67vVNnqRfOjQpF9drqYXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54243976"
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; d="scan'208";a="54243976"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2025 05:14:58 -0700
X-CSE-ConnectionGUID: n80zayKDQOOOpDpZ5z1kJQ==
X-CSE-MsgGUID: 5Je/xJldRsWC9oC26Gg/wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; d="scan'208";a="157581842"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2025 05:14:57 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 05:14:57 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 05:14:57 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.88)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 05:14:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yM/S1O7nwMnF/XRwVYzz/MvVu+fSVFxSk/52gwduoMUn//7Ua47UXFpo1jGlNDfvEmFl52enyyvhxxviWQnzo2bfnt9B8KpQCEaO7HwZvEuqU9MDfOqtyIt5MwdKyN9cc/C7C504VHK0jlSiZzKOkKabZBBGbJIfOrEIhlzTJK+vZ7wELzb5F3pjgAhvG6Ba6dV1EuHmq+eBFZSyisPLTPmm9zfSrGLYuazZ4cEAlCApX2DqNfn92QEYQAc7+lp4RyXl/m7gHK5qPv7CjQ/baMk40UoAYYbBvibRSqSE598kWqgUTKE8L3D+nLXIvOkwzDWxYOoyZyKNOqY8wRz+JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hb//sil7igEyi3p22z2I0MWmRISov80GpueMoQ9YM3k=;
 b=QYMTurCrr1fAMPgkQFHYKbh7eRpU5VqmGAsWj6RZ6w6bUDKjPaN4OElXBQ5QrQAV8udUbUUQq2la+bxSSPO4i9hQXDoLzIZfFloYzYEgxKNkNeONqKh6qd6hzq1dSn9KHVvMO+BTKlpc/JvbQFzKf9L5ipWVcReho7U9JsitkgralwvW0CLL4nueGB2htl3f6nhQgRC/fuBq9Ohcmbthn+N49DT7Z1lbztwhpnU1aGcFRZ11hpOagzlAuoM+sMHZ5jL6bK/UATGhI0D8KvXZ3rV34hNOEX+Rotyl8dQa9RJgc1JdQmfISlU/RhT5h94UY0tsDOjPo2ZyA3Yi3VN86w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MN2PR11MB4757.namprd11.prod.outlook.com (2603:10b6:208:26b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.37; Thu, 17 Jul
 2025 12:14:37 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 12:14:37 +0000
Date: Thu, 17 Jul 2025 13:14:32 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <stable@dpdk.org>, "Bernard
 Iremonger" <bernard.iremonger@intel.com>
Subject: Re: [PATCH 1/2] doc: remove reference to device selection option
Message-ID: <aHjpKA6qSfSxnBaY@bricha3-mobl1.ger.corp.intel.com>
References: <20250717114604.2285791-1-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250717114604.2285791-1-david.marchand@redhat.com>
X-ClientProxiedBy: DU6P191CA0011.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::25) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MN2PR11MB4757:EE_
X-MS-Office365-Filtering-Correlation-Id: 70048104-2c19-4550-b4e8-08ddc52b7fa7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?52YY+NtNIU3UncveAM0KXLs9LnnqFEVaDSuGmLPPuBkLYaL9ZHAhqGI9gpqM?=
 =?us-ascii?Q?FPxdPWjKAyFSqwoXBff5XJ9k5/wBRkabZwHW3Uqle7yVHm4ENh664KJWLiiy?=
 =?us-ascii?Q?er8xdYoaBONSgWbbdOxdeX3CAt625mLDloTdvlRGvO0ymVe1aKVa6TniA5uQ?=
 =?us-ascii?Q?ogwp8vr685dyvjBgGZMQt4IWpecGUvQ2FLFR7BA2KdnT4KauY4JwzflMVQtq?=
 =?us-ascii?Q?zpsG/FaQz0h7ZFjcfySEKo+zuz93rYglM/XRIC0LrYqPYJ+hW3zxnfiPQYF5?=
 =?us-ascii?Q?3ThTPuSzChDrardJEJrww5lJJO2Mzjsxc2//wsTY1LV5S1KfYYw/YBcWsCDF?=
 =?us-ascii?Q?LrgLgg8WldPor3PTLAn+VUqCRh6WPy+cqNlFvnjG2wPT0MywWdGci0c8V6qM?=
 =?us-ascii?Q?22yaJi+8PewE8Elk6CtU9Rf1KKVfTqR7YXw5BGw8OR/TJf/VMXcLiR0N0WyN?=
 =?us-ascii?Q?YUcdT5JUJpJeRoruoaDHFhMlxWbxXwoA0o48GTVAtqe/Ge4gPBo1VXD32zEn?=
 =?us-ascii?Q?B1t3+LfozmFTqALr+LFJCPST0F9Cdrdp6r3x9qilI4JGpZZDTZAwEHE5qDsE?=
 =?us-ascii?Q?YGr78PXuYrKWwNZW4tuwdpHAjLIEv1RAmOCq2aD88p2EqoX8XuyZ2t5Irdnl?=
 =?us-ascii?Q?esMmyGfnEeUVFQ84YN2jiTE7enIo5t7CrsG/JmbGZ1Zl1sFYFcAqVpy3p7jM?=
 =?us-ascii?Q?w7K2nh3BUB5yGm11zu4F3YZMAGta3oNJXlEhSGJxoICwJQE1uiYoJPwRECvx?=
 =?us-ascii?Q?dXpFf2ic2nmgMYI6t6cAr4sv/fWuKPM1llAr18U1ftX521PpIpA0AdeLAaXN?=
 =?us-ascii?Q?E0Q4AQq1U1syb6Y3vjN7dx/AwFFdKwLFePAbwJbUvK1eYoP1e69YQVjmfWSC?=
 =?us-ascii?Q?EhyOYO4mflJ91BZNzGfz+mrPpVjTn/f+ovbFLMQ1MRGeEgngX+rIOpqqSHvL?=
 =?us-ascii?Q?vK+HeotXgxL69jqyNhXYWIaMYjHVMmZX0YM+hdFa6/7yRnq35FgMf6/ddrOo?=
 =?us-ascii?Q?aUaUFccviWUT3YgHIiDxZf6mvZPKPYSTM3lYJ29Kyri2+UoV+sz/HW0gyoXo?=
 =?us-ascii?Q?fFCiMwB6OJHdygpO09XmfeRhzo6QZu5Ni4XT1e7PnxWUY4pWGXscNN0pEkFo?=
 =?us-ascii?Q?KTCFzB5ozgkqFNFXf0rS8e6v8rw8gw5aoMIaf/mG73cDOwQPgNFusMDBD8WX?=
 =?us-ascii?Q?mLl+Hs9PeFTkiu081Et5LfiOIa3WZG3ZEUnyS34yyF0ih+fu/jIuhQDCd24R?=
 =?us-ascii?Q?3hMTmgo7cJDVcXQbLE1yQsvC2Ra0Jik/vEqtdIkX6hSWMKF9c+M9XVQQHIqh?=
 =?us-ascii?Q?jLrMYOPIln2MopZvwCZjCPwfKkjZUCFMDpsrS55lDD9knpfG79rQvKWRSktt?=
 =?us-ascii?Q?YAA/vU+acGzLF1wMtXEd1+IYsKyIwAblCffMi2VSQf4WYTnNag=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p/EmgfkKYy3WIvWNt6N5wAY3bYQAyTL3pDeIWCyn4QNNDQO42gCXCSQvMvHq?=
 =?us-ascii?Q?Qse/2v0r30ziUQ4p0hgMphXbrr4zHbu9GO1ySviLdP6IRSFLsLOl5KycaIbl?=
 =?us-ascii?Q?BqYxqzL85yIlqF8lvDoW/BoiDuFXt1/l/xOjFIgIYqmuXFXF0VgNkPFFvTck?=
 =?us-ascii?Q?i8wyLFHCFMTAwc0wWgP+umD7chYHRsn4uvvwkCYWwHUcApWkp6JoFqTIRb5K?=
 =?us-ascii?Q?4Nu1a5ZZi8LwkNLQhuOeaRf0AdHDPyufIoH1RVSz7FmCeeFBf4JPnIhPnlUp?=
 =?us-ascii?Q?8Xlog6jFsNuodrsvIhq0ZYnG94ow1udsUhTf7XOU5z7INOpUzl9N1ujFT+tU?=
 =?us-ascii?Q?Mbqd6gxDU6JB5rReJ6ju1Dvevnp5551PQ26/tqgfbV+Ou4bk3Z77p8+Yb2ae?=
 =?us-ascii?Q?NEZRtJQz3bByukDtNRGAnmbYfmH+EYUQW7SnfjB7KWViDzzFhYdEPnVVIJVz?=
 =?us-ascii?Q?ypz8pGc7LloZzvFejaUIQj17Hk1OV7opoHLhWkC28WwF2lWNEgP55DY80FhD?=
 =?us-ascii?Q?z7tnWDfa3M01al1NclHu9q8nitcbBlpND1UGmJZ3Kq6WK8eWOtwvNBwnlIFD?=
 =?us-ascii?Q?0ffbUoiYBUm+z2q5lxHyQFWfg5Z/F0EehT/5AaRaLDUK/i/8VRcoONQJYUYb?=
 =?us-ascii?Q?CimGtKubMaG6pdBuCT9X4X+B2mEo1/5vBJ0pqx/5BPUpJMULKwh0JzCExn9W?=
 =?us-ascii?Q?4TTbT1GF78Ek35BiMPdIboBod7mBKFgAA81kaGIviE2mWO3GmmVeZD0g63dj?=
 =?us-ascii?Q?WOFPXtpyQQ5ovzVyLkCWv3tOH1cfpezu2/S2zhy995lu992SdquCdyZ3yo5u?=
 =?us-ascii?Q?MJci4g+YsGJQfDy6UXCaygBY6eiIriaxmOnWQHMI2Zyd7Gig+fJVPlvkgleh?=
 =?us-ascii?Q?8KhADT3bEWQssDHu4W9riMBgFAZVaEAKD2k0ijfmfJjB+mQyR6e340HtbgbO?=
 =?us-ascii?Q?WLGtQIPWWdnP+qTSAZLCO0lOoJvLZWjIaKs0Qg80+w7WfA4IRBrnRsT/SyZk?=
 =?us-ascii?Q?2jft7j+HuNKSKk+MMoWDNyuYnEjsQE8OsZtLbrbrpzsSIi7rFE4V8bz5tTPc?=
 =?us-ascii?Q?GbyLPMGgEWmcVCAKrbgK7OA8/mLnsunC5w8TuI5x0mwlnl6rAe4fsMKNvrRh?=
 =?us-ascii?Q?Pul20821OCUc1ylTcn8tJtZ6MtSVMpYjLy1MXzyE4wt62YAX/OYr8/ljSxTs?=
 =?us-ascii?Q?fA8GEcAjBWKJ22ILCb5A6WoAtAYyrfR547Zg3JpV6pk2e7vvnkLlccxBnfHW?=
 =?us-ascii?Q?nkSWeJUwx+JDudoPF7rJTMVygyZmjRlaWJbhMqXetv+jRN/n2HGrVqnKbs1S?=
 =?us-ascii?Q?ZWJD2QNxQ2xn6Diqz8FbkLh9jbf0+qxP0UkrplnujcjVd5zf0hyQIri4eOOK?=
 =?us-ascii?Q?8WmKbsl0NtrX0wz0Ytj2A5Y050RvlAdc4Alel5SoHkWaJnLMV4O86t4dNcYU?=
 =?us-ascii?Q?R93THdF8IKfZ7XY088fwLgwWEeSj9VeMwe2RY1JEM3dJ59Dj/gqyDlRnZZEP?=
 =?us-ascii?Q?/WBCCOBaBpQDFcw5dwTAA7VytUfeh4ssQL8Ivq8tSeJZNHNylrQU3a9aRTxP?=
 =?us-ascii?Q?hD67zKs17svY3gGUYK9xG6zF4BaiqtTr+45HDK0nZYeaN3z51kQnp8gOBIs4?=
 =?us-ascii?Q?Dg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 70048104-2c19-4550-b4e8-08ddc52b7fa7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 12:14:37.3633 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RTNuQLhvjspC9ZpdPv7aNlzDELWo2rJLjyv1nv7BvyEoOYlz6/YxH+5whDE+V9YI7cML7Q9i67MKK1PdNo9R3PWdU6Q6kIED6MGoYBB5MRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4757
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

On Thu, Jul 17, 2025 at 01:46:03PM +0200, David Marchand wrote:
> --use-device was replaced with -a / --vdev options in v1.6
> with commit cac6d08c8bde ("devargs: replace --use-device option by
> --pci-whitelist and --vdev").
> 
> It was reintroduced in the doc in v1.8 when the rst documentation
> was imported in .rst format.
> 

Those are some really, really old release versions! This issue has been
around a very long time, it seems!

> Fixes: 1ab07743b21b ("doc: getting started guide for linux")
> Fixes: dacdbfa45752 ("doc: getting started guide for freebsd")
> Cc: stable@dpdk.org
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
