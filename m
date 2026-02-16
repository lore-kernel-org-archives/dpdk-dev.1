Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EE0E81A4A
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 17:08:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1EFC140296;
	Mon, 16 Feb 2026 18:08:56 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 0A1CD40289
 for <dev@dpdk.org>; Mon, 16 Feb 2026 18:08:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771261734; x=1802797734;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=VYLzFDYXPfmdp+Y0hHYhq3OdJwJf7GmX3jDWt5MHDgA=;
 b=YVRmXJv6VorLx/FDHpIjDVIOPS+N4KtEryrP+fbyAF41/9eORLP7LgdO
 vT+CtM21mbGNe65JeRUJTRuKJmo2pC8FyhX1wGK27MEeA4/9siAKjUaNb
 6rpwIFfO1cGmy1wjzOC7wqcnbtKTz4kCBRWl3DzOtvHYbTNSmjQKpSMj6
 +BibwnQlfXpYqz1oKsaYAXzR3Uh7mvOSL1TjFgApO9CykckVFoVIs3zU7
 R7FapQ/42huZl74kNFBQ7wb2/vbBcFW1sK67gYwTbAKU5Mxj/POcEQrHA
 M1eVRGzmV8vmKstkvXWxnkbHnuamR0lb91Kb84lyBRUCe5Usj7IYCoDO6 A==;
X-CSE-ConnectionGUID: yqsKD9UhSi22/G0Ct4tkPg==
X-CSE-MsgGUID: Gj9vZ9U4RUeYVfH4n5K2qA==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="82974726"
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; d="scan'208";a="82974726"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 09:08:53 -0800
X-CSE-ConnectionGUID: nIZpWsTmSMWBKD3epg60nw==
X-CSE-MsgGUID: QOF4YTisQ4Ok1j+PRMi2yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; d="scan'208";a="212441671"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 09:08:53 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 09:08:52 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 16 Feb 2026 09:08:52 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.3) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 09:08:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E0AJoJY/ELkR2+13pIUA8Elf1TN0aAa5vqwc2XmFF3qsm1RrcNwPZAt4jZB3R3g7P3++mlMtbHiGPLNl6ejnfvRVsG1BPrNOlEa1ypJu1u+1jdFiFj2kurwYtz7CxtRw4aH4rp0EnyL+bLO1e2AULB4vQ7+gqajuqGb6YBHv8So1EQwTvWj9L8PkfTEdRxmm9CyDCxtpeBaAUczkd1N3VniA+2yt4REpYcm2gpTQo874wGQFtc/W1BSzoAiOaUMuSsCZWQSPTFXi4YYIRYLYH32AVskR0eldyMUt2XfvhsZcAcuKsuIR/I+/hR391Ipz+KQSvN+JzuwDGKI1Q5umhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ei3Tf3R/o8ADymKmZXEIT2imGZErbU0Og2DNY0fiBA=;
 b=lVhYsNvG3T2oL0BKtmPy6M0siiFVTnTsihixUeUyvUvUgDRSVYLdBp8Nm+yJczAkJg920upVu8MC9uHg6+A+eK54vwQks3wlHkav5WGvdnnBzA83dxtbAqhD9PWfJnNd5BYRx1ayqMFpWN2Fb8sUy4ESmFWvy5ZQRWwFRr41+kdTp5vi2rxHhC2pcRLcQRMS/qduBwQSRkNz80mKIBk0iNc6myZ0dIFxaWT1FE73B7L2p+tYlRx8x/tELIXvyHqry2lCNfXM/IMz2FVY1OA0KtvRuupqSq62xdqzqA9a1spM5R8woqx16OamxGjFVrgwAfBDoNlnMEFR5eEpcIQ6Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA3PR11MB7611.namprd11.prod.outlook.com (2603:10b6:806:304::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 17:08:50 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 17:08:49 +0000
Date: Mon, 16 Feb 2026 17:08:45 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 11/27] net/i40e: avoid rte malloc in MAC/VLAN filtering
Message-ID: <aZNPHVJYGlGfiOpT@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1770817884.git.anatoly.burakov@intel.com>
 <cover.1770817884.git.anatoly.burakov@intel.com>
 <e0e9fe897b674db0e8da9884813b363fee3914bf.1770817884.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e0e9fe897b674db0e8da9884813b363fee3914bf.1770817884.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DB8P191CA0026.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::36) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA3PR11MB7611:EE_
