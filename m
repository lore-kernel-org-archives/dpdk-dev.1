Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9587F606A31B
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 06:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=cAIumbV9
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E32A40270;
	Tue, 20 Oct 2026 08:54:30 +0200 (CEST)
Received: from forward502d.mail.yandex.net (forward502d.mail.yandex.net
 [31.44.14.18]) by mails.dpdk.org (Postfix) with ESMTP id 5FBF340144
 for <dev@dpdk.org>; Tue, 20 Oct 2026 08:54:29 +0200 (CEST)
Received: from mail-nwsmtp-smtp-production-main-52.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-52.yp-c.yandex.net)
 by forward502d.mail.yandex.net (postfix) with ESMTPS id A3EFDC038B;
 Tue, 20 Oct 2026 09:54:26 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-52 with ESMTPSA id
 NsTQcwjfBeA0-R1csWi1v; Tue, 20 Oct 2026 09:54:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1792479266; bh=hIAZpqXqc0x5HY6XrI1dEaJBGjFHXDor5GYjSAJxI8M=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=cAIumbV9U85zgC4qLcbLEm+jgy1UQLzoRfkUPwDTNrR/ivPHkZJ8gDRRVVHYYpXJp
 X4aUhvCDE2lWxzN3524EpFWelyhoa4lKVDADTAVg2hYruhSx5otK1Rvta5eiPrGoBb
 XwCLGalp97PlxrRVrzlhl8UQRPHlhf6LDeMoynKQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-52;
 dkim=pass header.i=@yandex.ru
Message-ID: <8ef01e45-dcb4-4e0c-a40b-ff1e5e8db1f1@yandex.ru>
Date: Tue, 20 Oct 2026 07:54:22 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] bpf: document ethdev callback threading limitations
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Marat Khalili <qm2k21@gmail.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>, dev@dpdk.org
References: <20261011182158.124246-1-qm2k21@gmail.com>
 <20261012210917.161343-1-qm2k21@gmail.com>
 <20261012210917.161343-3-qm2k21@gmail.com>
 <e5ff5f2b-de4c-48a7-bc0d-3a7392bb6e1a@yandex.ru>
 <20261019163518.1b6fd3c7@phoenix.local>
Content-Language: en-US, ru
From: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
In-Reply-To: <20261019163518.1b6fd3c7@phoenix.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



20.10.2026 00:35, Stephen Hemminger пишет:
> On Mon, 19 Oct 2026 22:10:11 +0100
> Konstantin Ananyev <konstantin.v.ananyev@yandex.ru> wrote:
>
>>> Document the data plane limitation in the file docstring of
>>> rte_bpf_ethdev.h: packet callback execution expects only one
>>> thread per port/queue pair at a time, making concurrent bursts
>>> (such as with RTE_ETH_TX_OFFLOAD_MT_LOCKFREE, shared RX queues,
>>> or multi-threaded software PMDs) unsupported.
>> Not sure what do you mean by:
>> 'shared RX queues' and 'multi-threaded software PMDs'. Can you probably
>> clarify?
> The restriction is that: rte_bpf_eth_tx_elf_load() can not be be used with RTE_ETH_TX_OFFLOAD_MT_LOCKFREE
> because if that offload is set, application is allowed to share a single transmit queue across multiple lcore.
I understand that part.
My question was: what Marat means by:

'shared RX queues' and 'multi-threaded software PMDs'

AFAIK, we don't have such things right now.
Correct me, if I am wrong.
  

>
> It would be better if the attempts to load on such a device failed.
> But in the is not enough because at least in theory a user could enable
> the offload later by reconfiguring the device.

