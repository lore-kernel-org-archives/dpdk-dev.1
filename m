Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906C6606A320
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Nov 2026 16:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=EOe3Los9
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55CEA402D6;
	Thu, 19 Nov 2026 17:36:46 +0100 (CET)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by mails.dpdk.org (Postfix) with ESMTPS id A8BB2400D7
 for <dev@dpdk.org>; Thu, 19 Nov 2026 17:36:45 +0100 (CET)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-cdddc79a4afso1184626a12.1
 for <dev@dpdk.org>; Thu, 19 Nov 2026 08:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1795106204;
 x=1795711004; darn=dpdk.org; 
 h=content-type:mime-version:references:in-reply-to:message-id:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JUne8gAERlMw3BdtOzRQdwDsg4sHeQCWro1D5UGbruA=;
 b=EOe3Los9DRhCuJ1ffA5kKYkEbtDTcnIeXPCPThk/fyMomuwkgGgepfdrWqcfSS6O9k
 ZoYr1NY1odFqhdquMrHAgTy4qqSVIKAckWdU+T3fjaoUVEI1699KxSBCVuc7jXg+7QnZ
 7w9G8hyQYvEDKVjva4dlYhz2nR95Up0rmKZrq4+AAklFE7B9EZrMiTHNxxPX+u0V6yIC
 DdktHTL8yEDwQPGIMRQMuV15h4Qrpr8rFkSrHjoku60dpr30DduGnUBee0YA3DYWbZ8V
 fd80pkBhZw4W5TsXiJSK3TR/fGhepSC92ZYoGz/1+NuW2wnS6uUMBhVlqcvjo64jHnWh
 wLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795106204; x=1795711004;
 h=content-type:mime-version:references:in-reply-to:message-id:subject
 :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JUne8gAERlMw3BdtOzRQdwDsg4sHeQCWro1D5UGbruA=;
 b=xol5YfBp7o7lXv+OSM61hJpsax0pFy/3l6SlalIUPRpRjGDaZ27P1QqVJNlpvP9JeA
 ZhACmG10zG+oGNuCd4vnQqir5vfXd1tRS+nq/DdDkG1Kah8VgzhFymkaCto47TzL17sf
 Y4/On7VkfJlbPrxIMu/Hp9ot1qYM6y1NAmsVcB7McFIPoDyoWwZjoJjFVSZV2q6VXf66
 3T16yCTYDuY23pBKUzAFNYalycybQmuoiYbrqLqPhPnXC2sPAwZQKVfnvuDr0I/YquTv
 xwy2VnwRlE57QpNtC8wH8ov+IyB1LRwm1KUmHjlO2BPDkLo/awvd9u2FCQWBHYqrCFXJ
 Jm4w==
X-Gm-Message-State: APuU4Z/q5bs2BwQb9IgP5eUrjJ9KkxEIwQbWdJiDogu5JiHBtqeCpupx
 My8OGBiqYfZTSygLeA/g73mdQ/7pHqj78DM8phBVkyujL95FAp4JjgkpfIOdhuxNosY=
X-Gm-Gg: AZFdTZffTBsfN8XVR+qCQOXbmuhy24InkK+iRrNX2bhphHzQ8rI2EM7fakb1XoMY3Q0
 kfYeHtoFFOzor5uzbRpgZ2ntF14xRd39/uLCrhN53wGeO0VQVwQcC94a7HRl3F/VLTlf+wrt+lC
 NQsqIxE+O7SG9Exqthtvy3zq4vzwXTDgO4X8ZWZIyiwdEE2I1id3Gm4A7u55JDbm9PnhB6SqpCA
 Xe5Mg6dxdelSY8mJkozSP37nTn6RfTz1uEdayYk/tZz/mum/ewSj0JIhO5VFjX1o67J980j3bXY
 3iF+oJXClTkP4xTvyT4dwcopA5y/nXlqLWgqgPSq3xV/igns7zIrgC+d4F/LeX7fUchHUvR8Q5U
 yYDiZJRGVQi8+Klv9sRwAdB9+PNvu3mgJEg50TQahuc01TWy2xji5Hf9xLURSyVqHgsx6HgwiRj
 yuRdsxw0uOD5WTi3Pa1XpIAVWA+RTKXKGbZytR9zwf827JBZOpsi8Fe3ikQDGDpMXw6tNfipOS5
 Zgvgw0tPeweQHHZDP+t6Aa2EkGPmP3/d0417ObbB5CrKEV8EwAajWLgocWueQ4QRV7HCpckQYSn
 r5Wmm6rQS7dBDLiQ5x7T+Fn1GhAP05xwi7erfIJgfRDrLpbF3jx/XA3NX7JBPDCwaAx9k9o=
X-Received: by 2002:a17:90b:5605:b0:3ad:3e8:12 with SMTP id
 98e67ed59e1d1-3b3d07d472dmr5058539a91.48.1795106203718; 
 Thu, 19 Nov 2026 08:36:43 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b40a878d50sm2521446a91.11.2026.11.19.08.36.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 08:36:43 -0800 (PST)
