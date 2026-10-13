Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B48CC6B19
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 17:18:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B39840272;
	Tue, 13 Oct 2026 19:18:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 2500340269
 for <dev@dpdk.org>; Tue, 13 Oct 2026 19:18:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791911929; x=1823447929;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ALlJlW7C1dHj8+VVbzb9yBPFSGXcMlMmFbBiu7DIpZI=;
 b=YqwU+k4rfjKlAHnzE6ctFQF/r10dKppLgWTIXBoh1K/GLHle9ERJz7K7
 s0UYGkRx1p05RpCby6Qsda/qr3ZxL/n/7nvyR6iQMjL1z0XcSEtu7pgX3
 qVIxUfUmMQ6+5XmCyq2VOuTZaDNhd+RI5Ow1MgL8RZ5xwjr0OV4pf9P3C
 wf5yG1dSeXGPLch1GTVrfRDgKgg3isslzBNUsPgW2J2YGuW/XBPhIv2uU
 DRhZjpE+hLCiqCzlCzJNRkHvNFxu1di+c32PwbM4+hptTHKuMHGXGTAW/
 mftz7gbU2f2dZpJgoB6D2+wweTTk4aKY6bKOsZROVs/hPJKxtD0TZ33E/ w==;
X-CSE-ConnectionGUID: Q8X3s9aGQ0qUWkeyy9pTOQ==
X-CSE-MsgGUID: 9U3qC3ZtTv67Pj6e9SMmyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="639978"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="639978"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 10:18:47 -0700
X-CSE-ConnectionGUID: c9eC+0MVT+y2i/fJl0s18w==
X-CSE-MsgGUID: AWDEu1ALTMaXQOsz79jiSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1291512"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 10:18:47 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 10:18:46 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 10:18:46 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.56)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 10:18:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TExv5bHSzvgMw6odxLc9ycNEN7zUIRb+Y2FglVyXFCJDEX+xCrnhjkf8yUf49thJrjGdtybpQAbA5hU+nhuZ3nEv9IXrIUX7JqIjBc1bpzTP615Q831lzDyI8QvaRgxItVFGUtU41S4pVWn9b9B/QfWCNPwf+mBt9+BZaRIaYWngKIscMfaax0ccPnd4XWkd2/NeK8ClmSPu1dBA/ta6KgNVzgmJSeZwmBCfeJGamH9QpxZ8Zz/e5SMbk0GJ1dVFeun/h9Z6wrT9P6VMmDP0ey/FO3BTsNXumdDwZZrJ5g/I6kyRdMEs39M/KkphOyZzjXX3mqGtN5S8A9S5sPhwHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BF9PiEoU4SOOzhDmSfbaV2RkKrju6VP/TeDCkG5g2l4=;
 b=b1uj23KvLg687Xb2fYvWen+hfIeMM0nXQzzvVv/+zUsP4swNAEb2WHbZVFnQLcasGm6DW8dgt4kywVTcTq58Tf4MRwvakB+KY38n+g3mFsUjJITyhGqejE4DfdNMv6OIOgPLiBZTjZMTS7Lks2VaCpvpQZRin93ZTlCtIb9+dMmoXhXAP2QBQw3EmTkvtw+lNGacuzzdSyozApsXUYWgLgWSmMXZxIUPcvmXot0K0gZcvJa8gU2ZAz7OdyYZJta6FL90v+l0f4WNkfJOhRX7b+hi5RR05TCbhl+JYjCEdgAEQ11qflYi/xeqYpM3eOzreG8EMPJWrnYibzIOpmr34g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by IA1PR11MB6244.namprd11.prod.outlook.com (2603:10b6:208:3e6::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 17:18:35 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 17:18:34 +0000
Date: Tue, 13 Oct 2026 18:18:28 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v7 00/25] Building a better rte_flow parser
Message-ID: <as5n5Gd_ibUFwu8T@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1787233986.git.anatoly.burakov@intel.com>
 <cover.1791892574.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1791892574.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0047.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::16) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|IA1PR11MB6244:EE_
