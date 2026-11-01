Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1CA606A324
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Nov 2026 23:22:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 36DD140E32;
	Mon,  2 Nov 2026 00:22:00 +0100 (CET)
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by mails.dpdk.org (Postfix) with ESMTPS id F3A8840E1C
 for <dev@dpdk.org>; Mon,  2 Nov 2026 00:21:58 +0100 (CET)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-1931ff67a29so4056785c88.1
 for <dev@dpdk.org>; Sun, 01 Nov 2026 15:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kev009.com; s=google; t=1793575317; x=1794180117; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QlTe5UdFIy93sGt0BMxI1Xt9dproD+S/babPEuuaB3k=;
 b=hP+cUOedY9WttXxcX1lnnWyah4sTvwwxqAinwieUh6njfNRQFWWGNGaOI+XFl48quQ
 B+xdoBRpp2vM9k4tBw3mj8KR+XDbmV+yDi6vxB7ti3ZGye4/VJjYcXL3tJ3ekFfjnEp/
 KQs6pwzfpbeiBbr9uRS6Fwd1Ben270yuKDhhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793575317; x=1794180117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QlTe5UdFIy93sGt0BMxI1Xt9dproD+S/babPEuuaB3k=;
 b=1uftPWnwKe1YJeWRxuHmcE5ZJD3lrHxO6KR7Lho9V/l/jvb2K7K72NWusZjsrEfooP
 6RfyNpLza8tCyndyMh4JhG8dfyKw+3vPpxpZpC9wZUaxvTCNiadvVc0BV9G3HgK4FtZ8
 7GgSX+xh8Ah9Bks2CSb/q4R3bYyXpp1CyFVXPDeajkhJd3xAx8jUqHTs4rStH8OvfDPO
 46joNrp3WqfIHnMUIuHfTlg/adSDXk7zRbZwH+qxbuSrl1dF3JjsLhhxJgFBfhJj+W83
 vxUMrif86qF8518lplrnFARx2JC2023XR/xcEkSgTX9e/85kAwi4lbACEK3bjhCcrtM5
 NkcQ==
X-Gm-Message-State: AFq9FYKE+4CCR79I6Q681RVBzgD9LSJRoqaTdpdVg0427wQYnTkI6cpa
 S9GCuJRGDyJaGisBVykNq2+GZQ0R5NwwJHoD51ENafzEJ+XgyCwenz19r6Hf9/HOr1WsQeTXdvt
 ecJZOArAm
X-Gm-Gg: AYBFou0aRFnOjmmIlTJGYd0IT9ud8GLTmcLsPLb2JzoYN1rtT81CazhSnYL0nXtbhIA
 EgdqQGSIeRB5E/UgpekkmlKcfNJZIktvEDlkrn1IHUjOPKas20qvDd914ItM88tG5gUQJynhhWl
 BuxgnsyjRk0McNDiVspQHhcPZSu1ISVzrBm3n9IJsXCApMQYMCrFQOyL3LgZcVexC2DI3lJ8rpl
 Fq6mwyM6gEyyIZp5TymdulBRShUH7KqwIe/2l9ucphbkggrx57yCdNLGp/EsN627523eNDAJt7+
 HfKuu1lzgTTRCqfY8GUuHjFEXTZa14tr48UReH4Letz/MSHpvosEu6/NgDaXYOac5ZuzRRxpDT9
 E0wRvbXBYUuj7em59AXcyqIHW1t34odNDlCdV2tSoH6m3zVysKrhpGiAxl898Gruf0O0Q4ZLbDP
 jmN4olJH5EYYqWfaCNzyXMvOvGcqs22YrJStjj017d3WE1CISsxDfDp8v9WT1YnmdalYXNzqg5V
 Oi6/hIvqFlw2L5FPzrUJZVu7wPMFyyaD8+ZcfOmPJQyW8r5nnNB9bD0GuRS8yg8WLX4gZK71Zp/
 IcuaYLUirOYulVmY+RhmC3g7tsqDYJFIgt6LzuBYA35kDZrAcxevNbzFePRRcKkpdkZcioliU1n
 O+lZTmYDuLDvPPD5odtre+epp91xTVeSb0+b1zJXqBbaGm50tefbI+idiDoF+6MSXFo3OuHW7Rr
 hgisxHX90=
X-Received: by 2002:a05:7022:1e13:b0:18d:ac5a:89ef with SMTP id
 a92af1059eb24-1ac5c17ab77mr10860379c88.31.1793575317057; 
 Sun, 01 Nov 2026 15:21:57 -0800 (PST)
