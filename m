Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAFBE9A03B
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 09:32:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7425A402E3;
	Thu, 19 Feb 2026 10:32:37 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 8B74B402AC
 for <dev@dpdk.org>; Thu, 19 Feb 2026 10:32:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771493556; x=1803029556;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=TuO5+qF8g0O8nqrkCVb74cu0e78XLp3tMdQVEGN1MNE=;
 b=bxC8xT2xA1CRPQgTt/vVW5LAzp32W5XAeokVPpgnReOumnHg4+rf5Lga
 RfH6eKKI/WeJunuSt2Jflhyl0vLxPBVH0uy9G2rccg7sC2dymmASMgvVC
 Afwv6hSOuSvRUieMJq3QuKA2FBzxtaIG3d76pqjxpHT9Xvt3qm9S/HHKI
 chCgGmfmpc2+Q1E3949oZ2ooXmubJOtsVaIgEu6uZEBsV3gCSwk4Gba/n
 GdtOYP8gE3kvkPBCd42bz8XQ4mq7tjlbenuKDFYywIUycATaslseH8Kyu
 np84Fbl54UrYZtF/lUKdBLkZCN5Msh1PEBI/HBHh92l8HNuznkZOCvk25 A==;
X-CSE-ConnectionGUID: RRJc+N0FTqK7PXtdi1oXeA==
X-CSE-MsgGUID: iVXBMrtLT/2nUce9RzwhSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="72671004"
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; d="scan'208";a="72671004"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 01:32:35 -0800
X-CSE-ConnectionGUID: /Fir3AJMQWuIrXKOaSJNDw==
X-CSE-MsgGUID: v56rvZ+ASnWl3CuAJ5yR5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; d="scan'208";a="214571308"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 01:32:35 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 19 Feb 2026 01:32:34 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 19 Feb 2026 01:32:34 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.14) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 19 Feb 2026 01:32:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V04rboNNUGiTnv8N5B23gh74BmzMnKdMEZ6kXqkmgUg3Ywwhniu8f6scTBNa2xOAfKKKvjayhXpY5hI8lSKzpUdtFc2UU8DxSWYPVpFO5qSeaaz/cdNSZiIcn64Z4WSzHQmXfN9posEfOi34FOOExn38HIHfIla9xnOhtKr8zZfwFBFvwOtlnuM8lZTX/jgkbrAKla21Kv918iyzNDCVnAk9pPdkUoVwKRxV+VvlxPPcNjDruxDEEcn8ZPZ4rL4U4AIHzA9iBlQHXLI9KvF3j1yjvX4v4FXvmlDHZP5NgubA33G9eEkgVDioUt84k2H0VGC3HWNd2YCH74DJJzOmYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haGriGau8+etHHrloUgVL/M1xLM5kaOy99ad6hh/FlQ=;
 b=shf47yweN6WYu4+PLYGEOCPzhyd+EPJAqdeXaSvZh6Yl+BhtLbaBT3erJxxJglm2+IfateGlyP/r16oRpUZrPE16FZBqvH1NU7r3wWLbAuY7h9/NsIXikS5d4xm8a8pYOWhGnqM5RukwkiYUe7fQpbYzOI1U2qepePeuyQQNcOByyj+SFYel85fugeFWrFe+CFGHxkXUnZZB7XtqGt3yzLxEEFdRhjE5f2EK1nskaaGui9c9qhylmUE9AUBLgpWKpVtRzKD4HFH2wlyZLYVlR/gOWkvc3i4EvR3w2UnDTxC21zWQPn7H3Jj29tJOHCDRp6aOPvwbx3gA+ewsfTmDgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ0PR11MB4784.namprd11.prod.outlook.com (2603:10b6:a03:2da::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Thu, 19 Feb
 2026 09:32:32 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 09:32:31 +0000
Date: Thu, 19 Feb 2026 09:32:27 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v4 20/27] net/iavf: avoid rte malloc in MAC address
 operations
Message-ID: <aZbYqwhkGM1R-7_S@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1770978324.git.anatoly.burakov@intel.com>
 <cover.1770978324.git.anatoly.burakov@intel.com>
 <ad3c77be6c74565b7a9e4544b6565ea91f94fc70.1770978324.git.anatoly.burakov@intel.com>
 <aZNTkvpt8ahCdoSS@bricha3-mobl1.ger.corp.intel.com>
 <88f7b829-83aa-48b0-9de4-fbdcf5633603@intel.com>
 <aZbYBIoAonxgBpiD@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aZbYBIoAonxgBpiD@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DUZP191CA0025.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ0PR11MB4784:EE_
