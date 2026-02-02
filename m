Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F4BE63C8C
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 19:12:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 415E04027D;
	Mon,  2 Feb 2026 20:12:45 +0100 (CET)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com
 [209.85.217.51]) by mails.dpdk.org (Postfix) with ESMTP id A4D1A4026D
 for <dev@dpdk.org>; Mon,  2 Feb 2026 20:12:43 +0100 (CET)
Received: by mail-vs1-f51.google.com with SMTP id
 ada2fe7eead31-5f1bcdf03c6so1576377137.1
 for <dev@dpdk.org>; Mon, 02 Feb 2026 11:12:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770059563; cv=none;
 d=google.com; s=arc-20240605;
 b=j0WY5aHkMp/eio+CavlWRWfkct2Z15BBLcN5vtu5NC4q2Q1I6IFCXeLyEWuhw/xCFt
 +iyyocUoOJmdlLrPJlvZnvxMXA6S5tIiojDJU1WithFg03cNzGD2ch1nl4Q2BYyeo7j/
 BIZMbetMfHYZxhU1OYFXRLqIVsHSN46iIOq6AGO52X2W5M+tzjNRATlVr7DLiIXVxxd2
 OnyZF9rvjLNqvniYdaChQQBrfPdJe/vA0YuNjZo6TR5WYzlzZPskYg0rNRRXUlmycPeS
 CVb8xRD3TF/tYdbr2JiTAroBwvtfFkEFxxPUw/u6VppvGnZ5VOjL1Klh0H5HlqsJfsek
 fAhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KVlhkFOx3kZ8VD+n4D19gzx039uh51OAt/DHPqbzW1k=;
 fh=+L1L+ZHbKjrb2f5CsW4olkadjYbHjR06LFcqyhSoUu4=;
 b=GJSBF8N7lyT0RSuiUdhX24n5/sXTdJWa131R4fXj6iTONGXo9RpYunv74T8hzF/yKr
 p2u2bDpWtO4IKhVBy3SPeRYOJloyXRIaGkZu74rUBvinZOFXTTdfEQtjxupjmiYCC8Az
 qo9ikzD5Qlx2+80wjMlQAKkwGUjcFeXMDg8lXPdmFY5sXvyjOos1JdFZ+x+Yc23WW3yI
 ymH7LRh4f+6dpavv36vEDQDaY88vA5VHF9xoV5QI6TFhrQU/kZMzPNLt5jvA598AhGHz
 YSYVRQ73X0UHt5nW8qi7fpufHwRkjZIKQUOKxcpJuCCGW5kYRzfJ51RWK2x65r76IZ+0
 GSog==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770059563; x=1770664363; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KVlhkFOx3kZ8VD+n4D19gzx039uh51OAt/DHPqbzW1k=;
 b=PffZPbgeNhGhyXPQfWGYT8wJjCh3QXppOm+qiiElNXl35ortjqEUf2PcYpsZn5SugQ
 HYpv4/HAhnDB4CEMtRH/WS0KlTN3IyHu0h2flqV9x2yyYNZ6JfGB6Ei4Srn/g85HOrsF
 Af7OgfEkuvf/3+tn+gx/GFnCGXFHMW7+8GxPCMbxr3MYGnnW2vwAqj7kl85Z//lRUvKC
 +YxNN8iMxpsS6yJ5o9E7dkGk1D9hE1ZXqeejfVFv5oTgtQ+fcR93l32Tg0PeHJQdBLG3
 VlWlTXyw6h/nBiko7QcJpSwf8MchzrcIOItY3gy2ZYlC05gWowJ4OFJEIDO4gCnmPtE4
 NPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770059563; x=1770664363;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KVlhkFOx3kZ8VD+n4D19gzx039uh51OAt/DHPqbzW1k=;
 b=jQUMVwwzn3M1CiXeMSKd0VRs9MCU+fIx2spzMyV4pA/SZPtA7/+iJLw5Og/dkFMKIv
 LQ3rh5G4LEtdx6b9qxkg3NZBCGMpPvJK/neN16cFf6JUC+VsDcz/zP93P+nJCxBBScdq
 P+ksBKWYuFzXEy2FpHX0OqT1s9Ha7lWsy2DJUuRGUoho+O8JxoCNL1a+D3I4JNrKOHv7
 sFSGM9ZuOJdZyMjcfvQu7+tRKuLQDSHEu7MzIsT2SnjeG7nf9lra7YTyRfyFHtM2zcJq
 0Gu6AQoIhnm++bs1lwzYokQM8O7ZDL9xeDCBMbEefWjRoK9I8yvBaqsrEBQcGiSpyDCt
 t/3w==
