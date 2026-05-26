Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3315CD5BC8
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 13:29:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A03B402AC;
	Tue, 26 May 2026 15:29:50 +0200 (CEST)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170]) by mails.dpdk.org (Postfix) with ESMTP id 3650B40290
 for <dev@dpdk.org>; Tue, 26 May 2026 15:29:49 +0200 (CEST)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-2ee990e8597so25390947eec.1
 for <dev@dpdk.org>; Tue, 26 May 2026 06:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779802188;
 x=1780406988; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IkFps+kKqLujfIi0Si+qEyHvkq0dwnDnOXsUZVybbBM=;
 b=TXN4cyKdnlOsYKgMKzxzVhozGLTfVgNftnFtIC9S0EjRRZ7GsSqGCRYzmdGNM+DcWq
 SxUSkoTzvFuGc9QHziSbQll2yceyKRNLLXlwJfD00tnbHwI/NFQUCmbkihPBV1ZusbQz
 hPPNuc9GbuKuT8EEy8v/sxPw2Gi/OGo6CbmyEvAGS4+Ky4aPsUOAo+FeYu3gNbe/HV8t
 KwjFJa+JU7mhkSlT2QFRyY9Rw15kEkhh6ekjiUNg/1x2lpFGo+9LKzHWwLtMoA3NTJIx
 7qaLBLV2awuTSYDK/hw+V07rEnLHG8wvVDulBT5uEZPlDVF7rWu9H/XmmjlHwd64sOQk
 3kcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779802188; x=1780406988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IkFps+kKqLujfIi0Si+qEyHvkq0dwnDnOXsUZVybbBM=;
 b=RFndfv8t7qh8htVNi4drkXM8g4dgcQve3dD5oX38geDaipT3c+LU4bDyoLw6O4CLJu
 czUK5/vba81VJRyN+2HM4r0Rk7hJexf2mjRXugP3JjzE5i/Hl7ImjIgzRACip/xSFs5+
 MKJ2/PO4OJXR9eCG6JskjCOhc45dwK6dubLZVnERa/2kYzmYF+p8cgLWg87XxWJE+bRi
 cL3By+g0HC82giwBYj9aUrEW25OR9cwxoeyJfgnC+0aUjpmxILaMVTDxLI6fY+lEor3s
 c1CDrhwOt/JJOdLIP05KFA6UrqUVfv7YajCAdCA0Gj/wcdRhyvsGx4bc26NslJZIKOf0
 b7MQ==
X-Gm-Message-State: AOJu0Yzf0v0tJrMw0vJfp2oIRxOlPm82EIUkyoWFMRB9jQtsbyq+YzXy
 HAcg0W7aMJQ1rVPBR4WSIdU2NRQKLx9STfQsytGA18sAktGTrPKJNE0CDI+RD6NuX6br2PjRYHX
 +lc9C
X-Gm-Gg: Acq92OG7YjvCDsYYVcnNMpPvmQ9s0P1HtaRStzlduNBDEtWUsVs0FZbFH//lNy6bnEL
 ASkqYOCmsz3edhnD3qdFd3A/ZdAjpku76RdHxJ9L2KZfmvETlatH/QROyrrV9AwQKWhLjlsrEZT
 HWc2axblJAzANRVbcjhCFBRjD/RO6AIhIMaMGOoIrSDqnwgKjzhv3VDeE/iG11LxDEIH7kEHl/K
 0lvdsHwgtb5P0rcqoTeqQ3xfMI8QF1rn4SB2lIEXcnhPj3ySRK+eR1OrPZ64uaDxvFLw/isB8/4
 7nhi402WPw7B15sGqX1ngMn/j+eoTvahc4gv7Mh1CWgpFIIqNgOXzbfQCxPIO6SBIG+JtWmtdf/
 u6qfkz7/Gwk/bTMuF+y8b+0ekf231IifKG+YhMRoNqSd2fUqNqn5OWgAlOkP8V7E2k9cSU69Wd9
 oj1guXAtgFR47QZzrPqvyVgNwyYQJ8skkuGdCX19ISyBfqieHImU5IUwzmi4lsE1fa
