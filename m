Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CE3CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Sun,  9 Nov 2025 14:50:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B51240268;
	Sun,  9 Nov 2025 15:50:46 +0100 (CET)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 515AA400D5
 for <dev@dpdk.org>; Sun,  9 Nov 2025 15:50:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 01A1B87
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1762699843;
 bh=XzJ3x/yZBPLBpmM5NLVSllVE+PVA53uJDITTYmBjKv0=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=h2oE3VRECi2kEatPnsb0CdJr93qiah3moUCjD6EonQtHKpsGq33yEy1cg9izWwsHT
 u6/rDW4KBwllkf9PwNrwA4CIPPQOVPnUdWl+jZKlpdmuNYmRI+J/mYh80q1lIjEu9k
 3dv9UVYBwcQx3SBmgQ6iyOS3lpEYAMs8DmtA8EZM=
Received: from [192.168.1.42] (unknown [188.170.87.245])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 01A1B87;
 Sun,  9 Nov 2025 17:50:42 +0300 (MSK)
Message-ID: <8d4666c3-e228-4dd1-be90-e3ae6deaf5f6@oktetlabs.ru>
Date: Sun, 9 Nov 2025 17:50:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 29/44] net/sfc: replace use of sys/queue.h
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20251103164915.101713-1-stephen@networkplumber.org>
 <20251103164915.101713-30-stephen@networkplumber.org>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
In-Reply-To: <20251103164915.101713-30-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 11/3/25 19:47, Stephen Hemminger wrote:
> Replace use of system sys/queue.h with DPDK rte_bsd_queue.h
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

[...]

> diff --git a/drivers/net/sfc/sfc_dp.h b/drivers/net/sfc/sfc_dp.h
> index 545f0f32bf..6f61b20a0f 100644
> --- a/drivers/net/sfc/sfc_dp.h
> +++ b/drivers/net/sfc/sfc_dp.h
> @@ -11,7 +11,6 @@
>   #define _SFC_DP_H
>   
>   #include <stdbool.h>
> -#include <sys/queue.h>

rte_bsd_queue.h should be added instead, since the header uses
TAILQ_ENTRY/HEAD macros.

>   
>   #include <rte_pci.h>
>   

