Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228E1CA5FC4
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:48:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 08E2442FD7;
	Thu,  1 Oct 2026 00:44:38 +0200 (CEST)
Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com
 [74.125.227.168])
 by mails.dpdk.org (Postfix) with ESMTP id 8678742F5F
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:44:34 +0200 (CEST)
Received: by mail-pj2-f40.google.com with SMTP id
 98e67ed59e1d1-3a0eeda3e03so2413179a91.1
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808274;
 x=1791413074; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Lzm/dmYqNqHPPxQWj3YR9m9ikkEgENVXL3UArn/GNTM=;
 b=uCY2otZyH07vjttVU/TWyOGEh+1ZKooIhoFwgAR0Q2BzsUHx6guv/ZGZGbCasHu3ah
 psf37leDBU9TUDBK/XtPVkMn5Bxhw2DfeHy8F2le2Jl7lE8hhXuEibFF++lKIXVzcAQk
 8ZZqqEhigoGja5MS+lCRSECsR0nYxJ9llkNEDniQ+wmO3ELY79C/oT8ul7hd//sxcnAI
 ebLe7m/VFTTJL+HmcUxmcUVAOEbSRpOtFOQM8aNryolywgP/hsx/qY8WUNHMAVXRovX4
 lr198BbI6Pr4y24I6D+Oc5w/pcNUfk77Q/ZvMun7xGMwlbbncgq4wYhHd3ULP8CEzXSm
 HYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808274; x=1791413074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Lzm/dmYqNqHPPxQWj3YR9m9ikkEgENVXL3UArn/GNTM=;
 b=JvApVrJzRTeKR1E+UBmRN5HTbZiHXJhh5GTLS15znSz40+kIubfVPC/1ownYzVoE1X
 j3YjCQRkOPNowKHylleOKtHYDVFZJDj/kAcMgxAx8IEUhRYHI6Zf7gmcQbOA+/sYuQO+
 AERnivvIx6xIoPE1MYPuGUSpmSVQCP5IvlyIm0Kb/fGdfNd/bfeZWJtyNsU31H6lpHZW
 5efSvzq/uXrJ5LazS9LDte3K5H4X+7BDPMsY/y9B9/NL8vY1Ps0AIpW/bbgpRGpQ0ZAw
 ZKxSifvJPIlW/rLBmJ02m78PrxzUxkaOg/+yqBLVCa1ShLNfeXAEZBwAW7jovvmIfunv
 jr3w==
X-Gm-Message-State: AFq9FYLCZE98xocKlTrW/MQQQrGmrqnud8+e/OEwXzARO0LmZSJ0y9iW
 4rFGbBKbp3snM9Waz8Ull1eySMPe4xEJA6a6bQbn2vsywsSvodHM3KgHiN8+0MZNvk1Xd/rPKCi
 JbN1Hfbc=
X-Gm-Gg: AYBFou3rq7C/yvi5LR7OUWdpnXO9jycQtb8tMOLf1CKGmk6ysgCjArOt/mqGCSE5qFJ
 E8VDGvmydzQjBAW/8TKZBOTGyqpwjXnRac4byjRpqgjbFiY1WtDZbrc6d9HRwEnefUhhynJvZQr
 fl7qo6DgUhwzC3WlWO2wK/uLxC1uApp5j4WEZvbUxN/PxbCDWxsx8y48MT0hFGg7p4tpPGbZ5Dc
 JUOJlQycoGzkXiup1K3H2teCx07A+75Fp1Z9nTAew7yBqz9FdeeCrHPSk1kp98ki7r3g938qwKG
 eqKb6BKj5shfW1aEPzn59yun5dJ65jun6oM09I0o4AhegRHv9OVgrP00FDhWJHo2ynwzh8uGmMW
 8A4yXBLkR/ZFoi4a+f8uxIcpZYDOnG7eLlzOit7eWb+agRo+ElnAiu0oSjR8lBDAWQbOJUxwk+g
 JQMruWtNsQVPEAoQUmv3TxFSI3D90TtEriDbseC+00TwK7tVRyYkRogkiZJTxn7QmXYFEd+PJaS
 RFnQ1kgBdgJ5CcsVMWGRt+9pGy+GGR4Sz2xsQ==
X-Received: by 2002:a17:90b:50c5:b0:3a0:c717:2db with SMTP id
 98e67ed59e1d1-3a4d1534cb9mr1104868a91.27.1790808273650; 
 Wed, 30 Sep 2026 15:44:33 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.44.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:44:33 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Matan Azrad <matan@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>
Subject: [PATCH v3 47/65] net/mlx4: use kvargs numeric helpers
Date: Wed, 30 Sep 2026 15:41:05 -0700
Message-ID: <20260930224340.58580-48-stephen@networkplumber.org>
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

