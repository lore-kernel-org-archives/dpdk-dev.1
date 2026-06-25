Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57507CDE000
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 17:33:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 779F64068A;
	Thu, 25 Jun 2026 19:32:52 +0200 (CEST)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by mails.dpdk.org (Postfix) with ESMTP id D5E7C4065F
 for <dev@dpdk.org>; Thu, 25 Jun 2026 19:32:43 +0200 (CEST)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-1363fe80fe8so323662c88.0
 for <dev@dpdk.org>; Thu, 25 Jun 2026 10:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782408763;
 x=1783013563; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iLB65ZoTawkQamiFXrg/et34AytmsISoxdNBm5UiFNQ=;
 b=CmRHS5ddyZ/7U4stdnHdsUjkKGG+9TK5nNNSGyBOH/4AfMN4g2VmmdPwTaT6eAs/9V
 eQihFA9yIhipmEQNBzHH1S97Jjq62fh6VnrmesHMbHM0Dx1spOizAKNxxAYIFPrYDiWE
 YG+OUKrGdiAGmzfL1vygRyd6nhbS8CSpxpV3wFUqZvzHWROtOpLBSZUYR/33YxeLOwXH
 QzIFaWXFSK+tM7EgDcEwUIjtQ6tHlG+AXUz3SGilccil3/8c3AMWUJOX1kc01TnSOjmy
 zlLxnb8ItkEnYLWZdaW6fCplgG3DFaAxtnCMlCchqmkNtkxLd+9prxbiMahKTJ93uvjj
 JBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782408763; x=1783013563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iLB65ZoTawkQamiFXrg/et34AytmsISoxdNBm5UiFNQ=;
 b=XODLKxljHqqNAL/HhbelaUWpVG4IjPxpl+QLv1374YaMWjCHA36gPVgCYjw7m6oux4
 WwlizxOu0F1PkTv0PQwhp4xHeRteZ/jVX6OQaj/1Jx/C5u4GRSuYS3DvdLAnl7tFgaXT
 Z5jxXgKZ8ltRytgZm8/J5RNr4N+PMKclFgG6+9/NBMESyhuiT534kws94KIuX0m/WthS
 h7PN5itWWXx74AnEo66MvvAUX+ySBzTRvP1I2DpWPBtzqVhwzlsGCQ63PYnFFSjIwQnb
 AtuM00YFGqCya9A+KEE9dt3QO/lVD6ZLS58UPzQv3w3U1WN0WPpxlvihq5HBDS/TN77v
 9ZdQ==
X-Gm-Message-State: AOJu0YzwIfBXPdELvmLRYw0mtJDgglLXe0XIOdoOPUPXI3Zx+EQev7Cb
 QAhxsRQV3AdKow9Hj/pWPlyr9oG+Lp3ZCVkcCEGxiuLZ29o3xjuciR7cWwpURylObzkcE3kvi86
 hNG1Y
X-Gm-Gg: AfdE7ck6oYJ7A4XluE7zRFfxrNHr8p8j3zR5IQCkzcxGGYSgSyZvhBIaQrbra+adz+y
 gP+SeKo44H6Ad2ztDYFrz7DqaDxRBZKIpGXUR0AvBTun8tCDQgFrqpwxqcbRvQVhDC8lyIgaOMO
 SgXBBhsIGx0WGV7VwAhzn37vyZ9IDEm0f+REFQc51RbNCtH9uCnUh54vTjP2mSu2NvX+pwolrv7
 tkV4wNBUKwbXm6R8fovnVq+/SFLebMZJ1kHWqJme0NbJ4hGTRyyfhZ97lZKEuHUituvdgXm3+G2
 7CDu9ZgJNaSGYuVKKbq7GuXhxcLIkJhT2bHdq0o4pN7x1Orv36tgoQiK/a1MDGoZFDrJaTZPfhx
 gojU4hik3SKvQZSz9LljhQjdPg4290TJgkjy2b9+/jp5y6SbH8UoXdH9K1Jp7iAChs5QhKeyh73
 ctbrgisgDg7aiO0epDbd84Fbf/5W4O1URDgF/1Vq/gAluOj4yDeuo=
X-Received: by 2002:a05:7022:62a6:b0:138:22f:9a2c with SMTP id
 a92af1059eb24-139db9e5923mr2961771c88.5.1782408762733; 
 Thu, 25 Jun 2026 10:32:42 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8f6acf9sm10218165c88.6.2026.06.25.10.32.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 10:32:42 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v6 8/9] test/bpf: check that JIT was generated
Date: Thu, 25 Jun 2026 10:30:18 -0700
Message-ID: <20260625173231.216074-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260625173231.216074-1-stephen@networkplumber.org>
References: <20260608203322.1116296-1-stephen@networkplumber.org>
 <20260625173231.216074-1-stephen@networkplumber.org>
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

