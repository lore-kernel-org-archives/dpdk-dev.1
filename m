Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286BEC43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 14:44:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C41740A6C;
	Tue, 30 Jun 2026 16:43:47 +0200 (CEST)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49]) by mails.dpdk.org (Postfix) with ESMTP id 9FE6C406B7
 for <dev@dpdk.org>; Tue, 30 Jun 2026 16:43:44 +0200 (CEST)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-475881b9a4bso1132561f8f.3
 for <dev@dpdk.org>; Tue, 30 Jun 2026 07:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782830624; x=1783435424; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mty1A3SbpUullxVbRqTJ7zDraSz/y2xl5NenBc0Uqbk=;
 b=mwzUnrHsg1Gp9YheUadw+i+XF+zybb6/Unj22qke3dAN3wUn+MJmkU2A6euFf5qHRD
 FQuux2XKYVRtpN47vRTCrAX6b4LsU+zmrCFSt3obCuf+mXJPIrTR4tRg3XcWMbgubeOD
 B2bdR9hztFWZlMlFxZ3c8ctK+irOM520lhP4f9yWsPpUrQpHkTuzgHm8xwBjaI384H34
 J7s5cZ32TK1FUAqAhXVRNBRe1RUBUF1D+oa9KkQy+bS0JJGp8xDcFiD/pHWUwtND/xMo
 bEa4GhmRX0WyudsJkO3Jk1aXSDG/dytMsuSNbqIGtwPlq+3WdaL6ueKudmEQ2wF/CaJd
 nzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782830624; x=1783435424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mty1A3SbpUullxVbRqTJ7zDraSz/y2xl5NenBc0Uqbk=;
 b=VOXPDXr662xroX5GLqjz71yKq+uK02g/0Ia45i99coOLY3wpd+2o9LVgf/1H7vo1qk
 vPNesvZXaGMkdm5A77TIsKAj7vGkZhzisBzy8MKoY8NVsDsaesKHR5GS+UObUOWDid+M
 vOxEW4Yda+g2Cl9h1J10qpDzV5+YTGgfZNDo+Mf2ZMtZ++6C/aLOGY14Lr9SeXZMa+SN
 JtlCNRN/+N/DQegRi82JqrAeSEu1VLOgUAceaelUiheGCIn8l7hRzW5KrYBlmqi6dMg+
 MupY0A/V6VaLav6aA2WuZ9n05CEinK+Mn1HkdB6pGio44GEkYrbRlN6ohLa77UMXK+Qk
 vDDA==
X-Gm-Message-State: AOJu0YyLhX1xacsSth4AwrMThfgWBcjnU2VJju6CvEFQi50OX7l9zoCc
 kf3yqD7rqY3bGn3kHOIeAnD9aHaWqeNgOglfIm2aqTQ5er9X67Zf2V37bhG4+t6+
X-Gm-Gg: AfdE7cmX6HuS9HTc8V7c39QcQun8AaQ5NTzDD5TntsCCe/Uitfa8sQAKHL2xrGh1Dtj
 dsNywmxRyO9pQKhI/OVSxf2Iq5uoSGYdedmCPMbeaapHo4t5WgY14UXG6qjKWL2oOfRMKWa3cLc
 KRnXonRz5YIdRw6nhoWuwa1tTapIaLGxzmFp3zqNZdwxZ6+oVawjdqgJ3pBRi6cZSdbGlKi5Y2D
 wX8yaqMeG2/7pSF2gdO86fG6nihZMpOYTElwNU+/3pPhCYELaM6NbcUr5F34/SEA4dkS0+8wORm
 qTCEmS2ZQSE8+WzE1odBE+w7xh91hbTx+N8ntrqk2tUVfrKShHelfy/pze86SWM8xDZQmxqW482
 u7ws/IWIg1Hdr7K7wKL4yv/8elPWWy1w8KQZgGMU9cv70K6GjN1i67LdlfGJpIMUTH4Pb5MrKlb
 OCWxYZYN4nMPlV6a28UyjWJn854MDYZXmM0zXF4JtV9afq
