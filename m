Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DEBCA9ED0
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 21:09:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1CAA140374;
	Mon, 12 Oct 2026 23:09:54 +0200 (CEST)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44]) by mails.dpdk.org (Postfix) with ESMTP id 20FAD40272
 for <dev@dpdk.org>; Mon, 12 Oct 2026 23:09:53 +0200 (CEST)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-48b042c0759so1720227f8f.2
 for <dev@dpdk.org>; Mon, 12 Oct 2026 14:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791839393; x=1792444193; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fSjdKpgqIbNSOb9hKuixabnm79AqvOF22WFarq1mBgY=;
 b=Z5ePmNbi6lfNTkkiDJjuaKstzm+I01+SEIb/PZaL0p/tKVk0yzAf/b4+oazC18NMlt
 /jJhsecMZ01bwghVC/pJ29nTfYoVCwnhuFBzhnNG/ZhOLOLoD0l1NCCvKBN6Dj7VmIFY
 sfa9jy7KaAGcwTn+v78cdIwZW7BAwCBf4T8DY/9aD9c6JaTIVAvnt2n2H9G1mWPPON5o
 +LE7hyGLJqnzSvBuU1Lp7kiw/evDen/k/5sR2cigfXcHPMhvJHlnJMCCXMxAfyo9LvGr
 WtDw2RLwa4gBVmZusxrKs7Whe9RfUsCLu1Jn+6z+JjpRFjz39QYxw0e1cuGDdSJRPREQ
 28Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791839393; x=1792444193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fSjdKpgqIbNSOb9hKuixabnm79AqvOF22WFarq1mBgY=;
 b=ETk1tjGCZfgzwgR+5bhGZ8Q2Lw2Tr8dYyJUxzVyY50FKrVMW/8r+V0bxggT3OJTk+Z
 ZA8PmycxHD6zffpCJGh7UqLcYVT43HYVylQmZYCIrArtH7ISG3cYfaOqwWghbWtBmhlN
 m0FpKLjHYN+7yagftmRi9TE3ySfi3W5mzL1lme4BLrlQmEtX5pArU1PgI0ObZk0hCRx+
 qhn5zxf14qE/lPPvoyDo3M4+9RntK/RfgCHREbvpQ2Qxa/ad8INWUYqiS/tgszrt5igj
 XgG2/vNaAAiwUFeGXzd64YoEeBDzq6B64zybr8GMISP6ady8lQZFnSSnOn/AW6qDl3QV
 wJwA==
X-Gm-Message-State: AFq9FYIoOvO4yLsIYlclLQkPEHoS4VxO92ZftZWQyFTtMHvwm9pbhYBN
 iiBQEwqntuTe7/SKgIhNW47gA/qyNl32pyQ/5Gv5rpajT43DQUV5z3tPRnnSj9rNeTE=
X-Gm-Gg: AYBFou2P/bOB4WARu8ijTFXrSjox6cPdJ/XDl8UkELsXN4zg65vj8Q5qZbQHu9prJEj
 O3KxhUrbcIgmJje8OZw2S2aD2K1+vO1Mvz10dsDc/Fxnkugz9+pLRuE+YweLywrFr4ONkTWVrhv
 INBPfQl0C3x3yCyzmjUyXhfQmPsrA3ECGbKYej2gM73pa4kb8fFfnoPEOTiDuB457Z5fcCPSCDw
 yCJkVyUMaUYjhs5hjlOo/jwmVsXpJuf4ShiBMdbvBtNIt6pQ58WtObmgD9+i2dSNPeGowMqlhJg
 lAL1OEiRlrQ40yKcBvMQNZqYe68ubP3lmqeGZipDkcZem7d71awb75sK2breg005/4YbVbm+tMU
 igElL93BQsShz9TCR6EXbpegWhHmOTxQBJXJy4/1g3HT9OwYphRXg9GFn2gqorzXhdnTdWcXGU+
 1DKBEQl5bIOy2UhLZK8FflylTqcBaIFVjH3JS6hKlOaw3MADDJaqJtExqgGwNxIptwTtxNVw==
X-Received: by 2002:a05:600c:698d:b0:4a1:98ed:7a79 with SMTP id
 5b1f17b1804b1-4a198ed7aecmr111950815e9.8.1791839392634; 
 Mon, 12 Oct 2026 14:09:52 -0700 (PDT)
Received: from dpdk.lxd ([80.233.57.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf2caf4sm342208725e9.10.2026.10.12.14.09.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 14:09:51 -0700 (PDT)
From: Marat Khalili <qm2k21@gmail.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <qm2k21@gmail.com>
Cc: dev@dpdk.org,
	stephen@networkplumber.org
Subject: [PATCH v2 2/9] bpf: document ethdev callback threading limitations
Date: Mon, 12 Oct 2026 21:09:09 +0000
Message-ID: <20261012210917.161343-3-qm2k21@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012210917.161343-1-qm2k21@gmail.com>
References: <20261011182158.124246-1-qm2k21@gmail.com>
 <20261012210917.161343-1-qm2k21@gmail.com>
MIME-Version: 1.0
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

Document the data plane limitation in the file docstring of
rte_bpf_ethdev.h: packet callback execution expects only one
thread per port/queue pair at a time, making concurrent bursts
(such as with RTE_ETH_TX_OFFLOAD_MT_LOCKFREE, shared RX queues,
or multi-threaded software PMDs) unsupported.

Rephrase the existing control plane multi-threading limitation
to explicitly distinguish it from the data plane requirement.

Signed-off-by: Marat Khalili <qm2k21@gmail.com>
---
 lib/bpf/rte_bpf_ethdev.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/bpf/rte_bpf_ethdev.h b/lib/bpf/rte_bpf_ethdev.h
index 686fda8d94..cf3b4048f0 100644
--- a/lib/bpf/rte_bpf_ethdev.h
+++ b/lib/bpf/rte_bpf_ethdev.h
@@ -10,8 +10,12 @@
  *
  * API to install BPF filter as RX/TX callbacks for eth devices.
  * Note that right now:
- * - it is not MT safe, i.e. it is not allowed to do load/unload for the
- *   same port/queue from different threads in parallel.
+ * - in the data plane, it expects only one thread per port/queue pair at a time.
+ *   Calling RX/TX burst functions concurrently on the same queue (e.g. when using
+ *   RTE_ETH_TX_OFFLOAD_MT_LOCKFREE, shared RX queues, or multi-threaded
+ *   software PMDs) is not supported.
+ * - in the control plane, it is not MT safe, i.e. it is not allowed to do
+ *   load/unload for the same port/queue from different threads in parallel.
  * - though it allows load/unload at runtime
  *   (while RX/TX is ongoing on given port/queue).
  * - allows only one BPF program per port/queue,
-- 
2.43.0

