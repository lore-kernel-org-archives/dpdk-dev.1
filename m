Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99E7606A31D
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Oct 2026 03:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=TfYJj88e
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE4D640151;
	Wed, 28 Oct 2026 04:53:59 +0100 (CET)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mails.dpdk.org (Postfix) with ESMTPS id C2D14400D7
 for <dev@dpdk.org>; Wed, 28 Oct 2026 04:53:57 +0100 (CET)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-8a064fac8cbso403190b3a.1
 for <dev@dpdk.org>; Tue, 27 Oct 2026 20:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793159636;
 x=1793764436; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GYe8NXUucYPMut5x7ObpTmubj5Shg25vPadJtfFVPg0=;
 b=TfYJj88edV5y/5rP2oufZypaqv0WN87bPzIr2NKk/Zci7NiILEty8NTpbxXb4jglR0
 wlH2CXibjXHG5Eu2BmAO7XY6mya00lNaGTbvJEDnIG5Fu2TwBeP/GoeLCPNHFW1aQ8++
 ccA8JEgmhzWjbG/8lvDNTbmtOg8urvRa26bQjLwit8jmMMTHSIjqaQk0nCJXbSFJUCIF
 5rS8L6DYiUo/NzKlkdlh/putRPpKJ0uxFudkXy8RSfDcumSAyG3jtrU4xswtWYURkStZ
 LSA5cjTk60IRnhGUT94rEy+FOhUwWvPdsMDrEu6WnlvivSqiSnmQ9fj5Cjp7ByCVE+H/
 BTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793159636; x=1793764436;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GYe8NXUucYPMut5x7ObpTmubj5Shg25vPadJtfFVPg0=;
 b=qgUAzQ5YyxUAj3rCRF8BRjbdUn1RHBcGV689JzENkrPTWmOFZqsX3DAgZ4PAYo1TgR
 7dNfSbM5vl36m67LlfQrjzfZ076ZfrIYOLJ1knMQW20AR0TwMUkEaKpH6ueFCxFqmaDu
 W3h3s6sy+l29Opuen0lLNHseZVx/o4++N8KD5th8dlZBOIOOHM6IGbXYMxQMFvHUGHL5
 LauzziKXxhOUAG6sh1upfvxt6lYzu6E2yB1Qvy6ho3F86lZbRR48rL//5mAi1BNQTJu3
 DYgAsiNFl+DedIoOGXOK7SV5ts/HBuGVpqZADCFUxZ35/5GL57gyotST+XAVxH3l/URX
 F08w==
X-Gm-Message-State: AFq9FYKwndiVh3pF4i9GNsEhuMubzR/snLcQpAYFKnnUEgBWjGXe/LNA
 gBC+YxbdYMfE74oT3xCpFPdAB1Zjvla1GEzDwSxgFO6LCuyft4pGIZyZxORKnxgMr1HEKGZoJsR
 jSU97RB4=
X-Gm-Gg: AYBFou1XEtkXXlEh8DarxmmCYL5zweUwM4CqFZ+A+qNkA7Wh4ZumvfYNB7znQm5OS4q
 9kaTkltX7V04efdavtDEw8Uh+x/myfmqu9BzExNL85F5vugwUu4FronJ16aMejs+Y1Lv1h2NZEi
 fNEZjYOY9Ho4id4TOZjKkJ37rTm9G86C+xLVHY65KrsZIBHaoc9vWln8/UjQLNuJFVqRJHWYT2I
 UkP/BrCy7yvSEus6UsD3wyTpi3N2AauwP3SfDwiKmxECcDqTIJkyqrCdHoaHlGC5cgrcy586m8T
 rVCOGoxUJLeqixxUC/zfJROzWez9ptXirj8n/U6gBNZxib+/BLvZSbCX6dzRaVbRJAfKGy1oSOe
 YEWkFNpWhgxoIKgnjIhnDHGewQASFIStMMVS2mHzJTvreaWWpT5FoTgcS0LpGA3znsqZii/ZQTx
 Mp18nSy9g4x1ime4MlA7w60qcmB+L6YlflVt8No8xyeBb58vdb/vxeU3DqtyGxGEJSYp36YI6sF
 H0wQydlweWEinx8v+o3nygmOUDbEscHxgt87IfSRt4z1ZJTABAiYgqO9JEXfd8YI6OkLntnMwlq
 NNXmC3+jqYUG8yg7j7hIXInAXawg8P9yGhGm55Wn7YbcVon7aTY9W/0mOje1+D5myEiB
