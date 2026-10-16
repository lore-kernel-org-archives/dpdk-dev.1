Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C15ECC6B38
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 17:33:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 987F54064F;
	Fri, 16 Oct 2026 19:33:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 64B444026C;
 Fri, 16 Oct 2026 19:33:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792172024; x=1823708024;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=QmheyBQC+DQRoY5Q1ieO0R8vqBEVFIRQhHKC1Jsryhc=;
 b=dE6cZPoUq3WzOcmLVlp4rKEUlaq0nYY8aHUqKHb0cWAot8ONfPOrpmiE
 uU4KfkrUfrvB2DsJ5cxUWjHYvyFHS0BD5qldCPRClcIdrIwd/RL+zMh/X
 e0DuCGb9Hwq270/jkb6GBdDetLHlPn03V5ypa6Ah3raOefElHm9ls45vN
 OIof7AuxL8gh+MM8qoA9eCNvptJtH/BBcl7cxPCXHL+9sW61DVJYb178y
 QFVwb5OGw1IvSxfqAcQMIN3ttcpPKRVjAZ+rb8Es0Xws4jyobmyeljmHt
 owzRURPC164k/ngbKg0fMrRAAZ6+sK338DTAcneBaTko+uc52i9bD1O10 A==;
X-CSE-ConnectionGUID: xps+HqH4Tzqcwa+gg1cIgg==
X-CSE-MsgGUID: kgyTVPVZTQ+IXWJFw/MKkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11937"; a="980113"
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="980113"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 10:33:42 -0700
X-CSE-ConnectionGUID: JCX3zca/Tkmu9pQwJv7Msw==
X-CSE-MsgGUID: B/UnJ0X/Sge21ZATHsJNkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="2061622"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 10:33:42 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 10:33:41 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 16 Oct 2026 10:33:41 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.59) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 10:33:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J3YjiI4+q/RXMZ2V78gzNyUP6ssCR0ur1Gu/nRDmiGcdQIBn3RWPxNArgGUvvRy8oqX/zV3ltiN78BmFSYnT9Cn3rPjQFCIpgPyO3dfyi7Rw5vR7mXlGl56SQtclvWN0d3y9GIwxcohZrNBftOUQUgTfqaW4/1ICrZEX1nJZIxyT73i+DoUeGDJ+GlZ36f6hGG968kn6GA9jNkvcv/0gNdkrnDTH9ZcM6KM875SpzCXNYL9kw/vo++VpxFHKa8peZWrGqU5x8VS5caVNKGiMy7uAiYTVvxWJYUQq9On5TVLztcN7CmYTOpt0Lj5SMork2u76uA24ji4oszhI8buGUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=glaLRIF39uytzkb6keCfZGSWpPJfRh07CV6R7R7uMJc=;
 b=YuDLiO8ed0Rl6BPgTr8XqEtuTEXWRsYpqAAqkPHuc0iYrEoO4THJXFkPPusNnluvbzk8aEA3T7eNaTW0V5UOrhwmvbEe9Uc8flKo0tyDb8XXf8c6I2TOzPIuHbNSJAdoIxPddfdhP5ddDF3toXvl0aLMmTLAJyxZYlBckDUo/o6fGDmS2KNrtUr7Ds/OLTQD3fw248w71MccPzlEqCMDMtPeAC4H5JwqhNPHx0TaUZT8PGoxibL/E0WjmKa1n8zVGTGPyqUiWxcw6ayX2pDoTWIZvCbgD5l/4MLq+Me4ZMp0Wj4fZ0HpmI1QXIDUtitvMXMiAIlfme03oDojGczTFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 17:33:28 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 17:33:28 +0000
Date: Fri, 16 Oct 2026 18:33:22 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH v2] net/intel: fix idpf Tx payload corruption in split
 queue
Message-ID: <atJf4tntpth3DGk1@bricha3-mobl1.ger.corp.intel.com>
References: <20260930044630.250936-1-shaiq.wani@intel.com>
 <20261007104042.1189216-1-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261007104042.1189216-1-shaiq.wani@intel.com>
