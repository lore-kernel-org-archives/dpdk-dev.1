Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B8BC55171
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Aug 2026 18:18:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3DD4E40647;
	Sun,  2 Aug 2026 20:18:46 +0200 (CEST)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by mails.dpdk.org (Postfix) with ESMTP id 00238400D6
 for <dev@dpdk.org>; Sun,  2 Aug 2026 20:18:40 +0200 (CEST)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-ca88130e09aso2015706a12.3
 for <dev@dpdk.org>; Sun, 02 Aug 2026 11:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785694720;
 x=1786299520; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JF+dXsq0Alzh8YQzzNK/AxPZMygVzAefveJKHltLoLw=;
 b=FRUOeK6GujO7C02mdzUF6CUz8QhAaEPUDSUxagg+6F3gbH+K4Jb8cGB9MK++E6SYU/
 PEyGg69TfXbSC7f7TvkLOP+PudAeZIqOvnP8bz8J3sZh2SCAsVZhCeovl++O9cEHDfzv
 6dm6AzPSwr1SZyYN9EH/9w+2AQB7EZYzhgxWseZxyzqqWJ/7QkcWrRiqzYobovA34us+
 0Fig6jds1XQ5AcFxFJJYEetFMCa+xjEo/4BYm4aOYhjQqUJhfefx8MqK4u2QAfWMi6tL
 2kPTP/YQw7nGshOBZVowhf8owToG1WNnZqXzy7QIgjGRC/J0+Q3px7dcjoGgrI/k3lQ7
 Gs1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785694720; x=1786299520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JF+dXsq0Alzh8YQzzNK/AxPZMygVzAefveJKHltLoLw=;
 b=o61BDuNLdzFrx/WxILBYxKmPn8O23bm+RUUmBDfPZ5abWhUXGAZ2zEDsTLrURnuOPU
 lbyTZtIbSSGXAi+jB1r3SD0zYyFabK7dC3sE9QCpdk7Fp7Ho0BvirsKBJcWUmaLdmpB5
 qk4W9M8s2op8d13O37xQ+pIERD7FJv1+N2S3daOR21r/Hpeau7Cj0uNNdCACrZzzKS1z
 Dc3EBIEPs+nzpNbFiHrggYxOKccAQABLf9zdqxui+UXcb65afb9NiXgBh70SKws0/9Vx
 gnDnkmT7LA47MgSH5KtMZcSLBnc78aUFzYn6unBmL3DF+wDz5Vp0AJcx9ZOcmAB7FyWe
 +AiQ==
X-Gm-Message-State: AOJu0YxWkTCIb5XqbcojSY5ZFoduCdzTXLRIVbIpi3MdtI1zA06HQrU4
 EbYCHKkfDYy94ax/fWndQRGLCfbH+EXQ3nw1nLcM3fPg3zPc5A7VCZ0P2MbgsLieFw5VQqZlMPf
 QXaUX
X-Gm-Gg: AR+sD11UuFk6vBojv3cNv1ooxCEBD1VWQYooBE9qu+rZ9ep8l4OjlvlsWHyr+uTbWBi
 8wpVAWDImD+eIiargdo3ShpllPWmdl56JtLjBJnNjOED1RIangUWBbZKEKrOOwMkqobZRuOcXUb
 7A8sY/07VuqBWzBQpHiGdUdrYV+7esmPIYd7MK/NzcDTwA2gI33aLkK7iSE++B5DNagfDQWc8iQ
 bP5QYywB20PLiM4oph0r0+PLlf8mr/ZBmXQtPmUQjpfw9087nu/NSN1z9ibN9MLmEMMrbxOFg6k
 HIm24KyiXmQrSc6IXx489/HGEXDsVseL9xvOcaAtLCSzgSYTbekgp1co6zub6yghkQA9j+8l4s6
 9aDTjUs41AJDQuGFRwjezxzbNUjHNwh2i/vpvvelQY+105NYZEviWoNXiqjickvBBsQtDe7rDya
 z/w2+poSGmRdzfEN4IElWWOLgvMAwDQB3gj+eo1aF+5eHwpJsPdqFg9SVEE8qy9otiLPxzkenT5
 5QSzutrBUoCkyrZLR0AAAyfciE=
X-Received: by 2002:a05:6a21:505:b0:3bf:6c08:4ebb with SMTP id
 adf61e73a8af0-3c92a8139f2mr8558602637.48.1785694720086; 
 Sun, 02 Aug 2026 11:18:40 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fab050d8csm39682295c88.0.2026.08.02.11.18.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2026 11:18:39 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [RFC 02/21] ethdev: use byte order instead of ntohl
Date: Sun,  2 Aug 2026 11:15:07 -0700
Message-ID: <20260802181835.476887-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260802181835.476887-1-stephen@networkplumber.org>
References: <20260802181835.476887-1-stephen@networkplumber.org>
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

DPDK has its own byte order macros which are preferred
over the Linux ones in arpa/inet.h

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ethdev/sff_8472.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/ethdev/sff_8472.c b/lib/ethdev/sff_8472.c
index 97f231854c..acbbcee210 100644
--- a/lib/ethdev/sff_8472.c
+++ b/lib/ethdev/sff_8472.c
@@ -4,6 +4,7 @@
  */
 
 #include <stdio.h>
+#include <rte_byteorder.h>
 
 #include "sff_common.h"
 
@@ -176,7 +177,7 @@ static float befloattoh(const uint32_t *source)
 		float dst;
 	} converter;
 
-	converter.src = ntohl(*source);
+	converter.src = rte_be_to_cpu_32(*source);
 	return converter.dst;
 }
 
-- 
2.53.0

