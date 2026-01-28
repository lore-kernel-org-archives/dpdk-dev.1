Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5D3D46BFC
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 21:03:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A1D0402B6;
	Wed, 28 Jan 2026 22:03:27 +0100 (CET)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id BF982402A7
 for <dev@dpdk.org>; Wed, 28 Jan 2026 22:03:25 +0100 (CET)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4806d23e9f1so2813955e9.2
 for <dev@dpdk.org>; Wed, 28 Jan 2026 13:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769634205;
 x=1770239005; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rY6eQ8mbLokcaUgIkCDNT7D6Deg8EW+MDUuKrRU6QHo=;
 b=XBvI7tTfq0X0ObQiwTvxvq8NnBn+0wzhRXfO9wPN/0qf82z/wThg0xSkKXyLg+ohVm
 j9pibiKcJ8jo6uOZBokPSVsq1OOaIJJcLxBESuDWT0ZO9n0yhxtGnCqi7NfMwJQVlbqw
 vYM0x3J9lw3TyDlviYmv8wTnZj9NU1UZosqA34pj1NotY09ZwJZwL17lw608TBY5VYDd
 Ztge7+m25hyL4zyj90oREYBBitOKm4Y2hS/XKe1PkV+MAWPylHeykI+PntBeNKgeiBBq
 ftsABDJd6k0b5Mmm3UlCWvBpM0GjUY95H6I1HKl47XMAUWb/zmFn6l/sG0LU8xrdPIhA
 yMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769634205; x=1770239005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rY6eQ8mbLokcaUgIkCDNT7D6Deg8EW+MDUuKrRU6QHo=;
 b=xOfE+8MI9kluvPo5xkqhUOkaQ1+FkECtVR96V3Jn4CzIy6/ukkCpnJcAzvvc1hWoSU
 1OxtfPSdhl5gxQ/HXS9NNraCaZ3xiKXwyPPGLivRbraBimTCPtg+8TbMh04SdoPjFmz8
 itiAKo7soRAoAMUUFwMzm6I/K69+dzM19cK4aCBc95ybolqfZbBgAdAPv83Sgew/AsTp
 INJpo8FDUwXFOmGsnBSCQwzl/m7379pEbZ3C6vg/YzPF/AiP8kOVYGh9nfa9x3wuj7Zh
 3Ypf+0Jvqy+XkY8IBYeJFnSCS8WROAJ+tX/UItrQaHKKSokm4CHHk/JORGOBgc07oDys
 mOXw==
X-Gm-Message-State: AOJu0YypM09HRsPFhz58YbdJgob3cYrvMOgDd93TFutbsMY+6LN2UaHG
 AZI4IvHcypMLCqMfmP9ciA6ViodnFAsUrbrizXqswOUHq4wvj0jD7pn6GHF4f0jEpHs=
X-Gm-Gg: AZuq6aKYF9m940sxDxVVnTOmTm/gEl/kBUTLc2MmJzF+HxXgGZ/v1uhLLd0uw/aPcBm
 /8APRV4g/qbwOx6D22hR1sER1T96jJdAM/rchCnlNmgS8DyVXS9Gz+6YaFLGu7J/pU92aceCq/m
 4KQTtCu3NC2A3fltrUw7QlxLxVCG+sKfaE6t4jS43KvBTBm3gA63dl4CNVKZMOU/fIFKmHq76Th
 sPkeCWEueM+CM1564ftMkrEvXxIsZh6t6uA7n5LiHnEkFMNDieBVGNZVuUYsVuvRWA8HQ4igxF+
 GJyyvEd55KhlsUjgZsVh1ZE+bXFKNuZ/jBscYvEr29KvrgRBJawRKf6grP06mrcqHk0hjC5rcdT
 AAGPl8dECwmYbrNWl5N78egjXCL27tYRuMosCBSTj3YOhfis+aFxkEOoCo436Io3kVYDyKz+nM7
 B4NnKJuFSm+y0OL/r3kKQom02XBSNXh7j8Toc0qZ3koBdxZGT32zil
X-Received: by 2002:a05:600c:4689:b0:477:9574:d641 with SMTP id
 5b1f17b1804b1-48069c5bd29mr90011135e9.22.1769634205205; 
 Wed, 28 Jan 2026 13:03:25 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c428basm161169245e9.12.2026.01.28.13.03.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 13:03:24 -0800 (PST)
Date: Wed, 28 Jan 2026 13:00:30 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Scott Mitchell <scott.k.mitch1@gmail.com>
Cc: dev@dpdk.org, "John W. Linville" <linville@tuxdriver.com>
Subject: Re: [RFC 1/4] net/af_packet: remove volatile from statistics
Message-ID: <20260128130014.0489e0a0@phoenix.local>
In-Reply-To: <CAFn2buD=1CwnP92LGuj7fGzi_Cujnp8eTV96ZzTNKBjsA6kzOA@mail.gmail.com>
References: <20260128173138.151837-1-stephen@networkplumber.org>
 <20260128173138.151837-2-stephen@networkplumber.org>
 <CAFn2buD=1CwnP92LGuj7fGzi_Cujnp8eTV96ZzTNKBjsA6kzOA@mail.gmail.com>
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

On Wed, 28 Jan 2026 11:57:16 -0800
Scott Mitchell <scott.k.mitch1@gmail.com> wrote:

> Can you clarify why removal of volatile is safe (visibility, ordering)
> when the producer thread and consumer thread can be different?

The short version is, volatile protects against compiler reordering code
where it thinks variable can't change. The atomic primitives protect against
load/store ordering issues on non-cache coherent CPU architectures.
The DPDK design pattern has been that statistics don't need to be
protected since producer is single thread and consumer should be ok
with slightly out of date data. The point is that using atomic requires
going out of cache on ARM (where it would matter) and on x86 locked
operations cause a pipeline stall. At the high data rates in DPDK
any stall or cache miss matters.

The one exception would be drivers that advertise lock free transmit
would need to use atomic on the Tx stats to avoid multi-producer problems.
