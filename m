Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1CFC83F22
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Jul 2025 16:17:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3030540663;
	Tue, 15 Jul 2025 18:17:13 +0200 (CEST)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com
 [209.85.219.47]) by mails.dpdk.org (Postfix) with ESMTP id 0D4F340657
 for <dev@dpdk.org>; Tue, 15 Jul 2025 18:17:12 +0200 (CEST)
Received: by mail-qv1-f47.google.com with SMTP id
 6a1803df08f44-702cbfe860cso53406746d6.1
 for <dev@dpdk.org>; Tue, 15 Jul 2025 09:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752596231;
 x=1753201031; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eUZCv7JfSH1Pqlfrhim8mO7FN121qgtWdXLSeZz07nY=;
 b=bTamX/xtkZihh/iheIpEiXIUdEBvXLu7zPR3DL2LiR0JLiVdMWnHeDi9/zKBhaVaFT
 FSv/0ixRNNPiPIvmC9H7CWZLn1j2waeSH5hW8MIZHTWFAva5mE7QiAi1K29KkdLm/v1p
 tuEJj4T76SZo8zC/RcpD2LISO1rD5oOMRSume332z8MTKG4lyIObYqV/5irRF6fsWhm+
 P31HXSwLQlmDEaHzmgxnr9jwu5R3H1WtpUBPJ/cwBNpXnAPxHV45bqZFUgIlrMaa4Hgr
 F2KPzVfBeQ3NPg1LJChGWbanAUQsnjJ+krFhWUHX2K1PFBDRiHbvgsm9OcVD8Oh9AzYU
 ogEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752596231; x=1753201031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eUZCv7JfSH1Pqlfrhim8mO7FN121qgtWdXLSeZz07nY=;
 b=Y/+ahZuOnOsleP32x7Cjywv79UwVpn2vvYiBmJx81b1+7jqH4EeVEe6p+yZfj4W5LQ
 pOL2A5R24G1ei6Uevh7dAE2vBDYMnvGwelYlByR1C9IaGAONZLKsmGSdXe9t85NGtxoo
 nJ4vNDis10VfGkb32cH4npQYnJT93TPslu7c4Ywxz0jGOn1aeoO5dxTuj/g3ggeK9xoo
 aUIT++UeITX+A8cE48s/F7/2pawY/UFo4/Ml3jjNDK4rI5CKs05fAVSwWanjMVfYIcQ5
 My3zNFb+CzFpFcURvbVxff0NaBjOD2f9qo2FDKZeJlOLARApwiI67msuPEdn73moiKQX
 8Ong==
X-Gm-Message-State: AOJu0YwbkFdkZAQILbZwnNE45ARXY+9wxULj2IyoW8FyBlxANmNXxf8R
 P/lZtrPHy2nNvwvQf9xOHjSzG6h9COP8m10enc4+5Wrh+C80Jiz1MnKXsvUzIUwrz2sS8Ie0jTM
 2IFsM
X-Gm-Gg: ASbGncs+VjGcXf4VLCLpDy7yaH7qMVGSHImbL7HEorRMiboPhY0g22I7Dbite5hRUlv
 4XdNvximd4Vdj/kXrT5tr1ZPGycguuCK/MD7m30wYx119up4+GRfE1xZoL8IqShzhr+FvfsM5yI
 EN7iU3drIsusFNi84eqV/y8trqhl0cGidSaOrDxTVtaDLYtjX13KpO7YM1JjeAOffKp6jt0DOAR
 G8zqcHt8z+shN7DEtWGU9zQ9fhPm90CC7c4jrubnA5FVyAeC9Hgsy/OsOGk141sR/4cKEjytC0F
 29E2j+GMHNnyR8JCwGaIi+2VksNDsB/RUpcetKvYVHcckRW0aFh4Y1gtHnVa9JNLvkYdYxP9HVa
 4Sh6wQV2HuJa6aXSTlfbB+Ef16SmI4tF1uus8PncVEZgMvU+keJdyMNGkK4MBAwjIUfXpwvJT
