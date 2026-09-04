Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC52C624D3
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 18:48:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 374FA42DC7;
	Fri,  4 Sep 2026 20:48:48 +0200 (CEST)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id 6DFDE427E6
 for <dev@dpdk.org>; Fri,  4 Sep 2026 20:48:46 +0200 (CEST)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2d5335cf904so13553125ad.2
 for <dev@dpdk.org>; Fri, 04 Sep 2026 11:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788547725;
 x=1789152525; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jKlXqYTMB36RNkyXhNVg77qIGKy6CJa9wEOZuwg46q4=;
 b=Ask5wLgjHpG60C61YO0kuJFTGqrxvUwdSB0m28Dx7pzjeFQMnHAqbljPxqFT3x6l+t
 Vy1NyDrpK6VOU8ijYZrzX7jUvSIeZMB7x8NwkowX+H8XcznKv5owRgBeb355vRS04D9T
 HgryFQnrEH8Zpkwwty3GN08BCb5SJivggecEK4tYkSWoZzfq7+L4iiJvp4oIpXTxl+O+
 lLefl0833ZHauzsKEuOtgB/7s67A3bvKlfzYDsmqAO5kXHySx9xEAWpRt+vbjIuEoL6o
 2NZ434Xq29H8lIESpX/CJoegggLBGzDzYdg/KE0q75zOMazKVvWdXmgrwQdgjQ1JgTFP
 T4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788547725; x=1789152525;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jKlXqYTMB36RNkyXhNVg77qIGKy6CJa9wEOZuwg46q4=;
 b=csK2d1pmAja+vY9yShzlenBaKXL8KmiUkWS8J5uw16FUl/0NNRqSCagWuvLnJ18K8S
 pZEEMmFLRihMDAQoxVQlIfrFBqvvy4zYA77oyU2g85uH2hLyre1mf3+QhK6J1GM0oGAa
 OlhpoBYLftwzlXqkZ/qnQkbIh4NVCdCwlXrBKb27JFgnoa3Olj9xDYgoiDQUejgAIlii
 ng9CiCZESWgsh87LOjXZlphbRtmjJD4ygMxWXXHDrYbtjiObpL8JKClE1M70ag0G/TYJ
 3ddbbk8qyg+LZAoUhJzBt60+sHxU2oiElHn98XnDhWNMAX9q1oS2VymD5Ug0NRgNpv2B
 fJcA==
X-Gm-Message-State: AFuF++mUuh0bIpjsC9uGbnScAttuPJSTU1TBDoJgKcWGw7GVAYY/Bo4i
 U55diHS1XN/Q85UYEpwk607wUaBzLtgrz4PvKgeMEsvkun/DMW+V/bma6Pvy6Eb6UWyEATsjC/C
 w9v9+
X-Gm-Gg: AYBFou1Mr6KtKiCeV1ncCwctJRB07wz1ouUhdJIGyPfDXMuX1uAA6nG9IHG0D2SSULh
 aqPmkiv/GNgxmYSKJi+uiqyTCYrV0YIFaSG3EVuYvM3A12Vs5VF+7bU4VQjHsP01mhQpjn5CbFq
 t6IJZqTuOaiSpA9vLAHiqTCnZEquMRcc+bnozYyHq8+MuerWlAUa8ZZ1FPCQ1Sm3lNJzBiypNt7
 JeuSjCvPx8dHJXxqiOasIdY8Mxl+VoCHNwrRHStx1sR+Rpq28I8trUq4MYOZX+dJv9Fa8XbR7hf
 C7mNASmovyV2291DmymttQ8uwPguwFJ0OvIWTObANiUV5uI/MvXN0R72qpkfZ0cDVQHd14kdv27
 rSuC59qmPb/zi00nCJeidWAQQ32BoJhXjX/+fYW8V+Uu5keJbCJpvg4upPgD7DYRzPrnBWZP2dT
 TZMKXbqhje0vOe4IKJ0Nws5hqPR+FPbYPxVlqV4oC82xssLilFaQAR8dNqQ84pvcsBi+muxPcTD
 7Kc2PfbtmmRKC530/w24NvY/5M7A3rOsw0e+Q==
X-Received: by 2002:a17:902:e786:b0:2d8:d4cc:be63 with SMTP id
 d9443c01a7336-2db12840354mr154517695ad.16.1788547725274; 
 Fri, 04 Sep 2026 11:48:45 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db1cdb4acesm9355615ad.4.2026.09.04.11.48.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 11:48:44 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Subject: [RFC] net/ixgbe/base: fix overflow in ACI debug dump
