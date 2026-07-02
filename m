Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5BAC43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Jul 2026 16:13:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5527F40689;
	Thu,  2 Jul 2026 18:12:51 +0200 (CEST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id 29330402D2
 for <dev@dpdk.org>; Thu,  2 Jul 2026 18:12:50 +0200 (CEST)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2ca64989e64so18496315ad.2
 for <dev@dpdk.org>; Thu, 02 Jul 2026 09:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1783008769;
 x=1783613569; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=698Q5tedFcw0mco+OZSeTzS6p4GhmXD1hwMC/eXTvCg=;
 b=oPCapskzY6yi14okPRK2Qx3qRvoNl3yuxwK/OY6hHSZe3vvr9uvupjFJZajYDCEbHw
 I66QS1Uk7ZoIzYI5xQDTH9NPgVv6lLtBqL/ufrFYdkkaWOc4LznpWEESroYkmUWBHpTz
 MkeuwvL3U/ULhEujHJ2hNlVMHs49cAq00NA3EQhsjtLljrsleSGiZHIx3wPcTOQtTmct
 Ju+1JGvYvPmq5gEEoXfwSFM7lnjVvUNqb9fQmXsRCZFAiOCNX4MHcvH19IEG9+/7oWdp
 6TKJDPzA7JHcjvEopVBslWzApXkDZH6ZBbE1/+jxoPwWwwhmFNQ6yIr10tWgp1u5MqOT
 ZMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783008769; x=1783613569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=698Q5tedFcw0mco+OZSeTzS6p4GhmXD1hwMC/eXTvCg=;
 b=j35jsjXF3em/GHEQUtqwdgfIdTgGj/PgBOMWfoYXe0ZTyc1Alns2MFBkB4XjbbmDnx
 9gXGyU7ixsKqXNDXQMQ2i53K/TYBWtraBzRJ7ShliCDlijfWvAV2DgqfIqhsQ0yMuxHc
 XlIFVpvCALXsthEZPWdAHhAGD5svKKPheIKs1DTFehY27lCO4iQ34Y4/oHfpy8FQshug
 TZCfLzs1kwmif0yYzp/0DHMQo3N64iVLF4bZL3Dn0DvLvl4El6JfYFTycU3WzvfxUmZC
 HyzcMVOSUXHNZhGwDqX/ugETyE7y0dIVI4ZwtOvz7I0MMqsAz4y1bKrUONRZNPS7lmhd
 N52Q==
X-Gm-Message-State: AOJu0YwVX0EICk1uFhBmci2HGhUx/gFXiGL/K/BLBolpCwUsiye6Ly7n
 t4WsaUWIYpNoMHi0mpjCpAlEUOKKkkYaqCQ4TlDYbmQ9LK0PhHXPw4ToSuLmbyCjX3SkKcL/qzy
 Rmgp6
X-Gm-Gg: AfdE7cnEoBcJWI22CYLLAUnwwtyVISTJc5esMfsw1gK+k/uzmIHNrJ2QJJoGDYuxBCn
 kY3u10Y4oO+ohMe+vpmG8+uuENX6Eld8xIzf0LWxSuFgT1KHHLEWyG/vCNtr37r/FHAzdRcw9fT
 H4YCkAqdy8ZEUhcsdZqyDx9IAmaRkNCZtQ/jneHpMo6Jj6esXLAm8b8xmi7TUNgm9YrRMIi7Yj6
 907+RjCh8/bDRGGS3Z1JetRpj0Xc4N1miEdkEmhQuCnwwv8Ry9T+6M8C+t2K9tjyyhAD4/URi0n
 Wp5VcCiDo/Ar5gB3ab0BXlGZhWMusx9hiH00DCeXFuK3LW6Dl4rZpbF6V1xT0/VYEA7c0vb/vZB
 0csS+NxAPPwDRFRUhalyWLFjfaYkRm7YaVIlJUl8lPp7B34asTGtANJRGx6F4B289sQrbpEJG4P
 1NJnaGbj8NPWgz4x1CMR2N0Axgo9FVWA25ifIwSYrd5Ban3RkVnOM=
X-Received: by 2002:a17:903:35d0:b0:2c9:c517:d075 with SMTP id
 d9443c01a7336-2ca7e6a5c2amr61764835ad.15.1783008768850; 
 Thu, 02 Jul 2026 09:12:48 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b3c7fa566sm9849304c88.4.2026.07.02.09.12.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 09:12:48 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Maayan Kashani <mkashani@nvidia.com>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH 1/4] app/testpmd: fix port socket ID with NUMA disabled
