Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00647F506D2
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 13:50:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B3EE402D4;
	Mon, 16 Mar 2026 14:50:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 9A9884025E
 for <dev@dpdk.org>; Mon, 16 Mar 2026 14:50:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773669046; x=1805205046;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=rNPcMHTaqfOTZ910IFjQGr4xqt+hKZbDqTB3yp12tMQ=;
 b=FI48t1YFOYDfwekUU8jWEePKeKDOXJXJhJcuFgrkPbrdylbi9Fiiru0T
 JupJpZujYgviQP//P9sFqlwAvuTmXIcxXdbbsuZPNQrz5awndD3X6Jozf
 dY+5lkv+OoUmllrtaWiVxKoVw4IJ5cE9OGLome+zdAS+dBTpC8uOddfUE
 PicmQEz53tnLPB4uRse5sDVOFST+4oRfwXUN4UUID4VEwOu+7k5tlEfb+
 AbYSE40gXzyYjzIo2lTTdUBPUOzuvPMhSQn7Tq4u1V3R0tBWi4zIanxqo
 VKr7ac8BLr311gWI3deXghY8PjTzAVeKM0utTWVW9acx9qBHZMWMtdA3N A==;
X-CSE-ConnectionGUID: lZBFIRRXRL2qm/+Mz1u20A==
X-CSE-MsgGUID: D6dLSu8jR+SDGXcbtFzjbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74601274"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="74601274"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 06:50:45 -0700
X-CSE-ConnectionGUID: UN7ALiG6TVSSoDsPDxlaPA==
X-CSE-MsgGUID: 9nAEUBlBRW2Kk/uRQ41tPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="252442882"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 06:50:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 06:50:44 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 06:50:44 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.65) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 06:50:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lOEmHEqc1DNe1sW2ILHZiL+Jk8v07y1XdLTxbnoLFwRbq7nhyx8mw8un9+SpzvKDPqMbHOh41jMoWaesE9E1lBAH3RzlGWDdT+NYNdRsH6JqrFBjMvT2Q2X8FkqABKobToZ6QM8wggdKoFa86V8swucZaBmTX3e5pxncEPCCCiNgGfUInRvQzWvm3glkgWbWfoFxGZz5cdt/ggUczQdi5PV/W2BU8q+VGgBmRuhXWM2/E97vohHwsjXkbgyOvvTL4383FkxjiMpnuiYVbnZhqHORYyzDRYq3Do/I52HIFyRC6D0sxpu6qF1Ceq8egFbq44zpdMyZMDEvTpNf9Znq0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5KbUCuPC0xSgaaFKUTogJUPVvSxV1KO0ChfZy3bwtHA=;
 b=Kfp1u0jPIa8KC0085ZWtvftyGWQlMx29J1/ZJuS26D/W1JFfBsNhsOEzRVirkjGmE4+U+8+dIcxIwWrZojRzfsXvCLVmWabYc+1jNFiw3l4iETRcVqJJG2T/+unozt1Nwp9OlJrbAJEgQtPj4wy8iIKvHg77L4MgEIu/8dCdijp5WMMbnYXh3c3MJ1gH/EdJhtg08loSWLnh9ACJV8/0bpQCn9ZX8VSRYrAY5gjHnxGif7IJPrYpBc5DMfMmIeRdPpFytuhrd0c8PbDjG48qZO348C/BHtBAGn6NPfl2+sKu18vpWTz+7nQys/DEctH5t+vae5HaqSzxqTO/yIYVAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by DM4PR11MB7398.namprd11.prod.outlook.com (2603:10b6:8:102::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 13:50:36 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1%5]) with mapi id 15.20.9723.016; Mon, 16 Mar 2026
 13:50:36 +0000
Date: Mon, 16 Mar 2026 13:50:30 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v20 10/25] net/pcap: add datapath debug logging
Message-ID: <abgKpmV0Noy1Agkk@bricha3-mobl1.ger.corp.intel.com>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
 <20260310161356.194553-11-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260310161356.194553-11-stephen@networkplumber.org>
