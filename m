Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE246FD9E2C
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 19:40:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3EDD140A6F;
	Fri, 27 Feb 2026 20:40:53 +0100 (CET)
Received: from mail-vs1-f100.google.com (mail-vs1-f100.google.com
 [209.85.217.100])
 by mails.dpdk.org (Postfix) with ESMTP id 8C62B402E7
 for <dev@dpdk.org>; Fri, 27 Feb 2026 20:40:51 +0100 (CET)
Received: by mail-vs1-f100.google.com with SMTP id
 ada2fe7eead31-5fdb47d6131so667002137.3
 for <dev@dpdk.org>; Fri, 27 Feb 2026 11:40:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772221251; x=1772826051;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q7VCYnd4LYWYnhHYOB+oDw+7UZpV4Vdr3nl6HAyAOLE=;
 b=oQleR2AwVOolLnyHFMLu0Fz37fp7CvA8PUfHneSFCM6Wm0bh/Lh1XoeESa5Jq7MAEY
 uoM/1SU3Hn4QAeL6NRU8jSdA7aIjrYbvlsMzxU8i7WzXaifiT5KqiF7Zqjutw+/MzKuY
 V51+2vYhTUFNnW58alW7uQJTSOUbA+QyhSqf/qiXV9TxAyU9ch/6z/iaOFlWpS5wyXhZ
 qZEZJ424vgJIM6e1zScoVCLNcIBFW9QGHuLKoFC9JCZ1einV0KaOmx7Q6xlJsX19u6aq
 mSof+mGdh56Y/Vd7+I8M9buwLu9RYs5YhuevSml67QkCx7kZ4pT6vpt5kbav5Vc7/cnM
 7uIQ==
X-Gm-Message-State: AOJu0Yz7mesVrs+XqRvRF9Yb0I4h9OxIlz3lqiWsQL9hHj5apu36rGMv
 uWt5cnZbHR+spxKkP14d+KgEerKR+UZKH4SKQ9jf+ex8DHvK7Pa2d+RZ9kKXhGxXqHBORTRYnNq
 vXqzU2Z4Vx+jAuf7CK/4+lb8Z8wH7fz9uJoW8G9NhQ4JLQv/hMpKmooZimdAtgiO51JfrkIXVdC
 RjMcLNrR86OAl6pX3VJjL7XQGdECsiQpxobEIzN/VkjyMLAUNHfc+9seemHidrA+RhxausVCqxJ
 VSTXO1OT+UG
X-Gm-Gg: ATEYQzyg8PJA9CU+RjtMxqLpCxePz5xs2xB1QKbmQE5bLeld0s80JxMt+4Txh+tGb0D
 9PC9b8w76oGSVMq1H0riS1zCusLwgyMQtDbdrOeQBvrBBHaqW2SRHwPebcQIqIpdhAnwjalrnMk
 3o12vAeW8PAlxF/XCFxTm1QgOsDLemxqXKWRpyudzzyDjB58WjRBSGzLwSMJJ/J0TdysOOPVK8J
 gMGn9CYMqG+vjMiabjtU18zuwEZc7AmhuuGT/V0ntgdI8MMv2MzNJP7Xf1CZWLKep5q/QkdXBCh
 Kd0q0lyNLH+VAhMUI4mlH3H5Y6ytqlA+sbMQs1+jXFKzQmiqw1C3SymTY30gs24l7YTzoLQHGTA
 JD2NyOcSDS+8uSVntZjBRGGrL6ysirxe9h3CPJPDpaxQ0rRglj5CEuorrB7XxWay2IDJihbV0sA
 JbGztimD8AEHvCwLn5L5F70ay4Aq94fnR2WevQVfNe0il86ZFNXW4cIaEdwEL6WLZ8rPX1K/qTS
 Q==
X-Received: by 2002:a05:6102:38cf:b0:5db:fe41:747b with SMTP id
 ada2fe7eead31-5ff32393a55mr1988456137.18.1772221250589; 
 Fri, 27 Feb 2026 11:40:50 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
 by smtp-relay.gmail.com with ESMTPS id
 a1e0cc1a2514c-94df64dfca1sm527902241.3.2026.02.27.11.40.50
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 27 Feb 2026 11:40:50 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1279637cf55so2491260c88.0
 for <dev@dpdk.org>; Fri, 27 Feb 2026 11:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1772221249; x=1772826049; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Q7VCYnd4LYWYnhHYOB+oDw+7UZpV4Vdr3nl6HAyAOLE=;
 b=DGBBeDCCkyYXkBIFpKzn6UnoPwkvarrycuR5uSZXyRcmWt8h8lOu9+CUbjIZvMSjau
 QXlmMe7ITNzO9vRQIQHQsoGRnnFmUnp6puh+i+TwOJSaA44vxzfcTdq+iAurZWiL54sv
 h1dhizvKwSIPHF6Ps8bl2HWtKKD5CyLuFy4GM=
X-Received: by 2002:a05:7022:7a5:b0:11b:ca88:c503 with SMTP id
 a92af1059eb24-1278fc9a69amr2009733c88.3.1772221249345; 
 Fri, 27 Feb 2026 11:40:49 -0800 (PST)
X-Received: by 2002:a05:7022:7a5:b0:11b:ca88:c503 with SMTP id
 a92af1059eb24-1278fc9a69amr2009717c88.3.1772221248652; 
 Fri, 27 Feb 2026 11:40:48 -0800 (PST)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12789962f89sm5255009c88.0.2026.02.27.11.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 11:40:48 -0800 (PST)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Keegan Freyhof <keegan.freyhof@broadcom.com>, stable@dpdk.org
Subject: [PATCH] net/bnxt: fix clang wcomma warnings in ULP
Date: Fri, 27 Feb 2026 12:42:00 -0700
Message-ID: <20260227194214.70456-1-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

From: Keegan Freyhof <keegan.freyhof@broadcom.com>

Fix compile warnings seen when using clang with the -Wcomma flag
in the bnxt ULP driver code by replacing commas with semicolons.

Bugzilla ID: 1807
Fixes: dd0191d5e70("net/bnxt/tf_ulp: support Thor2 ULP layer")
Cc: stable@dpdk.org

Signed-off-by: Keegan Freyhof <keegan.freyhof@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <Mohammad-Shuab.Siddique@broadcom.com>
---
 drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c
index 38cb5c8b31..bc347de202 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c
@@ -1296,10 +1296,10 @@ ulp_tf_global_cfg_update(struct bnxt *bp,
 	struct tf *tfp;
 
 	/* Initialize the params */
-	parms.dir = dir,
-	parms.type = type,
-	parms.offset = offset,
-	parms.config = (uint8_t *)&global_cfg,
+	parms.dir = dir;
+	parms.type = type;
+	parms.offset = offset;
+	parms.config = (uint8_t *)&global_cfg;
 	parms.config_sz_in_bytes = sizeof(global_cfg);
 
 	tfp = bnxt_ulp_bp_tfp_get(bp, BNXT_ULP_SESSION_TYPE_DEFAULT);
-- 
2.47.3