Date: Fri,  4 Sep 2026 11:47:16 -0700
Message-ID: <20260904184835.1900541-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

If doing ASAN build GCC warns:
  ixgbe_e610.c:59:41: warning: 'strncat' output may be truncated
  copying between 43 and 118 bytes from a string of length 127

The truncation is bogus, debug_portion is always 5 characters.
Rather than fighting with GCC rewrite the loop to
use a single snprintf() at a running offset.

I know this is base/ code but even upstream code needs to
be able to build clean with all compiler options.

Fixes: 12648d0a5afc ("net/ixgbe/base: add admin interface debug printouts")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/ixgbe/base/ixgbe_e610.c | 57 ++++++++++-------------
 1 file changed, 24 insertions(+), 33 deletions(-)

diff --git a/drivers/net/intel/ixgbe/base/ixgbe_e610.c b/drivers/net/intel/ixgbe/base/ixgbe_e610.c
index 06a69d1d62..4e2dac989f 100644
--- a/drivers/net/intel/ixgbe/base/ixgbe_e610.c
+++ b/drivers/net/intel/ixgbe/base/ixgbe_e610.c
@@ -42,41 +42,32 @@ void ixgbe_shutdown_aci(struct ixgbe_hw *hw)
 STATIC void ixgbe_aci_debug_array(struct ixgbe_hw *hw, u16 row_size, u8 *buf,
 				  u16 buf_size)
 {
-	char debug_portion[IXGBE_ACI_MAX_DEBUG_STRING_LENGTH] = {'\0'};
-	char debug_string[IXGBE_ACI_MAX_DEBUG_STRING_LENGTH] = {'\0'};
-	u16 i = 0, j = 0;
-	s16 remaining_space = IXGBE_ACI_MAX_DEBUG_STRING_LENGTH - 1;
-	s16 nbytes = 0;
-	if (!hw)
+	char debug_string[IXGBE_ACI_MAX_DEBUG_STRING_LENGTH];
+	u16 i, j, row;
+	int offset, nbytes;
+
+	if (!hw || !buf || !buf_size || !row_size)
 		return;
-	if (buf && buf_size && row_size) {
-		if (buf_size >= row_size) {
-			for (i = 0; i < (buf_size - row_size); i += row_size) {
-				nbytes = snprintf(debug_string, sizeof(debug_string), "0x%04X : ", i);
-				remaining_space = IXGBE_ACI_MAX_DEBUG_STRING_LENGTH - nbytes - 1;
-				for (j = 0; j < row_size; j++) {
-					nbytes = snprintf(debug_portion, sizeof(debug_portion), "0x%02X ", buf[i + j]);
-					strncat(debug_string, debug_portion, remaining_space);
-					remaining_space -= nbytes;
-					if (remaining_space <= 0) break;
-				}
-				strncat(debug_string, "\n", remaining_space);
-				DEBUGOUT1("%s", debug_string);
-				memset(debug_string, 0, IXGBE_ACI_MAX_DEBUG_STRING_LENGTH);
-			}
-		}
-		if (i < buf_size) {
-			nbytes = snprintf(debug_string, sizeof(debug_string), "0x%04X : ", i);
-			remaining_space = IXGBE_ACI_MAX_DEBUG_STRING_LENGTH - nbytes - 1;
-			for (j = 0; j < (buf_size - i); j++) {
-				nbytes = snprintf(debug_portion, sizeof(debug_portion), "0x%02X ", buf[i + j]);
-				strncat(debug_string, debug_portion, remaining_space);
-				remaining_space -= nbytes;
-				if (remaining_space <= 0) break;
-			}
-			strncat(debug_string, "\n", remaining_space);
-			DEBUGOUT1("%s", debug_string);
+
+	for (i = 0; i < buf_size; i += row_size) {
+		row = buf_size - i;
+		if (row > row_size)
+			row = row_size;
+
+		offset = snprintf(debug_string, sizeof(debug_string),
+				  "0x%04X : ", i);
+
+		for (j = 0; j < row; j++) {
+			nbytes = snprintf(debug_string + offset,
+					  sizeof(debug_string) - offset,
+					  "0x%02X ", buf[i + j]);
+			if (nbytes < 0 ||
+			    (size_t)nbytes >= sizeof(debug_string) - offset)
+				break;
+			offset += nbytes;
 		}
+
+		DEBUGOUT1("%s\n", debug_string);
 	}
 }
 
-- 
2.53.0

