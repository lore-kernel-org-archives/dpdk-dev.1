Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C00C55184
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Aug 2026 16:54:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C648140B98;
	Mon,  3 Aug 2026 18:53:28 +0200 (CEST)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id 2AF774069D
 for <dev@dpdk.org>; Mon,  3 Aug 2026 18:53:22 +0200 (CEST)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2cc97653887so39231675ad.1
 for <dev@dpdk.org>; Mon, 03 Aug 2026 09:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785776001;
 x=1786380801; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zMGoJIL6DjfIKZbaYgDA8sb7d+0U4OIeCd7ErA5WVLQ=;
 b=jBz/5tnw7YiUQWEl9k7/8itLJhlXR699VZtSlG8iC5qSTVVGhEV6NGBXG9OK/QDTO7
 RxzeH+GjpO2B0/NSTnl2TYrciaRKrcShtuNKrorC5tbM1yECGSIDOqO1uz2snzWT3tkz
 4lyWuMxllJByQVmpAhlWEiikfMy5h18HoPUZcsik1Ey+BfuU3imD7APbyNjORoKm/Gnh
 7VF3NAY59IZakilur3+B0F9R8+73XTnNOhhr//Y5TFEVFSepSNpvJr7jqND4tJzwXQ+P
 6doNLYjPnOV7ITeJ6pvYJkc51GmlMowQOCx9YI9wBdldV6SKmf9h+Q9NTkzL2WJtmBwz
 r+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785776001; x=1786380801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zMGoJIL6DjfIKZbaYgDA8sb7d+0U4OIeCd7ErA5WVLQ=;
 b=EM5duEsnz6ZK0bQ8BYYlMy08r/B8vPGmQIq50d1WcEhJB8W7TAzjExa4eYMnx6VxlJ
 UIHJ0JkVV6SHOCh/cg6P9jrIZyQ8VAW7ciCXFRMyUYhiRRar2y+bPDU5HrJY48tOwsZs
 I6QcYtTdzA52cgNG882S7gUHWjY41AQk1oTa24wvo4zu4t1E85Kcri/kfdnhKI9pFv5Y
 m7JEKrfY3yVYGtiykdJqcuLy/PpgcQ0IAMj8RFn/dL8U5t4ODHAzqQkve1BQozstsYQY
 tfyhy+53sX/Oi4a3beSCjcBFVPI/eEyaQXBAJOAqRaJqmpQ66fpZyyw+4yyNfLFJ8RXr
 5T5g==
X-Gm-Message-State: AOJu0YzN9lOWf7ZIDG+a2rQnGCh/YKep864SDQkKwR5P7Ydw7j1WZ2eX
 xhGlgwvLwLe+mbee0Ol+3OrWGf5ETSAcobL2P+KLgPeKUQCm0Vf/rsE0g4pwGdRMCvSxk5CE7C5
 nzBT9
X-Gm-Gg: AR+sD109dztkr0ozL7a2px30qx8Usqty7UW2i50zaVaqGkHSD6vNMmU6HLfddEXgXZp
 /2AnQde3IfdA7hj92UET273VJDcxV+WEwtlhStDT8HeMjIh1cndGzoWNwNz6AUtX4tk9jB6xVJD
 C5i+thnzu2DLof5O7Lyck7Galq1B9yxTCtz2TYjTQohEKLheCXfM2UoDo8LAZ7Lj4b8RmWKF2Ng
 frIOCaCSuiBMoVrmdLK6C4oS/vqa3gND3SMXmB/49kddO5Xw/aKL7Ln2FC6zi/swEpI2QM4mHbi
 l2YUpxkj7wJ7z+FLS8xqoGad2xjSWxKYjopkbCK1yi8xcPp+u1dgJ3ufOgjVqG1zbOB/w6xkfHq
 B1H9A3/QMNOMk2d3AZGYZsWdXUdM0/okvBPftugu8olL78Q4uz+qcQDyBrYLZIzZPlOKt47+ljM
 Ra7o8bZV6WGgw2MhFRMU3bsLych1xKhfjBAr0S2gWTYN1HhGvu0imxFpmtgX/zsuJ89CBzQN305
 nD1rTBgH6inp8KSA6ATf44q/yU=
X-Received: by 2002:a05:6a21:1f88:b0:3b2:a809:1000 with SMTP id
 adf61e73a8af0-3c92a518a8cmr10529310637.3.1785776001285; 
 Mon, 03 Aug 2026 09:53:21 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153dd4e5b0sm37711635eec.1.2026.08.03.09.53.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 09:53:20 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Howard Wang <howard_wang@realsil.com.cn>, Chunhao Lin <hau@realtek.com>,
 Xing Wang <xing_wang@realsil.com.cn>, Javen Xu <javen_xu@realsil.com.cn>
Subject: [PATCH v2 14/22] net/r8169: get network headers
Date: Mon,  3 Aug 2026 09:52:00 -0700
Message-ID: <20260803165304.289869-15-stephen@networkplumber.org>
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

This driver was getting network protocol headers indirectly
via rte_ethdev.h.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/r8169/r8169_rxtx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/r8169/r8169_rxtx.c b/drivers/net/r8169/r8169_rxtx.c
index 00de0471f4..b84d451bb3 100644
--- a/drivers/net/r8169/r8169_rxtx.c
+++ b/drivers/net/r8169/r8169_rxtx.c
@@ -20,6 +20,9 @@
 #include <rte_memory.h>
 #include <rte_malloc.h>
 #include <dev_driver.h>
+#include <rte_ip.h>
+#include <rte_udp.h>
+#include <rte_tcp.h>
 
 #include "r8169_ethdev.h"
 #include "r8169_hw.h"
-- 
2.53.0

