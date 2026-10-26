Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F4A606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 21:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=Vdo03Taq
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7BDB8402A3;
	Mon, 26 Oct 2026 22:17:33 +0100 (CET)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTPS id 5482440151
 for <dev@dpdk.org>; Mon, 26 Oct 2026 22:17:30 +0100 (CET)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2e987b4a710so1422685ad.1
 for <dev@dpdk.org>; Mon, 26 Oct 2026 14:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1793049449;
 x=1793654249; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mmOzLbpjP5qdWndvbPdcZRS/1pi2xYoEDuEoCQQIHhU=;
 b=Vdo03Taqg23c+1vRUJD5ivTFzyQrvswdZmQ/OByUjGQOKkny24xCBvPUDz40sKxLSk
 dwmUJBNFKIuLBtM0YcjjR1TchfmsqrssQMLyiyR5WENGOgUIzL5HLNkWnYP4LY0MBBDw
 k2pWvJusVcuh55C0wcqwuNZQQl4rYyLUcWbnIn/3YEMTOknjBat4I6HUdB45BeFa0KUf
 8rX4HbkMHA8qux/ocRi6+qzRThEcZpigOF5j7QnVAB02o38keqbsv9KN6yL0r1IRwnlv
 Kmqb9C3M4e1sZW9HQdq4J3vZr4KrqDKIkRYrZFkc/8D+7BRH8vj1aENAyRUvw228XSxz
 7X7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793049449; x=1793654249;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mmOzLbpjP5qdWndvbPdcZRS/1pi2xYoEDuEoCQQIHhU=;
 b=UWKeIDmcBXCErYKRuGhVgCk4Qv2kpnex8o4G/TuVR9btjdbcZrIK98Jv/U6dfzeB3h
 ZFqtBQrhIP2sFLiGz1PDFXmGaXhR1Pfqsahe2wXjcun1aY8pFL1BZgU3qTfFVzNGbMHy
 n+4yG9qppwuZxcboXhhGdpaAjsU9LVQAUhkkPdUXCma87tnu+uNwTGrzSusnyeSEdp7B
 luEqgImr1Tzg4uWwqiR+6uCXUTVM8rn8vJrdwgTYpLN5WAtmbPzwGw6WblNYZq8/HzmY
 Tyf/iKMKQZVjubu9qVam/6YjZsx782TxUeLCqjLIys9qkw5WooKfPZjjNnD62ai7bXAx
 /UFA==
X-Gm-Message-State: AFq9FYKJJIwtFTt+7RfrrwL/WLPxwHSB6EKuNZiOJORbdtaW55pkKnOJ
 gyUPe2pCT9GaxfYylg4Js59mxvgwCcePT3uyAyv/DJtg8zHVyC8pxozexFFBw6GQh6mWKyED3yc
 eLVDPB04=
X-Gm-Gg: AYBFou2Gg92zaKnlaxObfDatouT32cWCQ75OsZGIICmqE36VQgl2EiIX+cCLM0PhO8Z
 mC3Mo4dU7e1zANpXEdjQ5BnIi1VMTKsuO02JhXJTbDRoLyItXZwp5l1IWYiZXvLr3wxD6LPZSZR
 BRBDq8lxgan1TI2v5qSn+gvJG8Z4pqSFSTY/T2EIkZeDIdpIvv+h6qxVZoZsMzAfG/Cpx+MxFZf
 O3ZjnwPOD4E6z2ar9I0OTURuQJctJsi8pPa9u2EdWnjDrLH0+vXIgpiMvM3/bAmhcv5na/4vtbY
 TrpAQyafgx6vBqvgteHKM6LKQNRgZ/Y6s6y8iEOlJ3X4wFR7fvvN9370c8sFhlVfBFH6y7/0m2r
 UZaHhwtr7MUseIzEhpLtAGJ8Ii3t14iVZrS75UXKNrJYOq47/xDLEj/vM0p9MlTWwbmV166P3mE
 gVDwN9f39/UDN2LaSBV2/BcbLeyoGqdNLX8Z8Ej9g4v6KNutDkIkLcfQfX/4NfZR2jdRDtbm41a
 qvUeNvNxHpSiwaYHsGEW/bI3WmDgJiorn7kE13QBCb/F/RVZ3DMYM74u5bqPBse/0vFmvaB/kXT
 7hGa9qtm7naVWRVY074=
X-Received: by 2002:a17:903:32ce:b0:2e8:95d8:6423 with SMTP id
 d9443c01a7336-2eae4072774mr4669375ad.38.1793049448748; 
 Mon, 26 Oct 2026 14:17:28 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eae6c3d17csm893295ad.53.2026.10.26.14.17.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 14:17:28 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] net/ixgbe/base: fix string truncation warning in ACI debug
 dump
Date: Mon, 26 Oct 2026 14:17:26 -0700
Message-ID: <20261026211726.2319112-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Building with ASAN and -Werror fails:

  ixgbe_e610.c:59:41: error: 'strncat' output may be truncated
  copying between 43 and 118 bytes from a string of length 127
  [-Werror=stringop-truncation]

The hex dump used snprintf into a scratch buffer followed by strncat
with a signed remaining-space count, which could also go negative and
be passed to strncat as a huge size_t. Format each row directly with
snprintf at an offset instead, and handle the partial last row in the
same loop.

Fixes: 12648d0a5afc ("net/ixgbe/base: add admin interface debug printouts")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/ixgbe/base/ixgbe_e610.c | 48 +++++++----------------
 1 file changed, 15 insertions(+), 33 deletions(-)

diff --git a/drivers/net/intel/ixgbe/base/ixgbe_e610.c b/drivers/net/intel/ixgbe/base/ixgbe_e610.c
index 06a69d1d62..dc5e668edc 100644
--- a/drivers/net/intel/ixgbe/base/ixgbe_e610.c
+++ b/drivers/net/intel/ixgbe/base/ixgbe_e610.c
@@ -42,41 +42,23 @@ void ixgbe_shutdown_aci(struct ixgbe_hw *hw)
 STATIC void ixgbe_aci_debug_array(struct ixgbe_hw *hw, u16 row_size, u8 *buf,
 				  u16 buf_size)
 {
-	char debug_portion[IXGBE_ACI_MAX_DEBUG_STRING_LENGTH] = {'\0'};
-	char debug_string[IXGBE_ACI_MAX_DEBUG_STRING_LENGTH] = {'\0'};
-	u16 i = 0, j = 0;
-	s16 remaining_space = IXGBE_ACI_MAX_DEBUG_STRING_LENGTH - 1;
-	s16 nbytes = 0;
-	if (!hw)
+	char line[IXGBE_ACI_MAX_DEBUG_STRING_LENGTH];
+	u32 i, j;
+
+	if (!hw || !buf || !row_size)
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
+		size_t len;
+
+		len = snprintf(line, sizeof(line), "0x%04X : ", i);
+		for (j = 0; j < row_size && i + j < buf_size; j++) {
+			if (len >= sizeof(line))
+				break;
+			len += snprintf(line + len, sizeof(line) - len,
+					"0x%02X ", buf[i + j]);
 		}
+		DEBUGOUT1("%s\n", line);
 	}
 }
 
-- 
2.53.0

