Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A19E83841
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 23:05:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8023B4067E;
	Tue, 17 Feb 2026 00:05:00 +0100 (CET)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53]) by mails.dpdk.org (Postfix) with ESMTP id 934E14064C
 for <dev@dpdk.org>; Tue, 17 Feb 2026 00:04:58 +0100 (CET)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-436356740e6so4314963f8f.2
 for <dev@dpdk.org>; Mon, 16 Feb 2026 15:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771283098;
 x=1771887898; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eVLyJfxM17TdVjysGpfX0wko6tfcszG+c7F8KIvjWMg=;
 b=cjSRrT2wCBqka3yCIJJyeMlH0P8Q35P8pUkntF7nZSdID7ahg4y8Wt7m1zcwy6iEm6
 UA6wN9Zu1u8FQNiBqz6D4XtxUeDAKmgQYPwFN/gSKVKP9DJUP2iugc3q6AmbwR9WolLd
 dBuStGX0KshWjo2+ITeKhIlco5mvnSo3jwRUmBulVP7fiq6o61wPqwPFC1W0KkuhAhDw
 JFsqGhMfww5M5oyq4dx/43GNcNEgWfWTMJ5OBNXk/pRMMc3Jr+8b3QS2iLPRQ/nrLKqG
 VTgt6koW1uYtq6WTuKnfWfAkggAV9h5mvr1GMXUIOAuJ6h2rPLUs4ZxwCbCd99mBlpKK
 Ruig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771283098; x=1771887898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eVLyJfxM17TdVjysGpfX0wko6tfcszG+c7F8KIvjWMg=;
 b=Et/85D+LtjBt+z8NvqMs6EjIBQrBxknLk7GfVDlguH3FvBxXDRgnzZ+AxYmMhyi2jv
 1AMT87Upj9Q+BD71srl6KCiKU5LfinBpWJBM2b7FlH5SiucfTOvznNN5oXaxQBv6y3L9
 e1SQTysPRdLsm1CF7WuhxqiL2n3eXJuVkwrpWRgXS9yRQa3kj90PlOjNd0LDmT+o48cA
 70LP4plAadjGZiP+dmtpDY+0zYpvBBa6vt7qxgul6WJHagMcapemLE8kWc2LSVlexSOe
 p2FRQiDOxl6DuTaciM0AH7nMaVbmJl3aRU74iBsBzKzyAPARU2GJCOPaV1JzD9MZfhZ2
 wHlw==
X-Gm-Message-State: AOJu0YzUa/qutOasqETRMOS/eigr0Ug5rWAD01iR9e/XkXlS1YT3J314
 dPFwyMP2uSwN4fw4rIbcbob4poY1WUWPEwJUFPpCxDM5DwNn97AgWevzX5bzQ4+yr5ULHfX9Crj
 L7wmtKxI=
X-Gm-Gg: AZuq6aK+t3YYz3NoBdpYO6+xxcc2p8B49nsOZ1vxTSnfqzDl4q11jnqz5uvOXs1Qlkt
 WKT9jlcxDaPp/kNGt4A2oFjVlNq950aynj6VanPcLIF9/RElZusy9vWoHz86hZnpvln6yQRFyN3
 fKt7SCFBwOpeX0tEJfk6vwOWj4UORLz+vOglWB1lqfL/lbGdJ2wpgUamdpTFlK7ur350kDnPDL5
 +1Q9Atdtq3BGoQGpJ9kSwu4At7vkHz/6r600EarHHU8+g+PYiMS9crkvS6t0Wh4vCSFwafWFyxj
 81iOfKqPpDt23PAoJbJ7C6s/zIITtDk3e7rQ9QNeMa3Dz+vOtFQ+Dr4QaaTgfLgd90H5Rauf4v+
 nbhIALaMbfPYCFwwqgDs+emXXVyHb67mV+B40l1VJsZD7ohQ7x7hirukAlFjz45SsV3Z72zYxPV
 0ZCkZLPDwG7Vogs/7+FhQAkdxEojZ1gcHRdz9FIrENKtACuaUd4G1cQFrtyx8ZNg==
X-Received: by 2002:a05:6000:2001:b0:437:6758:ce70 with SMTP id
 ffacd0b85a97d-4379db61f70mr18593413f8f.26.1771283098203; 
 Mon, 16 Feb 2026 15:04:58 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac82f7sm33158867f8f.28.2026.02.16.15.04.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 15:04:57 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v2 09/11] net/tap: fix use-after-free on remote flow creation
 failure
Date: Mon, 16 Feb 2026 15:02:33 -0800
Message-ID: <20260216230437.847578-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260216230437.847578-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260216230437.847578-1-stephen@networkplumber.org>
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

After a local TC filter rule is installed and the flow is inserted
into pmd->flows, failure during remote flow creation jumps to the
fail label which frees the flow without removing it from the list
and without deleting the kernel-side TC rule.

Send RTM_DELTFILTER to clean up the local rule and call
LIST_REMOVE before freeing.

Bugzilla ID: 1881
Fixes: 2bc06869cd94 ("net/tap: add remote netdevice traffic capture")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/tap/tap_flow.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/tap/tap_flow.c b/drivers/net/tap/tap_flow.c
index 9d4ef27a8a..427faf75d5 100644
--- a/drivers/net/tap/tap_flow.c
+++ b/drivers/net/tap/tap_flow.c
@@ -1293,7 +1293,7 @@ tap_flow_create(struct rte_eth_dev *dev,
 			rte_flow_error_set(
 				error, ENOMEM, RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
 				"cannot allocate memory for rte_flow");
-			goto fail;
+			goto fail_remove;
 		}
 		msg = &remote_flow->msg;
 		/* set the rule if_index for the remote netdevice */
@@ -1307,14 +1307,14 @@ tap_flow_create(struct rte_eth_dev *dev,
 			rte_flow_error_set(
 				error, ENOMEM, RTE_FLOW_ERROR_TYPE_HANDLE,
 				NULL, "rte flow rule validation failed");
-			goto fail;
+			goto fail_remove;
 		}
 		err = tap_nl_send(pmd->nlsk_fd, &msg->nh);
 		if (err < 0) {
 			rte_flow_error_set(
 				error, ENOMEM, RTE_FLOW_ERROR_TYPE_HANDLE,
 				NULL, "Failure sending nl request");
-			goto fail;
+			goto fail_remove;
 		}
 		err = tap_nl_recv_ack(pmd->nlsk_fd);
 		if (err < 0) {
@@ -1325,15 +1325,22 @@ tap_flow_create(struct rte_eth_dev *dev,
 				error, ENOMEM, RTE_FLOW_ERROR_TYPE_HANDLE,
 				NULL,
 				"overlapping rules or Kernel too old for flower support");
-			goto fail;
+			goto fail_remove;
 		}
 		flow->remote_flow = remote_flow;
 	}
 	return flow;
+
+fail_remove:
+	/* Delete the local TC rule that was already installed */
+	flow->msg.nh.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
+	flow->msg.nh.nlmsg_type = RTM_DELTFILTER;
+	if (tap_nl_send(pmd->nlsk_fd, &flow->msg.nh) >= 0)
+		tap_nl_recv_ack(pmd->nlsk_fd);
+	LIST_REMOVE(flow, next);
 fail:
 	rte_free(remote_flow);
-	if (flow)
-		tap_flow_free(pmd, flow);
+	tap_flow_free(pmd, flow);
 	return NULL;
 }
 
-- 
2.51.0

