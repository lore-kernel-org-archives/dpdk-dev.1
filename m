Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501FFC5DF74
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 02:17:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B3BD40664;
	Tue, 18 Aug 2026 04:17:03 +0200 (CEST)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42]) by mails.dpdk.org (Postfix) with ESMTP id 644BD40653
 for <dev@dpdk.org>; Tue, 18 Aug 2026 04:17:02 +0200 (CEST)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-38dd55ad76cso525445a91.1
 for <dev@dpdk.org>; Mon, 17 Aug 2026 19:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787019421;
 x=1787624221; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OyfkOGjBfFMNDa+kMAx0XlUTZWXEFCsfUrTWKzboZHU=;
 b=y6D2Y/E873O7EuqFKfCL5CQd1Runxnge0NYVKjYHQ2/xzgIq0dR2TCia644mNn/wCV
 /L2F3wMLG2M8/9vT+APGq5sV0szTLRuCiKqXbacIrpDyk3N08KIb/R6b7aBPiYoHKno9
 pWBqS1Vx/4uQL7QG5orx77rjXe+QYiNvl6jlPRaY0H96f+e8gjgmRIuuSEuvhZyXezWr
 fgh7rwdxKrKvSHazy6+N7hUWe1mmKlBJtMsfNu1/RMMSfz1NXzJ9kknQc1AsFLjQky5K
 SN3TrNWYjnP9P3W9Iuql0epIkotQKy4XQ6amnkXw5pT7889lVhNzr8WbXWgdgiMiqBe4
 yEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787019421; x=1787624221;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OyfkOGjBfFMNDa+kMAx0XlUTZWXEFCsfUrTWKzboZHU=;
 b=JZE3qzVvV0uHfncbGCJKJn00OdW3WtUuCshVGhkNH3T5bT44sPM2ewLUoQTIc9yHYC
 QpgyRsR9T/Lp7ukMZNlcdILPGRYhzfXqxa+CqSMYVwRqG0Nv2Z3JC0+nHbSNmugbIGAE
 /ll1VZs4TKTQmrlP720GcFldx/7db8DE0yEQpNkdkL/nw3mmmab/nQ16MwY2Y+XkHDZv
 JTY0vXDuqWNROf9YTS1U70EgGUF9FU8BPiAnKxmrNL0hnHzTXWAuxpGn6XSTRIn9b3dN
 hG4N6REB1rmKOACxVGZ0WehS3LhOMGeeUCuu0XUUbgLfrlb9xhtwum7vnNs6w0K4HPEO
 CnUg==
X-Gm-Message-State: AOJu0YzQiyOXZhfFL/4sF0GTKfqgzRN3tfKZHhgxnhw4ou1JPDppNhv7
 fJaxDcpXQ5zVtmusv3rGuWjjS+r5skL4EAhRH6J+UHsisKkAiCLZ45Gid7wu/r868K4nT5zeyRK
 +PGkk
X-Gm-Gg: AR+sD12+sWd/7y6PmFAcHE/OnllfSOOD4HU5hl5H1IIJzWghUMzV1b2B23GRg1iEnao
 SSvLr4dBnTJw7hOJsAtvyB3p+KHdF1e3mNqxLVDn40TZjW43n441v7KN3QlKj10fuRjOyc3h4vf
 GmoWCj1ItMLLoqc3FMnw2Fu7wicmzRK0XXqbf/CT67Z2/M7IT5pcSLBtpXITflrYg9Sambnf5aH
 bdviXfchfNGtwpli/R+qSi4Vv3gvXUz3oQxJOEsCbbqY8VFxdsAFVcaRow0m1n/06VmaxIIs8qH
 xVziKCEt+YMnlgR9givpSaqWJJF5vr2KARHi4TsBcC71TcKUcy1/kRYVjRD/OG9fQho33j00OlS
 Z4EhqecwBE4fIyk9ZSouzGNvxGp5ZEZ9OASgyuZvTT3+N2dB6hq9qu9R0Mc3VD2C/C6qsXbs0mT
 Lf6kpbSuLzXWBvZ6tlUmZTEpCFhh0JJ+FGjJtYQpwdcZAW6Q004yYapZhRxcENIP2I85JwhjGvC
 nw+xluPAJk72zY9UQ1TyKZVnE/Cyad54t4=
X-Received: by 2002:a17:90b:278d:b0:36b:de66:92c3 with SMTP id
 98e67ed59e1d1-3955f1739cemr2826839a91.10.1787019421395; 
 Mon, 17 Aug 2026 19:17:01 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267bf83fb2sm10201306eec.19.2026.08.17.19.16.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 19:17:01 -0700 (PDT)
Date: Mon, 17 Aug 2026 19:16:52 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] net: fix cksum calculation for odd-sized segment
Message-ID: <20260817191652.108068ac@phoenix.local>
In-Reply-To: <20260813202236.246588-1-eva.kurchatova@virtuozzo.com>
References: <20260813202236.246588-1-eva.kurchatova@virtuozzo.com>
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

On Thu, 13 Aug 2026 23:22:35 +0300
Eva Kurchatova <eva.kurchatova@virtuozzo.com> wrote:

> The rte_raw_cksum_mbuf() performs rte_bswap16() on return value from
> __rte_raw_cksum() for odd-sized segments. However, __rte_raw_cksum()
> returns a 32-bit accumulator whose upper 16 bits may still contain
> carries that must be folded. Truncating those upper bits by passing to
> rte_bswap16() will produce an invalid checksum if they are non-zero.
> 
> This is surely a rare encounter in practice, as most NICs have hardware
> checksum offloads, and even then encountering an odd-sized SG segment
> is not common, but currently such a case would miscompute the checksum.
> 
> I found this issue by accident when comparing RVVM networking stack
> packet checksuming to DPDK, and noticed that this looked incorrect.
> 
> Fix this by folding the odd-sized segment checksum before bswap16.
> 
> Signed-off-by: Eva Kurchatova <eva.kurchatova@virtuozzo.com>

Acked-by: Stephen Hemminger <stephen@networkplumber.org>
