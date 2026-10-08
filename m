Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE0DCA6015
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 23:39:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D1EE740BA6;
	Fri,  9 Oct 2026 01:37:48 +0200 (CEST)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by mails.dpdk.org (Postfix) with ESMTP id 930B840DD6
 for <dev@dpdk.org>; Fri,  9 Oct 2026 01:37:47 +0200 (CEST)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-8935f42e8f0so619948b3a.2
 for <dev@dpdk.org>; Thu, 08 Oct 2026 16:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791502667;
 x=1792107467; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zf08NATFxbVviYWDI8GRClntoGL1OzsssyPwEl8RsKo=;
 b=MOazwFY4VvAB+S2hB3OEgbTSrLqxDi4JxDreNuPttv46p/SJ3flDHUkDcASp5WNjGP
 gmj/97AFYynE6c1RY1kOraQBUL6eCG8U273XgEBh+via7DcG+irL/Ugt0aH8PGejuWCw
 8B0uipxtL2x6Y1D9gZ1hZ7NrlNmJ6ztyULPXVpCEGqALWZfy92fIYg8Q7GLk12DA9Xa7
 +PbxgzLC+ZQO55SFh7NyDMD6tXGmXmJ8BUrr+XXtFiTMR4Q74QdEQekxRWAzfZYAeIZe
 ugLiCxJ8JQuCEpRMyu5jmt7mP4A95HgtuLaCoG/tySyEOqn/QwDF5B5O3/KBrwDR60qm
 WPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791502667; x=1792107467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zf08NATFxbVviYWDI8GRClntoGL1OzsssyPwEl8RsKo=;
 b=KopziplYdUFzmKjA3tdqIp8bKWXT8UxVaDJYtHKUeFZUF37uVZ6VMLHQDSH8qvNN3J
 STUaebVKdv1P9qhT67t75JiFZedMdQAhDrI9R9bgq2BCjC5S3qgir/RJDaOOq9aPi5pS
 NQB5MeNRhWHsXCM6806uXY+FHlhTBupj6qQsz0d+bS9QMhALoGkR7fnlXYc2LYmdPhsd
 IKMjX42swk+ZCzaE7raZGwbEzya65RiJMWqYgs3THI4MUu6bl72BckN8GFZivYEkD+7t
 sRlXu440ALK6VpizByf3PVNECiwt40I43kPc7aXIJVaqfWZRVT0RPc/HEvvxvSO0xJpP
 JLBg==
X-Gm-Message-State: AFuF++mjhG/9KwahYxBrdW9PhM4xGJu1ilUBAy/BIhuzF5Q87ajnSTRj
 OA5mCBGU1UfdiyhH6V4Gj0aZY65dTC2fb1Unennc9qwinVaEaqWWvXgm6gP/6oId+bXPQgHqgDC
 PF5vVi14=
X-Gm-Gg: AYBFou1RERC9A/VZwnpiP7s9WXiOIdtab+g+HD8QBpvWqVblCQZ6PHtQTuluIBEPAqj
 L+5Ewa9qnNwHvfa5KLHrkJuh9V/DiRz8lXtbHXhMpFPZL9a7hd++CySobD4phF1RBcjr5Lve+N0
 5hHzgX/gcHDh6bdon9VQOfm5pvLX3xL29/HebisrAe+UCHRCTy/OxLaoJGgH+ebgiFMyY7TBeY1
 nzcJ7GXgaSsiRamEKdWJjyDmjn+hmXogroSeoCeTRTUZwBQ2NH4DtVWxjXk13s9SpwfizJWViaT
 75gv08vNTGNoSsCClRDskdx6fjsSrWW7RlHfUc7q6PMh5x/QLkmCrHREt3qUYzqfMlFsuEvc9pW
 zHzazONlf75nUfxKuGYlGU/Fds8BdFkyj5QRy0U9QWr7ZsuK3KAvyjZe5kNMXX1vcCkmbsleySx
 y2SSfDGnj/uwuFHe2bTA7bdrUtWp+lY8NQ2XoVpV7q0fVrtpp8zMSyoQM5e8J0kwm8xYqgzEuI9
 P7Z5HyvB6YxxFK3bDkobq0qqeJRQgnHOONg0g==
X-Received: by 2002:a05:6a21:48d:b0:3de:6338:cfbe with SMTP id
 adf61e73a8af0-3e16c070c52mr7029637.55.1791502666760; 
 Thu, 08 Oct 2026 16:37:46 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-896c42b06e9sm187909b3a.42.2026.10.08.16.37.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 16:37:45 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v3 27/29] net/virtio: replace deprecated barrier in avail
 index update
Date: Thu,  8 Oct 2026 16:35:20 -0700
Message-ID: <20261008233649.1260843-28-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008233649.1260843-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261008233649.1260843-1-stephen@networkplumber.org>
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

