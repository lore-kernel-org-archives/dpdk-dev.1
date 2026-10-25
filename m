Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E01606A31A
	for <dpdk-dev@archiver.kernel.org>; Sun, 25 Oct 2026 10:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=NaaKfW9G
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB66D402B9;
	Sun, 25 Oct 2026 11:51:03 +0100 (CET)
Received: from forward500e.mail.yandex.net (forward500e.mail.yandex.net
 [93.77.172.85]) by mails.dpdk.org (Postfix) with ESMTPS id 6F5C24025F
 for <dev@dpdk.org>; Sun, 25 Oct 2026 11:51:02 +0100 (CET)
Received: from mail-nwsmtp-smtp-production-main-69.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-69.yp-c.yandex.net)
 by forward500e.mail.yandex.net (postfix) with ESMTPS id D8539C01F5;
 Sun, 25 Oct 2026 13:51:00 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-69 with ESMTPSA id
 wockM3Xg94Y0-e9zMrIRo; Sun, 25 Oct 2026 13:51:00 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1792925460; bh=JnRBJ/+uls3sZlhXiudxHahI9e0VuYpLLp5/T/zsK3c=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=NaaKfW9GcFNWkvCpiIO0i2JqmEzjbmeetyKRpooMLjAvo1tibXIWFtJuTfMDImT7s
 svr/PTH/Im0VHI2Rq0D+IvCIEkJupvMRsOu9YFfRGt7lfwojR3XUsPXXcBvRpPThNq
 af4GDPnZ9fTIi35JbYpdGyyhRH4ToVi99jM6XzOw=
Authentication-Results: mail-nwsmtp-smtp-production-main-69;
 dkim=pass header.i=@yandex.ru
Message-ID: <e564b858-832e-492e-9e1b-3fd2a254c30b@yandex.ru>
Date: Sun, 25 Oct 2026 10:50:58 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] bpf: simplify callback inuse tracking to boolean
 flag
To: Marat Khalili <qm2k21@gmail.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: dev@dpdk.org, stephen@networkplumber.org
References: <20261011182158.124246-1-qm2k21@gmail.com>
 <20261012210917.161343-1-qm2k21@gmail.com>
 <20261012210917.161343-6-qm2k21@gmail.com>
 <8f751b5c-941e-467f-b4d8-6d65e2b0db5b@yandex.ru>
 <f4539ddf-2893-4c36-b327-3eadd72ab057@gmail.com>
 <5b66ff13-47f0-46e6-82ed-df4034e31bcc@yandex.ru>
 <3b8e6fc9-b747-4d52-a4ba-f4803bea04ce@gmail.com>
Content-Language: en-US, ru
From: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
In-Reply-To: <3b8e6fc9-b747-4d52-a4ba-f4803bea04ce@gmail.com>
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



25.10.2026 10:24, Marat Khalili пишет:
>
> On 25/10/2026 07:40, Konstantin Ananyev wrote:
>>> On 19/10/2026 21:50, Konstantin Ananyev wrote:
>>>>> The even/odd usage counter semantics in struct bpf_eth_cbi was
>>>>> originally used to detect when in-flight packet callbacks complete.
>>>>> However, with at most one thread running the callback per port/queue
>>>>> pair and no risk of the ABA problem, a boolean flag (true for in use,
>>>>> false for idle) suffices.
>>>>>
>>>>> Change member use to bool and replace the counter increment in the
>>>>> datapath with stores of true and false. Simplify bpf_eth_cbi_wait()
>>>>> to a direct pause loop waiting until the flag is false, removing the
>>>>> now unnecessary RTE_WAIT_UNTIL_MASKED macro and casts. Update the
>>>>> documentation and synchronization sequence diagram accordingly.
>>>>
>>>> As I explained in previous mail, it is not about even/odd.
>>>> It is about waiting while current 'quiscent' period will end.
>>>> By 'simplifying' that to use just boll values (0/1) you introduce
>>>> a live-lock in CP: it can be blocked for very long time waiting
>>>> while DP thread will keep processing packets.
>>>
>>> I do not think this explanation is correct. It was always waiting 
>>> only for the next value after the odd one, there are no cases where 
>>> anything else happens.
>>        /* in use, busy wait till current RX/TX iteration is finished */
>>         if ((puse & BPF_ETH_CBI_INUSE) != 0) {
>>                 RTE_WAIT_UNTIL_MASKED((__rte_atomic uint32_t 
>> *)(uintptr_t)&cbi->use,
>>                         UINT32_MAX, !=, puse, rte_memory_order_acquire);
>>         }
>>
>> Here, we are waiting when 'puse' will become not equal to 'cbi->use'.
>> So, any value except current puse is good.
>
> If you look a the sequence diagram, there is no way to arrive here 
> without the callback being removed and `cb` cleared in the DP thread, 
> no matter how you move the arrows around.  So the DP thread will 
> increment `use` once to make it even, and then will never ever reach 
> the callback or increment anything again. We allow any value except 
> current puse, but there are never any values except the current puse 
> and the one after it. It's just these two values we can possibly see.

DP can (and most likely will) call rx/tx_burst again.
Just to give you an example:
--- DP thread:
cbi->use = 1;
                          --- CP thread:
                             read cbi->use (1)
--DP thread:
cbi->use = 2;
...
next rx burst:
cbi->use = 3;
                         read cbi->use (3)

So CP sees an odd value (3), but it is ok to proceed, as previoud RX 
iteration (quiscent period) had already finished,
and in new one rx_burst will not see removed call-back.

















