Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1364E6817D
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 12:46:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1653740261;
	Tue, 17 Feb 2026 13:46:55 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 24FAA400EF
 for <dev@dpdk.org>; Tue, 17 Feb 2026 13:46:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771332413; x=1802868413;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=aCjTIY0+uSGW2Yk/idy6SlodVAZHepr8TqBceb9FSZU=;
 b=MF7UCESRzIZ9le6kRKOJgwB4+HEFscr8mitE5ot4z9MYIU6BZuB1ecmc
 Q25KhM0K920ZcXlYKivpPUqkNCx/8pxr/+qAMb63g37jWsTmg3dk9o4MR
 ix8Cs2CNYHvc/PIhJ0r8T2eqHlAAmar5Fm3UCTTN7hNNl0EZJ3k1k/rTB
 ZC8bbgW5nif/Pvt62GornOWxpEDWT7BmWNfJ/Q+pocrC7dzbh9xZmIKpT
 A1Fh7m3yXdMki+5mni/SRMS/Ch8DLujq0l3Np0TYj8AqW3aQWrXa7hzvI
 cmlz8BnQTdUMEP6KszRWQK9VYp+KfHQgREseMxbw5QQppAsvr+ESYqjwU w==;
X-CSE-ConnectionGUID: CAaTIyrBQqaTsZXIi+Hv3w==
X-CSE-MsgGUID: qabGn0wLSMGA4e/qpmvy/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="83120790"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="83120790"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 04:46:52 -0800
X-CSE-ConnectionGUID: Fl98bBPISm+aKTb9ITWpzg==
X-CSE-MsgGUID: OHI3PmKWTh2q1LsTqY1lJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="212596497"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 04:46:52 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 04:46:51 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 17 Feb 2026 04:46:51 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.62) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 04:46:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ut+L5er7sXoXNT8jAEKYxALd3dQlBsTQjve4k1//H/m2VuoPr3Y1/YPuh4xIwwh9m+OEXnf71mngPPqxxgZutroAY1YbEQLIRYX77wk0FB5QYmOZpKiaoeZjqi9kd3N5dyZqhZ4oKCSd2ZspWuptk+wL5X56hHLR6LEFjJiqcY796iGrdvl3jYMhlzrJ/Wg/KF39WTg4Za3eTR2wT9vErJtwkxGr8QprcVMg4cU6B0VcqKTrblIIESlULiCHXkdwTHgeTOOa53gNHcRy2Hs4+bPZEuEBqpZBwaAKYwvzuz83fgVEuqJItKH1TtrvXwrkuZv+pxnPn4aXbIBhJP9qzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GsOTo7BxySCWZBohdyj/aF6R56Jknq9lZeEZKQMfzI=;
 b=uIxxUA2OuN8d7zYXa/+HvJnI0j0piFqptdozWYJV9/op1zYsa/nvWmtQSFgxBffsBS8htOmc2ffc6Lv/IwUC8qE2E3oYyr3XrCf4tGKFYl0SAd34QBQrco5sFH6VS+kuDX5poXTrOSd8mio+c3SEYk0BtTH/lVBdHojBIVqTYKJkwq3Y0D2n7AlUiqGiI7y6oqMdBEVxQHq8CXvBqK9GMM85tMggLn5cO4adJjtXOZ4srnSHbcHXAhZtmAQUIoDqvUcpRUk41RIIPk52GJNHP3Mz36YSjKJbJf1pUvvU2RGiF7/++91LEQjTw2SdMQh0RFme5AenmSR9cd+81ESnWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by IA4PR11MB8891.namprd11.prod.outlook.com (2603:10b6:208:56d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 12:46:49 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1%5]) with mapi id 15.20.9632.010; Tue, 17 Feb 2026
 12:46:49 +0000
Date: Tue, 17 Feb 2026 12:46:44 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 10/27] net/i40e: avoid rte malloc in RSS RETA operations
Message-ID: <aZRjNHlyUumWaEwP@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1770817884.git.anatoly.burakov@intel.com>
 <cover.1770817884.git.anatoly.burakov@intel.com>
 <18276a5e4876d084096cccf6f40ef9af87fedacf.1770817884.git.anatoly.burakov@intel.com>
 <aZNOm5EGcN7uSeVt@bricha3-mobl1.ger.corp.intel.com>
 <ad1ce316-2694-451e-8a51-2008a65cd8b5@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ad1ce316-2694-451e-8a51-2008a65cd8b5@intel.com>