Date: Thu, 19 Nov 2026 08:36:40 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ajit Kumar <Ajit.Kumar@amd.com>
Cc: <dev@dpdk.org>
Subject: Re: [PATCH] net/axgbe: retry transient SFP I2C read failures
Message-ID: <20261119083640.6c3a3ea0@phoenix.local>
In-Reply-To: <20261119035140.2074510-1-Ajit.Kumar@amd.com>
References: <20261119035140.2074510-1-Ajit.Kumar@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/AHc3xNsiBQo888SG+6pegM="
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

--MP_/AHc3xNsiBQo888SG+6pegM=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thu, 19 Nov 2026 09:21:40 +0530
Ajit Kumar <Ajit.Kumar@amd.com> wrote:

>  
> +/*
> + * The very first I2C transaction a port issues against its SFP cage
> + * (GPIO-expander / mux), right after axgbe_phy_init(), can legitimately
> + * find that device not yet ready to respond -- observed in the field
> + * as either a quick NACK (-ENOTCONN, IC_TX_ABRT_7B_ADDR_NOACK) or a
> + * full hardware stall with zero bus activity until axgbe_i2c_xfer()'s
> + * own 1-second timeout fires (-ETIMEDOUT). This is distinct from the
> + * cross-port bus-contention race fixed by axgbe_i2c_mdio_bus_mutex in
> + * axgbe_phy_get_comm_ownership(): it reproduces on a single port with
> + * no other port active at all, immediately after that port's own
> + * phy_init(), so serializing the bus does not help with it.
> + *
> + * Retry on these two codes as well as the existing -EAGAIN, with a
> + * short settle delay first, since an immediate retry is unlikely to
> + * help if the device is still completing its own power-on sequence.
> + *
> + * Cost: on the -ETIMEDOUT path this adds up to one more full internal
> + * 1-second timeout per phase for a genuinely persistent (non-
> + * transient) fault. This is bounded to each port's first post-init
> + * access -- a one-time bring-up cost, not a recurring one paid on
> + * every subsequent link_update() poll -- and, like any I2C/MDIO bus
> + * access, runs while axgbe_i2c_mdio_bus_mutex is held, so it can
> + * delay other ports' bus access by the same amount, same as any other
> + * access to this bus.
> + *
> + * Validated on two independent physical units (AMD CRB V3C48 and
> + * Advantech FWA-1081): 0 I2C errors across 30 iterations of the
> + * original cross-port repro plus a dedicated solo-access repro, which
> + * now links up cleanly on both ports; both failed deterministically
> + * without this change.
> + */
> +static inline bool axgbe_i2c_retryable(int ret)
> +{
> +	return ret == -EAGAIN || ret == -ENOTCONN || ret == -ETIMEDOUT;
> +}

The code is fine, but this a great example of an AI slop comment!

If you coach AI to write better commit messages and comments it will
produce something like:

/*
 * The SFP cage mux/GPIO expander may not respond to the first access
 * after phy_init(), either NACKing (-ENOTCONN) or stalling until the
 * transfer times out (-ETIMEDOUT). Retry those as well as arbitration
 * loss (-EAGAIN), after a short delay to let the device settle.
 */

See attached CLAUDE.md for hints how to help reduce this kind of mess.

--MP_/AHc3xNsiBQo888SG+6pegM=
Content-Type: text/markdown
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=CLAUDE.md

## Style

Avoid sounding like everything was generated by an LLM
1. Limit em dashes:   Max one per short paragraph. Less is better. Replace =
extras with commas, semicolons, or restructured phrasing.=20
2. Kill formulaic structures:   Avoid =E2=80=9CIt=E2=80=99s not just X; it=
=E2=80=99s Y=E2=80=9D phrasing. Rework neat triplets and symmetry=E2=80=94v=
ariety beats rhythm.
3. Purge buzzwords:   Remove or translate vague hype terms (e.g., *elevate,=
 robust, impactful, leverage, delve*). Use precise, plain alternatives.
4. Delete strained metaphors:   Cut weird similes or analogies that don=E2=
=80=99t land. If you wince when reading it, it goes.
5. Cut redundancy and filler:   Eliminate repeated clarifications, preamble=
, and excessive transitions. Get to the point, then stop.
6. Inject human voice:   Use first-person when appropriate. Add a brief obs=
ervation, reaction, or informal aside. Allow small imperfections that signa=
l a real writer.
7. Loosen formality (where context allows):   Use contractions naturally (d=
on=E2=80=99t, can=E2=80=99t, won=E2=80=99t). Avoid robotic phrasing. Let th=
e tone match the platform (Slack =E2=89=A0 policy doc).
8. Vary sentence rhythm:   Break uniformity. Mix short, medium, and long se=
ntences to avoid =E2=80=9CAI flatline=E2=80=9D pacing.
9. Anchor the point of view:   Stick to a consistent perspective (I, you, w=
e). Use active voice unless there=E2=80=99s a reason not to.
10. Prefer plaintext over markup

--MP_/AHc3xNsiBQo888SG+6pegM=--
