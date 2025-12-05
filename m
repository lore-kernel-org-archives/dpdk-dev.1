Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAFAD2F7EE
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 12:44:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C5774027D;
	Fri,  5 Dec 2025 13:44:16 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id A210540156
 for <dev@dpdk.org>; Fri,  5 Dec 2025 13:44:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764938655; x=1796474655;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=NeV0VqQ8YJSohMarD5NWOqh49ZW/QFBmgV5v9yzAkR0=;
 b=joQ/Q5g+qarLa9VA1LHvnqSrNOUTB+E6Hc8tjNWxd1eGSj0UMZ3fenN7
 dCq7IoCNVdfz8EZPGzHZdmEVECA4Cfffp15kydzIFykrWPqJ29bLPlIYN
 +JWUcQLDs5hNNb8O0KoT9CrbdERA36WcTW2IawpU4acwPaQaAHtpMBaW8
 ZOPd+ylrbhIHpXGdXqh1XbXxR0DvWr81zAUCuBsqjTPr1V6SQvUhdiaYj
 mU8U9J4eLd88vq7mlqsu+asK4fKqhlAAP9+Xu232cFcF3p3xickGOmUnW
 yrBemCEWe0L545fgeRvD1q+PjOHYK0gEdBPc9iLq+xjwo+PQOHiu+5CRr Q==;
X-CSE-ConnectionGUID: suW6CbxKQhCHgkvdeRjDpA==
X-CSE-MsgGUID: rH0Tia+7Sm6uhpiM5rzHpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="67008583"
X-IronPort-AV: E=Sophos;i="6.20,252,1758610800"; d="scan'208";a="67008583"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2025 04:44:13 -0800
X-CSE-ConnectionGUID: 2BNdNi5mTvSyfxHhb8sa3g==
X-CSE-MsgGUID: ITLFH93PQDCHpviqCkr9VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,252,1758610800"; d="scan'208";a="195108389"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2025 04:44:13 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 04:44:12 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 5 Dec 2025 04:44:12 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.23) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 04:44:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hokQjesZx3n8faZ/xWfeQHENudE2LE9jj+pdcHjt3iKwQAVHAH64OWPU6Rx/yUSa4yuMRWzMKzMeeuE8UycYRO74KZUJswWo6TZImvMqKfqcghyFE4qaiRNqvEDtw45SactnOarZEAA21bS0/lw2wXd5LkUdmYs0tu2+AAfrHN276bB37zLWbNvyMyXRr6qcV8fmfFNWPyFmdgb3xP/tgYQgbXkOMf5eGpRObNfRLjXNcY5XdPG+TJmdh9L93neRuW9J3Oi76AEcy2qQT7Ot+MbAJuhSMUiwrjyOPELx9gTXjePiLUQhT+UMlKlrq3CVrLkPZHSGqprG/2FS3V/2Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRPbkqM7P9LfsXvx8N67xavaSPfnPHMZfxsuvsRL+Ss=;
 b=x7nC4X+y1NB58TiyQpk6a5DiWNmpQkrpkGMs6qSdj8KQv+SXhNtWWmcj/tR7Z4+7n8xo2jYwvmCJsh/nFiR09/Y6QNqN4Z3wJNlIzphMGosfeZWUGXOEr2nFzbxUQSZa1ysFWATA13uBzWj2XR1d9j3Yr7EsLX2AQId9eC4Osw1ecpZrWe4QhGyxvOF1RtSLRLj4X5TiHPdymxZC0c8FxoHoMaM7lEZDASgBOFcxA6S2d0Ias7x4utz4Wc0pNdVN14fUkG/QDvxnH6Fq94tjVUkLuL5sDzYo4kBuf0+ovRN2t2J+Ufv+2BZvZOuF07GbsZXjmGwyOz4uGfNZsxaruQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS4PPF085B02B26.namprd11.prod.outlook.com (2603:10b6:f:fc02::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Fri, 5 Dec
 2025 12:44:04 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 12:44:04 +0000
Date: Fri, 5 Dec 2025 12:43:59 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 08/10] app/test: add some unattached tests to
 fast-test suite
