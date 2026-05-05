Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CEECD342F
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 10:46:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E22F040667;
	Tue,  5 May 2026 12:45:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 4B5DC4026C;
 Tue,  5 May 2026 12:45:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777977958; x=1809513958;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=AHX3TBtrMaUNq2uGeJJThzWHdRVj0oeAmaLSk13V3B8=;
 b=gPtBgey4tU2lRIVIENIps6R71tMkFwabh6xux7doJmrr/Bf1UKlGRQpt
 WhPoCDoaW3+mCGywWv1csDzFdVe+CI+iuW2UjBKBvzh6G1KLyBhYUeOHJ
 9co62+w9XowJNkj2O3f9PtvW2bGxHBPazndcNu3Nre2f24K7aWTJ56Y/X
 x435Hb4hJ5MBq4gJ/O9YiG5dHnDwoj1NfqPd6Bn9gLY7R9IwHea7tVrXJ
 4RHUzdc9X4OtwW/PoB44d9nyPJ84yMvsjqvSvQoVHQnZxB6r1n5nitNH5
 CF88cT/MMT9RJKq1mZYG9rmaVbMp9Z2EcJWjss4ktiLpNHbHTboufGPM8 A==;
X-CSE-ConnectionGUID: 2q0hFB9eQquXPZ49V1u4hA==
X-CSE-MsgGUID: QzKrrouyTe2EUg61Mh9dAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="77867010"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="77867010"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 03:45:57 -0700
X-CSE-ConnectionGUID: D+mKJiXhTaimFeb/PpL0SA==
X-CSE-MsgGUID: 7TCfiZo8T/q9J82kKWTdrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="240075523"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 03:45:58 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 03:45:56 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 5 May 2026 03:45:56 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.40) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 03:45:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MO2MxNgWe4swFH1njcoV/M/1J5R5rAjWrkv/rdvcEvDqPIRe4Hzbb6s/nuGfz5vi/D1xbjENANZ6VbKfvXZ2/pT1j5kzryasYt9NLu6bOlXSd4MrHyf0+YOBRYvW5kbT4HzEbDWQfYCjrMIx3iQ9S2S8zMbjI5m8wXlxqQL+YDVth+avDyZxFSGEU+WBWOJ/yIHNAkIO2r0GETCSKNGUBXVsaLd8Xlbe30qbs9NSCDZhk+jXco1VLy87EHYK/AN9TE7K2+Uyu3tRzOvb/15xjSvqtKav9clkUHxGYDYir2AIDReovVymgUavj5w3AuphT/3zoB2R3+Qu84DLIcUooQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29Gw/2xMVGOCPkIPfmXZyOIzz/Bx5K3z+iduBZXD9xE=;
 b=nuc9lBC7k2iNZVczpLt1HWLbja/5VeW1YhpMg7r1nms7KsV6NxZ9YCcgk+DbXps6i/vIu9Bg9sqAG2F4CRYVHh+DrOymVJwBn0pdZ0Zs6Ia9vre46dvPadC9PZxt4tm7OzOH4yACRmPxMR+5/fWfnHhkIVRIULRkRlqZ4ra+8NsilrcE+oYcTyVvn0Pt6QxECv7gP5PWNXHsULH9wrqbs8bIcEB987CCPHEtgdBN5QjBWxPhBoc0zg2EompVutDRBYfndFZ8bY3G2HeXElS9N1Jt4I78FuOr7L9l0ubQ0vBQv4GCne4DAAZgoeXB/EqzTJHaf8tSbLu9oKn3KSAZMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM6PR11MB4531.namprd11.prod.outlook.com (2603:10b6:5:2a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 10:45:54 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 10:45:54 +0000
Date: Tue, 5 May 2026 11:45:50 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH v3] net/idpf: fix multi-segment mbuf leak in split Tx
Message-ID: <afnKXmOH1kHSXbGs@bricha3-mobl1.ger.corp.intel.com>
References: <20260312110133.629246-1-shaiq.wani@intel.com>
 <20260422082642.882407-1-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260422082642.882407-1-shaiq.wani@intel.com>
