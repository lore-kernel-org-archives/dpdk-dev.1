Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489D7606AAD2
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 15:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LSFM46r9
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 900134064F;
	Mon, 19 Oct 2026 17:52:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 38ABD40298
 for <dev@dpdk.org>; Mon, 19 Oct 2026 17:52:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792425150; x=1823961150;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=fQQ1A1P7+f3D7Tx2T6EYh3f1UESNzSX9D05Zu2rtb6E=;
 b=LSFM46r9NjVDzrwFprpZ1xakzSaQ4ItiKBzMK9ursHTBoZVRrUC4/sbQ
 wn8sLLJbvk5jPSgtNkCZLoz1mpDMOo3otcXPEv9sz/VVKIOfW7FrcWRms
 0LbuSxI2fh6kEA5iqUYv9okJc2EJWhVaZl5B32u3CSV9GIm5iOW5XeV1C
 rVrZdqlCxBYGyRKjDjwn6sLIqwIm2HEJsOQrV4h7Yj1cSjfPA/CjfYak3
 Y2DMlLjSr8md19vLVIQtrjBuR6iKyLk+tcWQWzj4HZzi2GswisJCHT5Yl
 s/6eKp0JAl7XS6wchkxC3F8fqHvUq3tlV40KrBbhoQDjQA8+F5DAL98K3 Q==;
