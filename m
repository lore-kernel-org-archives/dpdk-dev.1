Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35672F54AD2
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 15:55:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60983402BE;
	Tue, 24 Mar 2026 16:55:00 +0100 (CET)
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by mails.dpdk.org (Postfix) with ESMTP id F29414025F
 for <dev@dpdk.org>; Tue, 24 Mar 2026 16:54:58 +0100 (CET)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-1273349c56bso5468425c88.0
 for <dev@dpdk.org>; Tue, 24 Mar 2026 08:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774367698;
 x=1774972498; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ojNM0ze0GTAirrZ5S3TbPiZQzmyV/4HovCQv1SxnK1g=;
 b=l/9SBeioT16jKjMXGWufqHSpkbOErsxGP7l7vExx59vnpTkhJoo+iLahqQ354WhQg+
 RtxZ+lrJ0CRVKBTumY6R93v0Td2oquASraFbgiWAO0/20PJyM+0WuZtx11nNl+HsZhMZ
 C/z6w8VGwcS47jx48K5Tqm/Ho18FGDlvu/2KTIcmBSv4iDsMmYOEE6mG0uCkRh++25Kp
 ZqIfoB2Aq/+/QEIL6FpdaexECiktsqWKhN3m9xiqJmyqVBxAw9JRHjE1ev9SWb6B6nWC
 g8A63LbiFhmsY8R0Wz6l3P8oKGU+1BD6p0VUVxlQNwCSYH7Q0ugOAAbeYZ05Ce9AOm4z
 0U3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774367698; x=1774972498;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ojNM0ze0GTAirrZ5S3TbPiZQzmyV/4HovCQv1SxnK1g=;
 b=CBWmvKylgyGJit9lIwDrknTcbTKhet+IMpJ2w4kt+ZuHCy+H9OhXQjv35mPLaHtdrr
 K3J0rQVPoSIBwu9IYuLmu5gk4kun5UXtL5yDInzKD1XkoVs/630i8+Tu+zERmiFRBDnQ
 KnNX6RgfjkNC8xTzDFunKWqmimGX9cp3jX0FSkvbdQkJJSeVzjI0WaAlRtdQrpCe+yHY
 YnMcprNulrE5wNkbX9H9NHbg4Qj/iQomX5E09dHq3YCGxH8khlsThFu/FVpRqKyWJu1/
 OUOxr52h9EQXsdn+JtPEKLyKCp6cYypPFlmq+kugZ0U2Qcg26EbBWzuGY4gNx7sD8koM
 bn/g==
X-Gm-Message-State: AOJu0YwzxT0Y/sgRE28MKG7KaAzDkGjr/awxvbIWlw9/x2py98k1f6hU
 1///lYATvfnqPwl+ssJ/dRvj0S0KTkz46KDA7hwOOoymLBLzPZlrz6BMDWLzKqg4FsiYmcbT85y
 POpp5
X-Gm-Gg: ATEYQzwGEccA/sXiPL/Ekd/eeQ9eKbcwxBlTBfvoA8Qn5dmAFJMPzTX8bex4faThUP6
 RzMXs2jXGk39pYdImZtb67bvDJhmuqfIop4W58S+4CRpYCEPhp+CmJYX3N72K9mzEdlLUeohuHQ
 Bzoq35abB2QXmanhJmghIfZhFQLKmcBPFq4B33n0iV7mYDJw8i0lUK5LcGUhHnuI0ija49msE/C
 h5IhQQWfmwEmPwAot8Uzrf0HQlCJZGdi6zKG+PJs7X+hCO6YdCPq4oRh/Oblp5eFnFYUiOl5FzW
 VJFMlH48iCZN0wz3T6AvL66kKGDpu9DMxT6NX/8dJQRPF2fn3gSFbioG5PERidLSIsFZkwAeJne
 a4rgVV654jklddcyGaV+QAdeYc/Ygbvr1MG6hedj1mt73feDrILcgy8NZH7hR7FraPGVi+dYPbv
 eQIdfKt3V0EhfhEhTkI/kap70sCYxHpguD
X-Received: by 2002:a05:7022:239c:b0:12a:949b:c46 with SMTP id
 a92af1059eb24-12a96eef455mr15143c88.21.1774367697904; 
 Tue, 24 Mar 2026 08:54:57 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12a733e794esm11583977c88.6.2026.03.24.08.54.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 08:54:57 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Junlong Wang <wang.junlong1@zte.com.cn>, Lijie Shan <shan.lijie@zte.com.cn>
Subject: [PATCH] net/zxdh: replace rte_memcpy with structure assignment
Date: Tue, 24 Mar 2026 08:54:54 -0700
Message-ID: <20260324155455.661996-1-stephen@networkplumber.org>
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

The cocci/struct_assign script found where simple assignment
could be used instead.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/zxdh/zxdh_flow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/zxdh/zxdh_flow.c b/drivers/net/zxdh/zxdh_flow.c
index 7a2e20ac39..56ac34c6e3 100644
--- a/drivers/net/zxdh/zxdh_flow.c
+++ b/drivers/net/zxdh/zxdh_flow.c
@@ -1884,7 +1884,7 @@ vf_flow_msg_process(enum zxdh_msg_type msg_type, struct rte_eth_dev *dev,
 	struct zxdh_flow_op_rsp *flow_rsp = (struct zxdh_flow_op_rsp *)flow_op_rsp;
 
 	dh_flow->hash_search_index = hw->hash_search_index;
-	rte_memcpy(&flow_msg->dh_flow, dh_flow, sizeof(struct zxdh_flow));
+	flow_msg->dh_flow = *dh_flow;
 
 	zxdh_msg_head_build(hw, msg_type, &msg_info);
 	ret = zxdh_vf_send_msg_to_pf(dev, &msg_info, sizeof(struct zxdh_msg_info),
-- 
2.53.0

