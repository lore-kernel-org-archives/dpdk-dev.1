Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C945BFF5106
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 15:17:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9326340659;
	Tue,  7 Apr 2026 17:17:44 +0200 (CEST)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mails.dpdk.org (Postfix) with ESMTP id 7600240654
 for <dev@dpdk.org>; Tue,  7 Apr 2026 17:17:43 +0200 (CEST)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-c76b95e652bso1642017a12.3
 for <dev@dpdk.org>; Tue, 07 Apr 2026 08:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775575062;
 x=1776179862; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+LH0sVG46i6spXShnxf5US5jJVkIYroHe739/z0Bcvc=;
 b=ieTTgC8lOze70gE5meWhungDsdtAyZ61r0U86btsv1VyM+D3fksblLF94zdHaXVcZ2
 K4fqbaHKjaJ9k+4qvfyIfOLzZ+szPXxh9iQKFSToOkUpREFMQ+cSfXFRwJeZGgPxrua/
 GyaGIfGRpRaodM73Oun2rutrGnUTxN4QsFWKgNXzi5OYdPi74rz1ixqC1GXLzA0TcElG
 wh/AeXJYk7ozFh30n/ij9i5Bdk2S1+5G2ENicRJ7AhOoHbCSuIgUz4NKNm6OFhwm5dQP
 EQPGi+y6EcqV0iHxmgXRtVKqIwVbto/+23kBEWw7b6d3tsojmqgKjoRRBaY42EiH/X9X
 B2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775575062; x=1776179862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+LH0sVG46i6spXShnxf5US5jJVkIYroHe739/z0Bcvc=;
 b=NJbooavJXWQU/26tiesR0z7i8e3nm8SRFptETEmXo1lvsVFACGKXbkpKpvdb0NH/fT
 ZFcaQnW58uGwsHwRgkKv8zxG+tu+96lXpdnv62VA9i4yTTyvgj7+fFhY1kHfjgMU2gL6
 eM2AV57wrQ4i6kCw+w+hsPXjXWU51fsuS3JvNYQF2Iu0ErQubTKNIypfZ5/1NSB2X4AR
 Lp8XtxZTTqBT2LBCgUcJ/r4EiA1i0GDbN0kr+Tx2B1iq4Nb5ysopLNHkM2fs7O5R2Exh
 i6WvkK98DqVAelex0bupEwuCzwuVKdcH1dh36Rsq3C4CIVdizb/Y0UCtTFFDaFc8TObQ
 IVPA==
X-Gm-Message-State: AOJu0YwckyawwU871Q/Z5b8vA5m4LYO4iGNwvSdI3QRZbGgodAfpd/c6
 vKPJLvZ54rofuT7uOMHC+C1MHJJIbCA+IBHsAmwdLqchftRMZorNPIJaFiGSYTwbr4IqNLwHDQC
 WZkzK
X-Gm-Gg: AeBDietrIqmrUROx2UltGHUjmjh3p5z33p1SSE8zYHWVvfdazAnd1UoKF+I3neBw+XG
 AoInwuhUnE8WZ8jFmRFLAwPPZwiLT94q1VYFVeJP0l91DcRJHHyryCOEy7vozfPfEBxZ2h6w2JP
 UI+HEG7OdopToGRwiMSdswvYSbyHj+DenPuNv43HEUl9ZBL5XPxgFQn47j8j1oOD4s9JsAXKorM
 6Gb3K8U9aryDun7n1N4I5t+IaAo3RES+9gVd7DH4xnEwt80fGwbhpT9CevpamdWmJlSxl7EpVUo
 C5kwiHMu+3DF/L8j1M7Kor6i9hEHStOt73YG+0EXfa3rHQDIK9uV0bmR5M+pD02T859WbIlhaPK
 O7V6TP/oBD9pqum8yXOWW2QCI3owADFL2pS7taOtDmaGYA/RJAumEeRiuCYSIx9CLhfgoWIKT65
 AlBaHf6DbWPNiqgGxrNIeK05j6wVAdM7iN
X-Received: by 2002:a05:6a20:958e:b0:398:a027:4732 with SMTP id
 adf61e73a8af0-39f2f0a3accmr16760036637.52.1775575062576; 
 Tue, 07 Apr 2026 08:17:42 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6477bbcsm15842933a12.3.2026.04.07.08.17.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 08:17:42 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 01/23] examples/ethtool: resolve shadow variable warnings
Date: Tue,  7 Apr 2026 08:15:57 -0700
Message-ID: <20260407151732.272195-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407151732.272195-1-stephen@networkplumber.org>
References: <20260407035209.650419-1-stephen@networkplumber.org>
 <20260407151732.272195-1-stephen@networkplumber.org>
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

Fix shadow variable warning by renaming the function parameter
from 'app_cfg' to 'ptr_cfg' to avoid shadowing the global variable.

../examples/ethtool/ethtool-app/main.c:89:44: warning: declaration of
'app_cfg' shadows a global declaration [-Wshadow]

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 examples/ethtool/ethtool-app/main.c | 4 ++--
 examples/ethtool/meson.build        | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/examples/ethtool/ethtool-app/main.c b/examples/ethtool/ethtool-app/main.c
index b6bbae70d2..6545eb322d 100644
--- a/examples/ethtool/ethtool-app/main.c
+++ b/examples/ethtool/ethtool-app/main.c
@@ -86,7 +86,7 @@ void mark_port_newmac(int idx_port)
 	ptr_port->port_dirty = 1;
 }
 
-static void setup_ports(struct app_config *app_cfg, int cnt_ports)
+static void setup_ports(struct app_config *ptr_cfg, int cnt_ports)
 {
 	int idx_port;
 	int size_pktpool;
@@ -101,7 +101,7 @@ static void setup_ports(struct app_config *app_cfg, int cnt_ports)
 	cfg_port.txmode.mq_mode = RTE_ETH_MQ_TX_NONE;
 
 	for (idx_port = 0; idx_port < cnt_ports; idx_port++) {
-		struct app_port *ptr_port = &app_cfg->ports[idx_port];
+		struct app_port *ptr_port = &ptr_cfg->ports[idx_port];
 
 		ret = rte_eth_dev_info_get(idx_port, &dev_info);
 		if (ret != 0)
diff --git a/examples/ethtool/meson.build b/examples/ethtool/meson.build
index 3ad948d109..d7f63d48af 100644
--- a/examples/ethtool/meson.build
+++ b/examples/ethtool/meson.build
@@ -17,7 +17,6 @@ sources = files(
         'ethtool-app/main.c',
 )
 includes = include_directories('lib', 'ethtool-app')
-cflags += no_shadow_cflag
 
 deps += 'bus_pci'
 if dpdk_conf.has('RTE_NET_IXGBE')
-- 
2.53.0

