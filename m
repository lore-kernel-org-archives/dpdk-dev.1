Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166A9C79FBC
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 14:12:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 42F1B42D99;
	Fri, 16 Jan 2026 15:12:27 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 8712C4026A;
 Fri, 16 Jan 2026 15:12:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768572746; x=1800108746;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=LdIwGyV6ag+xs4TY9odH6JMra/zvKVr0GROAZc2x1xw=;
 b=VmHTO/xgVCjG4U3CJzH0rM6gzgLopuE235is5gMgEnO3rMhDHLGa9PRj
 6u5SB+iNxSakiLPjz2K9hpf5sRkz3rmyahSUDD5abHWgBYlVbGhfAVti4
 eg+vCNr681HA7PVJl2NR6LhzvYxl1N3oAa2UtzmO7h0BWWuavmhUzydjv
 K+ahVYg3MDuFPZrFrOA4DoMgknt0D9Qp6o5ZweBAQRRTjrh8cqYyN9+AA
 zeAeJIbhf8WxtwtBg4gi/5kzC5KL7EWCaTd8EcLe6vzA38Y4xkneChUkh
 ZPozznOiziLyP4IGvFO6vtAWuMMWYFZdEg28ylh8mYTyoLLQcpSIOYS5R A==;
X-CSE-ConnectionGUID: w6DB4y4xQda4166J9Ag7Uw==
X-CSE-MsgGUID: h2io+Gi0SYqWYAedqGVQ5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11673"; a="87462706"
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; d="scan'208";a="87462706"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jan 2026 06:12:24 -0800
X-CSE-ConnectionGUID: hTBQ/8e7Sjm0u+N7WLVWXA==
X-CSE-MsgGUID: keODUkz1R8K+pGs5zVn3yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; d="scan'208";a="209386186"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jan 2026 06:12:24 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 16 Jan 2026 06:12:23 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 16 Jan 2026 06:12:23 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.30) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 16 Jan 2026 06:12:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gfXPoWlBLrJu4N22NWo1LzudDbd1xf5Wt5ONw1MLCIMglwI90OZ+oAhQZUEznHOYnqkLocuuqpOPtabCDucIwLkvwdLFQ0S3wRahfpccDHjIJ6vOcTvLbjcCnD0dfKQThUCmxNuLY+dtpL4eWG+RD10Np8kWmwQhBgN42T0SPPIEtf55i7NQnUr5JU5WhzkCgBkitwvAFhixQ5V7h6qJ+Xh1IQxXe4rJqYHxVEMJWtZkt1TDZt4abcaWOZ7Uhozo6bJuCbJZmw860j2gfhC2HSulJus8wGo+if7hmASuiQUNNSw+ahYxlG/CuKRb+MJttTQ2rKLLdbRZxvKTLnLgLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZTumVlLvvIcwR125VA7XUxHS+aVEcrD7LabGbTvEtE=;
 b=N3ZYuyvRLopJZaBAUEng1UlN9ioZsbDvna9ZVVO79v8AJVhrYSeSsm+ZtQX+y1jnyX7Xjuf9SNfEFxAi1p4EEyuOZCJr/9YcMoCXWxe1Fpy1TQFCrNH9pioMSlG6xU0lM0e+dFaCqfanITJMTQZhWDCz5lOYEqY5kDr9ryA+E+k65WgVnBMeIrRzVB+6katmyB7hKHuSOlY3RZOopzvXLp1TZkpwnLiqKxw8vGCiHxkJ6k8D6TFBg9JcQOT9ePUIRAfVlGu7b4Pf4DkZpSFIjwfX+OuHNc8WU6/c2//Svfutu9rArCS74fQFTUyxM8itH08IbhY9NJUdVBqnlxZdmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB5927.namprd11.prod.outlook.com (2603:10b6:510:14e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.9; Fri, 16 Jan
 2026 14:12:19 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 14:12:19 +0000
