Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190E5E9E2F8
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 12:05:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49194402B5;
	Wed, 11 Feb 2026 13:05:09 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 1554F4026A
 for <dev@dpdk.org>; Wed, 11 Feb 2026 13:05:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770811508; x=1802347508;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=wDd3Z8Wo4xJK0nObF20R+KCmc0bhJaviL7rIPQNYuA4=;
 b=CceSa7/eYihdyRMojTnFeIEmyZEMTDkabYJyiFrAYXRZ7dMloNwrAYNe
 OJeVkepVTuqwHprmCClLO9EU5FJggkW18PgzcoZjEKo4kzC3KExU7GK2y
 LXjmIrfE98MNcyzsfykkLKaSP9gIyfUCrPL+YinNAgErOk/5D++zk9cMg
 8uA7rqiE8vr1pYn7/gCqOgk+oenK+sUpvsdgn2maj720yS/lBlm2HFy+z
 HQPURHqpor86fsUv0sVKv507IaIqEJylRXVl4ZD2gKS1Z/lAfDQ8SHtgh
 l4HrZbUl83uCtjGvnDZ0RpZ1vyAs11mHtIeoCAPKBV7PlVcr2Uv+qw2jK g==;
X-CSE-ConnectionGUID: rM/uJ3D5QbCV/ET8kc57mA==
X-CSE-MsgGUID: zIl5ylu4TNa13LYRfYbokg==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="83398456"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="83398456"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 04:05:07 -0800
X-CSE-ConnectionGUID: gW4LTuCxQZyAQmL4Yz6zJg==
X-CSE-MsgGUID: 3L9MjP89T1me2AeO9/D0WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="216395021"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 04:05:06 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 04:05:05 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 11 Feb 2026 04:05:05 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.53) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 04:05:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YP/IeVU6jd87j5s1uFzqnARWqSkzIYm2TOsNAAFwloYNAkWVCpzO2bmC8vewGspzpLQSOAk1SZk+zP/jeyK1J+CYRLNRegdWWT+SBHHSHT8+LJ3V+dXVOzucPZHbW5Pb1/60SH+a1ZHeu4PthLgOso8hgDCvAicpN915oyAwreitwUvq2dnCHnBX1FATJGV+8NlfWADaSZaUpfS1HexzBD5g/VaYpyfvp4tUZdzirfCXS2sngCDuwGXSZHPFjF8J76H0jQzmOAmt/7n2qrzEi0c+/D9SDbn4083t7L3/mDEebmKaegrrvNshAgc9McFsVx2380ikjdGo112onuPVcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+kbFwurlKJhvY3Ghy6X6u/g+3V5nwKOI8WtNGwfXKak=;
 b=umLbbXEPMBc/KA1gLcTgJhdJy6xJHO/Fu2w3MZDV3S1Zv7V/3y3nIgDNqOj3oSd4VBBfts0A4wvz0cCZ/7XTFJxtvL0igZz9j126E08gq9+FIHHzkZib1pL0963HXBgdgsKsl8pD0+dTLQ7Hk78zx/7sbsf5tZhNJhOIR+Hl5O+O5gqj5jzD95akUy3tGuM0ED2l44N+rs3CzRfia2ocQpEh5S4QnvfRqOguRZCQ4nz6y4p8xLpNrWhwEvUQW/szy8iK6fA6mnAMMPnjOdBfvN4i7veqj+EqA7jBavPHVExUFzGBwsAMhSopitFFzHvcM1BzhkczdBh3vbTBpAhOhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB6454.namprd11.prod.outlook.com (2603:10b6:8:b8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.19; Wed, 11 Feb 2026 12:05:03 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 12:05:02 +0000
Date: Wed, 11 Feb 2026 12:04:57 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v4 07/35] net/i40e: refactor context descriptor handling
Message-ID: <aYxwaRdE4YrbRA2r@bricha3-mobl1.ger.corp.intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-8-bruce.richardson@intel.com>
 <abad013f-0a13-490e-9443-0441233684c0@intel.com>
 <aYs8WvDxV84HohAu@bricha3-mobl1.ger.corp.intel.com>
 <648f5f1b-a19b-43b6-963d-3add913e1f93@intel.com>
 <aYtwuoRLGMISZkZk@bricha3-mobl1.ger.corp.intel.com>
 <f7c399fa-ac12-42fb-8961-020950e7c113@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f7c399fa-ac12-42fb-8961-020950e7c113@intel.com>
