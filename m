Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFF7C83F27
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Jul 2025 21:57:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 663AE402E8;
	Tue, 15 Jul 2025 23:57:28 +0200 (CEST)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id 8D7EE4013F
 for <dev@dpdk.org>; Tue, 15 Jul 2025 23:57:25 +0200 (CEST)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-234f17910d8so59742365ad.3
 for <dev@dpdk.org>; Tue, 15 Jul 2025 14:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752616645;
 x=1753221445; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LlqJu8VrI6DjbSHMyNfGAAQ9kb4H4uUH/iEPp37KXBQ=;
 b=1EiHFL1FDbLmD4YTcehc9doyaeOHO7z51ejvajubwmDmQ3n0a2LcwCEbiakTR0gH+7
 CDbZXRIXbyzx+T9Z0E9MeGkU8hduAkXpjEHqLlmWVWTHOdcuO5+ixwKroNFNLUliLXRk
 GWXtEOZ+D+hvWsM+wGJdwSzBghZGKlZijUCVgoZJu6IkzeVkQXM6aNZ+x2bpbv2VtkfH
 9arQWQCne2qF4mnLh8l5nMUi9EgPk+31WqNTKhGyS9geDcRiKynCQa4iyxSKuZFhfBtI
 CoTw+yuzXNknHxg6fEz/jSEvv99oit3iKKXLiLZSsCW9I/oFbuT91RR7llKqYHZA9exS
 YoPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752616645; x=1753221445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LlqJu8VrI6DjbSHMyNfGAAQ9kb4H4uUH/iEPp37KXBQ=;
 b=lFxsday/XqAaQnCgp3kuvSkeeLJEm8Ggwzo8zsPAEObCmDJpTZ3honk3DVO6hYwNTM
 78zxPjmyY5o781tk0ARFmiN4zIA1V0okGCfCmQbItmKWiJApYxRjK7eC8dg3ssOwzWn4
 ZBKHzKOep7ITM6AfW4QUhTkCHG/aYLOaBrQRcGLqNEKA4TN9KPXLMLMBHKIO2uPnUiiU
 F65Bx0ejubkNlxh2lh0+Pic6STe4TNFId6MoD3dmljbrY2xDF89WsMy5mhPaxOaS5Aao
 crdemXZlYT7WUTBHXLP+ILEm3Ahem0TJ6X3H9prvV5Cx1DcNZVPtWoDQSrJP+ZAfH6kN
 imMQ==
X-Gm-Message-State: AOJu0Yy/OUpeeuFVt6NF72JmRH/2ufFsKmPx6V80D+GjsDMjTbZynk47
 2ct9zopBl9XkyAM8fq/8d3LnbDIwQ5vzqjaX6cgDDjB2IjI2DJB4CrI/ycnj+9aeFGUDiVylxqw
 1tOCkkls=
X-Gm-Gg: ASbGncvBSorBkXFs1H8yhe/v4RjxEAzFlxqwQ0SHGZXhL/9w0tQYrxUkzZHCVgNJjOw
 BLc8UuUMtzqfK8K2cdvJek3qa4Y9V26gB4tImJxYk3a94QT5LOB3z4wawYyhFoVXoP50r7wVCYR
 EOdC7hpYWQHTaEu0luGJuPEvePddXtcNLyBiizABm4GC/nAdMpNA2ev15fuZpPsfSIUJjeaOzjL
 qilC9jXgaMH62hW/B2VcwINiA/GiVuCao5qQ8VuBKsWp+1wy6awrUciAfF/21CYVlMGDP0OS2gr
 Hk1Ze5OL5KRC96jVCfeaCk9rq8t1goMLFWaAjyssO6gQTj1F6+NE8XlhGbyb/gM8jZKTrSzygBJ
 VybZ9IStbbJBzfkBj3UEb41xPN+3oscx9kkgCRLVscC3169UmR4DBhz9D0GefmSnA7NUpXtLH
X-Google-Smtp-Source: AGHT+IET9sQz7j7T6nw+20EGiqD9LE7FoslYmPhevnP05ptGUVcifJ4r2Q/aNEoAlr+jK0dpa3rhJQ==
X-Received: by 2002:a17:902:c944:b0:236:7050:74af with SMTP id
 d9443c01a7336-23e24ec0b7bmr7075205ad.9.1752616643540; 
 Tue, 15 Jul 2025 14:57:23 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de43228a6sm111538185ad.91.2025.07.15.14.57.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jul 2025 14:57:23 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Jack Bond-Preston <jack.bond-preston@foss.arm.com>,
 Kai Ji <kai.ji@intel.com>, Pablo de Lara <pablo.de.lara.guarch@intel.com>,
 Sunil Uttarwar <sunilprakashrao.uttarwar@amd.com>,
 Praveen Shetty <praveen.shetty@intel.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>, Gaetan Rivet <grive@u256.net>,
 Dengdui Huang <huangdengdui@huawei.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Rosen Xu <rosen.xu@altera.com>, Matan Azrad <matan@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Devendra Singh Rawat <dsinghrawat@marvell.com>,
 Alok Prasad <palok@marvell.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, Maciej Czekaj <mczekaj@marvell.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>, Chas Williams <chas3@att.com>,
 "Min Hu (Connor)" <humin29@huawei.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 David Hunt <david.hunt@intel.com>, Radu Nicolau <radu.nicolau@intel.com>,
 Akhil Goyal <gakhil@marvell.com>,
 Tomasz Kantecki <tomasz.kantecki@intel.com>,
 Sunil Kumar Kori <skori@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>,
 John McNamara <john.mcnamara@intel.com>,
 Erik Gabriel Carrillo <erik.g.carrillo@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>,
 Aman Singh <aman.deep.singh@intel.com>, Wisam Jaddo <wisamm@nvidia.com>
Subject: [PATCH v3 2/2] doc: remove use of '-n 4' option in documentation
 examples
Date: Tue, 15 Jul 2025 14:56:29 -0700
Message-ID: <20250715215718.7388-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250715215718.7388-1-stephen@networkplumber.org>
References: <20240718184326.21375-1-stephen@networkplumber.org>
 <20250715215718.7388-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Many places in the documentation are using -n 4 to set
the number of memory channels. This is no longer required
and is unneccessary in most cases.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Jack Bond-Preston <jack.bond-preston@foss.arm.com>
---
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
 64 files changed, 124 insertions(+), 129 deletions(-)

diff --git a/doc/guides/contributing/documentation.rst b/doc/guides/contributing/documentation.rst
index 7b287ce631..338254cf30 100644
--- a/doc/guides/contributing/documentation.rst
+++ b/doc/guides/contributing/documentation.rst
@@ -255,7 +255,7 @@ Line Length and Wrapping
   Long literal command lines can be shown wrapped with backslashes. For
   example::
 
-     dpdk-testpmd -l 2-3 -n 4 \
+     dpdk-testpmd -l 2-3 \
              --vdev=virtio_user0,path=/dev/vhost-net,queues=2,queue_size=1024 \
              -- -i --tx-offloads=0x0000002c --enable-lro --txq=2 --rxq=2 \
              --txd=1024 --rxd=1024
diff --git a/doc/guides/cryptodevs/aesni_gcm.rst b/doc/guides/cryptodevs/aesni_gcm.rst
index 7592d33da2..16bdaf3cb4 100644
--- a/doc/guides/cryptodevs/aesni_gcm.rst
+++ b/doc/guides/cryptodevs/aesni_gcm.rst
@@ -104,5 +104,5 @@ Example:
 
 .. code-block:: console
 
-    ./dpdk-l2fwd-crypto -l 1 -n 4 --vdev="crypto_aesni_gcm,socket_id=0,max_nb_sessions=128" \
+    ./dpdk-l2fwd-crypto -l 1 --vdev="crypto_aesni_gcm,socket_id=0,max_nb_sessions=128" \
     -- -p 1 --cdev SW --chain AEAD --aead_algo "aes-gcm"
diff --git a/doc/guides/cryptodevs/aesni_mb.rst b/doc/guides/cryptodevs/aesni_mb.rst
index 8d7e221e79..d58ce20ff4 100644
--- a/doc/guides/cryptodevs/aesni_mb.rst
+++ b/doc/guides/cryptodevs/aesni_mb.rst
@@ -168,7 +168,7 @@ Example:
 
 .. code-block:: console
 
-    ./dpdk-l2fwd-crypto -l 1 -n 4 --vdev="crypto_aesni_mb,socket_id=0,max_nb_sessions=128" \
+    ./dpdk-l2fwd-crypto -l 1 --vdev="crypto_aesni_mb,socket_id=0,max_nb_sessions=128" \
     -- -p 1 --cdev SW --chain CIPHER_HASH --cipher_algo "aes-cbc" --auth_algo "sha1-hmac"
 
 Extra notes
diff --git a/doc/guides/cryptodevs/ccp.rst b/doc/guides/cryptodevs/ccp.rst
index a314fb6fd1..e2d04d5317 100644
--- a/doc/guides/cryptodevs/ccp.rst
+++ b/doc/guides/cryptodevs/ccp.rst
@@ -94,7 +94,7 @@ To validate ccp PMD, l2fwd-crypto example can be used with following command:
 
 .. code-block:: console
 
-        sudo ./<build_dir>/examples/dpdk-l2fwd-crypto -l 1 -n 4 --vdev "crypto_ccp" -- -p 0x1
+        sudo ./<build_dir>/examples/dpdk-l2fwd-crypto -l 1 --vdev "crypto_ccp" -- -p 0x1
         --chain CIPHER_HASH --cipher_op ENCRYPT --cipher_algo aes-cbc
         --cipher_key 00:01:02:03:04:05:06:07:08:09:0a:0b:0c:0d:0e:0f
         --cipher_iv 00:01:02:03:04:05:06:07:08:09:0a:0b:0c:0d:0e:ff
@@ -109,7 +109,7 @@ following:
 
 .. code-block:: console
 
-        sudo ./<build_dir>/examples/dpdk-l2fwd-crypto -l 1 -n 4 --vdev "crypto_ccp,ccp_auth_opt=1" -- -p 0x1
+        sudo ./<build_dir>/examples/dpdk-l2fwd-crypto -l 1 --vdev "crypto_ccp,ccp_auth_opt=1" -- -p 0x1
         --chain CIPHER_HASH --cipher_op ENCRYPT --cipher_algo aes-cbc
         --cipher_key 00:01:02:03:04:05:06:07:08:09:0a:0b:0c:0d:0e:0f
         --cipher_iv 00:01:02:03:04:05:06:07:08:09:0a:0b:0c:0d:0e:ff
