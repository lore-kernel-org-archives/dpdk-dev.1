Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C71CA0EED
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 Aug 2025 09:49:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD083402DD;
	Wed, 20 Aug 2025 11:49:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 052E440292
 for <dev@dpdk.org>; Wed, 20 Aug 2025 11:49:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755683384; x=1787219384;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=4Bg38OBTX1muCfzyp/6yQtPJAzRsOvwt9jq7Do1U9Vw=;
 b=gHS+HcjcaUAwXN/rEXZk8KZfycSW5rtg3/DDd+t5wkCu8yojAKdyBIG1
 3iz0ojwh7T1s0jh30YH8UxyPEkFGJ7yIsMqwerjEnRUCSbR0udCvtWIQR
 3QSEvPgjLOgiw4YwZ9mMTNMmxFieDl+idHk96OMK+X4l0jPhlBF6YKLtK
 AE48nuJ+5B006AYjg/WZk9++cLSgaacsQi/9sZ6+cOBHiToQSzTy0nYrA
 +XycLqZ/DdfiMVJfw9+A4v2Z0g3lRuIc7TYkkeQ8LQGLVtdoDlorxHmcM
 Wn9Twa79boDcvgrSrj5rafiC10mhiTxUNqmDJaJ9ep9iiTKk1sEGS5eAt g==;
X-CSE-ConnectionGUID: aXSgaed2Q5qJNvbgtmmUqA==
X-CSE-MsgGUID: 8j6o6U7ZQZC7BIXgozcRLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="83369491"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; d="scan'208";a="83369491"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2025 02:49:43 -0700
X-CSE-ConnectionGUID: yFvneArlQGyncQV5JrWEcw==
X-CSE-MsgGUID: iZqYkIqvQxGeQfBoa3PWzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; d="scan'208";a="168433828"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2025 02:49:43 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 02:49:42 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 20 Aug 2025 02:49:42 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.44)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 02:49:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LR9rm8TjCXtglIf5lPHLJ6Jbnm/ZkWNbZLA+yq3jWs9Q5FJzIdt8HJvxCTA1vvwUaXo/PetgXon3axISqg4qFSU2KFUZoLTjzIqJPePkuwYwQwBCvG5g45S48OI40o8epUg6M+D/wVOWywhbq3sQ5Kxd8ob/OePR6IE30f4G/3JM2b0C9oFrxyaBBn83+7ZyBjxQEbHTx4ikbV6+rNJH3ilrsuFz5p2Ajwrirzr0jtII5AvgFU3HhMUooQYS33ajRrp58ysbQMpYEMvGZh/CtBykON6eHEBpz03H3WDxJ3onBAzgJ8Kun6hVfrFi7vq8V5yPtOBv2S2VXXg+tEEEPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxAF/u9dHFOH2ylmKsWXPQXqDQmRaLTKHXwRRlsimQQ=;
 b=AEmKrK1C+/4Lm1BKKdd8znAnMnGU0e117fptpwZd6mTaKvB2I77HeUdqzUGGAXsy750SBTsGoB7MxG+sBLo/dzHkSdWWPtKSzRePzqxB0vquLBddWUzCWUsfiB9NX49EDZ/BUT2fug7+x2fWJ+Uin0te3hLXQcH1c3NfIDlt295lQuCFDa3pMSIcLwLhC9Pk9iVOACdEVqSD49L/fxw4PbSMPuCzurtInDQhmCUwFweZiC5kTkDGJ+9nMHiHoKT52vF7VubWMDAMbKz2MhFEkbMDJSGbaBYZFsBTs2zNiw3Hz8ujTpsUGC26/pCKKp5FnHhTZvaapKPrMclbdBjBSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB5996.namprd11.prod.outlook.com (2603:10b6:8:5f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 09:49:39 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9052.013; Wed, 20 Aug 2025
 09:49:39 +0000
Date: Wed, 20 Aug 2025 10:49:19 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 14/15] net/iavf: use the common Rx path selection
 infrastructure
Message-ID: <aKWaH7TUxPbPX1Qi@bricha3-mobl1.ger.corp.intel.com>
References: <20250818105914.169732-1-ciara.loftus@intel.com>
 <20250818105914.169732-15-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250818105914.169732-15-ciara.loftus@intel.com>
