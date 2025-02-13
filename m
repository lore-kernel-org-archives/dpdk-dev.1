Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54ED1C021A4
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Feb 2025 18:58:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 04EF040651;
	Thu, 13 Feb 2025 19:58:40 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 1762840263
 for <dev@dpdk.org>; Thu, 13 Feb 2025 19:58:37 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 5E659203F3E4; Thu, 13 Feb 2025 10:58:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5E659203F3E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
 s=default; t=1739473116;
 bh=9wwvYutofdUpq07ukXULUZYu04as6HnnRvmIjonlCQ8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dRGdOyMwlMs+T4DSfNAXM+fr0nhM8TenLlKPjEjEc1pp58XmuYiqNvEF8DzL0Qxkd
 R63mejgRc292pDtPRwSjQZYD6sGrGtGXyPXyYcFZE2H/Us00U012cHmpq2A0/nGDt3
 5QTewxsajGXEKJhPzmsHI8FZsKBklhJIs1/F3aNk=
From: longli@linuxonhyperv.com
To: Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Wei Hu <weh@microsoft.com>
Cc: dev@dpdk.org,
	Long Li <longli@microsoft.com>
Subject: [Patch v2 3/3] net/netvsc: log error on failure to switch data path
Date: Thu, 13 Feb 2025 10:58:25 -0800
Message-Id: <1739473105-17797-4-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1739473105-17797-1-git-send-email-longli@linuxonhyperv.com>
References: <1739473105-17797-1-git-send-email-longli@linuxonhyperv.com>
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

From: Long Li <longli@microsoft.com>

There is no recovery code path if netvsc failed to switch data path.

Log an error in this case for troubleshooting.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/net/netvsc/hn_vf.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/netvsc/hn_vf.c b/drivers/net/netvsc/hn_vf.c
index 5d8058774d..4ff766ec8b 100644
--- a/drivers/net/netvsc/hn_vf.c
+++ b/drivers/net/netvsc/hn_vf.c
@@ -316,8 +316,9 @@ static void hn_vf_remove(struct hn_data *hv)
 	} else {
 		/* Stop incoming packets from arriving on VF */
 		ret = hn_nvs_set_datapath(hv, NVS_DATAPATH_SYNTHETIC);
-		if (ret == 0)
-			hv->vf_ctx.vf_vsc_switched = false;
+		if (ret)
+			PMD_DRV_LOG(ERR, "Failed to switch to synthetic");
+		hv->vf_ctx.vf_vsc_switched = false;
 	}
 	rte_rwlock_write_unlock(&hv->vf_lock);
 }
-- 
2.34.1

