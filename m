Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D7DC98324
	for <dpdk-dev@archiver.kernel.org>; Sun, 27 Sep 2026 04:00:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF8D440274;
	Sun, 27 Sep 2026 06:00:05 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id 7DB544026A
 for <dev@dpdk.org>; Sun, 27 Sep 2026 06:00:04 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-396ccda24afso1074188a91.3
 for <dev@dpdk.org>; Sat, 26 Sep 2026 21:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790481603; x=1791086403; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dCqe0XrsKUG0uUP7KG9eSX76BfNHo2KKP0WeUov8w6Q=;
 b=q1MJaVxh/bGyzy0OXA5My56K1tC9tAe5mcB90v2tDqcTeshQ/h5+jJUKjdzipcfjEL
 FCbxde4JR0htHmy0ozZupaLM/fwtMOnrh6p7ZwLl3B8sxDuFrCJYX1is08NH3IoBopcS
 6YyxwtT3cgMZnyguaHja7MRMHcE1UvCLVNQW0/wzOnmOQAPWRpTsvJSAPV3f6n78D3lJ
 RKkVcXyhzbHFNyKLhLc46S4ckB5qemUOZaxS/ULLjQhSPg7ESTmoByHt398IVA2RdyT5
 DLQ81liZQi0YcBD1I5LEea9YiKl97Hfei4JtrCbPUOT3BFG0tbbJWWZvEKU/4ASZ+x56
 5dQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790481603; x=1791086403;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dCqe0XrsKUG0uUP7KG9eSX76BfNHo2KKP0WeUov8w6Q=;
 b=SqZbEsbOzp6ZP4u5X8q+bw884vF0Ko0Y7eBexH/ET8fYWqi7JJ4QF91qljSb4fReIS
 etOwE2IIBeWrTvig+Q+jSCF5SceGpast/4zyp1Bl8J51y6grC+564NYrrNpQl6CYZn41
 wOHAvj9WNSIywgkwV2c5uXEIMJIxzTdS3QoU1+8/GjPINzU3BPRubF6PmKdAyCjTI/Tf
 KXkNfhjnD6k8+zm7Pxo6OvyFP2ovy9aJgEI5ot6h0v+T0wjksyrcyK7q+Gxi2MKgYCJn
 j5uZNh3TiC03tzvjjK47wNIGuA2uJFDoQzbf8qvn/s5SFb+6qFFgLwZ7fKhgIdE1/SlY
 wxtA==
X-Gm-Message-State: AFq9FYKLwx515ciPH2rQ3jhuQSzJ132v/O0JnD7eBVzHZtzaTtEj0Xsx
 HkJcEcgC9kkA0AhHqiOAFjKfaOl9AQAyxNZ1zEzG8biE+bkJJjpZlPg5p2HD8ia7
X-Gm-Gg: AYBFou170Uq1hGDoh6QSSf+uFwKn+Oc9l6LGFv2HpotD9tWxYKqg+xKmT5HNzYg3GFW
 VLCSNhSzOPEnySaU9FX8lKJaOfwycbR5aZOiLMqakPOel2c3whgN9LXKNt0q+CB4JXa4MDkIDDe
 UAY9J98YpyQGzBSbKFK95z9RzfTTxwhAyS5cqGsbVO6bdcqaojTtcp4Am+oXLi7sCMcQre1jZmo
 PbJbW0Dao/IYi3Xg5B7s1l0Djx25TpmHGwM6pS50JGF4+ZoJjOwMbh0Zzw4G7njdRa1rXVhBoei
 oyw8i+Teh+AHCi3pmNI7mbCsvIr5eowSwA/eK/DYG5IhWMuoy2q5diWte7u9CEBgT8HhvhYUhIt
 2fMDIF30AD+oaJcYOKrhi11XKMf9POPPgays7Yz0bo03iBt3nwC/VLnkCKxNyQPu73edLongo/V
 MhpVoo9ArEsUwxDj8UGjJlB52uF3WjtvBUJkfbNPl9b/jEABg+wVTt7DnAa3UcKEcohXmkRssLF
 0SXe9Y=
X-Received: by 2002:a17:90b:2790:b0:3a0:d265:3647 with SMTP id
 98e67ed59e1d1-3a0d265389fmr3105410a91.8.1790481603260; 
 Sat, 26 Sep 2026 21:00:03 -0700 (PDT)
Received: from OptiPlex (mail.forbuysw.info. [66.175.223.235])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a2b1e4d5basm775283a91.9.2026.09.26.20.59.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 21:00:02 -0700 (PDT)
From: Zhang Tengfei <zhtfdev@gmail.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net,
	Zhang Tengfei <zhtfdev@gmail.com>
Subject: [PATCH] mailmap: update contributor name
Date: Sun, 27 Sep 2026 11:59:49 +0800
Message-ID: <20260927035949.36887-1-zhtfdev@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Use "Zhang Tengfei" as the primary name. Both addresses belong to me

Signed-off-by: Zhang Tengfei <zhtfdev@gmail.com>
---
 .mailmap | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 57f7a9f87a..ee4f80e625 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1680,7 +1680,6 @@ Tarun Singh <tarun.k.singh@intel.com>
 Tasnim Bashar <tbashar@nvidia.com> <tbashar@mellanox.com>
 Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
 Tejasree Kondoj <ktejasree@marvell.com> <kondoj.tejasree@caviumnetworks.com>
-Tengfei Zhang <zhtfdev@gmail.com> <zypscode@outlook.com>
 Tero Aho <tero.aho@coriant.com>
 Tetsuya Mukawa <mtetsuyah@gmail.com> <mukawa@igel.co.jp>
 Thadeu Lima de Souza Cascardo <cascardo@redhat.com>
@@ -1981,6 +1980,7 @@ Zaiyu Wang <zaiyuwang@trustnetic.com>
 Zbigniew Bodek <zbigniew.bodek@caviumnetworks.com>
 Zengmo Gao <gaozengmo@jd.com>
 Zerun Fu <zerun.fu@corigine.com>
+Zhang Tengfei <zhtfdev@gmail.com> <zypscode@outlook.com>
 Zhangfei Gao <zhangfei.gao@linaro.org>
 Zhangkun <zhangk.zhangkun@huawei.com>
 Zhanibek Bakin <zhanibek.bakin@gmail.com>
-- 
2.53.0

