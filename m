Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41A7FD9E3A
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 19:53:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A84640B94;
	Fri, 27 Feb 2026 20:52:58 +0100 (CET)
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com
 [209.85.214.202])
 by mails.dpdk.org (Postfix) with ESMTP id 88C8340B8F
 for <dev@dpdk.org>; Fri, 27 Feb 2026 20:52:57 +0100 (CET)
Received: by mail-pl1-f202.google.com with SMTP id
 d9443c01a7336-2ae04f58b19so134434995ad.0
 for <dev@dpdk.org>; Fri, 27 Feb 2026 11:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1772221977; x=1772826777; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=63yf6Yo6+W1Li/TRHdYLTQz6LQgaOMGluJGlDkhEu5Y=;
 b=kmTOFUfL3dhM2WrVlFPB5ZjYrY3wx6aq2VbD1I66U5hb8uWrUeMLAoOl7zg4wC8TuY
 7qNixRSlZ2s2JR5eGeW+3fw+32am3tyFtUlpMzv0l4TgnQGzX5tftCC6dAkNyQi9jH5a
 BqWGJf/DBgbwJtlrFcPvWvRJUdNSa7IPuNAwXZxjBF0Opk2iYefWcfjtq5GJ0aPkstj0
 XUm9dZf0+99K/IxTQKGbn4LQaxocwKQh01hZ37a1orH6eQDBatj5OP2kQwB/UHQSHMHM
 IivXw0cI+tmCJI4XxksUOd/n+vYFXMG2eZgYKoqI1NIrteLy7zKlE/xb6L8DoIz2GdKD
 uwRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772221977; x=1772826777;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=63yf6Yo6+W1Li/TRHdYLTQz6LQgaOMGluJGlDkhEu5Y=;
 b=WBFANrrFykrBzaJjnjMlO8/nDl2qL/zHDtppihhkRm9okbGZcHj+KPagF9JVZFLS/a
 OJuofVidesmR8+wimUmX9OPmY16lzp6tRnjReGKLBeKMRFOCeYwQ51l9OBZME7Vjp0BM
 PDrkbQn0975pJWXjRHKuXEr28+pabNaO3SLeYFLw6y0keq72pBSjIYH3/kX9c+PumeCr
 IicvSo5v3DwNG6HnM7gk7Ez4/dVOaXYWZBJFrLSspVO/AXnBiDn+0kN8W8S++79/7cyD
 jlSb7g3Dp5sC0x0fZKOW0RCQvxtTH+8Ga/03z45FjjV/HcrfAdsxgizhu5j22T7OokUX
 h5Mw==
X-Gm-Message-State: AOJu0Yw0Fl7jVVjJW+OhrqHzIL4Y1GT9DcIJveCkIUIBRhkbe02cDfa/
 k43ONtj3IlwgEanrXKvK/j0CHWM102i79awTvciYjIcDovwS8rjtbsT7aY3suWlQibGqoU8lIdf
 bmjGQrYNgzFvYRCR6Aoe+QtGt1w==