Received: from kev-ws-aurora.cv0.bbox.io ([172.83.102.10])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac194b5437sm31982675c88.13.2026.11.01.15.21.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 15:21:56 -0800 (PST)
From: Kevin Bowling <kevin.bowling@kev009.com>
To: dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Harman Kalra <hkalra@marvell.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, stable@dpdk.org
Subject: [PATCH RESEND 1/3] eal/freebsd: fix active interrupt source cleanup
Date: Sun,  1 Nov 2026 16:21:51 -0700
Message-ID: <20261101232154.94354-2-kevin.bowling@kev009.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261101232154.94354-1-kevin.bowling@kev009.com>
References: <20261101232154.94354-1-kevin.bowling@kev009.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,TVD_FROM_1,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A descriptor can stop being readable after kevent reports it. On EAGAIN
or EINTR, interrupt dispatch skips the cleanup that clears the source's
active flag. Callback unregistration then keeps returning EAGAIN and the
synchronous unregister operation spins indefinitely.

Complete source cleanup after unsuccessful reads. Initialize the callback
flag for each event so a previous event cannot cause a callback on an
unreadable source.

Add a FreeBSD regression test that makes two descriptors ready in one
batch and drains one from the other's callback. An alarm dispatched in a
later batch confirms the read-error path has run before checking callback
counts and unregistration. The old path fails with a stuck active source;
the correction passes repeated runs.

Fixes: 23150bd8d8a8 ("eal/bsd: add interrupt thread")
Cc: stable@dpdk.org

Signed-off-by: Kevin Bowling <kevin.bowling@kev009.com>
---
 .mailmap                           |   1 +
 MAINTAINERS                        |   3 +-
 app/test/meson.build               |   4 +
 app/test/test_interrupts_freebsd.c | 187 +++++++++++++++++++++++++++++
 lib/eal/freebsd/eal_interrupts.c   |  13 +-
 5 files changed, 199 insertions(+), 9 deletions(-)
 create mode 100644 app/test/test_interrupts_freebsd.c

diff --git a/.mailmap b/.mailmap
index 492bb56acb..5c666ba171 100644
--- a/.mailmap
+++ b/.mailmap
@@ -889,6 +889,7 @@ Keith Wiles <keith.wiles@intel.com> <keith.wiles@windriver.com>
 Kent Wires <kent.wires@intel.com>
 Kerem Aksu <kerem.aksu@i2i-systems.com>
 Keunhong Lee <dlrmsghd@gmail.com>