X-MS-Office365-Filtering-Correlation-Id: 190d5044-7728-40ea-1cfc-08df294e0278
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|22082099003|10067099003|18002099003|3023799007|4143699003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: jVT6Oi99xqytIvzq3ecGqVkduTbs8kAUXYb1tvzUx2r5KFeZ45t75wYCSzE5q1PJZeb4o3tnbJan+jF4METU+o9ZT8HUfL0pbUtivt/yBcLousZfI89Xf1lIvYzNH9MtWIlKk2EKS0wWEByi8NDIKDnhTrSmJrBAc5tPQzffSbt3vv//O6sJ6XUdODTwPB176wMBe9o4m96aKzTR6RyvT+zsO1hI15WWUR2becou0dBTvovTtiUs3tZVl8MN6DIVRY0Djzb4RZlaCkmHN42RqMqYn9FxqMqNky9RJERdo99G71muvA+T0aIUuejs1NhdiTarpsGoeZUc2t1ruZpH6PYIa+0q9D37N5AMVAKobsXKWmJunM1yWB51txFbD7Sbcj6tO6gP1JJE6dkuoF8noAsHrx9AE1Bb8otMFXI3RMTyXrB5eTFdA2vSTB2wO7RKkubCAYucFbgpMM3pIY7jwNJHOlz4+MHIvGt4FJAGHmIVZk5DKuJLYItaD5NBUBaElt85WqT/gWPD6BJO227eVGobJAWYChVSuUgHEj46QS71op9WIBZjpJlNRkscMaO3wg6qHCp9MlTAc5A8aiq8QF2dhQ7II3IAqBv3/8CtOs+JprJZCy0meawwDiaGv2WCaqezuybCxC9xr2Wg0zzYY5dPhmlAo3UCuBHfrXRyemY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(22082099003)(10067099003)(18002099003)(3023799007)(4143699003)(11063799006)(5023799004)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KkoRwqV+0iz4vZoLMoA7q3a8Vt0+lD9t8e6v4b5na4T+xNHT6YpX3dL3LOfn?=
 =?us-ascii?Q?oqKLpclr9XsjqAKe+bfyxvjLzTKhst/vwMGhGOoFcdMlyyAPz7DoPP5MUJ3e?=
 =?us-ascii?Q?XR39aRpuI3OfWiWcPbRre/E8b5GdqJ4AyQbjUiV2VPLgfTZCa947HVkV5aM/?=
 =?us-ascii?Q?g4xNySRC7/vqEsju47sHX1f3EMMWV6hJAstUFJyTwCyw97szTAJXHwcxE1dr?=
 =?us-ascii?Q?YzM1Q0dRNGS6rnnBD//VbM6CXs8xmTXXLkvljSBxmy3sSFVDJySEEnDuyOWW?=
 =?us-ascii?Q?eayEvk4Pexp9eRy7hNcDDRiS2d9t+FigPuU2gp+YnM3Q3Xl0k0qLEYzMqGbr?=
 =?us-ascii?Q?UXj9eirfgG4VaSzrWGRyyZkB2UI1W5mfgnYoqpXO2Tyi1yxj2nutmzph/L5a?=
 =?us-ascii?Q?/Cb75OTbNBjAZ4ZqSsaqlnz6FvJ99PntZxxj2D16poRAQpxsblruHzwE5lLB?=
 =?us-ascii?Q?J2qRRw65tUuV+aIlLa8bkRPPv0bbnpCn+liiQ5NZDRyYySENzwNk2Q3ozQrC?=
 =?us-ascii?Q?d89TsvWCvDTjwINnrYQOMw9YT5UMISDS9t1WTS2JoBMrCKxNH5WpVBsbE4eP?=
 =?us-ascii?Q?/tHSISUPhjvdfsoi69GGbjIzUyXjk03ZXexoZEpXYUn222CtVVtyCrh7dpBB?=
 =?us-ascii?Q?7rltK5QeejObyLdE5RuonwA5YTVFbP0P34JmFeIT/ST5wU+ZsQ7ruHoAxuIY?=
 =?us-ascii?Q?kAnOuJS9yyqFBKi0FxY0Xs/UACWe76Th/Dz8uPGehz+ojFgPZQz2cwwC2212?=
 =?us-ascii?Q?MOo/z1x7faSlTzutuLeYBTF6nCryIZTsA3EFcLtbIiO1jfjwGhSq3lGbQRho?=
 =?us-ascii?Q?JO0xk4jh8iJzpBKKWu9sT/XNxsi30vQ0eKySqKUGsMQGCJiN0Ol/rGBYNq2r?=
 =?us-ascii?Q?D9pj9SgeE+scd6PcKyKIUsX8ek0TOBMmiquQAH+APrIPHbe2AUhWu2fjhYmx?=
 =?us-ascii?Q?iFVsNSDwA2/4/xLI1WC1b++uBGXV1SdApBFz6tf7HzpdUfkBOEjKuhoXUe1E?=
 =?us-ascii?Q?b4mDcJyWJ66g1UrCg81p/Os1hvx03+i44PemeoLxPz/qndmgD5+HK+I7yvBQ?=
 =?us-ascii?Q?Txob4MQ2mTTId/d5+B4Q+MXO4rgN80TxUN+40hpwYd+qQqXxfUIB5M77KU2o?=
 =?us-ascii?Q?/lu/MpONTJdjig3uYX3xTKTLTQmgC/QIOyU5p/CkzrMdgxq2gZoP665UbLCe?=
 =?us-ascii?Q?Y2tmamxDMqzPLV11OUz78vgKtbHWMNVs59QB0CNU9EaBqCaSV5TNaxkkp/Lk?=
 =?us-ascii?Q?SGF7cyBmlF1Vuv8fgDxU9+cF69SwVGs11AajapaBkRfebA/EQEKf7sdXg+8G?=
 =?us-ascii?Q?NNAvTFojkpQ7CXVzWTYDGbxINEIWgOVVL1HR8ur8jjqt2+0c8uDt3ph3mXbS?=
 =?us-ascii?Q?aVjYO0lPHPkf5B2mjb4G+xECrsGyExi6lK6b4Q2D9NVhcSZ+1W1emoHssf54?=
 =?us-ascii?Q?FEYzAcfAst2cKsOrf14N9Ec6PkFHSBABmAT76n4QHe7K7F3MqGGVFMqwsdck?=
 =?us-ascii?Q?aWONe35KHbF1rhyRiJh6mNzaPaUwI2QFUBCL9N6ZxSi7eGiCUUOAq2tnBQcT?=
 =?us-ascii?Q?ehGcwg0cIbMKpb2L60dWyPVSgqAOVpnb9ngClrFPj2PlNWajg0zG4zmtBN/y?=
 =?us-ascii?Q?XxPsnVbSIp+wqgU/sU9wJihdtbfc7YXdPpypRIRtO864CltlulPQMblV0fon?=
 =?us-ascii?Q?PZ6E0bQvK/Htsb8cn7ajAK3w4XSAG1aNs9tX15XLJ2Haf1HbAjFDInZj10fm?=
 =?us-ascii?Q?U9KFyaOg2nKqmWSNWoLZrDb5UMXZHBs=3D?=