X-CSE-ConnectionGUID: shVLJ5VkR5q2Gqo3Wo7DXg==
X-CSE-MsgGUID: 6xZ45r0sT/mvG9oHlBl3Lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1016840"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1016840"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 08:52:29 -0700
X-CSE-ConnectionGUID: DJIe/IRsS96EH2HBHoADCQ==
X-CSE-MsgGUID: P8BdYXdASBO50IUgpfWwNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2567976"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 08:52:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 08:52:27 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 08:52:27 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.21) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 08:52:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a125J/DEyHLDp7TGSkKvMFVc3yNzXwwKDpciLKW1jksUNeM+zuKe7H+A5KIcudW4cV3lRkptuUs4+YK8Gtx1IhSNh2aSxnQE/Yix7o436XO8lDOeMs+Gt1xwPFkLBRxmk7iV7yEfvmQ/BFngnU8feJPGaDDNAgMuyOS3MemDQ2SzRd82flh5tZ96pGkRLynH+3NsmejnSxmcuPwFH8eoLssM1XyYprQMMbk2W2Y+1h05uMiri84krpzfqF1MIswdRxlsIVTv8p3mLIoQawX1i/ibnbvI94uI2JAaK+QwJ8w6z9PUxHoAEJxt7JHH7af9Petu3VN1X78DhOSv9U9Qmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XP9NpBGOwjWScMnmM/KY/V+AeFuzap0cTwnBPK2hb/8=;
 b=WQ4jgxX9sTSX3+c7180DKeBx5wjX4bQhcLtAkg8YsnmeoAGWfgzgRNu0up2ySUVwYNaAhpUEvyoe5rgBHZNdvZwWRauu8EIxUpp49kMwdCYk35DwKg0hq6c0gahLI9H02UiMDMiDINcVZ0bdexUIMS41KgHJDW1oBobY+AiL6jaBG2xlnupyAEJ8Ge6zGqA2o/d7rpVR55+op5SRnY61pCXIxWS3UxYo/PGxXxfsYCn1nEeVJ2HU+SNeRCmDaB/0ijqH8vr+iCD29hX5w5rrn66VbiubxMmOEdTdCBxJF0KP6P+Fo12dwEp1yhiPNZwFrYJbJXr1V1dlSFO5Ssz6aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by PH8PR11MB9805.namprd11.prod.outlook.com (2603:10b6:510:3c2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Mon, 19 Oct
 2026 15:52:25 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 15:52:25 +0000
Date: Mon, 19 Oct 2026 16:52:19 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] net/i40e: enable vector Rx with IEEE1588 timestamping
Message-ID: <atY8s6shsqxA2YZl@bricha3-mobl1.ger.corp.intel.com>
References: <20261009053449.843546-1-anurag.mandal@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261009053449.843546-1-anurag.mandal@intel.com>
X-ClientProxiedBy: DUZPR01CA0224.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::20) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|PH8PR11MB9805:EE_
X-MS-Office365-Filtering-Correlation-Id: 806e63ef-ba14-43d6-c788-08df2df8f84b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|22082099003|10067099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: QZWj/q8wjIUWD9ixD2H2ZpD5Qb36Ebyn/qD2CssNojs8EUzShmCe3uOC3sAYJElTcmvRLmcLzNARHyAcGjz5eidC1UNtAEe7RbdmFLWCVy+lMYa6pc9tYXUeCum0q5HjJ7M+vONwI5qySRg9Oqq2W5oUgRm/1i2nMKjY+kc96E//cWMlyngR+qDwJbZLZYanFJsxgA606lJG+45gmi6CcGBuLnXlTd9LlwPOurjs4tsWXlELAaUPZaB6OsOUKlkQYbymyEHGKHc+n/MIPEsxV9wboqhafAuliUM+cm6G1D5J453Z2QcMFGASxzS2Ln/nCHcQVxmycjAa9drPyxx6ZUqNf8zGJdb47ElTGpG6KfwUZHcTQJSgppnALZCG6yGI5T3W6z/zK8PDvwHATzEzUkbcxvLU17pRSo7xHBJL0D73SE33RidlxhLgJE8wEZzAMeND9ZBdOQnsvvZ6HCqJIUj30YAF9QYbzxi30JdYdC7Mwae46WsoMwdXNEic02X8rbC5iGpiVT7BnVJ+TGN6JDU3UcducJkiRas/f6bgpbgso3pHcE5QlNm2Sbg/755oWa4aTQaMvIHgV+hjbWT/KbowxO/BfsrilMzFbPXOoUMjsbg3zaF2dO4SyHv3X+Vm68O9r3BRFKGdlA0zA1kjU9S0HxCp/j5ZxOkrmTx58qI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(10067099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FXb9SJCpnGmRbkeNSUgmAvQUq2RBTEMKDVqLG2Fp1miMo6FQmkBmbqfTHGQL?=
 =?us-ascii?Q?5qr9kCfOxHfN22QD2Vz4NpRlqfgHGVQ95BLeZRoixhnSYDu4Kpkpk3WUHYZi?=
 =?us-ascii?Q?v0p8wMWWm98Zo4QTcIfXlHCaSGNa2KD8vIWCff2CIK32d9NBsCPEfhkoJZxU?=
 =?us-ascii?Q?eb9oNJKaODtLx44cZhCIP922mI2uYdT2F/tY/iQq0uU9kMVHQZcMl393qxvs?=
 =?us-ascii?Q?rTlzDnrnlHlO5mHpmAc5oI5l63mShEBnAkiT+aWDw9fgNHQryN4VPRBNykmx?=
 =?us-ascii?Q?QZOCtdH1mrjbMjNPpNv4jnbrfy6IuLh6ZLEEVQ1ckwFdhBjHdpzHg3z2QIDF?=
 =?us-ascii?Q?eGwEo2/d3TpqT5yMn5ts5oz1lnh6f0L/QmIA9fW2bNfQQpBN8n1VUY7FHtzr?=
 =?us-ascii?Q?kZ5uDiHvVqFqtQWoVTyxR/NzajwXVKVElpelQNV/tkZRT6gN3r++EveBts6o?=
 =?us-ascii?Q?LY+XucrOnIb2GyUE/QNRF4QXRuxDLBtYyFIEr2t1pNUgpWuz0pi0Ode8H2ho?=
 =?us-ascii?Q?FbIsExJcfFvWqS5TYqXH09YExhgI41cgZxJwLC93D2ih2xAjyVmtmMts91xL?=
 =?us-ascii?Q?n2okkqUO93YIY5X5//ElOwo7XZT01LaiGCh8rvIMxzsOP4MpUmecCL+hvspe?=
 =?us-ascii?Q?QyffZcS/nkwAR8+4hZzrToRgyP4pJnaavHDPidLYQUVLgRA5wzPzGTUwDYvP?=
 =?us-ascii?Q?jNrP6uZGRW37NS1TSBC5vPOgR68DGzPugDA53Ks3qWhOe9EhI3a2THnuNQop?=
 =?us-ascii?Q?Yhmp8z1LJBP1pmzxf7q11nlyS3QhvJfkdXgVShM+fAAKBfmD6rlyx10d26i1?=
 =?us-ascii?Q?3boK8E9hUAqOFJHCOJ3y3XeiF0S82HAOXVRkPDU6uxy2hIrdx9qNYj5xMREz?=
 =?us-ascii?Q?HzhprkyB4mPp1Pd6IUMeCsLqY+FT98h9MF7S9RlJEV8INo6geJy6f8eQg+BE?=
 =?us-ascii?Q?M8vR46eLSgrUhjDvAOiUs/QPWzx4RkUjF2h4Io5ZdyS4S7dHS0B+XcL6OoYQ?=
 =?us-ascii?Q?pJwIWz9g9njS0IWqWQ4TILGsCltg5J/XhQuIoZpuBCnW3qt6BMmucFsjSwow?=
 =?us-ascii?Q?m6FSt/croY2p+iq/mNfTnHqCizuZQo+Zf19mQ7C9X85z7vrB/AXegYd2Y/TO?=
 =?us-ascii?Q?xZBD3jlsdQi4//PRNYbO4lrAcdqSb+V2CSA4fPcl9h9qiyKLuHWZFUmsWI21?=
 =?us-ascii?Q?iqHDL2TvGiFMxLMKLPZxe5SskbPf6O0ZuEEDAPKbm47l+bpnodlpL2OuWY7q?=
 =?us-ascii?Q?0Qf9xbwbJ9jA8Zzml8827M2pkifM4fNS3pt5DJFZn64h2vMOk+YkIhfQF1+o?=
 =?us-ascii?Q?ZUp5f4uVVI1rz7nE+fyKIjJ/vD9NauGE3iFzmAjQLCg7bhwJB/InpcHWUW2c?=
 =?us-ascii?Q?Ro6OrtGz86pX9UwY2pU0dA21U5BdW7c1yw3ZdHZeaGcW9abclCemc5S8NFj2?=
 =?us-ascii?Q?xe3BxqLTpUmJjObYlXqefQsyH8LwAVGr1qtdaK7rkUIAG0kyfo8FYB2nI7tq?=
 =?us-ascii?Q?YJoxSjbCKFs4pOHpk57CXCwv2UOQTtGeozMzfIRA9Kxs/wmCAPuTFM4fgs3n?=
 =?us-ascii?Q?T0ZVSW4WaR3pN1r8eIZ/hiHHwSJLbIFz8OxN9nZOlHC44TMgnOuEE0scoueT?=
 =?us-ascii?Q?IUz5ki38maLmGjqHa9CoWglbjeE8xKqyY1b51/8kJrhvXeB4x6puoQwHHsM6?=
 =?us-ascii?Q?AApVZRfQIXA/g1g+K7rtGtvLjlD377/cLUPGJbKQ9GBcpbimeSmYnCNRftE4?=
 =?us-ascii?Q?56pgoijooEl5xGNwuM/WmP56o6d6tXw=3D?=
