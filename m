Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE81FD8FD3
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 16:48:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9074A4065E;
	Thu, 26 Feb 2026 17:48:49 +0100 (CET)
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com
 [209.85.222.193])
 by mails.dpdk.org (Postfix) with ESMTP id 5C473402B2
 for <dev@dpdk.org>; Thu, 26 Feb 2026 17:48:48 +0100 (CET)
Received: by mail-qk1-f193.google.com with SMTP id
 af79cd13be357-8cbb6d5f780so106758085a.1
 for <dev@dpdk.org>; Thu, 26 Feb 2026 08:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772124528;
 x=1772729328; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iX9NsMt5DSOcZGw3BLt1xGpNE6zHlEb3L5mZlRqA+DU=;
 b=CtLvlErzLdpHSblgObtrhQWCp4pYkuRmaVZ54DOqkQxU4LPtGvC9Ji9lxkD9HVulU0
 cvS9Zz87cdZmrXKudpKSSXJNBtPdPGgjIpLjJ0DkFbJuJ7ZxWfb4DBdl5rzhU94Si5NS
 Fo/f1Cw/HzV913ZSewMnJdG4xvXtz3p9pc0RCM9iBh2DCNAzWG9+dsS3b/JIvheYtAml
 jL6xmCuZ/3stPoe9jPMDvl8i7Mu9OYVoZfQ5tH25Zuo07g3/9n3sadWe8L74Ke48te5x
 2x006GY8QM7AF3XOETmbUAsXAarsfU3vHBRhXFEaHffpm2X8CKvyTUm448xs9bSBfAKa
 zAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772124528; x=1772729328;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iX9NsMt5DSOcZGw3BLt1xGpNE6zHlEb3L5mZlRqA+DU=;
 b=h17djrA1AhSFiZixvajoBcEyTB7Ubid7DNJRT5S5M6lgEDyqQeAsmHsPqKDULdnNwL
 eXA2bbRpw+9OWbNLfSW+e7PgizYGYsn6vVWM5QcLzbvftIkFSaxtXp1KSPJhNRxza4as
 md6wdgBUbkiqRFR5fdOAtF70B6mBUH52yuHjDnxxkRQtpIeM1+bPaE/MjCPmpHt3Fb1/
 uXGBo+E37YF9DZO2F386GtQ45Uas031pPCuhEmDS5NU9z34OaoiYLdpYMiJJJkX7WtIf
 qn+0YYf1e9eg6jNX58HybcCD8qlt5UNCFslGlzW1+ySdZxCp/hXa6qTWaMnyAJYyh8IH
 wRcw==
X-Gm-Message-State: AOJu0YwdSqOHvgjrVV62TlfQ5czozs8D9kwCYx5FC1YTo3e3BqdDKLpw
 Kf0dWml200EPhwSgk/CHQQmEqSuCRw1u6WaZz54oADAYUDgVR8b3btJRJBVCLpVeCmfIpdjwhQH
 cCtH4
X-Gm-Gg: ATEYQzzbBol6wTAZWSph4OpA5GPladXGTFOG4kzDl+E5+w6i7WG9os1rUiqoHkffdXI
 eGVxV+gOKqc0zb5a9JPP547NMbrFylL0+TZTrNrWZFJSvS+5sAijmqpjG5zLfsirlJP0tNdvU90
 lQ9x5P10LUeRoKk+/Nj9uxyChdHu/ARMfFsgwH+CgjEhX7Mrn99GTuiDg5W88hl2Ih2x7qp8iF8
 B98jTdSRcPxS02C3sUZeREF4gZf+iW2+SR9B6EYVWj/Zn8sXFARiY51siyeKSGwpNMg6GP5qb6+
 vn3X1Wx/D5LMcmPt7jjBdAOIWGksMLxbp3k4sDSpM/7LLK8pIZ31IBMt3Vs+sYeh41UNyRTWRiD
 3SsPirc2wTnpjQDFOChjivNF12JJx3E0az+6xcM8P11iGXd6+ReLb0fNUUGIBMgs0MTp18oTJS+
 kFIev7yZAGKOxZbX+Vbb0gJksSZ3I8Q1zBunjzOpkk/iZybQhkNX57m8fsslLmSVj/rKvorGbS
X-Received: by 2002:ac8:5905:0:b0:501:3b8c:7d72 with SMTP id
 d75a77b69052e-50741f385efmr57660551cf.27.1772124527547; 
 Thu, 26 Feb 2026 08:48:47 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50744afbba3sm26227431cf.33.2026.02.26.08.48.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 08:48:47 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Luca Boccassi <bluca@debian.org>
Subject: [PATCH] test/memcpy: reduce alignment offset coverage to fix timeout
Date: Thu, 26 Feb 2026 08:48:43 -0800
Message-ID: <20260226164843.183959-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
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

The memcpy test sweeps all 32x32 src/dst alignment offset pairs which
causes it to timeout on slow emulated 32-bit build environments [1].

Replace with a curated set of 7 offsets {0, 1, 7, 15, 16, 17, 31}
that cover the interesting alignment boundaries. This reduces the
iterations from 38912 to 1862 while covering the same code paths.

[1] https://build.opensuse.org/package/live_build_log/home:bluca:dpdk/dpdk/Debian_Testing/i586

Reported-by: Luca Boccassi <bluca@debian.org>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_memcpy.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/app/test/test_memcpy.c b/app/test/test_memcpy.c
index 7273c17a06..12e491034f 100644
--- a/app/test/test_memcpy.c
+++ b/app/test/test_memcpy.c
@@ -36,6 +36,16 @@ static size_t buf_sizes[TEST_VALUE_RANGE];
 /* Data is aligned on this many bytes (power of 2) */
 #define ALIGNMENT_UNIT          32
 
+/*
+ * Subset of offsets to test. These values cover the structurally
+ * interesting alignment cases for SSE/AVX/AVX512 copy paths:
+ * aligned (0), off-by-one (1), partial vector (7, 15, 17),
+ * vector boundaries (16, 31). Testing all 1024 src x dst
+ * combinations of offsets 0..31 is unnecessary since many
+ * map to the same code paths, and causes the test to timeout
+ * on slow (e.g. emulated 32-bit) build environments.
+ */
+static const unsigned int test_offsets[] = {0, 1, 7, 15, 16, 17, 31};
 
 /*
  * Create two buffers, and initialise one with random values. These are copied
@@ -103,13 +113,15 @@ static int
 func_test(void)
 {
 	unsigned int off_src, off_dst, i;
+	unsigned int n_offsets = RTE_DIM(test_offsets);
 	int ret;
 
-	for (off_src = 0; off_src < ALIGNMENT_UNIT; off_src++) {
-		for (off_dst = 0; off_dst < ALIGNMENT_UNIT; off_dst++) {
+	for (off_src = 0; off_src < n_offsets; off_src++) {
+		for (off_dst = 0; off_dst < n_offsets; off_dst++) {
 			for (i = 0; i < RTE_DIM(buf_sizes); i++) {
-				ret = test_single_memcpy(off_src, off_dst,
-				                         buf_sizes[i]);
+				ret = test_single_memcpy(test_offsets[off_src],
+							 test_offsets[off_dst],
+							 buf_sizes[i]);
 				if (ret != 0)
 					return -1;
 			}
-- 
2.51.0

