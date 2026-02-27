Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2F4FD9E3A
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 19:59:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 700AD40A77;
	Fri, 27 Feb 2026 20:59:15 +0100 (CET)
Received: from mail-qk1-f227.google.com (mail-qk1-f227.google.com
 [209.85.222.227])
 by mails.dpdk.org (Postfix) with ESMTP id CC21F4060F
 for <dev@dpdk.org>; Fri, 27 Feb 2026 20:59:12 +0100 (CET)
Received: by mail-qk1-f227.google.com with SMTP id
 af79cd13be357-8cb513e860cso254467885a.2
 for <dev@dpdk.org>; Fri, 27 Feb 2026 11:59:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772222352; x=1772827152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sfT1zWd0efx/NVHPHitp7yQVwRz0yhfFarYghfJBNEw=;
 b=JMzLzp4LipQOXKRRA5wTk57YCLQ3A1rlWS6Kxa4gxr2diUl3sw/x9TLjsFTVEXAAge
 W5n3D3yfVINJdd/Z+1L8ZWNM+lpXZqJ9qZ0OVFixOIs7d84+F4N2RFm6Ymh6+pKQKVy4
 pDOcYYy+8E2toCIgflE0uCH9ewRtp6mUclGxKhZ2CCQEFUigVZFSQLFZMNXWezfYls7B
 Z/5iU2Pcj5k/nxeYpf/MUuMGhwaM968UMcKVCHxeVqLiXM8NzFN78qo3i9CCDMxM4c7r
 oVpGY8MX/mNlKxzxe1wygqO8mil5LjrP6du7YmsdE4r5yorGUsfd8giFW/HWJ7AeZHEa
 SP5w==
X-Gm-Message-State: AOJu0YyXs+heVLVSjc8AGxvBu3mN54b6Erd4lqUVlltlbL6hcfdbIZBt
 S3NUilMGsAO217Ch3JExxVjkmQ6AjfSvGVyFGJHTRmhsHY3Jvuh+nCNPyTKSOzEChsFtb0PwsTD
 hZPtbc3I50pBjKPif43CIhLnpcDImeHdeb2lEQq03862FupZOKPM4nWN62yDQN5yehBrAs8kS+7
 i3ARLfUxJenJ5tqIFnqsqFyNqFJofoxXCbbOB3P5Ul/rXqLii2Od3DyB/hYcj55k42NAs4S81FI
 ndFLdOjiMh4
X-Gm-Gg: ATEYQzwpCcUCztbSsG6/srGZgpi+hJNuAgIbc3Gk4XepXoJ3fWpRHETr8bGaPzmqSR0
 IIB1CEfV2PTNMkxoi2UyYzjzQatdlUVQbVH9wtQENrhHMsT/+4SN509fQ9aH8VXUDSHq37urAm3
 NM1Cg0q6+QLT0tPkpWXa8SUfQLQiJbWO0d1LAFuQM15NdItfi2D/do8voMhb19i2BrjFPGfgEgD
 M7AOoUtBEeI0XhnDrgrAs8Z17UzdbOWXMayKg796d4u3i6fIWm6Wu84Zxj8V3rRdTknmwP6gzfG
 lU7lDXDTT/Mt4aXmqQ3tDjuMuG0ZntGRbHxxgDetxPbIQWSZ+JNb3U5WvPH4sgiXi591/KEBnmE
 N0Xed6R7CKtAeG2DJWpeqVgvw9uR1zc/DK/TYJ2MuDM/JiT4XN7BYNPM+iE8WTtIilitRp38B5M
 p7EDfvP6MpiYDBimdOxHWZfRvRYq4cVkUTLpAg0gBmKjBaoNtFaKITeTK3P8/PWbOk4YkK2sceF
 g==
X-Received: by 2002:a05:620a:29d3:b0:8ca:2ba8:b988 with SMTP id
 af79cd13be357-8cbc8e031a8mr524124885a.41.1772222351866; 
 Fri, 27 Feb 2026 11:59:11 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 6a1803df08f44-899c7374ee1sm5280746d6.30.2026.02.27.11.59.11
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 27 Feb 2026 11:59:11 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8954ac30d79so255921826d6.3
 for <dev@dpdk.org>; Fri, 27 Feb 2026 11:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1772222351; x=1772827151; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sfT1zWd0efx/NVHPHitp7yQVwRz0yhfFarYghfJBNEw=;
 b=QNssmXdBM+RoVOVqy8FRtxldacEP3/3fGeAuiGceRZlacyMEBUJzsNa80X4m3gSKKN
 tqbOp2AT/zE7nKKZ+iHphicVbnyni0+sfz8SSrr5gC1mWOoY5rFjdbIUy1M1Jzfd81Eg
 7UGruINWl8U3D2VdhtqqQHEJE/AVT/uO5SsS4=
X-Received: by 2002:a05:6214:5190:b0:896:f61e:160c with SMTP id
 6a1803df08f44-899d1e33294mr64987726d6.27.1772222351008; 
 Fri, 27 Feb 2026 11:59:11 -0800 (PST)
X-Received: by 2002:a05:6214:5190:b0:896:f61e:160c with SMTP id
 6a1803df08f44-899d1e33294mr64987296d6.27.1772222350443; 
 Fri, 27 Feb 2026 11:59:10 -0800 (PST)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-899c7159c15sm51407106d6.2.2026.02.27.11.59.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 11:59:10 -0800 (PST)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Keegan Freyhof <keegan.freyhof@broadcom.com>, stable@dpdk.org
Subject: [PATCH v3] net/bnxt: fix clang wcomma warnings in ULP
Date: Fri, 27 Feb 2026 13:00:19 -0700
Message-ID: <20260227200025.70591-1-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260227195410.70511-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260227195410.70511-1-Mohammad-Shuab.Siddique@broadcom.com>
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
Fixes: dd0191d5e70d ("net/bnxt/tf_ulp: support Thor2 ULP layer")
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