X-Received: by 2002:a05:7300:8b2c:b0:304:886b:b07a with SMTP id
 5a478bee46e88-304886bba7bmr3985766eec.14.1779802187961; 
 Tue, 26 May 2026 06:29:47 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3045245d6aesm9854415eec.26.2026.05.26.06.29.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 06:29:47 -0700 (PDT)
Date: Tue, 26 May 2026 06:29:45 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 00/23] add net/sxe2 support for flow control
Message-ID: <20260526062945.6f473fca@phoenix.local>
In-Reply-To: <20260524093259.397506-1-liujie5@linkdatatechnology.com>
References: <20260524093259.397506-1-liujie5@linkdatatechnology.com>
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

On Sun, 24 May 2026 17:32:36 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
> 
> v1:
> -- add support for flow control
> -- add support for flow control status interrupt notification
> -- add support for ipsec inline protocol offload
> 
> Jie Liu (23):
>   net/sxe2: support AVX512 vectorized path for Rx and Tx
>   net/sxe2: add AVX2 vector data path for Rx and Tx
>   drivers: add supported packet types get callback
>   net/sxe2: support L2 filtering and MAC config
>   drivers: support RSS feature
>   net/sxe2: support TM hierarchy and shaping
>   net/sxe2: support IPsec inline protocol offload
>   net/sxe2: support statistics and multi-process
>   drivers: interrupt handling
>   net/sxe2: add NEON vec Rx/Tx burst functions
>   net/sxe2: add support for VF representors
>   net/sxe2: add support for custom UDP tunnel ports
>   net/sxe2: support firmware version reading
>   net/sxe2: implement get monitor address
>   common/sxe2: add shared SFP module definitions
>   net/sxe2: support SFP module info and EEPROM access
>   net/sxe2: implement private dump info
>   net/sxe2: add mbuf validation in Tx debug mode
>   net/sxe2: add testpmd commands for private features
>   net/sxe2: add private devargs parsing
>   net/sxe2: support flow control status interrupt notification
>   net/sxe2: update sxe2 feature matrix docs
>   common/sxe2: add memseg walk callback
> 
>  doc/guides/nics/features/sxe2.ini          |   66 +
>  drivers/common/sxe2/sxe2_common.c          |  156 ++
>  drivers/common/sxe2/sxe2_common.h          |    4 +
>  drivers/common/sxe2/sxe2_flow_public.h     |  633 +++++++
>  drivers/common/sxe2/sxe2_ioctl_chnl.c      |  179 +-
>  drivers/common/sxe2/sxe2_ioctl_chnl_func.h |   18 +
>  drivers/common/sxe2/sxe2_msg.h             |  117 ++
>  drivers/common/sxe2/sxe2_ptype.h           | 1793 ++++++++++++++++++
>  drivers/net/sxe2/meson.build               |   56 +-
>  drivers/net/sxe2/sxe2_cmd_chnl.c           | 1588 +++++++++++++++-
>  drivers/net/sxe2/sxe2_cmd_chnl.h           |  139 ++
>  drivers/net/sxe2/sxe2_drv_cmd.h            |  439 ++++-
>  drivers/net/sxe2/sxe2_dump.c               |  304 +++
>  drivers/net/sxe2/sxe2_dump.h               |   12 +
>  drivers/net/sxe2/sxe2_ethdev.c             | 1526 ++++++++++++++-
>  drivers/net/sxe2/sxe2_ethdev.h             |  113 +-
>  drivers/net/sxe2/sxe2_ethdev_repr.c        |  610 ++++++
>  drivers/net/sxe2/sxe2_ethdev_repr.h        |   32 +
>  drivers/net/sxe2/sxe2_filter.c             |  897 +++++++++
>  drivers/net/sxe2/sxe2_filter.h             |  100 +
>  drivers/net/sxe2/sxe2_flow.c               | 1391 ++++++++++++++
>  drivers/net/sxe2/sxe2_flow.h               |   30 +
>  drivers/net/sxe2/sxe2_flow_define.h        |  144 ++
>  drivers/net/sxe2/sxe2_flow_parse_action.c  | 1182 ++++++++++++
>  drivers/net/sxe2/sxe2_flow_parse_action.h  |   23 +
>  drivers/net/sxe2/sxe2_flow_parse_engine.c  |  106 ++
>  drivers/net/sxe2/sxe2_flow_parse_engine.h  |   13 +
>  drivers/net/sxe2/sxe2_flow_parse_pattern.c | 1935 ++++++++++++++++++++
>  drivers/net/sxe2/sxe2_flow_parse_pattern.h |   46 +
>  drivers/net/sxe2/sxe2_ipsec.c              | 1565 ++++++++++++++++
>  drivers/net/sxe2/sxe2_ipsec.h              |  254 +++
>  drivers/net/sxe2/sxe2_irq.c                | 1024 +++++++++++
>  drivers/net/sxe2/sxe2_irq.h                |   25 +
>  drivers/net/sxe2/sxe2_mac.c                |  535 ++++++
>  drivers/net/sxe2/sxe2_mac.h                |   84 +
>  drivers/net/sxe2/sxe2_mp.c                 |  413 +++++
>  drivers/net/sxe2/sxe2_mp.h                 |   73 +
>  drivers/net/sxe2/sxe2_queue.c              |   17 +-
>  drivers/net/sxe2/sxe2_rss.c                |  584 ++++++
>  drivers/net/sxe2/sxe2_rss.h                |   81 +
>  drivers/net/sxe2/sxe2_rx.c                 |   38 +
>  drivers/net/sxe2/sxe2_rx.h                 |    2 +
>  drivers/net/sxe2/sxe2_security.c           |  335 ++++
>  drivers/net/sxe2/sxe2_security.h           |   77 +
>  drivers/net/sxe2/sxe2_stats.c              |  591 ++++++
>  drivers/net/sxe2/sxe2_stats.h              |   39 +
>  drivers/net/sxe2/sxe2_switchdev.c          |  332 ++++
>  drivers/net/sxe2/sxe2_switchdev.h          |   33 +
>  drivers/net/sxe2/sxe2_testpmd.c            |  733 ++++++++
>  drivers/net/sxe2/sxe2_testpmd_lib.c        |  969 ++++++++++
>  drivers/net/sxe2/sxe2_testpmd_lib.h        |  142 ++
>  drivers/net/sxe2/sxe2_tm.c                 | 1169 ++++++++++++
>  drivers/net/sxe2/sxe2_tm.h                 |   78 +
>  drivers/net/sxe2/sxe2_tx.c                 |    7 +
>  drivers/net/sxe2/sxe2_txrx.c               |  174 +-
>  drivers/net/sxe2/sxe2_txrx.h               |    4 +
>  drivers/net/sxe2/sxe2_txrx_check_mbuf.c    |  595 ++++++
>  drivers/net/sxe2/sxe2_txrx_check_mbuf.h    |   38 +
>  drivers/net/sxe2/sxe2_txrx_poll.c          |  243 ++-
>  drivers/net/sxe2/sxe2_txrx_vec.c           |   46 +-
>  drivers/net/sxe2/sxe2_txrx_vec.h           |   38 +-
>  drivers/net/sxe2/sxe2_txrx_vec_avx2.c      |  777 ++++++++
>  drivers/net/sxe2/sxe2_txrx_vec_avx512.c    |  897 +++++++++
>  drivers/net/sxe2/sxe2_txrx_vec_common.h    |    1 -
>  drivers/net/sxe2/sxe2_txrx_vec_neon.c      |  707 +++++++
>  drivers/net/sxe2/sxe2_vsi.c                |  146 ++
>  drivers/net/sxe2/sxe2_vsi.h                |   12 +-
>  drivers/net/sxe2/sxe2vf_regs.h             |   82 +
>  68 files changed, 26531 insertions(+), 81 deletions(-)
>  create mode 100644 drivers/common/sxe2/sxe2_flow_public.h
>  create mode 100644 drivers/common/sxe2/sxe2_msg.h
>  create mode 100644 drivers/common/sxe2/sxe2_ptype.h
>  create mode 100644 drivers/net/sxe2/sxe2_dump.c
>  create mode 100644 drivers/net/sxe2/sxe2_dump.h
>  create mode 100644 drivers/net/sxe2/sxe2_ethdev_repr.c
>  create mode 100644 drivers/net/sxe2/sxe2_ethdev_repr.h
>  create mode 100644 drivers/net/sxe2/sxe2_filter.c
>  create mode 100644 drivers/net/sxe2/sxe2_filter.h
>  create mode 100644 drivers/net/sxe2/sxe2_flow.c
>  create mode 100644 drivers/net/sxe2/sxe2_flow.h
>  create mode 100644 drivers/net/sxe2/sxe2_flow_define.h
>  create mode 100644 drivers/net/sxe2/sxe2_flow_parse_action.c
>  create mode 100644 drivers/net/sxe2/sxe2_flow_parse_action.h
>  create mode 100644 drivers/net/sxe2/sxe2_flow_parse_engine.c
>  create mode 100644 drivers/net/sxe2/sxe2_flow_parse_engine.h
>  create mode 100644 drivers/net/sxe2/sxe2_flow_parse_pattern.c
>  create mode 100644 drivers/net/sxe2/sxe2_flow_parse_pattern.h
>  create mode 100644 drivers/net/sxe2/sxe2_ipsec.c
>  create mode 100644 drivers/net/sxe2/sxe2_ipsec.h
>  create mode 100644 drivers/net/sxe2/sxe2_irq.c
>  create mode 100644 drivers/net/sxe2/sxe2_mac.c
>  create mode 100644 drivers/net/sxe2/sxe2_mac.h
>  create mode 100644 drivers/net/sxe2/sxe2_mp.c
>  create mode 100644 drivers/net/sxe2/sxe2_mp.h
>  create mode 100644 drivers/net/sxe2/sxe2_rss.c
>  create mode 100644 drivers/net/sxe2/sxe2_rss.h
>  create mode 100644 drivers/net/sxe2/sxe2_security.c
>  create mode 100644 drivers/net/sxe2/sxe2_security.h
>  create mode 100644 drivers/net/sxe2/sxe2_stats.c
>  create mode 100644 drivers/net/sxe2/sxe2_stats.h
>  create mode 100644 drivers/net/sxe2/sxe2_switchdev.c
>  create mode 100644 drivers/net/sxe2/sxe2_switchdev.h
>  create mode 100644 drivers/net/sxe2/sxe2_testpmd.c
>  create mode 100644 drivers/net/sxe2/sxe2_testpmd_lib.c
>  create mode 100644 drivers/net/sxe2/sxe2_testpmd_lib.h
>  create mode 100644 drivers/net/sxe2/sxe2_tm.c
>  create mode 100644 drivers/net/sxe2/sxe2_tm.h
>  create mode 100644 drivers/net/sxe2/sxe2_txrx_check_mbuf.c
>  create mode 100644 drivers/net/sxe2/sxe2_txrx_check_mbuf.h
>  create mode 100644 drivers/net/sxe2/sxe2_txrx_vec_avx2.c
>  create mode 100644 drivers/net/sxe2/sxe2_txrx_vec_avx512.c
>  create mode 100644 drivers/net/sxe2/sxe2_txrx_vec_neon.c
>  create mode 100644 drivers/net/sxe2/sxe2vf_regs.h
> 

