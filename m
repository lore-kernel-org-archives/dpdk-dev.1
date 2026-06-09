Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F88CD8CA4
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 14:28:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 11405402B8;
	Tue,  9 Jun 2026 16:28:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 99B864025E
 for <dev@dpdk.org>; Tue,  9 Jun 2026 16:28:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781015326; x=1812551326;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=jE37XHx4WOwsfpwX+JsSxoQSHtyj79/rIz4BjKhSD0s=;
 b=AwJrtWq37aZDiGU6lXQTBHmtNETrS+0xdjeYecaQ7IdZr6uJsBAZq5mY
 Ntgk+loHHtVyNACEjywswKj0SZ2gxmUpcUfTOFMCZKUvGwCZjYXggYvf/
 YRb7cPZV+h1gFErfBuc48LGF8JkD8vUOYHpMZcPWItC8JiAhXlrnPf2x2
 7E1TCcevYKRLE7pOXFuhUlIZFrirvQZDPDjpKeWara16sl8m6AT7nEnxm
 z3eEwG3XfcFiZsy5cXxbpTPOxuK1BgunYpz2D30o/VHHLeCYn5i+J6D/r
 +ProI2YwvaUgV8JdHlWv/T/iQ8JBb6XCYnWrU4GybcU/+BiEZXzBY8BSZ Q==;