X-Gm-Message-State: AOJu0YzDdQBJsN8MbyP/j4/kFDEWWZbeGJRoIiOGM+rwADvka1boUkha
 7/87+nQKTNC9iaO4GWqbZGlzqEOSlA65b52TPDrqZ8JErm75sV9/mDNdhtUVbgBxfF4T0QvmuLQ
 p3YzMKbSunm0MrieArTMqYc9dw4cvIsxqBzHC
X-Gm-Gg: AZuq6aLu7Ra2bLR8ZDpJy2/rowSygMxAkyIHa2vJZ38twwvMzoLipQNMflpwGMTpbw2
 RlyxcNY4nWpsrEVla+2eLkzxFw0sEgiSR/iJKeAqmmssZ8KN6HhU8C9TXToY3lLwyCLVmrvyyGG
 dinSJapvax61H/rOZMfZZEkQSgumg2vLXxXRC0xiPHKmch6jj2xFy6Z9UwwUumK3SWm+y/kpVgd
 sPeePGF2c2Lwh4ag5tqcJlCoitWwOC63Umw31BA2v31k/PUg5vMlQD7sSl2Y6aLV/oX5yQ=
X-Received: by 2002:a67:f8d0:0:b0:5ee:a0e6:a9fa with SMTP id
 ada2fe7eead31-5f8e26c366amr2593248137.23.1770059562769; Mon, 02 Feb 2026
 11:12:42 -0800 (PST)
MIME-Version: 1.0
References: <20260128173138.151837-1-stephen@networkplumber.org>
 <20260128173138.151837-2-stephen@networkplumber.org>
 <CAFn2buD=1CwnP92LGuj7fGzi_Cujnp8eTV96ZzTNKBjsA6kzOA@mail.gmail.com>
 <20260128130014.0489e0a0@phoenix.local>
 <CAFn2buDhLQstsTxLyqsK3ZbOJG4ZgOGreKm0Lv7seieBEfJq_w@mail.gmail.com>
 <20260202093431.57c1d652@phoenix.local>
In-Reply-To: <20260202093431.57c1d652@phoenix.local>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Mon, 2 Feb 2026 11:12:31 -0800
X-Gm-Features: AZwV_QgGVJpS2HXRtytqkzmHyqYBGdix-U1IV8f6QKIRyz-RaiiOsRUpxi6_u_o
Message-ID: <CAFn2buCc2mACHssDV1zesWCrhju_=V67e=WSNK+0gkrGskKCRg@mail.gmail.com>
Subject: Re: [RFC 1/4] net/af_packet: remove volatile from statistics
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, "John W. Linville" <linville@tuxdriver.com>
Content-Type: text/plain; charset="UTF-8"
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

Thank you for the clarification about the function pointer indirection
acting as a compiler barrier - that makes sense for the typical case.

I have one remaining question about 32-bit architectures: even with
the implicit barrier, plain uint64_t reads aren't atomic on 32-bit
platforms (reader could see torn high/low halves). Is this acceptable
for stats counters in DPDK, or is 32-bit support not a concern?

For context, atomic_load/store(memory_order_relaxed) formally
guarantees both visibility and no tearing across architectures, with
minimal (GCC) or zero (Clang) overhead for x86-64. I see there's
precedent in DPDK for plain uint64_t stats, and I'm hoping to
understand the assumptions/trade-offs better.
