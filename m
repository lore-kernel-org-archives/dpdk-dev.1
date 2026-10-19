Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330D6CCF2D6
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 11:48:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A23040B9F;
	Mon, 19 Oct 2026 13:47:12 +0200 (CEST)
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mails.dpdk.org (Postfix) with ESMTP id 6AAE64028E
 for <dev@dpdk.org>; Mon, 19 Oct 2026 04:28:26 +0200 (CEST)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f3969a2a7so125216985a.2
 for <dev@dpdk.org>; Sun, 18 Oct 2026 19:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792376906; x=1792981706; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5gFjQ1TYXeEJawgbVi1bAPUGT6IqyrsDdV4x90UThPY=;
 b=u1VnEGLTpOcxFZ1JACQQzkEHcWbrj9auY0MtiSmGFlVKEaNtdOe7pybYGnu/Fij2IF
 +e3uluQvkkltOb0GWSmyDJ833I4OaQn4kGPXI5+3+a6TYYLlqJKYUecYcbgyB6+hWqxa
 YEol2Ef4jfWICC2wmDLodu5tkaqOvQAyISiEvMfrEOVR9ofIJiVpCmCwaDNDJD9sLltB
 ZDf3rK27567udQ4sZ32ukK3sh6lGN0w+QxQM3KcyHwlFRITavefYhSEuXYFIYgXfKFYl
 l9LNCnn4gnisA+F7b19zhkxaXZYY3diIw10P7xjHOTuINO/G+a6ENR1XWWTUI0UTmfZX
 3ScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792376906; x=1792981706;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5gFjQ1TYXeEJawgbVi1bAPUGT6IqyrsDdV4x90UThPY=;
 b=g+n5+0pfDhy5q/zLXVFzhxQme9XKiiKlUsIJ3e/vrMlZiMYSZroHmmUmjPtB/Sayx2
 4VI2cACrLM+PTOgnOoyRt0fTylu+bg2+xxjLXc3TOvcKCJ7ySU94r/0BIb44ABgjlfw8
 LW25b41Y3CkNG5Slasgnd1XW1iTSBXHLbA8DE4Zul6KplTiKuDqH31OIG0J3kgL2cXpz
 91ZEEmPWinNvXxdepuir0NloA1/QvYVKTOwqBfXBJbpcvpdCVw6HSCFCGDZe+33WJSGE
 znlGIN8qfomSuxe04kf49boyaJ0kDtT2CVhgFBnIAcRcduhPR8hKdhLyw484edKkUHe4
 Ku4g==
X-Gm-Message-State: AFq9FYKqQ0ZjBqvzpi0YvXM40FxFxzBgpMTfYU0/zIByp4Iwc9lBuk3O
 Vhp8iyreKWCgGYUlBPQGIqJV3q0/xYEPhI8t6+9VJZITjbtcgqIH8xboAV/6h3hLUQVPCcIqs7e
 chvyCup7w5esvoEZPtCScRW/XhpIFKZNHScJpPzSYoMzO0UIq2ALdle8KSctA3lacjDgkVvF2Kb
 5a+IreLimtEMCyD29G8ggwqFmOIcYA
X-Received: from qknqj15.prod.google.com
 ([2002:a05:620a:880f:b0:93a:20b6:ebe5])
 (user=rnwolfe job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1a1b:b0:93e:c12c:43f7
 with SMTP id af79cd13be357-93f29de8891mr1150035485a.68.1792376905244; Sun, 18
 Oct 2026 19:28:25 -0700 (PDT)
Date: Sun, 18 Oct 2026 22:28:24 -0400
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
Message-ID: <20261019022824.189319-1-rnwolfe@google.com>
Subject: [PATCH] net/gve: advertise Rx scatter in GQI queue format
From: Ryan Wolfe <rnwolfe@google.com>
To: dev@dpdk.org
Cc: joshwash@google.com, stable@dpdk.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 19 Oct 2026 13:47:02 +0200
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

Since jumbo frame support for GQI, a frame that does not fit in one Rx
buffer arrives as several descriptors with GVE_RXF_PKT_CONT set on all
but the last, and gve_rx_burst() chains them into one multi-segment
mbuf. The driver never reports RTE_ETH_RX_OFFLOAD_SCATTER, though, so
an application that enables multi-segment receive only when the port
claims it treats every packet as one segment. VPP is one: it masks its
requested Rx offloads with rx_offload_capa, so on a GQI gVNIC it never
sets its multi-segment flag, reads only the first buffer of a jumbo
frame and drops it as malformed. With 4 KB buffers that caps the usable
MTU near 4000 bytes on a VPC whose MTU is 8896.

Report SCATTER for GQI. DQO posts one buffer per packet and does not
chain, so it is unchanged.

Fixes: 496d4d2c8b54 ("net/gve: support jumbo frame for GQI")
Cc: stable@dpdk.org

Signed-off-by: Ryan Wolfe <rnwolfe@google.com>
---
 .mailmap                         | 1 +
 doc/guides/nics/features/gve.ini | 1 +
 drivers/net/gve/gve_ethdev.c     | 5 +++++
 3 files changed, 7 insertions(+)

diff --git a/.mailmap b/.mailmap
index 6d9e262cfb..87c544947c 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1477,6 +1477,7 @@ Ruifeng Wang <ruifeng.wang@arm.com>
 Rupesh Chiluka <rchiluka@marvell.com>
 Rushil Gupta <rushilg@google.com>
 Ryan E Hall <ryan.e.hall@intel.com>
+Ryan Wolfe <rnwolfe@google.com>
 Sabyasachi Sengupta <sabyasg@hpe.com>
 Sachin Saxena <sachin.saxena@nxp.com> <sachin.saxena@oss.nxp.com>
 Sagar Abhang <sabhang@brocade.com>
diff --git a/doc/guides/nics/features/gve.ini b/doc/guides/nics/features/gve.ini
index 9f3835edf6..5566511b6b 100644
--- a/doc/guides/nics/features/gve.ini
+++ b/doc/guides/nics/features/gve.ini
@@ -7,6 +7,7 @@
 Speed capabilities   = Y
 Queue start/stop     = Y
 MTU update           = Y
+Scattered Rx         = P
 TSO                  = Y
 RSS hash             = Y
 RSS key update       = Y
diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index 3c8d1a76e4..92a5a7679f 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -897,6 +897,11 @@ gve_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	dev_info->min_mtu = RTE_ETHER_MIN_MTU;
 
 	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_RSS_HASH;
+	/* GQI receives a frame larger than one Rx buffer as a chain of
+	 * buffers (gve_rx_burst follows GVE_RXF_PKT_CONT).
+	 */
+	if (gve_is_gqi(priv))
+		dev_info->rx_offload_capa |= RTE_ETH_RX_OFFLOAD_SCATTER;
 	if (priv->clk_read_type != GVE_DEV_CLK_UNSUPPORTED &&
 	    priv->nic_ts_report_mz != NULL)
 		dev_info->rx_offload_capa |= RTE_ETH_RX_OFFLOAD_TIMESTAMP;
