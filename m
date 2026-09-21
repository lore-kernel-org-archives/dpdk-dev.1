Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497ECC982EA
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 03:03:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 53931410DC;
	Mon, 21 Sep 2026 05:03:13 +0200 (CEST)
Received: from mail-ot1-f100.google.com (mail-ot1-f100.google.com
 [209.85.210.100])
 by mails.dpdk.org (Postfix) with ESMTP id E70B540E25
 for <dev@dpdk.org>; Mon, 21 Sep 2026 05:03:10 +0200 (CEST)
Received: by mail-ot1-f100.google.com with SMTP id
 46e09a7af769-7f4f824de5dso258573a34.2
 for <dev@dpdk.org>; Sun, 20 Sep 2026 20:03:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789959790; x=1790564590;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5oy+3ucYiOoKMDL/XyjABZEm19+WlJ0F5HC3+NOlEG8=;
 b=YtR3PQ6UimE9V18clhRR7tWIM/cHhzOImDeoofT2f6yfauIAOqJVQGAePaaiiSIJld
 238D8GC5WM0noMkwF2QVgtwk+H+6UotYgX+O4V9FSqtGVNbWOS8ON2/RMZ6eTZDbp1O6
 1jUivB5Z8py9iriMeSI9wWhrTg6S3WP0r09z3ZzZVK2pNzN3Zjnq/kgd96IZf+tBL7TT
 w0pAtmNTJPWnN3J9LkGefyrCW84OMQ5bRkN+1osDs3c4WwuLKNImqrPnnRBv3PIPdhwU
 3W5diG2Pa9dubuZzk9u/V/p0xMwcnwNcho85pdYVdBSBLEQtji9XAk8vNlQM7TVefgZV
 4hSw==
X-Gm-Message-State: AFuF++maxRfFCEaSMIQOrdblaz69+rv7hswYALT1gtdDvim/fElVU7ec
 d7dGD016uczv8sEhigLSvmQCGruMXIBAvVLH/NzZ6nC9KsU3aaytFVyx6F8IIL475MtILYW1JLy
 3D5VNwPjOs9tA6ut6gYavv3AaU4i7VN/jhsy6w6Kbj4rfP7+2pAykoqLMIcmWF2ZkKx/gbZpvZd
 O7yki/qes/y1INZtUJ6TINbe4iZr31QZXceq3bXHICqZ0hBeZBEzm8VuzgARfykA4EgoOUOcMkk
 kovU9lSyyLj
X-Gm-Gg: AYBFou0T+6sRvdy9r+SURO2ZVTt0ixuAA2oPCX+wOJe/UdM4rPA3U9DVY/F9K+gjFFR
 Vdp6dsCv/fQ0ufA0Ul2ES/zy0E5vVdHZ+baAvOCFwl2Qm+hEQcxCWQ+fbPDI+LMAcET/X0OdgGJ
 jcRZOxQnZncCaSDIR8Zn3uyrfnf6fEu5+Y9S5i/JxomKktXanQebLGiBZoZ5GTUAd3tbTFIll6r
 yCTp1x/DNjCuXolG9BNjtzMaZ8m+MAnJ/VnUC3iUrnkhAfNvQQEIF+pqLnI8OknEiHMXX2JBCsX
 UfVIL2qBtwt5ErGydnsM7XPCaA68fAbCWmeC5qCVqKcDMXNHgAP/fTxAB/EgTdLSzsc2Mto5flU
 u59ylbH0/Ta0cMSyhLWQZjsZWNKIDYmk8zzr/eYg8W4OoDV4GRBJIb1k2AemXAeihqu3dKdR8VA
 j3vMjKOrkJG6haVHqJjgrV4h3F67AJyjmmlgm6lbICx2H+88iW7J0G
X-Received: by 2002:a05:6830:6415:b0:7fa:ab72:9e04 with SMTP id
 46e09a7af769-80de41f6f9cmr10358331a34.28.1789959789919; 
 Sun, 20 Sep 2026 20:03:09 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
 by smtp-relay.gmail.com with ESMTPS id
 46e09a7af769-8107b12c278sm3632421a34.1.2026.09.20.20.03.09
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 20 Sep 2026 20:03:09 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38e1118e4abso4717037a91.0
 for <dev@dpdk.org>; Sun, 20 Sep 2026 20:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1789959788; x=1790564588; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5oy+3ucYiOoKMDL/XyjABZEm19+WlJ0F5HC3+NOlEG8=;
 b=NHiWEqiLZfVwTTyTvYma9tVDyehr4PYeiRnOAk0tCHyUNne2sNQshld5zx7gUJHh8Y
 omsfeGHMwXhx5TTJYUMZwipFfXwCsFFumxA+bs30mtseC9WR4suL/c0GB2T3HtAzzW/9
 yc7XeqyqFw/jeRwsYYNfidUqBeqcJlKDChZKc=
