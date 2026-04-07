Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA922FD5F92
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Apr 2026 08:25:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E118402D3;
	Wed,  8 Apr 2026 10:25:41 +0200 (CEST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com
 [209.85.208.170])
 by mails.dpdk.org (Postfix) with ESMTP id 3BAAC4025F
 for <dev@dpdk.org>; Tue,  7 Apr 2026 13:30:06 +0200 (CEST)
Received: by mail-lj1-f170.google.com with SMTP id
 38308e7fff4ca-38dfb789d7fso16678911fa.2
 for <dev@dpdk.org>; Tue, 07 Apr 2026 04:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775561405; x=1776166205; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1edvVOEmUMkvDkYm8khFGzlhVFqgCas37KCg0yDbZ6Y=;
 b=Bu3LWzKOOVcZikX2mC2u1zlSr2ooGgIUfQqErJRTjA8vSbiiRKJpmdX4W+LfFahD/T
 Yov6kBQYicsGLARa8jCPYq0PNFHT2O9t0xe98E4OjUDDr7l2CxXEiMySUIoaGrVp/zJF
 wAnyS+tRutBBNdA56yg5uXJ5QUvgvVGIBaQvKSMli5AvPhRjxuNRF9MyDmQfuBxrVY5E
 dy8EvlsGpoyBG2MO2Nk9HGedm4cp4mBy2/q+AP2VsGS0k7G3/DHsvdb3H28Y1JaNaxGV
 0yFbtf7AFr6ezPfSR/MqIUnLGmNJrGO4+VZ0XC1FaPLLrbJcR/FjzPsdPZ8cR3C+tfjK
 Z8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775561405; x=1776166205;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1edvVOEmUMkvDkYm8khFGzlhVFqgCas37KCg0yDbZ6Y=;
 b=MvQcPySkX2SKFIHrnxmsJloiosiq+VZ0Y1IRMEjo0CSLq8/zF46w0TK3ReJybysdik
 ACwKh+LNdif6nhmRx2G+G2DxUjX2hbneo/4nh2suhuak+2+vWWdGj6zQPyQA/i8M4EVX
 /ivL/EEOL628vKzhJCyhHx4YztOg20RZzro//Y63mIu/O71vmq0VJ1k6xoC4KGmQlcYE
 MNCvz/gIccrpqod+/mErRB4hDsojzYILWUcECmXDjFKc+6aFclq3lWega7xwHXxwDHdQ
 GkK/ARiZESl/vZfsFeHhkjuLshf29czX4VbBqrG2WqmnBW+UrfxVQJuBkr4NEDQPg0Hn
 zUyw==
X-Gm-Message-State: AOJu0YwuJ867+0WbCWg4SH9iZA82gu7JvNXX23RGU0bQLCr4j6wFnpIn
 5FT6e7qiCoC3LOeEjiN6zgbAj9gttPxxXafQzTk1X01qu2YMfADjCl4=
X-Gm-Gg: AeBDieueFNHT2UCr+euHl+Cofp0rFs0s4TO69l+qSOuH0b16ovI1Ne8aHRE1RkmHTRZ
 DJaG/qy5Z9DUcypUV+bsMQ6h8eujpzdYSHsLO1bKPNlnBFJ+tob7bG9qlyeR5REjxlCeLZQ63d3
 9wNnqwB2AD6hZUgT5IFqJIACmaLtWDodgLB66avG3U6sAv7HHGekFdddBQr7wJ3lkuE646Rwam9
 fDs+DR3S28WIDQPXga+OkKYZP03zZaNJjaLzWNNbqp5/miq4UeXPM7PN7+N5R5/95IgcGYSN/Gy
 5dr4av2KnddQ6WlHfLdygc/OjObbcgDOXgI4aG7/xT9QYt4fgocquEsAaUTDWT7XL0fIYZL87we
 5pcsxtw2fpbDznGgF5f5P3BnTXkKFoHyzO8IhbMdnfbTeRa7SPc0zAybR9jgbadLHQiBdnBEhYI
 O+zEhNcM8CqFY4CG62zpXm1PSLzWSJv9oe
X-Received: by 2002:a05:6512:1096:b0:5a2:bc66:b4a5 with SMTP id
 2adb3069b0e04-5a3375561d0mr4850168e87.9.1775561405121; 
 Tue, 07 Apr 2026 04:30:05 -0700 (PDT)
Received: from dev-debian-1.home ([81.94.128.221])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2c6cd6799sm3996864e87.81.2026.04.07.04.30.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 04:30:04 -0700 (PDT)
From: Sergei Iashin <yashin.sergey@gmail.com>
To: Harman Kalra <hkalra@marvell.com>,
 Santosh Shukla <santosh.shukla@caviumnetworks.com>,
 Jerin Jacob <jerinj@marvell.com>
Cc: dev@dpdk.org, stable@dpdk.org, jerin.jacob@caviumnetworks.com,
 Sergei Iashin <yashin.sergey@gmail.com>
Subject: [PATCH] net/octeontx/base: fix out-of-bounds read in DQ range lookup
Date: Tue,  7 Apr 2026 14:30:01 +0300
Message-Id: <20260407113001.1217481-1-yashin.sergey@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 08 Apr 2026 10:25:39 +0200
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

In octeontx_pko_dq_range_lookup(), the inner while loop evaluates the
array access ctl->dq_map[dq].chanid before the bounds check
dq < RTE_DIM(ctl->dq_map). When dq is incremented to 256 inside the
loop, the next iteration reads one element past the end of the
256-element dq_map array before the bounds condition can short-circuit.

Swap the two conjuncts so the bounds check is evaluated first, matching
the pattern already used in the outer loop.

Fixes: cad78ca23818 ("net/octeontx/base: add base PKO operations")
Cc: jerin.jacob@caviumnetworks.com
Cc: stable@dpdk.org

Signed-off-by: Sergei Iashin <yashin.sergey@gmail.com>
---
 drivers/net/octeontx/base/octeontx_pkovf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/octeontx/base/octeontx_pkovf.c b/drivers/net/octeontx/base/octeontx_pkovf.c
index 7aec84a813..5326fe24b9 100644
--- a/drivers/net/octeontx/base/octeontx_pkovf.c
+++ b/drivers/net/octeontx/base/octeontx_pkovf.c
@@ -196,8 +196,8 @@ octeontx_pko_dq_range_lookup(struct octeontx_pko_vf_ctl_s *ctl, uint64_t chanid,
 	while (dq < RTE_DIM(ctl->dq_map)) {
 		dq_base = dq;
 		dq_cnt = 0;
-		while (ctl->dq_map[dq].chanid == ~chanid &&
-			dq < RTE_DIM(ctl->dq_map)) {
+		while (dq < RTE_DIM(ctl->dq_map) &&
+			ctl->dq_map[dq].chanid == ~chanid) {
 			dq_cnt++;
 			if (dq_cnt == dq_num)
 				return dq_base;
-- 
2.39.5

