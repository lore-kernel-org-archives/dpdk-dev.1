Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2195AC5CFDB
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 11:58:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25FCD40B9C;
	Thu, 13 Aug 2026 13:58:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id C0364402D3
 for <dev@dpdk.org>; Thu, 13 Aug 2026 13:58:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786622325; x=1818158325;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Ez+ytkJXUAAOhTGHKHT9lNTTHSe8lYgeHaz2dtQtQSg=;
 b=HRhwkhbt4obkVSpKlXHpu2XFyfh70aPjSLbfNMbZ2m18f/WTuhSl6qwa
 4mrLeA6utbNH885JwUv074TXOEt8yZXzlpWG6wdBKQCrZz1PpWViJfo6F
 DxrHO9EdUXQCVYBTBCQfMUvRHCsBAS0DpdF8U/5qM8Kc27TnbqeCdELWo
 j+nSNf/dtyJL4/wtYW6XpsXa1Tndw7YlY4834Xac6eeHMyqFyhQtsQBq7
 jr1FltTMSEOeqGTGzHBFVuyLB1A56OGeUT+SUIdNGjIMohRW06mo149DZ
 Ezju6Spe7KpRt3jUvz1dcM4KdOhQSZfvRf/XLcqZaej4UE//lL70eHTQL w==;
X-CSE-ConnectionGUID: xSTFsyTSR8u7X26uuDRTxQ==
X-CSE-MsgGUID: DdHpeCnLQP6KTibGMlsLfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="112736352"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="112736352"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 04:58:44 -0700
X-CSE-ConnectionGUID: gYslolD7S7qdd61amMGk1A==
X-CSE-MsgGUID: JMFtl4tWTqWfc2nzdHecsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="264503154"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 04:58:44 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 04:58:43 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 13 Aug 2026 04:58:43 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.69) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 04:58:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bjlPexfw0B3UlZ0LcTbh0sk50G7cdvHBdutG5jmzAfHGaOQJ2JSQQvWMiJ9HF/JJnIQSUfXUc1crvPWJ9JX7M2kVFHO3mLtl+n6OAdGpDu+XjFitFJ54xVcR2BZegR/itww78RBPB5FJirBXsqA6nZuwu651ZxOJlyP8n9zmmDDlQmh3Ym3owzda93RZtjCn/XeXedpi00QdWYl7vdHBAjjCo1TzcQtjv4JAAspX78wr4uklI2wqEQ9JEvV5USHeGTHTr48EblaBOtdo0Amd/H23k91eA9DCY2GuTM8vIRSXHm50iVrYzXBX5GLbsmkYHsBTNAnPjFajdJNJr4H0+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwiD8ge/QOAAOcrjjjbpO16x0ymBomLXZooo8KjfxZ4=;
 b=NLovkyBN+Rc/YIcDXTo66wkuY7q6UcbchFzul5MjWGf8TH4CiOmt6mtsqed/4baOYHK3exmA4d2Wo8nAnUAtCKVB3iRPYRdenOjwQp0IymeV7A2QXqagLFN1JUFeZDLe73biou3BQuxP9K5Y1UT4+grwDjduo1hB/N5qKl+yCZtCR+iJvj7v/yGgjfq0P0/VjCqSSRdF/0W857UpiAdRx0DJ4gosTxgUGoFNwQRNI1I4KtTTobq3KcIsgdycijb821udzmp91e/QMgMGgyVtk2ZqjzcMXvIy3GeoqjAJW2MRz8861ZYLZukYB6Ahv0y4LZ/iZ8j6EmWcMwqgA7FR9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by SA3PR11MB689426.namprd11.prod.outlook.com (2603:10b6:806:58b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 11:58:41 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 11:58:41 +0000
Date: Thu, 13 Aug 2026 12:58:37 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Anatoly Burakov <anatoly.burakov@intel.com>, "Vladimir
 Medvedkin" <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH 2/2] net/ixgbe: replace memcpy with structure assignment
Message-ID: <an2xbeQC3Plf_uMm@bricha3-mobl1.ger.corp.intel.com>
References: <20260728143800.148509-1-stephen@networkplumber.org>
 <20260728143800.148509-2-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260728143800.148509-2-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0270.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::22) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|SA3PR11MB689426:EE_
