Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35ECEC61DC4
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 21:43:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84A0D406B4;
	Thu, 27 Aug 2026 23:43:19 +0200 (CEST)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id D4A9040689
 for <dev@dpdk.org>; Thu, 27 Aug 2026 23:43:18 +0200 (CEST)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2d53197d8b5so2901475ad.3
 for <dev@dpdk.org>; Thu, 27 Aug 2026 14:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787866998;
 x=1788471798; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XnHmx13AcotwC3vofcdVOfjck3w3RIovdD8N9GEKchk=;
 b=QQr1KWMYB+bdPkMVCSzNva85CZ85IyzzHW5OeGHbammtpXwHNjTpRV7tH6XOe8F8PB
 mK7+PWTsTQcetpPkbxVPXPkkF9tuNSKtqqcZV2XkzKsSTDVeDnxZQH/aevbqBXwDFNP6
 Uxw5DjHvGG1z4gMIyIQtx9OcvK/L/UEJJGyeHPVzxbvI2UQz1CmBglNNRZrYbxqZlVIZ
 kQ9SybERvMKzjtecc2VprKlDnLq79oSrGvdso3JhIL/PBTw17OQxjJDR6uuv9qv3TMBD
 QEvAzf7GRD4nuDY3BDbTjKGAWSLfpkV8DX+mNisDdt6Z6dxZLtNMdhoTjXLZGq2f/ZDI
 JuZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787866998; x=1788471798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XnHmx13AcotwC3vofcdVOfjck3w3RIovdD8N9GEKchk=;
 b=ltuF+zizKVKu0fXDjCuzBQ8HGDv/bw3GZCViApHt2ykIfM1ilOTCZmenJ+NHT3LsRc
 wavr52XdDTI55OOW2/TzVQI7DncMMpX9Rlh2ZNbqHQ/cuTEw0BJ1x4sp77FLy9LUq/Fm
 nz09H6jB6tMY/Ec8zdsz1qfFtf8NyGNvRiHYixlnLiiPaBFKTHuLK4mk0rvToc6njYZi
 RfMWSFYdn3JdeOHrmTYgvlDIj/T8Ov1tiJjtbioK2bmGeVr+G6BlPHU7MMQHVMU3/tfe
 e4aLAjJ9rl+12wNI1eDH3nugvVMCdFlgA8CuysB0ls4044b1PrQfD/ClO2dQam5ayBj8
 Pv3Q==
X-Gm-Message-State: AFuF++nr9JO/6X8Uomqkr5z65QjgqyPG5Oh8UHSZl+QrRvgfZWJ9/J8q
 djgLUnHiTigJhOZBCPcCs2BkkFcio9BD1Pxr804ujdsJCFTPx9po0OE2azN+oEsgNFAL9gT0Ppa
 BrDCQ
X-Gm-Gg: AR+sD131vsj24eRBQcbygKRI1AyeRZJ8AgVwC9PHHYss+NQRhM4LsHocVn7h3/v7LBb
 4+WKFpbPlJ+GaC1fYVuEAGZ0qOWSU5MiIy5FyDeJaSv6L/Vvhgf2c7SkSRise+jPj4xGKSdIaSg
 UpZhCQU+EdTkHlFDHafk0iEK3S4Kk40y70amQQmU8h+DDFeBFqNTplLc6WMnpkOjmeM8aB4Z819
 A27edcKXY0vic+8MZOrZGkXi7jrStRZ6h8VrBJHKzbhBMqKEJPoxSNV6gD7u1HzdU5pNBrmwDBz
 dnXpB1Zix5ZxTQoxhhKnXTq/o5hfHV7P5MSudc1s5iIyzke012SQDd86dI2ysEEk6/ZCOrRVJTi
 EienPHxZWI0CczvhykBSe9YL6txX+vIDeYK2i5Oqn+ZiRMprC5j1J8hLEfefcYIVPdyyQlaVoNR
 hfn+RcNfRwYSdOlgJaY5CMMNcOBUIOUpNKF7Ll47/WJ8yOc2O89jBJwM1F5xuTu4AfQ4yJ1RmA0
 Cn/XUMpXwNUzKhRx9LS6y3j/S4=
X-Received: by 2002:a17:903:32c2:b0:2d6:fb95:59f0 with SMTP id
 d9443c01a7336-2d74dc6f50dmr33096995ad.3.1787866998040; 
 Thu, 27 Aug 2026 14:43:18 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3285d1075ddsm9642445eec.29.2026.08.27.14.43.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 14:43:17 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v8 08/10] test/bpf: check that JIT was generated
Date: Thu, 27 Aug 2026 14:41:47 -0700
Message-ID: <20260827214236.1415047-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260827214236.1415047-1-stephen@networkplumber.org>
References: <0260608203322.1116296-1-stephen@networkplumber.org>
 <20260827214236.1415047-1-stephen@networkplumber.org>
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

