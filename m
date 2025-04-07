Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C158BC3601E
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Apr 2025 12:47:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D450E40156;
	Mon,  7 Apr 2025 14:47:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 89CC140041;
 Mon,  7 Apr 2025 14:47:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744030076; x=1775566076;
 h=date:from:to:cc:subject:message-id:
 content-transfer-encoding:mime-version;
 bh=pL3BALvfC+QChhIf43tnAy82NjtYd7E9MyMKZ6TEoAw=;
 b=LbZrSEzImXEUkJGqoPsWe7U9LZptqK0FMAfqEYKeQpmWB2HYraaT+FMi
 Wky0qWm6EtdN33cpc2qPtNCsBlwdfyDLMOuEPOdPPqIKexUvN+t0glP2n
 9V+BDe7xAoA6Y26vGzZFrQXMtzc2GgLjnKkAEG2WuVZOVVyVg5Zf4C18P
 27a9Zs44+4u1jSL6HiVXH9vRvBMt0xGqOTifFNnx5hLgC9Eh0J7T70Mrw
 qB9kx8kIrR5o5kG01U6FFgYTgIeFAfBEjjYpEfxCm7j9sVfH1y0+nlr4C
 x0Xx4qmu30SG5bOcLGOTzsthABG34ggBqypLCR4SlL0Jgp3SKMJDGCDzz A==;
X-CSE-ConnectionGUID: rqcXOUpfRdOtaZiloFLlZw==
X-CSE-MsgGUID: 27o34U2jT1ebPB30lrd17w==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="48127646"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="48127646"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 05:47:55 -0700
X-CSE-ConnectionGUID: ESB1JIpMT2izhE9VZuRJjg==
X-CSE-MsgGUID: qVCMrr1OQd6v/vVHePbZ6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="165148320"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 05:47:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 7 Apr 2025 05:47:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 7 Apr 2025 05:47:54 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 7 Apr 2025 05:47:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HD1uMGoD9TqPUe4MNAL177woABNWuXDNilptkqdSvjz0hmpXwXqNZkeJ8u3znkrk+z+lYmvBL8ZmXb766ho2o1WcpnT9bKd7JyS1GbYwNmuge2jX0zSO8boIGSZZM+R3OLqG/Fl9tEW1B/mq7WgrHL8CxIscIJ5xvU1+/U0Mu8LCa8HwaFTZxgCgbIuaYHVBE0Odmf9Yip2BZ8ZesxoHhQN3w5CcX8H/Wey4+WnIWTNCscTaAf7HbSpmHKOa496ELyL0JqgXBzj2KImoyUEE+RZnhx6Mx5gveVL5NS4pOlrS7byuvIbr02x5QZKwPF5gR3JhPOzOO+F+pTqa3PWE9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1jdsYHZNwWyUqkeO7QVUc5pSKKsxJx2hLxmOtmXJhE=;
 b=BUJK/WGuYHTOq1xEXEjGDgDq9WV740Pl0XHDLwThsvKpjVDBjP8X681+NTD19NbEaWG8Ir8xtxJjM6Js0qMHQwaQlz21ItwQNqCQI/ZtwMh6htucl3YOylZBSb09coAYV9KZSibsEAkJEA5gDRy7OUhCtuYu6+I4d0vYhMnS7+b0RmMMDVOLXrfe2d9rOLZrwNkMfFHmqemEmXKKiR031Et2AjytL1KthLQlUV0Fk1dl6572lHuOgnX5O4NZvyR3JmGsHk18tgjez+MQ6QjEr3PJE+pdixg86wdN1WvooIIOu95oftRo4epG3YOi+FcRVQf81Fren15kLK/8SsRNsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB8009.namprd11.prod.outlook.com (2603:10b6:510:248::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.46; Mon, 7 Apr
 2025 12:47:51 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%6]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 12:47:51 +0000
Date: Mon, 7 Apr 2025 13:47:47 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
CC: <techboard@dpdk.org>
Subject: Tech Board Meeting Minutes - 2025-Apr-02
Message-ID: <Z_PJczJAn2Rp1iPS@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB8PR06CA0064.eurprd06.prod.outlook.com
 (2603:10a6:10:120::38) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB8009:EE_
