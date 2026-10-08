Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48CFCA6007
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 14:53:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 967C040294;
	Thu,  8 Oct 2026 16:53:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id DC41B40284
 for <dev@dpdk.org>; Thu,  8 Oct 2026 16:53:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791471213; x=1823007213;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=R2XX7EJjkGURQvTJ4FlUj+vlw/T3wbgWdcd3+msH5Uw=;
 b=OMkCcMlsp60ipeXhXKAG7nseBG12rBihHkGjqIcvs8hoXtic6DZ66LCG
 RrMwo962gyPsAbdTeB6SQCUVYM2m6JNcj7vax9EggGRJbZZjTL4eTkW4t
 EkeGVSY8m2YVz0OgQHii9AWBjRjDX2VXeCFZ5UyfDK8LQHoRxoMUNlpoA
 2ObZBWUzyyNq65LyFFplKKGh3YQcFHTiWBznkmjlC5IolH8QVuZa/8koG
 lUWth5cTEIBUIFP7km3mcdI55b9H59P+Y0R/tLGzs1OxwIVcERLpq/ihC
 WYpAczHGDwqzBhzaj8S8UoZe3N8rX/2w18yhVzSXE64JlHfbsHa473q4a w==;
X-CSE-ConnectionGUID: KgvLM5g5Sd6HRc8dYo2lWg==
X-CSE-MsgGUID: 991GUEbaQPmv6YqJfj2WyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="253644"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="253644"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 07:53:32 -0700
X-CSE-ConnectionGUID: GTS079eiRkiFnA691AhP3w==
X-CSE-MsgGUID: cofl5cBwScutcgmemlvVJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="17650"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 07:53:31 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 07:53:31 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 07:53:31 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.41) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 07:53:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=veUNtGwqGINjIEJUvGF8EskCH5tfQud9kTbFthzA6YW2OPr//RFwrl2EnJpkBjBTQ+UUoxPdhwcnB84fBUXxtQy3p9y/2FZV+oMi2eshDZ3QTP8ijvUxgX9qFJp9kVdfrwy9LVJsQnHd99BL0B2jSTi9GlnfrXB53IVIwVPbLgjND7V2+nVBVNV7KQ5tG08ufTzFgx4cppK+hmVIwuKf6R7TQGQnZab3oY9bi3CMO1TYM3VrPWY7L+9TpdAeUvLDAxQoLJG83j/mU9vNojeIZFEPSh6hECNX+wuD2K+uxj+75tKkvMQ72cPzs3AkKL5fv+rndHaIJxYNI8vNJFXaZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzOkA1oLvGLtxvK5gxoplBsQnXNT0DL6nPMfsphVEM0=;
 b=RSWX7GyIQc7n/D8kJjVdulS7DdW4Mb9SErk8ps7EdM5xTgy0liJhFJsNaxMsXmesA4K3x6Zn3WqttxWT1InOqe1UbMTB2PoF37cHw1gq/nLdao7mserNf6rDqc2Y1lCHZU+7olDEbwptG6qmYKHrqjeZYvTwfD5vQUFi6ovXFBz3bf1n72eKXX6Y4bY++XzE0p1AdIGAe2nhlbznnduvDIZ5hcl+HtaPioE1KOYl6+mN3r9cNLFzWc5423KGmRlDzdMUXMjTIVuMrDZjTcxrnO1gTh39Bp457u6AEuR8NKgWD1bnR6tWaUzPXPHV1kXHYOe0jDsBgn1bobRs/rqrEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 8 Oct
 2026 14:53:25 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 14:53:25 +0000
