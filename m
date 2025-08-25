Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57823CA0FE1
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 10:54:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3AC284025A;
	Mon, 25 Aug 2025 12:54:05 +0200 (CEST)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mails.dpdk.org (Postfix) with ESMTP id 42D6E40151
 for <dev@dpdk.org>; Mon, 25 Aug 2025 12:54:03 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.162.112])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4c9SJT3lZvz2VRXn;
 Mon, 25 Aug 2025 18:51:05 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 11458140203;
 Mon, 25 Aug 2025 18:54:01 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 25 Aug 2025 18:54:00 +0800
Message-ID: <63b03620-8893-4336-a85d-e5c6883e994b@huawei.com>
Date: Mon, 25 Aug 2025 18:54:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/43] eal: add BSD version of queue.h
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
CC: Tyler Retzlaff <roretzla@linux.microsoft.com>, Jerin Jacob
 <jerinj@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>, Bruce Richardson <bruce.richardson@intel.com>,
 Harman Kalra <hkalra@marvell.com>, Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20250825034126.12046-1-stephen@networkplumber.org>
 <20250825034126.12046-3-stephen@networkplumber.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20250825034126.12046-3-stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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

On 8/25/2025 11:38 AM, Stephen Hemminger wrote:
> The version of sys/queue.h on Linux from glibc was derived
> from an older version of BSD and is missing several key macros
> such as LIST_FOREACH_SAFE. This leads to drivers re-implementing
> the macros (sometimes badly) and other bugs.
> Introduce a version of queue.h derived from the current FreeBSD.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

...

> 
> diff --git a/doc/guides/contributing/coding_style.rst b/doc/guides/contributing/coding_style.rst
> index 243a3c2959..097042dd22 100644
> --- a/doc/guides/contributing/coding_style.rst
> +++ b/doc/guides/contributing/coding_style.rst
> @@ -324,12 +324,12 @@ Structure Declarations
>  Queues
>  ~~~~~~
>  
> -Use queue(3) macros rather than rolling your own lists, whenever possible.
> +Use queue(3) macros defined in <rte_queue.h> rather than rolling your own lists.

rte_queue.h -> rte_bsd_queue.h

>  Thus, the previous example would be better written:
>  
>  .. code-block:: c
>  
> - #include <sys/queue.h>
> + #include <rte_queue.h>

rte_queue.h -> rte_bsd_queue.h

>  
>   struct foo {
>           LIST_ENTRY(foo) link;      /* Use queue macros for foo lists. */
> diff --git a/doc/guides/rel_notes/release_25_11.rst b/doc/guides/rel_notes/release_25_11.rst
> index ccad6d89ff..586a3cff28 100644
> --- a/doc/guides/rel_notes/release_25_11.rst
> +++ b/doc/guides/rel_notes/release_25_11.rst
> @@ -55,6 +55,9 @@ New Features
>       Also, make sure to start the actual text at the margin.
>       =======================================================
>  
> +* Added ``rte_queue.h`` which is clone of BSD queue.h header that is
> +  portable across all OS's.

rte_queue.h -> rte_bsd_queue.h

...
