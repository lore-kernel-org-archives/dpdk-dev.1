Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7E1C61DD6
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Sep 2026 08:06:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15B7340374;
	Wed,  2 Sep 2026 10:06:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id C1C9A402F0
 for <dev@dpdk.org>; Wed,  2 Sep 2026 10:06:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788336370; x=1819872370;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=VmbwfD1BZxC6kTFQC6A4z4v0hgWGwjF9JwbC7jayg9k=;
 b=ApXXeTjnl2TIkgTwToEZY48Bg8lnWsdkZ0Htxs2rYNYMmsKqo2lvFTNF
 cLSWiYC+DBJAXhSWc/VPd+n/+pqsUYlvZJeR4Wmbusb9VCp9hV8nkJq3Q
 MmLPDMFnc62WPL00AXiEiZvbWohA04tlhfCln5kx9EV/GPEUlQgeQ0iBe
 QBcLwXiKKh0D5Q28jup+XICHgtn820En6OrTBdvkTE91v3GXgOdj/7MBi
 jJ3SUNBo1XCWn7aIM2oB1l3BmNMvL40NYKzBwYkPbWqY1zTtCHk2WyWfI
 WQUfj/9plgmVvhRajIPmQCSTPWRF0acCIwLK/9br5mQczbmCGaop/mU0X A==;
X-CSE-ConnectionGUID: UEzfsrASRrK0i27TfeQtqg==
X-CSE-MsgGUID: gvzCP4QTSQikXy7VKBUG8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="91297702"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="91297702"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 01:06:08 -0700
X-CSE-ConnectionGUID: 4w/4/a0ERAK2AzAeaAF7Og==
X-CSE-MsgGUID: Q0SbUUjdT3K6HOn2t2EEIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="267564807"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 01:06:09 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 01:06:07 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 01:06:07 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.11)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 01:06:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I3J8UFurM2AuHXVmOzFL1BYfBJn0vMJXSKY8qfF3tFKS0P0r15KzRKznh/xkOgJhGZaff2ilQcMTFiR7SS50VYDdghWuH3HKuClg3RjCZJU9OHZ9rp5nVwnnODrxe6xu7jUyoEtjvuPVL9DMzn3sjv/BLXDoFc5FYkB2SdUCEbsamG8yx0qzhM++9VrDQPV091iYVQt7oXa70YDtn3pNRyYiukbELaiFgOIhgcHS+mUFyir5VzFiAHZd2JxsEiIA2ZxAM3V9I9481cfNjTUoJI+RMKkcy83e0EagHCrkby0xUGA+NZEYmLkAQoIuplBFV5dTWmKU+KK6oCRLJW6P3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHrnzwjudTwYnjXpqW+LcxRo+vr4lwHplI4KA4IjHHk=;
 b=KHIpfCDqldATs1UYyhS/D/Bk+G2GgKwLxipDR3Z+sEgKpojmm6Ba3iDlu5sOgLOLdWswusFYiYGB8+N1+5KUctwp1LhMhnewjJCX3VfmSjrYynOKUEfJhMBs4u86+5LCAOLJD1RsXFfERbesq+qNMcHBI96XuGLW7OT79g4174yQefSrkDpR+YLnfjIMsrUuHfsZ8pSsNsCbCS4wjyXaoAP2z6TkEe9KNQg/foaK/1bFzbdImqpkiSjg4FqEFUnp9a1reQIqUZ64vAxKQ0Bje1ACFUwXja02E8TUgpFu1smE22ORikN0n6+aUNnxncZrxPb0dhSb7PjMrdCy9+pysg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by IA1PR11MB6100.namprd11.prod.outlook.com (2603:10b6:208:3d4::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 08:06:02 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 08:06:02 +0000
Date: Wed, 2 Sep 2026 09:05:58 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH 07/22] ethdev: promote link speed helpers to stable
Message-ID: <apfY5n-N7y7PnRB3@bricha3-mobl1.ger.corp.intel.com>
References: <20260901203217.1485915-1-stephen@networkplumber.org>
 <20260901203217.1485915-8-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260901203217.1485915-8-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0188.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::27) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|IA1PR11MB6100:EE_
