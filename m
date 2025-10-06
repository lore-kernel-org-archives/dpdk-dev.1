Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1CDCAC5B8
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Oct 2025 08:42:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A07B9402B6;
	Mon,  6 Oct 2025 10:42:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 21970402B1
 for <dev@dpdk.org>; Mon,  6 Oct 2025 10:42:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759740121; x=1791276121;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=KR1LzGDCHSHe6310NyTTM0M3w0jk/OqtTsUySoCcNFw=;
 b=Nx+2cTPM1WM1K7wMyYqLhy542RQG+5NgYGC/zNFnf6yvBbmt6MXQBvE3
 /6CjqZkgu4oO/XeGe99+0we7uFnPOZkQ3UwG75MbNzRGnOyOwPh0GLcXT
 uqTaNdBrfzDWn5uLmGS+hzJniVk4FQxaJ2oPJg0Ko64Ifaa6OJL83CL9U
 wxZX09epFAZTfGpTe4H1LbEha9KiK2aI1k8B/rISYkWqBgCL61duUwSh1
 VhatTMM5SvTMj54QR5dLUN9o10LY8e0S/PfESN/Ednn+7Adm1lmyth2aQ
 7zYxyiqsjLfjTqBFxWuPxPZM8gVP/bDZ9GhvWUh7O7xqUORn44Inm3cPP g==;
X-CSE-ConnectionGUID: 3YCkzKgcST2/hhSkd68D9Q==
X-CSE-MsgGUID: +VqKn3gzQRuYw7cxoBsChw==
X-IronPort-AV: E=McAfee;i="6800,10657,11573"; a="61815704"
X-IronPort-AV: E=Sophos;i="6.18,319,1751266800"; d="scan'208";a="61815704"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2025 01:42:00 -0700
X-CSE-ConnectionGUID: X6qahw6NSAGnRPdJaBUGGA==
X-CSE-MsgGUID: 4TuyV7N7Su6h5kKx44lj2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,319,1751266800"; d="scan'208";a="184206446"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2025 01:42:00 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 01:41:59 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 6 Oct 2025 01:41:59 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.12) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 01:41:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MU8EXj4JHzeLTDBf/Thn8ylWy72LNCL/bkD2XRbgEht8OhID7os7HrJ/Jk9uMb+ehO/CS5eeSOrgp1lqUSLL4nT3hYWM5Khjd2VfbJFgYwN3hi+aOPe5+972ZDscPEn2yHe5H6p/PA7/uQJ8r5lO6SnWXlQdq0Ap99EgNRNhewAJ0mzcmWD0wzav5h2U+qkxdj/AdG3+lzUdKJljrcTrV0JD51oGVIbwWM5uULS5YzRVxwTIUbsqamjT1A9mvRbtBAsRlI+tFtwLZ59NJhMwnktfcYsxZT7Nq1ndoiIJvD7zPgY9TRlGc8zlB/JOqbdjA7YL8wWYeLBVYmbz8DxtRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b7Lh1Dp7BJYIqqIHQdu+Qg9kC/9dpi2qP38umg20Ipk=;
 b=HXACqWzB+eQMp21pGDVz8MUlMtj07L6bm0Jtspr+i4N86ff50+qux3kpRXXT+RC/NZb8KLXq3LOijEl/75r6TNKsVYu0XAcY3c5+IYIbuVhTUfoyp8kEYX7MnkttFiHPAh9iEcpEYP6myx1NdCwg8HNZNMOLYAyVkOk0oUys7c8UFkY5LxTT0lhvjm0EdsFJQKnXxIjy8pqW1zruwJHHh3GwEtNMJK0VoMExNQEKEOZQwjyi5hgeagZExEKJsr1RGIRRKgMr29JN0g2Zc0X3ynTtiLzET4joko8aCf4egBwrUML3avmCRhJB0sBuObL4a+pEfrztLuXdxGhUbgcb+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 08:41:51 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 08:41:50 +0000
