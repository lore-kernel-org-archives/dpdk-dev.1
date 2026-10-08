Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67564CA6011
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 17:45:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54FC040294;
	Thu,  8 Oct 2026 19:45:49 +0200 (CEST)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id BCADB40284
 for <dev@dpdk.org>; Thu,  8 Oct 2026 19:45:47 +0200 (CEST)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2e812e2b31bso6396575ad.3
 for <dev@dpdk.org>; Thu, 08 Oct 2026 10:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791481547;
 x=1792086347; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mpIw/iTCXCrZIo+NRThier+CNu2Qe7SDhdiPd6uRlrE=;
 b=XME4BlHp2tNMcljTSwxdjvBVTQ0fmHIAGk6/P+2SWuimXfaajTeYlfEWfLNQyg0DqR
 g01v7s1DemiKbidbMAXEbYna3bOeCGuxl+/FN3fyFrcufu3FCUb9jr5MCPQ1bhAMJohX
 AilE6EES/nq+GcuY+5n1x9QH0WzoPIqfky30wdrln5dPUOxyjacrnqcZ0L1ICQ7OAxDu
 +iOdvOiMrKLw3WPvct0sUfBZ0S9UwAY+d1z406XqQeD7nT6tH9lLjyAyFcTijWOq5RjE
 pwzKauM6p3k94dUbZlnvxoAnyY0Q/jE4+KhcQCRDvpN19OEQu5b98JV+ye+eE2+Z88K3
 dXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791481547; x=1792086347;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mpIw/iTCXCrZIo+NRThier+CNu2Qe7SDhdiPd6uRlrE=;
 b=Xhs+OyERCDf+si45L3ly73vLsZtlUjfmbp/rzBlNOgRDLBkWjUkeNx+08PqF9rHlSJ
 N8JSx4MIeI2WzgF9TQ1/kZE+fOuY7GqnWPW6wFfAzaWcIEDkmw+8GqbZQrAZKb5MQyaU
 v2mHTm6fR2qvpXhmbufehzMTb2QyO7VrgCsOc22HFVcLEWNaHm4haRevOukR/ks+dyBb
 qjju2qmBDYRO6zMSX9Y8Xea68GLza5iKR1QsdLA40au7MgQf/mQD2IhWdmNPucTxYonb
 XC5NbfXExjjoUklws0nw2dh4hOhJ2wZ224W+xcCGDqdHdwDypCXubQZ37SVQJ5/HSaAn
 Tw0A==
X-Gm-Message-State: AFq9FYJHY1ihnzfWR7FB16misv+rr0wIJsD1E+nAuazHoOxfqUbW/Hr7
 tD820c3MKWw7gdccgneB2dtT2kimAe//e8eUvAc/PeVjek3GJU7O/ZxeuuOrDCdo+tU=
X-Gm-Gg: AYBFou1m/7+/f0jJGHwg/C2ywrJHpnvcfmCQvks37l/ROTgcpIyT9LeXVRdHevZZwF6
 8FuqvlyxQ47dM7Y+8y1e6Su2r1uBzT6u+ckEobfzzQzAe2moV5AE920wHsc8zOZuZdLQ8ka3WOS
 y8fOrklmiQ6XTNkyjotyDyWN2L6Uy3wjtoALEcvGMUYUFWU0EFKLFavXr7O7Y48VB+N1I92vyOq
 s2S37n1YtNA1/x10Q8dE3GGI/QTNys1lgLZ1PF6dBeSEUB+TLZfTTSLUy1F5btxhtigUg4Tzo3L
 2Rof9uvgoKbcOk2Ju81objSN+TfD3CwS4fVo/j57T3XkUhF17CyONiBsldCbZ5UjqQqEgqCJeJw
 DwQMeRv+kuEwNnwOfp2RCJY9PimiTz8/xCxxCWv7HIIXONXBL+msQQjUgFguqS6kvTFAcfcvadt
 SXMF2bbDqLw531Zt6OLcppJV442uNlVItHwQpemLEbtFMlmu9eWuzRK9D/XeflfS9+F4Uzs7Dfs
 yR0xN3aioJb1y3DSOPru2PV/5p3o9weAWKqZ1S9F8tslUhcc3g=
X-Received: by 2002:a17:903:2c8:b0:2e2:c69a:bd7b with SMTP id
 d9443c01a7336-2e600394fdamr56199245ad.13.1791481546622; 
 Thu, 08 Oct 2026 10:45:46 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e83cce2a5bsm80675ad.36.2026.10.08.10.45.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 10:45:46 -0700 (PDT)
