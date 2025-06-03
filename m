Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF76AC5AE59
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 15:33:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BBEA40E39;
	Tue,  3 Jun 2025 17:33:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id B2B54402C8
 for <dev@dpdk.org>; Tue,  3 Jun 2025 17:33:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748964820; x=1780500820;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=q0PflWyWPuqQHQKt2Gkfkoe3NDuO79oQZVDCDLBW87U=;
 b=esz+obfQ6DJouPAFchSDJ/eYdTaXewQNOKMv0hGY6lULJ0gTt83UDvqH
 fez73YkZYUCngLqd/bz8mQwcL+QnRdV5VAFG+lMVVcyZJRCh45S5pa4HX
 CZXfXAuH3H9SBtcPwP+jhOJCWhFQa8tLXwCxpPcMg8szYDDAvaeKrZHEb
 zvGN3Zsc5rHw01gQrGGOhjKbjqOfjdj6nM6GHZIi5ct2x/ZpqDs7PzLBY
 wIs230/M96r/IEqFypPex34OeqqYcTyGKT+mCrtgt/V9PbLqMhIrhgl4+
 pVlfBO6w8qoH35KGe40Lk9qxzbn2uEf04tg/sdjohYsj7mIlC6BBBpNUL Q==;
X-CSE-ConnectionGUID: fIZW8NRuSdCRL66tTit+nw==
X-CSE-MsgGUID: RL/fHrIBQqKUJks5/bhN2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="62402690"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="62402690"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 08:33:39 -0700
X-CSE-ConnectionGUID: yM46u5NFTZa6SCxJS1GqFA==
X-CSE-MsgGUID: wdirxpwfSqWlAGvbosRgtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="145514644"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 08:33:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 08:33:38 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 08:33:38 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.55)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 3 Jun 2025 08:33:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Atv7bkeBf/aRRRf1cCzqAyIoHcMZwklopiLRkGR7hzX3mb88RCIYeanmwfr9OdPbAAKM0lHuk/lpfUgna0UOKQaHor0ZY+Mm2P991dlG1Si7LdhO+iLS73MwFmTkeGg66RN1Xp8SGVFlVNRohHZNKN971SNVzgWybpMva4YbA230FA4COEy8wOQESfuh7Q48BfbmkiG+2j/twc+SFh3JzBFnx8Ar7UlIm7KXOXR0VE/2NlMgMPmGxxgxqTCkMh2x2JeIwpKNG/pi3ZXSRogZ5rIq+yFh3mx6MtE8c7XY/ADeG4LOV/uUalZz5zN0C0x7rF/IEfIWNBTOP2QUwNJe6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftyOwaJ32nKMVu3FdcRUWOeeQcIqNeYuvkt/k6n3gXU=;
 b=Sq4ErZbCpFV1JnsQqBij7LSGr18A0SP8rtMPM9nXR+t30rrDU9JgL/nMyUErYUsQDuFvj6PpGwMglbQfQiPQjd4qhK1vhaJCwuAPDnEp6D+s2cF/JO5W7ai/UaGOeHVOng0UP7CMa9IYxjxcKqA1H8o7B52hj5OOWjN8wzjyoZ6NIXanGrtDoooABhL6xjiqhdrUb5oZKCEtmGvNunOb0e7vx/1+kRva7NPH8kNpQRYY+/eTwXBdHZbIU/BTNsTmgqzIvYTiER9miBRm2Avv1qHvgWQLL1nxDWhLp65U4W1nsn0dtB2WiKQzeiAXbr7zxigUFuDonfVXuU2DB6SiwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY8PR11MB7848.namprd11.prod.outlook.com (2603:10b6:930:6c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.19; Tue, 3 Jun
 2025 15:33:34 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8792.033; Tue, 3 Jun 2025
 15:33:34 +0000
Date: Tue, 3 Jun 2025 16:33:29 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: fengchengwen <fengchengwen@huawei.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 2/3] argparse: make argparse EAL-args compatible
Message-ID: <aD8VyfsBPl3rd9-K@bricha3-mobl1.ger.corp.intel.com>
References: <20250527092113.903910-1-bruce.richardson@intel.com>
 <20250527092113.903910-3-bruce.richardson@intel.com>
 <b58d1963-c4ca-4049-95d6-11293dc85e67@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b58d1963-c4ca-4049-95d6-11293dc85e67@huawei.com>
