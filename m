Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE1DCA5FC1
	for <dpdk-dev@archiver.kernel.org>; Thu,  1 Oct 2026 02:59:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E93E42E6B;
	Thu,  1 Oct 2026 04:59:03 +0200 (CEST)
Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com
 [74.125.227.166])
 by mails.dpdk.org (Postfix) with ESMTP id E118642DA6
 for <dev@dpdk.org>; Thu,  1 Oct 2026 04:59:00 +0200 (CEST)
Received: by mail-pj2-f38.google.com with SMTP id
 d9443c01a7336-2e2da4743b0so6173415ad.1
 for <dev@dpdk.org>; Wed, 30 Sep 2026 19:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790823540;
 x=1791428340; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g4bZXuTcFxPu78UkrzvaFgHMl9EFB61o2zfAZAIehNg=;
 b=yvOenVDVsEVVaBiHoL3hn5THTvq/tgN5iXzMnoPbF4zW2cUXnwXYy+DQXIOA2PmudO
 9exrezp1G/aMcPTu0e2MJXeQ6+WMKJtm+/fy/3do554roLiZYLnK2OzoosMqTTuLrXxo
 wEiMKOT0yygHDfalgME2g+Hve7lNmmMj4pwsFb4c8Ssfz8ADulgprZs5b45gfV2jUSQG
 vNJKcImHOpXuQINVPtHpqbaG33kM5GjVwtHrAo1KS5QRYpilLhVkTZ722bU09ZzcO03P
 6aLR6ytgtpil634rj/BkwY92hdUFjeuHa8yHDJgKyHxn9lf8vMWzJhoEX13TPJxo3GN+
 3UIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790823540; x=1791428340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=g4bZXuTcFxPu78UkrzvaFgHMl9EFB61o2zfAZAIehNg=;
 b=DBNp6qCsBxxsREKsj7bY5Ej39KVWIuXb4YhAcEuHDrE+zCyAQl3rXti5MQ5A3HrVro
 8aE8MGz+H+u62g2PfKc+WCjsW31DoK75vvvsWPPh3STZ/qUl8EdzOiOdobkpTyOu7pfR
 OrwzB7rNMiChx8t/5ud5WvA+sXllG774J0ukCSWceNd8vVDTQFW3LIPnJ3Jd2BdhKTyL
 Tz0CW5lnIk4NGRSRAYHXOgVcUUmdZzpSFWY0pXyR00YTqC0qKtmA4zXRYKlaix/kYO3x
 Ked38FlEL6pfIBDUWVAUtyUqCzgedKKbJldQ0+Dkc15VH5NFP2avkdsquueCXDTNb9Ky
 Ep6w==
X-Gm-Message-State: AFq9FYKPHIZq5Qez5uRYJrn5ujBGRadJjbXYfEFMy5CW8wSGRU9GEHCa
 uHVAtpbHPIWtuEO5G4nZ8W6WJcytCubkgE4XQgCp1pytBeQsfAQGRsU55nYlH+JCXmBy5bLOuHN
 Ql4fplLg=
X-Gm-Gg: AYBFou0VVU4DY2FI4IKtB2u0R9e+O85UFqxDVNCI3Czh64D6NZ3Ub9A90x78w77maV+
 F69NDeh9MMnldlaqa98L1ahzNRieM+91xEeX1fXpQaueH+CBZ+JNs+qAVMedsvVNjolbsZr1zCA
 U+PiC5lYf+jFX4mXnCB6i9xHxIKpTZyGTao87VYZRdnczbjl4kCt3xlCMDlSlcOaRcXimxItUZA
 pM1MjF5e6xU1uSr0kB2A850DCoZxoY/s8cOaBSzoKicnK5PmMZPbfMB25phYjppNGKjwzcQXriA
 UfIqB98qZfeXV7YXUcYNjB3W4B30E3GQbsu8AgQNkeVdDmi5xX7CszQGJRI/8nEqDFMZbiRjNXp
 u1l0YELLxKrz8lY/36RK2zZbDElCaxVeZz5chfoQV4TsrI5oLmukeR0eiBeTeZ41hShKbnxq9Rz
 ldEdi62wyTlapQYdt6Yao9XoBGrWsPZrwsMG9e1BZmJ8Hm7gwr2I44J55BbV+4TzOgn9C+inrog
 FrODW9DRt5TQDdV1Emkw+hJ1KsfM33kZ9/3ig==
