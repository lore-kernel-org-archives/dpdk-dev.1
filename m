Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B9B606A31A
	for <dpdk-dev@archiver.kernel.org>; Sun, 25 Oct 2026 10:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=l1sl1vw1
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15D5E402B9;
	Sun, 25 Oct 2026 11:25:03 +0100 (CET)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by mails.dpdk.org (Postfix) with ESMTPS id CF5424025F
 for <dev@dpdk.org>; Sun, 25 Oct 2026 11:25:01 +0100 (CET)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-48e3b22e971so854394f8f.0
 for <dev@dpdk.org>; Sun, 25 Oct 2026 03:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792923901; x=1793528701; darn=dpdk.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=tjV3HmNJgDHA2xJ4Z6zsHSdEpkYmCj5581SiGegxWH8=;
 b=l1sl1vw1VYoGE6BtFWTEuF5YxKD4xvpAMBTyke2/guQ+T1DPaTzatF7qAJMtWVHAK7
 N4oY/eH4UAAXeCDGeDVYeqyG+Y3CoZRVN06EVCmqwPrhnDn5r7my1AGShBiHfEpQwg9T
 /3mIoE4fGSou8sEWl3zrvQCOiFFUPmLhUJl8K9pIUYTAL5CTvnFB8jSLxe4SQ12L3usB
 4Dy8LcC4oVjP6XBfEiEhhVdttU4VHCjWoyaJxTetjULBxQRosrWi6KS4VJO18BTFMux/
 /rLYj5C85CWZ+V7JyXK9pDQBYhvpY1TnW7AwzJ5suiF8b+su+gSuDOXSh//i4kpTfEUw
 7XnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792923901; x=1793528701;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tjV3HmNJgDHA2xJ4Z6zsHSdEpkYmCj5581SiGegxWH8=;
 b=gKbT8RE6SUvl8+QoLMxIc0rVQcLegVM/qO0kSAsFSll3ggqnl0fXtHIb8Ju8Q24kqf
 MmjCpq9XuHqy9M2inl8NF5B4twDqUgARBy/9mktE0I/sVp2XRcVGPfw5/JRkdjcJRxV/
 vBDPZ6uAqfg9/94SunFz5ETE4lCBy0iRzxRR+jmeYcK/QKqhjcEFPRdGb+s+GyWv2uAg
 s9EG8EF96uTR39t9ZHIuE5MNMUdGFb0mdWoljnGL2qpxrT/flRpT1ZO0Lq+gvPoRY8AQ
 b1ozEbbqgeZbTYM3pBiooHVJktJJA28YLQFCtFf5fGKaxaVTujfUyNMSjTXrgOzcbPvq
 EewQ==
X-Gm-Message-State: AFq9FYIqnhcP76odz5n5ctXF/ZbTSE8pP5C58jjKYDa29PAosIsTTw8C
 ucafIZgIao9oVhxseIjXaHx2D633qCxud9q1xbv/ixYGnlu0vdXIJQ13
X-Gm-Gg: AYBFou0/bapMYtxPDPPVSsagyfCjK/E4OTsoMcQJ+aK6KNLPWeRGkcQEoWjuyFoVXRw
 07IhmKPETwm9hjOfuUKvb4/FPRea7SrQsBVoykoqs8WzMU5BqGydy34qWe6BfQGqGJPUXgZS+Yz
 tMYwEww5F4ICrJRl1vzOaDwa4z3jmV2AXaxLXkhErvsID5uK1IoHSAfjH+4wp6xXvOOSQ6lDL+G
 W3G+agTbVipzsto2p0uiMZXCt2UYjEJ1Mu88QaFgx9VwK7cLDsSP/RD0976SxvSjp6Lo51oNwX3
 Luh+I9ucJspHlC8PftLn4CsSuCaBit+fnAmuLIzYue2cr4l21AepbmNwHZ0oOg5FY3iRP6JbRwV
 qc6s5ceTbtyFpggpX021TX4E8AGXc80CXEJYaflcyBBH8Q2Y0aCMddANQQzuSHm8zeCdyqzA8QE
 PYToGX6oB+/ibjpOqOyGHR4Mk6sjY0DZD8V/jBBjU/EkHjnFVA7eT2ZLYp4JxMNkpD8iXGQF5jJ
 2em/QfdReItopO9ktl2Ifc+FBE1GdNB9DN3+9+LoL7Zer/LZQY=
