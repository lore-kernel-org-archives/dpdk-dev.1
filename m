Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC283CD5BD0
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 17:25:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C04624026C;
	Wed, 27 May 2026 19:25:56 +0200 (CEST)
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by mails.dpdk.org (Postfix) with ESMTP id 429194014F
 for <dev@dpdk.org>; Wed, 27 May 2026 19:25:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1779902754;
 bh=uyUUWMc0OfOdR8apDgyaxvbbxel6LvZI5IqJ1pWKk98=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=uzPsC6/bKFVS6cMeG24mFii4H3lZrokryBynqgaDDy6TeBupFMwzZRnlDOWffZbku
 IJRF3+tD8QZqcLQw0z8ZZXKy3YeQ8ihrtT0aLKYFf9pM3DlX9QpDKXaWL11br64BpW
 LcHzn6pag+ibOUtOcT5O9vxxH+ga3NPrpvV1RAEnDDKg2NI5DJYwACMvp/80dA1KcH
 50T7qDkhAicFpXQqqREScnWsUJknYin99se7Nac31UKWmutkYtNtepaL9Y2f9g6szV
 JzYpkGETOakRRh1fQVgjXB5ak8gJEHO2Ji/FK9BLtd/9AofoyO3NOcgn0d8Ceo4ep+
 NmQw31N8W2g8A==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
 by mail.lysator.liu.se (Postfix) with ESMTP id D5C003234
 for <dev@dpdk.org>; Wed, 27 May 2026 19:25:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1779902754;
 bh=uyUUWMc0OfOdR8apDgyaxvbbxel6LvZI5IqJ1pWKk98=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=uzPsC6/bKFVS6cMeG24mFii4H3lZrokryBynqgaDDy6TeBupFMwzZRnlDOWffZbku
 IJRF3+tD8QZqcLQw0z8ZZXKy3YeQ8ihrtT0aLKYFf9pM3DlX9QpDKXaWL11br64BpW
 LcHzn6pag+ibOUtOcT5O9vxxH+ga3NPrpvV1RAEnDDKg2NI5DJYwACMvp/80dA1KcH
 50T7qDkhAicFpXQqqREScnWsUJknYin99se7Nac31UKWmutkYtNtepaL9Y2f9g6szV
 JzYpkGETOakRRh1fQVgjXB5ak8gJEHO2Ji/FK9BLtd/9AofoyO3NOcgn0d8Ceo4ep+
 NmQw31N8W2g8A==
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
 id B86A132AF; Wed, 27 May 2026 19:25:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1779902751;
 bh=uyUUWMc0OfOdR8apDgyaxvbbxel6LvZI5IqJ1pWKk98=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=bxQDjZEqPzgr311Ht8yKN+KrZWlyeFfCe9L+P9/A/B9vDoAOUEx4g+G+yMjChWlpD
 RyLY5tdGI3rrjOvTh2CVUdYjlwnK5RFzhabp6t/s+hYLcUiTPXHQ3B5hHT3aBNiHX/
 PXUAv8XmeF7hpUjWsrHkiAT21a/lWcHZoHr/T8wA8Xhj/Nukah8r4HUCV8Hm7D2ad0
 M+RI1bM4bAbe1yvbi99IBPovy7IZnGemRuxzhw1qv6cgZpmulcncj6zpQ+llMUtgOo
 3nRoaC62GxqdfRRHYvdZOpdkZhUnFj6boZeDYbHSxfVU3ozsdGub7PgtO1cOPF8EM/
 g6M+OSxcrtAGQ==
Received: from [192.168.1.85] (h-62-63-215-114.A163.priv.bahnhof.se
 [62.63.215.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by mail.lysator.liu.se (Postfix) with ESMTPSA id 9491232AD;
 Wed, 27 May 2026 19:25:50 +0200 (CEST)
Message-ID: <22515b67-e155-4877-a02b-f343b6097d0f@lysator.liu.se>
Date: Wed, 27 May 2026 19:25:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/3] lib: add fastmem library
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>,
 Yogaraj Baskaravel <yogaraj.baskaravel@ericsson.com>
References: <20260525103642.55255-1-hofors@lysator.liu.se>
 <20260525103642.55255-3-hofors@lysator.liu.se>
 <20260527072251.7c53719d@phoenix.local>
Content-Language: en-US
From: =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <hofors@lysator.liu.se>
In-Reply-To: <20260527072251.7c53719d@phoenix.local>
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

On 5/27/26 16:22, Stephen Hemminger wrote:
> On Mon, 25 May 2026 12:36:41 +0200
> Mattias Rönnblom <hofors@lysator.liu.se> wrote:
> 
>> +
>> +static __rte_always_inline struct fastmem_cache *
>> +cache_get(struct fastmem_socket_state *socket, unsigned int class_idx,
>> +		unsigned int lcore_id)
> 
> Do not use always_inline. With current compilers using always inline
> makes the optimizer generate worse code. The only exceptions would
> be where inline is required to make assembly work or you have good benchmark
> data that proves that always_inline generates > 1% performance gain.
> 
> To much of DPDK use __rte_always_inline as "cargo cult" it is faster setting.

__rte_always_inline is still useful, but it is rare. For example, it may 
be required in certain situations to force constant propagation to 
actually occur.

I'm removing both inline and always_inline. Doesn't make a difference, 
so noise.

