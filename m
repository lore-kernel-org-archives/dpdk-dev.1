Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94C9CA5FA7
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:43:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2576542F47;
	Tue, 29 Sep 2026 18:40:02 +0200 (CEST)
Received: from mail-pz2-f30.google.com (mail-pz2-f30.google.com
 [74.125.228.30]) by mails.dpdk.org (Postfix) with ESMTP id F174142ECA
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:49 +0200 (CEST)
Received: by mail-pz2-f30.google.com with SMTP id
 d2e1a72fcca58-880fcd3790bso1520382b3a.1
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699929;
 x=1791304729; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Lzm/dmYqNqHPPxQWj3YR9m9ikkEgENVXL3UArn/GNTM=;
 b=hTrijj7DmR0LVOWp9NcKKt9OiKi/m9bqV/5m81drvBFYSR2ix2GWW+uSRzkyo+BCJc
 Hxu9Sb/7PjOTobtmL1uzubWNw6uaUxq4Uwx1vAjcWdNxtjq0DR2Uq9WQT6pzCoSklzel
 tRdy9CHvTO4zVm0WHNIFGrE9E13Dpk/F9GmWTnjb9j+l3qYCfVL4de7cnhK053/870n6
 MQ+FI4lheZ3Nm1qQC6QFJ3RN2sb0tNqQ1dpUJtBTWlanzDKMxra+yCwh/PG7OZ58hBqe
 pH68eOS/dTlO8PoEUuSriafVwExCY0WnvP7/EZ/Ab+2nmONruS055R3wohsDTscFq2HA
 cBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699929; x=1791304729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Lzm/dmYqNqHPPxQWj3YR9m9ikkEgENVXL3UArn/GNTM=;
 b=YxIljxZuhFVI21pUFUtj1/FEceycsLTH8or1X4mLOzEE5Lieg1vDylc3GbwiZs4kDS
 goDJycfdhKY0dqFzW8PUUrX5eW6fE8As1YvYEAQ6QS9/oTfqTlyor7G2tJYJqfbw1FNh
 PItAwC3RzGnzxe94Xb6YjpU6mX0f1wgIq9KUND/XNdkv82yWErHnb+4zNISwq/bzzLJL
 7hLHsJ/XU/sbqf0XUpOH6Sf9J95YH5JWAW2WR9q4SEUYuaYvxtAScD4Pi5ji7U2lCayr
 /BLvWWUs8igqntVAEi6OYleSiTkERo4YSrBRTzKeJ2wWrgdxQmo3X4iVpK6va679ZHPF
 f32w==
X-Gm-Message-State: AFuF++k6BCOmNiKyWNAZvlnLn58zmnyI2ZDb+R3X4uRcJ7oTQPrdhee/
 FbaZ+g/0xbHQxZLu2U7/+kIdXrrBVZ3Gn2kjT6iqQQ0km5Hn86HGV3skkVMjkOMnH2E8jm7uRsR
 o9+YcxN4=
X-Gm-Gg: AYBFou1G3tI1DizhCV989TQ7TLaHK93hLcywDR1dDlE2+7n2tzYZOxmzD6NZqlicPOh
 qpzq0mYeQnF4rX8mnsvn9qgE+b7fVFviapC/Rk0PhKHRDOWTHeJ/ZSYmwYJQmbXs6heP6XfklxD
 ReZLP96vxndjhoiM1L4TPqeKaDXaZx+7SequFglJYXL0x9UZbTfppuM16GqdYM0eSncnwN2FlIE
 IfhsOXSIA0+GZkGJbW79ENcXHVr6/Lo9SUIhkkjfXpFHkughq0FlMi9tSt451t8XFVhhMZfP4SW
 gyKfoD8zDcBBf5E2RMVmK23grDvizCWPC5bdPkewFuAjGGldVr3txBbXYf56swrS99bu++kBhJ7
 9nTSU91j8PHLBOs5AlO3kQVA9xyuByrpVOTG5ENZs/cp3pMUjl6BhoAfRtzfWZS4jV6vWwcEWB2
 2++4xisnwNNIrwblvIziRKqkFTFwNLqoBd2c2uSx63I/3MZWClOg8FbTTzUEKCWju/K8zZOKTKG
 C3BHbnTZDJhZYbY0JEqUEINa6mV2Xgpg/GHusA=
X-Received: by 2002:a05:6a00:a243:b0:878:34e7:9a40 with SMTP id
 d2e1a72fcca58-87e9c166fc6mr14510879b3a.57.1790699929127; 
 Tue, 29 Sep 2026 09:38:49 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:48 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Matan Azrad <matan@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>
Subject: [PATCH v2 46/61] net/mlx4: use kvargs numeric helpers
Date: Tue, 29 Sep 2026 09:36:49 -0700
Message-ID: <20260929163800.1108305-47-stephen@networkplumber.org>
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