Lots of AI review feedback issues (see below).

One other thing which I have recently started looking at is use of __rte_always_inline.
Since much of DPDK has just used __rte_always_inline without justification,
the resulting code is usually slower! Therefore in any new submission,
any use of always inline requires actual benchmark data that it helps.
There are a few case like when there it can help, but very few.
Review of "[PATCH v1 00/23] net/sxe2: PMD updates" series
20 of 23 patches are in the bundle (01-20); 21-23 are missing.

Note: the series targets main, not an LTS branch.


Patch 01/23 (net/sxe2: support AVX512 vectorized path for Rx and Tx)
====================================================================

Error: sxe2_tx_mode_func_set() now contains two back-to-back
       'if (tx_mode_flags & SXE2_TX_MODE_VEC_SET_MASK)' blocks. The first
       sets dev->tx_pkt_burst to sxe2_tx_pkts_vec_sse/sse_simple; the
       second immediately overwrites those assignments (and sets
       tx_pkt_prepare = NULL before the inner if/else decides what to
       set). The first block is dead. Either it was meant to be deleted
       when the AVX512-aware block was added, or the new code should
       have replaced rather than duplicated the old one.

Error: After this patch the first if-block above is no longer wrapped
       in #ifdef RTE_ARCH_X86 (the original '-#ifdef RTE_ARCH_X86' line
       was removed). On non-x86 builds the references to
       sxe2_tx_pkts_vec_sse / sxe2_tx_pkts_vec_sse_simple are
       undefined and the file will not compile.

