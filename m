Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA834CC6B38
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 11:31:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C2D3406FF;
	Fri, 16 Oct 2026 13:31:35 +0200 (CEST)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181]) by mails.dpdk.org (Postfix) with ESMTP id 6C12C402EB
 for <dev@dpdk.org>; Fri, 16 Oct 2026 08:27:03 +0200 (CEST)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-3535bf8b3e0so4442730eec.0
 for <dev@dpdk.org>; Thu, 15 Oct 2026 23:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792132022; x=1792736822; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bOoJlCU9CWQymF8XEQlfGwgrH6OHY12VbWT4iQmr+Ik=;
 b=a3sJEBbtIUVV7t154tOW9w+ckzHKnaIaFhTgfKXVoi7XuE0pioKXRZE6vpuJkroAXS
 gCJjmtBC+G5yKUAnASjj9G5RRl6PoCm9kLygPfc74nSXCCsaOPCp5rscgsDbn4I6MotF
 0RhKiOmzvXuMcsk/8UPhcG0OvOhhZxR8Vg1QJF3C+992Mw6VCNcb2LjIKEqOvtSBqiW/
 GIaUUiUXmziFifVXgm9TkWG5ydkSh/N60+i+6kz1aKumAQ1HRfs5sE0f5EbXGe4ffool
 r1xQnjSoi/YPZRHzV5gWlYo5Ah3y2gldEpf9FhEaZXkAdVyAXOa4sT1k3UfgZGR1SyVN
 zvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792132022; x=1792736822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bOoJlCU9CWQymF8XEQlfGwgrH6OHY12VbWT4iQmr+Ik=;
 b=M1tkTpeHXC3rvkZWfpKmDf4S3rwDFUa9hDBf3Ogaqzzc9qvWq3UU+uuQTLbXVaJQ7W
 pPgPjdY7CTRX0K3glrrwsIkmijtb8sDBIliaVAG05UczW0JqG1GwdBDNEa/Hazeo8Ldr
 jh9C6sbIwv8MFZxNoCua7gjzJZxl9sY7ci/0mXmRuo9yTXUWiBtXZoQqR+x+0ktrcaoS
 01WiiD+Udv06QVySvsy+1HFh5YHnLcGF4y/XlewESbhMzh+C+yFmJiunBvg83gVmL3Bp
 XyPeYhp4TQds3gNHvj/F3DJGeRBxtJ6px35knfNdL8cz17DBt33/MOv5ttMGZEIoORPl
 EVkQ==
X-Gm-Message-State: AFq9FYISJ7L7/pGldzmSICF5tYr/LTZPxb9VpTSRddM1jMcZSkVwB9fA
 C45VjMH79t7tKBLHxToD7RqhfdxDERlwEbyHTy3kIONS5v9jrw00YF5dub0gGg==
X-Gm-Gg: AYBFou1/ASul/DoE9dz10AbcoCNzdEcYR3vpElU89hiqtP57cGJZj3lNtKPfLn3JIhg
 xD+vlbR8i/KUp8Xpg5Lpl7GbxmlhS/PxIPNQbIkTjrQO75US58G98rej8sgAktaP4a3S1OpzUcI
 A4KGn6xBZM94BRMZMHlzEyPN9n5EzxoIoWyc+hk8PjMSfEfobdkwkXeijgGCaWx7egMHkZoJH/H
 oncn2kbKdxfuDlHJ6SnumW3mR/Ym2E3Ro/1Le0j0vp9DPuveBy5MFBxsE0FuPDqW0aigKhSpkBP
 CslOpwYw8qARQ2lcLXxJa5NCJvbB1ywcXnzi1j5JKIUid0ekSzEWVdiANGSq6/aPZFRiW9fhG1Y
 tLrc5W3qTMUDytsu5M3p11Vjy7dI9l1BLSBxJuurVA9nKdSn5DQcr7Na1oJ43t9WdJNbuOr20PC
 OTsyC+M8DHRg8a10047/P7m9gtPVlfSORabuOfo4ph2GCkFyfShj4AnEEq5TrFE6qm+32bLGWD
X-Received: by 2002:a05:701b:4649:b0:182:9071:3249 with SMTP id
 a92af1059eb24-1829071340bmr2348276c88.30.1792132022434; 
 Thu, 15 Oct 2026 23:27:02 -0700 (PDT)
Received: from aviuser.. ([192.19.252.250]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-183190aa3ebsm2743324c88.8.2026.10.15.23.27.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 23:27:02 -0700 (PDT)
From: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
To: dev@dpdk.org
Cc: joshwash@google.com,
	stephen@networkplumber.org,
	stable@dpdk.org
Subject: [PATCH v3 04/10] net/gve: fix stray TSO context descriptor on tag
 exhaustion
Date: Fri, 16 Oct 2026 06:26:41 +0000
Message-ID: <afad8110ea0c66e44c3f265ce9ea11eb066fd3c0.1792129992.git.tathagat.dpdk@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792129992.git.tathagat.dpdk@gmail.com>
References: <cover.1792129992.git.tathagat.dpdk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 16 Oct 2026 13:31:30 +0200
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

For TSO packets, the context descriptor is written and tx_id advanced
before a completion tag is allocated. If no tag is available, the
burst stops, but when earlier packets in the burst were sent, the
tail written at the end of the burst still covers the context
descriptor. The device then receives it with no data descriptors
behind it, and the slot is never deducted from nb_free.

Allocate the completion tag before writing any descriptor.

Fixes: 5fd289ff3a00 ("net/gve: support out-of-order completions on DQ Tx")
Cc: stable@dpdk.org

Signed-off-by: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
---
 drivers/net/gve/gve_tx_dqo.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
index a2ebadd0b8..36d56b7d26 100644
--- a/drivers/net/gve/gve_tx_dqo.c
+++ b/drivers/net/gve/gve_tx_dqo.c
@@ -308,15 +308,15 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 			break;
 		}
 
+		if (!gve_free_compl_tags_pop(txq, &compl_tag))
+			break;
+
 		if (tso) {
 			txd = &txr[tx_id];
 			gve_tx_fill_seg_desc_dqo(txd, tx_pkt);
 			tx_id = (tx_id + 1) & mask;
 		}
 
-		if (!gve_free_compl_tags_pop(txq, &compl_tag))
-			break;
-
 		pkts[compl_tag].mbuf = tx_pkt;
 		while (tx_pkt) {
 			/* Skip writing descriptors if mbuf has no data. */
-- 
2.43.0

