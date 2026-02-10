Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7EFEA811A
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 14:08:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C6AC400D7;
	Tue, 10 Feb 2026 15:08:40 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 9280C400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 15:08:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770732520; x=1802268520;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=1igY4NIcwQQCVFByKA7aUNSW7V1BgPasX0HmP19Ckg0=;
 b=c+mPqTVgzUfPrqTCdVJegWkXjUuJlJNW+B24A++PiuVDmMxdrJoOQRbK
 sCA9UcF+av43uKKfGpQMwssFCu5g66ppNyGLNT2WrF/gPI1iyww1/uaDD
 oK9twTnm5OD8MQtr38GrdJeOgdOp/vmR5Nnht8aP/MepG6VeWiFWvF8zA
 AMrGwWRG3dMgUC5ufK7q0739trPEHjDV0iC8VKPsapAPWjo2uewdJ+MWG
 coBhMHQ1Dx4yxsFI2hwts54fiyCAsoSNxYFOQHnvSVc8M5aOmBSmNEue8
 UYq5BN7SQ+2OApwA9cb7feV24vFjsdXE1rw9WjlfClbYpWFqpqne+K0lE Q==;
X-CSE-ConnectionGUID: 3PEraw7WRTWp3Jr02nctQA==
X-CSE-MsgGUID: 8k69w1n8QmuiF/EdHe9jkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="75706792"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="75706792"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 06:08:39 -0800
X-CSE-ConnectionGUID: t3sGYRG/SrexAELxSsM8EQ==
X-CSE-MsgGUID: zlNSnxNmTAOOoc++S+nWZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="216265206"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 06:08:38 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 06:08:38 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 06:08:38 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.60) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 06:08:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xEgKC82kMXF+loXRH1mGI1KBSyCsLWSCY9aL2rfLBrjVSvAakyeChpix1gcqx97V53+D6lncAjrsPvkLMt0n1mVYTnO+L65aLBKVA/ayY8fep+0nzZnUyLnMyaUjArJ7jx7db+s2xWxPK1mDCaqJYViDukvR2/JT1ibUKTrbs6GQBuiks+Ghso3oxomxVeWAZvelUZfMX8v0sKPN10fE3C9+bBCj22bHVbQ1i0yQrfLtmRKXwPskpswicW6aI9yKO79RP85Y3k7+7tS6MT06cVAsKR0cS4b7XLwMlFagNEoaGos3wcBEOQqlA9IbxtpookEs9RrGUCBsAw4I+nw/UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DALoqgFpsqEQCQ50qLnOAxS7FOvd4te+HcQl5ehmqw=;
 b=f4UxNY82fgw5pA3ekCSPOlZTTS5Dx40iGBE0p5ErJImtnj03bSd9JvQSAMcJ58g6IE6cKQBI84BZFgGlxjocGyyRrAlhUWmWoCMO1zgtPw4ZRJtrNzg/BKE3a63qZ4zq1I3UqvK2cv2LFNVkXozXhoj5zpU9J1gCfRX5ME4ngqnjh7GLGmh4fv5OqNHxEhT8GHIy3w6UBDvIfTKcR7dCGgfxsjiGmczBrWon9+xQhR/OIftB9Cz4QL+bROXDXU6Hvs1gWnqeAngpm9sZqsphp54dlXgH0ZUpWqfr/c88ItglVVzKLHn4tdTDpswoGFaUg1X/b//xftxkFGxqlJDOGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by LV8PR11MB8721.namprd11.prod.outlook.com (2603:10b6:408:203::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 14:08:36 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 14:08:35 +0000
Date: Tue, 10 Feb 2026 14:08:30 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>, Praveen Shetty
 <praveen.shetty@intel.com>
Subject: Re: [PATCH v4 05/35] net/intel: add common fn to calculate needed
 descriptors
