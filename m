Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB29EF9D0ED
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 18:51:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03E244060B;
	Tue, 14 Apr 2026 20:51:45 +0200 (CEST)
Received: from mail-ua1-f98.google.com (mail-ua1-f98.google.com
 [209.85.222.98]) by mails.dpdk.org (Postfix) with ESMTP id DDCB4402ED
 for <dev@dpdk.org>; Tue, 14 Apr 2026 20:51:43 +0200 (CEST)
Received: by mail-ua1-f98.google.com with SMTP id
 a1e0cc1a2514c-94dd01deb53so1397429241.0
 for <dev@dpdk.org>; Tue, 14 Apr 2026 11:51:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776192703; x=1776797503;
 h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
 :references:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7aKZ3wybNkmwilY5d7u64Li+0DgO0pNo295MDNlTkPo=;
 b=R15S/zQEZFq22Pz9nV8us3QurMo5xWiMvmyUV1356j/81rRRwvUdCK+lE8e6h8tqRi
 CWPnDSdSpYX9g0fYFOXDFzMplsnGzHaJ33rBij+I3KrLRjggrZCwgX4RnKNov+6qIgsv
 HzmQLhbSYgnB+hzATXM4Q879ufl8TnobluCrnxV+L3+stV4lPBLl7VSRTbE/OhlTS8XE
 1tokNznGp1Hrapj75qjbmqQormi0+JpIX31aG8KhdLb21ln7KsJabR5ee467JLw6o+gu
 CAIKDkz+fb/YKaD8qEcxXHOp4StcE9N6MQEoLAYLCyBbC2aI1V1MncfitxrLt35s6k5r
 j99g==
X-Forwarded-Encrypted: i=2;
 AFNElJ8xz2twVOqsT5BQNKHCRZe3vmqoK+ur5ANjRk64KXjbdNUPnkeSa49ejK4SlA4G50k8waI=@dpdk.org
X-Gm-Message-State: AOJu0Yx0EFlXYxr9z6dxeglt01dwjFuAwpiqtlvHXvb5Mfc3CcTYs2vj
 64JltJmMcUZK8oP5sOvf+9u33umZNw7NzRVTGmGrLLtsWHQJEwKfaSy6+xMOYA2/Vn5AD/i/12l
 vXLjIMUp7u2KWyZyxsfJ+SxtPaK/rb6fNR2QdBO80sP1b661UFw6IeDsaiuQz6+Gj7H2cQmAF9V
 2kAlkDChown1XqxKEbaqoNce30BFooUR/Jyr77be/YwtyNaOLnVNkStPArn6O3H4ThxQ/dMhGty
 Ie3wA==
X-Gm-Gg: AeBDievM9QZx8OjQMtChI/UtCGiI/El0NLf7Kf4Hb2KRSSfHNmaPYg95rjq26r+mznt
 OL+H3K2GLgmU09p6LOtvTBRxiBAxAzrFCnf+FS+vJZP8jdJN6C+w7Yf4N1kloKeWoDUgDaXO2SD
 cFJah+tsl86cUxuyFUv0mykOsPERiL0OiY3v5gciRsyEdRraONckWl6Gu8zvzuTmqO+ztqc4s4h
 eks63olk6wxoJSZqjNEQs9wWXl48vluzBQtGe6KbIALOwx9Bi0f5QbT2whae+8aDQRZ57nkkEO9
 +WukSHdW7gJnEiZ369KFkCjJtuL3r53Abv8RNAyH0TK88ubAg7LeTbih3J2l1NDr9mkfYALatMV
 InJTtTRbtPZAPcx8lOVgOPVxSx+pTKstjeST/YNADyrZhPQ6eu/yAJbFVJsSnMkKfLEdTW28no7
 em5Yn0mQO+2q0DvK6Z/bQiLXe4gPG4POKEy0nQg+/tUC38z+tOUW/r3zkLsVkhr8zp
