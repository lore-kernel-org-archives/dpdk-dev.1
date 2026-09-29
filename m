Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29902CA5FAB
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 00:22:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA4CF42686;
	Tue, 29 Sep 2026 02:21:57 +0200 (CEST)
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com
 [209.85.216.100])
 by mails.dpdk.org (Postfix) with ESMTP id C743041101
 for <dev@dpdk.org>; Tue, 29 Sep 2026 02:21:54 +0200 (CEST)
Received: by mail-pj1-f100.google.com with SMTP id
 98e67ed59e1d1-39b2ad862bdso1534821a91.2
 for <dev@dpdk.org>; Mon, 28 Sep 2026 17:21:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790641314; x=1791246114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DJ95biXUSZEePRK7Yfi3vYAQx+9i0VLP4U/t3anEZUc=;
 b=sE1AXeoLFbC24bZytQ5JFgAR19rcnhHQwEE9Z/mSsJD0nfHJEi1XcoLoQ0KxtfZViv
 sUecni5fCryL+skp83lLGqEzRbi6fQ0et5uvGHdK0AcZoardWVbaJ348p7KAPdbGc5Vk
 HN/WQ8ZfE2eXqs7pO+idksMeb5jQn5XRIF2lyL6lUt8/PfsEs43BnSGQsJo0qU2GqSTd
 ey1lMmekoad86tEKQ9kq67A4Hu4BYjRtn29sGB1J19EMG2x0fNf1WcPjTMTAM6u5DxBg
 hN6jLFFGVnDQOHfqwOQM2O6Md9s57ehfNzq2e8sn3CvB5QZyRviAENIwAHvO+w7+yGWt
 TX9g==
X-Gm-Message-State: AFq9FYJwsia3zFkAEUIr3UyZ2drjVltPY6bKnDNcVibx3vkMh2MpGkg5
 wb0pCO1QQfj3LI1smgcaA41kDl9iBKRdI3RZ4TJtKkejtAHSAWMrAaKXd8R8B4LTDjy4BM8N0wm
 nE6hpVKAQfk5wEqQ9IGh5uofA+jNS5xxSklNPDr4cPnOk5QAqLkXbU5ycmyRaObWJmPBKfmno/E
 bArRxAJzev51q8P0P0TCWJ8Wtv8IXoKK1CCjQG/b405IDFwr9eS9zjy/YO4JdiWsYEObbhPmwDr
 SOfMpQRAUlM
X-Gm-Gg: AYBFou3WMnPpiIhBI4r13leuv4HQRQyo7IaO3t5opS43Of2F0pGuj/sET+lK5xV+07K
 SHzXs/dvkJbxqkG9UB4fpa0lPX5NOJO53Sh33AsNMAvHZDYSd6TJJEfg5hb/EnHEovYD/+yxk9k
 bWB3nbCIOzHyoeovx6kiTGfP3qRAvN+nEw7gwVc9uF1CiaXhAQYo7yN5hAhM+owq7z06zLtJitS
 cfrhAEm9/bnYWdOUYecl7ynS373IXsHI6EqscJJRE7cM998dUUSL1nYsOziAuKvVbZFo+jR8heZ
 4McehKnVwSOIjtVpm9aAIb/Wg11rC3v3Y6Y2kbvqzJOxcB5BzYeV6AFzTukgbf4c3irl5gYezPR
 0cNAuT8sCgu2fYNfT1kMVba3cej3SinMlyUzqiXK9vJXrcb2a2FNh3mCEtTvP3aeV00eZzgyKmq
 9KZCJ8hdtqHmVJoPceVVAV9ipRf8OGXDTmGLKRZqSkyJFXSDcIZg==
X-Received: by 2002:a17:90b:1e47:b0:3a0:c1de:f720 with SMTP id
 98e67ed59e1d1-3a0c1def972mr9200844a91.20.1790641313798; 
 Mon, 28 Sep 2026 17:21:53 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-18.dlp.protect.broadcom.com. [144.49.247.18])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3a49835dfc6sm666417a91.6.2026.09.28.17.21.53
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Sep 2026 17:21:53 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91430af782dso82276066d6.2
 for <dev@dpdk.org>; Mon, 28 Sep 2026 17:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1790641313; x=1791246113; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DJ95biXUSZEePRK7Yfi3vYAQx+9i0VLP4U/t3anEZUc=;
 b=GzpWGFTTsbAQVwWx1TmzcKyatYkueWrb5NhHcJza1WyuPbGfGVNFlf94uk8zId/Wf6
 7YnZEj9+6EcbEY31pcEXs9czvOyN/OsP+rzIsA6bjUHXAvPTVYi8vvP7aBDs0cFF2QZ5
 RYDM98UwiLjE1sUMyhWjbbet+QuSX+hoBW51w=
