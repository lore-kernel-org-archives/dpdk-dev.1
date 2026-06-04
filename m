Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75C6CD6E6D
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 14:55:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C23AF402CC;
	Thu,  4 Jun 2026 16:55:15 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 70FB5402B6
 for <dev@dpdk.org>; Thu,  4 Jun 2026 16:55:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780584913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zXSXFpXVd6fBE9uKXmk/0gDTEcP7s8Uw6gpstAnoEIg=;
 b=axB3itnVRGXvqHy4X6DEjksa30L7FG22mLnabQqGRldh67XSHdfVavDiDbVD8PMju3PqyK
 VGe7rl+msuMGP5+6f+MkH3IXWuzTPMXTNxtu64ujk3LHzTLmpsl27oKCMEWR3e1/Di4Kab
 T8TR/XJe1S6BG1vlSWWO+DuxwW9aVjo=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-WpIwP-3dPWaYgQ10NdVB2w-1; Thu, 04 Jun 2026 10:55:12 -0400
X-MC-Unique: WpIwP-3dPWaYgQ10NdVB2w-1
X-Mimecast-MFC-AGG-ID: WpIwP-3dPWaYgQ10NdVB2w_1780584911
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5aa66891fa0so652892e87.1
 for <dev@dpdk.org>; Thu, 04 Jun 2026 07:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780584911; x=1781189711;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zXSXFpXVd6fBE9uKXmk/0gDTEcP7s8Uw6gpstAnoEIg=;
 b=XkQ209pOQ/xxjMhqFo3AEfkxL+xWRx+SFnGo6OIQS7gQ00Yj+bB29zas4BM3Cr83OQ
 fvDMoe783uWhTMcNBOo88yvlFOp1rUTORo1Oh693Tp7IQNi4PYd9T3wgu4C0cx1+AfN6
 3S/MEzdYnkdstS1Pk8jWnhXgnUOFjI5tmfm6ULn6ZSvBinDOtEIZ74HaavjDZ4yrtM1e
 IIDIJPICxrxJCKJNMeWgMMdEz1k+SSHL2+fBqlPCo6s/hF02Wd1PEccilpoJqWp3ytwl
 JK625qTiEJVrBF0jS5nh6wX/yDmWdwLFOJOQn2XgHZRI3xgyYJgHR4Hkx7zgjNyJesj3
 0jQQ==
X-Gm-Message-State: AOJu0YyAsILClA3SLV0tweJE0/+TBQC8LRDA48AOFflcwCI3ijmM7F4k
 2IUF+309wYNkJxKu4LxtbtObT3O1JgBf1djgi6bK6jmvkVpwdZgg9d3U4x1QA47uQna92pnXukk
 +JxAlQpd+QeX76ItPXuledLczp9VuZJzCBngMsSdyIL6HFu9j3MS3no1TBogxeF6ebOyW528uU6
 yank+P5j3KWAzM7O0Djlc=
X-Gm-Gg: Acq92OFtKbl1fp6CcyGMENEmfNFW6FLxZCSPNbh+jS3sgm6NgB2bm1Uh6J8vIjotMAB
 MMKIZaGVVmqGV7bv5Bgr0ZtA7LXzumt1KJlaMpsJhBlVyekNsnd5X9cwE1g1BqvyM+Vw8PaBJH1
 BpxaTn08nn1HjM7QsvTzHp34fcPYXYzowliVbSOmLGefYqGQ8l9OtBcZIMOK5ESlZ2ldvR6tBdp
 YHhCS2vSXL1J0NC8oORK0TsmIDwlIKgMg3PeDI54QhaNu0pc2oWB3Sbn9/XXxeSvDczYkmNRyyY
 3YtP
X-Received: by 2002:a05:6512:2252:b0:5aa:6ec6:257f with SMTP id
 2adb3069b0e04-5aa80c82b73mr1085588e87.10.1780584910475; 
 Thu, 04 Jun 2026 07:55:10 -0700 (PDT)
X-Received: by 2002:a05:6512:2252:b0:5aa:6ec6:257f with SMTP id
 2adb3069b0e04-5aa80c82b73mr1085580e87.10.1780584909980; Thu, 04 Jun 2026
 07:55:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260429114503.932575-1-david.marchand@redhat.com>
 <20260530075201.869606-1-david.marchand@redhat.com>
In-Reply-To: <20260530075201.869606-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 4 Jun 2026 16:54:57 +0200
X-Gm-Features: AVHnY4IY5S2WvC1S5PEF41wTpfMEgUcqRbkqgFQXHlRcPkHvVki2XAiWnUlliO8
Message-ID: <CAJFAV8zvFpLwz8SY8DUUezyJyM43eRZ17Yj30ex808eHC4ZE=g@mail.gmail.com>
Subject: Re: [PATCH v5 00/25] Consolidate bus driver infrastructure
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, thomas@monjalon.net, stephen@networkplumber.org, 
 bruce.richardson@intel.com, Chengwen Feng <fengchengwen@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QpxUtmCevLZzRnsQio9kTJAvSVkx1jsGM2IItPSNjGI_1780584911
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

On Sat, 30 May 2026 at 09:52, David Marchand <david.marchand@redhat.com> wrote:
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
> - Remove redundant checks and helpers, fix existing bugs (patches 1-7)
> - Add conversion macros and factorize lists (patches 8-10)
> - Consolidate device/driver lookup and iteration (patches 11-13)
> - Refactor probe logic (patches 14-17)
> - Remove bus-specific types from drivers (patches 18-25)
>
> Note on ABI:
> This series breaks the ABI for drivers (changes to rte_pci_device,
> rte_pci_driver, and similar structures for other buses). However, the DPDK
> ABI policy does not provide guarantees for driver-level interfaces.

Thomas pointed out offlist at a leak in the bus cleanup updates (patch
6): not-probed devices are not freed when calling the bus cleanup
operation.
I will fix this in a future series (hopefully for rc2), after
refactoring the cleanup/unplug code flows.

For now, series applied for rc1.
Thanks for the reviews!


-- 
David Marchand

