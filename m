Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573D8C79F82
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 19:17:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A5BE642E0C;
	Fri,  4 Sep 2026 21:17:28 +0200 (CEST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id E155D42E56
 for <dev@dpdk.org>; Fri,  4 Sep 2026 21:17:27 +0200 (CEST)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2d560775ca2so10691995ad.1
 for <dev@dpdk.org>; Fri, 04 Sep 2026 12:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788549447;
 x=1789154247; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D2j2esoh3PkJMJVpD4hZ0fWOSghOOHyL8fLnCQ0r8tw=;
 b=uLbaKedPhk9cgRkP1E/D4eZXxIbVrzGLWxs+o7D0wVVDjlyr0WUmueXCF31YBqpAXR
 YhxjIcgqN8GZsg2/3YJGn1zqxYSF1ZJm21e9eRlqS7K1GBBcNt1xQdaju2pPyCeiPB/N
 FQgQc+Gc//2b/Z+57DhF7mfDlM6HmAj3r3WSMYs6STqiag8tP7Oh6VlyqXTXPdNPzOwQ
 dZ+2s4uH7Yi7+LtXx8cQq80YyHvdu3PZe/mc+aw2mwyb0R2G9HGN2Zi2/PlXRKMpotad
 Ndy6vEnmWb5B8DBcNLeJzcrCpCZkmUl7frd0zUsGIq4VC0lV54vil9zmRAim2fcTj+7Q
 K8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788549447; x=1789154247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=D2j2esoh3PkJMJVpD4hZ0fWOSghOOHyL8fLnCQ0r8tw=;
 b=Eow+BPlG19ai2HnNVof8Ma9FDkxiYT11KsgouZPgEdccjfXcmrdHOCztpEQa9aJ95+
 eXE27HQCuRGiKzCJyW+vzqHCQQRLUCSns1/JEEN3d/ou4th9GeQRop4LuTfkFcqCQsVK
 TiPNjfs63hv6p2m7Ymbyw6MvkVu19eu8hKSNbug1+aHYhIaP+UOiAVv+rXmtErfYCWqQ
 sl8LTLGHQu/prGsnKAA93ZGGcfTJBaTu3em/vysKXJbzNF+Z8xzKZshfA8+j+JogpiBP
 /cu+y10Qmb2AqmA+TtKtu+rWAlO9L1jKKUi/fy+ur+Fmdxsade0Aq8z74c1YpLc4qfIG
 iGGQ==
X-Gm-Message-State: AFuF++kAuqhUP0gaXBJ9ADXW3ncZg/vMhCt8klclMYzjBMMKBMJb2gEw
 Gynt2FWzuObXjuD4CCsT5hyZddgRnI0VMEGsWrO5w/0IPxuWbTPVjX0SAY7i3I00pkXjP410r7X
 geQpw
X-Gm-Gg: AYBFou1rJKMeun7t+4XdgP5fGJNLLw79syQJPWS3G9M6J3Wa84TDJh9JvSk4hXAvacI
 EBlEumjX+0tuWquQEFrS2o+LrohtZZ8nSGboB4+7nRGADeE17X2NCEljUgbvacRMlhKm6PqXWhs
 1T/ucVGrZwmlzynUZxAsxrFy9BBKUUy8Y3LUyorjOLaWMEnbU5WmKvKTUkwBfRNYGEiMDvXSK9U
 VpRoNLgXHd/jNsBynZAapyJ3O+g83wyhAw9eo7Hj+cN0dPjlxecycd3/FL9eG7vreh/VB0h5fom
 NTiSDApUEe2UHCZzNpnvJvxY4eJQkVOHTKpkVGQw5Ctm/6OYoFcJgVvq2dx7NYnoZftjPtD6FgQ
 CIPMGvN/uoxQJ7hTYFlxaCZDURyYqBCyolP0BkogovwntPDlRwWZaakLBGdj66NG9BsTfxc2hZE
 jAr+Tp8L1fpH5A3RhBXYPbKrYYvRCt8D9TsRiAlspdRaRKv2o4J+NeV/Lav69KVXuL9DPCbioZL
 ce9vKpKibb9HEmYJKW2Cp1r19s=
X-Received: by 2002:a17:903:1aec:b0:2d9:6db:9fcb with SMTP id
 d9443c01a7336-2db125ca3bbmr114257675ad.11.1788549446890; 
 Fri, 04 Sep 2026 12:17:26 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db1499f07asm13335975ad.57.2026.09.04.12.17.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 12:17:26 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Wenbo Cao <caowenbo@mucse.com>
Subject: [PATCH 6/7] net/rnp: fix register debug log format
Date: Fri,  4 Sep 2026 12:12:41 -0700
Message-ID: <20260904191652.2399074-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904191652.2399074-1-stephen@networkplumber.org>
References: <20260904191652.2399074-1-stephen@networkplumber.org>
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

The register offset is a size_t but was printed with %p, producing a
-Wformat warning at every call site (22 in a full build) when
RTE_LIBRTE_RNP_REG_DEBUG is enabled.  Print it with %zx instead.

Fixes: 18d555f74fcf ("net/rnp: add mailbox basic operations")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/rnp/base/rnp_osdep.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/rnp/base/rnp_osdep.h b/drivers/net/rnp/base/rnp_osdep.h
index 58dcb40f90..a95a37f2fe 100644
--- a/drivers/net/rnp/base/rnp_osdep.h
+++ b/drivers/net/rnp/base/rnp_osdep.h
@@ -90,14 +90,14 @@ rnp_reg_read32(const void *base, size_t offset)
 {
 	u32 v = rte_read32(((const u8 *)base + offset));
 
-	RNP_PMD_REG_LOG(DEBUG, "offset=%p val=%#"PRIx32"", offset, v);
+	RNP_PMD_REG_LOG(DEBUG, "offset=%#zx val=%#"PRIx32"", offset, v);
 	return v;
 }
 
 static inline void
 rnp_reg_write32(volatile void *base, size_t offset, u32 val)
 {
-	RNP_PMD_REG_LOG(DEBUG, "offset=%p val=%#"PRIx32"", offset, val);
+	RNP_PMD_REG_LOG(DEBUG, "offset=%#zx val=%#"PRIx32"", offset, val);
 	rte_write32(val, ((volatile u8 *)base + offset));
 }
 
-- 
2.53.0

