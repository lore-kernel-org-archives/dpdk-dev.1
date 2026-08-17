Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECC3C5DF66
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Aug 2026 20:16:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20A224028E;
	Mon, 17 Aug 2026 22:16:39 +0200 (CEST)
Received: from alln-iport-8.cisco.com (alln-iport-8.cisco.com [173.37.142.95])
 by mails.dpdk.org (Postfix) with ESMTP id 222C340275
 for <dev@dpdk.org>; Mon, 17 Aug 2026 22:16:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=1455; q=dns/txt;
 s=iport01; t=1786997797; x=1788207397;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hYylfOfnmjMTlzLiC89XndVMsIDj2u+KhfZ32ZPWdNc=;
 b=fCdJSUeG4GPWl3kA9cZ0PwZJ4ODfjcyBNJA4KpLxRAwSuHYlXGhlZTlh
 91OIGZq9uPkK6m3RrlyKhDv9stncegzfOEHfTxyqFRKAv3vnS7ZFFIUTt
 fwp6lrxGGcik7WfcwRInlo/a/WHxUuyCM7WEQJ9EszvstowyvLSPQAoBc
 cuB4byYk2LyBhxr4LY9GSmplEOYAiVB2puCCul9UCxZr37MtdMRrSCnJO
 fAbmW1A9g+lphogbrHdm8yCj2tpMEQ5pEVIR2pdfaWXx9kNJujDIOHHkp
 imE0omc1fQW2zeeZj53Z/rJJS6a4yD1/w2s376sLq4naJZbJf4Tglk81g g==;
X-CSE-ConnectionGUID: 7AxU0XnaTseFKL1ArwcnCw==
X-CSE-MsgGUID: 5mkRZFx5REuma/qC1rHbBw==
X-IPAS-Result: =?us-ascii?q?A0BAAgB+aoNq/4sQJK1aHgEBCxIMggULgleBUkNJlkqeH?=
 =?us-ascii?q?oF+DwEBAQ9RBAEBhQUCjWoCJjQJDgECBAMCAwEBAQEBAQEBAQEBCwEBBQEBA?=
 =?us-ascii?q?QIBBwWBDhOGXIZbAgEDMgFGEFFWGYMCgnUDxUGCLIEBhH3ZSoFmAQsUAYE4j?=
 =?us-ascii?q?WF2hHwnG4FJRIEVg2mEGnaFeASCIoEMkxtIgR4DWSwBVRMNCgsHBYFmAzUSK?=
 =?us-ascii?q?hVuMh2BIz4XgQ0bBgWBHYEohDcjGTZ6gQlegSsqYQESF4EJggoCgnOCBgIBS?=
 =?us-ascii?q?SMLGA1IESw3FBkEPm4HjiEggkgObRNBCy9JUCvHHoQooVsaM6psmQiCAaF8X?=
 =?us-ascii?q?YRpgWg8gVkzGggbFYMiUxkPji0W0BUrMj8HAgcPApFzgX4BAQ?=
IronPort-Data: A9a23:1dfB9a1tdrebozF9BPbD5WJzkn2cJEfYwER7XKvMYLTBsI5bpzFWn
 2AaXGyGafuPMTb2cot+O9/i/B9QsZTWy4JhTwtl3Hw8FHgiRegpqji6wuYcGwvIc6UvmWo+t
 512huHodZ5yFjmH4E/xbtANlFEkvYmQXL3wFeXYDS54QA5gWU8JhAlq8wIDqtYAbeORXUXX5
 Lsen+WFYAX7g24tbTpOg06+gEoHUMra6WtwUmMWPZinjHeG/1EJAZQWI72GLneQauF8Au6gS
 u/f+6qy92Xf8g1FIovNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ajs7XAMEhhXJ/0F1lqTzeJ
 OJl7vRcQS9xVkHFdX90vxNwS0mSNoUekFPLzOTWXcG7lyX7n3XQL/pGU2gmANUo/O9LGmxg1
 thBASoSZRaomLfjqF67YrEEasULJc3vOsYb/3pn1zycVaxgSpHYSKKM7thdtNsyrpkRRrCFO
 YxAN3w2N0Wojx5nYj/7DLokgOaji1H0ciZTrxSeoq9fD237nFUojeSzboqKEjCMbZhQnXyqi
 HKbxUnkBxhdLffG0xqP2G3504cjmgu+Aur+DoaQ+vN0qFGLym9VDwcZPWZXutGwjkq4HtYaI
 EsO92929+459VegSZ/2WBjQTGO4gyPwkuF4S4USgDxhAIKOi+pFLgDolgJ8VeE=
IronPort-HdrOrdr: A9a23:aTvLy64x7bPx9FAuKgPXwALXdLJyesId70hD6qm+c3Bom6uj5q
 STdZsguyMc5Ax6ZJhko6HiBEDiewK4yXcW2+gs1N6ZNWGMhILrFvAB0WKI+VLd8kPFm9J15O
 NJb7V+BNrsDVJzkMr2pDWjH81I+qjhzEnRv4fj5kYoax12YKd96Ao8IAOaHkpqADRiP/MCZf
 yhDg4tnUvZRZzRBf7Lf0U4Yw==
X-Talos-CUID: =?us-ascii?q?9a23=3AbHFrb2pt2De0JoPhSWNaNfHmUZ8MYkCF/HHZH1S?=
 =?us-ascii?q?1J0VNEZSPVlSW07wxxg=3D=3D?=
X-Talos-MUID: 9a23:XQzTEQV/D6SbEUXq/GLphwtQGtc12YmzDUlKiL5foemOHzMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,229,1779148800"; d="scan'208";a="811546687"
Received: from alln-l-core-02.cisco.com ([173.36.16.139])
 by alln-iport-8.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 17 Aug 2026 20:16:36 +0000
Received: from rtice-VMware20-1 (unknown [10.189.17.96])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: rtice@cisco.com)
 by alln-l-core-02.cisco.com (Postfix) with ESMTPSA id 87ECF1800015E;
 Mon, 17 Aug 2026 20:16:35 +0000 (GMT)
From: Randy Tice <rtice@cisco.com>
To: dev@dpdk.org
Cc: Randy Tice <rtice@cisco.com>
Subject: [PATCH v4] eal/linux: harden uevent recv error handling
Date: Mon, 17 Aug 2026 16:16:02 -0400
Message-ID: <20260817201602.120526-1-rtice@cisco.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260813201656.65649-1-rtice@cisco.com>
References: <20260813201656.65649-1-rtice@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: rtice@cisco.com
X-Outbound-Client-TLS: ANONYMOUS; unknown [10.189.17.96]; TLSv1.3;
 TLS_AES_256_GCM_SHA384; 256
X-Outbound-SMTP-Client: 10.189.17.96, [10.189.17.96]
X-Outbound-Node: alln-l-core-02.cisco.com
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

v4:
Wrong patch submitted

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
index ec408649d0..5b3e9dea9f 100644
--- a/lib/eal/linux/eal_dev.c
+++ b/lib/eal/linux/eal_dev.c
@@ -241,9 +241,16 @@ dev_uev_handler(__rte_unused void *param)
 
 	ret = recv(rte_intr_fd_get(intr_handle), buf, EAL_UEV_MSG_LEN,
 		   MSG_DONTWAIT);
-	if (ret < 0 && errno == EAGAIN)
+	if (ret < 0 &&
+		(errno == EAGAIN || errno == EWOULDBLOCK || errno == EINTR)) {
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

