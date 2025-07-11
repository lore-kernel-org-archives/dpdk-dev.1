Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5076CC8303C
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Jul 2025 12:44:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C69840673;
	Fri, 11 Jul 2025 14:44:11 +0200 (CEST)
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by mails.dpdk.org (Postfix) with ESMTP id 3D254400D6
 for <dev@dpdk.org>; Fri, 11 Jul 2025 14:44:10 +0200 (CEST)
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
 by mail.lysator.liu.se (Postfix) with ESMTP id AC9BF8026
 for <dev@dpdk.org>; Fri, 11 Jul 2025 14:44:09 +0200 (CEST)
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
 id 84BA18024; Fri, 11 Jul 2025 14:44:09 +0200 (CEST)
Received: from [192.168.1.85] (h-62-63-215-114.A163.priv.bahnhof.se
 [62.63.215.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by mail.lysator.liu.se (Postfix) with ESMTPSA id CA3AE8023;
 Fri, 11 Jul 2025 14:44:07 +0200 (CEST)
Message-ID: <1dd2aaf4-9bc7-43fb-8261-0c4c9387ad07@lysator.liu.se>
Date: Fri, 11 Jul 2025 14:44:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] event/eth_tx: prefetch mbuf headers
To: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>
Cc: dev@dpdk.org, Naga Harish K S V <s.v.naga.harish.k@intel.com>,
 Jerin Jacob <jerinj@marvell.com>,
 Peter Nilsson <peter.j.nilsson@ericsson.com>
References: <20250328054339.489914-1-mattias.ronnblom@ericsson.com>
 <20250710083747.6f613e7f@hermes.local>
Content-Language: en-US
From: =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <hofors@lysator.liu.se>
In-Reply-To: <20250710083747.6f613e7f@hermes.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

On 2025-07-10 17:37, Stephen Hemminger wrote:
> On Fri, 28 Mar 2025 06:43:39 +0100
> Mattias Rönnblom <mattias.ronnblom@ericsson.com> wrote:
> 
>> Prefetch mbuf headers, resulting in ~10% throughput improvement when
>> the Ethernet RX and TX Adapters are hosted on the same core (likely
>> ~2x in case a dedicated TX core is used).
>>
>> Signed-off-by: Mattias Rönnblom <mattias.ronnblom@ericsson.com>
>> Tested-by: Peter Nilsson <peter.j.nilsson@ericsson.com>
> 
> Prefetching all the mbufs can be counter productive on a big burst.
> 

For the non-vector case, the burst is no larger than 32. From what's 
available in terms of public information, the number of load queue 
entries is 72 on Skylake. What it is on newer micro architecture 
generations, I don't know. So 32 is a lot of prefetches, but at least 
likely smaller than the load queue.

> VPP does something similar but more unrolled.
> See https://fd.io/docs/vpp/v2101/gettingstarted/developers/vnet.html#single-dual-loops

This pattern makes sense, if the do_something_to() function has 
non-trivial latency.

If it doesn't, which I suspect is the case in the TX adapter case, you 
will issue 4 prefetches, of which some or even all aren't resolved 
before the core need to data. Repeat.

Also - and I'm guessing now - the do_something_to() equivalent in the TX 
adapter case is likely not allocating a lot of load buffer entries, so 
little risk of the prefetches being discarded.

That said, I'm sure you can tweak non-vector TXA prefetching to further 
improve performance. For example, it may be little point in prefetching 
the first few mbuf headers, since you will need that data very soon indeed.

I no longer have the setup to further refine this patch. I suggest we 
live with only ~20% performance gain at this point.

For the vector case, I agree this loop may result in too many prefetches.

I can remove prefetching from the vector case, to maintain legacy 
performance. I could also cap the number of prefetches (e.g., to 32).

