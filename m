Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE28C021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 09:51:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E677F4029F;
	Wed, 26 Feb 2025 10:51:32 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 121FD4029A
 for <dev@dpdk.org>; Wed, 26 Feb 2025 10:51:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740563492; x=1772099492;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=V+QJAL2SCuumb9oL2n8glJ8p9UWj+bsr58vdHzDHhIs=;
 b=ZC2qD7hUjmZCLWZE8qK8QoiygTy1g+IZbA0lMd2PM7llQFOGgCBoqpyo
 1UshcLwwfXSdtfheQv2AMUFMz2td7XMt6dOwUFd/89EHSQtLu+bozaJN8
 uZhG4CC9L1zTN/XDHxfuRIKf7kMmwBQmszDWgsjfxpEdc+BXW34/ArWyM
 SBtBk1IaFhV7XoDRB37F8wK3Wt/cqjMc4PLynS+2pN8wERF6KzkSTulDw
 Usjw8CNmkLp64JXjKkYnI11e+5BavLNX5mRmYRDkMD4CzKBmgve56BtWL
 fKgGPeZC9T7/OkBhSXOwZNc+8ZHdaTuhZlK38Y7PmH2kJXp3Of937c3Ky g==;
X-CSE-ConnectionGUID: XUsz1cR/TbOMq1Zvh7PNiA==
X-CSE-MsgGUID: 2p5rFriBTt2VDvL6DfClDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="41653588"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; d="scan'208";a="41653588"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 01:51:31 -0800
X-CSE-ConnectionGUID: r9phaFBkQNyAJMysAlFXZA==
X-CSE-MsgGUID: c1T9nKDoSaWb9MSEdT8WPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="147568526"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 01:51:31 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 26 Feb 2025 01:51:30 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 26 Feb 2025 01:51:30 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Feb 2025 01:51:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bo4u+jf09Pl4VcBtiJ9DgUHsALXQaEMW+EnH/VLw2eDxF1WFiw+waZ3QyuagyCa40GRaFLv1Doh+PZDYkK761Y1AX7YiiwlHiKL78PqlAzztpLC/NIPpbk024seQuhOJUCoqu6u2BB0Q047m/GIgqx89bnNf0+y3zbhfP1NJy2fL21DUGuB8cjYQW/IfP2K9esGDU62PMkukka94hyj2DKmPLIEPoxhHiXW5riV5bMuCGgaGQtTBejhTehPR21K0YhnHGig7fe5WCngx0TY+ju4WCj/8NsKveqOtwFf/jT2zo1NJL3G6gnwH3O+FoT1jzMzcJj/IWZrKmNyfgXD69g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vH81CpIEzjoIqDdmymywlWay7SwwWLzehKcH/eylN8=;
 b=sL65CM7KC3Ze8VKJoOPX7ErOw/Wn/Wds3irKe69tJ52By6SJKZcAbgj4+rcT9m6XsciPrL1VhhLIO7O9FegfKZ9ZJAdW5RLrI9TsmCo02ccbZlwbfc3aPs07EMAx1kWS1KL/8LN8h4jOnZwI9yHn8LYNDWOELXM+DxirVkrnET9nzC53de8SSr1GFPnuEtB9LEfr5Gnxv1KLasbXaiS/AApd79u6msuBj4kJYWDPKjNErafpj4lrPNycjETeEMSf7ZCMKfXxa6zVwgdoYBsD2RGKYK8f3payFNKLig9YfGrYHuwIlfhrkf0qHophxGDD+fO2b13QJ+9ym7XQBXpSrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by LV1PR11MB8820.namprd11.prod.outlook.com (2603:10b6:408:2b2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 09:51:00 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 09:51:00 +0000
Date: Wed, 26 Feb 2025 09:50:56 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 1/5] eal: make compatible with instruction set updates
 for MSVC
Message-ID: <Z77kAPRl3W0XeaIJ@bricha3-mobl1.ger.corp.intel.com>
References: <1740430879-17874-1-git-send-email-andremue@linux.microsoft.com>
 <1740532016-6789-1-git-send-email-andremue@linux.microsoft.com>
 <1740532016-6789-2-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1740532016-6789-2-git-send-email-andremue@linux.microsoft.com>
X-ClientProxiedBy: DB7PR03CA0094.eurprd03.prod.outlook.com
 (2603:10a6:10:72::35) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|LV1PR11MB8820:EE_
