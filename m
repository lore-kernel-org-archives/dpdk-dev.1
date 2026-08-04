Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC5DC5518F
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Aug 2026 08:14:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A79594064E;
	Tue,  4 Aug 2026 10:13:40 +0200 (CEST)
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by mails.dpdk.org (Postfix) with ESMTP id 21F754065A
 for <dev@dpdk.org>; Tue,  4 Aug 2026 10:13:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1785831218;
 bh=N9k9/beG7OHs6JaP0p2WdcheYSvc8YqBU2BPWkt4Shc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YzOz1gkVjm6VKx9Vsw/L+EagDUXi2Qu0PInoo7BUROwwmJZYr/eLL60Q7QsBatxtD
 3c/4S8pX9o2YByvOJg3zHl4oqwuAmDss/Vfy76RnZKLr+v5KmaVZ6jBQyfuixlZALV
 0ZXWZiye3a0YIbWLOOIro5gmZLkll8W0qqF6OIrJdCBNceoXhGvFt8AEXomHfWK9/y
 wgS6nLuBGo3debi4EZhFGBc80RMvDFOoMK4WVUOVhTpmxRbU5jzmZBUodcrDHWXdro
 vHZMUkVGvbDKwlwn3X0FwCyjRniG/lxUu5CognGUn2eWbJ55BF17flp8v2mM+G20BL
 kZ6/vk4YLnbcA==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
 by mail.lysator.liu.se (Postfix) with ESMTP id C5DAFF19D
 for <dev@dpdk.org>; Tue,  4 Aug 2026 10:13:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1785831218;
 bh=N9k9/beG7OHs6JaP0p2WdcheYSvc8YqBU2BPWkt4Shc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YzOz1gkVjm6VKx9Vsw/L+EagDUXi2Qu0PInoo7BUROwwmJZYr/eLL60Q7QsBatxtD
 3c/4S8pX9o2YByvOJg3zHl4oqwuAmDss/Vfy76RnZKLr+v5KmaVZ6jBQyfuixlZALV
 0ZXWZiye3a0YIbWLOOIro5gmZLkll8W0qqF6OIrJdCBNceoXhGvFt8AEXomHfWK9/y
 wgS6nLuBGo3debi4EZhFGBc80RMvDFOoMK4WVUOVhTpmxRbU5jzmZBUodcrDHWXdro
 vHZMUkVGvbDKwlwn3X0FwCyjRniG/lxUu5CognGUn2eWbJ55BF17flp8v2mM+G20BL
 kZ6/vk4YLnbcA==
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
 id 96131F079; Tue,  4 Aug 2026 10:13:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1785831207;
 bh=N9k9/beG7OHs6JaP0p2WdcheYSvc8YqBU2BPWkt4Shc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=sA4bLFrOnSfOicTtAFN31g5RziS0PsIpLwIBRZ6rS9Gd+KXbX1G70c4rG4fZc6zLZ
 3p/rw3YE0cOWdy4QjlbY+f1Fg4szIjzCNCdIoaiFXVZtaAYefT1rXcxyoe/CoS3+6H
 d5Islu10PHn8ZSULydnVDv/EHUi1Zw3CBZ6NrXULu3EEGfDa4SXZKEGXtxBGp2qb61
 j5kR82LhJcutnd0fqMQlEMxcK8bZC4bHAh1w3W5P1vOjtQu6SrE7DbPyqG/GWIYAku
 V7fGBQmLvY/qV4me7g2OnJpRGrIMBhAdqOxdzXp+qVCyXIS/MbxbS4D1l7gX55EUJ+
 Z9vd3scpsfc0Q==