X-Received: from plbml7.prod.google.com ([2002:a17:903:34c7:b0:2ad:ae3b:1b6d])
 (user=jtranoleary job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:cf0f:b0:2ad:bd4c:a6 with SMTP id
 d9443c01a7336-2ae2e4e2373mr40386865ad.49.1772221976479; 
 Fri, 27 Feb 2026 11:52:56 -0800 (PST)
Date: Fri, 27 Feb 2026 19:51:24 +0000
In-Reply-To: <20260227195126.3545607-1-jtranoleary@google.com>
Mime-Version: 1.0
References: <20260227195126.3545607-1-jtranoleary@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260227195126.3545607-3-jtranoleary@google.com>
Subject: [PATCH 2/4] net/gve: introduce extended adminq command
From: "Jasper Tran O'Leary" <jtranoleary@google.com>
To: stephen@networkplumber.org
Cc: dev@dpdk.org, Vee Agarwal <veethebee@google.com>, 
 "Jasper Tran O'Leary" <jtranoleary@google.com>
Content-Type: text/plain; charset="UTF-8"
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

From: Vee Agarwal <veethebee@google.com>

Flow steering adminq commands are too large to fit into a normal adminq
command buffer which accepts at most 56 bytes. As a result, introduce
extended adminq commands which permit larger command buffers using
indirection. Namely, extended command operations point to inner command
buffers allocated at a specified DMA address. As specified with the
device, all extended commands will use inner opcodes larger than 0xFF.

Signed-off-by: Vee Agarwal <veethebee@google.com>
Signed-off-by: Jasper Tran O'Leary <jtranoleary@google.com>
---
 drivers/net/gve/base/gve_adminq.c | 30 ++++++++++++++++++++++++++++++
 drivers/net/gve/base/gve_adminq.h | 16 ++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/net/gve/base/gve_adminq.c b/drivers/net/gve/base/gve_adminq.c
index 64b9468..0cc6d44 100644
--- a/drivers/net/gve/base/gve_adminq.c
+++ b/drivers/net/gve/base/gve_adminq.c
@@ -438,6 +438,8 @@ static int gve_adminq_issue_cmd(struct gve_priv *priv,
 
 	memcpy(cmd, cmd_orig, sizeof(*cmd_orig));
 	opcode = be32_to_cpu(READ_ONCE32(cmd->opcode));
+	if (opcode == GVE_ADMINQ_EXTENDED_COMMAND)
+		opcode = be32_to_cpu(READ_ONCE32(cmd->extended_command.inner_opcode));
 
 	switch (opcode) {
 	case GVE_ADMINQ_DESCRIBE_DEVICE:
@@ -516,6 +518,34 @@ static int gve_adminq_execute_cmd(struct gve_priv *priv,
 	return gve_adminq_kick_and_wait(priv);
 }
 
+static int gve_adminq_execute_extended_cmd(struct gve_priv *priv, u32 opcode,
+					   size_t cmd_size, void *cmd_orig)
+{
+	union gve_adminq_command cmd;
+	struct gve_dma_mem inner_cmd_dma_mem;
+	void *inner_cmd;
+	int err;
+
+	inner_cmd = gve_alloc_dma_mem(&inner_cmd_dma_mem, cmd_size);
+	if (!inner_cmd)
+		return -ENOMEM;
+
+	memcpy(inner_cmd, cmd_orig, cmd_size);
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.opcode = cpu_to_be32(GVE_ADMINQ_EXTENDED_COMMAND);
+	cmd.extended_command = (struct gve_adminq_extended_command) {
+		.inner_opcode = cpu_to_be32(opcode),
+		.inner_length = cpu_to_be32(cmd_size),
+		.inner_command_addr = cpu_to_be64(inner_cmd_dma_mem.pa),
+	};
+
+	err = gve_adminq_execute_cmd(priv, &cmd);
+
+	gve_free_dma_mem(&inner_cmd_dma_mem);
+	return err;
+}
+
 /* The device specifies that the management vector can either be the first irq
  * or the last irq. ntfy_blk_msix_base_idx indicates the first irq assigned to
  * the ntfy blks. It if is 0 then the management vector is last, if it is 1 then
diff --git a/drivers/net/gve/base/gve_adminq.h b/drivers/net/gve/base/gve_adminq.h
index e237353..f52658e 100644
--- a/drivers/net/gve/base/gve_adminq.h
+++ b/drivers/net/gve/base/gve_adminq.h
@@ -25,8 +25,15 @@ enum gve_adminq_opcodes {
 	GVE_ADMINQ_REPORT_LINK_SPEED		= 0xD,
 	GVE_ADMINQ_GET_PTYPE_MAP		= 0xE,
 	GVE_ADMINQ_VERIFY_DRIVER_COMPATIBILITY	= 0xF,
+	/* For commands that are larger than 56 bytes */
+	GVE_ADMINQ_EXTENDED_COMMAND		= 0xFF,
 };
 
+/* The normal adminq command is restricted to be 56 bytes at maximum. For the
+ * longer adminq command, it is wrapped by GVE_ADMINQ_EXTENDED_COMMAND with
+ * inner opcode of gve_adminq_extended_cmd_opcodes specified. The inner command
+ * is written in the dma memory allocated by GVE_ADMINQ_EXTENDED_COMMAND.
+ */
 /* Admin queue status codes */
 enum gve_adminq_statuses {
 	GVE_ADMINQ_COMMAND_UNSET			= 0x0,
@@ -194,6 +201,14 @@ enum gve_driver_capbility {
 #define GVE_DRIVER_CAPABILITY_FLAGS3 0x0
 #define GVE_DRIVER_CAPABILITY_FLAGS4 0x0
 
+struct gve_adminq_extended_command {
+	__be32 inner_opcode;
+	__be32 inner_length;
+	__be64 inner_command_addr;
+};
+
+GVE_CHECK_STRUCT_LEN(16, gve_adminq_extended_command);
+
 struct gve_driver_info {
 	u8 os_type;	/* 0x05 = DPDK */
 	u8 driver_major;
@@ -440,6 +455,7 @@ union gve_adminq_command {
 			struct gve_adminq_get_ptype_map get_ptype_map;
 			struct gve_adminq_verify_driver_compatibility
 				verify_driver_compatibility;
+			struct gve_adminq_extended_command extended_command;
 		};
 	};
 	u8 reserved[64];
-- 
2.53.0.473.g4a7958ca14-goog

