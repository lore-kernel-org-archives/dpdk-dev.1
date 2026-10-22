Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3075606A31A
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 12:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mFP+nkAI
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB6424060C;
	Thu, 22 Oct 2026 14:57:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 750924060C
 for <dev@dpdk.org>; Thu, 22 Oct 2026 14:57:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792673862; x=1824209862;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=TjzQzB8K6KAbOenYknwbVKTJY6RsiAvhhEu+0xY5uGw=;
 b=mFP+nkAIswea7pyCKoOBQgBNUyrf4ovkAsCRWPxruXyIPBDgDw3ksXsP
 SPcQd2QPxkHoQdglIMcyCr3461qBAvnSIWEc2Tb/xZv0Ngc46rsn+Nv4W
 OpCwsyjBg80HaRhzcBqPHAmbnhPZqiGBxIBfsIlQcsoi5Lr/NqKuvhP6j
 mFQkCQR7vjBwDoIJBshWjdxFtzB2vvPG7rLNfd2+hnlVuED6Q1BYwPKBH
 vChBjC3YuyIj38ak2yQqW/fXfLA8M8eDqoXSpO9NrN2v0jfKd9AjuVnrN
 MTZJ4I3yj4SQKnJiPG8OGtrXwDe60nckpoiXv8T5yHhF5Mk1oMXcs5UaU w==;
X-CSE-ConnectionGUID: 1ZG0hSNyQpmDxQpL8X0suQ==
X-CSE-MsgGUID: 7ud3BPp/RuiCYWmmnpdHsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1293630"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1293630"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 05:57:41 -0700
X-CSE-ConnectionGUID: Av+KyT1pQKWi9sKfmf3UTQ==
X-CSE-MsgGUID: zZHu7LZZQJuS5KBbz09Qkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="5177100"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 05:57:41 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 05:57:40 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 22 Oct 2026 05:57:40 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.19) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 05:57:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mlgWKSenIuL7OSDpqqKXjpqpkb1Ec2K7LeVnaQnQe3yosC6CjGFU1831zXaWUOh5fx9jjMU5IR385PgtFL8YIe2m8Dp7e1JRfVwyhb401dLxd1SLtNOJmBfQP26hP/Be7AZgT1cVJPhW6Omtu7FO9M3jB2bLZesMDLS7NGUy84Wy7C5mBgDopY/WITUcx9y5ftpsUOrk3WGA40OuyrSNg5b0/u7zCbHuBqIlF1vPLBTNOnYY+c8o6DD+9C1vijWsBs99WQZ703iFTEGikH4viUoLH/RadZGZMjnjj4oe6bpIDi4CfXrG5k3zaZDNgnQeUJwaNrk/4mlp4M/a4LLqAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCM6IuAtDGgkRWp5M4Qn2+i7A3tR9et0x4nyBTb+aoA=;
 b=mKzLpOVJZvoicYb3Tu985OmnrUB5jhTWFgzUyr8Fh1IgfxjgFPda9tZDM5FHgooLfF8LB0dTAM4/A4BE/Nyuvx3Eu/yKpzBnNF65UuDdFaChCwwVq6jKj3X2isIgrkewgahM4zLKpJ5+gw8ZciLxeqBU4HKbJ8WORzk3dn7GEdAzGVXEiRUGLHu+91m7XRLVQFDZ0HI8i2Ywl/PA3UoelV6EpQBenFkhEfxts8EzqbyFQL5yfLo4GM4UPA1ysYAw6PjMgvvYP65fj8yAcW+hAZ6pbuSXMFU5UNBeyUFzQv5yEOxlH+B7qNUFjHRefQmE3d1it3ZLegsWjeyihf61iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by PH7PR11MB6497.namprd11.prod.outlook.com (2603:10b6:510:1f2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Thu, 22 Oct
 2026 12:57:37 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.017; Thu, 22 Oct 2026
 12:57:37 +0000
Date: Thu, 22 Oct 2026 13:57:32 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v4 02/10] net/iavf: do not store ethdev pointer
Message-ID: <atoIPBZ_pQkCEvHr@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1792592724.git.anatoly.burakov@intel.com>
 <cover.1792592724.git.anatoly.burakov@intel.com>
 <ca5d8bff6bf3b9d8a597b354c2c9e547ffdf7f34.1792592724.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ca5d8bff6bf3b9d8a597b354c2c9e547ffdf7f34.1792592724.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0335.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::19) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|PH7PR11MB6497:EE_