X-Received: by 2002:a05:6214:acf:b0:910:70e1:e73e with SMTP id
 6a1803df08f44-914557f8392mr145399726d6.36.1790641312857; 
 Mon, 28 Sep 2026 17:21:52 -0700 (PDT)
X-Received: by 2002:a05:6214:acf:b0:910:70e1:e73e with SMTP id
 6a1803df08f44-914557f8392mr145396246d6.36.1790641308002; 
 Mon, 28 Sep 2026 17:21:48 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91430e0f78csm91234246d6.32.2026.09.28.17.21.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 17:21:47 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Chenna Arnoori <chenna.arnoori@broadcom.com>, stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v3 4/5] net/bnxt: fix bounds in MAC address pool index
Date: Mon, 28 Sep 2026 18:24:41 -0600
Message-ID: <20260929002442.1208481-5-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260929002442.1208481-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260918032752.763408-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260929002442.1208481-1-Mohammad-Shuab.Siddique@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

From: Chenna Arnoori <chenna.arnoori@broadcom.com>

bnxt_mac_addr_add_op() indexed bp->vnic_info[pool] with a
caller-supplied pool before validating it against bp->max_vnics, and
before checking bp->vnic_info was even allocated yet (it is NULL
until the port is started). The existing "if (!vnic)" check was
always false, since vnic held the address of an array element and
is never NULL. bp->max_vnics is known from probe onward, so the pool
bound is checked first and unconditionally; the dev_started and
vnic_info checks, which gate whether there is anything to index yet,
follow it.

Fixes: 51fafb89a9a0 ("net/bnxt: get rid of ff pools and use VNIC info array")
Cc: stable@dpdk.org

Signed-off-by: Chenna Arnoori <chenna.arnoori@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
v3:
* Retitled from "fix bounds in MAC pool index and flow parsing" and
  dropped the flow-parsing half entirely (the bounded VOID-item skip
  in bnxt_flow_non_void_item()/bnxt_flow_non_void_action()) --
  Stephen Hemminger pointed out rte_flow patterns/actions are always
  END-terminated by API contract, so that bound did not guard a
  reachable path; reverted to the original unbounded skip loop
  rather than keep unnecessary defensive code. Dropped the
  corresponding Fixes: 5c1171c97216 tag.
* Reordered the remaining MAC-pool fix so the pool-vs-max_vnics bound
  check runs before the dev_started/vnic_info checks, not after --
  also per Stephen Hemminger.

 drivers/net/bnxt/bnxt_ethdev.c | 11 ++++++++---
 drivers/net/bnxt/bnxt_flow.c   |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index 11e8f7908d..20084826d3 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -2105,7 +2105,7 @@ static int bnxt_mac_addr_add_op(struct rte_eth_dev *eth_dev,
 				uint32_t index, uint32_t pool)
 {
 	struct bnxt *bp = eth_dev->data->dev_private;
-	struct bnxt_vnic_info *vnic = &bp->vnic_info[pool];
+	struct bnxt_vnic_info *vnic;
 	int rc = 0;
 
 	rc = is_bnxt_in_error(bp);
@@ -2117,8 +2117,8 @@ static int bnxt_mac_addr_add_op(struct rte_eth_dev *eth_dev,
 		return -ENOTSUP;
 	}
 
-	if (!vnic) {
-		PMD_DRV_LOG_LINE(ERR, "VNIC not found for pool %d!", pool);
+	if (pool >= bp->max_vnics) {
+		PMD_DRV_LOG_LINE(ERR, "Pool %u exceeds VNIC count %u!", pool, bp->max_vnics);
 		return -EINVAL;
 	}
 
@@ -2126,6 +2126,11 @@ static int bnxt_mac_addr_add_op(struct rte_eth_dev *eth_dev,
 	if (!eth_dev->data->dev_started)
 		return 0;
 
+	if (bp->vnic_info == NULL)
+		return 0;
+
+	vnic = &bp->vnic_info[pool];
+
 	rc = bnxt_add_mac_filter(bp, vnic, mac_addr, index, pool);
 
 	return rc;
diff --git a/drivers/net/bnxt/bnxt_flow.c b/drivers/net/bnxt/bnxt_flow.c
index 4bf38043b5..7b27d62697 100644
--- a/drivers/net/bnxt/bnxt_flow.c
+++ b/drivers/net/bnxt/bnxt_flow.c
@@ -1697,6 +1697,7 @@ bnxt_validate_and_parse_flow(struct rte_eth_dev *dev,
 	while (act->type != RTE_FLOW_ACTION_TYPE_END)
 		goto start;
 
+
 	return rc;
 ret:
 
-- 
2.47.3

