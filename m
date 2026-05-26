Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314D6CD5BDF
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 09:03:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 687FB402F1;
	Tue, 26 May 2026 11:03:51 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7DF1F402D7
 for <dev@dpdk.org>; Tue, 26 May 2026 11:03:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779786228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XSw/Hw4p6pON8i70BE4e78/rWvuU3Y5u9rO5Uc106UA=;
 b=BLW06GAVGy2jiUNjjveAQEr/PJxa3kRrNEp4TrrLCs2bmkQsMveQg5btwe+yyBZwBo5Uao
 TtrvSYhfLxew/s6e4h8EISCBPNzI52e4ENzALAz11De8N1/fLzFBkDYi4I/lZ6qfX/03Xc
 yAawczcEU9R+7vJxthYjpaYdcwV1znk=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-Hb8giOj3PzuPCP06FrKxig-1; Tue, 26 May 2026 05:03:47 -0400
X-MC-Unique: Hb8giOj3PzuPCP06FrKxig-1
X-Mimecast-MFC-AGG-ID: Hb8giOj3PzuPCP06FrKxig_1779786226
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b9a3c3c4eeso104644375ad.3
 for <dev@dpdk.org>; Tue, 26 May 2026 02:03:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779786225; x=1780391025;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XSw/Hw4p6pON8i70BE4e78/rWvuU3Y5u9rO5Uc106UA=;
 b=IvrZlCgi4el2weA+tTyCNjLkoBKW4sDk0ELQLEEfO4jD3kP1ryGC5izFecK5SWbkOF
 zOzxLssj/Lbi2KuH8czzXMM7WpYCJMQ0IlM2DmvX4avIntLLqhKsrGn2PnOXXupZ3Jl9
 119Vxkqva9Xzv5kAhYKcZtTWa0hQYL7XfBtFhapn0FcBd1Ya7Auidx/ES+Smjq04Z362
 NKqFDGxqp0vVN+7LIj1lY8Ubj9wMWhj9fcPaHr9BllXZEJCQoLktK5yKSxkJpTcr2DTR
 n6xIP2JSv3I/DS5ezSR5PxI8qAolplnNTHGJGrIEQ0aJmPttL7pxiyeT7gufmGPpeKaz
 9GWQ==
X-Gm-Message-State: AOJu0Yx0d4WSruWmXISnSf6jwfMlpn/1NnD9UsEr//R4NVNSjb9u/7A8
 jGbf25A+rTHxX/R1hepE8FUvandb/NorpZKX9InJgseFECT0JwGj231CdbB7n8bpoCPkuKjch2j
 4JXA/VvCE7ZOvhVOvNdT5xPJNkUXmFTrbHakW5ZwuyhNJPnm2Ik1CfKbc0hz6iEjfeUJBlkHWVs
 ia7EEADOUW+wp3AVu/DFqMj+dIPgk=
X-Gm-Gg: Acq92OFy2nqtr5npx7chhXiFKezmMTXyHXg+1VLO+yKqe0g8XwBhuNZYm8NuDjlw2xc
 tZPXP99dYbMPWR4y666Pey6tUNWxbBvwoxe5uOZDKB/RGXdit30VtT1Yp3gUGZpBYYVFOyntl6M
 JzoDAo69JcXwp5Q7xEjVDsxKMhOdnWIOChfJ80ylLeURYwz+NtUF9rAHtp3wawOFjMifdkLbnkn
 UsNYiN9fSap/ALHlTm/5Szcy9OU3sbt774Yh1VkU8w8nZUJThHpIpG0tHlFaKX723jHvYXFG0mK
 kGhS
X-Received: by 2002:a17:903:3508:b0:2bd:9a28:7189 with SMTP id
 d9443c01a7336-2beb05a2183mr195058085ad.7.1779786224675; 
 Tue, 26 May 2026 02:03:44 -0700 (PDT)
