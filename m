Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879B6CA5FC4
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:47:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 00F7742F33;
	Thu,  1 Oct 2026 00:44:22 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 2AEDF42F1F
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:44:20 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396ccdaea75so2119580a91.1
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808259;
 x=1791413059; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cKZnu1rTr7c/Ijov9F9quRvUzuktu9AMTFQRsUw4NS4=;
 b=0UB3jYcUiOBxU3BZBe6DLJw3Ni+wPta5TNwE7NFq65Cr0OMzrNOFvap+RqFb86thlN
 yOJyuxXWio4p5jRK1+8U2OtCHxwF6L6FhhY3PM1YA5qowxqlQgWhnn5wTL1MBGO32yn/
 Efn+7xs38fRwGOr2/9jZ1ehfwFJTkas5QcZPE6F5rK5Au2BEPv3rJVA9wIS6TwIiQJmp
 XD1srEhKFlZU6L+hDlH38FxqnfMbCSYYjKRrJQiFJ6XdQBU7StG1UBrNHrjhJkbzql6Q
 LeVltuui0WkQQj3CmtQL6Tw1xlbR7HWGq5aOOl5gcyFscRZ5vidm2r/WlMeNJv3eHDEP
 iYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808259; x=1791413059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cKZnu1rTr7c/Ijov9F9quRvUzuktu9AMTFQRsUw4NS4=;
 b=QD0bfSS7cqMG/qwQvwm1fVEMnAS6MuizaZYE3v3dD2vyJUFjnwtV1d+KGYTssDpepP
 l9XKrTQ2JEnP2Q2xNbCt7tGWRNUtdibdMFtdD8t95ppGyqnHcxRMImBbSZ45FDOt1tJq
 Ot6Q3Uk8xRC9CAqKGImHkMlZUO/V5s7FAAbp/OkkRdh8xr+iccwd8XHS86rOIh26tvZd
 ka5pbhZXObUyWeUeUUgV/5dxF0g153StiS9RCPhab+6FuQxjiaVKDwyH7Ov9eiJkHyuY
 GxtpBXV1FP6Cr7tebouf2uGsqsJ2q0I2d1NlyMdixiw/o6sPPBHE3CH0jY4SwhA3X/SF
 v0jQ==
X-Gm-Message-State: AFq9FYIQulAh++W8BN58Ht3MS02LRrp+vyZkBdV/8TtV4skCOoatK3a8
 3YpauZXWFzcIF71Ow7qjd9Sr9cka53uHkN2mDfkM9umuA9JjZTu6SPyNkWA2WACE+0PcWe1iONV
 r1/qD/kA=
X-Gm-Gg: AYBFou2mIoWxx+Jnd8Dbn/pu1tHnZ733775zBBz17tJmmU8fzwUpqtAQGEX0rRPiD8O
 rkMeLrrdQA8AtHPV6LzVHC48qxDNpRKF1b5UmSJ5IrPrcJlCgVRzOG/T/EqyXKlWAMdNUzh0HUL
 AmYyi3RP7lBnB5a7/j3KHvDbmSbCjT45D7nSpDAm0DoSOCwgGaZM5ObkqRXiN0+KvyjrNoGZToQ
 +iY+Hcp5OLl+wA/iCdB/BvTYuuA4iybyAgzZtX7dOm6QK4vxsA0w6YQbLtudYgu2i4I0iSX+gDa
 nyRYxmb4RZ3m/uefYAhZN23zcxBuQg9EpfvHx1M3LxveN1nknfaMgDiG9yxG+SZKjNX+K5ICqvf
 oYzvM9hBwP1ND1jP2rrKyv1PFLbFyU6puRoPDbcJqTdW3fMR+XaIr3VaUhngRmAzQNbIuZRKVVU
 /ER2FpJsGVGGRUlh6ngQ7za7sXNcdJPAfpjgMMwpvR8ii718fFJbLbhgXCpLp6KKx27HjrCK2I7
 pL0fNeu8puVRdcAnyt7VfJe3/KYI0C6Hfwn/Q==
X-Received: by 2002:a17:90b:4ac3:b0:39e:6c68:fd8f with SMTP id
 98e67ed59e1d1-3a4f318ff56mr502028a91.36.1790808259275; 
 Wed, 30 Sep 2026 15:44:19 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.44.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:44:18 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH v3 34/65] net/nfb: use kvargs numeric helpers
Date: Wed, 30 Sep 2026 15:40:52 -0700
Message-ID: <20260930224340.58580-35-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930224340.58580-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260930224340.58580-1-stephen@networkplumber.org>
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

Replace the open coded isdigit(), errno and end pointer checks in
nfb_eth_dev_create_for_ifc_by_port() with a range checked conversion.

The "port >= LONG_MAX" test was redundant with the interface count
check that follows it, since ifc_cnt is far below LONG_MAX.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/nfb/nfb_ethdev.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/nfb/nfb_ethdev.c b/drivers/net/nfb/nfb_ethdev.c
index ba7c849a4b..f2ad831c08 100644
--- a/drivers/net/nfb/nfb_ethdev.c
+++ b/drivers/net/nfb/nfb_ethdev.c
@@ -965,19 +965,14 @@ static int nfb_eth_dev_create_for_ifc_by_port(const char *key __rte_unused,
 		const char *value, void *opaque)
 {
 	int ret = -EINVAL;
-	char *end;
-	unsigned long port;
+	uint64_t port;
 	struct nfb_ifc_create_params *ifc_params = opaque;
 
-	if (value == NULL || strlen(value) == 0 || !isdigit(*value))
+	if (ifc_params->map_info.ifc_cnt == 0)
 		goto out;
 
-	errno = 0;
-	port = strtoul(value, &end, 10);
-	if (errno != 0 || *end != '\0')
-		goto out;
-
-	if (port >= LONG_MAX || port >= (unsigned long)ifc_params->map_info.ifc_cnt)
+	if (rte_kvargs_to_uint(value, 0, ifc_params->map_info.ifc_cnt - 1,
+			       &port) < 0)
 		goto out;
 
 	ifc_params->ifc_info = &ifc_params->map_info.ifc[port];
-- 
2.53.0

