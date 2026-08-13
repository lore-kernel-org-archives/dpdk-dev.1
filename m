Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9E4C5CFCF
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 17:23:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 802E842E15;
	Thu, 13 Aug 2026 19:22:54 +0200 (CEST)
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mails.dpdk.org (Postfix) with ESMTP id B259042E0C
 for <dev@dpdk.org>; Thu, 13 Aug 2026 19:22:52 +0200 (CEST)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8484f26852dso2503788b3a.1
 for <dev@dpdk.org>; Thu, 13 Aug 2026 10:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1786641772; x=1787246572; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JuAWQ9h7b7zo4p9MY9/PKEPamonwalzCtH0MR3NTA14=;
 b=j4VAqNrqoxGY4kcdfc7ou9HRkmlVeDeWy2i6pLv9UGEzc8UqCpcioVFSLmFcSXy1u/
 bcinqwAbEnCerPzAWMZFVGiVWGnd6p1S7aJoYU6aL8Ny4mY/VXfzxc1jUHNpc0yIFbTZ
 EToUSdefIgkBzPtxDptK67/TMF/gIUI2oKD6cEhNTYg1e8Q0UtVzls5TwfE/Jeh84lSs
 jVXOROVZjyYHUDRhk79x6RGQt1F3jo609BIm6OwNLQFRbrmtX/wbTQwTkXB+ME96wzE/
 OUloTNfeQj62MV4zPkoO9tyWG1gfQlohTqOgtr2iw320DiwcrWhrOJrle4D6ulfoEack
 DaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786641772; x=1787246572;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JuAWQ9h7b7zo4p9MY9/PKEPamonwalzCtH0MR3NTA14=;
 b=YCHJ7MRB3GJcqqtx6KOiwxsZCtgxV/f91otIPm4QdHGjJ3wLr9jsrRbuScYmexit8H
 11+SkWJ8TEfQ7PNVXwwIdL4vhqLfNBFDQrhR+mv0qufGB4Pp8ebbmgifn3qMn5VQg2f3
 NRTcx5mVX8giyF4kTYzVMzvm2t+to7H8y3U8MsOaO9jdtvSvi11KsEYgTVlpQQzXRi5r
 eqeVu1yTyiNKhajoIwf8l5afl93hLDfRRLPu/YRlj/fxeQqIWhViaEQVvJKkYaYdOeKa
 /9rxYAO9UHAgs+nfQlC+bcfn9PrsJguH1uINwYv7cGV0fZUU1eg6HTNW1NPqEtY5nRKZ
 Yv2Q==
X-Gm-Message-State: AOJu0YxbFhLi3OLvl+W2j9/6U8S3OLD1Engw/nQCF0tvG1zdJ3jgbUPH
 uWIDov+F+15xvjoZWQHEdfW0BUrQHrnZihjXsWXZ2M6jHGU0O6eRk1Mrb3rOY+8etNe/vnVKItU
 9oScsBcof8MU7FQ==
X-Received: from pfbko19.prod.google.com
 ([2002:a05:6a00:4613:b0:847:926b:dc17])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3910:b0:842:6004:3fd5 with SMTP id
 d2e1a72fcca58-84fc6e03386mr6976851b3a.25.1786641771545; 
 Thu, 13 Aug 2026 10:22:51 -0700 (PDT)
Date: Thu, 13 Aug 2026 10:22:29 -0700
In-Reply-To: <20260813172241.964736-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260812223017.2980190-1-joshwash@google.com>
 <20260813172241.964736-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813172241.964736-5-joshwash@google.com>
Subject: [PATCH v2 04/14] net/ice: use common division round up macro
From: Joshua Washington <joshwash@google.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Joshua Washington <joshwash@google.com>
Content-Type: text/plain; charset="UTF-8"
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

The RTE_DIV_ROUND_UP in rte_common.h makes DIV_ROUND_UP redundant.

Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/intel/ice/base/ice_osdep.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/intel/ice/base/ice_osdep.h b/drivers/net/intel/ice/base/ice_osdep.h
index 5d92cf5aa4..3ef52eae6d 100644
--- a/drivers/net/intel/ice/base/ice_osdep.h
+++ b/drivers/net/intel/ice/base/ice_osdep.h
@@ -311,13 +311,12 @@ ice_hweight32(u32 num)
 	return bits;
 }
 
-#define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
 #define DELAY(x) rte_delay_us(x)
 #define ice_usec_delay(x, y) rte_delay_us(x)
 #define ice_msec_delay(x, y) rte_delay_us(1000 * (x))
 #define udelay(x) DELAY(x)
 #define msleep(x) DELAY(1000 * (x))
-#define usleep_range(min, max) msleep(DIV_ROUND_UP(min, 1000))
+#define usleep_range(min, max) msleep(RTE_DIV_ROUND_UP(min, 1000))
 
 struct ice_list_entry {
 	LIST_ENTRY(ice_list_entry) next;
-- 
2.55.0.691.gc56d675ccc-goog

