Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754E2C5CFCF
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 17:16:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E22A6427E7;
	Thu, 13 Aug 2026 19:16:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id AAC454026E;
 Thu, 13 Aug 2026 19:16:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786641413; x=1818177413;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=kXyWSmPwvsVtp2GeRyywD5Ty1353DV1SqffQehSSUXQ=;
 b=CcbKq/g3FG1qTx0XPeoSMKaRvsQJqo0Z74axN+EzIEBNrNpImPpBnSf9
 QBI7BX5w6RFJJbMHOaQqNLn3NzZ93pgjch375JLHfV2vQGEUkdkBOlai5
 sR/OitmalGH/slCsi/YheRUYZhvvDPCwKQGwHWlaI5fHBnSMlsdp/fl2M
 6iEJBVFhH3wvdeY+ckDKQbTsEvMuMnkzuchJDscvbxVAPk1YjGO51tJzB
 OzbD3lOd/IwKfsaAbdu7gCO3Cmcr07gX5PRpqnrZog7hDCgpS7iE9VOx5
 O+ftyjSKHELYzgmHzeU0xL2fvez7oBQCr+Eu65XtCT1SB3s/rVWxPQX38 A==;
X-CSE-ConnectionGUID: NKLUiDfLThapb/XAlltPIA==
X-CSE-MsgGUID: gw2OpS1kSa+y75OeZJszew==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="112767392"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="112767392"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 10:16:51 -0700
X-CSE-ConnectionGUID: 242j4xVXQMq3WX+rLAGZKQ==
X-CSE-MsgGUID: jKKYXujgThqgZ0kI/NrNjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="293922359"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 10:16:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 10:16:51 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 13 Aug 2026 10:16:51 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.60) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 10:16:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=btaSdk14DYYP/FNXJd0dM8vOUi9Sl4SiL1Qwvi4CnEmahlEFSsExLUQ7qQWSeUBFov2qZxO6Ma36KKhVbdpt/PmYjidwBsEegXUGRuN5MeZ6XAK5+5QKk47oZE8ETdcQpO7vCtR8KzN1F+zizFGHF6spwKTOvGdBH0IVFGdT5HB5slSFMMPApjMv+f9YMeMdKLRXgCoUJShF5EzOK1JIs2pNzs5pRd5piAORFpCs5yYaSL/Ld0JPL5HSdoS0BqtRvrJ2xFlY47zV2hivzfh1fnykfFsIkP5kJ4b/DHF9pweobjPPBryFEdp96W/1M45Y7/LmfF0kLFTl/RLmR3v/IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhrsOLmRGu1F/MnMG8SskyWnsNoEaC0t1sbmEUY/LYA=;
 b=Qbs3UyRFJYnmy+oNViWXnq/2kxhpPjJfX3I8zzgwGEn/XqkeD0SI/eQhG5xuj05xedZOmwVllHNIrbQyyR6D5EaV1N2ssOd9/tDq5LOeVMnGjyzcuHzuHJ7+uxFd5np2qhwrOsxfgUe89KDR94zhZhYZ6GyGkP4eAtQ9GwpPaUQZQ3PudL/qox1OAKZbjTS98oyLheIPvbLfjOHLs2giX1NKqPAg1AFKXExYo881Cxoi/PdA5HRNb3TNGigq2k808lMq1DRmGk7fVc87C0f48I90ureilzVX6dnmfJZgdFaeUsq5vFc9Zehl4uaVT6BYkfWnq1ke94m/CQhp4iMh2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by IA3PR11MB140164.namprd11.prod.outlook.com (2603:10b6:208:548::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 17:16:49 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 17:16:49 +0000
Date: Thu, 13 Aug 2026 18:16:44 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH] net/idpf: propagate PCI NUMA node to vport ethdev
Message-ID: <an37_Ny0wGfR0MfZ@bricha3-mobl1.ger.corp.intel.com>
References: <20260811042635.465194-1-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260811042635.465194-1-shaiq.wani@intel.com>
X-ClientProxiedBy: DB9PR02CA0014.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::19) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|IA3PR11MB140164:EE_
X-MS-Office365-Filtering-Correlation-Id: 0806af68-2ddb-470c-4ef6-08def95ea8cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|22082099003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: lMOtdnw8by865mRe4IJonCX7TBVF8iu5/Tn8o1xYzs8d7BlMyV93R3sMTzM2tvNABHwB4VxQyQo9nHV+rTfboa3JHX14Vn7BnEO/0VQkAn1Op92yEYVbIWa0ooSjx2XqCxFYqPQMcs+/RVUTaJRo7XT0oErOlEWPCIJ0VjGWVaOtKSByDVlh6OAf8YA4/tNerIH1nQNA2Ai9X3QgC31waV7T1uQRABH9LKryfpjk9a1gABYyBE6BvUo68RaZk0kbKbhUpltQ/VgbdUfuydUHzNsb7S5oy/a5qFxI8aqOvTdWKRRGAJu1no0o9HSnRQvnodhES0wNbqGZpcB8MQh/+uFjDmjrxt2Me0A23iCXUQri78Z7metVsTCm1OBQQDPwaGE9/QSFdBejP6srMqvZCpJZ6pHTFrmOIAaLEjj62ZZBtccJ7VwMe1LsKFPHK/B7wkcmLXNGkciOeeb3MtIUtx7I0IX26j/COl93i9WEF7h+NE603Iq5Cg0RXTr5xuCiX3fqSabVsj6rQVRIgDx3UnajfJUERAGz9c8gP31jlM3xOCmZ9NXhc9k7hhrGuRqRyj/uPCbOLb1lfvKuL5SmhxEoLU3r7/fWh9jXGuDyocDFHqLbzpq9AYrZPZt+53lU/5hcByuXRlrIW96qREk5T4tIFR5XY/vrh6D1CXSiRg4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TWFAzeUM6yW+b6rT12PzeWwkEJGBancyB5cEwn3R8PtMxIIw8P3cO0D6h6Mi?=
 =?us-ascii?Q?+p69JKudqBNHxcfT0mVlVmlLBBx1Hq3RtxTXirVQE82o019ph16TGEDmGpnD?=
 =?us-ascii?Q?OMQ1h308JgCsMrSQ3GOiFCkaurfBuSVPcAZLsBbYEWjqts/h11pejixj30W5?=
 =?us-ascii?Q?jhsahaPZBFbY89XaEhBqdyrgcUIthEz8xy+15k61uAcgZpukQwFeQFu6vUDt?=
 =?us-ascii?Q?qOIcdrU1g1+qPIJZRQvEmfRlJS0jpLimcnwFEpMLVxwHs9ci01uaP4CYaIRE?=
 =?us-ascii?Q?pj1osYUHZWVXj5kWPqv+yd2D/xzQs2IAFWqTR+r0eirQUOiTCAEvK4l+AC5a?=
 =?us-ascii?Q?2WKkrRCbZhFOph+qxcxQa5n2nGg0aeN90r72e4DACPH4wucA7dy05anEo3LU?=
 =?us-ascii?Q?ue2kkZed86y4Lj5czGOoT0QZiMIZ+gmZGaVsRC2ZtNtxRQjwvFh2IWvIqF7f?=
 =?us-ascii?Q?p8dSK9a6LLNDC6fw48mDlxmOfPoSxzuhs8FVNywQX/HrcIt+p20wC/dF8t2v?=
 =?us-ascii?Q?mTTTqQ0JyqHM2NzywFWGMud8RTjCoW72zfrjuZ3qMe+zo4RrjI1ElWVCCWAj?=
 =?us-ascii?Q?lODzHfLtD/xl26BeQCiyOtZnZZNiOxOWuIHvZtbGaFGyG9FRituz/YxdiDLW?=
 =?us-ascii?Q?QlO7Fw3bktidKWiuzyZJnfQUsihWoZPgAu+KrwWKICqLFpPIjTss6lo464jP?=
 =?us-ascii?Q?OObeoyFg31AkXGq8XLAjr7JZiqL1pcA4EtuXG2/tRYnHRU+EAp2C4+LRfsNr?=
 =?us-ascii?Q?PK6T9WVGroavfLxYSNTA8SteWy1pJ1xKURtsUabhLeM5HmlgXKo0/UDWIdn5?=
 =?us-ascii?Q?ic2SwUwQ5ftcyIaCHRMCBIMI3pN5KiCKls2/9uqBf3mmzt25tm3JbNcSyfbj?=
 =?us-ascii?Q?/YoSF/zRbas6jNOzW2ivfv6AnLVvfLK1VLq74zQ8ev0a2F/mmUZ/kmMpa2LS?=
 =?us-ascii?Q?o4wPe0lSm+v7gpVmUz/VDmby3Lg2cppHhEuJvZWgzPANkfOEwM1TshPMCiCF?=
 =?us-ascii?Q?uKQWtroSesNIBtBDWdU8ZcZ4yuSxsklMe1q8xei4tUck1BGgQamapaTSEkCN?=
 =?us-ascii?Q?/w+HaWs9esk56ucvSv3qCHfVeyuLjP2mTkfsKj6W3p8bq9JL91RacRleFN3p?=
 =?us-ascii?Q?oRcisIj1/d5tDRFx4JctwYZXrjZUYQH8xP/odvqdl97F23bCyHnZFiDvGPF8?=
 =?us-ascii?Q?U2D7nNaP52GRf3v1ymFnYXm5+vNeC4G/+PrPBqrlAaNTTqDtBoY/ZBIzbCxO?=
 =?us-ascii?Q?7/zRGXYt5Vu9p/5fWD13AAxnz2UiuYRLztLUwG2/cR6FxfR65T5uRSSakzKb?=
 =?us-ascii?Q?lfzQ4Ph7lSuNiAihZK3kKI6QNzguFptn2roYzG8LMevhSZkwagRqbi/0FAi9?=
 =?us-ascii?Q?IR1HYNSds1ZEFuosS7F256MWPfPJ/GI4SnmLiWjCD4zmejDHObIluzki/Wum?=
 =?us-ascii?Q?97PS3jQDc4q4RZf6PPJFiegJPFoQq8IwCYQ0TMvB0cMPsKw1W10cDcc5zrhE?=
 =?us-ascii?Q?5qKUOXBzhepFDtNxV3H1EarfYDM/o0opbK/l0PtLFgfAeKE9UZszaBaRyqBf?=
 =?us-ascii?Q?fEFOIMXVRGNsYVvOJVjGI8c4hp9IahXb53RtuuldtiqXl2MtuoDUYpQ9lg/m?=
 =?us-ascii?Q?yxZlm7tHRExWQozNCUxlpU9gIB4RmKfYtsLj9FC6CbRdmbjoQCXMwj/wq+tc?=
 =?us-ascii?Q?xTr4xrb8zaxDCZ+SYFylU/8TcLc8/p1oEWL7NyBMQuK7ZQgHEzPMehzst0wv?=
 =?us-ascii?Q?jQxQw/lszHfUKyE/+S11mdr6xiFVWTE=3D?=
