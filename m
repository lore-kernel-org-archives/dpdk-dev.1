Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42530C982D1
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 13:02:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D491742E5D;
	Thu, 17 Sep 2026 15:02:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 84AA3400D5
 for <dev@dpdk.org>; Thu, 17 Sep 2026 15:01:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789650120; x=1821186120;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=D5qtcrGINs5fMJR6XrxLlYnllsGHkLS6RVXNydf8jBc=;
 b=gqqeraw/Y8VZ4AiFEMtQyXlEwErU7WkjIi4tIxY2yzFS2Mt5J2pf26EE
 /3GIeRI3vbdDlBU8N334Ok2r0gITo1gfZIVLCHf7W7bsWKiGywt0tjsB1
 FYoW87k83UGNT7KQVRGRd0HwoLIh4ltoJjZFpUaX1LdQwEWxpvZ1S5jMp
 p/w2Q+79KTUd922iZZczqu68QNvLiZdjuVGHjMfFZVTM1XiDXahL8HWR/
 FYLc9geQ8uFkWFvMnd20J60wBdQDq0Ho5cA72IFk7XeZV43wpgCwrMeJR
 U+LuHyNi6BksAFoY3UrRr/P5I2l3iXig6xl9jU+dAgS60/fR7YSsMZ6jU Q==;
