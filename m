Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E94C02199
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 17:21:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 349DE40A6F;
	Wed,  5 Feb 2025 18:20:22 +0100 (CET)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com
 [209.85.210.49]) by mails.dpdk.org (Postfix) with ESMTP id D5C4440A6F
 for <dev@dpdk.org>; Wed,  5 Feb 2025 18:20:19 +0100 (CET)
Received: by mail-ot1-f49.google.com with SMTP id
 46e09a7af769-71fbb0d035dso27791a34.2
 for <dev@dpdk.org>; Wed, 05 Feb 2025 09:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1738776019; x=1739380819; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fxrq83+c3GumvxXC6lFTimV5QxFJheNg/bL0gLEcsTM=;
 b=NZIENFegljxG1jkskTUJMh8purgD3bKrRctgdvpMCB0mUhoKw/IGLVR256B77YYESf
 FbigEV2VqIxGRvgrnUVmWQzbV2ZjvIVuho45WY92Dla3O7kekmLNdckjlK/6DnNhA0Se
 YVID1aFfyrjyLI5Y1iyMO0dnXrqDoFXyh2ltM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738776019; x=1739380819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fxrq83+c3GumvxXC6lFTimV5QxFJheNg/bL0gLEcsTM=;
 b=OThSD+SmFaMsvDIQs7zRH1PhWEf+6YpElcjoScZUIHgTNDwgv+qC8fO+fO/QGh8EHE
 8zwk47K4JVXIaDfZPWTQOd3E0RK1U3TUtNiHF70+3aD1gObmgSp8J+Xf5bWnNUbFsLly
 fiEyEh0JVXhB66+n4ehXK9UfUYKvRr+eJpHTAVi5muHMtYC0EczRmL9TQlkysPQfckOF
 ccQQ1tKOzkGqUFcjoB1YSEjLIc3SjnPbH5s+gp1kYK8TDNqOuujwYJP6pu/Sxb72+P5l
 aY5f1ziU4rF1VVB5/yWqiogp2KN658qjS3UvGgLGVrvmRtnGGvBTsh0+3PkvQA1rj10W
 ZR9g==
X-Gm-Message-State: AOJu0YwCetZDjzwNx9GJsHDlo0yzydcEVLCXCB3iJGhYkJQjby8BqygE
 Q+JWrHZkk9YXAFLnRFjrNGcHEwLYfJBScAWyzZJNo+1iA0Qvw1WbmkKsk4lg1PQHMAfzq05wYB4
 Z4deCdMBrAhipZET2WdqX79CO+JUSPiztdU7XiqR3k6unlKhw4WEv7lpE9lBU2Pr/jwIL6xhmtB
 Ie3cQdqFw72JISlLdr1vgg9E/mBH3a
X-Gm-Gg: ASbGncvFnBV9OojVLeUMOT40UfE0ZtI+NbL7pXfj4Bghoig7RcM72c8euC0Az3lbRXb
 hB5g0KpK9oQlnG2CKldNJR8+HuPhaB9Oro2FflvsvI9YkMBugdjPGHr9Zh4sPyiX8JjG1SqgrII
 wpMxQLR2AAh5o1U/BT9DkA3bOPj2+wdaMXl7BsmqMHmqOFDiaGBZlukCmVqDw6NKCyaubfqY5lN
 6z3A+6a1JRSYzwZdw/hQ+atmVddVdjlFT18jgbT2EzDFZI/jK6gnlJ3QLrgHn0QWJvOQz5hnE2H
 y3btz2OEfYrjhuE5QHwP4EiodNuSIMPDUXaXlX+7hNUtForTzUoJPH4Qeh4XBOtpYbizg+iWXbk
 ibDAh6NT7
X-Google-Smtp-Source: AGHT+IHQYfChmKUlUlXc+P1TgY8hL1TTOZD24LykVN5Mrpe7vHmpLt13pKMLW1QAwONNITq8DKgwcA==
X-Received: by 2002:a05:6830:6787:b0:71d:634a:e0d6 with SMTP id
 46e09a7af769-726a413e1b5mr2543074a34.6.1738776018984; 
 Wed, 05 Feb 2025 09:20:18 -0800 (PST)
Received: from C02GC2QQMD6T.wifi.broadcom.net ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-726617cde49sm4004016a34.27.2025.02.05.09.20.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 09:20:18 -0800 (PST)
From: Ajit Khaparde <ajit.khaparde@broadcom.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, Peter Spreadborough <peter.spreadborough@broadcom.com>
Subject: [PATCH 08/11] net/bnxt: address coverity overflow issues
Date: Wed,  5 Feb 2025 09:20:01 -0800
Message-Id: <20250205172004.50395-9-ajit.khaparde@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250205172004.50395-1-ajit.khaparde@broadcom.com>
References: <20250205172004.50395-1-ajit.khaparde@broadcom.com>
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

From: Peter Spreadborough <peter.spreadborough@broadcom.com>

This change addresses the CID 449058: Integer handling issues
(OVERFLOW_BEFORE_WIDEN) reported by coverity.

Coverity issue: 449058
Signed-off-by: Peter Spreadborough <peter.spreadborough@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
---
 drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c b/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
index 1770069295..c29933b803 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
@@ -468,7 +468,7 @@ static int alloc_link_pbl(struct tfc_ts_mem_cfg *mem_cfg, uint32_t page_size,
 	 * and page tables. The allocation will occur once only per backing
 	 * store and will located by name and reused on subsequent runs.
 	 */
-	total_size = page_size * total_pages;
+	total_size = (uint64_t)page_size * (uint64_t)total_pages;
 
 	if (total_size <= (1024 * 256))
 		mz_size = RTE_MEMZONE_256KB;
-- 
2.39.5 (Apple Git-154)

