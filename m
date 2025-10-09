Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC5BCCD184
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 16:54:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 00C4A402A0;
	Thu,  9 Oct 2025 18:54:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id A837C40267
 for <dev@dpdk.org>; Thu,  9 Oct 2025 18:54:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760028853; x=1791564853;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=3f1gczgVsQTQyfsGozc1yYc5zIBZ/Gwmk0AJvJEZtfc=;
 b=YCCiArcj8WTG2Jb/DgpBDORqpe5WwnfSPfr/P+ryWqntGdmg3GLsAAaS
 P3tP2iF/JD894dgVJOvuT9QoSCcIFJ+C2JDJ+Yf1KdxXpuMSUGha3V5sa
 VYASEmbv3RcMwegE70I5S5mwhZDJ4HN5crIic9LtqdyacuxgZeJffsgxR
 lLA//2PpztrYV7V6rp62xPpplAeV48t1M0xaMaKomH7ypQX5Wm5chqW6L
 TVHuI2xVeCpky8qbrWFHCCXGgsjpt89y8vyD/U8qivdi3dd6P5WBdjPg/
 fkKLUb0gUS+JjmqKpJ+vb0Akq9uqEgLTPraNX/u1HMWKUTP7ibiyE7FQn A==;
X-CSE-ConnectionGUID: ps+9vZ4bQlKzMD1f3USPLw==
X-CSE-MsgGUID: /GHt3skqQ3q4m3DN9lwf8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="61279896"
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; d="scan'208";a="61279896"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2025 09:53:41 -0700
X-CSE-ConnectionGUID: fxGiAKIdSp2iiNDLLssWSA==
X-CSE-MsgGUID: LWhoEfk7QwWeqbE7BiuPTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; d="scan'208";a="204461229"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2025 09:53:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 09:53:36 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 9 Oct 2025 09:53:36 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.45)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 09:53:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=htlDbJp8e/PVVoKf/0j057rS5pEtHpwXY+IktqRPVLDhzC/uLLQ5ofknhkUPbtK6lq6FyzhQaIkENZAboZG7jY6SF1HDUgJYLYHvUpPgHpVx6acbzrcBa7+Es4xiVF1NerC6QL2xS2yFGlxblXjb1tYkSxUuljHhu/JzouKu4B6i6xx23rtMnXMFNh+qm3FFpySEJMh0ZscXCH+cHDdQAkaxRSRyuOKuqPEP/ZgjI8jTElk5wZmC3TpmjlLky0/I0DCdAlGSmbRIv9LShmU00wwa4jLHKedWfl4hP5B0Ow60pEeVdCxwobGU9wuMVBypx57MoNAgrKGgVfR611zsVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8E6JifzltZWx7Dq1v2L3r2oAWTmdB8HCJ5rj3MyP78=;
 b=jwHkmafs191NwjStdwFtRos95sn5nPhQ7IcM1OAE5+cjV3ivD/XI0+6oEOqYQJd6O0bmnld51WhDThckJ41Pv9NweBJ/QHfEXa3pqRWcJGjCgIWqjBqzsWGlRPiZ8E1YazVI2lz+1xmdrsza2osIwNsOJbKJeSimj9CD/ZaFdlHywzknL6uhDReZuN5/VgyO6C8KQRLXEjSEmcHUiO8Ozv97OzG1Yd1QNOlQ23biU2Lw3a62iObNFPj7Mi+cK8fJA2shtvMur64Ae+8lkEaYumgp261NB43itGz8zBHVqTkQHobb6fAFxJ7PP6XC0Ai3rEcgQaZv5IrtC1RW3cO+cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB7276.namprd11.prod.outlook.com (2603:10b6:610:14b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 16:53:28 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 16:53:28 +0000
Date: Thu, 9 Oct 2025 17:53:23 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Stephen Hemminger
 <stephen@networkplumber.org>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, Ivan Malov <ivan.malov@arknetworks.am>,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: Re: [PATCH v8 2/3] mbuf: promote raw free and alloc bulk functions
 as stable
Message-ID: <aOfog1px7iVFzkh4@bricha3-mobl1.ger.corp.intel.com>
References: <20250821150250.16959-1-mb@smartsharesystems.com>
 <20250823063002.24326-1-mb@smartsharesystems.com>
 <20250823063002.24326-3-mb@smartsharesystems.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250823063002.24326-3-mb@smartsharesystems.com>
X-ClientProxiedBy: DUZPR01CA0336.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: 759b2da0-be5e-4676-3bd0-08de07545ed2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?IycPbI55mYaEfKhyv7RVf8r8qLYAZvjAoiRH6RtNJ53LFi7ardUGJ0k8RS?=
 =?iso-8859-1?Q?FyH1jBRHYKnzgLeeo15s58gd/f1jfNiVairsoQVT/Rr5oPzsaPLOKxY0eb?=
 =?iso-8859-1?Q?IpSMmpaANqiii3Xy1t9J4QRFdANgs0p71FZJDb1mIRjWT07XCV/qn8TU2R?=
 =?iso-8859-1?Q?4aVQLrO+ExpRSB9krDf1l4onmhF/Pcf23nTYo2YRPJBPdCh8fRrytLTDl4?=
 =?iso-8859-1?Q?xs3oCDcXJtmgFysqrxAb0+KT+R7cQMM+iEpFSMmM7bpWXvrH5bGtWdkpdK?=
 =?iso-8859-1?Q?ZaH1wwVdmWDVgwcdBxGApatdGn884+ZhWPPX8CF2r73KMgAe1dQ8FP/AGm?=
 =?iso-8859-1?Q?jmtw1RHKp4mDw1ZxucmQ/42e2QnGUmN+cuEOtlaPTGOpvLwwPPf/CvPT56?=
 =?iso-8859-1?Q?g34/HM8olP+16gTLdGcbg4yysNKu6iNGx/kBhBZazKEd9ykskPhDT9qGFl?=
 =?iso-8859-1?Q?30gARM01ZM3P6Dx0McwjEAfMr0ZH/tLpU5UE+CYp/HfJZ5esZAY5MV6JOl?=
 =?iso-8859-1?Q?DaO/n6MWdnkmXrFz9nV9muVzswl6hLMRJPFWQ2gWh1m7vAxq1+7rXVrFsy?=
 =?iso-8859-1?Q?87gEhHhZsEUgGYG7KjpbLVwnX869JE5MSEqabKxC73AH7uXWYPpjzCgbh5?=
 =?iso-8859-1?Q?fNikWWYHvtCLxeKW0ARHUT8hqJYXseIdMX7voipujjrbKVtzG9TO371h5C?=
 =?iso-8859-1?Q?mZN6ybjwmHFZAENAqjEIjWp+NiE41AFIkV6RG9uObOzWISdHFQtwX9bULN?=
 =?iso-8859-1?Q?lQ43KrdjJAeG3XepWlWfH9CIQ1prwjvR4dZTHw3K90COMYsghvTSH9957U?=
 =?iso-8859-1?Q?Jg2uNAS3tEgDKwvwl+/fVINsXHtUGwcetD4cjQTh/0MOXPOrDADE+o4Hef?=
 =?iso-8859-1?Q?3SJOfXFI9e8/yM0cS9N8/YRqBlSPhPHImvIz624fzySOBgUKS2WjtxSCHC?=
 =?iso-8859-1?Q?AI/0rdSNPvBRXRjd52nmv6zi6Za/Nlw5sK/mcWXbk8YRZ+OjkIDrA+cfv2?=
 =?iso-8859-1?Q?UANj2vUFHc7yeBGWV1qPsc8Vr0wz8SLNubqztvxIp6M0QH59AFnmZ2anXx?=
 =?iso-8859-1?Q?rtnBWtYGtwSLCrVD9fCN1qtyzD9H/RMo6cebkO63lLWE4n1V3f0mLRibXu?=
 =?iso-8859-1?Q?SYqDdgY00wLUmCgM2yj3v8A5vArQeqRI28KxSH94aBgViSlmLwmspH5CCw?=
 =?iso-8859-1?Q?IGZ5TV2wo/6QRHylDHKz1pzLE0fsU3lWI5eGw5D6Wizj3vJ3NorKel/Y6y?=
 =?iso-8859-1?Q?5+BG5I8hVf4zH2tACrgCeAgt1kxxvoae+99tUOZDL3YPVxiJ0PVMXK2vYd?=
 =?iso-8859-1?Q?j4TAyLpIFvrQR/ck4MVeTHFrizwJpqkgAIpfW+ylZzi63fv+sgNTVbDyXF?=
 =?iso-8859-1?Q?Q3VqPzfpvYgTx4KIAoTw1nngl8ZtPss8a9TZaqWYXkDFVxJIxx/k4Oc2K2?=
 =?iso-8859-1?Q?DCdggD43rUQoJypNG8PgIgnv3vEJZVV9A/7I6J+JOCtAUl1XvHM2RoamW8?=
 =?iso-8859-1?Q?qIiCgKiFZhnxmbiKht8JRE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?MYvS3OFf++uwq9Js57oV4PXgdYsfu0GTgAqxZkNjd6slHWEzo9Gkn3IZZj?=
 =?iso-8859-1?Q?aygoTJhx4cI9rbZTXGeXeZ5m8wwK6E6F7MNekxkz1nYr+9gJHfwGVjd5FE?=
 =?iso-8859-1?Q?WEHJSNNdp7uX5LdI3MRBcj0rz5h/VZdoJYwjZc9Rfd7g9Z66RMqqpAympb?=
 =?iso-8859-1?Q?PdLrO2yTOxJoRPZ7MUqb8vuscbmJVw1HeSLjalxnYDVwStCzhAMywzEwOp?=
 =?iso-8859-1?Q?LRv5bNvBWM5QDEjPA95Kv5O13elzEFK9saJiJYojuBW0+xPnlP4UxIIh3E?=
 =?iso-8859-1?Q?d79eFYKhRwGqcxFyJmg+SpTF9Zd7dHvqxMvT7bnc6DN9V1IDk0UKOc8xjz?=
 =?iso-8859-1?Q?FSpHJj8ljs0ZKJE2Hmhb2nQRbV9KLgk5i6E/G1qTra8KtsM8OaAWWtuvwo?=
 =?iso-8859-1?Q?+Yr6TjANJdg/fDHh4oqxQWp5BiBJnSAUPXjfSBEMw9AfviJKv2qYDwA2bZ?=
 =?iso-8859-1?Q?D4asKymJsVF02gVL6lcJJXJnP6GsUW7ZLKfupq5xePE0W/UexzeBLLB/Sy?=
 =?iso-8859-1?Q?hM7hk89tYrgUC2RDFDD+YeGDBLbulT5tUYvvFvzL3iiduHwcLz8KZkXNwp?=
 =?iso-8859-1?Q?tR49uX6BhiouxHKPKdv1uWq1VcRfiY+35D/fmwGs3xOcSskVe8b5Ql0U3A?=
 =?iso-8859-1?Q?5N8un7f+jR+vVmiRydKu13LeuoFfIu+7jI7gpcc4h/sIXbdTPTqo+Jf58z?=
 =?iso-8859-1?Q?29Me9wthzOcgCRUaK+Y2+JpCTJtFMfhUEcjt1uZ+Rdli9jHx/XujoyCcGd?=
 =?iso-8859-1?Q?RsoQdUHTN1BPJbpAD748odFZaUip6DRr0p0IwH4McZu9J/JitfWjNdzksG?=
 =?iso-8859-1?Q?FTDD5nLPXI6Hzw9YnQfLBY4PwtEBPVMEUqhtC5nPZ2Dl66GPp3Y9KZh9CV?=
 =?iso-8859-1?Q?TU2zpkP/1nRSa0OKpkkLoFGb5rDiF9H4d9O6emhywlx9hHiK01FGhiAJI5?=
 =?iso-8859-1?Q?q1EjW0AFrkKFTFpSevb+h+345aFR5vvUW4Q6rDwBe1+kvVj5uxCkKHjowi?=
 =?iso-8859-1?Q?Dynu8FPQWfKN3asUiz1Ymk9T/bjIK3rGJdEHldTqfsQ9VKSnTdCK1LJoUe?=
 =?iso-8859-1?Q?oX1Vnffkv5TphGZtumWZ1o7puywDmcaHZGtGW52cFuarZS8ZkB2MCrmvdq?=
 =?iso-8859-1?Q?8nR8/BCp8Q9V2K9nC911SkFitYr65HupaPbZ6GYvBXlYOJLQvV6lHsiKv0?=
 =?iso-8859-1?Q?9YA6PfyNN0Fgr3KPk+mc6UlwL4IEx5YECqhcN+CEo2sIcE4gRNYhsj5xoZ?=
 =?iso-8859-1?Q?nuRM1wjiZ0MuKLP8dtynyBoYvz5sGDPVG3kCbykI+xuySl4KfD4xZccJrS?=
 =?iso-8859-1?Q?6J9PN8J3Eb8+sx1HiY+pytjk9KhViL5on16jcsMjBdBLTE8ORW4I0uj2Ha?=
 =?iso-8859-1?Q?ZJEkdtgcedOnIhUp4m2rPAl7eocacYiQP+XijseUQNGQayk9hYQDiq5QJQ?=
 =?iso-8859-1?Q?W5bWXdEnMqY3qQDABKWCrqARClwZb1hbBBXUOn5CWA3Xhw/R7B3NseRyX2?=
 =?iso-8859-1?Q?s5hF43tmo6bOznSdovYQm0e55LN9ftX/zk57a3KALekbChVyiySK3MqpuA?=
 =?iso-8859-1?Q?XKLTJh5nnHb9y4v3h/wliUMF0gbJfN0yMsHvH5dpPU5evHz9ZhA8fQNr45?=
 =?iso-8859-1?Q?9q+qAWIxguV8NwybR7caGsMrvnX9YxL8nKzQMmUsolprR/H15fhEW0NQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 759b2da0-be5e-4676-3bd0-08de07545ed2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 16:53:28.6310 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J2RhED1hS4E00jkdZSCpB3CM6fI/VNPCy2zNIbuSBVsuN3dMEO8oA8p0eTiijGFyCZ6ZfeDuspzSN5vy63XZQljbCtbxY/sgqam4sWIpxqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7276
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

On Sat, Aug 23, 2025 at 06:30:01AM +0000, Morten Brørup wrote:
> If ethdev drivers should use these APIs for allocating/freeing mbufs
> instead of bypassing the mbuf library and accessing the mempool APIs, they
> cannot be experimental anymore.
> 

Not sure this is actually true. AFAIK there is no issue with internal use
of experimental functions (with certain caveats around use in macros or
inlines) since we will fixup any internal issues if the function changes.

However, no issue with making these stable.

> Also updated the packet mbuf alloc bulk function to use the raw alloc bulk
> function, now that it is stable.
> 
> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
> ---

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

