Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA486CA5FFE
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 16:38:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E78E40E18;
	Tue,  6 Oct 2026 18:38:26 +0200 (CEST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id 986074027B
 for <dev@dpdk.org>; Tue,  6 Oct 2026 18:38:25 +0200 (CEST)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-38759bcd877so1071593a91.2
 for <dev@dpdk.org>; Tue, 06 Oct 2026 09:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791304704;
 x=1791909504; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=e45Cw6fj6BvUXPuena4ZCpfYebC6WTN4khbDBn6YKFU=;
 b=ywNziSY38MGMykIvTIw1CBMKEheJb9uFR9dFNNDS3wYB5nE7WNRfbG6ktemErgAue3
 T2L2jP63mwmnzZd1GFfCrzNcvT/jBov68FofFr5rWs74+qlFU34rMa8pbkdGoGfeGT3z
 MW55ucrmyZATkdC/QU63Aqd7t5HJWss/F5lYf8WMSirG/rvJ50CTSAQcGp5wfyh4Qtt7
 kqljocsI+nlIRRoyeUfaX9HWGCP2p4p+oTaiMV2GAn130pL/4GTdtj35n2D6PLOhqFaL
 QtTyMX6EnRIPZSIUlZEzgg+zOozffOC8ERELd4EY8kAsusJfxgjvyRRdudyBGSL+CX50
 Y1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791304704; x=1791909504;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e45Cw6fj6BvUXPuena4ZCpfYebC6WTN4khbDBn6YKFU=;
 b=L/KdPHBrDlSxqaE8eQiYUVk5J6Tz3wtdUe/mOkbkvezmUCxCKWJp3/wVXut5FTdfzP
 xNCbN0vQ/FYg0uIR+VONI4jzsaxtq2fgta7noiYPqHSB5nCqyLBw+IKgR7qgd/ue9Sqv
 XF+wFKDM9rhb3sz9QE0Yle/MVPJrc4Dfhl2iQGp6He2kouwZQGe2073/O3UeWRgm3cOq
 TJj8UNkj2RVBX/OS5eBPAnbwuywQt+puePiZVWsxZwQCmNKeN2wVWiK17SeDfxaV8Hrd
 uolgPvbXxmumwkt/WKY/D92jj1hyMmNNd4gbcgeHbmYooEqZnclrtcOjdjaBAn/QdQWs
 BH2g==
X-Gm-Message-State: AFq9FYJf+IgBWIVq+JH65CKckvyHTI5L8FKXmfuqNbToBTMxtnWyKkqC
 7US7GCV7PLROGeMxvSnMmdvwkXhsD/xdKH1sh7Q9Odu0Q0h6uQcUt+iZNADCOYqhAbY=
X-Gm-Gg: AYBFou113Rqv52XyM0veq7siKmVkCV6TrAi6pQTAQ78dAwt2oXzBtrHiWi/sn/nn/0a
 hjbSReKqWnUCOsYRR6CiSXhU6v8Lzd9N+uL/kWkBg2UgLXGLDHS15OJkppv8mMsngiYla1T4Uiu
 U8vTpxKQKh7JAaOrdC9Jp0JHjLZI6AAqTNlYsXGUoHWH2U1oAu0ARTW45xPpCyxp6RUwZ6OMAus
 dR+QspBvtze/P46vZp5wQ6TbK6awj+SBnX1r7+sqaeaIh5sOX3LoKFSbGmoHiaUWMCCxpduM0oa
 xHLTxn3X4CzDbYWDkFAN202lUqVBHtQaPbGqRXoZ/IeT4HQNSXaE7Xf65rcZ0V3sm6wkEXtT78P
 WspswgVlGN/xVKX/0nS4QXp5iYzxJhiZ0omCZefGXzScN6BMFFzm1XaWV2W1V3Huy8dhEjc9KaF
 i4kF9pd7pBcscEFik7UyKSB+DmsugJHWOB3Tje1DOx/vQ/Z7FYWbZW94bWEt3wCBEGwyobXf73k
 5vbV3HQMBRvYarUsGKhsMmv8WV9XYrRE5WYXrlX
X-Received: by 2002:a17:90b:3c43:b0:3a4:ef4a:4f12 with SMTP id
 98e67ed59e1d1-3a8737dc5c7mr1233501a91.61.1791304704394; 
 Tue, 06 Oct 2026 09:38:24 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a89b3a2b36sm259368a91.9.2026.10.06.09.38.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 09:38:24 -0700 (PDT)
Date: Tue, 6 Oct 2026 09:38:22 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Joshua Washington <joshwash@google.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v4 00/15] Introduce RTE_DIV_ROUND_UP
Message-ID: <20261006093822.603a7a2e@phoenix.local>
In-Reply-To: <20261006023053.2572501-1-joshwash@google.com>
References: <20260923010742.2468145-1-joshwash@google.com>
 <20261006023053.2572501-1-joshwash@google.com>
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

