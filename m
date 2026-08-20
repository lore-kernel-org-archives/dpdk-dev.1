Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7FEC5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:25:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1836540BA2;
	Thu, 20 Aug 2026 07:24:33 +0200 (CEST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id CBA9640BA2
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:24:31 +0200 (CEST)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2ce87c7e3bbso20859575ad.1
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203471;
 x=1787808271; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ce/25cvZ/mX1ZAdU/FbvjdsGElgtXL/o8dt6sT7Advk=;
 b=h8Kw+EzzvR1z22nUmk9TQPGNDw/sQ3GMxR41MNqHesLfnxX3sXnH52fnHNKOs+L1Z4
 2ggU8gKLPhAtXQyJOJeGcJjzAgsjWpmRv+kUz6kKOeNHFsdCwdHZHeb0z5TYYL7v4ZgO
 aeymDILpJ/7kYc3Mb8pNNSsjiL0+/MqSAIHNV1GsoOJ+rhomZOOIgbyDi1boh91KALuP
 OmnYPl9oKKz+NgGrgAwodEM+Qm8xwZihJbdnZPx74zTleiDQLCrUpfdyQ2Bq+Arzg3U9
 TcoBs421oL+I2XoSDzEoue+OjdfaKCX0GTBUFaIOdq9KuGtn7EzNjM6Fo4ce92NZRrqk
 WSEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203471; x=1787808271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ce/25cvZ/mX1ZAdU/FbvjdsGElgtXL/o8dt6sT7Advk=;
 b=C9thIHP4hrz/nxT9HRC2JCDdGdRUptPPLx+UGdWbCr71+rCuxiue7Z8+Z2MW6FC6Rh
 YveIYxl2ZxCDGYePjM/CAIJQH9+Fcn+uiQDHsAQsOVxEaOSI78RGAu9EE0T2bp8LwNDy
 b86t9jgjKyg04hWARf+zKzTnKvocl5cCNGnmxKLi4AciZSet2KDiQvrUvaq4L7VavDBr
 H0sFl3nfSAPUPv8kbUIdkZ7iGLfpqbIN20PkAcaEsE40YD09W4Negn7JTR0JuajeVxNR
 6vOFsA6uamwJKZpoTbSlhjmavkgVqH6fNSKjv+aQHctb2v7D4xN13XKOKy/+4/Qi+7ZS
 LvMA==
X-Gm-Message-State: AFuF++k+TktuKqeCuDSa27+9fHX5tayF2vhRj8eY6T4e6zw3EVneTMCI
 6+zoEFO6mbhpVHlrFwW919ywvr72ev7B1d2P0XsRUJKT6kW6tFVYOhhUcIxU06Oxv1A1UMjbVJZ
 Mv2li
X-Gm-Gg: AR+sD12sIvaLgFsDOL+D6IWoffz2WOBx3xTyJVwu8Ags4R8X0S5W/OFaF9NoqTkDivt
 oe3YMXaXCvu0RkPO5KC5YBDJ/XjhCDVD1qaGFiu5OLzhjxJ1QTxRj9uunsaXLR/QCoCc4FRqNlC
 4Hk2eTyXOayENX439koBtCl7IZPO6HwCgW5ptHlg+9tyOq/WlcawgMO/N1ZLmT07IZLMdEPmCYu
 P7ov/4Oq6iDpLWCtsGHGXfkR47nsBTlxC+Raph/qI5gIM3P50Lz9B0QEUsJa+9L6MDA5cb0boOk
 yr9w7mNm5rhTF2TN/jVzwO9tZswaNO7p2RWv32kpSVrnqE6wjdpcwfSJDpnKgCejiPubpv1r7i4
 +QuFGMtryOE8gkEg9sbwt9/vUXpQ03GMsHxovnd6h/mVH3Juex60WqlsCi1H4yGgKzW/o+EqDbG
 Msj7oXzgxcEYxz+XyIud8ATkJj2SU1VBe3ZO3T7RG4yNIjaMFbnS3vJgFOUFVeuUyPFMJ80zj4z
 e5It014cI2H2vrYQt3D+/Y00ks=
X-Received: by 2002:a17:90b:1cc3:b0:381:6c5:3f63 with SMTP id
 98e67ed59e1d1-39580ace560mr19196657a91.6.1787203470900; 
 Wed, 19 Aug 2026 22:24:30 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.24.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:24:30 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: [PATCH 23/61] net/cnxk: replace use of rte_memcpy
Date: Wed, 19 Aug 2026 22:12:13 -0700
Message-ID: <20260820052251.1453273-24-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820052251.1453273-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
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
index 0ea3d7e89f..0e6d851169 100644
--- a/drivers/net/cnxk/cnxk_ethdev_ops.c
+++ b/drivers/net/cnxk/cnxk_ethdev_ops.c
@@ -462,7 +462,7 @@ cnxk_nix_mac_addr_set(struct rte_eth_dev *eth_dev, struct rte_ether_addr *addr)
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
index 1b013ce598..cbf7171ca8 100644
--- a/drivers/net/cnxk/cnxk_rep_flow.c
+++ b/drivers/net/cnxk/cnxk_rep_flow.c
@@ -81,7 +81,8 @@ prepare_pattern_data(const struct rte_flow_item *pattern, uint16_t nb_pattern,
 			hdr.mask_sz = term[pattern->type].item_size;
 		}
 
-		rte_memcpy(RTE_PTR_ADD(pattern_data, len), &hdr, sizeof(cnxk_pattern_hdr_t));
+		memcpy(RTE_PTR_ADD(pattern_data, len), &hdr,
+		       sizeof(cnxk_pattern_hdr_t));
 		len += sizeof(cnxk_pattern_hdr_t);
 
 		/* Copy pattern spec data */
@@ -231,7 +232,8 @@ prepare_action_data(const struct rte_flow_action *action, uint16_t nb_action, ui
 		hdr.type = action->type;
 		hdr.conf_sz = sz;
 
-		rte_memcpy(RTE_PTR_ADD(action_data, len), &hdr, sizeof(cnxk_action_hdr_t));
+		memcpy(RTE_PTR_ADD(action_data, len), &hdr,
+		       sizeof(cnxk_action_hdr_t));
 		len += sizeof(cnxk_action_hdr_t);
 
 		/* Copy action conf data */
diff --git a/drivers/net/cnxk/cnxk_rep_msg.c b/drivers/net/cnxk/cnxk_rep_msg.c
index a222e2b5cd..5da1d9999f 100644
--- a/drivers/net/cnxk/cnxk_rep_msg.c
+++ b/drivers/net/cnxk/cnxk_rep_msg.c
@@ -58,7 +58,7 @@ receive_control_message(int socketfd, void *data, uint32_t len)
 			if (cmsg->cmsg_type == SCM_CREDENTIALS) {
 				cr = (struct ucred *)CMSG_DATA(cmsg);
 			} else if (cmsg->cmsg_type == SCM_RIGHTS) {
-				rte_memcpy(&afd, CMSG_DATA(cmsg), sizeof(int));
+				memcpy(&afd, CMSG_DATA(cmsg), sizeof(int));
 				plt_rep_dbg("afd %d", afd);
 			}
 		}
@@ -90,7 +90,7 @@ send_message_on_socket(int socketfd, void *data, uint32_t len, int afd)
 		cmsg->cmsg_len = CMSG_LEN(sizeof(int));
 		cmsg->cmsg_level = SOL_SOCKET;
 		cmsg->cmsg_type = SCM_RIGHTS;
-		rte_memcpy(CMSG_DATA(cmsg), &afd, sizeof(int));
+		memcpy(CMSG_DATA(cmsg), &afd, sizeof(int));
 	}
 
 	size = sendmsg(socketfd, &mh, MSG_DONTWAIT);
