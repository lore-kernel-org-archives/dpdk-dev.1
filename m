Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCD2606A31B
	for <dpdk-dev@archiver.kernel.org>; Sat, 24 Oct 2026 14:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=APMNMRyz
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E3A240269;
	Sat, 24 Oct 2026 16:10:18 +0200 (CEST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id 6A4454021F
 for <dev@dpdk.org>; Sat, 24 Oct 2026 16:10:16 +0200 (CEST)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so3776665e9.2
 for <dev@dpdk.org>; Sat, 24 Oct 2026 07:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792851016; x=1793455816; darn=dpdk.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=aBDM4AjOKMRcEllMHEZDWOG3lAkkzMdE2Tx/Czg6xAQ=;
 b=APMNMRyzNuX3zen894f/qQB7HablNvTmV9MvaGVAN7IKMsyCLZkyMEtZUprXLE3UcR
 uoaQlCkodqkWWUFWB/vF6BVRU0cj2bbBliTbpKhYkISb2RtnwlPzMeMLNiau+CglJXW1
 KFYK9OOO4D5qWwFiMAEQAoiJI+ku4FGv4RSHGgCxLmVANSF90gEGNaaR4Cmgd2YTZS3k
 1BRe+nXsiB6SAlqlQxpW6dW61Y+N3ppW9LSk3ieYf257Oq5HkhCMfTh7h6p0LDsydytc
 IFl14A4RcsCcNaDVZaJMXmoGjivd5wLJTFPuZ9q9ukzu3t4kaPMKWKJt8QqZUu8JpTQU
 0ugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792851016; x=1793455816;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aBDM4AjOKMRcEllMHEZDWOG3lAkkzMdE2Tx/Czg6xAQ=;
 b=VQTGMKKSy+q6twa4YNKZ9PtZ7k8iCtisg6tIuxtiMOyeQSlewYkb0wFuBLBUx0+kAY
 ejpjU0dCLsQBHI0jVaGadPjqmmKCq5CL49g4OdpmEjvtMXR/ruoQa3hIs9nAyU3q9A9F
 BtWjPlC2iuXDXjt8VBYQuhotMC+UCx8TJxnR4KYdHgN79ssTQUXOuyoU3NIGkdGPhjVq
 UFsO1cmkMKt7SpQPEJSumkIy1JIe0lgTF+BgpM7tf5Rml3ESaMRdoQkIFEifdiiQ128F
 BTXwgG1zT5B6QBVpseZ2VETQ4TXCwWTQJDJZfy0r9zgjwx2aPG4lR5nVb03jJPSSKrcv
 ARrA==
X-Gm-Message-State: AFq9FYINUA4V5iNQ4rXeHqrtvy8xB5QjSZi2BEGcEI4Yi5p0+EMLVjdM
 J9PSa8xay3gwX4l3Dz2ob3oINV60wIAt4MvwZHSOz02DgjeDYHnDhVif
X-Gm-Gg: AYBFou1vGOQrveJvrQ7h+tSl1i5uaSXzuNRYLdhhl0zRhWRaOQttnq3izi5jdvZTFV7
 mIODweeeOWqfq4LW9mzJRJoUOIvVhJanL5GoB3PDrJhqfu2lBfBL+q3iLvDtCdNYZXE4Q+JI+Rf
 6Ul/gxfzfrE/39HlSayFEqzK1SfISD9BPJwRunmyKyJ1ukoxMBUnUVbnmYq/KxZVVBcIPWyx3AK
 ZLwlMuCSi3Ri30345VBLMEyH9976LRiKjQY6saheuKSAjhfBtIx58ELA+RQfcg3AKpZmNSG5LDU
 DSl2INmouA1SS/42589o+TcJk4uk4hU18NV+4+sJh6cvRWQocWOkgFP7ul53ZORffcSElT/He1Y
 TMJ6iU4W6HL9Pq5/WN0MX8Ve+4FxwQxeNZdSlhF8M/4xIhJfUF+9/9VJVR7W1ngEhzcehMoDplD
 W6qwHlgHvbXMgp5innPHmTq4xfadRLDEfSVy5XB0JB1R2OABrB9/nRXl8awqVGh1rrmVL42+rQ4
 kpZjH4ckSMrztPBhUCB/Kb44zmZpPXDuiZbwo5Hftam2FZbdMrwsiluQa3Ad9//Qchh4mF7EA==
X-Received: by 2002:a05:600c:3114:b0:4a3:5a55:f454 with SMTP id
 5b1f17b1804b1-4a35acc772dmr31576645e9.19.1792851015943; 
 Sat, 24 Oct 2026 07:10:15 -0700 (PDT)
Received: from [192.168.0.78] ([80.233.35.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a0bb112sm62286305e9.8.2026.10.24.07.10.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2026 07:10:15 -0700 (PDT)
Message-ID: <0309fc87-3912-41b1-8b38-7aa581bf07e3@gmail.com>
Date: Sat, 24 Oct 2026 15:10:13 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] bpf: document ethdev callback threading limitations
To: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: dev@dpdk.org, stephen@networkplumber.org
References: <20261011182158.124246-1-qm2k21@gmail.com>
 <20261012210917.161343-1-qm2k21@gmail.com>
 <20261012210917.161343-3-qm2k21@gmail.com>
 <e5ff5f2b-de4c-48a7-bc0d-3a7392bb6e1a@yandex.ru>
Content-Language: en-US
From: Marat Khalili <qm2k21@gmail.com>
In-Reply-To: <e5ff5f2b-de4c-48a7-bc0d-3a7392bb6e1a@yandex.ru>
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
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 19/10/2026 22:10, Konstantin Ananyev wrote:
>> Document the data plane limitation in the file docstring of
>> rte_bpf_ethdev.h: packet callback execution expects only one
>> thread per port/queue pair at a time, making concurrent bursts
>> (such as with RTE_ETH_TX_OFFLOAD_MT_LOCKFREE, shared RX queues,
>> or multi-threaded software PMDs) unsupported.
> Not sure what do you mean by:
> 'shared RX queues' and 'multi-threaded software PMDs'. Can you 
> probably clarify?

I mean any hypothetical solutions that call rx/tx burst concurrently 
from multiple threads or processes. To avoid confusion, will just leave 
only an RTE_ETH_TX_OFFLOAD_MT_LOCKFREE example in the next version.


>> diff --git a/lib/bpf/rte_bpf_ethdev.h b/lib/bpf/rte_bpf_ethdev.h
>> index 686fda8d94..cf3b4048f0 100644
>> --- a/lib/bpf/rte_bpf_ethdev.h
>> +++ b/lib/bpf/rte_bpf_ethdev.h
>> @@ -10,8 +10,12 @@
>>    *
>>    * API to install BPF filter as RX/TX callbacks for eth devices.
>>    * Note that right now:
>> - * - it is not MT safe, i.e. it is not allowed to do load/unload for 
>> the
>> - *   same port/queue from different threads in parallel.
>> + * - in the data plane, it expects only one thread per port/queue 
>> pair at a time.
>> + *   Calling RX/TX burst functions concurrently on the same queue 
>> (e.g. when using
>> + *   RTE_ETH_TX_OFFLOAD_MT_LOCKFREE, shared RX queues, or 
>> multi-threaded
>> + *   software PMDs) is not supported.
>> + * - in the control plane, it is not MT safe, i.e. it is not allowed 
>> to do
>> + *   load/unload for the same port/queue from different threads in 
>> parallel.
> AFAIK, all CP ethdev API is not MT-safe.
> Not sure there is a reason to put it here again.
> If you believe it is, then probably worth to mention that it follows 
> ethdev CP API convention.

I actually think the CP is safe now due to the spinlock, but I was wary 
of removing this pre-existing phrase. Since you support removing it, I 
will remove it.

