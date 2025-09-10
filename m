Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38E7CA0FED
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Sep 2025 19:05:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B6A44067C;
	Wed, 10 Sep 2025 21:04:54 +0200 (CEST)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42]) by mails.dpdk.org (Postfix) with ESMTP id 132BB4066C
 for <dev@dpdk.org>; Wed, 10 Sep 2025 21:04:50 +0200 (CEST)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-7240eb21ccaso10197706d6.0
 for <dev@dpdk.org>; Wed, 10 Sep 2025 12:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=atomicrules-com.20230601.gappssmtp.com; s=20230601; t=1757531089;
 x=1758135889; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fTEAznG4NXOJLArTQoDpsmL4cChyT1LfBWkRGAxUj/A=;
 b=RxHfkQ3tgwMCA45XMVbaJli3F7q0NYxZN499dSbb8KdQ0R+VJRhODUoJ124Rg2cSk/
 l0mPCQ+4wl8ht5zQdVssk3DX5XiRH7nSfVcYvZlUBM4uOCkJS3YrhlhlOocBUfqfkYri
 YEGru53Ptm9Hbz7LtuwRlJSGmglohcjq3fNanjgHV4J0XW9JK0I3PDHMPQPEGvJdMkO7
 klv11JJmZa0n7ItIXuqB8NrVDJPeChTPuOwFFSjDgf1KJv82Wxcf7isJdL997mDafhFd
 HbGfpASv7Tf4bBbez2rWopAlb5ytvP2meMXcw0/61pjOiBhfQfx6webktq9XheOOrHio
 USTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757531089; x=1758135889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fTEAznG4NXOJLArTQoDpsmL4cChyT1LfBWkRGAxUj/A=;
 b=j05s/4Bf5WrQfl6XHzSk6HJH86Rgyx1wOQh08M/pYSOSYfNlQVJ9/mt9lE+rXc6bpr
 VLI2x1FJSrBYntnDEmohssZeX/jcq6eBsmPS8wum/tSi9QGyWYSkQb6rLYfONBruuDxc
 T90x2E0Qc1mLOdrxIfW+9EuiOJ0W7JtYz5TrfsVZtqmMfw21L60Nv1BtT5DQPyUnZWGf
 H70Dn4N6Cu514amE2Q+H/Z6e4xUmSU5g5vGck8uIkDwN2jp/w0VkFXIesWTZUEuBb5GK
 JtxY5obU+/imiOEiUa7nFnBBESTkUr+91lyLLTK1TBhL6cyaV6aCUp2Stsd03HzIETPG
 CGsw==
X-Gm-Message-State: AOJu0YxK6ayX7O6A7lE9ReMG+QfzFPB9GgfJo4GTK0XALkx1nBlfO2dx
 T0UNQxtCnDdP8vUPXpKidzzdvPPdhjqGBSoqUKLyzKn2GnrDVQH/9MV7G7WUFZWqWxmAQRQUYQF
 Y33E=
X-Gm-Gg: ASbGncsWLnVwKZ1ZDWopbkc9jQViPMvqTDdq+JW8uG5wKFjuAn8zPQO3cr1F6QMJ1Ox
 dWQ4jrExuiRd23dJSVj2dEOsKR/JGzSqd+HjB5G9cM6aUw5cpfSNxGHMPhW3qtBh8pvaH9B9PPD
 nznJLxgG8EmA0sdpuAX/kdolS+hBMMPqDnQFGLaZviJQZJHoHIV14z30ghJwSm5oApcoEyeoyj+
 qhB1AYUoE3/5VPakpH4Cf5ivR+2RZBKZ4wfHxohLu2JJF97hsX94N6bfyoA5P6Mhpzk91GjHBfx
 pJ+n/iofQ2vCfGuRgW56zs8/Tz6HsMA9nPslSNb1W4iRKF2dJsx2wsYJkQOyjxz/BibqSkXe0Ms
 63vOAZ1+6fJzAId02cOPN6hstHgFU+U6m0QwI+9rI43AZq3ATfgRrSTj+MIy8+WnLM6H+WHyODI
 unOo4EyehaJ3gm00whZE0=
X-Google-Smtp-Source: AGHT+IHmqtrs0oUQziDnhQh6xRTHb3A1YpVU/emhuh+DK4L1Lj5u0WRhRrCPSEMKOm9+os1NvDL3eQ==
X-Received: by 2002:a05:6214:4e18:b0:70d:aa5b:a83 with SMTP id
 6a1803df08f44-76225ff9a4fmr8640236d6.33.1757531088794; 
 Wed, 10 Sep 2025 12:04:48 -0700 (PDT)
Received: from z690.czeck.local (pool-108-20-194-239.bstnma.fios.verizon.net.
 [108.20.194.239]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-762c81319e1sm488856d6.61.2025.09.10.12.04.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 12:04:48 -0700 (PDT)
From: Ed Czeck <ed.czeck@atomicrules.com>
To: dev@dpdk.org,
	stephen@networkplumber.org
Cc: Shepard Siegel <shepard.siegel@atomicrules.com>,
 John Miller <john.miller@atomicrules.com>
Subject: [PATCH v2 3/4] net/ark: improve ring handling for segmented packets
Date: Wed, 10 Sep 2025 15:04:35 -0400
Message-Id: <20250910190436.995899-3-ed.czeck@atomicrules.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250910190436.995899-1-ed.czeck@atomicrules.com>
References: <20250903212846.268492-1-ed.czeck@atomicrules.com>
 <20250910190436.995899-1-ed.czeck@atomicrules.com>
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

handle case where complete packet is not yet available

Signed-off-by: Ed Czeck <ed.czeck@atomicrules.com>
---
 drivers/net/ark/ark_ethdev_rx.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ark/ark_ethdev_rx.c b/drivers/net/ark/ark_ethdev_rx.c
index 6077d98ae0..1b5c4b64a4 100644
--- a/drivers/net/ark/ark_ethdev_rx.c
+++ b/drivers/net/ark/ark_ethdev_rx.c
@@ -313,11 +313,15 @@ eth_ark_recv_pkts(void *rx_queue,
 			}
 		}
 
-		if (unlikely(meta->pkt_len > queue->dataroom))
-			cons_index = eth_ark_rx_jumbo
-				(queue, meta, mbuf, cons_index + 1);
-		else
+		if (unlikely(meta->pkt_len > queue->dataroom)) {
+			uint32_t tcons = eth_ark_rx_jumbo(queue, meta, mbuf, cons_index + 1);
+			if ((int32_t)(prod_index - tcons) >= 0)
+				cons_index = tcons; /* nominal condition */
+			else
+				break;
+		} else {
 			cons_index += 1;
+		}
 
 		rx_pkts[nb] = mbuf;
 		nb++;
-- 
2.34.1

