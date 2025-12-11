Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A858D3E784
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Dec 2025 01:09:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A52C40289;
	Thu, 11 Dec 2025 02:09:21 +0100 (CET)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by mails.dpdk.org (Postfix) with ESMTP id 991C940285
 for <dev@dpdk.org>; Thu, 11 Dec 2025 02:09:20 +0100 (CET)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-7a9c64dfa8aso294992b3a.3
 for <dev@dpdk.org>; Wed, 10 Dec 2025 17:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1765415359;
 x=1766020159; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4zOwFYVt2DsOgTl9qpDFDrnFLlXBBccqJkyzSRf1qnU=;
 b=zBTmRIx4S2R3rAafZV9RVcGQcUTqXyzvDo9Yx5vkSVvcD84+WFkftIbfwj45xbhUcU
 PYWRs5tEkdDxJdGY2dZhvFkOlV89fJuCaOPhM/GO4eLTa75Hietm8rtL4y2eJPJC1uuH
 7ELWZ1jsZp0rV0Foz1hzWcTNbmD9bzNsJwRCAnKSwoobBXYPyJ7mCZDgetRkfygeOALo
 8hhQgPf2QIwtYGQNYD9j4e3y6ntoKkQe/SNCKcR+pILpG7VfhqghJvsvMQTWE4+cjdHA
 6xA50+xnTM+W1aCbv2Ng1oBeNH8/8L9z5JXVjSwd32jKqBLefEr2lRiXLf5vcxYzw2pS
 LXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765415359; x=1766020159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4zOwFYVt2DsOgTl9qpDFDrnFLlXBBccqJkyzSRf1qnU=;
 b=AxtmUtPVQ3P/HT/k6+igwyUl69QeTNRecfl7tSLOI4V/8yvs5TV7w+4E4z6uqs9qna
 yFzIZsu/WvCBzQFH9idkUYrHCk676UzlPylX2260kYeS5LiNWnEGP+8O3YPmiGal1Qfy
 4zefZ7c+WhD21IjGAQ/u4N96DkyykdjyTC+XHATt0EspP0S9LI5sRKl87mkMG+Sadl4F
 yOI5aOT+6k0hIA6l9aMok41Nti9pYzIjQTFoeewuPM5CRssf3SOGmt1Ra4D+2rhFqnAz
 m3/3HLtVe+bdWwvAGrN4UmrisG49k9HPGNCEBvPmbc49ZnnZK4cv1IM/0p9EpvBAHFyH
 WHeg==
X-Gm-Message-State: AOJu0Yz7Uvh/8N8g4rltV1g4Tk6L4Zo/pIEDQq63N6/7qvG3B5zHFpwZ
 BNorsparGESXa76ImfAmWv9+LemLehxUYzew8JE5LxQld7Ju3iu3yvC+3+kU/65fDtI=
X-Gm-Gg: ASbGncutTrXP7OF8Pr02AC3YUtPTf1iG2DQcldvdmy2EIWOZcG0J94RhXP7AW5kC52+
 zFmo4M+79d299aMdRHWZRtN5DSH0N6nrVaxC1gilqZRKuZAOKmSADel44Bd7zJL1mTq/g4Hut0B
 rw5J3UUUTDkPL3aFFVxYQvc4X4O2e9KdePRuKhLYYtz83ErXKwAS4FAa0kuHF58eCYPPiDzw3MP
 kdG+GyRYFPC4ZPIppEuVo3FDHUOExMw77fnRU0ycDnyFdWtlijBlZ9W50klcAgoEMUOYk6aUDGI
 Y/wkWcVsFfSbKn0b8N/Y29S9yWfm+Uuv6nmMdDJ+gwENCWzD7AM0cCX4mjSR9YteEklQAGOVvaf
 vz3chNEjkvtq2UMYQid/4ym6+VYIHZAv7rCLzmVJlW8DcUAakcJAlZi7kkW2W1BlJS1lUTZLmNn
 F3Pj62Df1w8HofRFNiMeB+VyHIwlLwUC2kAyVYEQqdjVil9UGrmhf2Tlie4vY=