Message-ID: <aTLTj4uppv01kT7T@bricha3-mobl1.ger.corp.intel.com>
References: <20251202154948.1757169-1-bruce.richardson@intel.com>
 <20251204182047.3154429-1-bruce.richardson@intel.com>
 <20251204182047.3154429-9-bruce.richardson@intel.com>
 <CAJFAV8yatWvS8OhOJM1yXw1T-RBerjE2psNH0um5KG88T6jnYg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJFAV8yatWvS8OhOJM1yXw1T-RBerjE2psNH0um5KG88T6jnYg@mail.gmail.com>
X-ClientProxiedBy: DUZPR01CA0228.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::23) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS4PPF085B02B26:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e61fa67-1822-4c82-a32e-08de33fbf92e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9cW44d16DnVFrlSOUKWZ/IBaGLtC4q/fiZlL2sF2g8Bzj1ge0GM2W0NPs1fK?=
 =?us-ascii?Q?XJZNI32TXGJe/5pF7J4gOHSbD/DqZGqRzwMm2l3Oaf0mXCxdSdMEPfyUob5I?=
 =?us-ascii?Q?8s/ioc8RZBExU3PlKyizDODDXA/sPP+N6FP7uAXSjG+94pnBAtGiAAhdSOFM?=
 =?us-ascii?Q?z2mpnVNrz/S/0g7rVWTG3aQ6ZyYpmBiDMvgHuwYtpataSZdszcKfXuUD3Ic4?=
 =?us-ascii?Q?if66oZxMhnjQSKyFkaxMCgDIBW7fxHSHOCJEkkeR/AJILbrO96PHXmBYHRXK?=
 =?us-ascii?Q?id8AflAOZCu84OQyhIZSR2dobqnx3zOi3d8d32oVgAzgLsVfvMMBQqQafYzR?=
 =?us-ascii?Q?J1GXLY6y09i/2ec4GKm3AF+NOoPsHxng8NSnWni38z4sYg10tUN2ZhBGG42+?=
 =?us-ascii?Q?gd8LzY7g4ICCDYoL6m/DhA0yY1JI5jUVM8ZgKiNnlXq8QBBG5rJJIjjQwJ1A?=
 =?us-ascii?Q?UlruZpQadgnqRnTE/js6zvlzUY0Zkikrh2iCfC6J/maY/NnsXmY23JzcABc4?=
 =?us-ascii?Q?MyOaJq5ekODNevZMXYpyVDxsTze2CDz499VtWzGLJFVlhnveCR/V4IWnJUPM?=
 =?us-ascii?Q?cXDJTN8XViagR0wOX8EdtsIQqgHwj4hWkgRRodNvIgs+aOFJeSo2BxpFarx7?=
 =?us-ascii?Q?6Iv4gKx2PbVkOV9KEtqv+cGOMMnFfd6pQpsgeTwRogSZP+odCe9H4QU48K5j?=
 =?us-ascii?Q?mChRvF0mWdu8r7ymMW25Z+w3/a2JkS4I8a9ZgyqlD3N2q3AemtfXLJm1J0fb?=
 =?us-ascii?Q?334U6ZHv64e0ZFe+94tVpS46zabNyn78POLYk+6Z+2irl5WRBC5w6mc+xrNR?=
 =?us-ascii?Q?vNxyfpX0ZMQyepUincsw6kMWri0caRXT8lS+LgMYNKldtYTSaZpNpDmzbs/p?=
 =?us-ascii?Q?TYjPa8pubAtaGb5+44ISURDTwcBAuQg2SIziatj2PKbC1jYbBOUoX9Y8SMfV?=
 =?us-ascii?Q?GbhhaGqByJlQ+SOM7WDwn2fDuHgiV2pHgn9SIcIBg9eiVLv0ZT5bRpnyqeWl?=
 =?us-ascii?Q?YXITGO1wnZJp+HYMPDk2W9TQQ031pUt+Gg5McimSWdGvKvT37MAyCd1sGps/?=
 =?us-ascii?Q?BmaWpRRCOL4Hb4tc9AQn8KRrOX4KVYOOiVr1J8ZsqSLQwYJwS9s1daL3YRNp?=
 =?us-ascii?Q?vz7vAzqJTTWxaH42pQHU19vgJTpd17ffVMslnDuapk3cqJnzbqfzNsU002B6?=
 =?us-ascii?Q?mV/8n+P7T9SG2YwoQnY9hBUY8SPQ0CWmtekpwdowGcmXLsgKT/kvPmShXHjd?=
 =?us-ascii?Q?tbGSApxv6vR9hf0F+zmY7QkZag6kK7/iuR4GZgCxemIzskZwwQXYVA3ay70m?=
 =?us-ascii?Q?bnhD1o6U97tmYA9eQBvYCQ4t5JGlhn1tdq+Ijot0L+EIaQV+bSXVE8jkYZaq?=
 =?us-ascii?Q?RIRqEU9IQfAZToZ29/dzadWN/Ig5rPZOkRKwb3IKu/NiW2WJMuLupBa8opCg?=
 =?us-ascii?Q?7iEzyf9TmuvZNO3esE7QMrBWfxNeCV+H?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4IfRTEiYZHowrc+QDPDNLtmvGoJLFrhqkvutX4dGYop0pTrilloF048oNOTY?=
 =?us-ascii?Q?V52aHzrVfBJOSUz61T2/0B5/50vKlXemQNHXePx/ZEoY1JJSGzoOH1mhh/3s?=
 =?us-ascii?Q?9dq8lgRRwbvElAQbsACvC2JZZQ4PNIDsZCYc/eNbFTQOSTPhqiLfdyHJQ2yc?=
 =?us-ascii?Q?AE8FMN4m6CMFcuzJWFCxuaRMqCqaMkxW6NvSN9IB3iNSjBNATeEK87gTI8+m?=
 =?us-ascii?Q?YadjFSA6mHWaQnGew+p92lRMEFMOaWjoRByiB4eb511I2jvMX7LqwRo5Xs+R?=
 =?us-ascii?Q?y7EVgx7Bua31X6AymcDkfeNXIzxWx+DgM88tqvgryecU/bPLbq05EUy2fhZ1?=
 =?us-ascii?Q?zvL+TEGPGllzN7PgdVUo+O7tWPvIO6uBHQ+HPzRw5uWPsd8Z7LB7Oxd9qnfY?=
 =?us-ascii?Q?m2KlnrvPwuGMeLq9RfNoYklJy+e9vZHH1wyUhMa6l2gK0Amze0TqEvAL4vEF?=
 =?us-ascii?Q?ICGsr5/aUgtcpSBVUsDMZ4DZ+VI211ALLr5/xYvqYVBFRZgg4lAK3cXDG4Bp?=
 =?us-ascii?Q?1d3jnVr60kdi54ExaURlyWcQe8Mt0M8swj5Qe2EjZCkEeJa3nwe9h+FuVzl5?=
 =?us-ascii?Q?oWNGv75REBkHUxJf7KBWBclb4TfXyNJm2FeaTP1TqNh8bQnR2SebYpRkY07H?=
 =?us-ascii?Q?d6A61sLSZRJpQ1ebmbveOCHp36XHhfAUQupln4Xv4YTEVm8uGYkwf88EQxpp?=
 =?us-ascii?Q?UK/w71RUfh91+gBdyFs7iDTxikzW1YRB/+j6FO4j30ohJnUTRgRJck5QfvUG?=
 =?us-ascii?Q?rE4XV/XDft59PSahLvf8nhiNjPL2LhXTGtWTqGpkj6a8saUU+x71yJEplBUr?=
 =?us-ascii?Q?VqdiXjIFq5ksGQRVClFMzpwair63DXWeP+0DHHO6CnTN/yro2oMRfjYnYsXm?=
 =?us-ascii?Q?UDCdWSvHB+QPyjaYmpdNHFRJE8R6ZU2ylnnmsX1/M0+dSQXPquY7YFCmc5re?=
 =?us-ascii?Q?sQm2Siw7Dk2Pfqdc9wZZ/jS3Q5vJP/RMiXmefoZliChmfbjmZUiflpGnm7Jr?=
 =?us-ascii?Q?rSzAbRukTyRCq9aFW0mh370xnJZjUlxH2kTmZg3XvFNCsAMMftaGsWJcVA5z?=
 =?us-ascii?Q?xkdezVU2bMQ4IY8OzQjOb6GEKyOKzkh6NlDStJ+SKuLWg0TXylRl6U8rfhZR?=
 =?us-ascii?Q?8sdYm8oj21/sdN3Wa7xyizxlUqlA0nAOM5Vedz66ATkZ7tHQph+qxzgvoW8e?=
 =?us-ascii?Q?RNUU9qO/+UYH1KUq6vlIXNFKIq224uG0agz3uccSTN6d38DttwKkPIiABvli?=
 =?us-ascii?Q?+huEct1LCGP0BsczNvzuULBjyq9LOFXviqTpahqWG2GYsvJn/LB+U/894Kx1?=
 =?us-ascii?Q?GRWL2hy+AsjiyLBhUpRp7hzKMPwcjhHAPs3xnJfWzTkuhnd5I9Q3XtM/MQKG?=
 =?us-ascii?Q?Zfs6n3M8srCt77i7VoC2HNIg6zzTaJ1Hq/W4BaHNrGw1JzkJhNnwwAuFzvLP?=
 =?us-ascii?Q?xiWNC0dkN/3PSonAfJOfMkMxzTxHW8pk+iZ9B6ErEHlNCyVn96RLdHgtx6HB?=
 =?us-ascii?Q?xiu0dFd70spfwS0HIeOIAR2xLnO3+1fLB+WPfFScBYvUl17VagxVU7uqfKH1?=
 =?us-ascii?Q?/D6XOr9umSh1HtxL372hCBrqIXEjOypFSbe4dGsFax+7jfTAKoWmf4px0/Zu?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e61fa67-1822-4c82-a32e-08de33fbf92e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 12:44:04.5369 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kucSIAE8hCMkEK2g2G6OEzh1jFgUAtrxlaxCGgvrKtY9DWPqfsq0EY/CmWSjzfvDewBe7/rlRonVDPLYIhZv29cgJYMITO9YeN8G0pZAreM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF085B02B26
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

