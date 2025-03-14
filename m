Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10409C282EC
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Mar 2025 14:46:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D203402E4;
	Fri, 14 Mar 2025 15:46:35 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 0888440289
 for <dev@dpdk.org>; Fri, 14 Mar 2025 15:46:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741963593; x=1773499593;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=UGxoWBWsBK6CfLb7vPessXQeyZyWFVsWyZQ/HxV9D44=;
 b=iRfrwEh1ihP7hrFurtHcJtkToYtEBVM2Ie3eEph4MfTU1yP6DXu9PgSV
 TQXL0CPzFgTYEZdzueFt4lG6efktRTOPJ89b8ILEVQNotfhWnTmit57ev
 gX5xh2NF7LYaRjN8Q0euYZAXvp/6QU1Bz3NTWdIwNo2ZIo/6pxbKhXpkv
 2iTYPyccfBELzufaTzflReULYiUlCE9WYeqI1/xtz4YgYB4CohwXjzzQO
 AXhWMFRsuJ9oF0HkdafAvPfhkkhvdt2zK/TzgjngfJKiboLM2xSNno416
 LjsyUYqIbDBwJNWoMNZjqRyVjfwenpN+RBSaok7XwIAiwFTJU1Ko26XLM Q==;
X-CSE-ConnectionGUID: CqIdneWNR2mhlzcAXsXIHw==
X-CSE-MsgGUID: Umqj+kiGSYaaEAikY/0fMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="43022609"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; d="scan'208";a="43022609"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Mar 2025 07:46:32 -0700
X-CSE-ConnectionGUID: 96/+He5XRti6n2HfFpFyRw==
X-CSE-MsgGUID: L0rLtYUWRECYq/yVveOCkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; d="scan'208";a="121492077"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Mar 2025 07:46:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 14 Mar 2025 07:46:31 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 14 Mar 2025 07:46:31 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Mar 2025 07:46:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bnElsbacXsKedfpvmmoiHpruNXWQTz5sjgor4AkLUUBu69LjGBECEtZ0AEX02FexzPpSblYWJwOvFqRRuewXODb4+QHusSyOAHhSaDrpPS98jYr/eR7RhlN4ifdHnasp6jhUg25WuLJyQVSCmQlre7rW/YAFWpqrTYLFfqDpzatFs7YnFE5wGJNLbCRw7++11R29CAT1anQ9nXqGusxgEh6wxI8Nuzd5mW8vN9k+OIahLndzpB3JiORqRGSdmFcvmu5v09d0dnKUxjPCFcz88dnucvEFCUzoeoaYlefRLQLq9h7iuPONy4K4cF9ZKiipMnpXgMyf3uhT7ryZeEbyFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGRQWpNfFto3YyC4UtI8fNRawPI4DWIBp7P5btERGts=;
 b=wkfSRuuX8VULxh2eyCFkLUhdc2jT91LTT5YeU024np5EDiOh7ebIGtNwi55zhDhB2Zr4Z50mYkDtpj65IJg+usmugcqvwhhBPGtFitM8p61TnuCek/C0zVDWyKJBzM4Yji5SynhUAiMpVqsJPsJxMaB52mMvUTMYjMuPPSvTe9PWabX8BZsrzw1QsYx0R2KQWPNcRZXEjviqmTTtdCa6Ag86ECw80gZ7ZqU5jMURK+Dbxvxu2miDGOKZ6ph4dbbx7tla8HraqBHiaXoHOluCjrymzECq/rX8ZoKMMBiJkVw4VxEDCeIQNNH6mgTdG6e78OiWR3XZEXzFv07bWmw+DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY5PR11MB6413.namprd11.prod.outlook.com (2603:10b6:930:37::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Fri, 14 Mar
 2025 14:46:26 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 14:46:26 +0000
Date: Fri, 14 Mar 2025 14:46:21 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: <dev@dpdk.org>, <mb@smartsharesystems.com>
Subject: Re: [PATCH v5 2/3] net/intel: use portable version of
 __builtin_add_overflow
Message-ID: <Z9RBPQ1W3z4pG5x6@bricha3-mobl1.ger.corp.intel.com>
References: <1735857169-19131-1-git-send-email-andremue@linux.microsoft.com>
 <1741962820-27123-1-git-send-email-andremue@linux.microsoft.com>
 <1741962820-27123-3-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1741962820-27123-3-git-send-email-andremue@linux.microsoft.com>
X-ClientProxiedBy: DU2PR04CA0051.eurprd04.prod.outlook.com
 (2603:10a6:10:234::26) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY5PR11MB6413:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ef5569a-58db-4362-4cc1-08dd6306ffb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sy1G3+klXPFiklEmE6hopL0tMUSlrDay3gsgQsvubdUp5thryISt4i30upzA?=
 =?us-ascii?Q?GjvUjRdCIPz5ZBZkx/dLVhHAt6P/ozJkoGhrm/OwrxVYnkg4YIHFdLpxYqfN?=
 =?us-ascii?Q?bO34uIB670vZtb3X/B5VPoqMPneyPQ0ItFwyaWJhCVoMefeS0wRfom+2H/rE?=
 =?us-ascii?Q?4El37lprvTaObRHsBpkDF+YbAhSAQpchs5huf57awwd4Z4xx3ODT8OWXpbNX?=
 =?us-ascii?Q?hZEEDDTlMeV7csXE0HRhDgYiRS1+LCjBObb7TJqXvdRn6YY6ihLzxtRnlsi+?=
 =?us-ascii?Q?EpZLg3jm29ARVnJhvqwcjnQ8y1TktNOnxPrg8t3ipwwLeqsNUHtuVodVBN6r?=
 =?us-ascii?Q?ygRaViIBITkqk1sCoutArZ0gDLq6jKYjcyv1z8vx9hZ1MH52AmcGS2y/Uf2m?=
 =?us-ascii?Q?Ioy6mduiMlCqOADIaAeqixD+xo0iCW9is6btE0aQd7iVu6jU80gQG1PqHCWj?=
 =?us-ascii?Q?7FgjqoHsW8DstStceUFlRTMP/Jq4ZXocZEAyGfEDyve5Fo66gSMjitwhSsRB?=
 =?us-ascii?Q?NKyVJF6c1t+Qq/YETeYbVSU8fr6BFc+iB1RYAIpuIh8E+s6a25lItMZrML8R?=
 =?us-ascii?Q?fy5dPEXYAdc/1iBuSPPLFuouNMTbJCgNZq++GTbbnj0dnZOWyQ2p4iQZGxuL?=
 =?us-ascii?Q?U+DaGOAb94oZ05mim1sM10brV5h7B78WSiPUqrSFgaxmASgK5I+9jqcSiBwS?=
 =?us-ascii?Q?R67E6KqkFL8TGdcMw4u34pix47KlptPVPA84DgL4rQv7e0Pbb4vnYTKobUU3?=
 =?us-ascii?Q?ZHu2FJCXGHjVEe4FA5z8rcntbXo4ayIJA6epOs5pDQpxqjI551XpWVoZwviY?=
 =?us-ascii?Q?eMoWDd1uAMWJIq3vjiVy7XQlEb4rwSDBMlPlAbJPN/wnZzY3UHilwvK0NhrW?=
 =?us-ascii?Q?U1HSDXPZ2eA1se037im0seFbg+OBqX6fWxLOfyGDUTDIZfYOFMYJ22XXJG8w?=
 =?us-ascii?Q?qZV/VagGn5tIIlcuL3zO/9rvVGqK/Z81bBy27bKdXdwCPkS/ZOYaROhBWqdg?=
 =?us-ascii?Q?DXuM6xTrM1H1jIHOk4wLLYgFt/D43PVPmjOwoPLrURYVuHxxn7XuqAcDi0JW?=
 =?us-ascii?Q?F6l2lc782NwY/Z6P+KCbBAwolTmRJGq2WGJdSjp156n3LGmO7tyCV/Nc/TyS?=
 =?us-ascii?Q?unpR6LL0PrnoW0IgYHuUaI8xw4N9qZxSHuGeuCCNK5XLo2iUxl4aKTGdw5fA?=
 =?us-ascii?Q?ndU/xEyJtvJT+h1E5VEmCa0WwaA+HGsMNXfFsl37wxjbo3UX/0dpL5qbDITI?=
 =?us-ascii?Q?7IsVclntxSqFe4iSXNLGSabbLRg7l+Y51ofn5Hg3rfwdDCCQ3rdbyv+NyLTD?=
 =?us-ascii?Q?oi9QROZDWzSXSGEchuibOMzgwLHz7sK60ErmdGeE9JnN/EJ3jtjR2D1fx4x4?=
 =?us-ascii?Q?zWt4EmZXYrQflLFDX6ZjZS+EH//Y?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/H7kk4oLmBEgaTt5OkydVfnK67oIWae+SH7Cv9apL8FE6CJLjqsoTbUCemra?=
 =?us-ascii?Q?tDSkFHElPCn5cBcrT/+uqFz9/P9RMktVFnoVENGNgl2OvBOPTjLsfZOjJk6k?=
 =?us-ascii?Q?7PDFvXojD3hIHJeor7O5YQ/BXF4wdJ49ALDgGR38dxcD/4AyIbS8ic9/tf1C?=
 =?us-ascii?Q?5e7OUZHzTWDwdyW5LCMwH5wJRmm5FhEzCctcparlJUZ9CFwiGjO22+SQY746?=
 =?us-ascii?Q?qaEEEeGpg/isC565Vs06HjhTd8aEy1l65W9RPX9xaS0NeX8R+sB7fculO/Ce?=
 =?us-ascii?Q?4zUANntNW6KqpO6lYoKSA4uDbkvn/KXjLwAzyTsjGtVdXsYY2TWoCogV3brb?=
 =?us-ascii?Q?mTxQ5yluf+CJ1gK7ykf9iSFKMu3iUG5KM/5vVltcv3pDphpQ/ysZhQ2Bfta3?=
 =?us-ascii?Q?CqGQvTrWD10TdIm9+HxD04FfB9xpHXpy00nP/2Gi8y30sMLRqwbMBP3R4xfh?=
 =?us-ascii?Q?+j+PwC4L5fDAtjVA/VhRSwmatSbQEFapEpT0m91sJut/2UFriCvWCuhyE6Kv?=
 =?us-ascii?Q?7vLgnQliEEPRWehTTTIT7wrvEspbycdhYLnhAHccDVcORo5RdBrD+vMwnrMl?=
 =?us-ascii?Q?RNxebQ3bzc606exvy2ywxEaeHILpzTiR6TRXS/y08nnbzAARj/A2/CMqJgtM?=
 =?us-ascii?Q?ELvGWy/2El2WwZ/LptOsGVJcr6eBRh6xTUIG0c3LcTqAxtHq/WnptmAMihnx?=
 =?us-ascii?Q?vpUiUFid60Rurk8xhKpzQpUEhMrjwZKJ+jaNNFXUa4/Lr7X7oAQZbzKkz5P8?=
 =?us-ascii?Q?HfOWbS0pBhnhdG8iWgwW+FR6s7o+j3T/gbDjZvU8l9ffTD3oPaLZJ/DlLWpd?=
 =?us-ascii?Q?xvXUR3uyhN3v3g1ZdvfADZxsaJD1UStkV6QCmDOgHB9l9mzsyXsm9AW/H0XB?=
 =?us-ascii?Q?+Io5B+OYcnDCKd7btiWDQZGnN+Wyi0uZ9Ydeo96DjCJdvXF84RCd96288OrC?=
 =?us-ascii?Q?Nr633VNM/B0Sl7vhQ7yR05CjOrFF6qDyB3a8nr7ZHPrxEQvDckkDBkdCJbt8?=
 =?us-ascii?Q?okpZCPMjBoBoM0SJIB/gz6xSKFpmTJgIn+paHAvJwJEft85vX7FFDPh7Cw8R?=
 =?us-ascii?Q?KdeY4LRYjGBSgro1t3g3yYBuuLv3Cw/v/P4R40noAnHzRmWehXEyTx18Ah+y?=
 =?us-ascii?Q?ecuKf/BCsja9WGfE9mrNdlgLc5ausys5/+BUTrnjlf9Lx3gp+TUmnYFIYJyo?=
 =?us-ascii?Q?clDZL/eRgOZk9HypNOAgwdk/4jB4cC/NHgXQRTGx975T1n1e4F+g5zF2R2DR?=
 =?us-ascii?Q?wpMOan3rbf5TbOqW0c5e818pjB6dEhCQbrUdD28xdtibsaSTzXlgOGnrgjm/?=
 =?us-ascii?Q?r3F0o293fgtwXczr2cShAx35p2kXsmB7ycRh0eruMdNA/u+xV6+AbmtSSc6o?=
 =?us-ascii?Q?19ed65EmDaTYa8H5VQtfry/EO/pnp3EqhcsJ8UuvXyoVLzm4vDip63hmMtfB?=
 =?us-ascii?Q?W3oib4cBe0Wn1LF3XrBI3SHWvZBUBuL7hu439EHopoXf75TNbQl+cPoKOEbs?=
 =?us-ascii?Q?QIMqz8Gxw4H4XwQd+ObtwYDxOL0JTzL0YXkOidguaGgn3w51O99J9/rFj3Dv?=
 =?us-ascii?Q?PNLN9dSunOi1KUgtcfknirLbZZ2lft5N49dFBQYaoN5TWcTLfa63gYlb2LEA?=
 =?us-ascii?Q?Mw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef5569a-58db-4362-4cc1-08dd6306ffb6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 14:46:26.8762 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NQA/cjbxOXIRUTW/AwqSZd+HIeE1EmmbGVhwfzopyIY0MzXzH9zJOSWBzeliQWFvMcDK3mPDMj36dAdi7zwdsSHIxboWE7VuFb6ivhJ/drE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6413
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

On Fri, Mar 14, 2025 at 07:33:39AM -0700, Andre Muezerie wrote:
> __builtin_add_overflow is gcc specific. It should be replaced with
> a portable version that can also be used with other compilers.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

