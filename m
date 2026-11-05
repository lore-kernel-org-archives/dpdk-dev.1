Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AB5606A328
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 10:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=k+mZNajp
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 92E9240E03;
	Thu,  5 Nov 2026 11:59:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTPS id 44EA940296;
 Thu,  5 Nov 2026 11:59:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793876387; x=1825412387;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Xtho2olDYaKurlgZya/Ix2t0OwrrUhfhvg/+coJYIz4=;
 b=k+mZNajpFpEU8LfUEa5k8/nQsz132tpTo0BS7i/OSujpI/YCtAz6tBV9
 gGSefHL0RzGg3zmFcHRGJ7tXM0VCj8GxSLLfW7rU0gxPZWyxTmjDu8i8F
 9oZsjQdwTcM+dw75kTgk/pL3Z/AHoph+0BBaNmXQJJltO40QI7hvqinrR
 CkSmpVvcSS5KlqLneRUmi5+nUgiyJzlFNmjcTt5GJsUQezqLJqtWtHExr
 z51Qxz+dll9N5jahQEBmNEttWGgZ3AFb6Yx+mk9qazch4RdJDZP4XWDtv
 UExcUs96dtaUCGWbgzlfeNnBF3fIQPsN19blEG9Nxi++VSX0oDoewJTh4 A==;
X-CSE-ConnectionGUID: 4mudkPy5RrmZFaimor8rkQ==
X-CSE-MsgGUID: OWSlqtuYRKWW9a73V36xBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2556750"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2556750"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 02:59:45 -0800
X-CSE-ConnectionGUID: +/5+bLc8RkiKkjncNWur8A==
X-CSE-MsgGUID: KT5oedbgTb+eELvhCcrLlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7315976"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 02:59:44 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 02:59:44 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 02:59:44 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.33) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 02:59:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DNqJe2RM5sABaBzr5MAU7+de680BT2RxjCEt6oQSXL6dJhXBNIF6yPWj8gzMV+iLXZ+Iv9wbYfG1fnunNdZWeJrN+/4ApuWSQsLXcdyJfy2AFTOiFsIRVXWaqaXvsk4rP/TTxqPOE5004uNKMR8r8ox1atvnGuGH8/wdQhatSR4Cz9WCIZ+rPTgFKQbDd7sBVYOlabbVy6ClOraNIxHsCtnG/j4uM0YCO/WPUvco4desPPaZKxL4LmxjzMjZQP6ZYNp9ikDJo6j0yJPO7+zsSIkY39r7SSHO97lNIuDnoT3S7LswIcg2KNBy+uQQ1PRVgzpgLThqHsDTQ/frQOz5Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHOyGHpwSjaxlhq1CwjcJ0GTJurK8EcQ6JW4Bz7MTuA=;
 b=TdQCY054jdEZim2XARmt9ivP35r91t/ViYxbRakO3kFtBLxpDXGOVGcNa2WeRQtzXz8ISmzu6R9B9fUWdoPVoeqmU37mZpU1G0/QE8swUctsdYxW1jYpkGuHHyJhsID/wbnYclfVlCamQ+cWe87Rai7z6JvxCf+JPnXpjoK5M6G1UI1vdF4Lfn4SPidiSWpwDPmRWmo8+aYe6D3vSZ8olJuP3+vmBmXF4vZ2i9kRE0Gqz2ScwyPgLx7caqW00P7kGQuE3rrBml81NrlVJtpRBeGxfRHXmv7hpEUrXMHhVHrGPlmltjGYEkZi9U0ntCCykGw30o3qnRGeKuwMlR9wvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 10:59:37 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 10:59:36 +0000
Date: Thu, 5 Nov 2026 10:59:31 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH] net/ice: fix RSS rule overwriting an existing one
Message-ID: <auxhk7HBD10-1Bwu@bricha3-mobl1.ger.corp.intel.com>
References: <20261103064438.390149-1-anurag.mandal@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261103064438.390149-1-anurag.mandal@intel.com>
X-ClientProxiedBy: DB8PR04CA0013.eurprd04.prod.outlook.com
 (2603:10a6:10:110::23) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|PH0PR11MB5902:EE_