X-MS-Office365-Filtering-Correlation-Id: cd65d3ec-790b-464c-6a62-08de6d7e0dc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j2MohPEKgQAZ3PJ5D8vlslXdkRfCllw6mAysZ6vZO3iZeHsMY7iC62+uB8Ki?=
 =?us-ascii?Q?g512ID0tVzHvj3qx11ZmilO24mUmjjjerKrTe3yU3A1EFgBkRMbCC2CPH7MO?=
 =?us-ascii?Q?OOXwyUeXmXIdIrz/rq995Y0ihS1A/KU+K8QgfQz495vX6TcJM8d2P+/gH8ny?=
 =?us-ascii?Q?JD8a8hVP+v1ISFe9ryjEkpwtz8Vp9PKxxK2iMOMCciRuiMkCzDDig4z39gPe?=
 =?us-ascii?Q?n6SsZODHFrSPwQ0RRUhOGWNouLA6CEMAn72nzohdKIacZy37eotZIE2+NZZ7?=
 =?us-ascii?Q?fWe8zbrlMFyDqIW1l5O0VDcZ1gY7KehahDf+CLrSEva1uWIhD+kS+zcqqD4/?=
 =?us-ascii?Q?H0e06qVAbgOIVblTU+gYIeQ4qEIiPR+7Qz5qLbWBeMR1npTV/BrZFnS9H1VT?=
 =?us-ascii?Q?KfM/KqdzSXQ/KOc2BDs/qFuTzmG6GJV/saKFewtwudwXPNMLWVNU+AyCyO1f?=
 =?us-ascii?Q?y13hztS5vlGAqJ2i753+xxuG+x2Uc1t3yv/1HOeVwz6iRRQ1AzzNNBFhChvR?=
 =?us-ascii?Q?U3SPHO4ABU9foL1lgPEvS8FWxOo4iKPt/ZtCkO0GW/vbiRrJVa60e86V793J?=
 =?us-ascii?Q?6FMW+O3LUWfbACvzvHtiMtLRhnZGwFh7pHipvUffzEvipMxDHfxKTF+7O3lv?=
 =?us-ascii?Q?DF91XD0QJcLYPkgOCw3fz1sJoluTQxAxMyq5hD5rH5UPR9jiv1N8NI9VVuP7?=
 =?us-ascii?Q?7DSoUoXMTcdnwC6WPG6snSqd5p6kDpqWNYS1TEQmw5Yiq8+pKp6Bc4qKfi+0?=
 =?us-ascii?Q?mOk+cYBvbf1ET/vWAZ+reXl2pWdh4WJxNZWBkxI4r9eQC2gP19X5O7/M4vzW?=
 =?us-ascii?Q?JO9xBEeJO8BaO+6XLZsshuKixEOQLA8tIKhBB+Ovlg+ZpWBYJAny8PSSGtHp?=
 =?us-ascii?Q?f5klILt9NmbemLZsGI9p3dMQTwbSoNWfT+iCw9AfDe+PmmGHwWIA8lXNB39z?=
 =?us-ascii?Q?g1LyFPnaL8TkB1rs532TI/Spx14lXb1HhXeYd7+SHoDSmKO1yXk+t8Fot30H?=
 =?us-ascii?Q?ZRooYTZBGB5Cp1Ou3f39vJIntKVMTcz5SmR4+ftu/YsJx69/Lx2O0iDXg7U2?=
 =?us-ascii?Q?QoQ+iCFBvclseldcKVBMwz77dWsFlJzWIGHP5ynno77cvFE5scpucjnYdIrg?=
 =?us-ascii?Q?69ieeRn+UcBW06EcAYp2RnYX0QgDqxcOrzUlVh2ar37mZ5dhz9L7bVMleYDx?=
 =?us-ascii?Q?bqaAz1X66YWDnA7fMez+qvXzJa8ZwVtCryXHCET8Q7Hg5EsqNfPD/xbswkIV?=
 =?us-ascii?Q?j66in41awNz+qePEw2G8xrQ0LBQyQakzKHOr82ZoKs4n/ggZwhB/D9sy9wIV?=
 =?us-ascii?Q?FnktkiH9QRBlMrxLkgDK6kXlfVSKN5rRs5406QcN5KpdohcRYOmcbbG9caza?=
 =?us-ascii?Q?1WmxtVR39dplZphtBxD4FGgNd7WTAJlDcMgUZXcLzVJGy7F3MzVyh5LoQNcd?=
 =?us-ascii?Q?maay+kGte4EJnm/JNgHT0tchjpZosiGwbI0/OxxxoHuyZ8RYzAthj2UVAJUi?=
 =?us-ascii?Q?BiBvItw5lSS9oTPr9buOFzx5cFIDbKLkynDj+JhrCDTeMzuqV4wZiJsrsjdI?=
 =?us-ascii?Q?k3jHpmMyggSQB5qdqhg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VsWcr4/8MKKx52hPxenhiHvqpgDA5hAOGeUsSsE83xoQIP83bdxhyWmNgB8C?=
 =?us-ascii?Q?jvBOxgFbdCI3rAGumOsDtYcRVh/SlSxSmJzgKkGKG8VjUScrceMAGRhKTA6b?=
 =?us-ascii?Q?wGd11I3qgsFNckLGSiKhXSowgrt5KAyNTgEJxswlNPk/KXbvLzhaA35NKfST?=
 =?us-ascii?Q?cLW9PJLkBsTGknyjOnIFi52a7cTmRfLIKGFi6Y18vsG13W6z874+ZQeRMbzO?=
 =?us-ascii?Q?S5xBXrQVb/Kr5489doZbHxklP30i6ffc2rs51iIBmjOgAYAiSw+emUd16Wzc?=
 =?us-ascii?Q?8vQbEuvkvGZgnEkFu4e/Umw2qi7ycCPYRJIF51LnXTgJgjiDFoaQF2QebzcA?=
 =?us-ascii?Q?Zv/gHDMoicRgqtP96SymyhZvggsOWTG0sbGLGtu/Cf3w+zwU0jQM6uarU2FY?=
 =?us-ascii?Q?oSxIJaDe0t8NufrYgXf74Kmn6XlGt7ooEGbHraPwOfouJ/2TCbBRP1D/ZX6c?=
 =?us-ascii?Q?xt9Z6m1kxHPptWwQDSBo+LaaZcKh0eW0LTHdiRiX+nuPt8cHQxjd0ZJZC92M?=
 =?us-ascii?Q?VmSSG4iVAIPnPH0Hi3DvLfFfDLwP97RfMnwgcaA/r5Ca3FLKvryi8cIum5cf?=
 =?us-ascii?Q?cNG710zwBJKSgCj4egNYMdiztL03WQbEkXTeQtEM3+C+zHZQRnPHG479h5Xc?=
 =?us-ascii?Q?wYpsgXvHMkTfTAnM8cPdsfhrIwmMHxthYtMna3K5PdCy7cV9CZmdaejVpDIW?=
 =?us-ascii?Q?ajiU+kqJdw38vSHoFvpms6HhYLKSzlMqbOs7mhNPjj852iSG3AXMUnau6w2G?=
 =?us-ascii?Q?ipWb2BffX5qCW2osP/caSK9/qma3ce67Awo/dJBhnsd0Eo4OTN2tU0NarlFZ?=
 =?us-ascii?Q?/zw4WGiHVkLeVq5kl0aZxRYNOuxHqCCq5AG+lseF/8YwX8LtgX8GALcJZ/aZ?=
 =?us-ascii?Q?C71CTBIkslcqByV9TlRrcKOV3qynRKxAOsWAk0BHmvKGFHc0vjfEDcDCeflH?=
 =?us-ascii?Q?nzNRBjB4TumvGLNPRwUJ/dqGmgvOP+BQCDUUpjKNaIKc3zZIGiZC8YKRyxVj?=
 =?us-ascii?Q?FjR6QSGJRrLEV5TBPYzKz2ecflxmE/a1jGX/fwvNrCSpn2WdgDE0qYkb0eJ8?=
 =?us-ascii?Q?yyI/FINdEZBNFQZTwi4WiXJEcqkkqUI7hOaLSILYjYQxZ1WiTzOE0i7Uesae?=
 =?us-ascii?Q?jfGI3uESJ4R3TGryo0Hna+jFJ6rHJZ914MHyAfId1CY14Mfclq+LD1TMY4l6?=
 =?us-ascii?Q?yh1dsBIuEMwxwF6Cldzpgt/zRvgTFADPfXs1FRGA9l+1oXyRHGYD53US3uCH?=
 =?us-ascii?Q?SPOkaDUoy8c9ofPxX8JymhR2Ua/gDVFjsMZ3bzhyTZIj50h6C80atDU8upbo?=
 =?us-ascii?Q?N4M5Ukca4KAWqemWvQlzeL9HDNvtrD7qA4oLQfsKSyXICSDajYsDyhdOfB5x?=
 =?us-ascii?Q?AW+Y/Eoi0YE1wWsr0h6YBKONgEgE2NpHOt5XMGDyKOnjQsOpq53CNA4aijaM?=
 =?us-ascii?Q?J6Bn0bEzAv33uZyM5l8XfvW53/sLhevNs6onmlg1teJp51zIWxjBqEgflES/?=
 =?us-ascii?Q?eoAV3svgzS//mVYVXLk0Kfvweuf2UhmtGfCkPPw7agruUccH6UABOWBmo/xm?=
 =?us-ascii?Q?flC5mFxWO2PKFJtnblgbmR1QDVxc2kv78CVd2QypZY+FFs/V5jBd4pcGLLIr?=
 =?us-ascii?Q?gfUWMS4lDZRqIWs3MyuoA3cwTo9aQmErNonM8zUiKUPxXYKo/RjCjww6fZW5?=
 =?us-ascii?Q?/QEEgA4m69nyayAGHixohKYd+xnZEjF88X3ccaVjral9mkARCiuC/BEjgkUH?=
 =?us-ascii?Q?S/ooDDZDx05oo9vzxpFpJHpQfYkc/QE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd65d3ec-790b-464c-6a62-08de6d7e0dc5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 17:08:49.9278 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Daahyh1M7go9pfkorNg0Q9rXTVhlZlUqtzeE6NZ6CtcQXYfJ/z2LvQXQayGgmx16PvmyQR1lXUU6UZHiKCLJI0a77ThcFH1gGraVppo4kRM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7611
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