X-Exchange-RoutingPolicyChecked: oQDSIxVC7MUtlwMPnrbkBSJZskqi1ct25piETG+eZ1DPtg83vR6be2h3ufwYjXwfaLlK6WjIxmEjoWQPGtbcHSHdJMBGl3JeEh8XXoth7JN3H273hpNR4cHj+Z4BNJNtTu96T+dvytRIg6B8lxf2uo+e2XBJUAxMGSGg7QRL5PNd/lRuBD9nL77CmnzoQLsjCt3ZDZ1l3Ux8dQAzNC6ZnpGyeT0rTGN3e+hQ7pX/khxNe3wkGYSSHEUbA6184j/qsDalWbCXoYJe1XiG8wjesIZk53pVtb991i/7QClyV7GadP6nIVeY5XcGoQfwlIoi0Yh4mwebkGJmSpzQHULYOQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 190d5044-7728-40ea-1cfc-08df294e0278
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 17:18:33.8332 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oA5Tl9oVtXBET+zoAyIWDz6IKgIoghIuqS+AXxoF2BVukaos05u82fjFnutZoHIN6SMCT03/FqxG8wfKCEfMNBrAYjFFhj5O17VgLBvywQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6244
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

On Tue, Oct 13, 2026 at 01:02:58PM +0100, Anatoly Burakov wrote:
> Most rte_flow parsers in DPDK suffer from huge implementation complexity because
> even though 99% of what people use rte_flow parsers for is parsing protocol
> graphs, no parser is written explicitly as a graph. This patchset attempts to
> suggest a viable model to build rte_flow parsers as graphs, by offering a
> library to build rte_flow parser graphs without too much boilerplate and
> complexity.
> 
> Most of the patchset is about Intel drivers, but they are meant as
> reimplementations as well as examples for the rest of the community to assess
> how to build parsers using this new infrastructure. I expect the first three
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
> v6 -> v7:
> - Validate graph nodes only once, including start node
> - Stop trying new engines when context allocation fails
> - Typos/copyright year changes
> - Fixed ixgbe ethertype skipping over stale entries
> - Fixed ixgbe ntuple to correctly handle L4 protocols when they are not zero
> - Fixed ixgbe fdir to mask out impossible bits from the rule
> - Fixed ixgbe security engine only deleting first SA table entry
> - Reworked i40e ORT programming because these registers are global
> - Fixed i40e RSS validation to handle GTP protocols correctly
> - Fixed hash table names being too long in some cases
> 

Patchset applied to dpdk-next-net-intel.

As well as the arm build issue, I also fixed a number of checkpatch issues,
since there were a large number on this set. Most I kept unfixed, since I
felt the exceptions were reasonable, but please check what was applied in
case some issue was introduced with the checkpatch changes I made on apply.

Thanks,
/Bruce
