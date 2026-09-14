Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845DFC88E6A
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 09:06:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D0D4D406BB;
	Mon, 14 Sep 2026 11:06:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 5A7B4402D2;
 Mon, 14 Sep 2026 11:06:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789376761; x=1820912761;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=VA9dsXSOgoPTT0xzNcMcVutXTe47yOFcBcdpAnTU9HU=;
 b=DPSeniU5xQMTUWzjVqd68Qd3CEFhDQYrmT7/Ul7KxHWTZU431HtVGg3p
 pU66JZNwRGjbJAm7AujISj4my0r4QByTqi/Kmw65BFTcND43hcX55c1yY
 3K4xDfbKVdDRnuDSBr5RLeRXFqs0gJXlgt/eCGEmj4n25k8V3SOJShZDN
 4T+3ySl+ciETmWMLMtxM/POUBMAZTRTXC9g4nenLh/Doovk6LLViNfklH
 BEFD9nYMaVXmCNF81NQ9hvQBI+U4fuRGAJiIKKA6lvVKgwkvcNGGzXPeJ
 HPtQXl9P6fdYemOIVjM7qf43DL4O6dAAFYtkpDLSkxT4tmZxOoynAjwuT w==;
X-CSE-ConnectionGUID: 7oJSyoXsR8GIFG9nASpypw==
X-CSE-MsgGUID: zCsSIsp1SM2UVXPWbCyBSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="93421735"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; d="scan'208";a="93421735"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 02:06:00 -0700
X-CSE-ConnectionGUID: zKcU1QZpRF2oKlz54Vn0bg==
X-CSE-MsgGUID: J6OzQWwJSJCnMIq7ZNVEDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; d="scan'208";a="270788534"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 02:06:00 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 02:05:59 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 14 Sep 2026 02:05:59 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.57) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 02:05:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fqQ+0jZ18EU1khEvTHGvoTUAZi1M+BxKJ1SHlzyO8Gf+Y7zrorDlKlM2qyGHyRzBhEiMy75HRhgvbKR1Dporjib3VsB7Ap1LMPXf6YTmMtJrT0qLVgxvaoIEszT0TcpXxjIp/FYzXbwy1XM2t/TOBzo9pnehZL+ETln0pXUbDHXLviFDg8DW69wkrRlnaa2grKvXTWs482IJCCITC+ojsrDEiu0kFQUFQYBWOKGeE/NMBLp66U9h5uCdU8aTNe/Jd/FlGMF0Rgfy/qZ49Z/tIIQ9jbMmMwzPOkgzcTY/3O8aiyCOdPbLyRrW5E74pi9LeFvHIWzV4JAB/RPt96pUWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MqL/OWtWaaHiKQI45RMHcPT9ja+JtfFTMW/NbbCYnww=;
 b=XSsRFHYgndtJRjeer62vrkTCbZWf80g0I974O0zDYknZQOHaPxN1WH/FrLfMsJ7ixv6KlodIADHP7pn/2gm0V4Is+rE6Ud8TRnm2k9zvMFDzRTOVcw3uzthCe3R7u4rQKZOoHVX78GJGKR87aKoIfc8Kvlj10t0OLciaDNAof1/8WOMgJIoK/VqHNCM+u4qHM++cncXdC2/ZM7uWGgDoK316jm5aWv2mE+Ylaj1pOhSs63gDpI5HV9Lv4N73zNtBJJTW8tgX4TaioSHzXC/fRm1NPPN75war+eiPUSdFreAipAbP+3DDbY81b9onfvOtjbNarl27sLNFZvgem89j8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by IA1PR11MB9519.namprd11.prod.outlook.com (2603:10b6:208:5d6::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 09:05:57 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 09:05:57 +0000
Date: Mon, 14 Sep 2026 10:05:51 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: [PATCH] eal: fix pointer add/sub macros for large offsets values
Message-ID: <aqe47zBfSbYYNwxI@bricha3-mobl1.ger.corp.intel.com>
References: <20260911164030.2465043-1-bruce.richardson@intel.com>
 <2ef8efd39dd54b22ae0c007dfa397a99@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2ef8efd39dd54b22ae0c007dfa397a99@huawei.com>
X-ClientProxiedBy: DUZPR01CA0218.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::21) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|IA1PR11MB9519:EE_
X-MS-Office365-Filtering-Correlation-Id: 07d10639-e8cc-4cd1-06a8-08df123f6328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: lc8M9PojtRNVL3W4p5BJf6CZJ4yxNS8InwfFs1cdxex28wvRlWxJtd3QLauEZJ1JOKTBW7Gr5zULHlMNKttsY4A3kVQO5tncnhO2ehYMJtY2yiek0A6Yq1u+ri27rx8WNjnDQlkJyDZTQg1PrvnzIchD5awhNVGuvWuSL6RKbrQq8e2d4ZyoCCn6f6XCzu7gxfI3Bk0OraBDvK1oblokJ+46Uf4Z3C63tb0XBejvZ1iX90SG7xWAH4FoxWKQrMF+TJfRSxAMi+giLxIN4C3cmC0jebmrR+h0QLdT8DIl4djuZue4kRAVhLR9m+MyXaGEVYsXJLx+9IqvGJmM0o1uapAANZa3vpyzmXfmJyIqwgS6se36bFJl7DeH+QDZYg7+8EF5y+M9mazIGUl+CRmChCfFZzd9Cy9uMEh38uPk4jH4u6clizgki0Jfo0lf2HOxzP69KKua6690swGyfYE8YDm+kGUkhYCHzzbnYekZih8RawGJJwnK1lZYsFm4h/HI0Em8HALF+Xw3o9eOYHutWqFn04hwMROLb+YxvAFQ806DQ0/gsA/VQClvNxfdKgGLLg+Ofh9JobGjS3BOzz9SkbFpisq0nhVzdPwf71JsSBTAhFeanOfSc/tiW+7Je4UDlCquBqz2oEJU3Dmlxa/pZlqUuCUdJiISl8fkCPnjpIg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5D7ajY48i6ghgDsosCIfUK1HmyQ1rq5g+HonjEtZDRfAriVCExM4g9OQf001?=
 =?us-ascii?Q?jwAK4ycEpPupmyWxpjUv4rtshfTthHLSuqoSIA3JkTRacYwcmIrJDInu4Dua?=
 =?us-ascii?Q?/T/XW3LC8QsQHWvE6cA/B1jVfK1r9ILOMeFj8ydVFRCFNx1co34nd1Ksvv1z?=
 =?us-ascii?Q?K3A7+EU9u+GXPsxS7Aul4QdrJYh0bNtLbVALxti4yY4Xv3iZZw0YSuOJ6JtZ?=
 =?us-ascii?Q?tLAYYF7as5Tk26iZ6bcChAt7W5S/y0/nlOt5touigCErM6MKN5gbhgI4wfVv?=
 =?us-ascii?Q?n7RRge5XhDzTrVDzmZopsC9pU76b2qoyi93Ml2enSR4Ga/Tmk8KUL9ncaSDE?=
 =?us-ascii?Q?fbWyWw7Zl9HTj3R24E8ulRmiMq8uKFBL39sJWfxcAmcZ8ab8TyC4bMJ31Ocq?=
 =?us-ascii?Q?jslJFXlv8CSWv6njcAPllmJB3QJRdub7OuVW+WWCH/8VvtdlkdbdQ4DepOyz?=
 =?us-ascii?Q?oKptZBMPrEVeBMB5bb7EPIWJbgqHC6aRFg+n7cu5umi9CbHJMCUnhGU/llq8?=
 =?us-ascii?Q?gqgyVALM3J4lNQrlnOz/PRxYaWn9ep6yBxvF55TCM9Ntjc2XWL+60p90LwUn?=
 =?us-ascii?Q?rZ275KBcpZG8SF3MRuoGE5uFS+vRGlhdB3afbs9speNMPrd25IsOOq0VlTjv?=
 =?us-ascii?Q?OhaTsiMPLAQ/O+XHdwUjZGlxQfQ/hKgYbMoVLLI3+61HXChwamjJUiRBvdN6?=
 =?us-ascii?Q?S0q7sMlGgCnfbHqaYXweUQgVhO3UyNfR6keu42T5YBh7XuPPFskLG71jrr5H?=
 =?us-ascii?Q?uuPfU5utb8WbpG7vXt0IMxe3NhJNANJqvRUI0raSK26CJ+pOz/PzJAnDebek?=
 =?us-ascii?Q?fE++391f77t1eupmxAXyx8RUwDxhPVSWFyEBhU5gIHwUwWNDmHyIRfqSDrt1?=
 =?us-ascii?Q?79ZU3kSLOW5yM8KoMW9iBGn3b8+EA4p6964lKHWntWVw/ZqX7AFnzZsXBQVF?=
 =?us-ascii?Q?OPT+GdMlmp7cjCcB/PoXCrLRtkJnbNR1FSd5GNC0mkovnPE1gpdgqy6XdWdQ?=
 =?us-ascii?Q?I+DYDlCg0Gc8plXf+wz8uOAlwZDOOfkps4VBQdFHQIkzvmGFVctOqY5+muPR?=
 =?us-ascii?Q?nZMUFo+KbTzIkvTRTOMDkledixYIT/mZPfHWJ4zT7mxJBmVonljWew57A/qp?=
 =?us-ascii?Q?x1NGip3xErezMCH6MIg6KPaE//LQZGGnH3zZDwmGN2br2EQECej9x5u0Sz1U?=
 =?us-ascii?Q?uJF+FsDibVEQKxdLw5knE7SBTlW8fvaR9MP8/+cvFR6ZTwCN0Kiiux8SWJUx?=
 =?us-ascii?Q?Q53rxt3kMuTK+hJ+dDCzeFvHf3Bbms74UOjvfVVbyXHVWr6UmHDSUnQS7TjK?=
 =?us-ascii?Q?QykL6i9pBEJJFSD8GiZegGiBwNQn05XIaHV0rkCszuJZp3/OgRuQh/QRwioQ?=
 =?us-ascii?Q?j84urL4eB8QheH6rDyhvswavJ1g2v+HZ+FDl962aFzDBKYNfbUf5S5HTq+zK?=
 =?us-ascii?Q?gbp8C9yZwji6JimkTiyId2YL4fkwUqrDhfdlSDRr6gyraJV0J8F5gEexRLzi?=
 =?us-ascii?Q?sP7ky2cagrBGtIlzZc1ChYwASOuIRuOg9gK7xdbLekacXDm8+/wwggz5CaUT?=
 =?us-ascii?Q?Zqop9TDWginOQ6mzht0gE8wgYY4Pu4j+FwgdobmjMbHflW9uVyhZ0FfTJl1h?=
 =?us-ascii?Q?yU4kabzrMby0G9gFY6d6xetJt5N3iHb9Id9dxpsKaRs6kF1/iCTD6LxVlLrm?=
 =?us-ascii?Q?FeeQ5mRJc5nlvxY0AQ8uWN2mG/8aTbNEfb0q+p5nDItRIx3hOKbH1xfl8ZDc?=
 =?us-ascii?Q?FeFt34TUyA2lJvnkQ0R4P9hUjwBzxbg=3D?=