X-Received: by 2002:a05:6a00:84a:b0:880:b709:cefb with SMTP id
 d2e1a72fcca58-8a6e83adf19mr933042b3a.45.1793159636081; 
 Tue, 27 Oct 2026 20:53:56 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8a6a662ba00sm607295b3a.23.2026.10.27.20.53.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 20:53:55 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>,
 Michael Wildt <michael.wildt@broadcom.com>,
 Randy Schacher <stuart.schacher@broadcom.com>
Subject: [RFC] net/bnxt: fix buffer overflow in TF set message helpers
Date: Tue, 27 Oct 2026 20:53:53 -0700
Message-ID: <20261028035353.2273737-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

LTO build with -Werror reports stack overflows in tf_msg.c:

  In function 'tf_global_cfg_set':
  rte_memcpy.h:91:9: error: writing 16 bytes into a region of size 8
  tf_msg.c:1574:45: note: at offset 48 into destination object 'req'
  of size 56

  In function 'tf_msg_set_if_tbl_entry':
  rte_memcpy.h:105:9: error: writing 32 bytes into a region of size 0
  tf_msg.c:1813:41: note: at offset 136 into destination object 'req'
  of size 128

tf_msg_set_global_cfg() limits config_sz_in_bytes to 16, but
req.data and req.mask are each 8 bytes. A config larger than 8 bytes
overruns data into mask, and the mask copy runs off the end of req.

tf_msg_set_if_tbl_entry() has no check at all. data_sz_in_bytes is a
uint16_t copied into the 88 byte req.data. The ULP mapper fills it
from a blob of up to 128 bytes.

Check both against sizeof() of the destination, as the matching get
functions already do.

Fixes: 98487d729b4a ("net/bnxt: cleanup and refactor session management")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/bnxt/tf_core/tf_msg.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bnxt/tf_core/tf_msg.c b/drivers/net/bnxt/tf_core/tf_msg.c
index aab8d05d81..ab03afaabd 100644
--- a/drivers/net/bnxt/tf_core/tf_msg.c
+++ b/drivers/net/bnxt/tf_core/tf_msg.c
@@ -23,7 +23,6 @@
  * means we have to manually sync hwrm with these defines if the
  * tf.yaml changes.
  */
-#define TF_MSG_SET_GLOBAL_CFG_DATA_SIZE  16
 #define TF_MSG_EM_INSERT_KEY_SIZE        64
 #define TF_MSG_EM_INSERT_RECORD_SIZE     96
 #define TF_MSG_TBL_TYPE_SET_DATA_SIZE    88
@@ -1618,7 +1617,7 @@ tf_msg_set_global_cfg(struct tf *tfp,
 	req.offset = tfp_cpu_to_le_32(params->offset);
 
 	/* Check for data size conformity */
-	if (params->config_sz_in_bytes > TF_MSG_SET_GLOBAL_CFG_DATA_SIZE) {
+	if (params->config_sz_in_bytes > sizeof(req.data)) {
 		rc = -EINVAL;
 		TFP_DRV_LOG(ERR,
 			    "%s: Invalid parameters for msg type, rc:%s\n",
@@ -1816,6 +1815,9 @@ tf_msg_set_if_tbl_entry(struct tf *tfp,
 	struct tf_dev_info *dev;
 	struct tf_session *tfs;
 
+	if (params->data_sz_in_bytes > sizeof(req.data))
+		return -EINVAL;
+
 	/* Retrieve the session information */
 	rc = tf_session_get_session(tfp, &tfs);
 	if (rc) {
-- 
2.53.0

