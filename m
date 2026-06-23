Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3A8CDB46F
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 13:51:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF9724065C;
	Tue, 23 Jun 2026 15:51:10 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id E0BE9402B5
 for <dev@dpdk.org>; Tue, 23 Jun 2026 15:51:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782222669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rk2PPvUWiC4ugWy320JpravOt0oUFv2/BXJmOv8iylY=;
 b=JqRydxXVoYbEAmeawPH//efceYkEjl53wZRWME8c6ZApgxYhfTLIoN0P2QmEU/T7pfW9T1
 73cvnlueLfXZzqYRgsK90rZGqjGHT/cplyQbuD1LpkhgIgVo27OmQy1P/+SC2W/bWSbreH
 9cKX537rB+HQYK739pOYMzIEltEzmLQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-yL631gjlNa-3rvNZhDXFdA-1; Tue, 23 Jun 2026 09:51:06 -0400
X-MC-Unique: yL631gjlNa-3rvNZhDXFdA-1
X-Mimecast-MFC-AGG-ID: yL631gjlNa-3rvNZhDXFdA_1782222665
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5aa63daf1a6so3503460e87.0
 for <dev@dpdk.org>; Tue, 23 Jun 2026 06:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782222665; x=1782827465;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rk2PPvUWiC4ugWy320JpravOt0oUFv2/BXJmOv8iylY=;
 b=MxRYQQJ+LiLczd9qyUXfIe5ICGfpV7jP6sF0en1ztGSlYmYUXPlxwqmfeUsDP+eQ9u
 5DSKkqCTzBS4fpBDGvy/ZapgMI7x1YZASwCXmBpleH5fSvrEC3fcxtb45gvhU/bwOX1t
 NETBaOhGlxqlP415BpzH/EXPt5f8osPkBMXIt11nt4uleJDtORbgo+YYvMcRjLxsvWeN
 aWMsBYAJR1MAgKsA+p+0repLQdIlzpsb8f26B3hOJVejgEkPhbFZxgbq/UlcQUWPliky
 TmHC1E7F/jifaMhf1LZ6GEolXzcHCsewkhmcDbNBkVck+/oxefHgz5PlTHC6WzQhgfLi
 3m0w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8zOcgslqIF3hNSK+XrHRcu6zW9yVD++mUGhMV9IPHnnKILMaTrixGJJ42t5RXcl3aHmu0=@dpdk.org
X-Gm-Message-State: AOJu0YxQrlWTpxfU+BktvhUDJgu0jxON6aRnPl/dIGjznkc6IPhMg3Fk
 CAl5zdRuwlJeq/1r2v5kz/L9GRAQRBFA1O4eAY1I5bfgLV7o6aA3Z5lYDL9rfrJ7E7a/Niv0Vz3
 oZeIqPoou6rTbBaC2cZ4PBnjICSG6ja+oqQLOe0Jt7+H9y2RudKmfsFLrcVPGGQKXlAA2FaN5Dk
 eUtll1sIxug9SZFtuj9TE=
X-Gm-Gg: AfdE7cnJoLSQX/6KDm7Jzs25fQePMmmwmfEFCvkR+bcpa1UjJETUszM08NAxqfzlFIw
 SDbdgubwHSmchs28UXSrm1tF9nDFt8/8uFXgDl7k2UOYL9h9lC2/t9N6FXX6i+QTLG7rVStnWgH
 dMKaMsbyQ9jN4NSi6kruvwXZHqTk71bjJrqlGkXuFWVESKj8cOBUZyivukPv2touYQandUUIeWy
 lTM+PrhEj5stNqxE3/gxpTl3hD4wLp8ZQKrmPXb6It4Jiuq9n4BMjX2jdo=
X-Received: by 2002:a2e:9a14:0:b0:399:778f:6ee8 with SMTP id
 38308e7fff4ca-39a27eec0efmr6414531fa.25.1782222665088; 
 Tue, 23 Jun 2026 06:51:05 -0700 (PDT)
X-Received: by 2002:a2e:9a14:0:b0:399:778f:6ee8 with SMTP id
 38308e7fff4ca-39a27eec0efmr6414331fa.25.1782222664474; Tue, 23 Jun 2026
 06:51:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260623113752.1100072-1-dsosnowski@nvidia.com>
