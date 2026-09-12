Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA5EC88E59
	for <dpdk-dev@archiver.kernel.org>; Sat, 12 Sep 2026 17:04:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 419D740A7A;
	Sat, 12 Sep 2026 19:04:27 +0200 (CEST)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by mails.dpdk.org (Postfix) with ESMTP id 8A5F240616
 for <dev@dpdk.org>; Sat, 12 Sep 2026 19:04:26 +0200 (CEST)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-cc147d86bebso2268504a12.0
 for <dev@dpdk.org>; Sat, 12 Sep 2026 10:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789232666;
 x=1789837466; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=COvGcDsH3cIpIRuKLkcMMWFJkYX7KhPqiNsZmjIkGn4=;
 b=BQ+BAbfTsnmi8a9VRy8GLAunY7FNdpYV/Qy+je/hdy2ep1LGaZE8yRUC6J2/0tVcrv
 8gRJoRHARAQ/n61CGAKioNS0274rMsv2GoUhIwEju3XOHk+ihTfnsuXAsYMBnV2i6TIB
 ZFoEvedcTCi8zTTfWAY7JjxmMo+Rnc2lHHUsivwdAySMuKzUmd/hmH1MFrk5UCXHM4Ek
 zJdhba1womoGv1TOSTuIO9z8ByqzFdWfbqryt1yudUZJAFfkxRsxXpiE8IcgpaAv1wG0
 w0xwzXOpzipBphvlEVP+djn3C6VlM8jKSJfrHCo36ay7neoiFvXQwaWttx5Coh+NO5cd
 ASEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789232666; x=1789837466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=COvGcDsH3cIpIRuKLkcMMWFJkYX7KhPqiNsZmjIkGn4=;
 b=PtqQ5AOHELy0nqOm+g38+ePHc1+dE2XOV+9OYI55XEt35BJEJTYjyBOrwfenx2s1bv
 uxcDtyfbdV3JoGkxd9QPGAEJ7xTv+lb1EAZcQWAnu/Ehw3ab9LnGFcfR+xMj89x7/Gcx
 tPCpc9SHR3Dkc3wVc1byKsQ7y2LAWlN9IxY90q31yO7lTW91reUZ6ojOPQjtRpUH94hZ
 BWIEMMJpVNkMjAHf6NTPaAq0kEzTuRgawe9CNXXYQr1EdD0954RfZUZ58WNLjm4Fq+25
 zDVUTQp8YfqMIho7kxqdZwAnDdjYq2eccZuMasNiKShI59H3T8ELy+cQPLpXKlo03qX6
 AeJw==
X-Gm-Message-State: AFuF++kNAnSS+n14LuH9dZ4SACwBhcUK5Emi9rnZb6OVZiTILKI/U+Zi
 mPwUtyrObmuCzEgSw6+xHyUB1XvyLsNQd3ONPAR+7MClF1eqJU07d5HhFLRqFqlO8D4Bzv+GhJp
 RegR//h8=
X-Gm-Gg: AYBFou2JCpUfDGZm4E+X3mUmK0xk55mxZOxsZ6CaHXScNxhGrk2eGtItTyVd6KiJqsE
 w6d2HmZn1nYw3BFYMeJtMN55ogrtFV7yqyEqECel0BYhZ1ayN1QkMHLf8lQC4Ul7H745eJhedxO
 q9Ye5TFCUiFVptEw8WgX6BjCXZYJoqC27W3kk5HDne/bXut7H+1RiDuNYMqGKJRiqNROdYa5OfV
 rh6D9q0d+TYKgHCXCxfwLpXjr60PbSK1dwCnP5ksw3qEtR/lTbAX+/5yG5Q9N95Y5Cfd/nwXaUT
 GZzSUeqHqB1Q8HzT45B/d/+cF1KMLoOdI/Tm+C0ncphf1c+WTZigR1GV3rFh5u5NEpxz3+Nc4ox
 PwRGJmmtexjJn9Izp95FblZDlnq0XmXYy02XPHXAxD+g7Vn2fMNhxV/BNMtCWmBYUuMT5WtskL8
 4unzs6iRCMJYWqd+ihqBx3p0xbrFRyaN0gqTwyCAJWtqH21YaBj1GZ648ccnjoRaCZxtxt08fII
 56jCwehI9TEB2sHK97wzOpKwO7PQNjYZ2whKQ==
X-Received: by 2002:a05:6a20:cd90:b0:3b3:3506:cf3f with SMTP id
 adf61e73a8af0-3dad26c4b49mr18173135637.1.1789232665688; 
 Sat, 12 Sep 2026 10:04:25 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc4c655c2f0sm2719569a12.18.2026.09.12.10.04.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 10:04:25 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v2 8/9] net/mlx5: use common sysfs routines
Date: Sat, 12 Sep 2026 10:02:20 -0700
Message-ID: <20260912170338.486978-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912170338.486978-1-stephen@networkplumber.org>
References: <20260912063319.4117869-1-stephen@networkplumber.org>
 <20260912170338.486978-1-stephen@networkplumber.org>
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

