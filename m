Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F92CCFA13
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 18:22:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F2F5D40395;
	Mon, 10 Nov 2025 19:22:15 +0100 (CET)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mails.dpdk.org (Postfix) with ESMTP id CD2B54026D
 for <dev@dpdk.org>; Mon, 10 Nov 2025 19:22:14 +0100 (CET)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-b9f1d0126e6so21604a12.1
 for <dev@dpdk.org>; Mon, 10 Nov 2025 10:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762798934;
 x=1763403734; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gTnnX2VYnTD1wjebMSeuhwVEawSGAzmvgAX7E+noCpY=;
 b=2Oqvj0Buh0GZokYPGo2/n1VZKaUqQyFZt3mGcXuYDqAUqgHL3lncSSSkZgW5o2ft3L
 YGUF4a9wLZAuKMoYaXl9G+4QK+mC9FFajBbGGAiWDIFt3MDF/CvyouOt5OPJSL1I+7tD
 FFz5tYkkTfaudXKdAMd9jCR/sqz9who4/pEEvs0zmMhhMtSNgDWAhYhdPQxUUu286ttY
 eZnuhYbCfR5jptPL1CkrVlUp7LqQwqTIi+Zqp6AXww9DjY8S5M8tr76SlZwcJCGRNIzx
 q+RNhfXMDVNLWYozJq9fyalDSfWCf5GzlUJ3Cf8krhqf2oW6oQynpkLqnHSgLTtScca1
 ZHpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762798934; x=1763403734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gTnnX2VYnTD1wjebMSeuhwVEawSGAzmvgAX7E+noCpY=;
 b=bw+LDmzDwYecDQLmO5FrPaShrxVJmZwr/JQk4nsgizytZo7Yq86fNvPceZsF5zHJ4T
 w/QW99DLC3woWGMP2gvz+tiKQ5sgd2Kkl2Liby1QEGhGjmdQFNVNVGlZULe0cHWWBhTf
 6z0QJWOat22hb4PbVxaa5KGdjarMSpbkm404dwxT/3H2pjku6DoVdHDc36aBegx8A7vV
 Kyw/KVnRbOsH9naeH5Brh0C0+VGGamczqPL8VojZEZNREcMkTX7sRcCQExQQHQiNhdpb
 JnKDPL8wGXaXzZ1X7icuw1CTmDqQf35DODUFlKokRo3Z84khBfLUiz8eDapi6YG731Sr
 IoIg==
X-Gm-Message-State: AOJu0YyohaCPWasM2L5Y7FqOS2OrM2MU5+cU+mrNRbL0Ex/4Ka9Ifd2w
 Om8zfAtFvhyFtdU9DbHbcdKp26zN+RHK//Lp8DWlx78P5NOG4pG/r1lyh/wtDxkLTDndIqfcr5p
 2Uj2s
X-Gm-Gg: ASbGncvrw0zk7ixzD2qcaha2PAfAre81NP/RW1VIqeyWAYvKJkszrhY/RjYJJqKTta9
 i88ppxGbugwrE+H4qF9ISdV+0ikB0JAUDVxjVEaQb8nL+ksN6idilbJEuxz0YnAzJ/OAQybPS/y
 uqnnWoFgOBtxPtZut3gYkaqgoFDddf531PfPezl0sDl+P2S781ZE2Iwcey6UGoN+69QvmkLJ1Z9
 Mb+xUhxb9jIZH7qtSXnjIw3Y9mBeE+fWtyg/aeHg0QPfUr7x/KjG2GfGBuX4o3eAmI55emODpZm
 tkyyWyCZU220+xM2AxA2tWOuwHVX7Ccoy+XAMyQ0Hy9WGR+z9zSNbGv1oKXRSJoC6wXNXNEZk/E
 rcmDGyGbi8UpEuZSRD+bIn0+wutmAydwpbLQ9GIjNvIxfKxHSIMWgo6f75skZO+rr9VGHtzzdJl
 I12fMTasNNvWwJZVhfQ0mYF6VTDHcvCNhbM3mZMwg=
X-Google-Smtp-Source: AGHT+IGOgGMMp5/JqXkijjCMaZRr7Q5im1/9YohS65ViqhCCHKrI3mQJ7xZXmrLAPH/2g/Yi77ehdw==
X-Received: by 2002:a17:902:ebc9:b0:297:ef0f:709a with SMTP id
 d9443c01a7336-2984094a5f0mr3523775ad.25.1762798933864; 
 Mon, 10 Nov 2025 10:22:13 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29650968298sm156290405ad.6.2025.11.10.10.22.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 10:22:13 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Byron Marohn <byron.marohn@intel.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>,
 Saikrishna Edupuganti <saikrishna.edupuganti@intel.com>,
 Christian Maciocco <christian.maciocco@intel.com>
Subject: [PATCH 1/3] examples/server_node_efd: fix format overflow
Date: Mon, 10 Nov 2025 10:19:33 -0800
Message-ID: <20251110182209.104087-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110182209.104087-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
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

Fixes: 39aad0e88c58 ("examples/flow_distributor: new example to demonstrate EFD")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/server_node_efd/efd_server/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
 
-- 
2.51.0

