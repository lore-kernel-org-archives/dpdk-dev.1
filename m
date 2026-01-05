Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B448EC79FB0
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Jan 2026 17:56:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8997E4026F;
	Mon,  5 Jan 2026 18:56:16 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 9935F40267
 for <dev@dpdk.org>; Mon,  5 Jan 2026 18:56:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767635775; x=1799171775;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=P/62widRiQPl3MKkBAkpE5LpThDubasLaOKCi93+p7w=;
 b=GooB+MAN3hdBeJQcHsHS55SbgSRnfP4+9XkxapV/NB44nMyq6toUCSV1
 DXR8U8iG3Gx6TS49PY7er1+Fpe6a9v247x4Q++8JYF2RL4rpNGFwqqvMV
 iLmhEPVaj6+9pX1BsnbsZjJe8qVj2/k1DpWZ6Bj3Jo0LLyGwkSpr30sD2
 w+8llLdfQyAjQaFirR9rDGhZdS48SyudqhoOF4HZleIj0mX0SK8+HDw1H
 l3f8R+UrMVwpilPQ93EPpP9D0xuq3OCCwbysjLoo/RClx8EGL9AcRdOju
 CPl6ckTFH9qYc8ypeFZEuNu8NVHpogjd0i6r/ZixAun7LrRG5LZn+hmGN Q==;
X-CSE-ConnectionGUID: K0R4RNxdQFGwHiZFcS4F2A==
X-CSE-MsgGUID: dKqDDBD+Q9Wb+doglEHOFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="79308851"
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; d="scan'208";a="79308851"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2026 09:56:14 -0800
X-CSE-ConnectionGUID: OmKOrwZlS3KYVBZNLswNgQ==
X-CSE-MsgGUID: focCVhw+RbeEPP4DWtxu8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; d="scan'208";a="239928706"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 05 Jan 2026 09:56:13 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 0/7] Add script for real-time telemetry monitoring
Date: Mon,  5 Jan 2026 17:55:58 +0000
Message-ID: <20260105175605.52689-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251210165532.103450-1-bruce.richardson@intel.com>
References: <20251210165532.103450-1-bruce.richardson@intel.com>
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

For a  quick demo, apply patches, run e.g. testpmd and then in a separate
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

v2:
- improve reconnection handling, eliminating some crashes seen in testing.

Bruce Richardson (7):
  usertools: add new script to monitor telemetry on terminal
  usertools/telemetry-watcher: add displaying stats
  usertools/telemetry-watcher: add delta and timeout opts
  usertools/telemetry-watcher: add total and one-line opts
  usertools/telemetry-watcher: add thousands separator
  usertools/telemetry-watcher: add eth name shortcuts
  usertools/telemetry-watcher: support reconnection

 usertools/dpdk-telemetry-watcher.py | 435 ++++++++++++++++++++++++++++
 usertools/meson.build               |   1 +
 2 files changed, 436 insertions(+)
 create mode 100755 usertools/dpdk-telemetry-watcher.py

--
2.51.0

