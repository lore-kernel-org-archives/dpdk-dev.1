Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C97C624D7
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 10:42:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D0F0C402D8;
	Thu,  3 Sep 2026 12:42:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 24F064028D
 for <dev@dpdk.org>; Thu,  3 Sep 2026 12:42:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788432163; x=1819968163;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=JkDowqnl/EmXTZ9tG6yF/v7UXp6ic6mW6x4MB2K2xa0=;
 b=flWI5HFyMP4YxMHUb9YVvJ8Uv8L2GDvbXqIEelAvuki5c3bUiiLlrjZ/
 b9CVmSdzZIzuNMt8YKOCvzXYT5/aMA/zX2Jn+IoyBh5XdgBGd1ptnQ1Vv
 zvtU4xj96nW+rN7UVHUNEg6BSVqCB/k0nyYW1pHRtc1X2CpnzW1Y8yBj+
 ad7os9K8teMhYbKuWtle59pyUFfSDFg9HrzsdRtlGXtkBI15FgnsAtvrv
 h+m85y8YE7NOPuZXRCod9Q0dwsWs4yeRmOkzPVCXZ1al9AGAKhJPoEn+n
 DmQE0ggJLqO+X0RuKmjET6vpHUI9d7www7axSklNGvwB8r1KhiDaXP+Ew Q==;