X-ClientProxiedBy: DU7P251CA0011.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB5996:EE_
X-MS-Office365-Filtering-Correlation-Id: 33cb824a-b714-4357-6ad2-08dddfcee177
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vXkDi/eJyOoT6QJDixTCXCJGxR7m/hwjyVm1bwk4sVktfXMTsAfsYC2VrGS8?=
 =?us-ascii?Q?AeONi1ltw7kj9r23M7yPkmEfTfW1OKXFBiHgaDtGwc8VHzncmhPF1pm/dS45?=
 =?us-ascii?Q?lgX259t/QgRMAD9ke4HBK2ADhwfT3NuNZbSbCuVJSX3SfkNvH8jK8a6wL3vE?=
 =?us-ascii?Q?/OaayUlQlAAoCHK3iU/2hRFrcuxMzeHyEk8myAHEpbQSpS6ZdHawc/y1SKOr?=
 =?us-ascii?Q?Ddmqq2KTlnYNmwLGqCy4/JcqhmG0QFGR3ErEsTwwRFD2ePceDSDRnWYmP4lX?=
 =?us-ascii?Q?N8PXqX31ysMjOJWxqvHDQ8Jxed4EXJheNiZWV+o+cd86bYA2TT6KaGGIES1g?=
 =?us-ascii?Q?Aumv4bt36Jf8MqhLrIaiYbyUmyUR6WSXb0Icnr2xrm00pHHqS98CQaURd3R7?=
 =?us-ascii?Q?s4jFEuIY6JvcBd25nuX5BQJZlAIRGnbOsPQJ98uvVGzthJl9iF24iWlZoLl4?=
 =?us-ascii?Q?0YDxMOCbjK6IQxLvpKl5VKP1m7TSp5uA6JYRL2eSoq3rPCKPpLy70j8iqyfd?=
 =?us-ascii?Q?GgwUMjjdUfX70nYBgGiw8OVMMzMjEg2HsD3KSLrVP6cODAbKTfAADs3MOqiB?=
 =?us-ascii?Q?dkVhE7J7+rd4wQ7a8vfvZVxXv1NZAkb8EuPA3DmuNiFZ2UUF24PaeDA7TVGc?=
 =?us-ascii?Q?aKC33hji0ptvL/GqMXhEI/DofYmWimHJzJTJ4UQPKQnHig8miuYT+s5req/1?=
 =?us-ascii?Q?TOxYIxXEFaVV0s6tHlNrxnwQn5LfCHYPbuoKtyHowigKI1ROXWUm+3kZHaHc?=
 =?us-ascii?Q?3XGFIVrVs/S7H+ui0jrs0yS6wtpky9PCP0Qyg7IymVQpEy72azAlbzB9p2iY?=
 =?us-ascii?Q?Fbr2N//mhOeaX51FWiVptJUnCE7fcIhjXGp0J5negU6H/yCKlt84ZYMEBgvA?=
 =?us-ascii?Q?EjNh6ZZp/A4+brMm3M4ARzHXSHli9OsEXujtGvUVxKR00jXu2UvZWIQ19gOm?=
 =?us-ascii?Q?45FnlHVrIehuTvyTk5BR+7i2qVZLuzp9eVmNgqnZU8rz9PpKPPlnaF2RMDo/?=
 =?us-ascii?Q?dzFYHr18EK0F4VRwVoM2QdhyBnsm1gz+p6yxvHkCPEHhfVkbyuua+C8063Un?=
 =?us-ascii?Q?0iY+UHP/e26hpFwuGR/mnR/0ML+oeDTi4yMgcUG5/0yjJWGR87omTybtBgsu?=
 =?us-ascii?Q?JhxGuIAH2O7tnijmk8wvTnoB2SO2EO5Jjm4MYYs9XkJbineGcyvA+QyLjlnP?=
 =?us-ascii?Q?JlAfAkUdsJChRq3yyyLfG/Sr4vwCxn+X8+PlrrvcJD7mLBqi2PclO9S8BDVn?=
 =?us-ascii?Q?nHl5s0ejNvLFMWZHCnEf9TqkIHs0sFsBeO8ptzeprNYANUEPDXL5utsYnR0N?=
 =?us-ascii?Q?owduGatlEGAPnGAJmdneiJDqYB1dKe2JEEDYFJJuY27Y4B2KWWidX7qjHFkF?=
 =?us-ascii?Q?QAYaCcVf4hphDcstSbhY8o6oeRJsqm5gw4qE/jdSSbK1yN6y+xmb/QTd90KB?=
 =?us-ascii?Q?h/mGPeFS2xE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FxMH6CPXX13kAyZ+wLmfNylkSdjkqp7M7KalJAN5GnO+bbSsgSlWYlEM3yzJ?=
 =?us-ascii?Q?J9VfpgNWGT4gEE3evVpkqFZl3qYJtPWHPAFgOtXF1+JL0lrh7F2UtN9VJrGV?=
 =?us-ascii?Q?oFvhJ0AOk9ZaX3R2ghVoIJBNJHRqGueTk9KON4KSarg3p6imOIVVcL0xra4c?=
 =?us-ascii?Q?GZvcI+0yoz9AGao9B6LfKT58x4Wl8eH9o+06ZrnxKDP0gm+UNqQoG6E9LV71?=
 =?us-ascii?Q?WOILr5F9WpROzlIRCgYBy6VxR7n72LVBlbbdFveA8wV5vNVAe0utePXjCyVV?=
 =?us-ascii?Q?btt0DB0eQe8wzgCfRkGmOU7+1Na+DbDv7MBOG/2w23a2iwQJMVzwQ+IOXinf?=
 =?us-ascii?Q?E9bzIwi7HwGq8FseI7KZ545oQ/fkrPU29zc84Ipd4k79MWRR9DTo7H8uH9xn?=
 =?us-ascii?Q?35OFpiWE+1Dkm3/NlRzKS5Kmbqocg2WQyTEZcqb4h3kGm1Vcan1rA3zbd3l4?=
 =?us-ascii?Q?xeu4RFS7S8z9AP5vW0dlEm6T1RUtdmP6RnxsPqyYfUo95SB91X1B7O0XNOyP?=
 =?us-ascii?Q?Z6Ki8j+sNWZZt89vOE8lN/OBkiDI2JK3OX0H5XLfuuOdPuXt2wZHAii/poNU?=
 =?us-ascii?Q?GKt/Z0RFoeIiBXbSJXS0p/msoVsh6U/5TPz4pcdcMc1MqhXiSWsjfzQC2ueo?=
 =?us-ascii?Q?xd7GNZLc+PzaA1ftdtQogj3XWXcPoGH+Ry3S1NrLVdCulNbtOXC3ruIi2qkO?=
 =?us-ascii?Q?7tmxYRwAl/f/22EEmBB3rRm14K9IRf5K28aJ9U5lqtpXdIlVcBh5VwfJ5vsA?=
 =?us-ascii?Q?pGvBqXRu70FwiJknN8C5zcuCy5gR1asHyQEPQKG/IKN2N2dexAkt0Oy7NLKW?=
 =?us-ascii?Q?/CYy1CTk6UlmNcKTf5mLfjuNHuB5uoCN2JU0KHwn6JiFgmm2V5URWMChbpUT?=
 =?us-ascii?Q?FgfmrYCWnXaSfUsD0DJHdw1YEbWaf8JfWzXH8zjxTspaLM4YtnfR99CrWyUq?=
 =?us-ascii?Q?CESlM+TU38iNiHeo5IqjM9PD53R2pZW8WBHq1xApgCuQBywAdKLinonaRXEX?=
 =?us-ascii?Q?uZOBigYYzW+hkwqW3yPd0/rHscH7YHKh9kG6pEngODxCKrjUnr+2IiGmfRqW?=
 =?us-ascii?Q?n388hC5oADY7s+yjxC8x0cCFtIuxqyyhA88htpoQZtPq4mbrOM01Gle7VUZY?=
 =?us-ascii?Q?LJNsN/pGmWLnbljjRVGUNwQFCICaj1XhQ+9yl53yruKbmky+FhqGXqFvqGiW?=
 =?us-ascii?Q?J0B1977djo75LZPFHxEJzPfV5ujbCJnmUWzSMoAb38OZiIcD3ftMwJNoZs3g?=
 =?us-ascii?Q?c+lPzzklusNGIHJHH8zvTS7ojtwbkwQohWhQtEGAO2X2aYEIo5NG3hNcivKm?=
 =?us-ascii?Q?NcLMinSg14EmvjX8hTPjVOwHims1ARLHYOQTQ4ER1Nmg7zWN0Pli7RhyjhG3?=
 =?us-ascii?Q?jxKYA/FjTbSehPQty4xJ1ic2z33fYQ4ZncapzmmoOt5P7hPY/Ae5VFjLGmVk?=
 =?us-ascii?Q?fUHTi9ALG2mf36yx/pYMqSFXidno+v1PW0GWk9dPYgWyNhcqWfMM0IemScG7?=
 =?us-ascii?Q?14COkexNJGopSrP4np4vyb2bwb973PC1+9WyBe5TtEeGDyDVtSK3SE8vYhLG?=
 =?us-ascii?Q?TNE/7kEYjJqQuJfQQcctUtB3ZWtZq0PeJQeQufcJtV8F4Uf9qw6pM9PRPSuc?=
 =?us-ascii?Q?HA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 33cb824a-b714-4357-6ad2-08dddfcee177
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 09:49:39.6777 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lW8WdAHO4s2pr20bQqqs9jebddt/YcWupLpu/bOa7QURFzghKMwehwDQHPKWYp/wUdpN8V6OhEQNBSHh40PJB7SJhpDdMRBmqTK8ODd5fNQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5996
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

On Mon, Aug 18, 2025 at 10:59:13AM +0000, Ciara Loftus wrote:
> Replace the existing complicated logic with the use of the common
> function.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
> v3:
> * change burst features to true/false instead of using defines
> * Use new extra features structure to define burst features
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