X-ClientProxiedBy: DB8P191CA0027.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::37) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|IA4PR11MB8891:EE_
X-MS-Office365-Filtering-Correlation-Id: 84b5bd2b-9bc3-4efe-2fa8-08de6e229e24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ciQ7iW3Nkcz/3ZejgZrp+o7ctYl6fUpebz8v8WVPlQ6IvRC+Zaq89XK+7Ptl?=
 =?us-ascii?Q?sIsLvyRIaNhQQsYTCNC/tHockV08/gBGPXgb9b3/zOmFl37dH7l7dhALA06k?=
 =?us-ascii?Q?X/uYn0jmXCjF9NbJHu6/L+JKfQ3//6x8i5ClwY2944ouIxuqvgiWnu5JfgUB?=
 =?us-ascii?Q?N6xPqLFGW04HeN5UIX276Pgvpfdflrwle2E3Exs7f3Jj0uF2UO+IlMGKDNCg?=
 =?us-ascii?Q?h+ZwcwNTH7PDYTM7kxNCns6BV41JKmEfIbu0AP6CaM2BHbzUI6O4TmfG3LFI?=
 =?us-ascii?Q?b7m9foo9VMskk0oYro4HNiwGPlbSpFjZkheXd+OU3LiqTB41USdQvwaTG8P9?=
 =?us-ascii?Q?JNFZJbL07She8YddxU7atR6dJDmT4jkaVg2I3ySC+0Qeq6lDcwK4KLVoenX4?=
 =?us-ascii?Q?dVMr3zh7Iusx0uVyQK2N5xtOwhsr6kvw6mkL4Bcg2xWyw7avNWDP3w+gidQ6?=
 =?us-ascii?Q?5j0jSkcFr73kX91n6CeePlunO53wb2OBU1mH7CdxTVOyiLzPkz45dXz5reN/?=
 =?us-ascii?Q?Wt70sFUHhaLmj9AnZm04kPjQre1SAGmQkaL3sfzaCg7UK9GaiLffHSdgKU/k?=
 =?us-ascii?Q?I0/gN/AvBuQ8UhbpEV0ybXqvcJHD5eLqtd31aOnGalFc2VHGKNKzeQ637A3L?=
 =?us-ascii?Q?lISieUw32H02y+v94cM23+rmwFtFfhWs2QV+Kir+xE3e3meFkOfW1fgI2aP9?=
 =?us-ascii?Q?FefyDKSq4ZfYz1gWbDYHLHpX+VMd/+w83SlJgg/TyEQiOn51t1Z5qBvtLGUG?=
 =?us-ascii?Q?dEsEs3PerGSJ3aQ0rTo9KTZTxDM63j2n7uxEn7vMO5qGQwKLAziPyrAOs1Ce?=
 =?us-ascii?Q?mZ0bTVzwV2DMQ2aaq3ASpxIVBb/rYO98K8WEgj7U9yh5/6pEJ5ShpFoClY9v?=
 =?us-ascii?Q?B9vq5Zox9Vk9vaKfu8KYRAQ9Hb1ypIBURxBXHZCCLlkFfr9+XnK1iXbyUcam?=
 =?us-ascii?Q?Gp6A3YtsxrYZKsk3v19+WSbjWQrZ2AdrwR4Sqn132jZILT6LBPzKGJ+ifBCO?=
 =?us-ascii?Q?NNjFbq6xbHKrA+N7ixG+jl26WMZlRHZHCxLCaNRf798FWRGI9LutN5jIqXJv?=
 =?us-ascii?Q?2Vhfqfpz8sMjJAtS+qkF4g9VLbBWYNlJQygZkbf5RLoRwOCqJEIyhU6eqaSA?=
 =?us-ascii?Q?1QRoSupphn9+o5NIf67Oj6cS3k/PptYV/8AJGkdaRd3sL7LjWHl3rQtBDS4C?=
 =?us-ascii?Q?vguLb+jpk8DXUJzzQMZaQRj8EKUnM/k0yRR4ooGHF61xZ9///M99kt7D4Sny?=
 =?us-ascii?Q?xTpbIcYI4Z+V+f/e347E9z7dmnqqyv2z58Q4nA8falh3/Lgm+HquyArj23ZQ?=
 =?us-ascii?Q?2cdzn+buVAKwBJzqPEa4GxG6mj+0TrNY17APHowof9kmmhQ3uTGie5B2DJB8?=
 =?us-ascii?Q?XqR5J+zlf4qpv2WIvEAXV9kvCox68xy/qJ7YItNjeDXbBRlfhNXHgKq7WUX5?=
 =?us-ascii?Q?arZOdKcNuUSkPLuSVPDz0vxIlJFxrRuCGWLbUikLqVSJPXqAhqy8rJilXizS?=
 =?us-ascii?Q?S8YaGdsOH3g8WANXhgwAnNjHiYW6G2btbdtcPLPmDddcaqftby9IzKs2SN/j?=
 =?us-ascii?Q?NJblF//1qhAnK9jbxkI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cDqH1rijIRa6JxCZ7jRAg4RSwFTNg4/SyUMhquwx2Tc8oQrsEsUv7ABLuqGL?=
 =?us-ascii?Q?1PDC6vNacH42C8Pdq0kd/dK0VLCrVoiPKt/t+IQnU6KfQprpsFEWzmqzJNfI?=
 =?us-ascii?Q?mt2awhmQAfQF20lrOtSZ6lZYL/lQsry+rx24Nf78vcNoDVUX3MXjyTEZMOs2?=
 =?us-ascii?Q?NhTY0MTYZWmRqB13Q61TJIoi80hCm7gZbJFeJFCAV5ZPzpG9UVPoqFOXfDxs?=
 =?us-ascii?Q?037UJSrjRyKUuA4FzgIPOiRXGxQGbpzbZE7nE+mw/Q1wwEe6KKBo7rMrQ5d6?=
 =?us-ascii?Q?RuZ+8hp0pWMItPF96QRfrFfCdvnNeJ9IU58A04ZksKuxoOCTF06EjTU3jqEz?=
 =?us-ascii?Q?zi0IwihQWWFT/VI7ZjwmbsCo0ndxShVNj+TZOBWtGRPXSuFwVFwSp9Clrlcp?=
 =?us-ascii?Q?u+3hQciv17BFWTK8tu0sBlNnBa1qbVjnr//eOJdiP8XeRtwol+PuMKsiMlyL?=
 =?us-ascii?Q?uVFKQnzl+RLKETcbusbLXc/1ME0QFeF6f4kaYHAGNyjkQ/QV2Lw1t3RXmRYT?=
 =?us-ascii?Q?MQwJZ0pCoxU93XhlBqvUUvdnhZw5y+G+NqZHZwfvCU5nvMpEkG0ypJsk90xu?=
 =?us-ascii?Q?/B5juz91WGShMo0apHCqWrUgpC6BZfGpwgagVbsvEMeHMhmWwN4wcEchmH14?=
 =?us-ascii?Q?ZQpn5lsgrC0z3DatdwPmd1P8Dpa3c/0AzjBnRqTaBRvRSTnV9tXzrXkgIfnc?=
 =?us-ascii?Q?x5mbwJUkGkSdXszP3Ia4UD7kziohgXdS3/YDvM2YxXMEYbL8S3TM4U73jvd0?=
 =?us-ascii?Q?K1cSuX3amlZOSuTLZokYqSgAmAVJZjscpRy/9z224j1kTwCKyWwXdLYFjYV+?=
 =?us-ascii?Q?GYSJzVG4OhTSP1ObD4/nkGt+v/Kowt9pFBwcKVqI10D4gvUkVtcmbv6vOeKg?=
 =?us-ascii?Q?9BymcsPlOcWA91tlU6s0nI8IoZUMJrtJntT3sOu43pvGV0tQ5okNb0iBHRTz?=
 =?us-ascii?Q?BpV154CY3UPs8eHifkWjiDJknADVsKiZvbdj2rZr/H3Yu1cv66Qd5gWA5NpA?=
 =?us-ascii?Q?2NsoRiq1Pqx35bwc1Fq/Sf5i8suZixP5VIbQajuTmHMzqW547onVyshYsbB+?=
 =?us-ascii?Q?3jqG15RTq15YWN9UtkSoP+ugKgnU7+sEjhhHVKwdK68OTg3l1uRSJlaqU5PY?=
 =?us-ascii?Q?0sgQj1y2l5rd3jEEe0kNXkP5ce+Fo8tOsfz5sJ8uLrkWDMO73VT7qmntkkOd?=
 =?us-ascii?Q?th0pWlrYdcVy5SH6ShlmjaesYH6tCVdOca0nX+5yJvd3BeO81gCgv1PAGlT4?=
 =?us-ascii?Q?yaQTVA7WDrthr15RIXiKR0OcbUuj4//EjEi8rKAJh/68h4hqh3Z4SCTn4wPt?=
 =?us-ascii?Q?F27d6Hix2z6yluaN7EWfs9TcUt548I9JZZZlWEG9GAGKM9nwgILNWTl+QlCr?=
 =?us-ascii?Q?txCuMy9Dkirb7GXLgiHXFbz1bLdtbkXHjM01k0BazfXynhOM2vNMXm+Sd8Lq?=
 =?us-ascii?Q?pb4rp43Y+EjUBe52EAwzjhzcaaWwE00tAWqBtsrZUChDaDQD3rbJasm+4bLl?=
 =?us-ascii?Q?FFYSIgDkMhKUtBc+4uSO0saKDGd946XllTfevjoeSIZdL05f7KGRmszPq53T?=
 =?us-ascii?Q?m0GD4b5ElhbO6ongxjmT22R8+GVjhlALZupvWfF9mLRLY6vENyUBWA5UfkX6?=
 =?us-ascii?Q?k6t0rn/VrZ0ncYI5cKlyl5X2hSrabmJlLgLYNC3Jrrh0iufhiwyGB8zV0NcR?=
 =?us-ascii?Q?gbTOZuu+NYv0UNmS0vQciQVOMhIbq/AqEr8NLohlJ/0+zt1EQpa6IlZr4+zO?=
 =?us-ascii?Q?la4kUEi6PctTSaMNvg7SwtCyeLxLkBg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b5bd2b-9bc3-4efe-2fa8-08de6e229e24
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 12:46:49.6919 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l0ePV9ydvnkvCQ5I4MO3KTRQpuYdrOyHA+ma+vBrQg5kLSgqnc0RoSq6gCUJW6buBgn9T/M34mE+GppNjwmcLdIAHS+rA7lbObgu+PfgUOY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB8891
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