X-MS-Office365-Filtering-Correlation-Id: 65a2e8bd-ec20-4c1d-d796-08dd75d2687d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?pkbnDhDY0Hhk9EhCQ74laTS0KxEy2a2JU8JtpiRSA8vrNyPzbV6YCQOrtW?=
 =?iso-8859-1?Q?oLgKc3FuaZ3rcJ12ytlJ1S5t7lAj0Cbxy+9ztf8/F2+DxoeBRqSTmO061B?=
 =?iso-8859-1?Q?ZUtOgxZOVkix+CTQ82af3jplp31b4UPzSRILYfU4YEfggSyEzMQEXyaIoz?=
 =?iso-8859-1?Q?nUTiH4vd2rXiwrYxGY7nnZGrmChXYjINZiKEYL1s07LjtDl5o/tK41gQIC?=
 =?iso-8859-1?Q?pItoK21U36SOhkHOBMk8FjDAyDL3qPjraQ22DPPVwsqWOmCXwBlioZS9LZ?=
 =?iso-8859-1?Q?iPtXkpDM295Zsz5Uz5jKBV0In76VOW/N9v9nrhfgBtuccjxRtLi3V47iJt?=
 =?iso-8859-1?Q?bgwH+DaXNs47c04/dnha99375p+x0GvBmG0bDDte/vwIW4+/XKH+Mpl/f7?=
 =?iso-8859-1?Q?7WbnLyvIFiW6g5IAo1H0jeR5JbH8NxaQz3/1+cpu2cviq+FJMGm2UZ3kG4?=
 =?iso-8859-1?Q?KLjsTGKEiOx1QrUm5flK1I7gDiyWUSgF1MT2Pj+v4MoMuLjXl3IwYZ5dOX?=
 =?iso-8859-1?Q?C4uEuPQWTjTSHAVHsgA+FsDD2GYdR2NDXZOZHUrMB9KQMCjboV5axgO8ge?=
 =?iso-8859-1?Q?udVZcVVlG5eBmXlBCAqadZNm6g+6TVWI8yR/xUcIVDOtcbvp/zAJwoeseH?=
 =?iso-8859-1?Q?ed20swlDicShHhiN9+tcGF+Vlx3Pb30Ry924u9OmQNgSUfczluBQnJ/kkh?=
 =?iso-8859-1?Q?KvSj49r23ofrRRigGZeDTkhLdIM8xKdEn3TX7g/Mom0wjH9TmKNK9j8tYg?=
 =?iso-8859-1?Q?SxgHpW+wH3QWmvRFzTy2WECnojCsxiiXmB7l6fDttGD3Dkj6qTxAfNNCvs?=
 =?iso-8859-1?Q?Q4pRI+1Bcg53iO9zLScsFDJVqhHpB3IIASsXeTmoae54pplGFZmmv6jVo0?=
 =?iso-8859-1?Q?p+Caht+FgLPQsqgRRNpH0DH+umh5v5n678S9thmE1O3NKwUw7+n8LQzKu2?=
 =?iso-8859-1?Q?XDgNY6kJ1MxdXn70bBxHGmNss0yfVqC6TgjEbFe/L7GnkMFyao54M2FURv?=
 =?iso-8859-1?Q?n81A6w/fZ43WbsX+TP58e9i5KWEMiqUJIwllOfSFcQYEa7m65cdv4XglTV?=
 =?iso-8859-1?Q?3pmcUWG4JJAoBqYD9aS9SNFQOCUCzrpAJUxFhvMHkkCcXuPkkhYI95PY52?=
 =?iso-8859-1?Q?i4okT45DtvbJ+A3yIoQ+dCeWBLrrcfaPrlcwT0YMVijj7fnGDfoVzf8f2J?=
 =?iso-8859-1?Q?uoUsC1hZnyYcHOJ8554qodnhATagqpAlzTQnbYxJ52KchvYBQ6QfIKbxlb?=
 =?iso-8859-1?Q?mgJNpvk9f/x4cV3e/j2DR2adPj6gyvBxvLxRiNiS1/xfmrPvjgb5f8vXqe?=
 =?iso-8859-1?Q?RFYh18/bmSgpWR+Y7AbatHqN64oWEpJOsqziCSQuI8YUFlUO4IZ/w1HLrV?=
 =?iso-8859-1?Q?2sfZvaIyhi4yihptJ47bB8WaEFNZg9AUmwE4AHdmja78zlkBLRjkcSYwQq?=
 =?iso-8859-1?Q?yg+BXUu7F2oW6YVE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?x6OsroA+VJWRnreQd17WA0xRPgTo98y9I+2YvYkKeMTCwg6ISY6FCxsqXN?=
 =?iso-8859-1?Q?6eo2rrh9FyEqN5PtI4+zEh/Ics4d2Bvgyu0/wS6114iPcR1yJIRGCcUD+A?=
 =?iso-8859-1?Q?sitTDMKDGCiG1NwZ/G0rMAr+mEEmmEv7tn8ol5sZ3SK0mis90VAOW3R2ag?=
 =?iso-8859-1?Q?W61VbCENhBrTaMAl8qvgSst9GPWrMMWlBR2IJhJe+GGvjoj3UB9mKMq1hj?=
 =?iso-8859-1?Q?js8is3KXbzsTNSly8BHBQAgjFmLRDPe07vsxTlHSgPd18Bip7KQo9je9yN?=
 =?iso-8859-1?Q?mhQu5DNtDk16ajms+IK6lamejOrCZIIonGqYdGmKZpU/qod775shRfluHW?=
 =?iso-8859-1?Q?tsyxLyUJcP9o5b3yiMj4CinnLByTqpuaKX/Fw35mQKxr4XtZSEBmbzUu9v?=
 =?iso-8859-1?Q?fll3WV9eIOXF19ueCSVfmiQByuZs/oHAsCdcURo2RzExtLH1EFluQTxWZ5?=
 =?iso-8859-1?Q?dIJV9O9yMWAZbWAYKD8mkbxv95+gDpHe+stRbVAn9O3kVO3vh5CAP5y05F?=
 =?iso-8859-1?Q?4GokrjnckrccatQiGHFg/2YGjnD27ipAWAtzJSojSsxRxNyTzxnN8VJ4LD?=
 =?iso-8859-1?Q?7vTs/QvRw8DIbPo5ZRJV8QDMb4MliyPoFaEkrFyQqpCTA0FOwGi4G0Is3+?=
 =?iso-8859-1?Q?kAXlj7TDVAljJzhAHKMIbUyMdGwWF2/Vs+EW/QkggekpsxuMiPvRqKZknc?=
 =?iso-8859-1?Q?uGOQCqxnrHVKlgM3HjzJH2CtwOqEgwwCYqTf7JoeD+Hdft9eMME2fC6Hto?=
 =?iso-8859-1?Q?3Pz48iieASMrCe9Guu+QG1aZFesZUz/0MSDKXbI8v/+g/o4qZZxpmGNPv4?=
 =?iso-8859-1?Q?eiUpp8FlVirNeT7r6q76LeExSRKy4tZSteY7KscP6mi4YOl6Q3Ng+q1s8k?=
 =?iso-8859-1?Q?AcVtAKhwNr1lAwJbRuwGw+nTxlD5y05JbJh4o+QoxcsL6lqd3rA7IFvUr8?=
 =?iso-8859-1?Q?RN72jL+OxvaSl77It60SStqlrUiBnnSd+hGOt2UOdrldSQj+h7O88vPNgs?=
 =?iso-8859-1?Q?UiNqqoPilBo5gbMPDdcdydeY31Sg66wL5tzxdNmCbVfDAgz7snHYxh4AAd?=
 =?iso-8859-1?Q?w6LSZfadVB1+tk4R3XRqI8SQaDBrx5PcjSFbqtnGyExJjzJB3CDQnKCLmA?=
 =?iso-8859-1?Q?FjnLn//WUSwjatHl8iCW9lG0+g4jb7aKTRMqUSBO91YayUf2Ih8SkKLzKF?=
 =?iso-8859-1?Q?cr97lIhk0hA/jo3MYTeuk8yHOBK/HjiIiiDDZ+VJiNhCNs7FtgH0FOltEE?=
 =?iso-8859-1?Q?dWEuQX1/skOBsKsJLcX7vMML28SSWojJIkcRnyvyvYpnvsCxIrJnLeDdGI?=
 =?iso-8859-1?Q?53fiqCL0WH3nVUnRJWJBuHXcEqnGACkrAi8L2fKfcP+eDu0aG0iwHnmkiE?=
 =?iso-8859-1?Q?GeSZpa6SrnHPXCsEnG6OmnUJsrSHyGDHEGrEM04/xyhbgFrollgGmkI//g?=
 =?iso-8859-1?Q?RHdPzbN6kPSXa5awgxh31hHXA7Wbhg84zC8jJsgxyCZ1lmZx7YlouLl8GS?=
 =?iso-8859-1?Q?IojIBVJCNxQemB0TJG1cKiqxLqQObZhZCs3YrWAjpFT1JvozwdHxWdlvaQ?=
 =?iso-8859-1?Q?7VtZSVEb7iYt2kc7OLQxYPJkfFipAT2l6p25kN4gjG3hX9pQ19oRnZ/H1Z?=
 =?iso-8859-1?Q?e3tDVYSGUQ/vKytzgWF5ty78SGRoNLJAQoes8KNVDEHGNie7bLuuy5eA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a2e8bd-ec20-4c1d-d796-08dd75d2687d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 12:47:51.5344 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qUxP94AmdV4R9CH/vI3xFsQ8u3TXjFQXDUGR0XewAcpovLbbiUxu2x+ppa1OQmshCcurhrpsUEQJ0YNZfP6vHK8JXL0VmB5oSA6uL4nkDNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8009
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