Date: Thu,  2 Jul 2026 09:10:11 -0700
Message-ID: <20260702161244.363233-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702161244.363233-1-stephen@networkplumber.org>
References: <20260702130729.26577-1-mkashani@nvidia.com>
 <20260702161244.363233-1-stephen@networkplumber.org>
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

When NUMA support is disabled, mbuf pools are created on
SOCKET_ID_ANY but port->socket_id is still set to 0 (or
--socket-num). Pool lookup is by name, and the name embeds the
socket id the pool was created with, so every lookup that does not
go through the one workaround in start_port() misses:

- the per-lcore pool assignment in init_config() leaves
  fwd_lcores[]->mbp NULL, so "testpmd --no-numa
  --forward-mode=txonly" crashes with a NULL dereference in
  pkt_burst_transmit();
- the per-segment and multi-mempool lookups in rx_queue_setup()
  fall back to the first pool, so buffer split fails when a later
  segment needs a larger mbuf
  (e.g. --mbuf-size=314,978 --rxpkts=186,978);
- the interactive "port <id> rxq|txq <id> setup" command cannot
  find a pool.

The --socket-num option is also ignored for pool allocation since
the offending commit.

Fix this at the source instead of adding another workaround at a
lookup site: make port->socket_id hold the same socket id the
pools are created and named with. Add uma_socket_id() returning
the pool socket key used when NUMA support is disabled
(--socket-num if given, otherwise SOCKET_ID_ANY) and use it for
pool creation, port->socket_id and the per-lcore pool fallback.
The workaround in start_port() is then unnecessary.

Passing SOCKET_ID_ANY to rte_eth_rx/tx_queue_setup() is allowed by
the ethdev API and matches the cross-NUMA intent of the offending
commit.

Fixes: 835fd4893a31 ("app/testpmd: support cross-NUMA allocations")
Cc: stable@dpdk.org

Reported-by: Maayan Kashani <mkashani@nvidia.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-pmd/testpmd.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index fcd8a90967..b5dca03047 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -1729,6 +1729,17 @@ init_config_port_offloads(portid_t pid, uint32_t socket_id)
 	}
 }
 
+/*
+ * Socket id that mbuf pools are created (and named) with when NUMA
+ * support is disabled: --socket-num if given, otherwise SOCKET_ID_ANY.
+ */
+static unsigned int
+uma_socket_id(void)
+{
+	return socket_num == UMA_NO_CONFIG ?
+	       (unsigned int)SOCKET_ID_ANY : socket_num;
+}
+
 static void
 init_config(void)
 {
@@ -1778,8 +1789,7 @@ init_config(void)
 					socket_id = socket_ids[0];
 			}
 		} else {
-			socket_id = (socket_num == UMA_NO_CONFIG) ?
-				    0 : socket_num;
+			socket_id = uma_socket_id();
 		}
 		/* Apply default TxRx configuration for all ports */
 		init_config_port_offloads(pid, socket_id);
@@ -1823,7 +1833,7 @@ init_config(void)
 			mempools[i] = mbuf_pool_create
 					(mbuf_data_size[i],
 					 nb_mbuf_per_pool,
-					 SOCKET_ID_ANY, i);
+					 uma_socket_id(), i);
 		}
 	}
 
@@ -1841,7 +1851,8 @@ init_config(void)
 			rte_lcore_to_socket_id(fwd_lcores_cpuids[lc_id]));
 
 		if (mbp == NULL)
-			mbp = mbuf_pool_find_first(0);
+			mbp = mbuf_pool_find_first(numa_support ?
+				0 : uma_socket_id());
 		fwd_lcores[lc_id]->mbp = mbp;
 #ifdef RTE_LIB_GSO
 		/* initialize GSO context */
@@ -1920,10 +1931,7 @@ init_fwd_streams(void)
 			}
 		}
 		else {
-			if (socket_num == UMA_NO_CONFIG)
-				port->socket_id = 0;
-			else
-				port->socket_id = socket_num;
+			port->socket_id = uma_socket_id();
 		}
 	}
 
@@ -3153,8 +3161,7 @@ start_port(portid_t pid)
 				} else {
 					struct rte_mempool *mp =
 						mbuf_pool_find_first
-							((numa_support ? port->socket_id :
-							(unsigned int)SOCKET_ID_ANY));
+							(port->socket_id);
 					if (mp == NULL) {
 						fprintf(stderr,
 							"Failed to setup RX queue: No mempool allocation on the socket %d\n",
-- 
2.53.0

