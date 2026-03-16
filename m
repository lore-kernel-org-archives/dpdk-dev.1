Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BD4F506D9
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 14:20:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A67F84025E;
	Mon, 16 Mar 2026 15:20:41 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 98AB5400D5
 for <dev@dpdk.org>; Mon, 16 Mar 2026 15:20:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773670840; x=1805206840;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=xYKFOd6UwZVQNTRl1NmtrNr669jbI6xe4ZDGqhkWS0I=;
 b=e35W77K4UqAGO1CCe4s59Swbo+Ez1aNfryl3ez0WlpJ5D5wmNhVxOo48
 7zgLhRFp/mbrjCukwDFULoxKhDzm3WbSwlbdRhLM28N+t1/fS6RwS4VS+
 JUdzY/Bxhp83HPGer4RLS0FnPYMJge3MjoEpupwyB2T5Yb0PCkIGT6VM7
 +OBXxIzb/uH3mzUOE2GGu/G8V1wjN2XMqRr40lJC66Qg414Xn/Wap9JG/
 w7KjW+HVUWlmmseBEemtFURdLoZUQ5yi6nFClgEwjdygl3IkcPYh6wf6v
 DRIhzCCdgvPJAjprFKNQBec6IuueyHc/1qzUqErjQX2w2tRNPIke5aG8u g==;
X-CSE-ConnectionGUID: ZFSiFSGVTVmqjHb3t/J2pw==
X-CSE-MsgGUID: D3DgWUiuRNOtkq+5rj4z7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74660558"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="74660558"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 07:20:39 -0700
X-CSE-ConnectionGUID: wyEeLzN9QramVfIbyV+KJw==
X-CSE-MsgGUID: ubegm2llTb2cCzvYgLJzBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="221879094"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 07:20:39 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 07:20:37 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 07:20:37 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.44) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 07:20:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bn32i0mJZKuHJVaKc5EdTSa8px5+wjKxOzLvceO5Mc/57zp9QwZdZRWQQOT3PCkQ+vx+Tmetn+7xKrSFdnJ2MZ3Zyrjx0FvEeb+SbDA2oirmbH+6R8iWZajQJjhGO5zh/3ibkhmj3/EdxjZTMBihVCUUnBT5V8ibNVNHcRNL5R7i6CsyMGYze6Ywf6jCkAaT6dh8tbUZFsRl85o0zUBLoTo9ZXGzFyGpa+NBq9mZD0oU6XjxkridkfjLYmYCQHg6ppktQaa+kA/439sUjorHl5PCzkna/5lV8hKsjXCS0Ov4dqvsnsQYwFx62CiCiALd940RBUZ1+CDFzK8d6BcCVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhTO5jXhx/S2Tl2zG/hPyUQ6+r6+jnBae9Zv1Ob5lPw=;
 b=H94lE0FTZP7cY0dJCIaAA0NmNwcLTqpeVs9zk8hcN2ugqb5Sx79yUamu6/FhMZ/3b4XpFI2jR0NyVwJU520NlvizX6TOYNnurps5uYhdexgT3GjzuTxR1BYiJXXJxTYv/Zxv9OA6xy5oJjJ7tLHMGXAzRKR6+w2f+3lUOw6mW2y2cEmcQeNM5t6+IHeG4O6UDu5KkDFN3ztvYuPXbUhKdfM/5Q9LcFXLnIw4/29EwpWHdI8ff3CnW4wf+B4cK+mXPIXOXpaqc6ekPnYC/L6g7Qg5rdkBHX5Cr4ldNTdXxNQArNrhHPP/zjsN3UKxzEPdvjlVWQZ8piTTL60cbBEQLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by MW4PR11MB5889.namprd11.prod.outlook.com (2603:10b6:303:168::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 14:20:33 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1%5]) with mapi id 15.20.9723.016; Mon, 16 Mar 2026
 14:20:33 +0000
Date: Mon, 16 Mar 2026 14:20:28 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Marat Khalili <marat.khalili@huawei.com>
Subject: Re: [PATCH v20 16/25] net/pcap: reduce scope of file-level variables
Message-ID: <abgRrFjEEjvPSc55@bricha3-mobl1.ger.corp.intel.com>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
 <20260310161356.194553-17-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260310161356.194553-17-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0317.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::27) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|MW4PR11MB5889:EE_
