Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8137CC6B38
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 11:31:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A8F2540682;
	Fri, 16 Oct 2026 13:31:33 +0200 (CEST)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180]) by mails.dpdk.org (Postfix) with ESMTP id 58C1740609
 for <dev@dpdk.org>; Fri, 16 Oct 2026 08:26:58 +0200 (CEST)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-35f1f76ea84so3014696eec.1
 for <dev@dpdk.org>; Thu, 15 Oct 2026 23:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792132017; x=1792736817; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VngVBvo1PC91dHLbZQB3cW723kq1I3O3hnS9UXb1Xao=;
 b=V5V/ECIVJS4bYtPjhM2Pu7VikeYXragBXlCghiGGfB7YyFje7k0Uzur2FeCfVfvSXY
 1DZdE4o5gfL+mhyxLtS4vzXDdK6p6JkT3BRiib7tOqN1PTCXzMIwzYBXK/qaEXOKBasG
 BaiSfXzKfyzIf2nAGWveX4K+7dWF1N/nVipJ4OKsOnfcqFJlX2pxWxq3CTSCeVdt/3EK
 IU3LfC1scVg7pfpOvPj3tgx2hE5OqXE5Ulc/0EBGhSjGcu3icOAq5BlTYaOlKAhq7WMH
 Zvr+awL6TJvbXxuGoSYV3tQpYkIuCMYyZ302F0sP2GQ1ofOAN/Oh/sQOTWOxq6+ZJOmW
 mT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792132017; x=1792736817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VngVBvo1PC91dHLbZQB3cW723kq1I3O3hnS9UXb1Xao=;
 b=DN4NJuQ2VuxnSYEr9pxBxSRNpWwmLQsuhPTV1qpG7LxAH2Jrr/IqKVI/hcGy5q8vja
 Oc1WPfL28ibQ3QR/eHHnw/oqhlWEgJtx7dPLaPN6GkC4JbOftpecUhEuoNgnuO3Pm0/w
 14g6RcS8A+vdD/P2/TNSr1l+UCgHa/74zNGKNY7uoEF7N+pmxYgX6azXDdeimKMO7s4+
 2ncZdopsU9UbLESrYXH2WShFyYhdVtbeTdxvnX4/dbjnXAzVvr/Y4TXswpWFM7TAo9Bi
 UYBjVmOpECpIq8A66lr2yi9w6dZXD39APX5QZJ+FDwupLmpj91DKj7wwQDPDBYArIrGU
 5yTQ==
X-Gm-Message-State: AFq9FYJtB+/0dbzezpcvTnRWaf45DK6gqvtIxevZoFLS2rGQPETkd/NH
 0tDhOQvgG/qSSgFVOVOaFYtX1R1ScX2YIvE2I5pQ/n4I+p2pUjwvUDALHQhK9g==
X-Gm-Gg: AYBFou27J6s0FY9YdC9O0EEA4AD2zbGe+jboRFw5+NiuRe2HT2sco3FoLFoGyQvz0tQ
 wuhOylpFzVkiihIYZahzvpB2TPoFsnxjJ1Qsu3BZmQTlVYz3OTe3n/4f6XMYzYteUve9513vSI3
 5nXJCsf8ETSWWV8aPuzMPIPTzDOBkBxxuWYl9Acb2JlceAB1M0ORDsYgifz/FoJKjWwGYqF4Xm6
 U93qH0FsC3ucD4F0mqYz8Zc7a8g+CbiRn61T6Ox8zECYHbToAm/HJEyXHGuT19vLN9jW3orjzWh
 YQev+LepWfJmAqCsJrwrt2nqc3O+SB4sDM8dMeoZpmoG7i4/taLe4j28SmnoaJgOOW4EBLXXZjx
 Ij40UrItzurcljmQfY27IA9Y51WhrKgxF84n3/6cyarrWMhfT5Qqx8RnvOSwQw0wdaDJRgalQT3
 OeiwoNJgHYJsDKk0/PpwfDoKx+lS7VLivd4+kiDdt+LXg2TfaLAnkPl8KhErWjjaAbQ7SWlP9XA
 IC0zA5sUQk=
X-Received: by 2002:a05:701b:21db:b0:149:ef22:2fa2 with SMTP id
 a92af1059eb24-16a5dcf5a62mr28138611c88.8.1792132017316; 
 Thu, 15 Oct 2026 23:26:57 -0700 (PDT)
Received: from aviuser.. ([192.19.252.250]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-183190aa3ebsm2743324c88.8.2026.10.15.23.26.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 23:26:57 -0700 (PDT)
From: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
To: dev@dpdk.org
Cc: joshwash@google.com,
	stephen@networkplumber.org,
	stable@dpdk.org
Subject: [PATCH v3 02/10] net/gve: fix DQO completion queue stall on unknown
 type
Date: Fri, 16 Oct 2026 06:26:39 +0000
Message-ID: <cd76d21c006035cd2bf734dd1106013a50815250.1792129992.git.tathagat.dpdk@gmail.com>
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

When gve_tx_clean_dqo() sees an unknown completion type, it returns
without advancing complq_tail. Every later call stops at the same
entry, so Tx completions are never processed again.

Log the type and skip the entry.

Fixes: 4022f9999f56 ("net/gve: support basic Tx data path for DQO")
Cc: stable@dpdk.org

Signed-off-by: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
Acked-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/gve/gve_tx_dqo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
index e094761b38..c864d722d9 100644
--- a/drivers/net/gve/gve_tx_dqo.c
+++ b/drivers/net/gve/gve_tx_dqo.c
@@ -108,8 +108,8 @@ gve_tx_clean_dqo(struct gve_tx_queue *txq)
 		PMD_DRV_DP_LOG(DEBUG, "GVE_COMPL_TYPE_DQO_MISS ignored !!!");
 		break;
 	default:
-		PMD_DRV_DP_LOG(ERR, "unknown completion type.");
-		return;
+		PMD_DRV_DP_LOG(ERR, "unknown completion type %u", compl_desc->type);
+		break;
 	}
 
 	next++;
-- 
2.43.0

