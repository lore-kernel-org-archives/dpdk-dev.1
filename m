Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCE2CA5FC4
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:44:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1AD6242D7F;
	Thu,  1 Oct 2026 00:43:55 +0200 (CEST)
Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com
 [74.125.227.167])
 by mails.dpdk.org (Postfix) with ESMTP id 74FD042D2B
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:43:50 +0200 (CEST)
Received: by mail-pj2-f39.google.com with SMTP id
 98e67ed59e1d1-3a4805e15cfso2016542a91.0
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808230;
 x=1791413030; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PWCxBJsidyWJCKf4Q+oX1YIwY3/qHy732Lb2HNNQASc=;
 b=tbKLsHseIMblLjfXMdJt4Pke2wPm+7VcjNHOCH4qSOZTfegKZY5+C+UOQbjrrE9LrL
 V6/ddyv32AfUXDTmi13lzpOHJpFgoW2AD/aAdimBOLrNV9/e8KNPzYSvYLIPN9nObuC5
 7g5fvJszF7A1YbdL87fAaE6k3dL4DtwB8oWeRentSHFRVdMXEdZwNZkyvpqINCgLMZKO
 Y+O06lvFhudq1FaXWjadbdqwDJZ4Euw8ITB9T+UgIUWtagcJXrfmhAYx81hJm4LK+Bcn
 xAF2z/ARhzc5L8XpOg2rVFgtNgN4BsLuxcsnJ/BeyX4qwWhztidBSTU3Y2AX4z2LSaEG
 nM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808230; x=1791413030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PWCxBJsidyWJCKf4Q+oX1YIwY3/qHy732Lb2HNNQASc=;
 b=RouLIrsQ90a2AX1Jzmu72vRV/YzBA3+0/Ohw5B6AviIGo528XMSWzZ+4k0a8TYJMPH
 lRX/iVkiFPP47hKyE/OdKNawUuQXr3DnPJp+TFoXX6HKHyCM/GyEMFWgRjBgYPvqGIKO
 K6YuHsATH+lIz2chAUD4fPtOx9+0Ilu4wqUHxVSg4EIv5ZDLRg+tIbgcmWzV/Ysj5uLH
 gs/czLDGxyKcaXDLZdcm/CPzX30JG2PIRV9gzF4q9c7uAYrIeEA/+THusAUk6qvx4Y+c
 k1kWm+CtTea1v1QqSVER7el64qXNjhn0iMbn/uUueqCra0vY4qL7Tdh+jufkWGGIEH+0
 e3OA==
X-Gm-Message-State: AFq9FYK6uLy+gCJ/3FJ400lfCkgERgT6vUHhGOHbMk++KAjZKVzPbytO
 Rxyxw4gQM4YtirAcMn6RuaJKKZ19pgtjQa/cAS2UCklPUCNCBISImEpMvn8vt43FE1K77c9Wi16
 Zn7/n
X-Gm-Gg: AYBFou2IGAykdzufnzD+p/1H4wqZj2fZ96TIHUUD5bE+idI5QBs0pwis6imP3A2BkSx
 ufFJEPY1e37CHybgPUTgVz43xkwFEURyK06BRtbS3d4GXSaO0REkJ4rrRdag07KSDRxNOD/O9zB
 EQ98v7fX3IneNdz6s6fDR0/d24wN06maB+lth4lAPAoe8RFLac3G4BAmNdKI5747pYtgLe52YqA
 rOlas7Wki4utrT9a5SogZSUGY9sIETEvbZDmkAOptCqiVNePmO1gB5urkokJKG8CdgkYBQajZX5
 bpP6DLAJf9SKhB42VLrphHSntdroKxCgxY4/0teT6rPQIQVEMG6xmUHxrp+dQZ8e+Z1eVHVDmcF
 NGLWVAx0Kao/igBBCAGuuiX4vOQeDTVCC0b+C5HajzKz6DEl79w0s4vTkm9ur/UhVXDyllQxku4
 buR3xu7oihMklrSSyU9F1TrwBoHebmyO7G1LyAOO/kZtGj48naco6lLiNJy2xxld/ZL/0zw2Sny
 7o70KJkpSIJdbJ2L5M+tsIpEvOmrj8+wJINgbkmUNtUE5el