X-CSE-ConnectionGUID: ZosWzPfYSDqScexBCSdDwA==
X-CSE-MsgGUID: mLQhZaedTIGKo+lnfionRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81823832"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="81823832"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 07:28:44 -0700
X-CSE-ConnectionGUID: 1Ah4FcKuRFqZ3fWwXIOvHQ==
X-CSE-MsgGUID: pLCuTqvcRV+coFT/hXalQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="250954548"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 07:28:44 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 07:28:43 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 9 Jun 2026 07:28:43 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.23) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 07:28:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PV3FBkVYCqtypqHpTuAE1osuFrTpxhjkrb19qFEvdfiNOeEcjtvP6pHgFQVW+Zpw/LaHh6p/koCeQh3SQzA5C4iRB48axx4twTYiYqoBpjf2Cmlt/l7m4KeeZQ8DXRWPY3xXokzV3K0bJ9KATQimtscTy35+E7Uppj60pp4yNeA49coDCp4FEc+wcu3QjkS+r1rci+lPLctD2UdcZe1Z8CgUqQYg4z65yPjYDg80UnkjyGs+s7+JnnGaFSXQN483HHaoPxEayqiNG38o14GMsN1vC9wSXgeivSBuk4MBJKHykwQetYVEcYItIXlYIPaOcet+IY+NqquOufyYuesmxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UdzkazC2K27xF+G9mP/i4PPhBYbF50Uz0GSAUQgbPKE=;
 b=uNujtvJdhRoz5VyvKNA8Yu87HB1MfhNcCebkNDsYW4vgOyFmZVlhweswvUg5nFfXXaJRtqLq5RDyzE0VBB6RMIkOvO6f27lS2+VshFYv0k9tdQbsnVilbRfU3N2v9y0hu0jfOv+bZ9559UYQavwczVLWY9fCvD/C/+30ZwBayaid4d8IfOGyobup8Ajoh/zBdJwXOyYJ8arY0ucpJLbsg+00IN4hSwVLrOGd7V9R1/Hv2gTAMpf3YhGUCNpZpcldcDopy8JKe2FL1D/Osmdp07qEaKcClFzcKPJioCATwvVFzTtroNBRdXQdh5J0v6NC7mvUTnFc87w1hXPBsZpixA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW5PR11MB5761.namprd11.prod.outlook.com (2603:10b6:303:195::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 14:28:39 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 14:28:39 +0000
Date: Tue, 9 Jun 2026 15:28:34 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
Subject: Re: [PATCH 1/3] net/iavf: downgrade opcode 0 ARQ log to debug
Message-ID: <aigjEm-RskU5s45v@bricha3-mobl1.ger.corp.intel.com>
References: <20260608145518.1705524-1-ciara.loftus@intel.com>
 <20260608145518.1705524-2-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260608145518.1705524-2-ciara.loftus@intel.com>
X-ClientProxiedBy: DU7P251CA0002.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::26) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW5PR11MB5761:EE_
X-MS-Office365-Filtering-Correlation-Id: 59a19028-b916-4604-92f5-08dec6336642
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|6133799003|18002099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: T82js3wgkQkNTs5QQjCpqL7965OjQZuEnrc+r3/LkVuq+JukjBSuvBIiPTD+tJvutdm1FGJUCxI/gfhGw3f7d7axbXFan/JQgCpKhxPN3JiDQYX6daAHPpGT+y+fFaTOlSwG/9u+DYCCwGgPG7pjak/MPbmpLcp+ac1A4gBxoQ288501YjiR5JuvlAN4S9FBW/c3oVeWjB+XAoTTrNxE3ifRCcB38X+3DWhO2m4EFTKMqOKzPaxkdMqv5S9ctX3/K3XEbpNBNhVChpbFcYz84DIp/5Y9Qve2pwNWSUU+YkzaKukyjFh30N29GHb6ah9o5GLWZJf6bo96r5AZ7comEFXSstVlU7PY+tyGF44eWHjLYI5XX9MrIEyzfo512svcBQ8Uvwqdalpdjhe3DbAlEZuKqhnlvHZL+wHKS32iVWeh2dY67r32fspSW8LWKmumqGZAfZmrId2OwR2iq6zab782R+Z4vhEhlvdZ8NJkqTCdMw8h3hhJwKaSk6sA/cTGF5JJZvs8l8bgp6Bo5vY+/UkmD1Z2Ku8nUchz/Kvh4zGYjtG0qP2/ypzaOBqE92f0inidS3m2nTRpEb8eRlglFGb3pxw+o0GUFZMZ+y8VDbpwxpAj/rM+fWTIPnIfr8n3VKnqqQEOc8WMigu9AWeazsiTafVF4ICmfbZgEhv1jXCTJldbNARwb+afizHFLcOu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(6133799003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3drbRh9Se3FD59PDcI0T93GYU06k5MbyMNUkU5++hdOA9tyPvybMfehEpmOZ?=
 =?us-ascii?Q?7Unf3utHAtJ6TYSMKxdb7l46+FeBLA/jYhm5AZeQz0QFGBgGjuYgkjW+8vSl?=
 =?us-ascii?Q?2UpseG0fnriYlRmd/coB+5z3BukZUbkwAAnQNIbTpZclcFl1b6il/fzC/nw9?=
 =?us-ascii?Q?Pnv877/9LF1M40iGtUUmSDEXUIlTIWXGL0QVezAI++tBsbBlcb1lAZ3tL2mP?=
 =?us-ascii?Q?ilyAM6ayzrsBqt+qBklc2qb4Aa+FyBYEoqeBB+O5hXUHbooMQ4FK5Gv47VNB?=
 =?us-ascii?Q?R84pZ/6fyNYDIF/bSqLXNNLYOcFlc7DwqygeTrfJZJoLwd6DVIQnExh5vaMY?=
 =?us-ascii?Q?iSeiS0vf17Qd1LIpt5r/kvUOQYxb7mvW43ux91ywjNJsXS9zpCPDHKCGFO+J?=
 =?us-ascii?Q?NQYmPeUDcN8jyp8BravKsmQx85+6FtFkZ//Rv7jYiwede8scTuWQ/SE5EVye?=
 =?us-ascii?Q?BYTiRUt3itYN70Y2+lnFsnh/JfYWfTC0eA4x9eVkl7r+trTYonbDwvtQAGmu?=
 =?us-ascii?Q?K9M6tYo87GYoRj0PMuSUO2THnyYcPQ+PuPlE27RiGSIPO2/t/s79Z11SSYKz?=
 =?us-ascii?Q?L2KyIvLnrWW0msW/8ydR44NvWsUqtBNfxDq6lOKsqd7a9K5qDSr+/HRltANh?=
 =?us-ascii?Q?zgCB12SsA0QMVKN/PUUj0fD0Sb+uTQ5NGF8zFoFfi1nMZJsHYqOZ1VRXRPVk?=
 =?us-ascii?Q?qylJPMEhSOF0C3FkU4NpRPsOmHc0YS8jgKFkS5D0OstQqZZWWYK/wHyVh9lp?=
 =?us-ascii?Q?VZMO6Dz9rr30qUbnkVtND0XKE16lfzYIqJvUTLh4nGEzq22n09iL9eMSHfIz?=
 =?us-ascii?Q?vlBe0P2GhcjTfoDZTtH6yJvRSTX6x18DOklA4PHuCIKkB10Ev0PisASHZUfq?=
 =?us-ascii?Q?Az17lTNxOHkXq0i2l4LBQriKe6nUOrQoq3xmSGsxFHYT/jhiZ6CFa6Nv6kBg?=
 =?us-ascii?Q?zxanDVjo839gjNk9P4SWEBaocRL1oNOanPaOU1FXQY1qpaJX1Tzo2cvjVHvg?=
 =?us-ascii?Q?Zw08BwbcBhuKnxeuIDrgPVARlp/phQ+DW+gYrhSJvyvTUB+Q8SKr1CxvlrJ4?=
 =?us-ascii?Q?7Apwo8A5sMUD6z8vBqop3+E0iopHlZV01Ej0p/tDr0SZTYJxafxho33fIx28?=
 =?us-ascii?Q?U5VnAnus9IbxoNC61A6I36Wkiev8VOqkstoggzTxIF4kU/RG7HN0QC0ubS7T?=
 =?us-ascii?Q?kAbkTrKziLu1VImmojYuwZuK2V2zs+h1saWKoUvR6YeNKN/DLO/UmE9FobxU?=
 =?us-ascii?Q?j9mSpLpXv76vAa6qElwWthZLIAbYTId1BBCZKcvJAQcPoSlZ8xj9n4dDnNnh?=
 =?us-ascii?Q?COXlbmdZ1jOIAPiNOY0M0gPJ6Ci8487fiPt+xXQcmKqSmZsKAngRu35+2rcz?=
 =?us-ascii?Q?8wqj0+ugo9XmaWhS8JNYzmJf2/V6gPPmzoGYPMfK9mlOfFqFxTQUYVUXsnoh?=
 =?us-ascii?Q?wLRpRpbSutHBQN6rwMuMYDT96v0t8h7ZUj2OE4Kod+FHTuc9SFtmR9/BvACe?=
 =?us-ascii?Q?lEPZA0nJnCEPJtywppp7BwbGOq2mfIxVYyg/eHn6yca0MHwzmYgAWSK1XBlX?=
 =?us-ascii?Q?usKwILrkD8tWgV8taWLqgyc8yD2QA+CDB1nluL9lJFLJVSaOdSqq8xiqGPqN?=
 =?us-ascii?Q?IJvxB2DDFgqapYGbGne2u2YHHfvSeEOsSb/OfLAe10kK/V8VnpWh3PTFGoL3?=
 =?us-ascii?Q?92vKZQNdeNQegMDIpkeshJXJYBerQ8sgjhnoA+jx5oixHNZVV38+RB+bTiN4?=
 =?us-ascii?Q?bqS1ulPz8HumLZQ2KHK5AkatGdMVxzQ=3D?=
X-Exchange-RoutingPolicyChecked: bG7SRvoVOMFgiaHlvwyaqAPgcuQXqox6uchiYVx6qdAlh61sSF2Qv3mzs7AEKYWuVM5ZCrQV6R+zc3neQvs8Zvay2yeK0XemH40CH4YtEghy+Fcj8We9Qpgqv4NBB11WjASyKYIkVk6d00SwlEONWIEidRldtxBMPQtU38UzY8rvKd9oM2wgelz08P1U0UUwRRih1KXTlR9Pke8p+bi3USuV3W2Vnt39I0AaSX5xLFbIUWD9XXoB5UFua5ogVlGb5ass/38NEsalx11vnpWoBGegQW/bXsbtPADjpJiYmirGy4FbbfgFt787QOAStnhjpBxyRtg093mswlB1AsWZHw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a19028-b916-4604-92f5-08dec6336642
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 14:28:39.5936 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Ibb/p8p/Wuo+OqztJY6ojeOQII5Vi+pBsiRoSlAtRMYKO4DwPwnJXi2p5cnNrYbtISx3NYP00RENTO15xrJ0AH7FhTkHut/hEtiOZBj2T0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5761
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

On Mon, Jun 08, 2026 at 02:55:16PM +0000, Ciara Loftus wrote:
> From: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
> 
> After admin queue reinitialisation, completions from uninitialised
> ARQ ring descriptor memory may arrive before any real PF response.
> These carry opcode 0 (`VIRTCHNL_OP_UNKNOWN`) and trigger a WARNING
> log on every poll iteration, flooding the log during reset recovery.
> 
> Treat opcode 0 as a distinct case and log it at DEBUG level, while
> retaining WARNING for genuine opcode mismatches.
> 
> Signed-off-by: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_vchnl.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
Should this be backported as a bugfix?
