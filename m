Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC11E7FDCD
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 20:12:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E3B540611;
	Mon,  2 Feb 2026 21:12:39 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id 219B34026D
 for <dev@dpdk.org>; Mon,  2 Feb 2026 21:12:38 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4805ef35864so41569505e9.0
 for <dev@dpdk.org>; Mon, 02 Feb 2026 12:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770063158;
 x=1770667958; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PC44zdspGUqJTV1vodalQOPQu2zhFxk4xp4Aj+P/UxU=;
 b=obE4+I6YlHNiS4Qt3ZJ67Dl/x4QlkClMl7H85hM9snlwbKaoQC2M0ZjhMnMq/nNTK+
 xT41xGf2NskhYYjmeNU184AwL2UMkzGkj+T7bCwiM5k7brVDR9475fs7HRjWyR+O+Q2S
 DtRUhVTvcPYvDckBgWzRDrOuDx2XlYBytnIexRd+kzdXxivIpzHMZEMJVYy4AwCw3YwH
 BQ77SJ/WKcp4c09y8wB8ldtiIEpfaKH074yfifZG8nBfCXyFXAtJAQoPMkuj+TZxhbl4
 O2nMgdhIlasAx74lbJ6isGZWjpCJas6y7HgnAlHXIlQVPyXqZjk9SZprLaaEsniD6bXK
 8Ycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770063158; x=1770667958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PC44zdspGUqJTV1vodalQOPQu2zhFxk4xp4Aj+P/UxU=;
 b=paTwHociW0gwO8pxtu3Dmp2Ge2EVoOEusyV7ASJ/WZ4EuZKyCHKHtn0fMKMi++p1mZ
 lP36mMRM0zApRvwbtxWSS1HNkS813GtIQkRz9ezQ5EW77GPw2+6h/KLNgucaRwV32fUB
 Vvo/8AiX/ScoXKhpkM4tXcccqtWyjp+Lmn/NXShYWVVXf0SBbuSPxHBpnR81L5rHT4o4
 uwboctX4gAD5/vaO4kYpAS+Xb+ruGcWqph9aZSq6kntZepunEHAd+aGsgmeeZ0t6Y5wz
 334xSk68qBdhgNudXu7r9tjjW3KsffQk8SI04y59tfx3/FrsiLCuxxwcpV6y3BcRjcjB
 srsg==
X-Gm-Message-State: AOJu0Yxx179D2yQ1iixtEHPXdg3MnM+jZV2YHMn633/RE7JUzEmMSU2i
 UoX+xAJekBlReML10m7v8jxHyXL36s/hV0G8MldujRsuTzeGvz4eS2wsZ7mPjR04lHk=
X-Gm-Gg: AZuq6aLAQuGLZ79sjVPitYctPXuSR5FTycJmvV/qb4RBr2hWu4mjmtpMwOsPIL/x+4+
 0CfXtn2KCXK81wP8PiOF8X9QywQ7gm/kJe/pb+sjgOLVu7KBKS45fZJHrsZYZ7tbqV0UWpFNhWV
 EYz4gqirpb8hvbYqg1iTOPSRHqQMfHIsTA0DpG1fiT2lbXs2mq7dYZDAgrA2jm0Ln2e79tVu+gX
 nKyueKa93FFTQhYNH4s99ufyJY8b8krheMjO41BQDCwiIIgijFbCN3M7GZSpXJiE08P0UnHy8RP
 7E7AHJbZo8LvBSinOLNBb0qpjNw+RU9WkHrt0B0+kQdSHciWtWqE/7Ysse3Ewx/v7oZoDH5woJp
 tcyNKy+eFNtOb78DQS4lWb80Av6SF8pdcvCro+q/5jzV22NT9gByvadZIB4q6doLEAQtHQtpdmb
 oMtgCaicqsEwAu8kSftm//AuHbg5q+Be+IB9dP/6qy2Y3OFawRMq5d
X-Received: by 2002:a05:600c:8b61:b0:477:b642:9dc9 with SMTP id
 5b1f17b1804b1-482db4866d7mr154858015e9.28.1770063157582; 
 Mon, 02 Feb 2026 12:12:37 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4830512ddd0sm12175395e9.9.2026.02.02.12.12.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 12:12:37 -0800 (PST)
Date: Mon, 2 Feb 2026 12:12:31 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Scott Mitchell <scott.k.mitch1@gmail.com>
Cc: dev@dpdk.org, "John W. Linville" <linville@tuxdriver.com>
Subject: Re: [RFC 1/4] net/af_packet: remove volatile from statistics
Message-ID: <20260202121231.3e5496ed@phoenix.local>
In-Reply-To: <CAFn2buCc2mACHssDV1zesWCrhju_=V67e=WSNK+0gkrGskKCRg@mail.gmail.com>
References: <20260128173138.151837-1-stephen@networkplumber.org>
 <20260128173138.151837-2-stephen@networkplumber.org>
 <CAFn2buD=1CwnP92LGuj7fGzi_Cujnp8eTV96ZzTNKBjsA6kzOA@mail.gmail.com>
 <20260128130014.0489e0a0@phoenix.local>
 <CAFn2buDhLQstsTxLyqsK3ZbOJG4ZgOGreKm0Lv7seieBEfJq_w@mail.gmail.com>
 <20260202093431.57c1d652@phoenix.local>
 <CAFn2buCc2mACHssDV1zesWCrhju_=V67e=WSNK+0gkrGskKCRg@mail.gmail.com>
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

On Mon, 2 Feb 2026 11:12:31 -0800
Scott Mitchell <scott.k.mitch1@gmail.com> wrote:

> Thank you for the clarification about the function pointer indirection
> acting as a compiler barrier - that makes sense for the typical case.
> 
> I have one remaining question about 32-bit architectures: even with
> the implicit barrier, plain uint64_t reads aren't atomic on 32-bit
> platforms (reader could see torn high/low halves). Is this acceptable
> for stats counters in DPDK, or is 32-bit support not a concern?

DPDK has not worried about torn counters on 32 bit architectures.
Whether it should or not is open question.
People don't care much about 32 bit anymore; other than not breaking it.

> For context, atomic_load/store(memory_order_relaxed) formally
> guarantees both visibility and no tearing across architectures, with
> minimal (GCC) or zero (Clang) overhead for x86-64. I see there's
> precedent in DPDK for plain uint64_t stats, and I'm hoping to
> understand the assumptions/trade-offs better.

The problems is that on relaxed ordering architectures like ARM
it makes the counter update more expensive in the fast path.
