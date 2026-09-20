Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D8FC982D8
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Sep 2026 18:14:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02AF740DDC;
	Sun, 20 Sep 2026 20:14:03 +0200 (CEST)
Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com
 [74.125.227.170])
 by mails.dpdk.org (Postfix) with ESMTP id CDF57406BB
 for <dev@dpdk.org>; Sun, 20 Sep 2026 20:13:56 +0200 (CEST)
Received: by mail-pj2-f42.google.com with SMTP id
 98e67ed59e1d1-39b350c69b4so2002312a91.2
 for <dev@dpdk.org>; Sun, 20 Sep 2026 11:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789928036;
 x=1790532836; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=im8w1tn13rZ2q0BpAWPdJAHUorjyP0XT+4c/DD2nioM=;
 b=rE8cetIi6Z4a7GE/z+brUV4ij3FaVcsyWY8M4jVN295P7e5SxnqM2yNHEdRFry74GR
 tX+/ZfIaWs8DbpMp+wTdtg7vtidIg/633YAlNt9x2kr4nO+ykUPTBaGF+rI4zSF1wRwf
 4/TAaFRpU5Q3fojEmtlWnm0ktK+aCjoK7nILj9q5vSIbcv65Q8vlOh3VHW6OTKURZYmR
 KOHMarBrQ3p8IBE2dkDuBJMavoNgjYdip6SsVsJOsKOt/ZBddn6B+egX6bRyqoolGypW
 KXt4t6UYygt9d4jl7JggYTT8Ww6BCVEphIP0gYwrh0yzNdKmJZYqNWFIERQBgkrxGotd
 G9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789928036; x=1790532836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=im8w1tn13rZ2q0BpAWPdJAHUorjyP0XT+4c/DD2nioM=;
 b=ek5zofz5bvEmpzlO25aYlR8KAJ2UQjbXhLjNa+vDmmlIKmYBQEbBAdKtKb0PysnZik
 drys3CZQoh7ytC1RytdbsyMFw5Fvhjm5oNEFzUOJJhKrIjiCY924WcJmrhtnyvZFjS2P
 IxAmHLAP0D+LRId+n1pf80S5pmDlJLGZzgGjAP/fUhlg1m8Glm2u2NHqVlzuiIYubg+G
 xIhk0zWBD5B/u5Z9RKv4QHURY2+EvZB/jjbXnV8+KrqJ5jkK/z0lS1WapPexbk/tCGo8
 mIA96KCj7+BMlJ99oiO0a8YeqwLm7UCCnNkc5fhN2+HvncJbIU90sJf3Bc0Nz++16Kw0
 MjaQ==
X-Gm-Message-State: AFuF++kKCGJaMZ5wsRlVI71tEnXsKYPbdyzExUp7xxlTm20NSY98ywlm
 A6ARd6EMWBBvJpGNhfSVGhmgm7DADCBUtLtwMC6mU4SNraCwCR5/c/UCOxybmPB31hRRdhM2UcK
 qZmTb
X-Gm-Gg: AYBFou30N/SRRJG1fZmT1Ajx2q2RVKKe6vS5KNMvLNhm7j7gRaCmZO67xoZh8IP9E+7
 gi7qvB1F9Xc4lbNGRv6sceDWa/gysX0CzMEAYWIz7cEfWTeeqzwHhKy5EAnHpVq6oAP2x8ucCku
 jlkE3Rg6cCkmXbl6QFuf8pCFEv3Z7cYtiW2lY3rFOzIpKASLxu0k6taYDFZ+FBcdsBZjH6oqgwK
 OHIxM5IcQrtE1mP33UmWkuDJ3Ugkua7ORkvTT/M4YJijRuqtTDOpPgcpFwfwiX+3gFeJzjOlUHQ
 y6yEWzCvz9tc3zgLTZ+9BS6gYGnipOFzjxNIUqzOGqjgcnAcHoJBTmhHDew+msK6S0cOiLClYso
 CWTL+fsjCAH9Gps9j8UlRArDQlrAt1tq/qWKkfdZaizIHJ6me7mmeoGLAPB9cK1yEFrjlcfH9Bw
 KxYfbCK3l5vyHsfscCuwOppCO21ZAEgngOGt/Xd+WxNJs8UTeDDi53Y786jwhJyJNBK9fn2/Swd
 zbpAJGeo6gdqaH17BSU0ieINp7wpUzjGL8DQg==
X-Received: by 2002:a17:90b:554b:b0:39e:6c6a:6574 with SMTP id
 98e67ed59e1d1-39e6c6a6819mr7722283a91.55.1789928035892; 
 Sun, 20 Sep 2026 11:13:55 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e6c37a88csm10088091a91.8.2026.09.20.11.13.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 11:13:55 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>
Subject: [PATCH v2 04/33] bus/vmbus: fix missing acquire on receive ring index
Date: Sun, 20 Sep 2026 11:09:56 -0700
Message-ID: <20260920181347.747210-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920181347.747210-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260920181347.747210-1-stephen@networkplumber.org>
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

The receive path checks available data by reading the write index and
then copies ring data. The link between the two is only the comparison,
a control dependency, which does not order load against load on a
weakly ordered architecture: packet data can be read before the host
has finished writing it. Load the write index with acquire, pairing
with the host's release store. This is the equivalent of virt_rmb()
in the Linux hv_pkt_iter code. No change in generated code on x86.

Fixes: 831dba47bd36 ("bus/vmbus: add Hyper-V virtual bus support")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Reviewed-by: Long Li <longli@microsoft.com>
---
 drivers/bus/vmbus/private.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/vmbus/private.h b/drivers/bus/vmbus/private.h
index 6efac86b77..aca5b534f9 100644
--- a/drivers/bus/vmbus/private.h
+++ b/drivers/bus/vmbus/private.h
@@ -12,6 +12,7 @@
 #include <bus_driver.h>
 #include <bus_vmbus_driver.h>
 #include <rte_log.h>
+#include <rte_stdatomic.h>
 #include <rte_eal_paging.h>
 #include <rte_vmbus_reg.h>
 
@@ -130,7 +131,16 @@ vmbus_br_availwrite(const struct vmbus_br *br, uint32_t windex)
 static inline uint32_t
 vmbus_br_availread(const struct vmbus_br *br)
 {
-	return br->dsize - vmbus_br_availwrite(br, br->vbr->windex);
+	uint32_t windex;
+
+	/* Pairs with the host's release store of the write index;
+	 * ring data must not be read before the index.
+	 */
+	windex = rte_atomic_load_explicit(
+		(volatile uint32_t __rte_atomic *)&br->vbr->windex,
+		rte_memory_order_acquire);
+
+	return br->dsize - vmbus_br_availwrite(br, windex);
 }
 
 int vmbus_txbr_write(struct vmbus_br *tbr, const struct iovec iov[], int iovlen,
-- 
2.53.0

