Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A66606A31A
	for <dpdk-dev@archiver.kernel.org>; Sun, 25 Oct 2026 07:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=EJLesbgK
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54C9B402B9;
	Sun, 25 Oct 2026 08:44:45 +0100 (CET)
Received: from forward500d.mail.yandex.net (forward500d.mail.yandex.net
 [31.44.14.16]) by mails.dpdk.org (Postfix) with ESMTPS id 9BBDA40269
 for <dev@dpdk.org>; Sun, 25 Oct 2026 08:44:43 +0100 (CET)
Received: from mail-nwsmtp-smtp-production-main-95.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-95.yp-c.yandex.net)
 by forward500d.mail.yandex.net (postfix) with ESMTPS id D80C781032;
 Sun, 25 Oct 2026 10:44:41 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-95 with ESMTPSA id
 diZ3KsVwhiE0-1h8pkkY8; Sun, 25 Oct 2026 10:44:41 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1792914281; bh=xYolZMA2rxFwivU2fH3DS+aUqKy5VRz/vfaDgJcr50k=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=EJLesbgKuhJHz7qB+6eYheWZaEjHW1XkXZ6+OqkxvRRUbSLglyZ7Gam4vtiOP/rL5
 yaJLH9NKWGMDLR1HMXh1SEt4ve6sECXcz0e5ExBe2xRwFUbgzFUkfaY9mW5DajpINC
 SsFVM5ROxXwG/HosKnw9/WSnq+7cOAvt5NmqhFsY=
Authentication-Results: mail-nwsmtp-smtp-production-main-95;
 dkim=pass header.i=@yandex.ru
Message-ID: <25c95d28-b393-4063-9b94-064b281812b9@yandex.ru>
Date: Sun, 25 Oct 2026 07:44:39 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] bpf: make callback handle atomic with relaxed
 access
To: Marat Khalili <qm2k21@gmail.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: dev@dpdk.org, stephen@networkplumber.org
References: <20261011182158.124246-1-qm2k21@gmail.com>
 <20261012210917.161343-1-qm2k21@gmail.com>
 <20261012210917.161343-9-qm2k21@gmail.com>
 <52dfdbb3-76a4-4cd4-a789-d864156b949e@yandex.ru>
 <a6c2138a-d029-4fd3-8296-dca57b319f18@gmail.com>
Content-Language: en-US, ru
From: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
In-Reply-To: <a6c2138a-d029-4fd3-8296-dca57b319f18@gmail.com>
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




>
> On 19/10/2026 22:27, Konstantin Ananyev wrote:
>>> The callback handle member cb of struct bpf_eth_cbi is concurrently
>>> cleared by the control plane on unload and read by the datapath to
>>> decide whether to execute the BPF filter program. Without atomic 
>>> typing,
>>> this concurrent access constitutes a data race in the C11 memory model,
>> Hmm... why is that?
>> So far, I don't see any.
>> Can you probably point where you believe is a data-race, and how 
>> using atomic
>> load/store can prevent it.
>
> It follows from the standard (5.1.2.4 Multi-threaded executions and 
> data races):
>
>     Two expression evaluations conflict if one of them modifies a 
> memory location and the
>     other one reads or modifies the same memory location. [...]

Well, that's why people invented different synchronization methods: 
mutexes, rcu, etc. :)
If you want to protect your data against data-races it soesn't mean yopu 
have to make
all your data  reads/writes atomic - you need to select a proper sync 
mechanism around
it, so you can keep using normal reads/writes for the data itself.
BTW, just blindly making data reads/writes atomic doesn't guarantee that 
there will be
no race conditions.

>
>     The execution of a program contains a data race if it contains two 
> conflicting actions in
>     different threads, at least one of which is not atomic, and 
> neither happens before the
>     other. Any such data race results in undefined behavior.

