Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE4F606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=RtPH0CCL
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D34D440A6C;
	Fri, 23 Oct 2026 18:02:00 +0200 (CEST)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id 37AB640A67
 for <dev@dpdk.org>; Fri, 23 Oct 2026 18:01:59 +0200 (CEST)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-3ac5b090d16so601794a91.0
 for <dev@dpdk.org>; Fri, 23 Oct 2026 09:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792771318;
 x=1793376118; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=u/d8YWL5vXKPHWBMPDV5PsiWtzfuRsOfcs+uirkPamw=;
 b=RtPH0CCLuUY1qcIM3ojCZIwJsVAn1UtLGzrv7NYiHOySmkGN8SKPr/lKAwFMuD4P4R
 SZSBXvKv5kKF6Tp4kVS0GNsP+/9WNG2r5efpVqZoz8eII5NhoaZPAl1EcenHgVMG18JV
 0pNSHBjibD9ZJxqt7QV8xYQZ7JADa9uKFz5/2Fs37d/BHuYDTC4qu/hiYux6acaf+qoD
 2wDn8a1h8Lp5STiqvPGq7ZI+3baSi7XG7CVZs0RuHa5lQa3AUrbM/J0+venQNQ+RVNjW
 WgZKZKUuaaXb1Vy0m92yDvNzGlaa7Dc16+0V+Rye4hHi30A2yNTKQbllzg70pYjY19Ak
 eztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792771318; x=1793376118;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u/d8YWL5vXKPHWBMPDV5PsiWtzfuRsOfcs+uirkPamw=;
 b=LEwtcxLyAOq3C6BjD1jsfg+A32HH8gUgVJSTOI/89Ym9TZJSVGJqvUp4+xySFPfeUp
 cCqEwNeH3HP52pcOzAMsO3Dx7sgQLqlNDywhdbr/8XPyKmGa1+b8018iHCF/T9420XE6
 O6Py/q7Dfn1nQeD13qaQhZAGUIUAo2BUohVsvLByR2AfsHDYe4qyvy6ejuw15ENf2XXo
 zX7/3kdq4FjHAMcfnH2oiDBUjZJiq75lAb7Hv8nibgmL9CRZiUQq7VklU/aAFdKZU5aQ
 OesVcFcuJBqUTzGxclop1R0tPZjGjJVX5+bdh2nLc9+urtkcnVZlSyjE+KHHECmFqsU3
 Wn8Q==
X-Gm-Message-State: AFq9FYL0Eo4btUm9qT+aJ8zIOQ8p6m/liph7AadttcgHYdfvn3/+6rw+
 JUJ1cF90mggId6kGbJm+X9zAzMrBL8tNaf6kbC8VyVYM6A7PEvyR2HXN/lRtzybzOQWl1b+Ahpg
 l0OSUh24=
X-Gm-Gg: AYBFou22Mu7dkAsbq6se2kC8zrVO6P3R5cnN18L7Gdfm4P2OOrua+KaFmRlHpKtQMIj
 SFUjQB0NInjVtD69RnDW9I8xMd+O1WcBSTJ/D2jueo2/rlKcgKfGi29e7oHPQUAb5E+eQfehhqc
 N3sX0sr8aZgGQ/MLzcL+utTS6kqGhwfK1Dgn/j4joK9z/ZNSLyvrmub3+CvUA7F/6aZjXRAPrK/
 XRnfVxOra8+cwahigE7BjiyiaayNJwbFW/RndLP5pvMWPkAoEf+oN+7eNA6pD3tx9fz1d1t0iQ+
 9PJHiSURYg8k8ZQaB0CVZ0yed3sCLQeJssAW3BTW+0anx08YSRArKd2zE9S/QDDJAu5XHhH4w4y
 21gFoBC/UebXYQvHbjwaHRx8F91XBgGMZdX+2VvRn0YZjnVHCFyHpuTkES7jWxa3Bj6A+9Fr9SA
 cVyew+u1CuWtWGGk2taDONG+gNgt0thV3v3D34ELA+TrPqmxpU4anP/JaoYnsJE/76bwscVpT/X
 6mfpQIc4vG0un5u8MOnuVFqMkIAJ4u0XIVWo8xA+nlPJkcZZDf3JtrIQZi67ivV1VXn/rJ1IfiQ
 dlacou5Mvs0AuUWYel7Bzg==
