Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BE3CA5FF5
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 20:26:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B16A440E3E;
	Mon,  5 Oct 2026 22:25:49 +0200 (CEST)
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com
 [209.85.216.99]) by mails.dpdk.org (Postfix) with ESMTP id 5076940E45
 for <dev@dpdk.org>; Mon,  5 Oct 2026 22:25:48 +0200 (CEST)
Received: by mail-pj1-f99.google.com with SMTP id
 98e67ed59e1d1-3a4a7eb86a4so282385a91.3
 for <dev@dpdk.org>; Mon, 05 Oct 2026 13:25:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791231947; x=1791836747;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RXh8xip+IptBqszd805e5592pRYj304XDLXWxZK/ZmQ=;
 b=MeiN+bkCfzg3SbV2mVFs33CCy1V+g8bQ9g2BDIbPn4qRZ1zGpuKAxirCgTb4Ny8+PH
 FVT3ACDMpfvHGjfgTQ1fNSbj+n8sKF08GMBCBIuqZt8XrfBjm4bDKp2MexhIZli3PDwN
 ZyKh8ALNsSPHR0c7Jr3400gnODLmA3ma0IXX41fyB6bEukr7+Ss8XE+9M8iIYXAjYfxj
 89oT+SwE/aUBJGJ3iyHaqgYJmY/GNpjEUf47UNW7ZDGU9Kb66ujSUSvG2IUolHy9LeDd
 4GiNcHtO0UuU+fh0fQmH0EFiDGGyKOnMiWpF0SaSim2mvU/VpwKkxRQOOyxjiGPbmpTD
 abZw==
X-Gm-Message-State: AFq9FYK39XoTW/uJaObRPW+ZVg+HgZpAeq11wlgge7YBaYydHeu/ZVDb
 QdCrnzxte7ey4+9m9PF/sk5MN4eO+ru6nLJLeshd5DCelOXQUmdTlNH8cENiAgjXbB/ZOGrEZIo
 ymKtTmlmqFSagBzdRx0MEb7OOBzIK/goVqxAqkOYXhG3dbZlxnTfon88QuEGPtwODrgPrPkfSuo
 svYSYgW33YJJBXKHOkF7ALpuopTid3TfRROFsJWHBKE186puEOVJUlsKSGh0W2RT4CqeoBUw==
X-Gm-Gg: AYBFou1EsRqRcYEHuiuG3ql+0575LD4IO25ugHGljuxYKaPp87qtOfLrNmTono7LH5P
 d5gwB4ud6776cVwlABuDZtGq48AGARCsNh2fzeKNuDN/buuk/ijNRHUdlTuCWaGOvWsDI6WThJO
 zpQ/HxbPu3Xr3fvg5GJVDZ8Owv+K/An+WQiGdqkudJ0UzhcT9JvGsTqLib5A/NZ6cIZeYvO+put
 tsS6oUhsfyZmiGeLRDPspezYPFIro89GbhFX5aN0rguQfR6X0ndUlp7tYOceeuqj563Ne5rQtwW
 ZI3RkvZM3nA/ggK/qeaDysM12TiWqNPJZgZBs5/y7uOOO6onT97RjyUEpBinmTZPJGnKsjP5Htu
 GYGS83625c2qts35KJrHzz8H5AtiaNzS1MSZnigwMhsJKRmYbd8JHvO22tYJx88nU5EDLQn4XjM
 XhZkhfkRwWkf08jJypPLf4U+XyEADUEs+iWK4q+A==
X-Received: by 2002:a17:90b:1e47:b0:3a4:c18c:b8a5 with SMTP id
 98e67ed59e1d1-3a6ce96a934mr9899605a91.58.1791231947144; 
 Mon, 05 Oct 2026 13:25:47 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3a842d0bfeasm211631a91.2.2026.10.05.13.25.45
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Oct 2026 13:25:47 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93e49a1d3b1so491235185a.2
 for <dev@dpdk.org>; Mon, 05 Oct 2026 13:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1791231944; x=1791836744; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RXh8xip+IptBqszd805e5592pRYj304XDLXWxZK/ZmQ=;
 b=c6hJ69Lpy97zFlJNGObiGhE+KP21mTPoEhsjvWPaYHSht66ajsAUt38WuooHv0WW2W
 T4+XQXwgHl3t6kQDgNv0JrHHgA6tCeWNupAmhxq1px+QSu8iUa4Hz8IW4vZKWZ/rrdRR
 1++IyIVEkWSR+s8xA9RZMG9prMFyKXdaBinfc=
X-Received: by 2002:a05:620a:7006:b0:939:a1cc:f234 with SMTP id
 af79cd13be357-93ce7a9ea26mr2107140885a.5.1791231944485; 
 Mon, 05 Oct 2026 13:25:44 -0700 (PDT)
X-Received: by 2002:a05:620a:7006:b0:939:a1cc:f234 with SMTP id
 af79cd13be357-93ce7a9ea26mr2107135885a.5.1791231943807; 
 Mon, 05 Oct 2026 13:25:43 -0700 (PDT)
Received: from r740-105-132.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93e7ec673a5sm175458385a.10.2026.10.05.13.25.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 13:25:43 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
	stable@dpdk.org
Subject: [PATCH] net/bnxt: validate direction index in tpm tbl
Date: Mon,  5 Oct 2026 15:25:39 -0500
Message-Id: <20261005202539.18133-1-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.31.1
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

From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>

Validate the direction index during OEM data message processing so
that it cannot go out of bounds when setting or getting data from the
table-scope instance manager. Add a boundary check for the direction
input; the region input already had a bounds check.

Fixes: 80317ff6adfd ("net/bnxt/tf_core: support Thor2")
Cc: stable@dpdk.org

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
---
 drivers/net/bnxt/hcapi/cfa_v3/tim/cfa_tim.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/bnxt/hcapi/cfa_v3/tim/cfa_tim.c b/drivers/net/bnxt/hcapi/cfa_v3/tim/cfa_tim.c
index 72302ac73b..6abed2ed2c 100644
--- a/drivers/net/bnxt/hcapi/cfa_v3/tim/cfa_tim.c
+++ b/drivers/net/bnxt/hcapi/cfa_v3/tim/cfa_tim.c
@@ -83,6 +83,11 @@ int cfa_tim_tpm_inst_set(void *tim, uint8_t tsid, uint8_t region_id,
 		return -EINVAL;
 	}
 
+	if (dir < 0 || dir >= CFA_DIR_MAX) {
+		CFA_LOG_ERR("dir = %d\n", dir);
+		return -EINVAL;
+	}
+
 	if (!(CFA_CHECK_UPPER_BOUNDS(tsid, ctx->max_tsid - 1) &&
 	      CFA_CHECK_UPPER_BOUNDS(region_id, ctx->max_regions - 1))) {
 		CFA_LOG_ERR("tsid = %d, region_id = %d\n", tsid, region_id);
@@ -105,6 +110,11 @@ int cfa_tim_tpm_inst_get(void *tim, uint8_t tsid, uint8_t region_id,
 		return -EINVAL;
 	}
 
+	if (dir < 0 || dir >= CFA_DIR_MAX) {
+		CFA_LOG_ERR("dir = %d\n", dir);
+		return -EINVAL;
+	}
+
 	if (!(CFA_CHECK_UPPER_BOUNDS(tsid, ctx->max_tsid - 1) &&
 	      CFA_CHECK_UPPER_BOUNDS(region_id, ctx->max_regions - 1))) {
 		CFA_LOG_ERR("tsid = %d, region_id = %d\n", tsid, region_id);
-- 
2.31.1