On Wed, Feb 11, 2026 at 01:52:53PM +0000, Anatoly Burakov wrote:
> Currently, when adding, removing, or configuring MAC and VLAN filters,
> we are using rte_zmalloc followed by an immediate rte_free. This is not
> needed as this memory is not being stored anywhere, so replace it with
> regular malloc/free.

A minor nit on a number of these patches and the commit logs. I suggest
expanding on the "not being stored anywhere" part to instead say that the
memory is a temporary scratchpad and so does not need to be in DPDK
hugepage memory.

For the code though:
Acked-by: Bruce Richardson <bruce.richardson@intel.com>


> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/i40e/i40e_ethdev.c  | 38 +++++++++++++--------------
>  drivers/net/intel/i40e/rte_pmd_i40e.c | 16 +++++------
>  2 files changed, 26 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
> index 654b0e5d16..806c29368c 100644
> --- a/drivers/net/intel/i40e/i40e_ethdev.c
> +++ b/drivers/net/intel/i40e/i40e_ethdev.c
> @@ -4165,8 +4165,7 @@ i40e_vlan_offload_set(struct rte_eth_dev *dev, int mask)
>  	if (mask & RTE_ETH_VLAN_EXTEND_MASK) {
>  		i = 0;
>  		num = vsi->mac_num;
> -		mac_filter = rte_zmalloc("mac_filter_info_data",
> -				 num * sizeof(*mac_filter), 0);
> +		mac_filter = calloc(num, sizeof(*mac_filter));
>  		if (mac_filter == NULL) {
>  			PMD_DRV_LOG(ERR, "failed to allocate memory");
>  			return I40E_ERR_NO_MEMORY;
> @@ -4206,7 +4205,7 @@ i40e_vlan_offload_set(struct rte_eth_dev *dev, int mask)
>  			if (ret)
>  				PMD_DRV_LOG(ERR, "i40e vsi add mac fail.");
>  		}
> -		rte_free(mac_filter);
> +		free(mac_filter);
>  	}
>  
>  	if (mask & RTE_ETH_QINQ_STRIP_MASK) {
> @@ -6231,8 +6230,7 @@ i40e_vsi_config_vlan_filter(struct i40e_vsi *vsi, bool on)
>  
>  	num = vsi->mac_num;
>  
> -	mac_filter = rte_zmalloc("mac_filter_info_data",
> -				 num * sizeof(*mac_filter), 0);
> +	mac_filter = calloc(num, sizeof(*mac_filter));
>  	if (mac_filter == NULL) {
>  		PMD_DRV_LOG(ERR, "failed to allocate memory");
>  		return I40E_ERR_NO_MEMORY;
> @@ -6264,7 +6262,7 @@ i40e_vsi_config_vlan_filter(struct i40e_vsi *vsi, bool on)
>  	}
>  
>  DONE:
> -	rte_free(mac_filter);
> +	free(mac_filter);
>  	return ret;
>  }
>  
> @@ -7154,7 +7152,7 @@ i40e_add_macvlan_filters(struct i40e_vsi *vsi,
>  	ele_num = hw->aq.asq_buf_size / sizeof(*req_list);
>  	ele_buff_size = hw->aq.asq_buf_size;
>  
> -	req_list = rte_zmalloc("macvlan_add", ele_buff_size, 0);
> +	req_list = calloc(1, ele_buff_size);
>  	if (req_list == NULL) {
>  		PMD_DRV_LOG(ERR, "Fail to allocate memory");
>  		return I40E_ERR_NO_MEMORY;
> @@ -7207,7 +7205,7 @@ i40e_add_macvlan_filters(struct i40e_vsi *vsi,
>  	} while (num < total);
>  
>  DONE:
> -	rte_free(req_list);
> +	free(req_list);
>  	return ret;
>  }
>  
> @@ -7230,7 +7228,7 @@ i40e_remove_macvlan_filters(struct i40e_vsi *vsi,
>  	ele_num = hw->aq.asq_buf_size / sizeof(*req_list);
>  	ele_buff_size = hw->aq.asq_buf_size;
>  
> -	req_list = rte_zmalloc("macvlan_remove", ele_buff_size, 0);
> +	req_list = calloc(1, ele_buff_size);
>  	if (req_list == NULL) {
>  		PMD_DRV_LOG(ERR, "Fail to allocate memory");
>  		return I40E_ERR_NO_MEMORY;
> @@ -7286,7 +7284,7 @@ i40e_remove_macvlan_filters(struct i40e_vsi *vsi,
>  	} while (num < total);
>  
>  DONE:
> -	rte_free(req_list);
> +	free(req_list);
>  	return ret;
>  }
>  
> @@ -7455,7 +7453,7 @@ i40e_vsi_remove_all_macvlan_filter(struct i40e_vsi *vsi)
>  	else
>  		num = vsi->mac_num * vsi->vlan_num;
>  
> -	mv_f = rte_zmalloc("macvlan_data", num * sizeof(*mv_f), 0);
> +	mv_f = calloc(num, sizeof(*mv_f));
>  	if (mv_f == NULL) {
>  		PMD_DRV_LOG(ERR, "failed to allocate memory");
>  		return I40E_ERR_NO_MEMORY;
> @@ -7484,7 +7482,7 @@ i40e_vsi_remove_all_macvlan_filter(struct i40e_vsi *vsi)
>  
>  	ret = i40e_remove_macvlan_filters(vsi, mv_f, num);
>  DONE:
> -	rte_free(mv_f);
> +	free(mv_f);
>  
>  	return ret;
>  }
> @@ -7510,7 +7508,7 @@ i40e_vsi_add_vlan(struct i40e_vsi *vsi, uint16_t vlan)
>  		return I40E_ERR_PARAM;
>  	}
>  
> -	mv_f = rte_zmalloc("macvlan_data", mac_num * sizeof(*mv_f), 0);
> +	mv_f = calloc(mac_num, sizeof(*mv_f));
>  
>  	if (mv_f == NULL) {
>  		PMD_DRV_LOG(ERR, "failed to allocate memory");
> @@ -7532,7 +7530,7 @@ i40e_vsi_add_vlan(struct i40e_vsi *vsi, uint16_t vlan)
>  	vsi->vlan_num++;
>  	ret = I40E_SUCCESS;
>  DONE:
> -	rte_free(mv_f);
> +	free(mv_f);
>  	return ret;
>  }
>  
> @@ -7561,7 +7559,7 @@ i40e_vsi_delete_vlan(struct i40e_vsi *vsi, uint16_t vlan)
>  		return I40E_ERR_PARAM;
>  	}
>  
> -	mv_f = rte_zmalloc("macvlan_data", mac_num * sizeof(*mv_f), 0);
> +	mv_f = calloc(mac_num, sizeof(*mv_f));
>  
>  	if (mv_f == NULL) {
>  		PMD_DRV_LOG(ERR, "failed to allocate memory");
> @@ -7594,7 +7592,7 @@ i40e_vsi_delete_vlan(struct i40e_vsi *vsi, uint16_t vlan)
>  	vsi->vlan_num--;
>  	ret = I40E_SUCCESS;
>  DONE:
> -	rte_free(mv_f);
> +	free(mv_f);
>  	return ret;
>  }
>  
> @@ -7626,7 +7624,7 @@ i40e_vsi_add_mac(struct i40e_vsi *vsi, struct i40e_mac_filter_info *mac_filter)
>  			mac_filter->filter_type == I40E_MAC_HASH_MATCH)
>  		vlan_num = 1;
>  
> -	mv_f = rte_zmalloc("macvlan_data", vlan_num * sizeof(*mv_f), 0);
> +	mv_f = calloc(vlan_num, sizeof(*mv_f));
>  	if (mv_f == NULL) {
>  		PMD_DRV_LOG(ERR, "failed to allocate memory");
>  		return I40E_ERR_NO_MEMORY;
> @@ -7665,7 +7663,7 @@ i40e_vsi_add_mac(struct i40e_vsi *vsi, struct i40e_mac_filter_info *mac_filter)
>  
>  	ret = I40E_SUCCESS;
>  DONE:
> -	rte_free(mv_f);
> +	free(mv_f);
>  
>  	return ret;
>  }
> @@ -7696,7 +7694,7 @@ i40e_vsi_delete_mac(struct i40e_vsi *vsi, struct rte_ether_addr *addr)
>  			filter_type == I40E_MAC_HASH_MATCH)
>  		vlan_num = 1;
>  
> -	mv_f = rte_zmalloc("macvlan_data", vlan_num * sizeof(*mv_f), 0);
> +	mv_f = calloc(vlan_num, sizeof(*mv_f));
>  	if (mv_f == NULL) {
>  		PMD_DRV_LOG(ERR, "failed to allocate memory");
>  		return I40E_ERR_NO_MEMORY;
> @@ -7725,7 +7723,7 @@ i40e_vsi_delete_mac(struct i40e_vsi *vsi, struct rte_ether_addr *addr)
>  
>  	ret = I40E_SUCCESS;
>  DONE:
> -	rte_free(mv_f);
> +	free(mv_f);
>  	return ret;
>  }
>  
> diff --git a/drivers/net/intel/i40e/rte_pmd_i40e.c b/drivers/net/intel/i40e/rte_pmd_i40e.c
> index a358f68bc5..fb73fa924f 100644
> --- a/drivers/net/intel/i40e/rte_pmd_i40e.c
> +++ b/drivers/net/intel/i40e/rte_pmd_i40e.c
> @@ -233,7 +233,7 @@ i40e_vsi_rm_mac_filter(struct i40e_vsi *vsi)
>  			   filter_type == I40E_MAC_HASH_MATCH)
>  			vlan_num = 1;
>  
> -		mv_f = rte_zmalloc("macvlan_data", vlan_num * sizeof(*mv_f), 0);
> +		mv_f = calloc(vlan_num, sizeof(*mv_f));
>  		if (!mv_f) {
>  			PMD_DRV_LOG(ERR, "failed to allocate memory");
>  			return I40E_ERR_NO_MEMORY;
> @@ -250,18 +250,18 @@ i40e_vsi_rm_mac_filter(struct i40e_vsi *vsi)
>  			ret = i40e_find_all_vlan_for_mac(vsi, mv_f, vlan_num,
>  							 &f->mac_info.mac_addr);
>  			if (ret != I40E_SUCCESS) {
> -				rte_free(mv_f);
> +				free(mv_f);
>  				return ret;
>  			}
>  		}
>  
>  		ret = i40e_remove_macvlan_filters(vsi, mv_f, vlan_num);
>  		if (ret != I40E_SUCCESS) {
> -			rte_free(mv_f);
> +			free(mv_f);
>  			return ret;
>  		}
>  
> -		rte_free(mv_f);
> +		free(mv_f);
>  		ret = I40E_SUCCESS;
>  	}
>  
> @@ -294,7 +294,7 @@ i40e_vsi_restore_mac_filter(struct i40e_vsi *vsi)
>  			   f->mac_info.filter_type == I40E_MAC_HASH_MATCH)
>  			vlan_num = 1;
>  
> -		mv_f = rte_zmalloc("macvlan_data", vlan_num * sizeof(*mv_f), 0);
> +		mv_f = calloc(vlan_num, sizeof(*mv_f));
>  		if (!mv_f) {
>  			PMD_DRV_LOG(ERR, "failed to allocate memory");
>  			return I40E_ERR_NO_MEMORY;
> @@ -312,18 +312,18 @@ i40e_vsi_restore_mac_filter(struct i40e_vsi *vsi)
>  			ret = i40e_find_all_vlan_for_mac(vsi, mv_f, vlan_num,
>  							 &f->mac_info.mac_addr);
>  			if (ret != I40E_SUCCESS) {
> -				rte_free(mv_f);
> +				free(mv_f);
>  				return ret;
>  			}
>  		}
>  
>  		ret = i40e_add_macvlan_filters(vsi, mv_f, vlan_num);
>  		if (ret != I40E_SUCCESS) {
> -			rte_free(mv_f);
> +			free(mv_f);
>  			return ret;
>  		}
>  
> -		rte_free(mv_f);
> +		free(mv_f);
>  		ret = I40E_SUCCESS;
>  	}
>  
> -- 
> 2.47.3
> 
