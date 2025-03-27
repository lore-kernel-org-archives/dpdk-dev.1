Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C885EC3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 16:17:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4A1A406BB;
	Thu, 27 Mar 2025 17:17:57 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 7E38840654;
 Thu, 27 Mar 2025 17:17:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743092276; x=1774628276;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=6zasd91YSAa5UPE3ypalzlhtHGTPXWtTTaAHAWU68ts=;
 b=EO4v/y3WfJ/sNhogLzWiLY8VOAq/G62CkxOqWp0aJ4EEaeP3XHxJIQ3Z
 V4hNtlX3TKZ36FnAOhHY3AQqS4/BQEQD7ckdLUwOp+UwbKr+p5mK8laAk
 Zp1ur/tn3yMSbQvsN1mefVuTjAh/PUsAjBqoWVV43g08j85mMRRf0lbve
 38uPAeWqv//X4XJ4tm/D1rmerSQEXmNJRcZTUlwp3QVse/5GYsBxUG/cJ
 qqx232KJpYOOYMXcMlHNX4V7rwhLzSh1yLR6R4PNTflvVHaTT7YhYxNsi
 sMgZWChebTuqnmGxQ5wmzUA4hZE0aWrev9XXNibL0GZKCNW2rK9Ywp8NW A==;
X-CSE-ConnectionGUID: jsMXCQ/ITOOwOyKz/Ko4qQ==
X-CSE-MsgGUID: UMCgCxY8QS+P4QC5YE5xDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="55805285"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="55805285"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 09:17:54 -0700
X-CSE-ConnectionGUID: H9RgTPfeThqU51Ki8w681g==
X-CSE-MsgGUID: G78KzV0tQWGSchmAXCGxPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="130054691"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 09:17:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 27 Mar 2025 09:17:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Mar 2025 09:17:53 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Mar 2025 09:17:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=djTqlcd5c/AZgsQqiKIkO3yWJFT8EP1bPXaN0ioj4lny2P6WCRL6jdI2f7S0kDWHXj37q/mGFg85LR3goAjR9rl8bi3ba4lBHWmP5qvSERzCLevRG80lIF0FgbKcV7DHqyqkMvYJj7W/AYSkYT150qRCOi9Yxjn3K/TbJc7ahZX3zOmCzHeFLYii3dkwnitSkdiAL5Wx4U/HObE0iRJoTVbRxX5JLfoipT9T1i6kpWlXlRG2Ap5WKjcWgodD21Y0ms4uwtXLlPatTqy8CPfyoqZEISBAhFUd4m233BSbQGKHYIYEfIL6zFVLCszoKHaCXJhDaj82TJ/6CDeLDPS0bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KzM4V2Ugmo1DSFTpDA3mgnWGVxuQrxH3JLjj4uhcjJk=;
 b=r+dHDr89VrHIdbXc7q0asQ88Y9JBxncWNV6ME1zGqMbYHUpH9tuuY3VYJ3XEgrrO0stsM3RgbkRcnetMw9pfIrrVSL1qivREvAP4SM2zc2BGiVoeMl02WBJG+YC0aYaZWYjIlUSJ3lSccuOWq4iHBCQNpXu/vE0x+4GXDbFsq3iALh30i2eb21mVM2y3WkwOoAe6jLIf+BvQXSsJY7ikZiExSbHPEI+pl31Z/LoRBqYfQwpNcESmNlbYmR0Kjcd8GTSbsmJj7hlmbz8aQvn8lT1Lq5Be64hrQVNJwm//0kkZhvS5Yc3HqwXDJS4Qn6WC/ByoOKL8aF8nS+bryKxpbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 16:17:35 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 16:17:35 +0000
Date: Thu, 27 Mar 2025 16:17:30 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Etelson, Gregory" <getelson@nvidia.com>
CC: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>,
 <dev@dpdk.org>, <techboard@dpdk.org>, <thomas@monjalon.net>,
 <mkashani@nvidia.com>
Subject: Re: DPDK for rust
Message-ID: <Z-V6GohKhnK0ywu2@bricha3-mobl1.ger.corp.intel.com>
References: <20250306133713.393057-1-getelson@nvidia.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FB79@smartserver.smartshare.dk>
 <461725d-3c36-9b7f-c02d-f630dc8bc725@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <461725d-3c36-9b7f-c02d-f630dc8bc725@nvidia.com>
X-ClientProxiedBy: DB8PR06CA0057.eurprd06.prod.outlook.com
 (2603:10a6:10:120::31) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB7381:EE_
