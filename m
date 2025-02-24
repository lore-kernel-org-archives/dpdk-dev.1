Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2134C021BB
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 20:19:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD44F40EE2;
	Mon, 24 Feb 2025 21:19:03 +0100 (CET)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by mails.dpdk.org (Postfix) with ESMTP id CBA3340DD0
 for <dev@dpdk.org>; Mon, 24 Feb 2025 21:19:02 +0100 (CET)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-220c8cf98bbso15606985ad.1
 for <dev@dpdk.org>; Mon, 24 Feb 2025 12:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740428342;
 x=1741033142; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=siYwfsJzB1G85oMGKr5WLWc6HZuLzoFABD0py+0uZW0=;
 b=sXdHkHKpipxMt5rcWDP/xm9o5DRA6Ac4CmqSM9vLf5gN+hSRYa0EKqcPNqRRFx0vR6
 RQQARlltrsLMajPCwBuJkFJvCGODL7uvqRCdzTrCcAIAVgrxhbmcbfIZxnpZurg7rY43
 kIzEpbYSew+DRfnXMMcQAlGKENofYqllB7jWD1zgji66xDJux/+Cj3GyOVSy2WVD+0FK
 KRfob3yXtsrn6jZUUlJ2vDMWcaqdWj4S/ac3Ks2Zgm/c7LZ14DVjsB/p6UCwGzOFhtSL
 t4vxH203bW9ZcvQyXmW+jCe6QtzS+K1UpI9VnITqfWkSvCiF5MQE7h0o+72eqwVjzEIe
 MefQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740428342; x=1741033142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=siYwfsJzB1G85oMGKr5WLWc6HZuLzoFABD0py+0uZW0=;
 b=tXyzBYdsDhu+spF2lQgxALdw6wfbJqoGYJbuiDAEsacdmrrWSXHhhd4fg9ngoFxM0r
 4tn0jKrW2WnIiaGZiR3O7/wpGCQpjzYY8Y7pt9vRwVMbj9ugEDbdoNxJTezAAmTsj0mp
 /8EgdmtdpNvkTjSpS+BXDkNdhswX95A23klizAf3+Ofi6wF7oUdDmmQGAl0xZTBJBjlW
 83tqpe+tT5t7RKhtV6tdYyzILKy3v6UuQIeqQHzxtTSwWySMdhLDa7o0445GNmmihOu4
 DAf7uqFW0WlYpN0DnGZUCFl1gcEw8i76jtqFiuiCF6doLznUZPQ34lATiKm8j7p4UVHb
 GP7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIw+U/GVMMutsalrmixc1ZMRsoZq4nAIJyKTmleKlB5B3jX0mu5+LOA0sHd4m2f5isQ34=@dpdk.org
X-Gm-Message-State: AOJu0Yxi07KIRLUjwd0SX7PmuduF1HfSoRJdW++dcWUL4GuqU5teT5KL
 zDoIoqA8w1nM6lVELyFLtYogNVPoXkNJpzlkaS27n+fpXQoJV4jJUuLHIpt5qOc=
X-Gm-Gg: ASbGnctHYdnwdB0iZLb8SKEUebBkaJCOweo9rLh9zyWY7gZKkBNLGt9mY9uIYyEZdS+
 /X586HkRJM3zf7g2OxrvNfeaC4fzc8IVzj9S2wpTDQFKM4Jle1wqoYHORZkzRKKQ+d+YxuR0ESC
 g0YGsd7oANUe67swyoh0/sCPR3uoUCTM9NzrECxZbm+d1Y/bzTvMZL3XrQ8DRc6nETStB/MfEQz
 mufT5/IZxCXbrMwPqYHdvvZHOuw22yQekVN3dbiLCC/hWGXjZ8ejNV1UcVin/HwBjDA48Lvhi6K
 UAETQrXmMV2Kqt8HfVIlFL1JHfAtekk+FTnL+XMGkqR3kqvLfIwMGQmTFxp3cQJwA1HcPux0if6
 sX2Q=
X-Google-Smtp-Source: AGHT+IF6hjhh/TBsFVTub8665RdCgCrBr5MVX3BZ0yS8IRwQV01JAypNfcGsO367NmPrCrUPJQ3SjQ==
X-Received: by 2002:a17:902:d503:b0:21f:f02:413c with SMTP id
 d9443c01a7336-221a11737a6mr250183695ad.42.1740428341716; 
 Mon, 24 Feb 2025 12:19:01 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2230a0007b9sm195745ad.15.2025.02.24.12.19.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 12:19:01 -0800 (PST)
