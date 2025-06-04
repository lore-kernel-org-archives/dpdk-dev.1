Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C96C5B543
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 16:56:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E8E142E46;
	Wed,  4 Jun 2025 18:56:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 2764C4025D
 for <dev@dpdk.org>; Wed,  4 Jun 2025 18:55:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749056158; x=1780592158;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=JzVcUds/xWwIV1Zq76J78VMi9AZbhYscnfizbjhAGRk=;
 b=HZg6HNLm6pWJA96jk+/pozmhQj/5IlMtHpWj5S5vkkR+pePH5O6UknzN
 nz/Mn+f6xiS3We9eBs4wZN5rEzp7Nk/SbdeBaxwqpc34Y3QjzyG7jyOyD
 vv8akNhM8ve2C9UqP1eh+XIVzeJzTPG57dlK36q8+oPi4djYVU7E4zErH
 H7mMn+FXLguLwrRAV2Vrh7v42mDWRXqwS7ukVqy2PeYuZ4OIWKEjzQsFx
 z+KGgnxYE1tAmfOuvmyvL7oOMxjC7Dmph63FAa7Q26/Zffffq0NhouRlz
 GYaMTSTOljK7B8OSZok0QaeF7iQZwR/CjSEu9odz2h0sIo5UaHUX2H3ZE g==;
