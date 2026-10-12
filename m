Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB96CA9ED2
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 21:22:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE95240279;
	Mon, 12 Oct 2026 23:22:39 +0200 (CEST)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by mails.dpdk.org (Postfix) with ESMTP id EF17740272
 for <dev@dpdk.org>; Mon, 12 Oct 2026 23:22:38 +0200 (CEST)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-88834d30002so960840b3a.1
 for <dev@dpdk.org>; Mon, 12 Oct 2026 14:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791840157;
 x=1792444957; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NMx1oIuMgTzftSO17/HTcGjRUeJopwGsZnHvuToXmDc=;
 b=Z3C5qi2IqCfCx++hlNYM2D0I2zSR18sPAvS4eu+QVEtz8XDmBqsuDS3y+AlfuEM/sm
 2qYmzgy/wHR3SldQJQ6FxxtBohb/OJw0FFS5JVZ4xzt8Dkv8BTJ2+RUOOT/jRhNRk/mq
 hryMyVqEIHZy7E6taH5sxZCzN/ZLQxHhBxdofLjsW+vbGJXWpdqcIBsu79l1r2fTl6Y+
 te1m+CSMqDGsxdMgZY693sixd6aK0FAIC2sP0ZgkSkY1LFVAJ0GDtvLsPnC3ijNuA3g7
 9YUnXqZIpQaHaq8yMD5U7E/GG07/LrQpnlxiDA2l/v5EUPhgiaU/SlZTHvfsSa3kkZAf
 QK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791840157; x=1792444957;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NMx1oIuMgTzftSO17/HTcGjRUeJopwGsZnHvuToXmDc=;
 b=Z8nh/rEtEVd5CwelbYfrFYhsoHCnxL5E29k7Fo9apVWA0Onn4o/byOUFyKZ5lnd/Ak
 GCXBqErxS8RYIpwnYOyB3UPsT1ihwU0nUHmsTq87I7ENkat75H5Gjh/3NwMtnp/OgDcI
 xs8AZmn73T5Sr9R+YjPTCph5BnrevHokJ6DzwokxynnbXMD9WXqpVVye8DxKYAIIjnRW
 RKuW8IepeX/zay/kB+Nit+mhQ5kDy/4/hrE6k6x+E4Ra9fNOlJNvfukf7cLLbMIyONkh
 Ekl4DKcnyeD07VJiUex90P2npRHxvpv0zlcb4jA5wPvo6VajK9o8sx2U59ueXR/HF8nB
 Ll5g==
X-Gm-Message-State: AFq9FYL7BSkaVdInVDxa+eo5oV0JMDVZe/OQNH9ClzzM5hCf3Ehl+FoT
 PQN2sfPfooUY3YByuK4Pmh9zhHGJzq3/1pPjeWM1KtRIyo1QgeuzYYlNIfIGWqQMbDA=
X-Gm-Gg: AYBFou2Fh76uGEAaNEjR2SPY6BYXtm1/eXlTymHLlKTFhR0ri6++9cqr65lQEqhHGmO
 iHIAxgROmCA16ico7T++H6r92MHC8ontbDIjN5UhyeTJnsNdIC5HG1DK/1OHa1qjOOiIPBix6Q4
 YmgxMC39TgVYwEOkqUQXNwtBGO1fTrVfjRLmuRyON8OQP7140pnmnU8DRyjGXXPV3jSETJPaX16
 tmIFHu+KFd0FtlKFrUWygZl3Hws7XHjPy9XLmM9rxW8UxLnAW1kMsS5nN5nxHI7Ex0OxxxgSMTo
 Zcaln87xJ4onuWeCsZBPJjwdzZD6sB3a2fVnHFNh1zdzbYcAzMTkZhLpQkiny9A67NSFVoY/f8F
 cjLiDAO4fbH4MQK22Ck+7Qh5F7eOo03FGvh+HzhRYbeCFyYlZ0W0+DEiPP4tBrTs1KBORWVC7OO
 dPNaiGMfzjuvtQ8LUgO7rZXh2CtJ1eveDAiPG7bng6mhdvnsfNxiferp50f9IvEWbX5EhuOPzWs
 DnTQnYxPhQB+BzTQwYtqAcYzYFUYUOqeyOEUn8T
X-Received: by 2002:a05:6a00:23c8:b0:87d:dc3c:1b5e with SMTP id
 d2e1a72fcca58-897c634d89fmr8825849b3a.26.1791840156954; 
 Mon, 12 Oct 2026 14:22:36 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-896b68ef2easm4398469b3a.7.2026.10.12.14.22.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 14:22:36 -0700 (PDT)
Date: Mon, 12 Oct 2026 14:22:34 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Prashant Gupta <prashant.gupta_3@nxp.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v9-S2 00/13] net/dpaa2 updates
Message-ID: <20261012142234.2d44b51b@phoenix.local>
In-Reply-To: <20261012070444.2149617-1-prashant.gupta_3@nxp.com>
References: <20261009104900.1120550-1-prashant.gupta_3@nxp.com>
 <20261012070444.2149617-1-prashant.gupta_3@nxp.com>
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

