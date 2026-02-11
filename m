Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA6EE9E319
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 14:45:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA84140612;
	Wed, 11 Feb 2026 15:45:09 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 07C1F402D3
 for <dev@dpdk.org>; Wed, 11 Feb 2026 15:45:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770821108; x=1802357108;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=mz6ojbb/64wCWeu/xAvD+uInhXV7hfrVcX5D4hfycKg=;
 b=E8WyGjJsS43AvOywK4qGVNaYgSgUBBULN7unS2Qa5kYczhS05xrmkS9D
 wu7tANQ32PqWqOubptRDmNmlKCGZKLUh8GcHQFmcvD8gmZ3yIUiFfpShs
 V0WHvCzfK9mFohOEmS18RqiqJH2HLrISDwEbYDLIZWPuLa8asjKnmqUzQ
 jWtGmwo80IULz6TPBIrY0nrbJ7QuIjN7Vwbl4qfsI+/d1lcrwnksXnlhY
 ptWuJDujugJQV1Bjr2m5RZVAKbDWK4uxaO0QmdWXrR5ml4qzsehTfYBTh
 99s+NLN2s8Pc+QOVrp+Xtgn6ziT1GrK0HB/GYIab8inDmK4IWoOLV6xMY A==;
X-CSE-ConnectionGUID: 2lWWZ8jlRm6H6RrXBClFaQ==
X-CSE-MsgGUID: 40Dn99QESzqDHlV2GfF3JQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="72012706"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="72012706"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 06:45:07 -0800
X-CSE-ConnectionGUID: AvgD5MVJQ22sI6NQc918+w==
X-CSE-MsgGUID: L6iFzSPgQmCSyL4OCkgWcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211860701"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 06:45:07 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 06:45:06 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 11 Feb 2026 06:45:06 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.52) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 06:45:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XlVXhVKam/FDAXt6NTJvdrPCLQNFLIbNzSe2/f7Fmr6r2rql5WRatyXXFAL6Auz/3P1tBGxakryBVGzKG+KGhnzlDW49QX0sMOMAaQniw81zU2aLFSxwLa3ni5Yw+Il44iAK1AUF+wQhJCGzK9YPXsUfpZmwqUnVz2aM0vepd7H8XpO+7JIzm5n7UsFbjHtKAWkyD7xlR1i2wnZHfAT8CyaJN0X2z3gpFvQhTFwzaqM7y/1n5lnZSIcQycLhZYvT29LOpGOC3c9PoNshv/82/yt8WFmz6q/SSbV8nI75fZgHOv0zKsJab8GfouWJ3rYyTnVy12u/f1mpqWsd44LClA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dP9sOW+TZFZA9yRtsvGUE3WDfvuxQ50XIdXI2WqqBIA=;
 b=ePGMwb82HL4Tz1O77MGm/kc8p5DY8fKJ8V4+Vx+DKuM0XNHE4bRh26gH4Xpnz5B+AKHocAruzp+T3XhleWK/aRZtiPMDizgOAzdvom433zmtNe1q1neImwfYdgj60pR8wKV57yCEt+rqhCxfeqU0PEERZ8Zg3Ztp8To0OYg1/wfP2NCSb9rp3peh2IzXBdutCxoybCAWUAnrgI9ACLYISMZLfJM9MOS9An275Vt0EowVSxGnlwgxdRtsFSGvNGOlicKT3SPrLqsVTOOyoWVu/KmguHCHal3JZQINffUJxG+a08x5N1jSYDwgEorvfN8BIowwMTcp2x4jijUiYeN5Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS7PR11MB8826.namprd11.prod.outlook.com (2603:10b6:8:256::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 14:45:04 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 14:45:04 +0000
Date: Wed, 11 Feb 2026 14:44:59 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v4 20/35] net/intel: write descriptors using non-volatile
 pointers
Message-ID: <aYyV68L3AxsnXeMS@bricha3-mobl1.ger.corp.intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-21-bruce.richardson@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F656F6@smartserver.smartshare.dk>
 <aYr0bDamNTwyDl9D@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F656F9@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F656F9@smartserver.smartshare.dk>
