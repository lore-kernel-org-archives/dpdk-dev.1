Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4AF606A31A
	for <dpdk-dev@archiver.kernel.org>; Sat, 24 Oct 2026 14:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=U1R8m36d
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4FA8240269;
	Sat, 24 Oct 2026 16:14:55 +0200 (CEST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id A7CC54021F
 for <dev@dpdk.org>; Sat, 24 Oct 2026 16:14:53 +0200 (CEST)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4956869750eso10459435e9.2
 for <dev@dpdk.org>; Sat, 24 Oct 2026 07:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792851293; x=1793456093; darn=dpdk.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YXk5taiFRGw01qpRzi/xxAfSEoLfPjVgQDTbgFIRIQ4=;
 b=U1R8m36dGXZXNRsT2pLVT8211cAHZnLKI7+CHd8SX/6zZkzPKP2QG8n623jso7u4gh
 FZT0bHgNz/LikACQpj2gAlEZAu7Wrxj/NaOoyDv2xTpFYRFOpA5mS+JVU0x/L8d5NUy5
 qK9B7SX/BlQeXsn5jNPWUrTZZ1kDmJ7Nfp9KTKm2AnClSFu2Msg5AQ4euRm22UpKEGjy
 N8hA59lp3nVSjMfm52e/Ftl5WCJ7fVZnjZTQMJFTMbEXfdl5a/9tySNsXMYiy2dAeCyn
 RpRXDXy/+2gBq9Vl7LIXxuT1TaLUFDmhSuBYP8L3EqEOkGcaf9W1Uvlxz7X0BNfZzinM
 l4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792851293; x=1793456093;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YXk5taiFRGw01qpRzi/xxAfSEoLfPjVgQDTbgFIRIQ4=;
 b=uN4gkS7BAWwQk7gbW/y9RtJ+hMMPCXK0pIv3KLWyxm7URpjxU0foYRpQM2Rci+7ivg
 IkxsfhtLIb8/sZYckWjHaQSMAXNJJ6yA/hE6DGV6jxhzWI/pHNu5oBJnx/g/rVAzMpTm
 B5heHCCSacejl+SLWFxzpeFcr601gOitkKAqE8CB30LepA2FVsm64j96y2THMZvEg+uJ
 84wDbJnRJC9Hrr4+V0oKGHBa5UeJ5LWRMe87QCYlmmG6rkqyrjYUdUfTGvsf33P8NS+w
 auW4HSOG1hs96jA8Nev+W3seZdvkNc30G4T+42cUkvHGF6MQcSbCR1ntHiZpnh8tFdkt
 IfaQ==
X-Gm-Message-State: AFq9FYIxBvu+yc0G0lb4KDiMLbEgaHSz46euFcI5hjqBk0BjsOUUQZyB
 PnIPLHMTLzu6+2HqBxEnm3IiFBUL9bW9z/rsu13NqYgi9cyqK2d5YZ7T
X-Gm-Gg: AYBFou1XkFz+q4VNb0zy2RcAHJhz5gmYdgjs/YU8wYEIa5pUeGmeckfj7zJez1Myj7e
 qcNMECIRDFBUROUQO6OOFNBF4BX5UQriGzMsi1LdctrrQbEGMwfGSwbRot6fOclEUCOP7q+nu96
 T94LqQo2Z/kIhCqpyQsioy/0kWBFXdpWFZ5zms9mRrkyfycxRnWPN/e14MrnImfCDO2UxlEsYlG
 WEU993G5laBchc5mP50QZKNOQRvUOj1BPIasAnvs6MriWFqAFJPN/no39uWLGaGT0PCIG7KidyE
 wkoYdGWm6Yr15HH/JE8Fc9fjeBf9hw89gyRo9f9pEyy3G4H7SBeibEZ3NEjXTW8VMHi+4VA7i/M
 vkPRAaNQ265PjcFXg31Dk14BNcIxhggeAZAJqLci+12aeywYD9d/V6in3QChBq43v3S2rV9gq0f
 Ff2JjygoRQm3IHJzYLo+TAgi43ZjbDX0AP8ZsGxHHBYFOr85m93SSwu3BIz7LgNkG+BK++0fr1K
 ire2P0hU/k1MXXGPY6o8nMLkCHjAD+gZ14nLBfDasHLEmha1z8=
X-Received: by 2002:a05:600c:5253:b0:4a2:148b:c88c with SMTP id
 5b1f17b1804b1-4a35ac8ba2emr28614335e9.8.1792851293135; 
 Sat, 24 Oct 2026 07:14:53 -0700 (PDT)
Received: from [192.168.0.78] ([80.233.35.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3dcbsm4568363f8f.14.2026.10.24.07.14.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2026 07:14:52 -0700 (PDT)
Message-ID: <f4539ddf-2893-4c36-b327-3eadd72ab057@gmail.com>
Date: Sat, 24 Oct 2026 15:14:49 +0100
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
Content-Language: en-US
From: Marat Khalili <qm2k21@gmail.com>
In-Reply-To: <8f751b5c-941e-467f-b4d8-6d65e2b0db5b@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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


On 19/10/2026 21:50, Konstantin Ananyev wrote:
>> The even/odd usage counter semantics in struct bpf_eth_cbi was
>> originally used to detect when in-flight packet callbacks complete.
>> However, with at most one thread running the callback per port/queue
>> pair and no risk of the ABA problem, a boolean flag (true for in use,
>> false for idle) suffices.
>>
>> Change member use to bool and replace the counter increment in the
>> datapath with stores of true and false. Simplify bpf_eth_cbi_wait()
>> to a direct pause loop waiting until the flag is false, removing the
>> now unnecessary RTE_WAIT_UNTIL_MASKED macro and casts. Update the
>> documentation and synchronization sequence diagram accordingly.
>
> As I explained in previous mail, it is not about even/odd.
> It is about waiting while current 'quiscent' period will end.
> By 'simplifying' that to use just boll values (0/1) you introduce
> a live-lock in CP: it can be blocked for very long time waiting
> while DP thread will keep processing packets.

I do not think this explanation is correct. It was always waiting only 
for the next value after the odd one, there are no cases where anything 
else happens.

