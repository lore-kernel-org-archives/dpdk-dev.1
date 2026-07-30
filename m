Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B759C55162
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Jul 2026 11:19:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D6AB40274;
	Thu, 30 Jul 2026 13:19:32 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 684BE40272
 for <dev@dpdk.org>; Thu, 30 Jul 2026 13:19:31 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=Z6vAuCJq2ig+0sH954CCHVEmI7EWk97LDg18tngoDjs=;
 b=4Jf/N5t/khc7Oxu/6NZzSPviUSTjNyy9zBQo0Dx7OmNbFIXDJehkspTVxW7S6yJ4YHesnzNwD
 k79RQ9BJ2112IS9WGV3yRFWa8R2aUQo3Auz/Ss3vWx4ys24zX/q98PNScTvjVIcdffWusB/DTFi
 KDgI1rZfs1lwEIRcKdY/t60=
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4h9mt63jd8zJ46cf;
 Thu, 30 Jul 2026 19:18:54 +0800 (CST)
Received: from frapema500002.china.huawei.com (unknown [7.182.19.148])
 by mail.maildlp.com (Postfix) with ESMTPS id 82D4740577;
 Thu, 30 Jul 2026 19:19:29 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500002.china.huawei.com (7.182.19.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 30 Jul 2026 13:19:29 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Thu, 30 Jul 2026 13:19:29 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Marat Khalili <marat.khalili@huawei.com>, Stephen Hemminger
 <stephen@networkplumber.org>, "dev@dpdk.org" <dev@dpdk.org>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: RE: [RFC 01/32] bpf: replace deprecated SMP barriers with C11 fences
Thread-Topic: [RFC 01/32] bpf: replace deprecated SMP barriers with C11 fences
Thread-Index: AQHdH4O2ptQbX30vgEiaf+/z/N+qaraFv74wgAAqXcA=
Date: Thu, 30 Jul 2026 11:19:28 +0000
Message-ID: <d63e76c3f5154e1595267cd87e23398f@huawei.com>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260729175715.165120-2-stephen@networkplumber.org>
 <a6a65fbd303f4ef3ba93fbe67d5ef022@huawei.com>
In-Reply-To: <a6a65fbd303f4ef3ba93fbe67d5ef022@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.16]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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

Gemini's suggestion FWIW (looks sensible but not tested):

---

This commit replaces the deprecated DPDK SMP memory barriers in the
BPF packet processing module with standard C11 atomic operations.=20

Rather than relying on standalone explicit fences (which can introduce=20
unnecessary overhead and are less idiomatic in C11), this patch=20
embeds the memory ordering directly into the atomic operations:

1. The usage counter (`cbi->use`) now utilizes `rte_atomic_fetch_add_explic=
it`.
   Entering the callback uses `acquire` semantics, and exiting uses
   `release` semantics, forming a proper lightweight lock without standalon=
e fences.
2. The callback pointer (`cbi->cb`) is marked as `RTE_ATOMIC` to prevent=20
   data races between the datapath and control path. It is updated=20
   and read using explicit atomic loads/stores with `acquire`/`release` sem=
antics.

---
 lib/bpf/bpf_pkt.c | 61 +++++++++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 26 deletions(-)

diff --git a/lib/bpf/bpf_pkt.c b/lib/bpf/bpf_pkt.c
index f072fdaaed..a831b5ad86 100644
--- a/lib/bpf/bpf_pkt.c
+++ b/lib/bpf/bpf_pkt.c
@@ -30,7 +30,7 @@
 struct __rte_cache_aligned bpf_eth_cbi {
 	/* used by both data & control path */
 	RTE_ATOMIC(uint32_t) use;    /*usage counter */
-	const struct rte_eth_rxtx_callback *cb;  /* callback handle */
+	RTE_ATOMIC(const struct rte_eth_rxtx_callback *) cb;  /* callback handle =
*/
 	struct rte_bpf *bpf;
 	struct rte_bpf_jit jit;
 	/* used by control path only */
@@ -80,9 +80,7 @@ static struct bpf_eth_cbh tx_cbh =3D {
 static __rte_always_inline void
 bpf_eth_cbi_inuse(struct bpf_eth_cbi *cbi)
 {
-	cbi->use++;
-	/* make sure no store/load reordering could happen */
-	rte_smp_mb();
+	rte_atomic_fetch_add_explicit(&cbi->use, 1, rte_memory_order_acquire);
 }
=20
 /*
@@ -91,9 +89,7 @@ bpf_eth_cbi_inuse(struct bpf_eth_cbi *cbi)
 static __rte_always_inline void
 bpf_eth_cbi_unuse(struct bpf_eth_cbi *cbi)
 {
-	/* make sure all previous loads are completed */
-	rte_smp_rmb();
-	cbi->use++;
+	rte_atomic_fetch_add_explicit(&cbi->use, 1, rte_memory_order_release);
 }
=20
 /*
@@ -104,15 +100,12 @@ bpf_eth_cbi_wait(const struct bpf_eth_cbi *cbi)
 {
 	uint32_t puse;
=20
-	/* make sure all previous loads and stores are completed */
-	rte_smp_mb();
-
-	puse =3D cbi->use;
+	puse =3D rte_atomic_load_explicit(&cbi->use, rte_memory_order_acquire);
=20
 	/* in use, busy wait till current RX/TX iteration is finished */
 	if ((puse & BPF_ETH_CBI_INUSE) !=3D 0) {
 		RTE_WAIT_UNTIL_MASKED((__rte_atomic uint32_t *)(uintptr_t)&cbi->use,
-			UINT32_MAX, !=3D, puse, rte_memory_order_relaxed);
+			UINT32_MAX, !=3D, puse, rte_memory_order_acquire);
 	}
 }
