Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E554C83F17
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Jul 2025 16:43:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B74640B92;
	Thu, 10 Jul 2025 18:42:52 +0200 (CEST)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by mails.dpdk.org (Postfix) with ESMTP id 1848440687
 for <dev@dpdk.org>; Thu, 10 Jul 2025 18:42:50 +0200 (CEST)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-7da3894b82dso120111685a.0
 for <dev@dpdk.org>; Thu, 10 Jul 2025 09:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752165769;
 x=1752770569; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nd5IbD1gfu3uxsi19HXLY82ZUVsISET2Jssfh5uVVjo=;
 b=jTmXi9hTbKdJwwDswRdw3erMn6DKs6WazuG9az/AOnzErAva/mfCyeWVeZ+0RemkYz
 eYj2f9PgiQjwffq8WQBK6XRnZ+8TkJxz+w0mTOuUJwbogFItS/nxOUNg32OCHvf7SMZr
 5MF7z+bDTMmbvtMyVKE6G48X2viRGK4dFkUUh3K7GCOOc6dXnF9S7cIl9uTmxXjN74uK
 92Qw8HCz3tPCHv3e8KApGrcWNB8DjZ6m3EcC5fUHdd9zdPi4HntMnFz8RbmVqCh/pfxz
 ax7byY8RimjDX6kvkw9kzuB9NA68cXbz6YuhimrSovJc7peObypJXg++wo82mCfvBkqQ
 x4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752165769; x=1752770569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nd5IbD1gfu3uxsi19HXLY82ZUVsISET2Jssfh5uVVjo=;
 b=tDGjMgCJT/wSP5z72E2kwxzsJ1R/rjELOHCfOMX24lJYNjZ6wag24n3nNhaijCBIo/
 6D+GbqLRMKpD5vFyiDFaQxj6hZdjLjQSktUoV3uNx6rwhfssGl/KGnAnLc+UBnC2pM97
 AifvqriDDtUys+XLkp3CiKwrTIvdaa5CBr6UQDQ5eU3LlQMJd4dYwq106lp8i4wVQ4qE
 PofukXn03uwh/ycJO2i4tV6THChM7CV8u15miRL1tXtYjyL+9kfUVw5isuL2f2Rc4fFF
 oGkAD0Zf39+CLX+iWLY1Yf5HrJQtL/Se17NQkSl8MECoLuudfs7D8BDommLFqhhbn9t7
 GJ6A==
X-Gm-Message-State: AOJu0Yxs6pdjFlF6wzJeCUr3XEuN1CLOxTByKsPl6NGU1nOcX9QeuQsp
 vw+YVkhu/Ng+dZG0K19xDN/Pjo+iOGHlsf3bwE31v8hX4XXA8H00INwvX4ueCBZ6LH9NfmjhnmF
 p07N9
X-Gm-Gg: ASbGncsxBcNUQg8Q31iO9w/LDnrFS9ddtretwTlq1rrJuNOwWAqjZ57FLkVPsR7GUsQ
 BkW1y4/h5xgeVPQ4kSJQb1UvKiwSUTVwMLQ7l5SG81wjKIzxV00BCwTT6GAzwFkJbUdcHPHkPFh
 JahUi9rZPHsHI3ExQA3YNxAxclIcdlzsYr5Ocw5J+w4DndFhzUEJhkaQVeiqbGzY/0FtyWbO9wE
 aoYHrEzYG86mPYEq9zCmX+UCLlgtMMWuyStWT3m0+trZG7Q+cCHra9KHVXaPudLlpSkHRq6vSjo
 QO+AUnPbzErAKkQQcSmO1g0LHTENYIvLusS9Cd5VCeGfcOjLsPBqc0OFy9HMBHbiTy+rLrK9ykn
 C9q0Rjmvn5ZuDTQYUi3PHP8KeHX+hWB6Sf2VtZAn9JBVi+d0=
X-Google-Smtp-Source: AGHT+IHj+zJQWNDcM+gSkotuSnmXDVgwpU2OpmmaGKrPTXGyBa4pN4nZQDYgEYF718k3Buh3MM2WKw==
X-Received: by 2002:a05:620a:1aa0:b0:7d3:913e:802e with SMTP id
 af79cd13be357-7ddecc1d40dmr26394385a.41.1752165769263; 
 Thu, 10 Jul 2025 09:42:49 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-704979b49b3sm10167966d6.30.2025.07.10.09.42.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 09:42:48 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>, Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v3 06/13] ethdev: make sure all necessary headers included
Date: Thu, 10 Jul 2025 09:16:47 -0700
Message-ID: <20250710164237.8630-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250710164237.8630-1-stephen@networkplumber.org>
References: <0250411234927.114568-1-stephen@networkplumber.org>
 <20250710164237.8630-1-stephen@networkplumber.org>
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

Best not to depend on other EAL headers to include stuff.
Some of the later changes had build failures on some platforms.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ethdev/ethdev_private.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/ethdev/ethdev_private.c b/lib/ethdev/ethdev_private.c
index 184cf33f99..fffffe2625 100644
--- a/lib/ethdev/ethdev_private.c
+++ b/lib/ethdev/ethdev_private.c
@@ -3,9 +3,18 @@
  */
 
 #include <assert.h>
+#include <errno.h>
+#include <inttypes.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <time.h>
 
 #include <eal_export.h>
 #include <rte_debug.h>
+#include <rte_eal.h>
+#include <rte_lcore.h>
+#include <rte_stdatomic.h>
 
 #include "rte_ethdev.h"
 #include "rte_ethdev_trace_fp.h"
-- 
2.47.2

