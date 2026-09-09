Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956F3C79F8C
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Sep 2026 09:09:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 69A4C40272;
	Wed,  9 Sep 2026 11:09:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 2855440144
 for <dev@dpdk.org>; Wed,  9 Sep 2026 11:09:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788944953; x=1820480953;
 h=message-id:date:subject:from:to:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=dB+8IMnsR9or/Xvn2cfca255HNHrR5KnAdQy9y5TJ9k=;
 b=KhZJxQNS6VnJvLnMl4NZFzNv5cZk7y65Li2flIRmgOySg4Mumo75w/Bn
 A+dhL2hqn+0BB9IAG86p+Ug+pOLKkpOHT2PVkwEKJbloSMpqz82YKxwG+
 3GhbbWNFxtffa1FgAMUbZ02FkdLxJ8T5gUBQzXQOFcnAS2I++4XUvmNKJ
 Onmgtnu3Q6GjeATVvR8ktBZpj7clb0fG0D+3985CGgo1CtZlHom+4CDaK
 54GGjzfxSfbwNvGLrJgEHu1qoIfrwv43H7eWG3bEYQ4nRL7GFBO/gUJ1Y
 EkjkSDydz2iRw2McN+LuZjAMCB6KaecGgZKNr2NT0196Eei652Pr3WDGA w==;
X-CSE-ConnectionGUID: TkET/8NkRKqX/PEByFHJLg==
X-CSE-MsgGUID: WyBqc01yQ7uZHRVuNSPJ9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="91876468"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="91876468"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 02:09:11 -0700
X-CSE-ConnectionGUID: H/AGOArzT0+g9oZK7M6l6Q==
X-CSE-MsgGUID: tSaYj0XAST2eO9Jv1qdr0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="271244381"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 02:09:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 02:09:10 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 9 Sep 2026 02:09:10 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.61) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 02:09:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A88S87Jjgbttb6Bc+stwr6f6bqEI4e3HygbSSa8kEKdzF9Wg3yvXXnlVP/26Z/hULW/mq/gJ8IqtehdirybAr6T4c4uMf9/9n7UmmybUy6zTALTRzq1PD2UMz1SMWaJRPv84u3mIqEk9iKVVyhuZpuVPF/dF83l4NDZK/cBoQOxgn5DfwD4okVITQ35QWLlW5IjQ8qGu2OuHl+E24+0MN3VHyaNodxAzBxKG7nQ0Wj/cxOMrzKZPyfYXMrhWGrJb6MKG/DUqGwVIR0kvUxbJ9Siv4QLArjCfDW3yLBtH5wrNi6X70KHoUv6rbM03LR3+SeqfrPDL3pjHcCUTc1zILg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSPwpqdOsAgvzW4LWGLreTCqOCGOkZkOtc0+LdAekFQ=;
 b=ZjH7MdsWXuCLWc9F8hXOoDZnhK9Sh9y/6BcjYy6SmVqYVrCqrUm9KdEhZBH+cPH7yAVd5Ft4IWrIUkYtH+g3IxOPzxNjDO5kGYHjNpd7iaRCM9UCDNyNPlWLNtSB9ww4ShNTN65d9F8j/Mc4t5jTWrraC3q+2G5ii8I83G9u0MK/hzKpJl/CbHpN/sBDbkwNS3fEui/T7fwodZP4pJHgENYn/tbGSWwVbSnaTOCD9vtPnZFoVG5oy83KSEXa4rGKHrLP441oUC+AXr/HgPnt4vSHC7kpRt90x+jdHvfc0JTJ3wEaO0jfruqcfNASXFcset2PZdiZOpNyEBpE7o150Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 PH7PR11MB8526.namprd11.prod.outlook.com (2603:10b6:510:30a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 09:09:03 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 09:09:02 +0000
Message-ID: <593aec82-a900-4357-85be-63c53767d542@intel.com>
Date: Wed, 9 Sep 2026 11:08:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/19] Building a better rte_flow parser
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
To: <dev@dpdk.org>
References: <cover.1787233986.git.anatoly.burakov@intel.com>
 <cover.1788880122.git.anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <cover.1788880122.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8P191CA0030.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::40) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|PH7PR11MB8526:EE_
