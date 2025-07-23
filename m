Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD1BC83F17
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 15:30:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FCD94066C;
	Wed, 23 Jul 2025 17:30:36 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 08854402A9
 for <dev@dpdk.org>; Wed, 23 Jul 2025 17:30:35 +0200 (CEST)
Received: from debian (unknown [78.109.70.60])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 18E22E0A60;
 Wed, 23 Jul 2025 19:30:33 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 18E22E0A60
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1753284634;
 bh=qMdXfFTMP3CkhzDduy6b04TAbdWDHlC6L7ITGRGrwjI=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=Ii51d2mpwRGWmcZBe99mIIoXW2zHSHNNDo9vZOdm6nQlPnuRIySQY6wW2Aeui2lvu
 o2hZyDKDxlRIeVoYzKXdKJ0WXIzuIWyRaq6De6MNvF/CZfhoAZlxyS8Toh9QIA/xbB
 dJ8iNWoMbrPxCeOe5yoWOZRaO942+5H5yy4yqXEASIo6gRXUj8vXkR1vrFeEzPww9O
 zWADr8sHnT4C0U8AOn1hajmxyMvlzBnz97MCkOFmYZrvKW786Uc+YGRlgzAc0mJmpP
 AjSCTa3BH1Mnli5keWBXXlYXq+aq79kQtEh6dfqJO2puGirxPKvvKZnWx3A5qU/5H1
 eQJ0hrz25LThQ==
Date: Wed, 23 Jul 2025 19:30:32 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: Stephen Hemminger <stephen@networkplumber.org>
cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>, 
 Thomas Monjalon <thomas@monjalon.net>, 
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, 
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: Re: [PATCH v6 07/13] ethdev: add port mirroring feature
In-Reply-To: <20250723082637.2e25b757@hermes.local>
Message-ID: <85915640-f131-70aa-68dc-2529294449ac@arknetworks.am>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250722173552.184141-1-stephen@networkplumber.org>
 <20250722173552.184141-8-stephen@networkplumber.org>
 <af08b0c8-1bb9-ca64-f62c-61bdc884adbb@arknetworks.am>
 <20250723082637.2e25b757@hermes.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

On Wed, 23 Jul 2025, Stephen Hemminger wrote:

> On Wed, 23 Jul 2025 06:13:27 +0400 (+04)
> Ivan Malov <ivan.malov@arknetworks.am> wrote:
>
>>  +static inline void
>>> +eth_dev_mirror(uint16_t port_id, uint16_t queue_id, uint8_t direction,
>>> +	     struct rte_mbuf **pkts, uint16_t nb_pkts,
>>> +	     const struct rte_eth_mirror_conf *conf)
>>> +{
>>> +	struct rte_mbuf *tosend[RTE_MIRROR_BURST_SIZE];
>>> +	unsigned int count = 0;
>>> +	unsigned int i;
>>> +
>>> +	for (i = 0; i < nb_pkts; i++) {
>>> +		struct rte_mbuf *m = pkts[i];
>>> +		struct rte_mbuf *mc;
>>> +
>>> +		if (conf->flags & RTE_ETH_MIRROR_INDIRECT_FLAG) {
>>> +			mc = rte_pktmbuf_alloc(conf->mp);
>>
>> Can 'rte_pktmbuf_alloc_bulk' be used prior to the 'for' loop? I do not insist.
>>
>>> +			if (unlikely(mc == NULL))
>>> +				continue;
>>> +
>>> +			/* Make both mbuf's point to the same data */
>>> +			rte_pktmbuf_attach(mc, m);
>>> +		} else {
>>> +			mc = rte_pktmbuf_copy(m, conf->mp, 0, conf->snaplen);
>>> +			/* TODO: dropped stats? */
>>> +			if (unlikely(mc == NULL))
>>> +				continue;
>>> +		}
>>>
>
> Both sides could use a bulk allocated array, but would need new variant
> of rte_pktmbuf_copy for that.

I see. I just meant may be something like this could be done before the loop.
> if (conf->flags & RTE_ETH_MIRROR_INDIRECT_FLAG) {
>     // do bulk alloc -> tosend
> }
But OK, understood.

Thank you.

>
