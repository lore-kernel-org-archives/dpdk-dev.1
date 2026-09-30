Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD96CA5FC5
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:48:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6133D42F99;
	Thu,  1 Oct 2026 00:44:33 +0200 (CEST)
Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com
 [74.125.228.42]) by mails.dpdk.org (Postfix) with ESMTP id D14B942F81
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:44:30 +0200 (CEST)
Received: by mail-pz2-f42.google.com with SMTP id
 41be03b00d2f7-cc797656e36so2027058a12.3
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808270;
 x=1791413070; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8pg9kEP/PlSLwqZBqgULj4i9AdBbVQ8PpmHj052Vtpk=;
 b=0FVK9cqVZ/uoa2Daqv60NZYA8ELyRnoGMp+M52WiwaBIgkQEcywCsFtdf1WIs27IzV
 eNW/p9fVsDtCvBE+dZR2nQsijMQqWVuFLL5jgQsWsgxJMtZlgSt16+5mMp9uwRpQIye8
 TFxt92uUZOEKVLJ7EKRoHm+mAKFJ+tDfligRzJlS3AQfMbjQAaz37WHhScm5a/bVEmEf
 wYgwLTgcdb16CR1Q6QVdcZX5n+MjHJw5Gi5MbzO74GZtvG6BniLawdjaXti1uup65E15
 wZf2LQ7KDJxHr08qNQv5P7AR9WwT5GvIIBFg+0Rqib4DY3EzN+X+jxanDGZYAYXnN7vt
 CoMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808270; x=1791413070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8pg9kEP/PlSLwqZBqgULj4i9AdBbVQ8PpmHj052Vtpk=;
 b=Tao0OtXUM5q+0dAxLI5dfZPEMFSlbsh/sYX+1s4f4M9fgNPs4B+0SAQ8b0ez7M4f1o
 0t+qCWOa85KrgKr74unKvDKnXcds7zXdVdwB1/8/UXikfb6OjaFtZ9HL2zGmi6SyO6Cu
 7SQ+4xRBpKKEkknb5A52leewnpuB2LDhinbaGuVKYXXmU5naaMjQMaTH4YNsL7mt3uoY
 W3+jrn4ZHPds5UNvARimyZFHkdRvsT4oFtkyfOEHuZDkLEJmsvdO1LuIKRZqYgkPS4Sf
 AFxXDdEKPGcPiaEnOatKVc3f9BJoadmD5HKGgS0KrgC53re9y6Th3skIDvIvXSj0EGiO
 6vvg==
X-Gm-Message-State: AFq9FYL9aHspOH8hT+OJ9gBPVjA83tPRdbFYtrA6OmoRx+ykqv93ufsi
 1nH6YjljOJndjedTPv2HVMM+D4fxE/bY/onJBjjzm2Aq/vXr3/hyZoPs32ChikPwxCnKy0S5HOv
 pu5f2iJk=
X-Gm-Gg: AYBFou2x/qGeG4kq4r5KLuZEhHu/FzQmMVFChHGzwTIHbm01Rk923ywcuqya4G69dfj
 0yYnJQ2LSmwxKYOmLyEvP5+CoLOAjokZ51N33mPzcwriKuVKPzzAV8jxtI1eqlxOkYz7kzsNPku
 EWXhp6NiceDPDrfBB5K8YqdysTCucI8Yrw31lXZFmoGpVuAMMz6NA2bNdMD+d3F6LvRq9/zKeo9
 m4Scp9e4cx5av84ouA0+SFEnSzP3zXQaOk7aaCXEZQcI9cZXTHmdJAcq/DWuXmLAu9IGOsRGNCx
 b8g3qqSe1yYaBqjpOK66apU2WXxQNgQsZVnR5CTlKGoqe5drvWgj7nmkBturBLoYuTqxwHV1gxY
 RaYK+MbuSLXvUZ7YFRKoeRJ2TccpO+F8cAd4HKyM1rr5wlISzZ7fz9VDL2zglcEN222Q9V/09au
 nuhaiHvlYfsQOenx6Ys4JgMq6OocrFWpkhFqnjENMXGd4Il0A1kHYd8KbSZnodt0lUC1ZoZ33wW
 ZFadK1zjIGZvXNw7e7/O9iqYUaZs2MHo723n9Q=
