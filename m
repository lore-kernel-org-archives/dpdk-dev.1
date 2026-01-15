Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F6AD4116E
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Jan 2026 10:55:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED8FD40F1A;
	Thu, 15 Jan 2026 11:55:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 3ECD0406B7;
 Thu, 15 Jan 2026 11:55:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768474546; x=1800010546;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Q0ZhoGx+LpI+EpEo5hhuSGpa9wCLsLqfCoo4s0CLM5Y=;
 b=NDzeNe+lDig6fV4pVDPDeX24ea2q0uBJ+jblVaBT1HSEHaXPHHi02zrq
 RQUQ1xawHjWpSHjlAWLkipfpjg8+VjU76vXn9JJ4MvWQaye1m3ri080Mr
 abrQV1pcYfrptkO9Mg+nG7HVT1syXEkd41yiGhx/nzheMWX30wEVdKH3Z
 LKszYN7AwA5K/LYYJv6ffCH/BrwmENloq3s874jR4K7VXW8VCrnd5tEy9
 vAUIltlU9exzDM+HfRYFtOQ36P2al9fsk1TriTuefjoBDw47wOnVGORM1
 M19DdGrW8clDdygwgOfHvgAix0bwCMPQHrvumudBRKsASDeaTjZhbPAtm Q==;
X-CSE-ConnectionGUID: VeU1qjHNSBGTWdOU0nFzuQ==
X-CSE-MsgGUID: 1wIjda6xSCOqIGNUaBEINA==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69514438"
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; d="scan'208";a="69514438"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2026 02:55:44 -0800
X-CSE-ConnectionGUID: ULcBUv8aSeeAdZwvyDXIfQ==
X-CSE-MsgGUID: KT96Z+GIT2O9KbdC79T4MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; d="scan'208";a="204068017"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2026 02:55:45 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 15 Jan 2026 02:55:43 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 15 Jan 2026 02:55:43 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.52) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 15 Jan 2026 02:55:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WSBND64LxuXdCKWT5dAdJtOupbuvFr3N9nxMXgwtMZvkczscCzoyvhtTtVA/XMXAzearyJvlFokNzZ+SE2iSbDMZ8atxqm0iUqynZTiv3JMLsbjJ0L4BLMt9m9zo9DREebldHRoI8vFOeVo15Zo7CnrFadDgvEdMaMC0D1lkyyyr4DKrw9WMnMQ26keWL+qt5f+hWcPiEs+ifGQUZuRxGuHIbXwwCcEO6KkSCpNvbiIIBRs08oxCXt1kun2UvfQuomP3ok5fNqkb7Gh8GfEub5Sy1aJk0pkg4som2L/5jRxaoZutKK1COAKfwejEjZe2cJLmKh5Jz4FdLCyu1SFzHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2w/P2/LQRjw5w3MfZ9gdbvjn7TiHVVr4WHN68SnLoWs=;
 b=sC/u6i6+4CEcEXoXEkQz99ImwTygFmjUXAepASxAiSXMaEsbiRBvqJwvXgI0pgntey5SXrEIDB1arWWO1DORIUOI5xrU1qRYWlPCv3WsyaWAz9Y9TIennKXw97L8vRvRx8Nz0/EK5jw6OVVXdNUC9bfbxFHc/ZFGZ1vvraoLy9W0BHuNWL36wVPh7EL78PXzjXOnHc6O+9itabHS9rHqTjddfjq9TlazziBGWXMKokHrNZZWDumC39Lr6dwerht232Id8zr96ZXawLLAgqblj7mntpdF8NmhOfI5W7jMXreWi9mKjAn49K06IbxWPKYk3pNTyMyKvU6w2qDiRBQs3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY5PR11MB6317.namprd11.prod.outlook.com (2603:10b6:930:3f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Thu, 15 Jan
 2026 10:55:34 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 10:55:34 +0000
Date: Thu, 15 Jan 2026 10:55:29 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH 2/3] net/ice: fix priority mode printing in Tx scheduler
 dump
Message-ID: <aWjHoTEgFQNHnop_@bricha3-mobl1.ger.corp.intel.com>
References: <20260115103824.1982220-1-ciara.loftus@intel.com>
 <20260115103824.1982220-3-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260115103824.1982220-3-ciara.loftus@intel.com>
