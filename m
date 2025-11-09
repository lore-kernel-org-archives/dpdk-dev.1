Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F97CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Sun,  9 Nov 2025 20:09:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84AD340652;
	Sun,  9 Nov 2025 21:09:08 +0100 (CET)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46]) by mails.dpdk.org (Postfix) with ESMTP id 51BBD4042E
 for <dev@dpdk.org>; Sun,  9 Nov 2025 21:09:06 +0100 (CET)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-34374febdefso1207948a91.0
 for <dev@dpdk.org>; Sun, 09 Nov 2025 12:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762718945;
 x=1763323745; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0+X6hc4mXqUZBC/NIeCKfVPaLvydX6rHrQkCB8c0WBY=;
 b=UaOwBy8gz7QEoy58Vgwb/cr4oKTDzOwSLwtblCe9/PNhrkokLmeiCr0adsRQIhqd2j
 sr1Ufs86ZGbADgQhKVI4FNFXnlOdNiIRYWk/WRSzbvzpPnZ1PYNS+Bh8/cqMyQ+Fg3nN
 rAwhEc44wNcf7ECFxTCLOVonKA1/xyEoe5aLt4WCBR8zDncgWhlv+0nK9xNFKTkZwn9X
 JYOLHaSpn3nsZK2+oxurS6Ok5LxUoSNIk5CeifRCAu1lNwcISfS35BWRU1izy9lbtuli
 hCiuJI5mqKmfI0VFUvZ3kvi1dtqWyIjevHlKRWLrdLHz5Q7DaMWwEF1iufBLk43Eey7/
 p9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762718945; x=1763323745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0+X6hc4mXqUZBC/NIeCKfVPaLvydX6rHrQkCB8c0WBY=;
 b=RU9aYey2bD+nCIQtCA+nkmjQDbJ01fxusXnn3skKh2QYf9yLV5XXFUwhdc0F/8/8aM
 9xcq26VrY72zljccTDtpr67BiLmNeEtV57Tafttt7Nq0AGw820RWgtiPRyeoWXPF+64D
 T/teoMPhU0mJqKH6zAox9tKvq7uoGUf2vcXYLefjQES2X9yr2uT00f3phMg93Q70A0Th
 8iFUSyeRCReCQoMTJW/zjsjEuuSzMfsPVwC6Gti677BhIDqXLwseD13kEGtSogQmnP57
 NsZPtQyI/JFVhGfC4+KJ4sVCb5r8gGqj5sEIDbuU9JfNf2DMKX2nskpbC0+ujRbdWSCr
 4C8w==
X-Gm-Message-State: AOJu0Yw3T4P3YgCLn3WC2MgWqt+wQrElNGHV7MQePgOLqs3PTlPa9G5l
 4RFROqR/fQDd1TIjSzzEz/9mjso46W8T0gc58x28dkNSjqHKCurWiMkZv6aI8RclhEMHrBNbgyh
 oGZW6Shg=
X-Gm-Gg: ASbGncuW2UWriNGFXR5ecxEFBXr4LdK0kNlxRsXiVw15Cj9FZAeI4utWSdvA45wAQLc
 cYF+Usm42Xazzb6Um3HKKGE/KVdQivz9e41OasV2iQMWgs7x2Vva77Pd4W+U3JChsrlcEbvgQWG
 oz4XKwK7wxEzvTuIq6IebEN5R7LQnFkzJrbfFSMyQp2gMy+P1tTfCunWKU2I86tFeaU7E6XcXHY
 h+e8mfmxDbsnvxGnrZxpZTGfSWGXmLJXUy7M+KRH50eSoqFN9CLKQyuRXCJEW+NbG2NTAmhpAqx
 uP8Cv0hUVcU6TYicUoQkqkXq4/RuPWV7x/Ji3hnPnqkFxulAAVWNW2zx1P70xYwqHMjkSqt432D
 5qkIW2himqBLQ/+nPqNNHu6j2+qqdBmfDdDgdH4JY+IFICc0XKWdAiZp//aAsCLyth7c7Wzg99P
 nLo+2d3HCJd0Ue+eHncMAMtCyBGPJVqYdbvaKfhg1EmmL1QmoZqg==