=20
@@ -201,11 +194,13 @@ bpf_rx_callback_vm(__rte_unused uint16_t port, __rte_=
unused uint16_t queue,
 {
 	struct bpf_eth_cbi *cbi;
 	uint16_t rc;
+	const struct rte_eth_rxtx_callback *cb;
=20
 	cbi =3D user_param;
=20
 	bpf_eth_cbi_inuse(cbi);
-	rc =3D (cbi->cb !=3D NULL) ?
+	cb =3D rte_atomic_load_explicit(&cbi->cb, rte_memory_order_acquire);
+	rc =3D (cb !=3D NULL) ?
 		pkt_filter_vm(cbi->bpf, pkt, nb_pkts, 1) :
 		nb_pkts;
 	bpf_eth_cbi_unuse(cbi);
@@ -219,10 +214,12 @@ bpf_rx_callback_jit(__rte_unused uint16_t port, __rte=
_unused uint16_t queue,
 {
 	struct bpf_eth_cbi *cbi;
 	uint16_t rc;
+	const struct rte_eth_rxtx_callback *cb;
=20
 	cbi =3D user_param;
 	bpf_eth_cbi_inuse(cbi);
-	rc =3D (cbi->cb !=3D NULL) ?
+	cb =3D rte_atomic_load_explicit(&cbi->cb, rte_memory_order_acquire);
+	rc =3D (cb !=3D NULL) ?
 		pkt_filter_jit(&cbi->jit, pkt, nb_pkts, 1) :
 		nb_pkts;
 	bpf_eth_cbi_unuse(cbi);
@@ -236,10 +233,12 @@ bpf_tx_callback_vm(__rte_unused uint16_t port, __rte_=
unused uint16_t queue,
 {
 	struct bpf_eth_cbi *cbi;
 	uint16_t rc;
+	const struct rte_eth_rxtx_callback *cb;
=20
 	cbi =3D user_param;
 	bpf_eth_cbi_inuse(cbi);
-	rc =3D (cbi->cb !=3D NULL) ?
+	cb =3D rte_atomic_load_explicit(&cbi->cb, rte_memory_order_acquire);
+	rc =3D (cb !=3D NULL) ?
 		pkt_filter_vm(cbi->bpf, pkt, nb_pkts, 0) :
 		nb_pkts;
 	bpf_eth_cbi_unuse(cbi);
@@ -253,10 +252,12 @@ bpf_tx_callback_jit(__rte_unused uint16_t port, __rte=
_unused uint16_t queue,
 {
 	struct bpf_eth_cbi *cbi;
 	uint16_t rc;
+	const struct rte_eth_rxtx_callback *cb;
=20
 	cbi =3D user_param;
 	bpf_eth_cbi_inuse(cbi);
-	rc =3D (cbi->cb !=3D NULL) ?
+	cb =3D rte_atomic_load_explicit(&cbi->cb, rte_memory_order_acquire);
+	rc =3D (cb !=3D NULL) ?
 		pkt_filter_jit(&cbi->jit, pkt, nb_pkts, 0) :
 		nb_pkts;
 	bpf_eth_cbi_unuse(cbi);
@@ -274,10 +275,12 @@ bpf_rx_callback_mb_vm(__rte_unused uint16_t port, __r=
te_unused uint16_t queue,
 {
 	struct bpf_eth_cbi *cbi;
 	uint16_t rc;
+	const struct rte_eth_rxtx_callback *cb;
=20
 	cbi =3D user_param;
 	bpf_eth_cbi_inuse(cbi);
-	rc =3D (cbi->cb !=3D NULL) ?
+	cb =3D rte_atomic_load_explicit(&cbi->cb, rte_memory_order_acquire);
+	rc =3D (cb !=3D NULL) ?
 		pkt_filter_mb_vm(cbi->bpf, pkt, nb_pkts, 1) :
 		nb_pkts;
 	bpf_eth_cbi_unuse(cbi);
@@ -292,10 +295,12 @@ bpf_rx_callback_mb_jit(__rte_unused uint16_t port, __=
rte_unused uint16_t queue,
 {
 	struct bpf_eth_cbi *cbi;
 	uint16_t rc;
+	const struct rte_eth_rxtx_callback *cb;
=20
 	cbi =3D user_param;
 	bpf_eth_cbi_inuse(cbi);
-	rc =3D (cbi->cb !=3D NULL) ?
+	cb =3D rte_atomic_load_explicit(&cbi->cb, rte_memory_order_acquire);
+	rc =3D (cb !=3D NULL) ?
 		pkt_filter_mb_jit(&cbi->jit, pkt, nb_pkts, 1) :
 		nb_pkts;
 	bpf_eth_cbi_unuse(cbi);
@@ -309,10 +314,12 @@ bpf_tx_callback_mb_vm(__rte_unused uint16_t port, __r=
te_unused uint16_t queue,
 {
 	struct bpf_eth_cbi *cbi;
 	uint16_t rc;
+	const struct rte_eth_rxtx_callback *cb;
=20
 	cbi =3D user_param;
 	bpf_eth_cbi_inuse(cbi);
-	rc =3D (cbi->cb !=3D NULL) ?
+	cb =3D rte_atomic_load_explicit(&cbi->cb, rte_memory_order_acquire);
+	rc =3D (cb !=3D NULL) ?
 		pkt_filter_mb_vm(cbi->bpf, pkt, nb_pkts, 0) :
 		nb_pkts;
 	bpf_eth_cbi_unuse(cbi);
@@ -326,10 +333,12 @@ bpf_tx_callback_mb_jit(__rte_unused uint16_t port, __=
rte_unused uint16_t queue,
 {
 	struct bpf_eth_cbi *cbi;
 	uint16_t rc;
+	const struct rte_eth_rxtx_callback *cb;
=20
 	cbi =3D user_param;
 	bpf_eth_cbi_inuse(cbi);
-	rc =3D (cbi->cb !=3D NULL) ?
+	cb =3D rte_atomic_load_explicit(&cbi->cb, rte_memory_order_acquire);
+	rc =3D (cb !=3D NULL) ?
 		pkt_filter_mb_jit(&cbi->jit, pkt, nb_pkts, 0) :
 		nb_pkts;
 	bpf_eth_cbi_unuse(cbi);
@@ -382,8 +391,7 @@ static void
 bpf_eth_cbi_unload(struct bpf_eth_cbi *bc)
 {
 	/* mark this cbi as empty */
-	bc->cb =3D NULL;
-	rte_smp_mb();
+	rte_atomic_store_explicit(&bc->cb, NULL, rte_memory_order_release);
=20
 	/* make sure datapath doesn't use bpf anymore, then destroy bpf */
 	bpf_eth_cbi_wait(bc);
@@ -395,14 +403,17 @@ static void
 bpf_eth_unload(struct bpf_eth_cbh *cbh, uint16_t port, uint16_t queue)
 {
 	struct bpf_eth_cbi *bc;
+	const struct rte_eth_rxtx_callback *cb;
=20
 	bc =3D bpf_eth_cbh_find(cbh, port, queue);
-	if (bc =3D=3D NULL || bc->cb =3D=3D NULL)
+	if (bc =3D=3D NULL)
+		return;
+	cb =3D rte_atomic_load_explicit(&bc->cb, rte_memory_order_acquire);
+	if (cb =3D=3D NULL)
 		return;
=20
 	if (cbh->type =3D=3D BPF_ETH_RX)
-		rte_eth_remove_rx_callback(port, queue, bc->cb);
+		rte_eth_remove_rx_callback(port, queue, cb);
 	else
-		rte_eth_remove_tx_callback(port, queue, bc->cb);
+		rte_eth_remove_tx_callback(port, queue, cb);
=20
 	bpf_eth_cbi_unload(bc);
 }
@@ -439,6 +450,7 @@ bpf_eth_elf_install(struct bpf_eth_cbh *cbh, uint16_t p=
ort, uint16_t queue,
 	rte_rx_callback_fn frx;
 	rte_tx_callback_fn ftx;
 	struct rte_bpf_jit jit;
+	const struct rte_eth_rxtx_callback *cb;
=20
 	frx =3D NULL;
 	ftx =3D NULL;
@@ -470,17 +482,18 @@ bpf_eth_elf_install(struct bpf_eth_cbh *cbh, uint16_t=
 port, uint16_t queue,
 		return -ENOMEM;
=20
 	/* remove old one, if any */
-	if (bc->cb !=3D NULL)
+	if (rte_atomic_load_explicit(&bc->cb, rte_memory_order_acquire) !=3D NULL=
)
 		bpf_eth_unload(cbh, port, queue);
=20
 	bc->bpf =3D bpf;
 	bc->jit =3D jit;
=20
 	if (cbh->type =3D=3D BPF_ETH_RX)
-		bc->cb =3D rte_eth_add_rx_callback(port, queue, frx, bc);
+		cb =3D rte_eth_add_rx_callback(port, queue, frx, bc);
 	else
-		bc->cb =3D rte_eth_add_tx_callback(port, queue, ftx, bc);
+		cb =3D rte_eth_add_tx_callback(port, queue, ftx, bc);
=20
-	if (bc->cb =3D=3D NULL) {
+	rte_atomic_store_explicit(&bc->cb, cb, rte_memory_order_release);
+	if (cb =3D=3D NULL) {
 		rc =3D -rte_errno;
 		bpf_eth_cbi_cleanup(bc);
