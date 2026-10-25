Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3562B606A31A
	for <dpdk-dev@archiver.kernel.org>; Sun, 25 Oct 2026 12:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=ExeBS4+N
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 162E6402B9;
	Sun, 25 Oct 2026 13:38:45 +0100 (CET)
Received: from forward501d.mail.yandex.net (forward501d.mail.yandex.net
 [31.44.14.17]) by mails.dpdk.org (Postfix) with ESMTPS id AAAE24025F
 for <dev@dpdk.org>; Sun, 25 Oct 2026 13:38:43 +0100 (CET)
Received: from mail-nwsmtp-smtp-production-main-58.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-58.yp-c.yandex.net)
 by forward501d.mail.yandex.net (postfix) with ESMTPS id 4FED181087;
 Sun, 25 Oct 2026 15:38:41 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-58 with ESMTPSA id
 bce1wuYdO4Y0-KKrIIxgm; Sun, 25 Oct 2026 15:38:40 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1792931920; bh=49vPgHl/41RFEMt0a54IyqySNbyH7xvwTjaMNuWgvds=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=ExeBS4+NOVeWycZn82U2Pvr/N5b4n9bj1QmDX6uhy6Iea77Fp2F4Ms7unrSJxVxIT
 CBrCz/+6fRN/0928Qf2aLPi2FhtkoZR8W4oGJ5FLuH1R2ZW9OFl/t8XWA85Mnn/rJ4
 9AmI6Za+YWJ9uIT/zW98difiU5uWRtZiYgYr8LYE=
Authentication-Results: mail-nwsmtp-smtp-production-main-58;
 dkim=pass header.i=@yandex.ru
Message-ID: <e889a968-3a42-4b80-8fba-85e79ca1592e@yandex.ru>
Date: Sun, 25 Oct 2026 12:38:37 +0000
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
 <e564b858-832e-492e-9e1b-3fd2a254c30b@yandex.ru>
 <8f9739ce-ad47-48d4-9a62-e4280b42bfd8@gmail.com>
Content-Language: en-US, ru
From: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
In-Reply-To: <8f9739ce-ad47-48d4-9a62-e4280b42bfd8@gmail.com>
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
> On 25/10/2026 10:50, Konstantin Ananyev wrote:
>>>>        /* in use, busy wait till current RX/TX iteration is 
>>>> finished */
>>>>         if ((puse & BPF_ETH_CBI_INUSE) != 0) {
>>>>                 RTE_WAIT_UNTIL_MASKED((__rte_atomic uint32_t 
>>>> *)(uintptr_t)&cbi->use,
>>>>                         UINT32_MAX, !=, puse, 
>>>> rte_memory_order_acquire);
>>>>         }
>>>>
>>>> Here, we are waiting when 'puse' will become not equal to 'cbi->use'.
>>>> So, any value except current puse is good.
>>>
>>> If you look a the sequence diagram, there is no way to arrive here 
>>> without the callback being removed and `cb` cleared in the DP 
>>> thread, no matter how you move the arrows around.  So the DP thread 
>>> will increment `use` once to make it even, and then will never ever 
>>> reach the callback or increment anything again. We allow any value 
>>> except current puse, but there are never any values except the 
>>> current puse and the one after it. It's just these two values we can 
>>> possibly see.
>>
>> DP can (and most likely will) call rx/tx_burst again.
>> Just to give you an example:
>> --- DP thread:
>> cbi->use = 1;
>>                          --- CP thread:
>>                             read cbi->use (1)
> By this time the callback is removed and `cb` is cleared.

from CP thread perspective:
  a) bc->cb is removed from ethdev callback list
  b) bc->cb = NULL
But there is no guarantee that DP thread will see these changes till next
bpf_eth_cbi_inuse()->rte_atomic_thread_fence(rte_memory_order_seq_cst);
So it can still (at least once) invoke bpf callback and read and update 
cbi->use.

Thinking about that once again - it seems that could happen only once
(i.e. in that example CP thread will see just one of {1,2,3,4} after 
that point.
So I probably was too pessimistic about 'live-lock'.
But anyway, I don't see any point to change existing code to what you 
propose (boolean value).
 From my perspective it doesn't make it safer (or faster) in any way.

>> --DP thread:
>> cbi->use = 2;
>> ...
>> next rx burst:
>> cbi->use = 3;
> How did we reach hear if `cb` is NULL?
>>                 read cbi->use (3)
>>
>> So CP sees an odd value (3), but it is ok to proceed, as previoud RX 
>> iteration (quiscent period) had already finished,
>> and in new one rx_burst will not see removed call-back.

