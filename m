Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D1FD3C928
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Dec 2025 16:55:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84861406FF;
	Wed, 10 Dec 2025 17:55:40 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id F307740285
 for <dev@dpdk.org>; Wed, 10 Dec 2025 17:55:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765385740; x=1796921740;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=+s7kgzC73Gv7zBeH02KvBojlAX+MMNf6fpzEO0nT0QE=;
 b=BBfpi1XK+fL4vlvRkTYnpzwMN9WDgZMYsFPhLu+0DqjlpAd92IrkwD5c
 0eRY1vr2j2VPpUYMH4JG+/4bwfH1fGZTJHama29ehawEaDMn47H88rQEx
 Wga2E1eFyt4+Z7pW99kPhJJrXssY2fLQX+8YHZF1Q5nQsujFEQ6XCJcEZ
 5+x/lt7OjxKwCtRY7j2R0Jz/6Uth4R/rDGS5wfXCeoyAd4CsIrj0H+LkY
 1f1wFHjkQrJxio1NuCTP/SPZm5WKpKNSuWHb/4TsB7c4ndUc1e81Nfd0E
 u7kKx9Sex9MXB6WSolQihNtxd9uveyCG1MyL7W8RWARjj3d/Kpd3+aRFS w==;
X-CSE-ConnectionGUID: ixfRwL5jTJW/nqeyVlfHDg==
X-CSE-MsgGUID: 7/CKQXcjQxi2GggieDMb9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="67088726"
X-IronPort-AV: E=Sophos;i="6.20,264,1758610800"; d="scan'208";a="67088726"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2025 08:55:38 -0800
X-CSE-ConnectionGUID: gw/GwK3vS5qAjlQkCPPAlw==
X-CSE-MsgGUID: yOSCMji9S/22jLkO9I6KfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,264,1758610800"; d="scan'208";a="195828599"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 10 Dec 2025 08:55:37 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 0/7] Add script for real-time telemetry monitoring
Date: Wed, 10 Dec 2025 16:55:25 +0000
Message-ID: <20251210165532.103450-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

TL;DR
------

For a  quick demo, apply patces, run e.g. testpmd and then in a separate
terminal run:

  ./usertools/dpdk-telemetry-watcher.py -d1T eth.tx

Output, updated once per second, will be traffic rate per port e.g.:

Connected to application: "dpdk-testpmd"
Time       /ethdev/stats,0.opackets /ethdev/stats,1.opackets        Total
16:29:12                  5,213,119                5,214,304   10,427,423


Fuller details
--------------

While we have the dpdk-telemetry.py CLI app for interactive querying of
telemetry on the commandline, and a telemetry exporter script for
sending telemetry to external tools for real-time monitoring, we don't
have an app that can print real-time stats for DPDK apps on the
terminal. This patchset adds such a script, developed with the help of
Github copilot to fill a need that I found in my testing. Submitting it
here in the hopes that others find it of use.

The script acts as a wrapper around the existing dpdk-telemetry.py
script, and pipes the commands to that script and reads the responses,
querying it once per second. It takes a number of flag parameters, such
as the ones above:
 - "-d" for delta values, i.e. PPS rather than total packets
 - "-1" for single-line output, i.e. no scrolling up the screen
 - "-T" to display a total column

Other flag parameters can be seen by looking at the help output.

Beyond the flags, the script also takes a number of positional
parameters, which refer to specific stats to display. These stats must
be numeric values, and should take the form of the telemetry command to
send, followed by a "." and the stat within the result which is to be
tracked. As above, a stat would be e.g. "/ethdev/stats,0.opackets",
where we send "/ethdev/stats,0" to telemetry and extract the "opackets"
part of the result.

However, specifying individual stats can be awkward, so some shortcuts
are provided too for the common case of monitoring ethernet ports. Any
positional arg starting with "eth" will be replaced by the set of
equivalent values for each port, e.g. "eth.imissed" will track the
imissed value on all ports in use in the app. The ipackets and opackets
values, as common metrics, are also available as shortened values as
just "rx" and "tx", so in the example above, "eth.tx" means to track the
opackets stat for every ethdev port.

Finally, the script also has reconnection support so you can leave it
running while you start and stop your application in another terminal.
The watcher will try and reconnect to a running instance every second.


Bruce Richardson (7):
  usertools: add new script to monitor telemetry on terminal
  usertools/telemetry-watcher: add displaying stats
  usertools/telemetry-watcher: add delta and timeout opts
  usertools/telemetry-watcher: add total and one-line opts
  usertools/telemetry-watcher: add thousands separator
  usertools/telemetry-watcher: add eth name shortcuts
  usertools/telemetry-watcher: support reconnection

 usertools/dpdk-telemetry-watcher.py | 429 ++++++++++++++++++++++++++++
 usertools/meson.build               |   1 +
 2 files changed, 430 insertions(+)
 create mode 100755 usertools/dpdk-telemetry-watcher.py

--
2.51.0

