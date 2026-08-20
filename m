Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E3BC5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:25:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6BED040DD0;
	Thu, 20 Aug 2026 07:24:36 +0200 (CEST)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by mails.dpdk.org (Postfix) with ESMTP id D8C4540DDA
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:24:34 +0200 (CEST)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-cc1469c1b83so1841338a12.1
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203474;
 x=1787808274; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2JKxy/A3XDVfMBFVLdmkTfrWLNJQgOwTu6pG9J8D0pg=;
 b=hLVErJz9V005Li0JwZNjvl/m2vKMogvWwfxuRzBpxVXBhNyAyXmAo07PuMVQ3BMovQ
 gLFqo7i58llBvBYFtcp7n2kcYojln6RGOUvwpdaDJ29d/TRHYjZZa6dkwQJmhq8ZRJiJ
 aCU0pA9I1dJys8m9GV48OZzRIj6jBChT+QL0RQtLKehsPy5scW+2LVmxsni+Wv9BW0oq
 9X2SxWT1KYbHWu1Nw1WjgPAmI7MhiiAEzLTbt2zMV6hUNEN6MUgKi/KhSWmKPeD31K/W
 V2X/GSgou7HOa0MQOhj4O7Tp2+z1P2ZOSPAIRbSmpiOAOt8QU+48c4LQTFk22PF0vCyi
 iAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203474; x=1787808274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2JKxy/A3XDVfMBFVLdmkTfrWLNJQgOwTu6pG9J8D0pg=;
 b=n8JroE7WIozf8d+3b/yYHVzg6gYqE96wjjYltJL0cs9tqoVWHh25rrjUr67chVDYLi
 fqWE3an82s56Hx+YMRH4PT6let3tjEVVIhHigQ3IsqYVyOpegn2PNZdEBrw2G3XUX0Lx
 a6hqRYduaHBAqcaZ2eLgcAp67Z5MXA5oCBxninnRNogu5GytqAQEov2u+eNJcc4aAXWs
 udaqCqMm3g3Ciql5smkGlebP6wgn968J08yKRejCTrS21zY/D07cZ2a6AV+pww+GOrs+
 FglF4Qbt9CaXg36yvMkM6lKqjeM8YYNMTpjoCUvhR882EUUjsLYtVbC7Is6/b4MpdFck
 aoFA==
X-Gm-Message-State: AOJu0YxAk9XxOOVY4v8ZWylP1yzOuXsPwOGngyPg6qR3Yj/1+XKXOo1/
 Oq0z9AHIQxTaF5O+2uTRxJXAYlXHDRSeOUtMIVB66t0WyiapgCpoPOuuYCbapHSg9dF0PaLYmSW
 nUW+o
X-Gm-Gg: AR+sD13qAjRxOH2tx236pEPiCvtrzCHZckfijvRRl/XIezg0t5pYiiN7eiFDcjq3rtg
 G5wLXFnrJqvsA4Cei1m1YCVYxmmChh6bYn90fJ7oAF1fkF4ggVIhZmog3Q2vIclKp62rQd9iD//
 ZCcnAKSmzu3lwAXGaSzelMK4mSZqY+USzfGr/O/6DeZuEhlUOInySdbmDbuVLFO2WbMS9AuShxg
 XLEjQU9u+heCsIEBtBn8kQQpE8Gan9IvllS3Cgux7y6FbQAN+Mxu/ATSxMTLIYgystjIMVWvK2t
 Dho9j0+r71Jc5Kl+voV3VPgF65N9t+m0qGsrGv8QBYJXIqW18e34FgovunNrd2pcszffIig7wS6
 rRn8vnNIHApOCuaFX7pYyzcK4RpgC0dcTBpf66rhwmHT7tJ04anMrkIvcj807V1Eoaow61d59LJ
 gFmhUopEgvdP3CuibbPvw+lkYkzaxdCGu2svLgswBhKYaKJAeT/V1xVgBd1Na1ffml7CoKp6aVD
 HarKkTsuh2Egyv561+Cw8oHTE8=
