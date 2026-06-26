Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76D3C43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Jun 2026 18:18:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91320402D1;
	Fri, 26 Jun 2026 20:18:49 +0200 (CEST)
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by mails.dpdk.org (Postfix) with ESMTP id B9B8D4026D
 for <dev@dpdk.org>; Fri, 26 Jun 2026 20:18:47 +0200 (CEST)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-139b914bab6so1848833c88.1
 for <dev@dpdk.org>; Fri, 26 Jun 2026 11:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782497927;
 x=1783102727; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N2xG2RvIGr4vYHeS8gF1ZEcCWaYRoWpis9p/QqWeGlA=;
 b=OOVY70aV7MEvQxi2RbpsFBzr3e5u3dVnvDhpsJpA8t087X1K5JLH6vy+JL6WWPE/rM
 sg6OlTVESMwRk38w3yHnL6HTjE48tRGEA37mtYvOqghSZjUOaAthrXQjvVMuZ0feDIvE
 sOdXfbXPgTPuxVdrUg560UZmVo4v0SOO1z6rnKlciQsnYanoZA0rro0aZHUbSSIEOQIm
 qi1nsVcHXTm2d3vTKPD4ODl6s90/GqQ/Yfpd9Z8eLoghZOxYWjAAqftA3NJQXlIp/wp7
 NERIEkKtU5SQrwyqTYS86HNgQi8R7n+8+Jf4qsiXRpMDYofyI9ryChb9+QnVHWdDNXST
 zjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782497927; x=1783102727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N2xG2RvIGr4vYHeS8gF1ZEcCWaYRoWpis9p/QqWeGlA=;
 b=BZRi2LbapBZdU7/0fjlevOkPD2G46jrmRw0U8NWiRw+jnLSQbaJpyAd/7nJAA2uos3
 XyImVKMygWwfaEGUBV4S/YJnsyy5p+uc22ZD3jXpnDaEFOdAUOksA7sSfchU3TDDGGa5
 OeDDoBjgRngwwAsgr648WEkcXgmcsKIeSFemE/SfFxSg5rSsaUbxIQ5cwJzmnZ2j8dFN
 AxgXVkosNENrCZU/1R1lIs/1x9VCHKmjOVkkahmUsq/Lps83OfJ1s9YhLYfv9tycQnFr
 4ros4Pn7bOmwNayGudqqLtTMczxPQ1CnONYFRb0dDD2NsOTRwZvnj7dpEstUvzPPQwcr
 DgqA==
X-Gm-Message-State: AOJu0YxSJipI9XWVxO7kT9qJIoGvFdLbsexBF+/Ie2LGIaRhhSMgI89W
 wGWSThMrXTWWynBjS1eXHCitIYJcYhdg5AwPDnr+zIlp2ARQMs/CABfYAVC2Rp9kGzKyTV7ovZH
 FI1+8
X-Gm-Gg: AfdE7cm/lqAZBbkZOLfznusxiibQBEHPy0ytrMMrjqamhZfrggvy80JTBW3mH5PY8Hh
 J4A7b0D7ze6/OVNWkHda14kPDA3QFe+YRBRcEKeausjj+OmxUCHZAxZAdp35uySKTsYMHb5TAES
 rwHH6cz/y+LQ9XO33lRNXQB3YPoUeJDdMy/Es1NWk0jQ4W5p1coMukiv9uKjQe7wMLlke4Gt/zy
 7FscsMDjn/3XBiZFvoYOl2WSUHKgoL+4H+P+skT31nGMnlR51ZCI3D60S/A38FfHqCYjKmAJ8Zq
 oxQzLHTKdCglZy3TFllhr0vtQkvqepAtfXW5+VBA721IkEpuXEFg6UmRG4vt6GLjsOGOAFcxCXS
 zJ4uUaRHr91FalKYnY8FHNpQljtkmnCUzxUbuaCs371IM9brrQI9dMebn1DANwGkkoXGT8pS22C
 wn2pEgTENL9kF/RlBlJdnJxlnnTpmpRryDVNK42l/miusBaMJV+cU4ig==
X-Received: by 2002:a05:7022:f9e:b0:137:ea00:3f3a with SMTP id
 a92af1059eb24-139dbb2a859mr6119908c88.9.1782497926305; 
 Fri, 26 Jun 2026 11:18:46 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d912197bsm31739809c88.15.2026.06.26.11.18.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 11:18:45 -0700 (PDT)
Date: Fri, 26 Jun 2026 11:18:42 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v9 00/23] net/sxe2: added Linkdata sxe2 ethernet driver
Message-ID: <20260626111842.589a7d12@phoenix.local>
In-Reply-To: <20260626063800.359448-1-liujie5@linkdatatechnology.com>
References: <220260625133139.207632-1-liujie5@linkdatatechnology.com>
 <20260626063800.359448-1-liujie5@linkdatatechnology.com>
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