X-ClientProxiedBy: DUZPR01CA0156.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB6454:EE_
X-MS-Office365-Filtering-Correlation-Id: dd8ef59b-e62b-483b-6bd8-08de6965c971
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UU2IDUMXxeVKmyl5/VXRFxf9Wq2WR43UOi7nmHOIQqWFeSXfduSILGxPFZJ5?=
 =?us-ascii?Q?8cW5SWzF0g5t98VSeNwEtIvXDF0mnaXmmQgfjeaw4ltNaahGSt7h8h5uc/jJ?=
 =?us-ascii?Q?kRIg9D0cI0+j7vBMmHbUqRuepKKHdFHM70RQPITcq3PcEgEU6IdZ15c1Eed6?=
 =?us-ascii?Q?4Vq+jTHfT0nrzTBsp+efgRtFfR4r9qy7SnKZozCVJxJFDgU72XiLz0DfBzt8?=
 =?us-ascii?Q?tuBPmZvyCr5749cirQ8Y7479kkxqPvVEY2Ww3aGUpzzpBtMFBRx0kY0dEymH?=
 =?us-ascii?Q?vRc2ziatuPXDQOUmpLDlqnwOlKcmTmoPnQco5wS86PXhDB18WFWlYYD8eXLb?=
 =?us-ascii?Q?gLVU1Tqg38TM0zmdNWz1uEu8tZmRSA0cid0Vpg7pAwsXQXgPXeNs9vk1eOvX?=
 =?us-ascii?Q?xpBZoTExsGKHGSkZTtWBud/lGu4v8H7O3ZqYGWwhkiVVlji2kJ+cPIR1Gk3/?=
 =?us-ascii?Q?JwqzgOiq/wlBkdwwffcDrIMP0MlJP7n+3BRgU6PVTMWeuuZXqdoKzkL9NLLf?=
 =?us-ascii?Q?HLVe9mniS1nDDUBkI9FOqR0qCGZNN9riO0fqDqTbaLOI7gvDQWw8XqIHzg+D?=
 =?us-ascii?Q?sMl5QCb/uxSNrvczOv7wulHn7K4VP0sb0XTyKpO+Te678tqpOZ5UKFdJqZvo?=
 =?us-ascii?Q?pg+dASl2QJoXiNVB8lpAFb8z9fj7NfbnkrWHd/xYJroYYFhO8GNUr2Dvz+hQ?=
 =?us-ascii?Q?yyElABC02Qy78EW58ttUUJUxJDxfh4djjR1YScKwh25I8ET1sIRYMe7rjJsp?=
 =?us-ascii?Q?BZ1aSX30i4lkQZ6Y4SvOR0sbuO15tFgAYUkQ5jA8baDB9onXQqnQsRvVslHI?=
 =?us-ascii?Q?3kfY9XD1bKxlFq0jffuEk8NwBg+V+LcwiZirJobk0LnZ+1/MnHRyUIfGxGxy?=
 =?us-ascii?Q?pk+Eyo7291P/DHH2c/hzGkUzsQFvLiI0e2Keh5QfVKwWtc8RCmj0EjBRuv3t?=
 =?us-ascii?Q?brsr7L2DY+ZQWp5S/Gp0jryuem05TJmEG+veOhreN5feUwecb/JJuTqVDC9O?=
 =?us-ascii?Q?doNT55cOFumxCb0JV4gesgj/afKxdWDGltLMVZTDrzGAwpVRrZLBl/kjsMfS?=
 =?us-ascii?Q?4LGmgVAPa6zHFqykHmd33L9gRnsMttchfbfAzJeofbLMTTmjfzeBhYoMLxZ3?=
 =?us-ascii?Q?cOVNeaZl1LM23a24ot6yFlwecoGxe9Q+lXN+6UUzh5SboafMQ5TaDRuVviUA?=
 =?us-ascii?Q?NdXlfr/vjhOl4VkKyBhcyotyv9PTbDhLGGtc9WPs0cC/JSU2KlswpSLwi2ur?=
 =?us-ascii?Q?7UDB938munQeYX0ppAFS/ZYG8rl5vMuiwXvZYj5VgEU/0SJVToW9UVFbHhAH?=
 =?us-ascii?Q?P4pjVYrs7T/SZIrEFJ+pJuYH5Gsg/cy0OJePgkKyC3TxIxfbD8MUhhH61A1B?=
 =?us-ascii?Q?Kl7frNjnz8tW4Lfoq4/Yf7Zu2yGlRn+Nhm/vpx9rI0JK3wR3IwWOhr3RxhB0?=
 =?us-ascii?Q?9N8tvyDaC0m7CqtEkRKK9usxuAlkVL1YaG+5keDMMTwVR/jWTKbzZ6eSLarK?=
 =?us-ascii?Q?zbymxJEDVDhhaV0rmvBbq4YH0ByTEODXvWJp4ggtM88DVIWB7HtViL5XqiJW?=
 =?us-ascii?Q?9I/pEjIcI1PGqoFHfeo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mACoLrEp0z4+w6sBDo8WcQnIGUaWUo4OoW+/Vu5NOSwEL0jdrVp4t79o6R9k?=
 =?us-ascii?Q?70KQTdMYWscTuB2V9F9nkHL25loS5PAnEgY5puhFtjmre1+BEZcwkGOQiUCi?=
 =?us-ascii?Q?bYKI+eLdImtQiAcHpBQ4VH5wAvjZXv5IYxPtAYDc93y3X+d5Xx8I9yqw0YeC?=
 =?us-ascii?Q?4H9h12/n9PqpPpTXv+2uZFwpzuMENtvTPN6zh82AlNzYIImmyfh4lYbLu2/p?=
 =?us-ascii?Q?KhfIHXNF+KCryrpD8XEohkWkljGAZYSszi9/oAT+/AzjX8CCaQFvr+R+0H/I?=
 =?us-ascii?Q?2Tf9M1pBCoievqCia0P7LRS7Lrj2TdTzxfve9BNyPWT1/+YaVEPqHYF73+1I?=
 =?us-ascii?Q?CgRO1PVssp1ps1OafgH0FQz0rAxEKxN2TKtwBAQz3pJe/o4wRiVwerDPofCy?=
 =?us-ascii?Q?svTYMGlSxmTmK/z7D0oWIG9cL5/bMoVgr1SuI2FKQa3IxxrBKItYvwVqh3SQ?=
 =?us-ascii?Q?9pkDP15eL+l1fwAEMWAo9XQMQk2A6SuumA6RAg2o9QTMNC8UNxFvfrmY5dws?=
 =?us-ascii?Q?WA1ulYDdXpDMxLkZfyt6GqQexNf050xBLgaRpM6auc0MkQVw6dSpMuGkKZFv?=
 =?us-ascii?Q?wUAtruu8VYEqDsMljnhDjorTbDb0j/JNIGHL0rlnjgdJYw+Ii1TDFOhptR82?=
 =?us-ascii?Q?AfXQQI+zkbfL7zp8qGN1DZS9CNgTg/Sy9AKMZhp2lsKkuzKAmocyl+ySZdtq?=
 =?us-ascii?Q?1edtv2pW+ggX5xQtA3gakYbpkXAe2Pf0VgjixgJd6Kpf0iW0sI3oQ9B6rlSR?=
 =?us-ascii?Q?Kx6wBARjz1IeY4sd3uCaUxHIX/lrJK48sOGo0UuonU4RPMh8WcBh78bXAmeD?=
 =?us-ascii?Q?CgSdl+M6rEu4A0mweCQDOR/XP+CI5Dxzz6EQ41gR08Wy4UxWCkxsqSkV6I8R?=
 =?us-ascii?Q?L8PaMZr+8dl9BaRsYNheqlpRPb2gb5YBCD6r8lKIjaCgXdwjKrCpnBrCEahb?=
 =?us-ascii?Q?5bqCju86iEiTQ66tSlzo6r3J4ylsbZeLCjCo8n3Tjj3tpkBATvyTNbxIUTVu?=
 =?us-ascii?Q?+Lm1ZErqRHI0TUNxLxvyn70E8B6jbfx1D3hdlTMZuaHe3PwCLy58Xqqjw17S?=
 =?us-ascii?Q?e4H1gcefW55yodd3xj9NtGzvMQ2fhO/+uYfR20a8Tr8PSe70RmoR5Ng8QqG6?=
 =?us-ascii?Q?k86fPBccU1FY9DWN9t5rSKkkgBBH2PJ+wMWoOFOU4xUvfC0hW1U/bQ2uD5Fh?=
 =?us-ascii?Q?61AZnRleXSgHp5WR4u6ci593U1nn5JjIPWY/GihTN8buL9cldsEkAXV9Wmps?=
 =?us-ascii?Q?qbv7KkCzvox5QWS6p90apSHZUrkHXN+17B79+hmNnd2bbDIuwlqQXrd9sOJW?=
 =?us-ascii?Q?N94rWhEP7Jgx+u+JXS3VQmkHl4aGXYQ8HLgg/qwmnX8hxO/pkoJ0jPCU9oEI?=
 =?us-ascii?Q?lPiHm2ci4OLU9RblXe46GHiMHN6mxCP0bCJYEoj4CU5DUfpJqmp11X/nTZ9s?=
 =?us-ascii?Q?Wn0G3sDAjsIzA3u/3SepDcRVF2Ac1LFp34+e7Nb3N7YALZVocQUE0UcnA7v+?=
 =?us-ascii?Q?qXZ0gYzm8MMDZVUB++miNbZajC4Fo7SHLla+OyR8gMVTJVYTYldIMFioXzPO?=
 =?us-ascii?Q?bZYG2iVLVxt1klefBqTCzQK9LP31po4+dfTgGVxpv+szGx6n8bQmZU+nu9d9?=
 =?us-ascii?Q?exBmF73f7bvkLpZ98/aCqaWbacmPbkMVX5zQXUbVdMAwYEcd0kDCQ9JKNdbG?=
 =?us-ascii?Q?njWRiqOe3EEUqPcnMXakKDsYPMnHhcZT6EP+uTgs/Fh0K3dMLEKadW0/fer8?=
 =?us-ascii?Q?Pen5TiccIdnyFvPdTOeZRiy9AXjR38g=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd8ef59b-e62b-483b-6bd8-08de6965c971
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 12:05:02.8324 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kdMB/6R5ufTn987M1tOErKWWY0K7xsfLoc5PHp9efgyZREKEbAcx7iuFUA0gbmGewLnM6yVAp13KPcmkqX4cPbu+0tdeFG7z4yY5amB2+FM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6454
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