X-MS-Office365-Filtering-Correlation-Id: 21bc2da5-b626-44ed-66ae-08dd6d4ae2c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3qI4bO14+w7pjVWBO7RQpjE6RQZn6w7HTVRphjRL4B+OPY07zY26Wyk9RMQ+?=
 =?us-ascii?Q?XhfT7qoOcjxzrEJp+Utmg+GgistwV4jdQJx3k+OPy3fz/B0JZ2ZwMqvvp1dp?=
 =?us-ascii?Q?miZsTqefx+OCTfUyctI74UKJE5unRmYWD+frZ7DjdVFGnSmpeiTUAIqlRMMH?=
 =?us-ascii?Q?eIzKW0TKqaM6OttUBkaO9JBgASWqnbzEpknwwcbyp4BzaqQsgXK9RzgUHnwh?=
 =?us-ascii?Q?YhhUssjaMrZfWgbiiftHXYTMciNBE3W6YzCvYt6ITFN/9I2013NgACQXQ/HT?=
 =?us-ascii?Q?0ovZZsFoJywaqM31kfygNMqSxW265wpIlsVJ7YgjJLzKzBpWL+WD5OlW5thk?=
 =?us-ascii?Q?1huHWFmuR+DJMBovHXJxiz3TwU2/NckySqKvk2RcgHZhs8o23DJng0VvSy62?=
 =?us-ascii?Q?clxMQUdtZ9bTrkjczVtGzjbKm3uXGlFcU2R7k4LCScNlPUJsEL1GW26nak1u?=
 =?us-ascii?Q?2m40KQYnoJr9SX2JXhngU6vp4JQ/oR2O59y4PKWUFLDJRi/q2CTwTwtI4011?=
 =?us-ascii?Q?E1ibQQb9LisxjOxmA0jYeuPpLJ3wfrHLuP2Big5ew3uqYNO3uquIR9COJix6?=
 =?us-ascii?Q?m72n9nnyryCz1AqqwxRNfYi+eadrJrppJYdMA73gE6qh2A6R0P0yZAs7OmJL?=
 =?us-ascii?Q?XchhV4TXuuq9mh5UACVd7y1xYSEswkyu98sajJiGSChwAJ+FmEGIsOhBn2WR?=
 =?us-ascii?Q?7czCfw+prvPw2lLZoLMNkEb8CCq8FyHwh2n5MB4mKjr7xAhDBAl/AWHAKdgX?=
 =?us-ascii?Q?ndYuhGdpvCNiiG2jVuSXqDByeKk3AsAXcnv5ahWmbzv6yai/Ccc3W3UkDEW7?=
 =?us-ascii?Q?vX4Ao2QstxIFGxF6rJ3EU/zuWIC9doT39jELvRJNkmABKl69uJBtTgZzeoyG?=
 =?us-ascii?Q?ybKZJFUh0jez6qtojxJiN5P+dfYB+GPIk+mPVuWHpEhKrfZMk43iSMRBiSJd?=
 =?us-ascii?Q?UzNFYk06rzkT5/7yNic8N+UuoAK7J1OtiB2GJ5lrHJUR5WD1u8G2qbUJXhRu?=
 =?us-ascii?Q?TOCsQwjJp3iYwIA+xmM2x6om4KAC20iviheltIxZQW8/Ft3+zxbbgiJ/1njG?=
 =?us-ascii?Q?iN5H46adluqmNk6FG33wyTUlwSCktkFzb4zBS47tr1B133XS77Ffp1Hw2nyB?=
 =?us-ascii?Q?dzbb64Oid+KbyKWBuXZTwc++thSzBUjDmeYZrTf7sc2nq/LyKt76KTr5gI+G?=
 =?us-ascii?Q?J1m+KOJo+NrrV23PSkRRsNqtGpF5bO4lopveYouhg8o/G8k4Zon4/PzTtZbR?=
 =?us-ascii?Q?Xj+nGFLWcOa8Xx85udDRZ4xQWQW42RVPdWjTJ0X/8q/pd/euaK1MuKZvQZdk?=
 =?us-ascii?Q?01MPgubwk8bxZ3myRrM9SCI08J2hpXv5j/MwdwjIU6Bbj8aXeQl/c9s/1p5p?=
 =?us-ascii?Q?c3ar9B74Ozb3iIa84mXd3Zp5xyFY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JhviOg0NPpqhf0Sll7JwHCHyITaiC5yUFHe37yTVlTVXDtohF5a5avJZ7U4A?=
 =?us-ascii?Q?Sfb4XI58Pr22suJqUuJ/ED111g3+V9aRoIvlqK1wO/MIpaC1C//nRtrwGuG4?=
 =?us-ascii?Q?W33CWMNOGDNBXS9lmBEc1S7gyCyhWfJsEiAlWRiiMt4iOtl7WmfFGSjORsFG?=
 =?us-ascii?Q?v4JxMhIJ9NYnTUhvQNV0wYs6Gp6dK2UzrqALCBb7h4DAjJuKTSk6yTh6sjIN?=
 =?us-ascii?Q?dwaEBzGFzM6D7IkxOxQab+fSOCvRsuy4wOUtQBzYNIrFoIVJQwk6mqh+XYEI?=
 =?us-ascii?Q?eVaMncYTK5TL0O3HXNkol0neKTxzqINEaumxpyW3wUVDkInRdJt857d7Ltuq?=
 =?us-ascii?Q?E1ePfEjdxwcdOUv0C1dLSemV4a2Coo1qxT6KLcz+PkFtyLtK3N+1ffwrSNzw?=
 =?us-ascii?Q?L3UD16hQKddWbnEAVIEOWSszpURzOZ+wK03iItNagth/gb0/TMd2dguZPJlb?=
 =?us-ascii?Q?7GKDtpicthly37uUBr/xOAWDAqZm1bthGL/EsOlTgHWgQYncSa8SL/CTFmay?=
 =?us-ascii?Q?BYAMYDZ40W+ZOT6CtbKCW/fRoS2jYB5XYGlxEzq8z4wD5D+0Pm1Vrmy22lZf?=
 =?us-ascii?Q?TsKXFZ83bgcyvy6mTsG10dZVuZNcCzul2MG5W6+xoTwbaCXuloH5ovPuqrZo?=
 =?us-ascii?Q?3RkjZfFgOIkynUKn0ApFWeTvFu9Y7UJMqJsi+Deif/llsZ4ec/rq+TI9K/qB?=
 =?us-ascii?Q?gIuDFktvQYRQA4agOcKEUj6NkXMZAAQG9AuI6d2pFvr0gSthoWq4ryKkfABN?=
 =?us-ascii?Q?CcrQjeQ1tGkIJIXe1ykJR2zYyrIdBqNtUpspyeSnaCUhDVq5Tz6virTUi8fM?=
 =?us-ascii?Q?x2JZ66qI5pzbUaNnjawkdI6OiadxPMGbqUNooKd/K349udlzcB+CfAIVJm6y?=
 =?us-ascii?Q?Zs+6Ov9fohR2XcwVBxGG30TTrvQAqVSiWT4YrRQ/mEEKpbFQxRWNZq0+qGJq?=
 =?us-ascii?Q?o9it45gH90wAdJTIQLu7Ib0dgrhQoyU7Ys1TUiFBCbuY5FTiP4pZo77QI9BQ?=
 =?us-ascii?Q?lhJqfQn3UM9Yb4z2Xs49eQZzP125Kwq554gF5XPTaWapPs7TqU4jrIg0iAeM?=
 =?us-ascii?Q?SV9QyO2UOGsPGM0SGrZRXaVo8Z1ss8c1iPf02iD8Ni6gzYKWYVw7EXPA2sms?=
 =?us-ascii?Q?He6se2aFZLfWIIxaRwe60QLFOL2l6v7VGPJZSyBA3nhLW7e+UhWF+FOZBogs?=
 =?us-ascii?Q?5kNY86sRH05LioRrPmXJdzQW4GV7HqOosq6QPMfWQCikBcEPcQT7QdIx/fPH?=
 =?us-ascii?Q?zkfUT31eDETMCPUQUdhfv5cKMKVrDdbxDEiYZLzlICTTZT11iy3ZvwVcHK5m?=
 =?us-ascii?Q?Hy10Teg5B798B6acGRtjGUTgdHQt8Dwyu6+jLM6eWVVOG0y6m1R1e0212NZJ?=
 =?us-ascii?Q?iUZGtb3aIDgL++8ABs7sfck1nB3TVsTcUsQAzeY3F1ycwpUtSZ4LhrQzIVZa?=
 =?us-ascii?Q?kep6PYzRH4xU3Rpw467l6ai8cb/3yMBDXviFEMNrdNKCn5dpzbNd+L9bsjYH?=
 =?us-ascii?Q?/t+iyE1jCEewZORlI3kmAvY6XxsnPE3zHzEskvWco5Z44kCYKoV/rZ/4jEb2?=
 =?us-ascii?Q?dblXjH4+gFdGe0ws/JTmnFhvlLiNZce0p5AQaIrIHAoVw8ag9tCIFMI19pNS?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 21bc2da5-b626-44ed-66ae-08dd6d4ae2c7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 16:17:35.7508 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zuXjT05ge/1R9NvKwwrecVAIba3qjGtiN0vJe0ygL415ogQaNLiGlMwm93wFyZ6ttovCGvEyPAdeYdFcsdbIYI3y0yWF4dCiR5M747K0JdM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7381
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

On Thu, Mar 27, 2025 at 11:00:40AM +0200, Etelson, Gregory wrote:
> Hello Morten,
> 
> Thank you for raising these questions !
> 
> > 
> > Do we want the DPDK project itself to support rust?
> > Or should parts of this be a DPDK hosted project, like grout?
> 
> Rust packages management is different.
> Also DPDK Rust code will eventually provide a different API.
> At this stage, DPDK hosted project looks like a good idea.
> 

For ease of use, that would mean hosting a cargo registry, no?
