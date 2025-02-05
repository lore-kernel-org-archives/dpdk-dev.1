Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21617C02198
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 17:20:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9DF4F40654;
	Wed,  5 Feb 2025 18:20:15 +0100 (CET)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com
 [209.85.210.43]) by mails.dpdk.org (Postfix) with ESMTP id 2C20D4065A
 for <dev@dpdk.org>; Wed,  5 Feb 2025 18:20:13 +0100 (CET)
Received: by mail-ot1-f43.google.com with SMTP id
 46e09a7af769-7231e2ac9e4so20804a34.0
 for <dev@dpdk.org>; Wed, 05 Feb 2025 09:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1738776012; x=1739380812; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UWuAYBaKgdX+Un9qXrfMRRvrRrfbiYfltFAhwI4YYjU=;
 b=EGQnrqfW1S+ej/YpRY0CgwSlKhCMTcb5FQPq7JZn49rgmBzFqYedEfdRQ44e8nXwHA
 kN5wgvybVYrIA78NDdEo/NW85bG2otlvWagCeP6HTgfh0ENPVKFGMZMHU5ivl/9Zwklr
 LQntXZY1KaKWzf39Xacn095oZMim/3ZyDNwzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738776012; x=1739380812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UWuAYBaKgdX+Un9qXrfMRRvrRrfbiYfltFAhwI4YYjU=;
 b=deVDofr40c4vmYmqmTxSmsfiiIBWxPwMKHfB/DfYX0cSD/oDH0lT0WaggVYMazbMAa
 HaNN0YnPTdJMNUFqI39aiYUoOkA3U0C6L825wo1z3vTINyYb9/rftctMU/TBXla2ie69
 Zjn1Phcn7VUPMs+s3dOetNijzeqd6QsTsCbQ7uAcF4IhX9/dqpEDi/Sn+W9ITqCjOVTO
 zv1HoxdwtGDQn5xtieDTPUDyCyW6Cap5gwIlSP/9LpApa4cxP3vBMjZyCKz93xNnaYMf
 xc9GRqnNB3SS6e6/vWqV9vQu8eybHa9iyrmHCWrGwKl9sPJGxGreYarcHm/l5pV00ftR
 xtAg==
X-Gm-Message-State: AOJu0YxSREF7HGHdfIB3YlfYwn7bJsNBULhCxuiSOyeyrn8+R+8DZkGw
 zub7G9vj7wG5ekp0kvTng0aZUhP+MavAzxOdU5PxmkECmzEJF0IDUC1M13NCpvr11fY9uXWNbm0
 jbj1dYfiYYl9vEJADNU6pIpzMPxQeY558f2RZygWpTpyUPrQypmTl6kZDzZHCxox6h5R0jf6CXt
 mrhYKWPSumS7RJlS2/0DFZVy4+NxgS
X-Gm-Gg: ASbGnctSRyjB20vyg3Lfgsf1l2HHsotWcRIllZxDnKMfO+jaQJeLubBSKA9C9WWM82P
 +hMCyUNYZtOnCN74qKm7DeUbXBvFtLJjw8FBT3fff6hQdNUMYYd+9LIn2DWUoHjUamqb9gPnjzx
 cVvxxPByhDaLucewIC36cD8ElIHOyCHUNQKNTj5ml3eNen6xFed4lvZOBEXkRcNe3VRFmlAlTHd
 fATWmlD7E2ZvA9+5B3gLbm3SqmC/A9KPI5UiGNUa70kKKCzkC2Qml3NnD+gLMyMQG3z4ezUJ4ab
 M1jq/nAAsw7Sk+Kq/2vwZCohABG2BraCGaHP+XyM809Bi6ErWbsw5E/XBWW91Hpjgc29r+jiTK/
 3B93G10v0
X-Google-Smtp-Source: AGHT+IG77WQaBQZ8y0P6leCDQoBeW9cQFuJeID2hfjfB+XnLIkGxwlL/IGev08fVgNa3V+ybkQBhZw==
X-Received: by 2002:a05:6830:4487:b0:71e:f1:3e1 with SMTP id
 46e09a7af769-726a4145e06mr2659586a34.3.1738776012198; 
 Wed, 05 Feb 2025 09:20:12 -0800 (PST)
Received: from C02GC2QQMD6T.wifi.broadcom.net ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-726617cde49sm4004016a34.27.2025.02.05.09.20.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 09:20:11 -0800 (PST)
From: Ajit Khaparde <ajit.khaparde@broadcom.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net,
	stable@dpdk.org
Subject: [PATCH 03/11] net/bnxt: fix Rx handler
Date: Wed,  5 Feb 2025 09:19:56 -0800
Message-Id: <20250205172004.50395-4-ajit.khaparde@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250205172004.50395-1-ajit.khaparde@broadcom.com>
References: <20250205172004.50395-1-ajit.khaparde@broadcom.com>
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

Fix the code accounting the status of compressed CQE handler.
The code was inside the block handling the normal CQE mode.
Moved the code out. Without this the Rx datapath was broken
for compressed CQEs in scalar mode.

Fixes: 5c980062d895 ("net/bnxt: support compressed Rx CQE")
Cc: stable@dpdk.org
Signed-off-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
---
 drivers/net/bnxt/bnxt_rxr.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_rxr.c b/drivers/net/bnxt/bnxt_rxr.c
index 5b43bcbea6..b53d9a917a 100644
--- a/drivers/net/bnxt/bnxt_rxr.c
+++ b/drivers/net/bnxt/bnxt_rxr.c
@@ -1390,14 +1390,6 @@ uint16_t bnxt_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 		} else if ((CMP_TYPE(rxcmp) >= CMPL_BASE_TYPE_RX_TPA_START_V2) &&
 			   (CMP_TYPE(rxcmp) <= CMPL_BASE_TYPE_RX_TPA_START_V3)) {
 			rc = bnxt_rx_pkt(&rx_pkts[nb_rx_pkts], rxq, &raw_cons);
-			if (!rc)
-				nb_rx_pkts++;
-			else if (rc == -EBUSY)	/* partial completion */
-				break;
-			else if (rc == -ENODEV)	/* completion for representor */
-				nb_rep_rx_pkts++;
-			else if (rc == -ENOMEM)
-				nb_rx_pkts++;
 		} else if (!BNXT_NUM_ASYNC_CPR(rxq->bp)) {
 			evt =
 			bnxt_event_hwrm_resp_handler(rxq->bp,
@@ -1407,6 +1399,14 @@ uint16_t bnxt_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 				goto done;
 		}
 
+		if (!rc)
+			nb_rx_pkts++;
+		else if (rc == -EBUSY)	/* partial completion */
+			break;
+		else if (rc == -ENODEV)	/* completion for representor */
+			nb_rep_rx_pkts++;
+		else if (rc == -ENOMEM)
+			nb_rx_pkts++;
 		raw_cons = NEXT_RAW_CMP(raw_cons);
 		/*
 		 * The HW reposting may fall behind if mbuf allocation has
-- 
2.39.5 (Apple Git-154)

