Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEECCC6B0F
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 22:36:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8D4540BA4;
	Wed, 14 Oct 2026 00:35:10 +0200 (CEST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id 834B340B8D
 for <dev@dpdk.org>; Wed, 14 Oct 2026 00:35:08 +0200 (CEST)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2db80fcdf8bso19780505ad.2
 for <dev@dpdk.org>; Tue, 13 Oct 2026 15:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791930908;
 x=1792535708; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=juElCyQVv9Sl6DDO65OhlCnvM/65YNpt3Fjee9d5t5c=;
 b=UTF7T5esNzL7WtWXesWuCJPPHjycQYjxmzGss+KOFBxT+vBfzw0HdY5lJHBMzRCPil
 /rXryVvlhH8Nyp2jVfKm6bBcmXcRDaMa3UPV0gMZSv46Jw/+ZedaAj1ne3FDTbRHkw/9
 9woNAoPbkJNplJFeC3/gZgi04vrp7jC6jP0f+znP2qI/bhNEve1X+aI/nK++FVmF0TCb
 OZh/QblfzpQjxLpxEjjgiuOG6ENGAxxYFBR/2ruaC+1qFgKypBUZztyaAsKYwLvWz+mY
 OiVHW+cMUPKWc+Bv48cs8Jd+UEIYrKwrF74WmQODULfUhxBggJYj0aAzAkhzAh0yceb9
 dY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791930908; x=1792535708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=juElCyQVv9Sl6DDO65OhlCnvM/65YNpt3Fjee9d5t5c=;
 b=nrqCDT4YTL5wWSS2y5rEoNSnPztJ7P/a+WeUYMYn/rpzYa/YCk0jqg7MI5PEctuq14
 SrnJjnsOhijB+7a3DLyxpX87njMcPx08bsgz17P1DGOm755t1SE1+c9v1vzLOce6R4xX
 p6gflTZ+zIHG/QZ/4smDv+2STik+y/Sn5mb77bKRb0wy3DBPYu7w1Sjdr8UDlR1NnmCN
 GULPSd2oE3Kme+xSD+0pXZz09x0uNkXBDxiG5Frwkg7N0coWSF6Ge4+Bs6XuoDm0ejzJ
 t/KRez61lJMhe+q2dD75CHQXIOv6aw+LmY+HR3jxwV4NhEWsnnZ2NhNTUe8p+BLf6G+y
 CWdg==
X-Gm-Message-State: AFq9FYIyFzM2AuBxV4y7A9GlervABsLYLEbs26ozsZ1kkZH7VG74zbLD
 7cOOU21Xd9A0BKIAAyZs9QUxPlassMdsy5CYJkcTorpcLi9mo73u4dn8WCyTOX2BvFQQ4/kUr55
 W0LZnmew=
X-Gm-Gg: AYBFou0vfUxUPozgKKTRvxhfd5BW1THj/WFkHMn0q9l3lm7/z+2ZksXV2KVXYA5tik3
 TeIf/6vp69dsc0AYPwvc2NlijKa6PfGNn8V2SESbsr23vuHV/PwDlWLrE/SjYgpZXanceuGKLDq
 lRYQDrS7PHCmxPlMVfzitELaU4R2nyZLXtVnYnSCuvRr8mr2Erp1pR1zHskmJ5ZP0k091nM/SMf
 clce07q8AcxvGZ8gqPpMXB89d8jG3xo2m6HuTjWFX0LT048V1a26Wu/HvmywsZb/ZNhmHwknyL6
 4dGhfy0UWYI60hTtQgzoN5UX/IJKdX+9H2DhH5b3rI2L0RTVrrfam0T8pz2tHXyA+RyoiBHIDVP
 qcBmPkVF6fqssDZOCvVKUEw2RTp0sZDBPLGlYYlZUHReb2/ZUfruP3smeO+Zw0X5RPS80bRwauH
 iiJ/VHeXbL91fDz+wXGOhy4YGQ88lmAV6x+i60JM2FhYlZ4ClC+b3hDwHpk3Zhc8kWioAZyamgj
 kOuehmOa1Q5VsM3ImMz7prpoxCzGIEjOVprTg==
X-Received: by 2002:a17:903:2f92:b0:2e3:1ed7:d5d3 with SMTP id
 d9443c01a7336-2e842cd448fmr111075485ad.67.1791930907631; 
 Tue, 13 Oct 2026 15:35:07 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8421b19a2sm61865145ad.46.2026.10.13.15.35.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 15:35:07 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jay Zhou <jianjay.zhou@huawei.com>
Subject: [PATCH v4 13/29] crypto/virtio: update comment reference to
 rte_smp_rmb
Date: Tue, 13 Oct 2026 15:22:26 -0700
Message-ID: <20261013222410.2257622-14-stephen@networkplumber.org>
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

The rte_smp_rmb helper is no longer used.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/crypto/virtio/virtqueue.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/virtio/virtqueue.h b/drivers/crypto/virtio/virtqueue.h
index 97a3ace48c..6ef40d3593 100644
--- a/drivers/crypto/virtio/virtqueue.h
+++ b/drivers/crypto/virtio/virtqueue.h
@@ -302,11 +302,11 @@ virtqueue_nused(const struct virtqueue *vq)
 
 	if (vq->hw->weak_barriers) {
 	/**
-	 * x86 prefers to using rte_smp_rmb over rte_atomic_load_explicit as it
+	 * x86 prefers virtio_rmb over rte_atomic_load_explicit as it
 	 * reports a slightly better perf, which comes from the saved
-	 * branch by the compiler.
-	 * The if and else branches are identical with the smp and io
-	 * barriers both defined as compiler barriers on x86.
+	 * branch by the compiler: on x86 this makes the two branches
+	 * identical, since virtio_rmb(0) is rte_io_rmb(), only a
+	 * compiler barrier, and loads are not reordered with loads.
 	 */
 #ifdef RTE_ARCH_X86_64
 		idx = vq->vq_split.ring.used->idx;
-- 
2.53.0

