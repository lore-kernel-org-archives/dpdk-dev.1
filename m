Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C422CD8CB9
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 15:41:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3221640A81;
	Wed, 10 Jun 2026 17:41:19 +0200 (CEST)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mails.dpdk.org (Postfix) with ESMTP id DABB0402BA
 for <dev@dpdk.org>; Wed, 10 Jun 2026 17:41:17 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 4D8251400101;
 Wed, 10 Jun 2026 11:41:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Wed, 10 Jun 2026 11:41:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1781106077;
 x=1781192477; bh=tLcB6wBSkpugCB2quiuhnVhjtnp01QFKV1F7yVUlnzA=; b=
 aRvHv/tQKVsp61z7gJgdi2N8fk0APwmlkrtQEj40mPorpy5HfhG+fRlZTpBwzLiK
 yWx4n2+XWxnA5L5fcplHWPnBchH28PoS9b9fjWUPhDXCzgU+Ya83bRtDAMmmr2KH
 Zeiu5gpJObH5lDySqnd0sDaWq5LlDuIw4UmA0KGymZZRoHAvbZSVNZys1PH3vuQJ
 6fJxhk1OIk/hI+yYDdajmdzSYy4fTzRFE+AVgp04WK70DEYs2xvl15/oSExT45rk
 3PwI6n6ZKjraxYM+DdnLwbNQtD/sVyN5CPU3tA3rKvtJ0w+VTPytgXF+TX+TSNZ+
 O/5jfVUZUr1fmpNdtg2TuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781106077; x=
 1781192477; bh=tLcB6wBSkpugCB2quiuhnVhjtnp01QFKV1F7yVUlnzA=; b=U
 Ya8UlT7kRLX6XAvfYGFy8hLUcL7GP6TG4y+JCs2LNA9oWRyMb70OH3Mh+R57qyKN
 fuR1U2Z8hTOOBnguLGUElDgZB3vZS50ucM+vnSHuORi+eCVmdFFAx+d1jWSh9uBv
 UDdTFUc2ENBf6Gbiy72RCXWluKokM2c8423U6HWvm233WGOGDRQWbkszizxVkTZM
 KmdUPLb3Wgt8R03VZNhRyPR+6H3iKd18MQ2EH6pklWfN2os9/MmmE24CADHC4luX
 8pd/dcPzZMDu2Uc7FcpS19GOfb4Dax1/XnxkFy5iUBNoSOVQpW5XI2ACKi31OQMd
 v8uO0iFPjtKoIuv0JohBw==
X-ME-Sender: <xms:nIUpat2QV4UknQdY3wMYHsQ-088NE6aezcrETA6OfX0spigR3mX2TA>
 <xme:nIUpakO9vK4-Q9XlI_99TtgfN8zZ4s9Fhb32MXPKJ25xWNm1muLSvY1cF3KVUz5-V
 7NURRnv4gnf2iJK6zKeek7DoL0DmMetBDBsKHt2qEOtpYNZGacdCw>
X-ME-Received: <xmr:nIUpal3R_fk5PrXmmdzFwJCI4InRr4WuEj9URWi_mO0SH3Kilhd3MkG5gJLquWDNuDQUFBc4We9hShH-h4W28SSkaA>
X-ME-Proxy-Cause: dmFkZTF4hRLfs+eacbT7P9W6HTXfsNeh4dByt5wJSgKiiictXWLDUBbKMVXBDNwP3QnfHO
 L4NierW5kECS+Qh9MIkBSuWdmGSh9NkndMSjK2eAnPmYKJ4r73iwkpcjAM9kw9zwM1AQyZ
 8DsLi7LzMhrsClYJnVW8k8GYYkTxSSstloHMcbWMWzAp/T2QPwzzkNpcmI3ZS0aM+84isN
 X9RUyrM/hVrOJF5woPmfHbTm1lSaaweUmRoVfiwpY5oU98XWfHH5B+VKAo/Jvv9gzmmJF9
 OPtu56RngOfDVPpKNQethRMbD52dd4Skl1EJRzQELZZ0NJOe1U2dwp/P2vuu4RTiL9+ajg
 /yH6NJeDXuvM/zn/wZie6HEXSltYyGi8a9PhPnfrZAFtBpVcor2+3UGwj/bkbTXxtCIcD6
 nk1wOmsJ8/ewCH0o8rIV3jmLniNOHiQ3+3oeydpFIbZbQACgYNrY+gSYJe6/rDf26mzb3S
 YqIk9Y7sR9nsj3bjLHENNDKNYMXdGCtWEQ0AxUTG8pBXjr6gnWY0rEugWWpLlHrFY2nCEF
 noqyn7oFGdWqNq8qLflwiBphNKQq3F6l1SAUFvzLDJpzxkG3leqiS4mFaB/OXqgLXSjX8a
 b90qa0nAvruq0ExHescn4Uqwx/rLl0AjZgTruF72OM3P8aQptzUVdW1UZEeA
X-ME-Proxy: <xmx:nIUpajFzFoacG7a6N9wRdw9wwuqmKOH6veEf5xQMN3PY6StVU8xDvg>
 <xmx:nIUpaq4fI2CCY3hIrXAV9nWTPGzLZzZ7qHE9j3Z_zzukvEPQP1vBRQ>
 <xmx:nIUpahvf8m6t_7yMfQUCW_HROZFxJ9TWUvP1z9bN8KWOR649s09bVQ>
 <xmx:nIUpaj52ADZLT7LCdty4zvNa4lgJ6yEvWXiOjLbzt__PHkrv5Zx5QA>
 <xmx:nYUpajlXkNU5jXB5CTb6U66MMdeKxQRzv0jZfNNq3HJ8NTPN-sxgKVJl>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 11:41:15 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: Re: [PATCH v2 2/3] ring: use GCC builtin as alternative to
 rte_atomic32
Date: Wed, 10 Jun 2026 17:41:13 +0200
Message-ID: <pL5asB6YRnyIfgpFKaylfw@monjalon.net>
In-Reply-To: <20260604163656.1226902-3-stephen@networkplumber.org>
References: <20260602171552.686349-1-stephen@networkplumber.org>
 <20260604163656.1226902-1-stephen@networkplumber.org>
 <20260604163656.1226902-3-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

04/06/2026 18:32, Stephen Hemminger:
> This patch replaces use of the deprecated rte_atomic32 code with
> GCC builtin atomic operations.

It compiles fine with GCC, but there is an issue with clang:

ninja: Entering directory `build-gcc-static'
ninja: no work to do.
ninja: Entering directory `build-gcc-shared'
ninja: no work to do.
ninja: Entering directory `build-clang-static'
ninja: no work to do.
ninja: Entering directory `build-clang-shared'
[1/3069] Compiling C object lib/librte_ring.a.p/ring_soring.c.o
rte_ring_gcc_pvt.h:43:2: error: address argument to atomic operation must be a pointer to integer or pointer ('volatile _Atomic(uint32_t) *' invalid)
   43 |         __atomic_store_n(&ht->tail, new_val, __ATOMIC_RELEASE);
      |         ^                ~~~~~~~~~


> Although it would be preferable to use C11 version on all architectures,
> there is a performance loss if we do it that way:
> 
> Measured on i9-13900H, two physical cores MP/MC bulk n=128, 10 runs:
>   with C11 builtin:           5.86 cycles/elem
>   with __sync builtin:        5.36 cycles/elem  (-9.4%)

You don't compare with the current rte_atomic functions?


