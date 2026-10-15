Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875CDCC6B33
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 09:55:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72AAE400EF;
	Thu, 15 Oct 2026 11:55:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 6B01C40041
 for <dev@dpdk.org>; Thu, 15 Oct 2026 11:55:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792058126; x=1823594126;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=K+h1y6VxTRGVka5Ti+LDmjze1SQueeUPHxPRj4coz78=;
 b=eAJBzKzvYO/+Is+9T/f1pArICGuG1o89pr39lMl+FNWpei2VREYUdeVS
 XiJTYXPQNc3bbJp/MpXaPTTkabQtR519YQLcdk40G4sy0EHnHtPapkl5S
 l8B6yjpCuaGrMtmI0guDGXwKk/EjM55jLXo9MFBf3QxtQX7WJhGMoqXw0
 sUztP+1r62DZBeM6qJ2q+UfmyyU/ZDTnBk+DW6baqvkseDL2iRKa7SRG1
 6XVvK+aBdrU/lx8aszgG1YlL9/MDcdchII6dxQNhNh8+znLt7JMw3Ae2G
 jpzk3OtJySRw/LCmAaQFibIGaoDmo87wQccAmFMOC1LLnP7EOkCTxYa+G w==;
X-CSE-ConnectionGUID: 0gdq3csfTKWj7zbqKalEaA==
X-CSE-MsgGUID: CRj/4aaATia7nWF/ybXJtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="817936"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="817936"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 02:55:25 -0700
X-CSE-ConnectionGUID: BOZwAV5+Q5qT6yBR/r65cQ==
X-CSE-MsgGUID: wnPF2hWWTBuqZoTJBAowfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="2009074"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 02:55:25 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 02:55:24 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 02:55:24 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.25) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 02:55:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iTYq1HzaGk4lZ4Ztv4IHUiEjeYWDwyaIvzKUe0z06jOmlxluz1y74sCF0FOTp9JSWjR9E3vpRGfX0UTMnDN3oeRAf+tTfuzsUM48/4dozKT70CsLWr3bgG+XwV9liyUFufVqbz/L3/dspbskYoXwNROUeHKe6L9cr+RChbHGim7DIECptlwkIlWlZSH1x2VIEwlPN27i/y7GXyiqTv9AN5VBNWNkNan6vY6tIf+WKI3H925053oj5bxEFYWv8rHKl7mnwpZNfHnyTXobXw4fnThiYCNWThotdYrqvtdV5d/LZQbctVzk3LOaSrlgWtbLWbFPTGCJ23OIhbeurYII8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5WDoQ5oIdbk1m8wKyzD6o9WkdkGN6Rkv6ZyU2fdwKtA=;
 b=bwnAaqyfUKxUSz08h2KaA7b5mWsQmrM9yxCwrXN4bHCwYZwieB7q5At46HlHqvZAlJH0wC59kx/c+Xf2hiKgjfQNaKhDyLpao45ZkkbS7sOLPlp4ksx6lTDi2PZejI1TFBW9l4jBp5WCZAb5c4PfvWy18oXJI5pdw8kkYNziREBOfQPXH6Ms4iz5nIcGGJVIydHe1njniI6EwrBIl44+S8z3AxRXx4ZJF7AAqlV63juqHhzRBslzGIYGQ4geBbr+RuHacz8Ws0St2eWSvJ2kvFkrktzX17qgKYtGtfanjQKL+Pfs5QUEA4JJTDpQa4aqXJ8CsPpAYShPfkPC9NgGqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DS0PR11MB7768.namprd11.prod.outlook.com (2603:10b6:8:138::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Thu, 15 Oct
 2026 09:55:16 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 09:55:16 +0000
Date: Thu, 15 Oct 2026 10:55:12 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Robin Jarry <rjarry@redhat.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH dpdk 2/2] lib: remove stack from always enabled libraries
Message-ID: <atCjAPYrWq02nmr3@bricha3-mobl1.ger.corp.intel.com>
References: <20261014192153.2693883-4-rjarry@redhat.com>
 <20261014192153.2693883-6-rjarry@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261014192153.2693883-6-rjarry@redhat.com>
