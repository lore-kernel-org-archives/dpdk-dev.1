Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03534C87FC5
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 07:39:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F7D6402DA;
	Mon, 21 Jul 2025 09:39:09 +0200 (CEST)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by mails.dpdk.org (Postfix) with ESMTP id 2263540281
 for <dev@dpdk.org>; Mon, 21 Jul 2025 09:39:07 +0200 (CEST)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-749248d06faso3362784b3a.2
 for <dev@dpdk.org>; Mon, 21 Jul 2025 00:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1753083546;
 x=1753688346; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LwnkSV9SG4X8aL4cCaNNDVn4J/db+CGR4ovtCls+A/o=;
 b=tqQbvpAAMtfu/jyY41yBYUwnBn/DCLtrQMV0u/GBHO8t9Pdmk+7ElinCxNnK4uUmBL
 Mn4oxA/aufVpMwn9A3ExO3j9231bv+BsCfAuGJNhZnwOWendEzlKVOO/5ZQGQqMxjw6J
 q+XV5oaDkMqVD9/rJVSK42KRohosYMxw9kRVDfXlh8axvxQ03qq0kGnwey3xjxc5usSf
 vOkkKIF6Q5NSAOSOcJUbTYjE/8V7yLmNv/3SoRrN3ctLWea3UdNVsbZI+T4Beg7SdNAm
 gTbywiVHC22JrOKbHnmm16FZCRFv0z7akrgTgd8ZGSkpRMjaKWMloXjIz4Jc0yu+cTWy
 Uf/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753083546; x=1753688346;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LwnkSV9SG4X8aL4cCaNNDVn4J/db+CGR4ovtCls+A/o=;
 b=INzdAR+81ydeq4yg+ZbGhZWHHQpE8wrO3KD3/D1H5LOPAxhRXpFcUKQ5c1i25tRAo0
 uVfJkbcUKhFFtd340lZqmPBV7mH2zjSLw9dz5+pstOXmM3uclx9WX92qkxnYERANtTQW
 CIAAgFhrgt8v5j/tzXc5FgwKAag+Yti/Ir9NewjUFTHfnYBr9BB9VWqnT+msFVJqtkjd
 KiGL+0Up4Agg/+NZbO4g12Y9/YZj+FtjzDxf7H+kbtfdSP9lnC+JMpu5TkiRIDGdnNna
 d2j0Eb9vpshYfk4GwHthETToMSHDx9Awsu31cY+lU/Ovn817aEQtxCpsWfaz/QaoYQD8
 NBVQ==
X-Gm-Message-State: AOJu0Yw8JEGA/cMEdlnYl3aUzcIXGKqWIp7LuM9bhY1MKRM2a3608ee9
 KO1lvg+MzF3IeBWs3gtMaChlXe2L/LA9baPYsoRFsn1AoK88/Pr2dTliK4yglCqGM1V3KSxqh7G
 r+7BU
X-Gm-Gg: ASbGncsoMi2xv1cEn6cvfznlZgppvmPnmh6kUzh0Sngfoe2TwtEn2anZi6HUAnwCWdZ
 LH+Q02tM92B6uCYgNTnQeRwtcWhsX9d+XsZc6dm67c9i537JaHTGwNfQRdTg37X2lxJH79gJLVx
 jj7pSw9XEDdq3u2h8N6UeGhwwjb4UufKhauQL/GRebkVAWVNYeUGQEfHXvcmTW6Z81/2ALY1yDG
 NuFSAbPU6ey2YukdlwJdDuFFcXCjsM8AipHQEOkbk+pJy4XCJyhPTqaXUFqizqm5NvsASFmUusx
 iMwKH1ZzUGsp+7bQstU+G4xvt7+dksyFXKCNsgsqVgEa8GcNdBUjRWrx2LDXbV5BG5zkW2FHkmV
 gTVtnbogS3DrU9RePptB7LHdVXMo0h2Z94zLYcDzKUs8pQ1si
X-Google-Smtp-Source: AGHT+IECsJS0U/lhxFno+YaJk4qiq3LExfJYs7RCfmKwcXbLAmGk3Rcg+cmChmBG6jBye8ZSExdycw==
X-Received: by 2002:a05:6a00:2293:b0:748:e585:3c42 with SMTP id
 d2e1a72fcca58-7584a957f1amr18888263b3a.15.1753083545944; 
 Mon, 21 Jul 2025 00:39:05 -0700 (PDT)
Received: from localhost.localdomain ([64.62.143.197])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-759c89d693asm5235559b3a.63.2025.07.21.00.39.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 00:39:05 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: dev@dpdk.org
Cc: rasland@nvidia.com, stable@dpdk.org,
 Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Subject: [PATCH] net/mlx5: fix crash when secondary queries dev info after
 primary exits
Date: Mon, 21 Jul 2025 03:38:51 -0400
Message-ID: <20250721073851.963141-1-14pwcse1224@uetpeshawar.edu.pk>
X-Mailer: git-send-email 2.43.0
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

When the primary process exits, the shared mlx5 state becomes
unavailable to secondary processes. If a secondary process attempts
to query device information (e.g., via testpmd), a NULL dereference
may occur due to missing shared data.

This patch adds a check for shared context availability and fails
gracefully while preventing a crash.

Fixes: e60fbd5b24fc ("mlx5: add device configure/start/stop")
Cc: stable@dpdk.org

Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
---
 drivers/net/mlx5/mlx5_ethdev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/mlx5/mlx5_ethdev.c b/drivers/net/mlx5/mlx5_ethdev.c
index 68d1c1bfa7..1848f6536a 100644
--- a/drivers/net/mlx5/mlx5_ethdev.c
+++ b/drivers/net/mlx5/mlx5_ethdev.c
@@ -368,6 +368,12 @@ mlx5_dev_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *info)
 	 * Since we need one CQ per QP, the limit is the minimum number
 	 * between the two values.
 	 */
+	if (priv == NULL || priv->sh == NULL) {
+		DRV_LOG(ERR,
+		"mlx5 shared data unavailable (primary process likely exited)");
+		rte_errno = ENODEV;
+		return -rte_errno;
+	}
 	max = RTE_MIN(priv->sh->dev_cap.max_cq, priv->sh->dev_cap.max_qp);
 	/* max_rx_queues is uint16_t. */
 	max = RTE_MIN(max, (unsigned int)UINT16_MAX);
-- 
2.43.0

