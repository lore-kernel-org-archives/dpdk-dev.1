Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433DAC43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 20:02:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 253AA40150;
	Mon, 29 Jun 2026 22:02:13 +0200 (CEST)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174]) by mails.dpdk.org (Postfix) with ESMTP id A5901400D5
 for <dev@dpdk.org>; Mon, 29 Jun 2026 22:02:11 +0200 (CEST)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-30eac9abd79so2816044eec.1
 for <dev@dpdk.org>; Mon, 29 Jun 2026 13:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782763330;
 x=1783368130; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xF+TNB0ANA+xPCC/R6HmvJTCBWn+cxTSIydLdNEV0QU=;
 b=tpfxkv6HEwVFFwe2F+UmdTibwUunBU/jkAOAcIoSSAJKHJkdU2OdotgWSqWQ4kWk4j
 tYkc+me78mOwny8qrC5CixY0frWVKbHgodFvQNqVdzPMXC5M4XOXG1at58WDIZ/TmAfM
 xuyiEQdOI61rARkNMsbEykkPNxPF7TRGX6A6VRfowfutsKZ3N+q9waBbodsD61XUPRnT
 UBVYoae628O3jB8ehmlk3oAtAgDzhJPkesLJQ+9p4uH6MNWEQBSIOk1o/QLFhIWLSlHG
 OoJbcPORfAe+sqD1cyq4fbXj1SoSHvp6vWg6SR4Uw4vLTBX+IfGEdTTROdvCUrQaHM4O
 Mn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782763330; x=1783368130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xF+TNB0ANA+xPCC/R6HmvJTCBWn+cxTSIydLdNEV0QU=;
 b=DymORjWYcGVq2UgvzW/SqfdALRpYRgP0lsnvSejR4/qZS9Cw8EBwpGVhleAJCTXSGH
 m3wsQsieMDvftxYvGoPIhdHXzLlwXTI157aaX2M2av2CCRMIVMTkqHP6l38XAFjjkD/e
 c7uGWzojkB17XnvxHXoyQrGiFEfwvb9zvxsaIggjLdEpHtP1oQYQMVPlGBxXcGgrQfLt
 l9bKVZvr3+ET4Ki/4eZiUuqbQ5Ad/e7bhUUzsObDtEclcTkW2Ay6qufqG2m3FcbBL/uA
 jCk116BydQCuG3WxvjWeknUzP4O0NbDK+fnBYpJFzBMSZojp1kTq4222OrXXoTodxh+N
 8KUA==
X-Forwarded-Encrypted: i=1;
 AHgh+RogXrx6KONkhuzCjJwDdq/Y2wuH64arbGe+whu0/1LApW6QwG2JA0MVef5Xxj+sJbY0WNU=@dpdk.org
X-Gm-Message-State: AOJu0YyC+wMr3GtSm+ofFhytKNZ7UhuQR6kQUfaYPRA69Ncty8mKTfWR
 hn4id0+9gsq/mF1uUhnuI+ovt0d0sc61bOfY8amv0hIaiz/ctNm2f9OzhuW0Q4g8XOc=
X-Gm-Gg: AfdE7ckvBwcFt/q4WxpxlEvsjfHfMd7V6bKTe8pI8vjRd7BLm/W0v6lULFOtCq4I50v
 R1c8Yd+YCEvsVXTshtT3oqQ/drlVPKQUSISvll86u+i6MmjpAf9a997aODgfkfwhnjGa78d2dR2
 IOq9892dZ4T9z7Zggz2eemSvc26g6w7f54ZNUFSFQILWAkNA+vqfQuw95AF4i+3KDaZnJNNko52
 3hTVBe4sFhTWTuRSKC6ViYJubWUE0Wf9NzciMD51cG47YD2FOneHheD9Rycx/qWE/ajUlO9dp4t
 MzTBH/hMKJN29TkIQe8dXFXf01JdLmdOhrJZItthOkSjoJufEIJwMADtOijtbpmVaYtfOx+DeZg
 uj81Z+3i+r3oVLm/Chm4k2mfcimuo3EhWrc8ewsrLjbkoye+K71F+JcJxsHzvPQmSjexXvuMnuI
 Lv/tYhzHIilMvpJpS2vt1iSUATNxihiUb9JcL/iW6OsuIXVthhy/kIEA==
X-Received: by 2002:a05:7300:3251:b0:2ea:3370:6e51 with SMTP id
 5a478bee46e88-30ee11ae39cmr660376eec.4.1782763330066; 
 Mon, 29 Jun 2026 13:02:10 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ee2cd21bcsm1234566eec.0.2026.06.29.13.02.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 13:02:09 -0700 (PDT)
Date: Mon, 29 Jun 2026 13:02:05 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Joshua Washington <joshwash@google.com>
Cc: Mark Blasko <blasko@google.com>, dev@dpdk.org, Ciara Loftus
 <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>, "Jasper Tran
 O'Leary" <jtranoleary@google.com>
Subject: Re: [PATCH] net/af_xdp: add Rx metadata and dynamic timestamping
 support
Message-ID: <20260629130205.5ed0e44b@phoenix.local>
In-Reply-To: <CALuQH+W4wPA5ygZ63pcQrCD-Uz_K1AsN9n+fzX+ESarmaHnmrA@mail.gmail.com>
References: <20260623215325.814776-1-blasko@google.com>
 <20260623150638.266d8574@phoenix.local>
 <CANULgnK9-P5dQtTPayiFD7PLor=1qV=7du-AtRuWGPd4F5SmAQ@mail.gmail.com>
 <20260629103804.3d4154bb@phoenix.local>
 <CALuQH+W4wPA5ygZ63pcQrCD-Uz_K1AsN9n+fzX+ESarmaHnmrA@mail.gmail.com>
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

On Mon, 29 Jun 2026 12:10:27 -0700
Joshua Washington <joshwash@google.com> wrote:

> These are all very good points for ensuring an airtight abstraction.
> However, I'd like to note that neither of the kernel-bound PMD
> interfaces (pcap, AF_PACKET) have support for the `read_clock` op. I
> am not certain of the reason for this, but I suspect it's because
> ethtool IOCTLs already cover that functionality. This patch's
> implementation follows the other implementations pretty closely,
> differing only in how the timestamp is extracted.

Yes, that needs to be fixed :-)
