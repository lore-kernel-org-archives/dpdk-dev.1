Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F53D715D6
	for <dpdk-dev@archiver.kernel.org>; Sat, 24 Jan 2026 09:00:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70B2B40293;
	Sat, 24 Jan 2026 10:00:11 +0100 (CET)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com
 [209.85.217.44]) by mails.dpdk.org (Postfix) with ESMTP id AC1854026F
 for <dev@dpdk.org>; Sat, 24 Jan 2026 10:00:10 +0100 (CET)
Received: by mail-vs1-f44.google.com with SMTP id
 ada2fe7eead31-5f535ff78abso2573157137.1
 for <dev@dpdk.org>; Sat, 24 Jan 2026 01:00:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769245210; cv=none;
 d=google.com; s=arc-20240605;
 b=MoV6WoruCFm2by/RI2CtleB3Z+VIK5l+GtW6SkqGmno28qTOi1LRl8dcfM0i2jBb84
 m1aD2RtOMRSszoGTKzrf+LSUrjgS3UxaLPvcg871EhtaYeJGO0ic905uyhiphApK+ZbL
 PyEb7Vkqsby16BS2+L1H1CLTQuynpVyI/JARc+qpnVh4TTTQhMGf8xvBrS5iNBHLTSHF
 lbZOCCjnOPdxV/WyrueiIm/b12YmOY7/TJm74h0oWUY8R3mtjSCJkftrC/Allh7SSYV9
 dSGxK6LGlaG4TW2NtPfGZri2Z7sFUYT5SoMsJjUGcaiGiydNRMyBov25EEmlffkxPfmx
 rAbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=sETJlyosKU11l2SCkz0Idt5WCGlSvoFnGkOt9WcjCco=;
 fh=9GDrS3tifzgfNr1eIYplN6H+e66iZWb9rV8dlwI9lvA=;
 b=IS7M0tWZOdCbHJspTA9PN9gFSitzPbkL0i4i09vSQTvr7BnPALmMremzoE3cz/7nsG
 JGfUdKbbbB5voD919GStuG/7diP05rg9q5LKQKIPZRfYmg63ffpgDuVwmA0LocoofHDP
 pI61b+fl1FNYQTOb/yxhHX7YTr3PZwgQyV96itUGlFX8DnnkPWie/zRRbh39/vExmaxK
 DKN/TvFlgrKEtuFojORbOOPYFL+YJh4EUa1It5lsYkxMrB61U84xUL2f0Aupb0GMbDGx
 KuE09n2JISmShYBtX497DHjelCCsTl1sPKTrpncek2EwGWllwIMiaP3/Q3Yzr26c5ZJf
 tRPA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769245210; x=1769850010; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sETJlyosKU11l2SCkz0Idt5WCGlSvoFnGkOt9WcjCco=;
 b=YYBv/t6QaRgoJ3NwdWdbmD7mGQkvypm4aR/J19/j6cNBJeeuHHKmSDgkz93SPQQ48c
 Yk0Wp7HBwZIJJK7FmbRnST1oTLihiAJ/JndtF1GaHUNkHJOpX83CxDNfsIc5HdzFGhsY
 kdqI+NKsfUnCAHlc8x0JfDyNXaLaKVygDAGQQQzpeAYnnmgen0YODo1miCPZ4/pbz6Yb
 xcCamIyJaCjIybt4PxbeLiyGyqfgJZlFcAHbYvyXeHn00dvNbBYYLBinCQ6g8pufvdik
 98Sz6FwY4y1Tr/vkDgvrbLvC40ujsjK5tDmlKC61hk9RBXhwalNhay43pmWoVcNLfobb
 8t2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769245210; x=1769850010;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sETJlyosKU11l2SCkz0Idt5WCGlSvoFnGkOt9WcjCco=;
 b=lvtoi8BDUvuJlblySEyu8e3Idj/hr5TYkqIBNj04+RNsApOBJRjk2W+uo4njhelPKA
 wD/vbXuT2p0zFIAY5Egk9UX4r+hTnhmqrtsmxjKi0I7f/mBZjROiO9sb3VBYX3qMcW7o
 PT/XRvr9aKB4iLV+ddIOaB0OnMsrNSb7iMROnYzGEVT9BwH5pUdux2yd/kORNilHtKnD
 wl4/YskkTHM4IXlEESpGaIVIiBRnZie0ABkfg/xR1CdyQTESS/Kr1bK+A+10z2S3Z1Eb
 h3X2QcRODp7XcWj5W6ZRwJn7+CmzFgNqgZOAQjr1sR19xlY8PvCmOFBFGJRxG2UI6yiK
 NI2w==
X-Gm-Message-State: AOJu0YxNJYCEfQXAphAfH4fa44owOWwiVwQ3vQOGpliZ+lluKJZgY1Vy
 ARNk3CQet8kOocdcjQHLZ9lPy8AgnKcG5mzW8VNEI4Wn+J0E/vrkwPJeikTetJ2pjovEC6spy1f
 S0cJF/4W+SDImAXMm8mzmJX32JgSonNnSrqXM
