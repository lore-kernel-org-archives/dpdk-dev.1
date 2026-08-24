Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4E2C5DF9C
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 19:23:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90E424027C;
	Mon, 24 Aug 2026 21:23:35 +0200 (CEST)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 by mails.dpdk.org (Postfix) with ESMTP id 9A5F540270
 for <dev@dpdk.org>; Mon, 24 Aug 2026 21:23:33 +0200 (CEST)
Received: by mail-qt1-f177.google.com with SMTP id
 d75a77b69052e-51c05dcdf49so37734851cf.0
 for <dev@dpdk.org>; Mon, 24 Aug 2026 12:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787599413; x=1788204213; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wLZ7GxGs6UOJLyrrVjcTGPeT+QoR5z6HHo+J+jWJhKM=;
 b=DkitY6VZ5nXO/TqSKmmoMPfeJatAlYH/qUsPMcuV6Z/2fpb1kf+UZxsI5o1JPuDZow
 yumoOOh3Df8dcmRuwsYwalYfmFbfBiK7AM4saCx3K0X0Or9P3zgmFN0Qb5L5U+BQdfrb
 S/xhtGFSlgdz/+K2slSmkyqX0wo6aFA784ii4PJ+oW/ENZ+2a9TLdRXpvoEXXKNi6tmB
 y0bIbzoP6UAinzU6ax1+FKYNzF9AMw/GBWJkdpBErB+Cc5BQTUA2EIRuYyvyfnrejtVU
 FnQqIutR7g0f7rvNnFHCtO2QQzqk7hpVEi6lO6dkcT79cr8iZr363d/DO8tEkmniFMOG
 WaAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787599413; x=1788204213;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wLZ7GxGs6UOJLyrrVjcTGPeT+QoR5z6HHo+J+jWJhKM=;
 b=nSKPvYeX8otdgiQ1S33ZKaeY95vd+k0gpskf2Zwu6FIzJBhH2DZ6pIdL4xOQju1KeQ
 xlGa7ES1sjTcJRHwrC2I6VPNa9wZhwwTRuzlfUvfPsWBEyedei71k9fNTAH4D+e3Jk8c
 ymGni6cms0uBikHlBUqTEtIiLQeRh4ue9i/dbinTtordq4QOVD7rKFUKh6lAWML/E68/
 p2X0nMscNw9laNCjlgmY7h/s5iUSdzsq5l86Nm/GOGjJdZFFpxNkzofBrnGbD4ygTwMX
 OCAyc0kefYL9hQ45UfRBjSb07oFQXC0/DlA4kgjIyz5EsFqmDtXOL2qBcK6hr0jIFBfs
 ArFQ==
X-Gm-Message-State: AFuF++kbamQurQxS0rgLalHfSX6qaTOP/PpIXZ+pQIFXdhiPzMgdVIso
 OfCMXwnMDYiHLApD3JpsFf3sq9uXoCZB8vioFwJFo1yP7U6jGBhbLueC
X-Gm-Gg: AR+sD12/moVZ4T0JDWE5+nPBMMLIFdbk9zmxgrLRqD214jI804ZhE3bvujUjtv1/Q6Z
 kfiR9HpTmpwVaVWi2f/kHIn0Vh9XuftNeoNrpBGmjkgSf9Eo3SW0tUJQkxoAX6DWecSslKohOrL
 l2ek6jZkoU1OS2MyywNAOyQMs0w2XRfCKlKaVxML6m9E+VgjIohjXnVCsYEkjUFCIgBK2gIu2Sb
 rwqCIKtMqztBCwgg9lADZ8ngcA2AShZ4/ij4DH80aJRtNassIPp8JlDD0s7s1nc+KYuLwCJV0PC
 FnRhxZQ604Z1pekZLSPCWxlBwt8wujAcV/X+gnzcbZ7NG09oB+e3fbwjOg74qc5/wcQyIiFuB1i
 bDyw//qnIzJIztYy/0/lruqRiDA9deLjTULJdulnu0qBe7s+vJnjZef/a5Nu80I3J0wq4agMha6
 y3bkd8ZG2jILB8cQbGZquTAfXCEoOlIBSWAAr0UXMX1A5NOP4C+cDNRynIhRzkkg==
X-Received: by 2002:ac8:5a53:0:b0:517:9f43:4732 with SMTP id
 d75a77b69052e-52e09bcdb5dmr210772041cf.11.1787599412577; 
 Mon, 24 Aug 2026 12:23:32 -0700 (PDT)
Received: from wpc.example.org ([67.221.51.185])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52e09974dc5sm53906081cf.1.2026.08.24.12.23.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 12:23:32 -0700 (PDT)
From: William Bland <blandwwa@gmail.com>
To: Changchun Ouyang <changchun.ouyang@intel.com>,
 Huawei Xie <huawei.xhw@alibaba-inc.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org,
	William Bland <blandwwa@gmail.com>
Subject: [PATCH 1/3] net: fix VLAN insert doc comment for shared-mbuf error
 code
Date: Mon, 24 Aug 2026 15:22:25 -0400
Message-ID: <20260824192228.1197189-1-blandwwa@gmail.com>
X-Mailer: git-send-email 2.55.0
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

The implementation returns -EINVAL when the mbuf is shared or
indirect, but the doc comment inaccurately stated -EPERM.

Fixes: c974021a5949 ("ether: add soft vlan encap/decap")

Signed-off-by: William Bland <blandwwa@gmail.com>
---
 lib/net/rte_ether.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/net/rte_ether.h b/lib/net/rte_ether.h
index c9a0b536c3..cb10d8fb06 100644
--- a/lib/net/rte_ether.h
+++ b/lib/net/rte_ether.h
@@ -387,7 +387,8 @@ static inline int rte_vlan_strip(struct rte_mbuf *m)
  *   The packet mbuf.
  * @return
  *   - 0: On success
- *   -EPERM: mbuf is shared overwriting would be unsafe
+ *   -EINVAL: overwriting would be unsafe because mbuf is shared or
+ *            indirect, or mbuf's first segment is too short
  *   -ENOSPC: not enough headroom in mbuf
  */
 static inline int rte_vlan_insert(struct rte_mbuf **m)
-- 
2.43.0