Date: Thu, 8 Oct 2026 15:53:19 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, Robin Jarry <rjarry@redhat.com>
Subject: Re: [PATCH] usertools/devbind: cleanup device type declarations
Message-ID: <aseuX3zaIKN5eAOC@bricha3-mobl1.ger.corp.intel.com>
References: <20261008144313.2000554-1-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261008144313.2000554-1-david.marchand@redhat.com>
X-ClientProxiedBy: DUZP191CA0034.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::11) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|PH7PR11MB6605:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f800733-cf0d-470e-1f90-08df254be79c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|6133799003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: kJyNy6DFFJf/KvyyBWHtY8yLdmBEaTjGPxdKeUddafDaZhzvoCM4VvSZ5YwXu+vU0cRyxn3xbOh0ozEbqlFM7iVVhigyyfaVq0pvELkIRya/kUugY2cFvHAHMFL2eHlFgpcUrjrEyOZylcBytfYXyuT//sO8mWYEOxSFHwOVGcrYZ8VynFGef4fm0wDnOuJ2CBXvyrlaaQOhKXU/pYpod5xiLVfYTxDJKTj2i8lpXi8fBkqTSXnHj3IrqknkGXiNCnb1QnU0iwoNqbADGddsbEf/IODTuKv2ZUO6kdUa1HPZ1xfPm8ZYlTPRF3qilE9i820OWwonxIGrS/evz4ZXAWCaBNTlC29+nmAdEnwAETauvIqnXY1OD/Zi1msMiDDIebqWQJJnqFi1INyrAcBRwEEtu9PdWVZ4ua7UUqYxZ6ISiqa8J8pm0qrZ+vjj3xktmERV/DBd+n258ExQOWSuO3t5+klL50S8vEMKumOLOLsmBtdl+WZTvzT0voJKJ1iLf4/6B2lNaBeZDambEJZA0wFvb8zhYjda4pdTyP5obVhhJvXPz8HAMnLy7Zj5/Slarug1V13vQrV8CtcnySUmovqrderzprE8KpscFFbZpAHF9qBdlTm9zXHXWN3WSoN43KwgrXso6ulul4wwINqh2pnpRj10eomwF0PPTRfmK9E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ftPtLnGGtjZ6nv5uTUiqbDQ6pz4anjdqJ23VF4m9h627yUXjzBBbD2p7/hYp?=
 =?us-ascii?Q?I/SJUnucISq68xSR46Vh5Tt5lTfwqwof+z6CbS/ozVv3CJzvZa5/T20c06Ks?=
 =?us-ascii?Q?fWnMT0p3oc8440DQd8GJbRf8yIz6/FgkdW4QR7C9m5E3p4PDhUo802sUPuBx?=
 =?us-ascii?Q?mlIf91Q5WVxw/U3lHG5ZiZUNB1LUtSn/lcwKZ2qJJvlThRftEg0ASFLrtCL/?=
 =?us-ascii?Q?cUyjsBByASl08Bn7BTqYmSxCK8HM9eUYytuq0paAAo4wVca7vesD6q67Rqvm?=
 =?us-ascii?Q?MezPstpO5UTxyfu8z3cr3hj+/ANVmt3YmTyyF7rbaAtnxPuSaqrprDKYl6/w?=
 =?us-ascii?Q?9zM2Fv5vwDEbBBQv9u9Hc1zR4k6nAYiX7CWOxJVy49+gpRfs8zXVhoOG3Nn3?=
 =?us-ascii?Q?xl04mBGKi5Saw0iKnnCLPobdeHI+uzuG7Ot88gD0J58pwcW+Se4F61HESv+y?=
 =?us-ascii?Q?el583XjOEIxsacwB7PpzZUx4uJWXMJgDRs3QaWFXCMydijfHSqrpd+p6Jm5e?=
 =?us-ascii?Q?27Wl/97wpyq+jbVxsAxrkDPEUXtOWxozvsikuoA9nYZFZwzV+FugRrtOkUCy?=
 =?us-ascii?Q?IjpGrZI2eQEAA3IwHHp2ERXG/FK7FaxaafLJASpBDzvdhs+2iY/TV6a3OM1R?=
 =?us-ascii?Q?+6gLm4px98iYHadL44abZWeWaknzTi6RLv21tDgkBm5rAhWcpSpPgrbc+9/w?=
 =?us-ascii?Q?W2Z2iKpiqaDGltMmPFyVUsO5vNGzwYQD7juI3gaOZJxxwjCvaeYVudZA7IQ/?=
 =?us-ascii?Q?s+UdysOtDHs/RdUL/TBjsttDYbNZzyd0ogJL4nZVcXc9aKjjY8bi9k5xoXid?=
 =?us-ascii?Q?dpXqna5RS/2/Ec8r0FuyFothI70sI01+UwWo3gkvj/5imQTkvLOvYQRtnG3W?=
 =?us-ascii?Q?OlOAb2rBrvtpqjeY6QzNX3DGX3hYnAzfu+nBwiFDERAbOUYrIkvNw05XOj/b?=
 =?us-ascii?Q?E7wAqsLEyeY5jZVwTjv+4eDqHZQZOcCB6IQEQ1yasSAdm0adxm+2vTMkyBN0?=
 =?us-ascii?Q?4vkH2gc0roOp5k2QAKoWf+0982/fT1Y7FQoQyLLXm89ybBq5Mfl+FxyMfEs0?=
 =?us-ascii?Q?MW4kqBJb3HZXgxsjGBJMPBcPJbqEde67pytlbWOFgyPGxVQDoUrpv8w+L8X0?=
 =?us-ascii?Q?hLNsiApcNzg61kRtNjVtu7f9aJ94sehJ/ryOvURgEaAT1xM3LiMiAX3/1n1Q?=
 =?us-ascii?Q?12dQen0MVRlR+9DFV40RHW9F4ItC2j5ixVZTEUugKfX16MBoOIUDGYcz3wMR?=
 =?us-ascii?Q?12aBHw5tN3vurgvf9XHvOOZdCUI02DlplF990yQUjfmPt6Gun9pWmpyTT186?=
 =?us-ascii?Q?IhMRbPVRj+//TKb/Ux7GRx09f9ZZ1cNH3McW1uETQm9DT5nDmmYNayY4DHv1?=
 =?us-ascii?Q?bIOW37m+nRdSx84WZrGyu4BBr2szlxCPa26N0htU5CFuXT4Ab0hCC6kLugW5?=
 =?us-ascii?Q?QTvqoKi0318nfCqXmR6uKVq9q7nxXP8Jr9kmLYGDei036qsbwYMrNd1qPYJW?=
 =?us-ascii?Q?tVZCEkr8w3ib6LOUkPRYocGi0k4IDXKCp6TqcuO+lSRtZC7TGgTaClsN3QOh?=
 =?us-ascii?Q?h+Co0yfBp5/KzKHFYNCgBHQla1Z2Q79BjFuuNPR5I6IeEjRvLuq8Q8jMVu3X?=
 =?us-ascii?Q?NEN7aLS2LMjY13RwZxPo5cj3FGL41VtAUNZ5a/WoJJJb6iUlI7PAb6McLkWp?=
 =?us-ascii?Q?fCXIU6DQEKngN8qmOjDuoBlGjQIPQDnF4qlSBrsoa7jwGscoz1lu1YSIBAqO?=
 =?us-ascii?Q?Qm9obVUqXLRXGSHAHncHk9yZdDHDQQ8=3D?=
