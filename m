Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2752C982D8
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Sep 2026 18:14:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7FB4D40B9E;
	Sun, 20 Sep 2026 20:13:59 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id CCEC1402D6
 for <dev@dpdk.org>; Sun, 20 Sep 2026 20:13:54 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-396ccdaea76so968023a91.0
 for <dev@dpdk.org>; Sun, 20 Sep 2026 11:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789928034;
 x=1790532834; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mCjo1zW/COJ7cysGt/Qj/MjL4vcleEX7sI0sl12GgLc=;
 b=IJ8plVn7JCBnbvdSsJD9lKE/FkN8Qg6GbT0fxwYDUXPMH5QxXwm1QtgUjXn0slCwic
 Vt9VYQbtRBkX9mZn+i8s+vHWVpVVn4jX7/cRn3TvS9yuuPkcLvr9qpxBPkiQgoymFUR0
 gKnc/gX7yvDk85UrNyuo4xM6IM1JFlUzame2vnpFJZkDjG81+1uYhMvj1qE8gchBWrec
 syx6uZ7nN4ahUnrFTfNmfiIachjwr3tiX2Pw5yp36vAEV7knNsgG2LvqKdBV8fYSVz2H
 ktaDS3/zwDPkFQaRJuUIPANpMMFf2JYHmLocNqM2W/Af8zjBrXR63+VDP4tVdSPBDv76
 b+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789928034; x=1790532834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mCjo1zW/COJ7cysGt/Qj/MjL4vcleEX7sI0sl12GgLc=;
 b=IQOoZZae0SbJJukDAAALBoS1ob0EPNBXNCYiOHyqkAErV61FYcpTGe49uvuXYUDwCE
 md5X8doZHtifwPAqwTkuFcPczp+floC5OiengzULgzHUyhisRGuHjskbGaJr5KucHScX
 YOIrvUN6YpVPVf5FovJVNyQtYBLOhUoD1ku94w+aTzX5Kc20BoRKKdYBChds0EXg9462
 LS+WAeuUr3gbeDRAU8lHLtPPQXQSLOB8R6eJdHu95XfFcl6IbLHUkZdBgv7d+i/CqIps
 no7OGajXCV5rIXa/SlqaO10CT+KiWxtyzqtfeg0gYzlkbFlpVDuGEJd83OVqsTxfuX3c
 IAVg==
X-Gm-Message-State: AFuF++mXBw4P85hYKsMcZt5WX9AP0BmisaMuz6biqk4oQUsR/LsuYwQ5
 KqldtEWjhVGfL46s9xPNQMGvPt05zpM1gXZLFz/RTKliFytHPAivm9oo8gBey6/1EYAPUcY8FiU
 uKLE5
X-Gm-Gg: AYBFou28j8jBPzIv7ooYrGY6hgE6Tpc4DeIoP60xgiw+iRD3bvjwHXXA79XAWrjL4g/
 TnCKGv/Q9fYX7E/BCoXoXJIuOy173Iglf4vdz4VIWOhIbrdjkSMCCsvrXEn7AoohHAWbrpY4RXY
 M+7Dk/OkzLSqpCiQKfRJro+oxLzBEPfbdfPgDROWxNUJ/Uw4GkxB8cs0fvnNUC6gUV94BmqrLJn
 qhhGT8GAdq0w50XnxLzeduB2cBiQ3E8PVCLj8gIv2tDutSkYUNKomaYpLdb0gNNmYqzV0Yc3VeD
 KcZ/j+X+geHCkMcpKweaoBqhBMIjPAz7wtH9DLSe6kmyh39q2vHTKXCkw0DvVGG/nGyc4ZqavIJ
 SLYyaliAmYHfkT1Pdntiqy2n73jU9pIxfnnFNlZZKQKv1afPOtZnA+WUJgi0wqexxw+ygxloXj4
 0vTAA+WPC8PUHx5Qnl1q6fbQe286Iw3mq1Ctdjp7cIMOLSxC7OAGpuZz8Zuskef6yXDyIr9l18F
 vrmlbPD/z9oeEH51jr0QvyPsIKZIuU+AZgWmg==
X-Received: by 2002:a17:90b:58c5:b0:39e:6c68:fd8c with SMTP id
 98e67ed59e1d1-39e6c68fed1mr4769081a91.33.1789928033770; 
 Sun, 20 Sep 2026 11:13:53 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e6c37a88csm10088091a91.8.2026.09.20.11.13.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 11:13:53 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu <weh@microsoft.com>
Subject: [PATCH v2 02/33] bus/vmbus: remove packed attribute from ring buffer
Date: Sun, 20 Sep 2026 11:09:54 -0700
Message-ID: <20260920181347.747210-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920181347.747210-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260920181347.747210-1-stephen@networkplumber.org>
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

The attribute came from the FreeBSD structure this was copied from,
which ends in a flexible array member for the ring data and is
asserted to be page sized. DPDK computes the data offset from the
page size instead and never declared that member, so nothing is
left that packing affects: all remaining members are naturally
aligned and the layout is identical without it.

Byte alignment does prevent atomic access to the ring indexes,
which clang rejects with -Watomic-alignment.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/bus/vmbus/rte_vmbus_reg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/vmbus/rte_vmbus_reg.h b/drivers/bus/vmbus/rte_vmbus_reg.h
index 6370a07f95..210328c877 100644
--- a/drivers/bus/vmbus/rte_vmbus_reg.h
+++ b/drivers/bus/vmbus/rte_vmbus_reg.h
@@ -69,7 +69,7 @@ struct __rte_packed_begin vmbus_mon_page {
  * Buffer ring
  */
 
-struct __rte_packed_begin vmbus_bufring {
+struct vmbus_bufring {
 	volatile uint32_t windex;
 	volatile uint32_t rindex;
 
@@ -111,7 +111,7 @@ struct __rte_packed_begin vmbus_bufring {
 	 * page aligned and starts at rte_mem_page_size() from the beginning
 	 * of this structure
 	 */
-} __rte_packed_end;
+};
 
 /*
  * Channel packets
-- 
2.53.0

