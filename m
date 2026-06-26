Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37F4C43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Jun 2026 18:21:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F13E64042C;
	Fri, 26 Jun 2026 20:21:19 +0200 (CEST)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177]) by mails.dpdk.org (Postfix) with ESMTP id 2697A4026D
 for <dev@dpdk.org>; Fri, 26 Jun 2026 20:21:18 +0200 (CEST)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-30bf132969bso1979301eec.0
 for <dev@dpdk.org>; Fri, 26 Jun 2026 11:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782498077;
 x=1783102877; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MyY4t8l+DG6seU448DoimqmX/n2QVECwSK0hkoOzQG0=;
 b=rV2X7WqE9tzsAaWrRq2fTZj7scp5zzAesddExJk+74eoZnupIybny/0OwtJRKhp2aJ
 Gi3BIR6uZBA8AsKVuP2dhNOEL6aGh+bp2shfB7NS3S1gI6pQ1yUWUvmJwykyCrL0OpTW
 //K68k+so0x6gtKoIkU5qigh95KlsfRbxdRTtvvPv28ljYlUYlJtob8Dk1bNm4qQ2afr
 0SqE7DOLFqQnam9/9y0xwaSD5QIc/ADv7v7+3o8ayfVqZdOlUURshTRGiiPwvOuDNyro
 sDvVj87FLypZhoarIHyuDR4mvLc+UYu1qtHtBqm8AQ1vKoHzwqx2L0TUu8TFcf/RW15A
 MPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782498077; x=1783102877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MyY4t8l+DG6seU448DoimqmX/n2QVECwSK0hkoOzQG0=;
 b=KqBb+6IDwHif3+XD/7lShZcUlu857UlIzPFAMNeDcuGXNrKXE7VApUY1JnSScGNS2i
 anJwkyVEu+AaaD1C5SU6FMh2wu6S02slJM6005ViSLooaJonfekza6G2skifaD65KngW
 Bxgx9A2EcC3AHQ8dBms4O5evwKesid6nELNHJ9GgK8lXZujeP3dmALTsN6EfqSeIr5Xy
 ZLyzTPcspPTNoWvRGr98aj6bFhfoXwHXraNAO9D2+WOMRnysBqseFIBD+DQhXca0XJ6x
 GgdxBkJSRtkBn/fJNECgFoqxY9fFV2fBkMSs+ECw6QAl9LrjjseoyFnfaurs3cX0xi9k
 IQzQ==
X-Gm-Message-State: AOJu0YwrRWZPSw6YARPtcVdJNZFhRyw+yes/4WOlcxpEsbtpMIGtRIRP
 SF4gRZDh8RWkj4nLkYeFSamiPkMnsGwe7AEPrr/0rZ8mtKCLiAjsDqT3wiRv21hrJreZEX/Lm63
 vZpzM
X-Gm-Gg: AfdE7cluPhOn/fJxkBWyxd3lcL6X3Jhzka8bXl5e2bLxWsi1x4gCAS6y2mluAfoQrxU
 hKgrvMp4cjjDBGTzL4Io4LuZoVMqNoIS+U2eFRFpVA2Vvv+4JgysNMVajMXJlCCJPrjZ5CTr5uc
 px/CXU9Xlq68HGKSsvE5lfC9jVFSP+DaUcxZvlzjdWKguz7x+QWBQvZRJQLaRzznd/3JyvvP4X2
 UKztrlibBvXOaKsxstDsPxSvz5ypHm9/cwtevim5wHD+B3hi12hwp6/3Dd+mUhQ0FwbS52LBY2+
 OSkWG1Z9Sxlk4AP8deG5ainccKJbTGw4oIK5iYSDiCv0oG0wxM4ZwKLVhV5VFeOILIDkrHHXaZn
 GKFBYhNfnO6sYhV0DrlnHCdONBvTz89kuU4d6h89iLfQEKkg5urRCWn3DjMsbMZ0E8a4A3uSEoV
 KOfdzM6vdP48VdygXqqV56t6IzvAps8JfkkEyOpilwcWoJG/chGctmWA==
