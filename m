Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FCCC53200
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Jul 2026 17:59:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DAE4F40DDB;
	Wed, 29 Jul 2026 19:57:48 +0200 (CEST)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by mails.dpdk.org (Postfix) with ESMTP id 3DB5740BA0
 for <dev@dpdk.org>; Wed, 29 Jul 2026 19:57:41 +0200 (CEST)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-c9cf07d2df6so906769a12.2
 for <dev@dpdk.org>; Wed, 29 Jul 2026 10:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785347860;
 x=1785952660; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AutbEqXNQU9LPX5AmSCbzwCNp+NpT+lVDpgLHM8sOzo=;
 b=RG9jfebVi7KCtI7tJT8TUaXIIMv8MAmEc8QlPnHxj8QH6TWlesnLNrSdBnaujF7sSm
 1AmtXxhjo9lJ8YC8qh9rmZiHpYRUwfDAL2gfBcLVODDHsTVBerH8Jq2NSFXQkjAtpxe9
 b6U7Dhq6wTpg799BLsXZH03hKL8SkiPlkDIqV0RdC6auSGr6KTPH2ApFGHDeWfa8ndic
 rZRt74OJ6DnK71zafrBkympeK4xv/+Pijg5Q4vt+kyWNvEF0zNzv5BVLcUm5Fya+ryj5
 kPFfIQx89bOpfFcNKfUExppZu3hdYKHf7WouF/8wyLBGiW8eOARRwa/hoRJZvREpA8Z6
 a1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785347860; x=1785952660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AutbEqXNQU9LPX5AmSCbzwCNp+NpT+lVDpgLHM8sOzo=;
 b=J9Pwhhfj7a7BRdEbssjPLZblmof6vswRCPLW0sdp/OS4WKqXOLIWkxo3ilXoe5sefJ
 GHAF0sBUxqGoWK88KjnablALxNISg1FFcIhkXtMQlI0SNAukeLNIX1rF57jzvbOlAa91
 6v89JMnY2nxUSgwm6yBKfdoHo47HNBWr0/5+MF3MDa3equq4DzGqm7Sg2jbQnXHG0Ylg
 0kFoCHBYGmorZSf4xbetgl7y640ubcapcAwHzLgHdSc+DckKGxybwANwp8xFJODLgsnc
 HLi1SVJRjt+gfYHkcr1jaB0aGWqQaVR+5z1RDdEbwqVe5Maq8pEUB3iw1K6WYcV0LFKF
 9W7A==
X-Gm-Message-State: AOJu0YwYzMwbJcbhcNn+VIJGCLqSXYdR53ttQimEwIwCTR0IwcBV3QAU
 ckhq7/6HrljtAcYytBr2qiklDD1styXkcRDroJ0XAVi0nSv0EcCgph5sXgtGklolsjGAwlX/Ppe
 RvZmQ
X-Gm-Gg: AR+sD12do6umGPKAcNPxGpp56E6Sk+LmJn5iDT27O2UDlqCxO4O3dVj2b5OiWn3RKAB
 XOj01KvEuz3w1cjyIYDg/n/8C4JzM7txyLZPfm+T71V1v1qOO7H9CdmhLwwpuhxChxMQwr3FB+X
 /7ABjGTTubIRHd5O4H0RJNpMjHRZRmYiObSalnbdguN8SzLbPtneX0SSJTtw9Sbbg+9PFJ3NioN
 O0yEP3qdfAuMI5SjdY3RXEouQYud38CC+jnyK7E/HgavSvHd/KoR9xOJInOY/Qzg7F7m9olXPSP
 QK5x/B5B1ZC7srabz6dG2I2H3hqfh8nXOXt0jodTQKxqiC1EqGG91KISCSbhuPsukcVTmGFotyR
 SE619lem7j5bMlw4NR03mmr5WTox9r6EYdPbp6zMTZ/9a1qnsO+nd9Tvc2NJvhIk7yLJLVNHewp
 oh3rQq8bGiOBq9KR88FMqA30u+EthCn4hR76D/Rh+Tjv1iW15HZr80myfUsadIg8P4A5w1cs5vM
 xYvHN8Ep9om+xlKjjs0nf7m22IuHLa/nEoKVQ==
X-Received: by 2002:a05:6a21:4cca:b0:3bf:b60b:da95 with SMTP id
 adf61e73a8af0-3c8ba66a166mr9260054637.60.1785347860449; 
 Wed, 29 Jul 2026 10:57:40 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504b15f77sm13111562eec.4.2026.07.29.10.57.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 10:57:40 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Harman Kalra <hkalra@marvell.com>
Subject: [RFC 21/32] mempool/octeontx: use IO barrier in pool destroy
Date: Wed, 29 Jul 2026 10:54:14 -0700
Message-ID: <20260729175715.165120-22-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729175715.165120-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
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

The barrier flushes outstanding writes to the FPA pool before the
teardown mailbox sequence. That is ordering against the device, so
use rte_io_wmb(). Control path.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/mempool/octeontx/octeontx_fpavf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mempool/octeontx/octeontx_fpavf.c b/drivers/mempool/octeontx/octeontx_fpavf.c
index 6cd0fc057f..7051422cb7 100644
--- a/drivers/mempool/octeontx/octeontx_fpavf.c
+++ b/drivers/mempool/octeontx/octeontx_fpavf.c
@@ -616,8 +616,8 @@ octeontx_fpa_bufpool_destroy(uintptr_t handle, int node_id)
 
 	RTE_SET_USED(node_id);
 
-	/* Wait for all outstanding writes to be committed */
-	rte_smp_wmb();
+	/* Make outstanding pool writes visible to the device */
+	rte_io_wmb();
 
 	if (unlikely(!octeontx_fpa_handle_valid(handle)))
 		return -EINVAL;
-- 
2.53.0