X-ClientProxiedBy: DUZP191CA0047.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::14) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM6PR11MB4531:EE_
X-MS-Office365-Filtering-Correlation-Id: c95ee267-b392-4aa4-f327-08deaa937bbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: gWAiYfFTueDYuZaLCaRaxxigOxiAMOOR2S9tLxUsN6qUR8uWNcw7CndHkyJ2YqKHNRMU8Tt4RIC5zY2h6VmIOM+Ro3/K+u6jUzMaYRk2p5bksAwdH6TRx/0B0R8cjIYmat8ZFm1nx6mjAS82WDO06N75NLu2V6apxlmU8zujneAYvSmQv6LnrAdBNVzkK3dQj74FvWIsbDe7O2UWvxoyrySA26R9pvsINac7mSM1z2DmoxQkzxqHcH311DKVtRD58WcIAK/6khXz1JbM+O85hqsDzYa4L4MQ5FGA/aZWmsYCd1QkZvm5uo9/ma/MK9wbzheY00S9x3sBzW3UV3TC+EEB1lOr5AfXj6u7lrkezSY74qLxZpVtw+7Nd1Kdml1Wvtov22CIC1vwY8loLVmZ2lGVls61Z1VdHN8FOtDdNRZEqNp8ZRxuz1y77wu7/RCIwMXE4u5h9Lfsa28C14dAsaDhJjqWTWD1RhSTbN2WGiArFxtbjDz54xs6uaByKYtR5neXuiWviih6SAq2l6kbJkWaly8IRl/20CJGNfSeACUrEP9jK+JV6swuq5Z5d1/zSOX8dj58J8Y0uZO+6JtVKyVf0JsIutFV8hlQfCcq+2rd7aWtPffoyJSrquDdJyKBVZ95drz2JpGTi2GMc2Yd3MT+exZROh/kGNxwYgkJfxXY6aVddpc0fOeonTW6o6sU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1vJAKol1T1fRZ+aTHBh3427luv5CZHbH3o9JjtcAuik0NzYQk7we/doOMia+?=
 =?us-ascii?Q?DyGpwA9zm4nuHk9JzDWvRzSE+n1rGwD4h0C8jRVY30vnj2VQeBaoqefO0WD/?=
 =?us-ascii?Q?hydk1MLN96EaJDzkYNmO0j+9K3W56bN+KVUoATQzu01VkiNmi9sny4Dnol11?=
 =?us-ascii?Q?f3HbG/m69attoapcNke4qlDHCQK/2InNnkchqm5EK6kwoW8XNRAloE79icaG?=
 =?us-ascii?Q?7u0qFWnAFCzUieo/dr1MiKyi/y28+5sU0n3ViIEZc1RbQAAap6GiLrRZ/VOq?=
 =?us-ascii?Q?shiOu/K/dT5Iv6y0Q/8LVv5nXF9uiHx/WTx/ROeLJtoGiWTMXdMYEUCdY97g?=
 =?us-ascii?Q?TJHL5UIdHZD8+EGoHsjykUaw54rWr8ysHO9sppZ06UT8cxbTn0pDWLQ8+SVX?=
 =?us-ascii?Q?pE4Z3cWQfWtJ8PnGNdxs2C4OUb62BGNmewJ8G7yeCOlj64Y8JM/WbbeXEiW/?=
 =?us-ascii?Q?1wWDhfeI5iQn45z8R9EgZJkFSmVCElLx4CAApuNLpEwA+8jxKDW7zXmSmX8x?=
 =?us-ascii?Q?B0GXrBmGVytM15NF/R1qu1n7ktcMx2LsnHOotLgvMEjwg12FMg079Rrvn8gK?=
 =?us-ascii?Q?T3PG771zgGMXTRLjMRSLTL2bEQVq8TEAhLAOisJ0WjaKHIGScv0FK25Y5gIO?=
 =?us-ascii?Q?sKRDtBFwNtnZveP/6JHW0/TX9+mlw4AcoJv7KnfmwFij3FCcuna0I9+9G2Tg?=
 =?us-ascii?Q?kcPF0qysxpTW56Dse7mJgg9jEngi8EShilYV2UWGWzpQe6P4lk/E1FGi8C7q?=
 =?us-ascii?Q?dT/eowSZuQXKZAQVZs0H2H5x4ASDYDgbdM6iSWIlm0UHgnPnhh47d/5BPHKv?=
 =?us-ascii?Q?p11pfBSfXJ3p3X8/bHuLHFtPa5SLMak4fz5PLn/pDufs7lfOdCU7dyj5EKWv?=
 =?us-ascii?Q?XjU39LMmyYyfGCZ4qDJcFi9d4hX8H4CxWxbPsJAs+PLHlrv9OnboXKaBDLV2?=
 =?us-ascii?Q?dn4WFXpE3O1Nsm4lkKJkd1wg2z3SWoNLp9HIwZejOWgvlTE9mXxuVqswIWaP?=
 =?us-ascii?Q?yXCP5Db5LQvSMPsu3YUEfQwjeFZFzjWx80Y6FdbrBV0eIsU54LxqZ7uAonUr?=
 =?us-ascii?Q?2zT5xmFJS+4txyKhqLshZw2/ehfVNcw7sbo1PM0sHIc/tyfGVGceLck1bwEu?=
 =?us-ascii?Q?bX6PS2tb66DSihtd9ZAFBHFjFhuA/2atcpM2CBJzoHV8gfgkQLPME7jPks8z?=
 =?us-ascii?Q?QTVPEizAeewJc6D3w1HAtOU5LTrgEqRGvD3C6dLzGKLjWvYvhCM69kMKot86?=
 =?us-ascii?Q?Sb0rhuZXq9JHjPOJ7aDq+8m1hDNrHmsbaaOXIpd7EGov6U/xO67sDuoJClm3?=
 =?us-ascii?Q?LyJ+IJuWTS8G+c3+Dnn4YWZ3tD2uZvaauXnrQBBfMTuVqqJEGFFDOFm6He7D?=
 =?us-ascii?Q?Cp2FWX1IOwYWeJbu8TVeucaIkn5xw3e/qC+EdANUle8G3Fr7LOqw3c3LvVVD?=
 =?us-ascii?Q?+t+bIFTzn1Ec0dHKR1M0IOikPwL/e5E8QTom0B7fXHSIS8I3PEe/qgfCWcPR?=
 =?us-ascii?Q?ublnmDwNQ9J+NgOf6CVhuYXp1n+1r28mBuMg9qt1X4t8buj9W7CvyBzr7988?=
 =?us-ascii?Q?cv/nQdqsZQddLen4H8pj3gFllxwU4G4DE3yRSePOgBD1r3EtPzPzYNZ62Uqj?=
 =?us-ascii?Q?ruhgmgs5OzLIiBoWZ+LqLKMLNAtSWrQOy30FwQ8edamfbgxbvchitq/uA4F6?=
 =?us-ascii?Q?3yYSmn4CWr4+LieTF0PkeGqVOEn9tScn5DUnLcxeXN+KtMSnws2cmsnwRjrY?=
 =?us-ascii?Q?+drF+n8djvakZf9D8iznU8XADw+0M0Q=3D?=
