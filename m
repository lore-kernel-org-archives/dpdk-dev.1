Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADE5E8385D
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 06:53:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A260B402A2;
	Tue, 17 Feb 2026 07:53:11 +0100 (CET)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id C214D4029D
 for <dev@dpdk.org>; Tue, 17 Feb 2026 07:53:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 140AA50
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1771311190;
 bh=iRoqmdr9MSaNPj+d4L4o6jSCVQCpHCI9bwbQMaTjSqM=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=Ym1U4zGW5C6+Ir6diuXcndUd1dQbDnXrgfviUZOC84eN87Xy8Kt9VTXoZJk+CKPuf
 qlLNXNqCdKbGXMaGPkFf5BPj7XkNKb7GOBKx5b/s7PUmR+chaumUqCnVSehlQmLL3V
 KWXtRU4Lack4DsXn+d2G+fxtkJUee+2GcEKYrRLI=
Received: from [192.168.38.17] (aros.oktetlabs.ru [192.168.38.17])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 140AA50;
 Tue, 17 Feb 2026 09:53:10 +0300 (MSK)
Message-ID: <2d2f055b-b833-4ca5-a9ba-e40ab8c9cf7f@oktetlabs.ru>
Date: Tue, 17 Feb 2026 09:53:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mempool: simplify get objects
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, dev@dpdk.org
References: <20260120082049.466224-1-mb@smartsharesystems.com>
 <20260216092750.94137-1-mb@smartsharesystems.com>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Organization: OKTET Labs
In-Reply-To: <20260216092750.94137-1-mb@smartsharesystems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 2/16/26 12:27 PM, Morten Brørup wrote:
> Removed explicit test for build time constant request size,
> and added comment that the compiler loop unrolls when request size is
> build time constant, to improve source code readability.
> 
> Moved setting cache->len up before the copy loop; not only for code
> similarity (cache->len is now set before each copy loop), but also as an
> optimization:
> The function's pointer parameters are not marked restrict, so writing to
> obj_table in the copy loop might formally modify cache->size. And thus,
> setting cache->len = cache->size after the copy loop requires loading
> cache->size again after copying the objects.
> Moving this line up before the copy loop avoids that extra load of
> cache->size when setting cache->len.
> 
> Similarly, moved statistics update up before the copy loops.
> 
> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>

Reviewed-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>

