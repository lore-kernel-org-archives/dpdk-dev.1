Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7615C606A31E
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Nov 2026 18:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=CQY9JiD4
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94A574027E;
	Mon, 23 Nov 2026 19:22:07 +0100 (CET)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by mails.dpdk.org (Postfix) with ESMTPS id 51BCB4027A
 for <dev@dpdk.org>; Mon, 23 Nov 2026 19:22:06 +0100 (CET)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-cdab8873d9dso1623798a12.1
 for <dev@dpdk.org>; Mon, 23 Nov 2026 10:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1795458124;
 x=1796062924; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2B1A23oMw7HnGqktOaxKXYybsJpsYUAyWXQACVTey2s=;
 b=CQY9JiD4dXoazRONWILProvTDYr3DZL9dpCc7yGbAML6NgyJq/zBxgmumX2o5N52/C
 M0UcrgwPebSlxAogYt9Ub/yZpTQZ7SGC9lPFVtv4J8o/OUBXGIj7UkWj7sKwbn2l2XV4
 H4K6bTuq0qQGAYm3jRlfLnsfwkB+ms31LdDvfHnrUwG1TAAJX1ojbZ+YGQ3D00mvHvwJ
 eTYkGFU4nHx5/VotBobnGBlkWBTEzD/9se0B1wzC9bQP7bhHxA7YvTp7CgSEAoDQsW3a
 a/hQAC9jZKAx4vtDOdOWSBZXxG0fphGt6eni55WZKWF2mTbuc+mhWEQjmpODFx3CGV5f
 41wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795458124; x=1796062924;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2B1A23oMw7HnGqktOaxKXYybsJpsYUAyWXQACVTey2s=;
 b=EQo3y3XSMpFCBIgFm2/vp0bMB90yky2YOJYlU+eHJ0PB9h/IsmqTEw/5JnC0HVcR3L
 2080EFLlP6dagzxOA4oB8EuShExdhZvstKLbj5VnDoro+ntbXGk5VaEao2FXu4KkYYsM
 +Ff1bslZs0I+ZmG3DQo27pUXx0eEFThiYTyhvCpkog/B+6AOSWqYDunEDx2mXv3tkxYM
 1nJa2Y63l6qhgc0+GIyRGwRhqBOX8vL4GnB2eFLDhW+H/pJJais4YDihsdMqfOiokjDj
 c6YwGroUPXRWnGl1iGNfWV7v4WHXyfZMHZGET+zVarD830wevyYTFTqCdrkYYlOFMzbI
 +bCQ==
X-Gm-Message-State: APuU4Z+PHLJeBdxcrRGRYZYdYphcYckjC9hqiuF05sE0I9UFBevkyLAp
 uXbWNznEjhrmSMh/oCggHmNlhRV3Kno1gdNlmwcvO59k0JGpTPyaGlure4WL8DJ14kfqKuEtjPx
 L3zT4DdE=
X-Gm-Gg: AZFdTZeTbpaFWKS1uqB73KMPPAwnViAR2IPsYoz0qod11vySCCSJ813SLo38loKq2KK
 TsSeMi82Ovw937KJco5Y3+xKvoeUKRseOuRV5aGXU0iWwa30JrvCdVU0VYX3d6Af0CNyJnUZ0eL
 YXeZ6jPtwAXqURdRKXM6GAHCqzyFrExTa24N684RLYXSs3wMDDt6ovNA0L5Ssa/k/Y8oaIYKjWa
 9sShAJsBxCyQzmuZSfQc+krruz6EC35P/3ftcn7CZFmoRgt/3CJPLdkpSbhErXmKj49rK1LphYU
 Snrphtew6qpBGFSnwLNWj3XJDOajkfyKjjsnbFzA9yx1cQQKLTNx7DAMyg0fPGO8JdlPhHzHBYu
 rsT5iY4SJKs8K+HKS01N2fjkSpfnIlXQmUnxOaJdinbhSPQaZvMTCjQFQB8HvuNH2kSLWsXq4KB
 ZNrXyk5QQynJxocANPxgk+3TfzhXYBIFIWRgK006MiKTz/HbP6rkb17OP3eM+Rk3a7tAf4w+SMK
 UBIWhPwqA3/m4hpTTWKyUEgkXjZVX9CaU/JpEYN2FiK6M1NmXh+9omPcdP6fs/kwV+Dndr9ED0V
 OqUfoRvbff+R1O1bN9o2MSJLY9CIfrA/Th7jtu6MycUUgwoItC8eiIYMha3695kxDZi5
X-Received: by 2002:a17:90b:1802:b0:3b0:c11a:9026 with SMTP id
 98e67ed59e1d1-3b41c95fa0cmr11471441a91.55.1795458124355; 
 Mon, 23 Nov 2026 10:22:04 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b4b3c71192sm2672376a91.5.2026.11.23.10.22.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 10:22:04 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH] doc: document that fork is not supported after EAL init
Date: Mon, 23 Nov 2026 10:21:10 -0800
Message-ID: <20261123182202.340811-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Follow up to a recently closed bug report. Forking an application after rte_eal_init()
does not work, but this was only mentioned in a couple of driver notes.
State the restriction in the EAL programmer's guide, along with what is still allowed:
exec() in the child, or a child making no DPDK calls.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/env_abstraction_layer.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/doc/guides/prog_guide/env_abstraction_layer.rst b/doc/guides/prog_guide/env_abstraction_layer.rst
index 2f13ee846e..c54c7e73a5 100644
--- a/doc/guides/prog_guide/env_abstraction_layer.rst
+++ b/doc/guides/prog_guide/env_abstraction_layer.rst
@@ -64,6 +64,13 @@ It consists of calls to the pthread library (more specifically, pthread_self(),
     The creation and initialization functions for these objects are not multi-thread safe.
     However, once initialized, the objects themselves can safely be used in multiple threads simultaneously.
 
+.. warning::
+
+    A child created by ``fork()`` after ``rte_eal_init()`` must not use the DPDK.
+    Calling ``exec()`` in the child, or making no DPDK calls at all, is safe.
+    For multiple processes sharing DPDK resources,
+    use the model described in :doc:`multi_proc_support`.
+
 Shutdown and Cleanup
 ~~~~~~~~~~~~~~~~~~~~
 
-- 
2.53.0

