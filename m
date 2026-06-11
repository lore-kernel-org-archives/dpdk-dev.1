Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A363CD8C9D
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 21:21:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD310433B0;
	Thu, 11 Jun 2026 23:21:25 +0200 (CEST)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173]) by mails.dpdk.org (Postfix) with ESMTP id 0AF434025F
 for <dev@dpdk.org>; Thu, 11 Jun 2026 23:21:23 +0200 (CEST)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-304cf518c9dso571911eec.1
 for <dev@dpdk.org>; Thu, 11 Jun 2026 14:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781212883;
 x=1781817683; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Gn3gFQXpq4iyaHAkrxZNnSnHGrS+mINVxQJkj91pI8=;
 b=xFwEUmgI4DpUOKtCN/mhjDd32n5FBeL8lPkQUhA/kd7hb8q179/72agg1z64mFqxPf
 9V4uIzcO/uCZy1uGag7AGhUg2KorXfIrKZcVZoFZyL7Lw2xSpOlvDevr0Qvr/DanEKRP
 u6zyKlx0/G5lkuTP4vNax/2/D38QFT5ZI9Ypn0Ny1HxjmBEa2stDepeQzhnjgVgb1V4n
 8EkFni/+EFVzP1mfqqyl7+2CS1BRCrmCRxIap2gQZvYaJpVo9dw7aZ+xUsneD/Q7qNti
 bmXA4GAIeW76v/YTQ6zHnh7StKR8E+gKlrTGfNa3U7aJqUtm2S01VfdBCfBjuoteSGBi
 wBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781212883; x=1781817683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5Gn3gFQXpq4iyaHAkrxZNnSnHGrS+mINVxQJkj91pI8=;
 b=IY0jQnwOUL59aQjSTLZLzuXKckERVm7+S9TpXqJiJn9iv4s6cuunzzK3hXYWK9eZCe
 CHjWFhGn9RIkmXKp+dVa0lEy3Dxa3WGvjkQejlVAenn7UypQFGEMxprR0R2Y4ygoWAdh
 C5SFh1KhGtCWoC6Txqm9TvLPzBv/5JsaKUDJlaBK4NpFpEN6YIAonmE2dPX03bP1iTk0
 F7qrpQQHtbLVwzfGHrXWtebyhH/Pp8wVIiqxTiXpBYptSDASDT9EYHQffFjSfeAdLCFt
 jC9AP9BByjZ1trMiojwtrR93D58M7Oz3SaBVaH3k4bxYozBPx47huMQ6CtORLxiyJ1bt
 htpA==
X-Gm-Message-State: AOJu0Yy7+uzO23D4Tj3+t+XC3W4ZtqLNXjbZckrxNrZRFWgjURObylea
 NF6UcCWa30B3lTkNTkgAOzM0IU/JWzxTwjTMDS2m8sruCnNzo6yJv4bfnGIoZrLGaEFPQdmoI9O
 hdCBJ
X-Gm-Gg: Acq92OFnaqUWQicyA8bSg9DLliUSpvJU1NXHGLujBRAIocHwHZHKSSiy9YrnF8Jsl5R
 sTdIGZ9i/+HmkUICt2axnlqb/6U7EO8klm4SGF77QQ/Am0fDrYIDVoJzqmH2PW1+u1xpo5+1kYj
 PYK+M6BWMpnAiRlTklvfX0RaqVFcsMuQROknhg5lzsejGbzcdPgskHjOrhau7HvI6ZNzcComQgE
 ++h9fu8+3yrAr6ajswAcy5XFyq0K9Oie81VLGdbnwmJYSBaxO9vCeR/PcaYI2yeo8ds+R2qwpfZ
 AIcDqtwk3qaudy+hNmKF1i4M7ba0v0xSZ2sO4rjmtYjD4JO9x4DDWLJlYnmV3qaOpIbklAPK74+
 n7K9Vw1fStQPNvHDH1MusXpB84xo3FLZZJUS6Q5FW+UveEA6sepqDxgErLE+D2y9XUDhQck0+1H
 GSJIwNRkbFN+oAKZMAW5hagIHXE0oKyfK+uy9Kdhahc0Hbp6vT+dn95CuoNiMu0Q==
X-Received: by 2002:a05:7300:7490:b0:2f1:496c:94d4 with SMTP id
 5a478bee46e88-3081ff4b292mr45199eec.4.1781212882470; 
 Thu, 11 Jun 2026 14:21:22 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081eb95450sm546238eec.28.2026.06.11.14.21.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 14:21:22 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 00/15] doc: clean up sample application guides
Date: Thu, 11 Jun 2026 14:18:39 -0700
Message-ID: <20260611212119.1026721-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20250216230903.124496-1-nandinipersad361@gmail.com>
References: <20250216230903.124496-1-nandinipersad361@gmail.com>
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

