Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248B3CD4F26
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 23:26:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 82FD040689;
	Wed, 24 Jun 2026 01:25:37 +0200 (CEST)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182]) by mails.dpdk.org (Postfix) with ESMTP id 2F35A40663
 for <dev@dpdk.org>; Wed, 24 Jun 2026 01:25:32 +0200 (CEST)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-30bf132969bso533227eec.0
 for <dev@dpdk.org>; Tue, 23 Jun 2026 16:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782257131;
 x=1782861931; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p+5khoGkRjFUAF4oGoTstncIY5BnGcLJYvfQnndowQw=;
 b=zXpVZszXMeMGL4AVF96yihvR3QaS5VYeG3yKBcY/Lvarv1BnUgJxRVkuBuuBABunuH
 nuEFp5GwW2l8dwMxdo00HUGREu+iDRh4/qteTy9vUCw3kl10wQIlrCafgRUI6rSYPxA3
 023xRFuFQyDFfk/uFHPdLUNNSTPKN2argBIy1LBCRr29V4Yeoo45Z9wzhhteaoKij1Zs
 SkeYSyxkQfganErB1Rx4p82JrLQ/O66i7N1I1pV3ptvEo97e8CJwUd+Ox9zjPrr4KRVC
 jRzvlGthwRRZgDfQKIvE+35IrGp84FIbaVI+4ZFQsHdCJze/LyMF92mnHrTN8ZWKj6Uk
 JMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782257131; x=1782861931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p+5khoGkRjFUAF4oGoTstncIY5BnGcLJYvfQnndowQw=;
 b=YBmqM4Q8NxV4tBzto3h5UwMLCFALGk/ZOVseszp6GeblfEcI/GA21HIffjZqTfU9ZJ
 peSVD93hCBN4fdb33vQ+S3S47ju/g4XZA1ylXZYf4E4VqgAfR2/YVLu4pe/E4hhk4Rr9
 9hSoGo4gzIz9dLnkaJ6k9+ywR7+CmakwT1d0lHL1S1Ot2qZ23LeYWLh5Clt864q7mhlk
 2zPJxz9E7anIWZS1Ic3PjQQI6Hr6aEWVrVMcbNCh4PZMRhvs+LfK7pKfiaXi2Zd6+Uf4
 PxYld/OuFvEvEOcxEKFFNAnNftqSUnOT9gurcFKSv+7WT8alG/UiH+OzsVsDEs8SprRb
 PLNg==
X-Gm-Message-State: AOJu0Ywws46BiZerbDDmD9ivT5RuVARCX4UG6nQ/gk5toeBiWVrchDzt
 3GKwhayiUmaVrhzYOQS2tuKcjidBX5C+i3p8x0JRllJj/YfsC/qGq9/KVg+OlQAPoQJesnJapln
 HYPWy
X-Gm-Gg: AfdE7cmmPzJUmyTidHNd8GXOFFKfqq2O9UGjRQm/KUNSwz6lXTikSD1+t3rNGPZr8nn
 Vsm9+G3S6eDtVwJdO0BdMKTtk5qe2UCjmKkx2IWU9hpSSUtp1PDTkTebVvIbma0b0T6ZSsh/lrH
 kY8Lu3Skv68KF2DGJv0EF4LyKndyHbtajBYUZKl4KXX++IZ0ZmO1KW+K4m6SaeCLkhEQ1+Iuobn
 rtZKUAVlXiw0mHKh7yaI6EG2bm9aUxK9qvGJJV8XMKp7jnAyeW7hDAprt6LqaOIRSEJlCZcDZvZ
 e2z/rHndu++tW79F1Te/sA3iKf80cU//LhVf2BS7tqmNLi/wusRQoNvS9v5KHJ8V7p/7JpZRaNn
 i7q1LSLHNe1eacT/O+aKw/AGZb0WaKBpzNgjUWjWm6d1JbjQugIR16aUX91o+7aYxIFqcdVD4Tz
 B5q4LcCV61WBAW516If1b+OAr2h3Ig60mD95gPxqjqNFReDtwMX6w=
X-Received: by 2002:a05:7300:d518:b0:30c:2432:7d7d with SMTP id
 5a478bee46e88-30c68de9503mr1227041eec.23.1782257131197; 
 Tue, 23 Jun 2026 16:25:31 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1ba635d8sm21263443eec.10.2026.06.23.16.25.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 16:25:30 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v4 5/7] test/bpf: check that JIT was generated
Date: Tue, 23 Jun 2026 16:23:16 -0700
Message-ID: <20260623232522.257208-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623232522.257208-1-stephen@networkplumber.org>
References: <20260608203322.1116296-1-stephen@networkplumber.org>
 <20260623232522.257208-1-stephen@networkplumber.org>
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

Avoid silently ignoring JIT failures. The test cases should
all succeed JIT compilation; if not it is a bug in the JIT
implementation and should be reported.

Introduce a configuration setting RTE_BPF_JIT_SUPPORTED
which is cleaner that adding ARCH specific #ifdef.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Marat Khalili <marat.khalili@huawei.com>
---
 app/test/test_bpf.c | 8 ++++++++
 lib/bpf/meson.build | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index b54e36910b..9adffcce64 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -3656,6 +3656,14 @@ run_test(const struct bpf_test *tst)
 				rv, strerror(rv));
 		}
 	}
+#ifdef RTE_BPF_JIT_SUPPORTED
+	else {
+		/* a JIT backend exists for this arch, so it must compile */
+		printf("%s@%d: %s: no JIT code generated;\n",
+			__func__, __LINE__, tst->name);
+		ret = -1;
+	}
+#endif
 
 	rte_bpf_destroy(bpf);
 	return ret;
diff --git a/lib/bpf/meson.build b/lib/bpf/meson.build
index 7e8a300e3f..04ede96689 100644
--- a/lib/bpf/meson.build
+++ b/lib/bpf/meson.build
@@ -27,8 +27,10 @@ sources = files(
 )
 
 if arch_subdir == 'x86' and dpdk_conf.get('RTE_ARCH_64')
+    dpdk_conf.set('RTE_BPF_JIT_SUPPORTED', 1)
     sources += files('bpf_jit_x86.c')
 elif dpdk_conf.has('RTE_ARCH_ARM64')
+    dpdk_conf.set('RTE_BPF_JIT_SUPPORTED', 1)
     sources += files('bpf_jit_arm64.c')
 endif
 
-- 
2.53.0