X-MS-Office365-Filtering-Correlation-Id: b56386a0-26b5-42e7-49f3-08df08c907e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|18002099003|22082099003|11063799006|56012099006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: zmhA9Bs7UJQqc48t3VdttdtoQZTOZajp+JyAOu20dZ4goIG8P4+hUHQ49TMjP4UnTBmZSjw5d1iV+V7CAgHIVJdxFGTUxd/0wogQAIRwv/m5QglLy/uqjhDFwfS4/3Q7LGSgsVha7Iy55s+mkHqgtGsccWTp4TUwEG7t33X66GN9C8YSCaB957hu7RnPe7vYkb9A2wAzS7+sYev6tlHN0hb3Rw1JHwenS3AQCJ7Lqrx7jqD9EFtXwuIj+EgQko8OkYJWZGmlzYKM3QDb/B1N6WpR8yPGrMv2SEieASBg1sEKiAa0RwxKyKDcVGDtdimDTZz898VWzha0IZFBsnXt5Lfzn2S6/dxVO2haUyPSSPZ6i1PUZpHujZ3zlo8MnZavyZ6+PwMPyBQg7CJsAMwFghmb+xdMjFHBhr0Mnea0jq1em3sPHZotB4xsCi+eDrW7ZuNUUVPodlaUoX7ucIqJ1HtBa5thS0lOXG5qGT8HDcuLVssPPQl0X8b6sXM4ReUKmIxjtGIKPQqP3BeqIEnCm8b2h8gIzt3bBdW3jR8nP0RYQvH/mgoltc7y7XsuInUIAEoXf8a8Ss07oQtmiH8nQjwEctrkjHoNHwQJKBEwnez/oVT1c9XQTyfyvT1E945nLwfuG2HMu9OMI8owzeyWxY7SxN4u1If6yDFHPL/vZf0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SPULFmfEl+sXYEt7nuSqBTU+97fNMXjpjzuTQfdLt0fA5cPwXhxt/nCFYR21?=
 =?us-ascii?Q?kEBWtjmBJ7GKdRm0laDWnD/ioRQn/t6REV30j6exyn6oyfzm99YGk60cRV7+?=
 =?us-ascii?Q?ff2R00isc8q6wpxP0isoP4gjVrFtK1S6QxxJ0xV3GE9Fhlvp/O/VGe5x2/Et?=
 =?us-ascii?Q?QR/ji30xvhbRa69/68XHTPFGZ/ErMdGweORMeg4cNjKXZvChdGIwGrQYrgeq?=
 =?us-ascii?Q?P9G6g1SZt/eIifXSg1HGXhheZYEpZVW6BVihhKY7h4WsIAQfZunMzvfx8TYo?=
 =?us-ascii?Q?0MdijohEPPE0k4jO1YBDNBWyadW1SD6Vyz+39Z4Y05vkf4Y6/7UuDlh7p7QR?=
 =?us-ascii?Q?Ob4+6bDHCnzzoOkHspcihpP7oHkLD+1KrnEsLANKRXWnMjIgapH/m9oG703d?=
 =?us-ascii?Q?LfxUnERkKeHpK4wdVjQ6rgr1qL1+Ub/bnNMhgZTzUq1dlEBve8M01eTrmepg?=
 =?us-ascii?Q?MsyJDVVHGrFxQAjHpCHRe12SjtSOxN+xGVCIgUZ9x+oFmi2Npv+gXFIEoHKL?=
 =?us-ascii?Q?oyh7rv94RuEcye5z+0LiPwfPyltN+xcF9lSSmYKCXpj3KYIyo9Ftfc4C6wo2?=
 =?us-ascii?Q?ibe06pMAv1NX61eYxhFsP4w1gDoIVMy10qWSm1goH+hEdFYcoOAM0kHi9967?=
 =?us-ascii?Q?Z2uzGUDL/SiHaE8P/Vru4YV3vWxu97JCBWL5QgN/BJH+PgBFMqEaT3iSDnaV?=
 =?us-ascii?Q?py4JGX7rjpXPr9GYWUKAs48vKFAtYNXDtz3n6pws7nKtn5EcMEnH3NT9l9MG?=
 =?us-ascii?Q?DrErPUh638ofTaxURB4HGWFjkA+3i2yhE0a+NubRBo6TVBHst3TsOIufaaGQ?=
 =?us-ascii?Q?+q4n0EpDM+LEp9KFMvtrOoxBo01IvFN2fRra5r6BN9R2lkNo24mMQnl2jxDn?=
 =?us-ascii?Q?r4DtenjH6Rq58zzoV673uaAI4DNJ8Torw4Gu0PsWCEYjmpJgPlL5ZDHc4+TK?=
 =?us-ascii?Q?O50v43SJKqahRb7M9zXJVL0lICfGumK4aWIztUtEvqLBcRBc5xe9CROk/3zX?=
 =?us-ascii?Q?DcKIJNQWcPhkSpv4z7Vh3g7na+5YHN1bEcIwm1NAS5y5RGnbBr8HJ8N1wbOj?=
 =?us-ascii?Q?v3NIGZcilbuKFCb1IYkeF82N6HQfdJTdk+Oisk4oCj7onF8FAal3dUvziqsu?=
 =?us-ascii?Q?DjzndtyPoa9X81r0e9edPVMq8c7X4bq6AMeU48yHpeE/YA3+XrNwxSboYbsd?=
 =?us-ascii?Q?VATi9I8O5BsaZ+GqArYXFZffjGSsH9lKLivh6BCVOdjjmHrNFM/In8A9O93o?=
 =?us-ascii?Q?ySiGaSq6mzw380OI6MgoGpjLDrILTR1jfCFuQpUSDZam4VyTdOhsnOfyAKCc?=
 =?us-ascii?Q?qiMZJ0VT3YyUbyFToKYL17kThb29MBoN60tpTHKztUPOLQyMDurEbhR86a1o?=
 =?us-ascii?Q?xBtSjkFF6bgnTZM6qde1KOZEevKEO/s1fZRXoqZi/TsUYakB8ph1pBPouVj5?=
 =?us-ascii?Q?OuFx95gWGBxhm8lm9w2XGyHwyBgxJ44X0QmMv6piQAqqvyE0J89OTpOEcPhw?=
 =?us-ascii?Q?z7p0GqPX3Cb586b6uMWC1eXgSiecnMw95sdsnXVuA3EBDtOYbUQ3PykWOd4V?=
 =?us-ascii?Q?C4VEJPJPPh7cerU/CY/v0ko7UGMA2BrUAYHGzdhxw7J9rSkwEwBjbMl4c2Wu?=
 =?us-ascii?Q?UKzM4G90+I5otWpez3460Eb7Q8iPbPNGLRU9howpp+kq2mz7kEsfFTOUqisa?=
 =?us-ascii?Q?surCU6Q9lxTAUY/sBjbpwgM3Wub0Qj8BHHQpVfe1VeHQVg4tmfAoCkXCNr30?=
 =?us-ascii?Q?7JCJUsbMuTQLAhyZj92mgHZYcdKIX+Y=3D?=
