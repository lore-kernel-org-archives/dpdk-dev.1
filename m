Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FE6C43327
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 10:43:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9419A402E0;
	Wed,  1 Jul 2026 12:43:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 618BA40278
 for <dev@dpdk.org>; Wed,  1 Jul 2026 12:43:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782902588; x=1814438588;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=FiXw/xaH8/kAvrJ02HlqljOlDy0LO4Thi5fkko+4CDE=;
 b=G34JE515wjywL8HBYxuuM8nfAWACgbkbrznsNd23HV838qmSSOlxH1XU
 GE3EZ+exhgvhF+k55YWsjfGGtk/n8sFJIk40XRpk4dsW/UtbKxTGsAhMn
 N4BRR6KR7aFusyBMtDMb4aKusi4eevtt/VmHY8NQ1CQl1dv+UAJz2tnjg
 yxnlzvm9ihxxs6+9eFT0gtqPg8x8hFh+oB8ribPuT4d9nga9sudFfwJ0y
 TQGKMd4cAlCP1QpXGWEhTSkefkzmK5DP0E60BaJLtzgPnorfWYI4QRj36
 y+OQ+gBFrvrhrbLAWJQIn6tmQfv1AixrYw9dJg4u8DZoTNVYxtK/NzeG6 g==;
X-CSE-ConnectionGUID: gRyxFJAdQY60QWWPaBoSvw==
X-CSE-MsgGUID: eE0MIf3HRRmTKKJEGs2Vkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="109179253"
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; d="scan'208";a="109179253"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 03:43:07 -0700
X-CSE-ConnectionGUID: keF/X1bzQ7GHbuGAcQw+zg==
X-CSE-MsgGUID: pBQikadKT0KDvjtzPDiqHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; d="scan'208";a="253177197"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 03:43:07 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 03:43:06 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 1 Jul 2026 03:43:06 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.55) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 03:43:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VBl5pDkQftN2vXQwfasnvutnuMm8X1Xh7uOb4AOWeFp4NCkKzcOECV6L0fo9iKZy665Kx08lvHjIuaB8Q1VB8nB/Diz82erHJ51KEiMJdQ7j1qWIf1c2FmBi5+V5TPJX1gif2CxnnIo+jOoDv03kUi2HPEKHFml0KbGilqzxl2yXZ+k4UXjMvYWdaKcA5Qc/VxcHMiMkZbopU/brlKFEPRCFq7Z/GIgILqeynK/VIKz/hTH4td7/3y4LhFqQRGiMRNiVWbVoBhJL3mG/s2efg2DPv8RbNzku+ycG18WU6sRX3l118j29tyTQNSrXthJhw5C9MW7zGXdk2pDk/OFybw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbBNh7bXDAPVKtT/3+dNYOLeBpMoGoTunvRzDgEfPt0=;
 b=CVsZkWIT/F8tI8QsRPTzY7s+1eIjc6q/H3/VjAnbiaxcTJf93rjpOvliogrpY+354giK+c086kykVEqz1TJrCM+LnbPgRo8180o4FpHIcPa/nmSY40Oq3Kj1ewBgULZD+4ZXmATGZPUkRdphMgKPY0ZM33K/i2LzMy8rpSc5o1LscG4fnd3bAnfSIlfzaQV9qvpQaAiANAZS3q86eWtY9kqY5U8GsoWRDf2n02sQ/djc4+vkN+USNWtABNaRQ9BCUrmfqdH0igW1HCfCCsl9zcRONgVlEU87JrGPN31QlMLczIlEGI7W3lhESq6MW2hB56q7uT8n2Ivil7jF0YMqkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by SJ1PR11MB6081.namprd11.prod.outlook.com (2603:10b6:a03:48c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 10:42:56 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0159.018; Wed, 1 Jul 2026
 10:42:50 +0000
Date: Wed, 1 Jul 2026 11:42:46 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Dawid Wesierski <dawid.wesierski@intel.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <marek.kasiewicz@intel.com>
Subject: Re: [PATCH v3 0/6] Intel network drivers enhancements
Message-ID: <akTvJnWSTs1Mxi2Q@bricha3-mobl1.ger.corp.intel.com>
References: <20260618144442.312844-8-dawid.wesierski@intel.com>
 <20260630120657.1046588-1-dawid.wesierski@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260630120657.1046588-1-dawid.wesierski@intel.com>
X-ClientProxiedBy: DUZPR01CA0260.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::8) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|SJ1PR11MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a3aaad6-db4a-49fc-dd44-08ded75d7f9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|56012099006|11063799006|4143699003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: bc2Zs1B7koYBLtliYOYD95Kd/Zp1MIaUcIe6VQYwQeIRYZq3QVQe2kfrdNIonsi84JlAfnwRvbx86XAftvsMDlbXTk7eeMZEWmlTqKI73hZFlXSPHwmWlk2wftRPjZhu9zGqR3q6EQVePia6KcW/grOzuX3GPdpG9da2lhAZlCfBQGUop7BPYxCgBQ2wNUe/coDnkTHWday4Bdf5sGvKJVMjjEdZKxRxuN0/av9kb27DRotNwSDKP6vZ70ID8FIfxoDAdu3NdnclOxr1ZkfrIEbfgTNMNl5nopI9x70gKsnMyrUbXoYqWL8TTI39szbqpj0SXwlOwv4hjyERKC/Yp/jbIMs4UrDS1bPh8CwcUAoGBt5o425nun0htsF2sgNUf4pE5bY08AFPgzBEEl1NYkBTZeL6Li0sjpP5gBT96HDPweMlvqdeHp68MxDBYHVIcUDVezAXnaLCyhogWdZvspq227/TbkyvIel82lplZbupzSIVnesInH+Cvc/Yc5emw2qqbsRoFMpa71+vsqNa7kOj7FORhNxfiXmNwxgN4WtIzKIqdiPk4a8VDA7O+4Zo0DebClubnqp9hqsLK11Q+Q5bOhwWxYhsYoxuqN7ZIDK205iPSQtgb9eMBka/okhUvFqb/efmxHon7R3Os1QsG+J892Bosxv5gFdrSVFQ12E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eDL8JgcHdMYnvi9GKt5O8DszZbN8v5ZUR8ZK4GeFq9BKum+hwoyDfv/KfTR0?=
 =?us-ascii?Q?emqOgmJ9jEZpoObwTUZ4L/In6eHUKPJ7wO3UUXSI79Oinok3JqfnF5+XSY1j?=
 =?us-ascii?Q?ha21V8tG8ajaqq/dOOuu5UFIE5ZSppv5S9eSrYxHHCgKLpmLSm0KQVgPuAHl?=
 =?us-ascii?Q?cOEAZEER1lGN05SmWk3VLRYMC1+IUatZAX5kG1/q4vgk3xHG5GBbdaoSI2BD?=
 =?us-ascii?Q?PNf4DlZT8NbtI6uIew0Lf/nb5MDBXpfIXHB4JX4oDPwLCTXRyvqehi9Ters3?=
 =?us-ascii?Q?quCIazwl22xuMZjITC5iNCOUY1/xI/yle7xVkGYQsKrl95iNkio+ebDJgoDc?=
 =?us-ascii?Q?sYsUM2SNLXsRFp58CeAzDFl94uqVLzNA9BgWPaVwqSrXgbzOTrnDD2VRB4Q5?=
 =?us-ascii?Q?idQ8Vx5wfIGYspT0d1g/tfXm2TjWXkqzuVVVNTdmH+XaSln2+m3rYj4E8LQ8?=
 =?us-ascii?Q?moXvqPrSEBjOSk2VMSug3vu4+R1IDph5FC22nE1byWwIRmc+f8o9ohKdUjR/?=
 =?us-ascii?Q?lzthPEfJXMfvz0V/PbYHoLhVhzQ73u5Fa+g0g1FxI9RmLYiwoUjf6sBBy4ES?=
 =?us-ascii?Q?avw9pqbGg4c/tUBlPOBN8wOYBwa8e6ClFGQdhwhTBMaqq+zU2MAf593We6ts?=
 =?us-ascii?Q?PvEvx2ED9lJuSOBuHxeUIAgWQ0qJDrVjQvIej2ccQQNzNT1D8+/STT4jd7N2?=
 =?us-ascii?Q?lDbcNVbiWHM8kvm3IijtX117RXLDqon84jEKT7D0OLIFpWP1bqp4bSWW6dnO?=
 =?us-ascii?Q?3yiLTu2tOha3mOX0N4KusX+PYQPEwAOOuA1tlZH+E4bbK17MX5BLv2CxeX2A?=
 =?us-ascii?Q?IsMUjcVFrPRDh6VIDjOYykSK/ojDk/jaYTJmmQSDTzWiU/sOvW3A6KpfiAd9?=
 =?us-ascii?Q?mYAJbUXJrI0K8HOOV0ZJHGx5g9k5XkX733BYvrlrqU9Qy4fGpDp69eXzb5te?=
 =?us-ascii?Q?TLGoaSqZL2eUt4SH6OQYBG8RHKN/QWOHrIZ9whfV5pP0DfL4SYeuly6vTInm?=
 =?us-ascii?Q?VeNKxiZp7S8CchHfMYePQF8feDj3y3h+7EfAolCx05lj+6avK02NjJ63jMFo?=
 =?us-ascii?Q?sLrCIFsTVMieYc5asKXCRIAYPdTLNkcF5poMzFd41lHCdQNipkdMjhFsgQ1q?=
 =?us-ascii?Q?EOOQuTfE1c1asp0LRSjCV7QrM5QrAicrMFPmLMWdFkx1QaI3NEQRUkE3oQgQ?=
 =?us-ascii?Q?WyNQVbL+ePvu0nHnxda0q0ty/9HoitGilQIQn2mq4g0iU4CnSnMGLh0BdBUN?=
 =?us-ascii?Q?+sqOPslfnAHmazeb7e4TGo+x+abbyNEkw7L7G9PPkOub5z883HEY4VRFgY/e?=
 =?us-ascii?Q?47KfreCIjsyduNY6v8Wo6qhSLyhrD5kf198wyfJQTQGpDdgtHpr43t4EPOAQ?=
 =?us-ascii?Q?Hq3dUoHEvCA6TUP+dGSLnki8N1WQw8aLCu94NNqOQf21IGxjxZvZ9u+gL+95?=
 =?us-ascii?Q?w8JGgiKmN10dUo7VulSsSa49Pb4pBATPTpGpFLyE5v6o+g1h/br5j5jLRSBR?=
 =?us-ascii?Q?YIRQW4o+11WbM6aVGfZqWzVHpHLW+V2+ZGEvrnYp0ZAHUNCaOz52wCzwoFpi?=
 =?us-ascii?Q?IiHCwq3X9REiR/VfhXy+o4i8jXZZ0y1vyvMrd00QWKaMNLvYVB1vIeb0crRq?=
 =?us-ascii?Q?wss9OOA319VXSxnnk3CNaReWHv35tEk4vSKGaV/TjM/VGfytCBhf8DCqMzVW?=
 =?us-ascii?Q?r4t4qaQiWsThZpY04PEVa9NoWnUgsxIapsqKz/BxF1RJxp4hDg2Bj5EawgZw?=
 =?us-ascii?Q?DdzaEJhXs6u1FDjkFCjEjiuQnbbDAgo=3D?=
