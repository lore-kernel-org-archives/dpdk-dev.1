Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C52CA5FA7
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:41:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7457C42ED3;
	Tue, 29 Sep 2026 18:38:53 +0200 (CEST)
Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com
 [74.125.228.38]) by mails.dpdk.org (Postfix) with ESMTP id 5180D42670
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:32 +0200 (CEST)
Received: by mail-pz2-f38.google.com with SMTP id
 d2e1a72fcca58-8814e797a5bso1718340b3a.0
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699911;
 x=1791304711; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FIM6488D6qTetDQW9M0Cf2sbxffrsKHjsFxK0ebGjWE=;
 b=UYjOhxZu1ciGeEpMgyyuJf0Jf5Ni/gpazfQMWWEBQYSZuYlPluhV178mrqACdw1hr9
 qvlLEVICgqPBfrhg3qFE0GZrp4PCFqRy0/HJ/Vh/0lZScdNFj/YkpTM6qmTIK7kkSAjE
 /U0+zctv6k0AX/MieWd+FVfWxe4TEe0mQI1/yqc7/l5XYS9QdPf+95q8BdQL7s98rgob
 sF2Fa/XpasI0X9LQGy9/RZ7KZ9XGBzZqobzmvTZN1CWPxyPSaSsloD37Q/nJcPEuaByd
 LYBitt+miIC6epI8Xk5mm6sY6K6sUaEo0qyEfatd6DCed4yTyaBCCt/KSVxVkaplx9f2
 BTNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699911; x=1791304711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FIM6488D6qTetDQW9M0Cf2sbxffrsKHjsFxK0ebGjWE=;
 b=o9gBAi5atqT8hIHmMoXuqUkhMQixmH0mmq6InywmHkAUKIngP4K7vpWIcOJ7WuiuRC
 ArdaZFLTNJEbrmaH9NvRfPvnrBf1I0JpjKgqrMdBA3fTxrhtLCe0lXmflsRAw4cs0kMs
 hm20EVqfmnufDC84S2PODI0SGOyVpw4CFO15f5XXugQTqY9KaYLJt1r4NSM+BkF7OvBo
 9Rh2EgY12DEofGLg4jSDh0uLyl/ovfzqQ4XStV6Og6JDQG7i+qDJ58QQMDLS4BbrhUiI
 1TzTMMa1FbiXIoWX10w+hCsbTUFbzFiBsdEjyTWRPHl3FOTnIp6fGm8CNwmtd5pMMzye
 SUXg==
X-Gm-Message-State: AFuF++nMtbRcK5KnkbzdRLI8AvA4McmIGNYsCwYj2kggWGcW5Y3CEGun
 +YysYoEdM9IPOo6gXot11oJl6bgyzrlIfVNp3H+vvoz3dd6mDbYQgSTnMf3Jo27MZbAo+q9RxyN
 2km2GBKE=
X-Gm-Gg: AYBFou1z158ie4KGdQrsfx3gnq8nlNL1eT43c7JXt115fxYa82Vv4pLqNudRmzqEwau
 aor890AVjnCNo2siCzzwlhutLYJcibrD2dx8WnNqlIRSFjatWV+NUXEE9DzHbArrclLxglcx+Hq
 8Yi+RmECj12h6Sjg2A4Pl32L8G+Y+QAePYWnjLLFHMkdgBNezrx5XhnowADCTlgEJ/FeQgkBJW8
 YIAKwQ1GrQY6zI8kkRCBLNTyLUCWtXIPwPkjlF0qRyNKr9ANhoQjXaNZC0KVZVMxOCZmEnK6Sq6
 NwV51gK1d6DPEBc5TR9Lsq87AiBPn+1kSdkUoMuKnRgg5N4lVL5KmRCoCKdN5Bl9uRa++c4zahD
 xg8rUgRU+gruQ1NmeEb9hAsZgMw6PW+3j2HmKE82l+rb2I6qffqioRb+y6XlJphbKVKSrsxM/Jp
 oRNdIixIYjjBe35BgdBvcqygc2oBsTuUHPxRCSviagc5glXyk9o9XUli9YZXl4bJ7GWiuVANHUH
 nrPuPyzPghr/s3BTRndrZYc12pLLz5ntdVJ4w==
