Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65C8C5DF8C
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:30:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D1DD440DFB;
	Fri, 21 Aug 2026 21:29:47 +0200 (CEST)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by mails.dpdk.org (Postfix) with ESMTP id A4ADE40DFB
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:29:46 +0200 (CEST)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-cbedf433a99so1299644a12.2
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340586;
 x=1787945386; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q3owLjzSE8epeHPsAnu4fDKZ60DApFZr/2ypc6NDjlo=;
 b=r3IS1amHzilNt9K5QWZoNwDLwl0Zr4S+ZRZ58Dl41VTX6MztkjDFQiNNMK2lQ9QpdN
 /0QJehyHNJYN7gzBaT3nm+NsnskuMbiGTgXUJfhI0hI6Lmb7EgPRD0/beqlQH+hGwOE4
 wPnRoMXYRZpUn5FlAyRjLT0nu1ob6aGLQ9D4fYhD65YiS1cl27tSU7Dir4hU6VTh0ORw
 GzHR7orARXwd13sqv9I7BWFgOraPUGhlFEc7HZf230GgJ7KG87LJJCrfPQZUxHifS7sm
 XqYkc/tf/PnG5INhgcYUdPdTxGTXFQjK/JcLJWf1cKqreziKt4J5Syy76u3hf/Lc8DqF
 0scw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340586; x=1787945386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=q3owLjzSE8epeHPsAnu4fDKZ60DApFZr/2ypc6NDjlo=;
 b=kGrAtw3VZ73txq8ZsriYfcf+yrQFNCUCgPdja6D+4OkzUDod8y7Ika7BuoHMypiiOa
 l+DM4c/k2T/dmRttOoo/CqbzXxgVb5oDiiULM3N0MdUr3s1moa9AlE/dJtnTVC4xYaJc
 V3wV4DcS1vpj1lw4GYhMBgy09FgiOGsE5z2UzdbM/l4Xf6Ph/OEo+60h8UoCAp3I9W2q
 bJH1XLeK1f8tqLnZyaIf1+Kzk0ShgnKlTn3YHtFNZESbBY4AFJaBq88jWgmpS065XOIW
 2dWgBj0ILYFVxRs9WZVTGgO8V3HfMA1SAn41oHIaU8PTH1Un4FO22IwqSfdqChEs8t6l
 wF3g==
X-Gm-Message-State: AFuF++kH6Wkv7QbsjPcbO+dWNAjckZuKWYGyiy/2xh68yG7/C8jyiZ6N
 tTliuwHgpnivwkPdyJkcNWIdoJ1WNEw3+mT2crARempvjn6hA9nnxAAGWLcQQD2EXcqm+u4sr4o
 gF7KlsL8=
X-Gm-Gg: AR+sD126Sgf74qwrIAM0iq4rTYmQSvz2RzTNv1wJFyuArbBUDnQZ8+CehxgJdqanh5h
 5ibzaraSkAoBArOLagciogSTDeIqOHlPqBFdFajNQ4domN+9L19jXLZLYg7GB9hiyyaPtAHwxnY
 yZcBy4n8QaxDCxLyJ9xk/irpcVp2NR/Ycm/3Xth2ZDtS2zORTePtPiKicEuQpp01z36mDAQRIZW
 1v2dYCEXsqltX+AHzKtQj+q9lmzBGdzjE1jtz6xpWb9w6+EzotvwgtPK7p2q9q4aWCp5vfjMUZJ
 DW42si0va2LAq6+FapRK4Qes8q2zo3XH3k7LDljBygAikpUJbJiFqXWYA8/gq0xJAi6fcKsKobs
 RSXD5zs1JLAphEkEZ2OaSCLsnQQH4yksKd0lC34amyUbWR96miFKdD/h4uSIVdr0g63ceP1dy9F
 TcYTREKlb4YqPJEAyY/R6TRySrgKgdvmrisiKZsg6SPAFwFHjV+EOE5OsljSxXTh/Owg8r3Nb6K
 mb3RT5ggbd4f3/dctcbw8tfQxhLXWYcMFhB7XqV27Mle11a8Q==
X-Received: by 2002:a05:6a21:3382:b0:3c4:396d:4a6c with SMTP id
 adf61e73a8af0-3cd2fd9f17dmr14403652637.5.1787340585800; 
 Fri, 21 Aug 2026 12:29:45 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.29.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:29:45 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: [PATCH v2 30/68] net/cnxk: replace use of rte_memcpy
Date: Fri, 21 Aug 2026 12:24:25 -0700
Message-ID: <20260821192646.146382-31-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
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

