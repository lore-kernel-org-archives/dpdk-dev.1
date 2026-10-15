Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF71CCC6B34
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 08:53:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A94B04025A;
	Thu, 15 Oct 2026 10:53:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 8E23240041
 for <dev@dpdk.org>; Thu, 15 Oct 2026 10:53:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792054437; x=1823590437;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=BsAscUw+QdUAVUXCkTKbbjmS7k/OBXs4C0MBkxYZUgA=;
 b=auTbwoElaQqTDnmUCVBOQpqGFPFOiHMud9fwTlKnwd7tv/FrSsJ+hKD9
 9CV4X+Wzm1xAUjbtWMfgmhiG9u6k/KDZdK78X3skJ5UwiYxc0FknMVR+E
 DtgfGT/vFxVWFnwnU1YpIv6cexu1Isc02Sgt3I9ZcNSWzdDxdgw1I+/GC
 ZE7BChBZKsVQTd5XSpNHXnFAwW+kuoWqrqYn/hspeu92gbcOF2+jaoHKb
 s2QEo9R1AHjTxsWtLbZMEW4GHHVsMFDDi33QRiqX+jso4MM5ssP9LXD6u
 SF+Npn2dPXc/S2+mlPFv+7/FtT23SrqpAH5fXVUW4FfRkhasKkNlQCjed w==;