Date: Mon, 6 Oct 2025 09:41:45 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, <david.marchand@redhat.com>
Subject: Re: [PATCH v8 00/18] Simplify running with high-numbered CPUs
Message-ID: <aOOAyQ2s9whgovnU@bricha3-mobl1.ger.corp.intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20251002174315.962992-1-bruce.richardson@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65499@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65499@smartserver.smartshare.dk>
X-ClientProxiedBy: DU7P190CA0005.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::22) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH8PR11MB8107:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ee53d1c-ae2c-439c-9619-08de04b431ae
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?cR6JXmkOcUsVB+sqplE0zl9PP7+9LpInT3ba0zxnwBrnaOQ2tbximVyvRE?=
 =?iso-8859-1?Q?eAdTkLaYTRZSxSTj1KFtcbH/cojCw/QILGZ9KW8T5ki98K3TKB7PsIlDZy?=
 =?iso-8859-1?Q?IvJjGTTKfKf9hzI1MD+xEUTyUALKM2XpNO/kUGw1RHANWtpJ0EolbOrPgQ?=
 =?iso-8859-1?Q?rkKQGrZxg94RJzrf42tstOoDT5dvh492MJXIG22t+a1zikm0vOcSQ4/kS4?=
 =?iso-8859-1?Q?rgHsdRYhk4yJhG3Lq2U3xvrRSai3YTeJVSO9ek4e0eZqE2CzVDl/aekGJ7?=
 =?iso-8859-1?Q?q3ZV+5lzHR8167U3vx1frRCQj3hdV+Pf3Pwd0yrKABwcs+APKJ1b0L9S4W?=
 =?iso-8859-1?Q?VY5wKeBRZoXBG7MOzYtsh1FTWvW77sVYnBhavoTZR+hBQ8D+SRYMv9uCLl?=
 =?iso-8859-1?Q?7pcTFF8e+PY+2iDPj5h2V3tdJoBK41wm98MT8wDKwkSFZ2lvZ9aYRULMKy?=
 =?iso-8859-1?Q?Eo0simfledl4ctGCbIzmlW4DY+kGgcqms7CvPtHj5ppVu2bYtAyUZz1T2T?=
 =?iso-8859-1?Q?pWT+yR5mqUdeSt4urNYmno5J0WB0eJHXMhNeXhA7cg22lbAZKbePEKl0x0?=
 =?iso-8859-1?Q?+bGfPCOkmM96eFaZvyCX69ROz45foNK8QQZl43IqKzBtzWFRqE4yCg70OA?=
 =?iso-8859-1?Q?s33lY7bGK0VKrkX169jqv4KB5wDAzcs9SaDj8LATNogH91IqOTfmQKDHbL?=
 =?iso-8859-1?Q?yk3t6XnwRtK/1eX1enO1eSngJlPLEetyyEPOl8L1Eu/wEmKyWm2SQZY1pU?=
 =?iso-8859-1?Q?NGGafevhas4McDXRUHaxCvb7nyItXfe/WNrFIA4LrY2EobfeTdx+355pdT?=
 =?iso-8859-1?Q?JrHpMj82ogI7sv5xOzhRQm2rpqKqpt0MM8+VPUzmsOJqGhV9wU6UXRsRy4?=
 =?iso-8859-1?Q?DpWr2dRxbCjEqz6eJE44kuCKUOZH4AN0h7s/ztcuCNnE0FttC37T/7GrJu?=
 =?iso-8859-1?Q?PX3/nh4WwvteNsmC712joW1HE/0e4AGX3JqzGzNu1qlBgDhlJHWaAf62lv?=
 =?iso-8859-1?Q?keoM6qagbQHiHeX0b6jX8VWPBfX1MQ42+qqnDoc4EVmBAxZuxmHb+rCOPC?=
 =?iso-8859-1?Q?HpSQXewW1xCU2F5wDAZCxtEX+TKoQSvSLgyqOTqfG8AnX4w06gET8c/ndL?=
 =?iso-8859-1?Q?ehD8r++uxVGoG6du9nGLdzCfxL7aKQz0NZEW5iBAk9AZ1fr65B6jzYQAIv?=
 =?iso-8859-1?Q?5bFb74aO4wz78M3ZnsseYJNsXki8/xNGIVZoYe7PAgY+L2w+gMv5Gp4Tlz?=
 =?iso-8859-1?Q?hOJ1CUu/sjrcNfom5F4ftd/Agjoa+3FeUOTUkpnz0KIZv0wpiH0JIi/LXY?=
 =?iso-8859-1?Q?tFRrfmtWVRUEwmI5kxt2YNVKeT+2yXroKuLWA/LJ+AQtz6ukF3Nu0sG6AR?=
 =?iso-8859-1?Q?Yi33diT6N1VJ8I9MYaxTHmq4VyiL1VW865o0h8gTXLB7WZSoTwD1RiyrCH?=
 =?iso-8859-1?Q?hDEVS6HvvQCSyQrDdvW/zGxayKyRNFXPgH821Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?tIBKoXB01e1HQqSFuVO0BHhUOOLwiyRG/jPAM+JaiGC2FtWwUoAVEA2SUw?=
 =?iso-8859-1?Q?9Pa3xD4dllVMXgkrAqCz7vx3NxJNGBikmzAT+4oCWKTT/lbLkCypiD5Cs0?=
 =?iso-8859-1?Q?X2uYFK0BaEW0otHsOBy9/EhfQjzH4FrPSsTwNPa2I5B6fupSWfuIRL4as8?=
 =?iso-8859-1?Q?f+BaAruGAFLVPPC7DthzEc9ZU6zVt71U1HUwWsyhl/3GyTXcoAYAaogAJv?=
 =?iso-8859-1?Q?Kg76fjwth3c/nWgkq15UaKWgnZofnafJsNEq8pzo35rym8a1Kbuz4lVw6v?=
 =?iso-8859-1?Q?338O26YIT8HQgdcv7zTzTwLSAn9UjG95nzMeZX4aDatR/7Uhmi3PvXVRAY?=
 =?iso-8859-1?Q?PXbZ8dNCmVPzstc40/99lgqj4Z/0vMa+3YybGLQWgdg4dSwWFY+jHBXa6K?=
 =?iso-8859-1?Q?MpkzI/+UIw4eK4UJh3xqiqFmR9CvitlOM+YnQscKVlqdaLmqCgnzOnrUqe?=
 =?iso-8859-1?Q?f48dvG/K0bwP5fzkRbP+QwXqUR3Kq/tYVlZgXJ+IQcBjwELQQLOkfnx6hi?=
 =?iso-8859-1?Q?oA5YcElWgh6snaiO7BEL1zmzLvSgkz4dAiBga59tA6zZ1pZxF0yy/3EqzY?=
 =?iso-8859-1?Q?CsRfeCvD02CeEKbQi2gcDQGm/NEJgFIZnCITv6V23SelOIWpY7BusoEoU8?=
 =?iso-8859-1?Q?dwxzT0eMQ/ZFaCnySn68jj7VuzqtDV8S1A1z6AdG2qUaQU7GkyyrPQF4uI?=
 =?iso-8859-1?Q?LJ83D8DurkX9TnAPitGv1yzA2OQB66vzD/8pqCnuCExKssjmJvrIKj9fHE?=
 =?iso-8859-1?Q?s51b9hajNQVWMVliOiM6ua0qqkEbcsWNJgeY4S71wv7NXjZDarm26OxvWW?=
 =?iso-8859-1?Q?vkNva1oAX2LvZYCDeLcmE0CQc7OWgJG+kN9qW0sSZ7/3BJLKkHGFLyNYro?=
 =?iso-8859-1?Q?xnQyxBdC76LLzdne+g+ZYdnuv127ZGx3zNsU1hg+RfdWdgkI39d6k0cs+J?=
 =?iso-8859-1?Q?/c4BhCkUSUyNRrOw8zpilFs/sfMlGVGmKXj9mPM40jpgKDBC7NaXsN9Ylu?=
 =?iso-8859-1?Q?J6TPHoTw2hq4Ou8+F3l1an0UGlUo1jD8ty3mxOvVk1rC4WLfH/JuLw8x1d?=
 =?iso-8859-1?Q?MvyAHmJpNVnPFFDllHHSNX7+dGwLbx1h0P2gtDPKZiRtPUxodmoRjp1HkP?=
 =?iso-8859-1?Q?ckB4NtRy+xX0E/4xC5FDGGD4ltvjHkycWJ6vYJiz58Tvtpy2snOpqpnQXm?=
 =?iso-8859-1?Q?zn1WW7MmAVd6gl/kJKhR18iGD6XMFfukPpW3MpjORMo2qmNuLLMjUI6mhx?=
 =?iso-8859-1?Q?F8FA+uoIIJmbnMNnFlS3Y/fCYx/HRPXs2HbDp01bLEukXmNqi9ADLTGJVb?=
 =?iso-8859-1?Q?JBhhJNTEdjRzmhIQTEkoCl3k0cCccJ/+QZWcSbd0qQ7sO6sM23eNSDmbWn?=
 =?iso-8859-1?Q?bGYV9XfHkrLixLYHaAtYIoleq/UVzX/SNXq3UYEpwF0LBm8UGI3mUXRPmZ?=
 =?iso-8859-1?Q?3Zs6oU+kNTL7NfHEXYybtcIHjs7yDEcrpPJKQjXCzRhnR6t4T0XhcMHUBW?=
 =?iso-8859-1?Q?O+z1ukxg7L8ogC2+WhUDwJNpZrV8SpVorckrNiiAhF/5I/cl4Wn5ueqq31?=
 =?iso-8859-1?Q?Gpa7ITlH3LZHhD0bp3e38+msa0xmm5uME0gRvJhfRzLcsX3FRRjTkD0B2G?=
 =?iso-8859-1?Q?Q4/PdB+iO2EPqABoM0oOxWpywevpexOSxWgtf4nkm+cDCZ0PvZ9erWvA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee53d1c-ae2c-439c-9619-08de04b431ae
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 08:41:50.8981 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9zTsAurxFym34E7mgNkC+JzNQgovp869DywDsa25MlHAY2LCaZ5XuuhbTMxm1WfdeoX5xl9f5nQ1Qz5XceSwuDu2epmcr+e51mVMXrgIgIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8107
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

