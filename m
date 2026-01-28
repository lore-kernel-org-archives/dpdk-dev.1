Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A62D46BF9
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 19:48:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3A2B40B9D;
	Wed, 28 Jan 2026 20:47:45 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id 0816A40B8D
 for <dev@dpdk.org>; Wed, 28 Jan 2026 20:47:41 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4801ea9bafdso864075e9.3
 for <dev@dpdk.org>; Wed, 28 Jan 2026 11:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769629660;
 x=1770234460; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QWqIUCdHuYX9YPREBYZ/qr+rIpVsIuvKlb2gFyCYpY0=;
 b=KQV7pBlUF5Tz0MUS4OhVL/U5wkBLgp7mVnS7WlmY1MKJzttiOpYaQRxX16dKRMBMBR
 l2PKXlt1Bh1ZyhhqFTskk0gAClwalW24QSsUHkOTRHKtZkg9Gual7N7TvpgsF6X7KCqH
 rinDkES3nV50UhjdyXH3Ie7GVldQI1yRn3IzpXobTEpFCVnHU1GXEPGE2x5FimfC79Ot
 tga6ZMjbO0l7hzwR5299Hz467P/nknhYSOV9NNEasPWQzhmnLz10XRdbGLQq94bQA2PL
 fDMSzX9R1Id/79BDly9yKMkuzSsJj9nCAAcIG24y41fNn4Y4UOqpbN9+u6pklwmBCK4B
 JgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769629660; x=1770234460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QWqIUCdHuYX9YPREBYZ/qr+rIpVsIuvKlb2gFyCYpY0=;
 b=Ye1ZCyVOmx8spiadgj8TwyIFddhzvhpH1hozjqYrjm/6NlXGnwgEtqyMjvFZ0aZSdm
 2hMmFnMncQj5E9ptvgfKt4XEP2LmeSfXgYjui5vH4tDAhFdCy3qjDw+5EhaKh8R2n2az
 nxgSZfeTmK4LOs8IrTvVx56p3eZDtrQh7zb6pFAS4Z1G0Fzm+siPQ7TI1/V9ni2LSfPe
 LRrqW42fnb5b3ApgDRAt0w64qP4v+d5V+I4IfP2C40N1jYCVoWzfiXsUm0bMuVITAPmo
 ZFs9aK/Vz9qdIkb0Yq9ev92JxMqY3a2V5a9ibSoG9dD+YryRe+qV6yPGeQBEcCb0w/qB
 pa+g==
X-Gm-Message-State: AOJu0YwXbnGlHLBYBfMNJanac8TCqgJiZDa69avJxr/3sO30VX7KvT/z
 NxmeXv4nIZhyk51cRyEAf6J43buh8z4Zirvq8U6G183NwtO+5//3EiLNv+KQC5D60+gm3hfrv0k
 gN4kM
X-Gm-Gg: AZuq6aJETAAgEf/efroFe3y/FUAIUNMYyz2/d2/u+b+Y6lP+FqquxMATV3SNhR1ArEf
 ZMJBaYlHMjOSZI2/0UyZrDz9CeNJ+nS3edKaWgYEb4Qu3LqMsOn6nQEZrpRYadD4S/nCali/FIk
 z8k1g+/bM3S46kuiXVHv2+PlQliRJ3P/WiPNVjJfiDlYdkQ0CIIqvtA5SVBjBw00Azpfz3ktnTb
 JSxH81g4Cq5D04qJMIdVVGSPnwjdwkIgkLGwDmyreyS0wgjUWfYgkaxiQcHlW1vf8kvhXlnpDlf
 Kna0qDegiFA+7dG+XTzvy96pg6g7dHJF4Crc+76RBKurVAPNq6yrTk950PaIu0g7d4BY9AOoZig
 X+x0uBU1eoVzBG0S84MAVZFNWqCXloL19YNvZa3r3cKpo2nPuloKKuLbR73P8oESi0OvdH7sQ5l
 j7T53HKfr2Er0n+K61mPfVshsQt/RpekPcH3sLUQRtmtDJyajCyg==
X-Received: by 2002:a05:600c:608e:b0:480:1b1a:5526 with SMTP id
 5b1f17b1804b1-48069c167d2mr95532545e9.16.1769629660549; 
 Wed, 28 Jan 2026 11:47:40 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e1354205sm9601438f8f.41.2026.01.28.11.47.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 11:47:40 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH v2 8/8] doc: correct grammar and improve clarity in MTR guide
Date: Wed, 28 Jan 2026 11:46:07 -0800
Message-ID: <20260128194722.480862-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260128194722.480862-1-stephen@networkplumber.org>
References: <20260116213100.110419-1-stephen@networkplumber.org>
 <20260128194722.480862-1-stephen@networkplumber.org>
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

Correct grammatical issues and improve clarity in the traffic metering
and policing documentation:

- Correct grammar: "override the color the packet" to "override the
  color of the packet"
- Correct typo: "show" to "shown" for correct past participle
- Standardize terminology: use "color-aware" and "color-blind"
  consistently with hyphens as compound adjectives

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 .../prog_guide/ethdev/traffic_metering_and_policing.rst   | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/doc/guides/prog_guide/ethdev/traffic_metering_and_policing.rst b/doc/guides/prog_guide/ethdev/traffic_metering_and_policing.rst
index 7f9faf36e2..de8d643fb1 100644
--- a/doc/guides/prog_guide/ethdev/traffic_metering_and_policing.rst
+++ b/doc/guides/prog_guide/ethdev/traffic_metering_and_policing.rst
@@ -47,15 +47,17 @@ Traffic metering determines the color for the current packet (green, yellow,
 red) based on the previous history for this flow as maintained by the MTR
 object. The policer can do nothing, override the color the packet or drop the
 packet. Statistics counters are maintained for MTR object, as configured.
+object. The policer can do nothing, override the color of the packet, or drop the
+packet. Statistics counters are maintained for each MTR object, as configured.
 
 The processing done for each input packet hitting an MTR object is:
 
 * Traffic metering: The packet is assigned a color (the meter output color)
   based on the previous traffic history reflected in the current state of the
   MTR object, according to the specific traffic metering algorithm. The
-  traffic metering algorithm can typically work in color aware mode, in which
+  traffic metering algorithm can typically work in color-aware mode, in which
   case the input packet already has an initial color (the input color), or in
-  color blind mode, which is equivalent to considering all input packets
+  color-blind mode, which is equivalent to considering all input packets
   initially colored as green.
 
 * There is a meter policy API to manage pre-defined policies for meter.
@@ -105,7 +107,7 @@ traffic meter and policing library.
 
    * Adding one (or multiple) actions of the type ``RTE_FLOW_ACTION_TYPE_METER``
      to the list of meter actions (``struct rte_mtr_meter_policy_params::actions``)
-     specified per color as show in :numref:`figure_rte_mtr_chaining`.
+     specified per color as shown in :numref:`figure_rte_mtr_chaining`.
 
 #. The ``rte_mtr_meter_profile_get()`` and ``rte_mtr_meter_policy_get()``
    API functions are available for getting the object pointers directly.
-- 
2.51.0

