Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CA9606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 10:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YEyiGezG
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA15140299;
	Fri, 23 Oct 2026 12:39:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 0358340268
 for <dev@dpdk.org>; Fri, 23 Oct 2026 12:39:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792751961; x=1824287961;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=8xUWMuQaa4+/6HhqnmjQSqSXmdg1UHNlfLt7mimaibQ=;
 b=YEyiGezGoAtht6K2N1MyzQK9BTE0PliobcyYyFxJtVhxYmXrQuiHFNZo
 95X63nO4yV0xTF2k0JBFYRE+Mc+CAgAzWN+VhU6HRiyDMET6z1hF4JTBB
 qIG7gOfgVcehKu532eS5aCKNYpeqJWkPVOvnpBpU99evXZC+6xqZ7gLfn
 VBBwKOqC0xTrTltFc7v728RQqfV2nyl2xh6PrdnfxCd2a6acwqDXv/xmh
 psRiCnJix9H4uiXuGc+Vm8qCMa+dix+m02W9GO4Ok+dt6h7Ltca2MB4+o
 hKTlP8KI9TEGkid1EUIaTj07+hilvT7LsD6NoWW6F44Qr6Lyk2mDS0AJD Q==;
X-CSE-ConnectionGUID: oiJpeKlKSdmVTcSrNjPRrQ==
X-CSE-MsgGUID: yeuSdfuaSPODyY9JqizfXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1523094"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1523094"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 03:39:20 -0700
X-CSE-ConnectionGUID: gzl3xMMDRjCaHt/Bp9LIRQ==
X-CSE-MsgGUID: B7MJckvYRLGwRJWh+arzSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="4099341"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 03:39:20 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 23 Oct 2026 03:39:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 23 Oct 2026 03:39:19 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.33) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 23 Oct 2026 03:39:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V/XVZvHLbzxaFF7vcikI7QQ+cc9ywy5xSaU+Jioi5KQlVNCCF//UFPMt3I38rsXVi9woPluZWLbBUfhwwdpYalR0OBS26X748J6ZHMB4Kv5Ysm1DjOrUke2eYtr6lXdzy4st6NCxv6DgsEUj91OULC9g2CMDro47rlt/wRI1xtUWujc3/8aeVTKAOWp15CUriT9ZeZWPrUq8js07Yw+4zmSfUDsd3EDouwRi0hFgT4OOdummQlUc9tZVakWbEESsbwZsv20JVSgKk9xB8pt5PuPyauYL0vEBEymZtfJO9TX3vRepW2e/I1PwAMhiYPTHNdcw9VX8qIMCBSG1JFRW9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PN2zJY6gyGgZzHzVhNkX4F6+qBMEjxc/W48vSpF5CnI=;
 b=eOd0HYUnn3VAnFllPPM9p6rpfAbAS8Cx4eYUQtEAM5ShYkxbR/XFwrfrRi6xaCE84gqcqSKpEwKpxYHFfJwVaCgTtyCucWV4GJ7f3RaVUc+EZPSp33KRrqnzI2T8mVwRRWmaQMyb1DAM6dgL4ZnzRKsRkX5Zp6KPjvH07IxJSA/DmpzLvN5KE76LhpfPQrXOx2jNO+jjCST7XUBK0124dAvAB3ifGF95kHKzKhDG24IwuNMs3o6v9e0B5orUOszSgkVuzedQc0wI5o99W2hvz3QcV1relfDfO8C6AEMpFwtaoxH9kQIwPno4uFnmZNdyzZ46p7zr6397aO2mLiaPYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DS6PR11MB446913.namprd11.prod.outlook.com (2603:10b6:8:49b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 10:39:12 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.017; Fri, 23 Oct 2026
 10:39:11 +0000
Date: Fri, 23 Oct 2026 11:39:06 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>
Subject: Re: [PATCH 0/9] Update ICE base driver
Message-ID: <ats5Spw3EyH9e5wO@bricha3-mobl1.ger.corp.intel.com>
References: <20261022165205.1830735-1-vladimir.medvedkin@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261022165205.1830735-1-vladimir.medvedkin@intel.com>
X-ClientProxiedBy: DU2PR04CA0268.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::33) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DS6PR11MB446913:EE_
X-MS-Office365-Filtering-Correlation-Id: b7c8b246-a800-4753-b263-08df30f1dff8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|261021121427099003|56012099006|11063799006|261009223027099003|10067099003|18002099003|261021123027099003|22082099003|3023799007|261022105027099003;
X-Microsoft-Antispam-Message-Info: L59hrRWIh1HvEXen+0nLU6xFKvnNcUe0WcJkIT8W4TSj+TP3ZavID74YhYF/WYHUih0JBSMq1bqo/2yCfT3D6BfjT/8RvoF70EhtAKHTZd+VUMP7Ok8W2uJcnCUjRqs08EHI5/wHWba0+ddmV/nKgImN+zJxCjvHBhxCQ1S5n+2A2iQgvc/GxGbL+V6ESnloCvJ3Rd5zfwUCTkBOmZBrfwDUhq8PpptJA2lidTFNKThjmtJ7lUKcZJuQlZgVDjRIw9UG5kk3vT3wrNpQlFdS4nOKymyx1ApQ19h+ORbk5A2AaH1HJeojC07JNF0cnTJXUjWwb8Icsu3hsdtxPn8mz1FBUEUtxFauztpoZmHSBHIjZuc2xKxxEnhY3j1j7SH9oVDGIonWidyasWZNviERGAugohbOowvzFWuWGuDpFc735p2ifHJ4bsrlVNr8ZLZIASvArq8vKhF8zhK9vnMTWG2Iph+RCos4t6JhaZllfMD6DxQA4ysAD0GROSVuOlDEX/Cw1PlAHIxtEWFxnrQTrOPtGmp+rIdx1/FA1R0ZQe2/m/mKWOMqg4SSEIF8DnLxOu5pP7nKtL7YMOo+DgYmiAXdrHpVprPQQDmgsNdX0LAdVwBDrc/I5zmYuTwjEtbSOu+izewZ3JtY84PCk5f+yrMKPK9rD5g2k3zMd5pHe2Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(261021121427099003)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(261021123027099003)(22082099003)(3023799007)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nZ9MDrqQbyCGt3PN57ZllPmz5jRyOEJNY3KaKtI51H5e/L+dWMLIklWbljVq?=
 =?us-ascii?Q?xMZVXpLPgNcCYrJVKFNpQsfN5YKvbz1lABV2MxAMdmbJg4stcTTc/1oaEXhm?=
 =?us-ascii?Q?epxhcFUlMAiQIE9oPoxxa/FpNDsahgLqSy+HtbV/P8s64HHDSJl5PNDL4ryo?=
 =?us-ascii?Q?STJveLbO/Y2/QOdf/HdqDwgLR9pFlJq7ZZEpkg73yi5lU/WKTmCXywRCKoXF?=
 =?us-ascii?Q?PAIKjoX8Preo3oavMiqvbLTi+iOVPDLABqOaV8UOCyjIQaQRw+n5bdkMnOqd?=
 =?us-ascii?Q?gAhW1VcOyeKPyAIXzjxca8aE+Cor9qUH3pq+gg2+TnkNsohh807ldYb48pGG?=
 =?us-ascii?Q?VBZGVOPr8kEfOWJu/rhv1zTVAxmeGPfa4mqvUZYMYERxJfNIjpnOfQ1GPug5?=
 =?us-ascii?Q?zJMyTbn38S+jgm/PErtKSCAjDbj8AKLUbDaLeOUJ/N914F+1Yxd+c7ilGqQT?=
 =?us-ascii?Q?+yaGeLRiW5aueCA8gfFbLz7wbx536nI26XKE/C3rMv7sTK/W+0c5FjsHKJA0?=
 =?us-ascii?Q?v8ZfLNYAtVShono5YCm+UPtdQPAdH3+p179sydsg0jkuc8ixNZtOTUP/IyMh?=
 =?us-ascii?Q?4pXk3ppcjbMw+Q4CY2355efpaOlrxVB4YsbeFQpNMMUlKaVYHmQViWxqX6Yq?=
 =?us-ascii?Q?IKQeg9YUr2N2Mwb47dPA0DCJj+dDjdPJUI9VtpoPs+xjIGX1UF5A45Mj0IpJ?=
 =?us-ascii?Q?y09vBPi4wN22gykN/WMhFVc7dvCWvuFjXxAvYSRQZyReX+Mc9Y6MT5sFFICJ?=
 =?us-ascii?Q?kVo3e72pTT5HwA+fHgETjiecWyRAfH06pqiMzfPqaRA+nCmrxkOHS/lzgvfh?=
 =?us-ascii?Q?8aqCAEwNflvwkqHGmU3sopDA/CklkpmzO0YYxYDsSfTc4QV2CU6Vi1vkpzDT?=
 =?us-ascii?Q?Xolu4jgOXzWhcvfq/x9I8+/fiIZubNQxcEN7NK+JGX8t8M0vAdUgsqfAvk8+?=
 =?us-ascii?Q?4XS7g83J5z0QkVktSDSRbjdV28iHOwY4/WA0fHcUFA2vLKMq41/YcXTDRpQr?=
 =?us-ascii?Q?+sdvy5Mm4J/NHm0iF7CQgiQRMk6EOp21QhVfd77gbGKp6+tlCBFLwuFMlQvx?=
 =?us-ascii?Q?RWT7PhHyX9+Il92vfkK9FiZerF2nQk9meNOY1+YKF5hJKHL7zF8qHRyiinP1?=
 =?us-ascii?Q?B3g26M3ov6y+m2Fa0oNS+KbjbDyf/flaLyzZGlgD6g2dmVHuQiewc/8bb39r?=
 =?us-ascii?Q?ffW+3R42ATMLMUyodjIPtKeilbSbnxxJfoe2k7HMk0iSMYpxFWWXkh+d9/p5?=
 =?us-ascii?Q?Zr1nRCQCOa4XqNZ7iB1ZTI/YGfV1kF2GfgiaEYVRwMX5wj056b0fCRBLFdji?=
 =?us-ascii?Q?GCTDoND28IOSYQnFNWij1+KXpowWRImn9oMj1rTvbgGcmSr47zfAhtmaxUtX?=
 =?us-ascii?Q?7H8wL9qW0495SLmc0EaOsEfhJtGwX1j5XhomfqYzZdLhUz4CCmxckN3H1xDD?=
 =?us-ascii?Q?4QkuTtjhYKwC09hbPFY90/3fcCNLBS+eorcaB3NK4J5iTtdLxKtS0sfsoO1Q?=
 =?us-ascii?Q?AKyO+755Vncq9mkLQl0HHYbcvnO0pN48C8fKX0u5eDwZB6lQVBz7vWo5QeVl?=
 =?us-ascii?Q?yph6lBK0eLTaWj8Y9ZPFmKUCJ0cdr47Mi77oh8aD2GlOdE8fbxxkg45O/lPO?=
 =?us-ascii?Q?/fEQNHeHw3+v3Iigzrqge2ovJuDBcnsymuOFVb4uZ+Scg0e6oTJU2H1rZR/W?=
 =?us-ascii?Q?3ZsPrUO57vDY4zAT0rAac+hermbhgCExOViTqmrqSCrk/pJgw4U2Oa6koZk5?=
 =?us-ascii?Q?q2XOQfAvfX1lsDcmFGFTQ/wImGbiifU=3D?=
