Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C269CA9ECF
	for <dpdk-dev@archiver.kernel.org>; Sun, 11 Oct 2026 18:23:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54DA2402D9;
	Sun, 11 Oct 2026 20:23:06 +0200 (CEST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50]) by mails.dpdk.org (Postfix) with ESMTP id 3CD994028D
 for <dev@dpdk.org>; Sun, 11 Oct 2026 20:23:04 +0200 (CEST)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-6afe29c08ccso1350989a12.1
 for <dev@dpdk.org>; Sun, 11 Oct 2026 11:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791742984; x=1792347784; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0Qe/FOdQTlVjyYHYYuIk7bhSsm12llxb6JQ84buohd4=;
 b=L/dQDmUGvATTEdeiKy8sIbwjmCz7WwAKZcaHQ/4sKBrJfXGuSMbbF/yvZHbb3MYyzA
 Wm+nrB8jx5H8zSke3Hsh0y7/m8kafSD1yoAnTUsRlOy2x8fF1iwLE8K/cMQVAU+rSAMh
 Okq3V5q/GpRQ3j8EKAP8h89b/+tXyPH/4NVG3RymFwgVi84Z4cKLU5CLxq9E0SXJeTNP
 l/ZT8E9dSs1xvRSUY0njTR2fUOpcW/uB7RcnsJBjqG90ODt2yPMK1oIKT9ctKXmzB4qE
 DuHRVGKB1qo5fYmUSEMYbDwXmdic3uSjaKv0apx12zCh8fZnNoVO4DdE2mo57FtYtYzq
 6Evg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791742984; x=1792347784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0Qe/FOdQTlVjyYHYYuIk7bhSsm12llxb6JQ84buohd4=;
 b=IYdUNIDN/eDzaQg72n+YDxPVMvP0QpRk/z7/JjdHL4i+gu+RQeAWIBkRmsr6agMSHm
 Qvgrs/6p+Te0MNELkt6vbG8uVS8LoafOFYMflBCoac5VRYw/jonU+HB07XR8yWguixnp
 CgvrdXMuyQEZNLZJvnG/am2jyIPQVLOGoiqqgzdBbx63Bur76bl8ecau1pyI98CfH3s8
 Y4zt/U+l80ueUgOrDmJAM4ZHrZ8ANaj11S0XYuZxDceY/9TcAvx8LSQgmNwWsW5tkAFr
 H6BKFcryEFJ1NMRHyZTzXF60CLz8tIf6ZPlEfBQR4kRFv7rLDkCCy7WroA8+SC1wU/iP
 vxHg==
X-Gm-Message-State: AFq9FYIM3J4BpXvP5qFdJ5l7oPGG3Amn149/rb6UQSBlOZSqatRGdijH
 LhrfRhNz+PhPyT8cxi9FjiZPL0S+UWYcwpZdyXkM0W0m1BlWnxdOyneDkGAIqxkfX+4=
X-Gm-Gg: AYBFou2muHW6MRPj7zeTpOv1M3N2+ZtKdyUnnlhUZ8J1A/4GrBZzjtzNoT1b4PrpoST
 kMqnwSWW+i3paZzkz+YaIh9Rv2Zc0U8sEumgl6xMt23ZgHr7hljD2DKSPzeU1h75JsWlFpFMkgz
 8L+sQINisSNUum7Wlma63wy1N+cIYmn1zVLGAhV56TChXIlys6b1oWgwcCrjRPAm5DNCwGKLSpa
 xVFwr2/jRc9mZoLaiePm1GXBXMTVyn6CRjxnhc6UfsIo3VH0vR23V6YdppcCtBg6gPxL0i2UTWE
 xRAlRKZlxSP8Hde15U65e6BgB3BV1UIk1bUNXveEFw0Oea+GfqiNMXvSwreOroc9DQNIOVAIR5d
 JEtiprDhP8Gw8oY4o/Md7W/nEJNge730Qj6mijFbBfNrfujK4GlGTNd+DDRgOaFmbd2Y4ml5YgM
 ryE2c685d01tb+hgW3P0nww8YwF6GZVJ2Ehl4vOM9A2nBkmoksvl5t5rIVSLA=