X-Received: by 2002:a17:90a:38a4:b0:3a0:c85a:ee12 with SMTP id
 98e67ed59e1d1-3a4f33d2dd7mr579936a91.41.1790823539741; 
 Wed, 30 Sep 2026 19:58:59 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f471b16asm2024487a91.9.2026.09.30.19.58.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 19:58:59 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v4 4/4] app/rpcapd: add host list option
Date: Wed, 30 Sep 2026 19:35:29 -0700
Message-ID: <20261001025853.319860-5-stephen@networkplumber.org>
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

Add -l to restrict which clients may connect, as libpcap's rpcapd
does.  The argument is the list itself rather than a file naming one,
with hosts separated by a comma, semicolon or space, so a list can be
copied between the two daemons.

Names are resolved once at startup, so DNS stays out of the accept
path and an unresolvable name fails at startup rather than when a
client first arrives.  Every address a name resolves to is accepted.

The list is checked after any TLS handshake, since a client using
rpcaps:// can only read an error sent inside the session.  Only the
control connection is checked: the data connection is already
restricted to the address the control connection came from.

This bounds which hosts may connect but does not identify them, so it
complements the password authentication rather than replacing it.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/rpcapd/main.c                      | 135 ++++++++++++++++++++++++-
 app/rpcapd/rpcap-protocol.h            |   1 +
 app/rpcapd/rpcapd.h                    |   1 +
 app/rpcapd/sock.c                      |   2 +-
 doc/guides/rel_notes/release_26_11.rst |   1 +
 doc/guides/tools/rpcapd.rst            |   8 ++
 6 files changed, 145 insertions(+), 3 deletions(-)

diff --git a/app/rpcapd/main.c b/app/rpcapd/main.c
index 0cf6c3f4ba..e354623cf0 100644
--- a/app/rpcapd/main.c
+++ b/app/rpcapd/main.c
@@ -66,6 +66,11 @@ bool use_tls;				/* -S */
 bool null_auth_ok;			/* -n */
 static const char *tls_certfile;	/* -X argument */
 static const char *tls_keyfile;		/* -K argument */
+static const char *host_list;		/* -l argument; NULL means any host */
+
+/* -l resolved at startup; empty means no restriction. */
+static struct sockaddr_storage *allowed_hosts;
+static unsigned int num_allowed_hosts;
 
 struct sockaddr_storage listen_addr;
 socklen_t               listen_addrlen;
@@ -94,6 +99,114 @@ is_loopback(const struct sockaddr_storage *ss)
 	return false;
 }
 
