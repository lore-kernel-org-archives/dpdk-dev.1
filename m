Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7877DC624A5
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 07:46:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C1C54025A;
	Mon, 31 Aug 2026 09:46:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id BA1F9400D5
 for <dev@dpdk.org>; Mon, 31 Aug 2026 09:46:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788162382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PI9KAoWN/QXil5lKhtWh2JEXGQQr0WVMz20pGcIyDTo=;
 b=hFTo1qDGogi22AZs7Lfhm78uGFL4ZRqWqXGjMbLFOW3tZU66lJRRfHkjdT/cAelh9rIUZ7
 5pZaFCKr1M77Vc5OoXXuaTPwkkiMb5vdWvUhZUyFG5hNkWWnZmbQmaukHltobHkde6KVR4
 G6U6FXRF1+tzIUA29cC6K5zxXcYxc18=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-YmotZtdMNz2oDZpQMIjimQ-1; Mon, 31 Aug 2026 03:46:20 -0400
X-MC-Unique: YmotZtdMNz2oDZpQMIjimQ-1
X-Mimecast-MFC-AGG-ID: YmotZtdMNz2oDZpQMIjimQ_1788162379
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5b4b020612aso1886800e87.0
 for <dev@dpdk.org>; Mon, 31 Aug 2026 00:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788162379; x=1788767179;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PI9KAoWN/QXil5lKhtWh2JEXGQQr0WVMz20pGcIyDTo=;
 b=dmamGhnh6OJfh8EdX7Jgb1xwJirBMC4URAcaBQry0VwSLDN9TyUIh8G/KBBsx9yRSz
 Q2v7ybG1bSd69pfODL5bKRVifS0zlMKKFInkO90fsxgWSfvlz4f0u+5junzd6eB2DziX
 i61vkVe9R4VO1vVcRw9JRtFhciI6+I3C9Tf2c0xI6PkeymA04/4oawOy+B4mTuKDMZz7
 eFiPXyQJ2VXkXfD4D4IcGdLcZvneou8pNK0lMCh9hlVWNqOE2iyZfp53lyU2fEdPFgZo
 ox0/b5e3uDUa7wxpjK7HbInS6NcQ0q8C9PzZk0zqwiU6sg5yfL0opbRsx+uL0kN0earT
 zNgw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwkApLY5s+r2WF3R6JAETT4V9oviV1AqsMkxtILFpu2SjnkXuUSsuKsNMc0NueGnjEDuUk=@dpdk.org
X-Gm-Message-State: AFuF++lzKSP7M/NL7FqPbZ0S//byXxkCR2C1Zs5OJLYX59Q+uAPtkiGe
 bKHHNXKAqnAWzvMgkqtsqKrht8yPX02JYysdr8WHW9wTpUwyPekvA9lSEWoZU5k/w/gMNpEAWQh
 SLpsd3JwYOOIUfjGIOT6KNsOFMvLLEWfKDPSsWCdU8Z+N4bkEH3oatOp+W4sDgCWh5oSjW4MHYQ
 2ssmjSvmOZEK15BJoJzCwcQWg39rY=
X-Gm-Gg: AYBFou0HRaEblVTXChEK9wpZmM9xRTR/lYc5LHVCT/b9h1klXLzTIoNaouK6BqwUWy2
 RDjJ0LdXRWExlCl2PAgLy9TLhy8nPamaIqAo3XAMvX52YCFIyi9fi3G03V42mCgN9DvmJhJCC4p
 yJoKwLEkU4nRywk8vHcd9ekBSzf0B1UQRK2b1GVkBtuwG0dmK6MTMczXbUI8auVvNncYnBFXOb/
 4WY/UBK3yXIEUNrqMfkCB7Sy7YZilv+tvPtxFbl0I5gxNgv
X-Received: by 2002:a05:6512:450d:b0:5b4:fdc3:d3f1 with SMTP id
 2adb3069b0e04-5b5e68f68ffmr6704112e87.18.1788162379006; 
 Mon, 31 Aug 2026 00:46:19 -0700 (PDT)
X-Received: by 2002:a05:6512:450d:b0:5b4:fdc3:d3f1 with SMTP id
 2adb3069b0e04-5b5e68f68ffmr6704079e87.18.1788162378511; Mon, 31 Aug 2026
 00:46:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260828074056.2250222-1-liujie5@linkdatatechnology.com>
 <20260831024103.3230425-1-liujie5@linkdatatechnology.com>
In-Reply-To: <20260831024103.3230425-1-liujie5@linkdatatechnology.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 31 Aug 2026 09:46:07 +0200
X-Gm-Features: AcwNN1XO0wRZAMx5tX_7_r3Lu38-SeISm2kr3gqQOKppU4GEaAn13_72AIqet0k
Message-ID: <CAJFAV8yczTmUeRNNWT5pJpfXsmYk9VGMri=m2jHz-biczkv5fQ@mail.gmail.com>
Subject: Re: [PATCH v7 00/47] net/sxe2: re-align with reference and fix review
 findings
To: liujie5@linkdatatechnology.com
Cc: stephen@networkplumber.org, dev@dpdk.org, 
 Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: X_L4CENkC7kKG7-b9Aalmwr6p-RA3WsyQCt7YNZ4E6w_1788162379
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

On Mon, 31 Aug 2026 at 04:41, <liujie5@linkdatatechnology.com> wrote:
>
> From: Jie Liu <liujie5@linkdatatechnology.com>
>
> This series updates the SXE2 poll mode driver (drivers/net/sxe2) and
> its common library (drivers/common/sxe2), fixing issues found in the
> previous version and re-aligning the driver with the reference
> implementation.
>
> Changes since v6:
> - drop the now-trivial sxe2_vsi_node_free() helper and inline
>   rte_free() at its call sites
> - unify the duplicated FNAV/ACL COUNT action arms in the flow parser
> - use a file-scope static const ops table for the vectorized Tx path
>   and fail sxe2_tx_queues_vec_prepare() on a NULL txq
> - split "unify vectorized Tx buffer handling" into three commits:
>   the buffer_ring union fix, the NEON Tx 4-wide descriptor fill, and
>   the NEON Rx ptype/memory-ordering fixes
> - use the primary VSI id directly for representors (the kernel
>   guarantees it is always valid)
> - drop the packed/aligned attributes from the TM command message
>   structs to match the historical kernel layout
> - fix VEC mode selection in the Tx/Rx mode set functions
> - clean up commit messages (headline case/length, missing Fixes tags)
>
> Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>

It looks like this series had issues during transmission.
Patchwork created multiple series...


-- 
David Marchand

