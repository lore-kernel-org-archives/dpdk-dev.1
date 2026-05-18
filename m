Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE3DCD4F3D
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 00:02:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9136540264;
	Mon, 18 May 2026 02:02:38 +0200 (CEST)
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by mails.dpdk.org (Postfix) with ESMTP id CD31740261
 for <dev@dpdk.org>; Mon, 18 May 2026 02:02:37 +0200 (CEST)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-132d1b2519eso5342462c88.0
 for <dev@dpdk.org>; Sun, 17 May 2026 17:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779062557;
 x=1779667357; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jKKYifzxvANVbKfcmas+aMF875jDbFM/+NVRHHzQ1kc=;
 b=WdgCOsNkjGv7uUm05ZMs/pNTiElWTCZIH5xJWRu67n6rra3E+RXH3wXF20fv8ez+un
 ZVAL31itdf9NAGIeU16KMjyk1LtxZ59jbHKB2XqabuBIcFFrQYLXCtsNm4YfH7uaUIe/
 YQKsloPlkNFAGxvSybL42MIz7yjkg9eM1jpE4dI43jxowIiFsjSQFcxa34R00jnOp/fE
 +WN9aOK5/S11zICu25KBaYwhdtCB2QETnKzcBrRtszgc+lJfFyKIW3PtFPwh+/KQGyjO
 5NUZPeCuXU1TvnymZLSXk9H/l9hiTUwm1xy2Mkl2oug2h4HOamjSayF0lFL+SIeRGz2y
 U5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779062557; x=1779667357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jKKYifzxvANVbKfcmas+aMF875jDbFM/+NVRHHzQ1kc=;
 b=hoAcrU9063EwkxhtJmWbTXOHijiyFUozK7SOA0G4OKNBewvn1E/HJLqi5TJQ8J8hit
 secsBk5OffwAX7iGn6BLygdKLhCz6/ZpihLmjl/MW20gE4y7U7nOrto0sJXYTv/Y30f4
 HgO35f5zRjvSvKRxegtq5qoUcFgFjPMU1aCX5fYa1BRuRiwsmQ+AXglG7v6WVEuK/BPr
 c6WkRz+UY3UpUP2EyNvZhwCbuXkVm3gIyoVAuG72GysoGmTcPIM4kZOtef/U41uTWHBC
 O2/PbMDbFzBzhpVXSeDLhUFYQqrNpaI50ASTFPfRy3ucsZbDN0XbTXmbA8Gf3+THadkw
 2r2A==
X-Gm-Message-State: AOJu0YyUr+qZqrLaSRlpHNpvL1cYbhLXIa2gDbvuceoBa2b0bKmXsBka
 rtB/HC3DXMkIUkn9YPhknKnqmBpB4kfs99K1P9omfym5NxEdtRJxs52SXIdK5rabbQ/82end7e+
 ys19WEBM=
X-Gm-Gg: Acq92OFSfNeLEvzdsZrJYOzuJbYEktCmr/XvB5++z3/GJ4l33IsCqm5S3m1xc1vIPX3
 eN8e0jqDOzib1lecWTYcCafAe7i2xGqe4ssPwDABQOnSkfPsb8wd8O1dj5Bkv7XfWw3zXHVeO5o
 x+CBq66aplPdpvtRJjpKHcBpEhAJKfYZrB186Kejw5Keu1+mvhyaGnwzJGAmtu7dre5Bwp6fh2J
 e2WhI3ItvIwkzC6ZvS36BQTCxz+7yWiPvBrdJwPqJnHkcUWNWAI8tagcPl3mlluRRl9UTbE0OxO
 cyABa9jzDn8k5D5iVE7UnemAtakkhXH70c/EAl3HSSn6Op/uTfUDKDskVHwtrNZAUv4p2iJJO8e
 ceuX6DwIR9IjUS8TSB6RzA9rbOW/kpLOWHm+Vhk6DkgZ9RPxJqJjTcguTU/y//ERK2JuC7Z8ohy
 WzEJxxuRBCiF0AdcvdunepR55zCA0m8WSNCfI=
X-Received: by 2002:a05:7022:6988:b0:12a:b39a:339f with SMTP id
 a92af1059eb24-1350473a96amr5435825c88.21.1779062556517; 
 Sun, 17 May 2026 17:02:36 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cc33aac9sm14138352c88.14.2026.05.17.17.02.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 17:02:36 -0700 (PDT)
Date: Sun, 17 May 2026 17:02:33 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v15 00/11] net/sxe2: fix logic errors and address feedback
Message-ID: <20260517170233.66915942@phoenix.local>
In-Reply-To: <20260516074618.2343883-1-liujie5@linkdatatechnology.com>
References: <20260516025540.2092621-12-liujie5@linkdatatechnology.com>
 <20260516074618.2343883-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Sat, 16 May 2026 15:46:07 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
>=20
> This patch set addresses the feedback received on the v10 submission
> for the sxe2 PMD. The primary focus is on fixing vector path selection,
> ensuring memory safety during mbuf initialization, and cleaning up
> redundant logic in the configuration functions.


Driver is in much better shape now.
AI is still finding a few things.

Review of [PATCH v15 00/11] sxe2 PMD
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Overall comments
----------------

