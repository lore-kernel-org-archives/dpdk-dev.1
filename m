Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DD4CD342F
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 10:08:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE2B24060B;
	Tue,  5 May 2026 12:08:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id B5BB140272
 for <dev@dpdk.org>; Tue,  5 May 2026 12:08:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777975729; x=1809511729;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=r+iQYFwCzopCjSR2QplJKXhSYDb+zoLRKHCvNIY9zis=;
 b=Uh1JOqKTdUSw9iL9kLUZVfymb+modBt2Y5uZjvs+YlIWYKV7WaBiFaCt
 UmQBRRJe6UNTMhx1T0UWHqRAEYXO6P53DfUdN8QbJla4x/lgPxWyvTb+Y
 aOoebvSzejZeJLoix0AISfKi3Mc5uoj81Fj71coo+OEAiRXQnCFG99/bk
 lKR8+xG1GWcPxr0dNDlF8Zk1uuGNAZv5nIJEOKHBjHsQcKm5SryNO6zQP
 4DmSGQsqBJU3gBYW0b8XWF+8Y1j0Y8iX0q2Vnf+Aey6jL+CKaAFLkOegr
 eccu1+iv9gDdVkzu0VGUlIcXb4bwpxEj0wvSWQz8BliKD/4aB3ClXLbAt A==;
X-CSE-ConnectionGUID: zPLNVaxlRdGC3Pb3CU2MLw==
X-CSE-MsgGUID: B/ll07eBQcSpevTmjd5l3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="89945935"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="89945935"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 03:08:48 -0700
X-CSE-ConnectionGUID: zK0iy7K9TWCKrOZjF+fbOA==
X-CSE-MsgGUID: YiliRd14SZmbNPkZ1mpFGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="239767013"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.128])
 by orviesa003.jf.intel.com with ESMTP; 05 May 2026 03:08:47 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v5 0/7] Add script for real-time telemetry monitoring
Date: Tue,  5 May 2026 11:08:26 +0100
Message-ID: <20260505100833.2885047-1-bruce.richardson@intel.com>
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
equivalent values for each port, e.g. "eth.imissed" will track the
imissed value on all ports in use in the app. The ipackets and opackets
values, as common metrics, are also available as shortened values as
just "rx" and "tx", so in the example above, "eth.tx" means to track the
opackets stat for every ethdev port.

Finally, the script also has reconnection support so you can leave it
running while you start and stop your application in another terminal.
The watcher will try and reconnect to a running instance every second.

v5:
- fix AI flagged issues in connection handling in patch 7
- rebased onto latest tree (switch release note being updated)

v4:
- Updated docs following AI review
- Converted one missed f-string to regular string

v3:
Updated following AI review
- removed unnecessary f-string
- added documnentation in guides/tools
- added release note entry

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

 doc/guides/rel_notes/release_26_07.rst |   7 +
 doc/guides/tools/index.rst             |   1 +
 doc/guides/tools/telemetrywatcher.rst  | 184 +++++++++
 usertools/dpdk-telemetry-watcher.py    | 497 +++++++++++++++++++++++++
 usertools/meson.build                  |   1 +
 5 files changed, 690 insertions(+)
 create mode 100644 doc/guides/tools/telemetrywatcher.rst
 create mode 100755 usertools/dpdk-telemetry-watcher.py

--
2.51.0

