Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CE7606A31A
	for <dpdk-dev@archiver.kernel.org>; Sun, 25 Oct 2026 10:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XMX3Gw4e
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 38C55402B9;
	Sun, 25 Oct 2026 11:57:23 +0100 (CET)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by mails.dpdk.org (Postfix) with ESMTPS id 689354025F
 for <dev@dpdk.org>; Sun, 25 Oct 2026 11:57:21 +0100 (CET)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso8203495e9.0
 for <dev@dpdk.org>; Sun, 25 Oct 2026 03:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792925841; x=1793530641; darn=dpdk.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ifsCYDLKTkxKslrREfFhNBJbh8PVUaycv6M0Z0MFseQ=;
 b=XMX3Gw4e18Udkjq3qkp9SnIvlTtmja2tlsupwoVsC1wJUuowsvxsn4LAaS/pu5yck3
 iI9Ts/GpeZOlz9baqaBlB3YvP86wMP7YyEd0NxqAJcpjYadK4WEzSYkQGFE2mHKsxEUu
 9K9TAXIrs2cmx5vlT+/zE+vhd9AjXWh4Vgi5xG+4h2q+D1D3eQVCLE5iS6ArI7LrzMqA
 rJW2JzhAweTzZ0leQdELQl8z/in0KeVzpq6uLageM+3gJXa9IBk7Yv8hffohoWzDK+tp
 by1jnKErExRE8+a/1lYZAw6sFcHe+l4ydkSEh978QxUK6gXNQYataLvdAthH/4d4CJMv
 LkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792925841; x=1793530641;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ifsCYDLKTkxKslrREfFhNBJbh8PVUaycv6M0Z0MFseQ=;
 b=fB2cZ9PQpO3XHZ/ouN+fFDoAihJvDRRrimcBjRqJxUvugGX7LXhEHT9+YaM9INks96
 wg/oQT7JHBrJzYxnrg3PMTBWTpBoN036A7t+tihCUz6jcVN9NxRG/NwgKRaAXh/KFwhv
 K1X2LLBAPRy3K6IK/B+NFHHEsOAjDwV4i6S49mcaDHoHcWTCya6JFIRpmM7V31NZocyQ
 LJYiIIPpOOnnKL4r81EU4kn5lj+7QyWM5i0n5bC1BKBCXtB0dmRYIXXA2Jw4+jXbV9gv
 y5O6bCWdtv/4eugmcrdrKvzsUUAZcVsOYktAy1Iw0uneDl2h6UzSGy3doKrd2YXpHNzp
 M/6Q==
X-Gm-Message-State: AFq9FYIVH6krR5QfMxZX5QBdg+qJJb2M6wXl9UsZ7tPUSzmnEaETFlqS
 tQUR2dX1hoqP+4ltQWWfHmLgjfjmbohzXMbjXRreCxzyeb9Qs/lkXior
X-Gm-Gg: AYBFou2XDZd+1EwGW+WV+qza+xDvbiBRPACt/9kd7vsbtk2Fg1R4+ocf7t27Ai5M8A1
 ySce6wvC51Na2tpTAPuUSyFJSNVCrlnN/LzkjU2oAJ30jI94tOsWWIri/OsVAEt+EVyh3vJGO/C
 Ilu3oCwml356niCCHixHYvzlmVcuPZCpKR5kVhl6cv3bVInD/yJMZfrMeeYqwMr48UmI/bG4gM9
 n2sBRrEe5Z3msiwiq5+EllE/rPQmadtpO61KpRaMZ8aXy/9nIkCErRDivM0famihhAuOzDyVf4Q
 PYLsA2i1Fg0yeYRghZKSpdfPHvBPrq/E1r+TO61A25a3oyXGUbnJZdFZxSckzHRByxwIu9A5Zop
 zFjUeDfaT3Xta5gAyoIwTXWXVBAjrHexIwhZVUrh/ARQ+HDtR2cBv+zCT/xUNVOBaZ9PO9gILue
 fk/wwcU64tViTpeA9Cy8E3j3daQ4PmTilO4pXZPQNwBIy7PuFKTboXrvdiD0RKNIBuExDFoMMdo
 zthop3X5spJ6ro5fVga99dZXbCI+TYiYDRhljlY14kzruaelB4=
X-Received: by 2002:a05:600c:3553:b0:4a2:fd2:985e with SMTP id
 5b1f17b1804b1-4a35aca7809mr74632335e9.17.1792925840879; 
 Sun, 25 Oct 2026 03:57:20 -0700 (PDT)
Received: from [192.168.0.78] ([80.233.35.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e412cc164sm8761793f8f.7.2026.10.25.03.57.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Oct 2026 03:57:20 -0700 (PDT)
Message-ID: <17533e64-a27d-422e-b7ca-13926429cfde@gmail.com>
Date: Sun, 25 Oct 2026 10:57:18 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] bpf: make callback handle atomic with relaxed
 access
To: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: dev@dpdk.org, stephen@networkplumber.org
References: <20261011182158.124246-1-qm2k21@gmail.com>
 <20261012210917.161343-1-qm2k21@gmail.com>
 <20261012210917.161343-9-qm2k21@gmail.com>
 <52dfdbb3-76a4-4cd4-a789-d864156b949e@yandex.ru>
 <a6c2138a-d029-4fd3-8296-dca57b319f18@gmail.com>
 <25c95d28-b393-4063-9b94-064b281812b9@yandex.ru>
 <339ca0fe-acec-4e15-9a02-10a9753f69ba@gmail.com>
 <9aaf7648-173b-468f-b782-bf9cc90c3cbd@yandex.ru>
Content-Language: en-GB
From: Marat Khalili <qm2k21@gmail.com>
In-Reply-To: <9aaf7648-173b-468f-b782-bf9cc90c3cbd@yandex.ru>
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 25/10/2026 10:53, Konstantin Ananyev wrote:
>
>>
>> On 25/10/2026 07:44, Konstantin Ananyev wrote:
>>>> It follows from the standard (5.1.2.4 Multi-threaded executions and 
>>>> data races):
>>>>
>>>>     Two expression evaluations conflict if one of them modifies a 
>>>> memory location and the
>>>>     other one reads or modifies the same memory location. [...]
>>>
>>> Well, that's why people invented different synchronization methods: 
>>> mutexes, rcu, etc. :)
>>> If you want to protect your data against data-races it soesn't mean 
>>> yopu have to make
>>> all your data  reads/writes atomic - you need to select a proper 
>>> sync mechanism around
>>> it, so you can keep using normal reads/writes for the data itself.
>>> BTW, just blindly making data reads/writes atomic doesn't guarantee 
>>> that there will be
>>> no race conditions.
>>
>> What you're saying is covered by the "neither happens before the 
>> other" clause below. In our case there are no mutexes, rcu, etc. that 
>> make the write happen before the read, or the read happen before the 
>> right. So the paragraph applies.
>
> Ok, can we probably return to my initial question:
> in the code under discussion: where do you see a race condition,
> and how exactly your changes fix it?
I see undefined behaviour according to the definition below. This 
definition depends on actions "at least one of which is not atomic", so 
making all the actions atomic removes one of the conditions for the 
undefined behaviour, making the behaviour defined.
>>>>     The execution of a program contains a data race if it contains 
>>>> two conflicting actions in
>>>>     different threads, at least one of which is not atomic, and 
>>>> neither happens before the
>>>>     other. Any such data race results in undefined behavior.
