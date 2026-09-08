Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0926AC79F82
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 10:15:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0ABB44069D;
	Tue,  8 Sep 2026 12:15:55 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 49E2A40374
 for <dev@dpdk.org>; Tue,  8 Sep 2026 12:15:54 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=rjd8LDkSZ12hezF6sos2eiKMR/729wsw45H69tY/y7w=;
 b=aJh6yi247sCPPUlkks3T9xFO/EjTQ+aalTFMN3fgB6QPw4UoCrzdDkafKfN2NuuZcUpukCEQh
 Rdw31JERZFiCU2lludfzmJQ07RllJIP2CXB6tomyc2T76YgSD4k+zaeWsuHVBMI/T7nG5DDQjNr
 l2EN58SxflzQeNHn0fAtt9Y=
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hfKYn3LxFzHnH4v
 for <dev@dpdk.org>; Tue,  8 Sep 2026 18:14:53 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id EC19940584
 for <dev@dpdk.org>; Tue,  8 Sep 2026 18:15:52 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 12:15:52 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: 
CC: <dev@dpdk.org>
Subject: [PATCH] cmdline: add cmdline_ prefix to dprintf
Date: Tue, 8 Sep 2026 11:15:34 +0100
Message-ID: <20260908101534.71961-1-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema100004.china.huawei.com (7.182.19.128) To
 frapema500003.china.huawei.com (7.182.19.114)
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

