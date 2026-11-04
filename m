Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AFD606A31B
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 12:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=FROeW7BA
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A5B0D40281;
	Wed,  4 Nov 2026 13:29:54 +0100 (CET)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 by mails.dpdk.org (Postfix) with ESMTPS id B12E44025A
 for <dev@dpdk.org>; Wed,  4 Nov 2026 13:29:53 +0100 (CET)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-c2e8c710847so106472766b.0
 for <dev@dpdk.org>; Wed, 04 Nov 2026 04:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793795393;
 x=1794400193; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=v0Sl84cumDKQGsOxUve0vrW6lNApPdA26tx+YzcH0ns=;
 b=FROeW7BAnEhYGzWhkUl9zCNE8MrIx0NE78n/Dh4RxWuF/6KBBqTslRLTDXm3+PBN8U
 ra/8/zemqikVxDYTlsQDOCU0kGEjRmiF+m/vR/dQW2mtCPFRHq5M3AVN30yRD7pmLPVR
 G844LPZBpq9Px6T94Sxxfa2suv2uUT5Pct00A2PAajSWBLOlRTsinnv+m22CU3YkY5Nf
 iZXlAXNAlQxTn0l9d/3SnI+sTNrbWiPoX7Xqv24hnpzSLV1yTLM5ALbe8d2DjIlshHJ8
 AUjld0YOFTN5DnBs9GbnpTCx/sZif+DKMC+MFZZhmWw6gUK+BsYfkO6Fy9MSIa89OodG
 +GuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793795393; x=1794400193;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v0Sl84cumDKQGsOxUve0vrW6lNApPdA26tx+YzcH0ns=;
 b=LMJhbuUe8vKVV4d61buENpTWTRLjLlgTEZqfDVQlUZFcVrD2hjY16A+6sR54hXsRGT
 qJtZTlysCX9YLCR0ZFW7dUea6VPFiyy2WO0tABep9cZuQISgKOSMidB+yCi2+litYBjK
 RFOsWnspC0N672gJPJTjjIzwhZuQ4cDrqVrMXumM/NeSaHOrU2zbVHOlyVa2uLJgDsJ4
 az0hRcIDKLbEHcQrLNJmSGfIYFDNTcv89CBP/p9f9+HSN5EKLcvDHX3BJxMnbpTFuXUP
 f8JTlaoZeNWX6PVBfZHmeea9L96Dj6UAd4KBU4XbTWWEI0HjBCyRvs/PsmKRD5m8+MDK
 tdXg==
X-Gm-Message-State: APuU4Z+KpIg4z6aP4ZTtNOUHbByOxLSUfsdy2uEDHrlOGDLtE+zvisjC
 KbwnbbGMlp76bB9Hn7mUKONoGPDP1Bg+SWwm3lcRUvvXVPhagnK4RrCcZL7elkaYBoQ=
X-Gm-Gg: AYBFou2mVNXkPDcgDdsX6RT+9umBZtNpBIt8HtPYplDaDzFUVp+HTNd3k4PCU+EVlR5
 OJFzVCg8VYVczH369IeXUUZXjv5q302XDBuc8GMMdQeaO9vugfbHJYFKwsXHgrUctS725awcjoP
 sXqRYnlt9Bx8QxQSSxroFyhrqZ62pCnQmrh8c5ChYkRat2rHPKRsYLi5Ttim1uPQWRVANn/Q0DB
 5MBiMZYHgq1Un17PuliiSRRrWy1LbS36X/wTbKBu4zQph6Q7xemRC/98wSDbC0v/SHKGd08+ozO
 XJp291lbx0kIzYzQAbimMFZbJG2U2C8QxMgwOuzNUwY5ZoXeNYljllPyrtDy3ZUpROWuea/TCGh
 MQKZiyEuZvQeUCYb8NvVWu6Vw4VCwIm9QRT2bU9/S6K1Lvfi3NnPXAEYjpusdMofMJKWoaRjraF
 mBcdJ2lD5Uq3Jwhjhrmj5q14oySXn6k+0jexevrCpZXUu4tCCL0OX0ssvErNjn+ZD3urIBW9WJ/
 VzLARwonz9tMfaRHhNUkFJ8t3Hc0zenbqSx2uimDAZrueNNLsloAVvzuC8kG/BYjVxO7Ofs/InE
 e1pgycVN5p0C59kO3jCJEwtCLrubGUX5RFHnDpA+lCRJkC4FOGJEiDROvn4DGahiPx5O4x5FxF5
 5PeAIaYM+0NCUIC6R17Ndf0GQp9+YQuU4pQup
X-Received: by 2002:a17:907:3e22:b0:c40:5ee3:8698 with SMTP id
 a640c23a62f3a-c4ca7a9ec9fmr1416008366b.31.1793795393021; 
 Wed, 04 Nov 2026 04:29:53 -0800 (PST)
