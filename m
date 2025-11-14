Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4772CE8D5F
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 17:49:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1514740EE4;
	Fri, 14 Nov 2025 18:49:18 +0100 (CET)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by mails.dpdk.org (Postfix) with ESMTP id 24AC440EE4
 for <dev@dpdk.org>; Fri, 14 Nov 2025 18:49:17 +0100 (CET)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-bb7799edea8so1770410a12.3
 for <dev@dpdk.org>; Fri, 14 Nov 2025 09:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763142556;
 x=1763747356; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/SmM926mL+fYrNE7iO+I60bIr/gx0JEbWqBJqUqyJBU=;
 b=fEhPaWzHNrzu7xnstMSg1a53+qO3XplFgw3mDeUs9ZvvoO2HHe1ctL5M24mNjfdAL7
 7nIX43gMMJ50m1iqBmg6jkB3v3JHJW4lrKbuHzHfhaiKNjGRwZd2tE++dFQg9feS5dFl
 Uk6PnLSixwNCw3DSyTZupmNY2BsYpN+pjux4nEtxl5gbA0XiW+7hSbsnzvI/xl05Gx+6
 G9C6u+to7jzYa90gfQy1aSdXH3FeP3nQw6OjwdtoKBNuQQsZwLyxyw5g2JvHX5L49OTG
 THyDYKx4cvAiGOzUV34VRlbnEy+TTa0n8fsSmsyCn4cWnTgAmAiRmFzZZrOjiixZJXi4
 atDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763142556; x=1763747356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/SmM926mL+fYrNE7iO+I60bIr/gx0JEbWqBJqUqyJBU=;
 b=dfpRh4lmaWsiQiJXdyqCKneQgA9RcqFUvAtuPVvTcw284YVQPkmWreScdQpthANd0q
 qShxFndKTiT1jvjmqDP1ncs69JSzMax0/2E3ltb0jN59o8HRm7dnPgEwCNHHHHdEZQFd
 Tdo3/YAFUoYIhtd8N9dlit6Sr6Hm45UNGmuNl4K6JhkpPz2iUITFbxDHPPzMnpc9GnVq
 8zvp0HokEZX4phqPPHgM44O8WgAtt1hY1dGDnumP3w897zsZo2xMKkPVnpwXWOMaDiNF
 i1i/fLkvhIOHn+PboYaCeAvTJWCLuPVBPxQQkTjUdwEyp0RV+cVGLq1I3Re7FZq5aRlL
 TYxg==
X-Gm-Message-State: AOJu0Yz2rCo8wOsvPQbBHhozaopns6pzTG1PKgA6AyoD8EwztgUl//wO
 3O3VGpqBNGYBwXGa0agShs+upEdEK6tz5TY2BsIAHzVgoA3cN1G0U+vokxqKLIF0xcVp+irn1wY
 KMMuH
X-Gm-Gg: ASbGncsILhWsgrvgHDcoh18ox+k6wspzGOAI/5856RiA9ANVRNHcMOjaaOp4aDLf/b3
 qNTaPQ8NzO2ZcVwSg9zJ8MDQLX1tlqXrK9XT0e+apScnbekM2CmvJh4oIwRpcfvNWTSWnX7n263
 rq8mWvmBIICM8FY0TCKe6i5ZsCHOvQY/q8eTlWrBrHdntlpShlIGYRlFHTBVX3IfJq6nmx+4aev
 4goBK01e2AJsjz0UdSiZe3nqfQ25bwpGkSwH9vbq5DGEZ7DThF+MTkpRNnsbSEKtdsIj6KH2PlB
 HzxFPNoDYtHa579n/VMC+S4MBQl0CK4cDdrzsR5ZIBLUzk2rjI5w73IPyen0VAV37azv8al6U9w
 XMIHuxTHvZXBeD6Nqyf9iCbgpdtYTA8kGJx+1R21xv5vov0W7a2Q8HAluwrLK3kMK54E0Uy/NHq
 Yhm5KkdvG8litKGdcH6BOF6yYPyKqy8XUf6ZEZ2L023njuS03q3A==
X-Google-Smtp-Source: AGHT+IEAyzQka7SurnCqCkolo1DZtQVT/+xE89PyMRpYQ2xhrTP+lk46kLsJgZzp/h1dI9KL8RKgEQ==
X-Received: by 2002:a05:7300:cc83:b0:2a4:3593:9695 with SMTP id
 5a478bee46e88-2a4abb32b86mr1389152eec.18.1763142556110; 
 Fri, 14 Nov 2025 09:49:16 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2a49d695821sm14417916eec.0.2025.11.14.09.49.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 09:49:15 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Ophir Munk <ophirmu@nvidia.com>,
 Adrien Mazarguil <adrien.mazarguil@6wind.com>,
 Nelio Laranjeiro <nelio.laranjeiro@6wind.com>
Subject: [PATCH v2] net/mlx5: fix warning from uninitialized variable
Date: Fri, 14 Nov 2025 09:49:12 -0800
Message-ID: <20251114174912.1103626-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251113163301.285550-1-stephen@networkplumber.org>
References: <20251113163301.285550-1-stephen@networkplumber.org>
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

If the retry loop exits the code would do memcmp against uninitialized
stack value. Resolve by initializing to zero.

Bugzilla ID: 1823

Fixes: 1256805dd54d ("net/mlx5: move Linux-specific functions")
Fixes: cfee94752b8f ("net/mlx5: fix link status to use wait to complete")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/mlx5/linux/mlx5_ethdev_os.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/mlx5/linux/mlx5_ethdev_os.c b/drivers/net/mlx5/linux/mlx5_ethdev_os.c
index 4d8fbed188..50997c187c 100644
--- a/drivers/net/mlx5/linux/mlx5_ethdev_os.c
+++ b/drivers/net/mlx5/linux/mlx5_ethdev_os.c
@@ -512,7 +512,7 @@ int
 mlx5_link_update(struct rte_eth_dev *dev, int wait_to_complete)
 {
 	int ret;
-	struct rte_eth_link dev_link;
+	struct rte_eth_link dev_link = { 0 };
 	time_t start_time = time(NULL);
 	int retry = MLX5_GET_LINK_STATUS_RETRY_COUNT;
 
@@ -2073,4 +2073,3 @@ int mlx5_txpp_map_hca_bar(struct rte_eth_dev *dev)
 		rte_mem_unmap(base, MLX5_ST_SZ_BYTES(initial_seg));
 	return 0;
 }
-
-- 
2.51.0

