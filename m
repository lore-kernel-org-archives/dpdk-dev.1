Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3E3C5B572
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Aug 2026 19:24:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91AEB4028E;
	Mon, 17 Aug 2026 21:24:21 +0200 (CEST)
Received: from alln-iport-6.cisco.com (alln-iport-6.cisco.com [173.37.142.93])
 by mails.dpdk.org (Postfix) with ESMTP id 4AB9A40275
 for <dev@dpdk.org>; Mon, 17 Aug 2026 21:24:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=1416; q=dns/txt;
 s=iport01; t=1786994659; x=1788204259;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sqguxI71I4WMYQAgafTo3ZZltmgYmyv+f2Gg94g6NEY=;
 b=e50eQ69AqJGBNaKe4BURdCquwPio0Yys1R1BK98eTALo4sbz8xibfu9I
 FPAhEajMMXqe1GIskvwHZsnI2lcuHbTakpLqhIlKWJlGl2qB14xmNpg9l
 s0HWT4tLcpj5DdcXpe9MpzORbmwaLqT5w2JIrXqL4+H6swvWzXoNNJiv8
 zskUcOk1kHgyKjXwrISonQ/OU96HUxyjbogHwDQfHAVMOOD0gbc3Rm7Aa
 kgqXb1m3mL7+g5QnNeBcccS6ZgcLzFFNrdi0Bazti5pmCB+gz0v1S0F1i
 sK0EIJ1GpGf2X2/dIHIr2akF+gAbbEg/Dm4nQL8YDW3iSbdn5ocWhPKib w==;
X-CSE-ConnectionGUID: qgRzPcdjQ/+SphhXeCvCdA==
X-CSE-MsgGUID: /GCEtmG0SKGE+9p3+57YZw==
X-IPAS-Result: =?us-ascii?q?A0BAAgA7X4Nq/44QJK1aHgEBCxIMggULgleBUkNJlkqeH?=
 =?us-ascii?q?oF+DwEBAQ9RBAEBhQUCjWkCJjQJDgECBAMCAwEBAQEBAQEBAQEBCwEBBQEBA?=
 =?us-ascii?q?QIBBwWBDhOGXIZbAgEDMgFGEFFWGYMCgnUDxhWCLIEBhH3ZSoFmAQsUAYE4j?=
 =?us-ascii?q?WF2hHwnG4FJRIEVg2mEGnaFeASCIoEMkxtIgR4DWSwBVRMNCgsHBYFmAzUSK?=
 =?us-ascii?q?hVuMh2BIz4XgQ0bBgWBHYEohDcjGTZ6gQlegSsqYQESF4EJggoCgnOCBgIBS?=
 =?us-ascii?q?SELGA1IESw3FBkEPm4HjiAggkgObRNBCy9JUCvHHoQooVsaM6psmQiCAaF8X?=
 =?us-ascii?q?YRpgWg8gVkzGggbFYMiUxkPji0W0BUrMj8HAgcPApFzgX4BAQ?=
IronPort-Data: A9a23:pVoxg6A53ZhK8RVW/5jhw5YqxClBgxIJ4kV8jS/XYbTApDkg0TxRx
 2tNXG3Sbv/cajamc4t1Otnl8EwEupXVxocwOVdlrnsFo1CmBibm6XV1Cm+qYkt+++WaFBoPA
 /02M4eGdIZvCCeA+n9BC5C5xVFkz6aEW7HgP+DNPyF1VGdMRTwo4f5Zs7ZRbrVA357jXmthh
 fuo+5eBYA/8hGYuWo4pw/vrRC1H7ayaVAww5jTSVdgT1HfCmn8cCo4oJK3ZBxPQXolOE+emc
 P3Ixbe/83mx109F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzXWX6aSuI0P6n3TE2vpUHnk9MY8hvaVMGWFOx
 fEzNhsBR0XW7w626OrTpuhEj8AnKozveYgYoHwllWyfBvc9SpeFSKLPjTNa9G5v3YYVQ7CHO
 YxANWAHgBfoO3WjPn8NFJM1kc+jh2L0dHtTr1f9Sa8fszCCkF0sgeCyWDbTUpulbuhJm2nAn
 UHp0ieoGkpZaYOu+yXQpxpAgceKx0sXQrk6GLCm3vJyjF7VwXYcYCD6TnOypf2/z0r7UNVFJ
 glMp2wlrLM58wqgSdyVswCEnUNodyU0A7J4e9DWIinTokYIy2513lQ5cwM=
IronPort-HdrOrdr: A9a23:dBObRqzsyQkYgVFz30nwKrPw5r1zdoMgy1knxilNoNJuHvBw8P
 re+MjzuiWbtN98YhsdcJW7Scq9qBDnhPtICOsqXItKNTOO0ACVxcNZnOnfKlbbdBEWmNQx6Y
 5QN4BjFdz9CkV7h87m7AT9L8wt27C8gceVbJ/lr0tFfEVNd7xq6Rt/B0KwF017QxQDOL8Cfa
 DsgPauY1GbCAwqhgPRPAh9Y9T+
X-Talos-CUID: 9a23:d4w0AGAI9kmn5n/6EzBozlwsEcwnSzqe92/QI3+1InhCRJTAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3Azt0AJA3QDreiOm+ELrAKvpdNuzUjpIuFJVwIvs0?=
 =?us-ascii?q?9mOapdn1oYHTA0wWFXdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,229,1779148800"; d="scan'208";a="809495907"
Received: from alln-l-core-05.cisco.com ([173.36.16.142])
 by alln-iport-6.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 17 Aug 2026 19:24:16 +0000
Received: from rtice-VMware20-1 (unknown [10.189.17.96])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: rtice@cisco.com)
 by alln-l-core-05.cisco.com (Postfix) with ESMTPSA id EEB6F18000144;
 Mon, 17 Aug 2026 19:24:15 +0000 (GMT)
From: Randy Tice <rtice@cisco.com>
To: dev@dpdk.org
Cc: Randy Tice <rtice@cisco.com>
Subject: [PATCH v3] eal/linux: harden uevent recv error handling
Date: Mon, 17 Aug 2026 15:23:33 -0400
Message-ID: <20260817192333.119549-1-rtice@cisco.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260813201656.65649-1-rtice@cisco.com>
References: <20260813201656.65649-1-rtice@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: rtice@cisco.com
X-Outbound-Client-TLS: ANONYMOUS; unknown [10.189.17.96]; TLSv1.3;
 TLS_AES_256_GCM_SHA384; 256
X-Outbound-SMTP-Client: 10.189.17.96, [10.189.17.96]
X-Outbound-Node: alln-l-core-05.cisco.com
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

v3:
Fixed build issue with bitwise operator vs test against errno.

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

