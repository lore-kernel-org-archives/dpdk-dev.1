Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313EFC982ED
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 15:55:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 77AB842E1D;
	Mon, 21 Sep 2026 17:55:11 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 0E3C442DCB
 for <dev@dpdk.org>; Mon, 21 Sep 2026 17:55:11 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396ccd66bb4so2738555a91.1
 for <dev@dpdk.org>; Mon, 21 Sep 2026 08:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790006110;
 x=1790610910; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Q1wd6nAWW5m+farvJP1+PIgboA/S55k7Fl/n1redwj8=;
 b=gyyPlM57IqJ4X6C1BYaM1VBGs7GfGLNDDKIQwzV48h3+P1nU/VeulBUvkaWlGMKP4t
 pmoGuBMaH1HIpz/kPG980bFm5eMjEGErtT0V8RK+O+vmcwSNFlB75MV4yGX3HptGtw+Y
 R8QXS2HZ/oc3y94LleajlX2RqtPn5ni5pSpTduzQH6xEt2635vBBzjbWQIvVEsGiE+oj
 deaE+NLi3fmK1fZxIa001km+qwnJm+6Jvv6HwtCHXeiBQCJIq97Gy1eebUz/6PamhAjI
 EOHLPJe+FeOSCVVuQxCygHO6ymaNs5oa1Lr85PTLwka3cNu1SU36l4w2ZTFwqcB107qY
 mXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790006110; x=1790610910;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q1wd6nAWW5m+farvJP1+PIgboA/S55k7Fl/n1redwj8=;
 b=A2pKWTbEa0hOzR+CdxbLZBQxupJ9hU4obKIenqwg7G3KR0kVOK5Mc4lqWGIZKc159p
 HWmWiIfAwylqbZTYGLx0epRkK+GIZgfUBh74qDXBdi6MZLcFBlFwzjCU36yKi+VXzyfu
 uV8Ke6hVveQuNvUIlihwJ8JSmc27hFfX1kwgh9f/1M0EMqde7b3i/XUJrM9st/mEg2Sd
 f5X5BL2vFxdyaUpoIErtoOm4JuBw8o+BlRufX0ahjUr3NA23fLYU+8BbgJYUBBCZa5vS
 PJvia64ptENSOIhSgG2lITIDOjj1iKe+bvVumOWfqJi2jgySbJGUJXin4DrFU6014qIq
 META==
X-Gm-Message-State: AFuF++nsrGRXOnQDHmPTMGK4fygJbKtJjsoNCUnNhHx5nVNCFf4U3suM
 m3GJYIwi5P0l7GZOOhvYgbSoyMtxnFCMVMtYDlMP/DKTEEx5w1dimBNrCh9uQNw0fi4=
X-Gm-Gg: AYBFou2lHEwOJZlY6rvtaDPsfsPV6A3LfMNYjiNxcU2qmHpQbdGHTm0ds/bAWylIzqA
 IV0Y8494xljqd2SVzvpYGqNx+KBySkbGUI+ps1uy/UG3K2z6iwyYYUktl97I804wlacVOfsOaA8
 u+iIZs7XW3nLMwgMGnuS0Tr8kQ9X2K/LmzvVLFxcbTUvdhi+CDb6824fFZUYSQToT5iIT7NjbtZ
 g9IP6E0d5900Tx1i7p5yfgrVZQNx7tz//Rj6uG5172IEW/kZkadUSRAyxw5/2OkBlbwjvLmVbNY
 HjGtdmVYzBfB1S9/aBQAdYirCrL6JxKgR0ZjJgBCnyJ4ucAeIl6NKvoVgqDVOwKnI1c4wJNGgY0
 D+/qrYFjfztZ2dqGqa9Lvl5ZSvG/A4TdPgeFZQXfxlX/UtB5p40Xv6UVjBfpzYEuaAm9Q0Z5qrZ
 yEQdR4I3+lk913q9IAA03MJH+DDzS38BIf69+NwRihHo/82LQ5Tt9BNylJiBcfowr1vrjPsJw/h
 2MRoTjx+NQvH7kdqvOh++Iq+AkDhPOornBbnJdE
X-Received: by 2002:a17:90b:4a11:b0:39e:6c69:34d4 with SMTP id
 98e67ed59e1d1-39e6c69367cmr11414683a91.56.1790006110068; 
 Mon, 21 Sep 2026 08:55:10 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a063c1994esm735465a91.17.2026.09.21.08.55.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 08:55:09 -0700 (PDT)
Date: Mon, 21 Sep 2026 08:51:25 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Cc: dev@dpdk.org, kishore.padmanabha@broadcom.com
Subject: Re: [PATCH v2] net/bnxt: add Tx DMA error stat counter
Message-ID: <20260921085125.7cc04e04@phoenix.local>
In-Reply-To: <20260921022703.1034465-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260918032812.763436-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260921022703.1034465-1-Mohammad-Shuab.Siddique@broadcom.com>
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

On Sun, 20 Sep 2026 20:27:03 -0600
Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com> wrote:

> From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
> 
> Hardware already reports an invalid/bad DMA address on a Tx BD via
> the TX_CMPL_ERRORS_DMA_ERROR bit in the Tx completion record, but the
> driver never inspected it, so a bad mbuf->buf_iova on Tx completed
> silently with no visibility.
> 
> Check the bit in bnxt_handle_tx_cp() and in the AVX2/SSE vector
> Tx-completion handlers, and count occurrences in a new per-queue
> tx_dma_err counter. The counter is folded into the standard oerrors
> stat and also exposed as a named xstat (tx_dma_err_pkts) for
> finer-grained visibility.
> 
> Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
> ---

[PATCH v2] net/bnxt: add Tx DMA error stat counter

Warning: tx_dma_err is a per-queue, single-writer counter but uses
rte_atomic_fetch_add_explicit() in the completion fast path. That is
a locked RMW for no benefit. Use a plain increment. The existing
tx_mbuf_drop pattern is not a reason to extend it.

Warning: bnxt_handle_tx_cp_vec() in bnxt_rxtx_vec_neon.c is not
updated. arm64 never counts DMA errors.

Warning: the release note says "per-queue xstat", but the patch
exposes a single port-wide sum. Fix one or the other.

Info: "tx_dma_err_pkts" counts completions, not packets. Vector
completions cover opaque packets, and with the following coalescing
patch one completion covers many. Rename the xstat or count packets.
