Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F398CCFA13
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 23:16:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B1AB54026D;
	Tue, 11 Nov 2025 00:16:51 +0100 (CET)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54]) by mails.dpdk.org (Postfix) with ESMTP id 027D04026A
 for <dev@dpdk.org>; Tue, 11 Nov 2025 00:16:49 +0100 (CET)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-42b3669ca3dso895767f8f.0
 for <dev@dpdk.org>; Mon, 10 Nov 2025 15:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762816609; x=1763421409; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YM4lWklJOuDx2tPKe5x9c3tQrcHlu4Vg9KJbM3bIf6Q=;
 b=DfZkIUPdB60UTF0DIjOs0zz/sNuAoSeKN73FDxgVJDUahqA+0deI6Zco6Kt3CiI4/G
 frwNc6KgtoUHmqJS98Asithw6cKarba+M4B/keQN/fcNdolt2CDLWe0X6jwhL6bT2sYM
 pbnFHuAUsVJfq3LYxuQwHElM31oARzINqdLdwKRhGszjtG2XTkEOJyPBjNrHfVqp+Py3
 ozkkayfhbbtYItridZMrk9GSqpE+qKTv2vY1xPauyW+TzZrnrthAcrMDIVojO+AP1zet
 4zc/w0vtwKBIuEvlJwGbOX/Mje9x2uQ+XJzlpjJuL7DYRncmI5eqsaYxZEBPl0sNv+VX
 Xsyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762816609; x=1763421409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YM4lWklJOuDx2tPKe5x9c3tQrcHlu4Vg9KJbM3bIf6Q=;
 b=lznd1fv4rB3cVNcShvaMW00fmOVBLVVFNBgX8ZJjFPgDcs/B+uLIhxraO5cjPdmWmv
 J/7crXzIioMYb+Ym7rwugnEXGmX8/a2U8kPF/WMwaH+kBPuY2fDdClqqZ1c0y458/wWE
 yBXFlMZkgj1TtULhwEPwlUpnjhLs7KUJUnX/F2gWpGfUNXFi8WLUAHTHdPLRBAP8bodk
 Arb389lQtF+E/P+lgJ96mIJfWi1+Pwy1FcGNfYMwgrE49e9WdD1ebc84ftovxQz/JquP
 /QRekzA64VdcW4qFHwt4SD7nUMM/DnuH/sqy17UhOrByQT7COOyu4PfHgwE3hXJaI9+b
 DSqQ==
X-Gm-Message-State: AOJu0YxL1RrIUHHrriJBsDghvSSuyak4DqJnO8Dr4nFQwUWo624Cb/cm
 F7FA0fd1bTYwhDQjKEtswint7l42MWGnIY4TW7fTI0Yg+OibhNCPIZt/0+xe6Q==
X-Gm-Gg: ASbGncsBH4la8H7VvKxENXJ9hR1j7u7AjR+ppE+dL6vXHHFBDuGdhV0S3virU1YwHmV
 Ttr5J3QnLgQ1/8CW6Lv9j/KAKmeZPiaOz+OvBsVE6gdoMDxYyQ9kE0WInOkaDUOytQwZWuDkv7+
 C6A3jxtYlzHIW01NFqmo0BLEIlOiuu9s5qVOMXs8ZbdgxEGZApdsibnV4l/bjv20gCCpgcCIrkM
 AVSOxkmfYNtUgPzxbwKNy/ITT5nBr0thWdDNlwIMUCw7gY8lurv8t6KGc3oLhQYYTCrhkmyCAGt
 8BkMdQvNQBf2dHgV0dhjoh+KK1TcIUvfeJaOP1h+yepGdDi5lvhoUiB4CJVhlRiWfzMUzu1qEtd
 BSm3AinaNecZFxlAVKT5/qvhJNGLDLWTQaKzyfIbK4RpPf2BWaW66iL+fOGJXK+IU0Rvv0bBimH
 g4MktikBj7/QpbDrd/GLJ1
X-Google-Smtp-Source: AGHT+IG0/w7mWAnTJuYi83ruWyFhq+34H0JeichaapIfwE1kGFJ+EUXNs7cKroch9SRSaHnKjnN06g==
X-Received: by 2002:a05:6000:2908:b0:42b:3a1b:f700 with SMTP id
 ffacd0b85a97d-42b3a1bfbd1mr5142830f8f.20.1762816609304; 
 Mon, 10 Nov 2025 15:16:49 -0800 (PST)
Received: from localhost.localdomain ([46.210.196.60])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-42b330f6899sm13108872f8f.21.2025.11.10.15.16.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 15:16:48 -0800 (PST)
From: Isaac Boukris <iboukris@gmail.com>
To: Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: dev@dpdk.org,
	Isaac Boukris <iboukris@gmail.com>
Subject: [PATCH v2] lib/ring: do not allow zero size ring
Date: Tue, 11 Nov 2025 01:15:45 +0200
Message-ID: <20251110231546.576516-1-iboukris@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251110222827.575488-1-iboukris@gmail.com>
References: <20251110222827.575488-1-iboukris@gmail.com>
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

this might happen when for instance the ring size is read from
config, and would cause runtime crash.

Signed-off-by: Isaac Boukris <iboukris@gmail.com>
---

v2:
* move the fix to the POWEROF2 macro itself.
* fixed style in the test code.

 app/test/test_ring.c | 7 +++++++
 lib/ring/rte_ring.c  | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/app/test/test_ring.c b/app/test/test_ring.c
index ba1fec1de3..3078348b2f 100644
--- a/app/test/test_ring.c
+++ b/app/test/test_ring.c
@@ -505,6 +505,13 @@ test_ring_negative_tests(void)
 	struct rte_ring *rt = NULL;
 	unsigned int i;
 
+	/* Test zero size ring */
+	rp = test_ring_create("test_zero_size_ring", -1, 0, SOCKET_ID_ANY, 0);
+	if (rp != NULL) {
+		printf("Test failed to detect zero size ring\n");
+		goto test_fail;
+	}
+
 	/* Test with esize not a multiple of 4 */
 	rp = test_ring_create("test_bad_element_size", 23,
 				RING_SIZE + 1, SOCKET_ID_ANY, 0);
diff --git a/lib/ring/rte_ring.c b/lib/ring/rte_ring.c
index edd63aa535..0a9fc31530 100644
--- a/lib/ring/rte_ring.c
+++ b/lib/ring/rte_ring.c
@@ -47,7 +47,7 @@ EAL_REGISTER_TAILQ(rte_ring_tailq)
 		     RING_F_MP_HTS_ENQ | RING_F_MC_HTS_DEQ)
 
 /* true if x is a power of 2 */
-#define POWEROF2(x) ((((x)-1) & (x)) == 0)
+#define POWEROF2(x) ((x != 0) && (((x)-1) & (x)) == 0)
 
 /* by default set head/tail distance as 1/8 of ring capacity */
 #define HTD_MAX_DEF	8
-- 
2.49.0

