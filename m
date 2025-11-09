Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE83CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Sun,  9 Nov 2025 20:09:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A0934042F;
	Sun,  9 Nov 2025 21:09:02 +0100 (CET)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52]) by mails.dpdk.org (Postfix) with ESMTP id 60BDA402E4
 for <dev@dpdk.org>; Sun,  9 Nov 2025 21:09:01 +0100 (CET)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-3438d4ae152so527610a91.1
 for <dev@dpdk.org>; Sun, 09 Nov 2025 12:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762718940;
 x=1763323740; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zpKV+aYKEYv3UyXwR/W8FMPOml3VfqjIIZuoyl4zr+c=;
 b=Phgitph65bjPXR5iCqvVYgui5cP3o7hxW3PwBBnwZegOG9tiBwJOXKTg7ZXwNtaaIK
 vPqAqQBEwNniRuNUbTwsqaCkoWZMz/7OSpHYSLhAc2rpEye/fMZ5HgDeLb40ncT7yAXO
 8WCRKxFHXY3Ez65ltYA28rDloaYc5cM0WJWxV+rLmS3vYMsobQRTLzzGu3KiUbTBJkWk
 VwUBApm8DVPN7aQGRF7WV9iYInn3lFZDquS8X0YNgYZy6vtVkeVqW54+0TCT7YL5qOx+
 CR8C2gKcqSdwfSSAFMIf6ZukbElC7eEgv095XdiOMtOFh6kI2RDuYOVcj9Upp4Waevlg
 /Cww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762718940; x=1763323740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zpKV+aYKEYv3UyXwR/W8FMPOml3VfqjIIZuoyl4zr+c=;
 b=sMp1tEb8PzN1F1rumtzURlDg5w3QBw7x9iVNt4SqBTBUisr0VRG4rU0TTYdFYCRoic
 XfkjhqxsNUlr147vW5Jj5JKExrXFlPE768zWioCZh44r1zDBjd4DV/Pt7HJsbj43Goxg
 SvxgLi+otzt/xujsbc1KIxVmSq4mCXxu36js5J4AhZEzVDmy7+pP7SHTbYRA1mXkdSol
 ygfYtXaGkWaNnmWwttHUUZfFqy0+o9BJExGflu5qZe777PlWfVkMKdl2v4S1y5jsJkb+
 7o/vqDqA/ySmD8Uc+/0n36wlzZgnfurQXTmDWIw6kDU85KLZbCHyy2oKUQhEH+oGv1wx
 wzBA==
X-Gm-Message-State: AOJu0YzGRudsxsMjfwTrGoWTOD05DABOXYSo6L/04AeaEngvjyVazDsc
 hr2iBCU6vyrdHuelqEDnDwruxmfmhEtbOaKSBdi6CCoQpSRv3mXxSrHzbHXVmybgdA6yT7IIO1K
 E3ETz2+o=
X-Gm-Gg: ASbGncvMO4/1a1M6FxV0hv23FU/0eRh/ppZh05CyaZ+sfAif56gGz0QOTZ955WFVpAf
 CJLwqjBCNyzuVuamBT1tXoHLBm5XjGQ0/J6oxAgi3VygKREZ97OKbO21iqHW6stNz/voiKoaKYM
 EGsUlhleBaAgPMZz/BiPB1gY0JVUO2xxA3M2vgodeMN54NVzPgQt4/2lIKF+Xj+A0QH3z3rn+Gw
 f3JOe/Q0zbcBV8NPyfpraegrLk/agnL43820l0zejNagGI5PiUgMXQP3w0mQR9kp5xg4pPeWqc5
 ut9TX5RvyPdF8HP1AGfRONBKNqOCJdzShIXQX4P7dDoCvpFCp2gfXlviA6dsL/hTq6xFlaka/xs
 kU3giuG4ymPZj9JUt/ZYddUQPK2hq9nV79ADtosXH1n0twCmastTu0HeVCMCRghKD1Lrq8R+RbX
 RBFeNMxtiQAN8wp7eHGbGc9deD770AnIjf7ycmcuBd44bpf9oHEQ==
X-Google-Smtp-Source: AGHT+IGON+6C6aP8RrgwwRRILBU7kINZqXG8vIDSmAMb89x9WURU2FFrIl6rQE9ot6Lac1+Jw3HZDg==
X-Received: by 2002:a17:90b:224e:b0:340:b152:65c0 with SMTP id
 98e67ed59e1d1-3436cbb240cmr6898966a91.26.1762718940419; 
 Sun, 09 Nov 2025 12:09:00 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-341a699d6dfsm15396648a91.16.2025.11.09.12.08.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Nov 2025 12:09:00 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v5 2/5] bpf: use bulk free on filtered packets
Date: Sun,  9 Nov 2025 12:07:35 -0800
Message-ID: <20251109200854.45942-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251109200854.45942-1-stephen@networkplumber.org>
References: <20251030173732.246435-1-stephen@networkplumber.org>
 <20251109200854.45942-1-stephen@networkplumber.org>
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

When rte_pktmbuf_free_bulk is faster because it does single
mempool operation rather than per-packet.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Reviewed-by: Marat Khalili <marat.khalili@huawei.com>
---
 lib/bpf/bpf_pkt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/bpf/bpf_pkt.c b/lib/bpf/bpf_pkt.c
index 01f813c56b..087ac0f244 100644
--- a/lib/bpf/bpf_pkt.c
+++ b/lib/bpf/bpf_pkt.c
@@ -177,8 +177,7 @@ apply_filter(struct rte_mbuf *mb[], const uint64_t rc[], uint32_t num,
 
 	if (drop != 0) {
 		/* free filtered out mbufs */
-		for (i = 0; i != k; i++)
-			rte_pktmbuf_free(dr[i]);
+		rte_pktmbuf_free_bulk(dr, k);
 	} else {
 		/* copy filtered out mbufs beyond good ones */
 		for (i = 0; i != k; i++)
-- 
2.51.0