X-ClientProxiedBy: DU2PR04CA0204.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::29) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY5PR11MB6317:EE_
X-MS-Office365-Filtering-Correlation-Id: 1551721c-2a85-4385-72ea-08de54249bed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wj4+0QxRpac468zE5jXU0KmDsdQTTEdQ7aE4i39gNmuwHgjKnmTIchE0vn6g?=
 =?us-ascii?Q?905l51oIZSXwdwEG89BSiOYM/jeX39388giC+ymQBUO+yFpTbjYZQw3lkt1k?=
 =?us-ascii?Q?yyGGwcPfT9GBxEZWIsoyro5HUa5aXZQbcDJg3Bigh30R6iBKt0xZe0wOck/B?=
 =?us-ascii?Q?NazNhTKkbt39FyXCYwH0vq/G1jvgfrBriGrTSmcJ/b/eCXnbwAFoVJIj9kJf?=
 =?us-ascii?Q?DAft2tNhtsHNfrVlnJYs5k8ExNOZL4xWbn5NRfKAK0h029Ar0wjQtGchiiNI?=
 =?us-ascii?Q?PfrraNM1JUgiuSIPGqLf0y93Agk10xzU5/Xrh91ckRHQDJzFZ+mSPyYOD9OF?=
 =?us-ascii?Q?W1MhUcr/PN9HEKpHiM9/tY3asr7ShR6PkWkypgPVxREmcwq/XBaeHam51FBe?=
 =?us-ascii?Q?NppozAexfc/VD6h9ua4JHZLzdT2KVuhAtDwW1tqSZi7dMaB50nwEHuvLoi5i?=
 =?us-ascii?Q?B+RF+SmCCgUN4bWtjEyD3PaeI7viQmdDCN7I8vyecu8EwtJ8CvvBNMvojo7A?=
 =?us-ascii?Q?cUHvA4WxclFZ5tR+kHs/cAyoQFGqpfuaQ15/TSi/33K/nNpSYOcAFQTNueX6?=
 =?us-ascii?Q?r11NQU8HGq35hFzyu70ssZGKyvmx+mPSpSGMluDALgbt++Y5VGdm5huAdJI/?=
 =?us-ascii?Q?pbBHuVI1F3u0Nrvl7cXvikTdqEtIjgfhREUULWzdGrAvlSeXRgVwJiqTlfNx?=
 =?us-ascii?Q?xuQ5phG7st1Q5yE8ET4HYYxGmELASFLnQCcZWAooIOl4QlreBDdgfALeFt9u?=
 =?us-ascii?Q?GrAyLF6IXEFRJahAP+DvokRmWpFC+BlwVqbXgrgsQvomWjW9CyEy8seEzxAv?=
 =?us-ascii?Q?gVQ3K6zs1Fqa4NVEKjJWn6CcdCMgNKxAkRlY7RAxHwRifZRUOJdH7LhMSCX3?=
 =?us-ascii?Q?OxRI0+dVUhC2+X6il+BJZboJMuO6EM8b/a+QkRBqCLZ1KqqiYN+XbxuFXGKm?=
 =?us-ascii?Q?Ec0xGt2clvBd0To9yJfOxEMGMN1FClMbzqTfMRtLaob5aiXpEBKJfHGEGAE4?=
 =?us-ascii?Q?OcXg3OGwsODNR+bmdRElrQE35UJbgCsE0mqlb3mtuTopKGFK8qDa9bIGhiD8?=
 =?us-ascii?Q?uMpeihfEBsuwBcX8YQqbuMdH0Bk58Hab/ICr8k7iWjvCUYAdFLDACFXPvtND?=
 =?us-ascii?Q?cb0J+kgsvjBmdxkGKh4keBsMicw54fneRFaYW9/5r1TKes4eLxb0c05WiB3V?=
 =?us-ascii?Q?FoIikKjhmogumzx3Sa+S+seR6kP455xEqJd2ag4kPr+svF16VCPuujHM69XE?=
 =?us-ascii?Q?hJMKZ/VyD/MZzylbr5TaDPgO0uSSqFwC+ZRPyuDpOjbwENCLisDf3U78i/W/?=
 =?us-ascii?Q?EotNhCU4vft9aEf3Bo4DerjGwuoCXyCsNfEdKUho9FeKhMoDjdDpwh9I14zv?=
 =?us-ascii?Q?kos1VjV7rpb6AtlGRKHqMfpG8CBKX881+d7W0mOa7RGNzFk0eG0rBJUXnuof?=
 =?us-ascii?Q?YcFvfNiMB6gtC1FdRCSwuLldQLBiyG8ogDQr/iilggHk9HNlDSJoI6zs4QN5?=
 =?us-ascii?Q?jDy5jJENyoVnm+zbuauxBCRF27GKO7hRgvZegkGkRQKxxZwbj7NgodTNz8tj?=
 =?us-ascii?Q?JDl52kFJVXbnfrfgWoU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EWMhnrapaxYgBLrY8GNX43LAabKx12v6SyT/jZ7J56egcI24vm7saK7yWkbs?=
 =?us-ascii?Q?VYd7hZNfpo93iDBrtaLpvNvgBhmdP4+dvO+glvv6SvhwhOyT/oz+g7AHhUv3?=
 =?us-ascii?Q?u/oXB9XpYhkK9w6y2RmGFdgYKZvHwnSdm/G2RGi8quBKYI5VC1meD04eXngU?=
 =?us-ascii?Q?RBtVLTyDRXZ5KH5AQth8MsFWqwL44vpGIfJTldezeHzc0JS80S2OaKr3rgTH?=
 =?us-ascii?Q?/8rt0QVL5nQ85A/tG5Y5F0CMyGqLXERkg8r2YLDj2C0KrVdhUpSwdp85Dfnh?=
 =?us-ascii?Q?vXFHlT6GcUuRHJDxHzKuqIbTD62L4qJl6975YLM3Nf8lKthCcrGxb9qspgF5?=
 =?us-ascii?Q?xL5EiwE+XV06g2pjZi/oUhtXFgoASnlColKuZIn/KFLP5nc+oXgEQDwFSeLc?=
 =?us-ascii?Q?3yezztbJRDsqQoAa0w2HdYsJVGIij4qL9eJ9IYzzkuEMmUiNHNZbRmtyJ2cy?=
 =?us-ascii?Q?y+IrV/uBLRaPcCnhDvCQOyhiIJHjNtcTxPQUVw8fWfoWM1bXaVaRTTt2Kc7/?=
 =?us-ascii?Q?ho+vbfMWJSa3ke1jXmDPTlKXwvjfypO7TFZIr50fqWj5TWQqtEVuzY5fS5ox?=
 =?us-ascii?Q?WKQyGHzofbuBtcypSe7+tQ/G1K0XXtIIdwSrJSbheCYIwk2CTmLILod3XbJg?=
 =?us-ascii?Q?GSkuYd+4+kbEdxsEXhhPSxYlK6VHSX7D/wE5o+b0b+mt4RupGZDNLaAWjpix?=
 =?us-ascii?Q?R4jbWw/cZJo5OTm/FJwroCWzPRslkhHz7ySfdC793JfAhiOfbTLvh61Qs6xS?=
 =?us-ascii?Q?e0jhMfiT5I2WYwck3xIzzBfQ/do6IHiX39py99PiHJsfPePk/yJlnEw1bPgH?=
 =?us-ascii?Q?V5wsBAC0X6gwkGW1QI0qeFtH9BIUSM5LrNvaPiLO8s81OMdYkcSu1M8PAmiX?=
 =?us-ascii?Q?9cOCkdAanbQy2NVskmlQhSBzCmIaVMsxibiige8XV3rYiiH1P8HApNWe0FBL?=
 =?us-ascii?Q?oLKdUNnJae789AWOThoCqmqu1E35mLPq6QT8V9MpSrDhiaxVta4yQ8CwFwJR?=
 =?us-ascii?Q?VXPMNdVkgHVwNYEvW751Jw1fOjSVi1J1I4gMfUk9kIi2042wgIhWg1tdXbFc?=
 =?us-ascii?Q?+exdrVXdhkjyPbvaqoYlsGjhXIjxkUi4+9Sa1qynikmKHztdUbKNjvNgNUOH?=
 =?us-ascii?Q?jfgCK5pyNc74eSSXBdUd9ZUAhPCKagzDFUrRKHscKQNTKG1whDu3Rc+inNuw?=
 =?us-ascii?Q?ohZeqhlQr4pPr9VD25XJvF+qoG7pRO0lGXmUNDNAf7Utprtluq0uTO3ZP9lF?=
 =?us-ascii?Q?bw4bjWNUumxQVXbFhmsNyfmaGlCwDpC+OkgsK2YgRaaC8jX4o/I/YSogayg8?=
 =?us-ascii?Q?kR7I5e+82XJJXvUtBYfQuXuNJoutuMekrBDWt1oMX3/zwdKgF3FAeW+htz3W?=
 =?us-ascii?Q?8GsLZa5KbM9G1EjDRE8MpUL+2thN+ooWmO3Q72AyqslAVrHyGnflRwaSEnVO?=
 =?us-ascii?Q?MnlYxXlZzgEkYStEJnvJLOyrA9g4eg8sBvNr4bF6IgbQwLa5+9RixiaqOTgb?=
 =?us-ascii?Q?UbgXUMA+zFSYqEvE6FOXjJgQc52eM8VstOaCvXDQAhZzkzfsBxAK2y6f2T1e?=
 =?us-ascii?Q?IhHQjnd3/BTXomqqHPo/XcWoVskeo3jqcTe3HE1VF0aNOykjvDyORz/2kT30?=
 =?us-ascii?Q?FNByUS0daP4H1Q0xSefAyO24s/lXgkJRhdfQTe12jvcPZ5SozkCUGmT2mY8W?=
 =?us-ascii?Q?K/3FjlK8BLcSPhCYR5vw8Uer/K/CgoTTaHj5O+WfOMpPdDBtNfNOkPNdhH65?=
 =?us-ascii?Q?dtDatjktb00fHRa6UREqqwgzmFoM1ow=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1551721c-2a85-4385-72ea-08de54249bed
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 10:55:34.6690 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TkbPJB1T620bC/qJuxP9duqmMitIrBaQNc7FNMhxUiFylAi5S0OmMpCkY70hZ3muFP5qZU9VvvtGOX5zJH6r+uDDw0TW3+08I2ABWSNkcbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6317
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

