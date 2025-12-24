Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A7FE78498
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Dec 2025 22:13:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1904340674;
	Wed, 24 Dec 2025 23:13:34 +0100 (CET)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50]) by mails.dpdk.org (Postfix) with ESMTP id 6ED1B40673
 for <dev@dpdk.org>; Wed, 24 Dec 2025 23:13:32 +0100 (CET)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-4308d81fdf6so3013117f8f.2
 for <dev@dpdk.org>; Wed, 24 Dec 2025 14:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766614412;
 x=1767219212; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PnyqqAR4lxNz2L/jcPUa3d1OVH/z/Sw4mH+pS117ZWk=;
 b=A5o49op/fI3ohRZ6LZWXlx5k6deP/DCQ9r8YVhS3EmZHPWr/1TAjm6FRMQN1tEl6Uz
 1t0BgqXscxLRCxt6LijZ5FP3KNU1/O+b8e+DN4w1d6JRi1d/M2oBEqaPBJ0z2V/LnwNP
 fvwuac6eU1wedMNjIJoFkaVgxtu8Oh9GqyHkY+FAYTDPtFgfWYD02Et2UJHSldI3ZJ+h
 pgnK/z0SmmBrku3jl17QtzMuK3/sblSYrwxKFiwccRk7WYTp1Q4RnhZVMM8o5ArqrJ7H
 bXHZu5Lb+z/KXW1MRCyrcjiKWjLIVgdrPELapW1XxwI63sRKd+vXbMs5I1E1s8624khK
 eQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766614412; x=1767219212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PnyqqAR4lxNz2L/jcPUa3d1OVH/z/Sw4mH+pS117ZWk=;
 b=e9nsSUNRqWl2NmISLiJ4PVYiPMB1Tt6vC648K3zp+9+38McW7e+yNg5WZsSj1abegM
 DwZPQ/48O7INuz86KgFdaejC+QQu96uKvTaZ8+PajG8VDARbmv8yh5Q4QzC8lJS4PX7v
 zRmP40b1VB44EKf7OFtfAoN6l7aD2uf64Of2dW84bTBXOujFdWm5gVu60dUqkR+dMrqw
 4uHcaMn1osxpW3ApzGDaRZo0iW/PHFqHy9tBKdwNuav33p/z2MTMf4hksifnoBs3F0Tp
 a+Vsmd5ZDvgiwHofOUklf5VroP166zoUd25e9ltE5CajEgWsBDVCiOSOgsVRc5tN6oyD
 mXSw==
X-Gm-Message-State: AOJu0YxMH1QWBJk4dFaFeeGkkES2aoiFosaF5PjvY3qDEoYZFTw/1xJL
 SjNjpE0ubFJvVxmqH7nLsUdtyXqKRswhgpZP8LabdP2oBjatSHRYIyw86as/0hkR4JCFTrlwKx7
 7pjG3qEQ=
X-Gm-Gg: AY/fxX7vg9VdFNAtEdFziatrIqT3JkjABpeAo+c0VMvP1Ig5uvx28HBpDoZ8K1xlENw
 bqBlPMUf23gYGO6zsY7ylCa7N+O8h9FpXp81o+ywT6kt/+GQJkliwrZAMxdEENDeOX26NOvfsTY
 8tqYPyYjKDWXkH23PmQy0N/S57TSESxeSVkhbXGT1nefUXKLfwSlPCvZw2tud0IqxE8aPdr8TyD
 dnmPG8YFbOrnVOYJNTz4ZIPb8OhOJTrEMotZN25tREYucaA/Pnss/Fxr728LeU2QRRXHsfXbVFp
 7sJxaG7fI3ktwcPHafVMcJGYwF/YnQj/pvKmBZustlYz4DsM0yWoTTN+hwNFH/IP/fYxlCg3w5C
 A0rKYAzFk85sqRtPMGL2nufEItxypTkjPOb1Anf/44BHHAL50kr2IZAXNTVW+qPvTizwpFO1B5h
 L1EfK3dcHCZ848alEjCC0WmaKHDcPNFR1143Q8lTvrBMlPu44srcex3WQY/Vzs
X-Google-Smtp-Source: AGHT+IF+7+aIM9L2lpS7X7kxnH3Hj7z1WRuIeSjJzrIJsC/+4uNDLM00GuLbW4VnIwB9cKgDRfzUPA==
X-Received: by 2002:a05:6000:26c3:b0:430:ff41:5c87 with SMTP id
 ffacd0b85a97d-4324e701157mr20535036f8f.60.1766614411926; 
 Wed, 24 Dec 2025 14:13:31 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea830fesm36796622f8f.20.2025.12.24.14.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Dec 2025 14:13:30 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: [PATCH v7 08/18] eal: warn if thread name is truncated
Date: Wed, 24 Dec 2025 14:11:49 -0800
Message-ID: <20251224221301.52714-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251224221301.52714-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251224221301.52714-1-stephen@networkplumber.org>
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

Thread name is very short 16 characters and therefore the name
dpdk-worker-%d will overflow with more than 9999 worker cores.
Error should be non-fatal since name only matters for debug.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/freebsd/eal.c | 6 ++++--
 lib/eal/linux/eal.c   | 6 ++++--
 lib/eal/windows/eal.c | 6 ++++--
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index 6215245ad5..beda7e0c5c 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -690,8 +690,10 @@ rte_eal_init(int argc, char **argv)
 			rte_panic("Cannot create thread\n");
 
 		/* Set thread_name for aid in debugging. */
-		snprintf(thread_name, sizeof(thread_name),
-				"dpdk-worker%d", i);
+		ret = snprintf(thread_name, sizeof(thread_name), "dpdk-worker%d", i);
+		if (ret >= (int)sizeof(thread_name))
+			EAL_LOG(INFO, "Worker thread name %s truncated", thread_name);
+
 		rte_thread_set_name(lcore_config[i].thread_id, thread_name);
 
 		ret = rte_thread_set_affinity_by_id(lcore_config[i].thread_id,
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index b12f325ddd..d848de03d8 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -863,8 +863,10 @@ rte_eal_init(int argc, char **argv)
 			rte_panic("Cannot create thread\n");
 
 		/* Set thread_name for aid in debugging. */
-		snprintf(thread_name, sizeof(thread_name),
-			"dpdk-worker%d", i);
+		ret = snprintf(thread_name, sizeof(thread_name), "dpdk-worker%d", i);
+		if (ret >= RTE_THREAD_NAME_SIZE)
+			EAL_LOG(INFO, "Worker thread name %s truncated", thread_name);
+
 		rte_thread_set_name(lcore_config[i].thread_id, thread_name);
 
 		ret = rte_thread_set_affinity_by_id(lcore_config[i].thread_id,
diff --git a/lib/eal/windows/eal.c b/lib/eal/windows/eal.c
index 21fe7cb1d9..8b539f8601 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -378,8 +378,10 @@ rte_eal_init(int argc, char **argv)
 			rte_panic("Cannot create thread\n");
 
 		/* Set thread name for aid in debugging. */
-		snprintf(thread_name, sizeof(thread_name),
-			"dpdk-worker%d", i);
+		ret = snprintf(thread_name, sizeof(thread_name), "dpdk-worker%d", i);
+		if (ret >= (int)sizeof(thread_name))
+			EAL_LOG(INFO, "Worker thread name %s truncated", thread_name);
+
 		rte_thread_set_name(lcore_config[i].thread_id, thread_name);
 
 		ret = rte_thread_set_affinity_by_id(lcore_config[i].thread_id,
-- 
2.51.0