+Kevin Bowling <kevin.bowling@kev009.com>
 Kevin Laatz <kevin.laatz@intel.com>
 Kevin Lampis <klampis@solarflare.com>
 Kevin Liu <kevinx.liu@intel.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index cc86b35b29..f78126b03d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -240,7 +240,7 @@ Interrupt Subsystem
 M: Harman Kalra <hkalra@marvell.com>
 F: lib/eal/include/rte_epoll.h
 F: lib/eal/*/*interrupts.*
-F: app/test/test_interrupts.c
+F: app/test/test_interrupts*.c
 
 Keep alive
 F: lib/eal/include/rte_keepalive.h
@@ -383,6 +383,7 @@ F: drivers/bus/pci/linux/*vfio*
 FreeBSD EAL (with overlaps)
 M: Bruce Richardson <bruce.richardson@intel.com>
 F: lib/eal/freebsd/
+F: app/test/test_interrupts_freebsd.c
 F: doc/guides/freebsd_gsg/
 
 FreeBSD contigmem
diff --git a/app/test/meson.build b/app/test/meson.build
index 9805cf5bee..74e766351b 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -218,6 +218,10 @@ source_file_deps = {
     'test_version.c': [],
 }
 
+if is_freebsd
+    source_file_deps += {'test_interrupts_freebsd.c': []}
+endif
+
 source_file_ext_deps = {
     'test_compressdev.c': ['zlib'],
     'test_pcapng.c': ['pcap'],
diff --git a/app/test/test_interrupts_freebsd.c b/app/test/test_interrupts_freebsd.c
new file mode 100644
index 0000000000..c6a68f8a66
--- /dev/null
+++ b/app/test/test_interrupts_freebsd.c
@@ -0,0 +1,187 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Kevin Bowling
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <unistd.h>
+
+#include <rte_alarm.h>
+#include <rte_atomic.h>
+#include <rte_cycles.h>
+#include <rte_interrupts.h>
+
+#include "test.h"
+
+static struct rte_intr_handle *handles[3];
+static int pipes[3][2];
+static RTE_ATOMIC(bool) entered;
+static RTE_ATOMIC(bool) release_gate;
+static RTE_ATOMIC(unsigned int) callbacks;
+static RTE_ATOMIC(unsigned int) drained;
+static RTE_ATOMIC(bool) batch_done;
+static RTE_ATOMIC(int) alarm_status;
+
+static void
+freebsd_gate(void *arg __rte_unused)
+{
+	char byte;
+
+	if (read(pipes[0][0], &byte, 1) != 1)
+		return;
+	rte_atomic_store_explicit(&entered, true, rte_memory_order_release);
+	while (!rte_atomic_load_explicit(&release_gate, rte_memory_order_acquire))
+		rte_delay_us_sleep(1000);
+}
+
+static void
+freebsd_after_batch(void *arg __rte_unused)
+{
+	rte_atomic_store_explicit(&batch_done, true, rte_memory_order_release);
+}
+
+static void
+freebsd_drain_peer(void *arg)
+{
+	int *peer = arg;
+	char byte;
+
+	if (read(*peer, &byte, 1) == 1)
+		rte_atomic_fetch_add_explicit(&drained, 1, rte_memory_order_relaxed);
+	rte_atomic_store_explicit(&alarm_status,
+		rte_eal_alarm_set(1000, freebsd_after_batch, NULL), rte_memory_order_relaxed);
+	rte_atomic_fetch_add_explicit(&callbacks, 1, rte_memory_order_release);
+}
+
+static int
+freebsd_unregister(unsigned int i)
+{
+	int ret;
+	unsigned int tries = 1000;
+
+	do {
+		ret = rte_intr_callback_unregister(handles[i],
+			i == 0 ? freebsd_gate : freebsd_drain_peer, (void *)-1);
+		if (ret != -EAGAIN)
+			return ret;
+		rte_delay_us_sleep(1000);
+	} while (--tries != 0);
+	return ret;
+}
+
+static void
+freebsd_interrupt_teardown(void)
+{
+	unsigned int i;
+
+	rte_atomic_store_explicit(&release_gate, true, rte_memory_order_release);
+	for (i = 0; i < RTE_DIM(handles); i++) {
+		/* A failed unregister leaves the source referenced by the EAL. */
+		if (handles[i] != NULL && freebsd_unregister(i) == -EAGAIN)
+			continue;
+		if (handles[i] != NULL) {
+			rte_intr_fd_set(handles[i], -1);
+			rte_intr_instance_free(handles[i]);
+			handles[i] = NULL;
+		}
+		if (pipes[i][0] >= 0)
+			close(pipes[i][0]);
+		if (pipes[i][1] >= 0)
+			close(pipes[i][1]);
+	}
+	rte_eal_alarm_cancel(freebsd_after_batch, NULL);
+}
+
+static int
+freebsd_interrupt_setup(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < RTE_DIM(handles); i++)
+		pipes[i][0] = pipes[i][1] = -1;
+	rte_atomic_store_explicit(&entered, false, rte_memory_order_relaxed);
+	rte_atomic_store_explicit(&release_gate, false, rte_memory_order_relaxed);
+	rte_atomic_store_explicit(&callbacks, 0, rte_memory_order_relaxed);
+	rte_atomic_store_explicit(&drained, 0, rte_memory_order_relaxed);
+	rte_atomic_store_explicit(&batch_done, false, rte_memory_order_relaxed);
+	rte_atomic_store_explicit(&alarm_status, 0, rte_memory_order_relaxed);
+	for (i = 0; i < RTE_DIM(handles); i++) {
+		if (pipe2(pipes[i], O_NONBLOCK) != 0)
+			goto fail;
+		handles[i] = rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE);
+		if (handles[i] == NULL)
+			goto fail;
+		if (rte_intr_fd_set(handles[i], pipes[i][0]) != 0 ||
+				rte_intr_type_set(handles[i], i == 0 ?
+				RTE_INTR_HANDLE_EXT : RTE_INTR_HANDLE_UNKNOWN) != 0)
+			goto fail;
+	}
+	return TEST_SUCCESS;
+fail:
+	freebsd_interrupt_teardown();
+	return TEST_FAILED;
+}
+
+static int
+freebsd_interrupt_read_race(void)
+{
+	unsigned int i;
+
+	TEST_ASSERT_SUCCESS(rte_intr_callback_register(handles[0], freebsd_gate, NULL),
+		"Cannot register gate");
+	TEST_ASSERT_SUCCESS(rte_intr_callback_register(handles[1], freebsd_drain_peer,
+		&pipes[2][0]), "Cannot register first source");
+	TEST_ASSERT_SUCCESS(rte_intr_callback_register(handles[2], freebsd_drain_peer,
+		&pipes[1][0]), "Cannot register second source");
+	TEST_ASSERT_EQUAL(write(pipes[0][1], "g", 1), 1, "Cannot trigger gate");
+	for (i = 0; i < 1000 &&
+			!rte_atomic_load_explicit(&entered, rte_memory_order_acquire); i++)
+		rte_delay_us_sleep(1000);
+	TEST_ASSERT(rte_atomic_load_explicit(&entered, rte_memory_order_acquire),
+		"Interrupt thread did not reach gate");
+
+	/* Both descriptors are ready in the next kevent batch. The first callback
+	 * drains its peer, so the second read sees EAGAIN. Neither a callback on
+	 * the empty source nor a permanently active source is valid.
+	 */
+	TEST_ASSERT_EQUAL(write(pipes[1][1], "a", 1), 1, "Cannot trigger first source");
+	TEST_ASSERT_EQUAL(write(pipes[2][1], "b", 1), 1, "Cannot trigger second source");
+	rte_atomic_store_explicit(&release_gate, true, rte_memory_order_release);
+	for (i = 0; i < 1000 &&
+			rte_atomic_load_explicit(&callbacks, rte_memory_order_acquire) == 0; i++)
+		rte_delay_us_sleep(1000);
+	/* An alarm installed by the callback is dispatched in a later kevent
+	 * batch, after the peer's read and source cleanup have been attempted.
+	 */
+	TEST_ASSERT_EQUAL(rte_atomic_load_explicit(&alarm_status, rte_memory_order_relaxed),
+		0, "Cannot schedule completion alarm");
+	for (i = 0; i < 1000 &&
+			!rte_atomic_load_explicit(&batch_done, rte_memory_order_acquire); i++)
+		rte_delay_us_sleep(1000);
+	TEST_ASSERT(rte_atomic_load_explicit(&batch_done, rte_memory_order_acquire),
+		"Interrupt thread did not finish the event batch");
+	for (i = 0; i < RTE_DIM(handles); i++)
+		TEST_ASSERT_EQUAL(freebsd_unregister(i), 1, "Source %u remained active", i);
+	TEST_ASSERT_EQUAL(rte_atomic_load_explicit(&callbacks, rte_memory_order_acquire),
+		1, "Callback ran without a readable event");
+	TEST_ASSERT_EQUAL(rte_atomic_load_explicit(&drained, rte_memory_order_relaxed),
+		1, "Peer was not drained");
+	return TEST_SUCCESS;
+}
+
+static struct unit_test_suite freebsd_interrupt_suite = {
+	.suite_name = "FreeBSD interrupt dispatch",
+	.unit_test_cases = {
+		TEST_CASE_ST(freebsd_interrupt_setup, freebsd_interrupt_teardown,
+			freebsd_interrupt_read_race),
+		TEST_CASES_END()
+	}
+};
+
+static int
+freebsd_interrupt_test(void)
+{
+	return unit_test_suite_runner(&freebsd_interrupt_suite);
+}
+
+REGISTER_FAST_TEST(interrupt_freebsd_autotest, NOHUGE_OK, ASAN_OK, freebsd_interrupt_test);
diff --git a/lib/eal/freebsd/eal_interrupts.c b/lib/eal/freebsd/eal_interrupts.c
index b29a2b174e..8ba92f71a8 100644
--- a/lib/eal/freebsd/eal_interrupts.c
+++ b/lib/eal/freebsd/eal_interrupts.c
@@ -464,12 +464,12 @@ eal_intr_process_interrupts(struct kevent *events, int nfds)
 	union rte_intr_read_buffer buf;
 	struct rte_intr_callback *cb, *next;
 	struct rte_intr_source *src;
-	bool call = false;
 	int n, bytes_read;
 	struct kevent ke;
 
 	for (n = 0; n < nfds; n++) {
 		int event_fd = events[n].ident;
+		bool call = false;
 
 		rte_spinlock_lock(&intr_lock);
 		TAILQ_FOREACH(src, &intr_sources, next)
@@ -511,13 +511,10 @@ eal_intr_process_interrupts(struct kevent *events, int nfds)
 			 */
 			bytes_read = read(event_fd, &buf, bytes_read);
 			if (bytes_read < 0) {
-				if (errno == EINTR || errno == EWOULDBLOCK)
-					continue;
-
-				EAL_LOG(ERR, "Error reading from file "
-					"descriptor %d: %s",
-					event_fd,
-					strerror(errno));
+				if (errno != EINTR && errno != EWOULDBLOCK)
+					EAL_LOG(ERR, "Error reading from file "
+						"descriptor %d: %s", event_fd,
+						strerror(errno));
 			} else if (bytes_read == 0)
 				EAL_LOG(ERR, "Read nothing from file "
 					"descriptor %d", event_fd);
-- 
2.56.0

