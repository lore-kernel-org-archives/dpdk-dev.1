Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAF4CF9C42
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Nov 2025 16:23:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 53EF0402E3;
	Thu, 20 Nov 2025 17:23:37 +0100 (CET)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mails.dpdk.org (Postfix) with ESMTP id 84B4F402DC
 for <dev@dpdk.org>; Thu, 20 Nov 2025 17:23:34 +0100 (CET)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-7b75e366866so513991b3a.2
 for <dev@dpdk.org>; Thu, 20 Nov 2025 08:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763655813;
 x=1764260613; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HZrNRy62Y/3uEVlnGGFDz0O+sNq5b+/fNCoB1oR2J8c=;
 b=POl8GlYSvU5lPK3msOPI4lWH9p/Lwt/+s0SIwOgc70PNyq+4Ole5G4ijNmVlblyW5D
 PUYtcwk3hBw+KYoOalQNUzyS9D1QgbAHsw20Syb+2Opk8S99mwvCmevTl4CjocYh2cUH
 JVRyB453s5JCezgvikDTLfm0cZEMCqj5RnqT+KlFTwrC6aqLhlNIpUApf/XXbyQ+pgMk
 BzmcTfaz275sFfxYWCpnv98+WW+jcw/Fuc1nC2bpkKb9J00GZSZCfMay6YiksafhcCi1
 JxyHBVWerEn9f2ovvAGtmgGUxF2QMRIKBzAZAKd/11OEiVpv177b/Lndwx0mK8Cszs3c
 vUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763655813; x=1764260613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HZrNRy62Y/3uEVlnGGFDz0O+sNq5b+/fNCoB1oR2J8c=;
 b=ove2TnT1vs9U5SSi2o3L/aLaXShb0uexqw4VOYc0jNbuMnQijYKYxb964CP9xmYQqz
 3SSLshqZB+juWPgtl6281OBT0wAlu7h36kltQ8Mr0IEcSpirAAoCcD+/YojMnDYbZsJ/
 v9ckLka0lbIt9q9flndNW+lqIRu5eRjLamVOIsgYZ96E88Egr8s0YV4wUZQpZ30namlY
 6hP7hxyi47xVJ6guaV3oGj1n28iH50JMobUPawksDhvhpNo8NuhBE4ZFG8TEH59TVpDn
 TqIWpMT0c8G8IKYECbv84/w7mFW5niuNWclsjlEMa6hC6rPD+TXAF1qC2hAgrhqr6EnX
 k1uA==
X-Gm-Message-State: AOJu0YyWvG4E9IVbZjSDhiYvRdJABRhiUxJldJD+nRBGD3ftCWNTOwfe
 tLcHchCfwwYBOY8rLagKtdJlgxWRzzlRUgUGwVhG2ucl4xNpf3QtPJWMemM+tSDG9I9xrtRfbFo
 zHhjh
X-Gm-Gg: ASbGncvnNN21WVZRAoUE/QpcjBfJ5RGJiZv5WAg8/1Ljb/CXja/6QYAWDKdjFCMc73X
 IljqkCeFhbW7WsjNdiXFSDBqZjHG8tKQ3Mr1AZQeGqRfXOacm4Y50JkXTDHtCztWmyS5/rh2CMu
 VYL8aY85J9dDH90bqywqH26HeyAn2FyIpPSPZP/AyQ3VDsQN6Mnok9GPoAqL5ZLcHIODBeXrxtH
 6kSbE1RmOfXXrMOKJ61yWmdxw+caiLOnzM5DPM2Zltf+8wSwaDQclqCm1+nzt45ZAM+aTsJoqts
 ShX1xfRPb9jEyJ/1Kq5/g964FC9TkCqMojjSvsNPUWPukDeSwyISqlQUT6kj3lG3WbccU1GoEgp
 gs7jsAqazfSm6tcc44ihwF946UAh+2pRLN1TwUoOsLl8E5gTXXq9qHHTf4GW4yazToxtNDfe8+h
 YvtNAP93PVdU4n01zz4TkmqilmNMglWozrySUPrY0p+6bIgj2SJA==