X-Received: by 2002:a05:7300:80ce:b0:30c:ab4f:46a2 with SMTP id
 5a478bee46e88-30cab4f490fmr1229551eec.38.1782498076853; 
 Fri, 26 Jun 2026 11:21:16 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c52eed6sm19441215eec.9.2026.06.26.11.21.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 11:21:16 -0700 (PDT)
Date: Fri, 26 Jun 2026 11:21:14 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v9 19/23] net/sxe2: add mbuf validation in Tx debug mode
Message-ID: <20260626112114.1eddd05e@phoenix.local>
In-Reply-To: <20260626064751.361466-1-liujie5@linkdatatechnology.com>
References: <220260625133139.207632-1-liujie5@linkdatatechnology.com>
 <20260626064751.361466-1-liujie5@linkdatatechnology.com>
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

On Fri, 26 Jun 2026 14:47:51 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
> 
> Introduce the `sxe2_txrx_check_mbuf` helper function to validate outgoing
> mbufs when `RTE_ETHDEV_DEBUG_TX` is enabled. This helps developers catch
> malformed mbufs (e.g., invalid segment lengths, bad offload flags, or
> unaligned buffers) before passing them to the hardware rings, avoiding
> potential hardware hangs or silent packet drops.
> 
> The validation is fully wrapped inside `RTE_ETHDEV_DEBUG_TX` conditional
> compilation blocks to ensure zero performance overhead in standard
> production builds.
> 
> Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
> ---

I don't think I was clear enough before, the verbose description is:


Current state (v9):

The new sxe2_txrx_check_mbuf() helper added in 19/23 is called only
from sxe2_tx_pkts_prepare(), which is the driver's tx_prepare
callback. It is not called from any tx_burst path (sxe2_tx_pkts, the
vec paths, the poll path).

The commit message claims the validation is "fully wrapped inside
RTE_ETHDEV_DEBUG_TX conditional compilation blocks to ensure zero
performance overhead in standard production builds." This is not what
the code does. There is no #ifdef RTE_ETHDEV_DEBUG_TX anywhere in the
new file or around the new call site. In fact the patch *removes* an
existing #ifdef RTE_ETHDEV_DEBUG_TX that previously gated
rte_validate_tx_offload() in the same loop, making that always-on too.

The new function is marked __rte_unused both in the header
declaration and in the .c definition, even though it has exactly one
caller. That attribute was likely a leftover from an earlier draft
where the function was only conditionally referenced.

The validation itself (595 lines) re-derives outer/inner L2/L3/L4
lengths from the packet bytes and compares them against what the mbuf
header declares - i.e., it's verifying that the application
correctly set mbuf->l2_len, l3_len, outer_l2_len, etc. before
submitting. Much of this overlaps what rte_validate_tx_offload() and
rte_net_intel_cksum_prepare() already check, both of which are called
in the same tx_prepare loop.

Desired state:

tx_burst should not contain validation checks for application errors.
The fast path runs once per packet at line rate, and any branch that
exists to catch a caller bug is paid on every well-behaved packet
forever. For driver assumptions that an application must satisfy,
the three sensible options are:

  1. RTE_ASSERT() - compiles out in release builds, surfaces the
     assumption to static analyzers, and fires for users running
     debug builds.

  2. unlikely() with drop-and-counter - if the check is cheap and
     the assumption can be violated in production. The bad packet
     is dropped, a queue stat is incremented, but the burst loop
     continues.

  3. Document the assumption in the API contract and don't check it
     at runtime.

tx_prepare is where validation belongs, and an unconditional check
there is acceptable - tx_prepare is opt-in, and an application that
calls it has already agreed to pay for inspection. The 595-line
function as written is mostly fine in that context. What's wrong is:

  (a) The commit message says one thing and the code does another.
      The author should either add the #ifdef RTE_ETHDEV_DEBUG_TX
      they claimed to add, or rewrite the commit message to describe
      what the patch actually does.

  (b) Driver-specific tx_prepare validation should cover sxe2-
      specific hardware constraints (descriptor count limits, buffer
      alignment, segment size limits) - not redo the generic offload-
      flag and length-consistency checks that rte_validate_tx_offload()
      and rte_net_intel_cksum_prepare() perform. As currently written,
      every packet going through tx_prepare gets its offload flags
      validated roughly twice.

  (c) __rte_unused on the function should be dropped.


Redo this with one of the above and resubmit
