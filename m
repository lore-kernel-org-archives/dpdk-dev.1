Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC47C53219
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Jul 2026 17:58:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 744B140A81;
	Wed, 29 Jul 2026 19:57:32 +0200 (CEST)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id B8AB04069D
 for <dev@dpdk.org>; Wed, 29 Jul 2026 19:57:27 +0200 (CEST)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2ccf2360620so12565205ad.3
 for <dev@dpdk.org>; Wed, 29 Jul 2026 10:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785347847;
 x=1785952647; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Mn7lrq+LkN28NC/bDIhP5Evsk3JaZUtcylXImrZI/40=;
 b=KXobudThyJF2oI+fQTcfBauuJaEihF1/uPqDBCZCi3XWQB2NHiCIDHV+o/GQFsnhEM
 qtBBskOhv3rWUKQoCPqh9rsfFhIfgnFX0iqr6tbaK+CHnIa06sD2yKoda66uykXKk7sJ
 rVQ670DKYNRJSszVKnq/IGbaV/7m89UcHCWFOfD/o7y5ghbgd2foURKyHeQFI5DEHAUb
 hlm2Mnw7LuMfyyS7RUu/RvyxS2NCP/rPC9CPGRElwGO/7DJpVkczEFjxgLSPY37uBj+S
 YTbmcV/4rYQZSaC1NBgHRSh+ED7s+R4NBHmxNREambMPhos7q5Gz1bNHdwW+2QdrHig2
 YXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785347847; x=1785952647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Mn7lrq+LkN28NC/bDIhP5Evsk3JaZUtcylXImrZI/40=;
 b=rxOFiCGi2kYPNUuFlpTM5+fsSqdplSKtq7563yg6yMAEagPtOcEiphqmePxVxbevOf
 QPDmAJkf3XzC2VxUa2bE/0cA0tgN+I3XFnOfkWiW9s+FRABBF8JjbgCVNNbqeYHAlfXZ
 Lh3EQmoWecaqx+YmpyHNPHbU4/1k2BqA94ZY/chJuGzIQHZuERfSidty80y/l/zbGuMf
 QSHmqTKEY1gtfub+PKLTiryIkeZGyse2mSCH8RUGFWtt16QsL6KLSH83hjRlDnVyTqKf
 p5DCv78/HmIgGKJdNdeERFlNAQAjjjKn99+fI2lQPFemsY1tZCPMSiOsuw/NP7FY5yVg
 nk9Q==
X-Gm-Message-State: AOJu0YyZVVXK+p/ztAmRhLXqtmzxRBe/SJyFF32vT/dRKeEc3VLq1I4M
 7epn9369cn6AcVNbe9taYv8RJcdr6xYsXfmfI5VVi1mnmjzZuJlxusUyyztg1OmwX8T1brIRJMS
 1GnPF
X-Gm-Gg: AR+sD10rPAz9WgwCfj8SevtjT1y9i/zdGpA89ROJq+ya/Cd8b2pV7Ax9VPkyWX97vre
 ykFb+eKAoae898L2u+e8rlF2Hxonmp6ntJ6ZH8qavr39byq4pUZArsv7pYFUEGV+AirJ58cgLJM
 R0J1qsBbvu+CEuKBFe1HG8ntHlCz2hNFe2DKm9ZO8TsAsQIxkw9nholUsAbEAuHWYpKF4K+M34D
 bNd/ra7susZez6VGA450u6H0JqpOT/brEOYv++YWqCR9y6Ew+3CZomHPUYbpG/ClunnRsVFPs2B
 bYIgR9VZayXVm4FmjAZL+j8AzaJA8/9SuAS3LOvhGPOe+tBCTmIGjSbwLQeNxfKEUVrDUDgUa8A
 LBlqcuoQZfo9Gk1lBmIIA5P+63JnqT8IisZw6nAsu/HhTIlUinHaFfEP7XqmB1fVElyPYrsgtHm
 gfmueqgYLbdiV8zF8o9isbfr16iw7CC3o4T6Kn9CqNAFIp0ytT9eVW5CPfVf863iSAfyLTVt4hi
 uDUqtSNsyXgeUdLbjlwDMmNcRc=
X-Received: by 2002:a17:902:ced1:b0:2cc:777f:d67c with SMTP id
 d9443c01a7336-2d015ac0089mr86040505ad.13.1785347846922; 
 Wed, 29 Jul 2026 10:57:26 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504b15f77sm13111562eec.4.2026.07.29.10.57.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 10:57:26 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [RFC 08/32] net/intel: replace rte_smp_rmb
Date: Wed, 29 Jul 2026 10:54:01 -0700
Message-ID: <20260729175715.165120-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729175715.165120-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
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

Replace deprecated rte_smp_rmb with equivalent
rte_atomic_thread_fence(rte_memory_order_acquire).

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/ice/ice_rxtx.c     | 2 +-
 drivers/net/intel/ixgbe/ixgbe_rxtx.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index c4b5454c53..6f168e358f 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -1955,7 +1955,7 @@ ice_rx_scan_hw_ring(struct ci_rx_queue *rxq)
 		for (j = ICE_LOOK_AHEAD - 1; j >= 0; j--)
 			s[j] = rte_le_to_cpu_16(rxdp[j].wb.status_error0);
 
-		rte_smp_rmb();
+		rte_atomic_thread_fence(rte_memory_order_acquire);
 
 		/* Compute how many status bits were set */
 		for (j = 0, nb_dd = 0; j < ICE_LOOK_AHEAD; j++)
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index 60222693fe..ce0a3dde34 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
@@ -1549,7 +1549,7 @@ ixgbe_rx_scan_hw_ring(struct ci_rx_queue *rxq)
 		for (j = 0; j < LOOK_AHEAD; j++)
 			s[j] = rte_le_to_cpu_32(rxdp[j].wb.upper.status_error);
 
-		rte_smp_rmb();
+		rte_atomic_thread_fence(rte_memory_order_acquire);
 
 		/* Compute how many status bits were set */
 		for (nb_dd = 0; nb_dd < LOOK_AHEAD &&
-- 
2.53.0

