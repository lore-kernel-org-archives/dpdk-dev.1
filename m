Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241DCF01832
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 13:31:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DFD174279A;
	Fri,  6 Mar 2026 14:31:02 +0100 (CET)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id EA67D42797
 for <dev@dpdk.org>; Fri,  6 Mar 2026 14:31:01 +0100 (CET)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-483487335c2so77949365e9.2
 for <dev@dpdk.org>; Fri, 06 Mar 2026 05:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772803861; x=1773408661; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m6h/q+bchSYAS0Ma91kplavWv8qr0mJGbtbLvxxAfic=;
 b=d20ft0i9nPXH/ZQ2W68SDoLu8I3GbmiR96jyRpnaSXs0blKTp8r2IkXaHPOBEDM6Dk
 4QDMvPnXm5OUQHp43xaoSpsz78ho8VA4jEcjdF+tPe1hzQcvLHxSIcyKZIOdzYkd/h6Z
 GD3h40aFpop/p8udLCGDU5z0WKIq+Y+jvz8zwdhUtQPFrgdLggN5eyiWxm4ejRiojOTZ
 wH+VrklQgJsID6BV1EeGGbcPmKeRr5CYoKCStXmAL9s1weiwp6NW6tGd5fxHWeteCZdq
 LHldaBBFLV7d//svETfNE/XoTtdTFjAdWHs3uMfoxhRD4wIZM3xF8ATxcbiVhh+0bj9W
 qTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772803861; x=1773408661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m6h/q+bchSYAS0Ma91kplavWv8qr0mJGbtbLvxxAfic=;
 b=vujjO/wlegqRCrpYSz7gfTpn7dhCBT2cFjBR/2x4Kvn5K3YN+dmWnNadhXWnpvVIDV
 8pTUw7FQqIAcBep9juCTCBlU6IXa7Tm4L7Ddp2VbIBhlisUs49FEoqyov0RtLleLOQZg
 I7ZT53AJxSgH41WrUFf6EUL5XhHFiBqiSPP7aNs2/LLAVqYMMBIGPX82zvSj6eWx+5LY
 mTkz0kcdNRL4+kBIcNBS3hkE4vCeQfPghZMePoOxVEye+kx8ZMZuna9cKXG1IbyFwRCl
 +WG9QngDg44uyOO3qkNxArjlvkYa5yj3oCJtmNazZdZN4BUU4I7dTCAdeF4HAbWubzo6
 YuFA==
X-Gm-Message-State: AOJu0Yz096a0lhE1CU1N4SXTlqOZu+OJogrVYXB4WD9krHfYxBDcUjP1
 ljHhPRy/IAZa0Eox+E+8X+WiJtj10G++Rd20ZPI/Rv5UzKcvJBP18S1TqYh46zZc
X-Gm-Gg: ATEYQzzhEmHnz/ZT8KPJUCWQfAu8cpTFk14VSEjbjO7HlQu6RKT+olP0t78tS5YqbBZ
 lG6qMWDdMoUh4k11JsctSwGtxEqKKmLWUzBDgf1o+rGLh0LJY8khbLABK68UzK8N6ELJwsJevWP
 VQBRyl8tKzpQGtaEb95Y9I/vXTGJmPKaFFH7gGzBgXScYaROctyyebOSCVNqUCvsc3XOWRyr2eA
 UvCyXikpnPstsdbP+TqvdcfG4+deRWgHmF/yauROoACWLM3xArC5u6vuy22aMmYJUW77vFodfd4
 b5ZzaS4pfUb6zfb/dIOOmMmCVuCVoSGupdV/hjkHsTkin1hbCtR4zCh9oWx3UaQN1jAFtiTI//p
 JChLDKqJ2abYnfvYZ7rd7ZKmeLHtdvS3OBJ1kdbrMlcQtH6/Rv4qhAAu2Wm1wPcnc9XFRT1wULF
 1nq5eVenMA6xc76GXfe7RPZighOSk=
X-Received: by 2002:a05:600c:8b68:b0:477:df7:b020 with SMTP id
 5b1f17b1804b1-48526969730mr37399685e9.18.1772803861309; 
 Fri, 06 Mar 2026 05:31:01 -0800 (PST)
Received: from freepad.iliad.local ([213.36.9.102])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dada9116sm3903909f8f.14.2026.03.06.05.31.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 05:31:00 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 david.marchand@redhat.com, Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org
Subject: [PATCH v3 08/17] net/dpaa2: fix error packet dump crash and memory
 leak
Date: Fri,  6 Mar 2026 14:30:26 +0100
Message-ID: <20260306133035.179709-9-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226143341.282188-1-maxime@leroys.fr>
References: <20260226143341.282188-1-maxime@leroys.fr>
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

Fix three bugs in dump_err_pkts().

1. NULL pointer dereference: mbuf was checked for NULL but then
   dereferenced unconditionally on the next line.

2. Memory leak on multi-segment packets: the while loop walked
   mbuf to NULL, so the subsequent rte_pktmbuf_free(mbuf) was a
   no-op and the packet was never freed. Use a separate iterator
   variable and free the original mbuf pointer.

3. Segment index not reset between packets: variable i was
   initialized once at function scope and never reset inside the
   do/while loop, so hexdump titles had wrong segment numbers.
   Make it local to the multi-segment block.

Not tested, found by code review.

Fixes: f9465bdcef9d ("net/dpaa2: fix error frame dump")
Cc: stable@dpdk.org

Reported-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 drivers/net/dpaa2/dpaa2_rxtx.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index 5a98f295a7..0de52cbef2 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -651,7 +651,7 @@ dump_err_pkts(struct dpaa2_queue *dpaa2_q)
 	const struct qbman_fd *fd;
 	struct qbman_pull_desc pulldesc;
 	struct rte_eth_dev_data *eth_data = dpaa2_q->eth_data;
-	uint32_t lcore_id = rte_lcore_id(), i = 0;
+	uint32_t lcore_id = rte_lcore_id();
 	void *v_addr, *hw_annot_addr;
 	struct dpaa2_fas *fas;
 	struct rte_mbuf *mbuf;
@@ -726,24 +726,27 @@ dump_err_pkts(struct dpaa2_queue *dpaa2_q)
 			DPAA2_GET_FD_OFFSET(fd), DPAA2_GET_FD_ERR(fd),
 			fas->status);
 
-		if (mbuf)
+		if (mbuf) {
 			__rte_mbuf_sanity_check(mbuf, 1);
-		if (mbuf->nb_segs > 1) {
-			while (mbuf) {
-				sprintf(title, "Payload seg[%d]", i);
-				rte_hexdump(stderr, title,
+			if (mbuf->nb_segs > 1) {
+				struct rte_mbuf *seg = mbuf;
+				int i = 0;
+
+				while (seg) {
+					sprintf(title, "Payload seg[%d]", i);
+					rte_hexdump(stderr, title,
+						(char *)seg->buf_addr + seg->data_off,
+						seg->data_len);
+					seg = seg->next;
+					i++;
+				}
+			} else {
+				rte_hexdump(stderr, "Payload",
 					(char *)mbuf->buf_addr + mbuf->data_off,
 					mbuf->data_len);
-				mbuf = mbuf->next;
-				i++;
 			}
-		} else {
-			rte_hexdump(stderr, "Payload",
-				(char *)mbuf->buf_addr + mbuf->data_off,
-				mbuf->data_len);
+			rte_pktmbuf_free(mbuf);
 		}
-
-		rte_pktmbuf_free(mbuf);
 		dq_storage++;
 		num_rx++;
 	} while (pending);
-- 
2.43.0