X-MS-Office365-Filtering-Correlation-Id: 85e98395-54a8-4138-f75d-08df303c0c37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|18002099003|22082099003|4143699003|11063799006|261009223027099003|261021123027099003|261021121427099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: taIeRHaKw0xloE8bwQEf4aIYlChH4GMyB97v/RhWmDTAiC7LeeD/lpOe8aQ2umRjqHOR5mAHlPWwhsCk+/OKkwS9Q220PC90/1db++jpPqn2cwFisab3mN4i9iE17Ip5F9Qw8GsdlfXLT+IdJ/FKqUoz7RcQF8YWfbXWviYjIyCIPFTv89rtroM3FdKfP+hcrry+zmJgGTF+k+z/D1xI4SlnqF9CR1BKigtI4qdPxeKKBtUQAwIFitV/RZxe1VjnbGXgHGY8Ipw0qBekrZmyptwAN1B8J0Qt89e1nrspP7iqeW5fAv86o32n2Lj9zXIi83U021XCTp9xEJIe0MCNpVsq8srPQFG2SKvqtSwNsq/iEvEf0lLGqhMntsCctKKbxDlazNuG0EY8ovVxe6DCinrw9RSX/0Bu6loUcajsjVWCXDYRNTcrdDt0zmAk3Kz+QIBfhMDDCJ2pSSpPu9StRbxv/gHqE7oSHJ8hsuhFdh53uIh3Fi5Kwmp4QJRcELXJDvzgy1OlQbVF9XOGoNDD8Z1TxA94cryGrylhDhVGgsRJ24dz8lFcrQ4Efv2cTaQ8T/PG1UztBDigt1XT3JcjHJ//qAvtYK03122Lbib36A1PKn8pqerDU0n2qJVOjrl4bol6kKsV1V5mZSXl7s3VTZccS4nihxEvxCP4RH3nd4A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(18002099003)(22082099003)(4143699003)(11063799006)(261009223027099003)(261021123027099003)(261021121427099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IYc0xcspyi4YBtJ5D4ONQpLqee3LkWmn/GX6Cak0ueuPRYNjAa+DhKkzoXPy?=
 =?us-ascii?Q?q629teTq4l6MuONHdrPqfsMGwWb6OamTV3rVErmXlCkpzbpY4zcCh0RtDh1u?=
 =?us-ascii?Q?UAgfdFDsy1LIkBDJwxIm0SN0s7y71nkMaXttPwAQ7nLEYd/6Z6vMCECQu3iH?=
 =?us-ascii?Q?mLUiunIaes+h7xBo7p38yWx+FTwYaFIFn9CMpAF1LV+Cfqx/+UnhZFVZmByH?=
 =?us-ascii?Q?AUthEyMs9wKVauTeNWLqMRZMXq1up/VoiR/XOMsgLm0lPJaRRwx0zKFO3Brn?=
 =?us-ascii?Q?aDF1eziApr1/ZWc/UYjOyAh0q4okjHfDy7t5clbe7RJHv6zKdRDcY6rjHdNB?=
 =?us-ascii?Q?LSBQwYGyApTM5jcGSShpx1o28GHMSY4QVj64Z1JC6umRodRtIAEHzBPHAiOh?=
 =?us-ascii?Q?ECC9/8mrGKvnS3tyuGbLWIADUKs77KwIZAw+yJ7TLHhNOmr8p79DcZd5oD2h?=
 =?us-ascii?Q?UxwCot4KdkvNrzI4PYzZLn5750A0I5evMyp9Bjdv8UNKd9QHCLka2oP8BZ+P?=
 =?us-ascii?Q?JiPup9ddPKQHWjaORPh6mMguB4AHQnwM3lV2GkXpYix4AfEsTOH6a5XcNkuz?=
 =?us-ascii?Q?K+aFHO7nFHczZcV8FxaJj8oTRokALeLhLN72FBbHSnMzhyIwG8oDbOZxoEvv?=
 =?us-ascii?Q?mqy+yyMzTm2WPwmg5VTSMnLz/X7ZBW1Cd1dTVa9AIdUg3HuI5d4a+wT1ouzu?=
 =?us-ascii?Q?6gYrHIvOuXQ4opaM9vxr7MOZADDGENZ3Ffnpvq0W4gmV/Ozl45BB3GP1TVVC?=
 =?us-ascii?Q?qdVCLxBWEVdEntc/9j28CjV1VhkiXDBPURVyA0m5dMiJgmHkQPraHci+j1Bd?=
 =?us-ascii?Q?yBW4hdveXbrY2hjBmS8BWoPExpkpGSuXcg0CTaf8tx2/kvO8YJNG0y6bzZmz?=
 =?us-ascii?Q?CJWbhkZeWJOGpx8sEIP9fAw1+54o7VBOCQVyh64wwWbsXAh29nikjLSU4P8o?=
 =?us-ascii?Q?s+L5P0611cyldoZr2Rhoh1XqZPD/zzetAwQzb9xyaVGmRaGRzuZhJqCDDEgk?=
 =?us-ascii?Q?8UHzG56FvtOp8Yl/a7oquh2/tqU+6K1K4ofZeLeBodFQJ9xSwDV0jzxY2tYX?=
 =?us-ascii?Q?1E5g3r4AK+hgmi0wwnQNbrlNdxbskVaJL17al1xK7rD8NZfllkVAXw6JC9NQ?=
 =?us-ascii?Q?FDk0hr5QnvGvl5wtjobZWy7JbeVnA3kIB3nfHusngK1NBStqeetpNcYeK1kv?=
 =?us-ascii?Q?ozhqml60Hj+xjjmw3KU7oosudkB0QzX62dZuh9SKxO7ZTl4xKbYtOf2rAqz1?=
 =?us-ascii?Q?jy2uvA9ptRtYUZ2NOvC6/00cZE2zGbr3levP5hWMzIlmqTbwKzX9Q+jsJwJX?=
 =?us-ascii?Q?STbIazbXxdr5QJQU0ZnwoQgF1a12iQ6pJS2zFsEf7agyJnFh8kGe4J/fHFtx?=
 =?us-ascii?Q?ZyAnJztYhwkUaemZG5pfc+ystfM7Ogn8o+eL8v90hX0lc+FZ1x9Mx89+pymV?=
 =?us-ascii?Q?Mn4xvnjh5Sgij2BEliO0WI67eYxhRg5gPdDbkFqOx16/K/nDmKaFDgxhMF6Y?=
 =?us-ascii?Q?SEREMIN35r7ojhZ7fLlvvblieT5y7HWs7EUr9SSrq2gylacGp9OJithXx9h5?=
 =?us-ascii?Q?JX3PurGunsq0HcVFRFJZ5zUcl+aElPL9/45PgKLRcBMe//JDZ1xdCJg8hiq3?=
 =?us-ascii?Q?jS3FnFsfRI1wLL197FjVd8M7umm4cqCemWkaNXuY21xK4w8LsIu+4SYlI2Ib?=
 =?us-ascii?Q?duUkn1a2UKW5aTsHhtUU0rUJJNhfbM0/xLvkdpMNKL8XbodZJARSp+wMkWXX?=
 =?us-ascii?Q?gd7OqySJ440RTQ08rKap64QAZI3B61w=3D?=
