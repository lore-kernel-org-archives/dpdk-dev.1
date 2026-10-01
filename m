Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD2ECA5FC1
	for <dpdk-dev@archiver.kernel.org>; Thu,  1 Oct 2026 02:59:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7DB4F42E15;
	Thu,  1 Oct 2026 04:59:02 +0200 (CEST)
Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com
 [74.125.227.169])
 by mails.dpdk.org (Postfix) with ESMTP id 3747641144
 for <dev@dpdk.org>; Thu,  1 Oct 2026 04:59:00 +0200 (CEST)
Received: by mail-pj2-f41.google.com with SMTP id
 98e67ed59e1d1-3a0aa9d356eso4593143a91.0
 for <dev@dpdk.org>; Wed, 30 Sep 2026 19:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790823539;
 x=1791428339; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/8OkP4m4IXJTgO0iZhJVdhHSN1F+uQc9ynQJwAfG/mY=;
 b=Oy+SFZShgVEHhvIqp92PfkumoYA0Dj3pUCxQUnI2tPxIKlWa2KOa29MjYbvSRm6MiL
 IuC+xWms1n42FqjTdfkwF5ieArtCfLQD2kdE1F4Kd26rn9RUjDwL50IXBDlnilHiTNFy
 Dnrz3R7I8gvxWMEaVDg8ALCPoHej7OJrcvKvrQrwVgGXMoXBkk4tXN6PcEOwT3evjLC0
 GpqcCkD9EiEh4bUCNTXF9qt6FIgGykW22GrsXSJpf7gOtM79lqjXTiO8Y9yOHypUQZzB
 E87ap5DNOPsDfVK9X7fwgvwKbMojF4ORPRpqgc2PYkIGCKqP07jxgFT5aCCLi4CCnole
 c6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790823539; x=1791428339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/8OkP4m4IXJTgO0iZhJVdhHSN1F+uQc9ynQJwAfG/mY=;
 b=eSRM6ErYIcZZN8khd9t4J7dLBakpXgviN4id9PLeSmDQtEo9tT55QVXMbudxtNBcDg
 m/bkN1Z52AujpBK8zMnAEuO5/xd7J2lLZxu/+FoHGdOgkP9/2lXhfyWGoh90w5ebhOyj
 uc9UmFdqsQ3LSStqdIoqTqL+ZdmPeq2Nvsx4yK11uovKwuD09e5aMi6h+qzpRuRwkTDT
 EEKrw4GsxvvyJWjqFXwMwUl5Leh/7OV1GGGI6Ie53UT1sxW8e2a3cSG4JId5LiXJ4wds
 UfUVyTGqFnDGO110FQbavlrRL2730tx/NVk1Le/k1OFQ7wdB80tCeOUU1gpNjlMvz9xE
 HOLA==
X-Gm-Message-State: AFq9FYKWVNaeb8Wvg3lsFtG1UihvsHVpFdVt+eSyGyjcPCzQZ4RHQ7C8
 4prRzLTQfeqoI7MZKpYs4Sg3TUREO6fFWlfOl9mxuEkITC0SbSF6UbfU4ncNmkKCaIW5n7Uyo9M
 nU6yP
X-Gm-Gg: AYBFou1jXtsWQKHZRTOeIIlFhqLZtpkC3mYslsvqCMjTgAV0MmdS9HS4Q1Jn6rGmZcz
 TN89zeY66wYzlvDL/BO7WCJVrE2JXTegDnk/DkRiI6HbKB2T5Q26DxKLmCQ4P6s7tTBfMMa7UUx
 BnRmZlFSAY7u3ZTg0EFcJ+/W2o6IGkr/2F76EBQyyy4sjzoGDERIxkkTN8ScTtu7pd0XPx257Do
 eyQ/OakOYdXZp8inrXa8q71IzCRSgDospktRXsKn3koWSQiz0EhwsJGJ1k85V4z5bDGDf2FRlsm
 sRfXRcaM+nw3MbzpTdiF6ylB+E3OeA0NEKcJhVQcBt4vXDiz7Bx02G9iLmGcGkuZRVrnLf4ki3v
 jxfGUBQWW3ZXXj3Ds7LEmcEgH26ShTOASUysHSQB4Tg04SLXHcWZD/YPk2OlhDa4gYeartzNQCb
 kEalwruyEyx2IKvGlwnSTd2alQiBMroo+/pB2tmsRCH5MCJNfRwhj0w0pxMqfm72A2SYzVRLbe5
 A8XovPYLFcKxSjX4r4MjV43iBItjxhvtPelDg==
X-Received: by 2002:a17:90b:3c0d:b0:3a4:b6c2:b159 with SMTP id
 98e67ed59e1d1-3a4d17928fdmr2715279a91.34.1790823538894; 
 Wed, 30 Sep 2026 19:58:58 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f471b16asm2024487a91.9.2026.09.30.19.58.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 19:58:58 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v4 3/4] app/rpcapd: add TLS support
Date: Wed, 30 Sep 2026 19:35:28 -0700
Message-ID: <20261001025853.319860-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001025853.319860-1-stephen@networkplumber.org>
References: <20260908210832.1556291-1-stephen@networkplumber.org>
 <20261001025853.319860-1-stephen@networkplumber.org>
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

Support remote packet capture over TLS.
This requires OpenSSL to be available.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/rpcapd/capture.c                   |  15 ++
 app/rpcapd/main.c                      | 154 +++++++++++++-
 app/rpcapd/meson.build                 |  15 ++
 app/rpcapd/rpcap-protocol.h            |   3 +
 app/rpcapd/rpcapd.h                    |  20 +-
 app/rpcapd/session.c                   | 182 +++++++++++++++--
 app/rpcapd/sock.c                      |  52 ++++-
 app/rpcapd/tls.c                       | 273 +++++++++++++++++++++++++
 doc/guides/rel_notes/release_26_11.rst |   2 +
 doc/guides/tools/rpcapd.rst            | 119 +++++++++--
 10 files changed, 789 insertions(+), 46 deletions(-)
 create mode 100644 app/rpcapd/tls.c

diff --git a/app/rpcapd/capture.c b/app/rpcapd/capture.c
index 17fce3fbca..b168216246 100644
--- a/app/rpcapd/capture.c
+++ b/app/rpcapd/capture.c
@@ -168,6 +168,7 @@ stop_capture(struct session *s)
 	rte_free(s->prm);
 	s->prm = NULL;
 	if (s->data.fd >= 0) {
+		tls_close(&s->data);
 		close(s->data.fd);
 		s->data.fd = -1;
 	}