On Fri, Dec 05, 2025 at 01:37:06PM +0100, David Marchand wrote:
> On Thu, 4 Dec 2025 at 19:22, Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> > diff --git a/app/test/test_red.c b/app/test/test_red.c
> > index 7f38ed1469..4b17173999 100644
> > --- a/app/test/test_red.c
> > +++ b/app/test/test_red.c
> > @@ -1872,6 +1872,6 @@ test_red_all(void)
> >
> >  #endif /* !RTE_EXEC_ENV_WINDOWS */
> >
> > -REGISTER_TEST_COMMAND(red_autotest, test_red);
> > +REGISTER_FAST_TEST(red_autotest, NOHUGE_OK, ASAN_OK, test_red);
> >  REGISTER_PERF_TEST(red_perf, test_red_perf);
> >  REGISTER_PERF_TEST(red_all, test_red_all);
> 
> The commit 50823f30f0c8 ("test: build using per-file dependencies")
> removed some context on why some tests were not part of a testsuite.
> -# Tests known to have issues or which don't belong in other tests lists.
> -extra_test_names = [
> -        'alarm_autotest', # ee00af60170b ("test: remove strict timing
> requirements some tests")
> -        'red_autotest', # https://bugs.dpdk.org/show_bug.cgi?id=826
> -]
> 
> I would prefer we don't put an unreliable test in fast-tests.
> 
Agreed, but for many cases for developers running these on their systems,
it's probably worth having them in. What would you think about having
checks in the tests themselves to detect if they are running in github CI
and to skip themselves in that case?