X-Exchange-RoutingPolicyChecked: e/rdkhcjJM5sg6XEJleWVCRP82UplRza88Mk+dc8FTQ2PdNGn8urUrBvnz4n36iyKy3mqbQtqEkU3datmJNqyLzbBaFbm5zVsbAT24RVj5Sq6E5WIM9YQWXiJP8kDND+huyEaNZXxrdxhCcsSZ2qivSsO+vPjpaiZbYo52CXFHmrfCJcphDyxvVGbm+gE/6K/R+IVR6r/0ji/Isgw+oLB1tODrnoz2+2OfolTbvm6WVZiRVDnXgKZUcYyc7jfvnqrPzV1seKF29f0RxK7Sesa7AcPXqNczlP7sCSp5qwcKNTi/Bde5yzIvXM1/dn4nYn30fShnEffi7eHZ3kbpMNVA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3aaad6-db4a-49fc-dd44-08ded75d7f9f
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 10:42:50.8573 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cmzYUcJuznjBbdgzqhLerygSGEq/Jqv5MJ+YXcon+BmOJw4l34y2uShYoVBIO/WYaS7mgEQ7sOl9U/RQ6iD66P0DDwiM0dWDSkjnEqhUUm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6081
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

On Tue, Jun 30, 2026 at 08:06:50AM -0400, Dawid Wesierski wrote:
> This series collects Intel E810 iavf and ice driver enhancements developed
> for the Media Transport Library (MTL) to support high-performance SMPTE
> ST 2110 media streaming workflows.
> 
> The "new code" in this series (specifically the testpmd enhancement in
> patch 6) demonstrates how the standard DPDK buffer-split offload can be
> orchestrated with pinned external-buffer mempools
> (RTE_PKTMBUF_POOL_F_PINNED_EXT_BUF) to achieve this. By pinning mbufs to
> contiguous hugepages, the NIC DMAs RTP payloads directly into application-
> owned memory. This eliminates the need for the header-split.
> 
> Documentation and a concrete configuration example for this workflow are
> included in the testpmd user guide (patch 6/6). The new 'create pinned-rxpool'
> command serves as both a test vehicle and a reference implementation for
> integrators.
> 
> In this series:
> - iavf maximum ring descriptor count to raised 4096 (HW limit).
> - iavf queue rate limit enabled reconfiguration at runtime.
> - Added opt-in "rl_burst_size" ice devarg for tighter packet spacing (jitter reduction).
> - Enabled PTP timestamping for all packets on ice.
> - Added opt-in "no_runtime_queue_setup" iavf devarg to restore strict
>   initialization semantics when required.
> 
> - Dropped the ethdev and net/intel "header-split mbuf callback" API
> - Replaced the out-of-tree approach with a testpmd demonstration (patch 6)
>   of the standard, upstream-preferred pinned-external-buffer workflow.
> - Fixed iavf error propagation and committed-state logic (Stephen Hemminger).
> - Converted the ice scheduler burst reduction and iavf runtime-config
>   disabling into opt-in devargs to preserve default behavior.
> - Updated documentation, commit messages, and .mailmap.
> 
> Dawid Wesierski (1):
>   app/testpmd: add pinned external-buffer Rx pool command
> 
> Marek Kasiewicz (5):
>   net/iavf: increase max ring descriptors to hardware limit
>   net/iavf: allow runtime queue rate limit configuration
>   net/ice: add scheduler rate-limiter burst size devarg
>   net/ice: timestamp all received packets when PTP is enabled
>   net/iavf: disable runtime queue setup capability
> 
Since RC2 is fast approaching, I've taken the first 3 patches of this
series into next-net-intel.

For the remaining 3 patches, the two driver patches need some more
discussion and probably rework. The final patch, for test-pmd, goes in a
different tree (not next-net-intel), so please send it as a separate
standalone patch.

Thanks,
/Bruce
