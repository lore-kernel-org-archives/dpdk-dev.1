Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2C0C55182
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Aug 2026 16:53:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 11D674064E;
	Mon,  3 Aug 2026 18:53:22 +0200 (CEST)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mails.dpdk.org (Postfix) with ESMTP id DDFF24068A
 for <dev@dpdk.org>; Mon,  3 Aug 2026 18:53:14 +0200 (CEST)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-cbe3fed2f58so1925185a12.3
 for <dev@dpdk.org>; Mon, 03 Aug 2026 09:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785775994;
 x=1786380794; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sQZLVj6klTDkcy47sBfEwcTsMKVlzfnccpdQbw/FiTo=;
 b=Ut5nDo0aGs/p9oEf46iliE3k1cQOLlhnRieb4dMksWvq2MCKtQ8MZrNwUCN3UuxKpQ
 BLHMcTZFE9XFLg1+Y9i85r/asbAjDpks/EE5u7BXxFBEXLNbl9FPwV4Qhce/KYcezqJp
 x6dNo5maE35PH17OPHeJFQiwWe85oL28GS5o0LmLTcOW2yiQ7rntPCDvYTmaBW451XEY
 oaHwCTX9pd2HbLE+jfYh6XN7WWeqADP1E1XB4Uo5P4nLPADpnsrfVFbvgKMnIz3ENgqK
 S44yFw2ujAsF7qH0/TYCmsyszDQSoDbyWYUwNxtAI6DzLjZSLVscrW0ZG6VTkczXHOHB
 ZZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785775994; x=1786380794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sQZLVj6klTDkcy47sBfEwcTsMKVlzfnccpdQbw/FiTo=;
 b=nIlSChMsP7YUpHXRzKot3tukgkjtuKBHGf1gIGAxv8apwqFUpbz/+lVw8o0F9//ynW
 pt9qgIe8h5rzIG5KIoTmr4O3PfMKBMMnWUrg2kjFXzeC3jwnijhLfudbgOb7rcCrBVPQ
 31yCmSc96Bv269bSZzTCpD1dm9XR86vdl441/GZNcivAhANaxmKuukD4EM8+0Z6OFUjb
 J6y8h1BRvSpXvMuFJHquLFpYVk4TL5NRKxKAewHlm/PK97k5184GF7rF2lDDO7rYOI/7
 BO4ftWgQN+rHq8HbDa2shw32UxSukAI67hwtmJym0AxrD0NjeNINninBPDtd0QgFqNDB
 RonQ==
X-Gm-Message-State: AOJu0YyboYUWBgUdpJI7G++A81Uq9g3VmntSf7wFIcXvXaIBpTll6dEY
 wlScXlCFimoYM7QiSdcaCPSjW7a0mINcQ/UQd4bRQ4g/Q0iqa4650hYQKl1jrg8LRpF4dgETaWO
 iYdEQ
X-Gm-Gg: AR+sD13L8syEhpOFS1yTbof2hx8F/e11XVa8/bHn1VFzZFZLgf3xwTK6lFljdNfUx5+
 /Uy5HkzrwOOpufWgXl2Q9NfH94RfZswsZWZ2JUe9rtHnVi00jrtzGJqGESMPzS1OLQj9g1tGhDV
 lrBraqGzS/GW4TKrQbIrlfIgrnf0Pyyc3XshX7qCVbPN5VDulE9fhMGg+VENjhOKniZrVEq4knF
 QH2aKqVZQWgz9UAEzndVJQVNmP9r6Sui6RBGEIEPbDYXJAwNNFpvdoLCmJ/Z0eq4vEA3gSTDTH/
 Ws5vWJL6MzaeFOBjRC7Luz5lYH2nNCXh5zvDfK/uLb0nD5AEXecJ0UHHQ0DdO6UYheZolvgc1Df
 BCy/0IWfiSQVAILmY3qMDq6zaB5zhLk7vPJLPjSY6z/+mqRu0LJMi8XorPYU6R2x6sppRnCQDAw
 QVnJX7HhdSJ3uA0EuZ2cyOZ2pax/kD01JQ1kTbu01kOQ4f8HiNXQZTI9iyw9R5LVzD6WqzDrycL
 eskoCJ+IjIJA/KgbqmKGpsNo60=
X-Received: by 2002:a05:6a20:244d:b0:398:837a:7af0 with SMTP id
 adf61e73a8af0-3c92a5e198amr11245844637.30.1785775994111; 
 Mon, 03 Aug 2026 09:53:14 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153dd4e5b0sm37711635eec.1.2026.08.03.09.53.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 09:53:13 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gagandeep Singh <g.singh@nxp.com>, Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH v2 07/22] crypto/dpaa_sec: include UDP header
Date: Mon,  3 Aug 2026 09:51:53 -0700
Message-ID: <20260803165304.289869-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803165304.289869-1-stephen@networkplumber.org>
References: <20260803165304.289869-1-stephen@networkplumber.org>
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

The driver was getting the UDP header definition indirectly via
rte_ethdev.h. That will change, so include the header directly.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/crypto/dpaa_sec/dpaa_sec.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/dpaa_sec/dpaa_sec.h b/drivers/crypto/dpaa_sec/dpaa_sec.h
index d78cad818a..bce60d9cb8 100644
--- a/drivers/crypto/dpaa_sec/dpaa_sec.h
+++ b/drivers/crypto/dpaa_sec/dpaa_sec.h
@@ -7,6 +7,8 @@
 #ifndef _DPAA_SEC_H_
 #define _DPAA_SEC_H_
 
+#include <rte_udp.h>
+
 #define CRYPTODEV_NAME_DPAA_SEC_PMD	crypto_dpaa_sec
 /**< NXP DPAA - SEC PMD device name */
 
-- 
2.53.0

