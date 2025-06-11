Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3759EC677C4
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 14:05:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 08835402EA;
	Wed, 11 Jun 2025 16:05:35 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by mails.dpdk.org (Postfix) with ESMTP id B74E6402DB
 for <dev@dpdk.org>; Wed, 11 Jun 2025 16:05:33 +0200 (CEST)
Received: from DESKTOP-P620.suse.de (unknown [IPv6:2a07:de40:b2bf:1b::106b])
 by smtp-out1.suse.de (Postfix) with ESMTP id 00FA7219CD;
 Wed, 11 Jun 2025 14:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1749650733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6ERzSUa9X3rbEqrrQHKlUF7HbMuSbxkjTkfs53NBP4Q=;
 b=jL64sxSt0udlHCf+nuhq7u7K++Pw2cdz9tSl9feoWBuTvEQe8EkTLrM+XmeiSrreekl7em
 o+C3Pl/NMu7eaXJK19S+C66gP3sBLwDlkTdpsVjBqEh8S6BUjxJcl90NOMFL/wICgkbB3K
 pwQdwHijI6BbNXhd/unMXWZWz/eRy/8=
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.com header.s=susede1 header.b=jL64sxSt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1749650733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6ERzSUa9X3rbEqrrQHKlUF7HbMuSbxkjTkfs53NBP4Q=;
 b=jL64sxSt0udlHCf+nuhq7u7K++Pw2cdz9tSl9feoWBuTvEQe8EkTLrM+XmeiSrreekl7em
 o+C3Pl/NMu7eaXJK19S+C66gP3sBLwDlkTdpsVjBqEh8S6BUjxJcl90NOMFL/wICgkbB3K
 pwQdwHijI6BbNXhd/unMXWZWz/eRy/8=
From: Clemens Famulla-Conrad <cfamullaconrad@suse.com>
To: paul.szczepanek@arm.com
Cc: nd@arm.com, dev@dpdk.org, Clemens Famulla-Conrad <cfamullaconrad@suse.com>
Subject: [PATCH v2] dts: fix deterministic doc
Date: Wed, 11 Jun 2025 16:05:30 +0200
Message-ID: <20250611140530.51551-1-cfamullaconrad@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <804d43cf-ff73-421b-a3a8-4b3dd3c3add5@arm.com>
References: <804d43cf-ff73-421b-a3a8-4b3dd3c3add5@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [19.55 / 50.00]; SPAM_FLAG(5.00)[];
 NEURAL_SPAM_LONG(3.50)[1.000]; NEURAL_SPAM_SHORT(2.86)[0.952];
 HFILTER_HOSTNAME_UNKNOWN(2.50)[]; RDNS_NONE(2.00)[];
 ONCE_RECEIVED(1.20)[]; MID_CONTAINS_FROM(1.00)[];
 HFILTER_HELO_IP_A(1.00)[desktop-p620.suse.de];
 R_MISSING_CHARSET(0.50)[];
 HFILTER_HELO_NORES_A_OR_MX(0.30)[desktop-p620.suse.de];
 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 BAYES_SPAM(0.00)[16.83%]; RCVD_COUNT_ZERO(0.00)[0];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 DIRECT_TO_MX(0.00)[git-send-email 2.43.0];
 GREYLIST(0.00)[pass,body]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,intel.com:email];
 DKIM_SIGNED(0.00)[suse.com:s=susede1];
 RCPT_COUNT_THREE(0.00)[4]; DKIM_TRACE(0.00)[suse.com:+]
X-Spamd-Bar: +++++++++++++++++++
X-Rspamd-Queue-Id: 00FA7219CD
X-Rspamd-Action: add header
X-Spam: Yes
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

Previously, `capture_name` defaulted to a "dynamic" value.
This caused non-deterministic documentation and could lead
to overwriting capture files if the method was called
multiple times within a single Python process.

Bugzilla ID: 1718

Signed-off-by: Clemens Famulla-Conrad <cfamullaconrad@suse.com>
---
 .mailmap                                                     | 1 +
 .../traffic_generator/capturing_traffic_generator.py         | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 76f65e5114..cd5362f130 100644
--- a/.mailmap
+++ b/.mailmap
@@ -272,6 +272,7 @@ Cian Ferriter <cian.ferriter@intel.com>
 Ciara Loftus <ciara.loftus@intel.com>
 Ciara Power <ciara.power@intel.com>
 Claire Murphy <claire.k.murphy@intel.com>
+Clemens Famulla-Conrad <cfamullaconrad@suse.com>
 Cody Doucette <doucette@bu.edu>
 Congwen Zhang <zhang.congwen@zte.com.cn>
 Conor Fogarty <conor.fogarty@intel.com>
diff --git a/dts/framework/testbed_model/traffic_generator/capturing_traffic_generator.py b/dts/framework/testbed_model/traffic_generator/capturing_traffic_generator.py
index 66a77da9c4..f485043f73 100644
--- a/dts/framework/testbed_model/traffic_generator/capturing_traffic_generator.py
+++ b/dts/framework/testbed_model/traffic_generator/capturing_traffic_generator.py
@@ -70,7 +70,7 @@ def send_packets_and_capture(
         receive_port: Port,
         filter_config: PacketFilteringConfig,
         duration: float,
-        capture_name: str = _get_default_capture_name(),
+        capture_name: str = "",
     ) -> list[Packet]:
         """Send `packets` and capture received traffic.
 
@@ -104,6 +104,9 @@ def send_packets_and_capture(
             duration,
         )
 
+        if not capture_name:
+            capture_name = _get_default_capture_name()
+
         self._logger.debug(f"Received packets: {get_packet_summaries(received_packets)}")
         self._write_capture_from_packets(capture_name, received_packets)
         return received_packets
-- 
2.43.0

