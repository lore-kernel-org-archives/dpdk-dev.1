Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A14C88E50
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:54:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A59CB4161A;
	Mon, 14 Sep 2026 07:52:04 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id 87DE441109
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:52:03 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-39b2ad83dc6so1769196a91.0
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789365123;
 x=1789969923; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Lzm/dmYqNqHPPxQWj3YR9m9ikkEgENVXL3UArn/GNTM=;
 b=aUdB4k3ovDTfuWOWi5ChcI2t4tMG1YYUvJaEDhBAwEX8kGSotdAdH9sbGLSBAJU5kN
 raM+A7tdslyNQpmHmXoPkCutSJzmUho12QFcXYMKXzN3g5FS8tQew7r0QO5nf7fFKxv1
 wSzUiAyLCKJLla8Wt4GebzdbMmQcDdwL5hoC0De6yHj1TiqfoB2H+M3NzAE5fABJZ5LW
 oOlgPp3YiZ2wZQIQqIz4sL00K+H1WwvBPIci/B3HfsqWSkjMmhILS7rM2WLJdE6+cy4/
 tA/1udnrcCOFfaUBPExBO/uDsLh8lIZfm6C4Y1yu1iMvY2dhCMIsCg/MAmBLYMGh2ZGp
 TsoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789365123; x=1789969923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Lzm/dmYqNqHPPxQWj3YR9m9ikkEgENVXL3UArn/GNTM=;
 b=YZNYQyjaZgAeAhLUhBSYocXTOPAJxYC76QhA2ZcA82U1hWui8NLsZpNpZr27CIAgEs
 JfP/1mR0vTDpNkGEk08ZZEuR5xNUMZnYAkcO1w1A0FAfUNL+jiGJoreJ53dmC6qmIg+w
 XtXYhMyOnEvakZtVYvXbkwa37mpMz7Txp3YGasww2Dz/Qril9zxAb24HYgIf3G01txgK
 k2D+ND/K6ow7+y6ir/SFBhm8wqujEqEr77OvOxQIUWDd+CdFyw/22ubJgLYbj7DI4OfZ
 yGQZrfJeS3FZ+FaMm1THFUc7PWpp9vceLLVLQKJ1J/26j+mLWcafIEX0GaOlQnHceu/P
 YYyQ==
X-Gm-Message-State: AFuF++nmQ1n1OnMeuxAStNsN9RhvMP/A9vHyRG7OEQbF7PGxX8iVJnh2
 +UU1iV3BHhB9EOkahT+TDHp5WkmrsEd8MXm0PsHVLwqtyc6CU1wWSc5KxDOZliuJ8Oo3zAmmGmk
 qOGXGjsc=
X-Gm-Gg: AYBFou0pGCUEuQ6PLhTkx0je8lcksnvg99TpVd8BtqcWvUxh1gTaNPUONa3mocX8ruT
 Fi8no6RXpwqDMVywt3Fa+LKkixpjUZ7sB7nN6ec+AEsa33gZU6BtHpEJEVbVP7eF7pVX8X4rnkH
 RGz88Uvh6q5vdMq6Q9TCFpdHY/x03jtWl70QstcoYghh1Cy/9wUjG4vSLbNcufkZCqdVajSqrOD
 XJjbcZSrZMw4lVDQ/aglgahLjdjjv6P9M1bpNV/cwfOcl+zy3qlkmsDXzddkIys4UTISThEfsF7
 WqTLxHGUiKo4Pp2u03E9B3cYstlSm/CIISHnGuzDvGx+RWfsTjc4Le9gFqtgWN711wRzClg0tOi
 A2jvk4iqw+qmDpTy45oXzuwunm0SOrbF3VQcNt9EHegc035bPgwr9Az/ApmHmXPSseKh1Gs4csl
 /R8Gvl6TOJNSu6tHTe14yHQU/wiofYinBh1WSL0ajg/ke4YC3THe4Kw3qFvZCzshbxJPi7wx0eo
 oZaEFkOIb3VqHDKR2/Ug1Pyj9Dry3+i7yVEgA==
X-Received: by 2002:a17:90b:3c47:b0:393:19a3:4f1 with SMTP id
 98e67ed59e1d1-39debf8d92cmr2802761a91.6.1789365122650; 
 Sun, 13 Sep 2026 22:52:02 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.51.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:52:02 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Matan Azrad <matan@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>
Subject: [PATCH 47/62] net/mlx4: use kvargs numeric helpers
Date: Sun, 13 Sep 2026 22:47:18 -0700
Message-ID: <20260914054912.755403-48-stephen@networkplumber.org>
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

