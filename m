Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930A9C44514
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 10:40:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE6B8402BA;
	Fri, 17 Jul 2026 12:40:29 +0200 (CEST)
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by mails.dpdk.org (Postfix) with ESMTP id 1F5984014F;
 Fri, 17 Jul 2026 12:40:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1784284826;
 bh=uNdtnb1XZ9THrrIihgxgnwha9Q3swqTJquC9KlOCanQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=esWRc9vRYKCy47POhYb8KbPZE2yDkmr4eEpk7/zyeBe/kmG77R322YpvL1bdd0Flt
 x3maibovHX5VRAE1shJwDjvgtfbdk0P787LDhw9rQOOvD6EDN1XLXqzI0krGWxBb/+
 b34E0upwdb/Mc3wmneJKWWGXVEiqpP4MufKDc+1fQRQi87sp6T+mgIxNy0mqf8j0WB
 go/mVl9Ge4J37ruUCk2gH6QooaAkuO94SFbF/ifuxa+/0kmaEybcy/EBqLkAaz5tAk
 HopajNbITYczcxf4SUEIRkaWK74Pmi14YLxIuvb1GcfzXoZu5YbfZTPubksuKgnxQh
 jbu8ZpM0Lc0LQ==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
 by mail.lysator.liu.se (Postfix) with ESMTP id 9F0613F14;
 Fri, 17 Jul 2026 12:40:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1784284826;
 bh=uNdtnb1XZ9THrrIihgxgnwha9Q3swqTJquC9KlOCanQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=esWRc9vRYKCy47POhYb8KbPZE2yDkmr4eEpk7/zyeBe/kmG77R322YpvL1bdd0Flt
 x3maibovHX5VRAE1shJwDjvgtfbdk0P787LDhw9rQOOvD6EDN1XLXqzI0krGWxBb/+
 b34E0upwdb/Mc3wmneJKWWGXVEiqpP4MufKDc+1fQRQi87sp6T+mgIxNy0mqf8j0WB
 go/mVl9Ge4J37ruUCk2gH6QooaAkuO94SFbF/ifuxa+/0kmaEybcy/EBqLkAaz5tAk
 HopajNbITYczcxf4SUEIRkaWK74Pmi14YLxIuvb1GcfzXoZu5YbfZTPubksuKgnxQh
 jbu8ZpM0Lc0LQ==
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
 id 83FC43E9A; Fri, 17 Jul 2026 12:40:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1784284823;
 bh=uNdtnb1XZ9THrrIihgxgnwha9Q3swqTJquC9KlOCanQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=nclHSWAFCFmzl0AgYlMBalgGLSka2bHtkhAtE2L9oA77/Vr9d+osNYTbZXw0zTHn/
 pzNYE/sxg4buSvsBOc/23WH3QVwor3qUWV/szrYjASDppb3M1jSbJc9JcHi3zE3JXj
 RYI/U+P3cC6pSdH1/9vCSYK4c3QhsiGUmknhUFfl05FdBa6suzOdnFOYYl/gmq1Su4
 JMAmmwA2Baut2rW3pt4lqSJD3oNtMJP3RRLbCFlwWk52yT/12mkmR7hdis1g8eNqjq
 wNvYHCs9qtVYqbn3laceAgNSY7wk9ka9mTir8JA6wOu70vXt9+4L14x8MNBbyC9KUI
 +wYZGwLmBGH0g==
Received: from [192.168.1.85] (h-62-63-215-114.A163.priv.bahnhof.se
 [62.63.215.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by mail.lysator.liu.se (Postfix) with ESMTPSA id 9B6563E98;
 Fri, 17 Jul 2026 12:40:22 +0200 (CEST)
Message-ID: <e893da05-888f-40c6-919c-95ff28ff9e1c@lysator.liu.se>
Date: Fri, 17 Jul 2026 12:40:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] test/dispatcher: transfer impl_opaque field
To: Thomas Monjalon <thomas@monjalon.net>,
 =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>,
 dev@dpdk.org, Jerin Jacob Kollanukkaran <jerinj@marvell.com>
Cc: Luka Jankovic <luka.jankovic@ericsson.com>, stable@dpdk.org
References: <20241211141303.132448-1-mattias.ronnblom@ericsson.com>
 <9491ee40-aa15-42b4-9b99-e47f29df217c@app.fastmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <hofors@lysator.liu.se>
In-Reply-To: <9491ee40-aa15-42b4-9b99-e47f29df217c@app.fastmail.com>
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

On 7/17/26 11:34, Thomas Monjalon wrote:
>> The dispatcher tests failed to transfer the impl_opaque rte_event
>> field between the dequeued and enqueued event, in violation with the
>> Eventdev API contract.
>>
>> Fixes: ecca8a0be606 ("lib: introduce dispatcher library")
>> Cc: stable@dpdk.org
>>
>> Signed-off-by: Mattias Rönnblom <mattias.ronnblom@ericsson.com>
> 
> Applied, thanks.
> 
> (better late than never)

Indeed! Thanks.