@@ -198,7 +198,7 @@ cnxk_rep_msg_populate_type(void *buffer, uint32_t *length, cnxk_type_t type, uin
 	data.length = sz;
 
 	/* Populate the type data */
-	rte_memcpy(RTE_PTR_ADD(buffer, len), &data, sizeof(cnxk_type_data_t));
+	memcpy(RTE_PTR_ADD(buffer, len), &data, sizeof(cnxk_type_data_t));
 	len += sizeof(cnxk_type_data_t);
 
 	*length = len;
@@ -218,7 +218,7 @@ cnxk_rep_msg_populate_header(void *buffer, uint32_t *length)
 	hdr.signature = CTRL_MSG_SIGNATURE;
 
 	/* Populate header data */
-	rte_memcpy(RTE_PTR_ADD(buffer, len), &hdr, sizeof(cnxk_header_t));
+	memcpy(RTE_PTR_ADD(buffer, len), &hdr, sizeof(cnxk_header_t));
 	len += sizeof(cnxk_header_t);
 
 	*length = len;
diff --git a/drivers/net/cnxk/cnxk_rep_ops.c b/drivers/net/cnxk/cnxk_rep_ops.c
index c481015592..7e24ec737d 100644
--- a/drivers/net/cnxk/cnxk_rep_ops.c
+++ b/drivers/net/cnxk/cnxk_rep_ops.c
@@ -692,7 +692,7 @@ cnxk_rep_mac_addr_set(struct rte_eth_dev *eth_dev, struct rte_ether_addr *addr)
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

