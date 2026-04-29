Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B452FF887E
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 18:21:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D9C840672;
	Wed, 29 Apr 2026 20:21:05 +0200 (CEST)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173]) by mails.dpdk.org (Postfix) with ESMTP id E4AA2402AC
 for <dev@dpdk.org>; Wed, 29 Apr 2026 20:21:01 +0200 (CEST)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-2ba9c484e5eso102736eec.1
 for <dev@dpdk.org>; Wed, 29 Apr 2026 11:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777486861;
 x=1778091661; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=stJp0keWiZqoanwg+qwRhajC3O05QE5rH/IOjZ75K2Y=;
 b=Qj3ZBP1y58ZLiKZjdaU2h8slDymEYh5xLmfa0N5hGhCRBMMBsanJ+R0p9+YNTNAQo3
 nBghjnoJDS1yJE8rsBIvBfwoVo+tisG+vw4AoenF4jX+jqtPDdMSuO0Y9/+sJRvLbKYe
 EsmPs+vQ751D1kYKAtKP5NubsSQqyEw3SrYlouWDyFJ9sxDv8+/hiHV0X+CHAsMrg/Ou
 OUdz79NnfwMzcaIuPUyjWxCJAXb3M3Sd/HgkkCW7cltD/fCa+ChdnfkPRxu7axX3LknV
 RCs5A5k/YLrPSOtVDxrRn0NegI4s2IgJHe3P8ojnhDQVP8VYq+h2FZ75iDPgSbrd1a4O
 762w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777486861; x=1778091661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=stJp0keWiZqoanwg+qwRhajC3O05QE5rH/IOjZ75K2Y=;
 b=MxeoM8VmIhiUg3YiJp33/M1XF1csOUmA+pPA2zSVNDwoeCP4az6uur9/C14gpo6b69
 r0KZlbyHPqul2OBK7TxHOE3qLwZH3ijJPI/v5ck8RrkINC/R2SUbMcLWx525KAZP1pMc
 nu7x6W73tQYXew0Gka8Z+/RQMDeXNztWLqpSVId36OFyqfQjBnHDE6CtAe5dVgIOp6jv
 WxH2LzbX319XDtKw0CO3UgQwpx/Zy22ewUq/Iyn8bHSDMgdujcA4asnNt0ziS3sjZA0u
 tmTDmgvhqw/lL37x7OUS746aW8lWNZhmt02c0otUvqUXuFQtlDI6wH0nvplGdIRjys4O
 tFpw==
X-Gm-Message-State: AOJu0Yzn0L3ArY/UimllFXznksxLhXDK1bRt+1VlOUnaeATLbeHdSw3P
 ZpnFpkJyQpOdrLWUb3JNTB7QAaB20sOrJrR2/NwsXwi6RojFj9r03+gvvnwQRHoq8RCzYoY85VO
 ESNZP
X-Gm-Gg: AeBDieut1yHMbcv6/6vp3jSjncJA9lmhL9E4X856IkT3SkcTlgrr4bxZlCwyLXo9WNi
 yrrSc5Os55oMVXElNfCkcumWZewMTAgHzfLbBKBD0weJMwrryw2etpP5EMgBVDr1Rlgj7vDBR47
 0UoWfB1ohHwu/8PlZMUufTJHUvzwkCiwgnYELgnvyVITqWmjFl461G4MMaYCgwz/9JXISZdAlxk
 Bfl09aC964cYs2PyRMZsQ+JW9y24W4ObFb1D5pcMe5EmfI2nkL6SQwuPTazbit2ZotaXRsBgtwY
 7qLgaeLxd4hx5RsaiQY9wyFttNjVQmXF1nvvgAUmEtKOkTRzdxPxVIMI2PZ30wdV3s/q9CKOgeP
 9vsl9TuIkq57rStDnLfvqKV1Y2GoT/MMVrgAQI4nlo2atzWZMYDqtg2ZYXuD5RTGgUM9bdPDwH1
 M6AjEjtyZQs6/7ejj40Pl2/PVQvV51BrlVV4d56nETSP8=
X-Received: by 2002:a05:7301:3d19:b0:2ed:e14:42e5 with SMTP id
 5a478bee46e88-2ed0e1443d6mr3080019eec.30.1777486860963; 
 Wed, 29 Apr 2026 11:21:00 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1bf8e7absm3230152eec.10.2026.04.29.11.20.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 11:21:00 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v6 1/3] maintainers: nominate myself for af_packet
Date: Wed, 29 Apr 2026 11:18:59 -0700
Message-ID: <20260429182055.398105-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429182055.398105-1-stephen@networkplumber.org>
References: <20260413230018.515837-1-stephen@networkplumber.org>
 <20260429182055.398105-1-stephen@networkplumber.org>
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

John Linville has retired from RedHat is no longer actively
involved with DPDK. I am retired but still active and do
the review for this.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f5539f851..723e26dec3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -671,7 +671,7 @@ F: app/test/test_link_bonding*
 F: examples/bond/
 
 Linux AF_PACKET
-M: John W. Linville <linville@tuxdriver.com>
+M: Stephen Hemminger <stephen@networkplumber.org>
 F: drivers/net/af_packet/
 F: doc/guides/nics/features/afpacket.ini
 
-- 
2.53.0

