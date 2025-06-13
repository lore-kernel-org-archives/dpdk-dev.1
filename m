Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3842C71136
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Jun 2025 13:51:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E10D42EDB;
	Fri, 13 Jun 2025 15:51:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id A010B42ECB;
 Fri, 13 Jun 2025 15:51:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749822716; x=1781358716;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=pTV+Cc/uLCJAIYzOMCygeapyualPRdvqkYACkgP/FWw=;
 b=c5ufmx3QH01txgzoPZUN0oebJ+YzFWlik4t94xLFtc/rItW+XiGGFyjG
 4B3Zd6/gywQXwDZ2U88qRDK3Ahx5TKkzlCstKEM7XUMGh8AbK3ukrBKkE
 I4p1Dls6n2TtwqzT0AvNN36zLqE+8xHktp+wcMUlv2zzUXwQOonZODoZJ
 wbiipf9QuPkXJ8j8Xvv3jMiwOp1LXh7lfRjWp9V6nxtb+bBocU0h8IhuJ
 KKP6LkkhezaQ5OEYiFDL0T+88n73xBfg7amTsN5RniLL1TsRmxnKuJ388
 XAkvdNZZZQJnfC3wZiNOsxCrfn5wuipgDkmIttK6XlpoZeTXWvNPpajAP A==;
