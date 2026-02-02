Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEB8E7DF11
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 17:34:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8AF724027D;
	Mon,  2 Feb 2026 18:34:39 +0100 (CET)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47]) by mails.dpdk.org (Postfix) with ESMTP id EB3FC4026D
 for <dev@dpdk.org>; Mon,  2 Feb 2026 18:34:37 +0100 (CET)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4806dffc64cso36185375e9.1
 for <dev@dpdk.org>; Mon, 02 Feb 2026 09:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770053677;
 x=1770658477; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c/byMa95hA5Vtl1UqxLr2HAogVeq6ef4wf9Rh+jCLVk=;
 b=Ccy88V+g121i5r4XTBjOJT1FX59Cq4vr9guW3oJldnR/GJMs8ZubRYYJeDalDDBBTs
 DqWs7pHHlUQ1yPqYt45D3liow5f8CPFRk7tyUrXbRW25lUS3YywiOhlnK8j3rRQkklm6
 LvjIrubq442nVB+gDJnIrmoclxLQfoW17DoA9T1yww6MF1yLHI9tcG2Y6UGbn3dphvH1
 Dmu9vRWx1nb9Nlz3xEo2tqClpWrd4QOZ24O2epf7YJK0fm94R8udInydlbtPcqaarKYp
 rS0CoTr/r3kg+1BdKCkJufDhY7Acgp3Tl0nCPBNkbqPrqjwSibh+L5+bWb0EDWpKvaa6
 bqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770053677; x=1770658477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c/byMa95hA5Vtl1UqxLr2HAogVeq6ef4wf9Rh+jCLVk=;
 b=RuHC8XbVB4c+gjBegvYjSMraFsG2aCXMDs7Iigj+9tCONHOghAC/LTI5jo+Xw1J8PG
 y5gsw2bcFdII/EYGFLfCwiPZ5LsYeYyOBiwRa0sht+9gHpIDnHPKbq1jqwGGnTx7VB36
 YvBppE8JNnE5vqEd3YOPy4TZ07R1PuZG7l6dRAxtLwZAc/yyDo4df9rcMeEB8bmeDDar
 4ryh6tsmqCTPA5txc3ZqnQz6oUFHNVUthKaOJOyougwKjMuetFghSBTLYOIgBJx/gKP0
 zlHY2BRtmQkpgpDGF4DvH72HuAiYABtCxOeZBnXxvkmZ8wxxwr7R83E6EHH0sXUP3BbG
 5D2w==
X-Gm-Message-State: AOJu0Yx2o+6qODO34slMGtpIntRUmWxBESTkPbV6UYaoEdGpQNJhTm91
 wx1MEy+hM6SFwZgngv00mtwBf1VOH/HIriyKIf7BNOlg7IQK11YXUKVg3R4suGs3kEY=
X-Gm-Gg: AZuq6aJMYjNMq+IDMCF7BWKdgI3Zlj5hH5lyZiYBx2jt1U6payC1CMKVD+MVtODaQ8I
 UqiQ9IdFfnPXI8Vp+6S5e07p/xUrGoIecs3CyjcThxmktFj9w8wW7B6q15dS7iY1+P/fEM0fSb9
 ouLm13ZeD73Cz0/do4AVXCtbVWHMxNVowGKBBZyqjau3ZD1ip1jJXMRlzc/x+4R1rovNX5RwgqQ
 vm5S3pHpPMBBzA9VKY2RLjkPNQ8BqTGPt7X6rLA7c2D309CTymnKr5obkGaf8IRXETzXhHlljwg
 iXN3+LmP9TjB+e0Qk1v8jRDkAxHB8KN+aARPew17ex/mtNxi/FK5+JzUyFxf9YNzBv0DNHEjPln
 WpRPvUg8FLqxNqc84Y/f9KRLNhMvD0Zz2NuKxUtvazmvJ/Rpde6iCyiRibnm2b9H6/PP+mw4OOJ
 FQpAshPYm9mfp2SgZKeqD9t83r9IgAeYagzdydQ33/jNv8ioYHoG7dTm2n8Ug1UBo=
X-Received: by 2002:a05:600c:4ecd:b0:480:3230:6c89 with SMTP id
 5b1f17b1804b1-482db4616damr167429335e9.12.1770053677057; 
 Mon, 02 Feb 2026 09:34:37 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48305129419sm3399515e9.6.2026.02.02.09.34.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 09:34:36 -0800 (PST)
Date: Mon, 2 Feb 2026 09:34:31 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Scott Mitchell <scott.k.mitch1@gmail.com>
Cc: dev@dpdk.org, "John W. Linville" <linville@tuxdriver.com>
Subject: Re: [RFC 1/4] net/af_packet: remove volatile from statistics
Message-ID: <20260202093431.57c1d652@phoenix.local>
In-Reply-To: <CAFn2buDhLQstsTxLyqsK3ZbOJG4ZgOGreKm0Lv7seieBEfJq_w@mail.gmail.com>
References: <20260128173138.151837-1-stephen@networkplumber.org>
 <20260128173138.151837-2-stephen@networkplumber.org>
 <CAFn2buD=1CwnP92LGuj7fGzi_Cujnp8eTV96ZzTNKBjsA6kzOA@mail.gmail.com>
 <20260128130014.0489e0a0@phoenix.local>
 <CAFn2buDhLQstsTxLyqsK3ZbOJG4ZgOGreKm0Lv7seieBEfJq_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Sun, 1 Feb 2026 23:02:53 -0800
Scott Mitchell <scott.k.mitch1@gmail.com> wrote:

> Without volatile, is there any guarantee the consumer thread will see
> the writes from the producer thread? For example, couldn't the
> compiler cache rx_pkts in a register on the consumer side?
> // Consumer thread:
> uint64_t prev = 0;
> while (monitoring) {
>     uint64_t curr = rx_pkts;  // Compiler may cache in register
>     if (curr != prev) {       // Without volatile: may always be false
>       update_display();       // Never executes
>       prev = curr;
>     }
> }
> 
> I created a godbolt comparing different approaches
> (https://godbolt.org/z/1Gaz6jPxh) showing assembly for x86-64 and ARM
> at -O3. Summary:
> 1. Plain load/store: Fastest. No visibility guarantees. May tear on 32-bit.
> 2. Volatile: Provides visibility. May tear on 32-bit.
> 3. Atomic load/store (relaxed): Same performance as volatile. Provides
> visibility and guarantees no tearing (even on 32-bit).
> 4. Atomic_fetch_add: Heaviest cost (LOCK on x86).
> 
> My concern is that Option 1 (Plain) has no guaranteed visibility - the
> compiler may optimize away loads entirely. Since Option 3 (Atomic
> Load/Store) has identical instruction cost to Volatile but provides
> formal guarantees (visibility + no tearing), would that be the
> preferred solution?

In normal case, compiler isn't going to be able to see across function
boundary especially through indirection of eth_dev_ops table.
With LTO it might be possible but unlikely.

