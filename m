Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BACCAC5B8
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Oct 2025 12:45:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 26C56402D1;
	Mon,  6 Oct 2025 14:45:25 +0200 (CEST)
Received: from mail-wm1-f102.google.com (mail-wm1-f102.google.com
 [209.85.128.102])
 by mails.dpdk.org (Postfix) with ESMTP id 8D508402B1
 for <dev@dpdk.org>; Mon,  6 Oct 2025 14:45:23 +0200 (CEST)
Received: by mail-wm1-f102.google.com with SMTP id
 5b1f17b1804b1-46e3af7889fso29964675e9.2
 for <dev@dpdk.org>; Mon, 06 Oct 2025 05:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1759754723; x=1760359523; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=01gOPC/KLVTlSwUziukd5E09bJVqZQDKeph1DsREltU=;
 b=hc+tLkSM5Mgy6dvC1+dH4nI99xcbeWccLlCDh70uEGe9wxV8ew2XXogOvvqbkCX0sg
 h1fv5DcSpy6yEt4smtwKDxRFQgxwD1cJhvp3dNoOeht2hVgRgoCscIp2ZQ1byiZrZL31
 8mKEdPxjlqdT7TEUBDa/+2hAPlFgBvcae6Kbbp5yUhOCkemgpoBa5QYcxZnwn55jCSck
 NhIaZ2TiBquPztMMR5uIhy0lHB7B1KQbdQKCuQSxYINn0zxTKDqM9xlXKg96j7gaEPID
 QtosiFkeB2Dql6XOPiZMKmFS2VfQwVRZQSC9gfeJB0r1P+ZDlQyQRFgQlMeeNajCa3Fu
 xaOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759754723; x=1760359523;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=01gOPC/KLVTlSwUziukd5E09bJVqZQDKeph1DsREltU=;
 b=JfRKskNdvCAMl1nOWtOImejYHB7lL/OVVp4JLpL+RI8cboUggSSrWpqmJWY+o+vtpc
 Ef1iKL7q75/IqpVs/y3wvTnlJvfdm1EJM3vj4XjAkum5Tsbzitc/Sq7pU9y+YP2tz3Y6
 4/f+3GQnVue8eo806WWzpwi1yn0S+XpTL3JHhmGCSTyW+mkQm0DViSB+Bao8q6mH+Kh2
 KTXkxvmik0SjMyULK7j530N9hcgFm5joZ+uhNFkRGMG6zu5/KM3oR9WUjjHJXRyn0WET
 EmsPAUpiDv/ZO31exgz10wH9E7Pck5/B1AZ3rXQEDf15oxMcFS27wZq5kUcjRXSTjZ48
 5sXw==
X-Gm-Message-State: AOJu0YySigdXWk+QgRKGluj09jCRPapaX0VRuDjEbf13oN2IX8Mox2rG
 5dLJMglXvN1EHhMHnwhKeJRiSGRPpo0Oq5QdRnJQOnFC6J26QavZucdbUywdhi57rQkLmfmgPK3
 5kzimDJQwdvZ74MwtAOUCvApEvgNsAouNF+DUtJkZ5LF9+Q==
X-Gm-Gg: ASbGncu5HfDc5Ol/mljIWprb3sExeZiYocBV5i5QUI8L2TgSiAbty0y7GjKZ6EEO99O
 6FS+yqDc7mOyqSsAHkh0giFScREJWupvb3Wk1CNShmbh5EHzoXQLYhQJ7wNm1SkoHCtJffqNoOK
 1VscE6f/4UNKpZL6tEI8I2fEEt8HRDUnMgs7RAWK5GWVqBr254JkM/DI8UhgKm0pXRVLODIe0c0
 Hr10oAlfirxB+sibKNCH46E/oNyr1R3KredIjpuY39w89vsv22TOW+evQ0RWbXkxahBoG023q3Y
 RckLtEoCPc1eB5GbLuen//yEngToqtMlUmq3dFOn19BzDgfMDR1hRcxfix5AmzbYJpjVN891AY4
 kgvbcv/JQiYt5h9vXxCKATjBv
X-Google-Smtp-Source: AGHT+IHLBus2BWFUc7n5TROBZZWvqrkU0pl2OXOewUXo2swPZqeqTtWgoQFcz/qwgdje2P8Z6jmcxuVN6uCF
X-Received: by 2002:a05:600c:c178:b0:45d:f81d:eae7 with SMTP id
 5b1f17b1804b1-46e71168c41mr74856735e9.28.1759754722969; 
 Mon, 06 Oct 2025 05:45:22 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
 by smtp-relay.gmail.com with ESMTP id
 ffacd0b85a97d-4255d8e0babsm944332f8f.39.2025.10.06.05.45.22; 
 Mon, 06 Oct 2025 05:45:22 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from localhost (vader.dev.6wind.com [10.17.1.39])
 by smtpservice.6wind.com (Postfix) with ESMTP id 97A05116BA;
 Mon,  6 Oct 2025 14:45:22 +0200 (CEST)
From: Thierry Herbelot <thierry.herbelot@6wind.com>
To: dev@dpdk.org
Cc: Thierry Herbelot <thierry.herbelot@6wind.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Bruce Richardson <bruce.richardson@intel.com>,
 David Marchand <david.marchand@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Olivier Matz <olivier.matz@6wind.com>
