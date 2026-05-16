Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BD5CD4F21
	for <dpdk-dev@archiver.kernel.org>; Sat, 16 May 2026 10:20:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A5CC04026C;
	Sat, 16 May 2026 12:20:04 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id BB09A40269
 for <dev@dpdk.org>; Sat, 16 May 2026 12:20:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778926802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=L+MV6zXtIHqTH/DDNdFJh5j9eLkDDbcZusXvtzxuXoo=;
 b=gE6akwnzUoapwekgJvUI7qJJmYLeFVvjlriuxBqeIX1vmXavs5YAWI/0ccI2ogDKzUXPRk
 3vU42Tfmih5Gvyy3BBbEnnFBeZncbtoYJCklX770dpiNx0g4O6ZhQ2en2TxlMaKXrC5S9k
 RiJeB8UqKuf/FFyJF9H2AaVIjD0Lfkk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-ywNVDprHPRe4AHNLxSkofA-1; Sat,
 16 May 2026 06:19:59 -0400
X-MC-Unique: ywNVDprHPRe4AHNLxSkofA-1
X-Mimecast-MFC-AGG-ID: ywNVDprHPRe4AHNLxSkofA_1778926798
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C90F71800451; Sat, 16 May 2026 10:19:57 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.52])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8CE8E18001E8; Sat, 16 May 2026 10:19:55 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: patrick.mahan@hpe.com, Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH] net/ice: improve log messages for DDP loading
Date: Sat, 16 May 2026 12:19:41 +0200
Message-ID: <20260516101942.443871-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: E8d_TupPBwsA-W6Mr28A48-N8NQd2WG4VEAV8meb6Ko_1778926798
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

Some nics may not provide a serial number (PCI capability
RTE_PCI_EXT_CAP_ID_DSN).

This results in a confusing ERROR log:
ICE_INIT: ice_dev_init(): Failed to read device serial number

This is confusing as DDP loading does *not* require the serial number to
be present for the port to be functional afterwards.

Besides, after trying various path, if the default DDP is not present on
the runtime system, the port initialisation ends up with a vague error:
ICE_INIT: ice_load_pkg(): failed to search file path

Improve the situation with adjusting the log level when reading the
SN fails, then add more debug context to DDP file loading and end up
with a ERROR log mentioning the expected file.

ICE_INIT: ice_firmware_read(): Cannot read DDP file
	/lib/firmware/updates/intel/ice/ddp/ice-b49691ffffe6e69c.pkg
ICE_INIT: ice_firmware_read(): Cannot read DDP file
	/lib/firmware/intel/ice/ddp/ice-b49691ffffe6e69c.pkg
ICE_INIT: ice_firmware_read(): Cannot read DDP file
	/lib/firmware/updates/intel/ice/ddp/ice.pkg
ICE_INIT: ice_firmware_read(): Cannot read DDP file
	/lib/firmware/intel/ice/ddp/ice.pkg
ICE_INIT: ice_load_pkg(): Failed to load default DDP package
	/lib/firmware/intel/ice/ddp/ice.pkg

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 31 ++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 0f2e7aee14..e065581ccf 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -2003,6 +2003,17 @@ static int ice_read_customized_path(char *pkg_file, uint16_t buff_len)
 	return n;
 }
 