X-CSE-ConnectionGUID: 5dwI0ov6RpO1/8sptNYRVg==
X-CSE-MsgGUID: 65qaypYSST6kVUfJqV09VA==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="55837795"
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; d="scan'208";a="55837795"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2025 06:51:54 -0700
X-CSE-ConnectionGUID: UDO3y/J7SIyJjwhied03hA==
X-CSE-MsgGUID: ooyOT80BQvOWw153HCaJ9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; d="scan'208";a="171017900"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2025 06:51:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 13 Jun 2025 06:51:53 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 13 Jun 2025 06:51:53 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.63)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 13 Jun 2025 06:51:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YzdgA7CtNtgudcis40o53cjrF4Rusu3ROmLonUyEMISOhofzVz0t9tXEczkndYpXxDbNnUAkJ+vWmlNoDW9dl85iJ2D4A12IvK9smg8HbWn+izCgx+CRC4JNGyIsmhEw54nARkCl9boex4eJkZ+PVJb61KeDxRVSWdRQTIXlozfnAzF0/8xB4Av0QsXDAdJQBvqQa8wpSxwg/Yy7CTKcuooSGSv2bsb+UHk6e8tqcMcNHnZqdQ80YU3xNum7k5LXjGf37oGLDArKMSSHGIi6qrhzis1yEyR/etKFLcBfYzwpoKSNyWp7fwmI08Rm2EWx7n8ydHsv8oHhdn3zXuurEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpmiWZGnpBB4DlhguDdWGd+9nwSpfLp31dfrrDs5eEE=;
 b=LU7D1bVhYsI1rsmy565g+YeOEDKRmCNdnLBmL5JWTaHV5uvRsQXmNeiNvDPMTIJ0lBZj4IHKAZMsvMj4lu6X+kS4CvHC2SW2hDNKsuWC4yEAuarFlGdksjsQ/+NeS2+6hK5kPi8EH9mtUqPH0wzWO5pMEiXNMMMfH8lHZXv73O25D5i9ba+MApYLOmTqGcIzSQq9+fRYYo5Km9DzYiHRwd1t9B7RcIGsL9EG4R8hMT5A7+k/zQ3PQa6fcprK0US0Td40nSXDufnsmfaHmQm+fOTAYfF/Nt6U2rXrTceK0JJo4laHVuUEUZE1j/K1N57nAhlfbLob+po9X32KNHLoTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW5PR11MB5932.namprd11.prod.outlook.com (2603:10b6:303:1a2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.23; Fri, 13 Jun
 2025 13:51:37 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 13:51:37 +0000
Date: Fri, 13 Jun 2025 14:51:32 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Varghese, Vipin" <Vipin.Varghese@amd.com>
CC: Thomas Monjalon <thomas@monjalon.net>, "dev@dpdk.org" <dev@dpdk.org>,
 <techboard@dpdk.org>
Subject: Re: [PATCH v5 0/3] lcore options cleanup
Message-ID: <aEws5G96TheH2CwH@bricha3-mobl1.ger.corp.intel.com>
References: <20250313113829.1480907-1-bruce.richardson@intel.com>
 <20250527152913.279011-1-bruce.richardson@intel.com>
 <5697443.hdfAi7Kttb@thomas>
 <PH7PR12MB8596DFDEAF9A7D0EB11D0A9A826AA@PH7PR12MB8596.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <PH7PR12MB8596DFDEAF9A7D0EB11D0A9A826AA@PH7PR12MB8596.namprd12.prod.outlook.com>
X-ClientProxiedBy: DU2PR04CA0290.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::25) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW5PR11MB5932:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d862305-6b37-423a-4500-08ddaa816a70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QrzwJNgZkSHYNQOtelDzwxAk3POGPVTqi5HevIDdmWFS4cNWB5cpODXVAdxg?=
 =?us-ascii?Q?xpBCGMTCPifxDRJm6Obzw/IE4he7HqdCQZY5ue4xnBgEZv3Lw8bGtCeZr3wD?=
 =?us-ascii?Q?6Uv521cO+Zcp24gDwaopc+8GVZFqOqMSG/fw7B1Ov596wXe5tdQpnoZh5uiE?=
 =?us-ascii?Q?UVAuyxS12iXdXX5Dt34g/ynGdvE3u/pV+38dedQpfgyd+QeHsaG7oHSfU1oz?=
 =?us-ascii?Q?ol0hFBdbEnYc7tVhK9vLY01dwyC6P4uykMQftjTne2284oDLGD78mjQs+BKX?=
 =?us-ascii?Q?oew4gBDym1f8ziX5i8zwal/4D1jPL6iyh0faqSIMXX1NioVRRnHKxJl2GoiV?=
 =?us-ascii?Q?DL2XsR/7aMU7nQ0PmDQw4fg1/Ioo/LE9/fKIk40UApMv6S9v0GG+FsA15aKo?=
 =?us-ascii?Q?4uF/N9OT5exPhOQtd5nqEPVRL51e3cakw3wGHeWtuTYb4lH+2e/7tQeQOSX7?=
 =?us-ascii?Q?0SnxRBFyVyS/4Tf21spFv6v/kLEaJBJEobexlHb5gcAPLGbnXzDrqITIdmKs?=
 =?us-ascii?Q?24ERCYkZruZVydiCVtywXC+As+fdIBnDTZN5xrh1yrii+pIKOyvj0q7zrn1C?=
 =?us-ascii?Q?V1uPosN6QUdmeoys4dsMdNVRFa9ylp/TxLptiEczH/axDYa1Jb1L/X2JwkSI?=
 =?us-ascii?Q?+fYsWDQjuEZcTK5L1smP89eiMcmS6KYAai4kepptBrcqG5PsIhG9+4h6jOan?=
 =?us-ascii?Q?vqS+hn9wBgFlid0/NC46akSJGUmTIyYwA99bvKKwZfGnhusBM7suK8PRkvG3?=
 =?us-ascii?Q?yId0E5oXDMCKarfdsonSO/od1uI/zkHOTRS04Mw9d74d+h9V7XxxVxVoyvWr?=
 =?us-ascii?Q?ZJ0m9y1PmT8ZsZsg+WEDKEdGR9vcBzqTsvRW2wMoTaOrlDIIxbyviZ9NVK+x?=
 =?us-ascii?Q?2X0zJgSw19n0QiFYWCNoprvpC92Y82s+xGwOnHj9U6KL5RT4CSnKFyp/vrv5?=
 =?us-ascii?Q?34t0Xs01v7o1P7BqiYe6s7kN8pg6kUDEZRM4U3LN6KRRIL/0k0YCPCxp9GKu?=
 =?us-ascii?Q?1XccHEftaONy2dgh+Obz02XJMRcJrEn9cDpOPDGWa6VoY2+VZfX9bv1a0r6y?=
 =?us-ascii?Q?BqUFOSLe3esU7L7Fr/s/TX+eoXiVPq5dmijQKsHqw7tQrP0GsvTB4Pj0/JU7?=
 =?us-ascii?Q?lmqnjUobcSGauxYyAZGrWJrs1NnwN1xIte+KIJahBIEEJCP6CnEUocAlT8aX?=
 =?us-ascii?Q?UCtKx2+ZGTx7Er1aNS856OuxRjQqCC6G2ZSbipGcIl86SlvtNsHudrEoLOee?=
 =?us-ascii?Q?ysnAeWlZRMB4mleI3KteEE1cumNthMYJWidgQ53UmFNU20lFKDHTPrNW6Pss?=
 =?us-ascii?Q?Bwhfejv3sPUKVQzJ9T3ssCW/28Vy8y51feMvOqVICuB/W79btP91uxr3U/OU?=
 =?us-ascii?Q?qKF8heSf7wGR7lc8taZlaBY0f1soi9PO1g105Pu5n0iwn0teLe7wS3m0E20T?=
 =?us-ascii?Q?cWsfCeyd3YI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0T2q25WbNE0iIjo0VNt3gBOnwrKI9OxFk8c4M5D1nX2rXq1VVktxgcD+jxaO?=
 =?us-ascii?Q?HptLC3JykCLzU8UKPxYxkgEHWh/8imfeDmLy5L4Q9nZZmb8PQToSJior8+tv?=
 =?us-ascii?Q?pzskDiLPWLPAg9pwvWKCiIwDoDQeU2U454WY0T1ZzqsWRLZjT4RCHrpr5Ft6?=
 =?us-ascii?Q?ZQPYSv1PGXZ2Km7D4t9IBCyjpPwxgWR5JCEkX/kkqalZRsQEDqCcVMDiA7bF?=
 =?us-ascii?Q?FjnF+DfCCTDpUkkvhY5JGsN0ejo0s1mYqTCp6/qa5p1d6/w2rJor8ammXsV9?=
 =?us-ascii?Q?B/JME57+6I7dPXZiCJiKQCwfKUb5Ah069x+pGZm1HiV8cV9cLTP13f952S/5?=
 =?us-ascii?Q?vcGh3j64Ivexo8BLDuEie7AjDpib1QGNRguWcZHDJxGW0+rIFhR1jNjIXsTB?=
 =?us-ascii?Q?xnnBE9qpBIxRpPj4klg03OjDW6/0UnEgw5nKowr8ewHkEFZtrDW/lBu9hyHu?=
 =?us-ascii?Q?MQOl4XiIPrpoGaZIEuc00a/rd3hJ10sayQPs1Jz8fWTkI58q+PvfM2MLd9Ja?=
 =?us-ascii?Q?qSYheoz7244MRt6x37moMeoYLpV0VJLqPi8e7kyHnfKjw+YXEaOk7ak3wB8+?=
 =?us-ascii?Q?jvQ15FKta4EcwkRONaDojbsh5eOP0J94J65ssTqAL/xJkeWUvzhBHIbrEqe0?=
 =?us-ascii?Q?iJWmb5cpGtXc4KNxxuFNDBNq/Lqkfu4QW+FkWuEucDLehIk3axjaAVm4++YH?=
 =?us-ascii?Q?k9m0U9te6zpS1wiDRp/Wc0leb7qWB+7TZe/L77JpyMadx9//CQlJvouOxJen?=
 =?us-ascii?Q?CDEEANZ4E6XPeftlsnMFRGHv+8+k468rco03cj4rx3ZpAdipHs89FpKMCHYL?=
 =?us-ascii?Q?4enhxdZvZXG9QMAaGAtfQjiU7kQRgGmKaVOcfatFBe2tSs8uEO47F2PAStcR?=
 =?us-ascii?Q?Y2PNRVwMMhZr0LcGxsts7Sc+utd8dV82rY6pY7ytizL5q47e2qOsCyWijaTo?=
 =?us-ascii?Q?wJsEi1jj3mMeD1yPch0MJ7sDLpyDX6xLvqxqPDKnHzBJP2B/9Ofd5ih0Ut/p?=
 =?us-ascii?Q?++m/oF/gsVfK9eusciWkSNvJokbJhaH2MpB/mPE3+Q/F7NskrhpQp4yqwgjm?=
 =?us-ascii?Q?fFKP/CDtMayXe8B0RO07a3UHNOeHqANnPPhwWROAS/3vcdH+SBsbaLku4qd+?=
 =?us-ascii?Q?39qmhrqfJlFDwmmjtjI6sL0TfAD2jT1egeJFzv/H4XiZLpAZjMIjv+s9rGVw?=
 =?us-ascii?Q?dl+HvqFUoV1eHXYoevMpxr/f6cWFgaeYaEuiE5P9s1voa4LdCvQojBTXV61R?=
 =?us-ascii?Q?lgniJTnmz8m48UDHyBAFcnEa85tKZQXv3OZNT73HNWVWsmwBO7CyZX8GSl0X?=
 =?us-ascii?Q?RvrhKgvzT1M5w7xDYpzEAa8O3aNitZNuUhPydSRVrBuAbhuxkKsRuREGnfNV?=
 =?us-ascii?Q?jC02sSRitBp+WPnCG3fvndxE3Jmoq41bxcRHhYSblD6jes7poJqbSNKRaYxB?=
 =?us-ascii?Q?ZoUsO+Fzl5WBVxwzJyrrfhc9vWdA9oTgcwl6rW3D9kCFedR3Tz9eXdCPgCK1?=
 =?us-ascii?Q?kq7kCW/f5Vf6qgyb8K7kTA6rDBe5pwcqty9CIrzS7fMtds3pTC1g2zMR5FlB?=
 =?us-ascii?Q?NzABRY0LVIE73PiOr8nxq1c9RQ9XD9+NaesaGJ509LFCtXRQbcOl9J0SLrOU?=
 =?us-ascii?Q?pQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d862305-6b37-423a-4500-08ddaa816a70
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 13:51:37.2316 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rvsLEnM5PCfCDz/O1GrmPvUY4aEqNQKEk8UeKuKvLSsg5dWTn9ck328s9XNRlqP8M7QZT7PZAItibrCWMu8CjguAu7Tz5rLSueYYQEVxlOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5932
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

