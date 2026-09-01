Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE2AC61DD6
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 20:33:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C82840DF8;
	Tue,  1 Sep 2026 22:32:53 +0200 (CEST)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by mails.dpdk.org (Postfix) with ESMTP id 7648540B99
 for <dev@dpdk.org>; Tue,  1 Sep 2026 22:32:52 +0200 (CEST)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-cc1c9879395so314431a12.1
 for <dev@dpdk.org>; Tue, 01 Sep 2026 13:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788294771;
 x=1788899571; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RJONKkrtggm9TA1sCy1CydwvjAcEyEUNI9C0Xwl5XGU=;
 b=x2rtey3TKaNeIeNIQ1X9UMHdLdK9O5J1Gqqaeww//vkBzISuiGNfSx6A7pz9DRvZ52
 8TJdCasbf/pK754wuA649S21NCHMGf1gq4BMYKpvJQhMuI42cAnp2+Xi3E2DmRii9dqd
 nv9S7Q0skH8YZvhInDTC0wYMKaSXoV/mJaBzNFzRFydNlRjOLOGTtGjV4IjAngbuogEe
 61nGmNoTFCv6VXmgAEUxoersfuhnLVP555x0ci90n7i71k4w+GcathtWTpve5ak1Z7Hh
 fJ7TO3jInfrsqPxiHnRYwexc9UvUxTum48nggzICXs9zrzkrES9KE6JwmCUVn9BWKLWE
 MQHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788294771; x=1788899571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RJONKkrtggm9TA1sCy1CydwvjAcEyEUNI9C0Xwl5XGU=;
 b=e5JRiTdxlwDKlBsxbGGOouToP7ct/puLgMbL08u+s1/x/IcZfYVxz1DkqZ3l1C33+I
 H4gYPOq7nCOjawtrse+jRY5GclMtZVLocNrrp04vfCQTf/dhsYU37Z+McTDujPMqR1Mq
 1DoJyCAV4+tE+BsXryEqY2fYJvdfMo5Z6T4DgtLAfWUqhyIPuw2ur33V6KbcL+5ZcZGx
 ApfZwfvrgYOl9mC8VT4act1vPm2fzKb13uChtrGiadOOc+9Bz0+5/XNMdUeffmSgmJL8
 UTYD0Mr1fMH4Ho9PVGvfPurTuifdQX2Voe8aM9ZE2qe81fAe3OFnd+0JpTiET+Za/SGc
 jSWA==
X-Gm-Message-State: AFuF++kQw7usxVtje4aO2BoSq8g4N7tMOxQKB2Sx+wvw3khv9D+IpFWr
 GByxcdo534OUJkE9VdmUpYXQbcN97/2909uk7IxHpGEKATPi33X6OtuL5PNxGCrFfjdvFcBZxfF
 uLpWe
X-Gm-Gg: AR+sD10H+HnDakZR6OpGN/UYHfWEJCQq8iw7j5iXyiPI54bS+t8tS2haV3FAiCZomQI
 MyOm/AHhEyaL0T6Kug98HNU2kYazfvtCRo8bJCGVF+gpD+87bDLEcnWb+iSMchrOIb07OOvm2TQ
 8FGOfJOMb+sS4H7kfhEZT6GOuG3ZreUOzVXxjHS0z0jIWPsemGOqS/1m5kMYleRQ6Sgsc6EiY+D
 4qi7yaeROLHkfjGortW4AUmPMoxACH4LO6rXnjQfsoyM2NpNKQ4rA58ijN2G8cjSW4la7cLzDuT
 4r0f5EA1fZR8cyk2VSI5x6Fb4sKpSkE3C8fyU5zQdmm+J249hThYr13ClxwEvb0MjlKGtdxGQdL
 iyedNgQol3RPEhyIl/I/WxbE1uIVs6mFCHe7U5S0n3MoMQ+7ourOXN8usQjqbAqIVAYIhIyN960
 BhgEC4hQBz/dGgVEw35KYFQgyjebb1Fuf7vARZov/uXtkyRSFa0Rltyv5fcJ0sOU+zjqTc/mIvs
 PCt25YeSQPPooeKM3ybrrqRw1k=
