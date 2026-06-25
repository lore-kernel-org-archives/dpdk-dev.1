Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B8DCDE00C
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 22:50:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FED140278;
	Fri, 26 Jun 2026 00:50:42 +0200 (CEST)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174]) by mails.dpdk.org (Postfix) with ESMTP id 8FB9040272
 for <dev@dpdk.org>; Fri, 26 Jun 2026 00:50:40 +0200 (CEST)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-30c591fb1cbso592599eec.1
 for <dev@dpdk.org>; Thu, 25 Jun 2026 15:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782427839;
 x=1783032639; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MfSGkt5a4RLH3W0czr21jZH/XnhQjlKAy4tY3MHhJOU=;
 b=sTuYC2IO5xoAO9NxO+N3pItpAYHg7AkcBLGgfMFaS8rXrszUoRpuzF0sBadQWQhUNF
 rYY+WLUGhWEo0X4mT8P2t0+UxYmgo2OvcKm29vD0Ik4A+Z/4A64pPpy5lFnxOWzAa+8y
 5sL3PXGde3cUi/NcyF5poJWzKvB2ualg9okaKwKbNGAMp5HdOsjfjyJaI+OBJqvqKb8j
 Z6UFs3MTvejS8Dsowz5/gfqS9/6rcCG1eJxWwz8xaUaXdCcs4b1dhdIIIwRHmZl3v+oo
 q4SUCcu/Zyqjm9pWKtz2WW9AN/C8hE+QwFsvopCaF/wW2u7hqjjRo+S7w5bDAINDMie2
 l5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782427839; x=1783032639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MfSGkt5a4RLH3W0czr21jZH/XnhQjlKAy4tY3MHhJOU=;
 b=kVbUJtYvHqZT1O3LlBKKPHRYcGnXm1mnSbtkW/ScpB6qKmr+e+dwXshOHKhvGAxoVy
 kG2GXHDscopmQUMnR7FYoHpNf7CUMASo5N8ZrTvD5rpxbSakEo1Mf4LyO9vF665wYbtV
 Vc/VlKc/9q2MMn+l0rAnYjY1bze2GRLj7fqSdFjFj3/m7xwvZS5hy7o5ueYi+shVnRKb
 sG5atU3llhm9Zc2a0Qm5a+h9zqYAAslXIJdzROvwwki5XCQENbOwTbMjov8HkP2G8vJt
 oO7nGv3aCPhPsH4GJAZmSywU2ttPK1CE+/dSHeUamOK1re/JnMKIZj4q1UECG8ZVzifb
 qvsA==
X-Gm-Message-State: AOJu0YzBinc+kscDEH8O1QZZuM3AzdvrY/f1EFVwcvBIS85tsc61sqAY
 5fYCqEBoES1qvrQxadLpcBZeFucbeWY/v3kFE32HiOYQ42rEht6CPGrvL6b+MokZT/ZGf45lvgO
 unZtN
X-Gm-Gg: AfdE7ckMyn5Jtb3UH55ABwFYNqEJa+Ubw5Lyig3K6HFZ6fcnwbGqhv+VNRaqO3RyXKC
 feh0UKQSiz3FQZvxoHKEd4XFR2MgkLONEkbo/sYDqBRDehnqm82dMzAuICrQpTnCb/lYWgil1kW
 ynFE67EmkNuGnH/ygH4jW9zaKHkVQaon9noYG6uOoeMq3t0pRehYe5tZ4TkAQ1R61IQwqs2P0MV
 1YpKpyvjw7wW48g/a7hmOCyPRI11o3yq1vAp0wt8c7aLN2llerdiB9Yt9gqnGNtQHEVPGiZjuTG
 X6EyRye6N7o1oTiKkG7r9xnlr76/N7FrqPppWS0elsH6BJAMYVNzZ2Btpt3VRREBrFkk3yuEBnC
 FcCmAUzqzRYcmr6I0fcxU4FyObRYhuWWfbrLoW3H/Mm/TTd9OBwIzeqApdBIlBa43XmE7wQl+vP
 4XIzMjhHb6NzJStIgrYEmqitPJNzABug11VsLAerzFSmB0PMT3nkn+Ew==
X-Received: by 2002:a05:7300:7b8a:b0:2ea:4228:ab11 with SMTP id
 5a478bee46e88-30c84b1df71mr3960240eec.3.1782427839243; 
 Thu, 25 Jun 2026 15:50:39 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c4c9dafsm15156505eec.1.2026.06.25.15.50.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 15:50:39 -0700 (PDT)
Date: Thu, 25 Jun 2026 15:50:36 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v8 00/23] net/sxe2: added Linkdata sxe2 ethernet driver
Message-ID: <20260625155036.25f856aa@phoenix.local>
In-Reply-To: <20260625131936.205040-1-liujie5@linkdatatechnology.com>
References: <20260625055021.63243-1-liujie5@linkdatatechnology.com>
 <20260625131936.205040-1-liujie5@linkdatatechnology.com>
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