On Mon, Oct 06, 2025 at 09:42:20AM +0200, Morten Brørup wrote:
> Bruce,
> 
> cpu_set_t is a fixed size array, with the size CPU_SETSIZE.
> This is part of libc.
> 
> However, the kernel may be built with support for a different number of CPUs.
> This means that e.g. sched_getaffinity() will fail with EINVAL if cpusetsize is smaller than the number of CPUs the kernel was built for.
> For more information, refer to the description about "Dynamically sized CPU sets" here:
> https://linux.die.net/man/3/cpu_alloc_size
> 
> With this series, consider ensuring that all DPDK functions taking a cpu set parameter also take a cpu set size parameter, to align with kernel APIs.
> E.g.:
> int sched_getaffinity(pid_t pid,
> 	size_t cpusetsize, cpu_set_t *mask), and
> void CPU_ZERO_S(size_t setsize, cpu_set_t *set),
> instead of:
> void CPU_ZERO(cpu_set_t *set).
> 

Ok, that seems a feasible change.

> <feature creep>
> Consider not using fixed size cpu sets (and CPU_SETSIZE) at all, but dynamically allocated cpu sets.
> </feature creep>
>

Will have to see what that involves. If it's fairly easy, I'll give it a
go, but we are rather late in this release cycle, so if it's taking too
long I'll have to give this bit a miss.

/Bruce
