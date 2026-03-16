Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A04AF53D69
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 15:33:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC6884025E;
	Mon, 16 Mar 2026 16:33:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 4EDC3400D5
 for <dev@dpdk.org>; Mon, 16 Mar 2026 16:33:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773675227; x=1805211227;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=5IrlbKkkML93extY3p8c0luRPM/1ZxCeSbGgW01Rpvw=;
 b=PtqcbhKfmPjbUgyYSOkdm4QkUWIO92OKcxDTxKp7oH/fOZO/WSIs0QXs
 nXUVdXGJmODzF3iSl95pJkFZBUPUVXDy5qgjM03FkG4UBEWC8XhKwuioD
 jBAi4M/krtU3lJ/+OmxG6wMznHniW66XVSiO3LF+vrmt18lc7J91vGjUD
 UWdIp0ieJVF6d1+eO+QUo6TZalaPVBJ+Pe3K8rFQOxu9bPB/l4gCYGDdG
 GoHwjcAWF4P0378ofI4ng6v5whzLfgEwmUeau/rIJ6/t/bWR6LBGyh7Of
 n7BQEOtf2hiVZNN8Ehx50jdJnat0SvtBpcB9at61FMAZkj62nk2gtL/K3 Q==;
X-CSE-ConnectionGUID: LnpLofhHRwu5IoXoadNBRg==
X-CSE-MsgGUID: pgAuZBdYRsuCDpMK7hQ2HA==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74398595"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="74398595"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 08:33:46 -0700
X-CSE-ConnectionGUID: n/ARR3UVTNy4MES3sbI1QQ==
X-CSE-MsgGUID: CviqiKW1RTqV43t1Pnrwsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="219140364"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 08:33:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 08:33:44 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 08:33:44 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.20) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 08:33:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=snnF9tUAGbWXzTm3cSsKAYEUjytx02R7LaMYH5DFO0gzdvZ3K6pLoPi4+Foq3xlqyRyHF6wgLCjdpbSU1g9+3x61UzFEN2/iW3gYufx4M30FbGSFW0rRAOckY/Rkf9syCfHeI7jCfgYL1P05Rc65hpcoMyyTQ3Kl+XgUZ3TP7dhc2rGQaXbIL6SEdPBMTTQcSqcg4caJNAmvxn1KCHxzVDL9M8k5zg5j+xFSic5X/CZDY0naPiWu82IGFz5CJsPi76zHpbE++OdMV1jwNHpxOIPTlpB7SvwFCuRFGBMhPtot8y44WkHtxkKjflLFBNHumDtaTWr/Sm5sS338zpY06g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHMxVfrEdZp3ix7wa+WS+/+tmRpXrWQ+fTVX/OC+q+Q=;
 b=NeOjOKKncO7zonPYieJOzbVOvOcARACWDVAWtozfDL22HZxyGYhvGFNWMp7LdMsJ5kDPGGgBAA4Ma6fOBYmaPtT/pCw23NZNi30KdCtS2CzKV+f4lNf1csnR8k8akQE2zkTpkmOVc5JHA9zXFOVFSC/h3/hZ+H41KkPgMR41mwQbcaxodJOs6Z0xFSwMT7g4DkVgU5KI7iCygQwDcLE4fkoaaLOmyD/9j2AnYsSg2vfN2pU7nPYdsgG6rEcvprC+afeAvkyfDRwbjNN+nMoJlt3tp+Te0PFNnyO7u+3uFoltHiUjbSaxj1uCBFufassWyU/Ib6HShk/xlP4PX1tC7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by DM3PPF01A5BE19B.namprd11.prod.outlook.com (2603:10b6:f:fc00::f04) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.19; Mon, 16 Mar
 2026 15:33:41 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1%5]) with mapi id 15.20.9723.016; Mon, 16 Mar 2026
 15:33:41 +0000
Date: Mon, 16 Mar 2026 15:33:36 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Reshma Pattan <reshma.pattan@intel.com>
Subject: Re: [PATCH v20 25/25] app/pdump: preserve VLAN tags in captured
 packets
Message-ID: <abgi0O1fWFqYIDP5@bricha3-mobl1.ger.corp.intel.com>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
 <20260310161356.194553-26-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260310161356.194553-26-stephen@networkplumber.org>
