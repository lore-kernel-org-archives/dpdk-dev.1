Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7409FCEFCEB
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Jan 2026 18:34:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0343940E44;
	Tue,  6 Jan 2026 19:33:34 +0100 (CET)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
 [209.85.208.52]) by mails.dpdk.org (Postfix) with ESMTP id 87FC440E37
 for <dev@dpdk.org>; Tue,  6 Jan 2026 19:33:32 +0100 (CET)
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-64b9dfc146fso221396a12.0
 for <dev@dpdk.org>; Tue, 06 Jan 2026 10:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767724412;
 x=1768329212; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tquIIG4S57JwWVztirFWO7sI/7fexHke+mJcTKFSVtc=;
 b=Rdjau1CNOfgUUEqKRE1C5nNYkc3cyGRmjAlVFOLOd2M/V2MfZfxereP7c3zzCF364T
 me/HkZ/pGqd10sPQqy40IzlEWE3k30wimbiz9gDnpAEnjaHbDPfZzXqU5GUeAYtSAfk0
 5IkAq2yusTmYupQEvBzxH4IyBJD1IQozahAeJ1D6wHDjMjMF46vDIObyA/qryEjQEOL5
 cx0KIFb/ECvZYA00s/lTiZyQQZqk1ijXZl3kQD4YWeYhO+Zmi5EGnaQnGBlyhp++RvCv
 UUCCQnN8SE3wS02sZNauSBpXD6B0vdEZ0wXmkTKBxc5ON/E7ylkVm+cSDIUxzz96g8gI
 voSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767724412; x=1768329212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tquIIG4S57JwWVztirFWO7sI/7fexHke+mJcTKFSVtc=;
 b=Sje+/v+ncWM+8f4eF0KfRLo5yY2cFF6tFdcuGVLIXvmfrplc6P0LQK1RJPzbtK6dlN
 tXkglIzgv52rmhvfW8tMeRvFkpPtnGbt7NazW7/X4xvad1Aj67DOmWEQ3IDTVbVW49UH
 cZat0X+UgIEj8GkHmJA3a1of2/f9vhESwA9DIRUcdHU8QWE7Y5rMg12jbN+isOmGqDkd
 ie4zFMCnoOCgiJwdbeothKHSJKCeqcgf5htTqC/Vd8LdflBu1pqIZkxVY1gt9lWp129q
 H8WJzokFolFr6Y4pCXe6QEFmGguSmFYOX8POHlsm8Usa9t+niS1zvLBtEfNhjZYdKfui
 aRog==
X-Gm-Message-State: AOJu0Yy23UJrFU5etX2sNCgunn9SrXrVhsJdRnI3RECHaF+x0uddKNnx
 syFKcF3lnxU5GAedHB1K7FaVWxo2pap0swBliRXOjBxrXvZIJJqJn7XNIu0cTlgVRLRBSP8LWaq
 ypzMbCDA=
X-Gm-Gg: AY/fxX5QfKrF4wIfxOFMXFgOfqk+5yLCyEP0vNDH1cBGVzZxxMdNHqvCoYFmzLvCNi/
 xhBAl29Bz9Vlqc7FG5Kc9YiwpKAy23+t6HXrKSlKYAhIYkrVjW/e9lKkhqBeFq3yMvysbHH0NvC
 09LHhQnIEffHQSc8XTjTp4gYKqclicyeeYO+vllvnzqfdJaafxM6buixwdPuzPsiwEb39HI39IU
 lNr1YpGoQWQYcpa8k5y05GhYdEwhqcK9KSAZlQZX9NBASyCwYKIvAO9jhGtdOphiyR8pTwC/37Z
 ONSNwC9oxyCv/99tT5DTIzY/pFCk4HGSbpV8FMlvV0y6d3KyShQPXjrS8EnBibnsGk7esyZLfja
 FBuNVal3jX/+9r2xS80CR9sSe1Ln1VUI3/GecdNIdECYZtBHievMGnX2GvHO4Ci5TjvTI4XVBuA
 8nsXZXbyBK067XwLnKYlwftbEvysdAYJUAyLa/qSNXpLBtAg/IBg==
X-Google-Smtp-Source: AGHT+IEauYD5BLxK1Hjam/6G4wB1WW0JI7TmFMHlP1cVfncLvnfm5cwCB6M+0tw8Z3d9ImUUDcmPhw==
X-Received: by 2002:aa7:c513:0:b0:64b:aa44:dea6 with SMTP id
 4fb4d7f45d1cf-6507c16e5d9mr2514530a12.15.1767724412074; 
 Tue, 06 Jan 2026 10:33:32 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507bf6d4acsm2728525a12.30.2026.01.06.10.33.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 10:33:31 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 10/12] net/pcap: cleanup MAC address handling
Date: Tue,  6 Jan 2026 10:26:49 -0800
Message-ID: <20260106182823.192350-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260106182823.192350-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
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

Use rte_ether_addr structure to avoid memcpy and void *.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 3eb313ebb8..bf863e8708 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -1383,9 +1383,9 @@ pmd_init_internals(struct rte_vdev_device *vdev,
 
 static int
 eth_pcap_update_mac(const char *if_name, struct rte_eth_dev *eth_dev,
-		const unsigned int numa_node)
+		    const unsigned int numa_node)
 {
-	void *mac_addrs;
+	struct rte_ether_addr *mac_addrs;
 	struct rte_ether_addr mac;
 
 	if (osdep_iface_mac_get(if_name, &mac) < 0)
@@ -1396,7 +1396,7 @@ eth_pcap_update_mac(const char *if_name, struct rte_eth_dev *eth_dev,
 		return -1;
 
 	PMD_LOG(INFO, "Setting phy MAC for %s", if_name);
-	rte_memcpy(mac_addrs, mac.addr_bytes, RTE_ETHER_ADDR_LEN);
+	rte_ether_addr_copy(&mac, mac_addrs);
 	eth_dev->data->mac_addrs = mac_addrs;
 	return 0;
 }
-- 
2.51.0