Error: In sxe2_tx_queue_mbufs_release_vec(), the new non-AVX512 'else'
       branch has 'buffer = txq->buffer_ring;' written twice in a row:

           +               buffer = txq->buffer_ring;
           +               buffer = txq->buffer_ring;

       This is a dead store and indicates careless editing.

Warning: In the same function, after the new
         #ifdef CC_AVX512_SUPPORT / else / #endif block, the original
         trailing 'for (; i < txq->next_use; ++i) { ... }' loop is still
         there. By the time control reaches it, the inner branches have
         already advanced i to txq->next_use, so the loop never runs.
         This is dead code; remove it.

Warning: In sxe2_tx_bufs_free_vec_avx512(), the 'normal' path
         (sxe2_txrx_vec_avx512.c around the rs_thresh loop) is
         misindented and has mismatched braces visually:

            } else {
                rte_mempool_put_bulk(mbuf_free_arr[0]->pool, ...);

           mbuf_free_arr[0] = mbuf;        /* wrong indent */
           free_num = 1;
       }
       }

         The code is syntactically correct but unreadable. Reindent.

Info: 'tx_mode_flags |=  SXE2_TX_MODE_VEC_SSE;' (double space) and the
      Yoda '(0 == (tx_mode_flags & ...))' style are inconsistent with
      the rest of the function which uses 'x == 0'.


