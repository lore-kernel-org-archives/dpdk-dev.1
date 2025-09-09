Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B869CA0FED
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Sep 2025 14:06:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0691A40281;
	Tue,  9 Sep 2025 16:06:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 139BD4026D
 for <dev@dpdk.org>; Tue,  9 Sep 2025 16:06:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757426766; x=1788962766;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Gz+XFGybIBwYq+3uF83xtCD7XBtIPaLMAAgeclPATzg=;
 b=ONFOIRggAeD8yCE/CHvmsZ4KOVIDd3wzXSirmK/iVfq+y5W0bCouJ2AS
 Rr0PzPOwt4J/CmqvUxfK7COGiOKOQuqJ1j3KERgBk9q/RDzaCeHE1alU5
 JhGWiQ8aTAMtvHCzp/xzayERCw8bnbJ2s0cLDc7OCLAQex9Xp/mjPkSom
 jvJPdB7d6+5Qcz56fGW76Kd40enMKoMAfEHqoj1l5yIdh3pOAAI2J65ca
 GA6BuPpKYvIb1YXq62LXaz5S1aFKC6nheo/NpuNNLGOaUcgREmpR2XLUP
 Pq6DSVxRxrks0KxNeFzXGYZrOjnRlnlHAcA6/rojG90pkmpB93DCVoYVZ Q==;
X-CSE-ConnectionGUID: qoCnCx/aSEayR8IFM8Ghtw==
X-CSE-MsgGUID: 49+9KlNpTsSc0w7JllSI3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="59857476"
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; d="scan'208";a="59857476"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2025 07:06:05 -0700
X-CSE-ConnectionGUID: QsR/bpmoQme8NtnKnkPuKg==
X-CSE-MsgGUID: z6bX+p1SRme6XYuO6mjZTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; d="scan'208";a="177150747"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2025 07:06:05 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 07:06:04 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 9 Sep 2025 07:06:04 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.66)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 07:06:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=es+pvTfq/c43/E57Spc7ML4E4hvM32kTC5JEyGklSR2mtJ5aZOVZTzkfwXkRjoo+GQ2o4bRg+xXPLUJ17GCQQYT+MP0pG1YBjpJo3xug01SHhiwku/BR+umg7fX+FHPZ1tMe4fTSpasSC+ce5RkLHdJgK06u1Ki5XSKm35SvoqSIl0Qu9yl0tR61A/bl4xIsrcIbubY+2CRcR8v/ezwc1mjNeTQfM0qC3FZ67p28bvhvoA1PxPCctkR2yxJCGQUfvfyq/zvB7LOGCoz1htJC5v3L8hFKm02/a6fLu9sYNcbxhg0avZJAs1OdIOAdRoqaeXYbkScHWZ6l5Wjf8BLRkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5BTN0uxe17LFoFqC+XPZxqM6LrwmkMHz2jV5tRxubgI=;
 b=ntwhXAILXl9AboveOfia2FZ8BR4xfR5xf5FIP12Xns8XSJoKc/r7WOORsr7/JxokFcaknxBj7CxxGEUIdA5oMg1a7qYJVmj7kh2krH6FrxH0VQpGX0cNWwzqbZ2O2LU+5gO5S9Gm3HAG/YhOvMPxaNaFAolvbaq2t39Upfr1wqeZbguIURnAULLa1YKuJakLsmUrR1rzQlQkicg1hjdfJ/WbFXs6P9gZ8jKComVTbeRpjQLoOyGG5di/6Gss0+GI/dmkDQQJ0DYRCehj1yhM1iAmhPyKNhFNkC60DedsKTRGku3XWXG72PWgT+XisjmMEnIMu0q9cTDrhDt9U5Wp8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SA2PR11MB5194.namprd11.prod.outlook.com (2603:10b6:806:118::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Tue, 9 Sep
 2025 14:06:01 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 14:06:01 +0000
Message-ID: <7bb6b47a-45e2-429a-8991-2ffcd2c64806@intel.com>
Date: Tue, 9 Sep 2025 16:05:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 1/9] drivers: remove unneeded VFIO header inclusion
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: <thomas@monjalon.net>, <maxime.coquelin@redhat.com>, Kai Ji
 <kai.ji@intel.com>, Dengdui Huang <huangdengdui@huawei.com>, Rosen Xu
 <rosen.xu@altera.com>
