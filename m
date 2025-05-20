Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49065C3DA6D
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 May 2025 12:56:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28B4A402C2;
	Tue, 20 May 2025 14:56:25 +0200 (CEST)
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by mails.dpdk.org (Postfix) with ESMTP id 1D8F3402AE
 for <dev@dpdk.org>; Tue, 20 May 2025 14:56:24 +0200 (CEST)
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
 by mail.lysator.liu.se (Postfix) with ESMTP id 98B0A6323
 for <dev@dpdk.org>; Tue, 20 May 2025 14:56:23 +0200 (CEST)
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
 id 8D4D4623C; Tue, 20 May 2025 14:56:23 +0200 (CEST)
Received: from [192.168.1.85] (h-62-63-215-114.A163.priv.bahnhof.se
 [62.63.215.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by mail.lysator.liu.se (Postfix) with ESMTPSA id CBA3062A7;
 Tue, 20 May 2025 14:56:21 +0200 (CEST)
Message-ID: <e9b59048-4b3a-4daa-a944-81aff0d22c99@lysator.liu.se>
Date: Tue, 20 May 2025 14:56:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] event/eth_tx: prefetch mbuf headers
From: =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <hofors@lysator.liu.se>
To: =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>,
 dev@dpdk.org
Cc: Naga Harish K S V <s.v.naga.harish.k@intel.com>,
 Jerin Jacob <jerinj@marvell.com>,
 Peter Nilsson <peter.j.nilsson@ericsson.com>
References: <20250328054339.489914-1-mattias.ronnblom@ericsson.com>
 <d0277a40-c17f-4ebf-99b3-bdb7e9190519@lysator.liu.se>
Content-Language: en-US
In-Reply-To: <d0277a40-c17f-4ebf-99b3-bdb7e9190519@lysator.liu.se>
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

On 2025-03-28 07:07, Mattias Rönnblom wrote:
> On 2025-03-28 06:43, Mattias Rönnblom wrote:
>> Prefetch mbuf headers, resulting in ~10% throughput improvement when
>> the Ethernet RX and TX Adapters are hosted on the same core (likely
>> ~2x in case a dedicated TX core is used).
>>
>> Signed-off-by: Mattias Rönnblom <mattias.ronnblom@ericsson.com>
>> Tested-by: Peter Nilsson <peter.j.nilsson@ericsson.com>
> 

<snip>

Naga, could you comment on this patch?