X-MS-Office365-Filtering-Correlation-Id: b788be5e-fa43-4e44-cf7a-08de6f99ce3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2cF7I1PcD3BWM3I7cYB39aJQTSqiCnbHrsy0TjjvqFWK4ozYCpc+8FVuywV6?=
 =?us-ascii?Q?Heof548fuUSrPH0Pwqk3MkgoEToa4DfNpNsHJPgkGpKjzO6n3rEV0TmcBP8H?=
 =?us-ascii?Q?edb2gAu2Dgv95zFLybAvBEKZP0kmdmqwSzR8HYooi8qP+Ud4IIRmPQn5TZrE?=
 =?us-ascii?Q?D+lR3QiN4aIJhzuk/VJ5/K33eX2peE7AXLvl/3Cf2POSjc3o80IVTObCSamo?=
 =?us-ascii?Q?DfORxQpCLHtKP1R2oRlUnKRstD/RMk3/eMRP0UON6ShuLmFoxaOH1YwnFcei?=
 =?us-ascii?Q?OqJbDqoh9osplIE0f/poU8yX+b+w/sDu57KiC386/zUwh0kjjXqVx2R1Tlm5?=
 =?us-ascii?Q?sh05655RN1m3P7Fdcn36zNryW4OiZIN8W13W/FAC+Jqk4d1WN1QzW1mA3/rl?=
 =?us-ascii?Q?UMyPo1ltCaFfV9aQd5KbacKkFj+iuH8gcnSY9qWLveF+uG9y+yoyzKgzzelg?=
 =?us-ascii?Q?DBB/2NrvoDbKGe7Os6wP0qpEkZckKlpF/m4Sn7HZwGxwWkeICcBM02xazGYp?=
 =?us-ascii?Q?XXtKODNx8D+pWkf9cDcS495mScpn3lkikamyGC4rZf9VedJpbQwOPlfB3ToH?=
 =?us-ascii?Q?HDKz6+gpRdu2YYhWQbt441MhmmQ1qo0fVUIHrBsmGdvbAkcdTHTZcZg+1v0d?=
 =?us-ascii?Q?5H3doNUS3LyHCBHZ9jQ4xDu4h5Sp6GI22Sf4PiM6U943DNN70BgAUMpBnY2f?=
 =?us-ascii?Q?LqxBCIKo4t8SmClAMQcqIo5gAIxLQ4UeZ/iLibJZtoRKPCIhTcrpBKni6bwR?=
 =?us-ascii?Q?Kf44ahKef2usM203k/QYA5vY6VsvgG6T1EV+ZQ8vOzNUBq9LQU0BCKz6VNnh?=
 =?us-ascii?Q?BQyxZmqdK9pMqowqSzDZYmQr9dNUrXndNedB4xn9c34SKAxzK6f79g1/0v1a?=
 =?us-ascii?Q?XDdnzAnHXi4cDoP3rnJgIRSmReHiHRr2z/LbWt9OloNfQYuWtuO6vNe973qn?=
 =?us-ascii?Q?EblYpA38j7XLhyYCYJEN2YzSl8Y/iewjj7hfoCEL6MoJwkfVIhvIg3ZAhJgh?=
 =?us-ascii?Q?4Ic3OXPTfNSVFaznOPRi94WbYeLKBrCzo0mmpHCDy0Bh2EXx6GGNuo1plbk+?=
 =?us-ascii?Q?LSv66qKwHVBfbYnL/FWGqHyhZAX5vCqXaSHBc52XOYbH65Yp0l5jdcNt/WKA?=
 =?us-ascii?Q?u//QZrPfOImb99AZKzLMHLZ42oWO6tr/l4JJ8HqoqMhbgLyaPQiZG9YZWB3h?=
 =?us-ascii?Q?S5UCDfkOGLaTGKiW0llPb4S1F6ZVGE/IeC1XObXFYOy/sqHkEyIWobgq4JQB?=
 =?us-ascii?Q?tJk6ZM9ZjjgkkU6ViseY31qimzSYpWAvd277CPeX7gPhL4C9jxWoOEQoYb9/?=
 =?us-ascii?Q?N+Pk8yF+TjQ5f8wDIB3i8++Fywoh/ZBWuKzm/6Y4nBFAgJ27YZtOW6Bt7FH3?=
 =?us-ascii?Q?Bv+0XVHhmco79Q6jlDGVHWYmCQ/Rrua0Iekr5gph/8DIS8+/XOBM8LNKfcni?=
 =?us-ascii?Q?rd8cKPr77vKCZaGDDJPPuY+cf2rxOupXaOFNcOzWT5BKtSiK91xm5xRpWoZk?=
 =?us-ascii?Q?4JRWeqK22ok4NWc341AVwX+ZoySV9fMRk+G/urwxJD7wx6jLni954kQpV07g?=
 =?us-ascii?Q?Ys6xdmYMAA7tnZDMr3Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/mEin2ShtgvbC11IHIvCrh9aPgSPeJIxRgj4VNPeHKs2iG1p568JKhYC6LGU?=
 =?us-ascii?Q?q4pF7JD1Ish8PQxQBCXSyBgv6NI4Al94eu2Y2TLxjNAe5FALmCjxDfSkMi/T?=
 =?us-ascii?Q?ulx9rQVc51xrPkw4cvVKn/a89EdKa9Xhj69WTjxmT5pRVtg8R0FRR0RLGfEi?=
 =?us-ascii?Q?LE938WjQoaiyxNwO3AlIIZ92oPvArGe144dq5U4Tcqs12OnIduISn2RFfu5q?=
 =?us-ascii?Q?/abR8nFO7e88aoC2WECDUuB/JIgO7qFkXpqz+Ak0gc0tl8KAS4rfkVOx0Ui6?=
 =?us-ascii?Q?dXw0MYKluoWdxwJIxMXmOfq/GoDXo5C4LdpmtZ1xI9WM/vMduZR4uB3JQ+Qk?=
 =?us-ascii?Q?m3gM8ZnZnBYsPFfaBGCoez2nO2TIJjLMQNCaQ7XAPEkT9wAIkoY4Cvu9D5ua?=
 =?us-ascii?Q?Fr4+4wk10VImxmFtt+7BC6KI1bOI8/Mq5biSbDX+Lit+oPZ6zipqYMk9ICdd?=
 =?us-ascii?Q?9N9Qfc/NGqcY3kGNC4rsCLAgceduhD8zdYTcZkoEu8rriU7Dvkro9zojqJ73?=
 =?us-ascii?Q?RcUXKTBY7Bk0VVnIWUB8pq8TFqFPn2xyVY7GVv7iXs9KN8DyCrKZ17HvWkWO?=
 =?us-ascii?Q?L1GZTod1I8JZEAoiDw7j2zKjRZHIx4eFVe6NjCXr8Jn9E56bFw+WA08Oj/NB?=
 =?us-ascii?Q?du0jwruHwwGrZq7hJTzgc06rXDamgyBQzdh0ul6HUKgT5EWy/tBfutPWXvKx?=
 =?us-ascii?Q?Y8kT/PtS1JFyfaWs9rlgY+sd6e8ZEF/FfGJwp2gB70Ut/CS+m59zllyScMyh?=
 =?us-ascii?Q?KjEKxTpWa75xLUBusoJ/oBWDgucpRWFluqgWhTnqQQvOAzMdyILKWfC6KhXb?=
 =?us-ascii?Q?4eomswXNCo6j3j05XwVpbhXNnNAIyWYQI5vBnEwE9eY/mo0fzZdrL5lmOjiu?=
 =?us-ascii?Q?uYO+j214fR4KK19sRYLPiXPu5vtaWXo51OWRErfcXmcck7PcGvBPAxPiK/sJ?=
 =?us-ascii?Q?CLFC81jr8GgDNq9l3LTczO86Rm8V9Pl28MjiOvND+M1f25hJIHvlVuVHDtPH?=
 =?us-ascii?Q?F6wvQBwT9mlOVLJBficBE4ijPV/JQJcJaIIGuYPC4d5i7AQBXHCnuM4BZXPd?=
 =?us-ascii?Q?FW3cbbrHn5xD9kGEnbK4OpQHrxPdKzdi9Da3PyGeqkFT6xdx3RtNZIoNCsul?=
 =?us-ascii?Q?UkpR0L0GOh0BanX7gcQ66jECb9UolcNVyqJComEWtLJzRa07E29Rdg13DjcT?=
 =?us-ascii?Q?ShoxoxzvheSx1Ud2Q+UU7Bt+sfxgTspKZFtELTHoF2jCm8lJTASyQOcfo39r?=
 =?us-ascii?Q?XTiJAPmfgq0TQzNiLj4bqF2PuJ9UVKouw0eXF47MJA0TAs+jNysF7ev3n/Fy?=
 =?us-ascii?Q?dL9bdX2F/ApSmi33d1aXXZa5XNEIAKxe8JoFV3jgpRospamgt3GK5G7lzrde?=
 =?us-ascii?Q?gRY4HI4U5Ntw89v8qIh4UUiR91BBgmaey1uSkquks9rnT8Zo46edoXbSpOv7?=
 =?us-ascii?Q?d8NaiyQsps9vX40wYq/7W3THXNFMtR0byaIMWNhyMSL/KEfgQOsNNe3MYaUk?=
 =?us-ascii?Q?zxSprWCFfRf0DIln/NJA3BmzlWqwIhhaeyBSPLFE5iUi5Q8N3oNufw837bG1?=
 =?us-ascii?Q?TY6BVSsnxJgDgghLL4WJMBa9Y2yLgQe95DzCGAeNqZzknBBOmUtw1aFFdzA4?=
 =?us-ascii?Q?uR0y2XJFHmlfq3P7QWasTL9wjbjjRU1WHQEb0O9IRWXnzVBl/HUsMvZUDHo3?=
 =?us-ascii?Q?EUBIZwa5UtQVk/jjE+4VJwkGX5gkTgqGJKjeV9xoTJLXBkC+ze2KANqG67zd?=
 =?us-ascii?Q?XiS7CSNet2+sWWcwNTx+qnu9zAT1Ds4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b788be5e-fa43-4e44-cf7a-08de6f99ce3c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 09:32:31.5638 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bkyzc0/NXHRQmvOHs9RhwqKvBv1YpsZka0oc+nX3qqqa6PjEM2ZjmfJ9kXNc3YHBlufAwoJfTu5wkW66ggTwMOvBo/M/jlpRoIM2qlENflE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4784
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

