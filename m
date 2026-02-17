Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DE4E83856
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 06:41:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE2F9402A2;
	Tue, 17 Feb 2026 07:41:09 +0100 (CET)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 9368C4029D
 for <dev@dpdk.org>; Tue, 17 Feb 2026 07:41:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru DA3C750
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1771310467;
 bh=/dN8RhJO1Do+o5syC08kYz1utL2Qj+ZGRkg+ROmj99U=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=hz7fg9PB/evg7XOwFVYJ85R258CKN22zU2MWzNDG6ppovSWzQ0Nqlchr+d14a/8yi
 2TLFlo57ecThKNZ+4m/oULSvWubLZtoWzIdkxKuLaISMKam5xHsm8EU7bIOAGk7IAN
 jDLt49nXHixsSFk8UD6GJEQ8qwEm60pOya4JJoOM=
Received: from [192.168.38.17] (aros.oktetlabs.ru [192.168.38.17])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id DA3C750;
 Tue, 17 Feb 2026 09:41:07 +0300 (MSK)
Message-ID: <b361cfbe-039d-437e-b628-5cb9f923bac7@oktetlabs.ru>
Date: Tue, 17 Feb 2026 09:41:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] ethdev: clarify rte_eth_tx_burst() return value and
 ownership semantics
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>
References: <20260216180011.393782-1-stephen@networkplumber.org>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Organization: OKTET Labs
In-Reply-To: <20260216180011.393782-1-stephen@networkplumber.org>
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

On 2/16/26 9:00 PM, Stephen Hemminger wrote:
> The documentation for rte_eth_tx_burst() uses the word "sent" to
> describe the return value, which is misleading. Packets returned as
> consumed may not have been transmitted yet; they have been accepted
> by the driver and are no longer the caller's responsibility.
> 
> This matters because the common usage pattern is:
> 
>      n = rte_eth_tx_burst(port, txq, mbufs, nb_pkts);
>      for (i = n; i < nb_pkts; i++)
>          rte_pktmbuf_free(mbufs[i]);
> 
> For this to work correctly, the contract must be:
>   - tx_pkts[0..n-1]: ownership transferred to the driver.
>   - tx_pkts[n..nb_pkts-1]: untouched, still owned by the caller.
> 
> Several drivers (and AI-assisted reviews) misinterpret the current
> wording and treat packets with errors as unconsumed, returning a
> short count. This causes callers to retry those packets indefinitely.
> The correct behavior is that the driver must consume (and free)
> erroneous packets, counting them via tx_errors.
> 
> Replace "sent" with "consumed" in the return value description,
> spell out the mbuf ownership contract, clarify the error handling
> expectation, and update the @return block to match.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>

Thanks for the clarification. I really like it.