In-Reply-To: <20260623113752.1100072-1-dsosnowski@nvidia.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 23 Jun 2026 15:50:52 +0200
X-Gm-Features: AVVi8CfoDhmUabxNOGegdBMNmkmg2J1UDRUn8-NgTaAb9OVKZYBL0tFfVJShwTg
Message-ID: <CAJFAV8yS6dLM2EUDgdG13U1Zdt208nmk2T3F8DYwT97U1coF3Q@mail.gmail.com>
Subject: Re: [PATCH 0/5] add versioned symbols for recently stabilized APIs
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Thomas Monjalon <thomas@monjalon.net>, dpdk-techboard <techboard@dpdk.org>
Cc: Bruce Richardson <bruce.richardson@intel.com>, 
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, 
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, 
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: D_bYYhxUS3eg-vWv7do4zaEch2d1k1xys1DVx8sGJPU_1782222665
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

Hello Dariusz,

On Tue, 23 Jun 2026 at 13:38, Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:
>
> Main goal of this patchset is to address https://bugs.dpdk.org/show_bug.cgi?id=1957

It is expected that experimental symbols may disappear overnight, and
this bug could also be closed as NOTABUG.

On the other hand, we do state in the doc that compatibility could be
provided when stabilising an experimental API, so ok.. let's try.

> but it also handles other recently stabilized symbols and has some minor fixes:
>
> - Patch 1 - Fix RTE_VERSION_EXPERIMENTAL_SYMBOL macro on clang.

Ouch... /me hides.


> - Patch 2 - Allow function versioning inside drivers.
> - Patch 3 - Version the function symbols stabilized in
>   https://git.dpdk.org/dpdk/commit/?id=e8cab133645f5466ef75e511629add43b68a5027
> - Patch 4 - Introduce versioning macros for global variable symbols.
> - Patch 5 - Version the function and variable symbols stabilized in
>   https://git.dpdk.org/dpdk/commit/?id=4ee2f5c1cedf9ee7f39afa667f71b07f4004ba5c
>
> Issue is still not fully fixed for stabilized global variables:
> rte_flow_dynf_metadata_offs and rte_flow_dynf_metadata_mask.

Well, symbol versioning is not something for variables.
Exposing global variables was a mistake from the start...
Those were exported for "performance" reasons as those are accessed
via inline helpers (but I am not sure there were benchmarks showing
the benefits).

I am for forbidding exports of global variables from now, unless some
really good performance benchmark is provided (@techboard for info).


Now, in practice for your issue, rather than reintroducing symbol
aliases (technical solution that I dropped when refactoring the
macros), I think we can do with some middle ground approach:
- leaving the inline helpers as "stable" (not __rte_experimental),
- restoring the EXPERIMENTAL version on the global variables, this
will restore the location of those symbols from the previous ABI pov,
and the checks won't catch this discrepancy anyway,
- during 26.11, drop the EXPERIMENTAL version on those variables,


In other words, stopping at your patch 3 of the series, then adding:

$ git diff
diff --git a/lib/ethdev/rte_flow.c b/lib/ethdev/rte_flow.c
index ec0fe08355..8bd21ccd31 100644
--- a/lib/ethdev/rte_flow.c
+++ b/lib/ethdev/rte_flow.c
@@ -23,11 +23,11 @@
 #define FLOW_LOG RTE_ETHDEV_LOG_LINE

 /* Mbuf dynamic field name for metadata. */
-RTE_EXPORT_SYMBOL(rte_flow_dynf_metadata_offs)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_dynf_metadata_offs, 19.11)
 int32_t rte_flow_dynf_metadata_offs = -1;

 /* Mbuf dynamic field flag bit number for metadata. */
-RTE_EXPORT_SYMBOL(rte_flow_dynf_metadata_mask)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_dynf_metadata_mask, 19.11)
 uint64_t rte_flow_dynf_metadata_mask;

 /**

> Patch 4 and 5 address the bug for these global variables,
> by providing a single storage for both EXPERIMENTAL and
> DPDK_26 variable symbol versions.
> This is achieved through symbol aliasing.
> But this solution is limited only to executables compiled with clang.
>
> clang and gcc have a different default behavior regarding relocations
> of global variables exposed by shared libraries.
>

Yeah... not even thinking about adding MSVC in the list...


-- 
David Marchand

