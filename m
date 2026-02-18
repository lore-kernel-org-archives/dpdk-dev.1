Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D86E9A03B
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 10:08:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B87B40395;
	Wed, 18 Feb 2026 11:08:58 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id B5A46402A3
 for <dev@dpdk.org>; Wed, 18 Feb 2026 11:08:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771409337; x=1802945337;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=7oMqkUxXWjy1fv23m+o8fg56YE4SOLqlCGJVeUfB5Jc=;
 b=GuWTczzBrbqOPJwU7zx2IwiUrwE9wJada56l36JH47lF7SN+lNj3tkIR
 5TnH/4zHg2COxKXWMnGIds4SyjP+NEyLF2GvUAmv3kwzdVhTQhW83wxS4
 kaPtWvFO8CwUAoOU3kh9dZUhjJtfbS06JeVYNkpy17F/F5maEsLVwQ//6
 L3VtQ6c9orfFqtQylrkvy37YrFCAotjx/KSyXSMJNr/T8S6TY5F/7awuo
 vS+ahN8fCyRvlGXyzsKMWnA+PnFV65Fke7jqSZOjEgPak+tOkToFlAzvc
 VWCXHydmnDaCwKTgfkGEMFCAmYa0XgD3l3pf6gQ7D3tCSu2t6jC1fdC30 g==;
X-CSE-ConnectionGUID: bR+nm4h4T6W8qb9kcFSn5g==
X-CSE-MsgGUID: pJFkmp+UTuGRvYelFG8zYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="60052260"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="60052260"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 02:08:56 -0800
X-CSE-ConnectionGUID: uPN6x7DQRsmyYTWtatzFDA==
X-CSE-MsgGUID: xR/HnPsmTzCwJUASDWceAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="214006169"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 02:08:56 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 02:08:55 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 18 Feb 2026 02:08:55 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.35) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 02:08:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i1npk+U6S30t47y8edma05ogvreRapK/NcgKb2azWhTr5HY3O6pkxbfpmrFk+0sMAY+X74u/rKAnxu1wEyXdjmeHraA25iqG6bXXo5EyrDFIB2jGcvlOxqcg8zB0P62y7KA0jtc9OtXoDlVT9lLZFFcUoMYBy0EX4QB+6ott3xSaZxFJoP+y0BA+4YRrarJMJIAuZKfd6m6HtXL1aR7XkOlB7jl0FQXfhlLYlilc5cLC8thuJ0vPK7z+QMNzQlGiAI9XlFD+UOABV84hpG22msuwhhAXTP/9Un++wKV6oHwVBHqcJDZKw7/r/cYtcHblM69qTg5OlJPezLRBijUvhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GN4stI4ZUifeFYtPMUm0zWAP2Mb7kvLnR4bCMBHqMNs=;
 b=EtooJybfJyEVoD1g6YWQ9l3m5npS0VJrnf+pH/KF2HXH512xJ+V9a320wSOuwOecPCiXbrj8yu9vpLybT4NqiUoB3DF5RGUoP0V4/PCAC5ewPPgmTp4dkaYJ94YvgADlWGg6yUsqJXDBObQ/48/7VqzgxhmXOlnjSvtND7XjO15br4GzHno18xj6KVR1KVabb2PnYFMbnCaHbnwknFZbWjY8pXKF+4f5vcBB/kOXPqh63nGCW94qMEwGgs9D7qcjRKTQZZCVZ+g0um/YhXr4ypKHlkj9yIJLI7c1fOvB9Dwf0Tnxe5/BfIsivwuHgUx0/KE4kXL2ivAiB/4Dh25MUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB5818.namprd11.prod.outlook.com (2603:10b6:510:132::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 18 Feb
 2026 10:08:53 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 10:08:53 +0000
Date: Wed, 18 Feb 2026 10:08:49 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 09/10] net/idpf: permit secondary process Tx path
 selection
