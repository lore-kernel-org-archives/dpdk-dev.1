Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0B6CD8CAD
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 21:05:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BEDE24042E;
	Tue,  9 Jun 2026 23:05:47 +0200 (CEST)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177]) by mails.dpdk.org (Postfix) with ESMTP id A2ED7400D5
 for <dev@dpdk.org>; Tue,  9 Jun 2026 23:05:45 +0200 (CEST)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-3075ce9c05aso338226eec.1
 for <dev@dpdk.org>; Tue, 09 Jun 2026 14:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781039145;
 x=1781643945; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dBl6BH8zpPTPYeEWZgRM3zd1XJLIjlA7N8ntVLTycBM=;
 b=U6bYtdaVeVQJFxpcnOMxjNiR3EZY12JVHJyfn86FTRqmw0Qlc4SEZr5Gw1Oecn+qB4
 0CXXC5xph/VryGehhh0xU2PtbqjE54t69dVnplJrSMLpx0gkDtNmPYlBdhUV3UjjiHeO
 FEMeAGZ3oqRU5yyA7wigf/Fxxm2xTkZyRGfPKFWwFi9nMNPbbqdi9W1Ub4QULHkfN+pb
 ySYHM0Mu5R7sFsRuvE4TITelYM9VIunvaSSIIJT0+Uq2u24zW5V6qUgEtJpiFpd5PxVt
 QKcYjGFhEQtmR+Q+06q19vjyxGpAJcx0q/OLG7MdlO6vf5o6/oNrHwozEHKfQf3nNmpL
 DNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781039145; x=1781643945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dBl6BH8zpPTPYeEWZgRM3zd1XJLIjlA7N8ntVLTycBM=;
 b=RNteIeIfUOisB3K8JEIVWhqfKQOXlG+4w6P4cIMjuLxr6wnG4WrREil0vQ12kseT0I
 r0SkDWRPFgyuWjZV1MSjZerenhmE2fA/oAsPpejYjM4atsbf+FtlZLCUHegIRbcIt/RB
 O6qY7mSJI7jB/YVfHI/N1TK+R5aTzDMZF3t2PRC32/1INL4F1DPmkiiqg0CgvObv37xW
 cd1JyTOOUaAv83PLJkuYR+vQR0P7y4KLnZ1W9JVY6d8PQsKzj4NDB45y39NSQou/fNhK
 vfbc3RSwM/22k93eESDuKF0XwtJZFSfCt6bW0HOLokGHbTxZ4QdzUbB1bVY0bkiOn3N5
 q6CA==
X-Gm-Message-State: AOJu0YxP8qns87CJ3rTU+hGStugz0fbMKTwFFfHhRyLLXUwSN4M5o8eD
 Bf4PYaZoWMO9JmgEadru5C61tpKLoQIPowE6j4jLDzyiNHnZIFABh0HNOm7J1arZHo3v46bD0li
 iylde
X-Gm-Gg: Acq92OGYarib2ATBrYeu1hWKGgX/SaOReyZeFo/L4YoBH5u8lcmFQJhsrjz+xTZ9z3h
 h12FBn4rFLvt9939rBsFDjwSe8yHlzZ4480c4vScgjkY/HpPDTR3AdmAPUKIiVYu5qLxNMtgIo1
 OAS9kdfeKG+dMGppzOCT3IlW7DX3Ph+S3ahEWEPctm4ciObywabhp7El2kPgGs07TS3dFengCEk
 j/dEXcH5bmsnnwtV/6KHAcsm7OxyzROkCqnWB9H7FfqC2TVkG7uLk0rRgjeqf4RCM7Z6au+RiuY
 Xvf1r6vbmsVdRzrfSYheJJuk8P3QuZHt47FasbpARvZUeu50kC3phAc2cI0Gds+tnU9qg0BTBxE
 FL5+zLp2SCMoGHo2E1TcebN6Wr5R+p527u0Fp+0k8vnItg+A6P5e4CBr8FQj50xhKlKLhPkepX4
 Fc1JEjjy5xDH7tKdvP1/41sj0Ga1AOSpTC6C/pShDvjKJF6ddYcb1sl0/HWiFlXU6s7P+a6VbE
X-Received: by 2002:a05:7300:3244:b0:2d9:ad46:4a92 with SMTP id
 5a478bee46e88-3077b0846d1mr12110925eec.13.1781039144448; 
 Tue, 09 Jun 2026 14:05:44 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074dcad34esm32953589eec.11.2026.06.09.14.05.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 14:05:43 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC 1/4] telemetry: allow commands to receive file descriptors
