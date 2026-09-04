Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EDEC79F82
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 19:17:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C9FE42DDF;
	Fri,  4 Sep 2026 21:17:06 +0200 (CEST)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id 693C342DD5
 for <dev@dpdk.org>; Fri,  4 Sep 2026 21:17:05 +0200 (CEST)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2d9db539a54so12655445ad.0
 for <dev@dpdk.org>; Fri, 04 Sep 2026 12:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788549424;
 x=1789154224; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YNmgk4yHOXOPCcGzj9GoUvZtqPpMQ14ixKqbMG6etJM=;
 b=LuTPv/vVuNc1u1mplkrLIGfIMW4bPGozWHmjoxxa/lVTAtXEVjYp+Gh0mDHn/Qk1/b
 dOw+9HIngbGjUjMR8RFzgECqePfqSBMLglI5HYhMDV0fWwXiljerdnENL0GEdcTNWT/b
 BQxSg5J+4WFGoyEqJJ1WRmClKTGZ5LTxfabnRvBVwGo7pTI6DPxdt6YrhDO9WN1IibMK
 1expm8ms1QCLWG2HvKOVxnbhQIhXsA558jpc4mV2DJ0j77tHxdJc+n3U+FUd4BtMmksW
 sL+/dhAV85EKG2SoEnLoVVIvdbsAUqjSB2BZPWVTne48XJQiwwpLwDYrNoRapKmpLvpk
 ImBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788549424; x=1789154224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YNmgk4yHOXOPCcGzj9GoUvZtqPpMQ14ixKqbMG6etJM=;
 b=fIveG6wIEMb92xWoXBWbAHS66uA9Jw5VpdrARInFFfo7Wd0T+kPNRZYOUINljFWang
 cYR7f/qtDIowBs/8laqQavumSb3a+mcn76IUpJ3O2+qAKhzh+kPba1YC+QtoA+uMRzfE
 SX8H9xVJl8EEDiIhC/ob7j1WHjSOYfPh2YsV6n8M2QIBcqErsVA+YgNy0r5X7NSUahkM
 BV0oXaLoydB8pYVVAklkSvWCgZwVkmKgSjS7xM8Fp1FosARML6uQTx9dsGBvVfCmuedv
 D3E8kIXe4b8xHkgQv/ZRDDmeT1ifpXGgK8gKHSfrii/FHSmutAxxBzV54c3TZwG1VFiH
 Lw6A==
X-Gm-Message-State: AFuF++k5EVJjVjEc50oXa2z/iXjgehKP0L9wZhvChqHUiG9LrEKFbqpi
 1cogBpVZnrhJfwXQdrHefYnedYNMzq+r10Fva+oTOGDK7LjCh0nrnJKhCzXYTwsN1X9KyaRdGDw
 VbHaw
X-Gm-Gg: AYBFou0hNZnPcNT3U8eYlQ/7Es7N4ee+LNc2dwObaSkQH/BK0p90KbPzvpcLOKXT2DR
 0oeR8hNPRX+3JQocRCcOd7SV127oXUejnNLcKhYzF0wHuuD5MZ6eymJvV6cgA0IUWcFzEzAJxzq
 93bY9pjdVJZwUNdDRNyPVgjwwEJJuriujPtw75K04luw3J2S4PSpO4QTAGedRDyu8UHoagu16Pl
 l+v8m9/OYNkbQHMoDHmap4L+/J62SK1egm6hGQKASw6MGVOfpxwZB/wVto0GQEFZSJkcd7u+LhT
 BgQrAkkCfhbcZk6Pbh5j4ZF2b5vOrP9nuAgskLG7wLTQtrGWPawxo6c/lf2V1GM5uxBGoE5aWcU
 2aj2bFpFKZIBhubI6F1bRjCs/cEoxU7QmajwfF7D1fvryOC51N8ZlD8GMU0s95+IF6kQcvYmWHp
 dtz7MAzzsdTpo3u7JYX0d170L+4mdj32kg+SAl3JivASp9bgcpzGHm/DJLS6E63AWamYdZOxZBN
 xM5FXTETppLvgXAcaow5DV2cKY=
X-Received: by 2002:a17:903:46cd:b0:2ca:1479:d9dc with SMTP id
 d9443c01a7336-2db125c332fmr139404545ad.12.1788549424408; 
 Fri, 04 Sep 2026 12:17:04 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db1499f07asm13335975ad.57.2026.09.04.12.16.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 12:17:03 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Youri Querry <youri.querry_1@nxp.com>, Roy Pledge <roy.pledge@nxp.com>
Subject: [PATCH 1/7] bus/fslmc: fix build of qbman debug code
Date: Fri,  4 Sep 2026 12:12:36 -0700
Message-ID: <20260904191652.2399074-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904191652.2399074-1-stephen@networkplumber.org>
References: <20260904191652.2399074-1-stephen@networkplumber.org>
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

QBMAN_RESPONSE_VERB_MASK is a private define in qbman_portal.c, not
in the qbman_portal.h header included by qbman_debug.c.
The debug file has therefore never compiled since it was added;
it fails with seven "undeclared identifier" errors when
RTE_LIBRTE_DPAA2_DEBUG_BUS is defined.

Define the mask locally, next to the other management command codes
that qbman_debug.c already defines for itself.

Fixes: 64f131a82fbe ("bus/fslmc: add qbman debug")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/bus/fslmc/qbman/qbman_debug.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bus/fslmc/qbman/qbman_debug.c b/drivers/bus/fslmc/qbman/qbman_debug.c
index f13168dce3..1c5c62addb 100644
--- a/drivers/bus/fslmc/qbman/qbman_debug.c
+++ b/drivers/bus/fslmc/qbman/qbman_debug.c
@@ -9,6 +9,9 @@
 
 #include <eal_export.h>
 
+/* Mask used to extract the response verb from a management command result */
+#define QBMAN_RESPONSE_VERB_MASK  0x7f
+
 /* QBMan portal management command code */
 #define QBMAN_BP_QUERY            0x32
 #define QBMAN_FQ_QUERY            0x44
-- 
2.53.0

