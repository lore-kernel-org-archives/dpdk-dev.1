Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05ACDD116F1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 11:47:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1189640DC9;
	Mon,  1 Dec 2025 12:45:29 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id EDB6C40261;
 Mon,  1 Dec 2025 12:45:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764589524; x=1796125524;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cp7rTmxf41klHOtPq7uE/ueZNbpJNNjJHGrFJwHEB5g=;
 b=SzDhSHcjuBqlb2dCEKZ0PhNgJSWIkOOVaTWL+A0FiqY/87Kf8buIF9lm
 eOKnKxbSVElq+OsszcsxNUPNGdxKRst6WoJOLc8z4AlLMZUNwndcokMEX
 9QxqcEj3LE0ixJZ3gIBhg0MFRc9RTMWuuwgCl5mc1L+C05TmMHljemllB
 3Ns5fmxFKOZh3ualutS9Y9Mf13QT5lRstu9oQCNjKUZo8cvqKDoS07HSX
 HvmxIun4r1N8dn6Vt1OrcYyh3tx6ZUTtRxJTs9LRmlaIejmKkAE3VVrqm
 TsEYu/uICQwopUmEVVN05PX8/KCCuZdH0srS+CLjd+fP3i4VIfnLAdPV3 g==;
X-CSE-ConnectionGUID: BC2cjG2ZR56HiRGosmFoAg==
X-CSE-MsgGUID: 00r7BPvjRHKaEzWoo7hlZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="77991749"
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; d="scan'208";a="77991749"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2025 03:45:24 -0800
X-CSE-ConnectionGUID: oA1JSgmoQ4Oe+hTWaq1ACA==
X-CSE-MsgGUID: HEvcRV7yQ5eYD3si0eqnLA==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 01 Dec 2025 03:45:23 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 19/31] app/graph: fix build with shadow warnings enabled
Date: Mon,  1 Dec 2025 11:44:36 +0000
Message-ID: <20251201114448.1441377-20-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251201114448.1441377-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251201114448.1441377-1-bruce.richardson@intel.com>
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

The global variable "conn" conflicted with the local parameter to each
function in the graph conn.c file. To prevent shadowing, use "c" as the
name for the local connection variable throughout the file.

Fixes: 3f90eda5b7fb ("app/graph: add telnet connectivity")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/graph/conn.c | 134 +++++++++++++++++++++++------------------------
 1 file changed, 67 insertions(+), 67 deletions(-)

diff --git a/app/graph/conn.c b/app/graph/conn.c
index 44934602c7..c5e1c1ae1b 100644
--- a/app/graph/conn.c
+++ b/app/graph/conn.c
@@ -20,12 +20,12 @@
 #define MSG_CMD_TOO_LONG "Command too long."
 
 static int