X-Google-Smtp-Source: AGHT+IHO+XGW3MPNq2KcHBNnAxDbKwrqiVNbg92lgY28MclMPdtkd4jQOQNROwFBgMIVoSECUNWy6g==
X-Received: by 2002:a05:6214:1248:b0:704:8e3c:7b4d with SMTP id
 6a1803df08f44-704f47fa528mr1148896d6.4.1752596231134; 
 Tue, 15 Jul 2025 09:17:11 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-704979a8857sm59985106d6.9.2025.07.15.09.17.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jul 2025 09:17:10 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 05/13] net/ring: add new devarg to create vdev from
 existing ring
Date: Tue, 15 Jul 2025 09:15:43 -0700
Message-ID: <20250715161700.103209-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250715161700.103209-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250715161700.103209-1-stephen@networkplumber.org>
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

Need ability to allow process like dumpcap to make a ring ethdev
with a pre-existing ring. Do this via devargs so it can work
with hotplug.

It looked like the API rte_eth_from_ring() would work for this,
but it doesn't do the right thing. That API makes new vdev but
names the ring based on the parameter.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/ring/rte_eth_ring.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/net/ring/rte_eth_ring.c b/drivers/net/ring/rte_eth_ring.c
index 966c64d9a5..94a739a925 100644
--- a/drivers/net/ring/rte_eth_ring.c
+++ b/drivers/net/ring/rte_eth_ring.c
@@ -23,9 +23,12 @@
 #define ETH_RING_INTERNAL_ARG		"internal"
 #define ETH_RING_INTERNAL_ARG_MAX_LEN	19 /* "0x..16chars..\0" */
 
+#define ETH_RING_RING_ARG		"ring"
+
 static const char *valid_arguments[] = {
 	ETH_RING_NUMA_NODE_ACTION_ARG,
 	ETH_RING_INTERNAL_ARG,
+	ETH_RING_RING_ARG,
 	NULL
 };
 
@@ -693,6 +696,20 @@ parse_internal_args(const char *key __rte_unused, const char *value,
 	return 0;
 }
 
+static int
+parse_ring_arg(const char *key __rte_unused, const char *value, void *data)
+{
+	struct rte_ring **rp = data;
+
+	*rp = rte_ring_lookup(value);
+	if (*rp == NULL) {
+		PMD_LOG(ERR, "ring '%s' not found", value);
+		return -1;
+	}
+
+	return 0;
+}
+
 static int
 rte_pmd_ring_probe(struct rte_vdev_device *dev)
 {
@@ -770,6 +787,18 @@ rte_pmd_ring_probe(struct rte_vdev_device *dev)
 				&eth_dev);
 			if (ret >= 0)
 				ret = 0;
+		} else if (rte_kvargs_count(kvlist, ETH_RING_RING_ARG) == 1) {
+			struct rte_ring *rxtx[1] = { };
+
+			ret = rte_kvargs_process(kvlist, ETH_RING_RING_ARG, parse_ring_arg, rxtx);
+			if (ret < 0)
+				goto out_free;
+
+			/* Note: rte_eth_from_ring() does not do what is expected here! */
+			ret = do_eth_dev_ring_create(name, dev, rxtx, 1, rxtx, 1,
+						     rte_socket_id(), DEV_ATTACH, &eth_dev);
+			if (ret < 0)
+				goto out_free;
 		} else {
 			ret = rte_kvargs_count(kvlist, ETH_RING_NUMA_NODE_ACTION_ARG);
 			info = rte_zmalloc("struct node_action_list",
@@ -843,4 +872,5 @@ static struct rte_vdev_driver pmd_ring_drv = {
 RTE_PMD_REGISTER_VDEV(net_ring, pmd_ring_drv);
 RTE_PMD_REGISTER_ALIAS(net_ring, eth_ring);
 RTE_PMD_REGISTER_PARAM_STRING(net_ring,
+	ETH_RING_RING_ARG "=<string> "
 	ETH_RING_NUMA_NODE_ACTION_ARG "=name:node:action(ATTACH|CREATE)");
-- 
2.47.2

