Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2458CDB479
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 15:58:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 097024068A;
	Thu, 25 Jun 2026 17:58:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 7323440616;
 Thu, 25 Jun 2026 17:58:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782403096; x=1813939096;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=iCzVeQsNmp0WWdGy+k8Pk3r4zyQ6/eU/v4UQ9wueHcA=;
 b=Dj6JBlAlPvWYHixXZw4wsZMZ9DKS9bkNyoiNKsfjLIuLMal4n+yQjzh3
 Jg5kVdnOLcGWhq4uPAaWTpM4Xgf9ukRr2BZ4+NKHGFwj+KxhqhKtv0wCn
 N1oUakopFKPL+2pPedrkMFzotRofJyR79XTFFsf8DHkHa5Vw+sM5ljMg/
 Cd6bOH9Pei8axBeBhDCpypa5EDNwXv8pnL+ynJK0i3gcQHMwC73Y6IzHu
 CnOsoggMtpNhs1j4LdZLnZf6b/KCe758Z0WXNUGtSKvieTSIQNWugYzl7
 vKkf+t/Q34aXDQIU9+di2EHN9QQBgSCXh8SG4OyfyGSzSkAVWGAxVvEK2 A==;
X-CSE-ConnectionGUID: NrnCY1pKSdS1fwWCWKZibw==
X-CSE-MsgGUID: kknvCxZgRvaRiGNVB/WGBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="100609518"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="100609518"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 08:58:15 -0700
X-CSE-ConnectionGUID: Un/ftCTfSbG5tYxno2HE0A==
X-CSE-MsgGUID: ukilVUmdSoaEK+gEaREOVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="246436226"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 08:58:14 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 08:58:14 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 25 Jun 2026 08:58:14 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.20) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 08:58:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aKMV8JKSNM6/wmYhziYRUy2OeHoEH7FlUUAAauVdcHQV+A4w6zayfwK2ZHu5UOsxwQl6X87eRLPc/LQxHJouXuXVZ8N+g9nHCnTZ/3WEtNCJCUo7b0lTHzh80W0sxain7PVGIDE/SQhh8/zuoW0GCzRPv+mL2ojQ5MeT2RJHM+EIKzcGKcE26gH2ZpTo9+z+zTiVcgXsg2dTzNlzAUGPx1UUGD/fbtEiZRei/5fBD3ENtF+ZqjfrzIqVsjgLm/0Rcc11GtgAdcpTmYQhWHG9nBxZAgf5MW7oBlNsCYF6qg63XRVwnRSOu3fcdbwQFvxuYPXWkKqbWB2vWltTiE/Jmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fDEUWmAVZM5fTPQVo6Vpzg8uySTXIYYQw/FhgW0ZuI=;
 b=I5s/lus8s84tXdCjIXO4S6a7TO9n58xPqjqycm5QvomthIjOlvrREjFkFSFuMGedTlEnXKNvQSKxW+AmWgDUhbG2LHMQL7TtY6F94V3ZiyKtT+NLHpFrG9dI2ACuRqgyDgCv/Cq+7wysGtYsk0qQqBYMK9JUAz+6drCrdtWDvcnc9j2oQy9l/ZtizQucoPGvS7XLpHbSNKyDXEyaSAv5FNRlF31fK6NBkZQYL365wCPlpOLA/k1ppnWARcdVViYco2vznQPiTNkVV0Ha1eanKaPpQzUwwTYSMmJfxAOh2p7U9ZzGNgeVAPpEUZldy9RdTtZCI1E9AhbPusKFgFqyhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ5PPFED9C9AC99.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::85d) by BY1PR11MB8030.namprd11.prod.outlook.com
 (2603:10b6:a03:522::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 15:58:09 +0000
Received: from SJ5PPFED9C9AC99.namprd11.prod.outlook.com
 ([fe80::2271:3ab6:e9cf:4ba2]) by SJ5PPFED9C9AC99.namprd11.prod.outlook.com
 ([fe80::2271:3ab6:e9cf:4ba2%8]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 15:58:09 +0000
Date: Thu, 25 Jun 2026 16:57:50 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH 2/3] net/ice: fix DCF Rx packets statistics underflow
Message-ID: <aj1P_hyRxOfoYwqZ@bricha3-mobl1.ger.corp.intel.com>
References: <20260625093619.726471-1-ciara.loftus@intel.com>
 <20260625093619.726471-3-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260625093619.726471-3-ciara.loftus@intel.com>
X-ClientProxiedBy: DU2PR04CA0210.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::35) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPFED9C9AC99:EE_|BY1PR11MB8030:EE_
X-MS-Office365-Filtering-Correlation-Id: 0146d9c0-d5b8-4ea9-ddb9-08ded2d28571
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|4143699003|6133799003|3023799007|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 1MQlHs8Me6+m9ZoEEVXKN/caObD8tC/2ClDiU0ajkQ6aUsrofEnAFkeDKrDOxNUSaWHh13XZxN4stcjPwYwT7J7ZaM/yQd9nsS/YopPDv0YJ361JSknDPf0OTrAgN3+VEvO2eC/deYYeAlcPG6d15nLfYRcZ4wGklYcEOKleNLUu+5BcwBc5WjbG/zHckxruGbkMe0B4m3nP2KIs2vLIV10EVsRYj5YJD6aBMxeE9Wg3y7jVFzV3xH2ayNXY2sFr3WnS07JRwwe4X7nMzvcBdADV2nQ8rpt4VRScAv1ANj/oy1m19n1cdUTpPryb6mg6j9ncMuKOr7sP9VunBDrZeVRSJLtIb1aDb6mR5EgAz7FRYOzzS/dN0Z7R+hQ+0D1pGWN6oWq94ZZ6n2QikXciggnSwoRuBMeS9BOb5qQh0oTAdt114F9CCe/MUFxRVURwxZPojoHXpxK+cIAKqprzvvQedEKQqRJvHX5PRBEKnchcSUiL4KFPdtevHGCeoVxWZ+gIwjF0wu9e5ULE0y/nG0eyYm4YlZkBWVPtXwQiok7ezrErpsoj/3cKRZZtVj2i76XbqXY1n1kFXW3PoB7sPHzizaWi+nPZcOKTIi9oF6FLnsFo04Y3mJ9c9L36u5+YF1/em7zszx4Ai20OtyNZ/Nujou26FKHZh+90wHArKWU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ5PPFED9C9AC99.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(4143699003)(6133799003)(3023799007)(5023799004)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1J89IfRAwiUFaLcziKcyrw54Lm9AMNsvSixmIJfXE5/OiZQwK3do8OQWoiiR?=
 =?us-ascii?Q?R7mLqZRLOjJNezAG37nS5dRr22p6mgwpzT9L8Sekdtsy+JzBvONciRh0wPQX?=
 =?us-ascii?Q?Cm1yL2gSckMPPsA+7s7nh7fGP3B+X4khrfeaFdnc7oAIxOkW52jb0MXpgbg8?=
 =?us-ascii?Q?X/5PgDVzglJ/MwVSPHkbNoPBPd8lpi+SkIVLhxZ7KetpdKnDH2diLURprGpI?=
 =?us-ascii?Q?Csdj1rITGYIL8mGrxwkqn1oOPrvOPnP12p6Pe+p9o5RUyQRT1dIl/XQ9x249?=
 =?us-ascii?Q?SYOVZ4qBBW7C+W42sStkscDBM5hPIlTeMLE3WhdMwZQXufkPdOEt9FuPpQ0w?=
 =?us-ascii?Q?buyMna+Wk2lz7ITwZQJgi5fSDI0Vu+myOfgFKBgMawGZqMemCguTMB09LnSG?=
 =?us-ascii?Q?NrJ7VT5EesTIN4OkF2FaAagP7qe2wfz5sj0DAo0HS6jUsLLp0mXr1GHAk8Kn?=
 =?us-ascii?Q?CMZ8LtUzMvUOTRv6LleKT2HeKRFz2g5VL5KPgKAU6zUuxcNospPzCt+Sh0hV?=
 =?us-ascii?Q?w8rWQzbNzogWvC6F67MOATEFvbNDbzBqjCX0HnWUEVTuT3Eroq3XTQ90CEha?=
 =?us-ascii?Q?AaJuR3vqOFZABagELHIH+JmwKU751oFaxkKKRFyrnhxoL/+GcDVm/VhM4BVB?=
 =?us-ascii?Q?HzrylypA1auKNylcrnB+HyejkvGw09pMasCrX/wi6YzFTIutbhUdnKpNnkAQ?=
 =?us-ascii?Q?kdAuALOepgi7UlqwD0vnV3SV0uSj9QRhP28SVyquF7Wi27ZR1S1XwZ3HSqwy?=
 =?us-ascii?Q?iOnjQLaXBC9QwPvvC/4bhjQ6fqndLJhoLqWtCyUgtod0TUYIeB4259YaTTO9?=
 =?us-ascii?Q?zAx6kNKE/IDa7mFzmdlioYYjD60fPMkLdgmfYhwYFRPgFc2amEqKYqlYOo/p?=
 =?us-ascii?Q?aKvZmWv0W+SmW4+RshrPtFGOzLS8R2/hcWKsflEWeh29W8N6PnYmMncJfneQ?=
 =?us-ascii?Q?yz4nLulAZ0bOu8S0+oB5WpxZMrUUGaBYp7l2CJj3DGvPc3ANL1TNHp3/6DhR?=
 =?us-ascii?Q?SsjivxJYgzbPB4Orrg2kNjD7piL7dMtShsE8+Qt5mXv2z5R3DQFZ7Xug3rV1?=
 =?us-ascii?Q?iTla1yWPjjnV7+Jd4JakbKVS5NhQgU9lJ/v1539/n53GXJXX7n2nSahgRHpN?=
 =?us-ascii?Q?pLwba0ZXg5UdJbDNSTkNf4/rAfxwaNSVPj4bP0dzAnJhoSbjymD3Nc7UVpZ4?=
 =?us-ascii?Q?h9fzJ6PaGeV1ky6qGRuFplObzU8s5ngWGesRfjtmzBBlbrvcVm6RuzEytNA+?=
 =?us-ascii?Q?0rUe5lGX3CZAHmONI5WpuW1T87iZhalBkzxCs2c9XS3zAPDcJPhV3o9bTHw0?=
 =?us-ascii?Q?MSED/um4qum47FsbiJXqUKEap8BXuSdghPD/xTvSA/jYEgh/jOdbY9yj6mm0?=
 =?us-ascii?Q?i5fJrbQ5XH6Fj341RuaNir1XgUtrmA6XBLHXm67+risfZMlUy2EH6gvcyBsF?=
 =?us-ascii?Q?bqPKWANwP99+bW98Wdjw29V+xL3AOg5HCRON1bgn9nrjqdcO87ZxQR8anPiN?=
 =?us-ascii?Q?2NSqUmtoKX6BbyYW0oKsHDBpRj9aMPXdaGYn8oIBjDRk/2jFe+AKqidmmVm/?=
 =?us-ascii?Q?zSsTZYGC0eHVh7UpkBHHiUsTECQrCGHGLRLcb9v53GihPzUE/eqcL9yldqOM?=
 =?us-ascii?Q?ZvAMTozCXc1JSJZQA/vWTt74CVHknaZFOD4ZCg2xInwHb1s+Z/TDUSXTQoYR?=
 =?us-ascii?Q?yCbM80KUuHDFuUukI0bJC7I9mM4s19cQJv5rXHjZBa5V6+BfGl3WWeDPVJ9C?=
 =?us-ascii?Q?QdZ2LEj1JG/8reqqdjDUcnQqttmw8Ek=3D?=