Message-ID: <aYs73tmg3YBlSXLB@bricha3-mobl1.ger.corp.intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-6-bruce.richardson@intel.com>
 <cab7ff8b-b260-4339-b0d7-8a139b617ba7@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cab7ff8b-b260-4339-b0d7-8a139b617ba7@intel.com>
X-ClientProxiedBy: DUZPR01CA0100.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::8) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|LV8PR11MB8721:EE_
X-MS-Office365-Filtering-Correlation-Id: f54c8ce6-c20b-4f45-7608-08de68ade187
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ypGfHrYRFjASZFmlSj0VuM+Hzam3icLG/jyacFhcmhPpuemHSqnOQ4Kqx4sa?=
 =?us-ascii?Q?RsYpzuMZurMHobmoPtMtB8Ru0LpKaypnpe5qPKnKvSJP/tuB6y19mQdCNfe4?=
 =?us-ascii?Q?nYvc/ABzeX7FFMo2AWrrkice8WOpbERyHd6NbnaCcNCYgrVqdJVrB0HQvebk?=
 =?us-ascii?Q?BD/im+TotRAmeOcWtJ+3HhbUsIgSiqJYXvkPBoyxHfVqdEOBmkvYQpBgsNH9?=
 =?us-ascii?Q?ynV8dYPJywGJIsDQddLhw+ZUx/RDDJLAQ3OiVJiKB0eAwvDRYyiYWIuSTJB4?=
 =?us-ascii?Q?qxNFOcJMktYS0c9btF/mAhCOR5AeQJ8L11BXvN5qOLJRTRsdspVUpIs8kT0b?=
 =?us-ascii?Q?xHCinESbPfu7HDNSHU/6TfOgbjiH6TE5QmTMSbuhV+dlE1Kvg9csTBwSVXgq?=
 =?us-ascii?Q?xt4V6Ujzat70VTH3PmkV7HZrD9PERxZxZ8chPiiAwlWsO4/r/6/sCTRzWZyp?=
 =?us-ascii?Q?v5pG/KYM86J4WqP6iFX62W+44Fs2lkcsjjhT2EYqOKOOgTSJ41zPr7WJvfpy?=
 =?us-ascii?Q?1sihXgUQiyP+0aG4rVxpOOTd4RDy9RC0cZzilYePKf0lO1rRYaV0XeV6S6rJ?=
 =?us-ascii?Q?K3WQSSosStWPDRSKjVu/e2e051jp3rs0g7TXtqzy1vS/KDY9tFJgpwJb+TXP?=
 =?us-ascii?Q?zVoDcI0GpYo3jt7j8F/g1yOwL1cGaCA6pGJcvIrZpgPkhbeJMQF4rqEAT4xW?=
 =?us-ascii?Q?yPD2ULs6E1iTyNrMTaWggJh39vNhJuBsN4vlNB8qrldLdYUk19/GKAlxWLwB?=
 =?us-ascii?Q?KSpUdaupkeNH5H3Xc99MqKuSD+mrsl1XYEriAZ/9QqxO56jCzMCb85vKkDj3?=
 =?us-ascii?Q?EW125tTXsuBWtKMBk0OslFOmnAOhuvG6teMbQsBwg76OkO3HXZwtEv7sACck?=
 =?us-ascii?Q?M8GIfxYE+6KUftllEjnmja4uOMwdbc+M6q1QBL4I1ckAoIydhpklYEBC6wuh?=
 =?us-ascii?Q?7r0OTEoMdaosjfn8JghZTAzX5Jbc3Cmh5PgMk3TIRc7nIjCl5LjFxr2pFVK6?=
 =?us-ascii?Q?5gFpsurWZi6GwU3cootkUEfVhMmbbrCiqylzyzHoLdgiQeLBAfCq3uLxASSY?=
 =?us-ascii?Q?aELKMpsfsPZaA9rXEgPJ9OTuBD9nbO2XH8JCXCjcvcfgrZH34LKcdOXg5pP2?=
 =?us-ascii?Q?yggSJZb3nobx0Ro3Cu7fsV5GZvXtxOrZC0Ec2NwWkGB4HBX6Gr44Py7GATGW?=
 =?us-ascii?Q?3IIqTWY8byByzxnkWVWgFvys9msnfffegJQ0AtBDvRLC+IPJI3X9OdKiIyXo?=
 =?us-ascii?Q?RfJKuJxlYizGB7p3Pf4Mlok02rg9ioLpIUzhbBR9idlHaoa0iopMcg/idpgj?=
 =?us-ascii?Q?d4m36upswTzmb6lZOjyPbxSxyYt8oEFD4GCO4kf0gIm/rJMmrHXTm5lMB/SC?=
 =?us-ascii?Q?7FUowedW5+FZqyvRmX/bT35D2Z7IdD+MyyV/MfOsc+oI+3Ti61qaXO00Aniq?=
 =?us-ascii?Q?2khIPz8QXTLdKegjQaBunMZ9FXjXQQF8BAl7hRoqJnUcrqGQlI60CRqwbS5K?=
 =?us-ascii?Q?1Eh29yu7W2XBhwVGTPakykNNOgpK0RJnpPikscw5hKkJf+Ol9C6w7GutA78p?=
 =?us-ascii?Q?CautlR4f6i369R6qf9g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vYoUbc840bFq5fsnhq1UtXD9aehvR2qMStzHvA7bxp7qmIIH5gLC665inc+C?=
 =?us-ascii?Q?OlwiLoGP3l8K+FLyiYNlrI73YF8+RWvj/lvaM8xtRBvhfQGedkJYXrFzras7?=
 =?us-ascii?Q?XY7sopd/wyyii1PZzyhtZwEDjFRQ8+nEWH8GNhaB67gk6kMyFFTRbxk+RHOv?=
 =?us-ascii?Q?/SMtjzT6fogFOfeDU+0xKKR1gRMHPC+Kp2rMd7UzltiXFSmWhamJ3OHhjbJK?=
 =?us-ascii?Q?cU2KtK0BnJ4ofK4gfrk13uQW4cCYklDdBRLHtGIu7UkGIIfvlkh3a0Q6vzeX?=
 =?us-ascii?Q?zSnOgww2piJKRgggCKbDRdDl5ZPDaAghL8N+WIntg1wSCSfMZlY5hDLpj8Vb?=
 =?us-ascii?Q?ng3QsnSViDPMayKkyNYkP17mkaJGQ/LlHOYwSxelVImaSoP7Atk6mbcEtCin?=
 =?us-ascii?Q?MXmIg0Xmq8JGc6XMFvspEPb95S8p/YCHZeeimAi+XwDrNQYUfB/ROc18ngkJ?=
 =?us-ascii?Q?gSDYXoxotZG8KRJvBD4WS8f33TQctawDsbaaJMtsJxWxrydauVlwIabYM/MV?=
 =?us-ascii?Q?IAP0bTY7E/JI5ydOlSaHyACHYELS4c84z1CBPvRxxBNhEgztXPF2vSvGauiT?=
 =?us-ascii?Q?pBlwRxopq12TX36nYONxVyDe1+Y/taDvpaqk/a6VPRrmenXOsivpJEbKnleM?=
 =?us-ascii?Q?YQImTtL+5/7yeDDIHVMMC1kyabOCyxSHSoGQ4Es+pQ8Sad7Nx19JKA1vaR4I?=
 =?us-ascii?Q?KikMmu29G6gKaqmo6uGWdOBCY1u6Thbg9e6QaGAvYHvC0DgopeUGCP+ogdCX?=
 =?us-ascii?Q?iKXfO/14P+m29bgfkACcpljwerpwzjRVcuX0eL54Fj2PDfRfEYZ0OdiY4KUQ?=
 =?us-ascii?Q?/4zrNJmAstf88FIr2m0gVDOCmbDTmIWXWFowQVcsUI0psipFvCH/On4tbPQF?=
 =?us-ascii?Q?lYRrE9PyiiMrBvLKsRjQmkNJDpStzPw8VQj/MAZBP+ARZLHWrDI/eO9ZufNC?=
 =?us-ascii?Q?5h4jPRtbn85jqpeSZSJrNe1N6l3dCj0rgtV2uzeCp0nRqCIHI7YMkV4+X2cX?=
 =?us-ascii?Q?f4YjanoGT9J06jSLitiBNJBGKjqgiYKgfdoQLV+UMjTsbikeJljfbdWxwjVp?=
 =?us-ascii?Q?lkRyzN5kSIP5iJjK/wFlaogjB47zUA4PYmGOl1Pk17mQEMsUp1PvNpcBFRPM?=
 =?us-ascii?Q?LMhS+VgzJUOAc1wvG3K2AWaS5g/sjM1UIty3f2qTnu6rukQy+LzwJ6+G+fii?=
 =?us-ascii?Q?OjggK6Z3rrZFdoua62KGz+GnHa4D2CgpSn4EWoPRebYPki4wYYtcnm7TP29G?=
 =?us-ascii?Q?RT2SekAFeDUt0SMdXquoJPWZnhWsCUVrq1RdSEDW9HhhSMgwt4xUbb86Sr4g?=
 =?us-ascii?Q?mPVn030aySmaOxt/QjrvFsuFnAPDwUZqOh916MtX0//86pbiLGFbncBYIbKM?=
 =?us-ascii?Q?cw1iXPthQsiGFvh4BAOCK8dJuVWWM/At0bzs8LUHrMqLsK+jA6VF7jPxst5s?=
 =?us-ascii?Q?QzlyXy+hrLDA98s9msrrLLCqUjOShQ77FCgINwl1vQk2zczJoLQ4NxtJBxqa?=
 =?us-ascii?Q?O/oA7vFYJE9IP5mFz3CY41bLc3KFq2eLE7T164vqFpFEp/zVt66uLGgYd01i?=
 =?us-ascii?Q?3OhB904DjRN/qklZBPMprwAC/u/t5DiwNtMhEZS5sbkLGXVOF3EaJZElX/cI?=
 =?us-ascii?Q?POML7GTJl+jkLZ3AbeQjElalwJrsADyUxLkg+6L9OxWkUfa+tJVcxUt5C8d6?=
 =?us-ascii?Q?ZNJBR3WAcgKpJCQJX9Ot6BayoGq2N+0kQn9+wFq4iZeBsi50g2vkyxN+aPCt?=
 =?us-ascii?Q?B7aXiKbZBT9sW4+gQyXcM10insH3mvI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f54c8ce6-c20b-4f45-7608-08de68ade187
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 14:08:35.7068 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xvp3HtFstvAsmxzN6ZeBXjFV8LxYH5wZTwKhbPggOPEFABk+XT/zluE2W79wOiq6JrbtfLRpDKHOSNzEuazeTzPth9J4FkpAa56Fgeb+XeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8721
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

On Tue, Feb 10, 2026 at 01:29:48PM +0100, Burakov, Anatoly wrote:
> On 2/9/2026 5:45 PM, Bruce Richardson wrote:
> > Multiple drivers used the same logic to calculate how many Tx data
> > descriptors were needed. Move that calculation to common code. In the
> > process of updating drivers, fix idpf driver calculation for the TSO
> > case.
> > 
> 
> "Fix TSO for idpf" sounds like a bugfix? Can it be backported to stable?
> 
Yes, it is a bug fix for a particular edge case. However, as done here, the
fix is implied by the code changes in the consolidation, and depends upon
them. Any fix for backport would need to be a different, standalone patch,
based on this.

/Bruce