@@ -312,6 +313,14 @@ handle_startcap(const struct conn *c, uint32_t plen, struct session *s)
 
 	s->data.fd = data_fd;
 
+	/* The client starts its handshake as soon as it has connected,
+	 * so promote before anything is sent.
+	 */
+	if (use_tls && tls_accept(&s->data) < 0) {
+		stop_capture(s);
+		return -1;
+	}
+
 	RPCAPD_LOG(NOTICE,
 		   "capture started on %s (snaplen %u, data port %u)",
 		   s->name, s->snaplen, data_port);
@@ -427,6 +436,12 @@ check_socket_status(const struct conn *ctrl)
 {
 	struct pollfd pfd = { .fd = ctrl->fd, .events = POLLIN };
 
+	/* A request may already be decrypted and waiting out of sight
+	 * of poll(), sharing a TLS record with an earlier one.
+	 */
+	if (tls_pending(ctrl))
+		return 1;
+
 	if (poll(&pfd, 1, 0) < 0) {
 		if (errno == EINTR)
 			return 0;
diff --git a/app/rpcapd/main.c b/app/rpcapd/main.c
index 7b7288785d..0cf6c3f4ba 100644
--- a/app/rpcapd/main.c
+++ b/app/rpcapd/main.c
@@ -62,13 +62,17 @@ static int bind_family = AF_UNSPEC;
 static const char *debug_file;		/* --debug-file argument */
 static unsigned int debug_log;		/* -D count: raise RPCAPD log verbosity */
 uint32_t send_timeout = DATA_SEND_TIMEOUT_SEC;	/* 0 means no limit */
+bool use_tls;				/* -S */
+bool null_auth_ok;			/* -n */
+static const char *tls_certfile;	/* -X argument */
+static const char *tls_keyfile;		/* -K argument */
 
 struct sockaddr_storage listen_addr;
 socklen_t               listen_addrlen;
 
 RTE_ATOMIC(bool) quit_signal;
 
-static bool
+bool
 is_loopback(const struct sockaddr_storage *ss)
 {
 	if (ss->ss_family == AF_INET) {
@@ -121,6 +125,62 @@ signal_handler(int sig __rte_unused)
 	rte_atomic_store_explicit(&quit_signal, true, rte_memory_order_relaxed);
 }
 
+/*
+ * TLS is not negotiated in the rpcap protocol, so a mismatch has to be
+ * detected from the first byte: an rpcap message starts with the
+ * protocol version 0, a TLS handshake with content type 22.
+ */
+#define TLS_RECORD_TYPE_HANDSHAKE	22
+
+/* How long a client has to send its first byte. */
+#define FIRST_BYTE_TIMEOUT_MS		(10 * 1000)
+
+static int
+setup_tls(struct conn *ctrl)
+{
+	uint8_t first;
+
+	/* Bounded wait: only one client is served at a time, so a peer
+	 * that connects and says nothing must not hold the daemon.
+	 */
+	switch (wait_readable(ctrl, FIRST_BYTE_TIMEOUT_MS)) {
+	case 1:
+		break;
+	case 0:
+		RPCAPD_LOG(NOTICE, "client sent nothing within %u seconds, closing",
+			FIRST_BYTE_TIMEOUT_MS / 1000);
+		return -1;
+	default:
+		return -1;
+	}
+
+	if (recv(ctrl->fd, &first, 1, MSG_PEEK) != 1)
+		return -1;
+
+	if (!use_tls) {
+		if (first == TLS_RECORD_TYPE_HANDSHAKE) {
+			tls_reject_handshake(ctrl->fd);
+			return -1;
+		}
+		return 0;
+	}
+
+	if (first != TLS_RECORD_TYPE_HANDSHAKE) {
+		struct rpcap_header hdr;
+
+		/* Reply in the clear; it is all the client will understand. */
+		RPCAPD_LOG(WARNING, "rejecting plaintext client: server requires TLS");
+		if (recv_full(ctrl, &hdr, sizeof(hdr)) == 0)
+			rpcap_discard(ctrl, rte_be_to_cpu_32(hdr.plen));
+
+		rpcap_send_error(ctrl, PCAP_ERR_TLS_REQUIRED,
+				 "TLS is required by this server; use rpcaps://");
+		return -1;
+	}
+
+	return tls_accept(ctrl);
+}
+
 /* Service a single client until it disconnects. */
 static void
 handle_client(int ctrl_fd)
@@ -134,6 +194,7 @@ handle_client(int ctrl_fd)
 	/* Remembered so the data connection can be restricted to this peer. */
 	if (getpeername(ctrl_fd, (struct sockaddr *)&peer, &peerlen) != 0) {
 		RPCAPD_LOG(ERR, "getpeername: %s", strerror(errno));
+		close(ctrl_fd);
 		return;
 	}
 	s.peer = peer;
@@ -141,6 +202,15 @@ handle_client(int ctrl_fd)
 		    host, sizeof(host), NULL, 0, NI_NUMERICHOST);
 	RPCAPD_LOG(NOTICE, "client %s connected", host);
 
+	if (!use_tls && !is_loopback(&peer))
+		RPCAPD_LOG(ERR,
+			"remote client %s is connected without TLS; "
+			"captured traffic and any credentials are exposed to the network",
+			host);
+
+	if (setup_tls(&ctrl) < 0)
+		goto done;
+
 	while (!rte_atomic_load_explicit(&quit_signal, rte_memory_order_relaxed)) {
 		struct rpcap_header hdr;
 		uint32_t plen;
@@ -165,12 +235,24 @@ handle_client(int ctrl_fd)
 			continue;
 		}
 
+		/* Nothing but authentication is served until it succeeds. */
+		if (!s.authenticated && hdr.type != RPCAP_MSG_AUTH_REQ &&
+		    hdr.type != RPCAP_MSG_CLOSE) {
+			RPCAPD_LOG(NOTICE, "request 0x%02x before authentication",
+				hdr.type);
+			if (rpcap_discard(&ctrl, plen) < 0 ||
+			    rpcap_send_error(&ctrl, PCAP_ERR_AUTH,
+					     "not authenticated") < 0)
+				goto done;
+			continue;
+		}
+
 		switch (hdr.type) {
 		case RPCAP_MSG_AUTH_REQ:
 			/* libpcap treats a zero-length AUTH_REPLY as "version
 			 * 0 only, same byte order".
 			 */
-			if (handle_auth(&ctrl, plen) < 0)
+			if (handle_auth(&ctrl, plen, &s) < 0)
 				goto done;
 			break;
 		case RPCAP_MSG_FINDALLIF_REQ:
@@ -210,6 +292,7 @@ handle_client(int ctrl_fd)
 	}
 done:
 	stop_capture(&s);
+	tls_close(&ctrl);
 	close(ctrl_fd);
 	RPCAPD_LOG(NOTICE, "client %s disconnected", host);
 }
@@ -239,10 +322,10 @@ open_listen_socket(uint16_t port)
 
 	RPCAPD_LOG(NOTICE, "listening on %s port %u", host, listen_port);
 
-	if (!is_loopback(&listen_addr))
-		RPCAPD_LOG(WARNING,
-			"non-loopback address %s; "
-			"rpcap is unauthenticated and unencrypted, captured traffic is exposed to the network",
+	if (!is_loopback(&listen_addr) && !use_tls)
+		RPCAPD_LOG(ERR,
+			"listening on non-loopback address %s without TLS; "
+			"captured traffic will be exposed to the network, use -S",
 			host);
 
 	if (listen(fd, 1) < 0)
@@ -261,6 +344,12 @@ usage(FILE *f, const char *progname)
 		"  -4                    use only IPv4\n"
 		"  -6                    use only IPv6\n"
 		"  -N <ring size>        ring size in packets (default %u)\n"
+#ifdef RTE_HAS_OPENSSL
+		"  -S, --tls             encrypt connections with TLS (rpcaps://)\n"
+		"  -X, --cert <file>     server certificate chain, PEM (needs -S)\n"
+		"  -K, --key <file>      server private key, PEM (needs -S)\n"
+#endif
+		"  -n, --null-auth       permit unauthenticated remote clients\n"
 		"  -D, --debug           increase log verbosity (-D info, -DD debug)\n"
 		"      --debug-file <f>  redirect log output to file <f> (append mode)\n"
 		"      --send-timeout <s> seconds a data send may block before the\n"
@@ -271,9 +360,9 @@ usage(FILE *f, const char *progname)
 		"      --lcore=<core>    CPU core to run on (default: any)\n"
 		"      --file-prefix=<p> prefix to use for multi-process\n"
 		"\n"
-		"WARNING: rpcap is unauthenticated and unencrypted.  Binding to\n"
-		"any non-loopback address exposes captured traffic to the\n"
-		"network.  Not for production use.\n",
+		"Remote clients must authenticate with a system username and\n"
+		"password, and must use TLS to send it.  Loopback clients may\n"
+		"connect unauthenticated.  Not for production use.\n",
 		RPCAP_DEFAULT_NETPORT, DEFAULT_RING_SIZE,
 		DATA_SEND_TIMEOUT_SEC);
 }
