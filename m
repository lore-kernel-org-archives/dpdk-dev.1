Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BEACA5FC4
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:47:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09B9242F23;
	Thu,  1 Oct 2026 00:44:21 +0200 (CEST)
Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com
 [74.125.227.166])
 by mails.dpdk.org (Postfix) with ESMTP id A4F3B42EC5
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:44:18 +0200 (CEST)
Received: by mail-pj2-f38.google.com with SMTP id
 98e67ed59e1d1-3a4bb1ed012so1331896a91.3
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808258;
 x=1791413058; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l9rAW62EBliE7/BBKpPZ8CArC5Fax1s056P6Lk0WBrw=;
 b=uref5xy8+cOhPnAAq0hc4njPxNVJAUyDokwGj9QJ4Ti0gV5oamLsD0vNpGIdIN9BFc
 dtagtPdJnpS4AGb6ACxdd2fuhlAxV/NC6ebAnt8y+8fWn/k9UnY+JMIhUoXBd//jaAnw
 JVnVBwaYjtyf3wpw9nDLBDnoLczDAfva3I5CdvG2qMn042FnMRQx3QQ5T6/OSFb9RjVF
 paXJOnX/sfekW3rhMB4WK/RMJwNs9CokOIB8X7z+EUyJq8YOK6NM+KOQQf9/eNMaCdvq
 nO+5fZOWzMZvDgUPXFFnnFGIWcFfyzdwOX50TwkJuSOEo/U2o2arUQhxDP3tb5xEGr8J
 dqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808258; x=1791413058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=l9rAW62EBliE7/BBKpPZ8CArC5Fax1s056P6Lk0WBrw=;
 b=jgS+XL8zFRoAzBuNm8TBTEUQEcUynZRPEQ/LajGzL98Sce0IUn4uspeRCFZdNq+a3+
 2cI74Idarmaj8N4qVKjx+VQACPSOXEFjEfxwNllUhLymKfXlec7b764UJ0Xc0WVPaV/v
 Su7EL+U2zzU6N6sOUZBlFxbR0HT9AS9VLyscDMRxBsXci6P4wmIgrDVZPtKgq4hnICr2
 gAo/l946S+xz0XBvHLOPR3a/JviauJRWWo/o5x1CFANjajHpfjutaN0LVXujhiIIgF0Z
 WRDUoX6D++Wd8aKeuNVVIij+4mWQncsGSqwEgBAmwwRCzQt+XeqvYbNQw7WIY/l6tXLN
 7V6A==
X-Gm-Message-State: AFq9FYIJXWV8ewHwZhGt+mv2ebsIAnx0nPkMvsTLfgB1UuVhqFjCEkTR
 IQK7GmRTMZhJsQy1WHdj/O02771Bl1N7h20TY40vjLGLcC7mJbNfw+NmJ/SzEes7CSGa4+K04Re
 QLuVq54c=
X-Gm-Gg: AYBFou3Q0VEfgVdbig4SespDxLEWRRtBnZMZb75S/zreH5IEkxfNyMvvPmG2fhtsmkO
 jAMAJcqt1Ccn+2t5jO+ysKjdxz8cLHmQ/Fawk3lyeuO8Un6bXLsjQdJzFYftf6qBZLKg3YbO1Go
 +7jrGYXcDxkh/IcG+ixGTip09p86PiLY0BM3N9K8+7NGNJ5JVARc4R3+OBdpbJhUu0itCZJwx6V
 IKTcQ5N5VQ6c+tk+E/Pb2yv4IgeZH9NMzid+Lz/H4Nk6c5YMePHq3dIabwsWHHTPD9+fzwecBRP
 AVRQFX09sn7xjKgw01HY8cVTUUGcgeeUPznnC5O4jvdun4TnIk2pQTampgS3UtICqnrXtO6ZOzq
 25arAZEafEG+xl2vifafFq562/V7rWiv/3QqAstjU6MIsavTw5v8Mt2xrZpgIOIENai2x3misAx
 6yYPb7PHXhdXPjVtWtZtHfqteKy5Nr5kG4k8q9WkUbaj7vYRnlhfwEecuKhjYDe0ihKLK+xKH7w
 3heYDk/iDiV0tSnc6j0kz/jy+i3KE+bVdPdfA==
X-Received: by 2002:a17:90b:2891:b0:3a0:a912:e775 with SMTP id
 98e67ed59e1d1-3a4d191ec9fmr2530638a91.54.1790808257914; 
 Wed, 30 Sep 2026 15:44:17 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.44.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:44:17 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Devendra Singh Rawat <dsinghrawat@marvell.com>,
 Alok Prasad <palok@marvell.com>
