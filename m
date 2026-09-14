Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1F8C88E50
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:52:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CBC440E50;
	Mon, 14 Sep 2026 07:51:15 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id 681C240E18
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:51:14 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-396ccd78e6eso455253a91.0
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789365073;
 x=1789969873; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4LmuUlKsachKfWP3GZ+NzxJcSm+v5a96I1MM7l6tHWs=;
 b=aFG41zv3zRAAGARXepDgvcbINI2KTN2ZGxOjpaaOeqeemdeynXWateoztE/P/cyVXI
 yyozRihOWO8q3/0782x3ZmA/ynez9DTXoXDfl5Q03GRXkSgOUZIkFD/oeYNsshS1k0N9
 zjHyEtokYPfJHLO7YWGxok4Qa6lTiJAEbmeeujGOz8pyv4UH6NBf3DSxVNFck0hv4JgO
 cvCgDgu9yR97fTncb9/i1JBsIjiNRhZJWxlmcJ4Lms8akQAlgZS8smFi0Xm4PMp0cgv9
 rzZnvx8l1vE/9ljArVsy9REEWpqaqIQuGYYZ+/f5+ilolSrIk/B4LEvAgnVK//kfKR6p
 v72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789365073; x=1789969873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4LmuUlKsachKfWP3GZ+NzxJcSm+v5a96I1MM7l6tHWs=;
 b=WrgIE+LRAEykSZJVroezDO44WkpKqiiT9hZh4NLwmwo1l6QKTSIyS3myMNCerOSK8S
 BphCAMhio6XeBM1D8SE4i9y3nINWsrivYiB/nQAiwpyBCJ9/e0hasvc0g9aK5Vm537kn
 YxH6iqik6k5rAbhHloJ7NKGM8XRdTQo2uTgUc2uZy6rNs/ecDfklHW8j+VxFMi2QVws9
 SL5DnApw84p30TGCnDiWT8N4TrNQ5R4rOnOYRG6Il6iCYt3az7jW0xKO9IfzPG0PWW+4
 bL6GQSAoAT0VS5GYSc1z+TZbAY7tdSF+hGkyzsQRBblFVr9ifIlRialPezpzG08Qf0Wo
 U+2g==
X-Gm-Message-State: AFuF++nwur6xqh+RPMmVDBN5zZtBLGhcFhbsox0coe4st8nhUHuuRJjG
 OdDVSx5GGIzHbQvqxLt3C+Ws/quiFEmijLL0sdeY/UH0vKIQ0tNfHSUZxTAX4i87WwO+1TPmU4x
 MXnkg
X-Gm-Gg: AYBFou2vQu6FLwMVNZY+TIFqw+MniCnYB7bxGWV8BNYx/2GQhYb156TeZF53MVNamgM
 RhYxMxvZPPidJpI6NjFiLTORaJTVnHgo0PzoTpU/WJXorZQVxRwPGGqZqDPb6KomZyhbiKtqcb7
 uQ40beah51QG0tE+GNzjDfQhwBxzRH9/o+cUS3HaTU0lMq4SoQdYwXv2Y/2t7rWsAgNKXXM/l7w
 iWewp3Z2Ph/ZGDXVRd/JIO8W+G70hb38fcvwwGJ9xQM9QNn1NsGmLnxKfEtYtTaruYTI1OV9Cr0
 atbZu+l9HH2y/Hj2M2PVNIPoSWwzSYlhC2TYQNnxKQ+voZAXYA56Wf8RH0wTI81x8M8XM1ir4Dd
 HdkVJHW4lY9MxRDIy1b0DQlwj1LiaQApwEzJUWWLtefAjtQqCDyCb4q8Ri/SaHoI8Wg4vlruBmi
 mg6UO0xdW72o23NB68e6vmoXZnLnQXWegwNd+4/aGHVuzLWL2dfMjwlAfjFYeKKStIskol8aJDF
 eVxLSRD/YiwybhEJ42c/dqdW1LBQt2A+IoTESeqNnicIonB
X-Received: by 2002:a17:90b:57c4:b0:38e:c232:9d2c with SMTP id
 98e67ed59e1d1-39dec375390mr1171675a91.2.1789365073532; 
 Sun, 13 Sep 2026 22:51:13 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:51:13 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Devendra Singh Rawat <dsinghrawat@marvell.com>,
 Alok Prasad <palok@marvell.com>
Subject: [PATCH 33/62] net/qede: use kvargs numeric helpers
Date: Sun, 13 Sep 2026 22:47:04 -0700
Message-ID: <20260914054912.755403-34-stephen@networkplumber.org>
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
index 4efc2dd349..5bf70ca2b5 100644
--- a/drivers/net/qede/qede_ethdev.c
+++ b/drivers/net/qede/qede_ethdev.c
@@ -1203,39 +1203,14 @@ static const char * const valid_args[] = {
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
@@ -1245,20 +1220,22 @@ static int qede_args(struct rte_eth_dev *eth_dev)
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

