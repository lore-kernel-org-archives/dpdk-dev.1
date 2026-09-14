Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B66BC88E50
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:52:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 87E8E40A7A;
	Mon, 14 Sep 2026 07:50:54 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 7C4BE406B4
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:50:53 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396ccb1a990so1350127a91.3
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789365053;
 x=1789969853; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eenilwUDzbe1crmjodfJhf6hHMCK9VU3ttB1I1nenxE=;
 b=L4+hVVpT30vj5DvQqrHtkfpVqfcwOmQ7tL8AqWZoR8DtdwjjuXdUO3RgtEfgFT7ScW
 HxzU4yQC+oJdE7RkSv7saV1qp2q60s4tGOz3waNdcJ+s16KfioU7OAKdpeZQgQAV2dLo
 B/PD0u9RAAmuHVGHa/o7EDSvwg0BTqGP/JrZCUduGSbbR+EmGHvu3lgSMxv2Z+T+3qnm
 fi8cljqvDD2FIzD+LNvMzIUsX8qNJ25EC+Di6b+k8TdMtubJ7tKUE0v3D635LRSQPdEr
 D9jBXOf2Iz5L9887qxMFGvKYK844KATmo4Y0YlZ2TitG/GWjh/LgGjaCQ8jPWEr+Rl+5
 1NTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789365053; x=1789969853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eenilwUDzbe1crmjodfJhf6hHMCK9VU3ttB1I1nenxE=;
 b=RLw3dLCrB6VYhEVUK6NIPnaE3DXYcqiOvDfUB3GhDbtcUzARlrrdt539yK6ePdcEVu
 uo3LSgQiZPngR4K7/3AA9IYQpQ/MTgOTAvyagFRGNMt8i4FmfPkoFcdU80ykYK9Vcpjp
 Y2Ll1VdgT9HFMqot0yGislW2+Sg3BiRHW7PBXBGT3JcTeFLdQ1fld3a57YFcoTgYLKnm
 plIwBOD2q3KKyJiA0xERLN1XgVwDWhv1PXTHYfiQVXfh/PGNpRUn+BlLbY1RLqZJppQi
 BhaYLsrTPhIaR+lENQ5jPLmT9o93hDGWGWl3/9xncx+2jZ9k2o3VijTs3eW2Sng/yxQH
 wLKg==
X-Gm-Message-State: AFuF++n78h4jksF77Ybr/yc/9vrch0ZKaBSshXJh+n7oJajC/qUc2fEW
 BcZ8paA4aDHt0whIAYksfZ9KB+kFyeL7FJj1K9CbVOGAlVZXOK7rHGnnlX0YpP9XzTCckncPxGq
 ZG7D2
X-Gm-Gg: AYBFou3DpoQlGJAoSPW/EMiiwl5DYRRwahTzDBqEGRgiI8UrE9kWKqEMrZ+LY4DtwDo
 ER1xdq7rP5ES+nIW2zspTLZbQp1mxFUhtx/7cMO/r18yGZ1gnGa1n7P75oNrfn6u1HCtZdVnGXk
 rqMhACzcc3wy+uLeqEgQpVXlcGgmXEvCjTjcSx+tfoEUvbz8d9beuLQSBZAlrY7D1nVtqPTA1zF
 wi1tJUC7hMzcls+oKfolWDlZvQutjxrzhjJajDclGqS9XkOKc3kFLX3MwKEjLkBXfo42UJf3Mho
 9ATNjOcwq/5Mp8/4YNJhz4ohpx+6YsPD+7068alk8uQaucv9NSmMVsUHCztbqgR7zhVu/Q5hsNi
 mXMzGc6xw3tEZ3AFu9utPHQRCGKMY3+Jza70YFcSg9QSc2EL+EYWFqYVFDIJL9VIS+ZJebKMRha
 3UEic8u4opT9MB/g3CLWvOdb9fv3vyfjRCzuaCopv/vGBzdOJC3lQOKwM6m5XrD1bp6zpezUpO5
 BfhxUw/lF2AX1rlvt3JAABFnY0e8X3Ocr++Cg==
X-Received: by 2002:a17:90a:ec8c:b0:39d:f130:8ef8 with SMTP id
 98e67ed59e1d1-39df130d538mr616631a91.23.1789365052625; 
 Sun, 13 Sep 2026 22:50:52 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.50.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:50:52 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jingjing Wu <jingjing.wu@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>,
 Beilei Xing <beilei.xing@intel.com>, Wenjun Wu <wenjun1.wu@intel.com>,
 Junfeng Guo <junfengg@nvidia.com>, Xiao Wang <xiao.w.wang@intel.com>,
 Xiaoyun Li <xiaoyun.li@intel.com>
Subject: [PATCH 27/62] net/idpf: use kvargs numeric helpers
Date: Sun, 13 Sep 2026 22:46:58 -0700
Message-ID: <20260914054912.755403-28-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914054912.755403-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
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
index c13505416a..6aad5c5008 100644
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
-	int *i = args;
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
-	*i = num;
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

