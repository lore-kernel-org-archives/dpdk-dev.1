Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747EFEB26E0
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 16:47:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E12140608;
	Tue, 10 Feb 2026 17:47:17 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 46A084042F
 for <dev@dpdk.org>; Tue, 10 Feb 2026 17:47:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770742036; x=1802278036;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=OG4Y177l8027ij6UbRzWtNtc0GrplrTQYII7HEZCwJs=;
 b=cqmA2AXmGiP2Vb+kIQflPeeVR/FvXpskW1nOFn+CkodUV8dwA+7oOttq
 wUfDci8U117/JSFZP4RWlKSRV8+mhxEv0UgyxMR10hyQ6Okwe7zq0yCx0
 cJJ/81jDBE+AG4SXtDYJr9odMs0gNT/V8zw7BomYTOLKsxYpnG87jEPN0
 R/Z66CXlbMCqxy4dmxh/33gK0bVpHdQuNZRZAu6DiUOuvOa1gQV8olgci
 3Pz949xZ3DeLaUZVKDpmKgb2/eN8rKzxWBtHjZ9DB52E5UfYIZEW8hjCr
 YwVHcBsbertDXrLRtRKkaqhaoBorO4FsIJOjQhmKoZWgInFUCrtZ3FK+8 Q==;
X-CSE-ConnectionGUID: ety4URm5SfWh/TrJLHPwLQ==
X-CSE-MsgGUID: zlFA1BurQtq0axxjBKYEXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="89290512"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="89290512"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 08:47:15 -0800
X-CSE-ConnectionGUID: GUpliwyIQSm2phiLgVOt3Q==
X-CSE-MsgGUID: x7wq6DDXQgyB9VPvZ/EAwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211009152"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 08:47:15 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 08:47:14 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 08:47:14 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.0) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 08:47:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yZ/Si6oq81naZLrzMhwvtR/1ji3DOCrlo03F81Gfw2hFbGwjV0CfHj3hi9EAsqp2J4Ntc1XLtLMoKakroMctxm/MnUf5sapMeyh32cq2KqMyUSbgC++DNd0LOKKe4AC24yJUI2WzPls1VfXwn5xH7GNC6dKyDDuvOJAptBEBZ8UUWYc1ga4LNFcxbRqwKH6NpH9d80/EeOkqzW8XSuaYu3bqQb+MGE7jplyg4rR+k5i0FmEWxzOAYlgxEOHevjhO2w2s/fqgl2M36esndOqbAI+A12Y+sudg2bzu7pP4DD9x5Odm6enLjVH11yrYyXwfFFWSsxvljCnFDBNpAKDv1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xhj8Bd+vvBBTUxYCsX+zoseW40+HObIpdJEjGb4ZeA=;
 b=i24fRS9oACpxpFvmgHZ7LesUr7EqMIehuK7apfdbT1eyScD662HerxEzEXZIKwQN6Xw8njCLgM1mj3yFiCZAhZoCkr/w2ErHnCJkDWBrd6Hx4YQMsAWtKzoJFLCqcqT2Gdo4oO0lY4oVTJt/XP3cNqpAO5vY7qcgvLS37SWCWZMf/wmdqu2/8D7vn5tx6v/p1jOzrPqhhqrQSa+Q7pN9bI0D1Bnx7b8cgDqaX3sjYix+2s0g3qy3I8SCTsHGaNyzD9iL9hZ1XZDdRy41McfEV8edJBLinf9TupxK3lIKiugoYhJtpyHkoRTF5FSTZBfSZaXCSIhP7zkHBX8mlWsbMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA3PR11MB9062.namprd11.prod.outlook.com (2603:10b6:208:577::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.16; Tue, 10 Feb
 2026 16:47:12 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 16:47:12 +0000
Date: Tue, 10 Feb 2026 16:47:07 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>, Praveen Shetty
 <praveen.shetty@intel.com>
Subject: Re: [PATCH v4 04/35] net/intel: consolidate definitions for Tx desc
 fields
Message-ID: <aYthC8nabQT3SaPt@bricha3-mobl1.ger.corp.intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-5-bruce.richardson@intel.com>
 <8e683730-a57a-4d12-88a1-7268dc507c4c@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8e683730-a57a-4d12-88a1-7268dc507c4c@intel.com>
X-ClientProxiedBy: DU7PR01CA0002.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::24) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA3PR11MB9062:EE_
X-MS-Office365-Filtering-Correlation-Id: f96f3b17-e8d7-4966-5045-08de68c409f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5AQK8dAn05W2pt452P/jLYN6sDP0UVyYt89RA++YYB+Ylq/MK/AufcI9lHCx?=
 =?us-ascii?Q?ygUbJpqyYMK/0CyLpi4FMGxbqZ9TJfMLkk5eqS3jyxn4dsksGRTNQ+nuFgSz?=
 =?us-ascii?Q?0n+GeoSLNSGPyIm6dKYQBn2JRVvR///dSiB+UpxLoKO73j760SUh/fokgQdG?=
 =?us-ascii?Q?UmKBIFeg8OxvDuVySxRGPX8O+m7rkD9uWXPPgxgt5ujpw+ela/zqzLKc9gEi?=
 =?us-ascii?Q?bAsnJXfD1YFSl+HlgdAHR4AmIJzRcBfnWapiC8QC5zzVbXiQX54kVPx13Lbe?=
 =?us-ascii?Q?JLomIGOFibOYsqZKQkJHvPL1psn6KQqZGrmp5wBnrIJ9AruJDgam37rHJSNv?=
 =?us-ascii?Q?eQ4SBAWW1SAluU00x1bgEASTrDSMrYchN9SwrheTkRqXnrgxf3rTfOXKGCWO?=
 =?us-ascii?Q?DfMZ3Z5lQ3JwwQdD59u2g8PL8kQZcVHtDoUbolrTNn6AIVtDHID8JkBlMOcw?=
 =?us-ascii?Q?CN8TZ+SgwlBG3s51t6ubsktYQSxeFgzRLhr7gHBtPL9Mju9m3z6/yq4yi9iL?=
 =?us-ascii?Q?91cHmMaCXLdZ+nsbwhslQmEDHO+nWTEZ67BFHfivWeL1aoFfiOnTJt4PgOl5?=
 =?us-ascii?Q?QiEc0mE31/i6IFGMd7HQkuIzSfian8ANhtVXeKe2HxW6QQmVzPdBGLdvkDaI?=
 =?us-ascii?Q?1Y93pc5GqI2A57gbpCKzt01taMGD0T8n9ajoCRPYpupXYJewW39uXvlXnkMI?=
 =?us-ascii?Q?AlHKpSyj4yb5Isjv08AU8s4w0+pmvYuQFQ2zjj6eGvwdHqdBuYtfAgoN6clP?=
 =?us-ascii?Q?a8lrBmi+9XcQrqP1ediWqc2gTVmVLueKZaswClH8mjL72xRCxSOhE0DuedT7?=
 =?us-ascii?Q?VQAgegkFFM7WZ89gAMZ+fOdBwNqUSja1zQXiprSNurvRMhoYEpC1OPUyXaHd?=
 =?us-ascii?Q?YdHpBDrXVuHgr1N0jfQ1JZ5wZFFTDSUHs1iYG/cEuw2FM+Hqr18vB59j+ZtP?=
 =?us-ascii?Q?8pn6TTicvfsDg8WcMZQCu1XqLl3F+dSvyic9uwf0PksGri3Be8/QEYhyqV2Y?=
 =?us-ascii?Q?jOFdkJFV6SQxlSLwSY4kxcfMVc6E5D5Up1A0YW6sk/XUssS+xdVCFMc24hex?=
 =?us-ascii?Q?nl0Qbgrh5261inv0fOb3LKfL55ngbyrUhwW/7Sw47JYaluBHqTsNITEd7hEz?=
 =?us-ascii?Q?e053sQXO158XfbzNUE5AQOHWx0NTmuzsZfuoows4UKGnjqn0SNOzbFw0HJ0Q?=
 =?us-ascii?Q?Gs1ApS15nZxLQkvL5re+ad1y+emv7xku78qcTb5haFZ56vFYqvN0mCkwtPoQ?=
 =?us-ascii?Q?+yapIeZLpfltd4tEch16C13FGsLixl9jw3PCrBBSYTK7R/QTl5P360HnhEuA?=
 =?us-ascii?Q?BujMNTDOO+Lm/PR2W13HC/TA/TGib8GJZzAiVVe39NoZds4EJPn9MJypwWYg?=
 =?us-ascii?Q?FbuXPWMY3j8QrFXIymT0UOEe078u0xBxlEwVvgf+lHPPlq3ZDTkvrlpbz2cE?=
 =?us-ascii?Q?4J9vBNvdF3/TyCHFDxgyIRi1XzjpA1y6miAAIYmxYadXFb3ywjnap6oxMIiY?=
 =?us-ascii?Q?Pm7EshdVkgt9MoGbvyDv29xePl164lqGoYydk+loNhZF12EmzXuIjnlxxfpA?=
 =?us-ascii?Q?xfZI03H/0YtD3bfM43g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YNijgt0JptVnOX5oMQYhvxuxmAPCkb8AlV4jz0mjJAVcJB+kwEopeW5eU+j1?=
 =?us-ascii?Q?bdAYsoNiZ6c3+oVAike/QjTqGzbjVsTE5pncxaJQjbrjpuSNZb/BG/JY7OT1?=
 =?us-ascii?Q?xV0X7A/6skWCpUST5pMaNNSE7eDj71ymhTbZB2jyMkoTXTJbdxuRDz8uBWCx?=
 =?us-ascii?Q?Pzr7Nlaj5q5veTTTxF3lBnSxUb/OVTBSeHMA9vc6TUSOiJG6wpHXmzt3nAZl?=
 =?us-ascii?Q?/CZvYI5eFORMRSpvksF/bJSGcgSSkosYREDwRMpgpJSjZz7sWgOAsbBWEzgS?=
 =?us-ascii?Q?aTsI4f3agvrncqt2t6DTUU9hseR9tvV03+ReBxRwg9yNXtYbhqDAERRohoiS?=
 =?us-ascii?Q?QU8+dnd7yX07x2VuTyqGVLAGVaw0jnI5XKSm+GYL9QAzYaHsgoqLewkLXR3C?=
 =?us-ascii?Q?cWSL/P5rI/2iBG2OXDt3809zBlGw4A2MfXKTSKwZhLyzHryqS0VgV50UNti2?=
 =?us-ascii?Q?uj7hFqIXEc0Um2W31ZIs6iunL2Z+sLJ6iyPX6IwLV+9n1T1dt3cGadZfGUJY?=
 =?us-ascii?Q?6pn3VKG7DoOvqvVxdJG6vAM87ZOthMWuwpNvXS6M3qqIoPiOmfqqkknDSWHx?=
 =?us-ascii?Q?Lh83UWNvZInj8QVVECcsgbdfFEIQTMQk3//LI7X3gCR7HR/5WRXaycHJc6Ff?=
 =?us-ascii?Q?qVQ47VobHsCyDBgN3zyv29mgENHjlHH6lgDtzVXUR2IOm/zMQGYU0aLPaalG?=
 =?us-ascii?Q?ShFI8ktnQIYExCBgeoFJyYVT5Fo+dBxx+3jq4f95aulr1Ddt+kGczHRyNYLn?=
 =?us-ascii?Q?WuiFPM3itGvxEVgT5wH4jRDepS39pbOKWFSBMUdSQcwlwhxjkqQ3YKmonoPq?=
 =?us-ascii?Q?000uAYteYXOPd1BirrI7k4g/bVHVXgQNwjttyDn3In8949IP85+zUDt9t4B+?=
 =?us-ascii?Q?CpUvTGeXLPe0iSpWoJ46odc9WjdMJVwFya4uMGwQVjBTzAU6x46TW2o+YIOH?=
 =?us-ascii?Q?+T7SQfaO9O0JhDXcUGxejlAcaOXGMvpDiISHmObqhV+WiCSFAPWEI6jPoa1f?=
 =?us-ascii?Q?op8srQgtlCEHGtQttdqLkfOPK8eLs68wnn23KQpg9SN5YdSIIrgWg3KRFLMp?=
 =?us-ascii?Q?L96TG7615kxd3Yy+7VG99zcpxXQ25stqYG1mj60ZDNucQKnpwRT+bvHmAL/1?=
 =?us-ascii?Q?K4BLBB33r7+cmDikSjBMm8Ot4JI8gb0FnqkAB75i9pq6U+1fl6Tu1re1hrCb?=
 =?us-ascii?Q?oonan1m1JZkiMYSoJBBf6/O9tEi/ns44RwEUjYJ18itZH+GmqilryHDbpic5?=
 =?us-ascii?Q?V6Fi6K3Tndbez0Lb+q33ljvMtlh1yoNOZSPUfK1btGcxTTbA9OUE3un+9vDs?=
 =?us-ascii?Q?g2Wi8Kw0m+/KvItU/KqosXtlCAjXFFJ33kb2MqZ42DeBIJ9iVCcyDmDG4hhW?=
 =?us-ascii?Q?pPvVaoyrZMzQkmZuqKwohHP2yS4bm57tJCvvUCngFcUQpg81BeRrixP2I2rJ?=
 =?us-ascii?Q?Y2ypFJdpXzBypiVcbfFUNXg8xYok7W30d/CjfelaCujsUioQLmd8lhQtv007?=
 =?us-ascii?Q?WyhDXGSVorev4JUYfi8i2YLJPCFETJYBd7hW99PM1xuPSB6Imk9pdchJT5VD?=
 =?us-ascii?Q?MWgT0ntsTK00YkGiEViWQgU2Hb94GdPnJ9CTQ2l4encQjC7GaW3GVl8XwoMV?=
 =?us-ascii?Q?WNUqLfZvquwkISFb2nkNKdC844HHVy3TOlVZziz5nA8N7dNRTYYYTk+s7g3B?=
 =?us-ascii?Q?wCiQw5ThQHO5fK7QZ3vUiA/C64QackrhJ5t94eN0sQuUSXtLkjqxEb6rF0WU?=
 =?us-ascii?Q?4hkMbgfb3qiz9Gapgi6xj9BiUzbtTlo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f96f3b17-e8d7-4966-5045-08de68c409f9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 16:47:12.4837 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g8nKUl1KGk8SW0C82S9azLcAKIf1IpftqGagpdKWoIE1d1lgeBv1R0m1JrVdlNNVQBn906WgQSOIzmw3Us2USzt4vL9WF1gx8Tjtha4HO68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9062
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

On Tue, Feb 10, 2026 at 01:26:19PM +0100, Burakov, Anatoly wrote:
> On 2/9/2026 5:45 PM, Bruce Richardson wrote:
> > The offsets of the various fields within the Tx descriptors are common
> > for i40e, iavf, ice and idpf, so put a single set of defines in tx.h and
> > use those throughout all drivers. (NOTE: there was a small difference in
> > mask of CMD field between drivers depending on whether reserved fields
> > or not were included. Those can be ignored as those bits are unused in
> > the drivers for which they are reserved). Similarly, the various flag
> > fields, such as End-of-packet (EOP) and Report-status (RS) are the same,
> > as are offload definitions so consolidate them.
> 
> Nitpick: the NOTE should IMO be separated, as otherwise the flow of the
> commit message is a bit confusing, as the latter part kinda parses as being
> part of the NOTE section that accidentally got left out of the parens,
> instead of being a continuation of the pre-NOTE section.
> 
Splitting into separate paragraphs for v5.