X-ClientProxiedBy: DUZPR01CA0050.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::20) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|PH0PR11MB5880:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ffb4664-9829-42dd-f2f5-08df2bab96a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|18002099003|22082099003|10067099003|4143699003|261009221727099003|261009223027099003|261009223327099003|261009220027099003|261009221227099003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: p0AQF1GZ+qa0215IjrWaQu91b8TlTHRJmalhsC1ltKqlKsw0Do2+JYBtpq/aM1z9/CVjPg8HZlEW1Y0opyeEQmEGg6Ah6e44+Ek0mw2u9TJLI33VZSmXrpZu+0k3LIOucdi7ggyx/eteDJoDoUvvQ+0HTkHlkAgIQIVJb5n0O2nxtr+IO2Z6CQypU4rq+GbLA09pGPQWCxBipc4h6sv9G3mmBb7UskVk/yw2klL4Ey+hJ4aCtIxBGbnZqeMHsXYP8I6OWXSQP12dnraBOAdTbRpD/zx0hk9IF/VfZqgU5OUZ6eGFnWXDSnibFbpEVSFCkhHZRe/aJLuzGMFvnzi3zntWRFomGDc1+Dl7lMo+26fq2fV8ascHfvKVFAMNeih2YVcjmFXMHM/d6IEEhynP5SgWx59IEN2xXRG9t9LjfW2zzltnItID3gj/P3dW4dIa47xm+FiMuo2WJMJfNzjF0JRP8Qga78TZPFtGuwzQrbz9LLWGE4V2gzIs/MrukR26lLS+avI5FMS34VWlwxGzSHnd19yc4wzmxL/Jgg1VJZRigHIlKoHYJxGdXbemZWaa5bzDHi1z98K+uoSOG3WwJgMoYICd7f+g6T73f6vIR56KIHn+cc6XrNbXQIJ+eKRe6wY1zXAK9lhdEPz4QrWNVuxBLyY2B03nw3KPOtmc6qQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(18002099003)(22082099003)(10067099003)(4143699003)(261009221727099003)(261009223027099003)(261009223327099003)(261009220027099003)(261009221227099003)(5023799004)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FisXfbypj2XwY4GarL7lvt6vo6ciXVqb2dJE4V4xCMZ4MYLDvI4ewuCg6qSU?=
 =?us-ascii?Q?dVIDwMuwsVWgpExYWDh0ijxlxmVm1A7d9ut+TvzqIW7DWgxgs3ETRbV7pTc5?=
 =?us-ascii?Q?qXjg/hep3vK7MVIz4OBWK0OoOJHIkyn4Wupu4EoiIlxzw8qyzcgdacgJ+/8t?=
 =?us-ascii?Q?GUQmgrrySB9WunGYbQrR938VBX+mgud+ayjDFruEVZFVBG8xDLJxINI3vaWC?=
 =?us-ascii?Q?LjUA33wPcPIqJYyfFOf+iD30Kp6QgaiAOH4W2kTB02USEPigDSgoX19HrPYD?=
 =?us-ascii?Q?PYBM/VmL6Gyu6JsRYUsE1vOLLoufzxU5ijCS/Om38JmbvGTRhgda83JvhoVX?=
 =?us-ascii?Q?rZfKjtnN/79DdPKUH9NvOeDHKf/zRC1PTqGrs7l3fKmhIUTwzdCgPI8CWuY0?=
 =?us-ascii?Q?UYoGRuUAPhstWgDFtC55WVfkDKps9/gZ9GeJqC4cg6mG1dyv8qLPghxbokq0?=
 =?us-ascii?Q?qI30kskTukk6doA7X2rq1RxpLDkm94KXffl46l1ufhVatdncNLI2rxrhGaH+?=
 =?us-ascii?Q?P4CpqVvUX0b0Y0vOPbya5V/J4Lo0hC8Ms5DrsaZPe/Z1g9/Wra/K/eM2wWXK?=
 =?us-ascii?Q?GvyH9VBBDpallmD581B/BjGVP7/Wt51UCOOY62hF8BUQirB9t3KyZvQ5JHOQ?=
 =?us-ascii?Q?6hPHlQywunmPSLuGHHH2kkrtlq4yKr/NoyC0ok0yzQ0HP9tPfJQEli/cUXXx?=
 =?us-ascii?Q?gt2BM5xEVsKoCBCRaARPUHePKvVMBmWpdUlWABDM/3KOj89LvMWTFlKXnJz5?=
 =?us-ascii?Q?brK92/lXwBj+3OGZnXGxeqreAHO3RBovkdZIbEvuE9REPeU+0sMqsMPFtChM?=
 =?us-ascii?Q?gCcubo+heMfS/rQ703Vj7LDm8+G+Mzh2kWVGPOB7DBNBvzm979whviJnA4eZ?=
 =?us-ascii?Q?tC6/K8BrdDbxJ5yZWN+blQfwRCxWH21aZE+/dnPQvX1G6DX9Orhy+w8Dk5YP?=
 =?us-ascii?Q?yIlIrE6gt6me6XPwNn4Zpcy9GEubbwbfj3znYolUDWprbr8Yb0ioxJox8wx7?=
 =?us-ascii?Q?x4w2vnjHXVKwoekmC+ItM+Dn/H+PPSdLqg01v9oSNCPGKfzArqGZ/DcyE68C?=
 =?us-ascii?Q?EUtBIuMC2y1mCzEgo6eKbtCoHOeSVaNxjeeI2TVSf1GXYHVBJsQdeI3e9znO?=
 =?us-ascii?Q?qwrCRvMXkssCrHeW8/6NR1Oysh4IkVhoTsDaa2VRi3/c1rKs5FhOj4SME2Lz?=
 =?us-ascii?Q?ObExEGgyRjHKoy0bIbdFlcZhcPU8i9mcpkc7kDtCD9PGRB89IyGs27wyhaTq?=
 =?us-ascii?Q?n29IZr68aUvET3BxRSpBve2WRD6vGuPe/dbcqHc+LnS207JDmAwmsllH4NM1?=
 =?us-ascii?Q?gxzmEWr2ngyDGsY5YUPW46gKsCWVQ4TVoB95ywub3JkedqaV8KhYqHDQzHQQ?=
 =?us-ascii?Q?ehA6NnzwpqJlUXpOkm3pKuKbmfOidGbSrQ4w/aRz0wzMKoI7yOkf8nP02mmC?=
 =?us-ascii?Q?AKFfpoxdqWP6auJHqhC2P8x0+fj9MUNhYrcUHhAhaTSanLtXmbnaXTcPmhkZ?=
 =?us-ascii?Q?GgHbM7qA1zMuTh7d19eSa+uChnzDFfxTfEmrmNc6GqEoQ0h5za+nmyjO4GLm?=
 =?us-ascii?Q?f7iKmZBmOSl08edCruqWZJUwqkn2gvBBAkHzxMhlwC/NMvgWB+bSoncaFuCi?=
 =?us-ascii?Q?fiFaMcK0mLd2CLHFEKKvxQfkoS2Tx+nS0Xdi+q5dUtUIuIbjv+Ki0wP7ywtB?=
 =?us-ascii?Q?TKP8LcY2l+Fr+1nYvzF6xzffRxh8MmYoy3c/r8kFjj36i7I5zyNivQxG3L14?=
 =?us-ascii?Q?jVhjn9XoYSWul+/HKfSYsU0hGHL+KZs=3D?=
