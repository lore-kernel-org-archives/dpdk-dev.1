Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFE6C83F34
	for <dpdk-dev@archiver.kernel.org>; Sat, 19 Jul 2025 15:32:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8826E402CE;
	Sat, 19 Jul 2025 17:32:47 +0200 (CEST)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by mails.dpdk.org (Postfix) with ESMTP id 574BD402A6;
 Sat, 19 Jul 2025 17:32:46 +0200 (CEST)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-748d982e92cso2138007b3a.1; 
 Sat, 19 Jul 2025 08:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752939165; x=1753543965; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V9Y1jV2xLw5CskS8dvmEZJNZrpGTSGZYfNhUhEiQoic=;
 b=Pg7MYhuiljs4uzW3N8D62e3FYO3DJWvSSJ+PtE4Ko+vX/CMemBPjZH1uBhKcu9Mgsw
 lTXFq80ABP+QLquF9cZrq83f+PnmeB4g3ogQAmlPTW2H+PviWR2XQ887FfeZdRlvdnR2
 xKvQIvcykhVJQWT7zd6d47kouhGQXkgd4TsFrypscrT8mdm4Mz84u/OrsETCU1L566VJ
 TynbvaIHkm0l2hohX0sg8Kpoh0Q8EJB9cI6paA+Z5MqFZPTLJyjrVMJ1Zyb7oDiyhAom
 s6D42kU0sF+4qXql8ez1rdjiZBpUHPH8TSu6QwOpybe6wNuZhMIAajfvAF++5DVNC89H
 1uUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752939165; x=1753543965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V9Y1jV2xLw5CskS8dvmEZJNZrpGTSGZYfNhUhEiQoic=;
 b=oewd1qoxBKZ86s9bc0d/LQlWFPuZJeGJJnrMJtPxyImpbQ3iOMv7xTunbwW8Zy0Ikf
 ldVurabxXYGgKHmpTVZ3Py06uQl4jXNWI7E5KsbncN+WbRNe6y8O0OGiZMGp4h994Rax
 ZIYRSsOQ72e9Tn1rM5HVa+PCzKtIWSwDkEneNGkrYOpg1EnJT7gpFvXvOhc1LrEZOQCS
 N5Hjh2NQ5MMVTMy5iTCMtLK2uNML9RH6RFhK0FyEJZ8tqZzdEOeuE8Gb+HtNux2TzGKn
 KpJyrcPsdNmaGkR9SOaGBFoWaeSa5IeyIVm/tPnomGVoaafoG+D3fA/gwzXzxbO0QceB
 uTPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkd76t8D+rB49U3KjzIKgw2G9/hMRktZM1Jc9jUyFuTHq6iSxk7x0n0hIVadlSknpAVscjt7U=@dpdk.org
X-Gm-Message-State: AOJu0YzRHsDbPnZVHHNWch4mr88Xu9mhWBYAd1H1iN9uboOUNN97uJyj
 zmdINrSjf9tt5Ftj5fqpM7bm3zBM+p5Bb1MpYYUDff4L+gi6bc1BtJjd6LhVfw==
X-Gm-Gg: ASbGncumewz58wN8Nxl1jye0T++oBrSjUnqrP5hP90v5YzSHxt+LpYdP3vjECPA7mJZ
 /cvaN0dMcEtuNKVphB6L57/Y2RHVCfZYrO4nYHGWGOlU3qJYOmgd0mW/1ZAPetgiXP6Qi6Iw49x
 IYgGTBvK0j/HK2gYgfqFiGKaxJTmBBJm0vHN9ecAKlr399PCMDOtJatSPkulID0CStYSgUcDrED
 ONtj29ZDaflT5fACTMEF0yFHgWpSHGRBOH403vGpCpeszRgdgcOwIDHAFkjTn5bUMtSFq8FYixm
 SCyHyu+IbNeuhS9wYVIkEM6QavvZ3YOMplAQAJQk5kcG6EPEzZC5ubCNe4HKI6+shANsIMaGZZ6
 DX5tMZqvaE2F98C9FzDfrofimkooec84Nj1l+Cy4gSltr97xYIh5w
X-Google-Smtp-Source: AGHT+IH0Spq6tOdlA6yXqzdBokETJ19uQdkmiJvZBKaXv7zZVnJguJDNC/1hRCKq+WZTAdClvp4V5Q==
X-Received: by 2002:a05:6a00:1994:b0:749:122f:5fe5 with SMTP id
 d2e1a72fcca58-756ea7bf7b0mr23348954b3a.18.1752939165113; 
 Sat, 19 Jul 2025 08:32:45 -0700 (PDT)
