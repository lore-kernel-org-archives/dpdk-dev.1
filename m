Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0834CC6B2D
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 02:53:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 604194026E;
	Thu, 15 Oct 2026 04:53:33 +0200 (CEST)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by mails.dpdk.org (Postfix) with ESMTP id EBC794025A
 for <dev@dpdk.org>; Thu, 15 Oct 2026 04:53:31 +0200 (CEST)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-878b44611ffso3148166b3a.3
 for <dev@dpdk.org>; Wed, 14 Oct 2026 19:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792032810;
 x=1792637610; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4n/fIJqoYlCg/ahRTQo8VgVGxvQP8ey0h40a+6XsDFQ=;
 b=Lhz1NnhC4EkplopAJ3ilXHo8OPNxTkjeoOvS9/CQSBhYnz/lLFsxUYZ46ldk/CbhUA
 Zw/hhPDGm/A4+2Vh4HR1mfSPrUXKuxQe/enRg2kM4FOBICmRlDkN/CPfvKSR8dGOWoMl
 h2vl3CELOTWNSaI4iGv5BsiXGzQA288kAkjNQ6Vhl9pSeT0HQEMlsMn5pQ49djs77+xT
 Ndyc9DrKr4HCzNBvo6US5P7scYY0mJ1SXgTdhUD+ZUpUUt9XWx3m2yc79XTNRtQh+jhV
 EXcQ+MCAJmOy61ODPzTmkEMj75a4VTnIWNMAto6nvMmGsEZavGO4YJK9r9Pkba01RXJS
 Cd0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792032810; x=1792637610;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4n/fIJqoYlCg/ahRTQo8VgVGxvQP8ey0h40a+6XsDFQ=;
 b=s9RplnJ6zYTTXEtIOFiZaHRdvEFrDMC6xdRcIi3Uj16CD1XeMAW+YMR+MsKA4ZRtYV
 xqqTXj9LjTvVm8sxAbxmsdEAXjx8IYDd4uw/oVNYk62BH3L5LfIkMImDCprDoSkADFli
 9+1d0jcAczdWQSE7YqKdVouYtcaCWHGcjgT9A7wI3HKl0W6O6lGwkwv+GJlFJfAwDue5
 aoQjTJAQxPYblvlxWHqTsXgihkj3ogOPnaBF3r/1o3WXBikp+2rZMBxOtSmCfxoupf2o
 8mkWmwxsl1R8meZtPpOF+SbBKM0iBFsH9sMV+SyvYO5khESYDXakvkXSgjSGgOpo/85C
 2RXA==
X-Gm-Message-State: AFq9FYK2puW0kkzzXkxjTPZQlj9036cY7r4Cg4HPSfPAMoOQvrrw1K3t
 IKjIej35k3IoxW/qia2y12Ojn4pQP588nneASvPn5p1H2fdDvw6gHWRGbHxm3ATN3so=
X-Gm-Gg: AYBFou1uthdm59mMaCwbLM11lVZK5G+PstZwbXYzqXAofase1imh6jTz6Qw9pM2PWhY
 RG5G9k1AkWTGZcH9jz+apBRP8kKH4Qs+k8XyXjRF8Fxn2CWGFjRCcqpqdCBoidUiox6koK/rme9
 1C/NmDlgAF6QQ/9MYgxyAxMA4lhTig1CAYLBOCEZe6L1U9LGl/WltPqlTQK/LdzNKQu25geN+7d
 IacfHZDMxSUHf6Ibjj+AIK3FaGlBkhjQxehf8qldhByZtAEd0aphCygfzn6szExCfshaInGXFdk
 ClWgaEFGOYyRFVIfciJVwbGRJXojAFOW/8SWOdU/3TKLDrZPkLweg77iR1tKKzom3rNTjuNP86/
 RQoSHER8hFmsJSMTkay8YBs3ng1vrnZ3OJ951vo8aL6nTfAMRTXrDyWaxxa0Onj4wxjdSHbuzxf
 crGjjB9EvfOs0KK9bY4j/hMBvaZGn+7DzoPglDUqWDTFg+Ft9N97JAU8qzrQyxbWcUwoS9MYgz3
 ZNhAAnpDd9jDsJlgTGyb7/rA0z4z/ReKFKBNj0A
