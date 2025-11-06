Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 341B0CCFA05
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 13:42:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 81FA2402EB;
	Thu,  6 Nov 2025 14:42:09 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 81829402BC;
 Thu,  6 Nov 2025 14:42:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762436528; x=1793972528;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=VDFediEiIRB5TefxUVGCCZ9sB+p/aUY1Db8pQKOGfbM=;
 b=ODNRNTps+oDWpWC89e4zlnEtUx1HHW0slPb3VaOdxkLIKdfVDK8X6TN/
 9b2C+ca/bcc614L8Svfe6NIt0mAlK/eUYB8goO0vfrXJExxyD2KU5u1aF
 axSvwM4V0PrUgqqYcMz4vJvsF0HJZsud+ReKHk6mJCU4WucC4So9dVWoy
 +LUXMxvwiOkxJgirbIW9GLpQjY/HZLsjx1xo7xErN/k6ap0wz9lhekzD2
 VtpzQ7ffJOWpW4B3yeYPSgKO4rLOtVz5T7a8LkyAMLzDkkzM9Ojd9yxaf
 J3aFav44pNC6+jFrL2l58297AgrpI1BfhvSO+XWUpMw7KCJa9VBbkIOsr g==;
X-CSE-ConnectionGUID: 90HGdI1MRNONWrCnkTYfJQ==
X-CSE-MsgGUID: qiTXgoCZTUe6H3IMW2YVOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="68430649"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="68430649"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 05:42:07 -0800
X-CSE-ConnectionGUID: cz4+oEKlTTiBGTlkbAyBLg==
X-CSE-MsgGUID: 04S3npEEQ2eI8SRzC6pmbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="187702718"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 05:42:06 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 05:42:06 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 6 Nov 2025 05:42:06 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.13) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 05:42:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/xpV53vUS+WG6CKCbhw0qFOXkg071xCYr0mTvyj+l9Kub5/mJU93l2SWlEjDdlL9bEkU25ODE59twVOEJA96bGxk6L5czAjXmhgmAcQh5qbvxZGJqklgjsy/ikRYnw2LGw7vXQKYpBxwYGjm79eQ3VWzDx7zwt8RdkbUI+w3XufW6YcN6c/ELZgS2MAIaOszxGX8cRTyDFSislZEXD1mxzqT5NmG0doYhrBy3054NBNurqY9Ehz3ntBQ1A3bFQex/4EhgLXxNO+UJc+g1nfNAi10b9jpoQCj1x8Gusj/OLXMZ+VPf6ZxEpVZ6DD6fhD7p6GxZTa4AfuOROBl6cdEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yk+QBz6xWcCGVoRoUzPtyAfGlqm7iwiRp3OcJo59IEA=;
 b=XeOwKhA5Mn2lsJ0A8QvpFzQpJ0vDKwQYOdg5yKrt/ZcXGJ9NKkr3A0uivHGpd6AfIpY1oB6dWOTet++MtOUaUhwUhoD5dojsQMWgJMRGML3EUQvcW0UFzzadMWCVWGsIbPyh/dT0wxemWrn/liOL/a+neOiNOuqSMyuJANC9t1tm/XxMDC6jxepb3Y0xmitTLNgjZkhlLPN44kl7m1gsW0sd6djujtZNp6yGFj2Ic1XZ+woHDYvQNL+mJPtsLfPZ/HiZaHuYAXjPXpWygJacFJPcKYRxP80UDVieAMG/kGEfwB29V3E75zW2iZdKJqXCo3NgUtkD0vXaBJq8pqtooQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MN2PR11MB4710.namprd11.prod.outlook.com (2603:10b6:208:262::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Thu, 6 Nov
 2025 13:41:58 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 13:41:58 +0000
Date: Thu, 6 Nov 2025 13:41:53 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
CC: <mb@smartsharesystems.com>, <david.marchand@redhat.com>,
 <ktraynor@redhat.com>, <thomas@monjalon.net>,
 <konstantin.ananyev@huawei.com>, <konstantin.v.ananyev@yandex.ru>,
 <maxime.coquelin@redhat.com>, <aconole@redhat.com>, <ferruh.yigit@amd.com>,
 <dev@dpdk.org>, <ciara.power@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH] examples/l3fwd-power: fix telemetry command registration
