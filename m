Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE55C5B572
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Aug 2026 18:54:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9EC1640275;
	Mon, 17 Aug 2026 20:54:09 +0200 (CEST)
Received: from alln-iport-2.cisco.com (alln-iport-2.cisco.com [173.37.142.89])
 by mails.dpdk.org (Postfix) with ESMTP id 3CE2940270
 for <dev@dpdk.org>; Mon, 17 Aug 2026 20:54:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=1345; q=dns/txt;
 s=iport01; t=1786992848; x=1788202448;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yv5dRPnPMWEqKxkuAT1nFuLYfj8twMbL4nEt2lMwJhs=;
 b=Q/EJRrmFfjJVMRiD+Y3Bw/OENyn77NQ3RlXqwFnYcqCZRFCrp6BgyWfF
 DPAyKhnJ5bR1FBDDlSqZupa/4xpY9xTLgbQ013Uu6fBYTO+5Ny1TgIHvN
 zT0oLGMi3thbuIlf7z5GhFkqXmaZHSQS7h4mdqVqkjcGEncAlzbEtyl4g
 V9UDXLqx8ABnxmIlE7Eh4TM6QDwk+EOhH22+OdHzaW4OeGv7y35DyXmil
 z3AI06YSQeLKLW8HRXkE9evDUe5mle1NuDpTPt4vXtKAGPFNrl52C6dzv
 2yVtOB8fGM7YgYSQCXBliEVUqcBUxFdGWEDdhShJ+zL+txEAKgEc7zZVK g==;
X-CSE-ConnectionGUID: +2RWltMzS6yIZZHVtDcQLw==
X-CSE-MsgGUID: SqOwM2h/QeiGgLohfMLG0w==
X-IPAS-Result: =?us-ascii?q?A0BAAgAXWINq/48QJK1aHgEBCxIMggULgleBUkNJlkqeH?=
 =?us-ascii?q?oF+DwEBAQ9RBAEBhQUCjWkCJjQJDgECBAMCAwEBAQEBAQEBAQEBCwEBBQEBA?=
 =?us-ascii?q?QIBBwWBDhOGXIZbAgEDMgFGEFFWGYMCgnUDxguCLIEBhH3ZSoFmAQsUAYE4j?=
 =?us-ascii?q?WF2hHwnG4FJRIEVg2mEGnaFeASCIoEMkxtIgR4DWSwBVRMNCgsHBYFmAzUSK?=
 =?us-ascii?q?hVuMh2BIz4XgQ0bBgWBHYEohDcjGTZ6gQlegSsqYQESF4EJggoCgnOCBgIBS?=
 =?us-ascii?q?SELGA1IESw3FBkEPm4HjiAggkgObRNBCy9JUCvHHoQooVsaM6psmQiCAaF8X?=
 =?us-ascii?q?YRpgWg8gVkzGggbFYMiUxkPji0W0BUrMj8HAgcPApFzgX4BAQ?=
IronPort-Data: A9a23:aqCZ4KptXxkvuJFr4Ryy76hWQg5eBmKpZxIvgKrLsJaIsI4StFCzt
 garIBnXb/uIazSmL9l2Oo6xpExU7ZXRxoUyHQVo+Hg3FHkXpePIVI+TRqvS04x+DSFioGZPt
 Zh2hgzodZhsJpPkjk7zdOCn9j8kif3gqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvV0
 T/Ji5OZYgLNNwJcaDpOtfrT8Uw35pwehRtB1rAATaET1LPhvyF94KI3fcmZM3b+S49IKe+2L
 86r5K255G7Q4yA2AdqjlLvhGmVSKlIFFVHT4pb+c/HKbilq/kTe4I5iXBYvQRs/ZwGyojxE4
 I4lWapc5useFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpfh660GMa04AWEX0qUtO15K6
 dkKE24cTyKxp9yq7LmCbvY506zPLOGzVG8eknhkyTecCbMtRorOBv2Uo9RZxzw3wMtJGJ4yZ
 eJANmEpN0qGOkMJYwtMYH49tL/Aan3XaSFZo1+9rqss6G+Vxwt0uFToGIqNJYLbFJwLxy50o
 Er95kPmJ0sac+WSyBWK1nWsiMrrsnvkDdd6+LqQs6QCbEeo7mAeFjUaTVe45/6jhSaDt8l3I
 kgQ/G8q6KM17kHuFoe7VByjq3nCtRkZMzZNL9AHBMi24vK8y26k6qIsF1attPROWBcKeAEX
