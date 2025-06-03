Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70417C5AD49
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 17:02:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B637040E64;
	Tue,  3 Jun 2025 19:02:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 3D4AF40E3B
 for <dev@dpdk.org>; Tue,  3 Jun 2025 19:02:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748970139; x=1780506139;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=pldMJdXDU0538j/pE7zXKuS9XGBBrFzBeP/kvd60AIk=;
 b=fanlWjrocj/8b4yQQIkFtx7mDZTRKIYU9yJvb5jRi+jfXn2XOmdecYAX
 iXIGRtXpjcIlaeXhoYfxXW0Y6US/mFPhagwE8EDwdvUSpgrsbyXY3kVeg
 +/e5LphCLh3zNJQKvHRo2OVEhmNQodScwAZ44Rn0SLXI1m1u2YGACurFf
 tDCjWlnbGrBzP3ViKwjumXWGvknr5MOVZ93fpDKxMxzeFuny0M52Zuml3
 HVanl4Vj08DOEeGVuFrQItb1PNZOLGlHHHJK04FPrMxtxv6bdmk9szKfs
 qepd0xpJ61HHnHml4DIQ5gZRBecOWMSJLXrtmfR9Td54LzTb609HYx6Nc w==;
X-CSE-ConnectionGUID: FaZQDGLuTLep1YR41u1oXQ==
X-CSE-MsgGUID: zCGkca8qTTCoP7AoSgquow==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="68577420"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="68577420"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 10:02:18 -0700
X-CSE-ConnectionGUID: H0CQq5luQQO09V+geFcISw==
X-CSE-MsgGUID: BJtchI/rSG680bAd+sXmAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="144795537"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 10:02:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 10:02:15 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 10:02:15 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.57)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 3 Jun 2025 10:02:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ETSzWUAgCzv2hTevb97UPF1klJg2rYjJ3xG189kbDMCJKRMtRvVciVo7CcOwCBQJnNygMeOeT6BeYDHCfnHCFZr0e7WTFWATBWtH/knYjaNSA8b5vRWp5z6qiCJHjP0aVb/n/JxoYR8OmBQBU5gWF4j7plGSGkcL87NmcLVCRi6/0OTVchMjrwziZ/w/IW9lunnDEC8mIo2mVWMhOvgdwscq5vj9MvDHxtaVdKwYZUStC8L9dwfG/bfdsFJaKWWcw5pv4r5bGkM3naIYrVkknzsTVsCDLc+mXVZjUutJtN4tuF+0FJ/wiz3oBQ7BzeD3GXKwP9xqpd55mMyAZCLY4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8CC+ZPDpx1TAH3JgdflzyExwg4X5nqlw5eGycDaIYU=;
 b=xH+sjy3JFxLGMCNgGckUn964tieQnRzExf7DcTbfkHElnj2BjiwmhbJ7wBCGcgkWDbaiXOgIeAvcJ+pjYjjKaZ+JFFMHmAp95wun9z3Fsim7kh8TK1PHUZlZlhWvF0VTHovHIg2SB7jDeFJQliZBh7fdiR8PJMrxOJIphs9iU2JwjqeqhszhvIzm9sRPIjH7Xso1kE7xjWC9XHFB/Us2dSUa+NG684hCMAOpNgeqmisFgDXtqFItwv5BWZuO3JeQCzbLT03HcR76HpHnzSIepBvyF9XEq7whiNxqNMCwi/le9Ip0/3JpP7xphcgQviJJ87DoiiPlZo4TTTXhgmO2yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB7642.namprd11.prod.outlook.com (2603:10b6:510:27d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Tue, 3 Jun
 2025 17:02:12 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8792.033; Tue, 3 Jun 2025
 17:02:12 +0000
Date: Tue, 3 Jun 2025 18:02:07 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v4 17/25] net/ice: use the common Rx queue structure
Message-ID: <aD8qj-ZTT8wvXZ3v@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1748612803.git.anatoly.burakov@intel.com>
 <cover.1748612803.git.anatoly.burakov@intel.com>
 <6d15c84431e2e44ead6111865700585a9c65c391.1748612803.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6d15c84431e2e44ead6111865700585a9c65c391.1748612803.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DB8PR09CA0003.eurprd09.prod.outlook.com
 (2603:10a6:10:a0::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB7642:EE_
X-MS-Office365-Filtering-Correlation-Id: 2596c1e2-5f29-4057-e36f-08dda2c06220
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PsPFrI7kB+GOW0ZUw5KNLKIx8jw7PS8LB+3nYCBaPalu7K7EaEz4nx29HELx?=
 =?us-ascii?Q?tW1bZGYw52jDszHdXUBDd3KcuSx1Bmjp97wF9Ll/yhJQCIApQ441cnLFm5r/?=
 =?us-ascii?Q?sR7nemeAhlMRXQGV89L/MAmLPhyRk6/nZdB6qWyI0B3Tp1jZtCqsONv2oOpI?=
 =?us-ascii?Q?ombj5oDm9yutSNEqBRtK00lXZVOR4d/kQ/wethnDGhMdMYzlWcezBTHAPo3F?=
 =?us-ascii?Q?nENsFdIEEkHcThjbRc8aT62u6fZL45vXQIkxsddEbG9VLcVXxPAPUMuORs7q?=
 =?us-ascii?Q?BjWLF1TdLPDsAh+wCV9G8fy97ur8JvJBzJGDwj1WWtt9dv/Yz+1p7Zkjn4HY?=
 =?us-ascii?Q?on9SP4yp0FMSx+4MyqzjiGfp4AHPtXCX872XHg5ehfZzjzBj5fMfYTKbIpc5?=
 =?us-ascii?Q?yfhWL293iAtIZNY/DVQslhdhD7hPLbiUuQrySZL8YB0aCh0NUVkYK/SiVyOl?=
 =?us-ascii?Q?SM8h9Ena0y6M/7WxuKGgc2RElHpCYRD2zc09HZ/qpaTjL1IRbglF9wesjL5/?=
 =?us-ascii?Q?8tMCzrRpZnNj0X1d1+W1Qm3Lr7X0lF2+9aFml1qrPDgVLP9hjuyXAb2hNxsG?=
 =?us-ascii?Q?XkUSK/NjTWsHT4vswWJpWWy3T2pdbK+TIRgHEAl3rpcMfCWBV75V6H5lPHLv?=
 =?us-ascii?Q?Ox1q/ZljVHeyXzmSuFT0mvhl6cICRE9bYP2jIHzVT69E5QjNAFHWRElYvSjH?=
 =?us-ascii?Q?feWCkxSKoGCL5dHGa5vCZr51Tti39m/dmxHfYjnSf9vwxYqoBWAsQFOq2RGw?=
 =?us-ascii?Q?8zMX3/7ISiSN5+FVBFqzNUBMYxEoGfbG6STbXaPLXogO3Bjqrp/9Ao2c1Y4n?=
 =?us-ascii?Q?T3ZWHMsUGuSiS5tXtvFheBveqXtp5dKtKW9hMlE0B+qnqKCJeACuB7oI3+s6?=
 =?us-ascii?Q?8SoE7xNTj8dz6CcuphUOssBmG0Gm2HFNLaEeL8qR+hbcEY5EO4cK8r49wYci?=
 =?us-ascii?Q?B3kW+i7ekpCxw56t2c8W4vziWeb8+3AWztLAB3rYm3EZKiWojV+vscM+t0UL?=
 =?us-ascii?Q?N+t/VzLHMggNiWeHpg3Kw0h8aObGs+FoDbAp2hHjlO6ghZ0MM4urZL6KhFQo?=
 =?us-ascii?Q?qeT0K0g/IFyDpu/MRrrofEUcDootXxWHrocUrp5UYII4titKOFx/CMIXNF3a?=
 =?us-ascii?Q?r1ariKOnOariVJ4sUYJvL3nSxtM6wzUvh+MU01+URa4iUNRokY154ucOEV2y?=
 =?us-ascii?Q?xlr4o5rkPXSHvbXFrT2nLFxSWj1pW/atxtMq4kABoamBQVPXvguEFiX/Ndvv?=
 =?us-ascii?Q?NGESn4nYrz2+FK1jr1O7dSsBX0zykc7zz8zrLMfSC5E/Y07qiE0Kt7+Ffvl6?=
 =?us-ascii?Q?DzjUdIFYDRM5Pza0BdGi0x5FWxZuPkYoUjTVUwzrfpnAy1+99MELbsOM/jTr?=
 =?us-ascii?Q?QS9fMFIXZyuEaRefufr4uY8xRl970WVUKRUPL9Y8aD/S9qj/wgzeLkwpTybz?=
 =?us-ascii?Q?pN6iPkVmIig=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VvAjisR8RWm0rq6EEQA5aejUWdE7IxWHV9n2KL8wGy43ATX2xcEhLVifV1qN?=
 =?us-ascii?Q?L1LmTxAvBiip9IviK8TkaBMkAkmJrvl/NcYWR1L4sOihr9FU5q1RgqAw3a5F?=
 =?us-ascii?Q?RPi1hplGYiO9s8juiCpW9EcGf+w0Gv0ZWltON3/yjefNVh2AL2ZCPlObIAuA?=
 =?us-ascii?Q?AG8GmlhH5BcgkMsk42tpTj/0jI667+t7pNu8vGZ07h8pdn9fzLS71BwV2lJT?=
 =?us-ascii?Q?gjMy1Y/DT8/z3iwQ5v+v19somnrZvFp4yyWE5/Winl3J+JonVmkJCZlNubvq?=
 =?us-ascii?Q?Lr+nArRv1A5+McGTkDZ7Qls3ldvgd4apPOjrfZgQyq7+/iHTK8dwF1DaJcH7?=
 =?us-ascii?Q?FRyJ8Tzyi7xGqMDP1TIbBZ14aHduHAEHg2FATS6Ha072SdQq7N5l/OrZjo8H?=
 =?us-ascii?Q?ykSQZwx44Cg/AT3YIAf6VCMX7zRy1qxkLo8fm95Sj85iijVb2smSX2OB1LW+?=
 =?us-ascii?Q?fuoxb/mjOJXYhKCKSeKOwbeipW20oH7ou+iPyNdoW9PnhCdO2hjrmQjXdzDG?=
 =?us-ascii?Q?14VN0s1llEpHyytSGPRemdT+aHb496d0CtATv8jbDs+6S3+7xeOH8uvISIWN?=
 =?us-ascii?Q?7XIXl/yIcL6H39jq6l/T8Hmx4OWPG17FEqE7lKyKO7uyvzeDBO1JO3yGZ4Ha?=
 =?us-ascii?Q?z+1cYYp+6uaIH2RWb48gFoxDRDN74iriuW13GD5YzPULDW+8tYs4GbXTfvxn?=
 =?us-ascii?Q?HMIKg1Wua1A6JsoWbVb++ra+eUFoX5qcXHGxj8bmMHxmK802H+gIGj/Pbr7O?=
 =?us-ascii?Q?MncOXtVE0JzAOZU2MQrlpN3wIS1I7QzegiYULYEHq/WNAMf7spOpyQuixJsg?=
 =?us-ascii?Q?9CXEUVkxlR7tQqaZ8VDzJT0sec8HR1R4WouQt05b+Sq5GGwgjFb6DRgdrqPV?=
 =?us-ascii?Q?CDpZQkcrbyW+g4XeOlanpra1kVDtt09z2d/J59LC2TAn7Rb0l9oOLOVPCaLA?=
 =?us-ascii?Q?YFUggXf7qK1HXIcPUrLmHf5LTK26TMkJBcFjnmkbTcOV8Eivtdlt4MX9Oac+?=
 =?us-ascii?Q?0JXDMQ8sWd0m9/lG2AKTBIwnK8kOfbOrv9BViOmbwoTlLXDgbvwnUYK8sYP4?=
 =?us-ascii?Q?XfLAlNEDP25P3Xchbl1MiXcRrNq7xPHQ7sbPm+nAGuXmgqiPeamw/4AjOjgF?=
 =?us-ascii?Q?BVi9ENO9RIXxUc4S0Q24m+bHxzYFnTZwfCJhjzmBUytG/GDRJ0Z+Wwq7qAXm?=
 =?us-ascii?Q?nFV45SyEyiLjcG1JEpkO641ZG7rqJdNvHAlUyfqMmFnqZps4ePlQqbDT+Co6?=
 =?us-ascii?Q?XRD6tUZjgs6LX7mAGUgcQIEexywJVn/0u7wVvg3+goB3ftbxQ+AztSTUtS1y?=
 =?us-ascii?Q?fFSASP/8bQllQSAg/8CFD0RyoIhe+T2tAyiL1Qj9fyXA9sFFUTePB9lTH+1b?=
 =?us-ascii?Q?8VBYfuFdg7mhQLGJLuyeHOS//XatOsHITn03CkkWSBqWXP7kBFNRkePrwjlz?=
 =?us-ascii?Q?jYsV+s331ycXXblJrehbG04kM4mEiMLzsZKKTJbj8D6y9ihSa5GhugLMWZqm?=
 =?us-ascii?Q?wb8gYPjYFplDvfDa5sGUdFv2TJivsqdL7yGiuMurPSOIoHiIXDQx+WGXyyP0?=
 =?us-ascii?Q?qEjfVmjrvqInj66PIMEDozgkqyYsFt9pqtPQvdlNIG+ktYSZU/LyGrWBaUt9?=
 =?us-ascii?Q?WQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2596c1e2-5f29-4057-e36f-08dda2c06220
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 17:02:12.2726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9x1DlLm4Bk62pg3s04qFqnpIOz25WON3hmmVEE7WRvR4M3cgQOEA5xl5hWrgfDCAAaUD9ymyJMYzzo+TfAyBbinSCKiMYlshp6VkL/w1e24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7642
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

On Fri, May 30, 2025 at 02:57:13PM +0100, Anatoly Burakov wrote:
> Make the ice driver use the new common Rx queue structure.
> 
> In addition to 16-byte and 32-byte descriptors supported by other drivers
> which we adjust ice driver to use where necessary, ice driver also
> supports flex descriptor format that is also shared by some of the other
> drivers, so add a common definition for the flex descriptor formats as
> well.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