X-MS-Office365-Filtering-Correlation-Id: e935a028-8ace-4bbc-49cf-08de83672f94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: v2co2avmD3W9oeWdvS7UzpZFa0X/mIAgHIrfo1SU3vbETR2Vou7me0wOy9sUwZ9RwVr1E+7d+r3IyKZux7QGAX36M1oYdHt+p6i3aO3M6nKXgCDhjrEDVm6npTCO4hNCbfSIgmit78T7p6JtqP1P1ZwjFL+qR8zQMEbhkybrQFZMfODLSPcnLrdrhbCzFJDwe5sZTMta0ScdxvncIg3BulqNZuTRI/wVi1YrVTwOYXFdwUtv4X8opwCz0OP8eghcs7okrkKA+b7iPTZ8EZmPvveAKMK4+enJzrt1Gh5R5YGjPAC7FckmEYmZNMD6UvA7DCvxngmLkg9ozXv3Z6ftPdwORuDuUH5l+iiQVrr31Imju0tRhwQjESG3BOW0Koa4nTyttUOV4YAuj5ASJSBLWC18traQ7t065kAlcsePcOkhdg5MzbnhPHGAhC4zD6WOcdRCRW10Gzj+4iXfKJN3dmSo6sBkQ1lD1Ixmu2zPEzoOF17QXTEiawOHbutrX5J18LiSCKorwwq0HTfiYTOkHtZKO0d32KfD84SXNzG2Lh6b0WduWc9vmwoeqbldx+eEAtAI+lPLhWDaoAVBqa1wCx2EtLACw/0N8+s0SpYPS9VYjfZkx0as8+Pob+iSbR7NDoMLjz/JDPmeGqJhqlgqs50zqM6Yfn2uIoZIBIIuNIs2F8OU6ka9wPwwr5leavgjJwmuIdjiBNK/PvFNwCscKX87FDev6G45/AgUCwSkJc4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l0t985NAJsM7QW9eQqafjAFz9knFeMkxP0pctMRFGQEBAkSCEdeKLN1vnzo9?=
 =?us-ascii?Q?wZ7a6nAPn0cQcU2DQZDP6PPSZBtvhwNnT1HiUXengh1Q4Y7RUMr/S5CAm6bR?=
 =?us-ascii?Q?/8i/4+BzH2AIEXHjr+fyuDEwc0IEXCtSH85r6Px4L7XBvBHwwkWUgdZHTV7e?=
 =?us-ascii?Q?vUtXa0yQCNVLuLqJ0jSl5YMeEvFfAaKVFWxSIAP4mabmaa6M+tYcgSypFCGY?=
 =?us-ascii?Q?P9IvfNZZ9gMS1TF5zj0lYr9kdNqQRJF7IJCUSmg7+Ps/89NMq3HUGyLsahzk?=
 =?us-ascii?Q?WqzV0oKh7U4snAHTItY4FdX5tlwb8FLKq77mrtpBdkdETWfU9LOMtr4qiDi2?=
 =?us-ascii?Q?rTe5pEioBq2OZjkbe3eYAyDgXFqRCozZqdGiuzUdKB+j8MgqOb0vmiWPOyuq?=
 =?us-ascii?Q?Yftp7T1vCwEvuF087Asx6zuk/7UL6Bf8VTaokFao61XcrMBA6aeYp3B9Eio1?=
 =?us-ascii?Q?3BT+8GzIkT9vj2jiSe2r9EOeMh+A5MQNqKPaFmJt7iOfJ3qRzlJPZCeBt4uS?=
 =?us-ascii?Q?I7G7q6lEy8okJJtlqf27sNnz45pubUIXnPEvfqz979xLz1BVyjaxb5/wemM/?=
 =?us-ascii?Q?PANtY2ZayX+Qi9ZMXqQMDTTkolos+tghMP0pan1Ttdfg9qjQXPf4nMvAQv6S?=
 =?us-ascii?Q?r3l8W1lYp5exgEsTiOL2TqU1IKvpkfSaFuOwP53pcs6HH1fXHOLr+MgGXSnq?=
 =?us-ascii?Q?974Kfn7821mqaHrojMthcH6iUn2G7E+mB9qOe/7dND87rY1OoZTHSEbU0Yi6?=
 =?us-ascii?Q?PestuMlHDowhLJy2lB0FafRik9kc/++HVgT+1QVSCqN5gX55HW3XVBSvnkki?=
 =?us-ascii?Q?9jbS3Gb4oQ75PDCyMJSjzM9+bJnWHyREL+xGwDqYLqiXChErqtHgysZlM3MT?=
 =?us-ascii?Q?tjUM/ry/nw6CRC98Pe1cyvT26V08qlPwY2vgrH/+Go61ZxuGDWOzqlx/CxNW?=
 =?us-ascii?Q?p/CW0TEb5UYoZOT9gNyTm0osTEkl2AEJfxQKwhtJRaaoAjyX96jfz2YgVNNG?=
 =?us-ascii?Q?H9+iNQu7lOVxm+NRkw3OVL0Whmgzzw6238Z/Hd5R9JFaOqZodCgdxS8rW5ug?=
 =?us-ascii?Q?2uS16JJQjUP1kfTEpg/oy2WpsJ7QETKyotTs6WNAolaqO1FCbUsloJARwA2E?=
 =?us-ascii?Q?acpCsFJWfw9dS8mFy+M6WFNsNBZlqL5vS0lkqlilO8OOXNQgNkxArNFdONiJ?=
 =?us-ascii?Q?qzCeXo9gqxfP5efEf7d3QFHH+c9Sej6AzTbaYDO2TtvsKzmnB29cboGbceEY?=
 =?us-ascii?Q?iGzo7Eng8s+ZFffr9YGmT2ODOSJYqH94Zwf+peShS43Lg2Tv5vFL4wIghWQM?=
 =?us-ascii?Q?K/QfTfnkyMDP4S4Gc30zl+p6/+nXVSQsvjIeVnAw2Gy7Rjno2DqsglMpgPqP?=
 =?us-ascii?Q?Ggi8yEmR875Sh8hnHvKew+i6WX7LEEYegqYQe67pseTSXvAp3YZ7wZgAZfCG?=
 =?us-ascii?Q?dB+pHgJvbuJvZtta1tYfRzyVZW5V+F0U9UXv0qD9co26qUH8lBiyiBIC2E93?=
 =?us-ascii?Q?4Db98H6ESYbqmUKNoPeDLwpXxqvHCksFcqifI50EhhG9mtTy4vxBaYrrBaNt?=
 =?us-ascii?Q?wtTdnT2gVWydebwQ7Lup2p1wq4nEIHl+vBuHMRl5HTlpzCoqHoWQhaFFthah?=
 =?us-ascii?Q?8q3nK6QkMB5CbjDuoQnXDh3MZQtyw+H688qEyRyGQiTOnbRbmqakePTj7pwb?=
 =?us-ascii?Q?p6o8tfL4UjgtENUrp8XR8F/G6L6GPADb3tjxcWncRS/0a+D7/lHxW98EZMhX?=
 =?us-ascii?Q?likNZPZx41ogNigahN519FC92Z/dYRI=3D?=
