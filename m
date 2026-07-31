Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2CFC54F54
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jul 2026 05:02:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 461FD40E27;
	Fri, 31 Jul 2026 07:00:27 +0200 (CEST)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by mails.dpdk.org (Postfix) with ESMTP id B0B3440E13
 for <dev@dpdk.org>; Fri, 31 Jul 2026 07:00:16 +0200 (CEST)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-8486672f03cso753637b3a.0
 for <dev@dpdk.org>; Thu, 30 Jul 2026 22:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785474016;
 x=1786078816; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QNUY6t5JrkqHM+hrcejEwEr3mqF78kdD25AyR8jVpCE=;
 b=z1TTMeH+KMFOiQbJUbJfZ+E4U4VFzUQrOCDjsog2K8bUuZRm7ExWBqwKeR03FYugny
 PZ716D7hTe8jbk9XW4Ak68SlvZZ7Pw4ULcH/wOPrRGSL5rJ6a+/KTwYhQmusE/sCZC0v
 h/2/G0vjFyGZ2cZjUcS3L8EHz93J9lg9hTVtm/q6y77SIO3+YOBkLdhBVcYj/icgoeuE
 TNI+JCQTQpqmGZV6f+isfHDhA3jheI+DXIfE+8a8zS82r41XiH1mjS3BPAmrLjthAWSm
 1tSQsVTt/fGF5VLXITwcVJpQ/1u5qU7GlkqIXfnsoBA5EnqFMIS5A1tqGzBMsOU8MESi
 XF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785474016; x=1786078816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QNUY6t5JrkqHM+hrcejEwEr3mqF78kdD25AyR8jVpCE=;
 b=TXDVtwGtIM7pkMQat5sM/rm66BWIFlW60aCnDEoU8wJiY6dy4jAW8wyFGNxHS7i86h
 sX0JhmPApDrJOv6pimkl5yZ6T+og3+s7oGVJ5x+EqjGtUuujfFUo10pljOet1xaydWdY
 74jfHBZmSEv3EiwrKMi9/b9bblmAd6EU0xjxv6g4sYebCpzCYUS372VUZordaQzqdhTg
 +ZYm008Xtl6bmazgD3bPqj2Q9fDGDHl/OH677hEYRGQQoRpeMTC82tlFe8ByfqRSr/JB
 ek5O2pRqj4meOd8kCmuDXtrOjRXQbdhtlNOVOCsRbYgKVjOLncTSVmbtHrNQewRj+rVm
 weSw==
X-Gm-Message-State: AOJu0YzGe/hAvLjWdWwZGkAmIVD7JE3bz2jQP44N7AHeFVeYODOrUNDd
 ph/vPEn/hgBtXok/OwWFU/itVKzCaTFvz8a2uFx6zADMO491neOmLxKhwqi4jxi7BaT7UbDcu+h
 s0J8n
X-Gm-Gg: AR+sD12F9wQSd/MTflh8bpSfOOep1IFb/aTWZf0Wcxa7zFQ7w6mBMjkR8yq9zBU7scV
 Sd4derQKjIc1sPbiqI+8uESpyRINx1dy3ap/iYbx2y1JzenRLAHYYi2pfVFiEbIvcnOpY9Sf5zn
 TU2EBo1UNPU5VE/16wsatiZXGyc5zliqnXgY7GsGrE71GpYra+W3rTRR0PlA/J1DOR0+QmSWrw0
 pAqjTE9fX9EaHOGbJNNo7fj1yhlvb5iWYDKqMeihMBjDbPOXf38/WrMuh7qOhKS/ZUhKwn8eUUM
 BGe0nI6T08tSOaBmlrcRbxGiJc8ulbjXbgVPH+lR0w5/kbbJKv2YddKZ/T+cWWpeMzZsUVBrxEd
 EMptoUR/3Ga8cCxGWPBpUCwm5rzu+rOCGmsd8WxUV26ZVXrCAfP6cLatwHt6XU/nGcQUxiiDl8a
 nIJctrOcI5AeNnR4558aSsCgt9VxpSJ2r8enVA5K1E1hBH948Rpb6gogUMM8GHb9KnzTql5+tVA
 BbAEHiq3qwDYjwERwe1pOY4fiIXiSHqmpSL/no=
X-Received: by 2002:a05:6a20:72a3:b0:3bf:6222:2e7e with SMTP id
 adf61e73a8af0-3c91b095909mr517721637.4.1785474015730; 
 Thu, 30 Jul 2026 22:00:15 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153e06f0f9sm823245eec.23.2026.07.30.22.00.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 22:00:15 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v6 23/24] test/atomic: suppress deprecation warnings for
 legacy APIs
Date: Thu, 30 Jul 2026 21:58:01 -0700
Message-ID: <20260731045948.769926-24-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731045948.769926-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260731045948.769926-1-stephen@networkplumber.org>
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

The rte_atomicNN_* APIs are now marked __rte_deprecated.
Wrap the whole file with __rte_diagnostic_push / pop and a
GCC pragma -Wdeprecated-declarations.

In future, when the APIs are removed this test collapses to just the
128-bit compare-and-swap case and the suppression goes with it.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_atomic.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/app/test/test_atomic.c b/app/test/test_atomic.c
index 2a4531b833..f32a1aeff4 100644
--- a/app/test/test_atomic.c
+++ b/app/test/test_atomic.c
@@ -100,6 +100,15 @@
  *   - At the end of the test, the number of corrupted tokens must be 0.
  */
 
+/*
+ * The rte_atomicNN_* APIs exercised below are deprecated in favour of C11 atomics.
+ * Suppress the deprecation warnings for the whole file;
+ * when the APIs are removed this test collapses to the 128-bit
+ * compare-and-swap case and the suppression goes with it.
+ */
+__rte_diagnostic_push
+_Pragma("GCC diagnostic ignored \"-Wdeprecated-declarations\"")
+
 #define NUM_ATOMIC_TYPES 3
 
 #define N_BASE 1000000u
@@ -645,4 +654,7 @@ test_atomic(void)
 	return 0;
 }
 REGISTER_FAST_TEST(atomic_autotest, NOHUGE_SKIP, ASAN_OK, test_atomic);
+
+__rte_diagnostic_pop
+
 #endif /* RTE_TOOLCHAIN_MSVC */
-- 
2.53.0

