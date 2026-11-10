Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAE4606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 19:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dressler.pro header.i=@dressler.pro header.a=rsa-sha256 header.s=uddkim-202310 header.b=TmClNe+s
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 21FC940281;
	Tue, 10 Nov 2026 20:06:37 +0100 (CET)
Received: from smtp06-ext.udag.de (smtp06-ext.udag.de [62.146.106.76])
 by mails.dpdk.org (Postfix) with ESMTPS id B67994026C;
 Tue, 10 Nov 2026 20:06:35 +0100 (CET)
Received: from machine (unknown [37.228.226.247])
 by smtp06-ext.udag.de (Postfix) with ESMTPA id 30473E10DC;
 Tue, 10 Nov 2026 20:06:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dressler.pro;
 s=uddkim-202310; t=1794337595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=DoCGhttVxQeJuRZnHDdSOaa1hbsVQaunqK8FaWFbKW8=;
 b=TmClNe+sKjDBqlLmUfRBeQ/0cev1a7BLFVpEDtQBChEQNWC1dJPnmbl81cqckqN2lx9W8F
 eFHCD9JjC3vcVGlAcI33860G4oreYy4MRag8CLqcjG3ikcPAmbOiS92PxfW5l9DJ8GRL/y
 Pq4/4mNvWb7+kbW3ej1gLMnbVCsUIsJqNBwLNwYkGYX6VtUPizUC1y35HQK79kXiVqkDQd
 yzyJbQFD0f59yaOVMI4G2f7GbmKsCbOV6GsSyU2d6hmfBOJInEGNMuHshpyIdHtH5iMigt
 0NRrUGAAGYB+QD3DyHCin2wyMzj1FQV2Nd4ak7gIPh6VJDdqEF3LjFw1qkRAIA==
Authentication-Results: smtp06-ext.udag.de;
 auth=pass smtp.auth=dressler-pro-0001 smtp.mailfrom=frank@dressler.pro
From: Frank Dressler <frank@dressler.pro>
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	stable@dpdk.org
Subject: [PATCH 1/1] net/af_packet: fix accidental fanout group ID reuse
Date: Tue, 10 Nov 2026 19:06:26 +0000
Message-ID: <20261110190626.519592-1-frank@dressler.pro>
X-Mailer: git-send-email 2.56.0
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
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_PRO_TLD,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This fix ensures that the queues of an AF_PACKET vdev do not
accidentally join an already existing fanout group in the same netns.
Joining such a group would make each member receive only a fraction of
the packets.

It sets the PACKET_FANOUT_FLAG_UNIQUEID flag for the first queue which
asks the kernel to allocate a new, unique fanout group ID, then asks the
kernel for that queue's fanout configuration which includes this
generated ID but not the flag anymore (the flag is ephemeral) and then
uses it for subsequent queues to make them join the same fanout group.

The bug exists since the PMD's introduction in 2014:

  # 2014 DPDK:
  $ git show 364e08f2bb:lib/librte_pmd_af_packet/rte_eth_af_packet.c |
      grep getpid
    fanout_arg = (getpid() ^ (*internals)->if_index) & 0xffff;

  # v26.07:
  $ git show v26.07:drivers/net/af_packet/rte_eth_af_packet.c |
      grep getpid
    return (getpid() ^ if_index) & 0xffff;

The chance for a collision might look low initially as it requires PIDs
to be equal mod 65536. But the chance is high for applications running
in containers having individual pidns but a shared netns, which can be
the case in a k8s pod, or also with manually started containers, e.g.
`--network ns:<path>` in Podman. The individual pidns increase the
chance of different processes having the same PID.

To quickly reproduce the issue, you can start multiple AF_PACKET DPDK
applications with qpairs greater than 1, prefixing them with
`unshare --fork -p` to have each one get the same PID as if they were
executed in a container. Each one then only receives a fraction of
the traffic.

The used UNIQUEID fanout flag is available since Linux v4.12, while DPDK
currently requires Linux v5.4 or newer. The change is also compatible
with RHEL 8.

Fixes: 364e08f2bbc0 ("af_packet: add PMD for AF_PACKET-based virtual devices")
Cc: stable@dpdk.org

Signed-off-by: Frank Dressler <frank@dressler.pro>
---
 drivers/net/af_packet/rte_eth_af_packet.c | 27 +++++++++++++++--------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index 44f82c0309..562f0c4abe 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -839,12 +839,6 @@ open_packet_iface(const char *key __rte_unused,
 
 #define PACKET_FANOUT_INVALID -1
 
-static int
-get_fanout_group_id(int if_index)
-{
-	return (getpid() ^ if_index) & 0xffff;
-}
-
 static int
 get_fanout_mode(const char *fanout_mode)
 {
@@ -877,11 +871,11 @@ get_fanout_mode(const char *fanout_mode)
 }
 
 static int
-get_fanout(const char *fanout_mode, int if_index)
+get_fanout(const char *fanout_mode)
 {
 	int load_balance = get_fanout_mode(fanout_mode);
 	if (load_balance != PACKET_FANOUT_INVALID)
-		return get_fanout_group_id(if_index) | (load_balance << 16);
+		return load_balance << 16;
 	else
 		return PACKET_FANOUT_INVALID;
 }
@@ -996,11 +990,12 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
 	sockaddr.sll_protocol = htons(ETH_P_ALL);
 	sockaddr.sll_ifindex = (*internals)->if_index;
 
-	fanout_arg = get_fanout(fanout_mode, (*internals)->if_index);
+	fanout_arg = get_fanout(fanout_mode);
 	if (fanout_arg == PACKET_FANOUT_INVALID) {
 		PMD_LOG(ERR, "Invalid fanout mode: %s", fanout_mode);
 		goto error;
 	}
+	fanout_arg |= PACKET_FANOUT_FLAG_UNIQUEID << 16;
 
 	/*
 	 * Set the flag opportunistically if multiple queues are requested.
@@ -1142,6 +1137,20 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
 					name, pair->value);
 				goto error;
 			}
+
+			/* read back the fanout arg so later queues join the same fanout group */
+			if (q == 0) {
+				socklen_t fanout_arg_len = sizeof(fanout_arg);
+				rc = getsockopt(qsockfd, SOL_PACKET, PACKET_FANOUT, &fanout_arg,
+						&fanout_arg_len);
+				if (rc == -1 || fanout_arg_len != sizeof(fanout_arg)) {
+					PMD_LOG_ERRNO(ERR,
+						"%s: could not get PACKET_FANOUT "
+						"on AF_PACKET socket for %s",
+						name, pair->value);
+					goto error;
+				}
+			}
 		}
 	}
 
-- 
2.56.0

