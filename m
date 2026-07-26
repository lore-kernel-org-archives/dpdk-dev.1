Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0504EC531C9
	for <dpdk-dev@archiver.kernel.org>; Sun, 26 Jul 2026 17:03:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4818340269;
	Sun, 26 Jul 2026 19:03:26 +0200 (CEST)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by mails.dpdk.org (Postfix) with ESMTP id ECD7140269
 for <dev@dpdk.org>; Sun, 26 Jul 2026 19:03:24 +0200 (CEST)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-930f72317a6so132595585a.3
 for <dev@dpdk.org>; Sun, 26 Jul 2026 10:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785085404; x=1785690204; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=O4R76pSCJHEpAlkyzL9GN+J0hRWubf54xg/MYZn6vvc=;
 b=NrbKY3oH9APj44aiwaYmgryhfYHNtq62NnAZDbJF+yQhRcu/FA5DVfDYPr3XaVuuMV
 Mx07km3FgAeDudqY9d+amqQtGsdiMxyF+N2rSHd5PUeFdSlRTfgHtkAYjiY9C/O7K8IU
 bYNtJzdAwvR4I54R8V1rei3H/tWthMs7p7gzYWAtF0UNvL1mlHj6qxW46aVXAvvD0nGa
 p1GQWO7yzvQbu2wjUwF9wcFhe5/daPW6f+2F/d10EEfumtLOqrvo65hf1FPZ5SLG2l7A
 UXqdHHa25+oBLnop0FvdB/uEnSGOllyptHx7u6E5De5JO4ugpQTHb4AsHgDbRxWmc8qu
 2p+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785085404; x=1785690204;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O4R76pSCJHEpAlkyzL9GN+J0hRWubf54xg/MYZn6vvc=;
 b=FOEpkk73Z3VKONtC1xPJ234/v0N/wX0/OwzRSFUXxVr7xa6gHo4io6iotIWmQK7tX/
 oKbK+S8g3/A2IXTtEPXCDqIPWTnOluP0JOl2Lq3JYNHyQxrl1ACfOiEnPpeOdtISbOjl
 XMbIO+mUDE/O/CRyfIbfbK14IpWHpIEDlKqQl1pEaRKANmWalk+lyTgpHxbx2lA8xKZp
 IVYrn40KI+PqFPX9va1IWQP3E5TlaU0svOxodircih7uDxandKGKy2M3OdpHHJflh13U
 7CAHkFBmpTKPRScIwfTTzimM1m8wgHgkiCf97fox+Hr84gtTaGTVeh8xAvS5lxthUdHe
 Y/IQ==
X-Gm-Message-State: AOJu0YxrbZeZAo9AW15H3AR7vllvz4UsZvnkpvDO+pd5Z2iM59lFCPOr
 5KSN8CFzomtMfaId3qWFpsem28plVkIOEppfqrzcOf5gYBKk+218opEE
X-Gm-Gg: AR+sD12XSHmY15Uw9kSwYhOcLaicoOReYFC1xmlTvV/MlBO4SNWu5FxK5rET6mMaP8I
 hXXF0sAX8a3thElTURt3lvJ5h6ioIW/tVLWRh8apr5ViSr4jWKsIT+BU4yLnOsCDkkNACZnfvHK
 5wfib3fTzBu+tUuQVpEatNSmEraid8F5tiBM1tj++J894CBqQ5fAGDoTwxxgaKImpe+C+Lpz+rU
 E0naZwBJ37XXLHAgn/aX4oDxEdCsFVpzhrdCzIBsWt2J3mWILWogZTp4hefSi4zGWBk0j3dYh00
 clOHkqa0Rt9INPp3G30GoXmyiYsFWxsy0CpEFyu/FhlLEITVEORYg8UjR6gUuRx41QphfaNkzNF
 Bf9NZaQU54K1p5uGvFU6lpxjChowNbQv76lkwx74ATXSTXbRgJwKyeNvcB4ar6EpiCeiZfMU=
X-Received: by 2002:a05:620a:4006:b0:930:9585:e08e with SMTP id
 af79cd13be357-932df653884mr571272685a.10.1785085404034; 
 Sun, 26 Jul 2026 10:03:24 -0700 (PDT)
Received: from gmail.com ([50.93.222.110]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-932de636183sm412745585a.27.2026.07.26.10.03.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 10:03:23 -0700 (PDT)
From: Weijun Pan <wpan3636@gmail.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>, Jan Blunck <jblunck@infradead.org>
Cc: dev@dpdk.org,
	Weijun Pan <wpan3636@gmail.com>,
	stable@dpdk.org
Subject: [PATCH] net/vhost: preserve Tx ownership on VLAN failure
Date: Sun, 26 Jul 2026 12:02:58 -0500
Message-Id: <20260726170258.8791-1-wpan3636@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The Tx path compacts the input mbuf array after software VLAN
insertion fails. Later packets are moved into the failed packet's
slot while the failed mbuf is freed.

The returned count then no longer identifies a prefix of the original
burst. An application freeing the unsent suffix can therefore free
duplicate or stale mbuf pointers.

Stop preprocessing at the first VLAN insertion failure and leave the
failed mbuf and the remaining suffix owned by the caller. Count only
packets prepared for vhost enqueue but not accepted as missed.

Bugzilla ID: 1884
Fixes: f63d356ee993 ("net/vhost: insert/strip VLAN header in software")
Cc: stable@dpdk.org

Signed-off-by: Weijun Pan <wpan3636@gmail.com>
---
Cc: Jan Blunck <jblunck@infradead.org>

Tested:
- Full x86_64 debug build with AddressSanitizer.
- Two-process net_vhost and virtio-user data-path test.
- Forced VLAN insertion failure on packet 1 by removing its headroom.
- rte_eth_tx_burst() returned 1 and preserved the unsent suffix.
- testpmd received 1 packet with no RX errors or missed packets.

 drivers/net/vhost/rte_eth_vhost.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/vhost/rte_eth_vhost.c b/drivers/net/vhost/rte_eth_vhost.c
index 05940f2461..9a85f1e26d 100644
--- a/drivers/net/vhost/rte_eth_vhost.c
+++ b/drivers/net/vhost/rte_eth_vhost.c
@@ -474,19 +474,17 @@ eth_vhost_tx(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
 		/* Do VLAN tag insertion */
 		if (m->ol_flags & RTE_MBUF_F_TX_VLAN) {
 			int error = rte_vlan_insert(&m);
-			if (unlikely(error)) {
-				rte_pktmbuf_free(m);
-				continue;
-			}
+
+			if (unlikely(error))
+				break;
 		}
 
 		if (r->internal->tx_sw_csum)
 			vhost_dev_tx_sw_csum(m);
 
-
-		bufs[nb_send] = m;
-		++nb_send;
+		bufs[i] = m;
 	}
+	nb_send = i;
 
 	/* Enqueue packets to guest RX queue */
 	while (nb_send) {
@@ -506,7 +504,7 @@ eth_vhost_tx(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
 	for (i = 0; likely(i < nb_tx); i++)
 		nb_bytes += bufs[i]->pkt_len;
 
-	nb_missed = nb_bufs - nb_tx;
+	nb_missed = nb_send;
 
 	r->stats.pkts += nb_tx;
 	r->stats.bytes += nb_bytes;
-- 
2.34.1

