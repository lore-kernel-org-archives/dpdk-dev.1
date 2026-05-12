Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787F0CD4F24
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 May 2026 12:35:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C928E40657;
	Wed, 13 May 2026 14:35:23 +0200 (CEST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id 64453402B5
 for <dev@dpdk.org>; Wed, 13 May 2026 01:42:35 +0200 (CEST)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2ba3e3c4f87so56261605ad.3
 for <dev@dpdk.org>; Tue, 12 May 2026 16:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778629354; x=1779234154; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sN4tXiAcqN8VTDoVjmBu0syj4E2vR25EUs6cn9dRowQ=;
 b=n2/i9YukKlLeY8TUBvqNWuP/aN4ExJtbC7wWCNYd7ZtlI0M/A+F+ng24zY5Ym9sRyk
 dr4Yy3DBSPzdzOAtFWD6N7vNCitOHMYGdraNIBCWC94iWgVOyIRVA0H9sbfQZ9/GcQbn
 ErpweHfZd+5a5YH3b2Y8ITJUYtbmf62HXdX92bJni5Dg8riC6eaNrpEGYA2dBJVgjuhd
 YYhzoBHnGPigO/eU7/R1TcIqFM2ZN776UFpY/WmzCHrNvkmO1jLEoFDR9XgKn2WEbcTA
 Vikw0tK9mSdPbkf41Uh5wYtJmXDNGhHimlGHv8PRkjXlHCSVIf09ZNsxe2dU3xj7XLf9
 97VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778629354; x=1779234154;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sN4tXiAcqN8VTDoVjmBu0syj4E2vR25EUs6cn9dRowQ=;
 b=qhLXadC2nPbKuGWtBRwRONQuUfcQv887cKJUxTZMsmljHqvRpz/OZai2x/NhCd98Sn
 nZGSxgwtnhKIMU8/aH8pKwIdblbwutZ00H8iEXi7BU79vYU5kgMXqKrREauoTxDrwXiK
 ocHftMI/HcEgLctzerPVYPl3vln3pNbuH4Gn0/nuVQfPW9aWdt7pvL03RfV/XQ+PaXR3
 9ADwgDfKosLGYbGBujVzBz/tFUKI5CfS75ymFMlFkx8hIYNXInYl1b/cNh6dxYJRbZLG
 fhJrslc4ozjx2+qrcxf8Khr1XJYYL8mLa3u0ueCnur5K0Ow/orx8DLALuOLfU0xV7H7U
 z9Ig==
X-Gm-Message-State: AOJu0YyQNER8t5cpy2WLjElqWSraI9v8ACsnri3RI929cn8g4Uo2zZ6+
 7aUnmFfNt/OGUuVYUorDswAZtUs88mLDLK9c5G24mXLepvnwZBUINT9lwG33lw==
X-Gm-Gg: Acq92OGzvXkKTALKWJ1L19M6qiNqfj2iNa1cS/DvptYaSr/g/nfI/jH6h09T1PWyiV5
 g0DBoOdT4z2nGl1N0AvcrBUC5Fihyylc6a2k/lIeAduDzLjiA/iFthC1EQGGlmo2zjS1J6qvZ9l
 9kSfjAO3Zq9V+sSllBbFEoHhKDApk6sXUeOCyNa/iWzw7YJYo2nN1Gf5S4EdzMQOkz0lxasx0Ot
 m2Ae/QZgif9eRBLLc22T/M/Jw0IXGznWdC2VvlAshH+V46r5kdoeUYvRhRXIgowLnj/AUDd5RHw
 RdLr1SpIDlWpY06SKec3CRwCwFtwgf0Mxluh+br3AYNQPQqzA8m7wFi9o2B7K1qzS3wsP8mBvBk
 orELt2mFNUhV4ROth6FARzwiOXUZX8v7qezjDvY1FAmsR8WF6p098RKIcE4yoip37KIiL+pJX58
 E14wtHJUwCZpq6k0C8w4/RDfLJ5vIniWoXkbMg3BGEBATgpWD/EmJ2IDtHnpNyZTXQY+QIC2Nqh
 C+J+qJbyhImqT052p1+RdPz
X-Received: by 2002:a17:903:198c:b0:2bc:a577:70c2 with SMTP id
 d9443c01a7336-2bd276e9861mr11238285ad.31.1778629350585; 
 Tue, 12 May 2026 16:42:30 -0700 (PDT)
Received: from arin-Desktop.dhcp4.washington.edu ([205.175.106.86])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1e35632sm152652695ad.53.2026.05.12.16.42.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 16:42:30 -0700 (PDT)
From: Arin Kharkar <arinkharkar@gmail.com>
To: dev@dpdk.org
Cc: Arin Kharkar <arinkharkar@gmail.com>
Subject: [PATCH] FIX: excessive logging in I40E driver
Date: Tue, 12 May 2026 16:42:27 -0700
Message-ID: <20260512234227.218761-1-arinkharkar@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 13 May 2026 14:35:20 +0200
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

Resolved bug #1936 by changing the log level in i40e_set_tx_function from NOTICE to DEBUG
---
 drivers/net/intel/i40e/i40e_rxtx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index c5ac75e0f0..bc48303a25 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -3124,7 +3124,7 @@ i40e_set_tx_function(struct rte_eth_dev *dev)
 					 i40e_tx_path_infos[ad->tx_func_type].pkt_burst;
 	dev->tx_pkt_prepare = i40e_tx_path_infos[ad->tx_func_type].pkt_prep;
 
-	PMD_DRV_LOG(NOTICE, "Using %s (port %d).",
+	PMD_DRV_LOG(DEBUG, "Using %s (port %d).",
 		i40e_tx_path_infos[ad->tx_func_type].info, dev->data->port_id);
 
 	if (ad->tx_func_type == I40E_TX_SCALAR_SIMPLE ||
-- 
2.43.0