X-Received: by 2002:a05:600c:190b:b0:4a5:cfc:1e95 with SMTP id
 5b1f17b1804b1-4a50d0b6418mr29303275e9.33.1792923901182; 
 Sun, 25 Oct 2026 03:25:01 -0700 (PDT)
Received: from [192.168.0.78] ([80.233.35.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a59d238sm104890185e9.14.2026.10.25.03.24.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Oct 2026 03:25:00 -0700 (PDT)
Message-ID: <3b8e6fc9-b747-4d52-a4ba-f4803bea04ce@gmail.com>
Date: Sun, 25 Oct 2026 10:24:58 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] bpf: simplify callback inuse tracking to boolean
 flag
To: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: dev@dpdk.org, stephen@networkplumber.org
References: <20261011182158.124246-1-qm2k21@gmail.com>
 <20261012210917.161343-1-qm2k21@gmail.com>
 <20261012210917.161343-6-qm2k21@gmail.com>
 <8f751b5c-941e-467f-b4d8-6d65e2b0db5b@yandex.ru>
 <f4539ddf-2893-4c36-b327-3eadd72ab057@gmail.com>
 <5b66ff13-47f0-46e6-82ed-df4034e31bcc@yandex.ru>
Content-Language: en-US
From: Marat Khalili <qm2k21@gmail.com>
In-Reply-To: <5b66ff13-47f0-46e6-82ed-df4034e31bcc@yandex.ru>
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


On 25/10/2026 07:40, Konstantin Ananyev wrote:
>> On 19/10/2026 21:50, Konstantin Ananyev wrote:
>>>> The even/odd usage counter semantics in struct bpf_eth_cbi was
>>>> originally used to detect when in-flight packet callbacks complete.
>>>> However, with at most one thread running the callback per port/queue
>>>> pair and no risk of the ABA problem, a boolean flag (true for in use,
>>>> false for idle) suffices.
>>>>
>>>> Change member use to bool and replace the counter increment in the
>>>> datapath with stores of true and false. Simplify bpf_eth_cbi_wait()
>>>> to a direct pause loop waiting until the flag is false, removing the
>>>> now unnecessary RTE_WAIT_UNTIL_MASKED macro and casts. Update the
>>>> documentation and synchronization sequence diagram accordingly.
>>>
>>> As I explained in previous mail, it is not about even/odd.
>>> It is about waiting while current 'quiscent' period will end.
>>> By 'simplifying' that to use just boll values (0/1) you introduce
>>> a live-lock in CP: it can be blocked for very long time waiting
>>> while DP thread will keep processing packets.
>>
>> I do not think this explanation is correct. It was always waiting 
>> only for the next value after the odd one, there are no cases where 
>> anything else happens.
>        /* in use, busy wait till current RX/TX iteration is finished */
>         if ((puse & BPF_ETH_CBI_INUSE) != 0) {
>                 RTE_WAIT_UNTIL_MASKED((__rte_atomic uint32_t 
> *)(uintptr_t)&cbi->use,
>                         UINT32_MAX, !=, puse, rte_memory_order_acquire);
>         }
>
> Here, we are waiting when 'puse' will become not equal to 'cbi->use'.
> So, any value except current puse is good.

If you look a the sequence diagram, there is no way to arrive here 
without the callback being removed and `cb` cleared in the DP thread, no 
matter how you move the arrows around. So the DP thread will increment 
`use` once to make it even, and then will never ever reach the callback 
or increment anything again. We allow any value except current puse, but 
there are never any values except the current puse and the one after it. 
It's just these two values we can possibly see.

