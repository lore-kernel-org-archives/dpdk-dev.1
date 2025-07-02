Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425B1C83013
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 12:36:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C307840DDE;
	Wed,  2 Jul 2025 14:36:28 +0200 (CEST)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by mails.dpdk.org (Postfix) with ESMTP id DC15D402E8
 for <dev@dpdk.org>; Wed,  2 Jul 2025 14:36:26 +0200 (CEST)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-748e63d4b05so2869948b3a.2
 for <dev@dpdk.org>; Wed, 02 Jul 2025 05:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1751459786;
 x=1752064586; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=alDVY7o1kp+HQc+3EQnP9c4GU7L8oQqtkfXGNsj7IpA=;
 b=FrBH6nUU37rVrAbHi3eQPUFMvKnClLdaDiCraxRGcQa4UXzkDtrazmoE1OXV78WpeH
 ACd9S4a1Fh5PWsLcB3lp7PiC0dBzHmXj+9zIwMvj08r4syGmOjDdsBppnPzcllGIdvrr
 IhqkXSEQzie/z/gih1W4ERXaKGBBdVHoj3q8NzYSClMxEdNxOMPogDA7UC2X/hDqwh4y
 gE9Ht/NxpKrHOoSx9jFrLAoEP14Ma28WhzWUUhGisiL+661ADCGiHFC+3AFEj+8VRawY
 IHY3X03zfEcm22OwV1HHlOO8QmxBeL+yv03fLzYc7gwst9iQHr12mshpn0PfJCPTM2pG
 fy6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459786; x=1752064586;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=alDVY7o1kp+HQc+3EQnP9c4GU7L8oQqtkfXGNsj7IpA=;
 b=vYIhHYgpvXiw2LwQapAKVjqz7A8bj72W6MIhZOEj51AyNxGoGy84DCg38Ig0ORztMU
 S8chMTUENb5qGqiCCi9MxqhGFMIKH/6AloSTyiuuskELQjY+3MgSVu8uxXD2pandosvy
 1Y8zDM0QEaqv2OQntfkryaMW7IrTGgx1xuUxn2DZLPrxWnrddeccjqk2Lc97A1MUDY/p
 bpgc6o2OwF5O41z5eHE7eHyQIF5Ztwr+lXGcR55L3WM8QRRD9M8u0uox8Kd/GZuttw7i
 kE8PsmoI6e5qvMBbIlOO72OWqgG5cxM7V8/IG2Hn7QRQNxebAK1dhbcSph0VUXdLL/BH
 +uuw==
X-Gm-Message-State: AOJu0YxWM/UOkQzK93aQRYtOC2EX3u/G2N40dWRFaWpPHh4AX8ZqqsT6
 vmEj9Vt6s422uhrvYXf7w/d6bCkiQggUVFYkVXRoBEzJhntWLoI5XyzC+iv+TaGXZitAnrabHN/
 EqhI/
X-Gm-Gg: ASbGncumrwsm8FDPX3j9vcdnlmj9VXQZbqJ6ChXAjyKbQ7UZ+2F+CjHNP3dDVRhrbcw
 fd/j7/nLKKf5ZL/p4x+hpDUaOr15o+8wW6Nrz5N/NNh7kiv0Y9UYsXkHojWAeVgtcOSdkdJDTst
 +A/80/OGcZpe4J9AYDOeDXR73UBAARBBml+on7P26LQcin4/hbIcIniHmymfF4Tx4CxT+pdRJMh
 1Dd3t4nov/i/BtNpeaDTUPT++OS85pZqfpTpC/bWd7nsh/2if1PPO8JGG4LMFeElgGA9q5l8gUR
 2BU5sZMZL4Ulj7mBEJyTGwQAa5RkxDmtH2egi/tSo4/DYAt/klOdWFrr1TRjPdWzI+2aZYiTA65
 EFentK6regshQ
X-Google-Smtp-Source: AGHT+IEx+9TwpcfQl4nFeDWRSxZX3PM2vwhzFn3jF6n3UiGg0Ul9D84Ma5+aMvhZCSFtTo0TToN4ww==
X-Received: by 2002:a05:6a20:430b:b0:216:1ea0:a526 with SMTP id
 adf61e73a8af0-222d7f32a61mr6100460637.40.1751459785588; 
 Wed, 02 Jul 2025 05:36:25 -0700 (PDT)
Received: from localhost.localdomain ([64.62.143.197])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74af557b3a2sm13980041b3a.104.2025.07.02.05.36.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:36:25 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: dev@dpdk.org
Cc: rasland@nvidia.com, stable@dpdk.org,
 Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Subject: [PATCH] net/mlx5: fix crash when using meter in transfer flow
Date: Wed,  2 Jul 2025 08:36:17 -0400
Message-ID: <20250702123617.1814996-1-14pwcse1224@uetpeshawar.edu.pk>
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

When creating a flow rule with the transfer attribute and a meter action,
the driver did not validate this combination and would crash due to
unsupported handling.

This patch adds explicit validation rejecting meter action in transfer
flows with an appropriate error message.

Fixes: 46a5e6bc6a85 ("net/mlx5: prepare meter flow tables")
Cc: stable@dpdk.org

Steps to reproduce:
1. Launch testpmd:
   ./build/app/dpdk-testpmd -l 0,1 -a <PCI BDF> -- -i --rxq=8 --txq=8

2. Inside testpmd:
   add port meter profile trtcm_rfc2698 0 0 5 10 50 100 1
   add port meter policy 0 0 g_actions mark id 3 / queue index 2 / end /
      y_actions mark id 7 / queue index 3 / end r_actions drop / end
   create port meter 0 0 0 0 yes 0xffff 0 y 0
3. flow create 0 group 0 ingress pattern eth / ipv4 / end actions
     jump group 1 / end
3. Following causes a segmentation fault:
   flow create 0 transfer ingress pattern eth / ipv4 /
      end actions meter mtr_id 0 / end

This patch ensures proper handling of the meter action with
transfer rule to prevent this crash.

Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
---
 drivers/net/mlx5/mlx5_flow.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mlx5/mlx5_flow.c b/drivers/net/mlx5/mlx5_flow.c
index 8db372123c..a7b793ef29 100644
--- a/drivers/net/mlx5/mlx5_flow.c
+++ b/drivers/net/mlx5/mlx5_flow.c
@@ -7993,7 +7993,17 @@ mlx5_flow_create(struct rte_eth_dev *dev,
 	struct rte_flow_attr *new_attr = (void *)(uintptr_t)attr;
 	uint32_t prio = attr->priority;
 	uintptr_t flow_idx;
-
+	if (attr && attr->transfer) {
+		const struct rte_flow_action *act;
+		for (act = actions; act && act->type != RTE_FLOW_ACTION_TYPE_END; ++act) {
+			if (act->type == RTE_FLOW_ACTION_TYPE_METER) {
+				rte_flow_error_set(error, ENOTSUP,
+					RTE_FLOW_ERROR_TYPE_ACTION, act,
+					"Meter action is not supported in transfer flows");
+				return NULL;
+			}
+		}
+	}
 	/*
 	 * If the device is not started yet, it is not allowed to created a
 	 * flow from application. PMD default flows and traffic control flows
-- 
2.43.0