X-Received: by 2002:a17:90b:57e3:b0:3ac:b622:9638 with SMTP id
 98e67ed59e1d1-3adce7eb02fmr1309631a91.42.1792771317999; 
 Fri, 23 Oct 2026 09:01:57 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ea94751ddasm2201055ad.28.2026.10.23.09.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 09:01:56 -0700 (PDT)
Date: Fri, 23 Oct 2026 09:01:39 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v10 00/17] Wangxun fixes and new features
Message-ID: <20261023090117.34672036@phoenix.local>
In-Reply-To: <3C29C180B4E33816+20261023110728.3975-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <3C29C180B4E33816+20261023110728.3975-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 23 Oct 2026 19:03:38 +0800
Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:

> This series addresses link-related issues on Wangxun Amber-lite 25G/40G NICs (CR/KR training, hot-plug, 10G link state).
> 
> ---
> v10:
>  - P12: check the FFE taps against the register field width of the MAC in
>         use, instead of only for the 40G one. On the Sapphire the main and
>         pre taps are six-bit fields and the post tap is seven-bit, so a
>         larger value spills into the neighbouring field rather than being
>         truncated.
>  - P12/P13: say "Amber-Lite 40G NIC" for bp_capa and laser_off, the only
>         MAC that implements either.
>  - P17: add a new patch to rename fiber_suppport_speed to fiber_support_speed.
>         The field was added with the misspelling in 234ce0d1fa, copied from the
>         out-of-tree base driver.

Most of it is fine, but you still are keeping a driver specific behavior around PHY
control which was identified as not acceptable in an earlier review.

I object to cases where driver writers treat their PMD as a unique and special case
because that would end up tying the user application to a specific PMD
and it makes it harder for users to manage and write code.

If there is a missing feature in the ethdev management layer, then control operations
and offloads should be added there and drivers should all work against that.

The current AI review reflects that.

Subject: Re: [PATCH v10 00/17] net/txgbe: Amber-Lite link fixes

Series applies cleanly to main and every commit builds with
-Dwerror=true. All Fixes: hashes resolve.

The v8 comments on 02, 03, 10, 15 and 16 are addressed. The
NEED_LINK_CONFIG fix in 16 is correct.

Patches 01-11 and 14-17 look good. 12 and 13 still need work.


Errors
------

[PATCH v10 13/17] net/txgbe: add devarg to turn off Tx laser for AML40

NAK on the devarg still stands.

The new paragraph says it is opt-in because link setup resets the
PHY and restarts AN73 on the next link-up. set_link_up() is a
control path operation, and the application asked for the link to
come back up. Renegotiation is the expected cost of that.

Leaving the transmitter on is the bug. With the laser on,
rte_eth_dev_set_link_down() does not take the link down, and the
peer cannot see the loss of signal. Drivers should not each pick
their own meaning for set_link_down.

Remove TXGBE_DEVARG_LASER_OFF and hw->devarg.laser_off. Disable the
transmitter unconditionally on AML40 link down, and in
txgbe_dev_set_link_up() run:

	if (hw->mac.type == txgbe_mac_aml40) {
		speed = hw->phy.autoneg_advertised;
		...
		err = hw->mac.setup_link(hw, speed, true);
		...
	}

Drop the doc and release note entries with it.


Info
----

[PATCH v10 12/17] net/txgbe: add pre2 FFE tap and backplane capability devargs

The new FFE range checks log at ERR level but still store the value.
On Sapphire an ffe_pre above 0x3F still runs into the main field
through "ffe_main << 8 | ffe_pre". Fall back to the default, as is
already done for bp_capa:

	if (ffe_pre > 0x3F) {
		PMD_INIT_LOG(ERR, "devarg '%s' value %u exceeds 0x3F",
			     TXGBE_DEVARG_FFE_PRE, ffe_pre);
		ffe_pre = 8;
	}

The bp_capa explanation in the commit message is fine.
