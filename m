Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BA5C982FF
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 13:34:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E7F8427B0;
	Tue, 22 Sep 2026 15:34:07 +0200 (CEST)
Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com
 [74.125.228.41]) by mails.dpdk.org (Postfix) with ESMTP id BFD7B402C8
 for <dev@dpdk.org>; Tue, 22 Sep 2026 15:34:05 +0200 (CEST)
Received: by mail-pz2-f41.google.com with SMTP id
 d2e1a72fcca58-8674704dab1so5540175b3a.2
 for <dev@dpdk.org>; Tue, 22 Sep 2026 06:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790084044;
 x=1790688844; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kaRW/NKs6HpIDIY/psfWB+5cKhECqn6gX/Ed8L1Vdcg=;
 b=JWPJpsxdu00XTqTlnEqOsdKe31wqpZ3gxJt37HBjpbx5yXdgS/+A7m/aE6hYcU0HjG
 PL2sp9TbRRCE+D5AoFIjNTVIMzofJeHkJGcjP2lZC67QK5VKe/sUnHkvA7R3vGucSBSo
 T0/vcBvLO96D5q6WyYuOKzmYRiTzvcy4rnvKGTHp8pp+iJzWnIyvLJ6Ne0bmV2QVDFHC
 aMug/qhcEJO2f31au5C0JN1lvfraWB9QgrycrXianJgF2cQFbJ3wVpdWY320Un4ha1cr
 6bR5BwDnDaUy+idwKLRiDlshYCpVofW8ZE6f0H8LuFROxO0TDNwDKqRSe3UrwIzdbxC2
 pA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790084044; x=1790688844;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kaRW/NKs6HpIDIY/psfWB+5cKhECqn6gX/Ed8L1Vdcg=;
 b=t4vBFclcNdXgKsZ157BEtO6szgW0ckq2RfDUXDEsd2dmVznmwbgrUirLdGG2J/tw90
 169UDP72d1rIKJ2scjCwb529PPj77FuvenyzMoTRKQSnhId+O1ZfZGTWurrrJ6EdXtWz
 5TKRgOLIJe/0nvb6wb32Kdzb2zXhQU/PKK7xQhha4pL/9y+j81LXY6tFKTBp+CLAnKX/
 wKr/wUx2Oec55tdpznjO9ypN5utLZVtGwvwPNe8vhizS8i/mLxwjVGn5VnRC1e+ve8GB
 Cs54tlM6E0KWXLcYQHUywC+J72rOErDf20Sfq6VCVPGPfoySg4QLpUTw8xmKDDsbBwbt
 xYtw==
X-Gm-Message-State: AFuF++mYObOalYiHI0tMmLEe/5im6eMbyge03Pt17GtSt9J//jJR7y5c
 Z92w288xCLHj0cMahleAyq9cVGQ8wvkEEKp97ZS+hd5yHHYonuX7WlmmHUF8A9VDM2M=
X-Gm-Gg: AYBFou1OqXSyhajVg/w+QSWpPXa5f2UACTcvdWa1m3Uwi/xH3pklhKarPOhQ/jg59bH
 2k+1KaxL0QE6dLDJ9sXtJdBbUH/wx0As8vWp+XaHvO7k/DeZwZp5b+sUbhyYqRgVYPBxR30SUnK
 gEcolWcwxv04IZG476RsjUkwEP90AkJrjjMR+KCkyB0z9vLbfDxamA9oZXLwtPU2HKHyjlDRL8p
 NA/n4KO/XxxyTf9H38NHCGgxDY2V4rxMos1nqYaH3dG1aav2V9UQQmcUWbuC++jqtfENC+7rItj
 8WK4gy5B1v/LTkUefI+Zvpj/kft0DQQQ4+GaSAc3PWlsuUnNM65juQLGFaTmrzHIcQcpXAXJN70
 l5n7AJvcE3d3G2s5zm2GHRdgaMQhOhGDSm2S/sVRf3TDz6gaVnSlPQfCl9jYlPB5gkWSMu+8h9Q
 Y6HOTYwDosb+vEZ6DZPsUAgxFtZTn2i87WK36tU6DenqaexJa3O9CTjSaMmEN1ez9rOS1d5Gf+L
 2shSAvKaz6vMc55m9fHY2c52qx4O7X7Zuw3RGLd
X-Received: by 2002:a05:6a00:b94:b0:878:34d7:6a36 with SMTP id
 d2e1a72fcca58-87c8472a581mr1316020b3a.42.1790084044621; 
 Tue, 22 Sep 2026 06:34:04 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87c32abf966sm870227b3a.39.2026.09.22.06.34.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 06:34:03 -0700 (PDT)
Date: Tue, 22 Sep 2026 06:34:01 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH] net/ring: remove internal devarg
Message-ID: <20260922063401.6f2faa98@phoenix.local>
In-Reply-To: <20260922113614.2952557-1-bruce.richardson@intel.com>
References: <20260922113614.2952557-1-bruce.richardson@intel.com>
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

On Tue, 22 Sep 2026 12:36:14 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> The devarg "internal" was used to pass a pointer to the creation
> function to reuse set parameters. However, this meant it could also be
> used as a devarg on the commandline leading to incorrect behaviour.
> Redesign the passing of the args parameters to use a per-thread global
> instead. The wrapper function sets the global to a valid value before
> calling the main creation function, skipping passing a devarg, before
> resetting the pointer back to NULL when the function returns.
> 
> Bugzilla ID: 1687
> Fixes: 96cb19521147 ("net/ring: use EAL APIs in PMD specific API")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

Minor nits from Opus review:

Review: [PATCH] net/ring: remove internal devarg
Patchwork: 169914

Applies cleanly to main, builds with -Dwerror=true. Fixes tag hash
96cb19521147 verified. Removing a user-reachable devarg that is
dereferenced as a raw pointer is the right fix.

Warning

The per-lcore pointer is still set while user callbacks run.
do_eth_dev_ring_create() calls rte_eth_dev_probing_finish(), which
fires RTE_ETH_EVENT_NEW callbacks synchronously on the same thread.
If a callback calls rte_vdev_init("net_ring_foo", "nodeaction=...")
the nested probe sees eth_ring_internal_args != NULL, ignores the
user's devargs, and attaches net_ring_foo to the outer caller's
rings.

Clear the pointer in probe right after reading it:

	internal_args = RTE_PER_LCORE(eth_ring_internal_args);
	RTE_PER_LCORE(eth_ring_internal_args) = NULL;
	if (internal_args != NULL) {

Keep the reset after rte_vdev_init() in rte_eth_from_rings() to
cover the paths where probe is never reached (-EEXIST, no driver
match). This also makes the comment "consumed and cleared by probe"
true; as written, probe does not clear it.

Alternatively add the vdev name to struct ring_internal_args and
require a match in probe. Either works; clearing is simpler.

Info

No test coverage. app/test/test_pmd_ring.c could add a case that
"net_ring_x,internal=0x1" no longer dereferences the value (it now
falls into the "Ignoring unsupported parameters" path).

Double space before "*/" in the comment above
RTE_DEFINE_PER_LCORE.