X-Gm-Gg: AZuq6aK7OyLeO30Y63IcI4h2huT2beITUdA3gxo90WGGtvJFRpkiSAdNjxm0vesv4RH
 uB/7RKek6zxpj8zk/8Ymvgvu1xVm3cpGoUy1Kn2eefVFOSOQdlBBvkkc+UmrVV44NYUMPpw42XJ
 PVFVHAf3dybozoofQGPgqC9WOYL9d23qFzUpI8P8uCwuadGehglvEKbaKPL5Twa73kAhgOCqXDc
 RrNr5x+S0a6dBpCvLNpyY3LmftLrLidotSjajW6VcAlspxl2bdgcb8sv+Z0Fft0P0e/meU=
X-Received: by 2002:a05:6102:41a2:b0:5db:d6dd:81c6 with SMTP id
 ada2fe7eead31-5f54bb469a8mr1722521137.18.1769245209666; Sat, 24 Jan 2026
 01:00:09 -0800 (PST)
MIME-Version: 1.0
References: <20260117210322.5419-1-scott.k.mitch1@gmail.com>
 <20260123162742.69675-1-scott.k.mitch1@gmail.com>
In-Reply-To: <20260123162742.69675-1-scott.k.mitch1@gmail.com>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Sat, 24 Jan 2026 00:59:58 -0800
X-Gm-Features: AZwV_QgSC_lyvt1vIshJo9jJu7-xFgYqD6792tbKcd8Xu1Z1Whr14yz8goTmc3U
Message-ID: <CAFn2buDQBAxnZBYyqhzZMN+DW9XRp9ZN1Wb6+976kQ_S4ByhiA@mail.gmail.com>
Subject: Re: [PATCH v10] eal: RTE_PTR_ADD/SUB char* for compiler optimizations
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org, 
 bruce.richardson@intel.com
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

UBSan flagged a legitimate warning [1] with this approach. There are
existing use cases in the codebase that pass ptr as NULL.

Before this change: NULL (0) is cast to uintptr_t. The addition
happens in the integer domain, which is valid defined behavior.
After this change: NULL is cast to char*. Performing arithmetic on a
NULL pointer ((char*)0 + x) is Undefined Behavior in C, even if the
offset is 0.

An example of this occurring is shown in [2].

We have a few options to resolve this:

1. Add runtime NULL checks into RTE_PTR_ADD -> Undesirable due to
runtime overhead in a hot-path macro.
2. Clarify that the caller is responsible for NULL checks -> Require
audit & update call sites in DPDK (and potentially breaking external
applications) to ensure NULL is never passed.
3. Revisit the API -> Existing API is convenient but limits type
safety, discards qualifiers (in caller code), and obscures pointer
provenance from the compiler (preventing optimizations). Here are
options to split the API:

Option 3.1: Distinct APIs per use case (Split Const/Non-Const) This
splits the macro into three explicit variants.

/* Add a byte-value offset to an integer address */
#define RTE_INT_PTR_ADD(intptr, x) ((typeof(intptr))((uintptr_t)(intptr) + (x)))

/* Add a byte-value offset to a non-const pointer */
#define RTE_PTR_ADD(ptr, x) ((void *)((char *)(ptr) + (x)))

/* Add a byte-value offset to a const pointer */
#define RTE_CONST_PTR_ADD(ptr, x) ((const void *)((const char *)(ptr) + (x)))

Pros:
Simpler Implementation: No suppressions or casting under the hood.

Cons:
Pointer API fragmentation: Callers must manually select the right macro.
Dependency Cascade: Dependent macros like RTE_PTR_ALIGN_CEIL rely on
RTE_PTR_ADD. Splitting RTE_PTR_ADD would also split RTE_PTR_ALIGN_CEIL
(into const and non-const variants). If we change CEIL then
RTE_PTR_ALIGN_FLOOR should be considered for consistency too.

Option 3.2: Pointer API and Integer-Address API (Preferred) This
separates integer use cases but keeps a single unified macro for
pointers that preserves const correctness automatically.

/* Add a byte-value offset to an integer address */
#define RTE_INT_PTR_ADD(intptr, x) ((typeof(intptr))((uintptr_t)(intptr) + (x)))

/* Add a byte-value offset to a pointer. Returns the same type as the
input (preserving const/volatile). */
#define RTE_PTR_ADD(ptr, x) \
  (__extension__ ({ \
    __rte_diagnostic_push \
    __rte_diagnostic_ignored_wcast_qual \
    typeof(ptr) __rte_ptr_add_result = \
          (typeof(ptr))((char *)(ptr) + (x)); \
    __rte_diagnostic_pop \
    __rte_ptr_add_result; \
}))

Pros:
Preserves Optimization: Uses char* arithmetic, allowing the compiler
to track pointer provenance.
Better Ergonomics: Callers don't need to distinguish between const and
non-const.
Existing Precedent: Following the existing pattern of RTE_PTR_ALIGN
which returns typeof(ptr).

Cons:
Requires warning suppressions: Suppressions are localized within the
macro and don't affect user code, and the typeof() return ensures type
safety at the call site.

I will submit a draft for v11 that implements option 3.2. If people
like this approach we can discuss if/how breaking into multiple
patches makes sense.

[1] ../lib/eal/common/eal_common_memory.c:335:9: runtime error:
applying zero offset to null pointer

[2] github.com/DPDK/dpdk/blob/main/lib/eal/common/eal_common_memory.c#L335

start = msl->base_va; // void* (can be NULL)
end = RTE_PTR_ADD(start, msl->len); // UB if start is NULL
if (addr >= start && addr < end)
    break;
