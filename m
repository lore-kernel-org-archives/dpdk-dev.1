Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD2AC61DEB
	for <dpdk-dev@archiver.kernel.org>; Sun, 30 Aug 2026 20:27:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F5C840653;
	Sun, 30 Aug 2026 22:27:00 +0200 (CEST)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id 060BF4064E
 for <dev@dpdk.org>; Sun, 30 Aug 2026 22:26:59 +0200 (CEST)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-3964dfb5a69so3244085a91.1
 for <dev@dpdk.org>; Sun, 30 Aug 2026 13:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788121618;
 x=1788726418; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RfMAHDReZJQEPit0TIHxdf1WNVUhFzkErw6+FTDG410=;
 b=wdrlPnohX0VkNWSda4PXIb1Y7EJeVJdIGGJExk5IWs9sQDl8/0JTKbDrQiB8htYW93
 Iv//Bm2wo4Et3s7ZfAdeuzyoe6Ne+oaUw2jGi+F9XO/hmQs4FChfXd08NGWVUnBG3zQL
 2S+vsWY1PV2Qs4gNsWNPJt4VwdDzlsCcGNMkCr5nm2f+QRclwOIdOGIbwDom3eRGb22U
 l6DQJ2xTUL/3RNNT1RVQ4Z4gcf2dYVU3XpMRqtttbfiE2EyXYaWDBq9DeAfqK+jL5PrX
 Ih/MUtHNjyQMQobIeNJVnWao1Jao69Lpr8p/GLt4xn2E+0Mamx1BONgKfZDdgk0DzeQh
 ZhAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788121618; x=1788726418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RfMAHDReZJQEPit0TIHxdf1WNVUhFzkErw6+FTDG410=;
 b=QUeX2rs6mgv5a4Hdaath3G+PMw6uA6Vz4BaPcSu8KJmPmLV+ayj+6BloZS9msqiTWu
 iXiIwVDF/bMjNrzUZHZUt5To8mC/8Fv7NEAsWI82Ce3ukJz2shB3eebbrnHBsmhyR7ka
 r6RKEUfn7r6dC/B9ZsWgC1cHMcfdc5XFoKEgbVt0G0HLgfaVSJUYIfkQBTBYm0Kn+9CV
 Yn17x/BHNFD77IHB1yRVbSqA0yTNl4IpxZv8vXQ/ZNwK+CElqUdx2qHUcc7UJ2Hrp720
 vjx/bZxSYXIchNanftbtLs3znOpCnTBtaN4Pogbv6AWVd6L1ZEU5fmzcAax4U1VSd6Vd
 tWGQ==
X-Gm-Message-State: AFuF++ke+Gzn5THCy9IR2fAH1mPn7pVOl0eyagUc9IXmIqPaGa53jOXi
 bvrSoJxzSHzMAI8DUbqhh9HEeQxfIZsoVnWdI4pTDKIn2xql2RHwhgin3QFDvBju6927Kbowbsw
 KDQ26
X-Gm-Gg: AYBFou3idaZzGma175Q26GtkmGTlY1elFOFGxVEh7rURNFCzmZL/clg4alwqIS1Wo2Z
 HQY/6Udjm1liG42YyuChd3Ew1JPJDvw+2fpe35MXMx+cIOO8mMYePdVVYESSvuHzGYn0qJmnwjz
 meh1g2xMZQ5y4bvBT8Krfill2g5EP21e8mbdGlp+8p7DSzdAIM6zbEtRxFtne49HW9VaCIQ7Nj9
 VMdWKxJG4rRPuyw8joUrTTtNT/Gy6ZU+cKgB55T0+7lbvJcl6vpyZBTWTxQ/R7R6quKpkbrmZRs
 /PbDh841wRgYd2NAldXhobmD9kQeFc4AFk9QYAS5pC4sxa6mYyw3OMlyWhJItpRLSQXxdXeZ4Cl
 xJBWi9VZ0cS/yceopc1VZI/9OaifB+OODfG5j7pYtjo9ywzJVf99G6ieTFDaf5LdWebbMQXZP2n
 tB5oxi4Ux/aKMdWAMFYrfQRTwivZ90Z5VhZpCnXa+gJH5dnwryUzME+pu5oIqxELmKehjmtWH+W
 xZC5rnGM+Yl25nuDMNB4zs1ji3Qe+q5ssPlPg==
X-Received: by 2002:a17:90b:1a8a:b0:398:9be8:ea66 with SMTP id
 98e67ed59e1d1-3989be8eae3mr17498780a91.19.1788121618091; 
 Sun, 30 Aug 2026 13:26:58 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0fd5c34sm17683165a91.8.2026.08.30.13.26.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 13:26:57 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>,
 Declan Doherty <declan.doherty@intel.com>
Subject: [PATCH 3/8] net/bonding: skip unavailable members in device info
Date: Sun, 30 Aug 2026 13:23:45 -0700
Message-ID: <20260830202636.760014-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260830202636.760014-1-stephen@networkplumber.org>
References: <20260708174204.72574-1-wpan3636@gmail.com>
 <20260830202636.760014-1-stephen@networkplumber.org>
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

bond_ethdev_info() queries every member to derive the maximum number of
Rx and Tx queues the bonding device can support. A single failing
member aborted the whole call.

Skip members that cannot be queried and derive the queue limits from
the rest.

A bonding device with no members at all keeps reporting UINT16_MAX, as
it did before: no member has constrained it yet.

Fixes: acfb51e2fe96 ("net/bonding: fix number of bonding Tx/Rx queues")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/bonding/rte_eth_bond_pmd.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/bonding/rte_eth_bond_pmd.c b/drivers/net/bonding/rte_eth_bond_pmd.c
index 6235c07679..7579b97b06 100644
--- a/drivers/net/bonding/rte_eth_bond_pmd.c
+++ b/drivers/net/bonding/rte_eth_bond_pmd.c
@@ -2360,28 +2360,40 @@ bond_ethdev_info(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	/* Max number of tx/rx queues that the bonding device can support is the
 	 * minimum values of the bonding members, as all members must be capable
 	 * of supporting the same number of tx/rx queues.
+	 *
+	 * A member may be unqueryable here: it can be removed concurrently, or
+	 * simply not be probed in this process. Skip those, but do not report
+	 * the UINT16_MAX default if no member could be queried at all, since
+	 * that would let any queue count pass rte_eth_dev_configure().
 	 */
 	if (internals->member_count > 0) {
 		struct rte_eth_dev_info member_info;
+		uint16_t queried = 0;
 		uint16_t idx;
 
 		for (idx = 0; idx < internals->member_count; idx++) {
 			member = internals->members[idx];
 			ret = rte_eth_dev_info_get(member.port_id, &member_info);
 			if (ret != 0) {
-				RTE_BOND_LOG(ERR,
-					"Error getting device (port %u) info: %s",
+				RTE_BOND_LOG(WARNING,
+					"Skipping device (port %u) info: %s",
 					member.port_id, strerror(-ret));
-
-				return ret;
+				continue;
 			}
 
+			queried++;
+
 			if (member_info.max_rx_queues < max_nb_rx_queues)
 				max_nb_rx_queues = member_info.max_rx_queues;
 
 			if (member_info.max_tx_queues < max_nb_tx_queues)
 				max_nb_tx_queues = member_info.max_tx_queues;
 		}
+
+		if (queried == 0) {
+			RTE_BOND_LOG(ERR, "No member device info available");
+			return -ENODEV;
+		}
 	}
 
 	dev_info->max_rx_queues = max_nb_rx_queues;
-- 
2.53.0

