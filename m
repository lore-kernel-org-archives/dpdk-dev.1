Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9FCCA5FC5
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:48:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 316DD42F45;
	Thu,  1 Oct 2026 00:44:29 +0200 (CEST)
Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com
 [74.125.227.167])
 by mails.dpdk.org (Postfix) with ESMTP id 9047042F73
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:44:27 +0200 (CEST)
Received: by mail-pj2-f39.google.com with SMTP id
 98e67ed59e1d1-3a49b6bb21eso1913961a91.3
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808267;
 x=1791413067; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MmMbdsh3P+qk5LKVBZzXqaxc8DUl9nD27h64Y2ZyBIw=;
 b=OrjYofiEs8PjmpbImF0JRcudTxtEvEYGgGyUq/Lqo7GzZrzI7khwpYEvCzUKiQ2Qd8
 QneXz3OBTYpVZPlh2cuhu7bTO18O8cHTkOU8HFj7oPSgFC9+Dtsz9ZSyguEI8v9sUwR7
 KCKIHkwNropu+cOByFuZS+bzeKejAij8LmWHHPA9gkov9N+umFxNRYpTX6Rl+M7BAk84
 XKNl0z2zz0PVapc0gxbZaCqPd0FGj65Ff4wuBWr+kfYCylAPiAQcXzrwytvx+K9beYHs
 vdTcOnHt5SOWiL6HRe1IMnlBaIDHiJiP3usY7r0YqgvIC0yVGhbUGArbZ7a2dTu6GyDx
 HcPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808267; x=1791413067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MmMbdsh3P+qk5LKVBZzXqaxc8DUl9nD27h64Y2ZyBIw=;
 b=aag3c/XPseX6PWXajwTSiKNwBTd9tbSRnJpQOUPJBE6KClzxwvewa3iCdGLIb6Hyia
 nVsx+S/lm4vqzZ8xuskuyojZQqB8xi1KLs99OGtLgrmWqAOGAYuJjghtrnziX9wS2b6o
 n7sRsUaQ73koKx2vWTGbo8sfseurnO9eL07R84py1jtwtCMHxNYZyueteLmQNe/kGWdC
 fpa3CjQa24ondCut/9QxZVO5FsZ/GxwxmqiEJYVfnoaG4SzKozPv7R5xZ0AdanjWSJHU
 rka9M/YNzZQmHoAR0V7eH7MCwuS98bECI4I5zLrB8Drl63nLOUWWGgeUdXEaaICcpk1y
 D9qw==
X-Gm-Message-State: AFq9FYKAquVWUUMQ3sDziUOGpIOPjXKWeK11oe5ewxly1msthrshCGLy
 Fzly+cHL2/RUs4I1KuB5sIKVaTRQiD0ZD75T0l/VY7PBKWstWzUL6A0E9EzX0dxqKPG6pLDuK0i
 dLyewP4w=
X-Gm-Gg: AYBFou2dAesuAjjhGz4B25RSNdvHb2f/Ya/ZooOE/Nen/F/hoD+jzebmQBKkhyj0kww
 9HhN0pMUj1Sy5NCfVY9MgD209atBgTDaFa1+Pyazo1KM0migwLyqOyWjuLA0MJxzpWoIE4ESnxJ
 donoolB34EJLNuHoFxc9R/6YfJqKmqj45lvRhOdfxHpA8FkcDf+b9UaBIDEDmPIduZzTchKpRvn
 dfNka1uoKY7DyPI7cY+OH+GIgW9qXNwGu/zRpUIoV4WN4/D8hbnmsQVfKXDloDHeho+dS13bh1i
 /jyFRQ/FdTdZ/qNGKwp9TiXComohukC05sFUhvyNJKh7BObLEa/NRuE41pdvw8wzpZ2cpbWJaf+
 yxMaAKTAX5BYXc6mD404qMgO0PnMNtEI+Y29ghTQQihEX8HS0Jka95t5zVynpXZ2mru/CPvcg38
 mEt+TiDX6nHe61CjeEMUAT0gkAxKh13icoiwJH5YHjgNMJZCgXJQCZc+Qj8/vFV5A2t7GL8ssfM
 wU66yBTCCJNbh4F/BE4F+GhByPo34ziVJhZLg==
X-Received: by 2002:a17:90b:4b11:b0:3a2:b70b:9cd4 with SMTP id
 98e67ed59e1d1-3a4d14f0998mr1559156a91.12.1790808266703; 
 Wed, 30 Sep 2026 15:44:26 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.44.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:44:26 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gagandeep Singh <g.singh@nxp.com>, Sachin Saxena <sachin.saxena@nxp.com>,
 Vanshika Shukla <vanshika.shukla@nxp.com>
Subject: [PATCH v3 40/65] net/enetc: use kvargs numeric helpers
Date: Wed, 30 Sep 2026 15:40:58 -0700
Message-ID: <20260930224340.58580-41-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930224340.58580-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260930224340.58580-1-stephen@networkplumber.org>
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

The VSI timeout and delay arguments are parsed with strtoul() without
checking the end pointer, so a value such as "10abc" is accepted. They
are also assigned into a uint32_t before being validated, so a value
above UINT32_MAX is truncated and only rejected if it happens to
truncate to zero.

Report the offending string rather than the truncated value, which was
not meaningful once the conversion had failed.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/enetc/enetc4_vf.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/net/enetc/enetc4_vf.c b/drivers/net/enetc/enetc4_vf.c
index 6eb1e5d760..fd985c85c9 100644
--- a/drivers/net/enetc/enetc4_vf.c
+++ b/drivers/net/enetc/enetc4_vf.c
@@ -2012,28 +2012,30 @@ enetc4_vf_dev_init(struct rte_eth_dev *eth_dev)
 			/* parse optional VSI-PSI timeout devarg */
 			val = rte_kvargs_get(kvlist, ENETC4_VSI_TIMEOUT);
 			if (val) {
-				errno = 0;
-				hw->vsi_timeout = (uint32_t)strtoul(val, NULL, 0);
-				if (errno != 0 || hw->vsi_timeout == 0) {
-					ENETC_PMD_ERR("Invalid VSI Timeout value = %u",
-							hw->vsi_timeout);
+				uint64_t num;
+
+				if (rte_kvargs_to_uint(val, 1, UINT32_MAX, &num) < 0) {
+					ENETC_PMD_ERR("Invalid VSI Timeout value = %s",
+							val);
 					rte_kvargs_free(kvlist);
 					return -1;
 				}
+				hw->vsi_timeout = num;
 				ENETC_PMD_NOTICE("VSI timeout set to %u", hw->vsi_timeout);
 			}
 
 			/* parse optional VSI-PSI delay devarg */
 			val = rte_kvargs_get(kvlist, ENETC4_VSI_DELAY);
 			if (val) {
-				errno = 0;
-				hw->vsi_delay = (uint32_t)strtoul(val, NULL, 0);
-				if (errno != 0 || hw->vsi_delay == 0) {
-					ENETC_PMD_ERR("Invalid VSI Delay value = %u",
-							hw->vsi_delay);
+				uint64_t num;
+
+				if (rte_kvargs_to_uint(val, 1, UINT32_MAX, &num) < 0) {
+					ENETC_PMD_ERR("Invalid VSI Delay value = %s",
+							val);
 					rte_kvargs_free(kvlist);
 					return -1;
 				}
+				hw->vsi_delay = num;
 				ENETC_PMD_NOTICE("VSI delay set to %u us", hw->vsi_delay);
 			}
 
-- 
2.53.0