X-Exchange-RoutingPolicyChecked: fyj8ax6iNGlwKkWqi2rQhIWho4TLUqxsU1GAuZVufih/cEF7kekgKSm64q+JIISnAolaR/yeSMN8yNAScWti/BhJkoFg2zBSJcmpyApHJN+4z28LwYwGGAJaiTu44eHQC9tp60EXjB9l1qk/kWBvBBKaX2MvxdLnVMFMkDAxCMq1pAhuEPj759o6YIdeSy3GNeN13n/kF+07OKMCPQjylvuPp7qEC0uNfkwgGG2gIxqvP6F3WYh0ryhxDT4UWsTyjJ0hqzyMM5MAF5y62us3NhE992Zn4FGe4WVqJYL+UrlXYt+4ygve59f5AwMN1a3QQRiptJcQdfDd0GzR77ouUg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0806af68-2ddb-470c-4ef6-08def95ea8cf
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 17:16:48.9299 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I/FG3j0fktP/8Myrpt6Mi60ZUuqsyWDD+wdEjBZ2OvgNjz/vqBeQeCNhwV8FqQc/rh3RDqgKWDB1eiUPaz03xkvrpQJCM7vz3YxGbbcXCbM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB140164
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

On Tue, Aug 11, 2026 at 09:56:35AM +0530, Shaiq Wani wrote:
> The IDPF driver creates vport ethdevs via rte_eth_dev_create() with a
> NULL bus_specific_init callback, bypassing the standard PCI probe path
> that normally copies the PCI device's NUMA node into
> eth_dev->data->numa_node via rte_eth_copy_pci_info().
> 
> As a result, rte_eth_dev_socket_id() always returns 0 regardless of
> which NUMA node the device is attached to, causing NUMA-unaware memory
> allocations for mempools and queue descriptors on multi-socket systems.
> 
> Set dev->data->numa_node explicitly from the parent PCI device in
> idpf_dev_vport_init() to restore correct NUMA affinity.
> 
> Fixes: 5e0f60527e5b ("net/idpf: remove vport req and recv info from adapter")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---
>  drivers/net/intel/idpf/idpf_ethdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.
Thanks,
/Bruce