On Thu, 25 Jun 2026 21:19:36 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
> 
> This patch set implements core functionality for the SXE2 PMD,
> including basic driver framework, data path setup, and advanced
> offload features (VLAN, RSS,TM, PTP etc.).
> 
> v8:
> 	Restore the flow-duplicate-pattern parameter
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
>  doc/guides/nics/sxe2.rst                   |  168 ++
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
>  drivers/net/sxe2/sxe2_ethdev.c             | 1486 ++++++++++++++-
>  drivers/net/sxe2/sxe2_ethdev.h             |  111 +-
>  drivers/net/sxe2/sxe2_ethdev_repr.c        |  609 ++++++
>  drivers/net/sxe2/sxe2_ethdev_repr.h        |   32 +
>  drivers/net/sxe2/sxe2_filter.c             |  895 +++++++++
>  drivers/net/sxe2/sxe2_filter.h             |  100 +
>  drivers/net/sxe2/sxe2_flow.c               | 1394 ++++++++++++++
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
>  67 files changed, 24762 insertions(+), 273 deletions(-)
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

Overall this is close, I don't think the flow duplicate flag you
added matches mlx5 as close as you think. Adding a new variant makes
sense, but try to keep original values matching other driver.
My intent here is to have drivers diverge as little as possible;
it makes it simpler for real world applications.

The AI chat review showed:

[PATCH v8 00/23] sxe2 driver feature additions

The v6 issues are resolved cleanly, except the flow-duplicate-pattern
alignment didn't go in the direction your "align with mlx5" guidance
intended.

Resolved from v6:

- The mbox is now in correct numeric order (06 before 07). git am
  bundle.mbox applies cleanly. The v6 bundle-order break is gone.

- All 23 commits build end-to-end at every commit. The dump-info patch
  was moved from position 19 to 22 - it now runs after devargs parsing,
  which makes its references to devargs fields consistent. sxe2_dump_fc_state()
  also correctly moved out of the devargs patch into the dump-info patch
  where it belongs.

- The v6 flow_dup_pattern_mode orphan situation is fixed. The field is
  now actually written by the new sxe2_parse_flow_dup_pattern_mode()
  parser, properly defaulted to SXE2_FLOW_SW_PATTERN_LAST in init, and
  read at sxe2_flow.c:310 to populate switch_pattern_dup_allow in flow
  metadata. The struct field, its writer, its reader, and its hardware-
  programming path are all consistent now.

- sxe2_parse_no_sched_mode was simplified to call the existing
  sxe2_parse_bool helper instead of duplicating strtoul boilerplate. Nice
  cleanup.

The flow-duplicate-pattern semantics:

This is the v8 redesign in response to "align to mlx5". What it does:

  doc/guides/nics/sxe2.rst, the option:
    0 = reject duplicates with EEXIST
    1 = allow; last-added rule active (LIFO)        <-- default
    2 = allow; first-added rule active (FIFO)

mlx5's equivalent allow_duplicate_pattern is a {0,1} boolean. Its
value=1 means "all rules are inserted but only the first rule takes
effect, the next rule takes effect only if the previous rules are
deleted." That is FIFO. So:

  mlx5 allow_duplicate_pattern=0  ==  sxe2 flow-duplicate-pattern=0
  mlx5 allow_duplicate_pattern=1  ==  sxe2 flow-duplicate-pattern=2 (FIFO)
  (no mlx5 equivalent)            ==  sxe2 flow-duplicate-pattern=1 (LIFO)

This is the worst possible alignment: sxe2 picked the same value range
{0,1} mlx5 has, picked the same name root, picked similar documentation
wording, and made the same value 1 mean the opposite hardware behaviour.
A user who runs the same `-a 0000:xx:xx.x,flow-duplicate-pattern=1` on
both PMDs gets FIFO on mlx5 and LIFO on sxe2 - inverted semantics under
identical names.

If the hardware genuinely supports both LIFO and FIFO and exposing both
is valuable, then naming and defaults should not visually parallel mlx5.
Suggested resolutions, in order of preference:

  (a) Drop LIFO. Document and implement only the two modes mlx5 has:
      0 = reject, 1 = FIFO (mlx5's value=1 semantic). Default 1. The
      name allow_duplicate_pattern (mlx5's spelling) becomes valid -
      same parameter, same values, same defaults across PMDs.

  (b) Keep both modes, but rename to make the meaning explicit and
      non-overlapping with mlx5:
        flow-duplicate-policy=reject|fifo|lifo  (string-valued)
      with reject as default. mlx5 keeps its short boolean; sxe2 has
      its own tri-state with non-aliasing values. This is clear but
      slightly more typing for users.

  (c) Keep current name and values but make value=1 mean FIFO (matching
      mlx5) and value=2 mean LIFO. The name's spelling still differs
      from mlx5's, but at least the integer-to-semantic mapping matches.

Personal preference is (a). The LIFO mode is unusual enough that I would
want to see a concrete use case before accepting it into a public
devarg. If the hardware queues rules in an order applications can
observe, that ordering is an rte_flow priority concern; the devarg layer
shouldn't be encoding it.

A separate small issue in the error-message ternary - sxe2_flow.c:809
prints "Duplicate flow pattern." when mode is non-zero and "Duplicate
flow pattern is not allowed." when mode is zero. But the EEXIST error
path should only fire when the policy is to reject, which is exactly
mode 0. In modes 1 and 2, the hardware accepts the duplicate as a
shadow/active rule; this error path should be unreachable. Either the
ternary's first branch is dead code (in which case remove it and the
ternary; print only the rejection message), or the rejection can
happen in modes 1/2 too (in which case the message must explain why -
table full, action conflict, etc - and the current wording is wrong
in both branches).

Otherwise this revision is in good shape. Once flow-duplicate-pattern
alignment lands one way or another, ready to merge.