X-Received: by 2002:a17:90b:28c4:b0:3a4:7c19:6a02 with SMTP id
 98e67ed59e1d1-3a4f9f19f12mr229576a91.0.1790808229718; 
 Wed, 30 Sep 2026 15:43:49 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.43.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:43:49 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Xiao Wang <xiao.w.wang@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH v3 08/65] vdpa/ifc: use kvargs numeric helpers
Date: Wed, 30 Sep 2026 15:40:26 -0700
Message-ID: <20260930224340.58580-9-stephen@networkplumber.org>
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

open_int() stores through a uint16_t pointer but both callers pass the
address of an int, so only two bytes of a four byte object are written.
It also checks errno without resetting it first, and never checks the
end pointer, so "vdpa=foo" is silently taken as zero.

Both arguments are used as booleans, so store them as bool and use
rte_kvargs_handle_bool.

The booleans use rte_kvargs_process_opt(), so that a bare key with no
value enables the option.

Bugzilla ID: 2040
Fixes: 40ef35f4a504 ("net/ifc: detect if VDPA mode is specified")

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/vdpa/ifc/ifcvf_vdpa.c | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/drivers/vdpa/ifc/ifcvf_vdpa.c b/drivers/vdpa/ifc/ifcvf_vdpa.c
index f319d455ba..1381f7cc9a 100644
--- a/drivers/vdpa/ifc/ifcvf_vdpa.c
+++ b/drivers/vdpa/ifc/ifcvf_vdpa.c
@@ -1480,21 +1480,6 @@ static struct rte_vdpa_dev_ops ifcvf_net_ops = {
 	.get_dev_type = ifcvf_get_device_type,
 };
 
-static inline int
-open_int(const char *key __rte_unused, const char *value, void *extra_args)
-{
-	uint16_t *n = extra_args;
-
-	if (value == NULL || extra_args == NULL)
-		return -EINVAL;
-
-	*n = (uint16_t)strtoul(value, NULL, 0);
-	if (*n == USHRT_MAX && errno == ERANGE)
-		return -1;
-
-	return 0;
-}
-
 static int16_t
 ifcvf_pci_get_device_type(struct rte_pci_device *pci_dev)
 {
@@ -1635,8 +1620,8 @@ ifcvf_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
 	uint64_t features;
 	struct ifcvf_internal *internal = NULL;
 	struct internal_list *list = NULL;
-	int vdpa_mode = 0;
-	int sw_fallback_lm = 0;
+	bool vdpa_mode = false;
+	bool sw_fallback_lm = false;
 	struct rte_kvargs *kvlist = NULL;
 	int ret = 0;
 	int16_t device_id;
@@ -1662,9 +1647,9 @@ ifcvf_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
 		return 1;
 	}
 
-	ret = rte_kvargs_process(kvlist, IFCVF_VDPA_MODE, &open_int,
-			&vdpa_mode);
-	if (ret < 0 || vdpa_mode == 0) {
+	ret = rte_kvargs_process_opt(kvlist, IFCVF_VDPA_MODE,
+			rte_kvargs_handle_bool, &vdpa_mode);
+	if (ret < 0 || !vdpa_mode) {
 		rte_kvargs_free(kvlist);
 		return 1;
 	}
@@ -1756,8 +1741,8 @@ ifcvf_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
 	list->internal = internal;
 
 	if (rte_kvargs_count(kvlist, IFCVF_SW_FALLBACK_LM)) {
-		ret = rte_kvargs_process(kvlist, IFCVF_SW_FALLBACK_LM,
-				&open_int, &sw_fallback_lm);
+		ret = rte_kvargs_process_opt(kvlist, IFCVF_SW_FALLBACK_LM,
+				rte_kvargs_handle_bool, &sw_fallback_lm);
 		if (ret < 0)
 			goto error;
 	}
-- 
2.53.0

