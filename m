Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9686CC6B16
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 15:22:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20DB240615;
	Tue, 13 Oct 2026 17:22:34 +0200 (CEST)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mails.dpdk.org (Postfix) with ESMTP id 80DE940272
 for <dev@dpdk.org>; Tue, 13 Oct 2026 17:22:33 +0200 (CEST)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-8899a204034so1413881b3a.2
 for <dev@dpdk.org>; Tue, 13 Oct 2026 08:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791904953;
 x=1792509753; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PBvS/ADzN6nqTyC2/lgLC4oedlnjmlmW/UXaB6uA/E4=;
 b=XKBLXLom7UfoNCC8vFvmbngrNTzWQnHAxP7c2PwM/+pFMRTd3PEWdz5jU5JGAiIDHQ
 sxwRm/eSqtH/sIEbq4rmM3lKYT1dhKfLTDutzYF1xeqR0OnYq4wo8gSoUgJJe+v72ZDL
 7e+bVeouf9PV5E4yTcd1CHN7uq8cz19mHNkioZoIgAwjlUAe6osbN7aMEBM1pi7ht56Y
 6qCnY1MCkZFAX1eYzvGtHedoKMiPBTaplFUFWDnQC3CJeDXuYtcRp+YdbBfesMS8kj4f
 B0k1hKDrqcWd0zbD+e3ysWrKKdjhxkeDqebj4+4/zwrATIf50qrq7J8/ce/Scn8ONodx
 hUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791904953; x=1792509753;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PBvS/ADzN6nqTyC2/lgLC4oedlnjmlmW/UXaB6uA/E4=;
 b=VrWJuGfF3gWzPv/FlHJCoAYwmMfIIlpDXDRzBclXN1tXjQmnrouyy/G88RZzQykyCK
 Umd9I3KRb+l5d2X9ug2a4CDkaZXAkuyRY3cVOy+A/g0FsIXOTDgs6EsMgUuOx8grEMfM
 dEdkAx5Zlii8pYxMtEkBBNilc0TQyjMiwoIXPFhS/0m5jXA5P6VHptQQG0b8V48gwC+P
 k1zL6y6fWKUYPkiEGRW+Rh/tEcynYsqtmF9hzJ3Em01AxzX3hk/YNmqA4pUVI7STx/XE
 zayLh2ihP3hklhsQ1JJdBrmVuqH15IM0xJUKs8+uio685iVtXRHCWusHBIVNlit/iZfz
 z2mw==
X-Gm-Message-State: AFq9FYIn7//o4n58Ocqp9wNBClMRPX5HrePAudPuwv8+mpxnvwNPE58f
 697+1vy01Sj3KtjZeCl12m9s2EIphXdib/GhN9L9vghAXzUZyWHKxZZ0b43+PsIBoko=
X-Gm-Gg: AYBFou3N8vGXb6JGICIaKE45hOKiIYzmUuFlE+uivFAlcqS7Wt7LzEHlx+AjmIrs6QQ
 oZ2N1RL/Watr/ZN0ZUz/XRh34i/wrxJvcR1wXjU3QisUWMvIxm1gh2+hv76h+YLizK1roUt4vcb
 Q8iljybu0jzTZNRpnxNIZLGCBZXB0avk6QCujMIFpWFtXkD6u40PpSLBdSQez/hvRHYzEEdxaSB
 CPzjVBXBBI2lhZgL+RO9STqI/hBK0lb55jcyMCt6aDWVni2kMsBy1kdVRYGenSbyzWSSqzPMkCS
 Kab0fmcbgfnpCfl9SLd577qZkMlnWjRrKyR6OlRClLu2/ykbQ6VP3VTprgLWvN2+5Sk/0V0G4eB
 d3e98s3W3xepO/z730T4wlG+FSFC31YPLX776N3MQatNFsG3Mh87guHUbpXbylENgNxb+bKM5bk
 DAc9X2ki3HyzZoJ4EZzsMQY/NVk3AIP3A9eV7EhUE5sCVfUz1wH4pj2paGX92wkk0dHJbcLm3bh
 o+i8xshG43Rvwa+OvlMcgc/gUDlOZWBhu6rdGDf
X-Received: by 2002:a05:6a00:99a:b0:88d:3f61:20e9 with SMTP id
 d2e1a72fcca58-897c7cd75e0mr9834035b3a.48.1791904952541; 
 Tue, 13 Oct 2026 08:22:32 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-89d802a4314sm15301b3a.11.2026.10.13.08.22.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 08:22:32 -0700 (PDT)
Date: Tue, 13 Oct 2026 08:22:30 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
Cc: dev@dpdk.org, joshwash@google.com
Subject: Re: [PATCH v2 0/4] net/gve: fix Tx queue stalls and sync DQO RDA
 with Linux driver
Message-ID: <20261013082230.09f67ddf@phoenix.local>
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


Looks good you may want to address these comments from AI.

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

Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
