Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9CBCA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:45:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E33FC42FB9;
	Tue, 29 Sep 2026 18:40:38 +0200 (CEST)
Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com
 [74.125.228.38]) by mails.dpdk.org (Postfix) with ESMTP id D344D42EE2
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:39:00 +0200 (CEST)
Received: by mail-pz2-f38.google.com with SMTP id
 d2e1a72fcca58-88272e1d069so1991118b3a.1
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699940;
 x=1791304740; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0lI3virqKF8YH11Zm1z5LNn3RKes4noW2zwn1rG7R2Y=;
 b=isFXGJTeuTh/NU9pqMeBoRdVj5p86XM4dYf0qs76HYRuDPZZK5pigEGis8GvJhVnqh
 3wrXTGHrMWSkciLNd32QF3iJ2e7Qs8qGpJIRLbRkwR+brv5QeZtISGON+ngZw+o1wX6R
 QDH4CoJDMIYoxE0BSrylYS9c90CKJ6U1Vd5qs5+tBHpIaCiqfUb1L+8q5wKBsaAejKAn
 9NeUhwzoxICdBXaD/q/j34NTfjAOphwLEeVwlUQRnrR6XjAJAuYiVJxr0KLzS40Srehb
 StnLm4Xh5fHBy7zYBIk75KZutR5ag50D3k3x6mNanyzxDqYHcGIOD7yhNyPE+EbGAb1q
 I0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699940; x=1791304740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0lI3virqKF8YH11Zm1z5LNn3RKes4noW2zwn1rG7R2Y=;
 b=xDxk2p+Bg1x+OomINaMzyTnG9975de3mr10l8nEAxMUWtDnfTCquQY26jJvuQWxn1b
 soiIStSFhfOyvNehg537uo/cn7bYB6e6MaLkh/0lzOtA3sjrl9pbn0dvqwVNY61Xzrjd
 n6Af04DHZHcy7PhHRJ6QNEFgj8E4PWAoO8SmbsD88Yug+zFMnuwe45Z7j75eBLprQGBS
 59o2sliSmmnBS7vKVC0Xav7OovgBC3EPRFlEB7XaPGyjCDcTIK7XCs2yHNps1+xsNSCG
 Ev6tQgnUcwmuecLj/N/bO1uMbMSNljG2Wbo3LhHFMN5XhJU+JpvIGvLKFwjL2DHt0Z5P
 2YNg==
X-Gm-Message-State: AFuF++nt8/pEBBQcO8PXLy4WigC6sOlrGlxKUPPmY48xHSVgP5wU34XE
 zBzmlzgVh82tcxismPGz21l362VsR5+ZQtSPOrmgI7p0pWT6b87ht4GIiHkEKwsQ/37Y72Oca/N
 2tEdSce65Rg==
X-Gm-Gg: AYBFou2gndanf9bNmGoaCZ7UD0mr3OdmVtia7epLI1SWYg/4UsCnUKyUL24KYOF+tXt
 2KaUh4HemJchbPQV2HuR437hN1PDNZ6sNdxyN9o1x5ZNMVmRgLayEVvRNUKpqjFpyoRdPjaRSai
 AkGbMGwhC1t7wnWzRTxLLpmftkamVnADgg3aDIFZVubbGW7bml5LOF84b+IRfOQb5Zatpb3el2g
 KRtKehe+YB4nEiQ8TvNHU8shjfioSnIdI+6oUkn1P/THOejxgCvwBIXJTyuLwI9YiJVdQQMv/1I
 ilxGrZrZormnPXRseBpgSW2vGNtkEYnEykVx5SCI+mPSZypGC93BkigULL5eji3y8twJrXq4GgJ
 7ImJA0fqEQc3SSvEeXD+FjBPSOIdo7bO6KXUjJwEReLiHYEPOPT9aiBBJzssPvaDY6rEkKnBLPc
 NdTA1tqP1juW0xojhH3U20cOCaWYjX8HTNW3f+fgtPxpxaiheS4d3DJp0y44i555jQh6aS/9God
 GXgwAf7q7v+HK6SrNt3K5PBlC0NltSWOI63iA==