X-ClientProxiedBy: DU6P191CA0024.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::14) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS7PR11MB8826:EE_
X-MS-Office365-Filtering-Correlation-Id: a3405c09-ab99-4f14-be54-08de697c244c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?LFYtLuKMUwBcbXZ71KvH9ZbTq0863eejZaYvjEVP2unQD3qcZpmb8KqPc/?=
 =?iso-8859-1?Q?4B8BLRf7uHEwjzHlbTYDHzxnwJxr25woJ+KP6BmfdA7poTQZyVRTxDcD/E?=
 =?iso-8859-1?Q?z/52vcEiEMKE/sROMcBfPczHtPPm9q7R+UZTV8bSMwIMeB6f5BWZMbq68N?=
 =?iso-8859-1?Q?19ghuCOIi++QkRjA9Wztspok6fiGpNkWQ1RurKlzWxRAMUfG7G/bsDwYdz?=
 =?iso-8859-1?Q?PXv8f0d2fGvLiulO4d8UfJqIokzgQhvSfeCyzBAvjAXscMLiOuTB3E5nyE?=
 =?iso-8859-1?Q?9KZUhTJdF7mhe2Iuwy7XtBEi/TTN8fWHxPmwOzyQIjyC8q+E6q5u6CXl6g?=
 =?iso-8859-1?Q?BIIJS9cUHp+6+CeylN7eZ8K1/o8i4ru8uVX5rLTo6aaN4EIMpDlAnO4U0F?=
 =?iso-8859-1?Q?C2dWdIQcbm1GP4jVFMgf7iXMaAaOJjbq57CpoBF1TyaM6+LnLcFfA1EHKF?=
 =?iso-8859-1?Q?nlfpIEcW1OQldx45Yrn/UAGNMAnliB8SdkpfcELj9s2BOGYMXaue5Celpx?=
 =?iso-8859-1?Q?EPdZ9n4UPskwN9Mh6XUEp6GsTOCd6JQkEUVlkG4Fcu3jfz5exDqugColxJ?=
 =?iso-8859-1?Q?GEiiy9x2kQtW83V/gknMU+Q6f4KDWLZO6gmfAzGSSRvznYGUJnh0x6w0dz?=
 =?iso-8859-1?Q?G1rO7jE06XD46nJDlakoOcgh7PL6kN7Lt97j3O2WKW4qMfybWPUCoreCBf?=
 =?iso-8859-1?Q?zmT5mbs7LSw82dtKoceloSP6qAcX+V/hoi/w6uPAoekwfqFkrpPDtIva73?=
 =?iso-8859-1?Q?VO53ViDjQMtFuYfOY/YBXvh7kLs6MFCcDMJEX34jJN+K7BqQ7byBSSBBGK?=
 =?iso-8859-1?Q?vab9oztuYnbmwUtpCZZNHlu0NFWLNA4pjjHYUaJUqSHj6BG4AmsI3FpMXI?=
 =?iso-8859-1?Q?RnHGt2jImCSnPmaElczfLwhh6UcuUC3gZKectODgXXG8fxTKj6VwGpoox5?=
 =?iso-8859-1?Q?sDvSh4ciXPHhiZ9vXOHqbmxH5Lr7MuoX02EL0DC9Inx2fD3qc8rCt6TpgO?=
 =?iso-8859-1?Q?/AU5722JMWjqJua/D7/WZBemDJuglhmJFJLkkp8dCf7LZqVHk68NiMgLgi?=
 =?iso-8859-1?Q?By/bfynDJi6naQAS+RLyftl+mHbFivjvAUjwa105SC/Jf/0X9PGUndszqU?=
 =?iso-8859-1?Q?4FItVEHCYF54Kp/82qA2RyK9fzfBco19SvsPxkwH8zdjhFKJIMdWQ4oZ2u?=
 =?iso-8859-1?Q?LlYwwmkS82YL6oxswpvn9ehQHAmrGhWTqRpsG5QGsBZuXiMBJRzqoULnMV?=
 =?iso-8859-1?Q?M8D8g5u6ODyRDc3VuOFNh7r1tfIfzo57cohdrLTJhr8XgDZBCxPONB5SyN?=
 =?iso-8859-1?Q?jDE/4DozxDgdO2/C0nbRXoWqHkgES+aervXpaphuniNgp+jJ4F+tOhKkHv?=
 =?iso-8859-1?Q?1XgDu9PzPj0cXlIzvzKfA9HSQ1aV1Urdm0SqKoQrYXy4ZcjcWzBTV6HZsp?=
 =?iso-8859-1?Q?2UvQwOtQCdOPhKeC9hpyoda5aqBJ0j04Db8vyPkrce0mU1PiEGRIiWpEqs?=
 =?iso-8859-1?Q?sfvhjLnuaNa/ka6HZ0wd6HSLv+GRFKPE48FuB3A/TXiUwuP8zdsYrnV5FE?=
 =?iso-8859-1?Q?y8xPYKDvlJAnVbD9q8HydvKHdNRZky7XfgAIsEdIS9YolSCXED4dRxK+XB?=
 =?iso-8859-1?Q?a6iPQd+/KTJeA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?TMloqtlLyBVKc+bSfRyJsgSeZEsvquEfdUd5KS0LZrqzHh/nUIL4Hq21fY?=
 =?iso-8859-1?Q?hZDazueHLVCptEsAYSPJftx4BrmiJ6HIn3DhQe4Tv4WaKb9tprymHZbRYD?=
 =?iso-8859-1?Q?3kqIpld/7k0bSRmw8OzKmhPLKVedRU70PNbwPRpHbkIPcrCH3BmH6YVF16?=
 =?iso-8859-1?Q?2fu/eiu+8xZH9sQgD+xxLg44u0O2gB23sBqIq6qHcwuIpDK8dUHqK1Fq8c?=
 =?iso-8859-1?Q?RCP3rIKn4ZN+snqleFBwUYU0gOhhcwZ7iY2aEhe4s7GaLxNcVeRj4qiBiB?=
 =?iso-8859-1?Q?9O2gQNvrfQW1d/A2RjEhCtTJDxKyygSAMPryTDA11KyJwlMLwfLrxSzOoo?=
 =?iso-8859-1?Q?uMlLDnePKiQ08D+RoF3Ua848TgGoloG9oAzWEQ+nWSqBJEjXYYtI7re72U?=
 =?iso-8859-1?Q?PMqO9ltRTvVXU5uyGnmgqrXd/3V5IZTzkF+o/echUgG5pt9Z5UKI6aeRm7?=
 =?iso-8859-1?Q?BEkHqapz1yO2KNXi0gIfkZdHuy5pg2B9qq5ZtygZXIg6ugVnVo8S2GT/Uh?=
 =?iso-8859-1?Q?7K2loav5dGxCid8U2jzNprgJSFnm8fpHDnUbYnB227ST2+cLHXWbAIolfz?=
 =?iso-8859-1?Q?GN+B+zOoPw/xSKjA+TS7j8Me4x76uFnDR0WWUKQE5193hRVuZHxlYFbVG7?=
 =?iso-8859-1?Q?AGk7Srx7g8F/00TjWp9dKpYKXY4Hp4/jRDjxy2I8KuZtb7srqmJ8RYABxu?=
 =?iso-8859-1?Q?rzhDtTrELNl6f6wDL4g3k+l+MZrpAyiKP4MNxNB58eCew5FHhAH77wL3/V?=
 =?iso-8859-1?Q?cMKAIRX+katvQtMD/xOoqJtwoUL7tHU5LawOAzuuYMS9tdbK6LP2Jn9+/s?=
 =?iso-8859-1?Q?JbZKR1cRDy1Da9b0wWrdFEjnhmjqC+w6REZLHJMIS5uDst+w3DB343Rsvb?=
 =?iso-8859-1?Q?JtVLyC0TIy5vNrzjOW6aAbfyidj4MH1TmNpJSjukXHp75QIvqhBh20vPs7?=
 =?iso-8859-1?Q?sYXWEvVHO4hMoyNF9ZWljXcPpTvZD3HWgVcOqW9ypN8V8RJmd6yLdsIbgy?=
 =?iso-8859-1?Q?OGlv9DyOdK7WobhLxthKcTABe+nZjsfPASQ141lLeuN0WY+bZd6GbIHIGx?=
 =?iso-8859-1?Q?9eGgXw77rH3h1SnxWEKWdDAm3Fn3KDK8SJFhRyGGWzX3j+naum4cNCbZH7?=
 =?iso-8859-1?Q?jSjY4eQhVzRnfafCABHTSkE+Ej6ORfGCz/Oy6wSs850AJbwY48LfmgWRjG?=
 =?iso-8859-1?Q?0upnqHl9IxCUj5NZykGSrR0SifGQgDt0zrVvPKzLDs407KZ5PhbtsVbElU?=
 =?iso-8859-1?Q?o9WLXsO/8l3w7u28CR8rUWV/OsN/34aEmgVN+4ZaYgSM8t9G0PYFt0yqzJ?=
 =?iso-8859-1?Q?ekAtg/pyJ5FkryYlyGwelCH6c+0STnM+JRn52cIfDJcIQsJV0N50ElHQHD?=
 =?iso-8859-1?Q?Zn97n3qk0poCIFOjG9RMGB2t2rcenizqq+x9aQgiY0NOdsaT4DSdKv8/IZ?=
 =?iso-8859-1?Q?sDESpgNTJDQibGADIxUk8oMp4U2YGN1AB8TnSOrbpbDXr5VmE+gpTkUh5R?=
 =?iso-8859-1?Q?Mq9fXMY0AEA2vIU4weZ64DO1qCeiGgPolgoFyuNazk98GHUG0nFH4GWVf5?=
 =?iso-8859-1?Q?huUuZ7t9u+SdqwhmG2sYsp3/62GfB8G8Au8/UX3TZuiJ//jyWffm9Pfd93?=
 =?iso-8859-1?Q?l2hJY/X1DGHnZa+y2vsvEBHvvDoYy16ct1nsKHgLBTQyiwdYKxctz7+sJ8?=
 =?iso-8859-1?Q?5OllTrY1FI7a51Rww3kWKSph9fepevZYUg/itDOVBD0W5iI0blxwhT7fa+?=
 =?iso-8859-1?Q?zhX6Le5+nog9azPI+PqpxgQhQlp+EvZV/fxcqAPfLuWq28bKWAddfuOk1Q?=
 =?iso-8859-1?Q?nkmHWcttEok4YK0j1WIL5iVpO9giRj4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a3405c09-ab99-4f14-be54-08de697c244c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 14:45:04.2140 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3GeSK77aiiCM3wwpMbRw9xy2zszdSKkyMSic3+KnencezTwyfNslWbW7kHVI3wtrHECY0aEhVwzpRKRYp5jq/EUCTtEYjRIlHmZYn3A10kE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8826
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

