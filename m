Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD794CAC5AC
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Sep 2025 15:05:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1030B40615;
	Tue, 23 Sep 2025 17:05:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 65D8C402CB
 for <dev@dpdk.org>; Tue, 23 Sep 2025 17:05:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758639937; x=1790175937;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=O87o7U+fJ+PvLzfUXHHR3VK2NDA9axSR5V1SKxe7Sx8=;
 b=JkOnAdKLvnDMJ8qzZtgdsgCFl3zah6EFTm+aSfeRRrhFuZit/3vpJvaM
 8AD/DVb9Ke31ObQ4WSXHcVSVtWrYs7J4jc2up7Jnm0mTLSKNpw81o+XTp
 WyiiLcp98mFy4qeXhwSHcFSu/jzRHqan+d/Euj4eVvsk2L/U1MzmCWfV9
 TYMVOqaSe2No9nreGy619auKYm0RydYwqJEoYDB5pfpWqQVsvAsTm8Bl3
 VnsWwFcQ5IlphW8x4btktbVi6SCdCvrUAGWWBEkO/HJMDwO1jGRYvG0ni
 NrFBs/HWPK7XNnkeQg/JjPdh37cNIslN412JRq5NvOWf6MujxJ++/KVOG g==;
X-CSE-ConnectionGUID: Fj7Leto1RcW1rxNwMxjYwg==
X-CSE-MsgGUID: 7JxNk/YnSHa9DLOAs+g77A==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="86363208"
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; d="scan'208";a="86363208"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2025 08:05:23 -0700
X-CSE-ConnectionGUID: d4NQm90+TXu4x7bAIR/x/A==
X-CSE-MsgGUID: U+pkJMQgT96m6WewsTsKZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; d="scan'208";a="181170154"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2025 08:05:23 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 23 Sep 2025 08:05:22 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 23 Sep 2025 08:05:22 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.36) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 23 Sep 2025 08:05:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ShmcboLJQ5vm1nDqDvnmFVvRxtKruZb/v3HA0BFesG89hCsgAj6V8Ru+CaY7SYYngeNtwar2x+Kl+RISKwxEt0j0dvJYO/Vq/x3cMw9Aj6i3AUqLADBlbqMAq8Jwb48sl0AthlaZEy1C89kp6YpAiTdYIWojmx0TcXZpHP1jFE3dxRKt3x5/5vgNKk7VbsgboSdI4e6pyg1yoWsxNrKKbAMieyroYAf+rExkaYqbnkMgJspxnwc4XGiESVLzUi5vHQXsQRMUmGTFDNbLgXpurZpCwfGP2SqgMOqxUjS3m/VaMwQDYJmjOyqMGLNXgNBAp367ZUl6wMd8GEcRXc+vmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtyOZVQLTi8srNa6m7XR0o093CiJ5aF/RvakWr5XTzI=;
 b=vfgWC8fuLh9eo6/j9/AIVQZwU8qaYpxDTS0iuvaemjQA2+z6IGbq3wW8FaECCj9aUvb1LwEX4y9DZ6ZKAC8vVd5tOu9Ci6QdogajaHb1xdnC5tpvksdVJtDtf1w7EsFRxSPc1/GkRM/D57UTdV+RJNsQ0+R0JjsZblXihRlMt2aPB8tc9RCAVqyOf2/1cxpN3LBu5CcD3jokUA9m9Xx7TdB3yursavclXbqC1/mSmKXwNGE8lXzH3oeroL+QiXPbFD3ReS+c4/FDBEE/smQm3P6noplSq2e6poO7fXgyEjlyQiLQcvQ1wX0VOQZp2DHrdBPNfjseskIVkhjOIQ6xwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB6321.namprd11.prod.outlook.com (2603:10b6:208:38b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 15:05:19 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 15:05:19 +0000
Date: Tue, 23 Sep 2025 16:05:12 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
CC: Jerin Jacob <jerinj@marvell.com>, Vamsi Krishna Attunuru
 <vattunuru@marvell.com>, "g.singh@nxp.com" <g.singh@nxp.com>,
 "sachin.saxena@nxp.com" <sachin.saxena@nxp.com>, "hemant.agrawal@nxp.com"
 <hemant.agrawal@nxp.com>, "fengchengwen@huawei.com"
 <fengchengwen@huawei.com>, "kevin.laatz@intel.com" <kevin.laatz@intel.com>,
 "conor.walsh@intel.com" <conor.walsh@intel.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>, Vidya Sagar Velumuri <vvelumuri@marvell.com>,
 "anatoly.burakov@intel.com" <anatoly.burakov@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: Re: [EXTERNAL] Re: [25.11 PATCH v3 0/5] Introduce DMA
 enqueue/dequeue operations
Message-ID: <aNK3KPYmVmMKfFoH@bricha3-mobl1.ger.corp.intel.com>
References: <20250519185604.5584-1-pbhagavatula@marvell.com>
 <20250524091316.10056-1-pbhagavatula@marvell.com>
 <aDQjDZowik8E7Jfh@bricha3-mobl1.ger.corp.intel.com>
 <PH0PR18MB408699863CC25944A04C2F18DE6BA@PH0PR18MB4086.namprd18.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <PH0PR18MB408699863CC25944A04C2F18DE6BA@PH0PR18MB4086.namprd18.prod.outlook.com>
X-ClientProxiedBy: DU2PR04CA0316.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB6321:EE_
X-MS-Office365-Filtering-Correlation-Id: c2ead66b-cce8-405f-846c-08ddfab29c24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RLuApW1je80FFnDTyJviSVR1vsh0IcNQLqEljG4JbUnBTDtTXBkWcq6hkp7/?=
 =?us-ascii?Q?BX/KJtEUChAEICJAqNZYYCppKL8lixnaxVZNU9R9IUJ9grLTZUDWIAmLmiEb?=
 =?us-ascii?Q?IsrJJIKUOM4rvdJWUDBHHfidahxoJr4m61XtXJC0+FmDL52UKvag4tSMlTCG?=
 =?us-ascii?Q?kpEo8eNQo6MTUgtKHjzwWWDvc9EZQfG1RnYlGH6H4rCbLNnU5xqPFaGR2GM1?=
 =?us-ascii?Q?G+gBdHRNdGg8ktqI9Ef++kRaA4vvo8oNlIV/7WZMuc7b3gr/bPanu7PQ4PLd?=
 =?us-ascii?Q?rinoN4UYFXY3HVjM1IivtT5Y4aMtbaPxe/wqVceF2DyRUwjISdBBtUfRkbec?=
 =?us-ascii?Q?eOmI1kNySzJ7XgpRODEYiCeCpU0Vmw4RlEq3ZiIFXS3qQfzWTRZ83K4/sbl2?=
 =?us-ascii?Q?mNV1fBAiBOdpKjuphf1b1aiWWrnTcQuvMjeMPcVPOd3OsVYnEcHauL6kNWIT?=
 =?us-ascii?Q?oVK6KBdiCG+7aVEW1Ff2m4y1uG5CmYx2sLHYrq3VrQcdJ/8Z2CNgZB3Gjw+a?=
 =?us-ascii?Q?8N2/RWfSNsM8IvqVasXey9rybzsQI0Uqs0xm2wE0966AoJCd7+3BYJQUk00Q?=
 =?us-ascii?Q?THHuVZme2X1ic7LUWDrt34NyqO0EyCn7j9YHLzRDQ1DiHmfWuMmGlp9ZcNmb?=
 =?us-ascii?Q?ZIRwWRMloe9EnXYz51QA/szy0xSdlY8nlotgFbyC768yrsh1kJ2eGiCpRmO+?=
 =?us-ascii?Q?0AhfApFLiOrW0iKXN5dP9e4mSZCo0KcbQeCG/gpcQS/hMJY916ojf/8AiwLe?=
 =?us-ascii?Q?grHiJyHd6tDbe533DJFes5i2uA568c0EcFkVy6gkvjU+VKbKWevIl71XoPe0?=
 =?us-ascii?Q?Eg8zsz6NZfkA1E7mJieIw00Dt6cUXsMGOCY4j5IJy29KsHWR/UjWL0/obDug?=
 =?us-ascii?Q?4bVN13HG6ZTam5YK9M3MDIR7ZaOrAGnMeVOcNrOSXWoq0YVOlnKtyQDfonw/?=
 =?us-ascii?Q?Xb63hH83G/PLmvf3nNYOOYH51ZmPoLe8PB1kGmS1GVwDBKTUsethoo90vem+?=
 =?us-ascii?Q?JlocZVk38FtKxjukjSISJ85IsJnJCJsQOvc6G9JBNrSZtQjsynOLTz0IPxcu?=
 =?us-ascii?Q?RdXxsLi9bUePkWw1T5y2uDfqD+lwIBdQiKk3V73wllFHnXiEM9M+oWgaahKy?=
 =?us-ascii?Q?t+apFnPk/rAToPaCP6QZfjy6audRpwd9+IIGun8pP0ljhg9PMrAutPPkJOgH?=
 =?us-ascii?Q?oXZZ3tVdjnuHUuOucdkBDP+YcP+UhWMxLxPTtbVraSX02B7g45U8b/ws9PK7?=
 =?us-ascii?Q?PcK87O1wDkxKHZxLYPsf7XvduZzpG+mMIjfv3rUJSzCtYjx0FKUqd4DoheEv?=
 =?us-ascii?Q?rr3SnZYndKGFEP1nXkS6cucEINapP9LrDDx7ck84Xb2dCBd5Nl2qeGvFKic3?=
 =?us-ascii?Q?nXPGq2uQLRNnFDIMj1RGj3pwAvWSnnTOnZxA+fbxxEk9ZXVdQHgK2qcbkSdk?=
 =?us-ascii?Q?5KFxjShdgnIGAQK512UcaECmz1lkKbgn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QeSoLzHcsUh60TdHmOGZd+iPrHTfKB8c81L3dq0VxLGJx9jEGnJNZrppv/pT?=
 =?us-ascii?Q?pkZthUOvJvlAR1GXPk9WC/wFtu7TYTyQEPVHhvLz4JXH8kCwt923/nZdca4F?=
 =?us-ascii?Q?+djIbj/45ZTkuxi6f+Iv58zR/KFpYJjN617EKEzKxvgz3xbGr5h+2/cizQkL?=
 =?us-ascii?Q?l1MKHqd0TSKZ/4XTi+H7i9dRpcX6bcxl0Bq3aJ+FmhFa3CbjI78kJJZhGnnC?=
 =?us-ascii?Q?JfEqnkc7YIwtg0S0DExWXcr4mu3K0qd+OO9t1jNNBU0i02y2i9IEIHhLC/ap?=
 =?us-ascii?Q?rId65YWtVDOHmYSOWFqp0cx68y/TvSTOYt59lRZr0GBhOoaaSinioUCqsvJh?=
 =?us-ascii?Q?kzqba1kXNkVZpjoJCwdwp3uNPc75kZngIf7i2Pjw3YIqxqUahvVkhwcUxX5f?=
 =?us-ascii?Q?SzSkJ3VqziOr+8mTIRtJdI8mPCE2uZEknQIQngdcVxkhdgePiZXqNUdc68Gp?=
 =?us-ascii?Q?prgbSV8xzQEPRgQlFrDeEUTL5cChcOTibnJKNpWxbPg4SWI+6oXn7pmPlMHc?=
 =?us-ascii?Q?mIcGDvpndYOzU44n4t9AIeh26dmbWh4YbBgpFIU5GyUs0lf+N453Hn6wNakV?=
 =?us-ascii?Q?64oSnYtsGNDjcsUqrPst2tdv/rE5uMCf+GMkyqgjpdOpxRUvkGTR0Hd3M1nC?=
 =?us-ascii?Q?8taKjfqAy5t9IGe7pOK6hYB/plJLZErvUr5yD6fE3kH5/BUvSfRgUNJUov8O?=
 =?us-ascii?Q?E+GUukwcRSyuYAjy7FfNqD8Wco1Ul0IBl+F1bA5WoH9+CKpTixJSTjo5whwC?=
 =?us-ascii?Q?Vex8+Be4mFDOyavKc7A+1+uaDuI7AibHV/6ijvwIx8JrBDlqEBetNinlBark?=
 =?us-ascii?Q?Wc3FCagPO+3GMoOHerYPGmmRkXNQvusr30EBn7EIezXETReqn/bInI5xjTGu?=
 =?us-ascii?Q?UJ0CjPDGtXQ3pTtfuz8Pi7YTQOWBbH52oSUzKLQD0LUrHg6m4d4po9BubbCQ?=
 =?us-ascii?Q?YFeHaBA6xHIGUdBFJRNZrGXfMsLTLqdj92CJ3vDgfv+1vzNAiQG/LhuJnyMi?=
 =?us-ascii?Q?BQPuBTuBT0LV742iV+hBJeASZroZTApChccyLiOo0MaOZnOixxFVCOOzAh5I?=
 =?us-ascii?Q?wgMnfPL7HY+BZpk4mDa4KLdgfCV3CxuQtTMIpnAklULGNEzwaoTTdUh1LVPI?=
 =?us-ascii?Q?7QFX7E3rbGaYdkJatW7I867hW2d0v1At/mA4U4AcmOEYSsLwTq16u/qDRsrQ?=
 =?us-ascii?Q?aTZiRTy0eqAirXcriYrcbxKV91G9nJIva9pl1DK3JkKDAStNmth+bGayWmMx?=
 =?us-ascii?Q?yLKnclYRphlOtzQnfIY+v7ofxf/6HwO8h2hQb7l6T1MKoV3DHnBSdOk/gCUv?=
 =?us-ascii?Q?eGhNOWQS9Pqia+Tvaradu3NsHfjNqQ3KD5XzIGy+lczA/9/D1F9TgWI7xsrd?=
 =?us-ascii?Q?pioifW1pDP4Jsl5xYYzwxTdaLUuqame2UjOu5Z0k8lTuqAJYBK92l02ux3jn?=
 =?us-ascii?Q?621SkbZqTRAgJPwjawQ+Ql/Mgpz79MGfmjYVUXN7kp9bcyKi3nXKwIpuiCpR?=
 =?us-ascii?Q?sGxLFV8a4c3x0feC7+l+eRedqzSuB1ybRGEsskcrH+TgkUlKQqjejOii0mw5?=
 =?us-ascii?Q?/GDEQI6VcS9XKgr11smYth3uFG7LOrCMRFVgS6V04+P6buZDV7eIKvqE6GlM?=
 =?us-ascii?Q?CQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c2ead66b-cce8-405f-846c-08ddfab29c24
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 15:05:19.0286 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KcrmHURgB/zVo0eZZhSw73cnr9JiiHI9q2j5vU3vizRMRvTZNMzxWvPAONBxivejgETmMw1VJeLuD52WB9vaJ/MIDFQbRdY8uryfjSAcXY8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6321
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

On Mon, Jun 09, 2025 at 10:03:33AM +0000, Pavan Nikhilesh Bhagavatula wrote:
> Hi Bruce, 
> 
> >On Sat, May 24, 2025 at 02:43:10PM +0530, pbhagavatula@marvell.com wrote:
> >> From: Pavan Nikhilesh <pbhagavatula@marvell.com>
> >>
> >> Introduce DMA enqueue/dequeue operations to the DMA device library.
> >>
> >> Add configuration flags to rte_dma_config instead of boolean for
> >> individual features.
> >>
> >> The enqueue/dequeue operations allow applications to communicate with the
> >> DMA device using the rte_dma_op structure, providing a more flexible and
> >> efficient way to manage DMA operations.
> >>
> >
> >While I have no really strong objections to this addition to the dmadev
> >API, I'd appreciate if you could explain WHY or how this method of working
> >is more efficient in your usecase? When designing the dmadev APIs
> >originally, we looked at using both an enqueue-type API as well as the
> >implemented individual-op-based APIs. IIRC at that time testing showed that
> >using the single ops directly was faster than using the enqueue APIs, so
> >I'm wondering what exactly has changed, or is different about your usecase?
> >
> 
> Here is an example where we see enqueue/dequeue ops to be useful especially when 
> integrating with Graph library.
> 
> We had to write an entire wrapper[1] for tracking sges with the current implementation 
> making our nodes[2] very complex.
> 

Can you explain a bit more here. Why do you need the wrapper rather than
just tracking in a circular ring all the copies offloaded? How does having
an enqueue API make this better? Can you perhaps give a trivial example
showing the difference it makes here? The examples you give below are
rather long to understand quickly.

Thanks,
/Bruce

> [1]https://github.com/MarvellEmbeddedProcessors/dao/blob/dao-devel/lib/common/dao_dma.h
> [2]https://github.com/MarvellEmbeddedProcessors/dao/blob/3f364261de91e355699bd9af20d60ea6459f7d67/lib/virtio_net/virtio_net_deq_ext.c#L51
> 
> >/Bruce
> 
> Thanks,
> Pavan.
> 
