Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF00CC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 17:41:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 22C9740A6F;
	Wed, 14 Oct 2026 19:40:49 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 388E040A7D
 for <dev@dpdk.org>; Wed, 14 Oct 2026 19:40:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791999646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QDcGyUsSb4TMUASRa69noNLNV4L0wVeBpraYTcJYy68=;
 b=DJ+4CqrX0mwnQZ6/VicNAfjKKCsCE182GaGrTjE6PcWA72Kl+4wik8OxaIA5jx2hlJCf9u
 YATXSHrchvV3LwZNxvCFcagrMjFyniADyhBtRPRznmlJP3TA1+9V+0kvn9fg/MjjjR8mIV
 rURopH0Cmr+4jLNaEDMn1RpOjQcl9pA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235-HWoSsAvgOoe1jicH4XOAVA-1; Wed,
 14 Oct 2026 17:40:45 +0000
X-MC-Unique: HWoSsAvgOoe1jicH4XOAVA-1
X-Mimecast-MFC-AGG-ID: HWoSsAvgOoe1jicH4XOAVA_1791999644
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6FAE31955DB0; Wed, 14 Oct 2026 17:40:44 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7552D195608E; Wed, 14 Oct 2026 17:40:43 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: hemant.agrawal@nxp.com,
	dev@dpdk.org
Cc: Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH 11/16] bus/fslmc: release resources on probe failure
Date: Wed, 14 Oct 2026 19:39:54 +0200
Message-ID: <20261014174001.1830726-12-david.marchand@redhat.com>
In-Reply-To: <20261014174001.1830726-1-david.marchand@redhat.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
 <20261014174001.1830726-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: C0Ygc2l76aap79ADZZV5meAGwC5ceigH4nqZo4YNvLE_1791999644
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

In case of a single failure, all mapped memory, VFIO resources and
device pointers were left untouched.
When reaching one init failure during probe, unwind what had been done so
far.

Note: the mapping helper was ignoring the memory callback registration
failure, so it is kept as is.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since RFC v2:
- rebased,

---
 drivers/bus/fslmc/fslmc_bus.c  | 10 ++++--
 drivers/bus/fslmc/fslmc_vfio.c | 56 +++++++++++++++++++++++++++++-----
 drivers/bus/fslmc/fslmc_vfio.h |  1 +
 3 files changed, 57 insertions(+), 10 deletions(-)

diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index 0600f1afd5..b3ebf41fd7 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -423,17 +423,23 @@ rte_fslmc_probe(struct rte_bus *bus)
 		if (ret) {
 			DPAA2_BUS_ERR("Unable to DMA map existing VAs: (%d)", ret);
 			DPAA2_BUS_ERR("FSLMC VFIO Mapping failed");
-			return ret;
+			goto vfio_close_group;
 		}
 	}
 
 	ret = fslmc_vfio_process_group();
 	if (ret) {
 		DPAA2_BUS_ERR("Unable to setup devices %d", ret);
-		return ret;
+		goto vfio_dma_unmap;
 	}
 
 	return rte_bus_generic_probe(bus);
+
+vfio_dma_unmap:
+	fslmc_vfio_dmaunmap();
+vfio_close_group:
+	fslmc_vfio_close_group();
+	return ret;
 }
 
 static bool
diff --git a/drivers/bus/fslmc/fslmc_vfio.c b/drivers/bus/fslmc/fslmc_vfio.c
index 10efd98e7b..c0ecf84cc7 100644
--- a/drivers/bus/fslmc/fslmc_vfio.c
+++ b/drivers/bus/fslmc/fslmc_vfio.c
@@ -1168,6 +1168,27 @@ fslmc_dmamap_seg(const struct rte_memseg_list *msl __rte_unused,
 	return ret;
 }
 
+static int
+fslmc_dmaunmap_seg(const struct rte_memseg_list *msl __rte_unused,
+		const struct rte_memseg *ms, void *arg)
+{
+	int *n_segs = arg;
+	int ret;
+
+	/* if IOVA address is invalid, skip */
+	if (ms->iova == RTE_BAD_IOVA)
+		return 0;
+
+	ret = fslmc_unmap_dma(ms->addr_64, ms->iova, ms->len);
+	if (ret)
+		DPAA2_BUS_ERR("Unable to VFIO unmap (addr=%p, len=%zu)",
+				ms->addr, ms->len);
+	else
+		(*n_segs)++;
+
+	return ret;
+}
+
 RTE_EXPORT_SYMBOL(rte_fslmc_vfio_mem_dmamap)
 int
 rte_fslmc_vfio_mem_dmamap(uint64_t vaddr, uint64_t iova, uint64_t size)
@@ -1191,10 +1212,8 @@ fslmc_vfio_dmamap(void)
 	rte_mcfg_mem_read_lock();
 
 	ret = rte_memseg_walk(fslmc_dmamap_seg, &i);
-	if (ret) {
-		rte_mcfg_mem_read_unlock();
-		return ret;
-	}
+	if (ret != 0)
+		goto unmap;
 
 	ret = rte_mem_event_callback_register("fslmc_memevent_clb",
 			fslmc_memevent_cb, NULL);
@@ -1207,12 +1226,33 @@ fslmc_vfio_dmamap(void)
 
 	DPAA2_BUS_DEBUG("Total %d segments found.", i);
 
-	/* Existing segments have been mapped and memory callback for hotplug
-	 * has been installed.
-	 */
+	/* Ignore callback handler registration failure */
+	ret = 0;
+
+unmap:
+	if (ret != 0) {
+		i = 0;
+		rte_memseg_walk(fslmc_dmaunmap_seg, &i);
+	}
+
 	rte_mcfg_mem_read_unlock();
 
-	return 0;
+	return ret;
+}
+
+int
+fslmc_vfio_dmaunmap(void)
+{
+	int i = 0, ret;
+
+	rte_mcfg_mem_read_lock();
+
+	rte_mem_event_callback_unregister("fslmc_memevent_clb", NULL);
+	ret = rte_memseg_walk(fslmc_dmaunmap_seg, &i);
+
+	rte_mcfg_mem_read_unlock();
+
+	return ret;
 }
 
 static int
diff --git a/drivers/bus/fslmc/fslmc_vfio.h b/drivers/bus/fslmc/fslmc_vfio.h
index c995fd67b8..57fe7038de 100644
--- a/drivers/bus/fslmc/fslmc_vfio.h
+++ b/drivers/bus/fslmc/fslmc_vfio.h
@@ -60,4 +60,5 @@ int fslmc_vfio_close_group(void);
 char *fslmc_get_container(void);
 int fslmc_get_container_group(const char *group_name, int *gropuid);
 int fslmc_vfio_dmamap(void);
+int fslmc_vfio_dmaunmap(void);
 #endif /* _FSLMC_VFIO_H_ */
-- 
2.54.0

