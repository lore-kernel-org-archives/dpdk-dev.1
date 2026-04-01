Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78351076387
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Apr 2026 17:13:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B9B1A40A7A;
	Wed,  1 Apr 2026 19:13:17 +0200 (CEST)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174]) by mails.dpdk.org (Postfix) with ESMTP id 7D6DD402E2
 for <dev@dpdk.org>; Wed,  1 Apr 2026 19:13:16 +0200 (CEST)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-2c156c4a9efso29616eec.1
 for <dev@dpdk.org>; Wed, 01 Apr 2026 10:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1775063595;
 x=1775668395; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=U+XlLufJg1eXw42f4uTGeHpl56EtL30oFe3SJXMxttw=;
 b=Ruq8e1FSlR9tL9ACYMP61nqYs/YVU34UdscaLTo2HLuLRHwij4rXbpQ57xcK89XHZ6
 IXzKhG+WauRzKuOd87J2myR43uWKCF/JAJO+FIw8zibuIgu66tU3x5e0O/fKN1F21JAX
 zBe7aFaLHi1dMPm+CT/PVYiISnlPr/MCWKY81REPrxeBISgST7Hq31Nw63GnzMPXnlnC
 3gM32cShaAGtxy0zZjbf/oG43l+HVTgHyEKpDf+3AjB5jOxLmew2enavUbH4X0Oqtwep
 np3IFDSY58ytzNgo2g3ltUCU5PYtKEXl01G4O9FzewN25wTcAgmM/J249LoeT9p4m1+A
 pljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775063595; x=1775668395;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U+XlLufJg1eXw42f4uTGeHpl56EtL30oFe3SJXMxttw=;
 b=rr1+jRhu3NhvhHa5fKFdFoIryNiKGJFi9F7o8Wg2eQXJQke8wvMNiUND3fLf2o5lEd
 cEMncANh+yHOftPY4CjRvjaZsXka9SpDJmrA7qBqqva2GNTkhyL6Js7INvpPym0SP3bO
 jIizbtH5fz2uXvDh/Fz89glUVYbWwULyTDiwpV7Id4fZQ5QmQGmJmorMihnhv8RnbbvB
 Xd2IoIXvKFZM9zVYnHx6+dwVc+Ikw9kvhr9Y7ANBsWKeZvpS27UmlDTA9WPid98cohHC
 xBg6bzpisb8z94RVm16jMiP2pJHhYbr7wc05+U5lgTap3Ssl5UdoUG9RO389LC1nW/rg
 KHkw==
X-Gm-Message-State: AOJu0YyyGal+LUhKD7gTuGk3l7s4mSW/ZQVASx4AiKOJxf5LHpcO/o+3
 6iFcRmaDjssdcY+E8LSYgQQhC/b9kj0eD3hqoCtHVi0jrFyxhWcS1mMtxwnh9Tr0nyjAJ/OmfQI
 MLwD9
X-Gm-Gg: ATEYQzyXzop1mryHnCSuTjGUKXf5SDtDOZgMfzX1UNCs9sb99434uVgpSVaWHqtDZSY
 efKeV3C2bIlWdhwIjEZwqiLn256kvQrQ+89Be7IY39k32iH9uJ9UlJcUWzzuDzNgPRf8unBm3iy
 eV8UhgekSG+yZ5R/lOhb3oMHpcOWFkOElGATUw4Jgm9DRGC/2N4wbp56B2CxrjME21mNJ3YSbwZ
 qXH2RE7Au8n+W4vWSSB2mTNCw4ZFrcL3CZyN/CgO7HUeMM/ODgkMaEws64MuAh3ST+bc7AJsbjr
 s7BkpUQzPSoZoQoxb1GkYoGkDN3Mji9aaJ9C3DpaReK2AQBbuoYfbpHZTuTBRPQkf6VHklQMIES
 BwZze3FJlDQAAQVSdkvW8F/6R1UaIPMDYdZ6AomjRhryIk8TkI3F8GGqnBcA1ujyIZUGF3bUdpU
 58LW3WeHgaI3W/Bmu5S0RqV1PcXpWHim5V
X-Received: by 2002:a05:7300:230d:b0:2c6:2bac:8b1 with SMTP id
 5a478bee46e88-2c932ea99f0mr2310301eec.24.1775063595236; 
 Wed, 01 Apr 2026 10:13:15 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca7cf126c9sm247055eec.27.2026.04.01.10.13.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 10:13:14 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Junlong Wang <wang.junlong1@zte.com.cn>, Lijie Shan <shan.lijie@zte.com.cn>
Subject: [PATCH] net/zxdh: replace memcpy with structure assignment
Date: Wed,  1 Apr 2026 10:13:11 -0700
Message-ID: <20260401171312.292717-1-stephen@networkplumber.org>
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

Found by cocci/struct_assign script

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