diff --git a/doc/guides/cryptodevs/kasumi.rst b/doc/guides/cryptodevs/kasumi.rst
index b57f18b56f..ce1db4e905 100644
--- a/doc/guides/cryptodevs/kasumi.rst
+++ b/doc/guides/cryptodevs/kasumi.rst
@@ -110,7 +110,7 @@ Example:
 
 .. code-block:: console
 
-    ./dpdk-l2fwd-crypto -l 1 -n 4 --vdev="crypto_kasumi,socket_id=0,max_nb_sessions=128" \
+    ./dpdk-l2fwd-crypto -l 1 --vdev="crypto_kasumi,socket_id=0,max_nb_sessions=128" \
     -- -p 1 --cdev SW --chain CIPHER_ONLY --cipher_algo "kasumi-f8"
 
 Extra notes on KASUMI F9
diff --git a/doc/guides/cryptodevs/null.rst b/doc/guides/cryptodevs/null.rst
index 12577fa0bf..8d7975466c 100644
--- a/doc/guides/cryptodevs/null.rst
+++ b/doc/guides/cryptodevs/null.rst
@@ -67,5 +67,5 @@ Example:
 
 .. code-block:: console
 
-    ./dpdk-l2fwd-crypto -l 1 -n 4 --vdev="crypto_null,socket_id=0,max_nb_sessions=128" \
+    ./dpdk-l2fwd-crypto -l 1 --vdev="crypto_null,socket_id=0,max_nb_sessions=128" \
     -- -p 1 --cdev SW --chain CIPHER_ONLY --cipher_algo "null"
diff --git a/doc/guides/cryptodevs/openssl.rst b/doc/guides/cryptodevs/openssl.rst
index ff21d21b23..d467069cac 100644
--- a/doc/guides/cryptodevs/openssl.rst
+++ b/doc/guides/cryptodevs/openssl.rst
@@ -80,7 +80,7 @@ To verify real traffic l2fwd-crypto example can be used with this command:
 
 .. code-block:: console
 
-	sudo ./<build_dir>/examples/dpdk-l2fwd-crypto -l 0-1 -n 4 --vdev "crypto_openssl"
+	sudo ./<build_dir>/examples/dpdk-l2fwd-crypto -l 0-1 --vdev "crypto_openssl"
 	--vdev "crypto_openssl"-- -p 0x3 --chain CIPHER_HASH
 	--cipher_op ENCRYPT --cipher_algo AES_CBC
 	--cipher_key 00:01:02:03:04:05:06:07:08:09:0a:0b:0c:0d:0e:0f
diff --git a/doc/guides/cryptodevs/snow3g.rst b/doc/guides/cryptodevs/snow3g.rst
index fb4e0448ac..bde30de1b5 100644
--- a/doc/guides/cryptodevs/snow3g.rst
+++ b/doc/guides/cryptodevs/snow3g.rst
@@ -119,5 +119,5 @@ Example:
 
 .. code-block:: console
 
-    ./dpdk-l2fwd-crypto -l 1 -n 4 --vdev="crypto_snow3g,socket_id=0,max_nb_sessions=128" \
+    ./dpdk-l2fwd-crypto -l 1 --vdev="crypto_snow3g,socket_id=0,max_nb_sessions=128" \
     -- -p 1 --cdev SW --chain CIPHER_ONLY --cipher_algo "snow3g-uea2"
diff --git a/doc/guides/cryptodevs/zuc.rst b/doc/guides/cryptodevs/zuc.rst
index 4615562246..1bede0498b 100644
--- a/doc/guides/cryptodevs/zuc.rst
+++ b/doc/guides/cryptodevs/zuc.rst
@@ -118,5 +118,5 @@ Example:
 
 .. code-block:: console
 
-    ./dpdk-l2fwd-crypto -l 1 -n 4 --vdev="crypto_zuc,socket_id=0,max_nb_sessions=128" \
+    ./dpdk-l2fwd-crypto -l 1 --vdev="crypto_zuc,socket_id=0,max_nb_sessions=128" \
     -- -p 1 --cdev SW --chain CIPHER_ONLY --cipher_algo "zuc-eea3"
diff --git a/doc/guides/howto/lm_bond_virtio_sriov.rst b/doc/guides/howto/lm_bond_virtio_sriov.rst
index 1859508559..1d46ebb27f 100644
--- a/doc/guides/howto/lm_bond_virtio_sriov.rst
+++ b/doc/guides/howto/lm_bond_virtio_sriov.rst
@@ -614,7 +614,7 @@ Run testpmd in the Virtual Machine.
    # use for bonding of virtio and vf tests in VM
 
    /root/dpdk/<build_dir>/app/dpdk-testpmd \
-   -l 0-3 -n 4 --numa-mem 350 --  --i --port-topology=chained
+   -l 0-3 --numa-mem 350 --  --i --port-topology=chained
 
 .. _lm_bond_virtio_sriov_switch_conf:
 
diff --git a/doc/guides/howto/lm_virtio_vhost_user.rst b/doc/guides/howto/lm_virtio_vhost_user.rst
index b84ef0dc29..94ab71d653 100644
--- a/doc/guides/howto/lm_virtio_vhost_user.rst
+++ b/doc/guides/howto/lm_virtio_vhost_user.rst
@@ -438,4 +438,4 @@ run_testpmd_in_vm.sh
    # test system has 8 cpus (0-7), use cpus 2-7 for VM
 
    /root/dpdk/<build_dir>/app/dpdk-testpmd \
-   -l 0-5 -n 4 --numa-mem 350 -- --burst=64 --i
+   -l 0-5 --numa-mem 350 -- --burst=64 --i
diff --git a/doc/guides/howto/packet_capture_framework.rst b/doc/guides/howto/packet_capture_framework.rst
index 8e64e7a83e..4099c419aa 100644
--- a/doc/guides/howto/packet_capture_framework.rst
+++ b/doc/guides/howto/packet_capture_framework.rst
@@ -89,7 +89,7 @@ inspect them using ``tcpdump``.
 
 #. Launch testpmd as the primary application::
 
-     sudo <build_dir>/app/dpdk-testpmd -l 4-7 -n 4 -- -i --port-topology=chained
+     sudo <build_dir>/app/dpdk-testpmd -l 4-7 -- -i --port-topology=chained
 
 #. Launch the dpdk-dumpcap as follows::
 
diff --git a/doc/guides/howto/pvp_reference_benchmark.rst b/doc/guides/howto/pvp_reference_benchmark.rst
index 073e72ea6f..bec97b8675 100644
--- a/doc/guides/howto/pvp_reference_benchmark.rst
+++ b/doc/guides/howto/pvp_reference_benchmark.rst
@@ -122,7 +122,7 @@ Testpmd launch
 
    .. code-block:: console
 
-      <build_dir>/app/dpdk-testpmd -l 0,2,3,4,5 --numa-mem=1024 -n 4 \
+      <build_dir>/app/dpdk-testpmd -l 0,2,3,4,5 --numa-mem=1024 \
           --vdev 'net_vhost0,iface=/tmp/vhost-user1' \
           --vdev 'net_vhost1,iface=/tmp/vhost-user2' -- \
           --portmask=f -i --rxq=1 --txq=1 \
@@ -332,7 +332,7 @@ Start testpmd:
 
    .. code-block:: console
 
-      <build_dir>/app/dpdk-testpmd -l 0,1,2 --numa-mem 1024 -n 4 \
+      <build_dir>/app/dpdk-testpmd -l 0,1,2 --numa-mem 1024 \
           --proc-type auto --file-prefix pg -- \
           --portmask=3 --forward-mode=macswap --port-topology=chained \
           --disable-rss -i --rxq=1 --txq=1 \
diff --git a/doc/guides/howto/vfd.rst b/doc/guides/howto/vfd.rst
index 5a62e6ff5a..62bcdfe15a 100644
--- a/doc/guides/howto/vfd.rst
+++ b/doc/guides/howto/vfd.rst
@@ -83,7 +83,7 @@ The typical procedure to achieve this is as follows:
 
 #. Run a DPDK application on the PF in the host::
 
-      dpdk-testpmd -l 0-7 -n 4 -- -i --txqflags=0
+      dpdk-testpmd -l 0-7 -- -i --txqflags=0
 
 #. Bind the VF port to ``igb_uio`` in the VM::
 
@@ -91,7 +91,7 @@ The typical procedure to achieve this is as follows:
 
 #. Run a DPDK application on the VF in the VM::
 
-      dpdk-testpmd -l 0-7 -n 4 -- -i --txqflags=0
+      dpdk-testpmd -l 0-7 -- -i --txqflags=0
 
 
 Common functions of IXGBE and I40E
diff --git a/doc/guides/howto/virtio_user_for_container_networking.rst b/doc/guides/howto/virtio_user_for_container_networking.rst
index a07dfd45b0..23f53199da 100644
--- a/doc/guides/howto/virtio_user_for_container_networking.rst
+++ b/doc/guides/howto/virtio_user_for_container_networking.rst
@@ -77,7 +77,7 @@ some minor changes.
 
     .. code-block:: console
 
-        $(testpmd) -l 0-1 -n 4 --numa-mem 1024,1024 \
+        $(testpmd) -l 0-1 --numa-mem 1024,1024 \
             --vdev 'eth_vhost0,iface=/tmp/sock0' \
             --file-prefix=host --no-pci -- -i
 
@@ -87,7 +87,7 @@ some minor changes.
 
         docker run -i -t -v /tmp/sock0:/var/run/usvhost \
             -v /dev/hugepages:/dev/hugepages \
-            dpdk-app-testpmd testpmd -l 6-7 -n 4 -m 1024 --no-pci \
+            dpdk-app-testpmd testpmd -l 6-7 -m 1024 --no-pci \
             --vdev=virtio_user0,path=/var/run/usvhost \
             --file-prefix=container \
             -- -i
diff --git a/doc/guides/linux_gsg/build_sample_apps.rst b/doc/guides/linux_gsg/build_sample_apps.rst
index f2b92187a6..139e88d4d0 100644
--- a/doc/guides/linux_gsg/build_sample_apps.rst
+++ b/doc/guides/linux_gsg/build_sample_apps.rst
@@ -109,10 +109,9 @@ The EAL options are as follows:
   affect legacy memory mode).
 
 Copy the DPDK application binary to your target, then run the application as follows