X-MS-Office365-Filtering-Correlation-Id: a74432fa-de40-42a5-56f9-08df3b2be1b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|6133799003|10067099003|22082099003|18002099003|3023799007|56012099006|261022075727099003|11063799006|5023799004|261028144727099003|261102123227099003|261026121527099003|261021121427099003|261026140227099003|261022105027099003|261009223027099003|261022113327099003;
X-Microsoft-Antispam-Message-Info: lERYy8NZLD1oH25ShFjIQhBfRJl3jFWPWQQtQCK7mIa6xZuEhjiJWY2BivBrCyPnDWKwfR94ebrc/k+/10PAAn58vwB+5RhGGLqYVAzz9BQhRlN8UouiRUuhV8dP8QS0vAy9djrsQisA0W6tH+djWg6GpEO0UMfM8fdz0l/V/61hqLbSselAonSlkHjYLofynY/F/aIPe9Geq8S0OiLfEZeGyxYrp5Vuxku18EsALDdTl695s71Jetzk/CUQwvrySZLHhthRWAKkeZXUMJkdTFIWOW2Ht2CAidL+zqlYB7GV9n8VoLdSWX72BR5IzrZa6m83fLBferoGHfP6DEwg76ispThr6fYSXLu6q8DO0secxt3X0MCNMAjgcY+8MQD7ZimHwhZeCSHK8pc58VegvDmNQK270IZT8q7AoP4rrE9/zFRtMVV6hFC6/Ib/MuhV841QJGbu2brqOTXCqS1nf9cGM8HiIzgpK/CW5Se5W2lG+iF2oXbRLPcCj+ITe+ITM1POasMGuEHyVicgSGIgfFKahxAGoVyTqPayRPLp5HPRf/62IQ+BxdiXJvqaqDhq7YGARX4qQ154GG8gUaKnT9FE9HbME/2bt4rMRk9H4Ag4/4Uvpqh1KgmPSC3eHoRI2Aj5lYBzHySsk1N+7ExT7HwduPnTg7TCl8RQH5NHWr4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(10067099003)(22082099003)(18002099003)(3023799007)(56012099006)(261022075727099003)(11063799006)(5023799004)(261028144727099003)(261102123227099003)(261026121527099003)(261021121427099003)(261026140227099003)(261022105027099003)(261009223027099003)(261022113327099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y1C3VmLD2UONJWuLCFhK+KNTpdj1sTcmSnoVtO8XAvqXoP/Y5oMR0r1QDM8y?=
 =?us-ascii?Q?EpHx6sC83ha8Bws4+aNMeqk5tmeKMn7DEssvt3EJObewhZHDUbJx+xhAKLV3?=
 =?us-ascii?Q?OIoFYW6ZKHoJuVQR9vYaCxP8r3gVAcj2Fpox9eCNaqQfG8lWwoudWrrEZJIR?=
 =?us-ascii?Q?RCka6ZhjrQSjtQYIABo1QsEvkbzneND63uFIz/YKxQgeznvrmL1WH/RHLBqr?=
 =?us-ascii?Q?KxYvrNL/VhZ5rgCXqOZSRs23NjsYJOLcuGeyKVUGYfDoSl7tyxXVxieVlnPQ?=
 =?us-ascii?Q?yFdbAnftT5vM7zoSTUbp+eovTMqQVtQ4UNJfMyCcQdV2vl8+NC6pXPUAG+Up?=
 =?us-ascii?Q?JQceb6GtGddjiQFVcOHDY2KRRA9o8PiD5nw2F0rYtQNeZ87WgaYkx7NEtO7V?=
 =?us-ascii?Q?HPj+9/A0oxxPNwVE3S8D1SpgGdnlbusUYMRlnfO4m3PEhzXp8MP4eleosnac?=
 =?us-ascii?Q?U4ru0zqX5/6R4ifF9E0WoqrAbWwylHgGkwkjRrK/i9QFF3SmkEo+heuqIMkR?=
 =?us-ascii?Q?p6MyE+TYLFbtyzxIjodn7fkWeshzAhBnwr/QX0XYTO0y4Jxgh26SRHZPhtdV?=
 =?us-ascii?Q?OofN75OhfYOXUc7I3iGVvqmUrk3HyriNJty8YOs/gjUd4gIwAS0ONucgFAG0?=
 =?us-ascii?Q?Ad9ehJ72KH/lhdsj/2VJxf0O9dFdc+C3xnvLUAPu0o4K/gU3dHWzXjZYWtd9?=
 =?us-ascii?Q?Pq8smpQr8UQYclAhrEp/rQO1ZZB8yjNc5qT8Ty9RuQ/EMLUSiiF5lmu3lSro?=
 =?us-ascii?Q?elHvN6y6Vkzi0JNJFTcFN6AsGVUm1fCUOhOYCcF96TdBxJn6tU7jhu4f7DSe?=
 =?us-ascii?Q?A0ofFa1HytQ/E25SpEbuBMcTko81q796qeHLZertOoDR0+ei6n3WgyM+0FLy?=
 =?us-ascii?Q?rJ4Zpor3Hkqlvq3UrnZGEP8UeYatXC2GpaqMdX1gM/0OzTs63WT7lDazGjSS?=
 =?us-ascii?Q?CzFJbMZyBtPpEkf44U0dm1D0CIUVvu1J8jLHoTiHB+mxiLLogF/2HtwAT+WB?=
 =?us-ascii?Q?4507I91m9gark2l4whpU5oTssS0GxXTa6EJI4JqbpQu43dbpzaGUSOcEh+Uw?=
 =?us-ascii?Q?VcdAzvIzqfBjKj2HtPjRyYq4YUiWzyO0e8CYr2DXxInGUqS3/0GPovHb6p2o?=
 =?us-ascii?Q?e7R6rYdh038JjTvV0WJ0Cjyk5i9RUKXJkVpaNO1vdR2H0wk5EN66XHEEguwJ?=
 =?us-ascii?Q?hLjww/yASAomNvMeUsgYh3hye1o9/mIkPL2jwp9Fb8QFlvIdWKjdMzskPdiY?=
 =?us-ascii?Q?RUrFxp5n3QMSGOAqzehUIJcPn0F9jFTrDX3qeO95fR7cz+u/556IPoaC1/6Y?=
 =?us-ascii?Q?zzdIt3ug+jVEUFLGDk9tMYB/99hURmyaf463B7Ab0qhE7Q8udZV6SPTZL6EP?=
 =?us-ascii?Q?F45VhtDBDaMnkYXsBtGTsbwVTH2S2mSu29pk6j0xaNvkyQ3E//2tT+x6TLkT?=
 =?us-ascii?Q?iw7P6iFNdpyiBR9SR1AzY8qhPzDQbhp0T3Ou1yELctJxn3RBiJOrrPwd+PJF?=
 =?us-ascii?Q?iYAH0dWGQ6h5ux1YkfzMOXByWjaXyt8X6jQzvkvHDWAgnCToSe0xjvavByvu?=
 =?us-ascii?Q?qq9zoLbPAH6cF7EzzuoNrthiLZ3rKz7vzQWuyEzMkb3WP6601yb7tA86qa96?=
 =?us-ascii?Q?FKAWvKwEsPM2jQ6yugZ40zH8izLhy94rjGNEpqVqXWyf9vaq+8U75438xmXE?=
 =?us-ascii?Q?YNAC5qK6tRJW2NukWdBM4QaTnNlBjV5r6JYMDEYMcLGZoJCkDcdjuVBhNz3F?=
 =?us-ascii?Q?JBWA1UKDO9Q9y8p79yTeTjyiVP5iS4U=3D?=
X-Exchange-RoutingPolicyChecked: i1tqmEChs8mxTBj4xHW0cFaw9ur0TDeJltcscCS5DMetqFOzxrTvxqjR09GV8O3WrtObz3myp+eDqlv+wh05wYGLIyVkznZXsfMo7w5i2LY23agsZzf75kSC8Jhm89jotk5xnKrhcOAoWZijXFMBsf3dH/Js9FQsx9Mvg6SEw+U2i2heS8Y60e2XxvJppOHdK+VdKl1+hZ68ixfHhkyx04v0VG9csLGTipL1x3DnsRlWATVlNTX3/jb5XY1Ibtql38F6bUDchPuf1ooULOmKcB1t7okebLg/p/dJT/4t5Q5KBKHL325bUs86COWydps2djY7aIj0l8tEf+rq65CmCg==
X-MS-Exchange-CrossTenant-Network-Message-Id: a74432fa-de40-42a5-56f9-08df3b2be1b6
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 10:59:36.8720 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zw6kwvyn60etzywWBmybLAKwaZKvNYZSR/Vu2kC1c3rz3ADiaaE2dQWc73T5KlH1tY7mSpXnCHL0sXcMQN4HdUnuoVF7Q/BHUwJoaxezCmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5902
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 06:44:38AM +0000, Anurag Mandal wrote:
> An RSS flow rule only selects the hash input set of a packet type,
> & the hardware keeps a single RSS profile per packet type for a
> port or the PF VSI.
> When a second rule is created for a packet type already used by
> another rule, the existing profile is silently replaced, while both
> flow handles remain valid.
> For example:
>   flow create 0 ingress pattern eth / vlan vid is 1500 / ipv6 / end
>     actions rss types ipv6 l3-dst-only end queues end / end
>   flow create 0 ingress pattern eth / vlan vid is 2640 / ipv6 / end
>     actions rss types ipv6 l3-src-only end queues end / end
> 
> Only the second rule is applied, whatever the VLAN ID of the packet,
> and destroying it, leaves the first rule without any hardware
> configuration.
> 
> Reject the creation of an RSS rule when another RSS rule of the port
> already uses the same protocol header stack.
> An outer VLAN header is ignored in the comparison, as it does not
> change the packet type.
> The existing rule has to be destroyed first to change the hash input
> set of that packet type.
> 
> Fixes: 5ad3db8d4bdd ("net/ice: enable advanced RSS")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
>  drivers/net/intel/ice/ice_hash.c | 43 ++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.
Thanks,
/Bruce