Patch 02/23 (net/sxe2: add AVX2 vector data path for Rx and Tx)
===============================================================

Warning: The commit message body ends with

            Signed-off-by: ...
            net/sxe2: support AVX512 vectorized path for Rx and Tx

         The trailing line looks like a stray subject from patch 01
         pasted in. Remove it.

Warning: The new AVX2 meson block adds '-mavx2' to c_args without
         gating on cc.has_argument('-mavx2') or __AVX2__. The AVX512
         block above it checks both compiler and CPU support. Apply
         the same pattern to AVX2 for consistency.

Note: this patch does not delete the duplicate-block / non-x86 bugs
      introduced in patch 01; it extends them with an AVX2 branch in
      the second block while the first SSE-only block is still
      executing first and being overwritten.


Patch 03/23 (drivers: add supported packet types get callback)
==============================================================

Error: drivers/net/sxe2/sxe2_ethdev.c new
       sxe2_buffer_split_supported_hdr_ptypes_get() declares its
       'size_t *no_of_elements' parameter as __rte_unused and never
       writes to it. The ethdev caller
       (rte_eth_buffer_split_get_supported_hdr_ptypes in
       lib/ethdev/rte_ethdev.c) reads no_of_elements after the
       callback returns and uses it as a loop bound. The caller's
       no_of_elements is an uninitialized stack variable, so this
       will iterate a garbage number of times and walk past the
       ptypes[] array. Set *no_of_elements = RTE_DIM(ptypes); before
       returning.

Error: drivers/common/sxe2/sxe2_ptype.h opens with

           #ifndef _SXE2_PTYPE_H_
           #define _SXE2_PTYPE_H_

       and ends with

           #endif /* _RTE_PTYPE_TUNNEL_GRENAT_H_ */

       The closing comment is from a different header. Compilation
       isn't affected but it makes the file look generated/copied.
       Fix the comment.

Warning: The file is a 1793-line static inline function
         (sxe2_init_ptype_list) plus a smaller static inline in a
         header installed under drivers/common/sxe2/. Every TU that
         includes it gets its own copy of the array and code. Move the
         body to a .c file and expose only a prototype.

Warning: sxe2_mtu_set() in sxe2_mac.c declares 'uint16_t mtu
         __rte_unused' and does nothing with the value. It only checks
         dev_started and returns 0. It does not configure hardware,
         does not validate against scatter Rx state, and does not
         re-select Rx/Tx burst functions. ethdev will write
         dev->data->mtu = mtu on return, so the driver silently accepts
         any value the caller passes that passes ethdev's range check.
         If this is a stub, mark it with a TODO; if not, finish it.

