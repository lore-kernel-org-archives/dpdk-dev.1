Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F508CC6B0F
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 22:35:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1DF2640A67;
	Wed, 14 Oct 2026 00:35:08 +0200 (CEST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id 1EAF640A79
 for <dev@dpdk.org>; Wed, 14 Oct 2026 00:35:05 +0200 (CEST)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-3ab8309dcbaso2535360a91.1
 for <dev@dpdk.org>; Tue, 13 Oct 2026 15:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791930904;
 x=1792535704; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+0G+6ELCFSGkpFKnwUH79AWQ5EGkkGV9y6uJb0z/uE8=;
 b=0CNiZzpjFk+382fATWPaZN9hRVeYktc7IERnY5UwVnp1TSWzjsrVvFsbpzDFeH6w+O
 D7eDlSZpBsQLWS2l5zCywmqBR1qZ8ZTTy2v57k/a4X+TJNK1ymnYa8CH0KbQ/f5DUqsf
 d1fXlcWYveIbi5O5dOOpZrOJlFrmpIr9v9Or5Vy8DE3C3hzUHfhrLN4miXHsSR0YiYRx
 ylkuvl3BRzZWSly/NktTDO2de4loVLLWDqxJrDG7y5IuJJ2ilIQaodj5EnVX0PqAoYpt
 vb2dUEnRojO70QMwCx8XZNtBa/Cn9yPLWhAlbKVG6lpk059iK/+yafVklN9dtPGdPvyR
 Cuvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791930904; x=1792535704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+0G+6ELCFSGkpFKnwUH79AWQ5EGkkGV9y6uJb0z/uE8=;
 b=le5DYUh30diUfx6PX4Sabq8gzKHByNWMiR1udHK64k8rJzURv4WmR4xmZktCu0L0uI
 /fPPhKCo/5hbzPlVcTnh0g692Xx9oqBTvkgSb95di0G+r+qyot14jaKXrBSo0CT1Ewrk
 eEt982pVGNeS9A4ahUPDP7pdixsnB74zU9PsOfm5Jn0EOprb+jczRf1rohaE8fwD+/4t
 zTkWlxv4ae7Ba6j56M1Z77GIomtye2ZQ3aCvxcSdwgagOL9qkZ+YP1uEJPDBRUIqun3M
 lRKE50eZWPln7/fs24Fqa3DOWzqOuus/xK9BCnC75seodzO3pho4gAvJwx6JawqNh2AA
 CMpA==
X-Gm-Message-State: AFq9FYLcqAWnT9P5F5QdiodKj3bLgSjjnwvGs2iwOnpOQklBflDUy8aM
 kntDU4doA4H9l24cJSEuR62QI0UQ2bSZWUk5JR8wyfrc4J7vpx+z2A+KIVoAj0VHQu2iSb6nyDi
 4U3jFrbc=
X-Gm-Gg: AYBFou3A0ZAjq8WOLOrLOcPeipv14HnZ8rqzpyBVPK9DXCWt6pFcZD6S52XDS167xfE
 KVIVvfhLwMwtB25/DyPFZArM4hybha6qACNsqAUSONFQqWqIcQWpQoRHbCij1VLRCji2xp0J5pQ
 RTMZFeJ7X28qVp3z/Cfw4yDDro9QPS4Lad+EPbu3bD9hQM4Ai36Mj4uiMtIqwX/gwKcnS3jFqeR
 ro++NJ/hYMh/xqWQKEU7Zhnu+AnqrRPdAchnOtDC2HJ2KN6v9OhbvKiWcTag5ig8A9IjMjzzFyp
 qEsBWAOJm+G+vnohovsM7U6Xw/ZLM5eW+Fk1htYMeodkZ/7nUtw/MNgeM4H3Ha6QjTSU7GiYYex
 0wIe5WzrA3KnFQSxNI+4wTU0U99ahAb5zJRAUUds3jUrmOvSmbLEoRbzNFmSnJfVQxrufXikb3q
 mpWDjLt7TYOAnB4vz78Pd0Bydj7qIek37If1GYD7Hm2wLeOsx6gu7HtqcVwxrlb3z/cQysCCD62
 yL2nUImZ32sjRfCAjlqYr+pPKPjYZiR7qK/fQ==
X-Received: by 2002:a17:90b:380c:b0:3a4:f7ae:a63 with SMTP id
 98e67ed59e1d1-3ab36f4cdeamr12356748a91.56.1791930904202; 
 Tue, 13 Oct 2026 15:35:04 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8421b19a2sm61865145ad.46.2026.10.13.15.35.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 15:35:03 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>, Maciej Czekaj <mczekaj@marvell.com>
Subject: [PATCH v4 10/29] net/thunderx: replace deprecated SMP barriers
Date: Tue, 13 Oct 2026 15:22:23 -0700
Message-ID: <20261013222410.2257622-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013222410.2257622-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261013222410.2257622-1-stephen@networkplumber.org>
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

Redefine the nicvf barrier wrappers as C11 fences and add an IO
variant. The RBDR refill barrier orders descriptor writes in DMA
memory against the doorbell register write, which is device
ordering: use the IO barrier there.

The mailbox flag barriers are inter thread ordering and become
release/acquire fences, matching what the old barriers did. Note the
flags they order (pf_acked, pf_nacked) are plain bitfields sharing a
byte with other fields, so a fence alone is not sufficient for them
under C11; making them atomic is a pre-existing issue left for a
separate patch.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/thunderx/base/nicvf_hw.c   | 3 ++-
 drivers/net/thunderx/base/nicvf_plat.h | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/thunderx/base/nicvf_hw.c b/drivers/net/thunderx/base/nicvf_hw.c
index 5b1abe2015..d1e31ffdaa 100644
--- a/drivers/net/thunderx/base/nicvf_hw.c
+++ b/drivers/net/thunderx/base/nicvf_hw.c
@@ -499,7 +499,8 @@ nicvf_qset_rbdr_precharge(void *dev, struct nicvf *nic,
 			break;
 		}
 	}
-	nicvf_smp_wmb();
+	/* Descriptors must be visible to the device before the doorbell */
+	nicvf_io_wmb();
 	nicvf_queue_reg_write(nic, NIC_QSET_RBDR_0_1_DOOR, ridx, count);
 	rbdr->tail = nicvf_queue_reg_read(nic,
 				NIC_QSET_RBDR_0_1_TAIL, ridx) >> 3;
diff --git a/drivers/net/thunderx/base/nicvf_plat.h b/drivers/net/thunderx/base/nicvf_plat.h
index 8421f57040..08ebb0cf62 100644
--- a/drivers/net/thunderx/base/nicvf_plat.h
+++ b/drivers/net/thunderx/base/nicvf_plat.h
@@ -25,8 +25,9 @@
 
 /* barrier */
 #include <rte_atomic.h>
-#define nicvf_smp_wmb() rte_smp_wmb()
-#define nicvf_smp_rmb() rte_smp_rmb()
+#define nicvf_smp_wmb() rte_atomic_thread_fence(rte_memory_order_release)
+#define nicvf_smp_rmb() rte_atomic_thread_fence(rte_memory_order_acquire)
+#define nicvf_io_wmb() rte_io_wmb()
 
 /* utils */
 #include <rte_common.h>
-- 
2.53.0