+/* Separators in the -l argument, same set as libpcap's rpcapd. */
+#define HOST_LIST_SEP " ,;"
+
+/*
+ * A dual-stack socket reports a v4 peer as ::ffff:a.b.c.d, which
+ * same_host() will not match against an AF_INET entry.  Normalize both
+ * the peer and the list, since a resolver can also return a mapped
+ * address.
+ */
+static void
+unmap_v4(struct sockaddr_storage *ss)
+{
+	const struct sockaddr_in6 *sin6 = (const void *)ss;
+	struct sockaddr_in sin = {
+		.sin_family = AF_INET,
+		.sin_port   = sin6->sin6_port,
+	};
+
+	if (ss->ss_family != AF_INET6 || !IN6_IS_ADDR_V4MAPPED(&sin6->sin6_addr))
+		return;
+
+	memcpy(&sin.sin_addr, &sin6->sin6_addr.s6_addr[12], sizeof(sin.sin_addr));
+	memset(ss, 0, sizeof(*ss));
+	memcpy(ss, &sin, sizeof(sin));
+}
+
+/*
+ * Resolve the -l list at startup, so an unresolvable name fails here
+ * rather than when a client connects.  A name can have several
+ * addresses; all of them are accepted.
+ */
+static void
+parse_host_list(void)
+{
+	static const struct addrinfo hints = {
+		.ai_family   = AF_UNSPEC,
+		.ai_socktype = SOCK_STREAM,
+	};
+	char *copy, *token, *saveptr;
+
+	if (host_list == NULL)
+		return;
+
+	copy = strdup(host_list);
+	if (copy == NULL)
+		rte_exit(EXIT_FAILURE, "Cannot copy host list: %s\n", strerror(errno));
+
+	for (token = strtok_r(copy, HOST_LIST_SEP, &saveptr); token != NULL;
+	     token = strtok_r(NULL, HOST_LIST_SEP, &saveptr)) {
+		struct addrinfo *res, *ai;
+		unsigned int n = 0;
+		void *tmp;
+		int rc;
+
+		rc = getaddrinfo(token, NULL, &hints, &res);
+		if (rc != 0)
+			rte_exit(EXIT_FAILURE, "Invalid host '%s' in host list: %s\n",
+				 token, gai_strerror(rc));
+
+		for (ai = res; ai != NULL; ai = ai->ai_next)
+			n++;
+
+		tmp = realloc(allowed_hosts,
+			      (num_allowed_hosts + n) * sizeof(*allowed_hosts));
+		if (tmp == NULL)
+			rte_exit(EXIT_FAILURE, "Cannot grow host list: %s\n",
+				 strerror(errno));
+		allowed_hosts = tmp;
+
+		for (ai = res; ai != NULL; ai = ai->ai_next) {
+			struct sockaddr_storage *slot =
+				&allowed_hosts[num_allowed_hosts++];
+
+			memset(slot, 0, sizeof(*slot));
+			memcpy(slot, ai->ai_addr, ai->ai_addrlen);
+			unmap_v4(slot);
+		}
+
+		freeaddrinfo(res);
+	}
+	free(copy);
+
+	/* An empty list is a typo, not a request to allow everyone. */
+	if (num_allowed_hosts == 0)
+		rte_exit(EXIT_FAILURE, "Host list '%s' contains no hosts\n", host_list);
+}
+
+/* Only the control connection is checked; accept_from() pins the data
+ * connection to the same peer.
+ */
+static bool
+host_allowed(const struct sockaddr_storage *ss)
+{
+	struct sockaddr_storage peer = *ss;
+	unsigned int i;
+
+	if (num_allowed_hosts == 0)
+		return true;
+
+	unmap_v4(&peer);
+
+	for (i = 0; i < num_allowed_hosts; i++)
+		if (same_host(&peer, &allowed_hosts[i]))
+			return true;
+
+	return false;
+}
+
 static void
 parse_bind_addr(void)
 {
@@ -211,6 +324,17 @@ handle_client(int ctrl_fd)
 	if (setup_tls(&ctrl) < 0)
 		goto done;
 
+	/* After the handshake: a TLS client can only read an error sent
+	 * inside the session.
+	 */
+	if (!host_allowed(&peer)) {
+		RPCAPD_LOG(WARNING, "rejected client %s: not in the allowed host list",
+			host);
+		rpcap_send_error(&ctrl, PCAP_ERR_HOSTNOAUTH,
+				 "this host is not allowed to connect to this server");
+		goto done;
+	}
+
 	while (!rte_atomic_load_explicit(&quit_signal, rte_memory_order_relaxed)) {
 		struct rpcap_header hdr;
 		uint32_t plen;
@@ -343,6 +467,8 @@ usage(FILE *f, const char *progname)
 		"  -b, --bind <addr>     bind address (default 127.0.0.1, ::1 with -6)\n"
 		"  -4                    use only IPv4\n"
 		"  -6                    use only IPv6\n"
+		"  -l, --hosts <list>    only accept clients from these hosts,\n"
+		"                        separated by ',' ';' or space\n"
 		"  -N <ring size>        ring size in packets (default %u)\n"
 #ifdef RTE_HAS_OPENSSL
 		"  -S, --tls             encrypt connections with TLS (rpcaps://)\n"
@@ -386,6 +512,7 @@ parse_opts(int argc, char **argv)
 	static const struct option long_options[] = {
 		{ "port",         required_argument, NULL, 'p' },
 		{ "bind",         required_argument, NULL, 'b' },
+		{ "hosts",        required_argument, NULL, 'l' },
 		{ "null-auth",    no_argument,       NULL, 'n' },
 #ifdef RTE_HAS_OPENSSL
 		{ "tls",          no_argument,       NULL, 'S' },
@@ -403,7 +530,7 @@ parse_opts(int argc, char **argv)
 	};
 	int option_index, c;
 
-	while ((c = getopt_long(argc, argv, "hnD46p:b:N:"
+	while ((c = getopt_long(argc, argv, "hnD46p:b:l:N:"
 #ifdef RTE_HAS_OPENSSL
 				"SX:K:"
 #endif
@@ -420,6 +547,9 @@ parse_opts(int argc, char **argv)
 		case 'b':
 			bind_addr = optarg;
 			break;
+		case 'l':
+			host_list = optarg;
+			break;
 		case '4':
 			bind_family = AF_INET;
 			break;
@@ -506,6 +636,7 @@ parse_opts(int argc, char **argv)
 
 	/* Resolve the bind address now that -4/-6/-b have been seen. */
 	parse_bind_addr();
+	parse_host_list();
 
 	/* There is no sensible default for either: libpcap's rpcapd looks
 	 * for cert.pem and key.pem in the current directory, which is not
@@ -519,7 +650,7 @@ parse_opts(int argc, char **argv)
 		rte_exit(EXIT_FAILURE,
 			 "A certificate or key was given without -S\n");
 
-	if (null_auth_ok && !is_loopback(&listen_addr))
+	if (null_auth_ok && !is_loopback(&listen_addr) && num_allowed_hosts == 0)
 		RPCAPD_LOG(ERR,
 			"-n allows any client that can reach this port to capture traffic");
 }
diff --git a/app/rpcapd/rpcap-protocol.h b/app/rpcapd/rpcap-protocol.h
index 7fc1ec5db5..787189eecc 100644
--- a/app/rpcapd/rpcap-protocol.h
+++ b/app/rpcapd/rpcap-protocol.h
@@ -43,6 +43,7 @@
 
 /* Error codes carried in the 'value' field of RPCAP_MSG_ERROR */
 #define PCAP_ERR_AUTH               3	/* generic authentication error */
+#define PCAP_ERR_HOSTNOAUTH        10	/* peer address is not in the allowed list */
 #define PCAP_ERR_WRONGVER          17
 #define PCAP_ERR_AUTH_FAILED       18	/* credentials were not accepted */
 #define PCAP_ERR_TLS_REQUIRED      19	/* server will only speak TLS */
diff --git a/app/rpcapd/rpcapd.h b/app/rpcapd/rpcapd.h
index 3eea5c08e2..aa4d01dba5 100644
--- a/app/rpcapd/rpcapd.h
+++ b/app/rpcapd/rpcapd.h
@@ -79,6 +79,7 @@ extern socklen_t               listen_addrlen;
 bool is_loopback(const struct sockaddr_storage *ss);
 
 /* sock.c: transport and message framing */
+bool same_host(const struct sockaddr_storage *a, const struct sockaddr_storage *b);
 int wait_readable(const struct conn *c, int timeout_ms);
 int accept_timeout(int listen_fd, int timeout_ms);
 int accept_from(int listen_fd, const struct sockaddr_storage *want,
diff --git a/app/rpcapd/sock.c b/app/rpcapd/sock.c
index 49c30c5370..0571e6c759 100644
--- a/app/rpcapd/sock.c
+++ b/app/rpcapd/sock.c
@@ -115,7 +115,7 @@ accept_timeout(int listen_fd, int timeout_ms)
 /* Compare the host part of two addresses, ignoring the port: the data
  * connection comes from an ephemeral port, not the control one.
  */
-static bool
+bool
 same_host(const struct sockaddr_storage *a, const struct sockaddr_storage *b)
 {
 	if (a->ss_family != b->ss_family)
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index b1ecaa3574..9e35d5881a 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -149,6 +149,7 @@ New Features
   protocol to allow live capture in tcpdump and Wireshark.
   Remote clients can be authenticated with a system username and password,
   and connections encrypted with TLS when built with OpenSSL.
+  Access can also be restricted to a list of allowed client hosts.
 
 
 Removed Items
diff --git a/doc/guides/tools/rpcapd.rst b/doc/guides/tools/rpcapd.rst
index f5d292682c..9e041e3a0f 100644
--- a/doc/guides/tools/rpcapd.rst
+++ b/doc/guides/tools/rpcapd.rst
@@ -60,6 +60,14 @@ The application has a small set of command-line options:
     Use only IPv6; an IPv4 argument to ``-b`` is rejected.  The default
     bind address becomes ``::1``.
 
+*   ``-l <host_list>``, ``--hosts <host_list>``
+
+    Only allow the hosts in ``<host_list>`` to connect.  The list is
+    host names or addresses separated by commas, semicolons or spaces,
+    and includes loopback, so ``127.0.0.1`` must be listed for a local
+    client.  Names are resolved at startup.  By default any host that
+    can reach the port may connect.
+
 *   ``-N <ring_size>``
 
     Size of the per-session capture ring in packets.  Default is 2048.
-- 
2.53.0

