Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4C6C88E67
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:49:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A38840691;
	Mon, 14 Sep 2026 07:49:29 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 011E740685
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:49:26 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-39d654f02baso1349653a91.3
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789364966;
 x=1789969766; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cfQjydVMJGLMuhMyNwx/25nCPKq1mGgZvaLaNSI4Xtk=;
 b=tb+dJiZlEH8I10talMFPPEoqVEYzVLyL4qebX+B5civimkKiiKLPCK+EoqYNZEF/0J
 PNQLZPhPwtR58m0kaesXOeXqsRw0EXi9ZZ0h6lBk8G7mhbiGf9VwUgbXkKrnK4CUgUve
 XTqZnorhkp9jyD+2L3UG3DaPsuUQ6QxPJzPxHUsWfuY8LWgeEvC4Z49B9qCUCUvkBJiA
 QC3PlRm/gkEHatmmgAB3rgfhr7m2hJeL3fwmwnVXTO8+/fe9xK0opVIlj08ev5IYf0n6
 l4dEYnBYs5s1dcK5TRybRB5Aq/Ul5HzVowMKGnL/M/6gd8qS2NpKNCTfp1/lEUx4DPop
 tlSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789364966; x=1789969766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cfQjydVMJGLMuhMyNwx/25nCPKq1mGgZvaLaNSI4Xtk=;
 b=iQBRmcn06ZhlxSZYUltIa+WXmWaJq9iKxcBtU1It0rXso4SXGkNNcn9F5BS4hiRLfy
 m3ibnhq29V1ZTWsZ3qEbLg8RntvHDq9HJdHlInBIYm4xJF/+wG5GyEa0gB4PyIBiELgV
 6sqIuglsbsMXhLGvodl3PSzH8v0uBQYwxktygJgS2yIQwVzDuY7L75fHs1XSh1vsA+lX
 PirNnhec2PT+Anw7tfIPGWzI1tJerrZqqT8hY4P6jj/3zZq0AeX+gCybkYfuThEXFKyO
 jIS9qSEeambOyO/FH5Lz+DUlrYLVJP+68HBA4J5HNTbeAiBBGkO51kAwezPaHXdsZ0XV
 5vWQ==
X-Gm-Message-State: AFuF++mQ4Lo2Y4jVTTNJF+HFSjKyo2c1NTyYM0ihn80BULng4GM8BjfS
 b1ef2p7LJeYavjxwSBq7noq7sv1qfRGeNQMuIHGorXv2wejkHf3QoFUKVKGsdrGLOTEHhiKMcf4
 8ysjP/fw=
X-Gm-Gg: AYBFou2gY3Ox6nw3l1puTVxaOf7CO5d3Xg7gF5dEDu2rv4+q6aITbfSGPT9HnFMw0ya
 sg+ux1VEVuj+sSkkZFBLfoXJWg+CDQTGfzodht3+hvGPTNIx4u6ZonHde118EtJvYevA1cJP00u
 X2WL1EO0sWTNnLa7bg/060S/BquNC/UhdjeQJjV6rWUp4fUypQE8jxIpgDgAjFxoPQY4SUiMal/
 4UgbN0PcZf3fzHuYEPXP1Swi+wrh0qNfE2XVtjpSe2ihJ1xaqRRTKD9PsqIwuCLN25mNELjMIlg
 GzgBvpzaGulM1M/70mvlCqFIGnjfGMA/vswDiMQmcA4+JUv04uz1rodtdvM6gje3c5WZ0FUJQw6
 GdJt6Si83oRejtNp0KzVG3VX9/Rx6ZcukI/QiwXI5QedjheKBx6EwPFmBtxv8LbdYSsOTyzODKy
 Q+Gaml/hGf/XcE1R8e8fu7vFUu7PYRbVfsUvLvmfQ4jyEQ/h73+Xq+hWvXWweIENlyTrl+N9zYa
 19yX6H+10xj3D+nM8ZwBzSJK5QmeJmC2+N2iQ==
X-Received: by 2002:a17:90b:390f:b0:398:c315:fa6f with SMTP id
 98e67ed59e1d1-39dec079f10mr2412135a91.14.1789364965987; 
 Sun, 13 Sep 2026 22:49:25 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.49.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:49:25 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Zhang Tengfei <zhtfdev@gmail.com>, stable@dpdk.org,
 Thomas Monjalon <thomas@monjalon.net>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH 01/62] net/txgbe: fix FDIR devarg integer width
Date: Sun, 13 Sep 2026 22:46:32 -0700
Message-ID: <20260914054912.755403-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914054912.755403-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
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

From: Zhang Tengfei <zhtfdev@gmail.com>

txgbe_handle_devarg() stores a uint16_t through extra_args, but
pballoc and drop_queue were u8. Setting pkt-filter-size overwrote
the adjacent drop_queue default.

Fixes: 7e18be9beef2 ("net/txgbe: add device arguments for FDIR")
Cc: stable@dpdk.org

Signed-off-by: Zhang Tengfei <zhtfdev@gmail.com>
---
 .mailmap                         | 1 +
 drivers/net/txgbe/txgbe_ethdev.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index fcb3d1bb3f..1b52f2caef 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1968,6 +1968,7 @@ Zerun Fu <zerun.fu@corigine.com>
 Zhangfei Gao <zhangfei.gao@linaro.org>
 Zhangkun <zhangk.zhangkun@huawei.com>
 Zhanibek Bakin <zhanibek.bakin@gmail.com>
+Zhang Tengfei <zhtfdev@gmail.com>
 Zhaochen Zhan <zhaochen.zhan@intel.com>
 Zhaoyan Chen <zhaoyan.chen@intel.com>
 Zhe Tao <zhe.tao@intel.com>
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 4d2746371b..814840b3f5 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -533,8 +533,8 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
 	u16 ffe_pre = 8;
 	u16 ffe_post = 44;
 	/* FDIR args */
-	u8 pballoc = 0;
-	u8 drop_queue = 127;
+	u16 pballoc = 0;
+	u16 drop_queue = 127;
 	/* New devargs for amberlite config */
 	u16 tx_headwb = 1;
 	u16 tx_headwb_size = 16;
-- 
2.53.0

