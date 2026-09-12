Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67269C79FB6
	for <dpdk-dev@archiver.kernel.org>; Sat, 12 Sep 2026 06:34:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B3E5D42E46;
	Sat, 12 Sep 2026 08:34:07 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id 2EBF142E45
 for <dev@dpdk.org>; Sat, 12 Sep 2026 08:34:06 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc4ae61629fso399595a12.2
 for <dev@dpdk.org>; Fri, 11 Sep 2026 23:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789194845;
 x=1789799645; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=COvGcDsH3cIpIRuKLkcMMWFJkYX7KhPqiNsZmjIkGn4=;
 b=m5msVdLaC/exaN9CgfpMCV3Fr8Ze01ZmzDFxNmDo0mNymx83KfOG+wSConG+mI6Ir0
 APXjY3+hLJSY4n7Xpq5EiiFkoODxuPY6+4z7xXrNr4d435/mT0Wc5igJVfuu/aLy/A1C
 WbC2RZVL6pGqPobftjDxxxNWsoDvzufdMO9p2E0tkIk2lmtDrhCbXj+vZ9FWM0lTeHvp
 ThsrCmSG+ECden2aQ+pLAlGcoM8mbnb67Tmn8XmrkMZVf3m1OqId5TPngjW6P6SjyaDa
 5mDhwf5BrNysJ2tgnaohy7jthrIb6xDX/Anqrn/aCAeSd1c/or2O480A92Ji0NThattz
 qSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789194845; x=1789799645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=COvGcDsH3cIpIRuKLkcMMWFJkYX7KhPqiNsZmjIkGn4=;
 b=ioUkD71F1nmTsUAqm+g/x9dhRg7cerDcnV0l0h4oVEV+v1v8ZS416JZ5U2lY0DZvCB
 zT4KW17CN20TGIQhZjaFvjYga2edDIhTb0ZhkZ6mOKh2Yrg+ui+aM9iwSBaMc8/ILEYB
 lyjVwzZsxZwJVXol/fGMS/YjQwtlPLS1KzOK7X/40F6hlqsrcfCzdr9CHTFmgsPospP2
 q5U7LRVOLT9oSmgtrn1ON64sFX/MwDpmynJtjNv4Hr354YNitvEGAYHvuuTbSZ0ZYMIo
 uy5AYZ7U0M8JvqBusDultOfCMyBBaEUPRyOZ5D9q/uWqpkkwEOrRQJhkbMvDrvLBDSy8
 PRUA==
X-Gm-Message-State: AFuF++nAPhYx9thOcOX2Ex4xJT3RS9MxsN4FuXEQWUmzznYu7OgjSXNO
 dm7/DKPq+EBzlh+aoNehdvjE7FNoYr9X3CX/GQpo8HxS/Qlyi/JVvv2Q5f56VYsToHCCUXnl08Y
 2ExfnIJc=
X-Gm-Gg: AYBFou3E8elwCJi42fsT1el5pOAl9qN+G90iNZ8/i49R13GVEKEEpUq0Un1hS7GY/SX
 1TcsyIfVcjlm9efY2qmvFuAYRLx5OoHnCMh8WTC2U/87SgKGnN6f9Avw+v6yyE7s5IXIH5kd5Eu
 OGGeHcbwpzUKfUHMKSKfE3XLeJw8j0fjZfwHaUcUKJYGdWS+yXC92Eme0XjiRUpxhQ36idRbBB4
 PFqEqkNRU7fHz1oBgFsEG/TFiax8pd7DugZAQ2yUyuVM0nLeCZ4RNDrNVNz+cI3Icu7lQria7qg
 OAstYzalRYe6meVdzygc9KcjGUSrMWjrfe+EPi+g76AdzD3y9FHpoitmZqdl6NLQS3FqmRSCFCI
 a/L7YoIRbMpvf3RGrBeRwY+AFhxj9eNuMv6YGvDWbYwpjEhM4kvLb2mdmN67N/qprRPSMdKjkI7
 1mhDsVYeBhpdHKMf82xeH/QONp79YrxMfQg0y0G2W+L4pWeUnahkdipdm2ZGp9Cd3Xjmvf2WLw1
 XKYkCMiydbNKkeHAHhGf/GKV/6FCH7uIQIH5w==
