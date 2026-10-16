Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF83CCA462
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 11:32:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCA7940A89;
	Fri, 16 Oct 2026 13:31:37 +0200 (CEST)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177]) by mails.dpdk.org (Postfix) with ESMTP id D1255402EE
 for <dev@dpdk.org>; Fri, 16 Oct 2026 08:27:10 +0200 (CEST)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-35f1f76ea84so3014868eec.1
 for <dev@dpdk.org>; Thu, 15 Oct 2026 23:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792132030; x=1792736830; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IGKrKUYqKbzZVB2hi2S0//1VkHHUrkCfNrzOOxfMzg0=;
 b=Agmt2tnoTaCdrvKlx4Ns9Mny+nAm5EA6uW8rEpJcs9eMRgFtp98eQuFboR+5WQF9c5
 5/v6AAhDEGybZlPAujZtQsp0dNN/choFA00LAxXZWCLJEHFASyeO49ZjTYTMZVxtCU85
 RFW0PJpkdNLJQercBA2MqOCBoSCK4GJkwBS4Bu1I9EJ+KICJXmS4y1j6j5RRP5t10cCp
 VTx+r8Cb9W/IqmI65I5CaGyPDTjIehej5+rgWIwCYPwXVmricUR8USvn1ODmtFzbLaul
 fVuF4jxxGxhPQCtdLoIUWzXZYnmQ8NvrHF/KtvbEBNK2NcnuhHmUyFrAfy+NPIEQ63DN
 bifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792132030; x=1792736830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IGKrKUYqKbzZVB2hi2S0//1VkHHUrkCfNrzOOxfMzg0=;
 b=I7OHH/7kircL17CugE38/gS94WcO/puT9IQQOjgl0CaK3XzkJRBi3JRKRwas35JpiP
 ult5kGHM2kJoSn4aunN1epTpbmxueHFhnhcGelVF+PvM1s8NwbGTofxb8cEuEXk5aoU9
 KBoslOkdaz5lKaEWFfuO3hrin7NaaDM1vn1MEWjx1t0ownSXeWlUhKa2p9/Z3ZWGKQPV
 rsTUSzw64DgENQZpjhapqBFID4l6T8ncBBY36xYZchMa+TACU/hLYis13/0p5jZwqmjs
 PEEJfbFAMxeg25iXYCFoY4bE+lSSbbINKBvXnZowX6OaEP47fl4YNWfKwzeHkKhJO8mS
 BzlQ==
X-Gm-Message-State: AFq9FYIY1KWmM7mNlfroa7v3wCumMWLF2H8D1Wa9yV4x9ykKhfEhHd3Z
 JioJR+SMZ/+koY1uAMitoUDOxhr1JuG1Xm+nJEr69QVaykMxrXTWbVf+L98Y2A==
X-Gm-Gg: AYBFou1op1Bau14UaapsGlLPqtYR6yahlcImBSBJqPUwp00mVWn2a+wX0gIwRTS9Ky2
 4rWIr/h4Yl1escpywR8HLpFGc3N0tnx9qFd5MYXgGvDCek3wFS22GXWPfszLoydPtQ1MkjSp4tw
 SpBhNH4Hwwjs8MtQx7CqlgHydvPrh4wSd2sqzKkJ7dmQ0RviHrjwYZ7eD/+LYT+YTpcEf7okW5W
 zBOTpCiCpe4Oa447kEpEm+i9vrFQuiTOgsHATVaMynPCcFtwaxmuYE8B4jBEliIIfZXBtNwHNot
 UPdAMRRiwytqSECZUBy67JEm7qAXqeHbqxwez2v1qKPxHRTncuOnFoVm0ALkmQk9/070BkT+EGe
 SotgBC6PTthto399jRhkLsJYNzu4r72OSe1VTuhMkV7VM9d/vKYf6nPwRu84ZFd9jRr1hxdcbZa
 q5+UdRfuQsXRDpT7zwMIfh+NLhm2C0dOjFK7oVTIzPBCSDbJYN8lHQGJgXzjsmKv8DKWh/VzDK
X-Received: by 2002:a05:701b:2512:b0:15a:4155:3d9a with SMTP id
 a92af1059eb24-16a6222be65mr28228788c88.47.1792132029855; 
 Thu, 15 Oct 2026 23:27:09 -0700 (PDT)
Received: from aviuser.. ([192.19.252.250]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-183190aa3ebsm2743324c88.8.2026.10.15.23.27.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 23:27:09 -0700 (PDT)
From: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
To: dev@dpdk.org
Cc: joshwash@google.com,
	stephen@networkplumber.org,
	stable@dpdk.org
Subject: [PATCH v3 07/10] net/gve: export Tx drop counters in xstats
Date: Fri, 16 Oct 2026 06:26:44 +0000
Message-ID: <25078ce17e3ced8c5d4a9183ddba98fe47991c37.1792129992.git.tathagat.dpdk@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792129992.git.tathagat.dpdk@gmail.com>
References: <cover.1792129992.git.tathagat.dpdk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 16 Oct 2026 13:31:30 +0200
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

too_many_descs is counted but missing from the Tx xstats table, so it
cannot be read. Export it together with invalid_mbufs.

Fixes: f4a70b449bfa ("net/gve: add DQO Tx descriptor limit")
Cc: stable@dpdk.org

Signed-off-by: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
---
 drivers/net/gve/gve_ethdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index c990920a4d..cbfb07edf6 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -983,6 +983,8 @@ static const struct gve_xstats_name_offset tx_xstats_name_offset[] = {
 	{ "packets", TX_QUEUE_STATS_OFFSET(packets) },
 	{ "bytes",   TX_QUEUE_STATS_OFFSET(bytes) },
 	{ "errors",  TX_QUEUE_STATS_OFFSET(errors) },
+	{ "too_many_descs", TX_QUEUE_STATS_OFFSET(too_many_descs) },
+	{ "invalid_mbufs", TX_QUEUE_STATS_OFFSET(invalid_mbufs) },
 };
 
 static const struct gve_xstats_name_offset rx_xstats_name_offset[] = {
-- 
2.43.0