Most of the issues called out in the v13 review have been
addressed in v15:

  - Inverted "if (!ret)" error checks in sxe2_dev_pci_map_init()
    are now "if (ret)".
  - Non-ASCII characters in sxe2_net_map_addr_info_pf[] removed.
  - rte_ticketlock_t around blocking ioctl() replaced with
    pthread_mutex_t.
  - Driver-private u8/s8/u16/... typedefs, __le*/__be* aliases,
    sxe2_errno.h, STATIC macro, and the reinvented
    LIST_FOR_EACH_ENTRY / COMPILER_BARRIER / sxe2_*_lock /
    udelay/mdelay/msleep / __iomem / IS_ERR helpers are gone.
  - "MTU update =3D Y" claim in the features matrix dropped;
    "Free Tx mbuf on demand =3D Y" is now backed by the new
    .tx_done_cleanup callback added in patch 11.
  - Redundant queue_idx bounds checks at the top of
    rx_queue_setup / tx_queue_setup removed.
  - "reseted" log-message typo fixed.

What remains:


Patch 11/11: net/sxe2: implement Tx done cleanup
------------------------------------------------

Error: NULL pointer dereference of tx_queue parameter.
sxe2_tx_done_cleanup() dereferences txq before checking it for
NULL:

  int32_t sxe2_tx_done_cleanup(void *tx_queue, uint32_t free_cnt)
  {
          struct sxe2_tx_queue *txq =3D (struct sxe2_tx_queue *)tx_queue;
          struct sxe2_adapter *adapter =3D txq->vsi->adapter;  /* segfault =
if txq =3D=3D NULL */
          int32_t ret;

          if (txq =3D=3D NULL) {                                  /* too la=
te */
                  ret =3D 0;
                  goto l_end;
          }
          ...

The NULL check must run before any field access:

          struct sxe2_tx_queue *txq =3D tx_queue;
          struct sxe2_adapter *adapter;

          if (txq =3D=3D NULL)
                  return 0;
          adapter =3D txq->vsi->adapter;
          ...


Patch 03/10 -> 09/10: vector mode probe gated on RTE_PROC_PRIMARY
-----------------------------------------------------------------

Warning: sxe2_rx_mode_func_set() runs the vector capability probe
only in the primary process:

          if (rte_eal_process_type() =3D=3D RTE_PROC_PRIMARY) {
                  ret =3D sxe2_rx_vec_support_check(dev, &vec_flags);
                  ...
          }

but sxe2_dev_init() calls sxe2_rx_mode_func_set(dev) and
sxe2_tx_mode_func_set(dev) from the secondary-process branch as
well.  In a secondary, the vector probe is skipped, rx_mode_flags
stays 0, and dev->rx_pkt_burst lands on
sxe2_rx_pkts_scattered{,_split}.  Since dev->rx_pkt_burst is
per-rte_eth_dev and re-written by whichever process attaches
last, the effective Rx burst mode depends on attach ordering.
The same pattern was flagged in v13 and is unchanged in v15.

Either run the same probe in secondaries, or share the primary's
decision through rte_eth_dev_data so secondaries inherit it.


Patch 03/10: common/sxe2: add sxe2 basic structures
---------------------------------------------------

Warning: macro identifier BITS_TO_uint32_t in sxe2_osal.h.  This
is the visible result of a wholesale "u32 -> uint32_t" rename
applied to identifier text without manual review.  The macro is
unused in the rest of the driver (the only mentions are the
definition itself and a later rename of the right-hand side),
so the cleanest fix is to delete it.  If a "bits to 32-bit-word
count" macro is wanted later, name it BITS_TO_U32 or use
RTE_DIM/RTE_ALIGN_MUL_CEIL idioms.


Patch 09/11: drivers: add data path for Rx and Tx
-------------------------------------------------

Info: in sxe2_tx_pkts() the exit chain remains

  l_exit_logic:
        if (tx_num =3D=3D 0)
                goto l_end;
        goto l_end_of_tx;
  l_end_of_tx:
        SXE2_PCI_REG_WRITE_WC(...);

The unconditional "goto l_end_of_tx;" immediately before the
"l_end_of_tx:" label is dead =E2=80=94 fall through.  The same pattern
appears in sxe2_rx_mode_func_set() at the end:

          dev->rx_pkt_burst =3D sxe2_rx_pkts_scattered;
          goto l_end;
  l_end:
          PMD_LOG_DEBUG(...);

Both can simply be deleted.


Series hygiene
--------------

Info: several identifiers are introduced with typos in one patch
and corrected in a later patch within the same series:

  - sxe2_commoin_inited (patch 03) -> sxe2_common_inited (patch 05)
  - sxe2_drv_dev_handshark (patch 03) -> sxe2_drv_dev_handshke
    (patch 04).  The renamed form is still a typo (missing 'a'
    between 'h' and 'k').  Log strings around it were corrected
    to "handshake" in patch 05; the function name was not.
  - Dead "if (ret !=3D 0)" after two void-returning
    sxe2_{rx,tx}_mode_func_set() calls is added in patch 08 and
    removed again in patch 09.

Each commit needs to be independently correct so that "git
bisect" lands on meaningful states.  Renaming an exported
internal symbol (RTE_EXPORT_INTERNAL_SYMBOL(sxe2_drv_dev_handshke))
mid-series also churns the auto-generated version map.  Please
collapse these into the patches that introduce the names, and
fix sxe2_drv_dev_handshke -> sxe2_drv_dev_handshake.
