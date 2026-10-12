Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A8DCA9ED2
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 21:10:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7446A40679;
	Mon, 12 Oct 2026 23:10:06 +0200 (CEST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id C313940615
 for <dev@dpdk.org>; Mon, 12 Oct 2026 23:10:04 +0200 (CEST)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso26726605e9.3
 for <dev@dpdk.org>; Mon, 12 Oct 2026 14:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791839404; x=1792444204; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5wyHCBde18tJWgnjIifRj5J2faBZ03Sm270FBby1TlE=;
 b=CqO/DdOuGBRvbOk8q7JkidsEm0ni7MXyTUFs1+5Vii2rFpnPm+2A7UBUtovG674Wl7
 aDOvQvgBY91T8o702XLOcr9vjXjwMe+dpS1VYpO3ldmjgbRzoBppOhYoPyJ9YToyaPtU
 Y0ZDI87sS1wq31i/z5p/0DPgnf4DUzQNvoV/eajYVt8gKCx+6V9zyu5wXDqq6Qit4FB9
 mjR0cWPiaJWF29gsNKHJF/nk9QI8qSaWI4x3/pdeuHxBRqJwLERTxYrDpxjndxYfKFZr
 ++bM11qskHUlChKrORiQZiHueDKP5Or7wX26IusRwUedh+sErbA++W1xaINF/3O29yXi
 se5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791839404; x=1792444204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5wyHCBde18tJWgnjIifRj5J2faBZ03Sm270FBby1TlE=;
 b=ri11qwQ21wQBb5Nd/gjj4seRSowZ0aixjHpkuvfldgGOr+V86LT/ZQzxiEjgtTtNcX
 1SBBVJvTVTHG3gSEDCPrxtPK9ULLqOi1sq2S6NOVIB6TzFAViAPiQQ5wNZUAa0ENrLvl
 dOryL3XyQ/2Hy1lgLfRWafYz7t7vETVQlnnyde95PUtTdrFt3++oooxm4E+zOrXtczKr
 WqjaGGjFhc8oYeu+Q2jKW6hJwl7OorHd8HibE0NBkVS2tPwPtDaejP0yoEbSBRotUQVU
 aZBXR68PMN42jX+kDOwGDulrYbOHMgc5jElfJpQ13pK1vKLOP2vB6yXZcNZ8AuPrn0bh
 gDeQ==
X-Gm-Message-State: AFq9FYJkmeMlTcBG2XiGF0ao9cVlb1L2MUYW/8dt2Z+oRYg/LrlXebm+
 eW49/p7QH03sbWhQvifjp2+G54g9mUAxNd7hwUMmZoZjXIyD4cZjcud5
X-Gm-Gg: AYBFou2mASDjso9Afia+fVcaGe5Xcscp14OfBTJZRbKH/DB49mbYlbR+WHRiQppFpGz
 9IE/SLeLUe1OoTkpwcVOf5sX87OFzKyvmh65MiuU2WDtG42lZObq8fXmBTFWoTR84DeTo+ylRVJ
 SwIS4w+VJEJ3dsAyma+sBAtpqiICsagxo1A6KmRMLyI/yxkyeMBSC1ty0n+01SoMBRbFaoiLxEU
 FrqaD/WaCJXrNMtwMvJ8u1fJoZvFee/Ns6P+qGwBM+93pjkXqEhj81WYY0B3UkYkSXIeoylv2Db
 ji7Grv7FuummmGNGzI7hLXXO1Yio3dWpRRgk6Sn2PvqiPBLnSXCIWe3hVG4wbcJ787JRc8ypEs8
 ET0ED5ZuuJIxv0X1Q90PEdCLg9SKQm7SrNduGiut5TAswnB+zDOad1F4WXgDw6pXSVUVKJnUp/O
 6WAo+3UATLkMkTG8nay/bMHT1Ew8Gqre2QXKU+2yWBfMOLxmavEHVoCywqRHg=
X-Received: by 2002:a05:600c:83c7:b0:4a1:7733:5102 with SMTP id
 5b1f17b1804b1-4a18e4a3fc8mr197093765e9.15.1791839404330; 
 Mon, 12 Oct 2026 14:10:04 -0700 (PDT)
Received: from dpdk.lxd ([80.233.57.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf2caf4sm342208725e9.10.2026.10.12.14.10.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 14:10:02 -0700 (PDT)
From: Marat Khalili <qm2k21@gmail.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <qm2k21@gmail.com>
Cc: dev@dpdk.org,
	stephen@networkplumber.org
Subject: [PATCH v2 6/9] bpf: reformat packet callback unload diagram
Date: Mon, 12 Oct 2026 21:09:13 +0000
Message-ID: <20261012210917.161343-7-qm2k21@gmail.com>
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

Reformat the CP-DP synchronization sequence diagram in bpf_pkt.c by
removing unnecessary vertical lines and re-centering arrow labels.

This comment-only commit is intentionally kept separate to make the
diff of the preceding semantic change more readable.

Signed-off-by: Marat Khalili <qm2k21@gmail.com>
---
 lib/bpf/bpf_pkt.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/lib/bpf/bpf_pkt.c b/lib/bpf/bpf_pkt.c
index 429feb76ad..55f5947460 100644
--- a/lib/bpf/bpf_pkt.c
+++ b/lib/bpf/bpf_pkt.c
@@ -53,25 +53,21 @@
  *     |                      |               |              |              |                |
  *     |                      |<---------------------- fetch callback -----------------------|
  *     |                      |               |              |              |                |
- *     |                      |               |<------------ store true ---------------------|
+ *     |                      |               |<---------------- store true -----------------|
  *     |                      |               |              |              |                |
  *     |-- remove callback -->|               |              |              |       rte_smp_mb()
  *     |                      |               |              |              |                |
  *     |                      |               |              |<------ fetch non-NULL --------|
  *     |                      |               |              |              |                |
- *     |------------------- store NULL --------------------->|              |                |
- *     |                      |               |              |              |                |
- *   rte_smp_mb()             |               |              |              |                |
- *     |                      |               |              |              |                |
- *     +-while use is true    |               |              |              | if cb not NULL-+
- *     | |                    |               |              |              |              | |
- *     | +----------- fetch true ------------>|              |              |<-- execute --+ |
- *     | |                    |               |              |              |  BPF program | |
- *     | |                    |               |              |              |              +-+
+ *     |------------------- store NULL --------------------->|              | if cb not NULL-+
+ *     |                      |               |              |              |              | |
+ *   rte_smp_mb()             |               |              |              |<-- execute --+ |
+ *     |                      |               |              |              |  BPF program | |
+ *     +-while use is true    |               |              |              |              +-+
  *     | |                    |               |              |              |                |
- *     | |                    |               |              |              |      rte_smp_rmb()
+ *     | +---------- fetch true ------------->|              |              |      rte_smp_rmb()
  *     | |                    |               |              |              |                |
- *     +-+                    |               |<------------ store false --------------------|
+ *     +-+                    |               |<---------------- store false ----------------|
  *     |                      |               |              |              |                |
  *     |------------ fetch false ------------>|              |              |                |
  *     |                      |               |              |              |                |
-- 
2.43.0