Date: Thu, 8 Oct 2026 10:45:43 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Roman Khromenok <roma55592@yandex.ru>
Cc: dev@dpdk.org, thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru
Subject: Re: [PATCH 0/4] ethdev: report module signal status flags
Message-ID: <20261008104543.1794c98d@phoenix.local>
In-Reply-To: <cover.1791447600.git.roma55592@yandex.ru>
References: <cover.1791447600.git.roma55592@yandex.ru>
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

On Thu,  8 Oct 2026 10:23:22 +0200
Roman Khromenok <roma55592@yandex.ru> wrote:

> The module EEPROM decoder shows the identity and the digital
> diagnostics of a module, but not the signal status, which is
> usually the first thing to check when a link does not come up.
> 
> Patches 1-2 report the SFF-8636 per-lane loss of signal,
> CDR loss of lock and Tx fault flags, as ethtool does since
> commit 045d8db ("sff-8636: report LOL / LOS / Tx Fault").
> The code is written for DPDK, not copied from ethtool.
> 
> Patches 3-4 report the SFF-8472 Rx_LOS and TX_FAULT state
> from page A2h byte 110. ethtool does not show it, so it is
> split out and can be dropped independently of patches 1-2.
> 
> The SFF-8636 flags are latched and cleared on read,
> so they report the events since the previous read;
> the SFF-8472 bits are the current state of the pins.
> 
> The series is based on next-net/for-main. It extends the same
> release notes entry as the testpmd patch 170851 ("app/testpmd: add
> command to decode module EEPROM"), so whichever is applied second
> needs a trivial context fixup there.
> 
> Roman Khromenok (4):
>   ethdev: report SFF-8636 lane status flags
>   test: check SFF-8636 lane status flags
>   ethdev: report SFF-8472 Rx LOS and Tx fault state
>   test: check SFF-8472 Rx LOS and Tx fault state

I am not an expert in this area, deferred to AI for review
and it reported one item worth checking.

Series: [PATCH 1/4..4/4] ethdev: report SFF module status flags
Author: Roman Khromenok

Summary
-------
Bit and offset mapping checked against SFF-8636 and SFF-8472:
bytes 3-5 lane split, Options 2/3/4 implemented bits, A0 byte 93
bits 4/5 and A2 byte 110 bits 1/2 are all correct. Lane string
format matches ethtool output. The SFF-8472 status is only shown
when DOM is supported (early return in sff_8472_show_all), which
is correct since byte 110 lives in A2.

Series depends on the module EEPROM decode series (the test file
and the release note entry are not in main yet); say so in the
cover letter.

Patch 1/4
---------
Warning: Rx LOS gated on Tx LOS implemented bit.

  /* There is no Rx LOS implemented bit, use the Tx one for both */
  if (data[SFF_8636_OPTION_4_OFFSET] & SFF_8636_O4_TX_LOS) {

Rx LOS has no implemented bit because it is not optional in
SFF-8636; only Tx LOS is (Options 4 bit 1). Gating Rx on the Tx
bit hides the most useful flag on every module without Tx LOS,
which is the case the commit message says this is for. ethtool
has the same limitation; no reason to copy it. Show Rx LOS
unconditionally:

  sff_show_lane_status("Rx loss of signal", SFF_MAX_CHANNEL_NUM,
                       SFF_8636_LANES_LOW(los), d);
  if (data[SFF_8636_OPTION_4_OFFSET] & SFF_8636_O4_TX_LOS)
          sff_show_lane_status("Tx loss of signal",
                               SFF_MAX_CHANNEL_NUM,
                               SFF_8636_LANES_HIGH(los), d);

and update the not_implemented test in 2/4 to expect
CHECK_FIELD("Rx loss of signal", "[ Yes, Yes, Yes, Yes ]").

Patch 2/4
---------
Info: fill_qsfp_signals() overwrites option bytes 193-195 instead
of setting bits. Any bits fill_qsfp() set there (page 01h/02h
provided, etc.) are lost, which can silently change what the
other decoders see. Use |= :

  data[QSFP_OPTIONS_2] |= 0x08;
  data[QSFP_OPTIONS_3] |= 0x30;
  data[QSFP_OPTIONS_4] |= 0x0a;

Patch 3/4
---------
Info: SFP shows "No" when clear, QSFP shows "None" for the same
field names ("Rx loss of signal", "Tx fault"). Telemetry
consumers keyed on name get two value conventions. Either use
"None"/"[ Yes ]" style for SFP too, or accept it and note it in
the commit message.

Info: release note line reads as a separate feature; "The
SFF-8472 decoder also reports ..." to match the 8636 line.

Patch 4/4
---------
Info: same as 2/4, data[SFP_ENH_OPTIONS] = 0x30 clears the
alarm/warning implemented bit (bit 7) if fill_sfp() sets it.
Use |= 0x30.