X-Exchange-RoutingPolicyChecked: qYIbWdA3LKU3zrDvqPfoP2Kyih8Cq9i2sIGrVNCiAhLLJ7dowcqYx5YoyRDzvdGCbEY5tyDt7dod16a/wmyjl0GXy0Jq31m0TcKaMkKwpMzm/JQEpdBrA66Ft+Gx9bXVqgDL3kiT4MaS16+OcTZ/4GpQfeLiaRPDL2zsrVNWLXJRujVT3IGXgNrJUjstiqyt4lpXeEBtLFvzEdEhf2eQL8Rw/r5Oe9R8GPGRkg4kOxy9gwzCsN7HbqIXx8WzOdLpydvQ9HifPrdzdXY+LKZo21V/zVGut54XhqHcGxj+lvyN10t9neG1Bpmp+J63KBYaBfRyOmZTWL5Topo9RxbtAw==
X-MS-Exchange-CrossTenant-Network-Message-Id: b56386a0-26b5-42e7-49f3-08df08c907e8
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 08:06:02.5076 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ANTIiskh4Jc7vls+9zn9XX+sKRmdFhAw2K6ku43OjXQuO/c96SKMaZtQjZzscD3EwL48mz9vLISpvrFUUGcXomW6VIIqvfDs+PJpLMP7DjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6100
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

On Tue, Sep 01, 2026 at 01:23:06PM -0700, Stephen Hemminger wrote:
> rte_eth_link_speed_to_str() and rte_eth_link_to_str() were added in
> v20.11 to give applications a common way to format link information
> instead of open coding it. Both are unchanged since.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
