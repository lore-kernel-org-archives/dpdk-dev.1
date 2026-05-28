Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92485CD5BD5
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 May 2026 08:47:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B33D44026F;
	Thu, 28 May 2026 10:47:35 +0200 (CEST)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by mails.dpdk.org (Postfix) with ESMTP id 501154021F
 for <dev@dpdk.org>; Thu, 28 May 2026 10:47:34 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id A6F1BEC0177;
 Thu, 28 May 2026 04:47:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Thu, 28 May 2026 04:47:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm3; t=1779958053; x=1780044453; bh=ik
 wCOjl49p8ewCXe3YopO9okH0dnJX26GlSeJ4e1bWc=; b=uO4RGjyO/eGWC5HhTu
 yth1UTpRpN9Xv7wW0duX8yh8Mc8finrZ7lYeLH+kELGjFaDSmKWWX0mMtoO9DSOX
 fLi1vaOaGcYPQZia+6ImiLkgpnmJ6mTOVmPPSgwd8stsgrS5tP0Sj9vN00YhQt0W
 uCGmdY+fAAfYN2BqpQBnWBcQ8pFhLZVtaSSMK82czmgO4bBK7KTVhXJjvqCfpmyG
 sGfbgHvwM70jDZSsjSW5QGdaazeBGSS6nuogvFXO6LBH1gDD2UbihQmOD9qHdT/a
 +/DaGs+HzaymW37TR7Alwv9fSDS9/PtZ7DY2Fm7w0jS0sxF8Qt0CgH6VW9ehCJSe
 pAlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1779958053; x=1780044453; bh=ikwCOjl49p8ewCXe3YopO9okH0dn
 JX26GlSeJ4e1bWc=; b=pPaiYf6lDMpSVRGIdA7VaFd1U5lz8A0igNQeE/UGxhDh
 7UauDHWKpDnfHh1sbYUI064G0pYOCarusrD8UMcFpa0bXZIry/4zUTLFrCjpNoxd
 NDE1lylA+9fhnSt1LegBwlU6KJQrMdMlOkrbgay3jamPXodKrcM0COzk5EM5/HOV
 ntX0UszvPcaRukAn0diNDPg8zqd1fsvLGva4CjwJ+COoU4qzPbClJ4V1bNT8grnX
 r1Qv2VSO9Xl/w4j+wU3wUgtP72gpaeOEfPo8rv4dOf+sj+1qQFJTkmqUrzhAFbL7
 YjRfyAlLzrfMqRpgeWWfJojtXohekOBbrojjxZgvrA==
X-ME-Sender: <xms:JAEYapVZGihtdbwgI5I2yImxW8-zLAVRmwCZuh0xy40cPKY4Z_SXgQ>
 <xme:JAEYal7vukzTVdYrKXKA2NAx7JtmhnpW8VdQbm0jkmgGCefiHFhzJeewD-kp1WPvo
 lCHpf3k7xbj8H1S6I39fGFoXrOfhQ5lfO-xZthGYb7TEckSo9N4YSA>