Date: Tue,  9 Jun 2026 14:02:02 -0700
Message-ID: <20260609210540.768074-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260609210540.768074-1-stephen@networkplumber.org>
References: <20260609210540.768074-1-stephen@networkplumber.org>
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

Add rte_telemetry_register_cmd_fd_arg() to register a command whose
callback also receives file descriptors passed by the client as
SCM_RIGHTS ancillary data. The callback owns the descriptors and must
close them.

This lets a client open a file itself and hand the descriptor to the
primary process, so DPDK never opens the path. That avoids path and
permission problems and works across container filesystem namespaces.

Existing commands and clients are unaffected. If unsolicited file
descriptor is passed, it is closed.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_07.rst |   5 ++
 lib/telemetry/rte_telemetry.h          |  66 ++++++++++++++
 lib/telemetry/telemetry.c              | 115 ++++++++++++++++++++++---
 3 files changed, 174 insertions(+), 12 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index b5285af5fe..d7a2df88c1 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -141,6 +141,11 @@ New Features
   Added AGENTS.md file for AI review
   and supporting scripts to review patches and documentation.
 
+* **Added telemetry support for passing file descriptors.**
+
+  Add experimental telemetry callback ``rte_telemetry_register_cmd_fd_arg()``
+  to allow command to receive file descriptors passed by client.
+
 
 Removed Items
 -------------