Date: Mon, 24 Feb 2025 12:18:57 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: "11" <caowenbo@mucse.com>
Cc: <thomas@monjalon.net>, <dev@dpdk.org>, <ferruh.yigit@amd.com>,
 <andrew.rybchenko@oktetlabs.ru>, <yaojun@mucse.com>
Subject: Re: [PATCH v13 00/28] [v13]drivers/net Add Support mucse N10 Pmd
 Driver
Message-ID: <20250224121857.22e51b36@hermes.local>
In-Reply-To: <7965B24DF5ABB77F+000101db8355$35272be0$9f7583a0$@mucse.com>
References: <1739951849-67601-1-git-send-email-caowenbo@mucse.com>
 <20250219081435.3c780063@hermes.local>
 <7965B24DF5ABB77F+000101db8355$35272be0$9f7583a0$@mucse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Thu, 20 Feb 2025 13:06:30 +0800
"11" <caowenbo@mucse.com> wrote:

> Hi Stephen,
> 
> For the release thing, that be ok.
> 
> But for Debian 12 with MUSDK it be failed, do I need to fixed it ,
> The ability when I used it that I had been memset it. But the compile-tool
> is warning it,
>  hw->phy_port_ids[idx] = ability.port_ids[idx];
> 
> Branch: master
> CommitID:968f7b6d7b6a7e60e6e551db430c4eecaccbbfd2
> 
> 151613-151639 --> testing issues
> 
> Upstream job id: Generic-DPDK-Compile-Meson#362983
> 
> Test environment and result as below:
> 
> +----------------------------------------+--------------------+
> |              Environment               | dpdk_meson_compile |
> +========================================+====================+
> | RHEL9 (ARM)                            | PASS               |
> +----------------------------------------+--------------------+
> | Ubuntu 20.04 ARM GCC Cross Compile     | PASS               |
> +----------------------------------------+--------------------+
> | Ubuntu 20.04 ARM SVE                   | PASS               |
> +----------------------------------------+--------------------+
> | Debian 12 with MUSDK                   | FAIL               |
> +----------------------------------------+--------------------+
> | Fedora 40 (ARM Clang)                  | PASS               |
> +----------------------------------------+--------------------+
> | Fedora 41 (ARM Clang)                  | PASS               |
> +----------------------------------------+--------------------+
> | Fedora 41 (ARM)                        | PASS               |
> +----------------------------------------+--------------------+
> | Fedora 40 (ARM)                        | PASS               |
> +----------------------------------------+--------------------+
> | Ubuntu 20.04 (ARM)                     | PASS               |
> +----------------------------------------+--------------------+
> | Ubuntu 22.04 (ARM)                     | PASS               |
> +----------------------------------------+--------------------+
> | Ubuntu 24.04 (ARM)                     | PASS               |
> +----------------------------------------+--------------------+
> | CentOS Stream 9 (ARM)                  | PASS               |
> +----------------------------------------+--------------------+
> | CentOS Stream 10 (ARM)                 | PASS               |
> +----------------------------------------+--------------------+
> | Debian 11 (Buster) (ARM)               | PASS               |
> +----------------------------------------+--------------------+
> | Ubuntu 20.04 ARM Clang Cross Compile   | PASS               |
> +----------------------------------------+--------------------+
> | Ubuntu 20.04 aarch32 GCC Cross Compile | PASS               |
> +----------------------------------------+--------------------+
> | Debian 12 (arm)                        | PASS               |
> +----------------------------------------+--------------------+
> 
> ==== 20 line log output for Debian 12 with MUSDK (dpdk_meson_compile): ====
> [888/1284] Linking static target drivers/libtmp_rte_net_r8169.a [889/1284]
> Generating rte_net_r8169.pmd.c with a custom command [890/1284] Compiling C
> object drivers/librte_net_r8169.a.p/meson-generated_.._rte_net_r8169.pmd.c.o
> [891/1284] Linking static target drivers/librte_net_r8169.a [892/1284]
> Compiling C object
> drivers/librte_net_r8169.so.25.1.p/meson-generated_.._rte_net_r8169.pmd.c.o
> [893/1284] Linking target drivers/librte_net_r8169.so.25.1 [894/1284]
> Compiling C object drivers/net/rnp/base/librnp_base.a.p/rnp_mbx.c.o
> [895/1284] Compiling C object
> drivers/net/rnp/base/librnp_base.a.p/rnp_fw_cmd.c.o
> [896/1284] Compiling C object
> drivers/net/rnp/base/librnp_base.a.p/rnp_mbx_fw.c.o
> FAILED: drivers/net/rnp/base/librnp_base.a.p/rnp_mbx_fw.c.o
> ccache aarch64-linux-gnu-gcc -Idrivers/net/rnp/base/librnp_base.a.p
> -Idrivers/net/rnp/base -I../drivers/net/rnp/base -I. -I.. -Iconfig
> -I../config -Ilib/eal/include -I../lib/eal/include -Ilib/eal/linux/include
> -I../lib/eal/linux/include -Ilib/eal/arm/include -I../lib/eal/arm/include
> -I../kernel/linux -Ilib/eal/common -I../lib/eal/common -Ilib/eal
> -I../lib/eal -Ilib/kvargs -I../lib/kvargs -Ilib/log -I../lib/log
> -Ilib/metrics -I../lib/metrics -Ilib/telemetry -I../lib/telemetry -Ilib/net
> -I../lib/net -Ilib/mbuf -I../lib/mbuf -Ilib/mempool -I../lib/mempool
> -Ilib/ring -I../lib/ring -Ilib/ethdev -I../lib/ethdev -Ilib/meter
> -I../lib/meter -fdiagnostics-color=always -pipe -D_FILE_OFFSET_BITS=64 -Wall
> -Winvalid-pch -Wextra -Werror -std=c11 -O3 -include rte_config.h -Wvla
> -Wcast-qual -Wdeprecated -Wformat -Wformat-nonliteral -Wformat-security
> -Wmissing-declarations -Wmissing-prototypes -Wnested-externs
> -Wold-style-definition -Wpointer-arith -Wsign-compare -Wstrict-prototypes
> -Wundef -Wwrite-st  rings -Wno-packed-not-aligned
> -Wno-missing-field-initializers -D_GNU_SOURCE -fPIC -mcpu=cortex-a72
> -DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API -Wno-format-truncation
> -Wno-address-of-packed-member -DRTE_LIBRTE_IXGBE_BYPASS -Wno-unused-value
> -Wno-unused-but-set-variable -Wno-unused-parameter -MD -MQ
> drivers/net/rnp/base/librnp_base.a.p/rnp_mbx_fw.c.o -MF
> drivers/net/rnp/base/librnp_base.a.p/rnp_mbx_fw.c.o.d -o
> drivers/net/rnp/base/librnp_base.a.p/rnp_mbx_fw.c.o -c
> ../drivers/net/rnp/base/rnp_mbx_fw.c
> ../drivers/net/rnp/base/rnp_mbx_fw.c: In function
> 'rnp_mbx_fw_get_capability':
> ../drivers/net/rnp/base/rnp_mbx_fw.c:257:65: error: 'ability' may be used
> uninitialized [-Werror=maybe-uninitialized]
> 257 |                         hw->phy_port_ids[idx] = ability.port_ids[idx];
> |                                                 ~~~~~~~~~~~~~~~~^~~~~
> ../drivers/net/rnp/base/rnp_mbx_fw.c:235:38: note: 'ability' declared here
> 235 |         struct rnp_phy_abilities_rep ability;
> |                                      ^~~~~~~
> cc1: all warnings being treated as errors
> ninja: build stopped: subcommand failed.
> ==== End log output ====

