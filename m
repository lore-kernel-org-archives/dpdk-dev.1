Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D4D1090220
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Mar 2026 12:43:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F10B402C4;
	Thu, 19 Mar 2026 13:43:33 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id D8CFD4025D;
 Thu, 19 Mar 2026 13:43:31 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 9C41C205CA;
 Thu, 19 Mar 2026 13:43:31 +0100 (CET)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Thu, 19 Mar 2026 13:43:31 +0100
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org,
	Marat Khalili <marat.khalili@huawei.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Christophe Fontaine <cfontain@redhat.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 stable@dpdk.org
Subject: [PATCH v2] mbuf: fix read packet data
Date: Thu, 19 Mar 2026 12:43:29 +0000
Message-ID: <20260319124329.729034-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319084048.652493-1-mb@smartsharesystems.com>
References: <20260319084048.652493-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 19 Mar 2026 12:43:31.0318 (UTC)
 FILETIME=[FDFC2160:01DCB79D]
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

The sum of offset + length, both 32 bit unsigned integers, could wrap
around, causing comparisons to give the wrong result.
This was fixed by using 64 bit instead of 32 bit for calculating the sum.

Note:
When the branch is not taken for the initial "if ((uint64_t)off + len >
rte_pktmbuf_pkt_len(m))" comparison, the sum is known to not exceed the
maximum possible value of rte_pktmbuf_pkt_len(m), UINT32_MAX, and
following sum calculations can proceed using 32 bit.

Also, fixed a related bug in an mbuf test case:
It expected reading a length of UINT_MAX from a non-zero offset to not
fail.
And due to the offset+length wraparound bug, the read operation did not
fail.
This test case was updated to expect the read operation to fail.

Fixes: b84110e7baa2 ("mbuf: add function to read packet data")
Fixes: 7b295dceea07 ("test/mbuf: add unit test cases")
Cc: stable@dpdk.org

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
v2:
* Fixed mbuf test case. (Marat Khalili)
---
 app/test/test_mbuf.c | 18 +++++++++---------
 lib/mbuf/rte_mbuf.c  |  2 +-
 lib/mbuf/rte_mbuf.h  |  2 +-
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/app/test/test_mbuf.c b/app/test/test_mbuf.c
index a41d2d0f97..db23259745 100644
--- a/app/test/test_mbuf.c
+++ b/app/test/test_mbuf.c
@@ -2037,13 +2037,13 @@ test_pktmbuf_read_from_offset(struct rte_mempool *pktmbuf_pool)
 	/* read length greater than mbuf data_len */
 	if (rte_pktmbuf_read(m, hdr_len, rte_pktmbuf_data_len(m) + 1,
 				NULL) != NULL)
-		GOTO_FAIL("%s: Requested len is larger than mbuf data len!\n",
+		GOTO_FAIL("%s: Requested offset + len is larger than mbuf data len!\n",
 				__func__);
 
 	/* read length greater than mbuf pkt_len */
 	if (rte_pktmbuf_read(m, hdr_len, rte_pktmbuf_pkt_len(m) + 1,
 				NULL) != NULL)
-		GOTO_FAIL("%s: Requested len is larger than mbuf pkt len!\n",
+		GOTO_FAIL("%s: Requested offset + len is larger than mbuf pkt len!\n",
 				__func__);
 
 	/* read data of zero len from valid offset */
@@ -2065,21 +2065,21 @@ test_pktmbuf_read_from_offset(struct rte_mempool *pktmbuf_pool)
 
 	/* read data of max length from valid offset */
 	data_copy = rte_pktmbuf_read(m, hdr_len, UINT_MAX, NULL);
-	if (data_copy == NULL)
-		GOTO_FAIL("%s: Error in reading packet data!\n", __func__);
-	/* check if the received address is the beginning of data segment */
-	if (data_copy != data)
-		GOTO_FAIL("%s: Corrupted data address!\n", __func__);
+	if (data_copy != NULL)
+		GOTO_FAIL("%s: Requested offset + max len is larger than mbuf pkt len!\n",
+				__func__);
 
 	/* try to read from mbuf with max size offset */
 	data_copy = rte_pktmbuf_read(m, UINT_MAX, 0, NULL);
 	if (data_copy != NULL)
-		GOTO_FAIL("%s: Error in reading packet data!\n", __func__);
+		GOTO_FAIL("%s: Requested max offset is larger than mbuf pkt len!\n",
+				__func__);
 
 	/* try to read from mbuf with max size offset and len */
 	data_copy = rte_pktmbuf_read(m, UINT_MAX, UINT_MAX, NULL);
 	if (data_copy != NULL)
-		GOTO_FAIL("%s: Error in reading packet data!\n", __func__);
+		GOTO_FAIL("%s: Requested max offset + max len is larger than mbuf pkt len!\n",
+				__func__);
 
 	rte_pktmbuf_dump(stdout, m, rte_pktmbuf_pkt_len(m));
 
diff --git a/lib/mbuf/rte_mbuf.c b/lib/mbuf/rte_mbuf.c
index a5d16e4c97..c2476e7704 100644
--- a/lib/mbuf/rte_mbuf.c
+++ b/lib/mbuf/rte_mbuf.c
@@ -795,7 +795,7 @@ const void *__rte_pktmbuf_read(const struct rte_mbuf *m, uint32_t off,
 	const struct rte_mbuf *seg = m;
 	uint32_t buf_off = 0, copy_len;
 
-	if (off + len > rte_pktmbuf_pkt_len(m))
+	if ((uint64_t)off + len > rte_pktmbuf_pkt_len(m))
 		return NULL;
 
 	while (off >= rte_pktmbuf_data_len(seg)) {
diff --git a/lib/mbuf/rte_mbuf.h b/lib/mbuf/rte_mbuf.h
index 592af2388c..d6602f74bc 100644
--- a/lib/mbuf/rte_mbuf.h
+++ b/lib/mbuf/rte_mbuf.h
@@ -1843,7 +1843,7 @@ const void *__rte_pktmbuf_read(const struct rte_mbuf *m, uint32_t off,
 static inline const void *rte_pktmbuf_read(const struct rte_mbuf *m,
 	uint32_t off, uint32_t len, void *buf)
 {
-	if (likely(off + len <= rte_pktmbuf_data_len(m)))
+	if (likely((uint64_t)off + len <= rte_pktmbuf_data_len(m)))
 		return rte_pktmbuf_mtod_offset(m, char *, off);
 	else
 		return __rte_pktmbuf_read(m, off, len, buf);
-- 
2.43.0