X-Received: by 2002:a05:6102:5108:b0:602:71a7:63be with SMTP id
 ada2fe7eead31-60a00b36d7bmr8004747137.16.1776192702945; 
 Tue, 14 Apr 2026 11:51:42 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
 by smtp-relay.gmail.com with ESMTPS id
 ada2fe7eead31-610b65933c5sm302189137.27.2026.04.14.11.51.41
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 14 Apr 2026 11:51:42 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b97ed96ef12so431065166b.3
 for <dev@dpdk.org>; Tue, 14 Apr 2026 11:51:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776192700; cv=none;
 d=google.com; s=arc-20240605;
 b=LnPoiVL/gYDJbvrEewihZHSrdOBvHERiMC3MoTmN5KjgATqHkxn4xFBETmfMnYixIv
 4GNGPCThnYwvP5tJoG1ioAdE4hCaFsOsXYsEUcZLYUcIFYgU7jprLHJoDSropqx9ohYc
 V2IerCgBaD9tVblGZH+CdND+YU7Z5tPw/m41tLELa9d0nLKVrKGZABYMI8b++jM91cZV
 ZTSAIwLYTTnsQZ5MaEUzx8+HKESVc6J7YlhSxtKWgcpHSAk3kfP25Xd6h31Zf2GHRW9k
 y3QIjKv2fCgUOZwaUBQk/ANdxtOGjoYeYtyqZdiYwkOzj56yqjpjnJS0v5EHdA4pQbgn
 Tx6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
 :references:from:dkim-signature;
 bh=7aKZ3wybNkmwilY5d7u64Li+0DgO0pNo295MDNlTkPo=;
 fh=Y79yTqy72+DRXClElHEfHGieLM3HFSgB66PvMPRy/tI=;
 b=T39RCLPbCGGahlgmdFcFpQlTq3X0uMrSMMtx5UaQgplyYzvUeZJGqFSLNzOLS7PHPa
 HLfb8mR2qfeevqdK4HRS6+j6uv6gLlLyT9krLbvSmJIxZD+9z2E54vV39KdokkKSiYvt
 rE9h2GbauBZP0/CBqhJeLs7FDMWcL1ej6AOfpllLihQt/iyoo0mxcp5KdH16TbaKvntI
 uGCxRyK+9lB7UmXrw1p9gOO7JERtWo4+hWXy5UimGpY141EAtbgEqy91KOa+4Sz8j70i
 VsgKfdtKEN0xg167ZvmLWSr3I7Hbvwpdo6VcbdCnHYVw/BM1g5pIFHrMPfrzW+4400N+
 6rzg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1776192700; x=1776797500; darn=dpdk.org;
 h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
 :references:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7aKZ3wybNkmwilY5d7u64Li+0DgO0pNo295MDNlTkPo=;
 b=EvguvGe1FUnDcW8rm3aed6VLeuJBOp7vxKwIvX0bjXq9TPKk8FaHuKkxntFDLUV672
 KG6IQv0i5GhJOorM961L/b/2hfLNj1NiKuMWMZmGiPpLhFXh9o2qMZXZsVxnMe0vwQNb
 Zo9blcO+ktor44UotutRxaOvoLBWWyAe5X4tQ=
X-Forwarded-Encrypted: i=1;
 AFNElJ/11BO/zB/qUCqEoSSEPZR30QOFx81aZsbj3lP0VaD0/VJXuUaIDNIq+5BG5zJf7sh6SDg=@dpdk.org
X-Received: by 2002:a17:906:209a:b0:b9d:9608:a4b4 with SMTP id
 a640c23a62f3a-b9d9608a734mr567811066b.12.1776192699684; 
 Tue, 14 Apr 2026 11:51:39 -0700 (PDT)
X-Received: by 2002:a17:906:209a:b0:b9d:9608:a4b4 with SMTP id
 a640c23a62f3a-b9d9608a734mr567809566b.12.1776192699148; Tue, 14 Apr 2026
 11:51:39 -0700 (PDT)
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
References: <20260413171836.123467-1-stephen@networkplumber.org>
 <20260413171836.123467-6-stephen@networkplumber.org>
In-Reply-To: <20260413171836.123467-6-stephen@networkplumber.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQK8hl1zwnNkhPx/FTeSTzT43qym7AHaqsA/tBCKDvA=
Date: Tue, 14 Apr 2026 14:51:35 -0400
X-Gm-Features: AQROBzCBn-W_BpTBo7Q8tjImWjTzK1VbKkp_cLTep1pnM6dQwxREDZ9Qmyj0PGA
Message-ID: <9032195738d97412900bf442539cbd85@mail.gmail.com>
Subject: RE: [PATCH 5/6] net/bnxt: fix mutexes for multi-process
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: stable@dpdk.org, 
 Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000f27a4d064f7016ac"
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

--000000000000f27a4d064f7016ac
Content-Type: text/plain; charset="UTF-8"

