Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD3DC43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 19:02:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD0DA40150;
	Mon, 29 Jun 2026 21:02:07 +0200 (CEST)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com
 [209.85.128.181])
 by mails.dpdk.org (Postfix) with ESMTP id CBB47400D5
 for <dev@dpdk.org>; Mon, 29 Jun 2026 21:02:06 +0200 (CEST)
Received: by mail-yw1-f181.google.com with SMTP id
 00721157ae682-7ff05e5d009so26717717b3.1
 for <dev@dpdk.org>; Mon, 29 Jun 2026 12:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782759726;
 x=1783364526; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zylJw8hQI83SXwAMys2mnv5vrQexegxPvv3sXHBJafQ=;
 b=hKMsCorZ9enX0K8RFo/wFjU7D+Y2ktXi9qNN0hu56L1qe1NHbMYa7nMHye/RDdRYgp
 8Erk/ncpBhIZVvdw0z+3ycrdl7Q62AsR19A7DOyZXQ6tELkCOVMrvYv3b4l/TZWOhypQ
 oKzqm78/6xQjoADIR4L4t7/WzjFTyPwy+O47eYZQ0r9AvG5/sRgdD1dDp4GfOtYEVWgh
 v4peM0YgEyIVH07C0S1wizOW2QZhzCtaMzS3xSTaSjwLfHm0hsRmbWpE6VviT981sStN
 y7si9lsSz5PrKuiYzAxDbn0EYIeSxpNufoi+Rq8SmD6PF6kmvWO6o8ZwodyU9o8Lsqok
 +k6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782759726; x=1783364526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zylJw8hQI83SXwAMys2mnv5vrQexegxPvv3sXHBJafQ=;
 b=OaC9ZISmgIV+5zr1BpJbKhZOx2ZXzaSENYwXwoLHvn3FGvVbVAWK5b3VcKgfJd7Z8B
 w0u/Bdh4rM8TTHdBL8XYnTALC4rJg5FO1nm1vWGfeyacYRt1IUy4FZF+Z2aY2Ws8H6bB
 tubUyhBdE4zEWqpWDFa1/BhzNJCgBAPdQEHB6/JoPMCXPtAG4RDno/zY8CJvz0jYWhA1
 2G72mw5ksr9SWKklenPcHdssi7lUSLPmTVO0GgOGKckZjAAwEsKHe6U12y3ifqFvQBUi
 C18to/+T/ws7kn4FeQIYfv4Y6GY1qL+y8yhIMErOO58Luac/rCe5Sr9BNj1TuhXlXsXN
 J1qw==
X-Gm-Message-State: AOJu0YwC+lfJ0occ8tqUsD1dgNyy2BD7Eo5yXxnaXDI33pbX7LYuU6DA
 KhNOxFz8opMU9I+Ks3suOqxIbZtGzDjCuAlIkBOXvJPCJKhLydUbbzf3rJORgB3pWBjre/oXVO7
 2UDQ5
X-Gm-Gg: AfdE7cmoUXyKLRjX6G/I883z+QHw5DPvGqezrD47E2YvQYaHZlG3Svl0h9Cd+MumetP
 eQuosMj54ng8bb6oc5+YYZbgW7B71jcwURryaWQxj4A0c/FnWGuRfoXZpTl985aYeiW/QBFq4x9
 bY1wrNhWk2VJQLg3q/16GUjVO1zT410kYfjALfiSqqKQk+L9Bz24bwp4gEfrd0CPh/+4bgXHEQS
 C032eJrzOKQ28Y4HNxgTgcte/Ut8Pbr9csEJVhvNOAIeHKzk6HUfdUHNWauV02oY82Mjk7sUtft
 5qTC6gve7prSs3aPzMj671OjsKKaKwlQHtzN63XTvROyIlzyioNLTWPmEUfPlr7nMZTLdpIlQks
 IvDL3mvmoVMmtLovNSmYnJ7oPe2N2/It4mo85Hc3ON+HVhGG0TV3zhZzK8gQOmzd58Fn2MeWWNW
 bPjtVDYn57lGXqqFvqaSD8tDxzG2oLDd4DW2xaCQodRrWi/B85Xha6/g==
X-Received: by 2002:a05:690c:998b:b0:7dd:3463:6872 with SMTP id
 00721157ae682-810d9e09d67mr9132267b3.41.1782759725634; 
 Mon, 29 Jun 2026 12:02:05 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-810e797364bsm1607607b3.17.2026.06.29.12.02.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 12:02:05 -0700 (PDT)
Date: Mon, 29 Jun 2026 12:02:02 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v10 00/23] et/sxe2: added Linkdata sxe2 ethernet driver
Message-ID: <20260629120202.6f7c4f1a@phoenix.local>
In-Reply-To: <20260627040458.845194-1-liujie5@linkdatatechnology.com>
References: <20260626064954.361771-1-liujie5@linkdatatechnology.com>
 <20260627040458.845194-1-liujie5@linkdatatechnology.com>
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

