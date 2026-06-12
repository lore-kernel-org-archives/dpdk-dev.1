Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0332BCD98CC
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Jun 2026 02:37:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 119C6433F3;
	Fri, 12 Jun 2026 04:37:53 +0200 (CEST)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54]) by mails.dpdk.org (Postfix) with ESMTP id 770554027F
 for <dev@dpdk.org>; Fri, 12 Jun 2026 04:37:51 +0200 (CEST)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-36b9d265355so262760a91.2
 for <dev@dpdk.org>; Thu, 11 Jun 2026 19:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781231870; x=1781836670; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TRNezfvt50xClPAwQxTLnRmr1Z78UBADDX7arSdmr4U=;
 b=ohW10/IiIIQE5+f1DEH+xcS5LLclQgsP/ACBNMgJ0tl+wlRRqZ6ZWbJUgOuVZg6Y4w
 ujq/Miu9Z9jP2/QNRh3HvZnRq4OdaV0bSOQ6bVRJyrvHTjxFBXDxETpZBaQ9OZCr52Ir
 Iv9jw8+Ut2iySyIuN9mfrrXusDdNkuo7VtjPh4dI5FAHS1UUv5H+AZs1naSZHua2XCJ2
 D9e3Sn8yW0NJhy1PoW04OINLK3vQH1lJKJcG4nCpGP8f4ro36UU1mUmj1ai4F36LCtQP
 wkzvjoTMtKVVbrvrTKBrBOlHxxydUI/r0T/3ahfpOsPJFyjRrhnmSLWpuaF+S+ydSogX
 D7lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781231870; x=1781836670;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TRNezfvt50xClPAwQxTLnRmr1Z78UBADDX7arSdmr4U=;
 b=O9qNrkBzFI8Pk3rOkzXmGZXZuZgZL2xY3zZg38qx35/cTvacnhiMlUGEp570jOycn9
 WFtKHgMLWUFCALrb8+bHBHyp4LbAGfgEV1dy1pdGO8rue2ALh4R1EyrcA7eAgn3paR57
 AziPMZkTV1KGpoznAGHr2YkTfjrNhmpldcgZrwdU9fBkT3nEdzy+mGIRx1HXcyYbdZ40
 EmpFpiE3v3EldYhqJ/3Y77uPfdf9DFGpEMLXFdTLZUAqFDaegSiofnJXLYicne+aQldd
 rl87mxtrl95DQdqKVuNONL9+Q4jJXt6/4ZwdHocL4yqwO/V0JshOt9upa110ORbZ6PBG
 Cs1g==
X-Gm-Message-State: AOJu0YwhCKv5caoM+RMVT6eiWQvunsx4IjStfl/aQ/q4kXDzQA/Fqlad
 lFRW41DkRhq1n3krQcjMvByQ/RuKte4uRCo2Q1DpigSh0Mk0ctIPsN59
X-Gm-Gg: Acq92OGop14/CEgzkF9FbOpf24iSD1U6p/MSHB5FL2xXubGNPtBhqsDPe+JiwUW4EXr
 YrgpuXAjPAxtmV0bkjLcs2bBwz85ah1yGWGBZkBgoSJdxZMVUQTHmiw59bBCE9JvIGMlnSP6hOL
 OeCvL2mBsngPPHx4GptfNC/f/zHq0I8ytNuHHTYBLbg5dwehwdhtUCk5Lh8Hw2v27pn6zjbiJNz
 F9Gf51q7lexjy14/nAWpFw+Io3ws1HqG6sUBQQRX/Wf5jO6L/bWQdVgCZPvyz+nB2L53Gmixzjw
 hsn2WgMvkVkAt/nQ9K862b0N+LS2ZLoHHj41/QIDgCPF+rtGsexKsCrLyLfybEyQdlWUNkJXhBU
 YFZDKsWtPB/c5BRDA8HEMN0rGQGhC8FmHaRr7BhkBO/pG0mXXFaWV/+Nn39xe805rqoyIygcEIy
 GkyOF2RA6zp65Vx6Iml9m4ytWMzDk=
X-Received: by 2002:a17:90b:278b:b0:36d:b818:f848 with SMTP id
 98e67ed59e1d1-37a01846bedmr1049343a91.5.1781231870322; 
 Thu, 11 Jun 2026 19:37:50 -0700 (PDT)
Received: from gentoo ([49.204.144.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37a262adf21sm294974a91.14.2026.06.11.19.37.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 19:37:49 -0700 (PDT)
From: Shreesh Adiga <16567adigashreesh@gmail.com>
To: Jasvinder Singh <jasvinder.singh@intel.com>
Cc: dev@dpdk.org
Subject: [PATCH] test: add larger input len test for CRC16-CCITT
Date: Fri, 12 Jun 2026 08:07:45 +0530
Message-ID: <20260612023745.275608-1-16567adigashreesh@gmail.com>
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

CRC16-CCITT test only covered len 32, 12, and 2 which meant that
code paths like 4x SSE4.2 loop and AVX512 code paths which operated
on larger lens like >255 never got covered.

This patch adds a 348 len input test for CRC16-CCITT similar to
CRC32 test which covers the additional paths in SSE4.2 and AVX512
implementations, therefore improving the test coverage.

Signed-off-by: Shreesh Adiga <16567adigashreesh@gmail.com>
---
 app/test/test_crc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/app/test/test_crc.c b/app/test/test_crc.c
index 4ff03e3f64..11645d323d 100644
--- a/app/test/test_crc.c
+++ b/app/test/test_crc.c
@@ -14,6 +14,7 @@
 #define CRC32_VEC_LEN2     348
 #define CRC16_VEC_LEN1     12
 #define CRC16_VEC_LEN2     2
+#define CRC16_VEC_LEN3     348
 
 /* CRC test vector */
 static const uint8_t crc_vec[CRC_VEC_LEN] = {
@@ -46,6 +47,7 @@ static const uint32_t crc32_vec2_res = 0xefaae02f;
 static const uint32_t crc16_vec_res = 0x6bec;
 static const uint32_t crc16_vec1_res = 0x8cdd;
 static const uint32_t crc16_vec2_res = 0xec5b;
+static const uint32_t crc16_vec3_res = 0x6271;
 
 static int
 crc_all_algs(const char *desc, enum rte_net_crc_type type,
@@ -137,6 +139,12 @@ crc_autotest(void)
 	ret |= crc_all_algs("16-bit CCITT CRC:  Test 6", RTE_NET_CRC16_CCITT, crc16_vec2,
 		CRC16_VEC_LEN2, crc16_vec2_res);
 
+	/* 16-bit CCITT CRC:  Test 7 */
+	memset(test_data, 0, CRC32_VEC_LEN1);
+	for (i = 0; i < CRC16_VEC_LEN3; i += 12)
+		rte_memcpy(&test_data[i], crc16_vec1, 12);
+	ret |= crc_all_algs("16-bit CCITT CRC: Test 7", RTE_NET_CRC16_CCITT, test_data,
+		CRC16_VEC_LEN3, crc16_vec3_res);
 	return ret;
 }
 
-- 
2.53.0