X-Received: by 2002:a17:903:3508:b0:2bd:9a28:7189 with SMTP id
 d9443c01a7336-2beb05a2183mr195057675ad.7.1779786224154; Tue, 26 May 2026
 02:03:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260429114503.932575-1-david.marchand@redhat.com>
 <20260526084212.3145685-1-david.marchand@redhat.com>
In-Reply-To: <20260526084212.3145685-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 26 May 2026 11:03:30 +0200
X-Gm-Features: AVHnY4Jk0gvf-sUkskeKhO3Bx3t-1IUKOVFlVOIgYhKVeXeRrSQVedWd92mGoEQ
Message-ID: <CAJFAV8wAt1hyHrL0N1AxQ1kBjKoQNtuo89m_H7LHZJmtGea_gQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/25] Consolidate bus driver infrastructure
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org, 
 bruce.richardson@intel.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5Qg1tqHZJFzYK8gHwg7wXgpt1yH4nmrhF3VOV-hwwvg_1779786226
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

On Tue, 26 May 2026 at 10:42, David Marchand <david.marchand@redhat.com> wrote:
>
> This is a continuation of the work I started on the bus infrastructure,
> but this time, a lot of the changes were done by a AI "friend".
> It is still an unfinished topic as the current series focuses on probing
> only. The detaching/cleanup aspect is postponed to another release/time.
>
> My AI "friend" really *sucked* at git and at separating unrelated changes,
> so it required quite a lot of massage/polishing afterwards.
> But it seems good enough now for upstream submission.
>
> I would like to see this series merged in 26.07, so that we have enough
> time to stabilize it before the next LTS.
> And seeing how it affects drivers, it is probably better to merge it
> the sooner possible (so Thomas does not have to solve too many conflicts
> when pulling next-* subtrees after, especially wrt the last patch).
>
>
> This series refactors the DPDK bus infrastructure to consolidate common
> operations and reduce code duplication across all bus drivers.
> Currently, each bus implements its own specific device/driver lists,
> probe logic, and lookup functions.
> This series moves these common patterns into the EAL bus layer,
> providing generic helpers that all buses can use.
>
> The refactoring removes approximately 1,400 lines of duplicated code across
> the codebase while maintaining full functional equivalence.
>
> Key changes:
> - Factorize device and driver lists into struct rte_bus
> - Implement generic probe, device/driver lookup, and iteration helpers in EAL
> - Introduce conversion macros (RTE_BUS_DEVICE, RTE_BUS_DRIVER, RTE_CLASS_TO_BUS_DEVICE)
>   to safely convert between generic and bus-specific types
> - Remove bus-specific device/driver types from most driver code
> - Move probe logic from individual buses to rte_bus_generic_probe()
> - Separate NXP-specific metadata from generic bus structures
>
> Benefits:
> - Significant code reduction (~1,400 lines removed)
> - Consistent behavior across all bus types
> - Simplified bus driver implementation
> - Easier maintenance and future enhancements
>
> The series is structured as a progressive refactoring:
> - Remove redundant checks and helpers (patches 1-5)
> - Add conversion macros and factorize lists (patches 6-8)
> - Consolidate device/driver lookup and iteration (patches 9-11)
> - Refactor probe logic (patches 12-15)
> - Remove bus-specific types from drivers (patches 16-23)
>
> Note on ABI:
> This series breaks the ABI for drivers (changes to rte_pci_device,
> rte_pci_driver, and similar structures for other buses). However, the DPDK
> ABI policy does not provide guarantees for driver-level interfaces.
>
>
> --
> David Marchand
>
> Changes since v2:
> - fixed dma/idxd probing as reported by Bruce,
> - moved api_ver setting (from match to scan) in bus/uacce,
> - fixed transient bug in the vdev code (in the middle of the series).
>   tl;dr the high level difference for bus/vdev between v2 and v3 == 0,
> - fixed doxygen,
> - enhanced API description,

There was some hiccup from Red Hat SMTP when sending the series..
hopefully my resending of the second half of the patches is good
enough.
At least, patchwork looks happy.



-- 
David Marchand