On Thu, Feb 19, 2026 at 09:29:40AM +0000, Bruce Richardson wrote:
> On Thu, Feb 19, 2026 at 10:22:24AM +0100, Burakov, Anatoly wrote:
> > On 2/16/2026 6:27 PM, Bruce Richardson wrote:
> > > On Fri, Feb 13, 2026 at 10:26:31AM +0000, Anatoly Burakov wrote:
> > > > Currently, when adding or deleting MAC addresses, we are using
> > > > rte_zmalloc followed by an immediate rte_free. This is not needed as this
> > > > memory is not being stored anywhere, so replace it with regular
> > > > malloc/free.
> > > > 
> > > > Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> > > > ---
> > > >   drivers/net/intel/iavf/iavf_vchnl.c | 4 ++--
> > > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
> > > > index 55986ef909..19dce17612 100644
> > > > --- a/drivers/net/intel/iavf/iavf_vchnl.c
> > > > +++ b/drivers/net/intel/iavf/iavf_vchnl.c
> > > > @@ -1402,7 +1402,7 @@ iavf_add_del_all_mac_addr(struct iavf_adapter *adapter, bool add)
> > > >   			}
> > > >   		}
> > > > -		list = rte_zmalloc("iavf_del_mac_buffer", len, 0);
> > > > +		list = calloc(1, len);
> > > 
> > > Given the loop above has a threshold set for IAVF_AQ_BUF_SZ, maybe a static
> > > buffer of that fixed size might be better?
> > 
> > That size is 4 kilobytes, so I agree that we can use one buffer rather than
> > constantly allocating/deallocating things, it'll still have to be
> > dynamically allocated.
> >
> I still would use a stack variable myself. 4k really isn't that big
> nowadays.
> 
4k is also PATH_MAX, and we use stack arrays of PATH_MAX size everywhere in
DPDK, so I think we can assume that it's an ok size to use as a stack
variable.

/Bruce