X-Exchange-RoutingPolicyChecked: E1k8CiPBUjn1GhR3r6DxRtlqimI/CZqSzh7UkBgC5DPYG3yLUhubXb18m7S7lARbwqYd90uSBWVc7nKuX8Pz23YMbiUycy/8meJplYVQNMEX4MJ49wDz7F9tjexxSMnHwszJ59fVbL0PjNiUtalR1YI44Ad+48jg6ZN/VbQEb/ta0zBo8QQIzEjddmIuskRp/uGtpONxFGcPDBOBRQyGpbvXKrEvlwL8rzQoobBkeDTZfkk6uvGVtTPIR3aA9Rm842ikTLnzE4Sof+vS9Ej3ed4RNEheVNRzibxBWQKz1OdeDkIr0C2OJp8OqlWNFzTRGu7rlzE4QEzF3W7S7ce26A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d10639-e8cc-4cd1-06a8-08df123f6328
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 09:05:56.9683 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3mFEXZDWbBDfgGOzJjlDL1Fa0VwKKU+HyCdfVHkC64WA3x+k3GarHdqSS0PDGn+wXhyho6DElPC0QdkGzdtW64gnD4fekHUodIYCN6eVBog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB9519
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

On Mon, Sep 14, 2026 at 08:29:42AM +0000, Konstantin Ananyev wrote:
> 
> 
> > The macros for adding or subtracting from pointers cast the pointer type
> > to uintptr_t before doing the arithmetic. However, for 32-bit builds, if
> > the value being added or subtracted is larger than uintptr_t, then we
> > get errors when casting back to "void *" type.
> 
> But probably error here in such case is a good thing, as it flags an overflow?
> Can't user explicitly convert x then to 32-bit type, if that was an intention?
> 
Fair point, hadn't thought of that! Let me mark this as rejected so.

/Bruce
