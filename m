Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20582CEBF80
	for <dpdk-dev@archiver.kernel.org>; Sat, 15 Nov 2025 19:38:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C8C7410F6;
	Sat, 15 Nov 2025 20:37:58 +0100 (CET)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mails.dpdk.org (Postfix) with ESMTP id CD7CB40E13
 for <dev@dpdk.org>; Sat, 15 Nov 2025 20:37:54 +0100 (CET)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-b994baabfcfso1888008a12.3
 for <dev@dpdk.org>; Sat, 15 Nov 2025 11:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763235474;
 x=1763840274; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DXcx0/e40zWSpv0HdJY3T5V6v0mTRv2tMcQZs6xwfQs=;
 b=FGGzPOUXN5s16+v7EKyYXA4ckHeKZp2L1q3RBw7snFwWR4SGfA74dcNsE7nMgOiGi0
 Eeh7J9LTeQKBceD4RuNtkMoe+Iq0E7zABL621WqXqhH8udn0nOF2Yk4XadzDBrL+AYws
 yWYIP3U+F/1POvAWDxt8z/3kueeNGt2LV8ZaKUbwo7mcXz8Yb9hFS0HB+OeC/92wQhqh
 Yw1mcoIiS46du/3ZoIkZ836qo/qTnD7YxVKJYAjtwdsG7Ov68MTa6keYFWurTflgQWGo
 /QTpTSNECBhoQPXeBVk5D+3mAWnu5mm4fbq98byvVLESzzRvvcUKsH/CF5axErCQZZ1R
 ZLhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763235474; x=1763840274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DXcx0/e40zWSpv0HdJY3T5V6v0mTRv2tMcQZs6xwfQs=;
 b=W61R0FPDURweXRsLlYU0TBElWvgTH/9Ri4QCuv814Sno9QX/HGEYHkps6XIcNB/QJ6
 MGYFQ/6IXWhjZvcuxlhZrT73uu/DhiIJcnRLX6PzaTbJk7vmuNta4jXZCUe6+7suMVS5
 NYP1HpfvG7YIv88eSDiZWTZlwtIZwVhYL5Sqf0rmkAADvoMfz5BJ8NCP+ID6FU6CPC4i
 oLEB5oHHIQJ4V8QRHkYcAOf1ftgxl0F2l+BAaG3tXoc9RK2yefOKJ7eIamdGV9j4QVdY
 Kgwo760+EAL/qnNdJMXVz6FRhXv/t4bEpbVQzdi19eOgIe0mIo2BoxDBhAGGcaw6q0WM
 i61g==
X-Gm-Message-State: AOJu0YwSIW2+D9QCKMa4UhX/YnLsJqdlnCWJruLkj1mF6ghcZPBm1ByF
 +64aKO5jjkhsWLUVLiFd7oOC6vOOpa0mK0flF/0EMRiZBZI6iGu48TpIXjjGii0N0UvYoTpNGO0
 hRdZl
X-Gm-Gg: ASbGncudFdGv6PZBCEQA/bQqbFdMc5ycl1YIjR6jA4THpVK+f3XEKeBoafLNsN/dJ9D
 A9oU/n9R05knW1qIlCZkhFcVrqBSHR6zFi20tmaIWc2Zx4TbvW7xsISNQlUCSv8fG9SpTaY0tyB
 DTJPCDplt0A3JLhLvnmDpXf3BClmagaJgx0Hl/hUy60KhKjl5RUInEZx8KCdZEWSveUP9RHJ9oG
 Cpkit9NJkTA8tFRyy/9b9n0ofCeX5bM/La5GTZ0X7HdJBqje6+URVcoFXjPVZNyi2BlWk2uWj3m
 t88gvGq8Agr7FMFJcWLLBpd/B24pGiin+CPHKb2T7TfO0JMFStK8WH/E93qn7vFlMgLofXICLqW
 cYf+uOdsBPappSK6uWKucOJ6V8tHj1lU90zCclUZSfyz+th2Unq9cBaxfvcMhUUSQW96MZYBlkx
 O2kRLMOFnh89K2Rmr+FnlA4YjmaDwuoo0XO51Yzkt6j6OUUOko3UV8fw0SB1Fb