X-Exchange-RoutingPolicyChecked: cS+CjPQJdyIzBh/fVdWnBWA4OymzGhENnGS3Ts3PKGB8EKp91EPnYBk4h/oDMIan4hgISl0tMFFgiXJkNiWvi+FscUqEg/o7nPufRrY09nzAX1tR6/EkWDoUVzTUiMFoOaUzq/iEHJ+iByFaAVDkSOhn+hMaaAgejHl7QNnM1onaMRJWT9jSSehE9uJQBYDLr00lYPSqcCXxKtcETfkIQB3NSJbyb99o3QBki1A/IUUO84KQ+iUSsdv8QpUpSEFoztKq4rmaYxcEmMUkDHIu3iVEKR2bdMg1oPNrE1NcqgIY8XpclWoQ1eiE1w1VKna83BV+jTh3qXLRBDh3y4OC1A==
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c8b246-a800-4753-b263-08df30f1dff8
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 10:39:11.6400 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ef94BGsu8WFIr8lWiBddAFWfKkI2pdbCDDks4qkvKDWxPLnHRAGHEk8gJhFeBxuMDkqZCz1Lxl5XqkP5OLzm28LBzZ75uCuyZ9e9xrYz9fU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB446913
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 04:51:56PM +0000, Vladimir Medvedkin wrote:
> Update the ICE base driver to the latest shared code snapshot:
> 
> - Bounds check, integer overflow and type fixes
> - New capability and NVM definitions
> - New E835 10GBASE-T device ID
> 
> Chinh Cao (2):
>   net/ice/base: add NVM definitions for Wake-on-LAN config
>   net/ice/base: add E835 10GBASE-T device ID
> 
> Deepthi Kavalur (1):
>   net/ice/base: fix loop counter type in recipe creation
> 
> Janardhanan Arumugam (1):
>   net/ice/base: fix out-of-bounds accesses in DDP and NVM code
> 
> Krzysztof Galazka (1):
>   net/ice/base: fix integer overflow in RL profile calculation
> 
> Przemyslaw Gierszynski (1):
>   net/ice/base: add RDE WoL override capability bit
> 
> Stefan Wegrzyn (2):
>   net/ice/base: add PQC certificate provisioning capability
>   net/ice/base: add NVM write flags for eRoT minSREV update
> 
> Vladimir Medvedkin (1):
>   net/ice/base: update version info
> 
>  drivers/net/intel/ice/base/README           |  2 +-
>  drivers/net/intel/ice/base/ice_adminq_cmd.h |  6 ++++++
>  drivers/net/intel/ice/base/ice_common.c     |  6 ++++++
>  drivers/net/intel/ice/base/ice_ddp.c        | 19 ++++++++++++-------
>  drivers/net/intel/ice/base/ice_devids.h     | 14 ++++++++------
>  drivers/net/intel/ice/base/ice_nvm.c        |  4 ++--
>  drivers/net/intel/ice/base/ice_sched.c      | 18 ++++++++----------
>  drivers/net/intel/ice/base/ice_switch.c     |  2 +-
>  drivers/net/intel/ice/base/ice_type.h       | 16 +++++++++++++++-
>  drivers/net/intel/ice/ice_ethdev.c          |  1 +
>  10 files changed, 60 insertions(+), 28 deletions(-)
> 
CI shows a couple of failures when testing this patchset. I'm not sure if
they are false positives though (for example a flags autotest failure).
Can you please check and confirm?

/Bruce