Don't need rte_memcpy for fixed size value.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/cnxk/cnxk_eswitch_devargs.c | 3 ++-
 drivers/net/cnxk/cnxk_ethdev_ops.c      | 2 +-
 drivers/net/cnxk/cnxk_rep.c             | 3 ++-
 drivers/net/cnxk/cnxk_rep_flow.c        | 6 ++++--
 drivers/net/cnxk/cnxk_rep_msg.c         | 8 ++++----
 drivers/net/cnxk/cnxk_rep_ops.c         | 2 +-
 drivers/net/cnxk/cnxk_tm.c              | 5 ++---
 7 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/net/cnxk/cnxk_eswitch_devargs.c b/drivers/net/cnxk/cnxk_eswitch_devargs.c
index 655813c71a..556503ade1 100644
--- a/drivers/net/cnxk/cnxk_eswitch_devargs.c
+++ b/drivers/net/cnxk/cnxk_eswitch_devargs.c
@@ -112,7 +112,8 @@ cnxk_eswitch_repr_devargs(struct rte_pci_device *pci_dev, struct cnxk_eswitch_de
 			goto fail;
 		}
 
-		rte_memcpy(&eswitch_dev->esw_da[j].da, &eth_da[i], sizeof(struct rte_eth_devargs));
+		memcpy(&eswitch_dev->esw_da[j].da, &eth_da[i],
+		       sizeof(struct rte_eth_devargs));
 		/* No of representor ports to be created */
 		eswitch_dev->repr_cnt.nb_repr_created += eswitch_dev->esw_da[j].nb_repr_ports;
 		j++;
diff --git a/drivers/net/cnxk/cnxk_ethdev_ops.c b/drivers/net/cnxk/cnxk_ethdev_ops.c
index b1ccc6598c..69c4375db1 100644
--- a/drivers/net/cnxk/cnxk_ethdev_ops.c
+++ b/drivers/net/cnxk/cnxk_ethdev_ops.c
@@ -463,7 +463,7 @@ cnxk_nix_mac_addr_set(struct rte_eth_dev *eth_dev, struct rte_ether_addr *addr)
 	}
 
 	/* Update mac address to cnxk ethernet device */
-	rte_memcpy(dev->mac_addr, addr->addr_bytes, RTE_ETHER_ADDR_LEN);
+	memcpy(dev->mac_addr, addr->addr_bytes, RTE_ETHER_ADDR_LEN);
 
 exit:
 	return rc;
diff --git a/drivers/net/cnxk/cnxk_rep.c b/drivers/net/cnxk/cnxk_rep.c
index e536898d3a..1e72d5dbaa 100644
--- a/drivers/net/cnxk/cnxk_rep.c
+++ b/drivers/net/cnxk/cnxk_rep.c
@@ -409,7 +409,8 @@ cnxk_representee_notification(void *roc_nix, struct roc_eswitch_repte_notify_msg
 		goto done;
 	}
 
-	rte_memcpy(msg->notify_msg, notify_msg, sizeof(struct roc_eswitch_repte_notify_msg));
+	memcpy(msg->notify_msg, notify_msg,
+	       sizeof(struct roc_eswitch_repte_notify_msg));
 	plt_rep_dbg("Pushing new notification : msg type %d", msg->notify_msg->type);
 	pthread_mutex_lock(&eswitch_dev->repte_msg_proc.mutex);
 	TAILQ_INSERT_TAIL(&repte_msg_proc->msg_list, msg, next);
diff --git a/drivers/net/cnxk/cnxk_rep_flow.c b/drivers/net/cnxk/cnxk_rep_flow.c
index 68ee334e01..23d9376c24 100644
--- a/drivers/net/cnxk/cnxk_rep_flow.c
+++ b/drivers/net/cnxk/cnxk_rep_flow.c
@@ -82,7 +82,8 @@ prepare_pattern_data(const struct rte_flow_item *pattern, uint16_t nb_pattern,
 			hdr.mask_sz = term[pattern->type].item_size;
 		}
 
-		rte_memcpy(RTE_PTR_ADD(pattern_data, len), &hdr, sizeof(cnxk_pattern_hdr_t));
+		memcpy(RTE_PTR_ADD(pattern_data, len), &hdr,
+		       sizeof(cnxk_pattern_hdr_t));
 		len += sizeof(cnxk_pattern_hdr_t);
 
 		/* Copy pattern spec data */
@@ -232,7 +233,8 @@ prepare_action_data(const struct rte_flow_action *action, uint16_t nb_action, ui
 		hdr.type = action->type;
 		hdr.conf_sz = sz;
 
-		rte_memcpy(RTE_PTR_ADD(action_data, len), &hdr, sizeof(cnxk_action_hdr_t));
+		memcpy(RTE_PTR_ADD(action_data, len), &hdr,
+		       sizeof(cnxk_action_hdr_t));
 		len += sizeof(cnxk_action_hdr_t);
 
 		/* Copy action conf data */
diff --git a/drivers/net/cnxk/cnxk_rep_msg.c b/drivers/net/cnxk/cnxk_rep_msg.c
index 48179dab36..837471c0dc 100644
--- a/drivers/net/cnxk/cnxk_rep_msg.c
+++ b/drivers/net/cnxk/cnxk_rep_msg.c
@@ -59,7 +59,7 @@ receive_control_message(int socketfd, void *data, uint32_t len)
 			if (cmsg->cmsg_type == SCM_CREDENTIALS) {
 				cr = (struct ucred *)CMSG_DATA(cmsg);
 			} else if (cmsg->cmsg_type == SCM_RIGHTS) {
-				rte_memcpy(&afd, CMSG_DATA(cmsg), sizeof(int));
+				memcpy(&afd, CMSG_DATA(cmsg), sizeof(int));
 				plt_rep_dbg("afd %d", afd);
 			}
 		}