X-Received: by 2002:a05:6402:915:b0:6aa:f0e:a15f with SMTP id
 4fb4d7f45d1cf-6b17c3e5a13mr7385622a12.38.1791742983785; 
 Sun, 11 Oct 2026 11:23:03 -0700 (PDT)
Received: from dpdk.lxd ([80.233.48.229]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b179de7e23sm4083718a12.25.2026.10.11.11.23.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 11:23:02 -0700 (PDT)
From: Marat Khalili <qm2k21@gmail.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <qm2k21@gmail.com>
Cc: dev@dpdk.org,
	stephen@networkplumber.org
Subject: [PATCH 7/9] bpf: reformat packet callback unload diagram
Date: Sun, 11 Oct 2026 18:21:55 +0000
Message-ID: <20261011182158.124246-8-qm2k21@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261011182158.124246-1-qm2k21@gmail.com>
References: <20261011182158.124246-1-qm2k21@gmail.com>
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

Reformat the CP-DP synchronization sequence diagram in bpf_pkt.c by
removing unnecessary vertical lines and re-centering arrow labels.

This comment-only commit is intentionally kept separate to make the
diff of the preceding semantic change more readable.

Signed-off-by: Marat Khalili <qm2k21@gmail.com>
---
 lib/bpf/bpf_pkt.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/lib/bpf/bpf_pkt.c b/lib/bpf/bpf_pkt.c
index 7ae64ed7d0..ea7e240494 100644
--- a/lib/bpf/bpf_pkt.c
+++ b/lib/bpf/bpf_pkt.c
@@ -52,27 +52,23 @@
  *     |                      |               |              |              |                |
  *     |                      |<---------------------- fetch callback -----------------------|
  *     |                      |               |              |              |                |
- *     |                      |               |<------------- store 1 -----------------------|
+ *     |                      |               |<------------------ store 1 ------------------|
  *     |                      |               |              |              |                |
  *     |-- remove callback -->|               |              |              |       rte_smp_mb()
  *     |                      |               |              |              |                |
  *     |                      |               |              |<------ fetch non-NULL --------|
  *     |                      |               |              |              |                |
- *     |------------------- store NULL --------------------->|              |                |
- *     |                      |               |              |              |                |
- *   rte_smp_mb()             |               |              |              |                |
- *     |                      |               |              |              |                |
- *     +-while use is 1       |               |              |              | if cb not NULL-+
- *     | |                    |               |              |              |              | |
- *     | +------------ fetch 1 -------------->|              |              |<-- execute --+ |
- *     | |                    |               |              |              |  BPF program | |
- *     | |                    |               |              |              |              +-+
+ *     |------------------- store NULL --------------------->|              | if cb not NULL-+
+ *     |                      |               |              |              |              | |
+ *   rte_smp_mb()             |               |              |              |<-- execute --+ |
+ *     |                      |               |              |              |  BPF program | |
+ *     +-while use is 1       |               |              |              |              +-+
  *     | |                    |               |              |              |                |
- *     | |                    |               |              |              |      rte_smp_rmb()
+ *     | +------------ fetch 1 -------------->|              |              |      rte_smp_rmb()
  *     | |                    |               |              |              |                |
- *     +-+                    |               |<------------- store 0 -----------------------|
+ *     +-+                    |               |<------------------ store 0 ------------------|
  *     |                      |               |              |              |                |
- *     |------------- fetch 0 --------------->|              |              |                |
+ *     |-------------- fetch 0 -------------->|              |              |                |
  *     |                      |               |              |              |                |
  *     |----------------- destroy BPF program and cleanup ----------------->|                |
  *     |                      |               |              |              |                |
-- 
2.43.0

