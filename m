Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F80ECCF9F8
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 16:52:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9070D40E37;
	Mon,  3 Nov 2025 17:50:04 +0100 (CET)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id 69C7C40E0F
 for <dev@dpdk.org>; Mon,  3 Nov 2025 17:49:59 +0100 (CET)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-295247a814bso44951015ad.0
 for <dev@dpdk.org>; Mon, 03 Nov 2025 08:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762188598;
 x=1762793398; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uYsA0q0g9XWXAK6VqYhLzZR57tNAA4JqYzVfoUtxAFk=;
 b=Px8PKv5hoyeKNx6NeMVhJqVtAn14OHjhzXiDE87IKdJuNQgpOHN030etq37uoqa4tZ
 CUcKAx37vJwXWhJb4g0iTTqkcP6+UCntxc+un3snWz0MMT+J6vawkFYvEqq+gWLc4Cp4
 7wzCaHC5WN4KPJj4e/E6i7od3FpCkNibWSfNwoecHcSgTzth/oe9nnKm5yLdXiA3oX+s
 z/mAQnZmmsDeN2bruAX2IkBmmuGOdvgNLrV75pTai6z8jVNtGvwqLqezEa9nrP0BBtfF
 hXE0BDIKNv4XUPrGJbB7K6O6e1QXGqcJaKWq99PHjdH8upeX+QuhuemYWXRWEC/fFvFU
 SwEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762188598; x=1762793398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uYsA0q0g9XWXAK6VqYhLzZR57tNAA4JqYzVfoUtxAFk=;
 b=d1nOiUlJE5DuhFZV7wxXSsPccrmN5fCVP1pP8lphCIAKf3xA+IyMHm2hCX0vevqgU8
 zfeUXmYWmc1nKZHxO9Z6WnCcXGdiTNxqJ1zyxjDp/mL03auQWuaL6QGLPWJrYnkmsWdw
 tuY700XqdVSKuaL5xlSL6/2rbW+McCFG1ipwjVLw1ss1TIvTQP5QZYBnxWvS8QP07iAj
 nSK9Y8ER5qzgwmS2QvCb3jrHJoN0EUdCSS7v4RuQCx2GyY5UFwpU+KU9zVk6LL0Wib1L
 BG+qv+7TcLqxvGACjxOBuD40pMl2k/9B8dTKXgJK9Ov2sJa2nDDBveMbiffyT5pqjZL7
 clPw==
X-Gm-Message-State: AOJu0Yz2Hgp+6y60I0Iq7pgqNus/QkICIufLIMbH+tTZ3ClDlyjpp9BN
 Gbx7YSOUlh9I3jdO9n9d3J7QdDu/hQ+GSewxK5Z5uQYWnwM1HcCnb0PrTuvt+52AqmvgUK0Anc3
 cxBzr
X-Gm-Gg: ASbGnctGZNOkHUDkKjhLHubhc+7BI2kSwFkufbre23vGz1ldBNG88QIcLF6tL9EdPVP
 wQAov46c5/3dAtkC5JZIAz8o6YmjWEz/Bhn9Xyiu8r82wn6zLbaezvf2i4IQo6livXMPfPQAW9O
 yivktKMaCGTBV9a9m0eqiy1qeJ+CgwzG3z5AseUDFljEWcXi/VEga22U447Sc/++5fsXqT6eZOK
 okBFdTDzRPAep5RzAuZCY/iXuxxC5NF4AkGp7HvI6WN0hKGkIV51uk9qiUrV20dUqObz0VmD+bY
 EcT+2Z1/IfdISG1WfP9Bqcc+7y0ZsFLUQ0cx+yrzUfMcRdlgr+YtfYpw84Q7O3m/+HL/hbmB+sL
 LfA+ui90w343b661O1OVU/+LgUO+qj34Xs96XMH6V4hQ6UvGnKtVXLSQfyVcacT6+G6sCxpvkfH
 fWhwsI2IItkE7tFCmXT9napcWxlnfyVlnt74UmpRpLuDnELup6+Q==
X-Google-Smtp-Source: AGHT+IE6lYtCO70CmtY8ViY3LAwbS9BjKDXg/LSNeeTIclJeJDsuXVn6STBFL9pQdi+S5tfD+Q2NgA==
X-Received: by 2002:a17:903:18b:b0:295:68df:da34 with SMTP id
 d9443c01a7336-29568dfdaf4mr83341025ad.53.1762188598452; 
 Mon, 03 Nov 2025 08:49:58 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3407f26e0a6sm6779040a91.5.2025.11.03.08.49.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 08:49:57 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH v3 30/44] net/softnic: replace use of sys/queue.h
Date: Mon,  3 Nov 2025 08:47:35 -0800
Message-ID: <20251103164915.101713-31-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103164915.101713-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20251103164915.101713-1-stephen@networkplumber.org>
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

Replace use of system sys/queue.h with DPDK rte_bsd_queue.h

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/softnic/rte_eth_softnic_internals.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/softnic/rte_eth_softnic_internals.h b/drivers/net/softnic/rte_eth_softnic_internals.h
index d3975dad10..5b4361bad0 100644
--- a/drivers/net/softnic/rte_eth_softnic_internals.h
+++ b/drivers/net/softnic/rte_eth_softnic_internals.h
@@ -7,7 +7,6 @@
 
 #include <stddef.h>
 #include <stdint.h>
-#include <sys/queue.h>
 
 #include <rte_mempool.h>
 #include <rte_mbuf.h>
-- 
2.51.0

