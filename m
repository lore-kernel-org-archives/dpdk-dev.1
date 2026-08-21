Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34AE9C5DF8C
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:31:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19E6640DF8;
	Fri, 21 Aug 2026 21:30:32 +0200 (CEST)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by mails.dpdk.org (Postfix) with ESMTP id 1C81640E3E
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:30:31 +0200 (CEST)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-cc16c6dcae2so1427141a12.2
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340630;
 x=1787945430; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7mEhN34E9YVxWsZmmUWiZiFxlX+ARs+hWDWXrtEIUbA=;
 b=Fpr0Hz5iqReHV110tXLHcfVqFmwPvXCS5TCxz7QNBbVAOuIoYpimzqC/zwzaiOOm9n
 SbDjBo79SdPTcTkGZlkyKCc95H4GNfKHvtZaZ4k42aWPRQXRpWcTbpsLggBjIR6bixqe
 3DMriC74stbVVWdpE0mwdOp/NR0f5ETueB3JF9EDlAQNvp+XovcccKkq+TkDJ//Jb7GI
 sMjo5l6ekIuhx03mIulzupFuLxSg9Zk2ZASOHE7xeeHO/VfAgiXiuEO4/FGbsXb0rTxP
 jiUX0o12H16U547zuCAXQO/HpDynqMW6lBvgNfxoKa7QefHMu1XhpP58YbdSnfvmNxEl
 jKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340630; x=1787945430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7mEhN34E9YVxWsZmmUWiZiFxlX+ARs+hWDWXrtEIUbA=;
 b=RIBcIXjSfNPq+9BeiPNsdOFD77ZxjavKfw/VWikr1qLP+I5QUDarJr5IN7oeKqSVQN
 onHAt0Of4n7ycxriadVjHlxdlRWhgq8k+Ki6eUuB37Xbg0clEvRRKnUIQ4ncql9uymOX
 fYLtNtMjU+h35vrT1/2wx2agHxgEeBqSDkBIm/zKSwRSPLlJfQ/wDN1Ap/NUKtKENbU9
 q0Gov6Yr/DYtZxloXPvgr/phvPH9KL97nFI6VYoAn+i0aEIAzAfxWdIQUVzbHn5rjAZG
 RvtlOQtAmtv9p6Qw/ly3OhV3wSahgPKpSzQ+JD2Kjn9Ikln4wuV4wOyfnVzkUAZjcKLt
 v0YA==
X-Gm-Message-State: AFuF++m3DcaHKqyWI/WGlTBKIBHKO6N6x+XnuYKI7eLahS744tPXQsCe
 rxrr1ERW8G9QQnaD6+htljM/BmUmCTzSu31ULPi/MFDqzAaZmROL2+iI1K54VV2NTacQmtsDwsO
 Q0XjPMsQ=
X-Gm-Gg: AR+sD11CfovjFrIcERF70WCeDadOw/Nd0HWNpATykWQc897NbG/fnVZWY6Iutirjqw8
 mrAYAS1klBy7i8+AUIEuMtskCoCm0fPJthgSLzqRpokfbkaNbQ1LLU+h248Xco2fC2vBYizzb2g
 NYuph7esAcpU7P96l1LCgooqjeyaD8nO7sN5QV2DAuUDa2QGmZDNCzAP/+t1W3ttfzEVWyrXM2q
 uMqSUJagrYjv1da8EX/WELTznC3zXRWshoDjVyIZ8MRRmXktEa2dw62rTnFYHnOi6vvDqljX6m4
 l0qZ3bfGCmFq4Xw2Gx9vfJG/O8WQwkhdRCfsWByf7P1OX2uOGMGz5/654KAHGIVrk5yuB8iu7LW
 TorWwFV528p1EEtzEOds88ordptRUo85P2299lLqMvbvick8aEiQOB/t6njADbs4HtxEjqvuN97
 qjxxe52BwlzptwiPN+R9T58UiGix4scylnmlI4PqWWWeV6TxIfBWUu3dtVZrkFeOxhu0PAsk/Ak
 xoc0RNXBNLx/+BW7kFJr+wez4o=