-(assuming the platform has four memory channels per processor socket,
-and that cores 0-3 are present and are to be used for running the application)::
+(assuming that cores 0-3 are present and are to be used for running the application)::
 
-    ./dpdk-helloworld -l 0-3 -n 4
+    ./dpdk-helloworld -l 0-3
 
 .. note::
 
diff --git a/doc/guides/linux_gsg/linux_drivers.rst b/doc/guides/linux_gsg/linux_drivers.rst
index 852a60f5c0..039823d61e 100644
--- a/doc/guides/linux_gsg/linux_drivers.rst
+++ b/doc/guides/linux_gsg/linux_drivers.rst
@@ -252,14 +252,14 @@ The token will be used for all PF and VF ports within the application.
 
    .. code-block:: console
 
-      <build_dir>/app/dpdk-testpmd -l 22-25 -n 4 -a 86:00.0 \
+      <build_dir>/app/dpdk-testpmd -l 22-25 -a 86:00.0 \
       --vfio-vf-token=14d63f20-8445-11ea-8900-1f9ce7d5650d --file-prefix=pf -- -i
 
 #. Start the DPDK application that will manage the VF device
 
    .. code-block:: console
 
-      <build_dir>/app/dpdk-testpmd -l 26-29 -n 4 -a 86:02.0 \
+      <build_dir>/app/dpdk-testpmd -l 26-29 -a 86:02.0 \
       --vfio-vf-token=14d63f20-8445-11ea-8900-1f9ce7d5650d --file-prefix=vf0 -- -i
 
 .. note::
diff --git a/doc/guides/nics/build_and_test.rst b/doc/guides/nics/build_and_test.rst
index 08310234ac..65264b9dbc 100644
--- a/doc/guides/nics/build_and_test.rst
+++ b/doc/guides/nics/build_and_test.rst
@@ -133,7 +133,7 @@ This section demonstrates how to setup and run ``testpmd`` in Linux.
 
    .. code-block:: console
 
-      ./<build_dir>/app/dpdk-testpmd -l 0-3 -n 4 -- -i
+      ./<build_dir>/app/dpdk-testpmd -l 0-3 -- -i
 
    Successful execution will show initialization messages from EAL, PMD and
    testpmd application. A prompt will be displayed at the end for user commands
diff --git a/doc/guides/nics/cpfl.rst b/doc/guides/nics/cpfl.rst
index 529ffae974..54a3015aa0 100644
--- a/doc/guides/nics/cpfl.rst
+++ b/doc/guides/nics/cpfl.rst
@@ -215,7 +215,7 @@ low level hardware resources.
 
    .. code-block:: console
 
-      dpdk-testpmd -l 0,1 -n 4 -a 0000:af:00.6,vport=[0-1],flow_parser="refpkg.json" -- -i
+      dpdk-testpmd -l 0,1 -a 0000:af:00.6,vport=[0-1],flow_parser="refpkg.json" -- -i
 
 #. Create one flow to forward ETH-IPV4-TCP from I/O port to a local(CPF's) vport. Flow should be created on
    vport X. Group M should match fxp module. Action port_representor Y means forward packet to local vport Y::
diff --git a/doc/guides/nics/cxgbe.rst b/doc/guides/nics/cxgbe.rst
index 1f0b848ede..487190ff60 100644
--- a/doc/guides/nics/cxgbe.rst
+++ b/doc/guides/nics/cxgbe.rst
@@ -749,7 +749,7 @@ devices managed by librte_net_cxgbe in FreeBSD operating system.
 
    .. code-block:: console
 
-      ./<build_dir>/app/dpdk-testpmd -l 0-3 -n 4 -a 0000:02:00.4 -- -i
+      ./<build_dir>/app/dpdk-testpmd -l 0-3 -a 0000:02:00.4 -- -i
 
    Example output:
 
diff --git a/doc/guides/nics/fail_safe.rst b/doc/guides/nics/fail_safe.rst
index 58307360a4..c3922b9c39 100644
--- a/doc/guides/nics/fail_safe.rst
+++ b/doc/guides/nics/fail_safe.rst
@@ -116,7 +116,7 @@ This section shows some example of using **testpmd** with a fail-safe PMD.
 
    .. code-block:: console
 
-      ./<build_dir>/app/dpdk-testpmd -l 0-7 -n 4 \
+      ./<build_dir>/app/dpdk-testpmd -l 0-7 \
          --vdev 'net_failsafe0,mac=de:ad:be:ef:01:02,dev(84:00.0),dev(net_ring0)' \
          -b 84:00.0 -b 00:04.0 -- -i
 
@@ -130,7 +130,7 @@ This section shows some example of using **testpmd** with a fail-safe PMD.
 
    .. code-block:: console
 
-      ./<build_dir>/app/dpdk-testpmd -l 0-7 -n 4 \
+      ./<build_dir>/app/dpdk-testpmd -l 0-7 \
          --vdev 'net_failsafe0,mac=de:ad:be:ef:01:02,dev(84:00.0),dev(net_ring0)' \
          -a 81:00.0 -- -i
 
@@ -138,7 +138,7 @@ This section shows some example of using **testpmd** with a fail-safe PMD.
 
    .. code-block:: console
 
-      ./<build_dir>/app/dpdk-testpmd -l 0-7 -n 4 -a ff:ff.f \
+      ./<build_dir>/app/dpdk-testpmd -l 0-7 -a ff:ff.f \
          --vdev='net_failsafe0,exec(echo 84:00.0)' -- -i
 
 #. Start testpmd, automatically probing the device 84:00.0 and using it with
@@ -146,7 +146,7 @@ This section shows some example of using **testpmd** with a fail-safe PMD.
 
    .. code-block:: console
 
-      ./<build_dir>/app/dpdk-testpmd -l 0-7 -n 4 \
+      ./<build_dir>/app/dpdk-testpmd -l 0-7 \
          --vdev 'net_failsafe0,dev(0000:84:00.0),dev(net_ring0)' -- -i
 
 
diff --git a/doc/guides/nics/hns3.rst b/doc/guides/nics/hns3.rst
index 1239c21604..5e0fdd5bbb 100644
--- a/doc/guides/nics/hns3.rst
+++ b/doc/guides/nics/hns3.rst
@@ -221,7 +221,7 @@ To start ``testpmd``, and add VLAN 10 to port 0:
 
 .. code-block:: console
 
-    ./<build_dir>/app/dpdk-testpmd -l 0-15 -n 4 -- -i --forward-mode=mac
+    ./<build_dir>/app/dpdk-testpmd -l 0-15 -- -i --forward-mode=mac
     ...
 
     testpmd> set promisc 0 off
@@ -242,7 +242,7 @@ Start ``testpmd``:
 
 .. code-block:: console
 
-   ./<build_dir>/app/dpdk-testpmd -l 0-15 -n 4 -- -i --rxq=8 --txq=8 \
+   ./<build_dir>/app/dpdk-testpmd -l 0-15 -- -i --rxq=8 --txq=8 \
 				  --nb-cores=8 --nb-ports=1
 
 Add a rule to direct ``ipv4-udp`` packet whose ``dst_ip=2.2.2.5, src_ip=2.2.2.3,
diff --git a/doc/guides/nics/i40e.rst b/doc/guides/nics/i40e.rst
index 234757cd7a..cb50f8de00 100644
--- a/doc/guides/nics/i40e.rst
+++ b/doc/guides/nics/i40e.rst
@@ -413,7 +413,7 @@ To start ``testpmd``, and add vlan 10 to port 0:
 
 .. code-block:: console
 
-    ./<build_dir>/app/dpdk-testpmd -l 0-15 -n 4 -- -i --forward-mode=mac
+    ./<build_dir>/app/dpdk-testpmd -l 0-15 -- -i --forward-mode=mac
     ...
 
     testpmd> set promisc 0 off
@@ -448,7 +448,7 @@ Start ``testpmd`` with ``--disable-rss`` and ``--pkt-filter-mode=perfect``:
 
 .. code-block:: console
 
-   ./<build_dir>/app/dpdk-testpmd -l 0-15 -n 4 -- -i --disable-rss \
+   ./<build_dir>/app/dpdk-testpmd -l 0-15 -- -i --disable-rss \
                  --pkt-filter-mode=perfect --rxq=8 --txq=8 --nb-cores=8 \
                  --nb-ports=1
 
@@ -1026,7 +1026,7 @@ See :numref:`figure_intel_perf_test_setup` for the performance test setup.
 
 #. The command line of running l3fwd would be something like the following::
 
-      ./dpdk-l3fwd -l 18-21 -n 4 -a 82:00.0 -a 85:00.0 \
+      ./dpdk-l3fwd -l 18-21 -a 82:00.0 -a 85:00.0 \
               -- -p 0x3 --config '(0,0,18),(0,1,19),(1,0,20),(1,1,21)'
 
    This means that the application uses core 18 for port 0, queue pair 0 forwarding, core 19 for port 0, queue pair 1 forwarding,
diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index c6531d5684..21593f2866 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -429,7 +429,7 @@ For example:
 
 .. code-block:: console
 
-   dpdk-testpmd -a 0000:31:00.0 -l 0-3 -n 4 -- -i --tx-offloads=0x200000
+   dpdk-testpmd -a 0000:31:00.0 -l 0-3 -- -i --tx-offloads=0x200000
    set fwd txonly
    set txtimes <inter_burst>,<intra_burst>
    start
@@ -541,7 +541,7 @@ Additional Options
 
 #. Bind the VF0, and run testpmd with 'cap=dcf' with port representor for VF 1 and 2::
 
-      dpdk-testpmd -l 22-25 -n 4 -a 18:01.0,cap=dcf,representor=vf[1-2] -- -i
+      dpdk-testpmd -l 22-25 -a 18:01.0,cap=dcf,representor=vf[1-2] -- -i
 
 #. Monitor the VF2 interface network traffic::
 
@@ -570,7 +570,7 @@ To start ``testpmd``, and add vlan 10 to port 0:
 
 .. code-block:: console
 
-    ./app/dpdk-testpmd -l 0-15 -n 4 -- -i
+    ./app/dpdk-testpmd -l 0-15 -- -i
     ...
 
     testpmd> rx_vlan add 10 0
diff --git a/doc/guides/nics/intel_vf.rst b/doc/guides/nics/intel_vf.rst
index 5f6adfca76..bc600e4b58 100644
--- a/doc/guides/nics/intel_vf.rst
+++ b/doc/guides/nics/intel_vf.rst
@@ -545,7 +545,7 @@ The setup procedure is as follows:
 
     .. code-block:: console
 