X-ClientProxiedBy: DU2PR04CA0218.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::13) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|DM4PR11MB7398:EE_
X-MS-Office365-Filtering-Correlation-Id: e7caee78-8fd5-45db-5c17-08de83630009
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Ghdw/vui7ju3oXoGhoPZZr70RLDKdIRCQ+2BMLSpagm+rKVUScwbQV5J9/Dqy+0mRvG0aeBKe6SSMN8sZPpKxIcmqxmkePHk7MVU11yTCGJaANY4YJOhG/U0aUS3tP2cZuijxuKO/AEaujhuLFiTTqb2AuGZ6R3z17oMDIsZDCkfNx3QPfFyVJs+lliEDPiQzs5zNeliJeErMqpF6f0W3txo7dTX+Uo0ZNs5qeur8OdcZALtttwQe4O4Kvzx03zOygtDaJC0IR1gqKzfSIFUKygMIYdjZtb878sNumI7qkw/LRzM0LsjlPht6rZX+hLOTLWKqMxhk2tPz+VEEzFzCKO033VwP9kqAv7BE6lnOEGJfN+q2BwxqLxwVqxFyTeat7qiFcLzGWSGkGcla0Csxojgf3S9JsOmGx5iqY5xmzZCobi1u3uZgKiuk8h8RJ42pTbR/I8M+ugQlqjJE/bQDEcpXg96Wixz6wWrYeXvX+aFZNxDDy5VzkF1JSMdZnK0Qh62ZUgHM5s8J0hC35a2tDiKpkRWvJ7Hnn8SW2j8dadYKb+gGoGYHXa0cz2IR6MYwV/tH8NK/8LlBQIMC3efeIgURh1IqSJcdWHy3yDlhJMLxFfiiMJ78XU5Soq9HtJE/h9BuSBdHvXWDM12UcIxNbCfQB/6SQmstoqEn7Jv4il0Op+xTcGlIqQFhEcNGOYhr42Szu3gCTgTUENSqujKEjY7inD/C1DoZqOPp3NSsus=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Sgkx4NexNz6/oW456IDAsB6ytiwBsd02X5hp07Kd0G+W+urYpjPod/2zb4a/?=
 =?us-ascii?Q?S8W10cdW8c7Eo4GNtLKP6r9Lna5rqi6WBCOhdhD9zlQrj8Oy8AkyYLBD3/Ne?=
 =?us-ascii?Q?GzEpOCaj655bp1KoNa7XDfkfeb1zlY6kQKG1vqRMbJ63JTd4lR2wfgTTzlzw?=
 =?us-ascii?Q?pKeSpEkEes31Xn4pFWipXib1LQ2LsBd0SyxxgSQ/5CKC6ZyqX+FrKP9NJmIm?=
 =?us-ascii?Q?teFIlUUnB9YYcCuCZsXptkOFDwAKbmeygHC38zmMPQmqF11kwAMLjIxDu6Ex?=
 =?us-ascii?Q?VQ9FgPGCZNa1pSs6eCLWDJS1ICcDcb6m/wIMxQjavR8EE22wZqYh2ED5/Dgq?=
 =?us-ascii?Q?ZIcb8AcFfgDaH47UpKvlMPEAJ9r6TOvq9zu451R41WqfKSvuPfBjO8UydxJk?=
 =?us-ascii?Q?g6Z/j8zv3XhzQJZzDxQH5Rrp0RWP2jj2GrhewcqQxTMz+Pa8CNiTMmuyD7xI?=
 =?us-ascii?Q?CLmezTIrIzK+uPpDZy586lb1ebK8dapiX8Cfdd/NAB1XM6z29BXsVea1imdq?=
 =?us-ascii?Q?oVp3TCmfFMCBzEu+L/Hq8tt9x87H9OUJr76ajzXNxhbnpAjZnAwzesrP2lPR?=
 =?us-ascii?Q?cLQCSyHjoha5vNrKXFmzmL2t52SlaQZSlK1xh1dayJpniYgUvXJC1bQ5Q2wr?=
 =?us-ascii?Q?CKCyzx+T3bS6KOSY86nyBrz6W/VXMOQ6Miw7OoU/hOw6XA4ZREgHCHgvvM8j?=
 =?us-ascii?Q?ORKJA2Ox5telX8XN6wUVyvnlWKPDGAtsCkFu0dMvC6OgBvFuKWMvWgPHqfSf?=
 =?us-ascii?Q?iMP0d8AJwnomGX4FXk2xFDyApq5w/FR4c7a+2pd1kAi4SIF+ENbUQmW0WG8O?=
 =?us-ascii?Q?iFBZ+sBo3IHKfyA4JuSHcSjmcAH/B8l8NXLgg40+KcY1ZdH5WyHME3GDtBKS?=
 =?us-ascii?Q?ESN0k8x18PtJTRVeBZgJL7TcTzMjpQzVrfbwstH7AnxIEBVzWOKppPPuhTD1?=
 =?us-ascii?Q?2pG7AkN6WGLH7LER914neaauckgoApZXZTaF02y1s8HQJMZF7vzNM6oLHIJG?=
 =?us-ascii?Q?R2mDiyq3aUxrsdENd/xtJpX+oAOOee9Jbj3BWwhZthYZddyyDs+LsOAzKDl1?=
 =?us-ascii?Q?gCiXtrqEoF7PpaTgu5XfssrZfJLyVzY24L9a5mJU3ZnFGUkjZJFdwFrRcYdM?=
 =?us-ascii?Q?AOXwWWR/n06M6qlPxCsZp99zKewws5WprWUDjUeXc1JzmS530NFhKyxMy4b/?=
 =?us-ascii?Q?kT9Z+pFk4jV3ObLEONW/y718C6oaEGDO+SXlMdDePmUvQEMVoUojQm5pfZxO?=
 =?us-ascii?Q?kgvzF5bImuKgwhtS4DTUjb4HP7Tw3z0yIpd2FO96+nkQjvK/gQ8kSUtni8Wo?=
 =?us-ascii?Q?BwN12/snXU9w8BTPUFyrb7oMBdvk2yPybnvTu7tN2fnu2LK+AgtCjDVL2DCn?=
 =?us-ascii?Q?is9o5P6CukwVUm0VdOspIuaOf2Z8rkdAzHMeQqnd3UWKg86dw1P6X9lBGDDa?=
 =?us-ascii?Q?ubJ9I6DjJDATPjde2qGinyiFO8/Y+zvzLqs4rtGqAxWndL9cLefeo8qQvM+Y?=
 =?us-ascii?Q?WdETJgeSY3nTb9cY5MsSf9jDKsH5hzE8GVupKvSl7PCMdnqZfNZqjW9jxBAr?=
 =?us-ascii?Q?zKxkijZ8o5iCqeMyHMNRWPm1zeVXE863nXyGy4KdgfYGH0Pm59BziTyK4gvE?=
 =?us-ascii?Q?kgtlHqxcMU7zKbo/lSE+QLGjOnYP9apx6XJMcFnGxB+6TWRqWFm2/H7DjKa7?=
 =?us-ascii?Q?K5TcZQve0WEnFo91l68RX3I5EbIlhO3mOx5FhOf9uIchXxn95hYfuc2cyeQ8?=
 =?us-ascii?Q?zaUD/72rKjAQntyJlB/gvZdR5C/VxoI=3D?=
