Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD2FCDB47F
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 17:59:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 194F3406B7;
	Wed, 24 Jun 2026 19:58:36 +0200 (CEST)
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by mails.dpdk.org (Postfix) with ESMTP id 2641C40662
 for <dev@dpdk.org>; Wed, 24 Jun 2026 19:58:29 +0200 (CEST)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-1363fe80fe8so2727085c88.0
 for <dev@dpdk.org>; Wed, 24 Jun 2026 10:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782323908;
 x=1782928708; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iLB65ZoTawkQamiFXrg/et34AytmsISoxdNBm5UiFNQ=;
 b=cYwObAElMS3iaLo+QzV3YLPSaOlXo9HVvhXmFiJAXDFGtPk3At/JzukzOjxDq2ln99
 1fty4/mzXwkFtNy3fBPUQ1IuWuKRa8f1C3XpgteiqBGOF8sRlRDDxxbQIgPbsBNJJ64O
 V31FLaL0iirvw7/3fvvXHwA9JpIjLycGJJPOIRPhgcoP1blr3PO+xhfGX2bq9987n/jp
 W2xjC4bPV/5xaOXEvQEeifvHETsCE693I9ZkzNzge0FJgXVw2zqj1FJRrk8YnyEKc1pF
 j//vqFNfQNGNUNUR+Ql/PgMp2SGl5C58KqsvqmFf1cYxDQ6OVtyvpGo6Ugap0Z2PVLg3
 YA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782323908; x=1782928708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iLB65ZoTawkQamiFXrg/et34AytmsISoxdNBm5UiFNQ=;
 b=lfAIduhl3CLtK56RQbKASlQ2i29k6TXP1bfBLfiwuDlmmP9laQXr1zzAcWXhOBh54p
 wdRf7/MeKAQVk1RqN0/cC0IFRuKNPksHb8n7rDsX4L1YMCykp53uY+a/JKgddOepIfm/
 WGM40tZrNbZ9znPNrotuSOYdG1g23/pGEu7m7th83IV+eW82eDd51qjZihS7+M7azKDF
 D+eM/ZEJd14BSQQ3+aRRrd9TlclIYEwaSfN7jvGOec6JDQkaCYRmhjKCkSVw9NauMR1Y
 ANPWH4otMNsQoP4FI6b/Y8RgriXQaCGdvBNmX81YRKK8Hhpzr/5qdfWjmi1xJ6A7gb0+
 9Jhw==
X-Gm-Message-State: AOJu0YwN/9EK5JEJ5WO1xjhTi9H4zDFgw2YiGxgT5ytkH0Fxv23MjX0Z
 8yf7k1O24cxUMNjeshbgMW53daKZhzCS3CJw8qLkAr0Q+Qsvvw/mEVv032kI6uptu2aEtACQURR
 Zt1AX
X-Gm-Gg: AfdE7clmASq2C6hqe5xugjjGjtxpbBwD2+93S3AK6HykVY76PDO4/BUwjdHbaAN+nDh
 eb1VoAkpVCijZeaebxxFka0OPNgBk7SIOSY4Ez72+UQeVRtKHD18eNq6S+SxNAcMGRw2ZW5qrmK
 B+cebswNHSnvq4vE7a7QEhyAyY1ZduptOf+Lo0oejkE2uVaSLhHYhND4PwNi5wj0pFtT4rOlQs8
 xea9FdD1UMgByfWNiG74sBsMT3xaVHnAP8LY7gM00LJMXzHKm16E3DJZOJBxVxhrdc/CeIkxCUi
 5/ZvSA8MHYAXJV8GIyLqij9GnrLvQh8S8L81HiDRvH1Md2G81yH/Khot8Oi5wH4d2NhRx8399W3
 gB8i2Nt4PbJ3Yj+15FJoaFEGafK3cHH3lg0e7uCGjUgmamVkE5nmBKG3wh7g0Vs23AwNtN3DlyP
 fFSVjcba2Em8tf1CABWzVE/mIwrUI7cdy/HzZAMGXOsDmsOKvYlJI=
X-Received: by 2002:a05:7300:6d22:b0:2d8:7302:d3d with SMTP id
 5a478bee46e88-30c691f2d0fmr4229579eec.8.1782323907994; 
 Wed, 24 Jun 2026 10:58:27 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7cab08c2sm696325eec.29.2026.06.24.10.58.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 10:58:27 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v5 8/9] test/bpf: check that JIT was generated
Date: Wed, 24 Jun 2026 10:55:07 -0700
Message-ID: <20260624175815.673064-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624175815.673064-1-stephen@networkplumber.org>
References: <20260608203322.1116296-1-stephen@networkplumber.org>
 <20260624175815.673064-1-stephen@networkplumber.org>
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
which is cleaner than using an ARCH specific #ifdef.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Marat Khalili <marat.khalili@huawei.com>
---
 app/test/test_bpf.c | 8 ++++++++
 lib/bpf/meson.build | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index 0e5894a532..16a1004e51 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -3649,6 +3649,14 @@ run_test(const struct bpf_test *tst)
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

