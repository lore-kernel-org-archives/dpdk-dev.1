Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C92CA9ED0
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 21:10:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84C044066C;
	Mon, 12 Oct 2026 23:09:58 +0200 (CEST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id 882BC4064C
 for <dev@dpdk.org>; Mon, 12 Oct 2026 23:09:57 +0200 (CEST)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a02667ccebso15892695e9.0
 for <dev@dpdk.org>; Mon, 12 Oct 2026 14:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791839397; x=1792444197; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rUPuwfxM3PAHFnqKMbiocaTUgWlT+9Rnj8EN+vK1Hcg=;
 b=J6fXkkBCMw/qKnKuYG0ljBx+mqbQRLi85lyhUnMhCOicU9EgEYNxJUn9uVpRjZPpwX
 +1WaakaW3EVQj/Sv6XYjBMHD52E14lKPW7R0A4IveK3VYjU9QOxceSU4VnaBWXooNZzj
 zGt73conuLIrUf3TWnL0sxemMqNJiHK3lNGEgq+hyC5ZawLOVGh4NzGjlJZ0Q2uUEXHa
 WLKxQBGqGr6UmGAaYJthgIcYfxk08DvgbK1Bs7u1PISSeTaW9VHTy+pvKDF75mTpn69n
 HSbQKnCurQPE61aPsh0k7PEg4DuXk4bbJLOGWJERj92TtesCjWQOqq7Ha/WfV9BWASjw
 Urig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791839397; x=1792444197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rUPuwfxM3PAHFnqKMbiocaTUgWlT+9Rnj8EN+vK1Hcg=;
 b=iICgpdGS3eN7WN0TWPyzaMQ2JrvZr7yJpjjOb0eIxljMDPgS4lHXHcXLuUm4rlEQHQ
 fdfCwJ4gMuBPoEiU6SKu4saSBEtrKbPluPAndrdWvX9O3ty/hcse2GWioJ58p5zcy+lV
 WtiEhtl2B/7+qmhT/H3WnZDjPyUa65PmGUA9ss0VaaeyB8VRNap9Jw8PRVPtCwhxX5b3
 7OZ4kqQqrW243StWIkh95yjBcbp3oqYO6RfL4KxX/EDxtmZa+5OIajhnArYlLC2cfnIj
 9KU5wIpkJ3ZCUOn90flYJC/yA4GBfsNrLh+rK3f7MvpCf+JwASEl3yv4oxccQcS9oD0p
 N/jw==
X-Gm-Message-State: AFq9FYKyCR/deV4/1g5qtZ19vgmo9NzIJUxK7IZ7Ca+wQlsnMG+m97bc
 dBYtXNxnld1n0tIYIo9BAIkp0QQsjhNWpkQSb91pbJ/5a9QZ8qRs9TPz
X-Gm-Gg: AYBFou0acI5KM0IrCXjLucEUbiLPOaY4b8pu4uW+QuwHThTZydIbEU/DGBmlNHkwZR1
 vKsljc82wdTQiduO+KiQ8dZHr3mVf79+ASAGe+n6RKs/3e2FHx/fL80DBMkKaOLPHVaFneH+pct
 9BuuWNSEshn0ku3tZjk2PLbh0qioGIeWcdyMkuQPOPhGetLQJTR4YnKLFe8FqWCJ/0X706yDL43
 qhIGL1VnCqbcOqBC6CtXT6Skvs1bG2qwGxWbtNp3W7x26P1I9MNyb/IHNQNAjw1BK9Smt+bY49r
 6lKUeIc2DqbtUDS7UMI52gf+voyYrZJ+M4ubvPCEKwwMD9ejWiCc870PCz37gFkbb6ZIB0qJH4b
 08TKYYVrh4VcgOIQ0mgJbj/9AjJ3HjR5m4rGNGBNhQL3Z+K62Lmr/qYpsdbi/6z01e6QVp4J7I5
 a0qBeQCCIWCfs0XfD1M3wRpkt6xdWU8klqtAuT2noueSvmkiOOtLyc4+rzOQE+
X-Received: by 2002:a05:600c:64c8:b0:49d:1df6:2592 with SMTP id
 5b1f17b1804b1-4a18e4c41b0mr189758585e9.21.1791839397105; 
 Mon, 12 Oct 2026 14:09:57 -0700 (PDT)
Received: from dpdk.lxd ([80.233.57.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf2caf4sm342208725e9.10.2026.10.12.14.09.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 14:09:56 -0700 (PDT)
From: Marat Khalili <qm2k21@gmail.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <qm2k21@gmail.com>
Cc: dev@dpdk.org,
	stephen@networkplumber.org
Subject: [PATCH v2 4/9] bpf: remove redundant memory barrier on unload
Date: Mon, 12 Oct 2026 21:09:11 +0000
Message-ID: <20261012210917.161343-5-qm2k21@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012210917.161343-1-qm2k21@gmail.com>
References: <20261011182158.124246-1-qm2k21@gmail.com>
 <20261012210917.161343-1-qm2k21@gmail.com>
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

From: Stephen Hemminger <stephen@networkplumber.org>

In bpf_eth_cbi_unload(), rte_smp_mb() was called immediately before
bpf_eth_cbi_wait(), which itself starts with rte_smp_mb().

Remove the redundant rte_smp_mb() call from bpf_eth_cbi_unload() and
update the unload sequence diagram accordingly.

Originally proposed by Stephen Hemminger as part of a series replacing
deprecated SMP barriers with C11 fences.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Marat Khalili <qm2k21@gmail.com>
---
 lib/bpf/bpf_pkt.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/lib/bpf/bpf_pkt.c b/lib/bpf/bpf_pkt.c
index eab85f7417..b1e25e4e7c 100644
--- a/lib/bpf/bpf_pkt.c
+++ b/lib/bpf/bpf_pkt.c
@@ -62,8 +62,6 @@
  *     |                      |               |              |              |                |
  *   rte_smp_mb()             |               |              |              |                |
  *     |                      |               |              |              |                |
- *   rte_smp_mb()             |               |              |              |                |
- *     |                      |               |              |              |                |
  *     +-if use is odd        |               |              |              | if cb not NULL-+
  *     | |                    |               |              |              |              | |
  *     | +------------ fetch odd ------------>|              |              |<-- execute --+ |
@@ -502,7 +500,6 @@ bpf_eth_cbi_unload(struct bpf_eth_cbi *bc)
 {
 	/* mark this cbi as empty */
 	bc->cb = NULL;
-	rte_smp_mb();
 
 	/* make sure datapath doesn't use bpf anymore, then destroy bpf */
 	bpf_eth_cbi_wait(bc);
-- 
2.43.0

