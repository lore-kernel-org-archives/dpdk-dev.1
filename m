Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8914BC88E65
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 10:39:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C2CE40272;
	Mon, 14 Sep 2026 12:39:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id C570140144
 for <dev@dpdk.org>; Mon, 14 Sep 2026 12:39:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789382362; x=1820918362;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=4QH313AQlXfPuNGB/3qSLJ1sylPOO95cq7x9PaYzvBU=;
 b=XtYjiCLZgbiGd2oSLxSb3k/OBSXW/+0fqxMLdhia24tsE6DXURtIMZMs
 Sqo5KzFXirk0vUuoPB9mxISCt3QVN2/fLywOeolR3kWBLr/N7LD0JGV4d
 by399a4e8Laxmg2oJpdl0yBzLWdtmEaEZo9f6C1YaMnf35FWX2Nmb+mXq
 aMYDX+7v2ksRBHxR7hspWgoyXVo3DalBlNG4WUCCXfxlOvlnOG5GDC0+8
 GGmIYA5vur/NNxQvVgwa7fLBCszii0qNV3ElKaEjK4vm0qwpD6sKcPB6w
 V2ZGOE4v0l+qJWKAYQOWBO2eC9tCHk3zuoPcK6D9E6Bh6sxrxB/qaXYgl Q==;