+static int
+ice_firmware_read(const char *file, void *buf, size_t *bufsz)
+{
+	int ret = rte_firmware_read(file, buf, bufsz);
+
+	if (ret < 0)
+		PMD_INIT_LOG(DEBUG, "Cannot read DDP file %s", file);
+
+	return ret;
+}
+
 int ice_load_pkg(struct ice_adapter *adapter, bool use_dsn, uint64_t dsn)
 {
 	struct ice_hw *hw = &adapter->hw;
@@ -2016,7 +2027,7 @@ int ice_load_pkg(struct ice_adapter *adapter, bool use_dsn, uint64_t dsn)
 	/* first read any explicitly referenced DDP file*/
 	if (adapter->devargs.ddp_filename != NULL) {
 		strlcpy(pkg_file, adapter->devargs.ddp_filename, sizeof(pkg_file));
-		if (rte_firmware_read(pkg_file, &buf, &bufsz) == 0) {
+		if (ice_firmware_read(pkg_file, &buf, &bufsz) == 0) {
 			goto load_fw;
 		} else {
 			PMD_INIT_LOG(ERR, "Cannot load DDP file: %s", pkg_file);
@@ -2032,11 +2043,11 @@ int ice_load_pkg(struct ice_adapter *adapter, bool use_dsn, uint64_t dsn)
 		if (use_dsn) {
 			snprintf(pkg_file, RTE_DIM(pkg_file), "%s/%s",
 					customized_path, opt_ddp_filename);
-			if (rte_firmware_read(pkg_file, &buf, &bufsz) == 0)
+			if (ice_firmware_read(pkg_file, &buf, &bufsz) == 0)
 				goto load_fw;
 		}
 		snprintf(pkg_file, RTE_DIM(pkg_file), "%s/%s", customized_path, "ice.pkg");
-		if (rte_firmware_read(pkg_file, &buf, &bufsz) == 0)
+		if (ice_firmware_read(pkg_file, &buf, &bufsz) == 0)
 			goto load_fw;
 	}
 
@@ -2046,23 +2057,23 @@ int ice_load_pkg(struct ice_adapter *adapter, bool use_dsn, uint64_t dsn)
 	strncpy(pkg_file, ICE_PKG_FILE_SEARCH_PATH_UPDATES,
 		ICE_MAX_PKG_FILENAME_SIZE);
 	strcat(pkg_file, opt_ddp_filename);
-	if (rte_firmware_read(pkg_file, &buf, &bufsz) == 0)
+	if (ice_firmware_read(pkg_file, &buf, &bufsz) == 0)
 		goto load_fw;
 
 	strncpy(pkg_file, ICE_PKG_FILE_SEARCH_PATH_DEFAULT,
 		ICE_MAX_PKG_FILENAME_SIZE);
 	strcat(pkg_file, opt_ddp_filename);
-	if (rte_firmware_read(pkg_file, &buf, &bufsz) == 0)
+	if (ice_firmware_read(pkg_file, &buf, &bufsz) == 0)
 		goto load_fw;
 
 no_dsn:
 	strncpy(pkg_file, ICE_PKG_FILE_UPDATES, ICE_MAX_PKG_FILENAME_SIZE);
-	if (rte_firmware_read(pkg_file, &buf, &bufsz) == 0)
+	if (ice_firmware_read(pkg_file, &buf, &bufsz) == 0)
 		goto load_fw;
 
 	strncpy(pkg_file, ICE_PKG_FILE_DEFAULT, ICE_MAX_PKG_FILENAME_SIZE);
-	if (rte_firmware_read(pkg_file, &buf, &bufsz) < 0) {
-		PMD_INIT_LOG(ERR, "failed to search file path");
+	if (ice_firmware_read(pkg_file, &buf, &bufsz) < 0) {
+		PMD_INIT_LOG(ERR, "Failed to load default DDP package " ICE_PKG_FILE_DEFAULT);
 		return -1;
 	}
 
@@ -2658,13 +2669,13 @@ ice_dev_init(struct rte_eth_dev *dev)
 	if (pos) {
 		if (rte_pci_read_config(pci_dev, &dsn_low, 4, pos + 4) < 0 ||
 				rte_pci_read_config(pci_dev, &dsn_high, 4, pos + 8) < 0) {
-			PMD_INIT_LOG(ERR, "Failed to read pci config space");
+			PMD_INIT_LOG(WARNING, "Failed to read pci config space");
 		} else {
 			use_dsn = true;
 			dsn = (uint64_t)dsn_high << 32 | dsn_low;
 		}
 	} else {
-		PMD_INIT_LOG(ERR, "Failed to read device serial number");
+		PMD_INIT_LOG(INFO, "Failed to read device serial number");
 	}
 
 	ret = ice_load_pkg(pf->adapter, use_dsn, dsn);
-- 
2.53.0