X-Exchange-RoutingPolicyChecked: ohI4k5X3o2iz1NmhvAe0HVfYhcEZ5XbB9Ul0xOTJ3WE81imD0cVVMRCz2RQzdBRW4ToVEFzPblxAN3nXkvuPZYIAlxeV4vBaJxUJ6IakP2/Lj5dHeOZcPNqdyX6cu2ptRVJpWOmf1oX1twcSdvU2SjOUkbItcw1XNBmQPVgdazvBlETAvrP7K1jDbvscUFuUeTPnRil04YcTpSsmdUHCihLVG5hLljR9caJ8Ovq+ZsaMJ4XmH3vYWeqjzt2ptF5QLO+8OvYV2zHhWU5rtMsCkYeQuuIL4choA4WKQSqr3mOzOLH06Rcaw46AQtD+Ut6iAj/R2Ou1MybPDiQ1yU4xdA==
X-MS-Exchange-CrossTenant-Network-Message-Id: e7caee78-8fd5-45db-5c17-08de83630009
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 13:50:36.0273 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e5hJraa8uqtGolYGSPDMx84scCZsIFNL6k8p2EFj0t0AyyfwLhwDU0XOK2X7GAF88cH5V0GYfw6HPpOetVvg2atNJmuBKhNKVqD/i375eww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7398
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

On Tue, Mar 10, 2026 at 09:09:48AM -0700, Stephen Hemminger wrote:
> Add datapath debug logging macros (PMD_RX_LOG, PMD_TX_LOG) gated
> on RTE_ETHDEV_DEBUG_RX/TX. Use PMD_TX_LOG in transmit error paths
> to aid debugging without impacting normal datapath performance.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
