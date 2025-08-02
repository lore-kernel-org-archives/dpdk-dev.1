Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDBDC87FD2
	for <dpdk-dev@archiver.kernel.org>; Sat,  2 Aug 2025 16:01:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7881240156;
	Sat,  2 Aug 2025 18:01:26 +0200 (CEST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id 2B7F140041
 for <dev@dpdk.org>; Sat,  2 Aug 2025 18:01:25 +0200 (CEST)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4538bc52a8dso18333725e9.2
 for <dev@dpdk.org>; Sat, 02 Aug 2025 09:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754150484;
 x=1754755284; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jDPjsMYXD3iv1XD8wI9ThJGVTGEyq5Lj4WtNIKd855w=;
 b=vACEfTgrQsyCA9CVTy19EyJhBYSgFyKPQZKSM0733aNoXTmyUx34HAmL+H52LOfzrw
 wXNfk5RuYbddTcmVff9WEtXix6kHqReN17qTAtiIMuTVCzsdzP/gb+HJpoFWcSP9P5ih
 G3lDbtSkeT8HILOVwEwppRXoN+gwZZotzbFcZiGy/ArW1PRdXw0qlade13s0Bl6qOXZL
 7pqncCiSKgxA4WUHvH+cK5wrFFY9QErF10x/sniIQ4j+N5pQ4CCgFgNhmu1Dc1YwHZ4d
 qyFQNnAfZnY0kGaFkNzy7UqceIWYSiWVlCR28V+M4mFa+RdU3GjkuSQ/gJu2wTcMWZqZ
 e4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754150484; x=1754755284;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jDPjsMYXD3iv1XD8wI9ThJGVTGEyq5Lj4WtNIKd855w=;
 b=ZRQAzERZtWDAA9XoxKV57L83hBG9S/bGKlWekfkgP92B1U4CW5XeoKVloJquDfJ8Wb
 gCGTe/5iwoxnTke9KwQNZ/UIWttjMq+g+Q7VdV40TaTVRdZ6xN2Ow6Q6O5JLamVWQCqD
 GZf2tHnTfINzD7jgPCZa3M3qEkEKQ7ivFlEUJSBmGoJOHph60MsoZm8aS/72Bw95v/2K
 qPnRw/uMQwyKOigdbwKIZgpDnJWyQ2U/yYHSKkb/yxdOZmhZIt/PZOuqJGvwVulahP+U
 IEWAuujZEG9z8AD7IZcrbDSYbwZaygrSghmm0M5U+22m0ISylCWX06lgdnuVCtD9CWo3
 tTsQ==
X-Gm-Message-State: AOJu0YxlJBafSr1Vrhzwx3B6bWX4+3Yd6wcoXa4m0Iz6liX0o0DSZ2ku
 ffdep7Rpe0MF6O8eZc2CKLZeYBvqRcRt3C6dz+A9TTpOwiZTuHJCVaauTTIK3f3nN5DRF0dw09S
 6LgqVrCk=
X-Gm-Gg: ASbGncudG8YznZ5kMEJcmjfCqFIuYkQAgpD8iCsP32app7UwCo3hAuYv9ES/3yq8uEt
 afhYYaDT8tfdllY+qy8QGOrJtIRfZVxgyrqBgzBUaG0KBhdF3SACYO44adc4S0JPd+X6g5LMVJp
 u+VfYJosd3m/OnIEXxCwFb9JCX9G6VLFlmncopPHDUvepdwG5yjqjoBrF8BdZCsGpVsRjdZ+4jA
 wFKiCdGherPVW03L1BdJKfadmo5JFQn3tJMCNXE+cJNBtxmoHPtlUVKxBHShxOyrSaedLjefmbU
 T+xdxXJPsKfzCt5J7jDpJHY16wZ8I9ooTlpE1yYaliPTxFRyOjHAPKP8S7SWZp/hg5HWS1smmzS
 n+ejnRxonNACnEuzZLOqnMhMndXABgdz0pz7laDWe3fAZVhojrha68dv6HmylxCJIG6eJ+lWM
X-Google-Smtp-Source: AGHT+IFsns9nM5Y8pveW8OEghQRsDHyndSzAkiObU6j3IEIb84c3dB40ivH/Zg2hyAjhPnSQQt8+uA==
X-Received: by 2002:a05:600c:4fc1:b0:456:22f0:d9ca with SMTP id
 5b1f17b1804b1-458b6b3dd7bmr22688405e9.26.1754150484430; 
 Sat, 02 Aug 2025 09:01:24 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458b403a151sm43669925e9.32.2025.08.02.09.01.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 09:01:23 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH] bpf: add allocation annotations to functions
Date: Sat,  2 Aug 2025 09:01:16 -0700
Message-ID: <20250802160117.30534-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
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

In commit 80da7efbb4c4 ("eal: annotate allocation functions")
helper macros were added to provide compiler information to
detect misuse of alloc/free combinations. This covered many
of the functions in DPDK but missed the case of data allocated
by BPF load functions.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/bpf/rte_bpf.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/lib/bpf/rte_bpf.h b/lib/bpf/rte_bpf.h
index 80ebb0210f..309d84bc51 100644
--- a/lib/bpf/rte_bpf.h
+++ b/lib/bpf/rte_bpf.h
@@ -18,6 +18,7 @@
 
 #include <rte_common.h>
 #include <rte_mbuf.h>
+#include <rte_malloc.h>
 #include <bpf_def.h>
 
 #ifdef __cplusplus
@@ -128,7 +129,8 @@ rte_bpf_destroy(struct rte_bpf *bpf);
  *   - ENOMEM - can't reserve enough memory
  */
 struct rte_bpf *
-rte_bpf_load(const struct rte_bpf_prm *prm);
+rte_bpf_load(const struct rte_bpf_prm *prm)
+	__rte_malloc __rte_dealloc(rte_bpf_destroy, 1);
 
 /**
  * Create a new eBPF execution context and load BPF code from given ELF
@@ -152,7 +154,9 @@ rte_bpf_load(const struct rte_bpf_prm *prm);
  */
 struct rte_bpf *
 rte_bpf_elf_load(const struct rte_bpf_prm *prm, const char *fname,
-		const char *sname);
+		const char *sname)
+	__rte_malloc __rte_dealloc(rte_bpf_destroy, 1);
+
 /**
  * Execute given BPF bytecode.
  *
@@ -228,7 +232,8 @@ struct bpf_program;
  *   - ENOTSUP - operation not supported
  */
 struct rte_bpf_prm *
-rte_bpf_convert(const struct bpf_program *prog);
+rte_bpf_convert(const struct bpf_program *prog)
+	__rte_malloc __rte_dealloc_free;
 
 #ifdef __cplusplus
 }
-- 
2.47.2