Message-ID: <aQylobE5s0YtsnDt@bricha3-mobl1.ger.corp.intel.com>
References: <20251006101058.191495-1-sivaprasad.tummala@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251006101058.191495-1-sivaprasad.tummala@amd.com>
X-ClientProxiedBy: DU6P191CA0041.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MN2PR11MB4710:EE_
X-MS-Office365-Filtering-Correlation-Id: 329eda14-c147-4d4b-eb61-08de1d3a41f3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UvlldSYcTcputrZL1F81sMRMZatN+ouAkQJBOxm+6G6ne7+00hBV9SLdJuKk?=
 =?us-ascii?Q?vXnk8LySlhJwE/39lAi4HWe+YtbIq+jGVnM8cMs+7nirAnpbxXQBGWLgD/hl?=
 =?us-ascii?Q?z/BXgDZP9NLCfKgJbLMdV4m2EGVR1+euT1UsOLQxGmaneBW1qZYgwx6sXcDN?=
 =?us-ascii?Q?7OD1KtLaxC3nFh9rGudap/cpRnd2+pSn6dvihX8sGNVN1QrWJog1LTgXGksE?=
 =?us-ascii?Q?cj8VK0fc3YelctD6XgbUSyd6H94ShSiFQ2WSHSutxNOC86RuduxmqoMKqkY9?=
 =?us-ascii?Q?GhrpkHSgTxeY5VJUvHKVd70uahyw7lV2w4MVRdooOJ0c7KNsIelpRzKbEI/q?=
 =?us-ascii?Q?jr2tSq9N15xrNYaJGxh6aipVs1sQWpS5s/oc5rLC6630NYHr7F+lZ1vIA4NO?=
 =?us-ascii?Q?ARnoCTST3CAb4TCXiQkrDgn6DXXljNnGfFTM2nCvI6Ry6hJ3woP2VxBe4qL/?=
 =?us-ascii?Q?uOuQNr0x9I95mX0F/t09xlmLwS01SwmZ36fMrCF7AQjSl8XCLX3v3LpZiaM8?=
 =?us-ascii?Q?cezcnzF4+e1VPNyof/GTZxgcPpa2jY5EqPeaKU718DSYd3Aei8sA9LdY4Uxh?=
 =?us-ascii?Q?wqOP9x19kxgR3X5YWRgThXYghHPLHLWtSCI8E/Ij5X2JYOOXZQPwU8MooLqi?=
 =?us-ascii?Q?4GdeRfTXWucJrpRG45DxhKm/yHm8UD0JgyBy510a+pNSonJArF8U3v1JgUwh?=
 =?us-ascii?Q?7YyUK1Ynr4trnrK//Qu2TFsOOW0pmJEgP+gd4eUkFYfMMZibsY2FRSZz3Cg7?=
 =?us-ascii?Q?C0TiBez4UOb8dBgCATAFXpwg9+v/+G7et+fcbZ6VU5Pxzq76kNr86IVKn+38?=
 =?us-ascii?Q?ljBANp9tw6I1YWHRY42SHYXKAaqeeKnF0zwt7v8ZvTTk9is51UWfqU7usAUt?=
 =?us-ascii?Q?meD++sxkZcx62zcZOqABLRGGxQe4Lfd7iMARUjShuiS4I29k0YUvakIIlChF?=
 =?us-ascii?Q?Dl3Zp71wRoCRa3B8DIly4gYBpPO8H+KMboETbWHvnGGUZoukvpQeh9WvGkog?=
 =?us-ascii?Q?ZB+ws/pIwzPKggMY1s2/R6Eew93CWdFIWjfa3OmkY7F9hf92Pkv3M+dzvlLX?=
 =?us-ascii?Q?/U7If1SNVJQUEssdpKYsiMKZ+Bw1SSLuuRvUx7wyBqYoKIGRNnzaG2G2YcTl?=
 =?us-ascii?Q?+wHZQCH4ih+N2iZsMZMlIcx0LaTiYSZ++uWD4xsEb7jVZcU6ZrImkf0/aZud?=
 =?us-ascii?Q?CVfXfsG5tso+/BfuFeanbf60HufuA3S0mTW+McIfNXtWxp6bb/hcMoH0VOiF?=
 =?us-ascii?Q?H+kTZ4wC1gByDrNvNtLIqd4BAVYYHOu9KKUIQkVbGPaoeilInPNPQSe4Y6XG?=
 =?us-ascii?Q?ScC1Lx6bbxW7nTth0UiXKeyYX4gNVhLLeJ9rw2Qqm7eYNgvYfYvSZU00O/pO?=
 =?us-ascii?Q?gtHrtGAb3uwbIqLhJbvKz/lRHcqR0M9pb7gDzSnMYuXWQk0yeK/UuAZB4OnJ?=
 =?us-ascii?Q?D+ZR8IgfxPkwrg0O06jRWDw6d8mwb9AX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IEQXEcfFxZiEw3cqTqnQjEahonh2sWbdy4QlLPURtioNIskINi3pVUlu27jS?=
 =?us-ascii?Q?CdDgKpVEmXFJMSTZptyxJK9Cg0++3g+ZuZW85m1Vvq8xlr0OdVdPfg4YLU85?=
 =?us-ascii?Q?nqXWXq3THI+jAplrzkr5GxUZYNvcnZbBLORhLUkVPGoFQJOwoDczh4EJ8ZQG?=
 =?us-ascii?Q?HK6mED43RktvUWs2dfGwJdw74NhVhl7Jb/iJUr/lirB0BVVqUYfY8aUfwRoW?=
 =?us-ascii?Q?9dilSG9y3/C7pWntvgqKEOAAL8OMxYkUKSYsel6Mcp1l3NJppEnfoHzjjOO2?=
 =?us-ascii?Q?ACcahTAb9aT93QY1fTU/NoIc7jonIuNGneyK1MnT67S9uaePswreGecCC5oC?=
 =?us-ascii?Q?MAwS3raUM4BxE/ddTLHMVw7F71hXwDdFVvOfKeheBHqrVAMEy6QDuQg8f/Bj?=
 =?us-ascii?Q?pcdNKL+YOXdGC5Effq0+laLi25Vya9F1HUnX4xBw+xXd1L6dUwXqCvKTxHe5?=
 =?us-ascii?Q?FI8KFzqgfimjVWd403njCu45oNvO2PX989ARrkTKOvNs17zBxLE2Q1YeCu/X?=
 =?us-ascii?Q?foK5W5UGmkdaSgxPLnp8/NjRM5HnCarUTKinlV0aG3uMV0F0Vqdd1UNA/nKo?=
 =?us-ascii?Q?l4fr+eG63x9N/rDcXoKhLb06LB9iJ3EWplKNCHx1Oxob2Llyi2xjuUzQb2zt?=
 =?us-ascii?Q?vpwKlR75WhltdKAm09WH0dgml/7P/PMqEVx/1x1rNhAgwjKPkDKFUHwL9M2U?=
 =?us-ascii?Q?n9DPn3auwFaTHfNftgZE6H2N46Fz3rEnbM2DL9D3tfEoEDufXkYDkXSH+l9v?=
 =?us-ascii?Q?ljnasc3lnlIBamJjpS4CUI+xGyOQkBUpZyZImay81B6hkdl91yqlT9u6QAVy?=
 =?us-ascii?Q?LL/oX93wL0dIb7w+9QbvQ3SKSPKpzidtOOr4jyRa7247aAO8Ieq5MXHwKs43?=
 =?us-ascii?Q?VGIbsNRPGQOkNMxB/GEo1rASdOtBJWnLf7cFotBtn4rxscQGCywT5pnTSn11?=
 =?us-ascii?Q?FAAh6fzfZ8TThI0sZtHwFhgEw7MG6wnQWpKvnCHCe9FDMJn0jKe+trCM1/YP?=
 =?us-ascii?Q?P89B8KPW0Habmob5YLymStQNyELXDcAbBR3U6qMk0yvbdCnTHm1yl9mzKmhy?=
 =?us-ascii?Q?JH4l5v37T9sLntHswOCg9Au3gWca2HTq3kLoefcaqWNTMQ9Y9x4rYaToNTrO?=
 =?us-ascii?Q?vOPVStvqwoH2mcF9+ahtrcuTcC+CLUMFX6s304KgxYryMeQCu0II5lLg1NBi?=
 =?us-ascii?Q?WDIB0NG19e/4SituEmCLTJezlqP96HhGlpYb7DyuGfxyjJEpRnL7V8WcxbnA?=
 =?us-ascii?Q?JLkrnjzD2dEiMZZSNB56Q37EcVVLX/JH5xiNsUGD+digLPVWz066KxZBYTwE?=
 =?us-ascii?Q?j0dzGtlQNjS+41v/KKAYUvQyR52FrA3lebkS/HolB/Zx3dE+myM9bEmJGxEP?=
 =?us-ascii?Q?8ppf4VjyM+GlfD+h50tgh67deaHJMCiCA8lvl5hpcGgrMIzGfO68GfQEWwdi?=
 =?us-ascii?Q?oLn2XuScbWKfjHPpZEdbhT0xaqrrQ2mQY3tmoSesA7JXzx5OcvIr8NI3MxQJ?=
 =?us-ascii?Q?s/nr+PrAxOanraBvIDoSSWZ3aPE3AjPZXchcMfZZo6I+Mu310QtkwpetPSbs?=
 =?us-ascii?Q?CW/S50BDogin1Y2cKMLD6gF58OG8ouMvQWrUbEQ+wsmtKcRIgchdaNJ5AnBU?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 329eda14-c147-4d4b-eb61-08de1d3a41f3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 13:41:58.6654 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UTh4+tyIaC2Kw3hmSwURQU27JD006IETFii6fCDI1SQj7G94gMLXH+OKmoDuehNUGTBKo1wAZXpwu0h4PzUU5fV5DsecQkFJ7HTq96kWQvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4710
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

On Mon, Oct 06, 2025 at 10:10:58AM +0000, Sivaprasad Tummala wrote:
> Telemetry command registration fails if the command name contains
> characters other than alphanumeric, underscore (_), and forward
> slash (/).
> 
> The l3fwd-power example previously used "/l3fwd-power/stats"
> as telemetry command, which includes a hyphen (-) and causes
> registration failure.
> 
> This patch fixes the issue by replacing the hyphen with an
> underscore, changing the command to "/l3fwd_power/stats"
> 
> Fixes: a35919a1139b ("examples/l3fwd-power: use new telemetry")
> Cc: ciara.power@intel.com
> Cc: stable@dpdk.org
> 
> Signed-off-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

