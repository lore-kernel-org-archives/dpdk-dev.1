Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DB5CDB46F
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 13:50:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C0A83402D5;
	Tue, 23 Jun 2026 15:50:07 +0200 (CEST)
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by mails.dpdk.org (Postfix) with ESMTP id BC66F402B5
 for <dev@dpdk.org>; Tue, 23 Jun 2026 15:50:04 +0200 (CEST)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-1390f75d8bbso6049509c88.0
 for <dev@dpdk.org>; Tue, 23 Jun 2026 06:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782222604;
 x=1782827404; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KKgKFJL39S6RQiyaZXhq6j2zgupPaSvdpr8kb2USUmA=;
 b=Wt3NVDw9+0dXIiuD6ylxfYpvioFmG2OVJ8nYNra+snM393oNoKNyXFlmc4SDMJf7gP
 X9NAbEHspcYlw9bnFmZHpLhhquZcLkYS1Z2q5RsGXQumn+MbPzPOuYU9mdcD2oWGtdFH
 QswaEyE2/2H1Ay3HVkB3VqykR6fB8XChqx6xKKK1W8QxVHEH7DCdIAGoPx2AKIXZD1Dc
 8HAvHLgJiIQ01JbHqmvQNyLaNQ9WiYkmH5suFFqPhdBK32JiaGe7GT+K9rOQPhaiPF8b
 +IdQw9YnAI5YIXoEUOcM7vDzAJwGJm3FyfWqhS2F8JqzsoPTTt3vKladK7NLQIjNyeMK
 1KaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782222604; x=1782827404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KKgKFJL39S6RQiyaZXhq6j2zgupPaSvdpr8kb2USUmA=;
 b=RgoBcqoV5k1TlcAJVkUGo098Fh6akYX5rYWfERre9PO9ENc8QjZ2UcAoc4FQEDGUfi
 f+ZMYXxXsHJjD6fNuHz+KVpqHQ8fwZe6yKyydZtTvdJq6NBx2Bx86ezy/S+AlDHrpahL
 MiXzsZM/wRSdFtyuX7utO+wMBKecugU1fqoiTag0WMxuobaAkl5GO/w8tTtgC6M7j8ur
 Vy73nqmmU3RXVg1RLuJVfDl0LtU6G5YV8/6ecpZTHwnyqld9/TITGyRd2lNU/ncY5iV4
 vRwTqLxXCDYgzV6XpFP/gbqxu2nUVyZa3E1q+fYwnsX7DHJT9Sxryjc1nAO+OsZRF5ib
 gZIA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8OyMRS6EZojfI90fWH7vYMC0a55uf3IxD3cV1LCNBzKivGwcZVgy+zKUX6h+OIfo/+Zc0=@dpdk.org
X-Gm-Message-State: AOJu0Ywqz4vqmURLknJFGEMmZMQdpgg4qlLnOes99+QCliJ5I2YdwR3B
 nT3zmX9arNZWqQB89QxkG1R9Eol0U+S1BNPl/Ya/rTTqj6cvvjSLl8GC3uRty4vQPJg=
X-Gm-Gg: AfdE7cktp70oq9d+L0QsPig2yQRB2FDN8fEBSXNkvzLtiHMId0ZcZv911FKE8sNdqMn
 B8QTYmWjaLwB5Hx53xqSK+Z/qZxQOXP3shud/KAHfid/3NVF6o9qGIEtpgCz22HZg6EWBAm3y3e
 4oFnhgTWBKYpdOPMRrStClgBODc58l5UfhH9MS6wRs6ht7jDYwlMuzuRjjgcHltjuWfDiN5ukpZ
 U7kyU7vc6TkmiE4m5zWGANgUdHRbjkbhQZcCVxZ+3oDL8CUdErAcEW6m3qvl58RRCeosoDVuQ2C
 ++O+xf81QSQ5qWPlgbfjhH+rzMuVXjkTl+yoa5Z6P9+clMPt5ZHJ5w1D5rOiK0satWKLe4ageXA
 N/hGdyjcMR+7GPneTtW/iB1hRGizDLRN9wKLZhSBH+YWS/mA0XHN7fEXj8xdeRzeFl3g7lTmVED
 9T77RiC78gt7b7TKrXZ2Xq6l9TNjTVmuM0EOBdBdlHmNIHnjVQQuorNw==
X-Received: by 2002:a05:7023:b0d:b0:12d:ea4f:99de with SMTP id
 a92af1059eb24-139c5b9d56amr2282765c88.0.1782222603795; 
 Tue, 23 Jun 2026 06:50:03 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139adca1b18sm12443743c88.3.2026.06.23.06.50.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 06:50:03 -0700 (PDT)
Date: Tue, 23 Jun 2026 06:50:00 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>, Bruce
 Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH 1/5] eal: fix macro for versioned experimental symbol
Message-ID: <20260623065000.57d775c9@phoenix.local>
In-Reply-To: <20260623113752.1100072-2-dsosnowski@nvidia.com>
References: <20260623113752.1100072-1-dsosnowski@nvidia.com>
 <20260623113752.1100072-2-dsosnowski@nvidia.com>
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

On Tue, 23 Jun 2026 13:37:47 +0200
Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:

> Add a missing semicolon after __asm__ block in
> RTE_VERSION_EXPERIMENTAL_SYMBOL macro.
> It's lack triggers the following compilation error with clang:
> 
>     ../lib/ethdev/rte_flow.c:320:1: error: expected ';' after top-level asm block
>       320 | RTE_VERSION_EXPERIMENTAL_SYMBOL(int, rte_flow_dynf_metadata_register, (void))
>           | ^
>     ../lib/eal/common/eal_export.h:75:74: note: expanded from macro 'RTE_VERSION_EXPERIMENTAL_SYMBOL'
>        75 | __asm__(".symver " RTE_STR(name) "_exp, " RTE_STR(name) "@EXPERIMENTAL") \
>           |                                                                          ^
>     ../lib/eal/include/rte_common.h:237:20: note: expanded from macro '\
>     __rte_used'
>       237 | #define __rte_used __attribute__((used))
>           |                    ^
> 
> Fixes: e30e194c4d06 ("eal: rework function versioning macros")
> Cc: david.marchand@redhat.com
> 
> Signed-

I didn't see this because clang doesn't have symver support.
Which version of clang is this?