Received: from stephen-xps.local (93.224-78-194.adsl-static.isp.belgacom.be.
 [194.78.224.93]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d0e48d3acsm62394866b.71.2026.11.04.04.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 04:29:52 -0800 (PST)
Date: Wed, 4 Nov 2026 13:29:49 +0100
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Aman Singh <aman.deep.singh@intel.com>
Subject: Re: [PATCH] app/test-pmd: add explicit parameter for fixed link speeds
Message-ID: <20261104132949.4957efe6@stephen-xps.local>
In-Reply-To: <20261103155033.3740814-1-bruce.richardson@intel.com>
References: <20261103155033.3740814-1-bruce.richardson@intel.com>
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

On Tue,  3 Nov 2026 15:50:33 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> When a particular speed was specified for a port in testpmd, the flags
> passed to the underlying API call always included the
> RTE_ETH_LINK_SPEED_FIXED flag. This flag is not a mandatory part of the
> bitmap when setting speeds, and is used to disable autonegotiation.
> It's possible to have a link report only a single speed while
> still have negotiation enabled, so testpmd needs to be extended to
> support setting a speed both with and without the flag.
> 
> This patch does so by adding an optional "fixed" keyword after the speed
> specified by the user. The presence or absense of the keyword adjusts
> the presence or absense of the FIXED speed bit in the ethdev
> configuration structure "rte_eth_conf.link_speeds" bitmap.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

In general it looked ok to me. But I would like testpmd and ethtool have same syntax
to follow the principle of "least surprise" for users.

The AI review with its issues and that encouragement was:

Review: [PATCH] app/test-pmd: add explicit parameter for fixed link
speeds (patchwork 172601)

Applies to main (26.11-rc2), builds with -Dwerror=true.

Warning (should fix)
--------------------

1. Syntax should follow ethtool rather than invent "fixed".

   ethtool has autoneg as a separate on/off setting:

     ethtool -s eth0 speed 10000 duplex full autoneg off

   With autoneg on, a given speed/duplex limits what gets advertised
   (the kernel's ethnl_auto_linkmodes()). That is the same as this
   patch's default, so the semantics are right; only the keyword and
   its position need to change:

     port config (port_id|all) speed (...|auto) duplex (half|full|auto)
         [autoneg (on|off)]

   autoneg off   -> set RTE_ETH_LINK_SPEED_FIXED
   autoneg on    -> clear it
   absent        -> leave autoneg alone. ethtool keeps the current
                    setting, so keep the FIXED bit already in
                    ports[pid].dev_conf.link_speeds. The default
                    dev_conf is autoneg, so a fresh port behaves as
                    posted.
   speed auto + autoneg off -> error, as now.

   Putting the optional tokens last leaves the existing
   "speed N duplex D" prefix alone. Users who know ethtool can guess
   it. Untested sketch for the all-ports case:

     struct cmd_config_speed_all {
     	...
     	cmdline_fixed_string_t item3;	/* "autoneg" */
     	cmdline_fixed_string_t value3;	/* "on#off" */
     };

     static cmdline_parse_token_string_t cmd_config_speed_all_item3 =
     	TOKEN_STRING_INITIALIZER(struct cmd_config_speed_all, item3,
     				 "autoneg");
     static cmdline_parse_token_string_t cmd_config_speed_all_value3 =
     	TOKEN_STRING_INITIALIZER(struct cmd_config_speed_all, value3,
     				 "on#off");

   The second cmdline_parse_inst_t still needs the two extra tokens.
   In the handler, res->item3[0] == '\0' means autoneg was not given.
   The cmdline library zeroes the result buffer, so the
   ".data = &cmd_config_speed_all_fixed" self-reference used as a flag
   can go. Same for the per-port instance.

2. Default behaviour of an existing command changes silently.

   Before this patch "port config 0 speed 10000 duplex full" set
   RTE_ETH_LINK_SPEED_FIXED. After it, the same command leaves autoneg
   enabled and advertises only 10G. Existing scripts and test plans
   (DTS, vendor validation) keep parsing but now do something
   different. Whether the user sees a difference depends on the PMD.

   The new default is correct (it matches ethtool), but the release
   note puts it under New Features. Give the behaviour change its own
   sentence, e.g.:

     Speed settings no longer disable autonegotiation by default;
     add ``autoneg off`` to force the speed.

3. --eth-link-speed is now inconsistent with the runtime command.

   parse_link_speed() in parameters.c still starts from
   RTE_ETH_LINK_SPEED_FIXED, and run_app.rst calls it "a forced link
   speed". So the startup option forces the speed and the runtime
   command no longer does. Either add a matching option (e.g.
   --eth-link-autoneg=on|off), or at minimum document it in the speed
   command section:

     The ``--eth-link-speed`` command line option always disables
     autonegotiation.

Info (consider)
---------------

4. testpmd_funcs.rst: the patch leaves three blank lines before
   "port config - queues/descriptors"; one is enough. "Support for
   these settings depends on the driver and hardware." adds nothing
   and can go.

5. Commit message: "absense" (twice) -> "absence"; "still have
   negotiation enabled" -> "still have autonegotiation enabled".