On Thu, Jan 15, 2026 at 10:38:22AM +0000, Ciara Loftus wrote:
> A value of zero in bit 4 of the generic data means that strict priority
> is enabled. Prior to this commit it was being interpreted as WFQ being
> enabled. Fix this.
> 
> Fixes: ab4eaf9a8a31 ("net/ice: dump Tx scheduling tree")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---

The relevant masks and defines are in some way badly named since the field
is therefore for enabling WFQ rather than Strict Priority. Running an AI
analysis of this block returns that the code is correct because it assumes
that the SP bit being enabled means that strict-priority is enabled (where
in datasheet the SP stands for Single Priority!)

Anyway, after checking datasheet agree fix is correct.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>


>  drivers/net/intel/ice/ice_diagnose.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/intel/ice/ice_diagnose.c b/drivers/net/intel/ice/ice_diagnose.c
> index 298d1eda5c..a58279a116 100644
> --- a/drivers/net/intel/ice/ice_diagnose.c
> +++ b/drivers/net/intel/ice/ice_diagnose.c
> @@ -641,7 +641,7 @@ void print_node(const struct rte_eth_dev_data *ethdata,
>  	fprintf(stream, "\t\t\t\t<tr>\n");
>  	fprintf(stream, "\t\t\t\t\t<td> priority mode</td>\n");
>  	fprintf(stream, "\t\t\t\t\t<td>");
> -	print_priority_mode(stream, ((data->data.generic >> 4) & 0x1) != 0);
> +	print_priority_mode(stream, ((data->data.generic >> 4) & 0x1) == 0);
>  	fprintf(stream,	"</td>\n");
>  	fprintf(stream, "\t\t\t\t</tr>\n");
>  
> -- 
> 2.43.0
> 