X-MS-Office365-Filtering-Correlation-Id: f4f90893-8d6f-49a2-db6b-08df0e51fd81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|4143699003|11063799006|5023799004|56012099006|3023799007|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: KY81cFsnh92eN+xrHaflK5tOaiN0AEdt+ItoEbZDZbq7KNDX1nLM6TFnlsxJhbfKPa5pQr++n+bsqtsHzBs3I9QSxVzgZEif8zQfVw2AVwdM88xQZ5k333YbtZ/d7JowdoR4vK3kLywZCrx8rbn/5f/W3OHTP49fEbghJcZ+DcRU5QwIjHVWW+0l1zeMDtGkn5WKKGdqK1PPZhwUJU0eiGBHsje+dy7ZBiOajdDRd8s6k7eq8tf5s4eBjvMe9mMwgbMcvJPZrfvU9UFQiulMXj+3ywYV31bcCV3ilbtEUw064JmGk4sy6npzK6vdtdZo+jPrlcDbf5K1OKKkHRIJM3ywR8V6ZyTkdjMugsiUGhNJy3qcyAR0T2y7WanHiPYrhXkFUt86PWsLo05frEkwv0eXyiYLkQ15Bb29U6CNRL5GszJShnOLZFeLfZy6eaT9iNA8pRLOpUBAfzKLOfVO1ZvgHG9z3l9DmCnezn9sQimQC/skiuzYmFIFkwSwYTREQRXIadZcE3mtinJV/dwnjz+NZHjPNkdvvs901x+l7ueKX1/Fab5zLNzYZd+cJGLNyNtfCnD2aA576izMR8D7v3xUSpV74oLgyAJiNZRZUE497erKHNVTRSCrizddGm/1ZM2O1pHVcR5vE3xTHOMvjAYMyremZHI56KeJ47/T1eY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(4143699003)(11063799006)(5023799004)(56012099006)(3023799007)(10067099003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjhCam40dk5IV1pqZGVQb3puazFjU3VON2VZNzl5dVBkbzRaZ2xaTGpUa1I4?=
 =?utf-8?B?ZVhQQjVKcjgvelI0S3ljVFA3cE94Zmh6MnlxVjVibzBLZzY2SG9FeXltb2lR?=
 =?utf-8?B?L0VJc28wTkpxd016S3NFNUl4UHZoQXFLYXhyWnRtUWs2OWgxcEJONEIweGxW?=
 =?utf-8?B?a245VExHL01KTS80MUw4eTNjYUpYRzlPUy9CTXRoZnE2YnFNLy9tT2g3bzJh?=
 =?utf-8?B?UWxmek50SFpGRVBCS0dXOU1SR0s4cjlIak5UQVdwVHNYV3l6M25TM2VNdllm?=
 =?utf-8?B?WCtxUldzeUtvbFhMSVJEd01lRnVmS0JwSDRuZjlsbi85QjRWc1F6RVdHc1BO?=
 =?utf-8?B?ODhoSVBaUnZSR0JtTElKMS9SQjFFUlE1UmVpK2RHREhBdlhtNWRMZGRJU2w2?=
 =?utf-8?B?Rkw3QVpKd080SFdFM3FKLzkwV085QjdhdXlHd0VYcTRQeXN3ZU9jL3BiV3A5?=
 =?utf-8?B?VWMvVlZqZU9Cc2IxUG1yRHI1NTFTbkFJRlE4YjA2ay9MWXlpSFFub3hwN0po?=
 =?utf-8?B?LzlPSE5LNDA1VVhxVWJoVG45c0tMcnJ2eThEMEk1TURRUUNZaVBvRjRMc3lj?=
 =?utf-8?B?eTg3ZWJGYTRJMm8vUVdkcWdPRXZEKy8vdkFueThra2p1UmQ2bmsvaTVVQ0gr?=
 =?utf-8?B?QzllZm9LVXJKajNFMElMeTM1ZUpIUExWZEVYOFNIUTVvQm4rQVMySkVQNFU2?=
 =?utf-8?B?dk91LzNSWU1kR0NLV0FlRCt3eWRlb2hpNDZsTU5xbnhMM3FUZTVyM1V3dG9i?=
 =?utf-8?B?QnU3VWhXazZ5aHlvNkl1UktWY0FJUHFyUk04QWRSbVFXNVh5MFdiaktFd1ZN?=
 =?utf-8?B?OWQ1ZkFLWitFZW5oUEtOSmlNMWVFYzFaZTc1Smw5dC9WRy95WTZRcUdQOUgr?=
 =?utf-8?B?T2VsTWlvdmxQQ2lheXlCRmFYWjNiTTFpY3l1UTFWTWtSSDgxWm5BQlVXRDdJ?=
 =?utf-8?B?VmNwam50NWlYenp5S0g5YTZjRnZZeDRZdGR1UDlVREJwWGgrcU84RVdVR0tQ?=
 =?utf-8?B?Q0pxcFhDcXRxc1JoNkI0S3QvWVgvekVDdDJzZkFla2JVVkd0YjQ0Q3lPeVlm?=
 =?utf-8?B?azRGWXJtdnVQMVcrTG9wcEcxbUlGZGRyQWh4Y1Y4WjY2d09wMUxGdS8zRGNZ?=
 =?utf-8?B?YmtpVWJCalowRWpXOXZMaUljSDROTFJmUHdiQnJEL0tuNnJjUGVoekovSXBl?=
 =?utf-8?B?SUtDRlNMbDUwQ2ZRU1BTWGc2Z2w0ZjJnKzhWQnpTZWduK1hDMjVWQ1hjSlJR?=
 =?utf-8?B?MS9RRnVrWXZPWkRXVm5QQTVNMFlGUU1JOU9iSVZIVm1JWVg4RlQ5VjVCck5H?=
 =?utf-8?B?NzRKQ3NRZkFzZnI0Y1pYK1FpUCtiRkx1MU9zdnhZS0tSMktKL0RaekZHM2tO?=
 =?utf-8?B?V1lETkpDT09DNkMydDF3bTYxV00wSVV2ZTZYc1pkelNKQnQwdTlPVGdsRTVU?=
 =?utf-8?B?WDRxc2owUjZyb0dQMjk0T0Fjdm03L3o2MTUzZGVBRCtYaFdKRDJXc3FBd3lJ?=
 =?utf-8?B?STJIcjFlbm1yR0h4a1ZyTG9OZHEydW5RVzJUN1JRZ21ocUtlWVdIRHJXeVRC?=
 =?utf-8?B?TTI5RkpSd2M3eStyandBMTVwTmtnM1VUbnFwVjRvaHVZTElRNjZua2NzYlps?=
 =?utf-8?B?VEdUUkZlajBoSTBzNkJxN2lzdHpGN1hIY1hMaXdXQm9zY3JVKzB4TmVBMHJ6?=
 =?utf-8?B?UDRYRkllalJVL3BmK2VwNVg2WlFMMFZVOUx1Z1p6T0VUNTJyUGNnSmlodHJB?=
 =?utf-8?B?MXR4Nlh0T1paVnMvbjh5SjN1b2h5UFhqK1pqak8zd3dRalgrUWhsR2NaZys0?=
 =?utf-8?B?YktFN0ZtemNkb0c2ZU1uQlFZR2hnUkw3Tkk0U2JUdEJKWm9xLzBRRERjR1d6?=
 =?utf-8?B?UTNTQ1JvNVc1UXdlRExacHRSdXoraDJjUzROSnArR0VxUnFjUm5vMGFXVzF3?=
 =?utf-8?B?YllJbUVrQm1xL3U0SExCQlJsRUhXL0JlUnc3VlJHeG03RWhSTTVwUEpnZ0Ez?=
 =?utf-8?B?TkxDKzRzQXBnc1NrVHBDOENKbnRmb1A1ZlN3a2ZSaHRMU3cvZlRkMGhsOXNa?=
 =?utf-8?B?dHpveDBuVHdudEZITmRZUzVhQWdDWmZVbGNGYjZuSVk5cWNCZVlvTEVsY3ZU?=
 =?utf-8?B?a1N6Ny8wUzVjV1ZwT3lCa25ZQUF4SitvTm5aTnNONmxHOXdlN1lvRXNRNlZ2?=
 =?utf-8?B?WFpSWUVWQ2dXZkRIOWdzdmF3d2lpNlp6a3VrOFloZVBaVzJwbmY3anQyc0hG?=
 =?utf-8?B?U3NoL1R2VE1wNXhkSmpobXkyR2kzVVlpc3FtRnZuZ3o1cnJzeEZqQUYxZis2?=
 =?utf-8?B?ZTIrZ3RKczBITCtnRGw3RVJYaUFpQTN0TzlWN3FFREI4WnpQZlhDdlB4NmI0?=
 =?utf-8?Q?JSYwDnXXnoHIs9qM=3D?=
X-Exchange-RoutingPolicyChecked: ckaxuC5dlCSMLfsrYyA70SdIctuIUxwbh019aBpqyUSCUf9z13F+fDZY+v4DuIeudXR5SlhIPFHywucq9+7Yw1U8Vd47D8c9+ZW7ODjGqkEKudBt0/k2YaEATcxshHBsJBfpuLYe0OhZfZkSlxQaTdU9MGlqnWfo1MpmutXEIqS3w10WgMamfc4CMMrSW19xj5T7kxE0weDqc06tUZo0UpyZ7yr+LCxfuRja8O4zxAi9EhNqXPwtlOW6BW36D67UYsNQw5CcUjZLigaXcYvo6RsIuieb/GRsRO7ttQWoRNAhytbjQP/jz64+bOiOf0L9Ho9+mGJFLe/KAEMkCRrn7Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f90893-8d6f-49a2-db6b-08df0e51fd81
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 09:09:02.1939 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZDnQs8OjK3FEo1lxPM2vkVWz81Sc0/UOjYP9kaBLSPpRh//3sl/01+dFMDEv5rapDvpTB4j6k+YepAsBuPQy7WxVR7XT/9ojkYx3z5gHoLs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8526
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

On 9/8/2026 5:20 PM, Anatoly Burakov wrote:
> Most rte_flow parsers in DPDK suffer from huge implementation complexity because
> even though 99% of what people use rte_flow parsers for is parsing protocol
> graphs, no parser is written explicitly as a graph. This patchset attempts to
> suggest a viable model to build rte_flow parsers as graphs, by offering a
> lightweight header only library to build rte_flow parsering graphs without too
> much boilerplate and complexity.
> 
> Most of the patchset is about Intel drivers, but they are meant as
> reimplementations as well as examples for the rest of the community to assess
> how to build parsers using this new infrastructure. I expect the first two
> patches will be of most interest to non-Intel reviewers, as they deal with
> building two reusable parser architecture pieces.
> 
> The first piece is a new flow graph helper in ethdev. Its purpose is
> deliberately narrow: it targets the protocol-graph part of rte_flow pattern
> parsing, where drivers walk packet headers and validate legal item sequences and
> parameters. That does not cover all possible rte_flow features, especially more
> exotic flow items, but it does cover a large and widely shared part of what
> existing drivers need to do. Or, to put it in other words, the only flow items
> this infrastructure *doesn't* cover is things that do not lend themselves well
> to be parsed as a graph of protocol headers (e.g. conntrack items). Everything
> else should be covered or cover-able. In practice, just about all drivers will
> benefit from graph parsing as all but one of them implement only the protocol
> stack parts, which are the ones targeted by the graph helper.
> 
> The second piece is a reusable flow engine framework for Intel Ethernet drivers.
> This is kept Intel-local because I do not feel it is even appropriate to define
> such a framework for all drivers to use in the first place. Even so, the intent
> is to establish a cleaner parser architecture with a defined interaction model,
> explicit memory ownership rules, locking, initialization sequence,
> implementations of rte_flow API entry points, flow replay and memory cleanup,
> and engine definitions that do not block secondary-process-safe usage. It is my
> hope that this would serve as a model for other drivers to follow, expand on,
> rework, and improve, so that maybe down the line we *might* have a common
> rte_flow infrastructure for drivers to use.
> 
> Most of the rest of the series is parser reimplementation, but that is mainly
> the vehicle for demonstrating and validating those two pieces. ixgbe and i40e
> are wired into the new common parsing path, and their existing parsers are
> migrated incrementally to the graph-based model. Besides reducing ad hoc parser
> code, this also makes validation more explicit and more consistent. In a few
> places that means invalid inputs that were previously ignored, deferred, or
> interpreted loosely are now rejected earlier and more strictly, without any
> increase in code complexity (in fact, with marked *decrease* of it!).
> 

Recheck-request: rebase=next-net-intel, iol-compile-amd64-testing, 
iol-intel-Functional, iol-intel-Performance

-- 
Thanks,
Anatoly
