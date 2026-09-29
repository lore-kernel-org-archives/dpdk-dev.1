Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BB6CA5FA7
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:42:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 512F942EE2;
	Tue, 29 Sep 2026 18:39:30 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id 756E942E1C
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:37 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc4c08393b0so1938036a12.0
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699916;
 x=1791304716; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l9rAW62EBliE7/BBKpPZ8CArC5Fax1s056P6Lk0WBrw=;
 b=bI/gXfdu9xhkaFbC7lE5Ifj+mKnR+bpEXgCLXbxK2ILJcrbIT4p34/c9WXHeGWgLcc
 UTqFuptVDsQ5BJ1cSCi2/rMnrCq4DYiy439Z9IVorz+29sEDYxGGvEUjGJTpHnkfinCw
 yf3z8MnKiBe08TDXAHiRx3SmcQ8VYKj+FEIwBMCKt+3ea/YVG/YJUSmLbEEA2krXV58s
 uLCYisOjHytwMRXQjvrG8CTzzAWG/HETBFs1nl4SnArqWb65kyo4DU/JpLrv02lPt0QG
 b1GxGSKHSwhvQ/GAPsTCfvWlg6HlcMq4rxPWpE6/XLVkp2zToWM7AQaav9KdcAcp5Z4U
 cXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699916; x=1791304716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=l9rAW62EBliE7/BBKpPZ8CArC5Fax1s056P6Lk0WBrw=;
 b=nWic+jafsiTnRVbTdw3PP8spxGLBedZYfTpj9VEa6yGRvgo4r1ZEp5F2IgYleMELEp
 vPgzf1ewPnSZ7WhECodzN5lnY5jrydGZMzj+6PUwUquwEYST849IWIIrKssVM/Qkoy3+
 6RfTH4VjmQTF1/txNHWmLPmVmRJco3qvTfaNca/+Mi+j+bSOTOHmdzM7VMYPK7sW/13b
 aLc1LrnAoghygMyg4gZBHgNg8Nqhnb+i6sXjbvebCTwAXZA9zuX7OI+91Xg9PQboN6iv
 PerRo0DUx4Mbo+uJaxkRyS3S/HdapIpLfs8cj7Dh1a1jTmaU7qjLP+HrKlOFaoJxMipP
 3SCg==
X-Gm-Message-State: AFuF++keeQH4uUwMAfyt5jAyUxMnB++wAsWNWxyIFdHp0zqmWUjRxrCp
 91fnKlaOvqvaCspOCMTAM3mLOgCs0UPfWtHn/uhlKvG5UixoWJcLRCC5pvCl6qWwianStRxeyqY
 bvCwvdIo=
X-Gm-Gg: AYBFou2eOS1EvhdXCjO0ynd4toGutv2yETaMhKWJdf1qKHk7Um755378FKgaVbe/0tb
 Cl9suwINzSiOPS/f1FyEIuJ3A1p+9ISZ8/gt2CwFMK0lH8Py0oguaDr50fYlBaxjkr/QVbtWOU+
 D7Nq9KNXcBBngk2o7E1gDXBk7xx2gPpse9nOLj7shpdhSy/Mxo0x5iY5kPhLXhLV2HxCHbFBAzo
 UzgYjC/Yn2yAdEzMqafE6mOuBCcV7p7sTc+OVAY1F6A/K7N+0tvgHQZhUItVEv9f6/m2bQ1mLYg
 BP+nR0w47Xg7b4EDWpCG4dBtJ0j9bK4ZGIqBdJykjwYtmikB/rgYRvMddzZZVrWx9+z3iENF8/j
 6dLX00ozr+b6mo38gB6mC05kjFgIpxwXY5aYBeQcPIR0fA6YW4mbpNiiiHcc5SldW8KaTZbKmWf
 9UO5fM6b2v3mFgbrhNSmObHZ3eiIN0EQPMDy0SB8ZLfUbgOh1/V77ph9idiLj5UQj1+rmXzyFlE
 kLxb8PGkN14oJ6rWKF1uVHAuGPGSw2c1cw7vA==
X-Received: by 2002:a05:6300:6d90:10b0:3de:59fe:d71c with SMTP id
 adf61e73a8af0-3de59fed8c5mr4599118637.60.1790699916647; 
 Tue, 29 Sep 2026 09:38:36 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:36 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Devendra Singh Rawat <dsinghrawat@marvell.com>,
 Alok Prasad <palok@marvell.com>
Subject: [PATCH v2 32/61] net/qede: use kvargs numeric helpers
Date: Tue, 29 Sep 2026 09:36:35 -0700
Message-ID: <20260929163800.1108305-33-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929163800.1108305-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260929163800.1108305-1-stephen@networkplumber.org>
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