-        ./<build_dir>/app/dpdk-testpmd -l 0-3 -n 4 -- -i
+        ./<build_dir>/app/dpdk-testpmd -l 0-3 -- -i
 
 #.  Finally, access the Guest OS using vncviewer with the localhost:5900 port and check the lspci command output in the Guest OS.
     The virtual functions will be listed as available for use.
diff --git a/doc/guides/nics/ipn3ke.rst b/doc/guides/nics/ipn3ke.rst
index 144b9462b6..82a0489178 100644
--- a/doc/guides/nics/ipn3ke.rst
+++ b/doc/guides/nics/ipn3ke.rst
@@ -76,7 +76,7 @@ To start ``testpmd``, and add I40e PF to FPGA network port:
 
 .. code-block:: console
 
-    ./<build_dir>/app/dpdk-testpmd -l 0-15 -n 4 --vdev 'ifpga_rawdev_cfg0,ifpga=b3:00.0,port=0' --vdev 'ipn3ke_cfg0,afu=0|b3:00.0,i40e_pf={0000:b1:00.0|0000:b1:00.1|0000:b1:00.2|0000:b1:00.3|0000:b5:00.0|0000:b5:00.1|0000:b5:00.2|0000:b5:00.3}' -- -i --no-numa --port-topology=loop
+    ./<build_dir>/app/dpdk-testpmd -l 0-15 --vdev 'ifpga_rawdev_cfg0,ifpga=b3:00.0,port=0' --vdev 'ipn3ke_cfg0,afu=0|b3:00.0,i40e_pf={0000:b1:00.0|0000:b1:00.1|0000:b1:00.2|0000:b1:00.3|0000:b5:00.0|0000:b5:00.1|0000:b5:00.2|0000:b5:00.3}' -- -i --no-numa --port-topology=loop
 
 HQoS and flow acceleration
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -87,7 +87,7 @@ To start ``testpmd``, and add I40e PF to FPGA network port, enable FPGA HQoS and
 
 .. code-block:: console
 
-    ./<build_dir>/app/dpdk-testpmd -l 0-15 -n 4 --vdev 'ifpga_rawdev_cfg0,ifpga=b3:00.0,port=0' --vdev 'ipn3ke_cfg0,afu=0|b3:00.0,fpga_acc={tm|flow},i40e_pf={0000:b1:00.0|0000:b1:00.1|0000:b1:00.2|0000:b1:00.3|0000:b5:00.0|0000:b5:00.1|0000:b5:00.2|0000:b5:00.3}' -- -i --no-numa --forward-mode=macswap
+    ./<build_dir>/app/dpdk-testpmd -l 0-15 --vdev 'ifpga_rawdev_cfg0,ifpga=b3:00.0,port=0' --vdev 'ipn3ke_cfg0,afu=0|b3:00.0,fpga_acc={tm|flow},i40e_pf={0000:b1:00.0|0000:b1:00.1|0000:b1:00.2|0000:b1:00.3|0000:b5:00.0|0000:b5:00.1|0000:b5:00.2|0000:b5:00.3}' -- -i --no-numa --forward-mode=macswap
 
 Limitations or Known issues
 ---------------------------
diff --git a/doc/guides/nics/mlx4.rst b/doc/guides/nics/mlx4.rst
index d79d5b1661..9870de7809 100644
--- a/doc/guides/nics/mlx4.rst
+++ b/doc/guides/nics/mlx4.rst
@@ -428,7 +428,7 @@ devices managed by librte_net_mlx4.
 
 #. Start testpmd with basic parameters::
 
-      dpdk-testpmd -l 8-15 -n 4 -a 0000:83:00.0 -a 0000:84:00.0 -- --rxq=2 --txq=2 -i
+      dpdk-testpmd -l 8-15 -a 0000:83:00.0 -a 0000:84:00.0 -- --rxq=2 --txq=2 -i
 
    Example output::
 
diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index c3a350d24e..12ec1ad5e6 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -2359,7 +2359,7 @@ ConnectX-4/ConnectX-5/ConnectX-6/BlueField devices managed by librte_net_mlx5.
 
 #. Start testpmd with basic parameters::
 
-      dpdk-testpmd -l 8-15 -n 4 -a 05:00.0 -a 05:00.1 -a 06:00.0 -a 06:00.1 -- --rxq=2 --txq=2 -i
+      dpdk-testpmd -l 8-15 -a 05:00.0 -a 05:00.1 -a 06:00.0 -a 06:00.1 -- --rxq=2 --txq=2 -i
 
    Example output::
 
diff --git a/doc/guides/nics/null.rst b/doc/guides/nics/null.rst
index 5f746d7711..c0e3199102 100644
--- a/doc/guides/nics/null.rst
+++ b/doc/guides/nics/null.rst
@@ -14,7 +14,7 @@ Usage
 
 .. code-block:: console
 
-   ./<build_dir>/app/dpdk-testpmd -l 0-3 -n 4 --vdev net_null0 --vdev net_null1 -- -i
+   ./<build_dir>/app/dpdk-testpmd -l 0-3 --vdev net_null0 --vdev net_null1 -- -i
 
 
 Runtime Configuration
@@ -26,7 +26,7 @@ Runtime Configuration
 
 .. code-block:: console
 
-   ./<build_dir>/app/dpdk-testpmd -l 0-3 -n 4 --vdev "net_null0,copy=1" -- -i
+   ./<build_dir>/app/dpdk-testpmd -l 0-3 --vdev "net_null0,copy=1" -- -i
 
 - ``size`` [optional, default=64 bytes]
 
@@ -35,7 +35,7 @@ Runtime Configuration
 
 .. code-block:: console
 
-   ./<build_dir>/app/dpdk-testpmd -l 0-3 -n 4 --vdev "net_null0,size=256" -- -i
+   ./<build_dir>/app/dpdk-testpmd -l 0-3 --vdev "net_null0,size=256" -- -i
 
 - ``no-rx`` [optional, default disabled]
 
diff --git a/doc/guides/nics/pcap_ring.rst b/doc/guides/nics/pcap_ring.rst
index 6b0a02d174..6955e91130 100644
--- a/doc/guides/nics/pcap_ring.rst
+++ b/doc/guides/nics/pcap_ring.rst
@@ -40,7 +40,7 @@ Device name and stream options must be separated by commas as shown below:
 
 .. code-block:: console
 
-   ./<build_dir>/app/dpdk-testpmd -l 0-3 -n 4 \
+   ./<build_dir>/app/dpdk-testpmd -l 0-3 \
        --vdev 'net_pcap0,stream_opt0=..,stream_opt1=..' \
        --vdev='net_pcap1,stream_opt0=..'
 
@@ -139,7 +139,7 @@ Read packets from one pcap file and write them to another:
 
 .. code-block:: console
 
-    ./<build_dir>/app/dpdk-testpmd -l 0-3 -n 4 \
+    ./<build_dir>/app/dpdk-testpmd -l 0-3 \
         --vdev 'net_pcap0,rx_pcap=file_rx.pcap,tx_pcap=file_tx.pcap' \
         -- --port-topology=chained
 
@@ -147,7 +147,7 @@ Read packets from a network interface and write them to a pcap file:
 
 .. code-block:: console
 
-    ./<build_dir>/app/dpdk-testpmd -l 0-3 -n 4 \
+    ./<build_dir>/app/dpdk-testpmd -l 0-3 \
         --vdev 'net_pcap0,rx_iface=eth0,tx_pcap=file_tx.pcap' \
         -- --port-topology=chained
 
@@ -155,7 +155,7 @@ Read packets from a pcap file and write them to a network interface:
 
 .. code-block:: console
 
-    ./<build_dir>/app/dpdk-testpmd -l 0-3 -n 4 \
+    ./<build_dir>/app/dpdk-testpmd -l 0-3 \
         --vdev 'net_pcap0,rx_pcap=file_rx.pcap,tx_iface=eth1' \
         -- --port-topology=chained
 
@@ -163,14 +163,14 @@ Forward packets through two network interfaces:
 
 .. code-block:: console
 
-    ./<build_dir>/app/dpdk-testpmd -l 0-3 -n 4 \
+    ./<build_dir>/app/dpdk-testpmd -l 0-3 \
         --vdev 'net_pcap0,iface=eth0' --vdev='net_pcap1,iface=eth1'
 
 Enable 2 tx queues on a network interface:
 
 .. code-block:: console
 
-    ./<build_dir>/app/dpdk-testpmd -l 0-3 -n 4 \
+    ./<build_dir>/app/dpdk-testpmd -l 0-3 \
         --vdev 'net_pcap0,rx_iface=eth1,tx_iface=eth1,tx_iface=eth1' \
         -- --txq 2
 
@@ -178,7 +178,7 @@ Read only incoming packets from a network interface and write them back to the s
 
 .. code-block:: console
 
-    ./<build_dir>/app/dpdk-testpmd -l 0-3 -n 4 \
+    ./<build_dir>/app/dpdk-testpmd -l 0-3 \
         --vdev 'net_pcap0,rx_iface_in=eth1,tx_iface=eth1'
 
 Using libpcap-based PMD with the testpmd Application
@@ -203,7 +203,7 @@ Otherwise, the first 512 packets from the input pcap file will be discarded by t
 
 .. code-block:: console
 
-    ./<build_dir>/app/dpdk-testpmd -l 0-3 -n 4 \
+    ./<build_dir>/app/dpdk-testpmd -l 0-3 \
         --vdev 'net_pcap0,rx_pcap=file_rx.pcap,tx_pcap=file_tx.pcap' \
         -- --port-topology=chained --no-flush-rx
 
@@ -223,7 +223,7 @@ Multiple devices may be specified, separated by commas.
 
 .. code-block:: console
 
-    ./dpdk-testpmd -l 1-3 -n 4 --vdev=net_ring0 --vdev=net_ring1 -- -i
+    ./dpdk-testpmd -l 1-3 --vdev=net_ring0 --vdev=net_ring1 -- -i
     ...
     Interactive-mode selected
     Configuring Port 0 (socket 0)
diff --git a/doc/guides/nics/qede.rst b/doc/guides/nics/qede.rst
index 38d5cbb1f3..c067a4c796 100644
--- a/doc/guides/nics/qede.rst
+++ b/doc/guides/nics/qede.rst
@@ -272,7 +272,7 @@ This section provides instructions to configure SR-IOV with Linux OS.
 
    .. code-block:: console
 
