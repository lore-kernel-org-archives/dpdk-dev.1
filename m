Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F42C636A1
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Feb 2026 17:33:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E7534069D;
	Sun, 22 Feb 2026 18:32:48 +0100 (CET)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com
 [209.85.167.180])
 by mails.dpdk.org (Postfix) with ESMTP id 7E03B4065C
 for <dev@dpdk.org>; Sun, 22 Feb 2026 18:32:40 +0100 (CET)
Received: by mail-oi1-f180.google.com with SMTP id
 5614622812f47-45f053b7b90so2370128b6e.0
 for <dev@dpdk.org>; Sun, 22 Feb 2026 09:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771781560;
 x=1772386360; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OFbKFVrj0b1bJRghZRFLpMxI7FsAO8E48npRxTefwbE=;
 b=jEAcgsbc/iQuGU1VvWkDxKnFmPYpMWws+JUXUzWzrQhLB3rYP1zXAPDoHt2/h6QySo
 KhJsnhsdTtBZMcCaYPZVqxYLMNJznKRZOVSC7GuT4kU78nGKKCX0SJh2HpX2H0jMsQbu
 0PuD0J83BQVNQ1eU9NrWbKqCDuaPmvUPtrW/1y+HQ5yFK1Ctxum1/qyAv2r/Mrs3qINc
 30h7W5SA6TxempzNzo0KFKAC/412p26HRB7Zu0OA6gmM96RZdQ14ttlHBtv3Ue2FCWc/
 nm15JSZlgAawl+LuafgB3SOlk42ZBd4m0LDt06K5OSWokdkySCQ2p203eL7jzBGdWpWx
 qPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771781560; x=1772386360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OFbKFVrj0b1bJRghZRFLpMxI7FsAO8E48npRxTefwbE=;
 b=Q1W9eqa5dnWLjFunLKG0EJ6pnswhdimM5iHQBKGYIcDyM7bwuHIr/FgGt9G2i/Obx+
 wrQX/fHOb0sySY+eyAQDPNv31hy5MIaXV7SSb8y7gVBnqKfsZzgh0KrTcp9r+xrQABIL
 xqdGcxG9sIa6F4Icc8oEtOAY7Lb5k+ck3RRqXCKlZcns5cjlIsE/53RmUV2vJyKkpfpA
 KHwDLK1UEYBCHSTwuokMHITk8x4mmi91KYQkMhLR/ByzNbhVWBecS2Y0IY/++Iyw6ny0
 5YicJfo0MJ43qq/SDtyirGdetitXUNb4ASVxWcIFwqtaiVauLIxPDFHgI9tEQLRw2Mqq
 UUuA==
X-Gm-Message-State: AOJu0YwUG7QZnT/WMU4MqnhiMRbSEgVAcn0vn3cIdIYNQZAxeW/Z0EAf
 EJJ9iYzNgfbw5sxqGp+pVxj5YIpKel1Vix1nxE+9u/pr/Fa1WnH0IsqPCLe7T4n1AYcfzhWav65
 oJm3F
X-Gm-Gg: AZuq6aLqMxb55MMyN/VNPnlAdTAsXZEvriqsudKrjR6qfKjivIrXQaFnIcCyzozKj1k
 nAQ32GW9T2I9Nj1Blr5nQwGqyMViI5+2BfEymlZ0uGWDF84Vh9pZvKu+84llk28II0TcUuyj+91
 i5qw8HDP5IxivV5qMRrjJJrkkwvMyuM8qwMZvqriPZqiX45DDR3e37HJukGxWEYYuL06Re8EDmy
 aK+jCBTCVUpwedTMwFsngDzNUmNSns/umNfq/3LJqdSoobBWnA8Wmo3FHDgCmU6gl/lLsEKzoQP
 SuGClxSTf1WZzcc/A4FJfb9bvWcT0rHu1DC4fDmZXWRfThr4GkAHy8KOokPNlC/nQxevaleBAjb
 +bKYmar0JyZxzkkPa0tD0+kzlLWc/FpWW1mfEe/pNCPG2jYWtSP/CsbH2HavcsU+JbbMLxcE1aK
 MlcqUicQCHomWdE9ES9LfxNpj7hjGq1NxrMMWCuWqscirhBX73XJ1sw4X5GEi7fQ==
X-Received: by 2002:a05:6808:1315:b0:462:dd4d:7679 with SMTP id
 5614622812f47-464461406a9mr3536620b6e.7.1771781559835; 
 Sun, 22 Feb 2026 09:32:39 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4157d2d7922sm5608972fac.12.2026.02.22.09.32.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 09:32:39 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v5 10/19] net/tap: free IPC reply buffer on queue count
 mismatch
Date: Sun, 22 Feb 2026 09:30:45 -0800
Message-ID: <20260222173225.522754-11-stephen@networkplumber.org>
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

In tap_mp_attach_queues(), if the reply queue count does not match
the number of received file descriptors, the function returns -1
without freeing the reply buffer allocated by rte_mp_request_sync().
Add the missing free().

Bugzilla ID: 1881
Fixes: 9ad43ad8fbee ("net/tap: fix potential IPC buffer overrun")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/tap/rte_eth_tap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index 2707d63f29..6640ac1596 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -2396,6 +2396,7 @@ tap_mp_attach_queues(const char *port_name, struct rte_eth_dev *dev)
 	/* Attach the queues from received file descriptors */
 	if (reply_param->q_count != reply->num_fds) {
 		TAP_LOG(ERR, "Unexpected number of fds received");
+		free(reply);
 		return -1;
 	}
 
-- 
2.51.0

