Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50D8D2ECEF
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Jan 2026 22:46:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30884402C0;
	Mon, 19 Jan 2026 23:46:03 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id E36614028F
 for <dev@dpdk.org>; Mon, 19 Jan 2026 23:46:01 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4801bc328easo39160255e9.3
 for <dev@dpdk.org>; Mon, 19 Jan 2026 14:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768862761;
 x=1769467561; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QGNuRblYumtwqpN+9gqA2URFkAOSBLjfXWBeuth59Rc=;
 b=S012199TNmwXQ7GGrqfLa92Nw6jK1Vyd2dXt7O6cehRQZROPuBL1w8MXCDmPGqVYtP
 oPYPi7Dhqf5EM3enQc0xTW98ve8lcVV4xfSiIkcltNuyjPpE3F226wzrgfD70kBWfw/x
 Uj4zwuRFGhhuHxhGDIBU1M55w44CguZjAgA9+5hGDlCAMAD6mxdracjuN4mfWQesC1EE
 nfl8u3QNQ4CvZq6UVBkQQKMKt5nT8hX/J1ZIARHDeqHgSEbukm8eiP3Oj/r+hxVvFNg9
 iRpgEh+4KHY5q79d8jRo8IqKTKyBEmflDFPD9aeeV9RvtMcgcJHKBprM0q39fYT0caD9
 PidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768862761; x=1769467561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QGNuRblYumtwqpN+9gqA2URFkAOSBLjfXWBeuth59Rc=;
 b=jwcB8/L0n/b74Fgf9QaSyfKUS0knM2HzjuiJqHBGlTNMqXy/QxdY4E9OyuL0OTUCE/
 N3Jh83nD5q/7ZAIL2NWom7kuLLZSy/GhcVCVVX2n4a1nwlWx3zbPguVAwLtiDPjEMEBt
 KPMxOuTxorYFA9p65HyUSjrHvr74PqcwYy2c0Qxow1EpYPrcmFAEDRFdyEdbFujUHuWr
 csZt/WGJJjNFFXfbnvKQFiEIES8LnkU8S1VP5TCcDuzR7LtI0KAtTMDDaylAsjmKhvOm
 /NHU+Lk6WWLuRhSI6TisrVSCTQ+gLwPDMeRUL53vqJPnKfG3yNPk8uqxvFjZ0arlrAmC
 BarQ==
X-Gm-Message-State: AOJu0Yxv663/t7iXao+4++XaKcSS/1dWH9o6n7AhI2Syo3zKZoAd5c0C
 8mEV1XlpF42SioLIxvv5S5vfSAf3GWkz3vEh1Pg12VzGvjHv3wmEds6pHkwRdWK7NFd7xt83E0C
 JUrUy
X-Gm-Gg: AY/fxX6l75egrWSp47fVtiU2OR4mfradLSWPFZNiAZhD02dhx5u88ig1S2FsMM+R41M
 awGsFOBKVIU9ZwIt1aV+bEEnKmLFReXhgXnxe/l5k/qFAsSNy3vjzJhjVzDsSk6jB+hWolSZmPW
 /lnvtY/g/t/cmjvx6h8D5abI0Smj3FpVSfh8+0N0CLmmQ5uwl4qAgCWMwPCKrHX3Guli7YocdF/
 6fLt20kgO1QPxBeZrDOMDGRViSFUjqASIci+h5MlYB1YUjQh9APcb1o+Hv0f3Su3seACKkuFc8b
 0BKx+ifcQEcFdlrz6pHMgqTBtzHY8TsM6681+GjBDuz/P8MNXGuSPdcnKSH4v5j7q7iPOlhi0ro
 jXYJAmOGVRKTQWBi3N9xUJuyHbxzlR2OMITto0QfW7XdimumVk/njibXLr1pt7iMen77qF42mCx
 FUlE86kZFSqfaLxKlpR0f3TatKfmpqwHwtDkxltX9XUViyqBXRAw==
X-Received: by 2002:a05:600c:190f:b0:479:3a86:dc1a with SMTP id
 5b1f17b1804b1-4801eb14bcfmr169097155e9.36.1768862761371; 
 Mon, 19 Jan 2026 14:46:01 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801fe2b936sm88180485e9.11.2026.01.19.14.45.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 14:46:00 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: [PATCH v4 1/6] common/cnxk: replace variable length state array
Date: Mon, 19 Jan 2026 14:44:08 -0800
Message-ID: <20260119224553.226243-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260119224553.226243-1-stephen@networkplumber.org>
References: <20251023194237.197681-1-stephen@networkplumber.org>
 <20260119224553.226243-1-stephen@networkplumber.org>
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

The cipher function is always called with in_len = 16
and there is an existing define for that.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/common/cnxk/roc_aes.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/common/cnxk/roc_aes.c b/drivers/common/cnxk/roc_aes.c
index d84feb546a..babf149ccf 100644
--- a/drivers/common/cnxk/roc_aes.c
+++ b/drivers/common/cnxk/roc_aes.c
@@ -157,9 +157,10 @@ static void
 cipher(uint8_t *in, uint8_t *out, uint32_t *ks, uint32_t key_rounds, uint8_t in_len)
 {
 	uint8_t data_word_len = in_len / sizeof(uint32_t);
-	uint32_t state[data_word_len];
+	uint32_t state[AES_HASH_KEY_LEN / sizeof(uint32_t)];
 	unsigned int i, round;
 
+	PLT_ASSERT(in_len <= AES_HASH_KEY_LEN);
 	memcpy(state, in, sizeof(state));
 
 	/* AddRoundKey(state, w[0, Nb-1]) // See Sec. 5.1.4 */
-- 
2.51.0

