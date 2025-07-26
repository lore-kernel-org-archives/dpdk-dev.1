Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AB6C83F17
	for <dpdk-dev@archiver.kernel.org>; Sat, 26 Jul 2025 12:01:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 22E2D40611;
	Sat, 26 Jul 2025 14:01:21 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id B30804060B
 for <dev@dpdk.org>; Sat, 26 Jul 2025 14:01:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 8E8BC50
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1753531278;
 bh=Vmpydv2ckHZfCaXjKCcaO4uS3X1vp5hHOpYRitcF3pM=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=F9ak6RXrhw1DLbtfmUYiDxp8OXbQpbnBUpA/Bd+TyorXxBnQ8hUXkDURB4pXvwffR
 IK1GLo6Ds9Fz/mtEIKAivWlthayDprqJffqsVQWGpUnXrneGdFqL5jze6GCHVjfhQz
 gPm3NW4fvw9SD4xPzoeN7keoNAx/3YBuJxBqpVIw=
Received: from [192.168.1.39] (unknown [188.170.87.221])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 8E8BC50;
 Sat, 26 Jul 2025 15:01:18 +0300 (MSK)
Message-ID: <528ee607-8212-429d-a6c4-02e0e6408b99@oktetlabs.ru>
Date: Sat, 26 Jul 2025 15:01:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mbuf: de-inline sanity checking a reinitialized mbuf
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, dev@dpdk.org,
 Thomas Monjalon <thomas@monjalon.net>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Ivan Malov <ivan.malov@arknetworks.am>
References: <20250719102315.435921-1-mb@smartsharesystems.com>
 <20250722093431.555214-1-mb@smartsharesystems.com>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
In-Reply-To: <20250722093431.555214-1-mb@smartsharesystems.com>
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

On 7/22/25 12:34, Morten Brørup wrote:
> Sanity checking a reinitialized mbuf (a.k.a. raw mbuf) has been refactored
> to follow the same design pattern as sanity checking a normal mbuf, and
> now depends on RTE_LIBRTE_MBUF_DEBUG instead of RTE_ENABLE_ASSERT.
> 
> The details of the changes are as follows:
> 
> Non-inlined functions rte_mbuf_raw_sanity_check() and rte_mbuf_raw_check()
> have been added.
> They do for a reinitialized mbuf what rte_mbuf_sanity_check() and
> rte_mbuf_check() do for a normal mbuf.
> They basically check the same conditions as __rte_mbuf_raw_sanity_check()
> previously did, but use "if (!condition) rte_panic(message)" instead of
> RTE_ASSERT(), so they don't depend on RTE_ENABLE_ASSERT.
> 
> The inline function __rte_mbuf_raw_sanity_check() has been replaced
> by the new macro __rte_mbuf_raw_sanity_check_mp(), which either calls
> rte_mbuf_raw_sanity_check() or does nothing, depending on
> RTE_LIBRTE_MBUF_DEBUG, just like the __rte_mbuf_sanity_check() macro does
> for a normal mbuf.
> 
> Note that the new macro __rte_mbuf_raw_sanity_check_mp() takes an optional
> mempool parameter to verify that the mbuf belongs to the expected mbuf
> pool.
> This addition is mainly relevant for sanity checking reinitialized mbufs
> freed directly into a given mempool by a PMD when using
> RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE.
> 
> The macro __rte_mbuf_raw_sanity_check() has been kept for backwards API
> compatibility.
> It simply calls __rte_mbuf_raw_sanity_check_mp() without specifying a
> mempool.
> 
> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>

Really good that the inline is removed.
As far as I remember easier it was an intent to remove rte_panic() from
libraries, but I think it is acceptable in this case.

Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