X-Exchange-RoutingPolicyChecked: AiN47NiaBSceuWH7scusks1BLTKIJHaRB0j8QR0vj+tdGrKhtjhee6j5yncqlBMEOccoT3j5UKxGEm4lDa63BrGkcSZMcGhEt2n7yf3yyg10rx7m+U/BCMG2YKoehcTEmSy74DcuJt3TypNvDNmTvzBCCy/t87F7yx0+OJaZDO05OGNn6F+w1ensTk55brsfIiojZQNOl9YG4Js35f0U3dBYpYX4rIq+vCP1+Xk8G/enjJqvbIbfbJifwhf9rIXKssbYSayB94auHtSnbHGd8MhIDw/9Wb4pC8NsrAunO1ssMkQ2Xl1m/mn4wLC4o+IfCConV2xHy5S+G18aHfJQ3g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 806e63ef-ba14-43d6-c788-08df2df8f84b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 15:52:25.4047 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EtIDwdtGzfSEPcnSzXkf3RLz7U8l5uFdqQivS+zqwpKvEW9UlAaWGT2uhqZbXRqJDY1t4FVgAjDFEEVnUgbU+L07V3wWtnKPoMIheFaEAno=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9805
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 09, 2026 at 05:34:49AM +0000, Anurag Mandal wrote:
> Enabling IEEE1588 support at build time forced all ports to fall back
> to the scalar Rx path, as the vector paths did not propagate either
> the PTP flags or the hardware timestamp register index.
> As a result, applications incurred the performance cost of scalar Rx
> on all traffic, even when packet timestamping was never enabled
> at runtime.
> 
> The hardware does not embed timestamps in Rx descriptors.
> Instead, it latches each timestamp into one of four dedicated
> registers and reports only a validity bit along with a 2-bit
> register index.
> Propagating these to the mbuf requires a per-packet store
> that SIMD cannot accelerate.
> 

The store to the mbuf does require an extra store in the vector path, but,
on the other hand, the actual flag processing and the extraction of the
register index can all be done using vector code without additional loads.
This is because the timesync flags are in the same status block in the
descriptor as the RSS/DD/EOP bits. I'll work with AI to put together a
prototype native AVX2 implementation of this and reply in this thread with
the patch for you to test and review.

/Bruce

> To remove this limitation, the vector Rx paths now perform a
> lightweight scalar pass over the descriptors consumed in each
> burst, populating the same PTP flags and timestamp register
> index as the scalar implementation.
> The timestamp decoding logic is shared between the scalar and
> vector paths to ensure consistent behavior.
> 
> Applications requiring PTP hardware timestamping therefore no
> longer need to choose between hardware timestamp support and
> vector Rx throughput.
> 
> Scattered Rx reassembly already propagated the offload flags from the
> last segment to the head mbuf, but it did not propagate the timestamp
> register index.
> Consequently, a segmented PTP packet could carry a valid timestamp flag
> while retaining a stale register index.
> The reassembly path now propagates the timestamp index as well, ensuring
> consistent metadata for multi-segment packets.
> 
> Tx path selection remains unchanged, and builds without IEEE1588 support
> are unaffected.
> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
<snip>