X-Exchange-RoutingPolicyChecked: AF0x0Yth83BO7MmYLVphS8Aj5UkhEip5jT8/8vagSCheHWz0ysvaIoxYbNNMcZFYwBIOqVUB+zgBjDh7Ml4yS/6WZzLIFdIHK2QWk+SeG+JXImXFvUbdv9fzYPta3jRTsXoOxpLo22+74vml4QfO8Bij6qDVWo8pk/2ipnF9mNb2UesyZPzzD5qeJHCH5XSKWMSMyHytTjuahgAZv6RnIXp0sESl5pJK2SNdKtbb/Vvfto2MvLZd8F2wi9/1TkJBJIjsGYNIqbGpLs5bFyceOKpxcvwbDAe1iBJlBExv7LkMO/iY7ByKTa+JZXrJNNcoEr86Rm+MWx8NGMF2ph3D2g==
X-MS-Exchange-CrossTenant-Network-Message-Id: c95ee267-b392-4aa4-f327-08deaa937bbd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 10:45:54.7989 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KfqN94Ejrdga9shwrgOy6gh7/bnPd01cLuPab1iUxjiPA7uiWnv/R8v8B1dRoPPXxQ+9QTZIImquLc2JDlwYpLrjr7xu3HYpbjCtiqx3e+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4531
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

On Wed, Apr 22, 2026 at 01:56:42PM +0530, Shaiq Wani wrote:
> RS completion only frees the EOP entry's mbuf, leaking preceding
> segments of multi-segment packets. Add a first_id field to the Tx
> entry struct, record the first sw_id at the EOP entry during submit,
> and walk forward from first to EOP to free all segments on completion.
> 
> Fixes: 8c6098afa075 ("common/idpf: add Rx/Tx data path")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.

Thanks,
/Bruce