X-ME-Received: <xmr:JAEYaoJoTdxjpoyBKOt4QExkUxti-5ku8pVflPZIyXBnJzOZAxWwSPloJFZrweNdGEMO8UMMYdRQn0f-EhIH7hw4jJeX3pg>
X-ME-Proxy-Cause: dmFkZTGsOXC7sHgCj/eTayGOO7a0Y/ZcR/C0hxCsTIFyI0dvyFJNJ/rfTtV9xS7ICr/I6d
 ngoEkM8/1h4cN2iK5vNlvnegyun/HRvtsv9eToDnywfihFUHPTsczZRGn7xIQaJp1gbTmI
 A8TdXm2KntIInPCjRcAN0foYkJmk/nGXZ7sdWlb2vPrzjCccb6gJmVuWBSAq1LLPPfQy4W
 M+nEul4RPoPjaCEfpBcUPQeDRSDlT9Hi4QMaKlXV+j0v0SQ/peTSQqXpsPmaBcBZ/JRH2c
 S4T6ia3MlNzExLX+eD/zpUkI4pZ1GbOTxaoAJlaAxgTv/7JBEjmZRHLcusN1I1jZlUANot
 ritERhM3rJaJQujhZpaDvR2+Z3aVI/OJV+J2EgDEULuGKPD9cBjHWJ3tQTAaHbRoB7XC8S
 hORNyPeq6yhpFQJ8RmXve6YCCWbkoqlE0zdR+qe6rQ7LyO0Dw5ZMJFDvn/bA0GYY2DXM2H
 CqrzFnqyjPY7E8zls+COkFyj9gGjSp9lkHskvOu06ciFTMV3AtO5uTwyuR/knaBL9+NMyu
 meVg4Zm1DwWgRhalkiksZun0gCc8fc3hABw0VNdhzpdwC5FSEExjEqvvvQ1IXX1DThMRNp
 sEf1SGEifLz/vvzMasLLCU7kn4oSp7jZHsH7xM5qKZn/pWT379rZd/knRzXg
X-ME-Proxy: <xmx:JAEYauLqRUXXHbVYgYzdlgHb5TGyW-w6k-eZ0iXBYyLsAj0mUGTYTw>
 <xmx:JAEYamUEbQivpGQvlSImGub3DcQ-Wjkj12eKl00tVuqOmtDy4xCotw>
 <xmx:JAEYagjmU1PRIP7N81hbUrDPJr10j9mrNFlWFdoF5xO6tCgAQrt6aw>
 <xmx:JAEYah-fisTJ9z7jny4Ukj14PulBjX4aQVy6C-LOtimPtbTN-1virg>
 <xmx:JQEYas3CCKZe2u1Fhmpx5v3mQX81MUQx7VhEMVNL8rQtC9NrXvrFMOoU>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 May 2026 04:47:31 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH] net/sxe2: fix 32-bit SSE build
Date: Thu, 28 May 2026 10:47:16 +0200
Message-ID: <20260528084717.1754057-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Seen in OBS on i586 Debian:

from ../drivers/net/sxe2/sxe2_txrx_vec_sse.c:5:
	In function ‘_mm_loadu_si128’,
		inlined from ‘rte_memcpy’
		inlined from ‘sxe2_rx_pkts_refactor’
			at ../drivers/net/sxe2/sxe2_txrx_vec_common.h:233:2:
	/usr/lib/gcc/i686-linux-gnu/12/include/emmintrin.h:703:10: error:
	array subscript 8 is outside array bounds of ‘struct rte_mbuf *[32]’

The important options to reproduce are "-m32 -O2 -march=corei7".

In 32-bit build the pointer array done_pkts[32] is smaller:
	32 * 4 = 128 bytes
so an SSE access  would be outside the bound.

The libc memcpy does not trigger such warning
and is a good choice to copy an array of pointers.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 drivers/net/sxe2/sxe2_txrx_vec_common.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/sxe2/sxe2_txrx_vec_common.h b/drivers/net/sxe2/sxe2_txrx_vec_common.h
index 99e1663f03..6b1649c390 100644
--- a/drivers/net/sxe2/sxe2_txrx_vec_common.h
+++ b/drivers/net/sxe2/sxe2_txrx_vec_common.h
@@ -230,7 +230,8 @@ sxe2_rx_pkts_refactor(struct sxe2_rx_queue *rxq,
 	}
 	rxq->pkt_first_seg = first_seg;
 	rxq->pkt_last_seg  = last_seg;
-	rte_memcpy(mbuf_bufs, done_pkts, done_num * (sizeof(struct rte_mbuf *)));
+	memcpy(mbuf_bufs, done_pkts, done_num * sizeof(*done_pkts));
 	return done_num;
 }
+
 #endif /* SXE2_TXRX_VEC_COMMON_H */
-- 
2.54.0