X-Received: by 2002:a17:90b:384c:b0:366:3517:1aa2 with SMTP id
 98e67ed59e1d1-39d9b99384dmr11537328a91.0.1789194845279; 
 Fri, 11 Sep 2026 23:34:05 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95424fccsm8661497a91.10.2026.09.11.23.34.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 23:34:04 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH 8/9] net/mlx5: use common sysfs routines
Date: Fri, 11 Sep 2026 23:30:27 -0700
Message-ID: <20260912063319.4117869-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912063319.4117869-1-stephen@networkplumber.org>
References: <20260912063319.4117869-1-stephen@networkplumber.org>
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

Read the bonding interface indexes with the EAL routine rather than
opening each file and parsing it with fscanf().

The index was read with fscanf("%u") and is now converted with base
0, so a value with a leading zero would parse as octal. The kernel
does not print ifindex with leading zeros.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/mlx5/linux/mlx5_ethdev_os.c | 17 +++++------------
 drivers/net/mlx5/linux/mlx5_os.c        | 13 +++++--------
 2 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/net/mlx5/linux/mlx5_ethdev_os.c b/drivers/net/mlx5/linux/mlx5_ethdev_os.c
index 4bbc590e91..d1c03d66af 100644
--- a/drivers/net/mlx5/linux/mlx5_ethdev_os.c
+++ b/drivers/net/mlx5/linux/mlx5_ethdev_os.c
@@ -36,6 +36,7 @@
 #include <rte_string_fns.h>
 #include <rte_rwlock.h>
 #include <rte_cycles.h>
+#include <rte_sysfs.h>
 
 #include <mlx5_glue.h>
 #include <mlx5_devx_cmds.h>
@@ -1192,27 +1193,19 @@ mlx5_sysfs_bond_info(unsigned int pf_ifindex, unsigned int *ifindex,
 		     char *ifname)
 {
 	char name[IF_NAMESIZE];
-	FILE *file;
 	unsigned int index;
-	int ret;
+	unsigned long val;
 
 	if (!if_indextoname(pf_ifindex, name) || !strlen(name)) {
 		rte_errno = errno;
 		return -rte_errno;
 	}
-	MKSTR(bond_if, "/sys/class/net/%s/master/ifindex", name);
 	/* read bond ifindex */
-	file = fopen(bond_if, "rb");
-	if (file == NULL) {
-		rte_errno = errno;
-		return -rte_errno;
-	}
-	ret = fscanf(file, "%u", &index);
-	fclose(file);
-	if (ret <= 0) {
-		rte_errno = errno;
+	if (rte_sysfs_parse_uint(&val, "/sys/class/net/%s/master/ifindex", name) != 0) {
+		rte_errno = ENODEV;
 		return -rte_errno;
 	}
+	index = val;
 	if (ifindex)
 		*ifindex = index;
 
diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index adc5878296..203e9339bb 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -29,6 +29,7 @@
 #include <rte_string_fns.h>
 #include <rte_alarm.h>
 #include <rte_eal_paging.h>
+#include <rte_sysfs.h>
 
 #include <mlx5_glue.h>
 #include <mlx5_devx_cmds.h>
@@ -2103,6 +2104,7 @@ mlx5_device_bond_pci_match(const struct ibv_device *ibdev,
 		char tmp_str[IF_NAMESIZE + 32];
 		struct rte_pci_addr pci_addr;
 		struct mlx5_switch_info	info;
+		unsigned long val;
 		int ret;
 
 		/* Process slave interface names in the loop. */
@@ -2140,15 +2142,10 @@ mlx5_device_bond_pci_match(const struct ibv_device *ibdev,
 			break;
 		}
 		/* Get ifindex. */
-		snprintf(tmp_str, sizeof(tmp_str),
-			 "/sys/class/net/%s/ifindex", ifname);
-		file = fopen(tmp_str, "rb");
-		if (!file)
-			break;
-		ret = fscanf(file, "%u", &ifindex);
-		fclose(file);
-		if (ret != 1)
+		if (rte_sysfs_parse_uint(&val, "/sys/class/net/%s/ifindex",
+				ifname) != 0)
 			break;
+		ifindex = val;
 		/* Save bonding info. */
 		snprintf(bond_info->ports[info.port_name].ifname,
 			 sizeof(bond_info->ports[0].ifname), "%s", ifname);
-- 
2.53.0

