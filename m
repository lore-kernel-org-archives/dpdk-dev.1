Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2704CC021B5
	for <dpdk-dev@archiver.kernel.org>; Sat, 22 Feb 2025 03:58:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F01D742D7F;
	Sat, 22 Feb 2025 04:58:02 +0100 (CET)
Received: from lf-1-20.ptr.blmpb.com (lf-1-20.ptr.blmpb.com [103.149.242.20])
 by mails.dpdk.org (Postfix) with ESMTP id D68CF42D68
 for <dev@dpdk.org>; Sat, 22 Feb 2025 04:57:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1740196675; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=7Ey7pGd0zKPLz66EDaIqwi7a76i53s81BDGMfj0vX4w=;
 b=Jt3DtOVQXOkOQ5qHSs8CX9FKkoDXq5mRxnkh9KKxHWgkZ86PDqi3p7bV3Jaf8U4qTrEaly
 igDFvELptBmnCW80CkoP/1PESONDThkM+zz3CToKoNqj4H4pzpJJoRXE6bCcJON05pcofn
 oEvMt+4yreyTFHDNTuYD4PlyVFC8lm5QezD4JC3VL/kOBWZawrfX8DpOBb8DiFOEbvatBK
 en9hxMogenosUoJg3LcXhB9bYn+/9CAIBf0+/Ip5lOflrV1QBYXxkmfKjJICOraq+Cef54
 lmLbeJ012J6DJwydvjjAPVYKnoaZz8CV4h9pANd/ej81HTscuNCpz5BLKW3uiQ==
Content-Transfer-Encoding: 7bit
Cc: <thomas@monjalon.net>, <stephen@networkplumber.org>, 
 <qianr@yunsilicon.com>, <nana@yunsilicon.com>, <zhangxx@yunsilicon.com>, 
 <xudw@yunsilicon.com>, <jacky@yunsilicon.com>, <weihg@yunsilicon.com>, 
 <zhenghy@yunsilicon.com>
From: "Renyong Wan" <wanry@yunsilicon.com>
References: <20250222035732.2290067-1-wanry@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+267b94b41+88b331+dpdk.org+wanry@yunsilicon.com>
Message-Id: <20250222035751.2290067-11-wanry@yunsilicon.com>
Mime-Version: 1.0
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
To: <dev@dpdk.org>
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn
 with ESMTPS; Sat, 22 Feb 2025 11:57:52 +0800
Subject: [PATCH 10/12] net/xsc: avoid initialize by same function
Date: Sat, 22 Feb 2025 11:57:53 +0800
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250222035732.2290067-1-wanry@yunsilicon.com>
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

This issue was reported by PVS studio, described as:
https://pvs-studio.com/en/docs/warnings/v656

Signed-off-by: Renyong Wan <wanry@yunsilicon.com>
---
 drivers/net/xsc/xsc_rx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/xsc/xsc_rx.c b/drivers/net/xsc/xsc_rx.c
index c031e56a94..ca832dab23 100644
--- a/drivers/net/xsc/xsc_rx.c
+++ b/drivers/net/xsc/xsc_rx.c
@@ -445,10 +445,8 @@ xsc_rxq_elts_alloc(struct xsc_rxq_data *rxq_data)
 
 		mbuf->port = rxq_data->port_id;
 		mbuf->nb_segs = 1;
-		rte_pktmbuf_data_len(mbuf) = rte_pktmbuf_data_room_size(rxq_data->mp)
-						- mbuf->data_off;
-		rte_pktmbuf_pkt_len(mbuf) = rte_pktmbuf_data_room_size(rxq_data->mp)
-						- mbuf->data_off;
+		rte_pktmbuf_data_len(mbuf) = mbuf->buf_len - mbuf->data_off;
+		rte_pktmbuf_pkt_len(mbuf) = rte_pktmbuf_data_len(mbuf);
 		(*rxq_data->elts)[i] = mbuf;
 	}
 
-- 
2.25.1