On Wed, Feb 11, 2026 at 10:20:40AM +0100, Burakov, Anatoly wrote:
> On 2/10/2026 6:54 PM, Bruce Richardson wrote:
> > On Tue, Feb 10, 2026 at 03:19:27PM +0100, Burakov, Anatoly wrote:
> > > On 2/10/2026 3:10 PM, Bruce Richardson wrote:
> > > > On Tue, Feb 10, 2026 at 01:48:20PM +0100, Burakov, Anatoly wrote:
> > > > > On 2/9/2026 5:45 PM, Bruce Richardson wrote:
> > > > > > Move all context descriptor handling to a single function, as with
> > > > > > the ice driver, and use the same function signature as that driver.
> > > > > > 
> > > > > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com> ---
> > > > > 
> > > > > <snip>
> > > > > 
> > > > > > +static __rte_always_inline uint16_t +get_context_desc(uint64_t
> > > > > > ol_flags, const struct rte_mbuf *tx_pkt, +		 const
> > > > > > union ci_tx_offload *tx_offload, +		 const struct
> > > > > > ci_tx_queue *txq __rte_unused, +		 uint64_t *qw0,
> > > > > > uint64_t *qw1) +{ +	uint16_t cd_l2tag2 = 0; +	uint64_t
> > > > > > cd_type_cmd_tso_mss = I40E_TX_DESC_DTYPE_CONTEXT; +	uint32_t
> > > > > > cd_tunneling_params = 0; + +	if
> > > > > > (i40e_calc_context_desc(ol_flags) == 0) +		return 0; +
> > > > > > +	if (ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) +
> > > > > > i40e_parse_tunneling_params(ol_flags, *tx_offload,
> > > > > > &cd_tunneling_params); + +	if (ol_flags &
> > > > > > RTE_MBUF_F_TX_TCP_SEG) { +		cd_type_cmd_tso_mss |=
> > > > > > i40e_set_tso_ctx(ol_flags, tx_pkt, *tx_offload); +	} else {
> > > > > > +#ifdef RTE_LIBRTE_IEEE1588 +		if (ol_flags &
> > > > > > RTE_MBUF_F_TX_IEEE1588_TMST) +			cd_type_cmd_tso_mss
> > > > > > |= +				((uint64_t)I40E_TX_CTX_DESC_TSYN <<
> > > > > > I40E_TXD_CTX_QW1_CMD_SHIFT); +#endif
> > > > > 
> > > > > I couldn't find any places where we define this, it appears to be
> > > > > some sort of legacy define, making this basically dead code?
> > > > > 
> > > > 
> > > > It is legacy, and does need to be fixed, but across all of DPDK I
> > > > think.  Testpmd, for example, has IEEE1588 ifdefs also.
> > > > 
> > > > However, for this patch, it's probably harmless enough to remove the
> > > > ifdef here and always allow this code path to execute.
> > > > 
> > > > /Bruce
> > > 
> > > Sure, but I would've preferred this to be a separate patch as it's
> > > semantically different from what you're doing here. Perhaps it can be
> > > fixed as one of the early patches in the series as "preparatory work" for
> > > this one.
> > > 
> > 
> > I don't think it belongs in this series at all, actually. The IEEE1588
> > define appears in multiple drivers, not just Intel ones, as well as testpmd
> > (as I previously said). However, if you think it's worth patching it out
> > just for i40e I can add the patch to do so to this set.
> > 
> > /Bruce
> 
> I don't have strong feelings about *when* to remove it, but if we are to
> remove it, IMO we should do it as a separate patch, not as a rolled-in
> change into this one. However, I don't think it's a big issue so if you
> think it's not worth the rework then that's fine.
> 
Ack.
