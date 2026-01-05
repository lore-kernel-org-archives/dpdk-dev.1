Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA64C47BD5
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Jan 2026 09:48:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20B2C4028F;
	Tue,  6 Jan 2026 10:48:50 +0100 (CET)
Received: from mx1.wirefilter.com (mx1.wirefilter.com [82.147.223.86])
 by mails.dpdk.org (Postfix) with ESMTP id 64BE440267
 for <dev@dpdk.org>; Mon,  5 Jan 2026 15:24:34 +0100 (CET)
Received: from egw.wirefilter.com (localhost.localdomain [127.0.0.1])
 by mx1.wirefilter.com (Proxmox) with ESMTP id 546EAC13BF;
 Mon,  5 Jan 2026 17:24:33 +0300 (+03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wirefilter.com;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:from:from:message-id:mime-version:reply-to:subject:subject
 :to:to; s=default; bh=eRHtpy4ETK2RPtDd4+jIc0+URW45lOV6WXNlEgPD+V
 E=; b=LH/hH2VcHTfs3F8cmZZMAG1fl3M/WMDsyLVzvoZrk6xcmjA4vptzb5dcVg
 KAkJ5d9aB/akyuzsh1E4QNksWXRpZFZkNmwaRfcJAFrlV8y6XJbxoHkSnIq2uFWZ
 6pZapSZ5nZO8EPu6YRfpKTsey69DwfjHLkBzaZrUdWR9aVn8ppmwehqOB3BO8yFq
 D7pRy9e+LvFkxn9/YmERRl9AHuZSI0vVor+zNIjfbJ25R1qQQV/o70nwjrScnL6/
 9DNnVsBMWEAzmeXVV/7dR3VqOboi0sfgfwifa59uV46cbJ3Ad3Eqx9Kdonr3Jzsn
 PYfpgyx6n6UA/kYmuHj+Q2lPFtvw==
Date: Mon, 5 Jan 2026 17:24:33 +0300 (AST)
From: Mohand Alrasheed <mrasheed@wirefilter.com>
To: dev <dev@dpdk.org>
Cc: dsosnowski <dsosnowski@nvidia.com>, viacheslavo <viacheslavo@nvidia.com>, 
 bingz <bingz@nvidia.com>, orika <orika@nvidia.com>, 
 suanmingm <suanmingm@nvidia.com>, matan <matan@nvidia.com>, 
 jackmin <jackmin@nvidia.com>, Mohand Alrasheed <mrasheed@wirefilter.com>
Message-ID: <205110942.16694617.1767623073046.JavaMail.zimbra@wirefilter.com>
Subject: [PATCH] net/mlx5: fix offset handling in mlx5_aso_cnt_sq_enqueue_burst
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.1.1.3]
X-Mailer: Zimbra 10.1.13_GA_4837 (ZimbraModernWebClient - SAF26
 (Mac)/10.1.13_GA_4837)
Thread-Index: Eo8Gc08mAGWstW7U3MFWd2XSVg8DZA==
Thread-Topic: net/mlx5: fix offset handling in mlx5_aso_cnt_sq_enqueue_burst
X-Mailman-Approved-At: Tue, 06 Jan 2026 10:48:49 +0100
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


From 9ca4302dd93461a7b01ad05af82ee2bcadf47675 Mon Sep 17 00:00:00 2001
From: Mohand Alrasheed <mrasheed@wirefilter.com>
Date: Mon, 5 Jan 2026 15:44:25 +0300
Subject: [PATCH] net/mlx5: fix offset handling in
 mlx5_aso_cnt_sq_enqueue_burst

mlx5_aso_cnt_sq_enqueue_burst() selects the ASO counter block using
dcs_id_base/4 and ignores the batch offset. This causes every batch to
target the first counter block, leading to counter aliasing (e.g. 2^16
matches 0).

This patch selects the counter block using the offset-adjusted index.

Reproducible example: https://github.com/Hawzen/rte-flow-async-profiling/blob/5e654e3a8a0414a5fa8ed43274195f180760f0b5/examples/flow_filtering/reproduce.md

Fixes: 4d368e1da3a453cbcac620e8844c0300b2f45cfa
Cc: jackmin@nvidia.com
Cc: stable@dpdk.org
---
 drivers/net/mlx5/mlx5_flow_aso.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/mlx5/mlx5_flow_aso.c b/drivers/net/mlx5/mlx5_flow_aso.c
index feca8c3e89..a232289024 100644
--- a/drivers/net/mlx5/mlx5_flow_aso.c
+++ b/drivers/net/mlx5/mlx5_flow_aso.c
@@ -1877,6 +1877,7 @@ mlx5_aso_cnt_sq_enqueue_burst(struct mlx5_hws_cnt_pool *cpool,
 	sq->elts[0].burst_size = max;
 	ctrl_gen_id = dcs_id_base;
 	ctrl_gen_id /= 4;
+	ctrl_gen_id += offset / 4;
 	do {
 		ccntid = upper_offset - max * 4;
 		wqe = &sq->sq_obj.aso_wqes[sq->head & mask];
--
2.39.5