X-ClientProxiedBy: DU2PR04CA0318.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::23) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|DM3PPF01A5BE19B:EE_
X-MS-Office365-Filtering-Correlation-Id: c09d5fbb-47a5-4746-272b-08de83716700
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info: jCx0nozlic4lYSWuk/lU8zoCthjqys/Z1PFBc4CBSxbnndb3RVEbwq9XWTrLGrhqPZ0v8vlWTRERp+9XpmNUKgIvjDvHgHob0sxR8L++Che9/RfGA0QS3d84mSVPmGU2h1U41bzA4d3QJK4ZL4eLyTbstnrE67SeZwZuOJxMZ5MKzf2AFB5UER2B0TY/knxiSMk3JvM8L4aD4fwvuCJ5ojm+o0Y35Xi2gz0YnKKDoocz+ApdFolhx7F+AgBC53sR1cbIjrJbswGNrk08XgSN8YQ8p7FurJD/ZfiB4roacSOriNEKk+9mM8psqz6mS1z94nWGMmY/czxdB4pSv7AOPrvCtF6yZnxHonU+QlR9/k0KR02/7pO+n37vTxZXN5UHpPqBzdg+biwcYgzanPommh9eRUolD2093tvBES6WCoTyOqyf7y2YHcEYlWQYtZfHlIH805papPYCOjcdeo7Iz2WED1weeSGos8em3yXcEhrHmREq0ipzAQlcFdgYCRDh/6A4ZRcPiQ+KKCsjabMIpVFQTGH4Lul+ze8PVXsx7Zx8iYU0RvwREc1atvXU9NxlK5oocBj7N7uPciiaxtkOaew1KlRYmaUizyd821sOMtEbzF5UkuFLPJ2FgGlx6S2FkX29EK8ezNB+ETvxUc+Ws/24XUELea1rmy1U+ORdmf4uFPetWHtq4l213uDgTvqoHJgGnq77sqQJ8EExEgdhTNEabmSfgKaGTUORYfvK8BY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/HDh6ZzNqISypJLBznt6t+PLERyim32hWa+yJXOBdoe4aGP3nyNi7qMQgdLC?=
 =?us-ascii?Q?0kBAdSIIEeiDrHLFWcBEELtU7b7mp0XAZMM0pYdZMw+33EQU2Xv8kVPpqoEA?=
 =?us-ascii?Q?WZ5IcLdOPUsFjFWdJDjDC9lfgy6WU0NchJDHtIisn57VXpZuelNeSLqaRwLH?=
 =?us-ascii?Q?FtlSiGx5UMFFyTqv7HVWiR7xY7BHwGoH/8ykHyxnQB810Po3A3fILHGrgc5H?=
 =?us-ascii?Q?6zJm40UbyFZ9h2Nadtit/ytvHmFcR1yvmDWrxr1nNUXm9B9BYVHivhHoQrn8?=
 =?us-ascii?Q?5u2D7tsk9irHDuC61Ni1oZtdZGn2uk+4IrTeNqEne79RSxpszMR+WfATz4rN?=
 =?us-ascii?Q?GEVLmDe3aYd7SzTXMkTgEjtxmKOoYZUowDyEZqTCwJTUkzgLjUZrgyj15K8j?=
 =?us-ascii?Q?jCvsESI0VM7yEAA37Ed/oWcfHWKm1CV9O+f8Vd8jgCukJ57fXl4t+sNig26T?=
 =?us-ascii?Q?6PKFFNCAcCe7TaDtPWagOLlVuWoZmYSDnQUyZSXAky7KFQS2LvZQblyXALsD?=
 =?us-ascii?Q?vS6WGOGoi/uqxYbiSG+4GQtMkfHJQSHjZTsg+WfGFDOjWcJZJDBcITMRCBSN?=
 =?us-ascii?Q?Q8m4LPLEwdXbFLfQ7fodTndnr5f74qfspu1m2UlJBl48c7TrDHTJsoobpu9J?=
 =?us-ascii?Q?cQQuOkSJGQFf3i4sFnYG3oaKo2uT0zIJkGJ2IPDf11J+szESL8GfPanHQzrb?=
 =?us-ascii?Q?or4j2V0kF/4YyDAw/Q1SKJ2+/92BC1RnBetOF69GtL9RuS1qRt76PATh+bfI?=
 =?us-ascii?Q?6+SfNPBIXapTtPaTo91RbvYZtNC9iyLLWWNstWnzHfhLpJHu5JlRKV9zyL47?=
 =?us-ascii?Q?PNTOTBfkFenLBxVONVOm0wkmlWTahHlQdlP8b4XfqcyNJq27HoCK3O3AU7TF?=
 =?us-ascii?Q?PTLThzLxDDpzEoWRRMjFCFobUAefJmSyYDcMRMiZ2n8jzcqs9OpmLOryM5bx?=
 =?us-ascii?Q?hMdZqRSdtmlWJMIbgVh9ZvJ/ejifH3IgoVB1GGbPS+9QCsd4me73WGEmoYdB?=
 =?us-ascii?Q?Tido3sQhxD7Y0PWCuJrqqftQ85PGTyys74gqubUO30fq/fgOWYpZY/z9TIDb?=
 =?us-ascii?Q?dnonR+MDHYj6QrjEYUzK/6pKlG3LzEGzpCuZsy33xuE0az5aQhkUvzz8aBfx?=
 =?us-ascii?Q?VpWL4zEo7T29AhJzW1fstyefHawFBJQDLaAfyEZkSclTzOIZRAXzI6Z7j6hl?=
 =?us-ascii?Q?EtuD31ZGsIvVYt6Cl+S8667p4Ht3hmCHVLAHr2ETBVDANJwJVnuDdLY/oKGi?=
 =?us-ascii?Q?L8bI+Qr5RCfiqWjtgdUESzavNX4J90cv/BlPKIAWmKOwULDZaxXvWnhEh8tr?=
 =?us-ascii?Q?Sdf7Zuyd38dtbAsKZwiIAnM3ytsrTuxZhlggmOOiV7kKMNCmDoMQ//eRvpLR?=
 =?us-ascii?Q?VcXeSRBE0vUHTd3/P2nJUlfTW0/yjlSQu2mjhCJzZIurX97Ibl1rwThiCeSM?=
 =?us-ascii?Q?D3r3Pd7NF0IZSb+ZLCiCM09cgQNK1ODlMDOz0sXdmU7uuOcJGmm9JibaM5xU?=
 =?us-ascii?Q?s4oBUQgOw0Fst0qeyhOYxRNZv4rI4V/zd7k440hOTfn1dPUrmRKpo4E+B0R9?=
 =?us-ascii?Q?6il6gW9hdJuhzIkj9pctHT6hFylCOtF+LysGpW5c/EswKtIsnkHVnzyfND06?=
 =?us-ascii?Q?er6RMW7x59c2eSfVto6Vtx6YeW8d9sr1UXZyI/8tBMRL8E6GQPA6LvsNw3u9?=
 =?us-ascii?Q?Q1urXAYgy6Ib0rGYdu1Z911vzBV+uqFbQy7No0LfdCCdTjUIV640Q75UymD6?=
 =?us-ascii?Q?HW5ov63J4W4VTMMjBisKnr6axW8Ks2o=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c09d5fbb-47a5-4746-272b-08de83716700
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 15:33:41.6879 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J1AA2NRG/jzhKhEz8ULv3KJ1dB1lWAhoxwpe0z19Y+AXTYFwWItESKoQUHTf/ZteJQLmMSp75SjRudOPiYRphV7ibsy1DwW2vpfDQ1CHoJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF01A5BE19B
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

On Tue, Mar 10, 2026 at 09:10:03AM -0700, Stephen Hemminger wrote:
> When the source port has VLAN strip enabled, captured packets have
> the VLAN tag in mbuf metadata (vlan_tci) but not in the packet data.
> Similarly, TX captures with pending VLAN insert have the tag only
> in metadata. The resulting pcap files contain untagged packets.
> 
> Convert RX_VLAN_STRIPPED metadata to TX_VLAN offload requests on
> dequeued mbufs and call rte_eth_tx_prepare() before rte_eth_tx_burst()
> so the pcap vdev inserts the tag into the packet data.
>

This is an example of something I previously flagged. Like with real
hardware, I think the PMD should be inserting the VLAN tag into the packet
as part of the Tx function, not the prepare function.
 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/pdump/rte_pdump.c | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
> 
