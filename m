Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A378DC369A1
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 20:24:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A92AA402CD;
	Tue,  8 Apr 2025 22:24:50 +0200 (CEST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id AF8DD4026B
 for <dev@dpdk.org>; Tue,  8 Apr 2025 22:24:48 +0200 (CEST)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-22435603572so58926675ad.1
 for <dev@dpdk.org>; Tue, 08 Apr 2025 13:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744143888;
 x=1744748688; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ebORzF8XFxzI8hRM2/FFF0b8YYxsvVM7IQOuY0+K7xw=;
 b=TnEbMVegLcBQhaeL5tlqauALEoGaJuVXX9WfVb8/I/1s+jM4EmeexKqs8NPH/Kgoj8
 MN1pbSlBBS8KI73x0wISwQOFv4P058qsxmi4A+NQKVq+n78nQdrkvrxCVARGzal1b/OY
 ePm36XaLOxbyMTdZjUrKL0XAJOiW/B8FRH0jlS1zwHsikAhszS8ChbtthAC9yE10d1EF
 obLUIInmXooN5uzloumxug2esqnyMiydVlcXu+im9SjYzoeuoLFdXAgrmCDvXdQCzLxO
 r5vfr0QYv5iYFy+fjf1C4vi+lIcWEx9cq+us+luybtG9CtJhxMba6TbJ7vdG8oX21KRd
 76uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744143888; x=1744748688;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ebORzF8XFxzI8hRM2/FFF0b8YYxsvVM7IQOuY0+K7xw=;
 b=quE+dYfSBlHBs/UOmRMeVUlXj7epIyoezxfNlKyvhOMUSWyg/r856xwFtvVxfzra/O
 PepH3+59MfR9YF1SJeCJft7aFEd1TeunzSKceJ+7Y6BDSj8WJOQnvAWQ7yv1wFaReNiS
 M9s0pBi8x5Y6ZoDgj4ucYM+4rzEPSz8cE/fg8IRWK+4032AFmNT4aVdKwsqZ6z3tmAb5
 +wjH/ivFYNNvHzabmtRhfehbF/NsIOf+V/ljZntlPrHp08QkmQqQmh7/dv9NqYjtbYzO
 sYIeh8/rPaDx+YaWxBsULNjO866V4mSSGIje5QR85OG9pld87mNfDWkqf5GRMK3WCWtb
 pacw==
X-Gm-Message-State: AOJu0YxFL4zsTPh+NX5Y5ikSMfNIcnBQ9BaowioI+AuCiRNej12rdQBF
 c+J6/DRizr/qkrIHjBDFHF2eH9Z7gJlGWsYgNPjZLVT2A7HrU4v30lFv3JiP4vO09VXXm0Qo0O9
 N
X-Gm-Gg: ASbGncuIz8iUJQOmzL0yTmz0HxKmQ0HAffsq+mL/EY4F548/Ns+wWGG4k/FdeGyf0Jh
 VsxhhIz5OdJjxjNKznuk4sfSFwIIty3pnH9UrKm+YVzi+U/dm2KYLNU9OMrweM3IboRWSZzRDHV
 fdpacbQEQ5lePkDvXgYpJBF1h/vFz3Kf/xlxZPwINx2bsiXbux3iAx5DKF4o0ItA3xKG2976Mbk
 UefHC4kxnvzazCGphZjLMtSRaUbDmQrOsbhIji/gbAaZIL5PVVfnYJ9h1Z3S1uj5oAf+tUPbiLQ
 9S1GVeSdG32uUjCBuVMff1xF6pA7812D6uh6w9sGbXBYyytI2lCW+635JZbkZ4EaiUHQfhgLn2F
 9IGohxRi1J9hrUbs4adXi
X-Google-Smtp-Source: AGHT+IG2aKv+zbasd+UnDxgfnmUDelPGpdWfvPZk8mDPOrDZH8bYJiShzGsbhTKAQX6LDe/X3qcwzQ==
X-Received: by 2002:a17:902:e750:b0:224:256e:5e4e with SMTP id
 d9443c01a7336-22ac2991b3dmr6175075ad.16.1744143887791; 
 Tue, 08 Apr 2025 13:24:47 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-229785c020dsm104810775ad.100.2025.04.08.13.24.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 13:24:47 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, lihuisong@huawei.com,
 stable@dpdk.org, Aman Singh <aman.deep.singh@intel.com>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Dongdong Liu <liudongdong3@huawei.com>
Subject: [PATCH] app/testpmd: revert auto attach/detach
Date: Tue,  8 Apr 2025 13:24:36 -0700
Message-ID: <20250408202436.158151-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
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

Revert "app/testpmd: add port attach/detach for multiple process"
This reverts commit 994635edb2c038e64617bcf2790a8cd326c3e8e0.

This commit breaks using pdump and other secondary processes that
create there own devices. The patch makes testpmd grab any new
hotplug device and configure it.

It may also break failsafe and netvsc PMD handling of VF devices.
But I don't have access to test that part.

The patch is flawed in concept, and needs to go.

Bugzilla ID: 1695
Fixes: 994635edb2c0 ("app/testpmd: add port attach/detach for multiple process")
Cc: lihuisong@huawei.com
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-pmd/testpmd.c | 77 +++++++++++-------------------------------
 1 file changed, 20 insertions(+), 57 deletions(-)

diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index b0ee39db52..6b5d94b571 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -705,7 +705,7 @@ eth_dev_set_mtu_mp(uint16_t port_id, uint16_t mtu)
 }
 
 /* Forward function declarations */
