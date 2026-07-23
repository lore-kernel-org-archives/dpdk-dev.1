Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0562C531D0
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 17:59:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA15E4064C;
	Thu, 23 Jul 2026 19:59:11 +0200 (CEST)
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com
 [74.125.224.53]) by mails.dpdk.org (Postfix) with ESMTP id 40A1440280
 for <dev@dpdk.org>; Thu, 23 Jul 2026 19:59:10 +0200 (CEST)
Received: by mail-yx1-f53.google.com with SMTP id
 956f58d0204a3-66804667af2so923633d50.0
 for <dev@dpdk.org>; Thu, 23 Jul 2026 10:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784829549;
 x=1785434349; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xTnAn8Yljkkt70+jm4QxaUG8qjcqlut8rayRhjSWJX4=;
 b=HnHThiYE2Yd3ifxum40jrIzCtfxgv+Tjm4KiQkhKiij2UvKrtYVpP65joRDwmUNmRT
 Lnz3DS9lhCw467EKsHWjGxOItPBdALJhxgQ7MPKN2NfazvL1bRtEVZjZ5Z6vgkd0pUFu
 yNfc6APsCDQmX4h0N+g5nnJgohjldoTX8l4oBlWhfWuZlekuewthS7QQVdm0M4t5SYjq
 H+iAlp+OhhAPkt6jlX4Q2TP1c//KyYLdXzPFWTDnIbuYv7SObbcwPzo39YConZ9yW1Yv
 bOPRVhIoL/xS5KBQw4TE4uAFBxbXyc5VGUbXZFf2TQzW/l1YrlOYb5dEA7P0gBp2W+0b
 EpWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784829549; x=1785434349;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xTnAn8Yljkkt70+jm4QxaUG8qjcqlut8rayRhjSWJX4=;
 b=AfzX2ZZv/S7tmZIkaxwBkZxjrv2YGPiMikdnI/9Gt+ftHfFdnXaHi6dR59PbV7ac18
 14gYFvC9e1xMVCqd+WVRCpZr55VyPGlEp0OZNmFbd7+l5oXEG8hzvWcSJsT2zAjZ05TO
 tzcBUvIqVOsAaRsUqjWZppRT9JoFm1hqBtprb1dYWSmSISQxvucTnMgSKsW1Iio9hna1
 rAWWRifNvj18bi5uOVZG5UC0lg5k+jvzWWOPbiwRk0bLejzIIVpWlaboZF+azMv5kPae
 fAcyQTQOMZIqUfUtNpv23EUWHos7+4qSIkLFVWVNxoK5peZ1KsXZRGju/Qx3EO0HC5kh
 a27w==
X-Gm-Message-State: AOJu0YyN2JGjvQY3o1qSBqICaGZtyvmS6ro3GsBCkxhPC+YjDKuUmCJy
 S0uPO3M2/5yx8h0kiQGvKB1/KNxdOsZ9ndUmRsxKc4m9bsvRDoAm3xkBYh8P0wa+HCxxgjFDYRL
 YFyTv
X-Gm-Gg: AR+sD12p0EHjjQJg4PKddQHqT93Kmi6mrfASSyhtYxV6FXj8O1k58CGC+ALSYHEVtCJ
 xLKaJD7ZfmSNmE/gucvAdK31Zp4foUL/PZa+E/oUt+bXvZFMa453vj3LFEoiprupxsPyXghj7k2
 nxWed0wC2sPzKVm/QUfEigNvfTpqX7Jq8FpwDwXLQOd1SNlRGH8N/ij9VTADoQXi81VBX1uYrO8
 HHgr/BhbXanHxKBudGm8ToUbs0lJfC2cgnu8TY7Shcze+FAtlV/fE75VVROo6iTj/GPwNkBoCLc
 hu/Oa7aYm5OyJYM+3RGvhj5GICNCTuTGBFsetGiNl3jyRN4ib5EP8jmXuAANJ0brwUqY+Wrx15U
 WkjczlHpAkyEP90wBFVY6a3pogy5oLIOeabYbK7owOVuB81h7UHSFFVrOrLf146ssivWjFnzVBb
 +BOE/sRvHuckyR2wdDmI4lSxvgRluYLQL0BOFeLwG1
X-Received: by 2002:a53:d20d:0:b0:668:9851:aa1 with SMTP id
 956f58d0204a3-668a4d63f59mr841519d50.53.1784829549404; 
 Thu, 23 Jul 2026 10:59:09 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66890367063sm3604198d50.0.2026.07.23.10.59.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 10:59:09 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Feifei Wang <wangfeifei40@huawei.com>,
 Xin Wang <wangxin679@h-partners.com>, Yi Chen <chenyi221@huawei.com>
Subject: [PATCH] net/hnic3: fix possible uninitialized return value
Date: Thu, 23 Jul 2026 10:59:05 -0700
Message-ID: <20260723175905.186303-1-stephen@networkplumber.org>
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

The code to enable fdir filter assumes entry is present.
If not found it would return uninitialized value.

Bugzilla ID: 1964
Fixes: efa3b9b36fc7 ("net/hinic3: add flow control and filters")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/hinic3/hinic3_fdir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/hinic3/hinic3_fdir.c b/drivers/net/hinic3/hinic3_fdir.c
index 37a4f0cf52..71d50a3d22 100644
--- a/drivers/net/hinic3/hinic3_fdir.c
+++ b/drivers/net/hinic3/hinic3_fdir.c
@@ -1275,7 +1275,7 @@ hinic3_enable_rxq_fdir_filter(struct rte_eth_dev *dev, uint32_t queue_id, uint32
 	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
 	struct hinic3_tcam_filter *it;
 	struct hinic3_tcam_cfg_rule fdir_tcam_rule;
-	int ret;
+	int ret = -EINVAL;
 	uint32_t queue_res;
 	uint16_t index;
 
-- 
2.53.0

