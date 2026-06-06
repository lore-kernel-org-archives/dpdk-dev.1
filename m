Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC7DCD8C85
	for <dpdk-dev@archiver.kernel.org>; Sat,  6 Jun 2026 06:08:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E40D4028F;
	Sat,  6 Jun 2026 08:08:30 +0200 (CEST)
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com
 [209.85.161.53]) by mails.dpdk.org (Postfix) with ESMTP id 0DA9B4026A
 for <dev@dpdk.org>; Sat,  6 Jun 2026 08:08:28 +0200 (CEST)
Received: by mail-oo1-f53.google.com with SMTP id
 006d021491bc7-69e2c792289so1906435eaf.3
 for <dev@dpdk.org>; Fri, 05 Jun 2026 23:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780726108;
 x=1781330908; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=z6c5Vlv0a2D1tI8iWsPfKZfcumt3VhbEA/peVQFAM4E=;
 b=OuOsAjdNmpp8no6VMQA8u/o9wcbIAOPe8wEikOxZou2OV7EauyjMdRCyZMO+iI8j6/
 07QkXfZMvnrfJIxV50OS6h/knmt+NVpZOdY+MS5XoQBB4hxn392m5YGoeQYU0+n7I5SM
 elYwCVlihjSlNEQGXao3ehLjr1+CP8NMqW+zSaNLVU9LpggMCiMKrQPxNenyoMiOuvhZ
 Lt2+njeLxqlMy5riiDeIyA2m32u5DKsW9DpfhekbSmlCU+cXT7RYmo2xKI7aAMDU5ekJ
 iiIRk2G9kCptgMpM6egUH39Vye/wg/ErPpxZofxajS9LOuFxn18HFK7XveUi1e3vjUBM
 hCvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780726108; x=1781330908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=z6c5Vlv0a2D1tI8iWsPfKZfcumt3VhbEA/peVQFAM4E=;
 b=caI7EQMmU2tOup8tGMAQNFpLPCWhe+laZhNXG/O5hifakM/QoboYIeo6H51jTCPPuV
 DHi6XvcCH65Ej4DNI+/HwBVRR3VJaNHAx7EKroL2BbQ2BksS9RkTuWzViDHAP/oaRuMp
 4Tf0V5GcPjQdvexkYMW4MTZSu72TziFUZ8DKmauFJbn5epPdPv+m8O5YsF7cSnz5pzr/
 4rwSkxRt0W2ioFXvpT8dvl87X6ek5QdXi0B7N2zSwt76bsBNR3Pe2X6xh8PiidgBKWvt
 p6jtCB0ZGDkn+elJrflxLStguYoT4zkE8LUpm+njvtJ7P2RM5/U/ViK+fMJGx2KaZIuI
 /30w==
X-Gm-Message-State: AOJu0YyZWBJWEd4VMLSRpn6xGlXmX0Svo/R/YuALb/6BIPdTUM+/tyri
 mfbBZJD/OB7oLo/dHAEuP69cJmUgDmLntxCwRrt7F20qmuhU1LLQsEW35u9r6h3lXANgF50kBeO
 0UYHl
X-Gm-Gg: Acq92OH/jPjIHLSpJ+4E+TanVCs5wxqWWVc/VhFVB1LWWkbo9kdwUvKPl7yKRUcbQjG
 1+hmVNPX970fMYW1UcDzTno3SteOdRASyDeX5xBoAPvPA7HHvhVWwff0khhQwAkaaP7Ga6cIc+Q
 cuaf58adYBF+fFdMjJvr4Jp/NoimLnL2dyd8VuXXhBKgH6vddWT1cIE9k/Dl3zX3JMHIH4t7q9j
 z4bMjcFBogWwaD3KW57r414CWM23OutVx8/FekUXYty7HCjqP/mib+HVzwdKcaXfuBrmMOLRlzH
 simWSoTOhGdGRFHr7ejQxMnY0m55SFZHOy2E0e1bY/xt1/CuEjudn4CrLGSsFsvHHcqb2jXwfCS
 XNHYplfT5fklfMGF+9UDZUO5rQc+tEng647DMAL+Vb24agGFoufmROFPHh3aELF0158xFoLpLOj
 FxSV3FslofeXAC3gkVVkOYPmDkClfioxO9l1xNcKBuB/GVrQR8fVOtQw+g5yF3uQ2Iscv4DGqLm
 eI=
