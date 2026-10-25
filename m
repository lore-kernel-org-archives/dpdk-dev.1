Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE63606A31B
	for <dpdk-dev@archiver.kernel.org>; Sun, 25 Oct 2026 10:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=GBu4RGKS
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CDD23402B9;
	Sun, 25 Oct 2026 11:53:31 +0100 (CET)
Received: from forward503d.mail.yandex.net (forward503d.mail.yandex.net
 [31.44.14.19]) by mails.dpdk.org (Postfix) with ESMTPS id 90A184025F
 for <dev@dpdk.org>; Sun, 25 Oct 2026 11:53:30 +0100 (CET)
Received: from mail-nwsmtp-smtp-production-main-99.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-99.yp-c.yandex.net)
 by forward503d.mail.yandex.net (postfix) with ESMTPS id D2391100042;
 Sun, 25 Oct 2026 13:53:26 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-99 with ESMTPSA id
 OrcAcFXgFeA0-XDV6o5yA; Sun, 25 Oct 2026 13:53:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1792925606; bh=B94W2m+bFR5igvOgkPxx5rnoSNe9hWMvOMii4M8sOZ0=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=GBu4RGKS78WvbegUD27Ggps6y+OQnlcjty/23pOjL7a4wvHge3MjKRpo7esXo16rG
 /w34VgSW2lquoPBDYk4K7GVxvUOdDNvqZ0/a3KtpfCXbcNzVKv5eAocbZ+Yk/Bk6jj
 iMmmwWeyJaSy+thxoMZrWjb4cw+67L5gjnCltM2s=
Authentication-Results: mail-nwsmtp-smtp-production-main-99;
 dkim=pass header.i=@yandex.ru
Message-ID: <9aaf7648-173b-468f-b782-bf9cc90c3cbd@yandex.ru>
Date: Sun, 25 Oct 2026 10:53:24 +0000
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
 <25c95d28-b393-4063-9b94-064b281812b9@yandex.ru>
 <339ca0fe-acec-4e15-9a02-10a9753f69ba@gmail.com>
Content-Language: en-US, ru
From: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
In-Reply-To: <339ca0fe-acec-4e15-9a02-10a9753f69ba@gmail.com>
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
> On 25/10/2026 07:44, Konstantin Ananyev wrote:
>>> It follows from the standard (5.1.2.4 Multi-threaded executions and 
>>> data races):
>>>
>>>     Two expression evaluations conflict if one of them modifies a 
>>> memory location and the
>>>     other one reads or modifies the same memory location. [...]
>>
>> Well, that's why people invented different synchronization methods: 
>> mutexes, rcu, etc. :)
>> If you want to protect your data against data-races it soesn't mean 
>> yopu have to make
>> all your data  reads/writes atomic - you need to select a proper sync 
>> mechanism around
>> it, so you can keep using normal reads/writes for the data itself.
>> BTW, just blindly making data reads/writes atomic doesn't guarantee 
>> that there will be
>> no race conditions.
>
> What you're saying is covered by the "neither happens before the 
> other" clause below. In our case there are no mutexes, rcu, etc. that 
> make the write happen before the read, or the read happen before the 
> right. So the paragraph applies.

Ok, can we probably return to my initial question:
in the code under discussion: where do you see a race condition,
and how exactly your changes fix it?

>
>>>     The execution of a program contains a data race if it contains 
>>> two conflicting actions in
>>>     different threads, at least one of which is not atomic, and 
>>> neither happens before the
>>>     other. Any such data race results in undefined behavior.

