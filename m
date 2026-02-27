Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EDE1039880
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 19:52:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4907240A70;
	Fri, 27 Feb 2026 20:52:49 +0100 (CET)
Received: from mail-dl1-f100.google.com (mail-dl1-f100.google.com
 [74.125.82.100]) by mails.dpdk.org (Postfix) with ESMTP id 43631402E7
 for <dev@dpdk.org>; Fri, 27 Feb 2026 20:52:48 +0100 (CET)
Received: by mail-dl1-f100.google.com with SMTP id
 a92af1059eb24-1270ac5d3efso2364701c88.1
 for <dev@dpdk.org>; Fri, 27 Feb 2026 11:52:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772221967; x=1772826767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6Zh3HpZd6ZC7lU7hCYUH4ur8yEJgvxeZTHTdJ9tKmT8=;
 b=UrMd8F8FVrt875AjjHEJNmfwf/EuDg5vWiJqr/m8T8ZMqXSxg4vqpQIeX8juG4OyRe
 lmfo5n81HTTgJ/toFbGgvgkS8IWSAFSRMEsRuRsiWh8jZNQKIyVepLwpU8KveB8xhx4j
 Al4XNO//P4J09Iz3ATZ0/jNhYVRsBbARt2StujKs0KQdNeZkNPgctkmrlVIhb9dkyg9k
 bMQC8HYJUc8E/z0/F2WiFpkfiAFU5oyh7sIQ1iMe8Jc8ksrkjMr7WgyG1czV/pers4rV
 QiKEeQYQESqmeiybTaZppToYsgDYrTD7c9Px2wCG53X5zxnjhfK9bvu52cXW+K1HglO7
 ++xw==
X-Gm-Message-State: AOJu0YzO0cI2Ha2JsH7Z56/CiinMrfOZ3C4EGEo+0LxB9/qFYE7z/1yH
 +bPRPofGD47p++HN/ecugRdvCdQHhXD75vH6l2LDINxjpRU4MwxZO8uHxPi0kApkb7h2iXgxdWw
 R7sJiQPwE+UN3tW0JsPZ/QR+BT+hFvqsEkfdKa5yEzw73n4Ufp6PctBI3ZPoIv6K+Yxz1KAQOPN
 BlXzy6NSQOGHpo0AsvLYiyxC4RRY0FPCnsWec8RJv0QAp/g1l5ltfFAynOn7SJdm7cwrjYZS3io
 ZXE0dQa/CQ1
X-Gm-Gg: ATEYQzyLYWWaD5f9fDdkoZ89gGfxBm2I44SLtqxGHLvaeQgGiRBfsX/evNWCPqCa0mv
 aHI/e5uhJ6B+02Wim0yMvWcf+YRbGCofSmUZMdQYtVEOA/ngWGcyBZzdBqJDwGYhQ0JWPsxaXak
 4L0p5QvDWJNhdEWCZ6ndE/lNpM0XDVOpnDEA5oy3fdlq3oRbmz7SRYmBBTq5LYvnniWYCvnZk8v
 UQ+axexEBU9c1ZhMEMJ67Ip8SwA73Xo22pIfyD3BHnmie2MSbWz4jQqtiUqe3ASXHfIOLFdqm/x
 S1G6mshn6x9aGgHoqygpzCepVU/dOhs1I82RryPpCdoqF5Lcox4I6ijDvHwppfkNx8evG4FMfV3
 gBTBLSLFma5hir1h7hzy7weYNzrs4c0MZRJhM3KtE7Y/GrPIyvBaIrKBOwHqAyQ2C+FsN6GZ6fp
 PeTIsUM0LoKfp4u2IRFl78mQidYF1e5zBjBN566wIms3DNx0fiygjJYlJ6pSCCPuzytEZN
X-Received: by 2002:a05:7022:23a5:b0:127:3214:c862 with SMTP id
 a92af1059eb24-1278fc45752mr1429424c88.40.1772221966983; 
 Fri, 27 Feb 2026 11:52:46 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
 by smtp-relay.gmail.com with ESMTPS id
 a92af1059eb24-12789a3074bsm841134c88.8.2026.02.27.11.52.46
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 27 Feb 2026 11:52:46 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-899c3239a28so26187686d6.0
 for <dev@dpdk.org>; Fri, 27 Feb 2026 11:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1772221966; x=1772826766; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Zh3HpZd6ZC7lU7hCYUH4ur8yEJgvxeZTHTdJ9tKmT8=;
 b=MUwqkHKndr1Okk3U23bFsUtN9uxJY7SibVa/AqlcUJu7UcCvZxX3AJxLjaYz5TI9st
 xUl2BmP3upiET4LjDvVJaf2nQ6B7Q2i51I9WcZiGKIrmMRRAisRF5qElDdBV9Z8Oni/5
 RQGsjABD6irKV/ElpjxDTa28rYXFp0QlzHyTc=
X-Received: by 2002:a05:6214:c22:b0:88f:e332:c009 with SMTP id
 6a1803df08f44-899d1d8957amr65244306d6.12.1772221965754; 
 Fri, 27 Feb 2026 11:52:45 -0800 (PST)
X-Received: by 2002:a05:6214:c22:b0:88f:e332:c009 with SMTP id
 6a1803df08f44-899d1d8957amr65243916d6.12.1772221965244; 
 Fri, 27 Feb 2026 11:52:45 -0800 (PST)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50744ae9313sm51181541cf.29.2026.02.27.11.52.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 11:52:44 -0800 (PST)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: Kishore.Padmananbha@broadcom.com,
 Keegan Freyhof <keegan.freyhof@broadcom.com>, stable@dpdk.org
Subject: [PATCH v2] net/bnxt: fix clang wcomma warnings in ULP
Date: Fri, 27 Feb 2026 12:53:52 -0700
Message-ID: <20260227195410.70511-1-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260227194214.70456-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260227194214.70456-1-Mohammad-Shuab.Siddique@broadcom.com>
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
Fixes: dd0191d5e70 ("net/bnxt/tf_ulp: support Thor2 ULP layer")
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