On Mon,  5 Oct 2026 19:30:36 -0700
Joshua Washington <joshwash@google.com> wrote:

> Numerous components independently define the DIV_ROUND_UP macro, using
> the same definition. Attempt to commonize by introducing
> RTE_DIV_ROUND_UP to rte_common.h and replacing usages of DIV_ROUND_UP
> with RTE_DIV_ROUND_UP. Similarly, replace DIV_CEIL, which is
> functionally identical, to RTE_DIV_ROUND_UP.
> 
> Changes in v4:
>   - eal: Fix merge conflict in release notes after rebase.
>   - various commits: add rte_common.h includes where missing to fix
>     compilation issues.
>   - opae: drop RTE_DIV_ROUND_UP change due to shered osdep file for RTE
>     and raw drivers.

Looks good, some minor AI notes on commit messages and doc

Review: [PATCH v4 00/15] division round up consolidation

Series applies cleanly to main. Each patch touches a disjoint set of
files, so with 01/15 first the series is bisect safe. Build of all
affected drivers, dpdk-proc-info, dpdk-test and dpdk-test-compress-perf
with -Dwerror=true is clean.

No errors or warnings.

Series

Info: remaining private copies not covered by this series, candidates
for a follow-up:
  drivers/raw/ifpga/base/opae_osdep.h   DIV_ROUND_UP (map like cxgbe)
  drivers/crypto/ccp/ccp_dev.h          CCP_DIV_ROUND_UP
  drivers/common/qat/dev/qat_dev_gen_lce.c  LCE_DIV_ROUND_UP
  drivers/net/sfc/sfc_dp.h              SFC_DIV_ROUND_UP
  drivers/common/sxe2/sxe2_osal.h       SXE2_DIV_ROUND_UP
  drivers/common/cnxk/roc_platform.h    PLT_DIV_CEIL
sfc_efx base (EFX_DIV_ROUND_UP) is shared code and should stay.

Patch 01/15 eal: introduce division round up macro

Info: the Doxygen repeats itself. "Evaluated twice" is in @param d and
again in the first @note; "non-negative" is in @param n and again in
the second @note. Keep the @param text and drop the duplicate notes.

The plain expression form (not a statement expression with typeof) is
correct here: several converted users need an integer constant
expression (array bound via BITS_TO_LONGS in rnp.h, MAX_KEY_DWORDS in
hns3_fdir.c, CNIC_ILT_LINES in bnx2x.h).

Patch 05/15 net/qede, 10/15 net/cxgbe, 11/15 net/ena

Info: commit message says RTE_DIV_ROUND_UP "makes DIV_ROUND_UP
redundant", but these patches keep DIV_ROUND_UP as an alias for base/
code. Say that instead, e.g.:

  Map DIV_ROUND_UP to RTE_DIV_ROUND_UP for the shared base code
  and use RTE_DIV_ROUND_UP directly elsewhere in the driver.

Patch 05/15 net/qede

Info: bcm_osal.h still defines RTE_ROUNDUP in the driver, squatting on
the RTE_ namespace the same way the removed RTE_DIV_ROUND_UP did.
RTE_ALIGN_MUL_CEIL() is the equivalent. Follow-up, not this series.

Patch 06/15 net/rnp

Info: nothing in DPDK defines BITS_TO_LONGS, so the new #ifndef guard
does nothing; drop it.
