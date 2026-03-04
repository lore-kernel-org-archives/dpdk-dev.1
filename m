Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF90EF8FF4
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Mar 2026 15:16:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9509D4067C;
	Wed,  4 Mar 2026 16:16:30 +0100 (CET)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com
 [209.85.208.176])
 by mails.dpdk.org (Postfix) with ESMTP id 8577A40041
 for <dev@dpdk.org>; Wed,  4 Mar 2026 01:34:14 +0100 (CET)
Received: by mail-lj1-f176.google.com with SMTP id
 38308e7fff4ca-3870778358aso73849131fa.1
 for <dev@dpdk.org>; Tue, 03 Mar 2026 16:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772584454; x=1773189254; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rvakeBmq9+nYEneoyLmg8QEtmArgNJ+fbxTEGyyfi9Q=;
 b=myulmN9nPxz04u1xGweH6aPTg/cdd0s4GEHhXeQ43LpuaVkFexH5tisft/xqvAb7TW
 OUnl7ajMGZO+7Xsr1KFDWCurLXYsWcQl9T4dYVKbiXIpFbxo2wt0ePaqlk4Tm/O6IpCu
 8PDj5usEc69FoIVrnu2Yh09GR14wQvjYkqQzfd+gxMb1/IJTxY0cXAHtJA8/HtQMFaDQ
 9ipwHYv798KFupBOICNz4g1ORDPMlbkVO4Zg/423IABlDmy9gA3feLCjh0J8SaKlAIy6
 1zfokUJGAHgVBCiRx/M/lK+3wmsHBM+W3e17oOo+0f5oyjbnPkhPbjqZYG+9j8X+XgOz
 KahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772584454; x=1773189254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rvakeBmq9+nYEneoyLmg8QEtmArgNJ+fbxTEGyyfi9Q=;
 b=XwCf30znc5xraPokAw9p8Zdwicfd3HvaW81KWwTLNN4jSC5IbLoUUtw5ENzmIS+oUr
 UTGvscvR4DeDD1+ilbvi+Ck6O5XTSI8f5uUnNI0TzHNv9nJq/aQm91EKf6dbi8bRM9MH
 PJ2Np3Oy8T+cYlsPZGo9FB+t05eGwyHQmlGuT33YmE9OZWeqnktpCAPXtpcyI8w6DjaY
 kjHt147DAC2fOqRG8u0XcPm8OZ43dyMbnLGzDjmewsFh4zx8QvIu0qNyobJLZGE+aCop
 IsRrP5S1+er0dSQ8KqqkzdcK3gUZE0G+KVtsQmtXXd51OsRkLQlMW2ZqklarY0d+uHjX
 rRYA==
X-Gm-Message-State: AOJu0YwOK4phehCIbt26V2SY0lS1cHdA6nL+8de0tCNCt5gfD1gg2f54
 l3kbJNAHFtTtelBDqoolG4WfHkNim6qAYRMs02kqRKIjiKmg8PCExXE=
X-Gm-Gg: ATEYQzy/6NxH+h9q7Fd9rToh+dPKf8mTF8aIf+EXf2XYoii4i7yhrY7oVP1rnDUpFpd
 q4GC48BMda0qwK35+8Ww29u6hyOifp/CVCS2RyvRn6F6frA3oBeNbGV+nK0/kfG4EuZk+Z8e1Zn
 31+nKNUEYp/lBQ/65FLIP4wc70bWLpeO82PbUfiVAN6W4/RmLIzBhF2KdLzzhHSPREfEHZk3Nrd
 VhxyK4ei2D2j2Ti4eGkqEaFIcnInBBrpPosemYFB6LNB048/JluSheRq6cVIwmSEoXwXgjXUb3S
 ZJoQKYdNxBkQ4GDdnI/GxkSSl+NcEPJ2hwoA7aY9Y65/QTfFKAKuicr7hDu+MYNY6bgsNz1Ry2t
 HEILI6Xs8/ox5Yy6GKsBwJuwjDyzluUuBeRoYoiFC9xZds+dpnI+fiun8o7MCuE2lxMLI3lh/K9
 dxDFNEkUk7RpX8o1HEMA97zv+xQJ6P
X-Received: by 2002:a05:651c:3253:b0:389:ef35:fb95 with SMTP id
 38308e7fff4ca-38a2c5644fcmr2201551fa.3.1772584453668; 
 Tue, 03 Mar 2026 16:34:13 -0800 (PST)