X-Google-Smtp-Source: AGHT+IEKJEVDL0VRCuV/M+2Ardxj+JcvLCemd3uwExXzHmm+ldP/J785STOtfN/Pdeq8Sdp/I7dP2Q==
X-Received: by 2002:a17:90b:4c8a:b0:340:fb6a:cb4c with SMTP id
 98e67ed59e1d1-3436cd064efmr7781861a91.30.1762718945522; 
 Sun, 09 Nov 2025 12:09:05 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-341a699d6dfsm15396648a91.16.2025.11.09.12.09.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Nov 2025 12:09:05 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v5 5/5] bpf: replace use of VLA
Date: Sun,  9 Nov 2025 12:07:38 -0800
Message-ID: <20251109200854.45942-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251109200854.45942-1-stephen@networkplumber.org>
References: <20251030173732.246435-1-stephen@networkplumber.org>
 <20251109200854.45942-1-stephen@networkplumber.org>
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

Variable length arrays are extension not required in C standard
and not available in Windows.
Use alloca() instead of variable length array.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Reviewed-by: Marat Khalili <marat.khalili@huawei.com>
---
 lib/bpf/bpf_pkt.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/bpf/bpf_pkt.c b/lib/bpf/bpf_pkt.c
index 087ac0f244..5007f6aef5 100644
--- a/lib/bpf/bpf_pkt.c
+++ b/lib/bpf/bpf_pkt.c
@@ -163,7 +163,7 @@ apply_filter(struct rte_mbuf *mb[], const uint64_t rc[], uint32_t num,
 	uint32_t drop)
 {
 	uint32_t i, j, k;
-	struct rte_mbuf *dr[num];
+	struct rte_mbuf **dr = alloca(num * sizeof(struct rte_mbuf *));
 
 	for (i = 0, j = 0, k = 0; i != num; i++) {
 
@@ -192,8 +192,8 @@ pkt_filter_vm(const struct rte_bpf *bpf, struct rte_mbuf *mb[], uint32_t num,
 	uint32_t drop)
 {
 	uint32_t i;
-	void *dp[num];
-	uint64_t rc[num];
+	void **dp = alloca(num * sizeof(void *));
+	uint64_t *rc = alloca(num * sizeof(uint64_t));
 
 	for (i = 0; i != num; i++)
 		dp[i] = rte_pktmbuf_mtod(mb[i], void *);
@@ -208,7 +208,7 @@ pkt_filter_jit(const struct rte_bpf_jit *jit, struct rte_mbuf *mb[],
 {
 	uint32_t i, n;
 	void *dp;
-	uint64_t rc[num];
+	uint64_t *rc = alloca(num * sizeof(uint64_t));
 
 	n = 0;
 	for (i = 0; i != num; i++) {
@@ -227,7 +227,7 @@ static inline uint32_t
 pkt_filter_mb_vm(const struct rte_bpf *bpf, struct rte_mbuf *mb[], uint32_t num,
 	uint32_t drop)
 {
-	uint64_t rc[num];
+	uint64_t *rc = alloca(num * sizeof(uint64_t));
 
 	rte_bpf_exec_burst(bpf, (void **)mb, rc, num);
 	return apply_filter(mb, rc, num, drop);
@@ -238,7 +238,7 @@ pkt_filter_mb_jit(const struct rte_bpf_jit *jit, struct rte_mbuf *mb[],
 	uint32_t num, uint32_t drop)
 {
 	uint32_t i, n;
-	uint64_t rc[num];
+	uint64_t *rc = alloca(num * sizeof(uint64_t));
 
 	n = 0;
 	for (i = 0; i != num; i++) {
-- 
2.51.0