X-CSE-ConnectionGUID: Glq/e8RiQn2mOpsi9E6otw==
X-CSE-MsgGUID: Q1AxWFR3TB6UZOvkD9d00w==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="93428000"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; d="scan'208";a="93428000"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 03:39:21 -0700
X-CSE-ConnectionGUID: ljcuC7bUTA+sw+d9SxfJHw==
X-CSE-MsgGUID: YxGQ4DOoTDGVtQYr+Y5W0A==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 03:39:20 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 03:39:19 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 14 Sep 2026 03:39:19 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.10)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 03:39:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YVpgWRu7vb+CH8Vg5FLD5NRiXWLgtajnJCkPWK6lsVIKcg35xjsv8bWC7E8C9yYMLaVaYb0jBLoC3Ky3sv4t8SqnOAlmftg8V+uCIGM2YVxHv/jD1SG3bILwJlFFfHqT3fdJN2rbAwdYBNSNFbfHuXSgXxjuvnBA5KNpWlmBTf3oKY8e75HQoTDGXWrAn+1qhQQCzCJD7ImsdmAEquLM2St15jnj+MBJteITostjaFjEUl/Ii/DKeA1YDr0uRvKdlUnBQgQKjLzWe/YuxMFsBYva21MnfcnCQwP8n3m9SFykb5uArYdItraoJ0MuCanIha6u1DlQwL7uVCFbg0R9NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LAOTKzBra+enPGxVOI/uvRdNPVjvKwTs4P2J7+6Q0G8=;
 b=h7wnLpkZHj9JF+SnZwOnYymi3aeznozlCkCFfiyaTubRsmK3RJb/wLHSO1eLEX6jS0+K0tXmEbB6ZQxaI8yW+lBWtYn2+WCbpBf6/qnt4pdVzDvAjY52lRoG9av/dDmyoXwlSxNnkuUvhe812BafMNaSvLw89hYK+YZUVLJkrX8dzCdOIGrcBxAkblhayaICVdzOWOdrdqtxciu/jaI8av0E/+oLR74FRUx6/tMkGNyYrpbAYsIRMWILHo3flluWGBJQMTNKC0d0N3oQXDIAyzQbXQtUOZgjfYMbqHpJT9xq6b1Fd1XNQBbOaGorIvEWfYUuK/CbcvuSipL9lpceJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DS4PPF267298081.namprd11.prod.outlook.com (2603:10b6:f:fc02::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 10:39:16 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 10:39:16 +0000
Date: Mon, 14 Sep 2026 11:39:11 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 00/22] ethdev: convert experimental symbols etc
Message-ID: <aqfOz4-BjGdN8kAj@bricha3-mobl1.ger.corp.intel.com>
References: <20260901203217.1485915-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260901203217.1485915-1-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0188.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::27) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DS4PPF267298081:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b5ce8a8-7e2f-4767-b1ef-08df124c6cc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|6133799003|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: LDNmGDeGgdhdnhVcQjADTfbU3Pvlfoy7rJ1PSLrHa10zWkEZPnAuZ+XMgrVd2YpfZ0PZrl36ukiGCWv4bP4tKyHzjyFeDtCBDZ9hZavdKO8fo4ICQ3IsKiIbYuG7xS3jCVYdUvD3JXLQCmzQ72n5y2/yjJ+x1YvkZrHq8qs98icyBL86sbBbCOrmOOprQ6ppCdxxaeCBgyrDPZ9RpLfDFaopUV/l4nDP7EgUO2crjjn25uJk+1a6BXSSbZLgcbsz9ClPkxKhgs7LjT2MptAfEcSnbL2pv1cKcEWHWqFHgQHoeSc7HgHpJQGs8+R5gZD4ZDNvQvQmNyCOcJihdEJ8G9SQcTX0z4tErXdXy6IqzOos6QE8g0Sesa92dyiXHEDPESPsaZ3zn90Dq15KHLwjRONurp7YElLUu+l0D+bZGwaHXRWd1HmbxPHaUn7TGtensO8gS9A2sOqOt5gVHxckBud0Sw1yMWItkIRN6nD9yi+uCKL6nNqA4j4lUUb+eUUIAamI2vWG8mliLzGqDV4y/L6Yzm8mqqqGzWVsGQ+9pZMSpXLmzn0f1B3eYYq6/sVlSssz57ZYKggVpehbCeKDe9pLZ1Z1taR0spw44LO6q4WF9Xt6LbxECBMxVrv979cBYX1lyuqLMt+IfcyiL5dRy66Jr+6ybdL6zs3KkirU7M0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SNC8uVWvcnMU9NzwCpqvq87dIRx9GJ6MmXuVY4e28Jl1Cwsc/V8YF6DY61H9?=
 =?us-ascii?Q?/0Ki1w57I3B9we2a7fihQoolxsFncehFEeVtXi8YqeDTz6uXeTBXXVLY9YKN?=
 =?us-ascii?Q?F46FpN6vCIIuWhU7SfRvfg1iCDVvwxxNSJE27TcJbmw+shkWDpmkdg24dkSS?=
 =?us-ascii?Q?6e00z4UKJDy+Hlj4R3m4eM82BodbmnmghbqbWcN/zSmb2RHb2pwKlE/pSL4O?=
 =?us-ascii?Q?Px3iLArByjbgwd9NJ6HiUpFUKy59tsMsnwmtQ9DGpCYKtj/ppXWKtkrRbaoD?=
 =?us-ascii?Q?vIgmNwxTJJlFywahb0TNmwPGd8Hp2sMjG+fl5NeaCRAs34390+M1mQyU6Rfg?=
 =?us-ascii?Q?miT0pUwc4oUyjpkDeuB4+I2TXZbF/z7xAlNR8UA3ey/rkl5YAdq9zjArQJfI?=
 =?us-ascii?Q?rzgc+c5fhDF8gXB3jzf8xmXf9g0hIATgLOMfE8WB+yRiV42foUtmtlyKKF4P?=
 =?us-ascii?Q?z6Mti4mAkb3RFNCwXO39CSo0bYGEYQPTrtNy+NmLr7+J1DdRRov5141MFw9u?=
 =?us-ascii?Q?4zNbKfTwu4lbtOAA98buCovkHfDHlNkhtH490i53UIgdEWSnxrhUTzboytqH?=
 =?us-ascii?Q?ZhjfCVy6XBuaHT2c0CwVo8iNcfs5DfygDmxzNTMQgIlMLKUBcxUL1Oj5BsgW?=
 =?us-ascii?Q?EABTs8RH8PJHqhjuSayK2pP7DlHBEpbQZBpk6Ooczazp04SZ7Yni/QGnF7wc?=
 =?us-ascii?Q?DLyllS50VGk71jcsGAQkTYt82HMCdBqMu6r0UCBRqEbB4B61sTjlg9ZpHJ15?=
 =?us-ascii?Q?BcVCDRNfF91LKNWGeIyHyf5BjXdFO1E2y6JbD+69betbz0n+N0J1C5erqhHU?=
 =?us-ascii?Q?o64y3+c+gFpu/mo3Q6gBscq572R0RcZuxsDKLT5HsopwVeYICH8kL7JzHc36?=
 =?us-ascii?Q?AX11brw6wMkvdncsdogqypB2pT6/EXwkARhzhvPd51GXp84iR0WosmpEgSo6?=
 =?us-ascii?Q?teoNSFerlxnLCmxnGDJS05ViFqgoSu2cZQbtfspjU/XpVugw0iv3lop3Z1Lb?=
 =?us-ascii?Q?lmYw2LUrRWN9AUvW6gXk8S81A6iYjyoH2mwWnCCN5FSxS3ITR3sWyOF13Rn4?=
 =?us-ascii?Q?FOmgKKaH0ad/JSAFF7TBNu+IUzkQxxsPevBKDk5ZEQFpzXi2Zi2KfcUbUbB1?=
 =?us-ascii?Q?lPO5ron6qyrZkTJqla1nNnYMiUjlFvfp6aj47Dx7z6+vzWiJOJAQgmDrClZC?=
 =?us-ascii?Q?VQJFaszTFCDVOmbVQ0Lw/RCEP+U/wF84nKLBhtihhYkNmupJkRXN6RogHC4J?=
 =?us-ascii?Q?rENHG7QY/BYxWJXx0/be6gSuqIgpjqu28XtChKJ/Q3zlhvGb33Hr2WIWkcNs?=
 =?us-ascii?Q?SQSpWhQbwE6WYd3sQTFIPxzWGbep8Q+BZsfYyDdb6U2luJ6uIs492ZsMJdGi?=
 =?us-ascii?Q?3jh8Bxb3RgD6TmWg3XVPQog5uYrVEgGwOusKTByp+U5sSkkz/Xaygiq6hOyW?=
 =?us-ascii?Q?apfgWCwO1/uOVwiUkqVjmroMI1qIWdO90kBViy2HgyRv/nz7jNNYq9gMnLHQ?=
 =?us-ascii?Q?RVVdM8RAmQCwTU2eA8ck6OOx30h1y4PXRdlLt9LghCc8xDuzdrLHQfY341Wy?=
 =?us-ascii?Q?mNayz5ZTHYYZwlCx1U/qCdpgz3rkRjRNw+1KGEPo60yJQJ0vREr7mSlE+nhX?=
 =?us-ascii?Q?gk+XxgSsoOqqU+679Ij9Og2/29HqqkFlY8Hbv77ZYJ6g/pBEVwESdKNUGSP2?=
 =?us-ascii?Q?3jdYrLmgf7lyvf9pze1Bho+jJonsHglW7fK+JiQBsGXRMVdME2dWOVzxqFlN?=
 =?us-ascii?Q?juF1zc7PDx0g2fAi2q0nvJYfBtJK9N4=3D?=