X-Exchange-RoutingPolicyChecked: HFlFcIpjTMqQOQ2qlr/StsL1+JmEZpfjTNioVPS7yvhDuI1wq3moZfUrddBazWkU2rlPoeeJJZqc8djji7NIpC02p3DQKoH7Z25aA4AtvPk7c7WJEsOLMFfDue7t20ie25Ap0avTN/6xdlrmjA+YfKj8G/Rmp6Bj1dnkPbgc9buOyb3SgR3J8hwBzw2tK3PkmeF3TRE3N++OdK2/V76nDiohI0va7qWmS345C/pK/lndYdEQAc3C8CUHLIqgwKWYB4++88aEWGlRATo6bPFD7DnmW06td69LTjZkPSPhwRsxyMx4ggsOWIZqBNXUnLBtpc5grbdd2hxJBHIvXr3kog==
X-MS-Exchange-CrossTenant-Network-Message-Id: e935a028-8ace-4bbc-49cf-08de83672f94
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 14:20:33.7480 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /VWJRn82vVgArwf4y23sPUNqYTFaUTYZ5hjqAke57/k8UbOl1bhWZg4HDCEqZtmWFL2WcD7b0l2TfDOQSxYQaP1T1jRE0ASDE7QD32gMwbU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5889
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

On Tue, Mar 10, 2026 at 09:09:54AM -0700, Stephen Hemminger wrote:
> Move errbuf from file scope to local variables in the two functions that
> use it (open_iface_live and open_single_rx_pcap). This avoids potential
> issues if these functions were called concurrently, since each call now
> has its own error buffer.  Move iface_idx to a static local variable
> within pmd_init_internals(), the only function that uses it. The
> variable remains static to preserve the MAC address uniqueness counter
> across calls.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Acked-by: Marat Khalili <marat.khalili@huawei.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