X-ClientProxiedBy: DB7PR02CA0028.eurprd02.prod.outlook.com
 (2603:10a6:10:52::41) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY8PR11MB7848:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f329e76-57cf-49b6-747b-08dda2b4008d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gVd/j42Z2me/AO/VmX7oEuhHPnruKIBdFXXLxBzoFdNspb+Qr91s0qInvoLw?=
 =?us-ascii?Q?pbyWOV22kl899iJ93QcLjm9iuUFkX4zxxVpJJ0eqBGQBxdTKFeVToO1RD0U7?=
 =?us-ascii?Q?QgZCo+eUDqwOTN1JVLt3KefGNvi/B8FhyS0ZnID639jNK/A7dPZrI4Vh5HQ1?=
 =?us-ascii?Q?Dw66FmwUwTPOHrb1sPUstxvOvRwM6gL1Ho1ToIjMckhaJlvqm731Qr+prc0p?=
 =?us-ascii?Q?Y80lFX/OxJWTiItFsQKVZLXub6I16ru7kfeQ62ScBQSMCug98uPe3TBp6W/k?=
 =?us-ascii?Q?mJPhKNpOXn6iR29DVHl3B7sT0wWJdJjZK8/ComDmeqrzR+Bddye3FWCos5/c?=
 =?us-ascii?Q?+qh5YXltyjrQ0cGYefsIQYsOuJcdOIUhWfUJ9W7V25EWOEQ13wt9b8SqzdqA?=
 =?us-ascii?Q?2UrNVNcs0+nOQ5eK2vIF7+C+T5E6frvWO623NkaZLo+PVbG+5lCC6CmGRKXh?=
 =?us-ascii?Q?s7absT5X3jsfNuN1PHHQ0MvJiccOxVXeIEcYRd1bzXTbLtzNJZkwFVIAJGu7?=
 =?us-ascii?Q?1pLKcmGclfN5xh4FJ3OUeF8niCWG/mqybaEaFv+HuqWS9cIp57zz1J6h11oE?=
 =?us-ascii?Q?6dNDXDa7UOcaGKDfuXG/3XxoIey87A8WmSQ4MRR7i/shg8iRA2DrhLiV+0WA?=
 =?us-ascii?Q?5YBXNGYPg8k8l8UbH0tXv29UbzHebJp8GHJ+6+hS/aRaBcdIHzRopsNU1RAx?=
 =?us-ascii?Q?3iLtDFltM3MTEAnL75VsztRk7geIQ39eGzIwREcksHs2DT0wXizH7zpMYoPH?=
 =?us-ascii?Q?b2EgPfikA5+5hSaIxw93taOiTGsFCce9aykNUjmDQrCN2pLZR+b+vuyfUXo0?=
 =?us-ascii?Q?k/M4ef7LrkPYO8j7I3EIcYnBg75SZjsDJBGb3N/KhAf3BOubOpRqsWOzbLbH?=
 =?us-ascii?Q?p2YAm5HCpQHLbeGBiDk34RSS/8prWXwMr/Dbgqwke3MWEC1fU8BvO0XhPDEf?=
 =?us-ascii?Q?G37P1xM+8vEMDmyPycan5euZlBK2n4ckmhVNM6mpExhzM5xXFE5j/blE/r4H?=
 =?us-ascii?Q?n4ymt4vHRvQUyO/EW73yiql8fqdZaRZCbAHW+0eHo+Lvf20Pv0uEB3Qmayla?=
 =?us-ascii?Q?hliWvJn9Q0+T1p9QelXaKL0bMGgAq6dlTtCY5YN2hPRQtJJqY30d4Q1Xu9Hh?=
 =?us-ascii?Q?/ztSXDnxKHfi/VCofju2PknbJW688dfmuC1CQfD+S6Ux7aTqFmsJ7M07iFTv?=
 =?us-ascii?Q?FhRjOkG1LstREIGk8ZsB+cT5mOuP9QRED0LCmLuYKpwVB/xQ9GeWyvKBJSzm?=
 =?us-ascii?Q?+5JDWedZeV13wDUx+WyaTj2n3pwW+ehJy0/6ybaNxYu8HJQHB6qwHibm57Ij?=
 =?us-ascii?Q?AneSqe1N2paSsGpR76SVRDXfs7aaM/eP0jazOvriUwn7fxQZZD6C6Dl3RtjW?=
 =?us-ascii?Q?KgKetPxZmaW+ap9gokc10CtcreD1UHrxCYBBNbhK4bftLiuDWRab+0QUp1f9?=
 =?us-ascii?Q?gy5muWdtq3U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zWw/OILsuv3rMKwMUkhfmSAGSaRhpbnU4G6n6T9ZE49EexIxXY6z8A0nj/yX?=
 =?us-ascii?Q?yEChucTu1CV0sx+eL23gVCngHLvy4xQCgnZcG1+r0acJcYIuTL9jSEcXAu2V?=
 =?us-ascii?Q?DKfbUfq2IRgLyGJr99CCbVjjZH2X/qU/h2H/YmThG4VmxF8ToCbUixwoSKIt?=
 =?us-ascii?Q?HwXIfByBKIsXuMD7MCq6rcSXsjjPepT016eIogGGSmXQUTPcGfMjwffa29ow?=
 =?us-ascii?Q?hBVIhV7o/gJv8gyVtzyPeFNBTCodDTvY+Gth6GdS7E4TwXPITmurgnVDRnAJ?=
 =?us-ascii?Q?yrw3gJIcZcn6IoMRwvp5Am/cn8CGja4w40Kz+jf4g46Si170AVzWHvVWxhEV?=
 =?us-ascii?Q?2IfvMIomSmXL77iyZHrl+hDLhOYQqDrR4PZPs74sCE2Lfqx3VrPGR3fgVBua?=
 =?us-ascii?Q?G99l/9vFeTOXEELf674ANbtzEiLorfSCDx1qppccbbISGRfzc4cWTMz5KsPj?=
 =?us-ascii?Q?p1vgT9R2Jj7I4hsrMX4R1kRh6b4roJP7F+1WWgbdkfPRqfLLhIz93vZVtV5M?=
 =?us-ascii?Q?szBljEKThCqaPkeWicmuVNSDHuW9jak9U+f1adB2iRURUANxlpRHc52j3lg0?=
 =?us-ascii?Q?44mCV/LYlugoQ4Lhv4K2ipORJXUSiCuDtctORGHaI7+BYVP/8rmLsNvZ/xtR?=
 =?us-ascii?Q?PkciQetb9QPY2IvxSubQ6EoLvtZ2/mZN4lfHMSTllhtFUs42S1KnW83k4EMV?=
 =?us-ascii?Q?mgQ5qhxQqhvlpitiqbuUtINJMEooeK+XaJ6gttnPGGVcq+4/L5l98PtHM+g4?=
 =?us-ascii?Q?vDO+/p1mpRo8DQZgWraWMFwxanzNVWgdhFRKEtnPvgJiCqaIu7lEuz9tmCOW?=
 =?us-ascii?Q?q0pocVpzJex0aqtKQCGwJEhdhwzoB6GO26SYAhAs6uR622A48Yz8+yaab0rD?=
 =?us-ascii?Q?z7/okllkZbbUMODSukwcqx33iXwcoxFt3MYLqGTjB034cG/76KSP2o9fyK7F?=
 =?us-ascii?Q?dKZwYfhdaUWUnQ4QEQDRhvQJOD2VNHDLBkyHtql3AIGACL9r+3ViCIPPfyh2?=
 =?us-ascii?Q?F8d55qv0d8QyRC2wBqLdbHyY9WsDIXiQ6aOwI6LFAUUqFS/EmVAbKWn5oi6u?=
 =?us-ascii?Q?uK8I43ljPLf2+GXQeuiSeNP5ij0+hP+UlBIggJ68YDGlOcO4bjMQ4dy9Yo3j?=
 =?us-ascii?Q?VyWY2IbGe2tx1dbweN9tyTwP/y+ggki0RQADp+geiIeydLRL8oVIzE4ccFXM?=
 =?us-ascii?Q?r4yVpnMn3v3D89fgeCtDJ5UN7MLv0rDJY6O0ALS3xYwZBPi29r7V6dsGUAsP?=
 =?us-ascii?Q?4kayUcq+VNO0XuuQSAe3wg7j0JQCSdhO9h4zR9x7SsrIwGPQ6cjn35xefa/Q?=
 =?us-ascii?Q?N7EICvOmfr+FqNauCqV3i0n1s7HDeIpmSMBzg6XnCiBnon1G7I8kHsIU3p9y?=
 =?us-ascii?Q?8R37stdIDEsvzh/nZjTI93W760IebJWGOkWxct3rhiw2ha6IfSQtJUUQszQr?=
 =?us-ascii?Q?sJWjqIwJ90KrVIFi97679ir+1rUbxZujaIO3m4l/BcPUZFNscu13wicb2gZz?=
 =?us-ascii?Q?GJA0aXw5jrfTJR4ycvKUmhzhJYUNItXuhMax/Spqu/vQQBcg+tZnuifcC4pg?=
 =?us-ascii?Q?4jOYAAyCiFfP7593pErsxtYK00Ym0wi5Ekgc9roKFX+oz6lEXvtz/nDSyv+l?=
 =?us-ascii?Q?IQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f329e76-57cf-49b6-747b-08dda2b4008d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 15:33:34.6180 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0CXJsw2I7ttr/oRLPI3DlDgfzyz4WU8mgrlD3t/5ph+7OJsNsZz6K2R/aLn8sdhJZT18zcI49B9EUJrEdqSWy00kPDm6+bekQkWo/S28nDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7848
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