@@ -91,7 +91,7 @@ send_message_on_socket(int socketfd, void *data, uint32_t len, int afd)
 		cmsg->cmsg_len = CMSG_LEN(sizeof(int));
 		cmsg->cmsg_level = SOL_SOCKET;
 		cmsg->cmsg_type = SCM_RIGHTS;
-		rte_memcpy(CMSG_DATA(cmsg), &afd, sizeof(int));
+		memcpy(CMSG_DATA(cmsg), &afd, sizeof(int));
 	}
 
 	size = sendmsg(socketfd, &mh, MSG_DONTWAIT);
@@ -199,7 +199,7 @@ cnxk_rep_msg_populate_type(void *buffer, uint32_t *length, cnxk_type_t type, uin
 	data.length = sz;
 
 	/* Populate the type data */
-	rte_memcpy(RTE_PTR_ADD(buffer, len), &data, sizeof(cnxk_type_data_t));
+	memcpy(RTE_PTR_ADD(buffer, len), &data, sizeof(cnxk_type_data_t));
 	len += sizeof(cnxk_type_data_t);
 
 	*length = len;
@@ -219,7 +219,7 @@ cnxk_rep_msg_populate_header(void *buffer, uint32_t *length)
 	hdr.signature = CTRL_MSG_SIGNATURE;
 
 	/* Populate header data */
-	rte_memcpy(RTE_PTR_ADD(buffer, len), &hdr, sizeof(cnxk_header_t));
+	memcpy(RTE_PTR_ADD(buffer, len), &hdr, sizeof(cnxk_header_t));
 	len += sizeof(cnxk_header_t);
 
 	*length = len;
diff --git a/drivers/net/cnxk/cnxk_rep_ops.c b/drivers/net/cnxk/cnxk_rep_ops.c
index 6dab022732..2409e8790f 100644
--- a/drivers/net/cnxk/cnxk_rep_ops.c
+++ b/drivers/net/cnxk/cnxk_rep_ops.c
@@ -693,7 +693,7 @@ cnxk_rep_mac_addr_set(struct rte_eth_dev *eth_dev, struct rte_ether_addr *addr)
 	cnxk_rep_msg_populate_header(buffer, &len);
 
 	msg_sm_meta.portid = rep_dev->rep_id;
-	rte_memcpy(&msg_sm_meta.addr_bytes, addr->addr_bytes, RTE_ETHER_ADDR_LEN);
+	memcpy(&msg_sm_meta.addr_bytes, addr->addr_bytes, RTE_ETHER_ADDR_LEN);
 	cnxk_rep_msg_populate_command_meta(buffer, &len, &msg_sm_meta,
 					   sizeof(cnxk_rep_msg_eth_set_mac_meta_t),
 					   CNXK_REP_MSG_ETH_SET_MAC);
diff --git a/drivers/net/cnxk/cnxk_tm.c b/drivers/net/cnxk/cnxk_tm.c
index 0ed6732dda..48354d902b 100644
--- a/drivers/net/cnxk/cnxk_tm.c
+++ b/drivers/net/cnxk/cnxk_tm.c
@@ -300,8 +300,7 @@ cnxk_nix_tm_shaper_profile_add(struct rte_eth_dev *eth_dev, uint32_t id,
 	profile->profile.pkt_len_adj = params->pkt_length_adjust;
 	profile->profile.pkt_mode = params->packet_mode;
 	profile->profile.free_fn = rte_free;
-	rte_memcpy(&profile->params, params,
-		   sizeof(struct rte_tm_shaper_params));
+	memcpy(&profile->params, params, sizeof(struct rte_tm_shaper_params));
 
 	rc = roc_nix_tm_shaper_profile_add(nix, &profile->profile);
 
@@ -373,7 +372,7 @@ cnxk_nix_tm_node_add(struct rte_eth_dev *eth_dev, uint32_t node_id,
 	if (!node)
 		return -ENOMEM;
 
-	rte_memcpy(&node->params, params, sizeof(struct rte_tm_node_params));
+	memcpy(&node->params, params, sizeof(struct rte_tm_node_params));
 
 	node->nix_node.id = node_id;
 	node->nix_node.parent_id = parent_node_id;
-- 
2.53.0