@@ -297,6 +386,12 @@ parse_opts(int argc, char **argv)
 	static const struct option long_options[] = {
 		{ "port",         required_argument, NULL, 'p' },
 		{ "bind",         required_argument, NULL, 'b' },
+		{ "null-auth",    no_argument,       NULL, 'n' },
+#ifdef RTE_HAS_OPENSSL
+		{ "tls",          no_argument,       NULL, 'S' },
+		{ "cert",         required_argument, NULL, 'X' },
+		{ "key",          required_argument, NULL, 'K' },
+#endif
 		{ "debug",        no_argument,       NULL, 'D' },
 		{ "help",         no_argument,       NULL, 'h' },
 		{ "version",      no_argument,       NULL, OPT_VERSION },
@@ -308,8 +403,11 @@ parse_opts(int argc, char **argv)
 	};
 	int option_index, c;
 
-	while ((c = getopt_long(argc, argv, "hD46p:b:N:",
-				long_options, &option_index)) != -1) {
+	while ((c = getopt_long(argc, argv, "hnD46p:b:N:"
+#ifdef RTE_HAS_OPENSSL
+				"SX:K:"
+#endif
+				, long_options, &option_index)) != -1) {
 		switch (c) {
 		case 'p': {
 			unsigned long u = strtoul(optarg, NULL, 0);
@@ -328,6 +426,20 @@ parse_opts(int argc, char **argv)
 		case '6':
 			bind_family = AF_INET6;
 			break;
+		case 'n':
+			null_auth_ok = true;
+			break;
+#ifdef RTE_HAS_OPENSSL
+		case 'S':
+			use_tls = true;
+			break;
+		case 'X':
+			tls_certfile = optarg;
+			break;
+		case 'K':
+			tls_keyfile = optarg;
+			break;
+#endif
 		case 'N': {
 			unsigned long u = strtoul(optarg, NULL, 0);
 
@@ -394,6 +506,22 @@ parse_opts(int argc, char **argv)
 
 	/* Resolve the bind address now that -4/-6/-b have been seen. */
 	parse_bind_addr();
+
+	/* There is no sensible default for either: libpcap's rpcapd looks
+	 * for cert.pem and key.pem in the current directory, which is not
+	 * something a daemon started as root should do.
+	 */
+	if (use_tls && (tls_certfile == NULL || tls_keyfile == NULL))
+		rte_exit(EXIT_FAILURE,
+			 "TLS needs both a certificate (-X) and a private key (-K)\n");
+
+	if (!use_tls && (tls_certfile != NULL || tls_keyfile != NULL))
+		rte_exit(EXIT_FAILURE,
+			 "A certificate or key was given without -S\n");
+
+	if (null_auth_ok && !is_loopback(&listen_addr))
+		RPCAPD_LOG(ERR,
+			"-n allows any client that can reach this port to capture traffic");
 }
 
 /*
@@ -548,6 +676,10 @@ main(int argc, char **argv)
 	if (rte_eth_dev_count_avail() == 0)
 		rte_exit(EXIT_FAILURE, "No Ethernet ports found\n");
 
+	/* Fail here rather than on the first client's handshake. */
+	if (use_tls && tls_init(tls_certfile, tls_keyfile) < 0)
+		rte_exit(EXIT_FAILURE, "TLS setup failed\n");
+
 	sigaction(SIGTERM, &action, NULL);
 	sigaction(SIGINT, &action, NULL);
 
diff --git a/app/rpcapd/meson.build b/app/rpcapd/meson.build
index 61f4dc0a95..42b9eec854 100644
--- a/app/rpcapd/meson.build
+++ b/app/rpcapd/meson.build
@@ -14,12 +14,27 @@ if not dpdk_conf.has('RTE_HAS_LIBPCAP')
     subdir_done()
 endif
 
+# password authentication uses crypt(3)
+libcrypt_dep = cc.find_library('crypt', required: false)
+if not libcrypt_dep.found()
+    build = false
+    reason = 'missing dependency, "libcrypt"'
+    subdir_done()
+endif
+
 sources = files(
         'capture.c',
         'filter.c',
         'main.c',
         'session.c',
         'sock.c',
+        'tls.c',
 )
 ext_deps += pcap_dep
+ext_deps += libcrypt_dep
 deps += ['ethdev', 'pdump', 'bpf', 'pcapng']
+
+# TLS support is optional; tls.c builds as stubs without it
+if dpdk_conf.has('RTE_HAS_OPENSSL')
+    ext_deps += openssl_dep
+endif
diff --git a/app/rpcapd/rpcap-protocol.h b/app/rpcapd/rpcap-protocol.h
index 438fd8dd84..7fc1ec5db5 100644
--- a/app/rpcapd/rpcap-protocol.h
+++ b/app/rpcapd/rpcap-protocol.h
@@ -42,7 +42,10 @@
 #define RPCAP_MSG_STATS_REPLY	     (RPCAP_MSG_STATS_REQ	 | RPCAP_MSG_IS_REPLY)
 
 /* Error codes carried in the 'value' field of RPCAP_MSG_ERROR */
+#define PCAP_ERR_AUTH               3	/* generic authentication error */
 #define PCAP_ERR_WRONGVER          17
+#define PCAP_ERR_AUTH_FAILED       18	/* credentials were not accepted */
+#define PCAP_ERR_TLS_REQUIRED      19	/* server will only speak TLS */
 #define PCAP_ERR_AUTH_TYPE_NOTSUP  20
 
 /* Authentication types in rpcap_auth.type */
diff --git a/app/rpcapd/rpcapd.h b/app/rpcapd/rpcapd.h
index df38231bfb..3eea5c08e2 100644
--- a/app/rpcapd/rpcapd.h
+++ b/app/rpcapd/rpcapd.h
@@ -21,6 +21,7 @@
 struct rte_bpf_prm;
 struct rte_mempool;
 struct rte_ring;
+struct ssl_st;
 
 #define RTE_LOGTYPE_RPCAPD RTE_LOGTYPE_USER1
 #define RPCAPD_LOG(level, ...) \
@@ -36,9 +37,10 @@ struct rte_ring;
  */
 #define MAX_CAPTURE_LEN		(DEFAULT_SNAPLEN + 2 * sizeof(struct rte_vlan_hdr))
 
-/* A connection to the client. */
+/* A connection to the client; ssl is NULL when not encrypted. */
 struct conn {
 	int fd;
+	struct ssl_st *ssl;
 };
 
 /* Per-client capture session state. */
@@ -50,6 +52,7 @@ struct session {
 	uint32_t snaplen;
 	uint32_t npkt;				/* packet sequence for rpcap_pkthdr */
 	uint32_t pdump_flags;			/* direction bits handed to pdump */
+	bool     authenticated;			/* AUTH_REQ has succeeded */
 	bool     opened;			/* OPEN_REQ has selected a port */
 	bool     capture_on;
 	bool     promisc_set;			/* we enabled promiscuous mode */
@@ -64,6 +67,8 @@ extern RTE_ATOMIC(bool) quit_signal;
 /* Command-line settings needed outside of main.c */
 extern uint32_t ring_size;
 extern uint32_t send_timeout;		/* seconds; 0 means no limit */
+extern bool use_tls;			/* -S: encrypt both connections */
+extern bool null_auth_ok;		/* -n: permit null auth off loopback */
 
 /* Address the control socket is bound to; the data socket uses the same
  * address with an ephemeral port.
@@ -71,6 +76,8 @@ extern uint32_t send_timeout;		/* seconds; 0 means no limit */
 extern struct sockaddr_storage listen_addr;
 extern socklen_t               listen_addrlen;
 
+bool is_loopback(const struct sockaddr_storage *ss);
+
 /* sock.c: transport and message framing */
 int wait_readable(const struct conn *c, int timeout_ms);
 int accept_timeout(int listen_fd, int timeout_ms);
@@ -85,8 +92,17 @@ int rpcap_discard(const struct conn *c, uint32_t plen);
 void set_sockaddr_port(struct sockaddr_storage *ss, uint16_t port);
 uint16_t get_sockaddr_port(const struct sockaddr_storage *ss);
 
+/* tls.c: TLS transport, stubbed out when built without OpenSSL */
+int tls_init(const char *certfile, const char *keyfile);
+int tls_accept(struct conn *c);
+void tls_close(struct conn *c);
+int tls_send(struct ssl_st *ssl, const void *buf, size_t len);
+int tls_recv(struct ssl_st *ssl, void *buf, size_t len);
+bool tls_pending(const struct conn *c);
+void tls_reject_handshake(int fd);
+
 /* session.c: control requests handled before a capture starts */
-int handle_auth(const struct conn *c, uint32_t plen);
+int handle_auth(const struct conn *c, uint32_t plen, struct session *s);
 int handle_findallif(const struct conn *c);
 int handle_open(const struct conn *c, uint32_t plen, struct session *s);
 
diff --git a/app/rpcapd/session.c b/app/rpcapd/session.c
index cc14f26335..61600cb286 100644
--- a/app/rpcapd/session.c
+++ b/app/rpcapd/session.c
@@ -5,8 +5,13 @@
  * the interface list, and selecting an interface.
  */
 
+#include <crypt.h>
+#include <errno.h>
+#include <pwd.h>
+#include <shadow.h>
 #include <stdlib.h>
 #include <string.h>
+#include <unistd.h>
 
 #include <rte_byteorder.h>
 #include <rte_ethdev.h>
@@ -14,6 +19,12 @@
 #include "rpcap-protocol.h"
 #include "rpcapd.h"
 
+/* Slow down a client working through a password list. */
+#define AUTH_FAIL_DELAY_SEC	1
+
+/* Bound what a client can make us allocate for credentials. */
+#define MAX_CREDENTIAL_LEN	256
+
 /* Build and send the list of available DPDK ports. */
 int
 handle_findallif(const struct conn *c)
@@ -67,37 +78,182 @@ handle_findallif(const struct conn *c)
 }
 
 /*
- * AUTH_REQ: check the authentication type only.
- *
- * There is no credential store, so a username and password cannot be
- * verified; refuse them rather than reply that they were accepted.
+ * Check credentials against the system password database, as libpcap's
+ * rpcapd does.  Privileges are not dropped afterwards, since that would
+ * break the capture, so this authenticates without authorising.
+ * Returns 0 if the credentials are good.
+ */
+static int
+check_password(const char *user, const char *password)
+{
+	const struct passwd *pw;
+	const struct spwd *sp;
+	const char *hash;
+	char *result;
+
+	pw = getpwnam(user);
+	if (pw == NULL) {
+		RPCAPD_LOG(NOTICE, "authentication failed: no such user");
+		return -1;
+	}
+
+	/* The password database only holds a placeholder when the real
+	 * hash lives in the shadow file.
+	 */
+	sp = getspnam(user);
+	hash = (sp != NULL) ? sp->sp_pwdp : pw->pw_passwd;
+
+	/* Not a hash: the account is locked ('!' or '*') or has no
+	 * password.  Either way there is nothing to check against.
+	 */
+	if (hash == NULL || *hash != '$') {
+		RPCAPD_LOG(NOTICE,
+			   "authentication failed: account has no usable password "
+			   "(is /etc/shadow readable?)");
+		return -1;
+	}
+
+	errno = 0;
+	result = crypt(password, hash);
+	if (result == NULL) {
+		RPCAPD_LOG(ERR, "crypt failed: %s",
+			   errno != 0 ? strerror(errno) : "unknown error");
+		return -1;
+	}
+
+	if (strcmp(result, hash) != 0) {
+		RPCAPD_LOG(NOTICE, "authentication failed: wrong password");
+		return -1;
+	}
+
+	return 0;
+}
+
+/*
+ * Wipe a credential before freeing it.  explicit_bzero() because the
+ * compiler may drop a memset() before free() as a dead store.
+ */
+static void
+free_credential(char *cred)
+{
+	if (cred != NULL) {
+		explicit_bzero(cred, strlen(cred));
+		free(cred);
+	}
+}
+
+/* Read a length-prefixed credential out of the AUTH_REQ payload. */
+static int
+recv_credential(const struct conn *c, uint32_t len, uint32_t *plen, char **out)
+{
+	char *buf;
+
+	if (len > *plen || len > MAX_CREDENTIAL_LEN)
+		return -1;
+
+	buf = malloc(len + 1);
+	if (buf == NULL)
+		return -1;
+
+	if (recv_full(c, buf, len) < 0) {
+		explicit_bzero(buf, len);
+		free(buf);
+		return -1;
+	}
+	buf[len] = '\0';
+	*plen -= len;
+	*out = buf;
+	return 0;
+}
+
+/*
+ * AUTH_REQ: null authentication is accepted from a loopback peer only;
+ * a remote client needs a username and password, unless -n was given.
  */
 int
-handle_auth(const struct conn *c, uint32_t plen)
+handle_auth(const struct conn *c, uint32_t plen, struct session *s)
 {
+	char *user = NULL, *password = NULL;
 	struct rpcap_auth auth;
 	uint16_t type;
+	int rc;
+
+	s->authenticated = false;
 
 	if (plen < sizeof(auth)) {
 		rpcap_discard(c, plen);
-		return rpcap_send_error(c, 0, "short authentication request");
+		return rpcap_send_error(c, PCAP_ERR_AUTH, "short authentication request");
 	}
 
 	if (recv_full(c, &auth, sizeof(auth)) < 0)
 		return -1;
-
-	/* Discard any username and password that followed. */
-	if (rpcap_discard(c, plen - sizeof(auth)) < 0)
-		return -1;
+	plen -= sizeof(auth);
 
 	type = rte_be_to_cpu_16(auth.type);
-	if (type != RPCAP_RMTAUTH_NULL) {
+	switch (type) {
+	case RPCAP_RMTAUTH_NULL:
+		if (rpcap_discard(c, plen) < 0)
+			return -1;
+
+		if (!is_loopback(&s->peer) && !null_auth_ok) {
+			RPCAPD_LOG(NOTICE,
+				   "rejecting null authentication from remote client");
+			return rpcap_send_error(c, PCAP_ERR_AUTH_FAILED,
+						"this server requires a username and "
+						"password for remote clients");
+		}
+		break;
+
+	case RPCAP_RMTAUTH_PWD:
+		if (recv_credential(c, rte_be_to_cpu_16(auth.slen1), &plen, &user) < 0 ||
+		    recv_credential(c, rte_be_to_cpu_16(auth.slen2), &plen, &password) < 0) {
+			free_credential(user);
+			return -1;
+		}
+
+		if (rpcap_discard(c, plen) < 0) {
+			free_credential(user);
+			free_credential(password);
+			return -1;
+		}
+
+		/* Refuse before checking, so a rejected password has not
+		 * already crossed the network in the clear.
+		 */
+		if (c->ssl == NULL && !is_loopback(&s->peer)) {
+			free_credential(user);
+			free_credential(password);
+			RPCAPD_LOG(NOTICE,
+				   "refusing password authentication on an unencrypted connection");
+			return rpcap_send_error(c, PCAP_ERR_AUTH_FAILED,
+						"this server will not accept a password "
+						"over an unencrypted connection; "
+						"use rpcaps://");
+		}
+
+		rc = check_password(user, password);
+		free_credential(user);
+		free_credential(password);
+
+		if (rc != 0) {
+			/* Delay a guess, and do not say which of the two
+			 * was wrong.
+			 */
+			sleep(AUTH_FAIL_DELAY_SEC);
+			return rpcap_send_error(c, PCAP_ERR_AUTH_FAILED,
+						"authentication failed");
+		}
+		break;
+
+	default:
+		if (rpcap_discard(c, plen) < 0)
+			return -1;
 		RPCAPD_LOG(NOTICE, "rejecting authentication type %u", type);
 		return rpcap_send_error(c, PCAP_ERR_AUTH_TYPE_NOTSUP,
-					"this server cannot check credentials; "
-					"connect without a username or password");
+					"authentication type not supported");
 	}
 
+	s->authenticated = true;
 	return rpcap_send_msg(c, RPCAP_MSG_AUTH_REPLY, 0, NULL, 0);
 }
 
diff --git a/app/rpcapd/sock.c b/app/rpcapd/sock.c
index 179c1a31c1..49c30c5370 100644
--- a/app/rpcapd/sock.c
+++ b/app/rpcapd/sock.c
@@ -18,6 +18,7 @@
 
 #include <rte_byteorder.h>
 #include <rte_common.h>
+#include <rte_mbuf.h>
 #include <rte_stdatomic.h>
 
 #include "rpcap-protocol.h"
@@ -59,6 +60,10 @@ wait_readable(const struct conn *c, int timeout_ms)
 {
 	struct pollfd pfd = { .fd = c->fd, .events = POLLIN };
 
+	/* Decrypted bytes buffered in the SSL object are invisible to poll() */
+	if (tls_pending(c))
+		return 1;
+
 	while (!rte_atomic_load_explicit(&quit_signal, rte_memory_order_relaxed)) {
 		int wait_ms = POLL_INTERVAL_MS;
 		int rc;
@@ -207,7 +212,11 @@ recv_full(const struct conn *c, void *buf, size_t len)
 		if (wait_readable(c, -1) != 1)
 			return -1;
 
-		n = recv(c->fd, p, len, 0);
+		if (c->ssl != NULL)
+			n = tls_recv(c->ssl, p, len);
+		else
+			n = recv(c->fd, p, len, 0);
+
 		if (n < 0 && errno == EINTR)
 			continue;
 
@@ -220,6 +229,44 @@ recv_full(const struct conn *c, void *buf, size_t len)
 	return 0;
 }
 
+/*
+ * No scatter/gather write in TLS, and SSL_write() gives each call its
+ * own record, so gather into one buffer rather than paying record
+ * overhead per piece.
+ */
+static int
+send_iov_tls(struct ssl_st *ssl, const struct iovec *iov, int iovcnt)
+{
+	uint8_t buf[sizeof(struct rpcap_header) + sizeof(struct rpcap_pkthdr) +
+		    MAX_CAPTURE_LEN];
+	const uint8_t *p = buf;
+	size_t len = 0;
+	int i;
+
+	for (i = 0; i < iovcnt; i++) {
+		if (len + iov[i].iov_len > sizeof(buf)) {
+			/* Cannot happen: buf is sized for both headers plus
+			 * MAX_CAPTURE_LEN.
+			 */
+			RPCAPD_LOG(ERR, "message too large for TLS buffer");
+			errno = EMSGSIZE;
+			return -1;
+		}
+		memcpy(buf + len, iov[i].iov_base, iov[i].iov_len);
+		len += iov[i].iov_len;
+	}
+
+	while (len > 0) {
+		int n = tls_send(ssl, p, len);
+
+		if (n <= 0)
+			return -1;
+		p += n;
+		len -= n;
+	}
+	return 0;
+}
+
 /*
  * Send all of iov, resending the remainder if sendmsg() reports a short
  * count (possible when the connection breaks or a signal arrives after
@@ -233,6 +280,9 @@ send_iov_full(const struct conn *c, struct iovec *iov, int iovcnt, int flags)
 		.msg_iovlen = iovcnt,
 	};
 
+	if (c->ssl != NULL)
+		return send_iov_tls(c->ssl, iov, iovcnt);
+
 	while (msg.msg_iovlen > 0) {
 		ssize_t n = sendmsg(c->fd, &msg, flags | MSG_NOSIGNAL);
 
diff --git a/app/rpcapd/tls.c b/app/rpcapd/tls.c
new file mode 100644
index 0000000000..f9671f63b4
--- /dev/null
+++ b/app/rpcapd/tls.c
@@ -0,0 +1,273 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Stephen Hemminger
+ *
+ * TLS transport for the rpcaps:// scheme.  Both the control and the
+ * data connection are promoted.  Built as stubs when DPDK was
+ * configured without OpenSSL.
+ */
+
+#include <errno.h>
+#include <stdbool.h>
+#include <stddef.h>
+#include <stdint.h>
+#include <string.h>
+#include <sys/socket.h>
+#include <sys/time.h>
+#include <unistd.h>
+
+#include "rpcapd.h"
+
+/* How long a peer may take to complete a handshake. */
+#define TLS_HANDSHAKE_TIMEOUT_SEC	10
+
+#ifdef RTE_HAS_OPENSSL
+
+#include <openssl/err.h>
+#include <openssl/ssl.h>
+
+static SSL_CTX *tls_ctx;
+
+static const char *
+tls_strerror(void)
+{
+	unsigned long e = ERR_get_error();
+
+	return (e != 0) ? ERR_reason_error_string(e) : "unknown error";
+}
+
+/*
+ * Build the server context at startup, so a bad certificate fails here
+ * rather than on the first client's handshake.
+ */
+int
+tls_init(const char *certfile, const char *keyfile)
+{
+	tls_ctx = SSL_CTX_new(TLS_server_method());
+	if (tls_ctx == NULL) {
+		RPCAPD_LOG(ERR, "cannot create TLS context: %s", tls_strerror());
+		return -1;
+	}
+
+	if (SSL_CTX_set_min_proto_version(tls_ctx, TLS1_2_VERSION) != 1) {
+		RPCAPD_LOG(ERR, "cannot set minimum TLS version: %s", tls_strerror());
+		return -1;
+	}
+
+	/* Hides a renegotiation from SSL_read()/SSL_write(). */
+	SSL_CTX_set_mode(tls_ctx, SSL_MODE_AUTO_RETRY);
+
+	if (SSL_CTX_use_certificate_chain_file(tls_ctx, certfile) != 1) {
+		RPCAPD_LOG(ERR, "cannot read certificate file '%s': %s",
+			   certfile, tls_strerror());
+		return -1;
+	}
+
+	if (SSL_CTX_use_PrivateKey_file(tls_ctx, keyfile, SSL_FILETYPE_PEM) != 1) {
+		RPCAPD_LOG(ERR, "cannot read private key file '%s': %s",
+			   keyfile, tls_strerror());
+		return -1;
+	}
+
+	if (SSL_CTX_check_private_key(tls_ctx) != 1) {
+		RPCAPD_LOG(ERR, "private key '%s' does not match certificate '%s'",
+			   keyfile, certfile);
+		return -1;
+	}
+
+	return 0;
+}
+
+/*
+ * SSL_accept() on a blocking socket waits indefinitely, and only one
+ * client is served at a time, so bound the handshake with socket
+ * timeouts.
+ */
+static int
+set_handshake_timeout(int fd, time_t seconds)
+{
+	struct timeval tv = { .tv_sec = seconds };
+
+	if (setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv)) < 0 ||
+	    setsockopt(fd, SOL_SOCKET, SO_SNDTIMEO, &tv, sizeof(tv)) < 0) {
+		RPCAPD_LOG(NOTICE, "cannot set TLS handshake timeout: %s",
+			   strerror(errno));
+		return -1;
+	}
+	return 0;
+}
+
+int
+tls_accept(struct conn *c)
+{
+	SSL *ssl = SSL_new(tls_ctx);
+	bool timed = set_handshake_timeout(c->fd, TLS_HANDSHAKE_TIMEOUT_SEC) == 0;
+
+	if (ssl == NULL) {
+		RPCAPD_LOG(ERR, "SSL_new: %s", tls_strerror());
+		return -1;
+	}
+
+	if (SSL_set_fd(ssl, c->fd) != 1) {
+		RPCAPD_LOG(ERR, "SSL_set_fd: %s", tls_strerror());
+		SSL_free(ssl);
+		return -1;
+	}
+
+	if (SSL_accept(ssl) != 1) {
+		/* A timeout surfaces as a syscall error on the read. */
+		if (errno == EAGAIN || errno == EWOULDBLOCK)
+			RPCAPD_LOG(ERR, "TLS handshake timed out after %u seconds",
+				   TLS_HANDSHAKE_TIMEOUT_SEC);
+		else
+			RPCAPD_LOG(ERR, "TLS handshake failed: %s", tls_strerror());
+		SSL_free(ssl);
+		return -1;
+	}
+
+	/* Back to blocking for the session. */
+	if (timed)
+		set_handshake_timeout(c->fd, 0);
+
+	RPCAPD_LOG(DEBUG, "TLS established: %s %s",
+		   SSL_get_version(ssl), SSL_get_cipher(ssl));
+	c->ssl = ssl;
+	return 0;
+}
+
+/* Send the close_notify alert so the client does not report a truncated
+ * stream.  The caller still owns the socket.
+ */
+void
+tls_close(struct conn *c)
+{
+	if (c->ssl == NULL)
+		return;
+
+	SSL_shutdown(c->ssl);
+	SSL_free(c->ssl);
+	c->ssl = NULL;
+}
+
+/*
+ * Map an SSL error onto the send()/recv() contract the callers expect:
+ * byte count on success, -1 with errno set on failure.
+ */
+static int
+tls_error(SSL *ssl, int ret, const char *what)
+{
+	int err = SSL_get_error(ssl, ret);
+
+	switch (err) {
+	case SSL_ERROR_ZERO_RETURN:
+		/* Clean shutdown by the peer: an orderly EOF. */
+		return 0;
+	case SSL_ERROR_SYSCALL:
+		/* errno is already set, unless the peer just vanished. */
+		if (errno == 0)
+			errno = ECONNRESET;
+		return -1;
+	case SSL_ERROR_WANT_READ:
+	case SSL_ERROR_WANT_WRITE:
+		errno = EAGAIN;
+		return -1;
+	default:
+		RPCAPD_LOG(DEBUG, "%s: %s", what, tls_strerror());
+		errno = EPROTO;
+		return -1;
+	}
+}
+
+int
+tls_send(struct ssl_st *ssl, const void *buf, size_t len)
+{
+	int ret = SSL_write(ssl, buf, len);
+
+	if (ret > 0)
+		return ret;
+	return tls_error(ssl, ret, "SSL_write");
+}
+
+int
+tls_recv(struct ssl_st *ssl, void *buf, size_t len)
+{
+	int ret = SSL_read(ssl, buf, len);
+
+	if (ret > 0)
+		return ret;
+	return tls_error(ssl, ret, "SSL_read");
+}
+
+/*
+ * One TLS record can hold several rpcap messages, and once read off the
+ * socket the rest sit in the SSL object where poll() cannot see them.
+ * Every wait must check this first.
+ */
+bool
+tls_pending(const struct conn *c)
+{
+	return c->ssl != NULL && SSL_pending(c->ssl) > 0;
+}
+
+#else /* !RTE_HAS_OPENSSL */
+
+int
+tls_init(const char *certfile __rte_unused, const char *keyfile __rte_unused)
+{
+	RPCAPD_LOG(ERR, "built without OpenSSL, TLS is not available");
+	return -1;
+}
+
+int
+tls_accept(struct conn *c __rte_unused)
+{
+	return -1;
+}
+
+void
+tls_close(struct conn *c __rte_unused)
+{
+}
+
+int
+tls_send(struct ssl_st *ssl __rte_unused, const void *buf __rte_unused,
+	 size_t len __rte_unused)
+{
+	errno = ENOTSUP;
+	return -1;
+}
+
+int
+tls_recv(struct ssl_st *ssl __rte_unused, void *buf __rte_unused,
+	 size_t len __rte_unused)
+{
+	errno = ENOTSUP;
+	return -1;
+}
+
+bool
+tls_pending(const struct conn *c __rte_unused)
+{
+	return false;
+}
+
+#endif /* RTE_HAS_OPENSSL */
+
+/*
+ * Turn away a handshake from a daemon without -S.  Written straight to
+ * the socket since there is no SSL context to generate it with.
+ */
+void
+tls_reject_handshake(int fd)
+{
+	static const uint8_t alert[] = {
+		21,	/* content type: alert */
+		3, 3,	/* legacy record version: TLS 1.2 */
+		0, 2,	/* payload length */
+		2,	/* level: fatal */
+		40,	/* description: handshake_failure */
+	};
+
+	RPCAPD_LOG(WARNING, "rejecting TLS handshake: server is not using TLS");
+	if (write(fd, alert, sizeof(alert)) != (ssize_t)sizeof(alert))
+		RPCAPD_LOG(DEBUG, "could not send TLS alert: %s", strerror(errno));
+}
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 8e107b48b6..b1ecaa3574 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -147,6 +147,8 @@ New Features
 
   Added the ``dpdk-rpcapd`` application, which implements the rpcap
   protocol to allow live capture in tcpdump and Wireshark.
+  Remote clients can be authenticated with a system username and password,
+  and connections encrypted with TLS when built with OpenSSL.
 
 
 Removed Items
diff --git a/doc/guides/tools/rpcapd.rst b/doc/guides/tools/rpcapd.rst
index a8b026a409..f5d292682c 100644
--- a/doc/guides/tools/rpcapd.rst
+++ b/doc/guides/tools/rpcapd.rst
@@ -18,19 +18,21 @@ the libpcap project's ``rpcapd``.
 See
 https://github.com/the-tcpdump-group/libpcap/tree/master/rpcapd
 for the reference implementation.
-Clients connect to ``dpdk-rpcapd`` using a ``rpcap://`` URL,
+Clients connect to ``dpdk-rpcapd`` using a ``rpcap://`` URL, or
+``rpcaps://`` for a TLS-encrypted connection,
 request the list of available interfaces(which are the ports of the DPDK primary),
 open one, and stream packets from it.
 
 .. warning::
 
-   ``dpdk-rpcapd`` listens on an unauthenticated, unencrypted TCP port
-   (default 2002).  Anyone able to reach the port can list DPDK ports
-   and capture all traffic flowing through them.  The default bind
-   address is ``127.0.0.1``, so the listener is not reachable from
-   other hosts; overriding this with ``--bind`` exposes captured
-   traffic to anyone who can reach that address.  **Do not run
-   ``dpdk-rpcapd`` on a production system.**
+   Anyone who can authenticate to ``dpdk-rpcapd`` can capture all
+   traffic flowing through the ports of the DPDK primary process.  The
+   default bind address is ``127.0.0.1``, so the listener is not
+   reachable from other hosts.  A client on the loopback address may
+   connect without credentials; a client from any other address must
+   authenticate with a system username and password and must use TLS to
+   send it, unless ``-n`` was given.  See `Authentication`_ and `TLS`_.
+   **Do not run ``dpdk-rpcapd`` on a production system.**
 
 
 Running the Application
@@ -63,6 +65,27 @@ The application has a small set of command-line options:
     Size of the per-session capture ring in packets.  Default is 2048.
     Rounded up to a power of two if necessary.
 
+*   ``-S``, ``--tls``
+
+    Encrypt both the control and the data connection with TLS.  Clients
+    must then use a ``rpcaps://`` URL.  Requires ``-X`` and ``-K``.
+    Available only when DPDK was built with OpenSSL.
+
+*   ``-X <file>``, ``--cert <file>``
+
+    Server certificate chain in PEM format.  Only meaningful with
+    ``-S``, and required by it.
+
+*   ``-K <file>``, ``--key <file>``
+
+    Server private key in PEM format.  Required with ``-S``; there is
+    no default.
+
+*   ``-n``, ``--null-auth``
+
+    Permit null authentication from any address, not just loopback.
+    Usually used with ``-l``.
+
 *   ``-D``, ``--debug``
 
     Increase log verbosity.  A single ``-D`` adds informational
@@ -102,6 +125,64 @@ secondary process and does not need EAL options on its command line for
 typical use.
 
 
+Authentication
+--------------
+
+A client on the loopback address may connect without credentials, which
+is what a ``rpcap://`` URL with no userinfo does.
+
+A client from any other address must supply a system username and
+password, checked against the host password database as the reference
+``rpcapd`` does.  Accounts without a usable password hash, such as
+locked accounts, are refused.
+
+A password is only accepted over an encrypted connection, so remote
+password authentication requires ``-S`` as well.  A password sent in
+the clear is refused without being checked.
+
+Credentials are checked but no privileges are dropped, so this
+authenticates a client without authorising it: any account that can log
+in has the same access to every port of the primary process.
+
+``-n`` waives the check and lets any client connect unauthenticated,
+from any address.
+
+
+TLS
+---
+
+``-S`` encrypts both the control and the data connection, and is
+available only when DPDK was built with OpenSSL.
+
+TLS is not negotiated in the rpcap protocol: the client decides from
+its URL scheme and the daemon from ``-S``, so the two have to be
+configured to agree.  A mismatch is reported rather than left to fail
+as a protocol error.
+
+A certificate and key can be generated for testing with:
+
+.. code-block:: console
+
+    openssl req -x509 -newkey rsa:2048 -nodes -days 30 \
+        -keyout key.pem -out cert.pem -subj /CN=localhost
+
+Start the daemon with them:
+
+.. code-block:: console
+
+    sudo ./<build_dir>/app/dpdk-rpcapd -S -X cert.pem -K key.pem
+
+Then connect with a ``rpcaps://`` URL:
+
+.. code-block:: console
+
+    sudo /usr/local/sbin/tcpdump -i rpcaps://localhost:2002/net_tap0 -nn -c 20
+
+A client does not validate a self-signed certificate unless told to
+trust it, so the connection is encrypted but the server is not
+authenticated.
+
+
 Client Setup
 ------------
 
@@ -174,17 +255,17 @@ in this initial version:
     Subsequent clients are queued by the listening socket but not
     serviced until the first disconnects.
 
-*   **No authentication.** Password authentication is refused with
-    ``PCAP_ERR_AUTH_TYPE_NOTSUP``; clients must connect without
-    credentials, which is what a ``rpcap://`` URL with no userinfo does.
-    With the default loopback bind, reaching the port already requires
-    an account on the host.
-
-*   **No TLS.** The ``-S`` option of the reference ``rpcapd`` is not
-    implemented, so the connection is always in the clear.  This is
-    reasonable for the default loopback bind, where the traffic never
-    leaves the host, but means ``--bind`` to any other address sends
-    captured packets over the network unencrypted.
+*   **TLS needs OpenSSL.** ``-S`` is only available when DPDK was built
+    with OpenSSL support.
+
+*   **Authentication does not restrict access.** Credentials are
+    checked, but the daemon keeps the root privileges it needs for
+    ``pdump`` instead of dropping to the authenticated user, so every
+    account that can log in has the same access to every port.
+
+*   **No client certificates.** TLS authenticates the server to the
+    client and encrypts the connection; the client is identified only
+    by its password.
 
 *   **TCP data transport only.** A client requesting UDP is refused.
 
-- 
2.53.0

