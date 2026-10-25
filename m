Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99104606A31E
	for <dpdk-dev@archiver.kernel.org>; Sun, 25 Oct 2026 10:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D3Br0ydE
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9FE0A402B9;
	Sun, 25 Oct 2026 11:15:02 +0100 (CET)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by mails.dpdk.org (Postfix) with ESMTPS id 509824025F
 for <dev@dpdk.org>; Sun, 25 Oct 2026 11:15:01 +0100 (CET)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-48e00eee27dso1302599f8f.0
 for <dev@dpdk.org>; Sun, 25 Oct 2026 03:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792923301; x=1793528101; darn=dpdk.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lYjc+aAP4DYhgjmB4HNqlz+8Er8ngGVYXAMQWWXpCiY=;
 b=D3Br0ydEnOIz4Cpxv3Znd0lnFgXsdzC8Ev3/tcZqRzTEtXmS53elub10HV0dHn42Hh
 G+LtBIje/rLxZnxCkS1dYBAAMN7I/lZjo0pJWBekdqQLFKSXDEy/Jmsbjth+wvybhkyA
 PbuMQkk+ELuFNTIthoXrEWxoWEwzL321stu9TLesMQ2u/C+ZZrm5T4F6kDRFAsNynpyH
 v0exZyCq56e0xoY2uPe9FYgOEp9gwvSGfdRrEV5iAX98J4l03VJrci58JcWULqrKAVre
 r0FpgNmUJt4Kh6WRMK3+GXPGdMgvZLfwZASX2UTpB3r3En6ttWEJ+I/9rFxFifny6Zqo
 kvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792923301; x=1793528101;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lYjc+aAP4DYhgjmB4HNqlz+8Er8ngGVYXAMQWWXpCiY=;
 b=G3G64fLgs6dDj4JED/2IyTyThwO8QhznDh87VOjq7OTBlvRNy9L5E2pukvFP7FaTC1
 o8kk/UOXtBSOQv4AmceFM4FYb69N5XJNJ30wtNsAOqoP5sIgLbPEcrX3vqQSyEKGpTgC
 LurpwUPWva/1HKhvbd1OrnAe65vPQ9hAh4smk88pQmJxZd4LIGlUv2tXDZbKeXkvw3XY
 X9QJZtip7ZoITLlvYxO4F82xdtI+/knuzVK5pXSfaDKQCqH2MK1y8mqCqyqcjsIVPmRh
 sw+Yi98YD8SP56LYFjtpMb1fA/tpTvG3vtiDaW0gL6XbRj49d5cn2GCKpCrfkyMm4+Ny
 e/nA==
X-Gm-Message-State: AFq9FYKgzee8u0jgc+VSUlEJqdat/ce+bYlmv9G/E2LKu8JWrUTcuGtz
 M2xkBqqiEMoQMXcWLcUepuoB9XF0EPvGy0fTEmmYgJzQfrm6CldaoFe2
X-Gm-Gg: AYBFou29gR2TI6UsAZMR1CQeInHU7YdtbOY0kyKYfp6eWIuS4CYhnt7iXnIDrm+UsGa
 7JfkhjW2dE/HXnfwfXoJE1FcAy6stCiQS0xllVNQ5zmYWgR6ykvO5xN84v12XueRfSDdKYZgkML
 KxH9oULbodw30J0+QSw+3aQesng+IZ7t7qYtF2x5bCtCsqlPfk7uQcOH7Jy5/1kV2wP1G1I/Ea8
 KXMokHsoSF7dkA8OiXVwI9MOgOI2A/iVYu2vbOMJUCXooGL05/jewGoEsKQNRxNnduHx6SK/Nr9
 jmIa91p9EttRZapHgsjAdDY59QVHnT+7Ja5izRRpC5IDq8FPC4hRuFTALn364wamh++5UR2sb52
 axjt/l99TVw6G2iO1qcXwk4/iZbyo/dluwLfawpxtKZ3DKIh6oR7FAH0MwlwjAhB6k1DbvI1l5d
 m+eqbM7be1cllRPIrhzEyoSAYQy+Q28LUHvoCH9RgcBXd6DGDHBkgr2ofctYJx8Bd2WxJ1IFC74
 Uo2I3jNK8CPAIE6RFp4K9XX32bbwtXoWF7lIIyeItPxyDn71ogBm69/btV8+Y06itqlI0kv
X-Received: by 2002:a05:600c:3544:b0:49f:fd40:80fa with SMTP id
 5b1f17b1804b1-4a35acc6b74mr72288365e9.34.1792923300599; 
 Sun, 25 Oct 2026 03:15:00 -0700 (PDT)
Received: from [192.168.0.78] ([80.233.35.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3eb8f36asm9476185f8f.1.2026.10.25.03.14.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Oct 2026 03:14:59 -0700 (PDT)
Message-ID: <339ca0fe-acec-4e15-9a02-10a9753f69ba@gmail.com>
Date: Sun, 25 Oct 2026 10:14:58 +0000
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
Content-Language: en-US
From: Marat Khalili <qm2k21@gmail.com>
In-Reply-To: <25c95d28-b393-4063-9b94-064b281812b9@yandex.ru>
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


On 25/10/2026 07:44, Konstantin Ananyev wrote:
>> It follows from the standard (5.1.2.4 Multi-threaded executions and 
>> data races):
>>
>>     Two expression evaluations conflict if one of them modifies a 
>> memory location and the
>>     other one reads or modifies the same memory location. [...]
>
> Well, that's why people invented different synchronization methods: 
> mutexes, rcu, etc. :)
> If you want to protect your data against data-races it soesn't mean 
> yopu have to make
> all your data  reads/writes atomic - you need to select a proper sync 
> mechanism around
> it, so you can keep using normal reads/writes for the data itself.
> BTW, just blindly making data reads/writes atomic doesn't guarantee 
> that there will be
> no race conditions.

What you're saying is covered by the "neither happens before the other" 
clause below. In our case there are no mutexes, rcu, etc. that make the 
write happen before the read, or the read happen before the right. So 
the paragraph applies.

>>     The execution of a program contains a data race if it contains 
>> two conflicting actions in
>>     different threads, at least one of which is not atomic, and 
>> neither happens before the
>>     other. Any such data race results in undefined behavior.