X-CSE-ConnectionGUID: zG0lqdAGSAavDNVG5uU7jw==
X-CSE-MsgGUID: rA60kMnmRcqeIKm7f5X4XQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89202095"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89202095"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 06:01:49 -0700
X-CSE-ConnectionGUID: nEr4xKylSbi8zaHyf0AYwQ==
X-CSE-MsgGUID: 1ctkuIjVS6m+z4szhJuJ3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="2173886"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 06:01:49 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 06:01:48 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 06:01:48 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.2) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 06:01:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yas4stAA4KaFxixpKurwj5aacVVNecmqH3aUiEZLxJKiFF5z3JG48+TbZohmefX17VNYuEwTNH/8wYkDviiGyH3brcU+RbmruDWpwAu/ZkdnspGRB5GG6KHuPvBBn5B3/u+oPJ+TaR+ax12TrjExGQY95WfToaTFwzJzKlYWeNWTIQm1e24TPXSFFuJ0bZ492xs81t0JY0sXnN329E9JLbdLYWjz/DQg2dXpGkuh6qD6x7FVE4sSBmtY7VfObLD55JX3zMjm3EKO5sanKhupk8BH+qAYn4SO8UVtrFW8b+4EjniUe2jfm8obSCn8HpeLewvbVZoHCmuvSzFCRaPZxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWnx+5n4LXI4/W4dKW6URzZXX5/oS+67MPMu00ue6O0=;
 b=raZVFXRScwG1hHESC7UMXIRtZ3qzFcQbv/kdLa7zggy8FTkdBFTUp7YzrFatjRQ4nIpYD6Mkoj858m9zNmTrX8bvjFGtKb4eEWQY0Qw4LjWD4RVRifJeuN+TrrF7KBHcxsyuWPjMXN5Xm1Mlfzy239iYk0fLHApJW9qcql46k7rJkW4iPEbscaEv0o9aIGW6ln/jzuZV/5SnYyPbOX+An/SeBFjCaIcncxtkSYJCga1xdBDH4jeMT1GlqA5wpgifCI7ezbElizMaMup8F7NwFJpZ+go/47nQ2UJ4IZkkNXfs8Sz4FuWlgMJKOmmbEVsQxMfDs7yLEov6n2cimI54lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by CH8PR11MB280672.namprd11.prod.outlook.com (2603:10b6:610:32d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 13:01:45 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 13:01:45 +0000
Date: Thu, 17 Sep 2026 14:01:40 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: David Marchand <david.marchand@redhat.com>, Robin Jarry
 <rjarry@redhat.com>, <dev@dpdk.org>
Subject: Re: EAL feature request
Message-ID: <aqvktFpwJsLqeY2L@bricha3-mobl1.ger.corp.intel.com>
References: <98CBD80474FA8B44BF855DF32C47DC35F65A50@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65A50@smartserver.smartshare.dk>
X-ClientProxiedBy: DU2PR04CA0298.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::33) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|CH8PR11MB280672:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a39f36f-052e-4de1-f833-08df14bbd36f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|3023799007|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: BspOhOTsr9JgVSOaMzmjjjkrU4q1HIBw/6PxEV8e9N3OQh9i80fcCGVwjzxOZLmZwhzTGMgvQvqkdYkICuxAPIPcMkyjHl0UXJNll9GQWV7dAi0aUgI3v6kz2UtCqI3UuIYgyRPYO2nWFZXWbkh6iPNjZzTrGPfTdu/Ok+p7DzSTx1tkV4m1K1gkOv0KYxfynYDE+lznYjR21YAJLCDfDlW/ckQMf53HrNQFLigQPDddBZV3s7FxT6aLthzb1jWekREA/0Ur+jIt4HoudV996SKZAtTPuflbeISgChozIq6Bwmbi5cVr6eBoB6M/vsoltdvioBu2PzkOH/8EdejE3lrq2kFRaqZyRxCdsrRtq1vRy4Ne5gZjRZJ0yHC5c80W+30RpQTHlKCH/MK0OZIqCLF47J2gaLchNJ26o94/7+xyTH+GpwYGkJTnK2nVGIrFpWtOHphxCum4XmnHlfN7TX8f9Gi5jUS7J8/yWxJMr+DD1bVSpFrdzhesjlJpCsTDlnaynS833wUkTWhzLQxMTqYqEJ2KOrR1OeIhufi8pjnXsk2OHAZbxvrJe25qIyi7es7RV1Jse1MXInHFff1bfYIWfiq4jxGYn34/7S+jz6Y/xSZGPzewCwC2oyK++LJyHPsdOqfdzgEkokE4pTf1vdBCUNYweInhKLBDORMS3gc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(3023799007)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?bFLmVTM5zgKOTsSkmHqn+Hjpb0hn3oX1UFI9JQj2DRG+cS+NagsFuPdoXS?=
 =?iso-8859-1?Q?d+W8w177ZsO65JIzO0UESflEOHhiO2D9HHMwze9eHwExvKpMAmJzYRjbvM?=
 =?iso-8859-1?Q?NJ76hRUCYodWn+Oxw6JNt4w7KZxqr5/AmbMC26iHSQOvRgbrt7iRH2gVIO?=
 =?iso-8859-1?Q?4Oocl6wf3V0zZyOsVgCu0NJLnE98Yyb2F3eNQbwLf6/0v7cNNl142usEc0?=
 =?iso-8859-1?Q?k6vPHo8FjjCqb5Dbv3sxconlTUTImVH+qZK/Lxqo2q5lc4LmtJefgRWVr4?=
 =?iso-8859-1?Q?fkJbQPcSD8Hd1rFk0OmkiM2iMIQWEjN3zzFaQf2w5TZaXc3+RQL5DoOYNO?=
 =?iso-8859-1?Q?3hBXC6NzuRPEYiWAbqE6AZAZJB/GTgUj5pxpSHp3qmh8bU3XDyiNasYJ66?=
 =?iso-8859-1?Q?iMfoY0ghcI1eXL8NNsPEbfIC1hEq5146uGrfp+xXHD+Faof8aHcQPA5Juy?=
 =?iso-8859-1?Q?pwnvpwg8n+npmfxO+BtFIsiGDNa/B1o/K7K1mcUw09ig6l7nMseGCfC42D?=
 =?iso-8859-1?Q?n5ostG9AJ4S08Y716nAXui3hOi4xPvlDwYaNOynyLA40zet5QGj6FDnTVW?=
 =?iso-8859-1?Q?Faf5eZ51RH+pX1Kygc/+/syvQwuMuGwZQF5ccLHQ4ysBzVz+mzUAfSkkJ3?=
 =?iso-8859-1?Q?LDswe60qEda+7BxgSuLcw8ETVIgcKWhnRP0LTjg64eop+2yZME2H42jxz0?=
 =?iso-8859-1?Q?TEGwTtiv0TSQzV7msHuXTvelfxQe1M1boehuFfuQDpWgMZidVPeN6y0MP0?=
 =?iso-8859-1?Q?d11yZJE62UpBWIAPbaP+sV7hxEe0L+dgGEezNh5W+fenaSDVu8HyvJP8oR?=
 =?iso-8859-1?Q?O4fTwhXSt95PVNFUZvEpadAKloHiwV6MNzfOAKwNzDW8t/pAqlR/S6FcHM?=
 =?iso-8859-1?Q?UVWeROg7AMwGyNFhQIM4i/cqSTNfXPwCyKvr93TUuuyK770gxL0vgIJt/p?=
 =?iso-8859-1?Q?U3IyX10JOyFoBYEOL+LpS7bPXt0YyHutnPWo4x//bKMKcI++XEV7uHRv3K?=
 =?iso-8859-1?Q?6NL43Wtx9PctNGOSgWlLdrBo6C+5dAHZpCtHsDeJfuxLOXVWQJE2tVaeJ8?=
 =?iso-8859-1?Q?6YKMHWLqPRSV4BLLRoL0ULdX2qNrZKAc2h+0UUQvxDVXtN/GFip/+NwTbY?=
 =?iso-8859-1?Q?DHeB5mtZv+SQUca69MQpm3QKNR6SGPBozTBstMULbzb3iGlvtCKnx5roUq?=
 =?iso-8859-1?Q?DUlksDOt7sRjGXf/V7ueqQDV4hlxdgq/J1gHewAVzzic0DscntvTrzNcfm?=
 =?iso-8859-1?Q?mtnxmA+Kr+Rw0qQ6IszxgBcFSLX/vybAevYMVL02YZwDR6C+w0jQXFyrwU?=
 =?iso-8859-1?Q?xshDxm0RNMiPcDzua79oJFqRzVnPMQcwEKcRzUyNvtZ/PcOXAggTY+GKop?=
 =?iso-8859-1?Q?OKO/4TPTL8Cr57hOO0fkC4jmJeXaaSCmIrEOkd6hzA0aSitOpG2UpQSbcb?=
 =?iso-8859-1?Q?NakmsMJNrBI+bDnIk4xjUhFLJXTJgcmxsvGXl+n5hnJcU9VwkI4hFsMAmR?=
 =?iso-8859-1?Q?walT5T1CIHCry+aWb0TdK5vBIVx+uPQfk5IlY8I4BFHUbFoJcwd6mNQRig?=
 =?iso-8859-1?Q?26Y9qnXf0YgtpcbEqeCKeu9CDRty9XWQO5XwVuVx0RjZQwpBgZ03dz4Avy?=
 =?iso-8859-1?Q?xfIP/wsPlBEr2ay+N57CklPIUB7/n+pC5NM8DieguHjpMqnoqvUajWtL4e?=
 =?iso-8859-1?Q?8iPX5Fc2UeilW/Z0yUXfJ1m65qs1FuiEPP25XrwPVRgJegar6ktclIYTQy?=
 =?iso-8859-1?Q?iStEcUpdDMP0YIN25YzH+REa/XrGAFgeibZQoTZ4zHnU82M09ibyjYzE25?=
 =?iso-8859-1?Q?/tBfQ/guHVpPFLKFw6M8koyPgM8/ZXQ=3D?=