mlx4_arg_parse() checks errno without clearing it first, so a stale
value left by earlier code rejects a valid argument, while a malformed
value such as "abc" sets no errno at all and is silently taken as zero.
The end pointer is never checked, so "1junk" is accepted.

Base 0 was used, so a leading zero silently selected octal.

The PCI_SLOT_NAME parser is left alone: it reads sysfs rather than a
device argument.

mr_ext_memseg_en is a boolean, so make the mlx4_conf field bool and
parse it with rte_kvargs_handle_bool(). mlx4_arg_parse() serves several
keys through a cast function pointer, so the boolean gets a call of its
own and the generic loop skips it. The one bit field it is later copied
into stays as it is.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/mlx4/mlx4.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/net/mlx4/mlx4.c b/drivers/net/mlx4/mlx4.c
index 28f1116891..1e64230e35 100644
--- a/drivers/net/mlx4/mlx4.c
+++ b/drivers/net/mlx4/mlx4.c
@@ -70,7 +70,7 @@ struct mlx4_conf {
 		uint32_t present; /**< Bit-field for existing ports. */
 		uint32_t enabled; /**< Bit-field for user-enabled ports. */
 	} ports;
-	int mr_ext_memseg_en;
+	bool mr_ext_memseg_en;
 	/** Whether memseg should be extended for MR creation. */
 };
 
@@ -532,12 +532,10 @@ mlx4_ibv_device_to_pci_addr(const struct ibv_device *device,
 static int
 mlx4_arg_parse(const char *key, const char *val, struct mlx4_conf *conf)
 {
-	unsigned long tmp;
+	uint64_t tmp;
 
-	errno = 0;
-	tmp = strtoul(val, NULL, 0);
-	if (errno) {
-		rte_errno = errno;
+	if (rte_kvargs_to_uint(val, 0, UINT32_MAX, &tmp) < 0) {
+		rte_errno = EINVAL;
 		WARN("%s: \"%s\" is not a valid integer", key, val);
 		return -rte_errno;
 	}
@@ -545,18 +543,16 @@ mlx4_arg_parse(const char *key, const char *val, struct mlx4_conf *conf)
 		uint32_t ports = rte_log2_u32(conf->ports.present + 1);
 
 		if (tmp >= ports) {
-			ERROR("port index %lu outside range [0,%" PRIu32 ")",
-			      tmp, ports);
+			ERROR("port index %u outside range [0,%u)",
+			      (unsigned int)tmp, ports);
 			return -EINVAL;
 		}
 		if (!(conf->ports.present & (1 << tmp))) {
 			rte_errno = EINVAL;
-			ERROR("invalid port index %lu", tmp);
+			ERROR("invalid port index %u", (unsigned int)tmp);
 			return -rte_errno;
 		}
 		conf->ports.enabled |= 1 << tmp;
-	} else if (strcmp(MLX4_MR_EXT_MEMSEG_EN_KVARG, key) == 0) {
-		conf->mr_ext_memseg_en = !!tmp;
 	} else {
 		rte_errno = EINVAL;
 		WARN("%s: unknown parameter", key);
@@ -590,8 +586,21 @@ mlx4_args(struct rte_devargs *devargs, struct mlx4_conf *conf)
 		ERROR("failed to parse kvargs");
 		return -rte_errno;
 	}
+	/*
+	 * mr_ext_memseg_en is a boolean and has a handler of its own; the
+	 * loop below covers the arguments which mlx4_arg_parse() handles.
+	 */
+	ret = rte_kvargs_process_opt(kvlist, MLX4_MR_EXT_MEMSEG_EN_KVARG,
+				     rte_kvargs_handle_bool,
+				     &conf->mr_ext_memseg_en);
+	if (ret != 0)
+		goto free_kvlist;
+
 	/* Process parameters. */
 	for (i = 0; pmd_mlx4_init_params[i]; ++i) {
+		if (strcmp(pmd_mlx4_init_params[i],
+			   MLX4_MR_EXT_MEMSEG_EN_KVARG) == 0)
+			continue;
 		arg_count = rte_kvargs_count(kvlist, pmd_mlx4_init_params[i]);
 		while (arg_count-- > 0) {
 			ret = rte_kvargs_process(kvlist,
@@ -783,7 +792,7 @@ mlx4_pci_probe(struct rte_pci_driver *pci_drv, struct rte_pci_device *pci_dev)
 	struct rte_eth_dev *prev_dev = NULL;
 	struct mlx4_conf conf = {
 		.ports.present = 0,
-		.mr_ext_memseg_en = 1,
+		.mr_ext_memseg_en = true,
 	};
 	unsigned int vf;
 	int i;
-- 
2.53.0

