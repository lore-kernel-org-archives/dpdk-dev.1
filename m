Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28456C88E67
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:52:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8EBBF40E64;
	Mon, 14 Sep 2026 07:51:12 +0200 (CEST)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by mails.dpdk.org (Postfix) with ESMTP id 1341B40E54
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:51:11 +0200 (CEST)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-cc4d03f95dfso1563141a12.2
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789365070;
 x=1789969870; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zegRyiPz/uw+hLZHx1OIBka97fu+iEvl0/H8ESNK2Nw=;
 b=ZZEmdAq3zwkPcAoI4GXU6mgE1ZsYbGP2jJzJH2t5ghbUkoPgekc5Bf5vWXnFymNuf5
 TRY+qYDcSKbrGJeeDv8jqTg81WEKE1521D4t0g05iORq73pT/DBJN/7jYntGn5f6yBU4
 WAu7oYIYiDjNoRk4xy0iYLCxagOCUYt5+h1aYgjNncbNhgidH8DogSEX5rSo1WDWgRtL
 HS64HiFUZZCgezVRsJ4W+gb3SY3/GyP7+jzFAEE5S7imp5H8yDG7NVoriPzxoiROHZgq
 gOm1X87gpzIEABcEKaAwizlye4P6U6xoknxlyhtFAAHd6D91jHrgp8CevpakQn82eu1W
 mQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789365070; x=1789969870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zegRyiPz/uw+hLZHx1OIBka97fu+iEvl0/H8ESNK2Nw=;
 b=JwcKjMkfwsY9Gl33G5fWuFUWElSy6HVgmgs680mWB52qdwGGnTjf/j/zFQGpKGtrjC
 i8uJXYwemEbH1CRBvJe3/KYI9osgYqcNgOlK7wV6ReZTaWGmLTxZIn0ZWma5ZkwPdsEY
 e4mPay+tvGZG4ruPdSfobH6+Uvb0HNdBxU7bGDg0/63Pk+FckTPF2AjYJqQyT0XnfRP4
 cQsg/A9gRYMrYE8PdqooguyuIs8D+GAuxAideaPnKWyysSgpXbooDwR8vKlTbXkR3R5o
 gs1UKPJCTE56KmnIOw1jA8rTdmv7yPvrKwpbV9j8xr+T0vSjjVCTMpbc0WvuVnokzpDP
 FBHg==
X-Gm-Message-State: AFuF++mcq7bCt3J11NSU85jKDlelmdoKW1bQY8s+EQ0Rhv5K8FOLqrT8
 dAgtzAFLe9Cc8SeTjkuL7sWjaHPuplpuO8w7VgCdwqe7Wg1X7nURjyWx3saZsUDOD9cV1jggaS3
 o7FN6Jb8=
X-Gm-Gg: AYBFou3xe3Yi48sczuHlu/+JAiT8ebfjKdOuchftVGSEcR+GCA4BgxhcpX5XvQ+kPKS
 O9u+UGxMK818Bysxz3rfdS+bxAkDkcxxsIXksavobUBaoGEinCMTnXtPUiNPz/LoFA7zR7JTAod
 zv6DOQqHFSWRi7oIWrfpbyaB6dA94tJmI3gsUwFBKkBJAvIyXBpz284J03pH0SlQFjqNtcAbvVr
 Td+R7qHzTtncZbEFiA+ijXW8dt188j5ccg+dLevB6GDevLjqNMcetw0qsWc5DLfEPYO1fECk279
 KkYwH8YLheMSXnWF8x5mnNue+WNv30/Ilpac0SWugIqDJGggMLuCjwRO+j1Uvs91V2KrClNyh7P
 8l1Jd6RF/h3B7XCU32z2SGYK9RJ1v5MSxjiK/Bj2flWQaERVVEhngMUD+X3LfQVokmI2dGMi1UR
 ahIctYcyl4irfS9KlfSXo0okKsC/Hmz4u3Xzd1I6YSjBSZ3dyD8EQ+EzelT4urRYj33QIW/Y+0w
 S91/WjMWRTpQxiSTa4f8Nxl7cxBwhtRzVtDZA==
X-Received: by 2002:a17:90b:2786:b0:39d:f2b0:5049 with SMTP id
 98e67ed59e1d1-39df2b0506dmr22797a91.17.1789365070152; 
 Sun, 13 Sep 2026 22:51:10 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.51.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:51:09 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Vamsi Attunuru <vattunuru@marvell.com>
Subject: [PATCH 32/62] net/octeon_ep: use kvargs numeric helpers
Date: Sun, 13 Sep 2026 22:47:03 -0700
Message-ID: <20260914054912.755403-33-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914054912.755403-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
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

parse_flag() uses atoi(), which cannot report an error, so a malformed
value is silently taken as zero. The result was only ever used as a
boolean, so use rte_kvargs_handle_bool() and drop the local handler.

This also accepts the usual spellings such as "on" and "true" in
addition to 0 and 1.

The boolean uses rte_kvargs_process_opt(), so that a bare key with no
value enables the option.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/octeon_ep/otx_ep_ethdev.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/net/octeon_ep/otx_ep_ethdev.c b/drivers/net/octeon_ep/otx_ep_ethdev.c
index 876d2f9d7d..cec51dc706 100644
--- a/drivers/net/octeon_ep/otx_ep_ethdev.c
+++ b/drivers/net/octeon_ep/otx_ep_ethdev.c
@@ -29,21 +29,11 @@ static const struct rte_eth_desc_lim otx_ep_tx_desc_lim = {
 	.nb_align	= OTX_EP_TXD_ALIGN,
 };
 
-static int
-parse_flag(const char *key, const char *value, void *extra_args)
-{
-	RTE_SET_USED(key);
-
-	*(uint8_t *)extra_args = atoi(value);
-
-	return 0;
-}
-
 static int
 otx_ethdev_parse_devargs(struct rte_devargs *devargs, struct otx_ep_device *otx_epvf)
 {
 	struct rte_kvargs *kvlist;
-	uint8_t ism_enable = 0;
+	bool ism_enable = false;
 
 	if (devargs == NULL)
 		goto null_devargs;
@@ -52,11 +42,11 @@ otx_ethdev_parse_devargs(struct rte_devargs *devargs, struct otx_ep_device *otx_
 	if (kvlist == NULL)
 		goto exit;
 
-	rte_kvargs_process(kvlist, OTX_ISM_ENABLE, &parse_flag, &ism_enable);
+	rte_kvargs_process_opt(kvlist, OTX_ISM_ENABLE, rte_kvargs_handle_bool, &ism_enable);
 	rte_kvargs_free(kvlist);
 
 null_devargs:
-	otx_epvf->ism_ena = !!ism_enable;
+	otx_epvf->ism_ena = ism_enable;
 
 	return 0;
 
-- 
2.53.0

