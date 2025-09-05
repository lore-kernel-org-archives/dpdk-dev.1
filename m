Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B781FCA1010
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Sep 2025 16:13:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 935EE402E7;
	Fri,  5 Sep 2025 18:13:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id D6531402E5
 for <dev@dpdk.org>; Fri,  5 Sep 2025 18:13:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757088809; x=1788624809;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=pFDy+2/eRQmCt6hCsCxiltO/H3ceL+jjwKs9udXtRss=;
 b=Fky+36bJ0HeELSQopraGyAXaHsomgVh7WR3ys7xOcEXfcIZdqhviDM41
 aef4EajFWZUljJZ1/PVt87smhZQVnqe3xXSwVoMr1KNWCFCULzgiDABhF
 9LUA27mJo0ZxIgfZ9XG/CzIygLjYM0qV6MABsv6BRwTX2B6ucpjOQcq0i
 vL6NbT4LuiLoS6X3iyPLiSEi3qacznIvxseNOCUR08Aivhn+a3GCoYAsp
 ptGVyoy/jrRB5snjNEEnJDIV3mFBaE3XU/3RSxldX+ziGP90Q1rx4ZdnW
 v5sQJrUuI5IpNjIdp8ncccaLvk3LNPrHMblnzmYXW3cTnlV+ejLf52+9r g==;