On Sat, 27 Jun 2026 12:04:58 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
> 
> This patch set implements core functionality for the SXE2 PMD,
> including basic driver framework, data path setup, and advanced
> offload features (VLAN, RSS,TM, PTP etc.).
> 
> V10:
> 	Introduce the 'sxe2_txrx_check_mbuf' helper function to validate
> 	outgoing mbuf tunnel type flags when RTE_ETHDEV_DEBUG_TX is enabled.
> 	The function checks that the RTE_MBUF_F_TX_TUNNEL_x flag in mbuf
> 	ol_flags matches the actual tunnel protocol detected in the packet
> 	(GTP, VXLAN, VXLAN-GPE, Geneve, GRE, or IPIP).
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
>  drivers/common/sxe2/sxe2_flow_public.h     |  633 ++++++
>  drivers/common/sxe2/sxe2_ioctl_chnl.c      |  178 +-
>  drivers/common/sxe2/sxe2_ioctl_chnl_func.h |   18 +
>  drivers/common/sxe2/sxe2_msg.h             |  118 ++
>  drivers/net/sxe2/meson.build               |   51 +
>  drivers/net/sxe2/sxe2_cmd_chnl.c           | 1587 ++++++++++++++-
>  drivers/net/sxe2/sxe2_cmd_chnl.h           |  139 ++
>  drivers/net/sxe2/sxe2_drv_cmd.h            |  523 ++++-
>  drivers/net/sxe2/sxe2_dump.c               |  287 +++
>  drivers/net/sxe2/sxe2_dump.h               |   12 +
>  drivers/net/sxe2/sxe2_ethdev.c             | 1496 +++++++++++++-
>  drivers/net/sxe2/sxe2_ethdev.h             |  111 +-
>  drivers/net/sxe2/sxe2_ethdev_repr.c        |  609 ++++++
>  drivers/net/sxe2/sxe2_ethdev_repr.h        |   32 +
>  drivers/net/sxe2/sxe2_filter.c             |  895 +++++++++
>  drivers/net/sxe2/sxe2_filter.h             |  100 +
>  drivers/net/sxe2/sxe2_flow.c               | 1391 +++++++++++++
>  drivers/net/sxe2/sxe2_flow.h               |   30 +
>  drivers/net/sxe2/sxe2_flow_define.h        |  144 ++
>  drivers/net/sxe2/sxe2_flow_parse_action.c  | 1182 +++++++++++
>  drivers/net/sxe2/sxe2_flow_parse_action.h  |   23 +
>  drivers/net/sxe2/sxe2_flow_parse_engine.c  |  106 +
>  drivers/net/sxe2/sxe2_flow_parse_engine.h  |   13 +
>  drivers/net/sxe2/sxe2_flow_parse_pattern.c | 1935 ++++++++++++++++++
>  drivers/net/sxe2/sxe2_flow_parse_pattern.h |   46 +
>  drivers/net/sxe2/sxe2_ipsec.c              | 1565 +++++++++++++++
>  drivers/net/sxe2/sxe2_ipsec.h              |  254 +++
>  drivers/net/sxe2/sxe2_irq.c                | 1026 ++++++++++
>  drivers/net/sxe2/sxe2_irq.h                |   25 +
>  drivers/net/sxe2/sxe2_mac.c                |  530 +++++
>  drivers/net/sxe2/sxe2_mac.h                |   84 +
>  drivers/net/sxe2/sxe2_mp.c                 |  414 ++++
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
>  drivers/net/sxe2/sxe2_switchdev.c          |  332 +++
>  drivers/net/sxe2/sxe2_switchdev.h          |   33 +
>  drivers/net/sxe2/sxe2_tm.c                 | 1151 +++++++++++
>  drivers/net/sxe2/sxe2_tm.h                 |   76 +
>  drivers/net/sxe2/sxe2_tx.c                 |    7 +
>  drivers/net/sxe2/sxe2_txrx.c               | 2106 +++++++++++++++++++-
>  drivers/net/sxe2/sxe2_txrx.h               |    8 +
>  drivers/net/sxe2/sxe2_txrx_poll.c          |  284 ++-
>  drivers/net/sxe2/sxe2_txrx_vec.c           |   46 +-
>  drivers/net/sxe2/sxe2_txrx_vec.h           |   38 +-
>  drivers/net/sxe2/sxe2_txrx_vec_avx2.c      |  747 +++++++
>  drivers/net/sxe2/sxe2_txrx_vec_avx512.c    |  867 ++++++++
>  drivers/net/sxe2/sxe2_txrx_vec_common.h    |   54 +-
>  drivers/net/sxe2/sxe2_txrx_vec_neon.c      |  689 +++++++
>  drivers/net/sxe2/sxe2_txrx_vec_sse.c       |   38 +-
>  drivers/net/sxe2/sxe2_vsi.c                |  146 ++
>  drivers/net/sxe2/sxe2_vsi.h                |   12 +-
>  drivers/net/sxe2/sxe2vf_regs.h             |   85 +
>  65 files changed, 24303 insertions(+), 271 deletions(-)
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
>  create mode 100644 drivers/net/sxe2/sxe2_txrx_vec_avx2.c
>  create mode 100644 drivers/net/sxe2/sxe2_txrx_vec_avx512.c
>  create mode 100644 drivers/net/sxe2/sxe2_txrx_vec_neon.c
>  create mode 100644 drivers/net/sxe2/sxe2vf_regs.h
> 

Thanks for being persistent. 
Applied to next-net
