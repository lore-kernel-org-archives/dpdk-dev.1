Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5B3CD5BB1
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 May 2026 14:31:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E93AC40276;
	Mon, 25 May 2026 16:31:43 +0200 (CEST)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180]) by mails.dpdk.org (Postfix) with ESMTP id 7D8FC40144
 for <dev@dpdk.org>; Mon, 25 May 2026 16:31:42 +0200 (CEST)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-2ee990e8597so23480913eec.1
 for <dev@dpdk.org>; Mon, 25 May 2026 07:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779719501;
 x=1780324301; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ukbpJnWbMEshLm+ExzSgSsOOhA+lMIZ6kiFz/RROD5I=;
 b=b/blJMcm7+TVSCBTYB8eKRHGQCKIPEGu8GSr0Ignu62HsV39iDTsxXlRp3XK+wHNS7
 1UAGOMrW6YW3vUB3n7P0qxsQYyj2jDOYx0NochfqTA49vZXeVY0F7+RPQ5YUMKvGLa31
 uuEprdvw/HncH/cD9spWUuV4/AcRDYD/rCEEPrZluA/aO6EhgkukJ+MhAk5aXyWs0hBN
 nDnMzEdjqH09KhU7T8JZU31wqzpWTgcIIkCrUNEhOqqCRSo4+V2u1OF4zvpw7uAZC94/
 9JykTBd1FrYKF7YvatUfg9VqMtL+02A6Hm9tLUP4JDLmN6cqRH8WH9/WyibTlHQ7YyoC
 rSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779719501; x=1780324301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ukbpJnWbMEshLm+ExzSgSsOOhA+lMIZ6kiFz/RROD5I=;
 b=KhQb8T7imG0gKBvJApkSSeCsfDJ0FkP3JEgh7oq/+Fu4Hz8WGL3DJyeuzEOZ4LZEJz
 +h5DyKlIhNnzBlNQa2SHHEobL2jB0HKix8HQfqegqkmubZCR+x0XGcwQWdoRrSamfeM6
 IuPQ/aeSbw4N1EtRtygFxsQbXD6JNsPEZJlBns/fzltUOxg+gZh1TLLRRTb6EqasNoIL
 b4NiNvObZSKJJJK7K/B3iTVoVTodOs7pE07bEYDJ63voPwh5qMfBW4nPJDQkvRiVk1Y3
 5Fen6JeZeIUN2xpMzAaG9nqzyESo+kQTgo7pE8C0J1EsZIO9Kl8yLikXHSQO3N2YdfMH
 qTEg==
X-Gm-Message-State: AOJu0YwZescq+4EOGT40b4WVYyW8OVnWZAhK733A756sTf3bn28Xv2VG
 bDBNcif7UOFVrS7cIrptmFKVOysroUDfH9DFt4wPABlQH/E1uDMhrlJShBhl2SSVUPU=
X-Gm-Gg: Acq92OHXJYRrqPnbNHmlxmFxqydwjPHw+JeKnUtWc8a5OyNvn5lxc5bR+xVD9U0aEYA
 l2FJNz0mUF8YSCXMyOAPS0mkG3DHwJnuvP11uwcw/713S1Lc5AwAFA4Ityu2WqHlpKgG7L6dGwS
 2GE/gOlzD7CSYr7bVl5CgQeSyUJ5hPMXDTzTLI1t7qdwA5OE/ypEw8fdzXN4hHaki7ZOhJCSsyM
 4cKBS0FERqtli6G1nGjQ2CL0qmjruINSS4/1W54xrHS91XomtnJ7Yj601q7ac9gP5Gr/vql7cl0
 DAyWRV1rd4wHhZND8wbMtdT9MvFA+mjvB3BgTOguMIsJZ2XNofrGPXKEgCCRX37jlUU44KOTKsA
 wp2WPYx5A0wjoN3uu3F/TZ4FGKNJesvXGXCN8Nx6Gv9p5QKyhFRcmL36TkXWABkBk8Lcf0CsfAD
 S182gnf+ZMWyXwmLNWGCIVY5HkyumtVljTDj3Y9NbDE1/JgJfK/eRYl5Edw5D9/L0S
X-Received: by 2002:a05:7300:ad2d:b0:2f6:9cb5:6c27 with SMTP id
 5a478bee46e88-30449102080mr6509231eec.21.1779719501448; 
 Mon, 25 May 2026 07:31:41 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3045245d6aesm7539471eec.26.2026.05.25.07.31.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 07:31:41 -0700 (PDT)
Date: Mon, 25 May 2026 07:31:38 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH v3 03/27] ring: use compare-and-swap wrapper
Message-ID: <20260525073138.7b92de69@phoenix.local>
In-Reply-To: <b827bdd2f5994f24b9806e5cbae82cd3@huawei.com>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260523195604.441947-1-stephen@networkplumber.org>
 <20260523195604.441947-4-stephen@networkplumber.org>
 <b827bdd2f5994f24b9806e5cbae82cd3@huawei.com>
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

On Mon, 25 May 2026 07:41:13 +0000
Konstantin Ananyev <konstantin.ananyev@huawei.com> wrote:

> In fact, in rte_ring we do have 2 implementations of the same core functions:
> lib/ring/rte_ring_c11_pvt.h  - uses C11 atomics
> lib/ring/rte_ring_generic_pvt.h - uses legacy instructions (smp_mb, extra), 
> If we going remove these legacy instructions anyway (or reimplementing them using C11 atomics),
> then there is probably no point to keep rte_ring_generic_pvt.h.
> Konstantin

Good point will try heading that way.