Info: sxe2_mac.h begins with a blank line before the SPDX comment.


Patch 04/23 (net/sxe2: support L2 filtering and MAC config)
===========================================================

No findings.


Patch 05/23 (drivers: support RSS feature)
==========================================

Info: '(uint8_t)rte_rand()' in sxe2_rss_hash_key_init throws away
      56 bits of entropy per byte. Use rte_rand() once per 8 key bytes
      or memcpy a uint64_t. Not a correctness bug.


Patch 06/23 (net/sxe2: support TM hierarchy and shaping)
========================================================

Error: Nine occurrences in sxe2_tm.c return positive ENOTSUP instead
       of negative -ENOTSUP:

           ret = ENOTSUP;
           goto l_end;

       Surrounding code uses -EINVAL and -ENOMEM (negative), so this
       is inconsistent and wrong. A positive return is treated as
       success by callers that check 'if (ret)'/'if (ret < 0)'.
       Change all nine to '-ENOTSUP'.


Patch 07/23 (net/sxe2: support IPsec inline protocol offload)
=============================================================

Info: sxe2_ipsec_id_alloc() does a linear bitmap scan for every SA
      allocation. For max_tx_sa/max_rx_sa in the thousands this is
      slow but functionally correct. Consider rte_bitmap_scan or a
      free-list.

Info: '0XFFFF' uppercase X is unusual; rest of the tree uses '0xFFFF'.


Patch 08/23 (net/sxe2: support statistics and multi-process)
============================================================

Info: 'send_reply = false;' assigns false (bool) to an int32_t. Either
      change the type of send_reply to bool or use 0/1.


Patch 09/23 (drivers: interrupt handling)
=========================================

Warning: sxe2_event_intr_post() uses
         rte_malloc(NULL, sizeof(struct sxe2_event_element), 0) for a
         per-event control structure. This consumes hugepage memory
         for an object that does not need DMA, is not shared with
         secondary processes, and is freed on the same thread.
         Use plain malloc().

Warning: The 'write(handler->fd[1], &notify_byte, 1)' return is
         masked with RTE_SET_USED(nw). On EAGAIN/EINTR/short write the
         element is queued but never delivered, and the consumer side
         is never woken. Either loop on EINTR/EAGAIN or check the
         return and unqueue/free the element on failure.


Patch 10/23 (net/sxe2: add NEON vec Rx/Tx burst functions)
==========================================================

Not reviewed in detail this round.


Patch 11/23 (net/sxe2: add support for VF representors)
=======================================================

Error: sxe2_flow_check_rss_action_attr() declares
       'int32_t ret = ENOTSUP;' (positive). It is then overwritten in
       every reachable path (-EINVAL in the default case, 0 at the
       end), so the initial value is a dead store - but the bigger
       problem is the function returns 0 after calling
       rte_flow_error_set() for rss->level > 2, rss->key_len != 0, or
       rss->queue_num != 0. The errors are reported via the error
       object but ret is not set to -EINVAL/-ENOTSUP, so the caller
       sees success. Each of those if-branches should set ret to a
       negative errno and goto l_end (or return immediately).

       Additionally, rte_flow_error_set() is called with positive
       ENOTSUP as the error code. rte_flow API expects negative errno
       (-rte_errno style). Use -ENOTSUP.

       (Same dead-store pattern around 'ret = ENOTSUP;' exists at
       least once more in this patch - audit all occurrences.)


Patches 12-20
=============

Not reviewed in detail this round.


General observations across the series
======================================

- Several patches mix positive and negative errno returns; this is a
  recurring class of bug. Search the whole series for
  'ret = E[A-Z]' (no minus) and audit each hit.

- Multiple files use 'rte_malloc' for per-call control structures
  that do not need hugepage memory.  Use malloc() unless the buffer
  is for DMA, shared between primary/secondary, or NUMA-pinned.

- A few places use 'rte_zmalloc' (no _socket variant) for what looks
  like queue-related state.  Where the buffer is touched by the data
  path or by secondary processes, use rte_zmalloc_socket().

- The Signed-off-by chain in some patches has stray lines after the
  s-o-b (see patch 02). Re-run 'git format-patch' or hand-edit.