X-Received: by 2002:a05:6a00:b83:b0:878:34d7:697c with SMTP id
 d2e1a72fcca58-8802c46f9d4mr10552029b3a.42.1790699939951; 
 Tue, 29 Sep 2026 09:38:59 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:59 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Xingui Yang <yangxingui@huawei.com>,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH v2 59/61] net/hns3: use kvargs hex helper for capability mask
Date: Tue, 29 Sep 2026 09:37:02 -0700
Message-ID: <20260929163800.1108305-60-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929163800.1108305-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260929163800.1108305-1-stephen@networkplumber.org>
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

hns3_parse_dev_caps_mask() does no validation whatsoever: strtoull() is
called with neither errno cleared nor the end pointer checked, so
"dev_caps_mask=junk" is silently taken as zero and "dev_caps_mask=-1"
wraps around to enable every capability.

The value is documented as a hexadecimal mask, so use
rte_kvargs_handle_hex64(), which reads it as hexadecimal with or without
a 0x prefix. The documented form "dev_caps_mask=0xF" is unchanged, and
so is a bare "F".

Note that hns3_parse_devargs() discards the rte_kvargs_process() return
value for every argument it parses, so a malformed mask is now reported
but still leaves the default of zero in place rather than failing probe.
Propagating those errors is a behaviour change per argument and is left
for a separate patch.

HNS3_CONVERT_TO_HEXADECIMAL loses its last user here, and
HNS3_CONVERT_TO_DECIMAL lost its own earlier in this series, so remove
both.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/hns3/hns3_common.c | 18 +-----------------
 drivers/net/hns3/hns3_common.h |  3 ---
 2 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/net/hns3/hns3_common.c b/drivers/net/hns3/hns3_common.c
index c21740ba5e..35cc3fca40 100644
--- a/drivers/net/hns3/hns3_common.c
+++ b/drivers/net/hns3/hns3_common.c
@@ -205,22 +205,6 @@ hns3_get_io_hint_func_name(uint32_t hint)
 	}
 }
 
-static int
-hns3_parse_dev_caps_mask(const char *key, const char *value, void *extra_args)
-{
-	uint64_t val;
-
-	RTE_SET_USED(key);
-
-	if (value == NULL || extra_args == NULL)
-		return 0;
-
-	val = strtoull(value, NULL, HNS3_CONVERT_TO_HEXADECIMAL);
-	*(uint64_t *)extra_args = val;
-
-	return 0;
-}
-
 static int
 hns3_parse_mbx_time_limit(const char *key, const char *value, void *extra_args)
 {
@@ -341,7 +325,7 @@ hns3_parse_devargs(struct rte_eth_dev *dev)
 	(void)rte_kvargs_process(kvlist, HNS3_DEVARG_TX_FUNC_HINT,
 			   &hns3_parse_io_hint_func, &tx_func_hint);
 	(void)rte_kvargs_process(kvlist, HNS3_DEVARG_DEV_CAPS_MASK,
-			   &hns3_parse_dev_caps_mask, &dev_caps_mask);
+			   rte_kvargs_handle_hex64, &dev_caps_mask);
 	(void)rte_kvargs_process(kvlist, HNS3_DEVARG_MBX_TIME_LIMIT_MS,
 			   &hns3_parse_mbx_time_limit, &mbx_time_limit_ms);
 	if (!hns->is_vf) {
diff --git a/drivers/net/hns3/hns3_common.h b/drivers/net/hns3/hns3_common.h
index 7b3f96b01a..967cde9e39 100644
--- a/drivers/net/hns3/hns3_common.h
+++ b/drivers/net/hns3/hns3_common.h
@@ -9,9 +9,6 @@
 
 #include "hns3_ethdev.h"
 
-#define HNS3_CONVERT_TO_DECIMAL 10
-#define HNS3_CONVERT_TO_HEXADECIMAL 16
-
 enum {
 	HNS3_IO_FUNC_HINT_NONE = 0,
 	HNS3_IO_FUNC_HINT_VEC,
-- 
2.53.0