Received: from isengard.friendlyfire.se (h-62-63-215-114.A163.priv.bahnhof.se
 [62.63.215.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by mail.lysator.liu.se (Postfix) with ESMTPSA id 749BDF18B;
 Tue,  4 Aug 2026 10:13:27 +0200 (CEST)
From: =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <hofors@lysator.liu.se>
To: stephen@networkplumber.org, thomas@monjalon.net,
 andrew.rybchenko@oktetlabs.ru, sriram.yagnaraman@ericsson.com
Cc: dev@dpdk.org, bingz@nvidia.com, rasland@nvidia.com,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>
Subject: [RFC 5/5] net: add eCPRI IWF message headers
Date: Tue,  4 Aug 2026 10:13:19 +0200
Message-ID: <20260804081319.1869087-6-hofors@lysator.liu.se>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804081319.1869087-1-hofors@lysator.liu.se>
References: <20260804081319.1869087-1-hofors@lysator.liu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

From: Mattias Rönnblom <mattias.ronnblom@ericsson.com>

The IWF message types were defined, but not their message headers, so
an IWF message could be identified but not described.

Add the IWF Start-Up (type #8), IWF Operation (type #9), IWF Mapping
(type #10) and IWF Delay Control (type #11) message headers, and the
Action Type values of the latter two, per eCPRI V2.0 figures 31A, 31B,
31L and 31O and tables 14A and 14C. As for the other message types,
only the header is described; the payload, such as the chunks of an IWF
Operation message, is left to the user.

struct rte_ecpri_combined_msg_hdr keeps its size, since the One-Way
Delay Measurement header remains the largest.

Signed-off-by: Mattias Rönnblom <mattias.ronnblom@ericsson.com>
---
 lib/net/rte_ecpri.h | 79 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/lib/net/rte_ecpri.h b/lib/net/rte_ecpri.h
index 5fcc4e5853..ef0e8ced4c 100644
--- a/lib/net/rte_ecpri.h
+++ b/lib/net/rte_ecpri.h
@@ -108,6 +108,28 @@
 #define RTE_ECPRI_EVT_IND_SYNC_ACK	0x04
 #define RTE_ECPRI_EVT_IND_SYNC_END	0x05
 
+/*
+ * Action Type of Message Type #10: IWF Mapping
+ * 0x00: SetRxConfigRequest
+ * 0x01: SetRxConfigResponseAccept
+ * 0x02: SetRxConfigResponseReject
+ * 0x03: SetRxConfigResponsePropose
+ * 0x04...0xFF: Reserved
+ */
+#define RTE_ECPRI_IWF_MAP_ACT_SET_RX_CFG_REQ	0x00
+#define RTE_ECPRI_IWF_MAP_ACT_SET_RX_CFG_ACC	0x01
+#define RTE_ECPRI_IWF_MAP_ACT_SET_RX_CFG_REJ	0x02
+#define RTE_ECPRI_IWF_MAP_ACT_SET_RX_CFG_PRP	0x03
+
+/*
+ * Action Type of Message Type #11: IWF Delay Control
+ * 0x00: Request get delays
+ * 0x01: Response get delays
+ * 0x02...0xFF: Reserved
+ */
+#define RTE_ECPRI_IWF_DCTRL_ACT_GET_DLY_REQ	0x00
+#define RTE_ECPRI_IWF_DCTRL_ACT_GET_DLY_RSP	0x01
+
 /**
  * eCPRI Common Header
  */
@@ -219,6 +241,59 @@ struct rte_ecpri_msg_event_ind {
 	uint8_t number;			/**< Number of Faults/Notif */
 };
 
+/**
+ * eCPRI Message Header of Type #8: IWF Start-Up
+ */
+struct __rte_packed_begin rte_ecpri_msg_iwf_up {
+	rte_be16_t pc_id;		/**< Physical channel ID */
+	uint8_t hfn;			/**< #Z: CPRI hyperframe number */
+	uint8_t bfn;			/**< #X: CPRI basic frame number */
+	rte_be32_t timestamp;		/**< Timestamp, in nanoseconds */
+#if RTE_BYTE_ORDER == RTE_LITTLE_ENDIAN
+	uint8_t line_rate:5;		/**< CPRI line rate */
+	uint8_t res:1;			/**< Reserved */
+	uint8_t s:1;			/**< CPRI scrambling indicator */
+	uint8_t f:1;			/**< CPRI FEC indicator */
+#elif RTE_BYTE_ORDER == RTE_BIG_ENDIAN
+	uint8_t f:1;			/**< CPRI FEC indicator */
+	uint8_t s:1;			/**< CPRI scrambling indicator */
+	uint8_t res:1;			/**< Reserved */
+	uint8_t line_rate:5;		/**< CPRI line rate */
+#endif
+} __rte_packed_end;
+
+/**
+ * eCPRI Message Header of Type #9: IWF Operation
+ *
+ * The header is followed by one or more chunks, each but the first one
+ * preceded by its own hyperframe and basic frame number.
+ */
+struct rte_ecpri_msg_iwf_opt {
+	rte_be16_t pc_id;		/**< Physical channel ID */
+	uint8_t hfn;			/**< #Z: CPRI hyperframe number */
+	uint8_t bfn;			/**< #X: CPRI basic frame number */
+};
+
+/**
+ * eCPRI Message Header of Type #10: IWF Mapping
+ */
+struct rte_ecpri_msg_iwf_map {
+	rte_be16_t pc_id;		/**< Physical channel ID */
+	uint8_t cfg_id;			/**< Mapping Config ID */
+	uint8_t act_type;		/**< Action Type */
+};
+
+/**
+ * eCPRI Message Header of Type #11: IWF Delay Control
+ */
+struct rte_ecpri_msg_iwf_dctrl {
+	rte_be16_t pc_id;		/**< Physical channel ID */
+	uint8_t dc_id;			/**< Delay Control ID */
+	uint8_t act_type;		/**< Action Type */
+	rte_be32_t delay_a;		/**< Delay A, in 1/16 ns */
+	rte_be32_t delay_b;		/**< Delay B, in 1/16 ns */
+};
+
 /**
  * eCPRI Combined Message Header Format: Common Header + Message Types
  */
@@ -233,6 +308,10 @@ struct rte_ecpri_combined_msg_hdr {
 		struct rte_ecpri_msg_delay_measure type5;
 		struct rte_ecpri_msg_remote_reset type6;
 		struct rte_ecpri_msg_event_ind type7;
+		struct rte_ecpri_msg_iwf_up type8;
+		struct rte_ecpri_msg_iwf_opt type9;
+		struct rte_ecpri_msg_iwf_map type10;
+		struct rte_ecpri_msg_iwf_dctrl type11;
 		rte_be32_t dummy[5];
 	};
 };
-- 
2.43.0