Subject: [PATCH] net/intel/e1000: reduce the optimization level for gcc > 11
Date: Mon,  6 Oct 2025 14:45:06 +0200
Message-Id: <20251006124506.388456-1-thierry.herbelot@6wind.com>
X-Mailer: git-send-email 2.39.2
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

The e1000 PMD stopped working under Ubuntu-24.04 (using gcc-13) when
compiled with -O3 (default level for all DPDK code). There is a crash
when starting testpmd:

(gdb) bt
#0  rte_read32_relaxed (addr=0x1100800e00) at ../sources/lib/eal/include/generic/rte_io.h:290
#1  rte_read32 (addr=0x1100800e00) at ../sources/lib/eal/include/generic/rte_io.h:345
#2  e1000_read_addr (addr=0x1100800e00) at ../sources/drivers/net/intel/e1000/base/e1000_osdep.h:106
#3  e1000_id_led_init_generic (hw=0x1586788c0) at ../sources/drivers/net/intel/e1000/base/e1000_mac.c:1844
#4  0x000062aaf653c85f in e1000_init_hw_82540 (hw=0x1586788c0)
    at ../sources/drivers/net/intel/e1000/base/e1000_82540.c:308
#5  0x000062aaf6db8227 in em_hardware_init (hw=hw@entry=0x1586788c0)
    at ../sources/drivers/net/intel/e1000/em_ethdev.c:920
#6  0x000062aaf65340ff in em_hw_init (hw=0x1586788c0) at ../sources/drivers/net/intel/e1000/em_ethdev.c:445
#7  eth_em_dev_init (eth_dev=eth_dev@entry=0x62aaff346000 <rte_eth_devices>)
    at ../sources/drivers/net/intel/e1000/em_ethdev.c:314
#8  0x000062aaf6db8b71 in rte_eth_dev_pci_generic_probe (private_data_size=11240,
    dev_init=0x62aaf6db8310 <eth_em_dev_init>, pci_dev=0x62ab2853dd90) at ../sources/lib/ethdev/ethdev_pci.h:150
#9  eth_em_pci_probe (pci_drv=<optimized out>, pci_dev=0x62ab2853dd90)
    at ../sources/drivers/net/intel/e1000/em_ethdev.c:365
#10 0x000062aaf646adf5 in rte_pci_probe_one_driver (dr=dr@entry=0x62aaf82d8020 <rte_em_pmd>,
    dev=dev@entry=0x62ab2853dd90) at ../sources/drivers/bus/pci/pci_common.c:299
#11 0x000062aaf6a15f7d in pci_probe_all_drivers (dev=0x62ab2853dd90) at ../sources/drivers/bus/pci/pci_common.c:383
#12 pci_probe () at ../sources/drivers/bus/pci/pci_common.c:410
#13 0x000062aaf7a485f3 in rte_bus_probe () at ../sources/lib/eal/common/eal_common_bus.c:84
#14 0x000062aaf670585d in rte_eal_init (argc=argc@entry=146, argv=argv@entry=0x7fffca468898)
    at ../sources/lib/eal/linux/eal.c:1253

The crash is linked to the use of gcc-13: uner Ubuntu-24.04 testpmd
compiled with gcc-11 from the same DPDK tree works as expected.

The perfect solution would be for someone to investigate why the
PMD crashes. However, this depends on Maintainer availability.

A less-perfect solution is to reduce the optimization level
(like another proposal for net/qede: see Link).

Note: if more regressions are seen in less-frequently used PMDs,
      maybe we should switch the default optimization level to -O1,
      (tree-wide) and only rise the optimization level for actively
      maintained PMDs, which are proven to work as expected with
      higher optimization levels.

Link: http://patches.dpdk.org/project/dpdk/patch/20250909054023.3263401-1-thierry.herbelot@6wind.com/
Signed-off-by: Thierry Herbelot <thierry.herbelot@6wind.com>
---
 drivers/net/intel/e1000/base/meson.build | 4 ++++
 drivers/net/intel/e1000/meson.build      | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/net/intel/e1000/base/meson.build b/drivers/net/intel/e1000/base/meson.build
index 4fe86dc6df34..e3631f1adc27 100644
--- a/drivers/net/intel/e1000/base/meson.build
+++ b/drivers/net/intel/e1000/base/meson.build
@@ -22,3 +22,7 @@ base_sources = files(
         'e1000_phy.c',
         'e1000_vf.c',
 )
+# testpmd crashes with gcc > 11 with compiling with default -O3 or -O2
+if (cc.get_id() == 'gcc' and cc.version().version_compare('>=12.0'))
+    base_cflags += '-O1'
+endif
diff --git a/drivers/net/intel/e1000/meson.build b/drivers/net/intel/e1000/meson.build
index 924fe4ecaef5..3a875d1555c2 100644
--- a/drivers/net/intel/e1000/meson.build
+++ b/drivers/net/intel/e1000/meson.build
@@ -23,3 +23,8 @@ if not is_windows
                 'igc_txrx.c',
         )
 endif
+
+# testpmd crashes with gcc > 11 with compiling with default -O3 or -O2
+if (cc.get_id() == 'gcc' and cc.version().version_compare('>=12.0'))
+    cflags += '-O1'
+endif
-- 
2.39.2