X-CSE-ConnectionGUID: mVBmLXUWQaibCkLlDJ14Hg==
X-CSE-MsgGUID: 4m83HQ/zTf6ElKVlFVdPYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="61770574"
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; d="scan'208";a="61770574"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2025 09:55:57 -0700
X-CSE-ConnectionGUID: /I046OvjRqGtzvk1x3DzGA==
X-CSE-MsgGUID: soj9oAUyTPqt/H6eWA8CdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; d="scan'208";a="176208007"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2025 09:55:56 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 09:55:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 4 Jun 2025 09:55:54 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.59)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 4 Jun 2025 09:55:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DvcZbf+W/4Tmhf3g2Pz0hSf4H/ZxWNbQJU/lFqw+5XN26He0fevM9vK7UM8MuRtfM2lOx+E08UmQTSI8854fjc46QXyNdL844ua7kPj+EjwlbMF3YFYgekpcUrB662TYxRB72a6xDpybcVd7cO8/74e57WhY2c15gzZSv7NfIB1WVuSt+dXF67Fajb5FUXD/V+wnxrYhz7VqraQT/a9SAgd6QCv3dN9LNXnFApn/KTnHJw49X8TI9haCYnXOvWFJSDok5lcRN3Ucpuo6Orf/CxhpxCkFeV7tj2bmLTB+BTXMW2H9So1wjfhWipDA9i9xVVP+zJbJHrYzQqqGmiwuwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6CpzPQV23V4dsIVKSJF4cSWJ2aibglqSp2gnRAWmfH8=;
 b=IxUiWpnc8P+OZh7TdbsvUYwqCUAyMqxAWZBVa7RUWMVMJc97esbwmFjWCOIp674+fzl+VnkEM/RlyOOaREL9HeRRhIu+RX0mL/TiuK9HrBgfyhAEC0uLOyqr1fO4MJOiObGSjZ0ePGpM1DKr9sDPu0+RgsX/rlBgbFJAmg27QuACBFxZtpK9h/EsZ2NVSlawov/IahE6QJv/A6fd7UlBpAohidu+4jJDUPW7/Kc+bC5KZgFxbdfhANp8hdyb5b2FuMEhy/lKvsbSXsxJzahHsxKRGzzMrOtaUKX4zih+SBK8XPnaht1zp01JgEy22FJF/avxAapeeEBtcNs9MUCIrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by LV8PR11MB8772.namprd11.prod.outlook.com (2603:10b6:408:200::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Wed, 4 Jun
 2025 16:54:51 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8792.033; Wed, 4 Jun 2025
 16:54:51 +0000
Date: Wed, 4 Jun 2025 17:54:44 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Wathsala Vithanage <wathsala.vithanage@arm.com>
CC: Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, Gaetan Rivet <grive@u256.net>,
 <dev@dpdk.org>, <nd@arm.com>, Honnappa Nagarahalli
 <honnappa.nagarahalli@arm.com>, Dhruv Tripathi <dhruv.tripathi@arm.com>
Subject: Re: [PATCH v5 2/4] bus/pci: introduce the PCIe TLP Processing Hints
 API
Message-ID: <aEB6VEFCKr-2t11p@bricha3-mobl1.ger.corp.intel.com>
References: <20241021015246.304431-1-wathsala.vithanage@arm.com>
 <20250602223805.816816-1-wathsala.vithanage@arm.com>
 <20250602223805.816816-3-wathsala.vithanage@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250602223805.816816-3-wathsala.vithanage@arm.com>
X-ClientProxiedBy: DB9PR01CA0022.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::27) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|LV8PR11MB8772:EE_
X-MS-Office365-Filtering-Correlation-Id: 191cd258-be10-4d56-1d93-08dda3888584
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4gUOj/hLxcWzPMzrzAJ3JXIRwwmwLyyBviTbscx1HtuupqqtFGvMupZhur5g?=
 =?us-ascii?Q?vBBKqTzwDk+DK/aa7aCV3lAq0dGghhjiUhEioupt6PRDNN407z1Qj/vZqyzP?=
 =?us-ascii?Q?OOBDeM3em3yRNY6tlL2YntF749cVoBS/bb4lxqj+jgU+/2VPApBjdhNVifbv?=
 =?us-ascii?Q?ep0bm5xXajaB3NegzeQ2KYqAyoKone1KLxqCARYvXMvlXIukXlbUwJEsXQGU?=
 =?us-ascii?Q?SiswHCel0BMkkZSug9PrIDTh+ux3gzYBNdKQMHOBe5I8iVeJmnt/V+qdzKia?=
 =?us-ascii?Q?PIsBuo6wilkRMz68XXstf59GMWY5U6i3T3cl12J2qbK/xgo7SXQ52m7109z3?=
 =?us-ascii?Q?O2kaN/TOw5t6KDtbfy6AjdiNJ3Qmv6Ii8ZGfO+CZ6yQvNWvrD9lvcvb8opUM?=
 =?us-ascii?Q?5A44qAAQ1lzxK8su2SB6qasybIG+UuPdJNqcbuGl0BiVoltLXh9npV3fOmFQ?=
 =?us-ascii?Q?TNDoWoGWPbTEmllkyXWbKUMVJOPgS4elovgz/IlI+WSebr08NjdLGYsMLzKi?=
 =?us-ascii?Q?X4UTc1lGVM9PqHiLt1s8AjypGh5BgyyrVkN3nE6byToHZTC/QEbxSe0bwrAu?=
 =?us-ascii?Q?xhmRtj96cPoVdR7ioVLhwxmx6k+rq9n7Mr6WfQcN/ZOdyoMlkvWRVaIRzxES?=
 =?us-ascii?Q?YlNnc+7LSRKA8JDF5P2b10Fj3vUKFYBejo/hm5iE5MQ1dbjrE+suNZ1TbQo5?=
 =?us-ascii?Q?7yNDgvocecWH7XGiwrFb+D+4bd21MLamdZcHvcRIb48pZm0d+4g8F5PTug4T?=
 =?us-ascii?Q?Fbi8xb9aBiqvQbhaiEhxEj/i+QkwoYRMzWL75mC0uRqRMx7J0HZ9suoTCTtz?=
 =?us-ascii?Q?jELDAFiQE2Hhp8EKSHo87vA6yB1Oz/75PKTr0GgxnKVTfx5qW7EfU4NL0lqe?=
 =?us-ascii?Q?UytTekq6EX9+aREfajDCCJ0/zZL+ALxjzE3hMF+crAQ7kxCP7HlPpOSz19UH?=
 =?us-ascii?Q?UFBbe4xFLgrc63STJh5JfxmeOwWuhv2ssiOlLm52gweDP3i5Be775cq/jNAY?=
 =?us-ascii?Q?5ruAs+fu6ELkTMOVhO5WANgPH0P8Ql6MCbt/AEB6SpxVI8s6kjELOEIQKk+S?=
 =?us-ascii?Q?C9/T3ZAvCBTc8zTpr5V8WcOuil3GEq5FQLdKOJpKNMe0RE4b4c12izPLHcz5?=
 =?us-ascii?Q?gW1WX1zb1czLU0Q/wtPQjjggPJ7PLoXbHS0B5lzg8yLQPq1jNmubaNQ2UOhu?=
 =?us-ascii?Q?ijUgoQ2d9LyoX6k0sBepK/7IAoOrE0EpnUvJobj0AtSLHewOkMYGfXxqqgDD?=
 =?us-ascii?Q?EzxjNUpW70Q9E50deObx4n4ymzAiYdhPdCyYhvz9skLEc5hru7n/RdfsZwK4?=
 =?us-ascii?Q?Vhif44F2cEOUuyqdJyIJw1+ddDY6bxGBT/6GpvX+DNO0g+UkA4LvzzlYV5xB?=
 =?us-ascii?Q?NGPzSLEzij4sLUt0xpY/uKpMd3eZlQoIDNrlWNfud4gP7sq0Vtrrw/TSbVFv?=
 =?us-ascii?Q?0VpwyZaCzM4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CxjU53TSz92TU8GJVbQvZvHHHAZ5yromT5L3oS+KPgH//+mTPSvNxTSAaYaA?=
 =?us-ascii?Q?PXOZpFhAStHWNsgStMID94dqyAb1ltEYYFewRiHZXPgbuqBhPjDGEZGQNDlp?=
 =?us-ascii?Q?08dZc5LYxx1xo5v9HUHIgls/hMCltWbkMX3VeyDhECmJAoPto8dpGtDmIaF4?=
 =?us-ascii?Q?DJDQt1luYjWjoL3fbXZ4JykfBVzdtu375UTGhQPBLe4H1EfJlSnP7x3EkUZV?=
 =?us-ascii?Q?Ap/1T5ZHFqIAzOo51sjFtn7ENk/bP8x+c++eB+iRs17uOkFflCSP0IygepsA?=
 =?us-ascii?Q?LmF1V/QF5or5w4dmKdS5tf6FnCNOSvMLpcOZMmhKawo2sUvny+vLkynwx7Oy?=
 =?us-ascii?Q?4RsbJVrvfgYtgRsus2xO/a0aNmtYN6ygc5oC0e5fP77DrFE4KFo8eE+QZE77?=
 =?us-ascii?Q?nqExOKYfayGh/vQPNELiyXiYc9SYyYd3vzoLI+dmv4QwnwLg62GR16vpUZ+F?=
 =?us-ascii?Q?W8/1SVRdiLxMVE2K5GJ2yiwSB1R7cJOfvEP6A9lnt7RwockqD1qXYJWC6YxQ?=
 =?us-ascii?Q?yCjpzax4jlzOeDqjTHJ8/6vcaNRgLq+1/xuRixYR9blIVplLhLAlohILxTqs?=
 =?us-ascii?Q?QbKdx/7rG8guNMmXl3hPsFLfKT9lcuWp7840+K7Jx68WmsnNpU9lLXuPr8OZ?=
 =?us-ascii?Q?lRzhqoomyBuL4mrSwsT3fTKOIEnpZ64w0efGoo8yYFt+O8KZFJ25JLixHx//?=
 =?us-ascii?Q?QQNQZ0JV1SnpLExeRW/zp9Nd59r5Rf1byRXX7ZkNZKxiX3G4R7pADKE6mEK9?=
 =?us-ascii?Q?kVceNypzmHIbh6ZyfVF/ISKBf99CrWibhoDhTOBfcGS0DxSAcCwByg5Je1rA?=
 =?us-ascii?Q?wQAd6GLNDUbAEBfUh8GXIdueCgu40wk2dOMhALSwtjM2HjJgbjIPMIbcJlPC?=
 =?us-ascii?Q?Ay9h0LTL3nko7jOG/FKYw7sZSjMYFn+sv2hDnTuw1Ridqc1AFEI0BRJoyxTI?=
 =?us-ascii?Q?Eomk8WDkT2cKQ3zOtCLqJv5eKjHC5sJOJvcBuHPw96KFZI8E5E8ZQcKonJiF?=
 =?us-ascii?Q?o6JwY410PcjmuAl8e/GvKZIfIVlyyVEcUwD1DbV/TjgWnjnlV0/QuvURgem2?=
 =?us-ascii?Q?1XJq0pjPtQ8rkeqoqyAiw3nVfDdPN7D/oS7lXuYSSeFuLs0OogKwEb5KKjsS?=
 =?us-ascii?Q?ZgnO8yOfmJLklvpQ37UENGncEBycMD/4YN4/wYHDJCPOcv9gEQ05ffmi49Nn?=
 =?us-ascii?Q?byaztL+WoGLd5/Zwl4HmSU9lSAaJtgyGu1V/Yynvsy2+UstaGZclWspRM1m+?=
 =?us-ascii?Q?Tz1+46gQ2eGvg2jOo5+D8B/Ed8X2uovdk8Juj2i2xtlvpED+qv7+iKN4DSBJ?=
 =?us-ascii?Q?TmmkFKVfh7wyUtOtdNkdPUkD3PhxizXj9Juylv+oIVbuxB4Y8b0mRSkrM2Ow?=
 =?us-ascii?Q?fDFUzwkCDItGywwswjYJzuiK5RKX1HbVstZkxKYV/VJNVH2wP8PLCzN4ygv7?=
 =?us-ascii?Q?B9EA2ldfcQFRt2wUCVYn7R1EccGRIIAtO4u9gp7YJ3Wi1z5fMCbkL6rk9dTC?=
 =?us-ascii?Q?lDI3h17HCDtVrceOzna4OK2U07tyMq/TKx42kEsgwUWfxHG5EeNsBvtcRt1t?=
 =?us-ascii?Q?uCNLQJpPVWmmyZHmjeXeMAVeZkR5d1i5eJu9MkY4+da+C0jMsMIFxWNoXj3C?=
 =?us-ascii?Q?2g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 191cd258-be10-4d56-1d93-08dda3888584
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 16:54:51.0064 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +abZ0oaBa2PpUgbh8PpDPgRs72ydM2eGRsv5iS+UREZnEotGvUmIy5SGifIdBAzd/Dahhe0Gm2z6/QeuGTBoRDktiB9+4Nhqu7MX7ZaRsLU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8772
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