X-MS-Office365-Filtering-Correlation-Id: 32e98f0a-ade6-4653-bd7d-08def93237f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: awwjrSSvK//ACmTqNqPqPiU8rCp7o+5K7lcI1npc1IEsydOTj2UGDKLzyLEqUmEIIrCLsT/WGMMwA3wCf/hJmqF2dDdKNdwMq/RcAhhgg5g0ITvj6FdGC1U9N816kmlxuEpV6WLQU7fUrFoyYT/hCcwPDLSAlRTTZrxLWolk0Lk8mIa4uCCD1am6NuYwUErsJEa4tVyw7cNTABaPzbRk30HlY74j2wM6+a7ZAlkNS9XEw2UgAi45BfXOcPfdnOPXiDQVF2EvWNg/2msZfhlAZOPjBQ4cwkv3smFKad4fM/bqRt02pCJIhOMa54SNrBh8WDcWThSNX7ddL42HHYoXHCkhNhe+Ao2rRgcn4hYddAJ/bebVR9vf6/gHxdkEawg/YPwUoGlnOUi4hVg6GS5jF+bPjyRZXf7fn50xZG04ypXG25z9v19e+dQcePX/0MsAaUmNEOhtsDKJ40OFtx33GyzL74o4EU3YKcazU2gG3XSf43mf5C6wpRLt6smTusni+gg3MFvczIjdR1GsMYlEk45ltbBQtD3m37sHa0fBhxgEyrIJsfeCrvx10XTHnsVuIXEWQ2yu6UoUHpLxoeep8w+TOnxgMGi/7oIL/Dy6fGBdfrbUMS85LKSIPQxdVzHYwhwzN8HFNwgl784iNvsFohIdU10AH9BrRYxD0U2ipZg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xgy6mDlZNHw7mkgwJbPhGyyTG8OzlSTHB3nlHFvkW2haT8MqVB3NM2n2nATz?=
 =?us-ascii?Q?o4o9Ez24Vyuynwg1tO9PyVEkpiGeQq3LDARQoctUkxzn6y6iVGd39LRAr+nm?=
 =?us-ascii?Q?05Gqq37+BYmFwEe1seWJyKucHb8a+9LkX2r5FdK9m9r9Lwl5TDvK69Vrt7jb?=
 =?us-ascii?Q?npCAMcqGkjmcq0H7N/x3N6iv4o7dzlZ+DXzTihrw37sHVmld8MeffATsGnVa?=
 =?us-ascii?Q?bNGJ2/JWL4OGI+gnUJRvzMFninMbvrmzliDzR/YcpIk1+M2IuYdsf1btrJJ4?=
 =?us-ascii?Q?yHEHNEaVkWWJRkWm2qLUdyXR3kcSjAZMqOrwDmiZmdvftjbG3F5pIrRJOcRu?=
 =?us-ascii?Q?DXthCknRC0B3UEDY5sGzLTBhq/Dn2jjsdxTkiJ4NT9H9OrPzgLSYaeTBmW3A?=
 =?us-ascii?Q?D5rPTcnqUwtLS7aK6TiG/9HUIhpbj3+JkEsMmibYweD5GOvPUROs8ACSwHHp?=
 =?us-ascii?Q?kFNno4d5UjuTED6QDafaatGFr6FdABg9qtrq56nZWagYDlH9C9rhJPNv3bMj?=
 =?us-ascii?Q?EJBZS0U2w3riLvUPEDdc2oIhxTdMqNzJ5JmVnWReOKRYhdgdO59sSK3Rg5Xg?=
 =?us-ascii?Q?nDbRSn3lj6MSpvSz6uICASgjUXqoqWi84CGVatk7oKEmESN8UBUqXf7V8lHl?=
 =?us-ascii?Q?K9xYpFa1lDUgxf5flf+/sLZJpOvECLo8curXbfu+RIk2TdDKAu95w7/5HHOJ?=
 =?us-ascii?Q?/OH/6pj09C9aDPUKLHsbT+ElC7v9eW8RQgFvbYQUuhIY2xWHWhpqb0sX2OJp?=
 =?us-ascii?Q?9GgU+3/fPhTHZbPuvbRMWy7lXpNb96mgpnLwcF8g9Q41AVD1b5hQLXHHk/4f?=
 =?us-ascii?Q?ZRG+2JfYhQJG2EnFGPW6GewAJdWw6GoxRmwkBoCS4LHugercORNF/NjluWHj?=
 =?us-ascii?Q?vI0pfyJ4xtaCUm0FbELNBNgKVFP79TBu2zRQR4WK6uiIUbUXNZ5vyVy2F+XK?=
 =?us-ascii?Q?0q8rMGyifCQ/qvFVASNEOvv8EfGmNQzJx/n2/xntE978zHTKTXb9hlffrEor?=
 =?us-ascii?Q?seLSoKYPzEwn+ln6MmJq6o14ekMUbw/NlIrcaJe54PaTlbE6iBwMqfpGlhV9?=
 =?us-ascii?Q?wzMo7SgRWJJEnb3A0xU4WGNF+fSmFfKPVEsVvu+Kp+1CNOMfiPxR3SNE6usd?=
 =?us-ascii?Q?7vdVYFMSsQoxRi4DDw82IQ9VXhcYWNmgGEJPfMTReLFACoycFFaUYnPwpzq1?=
 =?us-ascii?Q?ov5d+/fOdSTyRqvPRa9uTdQrq6nyjrWiBiGAa4749m2bhFoORYiQc33oWD3E?=
 =?us-ascii?Q?YrwYyBi0AONTsyJY7OAE9izf4ojfUmptEE3EPKu7lmdOEsFQ1h3BeCSgi1gG?=
 =?us-ascii?Q?HcYdKu8ZS49DSbBxCI7rFjaRqpqjgg8W4/0/Z1dugy/s1YpTsrR/UkfnAdCr?=
 =?us-ascii?Q?kV897rm6Fy+yq7EYj1KQTZn+FH0HODfZqDBCCIsdPYdnCubttcSDaaFCAa7+?=
 =?us-ascii?Q?bEthGzXtUiwFW/Yy3aOpsyGmrBUJMrCo6L3c4vvnwcuFpMbn+xnaTHUbBiah?=
 =?us-ascii?Q?y9lmlkPt8ChyEPhtDE1KPUIbR9GKfguRXeVmw4CgWKxrc6F0wn8CeZKm2VX7?=
 =?us-ascii?Q?4sNvXpziJZkg2VO5QOntRX6ZFmPpRgvvtrdmDMkTYhjp70y9DuICy4Rifg3r?=
 =?us-ascii?Q?dg17631L7n0AgcKOsK22hOCqXlIqWQOOD6nVB8CaoUYd3Wg+mBrYQCGeaLS6?=
 =?us-ascii?Q?dk9y9kXL89Gusqwxxvmft7kH9p1Xn2eBeKrjOTbRdNGIlTxfH9QVMP+lk0H5?=
 =?us-ascii?Q?miCTVWfNP5KNEOoJWepPVWvgn8CrlTg=3D?=
