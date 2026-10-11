Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9024ECA9EC7
	for <dpdk-dev@archiver.kernel.org>; Sun, 11 Oct 2026 18:23:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E869402D2;
	Sun, 11 Oct 2026 20:22:54 +0200 (CEST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50]) by mails.dpdk.org (Postfix) with ESMTP id 11FA9402D2
 for <dev@dpdk.org>; Sun, 11 Oct 2026 20:22:53 +0200 (CEST)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-6b1af232df4so432789a12.0
 for <dev@dpdk.org>; Sun, 11 Oct 2026 11:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791742972; x=1792347772; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fSjdKpgqIbNSOb9hKuixabnm79AqvOF22WFarq1mBgY=;
 b=gG6Hgy599+Lcf/2nSOgdanrmrL2G/dZM3NWN499GusH4JN/dHgZf6niN1ON9HOM6fV
 Gs0WufEJPRpv7rht+rHENhmjw84xJOBaf7Q57TBq+WlI9IgvTLfciBYGcZvMqx2LCm3y
 ZPpZ4iRCeZjlDlVVt/K9xOLfVbmFoMjJjw+KUJhEB2j0SjRdcWG6UQ0xj9tGJe8So7lr
 3rUmRlVJFOGr6/UF0u19SWBaoEsAl/q1gHVO6z4PqMB07T3hYFWrf18m3tlUpuVemH0I
 XeL4V65dmALxiVXXfFNU+VwDmxTQSxKSKiKdT4m8iVhDZBq4lwnT4ZEO773Xa2d1+lMx
 Agag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791742972; x=1792347772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fSjdKpgqIbNSOb9hKuixabnm79AqvOF22WFarq1mBgY=;
 b=n6pQcCloQ9xxdrlMF6CZpmg9NoBa26R/Hr9lGqyaRnq/Pyy+mEM1acA8uJa7u2Apv/
 O/E+RUODq7jsnmMWT3UOhjonKw9McbQKbThph+QsJmrBduVUjWCFDj5nfZe1grDrJCZW
 W+9bR5afOfjtDeMGnFbQt4X8Fn172IkbUwEALWGrzVut+IQtBTxMOZRCGbEXAO/IkO3z
 iBQ0HXQiIB5RTywWe3+k5P0uQzcTqv/o1TJPvhHOKGg2cInl203Lc7aEcFH4sXK8v4YR
 LaYKJIDCQvL7pT4RdRMXKvuSYIdxiALlNDmp7m+6GGqVRV9099Bb6UBkaf/DLff9V8W+
 43pQ==
X-Gm-Message-State: AFq9FYK74dUal8oIXgHPXoug5U9Rstv3iJWZkYzUhjA9ZFAzFI1kxOQ+
 42AoqJQmo7MABa6HNROiLOZMgkj2KsHssErD4lX4g0Qzb35R/WyetU8E
X-Gm-Gg: AYBFou2RdNC+pLWlS8ZmMxUPSuICccF7yrnDOywGYSYmBGl07/aG1fcz05Dk+vnSwd4
 N0abWJZLhes3CttsTT0ovLoVrfmHo0ZM9dXmO927iZ91WAYpBtTdWrwcI5aFkswXuL2fphekWye
 Dz6DL4GOLC+xtAGpYqplexJxzx0q4AOJ8aXBJ6Idu6hXNaPr/3UCuXDVir6GYTHtya5LH3eX+ju
 KJ4LK9Fd69XijM8p9HixbCxrRBjGeUe+vIQK0OnPqlcqGklHwCi6vM5aJqZspa2Plua1J+y+7/l
 ebVFJXcVZIlimqcE5e7oUp1R0VDrEyAPfMKWNS/hFOSr3a0BKMaqXeQCS13TW97vKRivOhSbSRo
 F6T35+kq5gFysxSQRKDYyy0winPpqmoVWpGGuC7W0A+VLRVZSDpACdeq6caIO4n8rU94kippqpQ
 U5U2NyVw4KQKd3OFTz/i0iaGnNCo54bWhMyBquHzNDKZL1UeLbsKDvA19SoN0EBSQzfEicQA==
X-Received: by 2002:a05:6402:28c4:b0:6b1:c2ad:fd69 with SMTP id
 4fb4d7f45d1cf-6b1c2adfecfmr638492a12.23.1791742972258; 
 Sun, 11 Oct 2026 11:22:52 -0700 (PDT)
Received: from dpdk.lxd ([80.233.48.229]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b179de7e23sm4083718a12.25.2026.10.11.11.22.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 11:22:50 -0700 (PDT)
From: Marat Khalili <qm2k21@gmail.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <qm2k21@gmail.com>
Cc: dev@dpdk.org,
	stephen@networkplumber.org
Subject: [PATCH 2/9] bpf: document ethdev callback threading limitations
Date: Sun, 11 Oct 2026 18:21:50 +0000
Message-ID: <20261011182158.124246-3-qm2k21@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261011182158.124246-1-qm2k21@gmail.com>
References: <20261011182158.124246-1-qm2k21@gmail.com>
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