X-CSE-ConnectionGUID: o2832Xr4QJKc1TKfJ2dwaw==
X-CSE-MsgGUID: LlFRkeEGRB6CP8j/4LbIRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="62074598"
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; d="scan'208";a="62074598"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Sep 2025 09:13:28 -0700
X-CSE-ConnectionGUID: 8zvO4ifrTH2EzZWIhPk5Jw==
X-CSE-MsgGUID: UrZu60s/TlmRdX9UFHs0tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; d="scan'208";a="209368277"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Sep 2025 09:13:28 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 09:13:27 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Sep 2025 09:13:27 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.72)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 09:13:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qk74OzAefqfB1nIYSqNdgGqh6eX0y0kO4bSf9BJXAz3ugQzjmmPwW3eAo3lmC/OIVdwKipA571mvKCmgGlKCioUriGrLxOUfWlbknObKONnmrmQzPloGptyscVFLGBkvk1/AhcEPoYMTqCJNOTDyTs3sBoqOBryS/RJooOi4AMKxCgeCx2jU9QjYlXEkG0tlfW9hFdrc/s0Lzo1XUQ55icC3Vfq3GX1q3/q2uqH0PI3P/1ibEeLMr3z0cuzWX/TELirrskP3banpE/Oh0zucdaOneZxmourvJVHRQPejnl5UJhkatolmFFA0YczyWy4H+7ToMy7sEuq0Y3x9vSqaLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXnf+CpdQzWht2NoZGGIxI+CLkumN36WYg9knC8JOvs=;
 b=mY65Lx8Vnf68oCmcbTW1mcqDokukJUfwQkKUsji1s/zibVQKVv0uHTZRFnneh59qg/hxn0jlMG1pIpwLezUDWSVUc5qapwIoltrZGaK3zLlbtS3HH28uwhfzuSugzoU+eTOt315yDPQ2R1F0g2mamBlvkEZtwJjNdHTlhtT+lB+D3GJplnTpbZVC/gZdXzU01X1vUBNVgeaoMEmtRnCDRi4HIO4B80wxjLzQq0ImRmpGHInzOoc9fwmgDXpMR44nfskq7jG1ipObcbh/ADELcJ7WoZDRVS1UccRBPVnR0CS82hsFE3JSUKUS72PmaWLAkeAUjb9kOWkun/6euJbC4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB8433.namprd11.prod.outlook.com (2603:10b6:610:168::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 16:13:22 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9094.016; Fri, 5 Sep 2025
 16:13:22 +0000
Date: Fri, 5 Sep 2025 17:13:17 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v1 10/12] net/ice: count drop-all filter stats in Rx stats
Message-ID: <aLsMHUeRKhiRP-ss@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1756833701.git.anatoly.burakov@intel.com>
 <8b65313e9b85aa1a27e429c5dfbc2875d0ab724d.1756833701.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8b65313e9b85aa1a27e429c5dfbc2875d0ab724d.1756833701.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DB7PR05CA0006.eurprd05.prod.outlook.com
 (2603:10a6:10:36::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB8433:EE_
X-MS-Office365-Filtering-Correlation-Id: 584d3439-2b7e-4d8c-a689-08ddec9722d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mdR23TaAflsZPPl6Dedt/BFUN4xSHMC2EhG719IM6jd7Jac6a9wCtoelLfEt?=
 =?us-ascii?Q?iDWUprCZW5agk8gbQRyKcGrm6Cs75w5qJBRzbyJi2KTbYbqiVIw/MUxpCzZV?=
 =?us-ascii?Q?Fg8OJ5Kio9lyCf6Wq5c69HXEPTPZww2Jt0wELtlFP19GKHfa1TAisGvlpfW1?=
 =?us-ascii?Q?qk3X2e1IHymJsen502rsFwfhGpsGwjNKq4XqzdOfGbWpSQMfaee2YFoLT6WS?=
 =?us-ascii?Q?DK1Pb+idnlHfewEqeoqix5KQOS+7KsTRaB3zehIxyI4MHsQ1JxjRD1x9GlnA?=
 =?us-ascii?Q?JRwFPAEhRlfRi3ag89Lk1noha1+dcq8xUOBVVfA+2AK9MPJ112vejuwvln0v?=
 =?us-ascii?Q?QIpP+/y2v8RkMG1TTgVxpqBSz/Ku42JPGWcMq9CtwItSHoD0vcRhv8Uqt/yp?=
 =?us-ascii?Q?N3CZjnhyRwlOkiy9fwYah2a6z978rph06y3y6n1MdfpSQk1wuBt+hvOkIiPR?=
 =?us-ascii?Q?MN44akgorbVZasjY+xlkH5T5Qsg+CIkt6DdidSbV5ifOEGnTniD0iGlYLOq8?=
 =?us-ascii?Q?VgKu+OI1VS+riNE2xKIa6y1Q88edI862oSmUiKkQ3YyhPNJ7U4pbWqUfBdxu?=
 =?us-ascii?Q?cjwUjRDKhS/JaqRcNI/UeXnwguQ3kYUYzVlg18FGvs2bjQpYR/xJZNMPL3wO?=
 =?us-ascii?Q?93HUUboV3oTfUFYFnUUeZMTNsMMXY6duWl7yzTmdVhmuiB31giDQI8UzwOPW?=
 =?us-ascii?Q?tBlGLjqyEJNr3A61LowH6KIH+X7X08VKd1J49/89Ks8nAqzP5/EL3BnN+Ok2?=
 =?us-ascii?Q?2F/j+5/E93KyQS46kM6KVTDBwTIcXPDBy3VCxfpWRd18H2uuIcFZklI5WYu/?=
 =?us-ascii?Q?jA/4rs7RxjmV+Hd0sfaoRNTv9FIK/iaDB9GdHvgrfR9aCj2u1lAdEo/KRVg5?=
 =?us-ascii?Q?KICQ0iWKmXEUg1x5F3EqsffHKzMU6kUGpkvOl8r9SeXcNnr03OO2jSEbHMqu?=
 =?us-ascii?Q?+x3csjDxXeD4ORzwdUGA796wuqPoByHZ9vfWBP6lk3tmBGNUeg05SJLyd7Ks?=
 =?us-ascii?Q?7fD67non6xT/94+zi/FGkhTWWaN8V1CcNCgKv0HzQliPVa0wNzJqcXRL892K?=
 =?us-ascii?Q?jQStZastt9m+k5tCqhapAFy1ThGST8ohDlMqywBlmyzW7GfmSkh0RjUy5zQM?=
 =?us-ascii?Q?lIGQPl2HChmhVlMKTscionrSKzWokML6ynEl0NrPGFWne9GoRiol+2JipdeF?=
 =?us-ascii?Q?mv4ajXyk+oV/hvaQBWEgDCcdf9oRA4QwfvDRImD7T3qJGUL6+WjCC4s84cV+?=
 =?us-ascii?Q?PvhktEGC88mW+vxtOzQedOAPgZzkwF2A65x3ZocEavtXQDXv6xyzaOx7XwpR?=
 =?us-ascii?Q?z8YA/DXC0wOn38KvsEdhDLwsl8P604c4NnnTvKWa+wH3ahfLKxzBmxvTTpHO?=
 =?us-ascii?Q?eriBodWiceXZGfXKJadlFFjDqJtppdjKd48SyCK/d/jrVD6HDanG5dUU6hrI?=
 =?us-ascii?Q?JKph0ZhOVz4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HCN3MbRSIU146IjU9zIZ1PHWEQL+EOrA7maCzSykOwTIqdPn4+PRtS92P0lG?=
 =?us-ascii?Q?5jAHNLpgDFxLezXB10oWfx7xdTrjoubbywu289+pPrqBcjnzFnFDW657c8FG?=
 =?us-ascii?Q?dAEsFCt3oXIcusRRpw1veNOU0Tu8MfjME55mSG22iMgqC6Lz1s4XbBjrayAZ?=
 =?us-ascii?Q?GnZsSxaph4D+1F6WsNNIqGRfJXUQlB8NADf8xedUNGfqIzifeq2n/TTFyPw9?=
 =?us-ascii?Q?nCuGguxyZK/CH7XNFK7MlkglNr9iLP7MdUTHy1ypM+qB6fd7MaOinwsW5v4l?=
 =?us-ascii?Q?xTa4iC1rwf2TkbxQ4x4vGadVV38nsPl3yj+MBvz/n59EMwi9lKacqdXirQIn?=
 =?us-ascii?Q?4qgr3MLhFtpk42B27CfH5Jh5prMa6kkVgPT1T5S5fiySKA/Dqm0jSo2dYCka?=
 =?us-ascii?Q?sIUDXugANu7DpOnupdDFDIoo6wUgknsk4ecOK8jYNEo2g642lC8FZRJuNTY9?=
 =?us-ascii?Q?Vz+XWOTttl5Sw1Bw5/wTggJOwT3CKVsz/dxlbhIPrsq/xVD5xqTwIwfOFDIg?=
 =?us-ascii?Q?cCz5qojHlc6e3/lXh79oR4vLA4s8xpl+rleyzDUqn4CEtiuN+p4ddDBYhs7c?=
 =?us-ascii?Q?r8zBMdG3i16mcz1sy8bJI8nBoyRBE+C7zyTAHOPmnFp62YVabbh94mlZ+Ixw?=
 =?us-ascii?Q?gOBttn+4AqfoRKUajb+1Fj0Cui69U93AZ3jsKUVrwXR0gEcfkdCfDvLiUW5x?=
 =?us-ascii?Q?lTmhsH4mGqYS8jWNijM8F9klzF91/dU3CLsPwNTIEFmc99swTpVx9AnFB+TI?=
 =?us-ascii?Q?+O9xFgl1wUNMwElgFcjsvtKppwoMQ51J3Ox3KeYeOEqDABYDBkOAaMlJZJ2R?=
 =?us-ascii?Q?lZdyci4BvmKjmdlycJgMhv60kXxw5GAMJ0EbECBXSqJLni3DzHmvbTPumKI3?=
 =?us-ascii?Q?+o/fs7Oa+9nnrI+3bqHUQOPDH0ZCr2CMbhZV3185AwB86EqDLIujOe0jkB3Z?=
 =?us-ascii?Q?JVFRqKuJFVHX+pWlFARElTfHyyi1tnbl5HzfB+jKZyP/VPON+TLmrfKrCbK7?=
 =?us-ascii?Q?pY6nIyQqiZCc1Hzqz68hg/xceoQZ0sN9dbMAog7RaCDRuOvqQFvmJA+yK1jp?=
 =?us-ascii?Q?I3scqK9IU47pJMxJ9IYzt7SNG6nTfGZ4nYOrmmDj7LQyA1sTWpo/pTBHPqcZ?=
 =?us-ascii?Q?xN5QZIk8nBk7ihdPdXBAiApaQoFWJpntwpVEGQIAXxVzMXWfkggR8wviVzaE?=
 =?us-ascii?Q?pV6XSP/57eThhmWoklJnuCxaSqSXnxWF4uvjBUrrfoLa5AQUHCqhvdnoCXB8?=
 =?us-ascii?Q?gD/QhoyoFLq64UhdKfiET/JBct1Azf+yOfxhlrrw2VuI2TiT1jeYzmze0Dnz?=
 =?us-ascii?Q?KMz+YoZoeIQzszjJC1bkH94VLLQpz1YYUn8jneigdkRtFosDMiPHx44CQtUF?=
 =?us-ascii?Q?z0HHzWSycNWlQ4u/mMLjkqkXYz18kppY4zpD7abPm5pH2qYZGdXwkkuWhaOu?=
 =?us-ascii?Q?i9NmYF2sDr5j2fZ/OX7RrL9LnAk833FAAdspvD0Oitbn6W02V+OWdmatGF7G?=
 =?us-ascii?Q?VHfNmHsuzEimWzx3awOU6uOm7cw2Jty+DpwJhMLe7bnc3xD/BGVrEudqhExt?=
 =?us-ascii?Q?epAmDt7AiM3nX5akrwUA0QFSCGrBQbKfhdyc/6/FbVlO6A5bdjWCPn0qVedR?=
 =?us-ascii?Q?FA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 584d3439-2b7e-4d8c-a689-08ddec9722d2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 16:13:22.6272 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UCCg8/eC2Xar9lonFNGoiLVDc9czX6tzBtdJcTHwp9EQI2JtqaKa/b5UvlS+E7qmeVFMG3PWTK1xYoTWAAB/Ect1UX837/p+f9EA8L24ZlM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8433
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

On Tue, Sep 02, 2025 at 06:27:00PM +0100, Anatoly Burakov wrote:
> From: Shaiq Wani <shaiq.wani@intel.com>
> 
> Packets dropped in the receive direction are counted as
> "rx_unknown_protocol" (GLSWID_RUPP),these packets need to be added to the
> "ipackets" and the GLV_GORCH/GLV_GORCL counters need to be added to
> rx_bytes.
> 
> Signed-off-by: Jeff Shaw <jeffrey.b.shaw@intel.com>
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/ice/ice_ethdev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