X-Exchange-RoutingPolicyChecked: pv0QwXQS7LVEiZvJz+bVNuNir2kPpX8V6gOBOoA8Bt14HaKptrcrEb6Y5tRCl1AdQ3KEIjg3nx52FK5VTlKk3eiNUur7ta+gkoHhu87UcpJtpwbs3ackgeUSU59Cj+6DzGAbmBxVBYHuqXMc8MUU94M6V/JuvM9GpMFniJdHwfvBsWc25+MmYATNOxuFKt7P78i8/sGd5zSSYcg/TOmX6Z8qVkYgbOvzWnwaUN6XP5uAeaXHFf6f/V3VLUIeusEMhC9lU/fj6rg3Hza4hOJqmizJH0R79ouWYncAB4Opg3eLmYyEf9IDRepn6oH0V6/G2eNwVqQDzm5TK9L+NyExcA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 32e98f0a-ade6-4653-bd7d-08def93237f4
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 11:58:41.6749 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1aA4z67Zmz76qLxvyvuJJ21iWkoJwsOqpMThoz9BStwTfo+y7QEhomfbtY6BhJ0gfHTbr3tTO5f7ptJD96CCXjNfOXPk/IRbnB8fCuQv16I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB689426
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

On Tue, Jul 28, 2026 at 07:38:00AM -0700, Stephen Hemminger wrote:
> Where possible use structure assignment instead of memcpy
> to preserve type checking. Found by cocci/struct-assign.cocci.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/net/intel/ixgbe/ixgbe_flow.c | 39 +++++++---------------------
>  1 file changed, 10 insertions(+), 29 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