-      dpdk-testpmd -l 0,4-11 -n 4 -- -i --nb-cores=8 --portmask=0xf --rxd=4096 \
+      dpdk-testpmd -l 0,4-11 -- -i --nb-cores=8 --portmask=0xf --rxd=4096 \
       --txd=4096 --txfreet=4068 --enable-rx-cksum --rxq=4 --txq=4 \
       --rss-ip --rss-udp
 
diff --git a/doc/guides/nics/softnic.rst b/doc/guides/nics/softnic.rst
index 4e841cb9a3..70a313be94 100644
--- a/doc/guides/nics/softnic.rst
+++ b/doc/guides/nics/softnic.rst
@@ -366,7 +366,7 @@ commands.
 
     .. code-block:: console
 
-        ./<build_dir>/app/dpdk-testpmd -l 0-2 -S 2 -n 4 \
+        ./<build_dir>/app/dpdk-testpmd -l 0-2 -S 2 \
                                     --vdev 'net_softnic0, \
                                     firmware=./drivers/net/softnic/ \
                                         firmware.cli, \
diff --git a/doc/guides/nics/thunderx.rst b/doc/guides/nics/thunderx.rst
index a64ae8e0aa..0b8584e00f 100644
--- a/doc/guides/nics/thunderx.rst
+++ b/doc/guides/nics/thunderx.rst
@@ -157,7 +157,7 @@ This section provides instructions to configure SR-IOV with Linux OS.
 
    .. code-block:: console
 
-      ./<build_dir>/app/dpdk-testpmd -l 0-3 -n 4 -a 0002:01:00.2 \
+      ./<build_dir>/app/dpdk-testpmd -l 0-3 -a 0002:01:00.2 \
         -- -i --no-flush-rx \
         --port-topology=loop
 
diff --git a/doc/guides/nics/vhost.rst b/doc/guides/nics/vhost.rst
index a7903ed583..d7341c22ee 100644
--- a/doc/guides/nics/vhost.rst
+++ b/doc/guides/nics/vhost.rst
@@ -101,7 +101,7 @@ This section demonstrates vhost PMD with testpmd DPDK sample application.
 
     .. code-block:: console
 
-        ./dpdk-testpmd -l 0-3 -n 4 --vdev 'net_vhost0,iface=/tmp/sock0,queues=1' -- -i
+        ./dpdk-testpmd -l 0-3 --vdev 'net_vhost0,iface=/tmp/sock0,queues=1' -- -i
 
     Other basic DPDK preparations like hugepage enabling here.
     Please refer to the *DPDK Getting Started Guide* for detailed instructions.
diff --git a/doc/guides/nics/virtio.rst b/doc/guides/nics/virtio.rst
index 0615abfaaf..a7642d96ce 100644
--- a/doc/guides/nics/virtio.rst
+++ b/doc/guides/nics/virtio.rst
@@ -186,7 +186,7 @@ There is no vector callbacks for packed virtqueue for now.
 Example of using the vector version of the virtio poll mode driver in
 ``testpmd``::
 
-   dpdk-testpmd -l 0-2 -n 4 -- -i --rxq=1 --txq=1 --nb-cores=1
+   dpdk-testpmd -l 0-2 -- -i --rxq=1 --txq=1 --nb-cores=1
 
 In-order callbacks only work on simulated virtio user vdev.
 
diff --git a/doc/guides/prog_guide/link_bonding_poll_mode_drv_lib.rst b/doc/guides/prog_guide/link_bonding_poll_mode_drv_lib.rst
index 60717a3587..4c1d69175e 100644
--- a/doc/guides/prog_guide/link_bonding_poll_mode_drv_lib.rst
+++ b/doc/guides/prog_guide/link_bonding_poll_mode_drv_lib.rst
@@ -378,7 +378,7 @@ Device names and bonding options must be separated by commas as shown below:
 
 .. code-block:: console
 
-    ./<build_dir>/app/dpdk-testpmd -l 0-3 -n 4 --vdev 'net_bonding0,bond_opt0=..,bond opt1=..'--vdev 'net_bonding1,bond _opt0=..,bond_opt1=..'
+    ./<build_dir>/app/dpdk-testpmd -l 0-3 --vdev 'net_bonding0,bond_opt0=..,bond opt1=..'--vdev 'net_bonding1,bond _opt0=..,bond_opt1=..'
 
 Link Bonding EAL Options
 ^^^^^^^^^^^^^^^^^^^^^^^^
@@ -478,25 +478,25 @@ Create a bonding device in round robin mode with two members specified by their
 
 .. code-block:: console
 
-    ./<build_dir>/app/dpdk-testpmd -l 0-3 -n 4 --vdev 'net_bonding0,mode=0,member=0000:0a:00.01,member=0000:04:00.00' -- --port-topology=chained
+    ./<build_dir>/app/dpdk-testpmd -l 0-3 --vdev 'net_bonding0,mode=0,member=0000:0a:00.01,member=0000:04:00.00' -- --port-topology=chained
 
 Create a bonding device in round robin mode with two members specified by their PCI address and an overriding MAC address:
 
 .. code-block:: console
 
-    ./<build_dir>/app/dpdk-testpmd -l 0-3 -n 4 --vdev 'net_bonding0,mode=0,member=0000:0a:00.01,member=0000:04:00.00,mac=00:1e:67:1d:fd:1d' -- --port-topology=chained
+    ./<build_dir>/app/dpdk-testpmd -l 0-3 --vdev 'net_bonding0,mode=0,member=0000:0a:00.01,member=0000:04:00.00,mac=00:1e:67:1d:fd:1d' -- --port-topology=chained
 
 Create a bonding device in active backup mode with two members specified, and a primary member specified by their PCI addresses:
 
 .. code-block:: console
 
-    ./<build_dir>/app/dpdk-testpmd -l 0-3 -n 4 --vdev 'net_bonding0,mode=1,member=0000:0a:00.01,member=0000:04:00.00,primary=0000:0a:00.01' -- --port-topology=chained
+    ./<build_dir>/app/dpdk-testpmd -l 0-3 --vdev 'net_bonding0,mode=1,member=0000:0a:00.01,member=0000:04:00.00,primary=0000:0a:00.01' -- --port-topology=chained
 
 Create a bonding device in balance mode with two members specified by their PCI addresses, and a transmission policy of layer 3 + 4 forwarding:
 
 .. code-block:: console
 
-    ./<build_dir>/app/dpdk-testpmd -l 0-3 -n 4 --vdev 'net_bonding0,mode=2,member=0000:0a:00.01,member=0000:04:00.00,xmit_policy=l34' -- --port-topology=chained
+    ./<build_dir>/app/dpdk-testpmd -l 0-3 --vdev 'net_bonding0,mode=2,member=0000:0a:00.01,member=0000:04:00.00,xmit_policy=l34' -- --port-topology=chained
 
 .. _bonding_testpmd_commands:
 
diff --git a/doc/guides/prog_guide/mempool_lib.rst b/doc/guides/prog_guide/mempool_lib.rst
index 7eead7b589..8b4793afff 100644
--- a/doc/guides/prog_guide/mempool_lib.rst
+++ b/doc/guides/prog_guide/mempool_lib.rst
@@ -45,9 +45,6 @@ The physical layout of the DRAM chips on the DIMM itself does not necessarily re
 
 When running an application, the EAL command line options provide the ability to add the number of memory channels and ranks.
 
-.. note::
-
-    The command line must always have the number of memory channels specified for the processor.
 
 Examples of alignment for different DIMM architectures are shown in
 :numref:`figure_memory-management` and :numref:`figure_memory-management2`.
diff --git a/doc/guides/prog_guide/overview.rst b/doc/guides/prog_guide/overview.rst
index 666c151b9d..c70023e8a1 100644
--- a/doc/guides/prog_guide/overview.rst
+++ b/doc/guides/prog_guide/overview.rst
@@ -22,16 +22,17 @@ Other libraries, outside of EAL, including the Hash,
 Longest Prefix Match (LPM) and rings libraries are also provided.
 Sample applications are provided to help show the user how to use various features of the DPDK.
 
-The DPDK implements a run to completion model for packet processing,
-where all resources must be allocated prior to calling Data Plane applications,
-running as execution units on logical processing cores.
-The model does not support a scheduler and all devices are accessed by polling.
-The primary reason for not using interrupts is the performance overhead imposed by interrupt processing.
+The DPDK supports multiple programming models for packet processing.
+Mos of the sample applications use a polling mode for performance but
+some of the samples use interrupt driven model is useful for saving power
+but has additional performance overhead. If available, it is possible
+to use the DPDK with event based hardware support.
 
 In addition to the run-to-completion model,
 a pipeline model may also be used by passing packets or messages between cores via the rings.
 This allows work to be performed in stages and may allow more efficient use of code on cores.
 
+
 Development Environment
 -----------------------
 
diff --git a/doc/guides/sample_app_ug/cmd_line.rst b/doc/guides/sample_app_ug/cmd_line.rst
index ec550d68f6..e038667bd5 100644
--- a/doc/guides/sample_app_ug/cmd_line.rst
+++ b/doc/guides/sample_app_ug/cmd_line.rst
@@ -55,7 +55,7 @@ To run the application in a Linux environment, issue the following command:
 
 .. code-block:: console
 
-    $ ./<build_dir>/examples/dpdk-cmdline -l 0-3 -n 4
+    $ ./<build_dir>/examples/dpdk-cmdline -l 0-3
 
 Refer to the *DPDK Getting Started Guide* for general information on running applications
 and the Environment Abstraction Layer (EAL) options.
diff --git a/doc/guides/sample_app_ug/dist_app.rst b/doc/guides/sample_app_ug/dist_app.rst
index 5c80561187..30b4184d40 100644
--- a/doc/guides/sample_app_ug/dist_app.rst
+++ b/doc/guides/sample_app_ug/dist_app.rst
@@ -54,7 +54,7 @@ Running the Application
 
    ..  code-block:: console
 
-       $ ./<build-dir>/examples/dpdk-distributor -l 1-9,22 -n 4 -- -p f
+       $ ./<build-dir>/examples/dpdk-distributor -l 1-9,22 -- -p f
 
 #. Refer to the DPDK Getting Started Guide for general information on running
    applications and the Environment Abstraction Layer (EAL) options.
