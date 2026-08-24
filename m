Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789BFC5DF81
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 16:15:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62C7540270;
	Mon, 24 Aug 2026 18:15:31 +0200 (CEST)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id ADA5B400D6
 for <dev@dpdk.org>; Mon, 24 Aug 2026 18:15:30 +0200 (CEST)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2d5655cc850so41594065ad.3
 for <dev@dpdk.org>; Mon, 24 Aug 2026 09:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787588129;
 x=1788192929; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8DghZ6O5DUgly0hvtjEBgjgGxxjBozaCJK3LoxD+y0E=;
 b=Ca6/V5FVTt3htpH8xlyF/Jpu8L28VZQ8lQxgqjIog7p+0jxMfiskDvD2xTsiOxDh7E
 WTl9RES1G5Yrxp0eMc05lT3bUBNJwM/CKrE8U0yelHBQubzAaaHLwuK5yRAXtzLei6Ef
 AGevCV5mZC4LWb8eSI2xmvB15M76GZsqESWVPwTkuZxgi61IBP76IcLKLxlnTRdFWs32
 UFjSAbhfOe3/giJwPSvCAbGerkxod1NQ5b+dhm9dCZQ/IJfTzxwhRvSRsoo2pUTD7Auf
 Vhy7c++n7iB3H2b0NNylEMooLhIpffR9xpiwC2zqF58A5qRvBxcXt9c5SohxnX7NW0od
 0Axg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787588129; x=1788192929;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8DghZ6O5DUgly0hvtjEBgjgGxxjBozaCJK3LoxD+y0E=;
 b=Rd1IHlJcdVSAZ/Lu+B8IzEvWVoMSDtfTPAGuIWbVxCBoLdTUzALS5ZlMFkN8km1z0K
 qnedEzTJeqziYcOw/VkMyAlBbl6TM0u9Mons3pq+mOQeAmsCPfWdixkQraH9qE7BifE5
 Zq2Y3DrSdptyQJfNVUq21Yc1r+wBpAYugtlyXUHI3+fMB6EPrn1AJhnwhw7WV5QgOn2V
 p1WIfhh/hTZdxbeVc8I7Obit2kv44Og7qrSEBWkB9fZK2hAakJ4ypKBPH2tJWfDQQ5E6
 ugcbVWJxxcYwMjBhOPywG5SuFqCb9mX7CYLmeQnDk+71u0EJry2L2jxSfrb/I39ll/Re
 DrIQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rohy7u8/rdMmi2PTm+a6RXccfyY8dfopFXacuFweRYHRmU2oYM50KR8REXhQD+eyjMhVlc=@dpdk.org
X-Gm-Message-State: AFuF++n6V1z6Pi6dyCBnsygTzrREi3ysdTfeWCMOyuio3fLczTPNeONe
 Vuee5CZ4kZT9Y/m7DUJ169/IETbPVcbdAyUIGAxiyJw+Hk/gnDa6cGScnhzBbaS3tF0=
X-Gm-Gg: AR+sD11hqZgD1Xi3uO80TGwIQIZU0uEOxlTqpFESSKdTqNqRMb8luQGgvMoeNqjacPQ
 lsh/63LWlU7nmLuaSf7f0gXaefDRts5euBeVM5L5K/sZyBE5uusZVyKTG3v6LYz5C3u58PrnDLe
 tk5oobb59bsZIxwCCR21SoyvyzUC9+Ty7CW5Ue/+YIxPm1GkR50nbG96CkygQQycqxzyqYpkDkw
 DK/P7gVkTM+/eyhoHi6SJur2PbIeaVmsyVwwcQ5qJq420tJ0Hpv3+y9GJhQUgJpcjj+Rp4OAyfU
 uugjj2gY5PGwPhuR54wLeFiRi/LYP7H+YYbzoP7D5mUT0XNtNXktj+3AUYN4OdkbREPgVs/aBG1
 ZQ6rGMJ+N1bmmo/k7CX6jc6SKdKRRKN6OIRI6bSkqc11GY+wOWgEIIBJBl9Ac/AnOWZsuK3JBof
 kaai70xHxjUXqulSat6e4K/V6B48t8bAea7ccZtPUQz/Ed7GrETTTf5wN50pv5SKbCNTU2CcJPr
 Kl0sBDaJvHe8oR8nF0zjSoV1RDL0A==
X-Received: by 2002:a17:903:19c7:b0:2b7:975c:dacc with SMTP id
 d9443c01a7336-2d64ada9e7bmr542868405ad.1.1787588129620; 
 Mon, 24 Aug 2026 09:15:29 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d676761bc7sm20005375ad.14.2026.08.24.09.15.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 09:15:29 -0700 (PDT)
