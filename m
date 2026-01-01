Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9C8EED626
	for <dpdk-dev@archiver.kernel.org>; Thu,  1 Jan 2026 18:13:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F344940267;
	Thu,  1 Jan 2026 19:13:54 +0100 (CET)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44]) by mails.dpdk.org (Postfix) with ESMTP id 69A9B40262
 for <dev@dpdk.org>; Thu,  1 Jan 2026 19:13:53 +0100 (CET)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-430fbb6012bso9685404f8f.1
 for <dev@dpdk.org>; Thu, 01 Jan 2026 10:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767291233;
 x=1767896033; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=X7vaUaT331syWLkw2RSznWL3aLMx88sXJV4cxBAu/pw=;
 b=xfHD/gOBxfo7qRsdDjN1Y2oJfPl7QTBeUAAVAkBpBeN/PpDQQjAx8hUfjJy5epT2dl
 lTFZWhtwtsJaVvYlGEZFmj/MkeqT99zHzhbweNirp+NQC3KrA+z3jBPUVroXmKfG6sx9
 38N3pM5LyY6015Hf+t+1E285Juxp0aIDG8k08oPoOlWtf1F+T48bT5dhxOwziHc4CM8I
 AHuqF1bhksNWfS01oSlb2llYk94vKqt5AywXCCb1bA6a7ITcZPHGwbfDV6lxksKtEIX5
 38JtGeK+xMNLnozujKYgJhy/Fa32L3g0ctzxY0VVyRtf6ySOkyuhjxxx9wMWfUerNKDK
 yhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767291233; x=1767896033;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X7vaUaT331syWLkw2RSznWL3aLMx88sXJV4cxBAu/pw=;
 b=LfH6Y1MBHa2QWfxysje6mMcmYSlNwJQ5EkO2FVof57+rJFfordD7lV54yLQcsFEK6G
 OV17jPzo1Zb24Lpk7tgeW5EhgPFkdH/wbdfos8HyN1PGrB0is1OFeJ0tVNeDGX55bshB
 mn+irUQIS0togVPfFL6pWt3B8MyuBULXTy6Qjg5eA719wIkjrv5R+1Zeh2zAUYlG2Aeh
 YxLSHeOuRMCwxrd57Xjmg/PR8HTGRZfr+slOcBWjEp9FsZOSAyU+6aVwxLJ4kiSSsc/C
 NopmswDFCxYFpeJseb2mVBNEyHPQDv/dnCa0m8kXm3oipFYwyQcECbUVWaEfzBF7d7Lf
 Makw==
X-Gm-Message-State: AOJu0YwYAV5Wzoc7KpPVbtle1PKsbWw39dtf+WLqWIrTRka1Gd3Dv3Up
 7D9VlZSVu5MlTnzeP3mrSiOcOYFcgATe2dHMoEuZ5nl6MWhPYnW2pa6mhMeF2qfoqf0nw3XDE+I
 MfPEph8Y=
X-Gm-Gg: AY/fxX6gBe1Qs6otoPGcCw5oGpMA46qMY6P06p/5TnwFL4mZ+jX//YJvfuS7/uE73EF
 YS8Hktep/Ya6l1osoqmTfibKvYgXMlJo3CBoz1VA7wABG2p6qJTzixAXFwJy9HcF+ML5aRYB7bk
 BdCEwrXJqvvnl8aNE6iZyjMs/9/T/Dg04XmqzA6pYLOAkNOY/qYF19e3eSyJjQrT6hYkFXuv7El
 xZCeyXzfIBZiaM/XWuC0RBeJDn9V5ZN8I+nF9h1UtFUWqTAnpCkWk1L7jZuTGgLglGbmV/S3ufP
 mu9H2P5weNC+w+LZum5ZHO5fH19qaQoDrKSO6vCL2+4+XZ6SzunvIIXzo8wNFE+E0p4iPfnb/Uk
 CkBg1IUuewSr2/RzLDzbjy8nKBImvW9kOJwnCQQJekPAf2MshGi/fNcJCOw5usbQ6OtAc34MaOP
 UzsLyS4afEA+gVHdZNg+dqXnLuLQfDP4+EbeAdSyBG4wgpO416Wg==
X-Google-Smtp-Source: AGHT+IFTMA3tldJDOYUOMzY/8CKgLBYzMmSVv0UM1CydQYR6E4SsMCIYy4y+NFeqY3ctRKq24FcSNA==
X-Received: by 2002:a05:6000:4312:b0:430:f1d3:f96 with SMTP id
 ffacd0b85a97d-4324e4c7393mr45834633f8f.6.1767291232578; 
 Thu, 01 Jan 2026 10:13:52 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43264613923sm65738005f8f.26.2026.01.01.10.13.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jan 2026 10:13:51 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH 1/2] net/nfb: remove unused flag
Date: Thu,  1 Jan 2026 10:13:43 -0800
Message-ID: <20260101181345.201601-1-stephen@networkplumber.org>
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

The configure callback does use the device argument.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/nfb/nfb_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/nfb/nfb_ethdev.c b/drivers/net/nfb/nfb_ethdev.c
index 98119d70fd..5f1b11a961 100644
--- a/drivers/net/nfb/nfb_ethdev.c
+++ b/drivers/net/nfb/nfb_ethdev.c
@@ -181,7 +181,7 @@ nfb_eth_dev_stop(struct rte_eth_dev *dev)
  *   0 on success, a negative errno value otherwise.
  */
 static int
-nfb_eth_dev_configure(struct rte_eth_dev *dev __rte_unused)
+nfb_eth_dev_configure(struct rte_eth_dev *dev)
 {
 	int ret;
 	struct pmd_internals *internals = dev->data->dev_private;
-- 
2.51.0

