Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A37C43458
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Jul 2026 16:41:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A4CC40264;
	Tue,  7 Jul 2026 18:40:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id D53B940264
 for <dev@dpdk.org>; Tue,  7 Jul 2026 18:40:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783442451; x=1814978451;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=l6fi3ll4IhHbb7ixQqgwx2S2JXQfHxuJpmzQ+Nrc8NA=;
 b=QW9m+s6YHtDUvtT/2kzPPpNkIP6NQ2mhWkVlXrzBnRIjLOyKRozyuy0z
 n2AgPFFlKi5XSF1o0dpuX5w9l/+PWPUAkEGWXen+3VO9i8hXr3eVttFnl
 ldSUQqEWIFS81Kdn1Iu8l6ckS3UpPsz31rTd/XV1xmmzBern26BB8yNZb
 CDnE2VJgx9ekx/1lXOZyl+7YxdV0McBq+zYhan35zlU+Io/iZfOLQECBA
 edTIKP0T6YhgoK0R59GydSqsXNppuUSENcD3pV8mQqVdwjbYkpcncuO11
 OsQ9ze3+l7bMB3n+r4bKf7CBlMp47LS8AwWQC5GOE1jl1grsUNUSK0s2R Q==;
X-CSE-ConnectionGUID: pmxj1+k6Smu4nEFW6tqXFg==
X-CSE-MsgGUID: CVK1ceUtQV+KhNT1tfYm9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="109639264"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="109639264"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2026 09:40:49 -0700
X-CSE-ConnectionGUID: tDgvPe1bSbWPWA5fRrKAOQ==
X-CSE-MsgGUID: QrlbnZpLSb6rjoBTTsO+1Q==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2026 09:40:50 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 09:40:49 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 7 Jul 2026 09:40:49 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.2) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 09:40:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n95XUv3unwgUvAs4XoDTko0mmAuZclzBFQiWtPaJYW6ioEIS85qp8rC8wMOQ6xC7egnJaVi5Uxxka2srjs/9GjZJv7iQmts5SPAQUPyaQAOnM7+weXFa7sLtSsI9QQYuYdQTHajW4KfixYZ5SOO3pp67IeiIzSZeyIqBi1y+n8lSaUqNKPildXO76JEUzg7F/KCDJ1cjutjSTErBBRxFFNU/YPPJA3R6aGigGE7DbD7ssSoRNi7WzESKADzeFuoNIXHaKM46bymiF3RjNC3rEYvVlIesbGJyirX+D/14R1CfuT3qSichcDg+mcGzXcgRezhnEeO/JHXlBkElwgNGGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gj11zv/SxUZfXKsfpwluqxFi4FIwE3Ubh5Cdjt5voTA=;
 b=QK3/+crGvZhuAnanRT4h2rqu1aHoWh/IAnFaFl7iQ4XofF4gnAxzGf7DzOrair5t546Ea0O/3KkjMJyxI5g176zIIGXmnOYlyqLCenZuKw3PllAsbBXDzP4/iqDY+2CTQejkzehOhpWCFTgPzCthrJNEkdKPOgWRDWBgzVBDcRaqd30oebMsWGo2X3eJQm1wRR3SDfzFgYrp/c/Pi1C09Gwwih626bww2Bkf21XWG5j5t6xREM5risVj3Plg2Yljqb6PbfXSOA0sA9HjGrl6b1h0TuDsmFuxUwVvEcGAAMsA5mktJ5910YUH8GbbTTG0zg4D4FOC2HQWPV5HrZqOjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by DS0PR11MB7804.namprd11.prod.outlook.com (2603:10b6:8:f3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 16:40:46 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0181.009; Tue, 7 Jul 2026
 16:40:46 +0000
Date: Tue, 7 Jul 2026 17:40:41 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Joshua Washington <joshwash@google.com>
CC: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
Subject: Re: [PATCH v2 0/9] Stability fixes for GVE
Message-ID: <ak0sCcv12lp9vYzF@bricha3-mobl1.ger.corp.intel.com>
References: <20260703131308.2507403-1-joshwash@google.com>
 <20260703072721.18c5987a@phoenix.local>
 <CALuQH+UE2kJdfbny0qLSxB+izFSPTQJXVCwDNbUotrcQL4LYhw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CALuQH+UE2kJdfbny0qLSxB+izFSPTQJXVCwDNbUotrcQL4LYhw@mail.gmail.com>
X-ClientProxiedBy: DU6P191CA0035.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::11) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|DS0PR11MB7804:EE_
X-MS-Office365-Filtering-Correlation-Id: 53dd8831-81c0-49fc-ec64-08dedc467e9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|22082099003|4143699003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: Nt8V9NZBUkCN9K/uuhd1fhT8NEiPG7qxadNdF2fWd5ToyB/Fnv0Xv9Uh3X5CxVAx92wtKhCFMD575Q5MDtXLnshbrYcZjuQHvPab/Zs7uiGz1USwd5MI6Ysf6rym+pzY87z4QpDp8xpl/bR3DKMH78ml8mmuuSwoZvWOYces6UxwpDvvJZEDw4IC9g1+BdtXj5udxfV9QdSe97Egpp2oPzHitu3C99TdMk3VMVd7p28Hu8FhvmW7/33TICLPzP24mq52x2TlqLiPQUI3CWaREomIPOxK56iGBoHBUcegOh9MTJwVEddkRwQVwzvRrIRpcXqf0NYsvUOnW6vV2WGmqnmGqM9We7LbJ5AeACLMY6fSiYW9oIsLlyRlESTkmwckqCdjOm6ty4qsoHE66lGOa0Wq7iY8pouEsOhpH6PF5g60xIAIbGs6HyTT7h6EWyiqfoFO/VovFFeoznGx7TvxNPWBQjn48mhnnxvHmLpah+ytsRGt5XdQMquclVrkgzJquUHTJdbG+eyoz0bt2CJmyisoZ/Wv6rGKmNeRI1aly+dWhfzD/08hU/ZKKw7+L81qIcNqNuJRi5HlgIy6GV6eYCgLzLhf83Ijb4KTfZxTqUPEd7Irh8ZcbNP0+a2OfOA1mRHTVdNPTEDLWzbagdjDWZ8WwDOh8nNN1RZGzk3IW6Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(22082099003)(4143699003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kUc0Yit4QEEIEP83BHd7QAzLizUfC5uHXn/8xSeoPO2rKYNdF211y+gEE5aa?=
 =?us-ascii?Q?4HOOplWyBtpqpLzqx0MInMo82Rb6P9mfVUV0S0UjZOYtU8YFqtpM+k/dF4Rc?=
 =?us-ascii?Q?iBgvGhmbL6i9fT/e09/5pNVMPuqEsMTP53aeZK5dIXFvmIR0iqduI7rBL7OU?=
 =?us-ascii?Q?aw9Eb/6f+lvKKssb97WrF6HG0r5zYEXCYyfjmRI48JWYbWfKkQi+Fd8WbhcG?=
 =?us-ascii?Q?onj8cUQwWnMOHl9FlSYX78lw5pXMzOIUzgnQ/XJMRQFx/gyP/FGq+z2ovfaZ?=
 =?us-ascii?Q?hTaotpuCFV7mTbbhPb/tUfRprUEWwGvpRsmuug8BOF6OMKZfZkw1OFVfn//m?=
 =?us-ascii?Q?uHQjlyTuhMsHaW8L9zwcrV1hGog0dQ10ML8O3MPicxZC0IrzRrvyqDzAVHT0?=
 =?us-ascii?Q?H3O8EuEgXz4Hb5w8qcUjEAYdC59+Srl0ViC40HvtxGPAE3+PwH+JzRRfS6s0?=
 =?us-ascii?Q?Ze3BzCptc9SD/a+Dm4kaTp2WNSzh9VSTUgt1ksWwUBqJkT6ucOFejw/dmBPc?=
 =?us-ascii?Q?++MQuuTleqJjgmZDphMGjiPIxODEFQ5lb6q7aaSCwr2sABRR3FQE3cphkJO5?=
 =?us-ascii?Q?6M8T4WpsvJqKNFbVg1yZF1b+4dGNzNoNcCNJIO44FifATbQmg9A7V4gw2s5T?=
 =?us-ascii?Q?w1B1rBuQwvAnHvitacH5+fdd4PsZBibEkEBRx54BfDcL8h2LFDIwRysgr1sD?=
 =?us-ascii?Q?KefRce4Nk0JjYRkSd/t4WrSxACkijqT/1hQ2ZQU18WXuMf9BalucWKB2/6R4?=
 =?us-ascii?Q?uyOBBcseAKrn6EfKsaONzTMb5MPx8pvFS0KULGij4frw6eJyMZQAOcwbCuX/?=
 =?us-ascii?Q?qlYK11kKn815nSQ9L8COfodLxFBmBd/25wtteYiOqxe4O+wMbUUPe0QN9aXY?=
 =?us-ascii?Q?dRd/3AqqCBbsRpFfR8b9z7DFfI2NURx4Xksld84czp68spmeuoRW9mqZDXJO?=
 =?us-ascii?Q?Kn3oIZMKnIPZfpZ87S59kaGatDpZPWoWwLKdTpgKORNp9298miqHrJvbFDPL?=
 =?us-ascii?Q?BFv74AiV9FLVfe7yvlmElV000OqzMDbRLo9YDwjZmULXLPRwxSDMy4FLPdzg?=
 =?us-ascii?Q?2Got+Gp2knvLSPK05aMVebtrOfHx15ub0U69saBXmP3P+rMt0ufvxDmrUQ/p?=
 =?us-ascii?Q?6gobmAMHzbpyh+7vLXOdaL1rtJw2kyeTVRhM0mNB7YVygyuT30KcfTpl3TBf?=
 =?us-ascii?Q?fQmUh/EMd6di3+X80lb5UiMuol1Dn3mN6SrLudZ7HpLV1l7HP8RzOPHjaJ4C?=
 =?us-ascii?Q?UQMy4cV2r5/AUieFjdr/FLiQ+5BG6SXFUGon0YeZYe/XGfG8PteEYbuUh11D?=
 =?us-ascii?Q?RHwsfgUb/tTWitCaKKfnCL1zJKcFqHvX9u7JhGCjgx0o9gnKz0sZDL5pl+44?=
 =?us-ascii?Q?oVOXrQpDE5b2U1zx9dyoudwkUKfGv0Ui5KbmZYS7fcco/PoA7iiBv39sQu8J?=
 =?us-ascii?Q?xaDvkr23yQ7jAct3pnEKBM3x5A5wfLWO+tvJkNZQz9Knmsezl4yuf1slRGYX?=
 =?us-ascii?Q?eAVEXTthcdkBifF61uqQH869A4rBZe8gVI6aMOnUldWdWCmi1Olo7Tcx71/A?=
 =?us-ascii?Q?26PlPk5nRsEf30FZ1fWP/7Px9GXm8+vX5qsBaS7uXult8KKf3o2QYV0u194y?=
 =?us-ascii?Q?OUj78956uVQF4zvGeqLjX8sViTV0zkIikKXRHQXf0tr8PUPHSLnfIrTdCNXP?=
 =?us-ascii?Q?RW6vNhdBcpwQR4W3IobK4sZe7eRjNtS0DY9cjoyLp4QYRzaR2TRlcdAAiCmy?=
 =?us-ascii?Q?qxol0fGIczL6QaVRrTAbgcoAq+tbJTw=3D?=
X-Exchange-RoutingPolicyChecked: oE+vjvDJg/d/rV2FIcDNHfvuvnm97WWk2GRpMJQs2Azz6uoNtQzSEpY0rirLodf4A2TFCwk5L9HDqfKLZcgvOl1nw+lJQG2iYVYiDWB/GixsR9yYLx0dGnIClvBqWjKEho3cAC+JZZ9+G7NWnxKDoddiFfT5htki8S1Vvkr3da9X2IUqxgBm6HXMmRMs2PoNsLZI4v8Vm8MUg5PmnHqJX/+R1hmpcoIoK23e6me9eK7UcTm4gOs7HBoeAzrQUArGfPBqCxeWaZeyC+ynnqUT9m9sjLKEjc5/u0E0l4dSPcJ9QfaQrxZQrSy93llEP1CRi1D6gkij9NTPSAuEn79gkQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 53dd8831-81c0-49fc-ec64-08dedc467e9b
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 16:40:46.5536 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZVMrluP5Z64cBYvZde7KJVOhhlNHqEvz0kAbnL79kj8JUUcQlovRY9FQQCLWDh4NjpsfCn9TMPXM0j9U4ErXEJyh6eDEzqGnX+X7FSTmyfs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7804
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

On Tue, Jul 07, 2026 at 12:02:18PM -0400, Joshua Washington wrote:
> >
> > Better but fails on 32 bit build during post-merge testing
> > DPDK 26.07.0-rc2
> 
> Will fix in v3. Is there a way I can test 32-bit compile using
> test-meson-builds.sh? It doesn't seem to be covered there by default.

It is covered if the necessary 32-bit multilib packages are available. I
verified using my ubuntu install here, and after installing gcc-multilib
package I had 32-bit builds from test-meson-builds.sh. Unfortunately, the
multilib package for 32-bit conflicts with the packages for arm and PPC
building, which is why I didnt have them installed myself before now.

/Bruce