X-MS-Office365-Filtering-Correlation-Id: 57e03e66-5908-4686-473f-08dd564b1327
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/e93Jw2n65S4UAQiDYUJDiBbwkYiGcSscXPKosRdj1QFAvjtj/iBbm+GDtOc?=
 =?us-ascii?Q?jJSN4LIflljmmEW3s/eDSPJM0XIcOt+OZkLcQ27dhNuKA0qTp6ID/j2Vh+RX?=
 =?us-ascii?Q?c1GifUQ9eDS0mlO32TJ2KMA+Pknk0rMw/KitJVzmxoODrk7AfdcVigO7Q0a8?=
 =?us-ascii?Q?UYmfNLDSgEYFFB8rCW+a6Zb3NdACoKVlLW8dy37h6MN1M5NDx4nWWBd7rdcc?=
 =?us-ascii?Q?Hqwia5WhvzxJ4CJbh1zWgK8QYbZdlDDy78ZijSl56Zhnd3H/CVat/+pi4G6N?=
 =?us-ascii?Q?JXAbVYHVo99ST4vN2AO+dcyMZGgwvFo9VuJ+IioWVzpOx7ik+QCHA0wEOSiN?=
 =?us-ascii?Q?FHOpgMxrDmHMDkQPjI+24DhR7UUYYKd7F21loNY+MN3z8P+R1tTSFzo+o3Gq?=
 =?us-ascii?Q?/S/5lOt+b8Kbsr4rlmWbQf9neuCZFPS+7IqQPrRbqlpA59d8b+a48tMP6QVW?=
 =?us-ascii?Q?1eHA0payBnSvNHKa4SjEEm4ZsvnW4c2lNxMhTZVO3hqKnG2893UVxBCEmJE7?=
 =?us-ascii?Q?AB+9PtUy/k+HTOthzDil5H2YJrecimvA2d3PrTKjEMH/t9wFBM0F1U+nmFUd?=
 =?us-ascii?Q?7Z6g5vMW7SD+sQyFHO/OJreIDm5keEsufHSpVuwRu9sOXjYYvMbuUU8KQ1JH?=
 =?us-ascii?Q?roHhW5bKQMW9XHqaMibHB/CDujrTJ2D1JtVpjMNAsQ1BPbwMcxLwBN2+G36w?=
 =?us-ascii?Q?dhGwt2Z5+MY90B61mrvKK5h6wbP/hKB+Rl+CmqqD04ypg9NPjqdXq66s2ket?=
 =?us-ascii?Q?ScBObSTQ3xNl67yJEkARWf5xV0ukTPrYlyEiy0V3LzLGWddZ1l3jp24aNXQe?=
 =?us-ascii?Q?XxqwnaPv0AoDc5wSMXOR6zXqpsHZrC6enUAJoy4//VayvV1hQqrmeqoxyIVN?=
 =?us-ascii?Q?a+Ose+w3pmbDwzyW6XFG/jx6hlWTgqCSlLFO8yWF4T5s9E5MXwFz3Qd9eKEn?=
 =?us-ascii?Q?deTpLbdKdqaRnuXIi4kXMirima5hERCYDs3LeI/SfJDmFAAaRIOctbeERFVu?=
 =?us-ascii?Q?/flCOuef1YBijB+ksavGK5hiFOmsqv9PBiiUswxIhG7VF+8eZ5T6D7UtAmKO?=
 =?us-ascii?Q?2V4ZK3D4LmUS2GM8RTORNLvGls+CNC7KTubIPEVnbTKfJyiV9Hh1iEkiOw3x?=
 =?us-ascii?Q?p1FxKJp6RuwmztT0pVAebFTJIYsNEHlYH0SjMYFm9NTIbp3golB4DHpJbKPx?=
 =?us-ascii?Q?iplFmSdCd7D0B/DPIauDYp94MLyjE9vHK8p8T7zlNYYnZcW1V+a4rc5bGjgR?=
 =?us-ascii?Q?1YcLGUNlMJxcYF7C15NxfPx1XZH5rZJwtNLaB1NIgPrtGwi8m+4bZpycxWjc?=
 =?us-ascii?Q?HHSXIu0+7mFKPobY+YKvbR/o31n81QGCzhaOIcdu84s5bsBD4aTHNHKaylE7?=
 =?us-ascii?Q?b3ZwG8/xyxdtIBISjsLnqJxKLaqT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KHYQhQRi/ffmlyBX4tZ4sS7a3e7sFODgQav/mWrH117r7t/OM0bSYigG/nIW?=
 =?us-ascii?Q?O+bX7sggeKmX+RJOCfhhO9AJ0IjgeDqW7XeVTv/FpiJi69Kss4y1w8SKs6r+?=
 =?us-ascii?Q?RxzzkigXz+zNpWnl1hS9CHMdcu3NmnJMBhmQfZAn2+u81ZZrrGAPW51NFc8/?=
 =?us-ascii?Q?xe3hdT8kBCH6FVfIvaTXGIRgr3ka0mz1S5e9RTFPOiaxEdbzM30mFy+FkE2z?=
 =?us-ascii?Q?BPRekV3jljjrf9k1Nzxj2IgcgVM577+XIy43U58/t8zFZ3oqn5D3ymdp3qnM?=
 =?us-ascii?Q?hN5LqFU6TkXEJD80LTrEje0hq761SHeK6OdUTJ1cLl0OXcmGHOek+052hG5i?=
 =?us-ascii?Q?fiYjxRijBxHwB5cIngVYU1ccPSLXp3NpYv8tzJEqUjR0u/YZi2EFAXWb1ukL?=
 =?us-ascii?Q?ABnjlRpMLboF2X//nXS63ReuaJJj8bLESvlEOuuQqJoBx5JFJHx2bQ0iJhOv?=
 =?us-ascii?Q?S9/tJUq5W87sXzch/0Hi5mB6W5LlHERC4QCZbE63UlYKyDkt9qiPDy0/yGjf?=
 =?us-ascii?Q?Ypq1db4zzG/4UYnooufuqgZ7soAcZYj4GTrZKwRoCxtumXCG7e06YXGxWZgz?=
 =?us-ascii?Q?6JOaBz3fxV8VW5coiq90zt7JeooM0Z0lEQo0NCZPL9J7sl79dpYYsvE+Bs7D?=
 =?us-ascii?Q?yN8RKNSYzKHIoNtIiLeHA68V1py9SQQsRVxtxBnpYDD6LIBUa5SQIzqAGw1V?=
 =?us-ascii?Q?FvkKDjmEJcxd6SFFeOpQYBolhB4E2tVvlglcNnCzr3BXwYBsreGIzd08YYYz?=
 =?us-ascii?Q?d7JJJ5johUA1+KNJVnSjGqrogyZeF57PbOmhcY0Qbi8GPqXGEjAV58xxioyf?=
 =?us-ascii?Q?lwIIskcXOnGV/jxR5IaCor2YHqYue+6g33h69uF1fPxHgZEFy2iShsU9mq48?=
 =?us-ascii?Q?/xCIw1DQypEoPhgoBVKYGGwLOt+RazCxxvbFFwRp5Bj2kVBbt0X1qjSVlDKn?=
 =?us-ascii?Q?3d5ZzZCAuW7zs7QlBYfBVJ976QVTqAtdi345rgZMliZG/G+q18lOikghxqKo?=
 =?us-ascii?Q?kSTuZ77631ezgbUgd6dJCc17z7pl1HVPgW+i1zggMJ5qBSRFyLLasCCPChsk?=
 =?us-ascii?Q?9dcVGOi5qBU7qiQ2gm5hvyh8dI+vP0jNBEZLp0G/yL3i1eIiX1TzmZfLDjwq?=
 =?us-ascii?Q?lubQikePcfPjhn2/dgVIh9S/pV5VRJeqsag3wPBLfICUiespjXlWohuZIIbc?=
 =?us-ascii?Q?Id+eKUDi7lh048m/enukVj/WIEuiilKwN2xveUoLa3DXkrzJiTXF70EdP1N+?=
 =?us-ascii?Q?9KeL1MdNM3tJ9owkXZGgFGGRxfJS7pAeJzWSzOaNxdHMved7KOx3GePYkm6t?=
 =?us-ascii?Q?8OSiJCo07W6aMjJKHTWVHTnUrflL95U8JS0f6w4U59V16GOy3JbmvJrhRhq9?=
 =?us-ascii?Q?pVu58Pe3kJeUFe4jNxflzCYApo/7SI4uXM0liAKBMrRJBlZ4jyENV7QFsjCz?=
 =?us-ascii?Q?3O914WgNb8Yomxhx1zi7QCk+g6RT0dgva2979E4V7BMYJwLEf2KUJ9Ype7dB?=
 =?us-ascii?Q?LhBWoOuOteQP1yx8DBSel6g0NieBfr+mE9r3ysa6Ra8kPWmafo23Zw/mg9An?=
 =?us-ascii?Q?8jDvkfE+JSB9+NEQdBAVL4QXeka6UhUa4dp6xrAJeLbkkslbfHBqMIu6qtXn?=
 =?us-ascii?Q?Rw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e03e66-5908-4686-473f-08dd564b1327
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 09:51:00.1195 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tZdqYlIoSP+FRM3VmHelccdl2cR6ETRWPaGTY4Z1X7VSwlYzMavqLQGuQLcjMElChgkHra0BXs4Y3VLEDDvsnEZ9JIWmnlUwIB0rikm+yv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8820
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

On Tue, Feb 25, 2025 at 05:06:52PM -0800, Andre Muezerie wrote:
> After the instruction set updates for MSVC the error below popped up:
> 
> ../lib/eal/common/rte_random.c(6): fatal error C1083:
>     Cannot open include file: 'x86intrin.h': No such file or directory
> 
> The fix is to not include header x86intrin.h with MSVC.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

