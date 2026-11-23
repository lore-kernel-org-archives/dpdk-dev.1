Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17C5606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Nov 2026 18:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Rl5MO3AY
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1508C4027E;
	Mon, 23 Nov 2026 19:43:33 +0100 (CET)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mails.dpdk.org (Postfix) with ESMTPS id 8D0ED4027A
 for <dev@dpdk.org>; Mon, 23 Nov 2026 19:43:31 +0100 (CET)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-8a06cc097c7so2505699b3a.0
 for <dev@dpdk.org>; Mon, 23 Nov 2026 10:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1795459410;
 x=1796064210; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ldlMS65b/Msy5spt/RzDLTr0VuVO/LE6sIqklPbigZA=;
 b=Rl5MO3AYptu/ECVvmBypzAodrP5Ot2Fq1io3BSoidZ3uo0a09RT3BcMO9NgBAYskpb
 dHYI/5hVq8ECGhW7pEj7ceFhAujZXLVyaUp5Yq8zsqKuh73BWiCPIfyhqrDtCq2fKegs
 qsyYdD7b2ch4yBSTkz4qZIK7xB3aREni3cAqiImbrJLmDRKcDOIifFnhIo+yVHtE/c78
 Vfel7tUvK4Y1R+gWKJpsyjw+9ZWmG5L+JrE29jb5k4CxHPvRo0ICkSO5Ej2vkjz5yj09
 oXbFB2IYM4Ha5BaF3OouxOgbvvryz0/W5ACicJ98j81shU2MSoRzs4LfutMEwubvRDlM
 x/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795459410; x=1796064210;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ldlMS65b/Msy5spt/RzDLTr0VuVO/LE6sIqklPbigZA=;
 b=V4zDIybGFT/qzaq9BaCan6ZU1pb/awbTnWkReIJWIEGEt6ERs7Q8vceuqtp2uCAQ7v
 4eaGmvnArqCqZKH0ILPKUf6Ujt2dNHHxEBN4WPAx1kzerFZgHXRhX9VAf8uO/fitTf4Z
 0EwOaUiB5NKdgcPfB+GKfwhwlhrX/uIB3Tl6ee+zUfBLA1ebkZG+sxqqnQVYMTuaHNhH
 Via8GpSxalyYWlbbjVD0pC/bWF7vmEHpCFeoitpTmEHGACU6uMucp+xSuzZ5fvdnUcet
 NIyRxpo8CEQ9zRbcKBQq/Q/FTGpOU6YT+a2iPLQTiWb4WzLtGLD9wjwneUSZLzUjr0Hn
 JtSg==
X-Gm-Message-State: APuU4Z+r3yd9pnWZ1okDG4Qk7kv1xGFkFlG6pJokyrV6fPnveGCiaNSt
 gRaqoUrckZ36sUtfLWmWhvC4wzix5xHPPRfYobJirA6IJVBcjGbodsw3Cn4kF1q9Jjs=
X-Gm-Gg: AZFdTZdz61j8N9u0Un7Apq8QpcIm3SZ01h/UiPQG+4Xv73FCXBJN/+tayR1sqSe5GXj
 K9acqeSKxpVT1m2hE7HK4OZiCF2FixQADfTKrgAcs+Dffeg5f59/uxDw0+NRK9w73tpTiq3qe1h
 ahL217ZFnN4ZGOnKWuIc8ucEXfQtZ5+pqVteL920JISwOf3bASjcenSPCB6FZVWysLPR11axaYf
 IeEEjZu0llO/yM8YtCbn4TVZDO7f1de7OElijT32Bf+r9nPr76KKV7yqg2u84tYlZqVCwIsA3oR
 gI+XiIGFJHqSGrf+151xLjx//RpvLCG4jx2ry57nJoB80/rB/S2R+Sd9jw8Cdiuln2Re1P2n0n/
 SIqNPb6VkgFKkyG1nR/vhI34kFqZTwm5kLReidOhMctt9wmUJZ+SNNgqDUuvZxOAOtKHx3NvFZW
 JQ6Sl0ZcUG2DdbQj3iGXvFeyUP6q4k4RBxairyX78fwoFVf79K+byJVNflyS874lMD4C0J0FDmD
 WudGlc5J5PR+iZfmDdzbpB9lue2fciyVRvP7Ai44j8hFlJDKDXfGAkiL7+sHhuA1m20vo6xc4rY
 AKgMqSyhTYnGe1AWWTH5fzVvzIPovU5g+znyT+LLirL62zqt1LaWPNV5SvW6jYjA46gIh+fFyfq
 4uIiW2huNJCat/TmW