diff --git a/doc/guides/sample_app_ug/hello_world.rst b/doc/guides/sample_app_ug/hello_world.rst
index e10d9445cf..5bfd4b3fda 100644
--- a/doc/guides/sample_app_ug/hello_world.rst
+++ b/doc/guides/sample_app_ug/hello_world.rst
@@ -25,7 +25,7 @@ To run the example in a linux environment:
 
 .. code-block:: console
 
-    $ ./<build_dir>/examples/dpdk-helloworld -l 0-3 -n 4
+    $ ./<build_dir>/examples/dpdk-helloworld -l 0-3
 
 Refer to *DPDK Getting Started Guide* for general information on running applications
 and the Environment Abstraction Layer (EAL) options.
diff --git a/doc/guides/sample_app_ug/ipsec_secgw.rst b/doc/guides/sample_app_ug/ipsec_secgw.rst
index e1d987a94e..7319505fe9 100644
--- a/doc/guides/sample_app_ug/ipsec_secgw.rst
+++ b/doc/guides/sample_app_ug/ipsec_secgw.rst
@@ -270,7 +270,7 @@ The mapping of lcores to port/queues is similar to other l3fwd applications.
 
 For example, given the following command line to run application in poll mode::
 
-    ./<build_dir>/examples/dpdk-ipsec-secgw -l 20,21 -n 4 --numa-mem 0,2048       \
+    ./<build_dir>/examples/dpdk-ipsec-secgw -l 20,21 --numa-mem 0,2048       \
            --vdev "crypto_null" -- -p 0xf -P -u 0x3             \
            --config="(0,0,20),(1,0,20),(2,0,21),(3,0,21)"       \
            -f /path/to/config_file --transfer-mode poll         \
@@ -368,7 +368,7 @@ For example, something like the following command line:
 
 .. code-block:: console
 
-    ./<build_dir>/examples/dpdk-ipsec-secgw -l 20,21 -n 4 --numa-mem 0,2048 \
+    ./<build_dir>/examples/dpdk-ipsec-secgw -l 20,21 --numa-mem 0,2048 \
             -a 81:00.0 -a 81:00.1 -a 81:00.2 -a 81:00.3 \
             --vdev "crypto_aesni_mb" --vdev "crypto_null" \
 	    -- \
diff --git a/doc/guides/sample_app_ug/ipv4_multicast.rst b/doc/guides/sample_app_ug/ipv4_multicast.rst
index 3f0cbac447..3eb8b95f29 100644
--- a/doc/guides/sample_app_ug/ipv4_multicast.rst
+++ b/doc/guides/sample_app_ug/ipv4_multicast.rst
@@ -74,14 +74,12 @@ Typically, to run the IPv4 Multicast sample application, issue the following com
 
 .. code-block:: console
 
-    ./<build_dir>/examples/dpdk-ipv4_multicast -l 0-3 -n 3 -- -p 0x3 -q 1
+    ./<build_dir>/examples/dpdk-ipv4_multicast -l 0-3 -- -p 0x3 -q 1
 
 In this command:
 
 *   The -l option enables cores 0, 1, 2 and 3
 
-*   The -n option specifies 3 memory channels
-
 *   The -p option enables ports 0 and 1
 
 *   The -q option assigns 1 queue to each lcore
diff --git a/doc/guides/sample_app_ug/keep_alive.rst b/doc/guides/sample_app_ug/keep_alive.rst
index a8dfd00c1d..8ae9d7c689 100644
--- a/doc/guides/sample_app_ug/keep_alive.rst
+++ b/doc/guides/sample_app_ug/keep_alive.rst
@@ -68,7 +68,7 @@ To run the application in linux environment with 4 lcores, 16 ports
 
 .. code-block:: console
 
-    ./<build_dir>/examples/dpdk-l2fwd-keepalive -l 0-3 -n 4 -- -q 8 -p ffff -K 10
+    ./<build_dir>/examples/dpdk-l2fwd-keepalive -l 0-3 -- -q 8 -p ffff -K 10
 
 Refer to the *DPDK Getting Started Guide* for general information on
 running applications and the Environment Abstraction Layer (EAL)
diff --git a/doc/guides/sample_app_ug/l2_forward_cat.rst b/doc/guides/sample_app_ug/l2_forward_cat.rst
index 5c9097c75d..f96f789f75 100644
--- a/doc/guides/sample_app_ug/l2_forward_cat.rst
+++ b/doc/guides/sample_app_ug/l2_forward_cat.rst
@@ -74,13 +74,13 @@ To run the example in a ``linux`` environment and enable CAT on cpus 0-2:
 
 .. code-block:: console
 
-    ./<build_dir>/examples/dpdk-l2fwd-cat -l 1 -n 4 -- --l3ca="0x3@(0-2)"
+    ./<build_dir>/examples/dpdk-l2fwd-cat -l 1 -- --l3ca="0x3@(0-2)"
 
 Or to enable CAT and CDP on cpus 1,3:
 
 .. code-block:: console
 
-    ./<build_dir>/examples/dpdk-l2fwd-cat -l 1 -n 4 -- --l3ca="(0x00C00,0x00300)@(1,3)"
+    ./<build_dir>/examples/dpdk-l2fwd-cat -l 1 -- --l3ca="(0x00C00,0x00300)@(1,3)"
 
 If CDP is not supported, it will fail with following error message:
 
diff --git a/doc/guides/sample_app_ug/l2_forward_event.rst b/doc/guides/sample_app_ug/l2_forward_event.rst
index 5a32a288bc..1d52211b9a 100644
--- a/doc/guides/sample_app_ug/l2_forward_event.rst
+++ b/doc/guides/sample_app_ug/l2_forward_event.rst
@@ -85,20 +85,20 @@ issue the command:
 
 .. code-block:: console
 
-    ./<build_dir>/examples/dpdk-l2fwd-event -l 0-3 -n 4 -- -q 8 -p ffff --mode=poll
+    ./<build_dir>/examples/dpdk-l2fwd-event -l 0-3 -- -q 8 -p ffff --mode=poll
 
 Eventdev mode with 4 lcores, 16 ports, schedule method ordered and MAC address updating enabled,
 issue the command:
 
 .. code-block:: console
 
-    ./<build_dir>/examples/dpdk-l2fwd-event -l 0-3 -n 4 -- -p ffff --eventq-sched=ordered
+    ./<build_dir>/examples/dpdk-l2fwd-event -l 0-3 -- -p ffff --eventq-sched=ordered
 
 or
 
 .. code-block:: console
 
-    ./<build_dir>/examples/dpdk-l2fwd-event -l 0-3 -n 4 -- -q 8 -p ffff --mode=eventdev --eventq-sched=ordered
+    ./<build_dir>/examples/dpdk-l2fwd-event -l 0-3 -- -q 8 -p ffff --mode=eventdev --eventq-sched=ordered
 
 Refer to the *DPDK Getting Started Guide* for general information on running
 applications and Environment Abstraction Layer (EAL) options.
@@ -116,7 +116,7 @@ The following is the sample command:
 
 .. code-block:: console
 
-    ./<build_dir>/examples/dpdk-l2fwd-event -l 0-7 -s 0-3 -n 4 --vdev event_sw0 -- -q 8 -p ffff --mode=eventdev --eventq-sched=ordered
+    ./<build_dir>/examples/dpdk-l2fwd-event -l 0-7 -s 0-3 --vdev event_sw0 -- -q 8 -p ffff --mode=eventdev --eventq-sched=ordered
 
 Explanation
 -----------
diff --git a/doc/guides/sample_app_ug/l2_forward_job_stats.rst b/doc/guides/sample_app_ug/l2_forward_job_stats.rst
index 6a19d4ba9d..23448f23a4 100644
--- a/doc/guides/sample_app_ug/l2_forward_job_stats.rst
+++ b/doc/guides/sample_app_ug/l2_forward_job_stats.rst
@@ -99,7 +99,7 @@ and thousands separator printing, issue the command:
 
 .. code-block:: console
 
-    $ ./<build_dir>/examples/dpdk-l2fwd-jobstats -l 0-3 -n 4 -- -q 8 -p ffff -l
+    $ ./<build_dir>/examples/dpdk-l2fwd-jobstats -l 0-3 -- -q 8 -p ffff -l
 
 Refer to the *DPDK Getting Started Guide* for general information on running applications
 and the Environment Abstraction Layer (EAL) options.
diff --git a/doc/guides/sample_app_ug/l2_forward_real_virtual.rst b/doc/guides/sample_app_ug/l2_forward_real_virtual.rst
index 9823bfe1ac..dbe880e1b3 100644
--- a/doc/guides/sample_app_ug/l2_forward_real_virtual.rst
+++ b/doc/guides/sample_app_ug/l2_forward_real_virtual.rst
@@ -116,7 +116,7 @@ updating enabled, issue the command:
 
 .. code-block:: console
 
-    $ ./<build_dir>/examples/dpdk-l2fwd -l 0-3 -n 4 -- -q 8 -p ffff
+    $ ./<build_dir>/examples/dpdk-l2fwd -l 0-3 -- -q 8 -p ffff
 
 To run the application in linux environment with 4 lcores, 4 ports, 8 RX queues
 per lcore, to forward RX traffic of ports 0 & 1 on ports 2 & 3 respectively and
@@ -124,7 +124,7 @@ vice versa, issue the command:
 
 .. code-block:: console
 
-    $ ./<build_dir>/examples/dpdk-l2fwd -l 0-3 -n 4 -- -q 8 -p f --portmap="(0,2)(1,3)"
+    $ ./<build_dir>/examples/dpdk-l2fwd -l 0-3 -- -q 8 -p f --portmap="(0,2)(1,3)"
 
 Refer to the *DPDK Getting Started Guide* for general information on running applications
 and the Environment Abstraction Layer (EAL) options.
diff --git a/doc/guides/sample_app_ug/l3_forward.rst b/doc/guides/sample_app_ug/l3_forward.rst
index 6f3cca7a9c..9b0d0350aa 100644
--- a/doc/guides/sample_app_ug/l3_forward.rst
+++ b/doc/guides/sample_app_ug/l3_forward.rst
@@ -157,7 +157,7 @@ To enable L3 forwarding between two ports, assuming that both ports are in the s
 
 .. code-block:: console
 
-    ./<build_dir>/examples/dpdk-l3fwd -l 1,2 -n 4 -- -p 0x3 --config="(0,0,1),(1,0,2)" --rule_ipv4="rule_ipv4.cfg" --rule_ipv6="rule_ipv6.cfg"
+    ./<build_dir>/examples/dpdk-l3fwd -l 1,2 -- -p 0x3 --config="(0,0,1),(1,0,2)" --rule_ipv4="rule_ipv4.cfg" --rule_ipv6="rule_ipv6.cfg"
 
 In this command:
 
