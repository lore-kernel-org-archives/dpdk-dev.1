Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356DF606A319
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 23:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=ib/EPBJz
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55FCF402D4;
	Tue, 20 Oct 2026 01:35:24 +0200 (CEST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id 19895402D4
 for <dev@dpdk.org>; Tue, 20 Oct 2026 01:35:22 +0200 (CEST)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-3ac451e128cso1642869a91.1
 for <dev@dpdk.org>; Mon, 19 Oct 2026 16:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792452922;
 x=1793057722; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WLBrw4RfV4cRPZrc5VBsPaAgN/gZ2+i1RCQaetVEbXg=;
 b=ib/EPBJz6y7YYFABhlp9hcGzg/Irp4i/LsKv2CFPLd6vyeVRtlRydJXjgpBnqQ4plh
 z9uFqZmogOGrrGKp7B1ohXLPm7JxJlgPaxcqXW5HvAEV920n5GZCpRhjxrVWaO8FNk8u
 YatVYF9SxO7gwzg0bn8akcucLUpJTGlhwqrVyKBWhBfe1B074LeilH5hniuDylXbqTsw
 K+zHazaACYCfgxMENIM0O126fTkN8YezLl9oueI5ratr7jk/Ds+wtxfKo9cn91Y7PIuZ
 oG+sVoiG9xZSYccxj6fVxu7Aj8K1QgIMiNyCw5NLSJ2k26wW9CB9+kA+dXxEygvzwxGL
 w+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792452922; x=1793057722;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WLBrw4RfV4cRPZrc5VBsPaAgN/gZ2+i1RCQaetVEbXg=;
 b=Q+27hftmx+qg2RMi8FFP3zhNrfKhehMuw7vbsGCXvtFgMPUo7NTqMPnwlPejSkr3BG
 1JtIMBrZYohVPZxSvFAQOFGgvgfZFl/Cdk4s0LqRI0vDKZGqYt/vZHFLaOyhRHeaU29+
 DTfuWl6PhxpYu/6ERRNxsR6j+kjUbruaSIa8dnZSbSZaMBfq8lLW/cPhMdIVsXGc9Z1U
 uDP38F+Fer/uVIv8pXDivpCTEvrcdUMi2wM6o48jH8tgDvKNtji64UMN2y1BhPSAzrrE
 ml4ux6KM70br2U/J2hTvuRZ0xC0SsOdfNL8QIFAdzIVs+LVZrbmUP50CrrpDcdoxr6fb
 pZ2Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxFk6N5A/XANkrUnuelVjEmnuSPGGb+gEnyyuccQSfRfejj0mzO8m/nhISBjOZTRZc4jw0=@dpdk.org
X-Gm-Message-State: AFq9FYIlpVPkBInW/UHtsIavyA+YyevJbagBs6mNJGrm8m3Y7n8hfnd1
 7TLvKTqxD2ugXFXFl3LNiGVhuanQhP8xQKdst4iypuQlHhEL4QJWj91HkNGUEW+iDE4=
X-Gm-Gg: AYBFou3jRN54LA5C2ADdpB0uAJOtRGR7y23TrXaDdf9aGAntD+LvLJ6n7QjuI2myXRR
 aZAK76z1fhrdIvgLh5SVFqvNjNIejqEVjvxPaWMOLZRx7K0P4HsMHN8RcelJ8qSVEHHcLNzv+Cl
 R2YK1KJkRRFL8hWkcUcCxRM2V6zMAGUSl8Dp4i4E0wZhRNOJ27szrZVh+SHAKgroTivB3R0nVuT
 ecG9JFL1ojw2Mnf+hWlfvkI51MRQPCikSIlEw9yxkzBiENZy7SR/kQL/NJEld6CQ9avJEzvTJHt
 USI8h/1kqqy40ouxYkmb34SXyb3ccBz31njGretL9JMkB/wIqAI3eTE2N3HHS+UmyWj/fNyklIT
 SzMFqKfQVjQVAh4WZoV03Vb1WAwpmcgDYxRJTikgHwfviwUINz8H0PHfX0dfi7UZAa3BZc1m2A1
 ZyYpozZjpCSYMbGRMM7LEcdPa7WVRtT7bm4VIL+a53qXS5OC4iaLemYYxpeL40lW+iHjWyJ9S9j
 JE74BZyj63a4IfNVLqwsen5MZDCzoVZObhNODAb
X-Received: by 2002:a17:90b:1d4d:b0:3a4:ba6b:cc24 with SMTP id
 98e67ed59e1d1-3acef5c99f8mr6455742a91.58.1792452920956; 
 Mon, 19 Oct 2026 16:35:20 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acd0cde4fdsm9252119a91.4.2026.10.19.16.35.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 16:35:20 -0700 (PDT)
Date: Mon, 19 Oct 2026 16:35:18 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
Cc: Marat Khalili <qm2k21@gmail.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, dev@dpdk.org
Subject: Re: [PATCH v2 2/9] bpf: document ethdev callback threading limitations
Message-ID: <20261019163518.1b6fd3c7@phoenix.local>
In-Reply-To: <e5ff5f2b-de4c-48a7-bc0d-3a7392bb6e1a@yandex.ru>
References: <20261011182158.124246-1-qm2k21@gmail.com>
 <20261012210917.161343-1-qm2k21@gmail.com>
 <20261012210917.161343-3-qm2k21@gmail.com>
 <e5ff5f2b-de4c-48a7-bc0d-3a7392bb6e1a@yandex.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 19 Oct 2026 22:10:11 +0100
Konstantin Ananyev <konstantin.v.ananyev@yandex.ru> wrote:

> > Document the data plane limitation in the file docstring of
> > rte_bpf_ethdev.h: packet callback execution expects only one
> > thread per port/queue pair at a time, making concurrent bursts
> > (such as with RTE_ETH_TX_OFFLOAD_MT_LOCKFREE, shared RX queues,
> > or multi-threaded software PMDs) unsupported.  
> Not sure what do you mean by:
> 'shared RX queues' and 'multi-threaded software PMDs'. Can you probably 
> clarify?

The restriction is that: rte_bpf_eth_tx_elf_load() can not be be used with RTE_ETH_TX_OFFLOAD_MT_LOCKFREE
because if that offload is set, application is allowed to share a single transmit queue across multiple lcore.

It would be better if the attempts to load on such a device failed.
But in the is not enough because at least in theory a user could enable
the offload later by reconfiguring the device.

