Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F80C88E75
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 13:59:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 777EF40A87;
	Mon, 14 Sep 2026 15:59:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 8FF42402F1
 for <dev@dpdk.org>; Mon, 14 Sep 2026 15:59:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789394386; x=1820930386;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=uARzIIucdEAtt361bm+bhn6D3Qg7zLQ3Icx+dzcA4bc=;
 b=YHx6s/OVtsXG2DPZiBFV4RujpGzhPJ9b5FiazNwp5f6nvhtzTuvwn7L/
 L9Q/eQPwSGF89ToISmDpMY8ZVOcOOR4i4fJkSxBeyMOd1KKe6o8bZlTh1
 C+BxhX7MMkdVMqkevLSc43/PVUXdILGa8A3nTXO5JY5YoQt95AL2Ycuee
 0yfAHDvjLH6UvMvQ+QOEmqPYMthNxbBy1hBn3lE4FKWwWHadi6M0uu4lF
 2ba5losswhHLkhugZzyGyHoT9/UWif+s4LlN2aE01GWxuD4wQg7Kbi+iD
 k278NUlaCkht8Mj782FHwLA9npnXe3NSMHnJoxdJktMPU7SVeNEAd+ZNL Q==;
X-CSE-ConnectionGUID: bWE+s21gR7+7hX+0eUWPMw==
X-CSE-MsgGUID: R4lqLIPtTj+NhLuC0RE3nA==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="107257600"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; d="scan'208";a="107257600"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 06:59:44 -0700
X-CSE-ConnectionGUID: cqZylVCWQJKNWEcnZLgblw==
X-CSE-MsgGUID: Os1NyLQXTyqBGiHUvUj+4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; d="scan'208";a="310923046"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 06:59:45 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 06:59:44 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 14 Sep 2026 06:59:44 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.31) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 06:59:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oK/DIPZJiqLQQoU+zDimp7fBMAvbA7jxMQ6sqHk1oIyeQTR/11eIvPGii17H+gjU0R0Fk99BPILgNlwOHyXMK8JOXxwhcoYTDTof0xnquOi8lBDhpWmxy29ESIaTy52mI39xHrhCO+d6B3dsUVu9XDW/e6rFroirsaQuSfnu56U6gc8dm78W+UVZkAPKwE2OzZ65iNO8OhzSe7jN/TpqFcN11n2aYhSuGjDRZH7O7kL7gRWvrglqA87DurCNenoFuaabvdh/CUqmbPKy0H3GKlf2R1Y5pgRrwOLQrEUkUF9xhmsXl0uCWavJXjIOZHbVKNJ5QJAMt6PnkgThIQjBEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oo23Vrh9ZZIx/k+KrYR3fPW02nKLyOS495LWauq5WJc=;
 b=CSTJNzfOLARAyP9i1T2z7v5tm52OJ9VouLmqr7jc6Iu1Ko4pLWoyTcGbxtyvv6Gx1olleZzu6AeR4sxWJQpur8+3qYPuWD53Oz7ZRKx3eWcDGiparxxNhoER6LfFE+QuBOg8dldEhjjir3aVvJowariLx5QJxeoibi+9+HABg64yQViENzBxQbFEIhZDZlTmse1jxcHEu2jDNBc+mRNNfyJ7t/Qs6WxFTQecYkvVrpP3S/Hho8y7xjZFcUGxYvPaxHSN4x7txTsGoZE35Ign21gEY75chnGr7oTzH4yK1ji/G6Hx+BoRuVG3nEtFkHQJxA6oJ/bJw2Q5sS7oni7o5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DM6PR11MB4580.namprd11.prod.outlook.com (2603:10b6:5:2af::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 13:59:40 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 13:59:40 +0000
Date: Mon, 14 Sep 2026 14:59:35 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 0/9] consolidate sysfs access
Message-ID: <aqf9xxwKC3ChUX2A@bricha3-mobl1.ger.corp.intel.com>
References: <20260912063319.4117869-1-stephen@networkplumber.org>
 <20260912170338.486978-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260912170338.486978-1-stephen@networkplumber.org>