On Mon, 12 Oct 2026 12:34:31 +0530
Prashant Gupta <prashant.gupta_3@nxp.com> wrote:

> Changes in v9:
> - Address review comments for meter and policing support.
> - Add meter resource cleanup during device close.
> - Add policing capability checks.
> - Validate burst size ranges before hardware programming.
> - Fix software/hardware state consistency on profile and policy updates.
> - Use standard FDIR reporting for flow-steered packets.
> - Replace global flow miss configuration with a per-device default flow
>   and remove the DPAA2_FLOW_CONTROL_MISS_FLOW environment variable.
> - Document and gate minimum DPNI version requirement for 24-byte flow keys.
> - Rework parser decode infrastructure and parser-result dumping.
> - Parse additional tunnel and fragmented packet types.
> - Fold parser-related fixes into the originating patches.
> - Remove unused VXLAN offset helpers after soft parser removal.
> - Move release note updates into the existing DPAA2 ethernet driver
>   entry under New Features.
> - Fix coding style issues reported during review.
> 
> Series overview:
> - fix an integer overflow in the CCSR region mapping,
> - set Tx confirmation on device init and support a larger burst size,
> - support MPLS and PPPoE flow distribution, meter and policing, and the
>   flow drop action, with a per-device default flow miss action,
> - identify Rx mbuf hash information by FLC and add minimum key size
>   support,
> - restructure parser processing, parse tunnel and fragmented packet
>   types, remove the unused soft parser driver and rename Rx queue flags.
> 
> Gagandeep Singh (7):
>   net/dpaa2: set Tx confirmation on device init
>   net/dpaa2: support larger burst size
>   net/dpaa2: support MPLS and PPPoE flow distribution
>   net/dpaa2: support meter and policing
>   net/dpaa2: support flow drop action
>   net/dpaa2: set default flow miss action per device
>   net/dpaa2: identify Rx mbuf hash information by FLC
> 
> Hemant Agrawal (4):
>   net/dpaa2: fix integer overflow in CCSR region mapping
>   net/dpaa2: add minimum key size support
>   net/dpaa2: restructure dpaa2 parser processing
>   net/dpaa2: parse tunnel and fragmented packet types
> 
> Jun Yang (2):
>   net/dpaa2: remove unused soft parser driver
>   net/dpaa2: rename Rx queue flags
> 
>  doc/guides/nics/dpaa2.rst               |    1 +
>  doc/guides/nics/features/dpaa2.ini      |    4 +-
>  doc/guides/rel_notes/release_26_11.rst  |   15 +-
>  drivers/net/dpaa2/dpaa2_ethdev.c        |   89 +-
>  drivers/net/dpaa2/dpaa2_ethdev.h        |  218 +++-
>  drivers/net/dpaa2/dpaa2_flow.c          |  633 +++------
>  drivers/net/dpaa2/dpaa2_meter.c         |  804 ++++++++++++
>  drivers/net/dpaa2/dpaa2_parse_dump.h    |  374 ------
>  drivers/net/dpaa2/dpaa2_parser_decode.h | 1549 +++++++++++++++++++++++
>  drivers/net/dpaa2/dpaa2_pmd_logs.h      |   67 +
>  drivers/net/dpaa2/dpaa2_recycle.c       |   24 +-
>  drivers/net/dpaa2/dpaa2_rxtx.c          |  351 +++--
>  drivers/net/dpaa2/dpaa2_sparser.c       |  137 --
>  drivers/net/dpaa2/dpaa2_sparser.h       |  202 ---
>  drivers/net/dpaa2/dpaa2_tm.c            |   16 +-
>  drivers/net/dpaa2/mc/dpni.c             |   11 +-
>  drivers/net/dpaa2/mc/fsl_dpni.h         |   25 +-
>  drivers/net/dpaa2/mc/fsl_dpni_cmd.h     |    3 +-
>  drivers/net/dpaa2/meson.build           |    2 +-
>  19 files changed, 3096 insertions(+), 1429 deletions(-)
>  create mode 100644 drivers/net/dpaa2/dpaa2_meter.c
>  delete mode 100644 drivers/net/dpaa2/dpaa2_parse_dump.h
>  create mode 100644 drivers/net/dpaa2/dpaa2_parser_decode.h
>  delete mode 100644 drivers/net/dpaa2/dpaa2_sparser.c
>  delete mode 100644 drivers/net/dpaa2/dpaa2_sparser.h
> 

In general looks good but there still is this open question.

Review: [PATCH v9-S2 00/13] net/dpaa2 updates

Applies on top of v7-S1. v8 comments on release notes, the
duplicated burst check, and 10/13 indent, naming and commit message
are addressed. Two items from v8 remain.


[PATCH 05/13] net/dpaa2: support meter and policing

Warning: no answer yet on meter_lock. meter_create still drops the
lock around dpaa2_mtr_hw_program(). If control operations can be
concurrent, there is a race here; if not allowed, what is the point
of meter_lock? Either hold it across check, program and insert, or
drop the lock.

Info: fsl_dpni.h still has the orphaned comment left behind when
DPNI_POLICER_OPT_DO_NOT_RESET_COUNTERS was removed:

-/**
- * Do NOT reset counters generally for policer update
- */
-