-data_event_handle(struct conn *conn, int fd_client)
+data_event_handle(struct conn *c, int fd_client)
 {
 	ssize_t len, i, rc = 0;
 
 	/* Read input message */
-	len = read(fd_client, conn->buf, conn->buf_size);
+	len = read(fd_client, c->buf, c->buf_size);
 	if (len == -1) {
 		if ((errno == EAGAIN) || (errno == EWOULDBLOCK))
 			return 0;
@@ -38,37 +38,37 @@ data_event_handle(struct conn *conn, int fd_client)
 
 	/* Handle input messages */
 	for (i = 0; i < len; i++) {
-		if (conn->buf[i] == '\n') {
+		if (c->buf[i] == '\n') {
 			size_t n;
 
-			conn->msg_in[conn->msg_in_len] = 0;
-			conn->msg_out[0] = 0;
+			c->msg_in[c->msg_in_len] = 0;
+			c->msg_out[0] = 0;
 
-			conn->msg_handle(conn->msg_in, conn->msg_out, conn->msg_out_len_max,
-					 conn->msg_handle_arg);
+			c->msg_handle(c->msg_in, c->msg_out, c->msg_out_len_max,
+					 c->msg_handle_arg);
 
-			n = strlen(conn->msg_out);
+			n = strlen(c->msg_out);
 			if (n) {
-				rc = write(fd_client, conn->msg_out, n);
+				rc = write(fd_client, c->msg_out, n);
 				if (rc == -1)
 					goto exit;
 			}
 
-			conn->msg_in_len = 0;
-		} else if (conn->msg_in_len < conn->msg_in_len_max) {
-			conn->msg_in[conn->msg_in_len] = conn->buf[i];
-			conn->msg_in_len++;
+			c->msg_in_len = 0;
+		} else if (c->msg_in_len < c->msg_in_len_max) {
+			c->msg_in[c->msg_in_len] = c->buf[i];
+			c->msg_in_len++;
 		} else {
 			rc = write(fd_client, MSG_CMD_TOO_LONG, strlen(MSG_CMD_TOO_LONG));
 			if (rc == -1)
 				goto exit;
 
-			conn->msg_in_len = 0;
+			c->msg_in_len = 0;
 		}
 	}
 
 	/* Write prompt */
-	rc = write(fd_client, conn->prompt, strlen(conn->prompt));
+	rc = write(fd_client, c->prompt, strlen(c->prompt));
 	rc = (rc == -1) ? -1 : 0;
 
 exit:
@@ -76,11 +76,11 @@ data_event_handle(struct conn *conn, int fd_client)
 }
 
 static int
-control_event_handle(struct conn *conn, int fd_client)
+control_event_handle(struct conn *c, int fd_client)
 {
 	int rc;
 
-	rc = epoll_ctl(conn->fd_client_group, EPOLL_CTL_DEL, fd_client, NULL);
+	rc = epoll_ctl(c->fd_client_group, EPOLL_CTL_DEL, fd_client, NULL);
 	if (rc == -1)
 		goto exit;
 
@@ -99,7 +99,7 @@ conn_init(struct conn_params *p)
 {
 	int fd_server, fd_client_group, rc;
 	struct sockaddr_in server_address;
-	struct conn *conn = NULL;
+	struct conn *c = NULL;
 	int reuse = 1;
 
 	memset(&server_address, 0, sizeof(server_address));
@@ -115,20 +115,20 @@ conn_init(struct conn_params *p)
 		goto exit;
 
 	/* Memory allocation */
-	conn = calloc(1, sizeof(struct conn));
-	if (conn == NULL)
+	c = calloc(1, sizeof(struct conn));
+	if (c == NULL)
 		goto exit;
 
-	conn->welcome = calloc(1, CONN_WELCOME_LEN_MAX + 1);
-	conn->prompt = calloc(1, CONN_PROMPT_LEN_MAX + 1);
-	conn->buf = calloc(1, p->buf_size);
-	conn->msg_in = calloc(1, p->msg_in_len_max + 1);
-	conn->msg_out = calloc(1, p->msg_out_len_max + 1);
+	c->welcome = calloc(1, CONN_WELCOME_LEN_MAX + 1);
+	c->prompt = calloc(1, CONN_PROMPT_LEN_MAX + 1);
+	c->buf = calloc(1, p->buf_size);
+	c->msg_in = calloc(1, p->msg_in_len_max + 1);
+	c->msg_out = calloc(1, p->msg_out_len_max + 1);
 
-	if ((conn->welcome == NULL) || (conn->prompt == NULL) || (conn->buf == NULL) ||
-	    (conn->msg_in == NULL) || (conn->msg_out == NULL)) {
-		conn_free(conn);
-		conn = NULL;
+	if ((c->welcome == NULL) || (c->prompt == NULL) || (c->buf == NULL) ||
+	    (c->msg_in == NULL) || (c->msg_out == NULL)) {
+		conn_free(c);
+		c = NULL;
 		goto exit;
 	}
 
@@ -138,8 +138,8 @@ conn_init(struct conn_params *p)
 
 	fd_server = socket(AF_INET, SOCK_STREAM | SOCK_NONBLOCK, 0);
 	if (fd_server == -1) {
-		conn_free(conn);
-		conn = NULL;
+		conn_free(c);
+		c = NULL;
 		goto exit;
 	}
 
@@ -161,47 +161,47 @@ conn_init(struct conn_params *p)
 		goto free;
 
 	/* Fill in */
-	rte_strscpy(conn->welcome, p->welcome, CONN_WELCOME_LEN_MAX);
-	rte_strscpy(conn->prompt, p->prompt, CONN_PROMPT_LEN_MAX);
-	conn->buf_size = p->buf_size;
-	conn->msg_in_len_max = p->msg_in_len_max;
-	conn->msg_out_len_max = p->msg_out_len_max;
-	conn->msg_in_len = 0;
-	conn->fd_server = fd_server;
-	conn->fd_client_group = fd_client_group;
-	conn->msg_handle = p->msg_handle;
-	conn->msg_handle_arg = p->msg_handle_arg;
+	rte_strscpy(c->welcome, p->welcome, CONN_WELCOME_LEN_MAX);
+	rte_strscpy(c->prompt, p->prompt, CONN_PROMPT_LEN_MAX);
+	c->buf_size = p->buf_size;
+	c->msg_in_len_max = p->msg_in_len_max;
+	c->msg_out_len_max = p->msg_out_len_max;
+	c->msg_in_len = 0;
+	c->fd_server = fd_server;
+	c->fd_client_group = fd_client_group;
+	c->msg_handle = p->msg_handle;
+	c->msg_handle_arg = p->msg_handle_arg;
 
 exit:
-	return conn;
+	return c;
 free:
-	conn_free(conn);
+	conn_free(c);
 	close(fd_server);
-	conn = NULL;
-	return conn;
+	c = NULL;
+	return c;
 }
 
 void
-conn_free(struct conn *conn)
+conn_free(struct conn *c)
 {
-	if (conn == NULL)
+	if (c == NULL)
 		return;
 
-	if (conn->fd_client_group)
-		close(conn->fd_client_group);
+	if (c->fd_client_group)
+		close(c->fd_client_group);
 
-	if (conn->fd_server)
-		close(conn->fd_server);
+	if (c->fd_server)
+		close(c->fd_server);
 
-	free(conn->msg_out);
-	free(conn->msg_in);
-	free(conn->prompt);
-	free(conn->welcome);
-	free(conn);
+	free(c->msg_out);
+	free(c->msg_in);
+	free(c->prompt);
+	free(c->welcome);
+	free(c);
 }
 
 int
-conn_req_poll(struct conn *conn)
+conn_req_poll(struct conn *c)
 {
 	struct sockaddr_in client_address;
 	socklen_t client_address_length;
@@ -209,12 +209,12 @@ conn_req_poll(struct conn *conn)
 	int fd_client, rc;
 
 	/* Check input arguments */
-	if (conn == NULL)
+	if (c == NULL)
 		return -1;
 
 	/* Server socket */
 	client_address_length = sizeof(client_address);
-	fd_client = accept4(conn->fd_server, (struct sockaddr *)&client_address,
+	fd_client = accept4(c->fd_server, (struct sockaddr *)&client_address,
 			    &client_address_length, SOCK_NONBLOCK);
 	if (fd_client == -1) {
 		if ((errno == EAGAIN) || (errno == EWOULDBLOCK))
@@ -227,20 +227,20 @@ conn_req_poll(struct conn *conn)
 	event.events = EPOLLIN | EPOLLRDHUP | EPOLLHUP;
 	event.data.fd = fd_client;
 
-	rc = epoll_ctl(conn->fd_client_group, EPOLL_CTL_ADD, fd_client, &event);
+	rc = epoll_ctl(c->fd_client_group, EPOLL_CTL_ADD, fd_client, &event);
 	if (rc == -1) {
 		close(fd_client);
 		goto exit;
 	}
 
 	/* Client */
-	rc = write(fd_client, conn->welcome, strlen(conn->welcome));
+	rc = write(fd_client, c->welcome, strlen(c->welcome));
 	if (rc == -1) {
 		close(fd_client);
 		goto exit;
 	}
 
-	rc = write(fd_client, conn->prompt, strlen(conn->prompt));
+	rc = write(fd_client, c->prompt, strlen(c->prompt));
 	if (rc == -1) {
 		close(fd_client);
 		goto exit;
@@ -253,17 +253,17 @@ conn_req_poll(struct conn *conn)
 }
 
 int
-conn_msg_poll(struct conn *conn)
+conn_msg_poll(struct conn *c)
 {
 	int fd_client, rc, rc_data = 0, rc_control = 0;
 	struct epoll_event event;
 
 	/* Check input arguments */
-	if (conn == NULL)
+	if (c == NULL)
 		return -1;
 
 	/* Client group */
-	rc = epoll_wait(conn->fd_client_group, &event, 1, 0);
+	rc = epoll_wait(c->fd_client_group, &event, 1, 0);
 	if ((rc == -1) || rc == 0)
 		return rc;
 
@@ -271,11 +271,11 @@ conn_msg_poll(struct conn *conn)
 
 	/* Data available */
 	if (event.events & EPOLLIN)
-		rc_data = data_event_handle(conn, fd_client);
+		rc_data = data_event_handle(c, fd_client);
 
 	/* Control events */
 	if (event.events & (EPOLLRDHUP | EPOLLERR | EPOLLHUP))
-		rc_control = control_event_handle(conn, fd_client);
+		rc_control = control_event_handle(c, fd_client);
 
 	if (rc_data || rc_control)
 		return -1;
-- 
2.51.0

