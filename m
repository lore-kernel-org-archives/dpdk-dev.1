Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1A8E9B365
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 11:47:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 99D7F4028C;
	Mon,  2 Mar 2026 12:47:14 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3305C400D7
 for <dev@dpdk.org>; Mon,  2 Mar 2026 12:47:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772452032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=LQz8w/I2X3+f+169GwA0jeSPVZi1tC2bm4DH5f+W2TE=;
 b=B8sDTkmKDrUv/avkzjyYcXGbNeBYEbKq0Q6kr3ce3WHUurQAjh0SBPNB0DEoWYTfrR+jjq
 jBow25HP+A8/a6wTL3qzqtC+ElucIIPh+LSjqPa1okUcARTNTSuKJZzM56vuqm7Hg6Atep
 6xph5p66dOOHEjYZgLditstrv+w0+1Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-XC03B6wxMIaPF-P7-SpYog-1; Mon, 02 Mar 2026 06:47:11 -0500
X-MC-Unique: XC03B6wxMIaPF-P7-SpYog-1
X-Mimecast-MFC-AGG-ID: XC03B6wxMIaPF-P7-SpYog_1772452030
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4836c819456so29880795e9.3
 for <dev@dpdk.org>; Mon, 02 Mar 2026 03:47:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772452030; x=1773056830;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LQz8w/I2X3+f+169GwA0jeSPVZi1tC2bm4DH5f+W2TE=;
 b=fn5hnWDynK6Kepafb7Lh4vAb+VMna3gNfvOKzL7/9eGaLjysfWDkAeUvA8LkawAXNp
 5x8nBDOZjaFt2ucXiIo68FfVZ0ug6/fedrGvGhY5hSJtwcf9uOP7RFp2HCZpberwxuK7
 ItprDAIrBig9orVrV1Na3sxffwavnOLgpiCZk7rRTu1RmES7nSwqwGL4Ig5YZg4Btcx0
 68LeoUp5gbg5TRxPMh2LFl2YxB6yJMXKEJq3uXAKAzmUfw1iBB07CDP9n20SOW+wY7Xi
 0mp2P3Giza7mkcyfF6KVZnQYKXMMJbynikZ/f2cJmOX6I6h1R2WOQrkhnr4LvxJYD8bM
 6/Yg==
X-Gm-Message-State: AOJu0YyQGAqRtdUQp+rytlONVa8aCJPzv+woXVVTJotX0tIBkB7dh+aT
 86uk1wrPih3jZgxJKBZ+3CfiY0y7IoQeSat1ZJHFW3nlDrMN22qkLCyaQdjkERyCQwIM5XFnFtG
 PeyzzlJ/6O8iFBMue130P4OlcvuhcvbVj2DMkdvlFlqoG
X-Gm-Gg: ATEYQzxVtWk3+o0C/K1DUmNMVZMgj7soZKSwQx2/8+WJjdHYl9Jv74bPQYpXScRWHRc
 W042zaOMohqxVS/c9CT8XgCzZyqtLLPS5nIHP/FMY/39Hvcotk4GN7ipKbAfV7xb6fzCTvWTzqH
 IgnZXliBYhgHCQ0iOdUfFxKNrhBCOgCdzKLwypudLTmYOJHDFPBa7M94Hi9G7MJL2L//yg3r+qc
 kABNoHf5qAV2dZlonjGcEoxClRJ8lyeq6GScsLKglXpDafbslA9WqG3Jq5tt3Rp5HqzMCBmN5NC
 DZTJ/WAnmpuc1umd6uXHETr98u2KSDQAoQo9Ks0bLEULjHBC7K8WixcLaHWXYpFGGA/MeP5jUhU
 uLKA3xjW94gWmcb5w+TPU03fN
X-Received: by 2002:a05:600c:630d:b0:477:a1a2:d829 with SMTP id
 5b1f17b1804b1-483c9bdb68emr221730735e9.13.1772452030198; 
 Mon, 02 Mar 2026 03:47:10 -0800 (PST)
X-Received: by 2002:a05:600c:630d:b0:477:a1a2:d829 with SMTP id
 5b1f17b1804b1-483c9bdb68emr221730035e9.13.1772452029740; 
 Mon, 02 Mar 2026 03:47:09 -0800 (PST)
Received: from [192.168.0.65] ([78.16.129.161])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfec1a5bsm159911015e9.29.2026.03.02.03.47.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2026 03:47:08 -0800 (PST)
Message-ID: <95057ac2-2dfe-4d44-af13-0ce7a947f2ea@redhat.com>
Date: Mon, 2 Mar 2026 11:47:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] eal/interrupt: add interrupt event info
To: David Marchand <david.marchand@redhat.com>, viacheslavo@nvidia.com,
 dsosnowski@nvidia.com
Cc: dev@dpdk.org, thomas@monjalon.net, hkalra@marvell.com
References: <20260128122055.192104-1-ktraynor@redhat.com>
 <20260219143852.200722-1-ktraynor@redhat.com>
 <20260219143852.200722-3-ktraynor@redhat.com>
 <CAJFAV8y7F1taC9bP4693x0PcstJxW-E45o0DpV2Mw==YGd2+Kg@mail.gmail.com>
From: Kevin Traynor <ktraynor@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
In-Reply-To: <CAJFAV8y7F1taC9bP4693x0PcstJxW-E45o0DpV2Mw==YGd2+Kg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cozGqFEY4YdAVmvtTbfc9eqOqN8iBpNapUy3qNqE7-8_1772452030
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

On 2/26/26 3:41 PM, David Marchand wrote:
> On Thu, 19 Feb 2026 at 15:39, Kevin Traynor <ktraynor@redhat.com> wrote:
>>
>> Add RTE_INTR_EVENT_* defines and a new API rte_intr_active_events()
>> in order to retrieve them.
>>
>> As the events are in the context of the current interrupt,
>> rte_intr_active_events() must be called from the context of
>> an interrupt callback.
>>
>> Signed-off-by: Kevin Traynor <ktraynor@redhat.com>
> 
> I have mixed feelings about letting this API in the open.
> We only have one user (the mlx5 driver), so I would mark it internal
> for now, and open later if some external user asks for it.
> 

Sounds good to me. I think it's generic enough to be public, but as you
say the only known use at present is for mlx5, so let's keep internal so
we are less restricted if we wanted to change it etc.

> And on the name itself, maybe: rte_intr_active_event_flags() ?
> 

Fine for me, it adds a bit more description.

> [snip]
> 
>> diff --git a/lib/eal/include/rte_interrupts.h b/lib/eal/include/rte_interrupts.h
>> index 1b9a0b2a78..bff4f98f85 100644
>> --- a/lib/eal/include/rte_interrupts.h
>> +++ b/lib/eal/include/rte_interrupts.h
>> @@ -40,4 +40,10 @@ struct rte_intr_handle;
>>  #define RTE_INTR_VEC_RXTX_OFFSET      1
>>
>> +/** Interrupt event flags returned by rte_intr_active_events() */
>> +#define RTE_INTR_EVENT_IN    (1 << 0)  /**< Data available to read */
>> +#define RTE_INTR_EVENT_ERR   (1 << 1)  /**< Error condition on fd */
>> +#define RTE_INTR_EVENT_HUP   (1 << 2)  /**< Hang up / disconnect */
>> +#define RTE_INTR_EVENT_RDHUP (1 << 3)  /**< Read Hang up / disconnect */
> 
> Nit: RTE_BIT32()
> 
> 

Ack. I will update on next version. Thanks David.

Slava/Dariusz, does this address your concerns from previous version,
any other concerns/comments from mlx5 perspective?