X-Exchange-RoutingPolicyChecked: ShJEB1n29f2CkoxCOsUzUuJiBqGCX9dGQD7ADzokhABJ1W7/DAZfK3vRUxV58HqGqXbf1i/2z35FXChHqqojwR6SRd4h/zESJmfs8jtVuyM8XglJZCiUYYLnbK5viWQNxQyTojd/IkB58Sn79MEOpwaguwTIpY4wKKuyMuT34vypFap3D8/MkOuqbLl/pdxDbT1z/fykDMQvaxFwMn7yGagNefys7qcCCleKhO+Q1FV/G4fAVMweJsMG2Dq+08OXECVbtiPkHWdifqZq9InKLyfBf4FHjtTQU6VJmtk0rO+4FJS/z9acLctUH1NBaLv7EZYzx+A+PbvZSNjmSZTAlw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e98395-54a8-4138-f75d-08df303c0c37
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 12:57:37.2568 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: svG7CjWnQnqgoDsOUJ0MAHy+agsOzMQsCSSXOeCErXhN4vJM2QicDfDQeMG3AxIs/USbPfe3LT7+moKO+kryyIvD/i5SQWBPi8PlEO6kUzo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6497
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 03:25:42PM +0100, Anatoly Burakov wrote:
> We should not be storing rte_eth_dev pointers in shared memory, because
> rte_eth_dev pointers are process local. To address that, remove the pointer
> from iavf_info, replace it with `rte_eth_devices`-based lookup, and rework
> the call paths to either use that lookup, or not require ethdev pointer
> in the first place.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/iavf/iavf.h              |  9 ++++++--
>  drivers/net/intel/iavf/iavf_ethdev.c       | 11 +++++-----
>  drivers/net/intel/iavf/iavf_ipsec_crypto.c | 24 +++++++++++-----------
>  drivers/net/intel/iavf/iavf_ipsec_crypto.h |  4 ++--
>  drivers/net/intel/iavf/iavf_vchnl.c        |  7 ++++---
>  5 files changed, 30 insertions(+), 25 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