X-Received: by 2002:a05:6a00:138f:b0:8b3:ce6d:8481 with SMTP id
 d2e1a72fcca58-8c87b4eea9cmr12159554b3a.16.1795459409749; 
 Mon, 23 Nov 2026 10:43:29 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c87343f726sm6283383b3a.36.2026.11.23.10.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 10:43:29 -0800 (PST)
Date: Mon, 23 Nov 2026 10:43:27 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ajit Kumar <Ajit.Kumar@amd.com>
Cc: <dev@dpdk.org>
Subject: Re: [PATCH] [PATCH v3] net/axgbe: wait for SFP cage I2C readiness
 on first probe
Message-ID: <20261123104327.4e45da0d@phoenix.local>
In-Reply-To: <20261123115224.2199549-1-Ajit.Kumar@amd.com>
References: <20261119173506.840405-1-Ajit.Kumar@amd.com>
 <20261123115224.2199549-1-Ajit.Kumar@amd.com>
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 23 Nov 2026 17:22:24 +0530
Ajit Kumar <Ajit.Kumar@amd.com> wrote:

> From: Ajit Kumar <ajit.kumar@amd.com>
> 
> A port's first I2C access to its SFP cage after axgbe_phy_start() can
> fail with a quick NACK (-ENOTCONN) or a stall until the 1-second I2C
> timeout (-ETIMEDOUT). This is distinct from the cross-port race fixed
> by the driver-wide I2C/MDIO bus mutex: it reproduces on a single port
> with no sibling active, right after that port's own phy_start().
> 
> v2 retried these codes inside axgbe_phy_i2c_read(), gated by a flag
> set on first success. Two problems: the flag lives in phy_data,
> allocated once at probe and never cleared across phy_start()/
> phy_stop(), so it doesn't track the access it's meant to gate; and a
> device that never responds never sets it, so a persistent fault pays
> the extra retry on every later link_update() poll, unbounded. The
> retry also ran while holding the bus mutex, blocking other ports for
> its duration, the concern raised against the original combined patch.
> 
> Drop the retry and the flag. Instead, wait briefly in
> axgbe_phy_start() before the first SFP probe, before the bus mutex is
> even taken. Fixed, known cost per phy_start(), no state to go stale,
> nothing held while waiting. axgbe_phy_i2c_read() reverts to its
> original -EAGAIN-only retry, unchanged.
> 
> Fixes: a5c7273771e8 ("net/axgbe: add phy programming APIs")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ajit Kumar <ajit.kumar@amd.com>
> ---
> Depends on the driver-wide I2C/MDIO bus mutex from "net/axgbe:
> serialize PHY and link status access" for the cross-port case;
> applies independently otherwise.
> 
> v3: dropped the retry/flag design, replaced with a settle delay before
> the first SFP probe in axgbe_phy_start(), outside the bus mutex.
> axgbe_phy_i2c_read() is unchanged from upstream.
> v2: gated the extended retry with a per-port settled flag (bounded to
> first access, per CI bot); switched to a real sleep; shortened the
> comment.

Yes, dealing with real hardware is hard, and seems reasonable.

AI review said:

Subject: Re: [PATCH v3] net/axgbe: wait for SFP cage I2C readiness on first probe

Applies on top of the bus mutex patch and builds clean. A delay
before the first probe is the right shape, and it fixes both v2
problems. But nothing says what the delay waits for, and nothing
shows that 2ms is enough.

Warning

The delay is not tied to any hardware event. axgbe_i2c_start() only
sets pdata->i2c.started, and the controller is enabled separately for
each transfer in axgbe_i2c_xfer(). So "after starting the I2C
controller" there is nothing new to settle. Before the delay,
axgbe_phy_set_mode() has already run the redriver programming (I2C or
MDIO) and a firmware rate change mailbox command that it waits on.
Whatever the expander is waiting for, it is not i2c_start().

Please say what the cage is waiting for: power or reset release
after phy_stop(), the mux left on a channel, or firmware still using
the bus after the rate change. Then wait for that condition instead
of a fixed delay. If a fixed delay really is the only option, say
where 2ms comes from, such as a datasheet value or measured margin.

v3 has no test result. The v2 validation was for a different change.
Please report results for this exact patch on the CRB and FWA-1081,
including whether the -ETIMEDOUT case (a full 1s stall) goes away
with a 2ms pre-delay. That would be surprising and needs data.

Info

The second paragraph of the commit message is v2 history; move it
below "---". The commit message should describe this change only.

The subject has "[PATCH] [PATCH v3]"; use --subject-prefix="PATCH v3"
or -v3 only.

The new comment can be one line once the cause is known, for example:

	/* SFP GPIO expander needs <N>us after <event> */