X-Received: by 2002:a05:6a00:4f92:b0:857:73e2:9105 with SMTP id
 d2e1a72fcca58-85ed94bb426mr423282b3a.21.1788294771441; 
 Tue, 01 Sep 2026 13:32:51 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-85dc0bffbc1sm323980b3a.48.2026.09.01.13.32.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 13:32:51 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 06/22] ethdev: promote FEC API to stable
Date: Tue,  1 Sep 2026 13:23:05 -0700
Message-ID: <20260901203217.1485915-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901203217.1485915-1-stephen@networkplumber.org>
References: <20260901203217.1485915-1-stephen@networkplumber.org>
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

The forward error correction API was added in v20.11 to query the
supported FEC modes of a port and to get and set the current mode.
The three functions have kept their prototypes since, and are
implemented by several PMDs.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst |  1 +
 lib/ethdev/rte_ethdev.c                |  6 +++---
 lib/ethdev/rte_ethdev.h                | 12 ------------
 3 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 57a47ec5f2..c4a9053b59 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -108,6 +108,7 @@ API Changes
     ``rte_eth_hairpin_get_peer_ports``
   * clock: ``rte_eth_read_clock``
   * flow dump: ``rte_flow_dev_dump``
+  * FEC: ``rte_eth_fec_get_capability``, ``rte_eth_fec_get`` and ``rte_eth_fec_set``
 
 
 ABI Changes
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index ce1779ba44..d814ee55f9 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -5288,7 +5288,7 @@ rte_eth_led_off(uint16_t port_id)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_fec_get_capability, 20.11)
+RTE_EXPORT_SYMBOL(rte_eth_fec_get_capability)
 int
 rte_eth_fec_get_capability(uint16_t port_id,
 			   struct rte_eth_fec_capa *speed_fec_capa,
@@ -5316,7 +5316,7 @@ rte_eth_fec_get_capability(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_fec_get, 20.11)
+RTE_EXPORT_SYMBOL(rte_eth_fec_get)
 int
 rte_eth_fec_get(uint16_t port_id, uint32_t *fec_capa)
 {
@@ -5342,7 +5342,7 @@ rte_eth_fec_get(uint16_t port_id, uint32_t *fec_capa)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_fec_set, 20.11)
+RTE_EXPORT_SYMBOL(rte_eth_fec_set)
 int
 rte_eth_fec_set(uint16_t port_id, uint32_t fec_capa)
 {
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index 7905e01658..41a744059c 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -4455,9 +4455,6 @@ int  rte_eth_led_on(uint16_t port_id);
 int  rte_eth_led_off(uint16_t port_id);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
- *
  * Get Forward Error Correction(FEC) capability.
  *
  * @param port_id
@@ -4482,15 +4479,11 @@ int  rte_eth_led_off(uint16_t port_id);
  *   - (-ENODEV)  if *port_id* invalid.
  *   - (-EINVAL)  if *num* or *speed_fec_capa* invalid
  */
-__rte_experimental
 int rte_eth_fec_get_capability(uint16_t port_id,
 			       struct rte_eth_fec_capa *speed_fec_capa,
 			       unsigned int num);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
- *
  * Get current Forward Error Correction(FEC) mode.
  * If link is down and AUTO is enabled, AUTO is returned, otherwise,
  * configured FEC mode is returned.
@@ -4507,13 +4500,9 @@ int rte_eth_fec_get_capability(uint16_t port_id,
  *   - (-EIO) if device is removed.
  *   - (-ENODEV)  if *port_id* invalid.
  */
-__rte_experimental
 int rte_eth_fec_get(uint16_t port_id, uint32_t *fec_capa);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
- *
  * Set Forward Error Correction(FEC) mode.
  *
  * @param port_id
@@ -4533,7 +4522,6 @@ int rte_eth_fec_get(uint16_t port_id, uint32_t *fec_capa);
  *   - (-EIO) if device is removed.
  *   - (-ENODEV)  if *port_id* invalid.
  */
-__rte_experimental
 int rte_eth_fec_set(uint16_t port_id, uint32_t fec_capa);
 
 /**
-- 
2.53.0

