Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2E8D4336E
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Dec 2025 05:32:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B8AF940273;
	Fri, 12 Dec 2025 06:32:58 +0100 (CET)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id 8424A400D6
 for <dev@dpdk.org>; Fri, 12 Dec 2025 06:32:57 +0100 (CET)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-299d40b0845so12461455ad.3
 for <dev@dpdk.org>; Thu, 11 Dec 2025 21:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1765517576;
 x=1766122376; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=11YdiNgznOpQIbk5aML70W68/NSIzR7JLc5YfVsQeok=;
 b=idW80iUYea/qvYzI1TEY6xBWKBiVCGq5V5RJq1CaHcH2ZzIcFfF19xMm9GTdGNyl6C
 2/GbYpotO2a3iyHBOzOocxD0MUlLCqaDMzvZSHXBSq4Kx89/CC9OQqwzDs1SHK3vG4U5
 oALbgFNz+DaDcfZQmzWzF4BXgx6aLcbz4SNlvmPnT/E2x+8vmlfR8HpEFe2MeroDXNP1
 HJlRlKrLZYhDF+4a6Thb7sCY+c8vQWmLypZC9xjPO7rySFGCwqAkLll33I3TnMVr+sx3
 wFd2ljYabu8KdeukTg7n4BtvR0KhOAYe0VD00ZNVpCf/lhTiUBZ3RHmwPXfao7EN8/TG
 Leaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765517576; x=1766122376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=11YdiNgznOpQIbk5aML70W68/NSIzR7JLc5YfVsQeok=;
 b=wEHg0BLa9qaZfDiGKTYd7n70OFF6T2LU9Ro8vS1Gdg7QB+w6OsRA2YfnyeeokH2RAe
 FbkgnrnzEEoGoJclMlOZJ7kbw2+x26+2SCSaDqAZrBR/GUDjWpi4IDsq6lhntXflnNj0
 GALZeKVJQZlSQ70L5A0Qi6fSTpWifFIPOT5P89NpX+ZIfvk6zcgAyd8YByj8uPIyX8dx
 b1+tRr98pkKBTvibUh9c2orcQSBQ9b8CKNwKAePs3Xco+G3iym96iaA9ghG7Fh+AToAV
 j25hRD04MVY16F7JcOxS+QPPPRLvhA1p47BtnQAbz3+uree09q3/aBfzf51OYfh2Xz1m
 ErCg==
X-Gm-Message-State: AOJu0YxKp0UkIJJydCxQ04QjYa1AnrNpGw4DAG/87VBGiX5MXV9ylaLz
 ndW2ES/TrSDCifdBgAQX31YRUsPqC/PU/0tMk/XAEguW3Gm8eGSWvVhAEYkK2JNR9xO253GYu7y
 XeCdQzZA=
X-Gm-Gg: AY/fxX64vD0agj4nPp7NECgHTZ+FbOVtD1WIOAPeCEUiU75BIrmRFSO3LklKG37xE9X
 Ypjy+2nm7s+cMosGsq81cLtA9f3agGRl0PtXmJKFHmxAEZkrrFKImf4RUIeA1Z1eG2OVFqARfBw
 mqXhcN1SAlodGGccJihHXqcS6YLp0aYA+RL7/lQTsGUWeIDbv+f9/h9L10Q9CVoYUexlS35J/LY
 89I+xZt/RFIi6ZH5/opxVgIwyRpuD8cLtqQVBm3jHOEP2Pqf4ru68JSVuXtpjthKmvODGtGlUKp
 dJUoG8uMgVqSxJBAIYUOTnu2Ugc8/edZ4oSGxgxWrc1RAVmMxhazXdQjpgXMH7ShAWAvT0lBLOn
 lAU/HPKPo9qxK5IIzqUaW0Z5fHYI7w52bfdGXBn2rN/3ZRr1YwO1dxH0gYvhl4WpAZJ+sM8a+Tn
 fxZH0T+nN6KTfgzsABSRNs2t3qmppaLw8qaYtoTy/I/uE1eQJwnO8IcLCr5mwdXHwe9IzpPzQ=
X-Google-Smtp-Source: AGHT+IFP//eYyicCCuf8z0niij7K/ufvSIIBeSdjB557CPydwKbKAAm+wqSUVSvhNjE+Qg7kX1sT4w==
X-Received: by 2002:a17:902:d4c8:b0:295:557e:7465 with SMTP id
 d9443c01a7336-29f23ae279fmr10254735ad.11.1765517576174; 
 Thu, 11 Dec 2025 21:32:56 -0800 (PST)
Received: from stephen-xps.local (fs98a57d9c.tkyc007.ap.nuro.jp.
 [152.165.125.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29eea06dd9bsm41687385ad.99.2025.12.11.21.32.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 21:32:56 -0800 (PST)
Date: Fri, 12 Dec 2025 14:32:49 +0900
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [RFC PATCH 0/7] Add script for real-time telemetry monitoring
Message-ID: <20251212143249.2fdbeaab@stephen-xps.local>
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
> 
> Bruce Richardson (7):
>   usertools: add new script to monitor telemetry on terminal
>   usertools/telemetry-watcher: add displaying stats
>   usertools/telemetry-watcher: add delta and timeout opts
>   usertools/telemetry-watcher: add total and one-line opts
>   usertools/telemetry-watcher: add thousands separator
>   usertools/telemetry-watcher: add eth name shortcuts
>   usertools/telemetry-watcher: support reconnection
> 
>  usertools/dpdk-telemetry-watcher.py | 429 ++++++++++++++++++++++++++++
>  usertools/meson.build               |   1 +
>  2 files changed, 430 insertions(+)
>  create mode 100755 usertools/dpdk-telemetry-watcher.py
> 
> --
> 2.51.0


The TUI patch was
https://patchwork.dpdk.org/project/dpdk/patch/20220831115250.362189-2-conor.walsh@intel.com/