On Tue, Jun 03, 2025 at 04:44:42PM +0800, fengchengwen wrote:
> On 2025/5/27 17:21, Bruce Richardson wrote:
> > The argparse library was missing two key features which made it
> > unsuitable for use by EAL or any program wanting similar behaviour.
> > 
> > 1. It didn't stop parsing arguments when it hit a "--" character
> > 2. It never returned the number of arguments parsed
> > 
> > Fix both these issues - the latter is a change to the ABI, since we now
> > return >= 0 rather than == 0 on success. However, the ABI is still
> > experimental so we can make exactly these sorts of tweaks to it.
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> >  app/test/test_argparse.c               | 46 +++++++++++++-------------
> >  doc/guides/rel_notes/release_25_07.rst |  9 +++++
> >  lib/argparse/rte_argparse.c            | 12 +++++--
> >  lib/argparse/rte_argparse.h            |  3 +-
> >  4 files changed, 43 insertions(+), 27 deletions(-)
> > 
> > diff --git a/app/test/test_argparse.c b/app/test/test_argparse.c
> > index 6b0d1524b5..a907fbe53f 100644
> > --- a/app/test/test_argparse.c
> > +++ b/app/test/test_argparse.c
> > @@ -360,14 +360,14 @@ test_argparse_opt_autosave_parse_int_of_no_val(void)
> >  	argv[0] = test_strdup(obj->prog_name);
> >  	argv[1] = test_strdup("--test-long");
> >  	ret = rte_argparse_parse(obj, 2, argv);
> > -	TEST_ASSERT(ret == 0, "Argparse parse expect success!");
> > +	TEST_ASSERT(ret >= 0, "Argparse parse expect success!");
> 
> Please compared with specific number, eg. TEST_ASSERT(ret == 2, "xxx");
> 
> ...
> 
> >  
> > @@ -780,7 +780,7 @@ test_argparse_parse_type(void)
> >  	ret = rte_argparse_parse_type(str_invalid, RTE_ARGPARSE_ARG_VALUE_INT, &val_int);
> >  	TEST_ASSERT(ret != 0, "Argparse parse type expect failed!");
> >  	ret = rte_argparse_parse_type(str_ok, RTE_ARGPARSE_ARG_VALUE_INT, &val_int);
> > -	TEST_ASSERT(ret == 0, "Argparse parse type expect failed!");
> > +	TEST_ASSERT(ret >= 0, "Argparse parse type expect failed!");
> 
> No need for rte_argparse_parse_type() API, this API still return 0 if success.
> 
> ...
> 
> > diff --git a/lib/argparse/rte_argparse.h b/lib/argparse/rte_argparse.h
> > index 332184302e..8cdb3195cb 100644
> > --- a/lib/argparse/rte_argparse.h
> > +++ b/lib/argparse/rte_argparse.h
> > @@ -183,7 +183,8 @@ struct rte_argparse {
> >   *   Array of parameters points.
> >   *
> >   * @return
> > - *   0 on success. Otherwise negative value is returned.
> > + *   number of arguments parsed (>= 0) on success.
> > + *   Otherwise negative error code is returned.
> 
> Please add note for "stops processing arguments when a ``--`` argument is encountered".
> 

Thanks for the review. All 3 comments fixed in v2 patchset.