@@ -188,13 +188,13 @@ the following is the sample command:
 
 .. code-block:: console
 
-    ./<build_dir>/examples/dpdk-l3fwd -l 0-3 -n 4 -a <event device> -- -p 0x3 --eventq-sched=ordered --rule_ipv4="rule_ipv4.cfg" --rule_ipv6="rule_ipv6.cfg"
+    ./<build_dir>/examples/dpdk-l3fwd -l 0-3 -a <event device> -- -p 0x3 --eventq-sched=ordered --rule_ipv4="rule_ipv4.cfg" --rule_ipv6="rule_ipv6.cfg"
 
 or
 
 .. code-block:: console
 
-    ./<build_dir>/examples/dpdk-l3fwd -l 0-3 -n 4 -a <event device> \
+    ./<build_dir>/examples/dpdk-l3fwd -l 0-3 -a <event device> \
 		-- -p 0x03 --mode=eventdev --eventq-sched=ordered --rule_ipv4="rule_ipv4.cfg" --rule_ipv6="rule_ipv6.cfg"
 
 In this command:
@@ -218,7 +218,7 @@ scheduler. The following is the sample command:
 
 .. code-block:: console
 
-    ./<build_dir>/examples/dpdk-l3fwd -l 0-7 -S 16-19 -n 4 --vdev event_sw0 -- -p 0x3 --mode=eventdev --eventq-sched=ordered --rule_ipv4="rule_ipv4.cfg" --rule_ipv6="rule_ipv6.cfg"
+    ./<build_dir>/examples/dpdk-l3fwd -l 0-7 -S 16-19 --vdev event_sw0 -- -p 0x3 --mode=eventdev --eventq-sched=ordered --rule_ipv4="rule_ipv4.cfg" --rule_ipv6="rule_ipv6.cfg"
 
 In case of eventdev mode, *--config* option is not used for ethernet port
 configuration. Instead, each ethernet port will be configured with this
diff --git a/doc/guides/sample_app_ug/l3_forward_graph.rst b/doc/guides/sample_app_ug/l3_forward_graph.rst
index 91bb5387ce..57afdf2e9c 100644
--- a/doc/guides/sample_app_ug/l3_forward_graph.rst
+++ b/doc/guides/sample_app_ug/l3_forward_graph.rst
@@ -93,7 +93,7 @@ To enable L3 forwarding between two ports, assuming that both ports are in the s
 
 .. code-block:: console
 
-    ./<build_dir>/examples/dpdk-l3fwd-graph -l 1,2 -n 4 -- -p 0x3 --config="(0,0,1),(1,0,2)"
+    ./<build_dir>/examples/dpdk-l3fwd-graph -l 1,2 -- -p 0x3 --config="(0,0,1),(1,0,2)"
 
 In this command:
 
@@ -119,7 +119,7 @@ To enable pcap trace on each graph, use following command:
 
 .. code-block:: console
 
-    ./<build_dir>/examples/dpdk-l3fwd-graph -l 1,2 -n 4 -- -p 0x3 --config="(0,0,1),(1,0,2)" --pcap-enable --pcap-num-cap=<number of packets> --pcap-file-name "</path/to/file>"
+    ./<build_dir>/examples/dpdk-l3fwd-graph -l 1,2 -- -p 0x3 --config="(0,0,1),(1,0,2)" --pcap-enable --pcap-num-cap=<number of packets> --pcap-file-name "</path/to/file>"
 
 In this command:
 
@@ -134,7 +134,7 @@ before including rte_graph_worker.h. Recompile and use following command:
 
 .. code-block:: console
 
-    ./<build_dir>/examples/dpdk-l3fwd-graph -l 1,2,3,4 -n 4 -- -p 0x1 --config="(0,0,1)" -P --model="dispatch"
+    ./<build_dir>/examples/dpdk-l3fwd-graph -l 1,2,3,4 -- -p 0x1 --config="(0,0,1)" -P --model="dispatch"
 
 To enable graph walking model selection in run-time, remove the define of ``RTE_GRAPH_MODEL_SELECT``. Recompile and use the same command.
 
diff --git a/doc/guides/sample_app_ug/link_status_intr.rst b/doc/guides/sample_app_ug/link_status_intr.rst
index da0cd85572..fd4e32560c 100644
--- a/doc/guides/sample_app_ug/link_status_intr.rst
+++ b/doc/guides/sample_app_ug/link_status_intr.rst
@@ -50,12 +50,12 @@ where,
 
 *   -T PERIOD: statistics will be refreshed each PERIOD seconds (0 to disable, 10 default)
 
-To run the application in a linux environment with 4 lcores, 4 memory channels, 16 ports and 8 RX queues per lcore,
+To run the application in a linux environment with 4 lcores, 16 ports and 8 RX queues per lcore,
 issue the command:
 
 .. code-block:: console
 
-    $ ./<build_dir>/examples/dpdk-link_status_interrupt -l 0-3 -n 4-- -q 8 -p ffff
+    $ ./<build_dir>/examples/dpdk-link_status_interrupt -l 0-3 -- -q 8 -p ffff
 
 Refer to the *DPDK Getting Started Guide* for general information on running applications
 and the Environment Abstraction Layer (EAL) options.
diff --git a/doc/guides/sample_app_ug/multi_process.rst b/doc/guides/sample_app_ug/multi_process.rst
index 1f77dd4bd6..1bd858bfb5 100644
--- a/doc/guides/sample_app_ug/multi_process.rst
+++ b/doc/guides/sample_app_ug/multi_process.rst
@@ -40,7 +40,7 @@ passing at least two cores in the corelist:
 
 .. code-block:: console
 
-    ./<build_dir>/examples/dpdk-simple_mp -l 0-1 -n 4 --proc-type=primary
+    ./<build_dir>/examples/dpdk-simple_mp -l 0-1 --proc-type=primary
 
 For the first DPDK process run, the proc-type flag can be omitted or set to auto,
 since all DPDK processes will default to being a primary instance,
@@ -49,7 +49,7 @@ The process should start successfully and display a command prompt as follows:
 
 .. code-block:: console
 
-    $ ./<build_dir>/examples/dpdk-simple_mp -l 0-1 -n 4 --proc-type=primary
+    $ ./<build_dir>/examples/dpdk-simple_mp -l 0-1 --proc-type=primary
     ...
     EAL: Requesting 2 pages of size 1073741824
     EAL: Requesting 768 pages of size 2097152
@@ -69,7 +69,7 @@ again run the same binary setting at least two cores in the corelist:
 
 .. code-block:: console
 
-    ./<build_dir>/examples/dpdk-simple_mp -l 2-3 -n 4 --proc-type=secondary
+    ./<build_dir>/examples/dpdk-simple_mp -l 2-3 --proc-type=secondary
 
 When running a secondary process such as above,
 the ``proc-type`` parameter can be specified as auto.
@@ -163,10 +163,10 @@ Example:
 
 .. code-block:: console
 
-    # ./<build_dir>/examples/dpdk-symmetric_mp -l 1 -n 4 --proc-type=auto -- -p 3 --num-procs=4 --proc-id=0
-    # ./<build_dir>/examples/dpdk-symmetric_mp -l 2 -n 4 --proc-type=auto -- -p 3 --num-procs=4 --proc-id=1
-    # ./<build_dir>/examples/dpdk-symmetric_mp -l 3 -n 4 --proc-type=auto -- -p 3 --num-procs=4 --proc-id=2
-    # ./<build_dir>/examples/dpdk-symmetric_mp -l 4 -n 4 --proc-type=auto -- -p 3 --num-procs=4 --proc-id=3
+    # ./<build_dir>/examples/dpdk-symmetric_mp -l 1 --proc-type=auto -- -p 3 --num-procs=4 --proc-id=0
+    # ./<build_dir>/examples/dpdk-symmetric_mp -l 2 --proc-type=auto -- -p 3 --num-procs=4 --proc-id=1
+    # ./<build_dir>/examples/dpdk-symmetric_mp -l 3 --proc-type=auto -- -p 3 --num-procs=4 --proc-id=2
+    # ./<build_dir>/examples/dpdk-symmetric_mp -l 4 --proc-type=auto -- -p 3 --num-procs=4 --proc-id=3
 
 .. note::
 
@@ -243,9 +243,9 @@ the commands are:
 
 .. code-block:: console
 
-    # ./<build_dir>/examples/dpdk-mp_server -l 1-2 -n 4 -- -p 3 -n 2
-    # ./<build_dir>/examples/dpdk-mp_client -l 3 -n 4 --proc-type=auto -- -n 0
-    # ./<build_dir>/examples/dpdk-mp_client -l 4 -n 4 --proc-type=auto -- -n 1
+    # ./<build_dir>/examples/dpdk-mp_server -l 1-2 -- -p 3 -n 2
+    # ./<build_dir>/examples/dpdk-mp_client -l 3 --proc-type=auto -- -n 0
+    # ./<build_dir>/examples/dpdk-mp_client -l 4 --proc-type=auto -- -n 1
 
 .. note::
 
diff --git a/doc/guides/sample_app_ug/ptpclient.rst b/doc/guides/sample_app_ug/ptpclient.rst
index 38f0479a0f..0df465bcb4 100644
--- a/doc/guides/sample_app_ug/ptpclient.rst
+++ b/doc/guides/sample_app_ug/ptpclient.rst
@@ -65,7 +65,7 @@ To run the example in a ``linux`` environment:
 
 .. code-block:: console
 
-    ./<build_dir>/examples/dpdk-ptpclient -l 1 -n 4 -- -p 0x1 -T 0
+    ./<build_dir>/examples/dpdk-ptpclient -l 1 -- -p 0x1 -T 0
 
 Refer to *DPDK Getting Started Guide* for general information on running
 applications and the Environment Abstraction Layer (EAL) options.
diff --git a/doc/guides/sample_app_ug/qos_scheduler.rst b/doc/guides/sample_app_ug/qos_scheduler.rst
index 36ada4902c..cd33beecb0 100644
--- a/doc/guides/sample_app_ug/qos_scheduler.rst
+++ b/doc/guides/sample_app_ug/qos_scheduler.rst
@@ -180,7 +180,7 @@ The following is an example command with a single packet flow configuration:
 
 .. code-block:: console
 