X-Received: by 2002:a05:6820:4cc2:b0:69d:cfb6:4f53 with SMTP id
 006d021491bc7-69e68b08dbamr4133723eaf.9.1780726107799; 
 Fri, 05 Jun 2026 23:08:27 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69e46450223sm6461817eaf.14.2026.06.05.23.08.27
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 23:08:27 -0700 (PDT)
Date: Fri, 5 Jun 2026 23:08:24 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: Re: [PATCH 0/8] telemetry: thread-safe and bounded parameter parsing
Message-ID: <20260605230824.4b2c6fed@phoenix.local>
In-Reply-To: <20260605205253.520196-1-stephen@networkplumber.org>
References: <20260605205253.520196-1-stephen@networkplumber.org>
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

On Fri,  5 Jun 2026 13:50:57 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> While looking into extending telemetry for other uses, I noticed a
> pattern of unsafe string handling in the command handlers. They run one
> thread per client connection but parse parameters with non-reentrant
> strtok(), and convert ids with atoi()/unchecked strtoul() that silently
> truncate or alias out-of-range values; in eth_rx the strtok()
> continuation chain can also dereference freed memory.
> 
> This series covers the library code (telemetry, ethdev, dmadev, security,
> eventdev, eth_rx, timer). A follow-up is needed for the same strtok()
> use in drivers.
> 
> They are marked for stable: the races and the use-after-free are real and
> the changes are low-risk to backport. But severity is low since telemetry is
> not a remote interface, but these are the kind of issues likely to
> be found by AI security scanning tools.
> 
> In future, atoi() and strtok() look worth adding to the forbidden
> tokens list in devtools/checkpatches.sh.
> 
> Stephen Hemminger (8):
>   telemetry: fix thread-unsafe command parsing
>   ethdev: make telemetry parameter parsing thread-safe
>   dmadev: validate telemetry parameters
>   security: harden telemetry parameter parsing
>   eventdev: remove strtok from telemetry handlers
>   eventdev/eth_rx: fix thread-unsafe telemetry parsing
>   eventdev/eth_rx: reject out-of-range telemetry adapter ID
>   eventdev/timer: reject out-of-range ID
> 
>  lib/dmadev/rte_dmadev.c                 |  44 +++++---
>  lib/ethdev/rte_ethdev_telemetry.c       |  12 ++-
>  lib/eventdev/rte_event_eth_rx_adapter.c |  97 ++++++++---------
>  lib/eventdev/rte_event_timer_adapter.c  |  22 ++--
>  lib/eventdev/rte_eventdev.c             | 136 +++++++++++-------------
>  lib/security/rte_security.c             |  41 ++++---
>  lib/telemetry/telemetry.c               |   5 +-
>  7 files changed, 186 insertions(+), 171 deletions(-)
> 

FYI - the CI AI review is all false positives on this.
Fed the review back into more capable AI that actually looks at the
code like a human and...

Thanks, but I believe all of these are false positives:

- rxa_validate_id() "%lu with uint8_t callers": the (unsigned long) cast is inside the macro, so the argument is unsigned long regardless of caller type. %lu is correct.

- parse_dev_id() / RTE_EVENT_MAX_DEVS: no such function or constant in this change; the bound is unchanged at RTE_EVENT_ETH_RX_ADAPTER_MAX_INSTANCE.

- cnxk qid upper-bound: the existing "qid >= node->n_rq" check already rejects any value above the (small) queue count before it is passed on, so qid > UINT16_MAX cannot reach the ctx function.

- capa_id bounds: security_capability_by_index() walks to the RTE_SECURITY_ACTION_TYPE_NONE sentinel and returns NULL for an out-of-range index, so there is no out-of-bounds access.

The max <= INT_MAX assertion in telemetry_parse_uint() is reasonable as documentation, but both callers pass values within range so it is not a correctness issue.