On Tue, Feb 10, 2026 at 10:28:10AM +0100, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Tuesday, 10 February 2026 10.04
> > 
> > On Tue, Feb 10, 2026 at 12:08:44AM +0100, Morten Brørup wrote:
> > > > +static inline void
> > > > +write_txd(volatile void *txd, uint64_t qw0, uint64_t qw1)
> > > > +{
> > > > +	uint64_t *txd_qw = __rte_assume_aligned(RTE_CAST_PTR(void *,
> > > > txd), 16);
> > > > +
> > > > +	txd_qw[0] = rte_cpu_to_le_64(qw0);
> > > > +	txd_qw[1] = rte_cpu_to_le_64(qw1);
> > > > +}
> > >
> > > How about using __rte_aligned() instead, something like this
> > (untested):
> > >
> > > struct __rte_aligned(16) txd_t {
> > > 	uint64_t	qw0;
> > > 	uint64_t	qw1;
> > > };
> > 
> > I can see if this works for us...
> > 
> > >
> > > *RTE_CAST_PTR(volatile struct txd_t *, txd) = {
> > rte_cpu_to_le_64(qw0),
> > > rte_cpu_to_le_64(qw1) };
> > >
> > >
> > > And why strip the "volatile"?
> > >
> > 
> > For the descriptor writes, it doesn't matter the order in which the
> > descriptors and the descriptor fields are actually written, since the
> > NIC
> > relies upon the tail pointer update - which includes a fence - to
> > inform it
> > of when the descriptors are ready. The volatile is necessary for reads,
> > though, which is why the ring is marked as such, but for Tx it prevents
> > the
> > compiler from opportunistically e.g. converting two 64-byte writes into
> > a
> > 128-byte write.
> 
> Makes sense.
> Suggest that you spread out a few comments about this at the relevant locations in the source code.
> 
Adding an explanation as part of the write_txd function, which is where the
volatile gets cast away.

/Bruce
