Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B93CCCFA1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 22:19:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A152402DC;
	Tue, 11 Nov 2025 23:19:05 +0100 (CET)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43]) by mails.dpdk.org (Postfix) with ESMTP id 8B3A9402D0
 for <dev@dpdk.org>; Tue, 11 Nov 2025 23:19:02 +0100 (CET)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-343dd5aa6e7so233119a91.0
 for <dev@dpdk.org>; Tue, 11 Nov 2025 14:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762899542;
 x=1763504342; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aAWLX0Q20WkWDTKYitZlfjmbgJj4Qvp4ftVfvvb4FgQ=;
 b=lGSkStr6tsvAZrdbn95I/kGOvT3MSJARTvExbME2vpzJBViWHlf46H3icsB4CQ1PH0
 BYMentQFBSq/G7fB+9MFpi+3KmplOIOYGyWKTtTEtxDxZZYWfjVqGDOUsdHdsIQX37yw
 C5mqIciNJI0SfWITr4hVa72QYRJchGoyTlGuTu3TmN6DqjGkHxaVX4R4xvvOS7EvQLQe
 U4OUI92tPhD00+aHuEwmCom8pWo/OpIttrgajVMMZcudGnY1xiyGr4iv27sn226bOrVv
 Mnvv74iOqebE/mKw87qmXvsbwBqRFr2gWpb870H7FJs7btngZKYEqqtjO4ZPNRXDdxJC
 KWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762899542; x=1763504342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aAWLX0Q20WkWDTKYitZlfjmbgJj4Qvp4ftVfvvb4FgQ=;
 b=P8gEPdULbYvpeVQ1onju45i+97hgjk/g5YHj5vLR/lY+QVnJztq324Clwbsr+sXByC
 HGTTPumVvZAGb5RZdw6nVdsdcMCZ4NALeiK2KFzzUkhBrMPPBLj5rJO2+TJ/poVSprDo
 zKjomdQbQSH3hshDltjF70dkEPd8IX1STh5lH/Uu+2Wdh9fVX+408QWALAVBIUCWQwA9
 JXSDGQHxjJSJACeQqaSZc0De6OsGinjE8W2/idZd8D/ThbMIYgABJR5PnsMf/oEM0R1V
 oFptH0khXP7AzFJYnN4LpFhbiOYG/O+miEPwdOblvleoIXoJCZa39ESNTqoQeZt8JMX1
 u7nw==
X-Gm-Message-State: AOJu0YzVCCBcBEm/AZNxENqUBikkAqOaxZ+/JTtOvE1CyZlVkfFgi0Ew
 2vKd3SNGiYma5SgLSYp2UFhitd7peQ6e/xA9FXtXj2d+UHuzMeWIDrLZ3PErGYjy4cZRzEGTX14
 2qDeR
X-Gm-Gg: ASbGncvXCxRt94Q3qmRZZcvEZMer/Dijvf3EdkQx/eb2aUDHhlSVLtTmOsa3qhTK+KI
 OS9Pfx6cuOdtBCdOo1eLkUGSOGLpo1WUDLdAScj3PVwQEOe3pB6e6r2h2jyj9zwgUuziGMHAqs4
 LlQxfhEMMTzwGrTlFw3D2t4ZlwJmgSuxeLt2cc07u0ylnRwYgZg8wBakifWdhiotG5/RrBv7K5J
 TIcGMz0n5UJI0ia/XbKFddeuTC8NtO7JSb1Fe8Fff9Cg9i4IMd93Zj24QOo37Pz8u92HSsXU5G9
 I8DjJ8D6l8bTNTyrpJpdbjDQyyh5igcAxE1QqpyVbRl+87ZjUQoty9NsCDLEdxKSdEVe+yYnvzz
 MA6hR3NomDbrIV/wTnbgjuufc2vW0c/7DlPd8Gsvi1FHnyXsDmLkefUeoxb98p/wk09IlN47DUK
 ngGLGo86knqupBebU7f7d4ptUZjRZoNRtiuqb5t2A6RKUgHfMKkQ==
X-Google-Smtp-Source: AGHT+IG9k3f8FkzgkAsmW5nIw61tPOKmI76jhWVirWTaI/Ym4t6JYp3JwDbmEBONdJ1vWfEm7TfvUA==
X-Received: by 2002:a17:90b:4a91:b0:341:761c:3330 with SMTP id
 98e67ed59e1d1-343dde8addfmr1040753a91.23.1762899541618; 
 Tue, 11 Nov 2025 14:19:01 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-343e072e5a5sm157001a91.11.2025.11.11.14.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 14:19:01 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Byron Marohn <byron.marohn@intel.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Saikrishna Edupuganti <saikrishna.edupuganti@intel.com>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>,
 Christian Maciocco <christian.maciocco@intel.com>
Subject: [PATCH v2 1/7] examples/server_node_efd: fix format overflow
Date: Tue, 11 Nov 2025 14:17:18 -0800
Message-ID: <20251111221857.443752-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251111221857.443752-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251111221857.443752-1-stephen@networkplumber.org>
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

If format-truncation is enabled, the compiler detects a string overflow
since the snprintf() is putting ethernet address and new line
in buffer only sized for the address.

Since get_rx_queue_name() is used to create a ring name.
The buffer should be sized to be a valid ring name.
This fixes some format-overflow warnings and also corrects
for future errors.

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