X-CSE-ConnectionGUID: 8mOFKHIdQ+ucU3ZoAhADfQ==
X-CSE-MsgGUID: bImfFHuAR9ixeJuptHwGsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="713517"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="713517"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 01:53:56 -0700
X-CSE-ConnectionGUID: iaSl+Xo7SfWhE6eWIxD2mQ==
X-CSE-MsgGUID: r/c9taTBQVyDB/GSWHe8JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="1546014"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 01:53:55 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 01:53:54 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 01:53:54 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.28) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 01:53:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=npcCZkodvgqNxux8S8SfXmsel9nJYf+K94gS0SyhQCad5oTsh25t2FhK28nq/gsUvMaxFHypfuIJlCHPg0LVAOeLWv2RbU0ferKsTsF019Eal6fpel06X5RsyVDBz2oeQnFojk1q0fNcklFyb3jmagj6lIQhxYosIP3GxQ7YUjKDZOCVLwIJ4sAxp/zadAQmRdgNA7G5cgaAzgclIPsgurgBPKHV3WvzbKAGxSJTYimYCjrY8L7py7GY+1F9QmDVFAdxLcp7vY48/2KNOjRVk8u36cePxx8mYOTuudZW5za3E38Hed4RT3aaki5CYKWR0HzPt/tvayDdGkI+mOI1SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LY4kyX6VPtl4JYa6Bvr1e+fOWj8wR8axMB2LcLrHBbE=;
 b=MsKBgvkmpzvnv4NctsdTg44c3JtWmLwqewkf/5BbVxVkUoRxHhw4I2pqWvOVBtpnRsPRixGgT9K3LZzOfYnV1SN7i/vVOKMKLWa1P/0UTYUIuhG3zk5zOTGWVddFwC/CgjBXMYOjAAOAvDGqOXlo0eMACGhLQdTUbD/kw68bJ9fG8ln4hCGIO2cSYPLMQaLlfFlUL4GK2Vrpxpbz1JThuhCs6STv32nP7u4alVvyB38ar1hauGZlBbr/jqAN7EgshvR8QXgl1w69IFBye/x0kSGpFQWb+isEcOW8UKuH3F6aYomtSuLPmcGw8r4r2POePlr/Ax97nVRH/pvQybMiWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 IA1PR11MB6073.namprd11.prod.outlook.com (2603:10b6:208:3d7::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.21; Thu, 15 Oct 2026 08:53:47 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 08:53:46 +0000
Message-ID: <0b380d9d-f7e1-4521-a548-9a9163f10995@intel.com>
Date: Thu, 15 Oct 2026 10:53:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/ixgbe: avoid private driver include in testpmd
To: Thomas Monjalon <thomas@monjalon.net>, <dev@dpdk.org>
CC: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
References: <20261014203435.583064-1-thomas@monjalon.net>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20261014203435.583064-1-thomas@monjalon.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0187.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::16) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|IA1PR11MB6073:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e212e82-fec0-46ad-b289-08df2a99d2d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|56012099006|11063799006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 4rDjcnT+wgx2MLb0v+ZdRI3QCGC3q/B54wwWIOifKw8usaMv0RR5Z2L7PnsyM1bN+Uaskqb4i9zDU/AmgTBL4Bv49qcfTUUwdYoFIQ68DvwlICv5GkKLHEb1wExsU3lyEyfzww4vdPiw05aJZTbPVuTcKxOqboFzFAgNAfKzebfBdHxl/r5b2FugOxne3pJBxUnzgFJLgFM4KIJRSduJszjSTzC2enXk/xrV0/BrI+WuZWDRsYf2JTVJP8t0BseV7f7MboDaZERXQjYMLEhwz2b4TaZd3xBcleOJErUttyc9M/8hiB0fxz54sZwc86ob2GYMDLkza03qMWqYZTswQHuMkmX65ClKXxmg2bNfS7ayl9bCOL0SdPKoWErWinq+L7dnK4y4PNkLp2IAlpD/IG0Lmy6fsA/THlaf8ZpAr4GWhXfQBSeTkqRjA5DrpbEXWgCaq9CwB9xrnwtF9K8PquLrbw99PnMhRsiz1qpNDewSsAbXW5W7XO1IWnfp67kMEWF86BzYIKPGwYVyKzVR5qo/839WO37LhB1TErCL6dHi4MfNKRkrFk7O6Mc9l6h1E9AOTBS94CCJ1QoJPkU/Wc4vfZqwH1Cqjum44u87DfLXoKg2YuLre7+O5Foi0aqosNGb372sIr5iTRK2v5F4DywnhfswA8n+QBeKSX73/wM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0QxZWtzK2JBU2hwQ0RwWkI5a3dHZCttMk5IblhSbjR4dWZDaVloc3JNUEZz?=
 =?utf-8?B?ajQzOXo2aVZvU2xKOHdPNUF3cG1YV04wdDBCcjRWci9oaU1MZjUxM3VDZDMw?=
 =?utf-8?B?bHlUd0lQUnhoYitocnBycHpoSDNVZzFWNHYzSEpQZGxCTU9aLzFSRjlkUDZU?=
 =?utf-8?B?YU9SY2dsQXhBb3U4TklRdU94RGQybUFlZ08wWm5RWFZidzRnQmJaNHhjSVVF?=
 =?utf-8?B?QjVLYWhPMm1pY2dkZEo5QkVZcGl0a0lvZ1NCdGZqT1p6OTcrZkFXblJSblBi?=
 =?utf-8?B?K3lMeHNRWWtZMWFFTEs5UDE4b1g0T3lURllDTVhaSnkzcmNGZ3lBSGVwWEVr?=
 =?utf-8?B?c0ZUQldJYzd3cjlhN2p3N0RUYVRnU2taZEpLcldwYVh1M1lDT1M1RHpsb2RY?=
 =?utf-8?B?Ti81NElHZUNqR3g4b1A3Z0hwblhGTExKbW96OTFteTc0Wm8vQWdqL09RbTBt?=
 =?utf-8?B?SzVETVB6OUpuMThHaGJ5cmNVRXdYUWxMMjR5K3Zta3J0WGpnM25FdjROR2JY?=
 =?utf-8?B?K2hXUTNzRDJhMy90TDNhZTMzc0lXekN4RUpPT1dzbnhKT0tvSXRiQ0Fya1gy?=
 =?utf-8?B?Ky9ENWljYXE2UTk4dis5UVE3Wi82VjhaVWNjanhiTzZBSXhQMXNvZVl0Z2dY?=
 =?utf-8?B?QmhxRkEwK3AvQkVSY0sxUW1VMGs3eUtuU0NHbkxSUWpWd0FqWWhlNFEvdmZ5?=
 =?utf-8?B?MW5wWEZpeEJNeUs3c2ZIYkI0RVd5blZJRWhNLzc3M2h5ckhQbVBjQ09Ud3J4?=
 =?utf-8?B?THZRMVdIM0xaUitvQlFsSnhadHNSTGtSQXA3ZXlWNUd4WlFHSVNBSGRQbXQ1?=
 =?utf-8?B?MjhlbWVwTGdRaHlIT3hzZG4weHpmaHNnVFIybFRKMGNxOWpzZjZKaXZtSUp4?=
 =?utf-8?B?YUpSd2VNZ29Da0M2NGU1MmkvYkRqbU1CSkZJYU9WT3pPTVpuR3c5Nk9xZGdr?=
 =?utf-8?B?VFRZbVdrMjI0ZmMwQmZCeXVrdG5JRVpIMmZlT0ZDTmdvUGRGNUtlQjMzMkNk?=
 =?utf-8?B?RkxoakRiMkV2N2REMm5kRFlCTHZTNjB5bklXVEZBV3EwVjlQWllWVGVzVzNQ?=
 =?utf-8?B?QjlBZld5T2NlYmZ4NzNhbm9zWjF0MEw0Z2RZTjBIM1FxQzFQbjF1Qmp3WGwy?=
 =?utf-8?B?ckdSWFV0NXI4QWI4MVJZaGg1R01TSXQyOFh2bmVlNVZRMlB5UUl6Y0kvU05G?=
 =?utf-8?B?SXowOHBZcTc4ZDRabW16dnUvQm1lUEgvYnZ4alFtYlE5eERDTzRiQTErMnpG?=
 =?utf-8?B?YkUwVXk5RnptZVdhRkd1SjRmWm9idlMyQjdEa2JGdzlHaXQrejF5UTRmaHBl?=
 =?utf-8?B?MVIzRkVCdWR3TlJYNExRWWNqQm8wa0dvbkNxKzJYZWs3Zm1FdkFwK20xVWFt?=
 =?utf-8?B?OEhHa09abUxMN0VGUW5zN1cxK1BDaHM3dG1xSmU2ejRVbHVnTkptS0pETktP?=
 =?utf-8?B?aHN6MG5hNHFmWkJ0SStMUWV6Y2ZpQjJLaXBsU3dsaUNZVlZUM2IvVnYzTXZM?=
 =?utf-8?B?SWwxOHAxeTFQS1A3L3Z2c2hQSEpJVmYzV2E3S0RpSFlYbGpNenhzRWxKdXM4?=
 =?utf-8?B?WWFJOTZMLzY3dUVabHdETURsZEs1d3RkaEFwTzZFanA4K2JGQlpTeGRPak8v?=
 =?utf-8?B?WStiMm9YNU9rSnlIUDUyMnZoU1R2VlppaHFpNjhVbU96SXRhRXZIbWpNS1RU?=
 =?utf-8?B?czYvNzRrcmVIVjRJTDBOQ0pRNGw1KzJqUVBmZ25peGM4bkJ1c3AvNTIySGZW?=
 =?utf-8?B?QmdLeEZJL3BRdWptNHNvdzB2MmZGenQ1VzNVenQ3WDhaR3Bkc0NZZWRXQXVB?=
 =?utf-8?B?MGNXMnVpdlRrdWJpcGc1L3RtM3hGYTBXKzl0WENkQlVtcDZSS2xHMTJWbTNh?=
 =?utf-8?B?NXZyMkI2c3FhanJhY1JqTE1nWXgwRDJiWENwQVNSNzZCazZRRVJyWHdVcXNO?=
 =?utf-8?B?QjNrOGU1a0FwS003M3puN2VkOUhiNXpUNEdidlRzSzVDOFVBNDNDVlJwc1Bw?=
 =?utf-8?B?akwrV2RSM0xtVm50bzRPY25qL1lHU3NWbzBVZGcyOVBoRTU3VjRSWlVQYUpC?=
 =?utf-8?B?TnFEb2Z5azYvYTV4VnU0QmNwSlA5bE53V2s3V3NZZVdsN1VNY0NpYTMvK0dX?=
 =?utf-8?B?akdsbzAvTU8wVEJOMUl6dEU5bUxxM0l2Z1dKQjVTSkpjcGZJWU05VTFHRTBj?=
 =?utf-8?B?UjhNdWtsbk1iWlQ3eHljTXhRM1V3Q3B4SVJxSTBuamI5WjNla0Y2MEtabWhS?=
 =?utf-8?B?dXErUkxSZzFrN1RXczZHZjBVTkIvTmRJVXFFVHFwcUxaTU02dTk3VGJKZklz?=
 =?utf-8?B?UW9SYmVyd0R3a01vMkgxQ1JCcm9rY1hqZXZFbXVHc3Z4RWRhUjAyc2VPazBs?=
 =?utf-8?Q?/BsIY0OMv/P4nx3Y=3D?=
