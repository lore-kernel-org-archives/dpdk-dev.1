Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E11C636A1
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Feb 2026 17:33:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C227240A6B;
	Sun, 22 Feb 2026 18:32:51 +0100 (CET)
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com
 [209.85.160.48]) by mails.dpdk.org (Postfix) with ESMTP id 87B2640672
 for <dev@dpdk.org>; Sun, 22 Feb 2026 18:32:42 +0100 (CET)
Received: by mail-oa1-f48.google.com with SMTP id
 586e51a60fabf-409470ad5bbso1159522fac.0
 for <dev@dpdk.org>; Sun, 22 Feb 2026 09:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771781562;
 x=1772386362; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/omJoVtSBuPtIyWBO+npMl3uPvGP9xe48jZLhu4cU/8=;
 b=cIcARxgp/I0gPG0cdDyUp6D1wS3BURPeK+m/ZenumqMcCUyABbhEIo5KG+X3LQBXiO
 2tRNtEEDAt5lWESYfD6/JNm7XsqJlhUUqaK1DjLW7+V/LMO8ts6GO7Gww4Y9egv3IBP1
 DKdgXRNsJ1PxFQBTbB2xbRbjTZDsNp5d8pWu+GYgGpY+qn2ZnePaVjlKEuBu073G0zTu
 D7hkNJkBzT472C+qWDdduZam6HRytuaPfrktkcYYMkf7+eVA70WsnrTnboyhoH0E5/TS
 A8iPVy0iKRlJnmIaXr7FqsBWhUhchLo9p5QdQj9GY08vuWuO4l2Nn69boKahl+Ajq2JI
 qx4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771781562; x=1772386362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/omJoVtSBuPtIyWBO+npMl3uPvGP9xe48jZLhu4cU/8=;
 b=MoUXEzYpTTamY6FZRtX+LpCBnbx2t8tD2h50e7tsApd4efr4sUKfre+Rio/Np522Y0
 T4ERZyReDFptCCOeZ2nks8Ta5+YpAe5vcgxpVxnIcrrEfWhR2UcIpgoct3jROj+NiCZ6
 O6DljZRh12n0CGSc092kvuOidKJT5YYFtLFGtn2TVSoYmR407eiCOZD9ELY2CndJ+JRb
 eD8aq71m72t49fYeCVKS1e+/qjvrB/ee4wdxsF1VJ4sgbay2Ka7Mg+rcjW3mfI7coT8A
 mlwOTUDbWivRnHwkQ7RqTpuu44gKJM+bZOUoStaZR8CQrvvwR9iaHFE/L0dasVUrQ58m
 BSyQ==
X-Gm-Message-State: AOJu0YwDOwqrwG68Bvor7xXH8m89vv6Ac+eW6hHe77vo/CuAOyl3MhJn
 biX2czvWPsTCwXnxcwbpaXcgei7p6iIAeHCAZmmXTDRqfuzgMdyKPa/hS+/Ko0MSgvhETtYGHK8
 8DORu
X-Gm-Gg: AZuq6aJ/3O7l3Dnrmdcz5wAY1d0p05s0GO279EocKrm3d02EEwGmfDOAjGiLcoSvIzq
 lNyaj2Rx5yOryZPI8xGQgtZKDDAvx1KYS1m/AeR7BNtL4Z50iKe4OUPMHDw5lTa9y6FFhuxTTxH
 bK09p1n3YtGYRyIcUGj428im85kquXzTf5D7q/zNKpCR+6d2IsJ+T57kEy+Ppi1YIaLz4RjfOQg
 7JkkDZG/srYy93YhSJmVDfB/tLi2HRmOIvSlYkNyk12OTDEu5iki8gxLV7+FP3XCL3zGNzk9iE1
 Iy9aCDxbFsWI6wUve8KNaCpHvTduBUN4Jx1/VZZOQgn0cphBBNyR4uXeN7YJk4fdFWQ7ZywN3uX
 ItWmEsCDbJtSLPtPrV7ZfBtcIpfGtcKoPtynJhaTVijd4+Yhdnqxoax6j7+XNeDx3osQ0gKV+g6
 oQrIQrpdgkQvr3N97XpaF/zApwAtw+lms1U8GA7LDXIai73WEAZMZgZQkqPXTvYg==
X-Received: by 2002:a05:6870:70a3:b0:404:33e1:3cc2 with SMTP id
 586e51a60fabf-4157ac44158mr3059983fac.13.1771781561848; 
 Sun, 22 Feb 2026 09:32:41 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4157d2d7922sm5608972fac.12.2026.02.22.09.32.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 09:32:41 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v5 12/19] net/tap: free remote flow when implicit rule already
 exists
Date: Sun, 22 Feb 2026 09:30:47 -0800
Message-ID: <20260222173225.522754-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260222173225.522754-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260222173225.522754-1-stephen@networkplumber.org>
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

When tap_flow_implicit_create() gets EEXIST from the kernel, the
allocated remote_flow is never freed. Add rte_free() on that path.

Bugzilla ID: 1880
Fixes: 2ef1c0da894a ("net/tap: fix isolation mode toggling")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/tap/tap_flow.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tap/tap_flow.c b/drivers/net/tap/tap_flow.c
index 427faf75d5..da1e70019a 100644
--- a/drivers/net/tap/tap_flow.c
+++ b/drivers/net/tap/tap_flow.c
@@ -1625,8 +1625,10 @@ int tap_flow_implicit_create(struct pmd_internals *pmd,
 	err = tap_nl_recv_ack(pmd->nlsk_fd);
 	if (err < 0) {
 		/* Silently ignore re-entering existing rule */
-		if (errno == EEXIST)
+		if (errno == EEXIST) {
+			rte_free(remote_flow);
 			goto success;
+		}
 		TAP_LOG(ERR,
 			"Kernel refused TC filter rule creation (%d): %s",
 			errno, strerror(errno));
-- 
2.51.0