X-ClientProxiedBy: DU7PR01CA0010.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::23) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DM6PR11MB4580:EE_
X-MS-Office365-Filtering-Correlation-Id: 664894d8-7ec6-4909-3cce-08df12686b57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|5023799004|4143699003|11063799006|56012099006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: /LW8ds7x677ay1ZRcS6R5mCxle55Zz7udwhB/jWe4bPRnKztel3d3HFvSJSYrU59Oki9XcW5+osIw7MWspM818N23tfb+T/+Nqh94G+TwzE3/NWdSeyoGfX5q6z0FrMC3faxn/HVcp8c7QRJYCEmPvGAp0Dq/0kCPeuBi59jrlK2bARSXvNU0VvBSqCVuu1LR/MFZUiLDG/mwR6jBj/CNanb9VuOrZ8Q4dqkqHWG5T0Cyb+JzrI2T+RkF0Hxrv/DA69KoU1J02ra7a+8B4Z8sr4cxtHIHXJeMbKPIM3mtU17HqWOltU+KjvAfkwr0E14UGq/g1yovksZ7vOYHRrqiA0MU7KtJUkI9Mon+mkHdiWv8QCBpUiHKiHpYzT1PPis/wOzyCGYoQWB9Q+fzAeXjTqXak13hamtnpfM0WOUH6F38Tnt9LM+QQVW5fRcLw1r8MrLuuYp0mYvKmZ/miO4QdafAmtoZ9sLX2p0Y/uVBg49roA8U7W0E3/97d6Nb2lSZk0Mh4nj8kpN3KcgpzMpYo8Enm+URqqJElW7tdKIhniSJ2TEamF3nULRE7rLgOHVHhkO3doq0HtRNOIlh6cTFRvTQBF1RWtz5hhJzh6bLdbk4Ir5Cl0hU58dEal2oBy/OSSQXEDYzc44ncLKhepgdDhUfdYPwgHR12ha0rj+9iQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(5023799004)(4143699003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P7xsWgG/68FqG0LNIX8oVC1o+5ELejdocPLTHQ89sPg4XlvBNe+bKBXt9jpi?=
 =?us-ascii?Q?f+fJCbhQ+rT3nw0ygAQJTrq/dEuBu6HaJVovlibCL9NA+Ar8CKJWg8CSfxdP?=
 =?us-ascii?Q?nnRTE9VYR1zGvTMn/geNPha7B13TALxzBI8DuVxa1RfIP86CQsQRzZlo6fEs?=
 =?us-ascii?Q?3Smx08ohAGTt1Ar9pzkUd9vKUyt7n/8Feioapo5p6tfpNKddKq1ygS3QRHSU?=
 =?us-ascii?Q?beWECMPzlNG9pZ4FkTkq3x7F1jqX+x/dZimWmleWV87lWOFNNkl3vzihzM8r?=
 =?us-ascii?Q?Y9PO+kCjRbBA05i+mPIPSV8Bq990xrE/7Uzq+QzvfVrLiAubw0Ze0tpXO4Os?=
 =?us-ascii?Q?tdtnBVuXSoxFMLLPEC4dKnjggAKU5rmaFBJ5jJVA1rqtpajp+QrDZdyAr+PV?=
 =?us-ascii?Q?mahaS1jIdfCryal2gRleT2Lhh3cZfh0T7a4X3sJg0e6U8/eUvx4ZvMTimie7?=
 =?us-ascii?Q?zK7ZGvKs3eUsoJIecTBs2wlHBvowgTTzEQ9xD1issnq1K7EycEWYiIwcv6MO?=
 =?us-ascii?Q?0bo5tcEFVrjrz0gvtjKvk/q4HrtBtvRDESrpFHeFcNez4Pt+uDCX3/+/CgCf?=
 =?us-ascii?Q?iejepit/OSrIHThrPc/Bk/WihZ9VQ8BNpDWtz9tn3f1/w+vAPUZTe4wIs5BP?=
 =?us-ascii?Q?8gVCuTsc9UoLW7fF5L0KXru8kgkwPMWQBWnJGqQmrckNilksTRcIJihzXsUt?=
 =?us-ascii?Q?Xgw7PuSLEKSXM9QZS+0ubuoBACygrNOkZB7cwiStpBn+PEtVCepl3IymZv2k?=
 =?us-ascii?Q?2TaRThZ4YCFeqbQg9vkWRsT4xBRe3axVOww7p+xmi0tAs8nI8ETgznVkx2XW?=
 =?us-ascii?Q?8vDtA9dowaklAJ1D7ifHfO/egUq+a+jOCRF+aPmoHscTS8y20I3TP7IyqkD9?=
 =?us-ascii?Q?Cu2WABXHKNPg9VR3CNLFgBWPPD5sjAB2dJ+cT2GIUg1iZlKhrjM3jln2aacR?=
 =?us-ascii?Q?j62rimUCyGq6Z9XBaK+jhf5V1Ci1suFavUCzgchhg/hmlvnAdm4ElcThcaMi?=
 =?us-ascii?Q?UGJHNy20Sd6PwH7n7KvHv8EtRWN9G+Qs1vbzf0vJMq3cOL3kVAkH755GD/X1?=
 =?us-ascii?Q?dSQ3QbWsc21XhNLCthe3jHUrYfPoGexjHC31+z9psocmi8HrazWU8VadpFeI?=
 =?us-ascii?Q?mKZIDrNMrQccXN4N1bV3wP+eE+J+ms2uirpFcb+Rbv0MVPAfbL9cQFiL5Shk?=
 =?us-ascii?Q?gIzpGDqkhS4+suZEkSKtuXet9joqTSCZSE/hMHtiG5ZFCeFM9bN0rp9UAwpf?=
 =?us-ascii?Q?7CyA2eTfp6Gjf+GOx8+ShzOJdfP454FlpKVROYlM2CyKjGFXBfWFY7Q87lPv?=
 =?us-ascii?Q?TtPZGi6HIFWUMJi5uWf9r+Ef4czrPYvhZaqfBXk7KlB1+IC1SlIRErxGOfll?=
 =?us-ascii?Q?2zM30c+EFDyEkRrrenpKh6yEw6if26puwVxpddSRxDRJ9xK0NEqgXyiwCCRt?=
 =?us-ascii?Q?uUu9QWhZLUieK2IGFVZ9skelr/QuIQxWpF3NJ2gNoUolDHvNu93PMnE8aUvJ?=
 =?us-ascii?Q?pC37zi3JMTXUl/gfhFe29LdX9FA6toI1Ta9MHEvqVGSSat5lnHsvde5gHOcf?=
 =?us-ascii?Q?CXFeUXFuOAh9K9j58C5IBCV1hhjqCCVRSu76ya/6BXjrdgz7JNttlvCT+VCJ?=
 =?us-ascii?Q?NT91gmK4Y5FyY1oXsCWocId0wxhkwEwsvSr1VM5ftEGBRClc25yT33ULU/KM?=
 =?us-ascii?Q?R1uBne69zIeKvd1mOlgT5WpA1tUS4khy2ZO2E9GD+i88H+3oQLSUycPTEGAS?=
 =?us-ascii?Q?lCntjFPoRAL90/g9Jif7X8Injxt2b+o=3D?=
X-Exchange-RoutingPolicyChecked: HJ/CjiU+AnxfdG9DmlmI+odIS4hQ+s7VSFGjfzNUKDKatQJuVdOklZ87p/ifmr7fph4Hku8R5g97tJoQmVXfq5yGFMHv+uv443KlU1+n/vDCLL98pqQKb0ypnYnf1vV+p2Poj1z+Z82TPgSELAWqqT0XbOsBZi9F7KdBGK4/B46qoGgXJTSNyGlnxlqyeSj4FDxg+iBwvf3BifBJT4I14PEfjQn+DxjYKJjqeUfIWPb9TYj/moLyUfHjZ/ktfei/DlFOqytVAlfdR2dGn0cjvIbngX2Lfz1m/WFajHSzMf4znr0P+F/KV3e2ZGvkuCE6r8N6BDtpE+Ow/IL5KdAnzw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 664894d8-7ec6-4909-3cce-08df12686b57
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 13:59:39.9620 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T50Vjwcn5e/jklGcyvE+w8mk2oD/HbxAyAP9DAKQ9hV4QpuqXn7YR0pA8+McrwlPmzIYwqsbkqeQXZCgj+DmAYzp/rfocLP4BmdHKHFdUjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4580
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

On Sat, Sep 12, 2026 at 10:02:12AM -0700, Stephen Hemminger wrote:
> After reviewing lots of drivers and seeing sloppy string handling
> resorted to AI assistance to unify and consolidate the parsing
> of sysfs values. Many drivers open code this with similar pattern
> but lacked any coherent error handling. The kernel API is
> consistent and won't give bad data, but it make sense to
> check for garbage.
> 
> Add one set of routines in EAL that build the path from a printf
> style format and convert with strtoul()/strtol(), then convert the
> existing callers.
> 
> Since the new routines are Linux only, a driver that uses sysfs while
> advertising support on FreeBSD or Windows now fails to link. Two such
> cases turned up and are fixed here: the eal_fs test and common/ionic.
> 
> Note: existing eal_parse_sysfs_value() goes away with this.
> It was exported as a stable symbol, which was a mistake:
> the eal_ prefix and the private eal_filesystem.h both say it is internal,
> and nothing outside the tree should have been calling it.
> The new rte_sysfs_parse_XXX routines are exported, but marked
> as internal use only.
> 
> v2 - checkpatch fixes
>    - clang format attribute fix
>    - sysfs is Linux only, not unix
> 
> Stephen Hemminger (9):
>   eal: add common sysfs value routines
>   dma/idxd: use common sysfs routines
>   common/ionic: use common sysfs routines
>   bus/vmbus: use common sysfs routines
>   power: use common sysfs routines
>   drivers/bus: remove duplicate sysfs string helpers
>   common/mlx5: use common sysfs routines
>   net/mlx5: use common sysfs routines
>   net/mana: use common sysfs routines
> 
Agree with this change in general, and I just ran a regession test with
dma/idxd driver, which reads a number of values from sysfs, and all seems
ok.

One question, what way is the patchset being split up? Some drivers are
separated out into patches 2-9, while other drivers are being updated in
patch 1?
