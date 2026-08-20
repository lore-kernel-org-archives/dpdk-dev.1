Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9256EC5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:24:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 22042402D1;
	Thu, 20 Aug 2026 07:23:51 +0200 (CEST)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by mails.dpdk.org (Postfix) with ESMTP id D52C040678
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:23:49 +0200 (CEST)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-c9b373d5af0so1163060a12.2
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203429;
 x=1787808229; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0L0MVUbnBnuT7NFe+zg+190J6RTfm4NeMhb5b7otfrs=;
 b=G32vhQM1gnUcoGnsUW1OC8t4ljpqBDEvZzcJ6zNuQv0bGQUkvSAaA6y46cdyUcD2VY
 6/PEz58B4Qhodt0aX1F7MaKWSynSoJG11NcuGReiA96yod5sUduYqNjn0xf9kL/2Qs9g
 JIyMoK2d/f2hPj9USWv9ulW3WRbaKhLIA/hMXmtlSlQQkc3B2Bd2STnGjaFAJto9GqzZ
 kUW6D7laprahNOG9NTAWFq1J8ZCwfooNXpZ7sAO2bLGheuv6VLekoYr64BWd1RM+p0aF
 6sAefhk04or+FslbYXEw8o0X1FcUI4ZZVzY5krccWyOUDeZMAqRThEgENdE6dEbHsDZM
 CuSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203429; x=1787808229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0L0MVUbnBnuT7NFe+zg+190J6RTfm4NeMhb5b7otfrs=;
 b=lutoJ2psS/sB6J5lwm0Ii1mI3burXCVq8L9vRx+drWRAqEV6itBKCMP9zXYgZjky+n
 RWWfTxxAjoDjwPRXfjCJxnYLtiQbEvbWsOOeQLlixyovAC6jRjiieGn7Hp6wGlZqcgpK
 TuqH0k3SEdxhS6pvpKQ92xnd0MFfeVcXISCeJM/gp79bN2OjWOx6u66/L0mmWFFyQpCY
 KFxauZYRNsjhD3WQNqzRyWXmtiGuWyVU0ijcVtRj7+c/HlN1KhqHSMcfdRURECYTBLUR
 59UIKVpBAErWrES3u7T5PnO0dJePu9ErzCkNVhQe/nyRpXBvSBVOGClhniQN5CjjnfDG
 68XQ==
X-Gm-Message-State: AOJu0YywIowSpabhYhibIDfx4n4PgAYTp8UwIrwwJZUQF8gjMGgVZOcs
 +8GCbNv61lJnYeIeOhig4y9Fmx8ozZ6B3xOs4zdw2bm2N2wm/pWoEDyCYaroIXjtXtv4S0j3kwX
 AeiCr
X-Gm-Gg: AR+sD11dESHhtAlc3VtcNDIonhEOBJzEk9tB63Vwr1pc7mhZ7uUTEeeEbWbf9aeisqU
 VOGEkyNmqNwncaQ9QyL0oZJVGEwybJD3oyn5SCbGWvZkYfrISuLDEA2nnZ6XGBA3DsGcHPUlqn/
 +WJRMti8URkPcvjclrHzTQq/iXfZlAhVdGh1zmI4VbuU/RKAJSy9kYYz5YDTJFr7hXwVnajfYO4
 4ETrRVM2IMZqlrGvbMY4bNzwlBvY4fNpeUk0jH+AXo2znWR+NI/Nv/ql5T9XEV3YDcnk4zW2gA/
 735cCQeF1nwfhUg2/rwBrByqnagN2+ARBUG/kKW30e0bCX2a17bzDSxx+Gn1BGFOT9t/TT8zz0b
 q1BcJChvBR4k0a75Vz+3ywC2xuyus4turT8HWNRctXjOof+nIYqfcsqb905tbyVxWM4eJ0l+CKe
 AqaQnUdJd0TLV71LxijQsDbanNczk2AIPjCUBvsm6+HdjajYFpANYNuyxTFUd27n8x2v2e++pON
 u1o/oPa97UFnXd/BfYxGvaWAe15zdeWGoNoXg==
X-Received: by 2002:a05:6a21:4c85:b0:3c4:3321:4fe8 with SMTP id
 adf61e73a8af0-3cd0122f40amr21597702637.14.1787203428923; 
 Wed, 19 Aug 2026 22:23:48 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:23:48 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Abhinandan Gujjar <abhinandan.gujjar@intel.com>,
 Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH 12/61] eventdev: replace fixed size rte_memcpy
Date: Wed, 19 Aug 2026 22:12:02 -0700
Message-ID: <20260820052251.1453273-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820052251.1453273-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
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

Using regular memcpy gets more checking from compiler.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eventdev/rte_event_crypto_adapter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/eventdev/rte_event_crypto_adapter.c b/lib/eventdev/rte_event_crypto_adapter.c
index 3f9cc7379a..b6707b50df 100644
--- a/lib/eventdev/rte_event_crypto_adapter.c
+++ b/lib/eventdev/rte_event_crypto_adapter.c
@@ -700,7 +700,7 @@ eca_ops_enqueue_burst(struct event_crypto_adapter *adapter,
 			continue;
 		}
 
-		rte_memcpy(ev, &m_data->response_info, sizeof(*ev));
+		memcpy(ev, &m_data->response_info, sizeof(*ev));
 		ev->event_ptr = ops[i];
 
 		/** Restore "struct rte_event::impl_opaque" from mbuf
-- 
2.53.0