X-Exchange-RoutingPolicyChecked: b6T811GwmUWQim4QAU4isn/mjL0/w2aISHjsGfLcsm1DG95SxzUjckUtFt7MqByUR73OWbZFv7JP69/A/R+5sSzZ85IbyPEuUZYxiwz8PoUysayWC4r87r7I2nQqljY8sV2h4RvG3Kfz0GPj6t7AeMNgrxCWGsLENsEAFlgBLB084Vi8Cz24rDhinlcfHyhAU6PLPGmL5z5dCZMx/NUSg/XYKGCivtcxJ+ElVcwl6GIzkQViOI5Z5MnfUmklZRK87PRXorldCBVarEoOZgnjE4NmfItgQjUb4T/nDoCSOGzIQ/khSYYsi0aRvinAi3FCi91yv0Ggja+OyKeJUtuVsw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a39f36f-052e-4de1-f833-08df14bbd36f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 13:01:45.0747 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F8YRU5sdIRtd/7xEO/Mr939J9mnPnNZnAMPbQxrNBWLYtqH7xzfTEBWReazFYgC8a8HLkgDHKd1BmdaO1b+UrotFj+OipcyI0s2br8IC60o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR11MB280672
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

On Thu, Sep 17, 2026 at 02:48:24PM +0200, Morten Brørup wrote:
> Bruce, David,
> 
> I don't know if this would be useful or not, but here goes...
> 
> Situation today:
> 
> DPDK has 3 types of threads with a valid lcore_id:
> 1. EAL threads, 
> 2. Service threads,
> 3. Non-EAL threads.
> 
> EAL threads are controlled by DPDK, and associated with physical cores at startup using the --lcores=<lcore_id>@<cpu_ids> parameter, and their OS cpuset/affinity etc. is managed by DPDK.
> 
> Service threads are also managed by DPDK.
> 
> Non-EAL threads are application created threads, which are simply assigned a valid lcore_id, but their OS cpuset/affinity etc. remains managed by the application.
> 
> Furthermore, macros such as RTE_LCORE_FOREACH_WORKER() only iterate over EAL threads, and rte_lcore_is_enabled() is only true for EAL threads.
> AFAIU, this means that DPDK only considers EAL threads as fastpath ("WORKER") threads.
> (The main thread is also an EAL thread, although it is usually not a fastpath thread. But its OS cpuset/affinity etc. is managed by DPDK, which is good.)
> 
> 
> Feature request:
> 
> Functions to create and destroy EAL threads at runtime, so applications like Grout could dynamically create/destroy threads that:
> 1. DPDK considers EAL (i.e. WORKER) threads,
> 2. Have their OS cpuset/affinity etc. managed by DPDK.
> 
> Such functions would probably need to take <lcore_id> and <cpu_ids> parameters, for dynamically updating the list of DPDK managed lcores and CPUs at runtime.
> 
> Maybe the ability to dynamically manipulate the <lcore_id>@<cpu_ids> mapping could be a separate set of APIs, so rte_thread_create_eal() would not require those parameters. (Don't know, just brainstorming.)
> 
> 
> Reason for asking:
> 
> Because DPDK doesn't provide this feature (hot-plug/remove of EAL threads), Grout has to take on the task of performing its own thread management (OS cpuset/affinity etc.), register its fastpath threads as Non-EAL threads, and cannot use RTE_LCORE_FOREACH_WORKER()/rte_lcore_is_enabled() for them, but considers Non-EAL as fastpath threads.
> 
> 
> Generally it would be logical for an application to register its control plane threads as Non-EAL threads to get the benefits that come with a valid lcore_id. But how then can DPDK discriminate between control plane and fastpath threads? Only the application knows.
> 
> It would be nice if DPDK's perception of which threads are fastpath or control plane was aligned with the application's perception.
> 

I've thought a bit about this in the past, and come to the conclusion that,
as currently designed, DPDK doesn't support spawning thread instances, but
it instead supports the idea of spawning work on already-existing threads.
I believe the original intention was that the maximum number of threads
would always exist when DPDK was running, but that they would be stopped
and started by the app by assigning them work - the threads being asleep in
the kernel in the meantime.

While it would be possible to make that model work for most use cases, I do
agree that your suggestion is a reasonable one, and probably is easier for
apps to work with.

/Bruce