X-Received: by 2002:a05:6300:4045:b0:3e1:370e:f249 with SMTP id
 adf61e73a8af0-3e19a64c1ffmr10380600637.60.1792032809994; 
 Wed, 14 Oct 2026 19:53:29 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd635cbaca7sm500000a12.25.2026.10.14.19.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 19:53:29 -0700 (PDT)
Date: Wed, 14 Oct 2026 19:53:27 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
Cc: dev@dpdk.org, joshwash@google.com
Subject: Re: [PATCH v2 0/4] net/gve: fix Tx queue stalls and sync DQO RDA
 with Linux driver
Message-ID: <20261014195327.189c5a4f@phoenix.local>
In-Reply-To: <20261013104348.714550-1-tathagat.dpdk@gmail.com>
References: <20261012105023.669486-1-tathagat.dpdk@gmail.com>
 <20261013104348.714550-1-tathagat.dpdk@gmail.com>
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

On Tue, 13 Oct 2026 10:43:44 +0000
Tathagat Priyadarshi <tathagat.dpdk@gmail.com> wrote:

> This patch series aligns the Google Virtual NIC (gve) DQO RDA transmit path
> with the upstream Linux kernel driver (drivers/net/ethernet/google/gve/) to
> resolve transmit queue stalls and hardware validation issues:
> 
> 1. net/gve: fix DQO descriptor cleaning loop bound
>    Fixes the off-by-one error in gve_tx_clean_descs_dqo()
>    ("while (--nb_descs)" -> "while (nb_descs--)") and avoids stalling
>    the completion queue on unrecognized descriptor types.
> 
> 2. net/gve: fix DQO Tx queue stall on multi-seg and TSO
>    Tracks descriptor intervals with last_re_idx per packet against
>    GVE_TX_MIN_RE_INTERVAL (32) instead of counting packets at burst end,
>    preventing descriptor ring starvation and queue deadlocks under
>    multi-segment and TSO traffic.
> 
> 3. net/gve: add cacheline overlap margin to DQO Tx ring
>    Enforces GVE_TX_MIN_DESC_PREVENT_CACHE_OVERLAP (4 descriptors) margin
>    in ring space checks, avoiding CPU and device DMA cacheline collisions.
> 
> 4. net/gve: add packet and TSO hardware constraints for DQO
>    Augments gve_tx_validate_descs() (which enforces the 10-descriptor
>    limit per packet or MTU segment) with the remaining hardware length
>    constraints: [17, 9728] bytes for non-TSO packets, maximum MSS limit
>    (9728 bytes), TSO total length limit (262143 bytes), and validates
>    header contiguity and payload presence on TSO packets. Invalid packets
>    are dropped instead of stalling the queue.
> 
> v2:
> - Patch 1/4, 3/4: No changes.

Don't know if this got sent yesterday.
Here was AI review of this

Subject: Re: [PATCH v2 0/4] net/gve: DQO Tx fixes

Applies cleanly to main; every commit builds with -Dwerror=true.
v2 drops invalid packets and continues instead of stalling the burst,
pops the completion tag before writing the TSO context descriptor,
and adds the Fixes tags. All three Fixes hashes resolve.

Info

[PATCH v2 2/4] net/gve: fix DQO Tx queue stall on multi-seg and TSO

1. Ringing the doorbell each time report_event is set is a
   performance change, not part of the stall fix. Descriptors posted
   earlier in the burst are reclaimed on the next burst either way,
   and Linux rings once per xmit batch. It is harmless, but for a
   stable backport it is better as a separate patch with numbers. At
   least drop "amortizing MMIO writes": it adds MMIO writes.

[PATCH v2 4/4] net/gve: add packet and TSO hardware constraints for DQO

2. tso_total_len is 24 bits wide; 262143 is the hardware limit (see
   the comment in the Linux gve_prep_tso()), not the field width.
   Reword: "Define GVE_TX_MAX_TSO_LEN_DQO (262143), the hardware limit
   on TSO payload length."

3. dropped_pkts is not in tx_xstats_name_offset[], so nothing reports
   it; too_many_descs had the same problem. Export it:

       { "dropped_pkts", TX_QUEUE_STATS_OFFSET(dropped_pkts) },

   or drop the counter and rely on errors.

4. The commit message lists the diff line by line. Cut it to the
   problem (invalid packets stalled the queue; hardware limits were
   not enforced) and the fix (drop and continue; the limits enforced).