diff --git a/lib/telemetry/rte_telemetry.h b/lib/telemetry/rte_telemetry.h
index 0a58e518f7..3e32d2902b 100644
--- a/lib/telemetry/rte_telemetry.h
+++ b/lib/telemetry/rte_telemetry.h
@@ -325,6 +325,37 @@ typedef int (*telemetry_cb)(const char *cmd, const char *params,
 typedef int (*telemetry_arg_cb)(const char *cmd, const char *params, void *arg,
 		struct rte_tel_data *info);
 
+/**
+ * This telemetry callback is used when registering a telemetry command with
+ * rte_telemetry_register_cmd_fd_arg().
+ *
+ * It behaves like telemetry_arg_cb, but additionally receives any file
+ * descriptors the client passed alongside the command as SCM_RIGHTS ancillary
+ * data. The callback takes ownership of these descriptors and is responsible
+ * for closing them.
+ *
+ * @param cmd
+ *   The cmd that was requested by the client.
+ * @param params
+ *   Contains data required by the callback function.
+ * @param arg
+ *   The opaque value that was passed to rte_telemetry_register_cmd_fd_arg().
+ * @param fds
+ *   Array of file descriptors received from the client. May be NULL when
+ *   n_fds is zero.
+ * @param n_fds
+ *   Number of file descriptors in the fds array.
+ * @param info
+ *   The information to be returned to the caller.
+ *
+ * @return
+ *   Length of buffer used on success.
+ * @return
+ *   Negative integer on error.
+ */
+typedef int (*telemetry_fd_cb)(const char *cmd, const char *params, void *arg,
+		const int *fds, unsigned int n_fds, struct rte_tel_data *info);
+
 /**
  * Used when registering a command and callback function with telemetry.
  *
@@ -368,6 +399,41 @@ __rte_experimental
 int
 rte_telemetry_register_cmd_arg(const char *cmd, telemetry_arg_cb fn, void *arg, const char *help);
 
+/**
+ * Register a command and a file-descriptor-aware callback with telemetry.
+ *
+ * The callback is invoked like rte_telemetry_register_cmd_arg(), but also
+ * receives any file descriptors the client passed alongside the command as
+ * SCM_RIGHTS ancillary data. This lets a client open a file (for example a
+ * capture output file) itself and hand the descriptor to the DPDK process,
+ * which never opens the path - avoiding path and permission concerns and
+ * working across container filesystem namespaces.
+ *
+ * Descriptors sent to a command registered with rte_telemetry_register_cmd()
+ * or rte_telemetry_register_cmd_arg() are rejected and the connection is
+ * closed.
+ *
+ * @param cmd
+ *   The command to register with telemetry.
+ * @param fn
+ *   Callback function to be called when the command is requested.
+ * @param arg
+ *   An opaque value that will be passed to the callback function.
+ * @param help
+ *   Help text for the command.
+ *
+ * @return
+ *   0 on success.
+ * @return
+ *   -EINVAL for invalid parameters failure.
+ * @return
+ *   -ENOMEM for mem allocation failure.
+ */
+__rte_experimental
+int
+rte_telemetry_register_cmd_fd_arg(const char *cmd, telemetry_fd_cb fn, void *arg,
+		const char *help);
+
 /**
  * @internal
  * Free a container that has memory allocated.
diff --git a/lib/telemetry/telemetry.c b/lib/telemetry/telemetry.c
index b109d076d4..30d3ae3a13 100644
--- a/lib/telemetry/telemetry.c
+++ b/lib/telemetry/telemetry.c
@@ -29,6 +29,8 @@
 #define MAX_CMD_LEN 56
 #define MAX_OUTPUT_LEN (1024 * 16)
 #define MAX_CONNECTIONS 10
+/* Maximum number of file descriptors a client may pass with one command. */
+#define MAX_FDS 8
 
 #ifndef RTE_EXEC_ENV_WINDOWS
 static void *
@@ -39,6 +41,7 @@ struct cmd_callback {
 	char cmd[MAX_CMD_LEN];
 	telemetry_cb fn;
 	telemetry_arg_cb fn_arg;
+	telemetry_fd_cb fn_fd;
 	void *arg;
 	char help[RTE_TEL_MAX_STRING_LEN];
 };
@@ -72,15 +75,15 @@ static RTE_ATOMIC(uint16_t) v2_clients;
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
 static int
-register_cmd(const char *cmd, const char *help,
-	     telemetry_cb fn, telemetry_arg_cb fn_arg, void *arg)
+register_cmd(const char *cmd, const char *help, telemetry_cb fn,
+	     telemetry_arg_cb fn_arg, telemetry_fd_cb fn_fd, void *arg)
 {
 	struct cmd_callback *new_callbacks;
 	const char *cmdp = cmd;
 	int i = 0;
 
-	if (strlen(cmd) >= MAX_CMD_LEN || (fn == NULL && fn_arg == NULL) || cmd[0] != '/'
-			|| strlen(help) >= RTE_TEL_MAX_STRING_LEN)
+	if (strlen(cmd) >= MAX_CMD_LEN || (fn == NULL && fn_arg == NULL && fn_fd == NULL)
+			|| cmd[0] != '/' || strlen(help) >= RTE_TEL_MAX_STRING_LEN)
 		return -EINVAL;
 
 	while (*cmdp != '\0') {
@@ -107,6 +110,7 @@ register_cmd(const char *cmd, const char *help,
 	strlcpy(callbacks[i].cmd, cmd, MAX_CMD_LEN);
 	callbacks[i].fn = fn;
 	callbacks[i].fn_arg = fn_arg;
+	callbacks[i].fn_fd = fn_fd;
 	callbacks[i].arg = arg;
 	strlcpy(callbacks[i].help, help, RTE_TEL_MAX_STRING_LEN);
 	num_callbacks++;
@@ -119,14 +123,22 @@ RTE_EXPORT_SYMBOL(rte_telemetry_register_cmd)
 int
 rte_telemetry_register_cmd(const char *cmd, telemetry_cb fn, const char *help)
 {
-	return register_cmd(cmd, help, fn, NULL, NULL);
+	return register_cmd(cmd, help, fn, NULL, NULL, NULL);
 }
 
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_telemetry_register_cmd_arg, 24.11)
 int
 rte_telemetry_register_cmd_arg(const char *cmd, telemetry_arg_cb fn, void *arg, const char *help)
 {
-	return register_cmd(cmd, help, NULL, fn, arg);
+	return register_cmd(cmd, help, NULL, fn, NULL, arg);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_telemetry_register_cmd_fd_arg, 26.07)
+int
+rte_telemetry_register_cmd_fd_arg(const char *cmd, telemetry_fd_cb fn, void *arg,
+		const char *help)
+{
+	return register_cmd(cmd, help, NULL, NULL, fn, arg);
 }
 
 #ifndef RTE_EXEC_ENV_WINDOWS
@@ -368,13 +380,70 @@ output_json(const char *cmd, const struct rte_tel_data *d, int s)
 		TMTY_LOG_LINE(ERR, "Error writing to socket: %s", strerror(errno));
 }
 
+/*
+ * Receive a command and any file descriptors the client passed alongside it
+ * as SCM_RIGHTS ancillary data. The payload length is returned (0 if the
+ * client sent an empty message or closed the connection, negative on error).
+ * Descriptors that arrive are returned in fds[]/n_fds and are owned by the
+ * caller. MSG_CTRUNC means more descriptors were sent than the control buffer
+ * could hold; *ctrunc is set so the caller can reject the command, but the
+ * descriptors that did fit are still returned so they can be closed rather
+ * than leaked.
+ */
+static int
+recv_with_fds(int s, char *buf, size_t buf_len, int *fds, unsigned int *n_fds,
+	      bool *ctrunc)
+{
+	char cmsgbuf[CMSG_SPACE(sizeof(int) * MAX_FDS)];
+	struct iovec iov = { .iov_base = buf, .iov_len = buf_len };
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+		.msg_control = cmsgbuf,
+		.msg_controllen = sizeof(cmsgbuf),
+	};
+	struct cmsghdr *cmsg;
+	int bytes;
+
+	*n_fds = 0;
+	*ctrunc = false;
+
+	bytes = recvmsg(s, &msg, 0);
+	if (bytes < 0)
+		return bytes;
+
+	if (msg.msg_flags & MSG_CTRUNC)
+		*ctrunc = true;
+
+	for (cmsg = CMSG_FIRSTHDR(&msg); cmsg != NULL; cmsg = CMSG_NXTHDR(&msg, cmsg)) {
+		if (cmsg->cmsg_level != SOL_SOCKET || cmsg->cmsg_type != SCM_RIGHTS)
+			continue;
+		*n_fds = (cmsg->cmsg_len - CMSG_LEN(0)) / sizeof(int);
+		memcpy(fds, CMSG_DATA(cmsg), *n_fds * sizeof(int));
+		break;
+	}
+	return bytes;
+}
+
 static void
-perform_command(const struct cmd_callback *cb, const char *cmd, const char *param, int s)
+close_fds(const int *fds, unsigned int n_fds)
+{
+	unsigned int i;
+
+	for (i = 0; i < n_fds; i++)
+		close(fds[i]);
+}
+
+static void
+perform_command(const struct cmd_callback *cb, const char *cmd, const char *param,
+		const int *fds, unsigned int n_fds, int s)
 {
 	struct rte_tel_data data = {0};
 	int ret;
 
-	if (cb->fn_arg != NULL)
+	if (cb->fn_fd != NULL)
+		ret = cb->fn_fd(cmd, param, cb->arg, fds, n_fds, &data);
+	else if (cb->fn_arg != NULL)
 		ret = cb->fn_arg(cmd, param, cb->arg, &data);
 	else
 		ret = cb->fn(cmd, param, &data);
@@ -412,8 +481,11 @@ client_handler(void *sock_id)
 	}
 
 	/* receive data is not null terminated */
-	int bytes = read(s, buffer, sizeof(buffer) - 1);
-	while (bytes > 0) {
+	int fds[MAX_FDS];
+	unsigned int n_fds = 0;
+	bool ctrunc = false;
+	int bytes = recv_with_fds(s, buffer, sizeof(buffer) - 1, fds, &n_fds, &ctrunc);
+	while (bytes > 0 || (bytes == 0 && n_fds > 0)) {
 		buffer[bytes] = 0;
 		const char *cmd = strtok(buffer, ",");
 		const char *param = strtok(NULL, "\0");
@@ -429,9 +501,28 @@ client_handler(void *sock_id)
 				}
 			rte_spinlock_unlock(&callback_sl);
 		}
-		perform_command(&cb, cmd, param, s);
 
-		bytes = read(s, buffer, sizeof(buffer) - 1);
+		/*
+		 * File descriptors go only to a command that registered to
+		 * receive them. A command that did not, or a truncated control
+		 * message, is a client error: close the descriptors and drop the
+		 * connection rather than silently discarding them.
+		 */
+		if (n_fds > 0 && (cb.fn_fd == NULL || ctrunc)) {
+			TMTY_LOG_LINE(ERR,
+				"Closing connection: %u file descriptor(s) passed to '%s'%s",
+				n_fds, cmd ? cmd : "(none)",
+				ctrunc ? " (truncated)" : " which does not accept them");
+			close_fds(fds, n_fds);
+			break;
+		}
+
+		/* an fd-aware callback takes ownership of the descriptors */
+		perform_command(&cb, cmd, param, fds, n_fds, s);
+
+		n_fds = 0;
+		ctrunc = false;
+		bytes = recv_with_fds(s, buffer, sizeof(buffer) - 1, fds, &n_fds, &ctrunc);
 	}
 exit:
 	close(s);
-- 
2.53.0

