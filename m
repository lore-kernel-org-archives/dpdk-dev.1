Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC28C43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 21:09:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF31440DCA;
	Fri, 10 Jul 2026 23:09:36 +0200 (CEST)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49]) by mails.dpdk.org (Postfix) with ESMTP id 5DDA640B9D
 for <dev@dpdk.org>; Fri, 10 Jul 2026 23:09:35 +0200 (CEST)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-47dec32798aso1433734f8f.1
 for <dev@dpdk.org>; Fri, 10 Jul 2026 14:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783717775; x=1784322575; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EELG2PbRBh8ouTRThhtif0EJ/3DQ4b10bnHAY5KfoYY=;
 b=UN1fWy1xLNZPsmyZkWXWR+24nZ9SXwszFUMpmthOsZxoQ1fi7YvThiFNbf0JOlNHXN
 Jai9Gg+ZjLKT/TrHlEWBftWniY+ZVCD4hyNk1y0Wf9niyBR48MM54luGOzlIzjcrrY0L
 PsTlBcd0JC55tWPH3/FcRyjW6PrqCXHtCS7+KxNJyX4WyQMgaGj52VjY7PtMl6eO/nDE
 oVn3iRFCXgw+0tU8qzZZmvMz0380rhBkPPAVRdvLbFP8IKTYD3oWXYsk5aluf10WdSE5
 REBovAu0T5cJUZ+BgcwbFF8eAjhguLMzZa7xfApgqIwfpFDgDdNTogoOFcg2WKuiT6C+
 k5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783717775; x=1784322575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EELG2PbRBh8ouTRThhtif0EJ/3DQ4b10bnHAY5KfoYY=;
 b=d2JKQbBdGHiXFbJaNup2LqQEPbarkT/0JkSQZ8nmEuVQG5ors+Zzh2aB+VkCV3AOFS
 nZKxp3XldtjoENx32WT/3k6foU2cCgK2oyWsCPT9b1sVaf9PZfQXYE5DJOAP7hxOPxV3
 1zRc5NWgP6G5lpVEJsUk2ANrPxSWw9gVgaT4y4p3VrNdpj2jEUzi6MFTM2Ieqt3zX3oP
 wlw9LcBgBkIhN9eUP0o42LYY1Q3MNr14xw+nXhNb6b1sEbEaT9GwLcENHHtlw6iUZdH3
 bOQfxr4myzx5GXY/7SrO/Qg8qwLkQUnvwOZfryNuiQlk4JZ+fMaotttYM3Mz7LSI4tT/
 7ePQ==
X-Gm-Message-State: AOJu0YzhJOHeMnROMl4SkC0W8SKi2SJBXrQ5kxVIiRheGDaTHHRpgwX4
 FUrSRe28iw1K0E5hPO14QxaWR8jUpVwa79bdnN2RbeRpCAmVrB/gLHviuiGd8dUY
X-Gm-Gg: AfdE7clyKvxMVwCQi/Kwx3MwCZ2vf7uJ3euo8Bo+G3vkFjapCTFynYkf127voI29yti
 0iTiXMYSmiPL3NGFxEO2xMbKFgPfikOV8l7eiPP1GgKqPaFpVPFk8ebuaE0IDEMwQGL64EHDmWK
 ViDLVQScTnRcZ/jV/WL9r5I9GdwqyafZ7GwCzOtnhksvhpeR8XIQB0vbATLVKB3OWqKySEP0jnm
 x9/9Drok0/h3B1u4GPY2Hkl2/YRfybfoAzw6XVdw9Q5h0qnlK0ujK8OHgs/q2oHpnx033MccZu7
 XLAYzNi+VasytvwF5EJSEUCd1xoyegaGDM/FdC0oiRMRGwIgSyRJIjMbR0RZYpAsVXpQnEe1AID
 YBRoyGWa5uurKsY0+zfiI3DcjBpLiz8Y7rhahqtufDziNan6JR4F06nbNsNWV5tv9nOLsqgP+A4
 haEcto+Q==
X-Received: by 2002:a05:6000:310f:b0:474:ad57:1720 with SMTP id
 ffacd0b85a97d-47f2dce29edmr345821f8f.43.1783717774879; 
 Fri, 10 Jul 2026 14:09:34 -0700 (PDT)
Received: from freepad.. ([2a01:e0a:6f:bdf0:a821:a41b:93f0:2def])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d843csm61924642f8f.14.2026.07.10.14.09.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:09:34 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>, Jun Yang <jun.yang@nxp.com>,
 Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH v4 4/6] bus/fslmc/mc: implement DPCON set notification
Date: Fri, 10 Jul 2026 23:09:18 +0200
Message-ID: <20260710210920.2402309-5-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710210920.2402309-1-maxime@leroys.fr>
References: <20260630144329.457643-1-maxime@leroys.fr>
 <20260710210920.2402309-1-maxime@leroys.fr>
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
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/bus/fslmc/mc/dpcon.c     | 31 +++++++++++++++++++++++++++++++
 drivers/bus/fslmc/mc/fsl_dpcon.h | 18 ++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/bus/fslmc/mc/dpcon.c b/drivers/bus/fslmc/mc/dpcon.c
index cd909fcac4..c01d7adabb 100644
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
+	/* Send command to MC. */
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

