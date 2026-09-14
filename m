Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F4CC88E72
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 17:38:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C3584111C;
	Mon, 14 Sep 2026 19:37:49 +0200 (CEST)
Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com
 [74.125.228.43]) by mails.dpdk.org (Postfix) with ESMTP id BD78A4113D
 for <dev@dpdk.org>; Mon, 14 Sep 2026 19:37:47 +0200 (CEST)
Received: by mail-pz2-f43.google.com with SMTP id
 d2e1a72fcca58-85469d249c5so2011539b3a.3
 for <dev@dpdk.org>; Mon, 14 Sep 2026 10:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789407466;
 x=1790012266; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=COvGcDsH3cIpIRuKLkcMMWFJkYX7KhPqiNsZmjIkGn4=;
 b=NelNEPNhGkB809pQjpBAbFU0zQDdIHMmjShme8TtVEP9bGJaptD5YBii9dIF7nMuxF
 ifxRth1UMVPqEc1cKKxXZZre/hZUOT0QDC7Rjj8DJO31vCKQD4OIcF1Go8Tplf4us/NR
 P90dTUqZEKo2O0zQi4327wLgJ/VmYhcSpFlatisTdQ22v8QjL1D4HVS/drmN8KNEfx2P
 TQOJHOyjEnvaMLNgnwvq/hSnzyknvTHyyFL+TevjSVwIZlnndqENp9v6XR3rPJQfWigH
 rah1tsCWICbXH7U84+zzVhM3IYFdcQzsz9x1kkkZvSBN22mf7Jt71fLbefduHgIc7coR
 59hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789407466; x=1790012266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=COvGcDsH3cIpIRuKLkcMMWFJkYX7KhPqiNsZmjIkGn4=;
 b=bMKBgbcE4LSTmKTBklVR5ykb0E/G+2JB4X3RLuFH30v6BVreSsQlb8WQGeapotBDQ5
 GV8/dQ7swyy03ufPZFeQaaDjaNIHCnu+2MSOguYqgumxfik4dW0RUUrYqat9bYkmZHvQ
 Fh4kShXqyPK/prHYG67eoiSuvPah1YVys6cR50DmW+507EbJkhtnfLiGL5yMJc+0R2Ne
 ounziQ133sv0Rh49xdMg0eVQX7uBfjYOXJ9USUW08JYaRFLr2nwuH/rTFRLnJpxPTbzz
 pJ9AxTaxvTWt/bVHYC6/PO7Tpt0wilREd63SQp/0O+PMcfTYsjcVcRhfeSgy9wbt6CKx
 r9iw==
X-Gm-Message-State: AFuF++nj06uBOqJ2te/sf7EOZCzGhic4e0EAMVnZkIB872/WuVfsi4kG
 kSjabuezQaMJBu6Haesql2+AHJ+UzF1Qj2Hk5hIAfvYOOFFwysjkjtv0g4g99/ZDFVHAef2vsaC
 GCCmvWMlkyQ==
X-Gm-Gg: AYBFou1EUGMWLAYfLUy9+Ld/YtkVAl8DItUtvka6HGT9szDaEG3FMp9e/R/JzDLh1yt
 8+V3C2c/BI7q+p62lLNGYbzLVAinyhJqvxkmuIwxrzk9rUqpxwafbh2CXM94mAvibdQ0h12QoOX
 e0g5qaAdnQ7KaVKy3l5+hxCWP039Ig8L5YW+EWdO2uSZzz4WW/H39QZhipcCPx4o7K5fat0tilN
 l3YfeNDnQD/PYYVbMDLBMLkiuFvxBUR1e0BF3gR7jSaVxelZUKU2O5Ix1BNeBpwXuLnAAzTQCNI
 MA8x4BF1/gArwuo5vhaYvhIoSM68id/Kj8NGwkJvUkY5F1KtHUd4h9+pB2QTFMhaRjKJNvuWyPC
 RzAgWkd2bPPzWNFpCX6O2GcwOPy3DWgCn9Pe1UZhOiT7ixvnfdipsuZS7oqxFDIKvOXvDGTjgGb
 00DbTEdUKzQ8c9e3GtzLHwlmDLerzBBD0P/bXpS3vGvMl0/SAUIWUvszBuagVlChF8HRFoNMVy8
 UFJtvsPadI4e9Zoth9boZf0QTdk0TeqKZWgDPPTWDldjHEB
X-Received: by 2002:a05:6a00:3022:b0:852:38ff:b4b6 with SMTP id
 d2e1a72fcca58-86f85207cf0mr6749022b3a.17.1789407465697; 
 Mon, 14 Sep 2026 10:37:45 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86b286c49d2sm5159867b3a.10.2026.09.14.10.37.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 10:37:45 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v3 8/9] net/mlx5: use common sysfs routines
Date: Mon, 14 Sep 2026 10:36:21 -0700
Message-ID: <20260914173700.2795983-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914173700.2795983-1-stephen@networkplumber.org>
References: <20260912063319.4117869-1-stephen@networkplumber.org>
 <20260914173700.2795983-1-stephen@networkplumber.org>
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