X-Received: by 2002:a17:903:2303:b0:2df:98a2:a2e2 with SMTP id
 d9443c01a7336-2e2e4b48e3fmr21554485ad.30.1790808269903; 
 Wed, 30 Sep 2026 15:44:29 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:44:29 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gagandeep Singh <g.singh@nxp.com>, Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH v3 43/65] drivers/crypto: use kvargs numeric helpers
Date: Wed, 30 Sep 2026 15:41:01 -0700
Message-ID: <20260930224340.58580-44-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930224340.58580-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260930224340.58580-1-stephen@networkplumber.org>
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

The dump mode handlers use atoi(), which cannot report an error, so a
malformed value is silently taken as zero, which disables dumping
entirely rather than being rejected.

Out of range values keep being clamped to the full dump level, as
before.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c | 15 ++++++++++++---
 drivers/crypto/dpaa_sec/dpaa_sec.c          | 17 +++++++++++++----
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
index 3d980d096f..93e92af6a7 100644
--- a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
+++ b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
@@ -4342,13 +4342,22 @@ check_devargs_handler(const char *key, const char *value,
 	if (!strcmp(key, "drv_strict_order")) {
 		priv->en_loose_ordered = false;
 	} else if (!strcmp(key, "drv_dump_mode")) {
-		dpaa2_sec_dp_dump = atoi(value);
-		if (dpaa2_sec_dp_dump > DPAA2_SEC_DP_FULL_DUMP) {
+		uint64_t val;
+
+		if (rte_kvargs_to_uint(value, 0, UINT8_MAX, &val) < 0) {
+			DPAA2_SEC_WARN("WARN: invalid value \"%s\" for \"%s\"",
+				       value, key);
+			return -EINVAL;
+		}
+
+		if (val > DPAA2_SEC_DP_FULL_DUMP) {
 			DPAA2_SEC_WARN("WARN: DPAA2_SEC_DP_DUMP_LEVEL is not "
 				      "supported, changing to FULL error"
 				      " prints");
-			dpaa2_sec_dp_dump = DPAA2_SEC_DP_FULL_DUMP;
+			val = DPAA2_SEC_DP_FULL_DUMP;
 		}
+
+		dpaa2_sec_dp_dump = val;
 	} else
 		return -1;
 
diff --git a/drivers/crypto/dpaa_sec/dpaa_sec.c b/drivers/crypto/dpaa_sec/dpaa_sec.c
index c53ee70853..3feb752bcd 100644
--- a/drivers/crypto/dpaa_sec/dpaa_sec.c
+++ b/drivers/crypto/dpaa_sec/dpaa_sec.c
@@ -3625,16 +3625,25 @@ dpaa_sec_uninit(struct rte_cryptodev *dev)
 }
 
 static int
-check_devargs_handler(__rte_unused const char *key, const char *value,
+check_devargs_handler(const char *key, const char *value,
 		      __rte_unused void *opaque)
 {
-	dpaa_sec_dp_dump = atoi(value);
-	if (dpaa_sec_dp_dump > DPAA_SEC_DP_FULL_DUMP) {
+	uint64_t val;
+
+	if (rte_kvargs_to_uint(value, 0, UINT8_MAX, &val) < 0) {
+		DPAA_SEC_WARN("WARN: invalid value \"%s\" for \"%s\"",
+			      value, key);
+		return -EINVAL;
+	}
+
+	if (val > DPAA_SEC_DP_FULL_DUMP) {
 		DPAA_SEC_WARN("WARN: DPAA_SEC_DP_DUMP_LEVEL is not "
 			      "supported, changing to FULL error prints");
-		dpaa_sec_dp_dump = DPAA_SEC_DP_FULL_DUMP;
+		val = DPAA_SEC_DP_FULL_DUMP;
 	}
 
+	dpaa_sec_dp_dump = val;
+
 	return 0;
 }
 
-- 
2.53.0

