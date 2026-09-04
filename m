Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A01CC79F80
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 09:52:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ACB6442E95;
	Fri,  4 Sep 2026 11:52:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 9FC1742E79
 for <dev@dpdk.org>; Fri,  4 Sep 2026 11:52:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788515539; x=1820051539;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=rEgaP9hMrvZaPy6r0Ffpg3TGDUQ9/1mid1JplCuHDGk=;
 b=oAwrmz0ic8XAxa6qWOwFrlrpdgCR/g1t5u3x9UJwCyu+QZBiykkuoSRD
 xK/ijDao8n83W+Jbb1xhaMDARSqfqAU8bDTgAT5yUaEB/s0lXX4x8BCM5
 NTxt+MdyXLPNC05SPvyLj4gPSwg8LAhRzuHMtHlQPGh2UCu0SYU5yixRV
 yJgqjEuP8hUuJ6G0L9G5r8lcaxPCYEjVoIXllwVNcJMrGiH0FlDrnuCj4
 xGy7qmr8m0VMjXr0zUYa5O5fH/gVdneuFFTE6n+M64mnS6iJ/2Ex7FzXW
 xVdf39cghQOPIDtJ7jEJb2vK+fkhPgRlx/46gEryOIEzB5p9wiMJh6Srr w==;
X-CSE-ConnectionGUID: 2T/kEX4CQa2Rj6PRqTAeiA==
X-CSE-MsgGUID: JthdYsLgS0qMroNbtY1G3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="100173185"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="100173185"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 02:52:18 -0700
X-CSE-ConnectionGUID: 3OpKiv9FQqq27VIvkYEZTQ==
X-CSE-MsgGUID: LwCj9bKsT/6J+K0vyXpM8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="266740566"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 02:52:17 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 02:52:17 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 4 Sep 2026 02:52:17 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.11) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 02:52:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mjNgUNFzQlZ6+d8zyuLFyMJcnwAGWP/5bJ9aX/AxlgO66OnE3znX8sUAEyWRReC4FPm2qkhrdoIXrtu4wmCZ1UK+/d0e6zIcVWlBcRz4SGKTTnxwlqEk+BFr4XmpSTt4P3bzr5zo2gbceF1KDac7B1dlKxvYsCa0+ESafH+rj0rcGBsPzZ6gaHejqWWJRQvFSqw+v2boTeW+0ijtW9RlCbgvsRYST6wKY5zuGfNpW75wZxelk8WV5wAk3XfQntaQYefxaUNgEW57UTsGuKOE4yvaKL1hDSSbJ+Sx0gWrbj7rKkkmJbmTkEnaZdYgUJTl83M54lGEEMvZeOS/kfg//Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37Myh5QK1GXk+nOScfWX2EHPk2jJuskyTp9U5khMgEc=;
 b=bXpMpSHVdQre8uuMzQtj7F8xT1Ynm4LOVY80R+1rIk9ou4ThO5YvAnIh0ZZlCO0fR1fRi8b5/LBJKq5T4lzmsvX8SLR4Lq/rJ0fw4xftZmY8Ryaf+MKOfmhgVEIaub5/1WRX0upkyXb47lBbp0LYCuo5J9XCSNTdV7Sczcmt5UehSmrI7612D14qG3Rvfmh5+EoSmGTMfSl7b86EDGycYGkbSE4jErQuO4rETaY8+IMcoORbgenDgoDkky/75in6aL+uYdiSfnCAvDCSIssPLErXIpkNKj4HZ9drQXLSzBP9cRqtDhGUxGPGF9DhyV4nABqPCEQS/QYq967w0VgF/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by CH3PR11MB8415.namprd11.prod.outlook.com (2603:10b6:610:17b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 4 Sep
 2026 09:52:14 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 09:52:14 +0000
Date: Fri, 4 Sep 2026 10:52:10 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Kumar, Rajesh" <rajesh3.kumar@intel.com>
CC: "Mandal, Anurag" <anurag.mandal@intel.com>, "dev@dpdk.org" <dev@dpdk.org>, 
 "Shetty, Praveen" <praveen.shetty@intel.com>
Subject: Re: [PATCH v2] net/cpfl: add timesync support
Message-ID: <apqUyigDKNMy-PGx@bricha3-mobl1.ger.corp.intel.com>
References: <20260728102008.860157-1-anurag.mandal@intel.com>
 <20260803093027.870965-1-anurag.mandal@intel.com>
 <SA1PR11MB67825EC0A3DAC9E8282B44FEE4A72@SA1PR11MB6782.namprd11.prod.outlook.com>
 <76d7b0eb-34ae-4d09-b4c5-1523578241f0@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <76d7b0eb-34ae-4d09-b4c5-1523578241f0@intel.com>
X-ClientProxiedBy: DU2PR04CA0330.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::35) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|CH3PR11MB8415:EE_
X-MS-Office365-Filtering-Correlation-Id: f2c847ee-08aa-40b7-a65b-08df0a6a32b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|6133799003|18002099003|22082099003|56012099006|11063799006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: rs5kVPdhBWEqN5HorlcBbgvzlxkUD0aL3oS4Blagr9Rgl4eswx2wApkpTypuPxpu4f/67Tq4XD4fjhAuhyB3XxQ64PhewUG0N46VbDfg/WB7YxI8QvaahPhH3Y8XzUeXzs8tE0tCHQmil5muGuJInvfyOnIMiycbkyIjCZ4MzRq3RCoJeuOW4OlgsHgPGFUkDOP354PGcWbz+4hP8RS+riIN/amVTcJlz5e9HcakNjCMCY/P1mlNxjTSy4HD6p/tFJwBRlMU7aCa+Ogpynh/kldkmGOTSJZJmuNMfr/1oVwSAvKYfozWGdenFlyVPhJnEZFj4iAVNTB+HxMNHHTOJ+UoK2YvfqBnmGqrQlQbkpQlhFXxFD7vtuKXHeQZ0i9tfeS4oUEFX61b1/x6hfyG5EZ5yMtdZNVZ1SrZNyjAD8f45K8Q9LbyuvTCHjCQxlGcLp4asOclDKhEjHARqmPrSpf/4aZbGY0/bJGRwCBjzb9pu0NSoRKWD3jrUsfZMAeucVgZ2n5AaESv4ySLqcN0qsTuKCHoAwAwEr44zwa5aKbmLBwzdhhXqpdLTFkCy3gDtlvF6yhpvDbnRjGHARY8SVvBCO5rLIBeDgfLwbKDbNn7eqf91BCd2qNcAswHiMnIMBjaBJvHedfg+xgbUJhs3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z/g91jEYx0fRFBgzoQ8uBn7zutyRFD2a+UnaXd1uMk3v45JTz1E0WuGUII83?=
 =?us-ascii?Q?FdkYO6Xo2isPRTRM2G2XiEAPBtd/nDKyOaMEc8vbW4kNiotAu9a4HujuxLPh?=
 =?us-ascii?Q?xB2y0V0QG+HywHpzfTeTZpRmo3buL/31IjNUZ5f4zT5cqQAIJfujug48vMsL?=
 =?us-ascii?Q?4dtZdKIK6rxpdO4lpZWAeTv63IXAjiw+0DooK1yU0ZUiAyQ1AJv1y7fPHOtO?=
 =?us-ascii?Q?xshnefiZpLVSHxNKEIpxvqcTsqWUQdZHv16DpNLjBH9xYFExZyc2sVnXeGCI?=
 =?us-ascii?Q?uB63bfZsxFokEsp1YXIs0aZdLzGo6LjKWNxtujkcwSRueeCt9TWMZi9gJy9d?=
 =?us-ascii?Q?twmhxoxJm4ZjNxb0HLrA0j/GTZvnawXXIeeZGSPaHKHgz7po8KPTbwz/EFzG?=
 =?us-ascii?Q?PT50PCqIQ28R4+nUBcvZCnxxCydqpcrIVpmWTfJJuOWMX8eRMYXkNG5KWAwQ?=
 =?us-ascii?Q?Rk2mtCSXlJKABWo8pwT+Vr82UPHfXmb3o3j8+ABEJsllfxXYoaxlhWMvdA4x?=
 =?us-ascii?Q?s+9txDaQPMU49rnQySYFP4OhwQF34XGJhWuiuZm47g/1Vsu1xqyHidmDV6Wl?=
 =?us-ascii?Q?Tptdzp9+DqcJ1t2Hwd8dnPEqc1v/frMk87liyjemcmMl1Ug6IwJyT+WGkvqD?=
 =?us-ascii?Q?8CEllDFPOamWyCu6PzKu/5VxxQZ9TTueDgfaOCV+O+Y7V1NlHdrDdGI4zSir?=
 =?us-ascii?Q?FK5iQC/PZQibwqxs5kZY4jpjjuEbJyv4b9GQ70TFXlo3vqOWiBP+g5AyVyJI?=
 =?us-ascii?Q?s9FHPF4HFu7R8dfxOJaYoQv95zQ3tIClwBVeJmC0rx/087b877R/WoJ1Ncdd?=
 =?us-ascii?Q?l8lVhN/qqHZpr8Zg8U0L/HgZHmDviiW4zDgu4PIUay+RAUoDaGkuJ03I5RwS?=
 =?us-ascii?Q?HPvZQwVgXpWkZoDOVvoe4S2btMzmFp8qe6lqxcWDXwr+p7uBPf1XdMqcjRhC?=
 =?us-ascii?Q?WYagmI2CS8k4Tl6k3GEYcFzr776hPo3X2ngztHcEsjcGQzSq4/onZprH98hP?=
 =?us-ascii?Q?j+0+QnOkNCtHRJyqTFJMy2m322w7wTMgdcUqFulD+0kxnC+1pqapVatPWonK?=
 =?us-ascii?Q?gOeocdDqjWBei0m9xeeQlWyjw1D5jSmqzxJBOdfFRKLBdVSK2c/UnY9duXI2?=
 =?us-ascii?Q?ofvOt08f1+3OHKFDW0rxbYKu0CrPocyVulMyB8Hk1qfhqhZSiPSUA9V+viNm?=
 =?us-ascii?Q?79JG6gSFJXwQVm69i7LNon4jlXY1qL2JfWkWM4+IGeHJ45Vax+lccZMyya1x?=
 =?us-ascii?Q?DyX0GUmGwG0k9z9bJOcnQGLXh6dGz5tuZVw9+N4ykdnYqBUmk6M5bEhxcXhE?=
 =?us-ascii?Q?CJCiFhp13DboAQuL1ByZf72xNwCLlOdPmG5yb2/2eZQwAAKWoRdh2DbStwTZ?=
 =?us-ascii?Q?ErYjsR8GHVk55bxLKIWYFsWQ7Tg9r1ygDQVR5vIXy6UGFtu21nT1RWZxZRza?=
 =?us-ascii?Q?epIK1ePGx7n8Iqjcz8+jyBZLe5llQwsNjz2AteXzUhmRTo8LAniF9TMDEvwj?=
 =?us-ascii?Q?bUibkfrWvb0h/JiFiZs2ezl0XDcavP8l0yIO24lFZabRDl+3VGYPR5PL3HAP?=
 =?us-ascii?Q?LSfgjY3knMaP29azttiwZu7RUyLTF4V8J0oitpf/D0fVekj+wBzQqVlauIsi?=
 =?us-ascii?Q?jZ0JnqGbOax7PcQ9hAhonjbhU1Isp8yyXWxAK24gimn8jkzDguQWDtTqp+9c?=
 =?us-ascii?Q?rY2ctgrxWqgtL4TO96fZ7PkuAwI75XlV3TsYKqedeaXxr+5PPHlzY7cj2m07?=
 =?us-ascii?Q?Bg17sCY65IzsjWX44yiqQ9K/3fSh4iw=3D?=