On Tue, Jun 10, 2025 at 11:08:44AM +0000, Varghese, Vipin wrote:
> [Public]
> 
> Snipped
> 
> >
> > Caution: This message originated from an External Source. Use proper caution
> > when opening attachments, clicking links, or responding.
> >
> >
> > 27/05/2025 17:29, Bruce Richardson:
> > > This patchset performs some basic cleanup of EAL lcore arguments
> > > before any more serious work is done on them (as discussed in previous
> > > patchset revisions).
> > >
> > > * mark the old coremask parameter (-c) and service core mask (-s) as
> > >   deprecated, so they can be dropped in future. Everything should now be
> > >   done using core lists where possible.
> > > * consolidate the, previously separate but similar, "-l" and "--lcores"
> > >   flags into just short and long versions of the same thing. This does
> > >   not affect the "--lcores" flag at all, but expands the scope of what
> > >   was possible with "-l".
> > > * Add documentation of examples of use of the -l/--lcores parameter
> > >
> > > V5: adjust the examples in patch 3, to only use quotes where necessary
> > >   and explain in a note why they are sometimes used in the examples.
> > >
> > > Bruce Richardson (3):
> > >   eal: deprecate old coremask-based EAL parameters
> > >   eal: merge corelist and core mapping options
> > >   doc: provide examples of using lcores EAL parameter
> >
> > This first step looks reasonnable,
> > but we need more acks for the deprecation.
> >
> > Applied without the first patch deprecating the famous -c option, pending for a later
> > stage in this release cycle.
> >
> 
> Acked-by: Vipin.varghese@amd.com
> 
> We had been using `core-mask` on DELL servers where BIOS is configured for Round Robin core mapping. All even for socket 0 and all odd for socket 1. But can work around by using or forcing use of `lcores`
> 
Thanks Vipin.

Any other acks, or alternatively any concerns about this deprecation?

Note that there is no date given for the removal of the coremask
functionality.  I would not expect its removal before the 25.11 release,
which means that it should stick around in the LTS release.

If people prefer, I can respin this patch to give a definite date for
removal, or we can leave it as it is now with "the future" being an
unspecified time. Personally, I'd rather leave it unspecified to give as
long as possible changeover time for this, given that coremask
functionality has been around for so long.

/Bruce