X-Google-Smtp-Source: AGHT+IFrmSymY/xcaAaX+bmLY0xwY20dWMtKWcHAltXyFOtEXsGtrRdnrIQugXYvjTsm0KEq2Q7lFA==
X-Received: by 2002:a05:693c:805c:b0:2a4:5ce8:44d0 with SMTP id
 5a478bee46e88-2a4abd7764bmr3522984eec.38.1763235473855; 
 Sat, 15 Nov 2025 11:37:53 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2a49d695821sm28753833eec.0.2025.11.15.11.37.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Nov 2025 11:37:53 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v3 1/4] examples/server_node_efd: fix format overflow
Date: Sat, 15 Nov 2025 11:36:36 -0800
Message-ID: <20251115193749.101355-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251115193749.101355-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251115193749.101355-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

If format-truncation is enabled, the compiler detects a string overflow
since the snprintf() is putting ethernet address and new line
in buffer only sized for the address.

Since get_rx_queue_name() is used to create a ring name.
The buffer should be sized to be a valid ring name.
This fixes some format-overflow warnings and also corrects
for future errors.

In file included from ../examples/server_node_efd/efd_server/main.c:31:
In function ‘get_printable_mac_addr’,
    inlined from ‘do_stats_display’ at ../examples/server_node_efd/efd_server/main.c:136:3:
../lib/net/rte_ether.h:248:36: warning: ‘snprintf’ output truncated before the last format character [-Wformat-truncation=]
  248 | #define RTE_ETHER_ADDR_PRT_FMT     "%02X:%02X:%02X:%02X:%02X:%02X"
      |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../examples/server_node_efd/efd_server/main.c:86:33: note: in expansion of macro ‘RTE_ETHER_ADDR_PRT_FMT’
   86 |                                 RTE_ETHER_ADDR_PRT_FMT "\n",
      |                                 ^~~~~~~~~~~~~~~~~~~~~~
../examples/server_node_efd/efd_server/main.c: In function ‘do_stats_display’:
../examples/server_node_efd/efd_server/main.c:86:59: note: format string is defined here
   86 |                                 RTE_ETHER_ADDR_PRT_FMT "\n",
      |

Fixes: 39aad0e88c58 ("examples/flow_distributor: new example to demonstrate EFD")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/server_node_efd/efd_server/main.c | 2 +-
 examples/server_node_efd/shared/common.h   | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/examples/server_node_efd/efd_server/main.c b/examples/server_node_efd/efd_server/main.c
index 75ff0ea532..62c3f4a16d 100644
--- a/examples/server_node_efd/efd_server/main.c
+++ b/examples/server_node_efd/efd_server/main.c
@@ -68,7 +68,7 @@ static const char *
 get_printable_mac_addr(uint16_t port)
 {
 	static const char err_address[] = "00:00:00:00:00:00";
-	static char addresses[RTE_MAX_ETHPORTS][sizeof(err_address)];
+	static char addresses[RTE_MAX_ETHPORTS][RTE_ETHER_ADDR_FMT_SIZE + 1];
 	struct rte_ether_addr mac;
 	int ret;
 
diff --git a/examples/server_node_efd/shared/common.h b/examples/server_node_efd/shared/common.h
index e1ab7e62b7..6726e2031e 100644
--- a/examples/server_node_efd/shared/common.h
+++ b/examples/server_node_efd/shared/common.h
@@ -58,8 +58,9 @@ get_rx_queue_name(unsigned int id)
 	/*
 	 * Buffer for return value. Size calculated by %u being replaced
 	 * by maximum 3 digits (plus an extra byte for safety)
+	 * Used as ring name, so upper limit is ring name size.
 	 */
-	static char buffer[sizeof(MP_NODE_RXQ_NAME) + 2];
+	static char buffer[RTE_RING_NAMESIZE];
 
 	snprintf(buffer, sizeof(buffer), MP_NODE_RXQ_NAME, id);
 	return buffer;
-- 
2.51.0