-static void setup_attached_port(void *arg);
+static void setup_attached_port(portid_t pi);
 static void check_all_ports_link_status(uint32_t port_mask);
 static int eth_event_callback(portid_t port_id,
 			      enum rte_eth_event_type type,
@@ -2906,7 +2906,6 @@ start_port(portid_t pid)
 		at_least_one_port_exist = true;
 
 		port = &ports[pi];
-
 		if (port->port_status == RTE_PORT_STOPPED) {
 			port->port_status = RTE_PORT_HANDLING;
 			all_ports_already_started = false;
@@ -3254,7 +3253,6 @@ remove_invalid_ports(void)
 	remove_invalid_ports_in(ports_ids, &nb_ports);
 	remove_invalid_ports_in(fwd_ports_ids, &nb_fwd_ports);
 	nb_cfg_ports = nb_fwd_ports;
-	printf("Now total ports is %d\n", nb_ports);
 }
 
 static void
@@ -3427,11 +3425,14 @@ attach_port(char *identifier)
 		return;
 	}
 
-	/* First attach mode: event
-	 * New port flag is updated on RTE_ETH_EVENT_NEW event
-	 */
+	/* first attach mode: event */
 	if (setup_on_probe_event) {
-		goto out;
+		/* new ports are detected on RTE_ETH_EVENT_NEW event */
+		for (pi = 0; pi < RTE_MAX_ETHPORTS; pi++)
+			if (ports[pi].port_status == RTE_PORT_HANDLING &&
+					ports[pi].need_setup != 0)
+				setup_attached_port(pi);
+		return;
 	}
 
 	/* second attach mode: iterator */
@@ -3439,17 +3440,13 @@ attach_port(char *identifier)
 		/* setup ports matching the devargs used for probing */
 		if (port_is_forwarding(pi))
 			continue; /* port was already attached before */
-		setup_attached_port((void *)(intptr_t)pi);
+		setup_attached_port(pi);
 	}
-out:
-	printf("Port %s is attached.\n", identifier);
-	printf("Done\n");
 }
 
 static void
-setup_attached_port(void *arg)
+setup_attached_port(portid_t pi)
 {
-	portid_t pi = (intptr_t)arg;
 	unsigned int socket_id;
 	int ret;
 
@@ -3464,8 +3461,14 @@ setup_attached_port(void *arg)
 			"Error during enabling promiscuous mode for port %u: %s - ignore\n",
 			pi, rte_strerror(-ret));
 