Yes, it looks like a compiler bug.  Unfortunately, DPDK has to workaround
issues with buggy compilers 

some times.
Maybe just do this instead

diff --git a/drivers/net/rnp/base/rnp_mbx_fw.c b/drivers/net/rnp/base/rnp_mbx_fw.c
index 4f351ce960..185bf4dee8 100644
--- a/drivers/net/rnp/base/rnp_mbx_fw.c
+++ b/drivers/net/rnp/base/rnp_mbx_fw.c
@@ -232,7 +232,7 @@ rnp_fw_get_phy_capability(struct rnp_eth_port *port,
 
 int rnp_mbx_fw_get_capability(struct rnp_eth_port *port)
 {
-       struct rnp_phy_abilities_rep ability;
+       struct rnp_phy_abilities_rep ability = { };
        struct rnp_hw *hw = port->hw;
        u32 is_sgmii_bits = 0;
        bool is_sgmii = false;
@@ -243,7 +243,6 @@ int rnp_mbx_fw_get_capability(struct rnp_eth_port *port)
        u8 lane_idx;
        u32 idx;
 
-       memset(&ability, 0, sizeof(ability));
        err = rnp_fw_get_phy_capability(port, &ability);
        if (!err) {
                hw->lane_mask = ability.lane_mask;