On Mon, Jun 02, 2025 at 10:38:02PM +0000, Wathsala Vithanage wrote:
> Extend the PCI bus driver to enable or disable TPH capability and set or
> get PCI Steering-Tags (STs) on an endpoint device. The functions
> rte_pci_tph_{enable, disable,st_set,st_get} provide the primary
> interface for DPDK device drivers. Implementation of the interface is OS
> dependent. For Linux, the kernel VFIO driver provides the
> implementation. rte_pci_tph_{enable, disable} functions enable and
> disable TPH capability, respectively. rte_pci_tph_enable enables TPH on
> the device in either of the device-specific, interrupt-vector, or
> no-steering-tag modes.
> 
> rte_pci_tph_st_{get, set} functions take an array of rte_tph_info
> objects with cpu-id, cache-level, flags (processing-hint, memory-type).
> The index in rte_tph_info is the MSI-X/MSI vector/ST-table index if TPH
> was enabled in the interrupt-vector mode; the rte_pci_tph_st_get
> function ignores it. Both rte_pci_tph_st_{set, get} functions return the
> steering-tag (st) and processing-hint-ignored (ph_ignore) fields via the
> same rte_tph_info object passed into them.
> 
> rte_pci_tph_st_{get, set} functions will return an error if processing
> any of the rte_tph_info objects fails. The API does not indicate which
> entry in the rte_tph_info array was executed successfully and which
> caused an error. Therefore, in case of an error, the caller should
> discard the output. If rte_pci_tph_set returns an error, it should be
> treated as a partial error. Hence, the steering-tag update on the device
> should be considered partial and inconsistent with the expected outcome.
> This should be resolved by resetting the endpoint device before further
> attempts to set steering tags.