X-CSE-ConnectionGUID: kE78BEPXSmGa4midT1wHhg==
X-CSE-MsgGUID: zO+eC7J6SZCKj3f9zjO14Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="114456066"
X-IronPort-AV: E=Sophos;i="6.25,259,1779174000"; d="scan'208";a="114456066"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 03:42:42 -0700
X-CSE-ConnectionGUID: zuSCKGXJSSWoRiWvn6onLQ==
X-CSE-MsgGUID: CeiGQaVyQVm9uTMu3KGJOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,259,1779174000"; d="scan'208";a="273438940"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 03:42:42 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 03:42:41 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 03:42:41 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.24) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 03:42:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hWd4fYs8wcBW+dVvfYk6JaTw6UVchbAJNIge0c3kso2wjQPPWi4nkoJf//7W4m/xEgwLYKOyZeY3KxoySlSFZRXfJjRdEcGImxutOjhjOPRLxO3JYu1ShsH5NWJGd/aN7PQGiC6q5Hh4VfA47T6y3JhkCtm4yGIy3hcCFFqISJKPxt5+guE1xEqiJbKt08WQbbqQAbUnuxkLOZLS3KHJcmUjCWSqsZt9Y3gztDflP/G3vT2Wa4Qwxx2q7Y5XT2a3Gbxtw09ahRL+ZSCeY9h8dabKly7GCtUoKYtDyJ5X+qM64/+i8AUSL9g720gnBfFy03CWxR4MQXf+PnUG6rit1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ruSU9ZWMzxYGzvYEFCHrjOEbX6TfsqvwA9KLP6iZK1w=;
 b=aXZDGy9xf6rz0za7Y7yNeQCq8kN0eXoEGLxF5W8lAu+JfwU2iHFQISb7yMZKeh+rq50hb5arQTOZFaoJOjbLNh99DQu+CSDa9MaebvsQavSxfa+oItINtVr7fj7VSmd/P/jNbk6mJr3MkYnqZN6fD1Jcyyr4CvhMreS3pC0orGFWvShEJ3lxiQMZUQl0jXidIUc3ow7+cm6lr1/r5Jjyx3MrMA0NjKRekTWLSsh9b1j8rCG5TnqVOakWod0l86Zb2Ax4XCHJUYzs9lQBxuXi/J8JSnAzL31tsLdYHDNfmc7Zo8MKTlu/8QEajEb8DnulPdmSSK1uUA9a2nkLa+6ZZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by MW4PR11MB7053.namprd11.prod.outlook.com (2603:10b6:303:221::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 10:42:37 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 10:42:37 +0000
Date: Thu, 3 Sep 2026 11:42:32 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Xiaoyun Wang <cloud.wangxiaoyun@huawei.com>, Feifei Wang
 <wangfeifei40@huawei.com>, Praveen Shetty <praveen.shetty@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>, Rosen Xu <rosen.xu@altera.com>, Dimon Zhao
 <dimon.zhao@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen
 <sam.chen@nebula-matrix.com>, Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang
 <zaiyuwang@trustnetic.com>, Thomas Monjalon <thomas@monjalon.net>, "Andrew
 Rybchenko" <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH v4 22/23] ethdev, drivers: isolate flow director
Message-ID: <aplPGC0ETfdMG3-h@bricha3-mobl1.ger.corp.intel.com>
References: <20260803165304.289869-1-stephen@networkplumber.org>
 <20260806051004.166778-1-stephen@networkplumber.org>
 <20260806051004.166778-23-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260806051004.166778-23-stephen@networkplumber.org>
X-ClientProxiedBy: DUZP191CA0007.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::11) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|MW4PR11MB7053:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bcc8a69-28ff-4442-3f1d-08df09a811ed
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: sUbnFUD+jr2Umaj+fiH6q7/ckXx2Qwnyt9PVNhwSykPidqkRPcF7L3wYAH1nqVir1GUr3MN3FXouuS9DFF1093YsOiJ7WM26RYmG2DWVAC7OAaEPtUbBin/+RS4BkS/tuv+cJGC7Khhe84A3TJMGVhu/hL+/dl+OSkkTDwgKJQz6uYu01BqTyaye7nIgTI0RbBaATtsdwt0KugCRBoT5OYVG9MBo5vJjL1CiNvLxAghU6uuy8XNBWmVaocS2dwmcyKDDlXXwVzUFkzxDRPlnJvAFCbkMEbrX59S8qxwK7evsDqWECoVAPHqmChWY1aOsLcd/lFszdwNr0sVIBsuLDbKZAss5+TWrgNWGI75LTLt9uCtO0xzlGW3P1YhHHjSKNVxwAGaHy4zFk4Fbzj/gROCAVLuWLzEuFCbUsalj9N085zVbMuC+lxIZ/4jy+0bEsxsIhuOBYtIO9T9NrQz7Bw09EVI4P282RfGqpMVFdLH1WL5UvpJrWQ9AUzxPShkMnI1SYNpEKoXbiWxEQ8WhspMOHd8tU7XvtZ0McTrT0g1fKGFBX5M6p+8qRNwr61iEAhXjjiF/HkEVrH6I3/sG4htlTynl3m71P+wBEmSUpOBI0ef4Kp6GkzjILKVc4HEn6U8Mhz+W3X0AZTz8SG3xSAsJAEIMEFaLtz/MYhoLyoE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YhvSaAPpp6eanalGmRcHlsYrO1iPCeGp9Ix8EctevmMyzdUobg/oq8v/PUfT?=
 =?us-ascii?Q?/0ATqemYoTOtHcX7NS5ElSRs7ULFjbagDWUstve5cJdfrLDlog88aDolK2N+?=
 =?us-ascii?Q?DT40bccdbxEPtVXnJtU007g3Yax55Qm30pif30H1672XFdueFCGGAC82c0Ts?=
 =?us-ascii?Q?BXmtI4iP1rmQFzwgX7Zh6YamswGSrUwz4F6K4QpYxKPUskF4TlT74ph1qH22?=
 =?us-ascii?Q?BAth8Xgzr7yaFo45uoWDDEzsxeRw7hp/JCaLkgr2dyhJrpteTDBI3Bn10aVW?=
 =?us-ascii?Q?aihA0wNlDy3opPiPUaQbjG97kEwIUjE3zxe3PKbJNg11Y514KiyZgLnHc9zA?=
 =?us-ascii?Q?ryIJvOjGMfU6P3UiLXaxkC5Kw+NfJJ2Eigy4Cc3evxA7+P1nXbaoz1mWUoAs?=
 =?us-ascii?Q?czZgwMNVpJnZSA2XkEEdiBd7Bb9sFhj1rDbs74aw9box7/qGVY6IiAHqafep?=
 =?us-ascii?Q?4HYJW05F5va50LOTeW7VCJ4f6PnW3CpYKsW8adune3egOLXuc40OqCEy7QRI?=
 =?us-ascii?Q?a/RVX3HgSKaK7pGxv5MOdgmaEFHQ80bBV206D+aVYt0sN5rAUcQ18FnpCgum?=
 =?us-ascii?Q?ezhwfS14A17kVeLdHgLNlMnBSkn8GvWAPP74uhxaIMBciUP8B3KSsqGLTwlT?=
 =?us-ascii?Q?bP5MRSQPSgHndEzQendtVCaaduIUtQ7OSRsDC18XutHQpsDqI2j6QVcz14X8?=
 =?us-ascii?Q?rpPTQCVOs/H/f2ZxNxY9A62XDfpIXpVgsM8kcQnt7kRzwiq2+RlJWfl/SxxE?=
 =?us-ascii?Q?uezAarFrhVB+e2tyHE1vbCW8gE1LX0OpA0P0LJK5c3YG47D0Eusg4YbCorG9?=
 =?us-ascii?Q?oBj+bPFJvLjN/gddOx8NGVwMyql7SgSLIizfZHfS4owYuyV33ztXF8/tai6c?=
 =?us-ascii?Q?fEkte73bjkFRxM/jELPPC+AXgYQY7C5NnO+V0XmKAqSS6Wsand/77qB1SjFr?=
 =?us-ascii?Q?kAC5PbSaPwnZy7RocI6zyppcmydTgwAx8D4nBnIpXG/5OzupzJb4zvH/wOoi?=
 =?us-ascii?Q?ov66qIr/xSsuWzvdhIRXOdeMsWckA6NbTMZjIh1wZ0RHpnQXCF468KM+HSaT?=
 =?us-ascii?Q?BGLCzzBNbWk88RvjSqcGVAstxDSDaysgmpIIT9vmagiU1EbjGg91jknveMUb?=
 =?us-ascii?Q?FB6He7Zojp0Yds705ihGEGUGRbCJWpgq+7MlCqJm/LXRjV1pT9bnaYCiEurU?=
 =?us-ascii?Q?wt1TFcBOUSO1u9GI90PCwHVL/JPt0JHhgsgF8eUOI+mQcqCoD4nqiWKCTPlV?=
 =?us-ascii?Q?vOsLCFMbK8allvuH94X2ppj8DsAOYYxBmW41Gax7qufZUdZP7mbcKhSUmozw?=
 =?us-ascii?Q?GgCjHPZShmBlyWjU0gWWe5Oer5ReKUBzaS5u1qulIGSPzWV1UokVkM6Ts32P?=
 =?us-ascii?Q?M7wON0Ci15q8r/lUyxxYENBOQ2gpQB1MtyMBLizo63OfLEFzo+Gy7hbVaZlW?=
 =?us-ascii?Q?38Atx2cr6er4H1BirLIke3IqjZSmH7Ud035KUjy5puQdMiVUc1w8xvSceqmc?=
 =?us-ascii?Q?LCID0r+3u6n3vSQg0wKVi5+5fjRi3QaCQI14KD4ODrBIV/tUo3qLsCwn9WlK?=
 =?us-ascii?Q?TaIBo0ZS6oWwSxqlMKG8MNK/pAsa4E6yVRRrYTuwMyh84RAq3BElXmgvTyVX?=
 =?us-ascii?Q?bo5oU1XfY0mgSUxJ/FsXZPSU2O3BIM+MBCGImh43Tw6d4zwHz0y2DyhP2Lqm?=
 =?us-ascii?Q?l8bdZpCALXs/VF11kmFH4CsCP+LKrdHkCoXqy1qqJDi4LOm53h9bB02tiji5?=
 =?us-ascii?Q?FVEmpqjVYVOn690aeovde8RUDTfUisY=3D?=
