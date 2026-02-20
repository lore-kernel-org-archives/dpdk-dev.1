Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AD9C53214
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 05:05:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D759240672;
	Fri, 20 Feb 2026 06:04:28 +0100 (CET)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by mails.dpdk.org (Postfix) with ESMTP id 976B74065E
 for <dev@dpdk.org>; Fri, 20 Feb 2026 06:04:23 +0100 (CET)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-8cb420fbb5dso107434785a.3
 for <dev@dpdk.org>; Thu, 19 Feb 2026 21:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771563863;
 x=1772168663; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eVLyJfxM17TdVjysGpfX0wko6tfcszG+c7F8KIvjWMg=;
 b=xcTxwH5xjJm6mowp0HnM95iGOWYogv8uCM6CYsD2dOyMtV1uhiuvOcjUxH1aHCK5qR
 BRtdCR7NgIWRwWfT+30J5LOqi6smmRpuUtkyEKB+5rvbi/ux4DyXGtdKwAQDWwaeIVpP
 pnCI23elrTWQYBi36Twbp4hT2/4Qn2anOx3aBYC2LO0FvaP+WrbuF83ffsBfew9XnaOz
 A5bht3Ta4oxA5SX15fEDqA3EYQIn/HD+DlKqeN1Y+jeRvCmWhuXcW8zIkEAjmg9UTGNY
 GosS8H6zk2teI1MuwKoS8FHXACu5BpqFYDdRdcOKWsfOsMk2WwNOh3i+krz7skhNcrtH
 bSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771563863; x=1772168663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eVLyJfxM17TdVjysGpfX0wko6tfcszG+c7F8KIvjWMg=;
 b=WQB3DCZuvFXu/LQkFTuWJVCPd37ykDebSY5M81AK0lQW9yxJksHsVbO2/fajK/Oa4j
 +kROARVhX9E7TF4rG5IPqT4lm80jFHA7SwsjSBwpg4y9kWWYuxtFKV18Hu40IsTMHp9Z
 jE5cZdz1O7mLOJZKaZNJaxGNlGKAKSyAMIOCModxoUjual7FEznG+0iQQn8mIfcD1Kr8
 b1xatrcCNYPq5VZgmB8AizaclukXFLNWM4vpvIf5M8mmg39ZDfkgrypPXHHELRGUpWyg
 NE75Il++Hwi1N4NuF6qlBEhHwqMWyTsKlt0y+m9eb9yq3D2jaG1I9939ituYNF6EZwvp
 xzVg==
X-Gm-Message-State: AOJu0YyIPv/vDqF22SMQwxeekCZiGDnERNT1eEY1DyD/WyZNc31Mb51P
 KVJVWBDVxJHZwLBB8TTSEyUpyj5rQKMWZcNruBZTAQXoJosYuIz/Hd2OeRO4GYIpU8p0HdfGE4u
 tz6b+
X-Gm-Gg: AZuq6aLFg5f8agHQSTXVtmXOt9Pe2W1x6Fo8Pp9vzUzbB6rIGKEyVea2pLCT6pAu7+E
 H+royDnm+RYgJxz8XBEnFEejvUSVeyrLkd0qgEN6ijiMa1AXlCGmWmxuso0QvmcYflWSBOJkixe
 8kYSYpnyOhRCAXW4XIVGmzbX6VoCXIgkinsEgoKrMANPw22RReKgHS8+yrH8+m+5nPvAMB6W0EX
 rAmScQD/Y9pErvD4T2VucO2JDMgOlytyb4jE3pOlYxky4U0/Cb9NCfvCglq6xPn10z9nWDq1Yt7
 3wkDFRxjN6ifW7iczLxWGLnYltvMsYii8KF5hU6slvK3ExeHSA05Fxkzy2+yGhKp56K4SlW8uyg
 c03o9eiiN0kMR0Jh5D3u/L4y6jX3BH2ZxQYAEdj0neZWz2tmFQbo5/3Akt9jauM/4FHpwtjmSyq
 thCANw2Xeup8X5t4ifI4evAzHB5yxqal2Z5ydd5W3TOtflWT5ZvrO/9kC9Ftg1R7lFPMJb0cNR
X-Received: by 2002:a05:620a:28c8:b0:8cb:3d57:2452 with SMTP id
 af79cd13be357-8cb7401caaamr871945685a.1.1771563862775; 
 Thu, 19 Feb 2026 21:04:22 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cb2b0f38dbsm2289278685a.21.2026.02.19.21.04.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 21:04:22 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v3 09/10] net/tap: fix use-after-free on remote flow creation
 failure
Date: Thu, 19 Feb 2026 21:02:11 -0800
Message-ID: <20260220050409.1571022-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220050409.1571022-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260220050409.1571022-1-stephen@networkplumber.org>
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