This seems very clunky for the user. Is there a fundamental reason why we
cannot report out what ones passed or failed?

If it's a limitation of the kernel IOCTL, how about just making one ioctl
for each individual op requested, one at a time. That way we will know what
failed to report it?

Other comments inline below.

/Bruce

> 
> Signed-off-by: Wathsala Vithanage <wathsala.vithanage@arm.com>
> Reviewed-by: Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>
> Reviewed-by: Dhruv Tripathi <dhruv.tripathi@arm.com>
> ---
>  drivers/bus/pci/bsd/pci.c        |  43 ++++++++
>  drivers/bus/pci/bus_pci_driver.h |  52 ++++++++++
>  drivers/bus/pci/linux/pci.c      | 100 ++++++++++++++++++
>  drivers/bus/pci/linux/pci_init.h |  13 +++
>  drivers/bus/pci/linux/pci_vfio.c | 170 +++++++++++++++++++++++++++++++
>  drivers/bus/pci/private.h        |   8 ++
>  drivers/bus/pci/rte_bus_pci.h    |  67 ++++++++++++
>  drivers/bus/pci/windows/pci.c    |  43 ++++++++
>  lib/pci/rte_pci.h                |  15 +++
>  9 files changed, 511 insertions(+)
> 
> diff --git a/drivers/bus/pci/bsd/pci.c b/drivers/bus/pci/bsd/pci.c
> index 5e2e09d5a4..dff750c4d6 100644
> --- a/drivers/bus/pci/bsd/pci.c
> +++ b/drivers/bus/pci/bsd/pci.c

<snip>

> diff --git a/drivers/bus/pci/bus_pci_driver.h b/drivers/bus/pci/bus_pci_driver.h
> index 2cc1119072..b1c2829fc1 100644
> --- a/drivers/bus/pci/bus_pci_driver.h
> +++ b/drivers/bus/pci/bus_pci_driver.h
> @@ -46,6 +46,7 @@ struct rte_pci_device {
>  	char *bus_info;                     /**< PCI bus specific info */
>  	struct rte_intr_handle *vfio_req_intr_handle;
>  				/**< Handler of VFIO request interrupt */
> +	uint8_t tph_enabled;                /**< TPH enabled on this device */

question: what would happen if we always enabled tph for each device. Does
doing so disable the default handling for the device?

>  };
>  
>  /**
> @@ -194,6 +195,57 @@ struct rte_pci_ioport {
>  	uint64_t len; /* only filled for memory mapped ports */
>  };
>  
> +/**
> + * @warning
> + * @b EXPERIMENTAL: this structure may change, or be removed, without prior
> + * notice
> + *
> + * This structure is passed into the TPH Steering-Tag set or get function as an
> + * argument by the caller. Return values are set in the same structure in st and
> + * ph_ignore fields by the calee.
> + *
> + * Refer to PCI-SIG ECN "Revised _DSM for Cache Locality TPH Features" for
> + * details.
> + */
> +struct rte_tph_info {
> +	/* Input */
> +	uint32_t cpu_id;	/*Logical CPU id*/
> +	uint32_t cache_level;	/*Cache level relative to CPU. l1d=0,l2d=1,...*/
> +	uint8_t flags;		/*Memory type, procesisng hint etc.*/
> +	uint16_t index;		/*Index in vector table to store the ST*/
> +

These fields should be reordered in order of size to avoid unnecessary
gaps.

For the flags field, I dislike having different sets of flags all
multiplexed into a single field. Can we instead of the flags field, and the
set of #defines below split these out into separate enums, and then have
separate fields for each one.

For example:
	struct rte_tph_info {
		uint32_t cpu_id;
		uint32_t cache_level;
		enum rte_tph_mem_type mem_type;
		enum rte_tph_hint hints;
		enum rte_tph_mode mode;
		...
	}

While the structure takes more space this way, this is not a datapath
structure that we should be seeing large arrays of it, or that needs to be
processed quickly, so usability should be prioritized over
size/compactness.


> +	/* Output */
> +	uint16_t st;		/*Steering tag returned by the platform*/
> +	uint8_t ph_ignore;	/*Platform ignores PH for the returned ST*/
> +};
> +
> +#define RTE_PCI_TPH_MEM_TYPE_MASK		0x1
> +#define RTE_PCI_TPH_MEM_TYPE_SHIFT		0
> +/** Request volatile memory ST */
> +#define RTE_PCI_TPH_MEM_TYPE_VMEM		0
> +/** Request persistent memory ST */
> +#define RTE_PCI_TPH_MEM_TYPE_PMEM		1
> +
> +/** TLP Processing Hints - PCIe 6.0 specification section 2.2.7.1.1 */
> +#define RTE_PCI_TPH_HINT_MASK		0x3

Looking at the mask usage below, does this mask not need to also be shifted
by the TPH_HINT_SHIFT? Otherwise it overlaps with the type mask.

