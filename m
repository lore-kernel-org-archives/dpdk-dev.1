Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D79606A31B
	for <dpdk-dev@archiver.kernel.org>; Sun, 25 Oct 2026 07:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=wsJ9/O/a
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC00340275;
	Sun, 25 Oct 2026 08:50:38 +0100 (CET)
Received: from forward501e.mail.yandex.net (forward501e.mail.yandex.net
 [93.77.172.86]) by mails.dpdk.org (Postfix) with ESMTPS id 26D2440269
 for <dev@dpdk.org>; Sun, 25 Oct 2026 08:50:36 +0100 (CET)
Received: from mail-nwsmtp-smtp-production-main-69.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-69.yp-c.yandex.net)
 by forward501e.mail.yandex.net (postfix) with ESMTPS id CCA98C0069;
 Sun, 25 Oct 2026 10:50:34 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-69 with ESMTPSA id
 VoZSubVgCSw0-4voAYvrg; Sun, 25 Oct 2026 10:50:34 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1792914634; bh=VN69FNhH4KuBYbX9NHD+FWnznPMVJZb2nltDgh52//0=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=wsJ9/O/afiWrpf9iL3ukpOXyQT5c4hQmRE6WP2T5JqDpI5x/GQrItO3OJqIVqqOwA
 FSR8bx7mLyC4aLlOeQcIkf3FCT7MM3ZZhe/pG8lh9+qYW3jPMw5D8IudQ37nVmZjg5
 6kXrDEsW9VrrlVx7r78RsV5nhrmuTjzigKeuqU9w=
Authentication-Results: mail-nwsmtp-smtp-production-main-69;
 dkim=pass header.i=@yandex.ru
Message-ID: <5d89ccc5-f05c-43f4-adaf-ef42c7cfa37b@yandex.ru>
Date: Sun, 25 Oct 2026 07:50:31 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] bpf: document ethdev callback threading limitations
To: Marat Khalili <qm2k21@gmail.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: dev@dpdk.org, stephen@networkplumber.org
References: <20261011182158.124246-1-qm2k21@gmail.com>
 <20261012210917.161343-1-qm2k21@gmail.com>
 <20261012210917.161343-3-qm2k21@gmail.com>
 <e5ff5f2b-de4c-48a7-bc0d-3a7392bb6e1a@yandex.ru>
 <0309fc87-3912-41b1-8b38-7aa581bf07e3@gmail.com>
Content-Language: en-US, ru
From: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
In-Reply-To: <0309fc87-3912-41b1-8b38-7aa581bf07e3@gmail.com>
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
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1




>
> On 19/10/2026 22:10, Konstantin Ananyev wrote:
>>> Document the data plane limitation in the file docstring of
>>> rte_bpf_ethdev.h: packet callback execution expects only one
>>> thread per port/queue pair at a time, making concurrent bursts
>>> (such as with RTE_ETH_TX_OFFLOAD_MT_LOCKFREE, shared RX queues,
>>> or multi-threaded software PMDs) unsupported.
>> Not sure what do you mean by:
>> 'shared RX queues' and 'multi-threaded software PMDs'. Can you 
>> probably clarify?
>
> I mean any hypothetical solutions that call rx/tx burst concurrently 
> from multiple threads or processes. To avoid confusion, will just 
> leave only an RTE_ETH_TX_OFFLOAD_MT_LOCKFREE example in the next version.
>
>
>>> diff --git a/lib/bpf/rte_bpf_ethdev.h b/lib/bpf/rte_bpf_ethdev.h
>>> index 686fda8d94..cf3b4048f0 100644
>>> --- a/lib/bpf/rte_bpf_ethdev.h
>>> +++ b/lib/bpf/rte_bpf_ethdev.h
>>> @@ -10,8 +10,12 @@
>>>    *
>>>    * API to install BPF filter as RX/TX callbacks for eth devices.
>>>    * Note that right now:
>>> - * - it is not MT safe, i.e. it is not allowed to do load/unload 
>>> for the
>>> - *   same port/queue from different threads in parallel.
>>> + * - in the data plane, it expects only one thread per port/queue 
>>> pair at a time.
>>> + *   Calling RX/TX burst functions concurrently on the same queue 
>>> (e.g. when using
>>> + *   RTE_ETH_TX_OFFLOAD_MT_LOCKFREE, shared RX queues, or 
>>> multi-threaded
>>> + *   software PMDs) is not supported.
>>> + * - in the control plane, it is not MT safe, i.e. it is not 
>>> allowed to do
>>> + *   load/unload for the same port/queue from different threads in 
>>> parallel.
>> AFAIK, all CP ethdev API is not MT-safe.
>> Not sure there is a reason to put it here again.
>> If you believe it is, then probably worth to mention that it follows 
>> ethdev CP API convention.
>
> I actually think the CP is safe now due to the spinlock, but I was 
> wary of removing this pre-existing phrase. Since you support removing 
> it, I will remove it.

Ah yes, I even forgot that there is a spin-lock :)
Then yes, CP is MT safe too.