X-Exchange-RoutingPolicyChecked: Sb5Ajhb/HxjQwMe0Sx+Mqm6T2wgIKyYqEK0kug7NQPA/beQww+cjwi755sjoBy2dW4ys8FSEMV/nhE5csPuLpd7QFse7dHE3PZUbYRIgDleCnrco7Yo42ohmRcPVBXWPTvxKgdkCNYySxt8o9g0x/yk5psbHYJOzn8MfdDfFBY+TK7PF5AqBz+dLNBy8v9NGhCYjL9wIiYrXBkP//87itWrUwi2X+ScDlKUvhbn+J+zz5EQEj2j3lWO/fCSnZJMIo36bmb66QMAXgJA4DU09VAuxDWI8fmVz6pSIZcVSK023PGCOAEyS55NbO35A1Oz9/uC9FHAjJ7YvSAUKgR1T0w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f800733-cf0d-470e-1f90-08df254be79c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 14:53:25.0159 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YJQqb/AJoQcx3RFMa3DJEfhf/lrYwHWHfwLn0F1wdYhXvQv3YP5DLMvoIYcYvT3m7bSumZpy33HZMjoKs6ZoCtFwNReqSUZxAAEDXnUnxEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6605
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

On Thu, Oct 08, 2026 at 04:43:13PM +0200, David Marchand wrote:
> Adding more device types has resulted in a nice chaotic order over time.
> Introduce a single dictionary and group by types (keeping the original
> order).
> Sort match entries by class/vendor/device values.
> 
> The Sub Vendor and Sub Device fields are never populated, just drop
> them.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  usertools/dpdk-devbind.py | 247 ++++++++++++++++----------------------
>  1 file changed, 105 insertions(+), 142 deletions(-)
> 

Good idea, thanks for the cleanup.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

