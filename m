Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5DCC55184
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Aug 2026 16:53:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B183440691;
	Mon,  3 Aug 2026 18:53:16 +0200 (CEST)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by mails.dpdk.org (Postfix) with ESMTP id ED2F74060F
 for <dev@dpdk.org>; Mon,  3 Aug 2026 18:53:13 +0200 (CEST)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-ca913a601fbso2467448a12.3
 for <dev@dpdk.org>; Mon, 03 Aug 2026 09:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785775993;
 x=1786380793; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v0q/Z1FZC10y3WqOxqQxntmFA6BV5+O916M9l+d+63Q=;
 b=TVBrF8gcO7yb/x6dXnVkoW4lrVUEh7GMUHNwyJ7jEPjbEOp3eOToPUenIyKgN5CXcl
 qb+IpB3GQW+KAk63uLZZlVgnoPaxhopT7hHovuU5+7jhtemOeuR31HQHHzrV1bjLCbwT
 Wds9Rs2NRPfnnXGsJ/UEYRtYKSMzm0/y53G3+co7rtLjpgCMkVUWk+WytaHj8Vs/covx
 D97LLPV55zoroRY1ORh1WP3utug2fWGT4l1CPSi/U8T1IDbL43V1TkN6HwKevRcedoYP
 gSknZgl4fPsBFfMMVoMX42Zfp3NH8yddvLLipTBfmkIOICMOSvxqHh8i4cXZDUJh2WFH
 Ynbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785775993; x=1786380793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=v0q/Z1FZC10y3WqOxqQxntmFA6BV5+O916M9l+d+63Q=;
 b=Lbb1rSgRJsFHd6DRDhhwPr027uQLCA0VEjBM8u7t9r6zT70ORtcbFqeqxQ0PeRwnQS
 Vr6k3Zh/ynrJrC+9q+pE5+CmkIwpAtpda/ArJpB7gfgdXJnPRn59WCorbsnxlUl7opBG
 43nYrAtfB7egiBExcmhyf2I/c+CgpksI3wj7IwU/0W9Z/hI3AlN04z16+NnbbBgl8XnV
 oAlO9eOSMd5OcPoUJJ5ABoWXxFvoS5nYV2xd9Yls6SMJXdpn08BGfJQZRXb5XKbwzrz+
 Q1cdwZLxocAZlB67Z2HBL3pxZTAu6f4tXUz/ooxtdhMcoBivlh9Nh/oJ2qNlOsi52qz2
 VU2w==
X-Gm-Message-State: AOJu0YxfnHNTsAWY6haTCG7WP1klkR2DsQK0+Oxrj1rOXfFzOQ8roG7P
 OCW601dK5/U7uSg4Kjd2LzeNpFaprbF3VFf9UvrVaZhtHAtVO9newPUTb7OuV5Rp+OqMQAr08Rk
 h5YxT
X-Gm-Gg: AR+sD13oHegarUy/oFXrjXb9IKNa1LdPPbBlbNA3CsaY0GXS/YjbriFu/euoUjkL6KH
 opjeIQ3J3AAqk3dGJVCww/aj4hAcCUwQobTygNTx+rAlM6RHOkOOqGRunKLywGLCfYMDFRNTX+m
 2mx4fFko2h+lxHtukUbck/T5gChgFHIW1BYG8IX3C8OLm1BQMDiNckyunsIvbLquiV/L+LpNsJ0
 pUZIQ1sPQ3o4kxRFHtNqFe1Ch35WoPE6+EJnYzOMRx0ETtpYiaIw/QTmHUlZuOLolDlaOqCCdQX
 2BkC0qOusdi9IEFSRIXcdMsEfNu5IIIHDUN9scvLOAcB2PsEKmG4i6+QPeGzufFkxOuuDS5OwNT
 CDuBUaXvh1a1/JiwQCqeh0ZlhIN3WMBsdf7KXKM6oZmmwZG9Adj22qqHIRPh54uiBxKRZdA+T5i
 jH5LZGWRq0jWQ8egNYmQNXMq5ZfJTI1sCmypbZUAgtmN870MBB+qp9NLTNnGz/6NY2hz9yaQPm0
 n/yiLPEwg8Vx3Pr+A0ylVYH1Z0=
X-Received: by 2002:a05:6a21:648c:b0:3c0:9c19:658d with SMTP id
 adf61e73a8af0-3c92a89b8d5mr11761380637.71.1785775993145; 
 Mon, 03 Aug 2026 09:53:13 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153dd4e5b0sm37711635eec.1.2026.08.03.09.53.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 09:53:12 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jeroen de Borst <jeroendb@google.com>,
 Joshua Washington <joshwash@google.com>
Subject: [PATCH v2 06/22] net/gve: include IP, UDP and TCP headers
Date: Mon,  3 Aug 2026 09:51:52 -0700
Message-ID: <20260803165304.289869-7-stephen@networkplumber.org>
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

This driver was getting rte_ip.h, rte_udp.h and rte_tcp.h
implicitly through rte_ethdev.h -> rte_eth_ctrl.h -> rte_flow.h.
Since rte_eth_ctrl.h is deprecated, better to not depend
on that.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/gve/gve_ethdev.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
index c9a176ff17..8087bf98f9 100644
--- a/drivers/net/gve/gve_ethdev.h
+++ b/drivers/net/gve/gve_ethdev.h
@@ -14,6 +14,9 @@
 #include <rte_bitmap.h>
 #include <rte_memzone.h>
 #include <rte_thread.h>
+#include <rte_udp.h>
+#include <rte_tcp.h>
+#include <rte_sctp.h>
 
 #include "base/gve.h"
 
-- 
2.53.0

