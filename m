Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC15C83F27
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Jul 2025 21:57:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3F014021E;
	Tue, 15 Jul 2025 23:57:22 +0200 (CEST)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id B337E4013F
 for <dev@dpdk.org>; Tue, 15 Jul 2025 23:57:21 +0200 (CEST)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-23dc5bcf49eso73377785ad.2
 for <dev@dpdk.org>; Tue, 15 Jul 2025 14:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752616640;
 x=1753221440; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KoBvYwIRpE32Fw8FcbPbyto/X3axUCRn8FrgZBTiAs4=;
 b=ujsDlbRRoTMoAp8lGZGI0Vt8s1w6MsT9HcYcCnMIOwEGvsqt/goVPTc4OXvzSt53F0
 6K/ogbEE9vZSg3fIPajuzHDb4y/3wmFU7fQB8YPUaaWQ/yNS2CJYD9s/zSzNiuTNcz+h
 AHzsEmOhZsTFeIRYGL6WlSFD61Lznju0rg1MQbgqIBR02tzkl5UiG88JCrTJn+5E8mNq
 5gEVw4CJs1ECbOIcjf8eE7detw/V3/Q7xk6HENwt9lnJm9HV0FioTz9URAwpHCqMUz/S
 ATtpZVZB8siWQ4FK1wIQUs10sH6uXIZhIed98wg9eXkMnRk6k0nl0bApkEi+Xa73TPgK
 XVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752616640; x=1753221440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KoBvYwIRpE32Fw8FcbPbyto/X3axUCRn8FrgZBTiAs4=;
 b=JwNT6SNSQ9i5GXVoazyVD2+saIq04o3rdOb8XHbQSJ+2Gvm8dB2dz1i5+FksG13huY
 eURXOkanhnkMk0nbLBmJLn0SWlfvcR78lD1BANNQ3YjjdJ/kE/pQnuxjMn+ijaseLJTM
 DG5ZftmP4aOPHGn6l0nN+zRyI27FSIs37xXlYO8r+qszvJtBoVvwIR9mzXYsNwacwoJw
 lbPJQX4oDzhO82rZU/y6jKj3G3jwrN1Lt1lZM3PEA0RRul/bsg8kxz3qKAfzbbKvkOWV
 mQg3Jr0UVQdpK0OsmZXPV37yL7cYyyrK5iCkt9a0KaPMuG663xMMp84dfXMqcDFJ8Z/X
 QRlw==
X-Gm-Message-State: AOJu0YxG45qurg55fiPH9DSWoQwtpdDUOnF4h7FaYPTJ1qwu4fLRldsI
 eGUBofrOJmosU8/qSXzEdPavtuRjui+j2SynlAAIo3xRsdqEOsVLReABoO/FYrp2/t59PPk7bix
 pGA9O
X-Gm-Gg: ASbGncssm8nK0BsLGJT0aLWEBifniIZfBIHr+ulOYPip1B4YtILp0OtP1cIRex3tpb9
 QiPcr7NrCZ02eRJlXlgz9QAcBjTnwlBhEUIBDQjahGsdNssXTVMm7anf5+7xn3d/wjM7J/IqsOb
 h3ogs25ksZ5TwaCtPwTje0PbLY5RWVSh7GwIhkWejpsPKEVKRBTvKS2Y2IaaYxL2OeAm3W3OHWp
 zop8CrgldQmGdoMq5xmRVblEVhWQPg+CNLZFhjcWkQe0Kx19LIjFoaVd5T3aVg0u3gECCyEEzrm
 6WQS+S48qGdS+pAkhKM0Ur0qMPG3NvlImWtn0fzEZicN3+vVmCdp4OpWv3zlY5tEJ3CKKApK9p6
 ASvlUrhueX/zNWqI5QjP3F6/GPvjUFJm7z2iOxiqSJI6z3AbPpqDQKB42IkeitOANpftho9QL+K
 deNA9BE3Y=
X-Google-Smtp-Source: AGHT+IGen+pG7nguoRVfjS5ScR/6NQ9kQ6kbstgEulv0iZuxy43zmYmm8ioOD+6wuqLAc3zPBgrftg==
X-Received: by 2002:a17:902:d503:b0:234:ba37:87b6 with SMTP id
 d9443c01a7336-23e24ed7341mr8837905ad.17.1752616640527; 
 Tue, 15 Jul 2025 14:57:20 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de43228a6sm111538185ad.91.2025.07.15.14.57.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jul 2025 14:57:20 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 0/2] cpu0 and memory channels doc update
Date: Tue, 15 Jul 2025 14:56:27 -0700
Message-ID: <20250715215718.7388-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20240718184326.21375-1-stephen@networkplumber.org>
References: <20240718184326.21375-1-stephen@networkplumber.org>
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

This is revised version of earlier patches to address
some guidance about CPU and memory channels in the documentation.