-    ./<build_dir>/examples/dpdk-qos_sched -l 1,5,7 -n 4 -- --pfc "3,2,5,7" --cfg ./profile.cfg
+    ./<build_dir>/examples/dpdk-qos_sched -l 1,5,7 -- --pfc "3,2,5,7" --cfg ./profile.cfg
 
 This example uses a single packet flow configuration which creates one RX thread on lcore 5 reading
 from port 3 and a worker thread on lcore 7 writing to port 2.
@@ -189,7 +189,7 @@ Another example with 2 packet flow configurations using different ports but shar
 
 .. code-block:: console
 
-   ./<build_dir>/examples/dpdk-qos_sched -l 1,2,6,7 -n 4 -- --pfc "3,2,2,6,7" --pfc "1,0,2,6,7" --cfg ./profile.cfg
+   ./<build_dir>/examples/dpdk-qos_sched -l 1,2,6,7 -- --pfc "3,2,2,6,7" --pfc "1,0,2,6,7" --cfg ./profile.cfg
 
 Note that independent cores for the packet flow configurations for each of the RX, WT and TX thread are also supported,
 providing flexibility to balance the work.
diff --git a/doc/guides/sample_app_ug/rxtx_callbacks.rst b/doc/guides/sample_app_ug/rxtx_callbacks.rst
index 2e784848f5..cd6512508b 100644
--- a/doc/guides/sample_app_ug/rxtx_callbacks.rst
+++ b/doc/guides/sample_app_ug/rxtx_callbacks.rst
@@ -38,7 +38,7 @@ To run the example in a ``linux`` environment:
 
 .. code-block:: console
 
-    ./<build_dir>/examples/dpdk-rxtx_callbacks -l 1 -n 4 -- [-t]
+    ./<build_dir>/examples/dpdk-rxtx_callbacks -l 1 -- [-t]
 
 Use -t to enable hardware timestamping. If not supported by the NIC, an error
 will be displayed.
diff --git a/doc/guides/sample_app_ug/skeleton.rst b/doc/guides/sample_app_ug/skeleton.rst
index ca6cddfed6..5f7f18dbc2 100644
--- a/doc/guides/sample_app_ug/skeleton.rst
+++ b/doc/guides/sample_app_ug/skeleton.rst
@@ -27,7 +27,7 @@ To run the example in a ``linux`` environment:
 
 .. code-block:: console
 
-    ./<build_dir>/examples/dpdk-skeleton -l 1 -n 4
+    ./<build_dir>/examples/dpdk-skeleton -l 1
 
 Refer to *DPDK Getting Started Guide* for general information on running
 applications and Environment Abstraction Layer (EAL) options.
diff --git a/doc/guides/sample_app_ug/timer.rst b/doc/guides/sample_app_ug/timer.rst
index d8c6d9a656..7af35d3d67 100644
--- a/doc/guides/sample_app_ug/timer.rst
+++ b/doc/guides/sample_app_ug/timer.rst
@@ -21,7 +21,7 @@ To run the example in linux environment:
 
 .. code-block:: console
 
-    $ ./<build_dir>/examples/dpdk-timer -l 0-3 -n 4
+    $ ./<build_dir>/examples/dpdk-timer -l 0-3
 
 Refer to the *DPDK Getting Started Guide* for general information on running applications and
 the Environment Abstraction Layer (EAL) options.
diff --git a/doc/guides/sample_app_ug/vdpa.rst b/doc/guides/sample_app_ug/vdpa.rst
index 38be28945d..cd3ec99054 100644
--- a/doc/guides/sample_app_ug/vdpa.rst
+++ b/doc/guides/sample_app_ug/vdpa.rst
@@ -54,7 +54,7 @@ Take IFCVF driver for example:
 
 .. code-block:: console
 
-        ./dpdk-vdpa -l 1 -n 4 --numa-mem 1024,1024 \
+        ./dpdk-vdpa -l 1 --numa-mem 1024,1024 \
                 -a 0000:06:00.3,vdpa=1 -a 0000:06:00.4,vdpa=1 \
                 -- --interactive
 
diff --git a/doc/guides/sample_app_ug/vhost.rst b/doc/guides/sample_app_ug/vhost.rst
index ec2805a0c9..4c944a844a 100644
--- a/doc/guides/sample_app_ug/vhost.rst
+++ b/doc/guides/sample_app_ug/vhost.rst
@@ -60,7 +60,7 @@ Start the vswitch example
 
 .. code-block:: console
 
-        ./dpdk-vhost -l 0-3 -n 4 --numa-mem 1024  \
+        ./dpdk-vhost -l 0-3 --numa-mem 1024  \
              -- --socket-file /tmp/sock0 --client \
              ...
 
diff --git a/doc/guides/sample_app_ug/vm_power_management.rst b/doc/guides/sample_app_ug/vm_power_management.rst
index e0af729e66..1955140bb3 100644
--- a/doc/guides/sample_app_ug/vm_power_management.rst
+++ b/doc/guides/sample_app_ug/vm_power_management.rst
@@ -186,7 +186,7 @@ Hypervisor Channel Configuration
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Configure ``virtio-serial`` channels using ``libvirt`` XML.
-The XML structure is as follows: 
+The XML structure is as follows:
 
 .. code-block:: XML
 
@@ -275,11 +275,11 @@ than the EAL options:
 
 The application requires exactly two cores to run. One core for the CLI
 and the other for the channel endpoint monitor. For example, to run on
-cores 0 and 1 on a system with four memory channels, issue the command:
+cores 0 and 1 on a system, issue the command:
 
 .. code-block:: console
 
-   ./<build_dir>/examples/dpdk-vm_power_mgr -l 0-1 -n 4
+   ./<build_dir>/examples/dpdk-vm_power_mgr -l 0-1
 
 After successful initialization, the VM Power Manager CLI prompt appears:
 
@@ -365,7 +365,7 @@ physical CPU mask:
    set_pcpu_mask {vm_name} {vcpu} {pcpu}
 
 Set the binding of the virtual CPU on the VM to the physical CPU:
- 
+
   .. code-block:: console
 
    set_pcpu {vm_name} {vcpu} {pcpu}
@@ -587,7 +587,7 @@ host, use a command like the following:
 
 .. code-block:: console
 
-   ./<build_dir>/examples/dpdk-guest_vm_power_mgr -l 0-3 -n 4 -- --vm-name=ubuntu --policy=BRANCH_RATIO --vcpu-list=2-4
+   ./<build_dir>/examples/dpdk-guest_vm_power_mgr -l 0-3 -- --vm-name=ubuntu --policy=BRANCH_RATIO --vcpu-list=2-4
 
 Once the VM Power Manager Guest CLI appears, issuing the 'send_policy now' command
 will send the policy to the host:
@@ -701,7 +701,7 @@ To start the application and configure the power policy, and send it to the host
 
 .. code-block:: console
 
- ./<build_dir>/examples/dpdk-guest_vm_power_mgr -l 0-3 -n 4 -- --vm-name=ubuntu --policy=BRANCH_RATIO --vcpu-list=2-4
+ ./<build_dir>/examples/dpdk-guest_vm_power_mgr -l 0-3 -- --vm-name=ubuntu --policy=BRANCH_RATIO --vcpu-list=2-4
 
 Once the VM Power Manager Guest CLI appears, issuing the 'send_policy now' command
 will send the policy to the host:
diff --git a/doc/guides/sample_app_ug/vmdq_dcb_forwarding.rst b/doc/guides/sample_app_ug/vmdq_dcb_forwarding.rst
index 9638f51dec..efb133c11c 100644
--- a/doc/guides/sample_app_ug/vmdq_dcb_forwarding.rst
+++ b/doc/guides/sample_app_ug/vmdq_dcb_forwarding.rst
@@ -72,7 +72,7 @@ To run the example in a linux environment:
 
 .. code-block:: console
 
-    user@target:~$ ./<build_dir>/examples/dpdk-vmdq_dcb -l 0-3 -n 4 -- -p 0x3 --nb-pools 32 --nb-tcs 4
+    user@target:~$ ./<build_dir>/examples/dpdk-vmdq_dcb -l 0-3 -- -p 0x3 --nb-pools 32 --nb-tcs 4
 
 Refer to the *DPDK Getting Started Guide* for general information on running applications and
 the Environment Abstraction Layer (EAL) options.
diff --git a/doc/guides/sample_app_ug/vmdq_forwarding.rst b/doc/guides/sample_app_ug/vmdq_forwarding.rst
index ed28525a15..c998a5a223 100644
--- a/doc/guides/sample_app_ug/vmdq_forwarding.rst
+++ b/doc/guides/sample_app_ug/vmdq_forwarding.rst
@@ -56,7 +56,7 @@ To run the example in a Linux environment:
 
 .. code-block:: console
 
-    user@target:~$ ./<build_dir>/examples/dpdk-vmdq -l 0-3 -n 4 -- -p 0x3 --nb-pools 16
+    user@target:~$ ./<build_dir>/examples/dpdk-vmdq -l 0-3 -- -p 0x3 --nb-pools 16
 
 Refer to the *DPDK Getting Started Guide* for general information on running applications and
 the Environment Abstraction Layer (EAL) options.
diff --git a/doc/guides/testpmd_app_ug/run_app.rst b/doc/guides/testpmd_app_ug/run_app.rst
index 330c37f2d9..82f61b133c 100644
--- a/doc/guides/testpmd_app_ug/run_app.rst
+++ b/doc/guides/testpmd_app_ug/run_app.rst
@@ -20,7 +20,7 @@ They must be separated from the EAL options, shown in the previous section, with
 
 .. code-block:: console
 
-    sudo ./dpdk-testpmd -l 0-3 -n 4 -- -i --portmask=0x1 --nb-cores=2
+    sudo ./dpdk-testpmd -l 0-3 -- -i --portmask=0x1 --nb-cores=2
 
 The command line options are:
 
diff --git a/doc/guides/tools/flow-perf.rst b/doc/guides/tools/flow-perf.rst
index 41eae15470..c0c7ffe577 100644
--- a/doc/guides/tools/flow-perf.rst
+++ b/doc/guides/tools/flow-perf.rst
@@ -58,7 +58,7 @@ with a ``--`` separator:
 
 .. code-block:: console
 
-	sudo ./dpdk-test-flow_perf -n 4 -a 08:00.0 -- --ingress --ether --ipv4 --queue --rules-count=1000000
+	sudo ./dpdk-test-flow_perf -a 08:00.0 -- --ingress --ether --ipv4 --queue --rules-count=1000000
 
 The command line options are:
 
-- 
2.47.2