On Fri, 26 Jun 2026 14:38:00 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
> 
> This patch set implements core functionality for the SXE2 PMD,
> including basic driver framework, data path setup, and advanced
> offload features (VLAN, RSS,TM, PTP etc.).
> 
> v9
> 	Clarify the behavior of the flow-duplicate-pattern parameter
> 
> *** BLURB HERE ***
> 
> Jie Liu (23):
>   net/sxe2: remove software statistics devargs
>   net/sxe2: add Rx framework and packet types callback
>   net/sxe2: support AVX512 vectorized path for Rx and Tx
>   net/sxe2: add AVX2 vector data path for Rx and Tx
>   net/sxe2: add link update callback
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
>   net/sxe2: add mbuf validation in Tx debug mode
>   common/sxe2: add callback for memory event handling
>   net/sxe2: add private devargs parsing
>   net/sxe2: implement private dump info
>   net/sxe2: update sxe2 feature matrix docs
> 
>  doc/guides/nics/features/sxe2.ini          |   56 +
>  doc/guides/nics/sxe2.rst                   |  186 ++
>  drivers/common/sxe2/sxe2_common.c          |  156 ++
>  drivers/common/sxe2/sxe2_common.h          |    4 +
>  drivers/common/sxe2/sxe2_flow_public.h     |  633 +++++++
>  drivers/common/sxe2/sxe2_ioctl_chnl.c      |  178 +-
>  drivers/common/sxe2/sxe2_ioctl_chnl_func.h |   18 +
>  drivers/common/sxe2/sxe2_msg.h             |  118 ++
>  drivers/net/sxe2/meson.build               |   52 +
>  drivers/net/sxe2/sxe2_cmd_chnl.c           | 1587 +++++++++++++++-
>  drivers/net/sxe2/sxe2_cmd_chnl.h           |  139 ++
>  drivers/net/sxe2/sxe2_drv_cmd.h            |  523 +++++-
>  drivers/net/sxe2/sxe2_dump.c               |  287 +++
>  drivers/net/sxe2/sxe2_dump.h               |   12 +
>  drivers/net/sxe2/sxe2_ethdev.c             | 1496 ++++++++++++++-
>  drivers/net/sxe2/sxe2_ethdev.h             |  111 +-
>  drivers/net/sxe2/sxe2_ethdev_repr.c        |  609 ++++++
>  drivers/net/sxe2/sxe2_ethdev_repr.h        |   32 +
>  drivers/net/sxe2/sxe2_filter.c             |  895 +++++++++
>  drivers/net/sxe2/sxe2_filter.h             |  100 +
>  drivers/net/sxe2/sxe2_flow.c               | 1391 ++++++++++++++
>  drivers/net/sxe2/sxe2_flow.h               |   30 +
>  drivers/net/sxe2/sxe2_flow_define.h        |  144 ++
>  drivers/net/sxe2/sxe2_flow_parse_action.c  | 1182 ++++++++++++
>  drivers/net/sxe2/sxe2_flow_parse_action.h  |   23 +
>  drivers/net/sxe2/sxe2_flow_parse_engine.c  |  106 ++
>  drivers/net/sxe2/sxe2_flow_parse_engine.h  |   13 +
>  drivers/net/sxe2/sxe2_flow_parse_pattern.c | 1935 +++++++++++++++++++
>  drivers/net/sxe2/sxe2_flow_parse_pattern.h |   46 +
>  drivers/net/sxe2/sxe2_ipsec.c              | 1565 ++++++++++++++++
>  drivers/net/sxe2/sxe2_ipsec.h              |  254 +++
>  drivers/net/sxe2/sxe2_irq.c                | 1026 ++++++++++
>  drivers/net/sxe2/sxe2_irq.h                |   25 +
>  drivers/net/sxe2/sxe2_mac.c                |  530 ++++++
>  drivers/net/sxe2/sxe2_mac.h                |   84 +
>  drivers/net/sxe2/sxe2_mp.c                 |  414 +++++
>  drivers/net/sxe2/sxe2_mp.h                 |   67 +
>  drivers/net/sxe2/sxe2_queue.c              |   17 +-
>  drivers/net/sxe2/sxe2_queue.h              |   15 +-
>  drivers/net/sxe2/sxe2_rss.c                |  584 ++++++
>  drivers/net/sxe2/sxe2_rss.h                |   81 +
>  drivers/net/sxe2/sxe2_rx.c                 |   93 +-
>  drivers/net/sxe2/sxe2_rx.h                 |    2 +
>  drivers/net/sxe2/sxe2_security.c           |  335 ++++
>  drivers/net/sxe2/sxe2_security.h           |   77 +
>  drivers/net/sxe2/sxe2_stats.c              |  586 ++++++
>  drivers/net/sxe2/sxe2_stats.h              |   39 +
>  drivers/net/sxe2/sxe2_switchdev.c          |  332 ++++
>  drivers/net/sxe2/sxe2_switchdev.h          |   33 +
>  drivers/net/sxe2/sxe2_tm.c                 | 1151 ++++++++++++
>  drivers/net/sxe2/sxe2_tm.h                 |   76 +
>  drivers/net/sxe2/sxe2_tx.c                 |    7 +
>  drivers/net/sxe2/sxe2_txrx.c               | 1958 +++++++++++++++++++-
>  drivers/net/sxe2/sxe2_txrx.h               |    8 +
>  drivers/net/sxe2/sxe2_txrx_check_mbuf.c    |  595 ++++++
>  drivers/net/sxe2/sxe2_txrx_check_mbuf.h    |   38 +
>  drivers/net/sxe2/sxe2_txrx_poll.c          |  284 ++-
>  drivers/net/sxe2/sxe2_txrx_vec.c           |   46 +-
>  drivers/net/sxe2/sxe2_txrx_vec.h           |   38 +-
>  drivers/net/sxe2/sxe2_txrx_vec_avx2.c      |  747 ++++++++
>  drivers/net/sxe2/sxe2_txrx_vec_avx512.c    |  867 +++++++++
>  drivers/net/sxe2/sxe2_txrx_vec_common.h    |   54 +-
>  drivers/net/sxe2/sxe2_txrx_vec_neon.c      |  689 +++++++
>  drivers/net/sxe2/sxe2_txrx_vec_sse.c       |   38 +-
>  drivers/net/sxe2/sxe2_vsi.c                |  146 ++
>  drivers/net/sxe2/sxe2_vsi.h                |   12 +-
>  drivers/net/sxe2/sxe2vf_regs.h             |   85 +
>  67 files changed, 24787 insertions(+), 273 deletions(-)
>  create mode 100644 drivers/common/sxe2/sxe2_flow_public.h
>  create mode 100644 drivers/common/sxe2/sxe2_msg.h
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
>  create mode 100644 drivers/net/sxe2/sxe2_tm.c
>  create mode 100644 drivers/net/sxe2/sxe2_tm.h
>  create mode 100644 drivers/net/sxe2/sxe2_txrx_check_mbuf.c
>  create mode 100644 drivers/net/sxe2/sxe2_txrx_check_mbuf.h
>  create mode 100644 drivers/net/sxe2/sxe2_txrx_vec_avx2.c
>  create mode 100644 drivers/net/sxe2/sxe2_txrx_vec_avx512.c
>  create mode 100644 drivers/net/sxe2/sxe2_txrx_vec_neon.c
>  create mode 100644 drivers/net/sxe2/sxe2vf_regs.h

