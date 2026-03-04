Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1BBEB7EB2
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Mar 2026 09:53:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F462402E4;
	Wed,  4 Mar 2026 10:53:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 2219A402A9
 for <dev@dpdk.org>; Wed,  4 Mar 2026 10:53:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772618003; x=1804154003;
 h=date:from:to:subject:message-id:references:in-reply-to:
 mime-version; bh=0MFNKeI3hK/RjHpwYavAwyyE6NZtp0bYZWdGBz19x0s=;
 b=iYzG5tPt1BQ+rrOPxejUiTEmcd2H18j5GugjmsBaqRkJaCsysfWxTe42
 NqyFlF7BirHW/9g9bg2OSEXAZXjjftuqQ+AhJQgZ84xFvkhcUt4+ShQPb
 QDH8hOO+jx/T+XMydFLHL/5OkGosrypV48zLPgkWxBbTO45Ku9o8zFjUO
 sKwWgIJzF6ha3LaSZu8OHypfYPa8aK5hlfeSoFj/7SGX2WXVn/qIJ3x6s
 UFTxThRP6quTd1cyUbFxUcuxeJUSEPdevIGgVkcEr1vGiwCuZifD0znd9
 uY9F75UPysDbPYKwmmQrnmvYL/87U4wf0TE12Q2QIHffHx8Qa4spv2zVn g==;
X-CSE-ConnectionGUID: bibebNW/Q+mimVl6uhOVXg==
X-CSE-MsgGUID: 0AegTQeHS++d+qh1y5eNCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="77543685"
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; d="scan'208";a="77543685"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2026 01:53:21 -0800
X-CSE-ConnectionGUID: IPDXOu/kTzeKGEdBZbfHXg==
X-CSE-MsgGUID: 8p27klCFQPSxbmwDhi9/Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; d="scan'208";a="218257782"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2026 01:53:21 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 01:53:20 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 4 Mar 2026 01:53:20 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.41) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 01:53:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LuiMp2BSQNQzx+h5kYPbTP5PYtyjrc9zEBCSg8BhwvAtMPJpeAA0/1fF+8wXLw0lFAR3LTUPsAfZZ2c6Grvqwgb3GjcagdFHASBwuGYgRVIIW7Oc5w98HcrQ/WRL2uJvumRNJaC2AhWg2IuHnNWt/uIe0vIPeiNSm0U007qnE+FSmhXiGUdLcBiS1ZEuplqh9xA/Fv6wvcg7HcoDr2bFU4Bx5qAwrYo1mTx+b1Ys3pv2yceai2lyRz27kFjxGfwqMwMuwnrOW+ZfAKH2x+pONYxMhMh6GpdEnTVH5lnac3UPgLKSjFA8RTmVpdzWc/bvFgdJtkmdqQJ/Gza3h+48Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mH4IObG1HUxpRiEXksVsivz2PPQI2zaVxIGCYOTKaPo=;
 b=ZNSewWo7Cpv24eW53HGlpE7emUW/7AGHsrRuy3Tb2P0k/C5x6JMoO9jzSSplHnnPo7gx/kW0b7YbS5Bxl5iNrtVDAzmnRuz9QXb3/KpoTKjKyWDZFhrH5QnuYfsmT9Q/kniJfTS8RQFxsiUITn+b+TS3Kre3QQIuPdHBWUVv/xCyKIK3EfyTkyiPFiH036tLYr2AbJ+s98m6HkPs8QyhMYsQDWwg7Y5C4SoU38SlrPc+pigTo/EF7zEva7tfT5M8fmUQZfP5Uyu43Ovf4pCdOwFTyUQw0oQQ5VHyDioZA3XNfv3l5JrMycJ4Otsug2xUh/mqjSGL94HAtNv8YbApuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by SJ0PR11MB5022.namprd11.prod.outlook.com (2603:10b6:a03:2d7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 09:53:12 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1%5]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 09:53:12 +0000