Received: from dev-debian-1.home ([95.165.2.1])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a123581424sm898843e87.26.2026.03.03.16.34.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 16:34:13 -0800 (PST)
From: Sergei Iashin <yashin.sergey@gmail.com>
To: Naga Harish K S V <s.v.naga.harish.k@intel.com>,
 Jerin Jacob <jerinj@marvell.com>,
 Jay Jayatheerthan <jay.jayatheerthan@intel.com>,
 Ganapati Kundapura <ganapati.kundapura@intel.com>,
 Weiguo Li <liweiguo@xencore.cn>
Cc: dev@dpdk.org, Sergei Iashin <yashin.sergey@gmail.com>, liwg06@foxmail.com,
 stable@dpdk.org
Subject: [PATCH 1/2] eventdev: fix eth dev ID truncation in telemetry
Date: Wed,  4 Mar 2026 03:34:05 +0300
Message-Id: <20260304003406.252929-2-yashin.sergey@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260304003406.252929-1-yashin.sergey@gmail.com>
References: <20260304003406.252929-1-yashin.sergey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 04 Mar 2026 16:16:28 +0100
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

eth_dev_id is declared as int in handle_rxa_get_queue_conf(),
handle_rxa_get_queue_stats(), handle_rxa_queue_stats_reset(), and
handle_rxa_instance_get(), but is implicitly narrowed to uint16_t when
passed to rte_eth_dev_is_valid_port() via
RTE_EVENT_ETH_RX_ADAPTER_PORTID_VALID_OR_GOTO_ERR_RET().
A value like 65535 + N passes validation as N, but is then used as-is as
an array index, causing out-of-bounds access and SIGSEGV.

To reproduce (requires telemetry enabled):
  echo "/eventdev/rxa_queue_conf,0,65536,0" | \
    socat - UNIX-CONNECT:/var/run/dpdk/vpp/dpdk_telemetry.v2,type=5

Result:
  SIGSEGV at handle_rxa_get_queue_conf + 0x34a, faulting address 0x50

This patch changes eth_dev_id from int to uint16_t to avoid truncation.

Fixes: 74b034ff8172 ("eventdev/eth_rx: fix parameters parsing memory leak")
Cc: liwg06@foxmail.com
Cc: stable@dpdk.org

Signed-off-by: Sergei Iashin <yashin.sergey@gmail.com>
---
 lib/eventdev/rte_event_eth_rx_adapter.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/lib/eventdev/rte_event_eth_rx_adapter.c b/lib/eventdev/rte_event_eth_rx_adapter.c
index d564e14b72..2183adce6f 100644
--- a/lib/eventdev/rte_event_eth_rx_adapter.c
+++ b/lib/eventdev/rte_event_eth_rx_adapter.c
@@ -3827,7 +3827,8 @@ handle_rxa_get_queue_conf(const char *cmd __rte_unused,
 {
 	uint8_t rx_adapter_id;
 	uint16_t rx_queue_id;
-	int eth_dev_id, ret = -1;
+	uint16_t eth_dev_id;
+	int ret = -1;
 	char *token, *l_params;
 	struct rte_event_eth_rx_adapter_queue_conf queue_conf;
 
@@ -3899,7 +3900,8 @@ handle_rxa_get_queue_stats(const char *cmd __rte_unused,
 {
 	uint8_t rx_adapter_id;
 	uint16_t rx_queue_id;
-	int eth_dev_id, ret = -1;
+	uint16_t eth_dev_id;
+	int ret = -1;
 	char *token, *l_params;
 	struct rte_event_eth_rx_adapter_queue_stats q_stats;
 
@@ -3970,7 +3972,8 @@ handle_rxa_queue_stats_reset(const char *cmd __rte_unused,
 {
 	uint8_t rx_adapter_id;
 	uint16_t rx_queue_id;
-	int eth_dev_id, ret = -1;
+	uint16_t eth_dev_id;
+	int ret = -1;
 	char *token, *l_params;
 
 	if (params == NULL || strlen(params) == 0 || !isdigit(*params))
@@ -4031,7 +4034,8 @@ handle_rxa_instance_get(const char *cmd __rte_unused,
 {
 	uint8_t instance_id;
 	uint16_t rx_queue_id;
-	int eth_dev_id, ret = -1;
+	uint16_t eth_dev_id;
+	int ret = -1;
 	char *token, *l_params;
 
 	if (params == NULL || strlen(params) == 0 || !isdigit(*params))
-- 
2.39.5