References: <20250903072826.1727004-1-david.marchand@redhat.com>
 <20250903151800.1965006-1-david.marchand@redhat.com>
 <20250903151800.1965006-2-david.marchand@redhat.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20250903151800.1965006-2-david.marchand@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0023.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::17) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SA2PR11MB5194:EE_
X-MS-Office365-Filtering-Correlation-Id: 0477b00f-6989-4bb7-4329-08ddefaa0197
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c0NHMk53YW9vU3UvL1pISE5weVlIVllkY3MvazEyMGZEZXNkbUZzdGtENjFq?=
 =?utf-8?B?RGdaSldBK240MVBlQTFsSmdueDJvbUVJTG4zM0NYSzY1Nmx4M1NRSzhXMzcx?=
 =?utf-8?B?aHlWMkNIVzF6RXdQVHNpTW9OcGJXRzFCOXVvazhmUUswWm11VGRCd05qNVk3?=
 =?utf-8?B?MHlScTN4UEZYYzUrTEdUYWM0TW10TFp4cDNsVXN6VjJvemx1a1NyWmZuQWpj?=
 =?utf-8?B?SStpTnZzM1kxRXpISi85d1M3Q1NhSEVEaENqN3ZFWEdGdWRjYkVVdkVZeHJW?=
 =?utf-8?B?Mm90WXdRTDdiR1NaaXZVNnZUTFVid3haSVphWTNFcEJXd1hydzJsZSszTkVG?=
 =?utf-8?B?ZVk4OW00MDZvcENiUmVreC9IcUx1VmZBOUUzZEdRRzY1RVZudXBqeVlNWVFU?=
 =?utf-8?B?V3ZJaFJZUkxGUTZpWldVdnZzb3c1NXFhb1BZTnFSckpKNjhqbTZmSzE4SkZ1?=
 =?utf-8?B?d09YRkZHdytQR3Q0ZisxcUNyZ1IvK3M1b3QvS3F2UkZnM0dQNmQ1K1pQMlg0?=
 =?utf-8?B?emhiUzAyajFTQUlGcnd0cTJrSnBLWTVXMHkrWWJGbk5YbnBJVVY5RkdzLzFJ?=
 =?utf-8?B?N3hLeGJCVUdvNzN0ckJONm5yRlRhaHBaSlV2YkVwU1BVSE8rd2hHWFZUUVlS?=
 =?utf-8?B?YVFZaU91b3g5b0V5RHR0alJ2cGNhOTRGUHoxSXZ2cE15NlhLamZZZGRmbGRF?=
 =?utf-8?B?YlhHWnBESTQ5Z2RETEFIYTJUZyt6YUpFdGdQRDRUbGZPc1BlWC9GSytYcFZh?=
 =?utf-8?B?NldqeDBITnErZ200REdBMFZLVUsyVzlxc3Y1cjdBRGVKd2s4UVJvUjRIYXpD?=
 =?utf-8?B?TElhNWRyQ3YvYVNpRGlOS0JhRDJqZERjWWxiMFVNVmU0UUUxME81NGFBSUdM?=
 =?utf-8?B?Y3h5UVBmemxoTURHWC95TDFVSHNKZVhNbnh3WGRJWjEzSFVZazJaT05tU1pI?=
 =?utf-8?B?eDI3aSsvMi9HZjl2Z0tBSDZISTRNZGFGSzl3dW1yaWpwckVJM1R5WUtTeU1m?=
 =?utf-8?B?QzZ1M0Q0aSt0dEkvZWRSNTNDaUdycUVyN0IvODdmLys3eU9LK0c5RE5kOXpU?=
 =?utf-8?B?cytTYzNXWm5RaXkzMXpiWGNwRmZ5Ykp2Vks1dWwvTzVVRE1hSUNQdndOblFj?=
 =?utf-8?B?ckZTV2tpOFM4U3N5VDIyUG9TeC85by9pbWtYRUMySWVlSUwydUNMTWNyLzl2?=
 =?utf-8?B?b0FydFppUGVPVTl4M2hHWjEvWFVWSnBRd004QlVjdHNjTUFFQVA0ZTBqRWho?=
 =?utf-8?B?dXlhejg3S2s0cUdaUUNiNmc1Z3ZGamhaenpNRzJ0NVVIYUNoL2Zxem91STNo?=
 =?utf-8?B?LzBPTzJURU9uTld4elB5N3BldHk2TXpUYml4RFg4VGNKMllHOXNEUXo4RmlJ?=
 =?utf-8?B?eVk5d2VQdE9RZU1CQTFCU0draVNzaGlCdXhERjFkR2JKa001R1JKOGNxKyts?=
 =?utf-8?B?dnZSaWdWcjJZRXdad2MwZ1ZocUd2L1NHNnFiS1pOcWdCcEw5bWNMQ3RwTTBa?=
 =?utf-8?B?UFBpUEpZYUVONUdsU1F4SHNBaGNnMkVaTndINlY3VmU2L2FLWEVDQVpJWndW?=
 =?utf-8?B?R0l0cnNYeDJnWCtTMGNRaFBZOGtzdC96MmtkSzhXRU5IRU1KYzZvaWdzTjhv?=
 =?utf-8?B?TEZzZ0NsNURVRjY5TGpEcUYvVGJLK2l0blp5ZngwVTVOdHJOVk5oemlhai92?=
 =?utf-8?B?elZ6Y0V2NmVoUE5MS1UwQ3pwUlVtRldGYWJEMUxrSGx0aTJQMGpJYmYxSDJ0?=
 =?utf-8?B?ZmNubTVFT2N2RGlsYncrVU9SRUdjM1NKR3ZnMjNTSkJyZ25ER2lJandueTlK?=
 =?utf-8?B?SXcxTGk1U2hjaGNoK3IyTENDaU9tN1dhczZKdVk1ZElIUi9BeFI0OTJxeVdT?=
 =?utf-8?B?WnZUYVFDTG51OGJzNFBabjZ4L3NrMGhOVDMyS0JGTTlEZWhYS1kvK0Y3QkpD?=
 =?utf-8?Q?z0Kxs7JWHnM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sm9TMW55SzhtRGp5WW1keHBjemltUTU3ZG91UWRNUHhIN0xQNmxqakw5VUly?=
 =?utf-8?B?Uzh0N2F4SkpIWnlrQ1VRdGsrU1k1U1VWL2dweVl1UTBhQ05lb1pqbCtNSUtM?=
 =?utf-8?B?dU4xOEhRdE1aeWVXczRMUk1NWmxsTmFMb09XaGJqdDVIbVplNHRRQ3lsVUM1?=
 =?utf-8?B?T3NzLzR2VWprZE10UUx6UVBGOERXWnpyTVRzcHI3dXpPcm43bkV1azZ2THJo?=
 =?utf-8?B?UUhIQ1dMSm44d2lpNjczZnZSclRSVm5jckVaNHVqWTFvSmlpY3M4amRHNDc5?=
 =?utf-8?B?OHNoY1RndGxmR1NPWnFLNjBOUFB5RGZlUVg3K0pSRGpYQnQzaFJqSmk2MEwy?=
 =?utf-8?B?YUp6TS9WNkJxdDE5akdmZGF5TFNTdkgwMi9DZ3ozOXVreW5jaXMyeWVudnZ5?=
 =?utf-8?B?VlhLSTVmdWpCN0NqSHNYWjdsbFpwT3JZUnZsSzZPN1BybksvZTlnSFBqNGtG?=
 =?utf-8?B?Ujd6NzIrRDR2SGV0ZTFKb2tOeGlLYkl4MnFtY2hNaWs0NWpJb2VSOEpvcTZh?=
 =?utf-8?B?MkcyaGZWU2lCazh2ZnU2WjRtRFJ2dm4rOHVUMGF3dStVazgwTGhWQUU2RnFP?=
 =?utf-8?B?cUMwM1NNTWNyeld2UXFBbnYyNmhuNHJYRGowa25BdDJFYUR5OHpaRDJwUXQy?=
 =?utf-8?B?dDE3MU9VdFEyZ1pjZk56Ym9OVjliRnZPNTVWWk85VUNQMUdkbm51cjAzYmlQ?=
 =?utf-8?B?ZC9XUnA1TjVEbU9WY3ZmY0lseCtlaFdOQlhsenZCd3ZBdEh3UzgzKytHRUM5?=
 =?utf-8?B?S0dEUXFSMDM5UXVVTUdLcFZwaWpWaGFMRlJSdmtUOTU2NlZRZDhMV0R5RUw0?=
 =?utf-8?B?K045SGhlcVFGbjFRLzRZNllXVkc0YTM0emtTUDFTeHhMQUxuQkZiN1NIcmZ2?=
 =?utf-8?B?Qmw2cSt5Q2VkQmRGVkJGcS81UmhlSHRvMFl4WnY4Y3hkY3hLb0d6andlMzl3?=
 =?utf-8?B?VzBHQXd0SXEyUU50WmZDdUVud0RxbURYZ1VaN0wweWVwK3pNMGNzWjhOYm5r?=
 =?utf-8?B?OWlaZlZuU1pUVnBraEh4UGt4dHdROWRBYS82bXFvN3NSSFQ3dG5rVkIvWkZp?=
 =?utf-8?B?MVRUWHdNcVRIazR5K1RscTlWQzRyck0rUGJKekJtV0ZEbkhWR054QXdvaFJY?=
 =?utf-8?B?YWpzYndBNGp4cWhLV0NaSEtqV1ZiZURwcEx2aEh3Q0lxaWF4YWdIVElBTDlO?=
 =?utf-8?B?RXZlT0g2bVREN05uN085bEQvRkVtOERFYUlPOG9NTXNiNWF4ZEN4TVR5YnFE?=
 =?utf-8?B?bjVQUSs2bE5rOXJ5UWtqay82cERjS0pWNFVYRHg2TkZEQlBRemZlNm1wQnRC?=
 =?utf-8?B?bWJKckUxMFUrc2UxbmdHZEhkMFpWOHFGT2JLQ1A0YVQ1WjI3bThXMURrbENt?=
 =?utf-8?B?eUpHdXFjcGdvcytjZnhVeGR3ZG9YcXN0QkpKaUZYVHFoa3dXb1gvbnBSRnds?=
 =?utf-8?B?MTJ0NEpnMzVvMW05SUEveUNJQ0NlR0JOVEgvbXJvR2UvWHMwQzIxL01tRGFj?=
 =?utf-8?B?ZTZja1MwNmwxSGxyWXB5UkJBRE5BS1lNMnhVQmptQi9IbmxIaTB2bE44UStF?=
 =?utf-8?B?LzBPQ0NNOS9icm1sQmY2R1l1UE15dEtIN0p3VGpWd1RkRU13dXhvcWlLV0lQ?=
 =?utf-8?B?MjBvc3c1aC9MOGRES2IzdEhpWGJXSEhxbFpXUU5hYzNRSm51YlRFbXIyV1lj?=
 =?utf-8?B?NDRncndZRytnYnpHWUxDdUs2WHdZdFJNeUZWWXRZc0hhM21ESEsybkV4eDV6?=
 =?utf-8?B?ZzBDZXFjSlZQVDZvZ3o2NW96ZGdzeElCWmNrUWJwYU9uOUxyK0ozV2l1R2pO?=
 =?utf-8?B?OUg2enE1enR6WjAzT2J2a0VqVGNYejZBc0l4bUdwR1lqR1ZBWXkzWFExVTA2?=
 =?utf-8?B?YzVYOXUvUFExdlpxSmFhMThwbjJVdnRSY3lMR0FGUXAwcklRTjljcGlzV3kv?=
 =?utf-8?B?bFFqKzQxYXZFNFpheHM5VEQrK0ZZc2pTTDltOGNqMHNaZGY2NzJ2dFU3OHpC?=
 =?utf-8?B?MVdLOXc5VGEzRGdydVd3WW9iZnZ2cWZoTjBhOHh5OVVuZWtVUFJVa1FtVjdx?=
 =?utf-8?B?MTFUSlI4T1hJcVlxdkVmQkdrV2xrZVczQ21UN3E2T2RDZTE2by8xd1FGZzF2?=
 =?utf-8?B?ZXZtSXdhMkFzTlVaa094V3hob3ROTVdlSjNzLzYzR3hXL0o5QkFYcTZXd0Zu?=
 =?utf-8?B?aVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0477b00f-6989-4bb7-4329-08ddefaa0197
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 14:06:01.0442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1sQ2YdcfyZEyobpgtREMcajj+CnrU2A3VuMavqpaH/KYV+Jo9HBBRKcRbRSL27gxyZouNLlC9HoJrkV2k9voDATVv4Yg9GYanDZhbwKUI9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5194
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

On 9/3/2025 5:17 PM, David Marchand wrote:
> Those drivers sources do nothing related to VFIO.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