Message-ID: <aZWPseNhRyRP0Yc3@bricha3-mobl1.ger.corp.intel.com>
References: <20260205124627.371733-1-ciara.loftus@intel.com>
 <20260218094937.1652391-1-ciara.loftus@intel.com>
 <20260218094937.1652391-10-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260218094937.1652391-10-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZPR01CA0212.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB5818:EE_
X-MS-Office365-Filtering-Correlation-Id: 81d85a9d-4ab8-4703-59f5-08de6ed5b84f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TYxLtgR8G3O3TkAWacet5UXiog09CtKiB/IqnzTsk90mlOs5rK11N7tNWx6l?=
 =?us-ascii?Q?wiDke5pxPcJ3rL19XbTgKNCRYesEoGVOwtEivo1KcblsPgMcjedKEUEDG9z1?=
 =?us-ascii?Q?ndgUAQTcB2CFFONI9IyfNqucUwQebOOlvgetc0sUPmqyNdO/YpsX2cL5WjUx?=
 =?us-ascii?Q?Wdh4lSWSWlHLf1czVUBmMuu3CHMBHSha4Ud0FDS6I7s7kvwkw/BYEaVGa99s?=
 =?us-ascii?Q?Vu/ySYxXjLcSAay1ZxI4uZRnd2L/6GWOkjDml7f1WS2sdn8bdLcP5R1ayz+b?=
 =?us-ascii?Q?D4RxB5HvzzLhiJJSrPlPt0wJNiXV/oI2fOO/4V0mPmPgRlz6QvBTB6EM6eQe?=
 =?us-ascii?Q?4xJ1Ii/GYQ/7r4MczzGdOnNzIPe2/wG18W+ZpJmKDe5Uka4SB6dq0zPEhirZ?=
 =?us-ascii?Q?R1aVVdqzLoS51X+NF0Ql6nQqs2C62MJaEFfRvv9sZRG6L3PeTQWa1cx7bD8f?=
 =?us-ascii?Q?5CkdpXBBOK4r1Sil76fj7w+cMliMP7shdOCxI58AzXJr8lKjJtAOLeM+HBLz?=
 =?us-ascii?Q?ZSlwRXtEGp1jDLQVcpHrRi88jMJdyLeDrIbS92ZSHeu9bCWtw3HGdQNbtQ57?=
 =?us-ascii?Q?uFcZgpmeOrva12I6bfuPZ1xS1keAhzKtEe60Is4peAI+WmQtHtJimz71yans?=
 =?us-ascii?Q?Fq8q7islFDQ/mfPO06zKjFUrUNMkuUmugfnWADAPgeb+pfhwO1Ucxf/f2hhC?=
 =?us-ascii?Q?YoI2D3mB0D9IZ+Z3Heti4tP05a7CCuRkqiuPUvnnb5CRUcaB4cyryca0p1am?=
 =?us-ascii?Q?A8Dpx7jHGRGw8gWSLRx+ZMBo8gMNT56jJqkujSd4stusYhUVJUYrZKMtnA9u?=
 =?us-ascii?Q?Ry1RSdgtJVzCpLFGiS6iE5t/yj0UlWiHBE+JPLuQnZ5YzZoHFWIhSAzJxOgW?=
 =?us-ascii?Q?cE1A+O12EcDaraIXlUOvFH6jHe6z78+kdZqnRwIfjjCsh7F4M4a5CzNWeg/u?=
 =?us-ascii?Q?MbS5tSmoixAeYEis+8Tj1GxQnxjj15pzr8QSh+gfu06AMwNmQ+FGKKcoaq6M?=
 =?us-ascii?Q?CViO+9VIdcCMoGUOkA0XTR4ba44PHZaGVjI7CYX59a+097zxtVAxS1yBWHKl?=
 =?us-ascii?Q?WhQvCYe9AYdAEoUxPpBPPc0B0v8ctmBWO8AqjLg5Khlev/9UuC/LHa1IRFzo?=
 =?us-ascii?Q?EqNjttQ3no8ebElGW/XZ5NySxnJI9z4dprpIQ4e427bg+ahdp14lHlp9LF55?=
 =?us-ascii?Q?3cTHixnx7xxQeYgghDX6yVHvGuqHnXjS0p0+ZtRSc0Rn75nQPJUmzu64+u+j?=
 =?us-ascii?Q?yZk5XLWMNBg5PpNyGAJovpw+98mIspImvWXaYk+GsmYlhIij0X9HE67wCFMZ?=
 =?us-ascii?Q?0D116Pwp1+ZlMWz4h3No58QENxCI0ZvNvUotD+2HD8Io5VT0ACJL/F0pfzUh?=
 =?us-ascii?Q?Q2APaEOyldBS2vW6lEuBH87cNxQTrFpsY0x4Q3IrWiqehbZh/Yx0X7iWRuAv?=
 =?us-ascii?Q?4dxlLXO0UK6SHEJOcDhUWVuYZUtMgi1sviFPZSAEG6xSmTHmzRk4bjL6GcTc?=
 =?us-ascii?Q?QcFeYGzLYqFhvgzTO1ZNENr9825kHhqir+213hYN7NVsUtOEmmfjNew6g9fP?=
 =?us-ascii?Q?7jdezyMh847g1e25kxA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8Wb8IRmjFySKIxuFJ5D8g1sTvNzY7AQE+j25ogyv4rWWonBP3a9ow4fedlTa?=
 =?us-ascii?Q?GvQryqTHCInmdTZr9ZhVB3ssiPDIZp2SYcke+BVkrElxHIcIbM+8EckDS5cY?=
 =?us-ascii?Q?+mXb3Yw7p/tHwa0W3C/ReYp94sXaHRfFWUfqutBpbwxQfM4Hg+Rx6U+0kjam?=
 =?us-ascii?Q?p06VF/TNZ6VXZVLREoqqQWcwWGDJwyIw2NntzKOTEkqmZ8xGK5SpdUZyRNOM?=
 =?us-ascii?Q?M7ImxIexyv2dpNfXOhmXTRYIh4mexQ1r+YYzMpXRpBXJwgUfpdq4lwx8XySZ?=
 =?us-ascii?Q?tnwtYQfgpAlsuIkEq6QBP0uPnOqkVpyx8I4MqWXDycTktkypGOcyWV0q84+5?=
 =?us-ascii?Q?Gep1fYqYPveW2RQAZ48r82kiR694Wvriea7gq65p3vVd0uO8pypFI/sthlFq?=
 =?us-ascii?Q?2kjQa8nU6oKLvkIcxxx5e6kJLXDaBumbpghM5ajU/aNWZGC7pfYh9T3sLrE+?=
 =?us-ascii?Q?7Ynkp6uBmrCyPsrxSDKu3/4nySqIZcKz7w8HUlkvQEeF/VkULwQErjVDJ0LS?=
 =?us-ascii?Q?P+U01vhovUBtA2mMOMyrspM0+k/UwzG9eqN7gnikkFOUPPVE1epnXK9x+Bwc?=
 =?us-ascii?Q?cAQv1mmUZxwo3OJBgcbmHP9xwWpdstcTXw4k6ZiHUh3RtvgpY906qAqFfwsl?=
 =?us-ascii?Q?4srYBTaf4G/XVcRKHd1ZrGvjdEhfGqG2EPmdiEvg3p9Z7uSy3zKPJ6XYXYwt?=
 =?us-ascii?Q?B32egsPTciQHK27BkUF3r4PLjUH2B1D0yHvMAYWDBclZnWbqPfmffUy2HgTJ?=
 =?us-ascii?Q?nsufCHXjkrHuq7hwJg72rqEVy7zP8+y2ueJnD2ouXtbXLDraDugkNEySOlL8?=
 =?us-ascii?Q?6M2nD5vgUGfz4t6QJNvhOS+G6DWE28n9BZ40YTN3Q/0nW9aNxLHu2ZL3nTkf?=
 =?us-ascii?Q?76iGkY3JkKaPZpO9djSveLwdhKEIpynedqBkqszqfteyXEzK6F18Bk2feqin?=
 =?us-ascii?Q?VSdVMryVuUfZS2ZnfrH8gZ1hheQo4C8seGNtuyFmc3xBnxDhBALBMuu84qhc?=
 =?us-ascii?Q?fU13JuRpS3Hx7VtYnXYt5a/0SR/3musBhUcnnH2J2iNpqAqxqLCXW+17soX2?=
 =?us-ascii?Q?N5wAOb83xENfxlzpZRLQ8nskpXgCV0DxcU2s8RQaNWY1ICT0gai0tnG/LNhE?=
 =?us-ascii?Q?b6ZSO5IirdJoprVvvjgo7d8wDgggYKjvxt5/KzpMho5DyOsV0oZ9jxthL01w?=
 =?us-ascii?Q?vOUfJnCJA28jtGgPiVg36r8FhRHOOiH3hXwVqlO9+0/th0PKD2W7+bI7ADXg?=
 =?us-ascii?Q?bpZny+HtKjGZmguGcThIjvXzdDv3aoqnOqV9qxO+SIUZOkaazYLEDwi+zkq8?=
 =?us-ascii?Q?Hm0SyCrHmxrVJQlCYCGvLU18w9KMcff8JJlfNiSAsttWbqDF/I+CGDOuZLGW?=
 =?us-ascii?Q?DmCzUpVGN8o73rbT9dI3zX0wRZOPuk9yvfk/aHPN5N1nHy7dhHsrtqKAhU58?=
 =?us-ascii?Q?ZR7gAmEVhqU9hIXGGZrFXeEvFwcvSzVFzkMbMHEKkmyNI07JZhmJcG4CA/Gp?=
 =?us-ascii?Q?DfXHIW6b4pfSvxkx4xqC+B8WkNe+p8673CKQrfcohlHXR7kvSq9Oz4Ha6OyV?=
 =?us-ascii?Q?QzfRO2S76RE6g7s/MVl5REqoEAXBBiKKhj2ciJM6dbeU3Hhq/wT/wydKszGg?=
 =?us-ascii?Q?S2+6EDFygeGe20aZzr9HQ6UVVi1XdkvJUGx0XA64l8+8S95tGNH+8lSOxGF5?=
 =?us-ascii?Q?VqgFctrxNXuJCDPlmGmWah0m8bHQCfWbDG/4WC502jx7Pb9XJOgXT3+hzahJ?=
 =?us-ascii?Q?yhTG05B9p0SGLLo3Z6KlsKbVzYjCwcY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d85a9d-4ab8-4703-59f5-08de6ed5b84f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 10:08:53.3361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lVzRMK0D6HP+KbdOLQey0sTz6eqBzq7WRIUmh/R0IpJnNlAm60vIvlcUi9vIHmZICGaRJdzJg38tcZn23xaTntPlTIc77+on5zL5Bfhrzqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5818
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

On Wed, Feb 18, 2026 at 09:49:36AM +0000, Ciara Loftus wrote:
> Commit 7cab7e67363a ("net/idpf: use common Tx path selection
> infrastructure") changed the way that secondary processes selected their
> Tx burst function. Instead of letting secondary processes select their
> own function, they now used the function selected by the primary
> process. However, the primary process only selects the function at
> device start, so if the primary process hadn't started the device by the
> time the secondary process was selecting its Tx burst function, the
> secondary process would not select the correct function.
> 
> This commit addresses this issue by allowing the secondary process to
> select the path if the device has not been started yet.
> 
> Fixes: 7cab7e67363a ("net/idpf: use common Tx path selection infrastructure")
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