X-Exchange-RoutingPolicyChecked: QVp+/YcD/nplIGiuGSNUH2rBPZPkhSL2yQoiC6UUVy8aaT5vXO/PVe+DkLa3QJTSYJbnjyYDWerFhfikmYFxw+lV08IVVSkviH3fTt66PMcVgbD5Glok9P0yz+dGKSYNTuC7kXX0p+tHttq2U7dJ4ShtN6jjw3cx6h4mBJJwmEBOYH3whtwaILYN39M7MccmWhRaA+7EhHYk7ZGano+Mv+PruNdfLnXBQFpAvNa0EYcH6xM4ijHrAQDQh85RB7s/49yqFDlDRfWIr83Hfm3dsCmiKHgWy0VdpeR3DUhwA2LvQt96/5OtwPk2GGlU9y1/ECK5I1joa0nh0gtgyMxA7Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ffb4664-9829-42dd-f2f5-08df2bab96a0
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 17:33:27.9248 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 95p39a69XgIziJYHpLT2UD6XGxSNJYPQCzh5HmMhzdjDUmzBtAyfbMkcwejW2Pb9+bj6xY81015XUQIiKFGAB2NykC/WYTRtK0zE/djZ2OM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5880
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

On Wed, Oct 07, 2026 at 04:10:42PM +0530, Shaiq Wani wrote:
> Observed on ACC while running NVMe traffic tests: under sustained
> high-throughput split-queue Tx, payload bytes on the wire did not
> match what the application submitted, while headers and checksums
> looked valid.
> 
> The RS-completion path was freeing mbufs by walking sw_ring[] slots
> between first_id and the EOP sw_id. sw_ring[] slots get reclaimed
> by RE and reused by subsequent submits well before RS lands, so the
> walker was freeing mbufs still in flight for later packets, whose
> buffers then got recycled and overwritten mid-DMA.
> 
> Fix by tracking completion ownership in a shadow ring indexed by a
> software-defined compl_tag stamped on all data descriptors of the
> packet, as required by the IDPF spec, and echoed back by HW on RS.
> The shadow ring is the sole owner of in-flight mbufs on the scalar
> split-queue path, so sw_ring[].mbuf is no longer written and queue
> stop/release drain only the shadow ring.
> 
> Since RE reclaims descriptors before RS completes, nb_tx_free does
> not bound the number of packets awaiting RS. Size the shadow ring to
> nb_tx_desc and stop transmitting when the next compl_tag slot is
> still occupied, so a pending entry is never overwritten and pending
> completions cannot overflow the completion queue.
> 
> Allocate the shadow ring at queue setup and fail setup on allocation
> error, and free it on all setup error and release paths. Remove the
> now unused ci_tx_entry.first_id field.
> 
> Fixes: 96cc9b6ea60c ("net/idpf: fix multi-segment mbuf leak in split Tx path")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---
> v2:
> Addressed AI review comments, which include:
> * Do not store mbufs in sw_ring[] on the scalar split-queue Tx path;
>   tx_pending_pkts[] is the sole owner, fixing double-free on queue
>   stop/release.
> * Stop Tx when the next compl_tag slot is still pending, so RS
>   entries cannot be overwritten when RE runs ahead of RS.
> * Allocate the shadow ring at queue setup and propagate -ENOMEM.
> * Free the shadow ring on idpf/cpfl setup error paths and in
>   cpfl_tx_queue_release().
> Also aligned with the IDPF spec:
> * Write the same compl_tag to all data descriptors of a packet.
> * Size the shadow ring to nb_tx_desc, so pending completions cannot
>   overflow the 2 * nb_tx_desc completion queue.
> Other:
> * Remove the now unused ci_tx_entry.first_id field.
> * Drop redundant per-descriptor sw_ring[].mbuf = NULL stores.
> 
>  drivers/net/intel/common/tx.h             |   8 +-
>  drivers/net/intel/cpfl/cpfl_rxtx.c        |   6 ++
>  drivers/net/intel/idpf/idpf_common_rxtx.c | 105 ++++++++++++++++------
>  drivers/net/intel/idpf/idpf_common_rxtx.h |   4 +
>  drivers/net/intel/idpf/idpf_rxtx.c        |   5 ++
>  5 files changed, 100 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
> index 2a63cd4330..7c9841a21a 100644
> --- a/drivers/net/intel/common/tx.h
> +++ b/drivers/net/intel/common/tx.h
> @@ -166,7 +166,6 @@ struct ci_tx_queue;
>  struct ci_tx_entry {
>  	struct rte_mbuf *mbuf; /* mbuf associated with TX desc, if any. */
>  	uint16_t next_id; /* Index of next descriptor in ring. */
> -	uint16_t first_id; /* Split-queue: first sw_id of packet at EOP entry. */
>  };
>  
>  /**
> @@ -262,6 +261,13 @@ struct ci_tx_queue {
>  				uint16_t sw_nb_desc;
>  				uint16_t sw_tail;
>  				uint16_t rs_compl_count;
> +				/* Split-Tx completion tracking: shadow ring indexed by a
> +				 * rolling compl_tag decouples RS-completion mbuf lifetime
> +				 * from sw_ring[] slot reuse. Sized nb_tx_desc.
> +				 */
> +				struct rte_mbuf **tx_pending_pkts;
> +				uint16_t tx_pending_size;
> +				uint16_t tx_next_compl_tag;
>  		};
>  	};
>  };

