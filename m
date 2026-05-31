Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8F0CD6E57
	for <dpdk-dev@archiver.kernel.org>; Sun, 31 May 2026 22:34:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E803402F0;
	Mon,  1 Jun 2026 00:34:14 +0200 (CEST)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169]) by mails.dpdk.org (Postfix) with ESMTP id 8B651402F0
 for <dev@dpdk.org>; Mon,  1 Jun 2026 00:34:12 +0200 (CEST)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-304cf518c9dso5340781eec.1
 for <dev@dpdk.org>; Sun, 31 May 2026 15:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780266851;
 x=1780871651; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AfU9uaghz2IXEnUAjifK2ZIjkA9eyYZp1cWd6ZttQYw=;
 b=0aLRz56Oyckvz2DXY4ExhzDboNOeiC8/n6P5/NAvjNe+DWK5AWI5ZCbwXeWETPWwGn
 Cz2TGZiX0VcsyTp1vvrmuSUuj+N5doev4WqNDWTGxA0nUqHMBnw3eMO1+atXKvpYEzbg
 REpDqito+8QVAS35eKhytbA4V6eE4oSiOt4rRbIjop/lvu/d7tvAeEYOrmK4NwxNQxYW
 O/I2dAW6jc2Vr1yIZONAcI9lOHV7QQcLu0rSYlpT/ByAoZi6CO64EQVsbh/KBzWhRfv+
 K86P9hak8SuNuWhGpgl99WfdJcYYg5WNHDOmqDuOltuKXkWbFI85CND7dKfufOPFPcwJ
 lDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780266851; x=1780871651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AfU9uaghz2IXEnUAjifK2ZIjkA9eyYZp1cWd6ZttQYw=;
 b=FOGKIgeEt5dGwW/2qAN9GwvYUacoGmdHgCZ+G1HlvU8bUXdjkLDfSBbk//tK9SPprb
 emNaBg+BXt1Ww1QhbbJrT9DH2x8JGqbD2V/i1vpHfdmFn0GVSuwbYrv6ZMxvER4DhNPq
 rqew2EapxocWy5inPTAsgYdY46tD5mvbp1ETJN+bp6vDeTfT0SLIiopPrmjzhVEVhLIQ
 L+lxoFu5kQryqkj9gUfC1Pr8cqlhYSXOtk2WsS/U79ChKOxUdf3ONVHHtP86vvseWaJ+
 NX2aF3azyzrA8/u2RreGgx0VGp9Mz9JjQF5fn4RPdNuUah141ptmGhEQSZ2WVXMX9gJ3
 oGBg==
X-Gm-Message-State: AOJu0Yw/NcaKVBPysQqHyNAV7eCBI50nWTviM7VABZFsAtM3mxa5nnzW
 uqCvt7GGU+SHMvT010QRgOn34Ry7ppo+gZh7m10OpFf70xdk0ugXIq9aLc+nQnuaaMu356ddnH/
 dMLc5
X-Gm-Gg: Acq92OHggKUFTGWrhiivXlZ2rydUGSClaIYv2ow0+zP/oYLseJp7T0qS6pHDiIXXpzR
 t03mRXk/FBdiuHdZUThU+6R+Oaa5fpfX0HT97S4ylGE56GrouvofPNyMJZKgYLAdOzp20Xseo1L
 ZpuJKJndw1RBanfL9l5TXlXom1N+NkUUJyG0WgBYjeDl3Cl3snkEiUqDFrTH5Q7qYRcYo3NllXy
 S6RRfG6FAEB400qdXCTXnqedG6z960XzOkgyhZfI3zCr7uDtiJy+KQM+VbsFwmcajCy2m9drmfP
 1U9aLyUl9kGm4+zaPtKgoorD10mDUC0lCMtuz5eRhTqBdyqes+avyA+ZemtLhyWbBEKrYHfF6pj
 mUDGbtfIh3q0F4Yx0/f4o4xfZ+kmZ83R0Tvbxj14JoRU0RpA8NRJ+blgvBA3z91lzIyCbuQwBP5
 AW5hIf0DaWv56Dxnc3RL9DrIqc8oQ5hMlG1OTtP+SGh8Zcr7mo0LWJzvWauMi2OkBqkBgu7bfq3
 4FR2RhcKASRug==
X-Received: by 2002:a05:693c:3006:b0:304:d388:c33e with SMTP id
 5a478bee46e88-304fa4a7fd1mr4893996eec.1.1780266851383; 
 Sun, 31 May 2026 15:34:11 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed2c10c1sm7033495eec.1.2026.05.31.15.34.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2026 15:34:11 -0700 (PDT)
Date: Sun, 31 May 2026 15:33:58 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 00/20] net/sxe2: added Linkdata sxe ethernet driver
Message-ID: <20260531153358.33596903@phoenix.local>
In-Reply-To: <20260530184625.480938-1-liujie5@linkdatatechnology.com>
References: <20260530184625.480938-1-liujie5@linkdatatechnology.com>
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

