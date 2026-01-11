Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF83FD2502D
	for <dpdk-dev@archiver.kernel.org>; Sun, 11 Jan 2026 20:24:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6AF74028F;
	Sun, 11 Jan 2026 21:24:41 +0100 (CET)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com
 [209.85.217.47]) by mails.dpdk.org (Postfix) with ESMTP id 3390E4013F
 for <dev@dpdk.org>; Sun, 11 Jan 2026 21:24:40 +0100 (CET)
Received: by mail-vs1-f47.google.com with SMTP id
 ada2fe7eead31-5ef2561e395so1820325137.2
 for <dev@dpdk.org>; Sun, 11 Jan 2026 12:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768163079; x=1768767879; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T4bs8yLj3NVNOjyDNITjJ0ZpMas6Co9RugwegUgoK0Y=;
 b=dBk5k6x8G2FcU8vx5iFYjnwkTu8XtZDaZvebV5nJRzIMEq6BZm6Ek64RixNuA2oAqV
 mCz0IJD/Sm71Uwu1iz6clKcqgzak5S2/AKHq3/ovO9pQzjB4jRHBY5qo0HUkDzgKfx4W
 TJflzKNAN6THNraCsFTP8YAVZMMWd0SgBJr8NLnfFEn5xpBudMkrJuVnRs7/Jk8YBiEb
 +APHVDqOnF+rTFXcfivObFb+i9CXCPUPl9zKOeQwXti8/MH4IhdvhFZ8vGQnWEJxQbAo
 3eMhr4KPACDgX8hOMHAWKCtMsERiJZyV9T6qxo0Kh/DamuoXxnmppWavuD2DqFR5413E
 bwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768163079; x=1768767879;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T4bs8yLj3NVNOjyDNITjJ0ZpMas6Co9RugwegUgoK0Y=;
 b=JvTucXjdSx+ACvZ/2/C4d5Ly7483YZkcGx82rcgVx9thHx8hAAraAb6nluWtn0dry6
 jN1D7tWY66RDvGn6ywxMuD65E+OwB8xUJNf6PTesS5yI4l4WU4BjKh5z1EpSpg3K1Vz+
 1KkqKi87ax4Ww78cYJHPus0HnditSuEMMAwezW9KJ89xPovfwF7Mp0e0IGwofjEIWGCk
 ZccBuW5/6ey4Ah1uj/kctHT0TYzeeeCnYC9ZrhswvZdIwwy9QQEbtCXoD+82IE0zgysm
 s1b4c3TS6wj7OAAZW3HZrg1e7u1Ix12uVtkw5KQBU6UsRUNUSHhTZB7QNPwuqO7Lf+nW
 xaqA==
X-Gm-Message-State: AOJu0YyV4ReCsjb4qHlV+s3amuxZrurBmegqFI7L0lXNhgguNd0s04mG
 +LZd38G8qlPz1PFAoyG6g0CoGkuX8USlBpamKU7rm5snHNtq/RbxYVGClGVgjA7ORsWhLnrCjL9
 dZlN4jC19iPahOUz14zxW05iE+Th9NaB29LNF
X-Gm-Gg: AY/fxX6b1HCa/R4+15XACzs1W/LpVQUWeWTw0pvBGrh+KfIVnI4TfAdsIcrP0GDyhZx
 t0u9b+OOhHHmdmECRmvvuch8kD3bWLPVzsUyG0tZNxqB7/ESiHhwFuYAANLknGiT7TWLqFUJw6G
 vS6qXEVCJIB6aCy2oeCBgS3p7tbquv1v5V+ng3K+53GPHBD+8UGzU/YBRKvq6wvoVes2A46ny2L
 JqGPAsQPnTwpHLpqWMoNo23/FT7qGejpQvz8JJMKFOjoEev84jlwdynsRK8gX2SH0hqAhbUQs5l
 Egk55MiPCRIQJBuQaxG3D834egT6PA==
X-Google-Smtp-Source: AGHT+IHsMEWmLKBt2Hca+F4XBKSgLqx3Fza76T30HTPmHoQ0pyweaHVlwyRVOki6O/W+KhOT7yll4hNkWLIwz8gsRH4=
X-Received: by 2002:a05:6102:3913:b0:5ef:241c:e0e3 with SMTP id
 ada2fe7eead31-5ef241ce230mr3950392137.23.1768163079492; Sun, 11 Jan 2026
 12:24:39 -0800 (PST)
MIME-Version: 1.0
References: <20260110015651.26201-1-scott.k.mitch1@gmail.com>
 <20260110015651.26201-4-scott.k.mitch1@gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65648@smartserver.smartshare.dk>
 <CAFn2buCsqH5DR9k9rZFek5OyEC3q26G_Cm_u9dUG1=YuWXrgQw@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6564C@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6564C@smartserver.smartshare.dk>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Sun, 11 Jan 2026 15:24:28 -0500
X-Gm-Features: AZwV_QiM5NI9e8bedOX-WNATB-n67gE9r5cGhlHx8NmqZE2tI3dEDyhNfaxiCTQ
Message-ID: <CAFn2buBzBLFLVN-K=u3MgBEbQ-hqbgJLVpDx3vSXVKJpa0yPNg@mail.gmail.com>
Subject: Re: [PATCH v12 3/3] eal/net: add workaround for GCC optimization bug
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, stephen@networkplumber.org, Scott <scott_mitchell@apple.com>
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

> I wonder if some of the magic types in rte_memcpy() [1] could be used to fix the aliasing/eliding problem in the checksum function:
>
> struct __rte_packed_begin rte_unaligned_uint16_alias {
>         unaligned_uint16_t val;
> } __rte_packed_end __rte_may_alias;
>
>
> [1]: https://elixir.bootlin.com/dpdk/v25.11/source/lib/eal/x86/include/rte_memcpy.h#L66

Nice tip! clang/gcc optimize this (https://godbolt.org/z/WxjEbj6s4) and my
reproducer doesn't trigger the gcc bug. v13 coming soon.
