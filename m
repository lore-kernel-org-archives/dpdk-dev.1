Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5E6C02199
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 17:20:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03EC040647;
	Wed,  5 Feb 2025 18:20:12 +0100 (CET)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com
 [209.85.210.44]) by mails.dpdk.org (Postfix) with ESMTP id EB1F840647
 for <dev@dpdk.org>; Wed,  5 Feb 2025 18:20:10 +0100 (CET)
Received: by mail-ot1-f44.google.com with SMTP id
 46e09a7af769-724d1724657so590500a34.0
 for <dev@dpdk.org>; Wed, 05 Feb 2025 09:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1738776010; x=1739380810; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=onggoaSB4OGPwR+btJrL8sA9fW6PZ0Eyq7UEXHv4zIk=;
 b=fhjdW54HVWcPfa4F54+z3pytqrgj8MXyRMpKp93BAtRgNQZxAiS4dPpAFFxUU7vyDl
 z3RLIZ5K7/S2zWUalhTR2wmxyA6QgTqEC7n10unjnorQ+HawcscV12C5KhAFzzGk8zA6
 gzq5GS2Psv9fjqZ1MMO6UwWDF6thDpTrtWkPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738776010; x=1739380810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=onggoaSB4OGPwR+btJrL8sA9fW6PZ0Eyq7UEXHv4zIk=;
 b=oDTAjLF9Mz7B0DXilOmYeC4SeYk8haUKTKAhf1PW1tS/ithHr5hPmgXosvYpnoFxrj
 A1gweOcScEGWVfE3s1396RzOF7zzm555Me1qHebJ+Dljj86LUNZok8pI3NYc9WWDXzQy
 xZrkZ5IEWO2QBYgO63lnNCkDclXgS6hPHKn9wBe+gREQSDB6yzqOamUAgVYti7MHQ1YS
 hIdsL57EmB3ihk3Um96G6GaoxgKFR8mrmABOtoMhnVqQ7een5ezfWjHzLCcf4TdrdB0a
 T5tuniAGZX4EAe2Ayd+gwF47hMjcOsN8iKNKr+qvW3FVGXIrj2uR4A8BqQbLd4tKASt/
 Ltzg==
X-Gm-Message-State: AOJu0YyhZxNNllZIy0aq1jSRvcoCrqKvdMfMx9/z9j5XRmJJhWkRNXUC
 W4q9SAQCcZc3e9eMmY3r+VabhxyDYymH3t8POOYd9YQEfvsrjrX0B8hN+TFh5OlHbD1CwU/3hnT
 K7Lv7Uxfce87ki1Sa1W6RHfWMsBzM0RjUDDB87GMrryf3WuwWJht7TTxD+wMyEIAlOu8FdcojwL
 04qIY8ifjBTvvm0kczZCXa+FCpahYr
X-Gm-Gg: ASbGncshsEwc56tlH1NpEIxMT2EGJH3Q/G2YKq+uhuFmrVGMmqUSqkWULzNYGUBXeml
 zwFAx1gbI+xMlSqk50G6niPfClSulqnI0VUDgSTKynaXUKcxtEWtzrVNpsM6y52KB7LA0bwqW+3
 dCIq2mwlfCofh20qg5WTcjFkv0KCB1r/7lRTloe0X4tG0VfGrj0o9LGIZfAXhbejx6kj8+tS6jK
 bIkAmNOfA0u8g0BOBHNXUXK2vzmvJQdzpFCwJ8alJfr/QZMtTT28y73jnHYSNKDDptSMyYT0SLL
 5bskZqr3ZZF36z/YK+pleevpZbvGtMrVFwt4bFIsVPrC08jebaCLRyqVyO9O/1Odh1tdDmgaNWi
 /ggFG2e2n
X-Google-Smtp-Source: AGHT+IGHumOp4DSSsfY2c9bzqig2GwkKHT8NNyBdnAhavPZnTFnmIOmn3jv4AdZP0Dg14wabHP7lfA==
X-Received: by 2002:a05:6830:63ce:b0:710:a425:d6b8 with SMTP id
 46e09a7af769-726ad72b73bmr62459a34.14.1738776009941; 
 Wed, 05 Feb 2025 09:20:09 -0800 (PST)
Received: from C02GC2QQMD6T.wifi.broadcom.net ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-726617cde49sm4004016a34.27.2025.02.05.09.20.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 09:20:09 -0800 (PST)
From: Ajit Khaparde <ajit.khaparde@broadcom.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH 01/11] net/bnxt: disable TruFlow if compressed CQE is set
Date: Wed,  5 Feb 2025 09:19:54 -0800
Message-Id: <20250205172004.50395-2-ajit.khaparde@broadcom.com>
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

If a user selects compressed CQE mode using the cqe-mode devarg,
it is clear that the user does not intend to use TruFlow mode.
Since host backed TruFlow setting is enable by default now, disable
TruFlow during initialization to prevent unexpected behavior
when the two get enabled.

Signed-off-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/net/bnxt/bnxt_ethdev.c | 5 +++++
 drivers/net/bnxt/bnxt_hwrm.c   | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index 21e9aa902c..81a7723c7e 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -5785,6 +5785,11 @@ static int bnxt_get_config(struct bnxt *bp)
 	if (rc)
 		return rc;
 
+	if (bnxt_compressed_rx_cqe_mode_enabled(bp)) {
+		PMD_DRV_LOG_LINE(INFO, "Compressed CQE is set. Truflow is disabled.");
+		bp->fw_cap &= ~BNXT_FW_CAP_TRUFLOW_EN;
+	}
+
 	rc = bnxt_hwrm_queue_qportcfg(bp);
 	if (rc)
 		return rc;
diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c
index d015ba2b9c..305c419051 100644
--- a/drivers/net/bnxt/bnxt_hwrm.c
+++ b/drivers/net/bnxt/bnxt_hwrm.c
@@ -1731,7 +1731,7 @@ int bnxt_hwrm_ver_get(struct bnxt *bp, uint32_t timeout)
 
 	if (dev_caps_cfg &
 	    HWRM_VER_GET_OUTPUT_DEV_CAPS_CFG_CFA_TRUFLOW_SUPPORTED) {
-		PMD_DRV_LOG_LINE(DEBUG, "Host-based truflow feature enabled.");
+		PMD_DRV_LOG_LINE(DEBUG, "Host-based truflow feature supported.");
 		bp->fw_cap |= BNXT_FW_CAP_TRUFLOW_EN;
 	}
 
-- 
2.39.5 (Apple Git-154)