X-Exchange-RoutingPolicyChecked: b+1SfC98om3Rj1DHBAMjvSni2wgNT1nwYmCQHgCtPNQ3in4s9oNp6hW+ZLNYuj/MxeJJYR8j9tfXKiAhDQf/M34xXFozJKbtze79cvQ3V2qm+Hx9aAdYFB00UOQ0ZadSmCFrACJt3ynol41jzzBhjTBjaHqSb5NivYW2xqP8wxivCLecGH71azJjQPLFZ0GdQ2YWm0zIUdVTwhf5BEcPX/+NvRTiy9vrcJWeIeKXQ5mI/jmrrPyaJ06GLVbuI8JINQkGUSDVE9NtQA47+THdCcWZD0hpw8XiLayR2enFE7cOXJCKndHH57E8o0YETw91GSkSppJ8NDBUt93cIcqSYA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0146d9c0-d5b8-4ea9-ddb9-08ded2d28571
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 15:58:09.5144 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qIQXYZKkx+Im1qvANGJDIeMQES49/EF8KRo35K8CHWl6Vqrj3oTYa6wteUAuX7EXpC9MufNfCo56YJTXEfLWpv7TtOy3ra7tfEXME6KvVbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8030
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

On Thu, Jun 25, 2026 at 09:36:18AM +0000, Ciara Loftus wrote:
> The number of Rx packets is computed as the sum of the unicast,
> multicast and broadcast packet counters, minus the discarded packet
> count:
> 
>     ipackets = rx_unicast + rx_multicast + rx_broadcast - rx_discards
> 
> The unicast, multicast and broadcast counters already include the
> packets that were subsequently dropped, so subtracting rx_discards
> yields only the packets delivered to the application. These values are
> provided by the PF in a virtchnl_eth_stats message; the PF samples them
> from separate sources and the order in which they are read cannot be
> guaranteed. Under load, rx_discards can therefore momentarily exceed the
> sum of the unicast, multicast and broadcast counters. As ipackets is
> unsigned, the subtraction then wraps to a huge bogus value, reported to
> the application as an enormous Rx packet count and packet rate.
> 
> The read order cannot be guaranteed, so use a saturating subtraction:
> when rx_discards exceeds the sum of the unicast, multicast and broadcast
> counters essentially nothing was delivered, so report zero instead of
> underflowing.
> 
> Fixes: c9f889e99616 ("net/ice: enable stats for DCF")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