X-Received: by 2002:a17:90b:17c1:b0:39d:f2a1:3a with SMTP id
 98e67ed59e1d1-39e54c19b62mr15208676a91.15.1789959788147; 
 Sun, 20 Sep 2026 20:03:08 -0700 (PDT)
X-Received: by 2002:a17:90b:17c1:b0:39d:f2a1:3a with SMTP id
 98e67ed59e1d1-39e54c19b62mr15208639a91.15.1789959787547; 
 Sun, 20 Sep 2026 20:03:07 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144d55f299fsm28621856c88.15.2026.09.20.20.03.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 20:03:07 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, Joseph Wong <joseph.wong@broadcom.com>,
 stable@dpdk.org, Farah Smith <farah.smith@broadcom.com>,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH] net/bnxt: fix NVRAM directory integer overflow
Date: Sun, 20 Sep 2026 21:06:11 -0600
Message-ID: <20260921030611.1034818-1-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

From: Joseph Wong <joseph.wong@broadcom.com>

Add bounds checking in bnxt_get_nvram_directory() to prevent a length
underflow when subtracting 2 from the input length, and an integer
overflow when calculating the required buffer length. Also enforce
firmware-supplied upper bounds on the directory entry count and entry
length, guarding against an undersized DMA buffer if firmware reports
implausible values, and use 64-bit arithmetic for the buffer size
calculation. The two returned values are each written back as a
single byte, so their upper bounds are UINT8_MAX, not larger values
that would let a firmware-reported value above 255 pass validation
and then silently truncate on the byte store.

Fixes: 19e6af01bb36 ("net/bnxt: support get/set EEPROM")
Cc: stable@dpdk.org

Signed-off-by: Joseph Wong <joseph.wong@broadcom.com>
Signed-off-by: Farah Smith <farah.smith@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_hwrm.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c
index 1615b36aae..bb55de9905 100644
--- a/drivers/net/bnxt/bnxt_hwrm.c
+++ b/drivers/net/bnxt/bnxt_hwrm.c
@@ -6049,6 +6049,9 @@ int bnxt_hwrm_nvm_get_dir_info(struct bnxt *bp, uint32_t *entries,
 	return rc;
 }
 
+#define BNXT_MAX_DIR_ENTRIES   UINT8_MAX
+#define BNXT_MAX_ENTRY_LENGTH  UINT8_MAX
+
 int bnxt_get_nvram_directory(struct bnxt *bp, uint32_t len, uint8_t *data)
 {
 	int rc;
@@ -6060,16 +6063,27 @@ int bnxt_get_nvram_directory(struct bnxt *bp, uint32_t len, uint8_t *data)
 	struct hwrm_nvm_get_dir_entries_input req = {0};
 	struct hwrm_nvm_get_dir_entries_output *resp = bp->hwrm_cmd_resp_addr;
 
+	if (len < 2)
+		return -EINVAL;
+
 	rc = bnxt_hwrm_nvm_get_dir_info(bp, &dir_entries, &entry_length);
 	if (rc != 0)
 		return rc;
 
+	if (dir_entries == 0 || dir_entries > BNXT_MAX_DIR_ENTRIES ||
+	    entry_length == 0 || entry_length > BNXT_MAX_ENTRY_LENGTH) {
+		PMD_DRV_LOG_LINE(ERR,
+			"Invalid dir info: entries=%u length=%u",
+			dir_entries, entry_length);
+		return -EINVAL;
+	}
+
 	*data++ = dir_entries;
 	*data++ = entry_length;
 	len -= 2;
 	memset(data, 0xff, len);
 
-	buflen = dir_entries * entry_length;
+	buflen = (size_t)dir_entries * entry_length;
 	buf = rte_malloc("nvm_dir", buflen, 0);
 	if (buf == NULL)
 		return -ENOMEM;
-- 
2.47.3

