Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28695CC6B12
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 22:37:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA84D40B9D;
	Wed, 14 Oct 2026 00:35:32 +0200 (CEST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id 88A8D40B9D
 for <dev@dpdk.org>; Wed, 14 Oct 2026 00:35:29 +0200 (CEST)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2e7e742a2c7so23442525ad.0
 for <dev@dpdk.org>; Tue, 13 Oct 2026 15:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791930929;
 x=1792535729; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zf08NATFxbVviYWDI8GRClntoGL1OzsssyPwEl8RsKo=;
 b=H0PUlHQB85hhD+GcCfKOrp+MR48KWPyMHdQQuojBXyw8voXYr77XjwC7G3Vfu5Fclc
 9F0yCxjYmMJzndaIwR200jLKwPI/Fpgra+7enr5eC2wG4E1fMygsx9zE2iVHlfBPILyw
 Jl7L42vUaxC1BGJLetp/lTJWCXtn1+WaFX7IH527TpeV+obZe38HbI46FOr/VX/PT8/F
 Y2WxVp9NkKsWl2F/DTjz36JQBuarpH9AA0K/nczpnmp6yK/86MFolITsLC2pmTO1YdsL
 BptOkb0fDtkyl52t8uv1Wm8wWzi19I6szUSv06I+MgtKdE/ARjXYOFKCPhhmZq/jtHRP
 F2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791930929; x=1792535729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zf08NATFxbVviYWDI8GRClntoGL1OzsssyPwEl8RsKo=;
 b=QaYVVwrry8AJ/88og93t6Ts4WsS0nd49ewKarPyMfyRkhFXdtCy/AWKOMrZPGvIitq
 AuP3W2IC4oHBAeIy0YG9b0QAKmoNYzj4f1iyMuzxPcvuCPwgr8JzSyt//uai1CBFJNqH
 e+c2nGaGcc/QGlq5duQx/XCtHGOKlq8R+gyL//dUv/c5TLeIYIrUNdoFT5QrRhz/dJps
 ouB10gTo4RK8lMzc+5Ll5xAuICl0LifDBe8z6IAtmgKEr1Gj/wK4C8NoM7iDX9E5NHCx
 la6+0ZlOd65tdIGNvkg7r79wqBddB0WIyQngCH0CjrHIoskvm4WYXSSOrBe1bBAoT+2/
 ZA3A==
X-Gm-Message-State: AFq9FYKnVxdTP49bS779qn6jBqNdmhtWKW53miCwyA968Ka9etVpwV4h
 7Fl32vLOrfXyXLv6BpnHtRpE+p1P7e1+P506ZWivasE8sEp4K1bgotztpmzF3WYbfmZtr1937dy
 7lgj3ONQ=
X-Gm-Gg: AYBFou3CKtWyhtl1ZB/dX0ruVsJFFU0n0dtIyJfY9+jFT/l8c6xkE3WXrFKLC8ALPyz
 UL9fmIga+3gvsl38Mg9XdAOXgsgG4z98tz1seWv9POpg10Oib3jtEmXhj52ENNa7Nd8lQXqaN/p
 qe76KHd4RiqslcFU82vGo3nZLlUcp+YeaVPKLI5jecyBKk0R6K0Sz+skzpIydBuPb5jWG1vdO3z
 VHgacpWZqrZ5V7XB7pMau7TbNar0d4quLkuozsROptN28nHHGHwse8kUUy4OvlkYT7OhEy1oOAR
 hPpYEy/wIL82igM2+xYxUJ2kQ+K+sxS437wxZReU1BH1aiVZyfx0gC/580Hk9FwzoWmcose0tjX
 fGUo2OJ/IkdHGiTQR/lCLxaOnkv1XfT8WLOTsIJHIrnSAKFgG2Y9sEU4QyibReErU+yfaZTbD6N
 4sFNhjWUatSHql2gPTGSZMUhdvGkG0+Wopevdl/MVpa/cOauG4j13PJrRmThm5nDNq9LPGAAwHT
 6rnWZpGlwX1oiR+3Jmf6CYaM+C4u7BqE6rxhw==
X-Received: by 2002:a17:902:eccb:b0:2e8:6540:11ba with SMTP id
 d9443c01a7336-2e865401250mr79548005ad.20.1791930928735; 
 Tue, 13 Oct 2026 15:35:28 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8421b19a2sm61865145ad.46.2026.10.13.15.35.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 15:35:28 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v4 27/29] net/virtio: replace deprecated barrier in avail
 index update
Date: Tue, 13 Oct 2026 15:22:40 -0700
Message-ID: <20261013222410.2257622-28-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013222410.2257622-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261013222410.2257622-1-stephen@networkplumber.org>
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

As with virtqueue_nused(), the x86 special case only pays off while
both arms of the weak_barriers test compile to the same thing, which
rules out rte_atomic_thread_fence(rte_memory_order_release). Use
rte_io_wmb(), a compiler barrier on x86, where stores are not
reordered with other stores.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/virtio/virtqueue.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/virtio/virtqueue.h b/drivers/net/virtio/virtqueue.h
index ee21d43068..8fd2999132 100644
--- a/drivers/net/virtio/virtqueue.h
+++ b/drivers/net/virtio/virtqueue.h
@@ -474,14 +474,14 @@ static inline void
 vq_update_avail_idx(struct virtqueue *vq)
 {
 	if (vq->hw->weak_barriers) {
-	/* x86 prefers to using rte_smp_wmb over rte_atomic_store_explicit as
-	 * it reports a slightly better perf, which comes from the
-	 * saved branch by the compiler.
-	 * The if and else branches are identical with the smp and
-	 * io barriers both defined as compiler barriers on x86.
+	/* x86 prefers rte_io_wmb over rte_atomic_store_explicit as it
+	 * reports a slightly better perf, which comes from the saved
+	 * branch by the compiler: on x86 this makes the two branches
+	 * identical, since rte_io_wmb() is only a compiler barrier and
+	 * stores are not reordered with other stores.
 	 */
 #ifdef RTE_ARCH_X86_64
-		rte_smp_wmb();
+		rte_io_wmb();
 		vq->vq_split.ring.avail->idx = vq->vq_avail_idx;
 #else
 		rte_atomic_store_explicit(&vq->vq_split.ring.avail->idx,
-- 
2.53.0