Subject: [PATCH v3 33/65] net/qede: use kvargs numeric helpers
Date: Wed, 30 Sep 2026 15:40:51 -0700
Message-ID: <20260930224340.58580-34-stephen@networkplumber.org>
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

qede_args_check() ignores the end pointer, so "1junk" is accepted, and
uses base 0, so a leading zero silently selects octal.

On failure it returned errno, a positive value, where the kvargs
handler contract expects a negative error code; return -EINVAL.

Both arguments are booleans, so drop qede_args_check() and use
rte_kvargs_handle_bool() on qdev->enable_tx_switching directly. The
handler needed the device only to reach that field and to apply the
VF argument on a VF alone, so the IS_VF() test moves to the caller and
the loop over valid_args[] becomes two explicit calls.

The old handler accepted any integer and reduced it with "!!", so
"vf_txswitch=2" meant true. It is now rejected, along with the other
values that are not booleans. A bare key enables tx-switching.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/qede/qede_ethdev.c | 55 ++++++++++------------------------
 1 file changed, 16 insertions(+), 39 deletions(-)

diff --git a/drivers/net/qede/qede_ethdev.c b/drivers/net/qede/qede_ethdev.c
index c41177b86a..fa5f24b023 100644
--- a/drivers/net/qede/qede_ethdev.c
+++ b/drivers/net/qede/qede_ethdev.c
@@ -1201,39 +1201,14 @@ static const char * const valid_args[] = {
 	NULL,
 };
 
-static int qede_args_check(const char *key, const char *val, void *opaque)
-{
-	unsigned long tmp;
-	int ret = 0;
-	struct rte_eth_dev *eth_dev = opaque;
-	struct qede_dev *qdev = QEDE_INIT_QDEV(eth_dev);
-	struct ecore_dev *edev = QEDE_INIT_EDEV(qdev);
-
-	errno = 0;
-	tmp = strtoul(val, NULL, 0);
-	if (errno) {
-		DP_INFO(edev, "%s: \"%s\" is not a valid integer", key, val);
-		return errno;
-	}
-
-	if ((strcmp(QEDE_NPAR_TX_SWITCHING, key) == 0) ||
-	    ((strcmp(QEDE_VF_TX_SWITCHING, key) == 0) && IS_VF(edev))) {
-		qdev->enable_tx_switching = !!tmp;
-		DP_INFO(edev, "Disabling %s tx-switching\n",
-			strcmp(QEDE_NPAR_TX_SWITCHING, key) ?
-			"VF" : "NPAR");
-	}
-
-	return ret;
-}
-
 static int qede_args(struct rte_eth_dev *eth_dev)
 {
 	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
+	struct qede_dev *qdev = QEDE_INIT_QDEV(eth_dev);
+	struct ecore_dev *edev = QEDE_INIT_EDEV(qdev);
 	struct rte_kvargs *kvlist;
 	struct rte_devargs *devargs;
 	int ret;
-	int i;
 
 	devargs = pci_dev->device.devargs;
 	if (!devargs)
@@ -1243,20 +1218,22 @@ static int qede_args(struct rte_eth_dev *eth_dev)
 	if (kvlist == NULL)
 		return -EINVAL;
 
-	 /* Process parameters. */
-	for (i = 0; (valid_args[i] != NULL); ++i) {
-		if (rte_kvargs_count(kvlist, valid_args[i])) {
-			ret = rte_kvargs_process(kvlist, valid_args[i],
-						 qede_args_check, eth_dev);
-			if (ret != ECORE_SUCCESS) {
-				rte_kvargs_free(kvlist);
-				return ret;
-			}
-		}
-	}
+	/*
+	 * Both arguments select the same thing. The VF one is only honoured
+	 * on a VF, which is why the two are handled separately rather than
+	 * in a loop over valid_args[].
+	 */
+	ret = rte_kvargs_process_opt(kvlist, QEDE_NPAR_TX_SWITCHING,
+				     rte_kvargs_handle_bool,
+				     &qdev->enable_tx_switching);
+	if (ret == 0 && IS_VF(edev))
+		ret = rte_kvargs_process_opt(kvlist, QEDE_VF_TX_SWITCHING,
+					     rte_kvargs_handle_bool,
+					     &qdev->enable_tx_switching);
+
 	rte_kvargs_free(kvlist);
 
-	return 0;
+	return ret;
 }
 
 static int qede_dev_configure(struct rte_eth_dev *eth_dev)
-- 
2.53.0

