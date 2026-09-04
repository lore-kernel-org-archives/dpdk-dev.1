Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03EBC624D3
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 19:17:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E16E042E44;
	Fri,  4 Sep 2026 21:17:15 +0200 (CEST)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTP id 2DC5142DD5
 for <dev@dpdk.org>; Fri,  4 Sep 2026 21:17:14 +0200 (CEST)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2ce98cb8165so15932685ad.1
 for <dev@dpdk.org>; Fri, 04 Sep 2026 12:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788549433;
 x=1789154233; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2Jg4y0L1UDzhyZfLwhaXMab41Qi1qIX/QmjE1+gT8hk=;
 b=otbs045bQQHnDe3Cr0gIyqeNB8Kol5y+Kkm+OAL70kl4fJVCtwLkzNZuiRqNhyiFmZ
 S2DchenXGFo0p4LHbtu0OdFhOgKgjrD5xlMHqiHVQRw822OyiiHmlzANSge46MNrVSNw
 6zqz62+fvWZyKA1Xy52XPPJvpSeTKj7kBiCTcuW7LzCHFVfyWRvoSSvk7+BqNJPImVo2
 BjjPjEdJv7ODjrrxSdOREUlUS3HAlvrexgP/Y8D4HvVjolxcI5bsU3NAFRIWpJZODVRt
 2m8EEXcGSpVewwO1LH0/SAxNkUuAc8q8qXfLqEIuaOv8G3GcEEooZ+d33pdpNP1R6eG8
 GDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788549433; x=1789154233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2Jg4y0L1UDzhyZfLwhaXMab41Qi1qIX/QmjE1+gT8hk=;
 b=FQKg3GQqlPdnVmsn1q2DTW0u8570AflAV1M1sJdwbjnqUPQAlzqhJpqD40s3h+8LQ7
 RSxFzUHLLVJfEerHTtvSwdnP7wIU5k4wYOq1Rkr8RyXjQg2+U2scqb/9exBMYRrGzuxw
 Qx9WGh3v8amzmQk4Oz3OXTppcIqf2oOZXmL290WzJFe73bAnlwchAYuz7Ts8z0tts3jT
 0bRxvfazYvYGg2L4kY04XrPmvQWLe4U/enNuVCAIZE6oZ3AbEwVJeOpQQt4uqwvjXa7D
 bQ+u07hVx+Kyxj1BwmtNoLlekMiN7Q3jc+jF2c/mEv3MxRwCnzY+Rk4F7oeCFMHnYVJg
 Y2yQ==
X-Gm-Message-State: AFuF++mnxLW/yNy4EekTuNAC50Inx68yCr9dmfc3GFw4XH6prDThEyiN
 oqTXfWuwvzYERRWa+BUrk03EYN7EDYvGqY2IidLfxaYlBUMWKTctx3lKyXDNqL0dQXSHN5EtG1l
 In06q
X-Gm-Gg: AYBFou3WqPF9hc5ZZZM8eWs5JSsYEO8XS3g0+q3I+/uiU2UAKjlzKWuOE0n5Jox7wMe
 Fqnia2cmD6/XzH4/i6qsBMWBV3FBqn1WBxlN+83loHiFRfPquTOR/WdqhqnB3e50atwEprxBIZy
 x9M1FFwhcRJ/vRFiV7kop8CdMkl+oCTtXUKvZaufL0UREIPmUmel7a1Y7naSr3/8KkniyQso0e6
 XltTlyhy5byMk53zs6rsjvKpwwquSmd+/7DZtpLsDlO6YOVamvhDF6ldmXCiY/J952lclzluGXy
 UUWk7c3MCyDsyJ9HF6uGdQm8tgfXCMHR01PtsAypPLHFDsOrJ32nHw473sn0ns2eitOWggz1dwr
 1ZbsYylJNJ3e/aSPsfp0/yw0/5jJc9Gd+2GauhmC4eoWEX2xU1ZMWhNmI6/E++xRei/g+pGnr4D
 RArrBeFC4NLjJ9//R7RYpfiY09V/6teHshV6GHNcSlFyHj6tVRspwhq8W4+joMe0m1cLmO5qs6u
 UuxfgF8o1d2irlT+fX19xOPbXM=
X-Received: by 2002:a17:903:32d1:b0:2db:18e7:e5db with SMTP id
 d9443c01a7336-2db18e7fa12mr55022525ad.12.1788549433155; 
 Fri, 04 Sep 2026 12:17:13 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db1499f07asm13335975ad.57.2026.09.04.12.17.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 12:17:12 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Gagandeep Singh <g.singh@nxp.com>, Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH 3/7] crypto/caam_jr: fix descriptor dump build
Date: Fri,  4 Sep 2026 12:12:38 -0700
Message-ID: <20260904191652.2399074-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904191652.2399074-1-stephen@networkplumber.org>
References: <20260904191652.2399074-1-stephen@networkplumber.org>
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

SEC_DUMP_DESC() grew a FILE * argument when the NXP drivers were
converted to fprintf(), but the only caller was never updated, so
building with RTE_LIBRTE_PMD_CAAM_JR_DEBUG failed with a macro
arity error.

Compiling the macro body for the first time then exposed two
further problems in it: the log format string ended in a newline,
which RTE_LOG_LINE() rejects, and descriptor pointers were cast to uint32_t,
truncating them on 64-bit builds.

Fixes: a8794e398279 ("drivers: use fprintf for debug dumps in NXP drivers")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/crypto/caam_jr/caam_jr.c      | 2 +-
 drivers/crypto/caam_jr/caam_jr_desc.h | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/caam_jr/caam_jr.c b/drivers/crypto/caam_jr/caam_jr.c
index a57dc56b80..104ce52d11 100644
--- a/drivers/crypto/caam_jr/caam_jr.c
+++ b/drivers/crypto/caam_jr/caam_jr.c
@@ -462,7 +462,7 @@ caam_jr_prep_cdb(struct caam_jr_session *ses)
 	}
 
 #if CAAM_JR_DBG
-	SEC_DUMP_DESC(cdb->sh_desc);
+	SEC_DUMP_DESC(cdb->sh_desc, stdout);
 #endif
 
 	cdb->sh_hdr.hi.field.idlen = shared_desc_len;
diff --git a/drivers/crypto/caam_jr/caam_jr_desc.h b/drivers/crypto/caam_jr/caam_jr_desc.h
index eb4e68578a..845facec26 100644
--- a/drivers/crypto/caam_jr/caam_jr_desc.h
+++ b/drivers/crypto/caam_jr/caam_jr_desc.h
@@ -112,12 +112,12 @@
 /* Helper macro for dumping the hex representation of a descriptor */
 #define SEC_DUMP_DESC(descriptor, f) {					\
 	int __i;							\
-	CAAM_JR_INFO("Des@ 0x%08x\n", (uint32_t)((uint32_t *)(descriptor)));\
+	CAAM_JR_INFO("Des@ %p", (const void *)(descriptor));		\
 	for (__i = 0;						\
 		__i < SEC_GET_DESC_LEN(descriptor);			\
 		__i++) {						\
-		fprintf(f, "0x%08x: 0x%08x\n",			\
-			(uint32_t)(((uint32_t *)(descriptor)) + __i),	\
+		fprintf(f, "%p: 0x%08x\n",			\
+			(const void *)(((uint32_t *)(descriptor)) + __i), \
 			*(((uint32_t *)(descriptor)) + __i));		\
 	}								\
 }
-- 
2.53.0