X-Google-Smtp-Source: AGHT+IH2uNET7Ba+ifRjGOFhn95bsiLdXgKVdjUVCwLQ/ArivN7OOeM1y3c41KCvlqTHcIx/q30gww==
X-Received: by 2002:a05:6a20:3c8d:b0:366:14af:9bd2 with SMTP id
 adf61e73a8af0-366e31ac1a3mr4102459637.72.1765415359322; 
 Wed, 10 Dec 2025 17:09:19 -0800 (PST)
Received: from stephen-xps.local (p99249-ipoefx.ipoe.ocn.ne.jp.
 [153.246.134.248]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c0c2632b725sm608338a12.8.2025.12.10.17.09.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 17:09:19 -0800 (PST)
Date: Thu, 11 Dec 2025 10:09:10 +0900
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [RFC PATCH 0/7] Add script for real-time telemetry monitoring
Message-ID: <20251211100910.49a107c6@stephen-xps.local>
In-Reply-To: <20251210165532.103450-1-bruce.richardson@intel.com>
References: <20251210165532.103450-1-bruce.richardson@intel.com>
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

On Wed, 10 Dec 2025 16:55:25 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> TL;DR
> ------
> 
> For a  quick demo, apply patces, run e.g. testpmd and then in a separate
> terminal run:
> 
>   ./usertools/dpdk-telemetry-watcher.py -d1T eth.tx
> 
> Output, updated once per second, will be traffic rate per port e.g.:
> 
> Connected to application: "dpdk-testpmd"
> Time       /ethdev/stats,0.opackets /ethdev/stats,1.opackets        Total
> 16:29:12                  5,213,119                5,214,304   10,427,423
> 
> 
> Fuller details
> --------------
> 
> While we have the dpdk-telemetry.py CLI app for interactive querying of
> telemetry on the commandline, and a telemetry exporter script for
> sending telemetry to external tools for real-time monitoring, we don't
> have an app that can print real-time stats for DPDK apps on the
> terminal. This patchset adds such a script, developed with the help of
> Github copilot to fill a need that I found in my testing. Submitting it
> here in the hopes that others find it of use.
> 
> The script acts as a wrapper around the existing dpdk-telemetry.py
> script, and pipes the commands to that script and reads the responses,
> querying it once per second. It takes a number of flag parameters, such
> as the ones above:
>  - "-d" for delta values, i.e. PPS rather than total packets
>  - "-1" for single-line output, i.e. no scrolling up the screen
>  - "-T" to display a total column
> 
> Other flag parameters can be seen by looking at the help output.
> 
> Beyond the flags, the script also takes a number of positional
> parameters, which refer to specific stats to display. These stats must
> be numeric values, and should take the form of the telemetry command to
> send, followed by a "." and the stat within the result which is to be
> tracked. As above, a stat would be e.g. "/ethdev/stats,0.opackets",
> where we send "/ethdev/stats,0" to telemetry and extract the "opackets"
> part of the result.
> 
> However, specifying individual stats can be awkward, so some shortcuts
> are provided too for the common case of monitoring ethernet ports. Any
> positional arg starting with "eth" will be replaced by the set of
> equivalent values for each port, e.g. "eth.imissed" will track the
> imissed value on all ports in use in the app. The ipackets and opackets
> values, as common metrics, are also available as shortened values as
> just "rx" and "tx", so in the example above, "eth.tx" means to track the
> opackets stat for every ethdev port.
> 
> Finally, the script also has reconnection support so you can leave it
> running while you start and stop your application in another terminal.
> The watcher will try and reconnect to a running instance every second.
> 


There was a previous submission of a nice telemetry TUI which seems to have
been abandoned, is there overlap with this?

