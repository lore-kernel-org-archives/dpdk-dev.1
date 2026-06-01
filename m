Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCD8CD6E4C
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 08:12:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 763A54025F;
	Mon,  1 Jun 2026 10:12:34 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id AEE164025A
 for <dev@dpdk.org>; Mon,  1 Jun 2026 10:12:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 638D466
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1780301551;
 bh=DcjXompDYPRAd9+1HgSGqdrHzLjATmRSBx+yZre7Cvs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=fceoy/54ZJt9RJk7G1onPIIey66ytROdJqTdKgwCTI4UsT0d7S47LNlH9gxDN+2nm
 oKylX8adQh/PoPTnGM6xXOe07aPZdbKT9YN53kawJXCIW6STisZAP9IseanqbXJ5ll
 d9sR03sd+2j+9UU12I26IPz/8qFcx9RTfZKZMcOI=
Received: from [192.168.38.17] (aros.oktetlabs.ru [192.168.38.17])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 638D466;
 Mon,  1 Jun 2026 11:12:31 +0300 (MSK)
Message-ID: <a239680c-0042-4635-b038-6c0a545ba0e5@oktetlabs.ru>
Date: Mon, 1 Jun 2026 11:12:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] app/test/mempool_perf: size mempool by tested cores
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
References: <20260529171417.526892-1-stephen@networkplumber.org>
 <20260529171417.526892-4-stephen@networkplumber.org>
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Content-Language: en-US
Organization: OKTET Labs
In-Reply-To: <20260529171417.526892-4-stephen@networkplumber.org>
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

On 5/29/26 8:10 PM, Stephen Hemminger wrote:
> The mempool size is computed from rte_lcore_count() so on systems
> with many lcores the test requires multiple GB of hugepages even
> for the single-core and dual-core variants.  On a 20 lcore system
> with 2 GB of hugepages the test fails with:
> 
>    cannot populate ring_mp_mc mempool
>    Test Failed
> 
> Size the four mempools by the number of cores actually exercised.
> 
> Return TEST_SKIPPED rather than -1 when allocation or populate of
> a mempool fails, so insufficient memory is reported as a skip and
> not as a test failure.  Propagate the skip through the combined
> mempool_perf_autotest wrapper.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>