Received: from localhost.localdomain ([122.235.156.36])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-759c89d06a8sm3038727b3a.45.2025.07.19.08.32.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Jul 2025 08:32:44 -0700 (PDT)
From: Yang Ming <mosesyyoung@gmail.com>
To: dev@dpdk.org
Cc: kai.ji@intel.com,
	stable@dpdk.org
Subject: [PATCH v3 2/2] crypto/ipsec_mb: fix QP release in secondary
Date: Sat, 19 Jul 2025 23:32:26 +0800
Message-ID: <20250719153227.1980-2-mosesyyoung@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20250719153227.1980-1-mosesyyoung@gmail.com>
References: <20250407052532.1913-1-ming.1.yang@nokia-sbell.com>
 <20250719153227.1980-1-mosesyyoung@gmail.com>
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

When a secondary process tries to release a queue pair (QP) that
does not belong to it, error logs occur:
CRYPTODEV: ipsec_mb_ipc_request() line 373: Unable to release
qp_id=0
EAL: Message data is too long
EAL: Fail to handle message: ipsec_mb_mp_msg
EAL: Fail to recv reply for request /tmp/dpdk/l2hi/mp_socket:
ipsec_mb_mp_msg

From the code path, cryptodev->data is allocated in the primary
via rte_cryptodev_data_alloc() (inside
ipsec_mb_create-->rte_cryptodev_pmd_create
-->rte_cryptodev_pmd_allocate-->rte_cryptodev_data_alloc).
This memory is placed in a shared memzone
(rte_cryptodev_data_%u), so both primary and secondary processes
reference the same cryptodev->data, including nb_queue_pairs and
queue_pairs[].

As a result, when the secondary process exits, ipsec_mb_remove()
is called (inside
rte_eal_cleanup-->eal_bus_cleanup-->vdev_cleanup
-->rte_vdev_driver-->ipsec_mb_remove-->ipsec_mb_qp_release
-->ipsec_mb_secondary_qp_op) and it loops through all queue
pairs using:
for (qp_id = 0; qp_id < cryptodev->data->nb_queue_pairs; qp_id++)
     ipsec_mb_qp_release(cryptodev, qp_id);

This causes the secondary to attempt releasing queue pairs it
doesn't own, triggering the error logs mentioned above.

This patch ensures that a secondary process only frees a QP if
it actually owns it, preventing conflicts and resolving the
issue.

Fixes: b35848bc01f6 ("crypto/ipsec_mb: add multi-process IPC request handler")
Cc: kai.ji@intel.com
Cc: stable@dpdk.org

Signed-off-by: Yang Ming <mosesyyoung@gmail.com>
---
 drivers/crypto/ipsec_mb/ipsec_mb_ops.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/ipsec_mb/ipsec_mb_ops.c b/drivers/crypto/ipsec_mb/ipsec_mb_ops.c
index 910efb1a97..50ee140ccd 100644
--- a/drivers/crypto/ipsec_mb/ipsec_mb_ops.c
+++ b/drivers/crypto/ipsec_mb/ipsec_mb_ops.c
@@ -138,6 +138,7 @@ int
 ipsec_mb_qp_release(struct rte_cryptodev *dev, uint16_t qp_id)
 {
 	struct ipsec_mb_qp *qp = dev->data->queue_pairs[qp_id];
+	uint16_t process_id = (uint16_t)getpid();
 
 	if (!qp)
 		return 0;
@@ -152,8 +153,10 @@ ipsec_mb_qp_release(struct rte_cryptodev *dev, uint16_t qp_id)
 		rte_free(qp);
 		dev->data->queue_pairs[qp_id] = NULL;
 	} else { /* secondary process */
-		return ipsec_mb_secondary_qp_op(dev->data->dev_id, qp_id,
-					NULL, 0, RTE_IPSEC_MB_MP_REQ_QP_FREE);
+		if (qp->qp_used_by_pid == process_id)
+			return ipsec_mb_secondary_qp_op(dev->data->dev_id,
+						qp_id, NULL, 0,
+						RTE_IPSEC_MB_MP_REQ_QP_FREE);
 	}
 	return 0;
 }
-- 
2.49.0.windows.1