Macro `dprintf` defined in `cmdline_cirbuf.h` may clash with eponymous
glibc macro. Add `cmdline_` prefix to the one defined by DPDK.

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 lib/cmdline/cmdline.c        |  2 +-
 lib/cmdline/cmdline_cirbuf.c | 28 ++++++++++++++--------------
 lib/cmdline/cmdline_cirbuf.h |  6 +++---
 lib/cmdline/cmdline_socket.c |  2 +-
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/lib/cmdline/cmdline.c b/lib/cmdline/cmdline.c
index 51fbc36cefe1..1b2df0dcc8f6 100644
--- a/lib/cmdline/cmdline.c
+++ b/lib/cmdline/cmdline.c
@@ -113,7 +113,7 @@ RTE_EXPORT_SYMBOL(cmdline_free)
 void
 cmdline_free(struct cmdline *cl)
 {
-	dprintf("called\n");
+	cmdline_dprintf("called\n");
 
 	if (!cl)
 		return;
diff --git a/lib/cmdline/cmdline_cirbuf.c b/lib/cmdline/cmdline_cirbuf.c
index 07d9fc6b904f..5cc09c887ca3 100644
--- a/lib/cmdline/cmdline_cirbuf.c
+++ b/lib/cmdline/cmdline_cirbuf.c
@@ -41,13 +41,13 @@ cirbuf_add_buf_head(struct cirbuf *cbuf, const char *c, unsigned int n)
 	e = CIRBUF_IS_EMPTY(cbuf) ? 1 : 0;
 
 	if (n < cbuf->start + e) {
-		dprintf("s[%d] -> d[%d] (%d)\n", 0, cbuf->start - n + e, n);
+		cmdline_dprintf("s[%d] -> d[%d] (%d)\n", 0, cbuf->start - n + e, n);
 		memcpy(cbuf->buf + cbuf->start - n + e, c, n);
 	}
 	else {
-		dprintf("s[%d] -> d[%d] (%d)\n", + n - (cbuf->start + e), 0,
+		cmdline_dprintf("s[%d] -> d[%d] (%d)\n", + n - (cbuf->start + e), 0,
 			cbuf->start + e);
-		dprintf("s[%d] -> d[%d] (%d)\n", cbuf->maxlen - n +
+		cmdline_dprintf("s[%d] -> d[%d] (%d)\n", cbuf->maxlen - n +
 			(cbuf->start + e), 0, n - (cbuf->start + e));
 		memcpy(cbuf->buf, c  + n - (cbuf->start + e) , cbuf->start + e);
 		memcpy(cbuf->buf + cbuf->maxlen - n + (cbuf->start + e), c,
@@ -73,13 +73,13 @@ cirbuf_add_buf_tail(struct cirbuf *cbuf, const char *c, unsigned int n)
 	e = CIRBUF_IS_EMPTY(cbuf) ? 1 : 0;
 
 	if (n < cbuf->maxlen - cbuf->end - 1 + e) {
-		dprintf("s[%d] -> d[%d] (%d)\n", 0, cbuf->end + !e, n);
+		cmdline_dprintf("s[%d] -> d[%d] (%d)\n", 0, cbuf->end + !e, n);
 		memcpy(cbuf->buf + cbuf->end + !e, c, n);
 	}
 	else {
-		dprintf("s[%d] -> d[%d] (%d)\n", cbuf->end + !e, 0,
+		cmdline_dprintf("s[%d] -> d[%d] (%d)\n", cbuf->end + !e, 0,
 			cbuf->maxlen - cbuf->end - 1 + e);
-		dprintf("s[%d] -> d[%d] (%d)\n", cbuf->maxlen - cbuf->end - 1 +
+		cmdline_dprintf("s[%d] -> d[%d] (%d)\n", cbuf->maxlen - cbuf->end - 1 +
 			e, 0, n - cbuf->maxlen + cbuf->end + 1 - e);
 		memcpy(cbuf->buf + cbuf->end + !e, c, cbuf->maxlen -
 		       cbuf->end - 1 + e);
@@ -352,19 +352,19 @@ cirbuf_get_buf_head(struct cirbuf *cbuf, char *c, unsigned int size)
 		return 0;
 
 	if (cbuf->start <= cbuf->end) {
-		dprintf("s[%d] -> d[%d] (%d)\n", cbuf->start, 0, n);
+		cmdline_dprintf("s[%d] -> d[%d] (%d)\n", cbuf->start, 0, n);
 		memcpy(c, cbuf->buf + cbuf->start , n);
 	}
 	else {
 		/* check if we need to go from end to the beginning */
 		if (n <= cbuf->maxlen - cbuf->start) {
-			dprintf("s[%d] -> d[%d] (%d)\n", 0, cbuf->start, n);
+			cmdline_dprintf("s[%d] -> d[%d] (%d)\n", 0, cbuf->start, n);
 			memcpy(c, cbuf->buf + cbuf->start , n);
 		}
 		else {
-			dprintf("s[%d] -> d[%d] (%d)\n", cbuf->start, 0,
+			cmdline_dprintf("s[%d] -> d[%d] (%d)\n", cbuf->start, 0,
 				cbuf->maxlen - cbuf->start);
-			dprintf("s[%d] -> d[%d] (%d)\n", 0, cbuf->maxlen - cbuf->start,
+			cmdline_dprintf("s[%d] -> d[%d] (%d)\n", 0, cbuf->maxlen - cbuf->start,
 				n - cbuf->maxlen + cbuf->start);
 			memcpy(c, cbuf->buf + cbuf->start , cbuf->maxlen - cbuf->start);
 			memcpy(c + cbuf->maxlen - cbuf->start, cbuf->buf,
@@ -391,19 +391,19 @@ cirbuf_get_buf_tail(struct cirbuf *cbuf, char *c, unsigned int size)
 		return 0;
 
 	if (cbuf->start <= cbuf->end) {
-		dprintf("s[%d] -> d[%d] (%d)\n", cbuf->end - n + 1, 0, n);
+		cmdline_dprintf("s[%d] -> d[%d] (%d)\n", cbuf->end - n + 1, 0, n);
 		memcpy(c, cbuf->buf + cbuf->end - n + 1, n);
 	}
 	else {
 		/* check if we need to go from end to the beginning */
 		if (n <= cbuf->end + 1) {
-			dprintf("s[%d] -> d[%d] (%d)\n", 0, cbuf->end - n + 1, n);
+			cmdline_dprintf("s[%d] -> d[%d] (%d)\n", 0, cbuf->end - n + 1, n);
 			memcpy(c, cbuf->buf + cbuf->end - n + 1, n);
 		}
 		else {
-			dprintf("s[%d] -> d[%d] (%d)\n", 0,
+			cmdline_dprintf("s[%d] -> d[%d] (%d)\n", 0,
 				cbuf->maxlen - cbuf->start, cbuf->end + 1);
-			dprintf("s[%d] -> d[%d] (%d)\n",
+			cmdline_dprintf("s[%d] -> d[%d] (%d)\n",
 				cbuf->maxlen - n + cbuf->end + 1, 0, n - cbuf->end - 1);
 			memcpy(c + cbuf->maxlen - cbuf->start,
 					       cbuf->buf, cbuf->end + 1);
diff --git a/lib/cmdline/cmdline_cirbuf.h b/lib/cmdline/cmdline_cirbuf.h
index 8e571462ca5c..acd95ebc82ba 100644
--- a/lib/cmdline/cmdline_cirbuf.h
+++ b/lib/cmdline/cmdline_cirbuf.h
@@ -23,10 +23,10 @@ struct cirbuf {
 };
 
 #ifdef RTE_LIBRTE_CMDLINE_DEBUG
-#define dprintf_(fmt, ...) printf("line %3.3d - " fmt "%.0s", __LINE__, __VA_ARGS__)
-#define dprintf(...) dprintf_(__VA_ARGS__, "dummy")
+#define cmdline_dprintf_(fmt, ...) printf("line %3.3d - " fmt "%.0s", __LINE__, __VA_ARGS__)
+#define cmdline_dprintf(...) cmdline_dprintf_(__VA_ARGS__, "dummy")
 #else
-#define dprintf(...) (void)0
+#define cmdline_dprintf(...) ((void)0)
 #endif
 
 
diff --git a/lib/cmdline/cmdline_socket.c b/lib/cmdline/cmdline_socket.c
index f3d62acdae41..9af3789fbc91 100644
--- a/lib/cmdline/cmdline_socket.c
+++ b/lib/cmdline/cmdline_socket.c
@@ -26,7 +26,7 @@ cmdline_file_new(cmdline_parse_ctx_t *ctx, const char *prompt, const char *path)
 
 	fd = open(path, O_RDONLY, 0);
 	if (fd < 0) {
-		dprintf("open() failed\n");
+		cmdline_dprintf("open() failed\n");
 		return NULL;
 	}
 	return cmdline_new(ctx, prompt, fd, -1);
-- 
2.43.0