X-Received: by 2002:a05:6000:29d3:b0:473:1706:7efe with SMTP id
 ffacd0b85a97d-475523b364fmr3450380f8f.24.1782830623961; 
 Tue, 30 Jun 2026 07:43:43 -0700 (PDT)
Received: from localhost.localdomain (free-mobile.vlq16.iliad.fr.
 [213.36.7.11]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47563d194bbsm7507080f8f.3.2026.06.30.07.43.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 07:43:43 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, sachin.saxena@nxp.com, david.marchand@redhat.com,
 Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH v3 4/6] bus/fslmc/mc: implement dpcon_set_notification
Date: Tue, 30 Jun 2026 16:43:27 +0200
Message-ID: <20260630144329.457643-5-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630144329.457643-1-maxime@leroys.fr>
References: <20260616102727.708948-1-maxime@leroys.fr>
 <20260630144329.457643-1-maxime@leroys.fr>
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

The DPCON_CMDID_SET_NOTIFICATION command id and its wire struct were
already present in the flib, but the dpcon_set_notification() function and
the public dpcon_notification_cfg were never implemented. Add them so a
DPCON channel can be pointed at a DPIO for CDAN delivery, which the
net/dpaa2 Rx-queue-interrupt path needs.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 drivers/bus/fslmc/mc/dpcon.c     | 31 +++++++++++++++++++++++++++++++
 drivers/bus/fslmc/mc/fsl_dpcon.h | 18 ++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/bus/fslmc/mc/dpcon.c b/drivers/bus/fslmc/mc/dpcon.c
index cd909fcac4..3ab2a12637 100644
--- a/drivers/bus/fslmc/mc/dpcon.c
+++ b/drivers/bus/fslmc/mc/dpcon.c
@@ -338,3 +338,34 @@ int dpcon_get_api_version(struct fsl_mc_io *mc_io,
 
 	return 0;
 }
+
+/**
+ * dpcon_set_notification() - Set the DPCON notification destination
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPCON object
+ * @cfg:	Notification parameters (DPIO, priority, user context)
+ *
+ * Return:	'0' on Success; Error code otherwise
+ */
+RTE_EXPORT_INTERNAL_SYMBOL(dpcon_set_notification)
+int dpcon_set_notification(struct fsl_mc_io *mc_io,
+			   uint32_t cmd_flags,
+			   uint16_t token,
+			   const struct dpcon_notification_cfg *cfg)
+{
+	struct dpcon_cmd_set_notification *dpcon_cmd;
+	struct mc_command cmd = { 0 };
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPCON_CMDID_SET_NOTIFICATION,
+					  cmd_flags,
+					  token);
+	dpcon_cmd = (struct dpcon_cmd_set_notification *)cmd.params;
+	dpcon_cmd->dpio_id = cpu_to_le32(cfg->dpio_id);
+	dpcon_cmd->priority = cfg->priority;
+	dpcon_cmd->user_ctx = cpu_to_le64(cfg->user_ctx);
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
diff --git a/drivers/bus/fslmc/mc/fsl_dpcon.h b/drivers/bus/fslmc/mc/fsl_dpcon.h
index f2668da1b1..3bef97f6f5 100644
--- a/drivers/bus/fslmc/mc/fsl_dpcon.h
+++ b/drivers/bus/fslmc/mc/fsl_dpcon.h
@@ -95,4 +95,22 @@ int dpcon_get_api_version(struct fsl_mc_io *mc_io,
 			  uint16_t *major_ver,
 			  uint16_t *minor_ver);
 
+/**
+ * struct dpcon_notification_cfg - Notification parameters
+ * @dpio_id:	DPIO object id that receives the channel's CDAN
+ * @priority:	Priority within the DPIO channel (0-7)
+ * @user_ctx:	User context provided with each CDAN message
+ */
+struct dpcon_notification_cfg {
+	int dpio_id;
+	uint8_t priority;
+	uint64_t user_ctx;
+};
+
+__rte_internal
+int dpcon_set_notification(struct fsl_mc_io *mc_io,
+			   uint32_t cmd_flags,
+			   uint16_t token,
+			   const struct dpcon_notification_cfg *cfg);
+
 #endif /* __FSL_DPCON_H */
-- 
2.43.0