X-ClientProxiedBy: DUZP191CA0047.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::14) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DS0PR11MB7768:EE_
X-MS-Office365-Filtering-Correlation-Id: f39f1e74-6aec-48e7-878a-08df2aa26a43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|18002099003|10067099003|22082099003|4143699003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: cLBYBMH2Fq4oYLju5otGN+njeEnenUHrx9/r5g0O6y4X6KNkxUzPHIKaDUwCxyL1w4ejY5bGEXfyLJG6uOTovbxd5CEaBNJVOsVrdQnNsJToBmoeoIXd/LD4rjdIzg85J2pB9OH4jJMClMHB/oxuuDB2hBVDZ2v+bW+C5RsHcsk/zQuIVFmuQPBOPmsBCsT8ckQim0bF6EEkgz7+BMkg+/rypKe5H9lwQ00qL4QPl7SbfqNYtKyaSijpHMbCA5Ol2O5u7Po5N+TzumYbGcyIv/zYJZKk/dTjPjE7q6oNiVloYg8/bhXDv1Qgh+bZOfFNZkyhlpYAlAgvlXkYWSU/AYjtJQ9agE5/3r/mMomkF2BZVHVr3Se/k0VCmZUGJ0ytynMTOCq7P8MLaDEtOUIPMQzk+36bRQ3jgSwrM72hx9doYn/bbGBD3EC0ysN5cvCEOGnOQsRRUefxCABkU7KzSk3Q5URbya8DGq1sgnvVc4Z+nCtkc4QmIYuRqIfrzd9aGxu7wkAP2DWdaXzgL8o5fpOe9iN/UXwsFGQjewDcOWsOgu2kPJNLJvaWQ04BXZeHhI1WzeBM2BB4EasmaHOsdwPGYMLMk3K6zexBJurORmKsbfqn6/WgGQMoGzzwmvghD/eW08Z1MHNbuwv4zjBBT9rQroq0OySdRGVUnQeepr0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(10067099003)(22082099003)(4143699003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OlNiK25PeXPhiP5zMKmhbR0hkls6W9EDB/v0osLQhHPo6NCSlThRJset2v+l?=
 =?us-ascii?Q?1Kp9k6uFgVW6yj0oJnc3BquDgs6ldOAeC0trmIU73E4kh4PUEX1/e9eI09zn?=
 =?us-ascii?Q?pz9Ob+xSLM4VOIellOyol0AEJPy9/QXXa4mST2qg/QDx8kJSQTNIQegPfcTA?=
 =?us-ascii?Q?BN81o5EcnVy4MSgkr0EFaSNnjWuYCXsK/pmHVDakWRViSlcxA0OsnSR8ksMD?=
 =?us-ascii?Q?dwdoN+mZ10Ucg/NBdhVtWqutM9WyUfRu6eYJGp03OIZyC3XOwiILnG72s2ru?=
 =?us-ascii?Q?uuWdSnWYjNnuy3MjNOjnUUIItGga/cwXR0nFbkDSXv2qum1PT50xin8aSh8l?=
 =?us-ascii?Q?MmB+pudD2gZXEVqECYYKCsQivsE6VyHKWPdK0oFuVsDThZU4MEwm0Ug9YdUZ?=
 =?us-ascii?Q?BW7sb0kIRIGcjwd9Dc6X0Ehy8hrrXJpapV+hmZ/rVxx6KwBrADAt9acf1j5v?=
 =?us-ascii?Q?Kvik6EyVLYUNzWE8RCBZDbfccWlfzDZ2Bk+U3cuD1tUCRT5Vs7Ksoba1VBf/?=
 =?us-ascii?Q?KGW8EXlr5+YAFRsw4wPFL0gQcUUsPb/vX42uC3kZ3p3ge89ZzAD5v5ge2YWU?=
 =?us-ascii?Q?A9J94JJGljcmisAtEnUr/qyPk6kCXsmH/md32taZUCGf46NBLdFOMHMSV6+K?=
 =?us-ascii?Q?PtA80V8KOr2pD0mGqvXGSrFqN68gECMb+l8DKJIPp8cm4Ml/LeL6cFT9GTlw?=
 =?us-ascii?Q?k/csvhogEY3fMudLkaejL3PVGmcKCcuM7nKWEPd/R9PszLNqEVPmUqrmfkDO?=
 =?us-ascii?Q?9PoBz2bHhB8426Tst1hmTiFQnzcLe02yrF4IaVk+GCdVNnjg1CzQ79Brd5NW?=
 =?us-ascii?Q?r1/rN6n9L+s4RwQdEsLdpbF4MjJpFz0kZeykErzX37U0eGQooE7cxx5hHWaC?=
 =?us-ascii?Q?Q5duSeINUxRrtwf2Ih2kzIROPd1N1t35TMEGlLHmMwxetoohBWX++wEdBGag?=
 =?us-ascii?Q?i5wp0aff4ij3nH9S1mLM3wqiVaNn/eem8HQNfjaYnb/xnCduY0rr5JaOOvY6?=
 =?us-ascii?Q?2+asNUyxsEWfXuWGdNUeRaACj9t3bMSSNgezPEfPw91SqHo7DhPINbTUZQf6?=
 =?us-ascii?Q?kqN34MdJyLWhnSRJhRjfkWnmfMZJOAOp+S9YLXt162SOAmpoG/kRC5CkaHmI?=
 =?us-ascii?Q?DveaE0S0sM9m06HTO/i0YZFZuPVhcQa+cCCWGdl8z1hsKBiW84Ia/5a3/4z1?=
 =?us-ascii?Q?GH48C4muce46TEo6j8pQCxPBnyXLVzf6obVnErzUyMwWog1dsZi5FQpVDe5y?=
 =?us-ascii?Q?w30sWXhWmLPq1tH4kfPUvsjrQTr1iWVPZspTDouvkucLTaDH3VXHgAYub/b8?=
 =?us-ascii?Q?coxRwsNyc3xbJOQCWf16wlcujS9fjDsXRx8SyG0wvsW2lQkl/kmNBWIDEdw+?=
 =?us-ascii?Q?LVL0R/vBHcDFPAfJsOb9upVuG8tMUQ1H7J7p8NhEif99+Qz3Zdj3PDVwUakv?=
 =?us-ascii?Q?c0BpKygxFnwQ1/O1E66wTmpxCoEWbjvQoPSNXUxkzy65Ng1bmLQdOaG7V2/s?=
 =?us-ascii?Q?gGKBQVkzhpNsZgWWesF1xGTL4l0I5Ja6Jfz3LyZEBzJxewojVz/d0YHHKsnO?=
 =?us-ascii?Q?yf61RuqeJ1EEzaOzBZkwLmXPENlYAcpe/eFGsWtoI6N6kFqNtlNaD6HL6B8R?=
 =?us-ascii?Q?iJV0aZU90PT+33/BOybHKF6C0zyjzEHRYVTeyBCg0xzv7ko6vecQJTvN9e0c?=
 =?us-ascii?Q?nTOR+MNZJE0zUz79Frmxr+EyksUo5hKFXQc8dSHxddGdWIbQHWUCFnrrTciR?=
 =?us-ascii?Q?1p5mMReH+daFL20nJuAY/g7TXb3eQfQ=3D?=
X-Exchange-RoutingPolicyChecked: Y8OBV1fQRCk9afKfsQCCC8Su4qcKSv4Uz9ensZRQfOpUYpzHkouZjNDv9x/a/2zk+01QatvQRjUjLsDpsk1ulKsVqgsVw/4X4cTUc/q3Cxb4Ch7ATysdN5udFBWer25+tZqdIXJfEBwoTSbmJjbaQ5ZJX7tnHJOtX4MzkzUGrhi41V0myaCvSSnF7yattVw2Z83D0eMGt1eMYCpYX7j2hU9HtiN/EBuWX8ziq02Waf1shkEnt2obNNRbloSbA5ZfMMMhLSF3EFSEC9EwJB/A/ipy9hXZm+89W4doJCRFwHVH0IyCNjSTHC3ozeESVGxc1jpfw0IfqfJx3HJviJHNNQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: f39f1e74-6aec-48e7-878a-08df2aa26a43
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 09:55:16.7361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UYbX2AcYR06y6xBnR1ff+zn0WKlmt22OOjO8w3GRNc78NzjWoMzahPLRJqZMFGHS7fPNwofdlLboPSyWPTS+uuiSd8j6AAsE0kY45Vi48Yg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7768
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

On Wed, Oct 14, 2026 at 09:21:55PM +0200, Robin Jarry wrote:
> rte_stack is only used by the associated mempool driver and the stack
> tests which explicitly declare it as a dependency:
> 
> 	$ git grep -l '#include <rte_stack.*\.h>'
> 	app/test/test_stack.c
> 	app/test/test_stack_perf.c
> 	drivers/mempool/stack/rte_mempool_stack.c
> 
> There is no reason to always build it.
> 
> Signed-off-by: Robin Jarry <rjarry@redhat.com>
> ---
>  lib/meson.build | 1 -
>  1 file changed, 1 deletion(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