On Sun, 31 May 2026 02:46:05 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
> 
> This patch set implements core functionality for the SXE PMD,
> including basic driver framework, data path setup, and advanced
> offload features (VLAN, RSS, DCB, PTP etc.).
> 
> Jie Liu (20):
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
>   drivers: add support for VF representors
>   net/sxe2: add support for custom UDP tunnel ports
>   net/sxe2: support firmware version reading
>   net/sxe2: implement get monitor address
>   common/sxe2: add shared SFP module definitions
>   net/sxe2: support SFP module info and EEPROM access
>   net/sxe2: implement private dump info
>   net/sxe2: add mbuf validation in Tx debug mode
>   drivers: add testpmd commands for private features
>   net/sxe2: update sxe2 feature matrix docs
> 
>  doc/guides/nics/features/sxe2.ini          |   66 +
>  drivers/common/sxe2/sxe2_common.c          |  156 ++
>  drivers/common/sxe2/sxe2_common.h          |    4 +
>  drivers/common/sxe2/sxe2_flow_public.h     |  633 +++++++
>  drivers/common/sxe2/sxe2_ioctl_chnl.c      |  178 +-
>  drivers/common/sxe2/sxe2_ioctl_chnl_func.h |   18 +
>  drivers/common/sxe2/sxe2_msg.h             |  118 ++
>  drivers/common/sxe2/sxe2_ptype.h           | 1793 ++++++++++++++++++
>  drivers/net/sxe2/meson.build               |   56 +-
>  drivers/net/sxe2/sxe2_cmd_chnl.c           | 1588 +++++++++++++++-
>  drivers/net/sxe2/sxe2_cmd_chnl.h           |  139 ++
>  drivers/net/sxe2/sxe2_drv_cmd.h            |  521 +++++-
>  drivers/net/sxe2/sxe2_dump.c               |  304 +++
>  drivers/net/sxe2/sxe2_dump.h               |   12 +
>  drivers/net/sxe2/sxe2_ethdev.c             | 1525 ++++++++++++++-
>  drivers/net/sxe2/sxe2_ethdev.h             |  112 +-
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
>  drivers/net/sxe2/sxe2_irq.c                | 1025 +++++++++++
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
>  drivers/net/sxe2/sxe2_txrx_vec_common.h    |    1 +
>  drivers/net/sxe2/sxe2_txrx_vec_neon.c      |  707 +++++++
>  drivers/net/sxe2/sxe2_vsi.c                |  146 ++
>  drivers/net/sxe2/sxe2_vsi.h                |   12 +-
>  drivers/net/sxe2/sxe2vf_regs.h             |   82 +
>  68 files changed, 26576 insertions(+), 117 deletions(-)
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

More findings by AI on this patch series.
Re-reviewed the respun sxe2 set (PATCH v1 01-20/20).

Status of the four findings from the previous (v2 23-patch) round:

- 07/20 IPsec valid_key buffer guard:  FIXED. The SXE2_IPSEC_MAX_KEY_LEN
  check now runs first, so it protects all paths including the increment==0
  fixed-size case.
- 09/20 event_thread_run:  FIXED. Now RTE_ATOMIC(uint32_t) with
  rte_atomic_load/store_explicit() (relaxed). Consistent with ndev.
- 14/20 monitor DD mask:  FIXED. Now uses SXE2_RX_DESC_STATUS_DD_MASK.
- devargs asm-generic / parse_u8:  NOT FIXED (see below).

Remaining and new issues:

[PATCH v1 19/20] drivers: add testpmd commands for private features

Error: #include <asm-generic/errno-base.h> is still present (now in this
patch's sxe2_ethdev.c change). It is a Linux kernel-internal header, does not
exist on FreeBSD (meson.build only disables Windows, so FreeBSD remains a
target), does not define the `errno` lvalue the parse callbacks use, and is
included by no other DPDK source. Use #include <errno.h>.

Warning: sxe2_parse_u8() now checks end==value and *end!='\0', which is good,
but the range/truncation problem remains. strtoul() returns unsigned long and
is assigned into `uint8_t u8_val` on the strtoul line itself:

    uint8_t u8_val;
    u8_val = strtoul(value, &end, 10);   /* truncates here */
    ...
    *num = (uint8_t)u8_val;              /* cast is a no-op */

So "300" is truncated to 44 and accepted as valid. Capture the result in an
unsigned long, reject values > UINT8_MAX, then assign. The trailing (uint8_t)
cast does nothing useful as written.

[PATCH v1 20/20] net/sxe2: update sxe2 feature matrix docs

Warning: The driver registers rte_security_ops and advertises
RTE_SECURITY_ACTION_TYPE_INLINE_CRYPTO (patch 07/20), but the updated
feature matrix has no "Inline crypto" entry. ixgbe and txgbe, which use the
same inline-crypto model, list "Inline crypto = Y". Add it (and "security"
if applicable) so the matrix matches the advertised capability.

[PATCH v1 07/20] net/sxe2: support IPsec inline protocol offload

Info: A side effect of the valid_key reordering: the increment==0 branch now
returns is_valid=true before the `src_key < min_key` check, so for a fixed-size
algorithm an under-length key (e.g. a 16-byte key against AES min=max=32) is
accepted. Not a memory-safety issue - the copy is still bounded by
MAX_KEY_LEN - but it drops the lower-bound validation the previous ordering
happened to provide. Consider keeping a `src_key < min_key` reject before the
increment==0 short-circuit.