X-Google-Smtp-Source: AGHT+IEQIPmMlr1jo5iXTm374DUH84TSpWj5ABv/0wUpx/Dk+h1Lf8olWYN357n04y2NZqd4F/uOXw==
X-Received: by 2002:a05:7022:fb07:b0:11b:9386:a388 with SMTP id
 a92af1059eb24-11c938aff99mr1264727c88.43.1763655813163; 
 Thu, 20 Nov 2025 08:23:33 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11c93e3e945sm12096427c88.6.2025.11.20.08.23.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 08:23:32 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>,
 Byron Marohn <byron.marohn@intel.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Saikrishna Edupuganti <saikrishna.edupuganti@intel.com>,
 Christian Maciocco <christian.maciocco@intel.com>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>
Subject: [PATCH v4 1/4] examples/server_node_efd: fix format overflow
Date: Thu, 20 Nov 2025 08:21:59 -0800
Message-ID: <20251120162327.78062-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120162327.78062-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251120162327.78062-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

If format-truncation is enabled, the compiler detects a string overflow
since the snprintf() is putting ethernet address and new line
in buffer only sized for the address.

Since get_rx_queue_name() is used to create a ring name.
The buffer should be sized to be a valid ring name.
This fixes some format-overflow warnings and also corrects
for future errors.

In file included from ../examples/server_node_efd/efd_server/main.c:31:
In function ‘get_printable_mac_addr’,
    inlined from ‘do_stats_display’ at ../examples/server_node_efd/efd_server/main.c:136:3:
../lib/net/rte_ether.h:248:36: warning: ‘snprintf’ output truncated before the last format character [-Wformat-truncation=]
  248 | #define RTE_ETHER_ADDR_PRT_FMT     "%02X:%02X:%02X:%02X:%02X:%02X"
      |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../examples/server_node_efd/efd_server/main.c:86:33: note: in expansion of macro ‘RTE_ETHER_ADDR_PRT_FMT’
   86 |                                 RTE_ETHER_ADDR_PRT_FMT "\n",
      |                                 ^~~~~~~~~~~~~~~~~~~~~~
../examples/server_node_efd/efd_server/main.c: In function ‘do_stats_display’:
../examples/server_node_efd/efd_server/main.c:86:59: note: format string is defined here
   86 |                                 RTE_ETHER_ADDR_PRT_FMT "\n",
      |

Fixes: 39aad0e88c58 ("examples/flow_distributor: new example to demonstrate EFD")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 examples/server_node_efd/efd_server/main.c | 2 +-
 examples/server_node_efd/shared/common.h   | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/examples/server_node_efd/efd_server/main.c b/examples/server_node_efd/efd_server/main.c
index 75ff0ea532..62c3f4a16d 100644
--- a/examples/server_node_efd/efd_server/main.c
+++ b/examples/server_node_efd/efd_server/main.c
@@ -68,7 +68,7 @@ static const char *
 get_printable_mac_addr(uint16_t port)
 {
 	static const char err_address[] = "00:00:00:00:00:00";
-	static char addresses[RTE_MAX_ETHPORTS][sizeof(err_address)];
+	static char addresses[RTE_MAX_ETHPORTS][RTE_ETHER_ADDR_FMT_SIZE + 1];
 	struct rte_ether_addr mac;
 	int ret;
 
diff --git a/examples/server_node_efd/shared/common.h b/examples/server_node_efd/shared/common.h
index e1ab7e62b7..6726e2031e 100644
--- a/examples/server_node_efd/shared/common.h
+++ b/examples/server_node_efd/shared/common.h
@@ -58,8 +58,9 @@ get_rx_queue_name(unsigned int id)
 	/*
 	 * Buffer for return value. Size calculated by %u being replaced
 	 * by maximum 3 digits (plus an extra byte for safety)
+	 * Used as ring name, so upper limit is ring name size.
 	 */
-	static char buffer[sizeof(MP_NODE_RXQ_NAME) + 2];
+	static char buffer[RTE_RING_NAMESIZE];
 
 	snprintf(buffer, sizeof(buffer), MP_NODE_RXQ_NAME, id);
 	return buffer;
-- 
2.51.0