Date: Mon, 24 Aug 2026 09:15:19 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Weijun Pan <wpan3636@gmail.com>
Cc: Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)"
 <humin29@huawei.com>, Anatoly Burakov <anatoly.burakov@intel.com>,
 dev@dpdk.org
Subject: Re: [RFC PATCH v2] net/bonding: restrict secondary control operations
Message-ID: <20260824091519.45ab3fd7@phoenix.local>
In-Reply-To: <20260823151625.18687-1-wpan3636@gmail.com>
References: <20260708174204.72574-1-wpan3636@gmail.com>
 <20260823151625.18687-1-wpan3636@gmail.com>
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

On Sun, 23 Aug 2026 10:16:25 -0500
Weijun Pan <wpan3636@gmail.com> wrote:

> The bonding PMD currently supports secondary attach with safe fallback
> burst functions, but bonding configuration and LACP state are owned by
> the primary process.
> 
> Use a secondary-specific dev_ops table so unsupported operations are
> rejected by ethdev before PMD callbacks can mutate shared device state.
> Also reject bonding-specific control APIs from non-primary processes,
> while keeping secondary detach and query paths available.
> 
> This keeps secondary process behavior safe while leaving room for future
> limited datapath support.
> 
> Bugzilla ID: 1900
> 
> Signed-off-by: Weijun Pan <wpan3636@gmail.com>
> ---

More indepth AI review with Fable saw some possible issues.

Review: [RFC PATCH v2] net/bonding: restrict secondary control operations

Applies cleanly to main, builds with -Dwerror=true. The secondary
dev_ops table is a good approach; everything left in it is read-only
against shared memory, and bond_ethdev_close() already returns early
for non-primary so dev_close stays safe.

Warning: prog guide describes a secondary datapath that does not exist

  "Secondary process datapath support is limited and bonding mode
  specific ... unless support for the selected mode is explicitly
  documented."

  bond_probe() installs bond_ethdev_rx_secondary() (returns 0) and
  bond_ethdev_tx_secondary() (frees and returns nb_pkts) for every
  mode. There is no mode with datapath support. Say that plainly:

  Rx and Tx are not supported on a bonding device in a secondary
  process; receive returns no packets and transmit drops them.

Warning: LACP query paths return zeroed state in a secondary process

  bond_mode_8023ad_ports[] is a plain global array, populated only in
  the primary. rte_eth_bond_8023ad_member_info(), _ext_collect_get()
  and _ext_distrib_get() validate against shared internals (which
  pass), then read actor/partner state from the secondary's untouched
  copy and return all zeros with rc 0. bond_ethdev_priv_dump(), kept
  in secondary_dev_ops, prints the same zeros through dump_lacp().

  Since the patch's premise is that query paths are safe in a
  secondary, either give these three the same bond_8023ad_check_primary()
  guard (and drop eth_dev_priv_dump from secondary_dev_ops or make
  dump_lacp() skip in secondary), or document that LACP per-member
  state is only visible to the primary.

Warning: rte_eth_bond_api.c: two blank lines after
  bond_api_check_primary(). checkpatch will flag it.

Info: three spellings of the same test

  rte_eth_bond_pmd.c already open-codes rte_eal_process_type() in
  bond_ethdev_mode_set(), bond_ethdev_close(), bond_probe() and
  bond_remove(). This patch adds bond_process_is_primary() plus two
  near-identical logging wrappers with different return values (-1
  and -ENOTSUP). The return values match each file's conventions, so
  not wrong, but one helper in eth_bond_private.h taking the error
  code would remove the duplication.

Info: link_update writes shared state from the secondary

  bond_ethdev_link_update() assigns ethdev->data->dev_link fields
  directly. Keeping it in secondary_dev_ops means a secondary calling
  rte_eth_link_get() races the primary on that shared struct.
  Pre-existing behaviour, but worth a thought given the patch's
  "must not change device state" rule.

----------------------------------------------------------------------
Suggested commit message (the Bugzilla entry has the background;
no need to restate it):

net/bonding: restrict secondary control operations

Bonding configuration and LACP state are owned by the primary
process. Install a reduced dev_ops table in secondary processes so
ethdev rejects control operations, and reject the bonding control
API when called from a non-primary process. Query and detach remain
available.

Bugzilla ID: 1900

----------------------------------------------------------------------
Suggested release note:

* **Restricted bonding device control to the primary process.**

  Secondary processes can query and detach a bonding device but can no
  longer change its configuration.

