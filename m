Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D42C5ACD9
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 17:07:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C2E9240679;
	Fri, 20 Feb 2026 18:06:35 +0100 (CET)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by mails.dpdk.org (Postfix) with ESMTP id DDE2840658
 for <dev@dpdk.org>; Fri, 20 Feb 2026 18:06:28 +0100 (CET)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-8cb3bae8d3eso219652285a.1
 for <dev@dpdk.org>; Fri, 20 Feb 2026 09:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771607188;
 x=1772211988; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eVLyJfxM17TdVjysGpfX0wko6tfcszG+c7F8KIvjWMg=;
 b=k1m7kxtkcoIbcMGaTPc5Bdi4Hu5DfyJjoeHtR08eGl9IQmF46OerrIK3Q2xTIpqqqy
 BIVAen1ZynHweklGXSuDr5l2yNp3w4xN9ovg0lM6b6hWEeFI2foT2jXSYFfhLD5EA5QK
 XehW7Bf/S2mlaH8nuzSebB53MwzN4tHK6Z22txGLkZDvQBoFghK4kcD71/SrLmx9IIRh
 8XcXcMdR1pAFfhTxGTC3dW96DJD4+lMmOzwrLPf2n5EvB7t5K1S+MZRdZWk8eFzmKIgs
 9YkhfWGBsY31pbkNf4RY3HOavBepo6VAPOBS7yzAA0laBCY2BtiaPR7pbqreCdyexMBZ
 xc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771607188; x=1772211988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eVLyJfxM17TdVjysGpfX0wko6tfcszG+c7F8KIvjWMg=;
 b=bS0L2/x4t0BWSkIymF7+//DWsEvBCmFefC9Sjc1J3qPen0L1pDAFhICEU1GN9Si4lP
 9plwDqIag6TanT2WurqQmIF281F/3odg/7x6zw0GEpcFe54APcWxK7PVDzSRrpKc4E5s
 zc2oV6kZ3VdKba/eXVNoqo7j34Sedw/qXgcVuWvD013jEpsRO/gBTzBooPSds2W01qts
 oe4COOpspgFZ6V6jUK3/RtAV1GB3VGoxZyZnOLCBy+nthnfNcr6fZMjEMEpML/yOHphC
 BSWSflPDpN3F/OZFQAWxP6IsfJZDx0BHcgXI1zUrESTOupM++4XHK3ano11Jk5V3lOJN
 FaVg==
X-Gm-Message-State: AOJu0YzC4A1KzhMRNME43U51PAjuOUzlaz0Zp2DYP/suGV/sizd6x8jL
 phLNVkXWa8cBPEsgka9Kik2JDUeJqms9vANa49BMN8R2dtc6UtL83qdc8ohr0XJ4kqEtUvn/ovi
 DWjrc
X-Gm-Gg: AZuq6aJVTbyJdYuzXepUhamnTfQNDXZqE03V1j9nQe7YYhkwpT4U1YLTBhW/k84V3gv
 tg81AOR9+dya3OIJSA3gCVZTwWycx5cp5QDe6fmT8cW4pRK1sCZmE6ivVTkfbf3wzjpab0coQKA
 LPnYjYSrnw1w4Q9rbzkELNDiLQSZVBjo6fkqgrg3mnZBRyBah+rO6BWa5DXd1/B9W46gVjBNa+l
 Xni57KLYYnfRCBSoM35D4Nv+qOvXp6IKKyTY9FpKSibp6CyP1AxSuIVdYxQ/gQymdaLLukdvPa/
 G8dthwDTqH0gS6F/lnbj/KjI8ktVvJt6RUZWtBYy90Fzv5kYQwFn9GWPwYecGg9mfqn2Ncnt4UQ
 PNAFSEUGGSduL+UpAR4z73k7MlejAA8gdEf0LoElRBhq4Vk1K2Q8YUajHTiRnrvzY+C3o4o05mF
 xGnOJh0LspEIFvyrxNI/gxX/Z9P6Uyn8xwN/q8MvJzIsGYX69arLafOvWH1Cc96w==
X-Received: by 2002:a05:622a:1112:b0:506:a57e:93a0 with SMTP id
 d75a77b69052e-5070bcf3c65mr7784591cf.64.1771607187965; 
 Fri, 20 Feb 2026 09:06:27 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50684bc39e6sm276277591cf.31.2026.02.20.09.06.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 09:06:27 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v4 08/10] net/tap: fix use-after-free on remote flow creation
 failure
Date: Fri, 20 Feb 2026 09:02:08 -0800
Message-ID: <20260220170614.75560-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220170614.75560-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260220170614.75560-1-stephen@networkplumber.org>
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