> +#define RTE_PCI_TPH_HINT_SHIFT		1
> +/** Host and device access data equally */
> +#define RTE_PCI_TPH_HINT_BIDIR		0
> +/** Device accesses data more frequently */
> +#define RTE_PCI_TPH_HINT_REQSTR		(1 << RTE_PCI_TPH_HINT_SHIFT)
> +/** Host access data more frequently */
> +#define RTE_PCI_TPH_HINT_TARGET		(2 << RTE_PCI_TPH_HINT_SHIFT)
> +/** Host access data more frequently with a high temporal locality */
> +#define RTE_PCI_TPH_HINT_TARGET_PRIO	(3 << RTE_PCI_TPH_HINT_SHIFT)
> +
> +#define RTE_PCI_TPH_ST_MODE_MASK   0x3
> +/** TPH no ST mode */
> +#define RTE_PCI_TPH_ST_NS_MODE	   0
> +/** TPH interrupt vector mode */
> +#define RTE_PCI_TPH_ST_IV_MODE	   1
> +/** TPH device specific mode */
> +#define RTE_PCI_TPH_ST_DS_MODE	   2
> +

As above, I think these would be nicer defined in different enums, going to
separate fields in the struct. That would also remove any ambiguity as to
whether the masks include the shift or not.

>  #ifdef __cplusplus
>  }
>  #endif
> diff --git a/drivers/bus/pci/linux/pci.c b/drivers/bus/pci/linux/pci.c
> index c20d159218..b5a8ba0a86 100644
> --- a/drivers/bus/pci/linux/pci.c
> +++ b/drivers/bus/pci/linux/pci.c
> @@ -814,3 +814,103 @@ rte_pci_ioport_unmap(struct rte_pci_ioport *p)
>  
>  	return ret;
>  }
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_tph_enable, 25.07)
> +int
> +rte_pci_tph_enable(struct rte_pci_device *dev, int mode)
> +{
> +	int ret = 0;
> +

Should check here if dev->tph_enabled is already true.

> +	switch (dev->kdrv) {
> +#ifdef VFIO_PRESENT
> +	case RTE_PCI_KDRV_VFIO:
> +		if (pci_vfio_is_enabled())
> +			ret = pci_vfio_tph_enable(dev, mode);
> +		break;
> +#endif
> +	case RTE_PCI_KDRV_IGB_UIO:
> +	case RTE_PCI_KDRV_UIO_GENERIC:
> +	default:
> +		ret = -ENOTSUP;
> +		break;
> +	}
> +
> +	if (!ret)

Prefer "ret == 0" for this comparison.

> +		dev->tph_enabled = 1;
> +
> +	return ret;
> +}
> +

Function could probably be shortened to something like (including a check
for already enabled, 2 lines shorter if we rely on checks in the
vfio_tph_enable() call):

int
rte_pci_tph_enable(...)
{
#ifdef VFIO_PRESENT
	if (dev->kdrv == RTE_PCI_KDRV_VFIO && pci_vfio_is_enabled()) {
		if (dev->tph_enabled == 0) {
			int ret = pci_vfio_tph_enable(...);
			if (ret != 0)
				return ret;
			dev->tph_enabled = 1;
		}
		return 0;
	}
#endif
	return -ENOTSUP
}


> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_tph_disable, 25.07)
> +int
> +rte_pci_tph_disable(struct rte_pci_device *dev)
> +{
> +	int ret = 0;
> +
> +	switch (dev->kdrv) {
> +#ifdef VFIO_PRESENT
> +	case RTE_PCI_KDRV_VFIO:
> +		if (pci_vfio_is_enabled())
> +			ret = pci_vfio_tph_disable(dev);
> +		break;
> +#endif
> +	case RTE_PCI_KDRV_IGB_UIO:
> +	case RTE_PCI_KDRV_UIO_GENERIC:
> +	default:
> +		ret = -ENOTSUP;
> +		break;
> +	}
> +
> +	if (!ret)
> +		dev->tph_enabled = 0;
> +
> +	return ret;
> +}

As above, we can shorten this function by replacing the switch with a
straight check for kdrv == RTE_PCI_KDRV_VFIO. Same with functions below
too.

> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_tph_st_get, 25.07)
> +int
> +rte_pci_tph_st_get(const struct rte_pci_device *dev,
> +		   struct rte_tph_info *info, size_t count)
> +{
> +	int ret = 0;
> +
> +	switch (dev->kdrv) {
> +#ifdef VFIO_PRESENT
> +	case RTE_PCI_KDRV_VFIO:
> +		if (pci_vfio_is_enabled())
> +			ret = pci_vfio_tph_st_get(dev, info, count);
> +		break;
> +#endif
> +	case RTE_PCI_KDRV_IGB_UIO:
> +	case RTE_PCI_KDRV_UIO_GENERIC:
> +	default:
> +		ret = -ENOTSUP;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_tph_st_set, 25.07)
> +int
> +rte_pci_tph_st_set(const struct rte_pci_device *dev,
> +		   struct rte_tph_info *info, size_t count)
> +{
> +	int ret = 0;
> +
> +	switch (dev->kdrv) {
> +#ifdef VFIO_PRESENT
> +	case RTE_PCI_KDRV_VFIO:
> +		if (pci_vfio_is_enabled())
> +			ret = pci_vfio_tph_st_set(dev, info, count);
> +		break;
> +#endif
> +	case RTE_PCI_KDRV_IGB_UIO:
> +	case RTE_PCI_KDRV_UIO_GENERIC:
> +	default:
> +		ret = -ENOTSUP;
> +		break;
> +	}
> +
> +	return ret;
> +}
> diff --git a/drivers/bus/pci/linux/pci_init.h b/drivers/bus/pci/linux/pci_init.h
> index 25b901f460..e71bfd2dce 100644
> --- a/drivers/bus/pci/linux/pci_init.h
> +++ b/drivers/bus/pci/linux/pci_init.h
> @@ -5,6 +5,7 @@
>  #ifndef EAL_PCI_INIT_H_
>  #define EAL_PCI_INIT_H_
>  
> +#include <rte_compat.h>
>  #include <rte_vfio.h>
>  #include <uapi/linux/vfio_tph.h>
>  
> @@ -76,6 +77,18 @@ int pci_vfio_ioport_unmap(struct rte_pci_ioport *p);
>  int pci_vfio_map_resource(struct rte_pci_device *dev);
>  int pci_vfio_unmap_resource(struct rte_pci_device *dev);
>  
> +/* TLP Processing Hints control functions */
> +__rte_experimental
> +int pci_vfio_tph_enable(const struct rte_pci_device *dev, int mode);
> +__rte_experimental
> +int pci_vfio_tph_disable(const struct rte_pci_device *dev);
> +__rte_experimental
> +int pci_vfio_tph_st_get(const struct rte_pci_device *dev,
> +			struct rte_tph_info *info, size_t ent_count);
> +__rte_experimental
> +int pci_vfio_tph_st_set(const struct rte_pci_device *dev,
> +			struct rte_tph_info *info, size_t ent_count);
> +
>  int pci_vfio_is_enabled(void);
>  
>  #endif
> diff --git a/drivers/bus/pci/linux/pci_vfio.c b/drivers/bus/pci/linux/pci_vfio.c
> index 5317170231..bdbeb38658 100644
> --- a/drivers/bus/pci/linux/pci_vfio.c
> +++ b/drivers/bus/pci/linux/pci_vfio.c
> @@ -12,6 +12,7 @@
>  #include <stdbool.h>
>  
>  #include <rte_log.h>
> +#include <eal_export.h>
>  #include <rte_pci.h>
>  #include <rte_bus_pci.h>
>  #include <rte_eal_paging.h>
> @@ -1316,6 +1317,175 @@ pci_vfio_mmio_write(const struct rte_pci_device *dev, int bar,
>  	return pwrite(fd, buf, len, offset + offs);
>  }
>  
> +static int
> +pci_vfio_tph_ioctl(const struct rte_pci_device *dev, struct vfio_pci_tph *pci_tph)
> +{
> +	const struct rte_intr_handle *intr_handle = dev->intr_handle;
> +	int vfio_dev_fd = 0, ret = 0;
> +
> +	vfio_dev_fd = rte_intr_dev_fd_get(intr_handle);
> +	if (vfio_dev_fd < 0) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	ret = ioctl(vfio_dev_fd, VFIO_DEVICE_PCI_TPH, pci_tph);
> +out:
> +	return ret;
> +}
> +
> +static int
> +pci_vfio_tph_st_op(const struct rte_pci_device *dev,
> +		    struct rte_tph_info *info, size_t count,
> +		    enum rte_pci_st_op op)
> +{
> +	int ret = 0;
> +	size_t argsz = 0, i;
> +	struct vfio_pci_tph *pci_tph = NULL;
> +	uint8_t mem_type = 0, hint = 0;
> +
> +	if (!count) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	argsz = sizeof(struct vfio_pci_tph) +
> +		count * sizeof(struct vfio_pci_tph_entry);
> +
> +	pci_tph = rte_zmalloc(NULL, argsz, 0);

For ioctl we should not need pinned memory. Use regular malloc here.

> +	if (!pci_tph) {

Coding style guidelines say to compare pointers explicitly to NULL.

> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	pci_tph->argsz = argsz;
> +	pci_tph->count = count;
> +
> +	switch (op) {
> +	case RTE_PCI_TPH_ST_GET:
> +		pci_tph->flags = VFIO_DEVICE_TPH_GET_ST;
> +		break;
> +	case RTE_PCI_TPH_ST_SET:
> +		pci_tph->flags = VFIO_DEVICE_TPH_SET_ST;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	for (i = 0; i < count; i++) {
> +		pci_tph->ents[i].cpu_id = info[i].cpu_id;
> +		pci_tph->ents[i].cache_level = info[i].cache_level;
> +
> +		mem_type = info[i].flags & RTE_PCI_TPH_MEM_TYPE_MASK;
> +		switch (mem_type) {
> +		case RTE_PCI_TPH_MEM_TYPE_VMEM:
> +			pci_tph->ents[i].flags |= VFIO_TPH_MEM_TYPE_VMEM;
> +			break;
> +		case RTE_PCI_TPH_MEM_TYPE_PMEM:
> +			pci_tph->ents[i].flags |= VFIO_TPH_MEM_TYPE_PMEM;
> +			break;
> +		default:
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +
> +		hint = info[i].flags & RTE_PCI_TPH_HINT_MASK;

As pointed out above, unshifted, this HINT_MASK overlaps with the
TYPE_MASK.

> +		switch (hint) {
> +		case RTE_PCI_TPH_HINT_BIDIR:
> +			pci_tph->ents[i].flags |= VFIO_TPH_HINT_BIDIR;
> +			break;
> +		case RTE_PCI_TPH_HINT_REQSTR:
> +			pci_tph->ents[i].flags |= VFIO_TPH_HINT_REQSTR;
> +			break;
> +		case RTE_PCI_TPH_HINT_TARGET:
> +			pci_tph->ents[i].flags |= VFIO_TPH_HINT_TARGET;
> +			break;
> +		case RTE_PCI_TPH_HINT_TARGET_PRIO:
> +			pci_tph->ents[i].flags |= VFIO_TPH_HINT_TARGET_PRIO;
> +			break;
> +		default:
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +
> +		if (op == RTE_PCI_TPH_ST_SET)
> +			pci_tph->ents[i].index = info[i].index;
> +	}
> +
> +	ret = pci_vfio_tph_ioctl(dev, pci_tph);
> +	if (ret)

Again, check explicitly for "== 0".

> +		goto out;
> +
> +	/*
> +	 * Kernel returns steering-tag and ph-ignore bits for
> +	 * RTE_PCI_TPH_ST_SET too, therefore copy output for
> +	 * both RTE_PCI_TPH_ST_SET and RTE_PCI_TPH_ST_GET
> +	 * cases.
> +	 */
> +	for (i = 0; i < count; i++) {
> +		info[i].st = pci_tph->ents[i].st;
> +		info[i].ph_ignore = pci_tph->ents[i].ph_ignore;
> +	}
> +
> +out:
> +	if (pci_tph)
> +		rte_free(pci_tph);

Free functions work fine with null pointers, so just call free without a
null check.

> +	return ret;
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(pci_vfio_tph_enable, 25.07)
> +int
> +pci_vfio_tph_enable(const struct rte_pci_device *dev, int mode)
> +{
> +	int ret;
> +
> +	if (!(mode ^ (mode & VFIO_TPH_ST_MODE_MASK))) {

So it's an error to twice set the mode to the same thing? should it not
just be a no-op?

> +		ret = -EINVAL;
> +		goto out;
> +	} else
> +		mode &= VFIO_TPH_ST_MODE_MASK;
> +
> +	struct vfio_pci_tph pci_tph = {
> +		.argsz = sizeof(struct vfio_pci_tph),
> +		.flags = VFIO_DEVICE_TPH_ENABLE | mode,
> +		.count = 0
> +	};
> +
> +	ret = pci_vfio_tph_ioctl(dev, &pci_tph);
> +out:
> +	return ret;
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(pci_vfio_tph_disable, 25.07)
> +int
> +pci_vfio_tph_disable(const struct rte_pci_device *dev)
> +{

Check here, or in caller to see if it's already enabled?

> +	struct vfio_pci_tph pci_tph = {
> +		.argsz = sizeof(struct vfio_pci_tph),
> +		.flags = VFIO_DEVICE_TPH_DISABLE,
> +		.count = 0
> +	};
> +
> +	return pci_vfio_tph_ioctl(dev, &pci_tph);
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(pci_vfio_tph_st_get, 25.07)
> +int
> +pci_vfio_tph_st_get(const struct rte_pci_device *dev,
> +		    struct rte_tph_info *info, size_t count)
> +{
> +	return pci_vfio_tph_st_op(dev, info, count, RTE_PCI_TPH_ST_GET);
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(pci_vfio_tph_st_set, 25.07)
> +int
> +pci_vfio_tph_st_set(const struct rte_pci_device *dev,
> +		    struct rte_tph_info *info, size_t count)
> +{
> +	return pci_vfio_tph_st_op(dev, info, count, RTE_PCI_TPH_ST_SET);
> +}
> +
>  int
>  pci_vfio_is_enabled(void)
>  {
> diff --git a/drivers/bus/pci/private.h b/drivers/bus/pci/private.h
> index 38109844b9..d2ec370320 100644
> --- a/drivers/bus/pci/private.h
> +++ b/drivers/bus/pci/private.h
> @@ -335,4 +335,12 @@ rte_pci_dev_iterate(const void *start,
>  int
>  rte_pci_devargs_parse(struct rte_devargs *da);
>  
> +/*
> + * TPH Steering-Tag operation types.
> + */
> +enum rte_pci_st_op {
> +	RTE_PCI_TPH_ST_SET, /* Set TPH Steering - Tags */
> +	RTE_PCI_TPH_ST_GET  /* Get TPH Steering - Tags */
> +};
> +
>  #endif /* _PCI_PRIVATE_H_ */
> diff --git a/drivers/bus/pci/rte_bus_pci.h b/drivers/bus/pci/rte_bus_pci.h
> index 19a7b15b99..e4d4780f54 100644
> --- a/drivers/bus/pci/rte_bus_pci.h
> +++ b/drivers/bus/pci/rte_bus_pci.h
> @@ -31,6 +31,7 @@ extern "C" {
>  struct rte_pci_device;
>  struct rte_pci_driver;
>  struct rte_pci_ioport;
> +struct rte_tph_info;
>  
>  struct rte_devargs;
>  
> @@ -312,6 +313,72 @@ void rte_pci_ioport_read(struct rte_pci_ioport *p,
>  void rte_pci_ioport_write(struct rte_pci_ioport *p,
>  		const void *data, size_t len, off_t offset);
>  
> +/**
> + * @warning
> + * @b EXPERIMENTAL: this API may change without prior notice.
> + *
> + * Enable TLP Processing Hints (TPH) in the endpoint device.
> + *
> + * @param dev
> + *   A pointer to a rte_pci_device structure describing the device
> + *   to use.
> + * @param mode
> + *   TPH mode the device must operate in.
> + */
> +__rte_experimental
> +int rte_pci_tph_enable(struct rte_pci_device *dev, int mode);
> +
> +/**
> + * @warning
> + * @b EXPERIMENTAL: this API may change without prior notice.
> + *
> + * Disable TLP Processing Hints (TPH) in the endpoint device.
> + *
> + * @param dev
> + *   A pointer to a rte_pci_device structure describing the device
> + *   to use.
> + */
> +__rte_experimental
> +int rte_pci_tph_disable(struct rte_pci_device *dev);
> +
> +/**
> + * @warning
> + * @b EXPERIMENTAL: this API may change without prior notice.
> + *
> + * Get PCI Steering-Tags (STs) for a list of stashing targets.
> + *
> + * @param mode
> + *   TPH mode the device must operate in.
> + * @param info
> + *   An array of rte_tph_info objects, each describing the target
> + *   cpu-id, cache-level, etc. Steering-tags for each target is
> + *   eturned via info array.
> + * @param count
> + *   The number of elements in the info array.
> + */
> +__rte_experimental
> +int rte_pci_tph_st_get(const struct rte_pci_device *dev,
> +		struct rte_tph_info *info, size_t count);
> +
> +/**
> + * @warning
> + * @b EXPERIMENTAL: this API may change without prior notice.
> + *
> + * Set PCI Steering-Tags (STs) for a list of stashing targets.
> + *
> + * @param mode
> + *   TPH mode the device must operate in.
> + * @param info
> + *   An array of rte_tph_info objects, each describing the target
> + *   cpu-id, cache-level, etc. Steering-tags for each target is
> + *   eturned via info array.
> + * @param count
> + *   The number of elements in the info array.
> + */
> +__rte_experimental
> +int rte_pci_tph_st_set(const struct rte_pci_device *dev,
> +		struct rte_tph_info *info, size_t count);
> +
>  #ifdef __cplusplus
>  }
>  #endif
> diff --git a/drivers/bus/pci/windows/pci.c b/drivers/bus/pci/windows/pci.c
> index e7e449306e..218e667a5a 100644
> --- a/drivers/bus/pci/windows/pci.c
> +++ b/drivers/bus/pci/windows/pci.c
> @@ -511,3 +511,46 @@ rte_pci_scan(void)
>  
>  	return ret;
>  }
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_tph_enable, 25.07)
> +int
> +rte_pci_tph_enable(struct rte_pci_device *dev, int mode)
> +{
> +	RTE_SET_USED(dev);
> +	RTE_SET_USED(mode);
> +	/* This feature is not yet implemented for windows */
> +	return -1;
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_tph_disable, 25.07)
> +int
> +rte_pci_tph_disable(struct rte_pci_device *dev)
> +{
> +	RTE_SET_USED(dev);
> +	/* This feature is not yet implemented for windows */
> +	return -1;
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_tph_st_get, 25.07)
> +int
> +rte_pci_tph_st_get(const struct rte_pci_device *dev,
> +		   struct rte_tph_info *info, size_t count)
> +{
> +	RTE_SET_USED(dev);
> +	RTE_SET_USED(info);
> +	RTE_SET_USED(count);
> +	/* This feature is not yet implemented for windows */
> +	return -1;
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_tph_st_set, 25.07)
> +int
> +rte_pci_tph_st_set(const struct rte_pci_device *dev,
> +		   struct rte_tph_info *info, size_t count)
> +{
> +	RTE_SET_USED(dev);
> +	RTE_SET_USED(info);
> +	RTE_SET_USED(count);
> +	/* This feature is not yet implemented for windows */
> +	return -1;
> +}
> diff --git a/lib/pci/rte_pci.h b/lib/pci/rte_pci.h
> index 9a50a12142..da9cd666bf 100644
> --- a/lib/pci/rte_pci.h
> +++ b/lib/pci/rte_pci.h
> @@ -137,6 +137,21 @@ extern "C" {
>  /* Process Address Space ID (RTE_PCI_EXT_CAP_ID_PASID) */
>  #define RTE_PCI_PASID_CTRL		0x06    /* PASID control register */
>  
> +/* TPH Requester */
> +#define RTE_PCI_TPH_CAP            4       /* capability register */
> +#define RTE_PCI_TPH_CAP_ST_NS      0x00000001 /* No ST Mode Supported */
> +#define RTE_PCI_TPH_CAP_ST_IV      0x00000002 /* Interrupt Vector Mode Supported */
> +#define RTE_PCI_TPH_CAP_ST_DS      0x00000004 /* Device Specific Mode Supported */
> +#define RTE_PCI_TPH_CAP_EXT_TPH    0x00000100 /* Ext TPH Requester Supported */
> +#define RTE_PCI_TPH_CAP_LOC_MASK   0x00000600 /* ST Table Location */
> +#define RTE_PCI_TPH_LOC_NONE       0x00000000 /* Not present */
> +#define RTE_PCI_TPH_LOC_CAP        0x00000200 /* In capability */
> +#define RTE_PCI_TPH_LOC_MSIX       0x00000400 /* In MSI-X */
> +#define RTE_PCI_TPH_CAP_ST_MASK    0x07FF0000 /* ST Table Size */
> +#define RTE_PCI_TPH_CAP_ST_SHIFT   16      /* ST Table Size shift */
> +#define RTE_PCI_TPH_BASE_SIZEOF    0xc     /* Size with no ST table */
> +
> +

Where are all these values used? They don't seem to be needed by this
patch. If needed in later patches, I'd suggest adding them there.

>  /** Formatting string for PCI device identifier: Ex: 0000:00:01.0 */
>  #define PCI_PRI_FMT "%.4" PRIx32 ":%.2" PRIx8 ":%.2" PRIx8 ".%" PRIx8
>  #define PCI_PRI_STR_SIZE sizeof("XXXXXXXX:XX:XX.X")
> -- 
> 2.43.0
> 