X-Exchange-RoutingPolicyChecked: QEmPJZQeITF+P91y8Ct0/vkJWagiVCi6I+kNDTePMdGEgIa235yw2WMHU6kDcxQwL+I8ypVkvrGJrYkJwicoJvo8pNydLawtId/RaX8oCqCDpCM1LlHX99qB4N+TrZ1rFUQXEGnPJ4YnvoNMpbKlVqxGm2YwA6fW5vKOgsfn1N0GDa/k6Hjrs7uW5kDeSmr4qEq9nevDjVOvUqxnl0hXYwYZHf6PqZfz8m9pUt+Tr9e4gepyoiBYg359i852fOcmsCUcTTWHHp74jplErcTuGVW7CwYAxK2qp8cO2GD6LH66ytQtCegTrNbXULQqR1kmmXGjThh5hRW5EXh2Ovf/zQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bcc8a69-28ff-4442-3f1d-08df09a811ed
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 10:42:37.1508 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g1Z0je8Kx4pNL+N3EVU08ptt7MSWkaZYgi5OKo/Jmna7/xWqsU9vFYevxMSbO3wUWqs8fLLNJuDzAv0KGBCN7650NjF4MpJzVCtDnrpbiDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7053
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

On Wed, Aug 05, 2026 at 10:09:16PM -0700, Stephen Hemminger wrote:
> There are leftover bits of legacy flow director that are
> still being used by drivers. Move the definitions contained
> in ethdev_driver.h and rte_eth_ctrl.h into a single file
> ethdev_fdir.h and only include it in the drivers that
> require it.
> 
> Change rte_ethdev.h to include the headers required
> which it was previously getting from rte_eth_ctrl.h -> rte_flow.h.
> 
> Since ethdev_fdir.h is internal for driver SDK only
> it does not have to include as many secondary headers.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  doc/api/doxy-api-index.md                     |  1 -
>  drivers/net/hinic/hinic_pmd_ethdev.h          |  2 +
>  drivers/net/hinic3/hinic3_ethdev.h            |  1 +
>  drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c |  2 +-
>  drivers/net/intel/e1000/e1000_ethdev.h        |  1 +
>  drivers/net/intel/e1000/igc_filter.h          |  2 +-
>  drivers/net/intel/i40e/i40e_ethdev.h          |  1 +
>  drivers/net/intel/iavf/iavf_fsub.c            |  2 +-
>  drivers/net/intel/iavf/iavf_hash.c            |  2 +-
>  drivers/net/intel/ice/ice_acl_filter.c        |  2 +-
>  drivers/net/intel/ice/ice_ethdev.h            |  2 +
>  drivers/net/intel/ice/ice_generic_flow.c      |  1 +
>  drivers/net/intel/ice/ice_hash.c              |  2 +-
>  drivers/net/intel/ice/ice_switch_filter.c     |  2 +-
>  drivers/net/intel/ipn3ke/ipn3ke_flow.c        |  2 +-
>  drivers/net/intel/ixgbe/ixgbe_ethdev.h        |  1 +
>  drivers/net/nbl/nbl_include/nbl_include.h     |  1 +
>  drivers/net/txgbe/txgbe_ethdev.h              |  1 +
>  lib/ethdev/ethdev_driver.h                    | 36 -----------
>  lib/ethdev/{rte_eth_ctrl.h => ethdev_fdir.h}  | 62 +++++++++++++++----
>  lib/ethdev/meson.build                        |  2 +-
>  lib/ethdev/rte_ethdev.h                       | 13 +---
>  22 files changed, 71 insertions(+), 70 deletions(-)
>  rename lib/ethdev/{rte_eth_ctrl.h => ethdev_fdir.h} (90%)
> 

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

