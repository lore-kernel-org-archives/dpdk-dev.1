Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DC8CA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:42:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30A5C42F0F;
	Tue, 29 Sep 2026 18:39:37 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id 2B2B942EB3
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:44 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 d2e1a72fcca58-85469e25400so1771649b3a.0
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699923;
 x=1791304723; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MmMbdsh3P+qk5LKVBZzXqaxc8DUl9nD27h64Y2ZyBIw=;
 b=jIXBmlexJW2ywejnRKw7V4TFBXPkXJGDGqy8mtwsENP9E93fndpVKIPK4HcTYxTtQ2
 LEK9v3gFC0s9QaSE4qh76Dp6ii866i3X62myiaFv1+MSC8sK++xMOYgmTl311NY+2sNw
 KEynUPDOFc0Ez8//PE7lU8+h7dWCdgk7ZZMgovlNOogYv4d1RLd59hJDWeodIr8eFcK3
 ckbcWrYWsGkXb6xlcXFQusZ0O6h9oK0yTRfRZ/xatw06Mxr9sQTT8rLIQ876qd09RQ/E
 B8uSOE6OGa5us5hkk95PQQwGfjcM33ZoZFN3osivQQH6nT1MsJCGT7K4xIH61YaW9Xnw
 hOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699923; x=1791304723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MmMbdsh3P+qk5LKVBZzXqaxc8DUl9nD27h64Y2ZyBIw=;
 b=Qo3Cme6YJUiZ57q+HBGOyeX1rMdldvb9Ur4Z4mKjMDCPEtgTeTEkp8WmT7ba/hal0K
 5XZC9ea9+c4tAPCyFBFXVOjsOJpk6DhPQcm8RPXZ65vw0c/kiA5UWj/fgcPXDhOWyhKp
 UbJoZlllSwBNItpaDY5cEjwD60gw/KDIfsQVfj5p32gXFn2fBLqxHeGx/JWg4FdAK4u/
 p/UEazLh0PKhnGASbCt6L/6GAyn1Vh/PRMQO82Ku9dK7fZNGmSIo3GAL6U8iGP0T4/X4
 PyCYz7cfJTJVoZAWtJh+Z7fMl4duUBL3D2p4bR9v8VHXjnIVzAOj+o1qpPw4Sgwflx+L
 j6Fg==
X-Gm-Message-State: AFuF++k2JnEAb5Szsriyg9//braAud1/lkDiQ75fPiGu8IRgXbP3wRmW
 bxbDroAMNkpUlKpfVEGNxRSacwcGe0MZTIueL0Q7yAyEevt75WwAfZTqVpzJN9aTdaa01AKW/ox
 Ia4iZaVk=
X-Gm-Gg: AYBFou13nleDTBL0phFNDO+mWsKs785bedNOzEJwv1Jw+Ukkf0HXdP+9fF1QbDOGvb6
 5ykbDcGDcH0Bqbtf6hpWdHDf027miMC4SOOepa+Cjlo2U03xqDPsBmIs61MfQyWL8acZy1k5S41
 vgPdHz4pnz+vqUf2KUMAWDLQWSTZrgp9lYWHlVYHDScqXAG8WuqNrbLk6WO4ZVahYgCt1sTw/PO
 1nz0HNwFkCkLdC46cmokRhEcQ38FswXn552yRf7/QXttSGMUpvDdHonofN3M+mqGR96U9FmgFU6
 fs/2mjlTx5HhzQg/Scrs5PlP7KDJ9iU91ti4CYcav9ZQdQOfxFg+nRUV72s+aPtdu5JzGohY0yF
 8x7kmy8FaD+StDxLlPE0dKLt8x/uDL9sHlDvRq6Ixo7PeLjMGXEB6PhQxJjiFBT9T6dNg1pCivN
 vxyN/uNG1oIVBsCgR3uEehN5KuNWd8bictwfmj20ij4zxB0PJz14gz8minvMNznfFPVaLamXBdz
 u8n0zdYgzQeCYsIhWmGO6pHGbNdmVP0OY++ow==
X-Received: by 2002:a05:6a00:2a0f:b0:874:705d:f642 with SMTP id
 d2e1a72fcca58-87e9b89664emr12951069b3a.36.1790699923322; 
 Tue, 29 Sep 2026 09:38:43 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:42 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gagandeep Singh <g.singh@nxp.com>, Sachin Saxena <sachin.saxena@nxp.com>,
 Vanshika Shukla <vanshika.shukla@nxp.com>
Subject: [PATCH v2 39/61] net/enetc: use kvargs numeric helpers
Date: Tue, 29 Sep 2026 09:36:42 -0700
Message-ID: <20260929163800.1108305-40-stephen@networkplumber.org>
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

The VSI timeout and delay arguments are parsed with strtoul() without
checking the end pointer, so a value such as "10abc" is accepted. They
are also assigned into a uint32_t before being validated, so a value
above UINT32_MAX is truncated and only rejected if it happens to
truncate to zero.

Report the offending string rather than the truncated value, which was
not meaningful once the conversion had failed.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/enetc/enetc4_vf.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/net/enetc/enetc4_vf.c b/drivers/net/enetc/enetc4_vf.c
index 6eb1e5d760..fd985c85c9 100644
--- a/drivers/net/enetc/enetc4_vf.c
+++ b/drivers/net/enetc/enetc4_vf.c
@@ -2012,28 +2012,30 @@ enetc4_vf_dev_init(struct rte_eth_dev *eth_dev)
 			/* parse optional VSI-PSI timeout devarg */
 			val = rte_kvargs_get(kvlist, ENETC4_VSI_TIMEOUT);
 			if (val) {
-				errno = 0;
-				hw->vsi_timeout = (uint32_t)strtoul(val, NULL, 0);
-				if (errno != 0 || hw->vsi_timeout == 0) {
-					ENETC_PMD_ERR("Invalid VSI Timeout value = %u",
-							hw->vsi_timeout);
+				uint64_t num;
+
+				if (rte_kvargs_to_uint(val, 1, UINT32_MAX, &num) < 0) {
+					ENETC_PMD_ERR("Invalid VSI Timeout value = %s",
+							val);
 					rte_kvargs_free(kvlist);
 					return -1;
 				}
+				hw->vsi_timeout = num;
 				ENETC_PMD_NOTICE("VSI timeout set to %u", hw->vsi_timeout);
 			}
 
 			/* parse optional VSI-PSI delay devarg */
 			val = rte_kvargs_get(kvlist, ENETC4_VSI_DELAY);
 			if (val) {
-				errno = 0;
-				hw->vsi_delay = (uint32_t)strtoul(val, NULL, 0);
-				if (errno != 0 || hw->vsi_delay == 0) {
-					ENETC_PMD_ERR("Invalid VSI Delay value = %u",
-							hw->vsi_delay);
+				uint64_t num;
+
+				if (rte_kvargs_to_uint(val, 1, UINT32_MAX, &num) < 0) {
+					ENETC_PMD_ERR("Invalid VSI Delay value = %s",
+							val);
 					rte_kvargs_free(kvlist);
 					return -1;
 				}
+				hw->vsi_delay = num;
 				ENETC_PMD_NOTICE("VSI delay set to %u us", hw->vsi_delay);
 			}
 
-- 
2.53.0

