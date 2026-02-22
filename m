Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC8AC636A1
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Feb 2026 17:33:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 430B9406BC;
	Sun, 22 Feb 2026 18:32:50 +0100 (CET)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com
 [209.85.210.50]) by mails.dpdk.org (Postfix) with ESMTP id 6B54540668
 for <dev@dpdk.org>; Sun, 22 Feb 2026 18:32:41 +0100 (CET)
Received: by mail-ot1-f50.google.com with SMTP id
 46e09a7af769-7d4beaf25deso2877178a34.0
 for <dev@dpdk.org>; Sun, 22 Feb 2026 09:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771781561;
 x=1772386361; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eVLyJfxM17TdVjysGpfX0wko6tfcszG+c7F8KIvjWMg=;
 b=VYKCwkRGhvD7suK4KfnOjTzFNhiDcmS5fsf6hB1xwqxqY0KZ6cCuqaElf1eLqxkK4t
 BZLczZ24nySvO6DoInH1Ze8snqBZXCB9hgB45iKAV1kuWE10KtyKtqrp3p3ITvVE6RmL
 L800wb+qywfTYul5ms7yg5MriPP/ygpRZduCsFA3H7hMYQCasmbh+E4ZvSKdFcyLDOU/
 l5KIMMAKfnjP20OIRg0Pglrm9A2Lh6m3gdNXzKa8yKrajaG/mr9WqekpQnpUIPTbOBy0
 ZEhp99W1OWg38cHfnRw75r4y6Ytk18CBCQEVQxCeozLLLlAV3ey/+uJp8EkaY4aTORQb
 F/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771781561; x=1772386361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eVLyJfxM17TdVjysGpfX0wko6tfcszG+c7F8KIvjWMg=;
 b=InsrWjT/tp17cukLoz5gcQp7UIh+jfAiAypS0NS54FjIun6YlQXHYj9UTC+bw9Tjgl
 ZC+WMstsYaCEooI1WeQ27fG8LhDmDFPQpZXA8YMvkfikfSfimaskj+HpB4jn+SMga0iZ
 u/uFTILcX0FcIRPa3cUODYygawJ8jKrZJ77XxHmnsobBlbP+j6hlXBWGgDmb4e66n8CV
 C4wGed26jckm+brF13CmQkR8pb4AUaG+HsqSgXLOmcQy6J0f7yZmEIUBBb3+mykwm5mM
 GwSMb3e0LMYjPPVgDqjIRlSeGQXyp34IeBmkzG7rzD3hLQSS3auTwnhbIoi6ONO3oguU
 RJ1Q==
X-Gm-Message-State: AOJu0YwDqOIyD7cuGu9g4D46kTeg7KsHw+BA9Kvj2b4lJ78zlkchyPal
 5b9F8DX6TiD67YirefEGkAHXHna00X3bS3x/1fVuDpEVJFNugg4k3MRe1UPjXlhYa9azcTG9IRX
 HO9od
X-Gm-Gg: AZuq6aIB60Z0XATFXanXk97rnBc7b5W4EyCdIaMvZWFIub233Qc1hZcLmuNbCAf9RfH
 ZT7fTKwtuaN1fRgxrNXhI6thJgd3Kraz9FNqnwnKtfP6896lqGxx33s9BvVybj/Y8JSZZV5mAMJ
 hQV9O0RNndmN6/aK+jtPFRlufmtwF+jbzyxzYQAv1wnBD3uLfhba72U3K1vpIPpGnq/lhC+RhFW
 BpXJ7E4iejNErhJny7iLFTdOBUZ21AQA4SnmYC05kM9LuE5GL7bSHgCCXW1GXx7Y5n9zWDWVH48
 2pm5qU7sXNuUcL9EIUX6xQhhBGAS57ocnQuMTjG1xveG7CUCSZEo/8BGuu/7qiZPiWRY1Hu+cqi
 INABU+PZGWrqRy3yrwdPfU/KUpSuoGI60TWqmY3dQSqRBb34gqJZOXF6Isw9s7Y/LUL9dWtrVK3
 GQDdX/vv6y6rvf/b5cB3vTLuQ5erUryiT9dTWR4PueRD6qD5JWMfwJEmAAnR5+3g==
X-Received: by 2002:a05:6820:1692:b0:674:910c:4217 with SMTP id
 006d021491bc7-679b0e0bf17mr6974936eaf.17.1771781560721; 
 Sun, 22 Feb 2026 09:32:40 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4157d2d7922sm5608972fac.12.2026.02.22.09.32.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 09:32:40 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v5 11/19] net/tap: fix use-after-free on remote flow creation
 failure
Date: Sun, 22 Feb 2026 09:30:46 -0800
Message-ID: <20260222173225.522754-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260222173225.522754-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260222173225.522754-1-stephen@networkplumber.org>
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

