Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA554CA5FC5
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:46:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0720C42EF6;
	Thu,  1 Oct 2026 00:44:15 +0200 (CEST)
Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com
 [74.125.227.167])
 by mails.dpdk.org (Postfix) with ESMTP id 9A3DF42E46
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:44:12 +0200 (CEST)
Received: by mail-pj2-f39.google.com with SMTP id
 98e67ed59e1d1-3a49b6bb21eso1913879a91.3
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808252;
 x=1791413052; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FIM6488D6qTetDQW9M0Cf2sbxffrsKHjsFxK0ebGjWE=;
 b=vZkWHSKMFtfQcWJibzvpdWPEl2MRWgjrA8wticG9svvTK4VKQ0LR/xalEBIawt9Qza
 CwQfMxeWUDji5XBmevfwNjGfGlTc36YvxtrDC3YhqMw7q+i46ylNQ5PexOUDCgTDmtWj
 Du/e4240VrHVZnyxtb+mUQx/L9lgAI8xbmL4zbMhC+rw1jxytM7bX9wWO5g5wt5FLZyN
 nPsog3kjR4GZFb8Qwxlu3/eyImvvpmebSmdw2LhFFtOdQF+4iqyQbCxHrYt6FD4eTyo4
 R+ui11luOjLYAGu23j6Q/jl8uVWzNHvteSEmY7T5yuLmeEIV+oXwa0l75Jle0yBj2utK
 30qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808252; x=1791413052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FIM6488D6qTetDQW9M0Cf2sbxffrsKHjsFxK0ebGjWE=;
 b=oTp3MCOZB7ywyzejyvgQewFw16RIZ7yenIyv0D/qSPqevm1TQ/yde1oZYyxAVuASCs
 j8i9WHYKaXomt+iRT6PE9fyjUM6OcOeSMfZSfzW2OxoriXCfwoqBO2/2osmiHd2lhLng
 AbTEy6yM5QO9sbwcslYWDoqiWU1ibdoSVkbPMWXPyzu+WcLs+bl+99SemO02K9DFXfMl
 rBIL4aAVZHVQcJEoQ/S7iCyW7AHceXJl166NMkuJzcRWtdCU6xD0e01uCkSO6AlwJNFj
 wzeNIDjJOWtst3Vs+Ku4+A2A6SD6gEc4aemobuz54hLJ36qNawnCn3rq43jEsod7mEpg
 6xdA==
X-Gm-Message-State: AFq9FYLAHPHWTRxfO8QkNij3iRB2YL05a3vmlnyJCI3zi1ECS/Q44ojU
 azizd1CzUAJ2hlRh0lJPnpVJ0Mf0eGGKT6JYuM1X3aLmFn7h7GQtxx0197Y/MD82MKMDgcCnwJ1
 kvLl9LiA=
X-Gm-Gg: AYBFou2iQnvCdu+zNe6b+loXZ2FbhkOCJ4S8j8YFOC8bXj+nPNxwezsZzpZNH8TiSxU
 xQ+WP+jCG+bSt+nJf270durjKrLP8eZxEyUda1chSRk8vOmRCWbxDVOE7EHGwS3P4+qYCkiBXbG
 MzoSD6si7WmleKCz1sz94vJf8E/DuO2HD6h2aNy2Vi38/MS5H74ZDdtXEgQqdWqmw4zedGg4OH2
 c/4V50jrK6xis+nlN2qy5OhxEdx6l/oBDqZYEDnlsJooPmaGHuGjeBUebIRxvKVS8vk3Hnz+ntF
 K2SRucJhVfd03qbljPi1/8CxJpr4bdLu0VEuAyO3aTtNm3tPyFD1KuHFNi7PWPE0O5Z8CJc5l4W
 d4X6AbUMJeqGu0pUSlK2MvOc3oE3uGOHJ/kgMEu4H6l7S2X7Yu99hc0iro5y4X1IkVSmiBQ6U41
 qrBAq2INAMRfgjiBvWILmgRGP5heC8BOpR1ZvRFip6j4fzVm1LTbS/7DszmlNCwP3zSvEmySpcw
 +PCwXpQxR1DjcYgyj1sr8oVeHifxCUsJcbob3w=
X-Received: by 2002:a17:90b:2885:b0:3a4:967c:6947 with SMTP id
 98e67ed59e1d1-3a4d1540282mr1540568a91.21.1790808251344; 
 Wed, 30 Sep 2026 15:44:11 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.44.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:44:10 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jingjing Wu <jingjing.wu@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>,
 Wenjun Wu <wenjun1.wu@intel.com>, Xiao Wang <xiao.w.wang@intel.com>,
 Beilei Xing <beilei.xing@intel.com>, Junfeng Guo <junfengg@nvidia.com>,
 Xiaoyun Li <xiaoyun.li@intel.com>
Subject: [PATCH v3 27/65] net/idpf: use kvargs numeric helpers
Date: Wed, 30 Sep 2026 15:40:45 -0700
Message-ID: <20260930224340.58580-28-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930224340.58580-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260930224340.58580-1-stephen@networkplumber.org>
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

