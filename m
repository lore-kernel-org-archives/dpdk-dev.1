Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F09BC021B5
	for <dpdk-dev@archiver.kernel.org>; Sun, 23 Feb 2025 02:44:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E817402DC;
	Sun, 23 Feb 2025 03:43:53 +0100 (CET)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id 867CB402CC
 for <dev@dpdk.org>; Sun, 23 Feb 2025 03:43:48 +0100 (CET)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-221057b6ac4so62607865ad.2
 for <dev@dpdk.org>; Sat, 22 Feb 2025 18:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740278628;
 x=1740883428; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MZ0SQx1hLtpcJGcKbrKNOrkqnuvJXDwLmGbRUPtKHcU=;
 b=EheEw5WcOKtMJv4qXAdHmxGtNiZPdBXbkU8EKUONThJLMGs3sUWCCmoIFj7OKuJXeZ
 v/gbtPQDY8hP2FZ7QWj7aURGkkb4IRZlfB0no3KkhK4uOe4x9gZn+HnQMVXhyjkC2uHs
 ohB1jJ0/g6rDYb6Rh6S3ev3qCpNiacpkWu65Rfsddmam24zwDwrrfqUW7N44tWrGmBM8
 5c1btdgfvLhsZwYUHJopyu/bD9o/FN6r3Vf2IpXZME8557j1PIxshbnmaZ5k1mvnJjSg
 5IWy9l1JbDDsnXlcvi+M4X/iYJ/cpZ87cEq6VGahXwZNKbDOv14BLIZVKolMpBki9PzY
 OYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740278628; x=1740883428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MZ0SQx1hLtpcJGcKbrKNOrkqnuvJXDwLmGbRUPtKHcU=;
 b=o9DiuMKqryTv0fgkXA1uLVxTPsjs5DeqLSDSaSlu7qt5tjeZqrDEtzSsk1Kt8Pl662
 QPXRTCIYEc1KMEd3YcMeM8YMQFTmvCpWu1yMymSlvcF8582Ee4XVccXaS94D+u7eSZaw
 /wac2hqPDRSR6qwUhRgKL7tXAc0JzCEP0CSshp4fpGgVG7wH+s+E+9C2j9nNRzEZbZKG
 sNh5cXw0JMM0s7qEiV1Or7gLBWT6pyoFRpUvPOV/LhW5YFimeqQS24pkz4fn3KUnnFjA
 iG37ueRziIsKhYT2iJAr+vtzN4kWCYi+UpXLYMNNKsa7V4HCNG8H9UrVhLlRdc527dnQ
 OXwg==
X-Gm-Message-State: AOJu0Yzroy54+KWPSoS3XY/qCjFiGHL0krG/4nY1I1otEEhn3I6BuYrG
 8YFkCTVJhVVF5O7ISadaYZKfdGTqS9mb1wnq1uvlPfqZBIrlC3Lgu9NVUUPiUy0c3UZEJvmk4h9
 8
X-Gm-Gg: ASbGnctrjwBBALA+UbSO6n6aMs2XTUW3B99vM/p7RhXUmEesI87xHYtw4b3CW1dcglU
 CFNfKKwmSYElH3KsBoZsH6ukTyxsDLvUN/7U93LkrzZNfbNxaHGohEPJEyBuAc5+HwZvipAKvQo
 YMrfRtCGsC7+DdEtDI4OuoQfa0T0h0Hz5Ndt8V/2F5IsQ+iI3txyb37HM6CVSjQ1teDKfKeJL8T
 PiP3JqZchFgbTn1Mm4hJvwlZ6FXTTUByiKligY1u+e7wzd2rC3aUExrSVjLiWIpaoZp02niEhUj
 pv/YLIpSZgf+rfkAhSFqk1unSucLbLpSTU2VGuNyccyK7w1BHCAf+guxnS1PxDD3Vf78e+cQ3Cq
 /qtM=
X-Google-Smtp-Source: AGHT+IE5ty4GWSSrnmAn6Jt1vW4N3VgImKbeR6lxyFd/rFenLAffpHt6lCzE3l2Rb5V92fDK44Hl/A==
X-Received: by 2002:a17:902:d581:b0:221:78a1:2820 with SMTP id
 d9443c01a7336-221a10ef1b6mr173761835ad.28.1740278627705; 
 Sat, 22 Feb 2025 18:43:47 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d536443fsm156112955ad.66.2025.02.22.18.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Feb 2025 18:43:47 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Junlong Wang <wang.junlong1@zte.com.cn>, Lijie Shan <shan.lijie@zte.com.cn>
Subject: [RFC 3/5] net/zxdh: fix RTE_ASSERT expression
Date: Sat, 22 Feb 2025 18:42:22 -0800
Message-ID: <20250223024334.1216477-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250223024334.1216477-1-stephen@networkplumber.org>
References: <20250223024334.1216477-1-stephen@networkplumber.org>
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

The parameter in RTE_ASSERT() was incorrect.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/zxdh/zxdh_msg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/zxdh/zxdh_msg.c b/drivers/net/zxdh/zxdh_msg.c
index 5a47b4fde6..4cd58ca0cb 100644
--- a/drivers/net/zxdh/zxdh_msg.c
+++ b/drivers/net/zxdh/zxdh_msg.c
@@ -1445,7 +1445,7 @@ zxdh_vf_promisc_set(struct zxdh_hw *hw, uint16_t vport, void *cfg_data,
 	struct zxdh_port_promisc_msg *promisc_msg = (struct zxdh_port_promisc_msg *)cfg_data;
 	int ret = 0;
 
-	RTE_ASSERT(!cfg_data || !hw || !res_info || !res_len);
+	RTE_ASSERT(!cfg_data || !hw || !reply || !res_len);
 
 	if (promisc_msg->mode == ZXDH_PROMISC_MODE) {
 		zxdh_dev_unicast_table_set(hw, vport, promisc_msg->value);
-- 
2.47.2