This series revises the sample application user guides for clarity,
grammar, and formatting consistency. Changes are documentation only:
wording is simplified, command-line options are normalised, Linux and
Ethernet capitalisation is corrected, and definition lists replace
ad hoc bullet lists where a term/description structure fits.

This work started from edits by Nandini Persad and was extended and
reworked across the rest of the sample application guides.

Stephen Hemminger (15):
  doc: cleanups to bbdev sample application
  doc: cleanup cmd_line example documentation
  doc: cleanup the distribution sample application guide
  doc: improve structure and clarity of compiling guide
  doc: improve clarity and consistency in DMA sample app guide
  doc: correct capitalization and formatting in ethtool guide
  doc: improve clarity in eventdev, FIPS, and flow filtering
  doc: enhance hello_world, intro, IP frag and pipeline
  doc: improve IP reassembly, IPsec, multicast, and keep-alive
  doc: enhance L2 forwarding sample application guides
  doc: enhance multi-process, NTB, ordering, and PTP guides
  doc: improve QoS, callbacks, EFD, and service cores guides
  doc: enhance skeleton, pipeline, timer, and vhost guides
  doc: improve vhost, VM power, and VMDq sample guides
  doc: correct grammar and punctuation consistency issues

 doc/guides/sample_app_ug/bbdev_app.rst        |  73 +++--
 doc/guides/sample_app_ug/cmd_line.rst         |  37 +--
 doc/guides/sample_app_ug/compiling.rst        |  84 +++---
 doc/guides/sample_app_ug/dist_app.rst         |  52 ++--
 doc/guides/sample_app_ug/dma.rst              |  60 ++--
 doc/guides/sample_app_ug/ethtool.rst          |  18 +-
 .../sample_app_ug/eventdev_pipeline.rst       |  51 ++--
 doc/guides/sample_app_ug/fips_validation.rst  |  65 +++--
 doc/guides/sample_app_ug/flow_filtering.rst   |  51 ++--
 doc/guides/sample_app_ug/hello_world.rst      |   8 +-
 doc/guides/sample_app_ug/intro.rst            |  34 +--
 doc/guides/sample_app_ug/ip_frag.rst          |  46 +--
 doc/guides/sample_app_ug/ip_pipeline.rst      | 109 ++++----
 doc/guides/sample_app_ug/ip_reassembly.rst    |  57 ++--
 doc/guides/sample_app_ug/ipsec_secgw.rst      | 128 ++++-----
 doc/guides/sample_app_ug/ipv4_multicast.rst   |  26 +-
 doc/guides/sample_app_ug/keep_alive.rst       |  12 +-
 doc/guides/sample_app_ug/l2_forward_cat.rst   |  34 +--
 .../sample_app_ug/l2_forward_crypto.rst       |  70 +++--
 doc/guides/sample_app_ug/l2_forward_event.rst |  20 +-
 .../sample_app_ug/l2_forward_job_stats.rst    |  46 ++-
 .../sample_app_ug/l2_forward_macsec.rst       |  38 +--
 .../sample_app_ug/l2_forward_real_virtual.rst |   4 +-
 doc/guides/sample_app_ug/link_status_intr.rst |   2 +-
 doc/guides/sample_app_ug/multi_process.rst    |  49 ++--
 doc/guides/sample_app_ug/ntb.rst              |   4 +-
 doc/guides/sample_app_ug/packet_ordering.rst  |  42 +--
 doc/guides/sample_app_ug/pipeline.rst         |  26 +-
 doc/guides/sample_app_ug/ptp_tap_relay_sw.rst |   2 +-
 doc/guides/sample_app_ug/ptpclient.rst        |  51 ++--
 doc/guides/sample_app_ug/qos_metering.rst     |  11 +-
 doc/guides/sample_app_ug/qos_scheduler.rst    |  16 +-
 doc/guides/sample_app_ug/rxtx_callbacks.rst   |  11 +-
 doc/guides/sample_app_ug/server_node_efd.rst  |   4 +-
 doc/guides/sample_app_ug/service_cores.rst    |  67 ++---
 doc/guides/sample_app_ug/skeleton.rst         |   8 +-
 doc/guides/sample_app_ug/test_pipeline.rst    |  17 +-
 doc/guides/sample_app_ug/timer.rst            |  19 +-
 doc/guides/sample_app_ug/vdpa.rst             |  51 ++--
 doc/guides/sample_app_ug/vhost.rst            | 178 ++++++------
 doc/guides/sample_app_ug/vhost_blk.rst        |  66 +++--
 doc/guides/sample_app_ug/vhost_crypto.rst     |  64 ++---
 .../sample_app_ug/vm_power_management.rst     | 262 ++++++++----------
 .../sample_app_ug/vmdq_dcb_forwarding.rst     | 101 ++++---
 doc/guides/sample_app_ug/vmdq_forwarding.rst  |  38 ++-
 45 files changed, 1121 insertions(+), 1091 deletions(-)

-- 
2.53.0