-----Original Message-----
From: Stephen Hemminger <stephen@networkplumber.org>
Sent: Monday, April 13, 2026 1:15 PM
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>; stable@dpdk.org;
Kishore Padmanabha <kishore.padmanabha@broadcom.com>; Ajit Khaparde
<ajit.khaparde@broadcom.com>; Venkat Duvvuru
<venkatkumar.duvvuru@broadcom.com>; Kalesh AP
<kalesh-anakkur.purayil@broadcom.com>; Somnath Kotur
<somnath.kotur@broadcom.com>
Subject: [PATCH 5/6] net/bnxt: fix mutexes for multi-process

The BNXT driver supports secondary processes, as shown by the explicit
check in bnxt_dev_init(). Multiple mutexes are located in structures
allocated in shared memory (dev_private and rte_zmalloc'd structures) that
are accessible by both primary and secondary processes.

However, the mutexes are initialized without PTHREAD_PROCESS_SHARED
attribute, which means synchronization between processes is undefined
behavior.

POSIX mutexes are by default private to the process creating them.
When a mutex protects data structures in shared memory that are accessed
by multiple processes, pthread_mutexattr_setpshared() must be called with
PTHREAD_PROCESS_SHARED.

This patch adds a helper function and updates all mutex initializations in
the BNXT driver:
  - flow_lock, def_cp_lock, health_check_lock, err_recovery_lock
    in struct bnxt (bnxt_ethdev.c)
  - vfr_start_lock in rep_info (bnxt_ethdev.c)
  - txq_lock in struct bnxt_tx_queue (bnxt_txq.c)
  - bnxt_ulp_mutex in session state (bnxt_ulp.c)
  - flow_db_lock in cfg_data (bnxt_ulp_tf.c, bnxt_ulp_tfc.c)

Bugzilla ID: 662
Fixes: 1cb3d39a48f7 ("net/bnxt: synchronize between flow related
functions")
Fixes: 5526c8025d4d ("net/bnxt: fix race between interrupt handler and dev
config")
Fixes: b59e4be2b6a7 ("net/bnxt: fix VF representor port add")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by:  Kishore Padmanabha <kishore.padmanabha@broadcom.com>
---
 drivers/net/bnxt/bnxt_ethdev.c         | 11 ++++++-----
 drivers/net/bnxt/bnxt_txq.c            |  3 ++-
 drivers/net/bnxt/bnxt_util.c           | 13 +++++++++++++
 drivers/net/bnxt/bnxt_util.h           |  2 ++
 drivers/net/bnxt/tf_ulp/bnxt_ulp.c     |  2 +-
 drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c  |  2 +-
drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c |  2 +-
 7 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_ethdev.c
b/drivers/net/bnxt/bnxt_ethdev.c index b677f9491d..3f55ad041d 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -5899,10 +5899,10 @@ static int bnxt_get_config(struct bnxt *bp)
static int  bnxt_init_locks(struct bnxt *bp)  {
-	pthread_mutex_init(&bp->flow_lock, NULL);
-	pthread_mutex_init(&bp->def_cp_lock, NULL);
-	pthread_mutex_init(&bp->health_check_lock, NULL);
-	pthread_mutex_init(&bp->err_recovery_lock, NULL);
+	bnxt_init_mutex(&bp->flow_lock);
+	bnxt_init_mutex(&bp->def_cp_lock);
+	bnxt_init_mutex(&bp->health_check_lock);
+	bnxt_init_mutex(&bp->err_recovery_lock);

 	return 0;
 }
@@ -6920,7 +6920,8 @@ static int bnxt_init_rep_info(struct bnxt *bp)
 	for (i = 0; i < BNXT_MAX_CFA_CODE; i++)
 		bp->cfa_code_map[i] = BNXT_VF_IDX_INVALID;

-	return pthread_mutex_init(&bp->rep_info->vfr_start_lock, NULL);
+	bnxt_init_mutex(&bp->rep_info->vfr_start_lock);
+	return 0;
 }

 static int bnxt_rep_port_probe(struct rte_pci_device *pci_dev, diff --git
a/drivers/net/bnxt/bnxt_txq.c b/drivers/net/bnxt/bnxt_txq.c index
7752f06eb7..8c834acb1d 100644
--- a/drivers/net/bnxt/bnxt_txq.c
+++ b/drivers/net/bnxt/bnxt_txq.c
@@ -204,7 +204,8 @@ int bnxt_tx_queue_setup_op(struct rte_eth_dev
*eth_dev,
 		goto err;
 	}

-	return pthread_mutex_init(&txq->txq_lock, NULL);
+	bnxt_init_mutex(&txq->txq_lock);
+	return 0;
 err:
 	bnxt_tx_queue_release_op(eth_dev, queue_idx);
 	return rc;
diff --git a/drivers/net/bnxt/bnxt_util.c b/drivers/net/bnxt/bnxt_util.c
index aa184496c2..c3f0a03f25 100644
--- a/drivers/net/bnxt/bnxt_util.c
+++ b/drivers/net/bnxt/bnxt_util.c
@@ -3,6 +3,7 @@
  * All rights reserved.
  */

+#include <pthread.h>
 #include <inttypes.h>
 #include <rte_ether.h>

@@ -37,3 +38,15 @@ uint8_t hweight32(uint32_t word32)
 	res = res + (res >> 8);
 	return (res + (res >> 16)) & 0x000000FF;  }
+
+/* Initialize mutex so that it can be shared between processes */ void
+bnxt_init_mutex(pthread_mutex_t *mutex) {
+	pthread_mutexattr_t attr;
+
+	pthread_mutexattr_init(&attr);
+	pthread_mutexattr_setpshared(&attr, PTHREAD_PROCESS_SHARED);
+	pthread_mutex_init(mutex, &attr);
+	pthread_mutexattr_destroy(&attr);
+}
diff --git a/drivers/net/bnxt/bnxt_util.h b/drivers/net/bnxt/bnxt_util.h
index 416a6a2609..e1b45d1bb5 100644
--- a/drivers/net/bnxt/bnxt_util.h
+++ b/drivers/net/bnxt/bnxt_util.h
@@ -16,4 +16,6 @@
 int bnxt_check_zero_bytes(const uint8_t *bytes, int len);  void
bnxt_eth_hw_addr_random(uint8_t *mac_addr);  uint8_t hweight32(uint32_t
word32);
+void bnxt_init_mutex(pthread_mutex_t *mutex);
+
 #endif /* _BNXT_UTIL_H_ */
diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp.c
b/drivers/net/bnxt/tf_ulp/bnxt_ulp.c
index 0c03ae7a83..c2c93859ff 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp.c
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp.c
@@ -214,7 +214,7 @@ ulp_session_init(struct bnxt *bp,
 			session->pci_info.domain = pci_addr->domain;
 			session->pci_info.bus = pci_addr->bus;
 			memcpy(session->dsn, bp->dsn,
sizeof(session->dsn));
-			pthread_mutex_init(&session->bnxt_ulp_mutex,
NULL);
+			bnxt_init_mutex(&session->bnxt_ulp_mutex);
 			STAILQ_INSERT_TAIL(&bnxt_ulp_session_list,
 					   session, next);
 		}
diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c
b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c
index bc347de202..d87120aea3 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c
@@ -1469,7 +1469,7 @@ ulp_tf_init(struct bnxt *bp,
 		goto jump_to_error;
 	}

-	pthread_mutex_init(&bp->ulp_ctx->cfg_data->flow_db_lock, NULL);
+	bnxt_init_mutex(&bp->ulp_ctx->cfg_data->flow_db_lock);

 	/* Initialize ulp dparms with values devargs passed */
 	rc = ulp_tf_dparms_init(bp, bp->ulp_ctx); diff --git
a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
index ad44ec93ca..0c3d1f7dae 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
@@ -1038,7 +1038,7 @@ ulp_tfc_init(struct bnxt *bp,
 		goto jump_to_error;
 	}

-	pthread_mutex_init(&bp->ulp_ctx->cfg_data->flow_db_lock, NULL);
+	bnxt_init_mutex(&bp->ulp_ctx->cfg_data->flow_db_lock);

 	rc = ulp_tfc_dparms_init(bp, bp->ulp_ctx, ulp_dev_id);
 	if (rc) {
--
2.53.0

--000000000000f27a4d064f7016ac
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGpzCCBI+g
AwIBAgIMTxuM8PbwRQIs9uJeMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNTIxOFoXDTI3MDYyMTEzNTIxOFowgekxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzETMBEGA1UEBBMKUGFkbWFuYWJoYTEQMA4GA1UEKhMHS2lzaG9yZTEWMBQGA1UEChMNQlJP
QURDT00gSU5DLjEoMCYGA1UEAwwfa2lzaG9yZS5wYWRtYW5hYmhhQGJyb2FkY29tLmNvbTEuMCwG
CSqGSIb3DQEJARYfa2lzaG9yZS5wYWRtYW5hYmhhQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBALtFWP+ax39qiJZsJuukdoqMyp0GWGaJ6MdaHvAxXWiEY5zmTiVU
QnpmNYp5SO1Cd1cBqDB0dcelQbiQ1qh+lnlUchJLR63y0ysUvUNvqV493q8+pHCm/2jPb0/R9rec
/jxwM9jaPAVkhGBwvudSfOAQlMPORtAHZyLHKFINcsNfLrGP/3lx+zj30v5tmDN7isOLWos7Jm/U
qRdC7UuUiXgX7q8xXd1MQlA95O73IY/Qb/y0ChEjGPb+U1wr+OsAWJ5fcjQXA/ffBb2GmMp9OUOs
wVNq8iHfie9nzNaaRw+yoyn0ovoiq2W3Q6r+U53ha/lz0itqCrJZN+G0MFf+cX8CAwEAAaOCAeMw
ggHfMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggr
BgEFBQcwAoY6aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1l
Y2EyMDIzLmNydDA5BggrBgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2Ny
NnNtaW1lY2EyMDIzMGUGA1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGg
MgoDAjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5
LzBBBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWlt
ZWNhMjAyMy5jcmwwKgYDVR0RBCMwIYEfa2lzaG9yZS5wYWRtYW5hYmhhQGJyb2FkY29tLmNvbTAT
BgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNV
HQ4EFgQURIyot+ZP/mdwQsofZexqAvOm5pMwDQYJKoZIhvcNAQELBQADggIBAKc5gYnhyTf+f6cm
kAHy1a4cLIWou43yaS+M/r69Pv44EVYvHxqt0mMvKh3U40Y+pHKph+VCjdoINKCd1SaqAFIqqEO4
XHWrFi3QAI3snUB6spPIoHN/srAcpX9tdrnAlyK593pq+H+mTMoFIGBP/oc8XCtaDgHp37rpuK9Q
qhF9h5cEJWgShmD7/Q02YydW3jsioy8HdTUD9fib1fRwiSc9uGq8JV5NJsYiJsi9FUz7kTUPohO0
h6U9tRUVmAf9gPbU46rin9By5X4Lt1jKge5O0vFEawCTr/pLmDcIf7CqRZfBoNalKOsBDovoeAOf
pXmQzQEMhnaf93MvbFvZaxC9Ir92DR45BH42xZuLKcQVUsqyLKwC6kEZg81AnZsRAUVpMvqiGbVb
hZnabsHragNY7Br3VCA2OaWk9yRRjt1UwzfIEEMNWqZeQzzAqKIR3XdXIrqAUlMQOX42tSV9FaIv
PSmR3uaH2M0/bRtz4TE1qRuTsLlr+XEGMxHssK7u7+WYM7EGF3ueZLcE7WmnwXEFli5Y5QX0SnmT
W8uDQvdvRdxXg4lkBLyifOudYTP3fULjpD6RWQPFlUPlh8F5QQEdKlfKW94rGD+O0u4sWi/msZw0
6VTvZ6C2BbUMJAo7coFff48NkW2xfICC8Kn1eU1eiWCrPSAls8STm9q25wOQMYICVzCCAlMCAQEw
YjBSMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xv
YmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0EgMjAyMwIMTxuM8PbwRQIs9uJeMA0GCWCGSAFlAwQCAQUA
oIHHMC8GCSqGSIb3DQEJBDEiBCDBnvh0L9c59KZLR8DQgMJIP/2I2VjPL13dxSVzECoY9TAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA0MTQxODUxNDBaMFwGCSqG
SIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZI
hvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCBVex82gmL
xXEjL84HLNBXYppmtaAKTMLbSHMwUuQp8BZybBhk19SYG0v5gNYO8RG3iybx025a2Qw0SqyV86eM
TXxC7pN8joTlpsIjqq3hubw6TGV+sqjnpdJ8zMPUTAqnC7flKqaJAAjAqwF2yYltqWx58FlqWQMe
CMR8O71h+tkZQZT4FbjSw/C89NKcM1GSiiQBc+WYESJ4WAvxcVClQvUWAOovmkCG6hUOZsLRAOmt
9+YPQ7ubmqeCJOTBs0SgXu4S3QR5D9Z/XQDnml2veZScILEUc9+1CT+D/q5dbdmLuCTLCsYqgs5o
+stMIKc1PAVZ7otnwrb3mN+TVBue
--000000000000f27a4d064f7016ac--
