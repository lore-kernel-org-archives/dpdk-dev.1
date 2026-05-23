Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55312CD5BB8
	for <dpdk-dev@archiver.kernel.org>; Sat, 23 May 2026 19:56:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A22004067A;
	Sat, 23 May 2026 21:56:18 +0200 (CEST)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179]) by mails.dpdk.org (Postfix) with ESMTP id 7A5AC4042F
 for <dev@dpdk.org>; Sat, 23 May 2026 21:56:13 +0200 (CEST)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-3044857f09aso3350319eec.1
 for <dev@dpdk.org>; Sat, 23 May 2026 12:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779566172;
 x=1780170972; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zFZDpG4eV0HCHZKgDiuGv3S4hmSfbHtRtepgmSaR2HI=;
 b=TSk8ch0NCLJO/sEtlL/UNgUynTzm6x7DBepF0k5cWCobdxxfSKzFgy/XALfoJ41HSO
 JL2FnU7Q0nXm+JdWPoYBWgNlI7/Laq9OgzSEw30RpusWiOqlFZ6SuwB6/SiAEsN7psOJ
 kJxpoS+YFu/9Pfv6jESsGJG8gRzcEhWO3924IsGJ/MpUWRX8zmZTjkXb7trjHyUJaCit
 rXr5wBD5D8uJannqX/LPRsZHUqwpoA2O1bhChpIy2oN527dgedRmVGyqp5op05R6so+I
 jeSfuB5X8eHrnm5Xvb50/VNWY2e8GOjHfx2xmtjMUE2u7rUzdck++cjq4SBB4jiJ++/c
 l3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779566172; x=1780170972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zFZDpG4eV0HCHZKgDiuGv3S4hmSfbHtRtepgmSaR2HI=;
 b=nfNKkGME8q21bg7ntmlIiqJ11V9vDUzUoBk+iVBLvm6b3Na+hoGdjLQyYADEWDp/yU
 nVFZGMnUOZvAQRYKZHM2g7LG0H6AxwC765ZtnfwMSB313ABpiRQLvXm2PrmH4pTkwkmL
 Zvs2yauf6+7cTcfOTwPk+cUfmVU7L9I+FHC+XcMnbjXTXlt2dgTEnIyZB5fSmVVl5wUh
 NZnScJreT9oUGsKZhvMwP7kCIyHANyp611LegrJspwGvp6j3AgIZoXJDT5iB1Tv24msF
 h6/ld+WmHqfUg5FzYGFlo/B+/2jZet7EIrLI3nhoqGkGbYHUSYMK1AyeKD/U57YRUx7Y
 RDyQ==
X-Gm-Message-State: AOJu0YzXw5a3SpxCFb14tBwWdWvdqaWor6irChCmQX08plPliI3TXuhP
 v9RXnIVNMfQgcrBHG8k2kcsjbcdZCr79MlnV/T3pztRKxtmVm7pnKnorhbTO6kiDh6mAUSvAlSr
 tCcqv
X-Gm-Gg: Acq92OFmH1QsYFrKmJ3PPHxU2wKTwvDQ0oPV4vCbAuzYb33t6FJ6j+xZlEKyAtLkI2L
 Fcl5kXnEtMfgRoS/ASiYMoWRdMTfZ6jgF0UPQpiWkirBEJxVBlLxyweVymiKllcXpLs4/+eIQW5
 6651x2MGkyIP46qxPVc//dV84ndhQljdqY3lfsQHE9929q8+WWomBCerlpLrlgOVOfYH4bmak/H
 Ci82oaTy5oJHE6Fl10wxzsH7tSGY3lHo1pkopuKZa3rjoXl3BThOgXfwF/dGxENHtppj3q0/Zv8
 MtXTObM4BWmuRDyLDE2Bp2EV0X5aGiEzN6g5abmGuftDOd7yunU4GSu5IllJTbwB6aN5qpoHms9
 MrKJ8GRlmiee2ii/3coaKpJj51tAb5LqiPJAYqaz7l2orXfdgslFWV3eNfoob3ehjk6TROckKzl
 vRtC2h4LgWo78JyVmqjeuSuYOiZfHv31zOargx0GXvJJvLnZipNb7ooft1KKP2v9KU6sEuerOd
X-Received: by 2002:a05:7301:1687:b0:2f5:23fb:9aac with SMTP id
 5a478bee46e88-304490e03f1mr3828201eec.31.1779566172567; 
 Sat, 23 May 2026 12:56:12 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30451f3feadsm5257271eec.13.2026.05.23.12.56.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 12:56:12 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 06/27] net/nbl: remove unused rte_atomic16 field
Date: Sat, 23 May 2026 12:16:08 -0700
Message-ID: <20260523195604.441947-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523195604.441947-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260523195604.441947-1-stephen@networkplumber.org>
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

The tx_current_queue was defined as rte_atomic16_t which
is deprecated. Remove it since it was never used.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/nbl/nbl_hw/nbl_resource.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/nbl/nbl_hw/nbl_resource.h b/drivers/net/nbl/nbl_hw/nbl_resource.h
index bf5a9461f5..f2182ba6bc 100644
--- a/drivers/net/nbl/nbl_hw/nbl_resource.h
+++ b/drivers/net/nbl/nbl_hw/nbl_resource.h
@@ -225,7 +225,6 @@ struct nbl_res_info {
 	u16 base_qid;
 	u16 lcore_max;
 	u16 *pf_qid_to_lcore_id;
-	rte_atomic16_t tx_current_queue;
 };
 
 struct nbl_resource_mgt {
-- 
2.53.0