X-Exchange-RoutingPolicyChecked: S4IhLAXY/0/Sh72f0bYAX5JyCBjtoXQAK0lWvbyJb2j3ezr4kSntlK89fsaywgovuIgYPx4LijQe0jHciUnoXGu8SvrwFajBmo9VXYOvJgut7Rgdv0IzqRwOUJKsr3VbUeR/sUigUSbCOhuE3sXc7OouMqvQ4dSYOy7XJklDjaYvESNvh9pqV5JQHDRUccdiAvMUsgJ+vUVNNknDCsqibqcZvixRTirQ19wmDWiDuH+l84hKlp7KX78E1ovbfnFuUZPKnap24rJcVSnCdixJ70hO9jPyWUK/3RGwDmBV7kW4/aVyskmTHYFIBMVIig8CSJPoVaCyCYHc1IVq/V0Z3w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b5ce8a8-7e2f-4767-b1ef-08df124c6cc4
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 10:39:16.3963 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7a9dnWVda0R2ZAM/2cYmiE0j02SbozA7Xh8XN/zdcoFFAkB8zx52lR1x7KjC0LvGqEi5bCHTcGzUFpAbOtw8nkzhqu3NFafVwWXy1Bu7q70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF267298081
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

On Tue, Sep 01, 2026 at 01:22:59PM -0700, Stephen Hemminger wrote:
> The DPDK policy is that experimental status should be short term
> with the expectation that it will be removed after one or two releases.
> A large part of the ethdev API has been left marked experimental long past that point.
> Several API's have stayed experimental as far back as 17.11.
> This series promotes 119 ethdev symbols introduced in 24.11 or earlier.
> It also cleans up comments  warnings on structures and inline functions.
> 
> The trace point symbols are left experimental on purpose;
> trace infrastructure is intended to stay unstable.
> 
> Stephen Hemminger (22):
>   ethdev: promote meter API to stable
>   ethdev: promote module EEPROM API to stable
>   ethdev: promote rte_flow_conv to stable
>   ethdev: promote hairpin API to stable
>   ethdev: promote read clock and flow dump to stable
>   ethdev: promote FEC API to stable
>   ethdev: promote link speed helpers to stable
>   ethdev: promote flow tunnel offload API to stable
>   ethdev: promote aged flow query to stable
>   ethdev: promote indirect action API to stable
>   ethdev: promote asynchronous flow API to stable
>   ethdev: promote flex item API to stable
>   ethdev: promote remaining aged flow helpers to stable
>   ethdev: promote congestion management API to stable
>   ethdev: promote IP reassembly offload API to stable
>   ethdev: promote per-queue priority flow control to stable
>   ethdev: promote device info and dump helpers to stable
>   ethdev: promote speed lanes API to stable
>   ethdev: promote queue helpers and aggregated ports to stable
>   ethdev: promote remaining aged symbols to stable
>   ethdev: promote fast path inline helpers to stable
>   ethdev: promote experimental structures to stable
> 
These can all be merged into a single commit, I think, but agree it's good
to stabilize all these APIs since they've been around a while.

Series-acked-by: Bruce Richardson <bruce.richardson@intel.com>

Once this set is applied (and hopefully pulled to main), that unblocks
merge of [1] which otherwise gives chkincs errors after patch 1.

/Bruce

[1] https://patches.dpdk.org/project/dpdk/list/?series=39206
