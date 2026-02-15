Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB80E63F08
	for <dpdk-dev@archiver.kernel.org>; Sun, 15 Feb 2026 19:55:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DACEE4067B;
	Sun, 15 Feb 2026 20:54:13 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id C29A940678
 for <dev@dpdk.org>; Sun, 15 Feb 2026 20:54:11 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4837f27cf2dso8465605e9.2
 for <dev@dpdk.org>; Sun, 15 Feb 2026 11:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771185251;
 x=1771790051; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eVLyJfxM17TdVjysGpfX0wko6tfcszG+c7F8KIvjWMg=;
 b=fO4/Vom09HvUdluBecjFWrWP8fL9elmX7s5RrV7bbYH/mU8qbsCWKbH+Pi9NNxeRb6
 VcX4s47mcMewnZ1vnGLC6y2W16Y4CZ8VZZabXgTQWWZ+YIxH0Z2F4UrDDEGLz2dDNQkn
 JsnP7/M3ClCUYhVEM9gW7j1fkty6qXry5qnzix6GTmejHbFFG0P6xadEIK2g065CnYpz
 AUp246MMUl5hSehBeREvrcj4adTx9b2qlz3xgn+e8EYnxHw1PVuIwKlLbITxfHAJtDHE
 syOKMj6c625V+59tipnBN7z+krCgkiij9NqCJ2w90aisF7Sym3qqAWQmJrdH6YPVPqUa
 9LiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771185251; x=1771790051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eVLyJfxM17TdVjysGpfX0wko6tfcszG+c7F8KIvjWMg=;
 b=oBBPMM+xI7k6JyrG6Ou3b3OJaeIxmgAdRmgL5OjmnMZynJU9H6oMl+6qzfJrEGqYBf
 QkCtCE8DTcni4ZjK/7WOgUX9X6kyZdwMvN2SfewW0YHCqkGCjSTM2YDjFxS/NOTf3O7L
 YgpAHR6XAoM5kxvGkhPVQoegM7zwt7av5/v+ge9P8VLYAYfTz0T8eXBwzGvOsE3CJWvF
 YAWVH00chVRMK4I7NSEDKfGqF1RhedTZCG7dvxS10fobiAxUY5dUbkWAvTv+T4KI8xgQ
 SpDsGESZpfuw1PilUtSHet00s0MNfdd5IVtbmb0epqqeLfY6TmdswzdKtj+/vZ/w4pgj
 q3Iw==
X-Gm-Message-State: AOJu0YyIxaibuFxtbNGSxTvU/q2dEbO2YG6KDVT/Kf3lxrfeFvhnmFv+
 ayJtSg3adSN+/D+9y0v1Ay/zRaBhqwlpFOqDjlexOJp6pR/mEqdTlKwUhdsPd6Z4eOhLpmG4HaN
 Te65XU6w=
X-Gm-Gg: AZuq6aLBY1yK0oO+Uku+kAwJbwQDCRW+J69N3EGUj35prb0FcQjUr7o5lPLqKkK/SYU
 ZzKLeQQ0zclNyFl7oq9aEFg7Bl0QatQlr3AikBTlZg0jrbYycAj7G/gKMc2u2oWE/l5yn41yuBC
 qg0FQvTv0m21xFSUJrhuON4sfOMGA40SlKYEG2bmmEhT50SZcrM/50cjgsiIgLvOmZ26U7ehKlg
 KCcVuwEQtNNZIR/Fe//LXa+D9cP1WTS//LMljuIui/6CDy1cToJdJcE5cpLECkDyYSNr4vqPUB/
 FIzlchqQ1Ggmj0kmh25jP10uhS1wWHY5+3wlpAl7vtNnygaDNgqeQ/Lx5WrzkM1f6z2KjmO9Z75
 Cbe79Daqiaq7EMzfB9TK0VoJCJ2Qsb+4kovFFrMqQiyU6b6fSZZHeIC/lFk4ONcXmM9lroz6diV
 3EKxv43ACvhh2KtXbp91CDH/h1DYRAa0Fs8j3FFtXzHE1h/Yvfjx9ISFnfVXb6/K7NOsZKmbv8
X-Received: by 2002:a05:600c:468d:b0:47e:e20e:bbb4 with SMTP id
 5b1f17b1804b1-4837108fcf1mr163002275e9.26.1771185251159; 
 Sun, 15 Feb 2026 11:54:11 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835d99497asm526490415e9.6.2026.02.15.11.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Feb 2026 11:54:10 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Pascal Mazon <pascal.mazon@6wind.com>, Olga Shern <olgas@nvidia.com>,
 Keith Wiles <keith.wiles@intel.com>
Subject: [PATCH 09/10] net/tap: fix use-after-free on remote flow creation
 failure
Date: Sun, 15 Feb 2026 11:52:27 -0800
Message-ID: <20260215195348.557945-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260215195348.557945-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
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