The devargs parsing looks fixed now.

AI review from long running chat..


[PATCH v9 00/23] sxe2 driver feature additions

Only two patches changed v8 -> v9 (devargs parsing and feature matrix
docs), and they address the flow-duplicate-pattern alignment correctly
this time.

[PATCH v9 21/23] devargs parsing - flow-duplicate-pattern now aligns

The user-facing semantics for value 0 and value 1 now match mlx5's
allow_duplicate_pattern:

  Value   mlx5 allow_duplicate_pattern      sxe2 v9 flow-duplicate-pattern
  -----   --------------------------        --------------------------------
  0       reject duplicates (EEXIST)        reject duplicates (EEXIST)
  1       allow; first rule active (FIFO)   allow; first rule active (FIFO)
  2       (not supported)                   allow; last rule active (LIFO)

Default is 1 in both PMDs. A user who sets flow-duplicate-pattern=1 on
sxe2 now gets the same behaviour as allow_duplicate_pattern=1 on mlx5.
Value 2 (LIFO) is an sxe2-specific extension that mlx5 doesn't have,
and the documentation says so. This is the right shape - aligned where
the capabilities overlap, extended where sxe2 has a real additional
capability.

The implementation uses a small lookup table to map the user value to
the internal enum sxe2_flow_sw_pattern_type (whose numeric ordering
{ONLY=0, LAST=1, FIRST=2} doesn't match the user-facing ordering):

  static const uint8_t udc_tbl[] = {
      SXE2_FLOW_SW_PATTERN_ONLY,   /* user 0 -> 0 */
      SXE2_FLOW_SW_PATTERN_FIRST,  /* user 1 -> 2 */
      SXE2_FLOW_SW_PATTERN_LAST,   /* user 2 -> 1 */
  };

The comment block above the table explains the mapping clearly. The
table name `udc_tbl` is a bit opaque - `user_to_internal[]` or
`mode_map[]` would read better - but the meaning is documented in the
comment so this is a nit, not a blocker.

The orphan ternary in sxe2_flow.c that picked between "Duplicate flow
pattern." and "Duplicate flow pattern is not allowed." based on the
mode value (raised against v8) is gone. Error message is now a single
"Duplicate flow." string, which is appropriate - the rejection path
only fires in mode 0 anyway.

[PATCH v9 23/23] feature matrix docs

Documentation for flow-duplicate-pattern is rewritten to closely match
mlx5.rst's style. The mode 0 and mode 1 paragraphs are essentially
verbatim from mlx5.rst (which is fine - same semantic, same wording is
clearer for users), with mode 2 added as the sxe2-specific extension.
The new paragraph explaining cross-port vs single-port behaviour is
sxe2-specific context that mlx5 doesn't need, and it's a useful clarification.

The default-value note now says "1 (allow duplicates, first-added takes
effect)" - explicit about which mode the default is, which the v8
documentation glossed.


