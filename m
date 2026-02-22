Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA60C636A1
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Feb 2026 17:33:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9C8840689;
	Sun, 22 Feb 2026 18:32:45 +0100 (CET)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com
 [209.85.210.54]) by mails.dpdk.org (Postfix) with ESMTP id 4E29140651
 for <dev@dpdk.org>; Sun, 22 Feb 2026 18:32:38 +0100 (CET)
Received: by mail-ot1-f54.google.com with SMTP id
 46e09a7af769-7d4cb7e10efso3142482a34.0
 for <dev@dpdk.org>; Sun, 22 Feb 2026 09:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771781557;
 x=1772386357; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2QFgTKunZMtPZVmAKui5ElScOS1xm1uJqPsz+Q+HqjU=;
 b=n9CfgaHlUwFtQC63161h6TXcxc52gSLkhIT4F7Q7ohqp09/h7ErvCjmZtKHlzYQ1Ul
 vHbIIoSxvBIz7vtpU4CrWDXlU5/sHJklTkEHJ6d3YjcJmKpAYusJ/TK1NbFyCy5LixeX
 ZfsvMj3JtKBUp2CaULNs6EkN1DszKwRlTbLj4foZAusMH6yHt/UURHkK8jH6YS8evsFy
 pI6T7uNfi0tZNMNg4kDb4CtN9uVu8iGOl2Hclejyz41lM0zK/JDsNZ3alrsQCFlrX9na
 kuojy4RFMZ68qN2RVKp2uK25+KyToVq0XD/7PJ38jesisj3KjKzhwGvUTX/ye6Nz6N7I
 EXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771781557; x=1772386357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2QFgTKunZMtPZVmAKui5ElScOS1xm1uJqPsz+Q+HqjU=;
 b=Fj8HlhlVVp9zmxHsEHLz6zOK4fYybT4PsT5ZzKzJKsvTis5Cx/jN0Hj195B7q+WVhk
 eMo+Ie6fbb3VRlONx7n/aillWOyYxEhDTZvLDSerWy4ygAupBu6UTU8gf81NPf+eJcqG
 gfXZFRHoCum0jeX/mv1kt8zEGbSS8ozOycXGpOqj0py6W6WC/Vfv4xOC7oRhBRbusAHC
 s2eVZFRrb295306MjriX/89PLZrhi6FEcSC8tk++ucHiPN4WVClQcTxRIjiVhCCw9JsL
 Gl37lx6Ne8/ZS0VbyrDM2OwbqX4plvofZvRhcM0Y3VT7mSS08wyvXh0XwhNtyX584u0M
 L8Ag==
X-Gm-Message-State: AOJu0YxFpkXVsoZta+jZPw5x+3WnruecRxPX0CQzxXjeQFZFpZEebJMT
 ZMBmnLYOD52ybLPHCibZZR0dDgJDAifAoleYkmBX0EjEkBglT9VCNmarOb5WEK3jYlkDFO11eit
 4WMHf
X-Gm-Gg: AZuq6aIftGnQqQI21D1sOY1QKNDgnADgiW6S+TXhm6J1ducD/mzZtzvea4GUPR6/w+W
 czmgpWTUtMEhDG/sMO13r8QSkhkiONMhKuW9Ieb10PQInBQ/1uvvpkDIrb7A8UAMwW0i2GIgUfl
 QMWG0W6cqwBpRSuydp2fh5d2INx0aEUB7Q3DvTgDIphEW2cyktaew/3hQuD/G/SMtKskkrgA3d6
 ++gegmv27HNpTvdHfFaRN/OvuAMO68PZYOaZzbKA25SqQIDZa3iLv2DEecxq0lx9mF7zLuuA+jd
 vB6KWAzSYb2+Hc4btcecCU3OM0gUhLN5MGYhOk3D64XCWh/U4ps6dz89v/TuQRxoUIUDx5OH2Js
 UM4KR2Gn6zSPmk4ruGIqLrzhv96TJo8spYAbylZL/jq40gCg+/H0C5tn3Ioc2yW1lcLXsS6oMSI
 v7RNeHnGcUxyG7CuuzCwsXRM8O2xt6qBTpextaCPhi1X8YNazcaIu8C3yl4iAScwdzN77HiOoN
X-Received: by 2002:a05:6808:2e47:b0:44d:bf83:d7f8 with SMTP id
 5614622812f47-46446180f1amr4224395b6e.4.1771781557385; 
 Sun, 22 Feb 2026 09:32:37 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4157d2d7922sm5608972fac.12.2026.02.22.09.32.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 09:32:36 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v5 08/19] net/tap: fix resource leaks in tap create error path
Date: Sun, 22 Feb 2026 09:30:43 -0800
Message-ID: <20260222173225.522754-9-stephen@networkplumber.org>
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

Correct two leaks in eth_dev_tap_create():

- process_private was never freed on error_exit. Add free() before
  releasing the port.
- If the process_private malloc failed, the function returned -1
  directly without releasing the ethdev port allocated by
  rte_eth_vdev_allocate(). Jump to a new error_exit_nodev_release
  label instead.

Bugzilla ID: 1881
Fixes: ed8132e7c912 ("net/tap: move fds of queues to be in process private")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/tap/rte_eth_tap.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index c810b0df72..acae3b6d76 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -1999,7 +1999,7 @@ eth_dev_tap_create(struct rte_vdev_device *vdev, const char *tap_name,
 	process_private = malloc(sizeof(struct pmd_process_private));
 	if (process_private == NULL) {
 		TAP_LOG(ERR, "Failed to alloc memory for process private");
-		return -1;
+		goto error_exit_nodev_release;
 	}
 	memset(process_private, 0, sizeof(struct pmd_process_private));
 
@@ -2189,9 +2189,12 @@ eth_dev_tap_create(struct rte_vdev_device *vdev, const char *tap_name,
 		close(pmd->nlsk_fd);
 	if (pmd->ka_fd != -1)
 		close(pmd->ka_fd);
+	rte_intr_instance_free(pmd->intr_handle);
+	free(dev->process_private);
+
+error_exit_nodev_release:
 	/* mac_addrs must not be freed alone because part of dev_private */
 	dev->data->mac_addrs = NULL;
-	rte_intr_instance_free(pmd->intr_handle);
 	rte_eth_dev_release_port(dev);
 
 error_exit_nodev:
-- 
2.51.0

