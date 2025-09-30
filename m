Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6591BCAC5B8
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 07:10:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0777C40ED0;
	Tue, 30 Sep 2025 09:06:06 +0200 (CEST)
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com
 [209.85.214.225])
 by mails.dpdk.org (Postfix) with ESMTP id 6D846402A2
 for <dev@dpdk.org>; Tue, 30 Sep 2025 02:37:24 +0200 (CEST)
Received: by mail-pl1-f225.google.com with SMTP id
 d9443c01a7336-27d4d6b7ab5so79691875ad.2
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759192643; x=1759797443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gkRyulW4lfOVm4TeHnHm5SaaCDky+7PT5BGsz+PYxkw=;
 b=v4P3+X8WiI+h7lemOTsz+lQ8oTwB/Ss7E3W16aZRK1uuSyT9J3QUhU65KZq8qHVJ5h
 r4KSAmOTtUFNfviXsDArh00TeS6OfZs8bolYqLnBlA/R102v99bZcA4iv7Oj1qvJHvEs
 vxOgJ3L8I8OREl1kmX9mbnh5GKd5iWzOptYt6fjh4uGr03zGG9BR4ruPgtQMuJvJR62R
 uYXujRoXPj5F2RpjhQ5Nxj79p/vvKnCSH9W7rjflShPZWHAdcKr8vOM6Yl2N/HUfCwcC
 bBuSS2PZtnCs+O12nHllredASm07wAx+giJdW2p2P56oSeQ1VP5Bvy6XPevqxcIJCuUV
 Mxkw==
X-Gm-Message-State: AOJu0YxMYXZ8EAu439JA2Wg7aWdfTHS3T4jJ95x4D2hbAnC1RVu3DqpO
 A3aWHmfslq/JlYzUYwiQU67hxc5z58fYITMBVeDUeLCrB39feHUwG+LW5wkZ7xtQr4t2Le8i3xm
 zsfWziHbV4TDUi8JZY8yy2OzqWAw6LvNyJWHdyaHfmXRSFhJY922/fYy8/JMMcBcRPcuJVW6Xb5
 Ld4vSuPMHTgEzwD35u/mejTAFNcBjeymQCOGgzE/bfklYp+tKDr3VKTWzl8cKt+GokslN9Xg==
X-Gm-Gg: ASbGncuG9Sf9CXxr87c21FFhy1aCwuHErISLa/hFl5OGmw9FRYHJnrLfqfK3HcA+zeb
 WbhY1/1IrHP2CmtQWYmNwEg5SI+iuGWAOM04ZZrSCSOAQ1i9Pv6Wk5Klyg0ouUp2vO9Mwf9QehP
 yB8jYbRcA/E4BUzcy+YIHE5HdtcLrOMFPz7Hrq3UlMrxEs2VJ1lzYEr9glugyHfybQ9XRnG7Xfg
 06DqtsNm/wmd5QX6WPMujpL/rDwzrIcmaQ2ofQub7EU58KNCLAJp1N59jy0BD5TNwqe1dZcdqi5
 CufO4qC6prfi/015w9wlHxt0B4lmcQv0va/57MvJWRL0HpovAIztOTL69B9pMV4TWCz6vsLBO3n
 xDo9VrXGzv3DhNCUBpPWiN2irdYjZRYa4NgZo0PnISf8LjJv7+dnYLCtRx6X5LXNxkTVXJ2gI3r
 HlBcQ8p2s=
X-Google-Smtp-Source: AGHT+IFIVp4aNNPFUhnvl0KlZ1RnmJEPqnux59Cvma+a5ktKAoZSNfHFVxb5aGSq1oQ37HRjQlswyhUg/mHU
X-Received: by 2002:a17:902:f54c:b0:271:479d:3de3 with SMTP id
 d9443c01a7336-27ed49c7763mr211542655ad.12.1759192643542; 
 Mon, 29 Sep 2025 17:37:23 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-116.dlp.protect.broadcom.com. [144.49.247.116])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-334736cbb23sm821492a91.8.2025.09.29.17.37.23
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Sep 2025 17:37:23 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-7810af03a63so8806695b3a.3
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1759192641; x=1759797441; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gkRyulW4lfOVm4TeHnHm5SaaCDky+7PT5BGsz+PYxkw=;
 b=Tu7u5H3r579E+gaqhx3bhGri34+jllrV183597xFqoTABQUB8nLvcw7SBpM2Bxz7QP
 P7l5aA9asyZQ1uUBi32+5q6cw7EeACTBqfCQ18Ay/205OHFCi/DQ2xlrTRedhKmgtIcp
 +J5z5QBBIGRla1Yckf9n+rUvIy7mrvlj3RWkY=
X-Received: by 2002:a05:6a20:729c:b0:2be:81e3:1124 with SMTP id
 adf61e73a8af0-2e7c44124d8mr23535801637.2.1759192641362; 
 Mon, 29 Sep 2025 17:37:21 -0700 (PDT)
X-Received: by 2002:a05:6a20:729c:b0:2be:81e3:1124 with SMTP id
 adf61e73a8af0-2e7c44124d8mr23535770637.2.1759192640863; 
 Mon, 29 Sep 2025 17:37:20 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bb97dsm12234825a12.9.2025.09.29.17.37.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 17:37:20 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Farah Smith <farah.smith@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Peter Spreadborough <peter.spreadborough@broadcom.com>
Subject: [PATCH 34/54] net/bnxt: fix adding udp_tunnel_port
Date: Mon, 29 Sep 2025 20:35:44 -0400
Message-Id: <20250930003604.87108-35-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250930003604.87108-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Mailman-Approved-At: Tue, 30 Sep 2025 09:05:07 +0200
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

From: Farah Smith <farah.smith@broadcom.com>

Do not increment the port count if adding the same value multiple
times.

Signed-off-by: Farah Smith <farah.smith@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Peter Spreadborough <peter.spreadborough@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
---
 drivers/net/bnxt/bnxt_ethdev.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index fad357f3ae..a395c2ab47 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -2622,7 +2622,6 @@ bnxt_udp_tunnel_port_add_op(struct rte_eth_dev *eth_dev,
 				PMD_DRV_LOG_LINE(ERR, "Only one port allowed");
 				return -ENOSPC;
 			}
-			bp->vxlan_port_cnt++;
 			return 0;
 		}
 		tunnel_type =
@@ -2636,7 +2635,6 @@ bnxt_udp_tunnel_port_add_op(struct rte_eth_dev *eth_dev,
 				PMD_DRV_LOG_LINE(ERR, "Only one port allowed");
 				return -ENOSPC;
 			}
-			bp->geneve_port_cnt++;
 			return 0;
 		}
 		tunnel_type =
@@ -2650,7 +2648,6 @@ bnxt_udp_tunnel_port_add_op(struct rte_eth_dev *eth_dev,
 				PMD_DRV_LOG_LINE(ERR, "Only one port allowed");
 				return -ENOSPC;
 			}
-			bp->ecpri_port_cnt++;
 			return 0;
 		}
 		tunnel_type =
-- 
2.39.5 (Apple Git-154)

