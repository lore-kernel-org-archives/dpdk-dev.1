Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2FFCD8CA6
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 16:33:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 456A640BA0;
	Thu, 13 Nov 2025 17:33:07 +0100 (CET)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by mails.dpdk.org (Postfix) with ESMTP id F2587402A0
 for <dev@dpdk.org>; Thu, 13 Nov 2025 17:33:05 +0100 (CET)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-ba599137cf8so690515a12.0
 for <dev@dpdk.org>; Thu, 13 Nov 2025 08:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763051585;
 x=1763656385; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/MagE56ECz05/LPmrk+mHwNDyA+OB2TCKa6N9w4HI/U=;
 b=jxTYJiF3tQg0tnObY6LAiek7m9hqcGipnpu6pqfuCY38LSVF6rhnB0fUkUVBwiZjuD
 +Y8HotidbWNa8qUy/mU7z4dXUz7cRAHM+l/b1NRY1+RNUxitdhz9PBJNI8t5pxZzwKIo
 FMDPZTl7NbVmO8Jalac+z3Eanruyq8kiRGgiy92NmYD6uEXEEgaipyJ/lYaFRmjRyh2B
 EXCQPvJRU6hgU6nY57Mq0LVRLs/9M467eOIU0B+66SR/IUisi+dsm0RnsMmjhLCNm2g4
 A5LUMa5uMRKgZNOKVDmAZMaTTcPPYtZlXXau7E9mVr/lkVIZ/Ct18nsLLbtdQeLQaEd6
 qLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763051585; x=1763656385;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/MagE56ECz05/LPmrk+mHwNDyA+OB2TCKa6N9w4HI/U=;
 b=eMV6QZoVwKIk1JQmzR2VnpStAU2hAk5N6lZ4i1I5KUj7rFHGmpcYs0k7nvNmyo/FaB
 RFS5fFHZMLVODNjc/KGrpbSbMIC8WpO94kF1SO4t9tR6l68iwVZpAENpR5REIulxqV4y
 N0YO0dRBQglS8Jz15+CdxCzpyLmnxYm5drV+3/5p66C4qs+tt2EGJq/jTjW1rIoxlxBT
 KmP49eO7ts2JosvmxTzUp4zbL8ken8jqI4JapuUcm6ETIoQdfp6opxZ5VpRVfPjmaooZ
 NneJFotNiw/Ddvg7gWbgppnam3Lzo7zfo91tnFsJg5nzsdI2HFyQALuokPdTUYR9JNOW
 ySHQ==
X-Gm-Message-State: AOJu0Yzx9XGSKaX6A/ucnrpyUXn9QtXAyj31hhfZ168o7Ddi4jRjMIIn
 qAKkfow3dPglHS6BOjqOMH5wkikGXzQU0IzQW8ifi/PN0l6RQvdllxaD7VArSuAJCWrbEaMvJad
 AuoaMNGthzQ==
X-Gm-Gg: ASbGncs6a/vj+ah7lAfSK+EfJTDVum2T75m5xKKfOuWuimOQRVhS2qLKJTewMX/sDGw
 Fri8CLdPFJs0bf2WNpn+zFicC23gfc6gWJi/HbFowO7sHfzxn4xA3AwGOrcbWefqLUf7CYetz7j
 3fKutgUavtX8wL7tUv3obtAEK1Q3GJeTH+MK271KiJOO9ske1L/Sjx5rbfAuOJESYOdNYssk1Px
 dG1tVE6RSgPuQw0/weP7NIn8q4FT7ETgpMLMiZ6792g1/ynSd7ocZiXU5AJS4gYhNRKTFdNLi9Z
 hgqt2pFhv9PLHVEXi4IZnOUSzXJ+tMruMlWrR3ViHglBf7Yrkj0MUHI5By7sQoEAtfa8nsetgM8
 8KpPwHyDiI8lHIHKl+T1x3kNbTAPgRnjYh/5xnOAPAMWL9aNGY2rmswR7Uqnjqkec4hnBY+SUu/
 ec/7CjurS3NIv/j/gs0fZZMFBDU5roLQFvTbmMvIk=
X-Google-Smtp-Source: AGHT+IF5JtSGZzWXF2Il41lt0gOCOOoMDY4wTpwgK1dRF5iicRNXGkntW4qy5jvSiQCSfhSCaoG71Q==
X-Received: by 2002:a05:701b:2901:b0:11a:4ffa:bb8f with SMTP id
 a92af1059eb24-11b033ae656mr61564c88.5.1763051584788; 
 Thu, 13 Nov 2025 08:33:04 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2a49db4a36asm276012eec.5.2025.11.13.08.33.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 08:33:04 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Ophir Munk <ophirmu@nvidia.com>
Subject: [PATCH] net/mlx5: fix uninitialized warning
Date: Thu, 13 Nov 2025 08:33:01 -0800
Message-ID: <20251113163301.285550-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
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

Gcc-16 detects use of uninitialized variable.
./drivers/net/mlx5/linux/mlx5_ethdev_os.c: In function ‘mlx5_link_update’:
../drivers/net/mlx5/linux/mlx5_ethdev_os.c:539:15: warning: ‘*(long unsigned int *)((char *)&dev_link + offsetof(struct rte_eth_link, <U38c0>))’ may be used uninitialized [-Wmaybe-uninitialized]
  539 |         ret = !!memcmp(&dev->data->dev_link, &dev_link,
      |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  540 |                        sizeof(struct rte_eth_link));
      |                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/mlx5/linux/mlx5_ethdev_os.c:515:29: note: ‘*(long unsigned int *)((char *)&dev_link + offsetof(struct rte_eth_link, <U38c0>))’ was declared here
  515 |         struct rte_eth_link dev_link;
      |

If the retry loop exits the code would do memcmp against unintialized
stack value. Resolve by intializing to zero.

Fixes: 1256805dd54d ("net/mlx5: move Linux-specific functions")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/mlx5/linux/mlx5_ethdev_os.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mlx5/linux/mlx5_ethdev_os.c b/drivers/net/mlx5/linux/mlx5_ethdev_os.c
index 4d8fbed188..d4a544e1a6 100644
--- a/drivers/net/mlx5/linux/mlx5_ethdev_os.c
+++ b/drivers/net/mlx5/linux/mlx5_ethdev_os.c
@@ -512,7 +512,7 @@ int
 mlx5_link_update(struct rte_eth_dev *dev, int wait_to_complete)
 {
 	int ret;
-	struct rte_eth_link dev_link;
+	struct rte_eth_link dev_link = { };
 	time_t start_time = time(NULL);
 	int retry = MLX5_GET_LINK_STATUS_RETRY_COUNT;
 
-- 
2.51.0

