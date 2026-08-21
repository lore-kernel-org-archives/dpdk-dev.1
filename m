Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78DEC5DF8C
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:30:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B169406B7;
	Fri, 21 Aug 2026 21:29:51 +0200 (CEST)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by mails.dpdk.org (Postfix) with ESMTP id A4401406B7
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:29:49 +0200 (CEST)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-cb5b8572b70so1759197a12.2
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340589;
 x=1787945389; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2JKxy/A3XDVfMBFVLdmkTfrWLNJQgOwTu6pG9J8D0pg=;
 b=ZKr2IytnhwgiuAdUwmCe/no3wxQW7JfUyJGPRKMN4wxkV4bq0FXzF6R6xqgAtM9CrF
 Yijg0W9zweETTNklCjBh3DaSpQXubyH89VY0qQV8iYeaHJ8/24IVt16q1Cd3SkwA7HnE
 8LsAABzINJqvERj9bpl1yvGXZRQB/5LiXrOMAZ4usOkgAIMuPfem4vBXJJRXOJKA5QYq
 aEOIDZjlQH2noUK9FSlRM23fGTOd36gxZaZqXyzmTViZSPfRW4zxdL1rlvgtpc1bB5kt
 c/+kZtiyU3MrmUgVRXXkv0zSufonZ/HGWGCSny55DO5gWoNXqEWaRuEwy5pUBmvdhW5y
 mbAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340589; x=1787945389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2JKxy/A3XDVfMBFVLdmkTfrWLNJQgOwTu6pG9J8D0pg=;
 b=Xo7UqWDqhzElTBv8/2N/hUwB9joD4+mlPQFx+0sDoJuxkvo+XeNctvzy/dhKoo4jx9
 ns1aa21kJF59LIAYtX/MlpiTf31v/TZrpu6F4K0MAp0cTvIy/TOq87IBA0z0BH2F600W
 23eQD3YtAb3wo/i3cvEPnmVuSt8qCcUB2E2Zv9dSQjq4mFT7KgtIBrJe01nMTx8Ibg6B
 u01Y6Z8D5Ssc2SoBU5CpsE61dP5va/fSxbGrfvv6AZ637YlZJ8d5ww+ZaESl0wU4G3ep
 NfZzUt0YIrNcHBcDPmtDTpjx6tDkW39JMrBTdfrmYQHbKakiFktg/tZ6dGabQ5iO/vdW
 lavQ==
X-Gm-Message-State: AFuF++lWA2SsbBvFoGw9OP6Vtxp1T8JBYgwWqWdM7gRe6wcrTYEYAjh8
 zLQ+TQgAql5PTb8Ddywp++QGXW8oKlrEaJPg2L1m/5DS7k8r5u4lpKGdk6UcMzbcVsalYfZR4kn
 eSM1v
X-Gm-Gg: AR+sD13wlRw7O2Er8PHe3j7SIrIN06FNTUOKwsJug2A+14smzEUwaeHM1NTeUaAnhyZ
 PG6wO+EzmW/CnA/G+Cywr/0hZZGNwFqtHVlYu9R8OLUI6Ycb7aDkJ7tRfnw1NdKVbS/jD0KsUUV
 Mh6QVMOGEFotSkMOsI6kNxFDvurWXIBN7WhGrsZVJFglpU6ADizsVyhBa5xz39um0awLPAroCOX
 Xql6MXkyfiW1ooz75jUMwxhTyJdNE8gKNecGr0xCfXC+7M03h6DTepc9n/ht5Y5FV6uP4Cy8+qw
 tA2BvRZgppyOD9uQHDTaPUZv+bUt0xe64cPgfKmJyJFheUm8nuNpiAWGN66uqHPfHuHRcVMC3BN
 LvIFXiLcjKggWS2vSmmF1wfiA25yXUCd7grUiciE4AfpZTjNy1w1gPbUiWAlxhyjBG5OshIyhbh
 Q5+ZeVL7EOGfM9rijM+vI7c+OlnEogmzMkldpVCrG1x4KtU+qaY1ooZ4tivVwETAyiVMKOKM86a
 vg1Z1w0fSVboBRfQZZ8Fge6A84=
X-Received: by 2002:a05:6300:67c8:b0:3cc:2552:ddd7 with SMTP id
 adf61e73a8af0-3cd2fe76849mr17461823637.5.1787340588856; 
 Fri, 21 Aug 2026 12:29:48 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.29.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:29:48 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Potnuri Bharat Teja <bharat@chelsio.com>
Subject: [PATCH v2 31/68] net/cxgbe: replace use of rte_memcpy
Date: Fri, 21 Aug 2026 12:24:26 -0700
Message-ID: <20260821192646.146382-32-stephen@networkplumber.org>
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