X-Received: by 2002:a05:6a00:94ce:b0:885:1c17:f794 with SMTP id
 d2e1a72fcca58-8851c17fc2dmr3410919b3a.44.1790699911472; 
 Tue, 29 Sep 2026 09:38:31 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:31 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jingjing Wu <jingjing.wu@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>,
 Beilei Xing <beilei.xing@intel.com>, Xiao Wang <xiao.w.wang@intel.com>,
 Junfeng Guo <junfengg@nvidia.com>, Xiaoyun Li <xiaoyun.li@intel.com>,
 Wenjun Wu <wenjun1.wu@intel.com>
Subject: [PATCH v2 26/61] net/idpf: use kvargs numeric helpers
Date: Tue, 29 Sep 2026 09:36:29 -0700
Message-ID: <20260929163800.1108305-27-stephen@networkplumber.org>
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

parse_bool() only tested errno for ERANGE and ignored the end pointer, so
"1junk" was accepted.

It also stored through an int pointer, but both device arguments are bool
fields, so parsing either wrote four bytes into a one byte object.

The handler did nothing beyond a range checked store of a boolean, so
drop it and pass rte_kvargs_handle_bool() directly, which stores a bool
and also accepts the usual spellings such as "on" and "true".

The booleans use rte_kvargs_process_opt(), so that a bare key with no
value enables the option.

Bugzilla ID: 2042
Fixes: 549343c25db8 ("net/idpf: support device initialization")

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/idpf/idpf_ethdev.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/net/intel/idpf/idpf_ethdev.c b/drivers/net/intel/idpf/idpf_ethdev.c
index e9e9781fdd..b3020fcd7c 100644
--- a/drivers/net/intel/idpf/idpf_ethdev.c
+++ b/drivers/net/intel/idpf/idpf_ethdev.c
@@ -3,6 +3,7 @@
  */
 
 #include <rte_atomic.h>
+#include <rte_kvargs.h>
 #include <rte_eal.h>
 #include <rte_ether.h>
 #include <rte_malloc.h>
@@ -1244,27 +1245,6 @@ parse_vport(const char *key, const char *value, void *args)
 	return 0;
 }
 
-static int
-parse_bool(const char *key, const char *value, void *args)
-{
-	bool *i = args;
-	char *end;
-	int num;
-
-	errno = 0;
-
-	num = strtoul(value, &end, 10);
-
-	if (errno == ERANGE || (num != 0 && num != 1)) {
-		PMD_INIT_LOG(ERR, "invalid value:\"%s\" for key:\"%s\", value must be 0 or 1",
-			value, key);
-		return -EINVAL;
-	}
-
-	*i = (num == 1);
-	return 0;
-}
-
 static int
 idpf_parse_devargs(struct rte_pci_device *pci_dev, struct idpf_adapter_ext *adapter,
 		   struct idpf_devargs *idpf_args)
@@ -1307,12 +1287,12 @@ idpf_parse_devargs(struct rte_pci_device *pci_dev, struct idpf_adapter_ext *adap
 	if (ret != 0)
 		goto bail;
 
-	ret = rte_kvargs_process(kvlist, IDPF_TX_SINGLE_Q, &parse_bool,
+	ret = rte_kvargs_process_opt(kvlist, IDPF_TX_SINGLE_Q, rte_kvargs_handle_bool,
 				 &adapter->base.is_tx_singleq);
 	if (ret != 0)
 		goto bail;
 
-	ret = rte_kvargs_process(kvlist, IDPF_RX_SINGLE_Q, &parse_bool,
+	ret = rte_kvargs_process_opt(kvlist, IDPF_RX_SINGLE_Q, rte_kvargs_handle_bool,
 				 &adapter->base.is_rx_singleq);
 	if (ret != 0)
 		goto bail;
-- 
2.53.0

