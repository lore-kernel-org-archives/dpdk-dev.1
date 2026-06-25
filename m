Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A204CDB47F
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 07:35:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE5D140280;
	Thu, 25 Jun 2026 09:35:07 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 56D084025F
 for <dev@dpdk.org>; Thu, 25 Jun 2026 09:35:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782372905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QsYZaXHjPU+1Y5YDY3A+FdL4/JFdzXQjsJIwF9qxWwk=;
 b=Q2+oMhpme3lFFdtRud9tdepPdF7vcfGm0Lu/mHJ+/+Forq1lrlHszBWNn9Xs5WRDjzmrKB
 EIRl628YXFCni1YS1KzEg+UtWOoWzt4PL/Iq5V6XvNfojJtAkWQHu6geW0yaPk/DQ1LnHd
 rz9KA14BQdSp7S//jg9CeqHG3CXSITc=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-WBKds7PIOEm-JXgVpdpWHg-1; Thu, 25 Jun 2026 03:35:04 -0400
X-MC-Unique: WBKds7PIOEm-JXgVpdpWHg-1
X-Mimecast-MFC-AGG-ID: WBKds7PIOEm-JXgVpdpWHg_1782372903
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-3998d89ef9eso7654171fa.1
 for <dev@dpdk.org>; Thu, 25 Jun 2026 00:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782372903; x=1782977703;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QsYZaXHjPU+1Y5YDY3A+FdL4/JFdzXQjsJIwF9qxWwk=;
 b=Z7dxdgb2oZsUAy3ZGwxxh+WJMP8kpixcc0uJQjwLcELv7rWw/4j5B12pWS+6jzGk6P
 XDMyibJp3Wd7CDNoc/k9FFA04RQymA0i68PXqnVZLCVZugob1POMhOFqq6F7WQjFVd2N
 hR0oT4QaqHA1cC+b3XS+JL5SS+/LNfaYQPDqBF5D49656uzW7tqVej37cCpnvBpUZCno
 kPDGRZ6WdjsVndpvjFqAnYmVS9zVnvGy7CPn+r8drAshoog/lrM9Tpo1DmxOtxDhv9IX
 sPTKLgYfso/XRW7S2lYCnQP+ksfPoBP20hiETneS/ctGSNOUcs48lm7SyaULxHJ29VpV
 A7IQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr0tKkXASIwdVQ61QOH8h/Yh8u5I/cbwjzW93n0mm6H0tewG0OxHmdEzVVi70dm5vwCAzM=@dpdk.org
X-Gm-Message-State: AOJu0Yz2Ecn4X4Mou5TO7PTW3MxVs53ag4fMP8NKx1e1w0cJWASkl9Kf
 GcahyPn2bIcX+r+iTCq/u/BNNqdZ0fXVjZ03GOZ6wlNsnZL1U3S/jwGEw4UOIvj1piIfbS/AJ6s
 JBIjek1SmJM6E8YlEOgl1USJM/893Uykxdl5RF1M5Ji2A1UITmfVzcfM3pTXukPqhHYFmSSgenD
 lfyUpE3AF2clSLpcdQK6E=
X-Gm-Gg: AfdE7cmbgAuQ9eDo0xPF+m9YLcENPo8dM4NtwUARrhA+Y50yHuyMfEfWSo2bnbm1gPG
 dkGQGlZmmmb9bi6kErttxss/+T+xVK4dfPqmwgjNl44LQec16dr8KVwJwozfJNJcRdMVZxefOM8
 2WHeehnWJY4LJmuziCjIHfTGiU3VHDLhxrdXxZjzspdvwKws46PXmnOpHQjZoBDHPywmgSqEAcw
 FyFbh6tOMOhtGI6jGNnlZvOweii7B/n1H62KQFEBJL5RiHjpXbFsgVv3K4=
X-Received: by 2002:a2e:bea2:0:b0:38e:e29c:9dc0 with SMTP id
 38308e7fff4ca-39acb8fe4a8mr2630601fa.20.1782372902948; 
 Thu, 25 Jun 2026 00:35:02 -0700 (PDT)
X-Received: by 2002:a2e:bea2:0:b0:38e:e29c:9dc0 with SMTP id
 38308e7fff4ca-39acb8fe4a8mr2630491fa.20.1782372902389; Thu, 25 Jun 2026
 00:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260623113752.1100072-1-dsosnowski@nvidia.com>
 <20260624131337.1127323-1-dsosnowski@nvidia.com>
 <20260624131337.1127323-2-dsosnowski@nvidia.com>
In-Reply-To: <20260624131337.1127323-2-dsosnowski@nvidia.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 25 Jun 2026 09:34:51 +0200
X-Gm-Features: AVVi8CcbAyuewskaBEp-Rq-76JQdIhDw-Bw1Wb0-wuRQZE7l6BvgIyUNaVM79DA
Message-ID: <CAJFAV8yA0HzKGqMCW_pxpR6u9sO5h-pv4WNK-QJ4H-uRw7vUUA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] eal: fix macro for versioned experimental symbol
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org, 
 Yu Jiang <yux.jiang@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LCET89XwTLxwJsvhQ2mLA1lYjmfWhZQHugBdpTZDXH0_1782372903
X-Mimecast-Originator: redhat.com
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

On Wed, 24 Jun 2026 at 15:15, Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:
>
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
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Thank you.
Reviewed-by: David Marchand <david.marchand@redhat.com>


-- 
David Marchand