On Tue, Feb 17, 2026 at 01:32:05PM +0100, Burakov, Anatoly wrote:
> On 2/16/2026 6:06 PM, Bruce Richardson wrote:
> > On Wed, Feb 11, 2026 at 01:52:52PM +0000, Anatoly Burakov wrote:
> > > Currently, when updating or querying RSS redirection table (RETA), we
> > > are using rte_zmalloc followed by an immediate rte_free. This is not
> > > needed as this memory is not being stored anywhere, so replace it with
> > > regular malloc/free.
> > > 
> > > Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> > > ---
> > >   drivers/net/intel/i40e/i40e_ethdev.c | 8 ++++----
> > >   1 file changed, 4 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
> > > index 06430e6319..654b0e5d16 100644
> > > --- a/drivers/net/intel/i40e/i40e_ethdev.c
> > > +++ b/drivers/net/intel/i40e/i40e_ethdev.c
> > > @@ -4630,7 +4630,7 @@ i40e_dev_rss_reta_update(struct rte_eth_dev *dev,
> > >   		return -EINVAL;
> > >   	}
> > > -	lut = rte_zmalloc("i40e_rss_lut", reta_size, 0);
> > > +	lut = calloc(1, reta_size);
> > >   	if (!lut) {
> > >   		PMD_DRV_LOG(ERR, "No memory can be allocated");
> > >   		return -ENOMEM;
> > > @@ -4649,7 +4649,7 @@ i40e_dev_rss_reta_update(struct rte_eth_dev *dev,
> > >   	pf->adapter->rss_reta_updated = 1;
> > >   out:
> > > -	rte_free(lut);
> > > +	free(lut);
> > >   	return ret;
> > >   }
> > 
> > For i40e do we not have a reasonable max reta size that we could use for a
> > local array variable, save allocating and freeing entirely?
> > 
> 
> It's on the order of kilobytes I think so I decided against stack allocation
> for this scenario.
> 
If it's only a kilobyte, I would tend to go with stack allocation.
However, it's up to you.

/Bruce
