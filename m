Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578CDCDB46F
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 16:05:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6504C402D5;
	Tue, 23 Jun 2026 18:05:49 +0200 (CEST)
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by mails.dpdk.org (Postfix) with ESMTP id 179C840150
 for <dev@dpdk.org>; Tue, 23 Jun 2026 18:05:48 +0200 (CEST)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-1397e093f90so661589c88.1
 for <dev@dpdk.org>; Tue, 23 Jun 2026 09:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782230747;
 x=1782835547; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gGNCjJpcccNFOI5ZRPT9TlKPXr4xQU5TyX3LrqvAvls=;
 b=vTavXbU8/3uyxP6RWqjAx0kDCqyIitxYKxD+Ot5CbJ/CwuSGx99Jc91RGQi662n5NA
 T1iIuCgSpAFzSAXGjZYG9GFC2/blhUsUBw97+TFe2z+YG7RYn0NbLhcW7wzCqPXUk6SR
 zMnBYYf8OYB9j0FSWO2zxiq5mWAFS7EmHDoGyhHznEdifXnOHjTPQ5M7iUBO01TsAuo6
 TCML/dnIMa4PMcdTTPmwJr6LxV2iPiLVpfLzdOnO7omVyBe/dAaHc9vr+DAI110xK/uy
 G5eGRWaV6cOmODpQt2vtTxDmxlJDqeP47T4KKoeS3jBLXQzoYRH5E0BEKI862kzuDF/F
 A8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782230747; x=1782835547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gGNCjJpcccNFOI5ZRPT9TlKPXr4xQU5TyX3LrqvAvls=;
 b=AsBd7lTfgFVecz3RE7CPuIfcBpaCuDbwZDsNwCSJXACrS4aCMf7yvXvFLgXQWBmYw3
 i0KjHl/Rmc4RmShaNP+Yh3FXorpRa64ZInbUvPOOobM63UgGoNHIe0HjXkZKKgU7UdJP
 9YuGsjDUp9SlTO24vwnjO3igWc3xer2PImMIqIDhn2om6sagRvnXf9U/mqko3LISOcdi
 N+8aQKyyOk9YyQw80O8ButI7z1KEAHVr6nxFuIcrZsniLEkNK9i85GbLBrpfrkSj0uR+
 C2CRLhDXbrUnB/u9Dach6SCq6H5q7Mebqr02fsMTdhzXb4uNH33W3zIQmHl45JY7sjHY
 2ksQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp4lx1RDafJ23Wy0yAL2fJ6t/obSnuIjjYq5HeV6O5+XW7tA6mjhfYsP70rUL/5r77YasM=@dpdk.org
X-Gm-Message-State: AOJu0YyrWSG1z5aVgWsFNK6z6aaRKUv8xbvqutO3ej7pxDMzYGkK11Iy
 gt915lFViUxRfjdE2hP6kzZ/Q/tXdZ/QvNFr2yEC7l79ebW0TD1IcfyxLA9NG/5vMMHocykxtif
 +bZJE
X-Gm-Gg: AfdE7ckajHH0bW9jRwZXeQfVwccMd0WL5EdD+ZEZvSXhgq0mO1bAbnZkJXPKjhyDuHu
 /nKdfWgWfHuWMUJYeu1HDgXuwrpGhJHNgnDo4mvf0jfVJ8GO26OpmrkNjaH10YIDGSYFaFnBM2E
 0juW0/F9ek5sEVdR/1XnPXrA6hPQfvsEmcHmCT1WKoEbGMe9+YdAgjFUYsZOaQADMbgKA10eTHF
 FnuLbLwluN8RJ84NcJu5/Mbt+iQfRORJWN9ANPDoYxHU41sKnrEuNCLFe2IEiu/LIyKiDUzdTWf
 jqaGQ9LPULQdn1b+LLkbeinuTn/YjCRhKwqFmMP40SxV8RAXrub43HrxTfqT+MhMyNeMX3Dhpzj
 q8UifF43jxIR6bVx+HSqqs5b5pVPw51A4xJLNJmNV9cmV44qlvFHeW3tMZxRwFCHRYk8wSQBzX1
 7DepXBECTfCxUFa1RR+mwRmIwZ57TVbGsB1oM9JiwJwI87BqfcF8pwfg==
X-Received: by 2002:a05:7300:fd0f:b0:30b:dd58:e167 with SMTP id
 5a478bee46e88-30c07038f73mr13973849eec.29.1782230746561; 
 Tue, 23 Jun 2026 09:05:46 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1ba635d8sm18913399eec.10.2026.06.23.09.05.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 09:05:46 -0700 (PDT)
Date: Tue, 23 Jun 2026 09:05:43 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>, "Bruce
 Richardson" <bruce.richardson@intel.com>
Subject: Re: [PATCH 1/5] eal: fix macro for versioned experimental symbol
Message-ID: <20260623090543.5b79181f@phoenix.local>
In-Reply-To: <rg475uc6ktrpsqfu32jmcfhluqlopy43kiwsonogud2z4aul7r@qwibo7j5yfk6>
References: <20260623113752.1100072-1-dsosnowski@nvidia.com>
 <20260623113752.1100072-2-dsosnowski@nvidia.com>
 <20260623065000.57d775c9@phoenix.local>
 <rg475uc6ktrpsqfu32jmcfhluqlopy43kiwsonogud2z4aul7r@qwibo7j5yfk6>
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

On Tue, 23 Jun 2026 17:26:22 +0200
Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:

> On Tue, Jun 23, 2026 at 06:50:00AM -0700, Stephen Hemminger wrote:
> > On Tue, 23 Jun 2026 13:37:47 +0200
> > Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:
> >   
> > > Add a missing semicolon after __asm__ block in
> > > RTE_VERSION_EXPERIMENTAL_SYMBOL macro.
> > > It's lack triggers the following compilation error with clang:
> > > 
> > >     ../lib/ethdev/rte_flow.c:320:1: error: expected ';' after top-level asm block
> > >       320 | RTE_VERSION_EXPERIMENTAL_SYMBOL(int, rte_flow_dynf_metadata_register, (void))
> > >           | ^
> > >     ../lib/eal/common/eal_export.h:75:74: note: expanded from macro 'RTE_VERSION_EXPERIMENTAL_SYMBOL'
> > >        75 | __asm__(".symver " RTE_STR(name) "_exp, " RTE_STR(name) "@EXPERIMENTAL") \
> > >           |                                                                          ^
> > >     ../lib/eal/include/rte_common.h:237:20: note: expanded from macro '\
> > >     __rte_used'
> > >       237 | #define __rte_used __attribute__((used))
> > >           |                    ^
> > > 
> > > Fixes: e30e194c4d06 ("eal: rework function versioning macros")
> > > Cc: david.marchand@redhat.com
> > > 
> > > Signed-  
> > 
> > I didn't see this because clang doesn't have symver support.
> > Which version of clang is this?  
> 
> clang 19 available on Debian 13:
> 
>   $ clang --version
>   Debian clang version 19.1.7 (3+b1)
>   Target: x86_64-pc-linux-gnu
>   Thread model: posix
>   InstalledDir: /usr/lib/llvm-19/bin

Ok, that was the asm block not the symver attribute.
