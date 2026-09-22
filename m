Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCB2C982FA
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 15:52:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C946E4278B;
	Tue, 22 Sep 2026 17:52:53 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id 0C106400D5
 for <dev@dpdk.org>; Tue, 22 Sep 2026 17:52:52 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 d2e1a72fcca58-86b90133ae8so46806b3a.1
 for <dev@dpdk.org>; Tue, 22 Sep 2026 08:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790092371;
 x=1790697171; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mMhO80DCGxpIa3936yV3KEpUr700LvLUcc4kBFK+HFM=;
 b=QxVzkFDJ3PZAYSYH/B9GTCjJ4BdbO3cVIRbUhFU5tZ+lMj+hAhVTXgZD0G4FSfPT8/
 JMn1GhK6Fzjq17/byhJnJBKisxplVadBaHiUJQ/SDO83ks9DIHhhRvNFK52V+cgvdekH
 MGBB7G8cc0zkSdKA/Wb4nuKK6k4yxGo0+AUg8CtT+waTrPOPudej+SQjiRverSFrytc7
 d356wcE5Vi9xHA4T5+tqVqczNf3cI8K6Ws39hqEuypCNGnEREG1zf3PB8aWLhTVZPzpa
 kNAGo8cwpq7PT50/I82w2aS5A9MmQJfkfdMVCQyiEAzzIduPhUzBypc9pTMu53Kf8Ynw
 ucqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790092371; x=1790697171;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mMhO80DCGxpIa3936yV3KEpUr700LvLUcc4kBFK+HFM=;
 b=1qUNC1C/pBc15sjfP2R+On3jj1n123V63MddM3W4pHtkGDVYBOU04JZ7vIneJo7hH1
 8Y60Sd1e2BusbX7fGuQxtxUthYeShjJnmHW7zQCSvxx/osKPzYqB/qERWKLnhlsG20I1
 vS59UKqWO+mQp20UqWh9gwYv3YqwJGd7lDLdALWWl6k3WftlGzKeCTHK2DyrC8eWhKlk
 YdLHbZG8oApu/4Oi3lrBuuloKcJJTdo1mOzMbY4gNyuHhNzn1zIjtRXECGbwX5WRbRE8
 QoI8intA1QO5wkqAONC2PsGoNKS9vW/ve6sL9wHA1zTSWg6RMqtKr7AOD40jRcPvDjQ4
 YM/w==
X-Gm-Message-State: AFuF++k2mSovWAlclyUyXrTy6lDqAUFfX5BdwsKwQzpSEDxSEeFRYmbc
 frMsLO1tkL2dfadeMzAyKQi+N5UHeEVah297LligMKti3HmCcPyFrqt6902s48P2c53IgwBRYPm
 zARlR
X-Gm-Gg: AYBFou3lCnNOC+B3gw8HiQrT0U1/3wc0bofMp0npGpvTvXXJNeWp2oIIks+evfdWp0R
 LXUv5BtfSKxtIWMyZbJcYRA5MGRlWot/MP0qMq7URKlJfS3mbALilOoNuBZhRw7QNaY4vNTuO35
 pnPbGM3N9+1+QR3DuYwwzd1wpaE3UUV8t7mbGOG5jK+nsgOzCXzITxLpwZScrXuJiMQymcfeTTc
 cDxf6unmnrLmbgWoYXXy/GXy6h8KiQnBytJluuPuQENjw1l9XScEb2N4Ibq2GhHlILRFwN8geaM
 C64xQl9lEQQ9AaD39FC0pfVEEjzuuQl4EszN7Ssncg4XrrsUIv7dw3tfcZsg0ZGYDWJ5CkDIIBK
 Shid9IvmxUDdtcvvHQqeyiHf1hpUoTGz3bu1VVaOIANcXOPECAcHVa2ljTPwhqenqYx9+/08+KF
 Ku1BCN881YII9PWaMWCWtYOnlDzDIX3S7ku16q8ASTfFOMWMsrQqOexOS9XF1PJI0KfPWDQFgly
 r7t/sZwm93FpACjrGbGT3c1180rtnZUVhubKQ==
X-Received: by 2002:a05:6a21:6086:b0:3d3:adbf:7781 with SMTP id
 adf61e73a8af0-3ddec6352cemr2353161637.22.1790092371036; 
 Tue, 22 Sep 2026 08:52:51 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc756b5c2e7sm1219347a12.27.2026.09.22.08.52.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 08:52:50 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 0/3] increase memzone name size and fix rib/fib prefixes
Date: Tue, 22 Sep 2026 08:52:07 -0700
Message-ID: <20260922155249.3115271-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921215733.404686-1-stephen@networkplumber.org>
References: <20260921215733.404686-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

This series increases memzone name size and also incorporates
the patch to check FIB and RIB namesizes.

Memzone names are limited to 31 characters, and ring, mempool and stack
names lose the length of their prefixes on top of that.

Patches:
1. fixes hardcoded 32 size in crypto-perf app.
2. increases RTE_MEMZONE_NAMESIZE to 64 and reorders slightly.
3. Anurag Mandal's "fib, rib: fix name prefixes" v2, rebased.

v2 - merge in name size and rib, fib
   - incorporate review comments

Anurag Mandal (1):
  fib, rib: fix name prefixes

Stephen Hemminger (2):
  app/crypto-perf: fix asymmetric op pool name size
  eal: increase memzone name size to 64

 app/test-crypto-perf/cperf_test_common.c |  4 +--
 doc/guides/rel_notes/release_26_11.rst   | 36 ++++++++++++++++++++++++
 lib/eal/include/rte_memzone.h            |  2 +-
 lib/fib/rte_fib.c                        | 16 +++++++++--
 lib/fib/rte_fib6.c                       | 16 +++++++++--
 lib/mempool/rte_mempool.h                | 29 ++++++++++---------
 lib/rib/rte_rib.c                        | 14 +++++++--
 lib/rib/rte_rib6.c                       | 14 +++++++--
 lib/ring/rte_ring_core.h                 |  9 +++---
 9 files changed, 108 insertions(+), 32 deletions(-)

-- 
2.53.0