X-Received: by 2002:a05:6a20:3d94:b0:3b3:26aa:5455 with SMTP id
 adf61e73a8af0-3cd300f9e23mr17063271637.13.1787340630275; 
 Fri, 21 Aug 2026 12:30:30 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.30.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:30:29 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Christian Koue Muf <ckm@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>
Subject: [PATCH v2 43/68] net/ntnic: replace use of rte_memcpy
Date: Fri, 21 Aug 2026 12:24:38 -0700
Message-ID: <20260821192646.146382-44-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
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

The uses of rte_memcpy() in the RSS hash key update and get are
control path only. Regular memcpy() has no performance disadvantage
there and gets more compile time checking of the arguments.

The remaining uses of rte_memcpy() are left alone since they are on
the receive and transmit fast paths.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/ntnic/ntnic_ethdev.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index d536a41c4e..cf5e6b2e3f 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -1769,7 +1769,7 @@ static int eth_dev_rss_hash_update(struct rte_eth_dev *eth_dev, struct rte_eth_r
 			return -1;
 		}
 
-		rte_memcpy(&tmp_rss_conf.rss_key, rss_conf->rss_key, rss_conf->rss_key_len);
+		memcpy(&tmp_rss_conf.rss_key, rss_conf->rss_key, rss_conf->rss_key_len);
 	}
 
 	tmp_rss_conf.algorithm = rss_conf->algorithm;
@@ -1779,7 +1779,8 @@ static int eth_dev_rss_hash_update(struct rte_eth_dev *eth_dev, struct rte_eth_r
 
 	if (res == 0) {
 		flow_filter_ops->nthw_mod_hsh_rcp_flush(&ndev->be, hsh_idx, 1);
-		rte_memcpy(&ndev->rss_conf, &tmp_rss_conf, sizeof(struct nt_eth_rss_conf));
+		memcpy(&ndev->rss_conf, &tmp_rss_conf,
+		       sizeof(struct nt_eth_rss_conf));
 
 	} else {
 		NT_LOG(ERR, NTNIC, "ERROR: - RSS hash update failed with error %i", res);
@@ -1804,7 +1805,7 @@ static int rss_hash_conf_get(struct rte_eth_dev *eth_dev, struct rte_eth_rss_con
 	if (rss_conf->rss_key != NULL) {
 		int key_len = RTE_MIN(rss_conf->rss_key_len, MAX_RSS_KEY_LEN);
 		memset(rss_conf->rss_key, 0, rss_conf->rss_key_len);
-		rte_memcpy(rss_conf->rss_key, &ndev->rss_conf.rss_key, key_len);
+		memcpy(rss_conf->rss_key, &ndev->rss_conf.rss_key, key_len);
 		rss_conf->rss_key_len = key_len;
 	}
 
@@ -2556,8 +2557,8 @@ nthw_pci_dev_init(struct rte_pci_device *pci_dev)
 		eth_dev->data->dev_private = internals;
 		eth_dev->data->mac_addrs = rte_malloc(NULL,
 					NUM_MAC_ADDRS_PER_PORT * sizeof(struct rte_ether_addr), 0);
-		rte_memcpy(&eth_dev->data->mac_addrs[0],
-					&internals->eth_addrs[0], RTE_ETHER_ADDR_LEN);
+		memcpy(&eth_dev->data->mac_addrs[0], &internals->eth_addrs[0],
+		       RTE_ETHER_ADDR_LEN);
 
 		NT_LOG_DBGX(DBG, NTNIC, "Setting up RX functions for SCG");
 		eth_dev->rx_pkt_burst = eth_dev_rx_scg;
-- 
2.53.0