TB Members Attending
---------------------
Aaron Conole
Bruce Richardson (chair)
Hemant Agrawal
Honnappa Nagarahalli
Jerin Jacob
Kevin Traynor
Maxime Coquelin
Morten Brørup
Stephen Hemminger
Thomas Monjalon

NOTE: The technical board meetings are on every second Wednesday at 3pm UTC.
Meetings are public, and DPDK community members are welcome to attend.
Agenda and minutes can be found at http://core.dpdk.org/techboard/minutes

Next meeting will be on Wednesday 2025-Apr-17 @ 3pm UTC, and will be
chaired by Hemant.

Agenda Items
=============

Official Deprecation of Old Linux Distro Support
-------------------------------------------------

* RHEL 7 and Centos 7 are no longer supported by DPDK
  - Compiler version GCC 4.8.5 is too old to build DPDK
  - Need to officially announce that it is no longer supported for new
    DPDK releases
  - Will still be maintained by older LTS releases, e.g. 21.11, 22.11
  - [Action Item] Kevin to upstream doc patch for RHEL 7 support removal
* With removal of RHEL 7, RHEL 8 becomes the oldest distro version
  supported.
  - This uses compiler versions GCC 8.2 and Clang 7
  - [Action Item] Bruce to upstream doc patch to update our recommended
    compiler versions to these