X-Received: by 2002:a05:6a20:c91c:b0:3bf:5b7a:fc8b with SMTP id
 adf61e73a8af0-3cd00aaa27dmr20618710637.0.1787203473914; 
 Wed, 19 Aug 2026 22:24:33 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.24.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:24:33 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Potnuri Bharat Teja <bharat@chelsio.com>
Subject: [PATCH 24/61] net/cxgbe: replace use of rte_memcpy
Date: Wed, 19 Aug 2026 22:12:14 -0700
Message-ID: <20260820052251.1453273-25-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820052251.1453273-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
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

Don't need rte_memcpy for fixed size value.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/cxgbe/clip_tbl.c     |  2 +-
 drivers/net/cxgbe/cxgbe_filter.c |  8 ++++----
 drivers/net/cxgbe/l2t.c          |  4 ++--
 drivers/net/cxgbe/smt.c          | 20 +++++++++-----------
 4 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/net/cxgbe/clip_tbl.c b/drivers/net/cxgbe/clip_tbl.c
index 8588b88158..ba7c9f19e4 100644
--- a/drivers/net/cxgbe/clip_tbl.c
+++ b/drivers/net/cxgbe/clip_tbl.c
@@ -115,7 +115,7 @@ static struct clip_entry *t4_clip_alloc(struct rte_eth_dev *dev,
 	if (ce) {
 		t4_os_lock(&ce->lock);
 		if (rte_atomic_load_explicit(&ce->refcnt, rte_memory_order_relaxed) == 0) {
-			rte_memcpy(ce->addr, lip, sizeof(ce->addr));
+			memcpy(ce->addr, lip, sizeof(ce->addr));
 			if (v6) {
 				ce->type = FILTER_TYPE_IPV6;
 				rte_atomic_store_explicit(&ce->refcnt, 1,
diff --git a/drivers/net/cxgbe/cxgbe_filter.c b/drivers/net/cxgbe/cxgbe_filter.c
index 5a7efe7a73..3d1d087ec2 100644
--- a/drivers/net/cxgbe/cxgbe_filter.c
+++ b/drivers/net/cxgbe/cxgbe_filter.c
@@ -851,10 +851,10 @@ static int set_filter_wr(struct rte_eth_dev *dev, unsigned int fidx)
 	fwr->ivlanm = cpu_to_be16(f->fs.mask.ivlan);
 	fwr->ovlan = cpu_to_be16(f->fs.val.ovlan);
 	fwr->ovlanm = cpu_to_be16(f->fs.mask.ovlan);
-	rte_memcpy(fwr->lip, f->fs.val.lip, sizeof(fwr->lip));
-	rte_memcpy(fwr->lipm, f->fs.mask.lip, sizeof(fwr->lipm));
-	rte_memcpy(fwr->fip, f->fs.val.fip, sizeof(fwr->fip));
-	rte_memcpy(fwr->fipm, f->fs.mask.fip, sizeof(fwr->fipm));
+	memcpy(fwr->lip, f->fs.val.lip, sizeof(fwr->lip));
+	memcpy(fwr->lipm, f->fs.mask.lip, sizeof(fwr->lipm));
+	memcpy(fwr->fip, f->fs.val.fip, sizeof(fwr->fip));
+	memcpy(fwr->fipm, f->fs.mask.fip, sizeof(fwr->fipm));
 	fwr->lp = cpu_to_be16(f->fs.val.lport);
 	fwr->lpm = cpu_to_be16(f->fs.mask.lport);
 	fwr->fp = cpu_to_be16(f->fs.val.fport);
diff --git a/drivers/net/cxgbe/l2t.c b/drivers/net/cxgbe/l2t.c
index ecb5fec911..19a190314f 100644
--- a/drivers/net/cxgbe/l2t.c
+++ b/drivers/net/cxgbe/l2t.c
@@ -82,7 +82,7 @@ static int write_l2e(struct rte_eth_dev *dev, struct l2t_entry *e, int sync,
 				  V_L2T_W_NOREPLY(!sync));
 	req->l2t_idx = cpu_to_be16(l2t_idx);
 	req->vlan = cpu_to_be16(e->vlan);
-	rte_memcpy(req->dst_mac, e->dmac, RTE_ETHER_ADDR_LEN);
+	memcpy(req->dst_mac, e->dmac, RTE_ETHER_ADDR_LEN);
 
 	if (loopback)
 		memset(req->dst_mac, 0, RTE_ETHER_ADDR_LEN);
@@ -155,7 +155,7 @@ static struct l2t_entry *t4_l2t_alloc_switching(struct rte_eth_dev *dev,
 			e->state = L2T_STATE_SWITCHING;
 			e->vlan = vlan;
 			e->lport = port;
-			rte_memcpy(e->dmac, eth_addr, RTE_ETHER_ADDR_LEN);
+			memcpy(e->dmac, eth_addr, RTE_ETHER_ADDR_LEN);
 			rte_atomic_store_explicit(&e->refcnt, 1, rte_memory_order_relaxed);
 			ret = write_l2e(dev, e, 0, !L2T_LPBK, !L2T_ARPMISS);
 			if (ret < 0)
diff --git a/drivers/net/cxgbe/smt.c b/drivers/net/cxgbe/smt.c
index 2f961c1ead..8f26dc572a 100644
--- a/drivers/net/cxgbe/smt.c
+++ b/drivers/net/cxgbe/smt.c
@@ -55,26 +55,24 @@ static int write_smt_entry(struct rte_eth_dev *dev, struct smt_entry *e)
 		 */
 		if (e->idx & 1) {
 			req->pfvf1 = 0x0;
-			rte_memcpy(req->src_mac1, e->src_mac,
-				   RTE_ETHER_ADDR_LEN);
+			memcpy(req->src_mac1, e->src_mac, RTE_ETHER_ADDR_LEN);
 
 			/* fill pfvf0/src_mac0 with entry
 			 * at prev index from smt-tab.
 			 */
 			req->pfvf0 = 0x0;
-			rte_memcpy(req->src_mac0, s->smtab[e->idx - 1].src_mac,
-				   RTE_ETHER_ADDR_LEN);
+			memcpy(req->src_mac0, s->smtab[e->idx - 1].src_mac,
+			       RTE_ETHER_ADDR_LEN);
 		} else {
 			req->pfvf0 = 0x0;
-			rte_memcpy(req->src_mac0, e->src_mac,
-				   RTE_ETHER_ADDR_LEN);
+			memcpy(req->src_mac0, e->src_mac, RTE_ETHER_ADDR_LEN);
 
 			/* fill pfvf1/src_mac1 with entry
 			 * at next index from smt-tab
 			 */
 			req->pfvf1 = 0x0;
-			rte_memcpy(req->src_mac1, s->smtab[e->idx + 1].src_mac,
-				   RTE_ETHER_ADDR_LEN);
+			memcpy(req->src_mac1, s->smtab[e->idx + 1].src_mac,
+			       RTE_ETHER_ADDR_LEN);
 		}
 		row = (e->hw_idx >> 1);
 	} else {
@@ -87,8 +85,8 @@ static int write_smt_entry(struct rte_eth_dev *dev, struct smt_entry *e)
 
 		/* fill pfvf0/src_mac0 from smt-tab */
 		t6req->pfvf0 = 0x0;
-		rte_memcpy(t6req->src_mac0, s->smtab[e->idx].src_mac,
-			   RTE_ETHER_ADDR_LEN);
+		memcpy(t6req->src_mac0, s->smtab[e->idx].src_mac,
+		       RTE_ETHER_ADDR_LEN);
 		row = e->hw_idx;
 		req = (struct cpl_smt_write_req *)t6req;
 	}
@@ -158,7 +156,7 @@ static struct smt_entry *t4_smt_alloc_switching(struct rte_eth_dev *dev,
 		t4_os_lock(&e->lock);
 		if (rte_atomic_load_explicit(&e->refcnt, rte_memory_order_relaxed) == 0) {
 			e->pfvf = pfvf;
-			rte_memcpy(e->src_mac, smac, RTE_ETHER_ADDR_LEN);
+			memcpy(e->src_mac, smac, RTE_ETHER_ADDR_LEN);
 			ret = write_smt_entry(dev, e);
 			if (ret) {
 				e->pfvf = 0;
-- 
2.53.0