X-Exchange-RoutingPolicyChecked: ExZcH3yd6NLA74B/wfbJt08wmLLPywarVZT1cKbdQhQKMA4zk2RiNsEvqLQu5QVItyQIQBybRmbqCO3jMj76dNo4uO1ULXkx5R29yr/NsDabrPvmJJAvaJI6LxcUcIQ1Z0Lqm0DBaLinXK1Pgc60gduwjfSGNxrswk5OYnjd3QYFDe0B3er8JXBmkr/ipwP3LS/ePtlNZvsw8DA8fRucwqp60LYyqcIuTi1hjiLCaw/mqkGVw5iw0u81joIKo7HksiMazfwFLJr5XhjCDQuBxU5n3beMd53teQfVSOYRx5m7c8EomyvbI8vtece5t7Bs+v6btXpF/K3ZS+Fu8aZe3g==
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c847ee-08aa-40b7-a65b-08df0a6a32b2
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 09:52:14.6207 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CbamZ/Gb02c+YtMeO0w6kXiFIKzlHUf4/AMBgvpDx7TJqVT/pSWADKmtYNa3diuFL0M0VW+4bMP1WPnXbw9ctyck+E73ZY+MFOyvbCB/SWc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8415
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

On Tue, Aug 25, 2026 at 01:36:48PM +0530, Kumar, Rajesh wrote:
> 
> On 17-08-2026 02:48 pm, Mandal, Anurag wrote:
> > Hi All,
> > 
> > Gentle reminder for review & ack.
> > 
> > Thank you.
> > 
> > Regards,
> > Anurag M
> > > -----Original Message-----
> > > From: Mandal, Anurag <anurag.mandal@intel.com>
> > > Sent: 03 August 2026 15:00
> > > To: dev@dpdk.org
> > > Cc: Richardson, Bruce <bruce.richardson@intel.com>; Shetty, Praveen
> > > <praveen.shetty@intel.com>; Mandal, Anurag <anurag.mandal@intel.com>
> > > Subject: [PATCH v2] net/cpfl: add timesync support
> > > 
> > > The cpfl PMD advertises RTE_ETH_RX_OFFLOAD_TIMESTAMP, so received
> > > packets carry a 32-bit hardware timestamp that the common idpf Rx path
> > > extends to 64-bit nanoseconds using the device PTP clock (PHC).
> > > However, it never initialised the PHC, so the timestamp conversion had no
> > > reference time.
> > > Applications had no way to enable timestamping or to read the current device
> > > clock to correlate the mbuf timestamps.
> > > 
> > > This patch adds PTP support by reusing the idpf common PTP helpers:
> > > 
> > > - timesync_enable: allocate and initialise the adapter PTP state,
> > >    query the PTP capabilities, program the base increment value
> > >    and set the device clock to the current system time.
> > >    The PTP state is shared by all vports of an adapter, so it
> > >    is initialised only once.
> > > 
> > > - timesync_read_time: return the current device clock as a timespec.
> > > 
> > > - timesync_disable: release the PTP state.
> > > 
> > > Once timesync is enabled, the common Rx path resolves the cached PHC time,
> > > so the mbuf Rx timestamp dynfield reports valid nanosecond values and
> > > applications can read the device clock with rte_eth_timesync_read_time().
> > > 
> > > Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> Reviewed-by: Rajesh Kumar <rajesh3.kumar@intel.com>

Applied to dpdk-next-net-intel.
Thanks,
/Bruce

