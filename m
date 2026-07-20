Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A085C44520
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Jul 2026 12:07:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A77B406A2;
	Mon, 20 Jul 2026 14:07:14 +0200 (CEST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53]) by mails.dpdk.org (Postfix) with ESMTP id 82F8140A76
 for <dev@dpdk.org>; Mon, 20 Jul 2026 14:07:11 +0200 (CEST)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-47f73b1ee02so145582f8f.1
 for <dev@dpdk.org>; Mon, 20 Jul 2026 05:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784549231; x=1785154031; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HwhyWGdmsPyAYZrc8LxPh16IDXE2pvDxz1/DQduzxkA=;
 b=rAgbj8UfcbzUDX59UnffcLCsT0CYw53Pvy5/G8SdYHaWoUrsJnHms90oQitL+OASzW
 MTIgmHqo92DSJaV0NzxDBW+dyOGkqQBX1eU/e45P2DnMfM86HW/EC3ZO2p0/i0XTzH52
 FvNLZjDbr7b6uGCbq9gVOSDQecxBJmRQYtHE6U9Z3JIBXP0w8CZLf5YR3A1FbCtIkUx3
 IvgWubEJFHMm6jzq9gC72SVJ7nlvifa9m2YCG9vHywqiPrgyHPD3la2vXZilvoDGOVSC
 M9pLC38TW9Gl+TRtLJLGKMtbu4kCBHZkgNqj9dSlK/wTT98JVxzMroYd9e6s3B0NNnxq
 17yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784549231; x=1785154031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HwhyWGdmsPyAYZrc8LxPh16IDXE2pvDxz1/DQduzxkA=;
 b=JlEmc4BclmDtbQRPJ6hxlFoX6vb3tTU3Z+UXYEHkrcJ1yagLSpMWy5yckUcsOUAtt8
 ReE8SKOBxD6tu5bHdA6eLT35DqJSRL7dmeqVLMzCB4NafOJH3ccje0TCKlXRHPVLwfn1
 MSKFeAUVyCrOc4R4yHROgPLe6osroH0QY53vxEtTrP4/HhbqOCYHPqdOEMvqxIR+iUwr
 bR3txn8aK2g53DRmi/Jc+qABMFvDb+PYzyrM1f0kS+LOIuBLANvWJTh2kBQZX0lEBV6s
 DnUOWVSXIhuVCFY/jD+iN/wExp4hIiIDEGoV6Nh0KonAPoWrGZ8+IgQj1rRh5LyXXcNL
 gdlQ==
X-Gm-Message-State: AOJu0YxEP2XojvJh4g5TnXdBRsZsJJ71+SJDOULPVxpYh/sxh/o3Vne6
 P1hkoYe8aatfDNPEHWAYCWh/GNL8sVhnqiQzTn6Of1mgQTF99C+dErLFhVP5VhcA
X-Gm-Gg: AR+sD10FFBv9nAiVhroM+kjwXT+MYtlgYXC5yaxmgvyIw283MzzaIM4T+pO7UbKLd7g
 gPCxw6v104CDVd+n2U201zZJucmc0ilFwW07DR9AbAbnrrjXPsPf8009JeQ8UBBdvwVVhuLMD0g
 q7z3qa8LFCYmWh5MXjymJ9wxOrDdAzzHzBm0+tvM2/eGf0UVWjVVxXSOJBw6iiHYSikLH+Y6hAl
 FQT5VRwxc2Dg9DKtz8f5KkiYhsTyLYYMIyYrVD++4/YHL3eYG29urUhYfWVODBafoL+HccMcIaC
 FNGIaE/KP4GvB7LFZnKml1UtGgCZy5m5mff+n7P5WEbCRET4E9w1EtR2xIGF1FxC1srpF5Hj7/F
 hjO5dkb8UBTrZO/quKJsl59MvSyejDMXY6vxu5pJRZu3Mqwj33FYmFA4yv1AoOPVdwL6Tm5Jtcw
 ObRYAzbs5jIo2SRVsq2Ni2vAgJCY+kbSAa/Q==
X-Received: by 2002:a05:6000:3101:b0:47f:776f:3845 with SMTP id
 ffacd0b85a97d-47f776f3a7amr5100994f8f.7.1784549230939; 
 Mon, 20 Jul 2026 05:07:10 -0700 (PDT)
Received: from localhost.localdomain (free-mobile.vlq16.iliad.fr.
 [213.36.7.11]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e51c33sm25507576f8f.12.2026.07.20.05.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 05:07:10 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: Maxime Leroy <maxime@leroys.fr>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 3/3] net/tap: use bool for boolean flags
Date: Mon, 20 Jul 2026 14:06:59 +0200
Message-ID: <20260720120700.801099-4-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720120700.801099-1-maxime@leroys.fr>
References: <20260717095842.419130-1-maxime@leroys.fr>
 <20260720120700.801099-1-maxime@leroys.fr>
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

persist, flow_init and flow_isolate only ever hold true or false but were
declared as int. Use bool, consistent with the interrupt-mode flags added
in this series and with common DPDK practice.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 drivers/net/tap/rte_eth_tap.h | 6 +++---
 drivers/net/tap/tap_flow.c    | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/tap/rte_eth_tap.h b/drivers/net/tap/rte_eth_tap.h
index aae9eea510..80419aad8c 100644
--- a/drivers/net/tap/rte_eth_tap.h
+++ b/drivers/net/tap/rte_eth_tap.h
@@ -72,7 +72,7 @@ struct pmd_internals {
 	char remote_iface[IFNAMSIZ];	  /* Remote netdevice name */
 	char name[IFNAMSIZ];		  /* Internal Tap device name */
 	int type;                         /* Type field - TUN|TAP */
-	int persist;			  /* 1 if keep link up, else 0 */
+	bool persist;			  /* 1 if keep link up, else 0 */
 	struct rte_ether_addr eth_addr;   /* Mac address of the device port */
 	struct rte_ether_addr *mc_addrs;  /* multicast address list */
 	uint32_t nb_mc_addrs;             /* multicast address count */
@@ -82,8 +82,8 @@ struct pmd_internals {
 	int nlsk_fd;                      /* Netlink socket fd */
 
 #ifdef HAVE_TCA_FLOWER
-	int flow_init;                    /* 1 if qdiscs were created */
-	int flow_isolate;                 /* 1 if flow isolation is enabled */
+	bool flow_init;                   /* 1 if qdiscs were created */
+	bool flow_isolate;                /* 1 if flow isolation is enabled */
 
 	struct tap_rss *rss;		  /* BPF program */
 
diff --git a/drivers/net/tap/tap_flow.c b/drivers/net/tap/tap_flow.c
index a9d8e09562..a0ffb35bdd 100644
--- a/drivers/net/tap/tap_flow.c
+++ b/drivers/net/tap/tap_flow.c
@@ -1521,7 +1521,7 @@ tap_flow_isolate(struct rte_eth_dev *dev,
 	}
 	return 0;
 error:
-	pmd->flow_isolate = 0;
+	pmd->flow_isolate = false;
 	return rte_flow_error_set(
 		error, ENOTSUP, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
 		"TC rule creation failed");
@@ -1914,7 +1914,7 @@ tap_flow_init(struct pmd_internals *pmd)
 		return -1;
 	}
 
-	pmd->flow_init = 1;
+	pmd->flow_init = true;
 
 	return 0;
 }
-- 
2.43.0