Date: Wed, 4 Mar 2026 09:53:06 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
Subject: Re: [PATCH] net/idpf: handle Tx of mbuf segments larger than 16k
Message-ID: <aagBAodZv-ydq22U@bricha3-mobl1.ger.corp.intel.com>
References: <20260303150026.1601461-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260303150026.1601461-1-bruce.richardson@intel.com>
X-ClientProxiedBy: DU2P251CA0002.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::11) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|SJ0PR11MB5022:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dffe0e9-a0bf-4a39-5580-08de79d3d896
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: yNrstr5TpDf+4mL0XynxTUfD6rvFcXneOf/XEs7Dzc+xhVq9teX7VxPTdN0wt7AAZKJcHFhrFRGQW/wBzC3aOOYw7xlJKZ4EXZsVjyqOUq8RDOm0UnM/uK/NGiIOmVkhenJ6B+ZDcYKpynBYFPtXV+qg7uFAb2BGkv7HXFVYH6LeEoaNf8a8wNfi8lcV2zr1w/dk9KCp7dNB8gh3bumExk7q+5BOIBzAmsprwQuWSgVTj+wpvv1hLugu3PpZ6b38tFN4jU+2DKF6KXRCYA8f11URbBIkDLmgD7cGkcSuVsFzOj5UYluM0zcpiqr9DU4nsEpIP/dByXV+Z0KMVAljFHOekukC7OXoff/7VXhjHyBm5eJXG3TMMOnBZtHx1U9fScDRTIu+eC6nk9Vw9ZxFkYOGSPZvul5Kt87vLJAoOGdUiMiGhQGFRrtuqgF4FckSzO27kncfvUp6Z6orKD0iCKaKenjhvgMQyCaOErdm5pQ+ABOAnxF5lHwT5jZLQlqpDkLWo0S/lCpbBrF5XNZe6B8OIkK/u0XW7P9USdUjJgWkAXzeogKzCPaJG5Th/z6Q3mQnCG11CUehI32mHTkUvhNwtRBYjeQ00rU5Xli3QNYLMT0SaOYKr6LEY6pqM8R4QXRkvALc2+KmvhoK/+v98NYilrCQjy4m4Y+3+OQM6N8+diI+VgfsV6Z7lRMazrrg18dZik1h5eTCtBW3Q4qTDsHzcqudpCy3H0N76q/ohGQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/rbBOwUay620WXuvKf2L6Io2qocXhQ7Ka7oAjBvEz3luTMxgi9vrO41yPL95?=
 =?us-ascii?Q?8b5aramFtuo+R+knpE2OJH4d994O2+s8nDeH12FgphtgyJ7Dkcw98DIwheNb?=
 =?us-ascii?Q?DsoP1ZH8cXF3mHk9DlN8Xo/FWppbeWMLUkmWR0C9faPSCX2U2bhSyeUCk+Fs?=
 =?us-ascii?Q?vVXKIyPPFgpL7EOTTdA8SzCb+DZ8rDccLi26T3w4xBBzfLbxpRyl1Zpg3NUU?=
 =?us-ascii?Q?oes4xbGaHZ8o/Caj/wIAl77gT2yDzlY133kQVhImykG3hioO/TfJo47X/8pE?=
 =?us-ascii?Q?I3xksQXqptNXLlEAeClw7aAPygOShXcPkGZS8BKXmUivZPeeNY8X1bKw+BRF?=
 =?us-ascii?Q?jmOkA7dbfUCakRh8uQVnQmXj7kUgo1neFSfirSVnIojm3yVylD6nnY9gH4rq?=
 =?us-ascii?Q?jjswQUsmDZ7AP8BFj2uqvMR3tYdRNpSghaDQHNPIyCH2U4Vumaa83a5p/aLe?=
 =?us-ascii?Q?Z2aBg66VYDldTwGJJBWjTllYpv/i+fKyjM6xdPV3ZkfpQaGqikV2Jo3iYXmC?=
 =?us-ascii?Q?H+mvbaEJMGcbvGHd5wMuxWVGQt0qzKJPefrnWFY1Bl/0kaU0y1a0qNoGriks?=
 =?us-ascii?Q?Z2gOPjdzc3TOeOnD0t6oxRMu7k996NBnfhzoSTT5VT6RNDjaRlqumTZtO90i?=
 =?us-ascii?Q?ciZ7GLQHTV4Wp2iVyxAwU97QkwFKEz/6oQHtRoJKQZJUqpZhEcHkPDFsRGs3?=
 =?us-ascii?Q?4R6uYFM27qV5clwoxiQBbJ/SfcCyy9XkLjJAFF4sehILApj/QQguUJngyQkv?=
 =?us-ascii?Q?LeeHxM0uqNIlnhXCFyI8BTK2hlUYszqXnEXvhspCr57Rgbic1d5XiWa8gAMa?=
 =?us-ascii?Q?p+idmaC4kUWHUvgd84iTTQhrcyn5wevW0E444PozkiUE//O1wkeNxSyFWQgf?=
 =?us-ascii?Q?+hZgrTde8uuv2XcCw9hUDdSnIV+wutwo4jtnsdSawXF/xEyaFrC3xMs+y3JI?=
 =?us-ascii?Q?6ru6RN1Vc6R20C6xqpjqb7TvayuT0JlLfqpIbby0oGosAbxDcC6WllhLKXtA?=
 =?us-ascii?Q?N9XKTyK9DsoX8q7+tD3T7hAGpwi8QHGw1RAxldNayD4x/gydi4psaEWB5rWZ?=
 =?us-ascii?Q?w78ot8YiZfZ6oKMi4j7/Wfs2JkXEGY94hbvo/qrcHAaq8pOiy+oeXVfcIAI0?=
 =?us-ascii?Q?XHUGXV/cTs9SkJ4tTeizH3XgqUBUl9L8f6bGrzL6/xBKTX8wK/KRCA1d0e7H?=
 =?us-ascii?Q?ryt2+xJUeNbdthNa4Ynk4D4+PbIisKAKpxHY45BqHeMMxPwP8q2cn7GFsTI+?=
 =?us-ascii?Q?9cl/eUEoJuODtxWIXt27SMwtJaSHF5nb+hBEh8kcALX6V7nXNX4/EDteMh3b?=
 =?us-ascii?Q?uNKw31VVVeB706e9QuXHn9NQuPEoRZ7GEpc6BDpFxhOCSfVelq4LQzZ+5wZ2?=
 =?us-ascii?Q?A+ESY0xHOoix/MuYBzRdytJq1l8ZjZJ+2Ugmpr8+owZ82MdX332A1tcSUVi3?=
 =?us-ascii?Q?2TG8WM/AkCY9cyfTg3Duox+sS/X1KUggqAp6SZsLUqkslheCWi7i5deOZQW6?=
 =?us-ascii?Q?NmHljYJUw84pvarGFtDxoI79Jm4CtWxR4czaezIU+E5/rDwQBFvmA51Mdrer?=
 =?us-ascii?Q?jDLR+mUKPjwKAwJqthWicX8xS6v6FsY/TpsEkap5MlNfYnZD3g8IAb3Frxx9?=
 =?us-ascii?Q?oGknS7nTkO3p048xWXmI+3vaOkfzviT3G9IyHYxRlhw/+ixI1xQm20EnQvEs?=
 =?us-ascii?Q?qrieDceaSsBMD75392KtjFZyOo0iREAtbJhJfpQEHRj+Ebf+pr6NN1ITEdgn?=
 =?us-ascii?Q?PbgejbtSpfslQG9FIOXaC9yEoezVbQo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dffe0e9-a0bf-4a39-5580-08de79d3d896
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 09:53:12.6005 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JGTi7Ug4um03ngH13nKbwEUkaGEHI0B32uw95yCvbWHDWt29xLq24ZCLKdwV4u1DOFptadX/CEJ2epJuquWz3Lyru3qGiktGOPLPeprLCpg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5022
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

On Tue, Mar 03, 2026 at 03:00:26PM +0000, Bruce Richardson wrote:
> Recent rework of the Tx single-queue path in idpf aligned that path with
> that of other drivers, meaning it now supports segments of size greater
> than 16k. Rework the split-queue path to similarly support those large
> segments.
> 
> Fixes: 770f4dfe0f79 ("net/idpf: support basic Tx data path")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
Recheck-request: iol-unit-amd64-testing