* For minimum kernel version support:
  - Patrick confirmed that the lab has just added an image with the
    minimum supported kernel [4.19] on it for CI testing
  - DPDK core does not have a particular dependency on recent kernels,
    this is instead the oldest TESTED kernel version
  - Other components, e.g. drivers, may have more up-to-date kernel
    requirements
  - [Action Item] Stephen to do a patch to update the docs to clarify
    the above points
  
Events Update
--------------

Prague event
- Reminder to register for this event
- Preparations well underway - event "swag" all sorted :)
- Technical board will hold an in-person meeting the day before the
  conference

US Event - Santa Clara
- Planning is ongoing
- Event will take place Sept 17-18th

DPDK Support via Rust APIs
---------------------------

Following discussion on the mailing list (see thread @[1]), open
discussion was held on Rust support in DPDK.

Overview of some points raised:
- Concern over level of rust expertise in community and in Tech-board
- Want to ensure that rust support does not hold back the C project
  itself, or impose limits on which C features or compiler features
  can be used.
- Suggestion that rust code in DPDK repository itself should be kept to
  an absolute minimum
  - rust examples potentially in a separate repository
- Any rust support should not just be a bindgen wrapper around DPDK:
  - been done many times before, value of that alone is questionable
  - desire expressed to have a "rustic" or rust-style set of APIs not
    just thin layer over C APIs
  - From mailing list discussion, seems consensus on having low-level
    API crate and higher-level API crate
- Exposing DPDK APIs officially via rust seen as an expansion of scope
  of DPDK project
  - there is value in having maintained "official" rust APIs from DPDK
    project
- Discussion held over the scope of DPDK exposed via rust APIs
  - limiting scope of what is exposed can reduce risk of C code breaking
    Rust code, and reduce maintenance burden
  - exposing more APIs via rust obviously increases what can be done by
    end-users
    - but problematic if only exposed in low-level C-style bindings
      rather than any higher-level crate
  - suggestion to have the bindgen-exposed APIs limited by what is
    necessary for the higher-level APIs
- More prototyping is likely necessary
- No conclusions reached at this point. Discussion will continue on-list.
 

[1] https://inbox.dpdk.org/dev/20250306133713.393057-1-getelson@nvidia.com/
