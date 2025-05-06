Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E46C3ABBE
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 May 2025 17:41:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A6F74060F;
	Tue,  6 May 2025 19:41:04 +0200 (CEST)
Received: from mx2.freebsd.org (mx2.freebsd.org [96.47.72.81])
 by mails.dpdk.org (Postfix) with ESMTP id EDF58402A3
 for <dev@dpdk.org>; Tue,  6 May 2025 19:41:01 +0200 (CEST)
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits)
 client-signature RSA-PSS (4096 bits))
 (Client CN "mx1.freebsd.org", Issuer "R10" (verified OK))
 by mx2.freebsd.org (Postfix) with ESMTPS id 4ZsQfj4v8gz3QZK;
 Tue, 06 May 2025 17:41:01 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [96.47.72.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
 client-signature RSA-PSS (4096 bits) client-digest SHA256)
 (Client CN "smtp.freebsd.org", Issuer "R11" (verified OK))
 by mx1.freebsd.org (Postfix) with ESMTPS id 4ZsQfj1KLQz3x8T;
 Tue, 06 May 2025 17:41:01 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
 t=1746553261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PHAlWuMnDP4yb3eX7u4SOOZD0ERkCX5oqkuZizwVoV4=;
 b=xR/GpX8NtL/nWMWizGz3vc/rA6yB0q4TeliITcCIXMOLORRGkqFc6geNM4Tn8nnmSct5VC
 5QGDwuBhbQS8c4cSZjA8b0Vhowv8FYHmUDZNLg8RD52gzaFm5atQl3KF5AXKJhfDy05Lu7
 KBTRX2RRzim4XJ1O6P7+8e8B9pd+Kn39euckLnunUcVYZVzYmmqwJUzVaRKjscjFvw2/+G
 wcBNp3CAdRppnxJcHoXwz4xfckB4UDRxeK8zaZM120cV+3y5Jsr8MhGSzJycsMq3naNQLp
 KCvgrWnHFwbyjp94zQ9BxOuuypHuVi6Bb4UiT5Zx2mb9PTklmhOr0PW8RyZZag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
 s=dkim; t=1746553261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PHAlWuMnDP4yb3eX7u4SOOZD0ERkCX5oqkuZizwVoV4=;
 b=ygjnkoilz2x+VmJN+xODsiQxJL49DcP6bqGewHEE2D/8S86nk1L0nnP8Hk1Ynp1q9KpT/J
 m4/XUUoIueJ+D+ALVKW+gGLk2dF0KO3Vwy4fwSw9wyYbFDLJxpz9TluYt84JfIB5ot8s69
 tWRUJIxOmfRrVNOZ+A2X0t5OWxqzwLKV4nRDWoNtOGg9PQ83uCxkHyWxV+xVNJ3c5xU2MM
 mCLXtp9QwYWpn2OcYkiu0GhR47S2gRvDKmbdagebi1tazncabN+yF9UwSDw0E1dhWLMdc/
 jtXT1sHffCQHAJA+ThYtB4+/z39V9T8zTGNehFIGRddsPqT20PF3DFQDj3v4FA==
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1746553261; a=rsa-sha256; cv=none;
 b=yYxlra7Ylt+a3pz4cJNu4Ouf7A9ELP+u8C6MzMplTQCfhHFonQFlP/q65dquclv30nbVdB
 y6nwsA1+Sy/9MwUQ6hqDoHAgJpCDYojJyMuOX1Mr9Q8HEaMLvkO40tT/cW/ndbnBYqdZXd
 tI3FASRdkqm/WcP+qfdz18gY89SL5U7JvE69e6XiFGgwDevmf02YsNOvxoMmVuGojnxOB7
 GB8VB5LDg2Td6nC0Ezi4O07zG1CvOTDcCmXPX7bYjMvtdJTbeV0rj/SwOGT7Wl9nklicI9
 EDSEgWnK7hieClIQqS8Bi74VRb9BcY3yWXWh36ly10JhOu39gtKdqRr0eOCYCQ==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
Received: from s1.pct.niksun.com (67-4-147-206.mpls.qwest.net [67.4.147.206])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate) (Authenticated sender: jfree)
 by smtp.freebsd.org (Postfix) with ESMTPSA id 4ZsQfh4gvhztv5;
 Tue, 06 May 2025 17:41:00 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
From: Jake Freeland <jfree@FreeBSD.org>
To: Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Cc: Jake Freeland <jfree@FreeBSD.org>,
	dev@dpdk.org
Subject: [PATCH 4/4] bus/pci/bsd: Fix device existence check
Date: Tue,  6 May 2025 12:40:44 -0500
Message-ID: <20250506174046.1136711-5-jfree@FreeBSD.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250506174046.1136711-1-jfree@FreeBSD.org>
References: <20250506174046.1136711-1-jfree@FreeBSD.org>
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

Use open(2) instead of access(2) to check for the existence of the target
device. This avoids a possible race condition where the the device file is
removed after a successful call to access(2) but before open(2).

This also fixes any potential bugs associated with passing open(2)-style
flags into access(2). i.e. access(2) does not formally support the O_RDWR
flag.

Signed-off-by: Jake Freeland <jfree@FreeBSD.org>
---
 drivers/bus/pci/bsd/pci.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/bus/pci/bsd/pci.c b/drivers/bus/pci/bsd/pci.c
index c64cd2c86c..9bce9df503 100644
--- a/drivers/bus/pci/bsd/pci.c
+++ b/drivers/bus/pci/bsd/pci.c
@@ -106,20 +106,29 @@ pci_uio_alloc_resource(struct rte_pci_device *dev,
 {
 	char devname[PATH_MAX]; /* contains the /dev/uioX */
 	struct rte_pci_addr *loc;
+	int fd;
 
 	loc = &dev->addr;
 
 	snprintf(devname, sizeof(devname), "/dev/uio@pci:%u:%u:%u",
 			dev->addr.bus, dev->addr.devid, dev->addr.function);
 
-	if (access(devname, O_RDWR) < 0) {
-		PCI_LOG(WARNING, "  "PCI_PRI_FMT" not managed by UIO driver, skipping",
-			loc->domain, loc->bus, loc->devid, loc->function);
-		return 1;
+	fd = open(devname, O_RDWR);
+	if (fd < 0) {
+		if (errno == ENOENT) {
+			PCI_LOG(WARNING, PCI_PRI_FMT" not managed by UIO "
+					"driver, skipping", loc->domain,
+					loc->bus, loc->devid, loc->function);
+			return 1;
+		}
+		PCI_LOG(ERR, "Failed to open device file for " PCI_PRI_FMT
+				" (%s)", loc->domain, loc->bus, loc->devid,
+				loc->function, devname);
+		return -1;
 	}
 
 	/* save fd if in primary process */
-	if (rte_intr_fd_set(dev->intr_handle, open(devname, O_RDWR))) {
+	if (rte_intr_fd_set(dev->intr_handle, fd)) {
 		PCI_LOG(WARNING, "Failed to save fd");
 		goto error;
 	}
-- 
2.47.2