This addition increases the size of the tx_queue struct, affecting all
drivers. I asked AI for some suggestions about this:

---

While the patch is functionally correct, it introduces unnecessary memory overhead, redundant fields, and dead code in the fast path:

A. Avoid the ci_tx_queue Size Increase
1. tx_pending_size is completely redundant: It is always assigned txq->nb_tx_desc at allocation and checked against txq->nb_tx_desc. Since nb_tx_desc is already a member of ci_tx_queue, tx_pending_size can be removed entirely.
2. Reuse existing pointers/padding:
   * In ci_tx_queue, sw_ring is a union:
    union {
        struct ci_tx_entry *sw_ring;
        struct ci_tx_entry_vec *sw_ring_vec;
        struct rte_mbuf **tx_pending_pkts; /* Can be placed here! */
    };

   * tx_next_compl_tag (2 bytes) can fit inside the existing 6-byte hole/padding in the idpf struct (or reuse sw_tail, which was previously the software tail index).
   * This eliminates the 16-byte growth, keeping ci_tx_queue at 144 bytes.

B. Eliminate Redundant Memory Allocation (Saving ~32 KB per Queue)

Currently, in split-queue scalar mode:

* Both sw_ring (sized 2 * nb_desc * sizeof(ci_tx_entry) = 32 KB for 1024 descriptors) and tx_pending_pkts (sized nb_desc * sizeof(struct rte_mbuf *) = 8 KB) are allocated.
* In scalar split-queue Tx, sw_ring[].mbuf is now completely unused.
* Better options:
  - Option 1 (Reuse sw_ring): Since sw_ring is already allocated and each struct ci_tx_entry has an mbuf pointer, store the packet directly in sw_ring[tag].mbuf. This avoids allocating tx_pending_pkts altogether, saves an extra rte_zmalloc_socket call, and avoids adding new fields to ci_tx_queue.
  - Option 2 (Allocate only tx_pending_pkts): In split-queue scalar mode, do not allocate sw_ring at all (or alias it), saving 32 KB per queue.