X-Exchange-RoutingPolicyChecked: TMmNHNqgbKjoPQhj/lCyqwVfU8b6ObROIUYLgQ1dKGUkuf3KGW0Dv9CUg55hgi/s9Fp47eMvxtZ+OYMoFDYo95Z7C8yfQZ9Yfnbu/Lbrl2tbD/lYSvthaiWBMUoX+IEoJ39y9T63TJfg8muLlJc80Pra7jQj0U85UCnRXqqGvvefkdSuwwveTXbc+vUZPRXXI2qVl+/h/WkbDZ1zl1dei08zQFay3Y88giIi1luxyrl7KmmR6iSDrRZK6zQvwVPpgTqWvZEQ1qQeRuHGOLTuJTdTQ4yjogSUK5Uc0YNpahdqSs0YlFI+jWnyQFy6Xvzs1lTTcVibW9MoS9BSVoEiPA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e212e82-fec0-46ad-b289-08df2a99d2d0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 08:53:46.8701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BceDLrHX8CXyHFTNlWooLowoIxNtSZVHhDWsq3wKRZIltxxNRVabTJ7YnjjgAba95sx2x35duJLzq2cq00iAVeXoXuIF7lNcJcg0wQCgYQc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6073
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

On 10/14/2026 10:34 PM, Thomas Monjalon wrote:
> Testpmd commands should use the driver's public API
> rather than access its private structures directly.
> Note: ixgbe_testpmd.c should be considered as part of testpmd.
> 
> ixgbe_testpmd.c includes ixgbe_ethdev.h only to check whether bypass
> operations are available through the private adapter structure.
> 
> Rely on the public bypass API to check availability
> and handle -ENOTSUP in the commands.
> Remove ixgbe_ethdev.h, ethdev_driver.h
> and the now unnecessary RTE_LIBRTE_IXGBE_BYPASS definition.
> 
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> ---

Reviewed-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