+	ports_ids[nb_ports++] = pi;
+	fwd_ports_ids[nb_fwd_ports++] = pi;
+	nb_cfg_ports = nb_fwd_ports;
 	ports[pi].need_setup = 0;
 	ports[pi].port_status = RTE_PORT_STOPPED;
+
+	printf("Port %d is attached. Now total ports is %d\n", pi, nb_ports);
+	printf("Done\n");
 }
 
 static void
@@ -3495,8 +3498,10 @@ detach_device(struct rte_device *dev)
 		TESTPMD_LOG(ERR, "Failed to detach device %s\n", rte_dev_name(dev));
 		return;
 	}
+	remove_invalid_ports();
 
 	printf("Device is detached\n");
+	printf("Now total ports is %d\n", nb_ports);
 	printf("Done\n");
 	return;
 }
@@ -3728,25 +3733,7 @@ rmv_port_callback(void *arg)
 		struct rte_device *device = dev_info.device;
 		close_port(port_id);
 		detach_device(device); /* might be already removed or have more ports */
-		remove_invalid_ports();
-	}
-	if (need_to_start)
-		start_packet_forwarding(0);
-}
-
-static void
-remove_invalid_ports_callback(void *arg)
-{
-	portid_t port_id = (intptr_t)arg;
-	int need_to_start = 0;
-
-	if (!test_done && port_is_forwarding(port_id)) {
-		need_to_start = 1;
-		stop_packet_forwarding();
 	}
-
-	remove_invalid_ports();
-
 	if (need_to_start)
 		start_packet_forwarding(0);
 }
@@ -3772,23 +3759,8 @@ eth_event_callback(portid_t port_id, enum rte_eth_event_type type, void *param,
 
 	switch (type) {
 	case RTE_ETH_EVENT_NEW:
-		/* The port in ports_id and fwd_ports_ids is always valid
-		 * from index 0 ~ (nb_ports - 1) due to updating their
-		 * position when one port is detached or removed.
-		 */
-		ports_ids[nb_ports++] = port_id;
-		fwd_ports_ids[nb_fwd_ports++] = port_id;
-		nb_cfg_ports = nb_fwd_ports;
-		printf("Port %d is probed. Now total ports is %d\n", port_id, nb_ports);
-
-		if (setup_on_probe_event) {
-			ports[port_id].need_setup = 1;
-			ports[port_id].port_status = RTE_PORT_HANDLING;
-		}
-		/* Can't initialize port directly in new event. */
-		if (rte_eal_alarm_set(100000, setup_attached_port,
-				      (void *)(intptr_t)port_id))
-			fprintf(stderr, "Could not set up deferred task to setup this attached port.\n");
+		ports[port_id].need_setup = 1;
+		ports[port_id].port_status = RTE_PORT_HANDLING;
 		break;
 	case RTE_ETH_EVENT_INTR_RMV:
 		if (port_id_is_invalid(port_id, DISABLED_WARN))
@@ -3801,15 +3773,6 @@ eth_event_callback(portid_t port_id, enum rte_eth_event_type type, void *param,
 	case RTE_ETH_EVENT_DESTROY:
 		ports[port_id].port_status = RTE_PORT_CLOSED;
 		printf("Port %u is closed\n", port_id);
-		/*
-		 * Defer to remove port id due to the reason that the ethdev
-		 * state is changed from 'ATTACHED' to 'UNUSED' only after the
-		 * event callback finished. Otherwise this port id can not be
-		 * removed.
-		 */
-		if (rte_eal_alarm_set(100000, remove_invalid_ports_callback,
-				      (void *)(intptr_t)port_id))
-			fprintf(stderr, "Could not set up deferred task to remove this port id.\n");
 		break;
 	case RTE_ETH_EVENT_RX_AVAIL_THRESH: {
 		uint16_t rxq_id;
-- 
2.47.2