Stephen Hemminger (2):
  doc: add note about CPU 0
  doc: remove use of '-n 4' option in documentation examples

 doc/guides/contributing/documentation.rst     |  2 +-
 doc/guides/cryptodevs/aesni_gcm.rst           |  2 +-
 doc/guides/cryptodevs/aesni_mb.rst            |  2 +-
 doc/guides/cryptodevs/ccp.rst                 |  4 ++--
 doc/guides/cryptodevs/kasumi.rst              |  2 +-
 doc/guides/cryptodevs/null.rst                |  2 +-
 doc/guides/cryptodevs/openssl.rst             |  2 +-
 doc/guides/cryptodevs/snow3g.rst              |  2 +-
 doc/guides/cryptodevs/zuc.rst                 |  2 +-
 doc/guides/howto/lm_bond_virtio_sriov.rst     |  2 +-
 doc/guides/howto/lm_virtio_vhost_user.rst     |  2 +-
 doc/guides/howto/packet_capture_framework.rst |  2 +-
 doc/guides/howto/pvp_reference_benchmark.rst  |  4 ++--
 doc/guides/howto/vfd.rst                      |  4 ++--
 .../virtio_user_for_container_networking.rst  |  4 ++--
 doc/guides/linux_gsg/build_sample_apps.rst    |  5 ++---
 doc/guides/linux_gsg/enable_func.rst          |  5 +++++
 doc/guides/linux_gsg/linux_drivers.rst        |  4 ++--
 doc/guides/nics/build_and_test.rst            |  2 +-
 doc/guides/nics/cpfl.rst                      |  2 +-
 doc/guides/nics/cxgbe.rst                     |  2 +-
 doc/guides/nics/fail_safe.rst                 |  8 ++++----
 doc/guides/nics/hns3.rst                      |  4 ++--
 doc/guides/nics/i40e.rst                      |  6 +++---
 doc/guides/nics/ice.rst                       |  6 +++---
 doc/guides/nics/intel_vf.rst                  |  2 +-
 doc/guides/nics/ipn3ke.rst                    |  4 ++--
 doc/guides/nics/mlx4.rst                      |  2 +-
 doc/guides/nics/mlx5.rst                      |  2 +-
 doc/guides/nics/null.rst                      |  6 +++---
 doc/guides/nics/pcap_ring.rst                 | 18 ++++++++---------
 doc/guides/nics/qede.rst                      |  2 +-
 doc/guides/nics/softnic.rst                   |  2 +-
 doc/guides/nics/thunderx.rst                  |  2 +-
 doc/guides/nics/vhost.rst                     |  2 +-
 doc/guides/nics/virtio.rst                    |  2 +-
 .../link_bonding_poll_mode_drv_lib.rst        | 10 +++++-----
 doc/guides/prog_guide/mempool_lib.rst         |  3 ---
 doc/guides/prog_guide/overview.rst            | 11 +++++-----
 doc/guides/sample_app_ug/cmd_line.rst         |  2 +-
 doc/guides/sample_app_ug/dist_app.rst         |  2 +-
 doc/guides/sample_app_ug/hello_world.rst      |  2 +-
 doc/guides/sample_app_ug/ipsec_secgw.rst      |  4 ++--
 doc/guides/sample_app_ug/ipv4_multicast.rst   |  4 +---
 doc/guides/sample_app_ug/keep_alive.rst       |  2 +-
 doc/guides/sample_app_ug/l2_forward_cat.rst   |  4 ++--
 doc/guides/sample_app_ug/l2_forward_event.rst |  8 ++++----
 .../sample_app_ug/l2_forward_job_stats.rst    |  2 +-
 .../sample_app_ug/l2_forward_real_virtual.rst |  4 ++--
 doc/guides/sample_app_ug/l3_forward.rst       |  8 ++++----
 doc/guides/sample_app_ug/l3_forward_graph.rst |  6 +++---
 doc/guides/sample_app_ug/link_status_intr.rst |  4 ++--
 doc/guides/sample_app_ug/multi_process.rst    | 20 +++++++++----------
 doc/guides/sample_app_ug/ptpclient.rst        |  2 +-
 doc/guides/sample_app_ug/qos_scheduler.rst    |  4 ++--
 doc/guides/sample_app_ug/rxtx_callbacks.rst   |  2 +-
 doc/guides/sample_app_ug/skeleton.rst         |  2 +-
 doc/guides/sample_app_ug/timer.rst            |  2 +-
 doc/guides/sample_app_ug/vdpa.rst             |  2 +-
 doc/guides/sample_app_ug/vhost.rst            |  2 +-
 .../sample_app_ug/vm_power_management.rst     | 12 +++++------
 .../sample_app_ug/vmdq_dcb_forwarding.rst     |  2 +-
 doc/guides/sample_app_ug/vmdq_forwarding.rst  |  2 +-
 doc/guides/testpmd_app_ug/run_app.rst         |  2 +-
 doc/guides/tools/flow-perf.rst                |  2 +-
 65 files changed, 129 insertions(+), 129 deletions(-)

-- 
2.47.2