IronPort-HdrOrdr: A9a23:hpyqfqGaEWAVI2CSpLqEIseALOsnbusQ8zAXPo5KJSC9Ffbo8/
 xG88506faZslwssTQb6LO90cq7MBbhHPxOgLX5VI3KNGLbUSmTXeNfBODZrAEIdReSysdtkY
 99bqlzD8DxB1Bmgcu/3BO1CL8bsb66GdiT5dv2/jNKURxgbb1m4kNSDwaWFVAzeSx9bKBJcq
 Z1IqF81kKdkbN9VLXDOkU4
X-Talos-CUID: 9a23:kDCulG69uKkekTy4q9sstxQuJcQ5V2/mkmbxEX2YN3pFQ4SxVgrF
X-Talos-MUID: =?us-ascii?q?9a23=3AeAM84Q2XyPEO64FUnwh8TPvppDUj2L2JF2VXkdI?=
 =?us-ascii?q?/tsirOgh3Ozm4qBvvXdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,229,1779148800"; d="scan'208";a="807699161"
Received: from alln-l-core-06.cisco.com ([173.36.16.143])
 by alln-iport-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 17 Aug 2026 18:54:07 +0000
Received: from rtice-VMware20-1 (unknown [10.189.17.96])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: rtice@cisco.com)
 by alln-l-core-06.cisco.com (Postfix) with ESMTPSA id 95F3B180000B4;
 Mon, 17 Aug 2026 18:54:06 +0000 (GMT)
From: Randy Tice <rtice@cisco.com>
To: dev@dpdk.org
Cc: Randy Tice <rtice@cisco.com>
Subject: [PATCH v2] eal/linux: harden uevent recv error handling
Date: Mon, 17 Aug 2026 14:53:21 -0400
Message-ID: <20260817185321.118447-1-rtice@cisco.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260813201656.65649-1-rtice@cisco.com>
References: <20260813201656.65649-1-rtice@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: rtice@cisco.com
X-Outbound-Client-TLS: ANONYMOUS; unknown [10.189.17.96]; TLSv1.3;
 TLS_AES_256_GCM_SHA384; 256
X-Outbound-SMTP-Client: 10.189.17.96, [10.189.17.96]
X-Outbound-Node: alln-l-core-06.cisco.com
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

The Linux uevent handler is harded for non-blocking receive behavior
and transient ENOBUF issue during hot plug/unplug testing with MANA.

Signed-off-by: Randy Tice <rtice@cisco.com>
---

v2:
Addressed review comments regarding spelling and missing code comments.
Limited the transient memory issue to just ENOBUF which was the only
original error observed.
---
 lib/eal/linux/eal_dev.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/lib/eal/linux/eal_dev.c b/lib/eal/linux/eal_dev.c
index ec408649d0..f1d2bc3d34 100644
--- a/lib/eal/linux/eal_dev.c
+++ b/lib/eal/linux/eal_dev.c
@@ -241,9 +241,16 @@ dev_uev_handler(__rte_unused void *param)
 
 	ret = recv(rte_intr_fd_get(intr_handle), buf, EAL_UEV_MSG_LEN,
 		   MSG_DONTWAIT);
-	if (ret < 0 && errno == EAGAIN)
+	if (ret < 0 &&
+		(errno == EAGAIN || errno == EWOULDBLOCK || EINTR)) {
+		/* non-blocking or interrupted */
 		return;
-	else if (ret <= 0) {
+	} else if (ret < 0 && (errno == ENOBUFS)) {
+		/* non-fatal transient memory condition */
+		EAL_LOG(ERR, "unexpected error on uevent recv: %s",
+			strerror(errno));
+		return;
+	} else if (ret <= 0) {
 		/* connection is closed or broken, can not up again. */
 		EAL_LOG(ERR, "uevent socket connection is broken.");
 		rte_eal_alarm_set(1, dev_delayed_unregister, NULL);
-- 
2.51.0