C. Clean Up Dead Code in the Fast-Path Loop
In idpf_dp_splitq_xmit_pkts, the loop still contains:

	txd = &txr[tx_id];
	txn = &sw_ring[txe->next_id];
	...
	sw_id = txe->next_id;
	txe = txn;
	...
	txq->sw_tail = sw_id;

Because nothing is stored in or read from sw_ring in this path, these operations generate unnecessary cache-line accesses on every descriptor in the burst. Cleaning them up will improve Tx packet burst efficiency.

> diff --git a/drivers/net/intel/cpfl/cpfl_rxtx.c b/drivers/net/intel/cpfl/cpfl_rxtx.c
> index aba3a5e916..0dbe47d336 100644
> --- a/drivers/net/intel/cpfl/cpfl_rxtx.c
> +++ b/drivers/net/intel/cpfl/cpfl_rxtx.c
> @@ -329,6 +329,7 @@ cpfl_tx_queue_release(void *txq)
>  		rte_free(q->complq);
>  	}
>  
> +	idpf_qc_split_tx_pending_free(q);
>  	ci_txq_release_all_mbufs(q, q->use_vec_entry);
>  	rte_free(q->sw_ring);
>  	rte_free(q->rs_last_id);
> @@ -624,6 +625,9 @@ cpfl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
>  		idpf_qc_single_tx_queue_reset(txq);
>  	} else {
>  		txq->desc_ring = mz->addr;
> +		ret = idpf_qc_split_tx_pending_alloc(txq, socket_id);
> +		if (ret != 0)
> +			goto err_pending_alloc;
>  		idpf_qc_split_tx_descq_reset(txq);
>  
>  		/* Setup tx completion queue if split model */
> @@ -642,6 +646,8 @@ cpfl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
>  	return 0;
>  
>  err_complq_setup:
> +	idpf_qc_split_tx_pending_free(txq);
> +err_pending_alloc:
>  	rte_free(txq->rs_last_id);
>  err_rs_last_id_alloc:
>  	rte_free(txq->sw_ring);
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
> index 649b5d1f99..e54056b5c0 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx.c
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
> @@ -233,6 +233,51 @@ idpf_qc_split_tx_descq_reset(struct ci_tx_queue *txq)
>  	txq->rs_compl_count = 0;
>  	txq->tx_next_dd = txq->tx_rs_thresh - 1;
>  	txq->tx_next_rs = txq->tx_rs_thresh - 1;
> +
> +	if (txq->tx_pending_pkts != NULL) {
> +		for (i = 0; i < txq->tx_pending_size; i++) {
> +			if (txq->tx_pending_pkts[i] != NULL) {
> +				rte_pktmbuf_free(txq->tx_pending_pkts[i]);
> +				txq->tx_pending_pkts[i] = NULL;
> +			}
> +		}
> +	}
> +	txq->tx_next_compl_tag = 0;
> +}
> +
> +RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_split_tx_pending_alloc)
> +int
> +idpf_qc_split_tx_pending_alloc(struct ci_tx_queue *txq, unsigned int socket_id)
> +{
> +	/* Bounding pending RS to nb_tx_desc keeps the 2 * nb_tx_desc complq from overflowing. */
> +	txq->tx_pending_pkts = rte_zmalloc_socket("idpf_tx_pending",
> +			sizeof(struct rte_mbuf *) * txq->nb_tx_desc,
> +			RTE_CACHE_LINE_SIZE, socket_id);
> +	if (txq->tx_pending_pkts == NULL) {
> +		DRV_LOG(ERR, "Failed to alloc idpf tx_pending shadow ring");
> +		return -ENOMEM;
> +	}
> +	txq->tx_pending_size = txq->nb_tx_desc;
> +	txq->tx_next_compl_tag = 0;
> +
> +	return 0;
> +}
> +
> +RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_split_tx_pending_free)
> +void
> +idpf_qc_split_tx_pending_free(struct ci_tx_queue *txq)
> +{
> +	uint32_t i;
> +
> +	if (txq->tx_pending_pkts == NULL)
> +		return;
> +
> +	for (i = 0; i < txq->tx_pending_size; i++) {
> +		if (txq->tx_pending_pkts[i] != NULL)
> +			rte_pktmbuf_free(txq->tx_pending_pkts[i]);
> +	}
> +	rte_free(txq->tx_pending_pkts);
> +	txq->tx_pending_pkts = NULL;
>  }
>  
>  RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_split_tx_complq_reset)
> @@ -387,6 +432,7 @@ idpf_qc_tx_queue_release(void *txq)
>  		rte_free(q->complq);
>  	}
>  
> +	idpf_qc_split_tx_pending_free(q);
>  	ci_txq_release_all_mbufs(q, false);
>  	rte_free(q->rs_last_id);
>  	rte_free(q->sw_ring);
> @@ -787,7 +833,6 @@ idpf_split_tx_free(struct idpf_complq *cq)
>  	volatile struct idpf_splitq_tx_compl_desc *compl_ring = cq->compl_ring;
>  	volatile struct idpf_splitq_tx_compl_desc *txd;
>  	uint16_t next = cq->tx_tail;
> -	struct ci_tx_entry *txe;
>  	struct ci_tx_queue *txq;
>  	uint16_t gen, qid, q_head;
>  	uint16_t nb_desc_clean;
> @@ -824,26 +869,21 @@ idpf_split_tx_free(struct idpf_complq *cq)
>  		txq->nb_tx_free += nb_desc_clean;
>  		txq->last_desc_cleaned = q_head;
>  		break;
> -	case IDPF_TXD_COMPLT_RS:
> -		/* Walk from first segment to EOP, freeing each segment. */
> -		txe = &txq->sw_ring[q_head];
> -		if (txe->mbuf != NULL) {
> -			uint16_t first = txe->first_id;
> -			uint16_t idx = first;
> -			uint16_t end = (q_head + 1 == txq->sw_nb_desc) ?
> -					0 : q_head + 1;
> -
> -			do {
> -				txe = &txq->sw_ring[idx];
> -				if (txe->mbuf != NULL) {
> -					rte_pktmbuf_free_seg(txe->mbuf);
> -					txe->mbuf = NULL;
> -				}
> -				idx = (idx + 1 == txq->sw_nb_desc) ?
> -					0 : idx + 1;
> -			} while (idx != end);
> +	case IDPF_TXD_COMPLT_RS: {
> +		/* Shadow ring indexed by the software-defined compl_tag is
> +		 * the sole source of truth for RS-time mbuf ownership; free
> +		 * the whole multi-seg chain via mbuf->next in one call.
> +		 */
> +		uint16_t tag = q_head;
> +
> +		if (unlikely(tag >= txq->tx_pending_size)) {
> +			TX_LOG(ERR, "invalid completion tag %u.", tag);
> +		} else if (txq->tx_pending_pkts[tag] != NULL) {
> +			rte_pktmbuf_free(txq->tx_pending_pkts[tag]);
> +			txq->tx_pending_pkts[tag] = NULL;
>  		}
>  		break;
> +	}
>  	default:
>  		TX_LOG(ERR, "unknown completion type.");
>  		return;
> @@ -976,6 +1016,19 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
>  		if (txq->nb_tx_free < nb_used)
>  			break;
>  
> +		/* RE reclaims descriptors before RS, so tag occupancy is the
> +		 * only bound on packets awaiting RS completion.
> +		 */
> +		uint16_t tag = txq->tx_next_compl_tag;
> +
> +		if (unlikely(txq->tx_pending_pkts[tag] != NULL)) {
> +			nb_to_clean = 2 * txq->tx_rs_thresh;
> +			while (nb_to_clean--)
> +				idpf_split_tx_free(txq->complq);
> +			if (txq->tx_pending_pkts[tag] != NULL)
> +				break;
> +		}
> +
>  		if (ol_flags & CI_TX_CKSUM_OFFLOAD_MASK)
>  			cmd_dtype = IDPF_TXD_FLEX_FLOW_CMD_CS_EN;
>  
> @@ -991,8 +1044,6 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
>  				tx_id = 0;
>  		}
>  
> -		uint16_t first_sw_id = sw_id;
> -
>  		do {
>  			uint16_t slen = tx_pkt->data_len;
>  			rte_iova_t buf_dma_addr = rte_mbuf_data_iova(tx_pkt);
> @@ -1004,13 +1055,12 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
>  					unlikely(slen > CI_MAX_DATA_PER_TXD)) {
>  				txd = &txr[tx_id];
>  				txn = &sw_ring[txe->next_id];
> -				txe->mbuf = NULL;
>  
>  				txd->buf_addr = rte_cpu_to_le_64(buf_dma_addr);
>  				txd->qw1.cmd_dtype = cmd_dtype |
>  					IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE;
>  				txd->qw1.rxr_bufsize = CI_MAX_DATA_PER_TXD;
> -				txd->qw1.compl_tag = sw_id;
> +				txd->qw1.compl_tag = tag;
>  
>  				buf_dma_addr += CI_MAX_DATA_PER_TXD;
>  				slen -= CI_MAX_DATA_PER_TXD;
> @@ -1024,14 +1074,14 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
>  
>  			txd = &txr[tx_id];
>  			txn = &sw_ring[txe->next_id];
> -			txe->mbuf = tx_pkt;
>  
>  			/* Setup TX descriptor */
>  			txd->buf_addr = rte_cpu_to_le_64(buf_dma_addr);
>  			txd->qw1.cmd_dtype = cmd_dtype |
>  				IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE;
>  			txd->qw1.rxr_bufsize = slen;
> -			txd->qw1.compl_tag = sw_id;
> +			/* Spec: COMPLETION_TAG must be identical on all data descs of a packet. */
> +			txd->qw1.compl_tag = tag;
>  			tx_id++;
>  			if (tx_id == txq->nb_tx_desc)
>  				tx_id = 0;
> @@ -1043,8 +1093,9 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
>  		/* fill the last descriptor with End of Packet (EOP) bit */
>  		txd->qw1.cmd_dtype |= IDPF_TXD_FLEX_FLOW_CMD_EOP;
>  
> -		/* Record first sw_id at EOP so completion can walk forward. */
> -		sw_ring[txd->qw1.compl_tag].first_id = first_sw_id;
> +		txq->tx_pending_pkts[tag] = tx_pkts[nb_tx];
> +		if (++txq->tx_next_compl_tag == txq->tx_pending_size)
> +			txq->tx_next_compl_tag = 0;
>  
>  		txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_used);
>  		txq->rs_compl_count += nb_used;
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.h b/drivers/net/intel/idpf/idpf_common_rxtx.h
> index b2d33287df..3365631d80 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx.h
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx.h
> @@ -216,6 +216,10 @@ void idpf_qc_single_rx_queue_reset(struct idpf_rx_queue *rxq);
>  __rte_internal
>  void idpf_qc_split_tx_descq_reset(struct ci_tx_queue *txq);
>  __rte_internal
> +int idpf_qc_split_tx_pending_alloc(struct ci_tx_queue *txq, unsigned int socket_id);
> +__rte_internal
> +void idpf_qc_split_tx_pending_free(struct ci_tx_queue *txq);
> +__rte_internal
>  void idpf_qc_split_tx_complq_reset(struct idpf_complq *cq);
>  __rte_internal
>  void idpf_splitq_rearm_common(struct idpf_rx_queue *rx_bufq);
> diff --git a/drivers/net/intel/idpf/idpf_rxtx.c b/drivers/net/intel/idpf/idpf_rxtx.c
> index 077a92a8a9..0d41cd87eb 100644
> --- a/drivers/net/intel/idpf/idpf_rxtx.c
> +++ b/drivers/net/intel/idpf/idpf_rxtx.c
> @@ -495,6 +495,9 @@ idpf_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
>  		idpf_qc_single_tx_queue_reset(txq);
>  	} else {
>  		txq->desc_ring = mz->addr;
> +		ret = idpf_qc_split_tx_pending_alloc(txq, socket_id);
> +		if (ret != 0)
> +			goto err_pending_alloc;
>  		idpf_qc_split_tx_descq_reset(txq);
>  
>  		/* Setup tx completion queue if split model */
> @@ -512,6 +515,8 @@ idpf_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
>  	return 0;
>  
>  err_complq_setup:
> +	idpf_qc_split_tx_pending_free(txq);
> +err_pending_alloc:
>  	rte_free(txq->rs_last_id);
>  err_rs_last_id_alloc:
>  	rte_free(txq->sw_ring);
> -- 
> 2.34.1
> 
