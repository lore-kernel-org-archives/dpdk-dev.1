Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A28C87FCB
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 Aug 2025 13:10:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E28F840BA4;
	Tue,  5 Aug 2025 15:10:34 +0200 (CEST)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mails.dpdk.org (Postfix) with ESMTP id 9EB1F40A4B
 for <dev@dpdk.org>; Tue,  5 Aug 2025 15:10:33 +0200 (CEST)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-76bf3dafaa5so2349771b3a.0
 for <dev@dpdk.org>; Tue, 05 Aug 2025 06:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1754399433;
 x=1755004233; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WGQNzgO9rAaQInAm/9SRboaH1POH7Pt7HHllnYmow6M=;
 b=Iywq7jDj9zjLZ9WINH6r9W3wMpjNOslgOXtgLjnKCRCnM6/dRjUIkqQ9ypGr4S6hzO
 9S9fG517vsNR6K6P+mK9j1/+C5yZ5jsOUEFeJbY96ur0dBzXQ68PWrcNThrO6qQ0D8ys
 eVlcfcOnehPU7Sm6/INsZ6t1A21OQkfm3zAeaQ1QGP4+VNzcqrcJ8t34r4C49g2LNtOA
 h51u3BieQef/+8balpQO2L+e17lqj/pncaBjlrrgv98P3kn2WJOTeNp9rQsZEjvZILoX
 4gCIYNku/jeTn7j+PXA74UZlkOkbcqFqWp49fEYXLEj3mzWXl3COT7KmUYDigmtUrg44
 mdxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754399433; x=1755004233;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WGQNzgO9rAaQInAm/9SRboaH1POH7Pt7HHllnYmow6M=;
 b=hsA+Y7kc9tqJ7oXe0+e/0nJXxlio0+QGfBpGuT2+8K2wpmw1lFeMvxig+stJUqvb7g
 NE9TjXlF+RzSrF6uJG+d0C9047GHK0s4BKmGLS3PlsapZ2325TEvQHdCbSPZwLY1RYru
 iGFwKQ/bI/INdMWDCSqTlW32pxoi0M8aea9WT2qeZ/034itlElKKLKsPG1o65aA+Ddcd
 ZMMRLCTUuyzZ2++maU9spPjmfs05Dls1uD4sE+b3X88NqysKJqyctbPhv3ASEKCHTRYI
 ZLM8sUXujW8PMo1atUwpkvhIn+OVIxQwAJfJsfDICKLhnYWXkfHvxEBTNWAc04p3hsl2
 6DWA==
X-Gm-Message-State: AOJu0YzyDI5AEZ6hx7/OpHW+GbEMJsOoSgKjW3RUR9C2ss7U2b0fUmKK
 wQ4pJfcoZIe6NgsoZkTFIySE9KySjtZeSQ5xr2fDPuIVPQ+u24Zw9PuEUZn4htVaBd0=
X-Gm-Gg: ASbGncum9mMnT4wmYmfsjkESw/0zngEt+PRpot/gJlxBtWfl9TBVb0kMQqO2ELLHcWB
 J6/4YxIRaDE59NOgQLB4GUtmmHzYIOdnW5mAMzTunKdCTgUyGVUpDcvKdwFlpcKgc9a0g3vyKb6
 JoAJQSZGLuxUCZmKRRzHRVO3tb/05SySm1VCvdDoVvFDNu8kYyrRqAtppbeFNuz1RXuSfsqyGS4
 7zgkE9NnRVo9djQMoktAu7pRiLx/jWrXo8fPJBZFgcIfZB/1J8RJfDbOymiFjnhX4+zoqCISvVm
 adBvzYYhRi7i9UFHXvqO682Cqd+V9FNTN0tPwkcvgYCmUzkEIbtcUWxiJ5nWsPKpc62gk+caWny
 mtJg62Z1BiwxCC3h1D/R8DBdsOm1PKJRcBMwgAvm/7B+t1HMn
X-Google-Smtp-Source: AGHT+IFQFlu25QloRC4xxlHp2gITT4EXwPXMpQVeXdVq08LQW6T3RBtpkW2bFexlC+GRyDbNyeJ4JQ==
X-Received: by 2002:a05:6a20:3d1c:b0:23d:e6ec:5410 with SMTP id
 adf61e73a8af0-2401ea7be84mr4610660637.17.1754399432614; 
 Tue, 05 Aug 2025 06:10:32 -0700 (PDT)
Received: from localhost.localdomain ([64.62.143.197])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bd9795200sm11371054b3a.114.2025.08.05.06.10.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 06:10:32 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Cc: dev@dpdk.org, stable@dpdk.org,
 Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Subject: [PATCH] This patch validate a connection tracking state when matching
 'conntrack is' in rte_flow rules. The conntract possible CT states are
 SYN_RECV, ESTABLISHED, FIN_WAIT, CLOSE_WAIT,
 LAST_ACK and TIME_WAIT. Therefore the maximum possible value to match on in
 rte_flow is TIME_WAIT but mlx5 allowed matching on any values.
Date: Tue,  5 Aug 2025 09:10:13 -0400
Message-ID: <20250805131013.476318-1-14pwcse1224@uetpeshawar.edu.pk>
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

This patch validate the CT state item.
Fixes: aca19061e4b9 ('net/mlx5: validate connection tracking item')
Cc: stable@dpdk.org

Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
---
 drivers/net/mlx5/mlx5_flow_dv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow_dv.c
index 7b9e5018b8..750385cd42 100644
--- a/drivers/net/mlx5/mlx5_flow_dv.c
+++ b/drivers/net/mlx5/mlx5_flow_dv.c
@@ -3290,6 +3290,11 @@ mlx5_flow_dv_validate_item_aso_ct(struct rte_eth_dev *dev,
 						  NULL,
 						  "Conflict status bits");
 	}
+	if (spec->flags > RTE_FLOW_CONNTRACK_STATE_TIME_WAIT)
+		return rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ITEM,
+					NULL,
+					"Invalid CT state matching \n");
 	/* State change also needs to be considered. */
 	*item_flags |= MLX5_FLOW_LAYER_ASO_CT;
 	return 0;
-- 
2.43.0