Date: Fri, 16 Jan 2026 14:12:14 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thierry Herbelot <thierry.herbelot@6wind.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Anatoly Burakov
 <anatoly.burakov@intel.com>, <stable@dpdk.org>, Olivier Matz
 <olivier.matz@6wind.com>
Subject: Re: [V2] net/intel: update key_len when getting RSS key
Message-ID: <aWpHPjGj2GwT8T9t@bricha3-mobl1.ger.corp.intel.com>
References: <20260112135311.2507243-1-thierry.herbelot@6wind.com>
 <20260116135435.3463443-1-thierry.herbelot@6wind.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260116135435.3463443-1-thierry.herbelot@6wind.com>
X-ClientProxiedBy: DU7P250CA0001.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::23) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB5927:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ed874d9-37b3-4ad0-87f7-08de550942ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L8e7kYoDJGmCkgl2OqJn+TNO+wu7e/Asj9GcXgr/6d7V/UDtrZaVr74RWCZ3?=
 =?us-ascii?Q?XyzBgeVMN6kFPwnQlzgXjWid4OtCHowMubZB0DcrzcBbGF7EDXdQA32NMgCS?=
 =?us-ascii?Q?In0eBIeJKCjERG07y7UYXIJ7+Y/x2+0HbwciYm2zH3hI/Qgxej0CEnr9Ha31?=
 =?us-ascii?Q?5RyW+EzzWnz3wYfCXpwMVWA0mjjzvDeVDO5agDXuAlDcxquAIcYstSMCbLXh?=
 =?us-ascii?Q?Co9/tS2lzzbVnjx5Lsy8k7ArbMkhdSkVxzqvFRpYQS6Z1Irly2/QaIUmqMk0?=
 =?us-ascii?Q?jCfHlFmxb0SygitC6LnbM02BxGkJdmDRo7VR+mxUwGmN3Ry7D8h5Au8fAden?=
 =?us-ascii?Q?LJSyobho2af5cXPWcdKMIh8s+BavB0eHnsSGCJobrdrLtcnXdNUGUN/93qz9?=
 =?us-ascii?Q?5owZ8aidLdoHfRfWatwOv52PCoC1TkdcNAWmqL3LQTwoZBaIWEmRloj3Hpdj?=
 =?us-ascii?Q?GQB3d2E11oScwag57qF5Fw5fml/ycbZKMg1o6GrKu7Cg6Nv/EL5pGo1OSTva?=
 =?us-ascii?Q?WyW43cgLXMaN2NyFRYF9QQxQcAMsAE+m/d4FvM9w2yBvofYR0DNKQIcGAl/H?=
 =?us-ascii?Q?CTyxNWlAF4p3JPDfsudesKjgjZKCx4RgNQMPByC2ye36PYr8LGw+wzWGn/RS?=
 =?us-ascii?Q?GGsrPbbBDucMxMaYezrZiUlm9PX66dTlKNHt+6L1lm6JTNGl8bKf828847Mk?=
 =?us-ascii?Q?isMlOytwNhxKB4PWpEw9E3gI1kLcuauZp5bpRMPTXawVw6iBpy0FliVcXyKs?=
 =?us-ascii?Q?FGZHxowxjugjzDpTWtknPZDWgVGyurr5+AyoxEU7WnSYwHjIYiQAMcBAvjXY?=
 =?us-ascii?Q?hZVQ8bRBsML68tsWOwe0wTx6Glm9CNNqZf52JI9IzlSwMEvoZ6wYgALU3A5U?=
 =?us-ascii?Q?kUNGMlrbsgCUSBi+jZd+iV1f0CW4/5fKjIJPhGyewdu7t2RaWM8SfeRqPWQD?=
 =?us-ascii?Q?8s7wyFRH2l7tACyroHB3St9MQXQqaItrFqbBDAtErwkPcasrSpKJvtyVhF0P?=
 =?us-ascii?Q?iSJHlg6D+r9VN0Sc8gsCKOsDGGanIIb0u6c6eK9pnvNiLIMYJiLP3AXaQtEt?=
 =?us-ascii?Q?rH2NPzC2TF0oPy9A9iiOQV4A5bGAZgECwfjOd4F+jhgiqdeP6sdhegd4QiJz?=
 =?us-ascii?Q?7vQ/G0sLnlYm9zkYxvl2+Q/X93hBmpmoDLDn9uEvYHUeVFxjot/O4pvpfmg2?=
 =?us-ascii?Q?jz50lscs2wdH+E1iq6CZkq62jBrJXTtIx0m7zuWJjq7V1dV9+m5kxEMssc0o?=
 =?us-ascii?Q?jANpM5M2Kl6Kce4tV4/MLynzIDdCN/XtXXbGFrnVACd4Seb4Q/S6h/Gm+Llz?=
 =?us-ascii?Q?NRbXsloPFhQnKeUga4vRO8hvhGxwkFYWWaAa1EYv/OYaTPXAicDHX+xCEc/Z?=
 =?us-ascii?Q?FqesZllvM94AT8dGSPe7GNvessAKDZ2HdDewVaG2EWPxlrLbMDDwMbL6uFTh?=
 =?us-ascii?Q?1r4Pijasf9XLm2DDmyWCnV/O58BG9X7bI9Lql9TIGQM5SkGwi9iVN1b/kYlH?=
 =?us-ascii?Q?EGVX13PTXvwtbc+cZiX000NRVbhRF2bhyMdzV/PiCFRAkdj98SyjJkfG8ie6?=
 =?us-ascii?Q?BjF2ptLccjDreCbIRHc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KV5MLVFyJ7DVyFXd43Wq7EwYuqTLMzIRG3Q0AEMOPZEFhk/frbK+MljLtO/g?=
 =?us-ascii?Q?9htpwiVZiUs1zMeqI/X5dlBIP6Qgrb9AYWMotbUYMw5eKh6x5216mrjadyDm?=
 =?us-ascii?Q?Qfc4BKp8DEFUzw6Rhn+rezg2Mp4Z8eT+iKh4VaJ6DglVHnpjDvcg2QE6Z7MZ?=
 =?us-ascii?Q?h+0acck+hshP6tnHK7QgB9ZcKzjPwWvPNi+ulB4+csIQVry9jffAReaCjbGn?=
 =?us-ascii?Q?oFmQTOK4v03JUfb0JvVxWWphd3bMOgK0nxpd9ZxxD0Z8FCz+fiytTFVW+fnA?=
 =?us-ascii?Q?5FqjwG4fNe+ZcfEg9lw55MtZlhTrD53AwJULZttQf2OQatmGnNJmUf+oGRsb?=
 =?us-ascii?Q?Uiw23/b1OFFJ5sJHhXyG9PrFlYlAKqDsO4cN2/xrL7fuL3MxEVOI3F62VjAR?=
 =?us-ascii?Q?sbF8N2AtUFxTHyvZfz3DxiWVgMEHtf9JdjOLbmW2IoKuJxe3RIpOyHmKjTHG?=
 =?us-ascii?Q?1uWqSaUjH/kD1vuUC9uhVpa6KzZCowLKc+bDrLEbiWk3tr7qX7+eGyrUExsr?=
 =?us-ascii?Q?E+bb2nZdw+McGYHMQozlTSDHdrp4OgEIc+Ysvkclh0olgoYLlr8daUSv4pQb?=
 =?us-ascii?Q?h0FwFNspdVG/f5qRwgFxflgKpAvfcbs3U8uTXr+X6SLS9/B4Nz919wPzB1Ti?=
 =?us-ascii?Q?VT+6UCURW8UqlQ89SrAJ7xmvGw1Sw6oCNaa55XIf18wOuxMu9uxoVXjE2nSV?=
 =?us-ascii?Q?dfC6fvThHcG7XdBFXzQaubgt+Lniy3hzwht5qWgKCLnsjKyihFmt1GViu5C1?=
 =?us-ascii?Q?Xt5TNjntCk0FfOmvZH8e4tEaPSqyMjNEx4pQcRZ2RTUVdVeE5NM0VVdvfTbo?=
 =?us-ascii?Q?SB8X3KgERlt1AZbloKsfl4nNGHlFTx5eOd6LsKFdJGo38i9+FVbV8Jb9tP1y?=
 =?us-ascii?Q?kB/Q0SvkD/oPKW96sjaKj7XADM5jdv/2wxzD/pVWVt/kfK++7yRQdO3dWNtj?=
 =?us-ascii?Q?nud1kpstCaTsYA9P65zq9OwZxgaGd5ExjndqUeQaT9BkEXU2cokBymT7N6bx?=
 =?us-ascii?Q?giFPaBjN7iRXSbPboeMl6ofNEfH+d+v+MgD4ztaNDDYd+Ew/AWs0OgrvyXCA?=
 =?us-ascii?Q?lExBQFfrCcNVjWKHdeDeHETYxJlUfcNfqC/DhAKrkdZLsxNqduamUL2+kXGP?=
 =?us-ascii?Q?IavE2ZqRIKow+zv44vyot2P+pgViRYrkW+/7ieHhBYyHLmDZETx5ahV2qVXo?=
 =?us-ascii?Q?EiA9Xi+4ZBi3IjGiiZlVKSCwwkf+WR2wbpcJTb/4bNzEzDWiBwFFzKo70s/8?=
 =?us-ascii?Q?DH7zdDTNdwHGS7PcKy90nMcDip/Eohz8RKKzHylQT8adz9TCWNlEAmP9PzxG?=
 =?us-ascii?Q?UWpJWKnSsYJ6AcOsqar2uNqytgG0gm8hReemVlEUBNL1kmJOFDj1FZw0ON4h?=
 =?us-ascii?Q?Plklxm+7jNTBFC+2W6KlzdLfl8gNEhfHO1b3M4HRyj4euuU4BzKqmLiIB4bh?=
 =?us-ascii?Q?E0hPT2hqhoQNNvonxhx1Veam83wHAF2/gHUTtg6GlZnWz0EBjd869w1xVnio?=
 =?us-ascii?Q?PEIGKFNQ6dH4Z5QpigrkFemKu5fU1meFbiqPdKrDatSMQpyf+pQxmJs/gjT7?=
 =?us-ascii?Q?7zXG8wpjYf2/yC0DaMSnIqofUOEsOaRMOAudIKIFTjWk6cGVpKILn2SfgQ3L?=
 =?us-ascii?Q?MQYCQD49lYcLMJySOpsZzjMOaALPTNt+uXUztjHeKL0HkBm5C05nX1eg/sCp?=
 =?us-ascii?Q?G4UkWR6JQFFAEtNHFLXn/N0ZANkmqI3chTT5A9d8k6ABD+9XC357769UHyRz?=
 =?us-ascii?Q?zKtmKSX5GsQs5ddd87cgzAL+aqdzc/c=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ed874d9-37b3-4ad0-87f7-08de550942ab
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 14:12:19.5879 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w9yYfMDxO1Zgtv5l2qjEK3GVh5pcsX8Z9SbOC/XDyNL9Vb57rlYL99PLZEmCz3nwpG1KEW4DLMvXh+JXOFDOTYAc2Ty2LfvmkK1sUzbhPZo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5927
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

On Fri, Jan 16, 2026 at 02:54:35PM +0100, Thierry Herbelot wrote:
> When adding the i40e PMD, the rss_hash_conf_get function was changed
> to update the RSS key len.
> The corresponding functions for ixgbe & e1000 were not updated to
> follow the new convention.
> 
> Fixes: 8a387fa85f02 ("ethdev: more RSS flags")
> Signed-off-by: Thierry Herbelot <thierry.herbelot@6wind.com>

cc: stable@dpdk.org

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.
Thanks,
/Bruce
