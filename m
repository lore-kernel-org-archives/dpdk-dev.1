Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B7AE909AE
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 15:07:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75DC240696;
	Tue, 17 Feb 2026 16:06:51 +0100 (CET)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52]) by mails.dpdk.org (Postfix) with ESMTP id D593240674
 for <dev@dpdk.org>; Tue, 17 Feb 2026 16:06:48 +0100 (CET)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-436263e31abso4171883f8f.1
 for <dev@dpdk.org>; Tue, 17 Feb 2026 07:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771340808;
 x=1771945608; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PJXeVs+lasTY0+ponRF9AZQ3EPxvNYE7zF0zlbtHtF4=;
 b=mixvCuDDxlx8+J95s+zBSp3zo93alebQ/YEg+W7R2D+3jypeNjdhZU0rxBd5k5VDT/
 v1Xdz8PRK9KPSWZG5jBKPRCmXRu0190mPORzD8qfr32tyo61ujZec//WAjgIAEt/+24R
 +Y3oxchoNpl3JRfhFi7nd8JtOSVpN3hFEIQaddos915LfjJupm/POFutrf+fo69HLK3W
 Sjltd1ODIOO0Y4FePJD2M1bfMqyKMbT3yIdfmTCK3K4qZraVnRTTI06P+hKITrEw70Gm
 47g/WuWJRmfesKBBE7NCFs4DonRotHmk3RzogI7SZSXVGFq5mOVuMjeuLzlrm0c2xZGX
 1/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771340808; x=1771945608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PJXeVs+lasTY0+ponRF9AZQ3EPxvNYE7zF0zlbtHtF4=;
 b=oq4yjXXySSGzSk2ScV2wxONKxQ5+ZdkbmJGHnMArKP4sVtvdNatSXAvZvZPxqg6tcS
 FnO6hSYwdTvcGToGIswiKMJnfmO1l2Oy4wfmeNqay+Pj+dfE19STYxMUH8lBIqRkujdz
 qPGYE6uGe58+zAGQMGjzD8cHJRnE/iIg8BI20w0hg/Q6xXx76vtQZwkJGgtkIEctq4pK
 3Gh5geEt4Ui5nWnJgXBwqlI6MsZ+v8Mu/BGLxjMomYeKf1hSqL6hS1s7bKzhTuDzrKXt
 m0EFxq7zcPmJ3dlzmRomvXxdBiVGSg8Hl9c3r/c3umR6JOjZkzx/LIaHE6lz3GoKwMzZ
 6sWA==
X-Gm-Message-State: AOJu0YyZn262j3L1lTD9vGICZYXPjtM6GYoUTeLfyrs838vgOLQ2zC9O
 DLsJwUU0/kslVPd5IOCPgov5eJgxF4TtCH6RN0EWRM1E4J+T1MHtMiZ9BFdUdWgNlvthhs0TPKg
 Zd2t0
X-Gm-Gg: AZuq6aIVqJP9XOGw0wqCUvoGvknRPrLQEVtack1w3UZRHR6hafGThRWrm2ld0Q3DBrS
 EPVuxvJXGCoGhGqW6Qf8Uk+1HnltrFBlFuveHnE2pvSKdOo2378NeRTgu9LyVhXIzPADkOXjaf4
 EJ/ZesOzwSlt/fz/U3MeQxHCCJisIiE34Y7Eme4UxHWWqZZyBtV0rbbIVJh1h8tNB6/afc//z1l
 4lazBdpnYW3lAAOLDC1O/NeHK878fUcPErrGYZqjV7Q4Ep0LTIExFce9Vwcum024hedtqcfDPru
 N8iDSOZi116P11Vi7vbxeDCAQ7bPrP+cV+NgAgQEtxLKpBST86JLeXsMST2QLJJARu2czIGJ7c3
 bdlgqZbKQt73WwwA0Bpfo9decV7MD5Tf6+vbPTuwjKdBGSddXD3e59Ub1fA+qD8hiLNvxBD2uRi
 174P4kVPPLUJl0sSAyzLZZ3BQpsxIf+kr1XKu1BiHq3SbSfyhEI4zSxVwUjW5+DA==
X-Received: by 2002:a05:6000:438a:b0:437:7177:8f04 with SMTP id
 ffacd0b85a97d-437978d5247mr24171379f8f.14.1771340808132; 
 Tue, 17 Feb 2026 07:06:48 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a6ba57sm28492012f8f.15.2026.02.17.07.06.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Feb 2026 07:06:47 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [RFT 4/4] net/mlx5: fix counter truncation in queue counter read
Date: Tue, 17 Feb 2026 07:05:02 -0800
Message-ID: <20260217150635.134031-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260217150635.134031-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260217150635.134031-1-stephen@networkplumber.org>
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

mlx5_read_queue_counter() casts its uint64_t *stat argument to
uint32_t * before passing it to mlx5_devx_cmd_queue_counter_query().
The query function writes a single uint32_t, so:

  - On little-endian (x86): only the low 32 bits of *stat are
    written; the upper 32 bits retain whatever value they had
    before the call (stack garbage or a stale value).
  - On big-endian (PowerPC): the write hits the wrong half of the
    64-bit word entirely.

Use a local uint32_t for the query and widen to uint64_t on
assignment.

Fixes: f0c0731b6d40 ("net/mlx5: add counters for hairpin drop")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/mlx5/mlx5.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index 71383f2ac7..4e0bc26754 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -3783,6 +3783,9 @@ int
 mlx5_read_queue_counter(struct mlx5_devx_obj *q_counter, const char *ctr_name,
 		      uint64_t *stat)
 {
+	uint32_t val;
+	int ret;
+
 	if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
 		DRV_LOG(WARNING,
 			"DevX %s counter is not supported in the secondary process", ctr_name);
@@ -3792,7 +3795,11 @@ mlx5_read_queue_counter(struct mlx5_devx_obj *q_counter, const char *ctr_name,
 	if (q_counter == NULL)
 		return -EINVAL;
 
-	return mlx5_devx_cmd_queue_counter_query(q_counter, 0, (uint32_t *)stat);
+	ret = mlx5_devx_cmd_queue_counter_query(q_counter, 0, &val);
+	if (ret == 0)
+		*stat = val;
+
+	return ret;
 }
 
 /**
-- 
2.51.0

