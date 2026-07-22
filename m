Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC4AC4453A
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Jul 2026 18:34:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 50DC3409FA;
	Wed, 22 Jul 2026 20:34:07 +0200 (CEST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id A3650406B7
 for <dev@dpdk.org>; Wed, 22 Jul 2026 20:34:03 +0200 (CEST)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2ceaf8a1265so130624165ad.2
 for <dev@dpdk.org>; Wed, 22 Jul 2026 11:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784745243;
 x=1785350043; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XnHmx13AcotwC3vofcdVOfjck3w3RIovdD8N9GEKchk=;
 b=jgY5H+1NtaSkNIRtwfy7Sdhxj26y+s1nVVVwKe2uK6qezhk6hstSehNuhJ/ZxS67im
 Fz+XIyQdl+pwspvl8NrRQiZ6dWuIilrW5riTP6vBEV1Xg62jPxvfqgizumgJNJEpYhCw
 zWED24p3A20hTeSyLcUFsxf/UMe4h4DYUD+kK4pfaw14v5Fdr9KQnpDvlevSRGqMdenG
 J3TAmwvDsoYi//mdfD9NizXoisRl4vO93FWLK9qzr3Hw33pkyfvlK2qL0Z+vRSCHsX7r
 miwV9DxX4A0YOy4YsuyqU/mNcwfn7MYgZp1ujNmdrs4akAaf8YmIVZEqD2+5/rgQtoWW
 R/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784745243; x=1785350043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XnHmx13AcotwC3vofcdVOfjck3w3RIovdD8N9GEKchk=;
 b=PRowS8ZfDIBQM5aVV4+dialBzMy66e6ZTov8bLsKu4LhOCNBYWlngvoHPMckytzZKO
 9c1oRPeKNz18SavNWikdfMEms5vm7Tkc/MBty77lSOkytX1zQ92lRLwTryld05j4AXeF
 LcD3sC1VdI04bubHpiVtbTGnEaBIbO3rj1zrBXln+PWQ13ijHLl3IXnQ6oXM6QwWGJkF
 r77+cktutFehHXWMAFoiCeYHZB454hAH6x/9Nn8SNHZB353ykzToW5Le7ooBvor99sE/
 nNxwIq4FaAWHlBv9GaGzobQKcbhhyt+1HkIi39nJDYYXs9AuzYQPUEv6YTTFSU/LFZu1
 8d8Q==
X-Gm-Message-State: AOJu0YxIIddAXsPCiV9DIT2Z8bIPw5Kckz20cIR1id+RYyb5h7M4Db9Z
 kMAQxHOKin4I2AuMavgEGJbECCAfCL/a3mHG5c5QWtcICzVbLrmx4Hjw8pXux6m0imOFAKnbztl
 nr3Qe
X-Gm-Gg: AR+sD12vVHxC/FFAsUlKmdpUNAmgNTrXJJ/0RLVKk8vVkOhAd7orzL695Jkse04+1j7
 RrE0Q5Il8hwE36lkA4U10cCox+2X8tfOXRksJV0BlB2U88mSYj9T0HHfoZ+A5UTbl1ljC1Y2aya
 oKtCWkIjFx2WaVK5fEFfxRmlA2hLio26z4s6cSzlhClvvQCsfiTDlz3HwaUVYTvTrWSSeH7oNt6
 mfrBlVR2Udv5u1Gb7+itco/EWu0hivyXXAg5pDtNOOhbo66G7l/XeS2l+kWkDJv72H3Lh/Fqtwr
 RJpFYK2P+zMjb8MoYAZzJqloApD9EhLZNxCDoRxPadTTRw0XmesSoXBdExIST6fqLy52dZmfWH5
 Tq75U0tlmxm6LjDER19UTNvtKDZx6ugQy7aNcU6kv2VednkXSBMtUuK59/0ZE1gND2xTHcBlWlw
 ziOo2Lci0vsGpEsTrIJIgxutQ35z/fAXwmNnVSDdqW
X-Received: by 2002:a17:902:f60c:b0:2ce:6d4a:5b8a with SMTP id
 d9443c01a7336-2cfa71ab5b8mr286945ad.38.1784745242738; 
 Wed, 22 Jul 2026 11:34:02 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e1c7ff4sm12227744eec.27.2026.07.22.11.34.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 11:34:02 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v7 08/10] test/bpf: check that JIT was generated
Date: Wed, 22 Jul 2026 09:05:20 -0700
Message-ID: <20260722183351.633025-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722183351.633025-1-stephen@networkplumber.org>
References: <0260608203322.1116296-1-stephen@networkplumber.org>
 <20260722183351.633025-1-stephen@networkplumber.org>
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
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
 app/test/test_bpf.c | 8 ++++++++
 lib/bpf/meson.build | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index 413d47357f..184438a549 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -3748,6 +3748,14 @@ run_test(const struct bpf_test *tst)
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
index b74a5c2321..74cff1eaed 100644
--- a/lib/bpf/meson.build
+++ b/lib/bpf/meson.build
@@ -29,8 +29,10 @@ sources = files(
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

