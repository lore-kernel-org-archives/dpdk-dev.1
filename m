Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FF8CA9EC7
	for <dpdk-dev@archiver.kernel.org>; Sun, 11 Oct 2026 19:53:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8831F40279;
	Sun, 11 Oct 2026 21:53:01 +0200 (CEST)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mails.dpdk.org (Postfix) with ESMTP id AF8F94026D
 for <dev@dpdk.org>; Sun, 11 Oct 2026 21:53:00 +0200 (CEST)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-872024e2b4eso339683b3a.0
 for <dev@dpdk.org>; Sun, 11 Oct 2026 12:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791748380;
 x=1792353180; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PyprGWttyU1kku7ZiSCjb6bXHq6iqdPUeXjoswK4mSY=;
 b=NdiNVzH0qb0KiGrAe94cKTGBd2THEhyuuZZKMhhIBxkOZ9VHq5wbaXlZuKsiX42NCL
 ogeRJ3MbIlIAENPKSG5LNURt/TH9eaZIiOlqZyUE2l0xAA7vBPZJ5gDzceABu3Y5gC3E
 FxnIlUeFr298+5HT+mTOI7f69ieMLQbR/sfZhEy0odEtQBvNVkuOgcZxdZ6TBKWqWwYi
 ji8QlwiBZBvHCzLFnZP8PHC9LMgCsb0rT78eh9YjPw8XE40DIJJLXjslDc+2ELh9reYZ
 fv3s1WVEN5V6R8gpWBoBVm8m1fotAlNCEOOgz1mjGoyIPiKbxnzEGQYg18IALdhvaWFE
 8IWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791748380; x=1792353180;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PyprGWttyU1kku7ZiSCjb6bXHq6iqdPUeXjoswK4mSY=;
 b=pIw9nqk9+Bwh1xUqdpa48qo1l07H7Evt/hIepJ+6DQTDVxbSrDUKv92FECGcvDksI/
 acfdsuZvkFVNF3nhTEWcHU4CjyeXvhKaFVaCVqrfvGqJN/zKssBpnagCWSsk8Iyv1wJS
 cQb0EXnwTuBk6HhWRZsfz7OH2LL6XDb3kH36czIp0MxyeTCYw4RYYJ6/R2KhRIAh1KjJ
 PqUmqVf0lS91FbEXrAfWeJVGO59Ga/Wl/UrAxuy0GoJe4C3fWYXRQ5auCdeJmrCg+ne4
 A88IH4VkiZrMjleZS0hkWAYFBhALBSeagUPyukorhjgRbqj61ZF8jTjhpsB00dFzAj/B
 BhVA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwz1exb7pspwt1uxHc16tG8aLW3EXmWGJp+OYMmAij3CMK/zM9xAUu7RFdhOxwGJBUMpqc=@dpdk.org
X-Gm-Message-State: AFq9FYLvEwJmTPb5ulyLC8b73uPJu+GqHvaj/uehQHHf0SNiBJ+8wklU
 BwwNCqX/goQhXKEt5rZexXDzIxMVnKmVr3finAFnmwd7SwKixnGMl0xNuhC6YVGAy+0=
X-Gm-Gg: AYBFou1XeUTEXqB6KjAIdbOovhcTjBL+/fSlD6KP8Gw21LSuUnBmSWaKu04nv/h5L2L
 GS0PaJlKGOHk2YbJNYd7In3AMXDU3V/9FcG7cqbgkChvL0Xiq0Jg62ZrHFDGIolz4VZNhkRZlub
 1arHFLJ+bDsGLs4fZ5QgZQUGrz9wEF1J3ms8i056TRyyqA8tIQNWNyadm/7MTeV3lrJCTFFeBgb
 5964gqwOyqQT9LVF6xlnE9rWDJRcDcuNbgiX1YxcnKGwFhNyZQfI+3FpliBu8LRyNc6ZhWX4QAf
 qxZYNQfK1xouL0BuS2Dka39If9l3yrkyVHuqn1AKSD/KLhpFwnuZK1bF1mJk7tiFq8FNV99CDJx
 zLYT6pZtHM6zPOD+oHmGyj/J+YaEu4LFzJO0XGYtv/LoQuUcEBYjiQsISR96+YO68oRUAfyzRKX
 Hvy9pxV7qQ8nU9PehThXQgSVti8DiwjhO4fEnYPM/p9Gt8REPyKXdEhDmd0m9FOxhLSF/yF+owu
 LDMP2ZVQLcibaLf8KU0Y6RZAcaA07jW4zYwjx9c
X-Received: by 2002:a05:6a00:c20f:b0:899:27b5:214e with SMTP id
 d2e1a72fcca58-89927b52461mr1933764b3a.30.1791748379643; 
 Sun, 11 Oct 2026 12:52:59 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-896c3107194sm3229279b3a.18.2026.10.11.12.52.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 12:52:58 -0700 (PDT)
Date: Sun, 11 Oct 2026 12:52:56 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <qm2k21@gmail.com>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>, dev@dpdk.org
Subject: Re: [PATCH 8/9] bpf: use relaxed stores for callback inuse tracking
Message-ID: <20261011125256.753e35bd@phoenix.local>
In-Reply-To: <20261011182158.124246-9-qm2k21@gmail.com>
References: <20261011182158.124246-1-qm2k21@gmail.com>
 <20261011182158.124246-9-qm2k21@gmail.com>
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

On Sun, 11 Oct 2026 18:21:56 +0000
Marat Khalili <qm2k21@gmail.com> wrote:

> Direct assignment to an atomic variable defaults to sequentially
> consistent memory order in C11. Since cross-thread memory ordering
> for packet callback execution and unload is already explicitly
> enforced by memory barriers, sequentially consistent stores are
> unnecessary and may emit redundant barrier instructions on weakly
> ordered architectures.
> 
> Update bpf_eth_cbi_inuse() and bpf_eth_cbi_unuse() to use
> rte_atomic_store_explicit() with rte_memory_order_relaxed, matching
> the relaxed loads already used in bpf_eth_cbi_wait().
> 
> Signed-off-by: Marat Khalili <qm2k21@gmail.com>
> ---

Already covered by smb_mb conversion patch.

If you want, can just make that into one patch which does
the conversion to bool and gets rid of smp_mb.
